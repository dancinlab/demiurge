# rfc_010 — Cockpit architecture (Quiver-mirror 3-pane info-arch + card system + Phase α..ζ)

> Status: **DESIGN** (`design.md` D31) · 2026-05-19
> Builds-on: `rfc_009` (macOS Swift cockpit spec — §3 information
> architecture only sketched, this RFC details it) · `rfc_002` v1.0
> (F1F2 typed-interface schema, consumed verbatim) · `rfc_007/008`
> (chain seam contracts v0).
> Reference UI: `cockpit/references/quiver-overview.png` —
> Palantir Foundry Quiver "Overview Analysis" capture, kept verbatim
> per **D27**.
> Boundary: **logical** (`@D g_cockpit_isolation` a/b/c/d) — this
> RFC ONLY designs cockpit-side consumption of `../exports/**`; it
> never re-shapes producer artifacts.
> Build status: spec only. Implementation lands as **Phase α..ζ**
> commits with measured-green build gates (D26/D28 idiom).

---

## 1. Purpose

`rfc_009` decided the macOS Swift cockpit IS the Demiurge product
surface (D22), drew its governance boundary (§5), and specified its
honesty-as-feature contract (§4). But §3 "Information architecture"
only sketched the 7-verb workflow as a spine — it did not specify
*what the screen looks like* once the user opens the app.

`rfc_010` fills that gap. It takes the user-provided Palantir Foundry
Quiver "Overview Analysis" capture as the reference UI pattern, maps
its layout idioms onto Demiurge's artifact model, layers Demiurge's
honesty-as-feature contract on top (gate chips, REJECTED cards,
verbatim provenance everywhere), and breaks the implementation into
six measured-green-gated phases (α..ζ).

**Scope boundary** (g3): this RFC is *design only*. No Swift
implementation work happens *because of* this RFC's existence — each
phase commits separately with its own build verification.

---

## 2. Reference UI — what Quiver does well

Captured at `cockpit/references/quiver-overview.png` (Palantir Foundry
Quiver, "Overview Analysis" canvas, 2026-05-19, user-provided).

### 2.1 Three observed zones

```
┌────────────────────────────────────────────────────────────────────────┐
│ TOP CHROME — file/help/undo/redo/save/share                            │
├────┬───────────────────────────────────────────────────────┬──────────┤
│ L  │ CANVAS toolbar — add data / add card / search cards    │ R header │
│ E  ├───────────────────────────────────────────────────────┤          │
│ F  │ heterogeneous cards, free-form grid:                  │ INSPECTOR│
│ T  │   • filter / numeric agg / bar plot                   │ for      │
│    │   • transform table / time series / heat grid         │ selected │
│ T  │   • each card has $-id, type-chip, resize handles     │ artifact │
│ R  │                                                       │          │
│ E  │                                                       │ tabs,    │
│ E  │                                                       │ collap-  │
│    │                                                       │ sible    │
│ +  │                                                       │ form     │
│par-│                                                       │ sections │
│ams │                                                       │          │
│    │                                                       │ DEPEND-  │
│    │                                                       │ ENCIES   │
└────┴───────────────────────────────────────────────────────┴──────────┘
```

### 2.2 Idiom inventory

1. **3-pane SplitView** — left tree (artifact catalog + parameters),
   center canvas (free-form heterogeneous cards), right inspector
   (selection-bound details).
2. **`$<id>` artifact tokens** — every artifact has a stable id
   (`$G`, `$AR`, `$AK` …); ids appear in card headers AND in the
   left tree AND in dependency lists, enabling cross-reference.
3. **Card composition** — each card is self-contained, draggable,
   resizable, closable, has a type chip ("Object set" / "Number" /
   "Categorical chart" …), shows action icons in its header.
4. **Card-type diversity** — Filter / Number / Bar / Heat /
   TimeSeries / Table / Scatter all coexist on the same canvas, all
   share the card chrome but render different bodies.
