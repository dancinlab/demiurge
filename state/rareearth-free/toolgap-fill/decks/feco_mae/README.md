# feco_mae — force-theorem MAE deck (QE noncollinear + SOC) — TOOLGAP-FILL PROOF

Purpose: PROVE that the SOC magnetocrystalline-anisotropy path runs on FREE compute
(summer RTX5070, QE 7.5 conda env). This is the deck that closes the L20 tool gap —
`hexa deck material` is a stub (geometry only, no SCF/MAE runbook), QFORGE-native has
SOC=0. QE pw.x implements `noncolin=.true. lspinorb=.true.` + force-theorem MAE.

## Recipe (force theorem)
- `scf.in`     : noncollinear+SOC SCF, converge charge density (M‖001, angle1=0).
- `nscf_001.in`: single-shot band energy with M‖[001] (force-theorem, startingpot=file).
- `nscf_100.in`: single-shot band energy with M‖[100] (angle1=90).
- MAE = E(M‖100) − E(M‖001);  K1 = MAE / V_cell.
- `scf_dryrun.in`: electron_maxstep=1 d16 validation variant (proves parse + SOC init).
- `run_mae.sh` : driver (stage1 SCF → stage2 two axes → K1 in MJ/m³).

This sample cell = bcc-Fe 2-atom (known SOC test case, ~1.8 μB/atom, K1 tiny by cubic
symmetry — it is the PIPELINE-VALIDATION ANCHOR per d_novel_only, not a result).
Pseudo: Fe.rel-pbe-spn-rrkjus_psl.0.2.1.UPF (has_so="T", PSlibrary fully-relativistic).

## lever(b) candidate decks (item C — staged, NOT run this round)
The magnet-ceiling lever(b) physics named three escape routes. Each becomes a feco_mae
clone with swapped geometry/species (uniaxial cell → nonzero K1 by symmetry):

1. interstitial-N D0_19 / Fe16N2 ("giant-moment" α''-Fe16N2, bct, N on octahedral site).
2. epitaxial tetragonal distortion: strained Fe-Co (FeCo bct, c/a≈1.1–1.25, Burkert
   2004 predicted K1 up to ~0.7–1 MJ/m³ at optimal c/a — uniaxial).
3. high-entropy 3d alloying (Fe-Co-Ni-Mn-... random uniaxial supercell, SQS).

## NOVELTY (d18 / d_novel_only) — pre-registered grounding
These are KNOWN material classes (NOT novel materials). The novelty target is whether
ANY clears the falsifier — and the literature answer is the pre-registered expectation:
- Fe16N2: bulk K1 ~ 1.0 MJ/m³ (giant moment ~2.9 μB/Fe), BELOW 3 MJ/m³. Known since
  1972; metastable, decomposes — the famous reproducibility controversy.
- strained FeCo: Burkert/Nordström/Eriksson PRL 93, 027203 (2004) — DFT K1 peak ~0.7–1
  MJ/m³ at c/a≈1.2; experimentally realized only as thin epitaxial films, BELOW 3 MJ/m³.
- HEA 3d: cantor-type 3d HEAs report soft-magnetic behavior, K1 << 1 MJ/m³.
None reported clearing 3 MJ/m³ at RT in bulk → the L1 "4f-anisotropy substitution
ceiling" law already predicts CLOSED-NEGATIVE for the 3d-only lever(b) family.

## FALSIFIER (pre-registered, d6)
H0: a 3d-only (no 4f) lever(b) lattice yields DFT magnetocrystalline K1 ≥ 3 MJ/m³ at RT.
- PASS  → escape candidate; advance to TIER-1 g5 + production MAE (full SCF, dense k).
- FAIL (K1 < 3 MJ/m³, expected) → CLOSED-NEGATIVE, reinforces L1 ceiling: 3d orbital
  un-quenching alone cannot reach RE-class anisotropy without a heavy 5d SOC center.

## d_deck_always note
The hard-won deck regularities here (FR-pseudo has_so check · noncolin+lspinorb pair ·
angle1/angle2 axis control · force-theorem startingpot=file · ecutrho=10×ecutwfc for
rrkjus US · mv smearing for metal) are the SPEC for a future `hexa deck material`
`magnetic_soc_mae` prototype. Already handed to hexa-lang core (ING.jsonl work id=28
+ handoff registry material-deck gap). Until that lands, this validated deck set is the
reference; clone + swap geometry per candidate (do NOT hand-author from scratch).
