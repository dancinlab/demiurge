// AntimatterRecord — phase: cohort producer prototype (no standalone
// PLAN κ / D-block — post-merge reconstructed).
//
// Typed sidecar for an `antimatter + analyze` producer run — a cohort
// domain (after sscb κ-34, energy κ-35) wired to a real
// measuring engine tool, and the FIRST particle-physics cell.
//
// The producer = `~/core/hexa-lang/stdlib/antimatter/pdg_lookup.py`,
// which queries the `particle` Python package (scikit-hep, BSD-3) for
// PDG-aggregated mass · charge · lifetime · decay-summary of a
// canonical short-list of antiparticles (positron · antiproton ·
// antineutron · antimuon).
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / EnergyRecord /
// MatterRecord / ComponentRecord): producer pinned to the library
// identity, measurement_gate honest, scope_caveats embedded with the
// record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "particle@<ver> (PDG live-data lookup)" — pin the
//     library, *not* the underlying experiment. The PDG values ARE
//     real measured constants (decades of accelerator-experiment
//     aggregation), but THIS run is not a demiurge measurement —
//     demiurge did not run an experiment, it copied the PDG
//     aggregator's record. So:
//       measurement_gate = GATE_OPEN
//       absorbed         = false
//     ALWAYS. There is no path here that flips them — that requires
//     a clean-room re-derivation of the PDG aggregation pipeline,
//     which is a multi-year accelerator program. The scope_caveats
//     embed this distinction so a downstream consumer never mistakes
//     the record for a demiurge in-house measurement.
//   • The measurement_VALUES are real. They are useful for any
//     downstream antiproton/positron trap or PET design that needs
//     mass · charge · lifetime · ctau · decay summary as a typed,
//     citable, persisted record without spinning up full Geant4.

import Foundation

/// Provenance for an `AntimatterRecord` — mirrors `EnergyProvenance`
/// / `SSCBProvenance` (same absorbed + measurementGate + caveats
/// discipline; producer points to the `particle` Python package).
public struct AntimatterProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "particle@0.26.2 (PDG live-data
    /// lookup)" — library identity, NOT experiment identity (g3).
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

/// One row of the antiparticle table — pinned to the PDG `particle`
/// package's shape so cross-version drift is visible in the record.
/// Stable particles surface `lifetime_s` / `ctau_m` as nil (the JSON
/// spec has no `inf` — the producer maps Infinity → null + a
/// human-readable "stable" string in `decaySummary`).
public struct AntiparticleRow: Codable, Equatable, Sendable {
    public let label: String
    public let pdgId: Int
    public let name: String
    public let pdgName: String?
    public let massMev: Double?
    public let massLowerMev: Double?
    public let massUpperMev: Double?
    public let charge: Double
    /// Lifetime in SECONDS (nil for stable particles).
    public let lifetimeS: Double?
    /// c·τ in METERS (nil for stable particles).
    public let ctauM: Double?
    public let widthPdgUnits: Double?
    public let spinType: String?
    public let isSelfConjugate: Bool
    public let antiFlag: Int
    public let decaySummary: String

    public init(label: String, pdgId: Int, name: String, pdgName: String?,
                massMev: Double?, massLowerMev: Double?, massUpperMev: Double?,
                charge: Double, lifetimeS: Double?, ctauM: Double?,
                widthPdgUnits: Double?, spinType: String?,
                isSelfConjugate: Bool, antiFlag: Int,
                decaySummary: String) {
        self.label = label
        self.pdgId = pdgId
        self.name = name
        self.pdgName = pdgName
        self.massMev = massMev
        self.massLowerMev = massLowerMev
        self.massUpperMev = massUpperMev
        self.charge = charge
        self.lifetimeS = lifetimeS
        self.ctauM = ctauM
        self.widthPdgUnits = widthPdgUnits
        self.spinType = spinType
        self.isSelfConjugate = isSelfConjugate
        self.antiFlag = antiFlag
        self.decaySummary = decaySummary
    }

    enum CodingKeys: String, CodingKey {
        case label
        case pdgId = "pdg_id"
        case name
        case pdgName = "pdg_name"
        case massMev = "mass_mev"
        case massLowerMev = "mass_lower_mev"
        case massUpperMev = "mass_upper_mev"
        case charge
        case lifetimeS = "lifetime_s"
        case ctauM = "ctau_m"
        case widthPdgUnits = "width_pdg_units"
        case spinType = "spin_type"
        case isSelfConjugate = "is_self_conjugate"
        case antiFlag = "anti_flag"
        case decaySummary = "decay_summary"
    }
}

/// The headline measurements — rows of the antiparticle table plus
/// the row count. The honesty gate is on the *provenance* (PDG
/// aggregator copy, not demiurge experiment), not the algorithm.
public struct AntimatterMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    public let table: [AntiparticleRow]

    public init(rows: Int, table: [AntiparticleRow]) {
        self.rows = rows
        self.table = table
    }
}

/// An antimatter PDG-lookup record (cohort round, no standalone PLAN
/// κ / D-block — post-merge reconstructed). Captures the
/// canonical antiparticle short-list (positron · antiproton ·
/// antineutron · antimuon) with mass · charge · lifetime · decay
/// summary, plus the producer + library + Python pin so cross-host
/// drift (different `particle` versions) is visible.
public struct AntimatterRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let fingerprint: String
    public let particleVersion: String
    public let pythonVersion: String
    public let measurements: AntimatterMeasurements
    /// Artifact files (relative to `exports/antimatter/pdg/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: AntimatterProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, fingerprint: String,
                particleVersion: String, pythonVersion: String,
                measurements: AntimatterMeasurements,
                artifacts: [String: String],
                provenance: AntimatterProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.fingerprint = fingerprint
        self.particleVersion = particleVersion
        self.pythonVersion = pythonVersion
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
        case pythonVersion = "python_version"
        case measurements
        case artifacts
        case provenance
    }
}
