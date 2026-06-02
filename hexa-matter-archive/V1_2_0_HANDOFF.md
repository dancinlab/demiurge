# V1_2_0_HANDOFF — Phase B-G roadmap (future-facing)

> **Created**: 2026-05-13 (Phase A elevation) · **Status**: future-facing handoff doc
> **Sibling**: `RELEASE_NOTES_v1.1.0.md` (current state) · `AXIS_CLOSURE_PLAN.md` (per-group residuals)
>
> This document sets expectations for **v1.2.0 and beyond** — what Phase B
> through Phase G will land, what is queued and not yet executed, and what
> the explicit `expecting` markers are.

---

## §0 Current state (as of v1.1.0, 2026-05-13)

- 17/17 verbs spec-present (silicon was the 17th, added 2026-05-13)
- 4/4 verify scripts PASS (`spec_presence`, `lattice_arithmetic`, `real_limits_anchor`, `closure_consistency`)
- 7-group taxonomy (CER / POL / FIB / MET / GEM / PRC / FAS) documented in `AXIS.md`
- (a) v1.x closure-grade = 100%
- (b) 29 parity gates queued (per `CLOSURE_RESIDUAL_BACKLOG.md §B`)
- (c) 15 wet-lab / fab items queued (per `CLOSURE_RESIDUAL_BACKLOG.md §C`)
- Phase A infrastructure docs landed (this commit)

The next major version (v1.2.0) targets **Phase B + Phase C** — selftest gates + per-group depth dirs. Phases D-G are queued behind that.

---

## §1 Phase B — selftest gates (target v1.2.0)

**Goal**: implement deterministic parity gates for the highest-leverage (b) items in `CLOSURE_RESIDUAL_BACKLOG.md §B`.

**Expected new files**:
- `tests/cer_b1_quartz_ri_parity.py` — NIST SRM quartz refractive-index parity vs `glass/glass.md`
- `tests/cer_b2_si_density_parity.py` — Si density CRC 2.329 g/cm³ vs Si-L6
- `tests/cer_b3_si_bandgap_parity.py` — Si bandgap NIST 1.12 eV vs Si-L7
- `tests/cer_b4_sic_bandgap_parity.py` — SiC bandgap 3.26 eV vs Si-L11
- `tests/cer_b5_si3n4_flexural_parity.py` — Si₃N₄ flexural ASM vs Si-L12
- `tests/pol_b1_aramid_tensile_parity.py` — Kevlar 49 vs ASM
- `tests/pol_b2_pet_hydrolysis_ea_parity.py` — PET E_a vs Marshall 1988
- `tests/pol_b4_nylon66_tg_tm_parity.py` — nylon-6,6 T_g/T_m vs CRC
- `tests/fib_b1_cellulose_xrd_parity.py` — cellulose crystallinity vs TAPPI T 271
- `tests/fib_b2_paper_tensile_parity.py` — paper tensile vs TAPPI T 494
- `tests/met_b1_inconel718_creep_parity.py` — Inconel 718 creep vs ASM vol. 1
- `tests/met_b2_ti6al4v_transition_parity.py` — Ti-6Al-4V α-β transition vs ASM vol. 2
- `tests/met_b3_ttt_1080_parity.py` — AISI 1080 TTT diagram vs ASM vol. 4
- `tests/gem_b1_corundum_ri_parity.py` — corundum n_d vs NIST
- `tests/gem_b2_ruby_fluorescence_parity.py` — ruby Cr³⁺ 694.3 nm vs NIST
- `tests/prc_b1_hales_packing_parity.py` — Hales 0.7405 numerical packing check
- `tests/fas_b1_reactive_dye_parity.py` — ISO 105 reactive dye yield

**Expected wiring**: each parity test gets a sentinel (`__<GROUP>_<GATE>__ PASS`) and is added to `verify/run_all.hexa` as a 5th-N script (or grouped into a `verify/parity_gates.hexa` aggregator).

**Expecting**: ~17 Phase B parity gates landing → `verify` scoreboard expands from 4 scripts to ~21 scripts (or 5 with a parity aggregator). `hexa.toml [verify].scripts_total` updates accordingly.

