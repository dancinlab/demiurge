// RtscAnalyzeRecord — rtsc + analyze producer (pyfemm 2-D magnetics).
//
// Typed sidecar for `rtsc + analyze` (ROI rank 10, ⭐⭐⭐⭐) — the FIRST
// producer in the rtsc domain (whole domain 0-producer before this).
// Producer = `~/core/hexa-lang/stdlib/rtsc/pyfemm_magnetics.py` — pyfemm
// drives FEMM (D. Meeker) for 2-D axisymmetric HTS coil B-field maps.
// Citations: arxiv:0811.2883, FEMM 4.2 manual, HTS Modelling Workgroup.
// Existing handoff: `inbox/notes/cohort-pickup-rtsc-femm-producer.md`.
//
// D61: substrate SSOT in hexa-lang/stdlib/, demiurge witnesses only.
// D72: FEMM has its own ecosystem (NOT skfem); stays in rtsc adapter.
//      Promote to kernels/em_2d/ at 2nd consumer.
// g3:  GATE_OPEN / absorbed=false always — placeholder HTS-tape proxy,
//      no calibrated J_c(B,T,θ). macOS honest-skip (FEMM is Windows
//      binary; Wine-only on macOS). Linux pool only.

import Foundation

public struct RtscAnalyzeHeadline: Codable, Equatable, Sendable {
    public let bMagnitudeTAtCentreOfProxyTape: Double?

    enum CodingKeys: String, CodingKey {
        case bMagnitudeTAtCentreOfProxyTape = "b_magnitude_T_at_centre_of_proxy_tape"
    }
}

public struct RtscAnalyzeRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let platform: String?
    public let skippedReason: String?
    public let headline: RtscAnalyzeHeadline?

    enum CodingKeys: String, CodingKey {
        case domain
        case verb
        case kind
        case stamp
        case producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case platform
        case skippedReason = "skipped_reason"
        case headline
    }
}
