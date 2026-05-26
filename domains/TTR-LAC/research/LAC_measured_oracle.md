# TTR-LAC — measured-oracle: 5-criteria PASS + tiered wet-lab study design (정직 deferral)

> milestone: TTR-LAC.md **LAC measured-oracle** → absorbed=true gate
> base: A1(SC lag-time) · A2+A3(D-boost·depth) · A4(LAST envelope) · A5(MD→Franz→in-vivo retention) · B1(세션 모델) · B2(PFD frost-clear) · B3(토픽 r↓) · B4(통합 프로토콜) · V1(38 claim · LB-6 = β_topical=0.50 rhein)
> 정직 원칙 (@D d1/d5/d6): 본 문서는 **wet-lab / 임상 의존 단계의 설계**다. 결과 미주장. NON-wet-lab 단계(A1-A5·B1-B4·V1·V2)는 완료로 driven; **measured-oracle PASS 까지 absorbed=false 유지**. 🟠 DEFERRED 명시.
> sibling: `TTR-ORAL/research/M8_M9_oracle_wetlab.md` (pattern source)

---

## TL;DR

V2 가 만든 52 closed-form identity 와 V1 38 claim 의 8 load-bearing assumption (LB-1..LB-8)을 **5-축 falsifiable oracle (O1-O5)** 로 환산. 각 O는 단일 측정으로 PASS/FAIL 갈리며 FAIL 시 어느 closed-form 가정이 깨졌는지 일대일 매핑. tier-A/B/C/D/E 5단계 study ladder (ex-vivo → 인-vitro phantom → animal → human Phase 0/1 → human Phase 2)로 LB-6(β_topical=0.50)·LB-3(D-boost retention)·LB-7(기포 광학) 순차 해소. 현 상태 = **🟠 DEFERRED** (외부 wet-lab/임상 의존) · absorbed=false.

핵심 결정 measurable = **Tier A Franz-cell ER 측정** — `hexa-LAC v1` (lid7+tet7 eutectic + LA5 + EtOH20 + epi 1:200k) 의 *in-vitro 인간 SC* D-boost 실측이 LB-3 (A2+A3 의 D-boost 20× 가정) 과 LB-6 (rhein β_topical) 을 *동일 ex-vivo 장치*로 동시 해소. cost ~$15-30k · 4-8주 · live-animal 無.

---

## §0 무엇이 deferred 이고 무엇이 닫혔나 (정직 경계)

```
   ┌─ NON-wet-lab (닫힘 · @D d1 driven to completion) ──────────────────────────┐
   │  A1  SC lag-time t_lag=h²/6D  ·  D=1e-10·h=10μm → onset 56min       🔵/🟢 │
   │  A2+A3  D-boost 20× → onset 3-11min · λ=60μm with epi · MEC≈0.5%   🟢    │
   │  A4  LAST envelope (Pliaglis-anchored · 273× margin @100cm²/30m)   🟢    │
   │  A5  MD→Franz→in-vivo retention waterfall (5-10× 보수 → P=33-67%)   🟢    │
   │  B1  c_pass·n geometric · PFD pivotal 3.7p → N=2.17 · fold 2.64×    🟢    │
   │  B2  μ_s_frost=163 · T@200μm 28%→99% (PFD 회복) · knee n*=3-4       🟢    │
   │  B3  β sweep · JOINT B2+B3 (β=0.50 → N=2.97) · carbon floor 1.5세션 🟢    │
   │  B4  5-stage 83min chair-time · double-coat β=0.615 · 3.8× honest   🟢    │
   │  V1  38 claim · 8 LB · LB-6 β_topical=0.50 = weakest link            ✓    │
   │  V2  52 closed-form identity (Fick·Mie·Beer-Lambert·기하급수 등)    🔵    │
   └──────────────────────────────────────────────────────────────────────────┘
                              │  closed-form 예측을 falsifiable measurement 로 환산 (이 문서)
                              ▼
   ┌─ wet-lab / human-clinical (이 문서가 설계만) ─── 🟠 DEFERRED ─────────────┐
   │  Tier A  Franz-cell ex-vivo (D-boost · β_topical · ER)                    │
   │  Tier B  in-vitro phantom (laser+tattoo collagen + PFD multipass)         │
   │  Tier C  animal (rat/mini-pig dermal pigment + LAST plasma)               │
   │  Tier D  human Phase 0/1 (EMLA+PFD off-label · IRB only)                  │
   │  Tier E  human Phase 2 (full hexa-LAC v1 w/ rhein · 505(b)(2))            │
   │  oracle  O1-O5 measured PASS  →  absorbed=true                            │
   └──────────────────────────────────────────────────────────────────────────┘
```

