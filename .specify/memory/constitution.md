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

### R2. Generic Verb-Cell Dispatch — `cellrun.hexa` + per-domain `.demi` manifest

Verb-cell dispatch (the 18-domain × 7-verb = 126-cell grid) flows through a **hexa-native generic dispatcher** (`~/core/hexa-lang/stdlib/cockpit/cellrun.hexa`) that reads a per-domain `.demi` manifest (`domains/<id>.demi` with `[cell.<verb>]` sections). New domains and new cells wire by editing the manifest — **never by adding new Swift code**. The 46 `cockpit/Sources/DemiurgeCore/Loaders/*Producer.swift` classes + 40+ hardcoded `(.verb, "domain")` switch cases in `ActionDispatch.swift` are **transitional bridges** (Principle I 'hexa-lang Pointer' + D14 / D18 / ARCH §0 hexa-only ultimate form 의 후속 적용 axis).

- **Manifest format** (8 keys per `[cell.<verb>]` section):
  - Required: `substrate` (python3 | hexa | curl | ngspice | bash | scan_only) · `script` (path under hexa-lang) · `record_kind` (Swift symbol pointer — typed-record schema reference) · `output_dir` (relative `exports/<domain>/<verb>/`)
  - Optional: `required_deps` · `gate_default` (OPEN | CLOSED) · `absorbed_default` (false | true) · `scope_caveats[]` · `fallback` (variant chain) · `unwired = true` (honest-skip with scaffold-pending message)
- **Carve-outs**:
  - **`record_kind` Swift-side anchor**: typed-record construction stays in Swift (compile-time safety on consumer side). Manifest declares the schema name; cellrun.hexa emits the JSON envelope; cockpit Swift decodes via the named Codable struct. The generic dispatcher does NOT absorb per-domain Codable schemas.
  - **`substrate = scan_only`**: 5 witness producers (Aura/Bio/Brain/Chem/Grid verify · foreign-drop scans) need a distinct code path with no spawn — cellrun.hexa handles via dedicated branch.
  - **Unwired cells**: manifest section absence (or `unwired = true`) → automatic g3 honest-skip · typed-by-config · no ad-hoc text fallthrough.
- **First land (Phase A · 2026-05-21)**: `~/core/hexa-lang-cellrun` isolated worktree · branch `cellrun-generic-dispatcher-scaffold` commit `cc1ad85` · 684-line `cellrun.hexa` + 192-line selftest (15/15 PASS) + end-to-end smoke (manifest-missing rc=2 honest-skip verified). Phase B (`domains/sscb.demi` PoC + sscb cells migrate · 1-2 session) pending review-then-merge of cellrun PR.
- **Load-bearing enforcement** — *Phase A scaffold*: `~/core/hexa-lang-cellrun/stdlib/cockpit/cellrun_test.hexa` (15-subtest invariants covering manifest-missing rc=2 · deps-missing rc=3 · success rc=0 · envelope shape `{record_kind, record_id, produced_at_utc, payload{substrate, provenance{measurement_gate, absorbed, scope_caveats}}}`). The hexa selftest is the real enforcement vehicle; this row is the narrative pointer.
- **Migration cost** (per audit `inbox/notes/2026-05-21-generic-cellrun-migration-design.md` · 412 line · untracked): **6-8 focused sessions** for full 46-producer migration (median 12 min/producer · max 60 min for idiosyncratic) + sscb.demi PoC 121 line covering 7/7 verbs (3 wired + 4 honest-skip with `unwired = true`).
- **Axis distinction**: R2 is dispatch-mechanism axis (plumbing) · cell `absorbed` 자체 무관 (R1 measurement axis · D103 dimension separation 보존). D74 ProducerRegistry alternatives 패턴 자연 흡수 (`[cell.<verb>.<variant>]` 섹션 multiple).
- **Cross-links**: ARCH §4.5 (target shape diagram + cost reduction table + migration path) · design.md D111 (full rationale + rejected alternatives + Phase A..E exit criterion + axis distinction) · D14 / D18 / D74 / D80 / D83 (`.demi` precedent) · Principles I (hexa-lang pointer) · II (7-verb spine) · ARCH §0 first principle.

**Version**: 1.2.0 | **Ratified**: 2026-05-21 | **Last Amended**: 2026-05-21
