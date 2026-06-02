# CROSS_LINK — sister-repo material-layer manifest

> **Last updated**: 2026-05-13
> **Purpose**: Manifest tracking material-layer overlaps between `hexa-matter`
> and its `hexa-*` sister substrates. **This is a written manifest, not a
> verified or executed integration.** No cross-repo CI runs, no shared
> registries, no auto-import — only documented boundary lines.
> **Scope**: which verbs in hexa-matter touch which sister's domain, what
> hexa-matter is responsible for, and what gets handed off.

---

## 1. Purpose — material-layer responsibility split

`hexa-matter` owns the **MATERIAL LAYER** only:
- Chemistry / crystal structure / phase / property table (spec-first, NIST/CRC/SEMI/ASTM/vendor-anchored)
- The 29 verb specs and their UNPROVEN/UNVERIFIED stamps
- `_python_bridge/` (RDKit/ASE/pymatgen compute), `_research_bridge/` (arxiv/web/patent absorption), `_absorption_bridge/` (Materials Project, GNoME, Matlantis, OMat24, universal-FF)

`hexa-matter` does **NOT** own:
- **Devices** built from the material (FET, solar cell, battery cell, magnet assembly, accelerator coil, …) — that is a sister repo's concern
- **Manufacturing process at scale** (fab line, foundry, recycling plant operations) — Category (c) per `AXIS_CLOSURE_PLAN.md`, out-of-repo by design
- **Wet-lab synthesis at production volume** — vendor / sister concern

external entities) and `INIT.md` rule #4 (SPEC_FIRST verdict preserved —
the repo does not own measurements).

---

## 2. Sister inventory

| Sister repo | On disk | Scope | Material-layer overlap with hexa-matter | Contact verb in hexa-matter |
|---|---|---|---|---|
| `hexa-rtsc` | ✅ | room-temp SC research (Tc=300K, Hc2=48T) | hypothesis-only `hxm-sc-*` candidates in `NOVEL.md` | (none yet wired; NOVEL.md ledger only) |
| `hexa-chip` | ✅ | 28-verb semiconductor stack (architecture / fab / EDA / packaging / NPU) | wafer-grade Si + compound-semi (GaN/SiC/GaAs/InP) MATERIAL spec | `silicon/`, `compound-semi/` |
| `hexa-energy` | ✅ | 14-verb energy substrate (battery / nuclear / grid / fuel-cell / thermal) | battery cathode + solid electrolyte material candidates (perovskite, MOF, carbon, magnetic for motors) | `perovskite/`, `mof/`, `carbon/`, `magnetic-materials/` |
| `hexa-bio` | ✅ | 5-axis molecular substrate (QUANTUM/WEAVE/NANOBOT/RIBOZYME/VIROCAPSID) | biomaterial substrates that touch wet-bio | `biodegradable-plastics/`, `wood-cellulose/` (cellulose nanocrystal CNC), `mof/` (drug-delivery cage candidate) |
| `hexa-fusion` | ✅ | 4-pillar fusion (D-T / p-11B / KSTAR-N6 / plasma-deep) | first-wall material + structural alloy (superalloy / W-Cu / SiC composite) | `superalloy/`, `compound-semi/` (SiC), `ceramics/` |
| `hexa-space` | ✅ | 27-verb space substrate (5 groups) | thermal-protection ceramics, aerospace alloys, carbon-fiber composites | `ceramics/`, `superalloy/`, `carbon/` (fiber), `aramid/` |
| `hexa-mobility` | ✅ | 11+ verb Stage-5 autonomy substrate (car / truck / robotaxi) | tire cord, structural composites, battery material, magnet for motors | `tire_cord/`, `carbon/`, `aramid/`, `magnetic-materials/`, `perovskite/` |
| `hexa-earth` | ✅ | 12-verb Earth substrate (climate / water / geo / defense) | concrete / cement / recycled steel / coastal-defense composites | `concrete/`, `concrete_tech/`, `recycling/`, `metallurgy/` |
| `hexa-cern` | ✅ | n=6 benchtop accelerator (3-pillar) | SC magnet alloy (NbTi / Nb₃Sn) + beam-line ceramics + vacuum-grade metals | `magnetic-materials/` (NdFeB context), `superalloy/`, `ceramics/` |
| `hexa-grid` | ✅ | 9-verb AI infrastructure fabric | copper interconnect, optical fiber glass, cooling-loop coolant materials | `metallurgy/` (Cu), `glass/`, `polymer-chemistry/` |
| `hexa-physics` | ✅ | 9-verb general physics (EM / fluid / gravity / thermo / optics / crystallography) | crystallography substrate (LATTICE_POLICY anchor) + optics-material (glass) | `silicon/` (lattice), `glass/`, `2d-materials/` |
| `hexa-cosmos` | ✅ | 3-pillar cosmology / particle / observatory | telescope mirror + detector-grade material | (informational only — observatory hardware abstracted) |
| `hexa-farm` | ✅ | 18-verb agriculture / food / coffee / wine / ecology | biodegradable mulch film, food-contact polymers | `biodegradable-plastics/`, `pet_film/` (food-contact use) |
| `hexa-arts` | ✅ | 24-verb arts / culture / games / linguistics / religion | lutherie (instrument wood + alloy), gemology (jewelry-arts) | `lutherie/`, `gemology/`, `wood-cellulose/` |
| `hexa-antimatter` | ✅ | 3-verb antimatter (factory / tabletop / PET-cyclotron) | trap-wall material (UHV-grade, low-outgassing) | `metallurgy/` (UHV Cu/Al), `ceramics/` (insulator) |
| `hexa-fantasy` | ✅ | 5-verb fantasy substrate (dragon / vampire / sf / snowflake_ice) — **fictional** | `snowflake_ice` touches ice / phase-transition physics only via metaphor | (none — academic metaphor; no factual claim) |
| `hexa-millennium` | ✅ | Clay 7 Millennium Problems — n=6 candidates | (no material-layer overlap — pure math substrate) | (none) |
| `hexa-aura` | ✅ | post-aural BCI chip substrate (4 pillars: clip / coil / cortex / safety) | mastoid clip material (Ti/PEEK), RT-SC nanocoil (downstream of `hexa-rtsc`) | (downstream of `hexa-rtsc`; informational) |
| `hexa-aero` | ❌ | (not on disk) | **FUTURE / not yet created** — would overlap on aerospace aluminum, Ti, GLARE laminate | (no contact verb until repo exists) |

