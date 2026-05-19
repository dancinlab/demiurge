# domain — energy (battery / nuclear / grid / fuel-cell)

> Status: **shallow public-surface map** (`design.md` Decision 3 hybrid).
> Boundary: public-surface clean-room (`design.md` Decision 1). Source:
> Agent-3 (cited). Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).

## 1. "Design blueprint" deliverable

A sized energy-system spec — cell/pack electrochemical model +
parameters, reactor core / neutronics model, or grid capacity-expansion
plan with techno-economic costing.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (application / market need; ISO / IEC standards per sub-domain) | — |
| 구조 ARCHITECT | (system topology; PyPSA network / OpenMC CSG geometry) | — |
| 설계 DESIGN | **PyBaMM** (physics-based battery models); **OpenMC** (Monte-Carlo neutronics, ANL / MIT); **OpenModelica** (incl. Nuclear library) | — |
| 해석 ANALYZE ⟲ | **NREL SAM / PySAM** (techno-economic analysis, BSD-3 open since 2017); PyBaMM experiment sim | — |
| 합성 SYNTHESIZE | **PyPSA** (power-system optimization w/ renewables / storage / sector-coupling) | — |
| 검증 VERIFY | **OpenMC vs Serpent** benchmarking; PyBaMM experiment validation | **Serpent** (Monte-Carlo neutronics, restricted distribution; reference benchmark vs OpenMC) |
| 인계 HANDOFF | (manufacturing / construction handoff per sub-domain) | — |

## 3. Notable proprietary (public docs only)

**Serpent** — Monte-Carlo neutronics, restricted distribution
(reference benchmark vs OpenMC); commercial deterministic core codes
also exist. Gap is moderate: open stack is broad across sub-domains
but **fragmented** — no single tool spans battery + nuclear + grid;
each sub-domain has a strong open option.

## 4. Biggest open-source gap

Cross-coupling / co-simulation glue across the sub-domains
(battery ↔ grid ↔ nuclear ↔ thermal) — strong point tools, weak
unified multi-domain energy-system integrator.

## 5. Cited sources

- PyBaMM — <https://github.com/pybamm-team/PyBaMM>
- OpenMC — <https://docs.openmc.org/en/latest/usersguide/beginners.html>
- OpenModelica Nuclear — <https://build.openmodelica.org/Documentation/Nuclear.html>
- PyPSA — <https://pypsa.org/>
- OpenMC vs Serpent benchmark — <https://www.mdpi.com/2673-4362/6/4/44>
- NREL SAM open source — <https://sam.nrel.gov/sam-open-source.html>, <https://github.com/NREL/SAM>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 에너지원 = 배터리 / 원자로 / 그리드
- 설계: 배터리 화학 = 리튬이온 / 전고체 / 나트륨이온
