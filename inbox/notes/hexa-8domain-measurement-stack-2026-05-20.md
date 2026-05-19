# 8-domain real-measurement library stack survey (deep research)

> Date: 2026-05-20. Source: web + arxiv deep research (WebSearch/WebFetch).
> Scope: GOAL P-⑧ — turn the 8 demiurge domains from "1 substrate
> producer" into a **real-measurement full stack** verifiable by the
> demiurge 7-verb spine.
> Domain maps read: `domains/{rtsc,cern,antimatter,space,fusion,mobility,aura}.md`.
> **ufo — no domain map exists**; section is honest candidate-estimate only.
> g3 compliance: only web/arxiv-confirmed tools listed; unverified items
> flagged ⚠; giant tools (Geant4 / OpenFOAM-class) given honestly low ROI.

ROI legend: ⭐ = absorption cost into a demiurge producer.
⭐ low cost / fast win … ⭐⭐⭐⭐⭐ very heavy (C++ build, MPI, GUI-bound).

---

## 1. rtsc — superconducting / high-field magnet

**실측 정의** — coil quench behaviour: 3-D coupled electromagnetic +
thermal + (mechanical/stress) transient simulation of REBCO/Bi-2212
windings; critical-current / critical-state field maps; AC-loss budget;
quench-propagation velocity and hot-spot temperature. Validation =
predicted hot-spot T and quench-load (MIITs) vs measured.

**Full library stack**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **FiQuS** (CERN STEAM Finite Element Quench Simulator) | `pip install fiqus` (needs Gmsh + GetDP) | 1/2/3-D EM·thermal·coupled EM-TH quench of SC magnets incl. Pancake3D NI-HTS module | macOS/Linux | open (CERN open-science; GPL-class deps) | ⭐⭐⭐ |
| **FEMM** | brew cask / Windows-native (Wine on mac) | 2-D / axisymmetric magnetostatics, heat, current flow | Linux/mac via Wine | Aladdin free | ⭐⭐ |
| **GetDP** | `apt`/`conda`/brew | general FEM solver (EM device, A-V formulation) — FiQuS backend | macOS/Linux | GPL-2 | ⭐⭐⭐ |
| **Gmsh** | `pip install gmsh` | mesh/geometry generation — FiQuS backend | macOS/Linux | GPL-2 | ⭐⭐ |
| **FEM Magnetics Toolbox** | `pip install femmt` (GitHub upb-lea) | power-electronic magnetic component design, winding loss | macOS/Linux | GPL-3 | ⭐⭐ |
| **Elmer FEM** | `apt`/conda/Docker | multiphysics FEM (EM + thermal + structural) | macOS/Linux | GPL | ⭐⭐⭐⭐ |
| HTS Modelling Workgroup model files | download archive | reference REBCO/HTS critical-state benchmark cases | n/a (model files) | mixed | ⭐⭐ |
| NICQS / HETS / H-FoSTER | research codes, repo-by-repo | REBCO coil quench (alt. to FiQuS) | varies | ⚠ varies | ⭐⭐⭐ |

**arxiv / DOI references**

- arXiv:2311.09177 — *An Open-Source 3D FE Quench Simulation Tool for
  No-Insulation HTS Pancake Coils* (FiQuS Pancake3D).
- IEEE Trans. Appl. Supercond. (CDS 2856852, DOI 10.1109/TASC.2023.3258905)
  — *An Open-Source Finite Element Quench Simulation Tool for SC Magnets*.
- arXiv:2402.04034 — *A novel and coupled EM and electrothermal software
  for quench analysis of high-field magnets*.
- arXiv:2112.00682 — *Quasi-3D Magneto-Thermal Quench Simulation Scheme
  for Superconducting Accelerator Magnets*.
- arXiv:2509.06621 — *Screening currents increase thermal quench
  propagation speed in ultra-high-field REBCO magnets*.

**추천 first producer** — `rtsc/quench` wrapping **FiQuS** (Pancake3D):
the only confirmed open 3-D coupled EM-thermal quench code; supersedes
the current FEMM 2-D substrate. Output = hot-spot T, quench load.

