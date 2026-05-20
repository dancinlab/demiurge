// AbsorbedNeedsMeasuredOracleTests — D109 (κ-68 G30 Stage 1).
//
// κ-68 governance invariant: cell record's stored `absorbed: Bool`
// MUST NOT be true unless EITHER
//   (a) `measuredOracle` non-nil AND `isMeasuredOraclePASS == true`
//       (D109 measured-oracle path · explicit-writer set), OR
//   (b) the cell is gated by D106 illustrative-physics (FusionVerifyRecord
//       `mc_slab_demo` path · cyan tone · anti-conflation per RFC 013
//       §6.12).
//
// D95 computed `isHexaNativeAbsorbed` (substrate-parity projection)
// MUST NOT cause stored `absorbed` to flip — that would conflate the
// two D103 dimensions.
//
// SCOPE — Stage 1 is fixture-only (synth records). Real-data exports/
// scan is the G29 land-day extension (revised G30 note Open Q #2).
// Stage 2 (`.specify/memory/constitution.md` row) is DEFERRED until
// constitution.md is populated (κ-68 G30 scope 밖).
//
// Cross-refs:
//   - inbox/notes/k68-g30-revised-2026-05-21.md (Stage 1 plan)
//   - design.md D103 (dimension-separation) · D106 (illustrative-physics
//     gate) · D109 (cell pick · κ-68 G27 land)
//   - proposals/rfc_013_hexa_native_parity_connection.md §6.11/§6.12

import XCTest
@testable import DemiurgeCore

final class AbsorbedNeedsMeasuredOracleTests: XCTestCase {

    // MARK: Invariant codification

    /// G30 governance invariant — stored `absorbed: true` requires
    /// EITHER (a) measured-oracle PASS OR (b) illustrative-physics
    /// exemption. Returns `true` when the invariant holds for the
    /// given record axes.
    private static func invariantHolds(
        absorbed: Bool,
        measuredOracle: MeasuredOracleRef?,
        isIllustrativePhysics: Bool
    ) -> Bool {
        // Trivially holds when absorbed=false — invariant only gates
        // the stored=true branch.
        guard absorbed else { return true }
        // Branch (b) — D106 illustrative-physics exempt.
        if isIllustrativePhysics { return true }
        // Branch (a) — measured-oracle non-nil AND PASS required.
        guard let oracle = measuredOracle,
              oracle.isMeasuredOraclePASS else {
            return false
        }
        return true
    }

    private static func passOracle(
        meanRelErr: Double = 0.02,
        threshold: Double = 0.05
    ) -> MeasuredOracleRef {
        return MeasuredOracleRef(
            oracleSource: "fixture · synth PASS",
            unit: "W/m^2",
            sampleCount: 60,
            meanRelErr: meanRelErr,
            maxRelErr: meanRelErr * 2.0,
            threshold: threshold,
            datasetCaveats: "synth fixture",
            datasetCitation: nil)
    }

    private static func failOracle() -> MeasuredOracleRef {
        return MeasuredOracleRef(
            oracleSource: "fixture · synth FAIL",
            unit: "W/m^2",
            sampleCount: 60,
            meanRelErr: 0.07,
            maxRelErr: 0.15,
            threshold: 0.05,
            datasetCaveats: "synth fixture",
            datasetCitation: nil)
    }

    private static func passParityRef() -> HexaNativeParityRef {
        return HexaNativeParityRef(
            kernelPath: "stdlib/kernels/solar/solar_kernel.hexa",
            parityTest: "stdlib/kernels/solar/solar_kernel_test.hexa",
            parityMethod: .substrateToSubstrate,
            parityTolerance: 1e-13,
            parityToleranceNote: nil,
            parityStatus: "21/21 PASS at rel_err <=1e-13",
            hexaLangSHA: "fixture",
            scopeNotes: "synth PASS for G30 invariant test",
            relErr: 1e-13)
    }

    // MARK: Test 1 — invariant holds across fixture set

