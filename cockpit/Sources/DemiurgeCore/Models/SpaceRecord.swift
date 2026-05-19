// SpaceRecord — phase κ-39 (P-⑧ FIFTH cohort producer, D60).
//
// Typed sidecar for a `space + analyze` producer run — Skyfield SGP4
// orbit propagation over standard NORAD TLEs (ISS + HST). 5번째 cohort
// 도메인 (sscb · grid · bot · brain 다음) 이 producer 임계점을 넘는
// 증거 — chip / component / matter 세 "deep" 기둥 외, breadth-survey
// cohort 가 누적적으로 measurable engine tool 로 매핑되는 흐름.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / MatterRecord /
// ComponentRecord / F1F2Record): producer pinned to skyfield + sgp4
// versions, measurement_gate honest about TLE age, scope_caveats
// embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "skyfield@<v>+sgp4@<v>" — pin the propagator library,
//     not a specific TLE source authority. SGP4 is the NORAD-standard
//     propagator (Hoots/Roehrich 1980, validated against the NORAD
//     reference implementation by Vallado 2006); Skyfield wraps the
//     reference C code. The numbers ARE real (~1 km positional
//     accuracy at epoch).
//   • BUT — TLE elements DECAY with age. Empirical rule of thumb:
//     ~1 km/day position drift; ~3 km/week; loses usefulness past
//     ~14 days. So the gate path is:
//       - tle_age_days ≤ 7   → GATE_CLOSED_MEASURED ELIGIBLE
//         (within SGP4's nominal validity window — the "real" g3
//         caveat is TLE-age, not absorption; SGP4 + Skyfield are
//         bench-validated against NORAD reference)
//       - tle_age_days > 7   → GATE_OPEN (drifted TLE, predictions
//         degrade outside nominal validity window)
//   • absorbed = false ALWAYS — Skyfield is an EXTERNAL Python library
//     (not absorbed into hexa-lang / hexa-arch). Same banned-absorbed
//     stance as ngspice (sscb), networkx (grid), URDF (bot), nibabel
//     (brain): demiurge is the consumer, the upstream tool is owner.
//   • scope_caveats records: TLE age caveat, fixed-observer prototype,
//     deterministic-input policy (bundled TLEs not live Celestrak fetch),
//     external-library status, and the SGP4-validity-window gate.

import Foundation

/// Provenance for a `SpaceRecord` — mirrors SSCBProvenance /
/// MatterProvenance (same absorbed + measurementGate + caveats
/// discipline; producer points to skyfield + sgp4 not demiurge).
public struct SpaceProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "skyfield@1.54+sgp4@2.25" (library
    /// pin, not a TLE-source authority — g3).
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

/// Fixed ground-station observer the propagation reduces to. Prototype
/// hard-codes Seoul so the record is reproducible cross-host; later
/// phase can lift this into per-run config.
public struct SpaceObserver: Codable, Equatable, Sendable {
    public let latDeg: Double
    public let lonDeg: Double
    public let elevM: Double
    public let name: String

    enum CodingKeys: String, CodingKey {
        case latDeg = "lat_deg"
        case lonDeg = "lon_deg"
        case elevM = "elev_m"
        case name
    }
}

/// Propagation window parameters — echoes the Python sidecar SSOT so
/// downstream sweeps can spot drift in window/cadence settings.
public struct SpaceWindow: Codable, Equatable, Sendable {
    public let t0Utc: String
    public let hours: Int
    public let stepS: Int
    public let sampleCountPerSat: Int
    public let visibilityAltDeg: Double

    enum CodingKeys: String, CodingKey {
        case t0Utc = "t0_utc"
        case hours
        case stepS = "step_s"
        case sampleCountPerSat = "sample_count_per_sat"
        case visibilityAltDeg = "visibility_alt_deg"
    }
}

/// Per-satellite aggregates over the 24 h window. ALL fields are real
/// numerical outputs of SGP4 (g3 — Skyfield IS the instrument here);
/// the honesty gate is on TLE age, not on the measurements themselves.
public struct SpaceSatelliteAggregates: Codable, Equatable, Sendable {
    public let sampleCount: Int
    public let visibleCount: Int
    public let visibilityRatio: Double
    public let maxAltDeg: Double?
    public let meanAltDegVisible: Double?
    public let maxPassMinutes: Double
    public let visibleWindowCount: Int

    enum CodingKeys: String, CodingKey {
        case sampleCount = "sample_count"
        case visibleCount = "visible_count"
        case visibilityRatio = "visibility_ratio"
        case maxAltDeg = "max_alt_deg"
        case meanAltDegVisible = "mean_alt_deg_visible"
        case maxPassMinutes = "max_pass_minutes"
        case visibleWindowCount = "visible_window_count"
    }
}

/// One satellite's propagation result — TLE epoch + age (the g3 gate
/// driver), per-sat aggregates, pointer to the NDJSON track file.
public struct SpaceSatellite: Codable, Equatable, Sendable {
    public let name: String
    public let noradId: Int
    public let tleEpochUtc: String
    public let tleAgeDays: Double
    public let trackFile: String
    public let aggregates: SpaceSatelliteAggregates

    enum CodingKeys: String, CodingKey {
        case name
        case noradId = "norad_id"
        case tleEpochUtc = "tle_epoch_utc"
        case tleAgeDays = "tle_age_days"
        case trackFile = "track_file"
        case aggregates
    }
}

/// A space orbit-analyze record (D60 / κ-39). Captures the SGP4
/// propagation aggregates for one or more standard NORAD TLEs plus
/// the TLE source hash + library versions so cross-host drift is
/// visible.
public struct SpaceRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let tleSha256_16: String
    public let tleCount: Int
    public let skyfieldVersion: String
    public let sgp4Version: String
    public let observer: SpaceObserver
    public let window: SpaceWindow
    public let runAtUtc: String
    public let worstTleAgeDays: Double
    public let satellites: [SpaceSatellite]
    /// Artifact files (relative to the per-run output directory under
    /// `exports/space/orbit/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: SpaceProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, tleSha256_16: String,
                tleCount: Int,
                skyfieldVersion: String, sgp4Version: String,
                observer: SpaceObserver, window: SpaceWindow,
                runAtUtc: String, worstTleAgeDays: Double,
                satellites: [SpaceSatellite],
                artifacts: [String: String],
                provenance: SpaceProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.tleSha256_16 = tleSha256_16
        self.tleCount = tleCount
        self.skyfieldVersion = skyfieldVersion
        self.sgp4Version = sgp4Version
        self.observer = observer
        self.window = window
        self.runAtUtc = runAtUtc
        self.worstTleAgeDays = worstTleAgeDays
        self.satellites = satellites
        self.artifacts = artifacts
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case tleSha256_16 = "tle_sha256_16"
        case tleCount = "tle_count"
        case skyfieldVersion = "skyfield_version"
        case sgp4Version = "sgp4_version"
        case observer
        case window
        case runAtUtc = "run_at_utc"
        case worstTleAgeDays = "worst_tle_age_days"
        case satellites
        case artifacts
        case provenance
    }
}
