#!/usr/bin/env bash
# Ready-to-run AutoDock Vina docking of WAY-316606 into the SFRP1 CRD Wnt groove.
# DEFERRED on mini (no vina/smina/obabel/rdkit; no conda; pip vina wheel unavailable for this py/arch).
#
# ── ONE-LINE INSTALL + RUN (a host with conda, e.g. a vast.ai CPU pod or ubu-1) ──
#   conda create -y -n dock -c conda-forge vina meeko openbabel python=3.11 && conda activate dock && bash run_dock.sh
#
set -euo pipefail
cd "$(dirname "$0")"

# 1. Receptor prep: AF model -> add H, assign Gasteiger charges, write pdbqt.
#    (Meeko's mk_prepare_receptor.py, or AutoDockTools prepare_receptor4.py.)
mk_prepare_receptor.py -i SFRP1_CRD_receptor.pdb -o SFRP1_CRD_receptor.pdbqt -p \
  || prepare_receptor4.py -r SFRP1_CRD_receptor.pdb -o SFRP1_CRD_receptor.pdbqt -A hydrogens

# 2. Ligand prep: SMILES -> 3D, protonate at pH 7.4 (piperidine N+ ~ pKa 10.5 -> charged), pdbqt.
obabel WAY-316606.smi -O WAY-316606_3d.sdf --gen3d -p 7.4
mk_prepare_ligand.py -i WAY-316606_3d.sdf -o WAY-316606.pdbqt \
  || obabel WAY-316606_3d.sdf -O WAY-316606.pdbqt -xh

# 3. Dock.
vina --config vina_config.txt --out WAY-316606_docked.pdbqt | tee vina_log.txt

echo "Top pose dG (kcal/mol):"
grep -A3 "^-----" vina_log.txt | head -5
