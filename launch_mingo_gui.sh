#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="${REMOTE_HOST:-mingo}"
REMOTE_SCRIPT="${REMOTE_SCRIPT:-/home/mingo/DATAFLOW_v3/MASTER/ANCILLARY/PIPELINE_REAL_TIME_CHECK/step1_status_timeline_gui.py}"

if ! command -v ssh >/dev/null 2>&1; then
  echo "Error: ssh is not installed."
  exit 1
fi

# Launch the GUI explicitly on the remote host for reliable startup.
exec ssh -X -o ExitOnForwardFailure=yes "$REMOTE_HOST" "python3 \"$REMOTE_SCRIPT\""