19 sisters cataloged; 18 exist on disk, 1 (`hexa-aero`) does not.

---

## 3. Per-sister sections

### 3.1 `hexa-rtsc` — room-temp superconductor research

- **Their scope**: 2-verb RTSC + SC substrate; Tc=300K target; LK-99-class claims as research-hypothesis.
- **Our touch**: `NOVEL.md` carries `hxm-sc-*` candidate IDs as **hypothesis ledger only**.
- **No double claim**: hexa-matter must never quote a Tc as "achieved" — only "vendor-reported / lab-reported / UNPROVEN".

### 3.2 `hexa-chip` — semiconductor device + fab

- **Their scope**: 28 verbs across architecture / design / EDA / process / packaging / NPU / PIM / 3D / photonic / RTL-gen / yield. Korean fab heritage (Samsung / SK / Hynix / DRAM / HBM).
- **Our touch**: `silicon/silicon.md` (wafer / polysilicon / CZ / FZ / 9N anchor + Wacker / GCL / Hemlock vendor data) and `compound-semi/compound-semi.md` (GaN / SiC / GaAs / InP bandgap + Wolfspeed / II-VI / Sumitomo vendor data).
- **Boundary**: hexa-matter owns **wafer material** (purity, defect density, lattice constant, bandgap as a substrate property). hexa-chip owns **device + fab process** (lithography, EUV throughput, FinFET, GAA, yield, packaging).
- **Per-spec rule**: silicon.md must NOT duplicate ASML throughput / TSMC yield / Samsung HBM stack claims — those are device-process claims, not material-layer claims.

### 3.3 `hexa-energy` — battery + nuclear + grid + fuel-cell

