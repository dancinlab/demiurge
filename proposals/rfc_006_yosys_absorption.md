# RFC 006 — Yosys absorption (RTL→netlist synthesis)

> Status: **draft / design only — NOT complete** · 2026-05-18 ·
> Source: rfc_004 §5 Phase 2 + `design.md` D15 (modules ⊂ hexa-lang/
> stdlib) + g3 (measured gate, never asserted). Pattern mirror:
> rfc_003 (BookSim2 clean-room re-derivation, 6 modules + self-tests).
> rfc_005 was hexa-matter (SUPERSEDED by D17); rfc_006 = first
> comb-stack EDA-tool absorption.

---

## 1. Purpose

Clean-room re-derive the **minimal Yosys subset** that takes
synthesizable Verilog RTL → a SKY130 gate-level netlist — the
**SYNTHESIZE**-verb tool for the chip domain (HANDOFF §4/§5), the
EDA-pipeline stage immediately after the NoC-sim (rfc_001/003).

## 2. Why now / parity target already exists

comb's T3 work already produced the exact reference this absorption
must reproduce (g3 — a real pre-measured oracle, no fabrication):

- RTL: `archive/comb/rtl/orfs/sky130hd/router_d{4,6}/router_d{4,6}.v`
- Yosys-produced netlists: `archive/comb/rtl/synth_netlists/
  router_d{4,6}.sky130.v`
- Measured SKY130 area (comb yosys+abc): d4 = **61,762.99 µm²**,
  d6 = **93,608.53 µm²** → ratio **1.5156×** (HANDOFF §4 oracle;
  also the `router_port_area_norm = 1.516` used in every F1F2
  record). **This is the §5 measurement-gate target.**

## 3. Clean-room scope (public-surface, D1)

Yosys = `github.com/YosysHQ/yosys` (ISC license, OSS — public-surface
OK; cite commit + license; no code copied — re-derive by inspection).
Minimal RTL→sky130-netlist flow only (NOT all of Yosys):

```
read_verilog  → proc → opt → memory → techmap → dfflibmap
              → abc(-liberty sky130_fd_sc_hd) → opt_clean → write_verilog
```

Everything outside that path (formal, SAT, FPGA backends, the full
RTLIL pass library) is out of scope.

## 4. Module breakdown (hexa-native → `hexa-lang/stdlib/yosys/`, D15)

Per D15 the modules live in hexa-lang/stdlib; this RFC (design) lives
in demiurge/proposals; demiurge references as consumer.

| module | re-derives (clean-room, cited) |
|---|---|
| `rtlil.hexa` | the RTLIL in-memory IR (modules/cells/wires) |
| `read_verilog.hexa` | synthesizable-subset Verilog frontend → RTLIL |
| `passes.hexa` | proc · opt · memory · techmap · dfflibmap · opt_clean |
| `liberty.hexa` | SKY130 `sky130_fd_sc_hd` `.lib` parse (cell areas/timing) |
| `abc_map.hexa` | tech-mapping to the liberty cells — **see §7, the hard part** |
| `write_verilog.hexa` | RTLIL → gate-level Verilog netlist |
| `yosys.hexa` | dispatcher (rfc_048 idiom; hexa-lang toolchain limits: no `match`, enum-eq broken, no tuples — int/struct idioms) |

Each module: `#!hexa strict`, top clean-room provenance block, per-fn
`// CLEAN-ROOM` markers, `fn main()` self-test, `exit(91)` fail-loud
(rfc_003 established idiom).

## 5. g3 measurement gate — when "absorbed" may be claimed

`absorbed` flips ONLY when, under the hexa-lang/stdlib/yosys tree:

- the flow synthesizes `comb router_d4.v` + `router_d6.v` against
  SKY130 `sky130_fd_sc_hd`, and
- the resulting **cell area reproduces comb's oracle within stated
  tolerance** — d4 ≈ 61,763 µm², d6 ≈ 93,609 µm², **ratio
  1.516× ± (tolerance TBD, propose ±5 %)**, and
- filed in `PLAN.md` with cited numbers.

Until then: program-in-progress, GATE-style (rfc_003 idiom). No line
may say "Yosys absorbed" before this gate.

## 6. Location / consumer

Modules → `hexa-lang/stdlib/yosys/` (D15, hexa-lang commit, unpushed
pending hexa-lang review — booksim/d5a63a82 precedent). demiurge
references it as the chip-domain SYNTHESIZE tool; this RFC is the
design only.