---

## 2. cern — particle accelerator

**실측 정의** — two layers: (a) beam optics — lattice tracking, dynamic
aperture, 6-D particle tracking, collective effects; (b) detector
response — particle transport through detector matter + track/event
reconstruction. Validation = tracked Twiss/optics vs design, or
reconstructed track parameters vs truth.

**Full library stack**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **Xsuite** (Xtrack/Xpart/Xfields/Xdeps) | `pip install xsuite` | symplectic 6-D tracking, space charge, beam-beam, e-cloud, GPU | macOS/Linux | Apache-2.0 | ⭐⭐ |
| **cpymad / MAD-X** | `pip install cpymad` | de-facto lattice/optics language, Twiss, matching | macOS/Linux | MAD-X: CC-class; cpymad GPL-3 | ⭐⭐ |
| **elegant** | radiasoft `container-beamsim` Docker | dynamic aperture, 6-D tracking, floor coords | Linux (Docker on mac) | open (ANL) | ⭐⭐⭐ |
| **Geant4** | conda-forge / source build | MC particle transport through detector matter, radiation/shielding | macOS/Linux | Geant4 license (open) | ⭐⭐⭐⭐⭐ |
| **ACTS** (A Common Tracking Software) | source/CMake build; spack | experiment-independent charged-track reconstruction | macOS/Linux | MPL-2.0 | ⭐⭐⭐⭐ |
| **ROOT** | conda-forge / brew | event data model, histogramming, analysis I/O | macOS/Linux | LGPL-2.1 | ⭐⭐⭐⭐ |
| **DD4hep / Key4hep** | spack / conda | detector geometry description + turnkey sim→analysis stack | Linux (mac partial) | LGPL-3 | ⭐⭐⭐⭐ |
| **WarpX / BLAST** | conda / source | PIC plasma-based accelerator (advanced concepts) | macOS/Linux | BSD-3 | ⭐⭐⭐⭐ |

**arxiv / DOI references**

- arXiv:1910.03128 — *ACTS: A Common Tracking Software*.
- arXiv:2106.13593 / Springer EPJ Res.Infra. DOI 10.1007/s41781-021-00078-8
  — *A Common Tracking Software Project*.
- IPAC2024 WEPR56 (JACoW) — *Xsuite: An Integrated Beam Physics
  Simulation Framework*.
- EPJ N 2025, DOI 10.1051/epjn/2024059 — *The Geant4 software toolkit
  evolution over the past decade*.

**추천 first producer** — `cern/optics` wrapping **Xsuite + cpymad**:
pure-pip, Apache-2.0, runs on macOS, gives real 6-D tracking. Detector
side (Geant4/ACTS/ROOT) is heavy → defer.

---

## 3. antimatter — antiproton / positron trap + PET

**실측 정의** — non-neutral plasma dynamics in a Penning / Penning-Malmberg
trap: electrostatic equilibria, space-charge, rotation, sympathetic
cooling, temperature relaxation; antiproton/positron stopping &
annihilation cross-sections; antihydrogen yield. Validation = predicted
plasma T / density / annihilation profile vs measured.

**Full library stack**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **Geant4** | conda-forge / source | antiproton/positron–matter interaction, stopping, annihilation | macOS/Linux | Geant4 license | ⭐⭐⭐⭐⭐ |
| **PlasmaPy** | `pip install plasmapy` | plasma parameters (Debye length, frequencies, collision rates) — partial fit for non-neutral plasma | macOS/Linux | BSD-3 | ⭐ |
| **LAMMPS** | conda / brew / source | molecular-dynamics temperature-relaxation of trapped non-neutral plasma | macOS/Linux | GPL-2 | ⭐⭐⭐⭐ |
| **WarpX / Warp** | conda / source | PIC code; adaptable to non-neutral plasma in trap fields | macOS/Linux | BSD-3 | ⭐⭐⭐⭐ |
| **particle / PDG** (current substrate) | `pip install particle` | particle masses, lifetimes, PDG IDs | macOS/Linux | BSD-3 | ⭐ |
| **ARTIQ + Sinara** | `nix`/conda (m-labs) | open trap-control HW/SW ecosystem | Linux | LGPL-3 | ⭐⭐⭐ |

