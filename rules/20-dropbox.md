# Dropbox connection (agent memory aid)

## Where the full runbook lives
- **AI-Tools:** `~/dev/AI-Tools/docs/dropbox-connection.md`  
- **Skill:** `~/dev/AI-Tools/skills/dropbox/SKILL.md`  
- **Second brain:** `second-brain/06-AI-Tools/Dropbox connection.md`

## Defaults for this user (CiscoKidRy)
- Prefer **rclone** remote named **`dropbox`**
- Binary: `~/.local/bin/rclone` (ensure on PATH)
- Secrets only in `~/.config/rclone/rclone.conf` — never in git
- **Login credentials** live in the **macOS Passwords app** under **Dropbox** — use for browser OAuth autofill only; agents cannot scrape Passwords.app; never copy password into MEMORY/git/chat

## When the user mentions Dropbox
1. Load the runbook above.  
2. Check `rclone listremotes` for `dropbox:`.  
3. If not connected, start OAuth (`rclone config` / authorize); ask user to unlock Passwords and fill Dropbox login in the browser.  
4. After successful connect, note in global memory: status + date only (no tokens).

## Security
Never store or commit Dropbox passwords, refresh tokens, or `rclone.conf` contents.
