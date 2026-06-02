# CLOSURE_RESIDUAL_BACKLOG — hexa-matter (b)/(c) deferral ledger

> **Created**: 2026-05-13 (Phase A elevation) · **Last sync**: 2026-05-13
> **Sister**: `AXIS_CLOSURE_PLAN.md` §10 roll-up — this file is the per-row
> enumeration of items deferred from category (a) v1.x scope.
>
> The closure-grade percentages in `README.md` Status section and `hexa.toml
> [verify].verdict = "CLOSED"` count **category (a) only** — in-repo
> software/spec work. That counts to **100%** as of 2026-05-13 (silicon
> close at `a239611`).
>
> Category (b) and (c) residuals do NOT subtract from the v1.x closure-grade,
> but they MUST be enumerated honestly so the percentage is interpretable.

---

## §0 Residual category legend (verbatim from AXIS_CLOSURE_PLAN.md §0)

- **(a) in-repo software** — closeable by code/test/spec work in this repo; **counts against v1.x closure-grade**. ✅ **100% REACHED 2026-05-13.**
- **(b) measured-data parity / Phase B/F stretch** — NIST/CRC/ASM/SEMI anchored values matched against measured datasets via deterministic parity gates; v1.x cert surrogate = the `LIMIT_BREAKTHROUGH.md` Wave M audit with explicit `BREAKABLE_WITH_TECH` / `HARD_WALL` annotations. **Deferred to v1.1.x / v1.2.x by design** — does NOT subtract from v1.x.
- **(c) out-of-software-scope** — wet-lab synthesis / vendor procurement / fab capacity / regulatory pathway. **100% IMPOSSIBLE in software** — closeable only via external execution.

---

## §A — Category (a) in-repo software residuals

✅ **ALL CLOSED 2026-05-13** with the silicon addition.

The path to (a) 100%:
- 2026-05-09: 16-verb v1.0.0 imported from `canon/domains/materials/` @ `47c70cbf`
- 2026-05-13: microplastics absorbed from hexa-medic (Phase D candidate verb dropped early into POL group)
- 2026-05-13: **silicon** authored in-repo (commit `a239611`) — 17th verb, cross-links into CER ∩ MET ∩ PRC
- 2026-05-13: `verify/run_all.hexa` aggregator reached 4/4 PASS

| Item | Status | Sentinel |
|------|--------|----------|
| 17/17 verb spec docs present | ✅ CLOSED 2026-05-13 | `verify/spec_presence.hexa` PASS |
| n=6 lattice arithmetic self-consistency (σ·φ=24, n·τ=24) | ✅ CLOSED 2026-05-12 | `verify/lattice_arithmetic.hexa` PASS (aux per LATTICE_POLICY §1.3) |
| LIMIT_BREAKTHROUGH.md real-limits anchored (NIST/CRC/Hales/Frenkel) | ✅ CLOSED 2026-05-12 | `verify/real_limits_anchor.hexa` PASS |
| Scoreboard cross-check (CLI · hexa.toml · README · AGENTS.md) | ✅ CLOSED 2026-05-13 | `verify/closure_consistency.hexa` PASS |

**Outcome**: hexa-matter v1.x (a) → **100%**. The v1.x closure-grade verdict in `hexa.toml [verify].verdict = "CLOSED"` is honest.

---

## §B — Category (b) measured-data parity gates (queued for Phase B/F)

These items are the deterministic parity gates between **the values cited in `LIMIT_BREAKTHROUGH.md` / `silicon/silicon.md` / per-verb spec docs** and **the measured datasets** in NIST SRD / CRC / ASM / SEMI / ASTM. Each item lists the source citation, the parity target, and the deferred Phase.

Phase B is the per-verb selftest implementation phase; Phase F is the live-database research bridge. Both are queued behind Phase A (this commit).

### B-CER (GROUP_CER ceramic)

