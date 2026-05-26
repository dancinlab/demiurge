# TTR-LAC V3 — hexa-native numerical recompute (🟢 push)

> milestone: TTR-LAC.md verify "V3 🟢 — hexa-native recompute (SC 투과 PK · 다중패스 n_pass)"
> V2 (hand-arithmetic closed-form ledger · 52/52 ✅) 의 핵심 수치를 **하나의 hexa-native sim 으로 통합 recompute** (🟢 SUPPORTED-NUMERICAL). sim = `TTR-LAC/sim/v3_numerical_recompute.hexa` · pattern = TTR-ORAL V3 mirror.
> 모든 closed-form 가 V2 hand-arithmetic 와 정합 (13/13 headline 양 PASS). GPU-needing claims (MCML photon transport · MD lipid fluidization 등) 는 비-우선 — 본 도메인 (topical-only · device 동반) 은 모두 local-CPU 천장 안. wet-lab gate (β_topical 직접 실측 · M8 ex-vivo) 는 🟠 DEFERRED.

---

## §1 모델 정의 (V2 family ↔ V3 sim 절 매핑)

| § | family | identity | sim 블록 |
|---|---|---|---|
| 1 | SC Fick (V2 §1) | `t_lag = h²/(6D)` · `onset = 2·t_lag` | sim §1 |
| 2 | depth decay (V2 §2) | `C(z) = C_surf · exp(−z/λ)` | sim §2 |
| 3 | session multipass (V2 §3) | `c_pass = φ·(1−r)` · `c_sess = 1−(1−c_pass)^n` · `N = log(0.1)/log(1−c_sess)` | sim §3 |
| 4 | recapture β (V2 §4) | `r(β) = (1−β)·r₀` · `β_combined = 1 − (1−β_pre)(1−β_post)` | sim §4 |
| 5 | Mie + LAST (V2 §5 + A4) | `μ_s_frost = N·Q·π·a²` · `T = exp(−μ·z)` · `Cmax = k·m·ER·f_epi/t_factor` | sim §5 |
| 6 | fold-cut (V2 §6) | total fold = SoC N / floor N · honest carbon-25% floor | sim §6 |

> 모든 절은 **hand-verifiable** — 1st-method = hexa double float arithmetic. V4 cross-check (2nd-method PBPK·MCML 등) 는 §5 참고.

---

## §2 hexa verbatim 출력 (per @D g5)

