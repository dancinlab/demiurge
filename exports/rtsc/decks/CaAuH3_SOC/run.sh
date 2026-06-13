#!/usr/bin/env bash
# CaAuH3 SOC full-rel Au campaign — vc-relax → scf → ph (electron_phonon='simple')
# falsifier: Tc shift < 5K vs scalar baseline → 5d SOC 무영향 확정
# d17 autonomous · cost-bearing fire

set -uo pipefail

WORK=/home/aiden/rtsc_caauh3_soc
mkdir -p "$WORK/out" "$WORK/pseudo"
cd "$WORK"

# Stage decks
cp /root/caauh3_soc/*.in "$WORK/" 2>/dev/null || cp ~/caauh3_soc/*.in "$WORK/" 2>/dev/null

# Pseudo staging — PSL 1.0.0 (full-rel for Au)
PSL_BASE="https://pseudopotentials.quantum-espresso.org/upf_files"
cd "$WORK/pseudo"
for f in Ca.pbe-spn-rrkjus_psl.1.0.0.UPF Au.rel-pbe-n-rrkjus_psl.1.0.0.UPF H.pbe-rrkjus_psl.1.0.0.UPF; do
  if [[ ! -f "$f" ]]; then
    wget -q "$PSL_BASE/$f" || curl -sLO "$PSL_BASE/$f" || echo "MISSING_PSEUDO=$f"
  fi
done
ls -la "$WORK/pseudo" > "$WORK/pseudo_check.log"

cd "$WORK"

# Source QE env (pool/cloud detached env loss — reference reference_detached_remote_env_loss)
source /etc/profile.d/conda.sh 2>/dev/null || true
conda activate qe 2>/dev/null || true
which pw.x ph.x >> "$WORK/run.log" 2>&1

NCORES=$(nproc)
NPROC=$((NCORES > 8 ? 8 : NCORES))

echo "=== START $(date -u) ===" >> "$WORK/run.log"

# Step 1: vc-relax
echo "[vc-relax] start $(date -u)" >> "$WORK/run.log"
timeout 21600 mpirun -np $NPROC pw.x -in vc-relax.in > vc-relax.out 2>&1
RC_VC=$?
echo "[vc-relax] rc=$RC_VC $(date -u)" >> "$WORK/run.log"
grep -E "Final|JOB DONE|convergence NOT" vc-relax.out | tail -20 >> "$WORK/run.log"

if [[ $RC_VC -ne 0 ]] && ! grep -q "JOB DONE" vc-relax.out; then
  echo "[vc-relax] FAIL — aborting chain" >> "$WORK/run.log"
  exit 1
fi

# Extract relaxed celldm + ATOMIC_POSITIONS into scf.in / ph.in
python3 - <<'PYEOF' >> "$WORK/run.log" 2>&1
import re, pathlib
out = pathlib.Path("vc-relax.out").read_text()
# Last CELL_PARAMETERS (alat)
m = re.findall(r"CELL_PARAMETERS \(alat=\s*([\d.]+)\)", out)
if m:
    new_alat = float(m[-1])
    print(f"[patch] relaxed celldm(1)={new_alat}")
    for fn in ("scf.in", "ph.in"):
        if pathlib.Path(fn).exists():
            txt = pathlib.Path(fn).read_text()
            txt = re.sub(r"celldm\(1\)\s*=\s*[\d.]+", f"celldm(1) = {new_alat}", txt)
            pathlib.Path(fn).write_text(txt)
else:
    print("[patch] no CELL_PARAMETERS — using start guess")
PYEOF

# Step 2: scf
echo "[scf] start $(date -u)" >> "$WORK/run.log"
timeout 14400 mpirun -np $NPROC pw.x -in scf.in > scf.out 2>&1
RC_SCF=$?
echo "[scf] rc=$RC_SCF $(date -u)" >> "$WORK/run.log"
grep -E "JOB DONE|convergence NOT|total energy" scf.out | tail -10 >> "$WORK/run.log"

if [[ $RC_SCF -ne 0 ]] && ! grep -q "JOB DONE" scf.out; then
  echo "[scf] FAIL — aborting chain" >> "$WORK/run.log"
  exit 2
fi

# Step 3: ph + el-ph
echo "[ph] start $(date -u)" >> "$WORK/run.log"
timeout 86400 mpirun -np $NPROC ph.x -in ph.in > ph.out 2>&1
RC_PH=$?
echo "[ph] rc=$RC_PH $(date -u)" >> "$WORK/run.log"
grep -E "JOB DONE|lambda|omega_log" ph.out | tail -30 >> "$WORK/run.log"

echo "=== END $(date -u) rc=$RC_PH ===" >> "$WORK/run.log"
