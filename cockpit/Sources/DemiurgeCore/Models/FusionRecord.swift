// FusionRecord — phase κ-45 (P-⑧ 6th cohort producer prototype, D67).
//
// Typed sidecar for a `fusion + analyze` producer run — the SIXTH cohort
// domain (after sscb κ-34, energy κ-38, antimatter κ-43, …) wired to a
// real measuring engine tool, and the FIRST plasma-physics cell.
//
// The producer = `~/core/hexa-lang/stdlib/fusion/plasma_metrics.py`,
// which queries `plasmapy.formulary` (BSD-2 / CC-BY-4.0, scikit-hep
// adjacent) for derived plasma parameters of an ITER-like core
// operating point (n_e = 1e20 m⁻³, T_e = T_i = 10 keV, B = 5.3 T, D+
// majority). The derived values (omega_pe / lambda_D / v_A / r_Li /
// gyrofrequencies / thermal speeds) ARE mathematical facts — Bohm /
// Debye / Lorentz algebra — but the inputs are textbook ITER reference
// values, NOT a real tokamak shot.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / EnergyRecord /
// MatterRecord / AntimatterRecord / ComponentRecord): producer pinned
// to the library identity, measurement_gate honest, scope_caveats
// embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "plasmapy@<ver> (ITER core reference derivation)" —
//     pin the library AND the scenario name. The plasmapy formulae
//     ARE real (standard plasma-physics algebra), but the inputs are
//     textbook ITER values, NOT measured-from-a-device. So:
//       measurement_gate = GATE_OPEN
//       absorbed         = false
//     ALWAYS. There is no path here that flips them — that requires a
//     real Thomson-scattering / interferometry / magnetic-probe reading
//     wired into the producer (JET / TFTR / KSTAR / SPARC / ITER). None
//     is in scope.
//   • The measurement_VALUES are real — given n_e, T_e, B, D+, the
//     derived parameters ARE what such a plasma WOULD have. Useful for
//     downstream fusion-component design (RF launchers, diagnostics,
//     blanket design) that needs a citable, persisted set of derived
//     parameters without spinning up a full equilibrium code.

import Foundation

/// Provenance for a `FusionRecord` — mirrors `AntimatterProvenance` /
/// `EnergyProvenance` / `SSCBProvenance` (same absorbed +
/// measurementGate + caveats discipline; producer points to the
/// `plasmapy` Python package).
public struct FusionProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "plasmapy@2026.2.0 (ITER core
    /// reference derivation)" — library identity + scenario, NOT
    /// device-measurement identity (g3).
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

/// Scenario inputs echoed from the producer — the *assumed* operating
/// point. NOT a device measurement (g3 — scope_caveats records this).
public struct FusionScenario: Codable, Equatable, Sendable {
    public let name: String
    /// Electron density [m⁻³].
    public let neM3: Double
    /// Electron temperature [keV].
    public let teKev: Double
    /// Ion temperature [keV].
    public let tiKev: Double
    /// Magnetic field [T].
    public let bT: Double
    /// Majority ion species (e.g. "D+").
    public let ionSpecies: String

    enum CodingKeys: String, CodingKey {
        case name
        case neM3 = "n_e_m3"
        case teKev = "T_e_keV"
        case tiKev = "T_i_keV"
        case bT = "B_T"
        case ionSpecies = "ion_species"
    }
}

/// The headline derived parameters extracted from plasmapy.formulary.
/// These ARE mathematical facts (Bohm / Debye / Lorentz algebra) given
/// the scenario inputs — the honesty gate is on the *inputs* (textbook
/// not device-measured), not the derivation.
public struct FusionMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    // Angular frequencies [rad/s] — primary algebra form.
    public let omegaPeRadS: Double?
    public let omegaPiRadS: Double?
    public let omegaCeRadS: Double?
    public let omegaCiRadS: Double?
    // Frequencies [Hz] — engineering form (omega / 2π).
    public let fPeHz: Double?
    public let fPiHz: Double?
    public let fCeHz: Double?
    public let fCiHz: Double?
    // Lengths [m].
    public let lambdaDM: Double?
    public let rLeM: Double?
    public let rLiM: Double?
    // Speeds [m/s].
    public let vThEMs: Double?
    public let vThIMs: Double?
    public let vAMs: Double?

    enum CodingKeys: String, CodingKey {
        case rows
        case omegaPeRadS = "omega_pe_rad_s"
        case omegaPiRadS = "omega_pi_rad_s"
        case omegaCeRadS = "omega_ce_rad_s"
        case omegaCiRadS = "omega_ci_rad_s"
        case fPeHz = "f_pe_Hz"
        case fPiHz = "f_pi_Hz"
        case fCeHz = "f_ce_Hz"
        case fCiHz = "f_ci_Hz"
        case lambdaDM = "lambda_D_m"
        case rLeM = "r_Le_m"
        case rLiM = "r_Li_m"
        case vThEMs = "v_th_e_m_s"
        case vThIMs = "v_th_i_m_s"
        case vAMs = "v_A_m_s"
    }
}

/// A fusion plasma derived-parameters record (D67 / κ-45). Captures
/// the ITER-like core operating point + plasmapy-derived parameters,
/// plus the producer + library + Python pin so cross-host drift
/// (different plasmapy versions, different Python) is visible.
public struct FusionRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let plasmapyVersion: String
    public let pythonVersion: String
    public let scenario: FusionScenario
    public let measurements: FusionMeasurements
    /// Artifact files (relative to `exports/fusion/plasma/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: FusionProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, plasmapyVersion: String,
                pythonVersion: String,
                scenario: FusionScenario,
                measurements: FusionMeasurements,
                artifacts: [String: String],
                provenance: FusionProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.plasmapyVersion = plasmapyVersion
        self.pythonVersion = pythonVersion
        self.scenario = scenario
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
        case plasmapyVersion = "plasmapy_version"
        case pythonVersion = "python_version"
        case scenario
        case measurements
        case artifacts
        case provenance
    }
}
