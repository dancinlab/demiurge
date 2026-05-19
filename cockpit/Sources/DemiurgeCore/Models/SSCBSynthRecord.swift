// SSCBSynthRecord — `sscb + synthesize` typed sidecar (D72 / D61).
//
// Mirror of ComponentVerifyRecord pattern (κ-39 / D66) — D61-compliant-
// from-birth producer wraps a hexa-lang-owned Python script and the
// Swift side just witnesses + types the JSON the script writes.
//
// The producer = `~/core/hexa-lang/stdlib/sscb/femmt_sweep.py`, a FEMMT
// + analytic-fallback parameter sweep over 3 ferrite cores × 3 turn
// counts (9 candidate bus-side stray-snubber inductors) for the
// HEXA-SSCB mk1 600 V / 100 A topology. Picks the lowest-score
// candidate (L_target = 1 µH; penalises B-saturation).
//
// rfc_002 §4 F1F2-style discipline (mirror ComponentVerifyRecord /
// SSCBRecord / EnergyRecord): producer pinned to the library identity
// (`femmt@<v>` or `analytic_fallback`), measurement_gate honest,
// scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "femmt@<v>" when femmt is importable, or
//     "analytic_fallback (femmt unavailable)" otherwise. The analytic
//     fallback uses the gapped-core textbook reluctance formula
//     (Hagedorn §7.4) — identical math to femmt's air-gap default,
//     deterministic and reproducible cross-host.
//   • The candidate cores are PARAMETRIC EE-class N87 ferrite cores
//     (effective area / path length from textbook geometry), NOT
//     picked from a measured datasheet. No bench B-H curve, no
//     thermal coupling, no winding-loss measurement.
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS.
//     There is no path here that flips them — absorbed=true requires
//     (real magnetic-material datasheet B-H · bench loss measurement
//     · thermal coupling · measured Φ-N parity). FEMMT itself is the
//     cited synthesis instrument (domains/sscb.md §2); pinning the
//     library version is honesty, not absorption.
//   • The measurement_VALUES are real analytic outputs (L, B_peak,
//     est_loss). They surface the *first honest sizing witness*, NOT
//     a magnetics signoff verdict.

import Foundation

/// Provenance for a `SSCBSynthRecord` — same shape as
/// SSCBProvenance / ComponentVerifyProvenance / AntimatterProvenance.
public struct SSCBSynthProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "femmt@1.0.0" or
    /// "analytic_fallback (femmt unavailable)" — library identity, not
    /// magnetics-component identity (g3).
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let scopeCaveats: [String]
    /// Clean-room citations — DEVSIM JOSS doi:10.21105/joss.03898,
    /// FEMMT GPL-3 upstream, OpenMagnetics catalogue, etc.
    public let citations: [String]

    public init(absorbed: Bool, producer: String,
                measurementGate: F1F2Record.MeasurementGate,
                scopeCaveats: [String], citations: [String]) {
        self.absorbed = absorbed
        self.producer = producer
        self.measurementGate = measurementGate
        self.scopeCaveats = scopeCaveats
        self.citations = citations
    }

    enum CodingKeys: String, CodingKey {
        case absorbed
        case producer
        case measurementGate = "measurement_gate"
        case scopeCaveats = "scope_caveats"
        case citations
    }
}

/// One candidate inductor sized for the bus-side stray-snubber.
public struct SSCBSynthCandidate: Codable, Equatable, Sendable {
    public let coreId: String
    public let turns: Int
    public let lUH: Double
    public let bPeakMT: Double
    public let lossEstW: Double
    public let saturates: Bool
    public let score: Double

    public init(coreId: String, turns: Int, lUH: Double,
                bPeakMT: Double, lossEstW: Double,
                saturates: Bool, score: Double) {
        self.coreId = coreId
        self.turns = turns
        self.lUH = lUH
        self.bPeakMT = bPeakMT
        self.lossEstW = lossEstW
        self.saturates = saturates
        self.score = score
    }

    enum CodingKeys: String, CodingKey {
        case coreId = "core_id"
        case turns
        case lUH = "L_uH"
        case bPeakMT = "B_peak_mT"
        case lossEstW = "loss_est_W"
        case saturates
        case score
    }
}

/// Target operating point echoed from the producer.
public struct SSCBSynthTarget: Codable, Equatable, Sendable {
    public let lTargetH: Double
    public let iPeakA: Double
    public let fSwHz: Double
    public let bSatT: Double

    enum CodingKeys: String, CodingKey {
        case lTargetH = "L_target_H"
        case iPeakA = "I_peak_A"
        case fSwHz = "f_sw_Hz"
        case bSatT = "B_sat_T"
    }
}

/// Sweep summary echoed from the producer.
public struct SSCBSynthSweep: Codable, Equatable, Sendable {
    public let cores: [String]
    public let turnsGrid: [Int]
    public let nCandidates: Int
    public let nSafe: Int

    enum CodingKeys: String, CodingKey {
        case cores
        case turnsGrid = "turns_grid"
        case nCandidates = "n_candidates"
        case nSafe = "n_safe"
    }
}

/// A sscb-synthesize record (D72 / κ-N). Pins the femmt version + the
/// selected candidate + the sweep stats so cross-host drift (different
/// femmt versions, different platforms) is visible.
public struct SSCBSynthRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let fingerprint: String
    public let femmtVersion: String?
    public let pythonVersion: String
    public let solver: String
    public let target: SSCBSynthTarget
    public let sweep: SSCBSynthSweep
    public let best: SSCBSynthCandidate
    public let candidates: [SSCBSynthCandidate]
    /// Artifact files (relative to `exports/sscb/synthesize/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: SSCBSynthProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, fingerprint: String,
                femmtVersion: String?, pythonVersion: String,
                solver: String,
                target: SSCBSynthTarget,
                sweep: SSCBSynthSweep,
                best: SSCBSynthCandidate,
                candidates: [SSCBSynthCandidate],
                artifacts: [String: String],
                provenance: SSCBSynthProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.fingerprint = fingerprint
        self.femmtVersion = femmtVersion
        self.pythonVersion = pythonVersion
        self.solver = solver
        self.target = target
        self.sweep = sweep
        self.best = best
        self.candidates = candidates
        self.artifacts = artifacts
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case fingerprint
        case femmtVersion = "femmt_version"
        case pythonVersion = "python_version"
        case solver
        case target
        case sweep
        case best
        case candidates
        case artifacts
        case provenance
    }
}