> **D19 — implementation session boundary.** The §4 modules +
> self-tests + §5 oracle verification are implemented in a
> **hexa-lang session** (modules live in hexa-lang's tree per D15;
> review+push authority co-located with ownership; avoids stacking
> a 3rd review on hexa-lang's pending `d5a63a82`/`61866308`). This
> RFC §4/§5 *is* the spec that session works against. demiurge's
> deliverable = design + D18/D19 (committed, whole). See
> `design.md` D19.

## 7. The hard part — ABC tech-mapping (honest, g3)

Yosys shells out to **ABC** (Berkeley logic-synthesis, also OSS) for
the actual technology mapping (`abc -liberty`). Clean-room
re-derivation of ABC's mapping/optimization is a *very large*
program (≫ rfc_003).

> **D18 RESOLVED 2026-05-18 → (7a) bounded-subprocess.** The Yosys
> flow is re-derived hexa-native; **ABC is invoked as a documented
> absorbed-substrate subprocess, fail-loud** (rfc_048/D14 hybrid g5
> exception, AGENTS.tape `g_hexa_native`-sanctioned). Reproduces the
> §2 oracle now; per-pass ABC re-derivation = scheduled follow-on.
> "Yosys absorbed" remains gated by §5 (not asserted here — g3).
> Rejected: (7b) full ABC re-derivation now (≫10× rfc_003, would
> stall all of Phase 2 behind one engine). See `design.md` D18.

- **(7a) bounded-subprocess** ✅ PICKED — re-derive the Yosys flow
  hexa-native but invoke ABC as a documented absorbed-substrate
  subprocess, fail-loud (rfc_048/D14 precedent, bounded g5
  exception). Reproduces the oracle now; ABC re-derivation =
  scheduled follow-on.
- **(7b) full ABC re-derivation now** — rejected (months,
  rate-limit-prone, stalls Phase 2 on one engine).

Other open: SKY130 `.lib` parse scope; synthesizable-subset coverage
of `read_verilog` (router_d{4,6}.v is small/clean — scope to what it
needs first).

## 8. What is NOT done (g3 honesty)

No modules written; nothing synthesized; no "Yosys absorbed" claim.
This RFC is **design only**. The clean-room modules are subsequent
rate-limit-safe scoped work (rfc_003 pattern), gated by §5.

## 9. Cross-references

`design.md` D15 (stdlib⊂hexa-lang) · rfc_004 §5 (Phase 2 plan) ·
rfc_001/003 (NoC-sim absorption + clean-room idiom) · rfc_048
(bounded-subprocess precedent) · `archive/comb/rtl/` (RTL + netlist +
oracle) · HANDOFF §4/§5.

---

## 10. Status — 2026-05-22 progress snapshot (g3-honest)

> **Status remains §5 OPEN — no `Yosys absorbed` claim.** Significant
> measured progression across multi-session campaign. Gate flip
> conditions (§5) NOT yet met.

### §4 modules — all 7 land-CLOSED on hexa-lang/stdlib/yosys/
- `rtlil.hexa` · `read_verilog.hexa` · `passes.hexa` · `liberty.hexa`
  · `abc_map.hexa` · `write_verilog.hexa` · `gate_record.hexa`
  (orchestrator + §5 measurement gate runner)
- Selftest cumulative: read_verilog 87/87 · passes 49/49 · abc_map
  12/12 · rtlil 11/11 · liberty 8/8 — **ALL PASS, 0 regressions**.

### §5 measurement progression (router_d4, oracle = 61,762.99 µm²)

| stage | d4 area (µm²) | Δ vs oracle | gap to ±5 % |
|-------|--------------:|-------------:|-------------:|
| campaign start (pre-Option-A) | 559 | 99.10 % | n/a |
| Option A+I (2-D LHS demux + BLIF per-bit `.latch`) | 32,829 | 46.85 % | n/a |
| per-bit connect buffer | 45,492 | 26.34 % | n/a |
| Piece 1 (`$dffe` + `edfxtp_1`) | 49,092 | 20.52 % | n/a |
| Path-a richer elab | 50,256 | 18.63 % | n/a |
| `.inputs/.outputs` per-bit shadow | 55,060 | 10.85 % | 3,694 |
| abc dedup + multi-bit `$eq` + SSA width | **55,546** | **10.07 %** | **3,208** |
| T79c post-paren bracket-select (post route_xy) | — pending measurement — | — | — |

**Cumulative: 559 → 55,546 µm² (99.4× area, Δ 99.10 % → 10.07 %, 89.0 pp
reduction).** §5 ±5 % gate target [58,754 ; 64,939] still **OPEN**.

### §5 d6 (oracle = 93,608.53 µm², ratio 1.5156× ± 5 %)
- last validated: 68,696 µm² (Δ 26.61 %) post Piece-1 era
- d6 measurement infrastructure unblocked by `pass_cut_and_remap`
  O(n³) → O(n) hashmap (commit `7691133b`) + `_passes_fuse_complex_
  cells` index (`6a5cadb6`) — memory 19 GB → 256 MB on mini
- post route_xy + perf measurement pending (mini back online
  2026-05-22 20:07 after 7+h crash)
- substrate yosys 0.33 reference on ubu-2: **98,247.98 µm²**
  (`comb/rtl/flat_v2k/router_d6.v` sv2v-flat, d6/d4 ratio = 1.528;
  cited 1.5156 differs +0.8 % due to packing/abc-script recipe)

### Substrate infrastructure (PR #297 follow-on, this campaign)
ubu-2 x86_64 Linux self-host substantially unblocked (5 layer fixes,
on PR #322 alongside §5 work):
1. `hexa_pipe_buf_enlarge_kernel` fake-FILE* `fileno` decode (parse)
2. `pthread_t → void*` cast for Linux glibc (outer build)
3. Linux `-Wl,--allow-multiple-definition` (link)
4. retired-shim bridge (`hexa_read_file`/`str_trim`/`write_file`) for
   stale dist hexa_v2 transpiler (April 2026)
5. `HEXA_MEM_CAP_MB=0` on Linux module_loader spawn (flatten unblock)

Result: ubu-2 runs the full §5 d4 hexa-native pipeline end-to-end
through `dfflibmap_sky130`. Final ABC `read_blif` fails on multi-
output `sky130_fd_sc_hd__fa_1` cell — substrate ABC version drift
(ubu-2 yosys-abc 0.65 stricter than mini standalone abc).

### Outstanding work to flip §5 gate
1. **Measurement-host regression after T79c (2026-05-22)**:
   `gate_record` process on mini (16 GB physical) jetsam-killed at
   ~50 GB compressed VM, before reaching `:techmap`. Kernel evidence
   from 5 kills in 10 min (`memorystatus: killing largest compressed
   process … 49,818 MB`). Selftest 87/87 PASS — frontend integrity
   intact; the route_xy inline (`80839dd7`) + T79c post-paren
   bracket-select (`7f2d897e`) expanded the SSA / multi-driver graph
   beyond mini's headroom. Suspected OOM site:
   `pass_clean_multidriver` accumulation (`pass_proc_mux` →
   `pass_clean_multidriver` window). **mini cannot remeasure the
   integration branch HEAD until this is profiled/fixed.**
2. **ubu-2 Linux x86_64 host** (30 GB + 39 GB swap): self-host
   substrate landed (§10 Substrate above) but the build/ tree still
   holds **arm64 Mach-O** `hexa_cli_driver`. A Linux ELF
   `hexa_cli_driver` must be cross-built on ubu-2 (separate cycle)
   to make ubu-2 a usable §5 measurement host post-T79c. Pipeline
   reaches `dfflibmap` on ubu-2 today; ABC `fa_1` multi-output
   strict-parse remains the residual cross-host blocker.
3. **Post-host-recovery work**:
   - Profile `pass_clean_multidriver` (O(n²) → O(n) accumulation
     candidate, mirroring `pass_cut_and_remap` `7691133b` fix)
   - Re-measure §5 d4 + d6 on a working host
   - read_verilog comb-always SSA for-body dyn-idx READ lowering
     (out_ready[grant_out] mux explicit fire) **if** T79c +
     post-paren didn't close it
   - ABC `fa_1` multi-output `.gate` emit split (yosys-abc 0.65
     compat, ubu-2 cross-host parity)
4. **On §5 d4 + d6 ±5 % PASS** (gate flip):
   `gate_record.hexa` verdict → `Yosys absorbed=true`, this doc §10
   flip, `hexa-lang/compiler/PLAN.md` §5 status flip.

> **g3 honesty (per HANDOFF §4 + AGENTS.tape D15):** Δ 10.07 % is
> measured-pass-fail, NOT "almost there" hand-waving. The remaining
> 5 pp is fully cited, fully reproducible, and **the line "Yosys
> absorbed" will not appear in this repository or any downstream
> until the §5 gate measurement records PASS.** Multi-session
> campaign work is logged in `hexa-lang/inbox/notes/` + PR #322.
