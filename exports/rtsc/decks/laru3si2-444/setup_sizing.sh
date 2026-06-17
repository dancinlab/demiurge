#!/usr/bin/env bash
# LaRu3Si2 4x4x4 sizing + d16 free dry-run on summer (FREE pool).
# SCF (fresh) -> ph.x init (prints the full irreducible q-list = sharding size)
#             -> d16 dry-run (q1 irr1 only, catches deck/basis errors before paid rent).
D=/home/summer/laru3si2_444
# self-detach: launch via `bash <abspath>` (simple argv, no mangling); re-exec in background.
if [ "${BG:-}" != "1" ]; then
  cd "$D" || exit 2
  BG=1 nohup bash "$0" > sizing.log 2>&1 &
  echo "launched sizing pid=$!"
  exit 0
fi
set -uo pipefail
QE=/home/summer/micromamba/envs/qe/bin
cd "$D" || { echo "no deck dir"; exit 2; }
export OMP_NUM_THREADS=1
MPI="$QE/mpirun -np 6 --bind-to none"

echo "=== 1. SCF (nspin=1, fresh) ==="
rm -rf out
$MPI $QE/pw.x -in scf.in > scf.out 2>&1
if ! grep -qi "JOB DONE" scf.out; then echo "SCF FAILED"; tail -30 scf.out; exit 13; fi
grep -iE "Fermi energy|convergence has been achieved" scf.out | tail -2

echo "=== 2. ph.x 4x4x4 init + d16 dry-run (start_q=last_q=1, start_irr=last_irr=1) ==="
sed -e 's/^  ! start_q.*/  start_q = 1/' -e 's/^  ! last_q.*/  last_q = 1/' ph.in > ph_dry.in
# add irr bounds for a true 1-rep dry-run
sed -i 's/^  trans = .true./  start_irr = 1\n  last_irr = 1\n  trans = .true./' ph_dry.in
$MPI $QE/ph.x -in ph_dry.in > ph_dry.out 2>&1
echo "--- error check (d16) ---"
if grep -qiE "Error in routine|%%%%%%" ph_dry.out; then
  echo "DRY-RUN FAILED:"; grep -iE "Error in routine|%%%%%%" -A4 ph_dry.out | head -30; exit 21
fi
echo "OK no errors"
echo "--- irreducible q-list (sharding size) ---"
grep -iE "Dynamical matrices for|q-points|^ *q = \(|Calculation of q" ph_dry.out | head -80
echo "--- total q count ---"
grep -icE "q = \(" ph_dry.out
echo "=== DONE ==="
