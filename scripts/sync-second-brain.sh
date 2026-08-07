#!/usr/bin/env bash
# Sync only second-brain/ with GitHub so notes stay shared across machines.
#
# Default mode (sync):
#   1. pull --rebase origin/<default-branch>
#   2. if second-brain has local changes → commit (second-brain only)
#   3. push to origin
#   4. if push still conflicts → branch + PR (+ auto-merge when possible)
#
# Usage:
#   ./scripts/sync-second-brain.sh           # full sync
#   ./scripts/sync-second-brain.sh pull      # fetch+rebase only
#   ./scripts/sync-second-brain.sh push      # commit+push only (still pulls first)
#   ./scripts/sync-second-brain.sh status    # show dirty second-brain state
#   ./scripts/sync-second-brain.sh --help
#
# Env:
#   AI_TOOLS_ROOT     Override repo root (default: parent of scripts/)
#   SB_SYNC_DRY_RUN=1 Print actions without committing/pushing
#   SB_SYNC_PR=1      Prefer branch+PR even when main push would work
#   SB_SYNC_LOG       Log file path
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="${AI_TOOLS_ROOT:-$ROOT}"
SB_DIR="second-brain"
REMOTE="${SB_SYNC_REMOTE:-origin}"
LOCK_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ai-tools"
LOCK_FILE="$LOCK_DIR/second-brain-sync.lock"
LOG_FILE="${SB_SYNC_LOG:-$HOME/.local/log/ai-tools-second-brain-sync.log}"
DRY_RUN="${SB_SYNC_DRY_RUN:-0}"
FORCE_PR="${SB_SYNC_PR:-0}"
MODE="${1:-sync}"

mkdir -p "$(dirname "$LOG_FILE")" "$LOCK_DIR"

log() {
  local line="[$(date '+%Y-%m-%d %H:%M:%S')] $*"
  echo "$line" | tee -a "$LOG_FILE" >&2
}

die() {
  log "ERROR: $*"
  exit 1
}

usage() {
  sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'
}

acquire_lock() {
  if command -v shlock >/dev/null 2>&1; then
    shlock -f "$LOCK_FILE" -p $$ || {
      log "Another sync is running (lock $LOCK_FILE); exiting."
      exit 0
    }
    trap 'rm -f "$LOCK_FILE"' EXIT
    return
  fi
  if [[ -f "$LOCK_FILE" ]]; then
    local old
    old="$(cat "$LOCK_FILE" 2>/dev/null || true)"
    if [[ -n "${old:-}" ]] && kill -0 "$old" 2>/dev/null; then
      log "Another sync is running (pid $old); exiting."
      exit 0
    fi
  fi
  echo $$ >"$LOCK_FILE"
  trap 'rm -f "$LOCK_FILE"' EXIT
}

require_repo() {
  [[ -d "$ROOT/.git" ]] || die "Not a git repo: $ROOT"
  [[ -d "$ROOT/$SB_DIR" ]] || die "Missing $ROOT/$SB_DIR"
  cd "$ROOT"
}

default_branch() {
  local b
  b="$(git symbolic-ref --quiet --short "refs/remotes/$REMOTE/HEAD" 2>/dev/null | sed "s#^$REMOTE/##" || true)"
  if [[ -z "$b" ]]; then
    b="$(git remote show "$REMOTE" 2>/dev/null | awk '/HEAD branch/ {print $NF}' || true)"
  fi
  echo "${b:-main}"
}

assert_clean_git_state() {
  if [[ -d .git/rebase-merge || -d .git/rebase-apply ]]; then
    die "Rebase in progress — resolve before second-brain sync"
  fi
  if [[ -f .git/MERGE_HEAD ]]; then
    die "Merge in progress — resolve before second-brain sync"
  fi
}

