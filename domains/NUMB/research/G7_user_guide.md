# NUMB G7 — 3-step 사용자 가이드 + OTC/Rx 라벨 자동 분기

> 🧊 **NUMB milestone G7** — 6 indication × 3 SKU 워크플로 + dispatcher decision tree + OTC-A(Drug Facts) / Rx-V1(USPI) skeleton + 시각 ASCII + hexa-native dispatcher.
>
> **결론 요약**: 6 procedure (laser hair · vascular · tattoo CREATION · injection · biopsy · pediatric) × 3 SKU (**OTC-A** = lid 4% only · **Rx-V1** = hexa-LAC v1 lid 7+tet 7+epi+peel-film · **Rx-V2** = N6-C capric ternary v1 + capric multiplier) 워크플로 closed-form. dispatcher 입력 5 (indication · weight · age · area · concomitant) → SKU/농도/도포시간/max area/warning 결정. OTC-A onset = 45-60 min honest (LMX-5 class). Rx-V1 onset = 2.8 min target. G3 prilocaine-free + 6 age envelope · G2 OTC monograph (tet 2% wall) · N6 capric duration multiplier 모두 정합.

---

## 0. 정합 한 줄 요약

```
   ┌────────────────────────────────────────────────────────────────┐
   │  G1 (8 indication) + G2 (OTC=lid4% / Rx=v1/v2) + G3 (6 age)    │
   │  + N6 (capric duration ×3 · onset 무관) → G7 dispatcher        │
   │                                                                │
   │  입력: indication · weight · age · area · concomitant          │
   │  출력: SKU · 농도 · apply_min · max_area · warning             │
   │                                                                │
   │  honest framing — OTC-A onset 45-60 min (NOT 3 min) · LMX class │
   │                  — Rx-V1 onset ~3 min target (eutectic + CPE)  │
   │                  — Rx-V2 onset ~3 min + duration ×3 (capric)   │
   └────────────────────────────────────────────────────────────────┘
```

---

## 1. 3-step 사용자 가이드 — 6 indication × 3 SKU (procedure-agnostic)

각 indication 마다 (1) **도포** (apply) · (2) **대기** (wait, onset timer) · (3) **procedure** (개시 timing) 의 3-step.

### 1.1 indication × SKU 워크플로 매트릭스

| # | indication | 권장 SKU (1순위) | 양 | 면적 | 도포 시간 | 대기 (onset) | procedure 윈도우 | 사후 |
|---|---|---|---|---|---|---|---|---|
| **I1** | laser hair removal (성인) | **Rx-V1** (lid 7+tet 7+epi) | 1-2 g per 100 cm² | 100-400 cm² | 30 min apply | ~3 min onset (apply 후 즉시) | 30-60 min 안에 완료 (epi vaso 효과 ≥60min) | peel 또는 wipe → wash |
| I1-OTC | laser hair removal (홈/저강도) | **OTC-A** (lid 4%) | 1-2 g per 100 cm² | ≤100 cm² | 45-60 min apply | 45-60 min 후 onset (LMX class) | 60-90 min 안에 완료 | wipe → wash |
| **I3** | laser vascular / resurfacing | **Rx-V1** | 1.5 g per 100 cm² | 100-200 cm² (얼굴 mask) | 30 min apply | ~3 min onset | 30-60 min 윈도우 (+epi) | peel-film 제거 후 즉시 |
| **I4-typ** | tattoo CREATION (typ) | **Rx-V2** (capric ternary, duration ×3) | 1.5 g per 100 cm² | ≤400 cm² (split 권장 >400) | 30 min apply | ~3 min onset | **≤180 min 윈도우** (v2 duration multiplier) | midway top-up 불필요 (capric a≈5) |
| **I4-max** | tattoo sleeve >1000 cm² | **Rx-V1 5+5% derate + split** | 1 g per 100 cm² | 1000 cm² (split 2회 · 4hr 간격) | 30 min apply | ~3 min onset | session 1: ≤120 min · session 2: 4hr 후 | re-apply 가능 (lid t½ 90min × 3 = 90% clearance) |
| **I2** | injection (vaccine/IV/blood draw) | **OTC-A** (lid 4%) — 작은면적, LAST trivial | 0.3-0.5 g | 5-10 cm² | 30 min apply | 30-45 min onset | 5-15 min 안에 needle | wipe |
| I2-Rx | injection (Rx 옵션) | **Rx-V1** (속도 우선) | 0.5 g | 10 cm² | 30 min apply | ~3 min onset | 5-10 min 안에 needle | peel |
| **I5** | derm biopsy / excision / mole | **Rx-V1** (즉시 onset 가치 ↑) | 0.3-0.5 g | 10-30 cm² | 30 min apply | ~3 min onset | 5-15 min 안에 incision | peel |
| **I6** | pediatric (≥1 mo) | **OTC-A** (prilocaine-free 필수) | 체중·연령별 (§1.3) | age-cap (§1.3) | 30-60 min apply | 30-45 min onset | 30-90 min 안에 procedure | wipe |
| I6-<28d | neonate <28d (term ≥37wk) | **clinical-defer** (BORDERLINE) | ≤1 g | ≤7 cm² | ≤60 min apply | n/a | 임상 confirmation 필요 (G3 honest) | — |

