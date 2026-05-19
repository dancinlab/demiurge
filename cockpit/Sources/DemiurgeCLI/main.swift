// DemiurgeCLI — phase α-3 + β minimum read-only scaffold
// (rfc_011 §10 / D34 / D38).
//
// Subcommands (v0, read-only):
//   demiurge --version | -v           Print version banner
//   demiurge --help    | -h           This help
//   demiurge list-all                 List artifacts of all kinds
//   demiurge list-records             List F1F2 records under ../exports/
//   demiurge list-decisions           List design.md decisions
//   demiurge list-rfcs                List ../proposals/rfc_*.md
//   demiurge list-domains             List ../domains/*.md
//   demiurge show <path>              Show one F1F2 record + provenance
//   demiurge list-projects            List workbench projects (manifests)
//   demiurge show-project <name>      Show one project + 7-verb progress
//   demiurge list-shelf <domain>      Show a domain's §6 shelf options
//
// Project subcommands read the SAME manifests the cockpit writes
// (~/Library/Application Support/lab.dancin.demiurge/projects/, D45)
// via the SAME DemiurgeCore functions — ProjectStore / DomainCatalog /
// Verb. cockpit and CLI never diverge (@D g_ssot_single_source).
//
// Action subcommands (rfc_011 §6, Phase θ — NOT here yet):
//   demiurge synth   <args>
//   demiurge measure <args>
//   demiurge verify  <args>
//   demiurge analyze <args>
//
// All `list-*` subcommands use `ArtifactRegistry` (DemiurgeCore) — the same
// abstraction that drives the GUI Artifacts tab. `show` uses `RecordLoader`
// with invariant-a runtime check (paths outside ../exports/** are
// rejected).

import Foundation
import DemiurgeCore

let version = "0.0.2 (phase α-3 + β, read-only — rfc_011 §10)"

func usage() {
    print("""
    demiurge — Demiurge cockpit CLI (read-only)

    USAGE:
      demiurge list-all                List artifacts of all kinds
      demiurge list-records            List F1F2 records under ../exports/
      demiurge list-decisions          List design.md decisions
      demiurge list-rfcs               List ../proposals/rfc_*.md
      demiurge list-domains            List ../domains/*.md
      demiurge show <path>             Show one F1F2 record + provenance
      demiurge list-projects           List workbench projects
      demiurge show-project <name>     Show one project + 7-verb progress
      demiurge list-shelf <domain>     Show a domain's §6 shelf options
      demiurge --version | -v          Print version
      demiurge --help    | -h          This help

    NOTES:
      - Records strictly read from ../exports/** (@D g_cockpit_isolation a).
      - Navigation docs read READ-ONLY per design.md D41 clarification.
      - Action subcommands (synth / measure / verify / analyze) land in
        Phase θ via Claude Code CLI dispatch (D34 / D38 /
        @D g_ai_agent_action_surface).
    """)
}

func printVersion() {
    print("demiurge \(version)")
}

func list(kind: ArtifactKind) -> Int32 {
    let stubs = ArtifactRegistry.load(kind: kind)
    print("\(kind.rawValue) (\(stubs.count)):")
    // pad to the longest id in this batch so columns align without
    // truncating the id (matters for $DOM:<name> which varies in length)
    let maxLen = stubs.map { $0.id.display.count }.max() ?? 0
    for s in stubs {
        let pad = String(repeating: " ", count: max(0, maxLen - s.id.display.count))
        print("  \(s.id.display)\(pad)  \(s.title)")
    }
    return 0
}

func listAll() -> Int32 {
    for k in ArtifactKind.allCases {
        _ = list(kind: k)
        print("")
    }
    return 0
}

func show(_ path: String) -> Int32 {
    let result = RecordLoader.load(relativePath: path)
    switch result {
    case .failure(let e):
        FileHandle.standardError.write(Data("show: \(e.errorDescription ?? "unknown error")\n".utf8))
        return 2
    case .success(let r):
        print("record_id:                  \(r.recordId)")
        print("interface:                  \(r.interface)")
        print("schema_version:             \(r.schemaVersion)")
        print("produced_at_utc:            \(r.producedAtUtc)")
        print("topology.kind:              \(r.topology.kind)")
        print("topology.degree:            \(r.topology.degree)")
        print("topology.node_count:        \(r.topology.nodeCount)")
        print("topology.routing:           \(r.topology.routing)")
        print("traffic:                    \(r.traffic)")
        print("verdict.f1:                 \(r.verdict.f1)")
        print("verdict.f2:                 \(r.verdict.f2)")
        print("verdict.rationale:          \(r.verdict.rationale)")
        print("provenance.measurement_gate:\(r.provenance.measurementGate.displayLabel)")
        print("provenance.absorbed:        \(r.provenance.absorbed)")
        print("provenance.sim_engine:      \(r.provenance.simEngine)")
        print("provenance.sim_commit:      \(String(r.provenance.simCommitHash.prefix(12)))")
        print("provenance.consumer_target: \(r.provenance.consumerTarget)")
        print("provenance.atlas_cite:      \(r.provenance.atlasCiteBlock)")
        print("provenance.gate_failures:   \(r.provenance.gateFailures.count)")
        for (i, gf) in r.provenance.gateFailures.enumerated() {
            print("  [\(i)] \(gf)")
        }
        print("provenance.scope_caveats:   \(r.provenance.scopeCaveats.count)")
        for (i, c) in r.provenance.scopeCaveats.enumerated() {
            print("  [\(i)] \(c)")
        }
        return 0
    }
}

