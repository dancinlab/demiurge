# rfc_006 §5 measurement-gate record — 2026-05-20 (GATE_CLOSED_MEASURED)

> **Verdict: PASS — gate CLOSED.** Both designs synthesised against
> SKY130 sky130_fd_sc_hd via upstream `yosys` 0.65; measured chip
> areas land within ±0.001 % of the rfc_006 §5 oracle (tolerance was
> ±5 %). g3 honest: this closes the **substrate** measurement gate
> only — the hexa-native `stdlib/yosys/read_verilog` SCOPE-expansion
> work documented in the 2026-05-19 OPEN record is **still open** and
> remains the absorption pickup. **No "Yosys absorbed" claim.**

## Cited oracle (rfc_006 §5)

| design | oracle area | tolerance |
|---|---:|---|
| `router_d4.v` SKY130 sky130_fd_sc_hd | **61 762.99 µm²** | ±5 % |
| `router_d6.v` SKY130 sky130_fd_sc_hd | **93 608.53 µm²** | ±5 % |
| ratio d6/d4 | **1.5156×** | ±5 % |

## Measured this session (2026-05-20)

| design | measured area | Δ vs oracle | verdict |
|---|---:|---:|:---:|
| `router_d4` (flat_v2k) | **61 762.9856 µm²** | −0.00001 % | PASS |
| `router_d6` (flat_v2k) | **93 608.5280 µm²** | −0.00000 % | PASS |
| ratio d6/d4 | **1.515609×** | +0.00058 % | PASS |

All three within ±5 % tolerance by **~5 orders of magnitude**.

## Blocker resolution (vs 2026-05-19 OPEN record)

| 2026-05-19 blocker | 2026-05-20 status | resolution |
|---|---|---|
| `abc` binary missing on PATH | RESOLVED (mis-diagnosis) | `abc` ships *inside* `yosys` 0.65 as an internal pass (`yosys -p "abc -liberty ..."`). No standalone binary required. Confirmed by `yosys -p "abc -help"`. |
| SKY130 `sky130_fd_sc_hd__tt_025C_1v80.lib` missing | RESOLVED (already present) | Found at `/tmp/sky130/skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__tt_025C_1v80.lib` (12 841 637 bytes, mtime 2026-05-18). Probably staged by an earlier hexa-arch session; surfaced via grep of pre-existing `router_d4.sky130.out`. |
| `stdlib/yosys/read_verilog` SCOPE too narrow for `comb/rtl/router_d{4,6}.v` (`localparam` / `generate` / `always` / `function automatic` / unpacked arrays) | **STILL OPEN** (substrate-side bypassed) | This run used the *upstream* `yosys` binary as the §5 substrate oracle — not the in-flight `stdlib/yosys/read_verilog.hexa` frontend. To keep the hexa-frontend honest, the Verilog actually fed in was the **sv2v-flattened `comb/rtl/flat_v2k/router_d{4,6}.v`** (Verilog-2001, no SV unpacked-array ports). The hexa-native frontend SCOPE expansion (`localparam`, `generate-for`, `always @(*)`, `function automatic`, multi-D `reg` mem, signed arith) is **still the pickup** for the hexa-lang absorption gate. |

## Reproduction (verbatim)

```bash
LIB=/tmp/sky130/skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__tt_025C_1v80.lib

# d4
yosys -p "read_verilog ~/core/hexa-lang/comb/rtl/flat_v2k/router_d4.v; \
          synth -top router_d4; \
          dfflibmap -liberty $LIB; \
          abc      -liberty $LIB; \
          stat     -liberty $LIB"
#   →  Chip area for module '\router_d4': 61762.985600

# d6
yosys -p "read_verilog ~/core/hexa-lang/comb/rtl/flat_v2k/router_d6.v; \
          synth -top router_d6; \
          dfflibmap -liberty $LIB; \
          abc      -liberty $LIB; \
          stat     -liberty $LIB"
#   →  Chip area for module '\router_d6': 93608.528000
```

Exit code 0 for both invocations; no `ERROR` lines in stderr; one
benign `Warning: Replacing memory \fifo_tail with list of registers`
(expected — small FIFOs at FIFO_LD=2 are register-mapped, not RAM).

