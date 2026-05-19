# domain — component (part / package / system design)

> Status: **shallow public-surface map** (`design.md` Decision 3
> hybrid). Boundary: public-surface clean-room (`design.md` Decision
> 1). Created by **`design.md` Decision 21** (component = new
> top-level domain, the chain's 3rd 7-verb pass; fed by the
> chip→component typed seam, rfc_008). Pipeline = 7-verb spine
> (`HANDOFF.md` §4 · D5).
> **Provenance**: cited public-surface web research (this session) —
> parity with the Agent-cited Cohort maps.

## 1. "Design blueprint" deliverable

A package + board + enclosure definition for a given die: substrate /
bump / pin-out, power-delivery network, a thermal solution (heatsink
/ TIM / airflow), signal-integrity-clean routing, and a system
bill-of-materials + thermal/EM dossier — i.e. the chip's
`chip→component` handoff dossier (rfc_008) turned into a
manufacturable package/board/system.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (package/system requirements from the rfc_008 chip dossier: die, power, Tjmax, IO rates) | — |
| 구조 ARCHITECT | (package class & stackup choice: wirebond vs flip-chip vs fan-out; board layer plan) | — |
| 설계 DESIGN | **KiCad** (cross-platform OSS PCB design suite: schematic capture + PCB layout + routing); **FreeCAD** (open-source parametric 3D modeler for enclosure / mechanical CAD); **gmsh** (3D finite-element mesh generator with built-in CAD + pre/post) | **Cadence Allegro X** (PCB & IC-package design platform), **Siemens HyperLynx** (high-speed SI/PI design suite) |
| 해석 ANALYZE ⟲ | **Elmer FEM** (multiphysics FE solver: heat transfer / structural / electromagnetics / fluids); **openEMS** (free FDTD electromagnetic field solver — full-wave EM / signal integrity); **FEMM** (2D magnetics / electrostatics / heat-flow / current-flow FEM); **CalculiX** · **Code_Aster** (3D structural / thermomechanical FEA); **OpenFOAM** (open-source CFD incl. heat transfer in fluids and solids) | **ANSYS Icepak** (electronics-cooling CFD on the Fluent solver: IC/package/PCB airflow + temperature), **COMSOL Multiphysics** (coupled thermal / structural / EM simulation platform) |
| 합성 SYNTHESIZE | **OpenMDAO** (open-source multidisciplinary design analysis & optimization framework with analytic derivatives — couples the thermal / EM / mechanical analyses into one optimized package + board definition) | — |
| 검증 VERIFY | Elmer / openEMS / CalculiX re-run as signoff (thermal margin, SI eye, stress); electrical-rules / design-rule checks in KiCad | **ANSYS / COMSOL** signoff; **Cadence Sigrity X** (SI/PI + PDN / IR-drop signoff for package & PCB) |
| 인계 HANDOFF | system bill-of-materials + thermal / EM dossier (rfc_004 §4 wording) → manufacturing / next chain consumer | — |

## 3. Notable proprietary (public docs only)

The mechanical/EM/thermal CAE space is **commercially dominated**:
**ANSYS** (Icepak electronics-cooling CFD, plus HFSS full-wave EM and
Mechanical FEA — public marketing; only Icepak retrieved here),
**COMSOL Multiphysics** (unified coupled-physics platform),
**Cadence** (Allegro X package/PCB platform; Sigrity X for SI/PI +
PDN), **Siemens** (HyperLynx SI/PI; Simcenter FloTHERM electronics
thermal — FloTHERM named from the same Siemens search, ⚠ *not
separately retrieved*). The open stack (Elmer, openEMS, CalculiX,
OpenFOAM, KiCad, FreeCAD) covers the physics individually but
requires integration glue (the OpenMDAO role above).

## 4. Biggest open-source gap

A unified package/board/system co-design environment with
production-grade SI/PI + thermal + mechanical in one polished loop —
the open pieces are individually strong but the integrated,
signoff-quality flow is proprietary (ANSYS/Cadence/Siemens class). A
real published OSS chain exists (FreeCAD → gmsh → CalculiX →
ParaView, Antmicro) but is bespoke glue, not a turnkey environment.

## 5. Cited sources

- KiCad — <https://www.kicad.org/> (OSS PCB suite: schematic + layout + ERC)
- FreeCAD — <https://www.freecad.org/> (open-source parametric 3D modeler)
- gmsh — <https://gmsh.info/> (3D FE mesh generator + CAD + pre/post)
- Elmer FEM — <https://github.com/ElmerCSC/elmerfem> (multiphysics FE: thermal/structural/EM/fluid)
- openEMS — <https://www.openems.de/> (free FDTD EM field solver)
- FEMM — <https://www.femm.info/wiki/HomePage> (2D magnetics/electrostatics/heat/current FEM)
- CalculiX — <http://www.calculix.de/> (free 3D structural FEA program)
- Code_Aster — <https://www.code-aster.org/> (structural & thermomechanics FE software)
- OpenFOAM — <https://openfoam.org/> (OSS CFD incl. heat transfer in fluids/solids)
- OpenMDAO — <https://openmdao.org/> (OSS MDAO framework, analytic derivatives)
- ANSYS Icepak — <https://www.ansys.com/products/electronics/ansys-icepak> (electronics-cooling CFD, Fluent solver)
- COMSOL Multiphysics — <https://www.comsol.com/comsol-multiphysics> (coupled multiphysics simulation platform)
- Cadence Sigrity X / Allegro X — <https://www.cadence.com/en_US/home/tools/sigrity-x.html> (SI/PI + PDN; package/PCB platform)
- Siemens HyperLynx / Simcenter FloTHERM — <https://eda.sw.siemens.com/en-US/pcb/hyperlynx/> (high-speed SI/PI suite; FloTHERM = electronics thermal)
- OSS electro-thermal chain (corroboration) — <https://antmicro.com/blog/2025/03/open-source-thermal-simulation-analysis-and-visualization> (FreeCAD → gmsh → CalculiX → ParaView PCB thermal pipeline)

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 냉각 = 수동 방열 / 팬 / 수냉
- 설계: 기판 = 유기 / 세라믹 ; 재질 = 알루미늄 / 구리
