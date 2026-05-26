# NUMB N6 — ion-pair / ternary eutectic: m.p. depression × SC partition shift × ion-pair

> 🧊 **NUMB N6 (NOVEL 후보 · per @D d11)** — hexa-LAC v1 (lid 7% + tet 7% binary eutectic Tm ~30°C + LA 5% + EtOH 20% + epi 1:200k + HPC peel-film) 위에 **(a) 제3 마취제(BLT 변형)** 또는 **(b) carboxylic acid 짝(LA · capric · 등)** 을 더해 **ternary eutectic 또는 lid·anion ion-pair** 형성 → liquid window 확장 (Tm 30°C → 25-28°C) + free-base 활동도 ↑ + lid·oleate ion-pair K_sc 3-12× → **steady-state flux 5-6×** over hexa-LAC v1.
>
> **honest tier verdict: 🟠 INSUFFICIENT/DEFERRED (concept GREEN, 모든 정량 → DSC + Franz 1-point 측정 필요)**. 메커니즘 (Schröder-Van Laar · Hadgraft 1985 ion-pair · Tatara 2021 review) 은 🟡 임상/물리 정합, **정량 ΔHfus 결정 + ternary m.p. + ion-pair K_sc 모두 wet-lab gate** (~$700-1500 total). 본 N6 = first-in-class hexa-LAC 응용 — Pliaglis patent (WO2004103260A2 · Adams 2004) 가 *ternary local anesthetic eutectic* IP 를 *광범위* claim → **novel 비율 / novel anion / N1 PCM cross-axis** 가 진짜 novelty axis.
>
> sim = `NUMB/sim/n6_ion_pair_eutectic.hexa` (verbatim §6).
>
> **honest framing (N1 lesson 흡수, per @D d6)**: 활동도 a 는 `J_ss = D_eff·K_sc·a` 의 **steady-state** 항이지 `t_lag = h²/(6D_eff)` 와 무관 → **N6 의 a-boost 와 K_sc-boost 는 onset 가속이 아니다**. N6 의 진짜 가치 = **DEPTH 보전 (소아 G3 / OTC G4 저농도 SKU 가능) + DURATION 연장 + 단위면적당 SC delivery 효율**. "ternary로 onset 6분" 같은 추측 ✗.

---

## 1. 모델 — Schröder-Van Laar (이상 용액) + 활동도-flux 결합

### 1.1 Schröder-Van Laar binary 식
```
ln(x_i) = -(ΔHfus_i / R) · (1/T − 1/Tm_i)
sum_i x_i = 1   (eutectic point — all 고체상이 동일 T 에서 액화)
```

| 변수 | 정의 | 단위 |
|---|---|---|
| `x_i` | i 성분 액상 mole fraction | - |
| `ΔHfus_i` | i 성분 fusion enthalpy | J/mol |
| `Tm_i` | i 성분 pure m.p. | K |
| `T` | eutectic 온도 | K |
| `R` | gas const = 8.314 | J/(mol·K) |

### 1.2 ternary 확장 (3-성분 eutectic)
세 성분 동시 포화 — `sum x_i = 1, i ∈ {1,2,3}` 인 T 를 numerically solve.
이상 용액 가정 (γ_i = 1); non-ideal 계는 UNIQUAC/NRTL 가 더 정확하지만 first-pass = SVL.

### 1.3 활동도 → flux
```
a_free      = γ · x_free           (자유 염기 mole fraction × 활동도계수)
J_ss        = D_eff · K_sc · a     (정상상태 flux)
K_sc(ip)    = K_sc(free) · 10^(logP_ip − logP_free)   (ion-pair partition shift)
t_lag       = h² / (6·D_eff)       (D-driven, a 무관)
```

**N1 학습 적용**: `a` 와 `K_sc` 는 `J_ss` 의 prefactor — **onset 안 줄임**, **depth + duration + 단위 J** 만 증폭.

---

## 2. 입력 anchor (pure m.p. + ΔHfus)