```
=== TTR-LAC V3 numerical recompute (hexa-native, 5 V2 families) ===

[1] SC Fick lag-time + D-boost (V2 §1 -> A1.9/A1.10):
  t_lag(D=1e-10, h=10um) =27.7778min
  onset = 2*t_lag        =55.5556min  <- EMLA ~60min anchor
  onset @ D-boost 20x (A2+A3 stack) =2.77778min  <- ≤20min target
  onset(h=15um, D=1e-10) =125.0min   onset(h=20um) =222.222min

[2] depth decay C(z)=C_surf*exp(-z/lambda) at z=200um (V2 §2 -> L2.6 MEC threshold):
  exp(-200/40) =0.00673795  exp(-200/60) =0.035674
  C(200um) Pliaglis 14%, lam=40 =0.0943313%   (< MEC 0.5%)
  C(200um) Pliaglis 14%, lam=60 =0.499436%   <- 0.499% ~= MEC 0.5%
  C/MEC ratio (14% x lam=60)    =0.998872x  (block plausible)
  C(150um)/C_surf (upper plexus, lam=40) =2.35177% of surface

[3] session model B1 (V2 §3 -> L3.3/L3.7 calibration anchors):
  c_pass(phi=0.83, r0=0.70) =0.249
  n=1 (SoC 1-pass)          : c_session =0.249  N =8.04117  <- lit 6-10
  n=1.4 (Biesman laser-alone): c_session =0.330276  N =5.74369  <- 5.74
  n=3.7 (PFD pivotal)       : c_session =0.653369  N =2.17329  <- 2.17
  PFD fold-cut (n=1.4 -> 3.7) =2.64286x  (B1 headline 2.64x)
  JOINT (n=3.7, beta=0.50): c_session =0.943252  N =0.802536  <- 0.80 model ceiling

[4] recapture beta sweep r(beta) = (1-beta)*r0 (V2 §4 -> L4.1/L4.2/L4.3):
  beta=0.30 (cooling+massage)  r =0.49
  beta=0.50 (rhein topical · LB-6) r =0.35  <- load-bearing
  beta=0.70 (Syk+rhein stack)  r =0.21
  beta=0.85 (anti-MARCO peptide) r =0.105
  B4 double-coat beta_combined (pre=0.30, post=0.45) =0.615  <- 0.615
  B4 JOINT (n=3.7, beta_combo=0.615) N =0.667579  <- 0.67 model ceiling

[5] frosting Mie extinction + PFD recovery + LAST safety (V2 §5 + A4 Pliaglis anchor):
  mu_s_frost (air)  =62.8319cm^-1  (+62.83 over baseline 100)
  mu_s_frost (PFD)  =0.628319cm^-1
  T(200um) baseline =0.135335  frosted =0.0385177  PFD =0.133645
  bubble extinction =0.71539  (~72% beam block)
  PFD recovery vs baseline =0.987512x  (~0.987 = 99% restore)

  -- LAST safety (Pliaglis FDA-PK anchor, hexa-LAC v1 100cm^2 x 30min + epi) --
  k (Pliaglis-anchored) =0.0532688ng/mL per mg lido applied
  mg lido applied (100cm^2 @ 7%) =1032.5
  Cmax (hexa-LAC v1, 100cm^2, 30min, +epi, ER=3) =18.3333ng/mL
  LAST safety margin (5000 ng/mL seizure / Cmax) =272.727x  <- ~273x

[6] fold-cut summary (V2 §6 -> L6.3/L6.5/L6.6):
  SoC (n=1.4, r0=0.70)      N =5.74369  ->9.1899mo  <- 9.19mo
  B4 model (n=3.7, b=0.615) N =0.667579  ->1.06813mo  <- 1.07mo model ceiling
  honest floor (carbon-25% non-deg) N=1.5 ->2.4mo  <- 2.4mo realistic
  fold-cut model ceiling = SoC / B4_model =8.60376x  (~8.60x)
  fold-cut HONEST FLOOR  = SoC / floor    =3.82913x  (~3.83x · @D d5/d6)

[7] checksums vs V2 hand-ledger (12 key numerics):
  L1.1 t_lag(D=1e-10,h=10um) min target 27.78  -> got27.7778
  L1.2 onset(2*t_lag)        min target 55.56  -> got55.5556
  L1.7 onset D-boost 20x     min target  2.78  -> got2.77778
  L2.6 C(200um) Pli14% lam60 %   target  0.499 -> got0.499436
  L3.3 N(SoC, n=1.4)           target  5.74  -> got5.74369
  L3.7 N(PFD,  n=3.7)          target  2.17  -> got2.17329
  L3.10 PFD fold-cut             target  2.64  -> got2.64286
  L4.2 r(beta=0.50)            target  0.35  -> got0.35
  L4.8 JOINT N(n=3.7,beta=0.50) target 0.80  -> got0.802536
  L4.9 beta_combined B4         target  0.615 -> got0.615
  L5.9 frost beam block %       target 71.5  -> got71.539
  L5.10 PFD recovery           target  0.987 -> got0.987512
  L6.6 honest fold-cut x        target  3.83  -> got3.82913

=== V3 done — 52/52 V2 closed-form 中 13 headline numerics 🟢 hexa-recompute PASS ===
=== honest floor (carbon-25% non-deg) = 1.5 sess ~ 2.4mo ~ 3.83x cut (@D d5/d6) ===
```

---

## §3 V2 ↔ V3 checksum table (13 key numerics)

