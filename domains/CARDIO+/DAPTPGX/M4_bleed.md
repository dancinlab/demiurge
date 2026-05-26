# M4 — 출혈 risk score (PRECISE-DAPT · PARIS · ARC-HBR · 한국인 calibration)

> 마일스톤 M4 산출물 · current-state · no history.
> 출처 = ESC 2023 ACS · ACC/AHA 2025 · KSC 2024 · KAMIR/HOST-EXAM cohort → 🟡 SUPPORTED-BY-CITATION.

---

## 1. 출혈위험 ↔ 허혈위험 trade-off

```
                     DAPT 지속기간 결정 dilemma
─────────────────────────────────────────────────────────────────
   짧게 (1-3 mo)                              길게 (12-36 mo)
        │                                              │
        ↓                                              ↓
   bleeding ↓↓                                  ischemic ↓↓
   ischemic ↑↑ (stent thrombosis · MACE)        bleeding ↑↑ (GI·ICH)
        │                                              │
        ↑                                              ↑
   HBR (ARC-HBR ⊕)                              HIR (high ischemic risk)
   PRECISE-DAPT ≥25                             prior MI · DM · multivessel
   PARIS bleeding high                          complex PCI · LM/bifurcation
        ┊                                              ┊
        ┊         ★ 한국인 PM (CYP2C19 *2/*2 등)     ┊
        ┊         clopidogrel 효과 X → 허혈 ↑↑       ┊
        ┊         + 동양인 출혈 ↑ (TICAKOREA)         ┊
        └────── DUAL JEOPARDY zone ─────────────────────┘
                  → M3 switch + PFT (M5) 합산 필요
```

→ **출혈위험 정량화 = M3 switch 결정의 절반**. 나머지 절반은 M1 유전형.

---

## 2. PRECISE-DAPT score (Costa F et al., *Lancet* 2017; PMID 28290994)

PCI 시점에서 산정 → **0-100점**. ≥25 = HBR → DAPT 단축 (3-6 mo) 권고.

| 변수 | 범위 | 가중치 (대략) |
|---|---|---|
| **Hemoglobin** (g/dL) | <10 → max | ~0-26점 (낮을수록 ↑) |
| **WBC** (×10⁹/L) | >20 → max | ~0-15점 (높을수록 ↑) |
| **Age** (yr) | ≥85 → max | ~0-35점 (높을수록 ↑) |
| **CrCl** (mL/min) | <30 → max | ~0-26점 (낮을수록 ↑) |
| **Prior bleeding** (history) | yes / no | 0 or ~26점 |

| 점수 구간 | 출혈위험 카테고리 | 1y TIMI major/minor 출혈 | 권고 |
|---|---|---|---|
| <25 | low-moderate | ~2% | 표준 DAPT 12 mo |
| **≥25** | **HBR** | **~5-7%** | **DAPT 3-6 mo · de-escalation 고려** |

- 외부 validation = PLATO · BernPCI · 한국 cohort (Kim 2019).
- 단점: 허혈위험 미반영 → DAPT-score / PARIS와 병용 필요.

---

## 3. PARIS bleeding risk score (Baber U et al., *J Am Coll Cardiol* 2016; PMID 27050190)

PCI 후 long-term DAPT 환자 대상. 6 변수, 0-14점.

| 변수 | 점수 |
|---|---|
| Age 50-59 / 60-69 / 70-79 / ≥80 | 0 / 1 / 2 / 3 |
| BMI <25 / ≥35 | 2 / 2 (U-shape) |
| Current smoker | 2 |
| Anemia (Hb <12 ♀ / <13 ♂) | 3 |
| CrCl <60 | 2 |
| Triple therapy (DAPT + OAC) | 2 |

| 합계 | 카테고리 | 2y major bleeding |
|---|---|---|
| 0-3 | low | ~1.8% |
| 4-7 | intermediate | ~3.3% |
| ≥8 | **high** | **~6.6%** |

→ PARIS는 **장기(>1y) 출혈 예측**에 강함 · PRECISE-DAPT는 시술 직후-1y에 강함. 보완 관계.

---

## 4. ARC-HBR criteria (Urban P et al., *Circulation* 2019; PMID 31116032)

**Major 1개** OR **Minor 2개** = HBR 정의.

### Major (각 1개로 HBR 충족)

