// EnergyWindVerifyRecord — typed Codable for the energy/wind sub-cell verify
//
// κ-71 R10 G40/G41 (design.md D120 + D121) — 4th cell measured-oracle
// flip target. Distinct from `EnergyVerifyRecord` (which carries the
// κ-68 G29 solar first-flip · sun-position axis) so the 4-record-type
// invariant audit exercises a NEW record type (G30 record-type-agnostic
// generalization — strongest evidence yet across Energy/solar ·
// Aura/EEG · Ufo/plasma · Energy/wind).
//
// Bridge stack: `stdlib/kernels/wind/power_curve_kernel.hexa` (IEC
// 61400-12-1 cubic-interp · hexa-lang PR #308 LANDED · cross-impl
// parity verified) + a measured-oracle producer that emits this record.
//
// PREDICTION-shape PASS (D120 contract · D110 G29 mirror · honesty-
// floor re-elevation after κ-69/70 numeric-equivalence rounds): the
// kernel's IEC cubic-interp curve vs an EMPIRICAL manufacturer power
// curve (e.g., Vestas V90-2.0 MW) is an asymmetric oracle producing
// genuine modeling error. mean_rel_err ≤ 0.05 over [4,25] m/s = PASS;
// otherwise honest gap + DEFER flip.

import Foundation

public struct EnergyWindVerifyRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    /// Cell-level absorbed flag (κ-71 G41 measured-oracle flip target).
    /// Producer policy (D103): substrate-parity on `hexaNativeParity`
    /// kernel does NOT auto-flip this. Requires `measuredOracle` non-
    /// nil with mean_rel_err ≤ 0.05 over the operational regime
    /// [v_cut_in, v_cut_out] (D120 PREDICTION-shape).
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let skippedReason: String?
    public let kernelReuse: String?
    /// D80 substrate-parity link (informational · `power_curve_kernel.hexa`
    /// v0.1.0 cross-impl parity confirmed on pool:ubu-2).
    public let hexaNativeParity: HexaNativeParityRef?
    /// D120 (G40 cell-pick) · D121 (G41 first-flip) · RFC 013 §6.11 —
    /// external measured-oracle reference. The empirical turbine power
    /// curve (manufacturer-published OR NREL WTK timeseries when token
    /// available) is the κ-71 fourth cell measured-oracle target. The
    /// cell's stored `absorbed` flip is a SEPARATE explicit writer
    /// action (D119 mirror): emitting `measuredOracle` non-nil does
    /// NOT by itself trigger `absorbed = true`.
    public let measuredOracle: MeasuredOracleRef?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case kernelReuse = "kernel_reuse"
        case hexaNativeParity = "hexa_native_parity"
        case measuredOracle = "measured_oracle"
    }

    public init(
        domain: String = "energy_wind",
        verb: String = "verify",
        kind: String = "energy_wind_verify",
        stamp: String,
        producer: String,
        measurementGate: F1F2Record.MeasurementGate,
        absorbed: Bool,
        scopeCaveats: [String],
        citations: [String],
        skippedReason: String? = nil,
        kernelReuse: String? = nil,
        hexaNativeParity: HexaNativeParityRef? = nil,
        measuredOracle: MeasuredOracleRef? = nil
    ) {
        self.domain = domain
        self.verb = verb
        self.kind = kind
        self.stamp = stamp
        self.producer = producer
        self.measurementGate = measurementGate
        self.absorbed = absorbed
        self.scopeCaveats = scopeCaveats
        self.citations = citations
        self.skippedReason = skippedReason
        self.kernelReuse = kernelReuse
        self.hexaNativeParity = hexaNativeParity
        self.measuredOracle = measuredOracle
    }
}