- **Their scope**: 14 verbs across battery / nuclear / grid / fuel-cell / thermal / mining / meta. Out-of-scope axes redirect to `hexa-fusion`, `hexa-antimatter`, `hexa-rtsc`, `hexa-earth`.
- **Our touch**:
  - `perovskite/perovskite.md` — ABX₃ photovoltaic + oxide perovskite (LSM/LSCF cathode, solid-oxide fuel-cell material layer)
  - `mof/mof.md` — gas separation (H₂ storage, CH₄ adsorption) + DAC ($100/t MOF UNPROVEN)
  - `carbon/carbon.md` — battery anode candidate (hard carbon, Si-C composite)
  - `magnetic-materials/magnetic-materials.md` — NdFeB / SmCo / ferrite for motor + generator rotors
- **Boundary**: hexa-matter owns **cathode/anode chemistry as a material** (formula, capacity-per-gram as a substrate property anchored to NIST/CRC/vendor). hexa-energy owns **cell + pack + grid integration** (cycle life at the cell level, BMS, grid-tied inverter).
- **No double claim**: hexa-matter does not claim battery cell cycle-life — that's a cell-engineering claim that lives in `hexa-energy`.

### 3.4 `hexa-bio` — biomaterials

- **Their scope**: 5-axis molecular substrate (QUANTUM / WEAVE / NANOBOT / RIBOZYME / VIROCAPSID); 35/35 selftest gates; the **reference substrate** hexa-matter is being elevated against (per `INIT.md` Goal).
- **Our touch**:
  - `biodegradable-plastics/biodegradable-plastics.md` — PLA / PHA / PBS / starch blends (marine-biodegradability UNVERIFIED except certain PHA D7081)
  - `wood-cellulose/wood-cellulose.md` — cellulose nanocrystal (CNC) + nanocellulose (potential scaffold material for `hexa-bio/weave`)
  - `mof/mof.md` — drug-delivery cage candidate (informational; clinical claims live in `hexa-bio`)
- **Boundary**: hexa-matter owns the **polymer chain / cellulose structure / MOF cage as material**. hexa-bio owns **molecular biology, drug delivery efficacy, cell-scaffold biocompatibility at the wet-bio level**.
- **Imported patterns**: `_absorption_bridge/` design pattern + `NOVEL.md` ledger pattern were imported from `hexa-bio` (per `AGENTS.md` §"Sister-substrate cross-links"). hexa-bio is the reference, not a peer to be claimed.

### 3.5 `hexa-fusion` — first-wall + structural alloy

- **Their scope**: 4 pillars (FUSION D-T / TABLETOP_FUSION p-11B / FUSION_POWERPLANT KSTAR-N6 / PLASMA_DEEP). 1/4 wired with a 27-item ledger.
- **Our touch**: `superalloy/superalloy.md` (Ni-based / Co-based / Fe-Ni-based — first-wall candidate), `compound-semi/compound-semi.md` (SiC composite for plasma-facing), `ceramics/` (W / W-coated structural).
- **Boundary**: hexa-matter owns **alloy composition + creep + thermal-shock R parameter as material properties**. hexa-fusion owns **reactor design, neutron flux loading, ITER-spec compliance**.

### 3.6 `hexa-space` — TPS + airframe + composites

- **Their scope**: 27 verbs in 5 groups (core / engineering / observation / life / operations). RSC-saturated 2026-05-08.
- **Our touch**: `ceramics/` (TPS — reusable surface insulation tile material), `superalloy/` (turbine alloy, structural), `carbon/` (carbon-fiber composite for airframe), `aramid/` (Kevlar / Nomex for ablative + thermal).
- **Boundary**: hexa-matter owns **material property table at standard test conditions**. hexa-space owns **airframe design, re-entry thermal load, launch-cost-per-kg**.

### 3.7 `hexa-mobility` — tire cord, battery, motor magnet

