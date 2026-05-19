// SpaceVerifyRecord — space + verify (GMAT/Basilisk, ROI 15).
// SSOT: ~/core/hexa-lang/stdlib/space/gmat_basilisk.py. D72: orbital
// mechanics adapter; kernels/orbital/ (κ-45) candidate for GMAT
// trajectory primitives at 2nd consumer. g3: GATE_OPEN / absorbed=
// false; install-gated skip when Basilisk missing (GMAT separate binary).

import Foundation

public struct SpaceVerifyRecord: Codable, Equatable, Sendable {
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

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
    }
}
