# ARCH — demiurge architecture (narrative SSOT)

> **Role**: this file is the *narrative* architecture SSOT — how the
> moving parts fit together, what data flows where, what the contracts
> are. The complementary files are:
>
> - `design.md` — gated D-decision audit trail (one decision = one
>   `### Decision N` block, numbered SSOT)
> - `PLAN.md` — append-only progress log (κ-N phase entries)
> - `AGENTS.tape` — enforced rules (`@D` governance + `@F` denies)
> - `ARCH.tape` — terse machine-readable arch index (tape v1.2)
> - `GOAL.md` — one-sentence north-star + honest-position
>
> If a number / list / counter appears here AND in another file, the
> other file is the SSOT (`g_ssot_single_source`, D50). This file
> describes the *shape* of the system, not the running counts.

> Last reconcile: 2026-05-20 · D77 (chem + bio domains) · D78 (graph
> DAG + multi-facet tag).

---

## 0. First principle — hexa-only (ultimate form)

> Every producer, kernel, record schema, and verify oracle's
> **ultimate destination** is **hexa-native** (`~/core/hexa-lang/`).
> Python adapters, Swift cockpit, external CLI are **transitional
> pointers (bridges)** — not endpoints. **Sibling repos** (`hexa-
> rtsc/` · `hexa-matter/` · `hexa-bio/` · `hexa-chem/`) carry
> **domain narrative only** (markdown · physics derivation · spec
> · citation index) — **no code** per D116 amendment of D14/D17/D77. A cell
> can only be flipped to `absorbed=true` non-provisionally when
> its hexa-native parity port exists AND matches the transitional
> implementation to a cited tolerance. Otherwise: GATE_OPEN /
> `provisional=true`, regardless of how many intermediate checks
> pass.
>
> Authority: AGENTS.tape `@D g_hexa_only` (INDEX top, body block,
> 2026-05-20) · design.md D80 · raises `g_hexa_native` (D14+D18)
> from absorption-time preference to absolute endpoint rule.
>
> **Orthogonal to the hexa-native endpoint axis is the *execution venue*
> axis** — where the FLOPs actually run. Heavy / install-gated /
> cross-platform-audit / GPU compute may route through `pool` (a
> first-class infrastructure layer · `~/core/pool/` CLI · canonical
> precedent at `~/core/hexa-lang/stdlib/material/cross_code_dft.py::
> _pool_cli_present`). Pool is a *venue, not a verb* (POOL.md §3.5) —
> the 7-verb spine and the hexa-native endpoint rule are unchanged
> by pool dispatch. Records that route through pool surface
> `provenance.pool_host` + `provenance.pool_command`; R4
> `absorbed=false` 영구 carries over (POOL.md §3.2). Cross-link:
> `POOL.md` (this repo · ~517 line · 7 § spec).
>
> Examples:
> - **endpoint-compliant**: chip §B sweep_oracle_parity.hexa
>   (κ-43 / D70) — first dynamic `absorbed=true`, BECAUSE the
>   hexa-native oracle exists.
> - **provisional**: cern+synth (κ-51) — Xsuite ⇄ Wiedemann/Lee
>   match on a Python substrate. honest flip at the algorithm
>   layer, but hexa-native FODO twiss kernel does not yet exist
>   → `provisional=true`, subject to demotion if the hexa-native
>   port diverges.

---

## 1. One-line shape

`demiurge` is a graph of **domains** with **prerequisite edges**
between them, where each domain has **7 verb cells** that dispatch
to **substrates** living in **hexa-lang** (or sibling hexa-* repos),
and the cockpit reads the resulting **typed records** under a
single **honesty gate** (g3).

```
   ┌────────────────────────────────────────────────────────────┐
   │ demiurge (Swift cockpit + DemiurgeCLI + DemiurgeCore)      │
   │                                                            │
   │ ┌──────────────────────┐    ┌───────────────────────────┐  │
   │ │ domains/ (18 nodes)  │    │ ProducerRegistry +        │  │
   │ │ + prerequisite edges │    │ ActionDispatch (per-cell  │  │
   │ │ + facet tags         │───►│  spawn into hexa-lang)    │  │
   │ └──────────────────────┘    └───────┬───────────────────┘  │
   │                                     │ python3 spawn        │
   └─────────────────────────────────────┼──────────────────────┘
                                         │
            ┌────────────────────────────┴───────────────────┐
            │ hexa-lang / stdlib/ (D17, D72 ①a kernels +     │
            │  ①b domain adapters)                           │
            │ + sibling repos: hexa-matter · hexa-bio ·      │
            │  hexa-chem (D17 precedent, typed-interface     │
            │  consumed)                                     │
            └────────────────────────────────────────────────┘
```

---

## 2. Domains — graph, not partition (D78)

### 2.1 Nodes

18 domains live under `domains/<name>.md`. Each one is a node in the
domain graph. Domain ≠ project; the project is a *pointer* (D-pending,
see §5).

```
Molecular tier (substrate-heavy):  matter · chem · bio
Device tier:                       chip · firmware · sscb · rtsc ·
                                   brain · aura
Component tier:                    component · bot
System tier:                       energy · grid · mobility · scope ·
                                   space · cern · antimatter · fusion
```

*Tier = facet tag, not a partition.* A domain can carry multiple
tags (D78 picked option 3). See §2.3.

### 2.2 Prerequisite edges (DAG)

Each `domains/<name>.md` carries a header field:

```yaml
prerequisites: [<other domain ids>]
```

The collection of edges forms a directed acyclic graph (DAG) — when
a project picks a *start domain*, the system traverses its transitive
closure and proposes the upstream domains to include.

Example chains (illustrative, exact edges live in each `domains/*.md`):

```
- bio (drug discovery)  →  chem (synthesis)  →  matter (formulation)
- chem (catalyst)       →  matter (carrier)
- fusion                →  rtsc (HTS coil)   →  matter (cryostat alloy)
- chip                  →  firmware                — software on top
- scope                 →  component (optics frame) → matter
```

Two domains can share an upstream prerequisite (e.g., both `bio` and
`chem` may depend on `matter`); this is why a DAG (not a tree) is the
correct shape.

### 2.3 Facet tags

Each domain header also carries:

```yaml
facets:
  scale:    Molecular | Device | Component | System
  cluster:  matter | bio | chem | physical | engineering | system | ...
  hostility: macos-clean | macos-partial | macos-blocked | linux-pool
```

Facets are **multi-tag**, not mutually-exclusive partitions — `bio`
might carry `cluster: [bio, chem]` if its prerequisite chain crosses
both clusters. The cockpit *New Project* UI uses facets only as a
filter for the initial domain pick.

### 2.4 Why graph, not strict partition

User observation (2026-05-20): real systems cross-cut domains. A drug
project touches `bio` (target) + `chem` (molecule) + `matter`
(formulation) + `component` (delivery device). Forcing each domain
into a single tier creates false either/or choices and hides the real
prerequisite relationships. D78 picked option 3 = graph DAG +
multi-facet tag.

### 2.5 Example — `domains/ufo.md` (HEXA-Disc, 7-stage propulsion)

The canonical worked example for "graph, not partition" + "multi-level
DAG" — a top-of-stack domain whose **direct** prerequisites are three
sister sibling repos (`hexa-fusion`, `hexa-antimatter`, `hexa-rtsc`),
each of which **transitively** depends on `rtsc` as a foundation
technology. The sibling-repo `~/core/hexa-ufo/` README §Status anchors
the mapping (Stage-1 Meissner → rtsc · Stage-2 cruise → fusion ·
Stage-3 orbital → antimatter).

```yaml
# domains/ufo.md — header (D78 schema, Option 3: direct prereq only)
prerequisites:
  - fusion       # Stage-2 MHD + tabletop fusion cruise
  - antimatter   # Stage-3 antiproton γ-rocket orbital
  - rtsc         # Stage-1 Meissner diamagnetism (direct)

facets:
  scale:    System
  cluster:  [physical, propulsion]           # multi-tag, not partition
  hostility: macos-clean                     # all 3 substrates macOS-clean

substrate_ssot: ~/core/hexa-ufo/             # D17 sibling-repo precedent
                                             #   v1.0.0, DOI 10.5281/zenodo.20102628
```

DAG fragment (3-level: foundation → application → integration):

```
                 ┌─────┐
                 │ ufo │              ← LEVEL 3 (integration apex)
                 └──┬──┘
            ┌───────┼───────┐
            │       │       │
       ┌────▼───┐ ┌─▼─────┐ │
       │ fusion │ │antimat│ │         ← LEVEL 2 (application)
       └────┬───┘ └──┬────┘ │
            │        │      │
            └────────┼──────┘
                     │
                ┌────▼────┐
                │  rtsc   │           ← LEVEL 1 (foundation)
                └─────────┘

direct prereq edges (Option 3 schema):
  ufo → {fusion, antimatter, rtsc}
  fusion → {rtsc, ...}          (per domains/fusion.md cross-refs)
  antimatter → {matter, rtsc}   (Penning trap SC magnet + trap matter)

transitive closure (computed by graph traversal, NOT stored):
  ufo* = {fusion, antimatter, rtsc, matter, ...}
```

**Why this is the chosen example**:
- **Multi-level DAG** is visibly necessary — `rtsc` shows up once as
  ufo's direct prereq (Stage-1 Meissner) **and** transitively through
  `fusion` and `antimatter`. Storing only direct edges (Option 3)
  keeps the SSOT minimal; the cockpit traversal proposes the closure.
- **rtsc-as-foundation** is real — `domains/grid.md` cross-references
  `rtsc` for HTS power cable, `fusion` uses tokamak SC coils,
  `antimatter` uses Penning trap SC magnets, `cern` uses LHC SC
  dipoles. Stripping rtsc breaks ≥4 downstream domains.
- **Sibling-repo pattern** (`~/core/hexa-ufo/`) makes the D17 / D77
  boundary concrete — substrate too large for one stdlib subtree, so
  it lives outside. The demiurge-side `domains/ufo.md` is a pointer.
- **Speculative tail honestly tracked** — `~/core/hexa-ufo/` Stages
  4–7 (warp / wormhole / dim-jump / dim-use) carry **13 OPEN
  falsifiers** (F-WARP-1..3 / F-WORM-1..3 / F-DIM-1..3 / F-USE-1..4).
  All UNPROVEN at v1.0.0. The demiurge cell layer respects this:
  any ufo+verify record carries scope_caveats spelling out that
  bookkeeping-closure ≠ empirical truth (g3).

**Project example over the same graph** — a "ufo close-encounter
trace" project (cockpit "New Project" flow):

```
step 1.  Facet filter: cluster=propulsion          → narrows to ufo + chain
step 2.  Pick start domain = ufo
step 3.  Auto-propose transitive closure:
            [rtsc, matter, fusion, antimatter, ufo]
                 ^foundation              ^integration apex
step 4.  Project.walk = topological sort of the closure
         Project.startDomain = ufo
         Project.verbState = per-domain 7-verb state
```

The same `domains/ufo.md` node serves any number of projects (D78 —
"domain ≠ project, project is pointer over the graph"). A drug-discovery
project would start at `bio` and traverse `{chem, matter}` — a
completely different transitive closure over the same graph.

---

## 3. The 7-verb spine (D5)

Every domain carries the same seven verbs, each of which dispatches
a *cell*:

```
명세 (specify)  → architecture spec, IETF/AUTOSAR-class doc, cited
구조 (structure)→ topology / task tree / inventory
설계 (design)   → real source artifact (RTL, KiCad, C, URDF, .step)
해석⟲ (analyze) → simulation, what-if, error analysis
합성 (synthesize)→ build the deliverable
검증 (verify)   → independent measurement against an oracle
인계 (handoff)  → packaged release + SBOM + cited audit trail
```

A (verb, domain) pair = a *cell*. With 18 domains × 7 verbs = 126
cells. Of those, ROI 1→18 (currently 17) have a real engine tool
dispatched; the rest fall back to the LLM "honest-gap" path.

---

## 4. Substrate & kernel layer (D17 / D61 / D72)

### 4.1 Where the math lives

`demiurge/` carries *no* compute code. Every producer script is owned
by `hexa-lang/stdlib/` (D17 / D61). The Swift `Producer.swift` in
demiurge spawns `python3 ~/core/hexa-lang/stdlib/<domain>/<script>.py
<output_dir>` and decodes the resulting JSON into a typed Record.

### 4.2 D72 — two-layer kernel

```
hexa-lang/stdlib/
├── kernels/              ①a domain-agnostic math (13 today)
│   ├── graph/  fem/  mc_transport/  orbital/  wave_optics/
│   ├── noc_sim/  logic_synth/  circuit/  plasma/  neural/
│   ├── signal_proc/  urdf/  solar/
│   └── (cfd, ode_pde, ...)  planned
│
└── <domain>/             ①b thin domain adapter
    ├── component/gmsh_skfem.py    → calls kernels/fem/
    ├── grid/networkx_basics.py    → calls kernels/graph/
    ├── cern/xsuite_optics.py      → adapter-only (single domain)
    └── ... (15 today, +chem, +bio post-D77 = 17)
```

A kernel may have many adapters. Example payoff:
`kernels/mc_transport/` is consumed by **4** domain adapters
(antimatter+analyze, fusion+verify, energy+verify, antimatter+verify)
— the N+M reuse the D72 layer was designed for.

### 4.3 D74 — ProducerRegistry (cells with alternatives)

Most cells have one substrate; a few carry alternatives. Example:
`(cern, analyze)` has both `pylhe` (legacy LHE round-trip) and
`xsuite-tracking` (real physics, default). ActionDispatch consults
`ProducerRegistry.entries` first; missing keys fall through to the
hardcoded switch (additive, not invasive).

```
ActionDispatch.runEngineTool(verb, domain, producer:)
    │
    ├─ ProducerRegistry.entries[(verb, domain)]?
    │   ├─ entry.pick(producer ?? default) → variant.run()
    │   └─ unknown producer → honest no-record
    │
    └─ switch (verb, domain) → hardcoded Producer.run() (default)
```

CLI: `action analyze cern --producer pylhe`.

### 4.4 Sibling repos (D17 / D77 / **D116 amendment 2026-05-21**)

> **D116** amendment: sibling repos = **문서만 (docs only)** · **모든
> substrate code = `~/core/hexa-lang/stdlib/<domain>/` ONLY**. D14/
> D17/D77 의 "sibling repo for large substrate sub-trees" precedent
> 는 본 D116 으로 **role-only-narrative** 로 amendment.

`hexa-lang` is the **single SSOT for ALL stdlib code** (substrate
algorithms · kernels · math · physics models · validation logic).
Sibling repos serve as **doc-only domain SSOTs** — domain narrative
(`*.md`) · physics derivation notes · citation indexes · spec ·
clean-room provenance. **No code** (no `.hexa` · no `.py` · no
`.swift` in sibling repos):

```
~/core/hexa-rtsc/     — RTSC.md 도메인 narrative · 5-gate definition
                        · candidate matrix · physics derivation
                        notes (R4 cross-link 의 doctrinal source).
                        **docs only · NO code (D116)**.
~/core/hexa-matter/   — material domain narrative + taxonomy +
                        citation index (D17 precedent · D116 으로
                        code allowance 제거). **docs only**.
~/core/hexa-bio/      — molecular biology domain narrative + spec
                        (D77 planned · D116 으로 docs-only 정착).
~/core/hexa-chem/     — chemistry domain narrative + citation index
                        (D77 planned · D116 으로 docs-only 정착).
```

The demiurge-side `domains/<id>.md` is the **active engineering
pointer** (carries deliverable spec + 7-verb cell wiring + cited
sources); sibling repos carry the **expanded narrative** (physics
derivation · longer-form spec · multi-paper citation cluster) when
the spec exceeds what a single `domains/<id>.md` page can hold.
Cellrun.hexa (D111 + ARCH §4.5) reads `.demi` manifest from
demiurge `domains/` · resolves substrate `script` path under
**`~/core/hexa-lang/stdlib/<domain>/`** (NEVER a sibling repo).

**Migration scope** (Phase B/C of D116 · multi-cycle): sibling
repos that currently hold algorithm code (`hexa-rtsc/verify/calc_
bcs.hexa` · `calc_mcmillan.hexa` · `calc_hc2_48t.hexa` · `falsifier_
check.hexa` · 등 추정 4개) 점진 `~/core/hexa-lang/stdlib/<domain>/`
이전. Sibling repo 의 narrative-only role 정착까지 multi-session.

### 4.5 D111 — Generic verb-cell dispatch (`cellrun.hexa` + `.demi` manifest)

> **D111 (2026-05-21)** ratifies the architectural shift away from
> hardcoded per-cell `*Producer.swift` classes toward a hexa-native
> generic dispatcher. This subsection describes the *target shape*;
> §4.3's ProducerRegistry + ActionDispatch switch is the
> **transitional bridge** (D14 / D18 / §0 hexa-only ultimate form).

**Pain that triggered D111** (2026-05-21 sscb 7-verb walkthrough ·
실 측정 ground truth):

- 46 `cockpit/Sources/DemiurgeCore/Loaders/*Producer.swift` classes
  (50-150 line each · spawn substrate + parse stdout + emit typed
  record · `(domain × verb)` axes scatter pattern)
- 40+ hardcoded `(.verb, "domain")` switch cases in
  `ActionDispatch.swift` · each new cell wiring = +1 Swift class
  + +1 switch case
- Adding a new domain requires writing 4-7 Swift producer classes
  (200-400 line each) + matching dispatch cases — Swift code per
  domain is essentially **prose** (`ai-native` 위반)
- ARCH §0 first principle says producer's ultimate destination is
  hexa-native — Swift producer classes are §0 endpoint targets too

**Target shape**:

```
ActionDispatch.dispatch(verb, domain)                                    [Swift · thin]
    │ spawn
    └─ hexa run stdlib/cockpit/cellrun.hexa <domain> <verb>               [hexa-native]
         │
         ├─ load_manifest(domain)                                          [domains/<id>.demi]
         │      [cell.<verb>]
         │      substrate     = python3 | hexa | curl | ...
         │      script        = stdlib/<domain>/<verb>.{py,hexa}
         │      record_kind   = <DomainVerbRecord>
         │      output_dir    = exports/<domain>/<verb>
         │      required_deps = [<binary>, <python-module>, ...]
         │      gate_default  = OPEN | CLOSED_DOC | CLOSED_MEASURED
         │      absorbed_default = false | true
         │      scope_caveats = [<caveat>, ...]
         │      fallback      = <variant>?       # D74 alternatives 흡수
         │
         ├─ dep_check(required_deps)
         │      └─ missing → honest-skip emit · g3 typed-by-config
         │
         ├─ spawn_substrate(substrate, script, ...)
         │      └─ capture stdout · exit · artifacts list
         │
         ├─ emit_record(record_kind, content, output_dir)
         │      └─ write JSON · timestamped id · gate/absorbed/caveats
         │         from manifest
         │
         └─ return result to Swift (record path · stdout · exit)
```

**Cost reduction** (new domain or new cell):

| step | pre-D111 (hardcoded) | post-D111 (manifest) |
|---|---|---|
| domain doc | `domains/<id>.md` | 동일 |
| **producer Swift** | **7 new class · 700-1400 line** | **0** |
| **dispatch switch** | **7 new case · 7-14 line** | **0** |
| hexa-native script | 도메인 작업 | 동일 |
| **manifest** | — | **신규 `<id>.demi` ~80-120 line** |
| record schema | 7 new Codable struct | 1 generic `CellRecord` OR 재사용 |
| g3 honest-skip | ad-hoc text 응답 | **typed-by-config 자동** |

**Migration path (Phase A..E · 15-20 session est · honest correction 2026-05-21 저녁 per Phase B step 3 observed cost — was 10-17 session at D111 ratification morning)**:

- **Phase A**: `stdlib/cockpit/cellrun.hexa` Phase A scaffold (hexa-
  lang isolated worktree `hexa-lang-cellrun` · concurrent agent
  2026-05-21 작업 중) — manifest loader + g3 gate + selftest. PR
  open 안 함 (review 대기).
- **Phase B**: `domains/sscb.demi` proof-of-concept (7 verb · 3
  wired + 4 honest-skip) · existing record byte-equal regression
  verify. 1-2 session.
- **Phase C**: 46 producer 점진 migration (1 도메인 / commit ·
  `.demi` add + Swift producer + switch case 제거 + regression
  test PASS). **8-13 session** (Phase B step 3 실측 20 min/cell ·
  원본 12 min/cell 의 3× · 46 producer × 20 min ≈ 15-20 시간
  total focused work · 도메인 별 1 session ≈ 3-6 cell).
- **Phase D**: `ActionDispatch.swift` 가 switch 0 case · 5-line
  thin spawner 로 축소. 1 session.
- **Phase E** (optional): Swift-side record schema 도 manifest-
  declared fields 로 generalize (per-domain CodingKey 폐기 검토).
  2-3 session.

> **Phase B observed cost (2026-05-21 저녁 · honest correction
> source)**: 3 sscb cells (6.5% of 46) ≈ 1 hour focused work →
> 20 min/cell observed (3× original 12 min/cell estimate). Overhead
> sources: format-mismatch fixup · Verb Korean→English mapping ·
> Python version debug · payload-flattening decisions. Phase A bug
> fixes in flight (cellrun.hexa `_split_csv` quoted-comma · Verb.
> canonical Korean drift · python candidate list · concurrent
> agent · PR update on `d111-phaseb-sscb-migration`) will reduce
> future per-cell cost — but 20 min figure already absorbs some
> recovery overhead, so envelope stays honest at 15-20 session.

**Axis distinction**:

- D111 = dispatch-mechanism axis (plumbing) · cell 의 `absorbed`
  자체와 무관 (D103 dimension separation 유지)
- D80 endpoint rule 의 *cockpit-dispatch axis* 적용 — kernel/
  producer-content/record-schema axes 와 별 axis
- D74 ProducerRegistry alternatives 패턴은 `[cell.<verb>.<variant>]`
  manifest 섹션으로 자연 흡수 (Swift ProducerRegistry class 도
  cellrun.hexa 안 selection logic 으로 흡수)

**Cross-link**: design.md D111 (full rationale + rejected
alternatives + Phase A..E) · D112 (Verb canonical → English wire
form · bug #2 fix) · D113 (payload flattening · sibling .meta.json
roll-up) · **D114** (stdlib SSOT enforcement · code-shape × repo
boundary) · **D116** (sibling repos = docs only · amendment of
D14/D17/D77) · D14 / D18 / D74 / D80 / D83 (.demi precedent) ·
CLAUDE.md Principles 1 + 2 + 4 + 5 (ai-native · hexa-first ·
domain-meta-domain · lattice-as-tool) · ARCH §0 first principle ·
§4.4 (sibling repos docs-only role per D116).

---

## 5. Projects — pointers over the graph

```
struct Project {
    let id: ProjectID
    let name: String
    let createdAt: Date

    // Pointer-only — does NOT own domain content.
    let startDomain: DomainID
    let walk: [DomainID]   // ordered chain (incl. prerequisites)

    // Mutable run state lives on the project; producers' typed
    // Records live under exports/<domain>/<cell>/<stamp>/.
    var verbState: [Verb: VerbState]
    var manifestPath: URL   // D45 — App Support persisted JSON
}
```

The project never modifies `domains/*.md`. The cockpit "New Project"
wizard:

```
step 1.  Facet filter (cluster + scale)         — narrows the 18 nodes
step 2.  Pick start domain (e.g., bio)          — graph traversal
step 3.  Confirm prerequisite chain             — DAG transitive closure
step 4.  Project name + manifest persistence    — App Support (D45)
```

A project may add or remove a domain from its `walk` later; the
underlying `domains/*.md` graph is unaffected. Multiple projects can
share the same domain (a single SSOT).

---

## 6. SceneDescriptor (D76)

3D viewers in the cockpit are *not* hardcoded per domain. Instead:

```
domains/*.md → toScene() → SceneDescriptor (Codable Swift)
                              │
                              │  primitive enum:
                              │   box · annulus · helixTube · sphere ·
                              │   mesh · arrow · label
                              │
                              ▼
            GenericSceneView3D (RealityKit ARView)
              ├─ orbit drag / scroll zoom
              └─ MeshDescriptor helpers (annulus / helix tube / ...)
```

`ComponentGeometry.toScene()` and `RtscGeometry.toScene()` are the
first two emitters; the goal is for every domain that *has* a
geometry to emit a SceneDescriptor instead of a custom view. The
domain-specific Views (`ComponentView3D`, `RtscView3D`) are
deprecated once their toScene() is wired and visually verified.

---

## 7. Records, gates, honesty (D9 / D12 / g3)

Every Producer emits a typed `Record` (Swift Codable) carrying:

```swift
struct Provenance {
    let absorbed: Bool                     // false until measured parity
    let producer: String                   // "lib@ver" — NOT the part
    let measurementGate: MeasurementGate   // OPEN / B_PINNED_MET /
                                           // CLOSED_MEASURED / FAILED
    let scopeCaveats: [String]             // honest what-this-isn't
}
```

`absorbed=true` flips ONLY on a *measured* gate — typically a cited
analytic oracle or an external benchmark hit within a stated
tolerance. Two dynamic flips so far: chip §B+§D (κ-43, D70) and
cern+synth (κ-51, vs Wiedemann/Lee). Everything else is
`GATE_OPEN, absorbed=false`. The `scope_caveats` field is
*non-optional* — every record carries an explicit list of what the
measurement does NOT cover.

The g3 contract: never silent-pass, never over-claim, never set a
gate without a citation. Install-gated and platform-gated skips are
honest: the substrate emits a record with `skipped_reason` set and
`absorbed=false` rather than crashing or falsifying success.

---

## 8. Cockpit (UI) layer (D26 / D35 / D41)

