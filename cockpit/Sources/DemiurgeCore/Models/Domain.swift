// Domain — single source of truth for per-domain metadata (D82 graph).
//
// SSOT rule (AGENTS.tape g_ssot_single_source): the domain key list,
// display labels, canvas-mode mapping, prerequisite edges, facet tags,
// and free-text inference keywords all live HERE — cockpit and CLI
// both consume DomainCatalog rather than each carrying its own
// `switch` over domain strings.
//
// D82 (graph DAG + multi-facet tag, Option 3): each Domain carries
//   - prerequisites: [DomainID]   (direct edges; transitive closure
//                                  is computed by DomainGraph)
//   - facets: DomainFacets        (multi-tag, NOT a partition)
//
// DemiurgeCore stays pure Foundation (Package.swift contract).

import Foundation

/// Which ② work-zone canvas mode a domain renders in (rfc_011 §7).
/// The mapping is data; the cockpit turns a mode into a SwiftUI view.
public enum CanvasMode: String, Sendable, Codable {
    case chip, component, matter, cohort
}

/// Where in the abstraction hierarchy a domain sits — Molecular (atom
/// / molecule), Device (chip-class device), Component (mechanical /
/// PCB / mechatronic assembly), System (multi-component infrastructure
/// or integration apex). Facet tag, NOT a partition (D82).
public enum DomainScale: String, Sendable, Codable {
    case molecular, device, component, system
}

/// A cluster a domain belongs to. **Multi-tag**: a domain may belong
/// to several clusters (e.g., a pharmaceutical drug is both `bio` and
/// `chem`). D82 explicitly rejects partition semantics.
public enum DomainCluster: String, Sendable, Codable {
    case matter, bio, chem, physical, propulsion, sensing
    case engineering, life, system
}

/// Platform hostility — where the domain's substrate is reliably
/// runnable. `macosClean` means the cockpit can dispatch without
/// pool routing; the others narrow what the cockpit can do locally.
public enum DomainHostility: String, Sendable, Codable {
    case macosClean = "macos-clean"
    case macosPartial = "macos-partial"
    case macosBlocked = "macos-blocked"
    case linuxPool = "linux-pool"
}

/// Multi-tag facet container. Filter / search axis for the cockpit
/// "New Project" wizard.
public struct DomainFacets: Sendable, Codable, Equatable {
    public let scale: DomainScale
    public let clusters: [DomainCluster]
    public let hostility: DomainHostility

    public init(scale: DomainScale,
                clusters: [DomainCluster],
                hostility: DomainHostility) {
        self.scale = scale
        self.clusters = clusters
        self.hostility = hostility
    }
}

/// One demiurge domain's metadata.
public struct Domain: Identifiable, Sendable {
    /// Domain key — "chip", "component", … (matches Project.domain).
    public let id: String
    /// Plain-language display label (rfc_012 §4).
    public let label: String
    /// Canvas mode for the ② work zone (rfc_011 §7).
    public let canvasMode: CanvasMode
    /// Free-text inference hints (rfc_012 §3 / D44).
    public let keywords: [String]

    /// D82 — direct prerequisite domains (graph DAG edges). Transitive
    /// closure is computed by `DomainGraph`, NOT stored here
    /// (`g_ssot_single_source`). Empty array = foundation node.
    public let prerequisites: [String]

    /// D82 — multi-tag facets (scale, clusters, hostility). Filter axis,
    /// not partition.
    public let facets: DomainFacets

    /// Optional sibling-repo SSOT pointer (D17 precedent). For domains
    /// whose substrate lives outside `hexa-lang/stdlib/<id>/` (e.g.,
    /// `~/core/hexa-matter/`, `~/core/hexa-ufo/`, `~/core/hexa-bio/`).
    public let substrateSSOT: String?

    public init(id: String, label: String, canvasMode: CanvasMode,
                keywords: [String],
                prerequisites: [String] = [],
                facets: DomainFacets,
                substrateSSOT: String? = nil) {
        self.id = id
        self.label = label
        self.canvasMode = canvasMode
        self.keywords = keywords
        self.prerequisites = prerequisites
        self.facets = facets
        self.substrateSSOT = substrateSSOT
    }
}

/// The domain catalog — the one place domain metadata is defined
/// (D82 graph DAG + multi-facet tag).
public enum DomainCatalog {
    /// 19 domains — runtime-loaded from `domains/INDEX.demi` (D83
    /// SSOT). D89 — `allHardcoded` polyfill removed (D86
    /// `g_no_hardcoded_data`). If INDEX.demi is missing or fails to
    /// parse the loader returns an empty array + stderr warning
    /// (D80 honesty path); callers must NOT rely on a Swift literal
    /// fallback.
    public static let all: [Domain] = {
        do { return try DomainLoader.loadAll() }
        catch {
            FileHandle.standardError.write(
                Data(("DomainCatalog: DomainLoader.loadAll() failed "
                      + "— \(error). Returning [] (D80 + D89). The "
                      + "previous `allHardcoded` Swift literal was "
                      + "removed per D86 `g_no_hardcoded_data`; "
                      + "INDEX.demi must be reachable.\n").utf8))
            return []
        }
    }()

    /// Domain for a key — a synthetic "general" cohort domain when the
    /// key is not in the catalog (so callers never crash on an unknown
    /// domain; the user can correct it via the §3 confirm step).
    public static func domain(for key: String) -> Domain {
        if let known = all.first(where: { $0.id == key }) {
            return known
        }
        return Domain(
            id: key,
            label: key == "general" ? "일반 공학" : key,
            canvasMode: .cohort,
            keywords: [],
            prerequisites: [],
            facets: DomainFacets(scale: .system,
                                 clusters: [.engineering],
                                 hostility: .macosClean))
    }

    /// Free-text → best-effort domain key (rfc_012 §3, D44 option C).
    /// "general" when nothing matches — the confirm step lets the user
    /// correct it, so the AI infers but never finalizes (g3).
    public static func infer(from target: String) -> String {
        let t = target.lowercased()
        for domain in all where domain.keywords.contains(where: { t.contains($0) }) {
            return domain.id
        }
        return "general"
    }
}
