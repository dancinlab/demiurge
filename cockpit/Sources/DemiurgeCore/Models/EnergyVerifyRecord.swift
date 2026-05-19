// EnergyVerifyRecord — energy + verify (OpenMC k-eff, ROI 12).
// SSOT: ~/core/hexa-lang/stdlib/energy/openmc_keff.py. D72: kernels/
// mc_transport/ reuse (3rd consumer — N+M payoff visible). g3:
// GATE_OPEN / absorbed=false; install-gated AND data-gated skip.

import Foundation

public struct EnergyVerifyRecord: Codable, Equatable, Sendable {
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