| # | V2 ID | quantity | V2 hand-ledger | V3 hexa recompute | drift | match |
|---|---|---|---|---|---|---|
| 1 | L1.1 | t_lag (D=1e-10·h=10μm) [min] | 27.78 | **27.7778** | 0.001% | ✅ |
| 2 | L1.2 | onset = 2·t_lag [min] | 55.56 | **55.5556** | 0.001% | ✅ |
| 3 | L1.7 | onset @ D-boost 20× [min] | 2.78 | **2.77778** | 0.080% | ✅ |
| 4 | L2.6 | C(200μm) Pliaglis 14% · λ=60 [%] | 0.499 | **0.499436** | 0.087% | ✅ |
| 5 | L3.3 | N (SoC, n=1.4) | 5.74 | **5.74369** | 0.064% | ✅ |
| 6 | L3.7 | N (PFD, n=3.7) | 2.17 | **2.17329** | 0.152% | ✅ |
| 7 | L3.10 | PFD fold-cut (1.4p→3.7p) [×] | 2.64 | **2.64286** | 0.108% | ✅ |
| 8 | L4.2 | r(β=0.50) [load-bearing] | 0.35 | **0.35000** | 0.000% | ✅ |
| 9 | L4.8 | JOINT N (n=3.7 · β=0.50) | 0.80 | **0.802536** | 0.317% | ✅ |
| 10 | L4.9 | β_combined (B4 double-coat) | 0.615 | **0.615** | 0.000% | ✅ |
| 11 | L5.9 | frost beam block [%] | 71.5 | **71.539** | 0.055% | ✅ |
| 12 | L5.10 | PFD recovery [×] | 0.987 | **0.987512** | 0.052% | ✅ |
| 13 | L6.6 | honest carbon-floor fold-cut [×] | 3.83 | **3.82913** | 0.023% | ✅ |

⇒ **13/13 ✅ PASS** (모든 drift < 0.5%; 가장 큰 drift = L4.8 0.317% 는 V2 두 자리 반올림 0.80 vs V3 0.8025 의 단순 자리수 차). V2 closed-form ↔ V3 hexa-native 의 일관성 검증 완료. additional headline (LAST 18 ng/mL · 273× margin · 9.19mo SoC · 2.4mo floor) 도 §2 verbatim 에서 확인.

> 추가 cross-domain anchor: TTR-ORAL V3 동일 family (BP1d 세션 모델 · `c_session = 1−(1−φ(1−r))^n`) 와 정합 → 본 도메인 §3 도 동일 closed-form 위에서 동작. β_oral 0.40 천장 (TTR-ORAL) vs β_topical 0.50 (LB-6) 의 1단계 boost 가 본 도메인 핵심 차이.

---

## §4 tier 상태 + 남은 🟠

### 🟢 SUPPORTED-NUMERICAL (V3 hexa-recompute 완료 · 13건)

| ID | claim | V3 anchor |
|---|---|---|
| A1.9 | SC lag (D=1e-10·h=10μm → 55.6min onset) | sim §1 |
| A1.10 | D-boost stack (20× → 2.78min) | sim §1 |
| A1.13/14 | dermal reach 2.35% / 0.674% (upper plexus / nerve endings) | sim §2 |
| A2/A3 | Pliaglis-eq 14% × λ=60 epi → 0.499% ≈ MEC 0.5% | sim §2 |
| B1.9 | SoC calibration (φ=0.83·r=0.70·n=1.4 → N=5.74) | sim §3 |
| B1.11 | PFD pivotal headline (n=3.7 → N=2.17 · fold 2.64×) | sim §3 |
| B3.4/3.5 | β sweep 0.30/0.50/0.70/0.85 → r=0.49/0.35/0.21/0.105 | sim §4 |
| B3.5 | JOINT (n=3.7·β=0.50 → N=0.80 model ceiling) | sim §3/§4 |
| B4 | double-coat β_combined=0.615 → N=0.67 | sim §4 |
| B2.4 | μ_s_frost=162.83 cm⁻¹ · T_frost/T_base=0.285 (~72% block) | sim §5 |
| B2.4 | PFD recovery 0.987× baseline | sim §5 |
| A4 | Pliaglis-anchored Cmax 18.3 ng/mL · 273× LAST margin | sim §5 |
| B4 | honest carbon-floor fold-cut 3.83× (SoC 9.19mo → 2.4mo) | sim §6 |

### 🟠 INSUFFICIENT/DEFERRED (V4 → wet-lab gate)

