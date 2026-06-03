# 8VERB — log

Append-only history sister of `8VERB.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-03 — PR1 landed in-worktree: discover = ordered stage 0/8 (doc/label only)

- [x] Family A PR1 committed in worktree (unpushed; parent reviews/merges) — SHA `af85101`. `usage()` --help now renders the 8-verb ladder (0/8 discover → … → 7/8 handoff) with discover as the pipeline head; `operate list` prints the same stage-0 ladder label. NO runtime change to `discoverCmd` / `Verb` enum / dispatch / exit. diff = +18 lines (<40). @ci_gate: swift build PASS · --help shows discover 0/8 · `discover` no-phanes still exit 2, message unchanged.

## 2026-06-03 — DISCOVERY: CLI surface enumerated + stacked-PR wiring plan written

Discovery milestone both CLI plans flagged as incomplete. $0, no compute, RTSC
campaign untouched. Plan written to `drafts/8verb-cli-wiring-plan.md`.

- [x] enumerated the current `demiurge cli` surface — 25 top-level subcommands
  (`cockpit/Sources/DemiurgeCLI/main.swift` `switch args[1]` L964–1112) + the
  `parseVerbArg` verb-alias map (L269–280, incl. Korean + `synth`/`measure`
  aliases). The 7-verb spine is the HARD enum `Verb` in
  `cockpit/Sources/DemiurgeCore/Models/Project.swift` L24; `discover` is NOT in
  the enum — it is an 8th head at the dispatch layer only (`case "discover"` →
  `discoverCmd` L907, spawns `phanes discover` subprocess).
- [x] built the 8-verb → handler → hexa-native target table (see plan §1b).
  Each `action <verb>` routes via `cliAction → ActionDispatch.runEngineTool`
  (`switch (verb,domain)` special cells + generic `default → CellrunDispatch.run`
  arm, already d4-compliant).
- [x] mapped the QFORGE gap (plan §2): QFORGE is reachable ONLY as
  `hexa qforge <run|selftest|gate|help>` (`stdlib/qforge/qforge_cli.hexa`);
  `ActionDispatch` has NO `(.synthesize,"rtsc")` cell, so the synthesize verb
  cannot drive el-ph today. Wiring = reuse the EXISTING HexaBridge forward
  pattern (the shape `atlas`/`verify --expr` already use) → `qforge run <deck>`
  (@L2) / `cloud dft-run --engine qforge` (@L3); `dft_engine_resolve` already
  resolves ""/"qe"→qe DEFAULT, qforge→qforge, unknown→refused
  (`stdlib/cloud/dft_dispatch.hexa` L217).
- [x] recorded the honest gate-blocker note (@L5/d6): correlation-XC sub-gap
  CLOSED (PR#2402/#2404), but the cell→|g|² front-end is engine-RUNS / NOT
  production (independent λ=0.0208 Γ-only Einstein ≠ QE λ=4.376, not cross-val'd)
  + 2/3 anchors (LaH10·Li2MgH16) PENDING → gate HELD, default engine stays QE,
  no flip. CLI must never present HELD as agreement.
- [x] wrote the stacked-PR plan (g4, each <200 lines): Family A (PR1–PR4) makes
  QFORGE reachable via the synthesize verb on the live Swift surface + binds the
  verify-gate readout; Family B (PR5–PR9) is the hexa-native re-home under
  demi-cli-hexa-native-plan (Swift retired only after per-verb parity). Each PR
  has an @ci_gate parity-smoke check.
- [x] flipped the 8VERB.md DISCOVERY milestone to `[x]`; refined the remaining
  open milestones to map onto the plan's PR families (discovery ≠ implementation
  — all implementation milestones stay `[ ]`).

