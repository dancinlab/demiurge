// ScopeVerifyRecord — cohort-round producer (absorption empty-cell
// fill, 2026-05-20 — no standalone PLAN κ / D-block, per archive/session-notes/
// absorption-empty-cells-research-2026-05-20.md §3 ROI rank 3).
//
// Typed sidecar for a `scope + verify` producer run — POPPY (+ optional
// WebbPSF + synphot) re-runs the SAME ①a wave_optics kernel that
// scope_poppy.py (analyze) uses on a *reference configuration* and
// witnesses 5 checks: reproducibility, diffraction-limit closure,
// encircled-energy monotonicity, WebbPSF cross-check (skipped if not
// installed), synphot photometric round-trip (skipped if not installed).
//
// rfc_002 §4 F1F2-style discipline (mirror ScopeRecord / ComponentVerifyRecord
// / CernRecord): producer pinned to the library, measurement_gate
// honest, scope_caveats embedded.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "poppy@<v>" (with optional webbpsf@<v> / synphot@<v>
//     pinned in the record). The verdict is reproducibility +
//     analytic invariants on the SAME parametric aperture
//     (MultiHexagonAperture), NOT a flight-data absorption. So
//     measurement_gate stays GATE_OPEN; absorbed = false ALWAYS,
//     regardless of how many checks GREEN.
//   • The diffraction-limit check is real (1.22 λ/D Airy) but on the
//     parametric aperture, not a JWST commissioning PSF.
//   • WebbPSF cross-check is loose (±50 %) because the WebbPSF model
//     adds OPD, secondary-mirror obscuration, struts and segment-tilt
//     errors that the bare MultiHexagonAperture does not — a strict
//     equality would be dishonest.
//   • Citations: POPPY/WebbPSF SSOTs (STScI), ASCL 1811.001 (synphot).
//   • absorbed=true would require: (a) WebbPSF parity within ±X% on a
//     JWST NIRCam commissioning hash, AND (b) a hexa-native FFT
//     re-propagation matching POPPY to IEEE-754. Neither lands here.

import Foundation

/// Provenance for a `ScopeVerifyRecord` — same shape as ScopeProvenance.
public struct ScopeVerifyProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. `"poppy@1.1.2 + synphot@1.7.0"` (or
    /// `"poppy@1.1.2 (webbpsf=not-installed, synphot=not-installed)"`).
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

/// Aperture parameters echoed from the producer.
public struct ScopeVerifyAperture: Codable, Equatable, Sendable {
    public let segmentsRequested: Int
    public let rings: Int
    public let segmentFlatToFlatM: Double
    public let effectiveDiameterM: Double

    enum CodingKeys: String, CodingKey {
        case segmentsRequested = "segments_requested"
        case rings
        case segmentFlatToFlatM = "segment_flat_to_flat_m"
        case effectiveDiameterM = "effective_diameter_m"
    }
}

public struct ScopeVerifyPropagation: Codable, Equatable, Sendable {
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

/// PSF measurements echoed from the kernel (same shape as
/// ScopeMeasurements, mirrored here so this verify record is self-
/// contained without forcing a hard dep on the analyze types).
public struct ScopeVerifyMeasurements: Codable, Equatable, Sendable {
    public let peakIntensity: Double
    public let totalIntensity: Double
    public let strehlProxy: Double?
    public let fwhmDiffractionLimitArcsec: Double
    public let fwhmMeasuredArcsec: Double?
    public let pixscaleArcsec: Double
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

/// One verify-check verdict line — kept JSON-shape-loose so check
/// fields that vary per check kind (rel_err, ee_r1, sha_a, etc.) all
/// fit through the same Swift type.
public struct ScopeVerifyCheck: Codable, Equatable, Sendable {
    public let name: String
    public let passed: Bool
    public let skipped: Bool
    public let note: String?
    public let relErr: Double?
    public let tolerance: Double?

    public init(name: String, passed: Bool, skipped: Bool,
                note: String?, relErr: Double?, tolerance: Double?) {
        self.name = name
        self.passed = passed
        self.skipped = skipped
        self.note = note
        self.relErr = relErr
        self.tolerance = tolerance
    }

    enum CodingKeys: String, CodingKey {
        case name
        case passed
        case skipped
        case note
        case relErr = "rel_err"
        case tolerance
    }
}

/// PASS / SKIPPED / required tally — required = not-skipped.
public struct ScopeVerifyTally: Codable, Equatable, Sendable {
    public let nRequired: Int
    public let nPassed: Int
    public let nSkipped: Int
    public let allRequiredPassed: Bool

    enum CodingKeys: String, CodingKey {
        case nRequired = "n_required"
        case nPassed = "n_passed"
        case nSkipped = "n_skipped"
        case allRequiredPassed = "all_required_passed"
    }
}

/// A scope verify-record (cohort round, no standalone PLAN κ /
/// D-block — post-merge reconstructed). Captures the 5-check signoff
/// on the parametric segmented primary.
public struct ScopeVerifyRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let psfSha256_16: String
    public let poppyVersion: String
    public let webbpsfVersion: String
    public let synphotVersion: String
    public let pythonVersion: String
    public let aperture: ScopeVerifyAperture
    public let propagation: ScopeVerifyPropagation
    public let measurements: ScopeVerifyMeasurements
    public let tally: ScopeVerifyTally
    public let checks: [ScopeVerifyCheck]
    public let artifacts: [String: String]
    public let provenance: ScopeVerifyProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, psfSha256_16: String,
                poppyVersion: String, webbpsfVersion: String,
                synphotVersion: String, pythonVersion: String,
                aperture: ScopeVerifyAperture,
                propagation: ScopeVerifyPropagation,
                measurements: ScopeVerifyMeasurements,
                tally: ScopeVerifyTally,
                checks: [ScopeVerifyCheck],
                artifacts: [String: String],
                provenance: ScopeVerifyProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.psfSha256_16 = psfSha256_16
        self.poppyVersion = poppyVersion
        self.webbpsfVersion = webbpsfVersion
        self.synphotVersion = synphotVersion
        self.pythonVersion = pythonVersion
        self.aperture = aperture
        self.propagation = propagation
        self.measurements = measurements
        self.tally = tally
        self.checks = checks
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
        case webbpsfVersion = "webbpsf_version"
        case synphotVersion = "synphot_version"
        case pythonVersion = "python_version"
        case aperture
        case propagation
        case measurements
        case tally
        case checks
        case artifacts
        case provenance
    }
}