5. **Inspector pattern** — right pane is **selection-bound**:
   clicking a card in the canvas (or a row in the tree) updates the
   inspector. Inspector has tabs (Data / Display / Code / Events)
   and collapsible form sections (SEARCH TYPE / CONDITION / RANGE
   …). At the bottom: **DEPENDENCIES** list with "view in graph"
   link.
6. **Parameters** — a separate section at the bottom of the left
   tree for canvas-wide parameter bindings (`$C Select Batch`,
   `$H Caffeine lower bound`, `$AV Date/time range parameter`).
7. **Visual discipline** — small dense sans-serif (Inter-like);
   mono for identifiers (`$G`); white cards on light-gray
   background; very restrained palette; data carries the color
   (blue heatmap, multi-series time-series), chrome stays muted.

---

## 3. Demiurge mapping — Quiver-mirror with honesty-mode

### 3.1 Mapping table

| Quiver pattern                  | Demiurge equivalent                                          | Source data                                |
| ------------------------------- | ------------------------------------------------------------ | ------------------------------------------ |
| Tea Batch (object)              | F1F2 record / seam record / Decision / RFC / Domain          | `../exports/**` / `../proposals/` / `../design.md` |
| `$G` `$AZ` `$AK` …              | `$R<n>` (records) / `$D<n>` (decisions) / `$RFC<n>` / `$DOM:<name>` | assigned by `ArtifactRegistry` at load     |
| Filter card                     | Records filter by gate / node / clock / absorbed             | derived                                    |
| Numeric aggregation             | Gate-state distribution count, absorbed-true count           | derived                                    |
| Bar plot by category            | Records by gate / by node / by domain                        | derived                                    |
| Time series chart               | Latency curve (per-record `latency_curve` field)             | `record.latency_curve`                     |
| Heat grid                       | Records pivot (node × clock × gate)                          | derived                                    |
| Transform table                 | Records table, sortable, with gate column                    | direct                                     |
| Inspector tabs (Data/…)         | Inspector tabs (Provenance / Data / Citations / Raw JSON)    | direct                                     |
| DEPENDENCIES list               | Cross-refs (rfc → D → records → caveats)                     | parsed from `design.md` + `rfc_*` + record.atlas_cite_block |
| Parameters section              | Cockpit-wide filter bindings (gate · node · absorbed · domain) | `@State` / `@AppStorage`                   |

### 3.2 Honesty-mode — Demiurge's added layer (not in Quiver)

These elements have **no Quiver equivalent**. They are Demiurge-specific
because Demiurge's product thesis (`rfc_009` §4) is that honesty IS
the feature.

1. **Gate chip in every card header** — every artifact card displays
   its `provenance.measurement_gate` as a colored chip at the top
   right of the card header (orange OPEN / blue B_PINNED_MET /
   green CLOSED_MEASURED / red FAILED). The chip is sourced FROM
   data, never chosen by the UI. Cards without provenance render
   as **REJECTED**.
2. **Inspector's first tab is `Provenance`** — Quiver's inspector
   defaults to Data; Demiurge's defaults to Provenance, because
   that is the contract the cockpit makes with the analyst.
3. **REJECTED card mode** — if a record fails to load OR is missing
   the `provenance` field, the card renders as a red REJECTED card
   showing why; no partial render, no fallback claim
   (`@F f4` mirror).
4. **`absorbed` flag is rendered verbatim** in every card header
   alongside the gate chip. Default shape (CHARTER) = `absorbed:
   false` → so most cards display that and that is expected; the
   `absorbed: true` cases are visually reinforced (green ring).
5. **Citations are first-class** — `provenance.atlas_cite_block`
   parses into linked references; the Citations tab in the
   inspector resolves them; broken citations show as red.
6. **Cross-ref dependency graph** — DEPENDENCIES list, by default,
   shows artifacts that REFERENCE the selected artifact AND
   artifacts the selected artifact CITES. Quiver shows topological
   dataflow; Demiurge shows *citation graph* — different graph,
   same UI idiom.
7. **No silent fallback** — if a derived card (e.g., aggregation by
   gate) cannot resolve because some records are missing
   provenance, those records appear in the aggregation as a
   visible "REJECTED bucket"; never silently dropped (g3).