# Reject paths that look like secrets under second-brain
secret_scan() {
  local bad=0
  local path
  while IFS= read -r path; do
    [[ -z "$path" ]] && continue
    case "$path" in
      *.pem|*.key|*.p12|*.pfx|*/.env|*/.env.*|*.env|*.env.*)
        log "Refusing to commit secret-like path: $path"
        bad=1
        ;;
      *id_rsa*|*id_ed25519*|*credentials.json*|*service-account*.json)
        log "Refusing to commit credential-like path: $path"
        bad=1
        ;;
    esac
  done < <(git status --porcelain --untracked-files=all -- "$SB_DIR" | sed 's/^...//')
  [[ "$bad" -eq 0 ]] || die "Secret-like files under $SB_DIR; not committing. Move secrets out or update .gitignore."
}

second_brain_dirty() {
  # true if any change under second-brain (incl untracked)
  [[ -n "$(git status --porcelain --untracked-files=all -- "$SB_DIR")" ]]
}

pull_rebase() {
  local branch
  branch="$(default_branch)"
  log "Pull --rebase $REMOTE/$branch"
  if [[ "$DRY_RUN" == "1" ]]; then
    return 0
  fi
  git fetch "$REMOTE" --quiet
  # Only rebase if we are on the default branch; otherwise still fetch for awareness
  local cur
  cur="$(git branch --show-current)"
  if [[ "$cur" == "$branch" ]]; then
    if ! git pull --rebase --autostash "$REMOTE" "$branch"; then
      die "pull --rebase failed; resolve conflicts in $ROOT then re-run"
    fi
  else
    log "On branch '$cur' (not $branch); fetched only. Commit/push will target current branch."
  fi
}

commit_second_brain() {
  if ! second_brain_dirty; then
    log "No local second-brain changes to commit"
    return 0
  fi
  secret_scan

  local summary count
  count="$(git status --porcelain --untracked-files=all -- "$SB_DIR" | wc -l | tr -d ' ')"
  summary="$(git status --porcelain --untracked-files=all -- "$SB_DIR" \
    | sed 's/^...//' \
    | head -8 \
    | tr '\n' ',' \
    | sed 's/,$//')"
  if [[ "$count" -gt 8 ]]; then
    summary="$summary, … (+$((count - 8)) more)"
  fi

  local paths msg
  paths="$(git status --porcelain --untracked-files=all -- "$SB_DIR" | sed 's/^...//' | head -20 | sed 's/^/- /')"
  msg="$(cat <<EOF
sync(second-brain): auto-sync notes ($count change(s))

$paths

Automated by scripts/sync-second-brain.sh so the Obsidian vault stays shared across machines.
EOF
)"

  log "Staging $SB_DIR only ($count paths). Sample: $summary"
  if [[ "$DRY_RUN" == "1" ]]; then
    log "DRY_RUN: would commit"
    return 0
  fi

  git add -- "$SB_DIR"
  # Nothing staged? (e.g. only ignored workspace.json)
  if git diff --cached --quiet; then
    log "Nothing staged under $SB_DIR after git add (likely ignored files only)"
    return 0
  fi
  git commit -m "$msg"
  log "Committed second-brain changes"
}

push_main_or_pr() {
  local branch cur
  branch="$(default_branch)"
  cur="$(git branch --show-current)"

  if [[ "$DRY_RUN" == "1" ]]; then
    log "DRY_RUN: would push"
    return 0
  fi

  # Nothing to push?
  if git rev-parse "@{u}" >/dev/null 2>&1; then
    if [[ -z "$(git log --oneline "@{u}..HEAD" 2>/dev/null)" ]]; then
      log "No commits to push"
      return 0
    fi
  fi

  if [[ "$FORCE_PR" == "1" ]]; then
    open_pr_and_merge
    return
  fi

  if [[ "$cur" != "$branch" ]]; then
    log "Not on $branch (on $cur); pushing current branch and opening PR if needed"
    git push -u "$REMOTE" "HEAD" || die "push failed"
    if command -v gh >/dev/null 2>&1; then
      if ! gh pr view --json url -q .url >/dev/null 2>&1; then
        gh pr create --title "sync(second-brain): multi-device notes" --body "Auto-sync second-brain from $(hostname -s) via scripts/sync-second-brain.sh" || true
      fi
      gh pr merge --merge --auto 2>/dev/null \
        || gh pr merge --merge 2>/dev/null \
        || log "PR created but not merged — merge manually if required"
    fi
    return
  fi

  if git push "$REMOTE" "HEAD:$branch"; then
    log "Pushed to $REMOTE/$branch"
    return 0
  fi

  log "Push rejected; re-pulling and retrying once"
  git pull --rebase --autostash "$REMOTE" "$branch" || die "rebase after rejected push failed"
  if git push "$REMOTE" "HEAD:$branch"; then
    log "Pushed to $REMOTE/$branch after rebase"
    return 0
  fi

  log "Direct push still failing; opening PR fallback"
  open_pr_and_merge
}

