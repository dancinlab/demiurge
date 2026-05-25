# NUCLEAR — Nuclear Discovery Simulation Stack (5-gate · N6–N10 cohorts)

@goal: Rank top-K candidate nuclides (superheavy Z>118 + drip-line) via a 5-gate a-e sim funnel for accelerator beam-time priority — absorbed=false 영구; sim PASS = wet-lab priority hint, never a discovery claim

> Sibling of `RTSC.md` §9 (compositional discovery — *new SC material*). NUCLEAR.md target = *elemental discovery* — superheavy / drip-line **nuclides**. Same R4 invariant family (`absorbed=false` 영구 · prediction never claims measurement).

---

## §1. Goal

Build a 5-gate simulation funnel that **proposes top-K candidate nuclides** (superheavy `Z > 118` + neutron-rich / proton-rich drip-line) for accelerator beam-time priority. The stack:

- **CAN**: predict mass + binding energy (HFB) · deformation (RMF) · α-decay half-life (WKB cluster) · drip-line for light nuclei (ab-initio NCSM / CCSD / IM-SRG) · shell-model spectroscopy (KSHELL / BIGSTICK).
- **CANNOT**: synthesize a new atom (needs GSI / JINR / RIKEN heavy-ion accelerator beam-time) · detect it (needs SHIP / DGFRS / GARIS recoil separator + measurement chain).

R4 invariant — every nuclear record carries `gate_type = nuclear-novel-discovery-simulation` + `absorbed = false 영구`. Sim PASS = "this nuclide is worth wet-lab priority", NOT "this nuclide exists".

> ⚠️ **"5-gate" 는 a–e *coverage 분류* 라벨이지 수치 composite 의 span 이 아니다.** N11 의 실제 rank 는 (c)-gate (α⊕SF 반감기) × island_weight 단독으로 계산된다 — (a) 는 입력 일부(Q_α)·install-gated, (b) install-gated, (d)(e) wet-lab 영구의존 → rank 기여 0. 상세 §2.2.

Mirror of RTSC §9 (compositional) for elemental:

| stack          | discovery axis              | g3 honest verdict on `absorbed=true` |
|----------------|------------------------------|----------------------------------------|
| RTSC §9        | new SC composition (a)(b)(c) | impossible from sim alone (§8.9)       |
| NUCLEAR (this) | new nuclide (a)(b)(c) → (d)(e) wet-lab | impossible from sim alone (§3 below)   |

### §1.1 Relation to RTSC §9.12 hydride DFT (separate scope · shared formalism class)

NUCLEAR and RTSC.md §9.12 both invoke "DFT" but at **different physics scales** — keep them in distinct homes:

| dimension | NUCLEAR (this doc · §4 N6) | RTSC.md §9.12 hydride el-ph |
|---|---|---|
| physics | strong nuclear force · proton/neutron wavefunctions in the nucleus | electromagnetic · electron wavefunctions in a periodic lattice |
| DFT-class | **nuclear HFB-DFT** (Skyrme / Gogny / RMF functionals · HFBTHO · HFODD · BSk family) | **solid-state Kohn-Sham DFT** (QE pw.x · plane-wave + PAW pseudopotentials) |
| observable | mass · binding energy · deformation · α/β/SF half-life | electronic band structure · electron-phonon coupling λ · Allen-Dynes Tc |
| convergence axis | functional family spread (BSk22/24/27 · UNEDF) · single-particle basis (HO Nmax / harmonic-oscillator truncation) | k-grid (24³ for H3S baseline) · q-grid (6³ baseline · q-grid + anharmonicity = dominant remaining under-convergence) |
| compute (@D d8) | small/medium nuclei (A < 200) → **pool ubu-1** · batch SHE sweep → **Vast.ai** | small unit cells (4-14 atoms) → **pool ubu-1** · same routing |
| record-side | `gate_type = nuclear-novel-discovery-simulation` (NUCLEAR.md §3.1) | `gate_type = simulation-only-prediction` (RTSC.md §8.7 Tier 1) |
| R4 verdict | absorbed=false 영구 (needs accelerator beam-time) | absorbed=false 영구 (needs lab synthesis + Tc measurement) |

Both share `@D d6` (measured-oracle invariant) · `@D d7` (first-principles ML-wall breakthrough · grid-converged values) · `@D d8` (compute sizing). The governance is **single SSOT in `project.tape`** — no separate "DFT.md" needed (would be doc bloat). Each stack is the *application instance* of the shared governance, not a sub-doc.

---

## §2. 5-gate nuclear taxonomy

Mirror of RTSC §9.7 (a–e). Honest verdict per gate identical in shape: (a)(b)(c) sim-sufficient · (d)(e) wet-lab dependent permanently.

| gate | content | sim coverage | wet-lab dependence |
|------|---------|--------------|--------------------|
| **(a)** | Nuclear structure — mass + binding energy + deformation `(Z, N)` | HFB / RMF / FRDM mass-table inputs → DFT-of-nucleus predict | sim sufficient · ±0.5–1.5 MeV typical |
| **(b)** | Spectroscopic structure — shell-model level structure, B(E2), B(M1) | KSHELL / NuShellX / BIGSTICK / ANTOINE Lanczos | sim sufficient for valence-space tractable cases |
| **(c)** | Decay channels — α / β / spontaneous-fission half-life | WKB cluster model + Geiger-Nuttall + UNEDF predictors | sim sufficient · scatter 10× typical |
| **(d)** | Production cross-section for SHE synthesis (fusion-evaporation σ) | HIVAP / DNS / KEWPIE2 / NRV channels | ★ **WET-LAB DEPENDENT** — sim gives σ within ~10× of experiment, never alone confirms |
| **(e)** | Detection signature — SHIP / DGFRS / GARIS analysis | (no honest sim — the recoil-separator beam-line IS the measurement) | ★ **WET-LAB DEPENDENT** — sim NEVER substitutes for accelerator beam-time |

### §2.1 Gate verdict honest table (mirror RTSC §9.6)

