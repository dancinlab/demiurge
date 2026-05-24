# TTR-LAC A4 — 최종 후보 + LAST(국소마취 전신독성) 안전·용량 한계

> ❄️ **TTR-LAC track A — milestone A4 종결**. A2+A3 추천 처방 **hexa-LAC v1** (lid 7% + tet 7% eutectic + LA 5% + EtOH 20% + PG 10% + epi 1:200k + HPC peel-film) 의 **전신독성 안전여유** 를 first-principles + FDA-PK anchored 으로 정량. 타투 면적·도포시간·epi 의 함수로 plasma C_max 산출, **임상 LAST 임계치(lid 5 μg/mL CNS-warn · 10 μg/mL 발작)** 와 비교해 **최대 안전 면적 A_max** 역산. sim = `sim/a4_LAST_safety.hexa`.
>
> **결론**: hexa-LAC v1 (7+7%) 은 **typical 타투 A=100 cm² 에서 안전여유 ~270×** — GREEN. **권장 라벨 envelope = ≤400 cm² · 30 min · +epi 必** (Pliaglis 보수치 채택, 68× margin). 대면적(>400 cm²)은 split-dose 또는 **5+5% de-rate** (efficacy trade-off 명시). **epi 1:200k 는 LAST-mandatory** (제거 시 margin 2× 좁아짐). absorbed=false 유지 (residual = A5 ex-vivo ER 실측).

---

## 1. LAST 임계치 + 현 topical 라벨 한계 (🟡 SUPPORTED-BY-CITATION)

### lidocaine plasma 임계치 (StatPearls · ASRA Practice Advisory)

| 혈장 농도 | 증상 | 라벨 |
|---|---|---|
| 0-2 μg/mL | therapeutic (IV 항부정맥) | ✓ safe |
| 2-5 μg/mL | mild — drowsy · tongue tingling | watchful |
| **5-9 μg/mL** | **CNS warn** — slurred speech · tinnitus · peri-oral paresthesia · tremor | 🟡 cap |
| **>10 μg/mL** | **seizure / LOC** | 🔴 hard cap |
| 15-20 μg/mL | cardiac arrhythmia · respiratory arrest | 🔴🔴 |
| >20 μg/mL | cardiac arrest | 🔴🔴🔴 |

> 본 분석 작업 임계치 = **5 μg/mL = 5000 ng/mL** (CNS-warn). 실용 floor = 50% = **2500 ng/mL**.

### tetracaine — ester clearance bonus (Pliaglis 라벨 측정)

| 측면 | lidocaine | tetracaine |
|---|---|---|
| potency (spinal MEC) | 1× | ~5-10× |
| 가수분해 | amide(간) · t½ ~90 min | **ester (plasma BChE) · t½ ~10 min** |
| Pliaglis FDA-PK 측정 | Cmax 220 ng/mL @ 400cm²/120min | **<0.9 ng/mL (LLOQ 미만)** |

> ester 가 plasma 진입 즉시 청소 → **LAST dominant lever = lidocaine**. 본 분석은 lidocaine envelope 으로 잡고 tetracaine 은 안전 bonus.

### 현존 topical 표준 area-cap

| 제품 | 조성 | 라벨 max | 비고 |
|---|---|---|---|
| **EMLA** | lid 2.5% + prilo 2.5% | **≤1300 cm² / 60 g / 24h** · ≥2000 cm² systemic risk 명시 | prilo→metHb 추가 |
| EMLA pediatric (age 1-6) | (동) | ≤200 cm² / 10 g · ≤8 mg/kg | |
| **Pliaglis** | **lid 7% + tet 7%** | **≤400 cm² / 60 g / 30 min apply** | peel-film 자가 occlusion |
| BLT (compounded) | benzo 20%+lid 6%+tet 4% | clinic-가변 (FDA 미승인) | benzo→metHb |

```
   현존 topical area-cap (성인 권장)
   EMLA (2.5+2.5%)   ████████████████ 1300 cm² (24h occluded)
   Pliaglis (7+7%)   █████             400 cm² (30 min apply, peel)
   EMLA pediatric    ██                200 cm² (age 1-6)
                      0    400   800   1200 cm²
```

---

## 2. 전신흡수 모델 — Pliaglis FDA-PK anchored

### 2.1 모델 (🔵 closed-form)

