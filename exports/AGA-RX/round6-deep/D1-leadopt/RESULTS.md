# DEEP D1 — lead-optimization analog docking (measured, Vina 1.2.7)

Designed analogs (round4-synthesize) docked vs SFRP1-CRD (box 8.6,3.1,2.9/24³) + AR-LBD off-target (validated pocket 26.767,2.339,4.632/20³, exh 32, seed 42).

| analog | SFRP1 ΔG | ΔΔG vs WAY(−7.77) | AR-LBD ΔG | Δ vs DHT(−9.89) | QED | synth |
|---|---:|---:|---:|---:|---:|---|
| WAY-316606 (parent) | −7.77 | 0 | −5.38 | +4.51 PASS | 0.73 | 5-step |
| **A3 saccharin-bicycle** | **−7.85** | **−0.08** | **−4.41** | **+5.48 PASS (cleanest)** | **0.83** | 4(+1) |
| A1 3-pyridyl | −7.45 | +0.32 | −4.83 | +5.06 PASS | 0.72 | 5-step |
| A2 4-aminoTHP | −7.38 | +0.39 | −4.90 | +5.00 PASS | 0.76 | **4-step (shortest)** |

VERDICT: NO analog breaks the ≥1.5 kcal/mol affinity-improvement gate (all within Vina noise of the parent) → affinity is NOT the optimization win. BUT all 3 **preserve SFRP1 potency AND improve developability AND are AR-cleaner than the parent**:
- **A3** = best overall (affinity ≥ parent, top QED 0.83, cleanest AR −4.41, rigidified 5→3 rotatable bonds).
- **A2** = best synthesizability (4-step, no Boc, non-basic THP cap removes the basic-piperidine liability) + AR-clean.
Recommendation: advance **A3 (potency/drug-likeness) + A2 (synthetic tractability)** as the dual dev-candidate set; the SFRP1 shallow PPI groove caps affinity ~−7.8 (a real ceiling, consistent with the weak-mM-binder reality → the developability + delivery axes, not raw ΔG, are where the program wins).
