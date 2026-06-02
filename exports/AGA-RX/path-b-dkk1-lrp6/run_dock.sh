#!/usr/bin/env bash
# AGA-RX PATH B — ready-to-run AutoDock Vina fragment screen against LRP6 PE3 pocket
# Run on any host with conda (pool ubu-1/2 free, or a Vast.ai CPU box per d7).
set -euo pipefail
cd "$(dirname "$0")"

# ---- 0. environment (one-time) -------------------------------------------
# conda create -y -n dock python=3.11
# conda activate dock
# conda install -y -c conda-forge vina openbabel rdkit meeko
#   (alt: smina single-binary -> https://sourceforge.net/projects/smina/)

# ---- 1. receptor prep: LRP6 chain A -> PDBQT ------------------------------
# add polar H, Gasteiger charges, rigid receptor
obabel lrp6_chainA_receptor.pdb -O lrp6_chainA_receptor.pdbqt -xr -p 7.4

# ---- 2. ligand prep: each fragment SMILES -> 3D protonated PDBQT ----------
mkdir -p ligands out
i=0
while IFS=$'\t' read -r smi name rest; do
  [[ "$smi" =~ ^#|^$ ]] && continue
  i=$((i+1))
  echo "$smi" | obabel -ismi -O "ligands/${name}.pdbqt" --gen3d -p 7.4 2>/dev/null
done < fragments.smi
echo "prepared $i ligands"

# ---- 3. dock each ligand into the PE3 pocket ------------------------------
: > results.tsv
for lig in ligands/*.pdbqt; do
  base=$(basename "$lig" .pdbqt)
  vina --config vina_dock.conf --ligand "$lig" --out "out/${base}_docked.pdbqt" > "out/${base}.log" 2>&1
  # top mode affinity (kcal/mol)
  dg=$(awk '/^   1 /{print $2; exit}' "out/${base}_docked.pdbqt" 2>/dev/null || \
       grep -m1 -E '^\s+1\s' "out/${base}.log" | awk '{print $2}')
  printf '%s\t%s\n' "$base" "${dg:-NA}" | tee -a results.tsv
done

echo "=== TOP ΔG (kcal/mol), most negative = best ==="
sort -k2 -n results.tsv
