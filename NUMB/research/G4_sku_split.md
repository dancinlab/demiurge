# NUMB G4 — SKU split 결정 트리 (OTC vs Rx-V1 vs Rx-V2)

> 🧊 **NUMB milestone G4** — G2 OTC monograph WALL (21 CFR 348.10 lid 0.5-4% · tet 1-2%) 후 재설계.
> G1 hexa-LAC v1 (lid 7+tet 7+epi+peel-film) 단일 SKU = 7/8 indication ✓, 그러나 OTC path는 lid 4% 단독으로 분리 불가피.
> 본 G4 = **3-tier SKU 포트폴리오** (OTC-A · Rx-V1 · Rx-V2) 정량 spec + indication 매트릭스 + 결정 트리 + 시장 capture 추정.
> **sim** = `NUMB/sim/g4_sku_split.hexa` (A1/A4/G1 상속 — onset · depth · duration · LAST 정량 비교).

---

## 0. honest framing (per @D d5/d6)

1. **OTC-A onset = LMX-4/5 class ~45-60min** — D-boost 가 없으므로 hexa-LAC v1 의 ~3min 과 명확히 구분된다. "OTC도 5분 onset" 같은 과대 약속 ✗.
2. **Rx-V2 (capric ternary) 의 depth/duration 우위 = N6 DSC + Franz wet-lab 의존 (🟠)** — Schröder-Van Laar 예측만 가지고 "Rx-V1 보다 6× 깊다"고 마케팅 불가. V2 가치는 wet-lab 검증 후에야 🟡 승격.
3. **cannibalization 위험**: Rx-V2 가 Rx-V1 의 procurement 를 잠식 가능 (같은 처방자 · 같은 indication). G4 결정 트리는 cannibalization 을 명시 변수로 모델링한다.
4. **안와 사용 contraindicated** — N6 wall (BLT corneal damage 학습 · JCAD 2016). 모든 SKU 에 "do not use near eyes" 라벨, V2 (capric pH-shift) 는 추가 안와 경고.

---

## 1. SKU spec — 3 후보 정량

### 1.1 OTC-A — `NUMB OTC lid 4`

| 축 | 값 | 근거 |
|---|---|---|
| 활성 | lidocaine 4% (단일) | 21 CFR 348.10 lid OTC max 4% |
| 부형제 | LA 5% · EtOH 20% · HPC 매트릭스 (peel 없음) | G1 base (eutectic 없으므로 peel-film 미적용) |
| epi | ✗ | OTC 모노그래프에 없음 |
| 면적 cap (라벨) | ≤200 cm² (성인) · ≤100 cm² (소아 ≥2y) | 21 CFR 348.50 외부 분석가 라벨 + EMLA 1300 cm² baseline 의 보수적 1/6 |
| 적용 시간 | 30-60 min apply (no peel) | LMX-4 라벨 precedent |
| 예상 onset | **45-60 min** (D ~ 1e-10, LMX 클래스) | A1 closed-form (eutectic 없음 → D-boost 미적용) |
| depth @ 200μm | ~30% MEC (얕음) | A3 exp(-z/λ) · λ=40μm |
| duration | 60-90 min | LMX-4 label · 짧음 |
| indication (라벨) | "minor cuts · minor burns · sunburn · minor skin irritation · insect bites" (21 CFR 348.50 fixed wording) | DailyMed 다중 lid 4% labels |
| 라벨 워딩 | "For external use only · Drug Facts · Avoid contact with eyes · Do not use over large areas of the body · Not for use on broken/inflamed skin · Stop use and ask a doctor if condition worsens or symptoms persist >7 days" | 21 CFR 348.50 |
| regulatory cost/time | $2-5M / 1-2 yr (Aspercreme/LMX 클래스 OTC ANDA-like) | G2 §2.2 |
| 가격 (소비자) | $15-25 / 30g (LMX-4 ~$42 floor 보다 generic-equivalent) | drug-pricing precedent |

