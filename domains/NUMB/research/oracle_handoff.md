# NUMB oracle — measured-oracle wet-lab handoff 명세

> 🧊 **NUMB oracle milestone** — non-wet-lab 게이트가 전부 closed 된 시점에서, in-silico 로 **닫을 수 없는** 측정 항목만을 명세하는 **wet-lab 측정 핸드오프**.
>
> **honest tier verdict: absorbed = FALSE (유지)**. non-wet-lab 8/8 PASS (G1-G7 + verify V3) 이지만 **@D d5 정합** — absorbed 는 wet-lab 측정 (downstream confirmation) 까지 대기. in-silico PASS 가 absorbed 를 의미하지 **않는다**. projection (G5 25.7mo 외삽 · N6 SVL m.p. 예측 · N5 r_mg=0.30 추정) 은 absorbed 를 flip 할 수 없다.
>
> sim = `NUMB/sim/oracle_gate.hexa` (deterministic absorbed-decision evaluator · 🟢 §6 verbatim).

---

## 0. @D d5 정합 — absorbed 결정 규칙

```
absorbed = (ALL non-wet-lab gates PASS) AND (ALL wet-lab oracle gates PASS)
```

- non-wet-lab block = **CLOSED** (8/8 PASS). 추가로 in-silico 로 닫을 수 있는 게이트는 **없음** (소진).
- wet-lab block = **OPEN** (0/12 PASS). 측정만 남음.
- ∴ **absorbed = FALSE**. 본 oracle milestone 은 "wet-lab 만 남았다"는 honest 상태를 명세 + 측정 path 를 phased 로 제시하는 것이지, absorbed 를 flip 하는 것이 아니다.

> @D d5: "absorbed=true ⇔ 모든 non-wet-lab 게이트 PASS · wet-lab 은 downstream confirmation." → 본 도메인은 그 *경계*에 있다: non-wet-lab 다 PASS · wet-lab 대기. **이것이 가장 honest 한 상태 평가.**

---

## 1. wet-lab gate 인벤토리 (in-silico 로 닫을 수 없는 측정 항목)

각 claim 의 현재 tier 는 🟠 (INSUFFICIENT/DEFERRED) — 측정 1회로 🟢(PASS)/🔴(FALSIFY) 결정.

| # | claim (in-silico 미결) | 측정법 | 비용 | 결정 tier (🟠→) | source milestone |
|---|---|---|---|---|---|
| W1 | **onset 95%-ile ≤ target** (OTC-A 45-60min · Rx-V1 ~3min) — `t_lag=h²/(6D)` 의 *human* 검증 | pin-prick / laser-pain VAS, healthy volunteer | $100K-1M+ (Phase 2) | 🟢/🔴 | G1·G4·G7 |
| W2 | **depth C(z) 실측** vs `C(z)=C_surf·exp(−z/λ)` (λ 40→60μm +epi) | micro-dialysis / biopsy depth-profile | $10-30K (ex-vivo) → 임상 | 🟢/🔴 | TTR-LAC A3 상속 |
| W3 | **LAST Cmax < threshold** (체중·면적별 human PK) | volunteer 혈중 lidocaine HPLC/LC-MS, 면적 sweep | $100K-1M+ (Phase 2) | 🟢/🔴 | G1·G3·A4 |
| W4 | **N5 토픽 Mg MEC shift r_mg=0.30** — *단일 missing measurement* (토픽 Mg+lido 진피 시너지 직접 실측 ZERO) | ex-vivo SC Franz + pin-prick ED50 shift | $10-30K (Phase 1) | 🟡/🔴 | N5 |
| W5 | **N6 ternary eutectic m.p.** (lid+tet+capric Tm; SVL 예측 ±3°C) | DSC 5-sample plate (4:4:2 / 3:3:4 / 2:2:6 + binary anchor + pure capric) | $200-500 | 🟡/🔴 | N6 |
| W6 | **N6 ion-pair K_sc** (lid·linoleate⁻ logP shift; Franz 10-12× → in-vivo 3-5×) | Franz 1-point (hexa-LAC v1 vs N6-C @30min K_perm) | $500-1000 | 🟡/🔴 | N6 |
| W7 | **N7 pH-gradient flux** (lid f_free 0.40%→80% @ pH 5.5→8.5; K_sc 8-12× in-vivo) | Franz pH 5.5 vs 8.5 (cadaver/synthetic SC) | $500-1000 | 🟡/🔴 | N7 |
| W8 | **N7 epi 분해 + lid amide 가수분해** (epi pH 8.5 30% loss @30min; lid max-stab pH 3-6) | epi/lid HPLC (bilayer N7-A/B/C @ T=0,1d,7d,30d, 40°C) | $300-600 | 🟡/🔴 | N7·G5 |
| W9 | **G5 epi 산화 real-time 24mo** (Arrhenius 외삽 25.7mo = projection, NOT measured) | ICH Q1A real-time 25°C/24mo 확정시험 + 가속 6mo | $5-15K (확정시험) | 🟢/🔴 | G5 |
| W10 | **G3 신생아 <28d 임상 confirmation** (numeric margin 1947× but BORDERLINE: PK 미성숙·AAG 2×·CL 0.5×) | 신생아 단회 PK + MetHb 모니터 (소아 임상) | Phase 2 (소아) | 🟢/🔴 | G3 |
| W11 | **OTC regulatory 승인** (lid 4% 단독 monograph/NDA) | FDA/KFDA filing + review | $2-5M (G2) | 승인/반려 | G2·G4 |
| W12 | **Rx 505(b)(2) NDA 승인** (hexa-LAC v1, Pliaglis RLD) | FDA 505(b)(2) filing + review | $15-50M·5-7yr (G2) | 승인/반려 | G2·G4 |