정직 명제: A1-B4 가 닫은 것은 *모델 self-consistency 와 ratio*. 절대값 8건 (V1 LB-1..LB-8) 중 **LB-3(D-boost in-vivo retention)·LB-4(λ 절대값)·LB-6(β_topical 0.50)·LB-7(기포 a·N)** 4건이 measured-only. 이것이 oracle 의 falsifiable gate.

---

## §1 PASS criteria O1-O5 — closed-form prediction 묶음

@D d5: absorbed=true ⇔ 모든 non-wet-lab gate PASS. LAC oral track 결정 gate 는 본질적으로 measured → oracle = measured PASS. 각 O는 V2 closed-form identity 에 묶여 거짓화 가능.

### O1 — 마취 onset (LB-3 의 measured proxy)

| | 측정량 | PASS 기준 | 묶인 V2 identity | FAIL 시 깨지는 LB |
|---|---|---|---|---|
| primary | 진피 자유신경말단(150-200μm) 차단 onset 분 (pin-prick / VAS reduction ≥50%) | ≥80% subjects ≤20 min · 또는 relaxed: ≥80% ≤30 min (per A5 thin/mid/thick-SC 분포) | `t_lag = h²/(6·D_eff)` · `onset ≈ 2·t_lag` (V2 §1 Fick) | LB-3 (D-boost in-vivo retention) · LB-4 (λ depth decay) |

```
   honest tier:
   strict   ≤20min · ≥80%  ⟺ D-boost in-vivo retention ≥ 50% (MD 42× → in-vivo ≥21×)
   relaxed  ≤30min · ≥80%  ⟺ D-boost in-vivo retention ≥ 25% (보수 5-10× — A5 중앙치)
   FAIL → LB-3 falsified → A5 polynomial mitigation (pre-dose 30→40min / CPE 적층 / target 완화)
```

### O2 — 마취 depth (LB-4 의 measured proxy)

| | 측정량 | PASS 기준 | 묶인 V2 identity | FAIL 시 깨지는 LB |
|---|---|---|---|---|
| primary | 진피 자유신경말단 plexus (z=150-200μm) 에서 분석 anesthesia (pin-prick + thermal QST) | pain score reduction ≥70% (VAS 0-10 · pre vs post) at 150-200μm depth 모방 stimuli | `C(z)/C_surf = exp(−z/λ)` · `MEC=0.5%` lidocaine | LB-4 (λ=40-60μm absolute) |
| secondary | Q-switched laser 펄스 통증 score (실제 시술 stimulus) | ≥70% reduction vs no-anesthesia control | (동) | (동) |

```
   strict   ≥70% pain reduction · 진피 plexus  ⟺  λ≥60μm with epi (C(200μm)≈0.5%≈MEC)
   relaxed  ≥50% pain reduction              ⟺  λ≈40μm baseline (C(200μm)=0.67%·analgesia-only)
   FAIL → LB-4 falsified → epi 1:200k 강제 + h-thin 환자만 권장 (cheek-class)
```

### O3 — LAST safety (LB-9 = A4 의 Pliaglis k_eff calibration)

| | 측정량 | PASS 기준 | 묶인 V2 identity | FAIL 시 깨지는 LB |
|---|---|---|---|---|
| primary | lidocaine plasma C_max (LC-MS/MS · 30/60/90/120 min post-apply) | C_max < 2 μg/mL (sub-CNS-warn = 2.5× safety floor) @ typical A=100 cm² · 30 min · +epi · ER 3x central | `C_max = k·Dose_mg` · `Dose=m·A·c_lido` | LB-9 (k_eff Pliaglis-eq) · ER_extra in-vivo |
| primary | LAST clinical signs (slurred speech · tinnitus · tongue tingling · tremor) | 0/N events · 라벨 envelope (≤400 cm² · 30 min · +epi) 내 | (동) | (동) |
| secondary | methemoglobin (prilo 함유 시) | <3% baseline (prilo 단독 시) · hexa-LAC v1 = no prilo → moot | — | — |

```
   strict   C_max < 2 μg/mL · 0 LAST event @ A≤400cm²  ⟺  Pliaglis-eq k_eff (273× model margin)
   FAIL → LB-9 falsified → A_max 재역산 (5+5% de-rate · split-dose · 면적 cap)
```

### O4 — 세션 reduction (LB-5 PFD 3.7p · LB-6 β_topical · LB-8 carbon floor)

