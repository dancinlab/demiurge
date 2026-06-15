#!/usr/bin/env bash
# Poll harvest_cand every 6 min up to ~10h (R13 systems are larger/slower than R12).
set -uo pipefail
cd "$(dirname "$0")"
for i in $(seq 1 100); do
  if bash harvest_cand.sh > harvest.last 2>&1; then echo "ALL_CELLS_DONE after $((i*6)) min"; cat RESULT.txt; exit 0; fi
  echo "[$(date -u +%FT%TZ)] poll $i: $(grep -o 'done_cells=[0-9]*/9' RESULT.txt 2>/dev/null | head -1)"
  /bin/sleep 360
done
echo "WATCH_TIMEOUT"; cat RESULT.txt 2>/dev/null; exit 2
