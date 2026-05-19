// BrainRecord — phase: cohort producer #2 (no standalone PLAN κ /
// D-block — post-merge reconstructed).
//
// Typed sidecar for a `brain + analyze` producer run — the SECOND cohort
// domain wired to a real measuring engine tool (after sscb / ngspice
// D55). Producer = brian2 2.6.0 (single LIF spike-rate). demiurge spawns
// the script that lives in hexa-lang stdlib (`stdlib/brain/lif_brian2.py`)
// per D61 / D17 generalized — the *script* belongs to hexa-lang, the
// *typed pointer* belongs to demiurge.
//
// rfc_002 §4 F1F2-style discipline (mirror MatterRecord / ComponentRecord
// / SSCBRecord): producer pinned to the simulator identity, measurement_gate
// honest, scope_caveats embedded with the record.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "brian2@<version>" — pin the SIMULATOR identity, not
//     a measured neuron. The LIF equation is textbook (Dayan & Abbott)
//     with constant DC drive — no patch-clamp data fit, no Allen Brain
//     Atlas absorption, no compartment model. measurement_gate stays
//     GATE_OPEN ALWAYS for this producer.
//   • absorbed = false — ALWAYS. The numbers (142 Hz tonic firing,
//     CV_ISI ≈ 0) are real (brian2's IEEE-754 integrator) but the model
//     is plausible-not-fitted. Same BANNED-absorbed stance as ngspice
//     sscb (D55), yosys chip-synth (rfc_006 §5), FreeCAD component (D54).
//   • This is ALGORITHM VERIFICATION — does brian2's `exact` integrator
//     produce the textbook firing rate for the textbook drive? — NOT a
//     measurement of any biological brain signal. domains/brain.md §2
//     proprietary gap (Sim4Life MDDT) is untouched.

import Foundation

/// Provenance for a `BrainRecord` — mirrors SSCBProvenance / MatterProvenance
/// (same absorbed + measurementGate + caveats discipline; producer points
/// to brian2 not demiurge).
public struct BrainProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "brian2@2.6.0" (simulator identity, not
    /// a measured neuron — g3).
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

/// Model parameters echoed from the producer — kept on the record so
/// downstream sweeps can compare configurations / detect drift.
public struct BrainModel: Codable, Equatable, Sendable {
    public let kind: String
    public let tauMs: Double
    public let vThreshold: Double
    public let vReset: Double
    public let iDrive: Double
    public let simTimeS: Double
    public let integratorMethod: String
    public let equation: String

    enum CodingKeys: String, CodingKey {
        case kind
        case tauMs = "tau_ms"
        case vThreshold = "v_threshold"
        case vReset = "v_reset"
        case iDrive = "i_drive"
        case simTimeS = "sim_time_s"
        case integratorMethod = "integrator_method"
        case equation
    }
}

/// The headline measurements extracted from the brian2 run — these ARE
/// the real numbers (brian2's IEEE-754 output). The honesty gate is on
/// the *model* (textbook, not fitted), not the *measurement*.
public struct BrainMeasurements: Codable, Equatable, Sendable {
    public let spikeCount: Int
    public let simTimeS: Double
    /// Tonic firing rate (spikes / sim_time_s). The textbook LIF with
    /// I=2, tau=10ms drive should land near 142 Hz (the analytic period
    /// is tau · ln(I / (I - v_thr)) ≈ 7 ms for I=2, v_thr=1).
    public let firingRateHz: Double
    public let meanIsiS: Double?
    /// Coefficient of variation of ISI — deterministic constant drive →
    /// CV ≈ 0 (sanity check that the integrator is not adding noise).
    public let cvIsi: Double?
    public let firstSpikeS: Double?
    public let lastSpikeS: Double?

    enum CodingKeys: String, CodingKey {
        case spikeCount = "spike_count"
        case simTimeS = "sim_time_s"
        case firingRateHz = "firing_rate_hz"
        case meanIsiS = "mean_isi_s"
        case cvIsi = "cv_isi"
        case firstSpikeS = "first_spike_s"
        case lastSpikeS = "last_spike_s"
    }
}

/// A brain analyze record (cohort round, no standalone PLAN κ /
/// D-block — post-merge reconstructed). Captures the headline measurements
/// from `python3 lif_brian2.py` plus the equation hash and model so
/// cross-host drift is visible.
public struct BrainRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let equationSha256_16: String
    public let brian2Version: String
    public let model: BrainModel
    public let measurements: BrainMeasurements
    /// Artifact files (relative to `exports/brain/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: BrainProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, equationSha256_16: String,
                brian2Version: String,
                model: BrainModel,
                measurements: BrainMeasurements,
                artifacts: [String: String],
                provenance: BrainProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.equationSha256_16 = equationSha256_16
        self.brian2Version = brian2Version
        self.model = model
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
        case equationSha256_16 = "equation_sha256_16"
        case brian2Version = "brian2_version"
        case model
        case measurements
        case artifacts
        case provenance
    }
}
