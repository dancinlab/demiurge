// SscbSpecifyRecord — sscb + specify (SSCB 7-verb walkthrough Step 1 ·
// 4th wired SSCB cell · D72 adapter-only · firmware-stub template
// pattern).
//
// SSOT: ~/core/hexa-lang/stdlib/sscb/specify.py (template emit transcribing
// `~/core/demiurge/domains/sscb.md` §1 "Design blueprint deliverable" —
// the HEXA-SSCB mk1 spec). D116: hexa-lang stdlib is the producer SSOT.
//
// g3 (honest, non-negotiable):
//   • absorbed = false PERMANENTLY. A spec without measurement is
//     illustrative, NOT an absorption claim. The HEXA-SSCB mk1 ≤ 600 ns
//     target is ASPIRATION, NOT bench-verified.
//   • measurement_gate = GATE_OPEN always — no path here flips it.
//     absorbed=true requires Wolfspeed-class .lib · bench-validated load
//     · DEVSIM TCAD coupling · measured stray-inductance · OpenFOAM
//     thermal · UL 489I type-test (mirrors SSCBVerifyRecord g3 header).
//   • current rating / die selection / UL 489I lab booking = downstream
//     verb territory (structure / design / verify) — this cell does NOT
//     bind to a part number or a fault current.
//
// Mirrors the firmware/specify.py top-level record shape (domain · verb ·
// kind · stamp · producer · measurement_gate · absorbed · scope_caveats
// · citations · skipped_reason · gate_type · provisional · artifacts)
// PLUS the SSCB spec fields transcribed from sscb.md §1 (target · voltage
// · current · standards · semiconductor_family · topology · protections
// · thermal_management · cert_dossier_required · notes).

import Foundation

public struct SscbSpecifyRecord: Codable, Equatable, Sendable {
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
    /// (no kernel exists, and never will — spec is a doc template).
    public let gateType: String?
    public let provisional: Bool?

    // ---- SSCB spec fields (transcribed from sscb.md §1) -----------------
    /// HEXA-SSCB mk1 headline target — e.g. "≤ 1 µs DC fault interruption
    /// (600 ns target)".
    public let target: String
    /// Voltage envelope — e.g. "1500 Vdc max (IEC 60947-2 SSHCB)".
    public let voltage: String
    /// Current rating — generally "TBD per family" at the specify stage.
    public let current: String
    /// Standards bundle — UL 489I 1st ed. 2025, IEC 60947-2, IEEE C37.x.
    public let standards: [String]
    /// Power-semi family — "SiC | GaN with paralleling".
    public let semiconductorFamily: String
    /// Topology — "pure-SS vs hybrid SSHCB" (architect shelf option).
    public let topology: String
    /// Protection mechanisms — snubber · magnetic limiter · galvanic
    /// disconnect.
    public let protections: [String]
    /// Thermal management plan — typically "active cooling — liquid cold
    /// plate option (OpenFOAM analyze cell)".
    public let thermalManagement: String
    /// UL 489I accredited-lab type-test required? (always true for SSCB).
    public let certDossierRequired: Bool
    /// Free-form notes — scoping language for downstream verbs.
    public let notes: String

    /// Artifact files (relative to `exports/sscb/specify/<stamp>/`).
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
        case target, voltage, current, standards
        case semiconductorFamily = "semiconductor_family"
        case topology, protections
        case thermalManagement = "thermal_management"
        case certDossierRequired = "cert_dossier_required"
        case notes
        case artifacts
    }
}
