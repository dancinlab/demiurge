// ChipSynthesizeRecord — chip + synthesize (D111 Phase C · chip cockpit half).
//
// SSOT: ~/core/hexa-lang/stdlib/chip/synthesize.py (PR #279 chip stdlib
// substrate). Yosys + ABC + SKY130 SC mapping pipeline → gate-level
// netlist + post-synth cell count + area estimate.
//
// Honest gates (g3):
//   • measurement_gate = GATE_OPEN ALWAYS — area estimate is liberty-
//     library lookup, NOT P&R-routed area.
//   • absorbed = false ALWAYS — rfc_006 §5 SKY130 area-oracle gate
//     requires OpenROAD P&R + Magic DRC + OpenSTA signoff (chip §D).
//   • scope_caveats: yosys phase-a synth-subset only · ABC heuristic ·
//     area_um2 = SKY130 hd cell-area sum (no routing congestion · no
//     IR-drop · no clock-tree synthesis).
//
// distinct from legacy ChipAnalyzeRecord (Leighton bounds) — that record
// is the booksim-oracle analytic cell, retained for κ-43 / D56 closure.

import Foundation

public struct ChipSynthesizeRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let skippedReason: String?

    // ---- chip + synthesize fields -----------------------------------
    /// Post-synthesis total cell count.
    public let synthCellCount: Int?
    /// True if SKY130 standard-cell mapping was applied (vs ABC default).
    public let sky130Mapping: Bool?
    /// Estimated area in µm² (cell-area sum, no routing).
    public let areaUm2: Double?
    /// True if SKY130 PDK was found at expected path.
    public let pdkAvailable: Bool?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case synthCellCount = "synth_cell_count"
        case sky130Mapping = "sky130_mapping"
        case areaUm2 = "area_um2"
        case pdkAvailable = "pdk_available"
    }
}
