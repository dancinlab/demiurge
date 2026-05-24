// EnergySynthRecord — energy + synthesize producer (PyPSA capacity expansion).
//
// Typed sidecar for an `energy + synthesize` producer run — a NEW
// measurable cell wired to a real measuring engine tool. This is the
// SECOND `energy`-domain cell after `energy + analyze` (pvlib clear-sky,
// EnergyRecord) and the FIRST `synthesize`-verb cell in the energy
// domain. ROI rank 5 from `archive/session-notes/absorption-empty-cells-research-
// 2026-05-20.md` §3 (⭐⭐⭐⭐⭐ — pure pip, NREL/TUB academic OSS).
//
// The producer = `~/core/hexa-lang/stdlib/energy/pypsa_capacity.py`,
// which builds a deterministic single-bus capacity-expansion LP
// (3 candidate technologies × 168-h representative week, snapshot
// weighting 8760/168) and delegates the solve to PyPSA's optimize()
// call (HiGHS vendored solver). The output is per-technology
// p_nom_opt MW + dispatch + annualised cost.
//
// rfc_002 §4 F1F2-style discipline (mirror EnergyRecord (pvlib) /
// ComponentVerifyRecord / SSCBRecord): producer pinned to the library
// identity, measurement_gate honest, scope_caveats embedded with the
// record.
//
// D61 / g_demiurge_pointer_only — script SSOT in hexa-lang/stdlib/,
// NEVER in cockpit/scripts/. demiurge ONLY witnesses + types.
//
// D72 2-layer classification — PyPSA is power-system optimization,
// NOT FEM (component+verify) / MC (energy+verify) / graph (grid+
// structure). The first consumer is this `energy + synthesize`; no
// second consumer yet, so the substrate stays a thin domain adapter
// under `stdlib/energy/pypsa_capacity.py`. Promote to
// `kernels/power_opt/pypsa_kernel.py` ONLY if a 2nd power-opt
// consumer (e.g. mobility V2G, grid+verify, energy+verify storage)
// appears — pickup note: `archive/session-notes/pypsa-kernel-promotion-pickup.md`.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "pypsa@<ver> + HiGHS@<ver>" — pin the libraries,
//     NOT the planned portfolio. The LP IS solved to optimality
//     (HiGHS reports termination = optimal), the numbers (p_nom_opt
//     MW per technology, annualised cost in EUR, renewable share)
//     ARE real PyPSA outputs. PyPSA's capacity-expansion formulation
//     is the canonical academic reference (Brown·Hörsch·Schlachtberger,
//     JORS 2018 doi:10.5334/jors.188).
//   • BUT the *inputs* are textbook placeholders: capital-cost numbers
//     are round figures inspired by NREL ATB but NOT a sourced ATB
//     pull; the demand profile is a single-bus toy with synthetic
//     daily / weekend shape; there is NO real storage cycling
//     constraint; the 168-h representative week is snapshot-weighted
//     to annual but real planning uses 8760-h sequential or
//     clustered-typical-day formulations. So:
//       measurement_gate = GATE_OPEN
//       absorbed         = false
//     ALWAYS. There is no path here that flips them — that requires
//     a sourced NREL ATB capital-cost pull, real demand profile
//     (e.g. ERCOT / PJM / ENTSO-E historical hourly load), renewable
//     capacity factors from real site-measured irradiance/wind (TMY3 /
//     ERA5 / NREL WIND), and AC power-flow with real network topology
//     — NOT a single bus.
//   • The measurement_VALUES are real LP outputs from a working
//     PyPSA + HiGHS stack. They are useful as a *first honest witness*
//     of the capacity-expansion stack in hexa-lang/stdlib (the LP is
//     feasible + optimal), NOT an investment signoff.
//   • If pypsa / HiGHS / pandas / numpy are missing OR the LP is
//     infeasible OR the summary JSON doesn't parse, the producer
//     returns ok=false and writes no record. Silent success forbidden.

import Foundation

/// Provenance for an `EnergySynthRecord` — mirrors `EnergyProvenance`
/// (same absorbed + measurementGate + caveats discipline; producer
/// points to PyPSA + HiGHS, not the planned portfolio).
public struct EnergySynthProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "pypsa@1.2.1 + HiGHS@1.14.0" —
    /// library identity, NOT portfolio identity (g3).
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

/// The capacity-expansion problem definition echoed from the producer
/// — kept on the record so a downstream sweep can compare problems.
public struct EnergySynthProblem: Codable, Equatable, Sendable {
    public let horizonHours: Int
    public let nBuses: Int
    public let nGenerators: Int
    public let nLoads: Int
    public let solver: String
    public let formulation: String

    public init(horizonHours: Int, nBuses: Int, nGenerators: Int,
                nLoads: Int, solver: String, formulation: String) {
        self.horizonHours = horizonHours
        self.nBuses = nBuses
        self.nGenerators = nGenerators
        self.nLoads = nLoads
        self.solver = solver
        self.formulation = formulation
    }