### 3.3 What Demiurge does NOT borrow from Quiver

- **Persistence of canvas layout** — Quiver saves analyses; Demiurge
  v0 does NOT persist layout (each launch starts fresh). Layout
  persistence is a P5 / phase-ζ-or-later concern.
- **Multi-user editing / sharing** — Quiver is collaborative;
  Demiurge is local-only (`rfc_009` §5).
- **Authoring / data-entry surface** — Quiver has Manual Entry +
  Add Data; Demiurge is **read-only** (`rfc_009` §5 g5 boundary).
  Cards display, never mutate.
- **AIP Generate / LLM cards** — out of scope (would violate the
  local-only typed-consumer contract).
- **Web rendering / WKWebView chrome** — `rfc_009` §5 forbids;
  Demiurge stays pure SwiftUI.

---

## 4. Information architecture — the 3-pane SplitView

### 4.1 Layout

```
┌─────────────────────────────────────────────────────────────────────────┐
│ TOP CHROME — title bar (window title = current canvas name)             │
├────────┬───────────────────────────────────────────────────┬───────────┤
│ LEFT   │ CANVAS TOOLBAR                                    │  RIGHT     │
│ TREE   │ + RECORD · + DECISION · + RFC · + DOMAIN ·        │  INSPECTOR │
│        │   SEARCH artifacts                                │  header    │
│ search ├───────────────────────────────────────────────────┤            │
│ ──     │                                                   │ tabs:      │
│ RECORDS│   ┌─$R1──────────┐  ┌─$D29───────────┐            │  Prove-    │
│   F1F2 │   │ F1F2 record  │  │ Decision 29    │            │  nance     │
│   seam │   │ ProvBanner   │  │ rationale list │            │  Data      │
│ ──     │   └──────────────┘  └────────────────┘            │  Citations │
│ DECIS- │                                                   │  Raw JSON  │
│ IONS   │   ┌─$LC──────────────────────┐                    │            │
│   D1.. │   │ Latency curve chart      │                    │ collapsible│
│ ──     │   │ rate vs cycles · GATE_OPEN│                   │ sections   │
│ RFCS   │   └──────────────────────────┘                    │            │
│   r001 │                                                   │  DEPEND-   │
│   r002 │   ┌─$RC───────────────────────┐                   │  ENCIES    │
│   …    │   │ Records collection table  │                   │  upstream  │
│ ──     │   │ 105 rows, gate column     │                   │  downstream│
│ DOM-   │   └───────────────────────────┘                   │  view-in-  │
│ AINS   │                                                   │  graph     │
│   chip │                                  Canvas ▾         │            │
│   …    │                                                   │            │
│ ──     │                                                   │            │
│ PARAM- │                                                   │            │
│ ETERS  │                                                   │            │
│ gate   │                                                   │            │
│ node   │                                                   │            │
│ absrb  │                                                   │            │
└────────┴───────────────────────────────────────────────────┴───────────┘
```

### 4.2 SwiftUI realization (canonical-first per D26)

- `NavigationSplitView` (macOS 13+) for the 3-pane shell.
- `List` (with sections) for LEFT tree.
- `ScrollView` + `LazyVGrid` (or custom flow) for CENTER canvas.
- `Form` + `DisclosureGroup` for RIGHT inspector.
- `.toolbar` for canvas toolbar; `Picker` / `Button` action items.
- No third-party deps (`@D g_swift_native`).

### 4.3 Selection model

- One `@StateObject ArtifactRegistry` at app root — owns all loaded
  artifacts keyed by `ArtifactID`.
- One `@State selectedArtifactID: ArtifactID?` — drives the inspector.
- LEFT tree row click → set `selectedArtifactID` → CENTER scrolls
  to + highlights the card → RIGHT inspector renders selection.
- CENTER card body click → also set `selectedArtifactID`.

---

## 5. Card system — Artifact protocol

### 5.1 Protocol sketch