### 1.2 Rx-V1 — `hexa-LAC v1` (G1 anchor, Pliaglis class)

| 축 | 값 | 근거 |
|---|---|---|
| 활성 | lidocaine 7% + tetracaine 7% (eutectic 30°C) | Pliaglis precedent · Yuan 2015 measured |
| 부형제 | LA 5% · EtOH 20% · HPC peel-film · epi 1:200k | G1 base |
| epi | **✓ 1:200k** | A4 50% Cmax 감소 |
| 면적 cap (라벨) | ≤400 cm² (성인) · split ≥4h 권고 over | Pliaglis label · A4 |
| 적용 시간 | 20-30 min apply (peel-film 자가-종단) | Pliaglis precedent |
| 예상 onset | **~3 min** (D 2e-9, eutectic + CPE 20×) | A1 + A2 D-boost · G1 §5 |
| depth @ 200μm | **~95% MEC** (정합 dermal block) | A3 · g1 §5 |
| duration | 90-120 min (+epi vasoconstriction) | Pliaglis label |
| indication (라벨) | "topical local analgesia for superficial dermatologic procedures: laser hair removal · laser facial resurfacing · IPL · vascular laser · filler injection · dermal procedure" | Pliaglis NDA 21-717 |
| regulatory cost/time | $15-50M / 5-7yr (US 505(b)(2)) | G2 §2.1 |
| 가격 | $$$ (Pliaglis ~$300+ / 30g range) | branded Rx topical |

### 1.3 Rx-V2 — `hexa-LAC v2` (N6-C capric ternary, premium)

| 축 | 값 | 근거 |
|---|---|---|
| 활성 | lidocaine 7% + tetracaine 7% + **capric acid 10-15%** | N6 §3.3 (mol 0.4:0.4:0.2) |
| 부형제 | LA 5% · EtOH 20% · HPC peel-film · epi 1:200k · 시트레이트 buffer pH 5.5 | N6 §3.3 + §4 pH-sting mitigation |
| epi | ✓ 1:200k | A4 inherit |
| 면적 cap (라벨) | ≤800 cm² (large-area tattoo sleeve sweet spot) | LAST recompute (§3) 통과 |
| 적용 시간 | 30-45 min apply | wet-lab 검증 후 확정 |
| 예상 onset | **~3 min (V1 과 동일)** — N6 honest framing: a/K_sc 는 J_ss 만 증폭, t_lag 무관 | N6 §1.3 |
| depth @ 200μm | **N6-C C/MEC = 12** (V1 의 ~6× steady-state flux) | N6 §6 (🟠 wet-lab 의존) |
| duration | **150-240 min** (capric ion-pair · PCM carrier 잔존) | N6 §3.3 (🟠 wet-lab) |
| indication (라벨) | **타투 제작 (sleeve)** · large-area laser (등·체스트 600-1000 cm²) · deep dermal procedure | N6 sweet spot |
| 안와 | **CONTRAINDICATED** (capric pH-shift + BLT corneal 학습) | N6 §4.3 wall |
| 소아 | **CONTRAINDICATED** (capric pH-sting 영아 부적격) | conservative (G3 prilocaine-free 효과 V1 으로 흡수) |
| regulatory cost/time | $20-60M / 6-8yr (505(b)(2) · novel ternary + capric anion) | G2 §2.1 baseline + novel ingredient overhead 30-40% |
| 가격 | $$$$ (premium · "depth/duration" 차별화) | Pliaglis 대비 +30% premium 목표 |

---

## 2. indication × SKU × outcome 매트릭스

8 indication (G1) × 3 SKU × {primary / secondary / contra} 매핑:

