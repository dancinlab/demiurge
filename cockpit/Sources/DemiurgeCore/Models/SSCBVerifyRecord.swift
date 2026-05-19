// SSCBVerifyRecord — `sscb + verify` typed sidecar (D72 / D61).
//
// Mirror of ComponentVerifyRecord pattern (κ-39 / D66) — D61-compliant-
// from-birth producer wraps a hexa-lang-owned Python script
// (`~/core/hexa-lang/stdlib/sscb/ngspice_breaking.py`) that spawns
// ngspice on a bolted-fault breaking-capacity scenario:
//   - HEXA-SSCB mk1 topology (600 V bus, 100 A nominal load)
//   - R_LOAD → R_FAULT = 0.01 Ω bolted short
//   - Protection detection delay t_det = 5 µs
//   - Gate ramp t_open = 50 ns
//   - Sim window 20 µs / 5 ns step (4 000 rows)
//
// Distinct from `sscb + analyze` (SSCBRecord) — analyze runs a normal-
// turn-off hard-switching transient and measures interrupt_ratio.
// VERIFY runs a bolted-fault breaking-capacity scenario and measures
// I_peak / I²t let-through / clearing_energy — the UL 489I-style
// figures-of-merit (domains/sscb.md §4).
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord /
// ComponentVerifyRecord): producer pinned to the binary identity
// (`ngspice@<v>`), measurement_gate honest, scope_caveats embedded
// with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "ngspice@<v>" — pins the simulator binary, NOT the
//     device model. The SiC switch is a generic R_on/R_off model,
//     NOT a Wolfspeed C3M0021120K .lib. The snubber is generic
//     (100 nF / 5 Ω), NOT engineered for this fault current.
//   • OpenFOAM thermal-margin check is INTENTIONALLY skipped — see
//     the absorption-empty-cells research note 2026-05-20:
//     "OpenFOAM thermal margin is heavy → skip with handoff note".
//     scope_caveats record this gap; no silent thermal claim.
//   • UL 489I certification is an accredited-lab type-test, NOT a
//     SPICE simulation. The producer's verdict is a *first honest
//     witness* of the breaking-capacity envelope, NOT a regulatory
//     verify.
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS.
//     There is no path here that flips them — absorbed=true requires
//     (Wolfspeed C3M0021120K-class .lib · bench-validated load ·
//     DEVSIM TCAD coupling · measured stray-inductance · OpenFOAM
//     thermal · UL 489I type-test).

import Foundation

/// Provenance for a `SSCBVerifyRecord`.
public struct SSCBVerifyProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "ngspice@46" — binary identity, NOT
    /// device-model identity (g3).
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let scopeCaveats: [String]
    /// Clean-room citations (DEVSIM JOSS doi:10.21105/joss.03898;
    /// arxiv:2504.00214 SEMIDV; ngspice manual; etc.).
    public let citations: [String]

    public init(absorbed: Bool, producer: String,
                measurementGate: F1F2Record.MeasurementGate,
                scopeCaveats: [String], citations: [String]) {
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

/// Bolted-fault topology parameters echoed from the producer netlist.
public struct SSCBVerifyTopology: Codable, Equatable, Sendable {
    public let vDcV: Double
    public let rFaultOhm: Double
    public let lBusH: Double
    public let switchRonOhm: Double
    public let switchRoffOhm: Double
    public let snubberCF: Double
    public let snubberROhm: Double
    public let tDetectionS: Double
    public let tOpenRampS: Double
    public let simTimeS: Double
    public let stepS: Double

    enum CodingKeys: String, CodingKey {
        case vDcV = "v_dc_V"
        case rFaultOhm = "r_fault_ohm"
        case lBusH = "l_bus_H"
        case switchRonOhm = "switch_ron_ohm"
        case switchRoffOhm = "switch_roff_ohm"
        case snubberCF = "snubber_C_F"
        case snubberROhm = "snubber_R_ohm"
        case tDetectionS = "t_detection_s"
        case tOpenRampS = "t_open_ramp_s"
        case simTimeS = "sim_time_s"
        case stepS = "step_s"
    }
}

/// Headline breaking-capacity measurements.
public struct SSCBVerifyMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    /// Peak prospective fault current.
    public let iPeakA: Double?
    /// Residual current after the breaker has cleared (within window).
    public let iPostClearA: Double?
    /// Time from gate-open command to i < 1% I_peak (seconds).
    public let tClearS: Double?
    /// Let-through I²t over the clearing interval (A²·s) —
    /// the UL 489I-style energy-let-through figure-of-merit.
    public let letThroughI2tA2s: Double?
    /// Clearing energy = ∫ v_sw · i dt over the clearing interval.
    public let clearingEnergyJ: Double?
    /// Peak voltage across the switch during clearing — flags the
    /// snubber-vs-stray-inductance overshoot honestly.
    public let vSwPeakV: Double?
    /// Did the breaker fully clear within the simulation window?
    public let clearedInWindow: Bool

    enum CodingKeys: String, CodingKey {
        case rows
        case iPeakA = "i_peak_a"
        case iPostClearA = "i_post_clear_a"
        case tClearS = "t_clear_s"
        case letThroughI2tA2s = "let_through_i2t_a2s"
        case clearingEnergyJ = "clearing_energy_j"
        case vSwPeakV = "v_sw_peak_v"
        case clearedInWindow = "cleared_in_window"
    }
}

/// A sscb-verify breaking-capacity record (D72 / κ-N).
public struct SSCBVerifyRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let netlistSha256_16: String
    public let ngspiceVersion: String
    public let ngspiceExit: Int
    public let pythonVersion: String
    public let topology: SSCBVerifyTopology
    public let measurements: SSCBVerifyMeasurements
    /// Artifact files (relative to `exports/sscb/verify/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: SSCBVerifyProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, netlistSha256_16: String,
                ngspiceVersion: String, ngspiceExit: Int,
                pythonVersion: String,
                topology: SSCBVerifyTopology,
                measurements: SSCBVerifyMeasurements,
                artifacts: [String: String],
                provenance: SSCBVerifyProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.netlistSha256_16 = netlistSha256_16
        self.ngspiceVersion = ngspiceVersion
        self.ngspiceExit = ngspiceExit
        self.pythonVersion = pythonVersion
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
        case netlistSha256_16 = "netlist_sha256_16"
        case ngspiceVersion = "ngspice_version"
        case ngspiceExit = "ngspice_exit"
        case pythonVersion = "python_version"
        case topology
        case measurements
        case artifacts
        case provenance
    }
}
