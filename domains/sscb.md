# domain — SSCB (solid-state DC circuit breaker)

> Status: **shallow public-surface map** (Cohort 2, `design.md` Decision 6).
> Boundary: public-surface clean-room (`design.md` Decision 1). Pipeline =
> 7-verb spine (`HANDOFF.md` §4 · D5). **Note**: VERIFY gate is dominated
> by certification standards (UL 489I 1st ed. Oct 2025 for SSCBs; IEC
> 60947-2; UL Solutions harmonization in progress) — a regulatory verify
> pattern analogous to `brain.md` but with mature open lab tooling at
> earlier verbs.

## 1. "Design blueprint" deliverable

A SiC / GaN-based solid-state interrupter spec — power semiconductor
selection + paralleling, gate-drive and snubber design, magnetic
limiter / commutation circuit, thermal management, mechanical isolation
(galvanic disconnect), plus certification dossier (UL 489I, IEC 60947-2,
type-test breaking capacity). Target: ≤ 1 µs DC fault interruption per
HEXA-SSCB mk1 spec (600 ns).

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (voltage / current / Icu+Ics breaking capacity per IEC 60947-2; UL 489I 1st ed. 2025 for SSCB / SSHCB ≤ 1000 Vac / 1500 Vdc; IEEE C37.x) | — |
| 구조 ARCHITECT | (semiconductor / mechanical-disconnect topology; pure-SS vs hybrid SSHCB) | — |
| 설계 DESIGN | **KiCad** (PCB, embedded ngspice for SPICE — `kicad.org/discover/spice/`); **ngspice** (open SPICE, FOSDEM'24 power-MOSFET VDMOS + JFET temp models) | **Cadence Virtuoso** · **Synopsys Custom Compiler** (custom IC design — public docs) |
| 해석 ANALYZE ⟲ | **DEVSIM** (open TCAD, Apache-2.0 since 2013; drift-diffusion + density-gradient quantum; JOSS 10.21105/joss.03898); **FEMMT** + **OpenMagnetics** (FEM magnetics — UPB-LEA + IEEE PELS); **OpenFOAM** (conjugate heat transfer for liquid-cooled stacks — Int. J. Heat Fluid Flow 2020) | **Synopsys Sentaurus TCAD**; **ANSYS Maxwell** / **Q3D** (3-D parasitic extraction) |
| 합성 SYNTHESIZE | (paralleled-die layout + magnetics sizing via FEMMT parameter sweeps) | — |
| 검증 VERIFY | ngspice + KiCad transient verification; OpenFOAM thermal margin | **PLECS Standalone** (Plexim — switched-system time-domain reference; PLECS Blockset = Simulink integration); **MATLAB / Simulink** + **Simscape Electrical** |
| 인계 HANDOFF | (UL / TÜV / KTL type-test submission per UL 489I + IEC 60947-2; harmonization track per UL Solutions) | — |

## 3. Notable proprietary (public docs only)

**Synopsys Sentaurus TCAD** is the certified industry reference for
semiconductor physics; **ANSYS Maxwell / Q3D** for 3-D EM parasitics;
**PLECS** (Plexim, Standalone + Blockset) is the de-facto power-electronics
switched-system simulator; **MATLAB / Simulink + Simscape Electrical**
for control + plant co-sim. The 4-foundry Korean stack (Magnachip /
DB HiTek / SK Keyfoundry / KEC for SiC / Si — ⚠ *vendor identities not
re-verified per file*) wraps proprietary PDKs around these tools.

## 4. Biggest open-source gap

Hard-switched fast-transient SiC / GaN co-simulation at PLECS parity
with calibrated commercial device models — ngspice + DEVSIM cover
physics-level device modelling, but PLECS-class abstract-switch +
nanosecond-resolution circuit-level workflow has no equivalent open
toolchain. The UL 489I certification path itself is also proprietary
(accredited lab only).

## 5. Cited sources

- DEVSIM — <https://github.com/devsim/devsim>, <https://joss.theoj.org/papers/10.21105/joss.03898>
- ngspice + KiCad integration — <https://www.kicad.org/discover/spice/>, <https://ngspice.sourceforge.io/news.html>, <https://archive.fosdem.org/2024/events/attachments/fosdem-2024-2834-ngspice-circuit-simulator-stand-alone-and-embedded-into-kicad/slides/22676/ngspice-HolgerVogt_tEfhemB.pdf>
- FEMMT — <https://github.com/upb-lea/FEM_Magnetics_Toolbox>
- OpenMagnetics — <https://www.ieee-pels.org/magazine/openmagnetics-an-online-toolbox-for-designing-and-simulating-magnetics/>
- OpenFOAM CHT liquid cooling for power electronics — <https://www.sciencedirect.com/science/article/abs/pii/S0142727X19309269>
- UL 489I 1st ed. (Oct 2025) — <https://webstore.ansi.org/standards/ul/ul489ied2025>, <https://www.ul.com/insights/path-safety-and-quality-solid-state-circuit-breakers>
- IEC 60947-2 vs UL 489 — <https://sinobreaker.com/iec-60947-2-vs-ul-489/>
- PLECS Standalone / Blockset — <https://www.plexim.com/products/plecs/plecs_standalone>, <https://www.plexim.com/products/plecs/plecs_blockset>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 차단 방식 = 기계식 / 솔리드스테이트 / 하이브리드
- 설계: 반도체 = SiC / GaN