| | 측정량 | PASS 기준 | 묶인 V2 identity | FAIL 시 깨지는 LB |
|---|---|---|---|---|
| primary | 90% clearance 까지 세션 수 N_session (vs SoC laser-alone matched-cohort) | ≥2× reduction (= N ≤2.87 vs SoC 5.74) · target ≥3× (N ≤1.91) per B4 model floor 1.5 | `N = log(0.1)/log(1−c_session)` · `c_session = 1−(1−c_pass)^n` · `c_pass = φ_rel·(1−r)` (V2 §3 multipass) · `r(β) = (1−β)·r₀` (V2 §4 recapture) | LB-5 (3.7p) · LB-6 (β=0.50) · LB-8 (carbon 25% floor) |
| secondary | 90% clearance 도달 월수 (7주 간격) | ≤4.5 mo (=2× SoC 9.2mo cut) · target ≤3 mo (~3× cut · honest carbon floor) | (동) | (동) |

```
   minimum  N ≤ 2.87  · ≥2× cut vs SoC          ⟺  PFD 3.7p (LB-5) + β_topical ≥ 0.30 (relaxed)
   target   N ≤ 1.91  · ≥3× cut vs SoC          ⟺  PFD 3.7p + β_topical ≥ 0.50 (rhein)
   ceiling  N ≤ 1.50  · ≥3.8× cut (B4 honest)   ⟺  PFD 3.7p + β=0.615 double-coat (B4 full)
   FAIL → LB-6 falsified (β_topical < 0.30) → B3 lever 제거 · PFD-only fallback (still 2.64× cut)
```

### O5 — cosmetic clearance (실제 환자 visual + objective)

| | 측정량 | PASS 기준 | 묶인 V2 identity | FAIL 시 깨지는 LB |
|---|---|---|---|---|
| primary | objective pigment fade (digital colorimetry · 4-grade Tattoo Clearance Scale TCS · pre vs 6 mo post) | ≥90% fade · ≥60% subjects (PFD pivotal anchor: Biesman 86.6% 6-8세션 vs B4 model 1.5세션) | `clearance = 1 − (1−c_session)` · carbon floor 75% absolute | LB-8 (carbon floor) · LB-1 (φ_rel=0.83) |
| secondary | patient satisfaction VAS · cosmetic acceptability | ≥80% subjects rate "satisfied/very-satisfied" · timeline shortened vs SoC matched | (동) | (동) |
| safety | scarring · pigmentation change · keloid | <5% incidence (SoC ~10-15%) | — | LB-7 (기포 광학 fluence) |

```
   strict   ≥90% fade · ≥60% subjects @ 6mo  ⟺  PFD+β achieves model floor 1.5세션
   relaxed  ≥75% fade · ≥50% subjects @ 12mo ⟺  carbon-25%-floor honest framing
   FAIL → LB-8 confirmed (carbon floor < 75%) → marketing language re-calibrate (no "full erase")
```

### oracle 통합 (PASS 부등식)

```
   measured-oracle PASS  ⟺  O1 ∧ O2 ∧ O3 ∧ O4 ∧ O5
   ─────────────────────────────────────────────────────────────────
   PASS  → absorbed=true  (마취 onset + depth + LAST safety + 세션 cut + cosmetic 5/5)
   FAIL  → absorbed=false 유지 + 어느 oracle 이 깨졌나 = 어느 V2 identity 가 falsified
          (예: O4 FAIL → LB-6 β_topical<0.30 → B3 lever 무력 → PFD-only 2.64× re-target)
```

---

## §2 Tiered study plan (Tier A → E)

```
   TIER LADDER (mirror TTR-ORAL M8/M9 staging)
   ─────────────────────────────────────────────────────────────────────
   Tier A  ex-vivo Franz-cell                 │ closes A5 retention gap + LB-3
   ▼                                          │ (D-boost in-vivo · β_topical 1차)
   Tier B  in-vitro phantom                   │ closes B2 frost optics + B3 r↓
   ▼                                          │ (LB-5 PFD 3.7p · LB-7 기포)
   Tier C  animal (rat → mini-pig)            │ closes A4 LAST in-vivo + LB-6 in-vivo
   ▼                                          │ (LAST plasma · β rat dermal pigment)
   Tier D  human Phase 0/1 (off-label)        │ closes O1-O3 in-clinic + B4 chair-time
   ▼                                          │ (EMLA+PFD off-label · IRB only)
   Tier E  human Phase 2 (505(b)(2))          │ closes O1-O5 ALL · rhein full
                                              │ (1-3yr · NDA-light path)
```

