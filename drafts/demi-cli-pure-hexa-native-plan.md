---
slug: demi-cli-pure-hexa-native
mode: auto (4-axis: complete forced)
status: landed
auto_weights: complete-forced (1,0,0,0 → complete; ties→safe)
created: 2026-06-03
landed: 2026-06-04
---

## task brief

Strip Swift COMPLETELY out of `demiurge cli` → pure hexa-native. The macOS
SwiftUI cockpit GUI was already scrapped (2026-05-27); what remains is Swift
`DemiurgeCLI` + `DemiurgeCore` (incl. the STL/USD 3D exporters + HtsCoilGeometry),
and `bin/demiurge cli` still `exec swift run DemiurgeCLI`. End state: ZERO Swift
in the `demiurge cli` path — the CLI, the 8-verb dispatch, and the geometry
exporters all run hexa-native; `cockpit/` Swift dir deleted; `bin/demiurge cli`
calls hexa. Web GUI (Next.js + react-three-fiber) is a SEPARATE browser-3D world
and is UNTOUCHED (Swift can't run in the browser — Vapor was rejected for exactly
this; the 3D-in-browser stays React/Three.js).

Current Swift surface to replicate (parity spec): `cockpit/Sources/DemiurgeCLI/main.swift`
(25 subcommands + the 8-verb ladder — see drafts/8verb-cli-wiring-plan.md + domains/8VERB.md),
the 7-verb enum in `DemiurgeCore/Models/Project.swift`, and the exporters
`DemiurgeCore/Exporters/{STLExporter,USDExporter}.swift` + `Models/HtsCoilGeometry.swift`.

## locked decisions — ✅ ALL LANDED 2026-06-04 (28-PR stack complete · domain 8VERB)

