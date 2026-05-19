# ABSORPTION empty-cells deep research — 2026-05-20

> Deep research (web + arxiv) for ABSORPTION.md measurable cells that have
> **no producer yet**. D53 measurable-only — only verb ∈ {synthesize ·
> verify · structure · analyze} cells are in scope (LLM 5-verb cells stay
> claude CLI fallback). **This note does NOT edit ABSORPTION.md** — another
> Agent is editing it. Findings are inbox-only; promote later via the
> Template prompt in ABSORPTION.md §"포그라운드 카탈로그".
>
> g3: honest — only tools/refs confirmed by actual web/arxiv searches this
> session. arxiv ids are real search hits. macOS-hostile tools flagged
> "blocked". No ABSORPTION.md row was added.

## 1. Cells WITH a producer (excluded from this survey)

chip(verify·synthesize·analyze) · component(synthesize·verify) ·
matter(analyze) · sscb(analyze) · grid(structure) · energy(analyze) ·
space(analyze) · brain(analyze) · mobility(analyze) · aura(analyze) ·
scope(analyze) · bot(structure) · antimatter(analyze) · cern(verify) ·
fusion(analyze).

Note: ABSORPTION.md §1 spine uses `structure` = the ARCHITECT verb. The
"grid+structure" and "bot+structure" producers (networkx · urdfpy) are the
cited filled cells. ARCHITECT/structure is mostly process, not measurable,
so few empty `structure` cells get strong candidates — flagged honestly.

## 2. Empty measurable-cell matrix

15 domains × {synthesize · verify · structure · analyze}. ✅ = filled,
`·` = empty (research target). `n/a` = no measurable producer plausible
(LLM/process verb — honest skip).

| domain     | synthesize | verify | structure | analyze |
|------------|-----------|--------|-----------|---------|
| chip       | ✅        | ✅     | ·         | ✅      |
| component  | ✅        | ✅     | ·         | **·**   |
| matter     | ·         | ·      | ·         | ✅      |
| sscb       | **·**     | **·**  | ·         | ✅      |
| grid       | **·**     | **·**  | ✅        | **·**   |
| energy     | **·**     | **·**  | ·         | ✅      |
| space      | **·**     | **·**  | ·         | ✅      |
| brain      | n/a       | n/a    | **·**     | ✅      |
| mobility   | **·**     | **·**  | ·         | ✅      |
| aura       | **·**     | ·      | ·         | ✅      |
| scope      | **·**     | **·**  | ·         | ✅      |
| bot        | **·**     | **·**  | ✅        | ✅      |
| antimatter | **·**     | **·**  | ·         | ✅      |
| cern       | **·**     | ✅     | ·         | **·**   |
| fusion     | **·**     | **·**  | ·         | ✅      |
| rtsc       | **·**     | **·**  | ·         | **·**   |

Bold `·` = researched below. Plain `·` (structure rows mostly, matter
synth/verify) = process/LLM verb, no OSS measurement producer — honest
skip per D53 (matter is a hexa-native invariant aggregator, no external
tool fits its synth/verify).

## 3. Per-cell candidates

ROI legend: ⭐ install cost vs measurement value. ⭐⭐⭐⭐⭐ = pip/brew
one-liner + immediate measured point; ⭐ = heavy/blocked.

### component + analyze  ⭐⭐⭐⭐
Domain §2 already names the OSS analyze stack. Lowest-fruit producer:
- **CalculiX (ccx)** — 3-D structural/thermomechanical FEA, free, brew/
  apt one-liner CLI. Reference: *OpenAM-SimCCX* framework paper (PMC
  PMC12608665, 2025) for CalculiX verification workflow.
- **Elmer FEM** — multiphysics (heat/structural/EM). apt `elmerfem-csc`.
  arxiv:1707.04080 (EOF-Library Elmer↔OpenFOAM coupler) is a clean-room
  citation source for the coupling pattern.
- ROI ⭐⭐⭐⭐ — component already has gmsh+scikit-fem (κ-44); CalculiX is
  a one-step extension to a measured stress/thermal point. D61: script
  SSOT `~/core/hexa-lang/stdlib/component/calculix.py`. GATE_OPEN.

