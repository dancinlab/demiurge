// SpaceSynthRecord — typed sidecar for the `space + synthesize`
// producer (OpenMDAO multidisciplinary opt — NASA GSC-17177-1; ROI
// rank 8 ⭐⭐⭐⭐ per inbox/notes/absorption-empty-cells-research-
// 2026-05-20.md §3 space block).
//
// EIGHTH cohort cell crossing the measuring-producer threshold (after
// sscb+analyze, energy+analyze, antimatter+analyze, cern+verify,
// component+verify, fusion+analyze, plus the rest of the 5-cohort
// breadth survey already filled) — and the FIRST `synthesize`-verb
// cell in the space domain (sibling of space+analyze's Skyfield SGP4
// propagator producer).
//
// D72 classify-FIRST: OpenMDAO is the same situation as scope+synth
// (generic MDO solver). At this commit, NO kernels/mdo/ promotion
// exists in hexa-lang — so the substrate stays as a domain-local
// adapter at `~/core/hexa-lang/stdlib/space/openmdao_mission.py`.
// A promotion-pickup note in `inbox/notes/openmdao-kernel-promotion-
// pickup.md` flags that the second consumer (scope+synthesize) will
// trigger the kernels/mdo/ promotion (2 consumers = promotion
// candidate per D72).
//
// rfc_002 §4 F1F2-style discipline (mirror SpaceRecord / ScopeRecord /
// SSCBRecord / MatterRecord): producer pinned to openmdao + scipy
// versions, measurement_gate honestly OPEN (textbook MDO, no flight-
// validated mission), scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "openmdao@<v>+scipy@<v>" — pins the optimiser + the
//     numerical backend. The MDO IS real (ScipyOptimizeDriver SLSQP
//     converges deterministically on the analytic Tsiolkovsky model),
//     but the model is SCOPING-LEVEL (single discipline, no AOCS /
//     thermal / staging / gravity loss). The headline output is a
//     ΔV-vs-payload trade point — useful for early sizing, NOT a
//     mission-design verdict.
//   • absorbed = false ALWAYS — OpenMDAO is an EXTERNAL Python library
//     (pip install). Same banned-absorbed stance as Skyfield (space+
//     analyze), POPPY (scope+analyze), ngspice (sscb+analyze), pvlib
//     (energy+analyze), particle (antimatter+analyze).
//   • measurement_gate = GATE_OPEN永구 — the optimiser converges for a
//     TOY upper-stage model with textbook nominal inputs. Stage-up to
//     GATE_CLOSED_MEASURED would require:
//       (a) GMAT coupling (a flight-validated mission profile) — ROI
//           rank 15 / binary download / skipped this round per spec;
//       (b) multi-discipline coupling (AOCS, thermal, comms);
//       (c) honestly ascertained inputs (real upper-stage spec sheet
//           or wind-tunnel data, not textbook values).
//   • scope_caveats records: model-discipline-count (1), input-
//     provenance (textbook nominal), GMAT-coupling absent, propellant-
//     constraint behaviour (when active, the trade pins ΔV at the
//     upper-bound side), external-library status, kernel-promotion
//     candidacy (D72).

import Foundation

/// Provenance for a `SpaceSynthRecord` — mirrors SpaceProvenance /
/// ScopeProvenance (same absorbed + measurementGate + caveats
/// discipline; producer points to openmdao + scipy not demiurge).
public struct SpaceSynthProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "openmdao@3.43.0+scipy@1.17.1"
    /// (library pin, NOT a mission authority — g3).
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let scopeCaveats: [String]
    /// Citation block for the SSOT — NASA OpenMDAO release notice.
    public let atlasCiteBlock: String

    public init(absorbed: Bool, producer: String,
                measurementGate: F1F2Record.MeasurementGate,
                scopeCaveats: [String],
                atlasCiteBlock: String) {
        self.absorbed = absorbed
        self.producer = producer
        self.measurementGate = measurementGate
        self.scopeCaveats = scopeCaveats
        self.atlasCiteBlock = atlasCiteBlock
    }

    enum CodingKeys: String, CodingKey {
        case absorbed
        case producer
        case measurementGate = "measurement_gate"
        case scopeCaveats = "scope_caveats"
        case atlasCiteBlock = "atlas_cite_block"
    }
}

/// MDO model description — single-discipline rocket-equation rollup.
/// Captured verbatim from the Python substrate's meta.json so cockpit/
/// CLI render the EXACT model the optimiser ran (no Swift re-derivation
/// of the model spec — g3).
public struct SpaceSynthModel: Codable, Equatable, Sendable {
    public let name: String
    public let disciplineCount: Int
    public let designVariables: [String]
    public let objective: String
    public let constraints: [String]
    public let ispS: Double
    public let mDryKg: Double
    public let propellantBudgetKg: Double
    public let dvBoundsMps: [Double]
    public let wetMassSamplesKg: [Double]

