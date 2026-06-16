#!/usr/bin/env bash
# LaRu3Si2 DFPT electron-phonon driver (run ON the vast pod).
# scf (nspin=1, NM) -> ph.x dry-run (d16) -> ph.x el-ph (electron_phonon='simple', 2x2x2 q) -> harvest lambda.
# Assumes micromamba qe env active (pw.x, ph.x on PATH) and CWD = deck dir.
set -uo pipefail
NP=${NP:-16}
log() { echo "[$(date +%H:%M:%S)] $*"; }

run_pw() { local in=$1 out=$2 np=${3:-$NP}; log "pw.x -np $np -in $in -> $out"; mpirun --allow-run-as-root -np "$np" pw.x -in "$in" > "$out" 2>&1; }
run_ph() { local in=$1 out=$2 np=${3:-$NP}; log "ph.x -np $np -in $in -> $out"; mpirun --allow-run-as-root -np "$np" ph.x -in "$in" > "$out" 2>&1; }

# --- 1. scf (nspin=1, dense 12x12x12, conv 1e-12) -----------------------------
log "=== scf_elph (nspin=1, NM) ==="
rm -rf out
run_pw scf_elph.in scf_elph.out
if ! grep -qi "JOB DONE" scf_elph.out; then log "SCF FAILED"; tail -40 scf_elph.out; exit 13; fi
grep -iE "the Fermi energy is|total magnetization|convergence has been achieved" scf_elph.out | tail -4
# capture DOS at E_F (printed by ph.x later; also dump here for record)
grep -iE "the Fermi energy is" scf_elph.out | tail -1

# --- 2. ph.x dry-run (d16): only Gamma, 1 irrep, catch directive errors -------
log "=== ph.x d16 dry-run (Gamma, start_irr=last_irr=1, ldisp off) ==="
cat > ph_dry.in <<'EOF'
LaRu3Si2 ph dry-run
&inputph
  prefix = 'laru3si2'
  outdir = './out'
  fildyn = 'dry.dyn'
  trans = .true.
  tr2_ph = 1.0d-14
  start_irr = 1
  last_irr = 1
  nat_todo = 0
/
0.0 0.0 0.0
EOF
run_ph ph_dry.in ph_dry.out 4
if grep -qiE "Error in routine|%%%%%%" ph_dry.out; then
  log "DRY-RUN FAILED:"; grep -iE "Error in routine|%%%%%%" -A4 ph_dry.out | head -40; exit 21
fi
log "ph dry-run OK (directives/pseudo/wfc valid). Resetting for full el-ph."
# remove the partial dry-run phonon recover/save so the full run starts clean
rm -f dry.dyn* _ph0/*.recover* 2>/dev/null
rm -rf out/_ph0 2>/dev/null
# re-run scf to guarantee a clean wfc (dry-run may have touched _ph0 only; scf wfc intact, but be safe)

# --- 3. full el-ph (electron_phonon='simple', 2x2x2 q, 16^3 fine k) -----------
log "=== ph.x FULL el-ph (electron_phonon=simple, 2x2x2 q) ==="
run_ph ph.in ph_elph.out
if ! grep -qi "JOB DONE" ph_elph.out; then
  log "PH el-ph did not finish; tail:"; tail -60 ph_elph.out
  # don't exit -- partial per-q output may still be harvestable
fi

# --- 4. harvest --------------------------------------------------------------
log "=== HARVEST: lambda / a2F markers ==="
log "--- per-q lambda (from ph_elph.out) ---"
grep -iE "lambda|el-ph|broadening|DOS =|double delta|Gaussian Broadening" ph_elph.out | head -60
log "--- elph / a2F / dyn files present ---"
ls -la *.dyn* elph_dir/ a2F* lambda* 2>/dev/null
ls -la elph.inp_lambda* a2Fmatdyn* 2>/dev/null
log "--- imaginary (negative) frequencies check across dyn files ---"
grep -iE "freq|omega" *.dyn* 2>/dev/null | grep -iE "\-[0-9]" | head -20 || log "no obvious negative freqs in dyn"
log "=== run_elph.sh DONE ==="