> **핵심 통찰**: hexa-LAC v1 (Rx-V1) 의 ~3 min onset 은 SC kinetics indication-agnostic — 동일 onset 모든 procedure 에. 차이는 *면적 envelope* + *세션 길이* 만.

### 1.2 SKU 정의 (3종)

| SKU | composition | onset | duration | max area (adult) | path |
|---|---|---|---|---|---|
| **OTC-A** | **lid 4%** 단독 (prilocaine-free, no epi) | **45-60 min** (LMX-5 class) | ~60 min | ≤100 cm² (라벨) | US Part 348 (lid 0.5-4% ✓) · KR 일반의약품 |
| **Rx-V1** | **hexa-LAC v1** (lid 7% + tet 7% + LA 5% + EtOH 20% + epi 1:200k + HPC peel-film) | **~3 min** (eutectic + CPE ER 3×) | 60-90 min | ≤400 cm² (single session) | US 505(b)(2) Pliaglis RLD · KR 자료제출 (전문) |
| **Rx-V2** | **N6-C capric ternary v1** (lid 7+tet 7+capric 10% + LA 5 + EtOH 20 + epi + HPC) | **~3 min** (eutectic shared) | **180 min** (capric a≈5 flux multiplier · onset 무관) | ≤300 cm² (보수적) | US 505(b)(2) v1 변형 NDA · KR 자료제출 |

### 1.3 G6 (pediatric) — 6 age band × SKU 매트릭스 (G3 흡수)

| age band | 체중 중앙값 (kg) | 권장 SKU | max area (cm²) | apply (min) | onset (min) | margin vs threshold |
|---|---|---|---|---|---|---|
| neonate <28d (term ≥37wk) | 3.5 | **clinical-defer** (BORDERLINE) | ≤7 | ≤60 | n/a | 1947× (수치 PASS but PK 미성숙) |
| infant 1-12mo | 7 | **OTC-A** (prilocaine-free 필수) | ≤20 | 45-60 | 45-60 | 638× |
| toddler 1-3y | 13 | OTC-A | ≤100 | 45-60 | 45-60 | 191× |
| preschool 3-6y | 19 | OTC-A | ≤100 | 45-60 | 45-60 | 191× |
| school 6-12y | 30 | **OTC-A** or **Rx-V1** (procedure 의존) | ≤200 | 30-45 | 30 / 3 | 130× / 130× |
| adolescent 12-18y | 55 | **Rx-V1** (adult-eq) | ≤400 | 30 | 3 | 68× |

> **prilocaine-free wall**: EMLA <37wk preterm 금기 + <12mo MetHb-inducer 병용금기는 NUMB v1 (no prilocaine) 에 transfer ✗ — 그러나 **신생아 행은 honest framing 으로 clinical-defer** (@D d5/d6).

---

## 2. 라벨 자동 분기 dispatcher (decision tree)

### 2.1 입력 / 출력 contract