    enum CodingKeys: String, CodingKey {
        case name
        case disciplineCount = "discipline_count"
        case designVariables = "design_variables"
        case objective
        case constraints
        case ispS = "isp_s"
        case mDryKg = "m_dry_kg"
        case propellantBudgetKg = "propellant_budget_kg"
        case dvBoundsMps = "dv_bounds_mps"
        case wetMassSamplesKg = "wet_mass_samples_kg"
    }
}

/// Optimised trade point for one wet-mass sample (the optimiser's
/// converged ΔV / propellant / payload triple).
public struct SpaceSynthOptimised: Codable, Equatable, Sendable {
    public let dvMps: Double
    public let mPropellantKg: Double
    public let mPayloadKg: Double

    enum CodingKeys: String, CodingKey {
        case dvMps = "dv_mps"
        case mPropellantKg = "m_propellant_kg"
        case mPayloadKg = "m_payload_kg"
    }
}

/// Solver diagnostics from the ScipyOptimizeDriver SLSQP run — kept
/// so a downstream sweep can spot stale tolerance / iteration drift.
public struct SpaceSynthSolver: Codable, Equatable, Sendable {
    public let ok: Bool
    public let optimizer: String
    public let tol: Double
    public let maxiter: Int
    public let propellantConstraintActive: Bool

    enum CodingKeys: String, CodingKey {
        case ok
        case optimizer
        case tol
        case maxiter
        case propellantConstraintActive = "propellant_constraint_active"
    }
}

/// One wet-mass sample's MDO output — inputs echoed, optimiser result,
/// and solver diagnostics. Mirrors the Python sample dict 1:1.
public struct SpaceSynthSample: Codable, Equatable, Sendable {
    public let mInitialKg: Double
    public let ispS: Double
    public let mDryKg: Double
    public let propellantBudgetKg: Double
    public let optimised: SpaceSynthOptimised
    public let solver: SpaceSynthSolver

    enum CodingKeys: String, CodingKey {
        case mInitialKg = "m_initial_kg"
        case ispS = "isp_s"
        case mDryKg = "m_dry_kg"
        case propellantBudgetKg = "propellant_budget_kg"
        case optimised
        case solver
    }
}

/// Headline best-payload trade point over the sweep — the "if you
/// only look at one number" point.
public struct SpaceSynthBest: Codable, Equatable, Sendable {
    public let mInitialKg: Double
    public let dvMps: Double
    public let mPayloadKg: Double
    public let mPropellantKg: Double

    enum CodingKeys: String, CodingKey {
        case mInitialKg = "m_initial_kg"
        case dvMps = "dv_mps"
        case mPayloadKg = "m_payload_kg"
        case mPropellantKg = "m_propellant_kg"
    }
}

/// A space synthesize-MDO record. Captures the ScipyOptimizeDriver
/// converged trade across the wet-mass sweep plus the model spec,
/// substrate versions, and provenance.
public struct SpaceSynthRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let inputSha256_16: String
    public let openmdaoVersion: String
    public let scipyVersion: String
    public let numpyVersion: String
    public let model: SpaceSynthModel
    public let samples: [SpaceSynthSample]
    public let best: SpaceSynthBest?
    public let runAtUtc: String
    /// Artifact files (relative to the per-run output directory under
    /// `exports/space/synthesize/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: SpaceSynthProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, inputSha256_16: String,
                openmdaoVersion: String, scipyVersion: String,
                numpyVersion: String,
                model: SpaceSynthModel,
                samples: [SpaceSynthSample],
                best: SpaceSynthBest?,
                runAtUtc: String,
                artifacts: [String: String],
                provenance: SpaceSynthProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.inputSha256_16 = inputSha256_16
        self.openmdaoVersion = openmdaoVersion
        self.scipyVersion = scipyVersion
        self.numpyVersion = numpyVersion
        self.model = model
        self.samples = samples
        self.best = best
        self.runAtUtc = runAtUtc
        self.artifacts = artifacts
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case geometryId = "geometry_id"
        case inputSha256_16 = "input_sha256_16"
        case openmdaoVersion = "openmdao_version"
        case scipyVersion = "scipy_version"
        case numpyVersion = "numpy_version"
        case model
        case samples
        case best
        case runAtUtc = "run_at_utc"
        case artifacts
        case provenance
    }
}
