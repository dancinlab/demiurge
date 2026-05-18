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
default:
    FileHandle.standardError.write(Data("unknown subcommand: \(args[1])\n".utf8))
    usage()
    exit(2)
}

exit(exitCode)
