#!/usr/bin/env bash
# R12 watcher. Polls harvest every 6 min; exits when all 10 cells done.
#
# AUTO RE-ARM (failure-mode #8): R12's old watch.sh self-exited at a fixed 7.5h budget
# and the campaign then ran UNWATCHED until caught. This now loops until EITHER all 10
# cells are done OR there is NO progress (done_cells unchanged) for STALL_HOURS; on
# hitting the per-arm poll budget while cells are still completing it re-execs ITSELF
# (exec "$0" "$@") to re-arm a fresh watcher, and still exits cleanly on true completion.
#
# AUTO-DOWN (failure-mode #10): on confirmed FULL completion (harvest exit 0 = all 10
# cells) it calls the canonical reaper `../round13-abfe-allcand/recover.sh reap --apply`
# (which scans BOTH manifests) to destroy leaked senolyx-* pods and stop billing. SAFETY:
# only on confirmed full completion; reap only ever touches senolyx-*-owned pods absent
# from BOTH manifests — RTSC (41001569) + all manifest pods (incl. R12's own running pods)
# can never match.
set -uo pipefail
cd "$(dirname "$0")"

POLLS_PER_ARM=${POLLS_PER_ARM:-75}    # 75 * 6 min = 7.5h per relaunch arm
STALL_HOURS=${STALL_HOURS:-12}        # exit if done_cells unchanged this long
STALL_POLLS=$(( STALL_HOURS * 10 ))   # 6-min polls -> 10/hour
REAPER=../round13-abfe-allcand/recover.sh

best=-1; stall=0
for i in $(seq 1 "$POLLS_PER_ARM"); do
  if bash harvest.sh > harvest.last 2>&1; then
    echo "ALL_CELLS_DONE after $((i*6)) min (this arm)"; cat RESULT.txt
    echo "[$(date -u +%FT%TZ)] auto-down: recover.sh reap --apply (senolyx-* orphans only; RTSC + manifest pods safe)"
    if [ -f "$REAPER" ]; then bash "$REAPER" reap --apply 2>&1 | sed 's/^/  /' || echo "  WARN reap returned nonzero (left pods intact)"; else echo "  WARN reaper $REAPER not found — skipping auto-down"; fi
    exit 0
  fi
  D=$(grep -o 'done_cells=[0-9]*/10' RESULT.txt 2>/dev/null | head -1)
  n=$(echo "$D" | grep -o '[0-9]*' | head -1); n=${n:-0}
  if [ "$n" -gt "$best" ]; then best=$n; stall=0; else stall=$((stall+1)); fi
  echo "[$(date -u +%FT%TZ)] poll $i: $D  (best=$best stall=$stall/$STALL_POLLS)"
  if [ "$stall" -ge "$STALL_POLLS" ]; then
    echo "WATCH_STALL: no progress for ${STALL_HOURS}h (done=$best/10) — exiting, NOT reaping (incomplete)"; cat RESULT.txt 2>/dev/null; exit 2
  fi
  /bin/sleep 360
done
echo "[$(date -u +%FT%TZ)] arm budget reached (done=$best/10, still incomplete) — re-arming watcher (exec \$0)"
exec "$0" "$@"
