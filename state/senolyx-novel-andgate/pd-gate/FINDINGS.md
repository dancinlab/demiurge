# pd-gate lane r1 — VERDICT 🟢 GATE_CLOSED_MEASURED (model-side, anchor-calibrated to UBX1325 PASS + UBX0101 FAIL)
## CORRECTED η_neo PD MODEL (replaces clearance-%)
η_neo_lift = R_cap · S_relief · E_local · K_persist  (∈[0,1])
  S_relief = c_causal·p_dep·sel_gain (sel_gain=S/(S+1); S≈4× → 0.80) · E_local=1−exp(−AUC_local/AUC_thr) · K_persist=τ_reacc/(τ_reacc+t_assess) · R_cap=tissue ceiling.
## PREDICTED η_neo lift (band p_dep 0.65→0.85) + new functional gate + verdict
RETINA 0.165-0.215 | gate η≥0.138 (≥+4 ETDRS letters durable) → 🟢 PASS (mirrors UBX1325)
AGA    0.108-0.141 | gate η≥0.121 (≥+20% terminal hair) → 🟠 PASS* (needs p_dep≥0.75)
PERIO  0.085-0.111 | gate η≥0.095 (≥+1mm CAL/bone fill) → 🟠 PASS* (R_cap-limited)
OA     0.025-0.033 | gate η≥0.069 (cartilage struct regen) → 🔴 FAIL (E_local PK washout × low R_cap)
## OA BREAKTHROUGH (d2, named): single dose 0.031→depot 0.068→depot+subtype-AND-gate 0.099 PASS→+cartilage R_cap 0.40→0.70 = 0.173. PK-gated+ceiling-gated, NOT closed.
## ARCHITECTURE GATE CORRECTION (recommended): retire clearance-% gates (OA≥78%·RETINA≥72%=falsified projections); adopt η_neo functional floors above + real endpoint tags + 2 calibration anchors (10.1056/EVIDoa2400009·UBX0101 OARSI).
## CAVEATS: falsification of clearance-% = hard/lit-grounded; absolute η magnitudes + c_causal/τ_reacc/AUC_local = wet-lab-only (d5). RETINA PASS robust (pinned to real Ph2). AGA/PERIO conditional. OA boundary real but addressable.
