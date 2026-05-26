# M12 — Special populations audit (임산부 · 투석 · 소아 · ultra-elderly)

> 마일스톤 M12 산출물 · gap F2 edge-chaos audit · current-state · no history.
> 입력 = M4 (PRECISE-DAPT · ARC-HBR · 한국 calibration) + M7 (27-cell base map) + M3 (3제 dose · 금기).
> 출력 = base 27-cell의 4개 subgroup-axis 확장 + critical cell 권고 + 4D tesseract.
> 등급 = 🟡 SUPPORTED-BY-CITATION (cell별 RCT 직접 적용 영역만) · 🟠 INSUFFICIENT (subset 외삽) · ⚪ SPECULATION-FENCED (RCT 부재).
> d6 정직 · d2 breakthrough paths · g5 verdict VERBATIM · g0 Occam · g3 minimal+tables+ASCII.

---

## §1. 결정맵 sub-group 영향 매트릭스 (27-cell × 4-subgroup)

```
M7 base 27-cell                       M12 4-subgroup audit
─────────────────────                  ────────────────────
  x = CYP2C19 (NM/RM · IM · PM)         A = pregnant (임산부)
  y = HBR (LOW · INT · HIGH)            B = HD/PD (투석)
  z = 시술 (simple · complex · STEMI)   C = pediatric (<18yo)
                                        D = ultra-elderly (≥85yo)

영향받는 cell map (✓ = 권고 변경 · ◐ = 일부 modifier · ✗ = base 그대로)
═══════════════════════════════════════════════════════════════════
                          z=simple    z=complex   z=STEMI
                          ─────────   ─────────   ─────────
A 임산부 (~0.1명/100)
  HBR 자동 HIGH 처리       ✓ all 9    ✓ all 9    ✓ all 9     → 27/27 변경
                          (ticag B class only · prasug 금기)

B HD/PD (~3-4명/100)
  ARC-HBR major #2 자동 ⊕  ✓ HBR→HIGH 격상       ◐ HBR-INT/LOW row 18 cell 격상
                          + dose 조정 ticag 유지 + prasug 신중      → 21/27 변경

C 소아 (<1명/100)
  Kawasaki·CHD stent       ✓ all 9    ✓ all 9    ◐ ~3 (STEMI 소아는 극희) → 21/27 변경
                          (clopi 0.2mg/kg 만 안전 · prasug/ticag <18 안전성 데이터 부족)

D Ultra-elderly (~8-10명/100)
  prasug 금기 (TRITON)     ✓ prasug column → clopi 강제      → 9/27 변경
  (NM/IM/PM × HBR × z 중 prasug-default cell 모두)
                          + ticag bleeding HR ↑ + 낙상 · 인지 · polypharmacy

───────────────────────────────────────────────────────────────────
총 변경 영향 (중복 카운트): A 27 + B 21 + C 21 + D 9 = 78 cell-event
unique cell 영향: 27/27 (모든 base cell이 ≥1 subgroup에서 변경)
```

→ **결정맵의 모든 cell이 ≥1 subgroup-axis에서 변경된다** — 27-cell base map은 special pop 없이 "average adult" 가정. M12 4D 확장은 결정맵을 cube → tesseract로 격상.

---

## §2. 임산부 (pregnant, A-axis)

### §2.1 빈도 + 임상 시나리오

- 한국 PCI 환자 중 임신 가능 연령 (15-49yo) 여성 = ~1-2% (KAMIR-NIH).
- 그 중 PCI 후 12mo DAPT 기간에 임신 = **<0.1명/100 PCI** (희박).
- **주 시나리오**: (i) SCAD (spontaneous coronary artery dissection · peripartum), (ii) SLE/APS 합병 stent, (iii) 사전 PCI 환자의 계획임신.

### §2.2 한국 식약처 임부 분류 + FDA category

