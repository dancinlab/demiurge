# 8VERB — log

Append-only history sister of `8VERB.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-04 — `all fg go`: pure-hexa stack #6 + #7 + #8 landed (list-kinds · show-record · gates)

Three foreground branches, all hexa-native (Swift untouched), all on the #5 RecordLoader base.

- [x] #6 PR-list-kinds → hexa-lang **PR#2641 MERGED**: `list-all/records/decisions/rfcs/domains`. `record_loader.hexa` +274 (`rl_stubs(kind)` for decision/rfc/domain; f1f2 path-scan kept so #5 loader cell stays `[]` for non-f1f2 — additive). `_list_render` mirrors Swift `list(kind:)` byte-for-byte (decisions from `design.md` `### Decision N`, rfcs from `proposals/rfc_*.md`, domains from `domains/*.md`+matter pointer, id-pad alignment). 10 cells → **26/26 GREEN** (live Swift arm).
- [x] #7 PR-show-record → hexa-lang **PR#2642 MERGED**: `show <path>` typed-field + provenance dump. Uses load-BY-PATH only (not resolve-by-id), `show:` prefix + exit 2 on failure (vs verify's `verify:`/exit1) → `_show_err` re-derives. 4 cells (ok/outside/missing/decode; Foundation decode tail env-owned, head+rc asserted) → **30/30 GREEN**.
- [x] #8 PR-gates → hexa-lang **PR#2643 MERGED**: `list-gates` (group by `measurement_gate` in MeasurementGate.allCases) + `gate-summary` (per-gate %.1f + absorbed tallies). KEY parity: both Swift verbs `guard case .success` → SKIP undecodable records; added strict `rl_f1f2_decodes()` so hexa skips the same 2 `router_*_pnr_sky130hd.json` (missing traffic/sim_commit_hash) → total 54→52 matches Swift (OPEN=49 CLOSED=3 absorbed=3/49). 4 cells → **34/34 GREEN**.
- [x] toolchain recipe nailed down (for #9+): imports resolve relative to ENTRY tree (`DEMI_HEXA_ENTRY` for child `hexa run`); gen3 `~/.hexa-cache/` is keyed on ENTRY file ONLY → `rm -rf ~/.hexa-cache/*` before EACH build/test or you test a stale binary (imported-handler edits silently ignored). No hexa-sh mutation needed.
- [ ] NEXT runnable: #9 domain-catalog (DomainCatalog+IngredientShelf, base for shelf/compose) · #12 project-store · #14 operate · #17 llm · #18 cellrun-engine (unblocks the `action` HAPPY path → synthesize→QFORGE #20).

## 2026-06-04 — `all fg go`: pure-hexa stack #4 + #5 landed (atlas-refusal · record-loader)

Two foreground branches the prior turn offered, both hexa-native (Swift untouched).

- [x] #4 PR-atlas → hexa-lang **PR#2639 MERGED** (squash into stack branch): `atlas` flipped manifest `subprocess`→`local`; `handler_atlas` classifies read (lookup/stats/hash/dump → verbatim forward) vs write (register/append-witness/pr) — write w/o `DEMIURGE_OWNER` REFUSED stderr `owner op (사장실 · M20)` rc2, with owner → forward. Generic dispatch untouched (d4). 3 parity cells (GOLDEN+live).
- [x] #5 PR-record-loader → hexa-lang **PR#2640 MERGED**: hexa-native `RecordLoader`+`ArtifactRegistry` (`record_loader.hexa`, 244L) — exports-root resolve (`$DEMIURGE_REPO/exports` else `<cwd>/../exports`), `rl_enumerate`/`rl_load_by_id`/`rl_load_by_path`/`rl_resolve` mirroring Swift, invariant-a path guard (outside + `..`-escape refused). Refactored `verify_record.hexa` onto it (224→123L, d3 dedup) — its 5 cells stayed byte-green. Loader `@ci_gate` self-check added.
- [x] parity verdict VERBATIM (g5): `demi_parity_selftest PASS` — **17/17 cells GREEN** (4 discover/action + 3 verify-passthrough + 5 verify-record + 3 atlas + 1 loader self-check + 1 live-forward). No discover stale-binary noise this run.
- [x] runtime finding (for the stack): in-process `setenv()` is a no-op stub (`hxlcl_setenv`) — env-dependent cells must spawn a child `hexa run` with the env set at child startup (verify cells + loader cell both use this).
- [x] stack topology: all sub-PRs squash-merge INTO branch `demi-stack3-verify-record` (now #3+#4+#5); that branch → main = PR#2638 (OPEN, the funnel PR). pr-cycle harness hook auto-merges each sub-PR into its base — linear stack preserved, reported honestly.
- [ ] NEXT runnable: #6 list-kinds · #7 show-record · #8 gates — all build on the #5 `RecordLoader` base.

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