open_pr_and_merge() {
  command -v gh >/dev/null 2>&1 || die "gh not available for PR fallback; push main manually"
  local branch stamp pr_branch
  branch="$(default_branch)"
  stamp="$(date +%Y%m%d-%H%M%S)"
  pr_branch="second-brain-sync/${stamp}-$(hostname -s | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9-' | cut -c1-24)"

  log "Creating branch $pr_branch and PR into $branch"
  git checkout -B "$pr_branch"
  git push -u "$REMOTE" "$pr_branch"
  local url
  url="$(gh pr create \
    --base "$branch" \
    --head "$pr_branch" \
    --title "sync(second-brain): auto-sync $(date +%Y-%m-%d)" \
    --body "$(cat <<EOF
## Summary
Automated second-brain sync from **$(hostname -s)** via \`scripts/sync-second-brain.sh\`.

## Why PR
Direct push to \`$branch\` failed or \`SB_SYNC_PR=1\` was set. Prefer merge so all machines stay aligned.

## Test plan
- [x] Only \`second-brain/\` paths included
- [ ] Spot-check notes on another machine after merge (\`git pull\`)
EOF
)" 2>/dev/null || true)"

  if [[ -z "${url:-}" ]]; then
    url="$(gh pr view --json url -q .url 2>/dev/null || true)"
  fi
  log "PR: ${url:-created}"

  if gh pr merge --merge --auto 2>/dev/null || gh pr merge --merge 2>/dev/null; then
    log "PR merged"
    git checkout "$branch"
    git pull --rebase --autostash "$REMOTE" "$branch" || true
  else
    log "Could not auto-merge PR — merge in GitHub UI, then pull on other machines"
  fi
}

show_status() {
  require_repo
  local branch
  branch="$(default_branch)"
  echo "Repo: $ROOT"
  echo "Branch: $(git branch --show-current) (default: $branch)"
  echo "Remote: $REMOTE"
  echo "Log: $LOG_FILE"
  echo "--- second-brain status ---"
  git status --short --untracked-files=all -- "$SB_DIR" || true
  if git rev-parse "@{u}" >/dev/null 2>&1; then
    echo "--- ahead/behind ---"
    git rev-list --left-right --count "@{u}...HEAD" 2>/dev/null | awk '{print "behind "$1", ahead "$2}'
  fi
}

main() {
  case "$MODE" in
    -h|--help|help) usage; exit 0 ;;
    status) show_status; exit 0 ;;
    pull|push|sync) ;;
    *) die "Unknown mode: $MODE (use sync|pull|push|status)" ;;
  esac

  require_repo
  acquire_lock
  assert_clean_git_state
  log "=== second-brain sync start (mode=$MODE) ==="

  case "$MODE" in
    pull)
      pull_rebase
      ;;
    push)
      pull_rebase
      commit_second_brain
      push_main_or_pr
      ;;
    sync)
      pull_rebase
      commit_second_brain
      push_main_or_pr
      ;;
  esac

  log "=== second-brain sync done ==="
}

main
