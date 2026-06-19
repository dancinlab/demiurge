# .discoveries/senolyx-selectivity-law.tape
# SENOLYX selectivity closing-formula — law-hunt fleet (analog of RTSC material-discovery closing formula)
id: senolyx-selectivity-law
seed: SENOLYX affinity axis depleted (FF ceiling, R12 close-negative) → pivot to selectivity LAW hunt
verdict_tier_target: closing-formula (multi-lens converged)

r1 (2026-06-19) — 4-lens fleet, all g5 PASS, CONVERGED:
- scap-law 🔵: selectivity = differential SCAP dependency, x*=(B−A)/(f·B); Δx*>0 selectivity condition;
  affinity ABSENT from Δx* → mechanistic root of the ABFE wall. (Soto-Gamez 2024 answer-key)
- window-ceiling 🔵/🟠: f_clear(T) ≤ p_dep(T)·F_b(D_tox); single-target THEOREM ceiling (SenePy no-universal-marker);
  window closes EC50_healthy ≤ EC50_sen,tail (navitoclax/platelet); escapable only by covering w/ orthogonal tox.
- selectivity-escape 🟢: S_total=∏S_i multiplicative AND-gate on ORTHOGONAL axes (metabolic×surface×lysosomal);
  conditional on independence+leak; GLS1 pan-senescent escapes the heterogeneity wall; PROTAC decouples dose↔tox.
- senolytic-corpus 🟢/🟠: affinity≠selectivity CONFIRMED (navitoclax tightest-Kd/narrowest-window); single-target
  ceiling + AND-gate window-escape confirmed; clinical escape UNPROVEN (UBX1325 Ph2b miss; no approved senolytic).
CLOSING FORMULA → state/senolyx-selectivity-law/SENOLYX_SELECTIVITY_CLOSING_FORMULA.md
NOVEL frontier (next): orthogonal AND-gate on pan-senescent backbone — no paper quantifies a 2-marker
senescence selectivity factor (d_novel_only target). Recipe: maximize f_s/f_q via selective-peptide BH3 Δ, not Kd.

r2 (2026-06-19) — NOVEL frontier 정량 + 게이트 정정, 3-lens g5 PASS:
- andgate-number 🟠: 현실 직교 AND-gate S_total ~4× (1.4-11×) → 전신 청소 ~7-28%@<5%harm; 단일마커 0.5× anti-sel; 3-marker 최소가용; 값=ρ+곱셈누출 의존 (문헌최초 정량).
- backbone-coverage 🔵/🟠: pan-senescent 의존성 부재; best BCL+MCL p_dep0.65, dual BCL∪GPX4 0.73-0.85, 잔존 15-35%; SA-β-gal=인식태그 not kill; GLS1 강등(EMBO2026).
- nexus-payoff 🔴/🟠: clearance-%→cure 전달함수 비단조·미근거(2차 틀린축); 72/78% 게이트 falsified(UBX0101 ~50%청소 전임상성공/인간OA실패; UBX1325 국소+subtype 성공); CURE OA/PERIO/AGA FAIL·RETINA precedent-PASS.
TERMINAL: 전신 broad senolytic CLOSED; 유일경로=국소전달+단일causal subtype+BCL/GPX4 백본 직교AND-gate(SA-β-gal 태그)=망막-class.
NOVEL 다음캠페인(d_novel_only·미선례): fibroblast-niche 국소 직교 AND-gate senolytic 설계·계산.