⚠ **honest gap**: no dominant packaged open-source non-neutral-plasma /
trap-dynamics simulator — confirmed by web search; groups use bespoke
PIC or MD codes. WarpX-PIC and LAMMPS-MD are adaptable proxies, not
purpose-built. This matches the domain map §4 gap (Agent-3 flagged).

**arxiv / DOI references**

- arXiv:2511.08849 — *Molecular Dynamics Simulations of Temperature
  Relaxation in Non-Neutral Plasmas Relevant to Antimatter Experiments*.
- Rev. Mod. Phys. 87:247 (Fajans & Surko) — trap physics reference.
- Phys. Plasmas 26:052511, DOI 10.1063/1.5092136 — *Electrostatic
  equilibria of non-neutral plasmas in a Penning trap with axially
  varying field*.
- Rev. Sci. Instrum. 92:123504 — *Non-neutral plasma manipulation
  techniques … high-capacity positron trap*.
- arXiv:2503.22471 — antihydrogen-yield model + ARTIQ/Sinara.

**추천 first producer** — `antimatter/plasma` wrapping **PlasmaPy** for
analytic plasma parameters (cheap ⭐), with an explicit honest note that
full trap PIC is a gap. Geant4 annihilation stays a deferred deep target.

---

## 4. space — spacecraft / launch / mission

**실측 정의** — orbit determination & propagation under perturbations
(J2/J3, drag, SRP, third-body); ΔV / maneuver planning; atmospheric
reentry aerothermal break-up; thermal balance. Validation = propagated
ephemeris vs reference (GMAT/Orekit) or observed TLE.

**Full library stack**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **skyfield** (current substrate) | `pip install skyfield` | ephemeris, satellite (SGP4) positions, rise/set | macOS/Linux | MIT | ⭐ |
| **poliastro** | `pip install poliastro` | orbit propagation, Lambert, J2/J3 + SRP perturbations, plotting | macOS/Linux | MIT | ⭐⭐ |
| **Orekit (orekit-python)** | `conda install -c conda-forge orekit` | high-fidelity OD, full perturbation force models, maneuvers | macOS/Linux | Apache-2.0 (Java+JCC) | ⭐⭐⭐ |
| **sgp4** | `pip install sgp4` | TLE propagation (reference SGP4/SDP4) | macOS/Linux | MIT | ⭐ |
| **tudatpy** | `conda install -c tudat tudatpy` | astrodynamics, OD, propagation, estimation | macOS/Linux | BSD-class | ⭐⭐⭐ |
| **NASA GMAT** | binary / source | trajectory modelling LEO→lunar→interplanetary (reference oracle) | macOS/Linux | Apache-2.0 / NOSA | ⭐⭐⭐⭐ |
| **Basilisk** | source build (AVS Lab) | spacecraft-centric mission / ADCS sim | macOS/Linux | ISC | ⭐⭐⭐⭐ |
| **OpenMDAO** | `pip install openmdao` | multidisciplinary optimization (couples with GMAT) | macOS/Linux | Apache-2.0 | ⭐⭐ |

⚠ reentry: **SCARAB** (HTG) and **DRAMA** (ESA) are the standard
aerothermal break-up codes but are **proprietary** (web-confirmed, not
open). No mature open reentry-thermal equivalent found → honest gap.

**arxiv / DOI references**

- SciPy Proceedings (majora-212e5952-015) — *poliastro: a Python library
  for interactive astrodynamics* (validated vs GMAT & Orekit).
- Acta Astronautica DOI 10.1016/S0273-1177(04)00082-1 — *Spacecraft
  destruction during re-entry … SCARAB software system*.
