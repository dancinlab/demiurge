// EnergyRecord — phase κ-38 (P-⑧ 4th cohort producer prototype, D59).
//
// Typed sidecar for an `energy + analyze` producer run — the FOURTH
// cohort domain (after sscb κ-34) wired to a real measuring engine
// tool, and the FIRST renewable-energy cell. pvlib (BSD-3, NREL SAM-
// verified clear-sky + CEC SAPM module model) is the producer;
// demiurge spawns it and persists the measurements as a typed record.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / MatterRecord /
// ComponentRecord): producer pinned to the library identity,
// measurement_gate honest, scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "pvlib@0.15.1" — pin the library, not the site weather
//     data. The Ineichen clear-sky model + CEC SAPM module model are
//     NREL SAM-verified, but this run uses ZERO real sky-measured
//     irradiance (no TMY3, no NSRDB). It is the *clear-sky upper bound*,
//     not a TMY yield prediction. Real-world annual yield typically
//     70-85 % of clear-sky bound (clouds, aerosols, snow, soiling).
//   • absorbed = false — ALWAYS. Same BANNED-absorbed stance as
//     SSCBRecord (ngspice@46 produces real numbers from a plausible
//     circuit — pvlib@0.15.1 produces real algorithm output from
//     standard module + clear-sky-only weather). measurement_gate
//     stays GATE_OPEN.
//   • scope_caveats records that no sky-measured data was used, the
//     module is from a CEC database (not bench-validated I-V curves),
//     and standard system losses (DC wiring, mismatch, soiling) were
//     NOT applied — so the bound is honestly optimistic.

import Foundation

/// Provenance for an `EnergyRecord` — mirrors `SSCBProvenance` /
/// `ComponentProvenance` (same absorbed + measurementGate + caveats
/// discipline; producer points to pvlib not demiurge).
public struct EnergyProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "pvlib@0.15.1" (library identity,
    /// not site-data identity — g3).
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

/// Site parameters echoed from the producer — kept on the record so a
/// downstream sweep can compare locations.
public struct EnergySite: Codable, Equatable, Sendable {
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let altitudeM: Double
    public let timezone: String

    enum CodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
        case altitudeM = "altitude_m"
        case timezone
    }
}

/// PV system parameters echoed from the producer — module, inverter,
/// mount tilt/azimuth, array sizing.
public struct EnergySystemSpec: Codable, Equatable, Sendable {
    public let module: String
    public let inverter: String
    public let surfaceTilt: Double
    public let surfaceAzimuth: Double
    public let modulesPerString: Int
    public let strings: Int
    public let tempAirC: Double
    public let windSpeedMs: Double

    enum CodingKeys: String, CodingKey {
        case module
        case inverter
        case surfaceTilt = "surface_tilt"
        case surfaceAzimuth = "surface_azimuth"
        case modulesPerString = "modules_per_string"
        case strings
        case tempAirC = "temp_air_C"
        case windSpeedMs = "wind_speed_ms"
    }
}

/// Simulation horizon + model selection.
public struct EnergySimulation: Codable, Equatable, Sendable {
    public let year: Int
    public let freq: String
    public let model: String
}

/// The headline measurements extracted from the pvlib ModelChain —
/// these ARE the real numbers (pvlib's NREL SAM-verified Ineichen +
/// CEC SAPM algorithm output). The honesty gate is on the *weather
/// data source*, not the algorithm.
public struct EnergyMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    /// Annual AC energy (clear-sky bound) — the headline figure.
    public let annualEnergyKwh: Double?
    /// Annual DC energy (clear-sky bound) — pre-inverter.
    public let annualEnergyDcKwh: Double?
    public let dcPeakKw: Double?
    public let acPeakKw: Double?
    /// Annual global horizontal irradiance integral (MWh per m²).
    public let ghiAnnualMwhPerM2: Double?
    /// kWh per calendar month (1..12 → AC kWh).
    public let monthlyAcKwh: [String: Double]

    enum CodingKeys: String, CodingKey {
        case rows
        case annualEnergyKwh = "annual_energy_kwh"
        case annualEnergyDcKwh = "annual_energy_dc_kwh"
        case dcPeakKw = "dc_peak_kw"
        case acPeakKw = "ac_peak_kw"
        case ghiAnnualMwhPerM2 = "ghi_annual_mwh_per_m2"
        case monthlyAcKwh = "monthly_ac_kwh"
    }
}

/// An energy clear-sky PV analysis record (D59 / κ-38). Captures the
/// headline annual_energy_kwh from `pvlib ModelChain` plus the site +
/// system spec so cross-host drift (different pvlib versions, different
/// module databases) is visible.
public struct EnergyRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let pvlibVersion: String
    public let pythonVersion: String
    public let site: EnergySite
    public let system: EnergySystemSpec
    public let simulation: EnergySimulation
    public let measurements: EnergyMeasurements
    /// Artifact files (relative to `exports/energy/pv/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: EnergyProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, pvlibVersion: String,
                pythonVersion: String,
                site: EnergySite, system: EnergySystemSpec,
                simulation: EnergySimulation,
                measurements: EnergyMeasurements,
                artifacts: [String: String],
                provenance: EnergyProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.pvlibVersion = pvlibVersion
        self.pythonVersion = pythonVersion
        self.site = site
        self.system = system
        self.simulation = simulation
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
        case pvlibVersion = "pvlib_version"
        case pythonVersion = "python_version"
        case site
        case system
        case simulation
        case measurements
        case artifacts
        case provenance
    }
}
