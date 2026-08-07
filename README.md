# AI-Tools

Canonical, **AI-tool-agnostic** vault for agent constitution, skills, workflows, prompts—and an **Obsidian second brain**—used with Grok, Claude Code, Codex, Cursor, and future tools.

**Owner:** [CiscoKidRy](https://github.com/CiscoKidRy)  
**Remote:** https://github.com/CiscoKidRy/AI-Tools  
**Local:** `~/dev/AI-Tools`

## What’s in here

| Path | Purpose |
|------|---------|
| `rules/` | Tool-agnostic constitution + global policies (**source of truth**) |
| `skills/` | On-demand procedures (`SKILL.md` playbooks) |
| `workflows/` | Multi-agent orchestration scripts |
| `prompts/` | Reusable prompt fragments |
| `templates/` | Starter `AGENTS.md`, project scaffolds |
| `second-brain/` | **Obsidian vault** (second brain; open this folder in Obsidian) |
| `scripts/` | Sync helpers (`rules/` ↔ `~/.grok/rules/`) |
| `docs/` | Design notes, counsel decisions, sync guide |

## Mission

1. Keep one **shared constitution** that is not locked to a single AI product.
2. **Sync** local agent rule folders with `rules/` after meaningful changes.
3. Keep the **second brain** in-repo so knowledge and tools version together on GitHub.

See `docs/sync.md` and `rules/00-constitution.md` (Mission section).

## Layering

1. **Global rules** (`rules/` → e.g. `~/.grok/rules/`) — short constitution
2. **Project `AGENTS.md`** — repo-specific commands and invariants (`templates/AGENTS.md`)
3. **Skills** — multi-step procedures that should not bloat always-on context
4. **Second brain** — durable personal/project knowledge in Obsidian
5. **CI / hooks** — anything binary (format, secret scan, tests)

## Quick start

```bash
git clone https://github.com/CiscoKidRy/AI-Tools.git ~/dev/AI-Tools
cd ~/dev/AI-Tools
./scripts/sync-rules-to-local.sh          # → ~/.grok/rules
# Obsidian → Open folder as vault → ~/dev/AI-Tools/second-brain
```

## Principles

- Tool-agnostic first; vendor shims second.
- Keep the constitution short; earn rules from repeated failures.
- Prefer free best-in-class tools; install before falling back.
- Local reversible work: act. Irreversible / shared / prod: confirm first.
- Never commit secrets. Done means verified against real project checks.
- After vault-worthy work: update AI-Tools, sync locals, commit, push.
