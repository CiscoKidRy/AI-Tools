# Plan interview and grounding discipline

**Date:** 2026-08-07  
**Vault paths:** `skills/plan-interview/`, `skills/grounding-discipline/`

## What these are

| Skill | Role |
|-------|------|
| **plan-interview** | Structured requirements discovery with quality gates (SCOPE…SUCCESS) until 95%+ aggregate confidence or user ends |
| **grounding-discipline** | Cross-cutting: no silent assumptions, no hallucinations, no over/understatement; claim labels + Grounding Report |

Composition: **plan-interview always loads grounding-discipline first**, and presents Discovery Complete **plus** Grounding Report when the plan/discovery is shown.

## Origin

- `plan-interview` adapted from [CiscoKidRy/Anthropic](https://github.com/CiscoKidRy/Anthropic) `claude/skills/plan-interview` (identical on all branches; single version).  
- Claude-only bits removed (`EnterPlanMode` hard dependency, Claude tool allowlists).  
- Tracker lookup made **toolset-agnostic** (use whatever tracker the current host/project has).  
- `grounding-discipline` designed from multi-agent web research: NIST confabulation / OWASP LLM09, Anthropic/OpenAI/Google grounding guidance, claim ledgers, source inventory patterns. See `skills/grounding-discipline/references/sources.md`.

## How to invoke

```
/plan-interview <topic>
/grounding-discipline
python skills/plan-interview/template.py "topic"
```

Local Grok: symlinks under `~/.grok/skills/` → AI-Tools paths.

## Related

- Constitution: evidence before action  
- Later pipeline skills (host-specific): design docs, writing plans, execute plan  