/// List workbench projects — reads the same manifests the cockpit
/// writes (ProjectStore, D45) and the same domain/verb metadata
/// (DomainCatalog / Verb) the cockpit renders — @D g_ssot_single_source.
func listProjects() -> Int32 {
    let projects = ProjectStore.loadAll()
    print("projects (\(projects.count)):")
    for p in projects {
        let domain = DomainCatalog.domain(for: p.domain)
        let verb = p.currentVerb
        print("  \(p.name)  —  \(domain.label) · \(verb.rawValue + 1)/7 \(verb.canonical)")
    }
    return 0
}

/// Show one project's manifest + 7-verb progress.
func showProject(_ name: String) -> Int32 {
    let projects = ProjectStore.loadAll()
    guard let p = projects.first(where: { $0.name == name }) else {
        FileHandle.standardError.write(Data("show-project: no project named '\(name)'\n".utf8))
        return 2
    }
    let domain = DomainCatalog.domain(for: p.domain)
    print("name:        \(p.name)")
    print("target:      \(p.target)")
    print("domain:      \(p.domain) (\(domain.label))")
    print("canvas_mode: \(domain.canvasMode.rawValue)")
    print("created_at:  \(p.createdAt)")
    print("7-verb progress:")
    for verb in Verb.allCases {
        let mark: String
        switch p.state(of: verb) {
        case .done:     mark = "[x] done (measured)"
        case .current:  mark = "[>] current"
        case .visited:  mark = "[~] visited (unmeasured)"
        case .upcoming: mark = "[ ] upcoming"
        }
        print("  \(verb.rawValue + 1). \(verb.canonical) (\(verb.plain))  \(mark)")
    }
    return 0
}

/// Show a domain's ingredient-shelf options per verb — parsed from
/// the §6 section of domains/<domain>.md via the SAME IngredientShelf
/// the cockpit ② work zone uses (@D g_ssot_single_source).
func listShelf(_ domain: String) -> Int32 {
    print("ingredient shelf — domain '\(domain)' (\(DomainCatalog.domain(for: domain).label)):")
    var any = false
    for verb in Verb.allCases {
        let groups = IngredientShelf.groups(domain: domain, verb: verb)
        guard !groups.isEmpty else { continue }
        any = true
        print("  \(verb.rawValue + 1). \(verb.canonical):")
        for g in groups {
            print("       \(g.title) = \(g.options.joined(separator: " / "))")
        }
    }
    if !any {
        print("  (no §6 design-options section — domains/\(domain).md absent or mapless)")
    }
    return 0
}

let args = CommandLine.arguments

guard args.count >= 2 else {
    usage()
    exit(0)
}

let exitCode: Int32
switch args[1] {
case "--version", "-v":
    printVersion()
    exitCode = 0
case "--help", "-h":
    usage()
    exitCode = 0
case "list-all":
    exitCode = listAll()
case "list-records":
    exitCode = list(kind: .f1f2)
case "list-decisions":
    exitCode = list(kind: .decision)
case "list-rfcs":
    exitCode = list(kind: .rfc)
case "list-domains":
    exitCode = list(kind: .domain)
case "show":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("show: missing <path> argument\n".utf8))
        usage()
        exit(2)
    }
    exitCode = show(args[2])
case "list-projects":
    exitCode = listProjects()
case "show-project":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("show-project: missing <name> argument\n".utf8))
        usage()
        exit(2)
    }
    exitCode = showProject(args[2])
case "list-shelf":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("list-shelf: missing <domain> argument\n".utf8))
        usage()
        exit(2)
    }
    exitCode = listShelf(args[2])
default:
    FileHandle.standardError.write(Data("unknown subcommand: \(args[1])\n".utf8))
    usage()
    exit(2)
}

exit(exitCode)