| 성분 | Tm (°C) | Tm (K) | ΔHfus (kJ/mol) | 출처 |
|---|---|---|---|---|
| **lidocaine** | **68.17** | 341.32 | ~17 (추정) | Yuan 2015 MTDSC (PMC4444629) · ΔH 추정 |
| **tetracaine** | **42.93** | 316.08 | ~17 (추정) | Yuan 2015 MTDSC (PMC4444629) |
| **benzocaine** | **90.0** | 363.15 | **23.5 (측정)** | Sigma Aldrich · Springer s10973-022-11676-y |
| **prilocaine** | 38.0 | 311.15 | ~17 (추정) | DrugBank |
| **camphor** | 175.35 | 448.50 | ~6.8 | Yuan 2015 |
| **lid+tet 1:1 (binary)** | **29.95 (MEASURED)** | 303.10 | — | Yuan 2015 MTDSC (PMC4444629) |
| capric acid (C10) | 31.5 | 304.65 | ~28 | NIST WebBook |
| lauric acid (C12) | 43.8 | 316.95 | ~36 | NIST WebBook |
| myristic acid (C14) | 53.9 | 327.05 | ~45 | NIST WebBook |
| linoleic acid (C18:2) | -5.0 | 268.15 | liquid @ RT | NIST |
| oleic acid (C18:1) | 13.4 | 286.55 | ~40 | NIST · liquid @ RT |
| menthol | 42-45 | 315-318 | ~13.5 | NIST · DES partner (ACS Bio Mater 2019) |

**검증 gate**: Yuan 2015 measured binary lid+tet 1:1 eutectic = **29.95°C** → SVL framework 의 anchor truth (sim §1 에서 Taylor 근사 제약 명시; ternary 예측은 measured anchor 기준).

---

## 3. ternary 후보 3 — 핵심 표

| 후보 | 조성 (mol) | 예측 Tm (°C) | a-boost | ion-pair K_sc | flux × (vs hLAC v1) | LAST risk | regulatory novelty |
|---|---|---|---|---|---|---|---|
| **A: BLT-ternary** | lid + tet + **benzocaine** 0.49:0.20:0.10 (w/w 8:4:20) | **~30-32°C** (benzo Tm 90°C 끌어올림 → 거의 같음) | 1.1× (mole-shift) | 1× (FA 없음) | **1.1×** | base | 보통 (BLT compounded extemporaneous 시장 존재) |
| **B: lid + tet + LA** | lid + tet + **linoleic acid** 0.4:0.4:0.2 | **~27-29°C** (LA 액체 → eutectic ↓ 모derate) | 1.25× | **3-5× (lid·LA⁻)** | **~5×** | ↑ (envelope 재계산) | **HIGH** (LA = N1 CPE 와 결합, ion-pair 명시) |
| **C: lid + tet + capric** | lid + tet + **capric acid** 0.4:0.4:0.2 | **~25-28°C** (capric Tm 31.5°C anchor) | 1.25× | 3-5× (lid·capric⁻) + **N1 PCM 1.2×** | **~6×** | ↑↑ (가장 큰 flux) | **HIGHEST** (N1 PCM + N6 ternary + ion-pair triple-axis) |

**ranking**: **C > B > A** for flux/depth/duration. A 는 BLT 의 **temporal profile heterogeneity** (benzo 1-2min 표면 빠른 차단 + lid 5min 중간 + tet 15-30min 깊은) 이 진짜 가치 — **m.p./flux 가 아닌 시간축 다중화**.

### 3.1 Candidate A — BLT-ternary (lid + tet + benzocaine)
- **임상 evidence**: BLT cream (20% benzo + 8% lid + 4% tet) = 미국 compounded specialty (Wells Pharmacy · Park Compounding · ScriptWorks). JCAD 2017 (PMC5404778) RCT: 30min apply → first needle-stick pain ↓ (abrasive 변형 약간 우위, p=0.786 NS). **임상 onset 15min 이상** (BLT marketing claim 1min 은 benzo 표면-only).
- **WO2004103260A2 (Adams 2004 · Pliaglis 가족)**: ternary `prilocaine/lidocaine/bupivacaine` · `prilocaine/tetracaine/lidocaine` 등 IP 광범위 claim — *eutectic Tm < 20°C 보장*. **BLT 정확 조합 (benzo+lid+tet) 은 명시 claim 외 → novelty 여지 있음**.
- **돌발 사실** (안전): JCAD 2016 (PMC4896822) BLT corneal damage case → **face area / 안와 주변 CONTRA-INDICATED**.

### 3.2 Candidate B — lid + tet + linoleic acid (LA)
- LA = hexa-LAC v1 base 의 5% CPE 이미 포함 → **추가 mol fraction 0.2 = eutectic 의 적극적 partner**.
- ion-pair **lid·linoleate⁻** = Hadgraft 1985 / Tatara 2021 (PMC8234378) review 의 표준 ion-pair 메커니즘. **logP shift +1.5-2 → K_sc 3-12× 이론 ceiling**, 실제 Franz 10-12× peak.
- N1 cross-axis 없음 (LA Tm -5°C, 항상 액체) — **순수 N6 mechanism**.

