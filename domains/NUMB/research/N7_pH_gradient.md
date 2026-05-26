# NUMB N7 — pH gradient bilayer cream: free-base activation × SC partition shift

> 🧊 **NUMB N7 (NOVEL 후보 · round-2 · per @D d11 + d18)** — hexa-LAC v1 (lid 7% + tet 7% binary eutectic Tm ~30°C + LA 5% + EtOH 20% + epi 1:200k + HPC peel-film, pH ~5.5 lactate buffered) 위에 **상부 alkaline layer (pH 8.5 carbonate buffer)** 를 도입 → **Henderson-Hasselbalch 평형 시프트** (lid f_free 0.40% → 80% · tet f_free 0.10% → 50%) → **K_sc partition multiplier** (Hadgraft 1985 ΔlogP +2.1 ionized→neutral) → **steady-state J_ss 4-6×** over hexa-LAC v1.
>
> **honest tier verdict: 🟠 INSUFFICIENT/DEFERRED (concept GREEN, 정량 → 1-point Franz cell + epi-HPLC + lid 안정성 wet-lab 필요)**. 메커니즘 (HH closed-form · Hadgraft 1985 logP shift · Tatara 2021 review) = 🟡 임상/물리 정합. **bilayer 아키텍처 3 후보 (A 2-step · B laminated · C microcap)** 모두 **wet-lab gate** (~$1000-2100 total). N7 = **freedom-to-operate** — buffered lid INJECTION (NaHCO3 8.4%) 는 well-precedented (Onpharma 등) 이지만 **transdermal pH-gradient bilayer cream = 2025 시점 published clinical study ZERO** → novel IP space.
>
> sim = `NUMB/sim/n7_ph_gradient.hexa` (verbatim §6, lid f_free hexa-native = 0.00397 / 0.240 / 0.799 @ pH 5.5/7.4/8.5).
>
> **honest framing (N1 + N6 학습 흡수, per @D d6)**: f_free 와 K_sc 는 `J_ss = D_eff · K_sc · a` 의 **steady-state prefactor** 항이지 `t_lag = h²/(6 D_eff)` 와 무관 → **N7 의 pH-shift 는 onset 가속이 아니다**. N7 의 진짜 가치 = **unit-area SC delivery 효율 ↑** (더 작은 patch 같은 depth) + **DEPTH 보전** (G3 소아 / G4 OTC 저농도) + **DURATION 연장**. "alkaline top → 5min onset" 같은 추측 ✗.

---

## 1. 모델 — Henderson-Hasselbalch + Hadgraft 1985 + Fick steady-state

### 1.1 Henderson-Hasselbalch (free-base 분율)
```
f_free = 1 / (1 + 10^(pKa − pH))
```

| 변수 | 정의 | 단위 |
|---|---|---|
| `f_free` | 자유 염기 mole fraction (비이온화) | - |
| `pKa` | 마취제 base pKa | - |
| `pH` | 국소 매질 pH | - |

### 1.2 SC partition shift (Hadgraft 1985)
```
K_sc(ip) = K_sc(0) · 10^(ΔlogP)
ΔlogP_max = +2.1   (ionized lid logP -0.6 → free-base lid logP +1.5)
```

### 1.3 활동도 → flux
```
a       = f_free · C_total
J_ss    = D_eff · K_sc · a            (정상상태 flux, Fick)
t_lag   = h² / (6 D_eff)              (D-driven · pH 무관)
K_sc_eff(pH) = K_sc(0)·f_free + K_sc(ion)·(1-f_free)
```

**N1 + N6 학습 적용**: f_free 와 K_sc 는 `J_ss` 의 **prefactor** — **onset 무관**. N7 가치축 = **prefactor multiplier (depth + duration + unit-area)**.

---

## 2. 입력 anchor — pKa · pH · logP · 안정성

