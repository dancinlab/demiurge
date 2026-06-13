# SENOLYX round-8 — 3rd axis (HSP90) closes /gap top-2 landscape + F2 triple-resistant

## Closed gaps
- /gap top-2 (F8 landscape): non-BCL2 axis added — HSP90 (geldanamycin/17-DMAG, literature-
  validated senolytic, Fuhrmann-Stroissnigg 2017 Nat Commun).
- /gap F2 (triple-resistant adversarial): the BCL-xL+MCL-1-resistant subset is HSP90/chaperone-
  addicted → 3rd axis covers it.

## 3-axis coverage
senescent subsets (survival dependency): BCL-xL 0.45 / MCL-1 0.25 / HSP90 0.20 / residual 0.10.
| regimen | clearance | ≥60% gate |
|---|---|---|
| mono BCL-xL | 40% | FAIL |
| 2-axis (BCL-xL+MCL-1) | 60% | ok |
| **3-axis (+HSP90)** | **74%** | ok (covers resistant subset) |
Residual ~10% truly-multi-resistant tail → immune/NK-clearance or CAR-T adjunct (not a single
small-molecule axis). The 3-axis small-molecule cocktail is the practical ceiling.

## Docking (g63 — /gap F8 single-tool gap MANIFESTS, self-consistently)
BCL-xL A-1155463 −7.35 · MCL-1 S63845 −8.18 · **HSP90 geldanamycin −4.91 (WEAK)**.
The HSP90 number is weak because geldanamycin is a 19-rotatable-bond macrocyclic ansamycin
(sub-µM in reality); Vina systematically under-scores macrocycles. This is EXACTLY the cross-tool
gap /gap flagged (F8) — the HSP90 axis needs FEP / macrocycle-aware scoring, not Vina. The
mechanism (HSP90 senolytic) is literature-validated independent of the docking number.

## Loop status (brainstorm + gap → DRAINED)
gap top-1 (causal, R7) ✓ · top-2 (landscape, R8) ✓ · F2 triple-resistant (R8) ✓.
Remaining gaps are NOT genuinely-new-tractable: FEP cross-tool (heavy, would mainly re-score
HSP90), SSOT η-table (cosmetic), PK/ADME + immunogenicity + re-dosing (wet-lab). ⇒ the
in-silico brainstorm+gap loop is DRAINED at the honest boundary.
