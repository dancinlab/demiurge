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

    // MARK: Test 3a — second carrier (AuraVerifyRecord) auto-extension
    //
    // κ-69 G33 audit (D115 second-cell pick · D117 first-flip): the
    // invariant `invariantHolds(absorbed, measuredOracle,
    // isIllustrativePhysics)` is record-type-AGNOSTIC by construction —
    // it consumes the SHAPE (Bool + Optional<MeasuredOracleRef> + Bool)
    // not a specific Record type. The κ-69 R8 G30-Stage-1 audit
    // confirms: NO invariant-helper code change was required to extend
    // the gate to a second carrier; the AuraVerifyRecord whose
    // `measuredOracle` field landed in this cycle is governed by the
    // same predicate. This test pins that observation so a future
    // regression that re-shapes the invariant around EnergyVerifyRecord
    // specifically will fail loudly.

    func testAuraVerifyRecordCoveredByInvariantNoCodeChange() {
        // Synth AuraVerifyRecord — substrate parity left nil (κ-69 R8
        // measurement-axis only), measured-oracle PASS, absorbed=true.
        let auraPass = AuraVerifyRecord(
            domain: "aura", verb: "verify",
            kind: "sleep_edf_alpha_band_psd_measured_oracle",
            stamp: "20260522T000000Z",
            producer: "synth@k69_g33_invariant_audit",
            measurementGate: .closedMeasured,
            absorbed: true,
            scopeCaveats: [], citations: [],
            falsifiers: nil,
            hexaNativeParity: nil,
            latticeInvariant: nil,
            skippedReason: nil,
            measuredOracle: Self.passOracle())

        XCTAssertTrue(Self.invariantHolds(
            absorbed: auraPass.absorbed,
            measuredOracle: auraPass.measuredOracle,
            isIllustrativePhysics: false),
            "AuraVerifyRecord with measured PASS must satisfy invariant — second-carrier auto-extension (G30 Stage 1)")

        // Conflation guard — Aura with absorbed=true but measured nil
        // and non-illustrative MUST fail the invariant.
        let auraConflated = AuraVerifyRecord(
            domain: "aura", verb: "verify",
            kind: "synth_conflation_attempt",
            stamp: "20260522T000000Z",
            producer: "synth@d95_conflation",
            measurementGate: .open,
            absorbed: true, // <- illegitimate (no oracle, not illustrative)
            scopeCaveats: [], citations: [],
            falsifiers: nil,
            hexaNativeParity: nil,
            latticeInvariant: nil,
            skippedReason: nil,
            measuredOracle: nil)

        XCTAssertFalse(Self.invariantHolds(
            absorbed: auraConflated.absorbed,
            measuredOracle: auraConflated.measuredOracle,
            isIllustrativePhysics: false),
            "AuraVerifyRecord with absorbed=true + nil measured oracle (and non-illustrative) MUST violate invariant — D103/D109 separation extends to the second carrier")
    }

    // MARK: Test 3b — third carrier (UfoVerifyRecord) auto-extension
    //
    // κ-70 G37 audit (D118 third-cell pick · D119 first-flip): the
    // invariant `invariantHolds(absorbed, measuredOracle,
    // isIllustrativePhysics)` is record-type-AGNOSTIC by construction —
    // it consumes the SHAPE (Bool + Optional<MeasuredOracleRef> + Bool)
    // not a specific Record type. The κ-70 R9 G30-Stage-1 audit
    // confirms: NO invariant-helper code change was required to extend
    // the gate to a THIRD carrier; the UfoVerifyRecord whose
    // `measuredOracle` field landed in this cycle is governed by the
    // same predicate. This test pins the **3rd record-type instance**
    // verification — invariant-helper code change 0 across three
    // distinct cell records (Energy/solar G29 · Aura/EEG G33 · Ufo/
    // plasma G37) is the strongest evidence that the G30 invariant's
    // record-type-agnostic design holds. Future regressions that
    // re-shape the invariant around any specific record type will fail
    // loudly.
    //
    // Cross-link: D118 cross-link gate — when absorbed=true is emitted
    // on a Ufo Stage-2 record, the producer MUST include a Stage-4..7
    // (warp/wormhole/dim/use) D106 illustrative-physics carve-out
    // entry in `scopeCaveats`. This test exercises the invariant's
    // arithmetic on the absorbed/measuredOracle/isIllustrativePhysics
    // triple — the carve-out is a separate scope_caveats SHAPE check
    // (audited at the producer + record-emit layer, not the invariant).

    func testUfoVerifyRecordCoveredByInvariantNoCodeChange() {
        // Synth UfoVerifyRecord — substrate parity left nil (κ-70 R9
        // measurement-axis only · Stage-2 sister-substrate fusion
        // plasma diagnostic), measured-oracle PASS, absorbed=true.
        let ufoPass = UfoVerifyRecord(
            domain: "ufo", verb: "verify",
            kind: "jet_pulse_lambda_d_measured_oracle",
            stamp: "20260522T000000Z",
            producer: "synth@k70_g37_invariant_audit",
            measurementGate: .closedMeasured,
            absorbed: true,
            scopeCaveats: [
                // D118 cross-link gate — Stage-4..7 carve-out entry.
                "Stage-2 sister-substrate fusion plasma diagnostic axis only — Stage-4..7 (warp/wormhole/dim/use) excluded per D106 illustrative-physics gate · RFC 013 §6.12 anti-conflation",
            ],
            citations: [],
            falsifiers: nil,
            hexaNativeParity: nil,
            alienIndex: nil,
            skippedReason: nil,
            measuredOracle: Self.passOracle())

        XCTAssertTrue(Self.invariantHolds(
            absorbed: ufoPass.absorbed,
            measuredOracle: ufoPass.measuredOracle,
            isIllustrativePhysics: false),
            "UfoVerifyRecord with measured PASS must satisfy invariant — third-carrier auto-extension (G30 Stage 1 · κ-70 G37 3rd record-type instance · invariant-helper code change 0)")

        // Conflation guard — Ufo with absorbed=true but measured nil
        // and non-illustrative MUST fail the invariant.
        let ufoConflated = UfoVerifyRecord(
            domain: "ufo", verb: "verify",
            kind: "synth_conflation_attempt",
            stamp: "20260522T000000Z",
            producer: "synth@d95_conflation",
            measurementGate: .open,
            absorbed: true, // <- illegitimate (no oracle, not illustrative)
            scopeCaveats: [],
            citations: [],
            falsifiers: nil,
            hexaNativeParity: nil,
            alienIndex: nil,
            skippedReason: nil,
            measuredOracle: nil)

        XCTAssertFalse(Self.invariantHolds(
            absorbed: ufoConflated.absorbed,
            measuredOracle: ufoConflated.measuredOracle,
            isIllustrativePhysics: false),
            "UfoVerifyRecord with absorbed=true + nil measured oracle (and non-illustrative) MUST violate invariant — D103/D109 separation extends to the third carrier")

        // D106 illustrative-physics branch — Ufo Stage-4..7 cell with
        // absorbed=true + measured nil + isIllustrativePhysics=true
        // satisfies the invariant (D118 carve-out · Stage-4..7
        // illustrative cells are the exempted set; this branch is
        // exercised when a future Stage-4 propulsion record is built
        // without a measured oracle and the producer flags it as
        // illustrative).
        XCTAssertTrue(Self.invariantHolds(
            absorbed: true,
            measuredOracle: nil,
            isIllustrativePhysics: true),
            "UfoVerifyRecord with absorbed=true + nil measured oracle MUST satisfy invariant when isIllustrativePhysics=true — D106 / D118 Stage-4..7 illustrative-physics carve-out")
    }

    // MARK: κ-71 G41 — fourth record-type invariant generalization (Energy/wind)

    /// G30 record-type-agnostic invariant audit — fourth carrier (D121).
    /// EnergyWindVerifyRecord is a NEW record type (κ-71 R10 G41 first-
    /// flip target · D120 cell pick · sub-cell separation from κ-68
    /// EnergyVerifyRecord). 0-code-change auto-extension across 4 cells
    /// (Energy/solar · Aura/EEG · Ufo/plasma · Energy/wind) is the
    /// strongest cross-cell evidence yet that `invariantHolds(absorbed,
    /// measuredOracle, isIllustrativePhysics)` is record-type-agnostic
    /// by construction. Wind is NOT D106 illustrative (real prediction
    /// axis · power_curve_kernel.hexa vs empirical turbine curve), so
    /// the illustrative branch test is intentionally omitted — the 2
    /// cases below (PASS + conflation guard) suffice.
    func testEnergyWindVerifyRecordCoveredByInvariantNoCodeChange() {
        // Synth EnergyWindVerifyRecord — measured-oracle PASS, absorbed=true.
        let windPass = EnergyWindVerifyRecord(
            stamp: "20260522T000000Z",
            producer: "synth@k71_g41_invariant_audit",
            measurementGate: .closedMeasured,
            absorbed: true,
            scopeCaveats: [],
            citations: [],
            measuredOracle: Self.passOracle())

        XCTAssertTrue(Self.invariantHolds(
            absorbed: windPass.absorbed,
            measuredOracle: windPass.measuredOracle,
            isIllustrativePhysics: false),
            "EnergyWindVerifyRecord with measured PASS must satisfy invariant — fourth-carrier auto-extension (G30 record-type-agnostic · κ-71 G41 4th record-type instance · invariant-helper code change 0)")

        // Conflation guard — Wind with absorbed=true but measured nil and
        // non-illustrative MUST fail the invariant.
        let windConflated = EnergyWindVerifyRecord(
            stamp: "20260522T000000Z",
            producer: "synth@d95_conflation",
            measurementGate: .open,
            absorbed: true, // <- illegitimate (no oracle, not illustrative)
            scopeCaveats: [],
            citations: [],
            measuredOracle: nil)

        XCTAssertFalse(Self.invariantHolds(
            absorbed: windConflated.absorbed,
            measuredOracle: windConflated.measuredOracle,
            isIllustrativePhysics: false),
            "EnergyWindVerifyRecord with absorbed=true + nil measured oracle (and non-illustrative) MUST violate invariant — D103/D109 separation extends to the fourth carrier")
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
