# Second brain auto-sync (multi-machine)

## Intent
Keep **`second-brain/`** on GitHub current whenever notes change so every machine/user clone of AI-Tools stays aligned. Do **not** wait for the user to ask “commit and push” for second-brain-only work.

## Canonical tooling
| Item | Path |
|------|------|
| Sync script | `~/dev/AI-Tools/scripts/sync-second-brain.sh` |
| Install timer (macOS) | `~/dev/AI-Tools/scripts/install-second-brain-autosync.sh` |
| Docs | `docs/sync.md`, `docs/obsidian-second-brain.md` |

## Agent duty (mandatory)
After **creating, editing, moving, or deleting** any file under `second-brain/` in AI-Tools:

1. Run immediately (do not only “offer”):

```bash
~/dev/AI-Tools/scripts/sync-second-brain.sh sync
```

2. Report the script’s outcome briefly (committed / nothing to do / PR opened / error).  
3. If the script fails, show the error and help fix (auth, conflict)—do not leave notes only on one machine.

If the same commit also includes non–second-brain vault files (`rules/`, `skills/`, …), you may use a normal full-repo commit **and still push**; otherwise prefer the second-brain script so only notes are staged.

## Scope of the script
- Stages **only** `second-brain/`  
- `git pull --rebase` then commit (if dirty) then push to `main`  
- On push conflict: branch + `gh` PR + attempt auto-merge  
- Refuses secret-like paths (`.env`, keys, etc.)  
- Never force-pushes  

## Background timer
macOS launchd (every ~3 minutes) covers **Obsidian UI** edits when no agent is running:

```bash
~/dev/AI-Tools/scripts/install-second-brain-autosync.sh install
~/dev/AI-Tools/scripts/install-second-brain-autosync.sh status
```

Other machines: clone/pull AI-Tools, then run the same `install` once.

## Never
- Force-push `main`  
- Commit secrets into second-brain  
- Skip sync “to avoid bothering the user” after second-brain edits—the user opted into auto-sync  
