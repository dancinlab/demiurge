# domain — component (part / package / system design)

> Status: **shallow public-surface map** (`design.md` Decision 3
> hybrid). Boundary: public-surface clean-room (`design.md` Decision
> 1). Created by **`design.md` Decision 21** (component = new
> top-level domain, the chain's 3rd 7-verb pass; fed by the
> chip→component typed seam, rfc_008). Pipeline = 7-verb spine
> (`HANDOFF.md` §4 · D5).
> **Provenance (honest, g3)**: drafted from general public-domain
> knowledge of the OSS component/EM/thermal/mechanical landscape —
> **NOT session-retrieved**. ⚠ Where a tool is named from general
> knowledge it is flagged; full cited-agent research (parity with
> the Agent-cited Cohort maps) = a scheduled follow-on, not claimed
> done here.

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
| 설계 DESIGN | **KiCad** (PCB / package layout, footprints); **FreeCAD** (3D enclosure / mechanical CAD); **gmsh** (analysis mesh generation) | **Cadence Allegro / Sigrity**, **Siemens HyperLynx** — ⚠ *named from general knowledge, not retrieved source* |
| 해석 ANALYZE ⟲ | **Elmer FEM** (multiphysics: thermal / structural / EM); **openEMS** (FDTD full-wave EM / signal integrity); **FEMM** (2D electrostatic / magnetic); **CalculiX** · **Code_Aster** (structural FEA); **OpenFOAM** (CFD / conjugate heat transfer) | **ANSYS Icepak / HFSS / Mechanical**, **COMSOL Multiphysics** — ⚠ *named from general knowledge, not retrieved source* |
| 합성 SYNTHESIZE | **OpenMDAO** (multidisciplinary design optimization — couples the thermal / EM / mechanical analyses into one optimized package + board definition) | — |
| 검증 VERIFY | Elmer / openEMS / CalculiX re-run as signoff (thermal margin, SI eye, stress); design-rule checks in KiCad | **ANSYS / COMSOL** signoff — ⚠ *general knowledge* |
| 인계 HANDOFF | system bill-of-materials + thermal / EM dossier (rfc_004 §4 wording) → manufacturing / next chain consumer | — |

## 3. Notable proprietary (public docs only)

The mechanical/EM/thermal CAE space is **commercially dominated**:
**ANSYS** (Icepak thermal, HFSS full-wave EM, Mechanical FEA),
**COMSOL Multiphysics**, **Cadence** (Allegro package/PCB, Sigrity
PI/SI), **Siemens** (Simcenter FloTHERM, HyperLynx). All named from
general engineering knowledge / public marketing — ⚠ *not detailed
from retrieved sources, flagged*. The open stack (Elmer, openEMS,
CalculiX, OpenFOAM, KiCad, FreeCAD) covers the physics individually
but requires integration glue (the OpenMDAO role above).

## 4. Biggest open-source gap

A unified package/board/system co-design environment with
production-grade SI/PI + thermal + mechanical in one polished loop —
the open pieces are individually strong but the integrated,
signoff-quality flow is proprietary (ANSYS/Cadence/Siemens class).

## 5. Cited sources

> ⚠ The links below are the projects' canonical home pages from
> general public knowledge — **not session-retrieved citations**.
> Listed for traceability; a full cited-research pass is the
> scheduled follow-on (honest provenance parity with the
> Agent-cited Cohort maps).

- KiCad — <https://www.kicad.org/>
- FreeCAD — <https://www.freecad.org/>
- Elmer FEM — <https://www.elmerfem.org/>
- openEMS — <https://www.openems.de/>
- FEMM — <https://www.femm.info/>
- CalculiX — <http://www.calculix.de/>
- Code_Aster — <https://www.code-aster.org/>
- OpenFOAM — <https://www.openfoam.com/>
- gmsh — <https://gmsh.info/>
- OpenMDAO — <https://openmdao.org/>