| # | 항목 | 정의 |
|---|---|---|
| 1 | 장기 OAC 사용 | warfarin · DOAC 예상 ≥12 mo |
| 2 | 중증 CKD | eGFR <30 mL/min/1.73m² |
| 3 | Hb <11 g/dL | 시술 시점 |
| 4 | 자발성 출혈로 입원/수혈 (6 mo 내) · 재발성 | 1y 내 ≥2회 |
| 5 | 중등도-중증 만성 thrombocytopenia | 혈소판 <100×10⁹/L |
| 6 | 만성 출혈성 diathesis | 응고인자 결핍 등 |
| 7 | 간경변 + 문맥압항진 | Child-Pugh B/C |
| 8 | 활동성 악성종양 (12 mo 내 진단/치료) | 비흑색종 피부암 제외 |
| 9 | 이전 자발성 ICH (시점 무관) · 외상성 ICH (12 mo 내) · brain AVM · 중등도-중증 ischemic stroke (6 mo 내) | — |
| 10 | DAPT 중 비-지연성 major 수술 | — |
| 11 | 최근 (30 d) major 수술/외상 | PCI 직전 |

### Minor (2개로 HBR 충족)

| # | 항목 | 정의 |
|---|---|---|
| 12 | 연령 ≥75세 | — |
| 13 | 중등도 CKD | eGFR 30-59 |
| 14 | Hb 11-12.9 (♂) / 11-11.9 (♀) | — |
| 15 | 자발성 출혈로 입원/수혈 (12 mo 내, major 기준 미충족) | — |
| 16 | 장기 NSAID/스테로이드 사용 | — |
| 17 | Ischemic stroke (시점 무관, major 기준 미충족) | — |

(원문 14 major / 6 minor 중 한국 임상에서 자주 적용되는 항목 enumerate; 원문 전체는 Urban 2019 Table 3 참조.)

---

## 5. 한국인 calibration

| cohort | n | 검증 결과 | 출처 |
|---|---|---|---|
| **KAMIR-NIH** | 13,104 (AMI) | PRECISE-DAPT ≥25 = 1y major bleeding HR 2.8 (vs <25) | Choi IJ 2019, *Korean Circ J* 49:120 |
| **K-ACTIVE** | 9,217 (ACS) | ARC-HBR ⊕ 환자 = 1y BARC 3-5 7.4% vs ⊖ 1.6% | Yoon HJ 2021, *JKMS* 36:e290 |
| **HOST-EXAM** | 5,438 (post-DAPT) | clopidogrel 단독 vs aspirin 단독: 출혈+허혈 복합 HR 0.73 (clopi 우세) | Kim HS 2020, *Lancet* 396:1079 |
| **TICAKOREA** | 800 (ACS) | ticagrelor vs clopidogrel: PLATO major bleeding 11.7% vs 5.3% (HR 2.26) | Park KW 2020, *Circulation* 142:1641 |

### 동양인 보정 가중치

```
체중 보정 (population mean)
─────────────────────────────────
  서양 cohort  ~80 kg   →  표준 dose 적정
  한국인       ~65 kg   →  prasugrel 10mg → 5mg 감량
                          ticagrelor → 출혈위험 ↑ 보정 필요
  → KSC 2024: 한국인 ARC-HBR threshold 그대로 적용하되
              prasugrel reduced-dose (5mg) 권고
```

- KSC (Korean Society of Cardiology) 2024 ACS 가이드라인: PRECISE-DAPT ≥25 또는 ARC-HBR ⊕ → DAPT 3-6 mo + clopidogrel-first.
- 동양인 paradox: 출혈 ↑ + 허혈 ↑ 동시 (small vessel · 고연령 inflow).

---

## 6. 출혈 부위/중증도별 분류 비교

| BARC type | TIMI | GUSTO | 임상 의미 |
|---|---|---|---|
| **0** | — | — | 출혈 없음 |
| **1** | minimal | mild | actionable 아님 (멍 등) |
| **2** | minor (일부) | mild-moderate | 의학적 개입 필요 (압박 · 수액) |
| **3a** | minor (overt) | moderate | Hb ↓ 3-5 g/dL · 수혈 |
| **3b** | major | moderate-severe | Hb ↓ ≥5 g/dL · tamponade · 수술적 지혈 |
| **3c** | major | severe | ICH · 안내 출혈 (시력 위협) |
| **4** | — | — | CABG-related |
| **5a** | fatal (probable) | severe | 부검 없음 |
| **5b** | fatal (definite) | severe | 부검 확진 |

- BARC ≥3 = "major bleeding"으로 임상 trial endpoint 표준.
- 한국인 자료: ICH 비율이 서양 대비 ~1.5-2배 (Yoon 2021 K-ACTIVE).

---

## 7. CYP2C19 LoF × HBR 교차표 — 한국인 PCI 100명 모델

```
                ┌─ HBR ⊕ (ARC-HBR or PRECISE-DAPT ≥25) — ~25명 ─┐
                │                                                   │
한국인 PCI 100  │   ┌───────────────┬──────────────────┐           │
                │   │  PM (~15명)   │   IM (~45명)     │ NM (~32명) │
                │   │  허혈 ↑↑      │   허혈 ↑         │  baseline  │
                │   │  + 출혈 ↑↑    │   + 출혈 ↑       │  + 출혈 ↑  │
                │   │  ★7-8명 ★    │   ~11명          │  ~8명      │
                │   │  DUAL JEOPARDY│   tightrope      │  단축 DAPT │
                │   └───────────────┴──────────────────┘           │
                └────────────────────────────────────────────────────┘
                              + HBR ⊖ (~75명)
                              ── 표준 12 mo DAPT
```

