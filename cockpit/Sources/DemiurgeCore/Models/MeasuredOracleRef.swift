// MeasuredOracleRef — D109 (κ-68 G27 land) · RFC 013 §6.11.
//
// SSOT for an external "measured-oracle" parity claim attached to a
// cell record (e.g. EnergyVerifyRecord). Anchors the cell's stored
// `absorbed: Bool` flip to a measured ground-truth comparison (the
// measured dimension of D103 separation), NOT a substrate-kernel
// PASS (which is the substrate-parity dimension carried by
// HexaNativeParityRef).
//
// D103 dimension separation — TWO orthogonal axes on a cell record:
//   1. Substrate kernel parity (`HexaNativeParityRef` · computed
//      `isHexaNativeAbsorbed`). Driven by PILOTS.demi `parity_status`.
//   2. Cell-level measured absorbed (`<Record>.absorbed: Bool`,
//      stored). Driven by THIS struct's PASS gate AND an EXPLICIT
//      writer set — NOT by D95 computed projection.
// Producers MUST set the two axes INDEPENDENTLY (RFC 013 §6.11).
//
// Honesty (D80 g_hexa_only · D106 illustrative-physics 제외):
// emitting this struct non-nil does NOT auto-flip `absorbed` — the
// cell-side stored absorbed is set by an explicit producer/writer
// path that checks `isMeasuredOraclePASS` AND is *not invoked* for
// illustrative-physics cells (Fusion `mc_transport` / `mc_slab_demo`
// 등 — anti-conflation per RFC 013 §6.12).

import Foundation

public struct MeasuredOracleRef: Codable, Sendable, Equatable {

    /// External oracle dataset identifier — citable string.
    /// Example: `"NREL MIDC SRRL Golden CO · pyranometer GHI ·
    /// 2026-05-15 · clear-sky day · 1-min cadence"`.
    public let oracleSource: String

    /// Units of the measured quantity, e.g. `"W/m^2"` for GHI,
    /// `"K"` for temperature, `"1"` for dimensionless.
    public let unit: String

    /// Number of paired (measured, modeled) samples that contributed
    /// to the parity statistics below.
    public let sampleCount: Int

    /// Mean relative error |measured - modeled| / |measured| over the
    /// `sampleCount` samples. The producer's primary PASS gate is
    /// computed against this value.
    public let meanRelErr: Double

    /// Worst-case (max) relative error in the sample window. `nil`
    /// when the producer reports summary stats only.
    public let maxRelErr: Double?

    /// PASS threshold (relative error bound) the producer applied
    /// to `meanRelErr`. The cell-side `absorbed` flip happens at
    /// writer time when `meanRelErr <= threshold` AND any additional
    /// dataset caveats permit.
    public let threshold: Double

    /// One-line dataset caveat — required (D80 honesty floor).
    /// E.g. `"clear-sky filter applied; nighttime samples dropped"`.
    public let datasetCaveats: String

    /// Optional dataset DOI / citation URL. `nil` when the dataset
    /// is public web-accessible and `oracleSource` carries enough
    /// identification.
    public let datasetCitation: String?

    public init(oracleSource: String,
                unit: String,
                sampleCount: Int,
                meanRelErr: Double,
                maxRelErr: Double?,
                threshold: Double,
                datasetCaveats: String,
                datasetCitation: String?) {
        self.oracleSource     = oracleSource
        self.unit             = unit
        self.sampleCount      = sampleCount
        self.meanRelErr       = meanRelErr
        self.maxRelErr        = maxRelErr
        self.threshold        = threshold
        self.datasetCaveats   = datasetCaveats
        self.datasetCitation  = datasetCitation
    }

    enum CodingKeys: String, CodingKey {
        case oracleSource     = "oracle_source"
        case unit
        case sampleCount      = "sample_count"
        case meanRelErr       = "mean_rel_err"
        case maxRelErr        = "max_rel_err"
        case threshold
        case datasetCaveats   = "dataset_caveats"
        case datasetCitation  = "dataset_citation"
    }

    /// Derived PASS predicate — TRUE when `meanRelErr <= threshold`.
    /// Mirror of `HexaNativeParityRef.isHexaNativeAbsorbed` (D95) —
    /// kept computed (not stored) so the numeric truth cannot drift
    /// from a duplicate boolean (D86 `g_no_hardcoded_data`).
    ///
    /// CAVEAT (D103) — this predicate does NOT by itself flip the
    /// cell's stored `absorbed: Bool`. The producer/writer path is
    /// responsible for performing the flip explicitly when this
    /// predicate is true AND the dataset caveats are acceptable.
    public var isMeasuredOraclePASS: Bool {
        return meanRelErr <= threshold
    }
}
