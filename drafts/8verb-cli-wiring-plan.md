---
slug: 8verb-cli-wiring
mode: discovery
status: discovery-complete
created: 2026-06-03
domain: 8VERB
obeys:
  - drafts/demi-cli-hexa-native-plan.md   # Swift DemiurgeCLI SCRAPPED → hexa-native (g1)
  - drafts/qforge-production-migration-plan.md @L1-L5  # qforge run · dft-run --engine qforge · gate
---

# 8verb-cli-wiring — plan (DISCOVERY milestone)

## scope (this is discovery + planning, $0)

The 8VERB goal: `demiurge cli` exposes all 8 verbs as ordered stages
(discover → specify → structure → design → analyze⟲ → synthesize → verify →
handoff), and EVERY operation — QFORGE el-ph included — is reachable through a
verb. This document is the DISCOVERY deliverable both CLI plans say is still
incomplete: a precise enumeration of the current surface + a concrete stacked-PR
wiring plan. It is NOT the implementation; it does not rent compute and does not
touch the RTSC campaign.

It obeys the two locked plans verbatim:
1. `demi-cli-hexa-native-plan.md` — Swift `DemiurgeCLI` is SCRAPPED; the CLI
   migrates hexa-native (g1). No NEW Swift verbs are added; the target home is
   the hexa-lang stdlib. Swift stays the live surface until per-verb parity.
2. `qforge-production-migration-plan.md` @L1-L5 (LOCKED) — `hexa qforge run
   <deck>` + `hexa cloud dft-run --engine qforge`; full migration flips ONLY on
   g5 λ·Tc agreement vs QE on CaH6·LaH10·Li2MgH16 (no forced flip); the
   correlation-functional / cell→|g|² front-end gap is reported as the gate
   blocker (d6), never faked.

---

## 1. Current `demiurge cli` verb/flag/exit surface (parity spec)

Source of truth:
- `cockpit/Sources/DemiurgeCLI/main.swift` — the 25-subcommand dispatch
  (`switch args[1]`, L964–1112) + `parseVerbArg` verb-alias map (L269–280).
- `cockpit/Sources/DemiurgeCore/Models/Project.swift` — the HARD 7-verb enum
  `Verb` (L24: `specify, structure, design, analyze, synthesize, verify,
  handoff`). `discover` is NOT in this enum — it is an 8th head wired only at the
  CLI dispatch layer (`main.swift` `case "discover"`, L1039 → `discoverCmd`).

### 1a. Full subcommand inventory (the parity contract to preserve)

These 25 top-level subcommands must keep identical args → routing/exit/error
wording across the hexa-native port (parity = behavior, not impl):

| subcommand | handler (main.swift) | exit codes |
|------------|----------------------|------------|
| `--version` / `-v` | `printVersion` | 0 |
| `--help` / `-h` (and bare) | `usage` | 0 |
| `list-all` | `listAll` | 0 |
| `list-records` | `list(.f1f2)` | 0 |
| `list-decisions` | `list(.decision)` | 0 |
| `list-rfcs` | `list(.rfc)` | 0 |
| `list-domains` | `list(.domain)` | 0 |
| `show <path>` | `show` | 0 / 2 (load fail) |
| `list-projects` | `listProjects` | 0 |
| `show-project <name>` | `showProject` | 0 / 2 (no project) |
| `list-shelf <domain>` | `listShelf` | 0 |
| `action <verb> [domain] [--producer N] [--compose\|--converge]` | `cliAction` / `cliActionComposite` / `cliActionConvergent` | 0 / 1 (engine gap) / 2 (bad verb) |
| `discover <objective> [--verifier P] [--rounds N] [--json]` | `discoverCmd` (spawns `phanes`) | passthrough / 2 (no phanes) |
| `list-gates` | `listGates` | 0 |
| `gate-summary` | `gateSummary` | 0 |
| `operate [list\|audit] [--owner]` | `operate` | 0 / 1 (pending) / 2 |
| `backend [list\|current] [--owner]` | `backend` | 0 / 2 |
| `llm [list\|use\|mode\|model\|key\|key-rm\|test\|ask]` | `llmCmd` | 0 / 1 / 2 |
| `project new\|advance\|retreat ...` | `projectNew` / `projectStep` | 0 / 1 / 2 |
| `compose <domain>` | `compose` | 0 |
| `verify <path\|id>` / `verify --expr\|--fence\|rubric ...` | `verifyRecord` / `verifyHexa` | 0 / 1 / 2 / 127 |
| `atlas <lookup\|stats\|hash\|dump> [args]` | `atlasCmd` (→ `hexa atlas`) | passthrough / 2 / 127 |
| `owner` | `ownerStatus` | 0 |
| `emit-component` | `emitComponent` | 0 / 1 |
| `export-component <fmt> [path]` | `exportComponent` | 0 / 1 / 2 |