```swift
protocol Artifact: Identifiable {
    var id: ArtifactID { get }              // "$R1", "$D29", "$RFC9", …
    var displayKind: String { get }         // "F1F2 record", "Decision", …
    var provenance: ProvenanceFacet? { get } // nil → REJECTED card
    @ViewBuilder func cardView() -> AnyView
    @ViewBuilder func inspectorView() -> AnyView
}
```

`ProvenanceFacet` is the common honesty-mode shape — every Artifact
provides one (or `nil` to be REJECTED). It carries `gate`, `absorbed`,
`citations`, `caveats`. For F1F2Record it maps 1:1 from rfc_002 §4.
For Decision/RFC/Domain it is synthesized (e.g., Decision's
"provenance" = the rationale-bullets + cited refs from `design.md`).

### 5.2 Artifact types (planned)

| Type            | Source                                 | Provenance synthesis                         |
| --------------- | -------------------------------------- | -------------------------------------------- |
| F1F2Record      | `../exports/chip/noc/f1f2/records/*.json` | direct from `provenance` JSON field        |
| SeamRecord (v0) | `../exports/seams/**/records/*.json`   | direct; default shape = GATE_OPEN absorbed=false (rfc_007/008) |
| Decision        | parsed from `../design.md` Decision N blocks | synth: rationale = caveats, picked = body, rejected = inverse |
| RFC             | parsed from `../proposals/rfc_*.md`    | synth: status + citation block              |
| Domain          | parsed from `../domains/*.md`          | synth: domain README's measured-vs-mapped state |

Each maps `provenance.measurement_gate` to the same color enum, so the
gate chip rule (§3.2.1) applies uniformly.

### 5.3 Card layout (canonical)

```
┌─$<id>──────────────────────────────────────┐
│ <id>   <kind chip>          🟠 GATE_OPEN ⊘ │  ← header (id, kind, gate chip, close)
│ ──────────────────────────────────────────│
│                                            │
│ <kind-specific body>                       │
│                                            │
│ ──────────────────────────────────────────│
│ absorbed: false · 5 caveats · 3 citations  │  ← footer (one-line provenance)
└────────────────────────────────────────────┘
```

Click the card body → select. Click the gate chip → focuses inspector
on the Provenance tab.

---

## 6. Phase plan — α..ζ (incremental, measured-green-gated)

Each phase is a separate commit (or commit-pair). Each phase MUST be
build-verified locally before the next phase opens (D26 spirit applied
to incremental progress).

| Phase | Scope                                                            | Est. LoC  | Build gate          |
| ----- | ---------------------------------------------------------------- | --------- | ------------------- |
| α     | `NavigationSplitView` shell. LEFT placeholder, CENTER hosts existing D29 view, RIGHT placeholder.  | ~50    | `swift run` clean   |
| β     | Artifact registry + LEFT tree populated by filesystem walk of `../exports/`, `../proposals/`, `../design.md`. Selection wired (clicking LEFT row scrolls CENTER). | ~150   | clean + selection works |
| γ     | Artifact protocol + F1F2RecordCard. CENTER canvas renders the SELECTED artifact's card (single-card view first). | ~80    | clean + card renders |
| δ     | Inspector pane (RIGHT). Tabs Provenance/Data/Citations/Raw. Selection-bound. | ~100   | clean + inspector renders |
| ε     | Card variety: DecisionCard / RFCCard / DomainCard / TableCard.  | ~200    | clean + each card type renders one example |
| ζ     | Parameters section (LEFT bottom) + DEPENDENCIES list (RIGHT bottom) + cross-ref scanner. | ~150   | clean + cross-refs resolve |
|       | **Total estimate**                                              | **~730** |                     |

Phases β and ε are the highest-friction; everything else is mostly
SwiftUI composition.

---

## 7. Open decision gates (for D32+ in `design.md`)

Each is a real fork-in-the-road that this RFC INTENTIONALLY does not
pre-commit. They are gates the phases will open as they arrive.

