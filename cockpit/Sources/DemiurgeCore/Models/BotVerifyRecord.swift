// BotVerifyRecord — bot + verify (Drake Lyapunov/SOS, ROI 13).
// SSOT: ~/core/hexa-lang/stdlib/bot/drake_verify.py. D72: rigid-body
// verify; kernels/rbd/ promotion at 2nd consumer. g3: GATE_OPEN /
// absorbed=false; install-gated skip when pydrake missing.

import Foundation

public struct BotVerifyRecord: Codable, Equatable, Sendable {
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