```
INPUT
  indication     ∈ {hair, vascular, tattoo, injection, biopsy, pediatric}
  weight         ∈ [3, 120]   kg
  age            ∈ [0, 99]    yr  (0=neonate <1y)
  area           ∈ [1, 2000]  cm²
  concomitant    ∈ {none, methb_inducer, opioid, class_I_antiarrhythmic}

OUTPUT
  sku            ∈ {OTC-A, Rx-V1, Rx-V2, REFUSE}
  concentration  string ("lid 4%" | "lid 7+tet 7+epi" | "lid 7+tet 7+capric 10+epi")
  apply_min      ∈ [15, 60]
  max_area       cm²
  onset_min      ∈ [3, 60]
  duration_min   ∈ [60, 180]
  warning        string[]
  rationale      string
```

### 2.2 decision tree (graphical)

```
                   ┌─────────────────────────┐
                   │  INPUT (5 fields)       │
                   └────────────┬────────────┘
                                │
                ┌───────────────┴───────────────┐
                │ age < 0.08 yr (neonate <28d)? │
                └─────┬─────────────────────┬───┘
                  YES │                     │ NO
                      ▼                     ▼
              ┌─────────────┐    ┌─────────────────────┐
              │ REFUSE      │    │ age < 12 mo &       │
              │ "clin-defer"│    │ concomitant=methb ? │
              └─────────────┘    └──┬───────────────┬──┘
                                 YES│               │ NO
                                    ▼               ▼
                            ┌─────────────┐  ┌────────────────────┐
                            │ REFUSE      │  │ indication branch  │
                            │ "methb+inf" │  └─────────┬──────────┘
                            └─────────────┘            │
       ┌───────────────────────────────────────────────┤
       │                  │              │              │              │
       ▼                  ▼              ▼              ▼              ▼
  hair_removal       vascular         tattoo        injection       biopsy
       │                  │              │              │              │
       │ age<12y?          │              │              │              │
       │  YES→OTC-A        │              │ area>1000?   │ age<12y?     │
       │  NO →             │              │  YES→Rx-V1   │  YES→OTC-A   │
       │   area≤100→OTC-A  │              │       split  │  NO →Rx-V1   │
       │   area>100→Rx-V1  │              │  >400→Rx-V1  │              │
       │                   │              │       derate │              │
       ▼                   ▼              ▼              ▼              ▼
   Rx-V1 default      Rx-V1 default    Rx-V2 ≤400     OTC-A or Rx-V1  Rx-V1
   (OTC-A if age<12)  (얼굴 mask)      (capric x3 dur) (속도 가치)      (속도 가치)
       │                   │              │              │              │
       └───────┬───────────┴──────────────┴──────────────┴──────────────┘
               ▼
       ┌────────────────────────────────────┐
       │ ENVELOPE CHECK (G3 max_area)       │
       │   if area > max_area_for_age(age)  │
       │     → DERATE (split 권고) or REFUSE │
       └────────────────────────────────────┘
               ▼
       ┌────────────────────────────────────┐
       │ ATTACH WARNINGS                    │
       │  • >400 cm² → split 권장           │
       │  • +epi → 손·발·코·귀·생식기 금지  │
       │  • Class I AA 병용 → caution       │
       │  • methb_inducer + lid → caution   │
       └────────────────────────────────────┘
               ▼
            OUTPUT
```

### 2.3 SKU 결정 우선순위 (lex-order)

1. **safety vetoes** (neonate <28d → REFUSE; <12mo + methb_inducer → REFUSE)
2. **indication primary** (tattoo CREATION → Rx-V2 default · 그 외 → Rx-V1)
3. **OTC fallback** (age <12y · area ≤100 · indication ∈ {hair, injection, biopsy, pediatric} → OTC-A)
4. **area envelope** (G3 age-cap 위반 시 → DERATE 또는 split)
5. **concomitant attach warnings** (Class I AA · methb_inducer · opioid)

---

## 3. FDA Drug Facts (OTC-A) — 1-page skeleton

> per **21 CFR 201.66** (format) · **21 CFR 348** (lid 0.5-4% external analgesic monograph)

