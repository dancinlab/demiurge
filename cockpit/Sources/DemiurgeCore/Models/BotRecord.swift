// BotRecord — phase κ-37 (P-⑧ third cohort producer, D58).
//
// Typed sidecar for a `bot + structure` producer run — the THIRD cohort
// domain (out of the 13 surveyed in domains/*.md) wired to a real
// measuring engine tool, after sscb κ-34 (ngspice 46) + grid (NetworkX,
// pickup #1, separate worktree). yourdfpy 0.0.60 is the producer;
// demiurge spawns it and persists the URDF spec metadata as a typed
// record.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / MatterRecord /
// ComponentRecord): producer pinned to the python package version,
// measurement_gate honest, scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "yourdfpy@<version>" — pins the python library, NOT
//     a real robot platform. The URDF is a hermetic self-generated
//     2-link revolute arm (no UR5/Franka manufacturer datasheet, no
//     bench-validated mass matrix). measurement_gate stays GATE_OPEN
//     until a vendor-validated URDF + Drake constrained sim are wired
//     in (BANNED-absorbed stance, same as SSCB κ-34).
//   • absorbed = false — ALWAYS. The numbers (link count = 4, joint
//     count = 3, DOF = 2, total mass = 3.6 kg, bbox = 0.2×0.2×0.7 m)
//     are real measurements of the URDF spec, but the *robot* is
//     not measured (no Gazebo regression, no Drake verification, no
//     ros2_control HIL, no ISO 10218 risk-assessment).
//   • urdfpy was the original target — it is deprecated / abandoned;
//     we fell back to its maintained successor yourdfpy per the
//     cohort-pickup note. The script will hard-fail with an honest
//     gap line if neither is importable.
//   • The 2-link arm is *URDF spec metadata*, not a robot.
//     domains/bot.md §1 calls out the full bot deliverable = URDF
//     + actuator/sensor selection + controller architecture + safety
//     analysis (ISO 10218 / 13482 / IEC 61131-3). This producer
//     covers ONE leaf of that tree (the URDF parse leaf), honestly.

import Foundation

/// Provenance for a `BotRecord` — mirrors `SSCBProvenance` /
/// `MatterProvenance` / `ComponentProvenance` (same absorbed +
/// measurementGate + caveats discipline; producer points to yourdfpy
/// not demiurge).
public struct BotProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "yourdfpy@0.0.60" (binary identity,
    /// not robot-platform identity — g3).
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

/// URDF spec topology echoed from the producer — kept on the record so
/// a downstream sweep can compare different URDFs (e.g. UR5 vs Franka
/// vs this hermetic 2-link arm) without re-parsing.
public struct BotTopology: Codable, Equatable, Sendable {
    /// `<robot name="…">` attribute (URDF root).
    public let robotName: String
    /// Coarse class — `2_link_revolute_arm`, `humanoid`, `manipulator`, …
    public let kind: String
    /// Source provenance — `self_generated_hermetic`, `vendor_datasheet`,
    /// `ros_industrial_universal_robot`, … (honest g3 pin).
    public let source: String

    enum CodingKeys: String, CodingKey {
        case robotName = "robot_name"
        case kind
        case source
    }
}

/// URDF spec measurements — the real numbers (yourdfpy parses XML,
/// trimesh computes bounds). Honesty gate is on the *robot*, not the
/// *measurement*.
public struct BotMeasurements: Codable, Equatable, Sendable {
    public let linkCount: Int
    public let jointCount: Int
    /// Joint count keyed by URDF joint type: `revolute` / `fixed` /
    /// `prismatic` / `continuous` / `floating` / `planar`.
    public let jointTypes: [String: Int]
    /// Degrees of freedom = actuated joints (yourdfpy's `num_dofs`).
    public let dof: Int
    public let actuatedJointNames: [String]
    /// Sum of all `<inertial><mass>` values, kilograms.
    public let totalMassKg: Double?
    /// Root link of the URDF tree (yourdfpy's `base_link`).
    public let baseLink: String?
    /// Visual scene bounding-box corners (trimesh `scene.bounds`),
    /// metres. `min[3]`, `max[3]`, `size[3] = max - min`.
    public let bboxMinM: [Double]?
    public let bboxMaxM: [Double]?
    public let bboxSizeM: [Double]?

    enum CodingKeys: String, CodingKey {
        case linkCount = "link_count"
        case jointCount = "joint_count"
        case jointTypes = "joint_types"
        case dof
        case actuatedJointNames = "actuated_joint_names"
        case totalMassKg = "total_mass_kg"
        case baseLink = "base_link"
        case bboxMinM = "bbox_min_m"
        case bboxMaxM = "bbox_max_m"
        case bboxSizeM = "bbox_size_m"
    }
}

/// A `bot + structure` URDF-meta record (D58 / κ-37). Captures the
/// headline URDF spec measurements from `yourdfpy.URDF.load(...)` plus
/// the URDF hash and topology so cross-host drift is visible.
public struct BotRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let urdfSha256_16: String
    public let yourdfpyVersion: String
    public let topology: BotTopology
    public let measurements: BotMeasurements
    /// Artifact files (relative to `exports/bot/structure/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: BotProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, urdfSha256_16: String,
                yourdfpyVersion: String,
                topology: BotTopology,
                measurements: BotMeasurements,
                artifacts: [String: String],
                provenance: BotProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.urdfSha256_16 = urdfSha256_16
        self.yourdfpyVersion = yourdfpyVersion
        self.topology = topology
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
        case urdfSha256_16 = "urdf_sha256_16"
        case yourdfpyVersion = "yourdfpy_version"
        case topology
        case measurements
        case artifacts
        case provenance
    }
}