    func testAbsorbedRequiresMeasuredOraclePASS() {
        // Fixture 1 — absorbed=false (invariant trivially holds)
        XCTAssertTrue(Self.invariantHolds(
            absorbed: false,
            measuredOracle: nil,
            isIllustrativePhysics: false),
            "absorbed=false should ALWAYS satisfy invariant (no constraint)")

        // Fixture 2 — absorbed=true + measured PASS (legitimate flip)
        XCTAssertTrue(Self.invariantHolds(
            absorbed: true,
            measuredOracle: Self.passOracle(),
            isIllustrativePhysics: false),
            "absorbed=true with measured PASS should satisfy invariant")

        // Fixture 3 — absorbed=true + illustrative exempt (D106 branch)
        XCTAssertTrue(Self.invariantHolds(
            absorbed: true,
            measuredOracle: nil,
            isIllustrativePhysics: true),
            "absorbed=true + illustrative-physics should satisfy invariant (D106 exempt)")

        // Counterexample 1 — absorbed=true + measured nil + non-illustrative
        XCTAssertFalse(Self.invariantHolds(
            absorbed: true,
            measuredOracle: nil,
            isIllustrativePhysics: false),
            "absorbed=true with measured nil and non-illustrative must FAIL invariant")

        // Counterexample 2 — absorbed=true + measured FAIL + non-illustrative
        XCTAssertFalse(Self.invariantHolds(
            absorbed: true,
            measuredOracle: Self.failOracle(),
            isIllustrativePhysics: false),
            "absorbed=true with measured FAIL must FAIL invariant")

        // Counterexample 3 — boundary: meanRelErr == threshold (PASS)
        XCTAssertTrue(Self.invariantHolds(
            absorbed: true,
            measuredOracle: Self.passOracle(meanRelErr: 0.05, threshold: 0.05),
            isIllustrativePhysics: false),
            "boundary meanRelErr == threshold should be PASS (inclusive)")
    }

    // MARK: Test 2 — D95 computed projection MUST NOT flip stored absorbed

    func testAbsorbedNotAutoflippedByD95Computed() {
        // Synth EnergyVerifyRecord — substrate parity PASS (D95 →
        // isHexaNativeAbsorbed=true), but measuredOracle=nil AND
        // absorbed=true (the violation the invariant must catch).
        let bad = EnergyVerifyRecord(
            domain: "energy", verb: "verify",
            kind: "synth_d95_conflation_attempt",
            stamp: "20260521T000000Z",
            producer: "synth@d95",
            measurementGate: .open,
            absorbed: true, // <- conflated from D95
            scopeCaveats: [], citations: [],
            skippedReason: nil,
            kernelReuse: nil,
            hexaNativeParity: Self.passParityRef(),
            measuredOracle: nil)

        // D95 computed projection sees substrate PASS as
        // isHexaNativeAbsorbed=true (this is correct behavior — the
        // SUBSTRATE dimension is honest). But the G30 invariant
        // protects the *stored* (measurement) dimension.
        XCTAssertTrue(bad.isHexaNativeAbsorbed,
            "D95 computed projection should report substrate PASS as true (substrate dimension)")

        // The G30 invariant MUST detect the conflation — record has
        // stored absorbed=true with no measured-oracle backing.
        XCTAssertFalse(Self.invariantHolds(
            absorbed: bad.absorbed,
            measuredOracle: bad.measuredOracle,
            isIllustrativePhysics: false),
            "G30 invariant MUST fail when stored absorbed=true is auto-flipped from D95 computed (measured nil)")
    }

    // MARK: Test 3 — D106 illustrative cells exempt from measured oracle

    func testD106IllustrativeCellExemptFromMeasuredOracle() {
        // Common case — illustrative cell with absorbed=false (stays
        // honestly unabsorbed; invariant trivially holds).
        XCTAssertTrue(Self.invariantHolds(
            absorbed: false,
            measuredOracle: nil,
            isIllustrativePhysics: true),
            "illustrative + absorbed=false should satisfy invariant")

        // Edge case — illustrative cell with measured PASS still
        // satisfies invariant (the (a) branch wins; (b) is a safety
        // net for cells that lack measured oracle by design).
        XCTAssertTrue(Self.invariantHolds(
            absorbed: true,
            measuredOracle: Self.passOracle(),
            isIllustrativePhysics: true),
            "illustrative + measured PASS should satisfy invariant (either branch)")

        // Specific case — illustrative + measured nil + absorbed=true
        // (D106 exemption from G30; the cell's stored absorbed isn't
        // a violation because the invariant exempts illustrative
        // cells per RFC 013 §6.12 anti-conflation).
        XCTAssertTrue(Self.invariantHolds(
            absorbed: true,
            measuredOracle: nil,
            isIllustrativePhysics: true),
            "illustrative + measured nil should still satisfy invariant (D106 exempt)")
    }
}