| # | indication | OTC-A (lid 4%) | Rx-V1 (hexa-LAC v1) | Rx-V2 (N6-C capric) |
|---|---|---|---|---|
| I1-face | laser hair removal (얼굴 ~50 cm²) | secondary (onset 느림) | **primary** | secondary (V1 충분) |
| I1-leg | laser hair removal (다리 400 cm²) | ✗ (면적 초과) | **primary** | secondary |
| I1-back | laser hair removal (등 600 cm²) | ✗ | secondary (split 권고) | **primary** (large-area premium) |
| I2 | pre-needle (vaccine / IV / blood draw) | **primary** (OTC accessibility) | secondary (over-engineered) | ✗ (over-engineered) |
| I3 | pre-laser vasc/resurf (얼굴 100-200 cm²) | secondary | **primary** | secondary |
| I4-typ | tattoo creation 200-400 cm² × 1-2h | ✗ (면적 + 시간) | **primary** | secondary |
| I4-max | tattoo CREATION sleeve 1000 cm² × 2-4h | ✗ | secondary (split 必) | **primary** (depth+duration sweet spot) |
| I5 | derm biopsy/excision 20 cm² | **primary** | secondary | ✗ |
| **I6** | **pediatric** (G3) | **primary** (lid-only, prilocaine-free ✓ 소아 OTC 클래스) | secondary (≥2y on label) | **contra** (capric pH-sting) |
| I7 | filler/botox 30 cm² | secondary (onset 느림 vs procedure tempo) | **primary** (3min onset ≈ 15min stretch) | ✗ (over) |
| I8 | dental gel | ✗ (mucosal · out-of-scope) | ✗ | ✗ |
| **eyelid/안와** | (G6 사전 정의) | secondary (lid-only OK ≤2cm²) | secondary (avoid 권고) | **contra** (BLT class wall) |

### 2.1 매트릭스 — 매핑 요약

- **OTC-A primary**: I2 · I5 · I6 (소아) — 작은 면적 · 셀프-OTC · prilocaine-free 안전.
- **Rx-V1 primary**: I1-face/leg · I3 · I4-typ · I7 — *cosmetic-grade fast-onset SKU* (Pliaglis 의 후속, +epi 차별).
- **Rx-V2 primary**: I1-back · I4-max — *대면적 + 장시간 sweet spot*. 시장 분율 작지만 unit price 높음.

소아 (I6) SKU 매핑 (G3 prilocaine-free):
- **OTC-A primary** (lid 단독 = MetHb 경로 자체 없음 · 21 CFR 348.50 소아 라벨 가능 ≥2y) — accessibility 최대.
- Rx-V1 secondary (≥2y on label · clinic 사용 · +epi 헤드룸 면적 cap 50 cm² 보수).
- Rx-V2 contra (capric pH-sting + 미실측 = 사전 보수 배제).

안와 (G6 사전 정의):
- V2 contra (BLT class wall, JCAD 2016).
- V1 / OTC-A "avoid contact with eyes" 라벨 (FDA 표준), 의도적 안와 사용은 OFF-LABEL.

---

## 3. hexa-native recompute (verbatim · 🟢 · per @D g5)

`run`: `hexa run NUMB/sim/g4_sku_split.hexa`

