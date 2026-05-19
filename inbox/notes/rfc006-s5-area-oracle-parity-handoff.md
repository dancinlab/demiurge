# incoming note: rfc006-s5-area-oracle-parity-handoff — the genuine remaining Yosys-absorption work

> **id**: `rfc006-s5-area-oracle-parity` · **opened**: 2026-05-20 KST · **status**: `handoff-open — ABC + SKY130 PDK both secured & measured-against; blocked on read_verilog 6-construct scope expansion (ABSORPTION.md §178, ~1-2 weeks)`
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