1. **D32 — artifact `$<id>` token format**
   - A) Sequential per type: `$R1`, `$R2`, `$D1`, `$D29` (Quiver-style)
   - B) Path-derived: `$2026-05-18-d8-king-1g`, `$D29-cockpit-monorepo`
   - C) Stable hash: `$a3f1...`
   - Trade-offs: A is short + Quiver-mirror but reassigns when load order changes; B is stable but verbose; C is stable + opaque.
   - Recommended for first pass: A; phase β.

2. **D33 — LEFT tree grouping**
   - A) By type (Records / Decisions / RFCs / Domains)
   - B) By domain (chip / matter / ...) then by type
   - C) By 7-verb stage (SPECIFY / ARCHITECT / ...)
   - Trade-offs: A is simplest; B matches D11 meta-conductor; C matches `rfc_009` §3 spine.
   - Recommended: A; phase β.

3. **D34 — Canvas layout policy**
   - A) Fixed grid (LazyVGrid n-col)
   - B) Free-form draggable cards (mimics Quiver exactly; requires custom layout + persistence — incompatible with §3.3 "no layout persistence v0")
   - C) Vertical scrolling stack of cards (simplest)
   - Recommended: C for v0; revisit later.

4. **D35 — DEPENDENCIES cross-ref scanner**
   - A) Live parse of `design.md` / `rfc_*.md` on launch
   - B) Pre-baked dependency manifest committed to `exports/cockpit/deps.json` (producer-owned per D7)
   - Recommended: A for phase ζ (simpler); B if perf demands later.

5. **D36 — Inspector tab order / default tab**
   - A) Provenance first (honesty-as-feature)
   - B) Data first (Quiver-style)
   - Recommended: A (per §3.2.2); phase δ.

6. **D37 — Filters / parameters realization**
   - A) `@State` per-launch (no persistence)
   - B) `@AppStorage` persisted across launches
   - Recommended: A for v0 (matches §3.3 non-persistence).

7. **D38 — Multi-card canvas (post phase γ)**
   - A) Always single-card center view (D29-style)
   - B) Vertical stack of all loaded artifacts
   - C) Tabbed canvases (Quiver-style multiple canvases)
   - Recommended: B at phase ε; C deferred.

---

## 8. What is NOT built (g3 — explicit)

Until each phase commits with measured-green build:

- **No NavigationSplitView yet** — D29 single-record viewer is still
  the live UI as of this RFC's writing.
- **No artifact tree** — LEFT pane content is not yet implemented.
- **No card protocol** — F1F2 is currently rendered by RecordView
  directly, not via an Artifact protocol.
- **No inspector tabs** — provenance is shown inline via
  ProvenanceBanner, but there are no Citations / Raw JSON / Data
  tabs.
- **No DecisionCard / RFCCard / DomainCard** — only F1F2Record renders.
- **No DEPENDENCIES list** — cross-refs exist in source `design.md`
  / `rfc_*.md` text but the cockpit does not parse them yet.
- **No filters / parameters** — the user cannot filter the corpus.
- **No layout persistence** — every launch resets.
- **No file picker beyond D30 hard-coded directory pin** — D30
  picker is the entry; LEFT tree (phase β) will provide richer
  navigation.

"cockpit is Quiver-mirror complete" is **NOT** asserted by this RFC.
Each phase landing is the only ground for any honest claim of
progress.

---

## 9. Cross-references

- `rfc_009` — macOS Swift cockpit product-surface spec (parent)
- `rfc_002` v1.0 — F1F2 record schema (consumed verbatim)
- `rfc_007` / `rfc_008` — chain seam record schemas (consumed when v1.0)
- `cockpit/references/quiver-overview.png` — reference UI capture
- `design.md` D22 (Phase-4 entry) / D27 (monorepo placement) / D28
  (SwiftPM bootstrap) / D29 (first slice) / D30 (file picker) /
  D31 (this RFC)
- `AGENTS.tape` `@D g_swift_native` (D26) / `@D g_cockpit_isolation`
  (D27) — both apply to every phase commit
- `CHARTER.md` "Mission" — meta-conductor; cockpit is the surface
  through which the meta-conductor is visible to the analyst
- `GOAL.md` — honesty-as-feature is the north-star differentiator;
  this RFC visualizes it