**Out of Phase B**: deterministic gates that require live database access (NIST SRD pull, MatWeb pull, ASTM standards pull) — these are Phase F.

---

## §2 Phase C — per-group depth dirs (target v1.2.0 or v1.3.0)

**Goal**: bring all 7 groups to per-group depth-dir parity with the existing CER pattern (`silicon/`, `glass/`, `ceramics/`, `concrete/`, `concrete_tech/`).

**Expected new dirs**:
- `superalloy/` (MET group) — Ni-based Inconel, single-crystal turbine blade, Ti grade-5
- `2d-materials/` (CER/POL hybrid; future GROUP_2D) — graphene, h-BN, MoS₂
- `compound-semi/` (CER/MET hybrid) — GaN, SiC device, GaAs, InP, AlN
- `perovskite/` (CER group) — ABO₃ family
- `elastomer/` (POL group) — natural rubber, SBR, EPDM, silicone elastomer
- `adhesive/` (POL group) — cyanoacrylate, polyurethane structural
- `mof/` (CER/POL hybrid) — metal-organic frameworks
- `liquid-crystal/` (POL group) — nematic, smectic, cholesteric
- `magnetic-materials/` (CER/MET hybrid) — NdFeB, SmCo, ferrite
- `biodegradable-plastics/` (POL group) — PLA, PHA, PBS
- `wood-cellulose/` (FIB group) — wood, nanocellulose

**Expected wiring**: each new depth dir gets a `<verb>/<verb>.md` spec file, added to `hexa.toml [verbs]` table, added to CLI dispatcher.

**Expecting**: 11 new depth dirs in Phase C, bringing the total depth-dir count from ~17 (one per current verb) to ~28.

**Coupled to Phase D** — Phase C depth-dirs are the home for Phase D new verbs.

---

## §3 Phase D — new verbs (target v2.0.0)

**Goal**: land 12+ new verbs documented as Phase D candidates in `DECOMPOSITION_PLAN.md §3`.

**Expected new verbs** (with target group):

| # | Verb | Group | Why |
|---|------|-------|------|
| 1 | compound-semi | CER | GaN, SiC device, GaAs, InP, AlN — wide-bandgap cluster |
| 2 | perovskite | CER | ABO₃ family + LK-99 status + MAPbI₃ solar |
| 3 | 2d-materials | new GROUP_2D | graphene, h-BN, MoS₂, WSe₂, phosphorene |
| 4 | elastomer | POL | natural rubber, SBR, EPDM, silicone elastomer |
| 5 | adhesive | POL | cyanoacrylate, polyurethane structural |
| 6 | biodegradable-plastics | POL | PLA, PHA, PBS, PHB, PCL |
| 7 | wood-cellulose | FIB | wood + lignocellulose + nanocellulose |
| 8 | superalloy | MET | Ni-based Inconel, single-crystal turbine blade |
| 9 | printing | PRC | additive manufacturing (FDM, SLS, SLA, DLP, MJF) |
| 10 | magnetic-materials | CER/MET | NdFeB, SmCo, ferrite, electrical steel |
| 11 | MOF | CER/POL | metal-organic frameworks |
| 12 | liquid-crystal | POL | LCD/OLED nematic, smectic, cholesteric |

**Expected verb count after Phase D**: **17 + 12 = 29 verbs**, 7-8 groups (possible addition of GROUP_2D for 2d-materials).

**Honest C3**: the 12-verb target is *engineering-driven*, not arithmetic-driven. If the actual landing is 11 verbs (one Phase D candidate gets re-classified as part of an existing verb), that is OK. If it's 14, also OK. The lattice does not get a vote.

**Expecting**: USER decision on which 3-5 verbs to land first. See `USER_ACTION_REQUIRED.md §2`.

---

## §4 Phase E — Python bridge `_python_bridge/module/` (target v2.0.0)

**Goal**: stand up a Python bridge module mirror to the hexa-bio pattern (`hexa-bio/_python_bridge/module/`).

