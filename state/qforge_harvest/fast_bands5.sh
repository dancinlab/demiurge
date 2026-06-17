#!/usr/bin/env bash
# Sibling flat-band gate-check — REAL root-cause fix (c1/c16).
# Prior failures (disk_io=none, then clean re-run) BOTH gave kpts=0 because QE
# suppresses per-k eigenvalue stdout when #k-points >= 100 unless verbosity='high'.
# The band path is 7 segments x 40 = ~280 k-points (>=100), so the eigenvalue
# blocks were written to ./out/*.save xml but NEVER to bands.out. The disk_io
# theory was wrong. Fix = inject verbosity='high' into bands.in &control.
set -u
QE=/home/summer/micromamba/envs/qe/bin
export OMP_NUM_THREADS=1
run() { "$QE/mpirun" -np 6 --bind-to none "$QE/pw.x" -in "$1" > "$2" 2>&1; }

patch_verbosity() {  # add verbosity='high' to &control if absent (python — robust vs sed backslash)
  local f="$1"
  python3 - "$f" <<'PY'
import sys
f=sys.argv[1]; t=open(f).read()
if "verbosity" not in t:
    open(f,"w").write(t.replace("&control","&control\n  verbosity = 'high'",1))
PY
}

do_sib() {
  local s="$1"; cd "$HOME/sib_work/${s}_fx" || return 1
  echo "#### V5 ${s} $(date) ####"
  patch_verbosity bands.in
  echo "-- scf ${s} --"; run scf.in scf.out
  grep -q "JOB DONE" scf.out && grep "absolute magnetization" scf.out | tail -1 || { echo "SCF FAIL ${s}"; return 1; }
  echo "-- bands ${s} (verbosity high) --"; run bands.in bands.out
  local kpts; kpts=$(grep -c "bands (ev)" bands.out)
  echo "JOBDONE=$(grep -c 'JOB DONE' bands.out) kpts=${kpts}"
  echo "== ${s} GATE =="
  python3 parse_flatband.py 2>&1 || python parse_flatband.py 2>&1
  # KEEP out/ (xml has eigenvalues as fallback); disk has 42G headroom
}

do_sib laos3si2
do_sib larh3si2
echo "=== V5 DONE $(date) ==="
