# LANE 1 — full-basis screened SCF npw_cap sweep (WIP)

Scope: lift npw_cap in the QFORGE screened-vertex path and measure λ(npw_cap)
vs QE 4.376 on the independent CaH6 front-end (exports/rtsc/decks/CaH6_NC).

Driver: stdlib/qforge/fixtures/cah6_fullbz_xval.hexa <deck> <npw_cap> <nq>
  (qforge_pw_frontend_phonons_scr — screened Dyson ε⁻¹ vertex)

Known anchors (pre-existing verdicts):
- npw_cap=16 selftest (c), keystone path, screened x+c : λ=0.180634 (~24× under, brief baseline)
- npw_cap=0 (full, n=645), BARE vertex   : λ=4.13647 (5.47% over)  [cah6_fullbz_converged.log]
- npw_cap=0 (full, n=645), SCREENED vertex: λ=5.05165 (15.4% over)  [VERDICT.txt screening-route-debug]

Hypothesis: npw_cap=16 truncation is the dominant 24×-under cause; lifting to
full recovers nearly all of it.

## sweep results (this lane)
(filled per-step below)
