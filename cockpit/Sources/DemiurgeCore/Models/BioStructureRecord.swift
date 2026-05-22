// BioStructureRecord — bio + structure (D116 bio domain cellrun migration).
// SSOT: ~/core/hexa-lang/stdlib/bio/bio.hexa (24-axis in-silico status
// surface · root dispatcher) until a per-verb structure.py argv shim lands.
//
// OPTION C HYBRID: structure is an IN-SILICO cell (functional decomposition
// — domain → motif → residue · bio.md §2 ARCHITECT). g3 / D106: GATE_OPEN /
// absorbed=false ALWAYS — a predicted decomposition is illustrative, NEVER
// an experimentally-resolved (X-ray / cryo-EM / NMR) structure. absorbed=
// true UNREACHABLE in software (measured wet-lab oracle past project.tape
// @D d1 boundary · no MeasuredOracleRef on illustrative cells · D6 / D106).
//
// Mirrors the FirmwareStructureRecord top-level shape — R3 schema witness.

import Foundation

public struct BioStructureRecord: Codable, Equatable, Sendable {
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