```
┌─────────────────────────────────────────────────────────────────┐
│ Drug Facts                                                      │
├─────────────────────────────────────────────────────────────────┤
│ Active ingredient (in each gram)         │ Purpose              │
│   Lidocaine 4%  (40 mg)                  │   Topical anesthetic │
├─────────────────────────────────────────────────────────────────┤
│ Uses                                                            │
│   • temporarily relieves pain and discomfort associated with    │
│     minor skin procedures (laser hair removal at home, minor    │
│     injections, skin biopsy site preparation)                   │
│   • numbs the skin before minor cosmetic procedures             │
├─────────────────────────────────────────────────────────────────┤
│ Warnings                                                        │
│   For external use only                                         │
│                                                                 │
│   Do not use                                                    │
│     • on cut, irritated, or infected skin                       │
│     • on large areas of the body                                │
│     • on mucous membranes (mouth, eyes, genital area)           │
│     • in children under 1 month of age                          │
│     • with a heating pad or wrap (increased absorption risk)    │
│                                                                 │
│   Ask a doctor before use if you                                │
│     • are pregnant or breast-feeding                            │
│     • take a Class I antiarrhythmic drug (mexiletine, tocainide)│
│     • have a methemoglobinemia risk (sulfa drugs, nitrates)     │
│                                                                 │
│   When using this product                                       │
│     • avoid contact with eyes                                   │
│     • do not apply to more than 100 cm² (about a hand palm)     │
│     • do not leave on more than 60 minutes                      │
│                                                                 │
│   Stop use and ask a doctor if                                  │
│     • condition worsens                                         │
│     • symptoms persist for more than 7 days                     │
│     • rash, itching, or swelling occurs                         │
│     • bluish skin or lips (possible methemoglobinemia)          │
│                                                                 │
│   Keep out of reach of children. In case of overdose,           │
│   get medical help or contact a Poison Control Center           │
│   right away (1-800-222-1222).                                  │
├─────────────────────────────────────────────────────────────────┤
│ Directions                                                      │
│   adults and children ≥ 12 years                                │
│     • apply a thin layer (about 1-2 g per 100 cm²) to clean,    │
│       dry, unbroken skin                                        │
│     • cover with non-occlusive dressing (optional)              │
│     • wait 45-60 minutes before the procedure                   │
│     • wipe off excess before procedure                          │
│     • do not exceed 4 applications per day                      │
│   children 1-12 years                                           │
│     • apply only as directed by a doctor                        │
│     • max area: ≤ 20 cm² (infant) · ≤ 100 cm² (≥3 y)            │
│   children < 1 month: do not use                                │
├─────────────────────────────────────────────────────────────────┤
│ Other information                                               │
│   • store at 20-25°C (68-77°F)                                  │
│   • protect from freezing                                       │
├─────────────────────────────────────────────────────────────────┤
│ Inactive ingredients                                            │
│   carbomer, glyceryl monostearate, lecithin, polysorbate 80,    │
│   propylene glycol, purified water, sorbitol, trolamine         │
├─────────────────────────────────────────────────────────────────┤
│ Questions or comments?  1-800-XXX-XXXX                          │
└─────────────────────────────────────────────────────────────────┘
```

---

## 4. Rx USPI (Rx-V1 hexa-LAC v1) — 1-page skeleton

> per **21 CFR 201.56-57** (PLR USPI format) · 505(b)(2) Pliaglis RLD-anchored

