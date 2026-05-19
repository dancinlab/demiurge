// CernRecord — phase κ-38 (`cern + verify` producer, D65).
//
// Typed sidecar for the cern-domain stopping-power producer — Stage 1
// substrate (per ABSORPTION.md §"hexa 포팅 단계"): Bethe-Bloch mean
// dE/dx for antiprotons in CERN-style shielding materials (Al, Cu, W,
// Pb) over a coarse KE grid (1 MeV — 1 GeV).
//
// Why this is "cern + verify" and NOT "cern + analyze":
//   • cern + analyze (cohort round, no standalone PLAN κ / D-block)
//     is `lhe_stats.py` (pylhe LHE event
//     stats) — generator round-trip, not shielding numbers.
//   • cern + verify is the verb that domains/cern.md §2 + domains/
//     antimatter.md §2 both map to Geant4 — the shielding / antiproton-
//     stopping check that comes AFTER the design has a candidate magnet
//     + cavity layout. This cell sits at that verify slot.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / EnergyRecord /
// AntimatterRecord): producer pinned to library identity, gate honest,
// scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "particle@<v> + Bethe-Bloch analytic (no Geant4 MC)"
//   • Bethe-Bloch IS the closed-form formula Geant4's G4hIonisation
//     uses to populate its stopping-power tables in the non-relativistic
//     regime — so the numbers are real measured-physics. What makes the
//     gate GATE_OPEN is the four omissions vs full Geant4 MC: shell
//     corrections (Z/β at low E), density-effect (high γ), straggling
//     distribution, and nuclear-stopping channels. Useful for trap-
//     design scoping; NOT an absorbed-claim replacement for Geant4.
//   • measurement_gate = GATE_OPEN ALWAYS — flipping requires the hexa-
//     native re-derivation (Stage 2 → Stage 3 parity → Stage 4 absorbed,
//     per ABSORPTION.md §"hexa 포팅 단계"; Geant4 = ⭐⭐⭐⭐⭐).
//   • absorbed = false ALWAYS.
//
// Pool note: ubu-1 / ubu-2 (linux) have particle + uproot + numpy
// installed in user-space (PEP 668 --break-system-packages); the
// producer runs identically there. Process-spawn from cockpit stays
// local (Swift Process → /opt/homebrew/bin/python3) — wilson-pool
// intercepts heavy Bash only, not Process spawns.

import Foundation

/// Provenance for a `CernRecord` — mirrors `AntimatterProvenance` /
/// `EnergyProvenance` (same absorbed + measurementGate + caveats
/// discipline; producer points to the `particle` Python package +
/// the Bethe-Bloch analytic kernel).
public struct CernProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "particle@0.26.2 + Bethe-Bloch
    /// analytic (no Geant4 MC)" — library + algorithm identity, NOT
    /// experiment identity (g3).
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

/// One row of the antiproton stopping-power table — (material, KE) →
/// (β, γ, T_max, dE/dx). Pinned to the Python producer's shape so a
/// cross-host or cross-version drift in `particle` is visible in the
/// record.
public struct StoppingPowerRow: Codable, Equatable, Sendable {
    public let material: String
    public let zTarget: Int
    public let aTargetGpermol: Double
    public let iEv: Double
    public let keMev: Double
    public let beta: Double
    public let gamma: Double
    public let tmaxMev: Double
    public let dedxMevcm2PerG: Double

    public init(material: String, zTarget: Int, aTargetGpermol: Double,
                iEv: Double, keMev: Double, beta: Double, gamma: Double,
                tmaxMev: Double, dedxMevcm2PerG: Double) {
        self.material = material
        self.zTarget = zTarget
        self.aTargetGpermol = aTargetGpermol
        self.iEv = iEv
        self.keMev = keMev
        self.beta = beta
        self.gamma = gamma
        self.tmaxMev = tmaxMev
        self.dedxMevcm2PerG = dedxMevcm2PerG
    }

    enum CodingKeys: String, CodingKey {
        case material
        case zTarget = "z_target"
        case aTargetGpermol = "a_target_gpermol"
        case iEv = "i_ev"
        case keMev = "ke_mev"
        case beta
        case gamma
        case tmaxMev = "tmax_mev"
        case dedxMevcm2PerG = "dedx_mevcm2_per_g"
    }
}

/// The headline measurements — the full (material × KE) table plus
/// the axis arrays + row count. The honesty gate is on the
/// *provenance* (Bethe-Bloch slice of Geant4, not full MC), not the
/// algorithm — the numbers themselves are PDG-aggregated.
public struct CernMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    public let materials: [String]
    public let keMevSamples: [Double]
    public let table: [StoppingPowerRow]

    public init(rows: Int, materials: [String],
                keMevSamples: [Double], table: [StoppingPowerRow]) {
        self.rows = rows
        self.materials = materials
        self.keMevSamples = keMevSamples
        self.table = table
    }

    enum CodingKeys: String, CodingKey {
        case rows
        case materials
        case keMevSamples = "ke_mev_samples"
        case table
    }
}

/// Physical constants surfaced for record reproducibility — same
/// values that the Python producer used. A consumer can re-evaluate
/// Bethe-Bloch from these alone (no need to import `particle`).
public struct CernConstants: Codable, Equatable, Sendable {
    public let kBbMevcm2PerG: Double
    public let antiprotonMassMev: Double
    public let electronMassMev: Double

    public init(kBbMevcm2PerG: Double, antiprotonMassMev: Double,
                electronMassMev: Double) {
        self.kBbMevcm2PerG = kBbMevcm2PerG
        self.antiprotonMassMev = antiprotonMassMev
        self.electronMassMev = electronMassMev
    }

    enum CodingKeys: String, CodingKey {
        case kBbMevcm2PerG = "k_bb_mevcm2_per_g"
        case antiprotonMassMev = "antiproton_mass_mev"
        case electronMassMev = "electron_mass_mev"
    }
}

/// A cern-domain verify record (D65 / κ-38). Captures the Bethe-Bloch
/// dE/dx table for antiprotons in (Al, Cu, W, Pb) at a fixed KE grid
/// (1 MeV … 1 GeV), plus the producer + library + Python pin so a
/// cross-host run is auditable.
public struct CernRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let fingerprint: String
    public let particleVersion: String
    /// uproot version IF a `.root` artifact was written, else nil
    /// (the producer omits the ROOT histogram when uproot is missing).
    public let uprootVersion: String?
    public let pythonVersion: String
    public let constants: CernConstants
    public let measurements: CernMeasurements
    /// Artifact files (relative to `exports/cern/stopping/<stamp>/`):
    /// always contains `csv` + `meta`; `root` is present only when
    /// uproot was importable in the producer's Python.
    public let artifacts: [String: String]
    public let provenance: CernProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, fingerprint: String,
                particleVersion: String, uprootVersion: String?,
                pythonVersion: String, constants: CernConstants,
                measurements: CernMeasurements,
                artifacts: [String: String],
                provenance: CernProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.fingerprint = fingerprint
        self.particleVersion = particleVersion
        self.uprootVersion = uprootVersion
        self.pythonVersion = pythonVersion
        self.constants = constants
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
        case fingerprint
        case particleVersion = "particle_version"
        case uprootVersion = "uproot_version"
        case pythonVersion = "python_version"
        case constants
        case measurements
        case artifacts
        case provenance
    }
}
