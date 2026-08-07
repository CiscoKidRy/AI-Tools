# AI-Tools

Canonical vault for CLI AI agent tooling used with [Grok](https://x.ai), Claude Code, Codex, and similar agents.

**Owner:** [CiscoKidRy](https://github.com/CiscoKidRy)  
**Remote:** https://github.com/CiscoKidRy/AI-Tools

## What’s in here

| Path | Purpose |
|------|---------|
| `rules/` | Always-on agent rules (constitution, tool policy, repo pointers) |
| `skills/` | On-demand procedures (`SKILL.md` playbooks) |
| `workflows/` | Multi-agent orchestration scripts |
| `prompts/` | Reusable prompt fragments |
| `templates/` | Starter `AGENTS.md`, project scaffolds |
| `docs/` | Design notes and counsel decisions |

## Layering (how to use these)

1. **Global rules** (`~/.grok/rules/`) — short constitution; copy or symlink from `rules/`
2. **Project `AGENTS.md`** — repo-specific commands and invariants (see `templates/AGENTS.md`)
3. **Skills** — multi-step procedures that should not bloat always-on context
4. **CI / hooks** — anything binary (format, secret scan, tests)

## Quick start

```bash
git clone https://github.com/CiscoKidRy/AI-Tools.git ~/dev/AI-Tools
# Optional: sync global Grok rules from this vault
cp ~/dev/AI-Tools/rules/*.md ~/.grok/rules/
```

## Principles

- Keep the constitution short; earn rules from repeated failures.
- Prefer free best-in-class tools; install before falling back.
- Local reversible work: act. Irreversible / shared / prod: confirm first.
- Never commit secrets. Done means verified against real project checks.
