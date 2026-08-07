---
name: dropbox
description: Connect to and operate on the user's Dropbox via rclone. Use when listing, uploading, downloading, or syncing Dropbox files.
---

# Dropbox skill

## Canonical runbook
Read and follow: `docs/dropbox-connection.md` in the AI-Tools repo (`~/dev/AI-Tools/docs/dropbox-connection.md`).

## Defaults
- CLI: `rclone` at `~/.local/bin/rclone`
- Remote name: `dropbox`
- Config (local secrets): `~/.config/rclone/rclone.conf` — **never commit**

## Quick path
1. Ensure rclone on PATH  
2. `rclone listremotes` → need `dropbox:`  
3. If missing: run interactive setup from the runbook (browser OAuth)  
4. User logs in with **macOS Passwords app → Dropbox** entry (agent does not read Passwords.app)  
5. Verify: `rclone lsd dropbox:`  
6. Then copy/ls/sync as requested  

## Never
- Commit tokens or `rclone.conf`
- Print full OAuth tokens or Passwords-app secrets into chat or notes
- Scrape or dump the macOS Passwords / Keychain Dropbox password into memory files