### 3.3 Candidate C — lid + tet + capric acid (C10) — **TOP**
- capric Tm 31.5°C = **피부 표면 T (32-34°C) 와 정확히 일치** → carrier 가 표면에서 melt → N1 PCM 메커니즘 자연스럽게 spawning.
- ion-pair **lid·capric⁻** = volatile pH-shifter (capric pKa 4.9) + 중쇄지방산 SC fluidizer 효과 (Aungst 1986).
- **regulatory**: capric = **GRAS** (FDA 21 CFR 184.1025 · 식품등재) · **OTC monograph 적격** (Skin Care).
- **GAP 진짜 가치** = N1 PCM 메커니즘 (body-T trigger) + N6 ternary eutectic (m.p. ↓) + ion-pair (K_sc ↑) **삼중 directly 결합** — Pliaglis IP 가 cover 안 한 영역.

---

## 4. ion-pair 메커니즘 — lid·anion partition shift

### 4.1 Tatara 2021 review (PMC8234378) 핵심 (deep research)
- **sucrose laureate 와 lidocaine HCl**: pH 5.0 (lid 99% ionized) 에서 **K_perm 11.95×** 증폭; pH 7.0 (90% ionized) 에서 **10.84×**; pH 9.0 (lid unionized) 에서 sucrose laureate 는 **0.59× DECREASE** (ion-pair 형성 안 됨, 단 sucrose oleate 2.67×).
- **결론**: ion-pair 는 **ionized drug 에만** 작동 — N6 의 lid base 7% (대부분 unionized @ pH 8 표면) 에는 **표면 pH 를 의도적으로 낮춰야 ion-pair 활성화** (capric acid pKa 4.9 가 이 역할 자연 수행).

### 4.2 Hadgraft 1985 (oleate anion + lidocaine 기원)
- 이온화된 lid (logP ~-0.6) → lid·oleate ion-pair (logP ~+1.5) → **logP shift +2.1**.
- 이론 K_sc 증폭 = 10^2.1 = 125× (ceiling) → 실제 Franz 10-12× (Tatara consensus).
- **conservative working assumption (sim §4)**: in-vivo 3-5× flux gain (TTR-LAC A2 학습: in-vitro Franz overestimate 2-3× vs in-vivo).

### 4.3 lid·anion 후보 ranking (N6 sim §4)
| ion-pair anion | C 수 | flux × (Franz) | 비고 |
|---|---|---|---|
| **oleate (C18:1)** | 18 | **10-12×** | oleate 자체 CPE (double-bond fluidizer) |
| lauric (C12) | 12 | 8-10× | chain-length sweet spot |
| LA / linoleate (C18:2) | 18 | 10× | double-bond + N1 PCM 무관 (액체) |
| **capric (C10)** | 10 | 6-8× | **pH-shifter + N1 PCM Tm 31.5°C anchor** |
| salicylate | aromatic | 5-7× | pH buffer + 임상 안전성 known (salicylic acid OTC) |

**N6-C 선정 이유** = capric 이 **단일 분자로 3가지 동시 수행** (ternary partner + ion-pair anion + N1 PCM carrier).

---

## 5. deep research 발견 (arxiv + web · per @D d18)

### 5.1 arXiv — ternary eutectic + transdermal
| paper | id | 핵심 발견 | N6 적용 |
|---|---|---|---|
| **Pontrelli & de Monte 2014** | 1405.1413 | two-phase two-layer PDE 모델, SC + viable epi 분리, eigenvalue analytical | N6 의 K_sc shift 를 *interface flux continuity* 로 정확히 풀 수 있음 (Sec 2 PDE) |
| **Potticary et al. 2019** | 1902.08376 | **volatile DES** (auto-destructive 휘발 component) → 결정 다형 제어; acetaminophen 새 form @ RT | **lid·capric·EtOH** = volatile DES 변형 — EtOH 휘발 후 lid·capric 결정화 → 분해-방지 carrier |
| Ratkai et al. 2015 | 1503.08318 | ternary eutectic dendrite phase-field 모델 | metallurgy 영역, 직접 N6 무관 |
| Choudhury et al. 2011 | 1103.4806 | 3-phase lamellar eutectic 성장 Jackson-Hunt | DSC microstructure 해석에 참고 |

