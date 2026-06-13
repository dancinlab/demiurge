#!/bin/bash
# GRID-TRACKER status board — one command shows the whole shard fleet.
# Reads the ledger (id·host·port·q·irr), parallel-SSH-fans each shard, prints
# a one-screen table: id · q · irr · rep/114 · elph · done · alive.
# No per-pod manual SSH — this IS the "추적 쉽게" tracker. Read-only.
set -u
LEDGER="${1:-$(dirname "$0")/grid.jsonl}"
NREP="${NREP:-114}"                      # representations per q-point (Li2MgH16)
TMP=$(mktemp -d)
jget(){ echo "$1" | grep -oE "\"$2\":\"[^\"]*\"" | head -1 | cut -d'"' -f4; }

while IFS= read -r line; do
  [ -z "$line" ] && continue
  id=$(jget "$line" id); st=$(jget "$line" status)
  [ "$st" = "gone" ] && { printf '%-12s | gone\n' "$id" > "$TMP/$id"; continue; }
  host=$(jget "$line" host); port=$(jget "$line" port); q=$(jget "$line" q); irr=$(jget "$line" irr)
  (
    r=$(timeout 15 ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR -o ConnectTimeout=8 -o BatchMode=yes -p "$port" "$host" '
        d=$(find / -maxdepth 5 -name ph.out 2>/dev/null | head -1)
        rep=$(grep -cE "Representation #" "$d" 2>/dev/null)
        el=$(find / -name "*.elph.*" 2>/dev/null | wc -l | tr -d " ")
        dn=$(grep -c "JOB DONE" "$d" 2>/dev/null)
        px=$(pgrep -c -f ph.x 2>/dev/null)
        echo "$rep $el $dn $px"' 2>/dev/null)
    if [ -z "$r" ]; then
      printf '%-12s %-5s %-7s %-8s %-5s %-5s %s\n' "$id" "$q" "$irr" "--" "--" "--" "SSH-FAIL" > "$TMP/$id"
    else
      set -- $r
      printf '%-12s %-5s %-7s %-8s %-5s %-5s ph.x=%s\n' "$id" "$q" "$irr" "${1:-?}/$NREP" "${2:-?}" "${3:-?}" "${4:-?}" > "$TMP/$id"
    fi
  ) &
done < "$LEDGER"
wait

echo "=== 🛰️ GRID-TRACKER 상태판 ($(date '+%H:%M:%S')) ==="
printf '%-12s %-5s %-7s %-8s %-5s %-5s %s\n' ID q irr rep elph done alive
printf '%s\n' "────────────────────────────────────────────────────────────"
cat "$TMP"/* 2>/dev/null | sort
# rollup
done_n=$(cat "$TMP"/* 2>/dev/null | awk '$6 ~ /^[1-9]/' | wc -l | tr -d ' ')
elph_n=$(cat "$TMP"/* 2>/dev/null | awk '$5 ~ /^[1-9]/' | wc -l | tr -d ' ')
tot=$(ls "$TMP" | wc -l | tr -d ' ')
printf '%s\n' "────────────────────────────────────────────────────────────"
echo "롤업: $tot shard · elph시작 $elph_n · JOB DONE $done_n"
rm -rf "$TMP"
