#!/usr/bin/env bash
# Force-theorem MAE driver (QE noncollinear + SOC) — toolgap-fill PROOF deck.
# MAE = E(M||100) - E(M||001).  K1 = MAE / V_cell.
# Stage1 = converge charge density (scalar SCF w/ SOC machinery on).
# Stage2 = two force-theorem single-shot diagonalizations at the two axes.
set -euo pipefail
source ~/miniforge3/etc/profile.d/conda.sh
conda activate qe
NP="${NP:-8}"
run(){ echo "== pw.x < $1 =="; mpirun -np "$NP" pw.x -in "$1" > "${1%.in}.out" 2>&1 || { echo "FAIL $1"; tail -30 "${1%.in}.out"; exit 1; }; }

run scf.in
# force theorem: reuse scf charge density (startingpot=file) at each axis
run nscf_001.in
run nscf_100.in

E001=$(grep '!' nscf_001.out | tail -1 | awk '{print $5}')
E100=$(grep '!' nscf_100.out | tail -1 | awk '{print $5}')
echo "E(001)=$E001 Ry   E(100)=$E100 Ry"
python3 - "$E001" "$E100" <<'PY'
import sys
Ry2J=2.1798723611035e-18
e001,e100=float(sys.argv[1]),float(sys.argv[2])
mae_ry=e100-e001
V=2.866e-10**3   # m^3 (bcc 2-atom conventional cube here; replace per-cell)
mae_J=mae_ry*Ry2J
K1=mae_J/V
print(f"MAE = {mae_ry*13605.7:.3f} meV/cell   K1 = {K1/1e6:.3f} MJ/m^3")
PY
