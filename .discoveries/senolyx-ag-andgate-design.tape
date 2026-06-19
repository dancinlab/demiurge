# .discoveries/senolyx-ag-andgate-design.tape
# SENOLYX-AG — fibroblast-niche 국소 직교 AND-gate senolytic 설계 (종결식 recipe 실행·d_novel_only)
id: senolyx-ag-andgate-design
seed: 선택성 종결식(senolyx-selectivity-law) → actionable recipe 실행 NOVEL 설계 캠페인

r1 (2026-06-19) — 4 design-lens g5 PASS·수렴:
- construct-design 🟢: WINNER Gal-uPAR-PROTAC (BCL-xL→CRBN PROTAC + galacto-cage + uPAR 나노입자); AND-gate=uPAR×SA-β-gal 직렬 2락; risk=ρ.
- niche-target 🟢: KILL=BCL-xL 주축+MCL-1 2차(GPX4 fibroblast 불신뢰); 직교쌍 DPP4∧SA-β-gal(최강) or uPAR∧SA-β-gal(fibroblast-검증); FIRST=PERIO(단일 CD81+ subtype+pocket+pair).
- compute-plan 🟢: ABFE→binary; PRIMARY=S_total AND-gate index; 5-stage mini-free pipeline(S1 new·S2/S5 reuse round5/7); g5 gates.
- pd-gate 🟢: η_neo PD(anchor UBX1325/UBX0101); RETINA PASS·AGA/PERIO PASS*·OA FAIL(depot+subtype+R_cap 돌파); clearance-% 게이트 정정 권고.
SPEC → state/senolyx-novel-andgate/SENOLYX_AG_DESIGN_SPEC.md
DECISIVE NEXT (zero-cost): PLAUR↔GLB1 (또는 DPP4↔GLB1) ρ + f_s/f_q from single-cell atlases + S1 모델 실행 = AND-gate 곱셈성 make-or-break.

S1 실행(c2): 단일마커 0.92× anti-sel · 2축 ~4×(ρ↑서 <2× 붕괴) · 3축 uPAR×DPP4×SA-β-gal 23.1×(box-min 4.34×·robust). 설계정정=robust엔 3축 AND-gate 필요. make-or-break=ρ. script=state/senolyx-novel-andgate/s1_andgate_index.py.
