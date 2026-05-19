// SSCBRecord — phase κ-34 (P-⑧ cohort producer prototype, D55).
//
// Typed sidecar for a `sscb + analyze` producer run — the FIRST cohort
// domain (out of the 13 surveyed in domains/*.md) wired to a real
// measuring engine tool. ngspice 46 is the producer; demiurge spawns
// it and persists the measurements as a typed record.
//
// rfc_002 §4 F1F2-style discipline (mirror MatterRecord / ComponentRecord
// / F1F2Record): producer pinned to the binary identity, measurement_gate
// honest, scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "ngspice@46" — pin the binary, not the *device model*.
//     The simulated SiC switch is plausible (Ron=20mΩ, Roff=1GΩ) not
//     pulled from a Wolfspeed C3M0021120K datasheet. measurement_gate
//     stays GATE_OPEN until a real validated device .lib is wired in.
//   • absorbed = false — ALWAYS. The numbers are "real" (ngspice's
//     IEEE-754 transient solver computed them) but the *circuit* is
//     not absorbed from a bench measurement. Same BANNED-absorbed
//     stance as yosys chip-synth (rfc_006 §5 gate OPEN) and FreeCAD
//     component-synth (D54 GATE_OPEN).
//   • scope_caveats records that the netlist is plausible-not-datasheet,
//     that the 100 nF/5 Ω snubber is generic-not-engineered, and that
//     the interrupt_ratio outcome (~0.35 at t=1.5 µs) FAILS the
//     HEXA-SSCB mk1 ≤ 1 µs target — surfaced honestly, NOT hidden.

import Foundation

/// Provenance for a `SSCBRecord` — mirrors ComponentProvenance /
/// MatterProvenance (same absorbed + measurementGate + caveats
/// discipline; producer points to ngspice not demiurge).
public struct SSCBProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "ngspice@46" (binary identity, not
    /// device-model identity — g3).
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

/// Topology parameters echoed from the producer netlist — kept on the
/// record so a downstream sweep can compare circuit configurations.
public struct SSCBTopology: Codable, Equatable, Sendable {
    public let vDcV: Double
    public let rLoadOhm: Double
    public let lBusH: Double
    public let switchRonOhm: Double
    public let switchRoffOhm: Double
    public let snubberCF: Double
    public let snubberROhm: Double
    public let tripTimeS: Double
    public let simTimeS: Double
    public let stepS: Double

    enum CodingKeys: String, CodingKey {
        case vDcV = "v_dc_V"
        case rLoadOhm = "r_load_ohm"
        case lBusH = "l_bus_H"
        case switchRonOhm = "switch_ron_ohm"
        case switchRoffOhm = "switch_roff_ohm"
        case snubberCF = "snubber_C_F"
        case snubberROhm = "snubber_R_ohm"
        case tripTimeS = "trip_time_s"
        case simTimeS = "sim_time_s"
        case stepS = "step_s"
    }
}

/// The headline measurements extracted from the transient — these
/// ARE the real numbers (ngspice's IEEE-754 output). The honesty
/// gate is on the *circuit*, not the *measurement*.
public struct SSCBMeasurements: Codable, Equatable, Sendable {
    public let rows: Int
    /// Voltage across the switch pre-trip (≈ I·Ron, ~2 V expected).
    public let vSwPreTripV: Double?
    public let vSwPeakV: Double?
    public let vSwPostTripV: Double?
    public let iLoadPreTripA: Double?
    public let iLoadPeakA: Double?
    public let iLoadPostTripA: Double?
    /// 10→90% rise on v_sw — IS the "speed of interruption" figure-
    /// of-merit. HEXA-SSCB mk1 target ≤ 1 µs (domains/sscb.md §1).
    public let riseTimeS: Double?
    /// i_post / i_pre — how much current is left flowing after trip.
    /// 0.0 = perfect interruption; 1.0 = no interruption.
    public let interruptRatio: Double?

    enum CodingKeys: String, CodingKey {
        case rows
        case vSwPreTripV = "v_sw_pre_trip_V"
        case vSwPeakV = "v_sw_peak_V"
        case vSwPostTripV = "v_sw_post_trip_V"
        case iLoadPreTripA = "i_load_pre_trip_A"
        case iLoadPeakA = "i_load_peak_A"
        case iLoadPostTripA = "i_load_post_trip_A"
        case riseTimeS = "rise_time_s"
        case interruptRatio = "interrupt_ratio"
    }
}

/// A SSCB transient-analyze record (D55 / κ-34). Captures the headline
/// measurements from `ngspice -b sscb_v1.cir` plus the netlist hash and
/// topology so cross-host drift is visible.
public struct SSCBRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let netlistSha256_16: String
    public let ngspiceVersion: String
    public let ngspiceExit: Int
    public let topology: SSCBTopology
    public let measurements: SSCBMeasurements
    /// Artifact files (relative to `exports/sscb/transient/`).
    public let artifacts: [String: String]
    public let provenance: SSCBProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, netlistSha256_16: String,
                ngspiceVersion: String, ngspiceExit: Int,
                topology: SSCBTopology,
                measurements: SSCBMeasurements,
                artifacts: [String: String],
                provenance: SSCBProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.netlistSha256_16 = netlistSha256_16
        self.ngspiceVersion = ngspiceVersion
        self.ngspiceExit = ngspiceExit
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
        case topology
        case measurements
        case artifacts
        case provenance
    }
}
