# Second brain auto-sync

**Goal:** Notes under `second-brain/` stay on GitHub so every clone/machine shares the same vault.

## What runs

| Mechanism | When |
|-----------|------|
| `scripts/sync-second-brain.sh` | Manually, or right after an agent edits notes |
| launchd (`install-second-brain-autosync.sh`) | About every 3 minutes + on login |
| Agent rule `rules/40-second-brain-auto-sync.md` | Agents must sync after second-brain writes |

## Commands

```bash
cd ~/dev/AI-Tools
./scripts/sync-second-brain.sh status
./scripts/sync-second-brain.sh sync
./scripts/install-second-brain-autosync.sh install   # once per Mac
./scripts/install-second-brain-autosync.sh status
```

## Behavior

1. Pull with rebase from `origin/main`  
2. If `second-brain/` is dirty → commit **only** those paths  
3. Push to `main`  
4. If push fails → branch + GitHub PR + try auto-merge  

Secrets under the vault are refused (`.env`, keys, etc.). Never force-pushes.

## Logs

- `~/.local/log/ai-tools-second-brain-sync.log`  
- launchd: `~/.local/log/ai-tools-second-brain-sync.launchd.*.log`  

## Related

- `docs/sync.md`  
- `docs/obsidian-second-brain.md`  
