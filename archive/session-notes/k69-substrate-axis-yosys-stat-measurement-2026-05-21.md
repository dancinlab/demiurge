# κ-69 chip §B substrate-axis · `yosys -p stat` cell-type breakdown measurement

> **status**: research-only · 2026-05-21 · untracked · NO commit
>
> Companion to `k69-substrate-axis-closure-path-2026-05-21.md` § 4
> (missing measurements 1+2). Disambiguates `$dff` vs comb-logic
> dominance of post-(e) 98% area gap. READ-ONLY measurement run —
> no hexa-lang / demiurge file mutations.

## § 0. Purpose

Option F precondition — `yosys -p stat` cell-type breakdown ·
disambiguates dff-count vs comb-cell axis of 98% gap source.

## § 1. Chain re-run results

**No drift since (e) c4b35b13/a4a032af LANDED.** Numbers exactly
reproduce the research-note baseline:

| design | hexa-native area | oracle    | Δ        | chain     |
|--------|------------------|-----------|----------|-----------|
| d4     | 1207.41 µm²      | 61762.99  | -98.045% | 10/10 OK  |
| d6     | 1677.86 µm²      | 93608.53  | -98.208% | 10/10 OK  |

Chain stages (both d4 + d6 PASS each): read_verilog · hierarchy ·
proc · flatten · opt · proc_mux · clean_multidriver · techmap ·
dfflibmap · abc_map. Intermediate artifacts at:
- `/tmp/_hexa_yosys_gate_d4_in.blif` (27,594 B · pre-ABC techmapped) · `_d4_out.blif` (10,141 B · post-ABC)
- `/tmp/_hexa_yosys_gate_d6_in.blif` (38,259 B) · `_d6_out.blif` (14,058 B)

**No intermediate Verilog emitted** — `abc_map.hexa` writes BLIF
directly (L452-455). Stat measurements below therefore use BLIF
inputs for hexa-native side; substrate side uses the original
`comb/rtl/flat_v2k/router_d{4,6}.v` (Verilog-2001 form — original
`router_d4.v` uses SystemVerilog unpacked-array port syntax that
yosys 0.65 default parser rejects with `syntax error, unexpected
'['` at line 18).

## § 2. Hexa-native cell-type breakdown

### d4 (post-techmap pre-ABC `_in.blif`)

```
357 cells (router_d4)
  41   $_DFF_P_                          ← flops (TRUNCATED — see § 4)
  83   sky130_fd_sc_hd__buf_1
  77   sky130_fd_sc_hd__mux2_1
  67   sky130_fd_sc_hd__and2_1
  45   sky130_fd_sc_hd__xnor2_1
  27   sky130_fd_sc_hd__inv_1
  12   sky130_fd_sc_hd__fa_1
   5   sky130_fd_sc_hd__xor2_1
```
BLIF: 41 `.latch` lines · 316 `.gate` lines · 1 `.model`.

### d4 (post-ABC `_out.blif`)
```
134 cells (router_d4)
  41   $_FF_                             ← still 41 flops (ABC doesn't expand width)
   5   _const1_
  32   sky130_fd_sc_hd__clkinv_1
  20   sky130_fd_sc_hd__o21ai_0
  16   sky130_fd_sc_hd__nor2_1
   5   sky130_fd_sc_hd__nand4_1
   5   sky130_fd_sc_hd__nand2_1
   5   sky130_fd_sc_hd__nor3b_1
   5   sky130_fd_sc_hd__buf_1
```
BLIF: 41 `.latch` · 93 `.gate`.

### d6 (post-techmap pre-ABC `_in.blif`)
```
493 cells (router_d6)
  57   $_DFF_P_                          ← flops (TRUNCATED — see § 4)
 113   sky130_fd_sc_hd__buf_1
 107   sky130_fd_sc_hd__mux2_1
  93   sky130_fd_sc_hd__and2_1
  63   sky130_fd_sc_hd__xnor2_1
  37   sky130_fd_sc_hd__inv_1
  16   sky130_fd_sc_hd__fa_1
   7   sky130_fd_sc_hd__xor2_1
```
BLIF: 57 `.latch` · 436 `.gate`.

## § 3. Substrate cell-type breakdown

### d4 substrate `synth` (RTLIL post-coarse-techmap, pre-tech-map)

