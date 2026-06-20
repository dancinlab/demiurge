#!/usr/bin/env bash
# Full leverb-mae-production campaign: run each cell's force-theorem MAE sequentially.
# Detached-safe. Writes a per-cell .RESULT line + a campaign RESULTS.txt summary.
# FeCo c/a scan first (cheap 2-atom), Fe16N2 last (18-atom, heavier).
set -uo pipefail
cd "$(dirname "$0")"
export NP="${NP:-4}"
RESULTS=RESULTS.txt
: > "$RESULTS"
echo "campaign start $(date)  NP=$NP" | tee -a "$RESULTS"

CELLS="feco_ca0p9 feco_ca1p0 feco_ca1p1 feco_ca1p2 feco_ca1p3 fe16n2"
for c in $CELLS; do
  d="decks/$c"
  echo "" | tee -a "$RESULTS"
  echo ">>> $c  $(date)" | tee -a "$RESULTS"
  bash run_cell.sh "$d" > "logs_$c.txt" 2>&1
  rc=$?
  K1=$(grep '^K1_MJ_per_m3=' "logs_$c.txt" | tail -1 | cut -d= -f2)
  GATE=$(grep '^GATE_3MJ=' "logs_$c.txt" | tail -1 | cut -d= -f2)
  MAE=$(grep '^MAE_meV_per_cell=' "logs_$c.txt" | tail -1 | cut -d= -f2)
  MAG=$(grep 'absolute magnetization' "logs_$c.txt" | tail -1 | awk '{print $4}')
  if [ "$rc" -eq 0 ] && [ -n "${K1:-}" ]; then
    echo "RESULT $c  MAE_meV=$MAE  K1_MJm3=$K1  $GATE  absmag=$MAG" | tee -a "$RESULTS"
  else
    tail3=$(tail -3 "logs_$c.txt" | tr '\n' '|')
    echo "RESULT $c  INCOMPLETE rc=$rc  tail=$tail3" | tee -a "$RESULTS"
  fi
done
echo "" | tee -a "$RESULTS"
echo "campaign done $(date)" | tee -a "$RESULTS"
