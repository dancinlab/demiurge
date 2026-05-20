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
> **ultimate destination** is **hexa-native** (hexa-lang). Python
> adapters, Swift cockpit, external CLI, and sibling-repo binaries
> are **transitional pointers (bridges)** — not endpoints. A cell
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

### 4.4 Sibling repos (D17 / D77)

`hexa-lang` is the single SSOT for stdlib code. A handful of
substrate domains live in *sibling repos* because their full
substrate tree is much larger than what fits as one stdlib subtree:

```
~/core/hexa-matter/   — material synthesis substrate (D17 precedent)
~/core/hexa-bio/      — molecular biology substrate (D77, planned)
~/core/hexa-chem/     — chemistry substrate (D77, planned)
```

The demiurge-side domain (`domains/matter.md`, `domains/bio.md`,
`domains/chem.md`) is a **pointer** — it carries the deliverable
spec + cited sources, and its substrate scripts spawn into the
sibling repo. `hexa-lang/stdlib/<domain>/` for these three points
to the sibling repo's entry script rather than holding the math.

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

**Refresh (2026-05-21 · κ-68 opening · D109 land)** — 위 G1–G8 는
κ-62 시점의 *initial gap surface* (cross-sim two-project 비교가
처음 표면화한 gap, alien-disc-mk1 ↔ aura-clip-mk1 cross-cohort 의
교집합). §11.4 의 implementation checklist 는 그 후 7 round 로 확장:
Round 1-3 (G1–G8 fundamental / honesty surface / cross-domain audit ·
κ-62) · Round 4 (G9–G12 hexa-native parity surface · D80 sweep · κ-65) ·
Round 5 (G13–G18 D80 SSOT 통합 + 후속 · D87..D101 sweep) · Round 6
(G19–G26 κ-67 closure + post-closure pilot #13 · D102..D108 + geodesy) ·
Round 7 (G27–G30 *in-progress* · κ-68 per-cell measured-oracle parity
round · RFC 013 §6.11 · G27 [x] D109 land 2026-05-21 · G28–G30
queued). 본 §11.3 의 G1–G8 priority 는 *initial-round historical*
표면 — 현 ground truth 는 §11.4 의 G1–G30 Round 1-7 가 carry. §11.3
는 cross-sim *origin gap* 의 audit trail 로 보존 (g_ssot_single_source
D50 — phase boundary 별 한 snapshot 유지).

### 11.4 G1–G30 implementation checklist

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
> in-progress)** 는 stored `absorbed: Bool` 의 첫 legitimate flip 을
> cell-side measured oracle 로 트리거 (NOT D95 computed projection)
> 하는 round — pre-code 시점에 4 G-item placeholder 로 scaffold.
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

- [ ] **G28.** Producer wire — substrate adapter 가 measured-oracle
    field 를 cell record 에 emit (`absorbed` 미flip)
  - 선정 cell 의 substrate adapter (hexa-lang 또는 sibling repo) 가
    verify record JSON 에 typed measured block (측정값 · external
    reference · rel_err · threshold · oracle source ref) inject.
    `hexa_native_parity` 와 별도 axis 의 새 field set. `absorbed:
    Bool` 은 false 유지 (D103 separation — schema half 만 land).
  - deps: G27 (cell choice) · D86 (no hardcoded data) · D103
    (dimension-separation)
  - exit:
    - cell record schema 1개 확장 (`<X>VerifyRecord.swift` typed
      `measuredOracle: MeasuredOracleRef?` 후보)
    - exports/ 에 measured block 보유 record JSON ≥ 1 land
    - XCTest ≥ 1 (decode + measured field 존재 검증)
    - `absorbed` 는 false 유지 (cell-flip 분리)