Key existing pattern (LOAD-BEARING for the QFORGE wiring): `verify --expr/...`
and `atlas` already forward VERBATIM to the hexa stdlib through
`HexaBridge.run([...])` / `HexaBridge.verify([...])`
(`cockpit/Sources/DemiurgeCore/Loaders/HexaBridge.swift`). The hexa-native
target reuses this same forward-to-stdlib shape — no kernel reimplementation
(d3, g5: verdict pasted verbatim, never re-judged).

### 1b. The 8-verb → handler → hexa-native target table

`action <verb>` maps the 7 enum verbs to `cliAction → ActionDispatch.runEngineTool`
(`switch (verb,domain)` special cells + a generic `default → CellrunDispatch.run`
arm — d4). `discover` is the orthogonal 8th head. The hexa-native target column
names the canonical stdlib subcommand each verb re-homes to.

| # | verb | korean | current Swift handler | exit semantics | hexa-native target |
|---|------|--------|-----------------------|----------------|--------------------|
| 0 | **discover** | 발견 | `discoverCmd` (main.swift L907) — spawns `phanes discover` subprocess; NOT in `Verb` enum | 2 if phanes binary absent | `hexa demi discover <objective> …` → forwards to phanes (d3: phanes owns the OUROBOROS loop) |
| 1 | specify | 명세 | `cliAction("specify", dom)` → `ActionDispatch.runEngineTool(.specify, dom)` | 0 / 1 (gap) / 2 (bad verb) | `hexa demi action specify <dom>` (generic dispatch) |
| 2 | structure | 구조 | `cliAction("structure", dom)` → runEngineTool(.structure, dom) | 0 / 1 / 2 | `hexa demi action structure <dom>` |
| 3 | design | 설계 | `cliAction("design", dom)` → runEngineTool(.design, dom) | 0 / 1 / 2 | `hexa demi action design <dom>` |
| 4 | analyze⟲ | 해석 | `cliAction("analyze", dom)` (+ `--converge` → `cliActionConvergent`) | 0 / 1 (unconverged) / 2 | `hexa demi action analyze <dom> [--converge]` |
| 5 | **synthesize** | 합성 | `cliAction("synthesize", dom)` → runEngineTool(.synthesize, dom); today routes component→`ComponentEmitter`, else generic `CellrunDispatch`. **QFORGE NOT reachable** | 0 / 1 / 2 | `hexa demi action synthesize <dom>` — for `rtsc`/hydride decks dispatch **QFORGE** via `hexa qforge run <deck>` / `hexa cloud dft-run --engine qforge` (see §2) |
| 6 | verify | 검증 | `verifyRecord` (path/id) OR `verifyHexa` (`--expr/--fence/rubric` → `hexa verify`) | 0 / 1 / 2 / 127 | `hexa demi verify <path\|id>` + `hexa verify` passthrough; surfaces the QFORGE→QE migration gate (`hexa qforge gate`) |
| 7 | handoff | 인계 | `cliAction("handoff", dom)` → runEngineTool(.handoff, dom) | 0 / 1 / 2 | `hexa demi action handoff <dom>` → atlas fold / `/paper` / NEXUS edge |

Notes:
- `parseVerbArg` (main.swift L269) also accepts Korean (`명세/구조/설계/해석/합성/
  검증/인계`) and the aliases `synth`→synthesize, `measure`→verify. The
  hexa-native verb parser MUST reproduce this alias map exactly (parity).
- The generic dispatch (`default → CellrunDispatch.run`) is already d4-compliant
  (no per-instance class; cells resolve from manifests). The port preserves the
  generic arm and only ADDS the QFORGE synthesize cell for hydride decks.

---

## 2. QFORGE-via-CLI wiring spec (the "all work CLI-reachable" axis)

### 2a. Today's gap

QFORGE is reachable ONLY as `hexa qforge <run|selftest|gate|help>`
(`stdlib/qforge/qforge_cli.hexa`). It is NOT reachable through `demiurge cli` at
all — `ActionDispatch`'s `switch (verb, domain)` has NO `(.synthesize, "rtsc")`
cell, and the generic `CellrunDispatch` arm has no QFORGE producer. So the
`synthesize` verb cannot drive el-ph today; an agent must drop to `hexa qforge`.

