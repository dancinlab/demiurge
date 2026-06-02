# AGA-RX · PATH C — metabolic + senescence COMBINATION (anti-PP405-me-too)

🧪 PATH C · *the "don't compete with PP405 on its own turf" path*

## differentiation thesis
PP405 (and the MPC-inhibitor class) re-activates hair-follicle stem cells by
shifting their metabolism (lactate/MPC axis). A me-too MPC inhibitor competes
head-on. PATH C instead attacks **two orthogonal, follicle-relevant vulnerabilities
that PP405 does NOT** and combines them:

1. **ARM 1 — metabolic, LDHA-SELECTIVE (downstream of MPC).**
   Rather than blocking pyruvate IMPORT (MPC, the PP405 node), block the cytosolic
   fork that DHT-stressed dermal papilla (DP) cells lean on: LDHA-driven
   pyruvate->lactate (Warburg-like) flux. The thesis is **LDHA-over-LDHB
   selectivity** — LDHA carries the anabolic/lactate-export load while LDHB
   (lactate->pyruvate, oxidative) is spared, avoiding systemic LDH ablation.
   This is downstream of and orthogonal to MPC, so it is NOT a PP405 me-too.

2. **ARM 2 — senescence CLEARANCE (a vulnerability PP405 ignores).**
   DHT chronically pushes DP cells toward a senescent, SASP-secreting state that
   blunts anagen re-entry. PP405 does nothing about the accumulated senescent
   pool. PATH C adds a **senolytic** (BCL-xL BH3-groove block -> apoptotic priming
   of senescent DP) plus an OPTIONAL **autophagy-restore** rapalog (FKBP12/mTORC1)
   to clear damaged organelles and dampen SASP.

Combination logic: ARM 1 shifts the surviving DP metabolism toward an anagen-
permissive state, while ARM 2 removes the senescent cells that would otherwise
suppress the response. The two arms hit non-overlapping nodes -> expected
super-additive effect on the anagen-fraction readout.

## targets & decks emitted (all coordinates/SMILES verified, NOT fabricated)

| arm | target | PDB (chain) | pocket (co-crystal probe) | box center | box size | lead |
|-----|--------|-------------|---------------------------|------------|----------|------|
| 1 | LDHA | 6Q0D (A) | substrate/NADH funnel (P8M inhibitor) | (31.4, 87.3, 53.1) | 26x24x22 | GSK2837808A |
| 1 | LDHB (counter) | 1I0Z (A) | homologous OXM+NAI site | (14.2, 39.6, 57.2) | 26x24x22 | — (off-target) |
| 2 | BCL-xL | 3ZLR (A) | BH3 groove (X0B = WEHI-539) | (-17.2, -12.7, -47.1) | 28x26x22 | WEHI-539 |
| 2 | FKBP12 (opt) | 1FAP (A) | rapamycin FKBP pocket | (-8.6, 26.9, 36.9) | 30x24x32 | rapamycin |

Each arm dir has: receptor `*_chainA_receptor.pdb` (HETATM/waters stripped),
`vina_dock_*.conf`, `candidates*.smi` (PubChem-verified), `run_dock.sh`, `DEFERRED.md`,
and the source PDB(s) for provenance. ARM 1 `run_dock.sh` docks vs BOTH LDHA and LDHB
and emits the selectivity gap. ARM 2 docks BCL-xL (primary) + FKBP12 (optional toggle).

### selectivity readout (ARM 1)
`selectivity = ΔG_LDHA − ΔG_LDHB`. A hit must be (a) strongly negative ΔG_LDHA AND
(b) have a negative gap (binds LDHA notably tighter than LDHB). Caveat: 6Q0D and 1I0Z
are in different coordinate frames; each .conf carries its own pocket-derived center,
box DIMS matched for a fair comparison (see arm1 DEFERRED.md for the superposition
cross-check recipe).

## combination-index plan (Bliss / Loewe on the anagen-fraction readout)
Readout `E` = **anagen fraction** of the DP/follicle model (fraction of follicles /
organoids in anagen) — a 0..1 effect, ideal for combination-index math.

**Dose grid.** Full N×M checkerboard: ARM-1 LDHA inhibitor (best in-silico hit) ×
ARM-2 senolytic (best BCL-xL hit), each at ~5-7 doses spanning sub-EC50 to plateau,
plus single-agent rows/columns and a vehicle well.

**Bliss independence (primary, for orthogonal mechanisms).**
Expected combined effect (as fraction affected `fa`):
  `fa_Bliss = fa_A + fa_B − fa_A·fa_B`.
Synergy if observed `fa_AB > fa_Bliss`. Report the **Bliss excess** surface
`Δ = fa_AB − fa_Bliss` over the whole grid (Bliss is the natural model here because
LDHA-metabolic and BCL-xL-senolytic act on independent targets).

**Loewe additivity / Combination Index (secondary, dose-equivalence).**
Fit each single-agent dose-response (median-effect / Hill), then
  `CI = d_A/Dx_A + d_B/Dx_B`  at each iso-effect level,
where `d_A,d_B` = doses of A,B in the mix producing effect x, and `Dx_A,Dx_B` = doses
of each ALONE for the same x. CI < 1 synergy · CI = 1 additive · CI > 1 antagonism.
Summarize with a Chou-Talalay Fa-CI plot + a Loewe isobologram at EC50/EC75/EC90.

**Decision.** Advance the combination if Bliss-excess > 0 across the mid-dose band
AND CI < 0.9 at EC75 — i.e. a genuinely super-additive anagen lift that beats either
arm alone (the differentiation claim vs a single-node PP405 me-too).

## status (d_defer_no_delete · d1/d19)
Structure-prep + deck emission = **DONE** for this lane (no docking-toolchain dep).
Docking itself = **deferred** (tooling absent on mini) — both arms' DEFERRED.md carry
the retry recipe. Candidates stay fully in the pool; only a 🔴 FALSIFIED verdict closes one.
Downstream: R2-A lane runs the decks -> ΔG + selectivity gap -> pick leads -> the
combination-index assay above on the anagen-fraction readout.
