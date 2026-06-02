# AXIS_CLOSURE_PLAN — hexa-matter per-group closure roadmap

> **Created**: 2026-05-13 (Phase A elevation) · **Status**: infrastructure doc
> **Companion**: `AXIS.md` (7-group taxonomy) · `CLOSURE_RESIDUAL_BACKLOG.md` (per-row deferral ledger)
> **Source-of-truth scoreboard**: `hexa.toml [verify]` + `verify/run_all.hexa`
>
> what counts against the v1.x closure-grade percentage (category (a)
> in-repo software), what is queued for v2 stretch (category (b) formal
> + measured parity), and what is permanently external (category (c)
> wet-lab synthesis / fab capacity). The percentages reported below are
> **category (a) only**; reading them without the (b)/(c) breakdown gives
> a false sense of how much is "left to do" inside the repo.

---

## §0 Residual category legend (verbatim from hexa-bio/AXIS_CLOSURE_PLAN.md §0, adapted to materials)

- **(a) in-repo software** — closeable by code/test/spec work in this repo; **counts against v1.x closure-grade**. ✅ **100% REACHED 2026-05-13** with the silicon addition (17/17 verbs spec-present, 4/4 verify scripts PASS).
- **(b) formal/empirical material-property data parity** — NIST/CRC/ASM/SEMI anchored values matched against measured datasets via deterministic comparisons. **NOT a v1.x blocker**; tracked for Phase B/F.

---

## §1 Current state snapshot (2026-05-13, post-silicon close)

| Group     | Verbs | spec_presence | lattice_aux | real_limits | closure_consistency | (a) % | (b) gaps | (c) gaps |
|-----------|-------|---------------|-------------|-------------|---------------------|-------|----------|----------|
| GROUP_CER | 5     | ✅ 5/5         | ✅           | ✅ NIST/CRC | ✅                   | **100%** | NIST tensile parity, thermal-shock dataset compare for ceramics, Si dopant concentration parity (Si-L8) | LK-99 synthesis (open), antiferroelectric perovskite growth, Wacker poly-Si batch trace |
| GROUP_POL | 5     | ✅ 5/5         | ✅           | ✅ CRC/ASM  | ✅                   | **100%** | aramid tensile NIST parity gate, microplastics partition-coefficient parity, PET hydrolysis activation-energy parity | aramid pilot synthesis, microplastics field-mass-balance |
| GROUP_FIB | 2     | ✅ 2/2         | ✅           | ✅ Ashby    | ✅                   | **100%** | cellulose-crystallinity dataset parity (XRD), paper-mechanics ISO 5626 parity | natural-fiber harvest-yield parity (Phase D dependent) |
| GROUP_MET | 2     | ✅ 2/2         | ✅           | ✅ ASM      | ✅                   | **100%** | superalloy creep-strength parity (Inconel 718), single-crystal turbine blade R-axis parity, TTT-diagram parity (austenite-martensite-bainite) | superalloy casting (single-crystal), Ti-6Al-4V grade-5 wet-process |
| GROUP_GEM | 1     | ✅ 1/1         | ✅           | ✅ NIST     | ✅                   | **100%** | refractive-index NIST parity, fluorescence-spectrum parity | lab-grown diamond CVD/HPHT bench, treatment audit (heat, irradiation) |
| GROUP_PRC | 4     | ✅ 4/4         | ✅           | ✅ Hales/Gibbs | ✅                | **100%** | Kepler packing simulation parity (Hales 2017 numerical), Gibbs ΔS_mix recycling-energy parity | polymer chemical-recycling pilot, alloy entropy-separation pilot |
| GROUP_FAS | 2     | ✅ 2/2         | ✅           | ✅ ASTM dye | ✅                   | **100%** | reactive-dye covalent-yield parity (ISO 105), mordant-dyeing K/S parity | wet-process dye-house pilot, natural-dye (indigo fermentation) cross-domain |

**(a) row total**: **100% across all 7 groups** as of 2026-05-13 — 17/17 verb spec docs present, all 4 verify scripts PASS, scoreboard cross-check (CLI · `hexa.toml` · README · `AGENTS.md`) consistent.

**(b) total**: ~15 dataset-parity gaps queued for Phase B/F.

**(c) total**: ~10 wet-lab / fab-capacity items queued — permanently external by definition.

---

## §2 Per-group sequencing — what closes next

The 7 groups are at category (a) 100% as of the silicon addition. The next closure axis is **category (b) — measured-data parity**. Sequencing rationale:

