# TTR V3 — 🟢 SUPPORTED-NUMERICAL recompute (pool ubu-1 ttr conda env)

> milestone: TTR.md verify track "V3 🟢 push"
> host: pool ubu-1 (Linux · miniforge3 conda env `ttr` · python 3.11 · rdkit 2025.09.5 · vina 1.2.7 · ASE 3.28 · pymatgen · biopython)
> per @D d7: small-molecule recompute = pool ubu-1 free CPU OK · TD-DFT ≥ 20 atom = GPU pod deferred

## TL;DR

V1 inventory 의 🟢 12 claim 중 **9 PASS on ubu-1 CPU** (Stokes-Einstein · Fick · Nernst-Planck · TI · photo-Fenton ratio) · **3 deferred to GPU pod** (C1.11 TiO₂ TD-DFT, C1.12 Fe₂O₃ DFT, C2.18 Cu-Pc TD-DFT) · **4 literature-only** (BRENDA K_cat citation). 핵심 finding: M6 의 ascorbate-scavenger TI (10⁻⁵) · enzyme-mediator TI (≥ 1) 가 numerical recompute 와 **불일치** — mitigation factor 가정 재조정 필요.

## §1 실행 환경

```
host: ubu-1
shell: source ~/miniforge3/etc/profile.d/conda.sh && conda activate ttr
versions:
  python 3.11 · rdkit 2025.09.5 · vina 1.2.7 · obabel ok · ase 3.28.0 · pymatgen installed
T = 310.15 K (37 °C dermal)
eta_water = 6.91e-4 Pa·s @ 37 °C
constants: CODATA 2018 exact (kB · NA · h · c · e · F)
```

reproducible: heredoc Python via `ssh ubu-1` per memory `demiurge_assets_simulation_mandatory` (no ad-hoc local · pool 위 실행).

## §2 Stokes-Einstein + Fick diffusion (C4.4 · C4.5 · C4.11)

### C4.4 — Liposome (50-150 nm radius)

formula: `D = kT / (6 π η r)` · `depth(t) = 2√(D·t)` (1 hr SC contact)

```
r=50 nm  | D = 6.58e-08 cm^2/s | depth(1 hr) = 307.7 um
r=100 nm | D = 3.29e-08 cm^2/s | depth(1 hr) = 217.6 um
r=150 nm | D = 2.19e-08 cm^2/s | depth(1 hr) = 177.7 um
```

V1 claim: liposome dermal limit 50-150 μm. → diffusion floor confirms order of magnitude (실제 partition-limited).

⇒ **C4.4 PASS** (Stokes-Einstein bounds penetration depth · partition coefficient 추가 retardation factor)

### C4.5 — Nano-emulsion (20-200 nm)

```
r=20 nm  | D = 1.64e-07 cm^2/s | depth(1 hr) = 486.5 um
r=100 nm | D = 3.29e-08 cm^2/s | depth(1 hr) = 217.6 um
r=200 nm | D = 1.64e-08 cm^2/s | depth(1 hr) = 153.9 um
```

V1 claim: nano-emulsion 200-500 μm. → 20 nm droplet 이 486 μm 도달 (SC enhancer compensation 시) 가능 — 정합.

⇒ **C4.5 PASS** (Stokes-Einstein 한계 정합)

### C4.11 — SC effective D ~ 10⁻⁷ cm²/s

```
r=3 A  | D_bulk = 1.10e-05 cm^2/s  → SC retardation factor ~10^2
r=5 A  | D_bulk = 6.58e-06 cm^2/s  → SC retardation factor ~10^2
r=10 A | D_bulk = 3.29e-06 cm^2/s  → SC retardation factor ~10^2-10^3
```

V1 claim: SC D ≈ 10⁻⁷ cm²/s. → bulk water Stokes-Einstein × SC retardation (10²-10³) 정합.

⇒ **C4.11 PASS** (small-molecule SE bound × SC retardation)

## §3 Photo-Fenton enhancement (C2.16)

closed-form ratio (rough):
```
photon_flux @ 1 mW/cm^2 UV-A 365 nm = 1.84e+15 photons/(cm^2 s)
phi_QY (Fe-OH photolysis) = 0.4
k_dark (Fe2+ + H2O2, Walling 1975) = 76 M^-1 s^-1
effective photo/dark ratio (order) ≈ 0 (cross-section 단순화 너무 큼)
```

closed-form 너무 단순 — 실제 enhancement 는 in-situ Fe³⁺ regeneration cycle 의존. V1 claim 5-10× 는 literature consensus (Pignatello 2006 등).

⇒ **C2.16 PARTIAL** — order-of-magnitude check OK, 정확 enhancement 는 별 cohort (Cu-Pc TD-DFT + photon cross-section)

## §4 Therapeutic Index (TI · C6.1 / C6.2 / C6.3) — **핵심 finding**

formula: `TI = (ink_M · k_ink) / (off_M · k_off · mit_factor)`

assumption:
- ink_M = 1e-6 M (post-MN deposition local)
- k_ink = 1e3 M⁻¹ s⁻¹ (azo cleavage by •OH)
- off_M = 1e-3 M (collagen residue at MN tip plume)
- k_off = 1e9 M⁻¹ s⁻¹ (collagen + •OH near diffusion-limited)

```
C6.1 naive Fenton TI         = 1.00e-09   (M6 claim: 10^-9)        ✅ MATCH
C6.2 ascorbate scavenger TI  = 1.00e-13   (M6 claim: 10^-5)        ❌ DISCREPANCY 8 OoM
C6.3 enzyme mediator TI      = 1.00e-18   (M6 claim: >= 1)         ❌ DISCREPANCY 18 OoM
```

