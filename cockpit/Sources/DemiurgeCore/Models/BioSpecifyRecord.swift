// BioSpecifyRecord — bio + specify (D116 bio domain cellrun migration).
// SSOT: ~/core/hexa-lang/stdlib/bio/bio.hexa (24-axis in-silico status
// surface · root dispatcher) until a per-verb specify.py argv shim lands.
//
// OPTION C HYBRID: specify is an IN-SILICO cell (target spec — gene of
// interest · FASTA · UniProt id · clinical-indication if drug · bio.md §2).
// g3 / D106: GATE_OPEN / absorbed=false ALWAYS — a target spec is
// illustrative aspiration, NEVER a measured wet-lab oracle. absorbed=true
// is UNREACHABLE in software for bio (requires a measured wet-lab readout
// past project.tape @D d1's legitimate not-yet boundary · no
// MeasuredOracleRef attaches to illustrative-physics cells · D6 / D106).
//
// Mirrors the FirmwareSpecifyRecord top-level shape (domain · verb · kind ·
// stamp · producer · measurement_gate · absorbed · scope_caveats ·
// citations · skipped_reason) — R3 typed-record schema witness.

import Foundation

public struct BioSpecifyRecord: Codable, Equatable, Sendable {
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
