# 🎛️ 8VERB — 8-verb CLI 파이프라인 (alias: "8단계 사다리")

`demiurge cli` as a complete 8-stage verb pipeline — every demiurge operation,
QFORGE el-ph included, reachable as one `demiurge cli <verb>` stage. No operation
lives outside the verb ladder; no surface (web GUI · AI-agent · web-bridge) sees
a verb the CLI cannot drive.

@goal := "demiurge cli exposes all 8 verbs as ordered stages + EVERY operation (QFORGE el-ph · deck · cloud · atlas · paper) is CLI-reachable through a verb — measured by per-verb parity smoke + a QFORGE-via-CLI run"

## The 8 verbs (discover prepended to the canonical 7)

The historical spine is 7 (`specify → … → handoff`, hard enum in
`cockpit/Sources/DemiurgeCore/Models/Project.swift`). `discover` already exists in
the Swift CLI as the **8-verb head** (`main.swift:893` — phanes discovery, d3/d4).
8VERB makes that head a first-class ordered stage, not an orthogonal pass-through.

| # | verb | korean | stage role | `demiurge cli` | QFORGE / compute hook |
|---|------|--------|------------|----------------|------------------------|
| 0 | discover | 발견 | enumerate objectives / candidates (phanes) | `discover <objective>` | candidate superhydrides → deck queue |
| 1 | specify | 명세 | what to build + the falsifier | `action specify <dom>` | target λ·Tc + falsifier |
| 2 | structure | 구조 | decompose into the stack | `action structure <dom>` | cell · k/q-grid · basis sizing (d11) |
| 3 | design | 설계 | concretize each part | `action design <dom>` | deck emit (`/deck` → vc-relax·scf·ph) |
| 4 | analyze⟲ | 해석 | check the design, iterate | `action analyze <dom>` | d16 free dry-run · preflight estimate |
| 5 | synthesize | 합성 | build the runnable form | `action synthesize <dom>` | **QFORGE run** — `qforge run <deck>` (el-ph→λ→Tc) · `cloud dft-run --engine qforge` |
| 6 | verify | 검증 | measure / cross-val | `verify <path\|id>` | g5 λ·Tc + migration gate (CaH6·LaH10·Li2MgH16) |
| 7 | handoff | 인계 | hand the result onward | `action handoff <dom>` | atlas fold · `/paper` · NEXUS edge |

```
discover ─▶ specify ─▶ structure ─▶ design ─▶ analyze⟲ ─▶ synthesize ─▶ verify ─▶ handoff
   │                                              ▲              │            │
   └─ candidates ────────────────────────────────┘   QFORGE el-ph│  gate λ·Tc │ atlas+paper
                                                       qforge run │  CaH6·LaH10│
                                                       dft-run    │  Li2MgH16  │
                                                       --engine qforge
```

## QFORGE-via-CLI (the "all work CLI-reachable" axis)

QFORGE today is reachable only as `hexa qforge <run|selftest>` — NOT through
`demiurge cli`. The locked plans below govern the wiring; 8VERB tracks their CLI
exposure so the `synthesize` verb can drive QFORGE without dropping to `hexa`:

- `drafts/qforge-production-migration-plan.md` (@L1-5 LOCKED): orchestrator
  deck→SCF→DFPT→elph→Eliashberg→Tc · `hexa qforge run <deck>` · `hexa cloud
  dft-run --engine qforge` · gate flips only on g5 λ·Tc agreement (no forced
  flip) · honest correlation-gap reporting (d6).
- `drafts/demi-cli-hexa-native-plan.md` (LOCKED): Swift DemiurgeCLI scrapped →
  hexa-native CLI (g1). The 8 verbs re-home as hexa stdlib subcommands; QFORGE
  exposure rides this migration.

## Milestones

- [x] DISCOVERY: enumerate the current `demiurge cli` 25-subcommand verb/flag/exit surface + the 8-verb→handler→hexa-native target table + the QFORGE-via-verb wiring spec → `drafts/8verb-cli-wiring-plan.md` (parity spec for the port)
- [x] PR1 — discover wired as ordered stage #0 in `usage()`/`operate list` (not orthogonal phanes pass-through; behavior unchanged) — landed in main tree (af85101), @ci_gate PASS (swift build · `--help` 0/8 ladder · discover-no-phanes still exit 2)
- [ ] PR2/PR3 — `demiurge cli action synthesize rtsc --deck <deck> [--engine qforge]` drives QFORGE el-ph via HexaBridge (`qforge run` @L2 / `dft-run --engine qforge` @L3) with no `hexa` drop; gap report verbatim (d6)
- [ ] PR4 — verify verb surfaces the QFORGE→QE migration gate (CaH6·LaH10·Li2MgH16) via `hexa qforge gate`, verdict verbatim (no asserted agreement)
- [ ] all 8 verbs dispatch through ONE generic path (d4 — manifest-driven cell, no per-verb hardcoding in the generic layer)
- [ ] `demiurge cli` ⇄ web GUI ⇄ web-bridge: every verb reachable on all three surfaces
- [ ] per-verb parity smoke (@ci_gate) script — Swift-parity until hexa-native migration lands
- [ ] hexa-native CLI re-home (Family B, PR5–PR9): 8 verbs as `hexa demi …` stdlib subcommands; Swift retired only after per-verb parity (demi-cli-hexa-native-plan)

## §6 shelf — design options

- CLI home: (a) keep Swift DemiurgeCLI as the surface until hexa-native parity · (b) hexa-native first, Swift frozen — LOCKED (b) per demi-cli-hexa-native-plan.
- discover placement: (a) ordered stage #0 · (b) orthogonal continuous lane (d_discovery) — 8VERB picks (a) for the ladder, (b) stays as the always-on discovery reflex.
- QFORGE engine select: (a) `qforge run` direct · (b) `dft-run --engine qforge` dispatch — both, per qforge-production-migration-plan @L2/@L3.
