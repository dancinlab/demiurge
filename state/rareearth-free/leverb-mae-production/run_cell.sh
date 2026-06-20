#!/usr/bin/env bash
# Force-theorem MAE driver for ONE cell dir. Detached-safe (called under nohup).
# Usage: NP=4 ./run_cell.sh <celldir>
# Stage1 = SCF (noncolin+SOC, M||001) → converged charge density.
# Stage2 = two nscf single-shot band energies (M||001, M||100) reusing density.
# K1 = (E100 - E001) / V_cell.
set -uo pipefail
source ~/miniforge3/etc/profile.d/conda.sh
conda activate qe
NP="${NP:-4}"
CELL="$1"
cd "$CELL" || { echo "NO_DIR $CELL"; exit 2; }
echo "=== CELL $CELL  NP=$NP  $(date) ==="

run(){
  local inf="$1"
  echo "== pw.x < $inf  $(date +%H:%M:%S) =="
  # bind-none / oversubscribe friendly for a loaded shared host
  mpirun --oversubscribe -np "$NP" pw.x -in "$inf" > "${inf%.in}.out" 2>&1
  local rc=$?
  if [ $rc -ne 0 ]; then echo "FAIL($rc) $inf"; tail -25 "${inf%.in}.out"; return $rc; fi
}

run scf.in || { echo "SCF_FAIL"; exit 3; }
# SCF convergence guard (d6: never proceed on an unconverged density)
if ! grep -q "convergence has been achieved" scf.out; then
  echo "SCF_NOT_CONVERGED"; grep -E "iteration #|estimated scf accuracy" scf.out | tail -4; exit 4
fi
echo "SCF_CONVERGED"
grep "total magnetization" scf.out | tail -1
grep "absolute magnetization" scf.out | tail -1

run nscf_001.in || { echo "NSCF001_FAIL"; exit 5; }
run nscf_100.in || { echo "NSCF100_FAIL"; exit 6; }

# Force-theorem band energies: use the one-electron + band sum. For a single-shot
# nscf the printed '!' total energy is the force-theorem energy at fixed density.
E001=$(grep '^!' nscf_001.out | tail -1 | awk '{print $5}')
E100=$(grep '^!' nscf_100.out | tail -1 | awk '{print $5}')
echo "E001_Ry=$E001"
echo "E100_Ry=$E100"
V=$(cat VOL_A3)
python3 - "$E001" "$E100" "$V" <<'PY'
import sys
Ry2J=2.1798723611035e-18
e001=float(sys.argv[1]); e100=float(sys.argv[2]); V_A3=float(sys.argv[3])
mae_ry=e100-e001
mae_meV=mae_ry*13605.693
V_m3=V_A3*1e-30
K1=(mae_ry*Ry2J)/V_m3
print(f"MAE_meV_per_cell={mae_meV:.4f}")
print(f"V_A3={V_A3:.4f}")
print(f"K1_MJ_per_m3={K1/1e6:.4f}")
print(f"GATE_3MJ={'PASS_GE3' if K1/1e6>=3.0 else 'FAIL_LT3'}")
PY
echo "=== DONE $CELL  $(date) ==="
