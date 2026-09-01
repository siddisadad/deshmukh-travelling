#!/usr/bin/env bash
set -euo pipefail

export PATH="/opt/flutter/bin:${PATH:-}"
cd /workspace

# Make start idempotent: free port 8080 if a previous web-server is still bound.
if command -v fuser >/dev/null 2>&1; then
  fuser -k 8080/tcp >/dev/null 2>&1 || true
fi
pkill -f -- "flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8080" >/dev/null 2>&1 || true
sleep 1

nohup flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8080 \
  >/tmp/flutter-web.log 2>&1 &

i=0
while [ "$i" -lt 90 ]; do
  if curl -sf http://127.0.0.1:8080/ >/dev/null; then
    echo "Flutter web ready on :8080"
    exit 0
  fi
  i=$((i + 1))
  sleep 2
done

echo "Flutter web failed to become ready" >&2
tail -n 80 /tmp/flutter-web.log >&2 || true
exit 1
