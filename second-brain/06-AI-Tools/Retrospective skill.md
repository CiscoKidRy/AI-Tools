---
type: resource
status: reference
tags:
  - ai-tools
  - skills
---

# Retrospective skill

## What
AI-**tool-agnostic** end-of-session skill: summarize the session, propose portable **skills / rules / workflows / agents / memory**, write into **AI-Tools** only after approval.

## Where
- Skill: monorepo `skills/Retrospective/SKILL.md`
- Design: `docs/retrospective.md`
- Staging: `docs/retros/`

## Why agnostic
- Conversation is the primary source (any host)
- Optional host logs never required
- Outputs live in AI-Tools (`AGENTS.md`, `rules/`, `skills/`), not a single product’s private folder as sole truth

## Invoke
“Run **Retrospective**” or “session retro — propose skills for AI-Tools”