| ID | claim | gate | host |
|---|---|---|---|
| LB-6 | β_topical = 0.50 직접 잉크-재포획 실측 | **M8 ex-vivo on real tattoo (Franz cell + post-laser imaging)** · 1순위 | wet-lab |
| LB-4 | λ depth-decay 절대값 (40/60μm partition/실효-D 의존) | A5 Franz PK (in-vivo retention) | wet-lab |
| A1.5 | BLT compounded 정확 onset (clinic 별 가변) | clinic-specific kinetic | wet-lab |
| B2.13 | PFD-lidocaine 직접 혼합 emulsion 안정성 | mock-up bench test | wet-lab |
| A1.15 | 진피 nerve-block 확률 (확률적·환자 가변) | clinical pilot | wet-lab |
| B3.10 | EMLA+PFD+rhein 3-step 도포순서 화학 양립성 | bench compat test | wet-lab |

### tier 분포 변동 (V1 → V3)

| tier | V1 | V3 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 8 | 8 (V2 52/52 unit-identity 으로 분해) |
| 🟢 SUPPORTED-NUMERICAL | 13 (개별 sim) | **13 (hexa-native consolidated)** |
| 🟡 SUPPORTED-BY-CITATION | 11 | 11 |
| 🟠 INSUFFICIENT/DEFERRED | 6 | 6 |
| 🔴 FALSIFIED | 0 | 0 |
| ⚪ SPECULATION-FENCED | 0 | 1 (V2 §0 meta-claim) |

> 🟢 13건 모두 본 V3 single-file hexa sim 에서 verbatim 재현 (이전 sim 분산 → consolidated). 새로 추가된 falsification 없음 — V2 closed-form ↔ V3 hexa-native 의 *정합* 검증이 목적. wet-lab gate 6건은 변동 없음.

---

## §5 V4 handoff list (final tier ledger 입력)

1. **V4 = final tier ledger** — V1 38 claim + V2 52 closed-form unit-identity + V3 13 hexa-recompute 의 통합 정산.
2. **atlas-register 후보 13 atom** (V2 §11) → PR-only landing per `@D g_atlas_binary_builtin`. 본 V3 의 hexa double-float recompute 가 numerical anchor 역할.
3. **2nd-method cross-check (V1 §6 plan)** — 7 step 모두 local CPU 천장 안:
   - V3.1 SC lag-time → Cleek-Bunge multilayer PBPK 또는 Potts-Guy 회귀
   - V3.2 dermal reach → 2-compartment PK (SC + viable epi + dermis · λ partition 분해)
   - V3.3 PFD multipass → 독립 임상 메타 (R20 Kossida 2012 / Brauer pilot PMC5042086)
   - V3.4 frosted μ_s → Monte Carlo photon transport (MCML) Mie 정확해
   - V3.5 dose-response knee → Reddel 2020 fluence-temp data 와 φ_rel sensitivity
   - V3.6 β sweep → TTR-ORAL BP1d r-sweep 정합 (β_oral 0.40 vs β_topical 0.50)
   - V3.7 통합 protocol → first-principles PBPK + 광학 + drainage 단일 모델
4. **wet-lab gate priority** — M8 ex-vivo on real tattoo (β_topical 직접 측정, LB-6 의 *직접* validation) = 1순위. A5 Franz PK retention = 2순위 (λ 절대값). LAST 가산 safety = 3순위 (Pliaglis stack overlay).
5. **hexa-lang INBOX patch (per @D d8 · V2 §10 breakthrough)** — dermatologic + laser-optics fn 7건 (`fick_lag`·`beer_lambert`·`mie_mu_s`·`multipass_cumulative`·`sessions_to_90pct`·`recapture_beta`·`beta_combined`) 을 hexa stdlib 에 propose → V4 이후 `hexa verify --expr` 로 직접 검증 path 열림. TTR-ORAL V2 §4 의 PK fn proposal 과 묶어 단일 dermatologic stdlib module.
6. **absorbed=false 유지** (LAC measured-oracle = M8 ex-vivo PASS 까지 · per @D d5) — non-wet-lab 영역 (closed-form + numerical) 은 모두 닫힘.

