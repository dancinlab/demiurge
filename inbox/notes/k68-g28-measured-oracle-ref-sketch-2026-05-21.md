# DRAFT — `MeasuredOracleRef` Swift sketch (G28 land 후보)

> **status**: draft · 2026-05-21
>
> **목적**: ARCH.md §11.4 Round 7 G28 (producer wire — substrate
> adapter 가 measured-oracle field 를 cell record 에 emit) 의 cockpit
> Swift type sketch. `EnergyVerifyRecord` 의 새 field 1개 + 새 typed
> struct 1개 의 *작은 schema 확장* 안.
>
> **insertion point**: `cockpit/Sources/DemiurgeCore/Models/
> MeasuredOracleRef.swift` (NEW file) + `EnergyVerifyRecord.swift`
> 의 `hexaNativeParity` 줄 직후 새 field 1개. style = `HexaNative
> ParityRef` (UfoVerifyRecord.swift line 96..) 와 일관.
>
> 본 note 는 Swift code 의 land 직전 검토용 — 사용자 승인 후 별도
> commit 으로 land. land 자체는 `absorbed: Bool` 미flip (D103 schema
> half 만).

---

## 1. `MeasuredOracleRef` struct skeleton

`HexaNativeParityRef` 의 style 을 mirror — `Codable, Sendable,
Equatable` · public struct · doc-comment 가 D80/D103 honesty floor
명시 · CodingKeys 가 snake_case JSON wire 와 매핑.

```swift
// MeasuredOracleRef.swift — D109 (G28) · κ-68 RFC 013 §6.11
// SSOT for "external measured-oracle parity claim" — typed annotation
// on a cell record (e.g. EnergyVerifyRecord) that anchors the cell's
// stored `absorbed: Bool` flip to a measured ground-truth comparison.
//
// D103 dimension separation — TWO orthogonal axes:
//   1. Substrate kernel parity (`HexaNativeParityRef` · computed
//      `isHexaNativeAbsorbed`). Driven by PILOTS.demi `parity_status`.
//   2. Cell-level measured absorbed (`<Record>.absorbed: Bool`,
//      stored). Driven by THIS struct's `isMeasuredOraclePASS`
//      PASS gate AND an EXPLICIT writer set — NOT by D95 computed
//      projection.
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
    /// Mirror of `HexaNativeParityRef.isHexaNativeAbsorbed` (D95),
    /// kept as a *computed* property so a stored boolean cannot drift
    /// from the numeric truth (D86 `g_no_hardcoded_data`).
    ///
    /// CAVEAT (D103) — this predicate does NOT by itself flip the
    /// cell's stored `absorbed: Bool`. The producer/writer path is
    /// responsible for performing the flip explicitly when this
    /// predicate is true AND the dataset caveats are acceptable.
    public var isMeasuredOraclePASS: Bool {
        return meanRelErr <= threshold
    }
}
```

## 2. `EnergyVerifyRecord` extension (additive)

`EnergyVerifyRecord.swift` 의 `hexaNativeParity` 줄 직후에 1 field
추가 + CodingKeys 1 줄 추가. init 은 현재 implicit memberwise
(struct default) 사용 중이므로 별도 갱신 없음 (Swift 가 자동 확장).
*변경된 surface = 2 lines (field + CodingKey).*

```swift
// (EnergyVerifyRecord.swift, after line 41 `hexaNativeParity`)

    /// D109 (G28) — κ-68 RFC 013 §6.11. External measured-oracle
    /// reference (e.g. NREL MIDC pyranometer GHI vs hexa-native sun-
    /// position-driven modeled GHI). Independent axis from
    /// `hexaNativeParity` above (D103 separation). `nil` when the
    /// cell has not yet been through the per-cell measured-oracle
    /// round; populated by the producer adapter at emit time when
    /// the dataset is available and the modeled chain runs end-to-
    /// end. The cell's stored `absorbed` flip remains a separate
    /// explicit writer action (NOT auto-triggered by this field).
    public let measuredOracle: MeasuredOracleRef?

    enum CodingKeys: String, CodingKey {
        // ... existing keys ...
        case hexaNativeParity = "hexa_native_parity"
        case measuredOracle   = "measured_oracle"
    }
```

