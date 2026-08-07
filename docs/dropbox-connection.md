# How to connect Dropbox (agent + human runbook)

**Owner:** CiscoKidRy  
**Machine preference:** macOS · CLI via **rclone** · optional Dropbox desktop app  

This document is **safe to commit**. It never stores tokens, passwords, or API secrets.

---

## Preferred connection method: rclone (CLI)

Agents use **rclone** for list/upload/download/sync against Dropbox without relying on the desktop app.

| Item | Value |
|------|--------|
| Binary | `~/.local/bin/rclone` (also on `PATH` via `~/.zshrc`) |
| Remote name (this machine) | **`Dropbox`** (capital D) |
| Config file (local only) | `~/.config/rclone/rclone.conf` |
| Docs | https://rclone.org/dropbox/ |
| Status | Connected (OAuth completed 2026-08-06) |

### Credentials location (this user)

| Item | Where |
|------|--------|
| Dropbox **login** (email/password) | **macOS Passwords app**, entry titled **Dropbox** |
| Dropbox **API token** after connect | `~/.config/rclone/rclone.conf` only (never git) |

**Important:** rclone does **not** take the Passwords-app password as a CLI flag. Dropbox uses **browser OAuth**. During that browser step, unlock Passwords and autofill the Dropbox entry (or paste once). Agents must **not** read or store that password in memory/git/chat.

### One-time setup (interactive — needs browser)

```bash
export PATH="$HOME/.local/bin:$PATH"

# Create remote named "dropbox"
rclone config
```

Interactive answers (typical):

1. `n` — New remote  
2. name: `dropbox`  
3. Storage: `dropbox` (type number from list)  
4. `client_id` / `client_secret` — leave blank for rclone defaults (OK for personal use)  
5. Edit advanced — `n` unless you know you need it  
6. Auto config — **`y`** (opens browser; sign in via **Passwords → Dropbox**, then Allow)  
7. Team folder — usually `n` for personal  
8. Keep as default — quit with `q`

Or non-wizard authorize helper:

```bash
rclone authorize "dropbox"
# Paste the token into `rclone config` when prompted
```

### Verify connection

```bash
rclone about Dropbox:
rclone lsd Dropbox:
rclone ls Dropbox: --max-depth 1
```

### Common agent commands

```bash
# List
rclone lsf Dropbox:path/to/folder

# Copy local → Dropbox
rclone copy /local/path Dropbox:remote/path -P

# Copy Dropbox → local
rclone copy Dropbox:remote/path /local/path -P

# Sync (careful: can delete)
rclone sync /local/path Dropbox:remote/path -P --dry-run
```

### If auth fails / token expired

```bash
rclone config reconnect Dropbox:
# or delete remote and re-run `rclone config`
```

---

## Optional: Dropbox desktop app

For Finder-visible files:

1. Install from https://www.dropbox.com/install  
2. Sign in as the user’s Dropbox account  
3. Local path is often:
   - `~/Dropbox`, or  
   - `~/Library/CloudStorage/Dropbox` (File Provider)

Agents may use the local folder **if** it exists and is fully synced. Prefer **rclone** when the desktop path is missing or partial.

Check:

```bash
ls -ld ~/Dropbox ~/Library/CloudStorage/Dropbox* 2>/dev/null
```

---

## Security rules (mandatory)

1. **Never** commit `rclone.conf`, OAuth tokens, or Dropbox API keys to GitHub / AI-Tools.  
2. **Never** paste full tokens into chat logs, second-brain notes, or MEMORY.md.  
3. Config stays in `~/.config/rclone/rclone.conf` (user home, not the repo).  
4. Prefer least privilege; don’t share refresh tokens.

---

## Agent checklist when user asks for Dropbox

1. `command -v rclone` — install to `~/.local/bin` if missing (see AI-Tools history / rclone install zip).  
2. `rclone listremotes` — expect `dropbox:`  
3. If missing remote → guide or run `rclone config` / `rclone config reconnect dropbox:` (user must complete browser OAuth).  
4. Operate with `dropbox:` remote paths.  
5. Update memory status: **connected** vs **needs OAuth** (never store the token).

---

## Status tracking (fill after connect)

| Field | Value |
|-------|--------|
| Account email (optional, non-secret) | _(user can fill)_ |
| rclone remote name | `dropbox` |
| Last verified | _(date)_ |
| Desktop app installed | no / yes |
| Local sync folder | _(path if any)_ |
