# Keeping AI-Tools in sync

## Goal
One GitHub repo holds the **tool-agnostic constitution**, the rest of the agent toolkit, and the **Obsidian second brain**. Local AI products are mirrors, not sole owners.

## Layout
```
~/dev/AI-Tools/                 # git clone of CiscoKidRy/AI-Tools
  rules/                        # constitution + global policies
  skills/ workflows/ prompts/
  templates/
  second-brain/                 # Obsidian vault root
  scripts/sync-*.sh
```

## Common flows

### After editing the vault (preferred)
```bash
cd ~/dev/AI-Tools
# edit rules/, second-brain/, skills/, …
./scripts/sync-rules-to-local.sh   # push constitution into ~/.grok/rules
git add -A
git commit -m "Describe the change"
git push
```

### After editing only ~/.grok/rules
```bash
cd ~/dev/AI-Tools
./scripts/sync-from-local-rules.sh
git add rules && git commit -m "Promote local rules to vault" && git push
```

### Obsidian / second-brain auto-sync
Open folder `~/dev/AI-Tools/second-brain` as the vault.

**Second-brain stays on GitHub automatically** so all your machines share notes:

```bash
# One-time per Mac (launchd every ~3 minutes + run on load)
./scripts/install-second-brain-autosync.sh install
./scripts/install-second-brain-autosync.sh status

# Manual / agent-triggered full cycle (pull → commit second-brain only → push / PR)
./scripts/sync-second-brain.sh sync
./scripts/sync-second-brain.sh status
```

| Mode | Behavior |
|------|----------|
| `sync` (default) | `pull --rebase`, commit dirty `second-brain/`, push `main`; PR+merge fallback if push fails |
| `pull` | Fetch + rebase only (use on a machine that only reads notes) |
| `push` | Same as sync (still pulls first) |
| `status` | Show dirty files under `second-brain/` |

Agents follow `rules/40-second-brain-auto-sync.md`: after any second-brain edit they run the sync script immediately.

Logs: `~/.local/log/ai-tools-second-brain-sync.log`

Env knobs: `SB_SYNC_DRY_RUN=1`, `SB_SYNC_PR=1` (always open PR), `SB_SYNC_INTERVAL_SEC` (install timer).

### Other machines
```bash
cd ~/dev/AI-Tools && git pull
./scripts/install-second-brain-autosync.sh install
```

## Conflict rule
If local agent config and AI-Tools diverge: **prefer AI-Tools** unless the user explicitly chose local-first for that change.

If second-brain sync hits a merge conflict: fix files under `second-brain/`, then re-run `./scripts/sync-second-brain.sh sync`.