- **Their scope**: 11 spec verbs Stage-5 autonomy (car / truck / robotaxi + lidar / camera / radar / sensor-fusion + planner / motion / HD-map / V2X / MRM / fleet).
- **Our touch**: `tire_cord/` (steel cord + aramid cord + nylon cord for tire), `carbon/` (CFRP for body), `aramid/` (Kevlar for ballistic / brake), `magnetic-materials/` (NdFeB for traction motor), `perovskite/` (LiDAR sensor PV candidate).
- **Boundary**: hexa-matter owns **cord tensile strength, magnet BHmax**. hexa-mobility owns **vehicle dynamics, AD stack, AEB validation**.

### 3.8 `hexa-earth` — concrete + recycling + coastal defense

- **Their scope**: 12-verb / 4-group (climate / water / geo / defense), v1.0.0 SPEC_FIRST.
- **Our touch**: `concrete/` and `concrete_tech/` (Portland cement, low-carbon cement, geopolymer), `recycling/` (steel + Al + glass + plastic recycling material), `metallurgy/` (recycled-steel alloy quality).
- **Boundary**: hexa-matter owns **concrete strength class, recycling yield as a material-level retention**. hexa-earth owns **climate impact accounting, infrastructure scale, watershed-level water budget**.

### 3.9 `hexa-cern` — SC magnet + beam-line material

- **Their scope**: 3-pillar benchtop accelerator (mini + parent + classical), 100 MeV target.
- **Our touch**: `magnetic-materials/` (NdFeB for steering; NbTi / Nb₃Sn for SC magnets is a downstream `hexa-rtsc` concern), `superalloy/` (beam-line vacuum chamber + structural), `ceramics/` (RF cavity ceramic + insulator).
- **Boundary**: hexa-matter owns **magnetic material BHmax + Curie temperature**. hexa-cern owns **beam dynamics, σ-cascade verification, accelerator-physics falsifiers**.

### 3.10 `hexa-grid` — AI infrastructure fabric

- **Their scope**: 9-verb fabric between `hexa-energy` (power), `hexa-chip` (compute), `hexa-codex` (model).
- **Our touch**: `metallurgy/` (Cu interconnect, Al busbar), `glass/` (optical fiber — single-mode silica glass), `polymer-chemistry/` (coolant: PAO / fluorinated dielectric).
- **Boundary**: hexa-matter owns **conductor resistivity, glass attenuation dB/km, coolant thermal conductivity**. hexa-grid owns **datacenter PUE, fiber backbone topology, AI-rack thermal design**.

### 3.11 `hexa-physics` — crystallography substrate

- **Their scope**: 9-verb general physics (EM / fluid / gravity-wave / thermo / optics / crystallography), candidate spec catalog.
- **Our touch**: `silicon/` (lattice constant + diamond-cubic crystal), `glass/` (amorphous SiO₂ + index of refraction), `2d-materials/` (MoS₂ / WS₂ / hBN — informs crystallography sub-pillar).
- **Boundary**: hexa-matter owns **crystal-property anchor values (lattice constant, density, refractive index)**. hexa-physics owns **closed-form n=6 derivations as theoretical candidates**.

### 3.12 `hexa-cosmos` — informational only

- **Their scope**: 3-pillar cosmology / particle / observatory. Candidate ΛCDM mapping.
- **Our touch**: telescope mirror grade glass (BK7 / Zerodur), CCD-grade Si — touched in passing in `glass/` and `silicon/` but **no formal contact verb**.

### 3.13 `hexa-farm` — biodegradable mulch + food-contact polymer

- **Their scope**: 18-verb (agriculture / food / coffee / wine / ecology), v0.1.0 spec catalog.
- **Our touch**: `biodegradable-plastics/` (mulch film; soil-biodegradable PBAT / PLA), `pet_film/` (food packaging PET — FDA 21 CFR 177.1630).
- **Boundary**: hexa-matter owns **polymer chemistry + degradation half-life as a substrate property**. hexa-farm owns **agronomic outcome, soil microbiome impact, food-safety claims**.

### 3.14 `hexa-arts` — lutherie + gemology

- **Their scope**: 24-verb arts / culture / games / linguistics / religion substrate.
- **Our touch**: `lutherie/` (instrument wood: spruce / maple / rosewood; brass alloy for bells), `gemology/` (diamond / corundum / beryl / quartz — GIA / IGS anchors), `wood-cellulose/` (acoustic wood + densified wood for instruments).
- **Boundary**: hexa-matter owns **wood density, Young's modulus, gemological refractive index**. hexa-arts owns **craft tradition, cultural context, instrument acoustics at the assembled-instrument level**.

