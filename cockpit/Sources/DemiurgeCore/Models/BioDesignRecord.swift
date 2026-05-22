// BioDesignRecord — bio + design (D116 bio domain cellrun migration).
// SSOT: ~/core/hexa-lang/stdlib/bio/bio.hexa (24-axis in-silico status
// surface · root dispatcher) until a per-verb design.py argv shim wrapping
// AlphaFold 3 / ESMFold / Boltz-1 / RFdiffusion / ProteinMPNN lands.
//
// OPTION C HYBRID: design is an IN-SILICO cell (structure prediction +
// de-novo design · bio.md §2 DESIGN). g3 / D106: GATE_OPEN / absorbed=false
// ALWAYS — a predicted fold / designed sequence is illustrative until
// wet-lab expression + structure-resolution confirms it. absorbed=true
// UNREACHABLE in software (measured wet-lab oracle past project.tape @D d1
// boundary · no MeasuredOracleRef on illustrative cells · D6 / D106).
//
// Mirrors the FirmwareDesignRecord top-level shape — R3 schema witness.

import Foundation

public struct BioDesignRecord: Codable, Equatable, Sendable {
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