| gate     | sim PASS 의 의미                                                         |
|----------|---------------------------------------------------------------------------|
| (a) PASS | HFB predicts bound state with reasonable Sn / Sp → *not yet observed atom* |
| (b) PASS | shell model predicts low-lying level structure → spectroscopy *prediction* |
| (c) PASS | T₁/₂ predicted ∈ μs-ms range (SHE) or longer (drip-line) → *prediction*    |
| (d) PASS | σ ≥ 1 pb @ optimal projectile-target combo → *accelerator priority hint*   |
| (e) PASS | (gate (e) has no meaningful sim PASS — only wet-lab)                       |

→ 5-gate **sim** PASS → `gate_type = nuclear-novel-discovery-simulation` · `absorbed = false 영구`. R4 invariant identical to RTSC §9 form.

### §2.2 composite score 의 실제 axis-coverage (g3 honesty · /gap F8)

⚠️ **"5-gate" 는 *coverage 분류*이지 composite 가중이 아니다.** 현 N11 composite score = **(c)-gate (α⊕SF 반감기) × island_weight 단독**:

| gate | composite 기여 | 사유 |
|------|----------------|------|
| (a) mass | 입력 일부 (Q_α) — 직접 rank 기여 0 | HFB mass 는 install-gated (§3.3) · Q_α 만 N7 로 chain |
| (b) spectroscopy | 0 | N9 install-gated · composite 미참여 |
| (c) decay (α⊕SF) | **유일한 수치 axis** × island_weight | closed-form (libm-only) · 설치 불요 |
| (d) fusion-σ | 0 | wet-lab 영구의존 (§3.2) · out-of-scope |
| (e) detection | 0 | wet-lab 영구의존 (§3.2) · sim PASS 없음 |

즉 §2 의 5-gate taxonomy 는 honest *coverage map* 이며 그대로 유지하나, composite rank 가 5-gate 를 span 한다는 함의는 사실이 아니다 — (c) 단독이다.

---

## §3. Honest invariants (g3 — non-negotiable)

### §3.0 Cross-cutting governance (project.tape — apply to nuclear stack too)

