# domain — mobility (stage-5 autonomous-driving platform)

> Status: **shallow public-surface map** (Cohort 2, `design.md` Decision 6).
> Boundary: public-surface clean-room (`design.md` Decision 1). Pipeline =
> 7-verb spine (`HANDOFF.md` §4 · D5). **Note**: VERIFY gate is the
> dominant proprietary surface — ISO 26262 (functional safety, system
> failures) + ISO 21448 SOTIF (insufficiency of intended behaviour) are
> both load-bearing for SAE L4 / L5 type-approval (UN R157 for ALKS).
> This is the cohort's hardest SPECIFY / VERIFY stress-test.

## 1. "Design blueprint" deliverable

A stage-5 (SAE L5) AV platform spec — perception + localization +
planning + control stack with sensor fusion (camera + lidar + radar +
IMU), vehicle ECU + AUTOSAR Classic / Adaptive partitioning, ODD
(operational design domain) definition, and dual ISO 26262 + ISO 21448
safety case. Variants: passenger / truck / robotaxi.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (ODD + scenario catalog per ASAM **OpenSCENARIO XML 1.x** / **OpenSCENARIO DSL 2.x**; ISO 26262 hazard analysis; ISO 21448 SOTIF triggering-condition catalog; UN R157 ALKS reg) | **IBM DOORS** / **Jama Connect** (requirements; public marketing) |
| 구조 ARCHITECT | **AUTOSAR Classic** + **AUTOSAR Adaptive** (specs publicly published — autosar.org); ROS 2 node graph | **Vector PREEvision** (E/E architecture; public docs) |
| 설계 DESIGN | **Apollo** (Baidu, Apache-2.0; full perception + planning + control stack); **Autoware** (Autoware Foundation, Apache-2.0; ROS 2-based, 500+ deployments); **ROS 2** (Humble / Iron / Jazzy) | **MATLAB / Simulink** (Model-Based Design); **dSPACE SystemDesk**; **Vector DaVinci Developer** |
| 해석 ANALYZE ⟲ | **CARLA** (MIT code + CC-BY assets + Unreal Engine; ASAM OpenDRIVE roads); **SUMO** (Eclipse, traffic-flow co-sim with CARLA); ROS 2 perception / planning eval pipelines | **IPG CarMaker**; **ANSYS VRXPERIENCE** / AVxcelerate; **dSPACE AURELION**; **Vector CANoe** |
| 합성 SYNTHESIZE | (ML training pipelines: PyTorch + open AV datasets — nuScenes, Waymo Open, KITTI); Autoware Core / Universe split | **MathWorks Embedded Coder** / **TargetLink** (auto-codegen for AUTOSAR ECU) |
| 검증 VERIFY | OpenSCENARIO scenario regression in CARLA; Autoware safety-certifiable engineering process | **dSPACE SCALEXIO** HIL; **Vector CANoe**; **ANSYS medini analyze** (ISO 26262 / 21448 tooling); **Parasoft C/C++test** (MISRA / ISO 26262) |
| 인계 HANDOFF | (type-approval per UN R157 ALKS + ISO 26262 work products + ISO 21448 SOTIF validation report; NHTSA voluntary safety self-assessment in US) | — |

## 3. Notable proprietary (public docs only)

**MATLAB / Simulink + Simscape** dominates Model-Based Design; **dSPACE**
(SCALEXIO, AURELION, SystemDesk) and **Vector** (CANoe, PREEvision,
DaVinci) own ECU dev + HIL + bus simulation; **IPG CarMaker** and
**ANSYS VRXPERIENCE / AVxcelerate** are the high-end physics-driving
simulators; **ANSYS medini analyze** is the de-facto ISO 26262 / 21448
work-product tool. Apollo and Autoware are credible open full-stack
counterparts at the *algorithm + integration* layer but stop short of
the safety-tooling + HIL hardware surface.

## 4. Biggest open-source gap

ISO 26262 + ISO 21448 SOTIF safety-case tooling and traceable
requirements / work-product management — the open AV stacks (Apollo,
Autoware) implement *what to verify*, but the *evidence-traceability +
qualified tool-chain* layer expected by type-approval authorities is
entirely proprietary (medini, DOORS, qualified codegen). This is the
demiurge SPECIFY+VERIFY gap that Cohort-1 synthesis flagged as
"under-evidenced" — mobility makes it concrete.

## 5. Cited sources

- Apollo (Baidu) — <https://github.com/ApolloAuto/apollo>, <https://developer.apollo.auto/>
- Autoware Foundation — <https://github.com/autowarefoundation/autoware>, <https://autoware.org/>
- CARLA — <https://github.com/carla-simulator/carla>, <https://carla.org/>
- SUMO (Eclipse) — <https://eclipse.dev/sumo/>, <https://github.com/eclipse-sumo/sumo>
- ASAM OpenSCENARIO XML / DSL — <https://www.asam.net/standards/detail/openscenario-xml/>, <https://www.asam.net/standards/detail/openscenario-dsl/>
- ISO 26262 vs ISO 21448 SOTIF — <https://www.patsnap.com/resources/blog/articles/iso-26262-vs-iso-21448-sotif-for-autonomous-driving/>, <https://www.ptc.com/en/blogs/alm/iso-26262-vs-sotif-iso-pas-21448-whats-the-difference>
- UN R157 ALKS + dual-standard convergence — <https://www.automotive-iq.com/autonomous-drive/articles/rethinking-autonomous-vehicle-functional-safety-standards-an-analysis-of-sotif-and-iso-26262>
