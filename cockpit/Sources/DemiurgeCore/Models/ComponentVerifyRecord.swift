// ComponentVerifyRecord — phase κ-39 (P-⑨ component-verify producer, D66).
//
// Typed sidecar for a `component + verify` producer run — the SIXTH
// measurable-only cell crossing the engine-tool threshold (after
// component+synthesize, chip+verify, chip+synthesize, matter+analyze,
// sscb+analyze, energy+analyze, antimatter+analyze), and the SECOND
// D61-compliant-from-birth producer (after the antimatter producer —
// cohort round, no standalone PLAN κ entry).
//
// The producer = `~/core/hexa-lang/stdlib/component/gmsh_skfem.py`,
// which builds a 10×10×2 mm silicon die proxy box via gmsh, meshes it
// with tetrahedra, then runs two scikit-fem solves on the same mesh:
// a steady-state heat conduction problem (Dirichlet T_amb on the back
// face, body heat source on the top 1 mm) and a linear elasticity
// problem (Dirichlet u=0 on the back face, gravity body force).
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / EnergyRecord /
// MatterRecord / ComponentRecord / AntimatterRecord): producer pinned
// to the library identity, measurement_gate honest, scope_caveats
// embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "gmsh@<v> + scikit-fem@<v>" — pin the libraries, NOT
//     the part. The geometry is a TOY box, NOT a measured component
//     STEP file from the rfc_008 chip→component handoff dossier.
//   • The numbers ARE real Partial-Differential-Equation solutions on
//     the toy geometry — physically correct given the inputs — but
//     the inputs (material constants, load, geometry) are placeholder
//     until a real cited component lands. So:
//       measurement_gate = GATE_OPEN
//       absorbed         = false
//     ALWAYS. There is no path here that flips them. Wiring against a
//     measured component STEP + measured material datasheet + measured
//     load case + mesh convergence study is a separate phase.
//   • The measurement_VALUES are real PDE outputs (ΔT, σ_vM, u_max).
//     They are useful as a *first honest thermal/structural witness*
//     for an electronics package, NOT a signoff verdict.

import Foundation

/// Provenance for a `ComponentVerifyRecord` — mirrors `AntimatterProvenance`
/// (same absorbed + measurementGate + caveats discipline; producer points
/// to the gmsh + scikit-fem Python pair).
public struct ComponentVerifyProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "gmsh@4.15.2 + scikit-fem@12.0.1" —
    /// library identity, NOT part identity (g3).
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

/// Geometry of the meshed solid — pinned alongside the measurements so
/// a downstream consumer can identify *which box* the numbers apply to
/// without re-reading the .msh. All lengths in METERS.
public struct ComponentVerifyGeometry: Codable, Equatable, Sendable {
    public let id: String
    public let displayName: String
    public let lengthM: Double
    public let widthM: Double
    public let thicknessM: Double
    public let meshSizeM: Double
    public let nNodes: Int
    public let nElements: Int

    public init(id: String, displayName: String,
                lengthM: Double, widthM: Double, thicknessM: Double,
                meshSizeM: Double, nNodes: Int, nElements: Int) {
        self.id = id
        self.displayName = displayName
        self.lengthM = lengthM
        self.widthM = widthM
        self.thicknessM = thicknessM
        self.meshSizeM = meshSizeM
        self.nNodes = nNodes
        self.nElements = nElements
    }

    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case lengthM = "length_m"
        case widthM = "width_m"
        case thicknessM = "thickness_m"
        case meshSizeM = "mesh_size_m"
        case nNodes = "n_nodes"
        case nElements = "n_elements"
    }
}

/// Material constants used by the FEM solves. Textbook silicon at 300 K
/// — NOT a datasheet measurement (see scope_caveats).
public struct ComponentVerifyMaterial: Codable, Equatable, Sendable {
    public let name: String
    public let kWPerMK: Double
    public let rhoKgPerM3: Double
    public let youngsPa: Double
    public let poissons: Double

    public init(name: String, kWPerMK: Double, rhoKgPerM3: Double,
                youngsPa: Double, poissons: Double) {
        self.name = name
        self.kWPerMK = kWPerMK
        self.rhoKgPerM3 = rhoKgPerM3
        self.youngsPa = youngsPa
        self.poissons = poissons
    }

    enum CodingKeys: String, CodingKey {
        case name
        case kWPerMK = "k_w_per_mk"
        case rhoKgPerM3 = "rho_kg_per_m3"
        case youngsPa = "youngs_pa"
        case poissons
    }
}

/// Load case applied to the box — power dissipation through the top
/// 1 mm, ambient on the back, gravity body force.
public struct ComponentVerifyLoad: Codable, Equatable, Sendable {
    public let diePowerW: Double
    public let heatingRegionThicknessM: Double
    public let tAmbientK: Double
    public let gravityMPerS2: Double