| ID | Gate | Source | Status |
|----|------|--------|--------|
| B-CER-1 | NIST SRM quartz refractive-index parity vs `glass/hexa-glass.md` F-GL-Q4 claim | NIST SRM 1960 quartz | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b1_quartz_ri_parity.py`) |
| B-CER-2 | Si density CRC 2.329 g/cm³ vs `silicon/silicon.md` Si-L6 | CRC Handbook 105th ed. | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b2_si_density_parity.py`) |
| B-CER-3 | Si bandgap NIST/Sze 1.12 eV vs `silicon/silicon.md` Si-L7 | NIST / Sze SM Physics 3rd ed. | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b3_si_bandgap_parity.py`) |
| B-CER-4 | SiC bandgap 3.26 eV (4H-SiC) vs `silicon/silicon.md` Si-L11 | Saddow & Agarwal 2004 | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b4_sic_bandgap_parity.py`) |
| B-CER-5 | Si₃N₄ flexural strength 600-1200 MPa (HIP) vs `silicon/silicon.md` Si-L12 | ASM Handbook vol. 21 | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b5_si3n4_flexural_parity.py`) |
| B-CER-6 | UHPC compressive σ 200-800 MPa range parity | Ductal / Cor-Tuf datasheet vs L8 LIMIT_BREAKTHROUGH | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b6_uhpc_compressive_parity.py`, vendored snapshot) |
| B-CER-7 | Mohs hardness ladder NIST parity (talc 1 → diamond 10) | Mohs 1812 + NIST SRD | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b7_mohs_hardness_parity.py`) |
| B-CER-8 | Thermal donor concentration in CZ Si post-anneal (Si-L8 ≈ 10¹⁶ cm⁻³) | Kaiser-Frisch 1958; Bullis SEMI | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b8_si_thermal_donor_parity.py`, vendored snapshot) |
| B-CER-9 | [O_i] interstitial oxygen in CZ wafer (Si-L9 10-30 ppma) | ASTM F121 / F1188 | ✅ CLOSED 2026-05-13 (gate: `tests/cer_b9_si_oxygen_interstitial_parity.py`, vendored snapshot) |

### B-POL (GROUP_POL polymer)

| ID | Gate | Source | Status |
|----|------|--------|--------|
| B-POL-1 | Kevlar 49 aramid σ 3.6 GPa / E 124 GPa / ρ 1.44 g/cm³ parity | ASM Handbook vol. 21; CRC | ✅ CLOSED 2026-05-13 (gate: `tests/pol_b1_aramid_tensile_parity.py`) |
| B-POL-2 | PET hydrolysis activation energy E_a parity | Marshall et al. 1988 + Toray datasheet | ✅ CLOSED 2026-05-13 (gate: `tests/pol_b2_pet_hydrolysis_ea_parity.py`) |
| B-POL-3 | Microplastics K_d (PE, PP, PS partition coefficient) parity | NOAA Marine Debris Program | ✅ CLOSED 2026-05-13 (gate: `tests/pol_b3_microplastic_kd_parity.py`, vendored snapshot) |
| B-POL-4 | Nylon-6,6 T_g 323 K / T_m 538 K parity | CRC Handbook | ✅ CLOSED 2026-05-13 (gate: `tests/pol_b4_nylon66_tg_tm_parity.py`) |
| B-POL-5 | UHMWPE (Dyneema SK99) σ 3.9 GPa / E 132 GPa parity | DSM Dyneema datasheet | ✅ CLOSED 2026-05-13 (gate: `tests/pol_b5_uhmwpe_parity.py`, vendored snapshot) |
| B-POL-6 | CNT yarn σ 80 GPa (lab) parity | Tsinghua / IBS published | ✅ CLOSED 2026-05-13 (gate: `tests/pol_b6_cnt_yarn_parity.py`, vendored snapshot, **UNPROVEN at commodity scale preserved verbatim** — gate verifies lab-mm parity only, NOT km-scale reproducibility) |

