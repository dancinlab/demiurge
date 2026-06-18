#!/usr/bin/env bash
# pod2 shard launcher — regenerate SCF locally (deterministic · cheaper than a
# GB transfer over a flaky proxy) then run el-ph q7-12. Detaches via nohup.
set -uo pipefail
D=/root/laru3si2_444; MM=/root/bin/micromamba
cd "$D" || exit 2
RUN="$MM run -n qe"; export OMP_NUM_THREADS=1
MPI="$RUN mpirun -np 192 --allow-run-as-root --bind-to none"
if ! grep -qi "JOB DONE" scf.out 2>/dev/null; then
  echo "=== SCF (local regen) START $(date +%H:%M) ==="
  $MPI pw.x -npool 6 -in scf.in > scf.out 2>&1
  grep -qi "JOB DONE" scf.out || { echo "=== SCF_FAIL ==="; tail -15 scf.out; exit 1; }
  echo "=== SCF DONE $(date +%H:%M) ==="
fi
echo "=== launching el-ph q7-12 ==="
exec bash /root/run_prod.sh 7 12