### 2b. The wiring (obeys qforge-production-migration-plan @L2/@L3)

The `synthesize` verb drives QFORGE through the EXISTING HexaBridge forward
pattern (the same shape `atlas`/`verify --expr` already use), via two routes the
locked plan defines:

- **@L2 direct chain:** `demiurge cli action synthesize rtsc --deck <deck>` →
  `HexaBridge.run(["qforge", "run", deck])` → `stdlib/qforge/qforge_cli.hexa
  _qf_run`. Verdict pasted VERBATIM (g5). When the deck has no harvested DFPT
  el-ph dataset (`ph.out`), `_qf_run` already reports the front-end gap honestly
  (exit 1, no fabricated Tc) — the CLI surfaces that report unchanged.
- **@L3 dispatch route:** `demiurge cli action synthesize rtsc --deck <deck>
  --engine qforge` → `HexaBridge.run(["cloud", "dft-run", deck, "--engine",
  "qforge"])` → `stdlib/cloud/dft_dispatch.hexa` (`dft_engine_resolve`:
  ""/"qe"→qe DEFAULT, "qforge"→qforge, unknown→refused). Default stays QE; the
  flag is an explicit opt-in.

Wiring point in the (still-live) Swift surface = a new `(.synthesize, "rtsc")`
case in `ActionDispatch.runEngineTool` (or, preferably for d4, a manifest-driven
`CellrunDispatch` producer so no name is hardcoded in the generic layer). In the
hexa-native target it is one generic synthesize cell whose producer for a
hydride/`rtsc` deck is `qforge run` / `dft-run --engine qforge`.

### 2c. Honest correlation / front-end gap note (@L5, d6)

Per the locked plan's qa-results, the migration gate is **HELD** (honest), and
the CLI must NOT imply otherwise:

- **Correlation-XC sub-gap: CLOSED** (PR #2402/#2404 — PZ81/PW92 LDA + PBE GGA
  correlation, wired into the DFPT screening kernel, g5-green).
- **cell→|g|² plane-wave front-end: the engine RUNS but is not production.** The
  5 assembler bricks (S(G), kinetic, V_loc, V_NL, assembler) + M5.5/5.6/5.7/5.8
  (self-consistent ρ-loop, Sternheimer→|g|², in-loop V_H[ρ], metallic
  Fermi+Anderson SCF) all execute a real inhomogeneous CaH6 cell end-to-end and
  CONVERGE (`converged=true`). BUT the independent λ (0.0208, Γ-only Einstein
  coarse) is an ENGINE-RUNS proof, NOT the QE-validated λ=4.376 — it is NOT
  cross-validated, NOT production, NOT absorbed.
- **2/3 anchors PENDING:** LaH10 + Li2MgH16 QE references are not terminal.

⇒ `dft_engine_resolve("")` stays `"qe"`; the default dispatch engine remains QE;
the running RTSC pods are untouched. The `synthesize`-via-QFORGE surface is an
explicit opt-in that REPORTS this honestly (the `qforge run` and `qforge gate`
outputs already carry the gap text). The CLI must NEVER present the held gate as
agreement. The full flip happens ONLY when g5 λ·Tc agreement lands on all three
anchors (no forced flip) — outside the scope of CLI wiring.

---

## 3. Stacked-PR plan (g4 — each PR <200 lines, 1 logical thing)

