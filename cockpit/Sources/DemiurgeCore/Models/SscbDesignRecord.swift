// SscbDesignRecord — sscb + design (SSCB 7-verb walkthrough Step 3 ·
// 6th wired SSCB cell · D72 adapter-only · ngspice netlist + KiCad PCB
// stub template emit).
//
// SSOT: ~/core/hexa-lang/stdlib/sscb/design.py (template emit derived
// from `~/core/demiurge/domains/sscb.md` §2 DESIGN row (open-source col:
// KiCad + ngspice · FOSDEM'24 VDMOS power-MOSFET reference) +
// `sscb.demi` [cell.design] caveats. D116: hexa-lang stdlib is the
// producer SSOT.
//
// R3 compliance (constitution 1.4.1):
//   • Cockpit Swift = typed record + thin dispatch ONLY.
//   • Producer logic (ngspice netlist construction · KiCad PCB textual
//     stub · design dossier markdown · meta.json emit) lives in
//     hexa-lang substrate (Python adapter). The full netlist + KiCad
//     stub + dossier are emitted as sibling artifacts; downstream
//     consumers (analyze / verify cells via `ngspice -b`) consume the
//     .cir directly without re-running the design cell.
//
// g3 (honest, non-negotiable):
//   • absorbed = false PERMANENTLY for this cell. Datasheet bindings =
//     placeholder vendor part numbers (Wolfspeed C3M0021120K · IXYS
//     IXDD609SI · etc.) — actual .lib download requires vendor login
//     + per-vendor click-through license, NOT acquired here.
//   • measurement_gate = GATE_OPEN always — no path here flips it.
//     absorbed=true requires Wolfspeed-class .lib · IXYS gate driver
//     SPICE macro · bench-validated load · DEVSIM TCAD coupling ·
//     measured stray-inductance · OpenFOAM thermal · UL 489I type-test
//     (mirrors SSCBVerifyRecord g3 header).
//   • Snubber · busbar · cold plate values = rule-of-thumb · NOT
//     optimized · synthesis sweep + bench measurement = Tier-2 work.
//   • KiCad PCB stub is a textual sketch · NOT a loadable .kicad_pcb ·
//     full schematic + interactive routing cycle = downstream Tier-2.
//
// Mirrors the SscbStructureRecord top-level shape (domain · verb · kind
// · stamp · producer · measurement_gate · absorbed · scope_caveats ·
// citations · skipped_reason · gate_type · provisional · artifacts) PLUS
// the design scalar roll-up fields (netlist_file · kicad_stub_file ·
// dossier_file · netlist_node_count · netlist_element_count ·
// datasheet_bound_count · placeholder_remaining_count · simulation_ready
// · notes).

import Foundation

public struct SscbDesignRecord: Codable, Equatable, Sendable {
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
    /// (netlist + PCB stub are doc scaffolds, not kernels).
    public let gateType: String?
    public let provisional: Bool?

    // ---- SSCB design scalar fields (Codable mirror of producer) ---------
    /// Filename of the ngspice transient netlist
    /// (`sscb_design_v1.cir`). Downstream analyze / verify cells consume
    /// it via `ngspice -b` without re-running the design cell.
    public let netlistFile: String
    /// Filename of the KiCad PCB textual stub
    /// (`sscb_design_v1.netlist.kicad_pcb_stub`). NOT a loadable
    /// `.kicad_pcb` — full schematic + layout cycle = downstream Tier-2.
    public let kicadStubFile: String
    /// Filename of the human-readable design dossier markdown
    /// (`sscb_design_v1.dossier.md`).
    public let dossierFile: String
    /// Approximate count of unique non-zero numeric / named nodes
    /// referenced by SPICE elements in the emitted .cir.
    public let netlistNodeCount: Int
    /// Count of SPICE primitive elements (V/R/L/C/M/D/X lines) in the
    /// emitted .cir (excludes `.MODEL` cards + comments).
    public let netlistElementCount: Int
    /// Count of BOM-node → datasheet placeholder bindings emitted in the
    /// sibling meta.json `datasheet_bindings[]` array.
    public let datasheetBoundCount: Int
    /// Count of bindings still marked `placeholder=true` (at design verb
    /// this is typically EQUAL to `datasheetBoundCount` — all bindings
    /// are placeholders, none are absorbed .lib).
    public let placeholderRemainingCount: Int
    /// True iff the emitted .cir is well-formed for direct `ngspice -b`
    /// consumption (has `.title` · `.MODEL` · `.TRAN` · `.END`).
    public let simulationReady: Bool
    /// Free-form notes — scoping language for downstream verbs.
    public let notes: String?

    /// Artifact files (relative to `exports/sscb/design/<stamp>/`).
    public let artifacts: [String: String]?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case gateType = "gate_type"
        case provisional
        case netlistFile = "netlist_file"
        case kicadStubFile = "kicad_stub_file"
        case dossierFile = "dossier_file"
        case netlistNodeCount = "netlist_node_count"
        case netlistElementCount = "netlist_element_count"
        case datasheetBoundCount = "datasheet_bound_count"
        case placeholderRemainingCount = "placeholder_remaining_count"
        case simulationReady = "simulation_ready"
        case notes
        case artifacts
    }
}
