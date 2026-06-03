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
### REORDER 2026-06-03 — Swift 폐기 FIRST (user directive): do NOT extend the Swift surface

The Family-A Swift PRs (PR2/PR3/PR4 below) are **SUPERSEDED** — building on
`cockpit/Sources/DemiurgeCLI/main.swift` only adds code that gets deleted. The
canonical path is now `drafts/demi-cli-pure-hexa-native-plan.md` (status=active,
mode=auto complete-forced): strip Swift COMPLETELY → pure hexa-native under
`stdlib/demi/` (hexa-lang), then delete `cockpit/` after the parity gate is
ALL-GREEN. synthesize→QFORGE and verify-gate re-home as rows in that 28-PR stack.

- [~] ~~PR2/PR3~~ SUPERSEDED → **PR-synthesize-qforge (stack #20)** in pure-hexa plan: `action synthesize rtsc --deck <deck>` → `hexa qforge run <deck>` subprocess, output VERBATIM (d6, HELD gate ≠ agreement). Lands hexa-native in `stdlib/demi/`, NOT Swift.
- [~] ~~PR4~~ SUPERSEDED → **PR-verify-record (stack #3)** + verify-passthrough (✅ MERGED hexa-lang #2602): `verify --expr|rubric` → `hexa verify` kernel verbatim already done; bare `verify <path|id>` record/claim-gate is #3.
- [ ] FOUNDATION+PROOF ✅ landed hexa-lang (PR#2597 + #2602 = rows 1-2): `stdlib/demi/` manifest-driven generic dispatch (d4) + per-verb parity smoke (`demi_selftest.hexa` @ci_gate); discover + verify-passthrough cells byte≡Swift
- [ ] pure-hexa stack PRs #3–#19 — RecordLoader · list-*/show/gate · DomainCatalog/compose · ProjectStore · operate/backend/owner · llm · cellrun-engine (each <200 lines, own parity cell, g4)
  - [x] #3 PR-verify-record ✅ — bare `verify <path|id>` provenance/claim-gate, 5 parity cells byte≡Swift (GOLDEN + live). Stack branch `demi-stack3-verify-record` → main = PR#2638 (OPEN, accumulates #3+#4+#5)
  - [x] #4 PR-atlas ✅ hexa-lang PR#2639 (squash-merged into stack branch) — `atlas` owner-gated write-verb refusal (register/append-witness/pr → rc2 w/o DEMIURGE_OWNER), 3 parity cells
  - [x] #5 PR-record-loader ✅ hexa-lang PR#2640 (merged) — hexa-native `RecordLoader`+`ArtifactRegistry` (exports/** enumerate·load-by-id·invariant-a guard), shared base for #6-#8; refactored verify_record onto it (224→123, d3). 17 cells ALL-GREEN
  - [ ] #6–#19 remaining (NEXT runnable: #6 list-kinds · #7 show-record · #8 gates — all on the #5 RecordLoader base)
- [ ] geometry exporters hexa-native (@L3, stack #21–#25): HtsCoilGeometry · STL/USD emit · emit/export-component — golden-file parity vs Swift bytes
- [ ] **PR-parity-gate-all-green (stack #26, @L2 GATE)** — every verb's parity cell ALL-GREEN; NO Swift deletion before this is green
- [ ] **PR-bin-flip (stack #27, demiurge repo, @L5)** — `bin/demiurge cli` flips `exec swift run DemiurgeCLI` → `hexa run stdlib/demi/demi_cli.hexa`, keep `--swift` explicit fallback
- [ ] **PR-swift-delete (stack #28, demiurge repo, @L2)** — delete `cockpit/Sources/DemiurgeCLI` + `DemiurgeCore` + Package.swift CLI target (24k LOC) AFTER #26 green; web GUI (Next.js + react-three-fiber) UNTOUCHED (@L4)

#### original Family-A milestones (kept for trace; do NOT pursue on Swift)
- [ ] ~~PR2/PR3 — synthesize→QFORGE via HexaBridge on the Swift surface~~ (superseded above)
- [ ] ~~PR4 — verify verb gate readout on the Swift surface~~ (superseded above)
- [ ] all 8 verbs dispatch through ONE generic path (d4) — now realized by the `stdlib/demi/` manifest dispatcher
- [ ] `demiurge cli` ⇄ web GUI ⇄ web-bridge: every verb reachable on all three surfaces

## §6 shelf — design options

- CLI home: (a) keep Swift DemiurgeCLI as the surface until hexa-native parity · (b) hexa-native first, Swift frozen · (c) **Swift 폐기 FIRST — strip Swift COMPLETELY, pure hexa-native, delete `cockpit/` after parity gate** — LOCKED (c) 2026-06-03 per `demi-cli-pure-hexa-native-plan.md` (user directive: do not extend the Swift surface).
- discover placement: (a) ordered stage #0 · (b) orthogonal continuous lane (d_discovery) — 8VERB picks (a) for the ladder, (b) stays as the always-on discovery reflex.
- QFORGE engine select: (a) `qforge run` direct · (b) `dft-run --engine qforge` dispatch — both, per qforge-production-migration-plan @L2/@L3.
