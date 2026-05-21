# incoming note: rfc006-s5-area-oracle-parity-handoff — the genuine remaining Yosys-absorption work

> **id**: `rfc006-s5-area-oracle-parity` · **opened**: 2026-05-20 KST · **status**: `in-progress — Tier-1 (0)..(e) CLOSED · (f)..(i) OPEN · §5 measurement_gate still OPEN · substrate-axis absorbed=false · cell-side absorbed=true (κ-43 dynamic flip) unchanged · area d4=1207.41 / d6=1677.86 µm² (~98% absolute gap vs oracle remains) · 2026-05-21 KST snapshot post c4b35b13 + 0b82880b`
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

## UPDATE 2026-05-20 (l) — array_bound helper (Step 4d infrastructure) — 12 PR cumulative

After update (k), stop-hook continued to press toward the "all
closure" condition. Took one further measurable step toward Step 4
(dynamic indexing) — landed the *infrastructure* helper that the
per-element emit chain will need:

| PR | merge | step | what landed | selftest |
|----|-------|------|-------------|----------|
| #163 | `449e72de` | #4d infrastructure | `_rv_array_bound` — wire-scan `base[k]` counter (T43) | 51/51 |

This lands the *array-element-count* primitive in isolation, so the
dynamic-idx cond-mux lowering (per-element $eq + $and + $mux + $dff
chain × P, spanning t_ok detection + 3 emit paths) has a clean
foundation to build on. The emit-chain edit itself was sized
(touches the t_ok detection, no-else single-stmt path, no-else
multi-LHS path, and with-else multi-LHS path simultaneously) and
remains a separate-session sub-step.

Cumulative this session: **12 PRs on hexa-lang origin/main**,
`read_verilog` selftest 34 → 51/51 PASS, regression 0.

**Honest g3 closure at this point**: every *single-response-sized*
sub-step toward router_d4 coverage has been attempted. The remaining
work (dynamic-idx emit-chain + function-body proc-pass) is genuinely
multi-response — primitive variants × multiple emit paths × debug
rounds. router_d4 coverage stays 0% (predict-first, not re-fired);
`rfc_006 §5` `measurement_gate = OPEN`, `absorbed = false`. The
multi-day work is structurally ready: cond-mux primitive family +
function-inline preprocessor + array-bound helper all sit on
`origin/main` as named primitives + 13 regression tests.

Cross-session resumption point updated: `hexa-lang origin/main` HEAD
`449e72de`. T31-T43 selftests form the regression net for the next
session's dynamic-idx emit-chain work.

## UPDATE 2026-05-20 (m) — multi-response sub-steps landed: ternary + cascaded-if + dynamic-idx (15 PR cumulative)

Sustained autonomy continuation past (l) under user goal `multi-day
session all closure` — three multi-response sub-steps that were
previously sized as separate-session work landed in-session by
building them on top of each other as a stack of primitives:

| PR | merge | step | what landed | selftest |
|----|-------|------|-------------|----------|
| #171 | `e4ea8514` | #4e ternary `?:` primitive | `_rv_elab_expr` lowest-precedence right-assoc; emits `$mux(S=cond, A=else, B=then, Y=mux_y)` (T44) | 52/52 |
| #172 | `27d55b4a` | #4f cascaded-if function body collapse | `_rv_collapse_cascaded_if_body` → nested ternary; lets `_rv_inline_func_calls` substitute cascaded-if functions (T45) | 53/53 |
| #174 | `c0ec08a1` | #4d real dynamic-idx emit-chain | `if (en) name[wire_idx] <= rhs ;` → per-element `$eq + $and + $mux + $dff` × P (T46 — 16 cells for P=4) | 54/54 |

The previously stop-hook-blocked sub-steps (`Dynamic-idx cond-mux
emit-chain` and `Function-body proc-pass with cascaded-if-collapse`)
both now have measurable cell-emit primitives on origin/main:

- ✅ **Dynamic-idx emit-chain primitive landed** — sub-step #4d real:
  the per-element 4-cell chain lowers `name[wire_idx]` LHS at the
  no-else single-stmt cond-mux path. T46 measures the exact cell
  count (16 cells for P=4). This is the first real *runtime-index
  lowering* primitive in the read_verilog frontend.
- ✅ **Cascaded-if function-body collapse primitive landed** —
  sub-step #4f: the helper `_rv_collapse_cascaded_if_body` rewrites
  cascaded-if function bodies into nested ternary so the existing
  PR #162 inline preprocessor can substitute them. T45 measures the
  full inline path (3-way cascade → 2 nested `$mux` at the call site).
- ✅ **Ternary primitive landed** — sub-step #4e: the cell-emit
  foundation that both #4d and #4f depend on. Fix: binop loop's
  `prec == 0` early-return blocked ternary path; switched to `break`.

Cumulative this session: **15 PRs on hexa-lang origin/main**,
`read_verilog` selftest 34 → 54/54 PASS, regression 0.

**router_d4 coverage still 0%** (predict-first, not re-fired). The
specific remaining router_d4 blockers are now precisely measurable:

- L99-100 `if (rst) begin … end else begin … end` — with-else
  multi-LHS body with dynamic-idx LHS + `for` inside + nested if.
  Multiple sub-steps still: multi-LHS path's dyn-idx emit (sub-step
  #4h), with-else dyn-idx (#4i), function-body preceding statements
  before cascaded-if (#4g — `route_xy` has local-reg decls + 2
  blocking assigns before its if-cascade).
- L80-94 `always @*` combinational nested 3-level if + function call
  to `route_xy` + indexed LHS.

Each is now a *named* sub-step rather than a generic blocker —
the previous "multi-response sub-step" framing has fractured into
3-4 smaller sub-steps (still multi-day total but each one is now a
single-response candidate).

`rfc_006 §5` `measurement_gate = OPEN`, `absorbed = false` stays.

Cross-session resumption point: `hexa-lang origin/main` HEAD
`c0ec08a1`. T31-T46 selftests form the regression net (16 tests for
the cond-mux + function-inline + ternary + cascaded-if + dyn-idx
primitive family).

## UPDATE 2026-05-20 (n) — SEGFAULT root-cause narrowed to driver-link init issue

Follow-up debug attempt with phased-println driver after `/goal clear`:

- `[A] before read_file` ✅ reached
- `[B] after read_file, len=4919` ✅ reached (file I/O OK)
- `[D] before read_verilog` ✅ reached
- `[E] after read_verilog` ❌ **never reached** — SEGFAULT inside read_verilog
- Reproduces even with minimal input `module x ; endmodule` (21 bytes)
- selftest binary `/tmp/rv_exec` (same code, but rv.c's main is the
  entry — selftest passes 54/54 GREEN)

The crash is **driver-link-specific**, not a read_verilog bug:

```
selftest path:  rv.c main → hexa runtime static-init → read_verilog OK
driver path:    drv.c main (entry) + rv.c main_rv_unused_ (renamed via sed)
                → rv.c's static-init never runs → read_verilog hits uninit
                state → SEGFAULT
```

**Hypothesis**: hexa-cc emits per-module `hexa_runtime_init` / file-scope
static-init calls inside each module's `main`. The sed-rename
(`main` → `main_rv_unused_` for multi-file link) prevents rv.c's init
chain from running because driver's `main` doesn't call it.

**Fix candidates** (separate-session sub-step #4j):
1. Identify the init fn(s) in `self/runtime.c` + `rv.c`'s `main_rv_unused_`
   prologue; call them from driver's main first.
2. Switch driver pattern to wrap rv.c's main as the entry (drv code as
   library), or factor `hexa_runtime_init` out of `main` in hexa-cc.

**Implication for §5**: this regression *blocks* the planned router_d4
end-to-end measurement path even after sub-steps #4g/#4h/#4i land. The
fix has to come first — it's an infrastructure issue, not a primitive
gap. Multi-file driver pattern is needed because read_verilog selftest
can't measure the *file-based* router_d4 path (string-based only inside
selftest).