## Inlined yosys `stat -liberty` output (post-techmap, post-abc)

### router_d4

```
=== router_d4 ===

        +----------Local Count, excluding submodules.
        |        +-Local Area, excluding submodules.
        |        |
     5173        - wires
     8501        - wire bits
       72        - public wires
     3026        - public wire bits
       10        - ports
      670        - port bits
     2927 6.18E+04 cells
        1    8.758   sky130_fd_sc_hd__a2111oi_0
        7    52.55   sky130_fd_sc_hd__a211oi_1
        1    10.01   sky130_fd_sc_hd__a21bo_1
        3   22.522   sky130_fd_sc_hd__a21boi_0
        4   30.029   sky130_fd_sc_hd__a21o_1
       23   115.11   sky130_fd_sc_hd__a21oi_1
        4   35.034   sky130_fd_sc_hd__a221oi_1
        5   50.048   sky130_fd_sc_hd__a222oi_1
        7   61.309   sky130_fd_sc_hd__a22o_1
      126  945.907   sky130_fd_sc_hd__a22oi_1
        3   26.275   sky130_fd_sc_hd__a2bb2oi_1
        2   17.517   sky130_fd_sc_hd__a311oi_1
        9   78.826   sky130_fd_sc_hd__a31o_1
       15    93.84   sky130_fd_sc_hd__a31oi_1
        1    10.01   sky130_fd_sc_hd__a32o_1
        6   37.536   sky130_fd_sc_hd__and2_0
        8   50.048   sky130_fd_sc_hd__and3_1
        1    8.758   sky130_fd_sc_hd__and3b_1
        2   17.517   sky130_fd_sc_hd__and4_1
        1    10.01   sky130_fd_sc_hd__and4b_1
       17   63.811   sky130_fd_sc_hd__clkinv_1
       23  460.442   sky130_fd_sc_hd__dfxtp_1
     1615 4.85E+04   sky130_fd_sc_hd__edfxtp_1
        7   43.792   sky130_fd_sc_hd__lpflow_inputiso1p_1
       62  387.872   sky130_fd_sc_hd__lpflow_isobufsrc_1
        6   67.565   sky130_fd_sc_hd__mux2_1
       19  190.182   sky130_fd_sc_hd__mux2i_1
      318 7.16E+03   sky130_fd_sc_hd__mux4_2
      270 1.01E+03   sky130_fd_sc_hd__nand2_1
       11   68.816   sky130_fd_sc_hd__nand2b_1
       41  205.197   sky130_fd_sc_hd__nand3_1
        1    7.507   sky130_fd_sc_hd__nand3b_1
       67  419.152   sky130_fd_sc_hd__nand4_1
        2   17.517   sky130_fd_sc_hd__nand4b_1
       68  255.245   sky130_fd_sc_hd__nor2_1
       11   68.816   sky130_fd_sc_hd__nor2b_1
       23   115.11   sky130_fd_sc_hd__nor3_1
        6   45.043   sky130_fd_sc_hd__nor3b_1
       11   68.816   sky130_fd_sc_hd__nor4_1
        7   61.309   sky130_fd_sc_hd__nor4b_1
        2   22.522   sky130_fd_sc_hd__o2111a_1
        5   37.536   sky130_fd_sc_hd__o211ai_1
        2   15.014   sky130_fd_sc_hd__o21a_1
       17   85.082   sky130_fd_sc_hd__o21ai_0
        1    10.01   sky130_fd_sc_hd__o21ba_1
        1    7.507   sky130_fd_sc_hd__o21bai_1
        1    8.758   sky130_fd_sc_hd__o221ai_1
        1    8.758   sky130_fd_sc_hd__o22a_1
       14   87.584   sky130_fd_sc_hd__o22ai_1
        1    8.758   sky130_fd_sc_hd__o2bb2ai_1
        1    8.758   sky130_fd_sc_hd__o311ai_0
        1    8.758   sky130_fd_sc_hd__o31a_1
        3   22.522   sky130_fd_sc_hd__o31ai_1
        1    8.758   sky130_fd_sc_hd__o41ai_1
        9   56.304   sky130_fd_sc_hd__or3_1
        1    8.758   sky130_fd_sc_hd__or3b_1
        2   20.019   sky130_fd_sc_hd__or4b_1
       24  210.202   sky130_fd_sc_hd__xnor2_1
       26  227.718   sky130_fd_sc_hd__xor2_1

   Chip area for module '\router_d4': 61762.985600
     of which used for sequential elements: 48956.953600 (79.27%)

Warnings: 1 unique messages, 1 total
```

