// ChipStructureRecord — chip + structure (D111 Phase C · chip cockpit half).
//
// SSOT: ~/core/hexa-lang/stdlib/chip/structure.py (PR #279 chip stdlib
// substrate). Module hierarchy + port graph + clock/reset tree extraction
// via yosys RTLIL → JSON (networkx module-DAG candidate).
//
// Honest gates (g3):
//   • measurement_gate = GATE_OPEN ALWAYS — RTLIL extraction is meta-
//     structure, not a measurement of behavior.
//   • absorbed = false ALWAYS — module topology is not an absorption claim.
//   • scope_caveats: yosys read_verilog scope = synth-subset (rfc_006 §5
//     blocker 3 of 3) · no `always @*` body interpretation · port roster
//     only.

import Foundation

public struct ChipStructureRecord: Codable, Equatable, Sendable {
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

    // ---- chip + structure fields (sscb structure mirror) -------------
    /// Module / cell count in the RTLIL graph.
    public let nodeCount: Int?
    /// Port / signal edge count in the graph.
    public let edgeCount: Int?
    /// Categories of cells (e.g. ["DFF", "comb", "io"]).
    public let categories: [String]?
    /// Placeholder fields not yet populated by the cell (transparency).
    public let placeholders: [String]?
    /// Path to the emitted RTLIL JSON dump (relative to output_dir).
    public let bomGraphFile: String?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case nodeCount = "node_count"
        case edgeCount = "edge_count"
        case categories
        case placeholders
        case bomGraphFile = "bom_graph_file"
    }
}
