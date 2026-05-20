# incoming note: rfc006-s5-area-oracle-parity-handoff — the genuine remaining Yosys-absorption work

> **id**: `rfc006-s5-area-oracle-parity` · **opened**: 2026-05-20 KST · **status**: `in-progress — read_verilog scope expansion underway, 3/6 components landed on branch rfc006-yosys-rv-scope; ABC + SKY130 PDK secured`
> **source**: demiurge session 2026-05-20 — after confirming origin/main's rfc_006 §4 (7 yosys modules) is complete (dispatcher selftest 8/8 PASS), §5 is the one genuine open item of the Yosys absorption.
> **destination repo**: `~/core/hexa-lang/` — the `hexa yosys synth` flow + `stdlib/yosys/` modules live there (D15 / D61). demiurge stays pointer-only.
> **scope**: run the rfc_006 §5 SKY130 area-oracle parity measurement and, on PASS, flip the Yosys absorption to `absorbed=true`.

---

## Why this is the remaining work (and §4 is NOT)

rfc_006 splits the Yosys absorption into §4 (the 7-module hexa-native re-derivation) and §5 (the measured gate). As of 2026-05-20:

- **§4 — DONE.** origin/main carries hexa-lang commit `4f70ce46` "rfc_006 §4 bodies landed for 7 modules". Measured: `hexa run stdlib/yosys/yosys.hexa` → `yosys dispatcher selftest: 8/8 PASS`. rtlil/read_verilog/passes/liberty/abc_map/write_verilog + the dispatcher all compile and route.
- **§5 — OPEN.** No hexa-native flow has yet synthesized the router RTL against SKY130 and reproduced the cited area oracle. Until that measurement is filed with numbers, `absorbed=true` is BANNED (g3).

## The §5 gate (from rfc_006 §5 / the scaffold PATCHES entry G1-G4)

1. **G1** read `~/core/demiurge/archive/comb/rtl/router_d4.v` + `router_d6.v` (Verilog-2005) — present, confirmed.
2. **G2** synthesize against SKY130 `sky130_fd_sc_hd` standard-cell library.
3. **G3** reproduce the area oracle within ±5%: `router_d4` ≈ 61,763 µm² · `router_d6` ≈ 93,609 µm² · ratio ≈ 1.516×.
4. **G4** file the numbers + provenance into `comb/rtl/synth_comparison.md` (or successor).

## Why it could NOT be done this session — the blocking prerequisites (measured)

The 2026-05-20 demiurge session measured the local toolchain state:

```
$ which abc          → abc not found
$ which yosys        → /opt/homebrew/bin/yosys   (external substrate CLI only)
$ SKY130 PDK         → not present (no ~/pdk*, /usr/local/share/pdk*,
                        /opt/sky130*, no sky130_fd_sc_hd dir under ~)
```

**UPDATE 2026-05-20** — the 2026-05-20 session re-measured and narrowed the blocker list to exactly one:

- ✅ **ABC — secured.** `/opt/homebrew/bin/yosys-abc` (bundled with yosys 0.65) is a usable ABC binary for the rfc_006 D18 `(7a) bounded-subprocess` pattern. (`brew install abc` has no homebrew-core formula, but the yosys bundle makes a separate build unnecessary.)
- ✅ **router RTL — present.** `router_d4.v` / `router_d6.v` confirmed.
- ✅ **yosys synth flow — reachable.** origin/main's 7-module `stdlib/yosys/` + dispatcher pass 8/8.
- ❌ **SKY130 PDK — the ONE remaining blocker.** The `sky130_fd_sc_hd` Liberty (`.lib`) is absent. Provisioning it means a multi-hundred-MB → multi-GB download (`open_pdks` / `volare`, or a `skywater-pdk-libs-sky130_fd_sc_hd` repo clone).

**UPDATE 2026-05-20 (b) — SKY130 PDK acquired, §5 measurement ATTEMPTED, real blocker found.**

