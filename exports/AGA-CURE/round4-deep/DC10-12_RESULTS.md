# DC10 / DC11 / DC12 — safety · specificity · permanence-heritability

## DC10 — cumulative multi-modal safety
Independent per-arm adverse-event probabilities; cumulative = 1−∏(1−rᵢ).

| arm | r (AE prob) |
|---|---|
| ② SFRP1+Dkk1 topical | 0.04 |
| ① MPC/LDH topical | 0.05 |
| ④ neogenesis inducer | 0.06 |
| ③ Cas12f AAV (1-shot) | 0.10 |

- cumulative (independent) = **0.228** · worst-case (correlated) = 0.250 · tol 0.30 → **PASS**
- **Finding:** the 4-modality regimen sits under a 0.30 AE tolerance. The recurring
  budget is topical-only (0.143); arm③ is a one-time lock (non-recurring risk).
  Stacking modalities does NOT breach tolerance.

## DC11 — epigenetic-edit (Cas12f) specificity
20nt protospacer, expected genomic off-target sites by mismatch count (human 3.1e9 bp):

| max-mismatch | expected off-target sites |
|---|---|
| 0 (exact) | 2.8e-03 |
| 1 | 0.17 |
| 2 | 4.99 |
| 3 | 91.8 |

- exact off-target ≈ 0; on:off specificity (≤3mm, 100× weaker off-binding) ≈ 0.52
- **Finding:** no exact off-target expected; near-match aggregate is non-negligible
  and the reversible epigenetic edit de-risks vs a permanent DNA cut. **g63 honest:**
  the specificity ratio is an order-of-magnitude in-silico estimate — flag for
  empirical GUIDE-seq / CHANGE-seq (wet-lab), NOT a hexa-verified value.

## DC12 — epigenetic-mark heritability (DC3 permanence falsify-test)
DC3 recommended epigenetic editing as best permanence. DC12 stress-tests whether a
DNMT1-maintained CpG methylation mark SURVIVES HFSC self-renewal over 50yr
(~25 stem divisions; mark = M=8 CpGs, silencing needs ≥4 retained).

| DNMT1 fidelity f | per-site f²⁵ | P(mark silencing @50yr) |
|---|---|---|
| 0.95 | 0.277 | 0.155 ✗ |
| 0.98 | 0.603 | 0.832 |
| 0.99 | 0.778 | 0.984 ✅ |
| 0.995 | 0.882 | 0.999 |

- **Finding:** epigenetic-lock permanence **HOLDS at physiological fidelity (f≥0.98)**
  for quiescent HFSC, but is **fidelity-sensitive** — at f=0.95 the mark dilutes
  (P=0.155). **Mitigation:** a self-reinforcing (CpG-island-spreading, endogenous-
  DNMT-recruiting) edit or a periodic booster removes the f<0.97 risk. This refines
  the DC3 recommendation: epigenetic lock is permanent IF the edit is self-propagating
  or fidelity is confirmed ≥0.98. **g63:** maintenance-fidelity is literature-order,
  not hexa-verified — empirical bisulfite-seq longitudinal needed.
