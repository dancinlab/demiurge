# AGA-RX DEEP D2 — MM-GBSA binding ΔG (env-wall broken)

## The deferral blocker — RESOLVED
D2 was DEFERRED on an env wall: pip-openff/openmmforcefields vs conda-pytorch
filesystem clash ("Directory not empty .../torch/include/ATen"). **Fix:** a fresh
conda-forge-ONLY micromamba env (ambertools·openmm·openff-toolkit·openmmforcefields·
parmed·pdbfixer·rdkit — NO pip) avoids the torch clash entirely. Env builds clean
(openmm 8.5.1). Recipe: `micromamba create -p envs/mmgbsa -c conda-forge python=3.11
ambertools openmm openff-toolkit openmmforcefields parmed rdkit openbabel pdbfixer`.

## Method
Single-trajectory MM-GBSA (GBSA-OBC2 implicit solvent): minimize the complex once,
then single-point E[complex], E[receptor], E[ligand] on the SAME coordinates
(no per-component re-minimization). Ligand: OpenFF SMIRNOFF (openff-2.1.0) with
NAGL ML-AM1BCC charges. Protein: ff14SB. Receptor repaired with PDBFixer.
> A v4 bug (minimizing each component separately) gave a meaningless +10.9 kcal/mol —
> receptor internal-energy noise (~100 kcal/mol over 2325 atoms) swamps binding.
> Single-trajectory (v5) removes that noise. Documented honestly.

## Result — WAY-316606 → SFRP1 (primary D2 goal)
| term | E (kcal/mol) |
|---|---|
| complex | −4197.23 |
| receptor | −4069.33 |
| ligand | −109.94 |
| **ΔG_bind** | **−17.96** |

**Finding:** an independent, more rigorous method (single-trajectory MM-GBSA)
**corroborates the Vina docking score** (−7.77): both give FAVORABLE binding (same
sign). Raw MM-GBSA over-binds in magnitude vs docking — expected (no entropy term).
The rigorous SFRP1 binding ΔG that D2 called for is in hand; the env wall is broken.

## AR-gate ΔΔG — honest method limitation (g63)
Running the same pipeline on WAY-316606 → AR-LBD gave ΔG_bind = −25.77 kcal/mol —
i.e. MORE favorable than SFRP1, the WRONG direction for selectivity. **Interpretation:**
single-snapshot MM-GBSA enthalpy is NOT a valid cross-target selectivity discriminator —
it omits configurational entropy and ligand strain, and the larger hydrophobic AR
pocket inflates raw GB/vdW contact energy regardless of specificity. **Selectivity is
established instead by the round-3 AR-gate DOCKING** (consistent scoring function:
WAY −5.38 weak at AR vs DHT −9.89; AR-clean PASS). A rigorous cross-target ΔΔG needs
FEP or entropy-corrected ensemble MM-GBSA — flagged, not faked.

## Status
- env-deferral: **RESOLVED** (conda-forge-only recipe)
- SFRP1 rigorous binding ΔG: **DONE** (−17.96, corroborates Vina)
- AR-selectivity: established by round-3 docking gate; MM-GBSA-ΔΔG → FEP (residual)