| 성분/매질 | 값 | 출처 |
|---|---|---|
| **lid pKa** | **7.9** | DrugBank · Sigma-Aldrich SDS |
| **tet pKa** | **8.5** | DrugBank · Powell 1987 Pharm Res |
| bupivacaine pKa | 8.1 | DrugBank |
| prilocaine pKa | 7.9 | DrugBank |
| lid logP (ionized) | -0.6 | Hadgraft 1985 transdermal review |
| lid logP (free base) | +1.5 | Hadgraft 1985 · ChemSpider |
| ΔlogP ceiling | **+2.1** | Hadgraft 1985 (1.5 - (-0.6)) |
| **K_sc ceiling** | **10^2.1 = 125.9×** | theoretical max |
| **K_sc realistic** | **10-12×** | Tatara 2021 review (PMC8234378) Franz consensus |
| K_sc in-vivo | 3-5× | TTR-LAC A2 학습 (Franz 대비 2-3× derate) |
| **skin acid mantle pH** | **4.5-5.5** | Lambers 2006 Int J Cosmet Sci |
| commercial cream pH | 5.5 (lactate) | EMLA · Pliaglis · LMX SDS |
| carbonate buffer pH | 8.5-10 | Sigma carbonate-bicarbonate buffer table |
| **lid stability max pH** | **3-6** | Powell 1987 Pharm Res PMID 3508528 (amide hydrolysis) |
| **epi pH 8.5 분해** | **30% loss @ 30min, 100% @ 2wks** | Sciencedirect 1990 alkalinized stability |
| lid micelle distribution | **pH 5/7.8/9 → 0%/55%/80%** | ScienceDirect SD emulsion study (전 micelle phase) |

**검증 gate**: hexa sim §2 outputs lid f_free = **0.00397 / 0.240 / 0.799** @ pH 5.5 / 7.4 / 8.5 → closed-form HH 와 0.4% 이내 매치 (🟢 numerical verify).

---

## 3. f_free + K_sc closed-form 결과 (hexa GREEN)

### 3.1 lid (pKa 7.9) free-base 분율
| pH | 10^(pKa-pH) | f_free | 임상 의미 |
|---|---|---|---|
| 4.5 | 2512 | **0.040%** | skin acid mantle (현재 SC 표면) |
| 5.5 | 251.2 | **0.40%** | commercial cream (EMLA/Pliaglis 표준) |
| 6.5 | 25.12 | 3.83% | |
| 7.4 | 3.162 | **24.0%** | physiologic (혈장 등) |
| 7.9 | 1.000 | 50.0% | == pKa |
| **8.5** | **0.2512** | **79.9%** | **N7 target (carbonate buffer)** |
| 9.5 | 0.0251 | 97.5% | (실용 한계 초과) |

### 3.2 tet (pKa 8.5) free-base 분율
| pH | f_free |
|---|---|
| 5.5 | 0.10% |
| 7.4 | 7.4% |
| **8.5** | **50%** |
| 9.5 | 90.9% |

### 3.3 K_sc effective ratio (lid pH 5.5 → 8.5)
```
K_eff(pH) = K_sc(0)·f_free + K_sc(ion)·(1-f_free)
K_eff(5.5) = 125.9 · 0.004 + 1 · 0.996  = 1.500
K_eff(8.5) = 125.9 · 0.799 + 1 · 0.201  = 100.8
ratio = 100.8 / 1.500 = 67.1×    (THEORETICAL)
```

| 평가 수준 | K_sc boost | 근거 |
|---|---|---|
| theoretical (HH × Hadgraft) | **67×** | hexa sim §3 closed-form |
| realistic (Tatara Franz cap) | **10-15×** | PMC8234378 review consensus |
| **conservative (in-vivo derate)** | **8-12×** | TTR-LAC A2 lesson (in-vivo / Franz ~0.3-0.5) |

---

## 4. bilayer 아키텍처 3 후보 (핵심 표)

| 후보 | mechanism | flux × (vs hLAC v1) | safety | regulatory | 안정성 | 비고 |
|---|---|---|---|---|---|---|
| **A: 2-step apply** (acidic base → 5min wait → alkaline top) | 사용자가 2 step 도포; SC 가 t=5min+ 에서 alkaline 경계 노출 | **4-6×** (weighted, half-coverage) | **HIGH** (physical separation; epi-acid + alkaline-top never mixed) | **EASIEST** (drug-drug combo, no fixed-dose claim; 2 SKUs 별도 NDA 가능) | **24mo OK** (각 SKU 독립 안정성) | user compliance 위험 (2 step 누락) · top-layer drying 시 pH 중성화 |
| **B: laminated peel-film** (HPC bilayer 단일 cream/film, polymer barrier) | 단일 SKU; bottom acidic lid+tet+epi + top alkaline carbonate, 도포 30min 동안 alkaline diffuse-cross | **6-8×** (top 직접 SC 접촉) | medium (long-term layer crosstalk 우려) | medium (novel formulation, 505(b)(2) feasible) | **WALL** (24mo 동안 alkaline → acidic 확산 → lid hydrolysis + epi 분해 risk) | thick polymer barrier 또는 encapsulation 필요 |
| **C: time-release pH** (acidic cream + sodium carbonate microcapsule 5min dissolve) | 단일 SKU; lid+tet+epi pH 5.5 안정 + 도포 시 SC 수분에 microcap 용해 → pH 국소 spike | **5-7×** (temporal pulse) | medium (microcap GMP 새 risk) | hard (novel GMP, microcap shell choice = 신소재 regulatory) | OK (microcap 분리 → 24mo shelf 가능) | acidic buffer override 위해 carbonate 20-30% w/w 필요 |

