// BioAnalyzeRecord — bio + analyze ⟲ (D116 bio domain cellrun migration).
// SSOT: ~/core/hexa-lang/stdlib/bio/bio.hexa (24-axis in-silico status
// surface · root dispatcher) until a per-verb analyze.py argv shim wrapping
// GROMACS / OpenMM (MD) + Foldseek / DSSP (search) + Biopython / BLAST+
// (parsers) lands.
//
// OPTION C HYBRID: analyze is the IN-SILICO ⟲ loop cell (MD trajectory +
// structure search · bio.md §2 ANALYZE). g3 / D106: GATE_OPEN / absorbed=
// false ALWAYS — an in-silico MD trajectory / docking score is NOT a
// measured binding affinity or in-vivo readout. absorbed=true UNREACHABLE
// in software (measured wet-lab oracle past project.tape @D d1 boundary ·
// no MeasuredOracleRef on illustrative cells · D6 / D106).
//
// Mirrors the FirmwareAnalyzeRecord top-level shape — R3 schema witness.

import Foundation

public struct BioAnalyzeRecord: Codable, Equatable, Sendable {
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
