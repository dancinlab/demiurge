#!/usr/bin/env bash
# LaRu3Si2 4x4x4 sizing — FOREGROUND (no self-detach; output captured directly).
set -uo pipefail
D=/root/laru3si2_444; MM=/root/bin/micromamba
cd "$D" || { echo "NO_DECK_DIR"; exit 2; }
RUN="$MM run -n qe"; export OMP_NUM_THREADS=1
NP=$(nproc); [ "$NP" -gt 8 ] && NP=8
MPI="$RUN mpirun -np $NP --allow-run-as-root --bind-to none"
echo "=== ENV: nproc=$(nproc) pw.x=$($MM run -n qe which pw.x 2>/dev/null) ==="
echo "=== 1. SCF ==="
rm -rf out
$MPI pw.x -in scf.in > scf.out 2>&1
echo "SCF rc=$? lines=$(wc -l < scf.out)"
if ! grep -qi "JOB DONE" scf.out; then echo "SCF_FAIL — tail:"; tail -20 scf.out; exit 13; fi
grep -iE "Fermi energy|convergence has been achieved" scf.out | tail -2
echo "=== 2. ph.x 4x4x4 init + d16 dry-run (q1 irr1) ==="
sed -e 's/^  ! start_q.*/  start_q = 1/' -e 's/^  ! last_q.*/  last_q = 1/' ph.in > ph_dry.in
sed -i 's/^  trans = .true./  start_irr = 1\n  last_irr = 1\n  trans = .true./' ph_dry.in
$MPI ph.x -in ph_dry.in > ph_dry.out 2>&1
echo "ph rc=$? lines=$(wc -l < ph_dry.out)"
if grep -qiE "Error in routine|%%%%%%" ph_dry.out; then echo "DRY_FAIL:"; grep -iE "Error in routine|%%%%" -A3 ph_dry.out | head -20; exit 21; fi
echo "--- irreducible q-list ---"
grep -iE "Dynamical matrices for|uniform grid of q-points|Calculation of q" ph_dry.out | head -40
echo "=== DONE ==="
