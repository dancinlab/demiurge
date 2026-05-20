# domain — chip (칩 설계 · deep domain)

> Status: **deep domain** — canonical 7-verb map lives in `HANDOFF.md`
> §5 + `proposals/rfc_001_chip_domain.md`, NOT here. `domains/README.md`
> records: "chip is the **deep** domain ... these 13 are **shallow**
> public-surface maps — breadth over depth." This file is the
> D100-minimal skeleton (Q4 — substrate-line parity with the 14
> non-sibling domains); it does **not** restate the 7-verb tool map.
> Boundary: public-surface clean-room (`design.md` Decision 1).
> Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).
>
> Graph (D82): prereq = `[]`. facets = `{scale: device,
> cluster: [physical, engineering], hostility: macos-clean}`.

**Substrate** (where the .hexa kernels live): hexa-lang `stdlib/kernels/circuit/` + `stdlib/kernels/logic_synth/` + `stdlib/kernels/noc_sim/` + `stdlib/{vhdl,yosys,booksim,hal}/` + sibling `~/core/hexa-chip/` (born hexa-native + sibling extension; deep domain — substrate spans the largest stdlib footprint of any demiurge domain)

## 1. Canonical map

See `HANDOFF.md` §5 (chip 7-verb deep map) and
`proposals/rfc_001_chip_domain.md` (the chip-domain RFC). This domain
file exists only to carry the D100 substrate-line and the D82 graph
record above — the public-surface tool map is **deliberately** not
duplicated here (g3 single-source-of-truth: HANDOFF.md §5 is the SSOT,
this file points).