```
=== NUMB G4 — SKU split (OTC-A / Rx-V1 / Rx-V2) ===

[1] onset (closed-form 2*t_lag, h = 10 um SC)
  OTC-A (D=1e-10, LMX class)              : onset(min) = 55.5556
  Rx-V1 (D=2e-9, eutectic + CPE 20x)      : onset(min) =  2.77778
  Rx-V2 (D=2e-9, V1 + capric ternary)     : onset(min) =  2.77778
  >> Rx-V2 onset EQUALS Rx-V1 onset (N6 honest: a/K_sc are J_ss prefactors, not t_lag)

[2] depth at z = 200 um (C(z)/MEC) — A3 exp(-z/lambda) with lambda(+epi)=60 um
  OTC-A : C(200um)/MEC =  0.31
  Rx-V1 : C(200um)/MEC =  1.92
  Rx-V2 : C(200um)/MEC = 11.99
  >> OTC-A subtherapeutic at 200 um; Rx-V1 clean block; Rx-V2 12x stack [WET-LAB GATE]

[3] duration (clinical anchor + epi/PCM extension, min)
  OTC-A : 60.0  | Rx-V1 : 105.0  | Rx-V2 : 194.985
  >> Rx-V2 ~3.25 h vs Rx-V1 1.75 h vs OTC-A 1.0 h (V2 is WET-LAB GATED)

[4] LAST headroom @ A = 400 cm^2, 30 min apply, vs 5000 ng/mL
  OTC-A : Cmax = 27.9 ng/mL  margin 179x
  Rx-V1 : Cmax = 73.4 ng/mL  margin  68x   (G1 §3 verbatim)
  Rx-V2 : Cmax = 73.4 ng/mL  margin  68x   (same lid+tet; capric non-LA)

[5] indication primary-share capture (TAM-weighted)
  OTC-A primary share = 0.237   (I2 + I5 + I6 pediatric)
  Rx-V1 primary share = 0.567   (I1-face/leg + I3 + I4-typ + I7)
  Rx-V2 primary share = 0.196   (I1-back + I4-max)
  TOTAL                = 1.000

[6] portfolio coverage (in-scope TAM)
  SINGLE (Rx-V1 only)         : 0.6165   (~62%)
  DUAL   (OTC-A + Rx-V1)      : 0.9040   (~91%)
  TRIPLE (OTC-A + V1 + V2)    : 1.0000   (100%)

[7] cost / timeline matrix (USD M / years)
  SINGLE : $32.5M /  6.0 yr
  DUAL   : $36.0M /  6.0 yr (parallel OTC, longest leg)
  TRIPLE : $76.0M /  8.0 yr (V2 lags ~1yr post-V1)

[8] cannibalization-adjusted net share
  DUAL   net (5% cannib)   = 0.8588
  TRIPLE net (15% cannib)  = 0.8500     <-- triple loses to dual after cannib

[9] decision-tree deltas
  +TAM dual vs single   = +0.2875  for +$3.5M / +0yr critical path
  +TAM triple vs dual   = +0.0960  for +$40.0M / +2yr / +10pp cannib

  >> DEFAULT = DUAL (OTC-A + Rx-V1)
     V2 trigger = (N6 DSC+Franz PASS) AND (tattoo-sleeve TAM >= $200M) AND (V1 yr2 revenue >= $50M)

=== G4 PASS — DUAL SKU portfolio (OTC-A lid4 + Rx-V1 hexa-LAC v1); V2 wet-lab trigger gated ===
=== periocular: V2 CONTRA · V1/OTC-A 'avoid eyes' (BLT corneal class wall) ===
=== pediatric: OTC-A PRIMARY (prilocaine-free + monograph label) · V1 secondary · V2 CONTRA ===
```

---

## 4. 결정 트리 — 단일 vs 듀얼 vs 트리플 SKU

```
                    ┌─────────────────────────────┐
                    │  SKU portfolio decision     │
                    └──────────────┬──────────────┘
                                   │
              ┌────────────────────┼────────────────────┐
              │                    │                    │
              ▼                    ▼                    ▼
       ┌──────────┐         ┌──────────┐         ┌──────────┐
       │ SINGLE   │         │  DUAL    │         │ TRIPLE   │
       │ Rx-V1 만 │         │ OTC-A +  │         │ OTC-A +  │
       │ (G1 anchor)│       │ Rx-V1    │         │ V1 + V2  │
       └──────┬───┘         └─────┬────┘         └─────┬────┘
              │                   │                    │
   ─────────────────────────────────────────────────────────────
   coverage:  62% TAM            91% TAM             100% TAM
   ─────────────────────────────────────────────────────────────
   cost:      $15-50M·5-7yr      +$2-5M·1-2yr        +$20-60M·6-8yr
              (G2 §2.1)          (OTC parallel)      (V2 incremental)
   ─────────────────────────────────────────────────────────────
   time-to-mkt: 5-7 yr           OTC ships 1-2 yr    V2 후속 6-8 yr
                                 (early revenue)     (총 8-10 yr)
   ─────────────────────────────────────────────────────────────
   cannibalize: n/a              ~5% (가격대 분리)   ~15% (V2→V1)
   ─────────────────────────────────────────────────────────────
   임상 차별화: V1 fast-onset     OTC = accessibility V2 = depth/dur
              만               + Rx = fast-onset      premium
   ─────────────────────────────────────────────────────────────
   risk:      I2/I5/I6 미커버    capric wet-lab gate ✗  V2 wet-lab gate
              (시장 21% 손실)                          + cannibalize ↑
   ─────────────────────────────────────────────────────────────
```