### sscb + synthesize / sscb + verify  ⭐⭐⭐⭐⭐
sscb+analyze already filled (ngspice). Both empty cells reuse installed
tools — zero new install:
- **synthesize**: FEMMT + OpenMagnetics parameter sweep (magnetics
  sizing) — pip `femmt`. Already cited domains/sscb.md §2.
- **verify**: ngspice transient breaking-capacity check + OpenFOAM
  thermal margin (both already present for analyze). Reference:
  DEVSIM JOSS doi:10.21105/joss.03898 (Sanchez 2022) — TCAD clean-room
  citation; arxiv:2504.00214 (SEMIDV compact device sim w/ quantum
  effects) as algorithm reference.
- ROI ⭐⭐⭐⭐⭐ — tools installed; only a Swift Producer + Record + case.

### energy + synthesize / energy + verify  ⭐⭐⭐⭐⭐
- **synthesize**: **PyPSA** capacity-expansion optimization — pip
  `pypsa`. Already cited domains/energy.md §2.
- **verify**: **OpenMC** k-eff vs published benchmark (VERA / CEFR).
  pip/conda `openmc` (nuclear data needed). References (real arxiv/
  journal hits): arxiv:2506.22559 (OpenMC vs MCNP spent-fuel
  criticality benchmark, 2025); FNS-SINBAD shielding benchmark
  (Fusion Sci. Tech. doi:10.1080/15361055.2024.2323747).
- ROI ⭐⭐⭐⭐⭐ for PyPSA (pure pip); ⭐⭐⭐ for OpenMC (nuclear-data
  download ~GB, but Linux-clean via ubu pool).

### space + synthesize / space + verify  ⭐⭐⭐⭐
- **synthesize**: **OpenMDAO** multidisciplinary opt — pip `openmdao`.
  Couples with GMAT (already the analyze producer). Cited space.md §2.
- **verify**: **GMAT** trajectory validation + **Basilisk** ADCS sim.
  GMAT = NASA open binary; Basilisk = pip-buildable.
- ROI ⭐⭐⭐⭐ — OpenMDAO pure pip; GMAT binary download moderate.
  No arxiv needed (NASA open-source SSOT GSC-17177-1 is citation).

### mobility + synthesize / mobility + verify  ⭐⭐⭐
- **verify**: **CARLA + ScenarioRunner** OpenSCENARIO regression.
  References: arxiv:2311.09784 (VIVAS — system-level simulation-based
  V&V of AD with CARLA/ScenarioRunner, 2023); arxiv:2604.16452
  (OpenSCENARIO 2.1 → CARLA compiler).
- **synthesize**: PyTorch training pipeline on open AV datasets — not
  a single measurable producer (process). Honest skip / low priority.
- ROI ⭐⭐⭐ — CARLA is a heavy install (Unreal Engine, multi-GB GPU);
  Linux pool only. macOS host = **blocked** (CARLA has no maintained
  macOS build). Run on ubu pool or as a separate session.

### scope + synthesize / scope + verify  ⭐⭐⭐⭐⭐
- **synthesize**: **OpenMDAO** coupled optics+structure opt — pip
  `openmdao` (same as space).
- **verify**: **POPPY + WebbPSF** end-to-end PSF validation — pip
  `poppy webbpsf` (analyze producer already POPPY; verify = re-run as
  signoff vs flight-validated reference). synphot for photometric check.
- ROI ⭐⭐⭐⭐⭐ — all pure pip, small. No arxiv needed (POPPY/WebbPSF
  are the cited SSOTs; ASCL 1811.001 for synphot).

### bot + synthesize / bot + verify  ⭐⭐⭐⭐
- **synthesize**: **Pinocchio** rigid-body dynamics + analytic
  derivatives — pip `pin` / conda. **OMPL** sampling planners.
- **verify**: **Gazebo** regression + **Drake** verification primitives
  (Lyapunov / SOS / contact-implicit) — pip `drake`.
- ROI ⭐⭐⭐⭐ — Pinocchio/Drake pip-installable; Gazebo heavier (apt,
  Linux-clean). bot is the all-open reference domain — no proprietary
  gap, lowest-risk cells. No arxiv mandatory (stack-of-tasks /
  drake.mit.edu are SSOTs).

