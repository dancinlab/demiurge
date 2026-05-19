// ComponentAnalyzeRecord — component + analyze producer (CalculiX FEA).
//
// Typed sidecar for `component + analyze` (ROI rank 6, ⭐⭐⭐⭐).
// Producer = `~/core/hexa-lang/stdlib/component/calculix.py` — CalculiX
// (ccx) 3-D structural/thermomechanical FEA solver. Independent cited
// measurement vs component+verify (gmsh+skfem, κ-44) — different FEM
// backend so the two cells cross-check.
//
// D61: substrate SSOT in hexa-lang/stdlib/, demiurge witnesses only.
// D72: shares mesh primitive with kernels/fem/skfem_kernel.py; full
//      kernels/fem/calculix_kernel.py extraction at 2nd consumer.
// g3:  GATE_OPEN / absorbed=false always — placeholder die geometry,
//      not a measured part. Honest install-gated skip when ccx is
//      missing.

import Foundation

public struct ComponentAnalyzeRecord: Codable, Equatable, Sendable {
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
    public let ccxReturncode: Int?
    public let inpPath: String?

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
        case ccxReturncode = "ccx_returncode"
        case inpPath = "inp_path"
    }
}
