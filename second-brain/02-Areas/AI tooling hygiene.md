---
type: area
status: active
tags:
  - area
  - ai-tools
---

# AI tooling hygiene

## Standard of care
- Constitution and rules live in **AI-Tools** (`rules/`) and stay tool-agnostic.  
- Local agent configs (e.g. `~/.grok/rules/`) are **mirrors**, synced via scripts.  
- This second brain stays in-repo under `second-brain/` and is committed with tool changes.  
- No secrets in git.

## Current focus
- Keep CODE+PARA workflow healthy  
- Process inbox regularly  
- Push vault + rules to GitHub after meaningful changes  

## Related
- [[06-AI-Tools/How this second brain works]]  
- [[06-AI-Tools/AI-Tools map]]  
- [[06-AI-Tools/Constitution and sync]]  