- NASA SE Handbook (SP-2016-6105 Rev2) — mission-phase requirements.

**추천 first producer** — `space/orbit` wrapping **poliastro** (or
Orekit for fidelity): real perturbed propagation, validated oracle,
upgrades the skyfield-only substrate.

---

## 5. fusion — tokamak / ICF reactor

**실측 정의** — plasma equilibrium (Grad-Shafranov / free-boundary),
edge / SOL turbulence & transport, MHD stability, neutron flux /
tritium-breeding-ratio (TBR), shutdown-dose-rate (SDDR). Validation =
predicted equilibrium / TBR / neutron spectrum vs benchmark
(MCNP / Serpent / SOLPS reference).

**Full library stack**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **plasmapy** (current substrate) | `pip install plasmapy` | plasma parameters, formulary | macOS/Linux | BSD-3 | ⭐ |
| **FreeGS** | `pip install freegs` | free-boundary Grad-Shafranov equilibrium | macOS/Linux | LGPL-3 | ⭐⭐ |
| **FreeGSNKE** | `pip install` (GitHub FusionComputingLab) | time-evolutive free-boundary equilibrium, MHD coupling | macOS/Linux | LGPL-class | ⭐⭐⭐ |
| **BOUT++ + Hermes-3** | conda / source (MPI) | edge/SOL plasma turbulence & transport | Linux (mac partial) | GPL-3 | ⭐⭐⭐⭐ |
| **OpenMC** | `conda install -c conda-forge openmc` | MC neutronics — TBR, neutron flux, SDDR | macOS/Linux | MIT | ⭐⭐⭐ |
| **DAGMC** | conda / source | CAD-based geometry bridge for MC neutronics | macOS/Linux | BSD-3 | ⭐⭐⭐ |
| **paramak** | `pip install paramak` | parametric fusion-reactor 3-D geometry for neutronics | macOS/Linux | MIT | ⭐⭐ |
| **Geant4** | conda-forge / source | radiation transport (public hadronic models) | macOS/Linux | Geant4 license | ⭐⭐⭐⭐⭐ |

⚠ **SOLPS-ITER** (edge plasma standard) is access-gated to ITER-member
institutions — not open. **MCNP/FLUKA** export-controlled / restricted.

**arxiv / DOI references**

- Phys. Plasmas 31:042517, DOI 10.1063/5.0188467 — *FreeGSNKE: A
  Python-based dynamic free-boundary toroidal plasma equilibrium solver*.
- arXiv:2303.12131 — BOUT++ / Hermes-3 edge turbulence.
- J. Fusion Energy DOI 10.1007/s10894-025-00500-8 — OpenMC / Geant4
  fusion-blanket TBR benchmark.
- Fusion Sci. Tech. DOI 10.1080/15361055.2024.2448414 — FLUKA fusion
  SDDR vs FNG-ITER benchmark.

**추천 first producer** — `fusion/equilibrium` wrapping **FreeGS** (then
FreeGSNKE): pure-pip, real Grad-Shafranov, upgrades plasmapy substrate.
`fusion/neutronics` (OpenMC) is a strong second.

---

## 6. mobility — autonomous-driving platform

**실측 정의** — traffic-flow simulation (microscopic), vehicle dynamics,
sensor-fusion perception/planning/control evaluation, scenario-based
safety verification (ISO 26262 / ISO 21448 SOTIF). Validation =
scenario-regression pass-rate, perception metrics vs labelled datasets.

