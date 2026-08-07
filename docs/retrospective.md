# Retrospective (AI-tool-agnostic)

## Purpose

**Retrospective** is a portable skill that turns a coding-agent session into:

1. A clear lessons summary  
2. **Approved** durable artifacts in the AI-Tools vault  

It is deliberately **not** Claude-only or Grok-only. Same process, same outputs, any host.

## Design evaluation (from community research)

| Community pattern | Keep? | How we adapt |
|-------------------|-------|--------------|
| agent-retro friction → concrete proposals | Yes | Proposals table + drafts |
| claude-reflect two-stage approve | Yes | Never auto-write always-on rules |
| Sionic skill PR to registry | Yes | AI-Tools git is the registry |
| Learnings.md staging | Yes | `docs/retros/` |
| JSONL-only Claude scripts | No as requirement | Optional host adapter only |
| Vendor `~/.claude/skills` as sole home | No | AI-Tools `skills/` is source of truth |

## Artifact map

| Proposal type | AI-Tools path |
|---------------|---------------|
| skill | `skills/<Name>/SKILL.md` |
| rule | `rules/<nn>-<slug>.md` |
| workflow | `workflows/` |
| agent brief | `prompts/agents/` |
| staging | `docs/retros/YYYY-MM-DD-*.md` |
| project how-to | `AGENTS.md` / `templates/AGENTS.md` |

## Invocation

Natural language on any agent:

- “Run **Retrospective**”  
- “Session retro — propose skills and rules”  
- “Capture learnings into AI-Tools”

Or load skill: `skills/Retrospective/SKILL.md`.

## Security

Do not put secrets, key inventories, or token values into retros or promoted skills. Private pointers stay in local memory (`~/.grok/memory/`) when needed.

## Related

- Skill: `skills/Retrospective/SKILL.md`  
- Constitution: `rules/00-constitution.md` (tool-agnostic mission)  