    enum CodingKeys: String, CodingKey {
        case horizonHours = "horizon_hours"
        case nBuses = "n_buses"
        case nGenerators = "n_generators"
        case nLoads = "n_loads"
        case solver
        case formulation
    }
}

/// One generator-catalogue row echoed from the producer.
public struct EnergySynthGeneratorSpec: Codable, Equatable, Sendable {
    public let name: String
    public let carrier: String
    public let capitalCostEurPerMwYr: Double
    public let marginalCostEurPerMwh: Double
    public let availability: String

    public init(name: String, carrier: String,
                capitalCostEurPerMwYr: Double,
                marginalCostEurPerMwh: Double,
                availability: String) {
        self.name = name
        self.carrier = carrier
        self.capitalCostEurPerMwYr = capitalCostEurPerMwYr
        self.marginalCostEurPerMwh = marginalCostEurPerMwh
        self.availability = availability
    }

    enum CodingKeys: String, CodingKey {
        case name
        case carrier
        case capitalCostEurPerMwYr = "capital_cost_eur_per_mw_yr"
        case marginalCostEurPerMwh = "marginal_cost_eur_per_mwh"
        case availability
    }
}

/// Per-generator LP result — the optimal investment + dispatch summary.
public struct EnergySynthGeneratorResult: Codable, Equatable, Sendable {
    public let carrier: String
    public let pNomOptMw: Double
    public let generationMwh: Double
    public let peakMw: Double
    public let capitalCostEurPerMwYr: Double
    public let marginalCostEurPerMwh: Double

    public init(carrier: String, pNomOptMw: Double,
                generationMwh: Double, peakMw: Double,
                capitalCostEurPerMwYr: Double,
                marginalCostEurPerMwh: Double) {
        self.carrier = carrier
        self.pNomOptMw = pNomOptMw
        self.generationMwh = generationMwh
        self.peakMw = peakMw
        self.capitalCostEurPerMwYr = capitalCostEurPerMwYr
        self.marginalCostEurPerMwh = marginalCostEurPerMwh
    }

    enum CodingKeys: String, CodingKey {
        case carrier
        case pNomOptMw = "p_nom_opt_mw"
        case generationMwh = "generation_mwh"
        case peakMw = "peak_mw"
        case capitalCostEurPerMwYr = "capital_cost_eur_per_mw_yr"
        case marginalCostEurPerMwh = "marginal_cost_eur_per_mwh"
    }
}

/// The headline measurements extracted from the PyPSA optimize() call.
public struct EnergySynthMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    public let horizonHours: Int
    /// Total demand over the snapshot window, weighted to annual MWh.
    public let totalLoadMwh: Double?
    /// LP objective value (annualised system cost, EUR).
    public let objectiveEur: Double?
    /// Renewable (solar + wind) share of total demand, 0..1.
    public let renewableShare: Double?
    /// Per-generator LP results keyed by generator name.
    public let perGenerator: [String: EnergySynthGeneratorResult]

    public init(rows: Int, horizonHours: Int,
                totalLoadMwh: Double?, objectiveEur: Double?,
                renewableShare: Double?,
                perGenerator: [String: EnergySynthGeneratorResult]) {
        self.rows = rows
        self.horizonHours = horizonHours
        self.totalLoadMwh = totalLoadMwh
        self.objectiveEur = objectiveEur
        self.renewableShare = renewableShare
        self.perGenerator = perGenerator
    }

    enum CodingKeys: String, CodingKey {
        case rows
        case horizonHours = "horizon_hours"
        case totalLoadMwh = "total_load_mwh"
        case objectiveEur = "objective_eur"
        case renewableShare = "renewable_share"
        case perGenerator = "per_generator"
    }
}

/// An energy capacity-expansion synth record. Captures the LP-optimal
/// investment per technology + annualised cost + renewable share, with
/// the PyPSA / HiGHS library pin so cross-host drift is visible.
public struct EnergySynthRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let pypsaVersion: String
    public let highsVersion: String
    public let pythonVersion: String
    public let problem: EnergySynthProblem
    public let generatorsCatalogue: [EnergySynthGeneratorSpec]
    public let measurements: EnergySynthMeasurements
    /// Artifact files (relative to `exports/energy/synth/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: EnergySynthProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String,
                pypsaVersion: String, highsVersion: String,
                pythonVersion: String,
                problem: EnergySynthProblem,
                generatorsCatalogue: [EnergySynthGeneratorSpec],
                measurements: EnergySynthMeasurements,
                artifacts: [String: String],
                provenance: EnergySynthProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.pypsaVersion = pypsaVersion
        self.highsVersion = highsVersion
        self.pythonVersion = pythonVersion
        self.problem = problem
        self.generatorsCatalogue = generatorsCatalogue
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
        case pypsaVersion = "pypsa_version"
        case highsVersion = "highs_version"
        case pythonVersion = "python_version"
        case problem
        case generatorsCatalogue = "generators_catalogue"
        case measurements
        case artifacts
        case provenance
    }
}
