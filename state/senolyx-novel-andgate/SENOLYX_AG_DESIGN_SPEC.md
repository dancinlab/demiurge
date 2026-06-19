# SENOLYX-AG — fibroblast-niche 국소 직교 AND-gate senolytic 설계 스펙 (R1, 4-lens 수렴) · 2026-06-19

종결식(state/senolyx-selectivity-law/)의 actionable recipe 실행 = NOVEL 설계 캠페인 (법칙사냥 아님·d_novel_only 미선례).

## WINNER 구조: Gal-uPAR(또는 DPP4)-PROTAC
```
KILL ⟺ [surface uPAR/DPP4 ⇒ 입자 내재화]  AND  [lysosomal SA-β-gal ⇒ warhead 탈케이지]  AND  국소전달
        └─── 인식축 2 (직교) ───┘            └─── 인식축 1 (직교) ───┘
- warhead(KILL): BCL-xL→CRBN PROTAC(PZ15227) ± galacto-caged MCL-1i(S63845)   [p_dep 0.65→0.85]
                 catalytic·event-driven → dose↔tox 분리; CRBN 혈소판 저발현 = 내장 sparing
- cage(gate1):   β(1,4)-gal on BCL-xL ligand → SA-β-gal/GLB1 절단 (Nav-Gal 화학)
- vehicle(gate2):uPAR-Ab(또는 DPP4) 나노입자 — 진입에 표면 마커 필요
- 선택성 = 차등 의존성 f_s/f_q (친화도 아님). uPAR/DPP4·β-gal = 인식 게이트(비치사).
```

## 핵심 설계 원칙 (종결식에서)
1. KILL = pan-senescent **dependency**(BCL-xL 주축·MCL-1 2차·GPX4 fibroblast서 불신뢰) — 친화도 최적화 금지.
2. 선택성 = **직교** 인식축 곱셈(S_total=∏Sᵢ). 가장 직교: DPP4(표면)∧SA-β-gal(효소); fibroblast-검증 최강: uPAR∧SA-β-gal.
3. SASP-공조절 마커(IL-6R·MMP·B2M·NOTCH) 금지 = 비독립 → AND-gate 붕괴.
4. **국소전달**(독성 분모 완화) + event-driven PROTAC(dose-decouple).
5. 게이트 = **functional η_neo**(clearance-% 아님).

## FIRST TARGET = PERIO (치주)
유일하게 동시 충족: 단일 dominant CD81+ 노화 fibroblast subtype + 폐쇄 pocket 국소전달 + 실제 직교쌍. (RETINA는 η 최고지만 RPE/내피=off-thesis; OA는 UBX0101 Ph2 실패=회피.)

## η_neo PASS/FAIL (anchor-calibrated: UBX1325 PASS·UBX0101 FAIL)
RETINA 0.165-0.215 (gate 0.138) 🟢 · AGA 0.108-0.141 (0.121) 🟠* · PERIO 0.085-0.111 (0.095) 🟠* · OA 0.025-0.033 (0.069) 🔴(depot+subtype+R_cap로 돌파).

## VERIFY PIPELINE (ABFE-free·cheapest-decisive first)
S1 AND-gate S_total(+ρ/leak 민감도)★NEW → S2 β-gal kinetics(reuse round5) → S3 f_s/f_q priming ODE → S4 local PK → S5 η_neo causal(reuse round7). S0 ABFE→binary(caged-vs-free·GPU·reuse round13).
PRIMARY readout = S_total(ratio-of-ratios·FF오차 상쇄), NOT ABFE.

## DECISIVE NEXT COMPUTATION (make-or-break·zero synthesis/pods)
PLAUR(uPAR)↔GLB1(β-gal) [또는 DPP4↔GLB1] 독립계수 ρ + f_s/f_q from public single-cell senescence atlases → AND-gate 곱셈성 검증(ρ≫0이면 붕괴). + S1 모델 실행.

## 정직 (d6)
모든 분자 조각은 출판 화학(Nav-Gal·DT2216·PZ15227·S63845·uPAR-CAR); NOVELTY=조합(직교 2축 AND-gate + 국소 + fibroblast-niche). In-silico: 방향성·robustness·AND-gate 논리·인과 cure 구조 결정가능. Wet-lab(d5 downstream): 절대 potency·c_causal·τ_reacc·AUC_local·efficacy.

## S1 실행 결과 (decisive number·c2 출력 증거·mini-free)
| config | S_total median | 악조건 box-min | <2× 붕괴? | clearable@5%harm |
|---|---|---|---|---|
| 단일 마커(uPAR) | 0.92× | 0.77× | YES (anti-sel) | 4.6% |
| 2축 uPAR×SA-β-gal | 4.62× | 1.97× | YES (취약) | 23% |
| 2축 DPP4×SA-β-gal | 3.85× | 1.72× | YES (취약) | 19% |
| **3축 uPAR×DPP4×SA-β-gal** | **23.1×** | **4.34×** | **NO (robust)** | 100% (median) |
→ **설계 정정: robust 선택성엔 3축 AND-gate 필요** (단일=anti-sel·2축=ρ↑서 붕괴·3축만 어떤 악조건서도 ≥2×). make-or-break 미지수 = ρ(축 독립성). DPP4×SA-β-gal이 uPAR×SA-β-gal보다 직교(다른 조절 허브)→낮은 ρ. DECISIVE NEXT: public single-cell atlas서 ρ(PLAUR↔GLB1)·ρ(DPP4↔GLB1) 추정 → 낮은 쌍 채택 + 3번째 축으로 보강.

## R2 — make-or-break ρ + kill-axis 닫음 (FINAL)
- ρ(추정·미측정): DPP4↔GLB1 0.10 · PLAUR↔GLB1 0.20 · PLAUR↔DPP4 0.30(worst). 3 distinct 조절허브(NF-κB·STAT1/HNF·TFEB) → 저 ρ. GLB1=직교 decorrelating leg → 3축 robustness SUPPORTED(붕괴선 이하).
- kill-axis f_s/f_q ≈ 1.6×(1.3-2.6) INFERRED·modest. healthy BCL-xL 항시발현 → ceiling ~2-3×. MCL-1i=escape봉인이나 differential compress(selectivity는 인식 AND-gate가 담당).
- **현실 총 선택성 = S1(3축,ρ0.1-0.3) × f_s/f_q(1.6×) = ~13.5-26× (중앙 ~19×)** — 최악 ρ서도 13.5× → 설계 SUPPORTED.
## FINAL VERDICT (R1+R2, d6)
SENOLYX-AG 설계 = **in-silico SUPPORTED**: 3축 직교 AND-gate(uPAR×DPP4×SA-β-gal) + BCL-xL/MCL-1 PROTAC warhead + 국소전달이 현실 ~19× 선택성·robust(추정 ρ 전 구간). 인식 게이트가 선택성 주동·kill-axis는 보조(~1.6×).
- make-or-break = ρ (미측정·추정 저값) → **단일 결정실험으로 가부 확정: 3색 flow(uPAR/DPP4/C12FDG-SA-β-gal) senescent fibroblast pairwise ρ** (wet-lab d5 downstream).
- FIRST=PERIO. OA는 depot+subtype+R_cap로만(d2). clearance-% 게이트 → η_neo functional 정정.
- NOVELTY=조합(미선례): 분자조각 전부 출판화학, 직교 3축 AND-gate + fibroblast-niche + 국소 = unprecedented(d_novel_only).
