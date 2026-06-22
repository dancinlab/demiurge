# RFC 009 — product surface: macOS Swift cockpit (API + UI/workflow spec)

> Status: **draft / design only — NOT built** · 2026-05-19 ·
> Source: rfc_004 §6 (product surface) + §7 Phase 4. Decisions:
> `design.md` D16 (surface = native macOS Swift app, macOS lock-in
> accepted), D2 (typed-interface = the only coupling point), D10
> (design-only; build = gated execution), D19 (implementation
> belongs to a dedicated downstream session — idiom reused here),
> g3 (no-over-claim; honesty IS the product feature). Pattern: this
> is the *detailed spec* that rfc_004 §6's RESOLVED framing pointed
> to — analogous to how rfc_002/007/008 detail their seams.

---

## 1. Purpose

Specify the **demiurge product surface**: a native **macOS Swift**
app — a *local design cockpit*, pure read-only consumer of the typed
exports, zero server / auth / DB, the hexa-native core untouched
(D16). **This RFC is the design only**; building it is downstream and
gated (D10, rfc_004 §6) — see §7. The public honest-audit surface is
**already** the public GitHub repo; the Swift app is the *local*
cockpit (complementary, not competing — D16).

## 2. What it consumes (the typed-interface contract — D2)

The app's **only** coupling point is the committed typed artifacts.
It reads, never writes back into the core (g5 boundary, §5):

| source | schema | state today |
|---|---|---|
| `exports/chip/noc/f1f2/schema/v1_0.md` + `records/` + `pair_verdicts/` | rfc_002 v1.0 | real records exist (NoC `GATE_B_PINNED_MET`) |
| `exports/seams/materials_to_chip/schema/v0.md` | rfc_007 v0 | contract only, **records empty by design** (g3) |
| `exports/seams/chip_to_component/schema/v0.md` | rfc_008 v0 | contract only, **records empty by design** (g3) |
| `design.md` + per-record `provenance` blocks | D-audit + rfc_002 §4 idiom | GATE state, `absorbed`, `measurement_gate`, citations |

Mapping convention: each JSON schema → a Swift `Codable` struct 1:1
(field names verbatim; `null` → Swift optional). Wire form (HXC v2)
is consumed **when the demiurge HXC tool lands** (the schemas'
`v*.hxc` note); until then the app reads the human/JSON form. No
schema is re-modelled or "enriched" in the app (g3 — it renders what
the producer emitted, nothing more).

## 3. Information architecture (the 7 verbs = the workflow)

The cockpit's spine **is** the 7-verb pipeline; domains = a plugin
picker; the meta-conductor chain (rfc_004 §4) = a pipeline canvas;
ANALYZE ⟲ = the visible iterate-back loop.

```
┌──────────────────────── demiurge cockpit (macOS) ────────────────────────┐
│ [domain ▾ chip|component|matter|…14]      [chain canvas: mat▶chip▶comp]    │
├───────────────────────────────────────────────────────────────────────────┤
│  SPECIFY → ARCHITECT → DESIGN → ANALYZE⟲ → SYNTHESIZE → VERIFY → HANDOFF   │
│    ●          ●          ●        ↺ loop       ○            ○        ○      │
├───────────────────────────────────────────────────────────────────────────┤
│  selected stage detail:  record viewer  ·  provenance/GATE banner (§4)     │
│  ┌─ record ──────────────┐  ┌─ provenance ───────────────────────────────┐ │
│  │ topology d6 hex R=7   │  │ absorbed: false   gate: GATE_B_PINNED_MET  │ │
│  │ … (rfc_002 fields)    │  │ citations: [BookSim2 28f432, SMART, …]     │ │
│  └───────────────────────┘  └────────────────────────────────────────────┘ │
└───────────────────────────────────────────────────────────────────────────┘
```

- domain picker = the 14 maps + chip/component/matter (plugin model).
- chain canvas = rfc_004 §4 boxes; a seam with empty records renders
  as a **dashed/"contract-only"** edge (honest, not a fake flow).