g3 — schema half 만 land: `measuredOracle` 가 non-nil + PASS 인
JSON record 가 emit 되어도 *stored* `absorbed: Bool` 은 false 유지
(G29 의 explicit-writer step 까지). XCTest 가 본 invariant 를
검증 (G30 governance 와 일관).

## 3. Open questions (사용자 review point)

1. **Time-series carrier 여부** — 본 sketch 는 summary stats
   (meanRelErr · maxRelErr · sampleCount) 만 carry. raw 시계열
   (1440 samples · GHI 쌍) 은 `exports/<>/raw_samples/` 에 별도
   파일로. 첫 land 의 honest floor 로는 summary 만 cell record 안
   carry, raw 는 reference 형태로 — Y/N?
2. **`unit` field 의 필요성** — Energy/solar 에는 `"W/m^2"` 가
   분명. 후속 cell (potential Aura / Ufo) 가 다른 unit (예: K /
   1 / m) 일 가능성 — type-level 보장 vs free-text — 후자 picked
   (현재 sketch). Y/N?
3. **PASS evaluation 의 위치** — `isMeasuredOraclePASS` computed
   predicate 가 producer 측의 1 차 gate. 본 predicate 가 true 일
   때만 cell-record writer 가 `absorbed=true` 로 set — 그런데
   `dataset_caveats` 의 free-text 가 *추가 gate* 의 역할 (예: 측정
   장비 calibration 만료 / day-of-year outlier 등). caveat parser
   가 필요한가, 아니면 writer 의 inspection 으로 충분한가?
4. **타입 재사용성** — `MeasuredOracleRef` 를 Energy-specific 으로
   둘지, 여러 cell 가 재사용할 generic 으로 둘지. 현재 sketch 는
   generic — `oracleSource` / `unit` 이 cell-agnostic. Aura
   neural-LIF / Ufo 의 후속 round 에서 그대로 재사용 가능 (D72
   N+M payoff 정신). Y/N?
5. **derived `isMeasuredOracleAbsorbed` computed property 의 위치** —
   `EnergyVerifyRecord` 에 `isMeasuredOracleAbsorbed` (computed,
   `measuredOracle?.isMeasuredOraclePASS ?? false`) 를 추가할지.
   `isHexaNativeAbsorbed` (D95) 와 일관성 vs *stored* `absorbed`
   와의 dimension-separation 명료성. 현 sketch 는 미포함 (writer
   가 stored 값을 직접 set 하므로 derived 는 redundant). Y/N?
6. **field 의 schema-half 단계 emit 정책** — `measuredOracle` 가
   non-nil PASS 인데 stored `absorbed=false` 라는 *intermediate*
   state 는 honest 상태인가, oxymoron 인가? D103 separation 으로
   honest (substrate-parity PASS + 측정-oracle PASS + cell writer
   가 아직 flip 안 함). cockpit UI 측에서 이 4번째 state 를 어떻게
   표현 (chip color · label) — G28 land 시 결정 vs G30 까지 deferred.

---

## Cross-references

- ARCH.md §11.4 Round 7 G28 (`[ ]` placeholder · 본 sketch 가 land
  base)
- `cockpit/Sources/DemiurgeCore/Models/HexaNativeParityRef.swift`
  (D80 type 의 style mirror anchor — UfoVerifyRecord.swift 의
  line 96..174 inline)
- `cockpit/Sources/DemiurgeCore/Models/EnergyVerifyRecord.swift`
  (additive 1 field 의 insertion point)
- proposals/rfc_013_hexa_native_parity_connection.md §6.11
- design.md D86 (g_no_hardcoded_data) · D90 (PILOTS schema parallel) ·
  D95 (computed projection) · D103 (dimension separation) ·
  D106 (illustrative-physics gate) · D109 (cell pick · 본 sketch 의
  upstream)
- inbox/notes/k68-cell-pick-2026-05-21.md · k68-d109-draft-2026-05-21.md
