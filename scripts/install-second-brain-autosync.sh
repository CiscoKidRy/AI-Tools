#!/usr/bin/env bash
# Install or uninstall a per-user launchd agent that keeps second-brain/ in sync
# with GitHub on a timer (covers Obsidian edits; agents also sync immediately).
#
# Usage:
#   ./scripts/install-second-brain-autosync.sh install   # default
#   ./scripts/install-second-brain-autosync.sh uninstall
#   ./scripts/install-second-brain-autosync.sh status
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SYNC_SCRIPT="$ROOT/scripts/sync-second-brain.sh"
LABEL="com.ciscokidry.ai-tools.second-brain-sync"
PLIST="$HOME/Library/LaunchAgents/${LABEL}.plist"
# Every 3 minutes — debounce-friendly for Obsidian without fswatch
INTERVAL_SEC="${SB_SYNC_INTERVAL_SEC:-180}"
LOG_DIR="$HOME/.local/log"
OUT_LOG="$LOG_DIR/ai-tools-second-brain-sync.launchd.out.log"
ERR_LOG="$LOG_DIR/ai-tools-second-brain-sync.launchd.err.log"

mkdir -p "$LOG_DIR" "$HOME/Library/LaunchAgents"

cmd="${1:-install}"

write_plist() {
  [[ -x "$SYNC_SCRIPT" ]] || chmod +x "$SYNC_SCRIPT"
  cat >"$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>${LABEL}</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>${SYNC_SCRIPT}</string>
    <string>sync</string>
  </array>
  <key>WorkingDirectory</key>
  <string>${ROOT}</string>
  <key>StartInterval</key>
  <integer>${INTERVAL_SEC}</integer>
  <key>RunAtLoad</key>
  <true/>
  <key>StandardOutPath</key>
  <string>${OUT_LOG}</string>
  <key>StandardErrorPath</key>
  <string>${ERR_LOG}</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key>
    <string>${HOME}/.local/bin:/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin</string>
    <key>HOME</key>
    <string>${HOME}</string>
  </dict>
</dict>
</plist>
EOF
}

uninstall() {
  if launchctl print "gui/$(id -u)/${LABEL}" >/dev/null 2>&1; then
    launchctl bootout "gui/$(id -u)/${LABEL}" 2>/dev/null || launchctl unload "$PLIST" 2>/dev/null || true
  fi
  rm -f "$PLIST"
  echo "Uninstalled ${LABEL}"
}

install() {
  uninstall 2>/dev/null || true
  write_plist
  launchctl bootstrap "gui/$(id -u)" "$PLIST" 2>/dev/null \
    || launchctl load "$PLIST"
  # Kick once now
  launchctl kickstart -k "gui/$(id -u)/${LABEL}" 2>/dev/null || true
  echo "Installed ${LABEL}"
  echo "  script:   $SYNC_SCRIPT"
  echo "  interval: ${INTERVAL_SEC}s"
  echo "  plist:    $PLIST"
  echo "  logs:     $OUT_LOG"
  echo "            $ERR_LOG"
  echo "            $HOME/.local/log/ai-tools-second-brain-sync.log"
  echo
  echo "On every other machine that edits this vault:"
  echo "  cd ~/dev/AI-Tools && git pull && ./scripts/install-second-brain-autosync.sh install"
}

status() {
  echo "plist: $PLIST"
  if [[ -f "$PLIST" ]]; then
    echo "plist: present"
  else
    echo "plist: missing (not installed)"
  fi
  if launchctl print "gui/$(id -u)/${LABEL}" >/dev/null 2>&1; then
    echo "launchd: loaded"
    launchctl print "gui/$(id -u)/${LABEL}" 2>/dev/null | head -40 || true
  else
    echo "launchd: not loaded"
  fi
  echo "--- recent sync log ---"
  tail -n 20 "$HOME/.local/log/ai-tools-second-brain-sync.log" 2>/dev/null || echo "(no log yet)"
}

case "$cmd" in
  install) install ;;
  uninstall|remove) uninstall ;;
  status) status ;;
  *)
    echo "Usage: $0 [install|uninstall|status]" >&2
    exit 1
    ;;
esac