### Tier A — ex-vivo Franz-cell (closes A5 retention · LB-3 1차)

| 항목 | 사양 |
|---|---|
| **목표** | hexa-LAC v1 D-boost in-vitro 인간 SC 실측 · A5 폭포 (MD 42× → Franz 10-15×) 확정 · 동시에 rhein β topical 의 SR-A binding 정량 |
| **기재** | Franz-type vertical diffusion cell (PermeGear · 9-cell array) · 인간 cadaver 피부 (≥3 donors · dermatomed 400μm) 또는 돼지 ear skin (대안) |
| **arms** | (1) saline control · (2) Pliaglis (lid7+tet7) baseline · (3) hexa-LAC v1 (full CPE stack) · (4) hexa-LAC v1 + epi 1:200k |
| **readout** | (a) lidocaine flux (LC-MS/MS · receptor compartment 24h) → D_eff = h²/(6·t_lag) · D-boost ratio · (b) rhein flux at 5-10min(pre)·30min(post) · (c) post-laser ex-vivo SR-A binding (radio-labelled rhein on macrophage culture · IC50) |
| **N** | 3 donors × 3 sites × 4 arms × 3 replicates = **108 cells** (~$15-30k cost, 4-8주) |
| **stat** | one-way ANOVA + Tukey HSD · log-flux primary endpoint · power 0.80 to detect D-boost ratio ≥2× at α=0.05 |
| **closes** | LB-3 (D-boost) → 🟠 → 🟡 · LB-6 (β_topical) 1차 grounding → 🟠 → 🟡 |
| **decisive** | ⭐ — *single Tier-A 결과로 LB-3+LB-6 동시 해소*, A2+A3 onset 가정과 B3 β=0.50 의 in-vitro 정합성 확정 |

### Tier B — in-vitro phantom (closes B2 frost optics · LB-5 · LB-7)

| 항목 | 사양 |
|---|---|
| **목표** | laser-tattoo phantom (collagen gel + India ink/carbon pigment) 에서 frost-PFD-multipass 광학 정량 · B2 μ_s_frost=163 cm⁻¹ · T@200μm 28%→99% 회복 in-vitro 검증 |
| **기재** | 3-layer phantom — (epidermis: PDMS film 50μm · dermis: collagen-1 gel 1mm w/ India ink 0.5 mg/mL · subQ: agar 2mm) · Q-switched Nd:YAG 1064nm laser · integrating sphere fluence meter |
| **arms** | (1) laser-only · (2) laser + PFD patch (DESCRIBE) · (3) laser + PFD + sub-β recapture mock (silica-coated India ink as "released pigment") |
| **readout** | (a) μ_s_frost (Monte Carlo MCML fit · pre/post-pass 산란 측정) · (b) ink clearance % per pass (image J pixel density · 1-7 passes) · (c) sub-β mock: silica-pigment uptake by macrophage-like THP-1 culture ± rhein |
| **N** | 4 phantom batches × 3 arms × 7 pass-levels × 3 replicates = 252 measurements (~$8-15k, 3-6주) |
| **stat** | dose-response knee fit (Hill function · n*≈3-4 expected per B2 §7[C]) · μ_s vs Mie theory chi-squared GoF |
| **closes** | LB-5 (PFD 3.7p knee) → 🟠 → 🟢 · LB-7 (기포 a·N) → 🟡 → 🟢 · B3 SR-A binding (rhein) → 🟠 → 🟡 |
| **gates** | A FAIL → B 진행 의미 ↓ (D-boost 가 0 이면 onset PASS 불가); B 독립 진행 가능 (광학은 마취제와 무관) |

### Tier C — animal (rat → mini-pig · closes A4 LAST in-vivo · LB-6 in-vivo)

