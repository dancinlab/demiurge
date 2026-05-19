// BotSynthRecord — bot + synthesize producer record (ROI rank 9, ⭐⭐⭐⭐
// per absorption-empty-cells-research-2026-05-20.md §3).
//
// Typed sidecar for a `bot + synthesize` producer run — Pinocchio
// (stack-of-tasks SSOT) rigid-body dynamics + analytic derivatives on
// the same hermetic 2-link revolute arm that bot+structure uses (κ-37
// / D58, urdfpy_basics.py). Cross-cell parity is witnessed by the
// urdf_sha256_16 hash being byte-identical to the bot+structure record.
//
// The producer = `~/core/hexa-lang/stdlib/bot/pinocchio_rbd.py` (D61
// substrate SSOT — Swift NEVER points to cockpit/scripts/*). The
// Python side runs Pinocchio's analytic Featherstone-style algorithms:
//   • forwardKinematics  → end-effector frame pose (oMf[ee_link])
//   • computeJointJacobians + getFrameJacobian (LOCAL_WORLD_ALIGNED)
//     → 6×nv analytic Jacobian
//   • rnea  → inverse-dynamics joint torque tau = M(q)·a + C(q,v)·v + g(q)
//   • crba  → mass matrix M(q)
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / FusionRecord /
// BotRecord / ComponentRecord): producer pinned to the library identity,
// measurement_gate honest, scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "pinocchio@<ver> (open-loop torque eval, no contact /
//     dynamic stability check)" — pin the library AND the scope. The
//     RNEA / CRBA / Jacobian outputs ARE real — Featherstone algebra is
//     mathematical fact given the URDF spatial inertias. BUT this slice
//     omits:
//       – contact forces (no Drake contact-implicit, no Gazebo regression)
//       – payload (no end-effector tool inertia)
//       – joint friction / actuator dynamics (no motor model)
//       – dynamic stability check (Lyapunov / SOS — Drake territory,
//         ROI rank 13 deferred this round)
//       – ros2_control HIL, ISO 10218 / 13482 risk assessment
//     So:
//       measurement_gate = GATE_OPEN
//       absorbed         = false
//     ALWAYS. There is no path here that flips them — that requires the
//     bot+verify cell (Drake/Gazebo, ROI rank 13, NOT this session).
//   • The URDF is the same self-generated hermetic 2-link arm as
//     bot+structure — no UR5 / Franka manufacturer datasheet, no
//     bench-validated mass matrix. domains/bot.md §1: the full bot
//     deliverable = URDF + actuator/sensor + controller + safety
//     analysis; this producer covers ONE leaf (analytic inverse dynamics)
//     of the URDF/RBD branch.
//   • absorbed=true is forbidden by construction — same BANNED-absorbed
//     stance as SSCB κ-34 / bot+structure / fusion κ-41.

import Foundation

/// Provenance for a `BotSynthRecord` — mirrors `BotProvenance` /
/// `FusionProvenance` / `SSCBProvenance` (same absorbed +
/// measurementGate + caveats discipline; producer points to the
/// `pinocchio` Python package, not a real robot platform).
public struct BotSynthProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g.
    /// "pinocchio@3.9.0 (open-loop torque eval)" — library identity
    /// + scope, NOT robot-platform identity (g3).
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let scopeCaveats: [String]
    /// Citation for the substrate SSOT (stack-of-tasks/pinocchio per the
    /// research note — no arxiv mandatory for bot synth, the library is
    /// the citation).
    public let citations: [String]

    public init(absorbed: Bool, producer: String,
                measurementGate: F1F2Record.MeasurementGate,
                scopeCaveats: [String],
                citations: [String]) {
        self.absorbed = absorbed
        self.producer = producer
        self.measurementGate = measurementGate
        self.scopeCaveats = scopeCaveats
        self.citations = citations
    }

    enum CodingKeys: String, CodingKey {
        case absorbed
        case producer
        case measurementGate = "measurement_gate"
        case scopeCaveats = "scope_caveats"
        case citations
    }
}

/// Sample configuration (joint q, v, a) at which the analytic RBD
/// quantities are evaluated. Honest g3: the *configuration* is real but
/// arbitrary — no trajectory optimization, no contact, single static
/// point. The Pinocchio outputs at that point are mathematical facts.
public struct BotSynthScenario: Codable, Equatable, Sendable {
    public let name: String
    public let kind: String
    public let source: String
    public let endEffectorFrame: String
    /// Joint position vector [rad] — length = nv = actuated joints.
    public let qRad: [Double]
    /// Joint velocity vector [rad/s].
    public let vRadS: [Double]
    /// Joint acceleration vector [rad/s²].
    public let aRadS2: [Double]

