---
name: ship-to-github
description: >
  Commit, push, and optionally open and merge a GitHub pull request using git and gh.
  Use when the user wants to ship work, open a PR, merge a PR, or says commit and push,
  create pull request, or ship-to-github.
---

# Ship to GitHub

**AI-tool-agnostic.** Works with any agent host that can run shell commands. Prefer `git` + GitHub CLI (`gh`).

## Prerequisites

- Repo has a remote (usually `origin`) and the user can push.
- `git` available; `gh` preferred for PRs (install if free and missing).
- Authenticated: `gh auth status` (or git credential helper). Do not invent tokens.

## Defaults

| Item | Preference |
|------|------------|
| Default branch | `main` (or repo default) |
| Commit style | Complete sentences; explain **why**, not only what |
| PR | Create from a feature branch unless user asked to commit on `main` |
| Merge | Only when user asks to merge; prefer merge commit or repo default |
| Force-push | **Never** to `main`/`master` without explicit confirmation |

## Steps

### A. Commit local changes

1. `git status` and `git diff` (and `git diff --staged` if needed).  
2. `git log -5 --oneline` to match commit message style.  
3. Stage relevant files (`git add …`). Do **not** stage secrets (`.env`, `rclone.conf`, `*.pem`, key files).  
4. Commit with a heredoc message (multi-sentence OK):

```bash
git commit -m "$(cat <<'EOF'
Short summary line.

Optional body: why this change matters.
EOF
)"
```

5. If nothing to commit, say so and stop (or continue to push/PR if commits already exist).

### B. Push

1. Current branch: `git branch --show-current`.  
2. If on `main` and user asked for a PR: create/switch to a descriptive branch first, then push.  
3. `git push -u origin HEAD` (or push current branch).  
4. Fix auth failures by guiding `gh auth login` / credential setup—never paste PATs into chat.

### C. Pull request (when requested)

1. Ensure `gh` works: `gh auth status`.  
2. Create PR:

```bash
gh pr create --title "…" --body "$(cat <<'EOF'
## Summary
- …

## Test plan
- [ ] …
EOF
)"
```

3. Return the PR URL.

### D. Merge (only if requested)

```bash
gh pr merge --merge --delete-branch
# or --squash if the user prefers
```

Then `git checkout main && git pull`.

## Verification

- `git status` clean (or only expected untracked files).  
- Remote has the commit: `git log origin/<branch> -1`.  
- PR merged state if applicable: `gh pr view`.

## Never

- Force-push shared default branches without explicit user confirmation.  
- Commit secrets, credentials, or large binary dumps the user did not ask for.  
- Amend commits that were already pushed unless the user explicitly allows it.  
- Skip hooks (`--no-verify`) unless the user explicitly requests it.  
- Put tokens or `gh` auth codes into chat logs.

## Related

- AI-Tools vault: commit durable agent config there first, then ship.  
- Dropbox/secrets: never ship the secrets vault into a public repo.