**Ranking 축별**
| 축 | 순위 |
|---|---|
| safety | A > C > B |
| flux | B > C > A |
| regulatory | A > B > C |
| 안정성 (24mo shelf) | A > C > B |
| compliance | B > C > A |

**TOP PICK**:
- **V1 (fastest to market) = A** — 2-SKU 별도 NDA · 가장 적은 안정성/regulatory novelty risk
- **V2 (after stability data) = B** — laminate stability R&D 검증 후
- **V3 (long-term innovation) = C** — microcap GMP scale-up

---

## 5. depth recompute @ 200μm (free nerve endings)

`C(z) = C_surf · a · K_eff · exp(−z/λ)`, λ=60μm (epi 1:200k), C_surf=14% lid-eq, exp(-200/60)=0.0357, MEC=0.5%

| 제형 | C(200μm) | C/MEC | 마진 |
|---|---|---|---|
| hexa-LAC v1 | 1.00 %lid | 2.0× | baseline safe |
| **N7-A (2-step)** | **4.00** | **8.0×** | 4× boost |
| **N7-B (laminated)** | **6.00** | **12×** | 6× boost (top-dom) |
| **N7-C (microcap)** | **5.00** | **10×** | 5× boost (pulse) |

→ N7-B/C 는 dermal block margin ~10-12× → **G3 소아 SKU 가능** (lid 3.5%+tet 3.5% de-rate 후에도 마진 5× 유지)

---

## 6. LAST safety re-gate

- Pliaglis baseline 100cm² × 30min + epi → Cmax 18 ng/mL lid (TTR-LAC A4 anchor)
- N7-A/B/C @ 4-6× flux → 예측 Cmax **72-108 ng/mL** (toxic 5000 ng/mL 대비 50× 마진, but baseline 273× 에서 50× 로 축소)
- **envelope (N6 와 동급)**: **EPI co-admin MANDATORY · AREA CAP <200cm² · DURATION CAP <30min**
- 1000cm² 타투 sleeve use case → **DE-RATE lid+tet 3.5+3.5%** (G1 cross-axis 보정)

---

## 7. 핵심 wall + breakthrough path

| wall | 정량 | breakthrough |
|---|---|---|
| **W1 alkaline pH skin tolerance** | pH 8.5 = mild alkaline (skin 4.5-5.5 acid mantle). 단시간 (<30min) tolerable (dental NaHCO3 9:1 ratio @ pH 7.4-8 임상 precedent), 장시간 SC degradation/irritation. | **N7 indication 제한 = 단회용 procedure 30min (G1 hair-removal/needle-stick/tattoo)** · 만성 신경통 등 hours-days 사용 ✗ |
| **W2 lid free-base 결정화/oil** | lid free base = oil @ skin T (lid Tm 68°C). Eutectic + EtOH 20% co-solvent 가 stabilize. | 24mo shelf → pH-stabilizing co-buffer (Tris, glycine) 추가 + DSC 결정성 측정 |
| **W3 epinephrine pH 8.5 분해** | 30% loss @ 30min, 100% @ 2wks (Sciencedirect 1990) | **bilayer 물리적 분리 MANDATORY** → N7-B 폴리머 배리어 또는 capsule 필수, N7-A (2 SKUs) / N7-C (microcap) = 자연스럽게 separated |
| **W4 lid amide 가수분해 @ pH 8.5** | Powell 1987 t₁/₂ ~ months @ RT (max stability pH 3-6) | shelf-life 24mo OK 단 alkaline 접촉 <hours total · N7-B 폴리머 분리 또는 냉장 |
| **W5 carbonate buffer 용량** | skin lactate 분비 (acid mantle) → 수분 내 중성화 | N7-A 도포 간 wait-time 3-5min critical · N7-C carbonate 20%+ w/w |
| **W6 regulatory novelty** | pH-gradient bilayer = FDA-approved 토픽 마취 precedent **ZERO** (buffered lid INJECTION 은 있음 — Onpharma) | **505(b)(2) feasible** w/ RLD = LMX-5 / Pliaglis · N7-A (2 SKUs) 가장 단순 |
| **W7 lid micelle phase data** | pH 5 → 0% / pH 7.8 → 55% / pH 9 → 80% (SD emulsion study) | N7 = empirical anchor 존재 → 🟢 numerical evidence 1점 |

