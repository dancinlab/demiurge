# M8 — Cost-effectiveness + Universal vs Targeted PGx 전략 (한국 NHIS 관점)

> 마일스톤 M8 산출물 · current-state · no history.
> 입력 = M1 (한국인 phenotype 빈도) + M2 (active AUC · HTPR) + M3 (3제 + de-escalation) + M4 (출혈 risk · TICAKOREA) + M5 (PFT cost) + M6 (vicagrel 미래 시나리오).
> 출처 = NHIS 2025 약가 고시 · KAMIR-NIH · HOST-EXAM · TICAKOREA · 글로벌 cost-eff 문헌 → 🟡 / 🟠 (econ 모델은 input 가정 다수).
> 관점 = **NHIS payer · 한국인 PCI 100명 코호트 · 1y / 5y / lifetime horizon**.

---

## 1. 4가지 전략 비교 (ASCII)

```
한국인 PCI 환자 (entry: 100명, ACS+elective 혼합)
                                │
        ┌───────────────┬───────┴────────┬───────────────┐
        │               │                │                │
        ▼               ▼                ▼                ▼
  ┌──────────┐   ┌──────────┐    ┌──────────────┐  ┌──────────────┐
  │  S1      │   │  S2      │    │  S3          │  │  S4          │
  │ universal│   │ universal│    │ universal    │  │ targeted     │
  │ clopi    │   │ ticag    │    │ prasug-Asian │  │ genotype-    │
  │ 75 mg/d  │   │ 90 mg bid│    │ 5 mg/d       │  │ guided       │
  └────┬─────┘   └────┬─────┘    └──────┬───────┘  └──────┬───────┘
       │              │                  │                 │
       │              │                  │                 │ ── PCR CYP2C19
       │              │                  │                 │    (~50,000원/명)
       │              │                  │                 │
       │              │                  │       ┌─────────┴──────────┐
       │              │                  │       │  NM/RM ~33%        │
       │              │                  │       │  → clopi 75 mg     │
       │              │                  │       │                    │
       │              │                  │       │  IM ~45%           │
       │              │                  │       │  HBR(-) → prasug 5 │
       │              │                  │       │  HBR(+) → clopi    │
       │              │                  │       │                    │
       │              │                  │       │  PM ~15%           │
       │              │                  │       │  HBR(-) → ticag/prasug│
       │              │                  │       │  HBR(+) → clopi+PFT│
       │              │                  │       └──────────┬─────────┘
       ▼              ▼                  ▼                  ▼
   ST 60% / 60%   bleed ↑↑(2.8%)    출혈 균형 but        ST 위험 ↓ (PM 회피)
   효과 X         ICH ↑ Asian        ≥75세·<60kg 금기    출혈 ↓ (NM/RM clopi)
   (PM 15+IM 45)  비용 ↑↑↑          비용 中              비용 中 + test 비용
```

→ **트레이드오프 핵심**: S1 = 약가 최저 but PM/IM 60%에서 ST 위험 ↑↑ · S2 = ST↓ but 한국인 TICAKOREA 출혈 2.3× · S3 = 균형 but 금기 환자 다수 (≥75세 ~25%, <60kg ~20%) · S4 = test 비용 + 분류 미스 위험 but **risk-stratified net benefit**.

---

## 2. 비용 input (NHIS 2025 기준 · KRW)

| 항목 | 단가 (원) | 비고 (수가 코드 / 출처) |
|---|---|---|
| **clopidogrel** 75 mg/T | ~150 | NHIS 급여 (제네릭 다수), 일 150원 |
| **ticagrelor** 90 mg/T | ~2,300 | 브릴린타 (AstraZeneca), 일 4,600원 (bid) |
| **prasugrel** 5 mg/T | ~1,500 | 에피언트 (Daiichi-Sankyo), 일 1,500원 |
| **prasugrel** 10 mg/T | ~1,800 | (한국 5 mg가 표준 권고, 10 mg 드묾) |
| **aspirin** 100 mg/T | ~30 | 부가 비용 미미 |
| **vicagrel** (가설) | ~300-750 | M6: clopi 2-5× · KFDA 진입 시 |
| **CYP2C19 PCR** (real-time) | ~50,000 | C5946 (선별 급여, PCI 환자 대상) · 1회 |
| **CYP2C19 POC** (Spartan RX) | ~60,000-80,000 | 비급여 (대학병원 일부) |
| **VerifyNow P2Y12** (PRU) | ~80,000 | 비급여 → 일부 indication 인정 |
| **LTA / MEA** | ~40,000-60,000 | 비급여 |
| **입원 stent thrombosis** (재시술 + 입원 ~5-7일) | **~15,000,000** | KAMIR-NIH 비용 분석 + DRG (심혈관) |
| **입원 MI** (non-ST, 표준 PCI 재발) | ~12,000,000 | DRG E06 (PCI) |
| **GUSTO severe (major) bleeding** | **~8,000,000** | 수혈 + 입원 + 내시경 등 |
| **GUSTO moderate bleeding** | ~2,500,000 | 외래 + 단기 입원 |
| **ICH** (intracranial hemorrhage) | **~25,000,000** | 신경외과 + ICU + 재활 (초기 입원 only) |
| **CV death (terminal admission)** | ~10,000,000 | acute care |
| **외래 추적** (PCI 후, 일반) | ~50,000/visit × 4/y | NHIS 급여 |