### B-FIB (GROUP_FIB fiber)

| ID | Gate | Source | Status |
|----|------|--------|--------|
| B-FIB-1 | Cellulose crystallinity (Segal index from XRD) parity | TAPPI T 271 / Segal 1959 | ✅ CLOSED 2026-05-13 (gate: `tests/fib_b1_cellulose_segal_parity.py`) |
| B-FIB-2 | Paper tensile (kraft, newsprint) parity | TAPPI T 494 | ✅ CLOSED 2026-05-13 (gate: `tests/fib_b2_paper_tensile_parity.py`) |

### B-MET (GROUP_MET metal)

| ID | Gate | Source | Status |
|----|------|--------|--------|
| B-MET-1 | Inconel 718 creep at 650 °C parity | ASM Handbook vol. 1; Special Metals datasheet | ✅ CLOSED 2026-05-13 (gate: `tests/met_b1_inconel718_creep_parity.py`) |
| B-MET-2 | Ti-6Al-4V α-β transformation T 1268 K parity | ASM Handbook vol. 2 | ✅ CLOSED 2026-05-13 (gate: `tests/met_b2_ti64_transus_parity.py`) |
| B-MET-3 | AISI 1080 TTT diagram parity (austenite → bainite/martensite) | ASM Handbook vol. 4 | ✅ CLOSED 2026-05-13 (gate: `tests/met_b3_aisi1080_ttt_parity.py`) |
| B-MET-4 | W melting point 3695 K parity | NIST | ✅ CLOSED 2026-05-13 (gate: `tests/met_b4_w_melting_parity.py`) |
| B-MET-5 | Os density 22.59 g/cm³ parity | NIST | ✅ CLOSED 2026-05-13 (gate: `tests/met_b5_os_density_parity.py`) |

### B-GEM (GROUP_GEM gem)

| ID | Gate | Source | Status |
|----|------|--------|--------|
| B-GEM-1 | Corundum refractive index n_d 1.762-1.770 parity | NIST | ✅ CLOSED 2026-05-13 (gate: `tests/gem_b1_corundum_ri_parity.py`) |
| B-GEM-2 | Ruby Cr³⁺ R-line fluorescence 694.3 nm parity | NIST / Sugano-Tanabe-Kamimura | ✅ CLOSED 2026-05-13 (gate: `tests/gem_b2_ruby_rline_parity.py`) |

### B-PRC (GROUP_PRC process)

| ID | Gate | Source | Status |
|----|------|--------|--------|
| B-PRC-1 | Hales packing simulation parity (FCC/HCP 0.7405) | Hales 2017 formal proof | ✅ CLOSED 2026-05-13 (gate: `tests/prc_b1_hales_packing_parity.py`) |
| B-PRC-2 | Gibbs ΔS_mix recycling-energy parity | ISO 14040 LCA + Gibbs | ✅ CLOSED 2026-05-13 (gate: `tests/prc_b2_recycling_gibbs_parity.py`, ideal-mixing thermodynamic derivation) |
| B-PRC-3 | Sol-gel TEOS hydrolysis rate parity | Hench & West 1990 | ✅ CLOSED 2026-05-13 (gate: `tests/prc_b3_solgel_teos_parity.py`, vendored snapshot) |

### B-FAS (GROUP_FAS fashion)

| ID | Gate | Source | Status |
|----|------|--------|--------|
| B-FAS-1 | Reactive dye covalent yield parity | ISO 105 | ✅ CLOSED 2026-05-13 (gate: `tests/fas_b1_reactive_dye_yield_parity.py`) |
| B-FAS-2 | K/S (Kubelka-Munk) for mordant-dyeing parity | AATCC test method 6 | ✅ CLOSED 2026-05-13 (gate: `tests/fas_b2_kubelka_munk_parity.py`, closed-form K/S identity check) |

### §B — Summary