- [ ] **G29.** 첫 cell `absorbed: true` legitimate flip (NOT D95
    computed projection)
  - G28 measured-oracle PASS 조건에서 cell record writer 가 stored
    `absorbed: Bool` 을 true 로 명시적 set. D95 computed `isHexa
    NativeAbsorbed` 재사용 금지 — stored field 와 computed field 는
    별도 set path 유지 (D103). RFC 013 §6.11 의 land 조건 충족.
  - deps: G28 (measured field 존재) · D80 (honesty floor) · D95
    (computed 와 격리) · D103 (dimension-separation)
  - exit:
    - 단일 cell 의 stored `absorbed: Bool` true land (measured
      oracle PASS 근거 cell record 안에 cite)
    - 다른 cell record 회귀 0 (의도치 않은 flip 없음)
    - design.md D-block + PLAN.md κ-68 entry
    - swift build/test PASS

- [ ] **G30.** Governance gate — absorbed-vs-measured invariant typed
    enforcement (D103 docstring → compiler-checkable)
  - AGENTS.tape `@D` 후보 1 row (이름 G27 단계에서 결정 — 예:
    `g_absorbed_needs_measured_oracle`) + cockpit XCTest 가
    "measured field 부재 시 stored `absorbed: Bool` true 면 FAIL"
    invariant enforcement. D103 docstring 의 semantic gate 를
    test-level guard 로 격상. D106 illustrative-physics case 는
    invariant 에서 제외 (anti-conflation 유지).
  - deps: G29 (첫 land 사례 존재) · D103 (docstring gate) · D106
    (illustrative-physics 제외)
  - exit:
    - XCTest invariant PASS
    - `AGENTS.tape` `@D` 1 row land
    - 기존 cell record (illustrative-physics 등) 회귀 0
    - swift build/test PASS

---

## Log

- 2026-05-20 — ARCH.md created. Consolidates D72 (kernel layer),
  D73 (firmware domain), D74 (ProducerRegistry), D76
  (SceneDescriptor), D77 (chem + bio domains), D78 (domain graph
  DAG + multi-facet tag) into one narrative architecture SSOT.
  Existing terse machine-readable index `ARCH.tape` is retained
  for tape-format consumers; this file is the human / cross-link
  layer. Numbers and counts deliberately deferred to design.md /
  PLAN.md / GOAL.md (g_ssot_single_source D50).
- 2026-05-20 — §11 Worked simulations added — two end-to-end
  design walk-throughs (`alien-disc-mk1` / `aura-clip-mk1`)
  recorded as canonical test cases. §11.4 carries the G1–G8
  implementation checklist with explicit deps / new files / edit
  targets / exit criteria per item. Round grouping: G1+G3+G5
  fundamental, G2+G7 honesty surface, G4+G6+G8 cross-domain
  audit. No code changed yet — these are design tests.
- 2026-05-20 — §0 hexa-only first-principle added (D80, AGENTS.tape
  `@D g_hexa_only` INDEX top). User gate "hexa only / hexa-native
  최상단 기록". Raises `g_hexa_native` (D14+D18, absorption-time
  preference) to absolute endpoint rule. Python/Swift/external CLI
  are transitional pointers, not endpoints. `absorbed=true` non-
  provisionally requires the hexa-native parity port. cern+synth
  (κ-51) reclassified as *provisional* (scope_caveats 이미 명시 한
  형식의 typed 화는 후속 phase).
- 2026-05-20 — §11.4 G1–G8 → G1–G12 확장. κ-62 (3322523) 에서 G1–G8
  all `[x]` 마감 완료 audit, 헤딩 노트 갱신. κ-65 D80 sweep
  (5e9f6dea) 산출물 cover 를 위한 Round 4 (G9–G12) 추가: G9
  `HexaNativeParityRef` 8-field schema + 5 cell-record carrier, G10
  `DependenciesLoader` 의 44-row cross-repo SSOT consumer (DEPENDENCIES.
  demi), G11 `GateType.hexaNativeFuture` (heavy-port bucket, exhaustive
  switch 갱신), G12 hexa-lang sibling-repo fix (a272c9c4 codegen
  param-shadow + `stdlib/core/math/wrap_pi.hexa` primitive · 4389da0c
  pilot-pattern reconcile).