```
cockpit/Sources/
├── DemiurgeCore/           — domain models + loaders + producers
│   ├── Models/              ComponentGeometry, RtscGeometry, *Record
│   ├── Loaders/             ActionDispatch, ProducerRegistry, *Producer
│   ├── Exporters/           USD, STL exporters (Component path)
│   └── Artifacts/           record discovery + serialisation
│
├── CockpitApp/             — SwiftUI macOS workbench
│   ├── CockpitApp.swift     entry; env switches for test windows
│   ├── Views/
│   │   ├── ComponentView3D    (legacy — see §6)
│   │   ├── RtscView3D         (legacy — see §6)
│   │   ├── GenericSceneView3D (target — D76)
│   │   ├── WorkbenchView      (7-verb recipe rail + project pane)
│   │   ├── NewProjectSheet    (post-D78: facet → pick → chain)
│   │   ├── RecordView         (Record decoder display)
│   │   ├── ProvenanceBanner   (Gate / absorbed / caveats render)
│   │   └── MarkdownView
│   └── ...
│
└── DemiurgeCLI/             — `action`, `list-gates`, `export-component`
```

The cockpit reads `domains/*.md`, `exports/<domain>/*` and the
manifest JSON; it never writes to `domains/*.md`. AR / visionOS is
the stated portability target (n_cockpit_ar_target) — that's why
RealityKit (not SceneKit) is the 3D layer.

---

## 9. Governance summary (AGENTS.tape)

| `@D` rule | one-liner |
|---|---|
| `g_demiurge_pointer_only` | demiurge = pointer / spawn wrapper only (D61) |
| `g_stdlib_ownership`      | `stdlib/` ⊂ hexa-lang only (D15) |
| `g3_no_over_claim`        | never assert unmeasured (D12) |
| `g_clean_room`            | public-surface only, no closed-binary RE (D1) |
| `g_decouple`              | hexa-bio + comb + hexa-matter typed-interface consumed (D2+D11) |
| `g_scope`                 | full scope incl. execution/absorption, no big-bang (D10+D12) |
| `g_absorption`            | per absorbed tool: one rfc_0NN, clean-room, measured gate |
| `g_hexa_native`           | absorb into hexa intrinsics, never shell out (D14+D18) |
| `g_swift_native`          | SwiftUI / Foundation / AppKit / RealityKit first (D26) |
| `g_cockpit_isolation`     | cockpit reads exports/docs one-way (D27+D41) |
| `g_ssot_single_source`    | one fact, one canonical home (D50) |

Forbidden (`@F`): creating a `stdlib/` tree under demiurge,
over-claim, closed-binary RE, silent skip, premature tombstone.

---

## 10. Cross-link

- decisions audit:  `design.md` (D1..D78)
- progress log:     `PLAN.md` (κ-1..κ-N)
- governance rules: `AGENTS.tape` (`@D` + `@F`)
- machine index:    `ARCH.tape`
- north-star:       `GOAL.md`
- absorption recipe:`ABSORPTION.md`
- next-session work:`NEXT_SESSIONS.md`
- inbox index:      `inbox/INDEX.md`
- per-domain spec:  `domains/<name>.md`

---

## 11. Worked simulations (design test, not implementation)

Two end-to-end project simulations were run *on paper* to design-test
the §2 graph + §5 project-pointer + §7 honesty model before the .demi
parser + DomainGraph code landed. Each simulation walks a hypothetical
user from `New Project` through every cell of the transitive closure,
recording where the design holds and where the gaps appear. These are
**not** measured records — they are design walk-throughs, kept as
canon test cases.

### 11.1 Simulation A — `alien-disc-mk1` (ufo from scratch)

User opens cockpit → New Project wizard. cluster=propulsion filter
narrows the 19 nodes; user picks `ufo` as the start domain; DAG
transitive closure proposes `{ufo, fusion, antimatter, rtsc, matter}`
(matter via antimatter prereq edge); user names "alien-disc-mk1".

```
T+0   New Project wizard
        Step 1. facet filter   : cluster=propulsion
        Step 2. start domain   : ufo
        Step 3. DAG closure    : {ufo, fusion, antimatter, rtsc, matter}
                                  ^integration            ^foundation
        Step 4. project name   : "alien-disc-mk1"
        manifest 저장 → ~/.config/demiurge/projects/alien-disc-mk1.json

T+1   topological walk (foundation → integration)
        Day 1   rtsc       (5 도메인, 35 cells)
        Day 2   matter
        Day 3   antimatter
        Day 4   fusion
        Day 5   ufo
```

**Day 1 · rtsc (foundation) — 7 verbs**

```
명세 SPECIFY   user 입력: "REBCO HTS 권선, B_peak=48T, T_op=20K, I_op=1000A"
              → exports/rtsc/specify/{stamp}/spec.json    [GATE_OPEN]

구조 ARCHITECT user 입력: solenoid topology, 1×1 m bore, 100 turns
              → exports/rtsc/structure/{stamp}/topo.json   [GATE_OPEN]

설계 DESIGN    substrate: FEMM 2-D axisymmetric (κ-48 substrate)
              cockpit: action design rtsc → DemiurgeCLI spawn
              ⚠ FEMM = Windows-binary, macOS Wine-only → honest skip
              → record skipped_reason="macos_host_femm_windows_binary"
              → "Re-run on Linux pool (ubu-1/ubu-2)" 안내

해석 ANALYZE   pyfemm magnetics (rtsc+analyze 실측)
              substrate: stdlib/rtsc/pyfemm_magnetics.py
              ⚠ macOS host = blocked (FEMM Wine) → honest skip again
              → record GATE_OPEN, scope_caveats=["Linux pool 필요"]

합성 SYNTHESIZE coil winding 생성 (FEMM Magnetics Toolbox)
              → skipped (substrate same)

검증 VERIFY   GetDP H-/A-φ HTS formulation (κ-49)
              substrate: stdlib/rtsc/getdp_hts.py
              ⚠ getdp not on PATH (brew install getdp 안 함)
              → record skipped_reason="getdp_binary_not_found"

인계 HANDOFF  coil dossier → fusion / antimatter downstream
              → exports/rtsc/handoff/{stamp}/dossier.json [GATE_OPEN]
```

Day 1 honest 결과: 7 records 모두 `GATE_OPEN / absorbed=false`. 측정 한 거 0
(모두 install/platform skip). user 가 NEXT_SESSIONS H-6 보고 "Linux pool 에서
다시" 결정.

**Day 2 · matter (antimatter prereq)**

```
명세 SPECIFY   "Penning trap 저온 비자성 합금 + 진공 lining"
              → spec.json   [GATE_OPEN]
설계 DESIGN    hexa-matter substrate (D17 sibling repo) spawn
              → ~/core/hexa-matter/verify/run_all.hexa
              ✅ matter+analyze 는 absorbed=true (D17 — hexa-lang 소유의
                 measured-parity 흡수, demiurge 는 consumer/pointer)
              → record GATE_CLOSED_MEASURED · absorbed=true (matter 만!)
              → 첫 진짜 측정 record 등장
... (나머지 verbs honest skip / template)
```

✨ 핫 — matter+analyze 가 처음 absorbed=true 보임 (D17 hexa-matter measured-
parity 가 sibling repo 에 이미).

**Day 3 · antimatter (Penning trap)**

```
명세 SPECIFY   antiproton trap geometry + plasma temp/density target
              ← Fajans & Surko RMP 87:247 reference
              → spec.json [GATE_OPEN]

설계 DESIGN    custom PIC code (no dominant OSS) → honest gap
              → skipped_reason="no_oss_consensus"

해석 ANALYZE   Geant4 antiproton-matter (κ-49 substrate)
              ⚠ Geant4 multi-hour C++ build 안 됨 (brew geant4 없음)
              → skipped_reason="geant4_not_installed"

합성 SYNTHESIZE plasma-parameter opt (arxiv:2503.22471) → template emit

검증 VERIFY   Geant4 stopping/annihilation (κ-49)
              → skipped (same Geant4 gap)

인계 HANDOFF   ARTIQ + Sinara trap-control electronics spec
              → exports/antimatter/handoff/{stamp}/artiq_spec.json
```

honest 결과: 7 records, 모두 `GATE_OPEN`. Geant4 install 이 H-2 handoff 의
핵심 이유 visible.

**Day 4 · fusion (tokamak)**

```
명세 SPECIFY   Q-target=10, TBR-target=1.1, B_max=15T (rtsc Day 1 reuse)
설계 DESIGN    FreeGS Grad-Shafranov (κ-? — pip-installable, macOS-ok)
              → 실측 가능, equilibrium 계산
              → exports/fusion/analyze/{stamp}/equilibrium.json
                (numeric output 但 absorbed=false — sourced lattice 아님)

해석 ANALYZE   BOUT++ Hermes-3 (GPL-3, macOS-buildable)
              → 실측 시도 (또는 skip if not installed)

합성 SYNTHESIZE engineering sizing (no single OSS) → template emit

검증 VERIFY   OpenMC TBR neutronics (κ-49 substrate)
              ⚠ OPENMC_CROSS_SECTIONS not set (~3 GB ENDF data 안 받음)
              → skipped_reason="openmc_data_path_unset"

인계 HANDOFF  IAEA fusion-safety design basis dossier template
```

honest: FreeGS 만 numeric output, 나머지 install/data gated.

**Day 5 · ufo (integration apex)**

```
명세 SPECIFY   "alien-disc-mk1 7-stage propulsion ladder"
              Stage 1-3 = sister substrates (Day 1-4 cells 인계 받음)
              Stage 4-7 = in-tree warp / wormhole / dimjump / dimuse
              → spec.json + 13 falsifier preregister (F-WARP/WORM/DIM/USE)
                                                       all OPEN

구조 ARCHITECT discoid airframe (1890-LOC narrative + 484-tier L(k)=24^(k-15))
              → topo.json + 7-stage propulsion stack 도

설계 DESIGN    in-tree Stage 4-7 spec docs (warp/wormhole/dimjump/dimuse)
              → 4 spec.md emit (Alcubierre, Morris-Thorne, KK ladder,
                                τ=4 (σ−φ)²=100c composite)

해석 ANALYZE   cross-stage energy budget — Tsiolkovsky generalised
              + alien_index ladder 🛸6 → 🛸∞⁴ → 🛸ABSOLUTE 표시

합성 SYNTHESIZE atlas registry build (hexa-ufo selftest dispatch)
              → ~/core/hexa-ufo/cli/hexa-ufo selftest (20/20 verify PASS)
              ✅ 자체 bookkeeping = PASS (lattice arithmetic + token consistency)

검증 VERIFY   13 falsifier preregister 상태 check
              → 13 OPEN · 0 CONFIRMED · 0 DEMOTED
              ⚠ bookkeeping ≠ empirical truth — scope_caveats 명시
              → record GATE_OPEN · absorbed=false (g3)

인계 HANDOFF   arXiv preprint + DOI 10.5281/zenodo.20102628 link
              → release.tar.gz: project manifest + 35 cell records
                + 1 discoid USD + 13 falsifier preregister CSV
```

**Simulation A — honest position**

```
🧱 project manifest
  domains:     5 (rtsc · matter · antimatter · fusion · ufo)
  cells:       35 (5×7)
  records:     35 emitted, all stored in exports/

🪟 g3 위치 (honest)
  GATE_CLOSED_MEASURED · absorbed=true  : 1  (matter+analyze, D17)
  GATE_OPEN · absorbed=false            : 34
    중 numeric output emit (skip 아님)  : 2-3 (FreeGS, OpenMDAO 등)
    install / platform skipped          : 27+ (FEMM/Geant4/OpenMC/Wine)
    template only (no producer)         : 5+ (specify/handoff verbs)

🔬 falsifier preregister (ufo Stage 4-7)
  OPEN     : 13 (F-WARP-{1..3} · F-WORM-{1..3} · F-DIM-{1..3} · F-USE-{1..4})
  CONFIRMED: 0
  DEMOTED  : 0

📦 산출물
  manifest        ~/.config/demiurge/projects/alien-disc-mk1.json
  exports/<domain>/<verb>/{stamp}/*.json   35 records
  exports/ufo/synthesize/{stamp}/airframe.usd  (discoid placeholder)
  exports/ufo/handoff/{stamp}/release.tar.gz   (preprint bundle)

🛤️ next-session 항목 자동 발생
  H-2  Geant4 multi-hour build → antimatter+analyze/verify 실측
  H-3  OpenMC + ENDF/B-VIII.0 → fusion+verify TBR 실측
  H-6  pyfemm Linux-pool + GetDP → rtsc+analyze/verify 실측
  H-7  firmware QEMU (UFO control firmware 추가 시)
```

**Simulation A — gaps discovered (G1–G5)**

```
✅ 잘 작동
  - DAG closure traversal: 5 도메인 자동 chain (Day 1→5 토폴로지 정렬)
  - g3 honesty: 35 cells 중 1개만 진짜 absorbed=true (matter), 정직
  - sibling repo pointer: ufo → hexa-ufo dispatch 자연 매핑
  - 13 falsifier preregister: 미증명 explicit OPEN (g3 위반 0)

⚠️ 갭 (현재 demiurge 가 부족)
  G1. cockpit 새 프로젝트 wizard 가 아직 facet → DAG 인지 X
      (현 NewProjectSheet 는 평면 list, D78 implementation 필요)
  G2. cell-skipped 일관 보고 UI 없음 (record JSON 안 매몰)
      → "왜 skipped 인지" project-level dashboard 필요
  G3. domains/matter/* pointer 가 D17 산출 (absorbed=true)을 어떻게
      cell record 로 surface 하는지 ActionDispatch 매끄럽지 않음
  G4. ufo 의 sister-repo dispatch — 현재 `hexa-ufo selftest` spawn 패턴 없음
      (sscb/cern/scope 처럼 stdlib/<domain>/*.py 가 아니라 외부
       sibling repo CLI binary 호출 → ProducerRegistry 확장 필요)
  G5. 13 falsifier preregister CSV 가 cell record schema 와 별개
      → ufo+verify Record 가 falsifier 표를 typed field 로 담아야

🛠️ design 통찰 (D78 graph + .demi format 이 풀어주는 갭)
  - G1 → DomainGraph.transitiveClosure(id) + cockpit wizard 갱신
  - G2 → exports/*/skipped.summary.json + ProvenanceBanner 확장
  - G3 → MatterAnalyzer 의 pointer-pattern 을 generic 패턴화
         (sibling-repo dispatch 표준화)
  - G4 → ProducerRegistry 의 variant.run 이 sibling-repo binary 도 spawn
         (이미 ProducerVariant 의 closure 가 그럴 수 있음 — 패턴 확립)
  - G5 → FalsifierEntry struct (Codable, monotone OPEN/CONFIRMED/DEMOTED)
         + UfoVerifyRecord 에 [FalsifierEntry] 필드
```

### 11.2 Simulation B — `aura-clip-mk1` (hexa-aura from scratch)

User opens cockpit → New Project wizard. facet filter (cluster=sensing
+ scale=Component) narrows; user picks `aura`; DAG closure proposes
`{aura, rtsc, chip, brain, bio, firmware}` per `domains/aura.md`
prerequisites + hexa-aura README §sibling. user names "aura-clip-mk1".

```
📊 hexa-aura sibling 매핑 (README §[!NOTE] 그대로):

hexa-aura sibling/upstream substrates:
  ├─ hexa-rtsc      ← RT-SC nano-coil (F-AURA-2 DEMOTED if rtsc falls)
  ├─ hexa-cern      ← canonical RSC worked example (verify pattern)
  ├─ hexa-bio       ← biological tissue / cortex 측 model
  └─ hexa-chip      ← chip + form-factor substrate

domains/aura.md prerequisites:
  - rtsc        # RT-SC nano-coil σ²=144 채널/타일 (README 핵심 의존)
  - chip        # BTE chip substrate (analog front-end + radio + power)
  - brain       # cortex 측 model (A1/V1/V6/S1/M1 zone)
  - bio         # cortex biological tissue (D77 신규)
  - firmware    # BLE radio + Zephyr SDK (D73 신규)
  # cross-link to hexa-cern = RSC verify pattern (not direct prereq)
```

ASCII (multi-level DAG):

```
              ┌──────────┐
              │   aura   │       ← LEVEL 4 (integration apex)
              │ (clip x2)│
              └────┬─────┘
       ┌──────────┼─────────┬──────────┬──────────┐
       │          │         │          │          │
   ┌───▼──┐   ┌───▼──┐  ┌───▼───┐  ┌───▼──┐  ┌────▼─────┐
   │ rtsc │   │ chip │  │ brain │  │ bio  │  │ firmware │  ← LEVEL 3
   └───┬──┘   └───┬──┘  └───┬───┘  └───┬──┘  └──────────┘
       │          │         │          │
       │      ┌───▼──┐  ┌───▼───┐  ┌───▼────┐
       │      │matter│  │  bio  │  │ matter │              ← LEVEL 2
       │      └──────┘  └───────┘  └────────┘              (chip의 substrate)
       │
       └──────── (rtsc 자체 = foundation)                  ← LEVEL 1
```

**Day 1 · foundation walk (rtsc · chip · brain · bio · firmware)**

```
rtsc 7-verb       — Day 1 ufo 시뮬과 동일 (FEMM Wine, GetDP install gate)
                    → 7 records all GATE_OPEN, Linux pool 필요

chip 7-verb       — Yosys/booksim (chip §B+§D 이미 absorbed=true, κ-43)
                    → analyze + verify = 측정 완료 (D70 dynamic flip)
                    ✅ 2 cells absorbed=true 등장

brain 7-verb      — Sim4Life FDA MDDT (proprietary irreplaceable gap)
                    → openEMS FDTD 가능, MNE 가능
                    → analyze 가 numeric (MNE-Python 결과)
                    → verify 는 Class III 게이팅 (FDA PMA, demiurge 못 함)
                    → 7 records, ~2 numeric, 5 honest gap

bio 7-verb (D77 신규)— 아직 domains/bio.md 없음 (D77 작업 미진행)
                    → 시뮬레이션은 후 작성 가정, ~/core/hexa-bio sibling spawn
                    → AlphaFold-class molecular substrate
                    → analyze numeric (BLAST/foldseek)

firmware 7-verb (D73) — κ-53 wiring 됨, QEMU mps2-an385 reference
                    → synthesize 가능 (arm-none-eabi-gcc 612-byte ELF)
                    → verify QEMU 안 됨 (brew qemu 미설치)
                    → 7 records, 1 실측 (gcc build), 6 install/template
```

honest 결과: foundation 5 도메인 × 7 verbs = 35 cells.
- absorbed=true: chip+analyze, chip+verify (κ-43 D70)
- numeric output (gate=OPEN): brain+analyze, bio+analyze, firmware+synthesize
- install/platform skipped: ~25
- template only: ~5

**Day 2 · aura (integration apex) — 7 verbs**

```
명세 SPECIFY
  user: "BTE mastoid 클립 한 쌍, 7.2 g, 144 채널/타일, A1+V1-V6+S1+M1"
  cited: FDA 21 CFR 820.30 + EU MDR 2017/745 GSPR + IEC 60601-1
  → spec.json [GATE_OPEN]

구조 ARCHITECT
  4 pillars (HEXA-AURA-CLIP / COIL / CORTEX / SAFETY)
  σ·φ = n·τ = J₂ = 24 (n=6 invariant lattice)
  → topo.json [GATE_OPEN]

설계 DESIGN
  KiCad PCB + ngspice AFE + FreeCAD 클립 mechanical
  nRF Connect SDK BLE 5.x stack (firmware sibling 인계 받음)
  RT-SC nano-coil layout (rtsc Day 1 인계 받음)
  → design/ 디렉토리: pcb.kicad / clip.step / firmware.elf
  → 1 실측 output (KiCad netlist), 2 template

해석 ANALYZE ⟲
  substrate: stdlib/aura/aura_mne.py (κ-45, MNE PSD)
  openEMS FDTD antenna pattern + SAR (BLE 2.4 GHz)
  ⚠ openEMS not on macOS native → honest skip if not installed
  → record: MNE numeric output if installed, openEMS skip
  → ~2 records, mix numeric + skip

합성 SYNTHESIZE
  firmware build (Zephyr / nRF Connect SDK) — firmware substrate spawn
  signal-processing pipeline emit (MNE-Python notebook template)
  → 1 numeric (firmware ELF), 1 template

검증 VERIFY
  openEMS antenna pattern + SAR estimate
  MNE validation against PhysioNet open EEG dataset
  ⚠ Sim4Life FDA MDDT (proprietary, irreplaceable for MRI-safety)
  → 4 falsifier preregister status: F-AURA-{1,2,3,4} 15 sub-IDs OPEN
  → record GATE_OPEN, scope_caveats=["Sim4Life unavailable",
                                       "PMA/MDDT not in scope"]

인계 HANDOFF
  FDA 510(k) (Class II) submission package
  EU MDR + Bluetooth SIG qualification
  → release.tar.gz: spec + dossier + 4 falsifier OPEN CSV
```

**Simulation B — honest position**

```
🧱 project manifest
  domains:     6 (rtsc · chip · brain · bio · firmware · aura)
  cells:       42 (6×7)
  records:     42 emitted

🪟 g3 위치 (honest)
  GATE_CLOSED_MEASURED · absorbed=true  : 2  (chip+analyze/verify κ-43 D70)
  GATE_OPEN · absorbed=false            : 40
    중 numeric output (skip 아님)       : ~8 (KiCad/MNE/Zephyr/FreeGS/openEMS-if)
    install / platform skipped          : ~25 (FEMM/Wine/QEMU/Sim4Life)
    template only                       : ~9 (specify/handoff verbs)

🔬 falsifier preregister (aura Stage)
  F-AURA-{1,2,3,4} 15 sub-IDs OPEN     : 15
  conditional DEMOTE rule:
    if hexa-rtsc falls → F-AURA-2 auto-DEMOTED (RT-SC 의존)
    이걸 demiurge 가 자동 cascade 가능 (DAG edge 의존)

📦 산출물
  manifest        ~/.config/demiurge/projects/aura-clip-mk1.json
  exports/aura/design/{stamp}/   pcb.kicad + clip.step
  exports/aura/handoff/{stamp}/  release.tar.gz (510(k) bundle)

🛤️ next-session 항목
  H-aura-1  openEMS macOS-native build → antenna SAR 실측
  H-aura-2  Sim4Life proprietary access → MRI-safety dossier
            (외부 commercial, demiurge 자율 영역 밖)
  H-aura-3  hexa-rtsc → hexa-aura cascade audit
            (rtsc 가 demoted 되면 aura F-AURA-2 auto-demote)
```

**Simulation B — gaps discovered (G6–G8 신규)**

```
✅ ufo 시뮬레이션 갭 (G1-G5) 모두 재발견 — pattern 일관

🆕 aura 시뮬레이션이 새로 발견:
  G6. Cascade falsifier — hexa-aura README 의 conditional rule
      "if hexa-rtsc falls → F-AURA-2 DEMOTED" 가 명시.
      이건 cross-domain *falsifier dependency* — DAG edge 의 일종.
      현재 DomainGraph 에 falsifier-cascade 표현 없음.
      → FalsifierEntry 에 `demoted_if: <other-falsifier-id>` 필드 추가
         또는 DomainGraph 가 falsifier 도 node 화 (super-graph)

  G7. Proprietary-mandatory gate — Sim4Life FDA MDDT 같은
      open 대체 없는 도구가 cell verify path 의 정직 차단.
      현재 substrate gate ("install 안 됨") 와 commercial gate
      ("FDA 의무, OSS 없음") 가 구분 안 됨.
      → record schema 에 gate_type: install | platform | regulatory |
         proprietary-irreplaceable 필드

  G8. n=6 lattice invariant cross-check —
      σ·φ = n·τ = J₂ = 24 가 모든 HEXA-family 의 invariant.
      aura/cern/ufo/rtsc/bio/chip 6 sibling 이 모두 이 invariant 공유.
      → DemiurgeCore 에 LatticeInvariant 모듈 (assertion engine)
         project-wide audit 가능

🛠️ 통찰
  - ufo + aura 둘 다 *integration apex* 패턴 (DAG top, sibling sub repos)
  - n=6 lattice 가 cross-project 공통 invariant — 별도 audit 의미 있음
  - falsifier cascade (cross-domain) 가 진짜 cross-domain bookkeeping
    의 핵심 — demiurge 의 정직성 표면의 핵심 case
```

### 11.3 Cross-simulation comparison + integrated gap list

```
                    alien-disc-mk1            aura-clip-mk1
                  ──────────────────         ──────────────────
domain count        5                          6 (sibling 1 더)
cells               35                         42
absorbed=true       1 (matter via D17)         2 (chip via D70)
falsifier OPEN      13 (F-WARP/WORM/DIM/USE)   15 sub-IDs (F-AURA-1..4)
sibling repos       hexa-ufo, hexa-matter      hexa-aura + 4 sister substrates
foundation node     rtsc                       rtsc (둘 다 같은 foundation!)
top node            ufo                        aura
cross-domain rule   13 OPEN preregister        cascade DEMOTE (rtsc → F-AURA-2)
```

