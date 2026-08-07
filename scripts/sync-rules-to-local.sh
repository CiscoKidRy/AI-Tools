#!/usr/bin/env bash
# Copy AI-Tools rules → local Grok global rules.
# Source of truth: this repo's rules/ directory.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="${GROK_RULES_DIR:-$HOME/.grok/rules}"
mkdir -p "$DEST"
cp -R "$ROOT/rules/." "$DEST/"
echo "Synced $ROOT/rules → $DEST"
ls -la "$DEST"