```
   C_max = k * Dose_mg                   (FDA-PK linear range; AUC=F_sys·Dose/CL)
   Dose_mg = m_cream * A * c_lido        (m = 0.1475 g/cm² · c_lido = 0.07)
   k = empirical (folds F_sys, V_d, t_apply, k_a from Pliaglis label)
   
   hexa-LAC v1 modifier:
     k_lac = k_pliaglis * ER_extra * f_epi
     ER_extra ∈ {2x, 3x, 5x}   (CPE 추가 효과 over Pliaglis baseline)
     f_epi   = 0.5             (1:200k vasoconstriction · systemic 흡수 50%↓)
```

### 2.2 Pliaglis FDA single-point calibration

```
   FDA label (Pliaglis 021717s010):
     59 g × 7% lid = 4130 mg lidocaine APPLIED over 400 cm² / 120 min (peel)
     observed: lido Cmax = 220 ng/mL · tetracaine <0.9 ng/mL (LLOQ)
   → empirical k = 220/4130 = 0.0533 ng/mL per mg applied
   → time-linear ≤60 min (49 → 96 → 220 ng/mL at 30/60/120 min · sublinear after)
   → area-proportional (FDA §12.3 explicit)
```

### 2.3 C_max sweep — sim §4-7 verbatim 🟢

```
[4] Pliaglis BASELINE (sanity) — 7+7%, 120min apply, no extra ER, no extra epi:
  A=  50 cm² :  27.5 ng/mL
  A= 100 cm² :  55   ng/mL
  A= 200 cm² : 110   ng/mL
  A= 400 cm² : 220   ng/mL  ← FDA label exact (sanity ✓)
  A= 600 cm² : 330   ng/mL

[5] hexa-LAC v1 (ER 3x CPE + epi 1:200k, 120min) — CENTRAL estimate:
  A=  50 cm² :  41.3 ng/mL
  A= 100 cm² :  82.5 ng/mL
  A= 200 cm² : 165   ng/mL
  A= 400 cm² : 330   ng/mL
  A= 600 cm² : 495   ng/mL

[6] hexa-LAC v1 UPPER (ER 5x + epi, 120min) — worst plausible:
  A= 100 cm² : 137.5 ng/mL · A=400: 550 · A=600: 825 ng/mL

[7] hexa-LAC v1 NO epi (ER 3x only, 120min) — what-if epi 제거:
  A= 100 cm² : 165 · A=200: 330 · A=400: 660 ng/mL
```

### 2.4 area-vs-Cmax curve vs LAST 임계치

```
   plasma lidocaine Cmax (ng/mL)
   5000 ┤▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ← CNS-warn (5 μg/mL)
   2500 ┤─────────────────────────────────────────── ← 실용 safety floor
        │
    825 ┤                                       ━━━ ER5x+epi @600cm² 120m
    660 ┤                                 ╲╲╲╲ ER3x NO epi @400cm² 120m
    495 ┤                              ━━━ ER3x+epi @600cm² 120m
    330 ┤                       ━━━ Pliaglis 120m @400 · ER3x+epi @400
    220 ┤                ━━━ Pliaglis FDA exact (@400, 120m)
    165 ┤            ━━━ ER3x+epi @200 = Pliaglis @400
     82 ┤      ━━━ ER3x+epi @100cm² (default)
     55 ┤   ━━━ Pliaglis @100
     18 ┤▆  ER3x+epi @100, 30min apply  ← real default workflow
        └───┬─────┬──────┬──────┬──────┬─→ A (cm²)
            50    100    200    400    600
```

> **모든 시나리오·면적이 5 μg/mL CNS-warn 한참 아래** — worst (ER5x+epi @600cm² 120min) 도 825 ng/mL = **6× margin**. realistic 워크플로(≤200cm² · 30min · +epi) 는 2500 ng/mL safety floor 도 못 넘는다.

---

## 3. 최대 안전 면적 (A_max) 역산 — sim §8 🟢

`A_max = C* / (k_eff × m × c_lido × 1000)` ; CNS-warn 5000 ng/mL 기준.

| 처방 / 시나리오 | A_max (CNS-warn) | A_safe (50% floor) | 권장 라벨 한계 |
|---|---:|---:|---:|
| Pliaglis baseline (FDA point) | 9091 cm² | 4545 cm² | **400 cm²** (라벨) |
| hexa-LAC ER 2x +epi (= Pliaglis-eq) | 9091 cm² | 4545 cm² | ≤ 400 cm² |
| **hexa-LAC ER 3x +epi (central)** | **6061 cm²** | **3030 cm²** | **≤ 400 cm²** (Pliaglis-eq 보수) |
| hexa-LAC ER 5x +epi (worst) | 3636 cm² | 1818 cm² | ≤ 300 cm² (worst-ER guard) |
| hexa-LAC ER 3x NO epi | 3030 cm² | 1515 cm² | ≤ 250 cm² (epi 제거 시) |