### antimatter + synthesize / antimatter + verify  ⭐⭐
- **verify**: **Geant4** antiproton stopping/annihilation. References
  (real arxiv hits): arxiv:2407.06721 (antiproton annihilation at rest
  in thin solid targets vs Geant4/FLUKA MC, 2024); arxiv:2503.04868
  (low-energy antiproton annihilation on nuclei, Geant4 v11.2.1
  FTFP_INCLXX_EMZ, 2025); arxiv:2604.21173 (positronium source
  modeling for Geant4 PET pipelines).
- **synthesize**: plasma-parameter optimization per antihydrogen-yield
  models (arxiv:2503.22471) — bespoke, no packaged OSS. Honest:
  no clean producer.
- ROI ⭐⭐ — Geant4 build is large (hours, C++); shares stack with
  cern/fusion. Best as a shared `transport` producer (see §4). Heavy —
  separate session.

### cern + synthesize / cern + analyze  ⭐⭐⭐⭐
- **synthesize**: **MAD-X / Xsuite** optics matching & optimization.
  References: arxiv:2310.00317 (Xsuite integrated beam-physics
  framework — optics functions + matched distributions); arxiv:
  2412.16006 (MAD-NG standalone linear/non-linear optics design).
- **analyze**: **elegant** (6-D tracking, dynamic aperture) or
  **Xsuite** GPU tracking. arxiv:2405.19163 (MAD-X space-charge
  matching); arxiv:2408.11677 (Lie-map lattice-error identification).
- ROI ⭐⭐⭐⭐ — Xsuite is pip `xsuite` (pure Python, light); MAD-X has
  a pip wheel (`cpymad`). elegant heavier (radiasoft container).
  Strong candidate — cern+verify already filled, this completes 3/4.

### fusion + synthesize / fusion + verify  ⭐⭐⭐⭐
- **verify**: **OpenMC** TBR + SDDR neutronics — pip/conda `openmc`.
  References: arxiv (OpenMC/Geant4 fusion-blanket TBR benchmark, DOI
  10.1007/s10894-025-00500-8 — already cited fusion.md §5); FNS-SINBAD
  fusion-neutronics validation doi:10.1080/15361055.2024.2323747.
- **synthesize**: engineering sizing (magnet/blanket/divertor) — no
  single OSS suite (domain §2 explicit). Honest skip.
- ROI ⭐⭐⭐⭐ for verify (OpenMC, shared with energy — same install).

### rtsc + verify  ⭐⭐⭐⭐  (whole domain currently 0 producers)
rtsc has **no producer in any cell** — highest-leverage empty domain.
- **verify**: **GetDP** open FEM solver (EM device analysis, H-/A-φ
  formulation for HTS). References: arxiv:0811.2883 (3-D FEM HTS
  magnetization, single-time-step iteration — the GetDP HTS algorithm
  paper); HTS Modelling Workgroup shared model files (htsmodelling.com).
- **analyze**: **FEMM** 2-D/axisymmetric magnetics (domain §2 design
  tool) — re-run as field-map measurement. FEMM is a known cohort
  pickup (see inbox/notes/cohort-pickup-rtsc-femm-producer.md).
- ROI ⭐⭐⭐⭐ — FEMM is light (Windows-native binary; on macOS via
  Wine = **partly blocked**, but `pyfemm` + xvfb on Linux pool works).
  GetDP = apt/brew `getdp` (Gmsh ecosystem, light). rtsc+analyze via
  FEMM is the existing cohort handoff — start there.

## 4. ROI-ordered priority