| Group | (b) gates remaining | ✅ CLOSED by Phase H + I.1 + I.2 (2026-05-13) | Phase target (remaining) |
|-------|---------------------|------------------------------------------------|--------------------------|
| CER   | 0 | 9 (B-CER-1..9) | — ALL CLOSED |
| POL   | 0 | 6 (B-POL-1..6) | — ALL CLOSED |
| FIB   | 0 | 2 (B-FIB-1 · B-FIB-2) | — ALL CLOSED |
| MET   | 0 | 5 (B-MET-1..5) | — ALL CLOSED |
| GEM   | 0 | 2 (B-GEM-1 · B-GEM-2) | — ALL CLOSED |
| PRC   | 0 | 3 (B-PRC-1..3) | — ALL CLOSED |
| FAS   | 0 | 2 (B-FAS-1 · B-FAS-2) | — ALL CLOSED |
| **Total** | **0 remaining** (29 → 0, **ALL 29 CLOSED**: 10 Phase H + 10 Phase I.1 + 9 Phase I.2) | **29** | — |

**🏆 Category (b) FULL CLOSURE achieved 2026-05-13** — all 29 enumerated parity gates have landed; selftest aggregator `parity_gates_smoke` sweeps 29/29; ledger §B drained 29 → 0. Combined with the §A 100% (a) closure already certified, **Category (a)+(b) closure = 100%** as of this commit. Category (c) remains OUT-OF-REPO BY DESIGN (wet-lab / vendor / fab handoff — software cannot close these per `AXIS_CLOSURE_PLAN.md` §0).



**Phase I.2 closure (2026-05-13)**: 9 vendor-/literature-anchored gates landed (Ductal+Cor-Tuf UHPC / Kaiser-Frisch + SEMI MF1188 / ASTM F121-F1188 / NOAA + Mato + Rochman / DSM Dyneema SK99 / Tsinghua Bai 2018 [UNPROVEN at commodity scale, preserved verbatim] / ISO 14040 + Gibbs / Hench-West + Brinker-Scherer / AATCC TM6 + Kubelka-Munk 1931). Aggregator now sweeps **29 gates total** and emits `__HEXA_MATTER_PARITY_GATES__ PASS (29/29 gates, 0 skipped)`. Selftest scoreboard remains 28/28 PASS. **§B fully drained 29 → 0 — Category (b) closure = 100%.**

**Honest C3 (residual)**: 0 of 29 gates remain UNVERIFIED. All values flow through vendored offline snapshots; gates check spec↔source parity, not measurement; UNPROVEN markers (CNT yarn at commodity scale, magic-MOF DAC, etc.) are explicitly preserved verbatim in snapshot metadata and gate output. Category (c) remains OUT-OF-REPO BY DESIGN (see §C).

---

## §C — Category (c) out-of-software-scope (wet-lab / vendor / fab handoff)

**These cannot be closed in software.** Enumerated for visibility and DEST: tracking.

### C-CER (ceramic)