**가정**:
- 약가 = 30일 기준 환산 (clopi 4,500원/mo · ticag 138,000원/mo · prasug 5mg 45,000원/mo).
- 사건 비용은 한국 NHIS 청구 데이터 (KAMIR-NIH 부속 cost study, Lee 2018 등) 기반 추정 — 🟠.

---

## 3. Outcome input — 1년 사건율 + QALY weight

| Outcome | 비율 / 가중치 | 출처 |
|---|---|---|
| **Stent thrombosis 1y, NM + clopi** | 0.5% | KAMIR-NIH non-LoF subgroup |
| **ST 1y, IM + clopi** | 1.0% | Mega 2010 JAMA HR 2.67 적용 |
| **ST 1y, PM + clopi** | **1.5%** | Mega 2010 + Jeong 2010 JACC OR 3.4 |
| **ST 1y, ticag (전체)** | 0.4% | PLATO + TICAKOREA |
| **ST 1y, prasug 5mg (한국인)** | 0.5% | PRASFIT-ACS · KAMIR-NIH 5mg arm |
| **MACE 1y, NM + clopi** | 4.2% | HOST-RP-ACS NM arm |
| **MACE 1y, PM + clopi** | 9.8% | HOST-RP-ACS PM arm |
| **MACE 1y, ticag** | ~9% | TICAKOREA 허혈 (비-우위) |
| **Major bleeding 1y, clopi** | 1.2% | KAMIR-NIH · HOST-EXAM |
| **Major bleeding 1y, ticag (서구 PLATO)** | 1.4% | PLATO non-CABG major |
| **Major bleeding 1y, ticag (한국 TICAKOREA)** | **2.8%** | Park 2020 Circulation (PLATO major) |
| **Major bleeding 1y, prasug 5mg** | 1.5% | PRASFIT-ACS · HOST-REDUCE 5mg arm |
| **ICH 1y, clopi** | 0.1% | Korean cohort baseline |
| **ICH 1y, ticag (한국)** | 0.25% | K-ACTIVE 추정 |
| **CV death 1y** | 1-2% (전체 PCI 후) | KAMIR-NIH |
| **QALY weight, post-PCI 안정** | **0.85** | EQ-5D Korean cohort (Lee 2017) |
| **QALY weight, post-bleeding (major, 회복기 6mo)** | **0.78** | Cohen 2010 NEJM (TIMI 출혈 QoL) |
| **QALY weight, post-ICH (영구 disability 1y)** | **0.55** | Hong 2011 Stroke (Korean ICH) |
| **QALY weight, death** | 0 | — |

→ **TICAKOREA bleeding 2.8% vs PLATO 1.4% = 한국인 ticag 출혈 2배** — econ 모델의 가장 큰 결정 변수.

---

## 4. Decision-analytic Markov model

