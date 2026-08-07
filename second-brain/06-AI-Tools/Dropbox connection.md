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
| Remote name | `dropbox` |
| Config | `~/.config/rclone/rclone.conf` (local only) |
| Binary | `~/.local/bin/rclone` |

## Status
- [ ] rclone installed  
- [ ] remote `dropbox:` authorized (browser OAuth once)  
- [ ] `rclone lsd dropbox:` works  
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