| ID | Item | DEST | Wall classification (`LIMIT_BREAKTHROUGH.md`) |
|----|------|------|--------|
| C-CER-3 | LK-99 room-T SC reproduction | DEST: none yet (2023 LK-99 null reproduction — Russell-Wickham et al.) — HARD_WALL pending peer-reviewed reproduction; UNVERIFIED preserved verbatim | HARD_WALL — `LIMIT_BREAKTHROUGH.md §4 "Not in top-3 (over-hyped) — Room-temperature superconductor (LK-99)"` ("Not reproduced; HARD_WALL until peer-reviewed reproduction") |
| C-CER-4 | Antiferroelectric perovskite growth (large-area + 25-yr lifetime) | DEST: Oxford PV / Saule Technologies / First Solar (vendor numbers only); LK-99 NOT REPRODUCED preserved verbatim | UNCLEAR — perovskite lifetime claim UNVERIFIED at commercial scale per `LIMIT_BREAKTHROUGH.md §4`; large-area uniformity = SOFT_WALL engineering frontier |
| C-CER-5 | Isotope-separated Si-28 production for quantum compute | DEST: International Avogadro Project (PTB Braunschweig + NRC Canada + NMIJ Japan) / quantum-compute consortia (Diraq, SQC, Silicon Quantum Computing) — research consortium, no commercial vendor | BREAKABLE_WITH_TECH — isotope separation is engineering-limited; `LIMIT_BREAKTHROUGH.md §3 L9 "Isotopically-pure thermal conductors"` notes the analogous ¹²C path (real, niche, expensive) |
| C-CER-6 | UHPC industrial pour scale-up | DEST: Lafarge-Holcim (Ductal) / Cemex / Densit / Cor-Tuf Concretes LLC — vendor numbers only; UHPC σ_c 200-800 MPa anchored at `tests/cer_b6_uhpc_compressive_parity.py` | SOFT_WALL — `LIMIT_BREAKTHROUGH.md §3 L8 "Concrete compressive strength — SOFT_WALL → UHPC"` (200-800 MPa deployed; ~2 GPa theoretical) |
| C-CER-7 | High-purity quartz mining (Spruce Pine NC) | DEST: Sibelco North America Inc. / The Quartz Corp (TQC, Drag Norway + Spruce Pine NC) — vendor numbers only; geographic-monopoly OUT-OF-SOFTWARE | OUT-OF-SOFTWARE — geological raw-material supply chain; no physical-limit row applies (mining is not bounded by a NIST/CRC invariant) |

### C-POL (polymer)

| ID | Item | DEST | Wall classification (`LIMIT_BREAKTHROUGH.md`) |
|----|------|------|--------|
| C-POL-2 | Microplastics open-ocean field campaign | DEST: 5 Gyres Institute / Algalita Marine Research Foundation / NOAA Marine Debris Program — cross-domain (hexa-earth overlap candidate); no formal contract | OUT-OF-SOFTWARE — open-ocean field sampling; software-side K_d parity at `tests/pol_b3_microplastic_kd_parity.py` (NOAA + Mato 2001 + Rochman 2013 anchored) |
| C-POL-3 | DuPont para-aramid (Kevlar) synthesis pilot | DEST: DuPont de Nemours Inc. (Richmond VA Spruance plant) — proprietary process, vendor numbers only; not licensable | OUT-OF-SOFTWARE — proprietary polymerization (PPTA in 100% H₂SO₄); SOFT_WALL on σ per `LIMIT_BREAKTHROUGH.md §3 L2` (Kevlar 49 σ ≈ 3.6 GPa) — engineering ceiling not physical theorem |

### C-MET (metal)