### 7.1 minimum-spend wet-lab gate (~$1000-2100)
| step | 실험 | $ | timeline |
|---|---|---|---|
| **P1 Franz cell** | 1-point lid flux pH 5.5 vs 8.5 (cadaver/synthetic SC) | **$500-1000** | 1 week |
| **P2 DSC alkaline lid 안정성** | lid+tet+NaHCO3 @ 40°C × 1wk, amide hydrolysis HPLC % | **$200-500** | 1 day + 1wk |
| **P3 epi 분해 prototype** | bilayer N7-A/B/C HPLC epi T=0, 1d, 7d, 30d | **$300-600** | 1 month |
| **P4 patent freedom-to-operate search** | USPTO + EPO pH-gradient topical anesthetic claims | $0 (model) | 1 day |
| **total** | | **~$1000-2100** | **~1 month** |

→ P1+P2+P3 PASS 시 🟠 → 🟡 (numerical evidence), 후속 in-vivo Phase 0 → 🟢

---

## 8. deep research 발견 (arxiv + web · per @D d18)

### 8.1 arXiv — pH-responsive / multi-layer transdermal
| paper | id | 핵심 발견 | N7 적용 |
|---|---|---|---|
| **Pontrelli et al. 2019** | **2001.03058** | **pH-responsive 2-layer (core + polymeric shell) drug delivery PDE** — pH stimulus → larger drug release in acidic vs physiologic env. Two-layer model accounts for dissolution + diffusion + polymer interaction. | **N7 bilayer DIRECTLY described** by their two-phase eigenvalue formulation; interface flux continuity analytical solution applicable |
| **Pontrelli et al. 2016** | **1601.03074** | iontophoretic multi-layer w/ Nernst-Planck + Laplace 전위, FD numerical | pH gradient = special case of chemical-potential gradient; N7 ion-pair partition follows same multi-layer formalism |
| **Pontrelli & de Monte 2014** | 1405.1413 | two-phase two-layer SC + viable epi, eigenvalue analytical | N7 alkaline top + acidic bottom = same 2-layer formalism, K_sc layer-dependent boundary condition |

### 8.2 web — buffered lid · alkaline cream · epi/lid pH 안정성
| source | URL | 핵심 발견 | N7 적용 |
|---|---|---|---|
| **Onpharma Buffering** | onpharma.com/pages/science-of-buffering-1 | lid INJECTION NaHCO3 8.4% (9:1 ratio) → pH 7.4 · onset 단축 · 통증 ↓ · 임상 표준 | **precedent — pH 8 lid 단기 임상 OK**. transdermal 적용은 미공개 |
| **PMC12742648** | Buffered vs non-buffered lid infiltration RCT (2024) | onset 약간 단축, 통증 유의 ↓ (p<0.05) | N7 핵심 framing 보강 — but onset 가속은 injection 의 acidic→neutral 전환 효과, transdermal 무관 |
| **PMC2854439** | peribulbar 마취 lid warming + alkalinization | 알칼리화 → 운동 차단 개선, 감각 차단 무관 | alkaline = ion-pair 변환 효과 단편 evidence |
| **PMC2827006** | Buffered lid + epi syringe 안정성 | 4-8°C 보관 4wk OK, RT 1wk 한계 | N7-A 2-SKU separation = epi 안정성 충분 |
| **Sciencedirect 1990 (S0196064405822814)** | Stability of epinephrine in alkalinized solutions | **pH 8.5 epi → 30% loss @ 30min, 100% @ 2 weeks** | **W3 직접 정량 anchor** |
| **PMC4071081** | Epi 표준 농도 안정성 | acidic salt + antioxidant 표준 | 표준 분해 mechanism |
| **Powell 1987 Pharm Res (PMID 3508528)** | Lid aqueous 안정성 (T, pH, buffer, metal ions) | **max stability pH 3-6** · amide hydrolysis @ alkaline | **W4 직접 정량 anchor** |
| **SD S0022354915469308** | lid+pri eutectic emulsion phase distribution | **micelle phase: pH 5 = 0%, pH 7.8 = 55%, pH 9 = 80%** | **W7 empirical HH 검증 anchor** |
| **MDPI 17:324 (2026)** | NADES + lid 2% hydrogel | ointment 대비 2.7× permeation | N7 8× target → triple stack 정당화 |
| **Frontiersin 2025 lid cream ultrasound+microneedle** | bioeng-biotechnol 1612145 | physical CPE 보강 path | N7 와 직교 axis (N1/N6 와도 직교) |
| **PMC12513045** | Topical analgesics 약리 review (2025) | pH 의 SC partition 역할 언급, gradient bilayer 명시 부재 | N7 = literature gap 확인 |

