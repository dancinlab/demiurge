# incoming note: cohort-pickup-bot-urdf-producer — third cohort producer candidate after κ-34 (sscb) + grid (pickup #2)

> **id**: `cohort-pickup-bot-urdf-producer` · **opened**: 2026-05-20 KST · **status**: `pickup — not yet implemented`
> **source**: P-⑧ lowest-hanging-fruit analysis (κ-34 prep). After sscb (picked) and grid (pickup #1), bot is the third candidate worth tracking.
> **scope**: ONE cell of bot.md — `bot + design` — wired to a URDF-lint / pinocchio dynamics producer.

---

## Why bot is candidate #3

From `domains/bot.md` (which the README cross-link calls out as "the all-open reference domain"):

- 7-verb stack is **reference-class at every verb** with open tools (ROS 2 + URDF + Pinocchio + OMPL + Drake + Gazebo).
- bot is the "smallest proprietary gap of all 13 Cohort-1+2 domains" — synthesis point 2 of the cross-cohort writeup.
- BUT: macOS install is heavier than ngspice (no brew ros2; PyBullet works on macOS via pip, Pinocchio via conda).

Score after κ-34:

| factor | bot (URDF + pinocchio) | grid (networkx — pickup #1) | sscb (picked) |
|---|---|---|---|
| 도구 설치 | `pip install pin pybullet` (~200 MB conda env) | python3 networkx already | brew ngspice already |
| CLI 한 줄 | `python -m pinocchio <urdf>` → mass + COM | `python -c "..."` → JSON | `ngspice -b file.cir` |
| 측정 명확도 | inertias + jacobian rank — analytic, deterministic | graph metrics | transient |
| 시작 비용 | sample URDF asset 필요 (이도 OSS) | 없음 (in-script topology gen) | 없음 (in-script netlist gen) |

bot is **slightly behind grid** because it needs an external URDF asset (e.g. UR5 / Franka public URDFs) and a pip install. Once those land, bot would be cleaner than grid because it has an absorbed-reference-class open stack.

## The producer skeleton (for the next agent)

**Files**:
- `cockpit/scripts/bot_urdf.py` — accept a public-domain URDF (e.g. UR5 from `ros-industrial/universal_robot`), use Pinocchio to compute total mass, COM, mass-matrix conditioning at home pose, Jacobian rank at end-effector. Write `<output_dir>/bot_urdf_v1.meta.json`.
- Optionally pull a vendored sample URDF into `cockpit/scripts/bot_assets/ur5.urdf` so the producer is hermetic (no `git clone` at runtime).
- `cockpit/Sources/DemiurgeCore/Models/BotRecord.swift` + `Loaders/BotProducer.swift` — mirror SSCB κ-34 pattern.
- `ActionDispatch.swift` add `case (.design, "bot")` → `runBotDesign()`.

**Measurements**:
- `joint_count`, `link_count` (URDF parse)
- `total_mass_kg` (Pinocchio inertias)
- `com_xyz_m` (center-of-mass)
- `inertia_matrix_cond` (mass-matrix conditioning at home pose — diagnostic)
- `ee_jacobian_rank` (kinematic singularity flag)

**Scope caveats**:
1. Pinocchio analytic dynamics ≠ real robot (no contact, no servo dynamics, no payload).
2. URDF is a public-domain sample, not pulled from a specific manufacturer datasheet.
3. measurement_gate = GATE_OPEN — Pinocchio computes real numbers from real URDFs, but the *robot* isn't measured (no Drake constrained sim, no Gazebo HIL run).
4. absorbed=true 금지 — bot.md's "ceiling test" requires Gazebo regression + Drake verification primitives, plus ISO 10218 risk-assessment. One Pinocchio kinematic pass is the first verb, not the whole chain.

## Effort estimate

- pip install pin pybullet (background OK, ~200 MB) — 5 min
- vendor URDF asset (`ros-industrial/universal_robot` UR5 description, BSD) — 10 min
- script: 1 hour
- Swift record + loader: 30 min
- build + smoke test: 30 min
- **total: half day** — install is the only friction beyond grid.

## Status

Not implemented. Pickup AFTER grid (#2), because grid has zero install friction. If both grid + bot land, P-⑧ has **3 cohort producers** (sscb / grid / bot) — that's enough to claim "demiurge crosses cohort boundaries" with honest evidence, not over-claim.

## Cross-reference

- `domains/bot.md` §2 tool map "설계 DESIGN" (URDF / SDF / Pinocchio / MoveIt 2).
- `domains/README.md` cross-cohort synthesis point 2 ("`bot` is the all-open reference domain").
- κ-34 SSCBProducer.swift — the template.
