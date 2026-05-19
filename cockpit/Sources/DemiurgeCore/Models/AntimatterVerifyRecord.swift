// AntimatterVerifyRecord — antimatter + verify (Geant4 stopping, ROI 18).
// SSOT: ~/core/hexa-lang/stdlib/antimatter/geant4_verify.py. D72:
// kernels/mc_transport/ reuse (4th consumer — clearest N+M payoff).
// g3: GATE_OPEN / absorbed=false; install-gated skip (Geant4 multi-
// hour C++ build, shared `transport` producer planned per ABSORPTION
// synthesis point 3).

import Foundation

public struct AntimatterVerifyRecord: Codable, Equatable, Sendable {
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
    public let kernelReuse: String?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case kernelReuse = "kernel_reuse"
    }
}
