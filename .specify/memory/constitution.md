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

**Version**: 1.0.0 | **Ratified**: 2026-05-21 | **Last Amended**: 2026-05-21