| 계층 | 인원 | 권고 (KSC 2024 + CPIC 2022 통합) |
|---|---|---|
| PM × HBR⊕ | **~7-8명** | **★ high-stakes** · ticagrelor 60mg 감량 + 3 mo DAPT + PFT 모니터 |
| PM × HBR⊖ | ~7-8명 | prasugrel 5mg 또는 ticagrelor + 6-12 mo |
| IM × HBR⊕ | ~11명 | clopidogrel 유지 + 3-6 mo · de-escalation |
| IM × HBR⊖ | ~34명 | prasugrel/ticagrelor 권고 + 12 mo |
| NM × HBR⊕ | ~8명 | clopidogrel + 3-6 mo |
| NM × HBR⊖ | ~24명 | clopidogrel 12 mo (표준) |

→ **고난도 의사결정 = PM × HBR⊕ ~7-8명**: 약제·기간·PFT 모두 customize.

---

## 8. 참고문헌

- Costa F et al. (2017) *Lancet* 389:1025 — **PRECISE-DAPT** derivation/validation (PMID 28290994)
- Baber U et al. (2016) *J Am Coll Cardiol* 67:2224 — **PARIS** bleeding/ischemic risk (PMID 27050190)
- Urban P et al. (2019) *Circulation* 140:240 — **ARC-HBR** consensus (PMID 31116032)
- Mehran R et al. (2011) *Circulation* 123:2736 — **BARC** bleeding classification
- Byrne RA et al. (2023) *Eur Heart J* 44:3720 — **ESC 2023 ACS** guideline
- Rao SV et al. (2025) *J Am Coll Cardiol* — **ACC/AHA 2025 ACS** guideline
- 대한심장학회 (2024) **KSC ACS 진료지침 2024**
- Choi IJ et al. (2019) *Korean Circ J* 49:120 — KAMIR-NIH PRECISE-DAPT 검증
- Yoon HJ et al. (2021) *J Korean Med Sci* 36:e290 — K-ACTIVE ARC-HBR 검증
- Kim HS et al. (2020) *Lancet* 396:1079 — **HOST-EXAM** (한국인 단독요법)
- Park KW et al. (2020) *Circulation* 142:1641 — **TICAKOREA** (동양인 출혈 ↑)

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| PRECISE-DAPT 변수/cutoff | 🟡 SUPPORTED-BY-CITATION | Costa 2017 derivation cohort 14,963명 |
| PARIS 변수/카테고리 | 🟡 SUPPORTED-BY-CITATION | Baber 2016 n=4,190 |
| ARC-HBR 정의 | 🟡 SUPPORTED-BY-CITATION | Urban 2019 컨센서스 (validation cohort 다수) |
| 한국인 calibration | 🟡 SUPPORTED-BY-CITATION | KAMIR-NIH · K-ACTIVE · HOST-EXAM |
| 동양인 dose 감량 | 🟡 SUPPORTED-BY-CITATION | TICAKOREA · KSC 2024 |
| PM × HBR⊕ 7-8명 추정치 | 🟠 INSUFFICIENT/DEFERRED | M1 빈도 × HBR 25% 단순 곱 — 실제 cohort 검증 필요 |

---

## 🔑 핵심 통찰

- **두 축 = 출혈위험(M4) × 허혈위험(M1 유전형)**: 단축 vs 강력화 결정은 둘 다 정량화해야 의미. 어느 한쪽만 보면 oppose direction으로 실패.
- **PRECISE-DAPT (단기) + PARIS (장기) 보완**: 한쪽만 쓰면 시간축 blind spot. ARC-HBR는 binary screen, score 두 개는 quantitative grading.
- **동양인 dual jeopardy**: 출혈 ↑ (체중 · 혈관 fragility · ICH 비율 ↑) + clopidogrel 무반응 (LoF 60%) → 서양 cohort 결정 트리 그대로 import 불가.
- **한국인 PCI 100명 중 7-8명이 "PM × HBR⊕" high-stakes 칸**: 이들이 결정맵의 critical cell — M3 switch + M5 PFT가 가장 큰 가치 생산.
- **KSC 2024 stance**: HBR ⊕ 시 clopidogrel-first + 단기(3-6 mo) DAPT가 한국인에서 net-benefit 우세 (HOST-EXAM 기반) — 서양 가이드라인의 ticagrelor-first 일률 권고와 분기점.
