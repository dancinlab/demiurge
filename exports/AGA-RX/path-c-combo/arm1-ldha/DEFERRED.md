# DEFERRED — AGA-RX PATH C · ARM 1 (LDHA / LDHB selectivity) docking (d_defer_no_delete)

## status
docking = **deferred** (TECHNICAL: docking tooling absent on mini, not a falsification).
Decks (LDHA + LDHB counter-screen) are built + ready-to-run; both candidates
(LDHA substrate/NADH funnel + the metabolic candidate set) stay fully in the pool.
NOT abandoned. This lane is structure-prep ONLY (PATH C, no docking-toolchain dep) —
the R2-A lane executes the dock.

## targets prepped (real PDB coordinates, verified)
- LDHA receptor : `ldha_chainA_receptor.pdb` (PDB 6Q0D chain A; NAI/P8M/PO4/GOL/HOH stripped)
                  pocket = P8M co-crystal inhibitor site; box (31.4, 87.3, 53.1) 26x24x22 A
- LDHB receptor : `ldhb_chainA_receptor.pdb` (PDB 1I0Z chain A; NAI/OXM/HOH stripped)
                  pocket = homologous OXM+NAI catalytic site; box (14.2, 39.6, 57.2) 26x24x22 A
- source PDBs kept for provenance: `6Q0D.pdb`, `1I0Z.pdb`
- selectivity readout = dG_LDHA - dG_LDHB (computed by run_dock.sh)

## what's absent (probed 2026-06-03 on mini, same as PATH B)
- `vina`, `smina`, `qvina2` : not installed; no working brew formula
- `obabel` (Open Babel)     : absent
- `rdkit`                   : absent; no py-distribution for the host python; no conda/mamba
- net: brew / conda-forge fetch blocked in this sandbox

## retry recipe (cheapest -> heaviest, per d7 small-cell sizing)
1. **mini local conda** (preferred, FREE): install miniforge, then
   `conda create -y -n dock -c conda-forge vina openbabel rdkit meeko && conda activate dock && bash run_dock.sh`
   (8 ligands x 2 receptors x exhaustiveness 16 ~= a few min on CPU — trivially single-host).
2. **pool free host** (d7: this is a tiny CPU job): copy this dir + a conda env, then
   `sidecar pool on ubu-1 'bash run_dock.sh'`.
3. **smina single binary** (no conda): download smina static; loop the two .conf files.
4. parameter-tune if a candidate fails 3D-gen: drop `--gen3d`, supply explicit SDF.
   GSK2837808A / galloflavin are large+rigid — if a pose clips a wall, widen the box to 30^3.

## selectivity caveat (for the R2-A lane to honor)
LDHA (6Q0D) and LDHB (1I0Z) are in DIFFERENT coordinate frames, so the two centers
are NOT interchangeable — each .conf carries its own pocket-derived center. Box DIMS
are deliberately matched (26x24x22) so the dG comparison is geometrically fair. If a
cross-check is wanted, structurally superpose LDHB onto LDHA (e.g. PyMOL `align`) and
re-derive the LDHB box from the mapped LDHA center.

## DO NOT delete the candidate — only a 🔴 FALSIFIED verdict (g63) closes it.