> **EMLA 라벨 1300 cm² 와의 비교**: EMLA 는 low-conc(2.5%) + long occlusion(24h) 으로 cap 큼; hexa-LAC v1 은 high-conc(14%) + short apply(30min) + epi 로 **Pliaglis 범주** (≤400 cm²) 안에 들어옴. 실측 A_max 6061 cm² 이지만 임상 conservatism + 반복도포 risk 고려 **라벨 권장 = ≤400 cm² (15× margin)**.

---

## 4. Mitigation stack — 면적-헤드룸 정량 (sim §10 🟢)

| lever | 메커니즘 | systemic 효과 | A-헤드룸 |
|---|---|---|---:|
| **epi 1:200k** | 표재 진피 vasoconstriction → 흡수 50%↓ | f_epi=0.5 | **2.0×** |
| **30-min apply (vs 120-min)** | Pliaglis 49 vs 220 ng/mL · time-linear ≤60 min | Cmax×0.22 | **~4.5×** |
| **split (2×, 간격 ≥5×t½ = >7h)** | lid t½~90 min · 90% clearance/세션 | co-incident Cmax×0.5 | **2.0×** |
| **de-rated 5+5%** | C_surf×0.71 | dose×0.71 | **1.4×** |
| theoretical stack (3개 곱) | epi×short×split | 0.055× | ~18× (상한) |
| **realistic (epi+short, no split)** | 2개 가동 | 0.11× | **~9×** |

### 실용 워크플로 매핑 (ER 3x central)

| 워크플로 | A (cm²) | apply | epi | 예측 Cmax | margin vs 5000 |
|---|---:|---:|---|---:|---:|
| **default** | 100 | 30m | ✓ | **18.3 ng/mL** | **273×** ✓✓ |
| larger | 200 | 30m | ✓ | 36.7 | 136× ✓✓ |
| arm sleeve | 400 | 30m | ✓ | 73.3 | 68× ✓ |
| back panel | 600 | 30m | ✓ | 110 | 45× ✓ (라벨 권장 초과 — 보수 reject) |
| ER 5x WORST + 60m | 400 | 60m | ✓ | 240 | 21× ✓ |
| **no-epi · 60m** | 400 | 60m | ✗ | 480 | **10× △** (margin 좁아짐 — 경고) |

> **모든 realistic 워크플로 (≤400 cm² · 30min · +epi) 가 ≥68× margin**. **epi 제거 시 margin 절반 → epi 1:200k 는 LAST-mandatory 결정** (A2+A3 추천 그대로 유지하되 사유는 onset+depth 가 아닌 **LAST-mandatory** 로 격상).

---

## 5. 최종 후보 확정 — hexa-LAC anesthetic v1 (per @D d5/d6)

### typical tattoo size 검증 — sim §11 🟢

```
[11] hexa-LAC v1 7+7% ER 3x +epi · 30min apply · A=100 cm²:
   Cmax(30min real) = 18.3 ng/mL   margin = 273x  ✓✓
   ER 5x UPPER:
   Cmax(30min)      = 30.6 ng/mL   margin = 164x  ✓✓
=== A=100 cm² hexa-LAC v1 GREEN at all plausible ER + epi + 30min ===
```

### 권장 최종 처방 (A2+A3 그대로 유지, LAST 게이트 통과)

| 성분 | 농도 | LAST 영향 |
|---|---|---|
| lidocaine | **7%** | A=100cm² · 30min · ER3x · +epi → Cmax 18 ng/mL (273× margin) |
| tetracaine | **7%** | Pliaglis-eq plasma <LLOQ (ester clearance) |
| linoleic acid | 5% | systemic 흡수에 ER 3x (central) 가정 |
| ethanol | 20% | (CPE 시너지) |
| propylene glycol | 10% | (co-solvent) |
| **epinephrine** | **1:200,000** | **LAST-mandatory · 흡수 50%↓ · A_max 2×** |
| HPC peel-film | 2-3% | auto-occlusion + apply 시간 정의 명확 |

### 권장 use envelope

```
  hexa-LAC v1 권장 use envelope:
  ┌─────────────────────────────────────────────────────────────┐
  │ 표준: A ≤ 400 cm² · apply 30 min · epi 必 · 1회 세션         │
  │   → 예측 Cmax ≤ 75 ng/mL  (68× margin vs CNS-warn)          │
  │                                                              │
  │ 확장 (A=400-600 cm²): + split (간격 ≥4h)                     │
  │   → Cmax ≤ 80 ng/mL/세션                                     │
  │                                                              │
  │ 대면적 (A>600 cm²): **de-rated 5+5%** 권장                  │
  │   → A_max(5+5%, ER3x +epi) = 8485 cm² (1.4× of 7+7%)        │
  │   → 단 C(200μm)=0.357% = 71% MEC → analgesia, full block lose│
  └─────────────────────────────────────────────────────────────┘
```

