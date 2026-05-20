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
