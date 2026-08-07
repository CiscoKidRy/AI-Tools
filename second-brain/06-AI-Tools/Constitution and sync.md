---
type: hub
tags:
  - ai-tools
  - sync
---

# Constitution and sync

## Principle
The **constitution is AI-tool agnostic**. Master copy lives in the monorepo:

`AI-Tools/rules/00-constitution.md`

## Sync loop
1. Edit constitution or tooling under `~/dev/AI-Tools`.  
2. Mirror global rules to local agent config: `./scripts/sync-rules-to-local.sh` → `~/.grok/rules/`.  
3. Capture durable decisions here under `06-AI-Tools/` or as Resources / Atomic ideas.  
4. **Commit and push** so GitHub, agents, and Obsidian stay aligned.

```bash
cd ~/dev/AI-Tools
./scripts/sync-rules-to-local.sh   # when rules changed
git add -A
git commit -m "Describe the change"
git push
```

## Related
- [[AI-Tools map]]  
- [[How this second brain works]]  
- [[02-Areas/AI tooling hygiene]]  