### 4.1 결정 — **DUAL (OTC-A + Rx-V1)** = round-3 권고 default

근거:
1. **TAM 91% 커버** (I8 dental 만 미커버 = out-of-scope) — 단일 (62%) 대비 +29%p, triple 대비 -9%p.
2. **time-to-revenue 가속** = OTC-A 가 1-2yr 안에 출시 (Pliaglis 5-7yr 기다리지 않음) → 임상 검증 데이터/브랜드 인지도 → Rx-V1 출시 시점에 cross-promotion.
3. **cannibalization 최소** (~5%) — OTC vs Rx 가격대 (수십 달러 vs 수백 달러) + 면적/시간 cap 라벨 분리.
4. **V2 의 wet-lab risk 회피** — N6 🟠 INSUFFICIENT 상태에서 commit 하는 R&D risk 가 dual 의 TAM gap (9%p) 보다 크다.

### 4.2 V2 trigger 조건 (triple 으로 격상하는 가드레일)

- N6 wet-lab gate 통과 (DSC + Franz · $700-1500): ternary m.p. ≤28°C measured · J_ss ≥3× over V1 measured.
- 타투 sleeve TAM 측정 가능 (≥$200M 글로벌 미커버 영역) — 현 추정 ~23% NUMB TAM 중 I1-back/I4-max 가 차지.
- V1 출시 후 2yr trailing revenue ≥ $50M (V2 R&D 의 자체 재투자 가능 threshold).

> 3 조건 동시 충족 시에만 V2 commit. round-3 시점에서는 dual 단계 → V1 출시까지의 임상 데이터로 V2 trigger 재평가.

---

## 5. 시장 capture 추정 (정량)

| segment | 글로벌 TAM | NUMB primary 분율 | NUMB capture (dual) | NUMB capture (triple) |
|---|---:|---:|---:|---:|
| laser hair removal (I1) | **$1.42-1.58 B** (G1) | face/leg = V1, back = V2 | **75%** (V1) | **100%** (V1+V2) |
| pre-needle (I2) | $300-500 M (LMX/Topicaine 슬롯) | OTC-A | **80%** | 80% (동일) |
| pre-laser (I3) | $200-300 M | V1 | 70% | 70% |
| tattoo CREATION (I4) | $300-500 M (BLT compounded 시장 대체) | typ=V1 / sleeve=V2 | 40% (typ only) | **70%** (sleeve unlock) |
| derm biopsy (I5) | $100-200 M | OTC-A / V1 split | 50% | 50% |
| pediatric (I6) | $150-300 M (vaccination + minor proc) | OTC-A | 60% | 60% |
| filler/botox (I7) | $200-400 M | V1 | 65% | 65% |
| dental (I8) | n/a (out-of-scope) | — | 0% | 0% |
| **TOTAL** | **~$2.7-3.8 B** | dual share | **62%** = ~$1.7-2.3 B addressable | triple share **74%** = ~$2.0-2.8 B addressable |

> NUMB 의 *realistic 5yr-cumulative revenue capture* 는 addressable 의 5-15% (가격·유통·경쟁) → dual = $85M-340M · triple = $100M-420M. 추가 $20-60M R&D 의 incremental NPV 가 +$15-80M 5yr-cum (희석 후) 인지 시장-가격 모델에서 검증 필요 (G7 territory).

---

## 6. 라벨 워딩 sketch — SKU 별 Drug Facts / Rx insert

### 6.1 OTC-A `NUMB OTC lid 4` (Drug Facts panel)

