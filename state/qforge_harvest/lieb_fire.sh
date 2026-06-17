#!/usr/bin/env bash
# Lieb-lattice (Os-O, CuO2 isomorph) flat-band gate-check — graph-topology
# generator's first untested topology (theorem-2 bipartite imbalance). Screen-first:
# fixed idealized geometry, scf + bands (verbosity='high') + parse. vc-relax only if
# GREEN (same screen->promote pattern as the kagome siblings). Self-logging.
# GUARD: waits for the LaOs3Si2 vc-relax to free summer's 6 cores (no oversubscribe).
exec >> "$HOME/lieb_oso2.log" 2>&1
set -u
QE=/home/summer/micromamba/envs/qe/bin
export OMP_NUM_THREADS=1
run() { "$QE/mpirun" -np 6 --bind-to none "$QE/pw.x" -in "$1" > "$2" 2>&1; }

echo "#### Lieb Os-O gate-check QUEUED $(date) ####"
# wait until vc-relax done (log marker) AND no pw.x running, up to ~90 min
for i in $(seq 1 180); do
  if grep -q "vc-relax DONE" "$HOME/laos3si2_vcrelax.log" 2>/dev/null && [ "$(pgrep -x pw.x | wc -l)" -eq 0 ]; then
    echo "guard cleared (vc-relax done, cores free) at iter $i $(date)"; break
  fi
  sleep 30
done

cd "$HOME/sib_work/lieb_oso2" || { echo "NO DIR"; exit 1; }
echo "#### Lieb Os-O START $(date) ####"
echo "-- scf --"; run scf.in scf.out
grep -q "JOB DONE" scf.out || { echo "SCF FAIL"; tail -15 scf.out; exit 1; }
grep "absolute magnetization" scf.out | tail -1
grep "the Fermi energy is" scf.out | tail -1
echo "-- bands (verbosity high) --"; run bands.in bands.out
echo "JOBDONE=$(grep -c 'JOB DONE' bands.out) kpts=$(grep -c 'bands (ev)' bands.out)"
echo "== Lieb Os-O GATE =="
python3 parse_flatband.py 2>&1 || python parse_flatband.py 2>&1
echo "=== Lieb Os-O DONE $(date) ==="
