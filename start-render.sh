#!/bin/sh
set -eu

export DISPLAY="${DISPLAY:-:99}"

echo "Starting Xvfb on ${DISPLAY}..."
rm -f /tmp/.X99-lock

Xvfb "${DISPLAY}" -screen 0 1366x900x24 -nolisten tcp -ac -noreset 2>&1 &
XVFB_PID="$!"

sleep 2

if ! kill -0 "${XVFB_PID}" 2>/dev/null; then
  echo "Xvfb failed to start."
  exit 1
fi

echo "Xvfb is running with PID ${XVFB_PID}."
exec node index.js
