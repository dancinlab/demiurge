// AuraRecord — phase κ-35 (D67-track cohort producer · second after D55).
//
// Typed sidecar for an `aura + analyze` producer run — MNE-Python (BSD,
// stsci) computes deterministic band-power + mains-rejection metrics
// from a *synthesized* EEG epoch. Demiurge spawns the producer
// (`~/core/hexa-lang/stdlib/aura/aura_mne.py` — D61 SSOT relocation,
// new producers under hexa-lang/stdlib/<domain>/) and persists the
// numbers as a typed record.
//
// rfc_002 §4 F1F2-style discipline (mirror SSCBRecord / MatterRecord /
// ComponentRecord / F1F2Record): producer pinned to the library
// version, measurement_gate honest, scope_caveats embedded.
//
// HONESTY (g3 — non-negotiable):
//   • producer = "mne@<version>" — pin the library, not the *subject*.
//     The EEG signal is *synthesized* (alpha sinusoid + pink noise +
//     mains hum) with a fixed RNG seed; there is no subject, no
//     electrode, no clinical recording. MNE's Welch PSD IS the math
//     instrument and the numbers are real, but the substrate is
//     plausible-not-absorbed.
//   • absorbed = false — ALWAYS. Real absorption would require a
//     pinned public dataset (e.g. PhysioNet EEG Motor Movement /
//     Imagery, commit-hash anchored) + spectrum-match within ±X dB,
//     plus IRB if any human data ever enters the loop.
//   • The Sim4Life MRI-safety gap (domains/aura.md §4) is orthogonal
//     — MNE is signal processing, not EM/SAR simulation.

import Foundation

/// Provenance for an `AuraRecord` — same shape as SSCBProvenance, just
/// pointing at the MNE library instead of ngspice.
public struct AuraProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. `"mne@1.12.1"`.
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

/// Stimulus parameters echoed from the producer — drift sentinel.
public struct AuraStimulus: Codable, Equatable, Sendable {
    public let sfreqHz: Double
    public let durationS: Double
    public let nChannels: Int
    public let channelNames: [String]
    public let rngSeed: Int
    public let alphaHz: Double
    public let alphaAmpUv: Double
    public let mainsHz: Double
    public let mainsAmpUv: Double
    public let pinkAmpUv: Double

    enum CodingKeys: String, CodingKey {
        case sfreqHz = "sfreq_hz"
        case durationS = "duration_s"
        case nChannels = "n_channels"
        case channelNames = "channel_names"
        case rngSeed = "rng_seed"
        case alphaHz = "alpha_hz"
        case alphaAmpUv = "alpha_amp_uV"
        case mainsHz = "mains_hz"
        case mainsAmpUv = "mains_amp_uV"
        case pinkAmpUv = "pink_amp_uV"
    }
}

/// Headline measurements from the Welch PSD — real numbers, deterministic
/// (no random tapers). All powers in V² (band-integrated PSD).
public struct AuraMeasurements: Codable, Equatable, Sendable {
    public let nChannels: Int
    public let nFreqs: Int
    public let freqMinHz: Double
    public let freqMaxHz: Double
    /// Band names ("delta" / "theta" / "alpha" / "beta" / "gamma") →
    /// grand-average power across channels (V²).
    public let bandPowerGrandAvgV2: [String: Double]
    /// 60 Hz mains line power / median 1-49 Hz baseline.
    public let mains60HzRatio: Double?
    public let mains60HzDb: Double?

    enum CodingKeys: String, CodingKey {
        case nChannels = "n_channels"
        case nFreqs = "n_freqs"
        case freqMinHz = "freq_min_hz"
        case freqMaxHz = "freq_max_hz"
        case bandPowerGrandAvgV2 = "band_power_grand_avg_v2"
        case mains60HzRatio = "mains_60_hz_ratio"
        case mains60HzDb = "mains_60_hz_db"
    }
}

/// An aura EEG-analyze record (D67 / κ-35). Captures the MNE-Python
/// Welch PSD measurements of the synthesized EEG epoch plus the signal
/// hash + stimulus params so cross-host drift is visible.
public struct AuraRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let geometryId: String
    public let signalSha256_16: String
    public let mneVersion: String
    public let stimulus: AuraStimulus
    public let measurements: AuraMeasurements
    /// Artifact files (relative to `exports/aura/eeg/<stamp>/`).
    public let artifacts: [String: String]
    public let provenance: AuraProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                geometryId: String, signalSha256_16: String,
                mneVersion: String, stimulus: AuraStimulus,
                measurements: AuraMeasurements,
                artifacts: [String: String],
                provenance: AuraProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.geometryId = geometryId
        self.signalSha256_16 = signalSha256_16
        self.mneVersion = mneVersion
        self.stimulus = stimulus
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
        case signalSha256_16 = "signal_sha256_16"
        case mneVersion = "mne_version"
        case stimulus
        case measurements
        case artifacts
        case provenance
    }
}