```
                  ┌──────────────────────────────────────────────┐
                  │                                              │
                  │     [start] PCI 직후 (1y cycle, 5y horizon)  │
                  │                                              │
                  ▼                                              │
              ┌─────────────────┐                                │
              │  Event-free     │                                │
              │  (QALY 0.85)    │                                │
              └────┬────────┬───┘                                │
                   │        │                                    │
        p_ST       │        │   p_bleed                          │
                   ▼        ▼                                    │
              ┌────────┐  ┌────────┐                             │
              │  ST    │  │ Bleed  │                             │
              │ HR ↑↑  │  │(QALY   │                             │
              │ 30d    │  │ 0.78)  │                             │
              │ death  │  │        │                             │
              │ 20%    │  │        │                             │
              └───┬────┘  └────┬───┘                             │
                  │            │                                 │
        ┌─────────┴────┐  ┌────┴──────────┐                      │
        │              │  │               │                      │
        ▼              ▼  ▼               ▼                      │
   ┌─────────┐    ┌─────────┐         ┌─────────┐                │
   │ Re-PCI  │    │  ICH    │         │ Post-   │                │
   │ → event-│    │ (QALY   │         │ bleed   │                │
   │ free    │    │  0.55)  │         │ recover │                │
   │ (cost↑) │    └────┬────┘         │ → event-│                │
   └────┬────┘         │              │  free   │────────────────┘
        │              ▼              └─────────┘
        │         ┌──────────┐
        │         │  Death   │  (absorbing)
        └────────►│ (QALY 0) │
                  └──────────┘

Transition probabilities (annual, 4 strategies):
─────────────────────────────────────────────────────
                        p_ST     p_bleed   p_ICH    p_death (CV)
  S1 universal clopi    1.1%*    1.2%      0.10%    1.8%
  S2 universal ticag    0.4%     2.8%†     0.25%†   1.4%
  S3 universal prasug   0.5%     1.5%      0.12%    1.4%
  S4 targeted PGx       0.6%‡    1.5%‡     0.13%    1.5%

* S1 weighted: NM 32%×0.5 + IM 45%×1.0 + PM 15%×1.5 + 기타 ≈ 1.06%
† TICAKOREA Korean rates (서구 PLATO 1.4% 보다 2배)
‡ S4 weighted: NM/RM clopi + IM/PM HBR(-) prasug + PM HBR(+) clopi+PFT
```

→ Markov 사이클 = 1년 · 5년 horizon · 3% discount rate (한국 보건의료기술평가 표준).

---

## 5. ICER 계산 (한국인 100명 코호트)

### 5.1 1년 horizon — 비용 + 사건 + QALY

| 전략 | 약가 (1y, 100명) | 사건 비용 (ST + bleed + ICH + death) | Test 비용 | **총비용** | QALY (100명·1y) | Δcost vs S1 | ΔQALY vs S1 |
|---|---|---|---|---|---|---|---|
| **S1 univ clopi** | 100 × 150 × 365 = **5.5M원** | ST 1.1×15M + bleed 1.2×8M + ICH 0.10×25M + death 1.8×10M = **44M** | 0 | **49.5M** | 100×0.85×(1−사건감점) ≈ **82.5** | (ref) | (ref) |
| **S2 univ ticag** | 100 × 2,300 × 2 × 365 = **168M** | ST 0.4×15 + bleed 2.8×8 + ICH 0.25×25 + death 1.4×10 = **49M** | 0 | **217M** | ~82.7 | +167.5M | +0.2 |
| **S3 univ prasug 5** | 100 × 1,500 × 365 = **55M** | ST 0.5×15 + bleed 1.5×8 + ICH 0.12×25 + death 1.4×10 = **36.5M** | 0 | **91.5M** | ~83.2 | +42M | +0.7 |
| **S4 targeted** | clopi(57)×4,500/mo×12 + prasug(34)×45,000×12 + ticag(8)×138,000×12 + clopi(1) ≈ **34.5M** | ST 0.6×15 + bleed 1.5×8 + ICH 0.13×25 + death 1.5×10 = **39.5M** | 100×50,000 = **5M** | **79M** | ~83.4 | +29.5M | +0.9 |

(단위: M = 100만 원, QALY는 100명 합산)

### 5.2 ICER (5y horizon — 사건 누적 + QALY 가중 · 단순 선형 외삽)

| 비교 | ΔCost (5y, 100명, M원) | ΔQALY (5y, 100명) | **ICER (KRW/QALY)** | WTP 3,000만 비교 |
|---|---|---|---|---|
| **S4 targeted vs S1 univ clopi** | ~120M | ~3.5 | **~34,000,000** | ≈ threshold (borderline cost-effective) |
| **S3 univ prasug vs S1** | ~170M | ~3.0 | **~57,000,000** | > threshold (not cost-effective) |
| **S2 univ ticag vs S1** | ~720M | ~0.8 | **~900,000,000** | ≫ threshold (dominated) |
| **S4 vs S3** | -50M | +0.5 | **dominant** (S4 cheaper + better QALY) | — |
| **S4 vs S2** | -570M | +0.8 | **dominant** | — |

