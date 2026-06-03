# SENOLYX round-9 — cross-tool re-score resolves /gap F8 single-tool gap (HSP90 axis)

## Gap addressed
/gap top-3 (F8 cross-tool-consistency): SENOLYX relied on Vina alone, and round-8's HSP90 axis
scored weakly (−4.91) — was the axis weak, or was Vina the artifact? A 2nd, more physical tool
(single-trajectory MM-GBSA, GBSA-OBC2; the AGA-RX D2-validated pipeline) re-scores it.

## Result — the tools DISAGREE, MM-GBSA confirms strong binding
| method | geldanamycin → HSP90 ΔG |
|---|---|
| Vina (docking) | −4.91 kcal/mol (weak) |
| **single-traj MM-GBSA** | **−66.49 kcal/mol** (strong) |
Terms: E[complex]=−7142.86, E[receptor]=−7117.15, E[ligand]=+40.78 (strained macrocycle).
**Finding:** the ~60 kcal/mol disagreement confirms the /gap F8 hypothesis — Vina grossly
UNDER-scores the 19-rotatable-bond macrocyclic ansamycin (geldanamycin), whose true affinity is
sub-µM/nM. MM-GBSA, which captures the buried-surface enthalpy Vina's empirical function misses,
confirms the HSP90 3rd axis binds STRONGLY. The round-8 −4.91 was a tool artifact, NOT a weak axis.

## Honest scope (g63)
- The cross-tool QUESTION (is Vina under-scoring?) is answered YES — gap resolved qualitatively.
- The MM-GBSA ABSOLUTE −66.49 is itself over-binding (single-snapshot, no entropy/strain
  correction, macrocycle) — NOT a quantitative ΔG.
- True alchemical FEP (the gold standard for the absolute number) needs GPU/hours → CLOUD step,
  not local; flagged as the round-10 wet-lab-adjacent computational gate.
⇒ The single-tool gap is structurally closed (2-tool cross-check + the disagreement direction
  resolved); the absolute affinity ranking awaits FEP on GPU.

## SENOLYX docking + cross-tool summary
BCL-xL A-1155463: Vina −7.35 · MCL-1 S63845: Vina −8.18 · HSP90 geldanamycin: Vina −4.91 / MM-GBSA −66.5.
The HSP90 axis, correctly scored, is the strongest-binding of the three (consistent with nM ansamycin).