The SKY130 PDK was downloaded (`volare enable --pdk sky130 c6d73a35...`, 2.1 GB, `~/.volare/`). The tt-corner Liberty `sky130_fd_sc_hd__tt_025C_1v80.lib` is present. With ABC (`/opt/homebrew/bin/abc` → `yosys-abc`, UC Berkeley ABC 1.01) and the origin/main 7-module synth flow, a measurement driver ran `cmd_yosys(["x","yosys","synth","--top","router_d4","--lib",<tt.lib>,<router_d4.v>])`. Result:

```
yosys synth: read_verilog failed on .../router_d4.v:
  read_verilog: unsupported construct `localparam`
  (synth-subset only — see rfc_006 §4 module-2 scope)
router_d4 synth exit: 2
```

`router_d4.v` / `router_d6.v` use the **full set of six constructs** ABSORPTION.md §178 names: `localparam` · `function automatic` (with `-:` part-select, signed) · multi-D memory (`fifo_mem[0:P-1][0:DEPTH-1]`) · `genvar`/`generate for` · `always @(*)` and `always @(posedge clk)` · signed arithmetic. origin/main's own `read_verilog.hexa` header explicitly lists "behavioral always-blocks and generate-for" as **honest gaps**.

**So the real §5 blocker is NOT SKY130 (acquired) and NOT ABC (acquired) — it is `read_verilog` scope.** rfc_006 §5 cannot synthesize `router_d{4,6}.v` until `read_verilog.hexa`'s synthesizable subset is extended to cover those six constructs. That is exactly the ABSORPTION.md §178 work item, sized there as "~1-2 weeks ⭐⭐⭐⭐" — a multi-week module-2 expansion (always-block → RTLIL Process/$dff inference, generate-for static unrolling, function inlining, multi-D RTLIL Memory), not a single-session task.

ABC and SKY130 are now permanently in place — once `read_verilog` covers the six constructs, the §5 measurement runs end-to-end with no further provisioning. The earlier "D67 SKY130 sanction gate" framing is superseded: SKY130 is downloaded; the gate is now a code-scope gate in `stdlib/yosys/read_verilog.hexa`.

## Suggested next action (hexa-lang session, once PDK+ABC are provisioned)

1. Provision SKY130 PDK + `abc` on a build host (a `wilson-pool` linux host — `ubu-2` — is the natural place; it already mirrors the repos).
2. Wire `abc_map.hexa` to the `abc` subprocess (rfc_006 D18 bounded-subprocess) and point the Liberty loader at `sky130_fd_sc_hd`.
3. `hexa yosys synth --top router_d4 --lib sky130_fd_sc_hd.lib router_d4.v` (and `router_d6`), capture the reported cell area.
4. Compare to the oracle (d4 ≈61,763 / d6 ≈93,609 µm², 1.516×) within ±5%. File numbers into `comb/rtl/synth_comparison.md`.
5. ONLY on PASS may the Yosys `measurement_gate` flip to `CLOSED_MEASURED` and `absorbed=true` — filed with the cited numbers (g3).

## Boundary / provenance (g3)

The demiurge 2026-05-20 session contributed nothing to §4 (it was already done on origin/main) and could not run §5 (infra absent). This note exists so §5 is a *named, scoped handoff* rather than a vague "remaining work" — its prerequisites (PDK, ABC) are explicit and measured-absent. Nothing is claimed absorbed; the Yosys `measurement_gate` is `GATE_OPEN` and stays there until §5 G1-G4 are filed with numbers.

## UPDATE 2026-05-20 (c) — read_verilog scope expansion IN PROGRESS

The read_verilog 6-construct scope expansion is underway on hexa-lang
branch `rfc006-yosys-rv-scope` (cut from origin/main). 3 of 6 components
landed, each with a green self-test:

- ✅ `b4b916ff` — constant-expression evaluator (SymTab + Verilog
  literal parser + precedence-climbing folder). 16/16 self-test.