### 3.15 `hexa-antimatter` — trap-wall + UHV material

- **Their scope**: 3-verb antimatter (factory + tabletop + PET cyclotron), 38/38 verify, 100% closure on F-AM-1/2/3/4.
- **Our touch**: `metallurgy/` (UHV-grade Cu / Al for trap walls, electropolished SS), `ceramics/` (alumina / sapphire window for laser injection).
- **Boundary**: hexa-matter owns **outgassing rate, UHV-grade surface roughness as material property**. hexa-antimatter owns **trap design, antiproton lifetime, PET-cyclotron yield**.

### 3.16 `hexa-fantasy` — no factual material claim

- **Their scope**: 5-verb fictional substrate (dragon / vampire / fantasy / sf / snowflake_ice). Literary metaphor only.
- **Our touch**: none — `snowflake_ice` touches phase-transition physics via metaphor; no factual material claim crosses the boundary.

### 3.17 `hexa-millennium` — pure math, no material overlap

- **Their scope**: Clay 7 Millennium Problems as n=6 closed-form candidates.
- **Our touch**: none. (Math substrate; no material layer.)

### 3.18 `hexa-aura` — downstream of hexa-rtsc

- **Their scope**: 4-pillar BCI chip (mastoid clip + RT-SC nanocoil + cortical IF + safety).
- **Our touch**: nanocoil is RT-SC-dependent → routes through `hexa-rtsc` first. Mastoid clip material (Ti / PEEK / silicone) touches `metallurgy/` + `polymer-chemistry/` but is informational only at this time.
- **Hard constraint**: hexa-aura's σ²=144-channel claim depends on RT-SC; hexa-matter MUST NOT claim hexa-aura's working device exists at material level. RT-SC remains UNPROVEN.

### 3.19 `hexa-aero` — FUTURE / not yet created

- **Status on disk**: `❌ MISSING` (`/Users/ghost/core/hexa-aero` does not exist).
- **Anticipated scope**: aerospace airframe substrate (Al 2024 / 7075, Ti 6Al-4V, GLARE laminate, aerospace CFRP).
- **Anticipated overlap**: would touch `metallurgy/`, `superalloy/`, `carbon/`, `aramid/`.
- **Action**: no cross-link until repo lands. Listed here for completeness so the manifest doesn't silently miss a future sister.

---

## 4. Boundary rules

1. **Material layer only**: hexa-matter spec docs describe materials by composition + structure + property table. Device-level + process-level + system-level claims belong in the sister.
2. **NIST/CRC/SEMI/ASTM/vendor anchor required** for every material property. hexa-matter never asserts a measurement.
3. **One-way reference**: hexa-matter references sister names + URLs for context, but does NOT pull live data from them. No cross-repo CI.
5. **UNPROVEN preserved across boundary**: LK-99, magic-MOF DAC, ambient metallic hydrogen, marine-biodegradability, hexa-aura σ²=144-channel — every flag that crosses a sister boundary stays UNPROVEN here as well.

---

## 5. No-double-claim rule

Verb specs in hexa-matter MUST NOT duplicate device/process/system claims from sister repos. Specifically:

- `silicon/silicon.md` MUST NOT claim ASML EUV throughput, TSMC yield, Samsung HBM stack height — those are `hexa-chip` device-process claims.
- `perovskite/perovskite.md` MUST NOT claim 25-year operating PV cell lifetime — that's `hexa-energy` cell-engineering territory and stays UNVERIFIED here.
- `mof/mof.md` MUST NOT claim DAC plant economics at scale — Climeworks $600–1000/t baseline is named; $100/t MOF stays UNPROVEN.
- `magnetic-materials/magnetic-materials.md` MUST NOT claim accelerator-magnet ramp rate or motor torque-density at the vehicle level — those are `hexa-cern` / `hexa-mobility` claims.
- `superalloy/superalloy.md` MUST NOT claim ITER first-wall lifetime in neutron-flux service — that's `hexa-fusion` territory.
- `concrete/` MUST NOT claim CO₂ accounting at watershed scale — that's `hexa-earth`.
- `NOVEL.md` `hxm-sc-*` MUST NOT claim Tc achieved — RT-SC stays UNPROVEN under `hexa-rtsc` / `LIMIT_BREAKTHROUGH.md`.
- `wood-cellulose/` MUST NOT claim biocompatibility for human implant — that's `hexa-bio` wet-bio territory.