- ANALYZE ⟲ is drawn as an explicit loop, not a straight arrow.

## 4. Honesty-as-feature (g3 rendered in the UI — the differentiator)

This is the product thesis, not decoration. **Every** output cell
renders, verbatim from the producer's `provenance` block:

- `absorbed` (true/false) — false shown plainly, never hidden;
- `measurement_gate` — `GATE_OPEN` / `GATE_B_PINNED_MET` /
  `GATE_CLOSED_MEASURED`, color-coded but **never upgraded** by the
  app (same rule as rfc_007 §4 / rfc_008 §4 consumers);
- `citations` — always visible;
- a record **missing** a `provenance` block renders as a red
  **REJECTED — no provenance** card (mirrors `AGENTS.tape @F f4`
  fail-loud; the app does not invent a default).

vs Cadence / Synopsys / COMSOL black boxes: those present results
without absorbed/gate/citation provenance. demiurge's surface makes
the no-over-claim discipline the **visible** differentiator (GOAL.md:
"honesty is the product feature").

## 5. Architecture / boundary (D2 / g5)

```
 hexa-native CORE  (7-verb engine + absorbed tooling — hexa-lang/stdlib/*)
        │  emits typed records (JSON now / HXC v2 later), rfc_002/007/008 schema
        ▼
   exports/**           ← committed, public-auditable (= GitHub audit surface)
        │  (the ONLY coupling point — D2)
   ─ ─ ─ ┼ ─ ─ ─  governance boundary  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
        ▼
   Swift cockpit  (SwiftUI · Codable · read-only · no net/auth/DB)
```

- The app is **outside** the governance boundary: it consumes typed
  exports, has **zero** coupling to the hexa-native core, embeds no
  web stack — so g5 (hexa-native-only) is **unpressured** (D16).
- Read-only: the app **cannot** mutate gate/provenance state; it
  renders the producer's claim verbatim (consumer rule, §4).
- No server / auth / DB / deploy surface (D16 ops-elimination
  rationale) — it opens local committed files.

## 6. Versioning / forward-compat

- The app **pins** each `schema_version` it understands; a v0 seam
  (rfc_007/008) renders with a visible **"DRAFT v0 — upstream
  unpinned"** badge (honest; not shown as production data).
- Unknown extra keys are **ignored** (forward-compatible — rfc_002
  §6 idiom), so producer schema growth never breaks the app.
- When a seam reaches v1.0 (real validated records), the badge
  clears automatically from the same provenance/gate fields — no
  app logic asserts it (g3).

## 7. What is NOT built (g3 — explicit)

**No Xcode project, no Swift source, no app exists.** This RFC is the
**spec only**. Building it is downstream **execution → gated** (D10,
rfc_004 §6) and — reusing the D19 idiom — belongs to a **dedicated
downstream build session**, which implements against this RFC §2–§6.
Nothing here claims a working cockpit (that would be the exact
over-claim g3 / `@F f2` forbids).

## 8. Open / deferred (not gating this design)

- actual build (Xcode/SwiftUI project) — gated downstream session.
- HXC v2 consumption — deferred until the demiurge HXC tool lands
  (schemas already note this); app reads JSON until then.
- macOS minimum version / toolchain / packaging — a build-session
  concern, not a design-spec branch (no gate now).
- These are scope boundaries, not undecided forks — no user gate
  required (accepted-plan execution under D16, like D20 for Phase 3
  entry).

## 9. Cross-references

`design.md` D16 (surface = Swift) / D2 / D10 / D19 (impl-session
idiom) · rfc_004 §6 (product-surface framing this details) / §4
(chain canvas) / §7 (Phase 4) · rfc_002 (F1F2 schema the record
viewer reads) · rfc_007 / rfc_008 (v0 seams, DRAFT-badged) ·
`GOAL.md` (honesty = the product feature) · CHARTER (g3, g5).
