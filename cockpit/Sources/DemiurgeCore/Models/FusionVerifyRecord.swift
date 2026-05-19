// FusionVerifyRecord — fusion + verify (OpenMC TBR neutronics, ROI 11).
// SSOT: ~/core/hexa-lang/stdlib/fusion/openmc_tbr.py. D72: kernels/
// mc_transport/ reuse (2nd consumer after antimatter+analyze). g3:
// GATE_OPEN / absorbed=false; install-gated AND data-gated skip.

import Foundation

public struct FusionVerifyRecord: Codable, Equatable, Sendable {
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