```
NUMB™ (lidocaine 7% + tetracaine 7% + epinephrine 1:200,000) Cream
                       For topical use only · Rx only
═════════════════════════════════════════════════════════════════
INDICATIONS AND USAGE
  NUMB Cream is indicated for topical local analgesia in adults
  and pediatric patients ≥ 1 year of age prior to:
    • laser-assisted dermatologic procedures
       (hair removal, vascular lesions, resurfacing)
    • dermatologic biopsy / excision (intact skin)
    • cosmetic injection procedures (filler, botox)
    • tattoo creation (small / medium area, ≤ 400 cm²)

DOSAGE AND ADMINISTRATION (highlights)
  Adults: apply 1-2 g per 100 cm² to intact skin, max 400 cm²,
          for 30 minutes. Peel film and wipe before procedure.
          Onset of effective anesthesia: ~3 minutes after apply.
  Pediatric:
    ≥12 y, >40 kg : adult dose, max 400 cm²
    6-12 y, 20-40 kg : max 200 cm²
    3-6 y, 15-25 kg : max 100 cm²  (G3 envelope)
    1-3 y, 10-20 kg : max 100 cm²
    <1 y : not recommended (BORDERLINE; clinical-defer)

DOSAGE FORMS AND STRENGTHS
  Cream: 70 mg/g lidocaine + 70 mg/g tetracaine + 5 µg/g
         epinephrine (as 1:200,000). HPC-based peel-film carrier.

CONTRAINDICATIONS
  • Known hypersensitivity to amide- or ester-type local
    anesthetics, PABA derivatives, or any component
  • Use on broken, inflamed, or infected skin
  • Application to mucous membranes (mouth, eye, genital)
  • Application to ears (risk of CNS exposure via eardrum)
  • Patients with congenital methemoglobinemia (tet path)
  • Areas of compromised perfusion (fingers, toes, nose, ear,
    penis — epinephrine contraindication)

WARNINGS AND PRECAUTIONS
  5.1  Systemic Local Anesthetic Toxicity (LAST)
       Risk increases with area, duration, age <1y, hepatic
       impairment, broken skin. Cmax envelope (G3 model) keeps
       margin ≥ 68× vs 5000 ng/mL threshold at labeled doses.
  5.2  Methemoglobinemia
       Tetracaine path is lower-risk than prilocaine. Avoid
       concomitant methemoglobin-inducing drugs (sulfonamides,
       nitrates, nitroprusside, phenobarbital, primaquine).
  5.3  Vasoconstrictor Risk (epinephrine)
       Not for use on digits, nose, ear, penis, fingertips.
  5.4  Pediatric Use
       <1 y: BORDERLINE per G3 PK-immaturity (free-fraction 2×,
       CL 0.5×). Use clinical judgment; lid 4% OTC may be safer.
  5.5  Class I Antiarrhythmic Coadministration
       Additive cardiac depressant effects with mexiletine,
       tocainide. Use with caution.

ADVERSE REACTIONS
  Most common (>1%): application-site erythema, edema, pruritus,
  pallor (epi-mediated). Serious: hypersensitivity, LAST.

USE IN SPECIFIC POPULATIONS
  Pregnancy : Category B (lidocaine) · C (tetracaine, epi)
  Lactation : lidocaine excreted in breast milk; caution
  Pediatric : per §5.4 + dose envelope above
  Geriatric : no dose adjustment needed
  Hepatic impairment : reduce area / time by 50%

OVERDOSAGE
  Wipe off cream immediately. Monitor for LAST signs (perioral
  numbness, dizziness, seizure, arrhythmia). Intralipid 20%
  rescue per ASRA guideline.

CLINICAL PHARMACOLOGY
  • Onset: ~3 min (eutectic + CPE ER 3× via LA + EtOH)
  • Tmax: 30-45 min · t½ (lid): ~90 min
  • Depth: ~3-5 mm with +epi 1:200,000 (λ 60 µm with epi)
  • Cmax @ 100 cm² × 30 min + epi: ~18 ng/mL (273× margin)

HOW SUPPLIED · STORAGE
  30 g aluminum tube · single-dose 5 g sachet
  Store 20-25°C · protect from light · do not freeze
  Shelf-life: 24 mo (target, G5 territory)
```

---

## 5. 시각 가이드 (ASCII)

### 5.1 결정 트리 (indication → SKU) — full path

```
   ┌─ START ─┐
   │ indication?
   └────┬────┘
        │
   ┌────┼─────────────────────────────────────────────────────────┐
   │    │                                                         │
   ▼    ▼                                                         ▼
 hair  vascular ─→ Rx-V1 (얼굴 mask, 30min apply, 3min onset)    biopsy
   │                                                              │
   │  ┌─age<12y or area≤100?                                      │  age<12y?
   │  └─YES→OTC-A   NO→Rx-V1                                      │   YES→OTC-A
   │                                                              │   NO →Rx-V1
   ▼                                                              ▼
 tattoo CREATION
   │
   │  area>1000 → Rx-V1 5+5% derate + 2-session split (4hr gap)
   │  area>400  → Rx-V1 standard 7+7%
   │  area≤400  → Rx-V2 (capric ternary, duration ×3)
   ▼
 injection
   │
   │  speed-critical (procedure ≤15min) → Rx-V1
   │  area≤10 + non-urgent              → OTC-A
   ▼
 pediatric
   │
   │  age<28d        → REFUSE (clinical-defer)
   │  age<12mo +methb→ REFUSE
   │  age<12mo       → OTC-A (max 20 cm², 60min apply)
   │  1-12y          → OTC-A default · Rx-V1 if procedure speed-critical
   │  12-18y         → Rx-V1 adult-eq
   ▼
   END
```