**Full library stack**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **osmnx** (current substrate) | `pip install osmnx` | road-network graphs from OSM | macOS/Linux | MIT | ⭐ |
| **SUMO** | `pip install eclipse-sumo` / brew | microscopic multi-modal traffic flow, car-following | macOS/Linux | EPL-2.0 | ⭐⭐ |
| **CARLA** | binary / Docker (Unreal Engine) | high-fidelity 3-D driving sim, sensor models, OpenDRIVE | Linux (mac via Docker, heavy) | MIT code / CC-BY assets | ⭐⭐⭐⭐⭐ |
| **Autoware** | Docker / ROS 2 source | full perception+planning+control AV stack | Linux (ROS 2) | Apache-2.0 | ⭐⭐⭐⭐⭐ |
| **Apollo (Baidu)** | Docker | full AV stack | Linux | Apache-2.0 | ⭐⭐⭐⭐⭐ |
| **CommonRoad** | `pip install commonroad-io` | scenario benchmark + motion-planning verification | macOS/Linux | BSD/GPL mix | ⭐⭐ |
| **OpenSCENARIO / OpenDRIVE (esmini)** | `pip install` / binary (esmini) | ASAM scenario playback & lightweight sim | macOS/Linux | MPL-2.0 (esmini) | ⭐⭐ |
| **nuScenes / Waymo Open devkit** | `pip install nuscenes-devkit` | labelled AV perception datasets + eval metrics | macOS/Linux | CC-BY-NC / Apache | ⭐⭐ |

⚠ **honest gap** (per domain map §4): ISO 26262 + ISO 21448 SOTIF
safety-case / traceability tooling is entirely proprietary (medini,
DOORS) — no open equivalent.

**arxiv / DOI references**

- arXiv:2110.07111 — *A Novel Traffic Simulation Framework for Testing
  AVs Using SUMO and CARLA*.
- arXiv:2511.11310 — *Simulating an Autonomous System in CARLA using ROS 2*.
- CARLA: Dosovitskiy et al., CoRL 2017, arXiv:1711.03938 — original
  CARLA paper.
- nuScenes: Caesar et al., CVPR 2020, arXiv:1903.11027.

**추천 first producer** — `mobility/traffic` wrapping **SUMO**: pip-able,
macOS-native, real microscopic traffic-flow measurement; upgrades the
osmnx network-only substrate. CARLA/Autoware are heavy → defer.

---

## 7. aura — post-aural wearable BCI

**실측 정의** — EEG/EOG signal processing: artifact removal, spectral
analysis, source localization (forward/inverse), functional
connectivity; plus device side — antenna pattern / SAR. Validation =
source-localization accuracy vs open EEG datasets; connectivity-estimate
consistency.

**Full library stack**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **MNE-Python** (current substrate) | `pip install mne` | EEG/MEG preprocessing, source localization, connectivity | macOS/Linux | BSD-3 | ⭐ |
| **mne-connectivity** | `pip install mne-connectivity` | functional / effective connectivity estimators | macOS/Linux | BSD-3 | ⭐ |
| **MNE-NIRS / mne-bids** | `pip install` | dataset standardization (BIDS), pipeline structure | macOS/Linux | BSD-3 | ⭐ |
| **Brainstorm** | MATLAB / compiled standalone | source estimation, MRI integration, GUI workflows | macOS/Linux | GPL-3 | ⭐⭐⭐ |
| **FieldTrip** | MATLAB toolbox | beamformer/dipole source recon, connectivity, stats | macOS/Linux (MATLAB) | GPL | ⭐⭐⭐ |
| **MNE-Connectivity / PyEEG / YASA** | `pip install yasa` | spectral features, sleep staging (signal-quality checks) | macOS/Linux | BSD/MIT | ⭐ |
| **openEMS** | source build / Docker | FDTD EM solver — antenna pattern + SAR estimate | macOS/Linux | GPL-3 | ⭐⭐⭐⭐ |
| open EEG datasets (PhysioNet, BNCI Horizon) | download | reference validation data | n/a | mixed open | ⭐ |

⚠ gap: **Sim4Life** (FDA-MDDT MRI-safety) has no open equivalent —
openEMS is not MDDT-qualified (domain map §4).

**arxiv / DOI references**

- Gramfort et al. 2013, DOI 10.3389/fnins.2013.00267 — *MEG and EEG
  data analysis with MNE-Python*.
- Oostenveld et al. 2011, DOI 10.1155/2011/156869 — *FieldTrip: open
  source software for advanced MEG/EEG analysis*.
