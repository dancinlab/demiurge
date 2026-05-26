# X28 — index-patient 10년 Markov microsim (illustrative 대표 환자)

> CARDIO+ 메타도메인 X28 산출물 · current-state · no history.
> 목적 = 4-axis 층화 케어가 **한 환자의 10년 궤적**에 주는 차이를 정량 투사 — X6/X11/X15(self-case)의 개인 적용을 microsimulation으로 닫음.
> ⚠⚠ 환자 프로파일 = **ILLUSTRATIVE 대표 환자** (사용자 실제 의료 데이터 아님 · 의학적 조언/예후 아님 · 모든 출력은 모델 투사 ⚪ proposal · d6). transition rate는 기존 sub-V/M8 VERBATIM grounding.

---

## §1. 모델 정의

- **대표 환자**: 65세 · post-PCI · CYP2C19 IM(중간대사자) · Lp(a) ≥50 high · ALDH2\*2 carrier (한국 PCI 환자의 3-axis "위험 동반" 대표 케이스 — X9 §5 layered care 대상)
- **2 arm**: A = 표준(universal clopidogrel · Lp(a) 미관리 · IV-only) vs B = 3-axis 층화(IM→prasugrel 5mg · Lp(a)→PCSK9 · no-reflow IC)
- **4-state Markov** (ef event-free · st post-MI/ST · bl post-major-bleed · de death) · v5 §5 matrix 구조 · 10 annual cycle · `CARDIO+/DAPTPGX/sims/x28_patient_microsim.hexa` mini 실측

### 1.1 grounded 파라미터 (출처 라벨)

| param | 값 | 출처 |
|---|---|---|
| death_base | 0.025/yr | v5 §5 (post-PCI 65yo baseline) |
| IM clopidogrel ST | 0.010/yr | v7 FIX-B LoF gradient (NM 0.005 < **IM 0.010** < PM 0.015) |
| potent(prasugrel) ST | 0.004/yr | v5 st_ticag |
| bleed clopi / potent | 0.012 / 0.0122 | v5 bleed_clopi / pm_bleed_weighted |
| Lp(a) high 미관리 mult | ×1.20 | ⚪ illustrative (LPA 인과 β 방향) |
| Lp(a) 관리(PCSK9) mult | ×1.05 | ⚪ illustrative (부분 강하) |
| utilities ef/st/bl | 0.85/0.75/0.80 | ⚪ illustrative standard CEA |

→ Arm A ST/yr = 0.010×1.20 = **0.012** · Arm B ST/yr = 0.004×1.05 = **0.0042** (층화가 IM을 potent로 + Lp(a) 관리).

---

## §2. mini 실측 (VERBATIM)

```
--- Arm A (표준 universal clopidogrel · Lp(a) 미관리) ---
A_10y_alive       =0.747267
A_10y_event_free  =0.72145
A_10y_death       =0.252733
A_10y_QALY        =7.26516
A_10y_life_years  =8.57219

--- Arm B (3-axis 층화: IM→prasugrel · Lp(a)→PCSK9 · no-reflow IC) ---
B_10y_alive       =0.760113
B_10y_event_free  =0.742021
B_10y_death       =0.239887
B_10y_QALY        =7.33102
B_10y_life_years  =8.63922

--- Δ (B − A · illustrative 환자 1명 · 10년) ---
dQALY_10y         =0.0658581
dLifeYears_10y    =0.0670257
dDeath_10y        =-0.0128463   (음수=B 사망 감소)
dEventFree_10y    =0.0205704
```

| 지표 (10년) | A 표준 | B 3-axis 층화 | Δ (B−A) |
|---|---|---|---|
| 생존 | 74.7% | 76.0% | **+1.28pp** |
| event-free | 72.1% | 74.2% | +2.06pp |
| 사망 | 25.3% | 24.0% | −1.28pp |
| QALY | 7.27 | 7.33 | **+0.066** |
| life-years | 8.57 | 8.64 | +0.067 |

---

## §3. 정직한 해석 (d6)

- **방향**: 층화 케어(B)가 이 대표 환자에서 **modest 양성** — 10년 +0.066 QALY · +0.067 life-years · 사망 −1.28pp. 과장 없는 합리적 크기 (단일 환자 1명 · 연 ST 절대차 ~0.008).
- **크기 맥락**: 개인 1명의 절대 이득은 작으나(QALY +0.066), 한국 PCI 인구(연 ~8만)에 적용 시 누적은 X3 §3.2 ICER/X19 budget과 정합 — microsim은 개인, ICER는 인구 관점.
- **민감도 (X27 연계)**: 출력은 illustrative modifier(Lp(a) ×1.20/×1.05 · utilities)에 의존하는 **⚪ projection**. Lp(a) mult를 1.0으로 두면 Δ는 거의 DAPT(IM→potent) 단독 기여로 축소. 핵심 동인 = IM clopidogrel ST(0.010)→potent(0.0042) 강하 + 그에 따른 사망 cascade 감소. bleed는 B가 약간 높으나(potent) ST 이득이 상회.
- **honest 한계**: 단일 대표 환자 · 비할인(undiscounted) · 4-state 단순 Markov · 실제 환자 결과 아님. X25 wet-lab gate(IC-sync IIT) + 실측 cohort 전엔 인과 확정 아님 (X13 numerical→causal 경계).

## §4. CARDIO+ 연결
- X6/X11/X15 (self-case 개인 적용)의 **정량 microsim 마감** — "내 3축이면 10년에 얼마 차이?"에 illustrative 답.
- X3 §3.2 (ICER) · X19 (budget) = 인구 관점 ↔ X28 = 개인 관점 (동일 rate, 다른 단위).
- X27 UQ: 본 microsim은 modifier-민감 → modifier sweep이 후속 robustness 후보.

## ref
- mini 실측: `POOL_DISABLE=1 hexa run CARDIO+/DAPTPGX/sims/x28_patient_microsim.hexa`
- grounding: v5/v7 (ST/bleed rate) · v5 §5 (Markov matrix) · X3 §3.2 (v8 ICER) · X19 (budget) · X27 (UQ)