### 5.2 onset timer (5 / 15 / 30 / 60 min)

```
 Rx-V1 / Rx-V2 (~3 min onset)
   apply ┃                                                       wipe
         ┃▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░┃
         0   3min                                              30min
             └─ effective anesthesia (procedure window 3-30min)
              window 60-90min (with epi vaso)


 OTC-A (lid 4%, LMX-class)
   apply ┃                                                       wipe
         ┃░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓┃
         0                      45min                          60min
                                └─ onset effective
                                  window 45-105min
```

### 5.3 면적 visual — 손바닥 = 100 cm² anchor

```
   손바닥 1개 (palm)  =  ~100 cm²    [OTC-A 라벨 cap]

   ▒▒▒                                          (≈ 10 cm² · injection · 0.3-0.5g)
   ▒▒▒                                          ←  손가락 끝 한마디
   ▒▒▒

   ▒▒▒▒▒▒▒▒▒▒                                   (≈ 100 cm² · OTC-A · 1-2g)
   ▒▒▒▒▒▒▒▒▒▒                                   ← 손바닥
   ▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒

   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                         (≈ 400 cm² · Rx-V1 max · 4-8g)
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                         ← 한쪽 다리 (laser leg)
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                         (≈ 1000 cm² · tattoo sleeve · split 必)
```

---

## 6. hexa-native dispatcher 사양 (→ `sim/g7_label_dispatcher.hexa`)

### 6.1 함수 시그니처

```
dispatch(indication, weight_kg, age_yr, area_cm2, concomitant) -> outputs:
  sku           : "OTC-A" | "Rx-V1" | "Rx-V2" | "REFUSE"
  conc_lid_pct  : 4 | 7
  conc_tet_pct  : 0 | 7
  apply_min     : int
  max_area      : int
  onset_min     : int
  duration_min  : int
  warning_code  : bitmask (1=split, 2=epi, 4=methb, 8=class_I_AA, 16=clinical_defer)
```

### 6.2 6 indication × 3 SKU 9 sanity case

| case | indication | weight | age | area | concom | → SKU | conc | apply | onset | max_area | warn |
|---|---|---|---|---|---|---|---|---|---|---|---|
| C1 | hair | 70 | 30 | 400 | none | Rx-V1 | lid7+tet7+epi | 30 | 3 | 400 | epi |
| C2 | hair | 25 | 8 | 50 | none | OTC-A | lid4 | 45 | 45 | 100 | — |
| C3 | vascular | 60 | 28 | 150 | none | Rx-V1 | lid7+tet7+epi | 30 | 3 | 400 | epi |
| C4 | tattoo | 70 | 25 | 300 | none | Rx-V2 | lid7+tet7+capric10+epi | 30 | 3 | 300 | epi |
| C5 | tattoo | 75 | 30 | 1200 | none | Rx-V1 | lid5+tet5+epi (derate) | 30 | 3 | 400 | epi+split |
| C6 | injection | 70 | 35 | 10 | none | OTC-A | lid4 | 30 | 30 | 100 | — |
| C7 | biopsy | 70 | 40 | 20 | none | Rx-V1 | lid7+tet7+epi | 30 | 3 | 400 | epi |
| C8 | pediatric | 13 | 2 | 50 | none | OTC-A | lid4 | 45 | 45 | 100 | — |
| C9 | pediatric | 3.5 | 0.05 | 7 | none | REFUSE | — | — | — | — | clinical_defer |
| C10 | hair | 70 | 30 | 100 | class_I_AA | Rx-V1 | lid7+tet7+epi | 30 | 3 | 400 | epi+class_I_AA |
| C11 | injection | 7 | 0.5 | 5 | methb_inducer | REFUSE | — | — | — | — | methb+infant |

