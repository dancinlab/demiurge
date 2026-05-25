// CernStructureRecord — cern + structure (구조 ARCHITECT) STUB.
//
// Typed cockpit-consumer sidecar (R3) for the `cern + structure` cell.
// SSOT substrate = ~/core/hexa-lang/stdlib/cern/structure.py (NOT YET
// AUTHORED — cellrun.hexa honest-skips rc=2 until it lands). Dispatch is
// manifest-driven via domains/cern.demi [cell.structure] →
// CellrunDispatch.run("cern", .structure) — NO per-verb Swift producer
// class, NO ActionDispatch branch (@D d4 single generic dispatch; instance
// = manifest only).
//
// 구조 ARCHITECT = ring / lattice topology. domains/cern.md §6 design
// shelf: 격자 = FODO / TME / DBA. A real impl would emit the cell-pattern
// choice + cell count + ring circumference as a lattice-topology record
// (networkx component-graph reuse, GridStructureProducer pattern, lattice
// elements as nodes).
//
// HONEST (g3 — non-negotiable):
//   • producer = "stub — a real impl would build a ring/lattice topology
//     (FODO chain · TME / DBA cell counter) and emit element-graph
//     metrics; no substrate authored yet."
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS —
//     a topology skeleton is never an absorption claim.

import Foundation

/// Optional headline for a cern + structure record — the lattice-topology
/// choice + counts (all nullable: a stub run leaves them nil).
public struct CernStructureHeadline: Codable, Equatable, Sendable {
    /// Lattice cell pattern — one of "FODO" / "TME" / "DBA" (domains/
    /// cern.md §6 design shelf).
    public let latticeType: String?
    /// Number of repeating cells around the ring.
    public let cellCount: Int?
    /// Ring circumference [m] (nil for a linac).
    public let circumferenceM: Double?

    enum CodingKeys: String, CodingKey {
        case latticeType = "lattice_type"
        case cellCount = "cell_count"
        case circumferenceM = "circumference_m"
    }
}

public struct CernStructureRecord: Codable, Equatable, Sendable {
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
    public let headline: CernStructureHeadline?

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
