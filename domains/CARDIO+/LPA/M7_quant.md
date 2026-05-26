# M7 — 잔여 위험 정량 (Lp(a) ↓ mg/dL × MACE ↓)

> 마일스톤 M7 산출물 · dose-response 정량 격자 = M8 ranking 직접 입력.
> 핵심 질문: **Lp(a)를 얼마나 낮춰야 MACE가 얼마나 감소하는가?**

---

## 1. 정량 프레임워크

- **1차 outcome**: MACE = CV death + 비치명 MI + 비치명 stroke + (urgent coronary revasc, trial-dependent)
- **dose-response 변수**:
  - Lp(a) 절대 감소 (mg/dL 또는 nmol/L)
  - Lp(a) 상대 감소 (%)
  - baseline level (≥ 50 vs ≥ 70 vs ≥ 175 mg/dL — risk-enriched)
  - follow-up 기간 (Mendelian = 평생 · Ph3 = 3-4년)
- **외삽 기준**: lifelong Mendelian RR/SD을 약물 RRR로 직접 환산 시 **~50% 효과 감쇠** 가정 (Ference 2017 인용)

---

## 2. Mendelian randomization — 인과 추정의 황금 표준

| 출처 | 변량 | 효과 추정 |
|---|---|---|
| **Burgess 2018 JAMA Cardiol** | Lp(a) 1-SD ↓ ≈ 50 nmol/L (~25 mg/dL) | **CHD HR 0.71** (95% CI 0.67-0.75) |
| Kamstrup 2009 Circulation (Copenhagen) | Lp(a) ≥ 80th vs < 22nd 백분위 | **MI HR ~2.5** |
| Clarke 2009 NEJM (PROCARDIS) | LPA SNP IV·V Kringle | CHD OR/log-Lp(a) ≈ 1.51 |
| Emdin 2016 JAMA | LPA loss-of-function variant | -CHD ~25% per 10 mg/dL ↓ (lifelong) |

→ **lifelong genetic Lp(a) ↓ 25 mg/dL ≈ CHD risk -29%**.
→ 약물로 같은 25 mg/dL ↓ 시 **단기(3-5년) RRR ~12-15%** 예상 (감쇠 ~50%).

```
Lp(a) 절대 ↓ (mg/dL)
0  ──┐
     │
-10  │     ┌── PCSK9i alone (Lp(a)≥50)
     │     │   ARR ~2%p · RRR ~17%
-25  │     │     ┌── Mendelian 1-SD lifelong
     │     │     │   RRR ~29% (Burgess)
-50  │     │     │     ┌── pelacarsen (HORIZON)
     │     │     │     │   예상 RRR 15-20%
-80  │     │     │     │     ┌── olpasiran (OCEAN(a))
     │     │     │     │     │   예상 RRR 18-25%
-100 ┘─────┴─────┴─────┴─────┴───────────────►
                MACE RRR (%)
```

---

## 3. statin/PCSK9 era 잔여 위험

- **FOURIER** (Sabatine 2017 NEJM, evolocumab on statin):
  - 1차 MACE: HR 0.85 (RRR 15% · ARR 1.5%p · 2.2y 평균)
  - = 잔여 risk **baseline의 ~30%** (statin 자체가 ~30% RRR, 위에 PCSK9i 15% RRR)
