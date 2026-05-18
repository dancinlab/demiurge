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
in hexa-arch/proposals; hexa-arch references as consumer.

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
pending hexa-lang review — booksim/d5a63a82 precedent). hexa-arch
references it as the chip-domain SYNTHESIZE tool; this RFC is the
design only.

> **D19 — implementation session boundary.** The §4 modules +
> self-tests + §5 oracle verification are implemented in a
> **hexa-lang session** (modules live in hexa-lang's tree per D15;
> review+push authority co-located with ownership; avoids stacking
> a 3rd review on hexa-lang's pending `d5a63a82`/`61866308`). This
> RFC §4/§5 *is* the spec that session works against. hexa-arch's
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
