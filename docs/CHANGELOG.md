# AI-Tools changelog

## 2026-08-07 — Retrospective skill (AI-tool-agnostic)
- `skills/Retrospective/` — end-of-session retro; propose portable skills/rules/workflows; approve-then-write to AI-Tools
- `docs/retrospective.md`, staging `docs/retros/`
- Host transcripts optional; conversation is primary; no vendor lock-in

## 2026-08-06 — Dropbox connection runbook
- `docs/dropbox-connection.md` — how agents connect via rclone (no secrets)
- `skills/dropbox/SKILL.md` + `rules/20-dropbox.md`
- Second-brain note: Dropbox connection

## 2026-08-06 — Second brain + constitution foundation

### Agent constitution (tool-agnostic)
- Canonical rules in `rules/` (constitution, free-tools policy, AI-Tools pointer)
- Sync scripts: `scripts/sync-rules-to-local.sh`, `scripts/sync-from-local-rules.sh`
- Mission: one GitHub vault kept in sync across Grok/Claude/Codex/etc.

### Obsidian second brain (`second-brain/`)
- CODE + PARA + atomic notes configuration
- Core Obsidian settings, hotkeys, graph colors, templates
- Operating guide: `second-brain/06-AI-Tools/How this second brain works.md`
- Daily notes, projects/areas/resources/archive

### People CRM
- `second-brain/07-People/` personal CRM
- Person template: facts, preferences, related projects, meeting log
- Wired into Home, inbox processing, meeting/project templates

### Git / GitHub
- Repo: https://github.com/CiscoKidRy/AI-Tools
- Local clone: `~/dev/AI-Tools`
