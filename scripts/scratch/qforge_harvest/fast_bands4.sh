#!/usr/bin/env bash
# Sibling fixed-lattice flat-band gate-check — CLEAN bands re-run (no disk_io=none).
# Root cause of prior failure (c1): disk_io='none' suppressed the per-k eigenvalue
# stdout blocks ("bands (ev)"), so parse_flatband.py found 0 k-points. Disk is now
# freed (43G), so we use the proven clean bands.in (same recipe that gave LaRu3Si2
# dE=-0.055). scf regenerates out/ charge density, then bands prints eigenvalues.
set -u
QE=/home/summer/micromamba/envs/qe/bin
export OMP_NUM_THREADS=1
run() { "$QE/mpirun" -np 6 --bind-to none "$QE/pw.x" -in "$1" > "$2" 2>&1; }

do_sib() {
  local s="$1"; cd "$HOME/sib_work/${s}_fx" || return 1
  echo "#### CLEAN ${s} $(date) ####"
  echo "-- scf ${s} --"; run scf.in scf.out
  grep -q "JOB DONE" scf.out && grep "absolute magnetization" scf.out | tail -1 || { echo "SCF FAIL ${s}"; return 1; }
  echo "-- bands ${s} (clean) --"; run bands.in bands.out
  local kpts; kpts=$(grep -c "bands (ev)" bands.out)
  echo "JOBDONE=$(grep -c 'JOB DONE' bands.out) kpts=${kpts}"
  echo "== ${s} GATE =="
  "$QE/../bin/python" parse_flatband.py 2>&1 || python3 parse_flatband.py 2>&1 || python parse_flatband.py 2>&1
  rm -rf out   # reclaim after parse (evidence = scf.out/bands.out kept)
}

do_sib laos3si2
do_sib larh3si2
echo "=== CLEAN DONE $(date) ==="
