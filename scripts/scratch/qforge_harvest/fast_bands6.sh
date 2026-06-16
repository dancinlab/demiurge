#!/usr/bin/env bash
# Sibling flat-band gate-check — V6: SELF-LOGGING + verbosity='high' (final).
# Two prior fixes failed to surface results because setsid detachment lost the
# outer stdout redirect (empty log). Fix: the script redirects its OWN output
# (exec >> log) so the journal survives regardless of how it is launched.
# bands.in already carries verbosity='high' (the real root-cause fix for the
# QE ">=100 k-points suppresses eigenvalue stdout" gate). scf is skipped when a
# fresh out/ charge density already exists.
exec >> "$HOME/siblings_v6.log" 2>&1
set -u
QE=/home/summer/micromamba/envs/qe/bin
export OMP_NUM_THREADS=1
run() { "$QE/mpirun" -np 6 --bind-to none "$QE/pw.x" -in "$1" > "$2" 2>&1; }

do_sib() {
  local s="$1"; cd "$HOME/sib_work/${s}_fx" || { echo "NO DIR ${s}"; return 1; }
  echo "#### V6 ${s} $(date) ####"
  grep -q "verbosity" bands.in || python3 -c "import io;f='bands.in';t=open(f).read();open(f,'w').write(t.replace('&control',\"&control\n  verbosity = 'high'\",1))"
  if [ -d out/${s}.save ] && grep -q "JOB DONE" scf.out 2>/dev/null; then
    echo "-- scf ${s} SKIP (out/ exists) --"
  else
    echo "-- scf ${s} --"; run scf.in scf.out
  fi
  grep -q "JOB DONE" scf.out || { echo "SCF FAIL ${s}"; return 1; }
  grep "absolute magnetization" scf.out | tail -1
  echo "-- bands ${s} (verbosity high) --"; run bands.in bands.out
  echo "JOBDONE=$(grep -c 'JOB DONE' bands.out) kpts=$(grep -c 'bands (ev)' bands.out)"
  echo "== ${s} GATE =="
  python3 parse_flatband.py 2>&1 || python parse_flatband.py 2>&1
}

do_sib laos3si2
do_sib larh3si2
echo "=== V6 DONE $(date) ==="
