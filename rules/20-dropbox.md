# Dropbox connection (agent memory aid)

## Where the full runbook lives
- **AI-Tools:** `~/dev/AI-Tools/docs/dropbox-connection.md`  
- **Skill:** `~/dev/AI-Tools/skills/dropbox/SKILL.md`  
- **Second brain:** `second-brain/06-AI-Tools/Dropbox connection.md`

## Defaults for this user (CiscoKidRy)
- Prefer **rclone** remote named **`Dropbox`** (capital D) → `Dropbox:path`
- Binary: `~/.local/bin/rclone` (ensure on PATH)
- Secrets only in `~/.config/rclone/rclone.conf` — never in git
- **Login credentials** live in the **macOS Passwords app** under **Dropbox** — OAuth autofill only; never copy password into MEMORY/git/chat
- **Status:** connected (OAuth completed 2026-08-06)

## When the user mentions Dropbox
1. Load the runbook above.  
2. Check `rclone listremotes` for `Dropbox:`.  
3. If missing/broken, `rclone config reconnect Dropbox:` and browser login via Passwords app.  
4. Operate with `Dropbox:` paths; never print tokens from `rclone.conf`.

## Security
Never store or commit Dropbox passwords, refresh tokens, or `rclone.conf` contents.
