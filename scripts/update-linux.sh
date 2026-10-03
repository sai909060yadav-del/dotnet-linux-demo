#!/usr/bin/env bash
# Manual update for a Git clone. Stop the running demo with Ctrl+C first.
set -euo pipefail
cd "$(dirname "$0")/.."
git rev-parse --show-toplevel >/dev/null
if [[ -n "$(git status --porcelain)" ]]; then
  echo 'Uncommitted changes found. Commit or review them before updating; nothing was overwritten.'
  exit 1
fi
git pull --ff-only
exec bash scripts/run-linux.sh
