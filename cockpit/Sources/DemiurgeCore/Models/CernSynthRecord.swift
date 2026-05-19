// CernSynthRecord — cern + synthesize producer (Xsuite optics matching).
//
// Typed sidecar for `cern + synthesize` (ROI rank 7, ⭐⭐⭐⭐).
// Producer = `~/core/hexa-lang/stdlib/cern/xsuite_optics.py` — Xsuite
// (CERN OSS pure-Python beam-physics framework) FODO twiss + tune fit.
// Citations: arxiv:2310.00317 (Xsuite), arxiv:2412.16006 (MAD-NG).
//
// D61: substrate SSOT in hexa-lang/stdlib/, demiurge witnesses only.
// D72: accelerator optics single-domain today; promote to
//      kernels/accelerator_optics/ at 2nd consumer.
// g3:  GATE_OPEN / absorbed=false always — textbook FODO parameters,
//      no real lattice or measured beam. Honest skip on ImportError.

import Foundation

public struct CernSynthHeadline: Codable, Equatable, Sendable {
    public let betaXMaxM: Double?
    public let qXTune: Double?
    public let p0cGeV: Double?
    public let particle: String?

    enum CodingKeys: String, CodingKey {
        case betaXMaxM = "beta_x_max_m"
        case qXTune = "q_x_tune"
        case p0cGeV = "p0c_GeV"
        case particle
    }
}

public struct CernSynthRecord: Codable, Equatable, Sendable {
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
    public let headline: CernSynthHeadline?

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
        case skippedReason = "skipped_reason"
        case headline
    }
}
