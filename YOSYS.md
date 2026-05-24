# YOSYS — RTL→netlist synthesis absorption (rfc_006 spec)

> **Status**: program-in-progress · §5 gate `OPEN` · `absorbed=false` —
> no "Yosys absorbed" claim until §5 measurement passes (g3, HANDOFF §4,
> AGENTS.tape D15).
>
> opened: 2026-05-18 (as `proposals/rfc_006_yosys_absorption.md`) ·
> root-promoted: 2026-05-22 (this file = canonical spec; historical
> campaign log = [`./YOSYS.log.md`](./YOSYS.log.md))
>
> parent: demiurge · implementation home: `hexa-lang/stdlib/yosys/` (D15) ·
> reference RTL+oracle: `archive/comb/rtl/`

This document is the **canonical spec** for clean-room re-derivation of
the minimal Yosys subset that takes synthesizable Verilog RTL → SKY130
gate-level netlist. It is the SYNTHESIZE-verb tool for the chip domain
(rfc_004 §5 Phase 2; HANDOFF §4/§5).

---

## §1. Purpose

Clean-room re-derive the **minimal Yosys subset** that takes
synthesizable Verilog RTL → a SKY130 gate-level netlist — the
**SYNTHESIZE**-verb tool for the chip domain, the EDA-pipeline stage
immediately after the NoC-sim (rfc_001/003).

Pattern mirror: rfc_003 (BookSim2 clean-room re-derivation, 6 modules +
self-tests). rfc_005 was hexa-matter (SUPERSEDED by D17); rfc_006 is the
first comb-stack EDA-tool absorption.

## §2. Parity target — comb's measured oracle (g3, pre-measured)

comb's T3 work produced the exact reference this absorption must
reproduce. No fabrication — these are real measured numbers:

- **RTL**: `archive/comb/rtl/orfs/sky130hd/router_d{4,6}/router_d{4,6}.v`
- **Yosys-produced netlists**: `archive/comb/rtl/synth_netlists/
  router_d{4,6}.sky130.v`
- **Measured SKY130 area** (comb yosys+abc):
  - router_d4 = **61,762.99 µm²**
  - router_d6 = **93,608.53 µm²**
  - **ratio 1.5156×** — the `router_port_area_norm = 1.516` used in every
    F1F2 record (HANDOFF §4 oracle)

This is the §5 measurement-gate target.

## §3. Clean-room scope (public-surface, D1)

Yosys = `github.com/YosysHQ/yosys` (ISC license, OSS — public-surface OK;
cite commit + license; no code copied — re-derive by inspection).
Minimal RTL → sky130-netlist flow only (NOT all of Yosys):

```
read_verilog  → proc → opt → memory → techmap → dfflibmap
              → abc(-liberty sky130_fd_sc_hd) → opt_clean → write_verilog
```

Everything outside that path (formal verification, SAT, FPGA backends,
the full RTLIL pass library) is out of scope.

## §4. Module breakdown (hexa-native → `hexa-lang/stdlib/yosys/`, D15)

Per D15, modules live in hexa-lang/stdlib; this spec lives in demiurge;
demiurge references as consumer.

| module | re-derives (clean-room, cited) |
|---|---|
| `rtlil.hexa` | the RTLIL in-memory IR (modules/cells/wires) |
| `read_verilog.hexa` | synthesizable-subset Verilog frontend → RTLIL |
| `passes.hexa` | proc · opt · memory · techmap · dfflibmap · opt_clean |
| `liberty.hexa` | SKY130 `sky130_fd_sc_hd` `.lib` parse (cell areas/timing) |
| `abc_map.hexa` | tech-mapping to liberty cells (see §7, the hard part) |
| `write_verilog.hexa` | RTLIL → gate-level Verilog netlist |
| `yosys.hexa` | dispatcher (rfc_048 idiom; hexa-lang toolchain limits: no `match`, enum-eq broken, no tuples — int/struct idioms) |
| `gate_record.hexa` | orchestrator + §5 measurement gate runner |

Each module: `#!hexa strict`, top clean-room provenance block, per-fn
`// CLEAN-ROOM` markers, `fn main()` self-test, `exit(91)` fail-loud
(rfc_003 established idiom).

## §5. Measurement gate — when "absorbed" may be claimed

`absorbed` flips ONLY when, under the hexa-lang/stdlib/yosys tree:

- the flow synthesizes `comb router_d4.v` + `router_d6.v` against
  SKY130 `sky130_fd_sc_hd`, and