| 항목 | 사양 |
|---|---|
| **목표** | (i) hexa-LAC v1 도포 후 LAST plasma kinetics (Pliaglis-eq k_eff in-vivo) · (ii) rat tail tattoo (Baranska 모델) 에서 β_topical in-vivo · (iii) Q-switched laser session 모방 + 잉크 fade timeline |
| **arms (C1 LAST rat)** | n=6/group × 4 groups = 24 rats — (a) Pliaglis · (b) hexa-LAC v1 -epi · (c) hexa-LAC v1 +epi · (d) vehicle · 30 min apply 200 cm²-eq · plasma sampling 0/15/30/60/120/240 min |
| **arms (C2 tattoo rat)** | n=8/group × 3 groups = 24 rats — (a) laser only · (b) laser + PFD · (c) laser + PFD + rhein topical (β_post) · 8주간 1 session · 12주 fade follow-up + 2-photon intravital |
| **arms (C3 mini-pig)** | n=4-6 mini-pigs (Göttingen · 인간 skin 가장 유사) — full hexa-LAC v1 + 5-stage B4 protocol · LAST + clearance 동시 |
| **readout** | (a) plasma C_max (LC-MS/MS · LAST clinical signs · ECG · CBC) · (b) tattoo clearance % intravital + endpoint histology (HMB-45 · F4/80 Mφ) · (c) dLN ink burden (ICP-MS metal + 색소 면적) |
| **N** | total ~52 rodents + 4-6 pigs · ~$80-150k · 4-6 months · IACUC required |
| **closes** | LB-6 (β_topical in-vivo) → 🟡 → 🟢 · LB-9 (LAST k_eff in-vivo) → 🟠 → 🟢 · A1 onset in-vivo (rat sensory threshold proxy) → 🟢 → 🟡 (translation guard) |
| **gates** | A+B PASS → C 진행 · A FAIL → C1 LAST 만 (formulation 안전 확인) |

### Tier D — human Phase 0/1 (EMLA+PFD off-label · IRB only · NO new IND)

| 항목 | 사양 |
|---|---|
| **목표** | EMLA + DESCRIBE PFD patch 의 **off-label combination** 임상 적용 — 둘 다 FDA-approved (EMLA Rx 1995 · DESCRIBE 510(k) 2015) 이므로 IND 不要, IRB-approved investigator-initiated study 로 즉시 가능 · O1/O3/O4-relaxed 측정 |
| **arms** | (1) EMLA 60min + Q-switched laser (SoC) · (2) EMLA 60min + DESCRIBE PFD + Q-switched laser (multi-pass n=3.7 per Biesman) · (3) LMX-4 30min + DESCRIBE PFD (occlusion-free 변형) |
| **cohort** | n=30/arm = 90 subjects (split-tattoo within-subject design · 좌/우 무작위) · 모든 subjects 기존 타투 보유 + 제거 desire |
| **readout** | (a) onset (VAS · pin-prick · 5/10/20/30 min) → O1 · (b) intra-procedure pain VAS → O2 · (c) plasma lido C_max (1 timepoint · 30 min) → O3 · (d) 6 mo TCS clearance · 세션 수 → O4 |
| **stat** | within-subject split-tattoo · paired t-test or Wilcoxon · non-inferiority margin Δ=10% for safety (one-sided 0.025) · superiority for clearance (one-sided 0.05) |
| **timeline** | 4-6 months recruitment · 12 months follow-up · ~$200-400k IIT cost |
| **closes** | O1-relaxed (≤30 min) · O3 (LAST in-clinic) · O4-minimum (≥2× cut) · B4 chair-time 83min 실측 |
| **gates** | C PASS (formulation safety) → D 진행 · D PASS → Tier E pivotal entry rationale |

### Tier E — human Phase 2 (full hexa-LAC v1 with rhein · 505(b)(2) · 1-3 yr)

| 항목 | 사양 |
|---|---|
| **목표** | full B4 protocol (EMLA 60→wipe→rhein pre β=0.30→PFD→laser n=3.7→rhein post β=0.45) · oracle O1-O5 strict PASS · 505(b)(2) NDA-light path (diacerein 경구 EU 1985 prior approval reliance) |
| **arms** | (1) full hexa-LAC v1 · (2) hexa-LAC v1 -rhein (B3 lever 제외 · isolation) · (3) SoC (EMLA + laser alone) |
| **cohort** | n=60/arm = 180 subjects · multi-center (3-5 sites) · stratified by Fitzpatrick I-VI · tattoo carbon-dominant ink (전문잉크 별도 stratum) |
| **endpoints** | primary = 90% TCS clearance @ 6 mo (O5) · secondary = session count to 90% (O4 strict ≥3×) · safety = LAST events + scarring (O3 strict) + onset VAS (O1 strict ≤20 min ≥80%) |
| **stat** | superiority for efficacy (O4/O5 · one-sided α=0.025 · power 0.90 detect 1.5-session cut) · non-inferiority for safety (Δ=5% scarring · one-sided 0.025) |
| **timeline** | 12 month enrollment + 12 month follow-up + 6 month analysis = ~30 months · ~$10-25M · pre-IND meeting → IND → Phase 2 |
| **closes** | O1-O5 strict PASS → absorbed=true · 505(b)(2) filing 가능 |
| **gates** | D PASS + Tier-C mini-pig in-vivo β_topical PASS → E 진입 |