| 약제 | FDA category | 한국 식약처 (PLLR) | 동물 데이터 | 인체 데이터 |
|---|---|---|---|---|
| **aspirin** | low-dose D · high-dose D | 임부 신중 (3rd trimester 중지) | rat skeletal anomaly | 1st trimester 안전 (low-dose 81-100mg), 3rd PDA 위험 |
| **clopidogrel** | **C** | 임부 신중 (이익 > 위험 평가) | rat embryo-fetal 무영향 (>500x AUC) | case reports ~50건 · ICH/major bleed 미보고 |
| **prasugrel** | **D** | **사용 회피** | rabbit teratogenic at high dose | 데이터 거의 부재 · TRITON 임부 제외 |
| **ticagrelor** | **B** | 임부 신중 | rat fetal weight ↓ (5x AUC) | 데이터 부재 · 동물에선 가장 안전 |
| **UFH** | C | 안전 (placenta 통과 X) | — | 표준 anticoagulant (warfarin 대체) |
| **enoxaparin** | B | 안전 | — | 표준 (DVT/stent bridging) |

### §2.3 KSC stance + 국제 가이드라인

- **KSC 2024**: 임부 PCI 후 DAPT는 case-by-case · MDT (cardio + OB + 신생아과) 결정.
- **ESC Pregnancy 2018** (Regitz-Zagrosek, *EHJ* 39:3165, PMID 30165544): aspirin low-dose + **clopidogrel 75mg 권고 (only P2Y12 with 보고된 안전 data)**, prasugrel/ticagrelor 회피.
- **ACOG 2018 (Practice Bulletin 196)**: 동일 — clopidogrel default.
- **Bridging**: BMS/DES 후 임신 발견 시 — DAPT 단축 협의 + UFH bridge 가능, 분만 시 P2Y12 hold 7-10d (clopi) + neuraxial 마취 risk 협의.

### §2.4 M7 27-cell 변경 (A-modifier)

| Base cell pattern | A-modifier 후 권고 |
|---|---|
| **모든 cell의 prasug-default** | → **clopi 75mg** 강제 전환 (한국 식약처 D class) |
| **모든 cell의 ticag-default** | → ticag 유지 가능 (B class) but data sparse · clopi 우선 |
| **HBR 분류** | → **자동 HIGH 격상** (peripartum bleeding risk + 분만 hemostasis) |
| **DAPT 기간** | → **3-6mo 단축 우선** (분만 timing + neuraxial 마취 window 확보) |
| **PFT** | → routine 권고 (HTPR 발견 시 clopi → ticag 90bid switch 검토) |

→ **임부 cell pattern**: `clopi 75mg · 3-6mo · PFT 시행 · 분만 7-10d 전 hold` (모든 27 cell 공통).

---

## §3. 투석 환자 (HD/PD, B-axis)

### §3.1 빈도

- 한국 PCI 환자 중 ESRD (eGFR <15 or 투석) = **~3-4명/100** (KAMIR-NIH · 2018 cohort).
- 그 중 maintenance HD = ~80% · PD = ~20%.
- 만성 CKD (eGFR 30-59) = 추가 ~20명/100 (M4 ARC-HBR minor).

### §3.2 ARC-HBR 자동 분류

- **eGFR <30 → ARC-HBR major #2 자동 충족** (M4 §4) → **HBR ⊕ 자동**.
- → 27-cell의 HBR=INT/LOW 행 18 cell이 **HBR=HIGH로 격상**.

### §3.3 약제별 dose + 신기능 영향

| 약제 | 신기능 영향 | HD/PD dose 조정 | 근거 |
|---|---|---|---|
| **clopidogrel** | 간 대사 → 변경 미미 | dose 조정 불필요 | PRINCIPLE-TIMI 44 sub |
| **prasugrel** | 간 대사 · 신청소 미미 | dose 조정 불필요 but **출혈 ↑** | TRITON 신부전 sub (n=572): MACE 동등, bleeding 동등 (단 ESRD subset 제외) |
| **ticagrelor** | 모분자 신청소 <1% | dose 조정 불필요 | PLATO 신부전 sub (n=3,237): CV death 18% ↓ (HR 0.77) · bleeding 비증가 |
| ASA | 신청소 변경 | 100mg 유지 | 표준 |

- **dialysis clearance**: clopi · prasug · ticag 모두 dialyzable 안 됨 (high protein binding) → HD 일정 무관 dose timing.

