# DEEP D5 — PD global sensitivity / uncertainty quantification (anagen gain)

200k-sample MC over the occupancy→anagen pipeline (C_DPC=Csurf·exp(−z/λ) → θ=C/(C+Kd) → gain=E_max·θ·14.4%-ceiling).
Uncertain inputs: E_max U(0.25,1.0) · Kd 40-160µM · λ_foll 0.2-2.0mm · z_DP 1.0-1.5mm · Csurf 80-140mM.

RESULT:
- anagen gain% vs vehicle: **mean 8.9% · median 8.9% · 90% CI [4.1, 13.8]** (ceiling 14.4)
- the earlier point estimate +13.6% was the E_max=1 OPTIMISTIC corner; full-bracket mean = +8.9%.
- occupancy θ median 0.997 (near-saturated; only the low-λ corner dips).

VARIANCE DECOMPOSITION (freeze-one conditional variance):
| input | variance contribution |
|---|---:|
| **E_max** | **98.6%** ★ |
| λ_foll · z_DP · Kd · Csurf | < 1% combined |

→ The entire output uncertainty is the ONE unmeasured parameter **E_max** (SFRP1-inhibition→anagen efficacy). PK/affinity are effectively settled (θ saturated). ⇒ the single highest-value wet-lab measurement = an **ex-vivo hair-organ-culture E_max assay**; it collapses the [4.1,13.8] band to a point. (d6: this sharpens, not fakes, the round-4 conditional.)

COMPETITIVENESS:
- P(gain ≥ 6%, clinically meaningful) = **77%**
- P(gain ≥ 9%, finasteride floor) = 49%
- P(gain ≥ 12%, minoxidil band) = 21%