1. **GROUP_CER first** — Si-L1..Si-L12 are the freshest entries (added 2026-05-13). The lowest-hanging parity gates are NIST SRM quartz refractive-index vs `glass/glass.md` claims; SiC bandgap NIST vs `silicon/silicon.md` Si-L11 claim; Si density CRC 2.329 g/cm³ vs `silicon/silicon.md` Si-L6 claim.

2. **GROUP_POL second** — aramid tensile (Kevlar 49 ~ 3.6 GPa published) vs ASM Handbook vol. 21; UHMWPE σ 3.9 GPa vs Dyneema SK99 datasheet; CNT-fiber lab ~80 GPa vs Tsinghua/IBS published.

3. **GROUP_MET third** — Inconel 718 creep at 650 °C vs ASM Handbook vol. 1 + Special Metals datasheet.

4. **GROUP_GEM, GROUP_FIB, GROUP_FAS, GROUP_PRC** — less load-bearing for v1.x; Phase F (research bridge) work.

---

## §3 GROUP_CER — closure roadmap

### §3.1 Closure status

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| ceramics | 100% | Vickers/Knoop hardness map (Si₃N₄ 600-1200 MPa flexural per Si-L12) lacks parity vs ASM vol. 21 measured dataset | ceramic-armor production scale; Wolfspeed SiC wafer trade volumes |
| concrete | 100% | UHPC compressive 200-800 MPa range lacks dataset parity vs Ductal/Cor-Tuf published spec | UHPC pilot-pour cost/m³ benchmarking |
| concrete_tech | 100% | curing-thermal model lacks parity vs ACI 318 measured | accelerated-curing kiln pilot |
| glass | 100% | Heraeus / Corning fused silica T_g vs L7 1473 K parity | high-purity quartz mining (Spruce Pine NC dominance) |
| silicon | 100% | Si-L1..Si-L12 vs SEMI M1 / ASTM F121/F1188/F47 measured parity (Phase B target) | Wacker batch lot purity audit, Wolfspeed SiC wafer fabrication, isotope-separated Si-28 (quantum compute) production |

### §3.2 Real-limit anchors used by GROUP_CER

From `LIMIT_BREAKTHROUGH.md`:
- L4 Mohs hardness ceiling 10 (diamond) — HARD wall
- L5 melting point 4215 K (Ta₄HfC₅) — HARD wall (bond energy)
- L7 glass T_g (~1473 K fused silica) — SOFT wall, compositional
- L8 concrete compressive σ_c (30 MPa → 800 MPa UHPC → 2 GPa theoretical) — SOFT wall

From `silicon/silicon.md` (Si-L1..Si-L12, added 2026-05-13):
- Si-L1 electronic-grade poly-Si 9N purity — SOFT wall (process + measurement)
- Si-L3 CZ crucible ~600 mm — SOFT wall (fused-silica creep at 1500 °C)
- Si-L4 FZ rod ~200 mm — SOFT wall (surface-tension + RF-coil power)
- Si-L5 Si melting point 1687 K — HARD wall
- Si-L7 Si bandgap 1.12 eV indirect — HARD wall (material parameter; device design lives in hexa-chip)
- Si-L11 SiC wide bandgap 3.26 eV (4H-SiC) — HARD wall

### §3.3 (b) gates queued for Phase B/F

- B-CER-1: NIST SRM quartz refractive-index parity vs `glass/glass.md` claim — `tests/cer_b1_quartz_ri_parity.py` (Phase B)
- B-CER-2: Si density CRC 2.329 g/cm³ vs Si-L6 — `tests/cer_b2_si_density_parity.py` (Phase B; tractable in days)
- B-CER-3: Si bandgap NIST/Sze 1.12 eV vs Si-L7 — `tests/cer_b3_si_bandgap_parity.py` (Phase B)
- B-CER-4: SiC bandgap Saddow & Agarwal 2004 vs Si-L11 3.26 eV — `tests/cer_b4_sic_bandgap_parity.py` (Phase B)
- B-CER-5: Si₃N₄ flexural strength ASM vol. 21 vs Si-L12 600-1200 MPa — `tests/cer_b5_si3n4_flexural_parity.py` (Phase B)

### §3.4 (c) hand-off destinations (DEST: matrix)

- C-CER-1 Wacker batch lot purity audit — DEST: Wacker Polysilicon AG (no contract; vendor numbers only)
- C-CER-2 Wolfspeed SiC wafer fabrication — DEST: Wolfspeed Inc. (no contract; vendor datasheet only)
- C-CER-3 LK-99 room-T SC reproduction — DEST: peer-reviewed lab (none yet; 2023 null reproduction)
- C-CER-4 Antiferroelectric perovskite growth — DEST: out-of-scope (Phase D candidate)
- C-CER-5 Isotope-separated Si-28 production — DEST: International Avogadro Project / quantum-compute consortia

