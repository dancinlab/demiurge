// MobilityVerifyRecord — mobility + verify (CARLA/ScenarioRunner, ROI 17).
// SSOT: ~/core/hexa-lang/stdlib/mobility/carla_scenario.py. D72: AD
// simulation single-domain adapter. g3: GATE_OPEN / absorbed=false;
// macOS HARD-BLOCK (no maintained CARLA macOS build) — Linux pool only.

import Foundation

public struct MobilityVerifyRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let platform: String?
    public let skippedReason: String?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations, platform
        case skippedReason = "skipped_reason"
    }
}
