# Demiurge cockpit

> macOS Swift cockpit + headless CLI for Demiurge — read-only typed
> consumers of `../exports/**` records (D22 / D27 / D28 / D34 / D40 / phase
> α-3). **rfc_009** product surface · **rfc_010** 3-pane info-arch ·
> **rfc_011** control surface (4-zone tabbed + chat + AI-agent + canvas
> modes + 3D viewer).

## SwiftPM layout (phase α-3 — rfc_011 §10)

```
cockpit/
├── Package.swift                       # Demiurge package, 3 targets
├── Sources/
│   ├── DemiurgeCore/                   # library — shared typed-interface
│   │   ├── Models/F1F2Record.swift     # rfc_002 v1.0 Codable mirror
│   │   └── Loaders/RecordLoader.swift  # ../exports/** read + invariant a
│   ├── CockpitApp/                     # macOS GUI executable
│   │   ├── CockpitApp.swift            # @main + 4-zone tabbed shell
│   │   └── Views/                      # ProvenanceBanner + RecordView
│   └── DemiurgeCLI/                    # headless CLI executable
│       └── main.swift                  # subcommands: list-records / show
└── references/                         # design + validation assets
```

## Build / run

```
cd cockpit
swift build                              # both targets

# GUI
swift run CockpitApp                     # launch the SwiftUI window

# CLI
swift run DemiurgeCLI --version          # version banner
swift run DemiurgeCLI list-records       # list F1F2 records under ../exports/
swift run DemiurgeCLI show <path>        # dump one record + full provenance
swift run DemiurgeCLI --help             # usage
```

Requires Swift 5.9+ · macOS 13+. Xcode opens `Package.swift` directly for
full IDE (Previews / Instruments / debug). Both executables share the
`DemiurgeCore` library — schema changes land once, GUI + CLI see them
together (D27 monorepo schema-drift-free).

## What the CLI does today (phase α-3 + β, read-only)

| Subcommand | Behaviour |
| ---------- | --------- |
| `--version` / `-v` | Print version banner |
| `--help` / `-h` | Usage |
| `list-all` | List all artifact kinds in one pass |
| `list-records` | List F1F2 records under `RecordLoader.f1f2RecordsRoot` (= `../exports/chip/noc/f1f2/records/`) |
| `list-decisions` | List `design.md` decisions (`### Decision N — title` parse) |
| `list-rfcs` | List `../proposals/rfc_*.md` |
| `list-domains` | List `../domains/*.md` (excluding README; includes `matter/` pointer per D17) |
| `show <path>` | Decode one record + dump key fields + `provenance.*` verbatim (CLI equivalent of the GUI's `ProvenanceBanner`) |

## What the CLI does NOT do yet (phase θ — coming)

Action subcommands (`synth` / `measure` / `verify` / `analyze`) dispatch
to **Claude Code CLI** (D34 / D38 / `@D g_ai_agent_action_surface`). The
agent performs the actual engine work (Yosys / OpenROAD / hexa-matter /
…) and writes new records to `../exports/**`; the cockpit and CLI never
mutate `exports/` directly (`@D g_cockpit_isolation` invariant d holds).

## Boundary — `@D g_cockpit_isolation` (top-level AGENTS.tape)

Both `CockpitApp` and `DemiurgeCLI` are *logically outside* Demiurge's
governance boundary (rfc_009 §5). Four invariants enforce the boundary in
a monorepo:

- **(a)** read ONLY `../exports/**` — typed records (D2 interface),
  runtime-checked by `RecordLoader.load(url:)` returning
  `pathOutsideExports` for any URL outside `RecordLoader.exportsRoot`
- **(b)** NO import of `hexa-lang/stdlib/*` or Demiurge's hexa-native
  core; both targets import only `Foundation` / `SwiftUI` / `AppKit` /
  `UniformTypeIdentifiers` / `DemiurgeCore`
- **(c)** build artifacts live in `.gitignore` — never enter records
  SSOT (`.build/`, `.swiftpm/`, `DerivedData/`, `*.xcodeproj/xcuserdata/`)
- **(d)** edit-direction is one-way — cockpit reads `exports/`,
  `exports/` never reads cockpit; AI agent action (phase θ) preserves
  this by routing writes through producer engines, never directly

## Native / canonical first — `@D g_swift_native`

Per **D26**: SwiftUI / Foundation / AppKit native idioms + Apple
canonical patterns FIRST. Third-party libraries / custom DSLs /
non-canonical structures require explicit per-PR justification — they
are not default.

## References

- `references/quiver-overview.png` — Palantir Foundry Quiver "Overview
  Analysis" GUI capture (2026-05-19, user-provided), kept as design
  inspiration for the honesty-as-feature 4-zone tabbed UI.
- `references/screenshot-2026-05-19-0347.png` — first user-side render
  of D29 + Phase α (validation evidence, PLAN.md log).
- `references/bipv-module-exploded-isometric.jpg` — BIPV module
  construction diagram (aluminiummagazine.com), aesthetic target for
  the `ComponentMode` 3D viewer (D35 / phase ι / RealityKit).

## Cross-refs

- `../proposals/rfc_009_product_surface_macos_cockpit.md` — product surface spec
- `../proposals/rfc_010_cockpit_architecture.md` — 3-pane info-arch + phases α..ζ
- `../proposals/rfc_011_cockpit_control_surface.md` — control surface (chat + agent + 4-zone + modes + 3D)
- `../design.md` D22 / D27 / D28 / D29 / D30 / D31 / D32..D40 — decision audit trail
- `../AGENTS.tape` `@D g_cockpit_isolation` / `@D g_swift_native` / `@D g_ai_agent_action_surface` / `@D g_ai_agent_chat_surface`