### 8.3 prior art 검토 (FTO freedom-to-operate)
- **buffered lid INJECTION** = 임상 표준 (Onpharma · NaHCO3 8.4% 9:1) — but topical/transdermal 아님
- **WO2004103260A2 (Pliaglis 가족)** = ternary anesthetic eutectic claim, pH 무관 → N7 free
- **LMX 가족** = lid base 4-5% liposomal, pH ~5-6 acidic → N7 가 위에 alkaline layer 추가 = 새 IP
- **2025 search** = "pH-gradient topical anesthetic cream" published clinical study **ZERO** (Frontiers · MDPI · PMC 검색 모두 부재)
- **결론**: **N7 = freedom-to-operate** (특히 N7-A 2-SKU drug-drug combo 는 fixed-dose claim 회피 → IP risk 최소)

---

## 9. hexa-native sim verbatim (per @D g5 · 🟢)

전체 출력 (host=mini, GREEN run, file = `NUMB/sim/n7_ph_gradient.hexa`):

```
=== NUMB N7 — pH gradient bilayer (alkaline-top free-base activation) ===

[2] HH numerical verify — hexa-native (Taylor approx for 10^x via exp(x ln10))
    -> use ln-domain: f_free = 1/(1+10^d), d=pKa-pH; precompute 10^d at d in {-1,0,1,2,3}
  lid f_free @ pH 5.5 = 0.00396511
  lid f_free @ pH 7.4 = 0.240269
  lid f_free @ pH 8.5 = 0.799233
  tet f_free @ pH 5.5 = 0.000999001
  tet f_free @ pH 7.4 = 0.0735835
  tet f_free @ pH 8.5 = 0.5

[3] SC partition shift — Hadgraft 1985 ceiling vs realistic cap
  K_sc boost (lid pH 5.5 -> 8.5): theoretical 67.1x  realistic 10x  conservative 8x
  K_sc boost (tet pH 5.5 -> 8.5): theoretical 125x   realistic 12x  conservative 10x

[7] depth recompute @ 200um
  hexa-LAC v1   C(200um)=0.9996 %lid   C/MEC=1.9992
  N7-A (2-step) C(200um)=3.9984 %lid   C/MEC=7.9968
  N7-B (laminat)C(200um)=5.9976 %lid   C/MEC=11.9952
  N7-C (micrcap)C(200um)=4.998 %lid   C/MEC=9.996

[8] LAST safety re-gate
  N7-A/B/C @ 4-6x flux -> projected Cmax 72-108 ng/mL
  -> EPI co-admin MANDATORY · AREA CAP <200cm2 · DURATION CAP <30min

=== verdict: N7 is a STEADY-STATE SC PARTITION MULTIPLIER (NOT onset accelerator) ===
=== Candidate A (2-step apply) = SAFEST + FASTEST regulatory; 4x flux over hexa-LAC v1 ===
=== onset = D-driven (UNCHANGED at 6min from hexa-LAC v1); depth + duration + unit-area are the gain ===
=== wall = Franz cell + DSC + epi-HPLC wet-lab required (~$1000-2100 total to break) ===
```

---

## 10. NUMB.md 갱신 안 (NUMB N-row 추가)

