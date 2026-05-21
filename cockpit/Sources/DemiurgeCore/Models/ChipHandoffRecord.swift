// ChipHandoffRecord — chip + handoff (D111 Phase C · chip cockpit half).
//
// SSOT: ~/core/hexa-lang/stdlib/chip/handoff.py (PR #279 chip stdlib
// substrate). Tapeout checklist (GDSII export · DRC · LVS · STA timing-
// met · IR-drop) + cell-library citation + bundle artifacts.
//
// Honest gates (g3):
//   • measurement_gate = GATE_OPEN ALWAYS — handoff dossier is scaffolding,
//     not a fab signoff.
//   • absorbed = false ALWAYS — fab acceptance (SkyWater MPW Shuttle /
//     Efabless OpenMPW) is OFF this map — that is the actual tapeout gate.
//   • scope_caveats: 6 simultaneous gates required for absorbed=true
//     (tapeout-clean GDSII + DRC + LVS + STA + IR-drop + IO ring + power-
//     grid · chip §D); this handoff cell emits the dossier shape but
//     NEVER flips any of them on its own.

import Foundation

public struct ChipHandoffRecord: Codable, Equatable, Sendable {
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

    // ---- chip + handoff fields --------------------------------------
    /// True if specify record's target/spec fields are present + checked.
    public let specCompliance: Bool?
    /// Path to the verification report (relative to output_dir).
    public let verificationReport: String?
    /// Path to GDSII handoff file (placeholder · OpenROAD pending).
    public let gdsHandoff: String?
    /// Cell-library citation (e.g. "sky130_fd_sc_hd v0.0.4").
    public let cellLibCitation: String?
    /// Count of artifacts bundled into the handoff tarball.
    public let bundleArtifactCount: Int?
    /// Count of certification blockers (DRC/LVS/STA failures · open gates).
    public let certBlockingCount: Int?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case specCompliance = "spec_compliance"
        case verificationReport = "verification_report"
        case gdsHandoff = "gds_handoff"
        case cellLibCitation = "cell_lib_citation"
        case bundleArtifactCount = "bundle_artifact_count"
        case certBlockingCount = "cert_blocking_count"
    }
}
