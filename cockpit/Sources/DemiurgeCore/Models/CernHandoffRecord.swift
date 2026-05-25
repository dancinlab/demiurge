// CernHandoffRecord — cern + handoff (인계 HANDOFF) STUB.
//
// Typed cockpit-consumer sidecar (R3) for the `cern + handoff` cell.
// SSOT substrate = ~/core/hexa-lang/stdlib/cern/handoff.py (NOT YET
// AUTHORED — cellrun.hexa honest-skips rc=2 until it lands). Dispatch is
// manifest-driven via domains/cern.demi [cell.handoff] →
// CellrunDispatch.run("cern", .handoff) — NO per-verb Swift producer
// class, NO ActionDispatch branch (@D d4 single generic dispatch; instance
// = manifest only).
//
// 인계 HANDOFF = Technical Design Report (TDR) → construction deliverable
// schema. domains/cern.md §1 deliverable. Natural shape (firmware/
// handoff.py CycloneDX bundle pattern reuse): a tarball manifest of MAD-X
// deck + Geant4 shielding dossier + DA scan + RF spec + radiation budget.
//
// HONEST (g3 — non-negotiable):
//   • producer = "stub — a real impl would bundle a TDR → construction
//     deliverable (deck + shielding dossier + DA scan + RF spec +
//     radiation budget manifest); no substrate authored yet."
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS —
//     a TDR bundle skeleton is never an absorption claim.

import Foundation

/// One slot of the TDR → construction deliverable bundle — name + whether
/// the upstream verb has populated it yet (all false for a stub).
public struct CernHandoffDeliverable: Codable, Equatable, Sendable {
    /// Deliverable slot name (e.g. "mad-x_deck", "shielding_dossier").
    public let slot: String
    /// Did an upstream verb already fill this slot? (false for stub).
    public let present: Bool

    public init(slot: String, present: Bool) {
        self.slot = slot
        self.present = present
    }
}

/// Optional headline for a cern + handoff record — the bundle manifest
/// (all nullable / empty for a stub run).
public struct CernHandoffHeadline: Codable, Equatable, Sendable {
    /// TDR deliverable schema slots and their fill state.
    public let deliverables: [CernHandoffDeliverable]?
    /// Relative path of the emitted bundle tarball (nil for stub).
    public let bundlePath: String?

    enum CodingKeys: String, CodingKey {
        case deliverables
        case bundlePath = "bundle_path"
    }
}

public struct CernHandoffRecord: Codable, Equatable, Sendable {
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
    public let headline: CernHandoffHeadline?

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