    public init(name: String, kind: String, source: String,
                endEffectorFrame: String,
                qRad: [Double], vRadS: [Double], aRadS2: [Double]) {
        self.name = name
        self.kind = kind
        self.source = source
        self.endEffectorFrame = endEffectorFrame
        self.qRad = qRad
        self.vRadS = vRadS
        self.aRadS2 = aRadS2
    }

    enum CodingKeys: String, CodingKey {
        case name
        case kind
        case source
        case endEffectorFrame = "end_effector_frame"
        case qRad = "q_rad"
        case vRadS = "v_rad_s"
        case aRadS2 = "a_rad_s2"
    }
}

/// Headline analytic-RBD outputs extracted from Pinocchio for the sample
/// scenario. The full per-step record (`<geom>.rbd.json`) carries the
/// 6×nv Jacobian and nv×nv mass matrix verbatim — this struct echoes
/// the engineering-meaningful scalars for fast cross-host parity.
public struct BotSynthMeasurements: Codable, Equatable, Sendable {
    /// Number of generalized coordinates (model.nq).
    public let nq: Int
    /// Number of velocity coordinates (model.nv = actuated joints).
    public let nv: Int
    /// Joint names in Pinocchio model order — first is `universe`,
    /// remainder are actuated.
    public let actuatedJoints: [String]
    /// End-effector translation in world frame [m] (oMf[ee_link]).
    public let eeTranslationM: [Double]?
    /// Inverse-dynamics joint torque tau = M(q)·a + C(q,v)·v + g(q) [Nm].
    public let tauRneaNm: [Double]?
    /// Gravity-only joint torque g(q) = rnea(q, 0, 0) [Nm].
    public let gravityTorqueNm: [Double]?
    /// Analytic frame Jacobian J(q) in LOCAL_WORLD_ALIGNED convention,
    /// 6×nv (rows: vx vy vz wx wy wz; cols: per joint).
    public let jacobian6xNv: [[Double]]?
    /// Mass matrix M(q) from CRBA, nv×nv (symmetrized).
    public let massMatrixCrbaNvxNv: [[Double]]?

    public init(nq: Int, nv: Int, actuatedJoints: [String],
                eeTranslationM: [Double]?, tauRneaNm: [Double]?,
                gravityTorqueNm: [Double]?,
                jacobian6xNv: [[Double]]?,
                massMatrixCrbaNvxNv: [[Double]]?) {
        self.nq = nq
        self.nv = nv
        self.actuatedJoints = actuatedJoints
        self.eeTranslationM = eeTranslationM
        self.tauRneaNm = tauRneaNm
        self.gravityTorqueNm = gravityTorqueNm
        self.jacobian6xNv = jacobian6xNv
        self.massMatrixCrbaNvxNv = massMatrixCrbaNvxNv
    }

    enum CodingKeys: String, CodingKey {
        case nq
        case nv
        case actuatedJoints = "actuated_joints"
        case eeTranslationM = "ee_translation_m"
        case tauRneaNm = "tau_rnea_Nm"
        case gravityTorqueNm = "gravity_torque_Nm"
        case jacobian6xNv = "jacobian_6xnv"
        case massMatrixCrbaNvxNv = "mass_matrix_crba_nvxnv"
    }
}

/// A `bot + synthesize` Pinocchio analytic-RBD record. Captures the
/// hermetic-arm URDF identity (sha256_16 = cross-cell parity witness),
/// the sample (q, v, a) scenario, and the headline analytic outputs
/// (RNEA torque, gravity torque, Jacobian, mass matrix). Provenance
/// pins the producer library version + Python version so cross-host
/// drift is visible.
public struct BotSynthRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let urdfSha256_16: String
    public let pinocchioVersion: String
    public let pythonVersion: String
    public let scenario: BotSynthScenario
    public let measurements: BotSynthMeasurements
    /// Artifact files (relative to `exports/bot/synthesize/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: BotSynthProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, urdfSha256_16: String,
                pinocchioVersion: String, pythonVersion: String,
                scenario: BotSynthScenario,
                measurements: BotSynthMeasurements,
                artifacts: [String: String],
                provenance: BotSynthProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.urdfSha256_16 = urdfSha256_16
        self.pinocchioVersion = pinocchioVersion
        self.pythonVersion = pythonVersion
        self.scenario = scenario
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
        case pinocchioVersion = "pinocchio_version"
        case pythonVersion = "python_version"
        case scenario
        case measurements
        case artifacts
        case provenance
    }
}
