# DEFERRED — AGA-RX PATH C · ARM 2 (senescence clearance) docking (d_defer_no_delete)

## status
docking = **deferred** (TECHNICAL: docking tooling absent on mini, not a falsification).
Decks (BCL-xL primary + optional FKBP12 rapalog) are built + ready-to-run; both
candidates (BCL-xL BH3 groove + FKBP12 pocket) stay fully in the pool. NOT abandoned.
This lane is structure-prep ONLY (PATH C, no docking-toolchain dep) — the R2-A lane
executes the dock.

## targets prepped (real PDB coordinates, verified)
- BCL-xL receptor : `bclxl_chainA_receptor.pdb` (PDB 3ZLR chain A; X0B/EDO/SO4/HOH stripped)
                    pocket = BH3 hydrophobic groove (X0B == WEHI-539 co-crystal,
                    HETNAM == WEHI-539 IUPAC confirmed); box (-17.2,-12.7,-47.1) 28x26x22 A
- FKBP12 receptor : `fkbp12_chainA_receptor.pdb` (PDB 1FAP chain A; RAP stripped) [OPTIONAL]
                    pocket = rapamycin FKBP-binding pocket; box (-8.6,26.9,36.9) 30x24x32 A
- composite       : `fkbp12_frb_composite_receptor.pdb` (1FAP chains A+B) — for the
                    FKBP12+rapalog->mTOR-FRB ternary face (NOT a single-pocket Vina problem)
- source PDBs kept for provenance: `3ZLR.pdb`, `1FAP.pdb`

## mechanism note (rapalog / mTOR arm)
Rapalogs are NOT direct mTOR-pocket inhibitors. The drug binds FKBP12 first; the
FKBP12-rapalog BINARY complex then docks onto the mTOR FRB domain (a COMPOSITE
protein-protein interface) to allosterically inhibit mTORC1. Vina against FKBP12
alone models ONLY the FKBP12-binding step (where rapalog SAR lives). The FRB ternary
face needs the composite receptor + a protein-protein method, not single-ligand Vina.
Biological rationale: restoring autophagy in DHT-senescent dermal papilla clears
damaged organelles and dampens the SASP, complementing BCL-xL senolysis.

## what's absent (probed 2026-06-03 on mini, same as PATH B / ARM 1)
- `vina`, `smina`, `qvina2` : not installed; no working brew formula
- `obabel` (Open Babel)     : absent
- `rdkit`                   : absent; no conda/mamba on host
- net: brew / conda-forge fetch blocked in this sandbox

## retry recipe (cheapest -> heaviest, per d7 small-cell sizing)
1. **mini local conda** (preferred, FREE): install miniforge, then
   `conda create -y -n dock -c conda-forge vina openbabel rdkit meeko && conda activate dock && bash run_dock.sh`
   (BCL-xL: 7 ligands; FKBP12: 2 macrolides — a few min on CPU).
2. **pool free host** (d7: tiny CPU job): copy this dir + a conda env, then
   `sidecar pool on ubu-1 'bash run_dock.sh'`.
3. **smina single binary** (no conda): download smina static; loop the .conf files.
4. set `RUN_FKBP12=0 bash run_dock.sh` to run the BCL-xL primary screen alone.
5. parameter-tune: macrolides (rapamycin/everolimus) and navitoclax are huge + very
   flexible — if 3D-gen or docking fails, raise `--gen3d` torsions / supply an SDF, and
   widen the FKBP12 box (already 30x24x32). For WEHI-539/navitoclax keep the elongated
   BH3 box (28x26x22) so the full groove is searched.

## DO NOT delete the candidate — only a 🔴 FALSIFIED verdict (g63) closes it.
