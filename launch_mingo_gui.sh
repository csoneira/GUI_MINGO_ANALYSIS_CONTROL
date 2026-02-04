#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="${REMOTE_HOST:-mingo}"
REMOTE_SCRIPT="${REMOTE_SCRIPT:-/home/mingo/DATAFLOW_v3/MASTER/ANCILLARY/PIPELINE_REAL_TIME_CHECK/step1_status_timeline_gui.py}"
LOG_DIR="${MINGO_GUI_LOG_DIR:-/tmp/mingo-gui}"
LOG_FILE="$LOG_DIR/launcher.log"

if ! command -v ssh >/dev/null 2>&1; then
  echo "Error: ssh is not installed."
  exit 1
fi

mkdir -p "$LOG_DIR"

# Use --foreground for debugging to keep the current shell attached.
if [[ "${1:-}" == "--foreground" ]]; then
  exec ssh -X -o ExitOnForwardFailure=yes "$REMOTE_HOST" "python3 \"$REMOTE_SCRIPT\""
fi

# Detach from the caller so launching from a terminal doesn't leave it hanging.
nohup ssh -X -o ExitOnForwardFailure=yes "$REMOTE_HOST" "python3 \"$REMOTE_SCRIPT\"" \
  >"$LOG_FILE" 2>&1 < /dev/null &
