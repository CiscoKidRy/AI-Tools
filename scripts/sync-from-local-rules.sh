#!/usr/bin/env bash
# Copy local Grok global rules → AI-Tools rules/ (promote local edits to the vault).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${GROK_RULES_DIR:-$HOME/.grok/rules}"
if [[ ! -d "$SRC" ]]; then
  echo "No local rules at $SRC" >&2
  exit 1
fi
mkdir -p "$ROOT/rules"
cp -R "$SRC/." "$ROOT/rules/"
echo "Synced $SRC → $ROOT/rules"
ls -la "$ROOT/rules"