- Tadel et al. 2011, DOI 10.1155/2011/879716 — *Brainstorm*.
- Westner et al. 2022, NeuroImage DOI 10.1016/j.neuroimage.2021.118789
  — beamformer-implementation comparison (MNE/FieldTrip/SPM/Brainstorm).

**추천 first producer** — `aura/sourceloc` extending the existing
**MNE-Python** substrate from raw-signal toward source localization +
mne-connectivity (cheap, BSD-3, already partly present). openEMS SAR is
a deferred heavy target.

---

## 8. ufo — UAP / unidentified aerial phenomena

> ⚠ **No domain map exists** (`domains/ufo.md` absent). This section is
> an **honest candidate estimate** only — not a confirmed demiurge
> domain spec. Scope below is inferred from the public scientific UAP
> literature (Galileo Project), not from a demiurge §1 deliverable.

**실측 정의 (candidate)** — if "real measurement" for ufo means
*systematic instrumented aerial-phenomena census* (the only scientific
framing found), it = multi-band sky monitoring (IR/optical/radio/audio),
object detection & tracking, trajectory/kinematics estimation, and
sensor-fusion classification (natural vs human-made vs unknown). There
is **no physics first-principles "device blueprint"** here — unlike the
other 7 domains, ufo has no engineered artifact to design.

**Full library stack (candidate — generic instrumentation/CV tools)**

| tool | install | measures | OS | license | ROI |
|---|---|---|---|---|---|
| **astropy** | `pip install astropy` | celestial coords, time, known-object cross-match | macOS/Linux | BSD-3 | ⭐ |
| **skyfield** | `pip install skyfield` | satellite/aircraft-pass prediction (rule out knowns) | macOS/Linux | MIT | ⭐ |
| **OpenCV** | `pip install opencv-python` | object detection / tracking in camera frames | macOS/Linux | Apache-2.0 | ⭐⭐ |
| **YOLO / ultralytics** | `pip install ultralytics` | airborne-object detection / classification | macOS/Linux | AGPL-3 | ⭐⭐ |
| **ADS-B tooling (pyModeS, dump1090)** | `pip install pyModeS` | rule out known aircraft via transponder data | macOS/Linux | MIT/GPL | ⭐⭐ |
| Galileo Project pipeline | not packaged / not released as pip | reference methodology only | n/a | ⚠ not open library | n/a |

⚠ The Galileo Project (Harvard, Avi Loeb) all-sky IR array is the only
rigorous scientific UAP-instrumentation effort found; it is a
**research observatory + offline pipeline**, *not* a redistributable
open library. No purpose-built UAP measurement library exists.

**arxiv / DOI references**

- J. Astron. Instrum. DOI 10.1142/S2251171723400081 — *Integrated
  Computing Platform for Detection and Tracking of UAP* (Galileo).
- Sensors 2025 (Galileo all-sky IR camera array commissioning) — PMC11820869.
- Geosci. Instrum. DOI 10.5194/gi-14-335-2025 — *Geomagnetic variometer
  station as auxiliary instrumentation for the study of UAP*.

**추천 first producer** — none recommended until a demiurge `ufo` domain
map (§1 deliverable) is authored. If forced: a thin `ufo/census`
detector over astropy + skyfield + ADS-B (known-object rule-out) is the
only honest, evidence-grounded option. Recommend: **write the domain
map first**, then revisit.

---

## 9. 8-domain combined priority (ROI order)

ROI here = (first-producer absorption cost) × (substrate-upgrade value).
Lower ⭐ + clear pip path + macOS-native = higher priority.

