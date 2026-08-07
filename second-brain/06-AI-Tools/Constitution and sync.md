# Constitution and sync

## Principle
The **constitution is AI-tool agnostic**. Master copy: `AI-Tools/rules/00-constitution.md`.

## Sync loop
1. Edit constitution or tooling under `~/dev/AI-Tools`.
2. Mirror global rules to local agent config when needed (`scripts/sync-rules-to-local.sh` → `~/.grok/rules/`).
3. Capture durable decisions and lessons as notes here under `06-AI-Tools/` or Resources.
4. **Commit and push** so GitHub, agents, and Obsidian stay aligned.

## Related
- [[AI-Tools map]]
- Vault README: `second-brain/README.md` (repo root relative)
