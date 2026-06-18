#!/usr/bin/env bash
# LaRu3Si2 4x4x4 el-ph PRODUCTION — disk-safe q-batched runner (recover).
# 12 irreducible q, each ~41G dvscf scratch; a 113G pod cannot hold all → run
# 2-q batches, save elph.inp_lambda.<q> + dyn (small) then clear _ph0 (large)
# before the next batch. recover=.true. rides reboots. Args: START_Q END_Q.
set -uo pipefail
D=/root/laru3si2_444; MM=/root/bin/micromamba
cd "$D" || exit 2
# SELF-GUARD (idempotent · flaky-transport safe): kill any stale ph.x/ph_b from a
# prior dry-run or half-launch so they cannot corrupt out/_ph0, then drop stale
# phonon scratch. The converged SCF (out/laru3si2.save) is PRESERVED — only the
# regenerable _ph0 phonon scratch is cleared. Runs once at launch.
pkill -9 -f "ph.x" 2>/dev/null || true
pkill -9 -f "ph_b"  2>/dev/null || true
sleep 3
rm -rf out/_ph0 2>/dev/null || true
RUN="$MM run -n qe"; export OMP_NUM_THREADS=1
# 384-core pod: use 192 ranks with npool=6 — the 16^3 k-grid is embarrassingly
# parallel over k, so -npool ~halves-to-sixths the per-q DFPT walltime nearly
# free (k-pools independent). NP/npool layout is FIXED across a recover chain
# (changing it needs a fresh _ph0), so the self-guard wipe above is intended.
NP=192; NPOOL=6
MPI="$RUN mpirun -np $NP --allow-run-as-root --bind-to none"
mkdir -p elph_out
SQ=${1:-1}; LQ=${2:-12}
echo "=== PROD q$SQ..$LQ on $(hostname) NP=$NP npool=$NPOOL ==="
q=$SQ
while [ "$q" -le "$LQ" ]; do
  e=$((q+1)); [ "$e" -gt "$LQ" ] && e=$LQ
  if [ -f "elph_out/.done_${q}_${e}" ]; then echo "batch q$q-$e already done"; q=$((e+1)); continue; fi
  sed -e "s/^  ! *start_q.*/  start_q = $q/" -e "s/^  ! *last_q.*/  last_q = $e/" ph.in > "ph_b${q}_${e}.in"
  echo "=== BATCH q$q-$e START $(date +%H:%M) ==="
  $MPI ph.x -npool $NPOOL -in "ph_b${q}_${e}.in" > "ph_b${q}_${e}.out" 2>&1
  if grep -qi "JOB DONE" "ph_b${q}_${e}.out"; then
    cp laru3si2.dyn* elph_out/ 2>/dev/null || true
    cp elph.inp_lambda.* elph_out/ 2>/dev/null || true
    touch "elph_out/.done_${q}_${e}"
    rm -rf out/_ph0 2>/dev/null || true     # disk-safe: elph+dyn saved, drop large scratch
    echo "=== BATCH q$q-$e DONE $(date +%H:%M) ==="
  else
    echo "=== BATCH q$q-$e FAIL ==="; tail -20 "ph_b${q}_${e}.out"; exit 1
  fi
  q=$((e+1))
done
echo "=== PROD q$SQ..$LQ ALL DONE ==="
