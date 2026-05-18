// ArtifactRegistry — read project metadata to populate the LEFT Artifacts
// tab (phase β, rfc_011 §10) and the corresponding CLI `list-*` subcommands.
//
// Reads:
//   ../exports/chip/noc/f1f2/records/*.json   (F1F2 records — invariant a strict, RecordLoader-anchored)
//   ../design.md                              (Decisions — `### Decision N — <title>` parse)
//   ../proposals/rfc_*.md                     (RFCs — filename `rfc_<NNN>_*.md`)
//   ../domains/*.md                           (Domains — filename `<name>.md`, README excluded)
//
// Navigation-doc read scope is clarified by design.md D41 + AGENTS.tape
// `@D g_cockpit_isolation` rule: invariant (a) keeps records strictly under
// `../exports/**`, but the cockpit may additionally read project metadata
// documents (design.md / proposals / domains / README / CHARTER / HANDOFF /
// GOAL / PLAN / ARCH.tape / AGENTS.tape / inbox / archive /
// cockpit/references/) READ-ONLY for sidebar + inspector context. These
// reads NEVER inform a measurement_gate / absorbed / parity claim.

import Foundation

public enum ArtifactRegistry {

    // MARK: — public entry points

    public static func loadAll() -> [ArtifactStub] {
        loadF1F2() + loadDecisions() + loadRFCs() + loadDomains()
    }

    public static func load(kind: ArtifactKind) -> [ArtifactStub] {
        switch kind {
        case .f1f2:     return loadF1F2()
        case .decision: return loadDecisions()
        case .rfc:      return loadRFCs()
        case .domain:   return loadDomains()
        }
    }

    // MARK: — F1F2 records

    public static func loadF1F2() -> [ArtifactStub] {
        let root = RecordLoader.f1f2RecordsRoot
        let fm = FileManager.default
        guard let urls = try? fm.contentsOfDirectory(at: root, includingPropertiesForKeys: nil) else {
            return []
        }
        let jsons = urls
            .filter { $0.pathExtension == "json" }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
        var out: [ArtifactStub] = []
        out.reserveCapacity(jsons.count)
        for (i, u) in jsons.enumerated() {
            let stub = ArtifactStub(
                id:    ArtifactID(kind: .f1f2, key: String(i + 1)),
                title: u.deletingPathExtension().lastPathComponent,
                path:  u.path
            )
            out.append(stub)
        }
        return out
    }

    // MARK: — Decisions (parse design.md headings)

    public static func loadDecisions() -> [ArtifactStub] {
        let url = projectRoot.appendingPathComponent("design.md").standardizedFileURL
        guard let content = try? String(contentsOf: url, encoding: .utf8) else { return [] }
        guard let re = try? NSRegularExpression(
            pattern: #"^### Decision (\d+) — (.+)$"#,
            options: [.anchorsMatchLines]
        ) else { return [] }
        let ns = content as NSString
        let range = NSRange(location: 0, length: ns.length)
        var seen = Set<String>()
        var out: [ArtifactStub] = []
        re.enumerateMatches(in: content, range: range) { match, _, _ in
            guard let m = match, m.numberOfRanges >= 3 else { return }
            let n     = ns.substring(with: m.range(at: 1))
            let title = ns.substring(with: m.range(at: 2))
            // dedupe (older revisions may repeat decision numbers — keep first)
            guard seen.insert(n).inserted else { return }
            out.append(ArtifactStub(
                id:    ArtifactID(kind: .decision, key: n),
                title: "D\(n) — \(title)",
                path:  url.path
            ))
        }
        // sort numerically by D-number
        out.sort { (a, b) in
            (Int(a.id.key) ?? 0) < (Int(b.id.key) ?? 0)
        }
        return out
    }

    // MARK: — RFCs (../proposals/rfc_*.md)

    public static func loadRFCs() -> [ArtifactStub] {
        let dir = projectRoot.appendingPathComponent("proposals").standardizedFileURL
        let fm = FileManager.default
        guard let urls = try? fm.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else {
            return []
        }
        let mds = urls
            .filter { $0.lastPathComponent.hasPrefix("rfc_") && $0.pathExtension == "md" }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
        var out: [ArtifactStub] = []
        for u in mds {
            let stem = u.deletingPathExtension().lastPathComponent
            // expect rfc_<NNN>_<slug>
            let parts = stem.split(separator: "_", maxSplits: 2, omittingEmptySubsequences: false)
            guard parts.count >= 2 else { continue }
            let n = String(parts[1])
            out.append(ArtifactStub(
                id:    ArtifactID(kind: .rfc, key: n),
                title: stem,
                path:  u.path
            ))
        }
        return out
    }

    // MARK: — Domains (../domains/*.md, excluding README)

    public static func loadDomains() -> [ArtifactStub] {
        let dir = projectRoot.appendingPathComponent("domains").standardizedFileURL
        let fm = FileManager.default
        guard let urls = try? fm.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else {
            return []
        }
        let mds = urls
            .filter { $0.pathExtension == "md" && $0.lastPathComponent != "README.md" }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
        var out: [ArtifactStub] = []
        for u in mds {
            let name = u.deletingPathExtension().lastPathComponent
            out.append(ArtifactStub(
                id:    ArtifactID(kind: .domain, key: name),
                title: name,
                path:  u.path
            ))
        }
        // include domains/matter/README.md as the matter pointer (D17)
        let matter = dir.appendingPathComponent("matter/README.md").standardizedFileURL
        if fm.fileExists(atPath: matter.path) {
            out.append(ArtifactStub(
                id:    ArtifactID(kind: .domain, key: "matter"),
                title: "matter (pointer — D17 hexa-lang absorbed)",
                path:  matter.path
            ))
        }
        return out.sorted { $0.id.key < $1.id.key }
    }

    // MARK: — helpers

    /// The project root, derived as the parent of `RecordLoader.exportsRoot`.
    /// (`exportsRoot` is `cockpit/../exports`, so `projectRoot` is `cockpit/..`.)
    public static let projectRoot: URL =
        RecordLoader.exportsRoot.deletingLastPathComponent().standardizedFileURL
}
