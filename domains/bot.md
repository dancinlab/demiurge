# domain — bot (robot platform — URDF + control)

> Status: **shallow public-surface map** (Cohort 2, `design.md` Decision 6).
> Boundary: public-surface clean-room (`design.md` Decision 1). Pipeline =
> 7-verb spine (`HANDOFF.md` §4 · D5). **Note**: this is the *smallest
> proprietary gap of all 13 Cohort-1+2 domains* — robotics has the most
> mature all-open stack (ROS 2 + Gazebo + MoveIt 2 + Drake + Pinocchio +
> OMPL + PyBullet covers every verb credibly). Documented honestly per
> Decision 1 no-over-claim.

## 1. "Design blueprint" deliverable

A robot platform spec — URDF / SDF model (kinematics + inertias +
collision), actuator + sensor selection, controller architecture
(low-level + WBC / MPC + planner + behavior), and safety analysis per
ISO 10218 (industrial) / ISO 13482 (service / personal-care) /
IEC 61131-3 (PLC control). Sub-classes: industrial manipulator,
mobile / AMR, quadruped (dog-robot), humanoid.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (ODD + task spec; ISO 10218-1/2:2025 for industrial, ISO 13482 for service, IEC 61131-3 for PLC) | — |
| 구조 ARCHITECT | **ROS 2** (Humble / Iron / Jazzy / Rolling — Apache-2.0; node/topic graph as architecture artifact) | — |
| 설계 DESIGN | **URDF** / **SDF** (W3C-style XML schemas, OSRF); **MoveIt 2** (manipulator config + planning pipelines) | — |
| 해석 ANALYZE ⟲ | **Gazebo** (Garden / Harmonic / Ionic — successor to Gazebo Classic; gz_ros2_control bridge); **PyBullet** (Bullet physics, ZLib); **Drake** (MIT / TRI; contact-rich multibody + optimization + systems framework); **Open3D** (perception / 3D data) | **NVIDIA Isaac Sim** (Omniverse-based; public marketing); **Coppelia V-REP** |
| 합성 SYNTHESIZE | **Pinocchio** (rigid-body dynamics + analytic derivatives, stack-of-tasks); **CasADi** (NLP / MPC code-gen); **Crocoddyl** (DDP); **OMPL** (40+ sampling planners; default MoveIt planner) | — |
| 검증 VERIFY | Gazebo regression + ros2_control HIL bridge; Drake's verification primitives (Lyapunov, SOS, contact-implicit) | **MathWorks Robotics System Toolbox** + **Simulink Real-Time** HIL |
| 인계 HANDOFF | (deployment per ISO 10218 risk-assessment + IEC 61131-3 PLC code; OSS deliverable format honest — URDF + ros2_control configs as actual SSOT) | — |

## 3. Notable proprietary (public docs only)

**NVIDIA Isaac Sim** (Omniverse PhysX 5; OpenUSD-based) is the most
visible commercial counterpart, primarily competing on photoreal
rendering + large-scale GPU parallel simulation. **MathWorks** and
**Coppelia** also have presence. *None of these replace the open core* —
the open stack is reference-class at every verb, with proprietary
advantage concentrated at GPU-parallel synthetic data generation and
proprietary safety-PLC ecosystems (Siemens TIA / Rockwell Studio 5000
on the IEC 61131-3 side).

## 4. Biggest open-source gap

GPU-accelerated photoreal sensor simulation at Isaac Sim parity (Gazebo
+ PyBullet are not photoreal at the same throughput); and qualified
safety-PLC toolchains for IEC 61131-3 + ISO 10218 certification. Neither
gap is at the algorithm layer — both are at *throughput* and *regulatory
qualification*. This is the cleanest "OSS-strong, regulatory-weak" split
in the cohort.

## 5. Cited sources

- ROS 2 (Autoware-cited deployments) — see `mobility.md`
- Gazebo (Ignition / Garden / Harmonic) — <https://docs.ros.org/en/humble/Tutorials/Advanced/Simulators/Gazebo/Gazebo.html>, <https://github.com/osrf/icra2023_ros2_gz_tutorial>
- MoveIt 2 + Gazebo integration — <https://github.com/AndrejOrsula/gz_moveit2_examples>
- Drake (TRI / MIT) — <https://drake.mit.edu/>, <https://medium.com/toyotaresearch/drake-model-based-design-in-the-age-of-robotics-and-machine-learning-59938c985515>
- Pinocchio — <https://github.com/stack-of-tasks/pinocchio>
- Pinocchio + CasADi MPC toolchain — <https://www.mech.kuleuven.be/en/pma/research/meco/research/model-predictive-control/3-toolchain-mpc>
- OMPL — <https://ompl.kavrakilab.org/>, <https://github.com/ompl/ompl>
- PyBullet + ROS 2 bridge — <https://github.com/oscar-lima/pybullet_ros>
- ISO 10218-1:2025 / -2:2025 — <https://www.iso.org/standard/73933.html>, <https://blog.ansi.org/ansi/iso-10218-1-2025-robots-and-robotic-devices-safety/>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 구동 = 전기모터 / 유압 / 공압
- 설계: 제어 = PID / MPC / WBC ; 센서 = 카메라 / 라이다 / IMU