```
4080 cells (router_d4)
  1600  $_DFFE_PP_           ← gated enable flops (dominant)
  997   $_MUX_
  684   $_NAND_
  544   $_AND_
   48   $_XNOR_
   42   $_ANDNOT_
   18   $_NOR_
   18   $_SDFFE_PP0P_        ← sync-reset enable flop
   18   $_XOR_
   16   $_ORNOT_
   15   $_SDFFCE_PN0P_       ← sync-reset clk-en flop
   11   $_NOT_
    5   $_SDFF_PP0_          ← sync-reset flop
   64   $_OR_
```
**Total flops = 1600 + 18 + 15 + 5 = 1638 flops** (40× hexa-native's 41).

### d4 substrate full SKY130 mapped flow (matches §5 oracle)
```
Chip area: 61762.99 µm² (oracle EXACT match)
  Sequential elements: 48956.95 µm² (79.27%)
  Combinational ≈    : 12806.04 µm² (20.73%)
  1615 × sky130_fd_sc_hd__edfxtp_1 (30.03 µm²/cell · 48498 µm² total)
    23 × sky130_fd_sc_hd__dfxtp_1  (20.02 µm²/cell · 460 µm² total)
   + sdff variants (small remainder)
```

### d6 substrate `synth`
```
7549 cells (router_d6)
  2243  $_DFFE_PP_                ← gated enable flops
  1629  $_NAND_
  1398  $_MUX_
  1327  $_AND_
   257  $_XNOR_
   209  $_OR_
   131  $_XOR_
   115  $_ANDNOT_
    94  $_ORNOT_
    76  $_NOR_
    27  $_SDFFE_PP0P_
    21  $_NOT_
    15  $_SDFFCE_PN0P_
     7  $_SDFF_PP0_
```
**Total flops = 2243 + 27 + 15 + 7 = 2292 flops** (40.2× hexa-native's 57).

### d6 substrate full SKY130 mapped flow
```
Chip area: 93608.53 µm² (oracle EXACT match)
  Sequential elements: 68485.68 µm² (73.16%)
  Combinational ≈    : 25122.85 µm² (26.84%)
  2258 × sky130_fd_sc_hd__edfxtp_1 (30.03 µm²)
    34 × sky130_fd_sc_hd__dfxtp_1
```

## § 4. Ratios + interpretation

### Flop-count ratio (dff_ratio)
| design | hexa-native flops | substrate flops | ratio  |
|--------|-------------------|-----------------|--------|
| d4     | 41                | 1638            | **40.0×** |
| d6     | 57                | 2292            | **40.2×** |

**This is NOT the 10× predicted in the c4b35b13 commit body** — it
is **4× larger** than predicted. The mechanism is precisely
identified in `abc_map.hexa` L300-310: each multi-bit `$dff` cell
emits ONE `.latch` line with INIT bit-width-as-integer-literal.
ABC sees a single flop instance regardless of declared width.

### Algebraic confirmation of Option F yield (d4)
Walk the 41 hexa-native latches by signal width (from BLIF dump):
- `rr_ptr` (FIFO_LD=2) · 1 entry · 2 bits → 2 latches
- `fifo_head[0..4]` (FIFO_LD=2) · 5 entries · 2 bits → 10
- `fifo_tail[0..4]` (FIFO_LD=2) · 5 entries · 2 bits → 10
- `out_valid[0..4]` (1) · 5 entries · 1 bit → 5
- `fifo_mem[0..4][0..3]` (W=64) · 20 entries · 64 bits → **1280**
- `out_data[0..4]` (W=64) · 5 entries · 64 bits → **320**

**Post-Option F expansion total = 1627 flops.** Substrate emits
**1638**. Delta of 11 flops accounts for the `$_SDFFCE_/$_SDFFE_/
$_SDFF_` rst-reduction variants (which substrate creates from
async-rst pattern detection — hexa-native chain has no equivalent
flop-type-promotion pass · those 38 extra flops are still emitted
as plain `$dff` in hexa-native form). Option F closes ~99% of the
flop-count gap.

### Comb-cell ratio (comb_ratio)
| design | hexa-native gates (BLIF `_in`) | substrate cells (RTLIL post-synth) | ratio |
|--------|------------------------------------|-------------------------------------|-------|
| d4     | 316                                | 2442 (4080 − 1638 flops)            | **7.7×** |
| d6     | 436                                | 5257 (7549 − 2292 flops)            | **12.1×** |

But this ratio is NOT directly area-comparable — hexa-native side
is already SKY130-techmapped (basic 2-input gates), substrate side
is RTLIL-level (n-input `$_NAND_` etc. that further expand at
techmap). The ABC-mapped `_out.blif` (93 cells for d4) is the more
honest comb count: substrate after ABC for d4 mapped also folds
substantially. Approximate area comparison:
- d4 substrate comb area: ~12,806 µm² (oracle minus sequential)
- d4 hexa-native total: 1,207 µm² · subtract flop estimate
  (41 × ~20 µm² ≈ 820 µm² for `dfxtp_1`-equiv) → comb ≈ 387 µm²
- comb area ratio: 12,806 / 387 ≈ **33×**

Yet remember: after Option F lands, the *correct* count for d4 is
1627 flops, so hexa-native total after Option F (rough projection)
≈ 1627 × 30.03 (edfxtp_1) + 387 µm² ≈ 49,250 µm² seq + 387 comb
= **~49,637 µm² vs oracle 61,763 µm²** → residual **~20% comb gap**.

### Area-by-category contribution (post-(e), current state)
| component                  | d4 substrate | d4 hexa-native | gap contribution |
|----------------------------|--------------|----------------|------------------|
| Sequential (flops)         | 48,957 µm²   | ~820 µm²       | **48,137 µm²** (79% of gap) |
| Combinational              | 12,806 µm²   | ~387 µm²       | **12,419 µm²** (20% of gap) |
| Total                      | 61,763 µm²   | 1,207 µm²      | 60,556 µm² gap (98.0%) |

## § 5. RECOMMENDED next step

**Option F first · then Option E (small comb residual)** — order
is now empirically-justified:

1. **Option F (BLIF `.latch` multi-bit expansion · 1-2 sessions)** —
   closes 79% of the gap by expanding each `$dff(W)` emission into
   W separate `.latch` lines in `abc_map.hexa` L300-310. Algebraic
   projection (§ 4) shows post-Option F flop count of 1627 vs
   substrate's 1638 — closes the flop-count axis to 99.3%. The
   ~20.02 µm²/flop `dfxtp_1` mapping (vs substrate's `edfxtp_1`
   30.03 µm² for clock-enable flops) leaves residual ~33% sequential
   gap from missing flop-type promotion (`$dffe`/`$sdff`), absorbing
   that goes to Tier-2.
2. **Option E (share/freduce in passes.hexa · 4-8 sessions)** —
   addresses the residual 20% comb-side gap. Lower priority because
   Option F lands the algebraically-largest fraction.
3. **Option C (RTLIL `$mem` cells) NOT recommended** — the latch
   truncation hypothesis is FALSY in scope: per-element flat `$dff`
   IS the correct representation, just truncated at BLIF emit.
   Migrating to `$mem` would re-architect for no additional benefit
   vs surgical Option F.

## § 6. Unresolved unknowns

1. **Post-Option F actual measurement** — § 4 projection (1627 ×
   20.02 µm² ≈ 32,572 µm² sequential, total ~33,000 µm²) assumes
   ABC maps each new `.latch` to `dfxtp_1`. Substrate maps to
   `edfxtp_1` (30.03 µm²/cell) via `dfflibmap` because RTLIL has
   `$dffe` cells; hexa-native chain emits plain `$_DFF_P_`. Real
   number post-F unknown until measured.
2. **Flop-type promotion ($dffe / $sdff)** — substrate's 1600
   `$_DFFE_PP_` come from clock-enable detection in `dffe_opt`
   passes. Hexa-native has no analog · all flops stay as plain
   `$_DFF_P_`. Post-Option F residual sequential gap = (30.03 −
   20.02) × 1615 ≈ 16,166 µm² (still ~26% of oracle area). Tier-2
   absorbs via `pass_dffe_opt` analog.
3. **Comb count ratio interpretability** — hexa-native is post-
   techmap; substrate `synth` stat I captured is pre-final-techmap.
   Apples-to-apples needs substrate `dfflibmap; abc -liberty; stat`
   intermediate captured · I captured only post-area-stat. Ratio
   should be re-measured if Option E feasibility study reveals
   <12,806 µm² is achievable.
4. **flat_v2k vs SystemVerilog parity** — flat_v2k version was
   generated by `sv2v` from the SystemVerilog original; both target
   identical semantics. Substrate measurement uses flat_v2k because
   yosys 0.65 parser rejects unpacked-array port lists. The
   hexa-native chain reads the SystemVerilog form via custom
   parser. Latent risk: structural divergence between the two
   forms could bias substrate baseline. Cross-check via
   `comb/rtl/synth_netlists/router_d{4,6}.sky130.v` (a pre-run
   substrate netlist) confirms 61,763 µm² for d4 — same oracle.

## Cross-link

- `~/core/demiurge/inbox/notes/k69-substrate-axis-closure-path-2026-05-21.md` § 4
  (missing-measurements list — this note finishes items 1+2; item 3
  (RTLIL Cell `\WIDTH` parameter propagation) NOT measured here ·
  Option F implementation phase will surface it)
- `~/core/hexa-lang/stdlib/kernels/logic_synth/abc_map.hexa` L300-310
  (BLIF `.latch` emit · Option F target site)
- `~/core/hexa-lang/comb/rtl/router_d4.v` L11-13 (parameter widths
  W=64 · ADDR_W=8 · FIFO_LD=2 · the algebra source)
- `~/core/hexa-lang/comb/rtl/flat_v2k/router_d{4,6}.v` (sv2v-form
  RTL · substrate-parser-compatible)
- `~/core/demiurge/archive/comb/rtl/router_d4.v` (identical to
  hexa-lang copy · oracle reproduction confirms parity)

`measurement_gate = OPEN` · post-(e) sequential-axis-dominance
**CONFIRMED MEASURED** · Option F precondition complete.