- 2026-05-20 — §11.4 G1–G12 → G1–G18 확장. 2026-05-20 cycle 의
  D80 SSOT 통합 + 후속 sweep (D87..D101) 산출물 cover 를 위한
  Round 5 (G13–G18) 추가: G13 `PILOTS.demi` 8-field SSOT + 12-row
  coverage (2d07fd8 foundation · efa4afe T7 · a5d12d2 D95 computed
  absorbed · 87cb765 / c63f406 / f28c1b0 / a2fcb1b D80 pilots
  #9..#12 · 3215cea chem seed), G14 19/19 도메인 narrative coverage
  (47bf504 D96 5 sibling rows + e451037 D100 14 non-sibling rows),
  G15 3-tier substrate link-integrity verifier (74a1b92 D97 Q3=A,
  `SUBSTRATE_LINKS.demi` + 3 XCTest tier), G16 cockpit
  `HexaNativeParityChip` 3-case 시각화 (f036f6f D99 render-only,
  pure-data model + SwiftUI view), G17 `DEPENDENCIES.demi ↔ PILOTS.
  demi` cross-ref CI (384101b D98 Phase F, 3 XCTest method), G18
  `DEMIURGE_HEXA_LANG` env-var deprecation (8fc0862 D101 D3/D88
  후속). 헤딩 노트 G1–G18 로 갱신.
- 2026-05-20 — §11.4 G1–G18 → G1–G24 확장 (+ G25/G26 post-closure
  pilot + breakthrough note 박제). 같은 2026-05-20 cycle 의 κ-67
  closure 및 그 직후 추가 pilot 산출물 cover 를 위한 Round 6 (G19–
  G26) 추가: G19 chem 첫 `PILOTS.demi` row (a033def D102 Stage-0
  scaffolding), G20 cell `absorbed` vs `isHexaNativeAbsorbed`
  dimension separation docstring (105315e D103 코드 변경 0), G21
  RFC 013 status `PARTIAL-LAND` → `MOSTLY-LANDED` refresh (943a5b8
  D105 κ-67 sweep reconciliation), G22 `.illustrativePhysics`
  `GateType` 4번째 case (f9a9a90 D106 RFC 013 §6.12 LANDED · anti-
  conflation cyan tone), G23 `SiblingRepoSpawner.resolveEntrypoint
  ()` 5th fallback `cli/hexa-<id>.hexa` (e66e4c0 D107 priority-
  preserving), G24 κ-67 closure 박제 (eea2804 D108 D87..D107 누적
  · 3 doc SSOT cross-link), G25 geodesy WGS84 14번째 D80 pilot
  (acac78c · hexa-lang `b7a43493` · 15th kernel folder · bridge
  substrate · 70/70 PASS @ 1e-10 · 누적 14 D80 pilots / 445
  assertions / 16 PILOTS rows), G26 D80 sweep close breakthrough
  note (1f9f934 · cold-start anchor · inbox/INDEX 27 entries).
  헤딩 노트 G1–G24 로 갱신 (G25/G26 는 Round 6 안 post-closure
  bracket).
- 2026-05-20 — §11.4 G1–G24 → G1–G30 확장. **Round 7 scaffold**
  (`κ-68 per-cell measured-oracle parity round` — RFC 013 §6.11 ·
  in-progress) 4 placeholder G-item 박음 (G27 cell + oracle 선정
  pre-code gate · G28 producer wire `absorbed` 미flip · G29 첫
  cell `absorbed: true` legitimate flip NOT D95 computed · G30
  governance invariant typed enforcement). pre-code 단계 — code
  변경 0, ARCH narrative 만 확장. stored `absorbed: Bool` 의 첫
  legitimate flip 을 cell-side measured oracle 로 트리거하는
  round 의 frame 을 박은 것. illustrative-physics gate (D106) 적용
  cell 은 본 round 의 flip 대상에서 제외 (RFC 013 §6.12 anti-
  conflation 유지).