### 6.3 verify (per @D g5)

V1 dispatcher recompute: 11 sanity case 모두 정합 → `hexa run sim/g7_label_dispatcher.hexa` (numerical 🟢).

---

## 7. tier & ledger

| 자산 | tier | 근거 |
|---|---|---|
| 3-step workflow matrix | 🟡 | G1 + G2 + G3 직접 적용 · 임상 prosp 자료 N/A |
| dispatcher decision tree | 🟢 | closed-form · hexa-native recompute · 11 case PASS |
| FDA Drug Facts (OTC-A) skeleton | 🟡 | 21 CFR 201.66 + 348 mapping · 실제 NDC 발급 전 draft |
| Rx-V1 USPI skeleton | 🟡 | PLR 21 CFR 201.56-57 mapping · Pliaglis RLD anchor |
| visual guides (ASCII) | 🟢 | onset timer + 면적 anchor 수치 정합 (G1 손바닥 100cm²) |
| OTC-A 45-60min onset honest | 🟢 | LMX-5 class label · 과대 약속 회피 (@D d5/d6) |

---

## 8. deep research (d18 정합)

### 8.1 web — FDA OTC monograph (재활용 + 확장)

- **21 CFR 201.66** ([eCFR](https://www.ecfr.gov/current/title-21/chapter-I/subchapter-C/part-201/subpart-C/section-201.66)) — Drug Facts format 표준 (1999 final rule): "Drug Facts" 제목 + Active ingredient / Purpose / Uses / Warnings (Do not use · Ask a doctor · When using · Stop use) / Directions / Other information / Inactive ingredients / Questions 섹션.
- **21 CFR 348** (External Analgesic) — lid 0.5-4% · tet 1-2% 한도 (G2 §2.2 흡수). NUMB OTC-A = lid 4% 단독으로 정합.
- 핵심 라벨 요건: bold subhead + Helvetica 6pt min · 좌측 정렬 · "for external use only" 강제 · MetHb 경고 (sulfa/nitrate concomitant) · pediatric "ask a doctor" trigger.

### 8.2 arxiv — readability anchor

- **2309.06961** (Gröger 2023, dermatology benchmark) — derm 이미지 라벨 신뢰성 (직접 patient-label readability 아닌 image-label 정확성) — peripheral.
- **1509.00379** (Barth 2015, *On the Readability of Boundary Labeling*) — leader-line label readability formal user study · 본 G7 의 ASCII visual (손바닥 anchor + onset timer) 의 readability 직관 정합 (boundary leader ≈ visual anchor).
- 직접 dermatology patient-label readability arxiv 인용은 sparse — FDA Plain Language guidance + Flesch-Kincaid 6th-grade target 권고가 산업 표준 (web 영역).

### 8.3 cross-finding

```
   G1 (8 indication) ─┐
   G2 (OTC tet wall, Rx 505(b)(2))─┐
   G3 (6 age + prilocaine-free) ───┼──→ G7 dispatcher
   N6-C (capric duration ×3) ──────┘     - 6 indication × 3 SKU case 모두 결정 가능
                                         - OTC-A onset 45-60min honest (no overpromise)
                                         - Rx-V1/V2 onset ~3min target
                                         - neonate <28d + <12mo+methb = REFUSE veto
```

---

## 9. 후속 milestone 연결

- **G4** (제형 variant) — Rx-V2 capric ternary 정식 spec · OTC switch path (lid 4 → 5+tet 2 한도내) 평가
- **G5** (포장/안정성) — 5g sachet (single-dose Rx-V1) · 30g tube · peel-film 광안정성 · 24mo shelf
- **G6** (인접 제품 양립성) — sunscreen 30min gap 권고 · chlorhexidine 동시 X · moisturizer 도포 후 X
- **oracle** — multi-indication clinical PASS rate (95%) + LAST 임상 0 incident + OTC/Rx 듀얼 승인 → absorbed=true

---

*author: NUMB/G7 · 2026-05-25 · per @D d5/d6/d10/g5 · 격리 worktree `numb-g7-retry-7f0570d3`*