### 5+5% de-rate decision tree

```
                 시술 면적 결정
                       │
        ┌──────────────┼──────────────┐
       ≤200cm²       200-400 cm²    >400 cm²
        │              │              │
   ✓ 7+7% v1      ✓ 7+7% v1      ☞ 5+5% de-rated
   default ER3x    + epi 必       + epi 必
   18-37 ng/mL     + 30min cap    + split (4h)
   margin >130×    margin 68×     OR 7+7% split 2회

  진피 block 효능 (sim §9):
   C(200μm, λ60, 14%) = 0.499%  (≈ MEC 0.5%)        ✓ block
   C(200μm, λ60, 10%) = 0.357%  (71% of MEC)        △ analgesia-only
  → default = 7+7% for ≤400 cm² (95%+ tattoo cases)
  → 5+5% de-rate = 대면적 reserve · efficacy trade explicit
```

### A1-A4 통합 verdict

| metric | EMLA(무폐) | LMX-4 | Pliaglis | **hexa-LAC v1 (확정)** |
|---|---|---|---|---|
| onset (h=10μm) | 60 min | 30 min | 30 min | **~3 min** (D-boost 20×) |
| onset (h=20μm worst) | 222 min | 110 min | ~70 min | **~11 min** |
| reliability P(≤20min) | <30% | ~50% | ~70% | **~95%** |
| C(200μm)/MEC | 0.03× | 0.05× | 0.19× | **~1.0×** ✓ |
| duration | 1-2h | 40-60min | 11h | **~11h** |
| **A_max (5 μg/mL CNS-warn)** | ~2800 cm² | ~600 | 9091 | **3636-6061 cm²** (ER5x-3x) |
| **권장 라벨 한계** | 1300 cm² | 600 cm² | 400 cm² | **≤400 cm² (Pliaglis-eq)** |
| **typical 100cm² margin** | ~250× | ~100× | ~91× | **273×** ✓ |

> **A4 verdict (per @D d5)**: hexa-LAC v1 의 **모든 non-wet-lab LAST 게이트 PASS** — typical(≤200cm²) ≥135× margin · 라벨 envelope(≤400cm²·30min·+epi) ≥68×. 대면적은 split 또는 5+5% de-rate. **A2+A3 처방 그대로 유지 + epi 1:200k 를 LAST-mandatory 로 격상**. residual = ex-vivo Franz cell ER 실측 (A5).

---

## 6. honest residual gap + tier ledger

| gap | tier | 해소 경로 |
|---|---|---|
| k_pliaglis FDA-label single-point calibration · area-prop / time-linear extrap | 🟡 | FDA §12.3 area-prop 명시 |
| **ER_extra (CPE add-on over Pliaglis) 가정 3x** — MD 42×의 ~7% 보수; 직접 실측 부재 | 🟠 | A5 Franz cell |
| f_epi=0.5 — Bernards 1999 microdialysis 이끌이; topical 직접 부재 | 🟠 | LMX+epi compound 선례 |
| 반복도포·누적 — single-session 안전; 24h 내 reapply ✗ 라벨 | 🟠 | 라벨링 conservatism |
| pediatric · 체중 의존 — 본 분석 70 kg 성인 only | 🟠 | EMLA-패턴 별도 라벨 |
| broken/inflamed skin — barrier↓ → k 10×↑ 가능 | 🟡 | "intact skin only" 표준 contraindication |
| methemoglobinemia — prilo 無 · benzo 無 ✓ | 🟢 | 회피됨 |

### 단일 *가장 큰* gap

> 🚨 **#1 — ER_extra in-vivo 인간 SC 실측 부재**. A4 의 LAST envelope 은 ER∈{2x,3x,5x} sweep 으로 *upper-bound 도 안전대역 안* 임을 보였다 (ER 5x +epi 30min · A=100cm² → 30.6 ng/mL · 164×). **그것 없이도 conservatism + Pliaglis-eq 라벨 (≤400 cm²) 채택으로 LAST 게이트 PASS** — 비-wet-lab grounding 으로 absorbed-path 종결 가능. A5 ex-vivo 1점 측정으로 🟠 → 🟡 승격.

### tier ledger