- the resulting **cell area reproduces comb's oracle within stated
  tolerance** — d4 ≈ 61,763 µm², d6 ≈ 93,609 µm², **ratio
  1.516× ± 5 %**, and
- filed in `PLAN.md` with cited numbers.

Until then: program-in-progress, GATE-style (rfc_003 idiom). No line
may say "Yosys absorbed" before this gate.

Gate-target windows:
- router_d4: area ∈ **[58,675, 64,851] µm²** (±5 %)
- router_d6: area ∈ **[88,928, 98,289] µm²** (±5 %)

## §6. Location / consumer

Modules → `hexa-lang/stdlib/yosys/` (D15, hexa-lang commit, unpushed
pending hexa-lang review — booksim/d5a63a82 precedent). demiurge
references it as the chip-domain SYNTHESIZE tool; this RFC is the design
only.

> **D19 — implementation session boundary.** The §4 modules + self-tests
> + §5 oracle verification are implemented in a **hexa-lang session**
> (modules live in hexa-lang's tree per D15; review+push authority
> co-located with ownership; avoids stacking a 3rd review on hexa-lang's
> pending `d5a63a82`/`61866308`). This spec §4/§5 *is* the spec that
> session works against. demiurge's deliverable = design + D18/D19
> (committed, whole). See `design.md` D19.

## §7. The hard part — ABC tech-mapping (D18 resolved)

Yosys shells out to **ABC** (Berkeley logic-synthesis, also OSS) for the
actual technology mapping (`abc -liberty`). Clean-room re-derivation of
ABC's mapping/optimization is a *very large* program (≫ rfc_003).

> **D18 RESOLVED 2026-05-18 → (7a) bounded-subprocess.** The Yosys flow
> is re-derived hexa-native; **ABC is invoked as a documented
> absorbed-substrate subprocess, fail-loud** (rfc_048/D14 hybrid g5
> exception, AGENTS.tape `g_hexa_native`-sanctioned). Reproduces the §2
> oracle now; per-pass ABC re-derivation = scheduled follow-on. "Yosys
> absorbed" remains gated by §5 (not asserted here — g3). Rejected: (7b)
> full ABC re-derivation now (≫10× rfc_003, would stall all of Phase 2
> behind one engine). See `design.md` D18.

- **(7a) bounded-subprocess** ✅ PICKED — re-derive the Yosys flow
  hexa-native but invoke ABC as a documented absorbed-substrate
  subprocess, fail-loud (rfc_048/D14 precedent, bounded g5 exception).
  Reproduces the oracle now; ABC re-derivation = scheduled follow-on.
- **(7b) full ABC re-derivation now** — rejected (months, rate-limit-prone,
  stalls Phase 2 on one engine).

Other open: SKY130 `.lib` parse scope; synthesizable-subset coverage of
`read_verilog` (router_d{4,6}.v is small/clean — scope to what it needs
first).

## §8. Current snapshot — 2026-05-22 KST (g3-honest)

> **Status remains §5 OPEN — no `Yosys absorbed` claim.** Significant
> measured progression across multi-session campaign. Gate-flip
> conditions (§5) NOT yet met.

### §4 modules — all 7 land-CLOSED

`rtlil.hexa` · `read_verilog.hexa` · `passes.hexa` · `liberty.hexa` ·
`abc_map.hexa` · `write_verilog.hexa` · `gate_record.hexa` — all live
on `hexa-lang/stdlib/yosys/`.

Selftest cumulative: read_verilog 87/87 · passes 49/49 · abc_map 12/12
· rtlil 11/11 · liberty 8/8 — **ALL PASS, 0 regressions**.

### §5 best measured (router_d4, oracle = 61,762.99 µm²)

| metric | value |
|---|---|
| best d4 area (post abc dedup + multi-bit `$eq` + SSA width) | **55,546 µm²** |
| Δ vs oracle | **10.07 %** |
| gap to ±5 % gate window | **3,208 µm²** |
| cumulative (campaign start 559 → 55,546) | **99.4× area, 89.0 pp Δ reduction** |

### §5 d6 (oracle = 93,608.53 µm²)

- last validated: 68,696 µm² (Δ 26.61 %) post Piece-1 era
- d6 measurement infrastructure unblocked by `pass_cut_and_remap`
  O(n³) → O(n) hashmap (commit `7691133b`) + `_passes_fuse_complex_cells`
  index (`6a5cadb6`) — memory 19 GB → 256 MB on mini
