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

### 11.4 G1–G8 implementation checklist

> 모두 미진행 (`[ ]`). 각 항목 진행하면 `[x]` 로 박고 PLAN κ-entry
> + design.md D-block + 영향 파일 commit 으로 묶을 것. 라운드 단위
> 묶음 commit 가능 (G1+G3+G5 한 commit, G2+G7 한 commit, G4+G6+G8
> 한 commit).

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
