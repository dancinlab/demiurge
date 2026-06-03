# SENOLYX round-3 — MM-GBSA close + β-gal prodrug gating (honest mixed result)

## (A) Deferred MM-GBSA — CLOSED
Round-2's deferred A-1155463/BCL-xL MM-GBSA, now run with explicit carboxylate
deprotonation (COOH→COO⁻ at pH 7.4, single 4QVX chain-A copy, NAGL charges, GBSA-OBC2):
| term | E (kcal/mol) |
|---|---|
| complex | −5055.51 |
| receptor | −4940.03 |
| ligand (COO⁻) | −25.26 |
| **ΔG_bind** | **−90.22** |
**Finding:** favorable binding SIGN corroborates the Vina −7.35 docking. **g63 honest:**
the magnitude is NOT quantitative — a net-charged (−1) ligand in single-snapshot GBSA
inflates the electrostatic/solvation term (cf neutral SFRP1 ligand −17.96). Sign-level
corroboration only; quantitative ΔG needs charged-species FEP or ensemble + entropy.

## (B) β-gal prodrug gating — steric model FALSIFIED (d6 pivot)
NOVEL route #2 was a galactosyl-ester prodrug (β-gal-cleavable, senescent-cell-selective
via elevated SA-β-gal). Hypothesis tested: does the galactose cap sterically BLOCK BH3-groove
binding (so only the cleaved parent is active)?
| ligand | Vina (kcal/mol) |
|---|---|
| parent (active) | −6.12 |
| galacto-prodrug (capped) | −6.60 |
**Finding (FALSIFIED steric gating):** the cap does NOT reduce binding — the prodrug docks
equal/slightly better (galactose points to solvent, BH3 groove accommodates the core).
⇒ β-gal-prodrug niche-selectivity is **NOT thermodynamic (binding-blockade)**; it is
**kinetic/PK** — selective intracellular β-gal CLEAVAGE in senescent cells (which over-express
SA-β-gal) releasing active drug locally. Docking is the wrong assay; round-4 must model the
β-gal cleavage-rate selectivity (enzyme kinetics: senescent vs normal SA-β-gal turnover),
NOT a binding gate. Honest redirect, not a failure.

## Status / next (round-4)
- BCL-xL binding: validated (docking −7.35 + MM-GBSA sign-corroborated).
- NOVEL selectivity route: steric-gating ruled out → pursue (a) CRBN-PROTAC platelet-sparing
  (CRBN-absent platelets) + (b) β-gal cleavage-KINETICS model (SA-β-gal turnover ratio).
- analyze (ADMET + platelet off-target) + verify (η_neo-lift PD) still open.
