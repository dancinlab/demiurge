// CernDesignRecord — cern + design (설계 DESIGN) STUB.
//
// Typed cockpit-consumer sidecar (R3) for the `cern + design` cell.
// SSOT substrate = ~/core/hexa-lang/stdlib/cern/design.py (NOT YET
// AUTHORED — cellrun.hexa honest-skips rc=2 until it lands). Dispatch is
// manifest-driven via domains/cern.demi [cell.design] →
// CellrunDispatch.run("cern", .design) — NO per-verb Swift producer
// class, NO ActionDispatch branch (@D d4 single generic dispatch; instance
// = manifest only).
//
// 설계 DESIGN = MAD-X / Xsuite lattice-deck handoff. domains/cern.md §2:
// MAD-X is the de-facto lattice/optics language; the design verb naturally
// emits the SEQUENCE deck (element definitions + drift/quad lengths +
// strengths) BEFORE the synthesize verb does the optics matching. Note the
// substrate is adjacent to cern+synthesize's xsuite_optics.py but the verb
// is different — design produces the deck template, synthesize matches it.
//
// HONEST (g3 — non-negotiable):
//   • producer = "stub — a real impl would emit a MAD-X SEQUENCE deck (or
//     Xsuite line) as a lattice-deck handoff artifact; no substrate
//     authored yet."
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS —
//     an un-matched lattice deck is never an absorption claim.

import Foundation

/// Optional headline for a cern + design record — the emitted deck's shape
/// (all nullable: a stub run leaves them nil).
public struct CernDesignHeadline: Codable, Equatable, Sendable {
    /// Deck backend — "mad-x" (SEQUENCE) or "xsuite" (line).
    public let deckBackend: String?
    /// Relative path of the emitted lattice deck artifact (nil for stub).
    public let deckPath: String?
    /// Number of lattice elements declared in the deck.
    public let elementCount: Int?

    enum CodingKeys: String, CodingKey {
        case deckBackend = "deck_backend"
        case deckPath = "deck_path"
        case elementCount = "element_count"
    }
}

public struct CernDesignRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    /// Acceleration-mechanism axis (CERN.md §1.5).
    public let accelMechanism: String?
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let skippedReason: String?
    public let headline: CernDesignHeadline?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case accelMechanism = "accel_mechanism"
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case headline
    }
}