If you (the agent) need to add a device-level claim, file it in the sister repo, not here. If you need cross-substrate validation, mark it as a Category (c) item in `CLOSURE_RESIDUAL_BACKLOG.md §C` (out-of-repo by design) and reference the sister by name.

---

## 6. Manifest status — honest disclaimer

This is a **written manifest**, not an executed or verified integration:

- No cross-repo CI runs. No shared registry. No auto-import.
- Each sister carries its own `verify/` + `selftest/` independently.
- "Material-layer overlap" rows reflect documentation review (top-of-README scope statements), not behavioral testing.
- If a sister's scope drifts, this manifest can go stale. Refresh by re-reading each sister's top-level README (or first ~50 lines of `INIT.md`).
- `hexa-aero` is listed as `FUTURE / not yet created`; do not infer it exists.

**Authoritative cross-link list for AI agents**: `AGENTS.md` §"Sister-substrate cross-links" remains the primary source; this manifest is the expanded version.

---

## 7. Supply-chain domain trio (added 2026-05-17)

Cross-cutting supply / criticality manifests sitting orthogonal to the 36 verbs:

| File | Scope | Cross-cuts verbs |
|---|---|---|
| [`RARE-EARTH.tape`](RARE-EARTH.tape) | 17-element family reference (LREE/HREE/Sc); USGS / IEA / EU CRM / 한국 종합대책 (1조 원 2026-02) anchors | `magnetic-materials/`, `metallurgy/`, `superalloy/`, `compound-semi/` (Sc/Y/Re/La/Ce trace) |
| [`RARE-EARTH+ALTERNATIVE.tape`](RARE-EARTH+ALTERNATIVE.tape) | Meta-domain (REE × substitution); 6-track roadmap (recycling · ferrite-hd · Mn-Al-C · boride · low-Dy/Tb · AI-found); 14+ arxiv 2024-2026 anchors; seeds 6 hxm-mag-* candidates in NOVEL.md §3.5 | `magnetic-materials/`, `recycling/`, `electrode-material/` (cross-class hybrids) |
| [`CRITICAL-MINERAL.tape`](CRITICAL-MINERAL.tape) | Umbrella for 12 export-controlled commodities (REE+Ga+Ge+Sb+W+Co+Li+graphite+Mg+Ti+Nb+Ta); 2023-2026 PRC export-control timeline | `compound-semi/` (Ga/Ge), `superalloy/` (Co/Re/W), `electrode-material/` (Li/graphite), `metallurgy/` (Mg/Ti/W) |

**Boundary**: this trio handles SUPPLY + CRITICALITY narratives. Per-verb MATERIAL spec (chemistry, phase, property table, parity gates) stays in the verb files. `NOVEL.md` candidates whose tag is `hxm-mag-*` are seeded by `RARE-EARTH+ALTERNATIVE.tape` but the ledger itself stays in `NOVEL.md` §3.5.

**Reverse cross-links established (2026-05-17)**:
- `MAGNETIC-MATERIALS.tape` → `[[RARE-EARTH+ALTERNATIVE]]` + `[[RARE-EARTH]]`
- `RECYCLING.tape` → `[[RARE-EARTH+ALTERNATIVE]]` + `[[CRITICAL-MINERAL]]`
- `METALLURGY-DEEP.tape` → `[[RARE-EARTH]]` + `[[CRITICAL-MINERAL]]`
- `COMPOUND-SEMI.tape` → `[[CRITICAL-MINERAL]]`
- `SUPERALLOY.tape` → `[[CRITICAL-MINERAL]]` + `[[RARE-EARTH]]`
