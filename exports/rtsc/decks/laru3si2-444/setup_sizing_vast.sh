#!/usr/bin/env bash
# LaRu3Si2 4x4x4 sizing on a vast pod (root, micromamba qe env). Self-detaching.
# SCF (fresh) -> ph.x init (prints the full irreducible q-list = sharding size)
#             -> d16 dry-run (q1 irr1 only).
D=/root/laru3si2_444
MM=/root/bin/micromamba
if [ "${BG:-}" != "1" ]; then
  cd "$D" || exit 2
  BG=1 nohup bash "$0" > sizing.log 2>&1 &
  echo "launched sizing pid=$!"
  exit 0
fi
set -uo pipefail
cd "$D" || exit 2
RUN="$MM run -n qe"
export OMP_NUM_THREADS=1
NP=$(nproc); [ "$NP" -gt 8 ] && NP=8
MPI="$RUN mpirun -np $NP --allow-run-as-root --bind-to none"

echo "=== 1. SCF ==="
rm -rf out
$MPI pw.x -in scf.in > scf.out 2>&1
if ! grep -qi "JOB DONE" scf.out; then echo "SCF FAILED"; tail -30 scf.out; exit 13; fi
grep -iE "Fermi energy|convergence has been achieved" scf.out | tail -2

echo "=== 2. ph.x 4x4x4 init + d16 dry-run ==="
sed -e 's/^  ! start_q.*/  start_q = 1/' -e 's/^  ! last_q.*/  last_q = 1/' ph.in > ph_dry.in
sed -i 's/^  trans = .true./  start_irr = 1\n  last_irr = 1\n  trans = .true./' ph_dry.in
$MPI ph.x -in ph_dry.in > ph_dry.out 2>&1
if grep -qiE "Error in routine|%%%%%%" ph_dry.out; then
  echo "DRY-RUN FAILED:"; grep -iE "Error in routine|%%%%%%" -A4 ph_dry.out | head -30; exit 21
fi
echo "OK no errors"
echo "--- irreducible q-list ---"
grep -iE "Dynamical matrices for|uniform grid of q-points|Calculation of q" ph_dry.out | head -40
echo "=== DONE ==="
