# hexa-arch CHARTER

> Standalone repo `~/core/hexa-arch`. Authoritative scope/governance.
> Kept self-contained with `HANDOFF.md` (continuable anywhere).

## Mission

A hexa-native, domain-pluggable **technical-design architecture program**:
**SPECIFY → ARCHITECT → DESIGN → ANALYZE ⟲ → SYNTHESIZE → VERIFY
(+VALIDATE) → HANDOFF** for *any* engineered system (7-verb cited spine —
see `design.md` Decision 5). Chip design is the first/lead domain; the
named cohort spans cern (가속기) · antimatter · rtsc (초전도) · space ·
energy · brain (BCI) — `design.md` Decision 3. Sibling of hexa-matter
(물질·소재) and hexa-bio (화학분자) via **typed-interface consumption**,
not absorption (`design.md` Decision 2) — hexa-arch is the design/
architecture sibling.

## Universal pipeline (domain-neutral 7 verbs — cited)

명세 **SPECIFY** → 구조 **ARCHITECT** → 설계 **DESIGN** → 해석 **ANALYZE**
⟲ → 합성 **SYNTHESIZE** → 검증 **VERIFY** (+VALIDATE bound) → 인계
**HANDOFF**. ANALYZE iterates back into DESIGN/SYNTHESIZE (gate, not
terminal). Spine grounded in 9 cited lifecycles (ISO/IEC/IEEE 15288 ·
V-model · NASA SE · FDA design controls · EDA RTL→GDSII · MBSE/OOSEM ·
PLM · accelerator · spacecraft) — see `design.md` Decision 5. Full
per-stage chip-domain external map: `HANDOFF.md` §5.

## Domain plugin model

Each domain absorbs the **public surface** of external prior art via a
`proposals/rfc_0NN_<tool>_absorption.md`: open-source code/specs · arxiv &
papers · patents (public reverse-engineering disclosure) · standards ·
datasheets · proprietary tools' *public documentation* (capability/gap
mapping + clean-room re-derivation only). Mirrors hexa-matter (⟵ ASE/
pymatgen) and hexa-bio (⟵ *published* AlphaFold/RDKit). Python-0 ·
shell-out-0 · measured · no fake progress. See `design.md` Decision 1.

## Non-goals (governance)

- **No actual fab/FPGA** — chip domain = tapeout-ready *design* only.
- **No over-claim** — "absorbed" only at measured feature-parity; SKIP-mode
  regression banned (lattice-is-tool · measured-only).
- **hexa-native-only** — absorb into hexa stdlib+cli, never shell out.
- **No closed-binary RE** — public-surface clean-room only: no decompilation
  of closed binaries, no license/DRM circumvention, no trade-secret
  extraction (`design.md` Decision 1).
- **Design-only** — execution to full measured parity (per-flit DES,
  §D full-curve, the `absorbed=true` flip) is a *gated non-goal*; the
  clean-room hexa-native re-derivation + RFCs + typed interface + the
  characterization records are the deliverable. Same discipline as the
  fab non-goal above (`design.md` Decision 10).
- **Not comb** — comb (hexa-lang, n=6 fabric) is a *consumer* of the chip
  domain, not the EDA absorber. Decoupled by design.

## First milestone

chip domain absorbs **BookSim2** (the field-reference NoC cycle simulator —
*not* gem5-Garnet; per `design.md` Decision 5 / Agent-2 cited comparison)
— minimal subset + **per-link modern-node wire-delay model** + **Leighton
degree-d analytic cross-check oracle**, resolving hexa-lang `comb`
RFC 057 F1/F2 (degree-6 vs degree-4 @ modern node) only when all three
loop together (no-over-claim). Full RTL→GDSII later, incremental,
measured. See `proposals/rfc_001_booksim2_noc_absorption.md`.

## Related repos

`~/core/hexa-chip` (5G/6G·packaging — distinct), `~/core/hexa-space`
(distinct, future space domain), `~/core/hexa-lang` (substrate, first
consumer `comb/`). See `HANDOFF.md` §8.
