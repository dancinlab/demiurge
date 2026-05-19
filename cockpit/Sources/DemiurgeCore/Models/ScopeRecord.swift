// ScopeRecord — phase: cohort producer (no standalone PLAN κ / D-block
// — post-merge reconstructed; third cohort producer after D55).
//
// Typed sidecar for a `scope + analyze` producer run — POPPY (BSD, STScI)
// computes deterministic diffraction PSF + Strehl + encircled-energy
// metrics for a parametric segmented primary mirror. Demiurge spawns
// the producer (`~/core/hexa-lang/stdlib/scope/scope_poppy.py` — D61
// SSOT relocation) and persists the numbers as a typed record.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / AuraRecord /
// MatterRecord / ComponentRecord / F1F2Record): producer pinned to the
// library, measurement_gate honest, scope_caveats embedded.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "poppy@<version>" — pin the library, not the *primary*.
//     The 18-segment aperture is *parametric* (POPPY's MultiHexagonAperture
//     with JWST-class 1.32 m flat-to-flat hex segments), NOT a polished
//     mirror with a measured wavefront map. measurement_gate stays
//     GATE_OPEN; absorbed = false ALWAYS.
//   • The Code V / Zemax tolerancing gap (domains/scope.md §4) is
//     orthogonal — POPPY does PSF, not ray-trace tolerancing.
//   • To flip closedMeasured we'd need a JWST-class wavefront map
//     (e.g. NIRCam commissioning hash) + Strehl reproduction within
//     ±X%. Single parametric PSF is P-⑧ "can we make a record?".

import Foundation

/// Provenance for a `ScopeRecord` — same shape as AuraProvenance.
public struct ScopeProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. `"poppy@1.1.2"`.
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

/// Aperture parameters echoed from the producer — drift sentinel.
public struct ScopeAperture: Codable, Equatable, Sendable {
    public let segmentsRequested: Int
    public let rings: Int
    public let segmentFlatToFlatM: Double
    public let effectiveDiameterM: Double
    public let effectiveAreaM2: Double

    enum CodingKeys: String, CodingKey {
        case segmentsRequested = "segments_requested"
        case rings
        case segmentFlatToFlatM = "segment_flat_to_flat_m"
        case effectiveDiameterM = "effective_diameter_m"
        case effectiveAreaM2 = "effective_area_m2"
    }
}

public struct ScopePropagation: Codable, Equatable, Sendable {
    public let wavelengthM: Double
    public let fovArcsec: Double
    public let pixscaleArcsec: Double
    public let oversample: Int

    enum CodingKeys: String, CodingKey {
        case wavelengthM = "wavelength_m"
        case fovArcsec = "fov_arcsec"
        case pixscaleArcsec = "pixscale_arcsec"
        case oversample
    }
}

/// Headline measurements from POPPY's diffractive propagation — real
/// numbers from Fraunhofer/Fresnel math, deterministic.
public struct ScopeMeasurements: Codable, Equatable, Sendable {
    public let peakIntensity: Double
    public let totalIntensity: Double
    public let strehlProxy: Double?
    public let fwhmDiffractionLimitArcsec: Double
    public let fwhmMeasuredArcsec: Double?
    public let pixscaleArcsec: Double
    /// Encircled-energy fractions keyed by radius ("r_1_arcsec", etc).
    public let encircledEnergy: [String: Double?]
    public let imageShape: [Int]

    enum CodingKeys: String, CodingKey {
        case peakIntensity = "peak_intensity"
        case totalIntensity = "total_intensity"
        case strehlProxy = "strehl_proxy"
        case fwhmDiffractionLimitArcsec = "fwhm_diffraction_limit_arcsec"
        case fwhmMeasuredArcsec = "fwhm_measured_arcsec"
        case pixscaleArcsec = "pixscale_arcsec"
        case encircledEnergy = "encircled_energy"
        case imageShape = "image_shape"
    }
}

/// A scope PSF-analyze record (cohort round, no standalone PLAN
/// κ / D-block — post-merge reconstructed). Captures the POPPY PSF +
/// Strehl + encircled-energy measurements of the parametric segmented
/// primary plus the image SHA + aperture/propagation params so cross-
/// host drift is visible.
public struct ScopeRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let psfSha256_16: String
    public let poppyVersion: String
    public let aperture: ScopeAperture
    public let propagation: ScopePropagation
    public let measurements: ScopeMeasurements
    /// Artifact files (relative to `exports/scope/psf/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: ScopeProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, psfSha256_16: String,
                poppyVersion: String, aperture: ScopeAperture,
                propagation: ScopePropagation,
                measurements: ScopeMeasurements,
                artifacts: [String: String],
                provenance: ScopeProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.psfSha256_16 = psfSha256_16
        self.poppyVersion = poppyVersion
        self.aperture = aperture
        self.propagation = propagation
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
        case psfSha256_16 = "psf_sha256_16"
        case poppyVersion = "poppy_version"
        case aperture
        case propagation
        case measurements
        case artifacts
        case provenance
    }
}