---

## §3 Cohort + endpoints (study-level stat plan)

| Tier | sample size | primary endpoint | secondary | dropout 가정 | stat 설계 |
|---|---:|---|---|---|---|
| A Franz | 108 cells (3 donors) | D-boost ratio (log-flux) | β SR-A binding IC50 · ER per arm | n/a (ex-vivo) | one-way ANOVA + Tukey · 검정력 0.80 to detect ≥2× D-boost @ α=0.05 |
| B phantom | 252 measurements | μ_s_frost (cm⁻¹) · clearance %/pass | knee n* (Hill fit) | n/a | dose-response Hill · GoF chi-squared vs Mie theory |
| C-rat LAST | 24 rats | plasma C_max (ng/mL) | LAST clinical score · CBC | ≤10% | repeated-measures ANOVA · Bonferroni-adjusted |
| C-rat tattoo | 24 rats | intravital clearance %@8wk | dLN ink burden · Mφ density | ≤15% | mixed-effects (cohort × time) · within-subject |
| C-pig | 4-6 pigs | clearance% + C_max integrated | full B4 chair-time | ≤20% | descriptive (small-n PoC) |
| D human Ph0/1 | 90 (split-tat) | within-subject Δ clearance @6mo · onset VAS | C_max · 세션수 · chair-time | ≤20% (typical aesthetic) | paired t / Wilcoxon · split-tattoo within-subject (variance ↓2-3×) |
| E human Ph2 | 180 (3×60) | 90% TCS clearance @6mo (one-sided superiority) | session count · onset reliability · scarring | ≤25% (cosmetic Ph2) | mixed-effects · ITT + per-protocol · one-sided α=0.025 · power 0.90 |

### 핵심 stat 결정

- **one-sided non-inferiority for safety** (O3 LAST · O5 scarring) — Δ_NI = 5-10% absolute · α=0.025 one-sided
- **one-sided superiority for efficacy** (O4 cut · O5 fade) — α=0.025-0.05 one-sided · power 0.90 detect 1.5-session difference (B4 honest floor)
- **stratification** Fitzpatrick I-VI + tattoo ink class (carbon-dominant vs 전문잉크) — V1 LB-8 carbon floor 정직 control

---

## §4 Decisive measurables — 가장 큰 uncertainty 붕괴 실험

V1 §8 verdict: load-bearing 가장 큰 = LB-6 (β_topical=0.50 rhein), 다음 = LB-3 (D-boost retention) · LB-4 (λ 절대값) · LB-5 (PFD 3.7p single source).

### 🥇 Tier A Franz-cell ER measurement (단일 가장 큰 collapse)

```
   ⭐ DECISIVE EXPERIMENT (이거 하나가 LB-3 + LB-6 + A5 retention 동시 해소)

   Franz-type vertical diffusion cell · 인간 cadaver SC (3 donors)
   ┌──────────────────────────────────────────────────────────────┐
   │  donor chamber: hexa-LAC v1 (lid7+tet7+LA5+EtOH20+epi)        │
   │       ↓                                                       │
   │  human SC (400μm dermatomed)                                  │
   │       ↓                                                       │
   │  receptor chamber: PBS · sample 0/0.5/1/2/4/8/24 h            │
   └──────────────────────────────────────────────────────────────┘
   measurement: lidocaine flux (LC-MS/MS) · steady-state J_ss
   derive:  D_eff = h²/(6·t_lag)
            D-boost = D_eff / D_eff(Pliaglis-baseline)
   PASS:    D-boost ≥ 10× (A5 보수 mid-range)  →  P(onset≤20min) ≥67%
   FAIL:    D-boost < 5×                       →  target ≤30min · pre-dose 30min
   bonus:   동일 setup 에서 rhein flux 측정 + IC50 SR-A binding →  β_topical 1차 grounding

   cost ~$15-30k · 4-8주 · NO live-animal · NO IRB · NO IND
   ──────────────────────────────────────────────────────────────────
   leverage:  단일 실험으로 LB-3 (D-boost) + LB-6 (β rhein) 동시 해소
              →  V1 38 claim 중 6 (LB-3·LB-6·LB-4 indirect·A1.12·B3.2·B3.7) 🟠→🟢
```

### 🥈 Tier B phantom multipass + sub-β recapture mock