---

## §4 GROUP_POL — closure roadmap

### §4.1 Closure status

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| aramid | 100% | Kevlar 49 σ 3.6 GPa / E 124 GPa / ρ 1.44 g/cm³ vs ASM Handbook vol. 21 parity | DuPont para-aramid synthesis (proprietary) |
| epoxy | 100% | DGEBA/DETA cure-cycle T_g range parity vs Hexcel/Henkel datasheet | aerospace prepreg pilot |
| nylon | 100% | nylon-6,6 T_g 323 K / T_m 538 K / σ 0.6-0.8 GPa parity vs CRC | DuPont Zytel / BASF Ultramid batch trace |
| pet_film | 100% | PET T_g 343 K / T_m 533 K / haze-vs-thickness parity vs Toray/DuPont | MRI-grade PET film yield audit |
| microplastics | 100% | partition coefficient K_d, biofilm colonization rate parity vs EPA/NOAA measured | open-ocean field mass-balance (5 gyres data) |

### §4.2 (b) gates queued

- B-POL-1: aramid Kevlar 49 tensile σ/E/ρ vs ASM vol. 21 — `tests/pol_b1_aramid_tensile_parity.py`
- B-POL-2: PET hydrolysis activation energy E_a vs Marshall et al. 1988 — `tests/pol_b2_pet_hydrolysis_ea_parity.py`
- B-POL-3: microplastics K_d for PE/PP/PS vs NOAA Marine Debris Program — `tests/pol_b3_mp_partition_coeff_parity.py`

### §4.3 (c) hand-off

- C-POL-1 DuPont/BASF/Toray batch trace — DEST: vendor partnerships (none active)
- C-POL-2 microplastics field campaign — DEST: oceanographic research (5 Gyres / Algalita / NOAA)

---

## §5 GROUP_FIB — closure roadmap

### §5.1 Closure status

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| fabric | 100% | woven-fabric thread count vs density parity (ISO 7211) | textile-mill supply chain |
| paper | 100% | cellulose-crystallinity XRD parity (Segal index) vs TAPPI T 271 | pulp-mill (chemical pulping pilot) |

### §5.2 (b) gates queued

- B-FIB-1: cellulose crystallinity vs XRD Segal index — `tests/fib_b1_cellulose_xrd_parity.py`
- B-FIB-2: paper tensile vs TAPPI T 494 — `tests/fib_b2_paper_tensile_parity.py`

---

## §6 GROUP_MET — closure roadmap

### §6.1 Closure status

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| metallurgy | 100% | superalloy Inconel 718 creep at 650 °C vs ASM Handbook vol. 1; Ti-6Al-4V α-β transformation T 1268 K parity | single-crystal turbine blade casting pilot |
| lutherie | 100% | bell-bronze (78Cu/22Sn) acoustic-resonance frequency vs measured | luthier-studio craft pilot |

### §6.2 (b) gates queued (Phase B/F)

- B-MET-1: Inconel 718 creep strength 650 °C vs ASM vol. 1 — `tests/met_b1_inconel718_creep_parity.py`
- B-MET-2: Ti-6Al-4V α-β transformation T vs ASM vol. 2 — `tests/met_b2_ti6al4v_transition_parity.py`
- B-MET-3: TTT (time-temperature-transformation) diagram parity for AISI 1080 steel — `tests/met_b3_ttt_1080_parity.py`

### §6.3 (c) hand-off

- C-MET-1 single-crystal turbine blade casting — DEST: PCC Aerostructures / Howmet (no contract)
- C-MET-2 luthier studio (Stradivari method) — DEST: out-of-scope (culture domain)

---

## §7 GROUP_GEM — closure roadmap

### §7.1 Closure status

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| gemology | 100% | refractive index n_d for corundum (1.762-1.770) vs NIST SRM; fluorescence spectrum λ_max for ruby Cr³⁺ 694.3 nm | lab-grown diamond CVD/HPHT bench |

### §7.2 (b) gates queued

- B-GEM-1: corundum refractive index NIST parity — `tests/gem_b1_corundum_ri_parity.py`
- B-GEM-2: ruby Cr³⁺ fluorescence 694.3 nm parity — `tests/gem_b2_ruby_fluorescence_parity.py`