| ID | Item | DEST | Wall classification (`LIMIT_BREAKTHROUGH.md`) |
|----|------|------|--------|
| C-MET-1 | Single-crystal turbine blade casting pilot | DEST: PCC Aerostructures / Howmet Aerospace Inc. / Doncasters Group Ltd. — vendor numbers only; Re-free 4th-gen SX UNVERIFIED preserved verbatim | BREAKABLE_WITH_TECH — single-crystal Bridgman growth is engineering-limited; T_service approaches `LIMIT_BREAKTHROUGH.md §3 L5` refractory ceiling but bounded well below 4200 K |
| C-MET-2 | Luthier studio (Stradivari method) reproduction | DEST: out-of-scope (culture domain — not a STEM closure target); no vendor and no physical-limit anchor expected | OUT-OF-SOFTWARE — culture / craft domain; no `LIMIT_BREAKTHROUGH.md` row applies (Stradivari acoustic profile is not bounded by a NIST/CRC physical invariant) |
| C-MET-3 | `hxm-mag-boride-001` ((FeCoNiMnCr)₂B C16 boride) thin-film → bulk scale-up + K₁/Tc measurement | DEST: Beeson lab (Georgetown) + Ames Lab CMI / Northeastern U / U Delaware; Adv. Mater. 2025 DOI 10.1002/adma.202516135 | UNCLEAR per `LIMIT_BREAKTHROUGH.md §7` — **SIM-NNP reached** (CHGNet relax of (FeCoNiMn)₂B C16 ordered approximant on ubu-1: stable, \|magmom\| 0.64 μB/atom; predictions/hxm-mag-boride-001.json). K₁ / FM-ordering / bulk synthesis stay out-of-repo — CHGNet resolves neither anisotropy nor easy-axis ordering |
| C-MET-4 | `hxm-mag-mn2sb-001` (Mn₂Sb tetragonal) bulk synth + magnetic measurement | DEST: Ames CMI / NIMS Tsukuba / Max Planck Inst. Microstructure Physics; arxiv:2507.01849 prediction (Tc=2270 K, K=1.57 MJ/m³, Ms=1.76 T) | UNCLEAR — **SIM-DFT reached** (MP mp-20664: P4/nmm, FM, E_hull=0); bulk synth + K/Tc measurement gates further promotion |
| C-MET-5 | `hxm-mag-mnalc-001` (MnAl τ-phase) bulk pilot — sintered pellet + thermal-cycling | DEST: industrial mechanochem / SPS pilot vendors (Eldim / Granutec / Höganäs Mn-powder supply); R&D lit ~12 MGOe lab, 6 MGOe sintered | BREAKABLE_WITH_TECH per `LIMIT_BREAKTHROUGH.md §7` — **SIM-DFT reached** (MP mp-771: MnAl P4/mmm, FM, E_hull=0); τ-phase metastability is the SOFT_WALL |
| C-MET-6 | `hxm-mag-ferrhd-001` (SrFe₁₂O₁₉ Co/La-doped) anisotropic high-density pilot | DEST: TDK Corp. (FB/NEO series) / Hitachi Metals NMX-X / Proterial; commercial (BH)max ~5-6 MGOe | SOFT_WALL per `LIMIT_BREAKTHROUGH.md §7` — **DESIGN** (MP mp-3742 E_hull=0.072 DFT-metastable; DFT over-penalises this commercial-stable oxide) |
| C-MET-7 | `hxm-mag-lowdy-001` ((Nd,Ce,La)₂Fe₁₄B low-Dy/Tb) production pilot | DEST: Toyota Motor (Tanaka Kakinen) / Daido Steel / Hitachi Metals NEOREC — prototype magnets 50-80% Dy reduction; commercial production unverified | BREAKABLE_WITH_TECH — **SIM-DFT reached** (base Nd₂Fe₁₄B MP mp-5182 P4₂/mnm, FiM, E_hull=0.001); Ce/La substitution itself unverified design |
| C-MET-8 | `hxm-mag-aifound-001` (FeCo₂Ge Heusler) bulk synth + Tc measurement | DEST: any intermetallic-synthesis lab (arc-melt / induction); NEMAD Table 4 (arxiv:2409.15675 / Nat. Commun. 16 9415 (2025)); pred Tc ≈ 1000-1070 K | UNCLEAR — **SIM-DFT reached** (MP mp-22300: Fm-3m full Heusler, FM, E_hull=0); NEMAD Tc is ML-regressed, not measured |
| C-MET-9 | `hxm-mag-gfcs-001` (Ga₃Fe₄Co₈Si) bulk synth + Tc measurement | DEST: intermetallic-synthesis lab; NEMAD Table 4 highest-Tc REE-free FM (pred Tc ≈ 1010-1150 K) | UNCLEAR — **SIM-DFT reached** (MP mp-1225352: R-3m, FM, E_hull=0); ML-regressed Tc gates further promotion |
| C-MET-10 | `hxm-mag-znfe-001` (ZnFe tetragonal) bulk synth + magnetic measurement | DEST: DFT-validation lab; arxiv:2507.01849 prediction (Ms=1.15 T, κ=0.85) | UNCLEAR — **DESIGN** (MP mp-1215473 E_hull=0.023 DFT-metastable); ordered-phase stabilisation gates SIM-DFT |
| C-MET-11 | `hxm-mag-refree-001` (Fe₁₆N₂ thin-film) bulk (BH)max measurement | DEST: thin-film magnetics lab (Coey group TCD / U Minnesota Fe₁₆N₂ lineage) | UNCLEAR — **SIM-DFT reached** (MP mp-555: Fe₈N≡Fe₁₆N₂ I4/mmm, FM, E_hull=0.001); bulk (BH)max gates promotion |
| C-MET-12 | `hxm-mag-tetra-001` (tetrataenite L1₀ FeNi) terrestrial ordered-phase synthesis | DEST: meteoritic-analogue labs (Cambridge / Northeastern tetrataenite groups) | UNCLEAR — **SIM-DFT reached** (MP mp-2213: FeNi P4/mmm L1₀, FM, E_hull=0); ordered-phase fraction at terrestrial cooling rates gates promotion |
| C-MET-13 | `hxm-mag-mnbi-001` (MnBi LTP) bulk synth + high-T coercivity | DEST: rare-earth-free magnet labs; LTP MnBi applied-phase literature | UNCLEAR — **DESIGN** (MP mp-568382 E_hull=0.21 DFT-metastable; LTP MnBi is a known applied phase despite DFT penalty) |

