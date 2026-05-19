// CernAnalyzeRecord — phase κ-44 (P-⑧ 5th cohort producer prototype, D66).
//
// Typed sidecar for a `cern + analyze` producer run — the FIFTH cohort
// domain (after sscb κ-34 / energy κ-38) wired to a real measuring
// engine tool, and the FIRST particle-accelerator-physics producer.
// pylhe (BSD-3, HEP-Python LHE v1/v3 parser) is the producer;
// demiurge spawns it and persists the round-trip statistics as a
// typed record.
//
// rfc_002 §4 F1F2-style discipline (mirror EnergyRecord / SSCBRecord /
// MatterRecord / ComponentRecord): producer pinned to the library
// identity, measurement_gate honest, scope_caveats embedded with the
// record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "pylhe@1.0.4" — pin the library, NOT the LHC. The
//     pylhe round-trip (write LHE, re-read LHE, count) is a real
//     algorithmic measurement of pylhe's end-to-end behavior on a
//     standards-compliant LHE file. Those numbers are real.
//   • BUT the input events are SYNTHETIC kinematics, NOT real LHC
//     data and NOT a tuned MadGraph/POWHEG/Sherpa generator output.
//     Momenta are hand-constructed with deterministic angles to
//     exercise the parser end-to-end. So:
//       measurement_gate = GATE_OPEN
//       absorbed = false
//     ALWAYS. Real-detector or real-MC absorption requires a tuned
//     generator card AND detector simulation (Delphes/Geant4) AND
//     tuned ATLAS/CMS object selection.
//   • scope_caveats records that the event sample is synthetic, the
//     channel kinematics are hand-constructed (not physically tuned
//     beyond on-shell mass + energy-momentum conservation per event),
//     no detector smearing/efficiency is applied, and no cross-section
//     is fit from data.

import Foundation

/// Provenance for a `CernAnalyzeRecord` — mirrors `EnergyProvenance` /
/// `SSCBProvenance` (same absorbed + measurementGate + caveats
/// discipline; producer points to pylhe not demiurge).
public struct CernAnalyzeProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "pylhe@1.0.4" (library identity,
    /// not LHC/MC-generator identity — g3).
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let scopeCaveats: [String]

    public init(absorbed: Bool, producer: String,
                measurementGate: F1F2Record.MeasurementGate,
                scopeCaveats: [String]) {
        self.absorbed = absorbed
        self.producer = producer
        self.measurementGate = measurementGate
        self.scopeCaveats = scopeCaveats
    }

    enum CodingKeys: String, CodingKey {
        case absorbed
        case producer
        case measurementGate = "measurement_gate"
        case scopeCaveats = "scope_caveats"
    }
}

/// LHE-process parameters echoed from the producer — channel, sqrt(s),
/// requested event count, RNG seed, LHE format version.
public struct CernProcess: Codable, Equatable, Sendable {
    public let channel: String
    public let sqrtSGev: Double
    public let nEventsRequested: Int
    public let rngSeed: Int
    public let lheVersion: String

    enum CodingKeys: String, CodingKey {
        case channel
        case sqrtSGev = "sqrt_s_gev"
        case nEventsRequested = "n_events_requested"
        case rngSeed = "rng_seed"
        case lheVersion = "lhe_version"
    }
}

/// Sample-file metadata — the LHE file the producer wrote + its size.
public struct CernSample: Codable, Equatable, Sendable {
    public let lheArtifact: String
    public let lheBytes: Int

    enum CodingKeys: String, CodingKey {
        case lheArtifact = "lhe_artifact"
        case lheBytes = "lhe_bytes"
    }
}

/// Round-trip statistics computed by re-reading the LHE file through
/// pylhe.LHEFile.fromfile(). These ARE the real algorithm-output
/// numbers — the honesty gate is on the *input events* (synthetic),
/// not the *parser* (which is the real pylhe code path).
public struct CernAnalyzeMeasurements: Codable, Equatable, Sendable {
    public let nEvents: Int
    public let multiplicityMean: Double?
    public let multiplicityMin: Int?
    public let multiplicityMax: Int?
    public let nFinalState: Int
    /// Sum of final-state E across all events (GeV). For an on-shell
    /// sample at sqrt(s), this should round-trip to n_events * sqrt(s).
    public let finalStateEnergyGevTotal: Double?
    public let finalStateAbsPzGevTotal: Double?
    /// PDG-id → count (across all events, all particles). Keys are
    /// stringified ints for stable Codable across hosts.
    public let pidCounts: [String: Int]

    enum CodingKeys: String, CodingKey {
        case nEvents = "n_events"
        case multiplicityMean = "multiplicity_mean"
        case multiplicityMin = "multiplicity_min"
        case multiplicityMax = "multiplicity_max"
        case nFinalState = "n_final_state"
        case finalStateEnergyGevTotal = "final_state_energy_gev_total"
        case finalStateAbsPzGevTotal = "final_state_abs_pz_gev_total"
        case pidCounts = "pid_counts"
    }
}

/// A CERN LHE-stats record (D66 / κ-44). Captures the headline round-
/// trip statistics from a pylhe.LHEFile.fromfile() re-read of a
/// deterministic synthetic sample, plus the process spec + sample
/// metadata so cross-host drift (different pylhe versions) is visible.
public struct CernAnalyzeRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let pylheVersion: String
    public let pythonVersion: String
    public let process: CernProcess
    public let sample: CernSample
    public let measurements: CernAnalyzeMeasurements
    /// Artifact files (relative to `exports/cern/lhe/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: CernAnalyzeProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, pylheVersion: String,
                pythonVersion: String,
                process: CernProcess, sample: CernSample,
                measurements: CernAnalyzeMeasurements,
                artifacts: [String: String],
                provenance: CernAnalyzeProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.pylheVersion = pylheVersion
        self.pythonVersion = pythonVersion
        self.process = process
        self.sample = sample
        self.measurements = measurements
        self.artifacts = artifacts
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case pylheVersion = "pylhe_version"
        case pythonVersion = "python_version"
        case process
        case sample
        case measurements
        case artifacts
        case provenance
    }
}
