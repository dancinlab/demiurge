#!/bin/bash
# GRID-TRACKER idempotent harvester — pull every DONE shard's light-set partials
# to local, mark the ledger. Safe to re-run from ANY session (no babysitter
# needed): a shard already harvested is skipped. When all shards report done,
# prints the recover/collect next-step.
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
LEDGER="$DIR/grid.jsonl"
DEST="$DIR/../harvest_final"          # exports/rtsc/Li2MgH16/harvest_final
DONEMARK="$DIR/harvested.txt"; touch "$DONEMARK"
mkdir -p "$DEST"
jget(){ echo "$1" | grep -oE "\"$2\":\"[^\"]*\"" | head -1 | cut -d'"' -f4; }

n_harv=0; n_done=0; n_tot=0
while IFS= read -r line; do
  [ -z "$line" ] && continue
  id=$(jget "$line" id); st=$(jget "$line" status)
  [ "$st" = "gone" ] && continue
  n_tot=$((n_tot+1))
  grep -qx "$id" "$DONEMARK" && { n_harv=$((n_harv+1)); n_done=$((n_done+1)); continue; }
  host=$(jget "$line" host); port=$(jget "$line" port); wd=$(jget "$line" wd)
  dn=$(timeout 15 ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR -o ConnectTimeout=8 -o BatchMode=yes -p "$port" "$host" "grep -lc 'JOB DONE' $wd/ph.out 2>/dev/null | wc -l" 2>/dev/null)
  if [ "${dn:-0}" -ge 1 ]; then
    # light-set only: dyn · elph · phsave xml (drop heavy *.wfc / *.dvscf)
    timeout 120 scp -o StrictHostKeyChecking=no -o LogLevel=ERROR -P "$port" \
      "$host:$wd/*.dyn*" "$host:$wd/*.elph.*" "$DEST/" 2>/dev/null
    echo "$id" >> "$DONEMARK"; n_harv=$((n_harv+1)); n_done=$((n_done+1))
    echo "  ✅ harvested $id"
  fi
done < "$LEDGER"

echo "=== harvest: $n_harv/$n_tot done-harvested ==="
ls -1 "$DEST"/li2mgh16.dyn[5-8]* 2>/dev/null | sed 's,.*/,  ,' | head
if [ "$n_done" -ge "$n_tot" ] && [ "$n_tot" -gt 0 ]; then
  echo "🎯 ALL shards done → next: gather _ph0 partials → ph.x recover=.true → dyn5-8 → assemble 8-q λ"
fi
