---
type: resource
status: reference
tags:
  - ai-tools
  - dropbox
  - integrations
---

# Dropbox connection

## Purpose
How agents and I connect to Dropbox from this Mac. **No secrets in this note.**

## Canonical runbook (repo)
Full steps: monorepo path `docs/dropbox-connection.md`  
Skill: `skills/dropbox/SKILL.md`

## Defaults
| Item | Value |
|------|--------|
| Tool | rclone |
| Remote name | `Dropbox` (capital D) |
| Config | `~/.config/rclone/rclone.conf` (local only) |
| Binary | `~/.local/bin/rclone` |
| Login (email/password) | **macOS Passwords app** → entry **Dropbox** (autofill in OAuth browser; never paste into vault notes) |

## Status
- [x] rclone installed  
- [x] Password location known (Passwords app → Dropbox)  
- [x] remote `Dropbox:` authorized (OAuth completed 2026-08-06)  
- [x] `rclone lsd Dropbox:` works  
- [ ] Optional: Dropbox desktop app + local folder  

## Quick verify
```bash
export PATH="$HOME/.local/bin:$PATH"
rclone listremotes
rclone about dropbox:
```

## Related
- [[AI-Tools map]]  
- [[Constitution and sync]]  
