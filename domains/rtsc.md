# domain — RTSC (high-field / superconducting magnet & coil)

> Status: **shallow public-surface map** (`design.md` Decision 3 hybrid).
> Boundary: public-surface clean-room (`design.md` Decision 1). Source:
> Agent-3 (cited). Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).

## 1. "Design blueprint" deliverable

Coil winding geometry + conductor (REBCO / Bi-2212) layout, field map,
current / critical-state distribution, AC-loss and quench / stress
budget.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (target field / current / temperature spec) | — |
| 구조 ARCHITECT | (coil / cryostat layout) | — |
| 설계 DESIGN | **FEMM** (2-D / axisymmetric magnetics, electrostatics, heat & current flow) | — |
| 해석 ANALYZE ⟲ | **HTS Modelling Workgroup** shared REBCO / HTS critical-state model files | **ANSYS Maxwell**, **COMSOL**, **Opera**, **JMAG** (3-D coupled EM-thermal-quench) |
| 합성 SYNTHESIZE | **FEM Magnetics Toolbox** (power-electronic magnetic components); FEMM winding definition | — |
| 검증 VERIFY | **GetDP / Elmer** open FEM solvers for EM device analysis | ANSYS A-V formulation (REBCO tape-stack magnetization) — public docs only |
| 인계 HANDOFF | (winding / cryostat fabrication handoff) | — |

## 3. Notable proprietary (public docs only)

**ANSYS Maxwell**, **COMSOL Multiphysics**, **Opera**, **JMAG**. ANSYS
A-V formulation is widely used for REBCO tape-stack magnetization
(HTS workgroup public ref). Gap is large for **3-D, multiphysics
(EM + thermal + structural quench)** HTS modelling — open FEMM is
essentially 2-D / axisymmetric; the 3-D HTS coupled workflow is
dominated by ANSYS / COMSOL.

## 4. Biggest open-source gap

3-D coupled EM–thermal–mechanical quench / AC-loss simulation for
REBCO / Bi-2212 coils (open tooling is 2-D-limited).

## 5. Cited sources

- FEMM — <https://sourceforge.net/projects/femm/>, <https://github.com/cenit/FEMM>
- FEM Magnetics Toolbox — <https://github.com/upb-lea/FEM_Magnetics_Toolbox>
- HTS Modelling Workgroup — <https://htsmodelling.com/?page_id=748>, <https://htsmodelling.com/model-files/archive/2024/03>
- Proprietary EM tools survey — <https://www.researchgate.net/post/Other_than_maxwell_what_are_the_softwares_available_for_electric_motor_design>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 권선 = 팬케이크 / 솔레노이드
- 설계: 도체 = REBCO / Bi-2212
