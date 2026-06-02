# DEFERRED — AGA-RX PATH B docking (d_defer_no_delete)

## status
docking = **deferred** (TECHNICAL: docking tooling absent on mini, not a falsification).
Deck is built + d16-style ready-to-run; the candidate (LRP6 PE3 pocket + fragment set)
stays fully in the pool. NOT abandoned.

## what's absent (probed 2026-06-03 on mini)
- `vina`, `smina`, `qvina2`        : not installed; no brew formula (`smina`, `autodock-vina` unresolved)
- `obabel` (Open Babel)            : absent
- `rdkit`                          : absent; `pip install rdkit-pypi` -> no distribution for py3.14;
                                     PEP-668 externally-managed system python; no conda/mamba on host;
                                     conda-forge unreachable from sandbox
- net: brew/conda-forge fetch blocked in this sandbox

## retry recipe (cheapest -> heaviest, per d7 small-cell sizing)
1. **mini local conda** (preferred, FREE): install miniforge, then
   `conda create -y -n dock -c conda-forge vina openbabel rdkit meeko && conda activate dock && bash run_dock.sh`
   (8 fragments x exhaustiveness 16 ~= a few min on CPU — trivially single-host).
2. **pool free host** (d7: 4-7-atom-class job is tiny; CPU is plenty): `sidecar pool on ubu-1 'bash run_dock.sh'`
   after copying this dir + a conda env.
3. **smina single binary** (no conda): download smina static, `smina --config vina_dock.conf --ligand <lig>.pdbqt`.
4. parameter-tune if a fragment fails 3D-gen: drop `--gen3d`, supply explicit SDF; widen box only if a
   pose clips the wall (current 24^3 A box already covers the full DKK1 finger footprint).

## artifacts ready
- `lrp6_chainA_receptor.pdb`  — receptor (LRP6 chain A, waters/glycans/glycerol stripped)
- `vina_dock.conf`            — box center (22.5, -0.7, -13.7), size 24x24x24 A
- `fragments.smi`             — 8 DKK1-pharmacophore-mimetic probes
- `run_dock.sh`               — prep + dock + rank pipeline (idempotent)

## DO NOT delete the candidate — only a 🔴 FALSIFIED verdict (g63) closes it.
