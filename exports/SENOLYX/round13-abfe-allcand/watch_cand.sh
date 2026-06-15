#!/usr/bin/env bash
# R13 watcher. Polls harvest_cand every 6 min. (R13 systems are larger/slower than R12.)
#
# AUTO RE-ARM (failure-mode #8): instead of a fixed poll cap that can self-exit and
# leave the campaign UNWATCHED (R12's watch.sh died at its 7.5h budget and ran blind
# until caught), this loops until EITHER all cells are done OR there has been NO
# progress (done_cells unchanged) for STALL_HOURS. On reaching the per-relaunch poll
# budget while cells are still completing, it re-execs ITSELF (exec "$0" "$@") to
# re-arm a fresh watcher. It still exits cleanly the moment the campaign truly
# completes (all 9 cells) or genuinely stalls.
#
# AUTO-DOWN (failure-mode #10): on confirmed FULL completion (harvest exit 0 = all 9
# cells), after RESULT.txt is preserved, it calls `recover.sh reap --apply` to destroy
# THIS campaign's leaked/idle pods and stop billing. SAFETY: reap is invoked ONLY on
# confirmed full completion (never on partial/blip), and reap itself only ever touches
# senolyx-*-owned pods absent from BOTH manifests — the RTSC pod (41001569) and every
# manifest pod can never match. Verified guard in recover.sh cmd_reap.
set -uo pipefail
cd "$(dirname "$0")"

POLLS_PER_ARM=${POLLS_PER_ARM:-100}   # 100 * 6 min = 10h per relaunch arm
STALL_HOURS=${STALL_HOURS:-12}        # exit if done_cells unchanged this long
STALL_POLLS=$(( STALL_HOURS * 10 ))   # 6-min polls -> 10/hour

best=-1; stall=0
for i in $(seq 1 "$POLLS_PER_ARM"); do
  if bash harvest_cand.sh > harvest.last 2>&1; then
    echo "ALL_CELLS_DONE after $((i*6)) min (this arm)"; cat RESULT.txt
    # auto-down: campaign fully complete -> reap this campaign's leaked pods (billing stop).
    echo "[$(date -u +%FT%TZ)] auto-down: recover.sh reap --apply (senolyx-* orphans only; RTSC + manifest pods safe)"
    bash recover.sh reap --apply 2>&1 | sed 's/^/  /' || echo "  WARN reap returned nonzero (left pods intact)"
    exit 0
  fi
  D=$(grep -o 'done_cells=[0-9]*/9' RESULT.txt 2>/dev/null | head -1)
  n=$(echo "$D" | grep -o '[0-9]*' | head -1); n=${n:-0}
  if [ "$n" -gt "$best" ]; then best=$n; stall=0; else stall=$((stall+1)); fi
  echo "[$(date -u +%FT%TZ)] poll $i: $D  (best=$best stall=$stall/$STALL_POLLS)"
  if [ "$stall" -ge "$STALL_POLLS" ]; then
    echo "WATCH_STALL: no progress for ${STALL_HOURS}h (done=$best/9) — exiting, NOT reaping (incomplete)"; cat RESULT.txt 2>/dev/null; exit 2
  fi
  /bin/sleep 360
done
# budget hit but cells still incomplete and progressing -> re-arm a fresh watcher.
echo "[$(date -u +%FT%TZ)] arm budget reached (done=$best/9, still incomplete) — re-arming watcher (exec \$0)"
exec "$0" "$@"
