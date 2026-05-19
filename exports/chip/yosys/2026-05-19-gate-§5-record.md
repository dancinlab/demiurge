# rfc_006 §5 measurement-gate record — 2026-05-19 (g3 honest)

> **Verdict: PARTIAL (gate OPEN).** All 7 hexa-native modules
> implemented + passing self-tests (57/57). Two substrate gaps + one
> frontend scope gap block full §5 closure.
> **No `Yosys absorbed` claim.**

## Cited oracle (rfc_006 §5)

| design | area | tolerance |
|---|---:|---|
| `router_d4.v` SKY130 sky130_fd_sc_hd | **61 762.99 µm²** | ±5 % |
| `router_d6.v` SKY130 sky130_fd_sc_hd | **93 608.53 µm²** | ±5 % |
| ratio d6/d4 | **1.5156×** | ±5 % |

Source: `~/core/demiurge/proposals/rfc_006_yosys_absorption.md` §2 +
HANDOFF §4 oracle + `router_port_area_norm = 1.516` (every comb F1F2
record).

## Pipeline trace (`hexa run stdlib/yosys/gate_record.hexa`)

```
[gate] SKY130 sky130_fd_sc_hd lib: MISSING
[gate] ABC binary: MISSING

[gate] router_d4.v — pipeline trace:
  [FAIL] d4:read_verilog — read_verilog: unsupported construct
         `localparam` (synth-subset only — see rfc_006 §4 module-2 scope)

[gate] router_d6.v — pipeline trace:
  [FAIL] d6:read_verilog — read_verilog: unsupported construct
         `localparam` (synth-subset only)
```

## What works (this session)

- 7/7 modules landed in `~/core/hexa-lang/stdlib/yosys/` (worktree
  `/private/tmp/wt-yosys-rfc006`, branch `yosys-rfc006`):
  - `rtlil.hexa` — typed RTLIL IR (Design/Module/Wire/Cell/Process) ·
    selftest 10/10 PASS
  - `read_verilog.hexa` — minimum-synth-subset Verilog frontend (module,
    input/output/wire, assign with single-op &/|/^/~/connect/constants) ·
    selftest 10/10 PASS
  - `passes.hexa` — proc/flatten/opt/techmap_sky130/dfflibmap_sky130/
    opt_clean/hierarchy_top · selftest 9/9 PASS
  - `liberty.hexa` — Liberty (.lib) parser (cell area + pin direction +
    sequential category) · selftest 8/8 PASS
  - `abc_map.hexa` — D18 bounded-subprocess wrapper (BLIF emit, ABC
    invocation, mapped-BLIF reader, stderr provenance) · selftest 5/5
    PASS with fail-loud on missing `abc` (exit 127)
  - `write_verilog.hexa` — RTLIL → gate-Verilog backend (port-ordered,
    byte-stable, `assign`-aware) · selftest 7/7 PASS
  - `yosys.hexa` — dispatcher (`hexa yosys <subcmd>`, exit codes
    0/1/2/90/91) · selftest 8/8 PASS
- `gate_record.hexa` runner records the §5 verdict honestly.

## Gaps blocking PASS (g3 honesty)

1. **ABC binary not on PATH** — `command -v abc` returned empty.
   Install `berkeley-abc` (https://github.com/berkeley-abc/abc) to
   close D18 substrate side.
2. **SKY130 `sky130_fd_sc_hd__tt_025C_1v80.lib` not on this
   workstation** — probed three canonical paths (`/usr/local/share/pdk`,
   `/opt/homebrew/share/pdk`, `~/.pdk/sky130A/`), all absent. Install
   the skywater-pdk (https://github.com/google/skywater-pdk) for the
   §5 area-oracle measurement.
3. **`read_verilog` SCOPE expansion** — `comb/rtl/router_d{4,6}.v`
   uses `localparam` + `parameter` + `generate-for` + `always @(*)` +
   multi-dimensional arrays + `function automatic`. Phase-a body
   covers only the minimum-subset (module/input/output/wire/assign
   with single binary op). Honest gap deliberately documented in
   `read_verilog.hexa` SCOPE block — each next construct = one new
   fn + one new self-test + fail-loud on unsupported.

## Re-run procedure

```bash
# all self-tests
for f in rtlil read_verilog passes liberty abc_map write_verilog yosys; do
    hexa run stdlib/yosys/${f}.hexa
done
# gate record (re-runs against comb/rtl/router_d{4,6}.v)
hexa run stdlib/yosys/gate_record.hexa
```

## Provenance / cross-refs

- worktree: `/private/tmp/wt-yosys-rfc006` (branch `yosys-rfc006`, **not
  pushed** — awaiting main merge decision)
- spec: `proposals/rfc_006_yosys_absorption.md` §4 (modules) + §5
  (gate) + §7 (D18)
- D-decisions: D15 (stdlib in hexa-lang) · D17 (hexa-native absorption)
  · D18 (ABC bounded-subprocess) · D19 (modules in hexa-lang/stdlib)
- pattern mirror: `stdlib/booksim/` (rfc_003 clean-room + raw-91
  fail-loud)
- `AGENTS.tape` g_hexa_native_sanctioned (D18 exception)