**총 wet-lab gate = 12** (효능 코어 3 · NOVEL probe 5 · 안정성/소아/규제 confirm 4).

---

## 2. oracle PASS 기준 정량 (absorbed=true 게이트 값)

absorbed 를 flip 하려면 아래 *측정값*이 모두 PASS 여야 한다 (sim §5 verbatim).

### 2.1 onset (W1)
- **OTC-A**: onset 95%-ile ≤ **60 min** (LMX-5 class · D~1e-10 · eutectic 없음). "OTC 5분" 과대 약속 ✗.
- **Rx-V1**: onset 95%-ile ≤ **3 min** target (D 2e-9 · eutectic + CPE ER 3×).
- Rx-V2 onset = Rx-V1 onset (N6 honest: a/K_sc 는 J_ss prefactor · t_lag 무관).

### 2.2 LAST Cmax (W3) — 체중·면적별 threshold
- **adult**: Cmax < **2500 ng/mL** (= CNS-warn 5000 × 50% safety floor).
- **neonate**: Cmax < **1250 ng/mL** (= neonate-derate 2500 × 50%; AAG 2× · CL 0.5×).
- 현재 closed-form 예측 (sim §5): Rx-V1 @400cm² Cmax = **73.3 ng/mL** (margin 68.2×) — **PK 로 CONFIRM 필요** (예측이지 측정 아님).

### 2.3 pediatric envelope (W10)
- neonate <28d: numeric margin 1947× 이나 **BORDERLINE** → 임상 confirmation 필수. confirm 전까지 라벨 = clinical-defer (≥1mo + prilocaine-free).

### 2.4 regulatory dual (W11·W12)
- **OTC** monograph/NDA APPROVED **AND** **Rx** 505(b)(2) NDA APPROVED — 둘 다.

---

## 3. phased wet-lab study 우선순위 + 비용 (study → 결정 claim 매핑)

### Phase 0 — in-vitro (저비용 · 즉시 시작) → **$2,650 (target $2000-5000 내)**
| study | 결정 gate | 비용 (mid) | timeline |
|---|---|---|---|
| DSC 5-sample plate | W5 N6 ternary m.p. | $350 | 1 day |
| Franz 1-point (N6) | W6 N6 ion-pair K_sc | $750 | 1 week |
| Franz pH 5.5 vs 8.5 (N7) | W7 N7 pH-gradient flux | $750 | 1 week |
| DSC alkaline lid (N7) | W8 (lid 안정성 일부) | $350 | 1 day + 1wk |
| epi/lid HPLC (N7+G5 batch) | W8 N7 epi 분해 · W9 G5 가속 epi-HPLC | $450 | 1 month |

→ **Phase 0 가 12 wet gate 중 8 개를 touch** (W5·W6·W7·W8 직접 결정 + W9 가속 anchor). **N6·N7·G5 cost-share batch** = 최우선 (가장 cheap-est NOVEL probe — N6·N7 동시).

### Phase 1 — ex-vivo / 소규모 → **$10K-30K**
| study | 결정 gate | 비용 | timeline |
|---|---|---|---|
| 인체 SC Franz (cadaver) | W2 depth C(z) ex-vivo · W7 in-vivo derate | $10-20K | 2-4 weeks |
| pin-prick ED50 shift | W4 N5 토픽 Mg MEC r_mg (**단일 missing measurement**) | $10-15K | 4-8 weeks |