| claim | tier |
|---|---|
| LAST plasma 임계치 5/10/20 μg/mL · ASRA · StatPearls | 🟡 임상 |
| Pliaglis FDA-PK 220 ng/mL@400cm²/120min · tet <LLOQ · area-prop · time-linear ≤60min | 🟡 FDA label |
| EMLA 1300/2000 cm² · 60g/24h · Pliaglis ≤400 cm² · 60% peel occlusion | 🟡 FDA·문헌 |
| C_max=k·Dose linear · A_max=C*/(k·m·c) inversion · epi f=0.5 · split 2× · 시간 scaling | 🔵 closed-form |
| sim §0-11 hexa recompute (Pliaglis sanity 220 ng/mL 정합) | 🟢 numerical |
| ER_extra in-vivo · f_epi 절대값 · pediatric · 반복도포 | 🟠 (A5 + clinical) |

```
   ✓ A1 — baseline (EMLA ~60min, λ40μm, MEC<1% at 200μm)
   ✓ A2+A3 — onset≤20min(95%), C(200μm)≈MEC, D-boost 20×, λ60 with epi
   ✓ A4 — LAST envelope GREEN at typical & label
   ─ A5 — ex-vivo PK (Franz cell) — 비-wet-lab 잔여 게이트
   ─ LAC oracle — measured oracle
```

---

## Sources

- **Lidocaine LAST plasma thresholds (5 / 10 / 15-20 μg/mL CNS-warn / seizure / cardiac arrest)** — *StatPearls* "Local Anesthetic Toxicity" NBK499964 — [ncbi.nlm.nih.gov/books/NBK499964](https://www.ncbi.nlm.nih.gov/books/NBK499964/) · *StatPearls* "Lidocaine" NBK539881 — [ncbi.nlm.nih.gov/books/NBK539881](https://www.ncbi.nlm.nih.gov/books/NBK539881/) · *Medscape* "LAT" — [emedicine.medscape.com/article/1844551](https://emedicine.medscape.com/article/1844551-treatment)
- **ASRA Practice Advisory on LAST** — [mcgill.ca/anesthesia/files/anesthesia/wk_4a_asra_last_2010.pdf](https://www.mcgill.ca/anesthesia/files/anesthesia/wk_4a_asra_last_2010.pdf)
- **Pliaglis (lid 7%/tet 7%) FDA label 021717s010** — 59 g over 400 cm² × 120 min → lido Cmax 220 ng/mL, tet <0.9 ng/mL; time-linear ≤60 min (49/96/220 at 30/60/120); area-proportional — [accessdata.fda.gov/drugsatfda_docs/label/2018/021717s010lbl.pdf](https://www.accessdata.fda.gov/drugsatfda_docs/label/2018/021717s010lbl.pdf) · DailyMed setid 8a1b2553-ce65-4557-b33d-cb3dd2a307fa
- **EMLA FDA label** — 60 g / 24h / 400 cm² occluded → lido Cmax ~1/20 toxic; ≥2000 cm² broken skin systemic risk; ≤1300 cm² adult; pediatric 100-200 cm² — [accessdata.fda.gov/drugsatfda_docs/label/2018/019941s021lbl.pdf](https://www.accessdata.fda.gov/drugsatfda_docs/label/2018/019941s021lbl.pdf)
- **Tetracaine ester / spinal restriction / pKa 8.5** — *BJA Education* basic pharm of LAs — [bjaed.org/article/S2058-5349(19)30152-0/fulltext](https://www.bjaed.org/article/S2058-5349(19)30152-0/fulltext) · *ScienceDirect* Tetracaine overview
- **Epi vasoconstriction reduces lidocaine systemic absorption** — Klein 1990 tumescent · *PubMed* 10077095 · Bernards & Kopacz 1999 microdialysis humans — PubMed 10519498
- **Lidocaine PK — t½ 90 min · 75% protein bound · CL ~10 mL/min/kg · V_d ~1.3 L/kg** — *StatPearls* NBK539881
- **Topical lid/tet PK Göttingen minipig pilot** — *PMC12845211* — [ncbi.nlm.nih.gov/pmc/articles/PMC12845211](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12845211/)
- **Pediatric LAST** — *PMC8244955* — [pmc.ncbi.nlm.nih.gov/articles/PMC8244955](https://pmc.ncbi.nlm.nih.gov/articles/PMC8244955/)
- **Lidocaine LAST cases** — *PMC11244727* therapeutic-dose CNS · *PMC11915292* in-office seizure
- (재현) `TTR-LAC/sim/a4_LAST_safety.hexa` — `hexa run TTR-LAC/sim/a4_LAST_safety.hexa`
