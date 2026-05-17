# hexa-arch CHARTER

> Standalone repo `~/core/hexa-arch`. Authoritative scope/governance.
> Kept self-contained with `HANDOFF.md` (continuable anywhere).

## Mission

A hexa-native, domain-pluggable **technical-design architecture program**:
model → synthesize → layer/assemble → verify → simulate, for *any* engineered
system. Chip design is the first domain; aerospace/space, mechanical, etc.
follow. Sibling of hexa-matter (물질·소재) and hexa-bio (화학분자); hexa-arch
is the design/architecture sibling.

## Universal pipeline (domain-neutral 5 verbs)

설계(model) → 쌓기(synthesize) → 적층(layer/assemble) → 검증(verify) →
계산(simulate). Full per-step chip-domain external map: `HANDOFF.md` §5.

## Domain plugin model

Each domain absorbs external open-source via a `proposals/rfc_0NN_<tool>_
absorption.md`, mirroring hexa-matter (⟵ ASE/pymatgen) and hexa-bio
(⟵ AlphaFold/RDKit). Python-0 · shell-out-0 · measured · no fake progress.

## Non-goals (governance)

- **No actual fab/FPGA** — chip domain = tapeout-ready *design* only.
- **No over-claim** — "absorbed" only at measured feature-parity; SKIP-mode
  regression banned (lattice-is-tool · measured-only).
- **hexa-native-only** — absorb into hexa stdlib+cli, never shell out.
- **Not comb** — comb (hexa-lang, n=6 fabric) is a *consumer* of the chip
  domain, not the EDA absorber. Decoupled by design.

## First milestone

chip domain absorbs a **NoC cycle simulator** (BookSim2 / gem5-Garnet) — the
minimal subset resolving hexa-lang `comb` RFC 057 F1/F2 (degree-6 vs
degree-4 @ modern node). Full RTL→GDSII later, incremental, measured.

## Related repos

`~/core/hexa-chip` (5G/6G·packaging — distinct), `~/core/hexa-space`
(distinct, future space domain), `~/core/hexa-lang` (substrate, first
consumer `comb/`). See `HANDOFF.md` §8.
