// RtscVerifyRecord — rtsc + verify (GetDP HTS H-/A-phi, ROI 16).
// SSOT: ~/core/hexa-lang/stdlib/rtsc/getdp_hts.py. D72: pyfemm
// (rtsc+analyze) + GetDP = 2nd rtsc-EM consumer → em-kernel promotion
// candidate (note: inbox/notes/em-kernel-promotion-pickup.md). g3:
// GATE_OPEN / absorbed=false; install-gated skip when getdp missing.

import Foundation

public struct RtscVerifyRecord: Codable, Equatable, Sendable {
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
    public let kernelNote: String?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case kernelNote = "kernel_note"
    }
}
