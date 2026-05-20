// EnergyVerifyRecord — energy + verify (OpenMC k-eff, ROI 12).
// SSOT: ~/core/hexa-lang/stdlib/energy/openmc_keff.py. D72: kernels/
// mc_transport/ reuse (3rd consumer — N+M payoff visible). g3:
// GATE_OPEN / absorbed=false; install-gated AND data-gated skip.
//
// D80 (g_hexa_only): also the consumer cell for the solar pilot
// (`stdlib/kernels/solar/solar_kernel.hexa`, 21/21 PASS rel_err<=1e-13
// vs pvlib 0.13.0 — landed on hexa-lang origin/main 2026-05-20). The
// `hexaNativeParity` field below carries that ref when a record is
// emitted from the solar-clearsky path. The k-eff Monte-Carlo path
// continues to leave the ref nil (the substrate kernel is `mc_slab_
// demo.hexa` but the cell's primary path is OpenMC k-eff, not the
// pattern-proof MC kernel).

import Foundation

public struct EnergyVerifyRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    /// Cell-level absorbed flag (LEGACY / measured-oracle dimension —
    /// distinct from `isHexaNativeAbsorbed` below). Producer policy
    /// (D103): a substrate-parity PASS on the linked `hexaNativeParity`
    /// kernel MUST NOT auto-flip this to `true`. Cell-level absorbed
    /// requires a measured oracle for THIS cell's outputs (per-cell
    /// parity round), not substrate kernel parity (D80 honesty floor +
    /// RFC 013 §4.3 substrate-parity ≠ measurement-parity).
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let skippedReason: String?
    public let kernelReuse: String?
    /// D80 — hexa-native parity port pointer (nil = provisional /
    /// no port yet). Populated for the solar-clearsky path; nil for
    /// the OpenMC k-eff path (heavy-port — see
    /// `~/core/demiurge/domains/DEPENDENCIES.demi`
    /// `[domain-energy_openmc_keff]` portable_status = "heavy-port").
    public let hexaNativeParity: HexaNativeParityRef?
    /// D109 (κ-68 G27 land) · RFC 013 §6.11 — external measured-oracle
    /// reference. Energy/solar is the κ-68 first measured-oracle target
    /// (NREL MIDC pyranometer GHI vs hexa-native sun-position-driven
    /// modeled GHI). Independent axis from `hexaNativeParity` above
    /// (D103 dimension-separation). `nil` until the per-cell measured-
    /// oracle round runs; populated by the producer adapter at emit
    /// time. The cell's stored `absorbed` flip remains a SEPARATE
    /// explicit writer action — emitting `measuredOracle` non-nil
    /// does NOT by itself trigger `absorbed = true` (G29 land scope).
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

    /// D95 — derived absorbed flag (computed, NOT stored).
    /// Reflects `hexaNativeParity?.isHexaNativeAbsorbed`; SSOT is
    /// `domains/PILOTS.demi → parity_status` (D86 / D90).
    ///
    /// D103 dimension separation — see `HexaNativeParityRef` (Ufo
    /// VerifyRecord.swift) header for the two-axis policy. This is the
    /// substrate-parity dimension; `absorbed` above is the measured
    /// dimension. Producers set them independently.
    public var isHexaNativeAbsorbed: Bool {
        return hexaNativeParity?.isHexaNativeAbsorbed ?? false
    }
}
