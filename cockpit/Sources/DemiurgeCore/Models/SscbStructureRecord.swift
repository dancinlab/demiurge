// SscbStructureRecord — sscb + structure (SSCB 7-verb walkthrough Step 2 ·
// 5th wired SSCB cell · D72 adapter-only · BOM tree template emit).
//
// SSOT: ~/core/hexa-lang/stdlib/sscb/structure.py (template emit transcribing
// `~/core/demiurge/domains/sscb.md` §2 ARCHITECT row + sscb.demi caveats
// into a networkx DiGraph BOM tree). D116: hexa-lang stdlib is the
// producer SSOT.
//
// R3 compliance (constitution 1.4.1):
//   • Cockpit Swift = typed record + thin dispatch ONLY.
//   • Producer logic (networkx graph build · meta.json emit · dossier
//     write) lives in hexa-lang substrate (Python adapter). The full
//     BOM graph is emitted as a sibling artifact `sscb_v1.bom_graph.json`
//     pointed at by `bomGraphFile`; downstream consumers (design verb)
//     can deserialize it without re-running the structure cell.
//
// g3 (honest, non-negotiable):
//   • absorbed = false PERMANENTLY for this cell. BOM is spec-level
//     placeholder — every node `placeholder=true` in the producer.
//     Datasheet binding (Wolfspeed C3M0021120K · IXYS / STGAP1AS gate
//     driver · etc.) = design verb territory, NOT structure.
//   • measurement_gate = GATE_OPEN always — no path here flips it.
//   • networkx graph is STRUCTURAL ONLY — no thermal/EM coupling. That
//     belongs analyze (OpenFOAM CHT) / synthesize (FEMMT) cells.
//
// Mirrors the SscbSpecifyRecord top-level shape (domain · verb · kind ·
// stamp · producer · measurement_gate · absorbed · scope_caveats ·
// citations · skipped_reason · gate_type · provisional · artifacts) PLUS
// the structure scalar roll-up fields (bom_node_count · bom_edge_count
// · categories · placeholders · notes · bom_graph_file).

import Foundation

public struct SscbStructureRecord: Codable, Equatable, Sendable {
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
    /// G7 typed gate_type — `"hexa-native-absent"` for template emit
    /// (BOM is a doc scaffold, not a kernel).
    public let gateType: String?
    public let provisional: Bool?

    // ---- SSCB structure scalar fields (Codable mirror of producer) ------
    /// BOM node count (DiGraph nodes).
    public let bomNodeCount: Int
    /// BOM edge count (DiGraph edges — directed).
    public let bomEdgeCount: Int
    /// Sorted list of node categories present in the BOM (e.g.
    /// `["commutation", "control", "mechanical", "power_path", "thermal"]`).
    public let categories: [String]
    /// Node IDs flagged `placeholder=true` (spec-level, no datasheet
    /// bind-out). At the structure verb this is typically EVERY node.
    public let placeholders: [String]
    /// Free-form notes — scoping language for downstream verbs.
    public let notes: String?

    /// Artifact files (relative to `exports/sscb/structure/<stamp>/`).
    public let artifacts: [String: String]?

    /// Sibling filename pointing at the full DiGraph dump
    /// (`sscb_v1.bom_graph.json`). Downstream consumers (design verb)
    /// can deserialize it without re-running the structure cell. nil if
    /// the producer fell back to a record-only emit.
    public let bomGraphFile: String?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case gateType = "gate_type"
        case provisional
        case bomNodeCount = "bom_node_count"
        case bomEdgeCount = "bom_edge_count"
        case categories
        case placeholders
        case notes
        case artifacts
        case bomGraphFile = "bom_graph_file"
    }
}
