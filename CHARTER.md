# Demiurge CHARTER

> Standalone repo `~/core/demiurge`. Authoritative scope/governance.
> Kept self-contained with `HANDOFF.md` (continuable anywhere).

## Mission

A hexa-native, domain-pluggable **technical-design architecture program**:
**SPECIFY → ARCHITECT → DESIGN → ANALYZE ⟲ → SYNTHESIZE → VERIFY
(+VALIDATE) → HANDOFF** for *any* engineered system (7-verb cited spine —
see `design.md` Decision 5). Chip design is the first/lead domain; the
named cohort spans cern (가속기) · antimatter · rtsc (초전도) · space ·
energy · brain (BCI) — `design.md` Decision 3 — **plus the chain-stage
domain `component` (part/package/system, FEM/EM/thermal)** added as
a new top-level domain by `design.md` Decision 21 to host the
meta-conductor's 3rd pass. **Typed-interface consumer**, NOT
absorber, of `hexa-matter` (물질·소재) and `hexa-bio` (화학분자)
(`design.md` Decision 2) — and per `design.md` Decision 17,
hexa-matter's *absorption SSOT is hexa-lang* (`stdlib/`), so
demiurge is the consumer-pointer side (`domains/matter/` = pointer,
not a copy). demiurge is the **meta-conductor** of a *chained*
materials→chip→component program: the 7-verb spine applied in
series, each pass's HANDOFF feeding the next's SPECIFY via a typed
seam contract (`rfc_007` materials→chip · `rfc_008` chip→component);
sibling science repos stay typed-interface-consumed (`design.md`
Decision 11 · `proposals/rfc_004_e2e_design_program.md`).

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
mapping + clean-room re-derivation only). The same absorption-RFC
pattern hexa-matter/hexa-bio used (⟵ ASE/pymatgen, AlphaFold/RDKit);
demiurge reuses the pattern but **consumes** those siblings typed-only
(Decision 2). **Re-derived reusable modules land in `hexa-lang/stdlib/`,
not under demiurge** (Decision 15 — stdlib is hexa-lang's exclusively;
demiurge is the consumer that references the hexa-lang location).
Python-0 · measured · no fake progress. See `design.md` Decisions 1, 15.

## Non-goals (governance)

- **No actual fab/FPGA** — chip domain = tapeout-ready *design* only.
- **No over-claim (g3)** — "absorbed/parity/resolved" only at a measured
  gate, filed with cited numbers; SKIP-mode regression banned (lattice-
  is-tool · measured-only · `AGENTS.tape @F f2/f4`).
- **hexa-native-only (g5)** — absorbed substrate runs as hexa intrinsics;
  re-derived reusable modules belong in **`hexa-lang/stdlib/`**, NOT
  under demiurge (`design.md` Decision 15; demiurge carries no
  `stdlib/` tree — `AGENTS.tape @F f1`). The rfc_048-precedented
  **bounded exception** is permitted: verbatim foreign substrate
  invoked as a documented fail-loud subprocess (e.g. ABC inside the
  Yosys flow per `design.md` Decision 18), with re-derivation as the
  scheduled follow-on.
- **No closed-binary RE** — public-surface clean-room only: no decompilation
  of closed binaries, no license/DRM circumvention, no trade-secret
  extraction (`design.md` Decision 1).
- **No big-bang** — incremental, per-domain absorption-RFC; full measured
  parity (per-flit DES, §B/§D full-curve, the `absorbed=true` flip) is
  gated by g3 measurement, never asserted. (The previous "design-only"
  framing of Decision 10 was **RESCINDED by Decision 12** — full scope
  incl. execution/absorption is in-scope; the gate discipline, not the
  scope cap, is what enforces honest progress.)
- **Not comb** — comb (hexa-lang, n=6 fabric) is a *consumer* of the chip
  domain, not the EDA absorber. Decoupled by design.

## Current state (snapshot, g3 — measured distance only)

4-Phase forward roadmap is **design-complete** at the contract/spec
level — NOT built, NOT wired, NOT absorbed:

- 9 RFCs delivered: rfc_001/002/003 (BookSim2 NoC absorption + F1F2
  seam + clean-room re-derivation), rfc_004 (e2e program), rfc_005
  (SUPERSEDED by D17), rfc_006 (Yosys absorption design + D18/D19),
  rfc_007/008 (materials→chip / chip→component typed seams, v0),
  rfc_009 (macOS Swift cockpit spec + D22).
- 15 domain maps (Cohort 1+2 = 13 Agent-cited + `component.md`
  cited this session — `design.md` Decision 21).
- chip NoC §B = `GATE_B_PINNED_MET` (pinned baseline measured, full-
  curve / §D NOT yet — `absorbed=false`, g3).
- Honest gap (what is NOT done): seam records 0 (both v0, contract
  only), Yosys §4 modules unimplemented (hexa-lang session, D19),
  Swift app unbuilt (gated downstream, D22), no domain measured-
  absorbed=true.

Progress / measured distance lives in `PLAN.md`; decision audit in
`design.md` D1–D22.

## Related repos

- `~/core/hexa-lang` — substrate + the **single SSOT for `stdlib/`**
  (D15); first consumer `comb/`. Hosts the absorbed re-derived
  modules demiurge references (e.g. `stdlib/booksim/` per rfc_003,
  hexa-lang commit `d5a63a82` — pending push in a hexa-lang session,
  D19).
- `~/core/hexa-matter` — sibling; absorption SSOT = hexa-lang per
  D17. demiurge carries only `domains/matter/` pointer.
- `~/core/hexa-chip` (5G/6G·packaging) and `~/core/hexa-space` —
  distinct existing repos.
- macOS Swift cockpit (D16, rfc_009): the product surface =
  read-only consumer of `exports/`; **build out-of-scope** here,
  belongs to a downstream session (D22). See `HANDOFF.md` §8.
