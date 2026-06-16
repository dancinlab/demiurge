#!/usr/bin/env bash
# LaOs3Si2 DFPT electron-phonon driver (run ON summer FREE pool, CWD = deck dir).
# Pipeline: scf (nspin=1 NM, dense 12^3 k) -> ph.x d16 dry-run -> ph.x el-ph
#           (electron_phonon='simple', 2x2x2 q, 16^3 fine k) -> q2r -> matdyn
#           (asr='crystal' STABILITY PRECHECK: imaginary modes?) -> lambda.x (Allen-Dynes Tc).
# Mirrors the LaRu3Si2 recipe. summer is FREE (no GPU rent). Self-logging via the fire wrapper.
set -uo pipefail
QE=/home/summer/micromamba/envs/qe/bin
export OMP_NUM_THREADS=1
NP=${NP:-6}
MPI="$QE/mpirun -np $NP --bind-to none"
log() { echo "[$(date +%H:%M:%S)] $*"; }

run_pw() { local in=$1 out=$2; log "pw.x -in $in -> $out"; $MPI $QE/pw.x -in "$in" > "$out" 2>&1; }
run_ph() { local in=$1 out=$2; log "ph.x -in $in -> $out"; $MPI $QE/ph.x -in "$in" > "$out" 2>&1; }

# --- 1. scf (nspin=1, dense 12x12x12, conv 1e-12) -----------------------------
log "=== scf (nspin=1, NM, 12x12x12) ==="
rm -rf out
run_pw scf.in scf.out
if ! grep -qi "JOB DONE" scf.out; then log "SCF FAILED"; tail -40 scf.out; exit 13; fi
grep -iE "the Fermi energy is|convergence has been achieved|total magnetization" scf.out | tail -4

# --- 2. ph.x dry-run (d16): only Gamma, 1 irrep, catch directive errors -------
log "=== ph.x d16 dry-run (Gamma, start_irr=last_irr=1) ==="
cat > ph_dry.in <<'EOF'
LaOs3Si2 ph dry-run
&inputph
  prefix = 'laos3si2'
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
run_ph ph_dry.in ph_dry.out
if grep -qiE "Error in routine|%%%%%%" ph_dry.out; then
  log "DRY-RUN FAILED:"; grep -iE "Error in routine|%%%%%%" -A4 ph_dry.out | head -40; exit 21
fi
log "ph dry-run OK. Resetting _ph0 for clean full el-ph run."
rm -f dry.dyn* 2>/dev/null
rm -rf out/_ph0 2>/dev/null

# --- 3. full el-ph (electron_phonon='simple', 2x2x2 q, 16^3 fine k) -----------
log "=== ph.x FULL el-ph (electron_phonon=simple, 2x2x2 q) ==="
run_ph ph.in ph_elph.out
if ! grep -qi "JOB DONE" ph_elph.out; then
  log "PH el-ph did not finish; tail:"; tail -60 ph_elph.out
fi
log "--- per-q lambda markers (ph_elph.out) ---"
grep -iE "lambda|el-ph|DOS =|double delta|Gaussian Broadening" ph_elph.out | head -60
ls -la *.dyn* elph_dir/ a2F* 2>/dev/null

# --- 4. q2r: real-space IFCs from the 2x2x2 dyn set ---------------------------
log "=== q2r (dyn -> IFC) ==="
cat > q2r.in <<'EOF'
&input
  fildyn = 'laos3si2.dyn'
  zasr = 'crystal'
  flfrc = 'laos3si2.fc'
/
EOF
$QE/q2r.x < q2r.in > q2r.out 2>&1
grep -iE "JOB DONE|Error" q2r.out | tail -3

# --- 5. matdyn STABILITY PRECHECK: asr='crystal' on the q-grid -> imaginary? --
# CRITICAL (d6 / ARCHITECTURE; lesson from ScH9/YH6): confirm NO hard imaginary
# modes before trusting lambda/Tc. We evaluate at the 2x2x2 commensurate q-set.
log "=== matdyn STABILITY PRECHECK (asr=crystal) ==="
cat > matdyn_stab.in <<'EOF'
&input
  asr = 'crystal'
  flfrc = 'laos3si2.fc'
  flfrq = 'laos3si2.freq'
  q_in_band_form = .false.
  q_in_cryst_coord = .true.
/
8
0.0 0.0 0.0
0.5 0.0 0.0
0.0 0.5 0.0
0.0 0.0 0.5
0.5 0.5 0.0
0.5 0.0 0.5
0.0 0.5 0.5
0.5 0.5 0.5
EOF
$QE/matdyn.x < matdyn_stab.in > matdyn_stab.out 2>&1
grep -iE "JOB DONE|Error" matdyn_stab.out | tail -3
log "--- frequencies (cm-1) at the commensurate q-set (negative = imaginary = UNSTABLE) ---"
# matdyn writes freqs to laos3si2.freq as omega(cm-1); scan for any negative.
if [ -f laos3si2.freq ]; then
  awk 'NR>1{for(i=1;i<=NF;i++) if($i+0==$i) print $i}' laos3si2.freq | sort -n | head -20
  NIMAG=$(awk 'NR>1{for(i=1;i<=NF;i++) if(($i+0==$i)&&($i< -1.0)) c++} END{print c+0}' laos3si2.freq)
  log "STABILITY: $NIMAG mode-values below -1 cm-1 (imaginary). 0 => DYNAMICALLY STABLE; >0 => UNSTABLE, do NOT trust Tc."
else
  log "STABILITY: laos3si2.freq MISSING -- matdyn precheck did not produce freqs."
fi

# --- 6. lambda.x : Allen-Dynes Tc from the a2F (only meaningful if stable) ----
# Build lambda.x input from the el-ph elph.inp_lambda files emitted by ph.x.
log "=== lambda.x (Allen-Dynes Tc) ==="
if ls elph_dir/elph.inp_lambda.* >/dev/null 2>&1 || ls elph.inp_lambda.* >/dev/null 2>&1; then
  log "el-ph lambda input files present; assemble lambda.in per QE la2F docs (mu*=0.10 and 0.13)."
  ls -la elph_dir/ elph.inp_lambda.* 2>/dev/null
  log "NOTE: lambda.x assembly is harvest-step (needs the per-q omega + DOS header). Defer to harvester."
else
  log "no elph.inp_lambda.* yet -- el-ph may be partial; harvest after JOB DONE."
fi

log "=== run_elph.sh DONE ==="
