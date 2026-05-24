// ScopeSynthRecord — cohort-round producer (absorption empty-cell fill,
// 2026-05-20 — no standalone PLAN κ / D-block, per archive/session-notes/
// absorption-empty-cells-research-2026-05-20.md §3 ROI rank 4).
//
// Typed sidecar for a `scope + synthesize` producer run — OpenMDAO
// (NASA OSS, Apache-2.0) couples a parametric segmented-primary
// optical figure-of-merit (PSF FWHM via the ①a wave_optics kernel)
// with a coarse areal-density structural-mass model and runs SLSQP
// to size the primary across 3 segment shelves (7 / 18 / 36 hexes).
//
// rfc_002 §4 F1F2-style discipline (mirror ScopeRecord / ScopeVerifyRecord
// / ComponentVerifyRecord / SSCBRecord): producer pinned to the
// library identity, measurement_gate honest, scope_caveats embedded.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "openmdao@<v> + poppy@<v>" — pin the libraries, NOT
//     the *primary*. The aperture is parametric (MultiHexagonAperture
//     via the ①a kernel); the structural mass model is areal-density
//     placeholders (60 kg/m² + 40 kg/m² backing + 20 kg/segment hw,
//     open-literature). measurement_gate stays GATE_OPEN; absorbed =
//     false ALWAYS.
//   • The converged J is a real optimum OF THIS SCALARISATION on this
//     coupled model — but the scalarisation weights are a designer
//     choice (NOT a measured Pareto front) and the mass coefficients
//     are placeholders. The record surfaces both so the consumer can
//     re-weight by editing the script — never by claiming a different
//     verdict from the same record.
//   • absorbed=true would require: (a) FEM mass model (CalculiX /
//     Elmer) via a separate kernel, (b) measured-grade Pareto front
//     vs a flight reference, (c) a 2nd MDO consumer to promote
//     OpenMDAO to `kernels/mdo/`. None of those land in this phase.

import Foundation

/// Provenance for a `ScopeSynthRecord` — same shape as ScopeProvenance.
public struct ScopeSynthProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. `"openmdao@3.43.0 + poppy@1.1.2"`.
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

/// Continuous + discrete design space the driver searched.
public struct ScopeSynthDesignSpace: Codable, Equatable, Sendable {
    public let ftfLowerM: Double
    public let ftfUpperM: Double
    public let ftfInitialM: Double
    public let segmentShelves: [Int]

    enum CodingKeys: String, CodingKey {
        case ftfLowerM = "ftf_lower_m"
        case ftfUpperM = "ftf_upper_m"
        case ftfInitialM = "ftf_initial_m"
        case segmentShelves = "segment_shelves"
    }
}

/// Scalarisation weights — designer choice, NOT measured.
public struct ScopeSynthWeights: Codable, Equatable, Sendable {
    public let wMass: Double
    public let wFwhm: Double
    public let wAper: Double

    enum CodingKeys: String, CodingKey {
        case wMass = "w_mass"
        case wFwhm = "w_fwhm"
        case wAper = "w_aper"
    }
}

/// Areal-density mass coefficients — open-literature placeholders.
public struct ScopeSynthMassModel: Codable, Equatable, Sendable {
    public let arealPrimaryKgPerM2: Double
    public let arealBackingKgPerM2: Double
    public let perSegmentHardwareKg: Double

    enum CodingKeys: String, CodingKey {
        case arealPrimaryKgPerM2 = "areal_primary_kg_per_m2"
        case arealBackingKgPerM2 = "areal_backing_kg_per_m2"
        case perSegmentHardwareKg = "per_segment_hardware_kg"
    }
}

/// Propagation parameters echoed from the kernel — drift sentinel.
public struct ScopeSynthPropagation: Codable, Equatable, Sendable {
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

/// One converged design point — output of `evaluate_point` after SLSQP
/// pulls the design variable to its optimum within the shelf.
public struct ScopeSynthConverged: Codable, Equatable, Sendable {
    public let ftfM: Double
    public let segments: Int
    public let rings: Int
    public let effectiveDiameterM: Double
    public let effectiveAreaM2: Double
    public let fwhmArcsec: Double
    public let strehlProxy: Double?
    public let psfSha256_16: String
    public let massKg: Double
    public let objectiveJ: Double

    enum CodingKeys: String, CodingKey {
        case ftfM = "ftf_m"
        case segments
        case rings
        case effectiveDiameterM = "effective_diameter_m"
        case effectiveAreaM2 = "effective_area_m2"
        case fwhmArcsec = "fwhm_arcsec"
        case strehlProxy = "strehl_proxy"
        case psfSha256_16 = "psf_sha256_16"
        case massKg = "mass_kg"
        case objectiveJ = "objective_j"
    }
}

/// Per-shelf optimisation outcome — one of 3 (7 / 18 / 36 segments).
public struct ScopeSynthShelf: Codable, Equatable, Sendable {
    public let segments: Int
    public let ok: Bool
    public let nIter: Int?
    public let converged: ScopeSynthConverged?
    public let error: String?

    enum CodingKeys: String, CodingKey {
        case segments
        case ok
        case nIter = "n_iter"
        case converged
        case error
    }
}

/// Winning shelf — lowest J among the 3 ok shelves.
public struct ScopeSynthWinner: Codable, Equatable, Sendable {
    public let segments: Int
    public let nIter: Int
    public let converged: ScopeSynthConverged

    enum CodingKeys: String, CodingKey {
        case segments
        case nIter = "n_iter"
        case converged
    }
}

/// A scope synthesize-record (cohort round, no standalone PLAN κ /
/// D-block — post-merge reconstructed). Captures OpenMDAO's coupled
/// optics+structure sizing of a parametric segmented primary.
public struct ScopeSynthRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let openmdaoVersion: String
    public let poppyVersion: String
    public let pythonVersion: String
    public let designSpace: ScopeSynthDesignSpace
    public let scalarisationWeights: ScopeSynthWeights
    public let massModel: ScopeSynthMassModel
    public let propagation: ScopeSynthPropagation
    public let shelves: [ScopeSynthShelf]
    public let winner: ScopeSynthWinner
    public let artifacts: [String: String]
    public let provenance: ScopeSynthProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String,
                openmdaoVersion: String, poppyVersion: String,
                pythonVersion: String,
                designSpace: ScopeSynthDesignSpace,
                scalarisationWeights: ScopeSynthWeights,
                massModel: ScopeSynthMassModel,
                propagation: ScopeSynthPropagation,
                shelves: [ScopeSynthShelf],
                winner: ScopeSynthWinner,
                artifacts: [String: String],
                provenance: ScopeSynthProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.openmdaoVersion = openmdaoVersion
        self.poppyVersion = poppyVersion
        self.pythonVersion = pythonVersion
        self.designSpace = designSpace
        self.scalarisationWeights = scalarisationWeights
        self.massModel = massModel
        self.propagation = propagation
        self.shelves = shelves
        self.winner = winner
        self.artifacts = artifacts
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case openmdaoVersion = "openmdao_version"
        case poppyVersion = "poppy_version"
        case pythonVersion = "python_version"
        case designSpace = "design_space"
        case scalarisationWeights = "scalarisation_weights"
        case massModel = "mass_model"
        case propagation
        case shelves
        case winner
        case artifacts
        case provenance
    }
}
