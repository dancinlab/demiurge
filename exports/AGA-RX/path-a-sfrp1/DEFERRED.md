# DEFERRED — WAY-316606 → SFRP1 CRD docking RUN (per d_defer_no_delete)

status: deferred
reason: TECHNICAL — no docking engine runnable on host `mini`
candidate: KEPT in pool (NOT falsified — no 🔴 verdict; deferral is resource-class only)

## What blocks the RUN on mini
- `which vina smina obabel` → none installed
- no conda/mamba/micromamba; no rdkit, no biopython
- `pip install vina` (py3.14 / arm64) → no wheel; source build fails: `ValueError: Boost library location was not found!`
- AutoDock Vina needs Boost C++ libs (and ADFR/Meeko or AutoDockTools for pdbqt prep)

## Retry recipe (run on a host with conda — vast.ai CPU pod or pool ubu-1/2)
```
conda create -y -n dock -c conda-forge vina meeko openbabel python=3.11
conda activate dock
bash run_dock.sh        # config + receptor/ligand prep + dock, all wired
```
Estimated cost: ~$0 (pool free) or <$0.10 (one vast.ai CPU-pod hour). Single ligand,
24 Å box, exhaustiveness 32 → seconds of wall time. Per d7: small job → pool free first.

## Deck is READY (d16 dry-run equivalent: files validated, box centered on pocket)
- receptor : SFRP1_CRD_receptor.pdb (CRD res 32-180, 1187 atoms, mean pocket pLDDT 92.7)
- ligand   : WAY-316606.smi (CID 16727102, MW 448.5)
- config   : vina_config.txt (center 8.6/3.1/2.9, size 24³, exh 32, modes 20)
- runner   : run_dock.sh

## Literature-estimated affinity (NOT a docking result — labelled as estimate)
WAY-316606 measured binding to sFRP-1: Kd ≈ 0.08 mM (80 µM), cell EC50 ≈ 0.65 mM.
ΔG_bind = RT·ln(Kd) at 298 K = (0.001987)(298.15)·ln(8.0e-5) = **−5.6 kcal/mol** (estimate).
This is a weak, mM-range binder — consistent with its known poor PK and the shallow,
solvent-exposed nature of the Fz-CRD Wnt PPI groove (hard target for small molecules).
A Vina score in the −5 to −7 kcal/mol band would be consistent; treat any deeper score
(< −8) on this shallow groove with skepticism (likely artifactual surface contact).