- **Lp(a) ≥ 50 mg/dL subset** (O'Donoghue 2019 Circulation):
  - PCSK9i가 Lp(a)를 약 -27% ↓ → MACE RRR **17%** (vs 전체 15%)
  - **modest Lp(a)-dependence** — PCSK9i의 Lp(a) ↓는 outcome benefit의 1/3 정도 기여
- **결론**: PCSK9 위의 잔여 ~30% 중 Lp(a)-driven 부분 = **약 8-12%p** (baseline 대비 ~3-4%p ARR)
- siRNA -95% deep reduction이 이를 표적 → **MACE RRR 추가 15-25% 예상**

---

## 4. HORIZON / OCEAN(a) 사전 power 추정

| trial | 분자 | n | f/u | Lp(a) ↓ | 절대 ↓ | powered for | readout |
|---|---|---|---|---|---|---|---|
| **HORIZON** (NCT04023552) | pelacarsen | 8,323 | 4.25y | -80% | ~50-80 mg/dL | RRR ~20% (HR 0.80) | 2026 H1 |
| **OCEAN(a)-Outcomes** (NCT05581303) | olpasiran | 7,297 | ~3y | -98% | ~60-120 mg/dL | RRR ~20% | 2027 H2 |
| **ACCLAIM-Lp(a)** (NCT06292013) | lepodisiran | 12,500 | ~5y | -94% | ~55-110 mg/dL | RRR ~15% | 2029 |

- HORIZON power 가정: baseline ≥ 70 mg/dL · 5-yr MACE ~13% control → 약 1,100 events at ~85% power
- **decision tree**:
  - **MACE -15~20% → 양성** (Ph3 success · Lp(a) 인과 확정)
  - **-5~10% → marginal** (subgroup-positive · regulatory 모호)
  - **0% → falsification** (Lp(a) ↓ ≠ MACE ↓ → Mendelian-약물 외삽 가설 붕괴)

---

## 5. 한국인 absolute risk reduction (ARR) 적용

- 한국인 Lp(a) ≥ 50 mg/dL 인구 = **~520만 명** (M2)
- ASCVD 2차 예방군 5년 MACE baseline = **15-20%** (KAMIR · CALAGB 등)
- Lp(a) ≥ 70 mg/dL 추가 hazard = **HR 1.3-1.5** (Patel 2021 · O'Donoghue 2019)
- 시나리오 (siRNA -95% · 5년):
  - Lp(a)-driven 위험분 ~25% × RRR 20% = **MACE ARR ~3-4%p**
  - **5-yr NNT ≈ 25-35**
- 1차 예방군 (Lp(a) ≥ 50 mg/dL · 무 prior MACE): baseline 5y MACE ~5-8% → NNT ~80-150

---

## 6. 외삽 한계 — 정량의 5가지 caveat

1. **ABS vs REL 비대칭** — 같은 -80%도 baseline 100 vs 50 mg/dL 시 절대 감소 2배 차이 → ARR/NNT는 baseline에 강 의존.
2. **lifelong vs late-life** — Mendelian은 평생 노출 · 약물은 3-5년 → RR 외삽 시 ~50% 감쇠 (Ference 2017 mendelian-vs-trial 메타 외삽).
3. **공동 변화 confounding** — siRNA/ASO가 Lp(a)만 ↓시키는지, 동반 LDL·apoB·oxPL 변화가 outcome에 기여하는지 분리 곤란 (특히 pelacarsen에서 LDL -10~15% 동반).
4. **측정 단위 bias** — mg/dL ↔ nmol/L 환산은 **isoform-dependent** (KIV-2 copy 별 분자량 다름). 동일 % 감소도 assay 별 다른 절대값 → trial-cross 비교 위험.
5. **KIV-2 copy 변이 → 약효 heterogeneity** — small isoform (high Lp(a)) carrier가 약효 ↑ 일 가능성. responder/non-responder 사전 layer 미정.

---

## 7. 정량 격자 (M8 ranking 직접 입력)

| 시나리오 | Lp(a) ↓ % | 절대 ↓ (mg/dL) | MACE RRR 추정 | 5-yr NNT | evidence tier |
|---|---|---|---|---|---|
| **PCSK9i alone, Lp(a)≥50** | -25~27% | -10~15 | ~17% | ~50 | 🟡 (FOURIER subset) |
| **pelacarsen (HORIZON)** | **-80%** | -50~80 | **15-20% (예상)** | **~25-30** | 🟠 → 2026 readout |
| **olpasiran (OCEAN(a))** | **-98%** | -60~120 | **18-25% (예상)** | **~20-25** | 🟠 → 2027 readout |
| lepodisiran (ACCLAIM) | -94% | -55~110 | 15-22% (예상) | ~20-30 | 🟠 → 2029 |
| zerlasiran (Q24W) | -82% | -45~85 | 15-20% (예상) | ~25-35 | 🟠 (Ph2 only) |
| **lifelong Mendelian 1-SD** | -25% (eq) | -25 | **~29% (Burgess)** | ~15 | 🟡 인과 외삽 |
| obicetrapib (CETP) | -50% | -25~40 | ~12-15% (Ph3 가설) | ~40 | 🟠 → BROADWAY |
| niacin (legacy) | -25% | -10~15 | 0% (AIM-HIGH/HPS2 falsified) | ∞ | 🔴 |

---

## 8. 정량 → M8 ranking 입력

- **ranking score 핵심 = ARR / NNT × evidence tier weight**
- **가장 강력 reduction**: olpasiran (-98% · NNT~20-25)
- **가장 강력 evidence (first-readout)**: pelacarsen (HORIZON 2026 H1)
- **가장 강력 duration**: lepodisiran (6-12개월 1회 dosing → adherence advantage)
- **가장 약한 stand-alone**: PCSK9i (Lp(a) 효과 modest · 주효 LDL 경유)

```
NNT 비교 (5y · Lp(a)≥50 · 2차 예방)
0    10   20   30   40   50   60
│────│────│────│────│────│────│
                       █████████████  PCSK9i alone (~50)
                  ████████████  obicetrapib (~40)
              ██████████  pelacarsen (~25-30)
            ████████  olpasiran (~20-25)
        █████  Mendelian (~15, 외삽)
```

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| Burgess 2018 MR 추정 (Lp(a) 1-SD ↓ → CHD HR 0.71) | 🟡 SUPPORTED-BY-CITATION | JAMA Cardiol 3:619 |
| Kamstrup 2009 percentile risk | 🟡 SUPPORTED-BY-CITATION | Circulation 117:176 |
| FOURIER Lp(a) ≥ 50 subset (RRR 17%) | 🟡 SUPPORTED-BY-CITATION | O'Donoghue 2019 Circulation 139:1483 |
| Ph3 outcome RRR 15-25% 예상 | 🟠 INSUFFICIENT/DEFERRED | HORIZON 2026 · OCEAN(a) 2027 readout 후 🟢/🔴 확정 |
| 한국인 NNT 25-35 추정 | 🟠 INSUFFICIENT/DEFERRED | 한국 시판/RWD 후향 분석 대기 |
| Mendelian → 약물 50% 감쇠 외삽 가정 | 🟠 INSUFFICIENT/DEFERRED | Ph3 readout이 외삽 검증 |

🔑 핵심 통찰:
- **Burgess 2018 Mendelian = 인과 외삽의 황금 표준** → Lp(a) 1-SD ↓ ≈ CHD -29% (lifelong).
- **약물 외삽 시 ~50% 감쇠 가정** → siRNA -95% 시 단기 **MACE RRR 15-25% 예상 · 5y NNT ~20-30**.
- **Ph3 readout (HORIZON 2026 · OCEAN(a) 2027)** = Lp(a) 인과 가설의 결정적 분기점 — falsifiable.
- 한국인 ≥ 50 mg/dL 520만 명 · 2차 예방 군 적용 시 **NNT ~25-35** → high-impact public-health intervention.

---

## 10. 참고문헌

- Burgess S et al. (2018) *JAMA Cardiol* 3:619 — Mendelian Lp(a) 1-SD ↓ → CHD HR 0.71
- Kamstrup PR et al. (2009) *Circulation* 117:176 — Copenhagen percentile risk
- Clarke R et al. (2009) *NEJM* 361:2518 — PROCARDIS LPA SNP
- Emdin CA et al. (2016) *JAMA* 316:638 — LPA LoF · per-mg/dL effect
- Ference BA et al. (2017) *JAMA* 318:947 — Mendelian-trial 외삽 메타
- Sabatine MS et al. (2017) *NEJM* 376:1713 — FOURIER 본체
- O'Donoghue ML et al. (2019) *Circulation* 139:1483 — FOURIER Lp(a) subset
- Tsimikas S et al. (2020) *NEJM* 382:244 — pelacarsen Ph2
- O'Donoghue ML et al. (2022) *NEJM* 387:1855 — olpasiran Ph2 (-98%)
- Nicholls SJ et al. (2024) *JAMA* 332:1986 — obicetrapib Ph2
- HORIZON (NCT04023552) · OCEAN(a)-Outcomes (NCT05581303) · ACCLAIM-Lp(a) (NCT06292013)