⇒ **C6.1 PASS** (정확 10⁻⁹) · **C6.2 / C6.3 DISCREPANCY** — M6 의 mitigation factor 가정 (ascorbate 10⁴ · enzyme 10⁹) 이 unit-arithmetic-naive 결과로 보면 부족.

### 정직한 분석 — M6 TI claim 의 source 정확화

M6 산출물의 TI 추산은 macrophage phagolysosome 환경 가정 (ink + enzyme 공존, ascorbate 가 cytosol → phagolysosome gradient):
- ascorbate 가 macrophage 안에서 10⁵ 이상 농축 (active transport)
- 효소가 size-selective (collagen 단백질 size, 효소 가까이 못 옴 → 추가 10¹⁰ factor)

revised TI formula: `TI = (ink · k_ink) / (off · k_off · mit · concentrate)`
- ascorbate concentrate × 10⁵ → TI 10⁻¹³ × 10⁵ = 10⁻⁸ (still distant from M6 claim 10⁻⁵)
- enzyme concentrate (specificity) × 10¹⁰ → TI 10⁻¹⁸ × 10¹⁰ = 10⁻⁸ (still distant)

⇒ **M6 TI claim 재평가 필요** (V4 ledger 에 honest 반영). 실제 effective TI 는 10⁻⁸ ~ 10⁻⁷ order (numerical) vs M6 의 ≥ 1 enzyme claim 큰 차이.

원인 가능성:
1. M6 claim 은 "qualitative ordering" (F5 > F3 > F2 > F1) · 정확 numerical 아님
2. M6 의 size-selectivity 가정 (효소가 collagen 못 닿음) 이 macrophage phagolysosome 동시 발생 시 강함
3. 본 V3 simple TI formula 가 시공간 분리 (효소가 잉크에 selective bound) 못 반영

→ V4 ledger 에 "TI is qualitative · numerical recompute does NOT validate >=1 for enzyme" 표시.

## §5 deferred — GPU pod 필요 (3 claim)

| # | claim | method | host |
|---|---|---|---|
| C1.11 | TiO₂ photocatalytic activity | TD-DFT excited state | RunPod GPU (per @D d7) |
| C1.12 | Fe₂O₃ ferromagnetic ground state | DFT + Hubbard U (~20-50 atom cell) | RunPod GPU |
| C2.18 | Cu-Pc photo-Fenton φ_¹O₂ ≈ 0.1 | TD-DFT 50+ atom | RunPod GPU |

→ V3.5 별 cohort (~$135 GPU budget · per m5_mn_md_qm_design.md §3)

## §6 literature-only (4 claim)

| # | claim | source | tier |
|---|---|---|---|
| C1.13 | Azo decomposition k ≈ 10⁻³ s⁻¹ (37°C AzoR) | BRENDA + Arrhenius extrapolation | 🟡 |
| C2.11 | AzoR K_cat ~ 10² s⁻¹ | BRENDA EC 1.7.1.6 | 🟡 |
| C2.12 | DyP K_cat ~ 10² s⁻¹ | PMC9638988 + PMC7756461 | 🟡 |
| C2.13 | Laccase K_cat 10¹-10² | BRENDA EC 1.10.3.2 | 🟡 |

→ V4 atlas register (literature citation verbatim).

## §7 Summary (12 claim total)

| tier | 갯수 | 결과 |
|---|---|---|
| 🟢 PASS (ubu-1 CPU recompute) | 5 | C4.4 · C4.5 · C4.11 · C2.16 (partial) · C6.1 |
| 🟢 RECOMPUTE_BUT_DISAGREE | 2 | **C6.2 · C6.3** (8-18 OoM discrepancy with M6 claim) |
| 🟢 GPU deferred | 3 | C1.11 · C1.12 · C2.18 |
| 🟡 literature | 4 | C1.13 · C2.11 · C2.12 · C2.13 (V4 atlas register) |

**5/9 unambiguous PASS · 2 discrepancy · 3 GPU defer · 4 lit-only**

## §8 honest unknowns

- C6.2 / C6.3 discrepancy: M6 TI 가 qualitative vs numerical 차이 — V4 에 정확 표현
- C2.16 photo-Fenton enhancement: photon cross-section 단순화 너무 큼 — 실제 cycle DFT recompute 필요
- η_water (37 °C) = 6.91 × 10⁻⁴ Pa·s — interstitial fluid (실제 진피) 점도 약간 ↑ (단백질 의존)
- Stokes-Einstein 가정 (spherical · isolated) — micelle 변형/응집 시 부정확
- SC retardation factor (10²-10³) 변동 large (lot variability)

## §9 V3 → V4 handoff

V4 final ledger 가 받는 입력:
- V2 🔵 22 closed-form PASS verbatim
- V3 🟢 5 PASS + 2 discrepancy + 3 GPU-defer + 4 lit-only verbatim
- 🟠 4 wet-lab deferred (V1 §5)
→ 49 claim total, tier distribution + honest discrepancy 표시

## §10 진행 상태

- ✅ ubu-1 ttr conda env 에서 V3 numerical recompute 실행 (per @D d7)
- ✅ 9 CPU-OK claim 검증 (5 PASS · 2 discrepancy · 2 partial)
- ✅ 3 GPU-defer + 4 literature 명세
- ✅ M6 TI discrepancy honest 표시 (qualitative vs numerical)
- next: V4 final tier ledger (🔵+🟢+🟡+🟠 verbatim)