→ N5 의 r_mg=0.30 중심 가정이 **단일 측정**에 의존 → Phase 1 이 N5 를 🟠→🟡/🔴 로 결정.

### Phase 2 — 임상 → **$100K-1M+**
| study | 결정 gate | 비용 | timeline |
|---|---|---|---|
| healthy volunteer onset (VAS) | W1 onset 95%-ile | $100-300K | 6-12 mo |
| human PK (혈중 lidocaine) | W3 LAST Cmax | $200-500K | 6-12 mo |
| 소아 단회 PK + MetHb | W10 neonate 임상 confirm | $300K-1M | 12-24 mo |
| + Phase 2 = W11·W12 규제 패키지로 이어짐 (G2: OTC $2-5M / Rx $15-50M) | W11·W12 | (G2) | (G2) |

---

## 4. decision tree — 각 wet-lab 결과 → SKU/제형 영향 (sim §7 verbatim)

| wet 결과 | SKU / 제형 영향 |
|---|---|
| **N6 DSC FAIL** (ternary depression 없음) | Rx-V2 capric **폐기** · Rx-V1 flagship 유지 |
| **N6 Franz K_sc < 3× in-vivo** | V2 depth/duration claim **FALSIFIED** → Rx-V1 only |
| **N7 Franz flux < 3×** | pH-gradient bilayer **폐기** · single-pH Rx-V1 유지 |
| **N7 epi-HPLC bilayer 분해** | 2-chamber **MANDATORY** (이미 설계) 또는 N7-A 2-SKU |
| **N5 r_mg < 0.15** (토픽 Mg shift 없음) | Mg adjuvant **폐기** · 대면적 = split-dose only |
| **N5 r_mg ≥ 0.30 PASS** | 타투 sleeve 500-800cm² 단일세션 **unlock** |
| **G5 real-time epi < 24mo** | dating 단축 또는 냉장 logistics |
| **onset_p95 Rx-V1 > 3min** | honest 재라벨 · OTC-A 무관 (45-60min) |
| **LAST Cmax > threshold** (어느 band든) | label max_area / 농도 축소 |
| **neonate 임상 FAIL** | neonate REFUSE 유지 · ≥1mo 무관 |

---

## 5. hexa-native oracle gate sim (verbatim · 🟢 · per @D g5)

`NUMB/sim/oracle_gate.hexa` — deterministic absorbed-decision evaluator. 각 게이트 PASS(1)/PENDING(0) 입력 → AND-product 로 absorbed 판정. non-wet-lab 8/8 PASS 현황 → "wet-lab 만 남음" 확인. (ubu-1 `hexa run` 실행 검증)