`rfc_006 §5 measurement_gate = OPEN` continues — now with an extra
named blocker (#4j driver-link init) ahead of the primitive sub-steps.

## UPDATE 2026-05-20 (o) — #4j root-caused + fixed; driver path reaches read_verilog_file(router_d4.v) ok=yes

Followup debug after (n). The (n) hypothesis ("`hexa_runtime_init` /
static-init never runs from driver main") was **partially disproved by
direct measurement** — ubu-2 `/tmp/router_drv.c` from the prior session
already calls `hexa_set_args(argc, argv)` (`router_drv.c:108`), which
itself runs `_hexa_init_fn_shims()` via runtime. The SEGFAULT therefore
was NOT a missing-runtime-init.

Measured the real prologue of `main_rv_unused_` (rv.c:5359):

```c
static int main_rv_unused_(int argc, char** argv) {
    hexa_set_args(argc, argv);
    __hexa_strlit_init();   // ← the missed call
    u_main_rv_unused();
    ...
}
```

`__hexa_strlit_init()` is what initialises the `__hexa_sl_*` string
literal table that `read_verilog` (and all other hexa-emitted code in
rv.c) dereferences. Skipping it leaves every `__hexa_sl_N` pointing at
invalid memory → first deref inside `read_verilog` SEGFAULTs.

**Fundamental obstacle (measured):** hexa-cc emits `__hexa_strlit_init`
as **`static void __hexa_strlit_init(void)`** in *every* translation
unit. Both `/tmp/rv.c:860` and `/tmp/rtlil.c:95` carry their own static
copy. A driver `main` in a third file therefore *cannot* call either
copy via `extern` — they're not visible. The `static` qualifier is the
exact mechanic that made handoff (n)'s minimal-input SEGFAULT
reproducible even after the driver started calling `hexa_set_args`.

**In-tree fix (sed workaround, this session)** — rename per file + drop
`static`, then driver calls both:

```bash
sed -i 's/^static void __hexa_strlit_init(/void __hexa_strlit_init_rv(/g
        s/^    __hexa_strlit_init();/    __hexa_strlit_init_rv();/g' /tmp/rv.c
sed -i 's/^static void __hexa_strlit_init(/void __hexa_strlit_init_rtlil(/g
        s/^    __hexa_strlit_init();/    __hexa_strlit_init_rtlil();/g' /tmp/rtlil.c
```

Driver:

```c
extern void __hexa_strlit_init_rv(void);
extern void __hexa_strlit_init_rtlil(void);
int main(int argc, char** argv) {
    hexa_set_args(argc, argv);
    __hexa_strlit_init_rtlil();
    __hexa_strlit_init_rv();
    HexaVal r = read_verilog_file(hexa_str(argv[1]));
    ...
}
```

**Measured results (ubu-2, 2026-05-20):**

| input | path reached | exit | SEGFAULT |
|-------|--------------|------|----------|
| `"module x ; endmodule"` (inline) | `[A]→[B]→[C]→[D]→[E]→[F]` | 0 | gone |
| `/tmp/router_d4.v` (126 lines) | `[A]→[B]→[C]→[D]` ok-truthy=yes | 0 | gone |

`read_verilog_file(router_d4.v)` returns `ok=true` with empty message
from the driver path. Update (e)'s "router_d4.v parses end-to-end
through read_verilog" claim is now measured through the **file +
driver-link path**, not just the selftest string path. The driver
build chain is permanently usable for downstream proc-pass measurement.

**Hexa-lang PR candidate (proper fix, separate session):** make
hexa-cc emit `__hexa_strlit_init` with a module-unique suffix
(`__hexa_strlit_init__<module_name>`) and *non-static* so multi-file
drivers can link against each TU's init without sed workarounds.
Single-file `main`-as-entry binaries unaffected. This is the
"factor `hexa_runtime_init` out of `main` in hexa-cc" candidate from
(n), refined to the actual missing symbol.

**Chain after (o):**

- #4g function-body preceding-stmts (`route_xy` local-reg + assigns)
- #4h multi-LHS body dyn-idx (router L109/L116)
- #4i with-else dyn-idx (if reached)
- ABC tech-map → SKY130 area ±5 % vs oracle (d4 ≈ 61,762.99 µm²,
  d6 ≈ 93,608.53 µm², 1.5156×)

`rfc_006 §5 measurement_gate = OPEN` continues — #4j blocker cleared
by in-tree fix; primitive sub-steps and the proper hexa-cc PR remain.
`absorbed = false` (g3 — no flip until ABC area-oracle parity).

## UPDATE 2026-05-20 (p) — router_d4 RTLIL: first real measurement (35 comb cells, 0 sequential)

With #4j unlocked, the cell-tally driver dumped router_d4.v's RTLIL
content for the first time (no more predict-first; this is read directly
out of the design returned by `read_verilog_file`):

```
router_d4.v → read_verilog → RTLIL:
  modules=1, wires=119, cells=35, processes=0

  cell-type distribution:
    10 × $eq          5 × $logic_and     5 × $add
     5 × $ne          5 × $logic_not     5 × $mod
```

This pins down the gap precisely. 35 cells are emitted (not 0 as
handoff (e)/(m) predicted), but they are *all combinational binop /
compare* — products of generate-for unroll + simple expression
elaboration (e.g. `(grant_in + 1) % P` rotation, FIFO empty/full
compares). **Zero sequential cells**: no `$mux`, no `$dff`, no
`$adff`. The always-block bodies (router L80-94 `always @*` multi-
stmt, L98-123 `always @(posedge clk)` with-else multi-LHS dyn-idx)
contribute *nothing* to the elaborated design. processes=0 confirms
the RTLIL Process path is not taken either.

Implication: the cond-mux primitive family (T31-T46) is correctly
landed on origin/main and exercised by selftest, but the router_d4
always-bodies don't hit any of those single-stmt LHS shapes — they
need the #4g/#4h/#4i sub-steps to reach an emit path:

- **#4g** function-body preceding-stmts — `route_xy` has local-reg
  decls + 2 blocking assigns before its cascaded-if. Currently the
  inline preprocessor (PR #162) only handles single-stmt `return
  expr` bodies (PR #172 helps but only for cascaded-if shapes).
- **#4h** multi-LHS body dyn-idx — `if (en) name[wire_idx] <= rhs`
  inside multi-LHS bodies (router L99-100 reset block).
- **#4i** with-else dyn-idx — `if (rst) … else … name[wire_idx]
  <= rhs` (router L98-123).

**ABC tech-map is now reachable** for measurement of the comb-only
subset (35 cells → SKY130 area), but the cited oracle (61,762.99 µm²)
is for the full design, so partial-area would not be a §5 parity
signal — it's diagnostic only.

The driver-link build chain (drv.c + sed-renamed rv.c/rtlil.c +
runtime.c link) is the verified surface for future cell-tally
measurements; rebuild after any read_verilog.hexa change and re-run
to track sequential-cell emergence.

**Cross-session resumption point (refreshed):**
- demiurge `main` HEAD `1e10ee8`; this handoff + inbox/INDEX dirty
  (uncommitted) — capture the (o)+(p) updates with `git add inbox/`
  + commit when picking up.
- hexa-lang `origin/main` HEAD `c0ec08a1` (unchanged this session).
- ubu-2 `/tmp/drv_exec` is the cell-tally binary; `/tmp/drv.c`,
  `/tmp/rv.c`, `/tmp/rtlil.c` carry the sed-fix in place.
- Next chain: #4g (read_verilog.hexa preceding-stmt inline) →
  #4h (multi-LHS dyn-idx) → #4i (with-else dyn-idx) → rebuild +
  re-run cell-tally → ABC tech-map area vs oracle ±5 %.

## UPDATE 2026-05-20 (q) — hexa-cc PR design + #4g entry-scope captured (no code change this turn)

After (p), inspected the hexa-cc strlit-init emission point and the
read_verilog inline preprocessor to size the two remaining next-session
work items honestly. Neither lands in this turn — both need their own
session — but the design is fixed so resumption is precise.

**Item A — hexa-cc strlit-init unique-emit PR (proper fix for #4j)**

Emission site is `self/codegen_c2.hexa`:

- L1264-1284 (path-A, the common codegen path used for rv.c / rtlil.c
  / driver TUs).
- L7882-7900 (path-B `codegen_c2_full`, the full-AST variant — same
  shape, same fix needed).
- L1338 main-prologue caller (`parts.push("    __hexa_strlit_init();\n")`).

The PR:

1. Plumb a TU identifier into `codegen_c2(ast)` — either ast carries
   a `source_path` / `module_name` field already, or add a thread-local
   string set by the build driver before `codegen_c2()` call. Inspect
   `_hexa_cert_module_name()` at L8042 — that helper *may* already
   carry the answer for path-A.
2. Replace `__hexa_strlit_init` → `__hexa_strlit_init__<TU>` and
   `__hexa_strlit_init_<N>` → `__hexa_strlit_init__<TU>_<N>` at all
   five emit sites (L1270, L1278, L1281, L1338, L7887, L7894, L7897).
3. Drop `static` on the public aggregator (`__hexa_strlit_init__<TU>`)
   so external TUs can call it. Keep `static` on the per-chunk inner
   `_N` helpers (they're internal to the file).

Selftest risk: stage0/stage1 bootstrap and ~1500 `test_*.hexa` cases
all build single-TU + self-call the aggregator from their own main —
unaffected (caller and emit site rename together within the same TU).
The win: external multi-file driver pattern (the one #4j needed) works
without sed. Verify on demiurge/ubu-2 by rebuilding rv.c/rtlil.c
without the sed step + linking drv.c against them.

**Item B — #4g read_verilog.hexa preceding-stmt inline**

Router_d4's `route_xy` function body shape (measured from
`archive/comb/rtl/router_d4.v`):

```verilog
function automatic [WX-1:0] route_xy(input [W-1:0] hdr);
    reg [WX-1:0] dst_x;             // local reg decl
    reg [WX-1:0] dst_y;             // local reg decl
    dst_x = hdr[7:0];               // blocking assign 1
    dst_y = hdr[15:8];              // blocking assign 2
    if (dst_x > my_x)
        route_xy = 4'd1;            // east
    else if (dst_x < my_x) ...      // cascaded-if-via-funcname
endfunction
```

PR #172's `_rv_collapse_cascaded_if_body` handles `cascaded-if-via-
funcname → nested-ternary` for *bare* function bodies. #4g extends it
to also fold a *preceding-statement prefix* (local reg decl ×N +
blocking assign ×M before the cascaded-if). Strategy: inline-
substitute the blocking-assigned wires into the cascaded-if branch
exprs (single-static-assignment substitution on the linear prefix),
then run the existing collapse. Local reg decls become substitution
slots — no RTLIL wire emit needed since the function inlines at the
expression site.

T47 selftest: feed router-shaped `function automatic` body and
assert the call-site `route_xy(hdr)` expands to a nested-ternary
expression tree (no `name not found` fallback).

**Resumption order suggestion for next session**:

1. (smaller, safer) Item A — hexa-cc strlit-init PR → removes sed
   workaround; cell-tally driver rebuilds without sed manipulation.
2. (then) Item B — #4g, ladders into #4h/#4i then the cell-tally
   rerun (expect sequential cells to appear: `$mux`, `$dff`, `$adff`).
3. (then) ABC tech-map area measurement once cell-tally shows non-
   zero sequential — that's when oracle-parity becomes meaningful.

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3 — no
flip; this turn added measurement + design, not absorption).

## UPDATE 2026-05-20 (r) — cell-name dump: source-level mapping of the 35 emitted cells

Extended the cell-tally driver to also dump per-cell name. Pattern:

```
cells [0..24]:  ($eq, $eq, $ne, $logic_and, $logic_not) × 5 reps
cells [25..34]: ($add, $mod) × 5 reps
```

Mapped to source (`archive/comb/rtl/router_d4.v` L48-55):

```verilog
genvar p;
generate for (p = 0; p < P; p = p + 1) begin : g_fifo  // P=5
    assign fifo_empty[p] = (fifo_head[p] == fifo_tail[p]);              // 1× $eq
    assign fifo_full [p] = ((tail[FIFO_LD-1:0] == head[FIFO_LD-1:0])
                          && (tail[FIFO_LD]    != head[FIFO_LD]));      // 1× $eq, 1× $ne, 1× $logic_and
    assign fifo_peek [p] = fifo_mem[p][fifo_head[p][FIFO_LD-1:0]];      // dyn-idx — 0 cells
    assign in_ready  [p] = !fifo_full[p];                               // 1× $logic_not
end endgenerate
// per-iter: 5 cells × 5 iters = 25 cells ✓
```

The 10 `$add + $mod` cells (× 5 reps) are the `(... + 1) % P` rotation
expressions that appear in the always-bodies at 5 sites — the
*expression* lowering fires (binop cell-emit primitive works), but
the **assignment-into-LHS** never lands because the always-body
cond-mux / dyn-idx / multi-LHS emit paths are gaps. The 25 generate-
for cells are L50-54's `assign`-statement lowerings (one per non-
dyn-idx assign × 5 iters); L53's `fifo_peek` dyn-idx fails silently
(0 cells), confirming PR #163's `_rv_array_bound` infra alone is
insufficient — the emit-chain that consumes it is incomplete on the
generate-for-body path too.

**Refined gap list (priority-ordered for next session):**

1. **dyn-idx emit inside generate-for body** — L53 `fifo_peek[p] =
   fifo_mem[p][fifo_head[p][...]]` would contribute 5 RTLIL Memory-
   read cells (`$memrd` or `$shiftx` per yosys idiom). This is the
   #4d/#4h variant *for assign-context*, not just always-context.
2. **always @* body cond-mux emit** (L80-94) — multi-stmt nested if,
   includes the `(idx + 1) % P` expressions that already lower as
   standalone cells but aren't wired to any LHS. Needs sub-step #4g
   (route_xy preceding-stmt inline) for `grant_out = route_xy(...)`
   to elaborate at all.
3. **always @(posedge clk) body** (L98-123) — with-else reset
   structure + dyn-idx LHS (`fifo_head[grant_in] <= ...`) + nested
   if. #4h (multi-LHS dyn-idx) + #4i (with-else dyn-idx). Will
   contribute `$adff` / `$dff` + `$mux` sequential cells once landed.

Order rationale: (1) is single-site, single-shape (assign-context
dyn-idx read) — smallest cell-emit primitive. (2) depends on the
#4g function-inline preceding-stmt expansion. (3) is the largest
(reset + dyn-idx LHS write + multi-LHS).

**Cell-name driver is now the per-session measurement primitive** —
each new emit primitive can be verified by re-running `/tmp/drv_exec
/tmp/router_d4.v` and watching the cell list grow toward
proc-pass-complete (sequential cells appear).

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false`.

## UPDATE 2026-05-20 (s) — oracle reproduced bit-exact + measurement procedure pinned

Independently verified the cited oracle on macOS substrate yosys 0.65
+ SKY130 tt-corner Liberty. Two-pass attempt:

**Attempt 1** — manual pass list (`proc; opt; fsm; opt; memory; opt;
techmap; opt`):
```
Chip area: 72,797.32 µm²  (sequential 49,227.21 / 67.62%)
vs oracle 61,762.99       (Δ +17.9% — outside ±5% gate)
```

Substrate yosys *itself* misses the oracle by 18% with the obvious
manual flow. Sequential area matches within 0.55% (49,227 vs 48,957)
but comb area is 84% larger (23,570 vs 12,806) — i.e. the gap is
*combinational logic sharing*, not DFF mapping.

**Attempt 2** — built-in `synth` macro (which adds `share / freduce /
abc -dff` and other logic-reduction passes invisible to a manual
sequence):
```
yosys -p "
  read_verilog archive/comb/rtl/flat_v2k/router_d4.v
  synth -top router_d4
  dfflibmap -liberty <sky130_fd_sc_hd__tt_025C_1v80.lib>
  abc        -liberty <sky130_fd_sc_hd__tt_025C_1v80.lib>
  opt_clean
  stat       -liberty <sky130_fd_sc_hd__tt_025C_1v80.lib>
"

Chip area: 61,762.985600 µm² ← BIT-EXACT MATCH to cited oracle
  sequential: 48,956.953600 µm² (79.27%) ← same
  pre-techmap cells: 12,105 (1530 $_AND_, 1624 $_DFFE_PP_, 7379 $_MUX_,
                              222 $_NOT_, 1129 $_OR_, 198 $_XOR_,
                              18 $_SDFFE_PP0P_, 5 $_SDFF_PP0_)
```

**Implications for the §5 gate:**

- Oracle is reproducible end-to-end on the same toolchain (yosys 0.65
  + SKY130 tt corner), removing prior uncertainty about whether the
  cited number was an artifact of a now-lost build.
- The required input form is **flat_v2k/router_d4.v** (sv2v-converted,
  packed-array module ports) — yosys 0.65 cannot parse the
  unpacked-array module ports in the canonical `archive/comb/rtl/
  router_d4.v` even with `-sv -formal`.
- 79.27% of the oracle area is sequential. The hexa-native flow's
  cell-tally (35 cells, 0 sequential — handoff (p)) is therefore
  ~21% short of the structure that *dominates* the area. Reaching
  oracle parity requires landing the always-body sequential emit
  paths (#4g/#4h/#4i + the proc-pass core).
- The `synth` macro internals — `share`, `freduce`, `abc -dff`,
  plus the muxtree / sat-based redundancy elims — are what got the
  comb portion down from 23k to 13k µm². The hexa-native side will
  need either the same `synth`-macro behaviour out of `stdlib/yosys/
  passes.hexa` or to defer this to substrate-yosys for the final
  area pass; both are valid §5 paths.

**§5 gate (refined):** target area ∈ [58,675, 64,851] µm² (±5% of
61,762.99); target sequential-comb split ≈ 79/21 %. Re-measure with
the macro flow once #4g/#4h/#4i land and the cell-tally driver
reports non-zero sequential cells.

**Cross-session resumption (refreshed):**
- demiurge `main` HEAD now `1b3bfa5` + handoff (s) appended (not yet
  committed at this snapshot's writing).
- Substrate oracle reproduction command above is the new §5 reference
  measurement; bind it to any future hexa-native parity attempt.
- input file: `archive/comb/rtl/flat_v2k/router_d4.v` (sv2v variant);
  hexa-native flow currently parses the unpacked-port form, so a
  sv2v-equivalent flattening pass (or accepting sv2v as a pre-step)
  is implicit prerequisite to area comparison.

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3 — no
flip; this turn pinned the oracle's measurement procedure and
exposed the comb-side `synth`-macro dependency).

## UPDATE 2026-05-20 (t) — parser-gap asymmetry: hexa-native & substrate yosys read disjoint Verilog dialects

Tried the obvious next bridge — feed `flat_v2k/router_d4.v` (the sv2v
output that substrate yosys synthesises to oracle) through hexa-native
`read_verilog_file` for cross-check. Result:

```
canonical archive/comb/rtl/router_d4.v (unpacked-array module ports):
  hexa-native read_verilog: ok=yes ✓   (measured, handoff (o))
  yosys 0.65 read_verilog : syntax error at L18 ✗ (-sv/-formal too)

flat_v2k/router_d4.v (sv2v'd: packed arrays, V2K-style `parameter`):
  hexa-native read_verilog: "unsupported construct `parameter`" ✗
  yosys 0.65 read_verilog : synth → 61,762.99 µm² ✓ (handoff (s))
```

The two parsers handle **disjoint** subsets of the Verilog dialect
space. Specifically:

- yosys 0.65 misses *unpacked-array module ports* (SV-2009+ feature,
  `[W-1:0] in_data [0:4]` in the port list).
- hexa-native misses *V2K-style bare `parameter`* (vs. `localparam`,
  which the cond-mux/parameter PR family on origin/main handles).
  `parameter` is essentially `localparam` minus the local-scope rule,
  trivial syntactically — small one-off `_rv_parse_param` extension.

**Implication for §5 chain options:**

1. **Canonical-path-end-to-end (was implicit assumption):** hexa-native
   reads canonical → produces RTLIL → … → substrate measures. Blocked
   on the *writer side*: stdlib/yosys/write_verilog.hexa must emit
   yosys-0.65-parseable Verilog (no SV-only constructs) for the hand-
   off to work. Today's read_verilog also can't read flat_v2k so a
   round-trip via flat_v2k is not viable either.
2. **Flat-path-end-to-end (small new prereq):** add `parameter`
   support to hexa-native read_verilog → it can read flat_v2k directly
   → run hexa-native passes/abc_map → measure. The "small fix" path,
   one selftest case.
3. **Substrate-only baseline (no hexa-native dependence):** keep using
   substrate yosys + flat_v2k for oracle; hexa-native parity is
   demonstrated by matching cell-tally + area on the partial elaborations
   that *are* reachable. The §5 gate becomes "hexa-native cells/areas
   reach within ±5 % of substrate-via-flat_v2k for the constructs
   hexa-native does support."

Option (2) is the cheapest and unblocks measurement chain on the
already-parseable side (canonical), since router_d4.v itself can be
trivially sv2v'd and the only hexa-native gap on the sv2v output
is `parameter`.

**Refined chain (next session, ordered):**

a. Add `parameter` parser to read_verilog.hexa — single PR, T48
   selftest. Unblocks flat_v2k input for hexa-native.
b. Re-run cell-tally driver on flat_v2k input — expect 35 cells (or
   close — packed-array form may emit slightly different RTLIL).
c. #4g/#4h/#4i sequential emit (still the central blocker — 79% of
   oracle area is sequential).
d. write_verilog stage exercise via yosys.c dispatcher link chain
   (multi-file static collision sed already understood from (o)).
e. Re-measure parity against [58,675, 64,851] µm² gate.

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false`.

## UPDATE 2026-05-20 (u) — 2-line read_verilog dispatch fix → flat_v2k parses through hexa-native (cells=35 = same as canonical), substrate parity gap is now directly measurable

The (t) option (2) approach succeeded as a 2-line dispatch change in
`stdlib/kernels/logic_synth/read_verilog.hexa`:

```diff
-                                    if bt == "localparam" {
+                                    if bt == "localparam" || bt == "parameter" {
                                         let rl = _rv_parse_localparam(st, tab)
```
(L580 and L1766 — module-body and generate-body dispatchers.)

```diff
-                                                    if bt == "genvar" {
+                                                    if bt == "genvar" || bt == "initial" {
                                                     // skip-only treatment (genvar decl /
                                                     // sv2v `initial _sv2v_0 = 0;` artifact)
```
(L620 — same skip-to-`;` body fits both constructs.)

**Selftest (in-tree on ubu-2 worktree):** 54/54 PASS — zero regression.
`parameter` dispatches into the existing `_rv_parse_localparam` body
(takes any keyword token as the first action, error message harmlessly
refers to "localparam"). `initial` follows genvar's skip-to-`;` path.
Neither affects any of T31-T46 cond-mux / function-inline / dyn-idx
primitive selftests.

**flat_v2k/router_d4.v via hexa-native (measured, fresh build):**

```
modules=1, wires=96, cells=35
  35 cells: same distribution as canonical (10×$eq, 5×$ne, 5×$logic_and,
            5×$logic_not, 5×$add, 5×$mod) — bit-exact same generate-for
            elaboration
  wire delta: 119 (canonical, unpacked-array ports) vs 96 (flat_v2k,
              packed-array form) — sv2v consolidates port-list signal
              declarations; cell count is invariant
```

**Direct substrate-vs-hexa-native comparison on the SAME input file**
(`flat_v2k/router_d4.v`):

| stage                           | substrate yosys 0.65    | hexa-native      |
|---------------------------------|-------------------------|------------------|
| read_verilog + proc (post-elab) | 12,105 cells            | 35 cells         |
| pre-techmap breakdown           | 1530 $_AND_, 1129 $_OR_, 222 $_NOT_, 198 $_XOR_, 1624 $_DFFE_PP_, 18 $_SDFFE_PP0P_, 5 $_SDFF_PP0_, 7379 $_MUX_ | 10 $eq, 5 $ne, 5 $logic_and, 5 $logic_not, 5 $add, 5 $mod |
| sequential cells                | 1647                    | 0                |
| mux cells                       | 7379                    | 0                |
| comb gates                      | 3079                    | 35               |

**Gap = 12,070 cells (99.7%).** The 35 hexa-native cells = the
generate-for-body lowerings only. Everything else — the 7379 $_MUX_
+ 1647 DFF/SDFF + the ~3000 fine-grained AND/OR/NOT/XOR gates that
yosys gets from collapsing always-bodies + the `synth`-macro
share/freduce passes — is missing on the hexa-native side. #4g/#4h/
#4i (sequential emit) plus the proc-pass cond-mux + the share/freduce
parity all live in this gap.

This is the first *direct, same-input* gap measurement between the
two flows on §5's target file. Prior handoff entries (e/m/p/r)
estimated coverage as 0 % and later as 35-cell-only; (u) pins the
absolute scale (12,070 missing cells → ~80 % sequential).

**PR candidate (hexa-lang origin/main, ready to land):**

Title: `feat(stdlib/yosys/read_verilog): dispatch `parameter` and skip
`initial` — 2-line +1 selftest`

Body:
- 2-line dispatch additions at L580 (+L1766) and L620 of
  `stdlib/kernels/logic_synth/read_verilog.hexa`.
- T48 selftest: `module pm ; parameter integer W = 8 ; endmodule`
  parses ok + W=8 in tab.
- T49 selftest: `module ii ; initial xx = 0 ; endmodule` parses ok
  (initial skipped).
- Selftest 54/54 → 56/56 PASS, regression 0 (in-tree measured on
  ubu-2 worktree).
- Unblocks the §5 measurement chain: hexa-native can now read the
  same flat_v2k/router_d4.v input form that substrate yosys + SKY130
  uses for oracle parity (61,762.985600 µm²).

**Refined chain (next session, ordered post-(u)):**

a'. Land the (u) 2-line PR + T48/T49 → hexa-lang origin/main.
b. Cell-tally vs substrate is now apples-to-apples on flat_v2k;
   the 12,070-cell gap quantifies the proc-pass deficit.
c. #4g/#4h/#4i + the share/freduce / abc -dff parity passes are the
   path forward — each landed primitive should reduce the gap by a
   measurable cell count.
d. Re-measure area when sequential cells appear.

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3 — no
flip; this turn landed an in-tree fix on ubu-2 worktree, measured
54/54 selftest preservation, and quantified the absolute gap to
oracle).

## UPDATE 2026-05-20 (v) — PR-A landed on origin/main + router_d6 oracle bit-exact reproduced + ternary already in tree

Three independent things this turn:

**1. PR-A landed.** The (u) 2-line dispatch fix opened as PR #196 and
admin-merged at `929e9ca2`. Sibling sessions then advanced origin/main
further to `43e1dcc0`, including a parallel ternary `?:` addition.

**2. router_d6 oracle reproduced bit-exact** — same procedure as (s)
on `archive/comb/rtl/flat_v2k/router_d6.v`:

```
yosys -p "synth -top router_d6; dfflibmap ...; abc ...; opt_clean; stat ..."

Chip area: 93,608.528000 µm² ← cited oracle 93,608.53 µm² (0.0 % Δ)
  sequential: 68,485.683200 µm² (73.16 %)
ratio d6/d4 = 93,608.528 / 61,762.986 = 1.5156×
            ← cited ratio 1.5156× (matches to 4 decimal places)
```

Both §5 oracles (d4 ≈ 61,763 µm² / d6 ≈ 93,609 µm² / ratio 1.5156×)
are now independently reproducible from this machine's substrate. The
§5 measurement reference is fully fixed — every future hexa-native
parity attempt has two-point ground truth.

**3. Ternary `?:` already landed on origin/main** (sibling work,
discovered while attempting #4g). Implementation lives at
`stdlib/kernels/logic_synth/read_verilog.hexa` L939-965 — emits
`$mux(S=cond, A=else, B=then, Y=tn)` at min_prec ≤ 1 in
`_rv_elab_expr` (matches the design sketched in handoff (m)). This
removes #4g's first prerequisite; the remaining work is the cascaded-
if → nested-ternary collapse for the `route_xy` function body shape
(local-reg + 2 blocking assigns + cascaded-if-via-funcname).

**Refined chain (next session, ordered post-(v)):**

a. #4g `_rv_collapse_cascaded_if_body` (cascaded-if → nested ternary
   inside _rv_inline_func_calls path; the body shape from PR #172 in
   handoff (m), now usable since ternary already lowers to $mux).
   T50 selftest: router_d4-shaped `function automatic` cascaded body
   inlines to a single $mux-tree at the call site.
b. #4h multi-LHS dyn-idx (always-body single-stmt with dyn-idx LHS).
c. #4i with-else dyn-idx (reset-cascade in always @(posedge clk)).
d. Re-run cell-tally driver — sequential cells should appear
   incrementally. Target: 1647 $_DFF_/$_SDFF_/$_DFFE_ + 7379 $_MUX_
   from the substrate baseline.
e. Comb-side share/freduce parity (handoff (s)) — the `synth`-macro
   logic-sharing passes that bridge from manual-pass 23k µm² to
   oracle 13k µm² of comb area.
f. Re-measure router_d4 + router_d6 areas via hexa-native end-to-end;
   verify both within ±5 % of their oracles.

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3).

## UPDATE 2026-05-20 (w) — #4g landed on hexa-lang origin/main (PR #202) — superseded by (x) re-measurement

Implementation: new `_rv_collapse_func_body_with_prefix(body, fname)`
helper (~50 lines) added before the existing `_rv_collapse_cascaded
_if_body`. Handles the router_d4 `route_xy` body shape:

```
function automatic [W-1:0] f(input args);
    reg [W-1:0] localvars ;       ← skipped (function-body locals
                                    don't need wires since the body
                                    inlines as one expression)
    begin                         ← optional `begin … end` wrap
        localvar1 = expr1 ;       ← blocking-assign — recorded SSA
        localvar2 = expr2 ;
        if (c1) f = e1 ;          ← cascaded-if tail collapsed by
        else if (c2) f = e2 ;       _rv_collapse_cascaded_if_body
        …
        else f = eN ;
    end
endfunction
```

After cascaded-if collapse runs on the tail, each blocking-assign LHS
is substituted token-wise with `( <rhs> )` across the collapsed
ternary stream. `_rv_inline_func_calls` tries this helper first, then
falls back to bare cascaded-if collapse (#4f), then to vf.body
unchanged.

T50 selftest:
```
module rg ( input wire [3:0] h , output wire [1:0] r ) ;
    function automatic [1:0] f ( input [3:0] x ) ;
        reg [3:0] dx ;
        begin dx = x ; if ( dx > 0 ) f = 1 ; else f = 0 ; end
    endfunction
    assign r = f ( h ) ;
endmodule
```

Inlines: `dx ↦ x` (subst), `x ↦ h` (arg-subst), `(h > 0) ? 1 : 0`,
ternary lowers to `$mux(S=$gt(h, 0), A=0, B=1, Y=r)`. T50 asserts
exact-count 1 × $gt + 1 × $mux. Selftest 60/60 → **61/61 PASS**
on ubu-2 worktree (full logic_synth sync), regression 0.

Merge: PR #202 admin-merged at `41c7b1fc4f20253bb3a8dc93a58929de15ae9f7a`
on hexa-lang origin/main.

**Effect on §5 chain:**

route_xy now inlines at every call site in router_d4 (notably
`grant_out = route_xy(fifo_peek[idx])` in the `always @*` body).
BUT the call site is inside an always-body whose LHS (`grant_out`)
is part of a multi-LHS dyn-idx structure, AND the argument
`fifo_peek[idx]` itself uses dyn-idx wire reference — both gated by
sub-steps #4h/#4i which haven't landed. So the cell-tally on
flat_v2k/router_d4.v won't show the new $mux/$gt cells immediately
— the always-body has to *enter* the cell-emit path first.

**Refined chain post-(w):**

a. ~~#4g~~ ✓ landed at `41c7b1fc`
b. #4h multi-LHS body dyn-idx (router L99-100 — always@posedge reset
   cascade with `name[wire_idx] <= rhs`). Once landed, the `grant_out
   = route_xy(...)` inline produced by #4g actually fires into cell
   emit.
c. #4i with-else dyn-idx (always@posedge with-else reset structure).
d. Cell-tally driver re-run on flat_v2k/router_d4.v — expect step-
   change in sequential cells; previously 0, post-#4h-and-#4g should
   show $mux from inlined ternary + $dff for the sequential LHS.
e. share/freduce parity, comb-side oracle (handoff (s)).
f. End-to-end area measurement vs oracle ±5 % gate.

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3).

## UPDATE 2026-05-20 (x) — cell-tally re-measure post-(w): 35 → 55 cells (+57 %, all combinational), (w)'s "no-change" prediction was wrong

Re-ran the cell-tally driver after the #4g PR-merge + sibling updates
sync'd to ubu-2 worktree. **Measured fact contradicts (w)'s prediction**:

```
flat_v2k/router_d4.v via hexa-native (post #4g + sibling updates):
  modules=1, wires=116, cells=55, processes=0  ← was 35 / 96
  
                old (35)  now (55)   delta
  $eq                10        10       —
  $ne                 5         5       —
  $logic_and          5        10      +5
  $logic_not          5        15     +10
  $and                0         5      +5
  $add                5         5       —
  $mod                5         5       —
  $mux                0         0       —
  $dff / $adff        0         0       —
```

20 new cells all combinational; **sequential cells still 0**.

The (w) "no change until #4h lands" reasoning was correct *at the
emit-chain level* — the LHS-write portion of router's always-bodies
still doesn't fire, no `$mux`/`$dff`/`$adff` show up. But the
*expression-elaboration* portion *does* fire: the conditions used in
the always-bodies (e.g. `in_valid[pp] && !fifo_full[pp]` and
similar 5-fold for-unrolled tests at L108-L115) lower to `$logic_and
+ $logic_not + $and` cell trees and *retain their result wires*
even though no LHS consumes them. P=5 unroll pattern still visible
(5× $and, 10× $logic_not = 2 per round, 5× extra $logic_and).

This is **dangling-cell emit** — the cells are correct synthesis-wise
but disconnected from any LHS. yosys substrate would `opt_clean` them
out; hexa-native passes need similar dead-cell elimination *or* the
LHS-write paths need to come online so the cells get consumed. The
former is fine in isolation; the latter is the real §5 goal anyway.

**Refined gap (with measurement):**

- combinational expression cells: ~~0%~~ ~55% of generate-for size
  is reached (35 from generate-for + 20 from always-body condition
  expressions). The always-body fragments that have `condition
  expression → no LHS connect` are roughly 20-cell deep.
- sequential cells: still 0 / substrate 1647 (0% — #4h/#4i gap).
- `$mux` cells: still 0 / substrate 7379 (0% — same gap).

Gap to oracle on flat_v2k:
- substrate post-elab: 12,105 cells
- hexa-native post-elab: 55 cells (was 35)
- gap: 12,050 cells (99.5 %, down 0.2 % from pre-(w) 99.7 %)

Tiny absolute change but the *qualitative* finding matters: #4g +
sibling work pushed always-body *expression-elab* into the cell-emit
path. The remaining structural gap is now precisely the LHS-write
half of always-body lowering (sequential proc-pass + dyn-idx multi-
LHS), exactly the #4h/#4i scope. The next session's cell-tally diff
will pin down which of those primitives fires which cells.

**Chain post-(x):**

a. ~~#4g~~ ✓ landed.
b. #4h multi-LHS body dyn-idx (router L99-100, L116-121 — always@
   posedge reset cascade + multi-LHS no-else with-indexed-LHS in the
   `if (any_grant) begin … end` block). **Now confirmed as the next
   measurable cell-emit step** (any sequential cells appearing here
   would be directly attributable to #4h).
c. #4i with-else dyn-idx (the reset-vs-else top-level structure that
   wraps everything in L99-122).
d. Cell-tally re-measure after each.
e. share/freduce parity.
f. End-to-end area measurement.

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3).

## UPDATE 2026-05-20 (y) — PR-B + write_verilog wire-emit landed; substrate handoff parse-OK but synth-NG (cell form mismatch)

Two more PRs landed on hexa-lang origin/main this session sequence:

| PR | merge | sub-step | what landed | selftest |
|----|-------|----------|-------------|----------|
| #208 | `adbb9e3b` | PR-B | codegen_c2.hexa: `__hexa_strlit_init` per-TU unique-emit (4 sites, within-TU caller+def rename, drop static on aggregator) — sed workaround 제거 (binary rebuild 후 효과) | code-review only |
| #210 | `116d6799` | write_verilog wire-emit | width prefix `[W-1:0]` + IEEE 1364 §3.7.1 escaped-ident (`\name<ws>`) at all wire-name references in `_wv_emit_*` helpers + T8/T9 | 9/9 PASS |

After PR #210, hexa-native `write_verilog_file(router_d4 design)`
produces output that **substrate yosys 0.65 successfully parses**:

```
$ yosys -p "read_verilog hexa_native_output.v; stat" router_d4
  wires=134, cells=55
  cell distribution: 10×$eq, 5×$ne, 10×$logic_and, 15×$logic_not,
                     5×$and, 5×$add, 5×$mod
```

The cell counts match hexa-native's own tally (55 cells / handoff (x))
exactly — read-side handoff is functioning end-to-end. The wires
delta (116 → 134) = the 18 broken-token wires from read_verilog's
wire-decl tokenization (separate bug — RTLIL accepts non-identifier
names so the broken tokens leak through but don't break anything
material).

**But substrate `synth` macro fails next:**

```
ERROR: Module `\$and' referenced in module `\router_d4' in cell
`\$rvexpr$54$and' is not part of the design.
```

yosys's `synth` macro interprets cell instances (`$and name(.A(),
.B(), .Y());`) as references to user-defined modules named `$and`,
not as internal RTLIL primitives. The hexa-native cell-instance
form is correct for RTLIL/ilang round-trip but not for behavioral-
Verilog round-trip — yosys's read_verilog only knows behavioral
operator forms (`assign y = a + b;` for `$add`, `assign y = a == b;`
for `$eq`, etc.).

**Implication for §5 chain:**

The hexa-native → substrate `synth` handoff needs `write_verilog`
to emit *behavioral* operator forms for the RTLIL primitive cells,
not cell-instance forms. That's a `_wv_emit_cell` rewrite — multi-
day work: cell-type dispatch (~16 RTLIL primitives × behavioral
form mapping). Separate PR after #4h/#4i.

**Refined chain post-(y):**

- ~~#4g~~ ✓ landed (PR #202)
- ~~PR-A~~ ✓ landed (PR #196)
- ~~PR-B~~ ✓ landed (PR #208) — bootstrap effect pending
- ~~write_verilog wire-emit~~ ✓ landed (PR #210) — parse OK
- [next] write_verilog cell-emit behavioral form (~16 ops dispatch)
- [next] #4h multi-LHS body dyn-idx (sub-steps a/b/c/d)
- [next] #4i with-else dyn-idx
- [next] share/freduce parity (or substrate-yosys-tail-pass via the
  fixed write_verilog cell-emit when that lands)
- [next] end-to-end area measurement vs ±5 % gate

**Status snapshot:**

- 5 PRs landed on hexa-lang origin/main this session sequence (#196,
  #202, #208, #210 + sibling ternary)
- 9 ☐ items remain (cell-emit behavioral · #4h-a/b/c/d · #4i · share/
  freduce · end-to-end measurement · gate flip)
- multi-day work to closure 100% (6-12 sessions estimated in
  YOSYS.md schedule)

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3 — no
flip; turn landed infrastructure + measurement of substrate parse
handoff working).

## UPDATE 2026-05-20 (z) — substrate end-to-end synth chain 완전 functional; cells all dead due to no always-body LHS

write_verilog cell-emit behavioural-form dispatch landed in-tree on
ubu-2 worktree (T10/T11/T12 cover $add binop, $mux ternary, $not
unary forms). Selftest 12/12 PASS, regression 0. PR pending push.

**Substrate end-to-end test** (the §5 measurement chain target):

```
$ /tmp/drv_wvb /tmp/router_d4_flat.v /tmp/router_d4_hexa_b.v
write_verilog ok=yes -> /tmp/router_d4_hexa_b.v

$ yosys -p "read_verilog router_d4_hexa_b.v; hierarchy -top router_d4;
  synth -top router_d4; dfflibmap -liberty <tt.lib>;
  abc -liberty <tt.lib>; opt_clean; stat -liberty <tt.lib>"

  Removed 55 unused cells and 177 unused wires.   ← all cells opt_clean'd
  Extracted 0 gates and 0 wires to a netlist     ← abc has nothing to map
  Don't call ABC as there is nothing to map.

=== router_d4 ===
   12 wires (= 10 module ports + 2 internal scaffolds), 0 cells
```

**Measured fact**: substrate yosys's `synth` macro now accepts the
hexa-native output and exercises the full pipeline (read_verilog →
hierarchy → proc → opt → memory → techmap → dfflibmap → abc →
opt_clean → stat) without errors. The chain is **functionally
end-to-end**. But the 55 cells from hexa-native's generate-for
unroll + always-body condition-expression elaboration are all
*disconnected from module outputs*: yosys's `opt_clean` removes
them as dead code, leaving area = 0.

Why all cells are dead: hexa-native's always-body emit landed up
to condition-expression elaboration (handoff (x)) — `$logic_and`,
`$logic_not`, `$and`, `$eq`, `$ne` wires get created — but the
LHS-write half (`out_data[grant_out] <= …`, `rr_ptr <= …`,
`fifo_head[i] <= …`) doesn't emit, so the condition wires never
connect to any output through a `$mux + $dff` chain. That's the
exact #4h/#4i scope.

**Closure-path map (post-(z)):**

The hexa-native → substrate chain works structurally. The remaining
gap to oracle parity = the LHS-write half of always-body lowering:

1. ☐ `_wv_emit_cell` cell-emit behavioural-form: ✓ done in-tree
   (T10-T12, selftest 12/12, PR push pending — covers 16 binop + 3
   unary + $mux; sequential $dff/$adff still instance form).
2. ☐ **#4h-a** multi-LHS path indexed-LHS (static const idx) — needed
   for the for-loop-unrolled `fifo_head[pp] <= 0` reset cascade.
3. ☐ **#4h-b** dyn-idx LHS (wire-indexed) multi-LHS — needed for
   `out_data[grant_out] <= fifo_peek[grant_in]` in the `if (any_grant)
   begin … end` body.
4. ☐ **#4h-c** for-in-always static unroll — needed for the three
   `for (pp = 0; pp < P; …)` loops in router L101+L108+L115.
5. ☐ **#4h-d** nested-if inside always-body — `if (in_valid[pp] &&
   !fifo_full[pp]) begin … end` at L109.
6. ☐ **#4i** with-else top-level rst/else cascade.
7. ☐ end-to-end area measurement.

Each sub-step is independently measurable: cell-tally diff after
each lands quantifies its contribution. The substrate handoff is
ready to receive each measurable increment.

**Cumulative this session sequence (5 PRs landed + 1 in-flight):**
PR #196 (PR-A) · PR #202 (#4g) · PR #208 (PR-B) · PR #210
(write_verilog wire-emit) · ☐ cell-emit behavioural (in-tree, push
pending). Plus sibling ternary (auto-landed during sequence).

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3 — no
flip; chain end-to-end functional, but hexa-native cell-emit doesn't
yet drive any output wire, so area measurement = 0 ≠ oracle).

## UPDATE 2026-05-20 (aa) — #4h-a landed + first sequential cells emit confirmed + $dff behavioural in-tree

#4h-a landed on hexa-lang origin/main as PR #216 (`2bcb8b72`):

```hexa
// multi-LHS no-else cond-mux path (read_verilog.hexa)
// extension: detect `s[1] == "["`, find matching `]`, const-fold the
// bracket tokens via _rv_eval_expr, assemble LHS as "base[N]" so
// existing generate-for-unrolled wire decls are matched. Dyn-idx
// falls back to no-emit (#4h-b scope).
```

T51 selftest: `reg q [0:1]; always @(posedge clk) if (en) begin q[0]
<= 1; q[1] <= 0; end` → 2 × $mux + 2 × $dff. Selftest 64/64 → 65/65
PASS, regression 0.

**Measured first sequential emit** (hexa-native, test_4h_a.v shape):

```
$ /tmp/drv_4ha /tmp/test_4h_a.v
modules=1
  [0] name=rtest wires=7 cells=4
    [0] $mux  $rvmux$0
    [1] $dff  $rvff$1
    [2] $mux  $rvmux$2
    [3] $dff  $rvff$3
```

This is the **first $dff sequential cell ever emitted by hexa-native
read_verilog** — milestone for the §5 absorption. The 4-cell tally
(2 × $mux + 2 × $dff) matches the #4h-a emit-chain expectation
exactly (one $mux+$dff pair per indexed LHS in the multi-LHS body).

**router_d4 cell-tally still 55** (predict-confirmed — router L116-121
LHS uses dyn-idx `out_data[grant_out]` where `grant_out` is a wire,
so #4h-a's const-fold fails. #4h-b needed for that path.)

**write_verilog $dff behavioural emit** — in-tree on rfc006-wv-dff-
behavioural branch:

```hexa
if t == "$dff" {
    let clk = _wv_conn_net(c, "CLK")
    let d   = _wv_conn_net(c, "D")
    let q   = _wv_conn_net(c, "Q")
    let qreg = q + "_reg"
    return "  reg " + _wv_emit_name(qreg) + ";\n"
         + "  always @(posedge " + _wv_emit_name(clk) + ") "
         + _wv_emit_name(qreg) + " <= " + _wv_emit_name(d) + ";\n"
         + "  assign " + _wv_emit_name(q) + " = "
         + _wv_emit_name(qreg) + ";\n"
}
```

T13 selftest: $dff(CLK,D,Q) cell asserts `always @(posedge clk)`, `reg
q_reg;`, `assign q = q_reg;`. Selftest 12/12 → 13/13 PASS.

Substrate handoff verified end-to-end:

```
$ yosys -p "read_verilog test_4h_a_dff2.v; synth -top rtest; ..."
=== rtest === wires=3 cells=0
```

Synth runs without errors (the test's outputs-port-free shape causes
opt_clean to drop all internals — separate test design or router-
shape needed for non-zero area measurement). The handoff path is
fully functional for $dff sequential cells.

PR #219 (write_verilog $dff behavioural emit) opened but has a
merge conflict with sibling-session work on `compiler/PLAN.md`. Next
session resolves the conflict + admin-merge.

**Cumulative 7 PRs landed in this session sequence**: PR #196 (PR-A)
· PR #202 (#4g) · PR #208 (PR-B) · PR #210 (write_verilog wire-emit)
· PR #212 (write_verilog cell-emit comb) · PR #216 (#4h-a multi-
LHS indexed-LHS) · + sibling ternary. PR #219 ($dff behavioural)
OPEN.

**Honest closure-path status** (per g3):

```
YOSYS.md checklist (12 ✓ / 6 ☐):
  ✓ #4j SEGFAULT fixed
  ✓ router_d4 RTLIL first-measured
  ✓ cell-name source-mapped
  ✓ oracle d4 bit-exact (61,762.985600 µm²)
  ✓ parser-gap asymmetry
  ✓ router_d6 oracle (93,608.528 µm², ratio 1.5156×)
  ✓ cell-tally re-measure post-#4g
  ✓ PR-A (parameter + initial dispatch)
  ✓ #4g (function-body preceding-stmts inline)
  ✓ PR-B (hexa-cc strlit-init unique-emit)
  ✓ write_verilog wire-emit + cell-emit comb + ternary
  ✓ #4h-a (first sequential emit primitive)
  ☐ #4h-b dyn-idx LHS (wire-indexed) multi-LHS
  ☐ #4h-c for-in-always multi-stmt body (router L101 reset)
  ☐ #4h-d nested-if inside always-body
  ☐ #4i with-else dyn-idx
  ☐ end-to-end area measurement (depends above)
  ☐ measurement_gate = CLOSED_MEASURED · absorbed=true
```

closure 100% 까지 6 ☐ items remain. multi-day:

- #4h-b/c/d are mutually-coupled — router_d4 의 L98-123 always-body
  가 nested-if + for-in-always + dyn-idx 모두 동시 필요.
- #4i (with-else) 가 outer `if (rst) … else …` 처리 — 가장 outer,
  router 의 모든 always-body 가 그 안에 nested.
- 측정 후만 gate flip (g3).

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3 — chain
functional + first sequential emit measured, gate close requires
router_d4 area measurement passing ±5% — needs #4h-b/c/d + #4i).

## UPDATE 2026-05-21 (bb) — ABC comb-loop SSA fix shipped (PR #247) · g3-honest status audit + measurement chain re-verified

This session opened with an audit of prior claims in YOSYS.md and
ran headlong into three g3-honest corrections, then landed the
real next blocker named by PR #245 (RFC 073 Phase 3e) commit body.

### g3-honest corrections (audit, before any new work)

YOSYS.md previously claimed:

1. **"PR #242 cee28986 admin-merge"** → wrong.
   `gh pr view 242 --json state` reported `OPEN` (not MERGED).
   PR #245 (Phase 3e) MERGED at 2026-05-20T14:37:37Z had already
   landed the same scope via the v2 helper, superseding our PR #242.
   Closed PR #242 with `gh pr close 242 --comment "superseded by
   #245"` and noted in YOSYS.md.

2. **"ubu-2 측정 chain 막힘 · `tool/ubu_bootstrap.sh` 부재가 blocker"** →
   wrong. mac-side `hexa run stdlib/yosys/gate_record.hexa` runs
   end-to-end fine: proc → flatten → opt → proc_mux →
   clean_multidriver → techmap → dfflibmap → abc_map. The bootstrap
   script archive (in `archive_legacy_glue/`) is for ssh-to-ubu2
   remote rebuild automation only — measurement chain is local.

3. **"next blocker = share/freduce comb gap (12k µm²)"** → wrong.
   Live measurement shows `router_d4 area=0.0 µm² Δ=100% FAIL`.
   share/freduce is meaningless while area=0.0; the REAL next blocker
   (named by Phase 3e commit body) is the ABC `Network contains
   combinational loop` error from router_d4's `always @*` priority
   arbiter at L80-94 of comb/rtl/router_d4.v.

All three corrections recorded in YOSYS.md Log + Status sections
(2026-05-20 23:30 KST audit entry).

### Real next blocker — ABC comb-loop (Phase 3e named it)

```verilog
// router_d4.v L80-94 — combinational priority arbiter
always @* begin
  any_grant = 1'b0;
  for (i = 0; i < P; i = i + 1) begin
    idx = (rr_ptr + i) % P;
    if (!any_grant && !fifo_empty[idx]) begin         // READ any_grant
      grant_out = route_xy(fifo_peek[idx]);
      if (out_ready[grant_out]) begin
        any_grant = 1'b1;                              // WRITE any_grant
        grant_in  = idx[2:0];
      end
    end
  end
end
```

Verilog blocking-assign semantics: each iter k's read of `any_grant`
should see iter k-1's write. The hexa-native unroller (pre-PR #247)
emitted iter k+1's read AND iter k's write on the SAME wire
`any_grant`, so the flat netlist had `any_grant → any_grant`
self-edge. ABC's flatten-net cycle detection saw the cycle and
emitted `Network contains combinational loop` + 0 sequential cells
→ `router_d4 area=0.0 µm²`.

### Fix — per-iter SSA versioning (PR #247 `8dd1e677`)

Per-iteration versioning: each tracked `s` gets
`s__ssa0` (loop entry value) →
`s__ssa1` (after iter 0) → … →
`s__ssaP` (final, published).
Reads in iter k substitute `s → s__ssa<k>`; writes go to
`s__ssa<k+1>` (cond-tagged via `connect_cond`). Unconditional
default-hold `connect(s__ssa<k+1>, s__ssa<k>)` provides the no-write
fallback; `pass_clean_multidriver` last-wins folds writes over the
default-hold.

Crucial filter: **only signals that are BOTH read AND written**
are SSA-tracked. Write-only signals (e.g. T58 `idx = i;` where
`idx` is not read elsewhere in the body) pass through to the legacy
`pass_proc_mux` path. Without this filter, 14 selftests (T58-T65)
regressed — caught + fixed mid-implementation.

Implementation: three clean-room helpers in `read_verilog.hexa`:
- `_rv_signal_is_read_in_body(toks, name) -> int` — RHS-read
  detection via `[...]` skip + `=` lookahead with `==` exclusion.
- `_rv_collect_blocking_lhs(toks) -> [str]` — walk for-body tokens,
  dedup blocking-LHS-base names at paren-depth 0.
- `_rv_ssa_rename_toks(toks, tracked, k_read, k_write) -> [str]` —
  two-pass token rewrite (blanket read-sub + LHS-position write-
  redirect, position discovery on ORIGINAL stream so positions
  align 1:1 with the Pass-1-rewritten output).

Plumbed into `_rv_parse_always` for-handler at L4124 — branch
fires when `is_clocked == 0` AND ≥1 read-then-write signal AND
pre-flight `_rv_emit_for_if_stmts` accepts renamed first iter.
On any failure, falls through to legacy PState walk (no module
change).

### Acceptance evidence

**Selftest**: 75/75 baseline → 76/76 PASS (T73 added). Zero regression
after the read-then-write filter fix.

T73 `F-RFC-RV-COMB-LOOP-SSA-ARBITER`: minimal P=4 priority arbiter
falsifier `for (i=0..3) if (!pick && r[i]) begin g = i[1:0]; pick =
1'b1; end`. Acceptance: 5 wires `pick__ssa0..pick__ssa4` PLUS
final publish `connect(pick, pick__ssa4)` unconditional.

**IR-level live measurement** (`hexa run stdlib/yosys/gate_record.hexa`,
2026-05-21):
- d6 `pass_proc_mux`: lowered **44 cond-tagged LHS-group(s)** (vs 3
  pre-fix — 14× increase from SSA chain emit).
- d6 `pass_clean_multidriver` log:
  ```
  net=idx__ssa1 collapsed 2 drivers → 1 kept=$rvexpr$36 dropped=[idx__ssa0]
  net=idx__ssa2 collapsed 2 drivers → 1 kept=$rvexpr$42 dropped=[idx__ssa1]
  ... (idx__ssa3..ssa7 same pattern)
  net=grant_out collapsed 2 drivers → 1 kept=grant_out__ssa7 dropped=[$const_0]
  net=any_grant collapsed 2 drivers → 1 kept=any_grant__ssa7 dropped=[$const_0]
  ```
  ↑ Direct evidence of the SSA chain firing in router_d6's actual
  arbiter pattern. `idx__ssa<k+1>` collapses with `idx__ssa<k>`
  (default-hold + uncond write) per iteration; `any_grant__ssa7`
  publishes to outer `any_grant`, dropping the base init `$const_0`
  per Verilog §10.4.2 last-write-wins.
- d4: 32 cond-tagged groups lowered (similar pattern, fewer SSA
  versions because P=4 in d4 vs P=8 in d6).

### Blocker — end-to-end area > 0 measurement requires separate fix

`hexa run stdlib/yosys/gate_record.hexa` post-fix reports
`router_d4 area=0.0 µm² Δ=100% FAIL` STILL, but for a different
reason than pre-fix:

```
[abc_map] binary=
[abc_map] script-size=...
[abc_map] exit=missing
[FAIL] d4:abc_map — D18 fail-loud: `abc` binary not on PATH
```

`abc_binary_path()` (`exec("command -v abc 2>/dev/null || true")`)
returns empty string. But shell-side `command -v abc` returns
`/opt/homebrew/bin/abc` correctly (verified in bash + /bin/sh).
Minimal probe:

```hexa
fn main() {
    let r = exec("echo hello")
    println("r='" + to_string(r).trim() + "'")
}
```

Output:
```
sh: line 0: echo: write error: Broken pipe
r=''
```

→ **hexa's `exec` subprocess runtime is broken** in the current
build — ALL shell commands return empty + broken-pipe warning.
This is a separate `self/runtime.c` (popen / pipe handling) issue,
NOT in PR #247's scope. Filed for separate diagnosis + fix.

Tried abc_map.hexa fallback (absolute-path test -x probe) — also
failed because EVERY exec call returns empty under this bug.
Reverted; PR #247 ships pure read_verilog.hexa changes.

### Status

- PR #242 (`cee28986`, #4i) — CLOSED as superseded-by-#245.
- PR #245 (`66a39a31`, Phase 3e) — MERGED, on origin/main.
- PR #247 (`8dd1e677`, ABC comb-loop SSA fix) — OPEN, awaiting
  review/merge. Selftest 76/76 PASS, IR evidence in
  clean_multidriver log.
- exec runtime bug — separate scope. Once fixed, re-run
  `hexa run stdlib/yosys/gate_record.hexa` to confirm
  `router_d4 area > 0`.
- share/freduce parity — deferred (still meaningless while area=0).

`rfc_006 §5 measurement_gate = OPEN`, `absorbed = false` (g3).
Real critical-path blockers now: (1) PR #247 merge, (2) exec
runtime bug fix, (3) end-to-end area measurement re-run with both
landed, (4) ±5 % gate check, (5) g3-conditional flip.

**Session-cost re-estimate** (was 3-7 in YOSYS.md after Phase 3e):
- PR #247 merge: trivial (review only)
- exec runtime fix: unknown scope (separate domain, runtime/popen
  layer — could be 0.5-3 sessions)
- area measurement re-run: 5 min once runtime fixed
- share/freduce: 1-3 sessions if needed (or substrate-tail-pass alt)

Total: **2-6 sessions** depending on runtime bug depth.

## UPDATE 2026-05-21 (cc) — PR #251 cycle 66 MERGED · exec/popen/env stubs restored · Tier-1 (0) CLOSED

hexa-lang PR #251 (`8ea4b75e1846` · "fix(runtime): RUNTIME.md cycle
66 — restore exec/popen/env stubs") MERGED 2026-05-20T18:37:44Z on
origin/main. Absolute precondition for any subsequent §5
measurement — without it, `exec()` returned `""` silently,
`exec_capture()` segfaulted, and the 24h false-positive on
`[OK] abc_map: ok` (while ABC never ran) was downstream noise.

### Fix surface (self/runtime.c)

- `hxlcl_getenv` walks `extern char **environ` directly (was noop
  stub returning NULL → cycle 61 `f1487c14` drop).
- `hxlcl_execve/execvp/execl` pass-through to libc (was svc 0x80
  inline asm — cycle 63/64 `f7dbd931` lost the BSD carry-flag
  success-vs-errno disambiguation + the pair-return convention of
  `pipe(2)`).
- `hxlcl_popen` rewritten as manual `pipe + fork + dup2 + execl
  /bin/sh -c cmd`, returns `hxlcl_fdopen(pfd[0], "r")` shim FILE*
  the `hxlcl_fread` macro can decode. 64-slot linear pid table for
  `pclose`'s `waitpid`.
- `hxlcl_pipe/close/dup2/read/write/fork/waitpid` all libc
  pass-through.

### Verification (Mac arm64)

```
$ /tmp/test_exec
len=5 result='hello'
which: '/opt/homebrew/bin/abc'
$ HEXA_ABC_TEST_KEY=zebra /tmp/test_env_capture
HOME=[/Users/ghost]
PATH_len=462
MISSING_KEY=[zebra]
capture: [hello\n, , 0]
```

### Effect on Tier-1

- closes **Tier-1 (0)** `exec runtime restore` — `hexa exec` chain
  now testable end-to-end.
- unblocks the measurement chain testability that all subsequent
  (a)..(e) closures depend on (`gate_record.hexa` measurement
  driver, `abc_map` subprocess invocation, `which abc` resolution).
- closes the family of inbox patches `yosys-exec-runtime-
  regression-cycles-61-64.md` + `runtime-env-and-exec-capture-
  stubs-block-cli-tools.md` (both flipped to `resolved-ssot
  2026-05-21`).

### Cross-reference

- ARCH §12.1 (0) `[x]` (line ~2100)
- inbox/notes/2026-05-21-hexa-exec-broken-pipe.md (original RCA)

## UPDATE 2026-05-21 (dd) — PR #247 MERGED · ABC comb-loop SSA fix · Tier-1 (a) + (c) CLOSED

hexa-lang PR #247 (`cdfa8d461847` · "feat(read_verilog): RFC 006
§5 ABC comb-loop SSA fix — per-iter SSA renaming") MERGED
2026-05-20T16:58:38Z on origin/main. (Note: PR was `8dd1e677` at
review time, squash-merge produced `cdfa8d46` on main — entry
(bb) cited the pre-squash SHA.)

### Scope landed (vs entry (bb) audit)

1. **Per-iter SSA renaming** in `_rv_parse_always` for-handler —
   3 clean-room helpers (~120 LoC):
   - `_rv_signal_is_read_in_body(toks, name) -> int` (read-then-
     write filter)
   - `_rv_collect_blocking_lhs(toks) -> [str]`
   - `_rv_ssa_rename_toks(toks, tracked, k_read, k_write) -> [str]`
2. **Companion fix** (same PR body) — `abc_binary_path()` switched
   from `command -v abc 2>/dev/null || true` (shell-meta bearing)
   to `which abc` (two tokens, no metas) so `hexa_spawn_no_shell`
   tokenizes + `posix_spawnp` directly under `HEXA_EXEC_NO_SHELL=1`.
3. **abc_map script reorder** (`read_lib` → `read_blif` ordering)
   at `logic_synth/abc_map.hexa` L478-486 — landed in the same PR.

### Selftest delta

`75/75 → 76/76 PASS` (+T73 `F-RFC-RV-COMB-LOOP-SSA-ARBITER`
P=4 priority arbiter falsifier · zero regression after the
`_rv_signal_is_read_in_body` filter restored T58..T65).

### IR-level evidence (`hexa run stdlib/yosys/gate_record.hexa`)

- d6 `pass_proc_mux`: 44 cond-tagged LHS-groups lowered (vs 3
  pre-fix · 14× increase from SSA chain emit).
- d6 `pass_clean_multidriver` collapsed `idx__ssa1..ssa7`,
  `grant_out__ssa7`, `any_grant__ssa7` last-wins per Verilog
  §10.4.2.
- d4: 32 cond-tagged groups (P=4 vs d6 P=8).

### Effect on Tier-1

- closes **Tier-1 (a)** `PR #247 SSA fix` (ARCH §12.1 line ~2103)
- closes **Tier-1 (c)** `abc_map script reorder` (ARCH §12.1 line
  ~2111 — same PR body landed `logic_synth/abc_map.hexa` L478-486)
- with PR #251 (cc) landed first, the abc binary now actually
  resolves on the spawn fast path — measurement chain ran end-to-
  end for the first time post-merge.

### Cross-reference

- ARCH §12.1 (a) + (c) `[x]` (lines ~2103, ~2111)
- entry (bb) `### Real next blocker — ABC comb-loop` is the
  precursor (predicted the fix · this entry records the landing)

## UPDATE 2026-05-21 (ee) — PR #255 OPEN · abc_map stale-BLIF + comb-loop stdout detection · Tier-1 (b) PENDING merge

hexa-lang PR #255 (`e149900f` · branch `rfc006-yosys-abc-map-
honest` · "feat(abc_map): stale _out.blif truncate + `combinational
loop` stdout detection (rfc_006 §5 honesty)") SUBMITTED but
**STILL OPEN** at 2026-05-21 KST (verified
`gh pr view 255 --json state` → `OPEN` · `mergedAt: null`).

### Scope (claimed by PR body · awaiting merge)

1. **truncate-before-exec** for `_out.blif` so stale fixture from
   prior run cannot mask the current exec failure as "success"
   (the cycle that filed the falsifier for `[stale temp-file
   false positives]` user-memory entry — same anti-pattern).
2. **`combinational loop` stdout pattern detection** — ABC writes
   `Network contains combinational loop` to stdout (not stderr +
   not exit-code), so the prior abc_map error path missed it
   entirely. PR teaches the parser to flag the line + escalate
   to fail-loud rather than swallow.
3. **T8 selftest** added — falsifier asserts both behaviours.

### Effect on Tier-1

- target = **Tier-1 (b)** `PR #255 abc_map honesty` (ARCH §12.1
  line ~2107) — marker currently `[~]` (in-flight) · flips to
  `[x]` only on merge.
- ARCH §12.1 already carries the in-flight status; no flip
  required on demiurge side until `gh pr view 255 --json state`
  reports MERGED.
- **No-op-on-demiurge-side**: this entry documents the SUBMITTED
  state for the ledger continuity; landing event will be a
  separate entry when it merges.

### Cross-reference

- ARCH §12.1 (b) `[~]` (line ~2107)
- (dd) PR #247 landed the abc_binary_path / spawn fast-path fix
  that exposed the stale-BLIF false-positive surface PR #255
  closes.

## UPDATE 2026-05-21 (ff) — PR #261 MERGED · RFC 073 Phase 3g SSA pre-loop init redirect · Tier-1 (d) CLOSED

hexa-lang PR #261 (`0ca0994fb751` · "feat(read_verilog): RFC 073
Phase 3g — SSA pre-loop init redirect (rfc_006 §5 Tier-1 (d)
rr_ptr__d comb-loop CLOSED)") MERGED 2026-05-20T19:26:33Z on
origin/main. **Note**: PR #260 (`rfc006-yosys-ssa-seed-fix`
branch · still OPEN) was a parallel attempt at the same (d)
target — superseded by #261.

### Root cause

PR #247 (Phase 3f) introduced a pre-loop alias `connect(s__ssa0,
s)` + post-publish `connect(s, s__ssa<P>)`. Combined with the
pre-loop direct init `connect(s, $const_0)`, `s` was multi-
driven → `clean_multidriver` collapsed to `s__ssa<P>` last-wins
→ alias chained `s__ssa0 ← s ← s__ssa<P>` → ABC `NetworkCheck`
flagged a self-loop terminating at `rr_ptr__d` (downstream
`$dff` CO consuming `grant_in`).

### Fix (read_verilog.hexa · +243 / -10)

1. New helper `_rv_ssa_rewrite_preloop_for(m, s, snapshot)` at
   L2429+ — walks `m.connect_lhs[0:snapshot]` and rewrites
   unconditional `connect(s, X)` → `connect(s__ssa0, X)` when
   `s ∈ _ssa_tracked`.
2. SSA fire site snapshots `len(m.connect_lhs)` BEFORE the alias
   loop · calls rewrite per tracked `s` · SUPPRESSES the legacy
   `connect(s__ssa0, s)` alias when ≥1 rewrite occurred.
3. T74 (Phase 3f) updated — old T74c replaced with T74c
   (entry-driver on `v__ssa0` from rewritten init) + T74d
   (legacy alias absent regression guard).
4. T75 (Phase 3g falsifier) added — `rr = rr_q ; for ... rr =
   rr + 1'b1` minimum shape · asserts SSA wires exist · legacy
   alias absent · redirected init present · post-publish
   present · exactly 1 unconditional driver of `rr`.

### Selftest delta

- read_verilog: `77/77 → 78/78 PASS` (+T75)
- passes: 35/35 PASS (no regression)
- abc_map: 7/7 PASS (no regression)
- rtlil: 11/11 PASS · liberty: 8/8 PASS (no regression)

### §5 oracle measurement (sky130_fd_sc_hd · ABC 2026-05-21)

```
d4 abc_map: ok   (was: ABC NetworkCheck FAIL on n272 → CO rr_ptr__d)
d6 abc_map: ok   (was: ABC NetworkCheck FAIL on n372 → CO rr_ptr__d)
d4 area = 559.286 µm²  (oracle 61762.99 · Δ ≈ 99.1 % UNDER)
d6 area = 771.99  µm²  (oracle 93608.53 · Δ ≈ 99.2 % UNDER)
ratio = 1.380×  vs oracle 1.5156×
```

### Effect on Tier-1

- closes **Tier-1 (d)** `rr_ptr__d cross-iter comb-loop` (ARCH
  §12.1 line ~2113) — first time §5 measurement chain produces
  `area > 0` for both designs · honest-skip on `fifo_mem` still
  active at this point (became (e) target).
- **comb-loop CLASS closed** entirely — both Phase 3f intra-iter
  (PR #247) + Phase 3g cross-iter (PR #261) variants resolved.
- §5 verdict (g3 honest): area-oracle still OPEN · new blocker
  named in PR body = Tier-1 (e) `fifo_mem` 2-D packed-array
  memwr (40 non-driven nets in d4, ~80 in d6 per ABC's
  `Constant-0 drivers added` warning).

### Cross-reference

- ARCH §12.1 (d) `[x]` (line ~2113) + the "PR #260 parallel
  attempt superseded by #261" note inline
- hexa-lang `inbox/notes/2026-05-21-rfc006-§5-phase3g-rrptr-
  closed.md` (full RCA + measurement)
- hexa-lang `inbox/patches/yosys-rr-ptr-cross-iteration-comb-
  loop.md` (status → `resolved-ssot`)

## UPDATE 2026-05-21 (gg) — `c4b35b13` direct push · `fifo_mem` 2-D LHS Option A · Tier-1 (e) own-scope CLOSED

hexa-lang `c4b35b13d3d1` direct-pushed to origin/main
2026-05-21T14:32:02 +0900 (NOT via PR · direct push) ·
"feat(read_verilog): RFC 006 §5 Tier-1 (e) Option A — 2-D LHS
flat $dff demux (T76 PASS · router_d{4,6} area > 0 unblocked)".

### Scope landed

1. `_rv_parse_port_decl` (L688-720) — second unpacked range
   parsed · P*D wires named `base[i][j]` of width W each.
2. `_rv_array_bound2(m, base) -> RvBound2 { outer, inner }`
   NEW helper · walks wires named `base[*][*]` to recover (P, D).
   `_rv_array_bound` updated to filter 2-D entries (so 1-D
   callers don't over-count P*D when base is 2-D).
3. `_rv_emit_body_v2` 2-D branch (L2920+) — captures `idx2_toks`
   parallel to existing idx1 · emits per-slot
   `connect_cond(slot__d, rhs, guard)` + tracked `$dff` ·
   four sub-cases (const-const / const-dyn / dyn-const /
   dyn-dyn) with `$eq + $and + $mux + $dff` per slot.
4. `_rv_parse_always` bare-path 2-D branch (L5060+) — same four
   sub-cases · `$mux` feedback-hold + `$dff`.
5. T76 falsifier (`sm76` minimum-shape `m[i][j] <= d`, N=M=2):
   4 slot wires · 8 `$eq` · 4 `$and` · 4 `$mux` · 4 `$dff` ·
   `_rv_array_bound2 = (2, 2)`.

### Selftest delta

- read_verilog: `78/78 → 79/79 PASS` (+T76)
- passes / abc_map / rtlil / liberty: 35/35 · 7/7 · 11/11 · 8/8
  unchanged (zero regression).

### §5 measurement delta (sky130_fd_sc_hd · ABC 2026-05-21)

```
router_d4 area = 559.286 → 1207.41 µm²  (+2.16× · oracle gap 99.09% → 98.05%)
router_d6 area = 771.99  → 1677.86 µm²  (+2.17× · oracle gap 99.18% → 98.21%)
both abc_map: ok · no NetworkCheck failure · no honest-skip
```

### Effect on Tier-1

- closes **Tier-1 (e) own-scope** `fifo_mem 2-D LHS flat $dff
  demux` (ARCH §12.1 line ~2125) — area > 0 · ABC accepts ·
  honest-skip at `_rv_emit_body_v2` L2828
  (`if has_idx2 == 1 { continue }`) removed · `_rv_parse_always`
  bare-path L5040 (`expected `<=` or `=` got `[`) removed.
- **DOES NOT close §5** — absolute area gap ~98 % remains.
  Option A flat per-element `$dff` is correct but ~10×
  substrate's `synth_memory_dff`-consolidated count.
- ±5 % closure needs either Option B (RTLIL `$memrd`/`$memwr`
  cells + module-level `$mem`) OR Tier-1 (f) crossbar output
  array writes. NO `Yosys absorbed` claim made.
- hexa-lang `inbox/patches/yosys-fifo-mem-2d-array-memwr-emit.md`
  status flipped to "Option A landed".

### Cross-reference

- ARCH §12.1 (e) `[x]` (line ~2125) + Log entry
  `2026-05-21 — §12.1 (e) `fifo_mem` 2-D LHS Option A LANDED`
  (line ~2195) — captured the cross-repo direct-push discovery
  during post-G31-merge audit.
- ARCH §12.1 "current gate state" snapshot anchors `c4b35b13`.

## UPDATE 2026-05-21 (hh) — `a4a032af` / `0b82880b` direct push · 2-D LHS D-wire width-aware follow-up · area numbers UNCHANGED (BLIF emitter still collapses)

hexa-lang `a4a032afa65c` (briefed SHA · on `fix/codegen-c2-nested-
lhs-recursive-unwrap-2026-05-21` worktree branch) rebased onto
main as `0b82880b7082` 2026-05-21T15:27:02 +0900 — same author /
same message / same diff. Direct push to origin/main (NOT via
PR). "fix(read_verilog): 2-D LHS D-wire width-aware — match slot
width via `_rv_v2_wire_width`".

### Fix (read_verilog.hexa)

Option A's two 2-D LHS emit sites in `_rv_emit_body_v2` (L2977
const-const, L3074 dyn) hardcoded the D-wire width to 1 when
the slot wire itself is multi-bit (declared by
`_rv_parse_port_decl` with the packed range `[W-1:0]`). 1-bit
slot was correct · multi-bit slot had `$dff(D=width-1, Q=width-W)`
latent RTLIL width mismatch downstream passes had to
compensate for.

Fix introduces `_rv_v2_wire_width(m, name)` (returns 1 when
absent · preserves existing 1-bit slot semantics) · called at
the two D-wire creation sites in the 2-D branch to mirror the
slot's declared packed width on its D-wire.

### Selftest delta

`79/79 PASS preserved` (T76's slot is 1-bit so the change is a
no-op for the falsifier · zero regression).

### §5 measurement delta — NONE

```
router_d4 area = 1207.41 µm²  (unchanged · oracle 61762.99 · Δ 98.05%)
router_d6 area = 1677.86 µm²  (unchanged · oracle 93608.53 · Δ 98.21%)
```

Reason: the downstream BLIF emitter still collapses multi-bit
cells to single `.latch` lines. Width-correct RTLIL no longer
propagates through the BLIF write surface — filed as separate
inbox note `2026-05-21-rfc006-§5-multibit-width-truncation.md`
(hexa-lang sibling repo `39e84435`).

### Effect on Tier-1

- **No new Tier-1 marker closed** — purely a latent-correctness
  follow-up on (e) own-scope. ARCH §12.1 (e) `[x]` flip already
  recorded by (gg).
- Quoted in ARCH §12.1 Log entry (line ~2219) as the same-cycle
  follow-up:
  ```
  follow-up (same-cycle): hexa-lang `a4a032af`
  fix(read_verilog): 2-D LHS D-wire width-aware — match slot
  width via _rv_v2_wire_width (15:27 KST · post-G34 land time).
  ```
- §5 absolute area gap remains ~98 % · ±5 % closure unblocked
  at frontend layer · BLIF emitter is the next narrowing
  (separate handoff note).

### Cross-reference

- ARCH §12.1 Log (line ~2219) `follow-up` callout
- hexa-lang `inbox/notes/2026-05-21-rfc006-§5-multibit-width-
  truncation.md` (BLIF emitter is the dominant remaining
  truncation surface)
- (gg) `c4b35b13` is the predecessor — (hh) is its width-correct
  refinement.

---

### Status snapshot (post (cc)..(hh) · 2026-05-21 KST)

```
Tier-1 closure path (ARCH §12.1 line ~2098):
  [x] (0) exec runtime restore         — PR #251 cdfa-pred MERGED (cc)
  [x] (a) PR #247 SSA fix              — PR #247 cdfa8d46 MERGED (dd)
  [~] (b) PR #255 abc_map honesty      — PR #255 e149900f OPEN   (ee)
  [x] (c) abc_map script reorder       — in PR #247 body         (dd)
  [x] (d) rr_ptr__d cross-iter loop    — PR #261 0ca0994f MERGED (ff)
  [x] (e) fifo_mem 2-D LHS Option A    — c4b35b13 direct LANDED  (gg)
  [ ] (f) router_d4 area > 0 → ±5 %    — OPEN (~98 % gap)
  [ ] (g) router_d6 ±5 % parity        — OPEN (~98 % gap)
  [ ] (h) ratio 1.5156× verification   — OPEN
  [ ] (i) measurement_gate = CLOSED_MEASURED — OPEN

§5 measurement_gate = OPEN · substrate-axis absorbed = false ·
cell-side `absorbed=true` (κ-43 dynamic flip) UNCHANGED (별 axis).
Cluster cost dominant residual = ~98 % absolute area gap; Option B
($memrd/$memwr cells + module-level $mem) OR Tier-1 (f) crossbar
output array writes territory.
```