---

## §8 GROUP_PRC — closure roadmap

### §8.1 Closure status

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| synthesis | 100% | sol-gel TEOS hydrolysis rate vs Hench & West 1990 | hydrothermal synthesis pilot |
| recycling | 100% | polymer ΔS_mix Gibbs floor vs ISO 14040 LCA | chemical-recycling pilot |
| recycle_n6 | 100% | n=6 lattice arithmetic (aux) | (n/a; in-software only) |
| printing | 100% | FDM/SLS/SLA mechanical-property vs ASTM F42 | additive-manufacturing pilot |

### §8.2 (b) gates queued

- B-PRC-1: Hales packing simulation parity (FCC/HCP 0.7405) — `tests/prc_b1_hales_packing_parity.py`
- B-PRC-2: Gibbs ΔS_mix for polymer recycling vs ISO 14040 — `tests/prc_b2_recycling_gibbs_parity.py`

### §8.3 (c) hand-off

- C-PRC-1 chemical recycling pilot — DEST: Eastman / Loop Industries (vendor numbers only)
- C-PRC-2 powder-bed printing pilot — DEST: EOS / 3D Systems / Stratasys (vendor numbers only)

---

## §9 GROUP_FAS — closure roadmap

### §9.1 Closure status

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| fashion-textile | 100% | textile supply chain audit (cotton, wool, silk yields) — none yet | global supply chain |
| textile-dyeing | 100% | reactive-dye covalent yield vs ISO 105 measured | dye-house pilot |

### §9.2 (b) gates queued

- B-FAS-1: reactive dye covalent yield ISO 105 parity — `tests/fas_b1_reactive_dye_parity.py`
- B-FAS-2: K/S (Kubelka-Munk) for mordant-dyeing parity — `tests/fas_b2_mordant_ks_parity.py`

---

## §10 Roll-up

| Category | Items | Effort to 100% | v1.x closure-grade impact |
|----------|-------|----------------|---------------------------|
| (a) in-repo software | 17 verbs spec-present + 4 verify scripts | **0 days remaining — ✅ (a) 100% REACHED 2026-05-13** | YES — silicon addition cleared the last gap |
| (b) measured-data parity | ~15 dataset-parity gates queued | Phase B/F (weeks-to-months); selftest implementation deferred | NO direct — but Phase B target enables v1.1.x stretch |

**Honest reading of "100% closure"**:
- **(a)** ✅ DONE 2026-05-13 — all 17 verbs spec-present, all 4 verify scripts PASS, scoreboard self-consistent. The silicon addition (commit `a239611`) cleared the last v1.x (a) gap. Phase D extended this to 29/29 (commit `99620b2`); Phase B layered a 21-gate selftest harness on top (commit forthcoming).
- **(c)** OUT-OF-REPO — wet-lab / vendor / fab adoption. Software-side discipline (no lattice fit on Wacker/GCL/etc.; vendor numbers vendored) is in place; closing the (c) gaps requires real-world counterparty selection that is not a software task.

---

## §11 Sister-substrate aggregator pattern

`verify/run_all.hexa` is the aggregator that runs all 4 verify scripts and exits 0 iff all PASS. This pattern matches the hexa-rtsc / hexa-ufo / hexa-cern / hexa-fusion sister substrates. The scoreboard rows in `README.md` Verify table + `hexa.toml [verify]` block are kept in sync by `verify/closure_consistency.hexa`.

The CLI dispatcher (`cli/hexa-matter.hexa`) carries the 17-verb table directly; `hexa-matter status` prints the live count from the dispatcher (not from any cached scoreboard).

---

## §12 Self-update protocol

When a verb / spec / verify script lands or is re-scoped:
1. Update `hexa.toml [verbs]` + `[verify]` first (SSOT for the scoreboard).
2. Run `hexa run verify/run_all.hexa` — all 4 scripts must PASS.
3. Update `README.md` (Run + Verify tables) + `AGENTS.md` (if AGENTS-visible policy change).
4. Update this file's §1 snapshot.
5. (Optional) Open or update a row in `CLOSURE_RESIDUAL_BACKLOG.md` if a (b) or (c) gap is touched.

raw_91 honest C3: this file is a *plan*, not a verification artifact. It does not change any closure-grade percentage; it makes the residual structure honest so the percentage is interpretable.

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation. (b)/(c) framework adapted from `hexa-bio/AXIS_CLOSURE_PLAN.md` (cycle-30, 2026-05-12) with the v1.x category (a) discipline already at 100% for hexa-matter.*