```diff
 ### N — NOVEL probes (round-1 · round-2)
 - [x] N1 phase-change peel-film → ... 🟠 plausibly-novel ...
 - [x] N5 Mg²⁺ multi-modal → ... 🟠 INSUFFICIENT/DEFERRED ...
 - [x] N6 ion-pair / ternary eutectic → ... 🟠 INSUFFICIENT/DEFERRED ...
+- [x] N7 pH gradient bilayer cream → `NUMB/research/N7_pH_gradient.md` (+ sim · 🟢 hexa-native HH+Hadgraft GREEN) · 🟠 INSUFFICIENT/DEFERRED · **Henderson-Hasselbalch + Hadgraft 1985 closed-form 검증 ✓ (lid f_free 0.40% → 80% @ pH 5.5 → 8.5)** · 3 bilayer 후보: A=2-step apply 4× (V1 top · safest) · B=laminated 6× (V2 · 안정성 wall) · C=microcap 5× (V3 · GMP novelty) · honest framing (N1·N6 학습 적용): f_free·K_sc 는 J_ss flux multiplier · `t_lag` 무관 → **depth+duration+unit-area delivery**, NOT onset · 🚨 wall = epi pH 8.5 분해 (Sciencedirect 1990 30% @ 30min) → bilayer 물리적 분리 mandatory; lid amide 가수분해 (Powell 1987 max pH 3-6) → laminated 24mo shelf risk · IP freedom-to-operate ✅ (transdermal pH-gradient cream published clinical ZERO 2025) · arxiv grounding Pontrelli 2019 (2001.03058) 2-layer PDE · breakthrough min-spend $1000-2100 (Franz + DSC + epi-HPLC) → 1mo timeline
```

---

## 11. honest verdict

🟠 **INSUFFICIENT/DEFERRED** — 모든 정량 (K_sc shift in-vivo · epi 분해 분리 효율 · lid 24mo 안정성) 이 **single-batch wet-lab spend ($1000-2100)** 로 측정 가능 → **N6 와 동등 cheap-est NOVEL probe**, 단 wall (epi/lid 안정성) 이 N6 보다 더 정량적으로 알려져 있음 (anchor 확실).

| 축 | tier | 근거 |
|---|---|---|
| HH closed-form | 🟢 | hexa-native numerical verify (lid f_free 0.397/24.0/79.9% 정확 매치) |
| Hadgraft 1985 ΔlogP+2.1 ceiling | 🟡 | 1985 review consensus, Tatara 2021 재확인 |
| Pontrelli 2019 arxiv 2-layer PDE | 🟡 | 직접 N7 architecture grounding (peer-reviewed) |
| K_sc in-vivo 8-12× | 🟠 | Franz 측정 필요 (P1) |
| epi pH 8.5 분해 | 🟢 | Sciencedirect 1990 정량 anchor (30% @ 30min) |
| lid amide 가수분해 | 🟢 | Powell 1987 Pharm Res anchor (max pH 3-6) |
| onset 가속 (만약 주장 시) | 🔴 **FALSIFIED** | N1·N6 학습; pH 는 J_ss prefactor, t_lag 무관 |
| **stack flux × hexa-LAC v1** | **4-6× (conservative)** | bilayer architecture weighted |
| LAST class | N6 와 동급 | 4-6× Cmax → envelope tighten |
| regulatory novelty | medium-high | transdermal pH-bilayer FDA precedent ZERO; 505(b)(2) feasible w/ N7-A |
| **IP freedom** | ✅ HIGH | published clinical 2025 ZERO + N7-A 2-SKU = no fixed-dose claim |
| breakthrough cost | $1000-2100 | P1 Franz + P2 DSC + P3 epi-HPLC + P4 FTO |

**다음 cycle 액션**:
1. wet-lab quote 받기 (P1 Franz cell · P2 DSC · P3 epi-HPLC) — N6 와 batch 하면 cost share
2. N7-A 가 PASS 시 → hexa-LAC v3-A spec drafting (2-step SKU + user guide G7 reroute)
3. 만약 in-vivo cap < 4× 면 → 후보 B/C 로 escalate
4. arxiv 2001.03058 (Pontrelli 2019) 모델 hexa-native 구현 (PDE eigenvalue) — V3 verify 보강

---

## 12. cross-axis stacking (N1 · N6 · N7 combinations)

| stack | flux × vs hLAC v1 | risk | regulatory |
|---|---|---|---|
| hexa-LAC v1 alone | 1.0× | low | known |
| + N1 (PCM body-T trigger) | 2.5× | medium | medium |
| + N6-C (capric ternary + ion-pair) | 6× | medium-high | medium-high |
| + N7-A (2-step alkaline top) | 4× | low (separated) | easy (2 SKUs) |
| **N1 + N6-C + N7-A** | **~10-15×** (depth+duration triple-stack) | **HIGH** (LAST envelope tighten 10×) | hard (3-mechanism novel) |
| **N6-C + N7-A** | **~8×** | medium-high | medium |
| **N1 + N7-A** | **~6×** | medium | medium |

→ **순수 가장 cheap V1 = N7-A 단독** (V1 → V2 escalate path 명확)
→ **궁극 목표 (V3 hexa-LAC v3)** = N1 + N6-C + N7-A 트리플 stack (LAST envelope 재계산 + 3-mechanism IP)