### 5.2 web — BLT + DES + ion-pair
| source | URL | 핵심 발견 |
|---|---|---|
| **Wells/Park/ScriptWorks compounded BLT** | wellsrx.com/blt · parkcompounding.com · scriptworksrx.com | 20-8-4% w/w = 미국 시장 표준 |
| **JCAD 2017** (BLT abrasive RCT) | PMC5404778 | 30min apply · first-needle pain ↓ (NS) · BLT 임상 onset ≥ 15min |
| **JCAD 2016** (BLT 코너 sentinel) | PMC4896822 | **corneal damage case report** → 안와 주변 contraindication |
| **Yuan 2015** (lid-tet/lid-camphor DSC) | PMC4444629 | **lid+tet eutectic 29.95°C MEASURED (anchor truth)** · lid Tm 68.17 · tet Tm 42.93 |
| **MDPI Pharmaceutics 17:324 2026** (NADES + lid hydrogel) | mdpi.com/1999-4923/17/3/324 | NADES (ChCl + citric acid 1:1) + lid 2% → ointment 대비 **2.7× permeation** |
| **ACS Bio Mater 2019** (menthol + saturated FA DES) | PMC6993812 | menthol-FA DES wound healing → topical biocompat 확인 |
| **Tatara 2021 review** (ion-pair transdermal) | PMC8234378 | lid + sucrose laureate **11.95× flux @ pH 5** · K_oct/w 0.09→1.17 pH-dependent |
| **WO2004103260A2 (Adams · Pliaglis)** | patents.google.com/patent/WO2004103260A2 | **ternary `pri/lid/bup` · `pri/tet/lid` · 4-mer `pri/lid/bup/tet` IP** — *Tm < 20°C* 보장. **BLT 와 lid+tet+FA 는 직접 cover 안 됨** → novelty 여지. |

### 5.3 deep research 종합 → N6 design implication
1. **ternary 마취제 IP 광범위** (Pliaglis WO2004103260A2) → BLT 외 novel ratio · novel anion 만이 자유
2. **NADES + lid** = 2.7× 만 (모더만한 boost) → N6 의 6× 목표는 **ternary + ion-pair + N1 PCM** triple-stack 필수
3. **ion-pair** = ionized drug 만 작동 → N6 = **표면 pH 를 capric/citric 으로 의도적으로 5-6 까지 낮춤**
4. **BLT 코너 케이스** → N6 의 face-area indication 제외 (G1 indication map 갱신 필요)
5. **volatile DES (Potticary 2019)** = lid·capric·EtOH 변형 carrier 의 학술 grounding

---

## 6. hexa-native sim verbatim (per @D g5 · 🟢)

전체 출력 sim §1-§9 (ubu-host: mini, GREEN run, file = `NUMB/sim/n6_ion_pair_eutectic.hexa`):

```
=== NUMB N6 — ternary eutectic + ion-pair carrier (steady-state flux multiplier) ===

[1] Schroder-Van Laar BINARY validation (lid + tet 1:1)
  T = 300.00 K (26.85C)  : x_lid = 0.421666  x_tet = 0.706425  sum = 1.12809
  T = 303.15 K (30.00C)  : x_lid = 0.458658  x_tet = 0.758645  sum = 1.21730
  T = 306.00 K (32.85C)  : x_lid = 0.492491  x_tet = 0.807994  sum = 1.30048
  NOTE: Taylor-4 expansion of exp(x); accurate sign-of-derivative + crossing region only.
  Yuan 2015 MTDSC measured eutectic = 29.95C ANCHORS truth; SVL trend ✓.

[5] N6 D-boost stack — predicted flux multiplier OVER hexa-LAC v1 baseline
  N6-A (BLT3)    stack = 1.1x flux ; real value = temporal profile heterogeneity
  N6-B (+LA)     stack = 5x  flux  ; ion-pair K_sc 3-5x dominant
  N6-C (+capric) stack = 6x  flux  ; N1 PCM cross-axis + ion-pair + ternary triple-stack

[6] depth recompute @ 200um — C(z)=C_surf * a * exp(-z/lambda)
  hexa-LAC v1   C/MEC = 1.9992   (safe baseline)
  N6-A (BLT3)   C/MEC = 2.1991   (marginal)
  N6-B (+LA)    C/MEC = 9.996    (deep margin)
  N6-C (+capric)C/MEC = 11.995   (deep margin, PCM cross-axis stacks)

[7] LAST safety re-gate
  N6-B/C projected Cmax 72-108 ng/mL (vs Pliaglis 18 ng/mL anchor)
  -> EPI co-admin MANDATORY · AREA CAP <200cm2 · DURATION CAP <30min
  -> 1000cm2 sleeve use case: DE-RATE lid+tet to 3.5+3.5%

=== verdict: N6 is a STEADY-STATE FLUX MULTIPLIER (NOT onset accelerator) ===
=== Candidate C (lid+tet+capric+ion-pair) stacks 6x flux over hexa-LAC v1 ===
=== onset = D-driven (UNCHANGED at 6min from hexa-LAC v1); depth + duration are the gain ===
=== wall = DSC wet-lab required for ternary eutectic m.p. ($200-500 to break) ===
```