**Expected new files**:
- `_python_bridge/module/hales_packing_calc.py` — FCC/HCP 0.7405 + random close pack + bidisperse extension (per Hales 2017 + Kepler conjecture)
- `_python_bridge/module/frenkel_strength_calc.py` — σ_th = E/10 calculator for any material (per Frenkel 1926)
- `_python_bridge/module/cz_si_dimension_calc.py` — Czochralski crucible/ingot geometry calculator (Si-L3 anchored)
- `_python_bridge/module/landauer_recycling_floor.py` — Gibbs ΔS_mix recycling energy floor (per L12)
- `_python_bridge/module/material_dse.py` — material design-space exploration (Ashby-chart driven)
- `_python_bridge/module/carbon_capture_calc.py` — already present at `origins/carbon-capture-calc/`; port to Python bridge module

**Expected wiring**: each bridge module gets a `--selftest` sentinel and is wired into `verify/run_all.hexa` (as a new `python_bridge_selftest.hexa` aggregator script, or each gets its own script line).

**Expecting**: 6+ Python bridge modules landing in Phase E.

**Cost discipline**: stdlib-only where possible (mirror hexa-bio's discipline). External deps (numpy, scipy) only where load-bearing.

---

## §5 Phase F — research bridge (target v2.x)

**Goal**: integrate live database access for material properties (currently spec docs cite vendor / NIST / CRC values; Phase F adds a programmatic fetch path).

**Target databases**:
- **MatWeb** (matweb.com) — industrial material database
- **NIST SRD** (Standard Reference Data) — NIST WebBook + Atomic Spectra Database + Phase Diagrams
- **ASTM Compass** — ASTM standards access
- **SEMI Standards** — SEMI M1 / PV17 / F121 / F47 silicon standards
- **CRC Handbook of Chemistry and Physics** — citation pull + value verification
- **Materials Project** (materialsproject.org) — DFT-calculated material properties
- **MatBench** — machine-learning material property benchmarks
- **AFLOW** — automatic-FLOW for materials discovery
- **OQMD** — Open Quantum Materials Database
- **NOMAD** — Novel Materials Discovery laboratory

**Expected new files**:
- `_python_bridge/module/research_bridge.py` — top-level bridge dispatcher
- `_python_bridge/module/matweb_fetch.py` — MatWeb fetch
- `_python_bridge/module/nist_srd_fetch.py` — NIST SRD fetch
- `_python_bridge/module/materials_project_fetch.py` — Materials Project fetch (via pymatgen API)


**Out of Phase F**: live-fetching during verify-script runs (would break determinism). Fetched data gets **vendored** as JSON snapshots at known SHAs, mirroring the hexa-bio pattern (`ribozyme/spec/gencode_v47_offtarget_risearch2_summary.json`).

---

## §6 Phase G — AlphaFold-class absorption (long horizon)

**Goal**: absorb large-scale material-property prediction capabilities (analogous to AlphaFold for protein structure).

**Candidate absorption targets**:
- **CALPHAD** (CALculation of PHase Diagrams) — thermodynamic assessment (FactSage, Thermo-Calc, OpenCalphad)
- **DFT calculation** (VASP, Quantum ESPRESSO, GPAW) — first-principles material property
- **Crystal structure prediction** (USPEX, CALYPSO, AIRSS) — *ab initio* phase prediction
- **MatGAN / CDVAE / DiffCSP** — generative AI for materials (analog to RFDiffusion for proteins)
- **DeepMind GNoME** (Graph Networks for Materials Exploration) — published 2023, ~2.2M stable crystal structures predicted

**Expected impact**: hexa-matter goes from 29 spec-shipping verbs (post-Phase D) to a substrate that can *predict* material parameters for novel compositions. This is the analog to hexa-bio's quantum-chemistry pocket VQE work (chem-accuracy across ~18 disease targets, per `LESSONS.md` v7.1 phase γ).

**Honest expectation**: Phase G is a *long horizon* item. Even hexa-bio's pocket VQE pipeline took ~30 cycles to mature. Phase G for hexa-matter will not land in v1.x or v2.x — more likely v3.x+ or a separate sister repo (`hexa-matter-predict`?) as the substrate matures.

---

## §7 Sequencing recommendation

Recommended phase order:

```
v1.1.0 (THIS RELEASE — 2026-05-13)
  └─ Phase A: infrastructure docs (10 infra + N expansion docs)

v1.2.0 (next ~weeks)
  ├─ Phase B: 17 parity gates (CER + POL + MET + FIB + GEM + PRC + FAS sample)
  └─ Phase C: 5-7 new depth dirs (superalloy/, perovskite/, compound-semi/, ...)

v2.0.0 (next ~months)
  ├─ Phase D: 12+ new verbs landing
  └─ Phase E: 6+ Python bridge modules

v2.x (longer horizon)
  └─ Phase F: research bridge to MatWeb / NIST SRD / Materials Project

v3.x+ (long horizon)
  └─ Phase G: AlphaFold-class material-property prediction
```

**Parallelization opportunity**: Phase B and Phase C are independent and can be parallel. Phase D depends on Phase C (depth dirs are the home for new verbs).

---

## §8 What is NOT in v1.2.0 (explicit)

To prevent scope creep, the following are NOT v1.2.0 deliverables:

- ❌ Hexa-bio-style 5-axis Bayesian σ-match audit (not applicable to material verbs; per `DECOMPOSITION_PLAN.md §5`)
- ❌ Lean4 formal verification (mirror of hexa-meta) — not a material-substrate concern
- ❌ Wet-lab / fab partnerships (these are category (c), out-of-software-scope; per `CLOSURE_RESIDUAL_BACKLOG.md §C`)
- ❌ Renaming the v1.x scoreboard verdict from `SPEC_FIRST` to something stronger until the underlying claim is true

---

## §9 Honest C3

- This file is a *roadmap*, not a commitment. Actual landing depends on user prioritization (see `USER_ACTION_REQUIRED.md`).
- The Phase B/C/D/E/F/G phase boundaries are *intentional decoupling*. We do not need to land all of B before any of C; depth-dir authoring for new groups (C) can proceed in parallel with parity-gate landing (B).
- The Phase D verb count (12) is an *engineering target*, not an arithmetic commitment. If Phase D delivers 9 or 15 verbs, both are fine.
- No n=6 lattice anchoring of any phase scope, verb count, or material parameter (per LATTICE_POLICY §1.2).

---

## §10 Expecting (active markers)

| Marker | Description | Phase target |
|--------|-------------|--------------|
| **expecting: B-CER-2 to close first** | Si density parity vs CRC is the lowest-hanging Phase B gate | v1.2.0 |
| **expecting: superalloy verb authored first in Phase D** | high industrial relevance + clean fit to existing GROUP_MET | v2.0.0 |
| **expecting: GROUP_2D added in Phase D** | 2d-materials (graphene, h-BN, MoS₂) is structurally different enough to warrant a new group | v2.0.0 |
| **expecting: user decision on Phase D priority** | which 3-5 verbs land first | v1.2.x window |
| **expecting: MatWeb research bridge first in Phase F** | broadest coverage, most flexible API | v2.x |
| **expecting: Phase G remains long-horizon** | DeepMind GNoME / CALPHAD / DFT absorption is multi-year | v3.x+ |

---

## §11 References

- `AXIS.md` — 7-group taxonomy
- `AXIS_CLOSURE_PLAN.md` — per-group (a)/(b)/(c) closure
- `CLOSURE_RESIDUAL_BACKLOG.md` — per-row deferral ledger
- `DECOMPOSITION_PLAN.md` — Phase D candidate verbs enumerated
- `LESSONS.md` — what worked / surprised / anti-patterns
- `RELEASE_NOTES_v1.0.0.md` — v1.0.0 retroactive notes
- `RELEASE_NOTES_v1.1.0.md` — v1.1.0 notes (silicon close + Phase A)
- `USER_ACTION_REQUIRED.md` — active asks
- `LATTICE_POLICY.md` — universal real-limits standard
- `LIMIT_BREAKTHROUGH.md` — Wave M audit
- `hexa-bio/V1_1_0_HANDOFF.md` — sister-substrate handoff style reference

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation. Future-facing v1.2.0 handoff doc.*
