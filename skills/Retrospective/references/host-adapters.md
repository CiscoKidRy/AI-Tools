# Host adapters (optional, non-blocking)

Retrospective **must work from conversation alone**. Host logs improve fidelity when present.

| Host | Session / history hints | Notes |
|------|-------------------------|--------|
| **Any** | Live chat context | Always primary |
| **Grok** | `~/.grok/sessions/<url-encoded-cwd>/<session-id>/` — `updates.jsonl`, `chat_history.jsonl`, `summary.json` | Optional supplement |
| **Claude Code** | `~/.claude/projects/<project>/*.jsonl` | Optional; do not require |
| **Codex** | User-provided path or product docs | Optional |
| **Cursor** | User-provided export / composer history if available | Optional |
| **Gemini CLI** | User-provided session path if available | Optional |

## Output always

Write durable artifacts to **`~/dev/AI-Tools`** first:

- `skills/`, `rules/`, `workflows/`, `prompts/`, `docs/retros/`, `AGENTS.md`

Optional mirrors (never source of truth alone):

- `~/.grok/rules/` via `scripts/sync-rules-to-local.sh`
- `~/.claude/` or `.cursor/rules` only as thin copies if the user asks

## Naming

Skill directory and skill `name`: **`Retrospective`** (user-facing brand).  
Invoke as “Retrospective” across tools; avoid vendor-prefixed names.