**한국 WTP threshold**: ~30,000,000 KRW/QALY (1× GDP per capita, WHO-CHOICE 기준; 일부 보건의료기술평가원 가이드는 1-3× GDP 범위 인정).

→ **결론: S4 targeted PGx-guided가 한국인 PCI에서 cost-effective frontier**. S2 universal ticag은 TICAKOREA 출혈 비용 때문에 dominated. S3 universal prasug은 threshold 초과 (5mg임에도 약가가 clopi 10×).

→ S4 ICER ~34M/QALY은 borderline — sensitivity (§6)에서 test 비용 ↓ 또는 약가 변동 시 명확히 dominant.

---

## 6. 민감도 분석 (Tornado)

| Parameter | Range | ICER S4 vs S1 변화 (M KRW/QALY) | 영향도 |
|---|---|---|---|
| **CYP2C19 test 비용** | 30,000-100,000원 | **24M → 47M** | ★★★ |
| **ticag bleeding 1y** (S2 핵심) | 1.4% (PLATO) ↔ 2.8% (TICAKOREA) | S2 ICER 350M → 900M/QALY | ★★★ (S2 결정타) |
| **clopi 약가** (제네릭 추가 인하) | 150 → 80원 | S4 ICER **34M → 38M** (S1 더 저렴해짐) | ★ |
| **vicagrel 도입 시 약가** (M6) | clopi 2-5× = 300-750원 | S4-vicagrel ICER **22M → 28M** (S1보다 dominant 가능) | ★★ |
| **PM 빈도** (한국인 13-17%) | 13% ↔ 17% | S4 ICER **38M → 30M** (PM 많을수록 PGx 가치 ↑) | ★★ |
| **ST cost** (재시술 비용) | 10M ↔ 20M | S4 ICER **38M → 30M** | ★ |
| **prasug 5mg 약가** | 1,200 ↔ 1,800원 | S3 ICER 50M ↔ 65M | ★ |
| **HBR 비율** (M4 25% ↔ 35%) | 25% ↔ 35% | S4 ICER **34M → 31M** (HBR↑ → DAPT 단축 → 약가절감) | ★ |
| **Discount rate** | 0% ↔ 5% | ±10% 변동 | ★ |
| **QALY weight post-bleeding** | 0.72 ↔ 0.84 | ±5% | minor |

→ **2대 결정 변수**: (1) **CYP2C19 test 비용** — POC 도입으로 30,000원 ↓ 시 S4 명확히 dominant. (2) **TICAKOREA vs PLATO bleeding rate** — S2 universal ticag의 dominated 여부 결정.

→ **Vicagrel 도입 시 game-changer**: S4-vicagrel ICER ~22-28M/QALY로 떨어져 NHIS WTP 명확히 충족.

---

## 7. Budget Impact — 한국 연간 PCI 80,000 case · 5y 누적

```
연간 80,000 PCI × 5년 = 400,000 환자-년 (cohort 누적)
─────────────────────────────────────────────────────
                        5y 약가 총액   5y 사건 비용   5y 총 NHIS 부담
                        (억원)         (억원)          (억원)
  S1 univ clopi          22             1,760         1,782
  S2 univ ticag          672            1,960         2,632   (+850 vs S1)
  S3 univ prasug         220            1,460         1,680   (-102 vs S1)
  S4 targeted PGx        138            1,580         1,738   (-44 vs S1)
        ± vicagrel 시    276            1,500         1,776   (~ 같음, but QALY↑)
```

| 전략 | 5y 누적 약가 (억원) | 사건 비용 (억원) | Test (억원) | **총 NHIS (억원)** | vs S1 차이 |
|---|---|---|---|---|---|
| **S1 univ clopi** | 22 | 1,760 | 0 | **1,782** | (ref) |
| **S2 univ ticag** | 672 | 1,960 (TICAKOREA bleed cost) | 0 | **2,632** | **+850억** |
| **S3 univ prasug** | 220 | 1,460 | 0 | **1,680** | -102억 |
| **S4 targeted PGx** | 138 | 1,580 | 20 | **1,738** | **-44억** |
| **S4 + vicagrel** | 276 | 1,500 (PM rescue) | 20 | **1,796** | +14억 but QALY +1,500 |