```
DRUG FACTS
Active ingredient                                  Purpose
Lidocaine 4%                                       Topical anesthetic

Uses
- temporarily relieves pain and itching due to:
  - minor cuts, minor scrapes, sunburn,
  - minor skin irritations, minor burns, insect bites

Warnings
For external use only. Avoid contact with the eyes.
Do not use over large areas of the body.
Do not use on broken or inflamed skin.
When using this product, do not bandage tightly.
Stop use and ask a doctor if condition worsens or
symptoms persist for more than 7 days.

Children under 2 years of age: Ask a doctor.

Directions
Adults and children ≥2 years: apply a thin layer to
affected area not larger than 2.5 inches × 4 inches
(≈ 40 cm²); leave on 30-60 min, then wipe off.
Do not apply more than 4 times daily.
```

### 6.2 Rx-V1 / Rx-V2 (Pliaglis-class prescribing info — 발췌)

핵심 절: INDICATIONS / DOSAGE / WARNINGS-PRECAUTIONS / ADVERSE REACTIONS / CLINICAL PHARMACOLOGY / HOW SUPPLIED.

- INDICATIONS V1: "topical local analgesia for superficial dermatologic procedures including filler injection, laser hair removal, vascular laser, IPL, dermal procedures"
- INDICATIONS V2: V1 + "tattoo creation (≥200 cm²)" 추가
- WARNINGS V2: "Contraindicated for periocular use" · "Not recommended in patients < 12 years" · "Buffered to pH 5.5; transient stinging possible at application"

---

## 7. tier ledger + verdict

| claim | tier |
|---|---|
| OTC-A onset 45-60min (LMX class, no D-boost) | 🟢 closed-form (A1 inherit) |
| Rx-V1 onset ~3min · depth ~95% · LAST margin 68× | 🟢 numerical (G1 §5 verbatim) |
| Rx-V2 onset = V1 (a/K_sc 는 J_ss 만) | 🔵 closed-form (N6 §1.3) |
| Rx-V2 depth C/MEC 12 · duration 195 min | 🟠 wet-lab gate (N6 DSC + Franz) |
| OTC-A regulatory $2-5M / 1-2yr | 🟡 cite (G2 §2.2 LMX/Aspercreme 클래스) |
| Rx-V1 regulatory $15-50M / 5-7yr | 🟡 cite (G2 §2.1 Pliaglis RLD) |
| Rx-V2 regulatory $20-60M / 6-8yr | 🟡 cite (G2 + novel ingredient overhead) |
| 21 CFR 348.10/348.50 lid 0.5-4% OTC label fixed wording | 🟢 regulation verbatim |
| Pliaglis FDA 2006 (NDA 21-717), 2008 voluntary withdrawal (manufacturing), Galderma reapproval | 🟡 cite (BioSpace · PracticalDermatology) |
| LMX-4 OTC Ferndale Laboratories ($42 / 30g typical) | 🟡 cite (drugs.com · SingleCare) |
| TAM segment 추정 ($1.42-1.58B laser hair removal · $300-500M pre-needle · etc.) | 🟡 cite (G1 sources + 부분 추정) |
| 시장 capture 분율 (NUMB 62-74%) | 🟠 추정 (segment 별 share assumption) |
| cannibalization 5% (dual) / 15% (triple) | 🟠 추정 (가격/면적 분리 가정 기반) |
| V2 trigger 가드레일 (3 조건 동시) | 🟡 governance (절차 정의) |

### G4 verdict (per @D d5)

