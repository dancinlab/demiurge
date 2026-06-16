#!/usr/bin/env bash
# Checkerboard-lattice (Os-O, line graph of the square = 2D pyrochlore cousin of
# kagome) flat-band gate-check — graph-topology generator's next untested topology
# (theorem-1 line-graph flat band; CLS on square plaquettes). Screen-first: fixed
# idealized geometry, scf + bands (verbosity='high') + parse. vc-relax only if GREEN
# (same screen->promote pattern as the kagome/Lieb siblings). Self-logging.
# GUARD: waits for the LaOs3Si2 vc-relax AND the Lieb gate to free summer's 6 cores
# (no oversubscribe — third in the queue: vc-relax -> Lieb -> checkerboard).
exec >> "$HOME/checkerboard.log" 2>&1
set -u
QE=/home/summer/micromamba/envs/qe/bin
export OMP_NUM_THREADS=1
run() { "$QE/mpirun" -np 6 --bind-to none "$QE/pw.x" -in "$1" > "$2" 2>&1; }

echo "#### Checkerboard Os-O gate-check QUEUED $(date) ####"
# wait until BOTH the vc-relax and the Lieb gate are done AND no pw.x running.
# poll up to ~6 h (720 * 30 s) — vc-relax + Lieb scf/bands ahead in the queue.
for i in $(seq 1 720); do
  vc_done=0; lieb_done=0
  grep -q "vc-relax DONE" "$HOME/laos3si2_vcrelax.log" 2>/dev/null && vc_done=1
  grep -q "Lieb Os-O DONE"  "$HOME/lieb_oso2.log"       2>/dev/null && lieb_done=1
  free=0; [ "$(pgrep -x pw.x | wc -l)" -eq 0 ] && free=1
  if [ "$vc_done" -eq 1 ] && [ "$lieb_done" -eq 1 ] && [ "$free" -eq 1 ]; then
    echo "guard cleared (vc-relax done, Lieb done, cores free) at iter $i $(date)"; break
  fi
  [ $((i % 20)) -eq 0 ] && echo "  ...waiting iter $i: vc=$vc_done lieb=$lieb_done free=$free $(date)"
  sleep 30
done

cd "$HOME/sib_work/checkerboard_oso2" || { echo "NO DIR"; exit 1; }
echo "#### Checkerboard Os-O START $(date) ####"
echo "-- scf --"; run scf.in scf.out
grep -q "JOB DONE" scf.out || { echo "SCF FAIL"; tail -15 scf.out; exit 1; }
grep "absolute magnetization" scf.out | tail -1
grep "the Fermi energy is" scf.out | tail -1
echo "-- bands (verbosity high) --"; run bands.in bands.out
echo "JOBDONE=$(grep -c 'JOB DONE' bands.out) kpts=$(grep -c 'bands (ev)' bands.out)"
echo "== Checkerboard Os-O GATE =="
python3 parse_flatband.py bands.out scf.out 2>&1 || python parse_flatband.py bands.out scf.out 2>&1
echo "=== Checkerboard Os-O DONE $(date) ==="
