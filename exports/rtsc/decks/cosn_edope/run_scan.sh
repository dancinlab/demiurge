#!/usr/bin/env bash
# CoSn electron-doping scan driver — QE tot_charge jellium proxy.
# Δn ∈ {0.0,0.2,0.4,0.6}  → tot_charge = {0,-0.2,-0.4,-0.6}  (negative = ADD electrons).
# Each Δn: scf (nspin=2) → bands (Γ-K-M-Γ-A) → bands.x → flat-band ΔE + magnetization.
# Usage:  bash run_scan.sh [NPROC]   (run from the deck dir; pseudo/ + *.tmpl present)
set -u
NP="${1:-16}"
PWX="${PWX:-pw.x}"
BANDSX="${BANDSX:-bands.x}"
MPI="${MPI:-mpirun -np ${NP}}"
DOPINGS=("0.0:0.0" "0.2:-0.2" "0.4:-0.4" "0.6:-0.6")

run_one () {
  local dn="$1" totchg="$2"
  local d="dn_${dn}"
  echo "===== Δn=${dn}  tot_charge=${totchg}  ($(date)) ====="
  rm -rf "$d"; mkdir -p "$d"
  cp -r pseudo "$d/pseudo"
  sed "s/__TOTCHG__/${totchg}/" scf.in.tmpl   > "$d/scf.in"
  sed "s/__TOTCHG__/${totchg}/" bands.in.tmpl > "$d/bands.in"
  cat > "$d/bandsx.in" <<EOF
&bands
  prefix = 'cosn'
  outdir = './out'
  filband = 'cosn_bands.dat'
/
EOF
  ( cd "$d" || exit 1
    echo "--- scf Δn=${dn} ---"
    $MPI $PWX -in scf.in   > scf.out   2>&1
    echo "--- bands Δn=${dn} ---"
    $MPI $PWX -in bands.in > bands.out 2>&1
    echo "--- bands.x Δn=${dn} ---"
    $MPI $BANDSX -in bandsx.in > bandsx.out 2>&1
    grep -E "Fermi|total magnetization|JOB DONE|convergence has been" scf.out | tail -6
  )
}

if [ "${DRYRUN:-0}" = "1" ]; then
  # d16: 1-iter syntax/basis dry-run on Δn=0 only (cheap, catches directive/pseudo errors).
  echo "=== DRY-RUN (1 SCF iter, Δn=0) ==="
  rm -rf dryrun; mkdir -p dryrun; cp -r pseudo dryrun/pseudo
  sed "s/__TOTCHG__/0.0/" scf.in.tmpl | sed 's/electron_maxstep = 400/electron_maxstep = 1/' > dryrun/scf.in
  ( cd dryrun && $MPI $PWX -in scf.in > scf.out 2>&1; tail -25 scf.out )
  exit 0
fi

for pair in "${DOPINGS[@]}"; do
  run_one "${pair%%:*}" "${pair##*:}"
done
echo "=== SCAN COMPLETE ($(date)) ==="