> **G4 PASS (dual-SKU default 권고)**. 결정 트리 결과 = **DUAL = OTC-A + Rx-V1** 이 round-3 시점의 최적 — 단일 (62% TAM) → dual (91% TAM) 의 +29%p 가 추가 $2-5M·1-2yr 의 ROI 명확. Triple (V2 추가) 의 +9%p TAM 은 V2 wet-lab gate (N6 🟠) + cannibalization +10%p 가 dual 의 헤드룸을 잠식 → V2 는 **trigger 조건 3개 동시 충족 시에만 commit** (DSC+Franz PASS + tattoo sleeve TAM 확정 + V1 출시 후 2yr revenue ≥$50M). 안와 (G6 사전 정의) = V2 contra · V1/OTC-A avoid label. 소아 SKU (G3 prilocaine-free) = **OTC-A primary** (≥2y label) + V1 clinic secondary, V2 contra. absorbed=false 유지 (G5 포장/안정성 · G6 인접토픽 · G7 사용가이드 · NUMB-oracle 미완).

---

## 8. Sources

### regulatory / labeling
- 21 CFR Part 348 — External Analgesic Drug Products for OTC Human Use — [ecfr.gov/current/title-21/chapter-I/subchapter-D/part-348](https://www.ecfr.gov/current/title-21/chapter-I/subchapter-D/part-348)
- 21 CFR 348.50 — Labeling of external analgesic drug products — [ecfr.gov/current/title-21/chapter-I/subchapter-D/part-348/subpart-C/section-348.50](https://www.ecfr.gov/current/title-21/chapter-I/subchapter-D/part-348/subpart-C/section-348.50)
- FDA Rulemaking History for OTC External Analgesic — [fda.gov/drugs/historical-status-otc-rulemakings/rulemaking-history-otc-external-analgesic-drug-products](https://www.fda.gov/drugs/historical-status-otc-rulemakings/rulemaking-history-otc-external-analgesic-drug-products)

### competitor products
- LMX-4 (Ferndale Laboratories) lidocaine 4% OTC — [drugs.com/otc/105661/lmx4.html](https://www.drugs.com/otc/105661/lmx4.html) · [singlecare.com/prescription/lmx-4](https://www.singlecare.com/prescription/lmx-4)
- LMX-5 (Ferndale) lidocaine 5% — DailyMed setid 34f8ed6b — [dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=34f8ed6b-4a52-4a99-9c1b-254196dc29b0](https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=34f8ed6b-4a52-4a99-9c1b-254196dc29b0)
- Pliaglis (lid 7%/tet 7%) Prescribing Information — [drugs.com/pro/pliaglis.html](https://www.drugs.com/pro/pliaglis.html)
- Pliaglis 2008 voluntary withdrawal + Galderma reapproval — *PracticalDermatology* — [practicaldermatology.com/news/20120419-fda_seeks_more_information_on_pliaglis/2459818](https://practicaldermatology.com/news/20120419-fda_seeks_more_information_on_pliaglis/2459818/)
- Galderma agreement extension for worldwide Pliaglis — [galderma.com/news/agreement-extension-cover-worldwide-rights-pliaglis-r](https://www.galderma.com/news/agreement-extension-cover-worldwide-rights-pliaglis-r)
- Lidocaine Hydrochloride Market 2025-2030 — *Mordor Intelligence* ($701M → $964M, CAGR 5.53%) — [mordorintelligence.com/industry-reports/lidocaine-hydrochloride-market](https://www.mordorintelligence.com/industry-reports/lidocaine-hydrochloride-market)
- Topical anesthetics for dermatologic procedures review — *PubMed 22243434* — [pubmed.ncbi.nlm.nih.gov/22243434](https://pubmed.ncbi.nlm.nih.gov/22243434/)

### inherited
- G1 (`NUMB/research/G1_indication_map.md`) — 8 indication map · hexa-LAC v1 envelope
- G2 (`NUMB/research/G2_regulatory_pathway.md`) — 21 CFR 348.10 OTC wall · Rx 505(b)(2) path
- G3 (`NUMB/research/G3_pediatric_LAST.md`) — prilocaine-free 100× MetHb · 6 age-band PASS
- N6 (`NUMB/research/N6_ion_pair_eutectic.md`) — capric ternary J_ss 6× honest framing
- (재현) `NUMB/sim/g4_sku_split.hexa` — `hexa run NUMB/sim/g4_sku_split.hexa`
