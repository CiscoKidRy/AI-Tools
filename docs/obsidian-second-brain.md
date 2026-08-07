# Obsidian second brain — configuration notes

Configured for **CiscoKidRy/AI-Tools** using current common practice (BASB CODE+PARA, atomic linking, minimal plugins, git-backed vault).

## Design choices

| Choice | Why |
|--------|-----|
| Vault = `second-brain/` subfolder | Keeps agent `rules/` out of the note graph; open only the vault root in Obsidian |
| PARA folders + links | Actionability for filing; links for thinking |
| CODE documented in-vault | Capture without organizing; process on a cadence |
| YAML properties on templates | Light structure for future Dataview/Bases without requiring plugins |
| Core plugins only by default | Avoid plugin debt; optional list in `Recommended plugins.md` |
| Git as sync | Free, already used for AI-Tools; no paid Obsidian Sync required |

## Where config lives

- App settings: `second-brain/.obsidian/*`  
- Human guide: `second-brain/06-AI-Tools/How this second brain works.md`  

## After clone on a new machine

1. Install Obsidian.  
2. Open `…/AI-Tools/second-brain` as vault.  
3. Trust the folder if macOS prompts.  
4. Install auto-sync so notes push/pull with GitHub:

```bash
cd ~/dev/AI-Tools
./scripts/install-second-brain-autosync.sh install
```

5. Optional: enable community plugins later from the recommended list.

## Multi-machine sync

Git is the sync plane (no paid Obsidian Sync required).  
`scripts/sync-second-brain.sh` commits **only** `second-brain/`, pushes to `main`, and opens a PR+auto-merge if a direct push is rejected.  
Background: macOS launchd every ~3 minutes (covers Obsidian UI edits).  
Agents: run the same script immediately after note edits (`rules/40-second-brain-auto-sync.md`).
