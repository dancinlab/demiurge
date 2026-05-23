// RtscVerifyRecord — rtsc + verify (5-axis cell: solenoid · HTS REBCO ·
// GetDP/scipy · verify · magstat_a_axisym_linear). SSOT:
// ~/core/hexa-lang/stdlib/rtsc/getdp_hts.py. RTSC.md §4 documents the
// axis taxonomy this schema embeds. g3: GATE_OPEN / absorbed=false;
// FEM stage may be install-gated when getdp is missing — the
// closed-form (Lorenz/Wheeler) verifier always runs.

import Foundation

public struct RtscVerifyRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let skippedReason: String?
    public let kernelNote: String?
    public let gateType: String?
    public let provisional: Bool?

    // 5-axis tag (RTSC.md §2)
    public let axes: Axes?
    // Parametric geometry the producer fed into both verifiers
    public let geometry: Geometry?
    // Single source of truth for "what to render in the cockpit headline"
    public let headline: Headline?
    // Per-verifier breakdown
    public let closedForm: ClosedForm?
    public let fem: FEM?
    public let crossCheck: CrossCheck?

    public struct Axes: Codable, Equatable, Sendable {
        public let device: String
        public let conductor: String
        public let solver: String
        public let verb: String
        public let formulation: String
    }

    public struct Geometry: Codable, Equatable, Sendable {
        public let lengthM: Double
        public let innerRadiusM: Double
        public let outerRadiusM: Double
        public let turns: Int
        public let currentA: Double
        public let jPhiAPerM2: Double

        enum CodingKeys: String, CodingKey {
            case lengthM = "length_m"
            case innerRadiusM = "inner_radius_m"
            case outerRadiusM = "outer_radius_m"
            case turns
            case currentA = "current_A"
            case jPhiAPerM2 = "j_phi_A_per_m2"
        }
    }

    public struct Headline: Codable, Equatable, Sendable {
        public let bCenterT: Double?
        public let bMaxOnAxisT: Double?
        public let inductanceH: Double?
        public let storedEnergyJ: Double?

        enum CodingKeys: String, CodingKey {
            case bCenterT = "B_center_T"
            case bMaxOnAxisT = "B_max_on_axis_T"
            case inductanceH = "inductance_H"
            case storedEnergyJ = "stored_energy_J"
        }
    }

    public struct ClosedForm: Codable, Equatable, Sendable {
        public let bCenterT: Double?
        public let bMaxOnAxisT: Double?
        public let inductanceH: Double?
        public let storedEnergyJ: Double?
        public let formula: String?

        enum CodingKeys: String, CodingKey {
            case bCenterT = "B_center_T"
            case bMaxOnAxisT = "B_max_on_axis_T"
            case inductanceH = "inductance_H"
            case storedEnergyJ = "stored_energy_J"
            case formula
        }
    }

    public struct FEM: Codable, Equatable, Sendable {
        public let bCenterT: Double?
        public let bzCenterT: Double?
        public let bMaxOnAxisT: Double?
        public let storedEnergyJ: Double?
        public let inductanceH: Double?
        public let solver: String?
        public let mesher: String?
        public let formulation: String?
        public let skippedReason: String?
        public let gmshPath: String?
        public let getdpPath: String?

        enum CodingKeys: String, CodingKey {
            case bCenterT = "B_center_T"
            case bzCenterT = "Bz_center_T"
            case bMaxOnAxisT = "B_max_on_axis_T"
            case storedEnergyJ = "stored_energy_J"
            case inductanceH = "inductance_H"
            case solver, mesher, formulation
            case skippedReason = "skipped_reason"
            case gmshPath = "gmsh_path"
            case getdpPath = "getdp_path"
        }
    }

    public struct CrossCheck: Codable, Equatable, Sendable {
        public let bCenterClosedFormT: Double?
        public let bCenterFemT: Double?
        public let relDelta: Double?
        public let relDeltaPct: Double?
        public let lClosedFormH: Double?
        public let lFemH: Double?
        public let lRelDeltaPct: Double?

        enum CodingKeys: String, CodingKey {
            case bCenterClosedFormT = "B_center_closed_form_T"
            case bCenterFemT = "B_center_fem_T"
            case relDelta = "rel_delta"
            case relDeltaPct = "rel_delta_pct"
            case lClosedFormH = "L_closed_form_H"
            case lFemH = "L_fem_H"
            case lRelDeltaPct = "L_rel_delta_pct"
        }
    }

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case kernelNote = "kernel_note"
        case gateType = "gate_type"
        case provisional
        case axes, geometry, headline
        case closedForm = "closed_form"
        case fem
        case crossCheck = "cross_check"
    }
}