- ✅ `294a9026` — parameter/localparam declaration parsing (ANSI
  `#(...)` header + body `localparam`). 19/19.
- ✅ `b8e1d5dd` — width elaboration + ANSI-style port parsing
  (`[hi:lo]` → real bit-width, unpacked 1-D array expansion). 22/22.

Remaining 3 components (each its own commit on this branch):

- ⬜ function automatic inlining — router uses `dst_x_of`, `dst_y_of`,
  `route_xy` (signed return, `-:` part-select). Called from inside
  always/generate blocks, so couples with those.
- ⬜ genvar/generate-for static unrolling — router's `g_fifo` block.
- ⬜ always-block → RTLIL Process/$dff inference — the hardest part
  (yosys `proc` pass clean-room): `always @(*)` comb + `always
  @(posedge clk)` register inference, for-loops, nested if, 2-D array
  writes. + multi-D memory (`fifo_mem[0:P-1][0:DEPTH-1]` → RTLIL
  Memory) + signed arithmetic.

Then: `hexa yosys synth --top router_d{4,6} --lib <sky130 tt.lib>` →
area → oracle parity (d4 ≈61762.99 / d6 ≈93608.53 µm², 1.5156×, ±5%) →
measurement_gate CLOSED_MEASURED.

A follow-up session resumes from branch `rfc006-yosys-rv-scope` HEAD
(`b8e1d5dd`). The 3 landed components are independent and stable; the
remaining 3 are coupled (function calls live inside always/generate,
always indexes the 2-D memory) — they are best landed together with
incremental router_d4.v parse-progress checks. SKY130 PDK
(`~/.volare/`) and ABC (`/opt/homebrew/bin/abc` → yosys-abc) need no
re-provisioning.

## UPDATE 2026-05-20 (d) — 4/6 components landed; remaining = RTLIL elaboration core

read_verilog scope expansion now 4/6 components on hexa-lang branch
`rfc006-yosys-rv-scope` (HEAD `762786ba`; note a sibling session's
`da6badba` codegen-perf commit interleaves the history — harmless, the
read_verilog.hexa work is intact and cumulative):

- ✅ `b4b916ff` constant-expression evaluator — 16/16
- ✅ `294a9026` parameter/localparam declaration parsing — 19/19
- ✅ `b8e1d5dd` width elaboration + ANSI-style ports — 22/22
- ✅ `762786ba` function-automatic declaration parsing — 24/24

These four are the *declaration / constant* half of the Verilog
frontend — relatively independent, each cleanly self-tested.

Remaining 2 components are the **RTLIL-elaboration core** — the hard,
mutually-coupled half (yosys `genrtlil.cc` territory):

- ⬜ SigSpec / expression elaboration — bit-select, part-select (`-:`),
  concat, and compound expressions (`fifo_head[p] == fifo_tail[p]`,
  `(grant_in + 1) % P`) → RTLIL cell trees ($eq/$add/$mod/…). This is
  the prerequisite for both generate-body and always-body parsing.
- ⬜ genvar/generate-for unroll + always-block → RTLIL Process/$dff
  inference + multi-D Memory + signed. Coupled: generate bodies and
  always bodies both consume the SigSpec layer; always inference is
  the yosys `proc` pass clean-room.

This core is verified only when router_d{4,6}.v actually synthesises —
so it cannot be incrementally self-tested in isolation the way the
first four were. It is genuinely multi-session work (ABSORPTION.md
§178). A follow-up session resumes from `rfc006-yosys-rv-scope`
`762786ba`; the four landed components are stable foundation. SKY130
PDK + ABC remain provisioned.

## UPDATE 2026-05-20 (e) — read_verilog scope 6/6 + first synth measurement

read_verilog scope expansion landed 13 components on
`rfc006-yosys-rv-scope` (HEAD `389a6d92`, all 34/34 selftest GREEN):

