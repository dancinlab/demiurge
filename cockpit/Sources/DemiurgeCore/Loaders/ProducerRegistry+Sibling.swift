// ProducerRegistry+Sibling — G4 (ARCH.md §11.4) — make sibling-repo
// dispatch a first-class ProducerRegistry variant.
//
// The D74 ProducerRegistry already wires `pylhe` and `xsuite-tracking`
// for `(cern, analyze)`. G4 generalises that pattern so any (verb,
// domain) cell whose substrate lives in a sibling repo
// (`~/core/hexa-<id>/`) can register a `sibling-<id>` variant via
// `siblingRepoVariant(domain:verb:displayName:)`. The variant calls
// `SiblingRepoSpawner.spawn` and projects the result into the generic
// `ActionResult` shape ActionDispatch understands.
//
// MatterAnalyzer remains the D17 historical precedent for its rich
// commit-pin / per-script gate decisioning; *future* sibling-cell
// producers go through this helper, exactly matching the G3 + G4
// design (`SiblingRepoSpawner` as canonical helper + ProducerRegistry
// surfaces it as a variant).

import Foundation

extension ProducerRegistry {

    /// Build a sibling-repo variant for a (verb, domain) cell. The
    /// returned variant spawns the sibling-repo entrypoint via
    /// `SiblingRepoSpawner.spawn(domain:verb:outDir:)` and assembles a
    /// generic `ActionResult` so ActionDispatch is unchanged.
    ///
    /// Use it in `ProducerRegistry.entries` like:
    /// ```
    /// ProducerCellKey(verb: .verify, domain: "ufo"): ProducerEntry(
    ///   defaultID: "hexa-ufo",
    ///   variants: [
    ///     "hexa-ufo": ProducerRegistry.siblingRepoVariant(
    ///                   id: "hexa-ufo",
    ///                   domainID: "ufo",
    ///                   verb: "verify",
    ///                   displayName: "hexa-ufo selftest")])
    /// ```
    public static func siblingRepoVariant(
        id: String,
        domainID: String,
        verb: String,
        displayName: String
    ) -> ProducerVariant {
        ProducerVariant(
            id: id,
            displayName: displayName
        ) {
            let stamp = ISO8601DateFormatter().string(from: Date())
                .replacingOccurrences(of: ":", with: "-")
            let outRoot = RecordLoader.exportsRoot
                .appendingPathComponent("\(domainID)/\(verb)",
                                        isDirectory: true)
            let outDir = outRoot.appendingPathComponent(stamp)
            try? FileManager.default.createDirectory(
                at: outDir, withIntermediateDirectories: true)
            let domain = DomainCatalog.domain(for: domainID)
            let r = SiblingRepoSpawner.spawn(
                domain: domain, verb: verb, outDir: outDir)
            let jsons = (try? FileManager.default.contentsOfDirectory(
                at: outDir, includingPropertiesForKeys: nil))?
                .filter { $0.pathExtension == "json" } ?? []
            let recordID = jsons.first?.lastPathComponent
                .replacingOccurrences(of: ".json", with: "")
            var lines: [String] = []
            if !r.stdout.isEmpty {
                lines.append(contentsOf:
                    r.stdout.split(separator: "\n").map(String.init))
            }
            lines.append("[\(domainID)+\(verb) · \(displayName)] "
                + "exit=\(r.exitCode), entrypoint=\(r.scriptPath)")
            if let ssot = r.resolvedFromSSOT {
                lines.append("  substrate SSOT: \(ssot)")
            }
            lines.append("GATE_OPEN / absorbed=false "
                         + "(g3 — sibling-repo dispatch; D80 hexa-"
                         + "native parity port still required for "
                         + "non-provisional absorbed)")
            return ActionResult(
                text: lines.joined(separator: "\n"),
                newRecordIDs: recordID.map { [$0] } ?? [],
                usedEngineTool: true,
                engineToolSucceeded: r.ok)
        }
    }
}