- B2 μ_s_frost=163 cm⁻¹ 검증 (LB-7 기포 a·N) · n*=3-4 knee 실측 (LB-5 Biesman 1건 single-source cross-check)
- silica-coated India ink 의 macrophage culture re-uptake + rhein blocking — *in-vitro β_topical* 측정 (Tier A 와 cross-validate)
- cost ~$8-15k · 3-6주 · 광학 + cell culture · NO live-animal

### 🥉 Tier C mini-pig full-protocol PoC

- Göttingen mini-pig (인간 피부 가장 유사 · Pliaglis pivotal animal model 동일) · 4-6 마리
- B4 5-stage protocol 그대로 + LAST plasma + 12wk fade follow-up
- *real* in-vivo β_topical (rat tail tattoo + intravital 2-photon, Baranska 모델 mini-pig 변형)
- cost ~$80-150k · 6 months · IACUC required · LB-6 (β_topical in-vivo) 최종 grounding

```
   uncertainty collapse cascade
   ───────────────────────────────────────────────────
   Tier A  (Franz)   →  LB-3 + LB-6 + LB-4 indirect   →  6 claim 🟠→🟢
   Tier B  (phantom) →  LB-5 + LB-7                    →  4 claim 🟡→🟢
   Tier C  (pig)     →  LB-6 in-vivo + LB-9            →  3 claim 🟡→🟢
   Tier D  (Ph 0/1)  →  O1-relaxed + O3 + O4-min       →  oracle 3/5 PASS
   Tier E  (Ph 2)    →  O1-O5 strict                   →  absorbed=true
   ───────────────────────────────────────────────────
   total collapse: 13 claim 🟠/🟡 → 🟢/🔵 · LB 8건 중 7건 해소 (LB-8 carbon floor 만 모델적 강제 유지)
```

---

## §5 honest deferral + tier ledger

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | Tier A/B/C/D/E 설계가 V1 LB-1..LB-9 와 O1-O5 에 일대일 매핑 | 🔵 SUPPORTED-FORMAL | V1 §7 LB 표 + V2 closed-form identity 직접 대응 |
| 2 | O1-O5 PASS ⟺ absorbed=true (부등식 구조) | 🔵 SUPPORTED-FORMAL | @D d5 gate 정의 + V2 §1-§4 closed-form 묶음 |
| 3 | Tier A 단일 실험이 LB-3+LB-6 동시 해소 (decisive collapse) | 🔵 SUPPORTED-FORMAL | Franz-cell setup geometry + LC-MS/MS multi-analyte |
| 4 | Tier A Franz D-boost · β_topical 절대값 | 🟠 DEFERRED | ex-vivo wet-lab 미수행 (외부 의존 · $15-30k) |
| 5 | Tier B-E 모든 측정 절대값 | 🟠 DEFERRED | wet-lab/animal/human 미수행 |
| 6 | O1-O5 PASS 여부 | 🟠 DEFERRED | measured-oracle PASS 전까지 false 유지 |
| 7 | absorbed=true 여부 | 🟠 DEFERRED | @D d5 — measured PASS 까지 false 유지 |

```
   tier 분포:  🔵 3  ·  🟢 0  ·  🟡 0  ·  🟠 4  ·  🔴 0
   ────────────────────────────────────────────────────
   설계·매핑·oracle 부등식 = 닫힘 (🔵).
   모든 측정 절대값 + absorbed flip = 🟠 DEFERRED.
   → @D d6 positive 강제 안 함. "설계는 first-principles 상 닫히고
      falsifiable 하나, 측정은 외부 wet-lab + 임상 의존으로 미수행 — absorbed=false 유지."
```

---

## §6 정직 결론 + next (@D d1/d2/d5/d6)