### C-GEM (gem)

| ID | Item | DEST | Wall classification (`LIMIT_BREAKTHROUGH.md`) |
|----|------|------|--------|
| C-GEM-1 | Lab-grown diamond CVD/HPHT bench | DEST: Element Six Ltd. (De Beers Group, Ascot UK + Springs SA) / Diamond Foundry Inc. (San Francisco CA) — vendor numbers only | HARD_WALL on Mohs hardness 10 per `LIMIT_BREAKTHROUGH.md §3 L4 "Mohs hardness 10 (diamond) — HARD_WALL (effectively)"`; growth-rate / cost-per-carat = SOFT_WALL engineering frontier |
| C-GEM-2 | Gem treatment audit (heat, irradiation) | DEST: GIA (Gemological Institute of America, Carlsbad CA) — diagnostic / certification only, not a treatment provider | OUT-OF-SOFTWARE — third-party certification body; software-side gemological-property parity at `tests/gem_b1_corundum_ri_parity.py` + `tests/gem_b2_ruby_rline_parity.py` |

### C-PRC (process)

| ID | Item | DEST | Wall classification (`LIMIT_BREAKTHROUGH.md`) |
|----|------|------|--------|
| C-PRC-1 | Chemical recycling pilot | DEST: Eastman Chemical Co. (Kingsport TN molecular-recycling plant) / Loop Industries Inc. (Terrebonne QC) — vendor numbers only; "infinite-recycle" claim UNPROVEN preserved verbatim | HARD_WALL — `LIMIT_BREAKTHROUGH.md §3 L12 "Material entropy of mixing (recycling) — HARD_WALL on recycling separation"` (Gibbs ΔS ≥ k·Σ n_i·ln(x_i) floor) |
| C-PRC-2 | Powder-bed printing pilot | DEST: EOS GmbH (Krailling DE) / 3D Systems Corp. (Rock Hill SC) / Stratasys Ltd. (Eden Prairie MN) — vendor numbers only | BREAKABLE_WITH_TECH — AM throughput is engineering-limited; SOFT_WALL on layer-height + defect-density per `LIMIT_BREAKTHROUGH.md §3 L1` Frenkel σ_th gap (defect-controlled) |

### C-FAS (fashion)

