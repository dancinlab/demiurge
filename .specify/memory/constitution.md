# demiurge Constitution

## Core Principles

### I. hexa-lang Pointer (NON-NEGOTIABLE)
demiurge is a typed-interface CONSUMER of hexa-lang stdlib, `hexa-matter` (materials), `hexa-bio` (molecules), and `comb` (n=6 lattice fabric). It does NOT fork, vendor, or absorb these. `domains/matter/` is a pointer into hexa-lang's absorbed material primitives — not a copy. Gaps file upstream via `~/core/hexa-lang/inbox/patches/`. hexa-lang's constitution governs stdlib / atlas / grammar / lattice; demiurge adheres on those subjects.

### II. 7-Verb Universal Pipeline
The spine is domain-neutral: SPECIFY → ARCHITECT → DESIGN → ANALYZE ⟲ → SYNTHESIZE → VERIFY → HANDOFF. Domain plugins (chip, component, cern, antimatter, rtsc, space, energy, brain, fusion, mobility, bot, grid, aura, sscb, scope) attach to this spine; they do not duplicate it or carry a private pipeline. Cited foundation: `design.md` Decision 5.

### III. Meta-Conductor Chain
Materials → chip → component are sequential passes. Each pass's HANDOFF feeds the next pass's SPECIFY via a typed seam contract (`rfc_007` materials→chip, `rfc_008` chip→component). Out-of-order or unchained execution violates this principle.

### IV. Public-Surface Clean-Room
Research draws from public sources only: OSS code/specs, arxiv, patents (as public disclosure), standards, datasheets, and public documentation of proprietary tools — for capability/gap mapping + clean-room re-derivation. CLOSED-BINARY DECOMPILATION, LICENSE/DRM CIRCUMVENTION, AND TRADE-SECRET EXTRACTION ARE OUT OF SCOPE.

### V. No Over-Claim (g3) — Measured Before Claimed
"absorbed", "parity", "resolved", "complete" require a recorded measurement before they appear in code, docs, or surface. No claim without evidence; missing measurement is recorded as missing. Aligns with hexa-lang `LATTICE_POLICY.md` (lattice-as-tool, anti-over-claim).

### VI. Step-by-Step Decision Gate (NON-NEGOTIABLE)
One user-confirmation per decision, never batched. Each lands in `design.md` as `### Decision N — <picked>` with explicit **picked** + 3+ rationale bullets. `design.md` is the decision audit-trail SSOT.

## Repository Layout

```
demiurge/
├── CHARTER.md     # scope & governance (authoritative)
├── ARCH.md        # narrative architecture SSOT
├── PLAN.md        # append-only progress log (κ-N phase entries)
├── design.md      # decision audit trail (SSOT)
├── GOAL.md        # one-sentence north-star
├── HANDOFF.md     # self-contained pickup brief
├── domains/       # pluggable domain modules (chip lead, cohort + 13 shallow)
├── proposals/     # rfc_NNN_*.md (typed-seam contracts)
├── cockpit/       # macOS Swift workbench (/Applications/demiurge.app)
├── exports/       # outbound seam payloads
├── inbox/         # inbound external material (clean-room queue)
├── state/         # runtime state for the cockpit
└── .specify/      # Spec Kit pipeline artifacts (this constitution lives here)
```

## Development Workflow

1. **Decision first.** Every direction lands in `design.md` as a Decision entry before code moves. One decision per gate (Principle VI).
2. **Spec next.** Feature work flows through Spec Kit: `/speckit-specify → /speckit-plan → /speckit-tasks → /speckit-implement`.
3. **Domain via plugin, never via spine fork.** New engineering domains attach as plugins under `domains/`; they do not re-implement the 7-verb spine.
4. **Upstream gaps, not local hacks.** When `hexa-lang` / `hexa-matter` / `hexa-bio` / `comb` lacks a primitive, the patch is filed at `~/core/hexa-lang/inbox/patches/<name>.md`. Local workarounds in demiurge are blocked when an upstream fix is feasible.
5. **Measure before claim.** Any merge that asserts absorbed/parity/resolved/complete must point at the recorded measurement (test, bench, citation).

## Governance

- This constitution governs demiurge-local concerns (7-verb spine, meta-conductor chain, clean-room boundary, decision discipline, honest reporting). On stdlib / atlas / grammar / lattice / materials / molecules subjects, the `hexa-lang` constitution wins.
- Amendments land via a PR that updates this file, adds a `design.md` decision entry, and bumps semver: MAJOR = principle removal/redefinition · MINOR = new principle/section · PATCH = wording.
- Complexity must be justified in the corresponding `design.md` entry. Default = simpler.

## Governance Rows

Narrative anchors for typed enforcement invariants. Each row points at the load-bearing test/code that actually enforces; the row itself is the human-readable governance pointer (not the enforcement). Add rows by appending — never edit existing rows in-place except for PATCH-level wording.

### R1. Measured-Oracle Invariant — `absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true`

A cell-record's stored `absorbed: Bool` flips legitimately only when an attached `MeasuredOracleRef` records `isMeasuredOraclePASS=true` against its PASS criterion. Conflation of the measured-oracle axis with substrate-parity (D95 computed projection · `isHexaNativeAbsorbed`) is forbidden — D103 dimension-separation enforces two orthogonal axes (`absorbed` = measurement axis · `hexa_native_parity` = substrate-port axis).

- **Carve-outs**:
  - **D106 illustrative-physics cells**: `.illustrativePhysics` `GateType` cells (RFC 013 §6.12) are exempt — no `MeasuredOracleRef` can be attached; `absorbed` flips by illustrative gate criteria, not measured-oracle PASS. Anti-conflation cyan tone in cockpit.
  - **D95 computed projection (substrate-parity)**: A DIFFERENT axis (D103). `isHexaNativeAbsorbed` computed projection PASS is NOT sufficient to flip `absorbed`. Separate stored field carries the substrate-parity record (`HexaNativeParityRef`).
- **First land (κ-68 G29 · D110 · 2026-05-21)**: Energy/solar cell · oracle = NREL MIDC SRRL pyranometer GHI · 480 clear-sky samples (2024-06-15) · `mean_rel_err = 0.04967` ≤ 0.05 threshold · marginal PASS · commit `80a1664`.
- **Load-bearing enforcement** — *Stage 1 (typed)*: `cockpit/Tests/DemiurgeCoreTests/AbsorbedNeedsMeasuredOracleTests.swift` (commit `fee34cc` · 3 test methods covering invariant + D95 conflation + D106 exempt branch · 63/63 PASS · 0 regression). The XCTest invariant is the real enforcement vehicle; this row is the narrative pointer.
- **Cross-links**: ARCH §11.4 G30 (Stage 1 LANDED) · ARCH §11.4 G34 (Stage 2 = 본 row LANDED) · design.md D109 (cell+oracle pick) · D110 (first flip record) · D103 (dimension-separation) · D106 (illustrative carve-out) · RFC 013 §6.11 (LANDED · κ-68 closure) · §6.12 (illustrative anti-conflation).

**Version**: 1.1.0 | **Ratified**: 2026-05-21 | **Last Amended**: 2026-05-21
