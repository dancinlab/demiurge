#!/usr/bin/env bash
# LaRu3Si2 flat-band gate-check driver (run ON the vast pod).
# vc-relax -> patch celldm -> scf (nspin=2) -> bands -> harvest markers.
# Assumes micromamba qe env active (pw.x, bands.x on PATH) and CWD = deck dir.
set -uo pipefail
NP=${NP:-16}
log() { echo "[$(date +%H:%M:%S)] $*"; }

run_pw() { # in out np
  local in=$1 out=$2 np=${3:-$NP}
  log "pw.x -np $np -in $in -> $out"
  mpirun --allow-run-as-root -np "$np" pw.x -in "$in" > "$out" 2>&1
}

# --- 1. dry-run syntax check (d16) -------------------------------------------
log "=== d16 dry-run (electron_maxstep=1) ==="
sed 's/electron_maxstep = 400/electron_maxstep = 1/' scf.in > _dry.in
run_pw _dry.in _dry.out 4
if grep -qiE "Error in routine|%%%%%%" _dry.out; then
  log "DRY-RUN FAILED:"; grep -iE "Error in routine|%%%%%%" -A3 _dry.out | head -30; exit 11
fi
log "dry-run OK (no directive/pseudo errors)"
rm -f _dry.in; rm -rf out

# --- 2. vc-relax -------------------------------------------------------------
log "=== vc-relax ==="
run_pw vc-relax.in vc-relax.out
if ! grep -qi "End final coordinates\|JOB DONE" vc-relax.out; then
  log "VC-RELAX did not finish cleanly"; tail -40 vc-relax.out; exit 12
fi
# parse relaxed celldm: QE prints 'new lattice constant' / CELL_PARAMETERS; use a/c from final coords
log "vc-relax DONE. Relaxed cell markers:"
grep -iE "new unit-cell volume|CELL_PARAMETERS|lattice parameter|celldm" vc-relax.out | tail -10

# --- 3. patch scf.in/bands.in with relaxed celldm ----------------------------
# extract final celldm(1) (alat in bohr) and c/a from last CELL_PARAMETERS block
python3 - <<'PY'
import re,sys
t=open('vc-relax.out').read()
# alat (bohr): from "lattice parameter (alat)  =   X.XXXX  a.u." -- but vc-relax rescales; use final CELL_PARAMETERS (alat= ..)
blocks=re.findall(r'CELL_PARAMETERS \(alat=\s*([\d.]+)\)\s*\n\s*([-\d. \n]+?)\n\n', t)
if not blocks:
    blocks=re.findall(r'CELL_PARAMETERS \(alat=\s*([\d.]+)\)\s*\n((?:\s*[-\d.]+\s+[-\d.]+\s+[-\d.]+\s*\n){3})', t)
alat,vec=blocks[-1]
alat=float(alat)
rows=[list(map(float,r.split())) for r in vec.strip().split('\n')]
import math
a=math.sqrt(sum(x*x for x in rows[0]))*alat   # |v1| in bohr
c=math.sqrt(sum(x*x for x in rows[2]))*alat   # |v3| in bohr
coa=c/a
print(f"RELAXED celldm1_bohr={a:.5f} c_over_a={coa:.5f} a_Ang={a*0.529177:.4f} c_Ang={c*0.529177:.4f}")
open('_relaxed.env','w').write(f"A={a:.5f}\nCOA={coa:.5f}\nA_ANG={a*0.529177:.4f}\nC_ANG={c*0.529177:.4f}\n")
PY
source _relaxed.env
log "patching scf.in / bands.in: celldm(1)=$A celldm(3)=$COA"
for f in scf.in bands.in; do
  sed -i "s/celldm(1) = .*/celldm(1) = $A/" "$f"
  sed -i "s/celldm(3) = .*/celldm(3) = $COA/" "$f"
done

# --- 4. scf ------------------------------------------------------------------
log "=== scf (nspin=2) ==="
run_pw scf.in scf.out
grep -iE "the Fermi energy is|total magnetization|absolute magnetization|convergence has been achieved|JOB DONE" scf.out | tail -8
if ! grep -qi "JOB DONE" scf.out; then log "SCF FAILED"; tail -40 scf.out; exit 13; fi

# --- 5. bands ----------------------------------------------------------------
log "=== bands ==="
# if default david stalls on empty bands, fall back to diago_full_acc=.false.
run_pw bands.in bands.out 32
if ! grep -qi "JOB DONE" bands.out; then
  log "bands default stalled; retry diago_full_acc=.false. + conv 1e-6"
  sed 's/conv_thr = 1.0d-9/conv_thr = 1.0d-6\n  diago_full_acc = .false./' bands.in > bands_fa.in
  run_pw bands_fa.in bands.out 32
fi
grep -iE "the Fermi energy is|JOB DONE|highest occupied" bands.out | tail -5

log "=== ALL DONE. E_F + magnetization (scf.out):"
grep -iE "the Fermi energy is|total magnetization" scf.out | tail -4