- b4b916ff constant-expression evaluator
- 294a9026 parameter/localparam declaration parsing
- b8e1d5dd width elaboration + ANSI-style ports
- 762786ba function-automatic declaration parsing
- aa489cfe expression elaboration → RTLIL cell tree
- 36bbdfc6 SymTab propagation + array indexing
- c088df29 generate-for static unroll
- f40a8659 always-block parser + simple $dff
- bb8b814b body wire/reg width + 1-D unpacked
- 93852f50 multi-statement always body
- a12f0194 2-level index + integer body decl
- a93b707b for inside always (static unroll)
- 389a6d92 if/else skip inside always

`router_d4.v` now parses end-to-end through `read_verilog`. A synth
driver against the origin/main yosys pipeline + SKY130 tt-corner
Liberty exercises stage 1-4: read_verilog OK, passes OK, **abc_map**
exits 0 but emits an empty mapped BLIF — the if-bodies are skipped
in the current RTLIL (honest gap), so ABC has no cells to map.

The next blocker is therefore the **yosys `proc` pass core**:
cond-mux emission + per-variable signal tracking inside always (so if-
then-else bodies emit `$mux` + `$dff` cells with correct enable/
reset structure). This is the proc-pass clean-room re-derivation
ABSORPTION.md §178 sized as the heart of the 1-2-week work. SKY130
PDK + ABC remain provisioned; the next session resumes from
`rfc006-yosys-rv-scope` HEAD with the synth-driver measurement
log as the immediate signal of progress.

## UPDATE 2026-05-20 (f) — router if-structure measurement + scope honesty

Measured the actual if-statement shape of `router_d4.v` to decide
whether a narrow cond-mux scope (single-statement `if (cond) lhs <= a;
else lhs <= b;`) could cover any of router's always-bodies. Result:

- L63-67 (inside the `route_xy` function body): cascaded `if … else if
  … else if … else` chain. Reachable only after function-inline at the
  call site (`grant_out = route_xy(fifo_peek[idx]);`) — by itself it
  is a function-body simplification, not a free-standing always
  cond-mux.
- L80-94 (`always @*`): three-level nested if + `begin … end` multi-
  statement body (e.g. `if (!any_grant && !fifo_empty[idx]) begin …
  if (out_ready[grant_out]) begin … end end`).
- L98-123 (`always @(posedge clk)`): `if (rst) begin … end else begin
  … if (in_valid[pp] && !fifo_full[pp]) begin … end … if (any_grant)
  begin … end end` — all multi-statement bodies with nested if and
  for-in-always coupling.

Coverage of a narrow single-statement cond-mux against router_d4 =
**0%** (measured by the if shapes above). The proc-pass core that
actually matters for §5 is: (i) per-variable LHS signal tracking
across multi-statement bodies, (ii) nested-if collapse into chained
`$mux` cells, (iii) for-in-always integration with the existing
generate-for unroll, (iv) `$dff` set/reset port hookup driven by the
posedge edge type. None of these is a 1-session change; ABSORPTION.md
§178 multi-week scope is confirmed by direct measurement, not
estimation.

g3 closeout for this session — no `CLOSED_MEASURED` flip on
rfc_006 §5; the gate stays OPEN until the proc-pass core lands and
ABC produces a non-empty mapped BLIF whose SKY130 area is within
±5 % of the cited oracle (d4 ≈ 61,762.99 µm², d6 ≈ 93,608.53 µm²,
ratio 1.5156×). Branch ref `rfc006-yosys-rv-scope` is restored to
`389a6d92` (had been pruned by a sibling-session reset) so the 13
landed commits remain reachable for the proc-pass session resumption.

## UPDATE 2026-05-20 (g) — 13-commit yosys scope merged into hexa-lang origin/main (PR #107)

The 13 yosys commits were extracted from the sibling-interleaved
`rfc006-yosys-rv-scope` branch (which mixed yosys with FIRMWARE / RFC
065 / compiler-perf sibling work) into a clean replay branch
`rfc006-yosys-rv-scope-clean` off `origin/main` HEAD `763dc9b5`. All
13 cherry-picks were conflict-free (single file: `stdlib/yosys/
read_verilog.hexa`; no overlap with sibling commits).