- **NON-wet-lab 완료로 driven** (@D d1): A1-A5 · B1-B4 · V1 · V2 + 본 문서 oracle 환산까지 — 측정 직전 단계까지 모두 닫힘. 38 claim · 52 identity · 5 oracle · 5 tier 가 first-principles + closed-form 의 끝.
- **measured-oracle 5-조건 falsifiable**: O1 (onset ≤20-30min · ≥80%) · O2 (depth ≥70% pain cut at 진피 plexus) · O3 (C_max <2 μg/mL · 0 LAST event) · O4 (N≤2.87 ≥2× SoC cut) · O5 (≥90% fade @6mo ≥60% subjects). 각각 V2 closed-form 에 묶여 FAIL 시 어느 LB가 깨졌는지 직결.
- **absorbed=false 유지** (@D d5): Tier A-E 미수행. 본 문서는 *설계와 판정규칙* 만 제공.
- **닫힌 부정 아님** (@D d2): 각 FAIL 마다 breakthrough loop 명시 — O1 strict FAIL→relaxed (≤30min) 또는 thin-SC 한정 · O4 FAIL→PFD-only 2.64× fallback · O5 FAIL→carbon-floor 정직 marketing re-calibrate.
- next:
  - 즉시: V3 numerical cross-check (PBPK SC permeability · MCML photon transport) — A5/B2 sim 의 2nd-method 정합 확인 · local CPU 천장 안 (@D d7)
  - 단기: Tier A Franz-cell IIT 파트너 (academic dermatology lab) 컨택 — $15-30k IIT funding · NO IND · 4-8주
  - 중기: Tier B phantom in-house build (collagen + India ink + Q-Nd:YAG rental) — $8-15k · 3-6주
  - 장기: Tier C-E 외부 GLP/IACUC + IRB + IND (3-30개월 누적) — @D d1 driven 가능 영역 아님 (외부 의존 honest)

## Cross-reference

- A1/A2+A3/A4/A5 closed-form: `TTR-LAC/research/{A1,A2_A3,A4,A5}*.md`
- B1/B2/B3/B4 closed-form + integrated: `TTR-LAC/research/{B1,B2,B3,B4}*.md`
- V1 claim inventory (38 claim · LB-1..LB-9): `TTR-LAC/verify/V1_claim_inventory.md`
- V2 closed-form identities (52 identity): `TTR-LAC/verify/V2_formal_identities.md`
- TTR-ORAL M8/M9 oracle pattern source: `TTR-ORAL/research/M8_M9_oracle_wetlab.md`
- @D d1: NON-wet-lab 단계 완료로 driven · @D d2: 모든 FAIL 에 돌파 루프 · @D d5: absorbed=false 유지 (measured PASS 전) · @D d6: oracle falsifiable · positive 강제 없음 · first-principles (V2 closed-form 묶음) 만 사용

## Sources (consolidated · LAC tier-ladder)

### regulatory + 임상 anchor
- **Pliaglis FDA label 021717s010** — lid7+tet7 · 220 ng/mL @ 400 cm²/120 min · area-prop · time-linear ≤60 min
- **EMLA FDA label** — lid2.5+prilo2.5 · ≤1300 cm² adult · ≤200 cm² pediatric · metHb warning
- **DESCRIBE PFD patch 510(k) Merz 2015·2020** — Q-switched 532/694/755/1064 · pico cleared
- **diacerein EU 경구 1985** (Artrodar/Artrolyt EU 골관절염) — rhein 505(b)(2) reliance reference

### wet-lab / 임상 trial precedent
- **Biesman 2017** PFD pivotal — *Lasers Surg Med* PMID 28319270 (3.7 vs 1.4 passes · 30 split-tattoo)
- **Kossida 2012** R20 method — *J Am Acad Dermatol* PMID 22036610 (4-pass · 20-min wait · 61% vs 0%)
- **Reddel 2020** PFD in-vivo — *J Cosmet Laser Ther* PMID 32516063 (fluence/temp/particle release)
- **Baranska 2018** capture-release-recapture — *J Exp Med* PMID 29511065 (90-d cycle · SR-A · tattoo Mφ kinetic)

### LAST + safety reference
- **StatPearls** Local Anesthetic Toxicity NBK499964 · Lidocaine NBK539881 — 2/5/10/15-20 μg/mL thresholds
- **ASRA Practice Advisory on LAST** — mcgill.ca/anesthesia LAST 2010

### ex-vivo + animal model
- **Lunter 2021** MD-sim LA+EtOH lidocaine flux 42× (이상 lipid bilayer)
- **EMLA Franz cell flux** 문헌 (Wiechers · FDA bioeq · 10-15× in-vitro 인간 SC)
- **Mohammed 2012** SC thickness site CV ~2× (cheek 17 · forearm 23 · hand-back 29 μm)
- **Göttingen minipig topical PK pilot** — PMC12845211 (인간 skin proxy)

### Cross-domain inheritance
- TTR-ORAL/research/M8_M9_oracle_wetlab.md — pattern source (NON-wet-lab vs DEFERRED 경계 · oracle 부등식 구조)
- TTR-ORAL/research/BP1a_scavenger_receptor_scout.md — rhein/MARCO/SR-A scaffold (β_topical 외삽 근거)
- TTR-ORAL N1/N3 — carbon black 25% 비분해 floor (LB-8 상속)
