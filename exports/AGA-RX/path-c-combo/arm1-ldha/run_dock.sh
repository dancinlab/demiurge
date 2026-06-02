#!/usr/bin/env bash
# AGA-RX PATH C · ARM 1 — LDHA-selective docking + LDHB counter-screen.
# Docks every candidate vs BOTH LDHA (6Q0D) and LDHB (1I0Z), then reports the
# selectivity gap = dG_LDHA - dG_LDHB (a MORE-NEGATIVE LDHA and a NEGATIVE gap
# = LDHA-selective, the PATH C metabolic thesis).
# Run on any host with conda (pool ubu-1/2 free per d7, or a Vast.ai CPU box).
set -euo pipefail
cd "$(dirname "$0")"

# ---- 0. environment (one-time) -------------------------------------------
# conda create -y -n dock python=3.11
# conda activate dock
# conda install -y -c conda-forge vina openbabel rdkit meeko
#   (alt: smina single-binary -> https://sourceforge.net/projects/smina/)

# ---- 1. receptor prep: LDHA + LDHB chain A -> PDBQT ----------------------
# add polar H, Gasteiger charges at pH 7.4, rigid receptor
obabel ldha_chainA_receptor.pdb -O ldha_chainA_receptor.pdbqt -xr -p 7.4
obabel ldhb_chainA_receptor.pdb -O ldhb_chainA_receptor.pdbqt -xr -p 7.4

# ---- 2. ligand prep: each candidate SMILES -> 3D protonated PDBQT --------
mkdir -p ligands out_ldha out_ldhb
i=0
while IFS=$'\t' read -r smi name rest; do
  [[ "$smi" =~ ^#|^$ ]] && continue
  i=$((i+1))
  echo "$smi" | obabel -ismi -O "ligands/${name}.pdbqt" --gen3d -p 7.4 2>/dev/null
done < candidates.smi
echo "prepared $i ligands"

dock_one () {  # $1=conf $2=outdir $3=lig
  local conf="$1" od="$2" lig="$3" base
  base=$(basename "$lig" .pdbqt)
  vina --config "$conf" --ligand "$lig" --out "${od}/${base}_docked.pdbqt" > "${od}/${base}.log" 2>&1
  awk '/^   1 /{print $2; exit}' "${od}/${base}_docked.pdbqt" 2>/dev/null \
    || grep -m1 -E '^\s+1\s' "${od}/${base}.log" | awk '{print $2}'
}

# ---- 3. dock vs LDHA and vs LDHB, compute selectivity gap ----------------
printf 'ligand\tdG_LDHA\tdG_LDHB\tgap(LDHA-LDHB)\n' > selectivity.tsv
for lig in ligands/*.pdbqt; do
  base=$(basename "$lig" .pdbqt)
  a=$(dock_one vina_dock_ldha.conf out_ldha "$lig"); a=${a:-NA}
  b=$(dock_one vina_dock_ldhb.conf out_ldhb "$lig"); b=${b:-NA}
  if [[ "$a" != NA && "$b" != NA ]]; then
    gap=$(awk -v x="$a" -v y="$b" 'BEGIN{printf "%.2f", x-y}')
  else gap=NA; fi
  printf '%s\t%s\t%s\t%s\n' "$base" "$a" "$b" "$gap" | tee -a selectivity.tsv
done

echo "=== ranked by LDHA affinity (most negative dG_LDHA first) ==="
( head -1 selectivity.tsv; tail -n +2 selectivity.tsv | sort -k2 -n )
echo "=== ranked by SELECTIVITY gap (most negative gap = most LDHA-selective) ==="
( head -1 selectivity.tsv; tail -n +2 selectivity.tsv | sort -k4 -n )
