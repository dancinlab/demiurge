// FalsifierCascade — G6 audit engine (ARCH.md §11.4).
//
// Each `FalsifierEntry` carries an optional `demotedIf: String?`
// pointing at an upstream falsifier id. When the upstream entry has
// `status = .demoted`, this engine cascades the DEMOTE downstream
// (e.g., hexa-aura README "if hexa-rtsc falls → F-AURA-2 DEMOTED").
//
// Monotonicity is preserved (D80 g_hexa_only spirit + hexa-aura /
// hexa-ufo invariants):
//   - OPEN → DEMOTED is allowed (cascade-induced or evidence-induced)
//   - OPEN → CONFIRMED is allowed (evidence-induced only)
//   - CONFIRMED → anything is FORBIDDEN
//   - DEMOTED → anything is FORBIDDEN
//
// The engine returns the closure (all entries with their cascade-
// updated status) plus a diagnostic list of cascade hops, so the
// cockpit dashboard can show "demoted because of …".

import Foundation

public struct FalsifierCascadeHop: Sendable, Equatable {
    public let target: String        // id that flipped
    public let cause: String         // upstream id that triggered
    public let reason: String        // human-readable

    public init(target: String, cause: String, reason: String) {
        self.target = target
        self.cause = cause
        self.reason = reason
    }
}

public struct FalsifierCascadeResult: Sendable, Equatable {
    /// All entries with cascade-induced DEMOTE applied.
    public let entries: [FalsifierEntry]
    /// One row per cascade-induced DEMOTE.
    public let hops: [FalsifierCascadeHop]

    public init(entries: [FalsifierEntry], hops: [FalsifierCascadeHop]) {
        self.entries = entries
        self.hops = hops
    }
}

public enum FalsifierCascade {

    /// Compute the cascade closure. BFS over `demotedIf` edges,
    /// monotone (only OPEN entries flip to DEMOTED; CONFIRMED /
    /// DEMOTED stay put).
    public static func apply(_ entries: [FalsifierEntry])
        -> FalsifierCascadeResult {
        var byID: [String: FalsifierEntry] = [:]
        for e in entries { byID[e.id] = e }

        var hops: [FalsifierCascadeHop] = []
        var changed = true
        var safety = 0
        while changed && safety < 1000 {
            changed = false
            safety += 1
            for e in byID.values {
                guard e.status == .open,
                      let upstream = e.demotedIf,
                      let up = byID[upstream] else { continue }
                if up.status == .demoted {
                    byID[e.id] = FalsifierEntry(
                        id: e.id,
                        status: .demoted,
                        openedAt: e.openedAt,
                        demotedIf: e.demotedIf,
                        evidenceRef: e.evidenceRef
                            ?? "cascade from \(upstream)",
                        summary: e.summary)
                    hops.append(FalsifierCascadeHop(
                        target: e.id,
                        cause: upstream,
                        reason: "upstream \(upstream) is DEMOTED → cascade"))
                    changed = true
                }
            }
        }

        // Preserve original input order in result.
        let result = entries.compactMap { byID[$0.id] }
        return FalsifierCascadeResult(entries: result, hops: hops)
    }
}
