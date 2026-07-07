#!/usr/bin/env bash
# SENOLYX OA-cartilage Step4 — batch dock ligands.smi + anchors vs 5SYN(APT2), apply gate.
# Validation redock already PASSED (ML349 RMSD 0.46A, aff -13.1). Prep trusted.
set -u
D=/Users/mini/miniforge3/envs/dock/bin
cd "$(dirname "$0")"
mkdir -p poses
RES=dock_results.tsv
: > "$RES"
printf "ID\tsmiles\taffinity\tnet_charge\n" >> "$RES"

dock_one() {  # id  smiles
  local id="$1" smi="$2"
  $D/obabel -:"$smi" --gen3d -p 7.4 -O "poses/${id}_lig.pdbqt" >/dev/null 2>&1
  [ -s "poses/${id}_lig.pdbqt" ] || { printf "%s\t%s\tPREP_FAIL\tNA\n" "$id" "$smi" >>"$RES"; return; }
  local q; q=$($D/python -c "
from rdkit import Chem
m=Chem.MolFromSmiles('$smi')
print(Chem.GetFormalCharge(m) if m else 'NA')" 2>/dev/null)
  $D/smina -r receptor.pdbqt -l "poses/${id}_lig.pdbqt" \
    --autobox_ligand ml349_xtalA.pdb --autobox_add 8 \
    --exhaustiveness 16 --num_modes 5 --seed 0 \
    -o "poses/${id}_out.pdbqt" --cpu 4 2>/dev/null
  local aff; aff=$(grep -m1 "REMARK minimizedAffinity" "poses/${id}_out.pdbqt" 2>/dev/null | awk '{print $3}')
  [ -z "$aff" ] && aff=$($D/python -c "
import re
for l in open('poses/${id}_out.pdbqt'):
    if l.startswith('REMARK VINA RESULT') or 'minimizedAffinity' in l:
        print(re.findall(r'-?\d+\.\d+',l)[0]); break" 2>/dev/null)
  printf "%s\t%s\t%s\t%s\n" "$id" "$smi" "${aff:-NA}" "${q:-NA}" >> "$RES"
  echo "  $id  aff=${aff:-NA}  q=${q:-NA}"
}

# anchors (real, from pubchem — method validation)
dock_one ML349_real "COC1=CC=C(C=C1)N2CCN(CC2)C(=O)C3=CC4=C(S3)C5=CC=CC=C5S(=O)(=O)C4"
dock_one ML348_real "C1CN(CCN1CC(=O)NC2=C(C=CC(=C2)C(F)(F)F)Cl)C(=O)C3=CC=CO3"
# ligands.smi (Fable novel series + controls + warhead)
while IFS=$'\t' read -r smi id; do
  [ -z "$id" ] && continue
  dock_one "$id" "$smi"
done < ligands.smi

echo "=== done -> $RES ==="
column -t -s$'\t' "$RES"