| ID | Item | DEST | Wall classification (`LIMIT_BREAKTHROUGH.md`) |
|----|------|------|--------|
| C-FAS-1 | Dye-house pilot (reactive / mordant) | DEST: Huntsman Corporation (Textile Effects) / Archroma Management LLC / DyStar Singapore Pte Ltd. — vendor numbers only; industrial textile supply chain | OUT-OF-SOFTWARE — industrial dye-house operation; software-side covalent-yield parity at `tests/fas_b1_reactive_dye_yield_parity.py` (ISO 105-X12) and K/S parity at `tests/fas_b2_kubelka_munk_parity.py` |
| C-FAS-2 | Natural-dye revival (indigo fermentation) | DEST: cross-domain — `hexa-bio` fermentation chapter overlap (no direct hexa-matter vendor) | OUT-OF-SOFTWARE — biological fermentation belongs to the sister-substrate `hexa-bio`; cross-link only, not a hexa-matter closure target |

### §C — Handoff destination matrix

| ID | Type | Sister repo | External API / vendor | Status |
|----|------|-------------|----------------------|--------|
| C-CER-2 Wolfspeed | vendor audit | none | Wolfspeed datasheets | DEST: vendor-numbers-only |
| C-CER-3 LK-99 | lab reproduction | none | none | DEST: HARD_WALL (peer-review pending) |
| C-CER-5 Si-28 | quantum compute | possible hexa-chip overlap | Avogadro Project | DEST: research consortium |
| C-POL-2 microplastics | field campaign | possible hexa-earth overlap | NOAA / EPA | DEST: cross-domain |
| C-MET-1 turbine blade | aerospace | none | PCC / Howmet | DEST: vendor-numbers-only |
| C-FAS-2 indigo ferm | cross-domain | hexa-bio fermentation | none | DEST: cross-domain |



---

## §D — Roll-up

| Category | Items | Effort to 100% | v1.x closure-grade impact |
|----------|-------|----------------|---------------------------|
| (a) in-repo software | 33 verbs + 4 verify scripts | **0 days remaining — ✅ (a) 100% REACHED 2026-05-13** | YES — all (a) gaps closed |
| (b) measured-data parity | 29 gates total → **20 ✅ CLOSED by Phase H + I.1 (2026-05-13)** · 9 remaining (1 Phase B B-FAS-2 + 8 Phase F) | Phase I.2 (B-FAS-2 K/S Kubelka-Munk) + Phase F (8 live-DB items) | PARTIAL — 20/29 closed (selftest 28/28; parity_gates_smoke sweeps 20/20); Phase I.2 closes B-FAS-2; Phase F closes live-DB residual |
| **Total** | **51 enumerated rows** (29 §B closed + 4 §A closed + 18 §C handed-off) | — | — |

**Honest reading of "100% closure 가능?"** (updated 2026-05-13 post-Phase I.1):

- **(a)** ✅ **DONE 2026-05-13** — all 33 verbs spec-present, all 4 verify scripts PASS, scoreboard self-consistent at **selftest 28/28 PASS**. **v1.x (a) = 100%.**
- **(b)** 29 parity gates total → **20 CLOSED by Phase H + I.1** (selftest aggregator `parity_gates_smoke` sweeps 20/20) + 9 queued (1 Phase I.2 B-FAS-2 + 8 Phase F live-DB). None of these subtract from v1.x. Closing the remaining 9 lifts v1.1.x / v1.2.x.

---

## §E — Self-update protocol

When a (b) parity gate lands or a (c) destination changes:
- **(b) gate lands** → Phase B/F: implement `tests/<group>_<gate>_parity.py`, wire into `verify/run_all.hexa`, flip the §B status from "Phase B/F target" to "✅ CLOSED `<date>`".
- **(c) DEST changes** → update the §C matrix DEST column. New vendor partnership → log the partnership document URL in the row.

raw_91 honest C3: this file is a *deferral ledger*, not a verification artifact. It does not change any closure-grade percentage; it makes the residual structure honest so the percentage is interpretable.

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation. (b)/(c) framework adapted from `hexa-bio/CLOSURE_RESIDUAL_BACKLOG.md` (cycle-30, 2026-05-12).*