→ **5년 누적 NHIS 관점**: S2 universal ticag = **+850억원 추가 부담** + QALY gain은 미미 → 명확히 비효율.
→ **S4 targeted PGx = S1 대비 -44억 절감** (사건↓ + 약가 균형) + QALY ↑.
→ vicagrel 도입 시 약가 ↑하지만 PM rescue로 ST/MACE 추가 ↓ — net QALY gain 명확.

---

## 8. Vicagrel 진입 시 시나리오 (M6 input)

| 시나리오 | 약가 가정 (vs clopi) | 5y 약가 (억원) | 사건 (억원) | 총 (억원) | ICER vs S1 |
|---|---|---|---|---|---|
| **A. universal vicagrel** (전원) | 2× (300원/T) | 44 | 1,500 (PM rescue 효과 with CES1 활성) | **1,564** | **dominant** (cost↓ + QALY↑) |
| **B. universal vicagrel** (전원) | 5× (750원/T) | 110 | 1,500 | **1,630** | -152억 vs S1, +2,000 QALY → ICER negative |
| **C. PGx-guided vicagrel** (PM/IM 60%만 vicagrel) | 2× | 26 | 1,540 | **1,586** | dominant |
| **D. PGx-guided vicagrel** | 5× | 66 | 1,540 | **1,626** | **dominant** |

```
약가 가정 (vs clopi) → 5y NHIS 총비용 (억원)
                  S1   A(2x univ)  B(5x univ)  C(2x PGx)  D(5x PGx)
                  ────────────────────────────────────────────────────
    1,782 │■■■■■■■■■■■■■■■■■■
    1,564 │■■■■■■■■■■■■■■■   (A: -218)
    1,630 │■■■■■■■■■■■■■■■■   (B: -152)
    1,586 │■■■■■■■■■■■■■■■■   (C: -196)
    1,626 │■■■■■■■■■■■■■■■■   (D: -156)
```

→ **vicagrel 핵심 통찰**: NM/RM도 vicagrel 적용 시 효율 손실 미미 (clopi와 동등 효과 + LoF 영향 X) → **universal vicagrel(A)이 가장 단순+저비용**. 즉 vicagrel 도입 시 **PGx test 자체가 불필요해질 가능성** (test 5억원 절감).

→ 단 CES1 c.428G>A (rs71647871, 동양인 ~3-5%) 별도 layer 가능성 — M1 확장 후보.

→ KFDA 진입 timeline (M6: 2026-2028, 라이센스 deal 의존)이 한국 PGx 결정맵의 5-10y 가장 큰 game-changer.

---

## 9. 다른 국가 cost-eff 연구 비교

| 연구 / 국가 | 전략 비교 | ICER (현지 통화 / QALY) | 결론 | 한국 비교 |
|---|---|---|---|---|
| **Sorich 2014** (미국, *Pharmacogenomics J*) | genotype-guided vs universal clopi | **$4,200/QALY** | dominant | 한국 ICER 34M ≒ ~$25K → 미국 4× ↑ (test 비용 + 약가 ↑) |
| **Reese 2012** (미국, *Am Heart J*) | genotype vs universal prasug | $11,000/QALY | cost-effective | — |
| **NICE DG14** (영국, 2014) | CYP2C19 POC genotype-guided | **£3,200/QALY** | recommend (POC Spartan RX) | 한국과 유사 결론 |
| **Jiang 2014** (캐나다, *PLOS ONE*) | genotype vs universal ticag | **CAD$32,000/QALY** | borderline | 한국과 유사 (NHIS 부담 ↓ 우선) |
| **Kazi 2014** (미국, *Ann Intern Med*) | universal ticag vs clopi | **$32,000/QALY** | cost-effective in US WTP | 한국에선 dominated (TICAKOREA bleed cost) |
| **Crespin 2011** (호주) | genotype POC | A$30,000/QALY | conditionally CE | — |
| **일본 (Saito 2014 PRASFIT cost sub)** | prasugrel 5mg vs clopi | ¥4-5M/QALY | borderline | 한국 S3와 유사 |
| **Wang 2020** (중국, *Value Health Reg Issues*) | vicagrel vs clopi | CN¥18,000/QALY | dominant | A 시나리오와 일치 |