- **`@D d6`** (measured-oracle invariant · **4-carrier audit COMPLETE** as of κ-71 G41 D122) — `absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true`. For nuclear records this is *permanent absorbed=false* (§3.1 below · no measured-oracle path exists without accelerator beam-time). The invariant is record-type-agnostic by construction (4 record types audited: Energy/solar · Aura/EEG · Ufo/plasma · Energy/wind · 0 invariant-helper code change) — when a `NuclearVerifyRecord` is ever added it auto-extends.
- **`@D d7`** (first-principles physics breaks ML-wall · grid-converged values only) — drive HFB-DFT mass / decay predictions to converged values; label under-converged regions honestly (e.g., AME2020-fit BSk-family vs UNEDF cross-functional spread is the equivalent of RTSC §9.12 H3S 16³-k 1.15 → 24³-k 0.85 broadening-stable correction); **never force a target number** (the "Z=126 island of stability" claim is a *prediction with cited uncertainty*, never "Z=126 found").
- **`@D d8`** (compute sizing) — N6 HFBTHO on small/medium nuclei (A < 200) routes to **pool ubu-1:aiden** (auth restored 2026-05-22 · QE 7.5 confirmed; HFBTHO install path is `_INSTALL_HINTS["hfbtho"]` per `hfbtho_adapter.py` · install pending). Batch screening of (Z, N) sweeps (N11 funnel · §6 deferred Phase 6) routes to **Vast.ai CPU spot market** (per d8 spec). GPU pod considered only for SHE multi-cluster relativistic calculations (≥ 20 cluster atoms with relativistic corrections, e.g., DD-RHB). HFB SCF on a single nuclide remains anti-pattern carve-out (don't port to hexa-native).
- **`@D d2`** (Pattern 2 invariant verbal form) — never say "Z=126 발견 불가능" / "drip-line 도달 불가능"; the stack is *prediction-only* but breakthrough paths (next-generation accelerators · neutron-rich beam factories · ab-initio reach extending into heavy nuclei) stay surfaced. Out-of-scope ≠ impossible.

### §3.1 R4 carry over from RTSC

Identical wording to RTSC §9.10 N5 g3:
- **`absorbed=false 영구`** — no nuclear record EVER flips to `absorbed=true`. That promotion requires GSI / JINR / RIKEN heavy-ion accelerator beam-time + SHIP-class separator detection + decay-chain identification. OUT OF SCOPE for this stack.
- **`gate_type=nuclear-novel-discovery-simulation`** — new shape value (mirror of RTSC §9.10 N5 `novel-discovery-simulation`).
- **"가능성" ≠ "임"** — record headlines must read "Z=119 후보일 가능성" never "Z=119 후보임" or "Z=119 발견됨". RTSC §8.10 LK-99 / Nb attestation honest-correction pattern.

### §3.2 (d)(e) wet-lab dependency — permanent

Even if (a)(b)(c) all PASS:
- (d) σ-prediction can be off by 10× — fusion-evaporation cross-section is famously hard (HIVAP statistical model, DNS dinuclear-system model, KEWPIE2 — each ~10× scatter is common).
- (e) detection involves recoil-separator efficiency, GSI/JINR's actual implant pad, alpha-decay chain verification, time-of-flight discrimination — *physical hardware*. No sim model substitutes.

→ NUCLEAR stack output is **a ranked top-K nuclide candidate list for accelerator priority**, not a discovery claim.

### §3.3 No fabrication

If HFBTHO / KSHELL / KEWPIE2 binaries are not available on the host:
- **`install-gated` is the PASS verdict** (mirror RTSC §9.9.1 Phase 1 wrap-as-is — *honest skip is acceptable first-land*).
- Don't invent numerical results. Don't synthesize plausible-sounding mass tables. Citation rigor: every record emits `citations: [arxiv:..., NSDC link, paper DOI]`.

### §3.4 Half-life threshold caveat → SHE→RTSC bulk-solid bridge 평결 (cross-stack)

- Z > 118 superheavy 반감기는 통상 μs–ms (Og 0.7 ms · Ts ~50 ms · Mc ~150 ms · 예측 Z=119/120 유사 μs–ms). island-of-stability 낙관 모델은 일부 미합성 핵종(²⁹⁸Fl·²⁹⁶Cn 등)에 수백~수천 년 수명을 *예측*하나 — 0개 합성됨 (N=184 영역 현 빔 도달 불가 · @D d7 "예측 ≠ 발견").
- **binding constraint 는 반감기가 아니라 생산량이다.** 가장 짧은 SHE 수명(Og 0.7 ms)조차 결정 핵생성 시간(MD ~ns)을 6 자릿수 초과 — 시간상 격자 형성은 가능. 진짜 벽: SHE 는 one-atom-at-a-time, 통산 <20 원자, Og ~1 atom/month 로만 생산되고 각자 ms 내 붕괴 → RTSC bulk/Tc 측정에 필요한 ~10¹⁵–10²² 원자를 동시에 모으는 것과 10¹⁵+ 배 격차.
- **single-atom 예외 (honest)**: SHE *화학* 은 실재하는 진짜 과학이나 single-atom 상대론적 기체상 화학(thermochromatography 흡착 엔탈피·휘발성, Cn·Fl·Nh·Mc)이지 bulk 초전도가 아니다 — 초전도는 many-body collective 현상으로 원자 1개에 Tc 가 정의되지 않으며 RTSC §8.9 의 어떤 gate(특히 bulk 측정 (b))도 못 채운다.
- **isomer 체크**: 장수명 isomer(¹⁸⁰ᵐTa T½>2.9×10¹⁷ yr · ¹⁷⁸ᵐ²Hf 31 yr)는 모두 Ta·Hf 같은 일상 원소 — 이미 bulk 결정, SHE 아님. SHE isomer 가 수명을 늘려도 생산량 축은 불변 → 평결 안 바뀜.
- **평결**: SHE/장수명 isomer → RTSC bulk-solid bridge **없음 (NO)**. 두 스택(RTSC=조성 · NUCLEAR=원소)은 같은 R4 family 의 *parallel funnel*, 물질 공급 경로로 통합 안 됨. ⚠️ flat "불가능" 아님 — 평결을 바꾸는 단일 트리거 = *분(min) 단위 수명 island-of-stability 핵종의 거시량 생산*; 이는 차세대 neutron-rich beam factory(FRIB급+)와 cross-section ~pb→거시량 10¹⁵배 생산률 도약이라는 이중 천문학적 전제를 요구. 상세 bracket: `exports/nuclear_discovery/bridge/2026-05-25-nuclear-rtsc-bridge.md`.

### §3.5 Citation rigor (R4 protection)

Every cohort record emits:
- `citations: [arxiv:..., NSDC link, paper DOI]`
- `provenance.primary_refs` — at least one peer-reviewed reference per claim.
- `scope_caveats` — at least 3 lines including (i) sim ≠ measurement, (ii) 5-gate evaluation incompleteness, (iii) backend-specific limitations.

---

## §4. Cohort spec (N6 – N10)

Numbering continues from RTSC §9 (N1–N5). Mirror of RTSC §9.7 4-cohort + §9.10 N5 pattern.

| cohort  | role                                                | external lib candidates                                              | path        |
|---------|------------------------------------------------------|------------------------------------------------------------------------|-------------|
| **N6**  | Nuclear mass + binding energy + deformation `(Z,N)` | HFBTHO (Skyrme HFB) · HFODD · UNEDF · BSk22/24/27 · FRDM2012           | B (wrap-as-is) |
| **N7**  | α-decay · spontaneous fission · β-decay half-life   | WKB cluster (closed-form, libm-only) · Geiger-Nuttall · UNEDF half-life | A candidate (small closed-form kernel) |
| **N8**  | Fusion-evaporation σ for SHE synthesis              | HIVAP · DNS · KEWPIE2 · NRV                                            | B (wrap-as-is) |
| **N9**  | Shell-model spectroscopy (B(E2), B(M1), levels)     | KSHELL · NuShellX@MSU · BIGSTICK · ANTOINE                             | B (wrap-as-is) |
| **N10** | Ab-initio drip-line (light nuclei)                  | NCSM · CCSD · IM-SRG · symplectic NCSM                                 | B (wrap-as-is) |

### §4.1 N6 — HFB mass + binding energy + deformation

- **Primary backend**: HFBTHO 3.00+ — Skyrme HFB axially deformed, Fortran 95, open-source.
- **Cited cross-validation**: BSk22/24/27 (Goriely et al.) functional family — 8 multi-functional outputs for σ-spread estimation (mirror of N4 cross-code DFT pattern from RTSC §9.4).
- **Reference table fallback**: FRDM2012 (Möller-Nix 2012) — openly cited mass table covering Z=8–110, N=8–250.
- **Input**: `(Z, N)` pair (or list for batch).
- **Output**: mass excess (MeV) · binding energy per nucleon · β2 (quadrupole) · β4 (hexadecapole) deformation · 2-σ uncertainty band.

### §4.2 N7 — α / β / SF half-life

- **Primary form**: WKB cluster model (Gamow penetrability + preformation factor). Small closed-form kernel — Path A candidate after wrap-stabilization (Phase 4 of RTSC §9.9.1 schedule).
- **Cited form**: Geiger-Nuttall log T₁/₂ = a·Q_α^{-1/2} + b — empirical 2-parameter fit (Royer, Viola-Seaborg variants).
- **UNEDF half-life predictors**: density-dependent cluster model (DDCM) by Royer / Ren / Xu — published parameter tables, no install.
- **Input**: `(Z, N, Q_α)` — Q_α from N6 mass output (chained).
- **Output**: log T₁/₂ (s) · α-branching ratio prediction · honest spread vs. published Geiger-Nuttall scatter.
- **C1 SF-competition (2026-05-25 · NOVEL probe pick · hexa-lang #928)**: the (c)-gate is NO LONGER α-only. `sf_log10_t(Z,A)` (Ren-Xu 2005 phenomenological SF systematics — C. Xu & Z. Ren, PRC 71, 014309 (2005); coefficients C1=-548.825021 C2=-5.359139 C3=0.767379 C4=-4.282220, ν seniority 0 even-even / 2 else; reproduced verbatim in Kiren+ 2013 arxiv:1301.1767 Eq.2.4) + `total_halflife(L_α,L_sf)` partial-rate combiner → `DecayTotal { log10_T_total, alpha/sf_branching, sf_dominates }`. For Z≥104 SF often dominates, so the prior α-only T₁/₂ OVERESTIMATED total survival; `c_gate_total_cell` now returns the honest α⊕SF total (Og-294 anchor: α-only log10 T=-2.93 → α⊕SF -3.20, b_α≈0.48 — α-only DID overestimate). Honest limits: SF scatter ±2-3 dex > α; **odd-A hindrance + shape-isomers NOT modeled → odd-A composite unreliable this regime** (Ren-Xu ν=2 over-predicts odd-A SF; real Lv-293/Fl-289 are α-dominant); SF dominance = priority-down-weight PREDICTION, never "this nuclide cannot exist" (@D d2 · §3.4). `sf_log10_t --expr` shows 🔴 at engine float-floor (|Δ|≈6.7e-7 · same as landed VS/Royer atoms · far inside SF physical scatter); combiner atoms 🟢 full f64. absorbed=false 영구.
- **formula-ensemble 비대칭 (honest · /gap F4)**: α-decay 는 **2-formula 앙상블** (Viola-Seaborg + Royer · NC3 consensus 로 spread 표출)이나, SF (C1) 은 **Ren-Xu 2005 단일 formula · spread 없음**. 현재 허용 가능한 이유 = SF 의 물리적 scatter (±2-3 dex) 가 α (≪ 1 dex) 를 압도 → 단일-formula 의 model-spread 누락이 SF 고유 scatter 에 묻힌다 (α 처럼 앙상블이 분별력을 주지 못함). 2번째 published SF formula (예: Denisov-Khudenko 2009) 추가는 future work — 단, §3.3 에 따라 **verbatim-cite (계수 그대로 인용) 必, re-derive 금지** (재유도 = mis-cite).
- **GAP-fix A G1/G2 (2026-05-25 · sim.hexa v0.6.0 · hexa-lang #936/#938)**: (G1) `_anz_reason(Z,N,A,Q_α)` 가 비일관 triple (A≠Z+N · Z,N≤0 · 비유한/≤0 Q_α · Z>130 transpose) 을 compute 前 honest reason code 로 차단 — 전치 (Z,N) 이 log10 T 를 ~10× 뒤집던 silent-failure 제거; `n11_{alpha,island}_cell_checked` = 검증 진입점. (G2) `consensus_alpha` 가 `outlier_count` + `robust_mean` (leave-one-out 3·peer-spread Byzantine 가드 · n≥3 활성) 보고 + per-cell `model_validity_flag` (nominal/odd-A/out-of-domain) — Lv-293·Fl-289 붕괴가 이제 odd-A 플래그로 "진짜 SF 우세"와 구분됨.
- **Round-2 A SF physics (2026-05-25 · sim.hexa v0.8.0 · hexa-lang #949/#953)**: (c)-gate SF 채널 물리 보정. **C3** Hoffman 1993 (UCRL-JC-115794) odd-A/odd-odd SF hindrance (log HF 5/10) → `sf_log10_t_hindered` + Ren-Xu 도메인 가드 (Z≥114 & SF가 α보다 3 dex 아래 ⇒ SF 드롭 · `sf_model_invalid` 플래그 · α-only total) → 측정 α-우세 앵커 Lv-293 (composite 0.0→0.433) · Fl-289 (0.0→0.170) 복구 (round-1 Ren-Xu ν=2 외삽 artifact 제거). **C4** 2nd SF 공식 Zdeb-Warda-Pomorski 2013 (PRC 87 024308 · F(Z)+parity · δM 생략=보수적 short-T_SF bound) + `sf_consensus` → SF 도 α (VS·Royer) 처럼 2-공식 spread (단 SF가 더 넓음 ±2-3 dex). 검증: in-code 수치 self-check (cited 계수 일치) — `hexa verify --expr` 아톰 등록은 후속 (g5). absorbed=false 영구; SF dominance = flagged PREDICTION (@D d2).
- **Round-2 B 대량 패리티 (2026-05-25 · hexa-lang #955)**: α-커널을 85개 측정 α-방출체 (NUBASE2020/AME2020 IAEA NSDC 라이브 · Z 60-118)로 검증 — 손-앵커 2개→85. **설계 도메인(even-even Z≥83) RMS 0.35 dex·bias~0**, SHE(Z≥104) 0.61 dex, **odd-A 1.31 dex·-1.01 bias** (parity-평균 계수의 odd-A hindrance 누락 → G2 `model_validity_flag=odd-A` 셀 down-weight 정당화). 체계적 -0.56 dex 과소예측. 최대 이상치 ²⁰⁹Bi (-4.0 dex·준안정·피팅 도메인 밖). VALIDATION이지 prediction 아님 · absorbed=false. caveat: SHE 12셀 다수 Q_α=systematics (부분 순환). 리포트: `exports/nuclear_discovery/validation/2026-05-25-nubase-parity.md`.

### §4.3 N8 — fusion-evaporation cross-section

- **Backends**: HIVAP (statistical evaporation model) · DNS (dinuclear system, Adamian/Antonenko) · KEWPIE2 (Vance/Hagino) · NRV web-resource (atomic-data.jinr.ru/NRV).
- **★ Wet-lab dependent gate**: σ prediction is famously off by 10× — sim gives accelerator priority hint, NEVER confirmation.
- **Input**: `(Z_proj, A_proj, Z_target, A_target, E_lab)` quintuple.
- **Output**: σ (pb or fb) for evaporation channels (1n, 2n, 3n, 4n, 5n, αxn) · honest 10× scatter caveat.

### §4.4 N9 — shell-model spectroscopy

- **Backends**: KSHELL (Shimizu, Lanczos) · NuShellX@MSU (Brown) · BIGSTICK (Johnson, OpenMP/MPI) · ANTOINE (Caurier, original).
- **Massive numerical infrastructure** — `_setup/` install footprint typically 1–10 GB.
- **Input**: `(Z, N)` + valence space (e.g., `pf-shell`, `sd-shell`, `sdpfm`) + interaction (USDA/USDB/KB3G/GXPF1).
- **Output**: low-lying level energies (MeV) · B(E2) (e²fm⁴) · B(M1) (μ_N²) · 2-σ band from cross-interaction comparison.

### §4.5 N10 — ab-initio drip-line (light nuclei)

- **Backends**: NCSM (Navratil/Barrett No-Core Shell Model) · CCSD (Hagen/Papenbrock coupled cluster) · IM-SRG (Hergert/Bogner in-medium SRG) · symplectic NCSM.
- **Scope**: A ≤ 30 (NCSM/CCSD basis explosion) — proton drip-line + neutron drip-line for light elements.
- **Input**: `(Z, N)`, A ≤ 30 nominally.
- **Output**: ground-state energy (MeV) · proton/neutron separation energies Sp/Sn · drip-line flag (Sp < 0 or Sn < 0).

---

## §5. External library survey

### §5.1 N6 — mass / structure

| tool | algorithm | license | source |
|------|-----------|---------|--------|
| **HFBTHO** | Axially deformed Skyrme HFB | open-source | https://gitlab.com/hfbtho/hfbtho · github mirror |
| **HFODD** | Triaxial Skyrme HFB (more general) | open-source | github.com/skyrme-hfb/hfodd |
| **UNEDF** | Universal Nuclear Energy Density Functional | open results | unedf.mps.ohio-state.edu (legacy URL) |
| **BSk22/24/27** | Brussels-Skyrme functional family (Goriely/Chamel/Pearson) | published tables | arxiv:1607.06961 (BSk32 release) |
| **FRDM2012** | Finite-Range Droplet Model (Möller, Nix) | published table | arxiv:1508.06294 (release paper) |

### §5.2 N7 — half-life

| tool | form | source |
|------|------|--------|
| WKB cluster (closed-form) | Gamow penetrability × preformation factor | libm-only ~50–100 LOC kernel |
| Geiger-Nuttall (Royer 2000) | log T₁/₂ = a·Q^{-1/2} + b | published parameters |
| Viola-Seaborg | same shape, different params | published |
| UNEDF half-life (Goriely et al.) | density-dependent cluster | published tables |

### §5.3 N8 — fusion-evaporation

| tool | model | source |
|------|-------|--------|
| **HIVAP** | statistical evaporation (Reisdorf) | request from authors; legacy Fortran |
| **DNS** | dinuclear system (Adamian/Antonenko) | publications + Dubna codes |
| **KEWPIE2** | Vance/Hagino | github.com/kewpie2 |
| **NRV** | JINR atomic-data nuclear reactions video | http://nrv.jinr.ru/nrv/ (web) |

### §5.4 N9 — shell model

| tool | core | source |
|------|------|--------|
| **KSHELL** | Shimizu Lanczos | https://sites.google.com/alumni.tsukuba.ac.jp/kshell-nuclear |
| **NuShellX@MSU** | Brown | https://people.frib.msu.edu/~brown/resources/resources.html |
| **BIGSTICK** | Johnson, OpenMP/MPI | https://github.com/cwjsdsu/BigstickPublick |
| **ANTOINE** | Caurier (legacy) | http://www.iphc.cnrs.fr/nutheo/code_antoine/ |

### §5.5 N10 — ab-initio

| tool | method | source |
|------|--------|--------|
| **NCSM** | No-Core Shell Model | Navratil's group · published parameters |
| **CCSD / CCSDT** | coupled cluster | Hagen/Papenbrock (ORNL) |
| **IM-SRG** | in-medium SRG | Hergert/Bogner (MSU) |
| **symplectic NCSM** | Sp(3,R) basis | Dytrych/Draayer (LSU) |

### §5.6 Data corpora (cross-validation)

- **IAEA NSDC** — `nds.iaea.org/relnsd/` (live evaluated nuclear data)
- **AME 2020** (Wang/Audi/Kondev) — `https://www-nds.iaea.org/amdc/` (mass evaluation tables)
- **NUBASE 2020** — half-life + decay-mode evaluation companion to AME
- **JINR NRV** — `http://nrv.jinr.ru/nrv/` (low-energy nuclear reactions video)

---

## §6. Phase 1 land target

Mirror of RTSC §9.9.1 Phase 1 wrap-as-is — single-cohort first-land, then sweep.

### §6.1 N6 first (HFBTHO wrap)

**Rationale**: HFBTHO is the most-mature open-source HFB binary · BSk22/24/27 cross-validation reference table is openly cited · matches RTSC §9 N4 cross-code DFT pattern (sim_adapter → mp_query → csp_adapter shape) closest.

> **Infrastructure cross-link (2026-05-22 update)**: HFBTHO is a Fortran 95 binary — install-gated on macOS arm64 historically; Linux pool hosts (`ubu-1` / `ubu-2`) more tractable. **pool ubu-1 (aiden user · 6c Ryzen 9600X · 27GB RAM · QE 7.5 conda env confirmed) auth RESTORED 2026-05-22** ([[reference-qe-dft-pool-setup]] · `~/core/pool/inbox/troubleshooting/2026-05-22-ubu-1-publickey-denied.md` RESOLVED footer) — HFBTHO install on ubu-1 unblocked. The RTSC §9.12 hydride DFT extension is using the same ubu-1 baseline RIGHT NOW (QE pw.x/ph.x · `~/qe_runs/cah6/` etc. · per @D d8 small-cell pool routing). HFBTHO install on ubu-1 is the natural N6 phase-2 substrate (different software · same compute host · share queue discipline). Promotion to first-class `pool` routing (mirror of RTSC §9.9.1 N4 `_pool_cli_present` precedent) tracked in `POOL.md` §4.2 + `~/core/pool/inbox/requests/2026-05-22-session-feature-requests.md` #1 (per-host user+key config · landing this resolves `pool on ubu-1` ad-hoc to `aiden` automatically). Current Phase 1 honest skip path (`install-gated` / `weights-missing` / `network-fail`) holds until HFBTHO+BSk install on ubu-1 actually happens (separate session).

**Adapter**: `hexa-lang/stdlib/nuclear/hfbtho_adapter.py`

**Honest skip paths** (mirror RTSC §9.9.1 Phase 1):
1. **`install-gated`** — HFBTHO binary not on PATH and `$HFBTHO_BIN` env var unset. Skip with install hint.
2. **`weights-missing`** — BSk parameter files (`.dat`) not in `$HFBTHO_PARAM_DIR`. Skip with download hint (Brussels-Nuclear-Library URL).
3. **`network-fail`** — IAEA NSDC AME2020 fetch failed (offline / endpoint down). Skip; record retains `gate_type=install-gated` to surface honesty.

**CLI**:
```
python3 stdlib/nuclear/hfbtho_adapter.py <Z> <N> <out_dir>
```

**Output**: `exports/nuclear_discovery/<run_stamp>/n6_<Z>_<N>.json`

**Record schema**:
```
{
  "domain": "nuclear",
  "verb": "verify",
  "kind": "hfb_mass_prediction",
  "gate_type": "nuclear-novel-discovery-simulation" | "install-gated",
  "absorbed": false,
  "provisional": true,
  "query": { "Z": ..., "N": ... },
  "backend_probe": { ... },
  "scope_caveats": [...],
  "citations": [...],
  ...
}
```

> **G3 top-K 확장 schema (2026-05-25 · sim.hexa v0.6.0 · hexa-lang #939)**: `top_k_she.json` (producer `sim.hexa@nuclear-N11-G3`) 가 record 에 `predicted_input: bool` · `Q_alpha_band_MeV` · `Q_alpha_source="PREDICTED via <arxiv:...>, NOT measured"` · `valid`+`guard_reason`(G1) · `scores.model_validity_flag`(G2) 추가. 리서치노트 §3 의 cited PREDICTED Q_α band 중앙값으로 Z=119/120 언락 → 랭킹 Og-294 0.242 > **²⁹⁵119 0.0462** > **²⁹⁷120 0.0306** > **²⁹³119 0.0017** > 295-120/Lv-293/Fl-289 (0.0). honest-skip: 293-120 · 298-120 · Z=121/122 (cited Q_α 없음 · @D d2). `absorbed=false 영구`; predicted-input ≠ measurement.

> **G4 predicted-only novel view (2026-05-25 · sim.hexa v0.9.0 · hexa-lang #956)**: `top_k_novel.json` = `predicted_input=true` 셀만 (신규 Z=119/120 발견 후보), composite 내림차순 — 기지 앵커(Lv-293/Og-294/Fl-289) 제외하여 가속기 *발견* 우선순위를 깔끔히 표출. 전체 `top_k_she.json`은 유지 (순수 추가). 랭킹: 295-119 0.0462 > 297-120 0.0306 > 293-119 0.0017 > 295-120 0.0. 전부 `absorbed=false` · "후보일 가능성"≠"발견됨" (@D d2). 회귀 가드: `test/nuclear_r4_anchor_smoke.hexa` (#959) · SF 커널이 이제 `hexa verify --expr` 아톰 (#960 · sf_log10_t_hindered/zwp/sf_consensus 🟢).

### §6.2 Phase 2+ deferred

- **N7 WKB** small closed-form kernel — same session if budget allows, else next session.
- **N8 / N9 / N10** wraps — separate sessions (each external lib install audit non-trivial).
- **N6–N10 stabilization audit** — mirror RTSC §9.9.1 Phase 2 (4-baseline × 5-cohort sanity matrix). Baseline candidates: Z=118 Oganesson (known), Z=119 (predicted SHE), Z=120 (predicted SHE), drip-line ⁸B (proton), drip-line ²⁴O (neutron).
- **N11 funnel cohort** — mirror RTSC §9.10 N5 compositional-explorer for nuclides: enumerate `(Z, N)` candidate space, rank by (a)(b)(c) composite score, emit top-K accelerator priority list.

### §6.3 Phase progress (2026-05-22 update · mirror RTSC §9.9.1 Phase progress table · D116 demiurge=pointer)

| Phase | 상태 | hexa-lang SSOT | demiurge pointer |
|---|---|---|---|
| Phase 1 (N6 + N7 wrap-as-is land) | ✅ **LANDED** | hexa-lang `nuclear-discovery-phase1` · `stdlib/nuclear/{hfbtho_adapter,wkb_alpha_decay}.py` | `archive/session-notes/2026-05-22-nuclear-discovery-system-launch.md` |
| Phase 2 (5-baseline × 2-cohort = 10-cell stabilization audit) | ✅ **LANDED** · 10/10 PASS · 0 absorbed=true · 8 install-gated + 2 simulation (²³⁸U + ²⁹⁴Og) · ²⁹⁴Og anchor reproduced (-2.93±0.22 dex vs obs -3.15) · ²³⁸U +0.30 dex deviation honest (low-Q_α calibration edge) | (audit only) | `archive/session-notes/2026-05-22-nuclear-9-phase2-stabilization.md` |
| Phase 3 (microkernel identification audit · N6+N7) | ✅ **LANDED** (rolled into Phase 2 audit §7) · NC1 (`_viola_seaborg_log10_t`) · NC2 (`_royer_log10_t`) · NC3 (`_consensus`) — all in N7 · N6 = 0 candidates (HFB SCF anti-pattern carve-out) | (audit only) | `archive/session-notes/2026-05-22-nuclear-9-phase2-stabilization.md` §7 |
| Phase 4 #1 (Path A microkernel port · NP1 bundle = NC1+NC2+NC3) | ✅ **LANDED** · 250 LOC actual · `stdlib/nuclear/sim.hexa` v0.1.0 (new module · mirror of `stdlib/material/sim.hexa` v0.2.0) · **31/31 parity PASS** · all rel_err=0.0 IEEE 754 bit-for-bit · ²³⁸U + ²⁹⁴Og Phase 2 anchors reproduced verbatim (regression=0) · NC3 dedicated struct (Option B · MIRROR comment to material/sim.hexa Consensus) | hexa-lang `bf16ebdd` (`stdlib/nuclear/sim.hexa` v0.1.0) | `archive/session-notes/2026-05-22-nuclear-phase4-1-parity-verify.md` |
| Phase 5 (N8/N9/N10 wrap land) | ✅ **LANDED** · 3-PR stack · 6 honest-skip 경로 (install-gated = PASS per §3.3) · 0 absorbed=true · N8 σ ~10× scatter caveat + "accelerator priority hint, never confirmation" (gate d wet-lab dependent) · N9 weights-missing (interaction .snt/.int) · N10 weights-missing (chiral-EFT ME) + A≤30 soft-ceiling flag (out-of-scope≠impossible · @D d2) | hexa-lang `4c10eed6` · `stdlib/nuclear/{n8_fusion_evap,n9_shell_model,n10_abinitio}_adapter.py` · PR #907/#913/#917 | `archive/session-notes/` |
| Phase 6 (N11 funnel cohort · mirror RTSC §9.10) | ✅ **LANDED** · `sim.hexa` v0.2.0 N11 (`c_gate_window_score` + `n11_alpha_cell` chaining NC1/NC2/NC3) · top-K JSON (NUCLEAR.md §6.1 schema) · cited-Q_α SHE shortlist Lv-293 > Og-294 > Fl-289 (c_gate 0.836/0.682/0.456) · Z=119–122 honest-skip install-gated (§3.3 no Q_α fabrication) · N7 kernels verify-registered → 2/2 🟢 SUPPORTED-NUMERICAL (\|Δ\|=0.0) · Og-294 anchor regression=0 | hexa-lang `cdb24cfe` (PR #914 · `stdlib/nuclear/sim.hexa` v0.2.0 + `tool/verify_cli.hexa`) | `exports/nuclear_discovery/n11_funnel/<stamp>/top_k.json` |

#### §6.3.1 island_weight(Z,N,σ) 가정 표면화 (g3 honesty · /gap F4 · C2 sim.hexa v0.3.0)

- **σ=6.0 은 derivation 없는 hyperparameter** — magic-number 거리 Gaussian 의 폭은 fit/유도가 아니라 re-rank 용 손잡이값일 뿐 (**gate 아님** · PASS/FAIL 결정 무관). composite 순서를 매끄럽게 할 뿐 물리적 안정성 척도가 아니다.
- **양성자 마법수 {114, 120, 126} 동등-확정 취급은 부정확** — Z=114 vs 120 vs 126 은 functional/model-dependent **미해결 예측** (Skyrme 계열은 흔히 120/126, RMF 계열은 114 선호 · 합성 0개로 미검증). island_weight 는 동등하게 취급하나 실제로는 미해결이다.
- **island_weight = 근접 HINT, "섬 근처 ⇒ 안정/발견" 아님 (@D d2)** — 섬 낙관 모델의 수백~수천 년 수명 예측은 0개 합성 (§3.4) · out-of-scope ≠ impossible. weighting 은 priority re-rank 보조이며 발견·안정성 주장이 아니다.

#### Phase 2 honest blockers (resolved · documented · or carry-forward)

- **HFBTHO binary not in env** (expected · honest-skip is PASS) — install path documented in adapter `_INSTALL_HINTS["hfbtho"]`.
- **FRDM2012 `.dat` mass table not in env** (expected · honest-skip is PASS) — lightest install path; Phase 3 follow-on: `_fetch_frdm2012()` helper.
- **BSk22/24/27 tables not in env** (expected · honest-skip is PASS) — same install class as FRDM.
- **²⁹⁹Uue N6→N7 chain dependency** (informational) — N7 install-gates when N6 install-gates rather than fabricating Q_α from external mention; honest cascade per §3.3 "Don't invent" rule.
- **Brown 1992 / SemFIS-2 third formula honest-skipped** — published coefficients don't reproduce SHE regime within honest spread; re-derivation would mis-cite. Phase 3+ follow-on: substitute Denisov-Khudenko 2009 with verbatim coefficients.

---

## §7. R4 invariant block — explicit wet-lab dependency (mirror RTSC §8.10 honest-correction pattern)

> Every nuclear sim record must read in headline / scope_caveats:
>
> **"Z=119 후보일 가능성"** — sim says: "if synthesized + detected, this (Z, N) point should sit at this binding-energy / half-life region of the chart". The record is a *prediction* — it does NOT, and CANNOT, claim "Z=119 후보임" or "Z=119 발견됨" or "Z=119 atom exists".
>
> **What promotion to `absorbed=true` would require** (out of scope, permanent):
> 1. Heavy-ion accelerator beam-time at GSI / JINR / RIKEN (or future FRIB-class facility).
> 2. SHIP / DGFRS / GARIS recoil-separator detection chain.
> 3. Decay-chain identification (α-decay correlations to known daughter nuclide).
> 4. Independent replication at a second laboratory (mirror of RTSC §8.9 5-criteria gate (d)).
> 5. IUPAC / IUPAP Joint Working Party priority assignment + name approval.
>
> None of (1)–(5) is achievable from simulation. R4 invariant `absorbed=false 영구` is therefore identical to RTSC §9 — **hardcoded** in each producer, NOT a runtime decision.

### §7.1 Honest correction stance (preemptive)

If any future record (NUCLEAR or hexa-lang stdlib/nuclear adapter) ever surfaces `absorbed=true` for a sim-only prediction, that record is a **g3 violation** in the RTSC §8.10 Nb-attestation honest-correction pattern. The producer must be rejected.

---

## §8. Citations + Web URLs

### §8.1 arxiv primary references

- `arxiv:1607.06961` — Goriely et al., "Further explorations of Skyrme-Hartree-Fock-Bogoliubov mass formulas. XV. The spin-orbit coupling" (BSk family)
  - https://arxiv.org/abs/1607.06961
- `arxiv:1508.06294` — Möller et al., "Nuclear ground-state masses and deformations: FRDM(2012)"
  - https://arxiv.org/abs/1508.06294
- `arxiv:2103.07016` — Modern HFB / EDF nuclear-mass review
  - https://arxiv.org/abs/2103.07016
- `arxiv:2208.11471` — SHE production cross-section review / KEWPIE2-class analysis
  - https://arxiv.org/abs/2208.11471
- `arxiv:1810.10825` — HFBTHO 3.00 release paper (Stoitsov / Schunck / Kortelainen / Nazarewicz / Ring / Werner — axially-deformed Skyrme HFB)
  - https://arxiv.org/abs/1810.10825
- `arxiv:2004.06135` — UNEDF (Universal Nuclear Energy Density Functional) program review
  - https://arxiv.org/abs/2004.06135
- `arxiv:nucl-th/0510074` — Royer Geiger-Nuttall / WKB α-decay analytic-formula paper
  - https://arxiv.org/abs/nucl-th/0510074
- `arxiv:1611.07916` — AME2016 (predecessor to AME2020) — `Audi / Wang / Kondev`
  - https://arxiv.org/abs/1611.07916
- `arxiv:2105.01035` — AME2020 release (Wang / Huang / Kondev / Audi / Naimi)
  - https://arxiv.org/abs/2105.01035

### §8.2 Library / data URLs

- **HFBTHO** — https://gitlab.com/hfbtho/hfbtho
- **UNEDF** — https://unedf.mps.ohio-state.edu (legacy) · https://nucleartheory.cscs.ch (CECAM)
- **IAEA NSDC** (live evaluated nuclear data) — https://nds.iaea.org/relnsd/
- **AME 2020 mass evaluation** — https://www-nds.iaea.org/amdc/
- **NUBASE 2020 half-life evaluation** — https://www-nds.iaea.org/amdc/
- **JINR NRV** (nuclear reactions video) — http://nrv.jinr.ru/nrv/
- **KSHELL** — https://sites.google.com/alumni.tsukuba.ac.jp/kshell-nuclear
- **BIGSTICK** — https://github.com/cwjsdsu/BigstickPublick
- **NuShellX@MSU** — https://people.frib.msu.edu/~brown/resources/resources.html
- **Brussels Nuclear Library** (BSk parameter files) — http://www-astro.ulb.ac.be/bruslib/

### §8.3 Cross-stack reference

- **RTSC.md §9** (compositional discovery sibling) — same R4 invariant family. NUCLEAR ↔ RTSC = elemental ↔ compositional. Same `gate_type` mechanic, distinct discovery axis.
- **RTSC.md §8.10** (Nb-attestation honest-correction precedent) — template for "sim-PASS ≠ measurement" g3 correction language.
- **RTSC.md §8.7 Tier 1** (Computational synthesis tier) — NUCLEAR is the nuclear-physics analog of RTSC Tier 1 material synthesis; Tier 2–4 (recipe / measurement / falsifier) are intrinsically wet-lab and out-of-scope.

---

---

Historical log entries are in [`./NUCLEAR.log.md`](./NUCLEAR.log.md).
- [x] Phase 1 — N6 HFBTHO + N7 WKB wrap-as-is land
- [x] Phase 2 — 10-cell stabilization audit (Og-294 anchor)
- [x] Phase 3 — microkernel identification audit (NC1/NC2/NC3)
- [x] Phase 4 — Path A sim.hexa parity port (31/31 bit-for-bit)
- [x] Phase 5 — N8/N9/N10 wrap land (fusion-evap sigma · shell-model · ab-initio)
- [x] Phase 6 — N11 funnel cohort (enumerate Z,N → top-K accelerator priority)
- [x] NUCLEAR x RTSC bridge — honest-exception bracketing: SHE/isomer → RTSC bulk = NO (벽=생산량 not 반감기; SHE single-atom 화학은 예외). exports/nuclear_discovery/bridge/2026-05-25-nuclear-rtsc-bridge.md
- [x] C1 — SF-competition closed-form (sf_log10_t + alpha/SF branching -> T_total) in sim.hexa; closes N7 alpha-only flaw for Z>=104 (NOVEL probe top pick) · hexa-lang PR #928 · sim.hexa v0.2.1
- [x] C2 — shell-gap-aware island-of-stability weighting for N11 composite (magic-number distance Gaussian; consumes C1 T_total) · hexa-lang PR #929 · sim.hexa v0.3.0
- [x] GAP-fix A — sim.hexa correctness+unlock (hexa-lang PR #936/#938/#939 · v0.3.0→v0.6.0): G1 (Z,N,A,Q_α) guard · G2 odd-A model_validity_flag + consensus outlier guard · G3 PREDICTED-Q_α injection → Z=119/120 unlock (²⁹⁵119 #2 · ²⁹⁷120 #3 · ²⁹³119 #4; Z=121/122 honest-skip) · all kernels verify 🟢 · @goal MET (novel Z>118 ranked)
- [x] GAP-fix B — NUCLEAR.md honesty: §2.2 composite=(c)-gate×island 단독 (5-gate=coverage map only) · §6.3.1 σ=6.0 hyperparameter + proton-magic model-dependent · §4.2 α 2-formula vs SF 단일 비대칭 caveat
- [x] Round-2 A — SF physics (hexa-lang PR #949/#953 · sim.hexa v0.6.0→v0.8.0): odd-A SF hindrance (Hoffman 1993, log HF 5/10) + Ren-Xu Z≥114 domain guard → Lv-293 (0.0→0.433) · Fl-289 (0.0→0.170) RECOVERED · 2nd SF formula (Zdeb-Warda-Pomorski 2013) + sf_consensus spread. 검증=in-code 수치 self-check (cited 계수; --expr 아톰 등록=후속)
- [x] Round-2 B — NUBASE2020 bulk parity (hexa-lang PR #955): α 커널 vs 85 측정 T½ (앵커 2→85) · 핵심도메인(ee Z≥83) RMS 0.35 dex·bias~0 · SHE(Z≥104) 0.61 · odd-A 1.31·-1.01 (hindrance 미포착 → G2 플래그 정당화) · 앵커 재현 U-238 +0.30·Og-294 -0.20
- [x] Round-3 g5 — SF 커널 (sf_log10_t_hindered·zwp·sf_consensus_mean/spread) hexa verify --expr 아톰 등록 (hexa-lang PR #960) → 전부 🟢 SUPPORTED-NUMERICAL (full-precision); rounded-literal 🔴 = ε=1e-9 float-floor (VS/Royer 동일 class). round-2 g5 빚 청산
- [x] Round-3 predicted-only view — N11 top_k_novel.json (predicted_input=true만) (hexa-lang PR #956 · sim.hexa v0.9.0): 295-119 0.0462 > 297-120 0.0306 > 293-119 0.0017 — 기지 핵종 제외, 신규 발견 후보만
- [x] Round-3 regression test — test/nuclear_r4_anchor_smoke.hexa (hexa-lang PR #959): R4 absorbed=false 7/0 + U-238 +17.45·Og-294 -2.93 앵커 재현, negative-controlled. /gap F5 defense-in-depth
