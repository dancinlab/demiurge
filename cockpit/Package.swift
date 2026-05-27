// swift-tools-version: 6.2
// Demiurge CLI — headless control surface (AI-agent surface, D34/D38).
// The macOS SwiftUI GUI (CockpitApp) was scrapped; the user surface is
// now the web GUI (Next.js · Cloud Run). Swift here is CLI + lib only.
//
// Two targets:
//   DemiurgeCore  — library, the shared typed-interface consumer of
//                   ../exports/** (F1F2Record + RecordLoader). Pure
//                   Foundation; no SwiftUI / AppKit imports.
//   DemiurgeCLI   — Foundation-only headless executable; depends on
//                   DemiurgeCore. The AI-agent + web-bridge surface.
//
// Logical-boundary invariants — AGENTS.tape @D g_cockpit_isolation:
//   (a) read ONLY ../exports/** (typed records, D2 interface)
//   (b) MUST NOT import hexa-lang/stdlib/* nor demiurge hexa-native core
//   (c) build artifacts in .gitignore
//   (d) edit-direction is one-way: cockpit reads exports, never reverse
//
// Build:
//   cd cockpit && swift build
// Run:
//   swift run DemiurgeCLI --version       # CLI version
//   swift run DemiurgeCLI list-records    # CLI: list F1F2 records
//   swift run DemiurgeCLI show <path>     # CLI: dump one record

import PackageDescription

let package = Package(
    name: "Demiurge",
    platforms: [
        .macOS(.v26)
    ],
    products: [
        .library(
            name: "DemiurgeCore",
            targets: ["DemiurgeCore"]
        ),
        .executable(
            name: "DemiurgeCLI",
            targets: ["DemiurgeCLI"]
        )
    ],
    targets: [
        .target(
            name: "DemiurgeCore",
            path: "Sources/DemiurgeCore"
        ),
        .executableTarget(
            name: "DemiurgeCLI",
            dependencies: ["DemiurgeCore"],
            path: "Sources/DemiurgeCLI"
        ),
        .testTarget(
            name: "DemiurgeCoreTests",
            dependencies: ["DemiurgeCore"],
            path: "Tests/DemiurgeCoreTests"
        )
    ]
)