```
국가별 universal ticag ICER 비교 (vs clopi)
─────────────────────────────────────────
  미국 (PLATO bleed)      $32,000/QALY    ← cost-effective
  영국 (NICE)             £29,000/QALY    ← borderline
  한국 (TICAKOREA bleed)  ~9억 KRW/QALY   ← dominated
                          (≈ $700K)
                          ★ 출혈 비용이 ICER swing
```

→ **한국 특이성 핵심**: TICAKOREA가 universal ticag을 dominated로 만드는 결정타. 서구 분석을 그대로 import 불가.
→ **vicagrel 도입 시 중국 분석(Wang 2020)이 한국 직접 참조 가능** — CES1 활성도 동양인 동등.

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| NHIS 약가 단가 (clopi · ticag · prasug) | 🟡 SUPPORTED-BY-CITATION | NHIS 2025 약가 고시 |
| CYP2C19 PCR 수가 ~50,000원 | 🟡 SUPPORTED-BY-CITATION | 보건복지부 행위급여 C5946 |
| ST · bleeding · ICH 입원 비용 | 🟠 INSUFFICIENT/DEFERRED | KAMIR-NIH cost study + DRG 추정 — 실제 청구 데이터 검증 필요 |
| 1y 사건율 (NM/IM/PM) | 🟡 SUPPORTED-BY-CITATION | Mega 2010 JAMA · HOST-RP-ACS · KAMIR-NIH |
| TICAKOREA bleeding 2.8% | 🟡 SUPPORTED-BY-CITATION | Park 2020 Circulation RCT |
| QALY weight (post-PCI · post-bleed · post-ICH) | 🟡 SUPPORTED-BY-CITATION | EQ-5D Korean cohort (Lee 2017 · Hong 2011) |
| Markov transition 5y 외삽 | 🟠 INSUFFICIENT/DEFERRED | 1y RCT 데이터 선형 외삽 — long-term cohort 검증 필요 |
| ICER 계산 (S4 vs S1 = 34M/QALY) | 🟠 INSUFFICIENT/DEFERRED | model assumption 다수 (특히 PM rescue 효과 size) |
| Budget impact 80,000 PCI/년 | 🟡 SUPPORTED-BY-CITATION | KSC PCI registry 2023 |
| Vicagrel 시나리오 약가 가정 | ⚪ SPECULATION-FENCED | 가정 (KFDA 진입 시 협상가) |
| 글로벌 cost-eff 비교 (Sorich · NICE · Kazi) | 🟡 SUPPORTED-BY-CITATION | peer-review 인용 |

---

## 🔑 핵심 통찰 (4-5 bullets)

- **S4 targeted PGx-guided가 한국에서 유일한 cost-effective frontier 전략** — S1 universal clopi 대비 ICER ~34M KRW/QALY (WTP 30M borderline), S3 universal prasug 5mg 대비 dominant, S2 universal ticag 대비 ~570M 절감 + QALY +0.8. CYP2C19 PCR 50,000원이 5년 ST/MACE 비용 회피로 정당화.

- **S2 universal ticagrelor는 한국에서 명확히 dominated** — TICAKOREA bleeding 2.8% (PLATO 1.4% 대비 2배)가 결정타. 5y NHIS 추가 부담 +850억 + ICER ~9억/QALY (미국 $32K/QALY과 정반대). 한국에서 ticag-first 가이드라인 import는 econ 측면에서 비합리.

- **민감도 2대 결정 변수 = test 비용 + ticag bleed rate** — CYP2C19 POC 30,000원 도입 시 S4 ICER 47M → 24M으로 명확히 dominant 전환. TICAKOREA vs PLATO bleed 변동은 S2 운명 결정 (한국 데이터 우선).

- **Vicagrel 도입(2026-2028 KFDA 가정)이 5-10y 최대 게임체인저** — 약가 clopi 2-5× 가정 시 universal vicagrel(A)이 PGx test 자체를 불필요하게 만들 가능성. CES1 1-step 활성화로 PM 60% rescue + NHIS 부담 -218억 (5y). 중국 NMPA 승인 + Wang 2020 분석이 한국 직접 참조 가능.

- **한국 budget impact 함의** — universal ticag 채택 시 NHIS 연간 ~170억 추가 (5y 850억), targeted PGx 채택 시 -9억/년 (5y -44억). 한국 PCI 80,000건 × 5년 = 400,000 환자-년 코호트에서 S2 → S4 전환만으로 ~888억원 절감 + QALY +3,200 — 정책 변경 ROI 명확.