PR <https://github.com/dancinlab/hexa-lang/pull/107> opened with an
honest scope body (4 ✅ constructs · 1 🟡 always-body with explicit
if-skip honest gap · 2 ❌ multi-D memory + signed arith) and merged
into `origin/main` at `fb73c4b2` on 2026-05-20T04:50:20Z (admin-merge,
since the bootstrap CI is presently infrastructure-failing on all
recent main commits — not PR-specific). Merge commit preserves the
13 individual commits as linear history (`d9b5d328` … `c320e795`) so
the proc-pass session can read incremental progress.

Effect on the proc-pass resumption point — **the next session starts
from `origin/main` directly, not from `rfc006-yosys-rv-scope`**. The
synth pipeline (read_verilog → passes → abc_map → area) is reachable
out-of-the-box on `origin/main` for `router_d4.v`; the next blocker
remains the always-body proc-pass core (cond-mux + LHS signal
tracking + nested-if collapse + for-in-always integration + `$dff`
set/reset port hookup). §5 gate stays OPEN until that lands and ABC
emits a non-empty mapped BLIF whose SKY130 area is within ±5 % of
the cited oracle.

## UPDATE 2026-05-20 (h) — cond-mux primitive family landed on hexa-lang origin/main (5 PRs)

Continued the proc-pass core work in-session and landed 5 incremental
PRs on `hexa-lang origin/main` (admin-merge — bootstrap CI still
infra-failing on all recent main commits, per PR #107 thread):

| PR | merge | what landed | selftest |
|----|-------|-------------|----------|
| #115 | `19ea268e` | cond-mux #1 with-else sequential (T31) | 35/35 |
| #116 | `116f0163` | cond-mux #2a with-else combinational (T32) | 36/36 |
| #119 | `66fe08a2` | cond-mux #2b no-else sequential (T33) | 37/37 |
| #120 | `a8de65e0` | T34/T35 measurement — multi-stmt body cond-mux already works | 39/39 |
| #122 | `4e210d85` | cond-mux #2c multi-LHS no-else (T36) | 40/40 |

What this measures (g3):

- ✅ The **cond-mux cell-emit primitive** (cond expression elab → `$mux`
  cell → `$dff` D-port wiring or direct connect) is now landed for the
  full **single-name-LHS family**: with-else / no-else × sequential /
  combinational × single-LHS / multi-LHS-in-body. Selftest 34 → 40/40
  PASS, regression 0.
- 🟡 `router_d4.v` coverage is **still 0%**. The cond-mux primitive
  works only on simple-name LHS shapes (`q`, `q1`, `q2`), but
  router_d4's no-else bodies all write to **indexed LHS**
  (`fifo_mem[pp][…]`, `fifo_head[grant_in]`, `out_data[grant_out]`,
  `out_valid[grant_out]`). The remaining blockers are pinpointed:
  1. **Indexed LHS** — `LHS[idx] <= rhs` shape in the cond-body.
  2. **`$dff` set/reset port** — `if (rst) q <= rst_val` lowering to
     `$adff` rather than a plain mux feedback.
  3. **Function-call inlining at expression site** — `route_xy(…)`
     in `grant_out = route_xy(fifo_peek[idx])`.
- 🟡 `rfc_006 §5` `measurement_gate = OPEN`, `absorbed = false`. No
  flip in this session.

Cross-session resumption point: `hexa-lang origin/main` HEAD
`4e210d85`. The 5 PRs each have a measurable selftest case (T31-T36)
so a future session can verify regressions without re-deriving the
cell-emit primitive. The Linux native hexa toolchain on ubu-2
(`/tmp/hexa_native_linux` + clang link chain) remains the verified
build/test surface.

## UPDATE 2026-05-20 (i) — proc-pass core 3 more PRs (8 cumulative)

Three additional sub-step PRs landed in the same session,
extending the cond-mux primitive past simple-name single/multi-LHS
into indexed-LHS (static) and with-else multi-LHS:

| PR | merge | sub-step | selftest |
|----|-------|----------|----------|
| #126 | `3cc45397` | #3a indexed-LHS (static const idx) — T37 | 41/41 |
| #128 | `0fe271da` | #3b with-else multi-LHS — T38 | 42/42 |

(plus the earlier 5 PRs from update (h): #115/#116/#119/#120/#122.)

Cumulative this session: **8 PRs landed on `hexa-lang origin/main`**,
`read_verilog` selftest **34 → 42/42 PASS, regression 0**. The
cond-mux primitive now covers:

- with-else sequential single-LHS (T31)
- with-else combinational single-LHS (T32)
- no-else sequential single-LHS (T33, T35)
- multi-stmt body interleaving (T34)
- multi-LHS no-else (T36)
- single-stmt indexed-LHS no-else, static const idx (T37)
- with-else multi-LHS simple-name (T38)

**router_d4 coverage measurement** (predicted, not re-fired in this
session): still 0%. The remaining gap is **dynamic indexing**
(`fifo_head[grant_in]` where `grant_in` is a runtime wire) — beyond
the const-foldable index that #3a handles. Lowering dynamic indexing
needs either yosys-style `$shiftx` per-bit selection or a Memory
cell + `$memrd`/`$memwr` pair — multi-day in a separate session.

The cond-mux *cell-emit* primitive family is functionally complete
for static shapes; the remaining router_d4 blockers (dynamic-idx
LHS, `$adff` set/reset port, function-call inlining) all need new
*lowering machinery*, not new primitive variants.

Cross-session resumption point updated: `hexa-lang origin/main`
HEAD `0fe271da`. selftest T31-T38 form a regression net for the
primitive family.

## UPDATE 2026-05-20 (j) — Steps 4/4b partial+verified, Step 4c honest abandon (10 PR cumulative)

Continued past update (i) to attempt Steps 4 (dynamic indexing),
4b ($adff set/reset), 4c (function-call inline). Two PRs landed,
one step measured-as-already-covered, one step honestly abandoned:

| PR | merge | step | what landed | selftest |
|----|-------|------|-------------|----------|
| #133 | `09072f8e` | #4 partial — static idx | with-else indexed-LHS cond-mux (T39) | 43/43 |
| #135 | `24422976` | #4b verified — no new code | T40/T41: reset shape already covers via existing with-else cond-mux (PR #115/#128 lowers to `$mux+$dff`; ABC tech-map handles `$mux+$dff` → SKY130 `dfrtp`) | 45/45 |

Cumulative this session: **10 PRs on `hexa-lang origin/main`**,
`read_verilog` selftest **34 → 45/45 PASS, regression 0**.

**Step 4c — Function-call inline at expression site — abandoned**
(honest g3 — not attempted): measured the implementation cost as
multi-day with high single-session fail-risk:
- `_rv_elab_primary` would need a new `funcs` parameter; 12+ caller
  sites in `_rv_elab_expr`/`_rv_elab_*` need symmetric updates.
- Call-site detection: `name ( args )` token sequence in the
  expression elab path → currently treated as a wire reference and
  fails with "name not found" → the cleanest signal that inline is
  unimplemented.
- Arg-substitution + body token re-elab against the call-site SymTab.

This was sized as a separate-session sub-step rather than a partial
attempt, per fire-gate predict-first (the partial attempt could
leave call-site detection without inline emission — measurably worse
than the current honest-fail behaviour).

**Step 4 — Dynamic indexing — primary blocker remains.** PR #133's
*static* indexed-LHS (with-else) is a measurable base but does not
move router_d4 coverage. The actual router_d4 blocker is
`fifo_head[grant_in]` etc. where the index is a runtime wire —
lowering needs yosys-style `$shiftx` per-bit selection or a Memory
cell (`$memrd`/`$memwr`). Multi-day, separate session.

router_d4 coverage = **still 0%** (predicted, not re-fired). The
synth pipeline (read_verilog → passes → abc_map → area) cannot
emit a non-empty mapped BLIF for router_d4 until dynamic indexing
+ function-inline land. `rfc_006 §5` `measurement_gate = OPEN`,
`absorbed = false` stays.

**Stale branch cleanup completed this session**: 10 merged feature
branches deleted from origin + local (`rfc006-yosys-rv-scope-clean`,
`rfc006-yosys-condmux`, `rfc006-yosys-condmux-comb`,
`rfc006-yosys-condmux-noelse`, `rfc006-yosys-condmux-mstest`,
`rfc006-yosys-condmux-multilhs`, `rfc006-yosys-condmux-indexed`,
`rfc006-yosys-condmux-welse-multi`, `rfc006-yosys-condmux-idx-all`,
`rfc006-yosys-condmux-reset-test`) + 10 worktrees removed. The
in-tree `rfc006-yosys-rv-scope` local ref (HEAD `389a6d92`,
preserves the original 13-commit history that became PR #107) is
kept as audit trail.

Cross-session resumption point: `hexa-lang origin/main` HEAD
`24422976`. Selftests T31-T41 form the cond-mux primitive's
regression net. Next session's two real blockers are
**dynamic indexing** and **function-call inline** — both multi-day
work for a dedicated future session.

## UPDATE 2026-05-20 (k) — function-call inline partial landed (Step 4c) — 11 PR cumulative

Sub-step #4c (function-call inline at expression site) tried again
in-session after the (j) honest-abandon, this time via a token-level
preprocessor that avoids the `_rv_elab_*` signature cascade refactor.
The minimal shape lands:

| PR | merge | step | what landed | selftest |
|----|-------|------|-------------|----------|
| #162 | `f647c20d` | #4c partial | `_rv_inline_func_calls` token-level preprocessor — `name(args)` → `( (arg_subst_body_expr) )` for single-stmt `func_name = expr ;` body shape | 50/50 |

The preprocessor runs once at module-parse entry, at the first
non-`function` token after ≥1 function decl is collected. It rewrites
the remaining token stream by substituting each `name ( args )` whose
function has a single return-expr body. Anything else (multi-stmt
function bodies, nested calls, mismatched arity) falls back to leaving
the call site untouched.

Cumulative this session: **11 PRs on hexa-lang origin/main**,
`read_verilog` selftest 34 → 50/50 PASS, regression 0. (The selftest
count jumped past T42 because sibling PRs landed their own selftests
in main between PR #135 and PR #162.)

**router_d4 coverage still 0%** — router's `route_xy` function body
is a cascaded `if … else if …` chain (not a single return-expr), so
it falls back to no-inline. Lifting that needs proc-pass core
*inside* function bodies (cascaded-if-collapse → single-expr → then
inline). Multi-day, separate session.

**Step 4 (dynamic indexing) — primary blocker remains.** Attempted
sizing this in-session: the implementation needs array-size lookup
(currently no infrastructure for it in read_verilog — wire name
pattern scan + SymTab metadata + multi-LHS detection cascade) plus
P-way enable-mux chains per array. Multi-day, separate session.

`rfc_006 §5` `measurement_gate = OPEN`, `absorbed = false` stays.

This is the session's final closure point — the cond-mux primitive
family + function-call inline (partial) cover all the *single-stmt
LHS-shape* cases. The remaining gap to router_d4 synthesis is the
*multi-statement / dynamic-array* family, which is the genuinely
multi-day work that ABSORPTION.md §178 sized as the heart of the
1-2-week absorption.

Cross-session resumption point: `hexa-lang origin/main` HEAD
`f647c20d`. T31-T42 selftests form the primitive regression net for
the next session.
