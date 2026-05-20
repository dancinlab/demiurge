// ProducerLoader — load `domains/PRODUCERS.demi` (D85, D86) into
// `ProducerRegistry`-shaped entries.
//
// `@D g_no_hardcoded_data` (D86) keeps ProducerRegistry sibling-repo
// variants in a declarative SSOT, not Swift literal. This loader:
//   1. Resolves the canonical path for PRODUCERS.demi (env / cwd /
//      ~/core/demiurge fallback — same pattern as DomainLoader).
//   2. Parses via DemiParser (D83).
//   3. Projects each section into a `(ProducerCellKey, ProducerEntry)`
//      tuple, calling `ProducerRegistry.siblingRepoVariant` for the
//      single variant.
//
// Only `kind = "sibling"` is supported today (single-variant case).
// Multi-variant sibling-cells and Swift-class variants in .demi (none
// queued — Swift function refs are the documented exception in D86)
// will follow when needed.

import Foundation

public enum ProducerLoader {

    /// Resolve canonical path for `domains/PRODUCERS.demi`. Mirrors
    /// `DomainLoader.indexPath()` priority.
    public static func producersPath() -> String? {
        let env = ProcessInfo.processInfo.environment
        if let repo = env["DEMIURGE_REPO"] {
            let p = "\(repo)/domains/PRODUCERS.demi"
            if FileManager.default.fileExists(atPath: p) { return p }
        }
        let cwd = FileManager.default.currentDirectoryPath
        let pwdPath = "\(cwd)/domains/PRODUCERS.demi"
        if FileManager.default.fileExists(atPath: pwdPath) { return pwdPath }
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let homePath = "\(home)/core/demiurge/domains/PRODUCERS.demi"
        if FileManager.default.fileExists(atPath: homePath) { return homePath }
        return nil
    }

    /// Load + parse + project. Empty list if the file is missing
    /// (`@D g_no_hardcoded_data` says SSOT-missing is a possible
    /// state — caller can merge with Swift-class hardcoded entries).
    public static func loadAll() -> [(ProducerCellKey, ProducerEntry)] {
        guard let path = producersPath() else { return [] }
        guard let src = try? String(contentsOfFile: path, encoding: .utf8)
            else { return [] }
        let sections = DemiParser.parse(src)
        return sections.compactMap { project($0) }
    }

    /// Project one DemiSection into a `(ProducerCellKey, ProducerEntry)`
    /// tuple. Tolerant — returns nil on malformed sections.
    public static func project(_ s: DemiSection)
        -> (ProducerCellKey, ProducerEntry)? {
        guard let verbStr = s.string("verb"),
              let verb = parseVerb(verbStr),
              let domain = s.string("domain"),
              let kind = s.string("kind"),
              let id = s.string("id") else {
            FileHandle.standardError.write(
                Data(("ProducerLoader: section '\(s.id)' missing one "
                      + "of verb/domain/kind/id — skipped (D86)\n").utf8))
            return nil
        }
        let display = s.string("display") ?? id
        guard kind == "sibling" else {
            FileHandle.standardError.write(
                Data(("ProducerLoader: section '\(s.id)' kind="
                      + "'\(kind)' not supported yet (only 'sibling') "
                      + "— skipped\n").utf8))
            return nil
        }
        let variant = ProducerRegistry.siblingRepoVariant(
            id: id, domainID: domain, verb: verbStr,
            displayName: display)
        let entry = ProducerEntry(defaultID: id, variants: [id: variant])
        return (ProducerCellKey(verb: verb, domain: domain), entry)
    }

    /// Verb id → typed Verb. Mirrors DemiurgeCLI's `parseVerbArg`.
    private static func parseVerb(_ s: String) -> Verb? {
        switch s.lowercased() {
        case "specify":    return .specify
        case "structure":  return .structure
        case "design":     return .design
        case "analyze":    return .analyze
        case "synthesize": return .synthesize
        case "verify":     return .verify
        case "handoff":    return .handoff
        default:           return nil
        }
    }
}