| rank | cell | producer | install | ROI | note |
|------|------|----------|---------|-----|------|
| 1 | sscb+synthesize | FEMMT sweep | (installed) | ⭐⭐⭐⭐⭐ | zero new install |
| 2 | sscb+verify | ngspice+OpenFOAM | (installed) | ⭐⭐⭐⭐⭐ | zero new install |
| 3 | scope+verify | POPPY/WebbPSF | pip | ⭐⭐⭐⭐⭐ | analyze tool re-run |
| 4 | scope+synthesize | OpenMDAO | pip | ⭐⭐⭐⭐⭐ | pure pip |
| 5 | energy+synthesize | PyPSA | pip | ⭐⭐⭐⭐⭐ | pure pip |
| 6 | component+analyze | CalculiX | brew/apt | ⭐⭐⭐⭐ | extends κ-44 |
| 7 | cern+synthesize | Xsuite/cpymad | pip | ⭐⭐⭐⭐ | completes cern 3/4 |
| 8 | space+synthesize | OpenMDAO | pip | ⭐⭐⭐⭐ | pure pip |
| 9 | bot+synthesize | Pinocchio | pip/conda | ⭐⭐⭐⭐ | all-open domain |
| 10 | rtsc+analyze | FEMM (pyfemm) | Linux pool | ⭐⭐⭐⭐ | existing cohort handoff |
| 11 | fusion+verify | OpenMC | conda+data | ⭐⭐⭐ | shares energy install |
| 12 | energy+verify | OpenMC | conda+data | ⭐⭐⭐ | nuclear-data GB |
| 13 | bot+verify | Drake/Gazebo | pip/apt | ⭐⭐⭐ | Gazebo heavier |
| 14 | cern+analyze | elegant/Xsuite | container | ⭐⭐⭐ | elegant heavier |
| 15 | space+verify | GMAT/Basilisk | binary | ⭐⭐⭐ | binary download |
| 16 | rtsc+verify | GetDP | apt/brew | ⭐⭐⭐ | HTS formulation work |
| 17 | mobility+verify | CARLA/ScenarioRunner | Linux pool | ⭐⭐ | macOS blocked |
| 18 | antimatter+verify | Geant4 | source build | ⭐⭐ | heavy; shared transport |

## 5. macOS-hostile / blocked — honest

- **CARLA** (mobility+verify) — no maintained macOS build; Unreal-based,
  multi-GB GPU. **Blocked on macOS host** — run on ubu Linux pool only.
- **FEMM** (rtsc) — Windows-native binary; macOS only via Wine.
  Mitigation: `pyfemm` headless on Linux pool with xvfb. **Partly
  blocked** on macOS host.
- **Geant4** (antimatter/cern/fusion verify) — not blocked, but a
  multi-hour C++ build. Recommend a single shared `transport` producer
  (Geant4 + OpenMC) per ABSORPTION.md README synthesis point 3
  ("transport abstraction serves 8/13 domains"), built once on the pool
  rather than per-domain. Heavy candidate → separate session.

## 6. Honest gaps / not researched

- **`structure` (ARCHITECT) cells** — mostly process verbs with no OSS
  measurement tool (per ABSORPTION.md README cross-domain synthesis:
  "SPECIFY/ARCHITECT/HANDOFF are domain-specific processes without
  consistent OSS tooling"). grid+structure (networkx) and bot+structure
  (urdfpy) are the rare measurable exceptions and are already filled.
  brain+structure left honest n/a — no measurable producer surfaced.
- **matter+synthesize / matter+verify** — matter is a hexa-native
  closure-invariant aggregator (D17); no external tool maps. Honest skip.
- **synthesize cells for antimatter / fusion** — domain §2 explicitly
  states no packaged OSS exists (bespoke engineering). Honest skip.
- **aura+verify** — openEMS antenna/SAR is plausible but Sim4Life MDDT
  gap means no measured-gate regulatory verify; openEMS is a light
  pip/apt candidate for a substrate analyze-grade check only. Listed
  low-priority; not deep-researched this pass.

## Log

- 2026-05-20 — created. Web + arxiv deep research for ABSORPTION.md
  empty measurable cells. 18 candidate cells ranked by ROI. arxiv ids
  are real search hits (2310.00317 · 2407.06721 · 2311.09784 · 0811.2883
  · 2506.22559 · 2503.04868 · 2604.16452 · 2412.16006 · 2405.19163 ·
  2408.11677 · 2504.00214 · 2604.21173). CARLA flagged macOS-blocked;
  FEMM partly blocked. ABSORPTION.md NOT edited (other Agent active).