### router_d6

```
=== router_d6 ===

        +----------Local Count, excluding submodules.
        |        +-Local Area, excluding submodules.
        |        |
    10028        - wires
    14822        - wire bits
      120        - public wires
     4408        - public wire bits
       10        - ports
      938        - port bits
     5026 9.36E+04 cells
        1   11.261   sky130_fd_sc_hd__a2111o_1
        5   43.792   sky130_fd_sc_hd__a2111oi_0
        4   35.034   sky130_fd_sc_hd__a211o_1
       17  127.622   sky130_fd_sc_hd__a211oi_1
        3   30.029   sky130_fd_sc_hd__a21bo_1
        8   60.058   sky130_fd_sc_hd__a21boi_0
       17  127.622   sky130_fd_sc_hd__a21o_1
      107  535.514   sky130_fd_sc_hd__a21oi_1
        2   20.019   sky130_fd_sc_hd__a221o_1
       64  560.538   sky130_fd_sc_hd__a221oi_1
       19  190.182   sky130_fd_sc_hd__a222oi_1
       62  543.021   sky130_fd_sc_hd__a22o_1
      299 2.24E+03   sky130_fd_sc_hd__a22oi_1
        3   26.275   sky130_fd_sc_hd__a2bb2oi_1
        4   35.034   sky130_fd_sc_hd__a31o_1
       21  131.376   sky130_fd_sc_hd__a31oi_1
        3   30.029   sky130_fd_sc_hd__a32o_1
       11   96.342   sky130_fd_sc_hd__a32oi_1
        2   17.517   sky130_fd_sc_hd__a41oi_1
       24  150.144   sky130_fd_sc_hd__and2_0
       31  193.936   sky130_fd_sc_hd__and3_1
        6    52.55   sky130_fd_sc_hd__and3b_1
        8   70.067   sky130_fd_sc_hd__and4_1
       46  172.666   sky130_fd_sc_hd__clkinv_1
       34  680.653   sky130_fd_sc_hd__dfxtp_1
     2258 6.78E+04   sky130_fd_sc_hd__edfxtp_1
       37  231.472   sky130_fd_sc_hd__lpflow_inputiso1p_1
       52  325.312   sky130_fd_sc_hd__lpflow_isobufsrc_1
       58  580.557   sky130_fd_sc_hd__maj3_1
       13   146.39   sky130_fd_sc_hd__mux2_1
       17  170.163   sky130_fd_sc_hd__mux2i_1
      444  9999.59   sky130_fd_sc_hd__mux4_2
      301 1.13E+03   sky130_fd_sc_hd__nand2_1
       61  381.616   sky130_fd_sc_hd__nand2b_1
       55  275.264   sky130_fd_sc_hd__nand3_1
        5   37.536   sky130_fd_sc_hd__nand3b_1
       88  550.528   sky130_fd_sc_hd__nand4_1
        1    8.758   sky130_fd_sc_hd__nand4b_1
        2   22.522   sky130_fd_sc_hd__nand4bb_1
      219  822.038   sky130_fd_sc_hd__nor2_1
       23  143.888   sky130_fd_sc_hd__nor2b_1
       49  245.235   sky130_fd_sc_hd__nor3_1
       14  105.101   sky130_fd_sc_hd__nor3b_1
       20   125.12   sky130_fd_sc_hd__nor4_1
        9   78.826   sky130_fd_sc_hd__nor4b_1
        1    10.01   sky130_fd_sc_hd__nor4bb_1
        1    8.758   sky130_fd_sc_hd__o2111ai_1
        9   67.565   sky130_fd_sc_hd__o211ai_1
        9   67.565   sky130_fd_sc_hd__o21a_1
       65  325.312   sky130_fd_sc_hd__o21ai_0
        4   30.029   sky130_fd_sc_hd__o21bai_1
        2   22.522   sky130_fd_sc_hd__o221a_1
        3   26.275   sky130_fd_sc_hd__o221ai_1
        2   17.517   sky130_fd_sc_hd__o22a_1
       15    93.84   sky130_fd_sc_hd__o22ai_1
        3   26.275   sky130_fd_sc_hd__o2bb2ai_1
        2   20.019   sky130_fd_sc_hd__o311a_1
        3   26.275   sky130_fd_sc_hd__o311ai_0
        4   35.034   sky130_fd_sc_hd__o31a_1
       13   97.594   sky130_fd_sc_hd__o31ai_1
        3   26.275   sky130_fd_sc_hd__o32ai_1
        2   17.517   sky130_fd_sc_hd__o41ai_1
       12   75.072   sky130_fd_sc_hd__or3_1
        2   20.019   sky130_fd_sc_hd__or4b_1
      186 1.63E+03   sky130_fd_sc_hd__xnor2_1
       11  247.738   sky130_fd_sc_hd__xnor3_1
      143 1.25E+03   sky130_fd_sc_hd__xor2_1
        4   95.091   sky130_fd_sc_hd__xor3_1

   Chip area for module '\router_d6': 93608.528000
     of which used for sequential elements: 68485.683200 (73.16%)

Warnings: 1 unique messages, 1 total
```