---

## §6 honest tier 종합 + Sources

### honest verdict (per @D d5/d6)

V3 의 13 양 hexa-recompute 가 V2 hand-ledger 와 *모두 정합* (drift < 0.5%) → closed-form 토대는 견고. 그러나 **단일 가장 약한 고리** = **LB-6 (β_topical = 0.50)** — TTR-ORAL BP1a rhein/MARCO scaffold 의 *경구* β_oral 0.40 천장을 *토픽 ~10³× 농도 우위*로 외삽한 값으로, 직접 잉크-재포획 β 실측 없음. JOINT stack <1세션 절대값 (B3.5 / B4 N=0.67) 은 carbon-25% 비분해 floor 무시한 모델 천장 — sim §6 에서 honest floor (~1.5 sess · 2.4mo · **3.83×** cut) 로 self-falsify. 모델 천장 8.60× 와 honest floor 3.83× 의 gap (= 모델 N=0.67 vs floor N=1.5) 이 본 도메인의 인플레 가드 핵심.

### Sources (V1/V2 inherited · 새 lit 없음)

**마취 (A1·A4·A5)**
- EMLA FDA label — onset 1h·최대 2-3h·≤1300 cm²/150g (accessdata.fda.gov/.../019941s021lbl.pdf)
- Pliaglis FDA-PK — 59g/400cm²/120min → lido Cmax 220 ng/mL (FDA label)
- Lidocaine SC diffusivity ~1e-10 cm²/s — UCSD BENG221 · *Int J Dermatol* 2018 · *Sci Data* 2024 skin permeability review
- LAST seizure threshold lidocaine 5000 ng/mL — *PubMed* 25135033 lidocaine/tetracaine review

**제거 (B1·B2·B3·B4)**
- PFD pivotal trial (Biesman 2017) 3.7p vs 1.4p — *Lasers Surg Med* PubMed 28319270
- R20 (Kossida 2012) 4p 61% vs 0% — PubMed 22036610
- frosting bubble density a=1μm·N≈10⁹/cm³ — Ho 2002 (JCAS PMC4411588)
- baseline dermis μ_s ~100 cm⁻¹ (755nm) — Jacques 2013 *Phys Med Biol*
- PFD 물성 (n=1.313 · O₂ 50mL/100mL · 비반응 FDA-cleared) — ScienceDirect Topics · refractiveindex.info
- Baranska 2018 capture-release-recapture · 잉크 재포획 macrophage 기전 — *J Exp Med* rupress.org/jem/215/4/1115

**Cross-domain inheritance**
- TTR-ORAL V3 (`TTR-ORAL/verify/V3_numerical_recompute.md`) — 동일 BP1d 세션 모델 family · pattern mirror source
- TTR-LAC V1/V2 — claim inventory + closed-form ledger SSOT

**재현 (hexa-native)**
- `hexa run TTR-LAC/sim/v3_numerical_recompute.hexa` — 본 V3 consolidated sim (52/52 closed-form 中 13 headline 양 hexa-recompute)
- 개별 sim (V1 inventory inherited): `a1_lagtime.hexa` · `a2_a3_accel_depth.hexa` · `a4_LAST_safety.hexa` · `b1_laser_ratelimit.hexa` · `b2_frosting_clear.hexa` · `b3_topical_r_down.hexa` · `b4_integrated_protocol.hexa`

---

## §7 final note

V3 = consolidated hexa-native recompute. V2 52/52 closed-form 의 핵심 13 headline 양을 단일 sim 으로 hexa-native 재현 → drift 全 <0.5% 로 PASS. carbon-25% honest floor (3.83× cut / 2.4mo) 가 모델 천장 (8.60× / 1.07mo) 을 self-bound — 인플레 가드 작동. 단일 가장 약한 고리 = LB-6 (β_topical = 0.50) · M8 ex-vivo 가 1순위 wet-lab gate. non-wet-lab 영역 (closed-form + numerical) 은 **닫힘** · absorbed=false 유지 (per @D d5 — measured-oracle PASS 까지).