- substrate yosys 0.33 reference on ubu-2: **98,247.98 µm²**
  (`comb/rtl/flat_v2k/router_d6.v` sv2v-flat, d6/d4 ratio = 1.528;
  cited 1.5156 differs +0.8 % due to packing/abc-script recipe)

### Substrate infrastructure (PR #297 / #322 follow-ons)

ubu-2 x86_64 Linux self-host substantially unblocked (5 layer fixes):
1. `hexa_pipe_buf_enlarge_kernel` fake-FILE* `fileno` decode (parse)
2. `pthread_t → void*` cast for Linux glibc (outer build)
3. Linux `-Wl,--allow-multiple-definition` (link)
4. retired-shim bridge (`hexa_read_file`/`str_trim`/`write_file`) for
   stale dist hexa_v2 transpiler (April 2026)
5. `HEXA_MEM_CAP_MB=0` on Linux module_loader spawn (flatten unblock)

Result: ubu-2 runs the full §5 d4 hexa-native pipeline end-to-end through
`dfflibmap_sky130`. Final ABC `read_blif` fails on multi-output
`sky130_fd_sc_hd__fa_1` cell — substrate ABC version drift (ubu-2
yosys-abc 0.65 stricter than mini standalone abc).

### Outstanding work to flip §5 gate

1. **Measurement-host regression (post T79c, 2026-05-22)**: `gate_record`
   process on mini (16 GB physical) jetsam-killed at ~50 GB compressed
   VM, before reaching `:techmap`. Suspected OOM site:
   `pass_clean_multidriver` accumulation. **mini cannot remeasure the
   integration branch HEAD until profiled/fixed.**
2. **ubu-2 Linux x86_64 cross-build**: self-host substrate landed (above)
   but `hexa_cli_driver` still arm64 Mach-O. A Linux ELF
   `hexa_cli_driver` must be cross-built on ubu-2 (separate cycle) to
   make it a usable §5 measurement host post-T79c.
3. **Post-host-recovery work**:
   - Profile `pass_clean_multidriver` (O(n²) → O(n) accumulation
     candidate, mirroring `pass_cut_and_remap` `7691133b` fix)
   - Re-measure §5 d4 + d6 on a working host
   - read_verilog comb-always SSA for-body dyn-idx READ lowering
   - ABC `fa_1` multi-output `.gate` emit split (yosys-abc 0.65 compat)
4. **On §5 d4 + d6 ±5 % PASS** (gate flip):
   `gate_record.hexa` verdict → `Yosys absorbed=true`, this doc §8 flip,
   `hexa-lang/compiler/PLAN.md` §5 status flip.

## §9. What is NOT done (g3 honesty)

Per HANDOFF §4 + AGENTS.tape D15: Δ 10.07 % is measured-pass-fail, NOT
"almost there" hand-waving. The remaining 5 pp gap is fully cited, fully
reproducible, and **the line "Yosys absorbed" will not appear in this
repository or any downstream until the §5 gate measurement records
PASS.**

Multi-session campaign work is logged in `hexa-lang/inbox/notes/` +
demiurge `archive/session-notes/` + [`./YOSYS.log.md`](./YOSYS.log.md).

## §10. Cross-references

- `design.md` D15 (stdlib ⊂ hexa-lang) · D18 (bounded-subprocess) ·
  D19 (implementation session boundary)
- `proposals/rfc_004` §5 (Phase 2 plan) — original rfc_006 context
- `rfc_001` / `rfc_003` — NoC-sim absorption + clean-room idiom
- `rfc_048` — bounded-subprocess precedent
- `archive/comb/rtl/` — RTL + netlist + oracle (the §2 measurement)
- `HANDOFF.md` §4/§5 — cohort owner roles, oracle citation
- `ARCH.md` §12.1 — measurement-host regression log (rfc006-s5-area-
  oracle-parity-handoff inbox note, 1754-line detail SSOT)
- `archive/session-notes/rfc006-s5-area-oracle-parity-handoff.md` — entry-by-entry
  measurement-fact + cycle log (load-bearing detail SSOT)
- `archive/session-notes/k69-substrate-axis-yosys-stat-measurement-2026-05-21.md`
  — yosys -p stat substrate-axis measurement note
- `hexa-lang/stdlib/yosys/` — implementation home

---

Historical campaign log (multi-session §5 progression, host failures,
substrate infra fixes) is in [`./YOSYS.log.md`](./YOSYS.log.md).