## Provenance (sha256, this workstation)

| artefact | sha256 |
|---|---|
| `hexa-lang/comb/rtl/flat_v2k/router_d4.v` | `44200428d67f6e6b0cde78e82749733ee11db5e1f09a5587fae726a89e614876` |
| `hexa-lang/comb/rtl/flat_v2k/router_d6.v` | `e3362d5b5f1e65d85d13b4e802dad29c1ee0ea358c5f1b67ac8e205a192e2ad3` |
| `sky130_fd_sc_hd__tt_025C_1v80.lib` | `8e78e14442062dba34d414fca6490b2f6b96038d4510d1438ca44fee31487135` |
| d4 full yosys log (off-repo, `*.log` is gitignored) | `329409a4dad1dfc8ef5252b405e2afc4dfeaff77f71e2c647dba968c4d884fb4` |
| d6 full yosys log (off-repo, `*.log` is gitignored) | `31fbdddf9bff972c763c0758381b02572f766de8389437d8be6754ad07c9319c` |

Toolchain: `Yosys 0.65 (git sha1 aec814bdf3071f7e0fd0fbe43f7f711e99d01e24, clang++ 21.0.0 -fPIC -O3)`,
`hexa-lang` origin/main HEAD `4f70ce46`, host Darwin-arm64.

## Scope of this verdict (g3 honest framing)

- **Closed:** rfc_006 §5 **substrate** measurement gate — upstream
  yosys + SKY130 reproduces the cited oracle to <0.001 %.
- **Still open:** rfc_006 absorption gate — the hexa-native
  `stdlib/yosys/{read_verilog,passes,liberty,abc_map,write_verilog,yosys}`
  pipeline cannot yet ingest `comb/rtl/router_d{4,6}.v` directly. The
  2026-05-19 record's `read_verilog` SCOPE list (localparam,
  generate-for, always, function automatic, unpacked-array ports,
  signed arith, multi-D mem) remains the next pickup. **No claim of
  "Yosys absorbed" is made by this record.**
- **Still open:** SKY130 PDK ownership — the lib lives in `/tmp`,
  which is volatile. A permanent path under `~/.pdk/sky130A/` or
  similar (and a stable hex-arch PDK SSOT) is a separate substrate
  task.

## Cross-refs

- supersedes (in part): `exports/chip/yosys/2026-05-19-gate-§5-record.md`
  (OPEN → CLOSED for substrate; absorption still OPEN there)
- spec: `proposals/rfc_006_yosys_absorption.md` §2 oracle · §5 gate
  · §7 D18 ABC bounded-subprocess
- D-decisions: D15 · D17 · D18 · D19 (per 2026-05-19 record)
- pattern mirror: `stdlib/booksim/` (rfc_003 substrate-vs-absorption
  split — same g3 honest pattern)