| rank | domain | recommended first producer | core tool | absorb ⭐ | note |
|---|---|---|---|---|---|
| 1 | **aura** | `aura/sourceloc` | MNE-Python (+mne-connectivity) | ⭐ | substrate already MNE; pure extension, BSD-3 |
| 2 | **space** | `space/orbit` | poliastro | ⭐⭐ | pip MIT, validated vs GMAT/Orekit |
| 3 | **fusion** | `fusion/equilibrium` | FreeGS | ⭐⭐ | pip LGPL, real Grad-Shafranov |
| 4 | **cern** | `cern/optics` | Xsuite + cpymad | ⭐⭐ | pip Apache-2.0, real 6-D tracking, macOS-ok |
| 5 | **mobility** | `mobility/traffic` | SUMO | ⭐⭐ | pip EPL, macOS-native microscopic traffic |
| 6 | **antimatter** | `antimatter/plasma` | PlasmaPy | ⭐ (low value) | cheap but only analytic params; full PIC is a gap |
| 7 | **rtsc** | `rtsc/quench` | FiQuS (Pancake3D) | ⭐⭐⭐ | only open 3-D quench code; Gmsh+GetDP deps |
| 8 | **ufo** | — (write domain map first) | astropy+skyfield (fallback only) | n/a | no domain map; no purpose-built library exists |

**Headline findings**

- **Pure-pip quick wins**: aura, space, fusion, cern, mobility — five
  domains have a macOS-native pip-installable real-measurement tool that
  cleanly upgrades the current 1-point substrate. These are the GOAL-P-⑧
  fast path.
- **Honest gaps confirmed (g3)**: antimatter (no packaged non-neutral
  plasma simulator), rtsc 3-D coupled multiphysics (only FiQuS, with
  heavy deps), space reentry (SCARAB/DRAMA proprietary), mobility SOTIF
  safety-tooling (proprietary), fusion SOLPS-ITER (access-gated). All
  match the existing domain-map §4 gap statements.
- **ufo**: no domain map, no physics artifact, no purpose-built library
  — flagged honestly; recommend authoring `domains/ufo.md` before any
  producer work.
- **Giant tools honestly down-ranked**: Geant4, CARLA, Autoware, Apollo,
  ANSYS/COMSOL-class all rated ⭐⭐⭐⭐–⭐⭐⭐⭐⭐ — real but heavy; not
  first-producer candidates.

---

## Sources

- FiQuS / quench — https://arxiv.org/pdf/2311.09177 ·
  https://cds.cern.ch/record/2856852 · https://pypi.org/project/fiqus/ ·
  https://steam.docs.cern.ch/tools/fiqus/ · https://arxiv.org/html/2402.04034v1 ·
  https://arxiv.org/pdf/2112.00682 · https://arxiv.org/html/2509.06621v1
- Plasma / fusion — https://github.com/PlasmaPy/PlasmaPy ·
  https://pubs.aip.org/aip/pop/article/31/4/042517/3286904 ·
  https://github.com/freegs-plasma/freegs · https://link.springer.com/article/10.1007/s10894-025-00500-8
- Accelerator — https://arxiv.org/pdf/1910.03128 ·
  https://link.springer.com/article/10.1007/s41781-021-00078-8 ·
  https://proceedings.jacow.org/ipac2024/pdf/WEPR56.pdf ·
  https://xsuite.readthedocs.io/en/latest/installation.html ·
  https://www.epj-n.org/articles/epjn/full_html/2025/01/epjn20240059/epjn20240059.html
- Antimatter — https://arxiv.org/pdf/2511.08849 ·
  https://pubs.aip.org/aip/pop/article/26/5/052511/1061717 ·
  https://pubs.aip.org/aip/rsi/article/92/12/123504/283244
- Space — https://github.com/poliastro/poliastro ·
  https://proceedings.scipy.org/articles/majora-212e5952-015 ·
  https://www.htg-gmbh.com/en/htg-gmbh/software/scarab/
- Mobility — https://arxiv.org/abs/2110.07111 ·
  https://arxiv.org/pdf/2511.11310 · https://carla.org/
- Aura — https://github.com/mne-tools/mne-python ·
  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3872725/ ·
  https://pubmed.ncbi.nlm.nih.gov/21253357/ · https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7322560/
- UFO/UAP — https://www.worldscientific.com/doi/10.1142/S2251171723400081 ·
  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11820869/ ·
  https://gi.copernicus.org/articles/14/335/2025/