Two PR families. Family A (PR1–PR4) makes QFORGE reachable through the
`synthesize` verb on the LIVE Swift surface + binds the verify-gate readout — the
smallest closing of the 8VERB "all-work-CLI-reachable" axis WITHOUT pre-empting
the hexa-native rewrite. Family B (PR5–PR9) is the hexa-native re-home that
`demi-cli-hexa-native-plan` owns; listed here for ordering, executed under that
plan. Swift is retired only after per-verb parity (B's final PR).

Each PR ships from a FRESH worktree off `origin/main` (d9 — no index leak), with
a per-PR `@ci_gate` parity-smoke. Korean commit body; do NOT push without review.

### Family A — QFORGE-via-verb on the live Swift surface

- **PR1 — `discover` as ordered stage #0 (doc + dispatch label).** Make
  `discover` a first-class ordered stage in the `usage()` ladder rendering +
  `operate list` (it is currently an orthogonal pass-through). NO behavior change
  to `discoverCmd`. <40 lines. @ci_gate: `demiurge cli --help` lists discover as
  stage 0/8; `demiurge cli discover` (no phanes) still exits 2 with the same
  message.

- **PR2 — QFORGE synthesize cell (direct, @L2).** Add the `(.synthesize, "rtsc")`
  producer to `ActionDispatch` (manifest-driven `CellrunDispatch` producer
  preferred over a hardcoded switch case, d4) + a `--deck <path>` flag parse in
  `cliAction`. Routes to `HexaBridge.run(["qforge","run",deck])`; verdict
  verbatim (g5). <120 lines. @ci_gate: `demiurge cli action synthesize rtsc
  --deck <fixture-no-ph>` exits 1 and prints the front-end-gap report verbatim
  (no fabricated Tc).

- **PR3 — QFORGE dispatch route (@L3, `--engine qforge`).** Add `--engine
  <qe|qforge>` flag to the synthesize cell → `HexaBridge.run(["cloud","dft-run",
  deck,"--engine",engine])`. Default (no flag / `qe`) unchanged. <90 lines.
  @ci_gate: `--engine qforge` forwards verbatim; `--engine vasp` → refused (exit
  echoes `dft_engine_resolve` "" refuse); default route still QE.

- **PR4 — verify verb surfaces the migration gate.** Add `verify --gate` (or
  `verify gate`) → `HexaBridge.run(["qforge","gate"])` so the verify verb shows
  the CaH6·LaH10·Li2MgH16 λ·Tc scoreboard (PASS/HELD/PENDING) verbatim. <60
  lines. @ci_gate: `demiurge cli verify --gate` prints `n/3` + HELD verbatim from
  `hexa qforge gate`; never asserts agreement (d6).

### Family B — hexa-native re-home (executed under demi-cli-hexa-native-plan)

- **PR5 — hexa-native CLI skeleton + generic verb dispatcher** (`hexa demi …`),
  d4 generic dispatch + `version` parity. No verb logic yet. @ci_gate: `hexa demi
  --version`/`--help` byte-match the Swift banners (behavior parity).

- **PR6 — port the read verbs** (`list-*`, `show`, `*-project`, `list-shelf`,
  `list-gates`, `gate-summary`, `compose`, `operate`, `backend`, `owner`) one
  group/PR if any exceeds 200 lines. @ci_gate: each verb's args → identical
  routing/exit/wording vs Swift.

- **PR7 — port `action` (7 verbs) + `parseVerbArg` alias map** (incl. Korean +
  `synth`/`measure` aliases + `--compose`/`--converge`/`--producer`). Carries the
  QFORGE synthesize cell from PR2/PR3 forward to the hexa-native generic cell.
  @ci_gate: per-verb parity smoke (all 8 verbs route identically).

- **PR8 — port `verify`/`atlas`/`llm`/`emit-component`/`discover`** (the
  forward-to-stdlib + subprocess verbs). @ci_gate: forwarded verdicts verbatim;
  `discover` spawns phanes identically.

- **PR9 (FINAL) — flip `bin/demiurge cli` to the hexa CLI; RETIRE Swift
  DemiurgeCLI** (remove `cockpit/Sources/DemiurgeCLI`) — ONLY after the full
  per-verb parity smoke is green. @ci_gate: the whole parity matrix PASS;
  `bin/demiurge cli <verb>` routes to hexa.

### @ci_gate — per-verb parity smoke (the cross-cutting check)

A single script (e.g. `cockpit/Tests/parity_smoke.sh` for Family A,
`stdlib/demi/parity_smoke.hexa` for Family B) that, for every verb in the table,
runs the same argv against the OLD Swift CLI and the NEW path and asserts
identical routing / exit code / human-visible error wording (parity = behavior,
not implementation detail). QFORGE rows assert the HELD/gap report is verbatim
and that NO fabricated Tc / agreement appears (d6 guard). Verdicts pasted
verbatim per PR (g5).

---

## 4. completion criteria

- Family A merged ⇒ `demiurge cli action synthesize rtsc --deck <deck>
  [--engine qforge]` drives QFORGE (no `hexa` drop) and `verify --gate` surfaces
  the migration scoreboard — closing the "QFORGE reachable through a verb" axis
  honestly (gate still HELD; default engine still QE).
- Family B merged + parity-green ⇒ all 8 verbs hexa-native, Swift retired.
- The migration FLIP (default engine → qforge) is NOT part of this plan; it
  flips only on g5 λ·Tc agreement on CaH6·LaH10·Li2MgH16 (qforge-production-
  migration-plan @L4), reported honestly if blocked (@L5 / d6).