```
=== NUMB oracle gate — deterministic absorbed-decision evaluator (@D d5) ===
RULE: absorbed = (ALL non-wet-lab PASS) AND (ALL wet-lab oracle PASS)
      flag 1 = PASS (measured/closed) · flag 0 = PENDING (unmeasured/open)
      wet-lab = DOWNSTREAM CONFIRMATION; non-wet-lab passing alone != absorbed
[1] NON-WET-LAB gates (in-silico / closed-form / literature)
  G1 indication   = 1
  G2 regulatory   = 1
  G3 ped(numeric) = 1
  G4 sku-split    = 1
  G5 shelf(proj)  = 1
  G6 compat       = 1
  G7 dispatcher   = 1
  V3 recompute    = 1
  NON-WET-LAB passing = 8 / 8   product(AND) = 1
[2] WET-LAB ORACLE gates (measurement required — in-silico NOT closable)
  onset VAS (95%<=target)      = 0
  depth C(z) measured          = 0
  LAST Cmax human PK           = 0
  N5 topical Mg MEC r_mg=0.30  = 0  (single missing measurement)
  N6 ternary DSC m.p.          = 0
  N6 ion-pair K_sc Franz       = 0
  N7 pH-gradient flux Franz    = 0
  N7 epi/lid HPLC stability    = 0
  G5 epi real-time 24mo        = 0
  G3 neonate clinical confirm  = 0
  OTC regulatory approval      = 0
  Rx 505(b)(2) approval        = 0
  WET-LAB passing = 0 / 12   product(AND) = 0
[3] ABSORBED decision (deterministic, @D d5)
  absorbed = nonwet_product(1) * wet_product(0) = 0
  non-wet-lab block: CLOSED (all 8 PASS)
  wet-lab block: OPEN (oracle awaiting measurement)
  VERDICT: absorbed = FALSE
[4] honest state readout (@D d5/d6)
  non-wet-lab status : 8/8 PASS
  -> in-silico gates EXHAUSTED (nothing more closable without measurement)
  wet-lab remaining  : 12/12 gates open
  CRITICAL HONESTY: in-silico PASS does NOT imply absorbed.
  absorbed waits ONLY on wet-lab measurement (downstream confirmation).
  No projection (G5 25.7mo / N6 SVL m.p. / N5 r_mg=0.30) may flip absorbed.
[5] oracle PASS criteria (quantified absorbed-gate thresholds)
  onset_p95: OTC-A <= 60.0 min ; Rx-V1 <= 3.0 min
  LAST Cmax PASS: adult < 2500.0 ng/mL ; neonate < 1250.0 ng/mL
  (predicted Rx-V1 400cm^2 Cmax=73.3075 ng/mL margin=68.2058x — to be CONFIRMED by PK)
  pediatric: neonate <28d numeric margin 1947x but BORDERLINE -> clinical confirm REQUIRED
  regulatory: OTC monograph/NDA APPROVED + Rx 505(b)(2) NDA APPROVED (both)
[6] phased wet-lab cost ladder
  Phase 0 (in-vitro: DSC + Franz + HPLC) total = $2650.0
    -> decides: N6 m.p./K_sc · N7 flux/stability · G5 epi-HPLC accel (8 of 12 wet gates touched)
  Phase 1 (ex-vivo SC Franz + pin-prick ED50) = $10000.0 - $30000.0
    -> decides: N5 topical Mg MEC r_mg (single missing) · depth C(z) ex-vivo
  Phase 2 (clinical: onset VAS / PK / pediatric) = $100000.0 - $1000000.0+
    -> decides: onset_p95 · LAST Cmax human PK · neonate clinical confirm
[7] decision tree (wet result -> SKU/formulation impact)
  N6 DSC FAIL (no ternary depression)   -> drop Rx-V2 capric; Rx-V1 remains flagship
  N6 Franz K_sc < 3x in-vivo            -> V2 depth/duration claim FALSIFIED -> Rx-V1 only
  N7 Franz flux < 3x                    -> drop pH-gradient bilayer; keep single-pH Rx-V1
  N7 epi-HPLC degrade in bilayer        -> 2-chamber MANDATORY (already designed) or N7-A 2-SKU
  N5 r_mg < 0.15 (topical Mg no shift)  -> drop Mg adjuvant; large-area = split-dose only
  N5 r_mg >= 0.30 PASS                  -> unlock tattoo-sleeve 500-800cm^2 single session
  G5 real-time epi < 24mo               -> shorten dating or refrigerated logistics
  onset_p95 Rx-V1 > 3min                -> relabel honest onset; OTC-A unaffected (45-60min)
  LAST Cmax > threshold (any band)      -> reduce max_area / concentration in label
  neonate clinical FAIL                 -> neonate REFUSE stays; >=1mo unaffected
=== oracle_gate VERIFIED 🟢 — absorbed = FALSE (non-wet-lab CLOSED, wet-lab OPEN) ===
```

---

## 6. 종합 — honest absorbed 평가 (@D d5/d6)

- **non-wet-lab block CLOSED** (8/8): G1-G7 + verify V3 모두 PASS. 추가로 in-silico 로 닫을 게이트 **소진** (더 닫을 게 없음).
- **wet-lab block OPEN** (0/12): 효능 코어 (onset·depth·LAST PK) · NOVEL (N5 Mg · N6 ternary · N7 pH) · 안정성/소아/규제 confirm 전부 측정 대기.
- **absorbed = FALSE** (유지). 본 oracle milestone 은 측정 path 를 명세 + phased 비용을 산정했을 뿐, absorbed 를 flip 하지 **않는다**.
- **다음 액션** = Phase 0 ($2,650, N6+N7+G5 cost-share batch) 부터. 12 wet gate 중 8 개를 가장 싼 in-vitro 한 batch 로 결정 → N6/N7/V2 SKU 운명 + G5 가속 epi anchor 확정.

> **@D d5 핵심**: in-silico 가 다 PASS 했다고 "absorbed" 라고 말하는 것은 governance 위반. wet-lab measurement (downstream confirmation) 만이 absorbed 를 flip 한다. 본 명세는 그 경계를 정직하게 기록한다.