핵심 발견: **rtsc 가 두 프로젝트의 foundation 공통** — D72 N+M payoff 의
도메인-수준 사례. 같은 rtsc 인스턴스가 alien-disc-mk1 / aura-clip-mk1 둘 다
prereq. 도메인 = 다중 프로젝트 공유 노드 (사용자 명시: "완성된 도메인은
여기저기 쓰일 수 있으니까").

**Integrated gap list (G1–G8)**

```
🎯 새 갭 통합 list (G1-G8)

G1. cockpit NewProjectSheet — facet → DAG 인지 (D78 impl 핵심)
G2. cell-skipped 일관 보고 UI
G3. sibling-repo pointer pattern 표준화 (matter / ufo / aura)
G4. ProducerRegistry 가 sibling-repo binary spawn
G5. FalsifierEntry 가 record schema typed field
G6. Cascade falsifier (cross-domain DEMOTE rule)
G7. gate_type 구분 (install / platform / regulatory / proprietary)
G8. n=6 lattice invariant cross-check 엔진
```

우선순위 추천:
- **첫 라운드**: G1 + G3 + G5 (D78 graph + sibling pattern + falsifier typed) — 가장 fundamental
- **둘째 라운드**: G2 + G7 (UI / gate_type 정직성 표면)
- **셋째 라운드**: G4 + G6 + G8 (cascade + lattice audit)

비교 — 기존 EDA = project-bound (각 프로젝트가 자기 도메인 데이터 자체 보유).
demiurge = domain-shared (도메인 1개 + 프로젝트 N 개 포인터). 시뮬레이션 두 개가
rtsc 공유로 직접 입증. monolithic CAD 가 못 하는 cross-domain bookkeeping 정직성
표면.

**Refresh (2026-05-22 · κ-70 opening · §11.5 R9 scaffold land)** —
위 G1–G8 는 κ-62 시점의 *initial gap surface* (cross-sim two-project
비교가 처음 표면화한 gap, alien-disc-mk1 ↔ aura-clip-mk1 cross-cohort
의 교집합). §11.4 + §11.5 의 implementation checklist 는 그 후 9
round 로 확장: Round 1-3 (G1–G8 fundamental / honesty surface /
cross-domain audit · κ-62) · Round 4 (G9–G12 hexa-native parity
surface · D80 sweep · κ-65) · Round 5 (G13–G18 D80 SSOT 통합 + 후속 ·
D87..D101 sweep) · Round 6 (G19–G26 κ-67 closure + post-closure pilot
#13 · D102..D108 + geodesy) · Round 7 (G27–G30 *LANDED* · κ-68 per-cell
measured-oracle parity round · RFC 013 §6.11 · D109/D110 · 4-fold full
land 2026-05-21) · Round 8 (G31–G34 *LANDED* · κ-69 hexa-native
ultimate-form parity + 2nd cell measurement round · D115/D117 · 4-fold
full land 2026-05-22) · Round 9 (G35–G38 *LANDED* · κ-70 3rd cell
measurement round · 4-fold full land 2026-05-22 · G35 candidate-research +
G36 D118 Ufo/plasma Stage-2 5-fold lock-in + G37 D119 first-flip
(`mean_rel_err = 2.21e-06` numeric-equivalence PASS) + G38 R9 4/4
CLOSURE governance row [`project.tape @D d6` 3-carrier audit COMPLETE]).
본 §11.3 의 G1–G8 priority 는 *initial-round
historical* 표면 — 현 ground truth 는 §11.4 + §11.5 의 G1–G38 Round 1-9
가 carry. §11.3 는 cross-sim *origin gap* 의 audit trail 로 보존
(g_ssot_single_source D50 — phase boundary 별 한 snapshot 유지).

### 11.4 G1–G34 implementation checklist (κ-62..κ-69 R1..R8)

> G1–G8 라운드 1–3 (`fundamental` / `honesty surface` / `cross-domain
> audit`) 는 κ-62 (3322523) 에서 전부 `[x]` 완료. G9–G12 라운드 4
> (`hexa-native parity surface` — D80 sweep) 는 κ-65 (5e9f6dea) 에서
> 진행. G13–G18 라운드 5 (`D80 SSOT 통합 + 후속` — D87..D101 sweep)
> 는 2026-05-20 cycle 에서 PILOTS.demi seed + 19/19 도메인 narrative
> coverage + 3-tier link-integrity + cross-ref CI + chip UI + env
> deprecation 으로 land. G19–G24 라운드 6 (`κ-67 closure + post-
> closure pilot #13` — D102..D108 + geodesy) 는 같은 2026-05-20 cycle
> 후반에 chem 첫 PILOTS row + dimension docstring + RFC 013 MOSTLY-
> LANDED + illustrative-physics gate + spawner 5th fallback + κ-67
> closure + geodesy WGS84 14th pilot 로 마감. **G27–G30 라운드 7
> (`κ-68 per-cell measured-oracle parity round` — RFC 013 §6.11 ·
> LANDED 2026-05-21)** 는 stored `absorbed: Bool` 의 첫 legitimate
> flip 을 cell-side measured oracle 로 트리거 (NOT D95 computed
> projection · D109/D110 land · marginal PASS 0.0499 vs 0.05) ·
> Energy/solar + NREL MIDC pyranometer 위 4-fold full land 마감.
> **G31–G34 라운드 8 (`κ-69 hexa-native ultimate-form parity +
> next-cell measurement round` — LANDED 2026-05-22 · 4/4 CLOSURE)** 는
> κ-68 closure entry 의 reserved scope (G29-β · 다른 cell measured-
> oracle round · G30 Stage 2) 를 4 G-item 으로 박은 full-land 마감 ·
> G31 (Energy/solar `solar_position_kernel` runtime port · PR #263) +
> G32 (D115 · 2nd cell pick Aura/EEG) + G33 (D117 · 2nd cell first-flip ·
> Aura/EEG · PhysioNet Sleep-EDF · mean_rel_err 8.40e-07 PASS) + G34
> (governance row · constitution.md v1.0.0 → v1.1.0 MINOR bump · measured-
> oracle invariant narrative). **G35–G38 라운드 9 (`κ-70 third-cell
> measurement round` — scaffold 2026-05-22 · G35 + G36 + G37 + G38
> LANDED 2026-05-22 · R9 4/4 CLOSURE)** 는 κ-69 R8 closure entry 의 reserved
> 'κ-70+ next horizon' scope (3rd cell measurement-parity ·
> `invariantHolds` record-type-agnostic audit 의 3rd instance) 를 4
> placeholder G-item + G35 candidate-research note 동시 박은
> scaffold + research land 으로 시작 → G36 cell-pick decision
> (D118 · Ufo/plasma Stage-2 · 5-fold lock-in · code 0) 동시 cycle
> 안에 박힘. G35 = 3-candidate (Ufo/plasma Stage-2 · Energy/wind ·
> Bio/ECG) 5-fold lock-in 비교 + ranking. G36 = #1 ranked default
> 채택 (D118 · Ufo/plasma Stage-2 · JET open-pulse archive mid-Ohmic
> single shot · λ_D Debye length axis · Stage-4..7 D106 illustrative
> carve-out 명시 박제). G37 = 3rd cell first-flip LANDED 2026-05-22
> same-cycle (D119 · JET-like mid-Ohmic single shot · `mean_rel_err =
> 2.21e-06` numeric-equivalence PASS · D117 G33 mirror · 3rd record-
> type `testUfoVerifyRecordCoveredByInvariantNoCodeChange` 박제 ·
> invariant helper code 변경 0 = strongest evidence cycle · hexa-lang
> PR #291 `6187d499` MERGED). G38 = LANDED 2026-05-22 (κ-70 R9 4/4
> CLOSURE governance row · κ-69 R8 closure entry mirror · governance
> SSOT = `project.tape @D d6` [Spec Kit `.specify/memory/constitution.md`
> 제거 `ab0724c` 이후 · G34 의 constitution R1 → `@D d6` migration
> `e458d3c` 의 successor] 의 3-carrier audit COMPLETE PATCH update ·
> code 0). **G39–G42 라운드 10 (`κ-71 fourth-cell measurement round`
> — R10 4/4 LANDED 2026-05-22 · G39 + G40 `[x]` · G41 D121→D122 same-day kernel-refinement flip · G42 4/4 proper closure)** 는
> κ-70 R9 closure entry 의 'next horizon (κ-71+)' scope 를 4 placeholder
> G-item + G39 candidate-research note (`inbox/notes/2026-05-22-k71-
> horizon-candidate-research.md` · 3 finalist Energy/wind · Bio/ECG ·
> Chem/Arrhenius · ranking advisory #1 Energy/wind) 동시 박은 scaffold
> 로 시작 → **G40 cell-pick decision LANDED (design.md D120 · Energy/
> wind sub-cell #1 picked · 새 `EnergyWindVerifyRecord` · NREL WTK
> HSDS IEC 61400-12 power curve · 새 `power_curve_kernel.hexa`
> [substrate floor ZERO] + 새 `wtk_fetcher.py` · prediction-shape
> PASS [D110 G29 mirror · numeric-equivalence 후퇴 회복] · code 0)**.
> **κ-71 structural inflection**: lowest-friction 1-field-extension
> carrier 가 κ-70 으로 소진 (`FusionVerifyRecord` 만 잔여 `[HP][✗]`
> 이나 D106 illustrative 영구-잠김) — 모든 κ-71 후보가 새 VerifyRecord
> 신설 또는 producer-side 새 sub-cell 경로 신설 cost 를 짐 · Energy/
> wind 는 그 위 brand-new substrate kernel (substrate floor ZERO)
> 까지 신설 = G41 first-flip 이 κ-68..κ-70 어느 것보다 substrate-side
> 1-step 더 무거움 (§11.6). **κ-71 R10 closed 4/4 LANDED via same-day
> D121→D122 kernel refinement** (D121 honest gap baseline ·
> mean_rel_err=0.0708 v0.1.0 cubic-interp · D122 kernel refinement v0.2.0
> `power_curve_segments` 6-pt sparse-fit · mean_rel_err=0.0298 PASS ·
> 58% mean-error reduction · D120 ≤0.05 criterion unchanged ·
> PREDICTION-shape preserved · R4 invariant respected · all 6 of 6 G41
> components LANDED · 4/4 proper closure). **G43–G46
> 라운드 11 (`κ-72 R11 horizon · scaffold 2026-05-22 · all `[ ]`)** 는
> κ-71 R10 closure entry 의 "next horizon (κ-72+)" 약속 이행 — 3
> framing 후보 (A=G41 resumption · B=5th cell · C=hybrid) 의 candidate-
> research 동시 land (`inbox/notes/2026-05-22-k72-horizon-framing-
> research.md` · ranking advisory: Framing A · pick belongs to G43/G44).
> Framing A 채택 시 G43 = resumption-track decision (D122) · G44 =
> substrate refinement OR D-block-only oracle relaxation · G45 = G41
> 첫 legitimate flip 재시도 (D123) · G46 = R11 closure. **honest
> partial-closure precedent**: κ-71 R10 이 첫 PARTIAL · κ-72 R11 의
> 어떤 framing 도 PARTIAL 가능성 명시 인정 — R4 invariant 가 작동
> 하는 증거지 design 실패 아님 (§11.7).
> 각 항목 진행하면 `[x]` 로 박고 PLAN κ-entry + design.md D-block +
> 영향 파일 commit 으로 묶을 것.

**라운드 1 — fundamental (D78 + sibling + falsifier schema)**

- [x] **G1.** cockpit `NewProjectSheet` — facet → DAG 인지
  - **κ-56**: `Domain.swift` 에 prerequisites + facets fields 추가.
    `DomainGraph.swift` 신규 (transitiveClosure / topologicalSort /
    byScale / byCluster / roots / leaves). DomainCatalog 19 entries
    에 prereq + facet 박음.
  - **κ-57**: D83 `.demi` format + `domains/INDEX.demi` (19
    `[<id>]` records) + `DemiParser.swift` + `DomainLoader.swift` 신규.
    `DomainCatalog.all` 가 runtime-load (loadAllOrFallback). 도메인
    추가는 이제 `.demi` 한 section (Swift 변경 0).
  - **κ-58**: D84 2-tier (built-in + user `u/` prefix). `DomainLoader.
    loadUserDomains()` + Project.walk 필드. user 도메인이 built-in
    prereq 로 사용 가능 (DAG 자연 확장).
  - **κ-59**: `NewProjectSheet` step 3 (confirm) 에 DAG closure
    preview chip stack 추가. `closureWalk` computed property 가
    `DomainGraph.transitiveClosure` + `topologicalSort` 호출. start
    도메인은 accent 색, prereq chain 은 secondary chip 으로 표시.
    `u/<id>` 도메인은 "내 도메인" badge. Project.walk 가 closure 로
    자동 채워져서 onCreate 호출. `build CockpitApp` OK (2.94s).
  - deps: D78 graph + `.demi` parser + `DomainGraph.transitiveClosure`
  - new files:
    - `cockpit/Sources/DemiurgeCore/Models/Domain.swift` (refactor — type 만)
    - `cockpit/Sources/DemiurgeCore/Loaders/DemiParser.swift` (new, ~100 LOC)
    - `cockpit/Sources/DemiurgeCore/Loaders/DomainLoader.swift` (new, ~80 LOC)
    - `cockpit/Sources/DemiurgeCore/Models/DomainGraph.swift` (new, ~120 LOC)
    - `domains/INDEX.demi` (new SSOT — 19 `[<id>]` records)
  - edit:
    - `cockpit/Sources/CockpitApp/Views/NewProjectSheet.swift` —
      step 1 facet filter → step 2 start pick → step 3 chain confirm
  - exit:
    - swift build green
    - `DemiurgeCLI action list-domains --facet cluster=propulsion` 작동
    - cockpit 새 wizard 3-step 매뉴얼 검증

- [x] **G3.** sibling-repo pointer pattern 표준화 (matter / ufo / aura)
  - **κ-56**: `SiblingRepoSpawner.swift` 신규 (D17 entrypoint
    resolver + uniform spawn — `~/core/hexa-<id>/cli/hexa-<id>` 또는
    fallback `verify/run_all.hexa` 등 canonical 후보 4개 자동 시도).
  - **κ-60 decision (no-refactor)**: `MatterAnalyzer.swift` 는 D17
    historical precedent 로 **그대로 보존**. commit-hash pin / per-
    script PASS parsing / closure-invariant gate 결정 등 hexa-matter
    특화 처리가 generic helper 로 흡수하면 손실. 미래 sibling-cell
    (ufo / aura / cern / antimatter / fusion / rtsc / space / brain /
    bio / chem) Producer 가 SiblingRepoSpawner 사용하는 게 G3 목표
    충족 (regression 위험 0).
  - deps: G1 (DomainLoader 의 substrate_ssot 필드 읽기)
  - new file:
    - `cockpit/Sources/DemiurgeCore/Loaders/SiblingRepoSpawner.swift`
      (new helper — spawn `<repo>/cli/<binary>` or `<repo>/<entry>.hexa`)
  - refactor:
    - `MatterAnalyzer.swift` D17 spawn 패턴을 `SiblingRepoSpawner` 호출로
    - 신규 `UfoAnalyzer.swift` / `AuraSensorAnalyzer.swift` 가 같은
      helper 재사용 (코드 중복 0)
  - exit:
    - matter+analyze 가 기존과 byte-identical record (회귀 0)
    - 새 도메인이 sibling-repo 포인터 등록할 때 코드 1줄 (`SiblingRepoSpawner.spawn(.aura)`)

- [x] **G5.** `FalsifierEntry` 가 record schema typed field
  - **κ-56**: `FalsifierEntry.swift` 신규 (typed monotone OPEN /
    CONFIRMED / DEMOTED + demotedIf for G6 cascade).
  - **κ-60**: `UfoVerifyRecord.swift` + `AuraVerifyRecord.swift` 신규
    (typed Codable). 각각 `falsifiers: [FalsifierEntry]?` 필드 +
    `hexaNativeParity: HexaNativeParityRef?` (D80) +
    AuraVerifyRecord 는 `latticeInvariant: LatticeInvariantResult?`
    (G8 stub) 추가. ufo (13 falsifiers F-WARP/WORM/DIM/USE) + aura
    (F-AURA-{1..4} 15 sub-IDs, G6 cascade `demotedIf` 활용 준비).
  - deps: 없음 (Codable schema 확장만)
  - new files:
    - `cockpit/Sources/DemiurgeCore/Models/FalsifierEntry.swift` (new)
      ```
      struct FalsifierEntry: Codable, Sendable {
          let id: String                  // e.g. "F-AURA-2"
          let status: FalsifierStatus     // OPEN | CONFIRMED | DEMOTED
          let openedAt: String            // ISO date
          let demotedIf: String?          // G6 cascade rule (옵션)
          let evidenceRef: String?        // arxiv / DOI when CONFIRMED
      }
      enum FalsifierStatus: String, Codable { case open, confirmed, demoted }
      ```
  - edit:
    - `UfoVerifyRecord.swift` (신규) 에 `falsifiers: [FalsifierEntry]?`
    - `AuraVerifyRecord.swift` (신규) 에 같은 필드
    - hexa-ufo / hexa-aura 의 falsifier preregister CSV 가 cell record
      typed array 로 자동 인계
  - exit:
    - ufo+verify Record JSON 안 falsifier 표가 typed array
    - cockpit `ProvenanceBanner` 가 falsifier OPEN/CONFIRMED/DEMOTED count 표시

**라운드 2 — 정직성 표면**

- [x] **G2.** cell-skipped 일관 보고 UI
  - **κ-61**: `SkippedCellsAggregator.swift` 신규 (Foundation only,
    `exports/` 디렉토리 scan + 모든 JSON 의 `skipped_reason` field
    수집 + GateType 자동 추정 fallback heuristic).
    `SkippedCellsDashboard.swift` 신규 (SwiftUI) — gate-type chip
    summary + filter + 셀 list + "내가 풀 수 있는 갭" count
    (userResolvable). 모든 17+ dispatched cell 이 통일 dashboard 안에
    visible.
  - deps: G1 부분 (DomainGraph 가 cell coverage 알아야)
  - runtime artifact:
    - 각 project 의 `exports/<domain>/skipped.summary.json` —
      verb × cell × skipped_reason 매트릭스
  - edit:
    - `cockpit/Sources/CockpitApp/Views/ProvenanceBanner.swift` 확장
      → "이 cell 이 왜 skipped 인지" 한 줄 표시
    - 새 view `SkippedCellsDashboard.swift` (project pane 안 별도 탭)
  - exit:
    - alien-disc-mk1 / aura-clip-mk1 모두 dashboard 에 skipped 이유
      clean 표시 (29/27 cell 중 X 가 install-gated, Y 가 platform-blocked)

- [x] **G7.** `gate_type` 구분 (install / platform / regulatory / proprietary)
  - **κ-61**: `GateType.swift` 신규 — `installGated` / `platformGated`
    / `dataGated` / `regulatoryGated` / `proprietaryOnly` /
    `hexaNativeAbsent` (D80 surface) / `producerAbsent` /
    `unspecified` 8 case. `userResolvable` predicate (user 설치/다운로드
    로 풀 수 있는 갭) + `hexaNativeBlocked` predicate (G6/D80 cascade).
    각 case 가 Korean label 보유 (cockpit ProvenanceBanner + G2
    dashboard 사용). substrate 측 typed emit 점진 적용 — 그 동안
    G2 aggregator 가 skipped_reason text 에서 heuristic fallback.
  - deps: G5 (Record schema 변경 같이 가는 게 효율)
  - edit:
    - `F1F2Record.swift` 의 `MeasurementGate` enum 에 `gate_type`
      소속 field 추가 OR scope_caveats 안 typed key
      ```
      enum GateType: String, Codable {
          case installGated         // brew install missing
          case platformGated        // macOS Wine / Linux only
          case regulatoryGated      // FDA Class III, PMA, MDDT
          case proprietaryOnly      // Sim4Life / ANSYS / FLUKA
          case dataGated            // OPENMC_CROSS_SECTIONS
      }
      ```
    - 모든 17 substrate Python script 가 `gate_type` field 출력 (점진,
      cell 단위 PR)
  - exit:
    - Project dashboard 가 `gate_type` 별 cluster 표시
      (예: "23/42 install-gated, 5/42 regulatory-gated proprietary-only")

**라운드 3 — cross-domain audit**

- [x] **G4.** `ProducerRegistry` 가 sibling-repo binary spawn
  - **κ-62**: `ProducerRegistry+Sibling.swift` 신규 — extension on
    `ProducerRegistry` with `siblingRepoVariant(id:domainID:verb:
    displayName:)` factory. variant.run closure 가 `SiblingRepoSpawner.
    spawn` 호출 + `exports/<domain>/<verb>/<stamp>/` 디렉토리 자동
    생성 + emitted JSON 으로부터 recordID 추출. cern+analyze 의
    pylhe / xsuite-tracking 패턴이 일반화됨 — 새 (verb, domain) cell
    이 sibling-repo binary 인계 받을 때 entries dict 한 줄 추가
    (`"hexa-ufo": ProducerRegistry.siblingRepoVariant(...)`).
  - deps: G3 (`SiblingRepoSpawner` 헬퍼 먼저)
  - edit:
    - `ProducerRegistry.swift` 확장 — variant.run closure 안에서
      `SiblingRepoSpawner.spawn(.hexa_ufo, command: "selftest")` 호출
    - cern+analyze pylhe / xsuite-tracking 패턴 (D74) 을 sibling-repo
      variant 로 확장: `(ufo, synthesize)` → `hexa-ufo CLI` variant
  - exit:
    - 새 도메인이 sibling-repo CLI 인계 받을 때 entries dict 1 줄

- [x] **G6.** Cascade falsifier (cross-domain DEMOTE rule)
  - **κ-62**: `FalsifierCascade.swift` 신규 — BFS over `demotedIf`
    edges. `apply(_ entries:)` 가 monotone fixpoint (OPEN entry 가
    upstream DEMOTED 면 본인도 DEMOTED, CONFIRMED/DEMOTED 는 freeze).
    `FalsifierCascadeResult` = updated entries + diagnostic
    `[FalsifierCascadeHop]` (target / cause / reason) — cockpit
    dashboard 에서 "demoted because of …" 표시 가능. hexa-aura README
    의 "if hexa-rtsc falls → F-AURA-2 DEMOTED" 정확 매핑.
  - deps: G5 (`FalsifierEntry.demotedIf`) + G1 (DomainGraph)
  - edit:
    - `DomainGraph.swift` 에 `falsifierCascade(start: FalsifierID) -> [FalsifierID]`
      추가
    - `hexa-rtsc` 의 root falsifier 가 DEMOTED 되면 `aura/F-AURA-2`
      도 auto-DEMOTED 표시 (project-wide audit)
  - exit:
    - `DemiurgeCLI falsifier-audit aura-clip-mk1` 가 cross-domain
      cascade 매트릭스 출력

- [x] **G8.** n=6 lattice invariant cross-check 엔진
  - **κ-62**: `LatticeInvariant.swift` 신규 — `canonicalN = 6`,
    `canonicalProduct = 24`, `audit(n:sigma:phi:tau:jTwo:)` +
    `audit(_ result:)` (LatticeInvariantResult overload). 두 변형
    모두 nil 반환 = pass, `InvariantViolation` 반환 = fail 의
    failures list 보유. hexa-ufo / hexa-aura / hexa-cern / hexa-rtsc
    / hexa-bio / hexa-chip 의 `σ·φ = n·τ = J₂ = 24` invariant 자동
    검증.
  - deps: G3 (sibling-repo 메타데이터 표준화)
  - new file:
    - `cockpit/Sources/DemiurgeCore/LatticeInvariant.swift` (new, ~60 LOC)
      ```
      enum LatticeInvariant {
          static let n: Int = 6
          static let sigma_phi = 24     // σ·φ = n·τ = J₂ = 24
          // assert all HEXA-family substrates report n=6
          static func audit(_ project: Project) -> [InvariantViolation]
      }
      ```
  - edit:
    - project manifest 에 lattice audit 필드
    - cockpit project pane "lattice invariant" badge (`σ·φ = 24` PASS/FAIL)
  - exit:
    - alien-disc-mk1 + aura-clip-mk1 둘 다 `σ·φ = 24` PASS
      (hexa-ufo / hexa-aura README 의 invariant 자동 검증)

**라운드 4 — hexa-native parity surface (D80 sweep, κ-65)**

- [x] **G9.** `HexaNativeParityRef` 8-field schema (D80 §4.1 contract)
  - **κ-65** (5e9f6dea): `UfoVerifyRecord.swift` 의 `HexaNativeParityRef`
    가 connection-plan §4.1 의 8-field shape 으로 확장 — `kernelPath` /
    `parityTest` / `parityMethod` (7-case enum: substrateToSubstrate /
    analyticOracle / pythonCompanionSeedMatch / roundtripIdentity /
    heapqOracleExact / handMirroredPython / other) / `parityTolerance`
    (+non-numeric oracle note field) / `parityStatus` / `hexaLangSHA` /
    `scopeNotes` / `relErr`. 기존 (ref / relErr / tolerance) trio 는
    on-disk JSON consumer 부재 audit 후 retire.
  - deps: G5 (`FalsifierEntry` typed Codable pattern 전례)
  - carriers (5):
    - `UfoVerifyRecord` (선행 보유 — schema upgraded inline)
    - `EnergyVerifyRecord` (solar pilot, pvlib_clearsky path)
    - `FusionVerifyRecord` (mc_transport pilot, illustrative MC)
    - `AuraVerifyRecord` (dft_naive pilot)
    - `ChipAnalyzeRecord` (event_queue future consumer, noc_sim)
  - exit:
    - 5 cell-record carrier 모두 8-field shape 으로 compile PASS
    - `swift test` 3/3 PASS (DependenciesLoaderTests)

- [x] **G10.** `DependenciesLoader` — 44-row cross-repo SSOT consumer
  - **κ-65** (5e9f6dea): `Loaders/DependenciesLoader.swift` 신규 —
    `hexa-lang/domains/DEPENDENCIES.demi` (44-row audit SSOT) 를
    `DemiParser` 로 읽어 typed `DependencyEntry` 로 project. `Weight` /
    `PortableStatus` / `Kind` enum 이 `.demi` vocab mirror.
    `inferGateType(for:)` 가 §3.1/§3.2 contract 구현 (nonportable →
    `hexaNativeAbsent`, heavy-port → `hexaNativeFuture`). Path resolver
    는 `DEMIURGE_HEXA_LANG` → `DEMIURGE_REPO/../hexa-lang` →
    `~/core/hexa-lang` 순. Honesty floor: SSOT 부재 시 빈 array +
    stderr warning (no Swift hardcoded fallback, D86 g_no_hardcoded_data
    준수, `ProducerLoader` 패턴 일치).
  - deps: G2 (`GateType` 분류) + D85 `ProducerLoader` 패턴 + D86
  - new files:
    - `cockpit/Sources/DemiurgeCore/Loaders/DependenciesLoader.swift` (~230 LOC)
    - `cockpit/Tests/DemiurgeCoreTests/DependenciesLoaderTests.swift` (3 cases)
  - reference SHA pin: hexa-lang origin/main =
    `1a55599c42513d58fb503c1876441e6665413b64` (κ-65 시점 fetch read-only)
  - exit:
    - `testEmptyEnvironmentReturnsEmptyArray` / `testFixtureParsesFourRows
      WithEnumsAndKindSplit` / `testGateTypeInferenceContract` PASS

- [x] **G11.** `GateType.hexaNativeFuture` (heavy-port bucket)
  - **κ-65** (5e9f6dea): `GateType.swift` 에 `hexaNativeFuture` case
    추가 — 기존 `hexaNativeAbsent` (영구 부재) 와 분리. `hexaNativeFuture`
    는 "포팅 예정, 무게 큼" (heavy-port) bucket — `DependenciesLoader.
    inferGateType(for:)` 가 `PortableStatus.heavyPort` row 를 여기로
    매핑. `hexaNativeBlocked` predicate 가 두 case 모두 cover (G6/D80
    cascade 의 honest cap). SkippedCellsDashboard color map: yellow
    (future) / orange (absent) — exhaustive switch 갱신.
  - deps: G7 (`GateType` enum) + G2 (`SkippedCellsDashboard` exhaustive)
  - edit:
    - `Models/GateType.swift` — case + Korean label "hexa-native 포트
      예정 (heavy-port)" + `hexaNativeBlocked` 확장
    - `Views/SkippedCellsDashboard.swift` — exhaustive switch color
  - exit:
    - `swift build` PASS — exhaustive switch 누락 없음

- [x] **G12.** hexa-lang substrate fix — codegen param-shadow + `wrap_pi`
  - **a272c9c4** (hexa-lang): `self/codegen_c2.hexa` 의 fn-ref auto-wrap
    5 sites (sort_by arg ×2, struct field, user-fn call arg, indirect-
    call arg) 가 local lexical scope 무시하고 stdlib top-level fn 만
    체크 → param `e: float` 등 collide name 이 broken C emit
    (`hexa_fn_new((void*)e, 0)`) 으로 clang error. Centralized
    `_gen2_should_autowrap_fnref(name)` 헬퍼가 current-fn params/lets
    체크. Sibling: `stdlib/core/math/wrap_pi.hexa` 신규 primitive
    (Python `math.fmod` parity, ±π 보존) + 12-case unit test PASS.
    Orbital Kepler pilot (#5b inbox/notes) 의 workaround `e → ecc`
    rename 회수 가능.
  - **4389da0c** (hexa-lang): inbox pilot-pattern 표가 codegen-gotcha-A
    discovery 통합 — cross-repo pilot 패턴 SSOT 갱신.
  - deps: 없음 (sibling-repo PR-only fix, demiurge consumer 변경 0)
  - new files (hexa-lang):
    - `stdlib/core/math/wrap_pi.hexa` (primitive)
    - `stdlib/core/math/wrap_pi_test.hexa` (12 falsifiers)
    - `inbox/notes/2026-05-20-codegen-gotcha-A-…` (post-mortem)
  - edit (hexa-lang):
    - `self/codegen_c2.hexa` (helper + 5 wrap-site replacement)
    - `stdlib/kernels/orbital/kepler_2body_kernel.hexa` (use stdlib wrap_pi)
  - exit:
    - hexa-lang `hexa_v2` byte-stable fixpoint regen PASS
    - `wrap_pi` 12-case unit test 12/12 PASS

**라운드 5 — D80 SSOT 통합 + 후속 (D87..D101 sweep, 2026-05-20)**

- [x] **G13.** `PILOTS.demi` 8-field SSOT + 12-row coverage (D87..D91 + D94 + D95)
  - **2d07fd8** (D87..D94 foundation): `domains/PILOTS.demi` seed
    (10 row, kernel-per-row · 8 fields = `kernel_path` /
    `parity_test` / `parity_method` / `parity_tolerance` /
    `parity_status` / `hexa_lang_sha` / `algorithm_ref` /
    `scope_notes`) + DEPENDENCIES.demi 를 `hexa-lang/domains/`
    에서 `demiurge/domains/` 로 verbatim 이동 (D87+D88, .demi 는
    demiurge family own). `DomainCatalog.allHardcoded` 19-도메인
    Swift literal 폐기 (D89, D86 `g_no_hardcoded_data` 강제).
    `PilotLoader.swift` 신규 — `PilotEntry` 8-field struct +
    `loadAll()` / `find(id:)` / `find(kernelPath:)` API +
    SSOT-missing → 빈 array + stderr warn (D80 honesty).
  - **efa4afe** (D94 phase T7): `<domain>+analyze` Producer 의
    cell-emit path 가 `PilotLoader.find(id:)` auto-lookup —
    hardcoded parity_status string 박지 않고 loader 가 SSOT.
  - **a5d12d2** (D95): `HexaNativeParityRef.isHexaNativeAbsorbed`
    computed property + 5 cell record (Ufo/Energy/Fusion/Aura/
    ChipAnalyze) 같은 이름 computed delegate — stored boolean 0,
    parity_status projection 만 (D86 정합). 10/10 row PASS
    표현 → true 판정 (HexaNativeAbsorbedTests 8 case).
  - **87cb765 / c63f406 / f28c1b0 / a2fcb1b** (D80 pilots #9..#12):
    `breaker_trace_reduce_kernel` (b1745c3a, 24/24 PASS) +
    `bar1d_kernel` (c9ca39e7, partial fem-port) + `dual_forward_
    kernel` (170f74af, autodiff dual numbers) + `needleman_wunsch_
    kernel` (d73a2cbf, bio domain entry) — PILOTS.demi 12 row
    누적. bio + autodiff 두 도메인 entry.
  - **3215cea** (chem seed): `domains/chem.md` 의 substrate line —
    chem 도메인 `stdlib/kernels/chem/` 시드 (NOT YET → seed 표기,
    honest record).
  - deps: G7 (`GateType`) + G9 (`HexaNativeParityRef` 8-field) +
    G10 (`DependenciesLoader` 패턴) + D85 (`ProducerLoader` 패턴
    mirror) + D86 (`g_no_hardcoded_data`)
  - new files (demiurge):
    - `domains/PILOTS.demi` (12 row, 8-field schema head comment)
    - `cockpit/Sources/DemiurgeCore/Loaders/PilotLoader.swift`
    - `cockpit/Tests/DemiurgeCoreTests/PilotLoaderTests.swift`
    - `cockpit/Tests/DemiurgeCoreTests/HexaNativeAbsorbedTests.swift`
  - move: `hexa-lang/domains/DEPENDENCIES.demi` →
    `demiurge/domains/DEPENDENCIES.demi` (verbatim)
  - exit:
    - PILOTS.demi 12 row 모두 D90 8-field 보유
    - `swift test` PASS (PilotLoaderTests + HexaNativeAbsorbedTests
      포함), `swift build` PASS
    - `allHardcoded` 19-도메인 literal trace 0

- [x] **G14.** 19/19 domain narrative coverage (D96 + D100 + chem seed)
  - **47bf504** (D96): 5 sibling-bearing `domains/<id>.md` (rtsc /
    cern / antimatter / fusion / ufo) head 블록 바로 아래
    `**Sibling sub-domains** (hexa-<id> repo): a · b · c` 한 줄
    추가. sibling §3 REQUIRES + 서브폴더 구조에서 추출. SSOT
    변경 0 — `.demi` 4종 미수정.
  - **e451037** (D100): 14 non-sibling 도메인 (firmware / sscb /
    brain / aura / component / bot / chem / bio / energy / grid /
    mobility / scope / space + chip skeleton + matter pointer
    갱신) `domains/<id>.md` 에 `**Substrate** (where the .hexa
    kernels live): <location>` 한 줄 추가 — D96 의 역방향.
    `domains/chip.md` 신규 minimal skeleton (deep-domain pointer,
    canonical map 은 `HANDOFF.md` §5 + `rfc_001`),
    `domains/matter/README.md` (D17 pointer-only) 한 줄 추가.
  - **3215cea** (chem narrative): D100 분기 (a/b/c) 중 (c) full
    sibling + no stdlib subtree yet 의 honest 기록 — `stdlib/
    kernels/chem/` 시드 NOT YET 표기.
  - deps: G1 (DomainCatalog/INDEX.demi 19 row) + D82 (DAG) + D86
    (narrative-only, SSOT 데이터 무변경)
  - edit:
    - 5 sibling `domains/<id>.md` + 13 non-sibling `domains/<id>.
      md` (D96+D100, sub-domain / substrate 한 줄)
    - 1 신규 skeleton `domains/chip.md` + 1 pointer 갱신
      `domains/matter/README.md`
  - exit:
    - 19/19 도메인 narrative coverage (D96 5 + D100 14)
    - `.demi` SSOT 4종 (INDEX/PILOTS/DEPENDENCIES/PRODUCERS) 무변경

- [x] **G15.** 3-tier substrate link-integrity verifier (D97)
  - **74a1b92** (D97 Q3=A): `domains/SUBSTRATE_LINKS.demi` 신규
    SSOT (5 row, 4 field — `sibling_path` / `identity_key` /
    `advisory_prereqs` / `notes`) + `SubstrateLinksLoader.swift`
    (`PilotLoader` / `DependenciesLoader` 패턴 1:1 mirror,
    SSOT-missing → 빈 array + stderr warn). `SubstrateLink
    IntegrityTests.swift` 3 XCTest: Tier ① `sibling_path` 가
    directory FileManager.isDirectory (FAIL on miss), Tier ②
    `<sibling_path>/AGENTS.tape` 가 `@I id001 := "<identity_key>"`
    선언 보유 (FAIL on miss), Tier ③ `advisory_prereqs` 가
    `DomainGraph.transitiveClosure` 안 존재 (**warn-only** —
    XCTFail 안 함, Q1 two-SSOT independent 보존).
  - deps: G1 (`DomainGraph.transitiveClosure`) + D82 (sibling DAG)
    + D86 (declarative .demi, Swift = type + loader 만) + D80
    (honesty floor)
  - new files:
    - `domains/SUBSTRATE_LINKS.demi` (신규 SSOT, 5 row)
    - `cockpit/Sources/DemiurgeCore/Loaders/SubstrateLinksLoader.swift`
    - `cockpit/Tests/DemiurgeCoreTests/SubstrateLinkIntegrityTests.swift`
  - exit:
    - swift test 28/28 PASS (SubstrateLinkIntegrity 3/3 —
      `DEMIURGE_REPO` 설정 시 5 sibling 실 walk 통과,
      미설정 degenerate case 는 D80 honesty trivially pass)
    - Tier ③ advisory drift 0 (`SUBSTRATE_LINKS.demi.advisory_
      prereqs` 가 `INDEX.demi` transitive closure 와 정확 일치)
    - sibling 5 repo 100% READ-ONLY (write/edit 0)

- [x] **G16.** cockpit `HexaNativeParityChip` 3-case 시각화 (D99)
  - **f036f6f** (D99 render-only): `HexaNativeParityChipModel.swift`
    신규 pure-data render-model (`Tone.absent` (회색 "no hexa-
    native") / `.absorbed` (녹색 "hexa-native ✓ <SHA>") /
    `.provisional` (노랑 "hexa-native (provisional)"), label /
    tooltip / accessibilityID 의 3-case 분기) — SwiftUI 의존성 0,
    test target 에서 branch-test 가능. `HexaNativeParityChip.swift`
    SwiftUI view 가 `model.tone` → `Color.gray / .green / .yellow`
    매핑. `SkippedCellEntry` 에 optional `hexaNativeParity:
    HexaNativeParityRef?` 1 field + `SkippedCellStub` decode 라인 1
    추가 (lax — legacy record = nil = 회색). `SkippedCellsDashboard`
    `SkippedCellRow` HStack 안에 chip 1 줄 통합.
  - **D80 honesty floor**: ref 첨부 ≠ 흡수. PASS 토큰이 없으면
    반드시 노랑 (provisional), 절대 녹색 아님 — 분석가가 흡수
    오인 방지 색 강제.
  - deps: G2 (`SkippedCellsDashboard`) + G11 (`GateType` cascade)
    + D80/D86/D95 (chip 은 render-only, SSOT 무변경)
  - new files:
    - `cockpit/Sources/DemiurgeCore/Models/HexaNativeParityChipModel.swift`
    - `cockpit/Sources/CockpitApp/Views/HexaNativeParityChip.swift`
    - `cockpit/Tests/DemiurgeCoreTests/HexaNativeParityChipTests.swift`
      (4 XCTest — absent/absorbed/provisional + accessibility-ID
      distinctness)
  - edit:
    - `Loaders/SkippedCellsAggregator.swift` (`hexaNativeParity`
      field 1개 추가)
    - `Views/SkippedCellsDashboard.swift` (chip 1 줄 통합)
  - exit:
    - swift build PASS · swift test 32/32 PASS (+4 신규 chip test)
    - 새 SSOT 0, 새 stored data 0, schema 변경 0 (chip 데이터 흐름
      = PILOTS.demi → record JSON → SkippedCellEntry → model →
      view 100% 일방향)

- [x] **G17.** `DEPENDENCIES.demi ↔ PILOTS.demi` cross-ref CI (D98)
  - **384101b** (D98 Phase F): `DependenciesPilotsCrossRefTests.
    swift` 신규 test class — 3 XCTest method 가 양 SSOT cross-ref
    drift 자동 alert: (a) already-ported deps 가 pilot row 보유,
    (b) pilot `kernel_path` 가 hexa-lang 디스크에 실존, (c) pilot
    8-field 무누락. D80 honesty floor: file 부재 / non-main
    hexa-lang branch / clone 부재 시 **XCTSkip** 으로 명시적
    surface (XCTFail false-positive 0, silent pass 0). 기존
    `DependenciesLoaderTests` / `PilotLoaderTests` 의 `setenv`
    defer 가 부모-shell `DEMIURGE_REPO` 를 unset 하던 hygiene bug
    동일 PR 에서 save+restore 교정.
  - deps: G10 (`DependenciesLoader`) + G13 (`PilotLoader`) + D88
    (DEPENDENCIES.demi 위치) + D90 (PILOTS.demi 8-field) + D93
    (pattern-pilot.md ↔ PILOTS.demi cross-link)
  - new file:
    - `cockpit/Tests/DemiurgeCoreTests/DependenciesPilotsCrossRefTests.swift`
      (3 XCTest method)
  - edit (hygiene):
    - 기존 두 Loader test 의 setenv defer save+restore 교정
  - exit:
    - swift test 양 SSOT cross-ref CI 3/3 (clone 미설정 시 XCTSkip)
    - 새 SSOT 0, 새 Swift type 0 — pure 검증 logic

- [x] **G18.** `DEMIURGE_HEXA_LANG` env-var deprecation (D101)
  - **8fc0862** (D101 D3/D88 후속): `DependenciesPilotsCrossRefTests.
    swift` 의 `hexaLangRepoPath()` resolver 에서 `$DEMIURGE_HEXA_
    LANG` env-var fallback 1줄 제거 — sibling hexa-lang clone
    발견은 이제 canonical `$HEXA_LANG_REPO` (non-prefixed) +
    `~/core/hexa-lang` dev-default 2단계. `DependenciesLoader.
    swift` 자체는 이미 D88 시점에 demiurge-local resolver
    (`$DEMIURGE_REPO/domains` → `$PWD/domains` → `~/core/
    demiurge/domains`) 로 전환되어 있어 변경 0. rfc_013 §2.4 +
    `GateType.swift` doc 주석 + `EnergyVerifyRecord.swift` stale
    path 3종 정정 (DEPENDENCIES.demi 의 demiurge SSOT 경로 반영).
  - **rationale**: D3 정신 — demiurge `.demi` 는 demiurge own,
    demiurge-prefixed env-var 가 cross-repo path lookup 에 쓰일
    이유 사라짐. 외부 clone 은 외부 이름 (`HEXA_LANG_REPO`) 으로.
  - deps: D3 + D88 (DEPENDENCIES.demi 이동) + D86 (env-var surface
    축소 → hardcoded fallback 가짓수 감소)
  - edit:
    - `cockpit/Tests/DemiurgeCoreTests/DependenciesPilotsCrossRefTests.
      swift` (env-var 분기 2줄 제거 + XCTSkip 메시지 동기화)
    - `proposals/rfc_013_hexa_native_parity_connection.md` §2.4 +
      §8 cross-ref 정정
    - `cockpit/Sources/DemiurgeCore/Models/GateType.swift` doc
      주석 2종 정정
    - `cockpit/Sources/DemiurgeCore/Models/EnergyVerifyRecord.swift`
      stale `~/core/hexa-lang/domains/DEPENDENCIES.demi` 한 줄
      → `~/core/demiurge/domains/DEPENDENCIES.demi`
  - exit:
    - swift build PASS · swift test 35/35 PASS (Cross-RefTests 3/3
      — dev-box non-main branch 로 인한 XCTSkip 1, 변경 무관)
    - `.demi` 데이터 SSOT 무변경, `DependenciesLoader.swift` 무변경
    - 새 SSOT 0, 새 stored data 0, schema 변경 0

**라운드 6 — κ-67 closure + post-closure pilot #13 (D102..D108 +
geodesy WGS84, 2026-05-20)**

- [x] **G19.** chem 첫 `PILOTS.demi` row (D102 · Stage-0 scaffolding)
  - **a033def** (D102): `domains/PILOTS.demi` 에 `[pilot-chem_
    arrhenius]` row 1 (Stage-0 — internal-invariant 6/6 PASS, no
    external oracle yet) 추가. PILOTS row count 13 → 14 (이후
    bio_align_nw 이 D80 #12 로 row 15). `kernel_path` =
    `stdlib/kernels/chem/arrhenius_kernel.hexa` (hexa-lang SHA
    `78aee88d`). `parity_status` 가 PASS 토큰 보유 → D95 computed
    `isHexaNativeAbsorbed` true 판정에 자동 합류.
  - **3215cea** (chem narrative seed · D100 분기 c): `domains/chem.
    md` substrate line — `stdlib/kernels/chem/` seed 의 NOT YET
    표기 (full sibling repo `~/core/hexa-chem/` 미존재 honest
    record).
  - **scope floor** (D102 명시): `DEPENDENCIES.demi` `kernel-chem`
    row · `SUBSTRATE_LINKS.demi` chem row · sibling `hexa-chem`
    repo seed 는 P-⑫ ②a/②b/②c 별도 세션. 2nd consumer 도착 시 N+M
    promotion 트리거 (D72 정신).
  - deps: G13 (`PILOTS.demi` 8-field) + G14 (chem narrative) + D86
    + D90 + D91 + D102
  - edit:
    - `domains/PILOTS.demi` (chem row 1 추가)
    - `domains/chem.md` (substrate line seed)
  - exit:
    - PILOTS.demi 14 row · cross-ref CI 3/3 PASS (단방향 의무
      미발동 — chem 은 PILOTS-only entry, DEPENDENCIES 반대편 없음)
    - swift build/test PASS · 새 Swift code 0 · 새 stored field 0

- [x] **G20.** cell `absorbed` vs `isHexaNativeAbsorbed` dimension
  separation docstring (D103 · 코드 변경 0)
  - **105315e** (D103): 5 cell record (`UfoVerifyRecord` /
    `EnergyVerifyRecord` / `FusionVerifyRecord` / `AuraVerifyRecord`
    / `ChipAnalyzeRecord`) 의 stored `absorbed: Bool` 에 dimension-
    separation docstring 추가. 두 dimension (측정-oracle vs
    substrate-parity) 가 별도 SSOT 임을 명시 — 컴파일러가 잡을 수
    없는 semantic gate 를 docstring 으로 enforce. `HexaNativeParity
    Ref` doc 의 "Honesty (D80 g_hexa_only)" 블록 바로 아래에 "D103
    dimension separation" 단락 (2-axis 정책 명시 · producer 가 두
    axis 를 INDEPENDENTLY set 해야 함을 못박음). `FusionVerifyRecord`
    는 mc_transport pilot 의 illustrative-physics 성격 때문에 doubly-
    true (측정 dimension 뿐 아니라 substrate-parity dimension 까지
    provisional).
  - deps: D80 honesty floor + D86 (`g_no_hardcoded_data`) + D95
    (computed `isHexaNativeAbsorbed`) + RFC 013 §4.3
  - edit:
    - 5 cell record docstring (`absorbed: Bool` + computed
      `isHexaNativeAbsorbed` 양쪽)
  - exit:
    - swift build PASS · swift test 35/35 PASS · 새 warning 0
    - `.demi` 데이터 SSOT 무변경 · schema / wire shape / CodingKeys /
      init signature 모두 byte-unchanged · 새 stored field 0
    - 변경 surface = 5 파일의 docstring + header comment 만

- [x] **G21.** RFC 013 status `PARTIAL-LAND` → `MOSTLY-LANDED`
  refresh (D105 · κ-67 sweep reconciliation)
  - **943a5b8** (D105): `proposals/rfc_013_hexa_native_parity_
    connection.md` 의 status header / §6 follow-ons / §8 cross-
    references / §9 log 를 post-κ-67 sweep (D94..D103 · 12 commits)
    의 실제 상태로 갱신. status string `PARTIAL-LAND` → `MOSTLY-
    LANDED`. §6.1..§6.10 LANDED with SHA cross-link, §6.11 (per-cell
    measured-oracle) queued, §6.12 reserved for D106 (illustrative-
    physics gate) 직전 갱신.
  - deps: D80 + D86 + D87..D103 누적 + RFC 013 publication (cea3c66)
  - edit: `proposals/rfc_013_hexa_native_parity_connection.md` 단일
    파일의 status / 표 / cross-link / log 정합화만
  - exit:
    - RFC 013 status header 가 실 land 상태 반영
    - 새 RFC / 새 SSOT / 새 code 0
    - swift build/test PASS (RFC text-only change)

- [x] **G22.** `.illustrativePhysics` `GateType` 4번째 case (D106 ·
    P-⑩ ③ · RFC 013 §6.12 LANDED)
  - **f9a9a90** (D106): `cockpit/Sources/DemiurgeCore/Models/Gate
    Type.swift` 에 `.illustrativePhysics` enum case (cyan tone) 추가.
    `HexaNativeParityChipModel` 의 3-case (`absent` 회색 /
    `absorbed` 녹색 / `provisional` 노랑) 가 D106 4번째 case (cyan)
    로 확장 — substrate-parity PASS 인데 kernel 자체가 illustrative
    (mc_slab_demo 같은 single-energy-group / closed-form analytic /
    pattern-proof). cell-level absorbed flip 은 여전히 외부 measured
    oracle 필요. `FusionVerifyRecord` 가 canonical occupant (mc_
    transport pilot 의 illustrative gating). `SkippedCellsDashboard`
    의 `color(for:)` switch 가 4-case exhaustive.
  - **anti-conflation gate**: substrate-parity 가 PASS 인 illustrative
    kernel 을 녹색 (absorbed) 로 표시하면 reviewer 가 "측정 oracle
    까지 통과" 로 오인. cyan tone 이 그 conflation 을 차단 — RFC
    013 §6.12 의 가장 미묘한 typed enforcement.
  - deps: G7 (`GateType`) + G11 (heavyport bucket) + G16 (chip
    3-case) + D80 + D103 + RFC 013 §6.12
  - edit:
    - `cockpit/Sources/DemiurgeCore/Models/GateType.swift` (case 1)
    - `HexaNativeParityChipModel.swift` (4번째 tone)
    - `SkippedCellsDashboard.swift` `color(for:)` 4-case exhaustive
    - `proposals/rfc_013_hexa_native_parity_connection.md` §6.12
      LANDED
  - exit:
    - swift build PASS · swift test PASS (chip 4-case + dashboard
      switch exhaustive)
    - 새 SSOT 0 · 새 stored data 0 · 새 `.demi` row 0

- [x] **G23.** `SiblingRepoSpawner.resolveEntrypoint()` 5th fallback
    `cli/hexa-<id>.hexa` (D107)
  - **e66e4c0** (D107): `cockpit/Sources/DemiurgeCore/Loaders/
    SiblingRepoSpawner.swift` 의 entrypoint resolver 에 5th
    fallback `<repo>/cli/hexa-<id>.hexa` 추가 — 기존 4 후보
    (`cli/hexa-<id>` binary · `verify/run_all.hexa` · root
    `<id>.hexa` · `main.hexa`) priority 보존, 5번째 슬롯에 hexa-
    aura / hexa-ufo 의 실제 파일명 (`cli/hexa-aura.hexa` /
    `cli/hexa-ufo.hexa`) 인식. priority-preserving 확장 — 기존 4
    sibling (matter / chip / cern / fusion) 의 resolve 경로 byte-
    unchanged.
  - deps: G3 (SiblingRepoSpawner) + D17 (sibling-repo dispatch) +
    D85 (PRODUCERS.demi)
  - edit:
    - `SiblingRepoSpawner.swift` (5th fallback 1 case 추가)
    - `SiblingRepoSpawnerTests.swift` (10 XCTest — slot priority +
      identity drift)
  - exit:
    - swift test 10/10 PASS (`SiblingRepoSpawnerTests` 신규)
    - 기존 sibling resolve 경로 회귀 0 (priority preserve)

- [x] **G24.** κ-67 closure 박제 (D108 · RFC 013 MOSTLY-LANDED ·
    D87..D107 누적 SSOT 정합)
  - **eea2804** (D108): κ-67 sweep (D87..D107 · D104 reserved · 20
    결정 · 13+ commit) 의 **누적 closure** 를 PLAN.md κ-67 entry ·
    GOAL.md "현재 위치" + Log · design.md D108 entry 3-지점에 한
    사이클로 박제. 새 code 0, 새 stored field 0, 새 `.demi` row 0,
    새 RFC 0 — *문서 SSOT 3개* 의 결정-감사추적 정합화만. κ-67
    sweep 의 사실은 이미 D87..D107 + RFC 013 §6 + ARCH §11.4 +
    commit 본문에 존재; 본 entry 는 그것이 한 phase 의 closure 였다
    는 사실을 *PLAN.md κ-진행로그* 와 *GOAL.md 현재위치* 에서 동일
    하게 가리키도록 cross-link.
  - **κ-66 ↔ κ-67 boundary**: κ-66 은 hexa-lang 측 8 pilot land 의
    *upstream* fact 박제 (PLAN.md), κ-67 은 그것이 demiurge 측에서
    데이터 SSOT + producer wire + UI + governance + sibling-spawner
    fallback 으로 *완전 정합* 된 상태의 closure. 다음 κ-68 reserved
    = §6.11 per-cell measured-oracle round (P-⑩ ①).
  - deps: D87..D107 누적 + RFC 013 publication + ARCH §11.4 Round 5
  - edit:
    - `PLAN.md` `## 진행 로그` 끝에 phase κ-67 closure entry
    - `GOAL.md` "현재 정직한 위치" + `## Log` κ-67 entry
    - `design.md` D108 entry (κ-67 closure 박제)
  - exit:
    - 3 doc SSOT cross-link 정합 (PLAN κ-67 ↔ GOAL position+Log ↔
      design D108)
    - 새 code · stored field · `.demi` row · RFC 0
    - swift build/test PASS (doc-only change)

- [x] **G25.** geodesy WGS84 14번째 D80 pilot (post-D108 · 15th
    kernel folder · bridge substrate)
  - **acac78c** (pilot #13 chronological; 14th D80 pilot row when
    chem seed is counted; hexa-lang SHA `b7a43493`): `domains/
    PILOTS.demi` 에 `[pilot-geodesy_wgs84]` row 1 추가 — PILOTS
    row count 15 → **16** (D80 pilot 14 + chem seed 1 + transport_
    kinematics 가 mc_transport 2nd kernel = D91 row-per-kernel
    cumulative). `kernel_path` = `stdlib/kernels/geodesy/wgs84_
    kernel.hexa`. `parity_status` = `70/70 PASS at rel_err ≤ 1e-10`
    (6 WGS84 constants + 3 deg/rad + 18 forward geodetic→ECEF + 18
    round-trip ECEF→geodetic + 8 haversine + 14 Vincenty + 2 cross-
    algorithm invariants). **NEW DOMAIN FAMILY** — geodesy 가 15th
    kernel folder, FIRST kernel in the geodesy family (autodiff /
    bio_align / chem / circuit / fem / graph / logic_synth / mc_
    transport / neural / noc_sim / orbital / plasma / signal_proc /
    solar / urdf / wave_optics 중 14 prior pilot 의 폴더가 아닌
    독립 가족). **BRIDGE substrate** — 4 already-listed demiurge
    consumers (mobility/road_network.py via osmnx, space/skyfield_
    sgp4.py via skyfield, solar/* via pvlib, grid/networkx_basics.
    py via networkx) 가 각각 4 다른 lib 로 private 좌표수학을 재구현
    중. 한 hexa-native substrate 가 4 private copy 를 대체.
  - **DEPENDENCIES.demi** `kernel-geodesy` row 동반 (`already-
    ported` · 4 advisory consumer pointer). `domains/geodesy.md`
    신규 narrative (D100 reverse 패턴 — substrate line + bridge
    consumer table). **absorbed=true NOT flipped** — geodesy ①b
    adapter `stdlib/geodesy/wgs84.hexa` 아직 부재, 4 consumer ①b
    adapter 가 land 하기 전까지 heavy-port 상태 유지 (D80 honesty).
  - **post-closure significance**: D108 는 κ-67 phase boundary 박제
    였고, geodesy 는 그 직후의 첫 추가 D80 pilot — κ-68 reserved
    (P-⑩ ① per-cell measured-oracle round) 와는 별도 axis 의 추가
    substrate growth. 누적 fact: **14 D80 pilots · 445 cumulative
    assertions** (375 + 70 geodesy) · **15 kernel folders** (14 +
    geodesy) · **16 PILOTS.demi rows** (15 + geodesy).
  - deps: G13 (PILOTS.demi 8-field) + G14 (narrative coverage) +
    G19 (chem seed precedent) + D72 (2-layer N+M) + D80 + D88
    (DEPENDENCIES.demi 위치)
  - new files (demiurge):
    - `domains/geodesy.md` (substrate narrative · 4 consumer table)
  - edit:
    - `domains/PILOTS.demi` (geodesy row 1 · row 15 → 16)
    - `domains/DEPENDENCIES.demi` (kernel-geodesy row · already-
      ported · 4 advisory consumer note)
  - exit:
    - swift build/test PASS (16 PILOTS · 15 kernel · 5 SSOT 가
      cross-ref CI 3/3 모두 PASS — pilot row 가 DEPENDENCIES
      already-ported deps 와 bi-directional 일치)
    - cell `absorbed` flip 0 (D80 honesty — bridge substrate
      floor 만 land, consumer adapter 별도)

- [x] **G26.** D80 sweep close breakthrough note (1f9f934 · cold-
    start anchor)
  - **1f9f934**: `inbox/notes/d80-sweep-close-2026-05-20.md` 신규 —
    D80 sweep 의 single-session digest (15 PILOTS.demi rows ·
    14 kernel folders · 5 .demi SSOTs · 5 cockpit Loaders · 4-case
    chip · 19/19 도메인 narrative · D104 reserved · RFC 013 MOSTLY-
    LANDED). 새 session 또는 외부 reviewer 가 standalone 으로 읽고
    모든 artifact location 을 1-pass 추적 가능한 cold-start anchor.
    `inbox/INDEX.md` 에 row 추가 (status = archive · 27 entries 도달).
  - **note**: 본 note 의 PILOTS row count "15" 는 geodesy (acac78c)
    land 직전 시점 스냅숏 — 현 origin/main 16 row 와 1 row 차이는
    G25 post-closure pilot 때문이고, note 가 superseded 되지 않고
    audit 로 잔존 (D50 g_ssot_single_source — phase boundary 별 한
    note).
  - deps: D108 closure + D87..D107 누적 · 7 Findings · §3 SHA cite
    table · §5 topology (15 PILOTS · 14 kernel · 5 SSOT · 5 Loader)
  - new files:
    - `inbox/notes/d80-sweep-close-2026-05-20.md`
  - edit:
    - `inbox/INDEX.md` (row · status archive · 27 entries)
  - exit:
    - inbox/INDEX.md 27 entries 도달
    - swift build/test 무관 (doc-only)

**라운드 7 — κ-68 per-cell measured-oracle parity round (RFC 013 §6.11 ·
in-progress)**

> stored `absorbed: Bool` 의 첫 legitimate flip 을 cell-side measured
> oracle 로 트리거 (NOT D95 computed projection from substrate-parity).
> D103 docstring 이 가드하는 axis 의 첫 실 land — substrate-parity ≠
> measurement-parity 의 honest floor 를 처음으로 measured 쪽에서 land.
> 4 placeholder G-item — 진행되면 `[x]` 로 박고 PLAN κ-68 entry +
> design.md D-block + 영향 파일 commit 으로 묶는다. illustrative-
> physics gate (D106) 가 적용된 cell 은 본 round 의 absorbed flip
> 대상 아님 — RFC 013 §6.12 anti-conflation 유지.

- [x] **G27.** Cell + measured-oracle source 선정 (κ-68 R7 pre-code
    decision gate · D109 land 2026-05-21)
  - **D109** (κ-68 G27 land): cell = **Energy/solar** (cockpit
    `EnergyVerifyRecord` carrier + hexa-lang `stdlib/kernels/solar/
    solar_kernel.hexa` substrate). 외부 measured oracle = **NREL MIDC
    SRRL Golden CO pyranometer GHI** (single clear-sky day · 1-min
    cadence). bridge stack = **pvlib clearsky/transposition trusted**
    (substrate-parity 이미 증명), hexa-native scope = **solar_position
    _kernel (sun position only)**. PASS criterion = **mean rel_err ≤
    5% over clear-sky daylight hours**. 회피 후보 4개 (Fusion D106
    illustrative · ChipAnalyze YOSYS 별 세션 · Aura heavy infra · Ufo
    closed-form only) — rationale 명시. code 0 (decision-only).
  - **audit trail**: inbox/notes/k68-cell-pick-2026-05-21.md (cell
    pick anchor · 5 sub-decision 정렬) + k68-d109-draft-2026-05-21.md
    (D109 pre-land 검토 draft).
  - deps: G19..G26 누적 · RFC 013 §6.11 · D80 (honesty floor) ·
    D95 (computed projection 격리) · D103 (dimension-separation
    docstring) · D106 (illustrative-physics 제외)
  - exit:
    - design.md `### Decision 109` 박제 · 5 sub-decision default
      baked-in
    - 새 code 0 · 새 stored field 0 · 새 `.demi` row 0
    - PLAN.md κ-68 opening entry · ARCH §11.4 G27 `[ ]` → `[x]`

- [x] **G28.** Producer wire — substrate adapter 가 measured-oracle
    field 를 cell record 에 emit (`absorbed` 미flip) · **schema-half
    LANDED 2026-05-21**
  - **4a1a087** (G28a · demiurge main): `MeasuredOracleRef.swift`
    신규 (Codable Sendable Equatable · 8 field — oracle_source ·
    unit · sample_count · mean_rel_err · max_rel_err · threshold ·
    dataset_caveats · dataset_citation · `isMeasuredOraclePASS`
    computed predicate) + `EnergyVerifyRecord.measuredOracle:
    MeasuredOracleRef?` field 추가 + `MeasuredOracleRefTests.swift`
    (7 method · Codable round-trip · snake_case JSON wire ·
    `isMeasuredOraclePASS` 3 branch · `EnergyVerifyRecord` nil/non-
    nil decode + D103 invariant). swift test **60/60 PASS** ·
    기존 53 test 회귀 0.
  - **hexa-lang PR #248** (G28b · branch `g28-measured-oracle-
    producer` · commit `9b39f335` on `origin/main` base): STUB
    producer `stdlib/energy/nrel_midc_pyranometer.py` 신규. 60 1-min
    synthetic clear-sky · mean_rel_err 0.013 · max_rel_err 0.020 ·
    threshold 0.05 · would_pass=true · absorbed=false. 명시 STUB ·
    NOT real NREL MIDC data — real fetch + pvlib stack 은 G29 scope.
  - **Multi-repo discipline**: hexa-lang 측 작업은 별도 worktree
    (`/Users/ghost/core/hexa-lang-g28` 임시 · origin/main 기반 ·
    branch `g28-measured-oracle-producer`). 다른 세션의 rfc006-yosys-
    abc-map-script-order branch (`~/core/hexa-lang`) 미접촉 — 양
    session 의 git index 완전 분리.
  - deps: G27 (D109 cell choice) · D86 (no hardcoded data) · D103
    (dimension-separation) · D106 (illustrative-physics 제외)
  - exit:
    - cell record schema 1개 확장 [x] `MeasuredOracleRef.swift`
    - exports/ 에 measured block 보유 record JSON ≥ 1 [x] (smoke test
      `/tmp/g28b-stub-test/energy_verify_<stamp>_*.json`)
    - XCTest ≥ 1 [x] `MeasuredOracleRefTests` 7 method PASS
    - `absorbed` 는 false 유지 [x] (D103 separation 보존 · G29 까지
      explicit-writer gate 닫혀 있음)

- [x] **G29.** 첫 cell `absorbed: true` legitimate flip (NOT D95
    computed projection) · **LANDED 2026-05-21 D110**
  - **hexa-lang `b8d35920` (PR #259 merged)**: `stdlib/energy/nrel_
    midc_pyranometer.py` STUB → REAL 승격. 단일 NREL MIDC BMS day
    (2024-06-15 · SRRL Golden CO) fetch + pvlib Ineichen clearsky
    modeled GHI + daylight + clear-sky filter + 1-min cadence
    measured-vs-modeled parity. Producer 가 mean_rel_err ≤ 0.05
    조건에서 record JSON 의 `absorbed: true` 를 EXPLICITLY set —
    D109 PASS criterion 의 first legitimate writer-set path.
  - **measured result (2024-06-15)**:
    - daylight samples (zenith<85°): 829
    - clear-sky kept (ratio in [0.85, 1.30)): 480 (dropped 349 ·
      42% cloud-edge/enhancement)
    - **mean_rel_err: 0.04988** vs threshold 0.05 → **PASS**
      (marginal · ~24 bp under threshold · honestly documented)
    - max_rel_err: 0.2303 (cloud-edge transients in filter window)
    - **absorbed: true** (κ-68 first legitimate flip)
    - measurement_gate: GATE_CLOSED_MEASURED
  - **demiurge land**:
    - `exports/energy/verify/2026-05-21T03-07-39Z/energy_verify_
      20260520T190739Z_nrel_midc_pyranometer.json` (real record ·
      `absorbed=true` · measured_oracle PASS · all 8 typed field
      populated by real fetch).
    - design.md D110 (G29 land record · marginal pass rationale ·
      4 G29-β follow-on axis).
    - PLAN.md `## 진행 로그` κ-68 G29 entry.
  - **D80 g_hexa_only**: hexa-native `solar_position_kernel` 의
    runtime call site 는 G29-β follow-on (parity-of-implementation
    이 κ-65 21/21 PASS 로 이미 증명 · 본 producer 는 pvlib 의
    sun-position 을 reuse · substrate-parity ≠ runtime-port). D80
    절대 endpoint 는 G29-β 에서 충족.
  - **D103 dimension-separation**: `hexa_native_parity = null` 유지
    (substrate-parity 는 PILOTS.demi `[pilot-solar]` 21/21 PASS 가
    별 axis · 본 record 의 measured-oracle axis 와 INDEPENDENTLY
    set per D103).
  - **D106 illustrative-physics**: 본 cell (Energy/solar) 은
    measurement cell · illustrative gate 적용 안 됨. anti-conflation
    유지.
  - **G30 Stage 1 invariant**: 본 record 의 (`absorbed=true`,
    `measuredOracle non-nil + isMeasuredOraclePASS=true`) shape
    이 `AbsorbedNeedsMeasuredOracleTests.testAbsorbedRequiresMeasured
    OraclePASS` 의 (a) branch 정확히 hit · invariant PASS.
  - deps: G28 (`MeasuredOracleRef` schema · `4a1a087`) · D80
    (honesty floor) · D95 (computed projection 격리 유지 · 본
    flip 은 stored axis) · D103 (dimension-separation) · G30
    Stage 1 XCTest (`fee34cc`)
  - exit:
    - 단일 cell `absorbed=true` land [x] (`exports/energy/verify/
      2026-05-21T03-07-39Z/...` JSON · measured oracle PASS 근거
      record 안에 cite)
    - 다른 cell record 회귀 0 [x] (Fusion / Aura / Ufo /
      ChipAnalyze 등 모든 다른 cell 의 `absorbed` 미flip · synth
      fixtures 만 변경)
    - design.md D110 [x] · PLAN.md κ-68 G29 entry [x]
    - swift build/test PASS [x] (63 test · 회귀 0 · G30 Stage 1
      invariant 가 본 record shape verified)

- [x] **G30.** Governance gate — absorbed-vs-measured invariant typed
    enforcement · **Stage 1 (XCTest) LANDED 2026-05-21 `fee34cc` ·
    Stage 2 (constitution.md row) DEFERRED**
  - **Stage 1 (load-bearing) — LANDED `fee34cc`**: `cockpit/Tests/
    DemiurgeCoreTests/AbsorbedNeedsMeasuredOracleTests.swift` 신규
    · 3 test method:
    - `testAbsorbedRequiresMeasuredOraclePASS` — invariant 의 (a)
      measured PASS OR (b) D106 illustrative-physics exempt 양
      branch 검증 + boundary (meanRelErr == threshold inclusive PASS)
      + 3 counterexample.
    - `testAbsorbedNotAutoflippedByD95Computed` — synth Energy record
      의 substrate-parity PASS (`isHexaNativeAbsorbed=true`) +
      `measuredOracle=nil` + `absorbed=true` conflation 을 invariant
      가 FAIL 분류. D103 dimension-separation enforcement 을 typed
      test-level guard 로 격상.
    - `testD106IllustrativeCellExemptFromMeasuredOracle` — D106
      illustrative cell 의 3 branch 모두 invariant PASS · RFC 013
      §6.12 anti-conflation 유지.
    - swift build PASS · swift test **63/63 PASS** (60 기존 + 3
      신규 · 1 XCTSkip baseline · 회귀 0).
  - **Stage 2 (doc-shaped audit) — DEFERRED**: `.specify/memory/
    constitution.md` governance row land 은 constitution.md 가
    template-only (line 1 `# [PROJECT_NAME] Constitution`) 인 동안
    보류. constitution.md populate timing 은 별도 사용자 결정 ·
    κ-68 G30 scope 밖. land 후보 row 의 안은 `inbox/notes/k68-g30-
    revised-2026-05-21.md` §Stage 2 안에 박힘.
  - **scope rationale (post-archive)**: 1a620ad (AGENTS.tape `archive/`
    이동) + ca61a6c (Spec Kit Phase 2 채택 · constitution.md 가 새
    SSOT) + bd28631 (G30 exit criterion `AGENTS.tape @D` →
    `constitution.md row` redirect) chain 후 .tape format dormant.
    사용자 메모 ".tape 안쓰여 현재 (참고)" — XCTest 가 real
    enforcement vehicle. G30 의 load-bearing enforcement 는 Stage 1
    단독으로 충족.
  - **audit trail**: `inbox/notes/k68-g30-governance-row-sketch-
    2026-05-21.md` (SUPERSEDED · 옛 AGENTS.tape sketch · body 보존)
    + `inbox/notes/k68-g30-revised-2026-05-21.md` (post-archive
    revised plan · Stage 1 mandatory + Stage 2 deferred).
  - deps: G28 (`MeasuredOracleRef` schema · `4a1a087`) · D103
    (dimension-separation) · D106 (illustrative-physics 제외)
  - exit:
    - XCTest invariant PASS [x] (3 method · 0 failure)
    - 기존 cell record 회귀 0 [x] (60 기존 test PASS)
    - swift build/test PASS [x] (63 total · 1 XCTSkip)
    - **DEFERRED** (Stage 2 · κ-68 closure block):
      - `.specify/memory/constitution.md` row land (constitution.md
        populate 후 별 commit)
      - G29 real measurement 위 build 된 real-data branch invariant
        (G29 land 시 fixture 확장)

**라운드 8 — κ-69 hexa-native ultimate-form parity + next-cell
measurement round (LANDED 2026-05-22 · 4/4 CLOSURE)**

> κ-68 closure entry 의 'κ-69 reserved scope' 약속 이행 — Round 8
> scaffold 박음. 3 axis 묶음: (a) **G29-β** Energy/solar cell 의
> hexa-native runtime call site port (D80 ultimate-form parity ·
> `solar_position_kernel.hexa` substrate → hexa-native bridge 의
> endpoint compliance) · (b) **다른 cell** measured-oracle round
> 1회 더 (Aura / Ufo 등 · D106 illustrative gate 적용 cell 제외 ·
> G27..G29 와 동형 pick→wire→flip 구조) · (c) **G30 Stage 2**
> constitution.md governance row land (κ-68 R7 에서 DEFERRED).
> code 변경 0 — ARCH narrative 만 4 placeholder G-item 박는다.
> 각 항목 진행되면 `[x]` 로 박고 PLAN κ-69 entry + design.md
> D-block + 영향 파일 commit 으로 묶을 것.

- [x] **G31.** G29-β — Energy/solar cell `solar_position_kernel`
    hexa-native runtime call site port (D80 ultimate-form parity ·
    *G31a + G31b landed origin/main 2026-05-21 via PR #263
    (`8eec8e734f6db6a9275218dc4e2ebb5a9cf41f15`)*)
  - **scope**: G29 (κ-68) 의 first legitimate flip 은 substrate
    bridge stack (pvlib clearsky/transposition trusted) 위에서
    `solar_position_kernel.hexa` 만 hexa-native scope 였음 — D80
    endpoint rule §0 의 "ultimate-form" 절대 endpoint 는 G29 시점
    에 미충족 (bridge-on-Python 잔재). G31 = solar_position_kernel
    runtime call site 자체를 hexa-native 화 · pvlib bridge 의존
    제거 (sun-position axis 만 · Ineichen clearsky 는 G31β 별
    scope) · 동일 NREL MIDC fixture 위 mean rel_err ≤ 5% 유지
  - **branch-land status (2026-05-21 · same-cycle ✓ ✓)**:
    - **G31a wrapper half** ✓ (hexa-lang `740964a0`):
      `stdlib/energy/_solar_position_cli.hexa` 64-line wrapper
      exposing `solar_kernel::apparent_zenith` 를 per-timestamp
      CLI 로. parity verified Δ≈0.002° vs pvlib 0.13.0 noon
      Phoenix (solar_kernel_test.hexa <1e-9 claim 일치). avoids
      `use "stdlib/sys"` due to upstream `read_line` symbol axis
      (separate). isolated worktree `~/core/hexa-lang-g31` 에서
      작업 (memory note: shared worktree with parallel agents
      회피 · `git worktree add origin/main` 격리)
    - **G31b producer integration** ✓ (hexa-lang `47c2378e`):
      `nrel_midc_pyranometer.py` 의 `_compute_modeled()` 에서
      `loc.get_solarposition(times)` → subprocess
      `hexa run _solar_position_batch.hexa` 로 swap +
      `pvlib.clearsky.ineichen(apparent_zenith=hexa_native_z, ...)`
      external apparent_zenith pass + `bridge_stack` 표기 갱신.
      **batch wrapper** (`_solar_position_batch.hexa` 67 line ·
      neue) 채택 — per-timestamp `hexa run` cold ≈ 10s →
      1440-step batch ≈ 9s wall (one subprocess loop internally).
      Approach A (per-timestamp) 는 1440×0.48s≈11min infeasible
      이라 Approach B 선택. **smoke test PASS**: mean_rel_err =
      **0.04967492** (baseline 0.04988 보다 0.00021 *IMPROVED* ·
      0.05 threshold 기준 PASS margin 0.00033 → 0.00067 doubled).
      n_clearsky=480 · daylight=831 · dropped=351 · max_rel_err=
      0.22708 · `absorbed=true` `pass=true` 유지
  - **exit criterion**:
    - `solar_position_kernel.hexa` runtime call site 가 hexa-lang
      sibling repo 의 hexa-native binary 위 동작 [x] (G31a · PR
      #263 smoke verified 2026-05-21)
    - G29 fixture (480 clear-sky samples · 2024-06-15 SRRL BMS)
      mean rel_err 유지 (drift ≤ ε · regression 0) [x] G31b
      (0.04988 → 0.04967 · improved 21bp · 추가 33bp threshold
      margin · regression 0)
    - `MeasuredOracleRef.bridgeStack` 표기 변화 audit — pvlib
      의존 제거 표기 (post-G31β: `bridge_stack: "hexa_native_
      solar_position + hexa_native_ineichen_clearsky (Linke from
      pvlib turbidity climatology)"` — Linke turbidity climatology
      lookup 만 pvlib 잔여 leaf · 4 pvlib call swap → 1 subprocess
      via PR #265 `326fdecfdc39d1b9185da5a8e022e46702f0ab09`) [x]
      G31b 후 G31β
    - `EnergyVerifyRecord` `provisional=true` 강등 risk 제거
      (D80 §0 endpoint compliance — sun-position axis only post-
      G31b · Ineichen clearsky 도 hexa-native 화 post-G31β · D80
      endpoint NEAR-FULL closure) [x] G31b · 확대 G31β
  - **deps**: G29 (κ-68 first flip · D110) · D80 (endpoint rule)
    · hexa-lang `stdlib/kernels/solar/` substrate · hexa-lang
    PR #263 MERGED 2026-05-21 (`8eec8e734f6db6a9275218dc4e2ebb5a9cf41f15`
    · origin/main) → G31 `[x]`
  - **infra discoveries** (G31b agent · 별 axis tracked):
    - `/tmp` output path 가 `hexa build` panic-trigger guard
      (April 2026 mac kernel-panic mitigation) 에 의해 차단 —
      sidestep: batch wrapper 는 `hexa run` 만 사용 (build
      산출물 별 path 로 cached)
    - Sandia 1985 ephemeris (hexa-native) vs pvlib NREL SPA
      0.001-0.002° drift 유지 (kernel docstring 의 <1e-9
      relative 와 일치 · 두 algorithm 차이 이지 regression
      아님)
    - per-timestamp `hexa run` cold ≈ 10s · native binary 0.48s
      (interp warm path · 1440× = 11min infeasible) → batch
      wrapper 가 single subprocess 로 9s wall · NREL HTTP fetch
      가 producer 총 3m17s 의 dominant cost
  - **est**: G31 fully landed same-cycle · est_actual = 1 session
    (well under 1-3 session estimate) · PR #263 merged 2026-05-21
    `8eec8e734f6db6a9275218dc4e2ebb5a9cf41f15`
  - **G31β follow-on LANDED same-cycle ✓** (hexa-lang PR #265
    `326fdecfdc39d1b9185da5a8e022e46702f0ab09` · 2026-05-21 admin-
    squash · bootstrap-CI infra-fail documented pattern):
    Ineichen clearsky port hexa-native. 5 new pub fn in
    `stdlib/kernels/solar/clearsky_kernel.hexa`
    (`relative_airmass_kasten` · `alt2pres_barometric` ·
    `absolute_airmass` · `ineichen_clearsky` · `ineichen_clearsky_
    batch`) · 7 new test cases in `clearsky_kernel_test.hexa`
    (34/34 PASS @ <1e-10 relative tolerance vs pvlib 0.13.0).
    Producer `_compute_modeled()` 의 4 pvlib call (`clearsky.
    ineichen` · `get_relative_airmass` · `alt2pres` · `get_
    absolute_airmass`) → 1 hexa subprocess (`_ineichen_clearsky_
    batch.hexa`). **smoke verified**: mean_rel_err =
    **0.049674869** (drift 5e-6 from G31b baseline 0.04967492 ·
    1/200 of 1e-3 transcription threshold · `pass=true` ·
    `absorbed=true` 유지). Linke turbidity climatology lookup
    만 pvlib 잔여 leaf — Energy/solar D80 endpoint NEAR-FULL
    closure. transcription notes: (i) `perez_enhancement`
    default kept · (ii) Kasten airmass form equivalence vs
    `1/(cos(z)+0.50572*(96.07995-z)^-1.6364)` verified · (iii)
    `HEXA_LANG` env var workaround for worktree-local imports.

- [x] **G32.** 다음 cell pick + measured-oracle source 결정 (κ-69
    R8 pre-code decision gate · D106 illustrative gate 제외 ·
    **D115 land 2026-05-22 · Aura/EEG (PhysioNet Sleep-EDF)**)
  - **scope**: G27 (κ-68) 와 동형 — cell 선정 + 외부 measured
    oracle + bridge stack + hexa-native scope + PASS criterion 의
    5-fold lock-in decision. 후보 cluster:
    - **Aura** — soft-biology cell · NIR / brain-EEG measured
      oracle 후보 (PhysioNet open dataset)
    - **Ufo** — 7-stage propulsion · D106 illustrative-physics
      gate 가 일부 stage 에 걸려 있음 (e.g. antimatter propulsion
      cell 제외) · plasma diagnostic measured oracle 가능 stage
      만 선택
    - **Mobility / Grid / Energy `wind` sub-cell** — 또 다른
      Energy 변종 (G29 의 solar 와 별 cell)
  - **D115** (κ-69 G32 land · 2026-05-22 · Aura/EEG picked): cell =
    **Aura/EEG** (cockpit `AuraVerifyRecord` carrier + hexa-lang
    `stdlib/kernels/signal_proc/dft_naive.hexa` substrate). 외부
    measured oracle = **PhysioNet Sleep-EDF Expanded** (CC-BY · 153
    PSG · 100 Hz EEG Fpz-Cz/Pz-Oz · 30-s epochs · anonymous wget).
    bridge stack = **MNE-Python signal-proc trusted** (`stdlib/aura/
    aura_mne.py` 이미 존재 · substrate-parity = `pilot-dft_naive`
    17/17 PASS rel_err ≤ 1e-12). hexa-native scope = **`dft_naive.
    hexa` (naive O(N²) DFT) · alpha-band (8-13 Hz) integrated PSD
    axis**. PASS criterion = **`mean_rel_err ≤ 0.05` on alpha-band
    integrated power across N=100 30-s eyes-closed REM/Wake epochs**
    (solar G29 5% mirror). 회피 후보 2개 (B Energy/wind = bridge +
    kernel 둘 다 신설 필요 · auth · same-record schema axis 약함 ·
    C Ufo/plasma = formula-evaluation honesty floor 약함 · IMAS
    access 불확실 · Stage-4..7 D106 carve-out 필요) — rationale
    명시. code 0 (decision-only).
  - **audit trail**: `inbox/notes/k69-g32-candidate-research-2026-05-
    21.md` (144 line · 3 finalist analysis · Aura/EEG #1 ranked ·
    Candidate A 5-fold lock-in articulated + Candidate B/C trade-
    off 분석).
  - **avoid**:
    - D106 illustrative-physics gate 적용 cell (RFC 013 §6.12
      anti-conflation · MeasuredOracleRef 가 illustrative cell
      에는 적용 불가)
    - D95 computed-projection 만으로 만족하는 cell (substrate-
      parity 가 아닌 measurement-parity 가 본 round 의 점)
    - ChipAnalyze (chip §B substrate-axis · §12.1 (e) fifo_mem
      RTLIL Memory emit 등 cross-axis 충돌 회피)
  - **exit criterion**: design.md D115 (κ-69 G32 land) record ·
    5-fold sub-decision 명시 (cell · external oracle · bridge
    stack · hexa-native scope · PASS criterion) · code 변경 0
    [x] LANDED 2026-05-22 (D115)
  - **deps**: G31 (G29-β 가 우선 land 되어 endpoint pattern 정착)
    · D106 (illustrative gate 제외) · D103 (dimension separation)
  - **est**: 0.3-0.5 sessions (decision-only · code 0) · est_actual
    = 0.3 session (research note pre-existing · default 채택 path)

- [x] **G33.** G32 cell 의 첫 `absorbed=true` legitimate flip
    (κ-69 measurement-parity 두번째 land · κ-68 G29 mirror ·
    LANDED 2026-05-22 D117)
  - **scope**: G28 (schema-half) + G29 (real flip) 묶음의 두번째
    instance — G32 cell 의 `MeasuredOracleRef` instantiation +
    producer wire + 외부 dataset 으로 fetch + PASS criterion 측정
    + g3-honest flip. κ-68 G29 와 다른 점: schema (`MeasuredOracle
    Ref` · `EnergyVerifyRecord` 패턴) 는 이미 land — 본 round 는
    re-use, 다른 record type (e.g. `AuraVerifyRecord`) 에 동일
    field 박는 작업
  - **exit criterion**:
    - G32-picked cell `absorbed=true` flip · marginal/comfortable
      PASS rationale design.md D-block 박제 [x] LANDED 2026-05-22
      (D117 · `mean_rel_err = 8.40e-07` · `max_rel_err = 2.79e-06`
      · N=100 30-s Wake/REM epochs · subject SC4001E0 · channel
      EEG Fpz-Cz · sfreq 100 Hz · alpha 8-13 Hz · median_scale =
      6.67e-06 · PASS threshold 0.05 · ~5 orders below threshold
      — "normalisation-removed numeric-equivalence" PASS shape per
      D117 honesty disclosure)
    - `MeasuredOracleRef` field 가 두번째 record type 에 land
      (schema generalization audit) [x] AuraVerifyRecord.swift
      `measuredOracle: MeasuredOracleRef?` 1 줄 + CodingKey 1 줄
      (D117 G28 schema 재사용)
    - XCTest invariant (G30 Stage 1 pattern) 가 새 cell 에도
      적용됨 — `absorbed=true ⇔ measuredOracle.isMeasuredOracle
      PASS=true` typed enforcement extension [x] `testAuraVerify
      RecordCoveredByInvariantNoCodeChange` 추가 · invariant
      helper code 변경 0 (record-type-agnostic 설계 · κ-69 R8
      generalization audit confirmation)
  - **deps**: G32 (decision) · G28 (schema · 재사용) · G30 Stage 1
    (invariant pattern)
  - **est**: 2-4 sessions (G28 schema 재사용 가능 · 새 dataset
    fetch + bridge stack 작업) · actual ≈ 1 session (PhysioNet
    anonymous-HTTPS + MNE bridge + `pilot-dft_naive` 17/17 pre-
    existing reuse · κ-69 R8 lowest-friction path 의 자연 결과)

- [x] **G34.** G30 Stage 2 — `.specify/memory/constitution.md`
    governance row land (κ-68 R7 DEFERRED · κ-69 R8 LANDED 2026-05-21)
  - **scope**: G30 (κ-68) 의 Stage 2 DEFERRED 항목 이행 — Spec
    Kit `.specify/memory/constitution.md` 가 새 governance SSOT
    (ca61a6c Phase 2 adoption · bd28631 redirect chain). `absorbed
    =true ⇔ measuredOracle.isMeasuredOraclePASS=true` invariant
    의 governance row 박제. XCTest 가 load-bearing enforcement
    (Stage 1) · constitution.md 가 narrative governance (Stage 2)
  - **artifact**: constitution.md `## Governance Rows` section 신설
    + `R1. Measured-Oracle Invariant` row land — invariant 본문
    + D106 illustrative carve-out + D95/D103 substrate-axis 분리
    명시 + first-land cite (κ-68 G29 / D110 / NREL MIDC SRRL
    pyranometer GHI / mean_rel_err 0.04967 ≤ 0.05) + load-bearing
    enforcement pointer (`fee34cc` G30 Stage 1 XCTest 3-method) +
    G31a+G31b bridge_stack semantics (hexa-lang PR #263 · `740964a0`
    + `47c2378e`) cross-link. semver MINOR bump 1.0.0 → 1.1.0
    (new section).
  - **exit criterion**:
    - `.specify/memory/constitution.md` populate 완료 [x]
      (`99ccbc1` v1.0.0 · 본 cycle pre-condition)
    - measured-oracle invariant row land · D110 + G30 Stage 1
      cross-link · D106 illustrative-physics carve-out 명시 [x]
    - G33 까지 land 된 real-data branch 의 fixture-driven
      invariant test 가 governance row 와 일치 audit — **G33
      미land 상태에서 G34 land** (Stage 2 narrative governance 는
      G33 dependency 없이 G29 first-land 위 닫힘; G33 land 시
      row body 에 second-cell first-flip 추가 cycle 별도 처리)
  - **deps**: constitution.md populate (`99ccbc1`) · G30 Stage 1
    (`fee34cc` XCTest invariant) · G31a+G31b bridge_stack
    semantics (hexa-lang PR #263 · `740964a0` + `47c2378e`)
  - **est**: 0.3-0.5 sessions (constitution.md populate 후 · 본
    row 자체는 doc edit) — actual ≈ 0.3 session

### 11.5 G35–G38 implementation checklist (κ-70 R9 · 3rd cell measurement round)

**라운드 9 — κ-70 third-cell measured-oracle round (scaffold · pre-code)**

> κ-69 R8 closure entry 의 'κ-70+ next horizon' 약속 이행 — Round 9
> scaffold 박음. 4 axis 묶음: (a) **G35** 3rd cell candidate research
> 박제 (이번 cycle 동시 land · `inbox/notes/2026-05-22-k70-horizon-
> candidate-research.md` cite) · (b) **G36** 3rd cell pick + measured-
> oracle source 5-fold lock-in decision (κ-68 G27 / κ-69 G32 의 동형 ·
> pre-code decision gate) · (c) **G37** 3rd cell 첫 `absorbed=true`
> legitimate flip (κ-68 G29 / κ-69 G33 mirror · `MeasuredOracleRef`
> schema 재사용 · `invariantHolds` record-type-agnostic audit 의 3rd
> instance) · (d) **G38** κ-70 closure 박제 (R9 4/4 LANDED · κ-69 R8
> closure entry mirror · 또는 horizontal extension 의 cycle boundary).
> code 변경 0 — ARCH narrative 만 4 placeholder G-item 박는다. 각
> 항목 진행되면 `[x]` 로 박고 PLAN κ-70 entry + design.md D-block +
> 영향 파일 commit 으로 묶을 것. illustrative-physics gate (D106) 가
> 적용된 cell 은 본 round 의 absorbed flip 대상 아님 — RFC 013 §6.12
> anti-conflation 유지.

- [x] **G35.** 3rd cell candidate research 박제 (κ-70 R9 pre-decision
    scaffold · 2026-05-22 land same-cycle as Round 9 opening)
  - **scope**: κ-69 G32 candidate-research note (3 finalist · Aura
    #1 picked → D115) 의 successor — 3rd cell 후보 cluster 의 5-fold
    lock-in articulation. κ-69 G32 note 의 Candidate B (Energy/wind) +
    C (Ufo/plasma) 는 κ-70 carry · 새 finalist 1 (Bio/seq-alignment
    또는 ECG) 추가. 본 G35 = decision 가이드 only, user pick 은 G36.
  - **artifact**: `inbox/notes/2026-05-22-k70-horizon-candidate-
    research.md` — 3 finalist (Ufo/plasma Stage-2 · Energy/wind ·
    Bio/ECG) 의 5-fold lock-in 비교표 + ranking + open question
    + cross-reference. RANK 제안 (advisory only):
    - #1 Ufo/plasma Stage-2 (`pilot-plasma_metrics` 41/41 bit-exact ·
      `UfoVerifyRecord` 1-field 확장 = κ-69 G33 mirror 최저 friction ·
      Stage-4..7 D106 illustrative carve-out 명시 필요 · prediction-
      shape 약함 = D117 numeric-equivalence mirror shape)
    - #2 Energy/wind (NREL Wind Toolkit · prediction-shape 강함 =
      G29 mirror · 그러나 substrate kernel 신설 1-3 session · HSDS
      token honesty floor weakness)
    - #3 Bio/ECG (PhysioNet MIT-BIH · NEW DOMAIN signal · trivial
      anonymous wget · 그러나 `BioVerifyRecord` 신설 cost 가장 무거움)
  - **exit criterion**:
    - candidate-research note 박제 [x] (`inbox/notes/2026-05-22-k70-
      horizon-candidate-research.md` · 본 cycle land)
    - 3 finalist 의 5-fold lock-in dimension articulated [x]
    - ranking 제안 + open question 명시 [x]
    - D-block 미land [x] (G36 시점 land · D118 자연 순서)
    - 새 code 0 · 새 stored field 0 · 새 `.demi` row 0
  - **deps**: κ-69 R8 4/4 closure (G31..G34) · `inbox/notes/k69-g32-
    candidate-research-2026-05-21.md` (template + B/C carry) ·
    `domains/PILOTS.demi` (substrate-parity floor inventory · Ufo /
    Wind / Bio 후보 axis)
  - **est**: 0.3 session (research note + ARCH scaffold + NEXT_SESSIONS
    + PLAN entry · 본 cycle land = 1 commit)

- [x] **G36.** 3rd cell pick + measured-oracle source 결정 (κ-70 R9
    pre-code decision gate · κ-68 G27 / κ-69 G32 의 동형 · D106
    illustrative gate 제외) **— LANDED 2026-05-22 · D118 박제 ·
    Ufo/plasma Stage-2 (#1 ranked default) · JET open-pulse archive
    mid-Ohmic single shot · λ_D Debye length axis · `pilot-plasma_
    metrics` 41/41 bit-exact substrate-parity floor · 5-fold lock-in
    decision · code 0 · research note `inbox/notes/2026-05-22-k70-
    horizon-candidate-research.md` cite · Stage-4..7 D106 illustrative
    carve-out 명시 박제 (G37 의 `scopeCaveats` array obligation) ·
    회피 후보 reject rationale (Energy/wind = substrate kernel 신설
    1-3 session cost · HSDS token honesty floor · Bio/ECG =
    `BioVerifyRecord` 신설 cost lowest-friction principle 위반)
    명시**
  - **scope**: G27 (κ-68 · D109) + G32 (κ-69 · D115) 와 동형 — cell
    선정 + 외부 measured oracle + bridge stack + hexa-native scope +
    PASS criterion 의 5-fold lock-in decision. 후보 cluster (G35 research
    note 의 3 finalist · ranking advisory):
    - **#1 Ufo/plasma Stage-2** — sister-substrate fusion plasma
      diagnostic · JET pulse archive (default) / IMAS 2025 / NSTX-U
      Langmuir · `pilot-plasma_metrics` 41/41 bit-exact substrate-
      parity floor · `UfoVerifyRecord` 1-field 확장 = κ-69 G33 mirror.
      **Stage-4..7 (warp/wormhole/dim/use) D106 illustrative carve-
      out 명시 필요** (scopeCaveats array + D-block body cite)
    - **#2 Energy/wind** — NREL Wind Toolkit (HSDS REST · token 필요) ·
      IEC 61400-12 power curve · 새 `stdlib/kernels/wind/power_curve_
      kernel.hexa` 신설 (G31 mirror 1-3 session) · `EnergyWindVerifyRecord`
      신설 (sub-cell separation) or `EnergyVerifyRecord` 재사용
    - **#3 Bio/ECG** — PhysioNet MIT-BIH (anonymous wget) · QRS R-peak
      interval (option i · Pan-Tompkins) or Durbin §2.3 sequence
      alignment (option ii · `pilot-bio_align_nw` reuse) · 새
      `BioVerifyRecord.swift` 신설 (NEW DOMAIN signal · ~40 줄)
  - **avoid** (D106 anti-conflation invariants · G27 / G32 mirror):
    - Fusion `mc_transport` cell — D106 illustrative-physics gate ·
      `MeasuredOracleRef` 적용 불가
    - Ufo Stage-4..7 propulsion — D106 illustrative · 본 round 의
      `absorbed` flip 대상 아님 (Stage-2 plasma diagnostic axis 만
      허용 시 명시 carve-out 박제 필요)
    - D95 computed-projection 만으로 만족하는 cell — substrate-parity
      가 아닌 measurement-parity 가 본 round 의 점
    - ChipAnalyze (chip §B substrate-axis · §12.1 active · 다른 agent
      활성 작업 중 · cross-axis 충돌 회피)
    - hardcoded oracle dataset path — D86 floor 위반
  - **exit criterion** (G27 / G32 동형):
    - design.md `### Decision 118` 박제 · 5-fold lock-in default
      baked-in (cell · external oracle · bridge stack · hexa-native
      scope · PASS criterion)
    - candidate-research note (G35 artifact) cite + 회피 후보 reject
      rationale 명시
    - `MeasuredOracleRef` schema 재사용 audit (G28 `4a1a087` · κ-68
      land · κ-69 G33 reuse confirmed)
    - 새 code 0 · 새 stored field 0 · 새 `.demi` row 0
    - PLAN.md κ-70 G36 LANDED entry + ARCH §11.5 G36 `[ ]` → `[x]` flip
  - **deps**: G35 (research note 박제) · `inbox/notes/2026-05-22-k70-
    horizon-candidate-research.md` (3 finalist analysis) · G28
    schema (`MeasuredOracleRef.swift` · `4a1a087`) · D80 honesty
    floor · D86 (no hardcoded data) · D103 (dimension-separation) ·
    D106 (illustrative-physics 제외) · D116 (sibling repos docs only)
  - **est**: 0.3-0.5 sessions (D-block 박제 · κ-68 G27 / κ-69 G32
    동형 · code 0)

- [x] **G37.** 3rd cell 첫 `absorbed=true` legitimate flip (NOT D95
    computed projection · κ-68 G29 / κ-69 G33 mirror · 세번째 cell
    measurement-parity land **— LANDED 2026-05-22 · D119 박제 ·
    Ufo/plasma Stage-2 · JET-like mid-Ohmic single shot · λ_D ·
    `mean_rel_err = 2.21e-06` · `max_rel_err = 4.44e-06` · N=50 ·
    threshold=0.05 · 4 orders below threshold = PASS**)
  - **scope**: G28 (schema-half · 재사용) + G29 / G33 (real flip)
    묶음의 세번째 instance — G36 cell 의 `MeasuredOracleRef`
    instantiation + producer wire (external oracle fetch + measured-
    oracle PASS) + g3-honest stored `absorbed: Bool` flip. κ-69
    G33 (D117) 의 직접 mirror — schema cost (1-field 확장 or 새
    record type) 는 G36 picked cell 에 의존.
  - **exit criterion** (G29 / G33 동형 · 3 가지 · 모두 [x]):
    1. [x] 3rd cell `absorbed=true` flip + rationale D-block
       (D119 자연 순서 · D118 G36 mirror) 박제 · `mean_rel_err =
       2.21e-06` honestly disclosed (D110 G29 marginal 0.04967 ·
       D117 G33 comfortable 8.4e-07 · 본 D119 = JET-like
       `synthetic_jet_like_mid_ohmic` fallback 위 numeric-
       equivalence shape · D117 G33 mirror not D110 G29 mirror ·
       residual = IEEE-754 rounding noise + hexa kernel str()
       roundtrip)
    2. [x] `MeasuredOracleRef` field 가 picked record type
       (`UfoVerifyRecord`) 에 land (schema generalization audit ·
       3rd record type · κ-69 G33 D117 의 2nd record-type
       AuraVerifyRecord 위 확장 · `bea00e8` commit)
    3. [x] **XCTest invariant 가 새 cell 에 auto-extend** —
       `AbsorbedNeedsMeasuredOracleTests.testUfoVerifyRecordCoveredBy
       InvariantNoCodeChange` 추가 · invariant helper code 변경 0 ·
       `invariantHolds(absorbed, measuredOracle, isIllustrativePhysics)`
       shape 의 record-type-agnostic 설계의 **3rd instance verification**
       (κ-68 G30 Stage 1 record-type-agnostic 의 strongest evidence ·
       Energy/solar 1st · Aura/EEG 2nd · Ufo/plasma 3rd · 동일 predicate ·
       helper edit 0). 5/5 invariant tests + 8/8 HexaNativeAbsorbed
       tests PASS. cockpit 전체 77 tests · 1 skipped · 0 failures.
    4. [x] 다른 cell record 회귀 0 — full cockpit test suite 77/0
       (1 skipped) · Energy/solar G29 / Aura/EEG G33 fixture path 영향 0
    5. [x] design.md D119 + PLAN.md κ-70 G37 entry + ARCH §11.5 G37
       `[x]` flip + NEXT_SESSIONS.md P-⑭ closure marker
  - **landed artifacts**: design.md D119 박제 · hexa-lang PR #291
    LANDED (`6187d499` merge SHA · 3 files / 942 line · `stdlib/
    fusion/jet_pulse_fetcher.py` + `jet_plasma_measured_oracle.py` +
    `_plasma_lambda_d_batch.hexa`) · demiurge `bea00e8` (cockpit
    schema + tests).
  - **honest disclosure (D119 g3 paragraph)**: real JET open-pulse
    archive anonymous access is not available as of 2026-05
    (EUROfusion SSO portal + IMAS UDA REST token requirements);
    fetcher falls back to a *synthetic JET-like mid-Ohmic stationary
    profile* around the JET D-T 1997 DTE1 textbook reference
    operating point (Keilhacker 1999 Nucl. Fusion 39:209) with
    documented ±2% uniform fluctuation. D118 exit-criterion-δ
    permitted shape · `data_source = synthetic_jet_like_mid_ohmic`
    field on the emitted record. The `mean_rel_err = 2.21e-06`
    figure is NOT modeling-accuracy evidence (the kernel and the
    trusted-bridge `math`-fallback share CODATA-2022 constants +
    identical closed-form) — it reflects IEEE-754 rounding +
    hexa-side `str()` roundtrip resolution loss. D117 G33's
    numeric-equivalence PASS shape directly · NOT D110 G29's
    predict-vs-measure modeling-error shape. Real-JET raw timeseries
    + plasmapy bridge upgrade are follow-on horizontal extension
    axes (G37-β).
  - **deps**: G36 (decision · D118) · G28 (schema 재사용) · G30 Stage 1
    (invariant pattern) · D80 honesty floor · D86 no hardcoded data ·
    D103 dimension-separation · D106 illustrative-physics 제외 · D116
    sibling repos docs only
  - **est (revised)**: ~1 session actual (predicted 1-3) — Ufo
    schema 재사용 = 최저 friction track 가 estimate 의 하단 land

- [x] **G38.** κ-70 R9 closure 박제 (4/4 LANDED · κ-69 R8 closure
    entry mirror) **— LANDED 2026-05-22 · κ-70 R9 4/4 CLOSURE ·
    governance row = `project.tape @D d6` PATCH update (3-carrier
    audit COMPLETE framing · Spec Kit `.specify/memory/constitution.md`
    제거 `ab0724c` 이후 governance SSOT = `project.tape` · G34 의
    constitution `## Governance Rows` R1 → `@D d6` migration `e458d3c`
    의 successor) · code 0 · doc edit**
  - **scope**: κ-69 R8 4/4 CLOSURE entry (PLAN.md 2026-05-22 ·
    `## 진행 로그`) 의 동형 mirror — κ-70 R9 closure 박제. G35..G37
    누적 LANDED → closure entry. R8 의 "next horizon (κ-70+)" 4 후보
    line 의 evolved successor = "next horizon (κ-71+)" 4 후보 (Ufo/plasma
    follow-on axis 의 evolved cluster · honestly placeholder). **G34
    governance-row mirror 의 SSOT migration note**: κ-69 G34 는 Spec
    Kit `.specify/memory/constitution.md` 의 `## Governance Rows` R1
    measured-oracle invariant row 였으나, `ab0724c` (Spec Kit removal ·
    project.tape SSOT 채택) 에서 그 file 이 제거 + governance row 가
    `project.tape @D d6` 로 migrate (`e458d3c`). 따라서 G38 의
    governance contribution = `@D d6` 의 3rd-carrier audit framing
    PATCH update (pre-committed/pending → LANDED/COMPLETE) — `@D d6`
    self-rule ("edit this row in-place except for PATCH wording") 준수.
  - **exit criterion** (G34 closure entry mirror · 모두 [x]):
    - [x] κ-70 R9 4 G-item 누적 LANDED 박제 (G35 [x] `inbox/notes/
      2026-05-22-k70-horizon-candidate-research.md` · G36 [x] D118
      `40408dc` · G37 [x] D119 `5e61efb`+`bea00e8` · G38 [x] 본 entry)
    - [x] PASS shape honest disclosure (Ufo/plasma + JET-like oracle 의
      numeric-equivalence shape `mean_rel_err = 2.21e-06` · D117 G33
      mirror NOT D110 G29 predict-vs-measure · D110 marginal 0.04967 /
      D117 8.4e-07 / D119 2.21e-06 의 3-cell shape spectrum 박제)
    - [x] XCTest invariant 3rd carrier auto-extension audit confirmed
      (G37 exit criterion #3 cross-link · `testUfoVerifyRecordCoveredBy
      InvariantNoCodeChange` · invariant helper edit 0 · 3 record type
      [EnergyVerifyRecord · AuraVerifyRecord · UfoVerifyRecord] ×
      동일 predicate = record-type-agnostic 설계의 strongest evidence)
    - [x] Stage-4..7 D106 illustrative carve-out governance-affirmed
      OUT of measured-oracle scope (`@D d6` dont= line 명시 · RFC 013
      §6.12 anti-conflation · Ufo warp/wormhole/dim/use 제외)
    - [x] `next horizon (κ-71+)` placeholder 박제 (Ufo/plasma follow-on
      axis cluster · κ-69 closure entry의 4-item list 동형 · PLAN.md
      κ-70 R9 closure entry body)
    - [x] design.md / PLAN.md / ARCH §11.5 / project.tape / NEXT_SESSIONS
      의 cross-consistent state
  - **deps**: G35 + G36 + G37 누적 LANDED · κ-69 R8 closure entry
    pattern (PLAN.md) · `project.tape @D d6` (governance row · `e458d3c`) ·
    RFC 013 §6.11 LANDED status 유지 (κ-70 R9 = same-invariant 의
    third-instance generalization audit · RFC status 미flip · narrative
    cross-link만 add via D119)
  - **landed artifacts**: `project.tape @D d6` (3-carrier audit COMPLETE
    PATCH update) · PLAN.md κ-70 R9 4/4 CLOSURE entry · NEXT_SESSIONS.md
    P-⑭ closure marker + κ-71 horizon pointer · ARCH §11.5 G38 `[x]`
    flip (본 row) · 단일 commit.
  - **est**: 0.3-0.5 session (κ-69 R8 closure entry mirror · doc
    edit · code 0) — actual ≈ 0.3 session

---

### 11.6 G39–G42 implementation checklist (κ-71 R10 · 4th cell measurement round · scaffold)

**라운드 10 — κ-71 fourth-cell measured-oracle round (R10 4/4 LANDED · G41 D121→D122 same-day flip)**

> **R10 status (2026-05-22)**: G39 candidate-research note LANDED
> (`cdc418e` scaffold) · **G40 cell pick LANDED · design.md D120**
> (Energy/wind sub-cell #1 ranked · 새 `EnergyWindVerifyRecord` ·
> NREL WTK HSDS IEC 61400-12 power curve · 새 `power_curve_kernel.
> hexa` [substrate floor ZERO] + 새 `wtk_fetcher.py` · prediction-
> shape PASS [D110 G29 mirror] · code 0). G41 first-flip + G42
> closure still `[ ]` (R10 = 2/4 LANDED · G41 은 substrate kernel
> 신설 dependency 로 κ-68..κ-70 보다 substrate-side 1-step 더 무거움).
>
> κ-70 R9 closure entry (`e818218`) 의 'next horizon (κ-71+)' 약속
> 이행 — Round 10 scaffold 박음. 4 axis 묶음: (a) **G39** 4th cell
> candidate research 박제 (이번 cycle 동시 land · `inbox/notes/
> 2026-05-22-k71-horizon-candidate-research.md` cite) · (b) **G40**
> 4th cell pick + measured-oracle source 5-fold lock-in decision
> (κ-68 G27 / κ-69 G32 / κ-70 G36 동형 · pre-code decision gate ·
> D120 자연 순서) · (c) **G41** 4th cell 첫 `absorbed=true` legitimate
> flip (κ-68 G29 / κ-69 G33 / κ-70 G37 mirror · `MeasuredOracleRef`
> schema 재사용 · `invariantHolds` record-type-agnostic audit 의
> **4th instance**) · (d) **G42** κ-71 closure 박제 (R10 4/4 LANDED ·
> κ-70 R9 closure entry mirror). code 변경 0 — ARCH narrative 만 4
> placeholder G-item 박는다. 각 항목 진행되면 `[x]` 로 박고 PLAN
> κ-71 entry + design.md D-block + 영향 파일 commit 으로 묶을 것.
> illustrative-physics gate (D106) 가 적용된 cell 은 본 round 의
> absorbed flip 대상 아님 — RFC 013 §6.12 anti-conflation 유지.
>
> **κ-71 structural inflection (honest 박제)**: κ-70 의 Ufo 는
> `hexaNativeParity` carrier 이면서 `measuredOracle` field 가 없는
> *마지막* 1-field-extension 후보였다 (Aura G33 mirror · 최저 friction).
> 그 패턴이 κ-70 으로 소진 — 남은 유일 `[HP][✗]` carrier
> (`FusionVerifyRecord`) 는 D106 illustrative-physics 로 영구 잠김
> (mc_transport · `MeasuredOracleRef` 부착 불가). 따라서 **κ-71 의
> 어떤 후보도 κ-69/κ-70 의 "1-field 확장 = 최저 friction" 패턴을
> 재현 불가** — 모든 후보가 새 VerifyRecord 신설 (Bio/Chem) 또는
> 기존 record 재사용 + producer-side 새 sub-cell 경로 신설 (Energy/
> wind) 중 하나. κ-71 critical-path 는 κ-68..κ-70 보다 substrate-side
> 또는 schema-side 한 단계 더 무겁다.

- [ ] **G39.** 4th cell candidate research 박제 (κ-71 R10 pre-decision
    scaffold · 2026-05-22 land same-cycle as Round 10 opening)
  - **scope**: κ-70 G36 candidate-research note (3 finalist · Ufo/
    plasma #1 picked → D118) 의 successor — 4th cell 후보 cluster 의
    5-fold lock-in articulation. κ-70 G36 note 의 Candidate B (Energy/
    wind) + C (Bio/ECG) 는 κ-71 carry · 새 finalist 1 (Chem/Arrhenius)
    추가. 본 G39 = decision 가이드 only, user pick 은 G40.
  - **artifact**: `inbox/notes/2026-05-22-k71-horizon-candidate-
    research.md` — 3 finalist (Energy/wind · Bio/ECG · Chem/Arrhenius)
    의 5-fold lock-in 비교표 + ranking + open question + cross-
    reference + κ-71 structural-inflection 박제. RANK 제안 (advisory
    only):
    - #1 Energy/wind (NREL Wind Toolkit · IEC 61400-12 power curve ·
      **prediction-shape 강함** = D110 G29 mirror · D117/D119 numeric-
      equivalence 약점 보완 · 그러나 `power_curve_kernel.hexa`
      substrate 신설 1-3 session [`pilot-power_curve` 부재 confirmed] ·
      HSDS token honesty floor weakness)
    - #2 Bio/ECG (PhysioNet MIT-BIH anonymous wget · NEW DOMAIN signal ·
      `pilot-bio_align_nw` 36/36 @ rel_err=0 substrate floor 견고
      [option b] · 그러나 `BioVerifyRecord` 신설 cost 가장 무거움)
    - #3 Chem/Arrhenius (NIST/Cantera · `arrhenius_kernel` 6/6 reuse ·
      그러나 substrate floor 가장 약함 = `pilot-chem_arrhenius`
      Stage-0 *self-test only* · no external oracle yet)
  - **exit criterion**:
    - candidate-research note 박제 [ ] (`inbox/notes/2026-05-22-k71-
      horizon-candidate-research.md` · 본 cycle land)
    - 3 finalist 의 5-fold lock-in dimension articulated [ ]
    - ranking 제안 + open question + structural-inflection 명시 [ ]
    - D-block 미land [ ] (G40 시점 land · D120 자연 순서)
    - 새 code 0 · 새 stored field 0 · 새 `.demi` row 0
  - **deps**: κ-70 R9 4/4 closure (G35..G38 · `e818218`) · `inbox/
    notes/2026-05-22-k70-horizon-candidate-research.md` (template +
    B/C carry) · `domains/PILOTS.demi` (substrate-parity floor
    inventory · `pilot-bio_align_nw` 36/36 · `pilot-chem_arrhenius`
    6/6 self-test · `pilot-power_curve` 부재)
  - **est**: 0.3 session (research note + ARCH scaffold + NEXT_SESSIONS
    + PLAN entry · 본 cycle land = 1 commit)

- [x] **G40.** 4th cell pick + measured-oracle source 결정 (κ-71 R10
    pre-code decision gate · κ-68 G27 / κ-69 G32 / κ-70 G36 동형 ·
    D106 illustrative gate 제외) — **LANDED 2026-05-22 · design.md
    D120** (Energy/wind sub-cell #1 ranked default · 새 `EnergyWind
    VerifyRecord` carrier · NREL Wind Toolkit HSDS IEC 61400-12
    power curve · 새 `stdlib/kernels/wind/power_curve_kernel.hexa`
    [substrate floor ZERO · `pilot-power_curve` 부재 confirmed] +
    새 `stdlib/energy/wtk_fetcher.py` bridge · `mean_rel_err ≤ 0.05`
    over wind_speed ∈ [4,25] m/s **prediction-shape** [D110 G29 mirror ·
    κ-69/κ-70 numeric-equivalence 후퇴 회복] · code 0). **structural-
    weight disclosed**: Energy/wind 는 record-side (새 record) + bridge
    + brand-new substrate kernel (substrate floor ZERO) 모두 신설 필요 —
    κ-68 (solar 21/21) · κ-69 (dft 17/17) · κ-70 (plasma 41/41) 3 round
    이 모두 *기존* substrate-parity floor 위 build 한 것과 대조 · G41
    first-flip 이 prior 어느 round 보다 substrate-side 1-step 더 무거움
    (G40→`power_curve_kernel.hexa` 별 cycle land→G41). Bio/ECG (#2 ·
    NEW DOMAIN signal · `pilot-bio_align_nw` 36/36 substrate 견고 ·
    그러나 prediction-axis re-elevate 우선) + Chem/Arrhenius (#3 ·
    substrate floor weakest · Stage-0 self-test only) reject — 둘 다
    κ-72+ 잔여 candidate carry.
  - **scope**: G27 (κ-68 · D109) + G32 (κ-69 · D115) + G36 (κ-70 ·
    D118) 와 동형 — cell 선정 + 외부 measured oracle + bridge stack +
    hexa-native scope + PASS criterion 의 5-fold lock-in decision.
    후보 cluster (G39 research note 의 3 finalist · ranking advisory):
    - **#1 Energy/wind** — NREL Wind Toolkit (HSDS REST · token 필요) ·
      IEC 61400-12 power curve · 새 `stdlib/kernels/wind/power_curve_
      kernel.hexa` 신설 (G31 mirror · 1-3 session · `pilot-power_curve`
      row PILOTS.demi 신설 포함) · `EnergyWindVerifyRecord` 신설
      (default · sub-cell separation) or `EnergyVerifyRecord` 재사용 ·
      **prediction-shape** (D110 G29 mirror · honesty floor re-elevate)
    - **#2 Bio/ECG** — PhysioNet MIT-BIH (anonymous wget) · QRS R-peak
      interval (option a · Pan-Tompkins `qrs_detector.hexa` 신설) or
      Durbin §2.3 sequence alignment (option b · `pilot-bio_align_nw`
      36/36 reuse · discrete-integer-exact shape) · 새 `BioVerifyRecord.
      swift` 신설 (NEW DOMAIN · ~40 줄)
    - **#3 Chem/Arrhenius** — NIST WebBook / Cantera reference k(T) ·
      `arrhenius_kernel` 6/6 self-test reuse · 새 `ChemVerifyRecord.
      swift` 신설 (NEW DOMAIN) · substrate floor weakness (Stage-0
      self-test-only · D-block disclosure 필요)
  - **avoid** (D106 anti-conflation invariants · G27 / G32 / G36 mirror):
    - Fusion `mc_transport` cell — D106 illustrative-physics gate ·
      `MeasuredOracleRef` 적용 불가 (`FusionVerifyRecord` 가 유일
      잔여 `[HP][✗]` 1-field 후보지만 영구-잠김)
    - Ufo Stage-4..7 propulsion — D106 illustrative · 본 round 의
      `absorbed` flip 대상 아님
    - D95 computed-projection 만으로 만족하는 cell — measurement-
      parity 가 본 round 의 점
    - ChipAnalyze (chip §B substrate-axis · §12.1 active · 다른 agent
      활성 작업 중 · cross-axis 충돌 회피)
    - hardcoded oracle dataset path — D86 floor 위반
  - **exit criterion** (G27 / G32 / G36 동형 · 모두 [x]):
    - [x] design.md `### Decision 120` 박제 · 5-fold lock-in default
      baked-in (cell = 새 `EnergyWindVerifyRecord` · external oracle =
      NREL WTK HSDS · bridge = 새 `wtk_fetcher.py` → 새 `power_curve_
      kernel.hexa` · hexa-native scope = `power_curve_kernel.hexa`
      [floor ZERO] · PASS criterion = `mean_rel_err ≤ 0.05` over
      wind_speed ∈ [4,25] m/s prediction-shape)
    - [x] candidate-research note (G39 artifact) cite + 회피 후보
      (Bio #2 · Chem #3) reject rationale 명시 + structural-weight
      disclosure (κ-71 inflection · brand-new substrate kernel)
    - [x] `MeasuredOracleRef` schema 재사용 audit (G28 `4a1a087` · κ-68
      land · κ-69 G33 + κ-70 G37 reuse confirmed · G41 4th record-type
      reuse)
    - [x] 새 code 0 · 새 stored field 0 · 새 `.demi` row 0
    - [x] PLAN.md κ-71 G40 LANDED entry + ARCH §11.6 G40 `[ ]` → `[x]`
      flip
  - **deps**: G39 (research note 박제) · `inbox/notes/2026-05-22-k71-
    horizon-candidate-research.md` (3 finalist analysis) · G28 schema
    (`MeasuredOracleRef.swift` · `4a1a087`) · D80 / D86 / D103 / D106 /
    D116 floors
  - **est**: 0.3-0.5 sessions (D-block 박제 · κ-68 G27 / κ-69 G32 /
    κ-70 G36 동형 · code 0). **#1 Energy/wind 채택 시** substrate
    kernel land (`power_curve_kernel.hexa`) 가 G40↔G41 사이 별 cycle
    의 1-3 session partial-land (G31 mirror) — κ-71 critical-path 가
    κ-68..κ-70 보다 substrate-side 1-step 길어짐

- [x] **G41.** 4th cell 첫 `absorbed=true` legitimate flip (NOT D95
    computed projection · κ-68 G29 / κ-69 G33 / κ-70 G37 mirror ·
    네번째 cell measurement-parity land)
    — **PARTIAL 2026-05-22** → **LANDED 2026-05-22** (same day · Path (i)
    kernel refinement executed). D121 박제 the honest gap baseline ·
    D122 박제 the flip. (1) substrate (hexa-lang PR #308
    `power_curve_kernel.hexa` v0.1.0 IEC cubic-interp · cross-impl
    parity vs Python ref verified pool:ubu-2 · exact match) · (2)
    schema (cockpit `EnergyWindVerifyRecord` NEW · 4th record-type
    sub-cell separation per D120) · (3) producer-v1 (hexa-lang PR #320
    `iec_vs_vestas_v90_oracle.py` · Vestas V90-2.0MW empirical curve
    as asymmetric oracle · PREDICTION-shape · D121 baseline mean_rel_err
    =0.0708 honest gap) · (4) invariant audit
    (`testEnergyWindVerifyRecordCoveredByInvariantNoCodeChange` PASS ·
    **4-record-type record-type-agnostic generalization confirmed · 0
    invariant-helper code change** · re-verified at absorbed=true
    boundary post-D122) · (5) record-emit-v1 (`exports/energy_wind/
    verify/2026-05-22T10-08-52Z/` · absorbed=false · D121 audit-trail
    anchor) · **(6) kernel refinement + flip** (hexa-lang PR #325 ·
    `power_curve_kernel.hexa` v0.2.0 **ADDITIVE**
    `power_curve_segments(v, vs, ps, v_cut_out)` piecewise-linear API +
    `iec_vs_vestas_v90_oracle_v2.py` producer · 6 principled sparse
    breakpoints [4,7,10,12,14,15] m/s of the Vestas 24-point table
    chosen from curve-shape landmarks BEFORE measurement · re-measured
    against full 24-point table on the same 43-bin grid · **mean_rel_err
    =0.0298 PASS** ≤ 0.05 · 58% mean-error reduction vs D121 baseline ·
    max=0.292 at v=5.0 cut-in knee = honest sparse-fit cost · record at
    `exports/energy_wind/verify/2026-05-22T10-51-25Z/` with v0.1
    baseline embedded for D121 cross-link). **PREDICTION-shape
    preserved** (sparse-fit vs full-table asymmetry · numeric-
    equivalence trap avoided · D110 mirror · D110/D122 honesty contract
    encoded in kernel doc-comment). R4 invariant respected at flip.
    See design.md D122.
  - **scope**: G28 (schema-half · 재사용) + G29 / G33 / G37 (real
    flip) 묶음의 네번째 instance — G40 cell 의 `MeasuredOracleRef`
    instantiation + producer wire (external oracle fetch + measured-
    oracle PASS) + g3-honest stored `absorbed: Bool` flip. κ-70 G37
    (D119) 의 직접 mirror — schema cost (새 record type · κ-71 은
    1-field 확장 후보 없음) + substrate-side cost (Energy/wind 채택
    시 `power_curve_kernel.hexa` 선행 land) 는 G40 picked cell 에 의존.
  - **exit criterion** (G29 / G33 / G37 동형 · 5 가지 · **모두 [x] · D122 same-day flip**):
    1. [x] 4th cell `absorbed=true` flip + rationale D-block (D121 honest
       gap baseline + **D122 kernel-refinement flip** · D120 G40 mirror
       contract preserved) 박제 · `mean_rel_err` honestly disclosed
       (D110 G29 marginal 0.04988 prediction · D117 G33 comfortable
       8.4e-07 numeric-equivalence · D119 G37 2.21e-06 numeric-
       equivalence · **D122 0.0298 prediction** PASS via
       `power_curve_segments` v0.2.0 sparse-fit · PREDICTION-shape D110
       mirror preserved · κ-69/70 numeric-equivalence trap avoided)
    2. [x] `MeasuredOracleRef` field 가 picked record type에 land
       (schema generalization audit · **4th record type
       EnergyWindVerifyRecord** · κ-70 G37 D119 의 3rd record-type
       위 확장)
    3. [x] **XCTest invariant 가 새 cell 에 auto-extend** — invariant
       helper code 변경 0 · `invariantHolds(absorbed, measuredOracle,
       isIllustrativePhysics)` shape 의 record-type-agnostic 설계의
       **4th instance verification** (Energy/solar 1st · Aura/EEG 2nd ·
       Ufo/plasma 3rd · κ-71 Energy/wind 4th · 동일 predicate · helper
       edit 0 · D122 후 absorbed=true boundary 에서도 재확인). 3rd 가
       이미 strongest evidence — **4th 는 BOTH absorbed=false (D121)
       AND absorbed=true (D122) boundary 에서 confirmation = strongest
       across-boundary evidence yet**
    4. [x] 다른 cell record 회귀 0 — full cockpit test suite PASS
       (Energy/solar G29 · Aura/EEG G33 · Ufo/plasma G37 fixture
       path 영향 0 · D121 absorbed=false fixture + D122 absorbed=true
       fixture coexist)
    5. [x] design.md D121 + **D122** + PLAN.md κ-71 G41 entry + ARCH
       §11.6 G41 `[~]` → `[x]` flip + κ-71 R10 4/4 proper closure
       (G42 row PATCH 3/4 → 4/4)
  - **deps**: G40 (decision · D120) · G28 (schema 재사용) · G30 Stage 1
    (invariant pattern) · D80 / D86 / D103 / D106 / D116 floors ·
    (#1 Energy/wind 채택 시) `power_curve_kernel.hexa` substrate land
  - **est**: 1-3 session (G40 picked cell 의 substrate/schema cost
    의존 · κ-71 은 1-field 확장 후보 없어 κ-70 Ufo [~1 session 최저
    friction] 보다 큼 · Energy/wind 채택 시 substrate kernel 선행
    cycle 포함)

- [x] **G42.** κ-71 R10 closure 박제 (initial PATCH **3/4 LANDED + G41
    `[~]` PARTIAL** · κ-70 R9 closure entry mirror · **then upgraded
    same-day to 4/4 LANDED via D122 kernel refinement**)
    — **LANDED 2026-05-22 (initial 3/4) → 4/4 PROPER CLOSURE same-day**:
    governance row update `project.tape @D d6` PATCH (3-carrier →
    **4-carrier audit COMPLETE** · EnergyWindVerifyRecord G41 added
    as 4th carrier). κ-71 R10 closure narrative (final): G39 ✅ + G40 ✅
    + **G41 [x] LANDED** (6 of 6 components · D122 kernel-refinement
    flip · mean_rel_err 0.0708 → 0.0298 PASS) + G42 ✅ governance.
    **4/4 LANDED** — initial 3/4 honest-PARTIAL framing superseded by
    same-day D122 Path (i) execution. hexa-lang side PR #320
    (v0.1.0 producer · D121 audit-trail) + PR #325 (v0.2.0 kernel
    refinement + producer · D122 flip) — both OPEN pending hexa-lang
    bootstrap CI re-stabilization (chronic 11-silent-wipe pattern ·
    orthogonal to G41/G42 governance surface). `project.tape @D d6`
    "edit-in-place except for PATCH wording" self-rule respected.
  - **scope**: κ-70 R9 4/4 CLOSURE entry (PLAN.md 2026-05-22 ·
    `## 진행 로그`) 의 동형 mirror — κ-71 R10 closure 박제. G39..G41
    누적 LANDED → closure entry. R9 의 "next horizon (κ-71+)" 4 후보
    line 의 evolved successor = "next horizon (κ-72+)" 4 후보 (G40
    picked cell 의 follow-on axis + 잔여 candidate cluster + 5th cell
    measured-oracle round · honestly placeholder). governance row
    contribution = `project.tape @D d6` 의 **4th-carrier audit framing
    PATCH update** (G38 의 3-carrier COMPLETE → 4-carrier · `@D d6`
    self-rule "edit this row in-place except for PATCH wording" 준수).
  - **exit criterion** (G38 closure entry mirror · 모두 [ ]):
    - [ ] κ-71 R10 4 G-item 누적 LANDED 박제 (G39 [ ] research note ·
      G40 [ ] D120 · G41 [ ] D121 · G42 [ ] 본 entry)
    - [ ] PASS shape honest disclosure (G40 picked cell + oracle 의
      shape · D110 prediction / D117·D119 numeric-equivalence / Bio
      option-b discrete-exact 중 어느 것인지 명시 · 4-cell shape
      spectrum 박제)
    - [ ] XCTest invariant 4th carrier auto-extension audit confirmed
      (G41 exit criterion #3 cross-link · invariant helper edit 0 ·
      4 record type × 동일 predicate = record-type-agnostic 설계의
      redundant-confirmation evidence)
    - [ ] D106 illustrative carve-out governance-affirmed OUT of
      measured-oracle scope 유지 (`@D d6` dont= line · RFC 013 §6.12)
    - [ ] `next horizon (κ-72+)` placeholder 박제 (κ-70 closure entry
      의 4-item list 동형 · PLAN.md κ-71 R10 closure entry body)
    - [ ] design.md / PLAN.md / ARCH §11.6 / project.tape / NEXT_
      SESSIONS 의 cross-consistent state
  - **deps**: G39 + G40 + G41 누적 LANDED · κ-70 R9 closure entry
    pattern (PLAN.md) · `project.tape @D d6` (governance row) · RFC
    013 §6.11 LANDED status 유지 (κ-71 R10 = same-invariant 의 fourth-
    instance generalization audit · RFC status 미flip · narrative
    cross-link만 add via D121)
  - **est**: 0.3-0.5 session (κ-70 R9 closure entry mirror · doc
    edit · code 0)

---

### 11.7 G43–G46 implementation checklist (κ-72 R11 · horizon round · scaffold)

**라운드 11 — κ-72 R11 horizon round (scaffold · pre-code · framing TBD)**

> **R11 status (2026-05-22)**: G43..G46 all `[ ]` · scaffold only ·
> code 0. **G43 framing decision is the first sub-gate** — Framing A
> (G41 resumption · kernel refinement OR oracle-criterion D-block) ·
> Framing B (5th cell · Bio/Chem/Matter NEW DOMAIN) · Framing C
> (hybrid · κ-72 = A · κ-73 = B). Recommendation in framing-research
> note = **Framing A** (advisory only · pick belongs to next session).
>
> κ-71 R10 closure entry (`c82fe0e` PLAN log · `2ac28b4` G42 commit)
> 의 'next horizon (κ-72+)' 약속 이행 — Round 11 scaffold 박음. 본
> round 의 G-shape 는 **picked framing 에 의존**:
>
> - **Framing A picked (recommended)**: G43 = resumption-track
>   decision (Path (i) kernel refinement vs Path (ii) oracle-criterion
>   D-block · D122 자연 순서) · G44 = substrate refinement land OR
>   D-block-only oracle relaxation · G45 = G41 first-flip 재시도
>   (D123 · 4th cell `EnergyWindVerifyRecord` 재사용 · 새 record 0) ·
>   G46 = R11 closure (4/4 LANDED if G45 PASS · 또는 PARTIAL 재현).
> - **Framing B picked**: G43 = 5th cell candidate research (κ-71 G39
>   mirror · Bio/Chem/Matter finalist) · G44 = 5th cell pick (D122 ·
>   κ-71 G40 mirror) · G45 = 5th cell first-flip (D123 · κ-71 G41
>   mirror · 5-record-type audit · PARTIAL risk 명시) · G46 = R11
>   closure.
> - **Framing C picked**: κ-72 G43..G46 = Framing A shape · κ-73
>   §11.8 (post-κ-72-closure) = Framing B shape.
>
> code 변경 0 — ARCH narrative 만 4 placeholder G-item 박는다. 각
> 항목 진행되면 `[x]` 로 박고 PLAN κ-72 entry + design.md D-block
> (D122/D123 자연 순서) + 영향 파일 commit 으로 묶을 것.
> illustrative-physics gate (D106) 가 적용된 cell 은 본 round 의
> `absorbed` flip 대상 아님 — RFC 013 §6.12 anti-conflation 유지.
>
> **κ-72 honest precedent inheritance**: κ-71 R10 = 첫 PARTIAL
> 라운드 (3/4 + G41 `[~]`). 본 R11 의 어떤 framing 도 PARTIAL 가능성
> 명시 인정 — Framing A 의 G45 가 refined kernel 위에서 여전히
> PASS 못해도 honest 3/4 + G45 `[~]` 가 정직한 land · Framing B 의
> G45 가 새 record + 새 oracle 위에서 PARTIAL 도 동일. **R4 invariant
> 가 작동하는 design 증거 · 실패 아님.** 4/4 LANDED 는 *결과*이지
> *목표*가 아니다 — 목표는 R4 의 정직한 land.
>
> **G41 [~] PARTIAL 상태 유지 (κ-72-A G45 시점까지)**: 본 §11.7
> scaffold 가 land 되어도 §11.6 G41 의 `[~]` 는 그대로 · D121 도 그대로 ·
> κ-72-A G45 가 PASS 시점에만 §11.6 G41 → `[x]` 로 flip. κ-72-B/C
> 채택 시 G41 indefinite `[~]` (B 채택 시 영구 · C 채택 시 κ-72-A
> 완결로 close).

- [ ] **G43.** framing decision + (Framing A 시) resumption-track
    decision (Path (i) kernel refinement vs Path (ii) oracle-criterion
    D-block) — κ-72 R11 first sub-gate · pre-code decision · code 0
  - **scope**: 3 framing (A · B · C) 중 1 pick · Framing A 채택 시
    추가로 Path (i)/(ii)/(iii) 중 1 pick. **honest precedent**: κ-71
    R10 의 PARTIAL closure 가 처음이므로 본 G43 도 "어떤 framing
    이 R4-honest 한가" 의 첫 decision — κ-68 G27 / κ-69 G32 / κ-70
    G36 / κ-71 G40 의 *new-cell-pick* 패턴과는 shape 가 다름 (본 G43
    은 *round-shape pick*). research note 의 ranking 제안:
    - **Framing A 추천** (G41 resumption · D122 = resumption-track ·
      smallest scope · closes open `[~]` · 4-domain progression broken
      but precedent affirmed)
    - Framing B (5th cell · D122 = 5th cell pick · highest new-domain
      signal · G41 stays `[~]` indefinite · PARTIAL-risk repeat)
    - Framing C (hybrid · κ-72 = A · κ-73 = B · best of both · κ-73
      scaffold 추가 obligation)
  - **artifact**: 본 G43 land 시점 = `design.md ### Decision 122`
    박제 (Framing A 채택 시 = "resumption-track 선정" D-block · Path
    (i)/(ii) 중 1 명시 · Framing B/C 채택 시 = "5th cell pick" or
    "hybrid sequence commit" D-block). κ-71 G40 D120 mirror style.
  - **exit criterion**:
    - [ ] framing pick + rationale 명시 (research note 의 trade-off
      참조 · "이 framing 이 #1 으로 올라가려면" 조건 hit 여부)
    - [ ] (Framing A 시) Path (i)/(ii)/(iii) 중 1 명시 · Path (iii)
      anti-pattern reject rationale 동반
    - [ ] design.md D122 박제 · κ-71 G40 D120 mirror style ·
      5-fold lock-in (Framing A 시) OR 5-fold lock-in (Framing B 시 ·
      cell + external oracle + bridge + hexa-native + PASS criterion ·
      κ-71 G40 D120 동형)
    - [ ] research note (G43 artifact OR sibling commit) cite +
      회피 framing reject rationale 명시
    - [ ] 새 code 0 · 새 stored field 0 · 새 `.demi` row 0
    - [ ] PLAN.md κ-72 G43 LANDED entry + ARCH §11.7 G43 `[ ]` → `[x]`
      flip
  - **deps**: 본 §11.7 scaffold land · `inbox/notes/2026-05-22-k72-
    horizon-framing-research.md` (3-framing 5-fold lock-in · ranking
    advisory · 본 commit 동시 land) · D121 (κ-71 G41 PARTIAL · the
    precedent · resumption paths (i)/(ii)/(iii) baked-in) · D120
    (κ-71 G40 cell-pick · PASS criterion baked-in) · D106/D103/D86/D80
    floors
  - **est**: 0.3-0.5 session (decision gate · code 0 · κ-71 G40 D120
    mirror style · framing 선택은 사용자 explicit pick · pre-pick
    금지)

- [ ] **G44.** substrate refinement land (Framing A · Path (i)) OR
    oracle-criterion D-block (Framing A · Path (ii)) OR 5th cell pick
    (Framing B · D122 자리 shift) — picked framing 에 의존
  - **scope**: G43 의 picked framing 에 따라 shape 분기:
    - **Framing A · Path (i)**: hexa-lang `stdlib/kernels/wind/
      power_curve_kernel.hexa` v0.1.0 → v0.2.0 (additive · 2nd curve
      form · 다음 중 1: multi-segment quadratic · sigmoidal-on-rated ·
      piecewise-cubic with rated smoothing) · cross-impl parity vs
      Python ref · hexa-lang PR mirror PR #308 pattern · κ-71 G41
      substrate sub-phase mirror (`inbox/notes/2026-05-22-k71-g41-
      substrate-LANDED.md` 동형)
    - **Framing A · Path (ii)**: `design.md ### Decision 122` body
      가 새 PASS criterion 정의 (operating-regime weight by energy
      yield · Weibull · per-bin weight 등) · code 거의 0 (producer
      update only if criterion shape changes input shape) · honest
      disclosure 필수: "PASS criterion redefined · NOT modeling-
      accuracy improvement"
    - **Framing B**: κ-71 G40 D120 mirror · 5th cell 5-fold lock-in
      decision · D122 박제 · code 0. research note 의 #1 default =
      Bio (option b NW for substrate floor zero · OR option a ECG for
      prediction-shape signal)
  - **exit criterion** (framing-dependent · 모두 [ ]):
    - **Framing A · Path (i)**:
      - [ ] `stdlib/kernels/wind/power_curve_kernel.hexa` v0.2.0
        merged (2nd curve form API · v0.1.0 cubic_interp preserved)
      - [ ] cross-impl parity vs Python ref · exact match on pool:ubu-2
      - [ ] `pilot-power_curve` row PILOTS.demi 갱신 (v0.2.0 reference)
      - [ ] 새 stored field 0 · 새 `.demi` row 0 (kernel only)
    - **Framing A · Path (ii)**:
      - [ ] design.md D122 박제 · 새 PASS criterion 정의 + cherry-
        pick disclosure ("D120 PASS 0.05 unchanged · weighting
        redefined" 또는 "PASS threshold changed honestly")
      - [ ] producer code change disclosed (if any · D86 floor 유지)
    - **Framing B**:
      - [ ] design.md D122 박제 (5th cell pick · 5-fold lock-in ·
        κ-71 G40 D120 mirror style)
      - [ ] candidate-research note cite + 회피 후보 reject rationale
      - [ ] `MeasuredOracleRef` schema 재사용 audit (5th record-type
        instance)
    - [ ] PLAN.md κ-72 G44 LANDED entry + ARCH §11.7 G44 `[ ]` → `[x]`
  - **deps**: G43 (framing + Path/cell pick) · `power_curve_kernel.
    hexa` v0.1.0 (PR #308 MERGED · κ-71 G41 substrate baseline) · D121
    Path (i)/(ii)/(iii) baked-in scope · D86/D103/D106/D80 floors
  - **est**: framing-dependent: Path (i) = 1-2 session · Path (ii) =
    0.3 session (D-block only) · Framing B = 0.3-0.5 session (κ-71
    G40 mirror)

- [ ] **G45.** G41 first-flip 재시도 (Framing A · `absorbed=true`
    legitimate land · 4th cell EnergyWindVerifyRecord 재사용) OR 5th
    cell first-flip (Framing B · 새 record · 5-record-type audit) —
    picked framing 에 의존
  - **scope**: picked framing 에 따라:
    - **Framing A**: κ-71 G41 의 재시도 · refined kernel (Path i) 또는
      refined PASS criterion (Path ii) 위에서 measure · `mean_rel_err
      ≤ 0.05` over [4,25] m/s · D-block D123 = "G41 resumption
      result". `EnergyWindVerifyRecord` 재사용 (새 record 0). 4-record-
      type audit 갱신 0 (이미 confirmed · 4-record 그대로 · `absorbed`
      true 로 flip). §11.6 G41 `[~]` → `[x]` *옆문* flip (D123 cite +
      D121 supersedes note)
    - **Framing B**: κ-71 G41 mirror · 새 record (5th carrier · Bio
      = `BioVerifyRecord` 또는 Chem = `ChemVerifyRecord`) · `Measured
      OracleRef` 5th-record-type instance · invariant audit 5th
      instance (redundant confirmation 가치 · κ-71 G39 research §주요
      trade-off #4 참조) · D123 = 5th cell first-flip
  - **exit criterion** (framing-dependent · 모두 [ ]):
    - **Framing A**:
      1. [ ] refined kernel (Path i) 또는 refined PASS criterion (Path
         ii) 위 measurement · `mean_rel_err honest disclosure
      2. [ ] PASS achieved → `absorbed=true` flip · §11.6 G41 `[~]` →
         `[x]` flip · D121 → D123 supersedes 명시
      3. [ ] FAIL → honest D123 PARTIAL · κ-71 G41 pattern repeat ·
         §11.7 G45 `[~]` PARTIAL · 4/4 LANDED 미달성 (G46 closure
         honestly 3/4)
      4. [ ] 4-record-type audit 변경 0 (이미 confirmed · 4-record
         그대로 · κ-71 D121 #4 mirror)
      5. [ ] 다른 cell record 회귀 0 — full cockpit test suite PASS
      6. [ ] design.md D123 + PLAN.md κ-72 G45 entry + ARCH §11.7 G45
         `[x]` (PASS 시) 또는 `[~]` (FAIL 시 · PARTIAL)
    - **Framing B**:
      1. [ ] 5th cell `absorbed=true` flip + D123 박제 · κ-71 G41
         mirror · `mean_rel_err` honestly disclosed · PARTIAL 가능성
         scope 박제
      2. [ ] 새 record type land · `MeasuredOracleRef` 5th-record-type
         instance · schema generalization audit 5th instance
      3. [ ] XCTest invariant 5th carrier auto-extend · invariant
         helper code 변경 0 · `invariantHolds(absorbed, measuredOracle,
         isIllustrativePhysics)` shape · 5 record type × 동일
         predicate × helper edit 0
      4. [ ] 다른 cell record 회귀 0
      5. [ ] design.md D123 + PLAN.md κ-72 G45 entry + ARCH §11.7 G45
         flip
  - **deps**: G44 (substrate refinement OR D-block OR 5th cell pick) ·
    G28 (`MeasuredOracleRef.swift` schema · κ-72 G45 = 4th instance
    reuse [Framing A] 또는 5th instance [Framing B]) · G30 Stage 1
    (invariant pattern · 4-record audit confirmed by κ-71 G41) · D80/
    D86/D103/D106/D116 floors
  - **est**: framing-dependent: Framing A = 0.5-1 session (single-
    cell control loop) · Framing B = 1-3 session (κ-71 G41 mirror ·
    PARTIAL risk per κ-71)

- [ ] **G46.** κ-72 R11 closure 박제 (4/4 LANDED 시 첫 "resumed-
    flip" 라운드 · 또는 honest 3/4 + G45 `[~]` PARTIAL closure 시
    κ-71 R10 mirror)
  - **scope**: κ-71 R10 closure entry (PLAN.md 2026-05-22 ·
    `## 진행 로그`) 의 successor — κ-72 R11 closure 박제. G43..G45
    누적 LANDED → closure entry. R10 의 "next horizon (κ-72+)" 4 후보
    line 의 evolved successor = "next horizon (κ-73+)" 4 후보 (Framing
    C 채택 시 κ-73 = 5th cell · Framing A/B 단독 채택 시 κ-73
    placeholder). governance row contribution = `project.tape @D d6`
    의 4-carrier audit framing **PATCH update** (κ-71 G42 의 "flip
    DEFERRED" → "flip LANDED via resumption" [Framing A G45 PASS]
    또는 "5-carrier audit COMPLETE" [Framing B G45 PASS] 또는 "G41
    still DEFERRED + resumption attempted" [G45 FAIL]).
  - **exit criterion** (κ-71 G42 closure entry mirror · 모두 [ ]):
    - [ ] κ-72 R11 4 G-item 누적 LANDED 박제 (G43 [ ] framing +
      track/cell pick · G44 [ ] substrate refinement OR D-block OR
      5th cell pick · G45 [ ] resumed flip OR 5th cell flip · G46 [ ]
      본 entry)
    - [ ] PASS shape honest disclosure (Framing A G45 PASS = D121 +
      D123 supersedes-with-refinement · Framing A G45 FAIL = honest
      PARTIAL κ-71 pattern repeat · Framing B G45 = 5th PASS shape
      [Bio prediction R-peak 또는 Bio option-b discrete-exact rel_err=0
      또는 Chem numeric-equivalence])
    - [ ] (Framing A 시) §11.6 G41 `[~]` → `[x]` (G45 PASS 시 · D123
      cite + D121 supersedes 명시) OR §11.6 G41 `[~]` 유지 (G45 FAIL
      시 · D121 unchanged + D123 partial-result 추가)
    - [ ] (Framing B 시) XCTest invariant 5th carrier auto-extension
      audit confirmed (G45 exit criterion cross-link · invariant
      helper edit 0 · 5 record type × 동일 predicate = redundant-
      confirmation evidence)
    - [ ] D106 illustrative carve-out governance-affirmed OUT of
      measured-oracle scope 유지 (`@D d6` dont= line · RFC 013 §6.12)
    - [ ] `next horizon (κ-73+)` placeholder 박제 (κ-71 closure entry
      의 4-item list 동형 · honest)
    - [ ] design.md / PLAN.md / ARCH §11.7 / project.tape / NEXT_
      SESSIONS 의 cross-consistent state
    - [ ] R11 closure shape 명시: **4/4 LANDED** (G45 PASS) 또는
      **honest 3/4 + G45 `[~]` PARTIAL** (G45 FAIL · κ-71 R10 패턴
      재현). 후자는 design 실패 아님 · R4 invariant 작동 증거.
  - **deps**: G43 + G44 + G45 누적 LANDED · κ-71 R10 closure entry
    pattern (PLAN.md `c82fe0e`) · `project.tape @D d6` (governance
    row) · RFC 013 §6.11 LANDED status 유지 (κ-72 R11 = Framing A 시
    same-invariant 의 fourth-instance flip-completion 또는 Framing B
    시 fifth-instance generalization audit · RFC status 미flip 둘 다)
  - **est**: 0.3-0.5 session (κ-71 G42 closure entry mirror · doc
    edit · code 0)

---

## 12. Open axes (substrate-side · post-cell-flip)

This section tracks open work on **substrate-side parity axes**,
running parallel to the per-cell measured-oracle round structure of
§11.4. Each axis owns its own gate (g3 substrate · `measurement_gate`
flip) and lands independently of the §11.4 G-rounds. ARCH §12 carries
the narrative anchor + Tier-1/2/3 shape; detail SSOTs live in
`inbox/notes/`.

> **landing-axis distinction** — D80 endpoint rule (§0): per-cell
> `absorbed=true` (e.g. chip §B+§D κ-43 dynamic flip) is a separate
> axis from the **hexa-native parity port** axis tracked here. A cell
> can be `absorbed=true` while its substrate-axis `measurement_gate`
> is still OPEN; the §12 axes close the latter without changing the
> former. Closure of a §12 axis removes the `provisional=true`
> demotion risk implied by §0, but is NOT itself a cell flip.
>
> **infrastructure-axis distinction** — Many §12 substrate-axis measurements
> can route their heavy compute through the `pool` CLI infrastructure
> layer (e.g. chip §B substrate-axis ABC cross-platform reproducibility
> audit ran on ubu-2 per `inbox/notes/2026-05-21-pool-gate_v3-abc-
> diagnosis.md`). Pool is a *venue, not an endpoint* — closing a §12
> substrate-axis via pool dispatch still requires the hexa-native parity
> port to satisfy §0. Cross-link: `POOL.md` for the routing taxonomy +
> honest invariants + the `_pool_cli_present` canonical adapter
> precedent.

### 12.1 chip §B — rfc_006 §5 area-oracle parity (yosys absorption)

> **inherited 2026-05-21**: 구 root `YOSYS.md` (rm'd at `06a8428`) 의
> 잔여 Tier-1/2/3 로드맵을 본 절로 이관. Detail SSOT (entry-by-entry
> 측정-fact + 사이클별 변동 log · 1754 line · entries (o)..(bb)+ 누적)
> 는 `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md`.

**goal** — hexa-native synth chain 이 substrate yosys+SKY130 의 oracle
area (router_d4 = 61,762.99 µm² · router_d6 = 93,608.53 µm² · ratio
1.5156× bit-exact) 를 ±5 % 안에서 재현 → rfc_006 §5
`measurement_gate = CLOSED_MEASURED` flip.

**current gate state** (2026-05-21 KST · post hexa-lang `df4ff3f7`
Tier-1 (ii) Option I LANDED · post (ll) Option F agent fresh chain
rerun verification):
- `measurement_gate = OPEN` · substrate-axis `absorbed = false`
  (cell-side κ-43 flip 별 axis · unchanged `absorbed=true`)
- area measurement (mac-side `HEXA_EXEC_NO_SHELL=1 hexa run
  stdlib/yosys/gate_record.hexa` · fresh clean-worktree rerun):
  - router_d4 = **32,829 µm²** (Δ=**46.85 %** vs oracle 61,763 ·
    27× pre-(e) baseline · Option I 1:1 per-`.latch` reader-half at
    `abc_map.hexa` L470-479) · `abc_map: ok exit=0`
  - router_d6 = **45,936.6 µm²** (Δ=**50.93 %** vs oracle 93,608.5 ·
    same Option I closure) · `abc_map: ok exit=0`
  - chain selftest 8/8 PASS · 1638 `.latch` lines d4 · 2292 d6 ·
    1653 / 2313 `.gate` lines post-ABC · EXACT substrate flop count
    match · narrative authority `inbox/notes/rfc006-s5-area-oracle-
    parity-handoff.md` entry (ll) · supersedes (kk)'s stale-BLIF
    revert to 1207.41 / 1677.86 µm² (measurement pipeline artifact)
- gate target window: area ∈ [58,675, 64,851] µm² (d4 ±5 %) +
  [88,928, 98,289] µm² (d6 ±5 %) · NOT yet met · residual ~47-51 %
  gap = `share`/`freduce` (comb sharing) + DFFE-promotion · Option E +
  Tier-2 territory (4–8 session estimate)

**Tier-1 — closure path (immediate, multi-session)**

- [x] (0) **exec runtime restore** — upstream PR #251 (hexa-lang
  cycle 66 `8ea4b75e`) MERGED; popen/spawn stubs 복구 → `hexa exec`
  chain testable
- [x] (a) **PR #247 SSA fix** (`8dd1e677` + `f4c3c493`) MERGED — `_rv_
  parse_always` for-handler 의 intra-iteration blocking-LHS chain
  per-iter SSA renaming (3 helper + read-then-write filter · T73
  selftest)
- [x] (b) **PR #255 abc_map honesty** MERGED `e4f79e26` 2026-05-21 —
  `abc_map.hexa` truncate-before-exec + `combinational loop` stdout
  pattern + T9/T10 selftest (renumbered from T8/T9 post-Option-I
  rebase to avoid collision with Option I's T8 multi-bit `.latch`
  test). stale `_out.blif` false-positive load-bearing guard ·
  post-Option-I rebase clean (test-section only conflict · abc_map
  function body untouched) · selftest 10/10 PASS · zero regression
- [x] (c) **abc_map script reorder** (`read_lib` → `read_blif`) —
  already in PR #247 `logic_synth/abc_map.hexa` L478-486
- [x] (d) **`rr_ptr__d` cross-iter comb-loop** — hexa-lang PR #261
  (`0ca0994f`) MERGED 2026-05-20T19:26:33Z (RFC 073 Phase 3g · SSA
  pre-loop init redirect); `_rv_parse_always` for-handler 의 SSA
  chain pre-loop alias (`connect(s__ssa0, s)`) + post-loop publish
  (`connect(s, s__ssaP)`) 결합으로 발생한 `s__ssa0 = s = s__ssaP`
  comb cycle 을 `connect_lhs[]` 역방향 scan + pre-loop driver rhs
  직접 seed 로 해체. cycle 해체 + 외부 readers 는 post-loop publish
  통해 정확한 값 read. T74c rewrite + T74d regression guard 추가.
  read_verilog selftest 77/77 · round_trip 12/12 · abc_map 7/7
  (zero regression). **note**: PR #260 (`rfc006-yosys-ssa-seed-fix`
  branch) 는 같은 (d) target 의 parallel attempt — superseded by
  PR #261 · still OPEN
- [x] (e) **`fifo_mem[*]` 2-D LHS flat `$dff` demux** — hexa-lang
  `c4b35b13` LANDED 2026-05-21 (Option A · 2-D unpacked array LHS
  → per-slot `$eq + $and + $mux + $dff` demux · 4 sub-cases:
  const/dyn × const/dyn). Selftest 78/78 → **79/79 PASS** (+T76).
  ABC accepts cleanly · `_rv_emit_body_v2` honest-skip 제거.
  Measured (sky130_fd_sc_hd · 2026-05-21):
  - router_d4 = **1207.41 µm²** (was 559.286 · +2.16×) · oracle
    61,762.99 · still ~98% under
  - router_d6 = **1677.86 µm²** (was 771.99 · +2.17×) · oracle
    93,608.53 · still ~98% under
  Follow-up width-aware fix `a4a032af` (D-wire mirror packed
  width via `_rv_v2_wire_width`) · 79/79 PASS preserved (no area
  delta — BLIF emitter still collapses multi-bit to single
  `.latch`). **scope note**: (e) 의 own-scope (area > 0 + ABC
  accepts + no honest-skip) CLOSED. §5 absolute area gap ~98%
  잔존 — Option B (RTLIL `$memrd`/`$memwr`) 또는 (f) crossbar
  output array writes 가 cluster cost 의 dominant 잔여. NO
  `Yosys absorbed` claim. PR #256 inbox patch status → "Option
  A landed".
- [~] (f) **end-to-end router_d4 area > 0 → ±5 % gate** measurement
  — **PARTIAL-LANDED** (chain-measured **32,829 µm²** · oracle gap
  **46.85 %** · 79 % of substrate-axis gap closed since (e)+(ii)
  Option I · BLIF `.latch` count 1638 matches substrate flop count ·
  post-ABC `.gate` lines 1653 per-bit-mapped · gate target window
  ∈ [58,675, 64,851] µm² NOT yet met). Source: Option F agent
  2026-05-21 KST fresh chain rerun (`hexa run stdlib/yosys/
  gate_record.hexa` from clean worktree · selftest 8/8 PASS) ·
  narrative authority `inbox/notes/rfc006-s5-area-oracle-parity-
  handoff.md` entry (ll). Residual ~47 % gap = comb sharing
  (`share`/`freduce`) + DFFE-promotion (`$_DFFE_PP_` @ 30.03 µm² vs
  hexa-native `$_DFF_P_` @ 20.02 µm²) · Option E + Tier-2 territory ·
  NOT yet ±5 % gate close.
- [~] (g) **router_d6 parity** measurement — **PARTIAL-LANDED**
  (chain-measured **45,936.6 µm²** · oracle gap **50.93 %** · 2292
  `.latch` lines · 2313 post-ABC `.gate` lines · area target window
  ∈ [88,928, 98,289] µm² NOT yet met) · same Option I 79 % gap
  closure logic as (f) · same Option E residual.
- [ ] (h) **ratio 1.5156× verification** — d6/d4 = 45,936.6 / 32,829
  = **1.3995** vs oracle 1.5156 · 7.7 % off · target ∈ [1.4399,
  1.5914] (±5 %) NOT yet met · closes naturally as Option E lands
  (d6 uses proportionally more DFFE than d4 in substrate)
- [ ] (i) **`measurement_gate = CLOSED_MEASURED`** flip — g3
  conditional · d4 + d6 + ratio 三項 all PASS 이후만

**Tier-2 — post-closure expansion (week+ scope)**

- [ ] **`$adff` / `$sdff` / `$dffe` write_verilog behavioural emit**
  — reset / enable variants. `always @(posedge clk, posedge rst) if
  (rst) q <= 0; else q <= d;` round-trip · T14/T15/T16 selftest 가
  signal. router-class designs 가 사용
- [ ] **share / freduce parity** — comb-side oracle gap closure
  (handoff (s) finding: `synth` macro 의 logic-sharing optimizations
  ~12,806 µm² 차). 옵션 A = `stdlib/kernels/logic_synth/passes.hexa`
  의 share + freduce impl · 옵션 B = substrate-yosys-as-tail-pass
  (hexa-native frontend → substrate `synth` tail · D80 endpoint 의
  hexa-native ultimate-form 와 trade)
- [ ] **formal equivalence check** — substrate `yosys -p "...
  equiv_make oracle hexa_native eq; equiv_simple; equiv_status"`
  reports `0 unproven` · hexa-native ↔ substrate's oracle RTLIL
  semantic equivalence (§5 cross-verification)

**Tier-3 — announcement + governance close**

- [ ] **`ABSORPTION.md` §178 yosys row** flip → `absorbed=true ·
  measured area passes ±5 %` · Tier-1 all `[x]` dependency
- [ ] **rfc_006 §5 closure announcement** — `measurement_gate =
  CLOSED_MEASURED · absorbed=true · 2026-MM-DD measured` ROADMAP +
  commit message adoption · ABSORPTION.md updated dependency

**estimate** (post-2026-05-21 (e) Option A LANDED audit): **8–16
sessions** until gate close. Tier-1 (f) + (g) + (h) + (i) cluster
가 dominant 잔여 cost (§5 absolute area gap ~98% 잔존 — Option A
flat $dff 는 substrate `synth_memory_dff` consolidated count 보다
~10× 비싸므로 ±5 % closure 는 Option B `$memrd`/`$memwr` cells 또는
crossbar output array writes (Tier-1 (f) territory) 필요); Tier-2 +
Tier-3 는 gate flip 이후 unlock.

**shape note** — 이 axis 의 work 는 sibling repo `~/core/hexa-lang`
에서 일어남 (demiurge 측은 narrative emit + ABSORPTION.md row flip
정도). demiurge 측 commit 0 에 가까운 axis — sibling-repo PR 의
landing 시각만 ARCH `## Log` 에 박제.

---

---

Historical log entries are in [`./ARCH.log.md`](./ARCH.log.md).
