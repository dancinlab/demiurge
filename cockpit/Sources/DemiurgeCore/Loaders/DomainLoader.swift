// DomainLoader — load 19+ domains from `domains/INDEX.demi` (D83).
//
// Resolves the `.demi` SSOT path (env DEMIURGE_REPO → cwd → bundle
// fallback), parses via `DemiParser`, projects each `DemiSection` into
// a typed `Domain`. If the load fails for any reason, the caller can
// fall back to `DomainCatalog.allHardcoded` (phase A polyfill).
//
// D50 g_ssot_single_source — INDEX.demi is THE SSOT; the Swift
// hardcoded `DomainCatalog.all` array (post-D83) becomes a dev-only
// polyfill kept in sync with INDEX.demi.

import Foundation

public enum DomainLoaderError: Error, CustomStringConvertible {
    case fileNotFound(String)
    case parseFailed(String)

    public var description: String {
        switch self {
        case .fileNotFound(let p): return "INDEX.demi not found at \(p)"
        case .parseFailed(let m):  return "INDEX.demi parse failed: \(m)"
        }
    }
}

public enum DomainLoader {

    /// Resolve the canonical path for `domains/INDEX.demi`. Priority:
    /// 1. `$DEMIURGE_REPO/domains/INDEX.demi`
    /// 2. `$PWD/domains/INDEX.demi`
    /// 3. `~/core/demiurge/domains/INDEX.demi` (last resort)
    public static func indexPath() -> String? {
        let env = ProcessInfo.processInfo.environment
        if let repo = env["DEMIURGE_REPO"] {
            let p = "\(repo)/domains/INDEX.demi"
            if FileManager.default.fileExists(atPath: p) { return p }
        }
        let cwd = FileManager.default.currentDirectoryPath
        let pwdPath = "\(cwd)/domains/INDEX.demi"
        if FileManager.default.fileExists(atPath: pwdPath) { return pwdPath }
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let homePath = "\(home)/core/demiurge/domains/INDEX.demi"
        if FileManager.default.fileExists(atPath: homePath) { return homePath }
        return nil
    }

    /// D84 — per-machine user-custom domains live here. Every `.demi`
    /// file inside this directory is parsed; each id must carry the
    /// `u/` prefix (otherwise warn + skip, no silent built-in override).
    public static func userDomainsPath() -> String {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        return "\(home)/.config/demiurge/user-domains"
    }

    /// Scan `userDomainsPath()` for `*.demi` files, parse each, project
    /// into Domain, and gather. Missing dir = empty list (not an error
    /// — user just hasn't added any custom domain yet).
    public static func loadUserDomains() -> [Domain] {
        let dir = userDomainsPath()
        let fm = FileManager.default
        guard let entries = try? fm.contentsOfDirectory(atPath: dir) else {
            return []
        }
        var result: [Domain] = []
        for entry in entries where entry.hasSuffix(".demi") {
            let path = "\(dir)/\(entry)"
            guard let src = try? String(contentsOfFile: path,
                                        encoding: .utf8) else { continue }
            let sections = DemiParser.parse(src)
            for s in sections {
                // D84 — user domain ids MUST carry `u/` prefix.
                guard s.id.hasPrefix("u/") else {
                    FileHandle.standardError.write(
                        Data(("DomainLoader: user domain "
                              + "'\(s.id)' in \(entry) missing 'u/' "
                              + "prefix — skipped (D84)\n").utf8))
                    continue
                }
                if let d = project(s) { result.append(d) }
            }
        }
        return result
    }

    /// Load + parse + project into a `[Domain]` array, or throw.
    /// D84 — also loads user-custom domains and merges (user entries
    /// appended after built-in; `u/` prefix prevents id collision).
    public static func loadAll() throws -> [Domain] {
        guard let path = indexPath() else {
            throw DomainLoaderError.fileNotFound(
                "$DEMIURGE_REPO/domains/INDEX.demi or fallback paths")
        }
        let src: String
        do { src = try String(contentsOfFile: path, encoding: .utf8) }
        catch { throw DomainLoaderError.parseFailed(
            "read \(path): \(error.localizedDescription)") }

        let sections = DemiParser.parse(src)
        let builtIn: [Domain] = sections.compactMap { s in
            // D84 — built-in domains MUST NOT carry `u/` prefix.
            if s.id.hasPrefix("u/") {
                FileHandle.standardError.write(
                    Data(("DomainLoader: built-in INDEX.demi has "
                          + "id '\(s.id)' with reserved 'u/' "
                          + "prefix — skipped (D84)\n").utf8))
                return nil
            }
            return project(s)
        }
        if builtIn.isEmpty {
            throw DomainLoaderError.parseFailed(
                "no built-in domains parsed from \(path) "
                + "(\(sections.count) sections)")
        }
        let user = loadUserDomains()
        return builtIn + user
    }

    /// Project one `DemiSection` into a `Domain`. Tolerant — returns
    /// `nil` if a required field is missing or unknown.
    public static func project(_ s: DemiSection) -> Domain? {
        guard let label = s.string("label") else { return nil }
        let canvasRaw = s.string("canvas_mode") ?? "cohort"
        guard let canvas = CanvasMode(rawValue: canvasRaw) else { return nil }
        let scaleRaw = s.nestedString("facets", "scale") ?? "system"
        guard let scale = DomainScale(rawValue: scaleRaw) else { return nil }
        let hostilityRaw = s.nestedString("facets", "hostility")
            ?? "macos-clean"
        guard let hostility = DomainHostility(rawValue: hostilityRaw)
            else { return nil }
        let clusters = s.nestedList("facets", "cluster")
            .compactMap { DomainCluster(rawValue: $0) }
        let prerequisites = s.list("prerequisites")
        let keywords = s.list("keywords")
        let substrateSSOT = s.string("substrate_ssot")

        return Domain(
            id: s.id,
            label: label,
            canvasMode: canvas,
            keywords: keywords,
            prerequisites: prerequisites,
            facets: DomainFacets(
                scale: scale,
                clusters: clusters,
                hostility: hostility),
            substrateSSOT: substrateSSOT)
    }

    /// Load + fall back to hardcoded list on any failure.
    /// `DomainCatalog.all` uses this so callers never crash.
    public static func loadAllOrFallback(_ fallback: [Domain]) -> [Domain] {
        if let loaded = try? loadAll(), !loaded.isEmpty {
            return loaded
        }
        return fallback
    }
}