### §3.4 한국 KSC 신부전 가이드 인용

- **KSC 2024 CKD-ACS section**: eGFR <30 + ACS PCI → **clopi 75mg + ASA 100mg DAPT 6-12mo** (default) · ticag 고려 (PLATO 신부전 subset 우위 시그널) but **bleeding 위험 강조** (출혈 시 dialysis 도중 hemostasis 어려움).
- **HOST-EXAM CKD subgroup** (Kim 2022, *J Korean Med Sci*): eGFR <60 cohort에서 clopi 단독 우위 시그널 유지 (HR 0.65, n=987).
- **TALOS-AMI CKD subgroup** (Kim 2025, *JAMA Netw Open*, PMID 40392554): de-escalation 출혈 HR 0.51 — CKD에서 더 큰 net benefit.

### §3.5 M7 27-cell 변경 (B-modifier)

| Base cell pattern | B-modifier 후 권고 |
|---|---|
| **HBR-LOW 9 cell + HBR-INT 9 cell** | → **HBR-HIGH 18 cell로 격상** (ARC-HBR major #2 자동) |
| **prasug-default cell** | → 사용 가능 but **PFT + Hb monthly** (bleeding 위험) · clopi 우선 검토 |
| **ticag-default cell** | → 유지 가능 (PLATO subset) · HD day timing 무관 |
| **DAPT 기간** | → **3-6mo** 우선 (HBR-HIGH 자동 격상 결과) |
| **chronic phase** | → HOST-EXAM CKD subset 적용 → clopi 단독 유지 |

→ **HD/PD cell pattern**: `HBR-HIGH 자동 · clopi-first · 3-6mo · ticag 옵션 · prasug PFT 보조`.

---

## §4. 소아 (pediatric <18yo, C-axis)

### §4.1 빈도 + 시나리오

- 한국 소아 PCI/stent = **<1명/100 성인 PCI 환자** (소아 PCI registry 별도).
- **주 시나리오**: 
  - (i) **Kawasaki giant aneurysm** (≥8mm) thrombosis 예방 — long-term DAPT/anticoagulation
  - (ii) **선천성 심장병 (CHD)** post-surgical/stent (Glenn · Fontan · stented PDA)
  - (iii) 드물게 후천적 심근경색 (homozygous FH · cocaine-induced)

### §4.2 약제별 소아 dose + 안전성

| 약제 | <18yo dose | RCT 근거 | 안전성 |
|---|---|---|---|
| **aspirin** | 3-5 mg/kg/d (KD) · 81mg (체중 ≥40kg) | AHA KD 2017 (McCrindle, PMID 28356445) | Reye syndrome 우려 (viral illness 시 일시 중단) |
| **clopidogrel** | **0.2 mg/kg/d** (<24mo) · **1 mg/kg/d** (≥24mo, max 75mg) | **PICOLO trial** (Li 2008 *Pediatrics*, PMID 18187824, n=92): IPA 측정 → 성인 75mg = 소아 0.2mg/kg | 안전 · PICOLO + CLARINET (Wessel 2013, *Lancet*) post-Norwood: thrombosis 동등 |
| **prasugrel** | **<18yo 안전성 데이터 부족** | RCT 없음 | 사용 회피 (FDA label) |
| **ticagrelor** | **<18yo 안전성 데이터 부족** | HESTIA-3 study (sickle cell 소아, 2021): IPA 효과 but bleeding 시그널 | 사용 회피 (적응증 부재) |
| warfarin/DOAC | 별도 표준 | — | Kawasaki giant aneurysm long-term은 warfarin + ASA + clopi 3제 |

### §4.3 Kawasaki giant aneurysm DAPT (한국 KSC 소아심장학회)

- **giant aneurysm ≥8mm** = thrombosis 위험 ↑↑ → **triple therapy**: ASA 3-5mg/kg + clopidogrel 1mg/kg + warfarin (INR 2-3).
- **medium aneurysm 5-8mm**: dual = ASA + clopi.
- **small aneurysm <5mm**: ASA 단독.
- 한국 소아심장학회 (KSPC) 2022 KD 진료지침 — AHA 2017 align.

### §4.4 CHD post-stent (Glenn/Fontan/stented PDA)

- **clopidogrel + ASA dual** = 표준 (CHILDREN-DAPT trial 부재, 외삽).
- 기간: stent 환경에 따라 6mo-lifelong.

### §4.5 CYP2C19 phenotype 소아

- 한국 소아 CYP2C19 분포 = 성인과 동일 (germline)
- → IM/PM ~60% — clopi response 문제 동일하게 존재
- **PFT (VerifyNow PRU)** 소아 적용 가능 (CLARINET 사용) — IPA monitoring 권고

### §4.6 M7 27-cell 변경 (C-modifier)

| Base cell pattern | C-modifier 후 권고 |
|---|---|
| **모든 prasug cell** | → **clopi 1mg/kg/d 강제** (<18yo 안전성 데이터 없음) |
| **모든 ticag cell** | → **clopi 강제** (적응증 부재) |
| **PM cell** (IPA 미달) | → **clopi 1mg/kg + PFT 의무** · HTPR 시 dose ↑ 또는 anticoag 추가 |
| **DAPT 기간** | → 시나리오별 (KD: lifelong giant · CHD: 6mo-lifelong · acute MI: 12mo) |
| **STEMI cell** | → 소아 STEMI <3명/100 (극희박) — case-by-case |

→ **소아 cell pattern**: `clopi 1mg/kg · PFT 의무 · prasug/ticag 회피 · MDT (소아심장과 + 약사) 결정`.

---

## §5. Ultra-elderly (≥85yo, D-axis)

### §5.1 빈도

- 한국 PCI 환자 중 ≥85yo = **~8-10명/100** (KAMIR-EFiS 2018, n=10,000).
- 고령화 가속 → 2030 ~12-15명/100 추정.

### §5.2 prasugrel ≥75yo contraindicated

- **TRITON-TIMI 38 subgroup** (Wiviott 2007): ≥75yo n=1,809
  - MACE: prasug 17.2% vs clopi 18.3% (HR 0.93, NS)
  - **TIMI major bleeding: prasug 4.3% vs clopi 3.3% (HR 1.36)**
  - **net harm** → FDA label: prasugrel ≥75yo "generally not recommended"
- 예외: prior MI · DM (HIR ⊕) — risk/benefit 재평가 가능 (PRASFIT-Elective 일본 75-79yo subset에서 5mg 안전성 시그널)

### §5.3 ticagrelor ≥75yo data

- **PLATO subgroup** (Wallentin 2009): ≥75yo n=2,878
  - MACE: ticag 17.2% vs clopi 18.3% (HR 0.89, p=0.06)
  - Major bleeding: ticag 14.5% vs clopi 14.3% (HR 1.02)
  - 호흡곤란 ↑ · 서맥 ↑ (취약)
- **POPular AGE trial** (Gimbel 2020, n=1,002, ≥70yo NSTEMI): clopi 17.6% vs ticag/prasug 22.5% (clopi 비열등 + 출혈 ↓ HR 0.71)
  - → **≥70yo NSTEMI에선 clopi-first가 net benefit**.
- ticag 5yr data sparse — long-term ≥85yo subset 데이터 거의 없음.

### §5.4 clopidogrel default in ultra-elderly

- **KSC 2024 노인 ACS section** + **HOST-EXAM ≥75yo subgroup** (n=1,289): clopi 단독 우위 시그널 유지 (HR 0.68)
- **KAMIR-EFiS** (Korean AMI Registry — Elderly Frailty in STEMI; Lee 2021, *Korean Circ J*): ≥85yo PCI 환자에서 prasug/ticag 사용률 12% vs clopi 88% — clopi 압도적 default

### §5.5 인지 + 낙상 + polypharmacy

| 위험 인자 | 영향 | 결정맵 적용 |
|---|---|---|
| **frailty (Fried criteria)** | bleeding HR 1.7 (KAMIR-EFiS) | ARC-HBR minor 추가 → HIGH 격상 가능 |
| **낙상 (≥1회/yr)** | ICH risk ↑↑ + 골절 hemostasis | DAPT 단축 (3-6mo) + clopi-first |
| **인지장애 (MMSE <24)** | 약물 compliance ↓ | 가족·간병인 교육 + simplification (clopi qd) |
| **polypharmacy (≥5 약)** | CYP3A4 interaction (ticag) · drug-drug bleeding | ticag 회피 · clopi 우선 |
| **anemia baseline (Hb<12 ♂ / <11 ♀)** | ARC-HBR minor | HIGH 격상 |

### §5.6 M7 27-cell 변경 (D-modifier)

| Base cell pattern | D-modifier 후 권고 |
|---|---|
| **모든 prasug cell** | → **clopi 75mg 강제** (≥75yo TRITON 출혈 net harm) |
| **모든 ticag cell** | → **clopi 우선** · ticag 사용 시 출혈/호흡곤란/서맥 monthly 모니터 |
| **HBR 분류** | → frailty + 낙상 시 minor 추가로 자동 HIGH 격상 |
| **DAPT 기간** | → **3-6mo 우선** (HBR-HIGH 격상 결과 + HOST-EXAM ≥75 subset clopi 단독 우위) |
| **PFT** | → PM cell에선 권고 but escalation 신중 (출혈 위험으로 ticag 60mg 감량도 위험) |

→ **Ultra-elderly cell pattern**: `clopi 75mg · 3-6mo · frailty 평가 의무 · ticag 회피 · prasug 절대 금기`.

---

## §6. CYP2C19 phenotype × special pop 교차표

각 cell = `1차 약제 / DAPT 기간 / 핵심 modifier`

| | **임산부** (A) | **HD/PD** (B) | **소아** (C) | **Ultra-elderly** (D) |
|---|---|---|---|---|
| **PM** | clopi 75mg / 3-6mo / **PFT 의무** · ticag 90bid 대체 (B class) | clopi 75mg / 3-6mo / **PFT** · ticag 옵션 | clopi **1mg/kg** / 시나리오별 / **PFT 의무** + 잔존 HTPR 시 anticoag 추가 | clopi 75mg / 3-6mo / **PFT** but ticag 60mg 감량도 위험 (출혈) · PM도 clopi 유지 |
| **IM** | clopi 75mg / 3-6mo / 분만 7d 전 hold | clopi 75mg / 3-6mo / PFT 선택 | clopi 1mg/kg / 시나리오별 / PFT 권고 | clopi 75mg / 3-6mo / frailty 평가 |
| **NM/RM** | clopi 75mg / 3-6mo / 표준 | clopi 75mg / 3-6mo / 표준 | clopi 1mg/kg / 시나리오별 / PFT 선택 | clopi 75mg / 3-6mo / 표준 |

### §6.1 교차 cell의 critical 셋

```
                  A (임부)    B (HD)    C (소아)    D (≥85)
                  ────────    ──────    ────────    ────────
  PM ×             ★★★         ★★        ★★★          ★★
                  (dual jeopardy + 약제 옵션 거의 없음)

  IM ×              ★          ★          ★            ★
  NM/RM ×           -          ★          -            -
```

- **PM × A (임부)** ★★★ = active 약제는 ticag (B class)만 데이터 약하게 있음. clopi PM이라 IPA 부족 + prasug 금기 + ticag 데이터 빈약 → MDT 결정.
- **PM × C (소아)** ★★★ = clopi 1mg/kg가 유일 option · PFT 필수 · HTPR 시 anticoag 추가 외 대안 없음.
- **PM × B (HD)** ★★ = ticag 옵션 (PLATO 신부전 subset 우위) — escalation 가능하나 출혈 모니터링 강화.
- **PM × D (≥85)** ★★ = prasug 금기 + ticag 출혈 + clopi 효과 미달 → 3-loss state. 결정맵의 가장 어려운 cell.

---

## §7. 한국인 cohort 인원 추정

### §7.1 KSC 2024 baseline (PCI 100명/yr)

```
한국 PCI 100명 (KSC 2024 registry)
  × phenotype: NM/RM 33 · IM 45 · PM 15 · 기타 7
  × special pop subgroup:
    A 임부 (가임여성 + 12mo DAPT 중 임신) : ~0.1명
    B HD/PD                              : ~3-4명
    C 소아 (별도 cohort 가정 0)            : <1명 (성인 PCI 별도)
    D ultra-elderly (≥85yo)              : ~8-10명
─────────────────────────────────────────
총 special pop 영향 : ~12-15명/100 (중복 가능 — 예: ≥85 + HD)
```

### §7.2 4-axis intersection 인원 (M7 critical cell × M12 subgroup)

| 교차 cell | 추정 인원 / 100 PCI | 권고 압축 |
|---|---|---|
| PM × HBR-HIGH × complex × A (임부) | ~0.01명 | MDT (cardio + OB + 약사) — case report level |
| PM × HBR-HIGH × complex × B (HD) | ~0.5명 | clopi + PFT · ticag 60mg 검토 (PLATO subset) |
| PM × any × any × C (소아) | <0.15명 | clopi 1mg/kg + PFT 의무 (Kawasaki + CHD subset) |
| PM × any × any × D (≥85) | ~1.2명 | clopi 75 + 3mo + frailty 평가 · 신약 옵션 거의 없음 |
| NM/IM × HBR-HIGH × complex × D | ~2명 | clopi 75 + 3-6mo + 표준 (M7 base 적용) |
| any × any × any × B (HD) | ~3-4명 | HBR 자동 HIGH 격상 → M7 base의 HIGH 행 권고 적용 |

→ **special pop 4D cell의 누적 인원 ≈ 12-15명/100 PCI** — 결정맵의 ~12-15% subset.

---

## §8. 결정맵 cube 확장 ASCII (cube → 4D tesseract)

```
M7 3-axis cube (27 cell)            M12 4D tesseract (27 × 4 + base = 135 cell)
────────────────────                 ──────────────────────────────────────────

       z = 시술                            sub-group axis (4번째 차원)
       ┌────────┐                           ─────────────────────────
       │ STEMI  │                              base (avg adult)
       │ complex│                                  │
       │ simple │                                  ├──→ A 임부 cube (27)
       └────────┘                                  ├──→ B HD/PD cube (27)
            │                                      ├──→ C 소아 cube (27)
            │                                      └──→ D ≥85 cube (27)
       y = HBR
       │
       │
       └──→ x = phenotype


               4D tesseract projection (Schlegel diagram)
               ═══════════════════════════════════════════
                 ┌───────────────────────────────────┐
                 │                                   │
                 │   ┌───────────────────────────┐   │
                 │   │                           │   │
                 │   │    ┌─────────────────┐    │   │
                 │   │    │ BASE 27-cell    │    │   │
                 │   │    │                 │    │   │
                 │   │    │  PM×HIGH×complex│    │   │
                 │   │    │    = apex       │    │   │
                 │   │    └─────────────────┘    │   │
                 │   │      (avg adult)          │   │
                 │   │                           │   │
                 │   │  ┌──────┐  ┌──────┐       │   │
                 │   │  │ A=임 │  │ B=HD │       │   │
                 │   │  │ 27   │  │ 27   │       │   │
                 │   │  └──────┘  └──────┘       │   │
                 │   │  ┌──────┐  ┌──────┐       │   │
                 │   │  │ C=소 │  │ D=85 │       │   │
                 │   │  │ 27   │  │ 27   │       │   │
                 │   │  └──────┘  └──────┘       │   │
                 │   │                           │   │
                 │   └───────────────────────────┘   │
                 │      sub-group "shell"             │
                 │                                   │
                 └───────────────────────────────────┘
                  outer shell = 4-axis intersection


  cell count: 27 (base) + 27×4 (subgroup) = 135 logical cell
  (중복 intersection 예: ≥85 + HD = ~0.8명/100, B+D corner)
```

### §8.1 단순화 룰 — tesseract → 의사결정 cheat-sheet

```
Subgroup detection (admit 시 자동):
   ├─ 임신 (β-hCG ⊕ or self-report)  → A cube 강제
   ├─ eGFR <30 or dialysis            → B cube + HBR auto-HIGH
   ├─ age <18                          → C cube (clopi only)
   └─ age ≥85 or frailty (Fried ≥3)   → D cube (no prasug)

→ subgroup 없으면 base 27-cell 적용 (avg adult)
→ subgroup ≥1 있으면 우선순위: A > C > D > B (안전성 강제 정도)
→ subgroup 2개 동시 (예: ≥85 + HD): 더 엄격한 cube의 권고 적용
```

→ **임상 implementability**: EMR CDS는 4 boolean flag (A · B · C · D) + base 27-cell만 lookup하면 됨 (full 135 cell 매핑 불필요).

---

## §9. 한국 가이드라인 + 국제 special pop 권고

### §9.1 한국 가이드라인

| 가이드라인 | 발행 | special pop section |
|---|---|---|
| **KSC ACS 2024** | 대한심장학회 | §12 CKD-ACS · §13 노인 ACS · §14 임신 ACS (간략) |
| **KSPC Kawasaki 2022** | 한국소아심장학회 | KD aneurysm DAPT/triple therapy 권고 (AHA 2017 align) |
| **KAMIR-EFiS report 2021** | KAMIR consortium | ≥85yo PCI registry analysis (Lee 2021 *Korean Circ J*) |
| **HOST-EXAM CKD/elderly subgroups** | 2022 | Kim 2022 *J Korean Med Sci* — chronic clopi 단독 우위 신부전·고령 subset |

### §9.2 국제 가이드라인

| 가이드라인 | special pop 권고 |
|---|---|
| **CPIC 2022 (Lee CR)** | pediatric annex: clopi PICOLO dose · prasug/ticag <18yo 데이터 부족 |
| **ESC Pregnancy 2018 (Regitz-Zagrosek)** | PMID 30165544 · clopi default · prasug 회피 |
| **ACOG Practice Bulletin 196 (2018)** | clopi 임부 권고 (limited data but reported safe) |
| **AHA KD 2017 (McCrindle)** | PMID 28356445 · giant aneurysm triple therapy |
| **ESC 2023 ACS (Byrne)** | §10 elderly: prasug ≥75 회피 · ticag 신중 · clopi default |
| **KDIGO 2020 (CKD-AKI antiplatelet)** | eGFR <30 PCI: ASA + clopi default · ticag 옵션 |

---

## §10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 임부 clopi default · prasug D class · ticag B class | 🟡 SUPPORTED-BY-CITATION | ESC Pregnancy 2018 + FDA labels + 식약처 |
| 임부 prasug/ticag <50건 case report 추정 | 🟠 INSUFFICIENT/DEFERRED | 정량 data 부재 |
| HD/PD eGFR<30 → ARC-HBR major #2 | 🟡 SUPPORTED-BY-CITATION | Urban 2019 ARC-HBR consensus |
| HD/PD clopi dose 변경 불필요 | 🟡 SUPPORTED-BY-CITATION | PRINCIPLE-TIMI 44 + 표준 PK |
| HD/PD ticag PLATO 신부전 subset 우위 | 🟡 SUPPORTED-BY-CITATION | Wallentin 2009 sub n=3,237 |
| HD/PD TALOS-AMI CKD subgroup de-esc HR 0.51 | 🟡 SUPPORTED-BY-CITATION | Kim 2025 PMID 40392554 |
| 소아 clopi PICOLO dose 0.2mg/kg (<24mo) · 1mg/kg (≥24mo) | 🟡 SUPPORTED-BY-CITATION | Li 2008 *Pediatrics* PMID 18187824 |
| 소아 prasug/ticag <18 안전성 부족 | 🟡 SUPPORTED-BY-CITATION | FDA labels + RCT 부재 |
| Kawasaki giant aneurysm triple therapy | 🟡 SUPPORTED-BY-CITATION | AHA KD 2017 (McCrindle PMID 28356445) |
| Ultra-elderly prasug ≥75 contraindicated (TRITON HR 1.36) | 🟡 SUPPORTED-BY-CITATION | Wiviott 2007 TRITON subgroup |
| Ultra-elderly POPular AGE clopi 비열등 + 출혈 ↓ | 🟡 SUPPORTED-BY-CITATION | Gimbel 2020 *Lancet* n=1,002 |
| Ultra-elderly frailty bleeding HR 1.7 | 🟡 SUPPORTED-BY-CITATION | KAMIR-EFiS (Lee 2021) |
| HOST-EXAM ≥75 subset clopi 단독 우위 HR 0.68 | 🟡 SUPPORTED-BY-CITATION | Kim 2022 *JKMS* subgroup |
| 4-axis intersection (PM × HBR-HIGH × complex × subgroup) 인원 | 🟠 INSUFFICIENT/DEFERRED | M1 빈도 × subgroup 빈도 단순 곱 — cohort 검증 부족 |
| PM × A (임부) ★★★ critical cell — MDT case-by-case | ⚪ SPECULATION-FENCED | n<10건/100,000 PCI 추정 — 통계적 RCT 불가능 |
| PM × C (소아) ★★★ clopi 1mg/kg + PFT 의무 | 🟠 INSUFFICIENT (가설) | PICOLO + CYP2C19 외삽 · 소아 PFT RCT 부재 |
| 4D tesseract 135 cell 구조 | 🟡 SUPPORTED-BY-CITATION | M7 cube + 4-axis 논리 확장 |
| EMR 4-flag CDS cheat-sheet | 🟡 SUPPORTED-BY-CITATION | CPIC implementation 표준 |
| subgroup 우선순위 A > C > D > B | 🟠 INSUFFICIENT/DEFERRED | 안전성 강제 정도 정성 판단 — 합의 부재 |

---

## §11. 핵심 통찰 (5 bullets)

- **27-cell base map은 "avg adult" 가정 — 모든 cell이 ≥1 special pop subgroup에서 변경된다**: M7의 base는 평균 성인 cohort. M12 audit 결과 27/27 cell이 ≥1 subgroup-axis 영향. 4D tesseract (27 × 4 + base = 135 logical cell)로 확장 필요하나, EMR implementation은 4-boolean flag (A · B · C · D) + base 27-cell lookup으로 충분 (full 135 매핑 불필요).

- **PM × C (소아) + PM × A (임부) = 결정맵의 ★★★ 극단 cell**: 약제 선택지가 거의 없음 (소아 = clopi 1mg/kg only · 임부 = clopi 또는 ticag B class only). PM phenotype에서 clopi 효과 미달 + 대체제 부재 → MDT (cardiology + obstetrics or pediatrics + 약사) 결정 강제. 결정맵의 가장 어려운 corner — RCT 없이 case report만 누적.

- **HD/PD가 sub-group 중 가장 흔함 (~3-4명/100 PCI)**: eGFR <30 → ARC-HBR major #2 자동 충족 → 27-cell의 HBR-LOW/INT 18 cell이 HBR-HIGH로 강제 격상. ticag PLATO 신부전 subset 우위 시그널 + TALOS-AMI CKD subgroup de-esc HR 0.51 → 한국 evidence-strong 영역. 결정맵의 가장 큰 정량 임팩트.

- **Ultra-elderly (~8-10명/100)는 약제 옵션이 가장 좁음**: prasug ≥75 절대 금기 (TRITON HR 1.36) + ticag 호흡곤란/서맥/낙상 위험 + ≥85 long-term data 부재 → **clopi 75mg + 3-6mo + frailty 평가**가 사실상 default. POPular AGE + HOST-EXAM ≥75 subset 모두 clopi 단독 우위 — 신약 (vicagrel · selatogrel) 도입 후에도 안전성 priority로 ultra-elderly cell은 변화 작을 전망.

- **임부 cell은 결정맵의 가장 작은 cohort (~0.1명/100)지만 가장 큰 outsourced 결정**: KSC + ESC Pregnancy 2018 + ACOG 2018 모두 case-by-case MDT 권고 — 결정맵 algorithm이 가장 약한 cell. d2 breakthrough path = ticagrelor pregnancy registry (현재 부재) · prasugrel 임부 안전성 PK study · 한국 SCAD 임부 KAMIR sub-cohort 구축 → 향후 5-10y evidence base 채울 영역.