> Status: LANDED. Every @L below is satisfied — pure-hexa-native `demiurge cli` shipped, Swift cockpit/ CLI+Core deleted (23,442 LOC, demiurge PR#576), 127/127 parity cells GREEN (gate #26 coverage-locked). This plan is closed; the @L list is retained as the historical contract, not an open checklist.

- @L1 ✅ LANDED (home · complete): all hexa-native CLI code lives under `stdlib/demi/` in hexa-lang; ONE generic manifest-driven dispatch (d4 — no per-verb hardcoding, no per-instance class) · assert:grep "demi"
- @L2 ✅ LANDED (parity-gate · safe): Swift `cockpit/` dir is deleted ONLY after a per-verb `@ci_gate` parity smoke is ALL-GREEN (hexa output ≡ Swift output for every verb). NO forced deletion before parity · assert:grep !forced
- @L3 ✅ LANDED (3D · complete): the STL/USD geometry exporters + HtsCoilGeometry port to hexa-native (USD/STL emit from hexa); `emit-component`/`export-component` verbs reach parity. **NO HARDCODING — 3D geometry MUST load from an EXTERNAL geometry spec/manifest file at runtime; the generic emitter lives in `.hexa`, NEVER per-shape/per-instance geometry constants in source (d4 manifest-only · d3 data-not-code). Parity cell MUST prove a file-only shape swap (no recompile) changes the emitted STL/USD bytes.** · assert:grep "usd"
- @L4 ✅ LANDED (web · safe): web GUI (Next.js + react-three-fiber) is NOT touched — browser 3D stays React/Three.js; this migration is the LOCAL CLI surface only · assert:grep "react-three"
- @L5 ✅ LANDED (entry · complete): `bin/demiurge cli` flips `swift run` → `hexa` ONLY after full per-verb parity; during migration keep swift as an explicit fallback flag, never a silent regression · assert:grep "hexa"
- @L6 ✅ LANDED (qforge · std): the `synthesize` verb drives QFORGE via `hexa qforge run <deck>` (honors qforge-production-migration-plan @L1-5; surface QFORGE output verbatim, never present a HELD gate as agreement) · assert:grep "qforge"
- @L7 ✅ LANDED (verify · complete): every verb closed by a g5/`@ci_gate` parity check vs the Swift reference output — paste verdict verbatim, no LLM-self-judge · assert:grep "parity"

## next-action checklist

- [x] FOUNDATION: scaffold `stdlib/demi/` (hexa-lang) — `demi_cli.hexa` (main-bearing thin entry) + a manifest-driven generic verb dispatcher (d4) + a per-verb parity-smoke harness (runs hexa verb ⇄ Swift verb, diffs output)
- [x] PROOF: port 2 verbs end-to-end (`discover` stage-0 + one `action <verb>`) through the generic path + their parity smoke green (g5 verbatim)
- [x] enumerate the FULL stacked-PR sequence for the remaining 23 subcommands + the 3D exporters into this plan's `## handoff` (one PR <200 lines each, g4)
- [ ] port the geometry exporters (STL/USD emit + HtsCoilGeometry) hexa-native — `emit-component`/`export-component` parity (@L3)
- [ ] wire `synthesize` → `hexa qforge run <deck>` (@L6)
- [ ] flip `bin/demiurge cli` → hexa (after full parity, @L5)
- [ ] delete `cockpit/` Swift dir (after parity ALL-GREEN @ci_gate, @L2)
- [ ] ship FOUNDATION+PROOF as hexa-lang PR(s) (worktree, g5, do NOT push — parent reviews/merges)

## completion criteria

- `demiurge cli <verb>` for all 25 subcommands runs hexa-native (zero `swift run`).
- per-verb parity smoke ALL-GREEN (hexa ≡ Swift reference, recorded verbatim).
- `cockpit/` Swift dir removed; `bin/demiurge` calls hexa.
- web GUI untouched (Next.js + react-three-fiber intact).
- This is multi-PR; the FIRST agent run lands FOUNDATION+PROOF + the full stacked-PR enumeration. Swift is NOT deleted until the final parity gate — partial progress is honest, not a fake "done".

## handoff

### what landed (FOUNDATION+PROOF · branch `demi-cli-foundation` in hexa-lang, unpushed)

`stdlib/demi/` scaffolded off `origin/main` (99e62812b), pure hexa-native, manifest-driven generic dispatch (d4 — verb behavior branches ONLY on a manifest `kind`, never on the verb name):

- `manifest.hexa` — SINGLE-SOURCE verb table. All 25 Swift subcommands declared as `Verb{name,kind,target,summary}` rows. `kind ∈ {subprocess, local, meta}`. add/rename/remove a verb = manifest-only edit.
- `dispatch.hexa` — ONE path `demi_dispatch → dispatch_kind`. `subprocess` forwards argv to phanes/hexa with stdout VERBATIM (g5); usage rendered from the manifest; phanes resolution + not-found block byte-matched to Swift.
- `handlers.hexa` — the `local` family entry + honest `handler_stub` (declared-but-unported verbs exit 2, NEVER fake parity — @L2/@L7). `handler_action` ported (verb labels = Swift `Verb.plain`).
- `demi_cli.hexa` — thin `main()` entry (lib modules import-clean).
- `demi_selftest.hexa` (`@ci_gate`) — per-verb parity smoke: runs hexa ⇄ Swift, asserts stdout+stderr byte-identical AND exit codes equal. GOLDEN fallback (no Swift toolchain needed in CI) + `DEMI_SWIFT_BIN` live cross-check.

PROOF cells ALL-GREEN (byte ≡ live Swift, rc≡): `discover/usage`, `discover/phanes-not-found`, `action/unknown-verb`. (`action` HAPPY path = honest stub; the `cellrun` engine it needs is a stacked PR below.)

### honest finding (drives the stack)

The Swift `action <verb> <domain>` HAPPY path does NOT print a static gap line — it routes through `ActionDispatch.runEngineTool → cellrun`, which reads `domains/<domain>.demi` manifests + a python substrate and emits multi-line `[cellrun]` output (exit 1 on an engine gap). The `list-*` / `show*` / `gate` / `compose` / `operate` / `backend` / `llm` / `project` verbs likewise depend on `DemiurgeCore` services (`ArtifactRegistry`, `RecordLoader`, `ProjectStore`, `DomainCatalog`, `IngredientShelf`, `DomainComposer`, `OperationRegistry`, `BackendResolver`, `LLMSettings`). Porting these is the bulk of the work — each is its own <200-line PR with its own parity cell.

### stacked PR sequence (each `--base` on the layer below · one concern · <200 lines · g4)

Foundation = `demi-cli-foundation` (landed, hexa-lang PR#2597). Stack order (MERGED to hexa-lang main: PR#2597 foundation · PR#2602 stack1 = rows 1-2):

1. **PR-discover-live** ✅ MERGED (#2602) — LIVE phanes cross-check parity cell via deterministic stub; discover argv-forward + child-rc asserted byte≡Swift.
2. **PR-verify-passthrough** ✅ MERGED (#2602) — `verify --expr|--fence|rubric` → `hexa verify` kernel verbatim (rc-prop, missing-hexa→127); bare <path|id> → honest verify.record stub. parity cells green.
3. **PR-verify-record** — port the bare `verify <path|id>` provenance/claim-gate consistency check (RecordLoader + ArtifactRegistry equivalents over `exports/`). parity cell. (~180)
4. **PR-atlas** — `atlas` already `subprocess`; add the owner-gated write-verb refusal + parity cell vs `atlasCmd`. (~90)
5. **PR-record-loader** — hexa-native `RecordLoader` + `ArtifactRegistry` (read F1F2 records under `exports/**`, invariant-a path guard). Shared base for list-*/show/gate PRs. (~190)
6. **PR-list-kinds** — `list-all`/`list-records`/`list-decisions`/`list-rfcs`/`list-domains` over the PR-5 registry. parity cells. (~150)
7. **PR-show-record** — `show <path>` record + provenance dump (depends PR-5). parity cell. (~140)
8. **PR-gates** — `list-gates` + `gate-summary` (depends PR-5). parity cells. (~150)
9. **PR-domain-catalog** — hexa-native `DomainCatalog` + `IngredientShelf` (parse `domains/<d>.md` §6). Base for shelf/compose. (~190)
10. **PR-compose** — `compose <domain>` + `DomainComposer` (constituent stack, topo order). parity cell. (~180)
11. **PR-list-shelf** — `list-shelf <domain>` (depends PR-9). parity cell. (~110)
12. **PR-project-store** — hexa-native `ProjectStore` + `Project`/`Verb` model + `list-projects`/`show-project`. parity cells. (~190)
13. **PR-project-mutate** — `project new|advance|retreat` (writes the same manifest; depends PR-12). parity cells. (~170)
14. **PR-operate** — `operate list|audit` + `OperationRegistry` manifest + owner-mode gate. parity cells. (~190)
15. **PR-backend** — `backend list|current` + `BackendResolver` (local + DEMIURGE_BACKEND). parity cells. (~150)
16. **PR-owner** — `owner` status surface (depends PR-14). parity cell. (~80)
17. **PR-llm** — `llm list|use|mode|model|key|key-rm|test|ask` + `LLMSettings`/Keychain/`LLMBridge`. (Largest; may split list/config vs test/ask into 2 PRs of ~150 each.) parity cells.
18. **PR-cellrun-engine** — hexa-native `ActionDispatch.runEngineTool` (cellrun: read `domains/<d>.demi` + substrate dispatch). Unblocks the `action` HAPPY path. parity cell vs Swift `cliAction`. (~190)
19. **PR-action-compose-converge** — `action --compose` / `--converge` (`runComposite`/`runConvergent`; depends PR-18). parity cells. (~180)
20. **PR-synthesize-qforge** (@L6) — `action synthesize rtsc --deck <deck>` → `hexa qforge run <deck>` subprocess, output VERBATIM. Honors qforge-production-migration @L1-5: a HELD/under-converged gate is surfaced as-is, NEVER as production agreement (d6). parity cell vs `cliSynthesizeRtsc`. (~120)
21. **PR-htscoil-geometry** (@L3) — port `HtsCoilGeometry` + `ComponentGeometry` SSOT to hexa-native (procedural placeholder, GATE_OPEN honest). (~150)
22. **PR-stl-exporter** (@L3) — hexa-native `STLExporter.stl` emit (depends PR-21). golden-file parity cell vs Swift STL bytes. (~120)
23. **PR-usd-exporter** (@L3) — hexa-native `USDExporter.usda` emit (λ-rich layer expansion + UsdPreviewSurface; depends PR-21). golden-file parity cell vs Swift `.usda` bytes. (~190)
24. **PR-export-component** (@L3) — `export-component usda|stl` (depends PR-22, PR-23). parity cell vs `exportComponent`. (~90)
25. **PR-emit-component** (@L3) — `emit-component` (`ComponentEmitter.emitBundled` → `.usda/.usdz` + record; depends PR-23). parity cell. (~140)
26. **PR-parity-gate-all-green** — register EVERY verb's parity cell in `demi_selftest.hexa` and assert the full `@ci_gate` ALL-GREEN. This is the @L2 GATE — no Swift deletion before this is green. (~80, mostly cell registrations)
27. **PR-bin-flip** (@L5, demiurge repo) — `bin/demiurge cli` flips `exec swift run DemiurgeCLI` → `hexa run stdlib/demi/demi_cli.hexa`, keeping `--swift` as an explicit fallback flag (never a silent regression). (~60)
28. **PR-swift-delete** (@L2, demiurge repo) — delete `cockpit/Sources/DemiurgeCLI` + `DemiurgeCore` + `Package.swift` CLI target ONLY after PR-26 is ALL-GREEN. Web GUI (Next.js + react-three-fiber) UNTOUCHED (@L4). (~lines = deletions)

Notes: PRs 1-26 land in hexa-lang (`stdlib/demi/`); PRs 27-28 land in the demiurge repo (`bin/` + `cockpit/`). The `kind` set stays fixed at {subprocess, local, meta}; new DemiurgeCore-equivalent services are leaf modules under `stdlib/demi/` imported by their handler. Every PR adds its parity cell to `demi_selftest.hexa` in the SAME PR (@L7 — no verb merges without a green cell).
