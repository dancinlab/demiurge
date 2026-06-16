#!/usr/bin/env bash
# Self-logging fire wrapper for the LaOs3Si2 DFPT el-ph campaign on summer (FREE pool).
# Builds the workdir ~/laos3si2_dfpt/ from the relaxed deck at ~/sib_work/laos3si2_fx/,
# then runs run_elph.sh with all stdout/stderr teed to ~/laos3si2_dfpt.log (survives setsid detach).
#
# Launch DETACHED on summer:
#   setsid bash ~/laos3si2_dfpt_fire.sh >/dev/null 2>&1 </dev/null & disown
# Progress:
#   grep -nE "===|Representation|Diagonalizing|JOB DONE|lambda|STABILITY|FAILED" ~/laos3si2_dfpt.log
set -uo pipefail
SRC=$HOME/sib_work/laos3si2_fx
WORK=$HOME/laos3si2_dfpt
LOG=$HOME/laos3si2_dfpt.log

exec >> "$LOG" 2>&1
echo "================================================================"
echo "[$(date)] LaOs3Si2 DFPT fire START (summer free pool, np 6)"
echo "================================================================"

mkdir -p "$WORK"
# deck files (scf.in, ph.in, run_elph.sh) are copied in by the dispatcher (scp) before this runs.
# pseudos: reuse the verified set from the relaxed deck.
mkdir -p "$WORK/pseudo"
cp -f "$SRC/pseudo/La_ONCV_PBE_sr.upf" "$SRC/pseudo/Os_ONCV_PBE_sr.upf" "$SRC/pseudo/Si_ONCV_PBE_sr.upf" "$WORK/pseudo/"
echo "[$(date +%H:%M:%S)] pseudos staged:"; ls -la "$WORK/pseudo/"

cd "$WORK" || { echo "cd $WORK FAILED"; exit 2; }
echo "[$(date +%H:%M:%S)] deck files in workdir:"; ls -la "$WORK"/*.in "$WORK"/run_elph.sh

NP=6 bash "$WORK/run_elph.sh"

echo "================================================================"
echo "[$(date)] LaOs3Si2 DFPT fire WRAPPER DONE"
echo "================================================================"
