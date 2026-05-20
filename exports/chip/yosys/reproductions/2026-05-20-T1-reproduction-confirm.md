# rfc_006 §5 substrate-gate — reproduction confirm (2026-05-20, T1 follow-up)

> **Verdict: PASS reproduced — substrate gate still CLOSED_MEASURED.**
> Re-ran the 2026-05-20 CLOSED_MEASURED recipe from a fresh worktree
> on origin/main tip; numbers byte-identical to the parent record.
> g3 honest: this is **only the substrate measurement** —
> the hexa-native `stdlib/yosys/`/`stdlib/kernels/logic_synth/`
> absorption (frontend SCOPE + techmap_sky130 cell coverage +
> gate-runner area-sum wiring) remains **OPEN**. No
> "Yosys absorbed" claim added by this reproduction.

## Parent record

`exports/chip/yosys/2026-05-20-gate-§5-record-CLOSED_MEASURED.md`
(CLOSED at substrate level · OPEN at hexa-native absorption level).

## Measurement re-fire (this session)

| design | measured area (µm²) | oracle (µm²) | Δ vs oracle |
|---|---:|---:|---:|
| `router_d4` (flat_v2k) | **61762.985600** | 61762.99 | −0.000007 % |
| `router_d6` (flat_v2k) | **93608.528000** | 93608.53 | −0.000002 % |
| ratio d6/d4 | **1.515609** | 1.5156 | +0.000584 % |

Tolerance gate ±5 % → all three pass by ~5 orders of magnitude.
Byte-identical to the parent CLOSED_MEASURED record's numbers.

## Reproduction (verbatim, this session)

```bash
LIB=/tmp/sky130/skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys -p "read_verilog ~/core/hexa-lang/comb/rtl/flat_v2k/router_d4.v; \
          synth -top router_d4; dfflibmap -liberty $LIB; abc -liberty $LIB; \
          stat -liberty $LIB"
#   →  Chip area for module '\router_d4': 61762.985600
yosys -p "read_verilog ~/core/hexa-lang/comb/rtl/flat_v2k/router_d6.v; \
          synth -top router_d6; dfflibmap -liberty $LIB; abc -liberty $LIB; \
          stat -liberty $LIB"
#   →  Chip area for module '\router_d6': 93608.528000
```

Both invocations exit 0 with one benign warning each
(`Replacing memory \fifo_tail with list of registers` — expected at
FIFO_LD=2 register-mapping).

## Provenance

- Toolchain : `Yosys 0.65 (git sha1 aec814bdf3071f7e0fd0fbe43f7f711e99d01e24, clang++ 21.0.0 -fPIC -O3)`
- Repo tip  : `origin/main` `49c1d2d6` (fetched 2026-05-20 KST)
- Host      : Darwin arm64
- PDK lib   : 12 841 637 bytes (sky130_fd_sc_hd__tt_025C_1v80)

## Lib-path corroboration (new finding)

The CLOSED_MEASURED record noted SKY130 lib ownership is open
(volatile `/tmp` location). This session confirms an additional
non-volatile copy already exists on this host:

```
/Users/ghost/core/OpenROAD-flow-scripts/flow/platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
  (12 800 135 bytes, mtime 2026-05-18)
```

(byte-different from the `/tmp` copy by ~41 KB — likely a minor
SKY-PDK release delta or OpenROAD scrubbing; both equivalent for the
§5 area-oracle within ±5 %). PDK-ownership SSOT decision remains
upstream of this reproduction record.

## Hexa-native gate status (UNCHANGED — still OPEN)

Ran `stdlib/yosys/gate_record.hexa` against `comb/rtl/router_d{4,6}.v`
via `hexa-parse` (build path; module_loader resolved via
`HEXA_MODULE_LOADER=/Users/ghost/core/hexa-lang/build/hexa_module_loader`).

Pipeline trace (this session):
- `read_verilog`, `hierarchy`, `proc`, `flatten`, `opt`, `techmap_sky130`,
  `dfflibmap_sky130` all `[OK]` for both d4 and d6.
- `abc_map` `[FAIL]` for both: D18 fail-loud — ABC produced no mapped
  BLIF (output file empty). Manual `abc` re-fire reports
  `Line 4: The current library is not available. Reading network from
  file has failed.` — the BLIF emitted by `abc_emit_blif` still contains
  Yosys-style RTLIL pseudo-cells (`$eq`, `$ne`, `$add`, `$mod`,
  `$logic_and`, `$logic_not`, `$mux`, …) which are NOT in any SKY130
  lib, and `stdlib/kernels/logic_synth/passes.hexa::pass_techmap_sky130`
  only renames 5 trivial cell types (`$and`, `$or`, `$xor`, `$not`,
  `$dff`), leaving the arith/cmp/mux operators unmapped.

Honest gap (rfc_006 absorption pickup, unchanged from
`2026-05-19-yosys-rfc006-bodies-landed.md`):

1. **`pass_techmap_sky130` cell-coverage expansion** — add lowering
   rules for `$eq`/`$ne`/`$lt`/`$le`/`$gt`/`$ge`/`$add`/`$sub`/`$mul`/`$mod`
   /`$logic_and`/`$logic_or`/`$logic_not`/`$mux`/`$pmux` into NAND/AOI/OAI
   trees (Yosys's `techmap.v` + arith mapping is the upstream model).
2. **`gate_record.hexa` area-sum wiring** — call
   `lib_total_area(lib, names, counts)` on the post-`abc_map` design
   when both `found_lib != ""` and the pipeline reaches the `abc_map`
   stage successfully (currently the gate hard-bails at
   `[gate] verdict: needs cell-area sum vs oracle (next step)`).
3. **`abc_map.hexa` script ordering** — current invocation is
   `read_blif $in ; strash ; read_lib $lib ; map ; write_blif $out`;
   ABC reports `Line 4: library not available` because `read_blif`
   can't resolve `.gate` types until a lib is loaded. Re-order to
   `read_lib $lib ; read_blif $in ; strash ; map ; write_blif $out`
   (or use the standalone `&` command flow which loads lib before
   reading the netlist). Independent of (1) — even after techmap
   coverage expands, the script order needs to put `read_lib` first.

## Honest-scope note

- This record is a **reproduction** of the 2026-05-20 substrate
  measurement using upstream `yosys 0.65` against the sv2v-flattened
  `comb/rtl/flat_v2k/router_d{4,6}.v`. It is **NOT** a hexa-native
  measurement.
- The hexa-native `stdlib/yosys/` + `stdlib/kernels/logic_synth/`
  pipeline does **not** reach the area-oracle in this session
  (techmap coverage + script-ordering + area-sum, above). The
  absorption gate stays OPEN; the parent CLOSED_MEASURED record
  closes only the substrate-side.
- No `provenance.absorbed` flag flipped by this reproduction.
- @D g5 hexa-native, @D g6 atlas-cite, @D g7 inbox-patches all
  respected; the upstream yosys-binary call is the rfc_006 D18
  bounded-substrate, not a derivation backend.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
