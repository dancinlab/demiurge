// DomainComposition — resolve a domain into its constituent domain
// stack (CLI+COCKPIT M15). 선행도메인 = 구성도메인: a domain is composed
// of its prerequisite domains, recursively (M0_operate.md §8).
//
// Two orthogonal axes of the demiurge domain model (D82):
//   • 가로 clusters    — a domain's discipline tags (bio/chem/tech…),
//                        multi-tag (a project can be tech AND bio).
//   • 세로 prerequisites — a domain is BUILT FROM sub-domains; the
//                        transitive closure is the full constituent set.
//
// This resolver feeds project creation + the 7-verb dispatch (M15-M17):
// running a verb on a composite domain means running it across the
// constituent stack (topo-ordered foundation→apex), each step
// cluster-aware. Pure derivation over DomainGraph — no new SSOT.

import Foundation

public struct DomainComposition: Sendable {
    /// How the start domain composes (M0_operate.md §8).
    public enum Kind: String, Sendable {
        case atomic     // no prerequisites — a foundation domain
        case composite  // built from sub-domains (closure > 1, not system)
        case meta       // integration apex — scale == system (ufo·fusion…)
    }

    public let start: String
    /// Constituent domains, topo-ordered (foundation first, apex last).
    public let stack: [Domain]
    /// Distinct clusters across the whole stack, first-seen order.
    public let clusterUnion: [DomainCluster]
    public let kind: Kind
    /// The START domain's own clusters span both a life-side and a
    /// tech-side discipline — the "기술+바이오 결합" case (e.g. aura).
    public let crossesDiscipline: Bool
    /// Distinct external substrate SSOT pointers in the stack (D17).
    public let substrateSSOTs: [String]

    public var ids: [String] { stack.map { $0.id } }
}

public enum DomainComposer {
    /// Discipline grouping for the cross-discipline (결합) test. LIFE =
    /// 생물·화학 계열; TECH = 공학·물리 계열. A domain "combines" when its
    /// OWN clusters touch both sides (not the transitive closure, so a
    /// pure-bio domain that merely sits on `matter` is not mislabeled).
    static let lifeClusters: Set<DomainCluster> = [.bio, .chem, .life]
    static let techClusters: Set<DomainCluster> = [
        .engineering, .physical, .propulsion, .sensing, .matter, .system,
    ]

    /// Resolve `start` into its constituent stack + facets. Unknown
    /// domains degrade to a single synthetic node (DomainCatalog rule).
    public static func resolve(_ start: String) -> DomainComposition {
        let closure = DomainGraph.transitiveClosure(of: start)
        let ordered = DomainGraph.topologicalSort(closure.map { $0.id })
        let idx = DomainGraph.index
        let stack = ordered.compactMap { idx[$0] }

        let startDomain = DomainCatalog.domain(for: start)
        let kind: DomainComposition.Kind =
            startDomain.facets.scale == .system ? .meta
            : (stack.count > 1 ? .composite : .atomic)

        let own = Set(startDomain.facets.clusters)
        let crosses = !own.isDisjoint(with: lifeClusters)
                   && !own.isDisjoint(with: techClusters)

        return DomainComposition(
            start: start,
            stack: stack,
            clusterUnion: orderedClusterUnion(stack),
            kind: kind,
            crossesDiscipline: crosses,
            substrateSSOTs: Array(Set(stack.compactMap { $0.substrateSSOT })).sorted())
    }

    /// First-seen union of clusters across the stack (stable order).
    private static func orderedClusterUnion(_ stack: [Domain]) -> [DomainCluster] {
        var seen: Set<DomainCluster> = []
        var out: [DomainCluster] = []
        for d in stack {
            for c in d.facets.clusters where !seen.contains(c) {
                seen.insert(c)
                out.append(c)
            }
        }
        return out
    }
}