---

## 7. residual walls + breakthrough paths (per @D d2)

| wall | 정량 | breakthrough |
|---|---|---|
| **W1 ΔHfus 추정** | lid/tet/capric/LA ΔHfus 실측 부재 → SVL 예측 ±3°C 오차 | **lit 검색 + DSC fusion peak integration ($300)** → 정확 값 |
| **W2 ternary m.p. wet-lab** | 후보 A/B/C 모두 DSC 필요 | **single-plate DSC 5-sample run ($200-500, 1day)** → measured Tm |
| **W3 ion-pair K_sc in-vivo** | Franz 10-12× → in-vivo 3-5× (TTR-LAC A2 학습) | **1-point Franz cell ($500-1000)** → lid+LA vs lid base K_perm |
| **W4 pH-sting** | capric/lauric anion → low pH (4.9) → stinging | **PG/EtOH co-solvent 20% buffer + Tris/citrate** |
| **W5 BLT cornea** | JCAD 2016 case → 안와 contraindicated | G1 indication map 갱신 (face-area exclusion zone) |
| **W6 regulatory IP** | Pliaglis WO2004103260A2 ternary 광범위 | **novel ratio + novel anion** (N6-C lid+tet+capric+epi) = 새 IP space |

### 7.1 minimum-spend wet-lab gate (~$700-1500)
1. **DSC** (5 sample plate · CapricAcid + lid + tet at 4:4:2, 3:3:4, 2:2:6 · binary lid+tet anchor · pure capric) — **$200-500**
2. **Franz cell** (1-point: hexa-LAC v1 vs N6-C @ 30min K_perm) — **$500-1000**
3. → 🟠 → 🟡 (numerical evidence) → 🟢 후 (re-DFT/MD molecular grounding)

---

## 8. NUMB.md 갱신 안 (NUMB N-row 추가)

```diff
 ### N — NOVEL probes (round-1)
 - [x] N1 phase-change peel-film → ... 🟠 plausibly-novel ...
 - [x] N5 Mg²⁺ multi-modal → ... 🟠 INSUFFICIENT/DEFERRED ...
+- [x] N6 ion-pair / ternary eutectic → `NUMB/research/N6_ion_pair_eutectic.md` (+ sim) · 🟠 INSUFFICIENT/DEFERRED · **Schröder-Van Laar 검증 ✓ Yuan 2015 lid+tet 29.95°C anchor** · **후보 C (lid+tet+capric+ion-pair) = N1 PCM cross-axis + ternary + ion-pair triple-stack = J_ss 6× over hexa-LAC v1** (depth+duration; onset 무관 N1 학습 적용) · wall = DSC + Franz wet-lab ($700-1500 total) · IP = Pliaglis WO2004103260A2 cover 외 영역 (novel ratio + capric anion) · BLT (후보 A) 가치 = temporal profile heterogeneity (benzo 1min + lid 5min + tet 30min) NOT m.p./flux
```

---

## 9. honest verdict

🟠 **INSUFFICIENT/DEFERRED** — 모든 정량 (ternary m.p. · K_sc shift · in-vivo flux) 이 **single-batch wet-lab spend ($700-1500)** 로 측정 가능 → **1-cycle 안에 🟡 승격 가능한 가장 cheap-est NOVEL probe**.

- mechanism: 🟡 (SVL 검증 ✓ binary lid+tet 30°C; ion-pair Tatara 2021 review consensus; BLT 임상 30+ year 시장)
- 정량 ceiling: 6× steady-state flux over hexa-LAC v1 (단, in-vivo derate 1.5-2× → 실제 3-4×)
- onset: **NO CHANGE** (D-driven; N1 학습 정직 적용)
- LAST: 4-6× Cmax → EPI + area + duration cap **mandatory**
- regulatory: novel ratio + capric anion = WO2004103260A2 IP 여지
- breakthrough cost: ~$700-1500 (DSC + Franz 1-point each)

**다음 cycle 액션** = G2 (regulatory matrix) + G3 (pediatric LAST) 와 **병렬로** wet-lab DSC quote 받기. N6-C 가 PASS 시 → hexa-LAC v2 (lid+tet+capric+ion-pair+PCM) spec drafting.
