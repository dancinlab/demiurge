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

r2 (2026-06-19) — make-or-break ρ + kill-axis, 2-lens g5 PASS:
- rho-estimate 🟠: ρ inferred 저값(DPP4↔GLB1 0.10·PLAUR↔GLB1 0.20·PLAUR↔DPP4 0.30); 3 distinct 허브(NF-κB/STAT1/TFEB)·GLB1 decorrelating leg → 3축 SUPPORTED. 결정실험=3색 flow ρ.
- fsq-estimate 🟠: f_s/f_q ~1.6×(1.3-2.6) inferred modest; healthy BCL-xL 항시발현 ceiling ~2-3×; MCL-1i differential compress; 인식 AND-gate가 selectivity 주동.
- 현실 총 선택성 = S1×f_s/f_q = ~13.5-26×(중앙 ~19×·최악 ρ서도 13.5×) = 설계 SUPPORTED.
FINAL: SENOLYX-AG in-silico SUPPORTED(~19× robust); make-or-break ρ 미측정→3색 flow 단일실험으로 확정. FIRST=PERIO. d_novel_only 미선례 조합.
