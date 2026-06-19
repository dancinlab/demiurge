# scap-law lane r1 — VERDICT 🔵 formal (lit-grounded + closed-form + counterfactual-verified)

## CLOSING FORM — selectivity is a DIFFERENTIAL-DEPENDENCY quantity (affinity-orthogonal)
MOMP commit:  A − B·(1 − f·x) > θ   (A=activator BH3 stress, B=anti-apoptotic buffer, f=fraction of buffer on the DRUGGED protein, x=occupancy, θ=MOMP threshold)
Kill occupancy (θ=0):  x* = (B − A)/(f·B)
SELECTIVITY LAW:  selectivity exists ⟺ Δx* = x*_quiescent − x*_senescent > 0
   Δx* = (B_q−A_q)/(f_q·B_q) − (B_s−A_s)/(f_s·B_s) > 0
Dominant lever = f_s ≫ f_q (senescent funnels survival through one druggable buffer).
**Affinity (ΔG_bind) does NOT appear in Δx*** → it only maps x→dose. THIS is why the ABFE/RBFE affinity axis was the wrong axis (mechanistic explanation of the SENOLYX FF wall).
Operational (BH3-profiling): TW ∝ Δ(BCL-xL dependency)_{sen−qui} via selective HRK/NOXA peptide — NOT Δ(overall priming).

## NUMBERS (numpy threshold + 40k-cell MC)
window peaks +0.782 at x≈0.8 even though senescent LESS primed overall (A−B −0.40 vs −0.30); closed-form Δx*=+0.756>0; counterfactual f_q=f_s → window NEGATIVE (−0.03..−0.11) = kills healthy first. Selectivity impossible without the differential.

## CITATIONS (c23 answer-key)
- Soto-Gamez et al., Cell Death Differ 2024, 10.1038/s41418-024-01431-1 — specific BCL-xL dependency (HRKy) predicts senolysis; overall priming does NOT. (THE answer key)
- Vo/Letai, Blood 2011 — therapeutic index = differential priming.
- Montero & Letai dynamic BH3 profiling, 10.1038/s41419-021-04029-4.
- Cell Death Discovery 2025, 10.1038/s41420-025-02379-y — senogenic shift widens window.

## FALSIFIER (pre-registered)
Law dies if overall priming (promiscuous BIM/BID Δ) predicts senolysis ≥ as well as specific dependency Δ; or if a high-affinity BH3 mimetic with f_s=f_q achieves selectivity.

## CAVEATS (d6)
Empirical core published 2024 (not ours) — we add the closed-form x*=(B−A)/(fB) + proof affinity drops out of Δx*. Lit relation is Spearman (correlation); single-buffer model (real f is a vector over BCL-2/xL/MCL-1/BCL-w).
