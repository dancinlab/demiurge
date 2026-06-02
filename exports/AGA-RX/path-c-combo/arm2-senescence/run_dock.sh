#!/usr/bin/env bash
# AGA-RX PATH C · ARM 2 — senescence-clearance docking.
# PRIMARY  : BCL-xL BH3-groove senolytic screen (3ZLR / WEHI-539 pocket).
# OPTIONAL : FKBP12 rapalog autophagy-restore screen (1FAP; FKBP12-binding step
#            only — see vina_dock_fkbp12.conf mechanism caveat). Toggle RUN_FKBP12.
# Run on any host with conda (pool ubu-1/2 free per d7, or a Vast.ai CPU box).
set -euo pipefail
cd "$(dirname "$0")"
RUN_FKBP12="${RUN_FKBP12:-1}"   # set 0 to skip the optional mTOR arm

# ---- 0. environment (one-time) -------------------------------------------
# conda create -y -n dock python=3.11
# conda activate dock
# conda install -y -c conda-forge vina openbabel rdkit meeko
#   (alt: smina single-binary -> https://sourceforge.net/projects/smina/)

dock_set () {  # $1=conf $2=smi $3=tag
  local conf="$1" smi="$2" tag="$3" base dg
  mkdir -p "ligands_${tag}" "out_${tag}"
  local i=0
  while IFS=$'\t' read -r s name rest; do
    [[ "$s" =~ ^#|^$ ]] && continue
    i=$((i+1))
    echo "$s" | obabel -ismi -O "ligands_${tag}/${name}.pdbqt" --gen3d -p 7.4 2>/dev/null
  done < "$smi"
  echo "[$tag] prepared $i ligands"
  : > "results_${tag}.tsv"
  for lig in "ligands_${tag}"/*.pdbqt; do
    base=$(basename "$lig" .pdbqt)
    vina --config "$conf" --ligand "$lig" --out "out_${tag}/${base}_docked.pdbqt" > "out_${tag}/${base}.log" 2>&1
    dg=$(awk '/^   1 /{print $2; exit}' "out_${tag}/${base}_docked.pdbqt" 2>/dev/null \
         || grep -m1 -E '^\s+1\s' "out_${tag}/${base}.log" | awk '{print $2}')
    printf '%s\t%s\n' "$base" "${dg:-NA}" | tee -a "results_${tag}.tsv"
  done
  echo "=== [$tag] ranked by ΔG (most negative = best) ==="
  sort -k2 -n "results_${tag}.tsv"
}

# ---- 1. receptor prep -> PDBQT (polar H, Gasteiger, pH 7.4, rigid) -------
obabel bclxl_chainA_receptor.pdb  -O bclxl_chainA_receptor.pdbqt  -xr -p 7.4
[[ "$RUN_FKBP12" == 1 ]] && obabel fkbp12_chainA_receptor.pdb -O fkbp12_chainA_receptor.pdbqt -xr -p 7.4

# ---- 2+3. PRIMARY BCL-xL senolytic screen --------------------------------
dock_set vina_dock_bclxl.conf candidates_bclxl.smi bclxl

# ---- OPTIONAL FKBP12 rapalog screen --------------------------------------
if [[ "$RUN_FKBP12" == 1 ]]; then
  dock_set vina_dock_fkbp12.conf candidates_fkbp12.smi fkbp12
fi
