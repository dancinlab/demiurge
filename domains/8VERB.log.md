# 8VERB — log

Append-only history sister of `8VERB.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-04 — pure-hexa stack #3 (PR-verify-record) landed → hexa-lang PR#2638 (open, parent review)

Corrected-surface resume after the Swift halt. Bare `verify <path|id>`
provenance/claim-gate check ported hexa-native into `stdlib/demi/`, NOT Swift.

- [x] `stdlib/demi/verify_record.hexa` NEW (189 code lines, <200 g4) + `handlers.hexa` bare-path route (generic dispatch untouched, d4) + 5 parity cells in `demi_selftest.hexa` (@L7 — cell in the SAME PR).
- [x] Swift reference reproduced live (`cockpit/.build/release/DemiurgeCLI`): valid record path/id → 6 `[OK]` rc0 · missing → `Record file not found` rc1 · outside exports → invariant-a refusal rc1 · inconsistent → `REJECTED` (stderr-first) + `[FAIL]` rc1.
- [x] parity verdict VERBATIM (g5): GOLDEN `@ci_gate` ALL-GREEN — `verify/record-{ok-path,ok-id,reject,missing,outside}` byte≡golden, `demi_parity_selftest PASS [12/12]`; LIVE `DEMI_SWIFT_BIN` cross-check = all 5 verify cells `PASS (byte ≡ Swift)`.
- [x] bug caught+fixed mid-build: `json_object_get_str` doesn't split on `.` → added `_vr_path_str` (json_object_get_path + to_string) for dotted provenance paths.
- [ ] KNOWN-NOISE (not this PR): the selftest header line shows FAIL due to 3 PRE-EXISTING `discover` cells — prebuilt Swift binary is May-25, predates the discover verb (#2602); GOLDEN cells green. Follow-up = rebuild `cockpit/.build` or treat discover GOLDEN as authoritative.
- [ ] PR#2638 left UNMERGED (parent review per plan; pr-cycle auto-merge blocked by `selfhost-gates-summary` required check).
- [ ] toolchain footgun for the rest of the stack: installed `hexa` resolves `stdlib/demi/*` from FIXED root `/Users/mini/hexa-sh/stdlib/` + `~/.hexa-cache/hexa_run.*` keyed on ENTRY file only (imported-module edits need cache nuke). Overlay+restore used; hexa-sh left clean (d9).
- [ ] NEXT runnable: stack #4 (PR-atlas owner-gated refusal) or #5 (PR-record-loader, shared base for list-*/show/gate).

## 2026-06-03 — REORDER: Swift 폐기 FIRST (user directive) — Family-A Swift PRs SUPERSEDED

User directive mid-`/afg`: "swift 폐기먼저 해야돼" + "도메인에 반드시 기록". The
about-to-launch Family-A Swift PR2/PR3 (wire `synthesize`→QFORGE on
`cockpit/Sources/DemiurgeCLI/main.swift`) was HALTED — it would extend a surface
that is slated for deletion. Recorded here + in `8VERB.md` milestones + §6 shelf.

- [x] HALTED the Swift-surface PR2/PR3 agent launch (foreground afg branch 1/2) before any edit — no Swift code added.
- [x] Confirmed canonical path = `drafts/demi-cli-pure-hexa-native-plan.md` (status=active · mode=auto complete-forced · @L1-7 locked): strip Swift COMPLETELY out of `demiurge cli` → pure hexa-native under `stdlib/demi/` (hexa-lang); `cockpit/` (24053 Swift LOC) deleted ONLY after the per-verb parity `@ci_gate` is ALL-GREEN (@L2, no forced deletion); `bin/demiurge cli` flips `swift run`→`hexa` after parity (@L5); web GUI Next.js + react-three-fiber UNTOUCHED (@L4).
- [x] Re-homed the 8VERB milestones onto the pure-hexa 28-PR stack: synthesize→QFORGE = stack #20 (PR-synthesize-qforge, `hexa qforge run <deck>`, output VERBATIM, HELD gate ≠ agreement, d6); verify-gate = stack #3 (PR-verify-record) + verify-passthrough already ✅ MERGED (hexa-lang #2602). FOUNDATION+PROOF ✅ landed (hexa-lang PR#2597 + #2602 = rows 1-2: manifest-driven d4 dispatch + parity smoke; discover + verify-passthrough cells byte≡Swift).
- [x] §6 shelf: CLI-home decision flipped (a)/(b) → **(c) Swift 폐기 FIRST** LOCKED 2026-06-03.
- [ ] NEXT: resume the pure-hexa stack at PR #3 (PR-verify-record) — hexa-lang `stdlib/demi/`, each PR <200 lines + own parity cell (g4/@L7). NOT on Swift.

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