    public init(diePowerW: Double, heatingRegionThicknessM: Double,
                tAmbientK: Double, gravityMPerS2: Double) {
        self.diePowerW = diePowerW
        self.heatingRegionThicknessM = heatingRegionThicknessM
        self.tAmbientK = tAmbientK
        self.gravityMPerS2 = gravityMPerS2
    }

    enum CodingKeys: String, CodingKey {
        case diePowerW = "die_power_w"
        case heatingRegionThicknessM = "heating_region_thickness_m"
        case tAmbientK = "t_ambient_k"
        case gravityMPerS2 = "gravity_m_per_s2"
    }
}

/// The thermal-solve verdict.
public struct ComponentVerifyThermal: Codable, Equatable, Sendable {
    public let tMinK: Double
    public let tMaxK: Double
    public let tMeanK: Double
    public let deltaTK: Double
    public let dofCount: Int

    public init(tMinK: Double, tMaxK: Double, tMeanK: Double,
                deltaTK: Double, dofCount: Int) {
        self.tMinK = tMinK
        self.tMaxK = tMaxK
        self.tMeanK = tMeanK
        self.deltaTK = deltaTK
        self.dofCount = dofCount
    }

    enum CodingKeys: String, CodingKey {
        case tMinK = "t_min_k"
        case tMaxK = "t_max_k"
        case tMeanK = "t_mean_k"
        case deltaTK = "delta_t_k"
        case dofCount = "dof_count"
    }
}

/// The structural-solve verdict.
public struct ComponentVerifyStructural: Codable, Equatable, Sendable {
    public let uMaxM: Double
    public let sigmaVmMaxPa: Double
    public let dofCount: Int

    public init(uMaxM: Double, sigmaVmMaxPa: Double, dofCount: Int) {
        self.uMaxM = uMaxM
        self.sigmaVmMaxPa = sigmaVmMaxPa
        self.dofCount = dofCount
    }

    enum CodingKeys: String, CodingKey {
        case uMaxM = "u_max_m"
        case sigmaVmMaxPa = "sigma_vm_max_pa"
        case dofCount = "dof_count"
    }
}

/// One row of the flat measurement table — the CSV-friendly view. Kept
/// alongside the structured thermal/structural blocks so a downstream
/// consumer can choose either.
public struct ComponentVerifyRow: Codable, Equatable, Sendable {
    public let measurementKey: String
    public let value: Double
    public let unit: String

    public init(measurementKey: String, value: Double, unit: String) {
        self.measurementKey = measurementKey
        self.value = value
        self.unit = unit
    }

    enum CodingKeys: String, CodingKey {
        case measurementKey = "measurement_key"
        case value
        case unit
    }
}

/// The headline measurements — thermal + structural verdicts plus the
/// flat row table for human-readable presentation.
public struct ComponentVerifyMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    public let table: [ComponentVerifyRow]
    public let thermal: ComponentVerifyThermal
    public let structural: ComponentVerifyStructural

    public init(rows: Int, table: [ComponentVerifyRow],
                thermal: ComponentVerifyThermal,
                structural: ComponentVerifyStructural) {
        self.rows = rows
        self.table = table
        self.thermal = thermal
        self.structural = structural
    }
}

/// A component-verify record (D66 / κ-39). Captures the toy
/// die-proxy thermal + structural verdict with the gmsh / scikit-fem
/// library pin so cross-host drift (different versions) is visible.
public struct ComponentVerifyRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let fingerprint: String
    public let gmshVersion: String
    public let skfemVersion: String
    public let pythonVersion: String
    public let geometry: ComponentVerifyGeometry
    public let material: ComponentVerifyMaterial
    public let load: ComponentVerifyLoad
    public let measurements: ComponentVerifyMeasurements
    /// Artifact files (relative to `exports/component/verify/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: ComponentVerifyProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, fingerprint: String,
                gmshVersion: String, skfemVersion: String,
                pythonVersion: String,
                geometry: ComponentVerifyGeometry,
                material: ComponentVerifyMaterial,
                load: ComponentVerifyLoad,
                measurements: ComponentVerifyMeasurements,
                artifacts: [String: String],
                provenance: ComponentVerifyProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.fingerprint = fingerprint
        self.gmshVersion = gmshVersion
        self.skfemVersion = skfemVersion
        self.pythonVersion = pythonVersion
        self.geometry = geometry
        self.material = material
        self.load = load
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
        case gmshVersion = "gmsh_version"
        case skfemVersion = "skfem_version"
        case pythonVersion = "python_version"
        case geometry
        case material
        case load
        case measurements
        case artifacts
        case provenance
    }
}
