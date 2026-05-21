// ChipDesignRecord — chip + design (D111 Phase C · chip cockpit half).
//
// SSOT: ~/core/hexa-lang/stdlib/chip/design.py (PR #279 chip stdlib
// substrate). Area/freq/power design-space exploration scaffold — yosys
// pre-synth pass + ABC heuristic + datasheet-binding template emit.
//
// Honest gates (g3):
//   • measurement_gate = GATE_OPEN ALWAYS — design-space sweep is meta,
//     not a tapeout PPA verdict.
//   • absorbed = false ALWAYS — OpenROAD P&R + signoff missing (chip §D
//     honest-gap roster).
//   • scope_caveats: PPA tradeoff = back-of-envelope · datasheet bindings
//     = stub (no real vendor part) · simulation_ready=false until
//     synthesize cell runs.

import Foundation

public struct ChipDesignRecord: Codable, Equatable, Sendable {
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

    // ---- chip + design fields ---------------------------------------
    /// Netlist file path (relative to output_dir).
    public let netlistFile: String?
    /// KiCad stub schematic file path (placeholder · chip §D handoff).
    public let kicadStubFile: String?
    /// Design dossier markdown path.
    public let dossierFile: String?
    /// Module / cell count from pre-synth yosys pass.
    public let nodeCount: Int?
    /// Element / port count.
    public let elementCount: Int?
    /// Datasheet binding identifiers (e.g. ["sky130_fd_sc_hd__inv_2"]).
    public let datasheetBindings: [String]?
    /// True if downstream synthesize cell can consume this dossier.
    public let simulationReady: Bool?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case netlistFile = "netlist_file"
        case kicadStubFile = "kicad_stub_file"
        case dossierFile = "dossier_file"
        case nodeCount = "node_count"
        case elementCount = "element_count"
        case datasheetBindings = "datasheet_bindings"
        case simulationReady = "simulation_ready"
    }
}
