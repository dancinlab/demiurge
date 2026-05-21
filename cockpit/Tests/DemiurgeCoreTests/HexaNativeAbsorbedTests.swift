// HexaNativeAbsorbedTests — D95 derived absorbed flag.
//
// Covers:
//   (1) HexaNativeParityRef.isPassStatus predicate over the 10 PASS
//       phrasings actually present in domains/PILOTS.demi (+ negative
//       inputs).
//   (2) HexaNativeParityRef.isHexaNativeAbsorbed (instance computed).
//   (3) Cell-record .isHexaNativeAbsorbed (5 record types) reflects
//       hexaNativeParity?.isHexaNativeAbsorbed and falls back to
//       false when the field is nil.
//
// SSOT-only — no new stored data; predicate strings are echoed from
// PILOTS.demi for the positive cases.

import XCTest
@testable import DemiurgeCore

final class HexaNativeAbsorbedTests: XCTestCase {

    // MARK: (1) isPassStatus — pure predicate

    /// Mirrors every parity_status string currently in PILOTS.demi
    /// (10 rows). All must derive isHexaNativeAbsorbed == true.
    func testIsPassStatusAcceptsAllPilotsDemiPhrasings() {
        let pilotsDemiStatuses = [
            "21/21 PASS at rel_err <=1e-13",
            "8/8 PASS at ~1e-3 rel @ N=1e5",
            "23/23 PASS at rel_err <=2e-15",
            "PASS (concurrent branch, networkx companion parity)",
            "PASS (concurrent branch, yourdfpy companion parity)",
            "41/41 PASS at rel_err = 0.0",
            "27/27 PASS at rel_err = 0.0",
            "17/17 PASS at rel_err <=1e-12",
            "36/36 PASS exact",
            "41/41 PASS at rel_err = 0.0",
        ]
        for s in pilotsDemiStatuses {
            XCTAssertTrue(
                HexaNativeParityRef.isPassStatus(s),
                "expected PASS for \(s)")
        }
    }

    func testIsPassStatusRejectsNegativeCases() {
        // Empty / whitespace-only / nil-like.
        XCTAssertFalse(HexaNativeParityRef.isPassStatus(""))
        XCTAssertFalse(HexaNativeParityRef.isPassStatus("   "))
        // Explicit FAIL / SKIP / ERROR markers.
        XCTAssertFalse(HexaNativeParityRef.isPassStatus("FAIL"))
        XCTAssertFalse(HexaNativeParityRef.isPassStatus(
            "3/5 PASS, 2/5 FAIL"))
        XCTAssertFalse(HexaNativeParityRef.isPassStatus("SKIP"))
        XCTAssertFalse(HexaNativeParityRef.isPassStatus(
            "ERROR: substrate import failed"))
        // Partial PASS — leading N/M with N != M.
        XCTAssertFalse(HexaNativeParityRef.isPassStatus(
            "20/21 PASS at rel_err <=1e-13"))
        // No PASS token at all.
        XCTAssertFalse(HexaNativeParityRef.isPassStatus(
            "21/21 at rel_err <=1e-13"))
    }

    // MARK: (2) instance computed on HexaNativeParityRef

    func testHexaNativeParityRefInstanceComputed() {
        let pass = HexaNativeParityRef(
            kernelPath: "stdlib/kernels/solar/solar_kernel.hexa",
            parityTest: "stdlib/kernels/solar/solar_kernel_test.hexa",
            parityMethod: .substrateToSubstrate,
            parityTolerance: 1e-13,
            parityToleranceNote: nil,
            parityStatus: "21/21 PASS at rel_err <=1e-13",
            hexaLangSHA: "122620de",
            scopeNotes: "fixture",
            relErr: nil)
        XCTAssertTrue(pass.isHexaNativeAbsorbed)

        let fail = HexaNativeParityRef(
            kernelPath: "stdlib/kernels/foo/bar.hexa",
            parityTest: "stdlib/kernels/foo/bar_test.hexa",
            parityMethod: .other,
            parityTolerance: nil,
            parityToleranceNote: nil,
            parityStatus: "3/5 PASS, 2/5 FAIL",
            hexaLangSHA: "deadbeef",
            scopeNotes: "fixture",
            relErr: nil)
        XCTAssertFalse(fail.isHexaNativeAbsorbed)
    }

    // MARK: (3) cell-record computed reflects parity-ref (5 records)

    private func passRef() -> HexaNativeParityRef {
        HexaNativeParityRef(
            kernelPath: "stdlib/kernels/solar/solar_kernel.hexa",
            parityTest: "stdlib/kernels/solar/solar_kernel_test.hexa",
            parityMethod: .substrateToSubstrate,
            parityTolerance: 1e-13,
            parityToleranceNote: nil,
            parityStatus: "21/21 PASS at rel_err <=1e-13",
            hexaLangSHA: "122620de",
            scopeNotes: "fixture",
            relErr: nil)
    }

    private func failRef() -> HexaNativeParityRef {
        HexaNativeParityRef(
            kernelPath: "stdlib/kernels/foo/bar.hexa",
            parityTest: "stdlib/kernels/foo/bar_test.hexa",
            parityMethod: .other,
            parityTolerance: nil,
            parityToleranceNote: nil,
            parityStatus: "FAIL",
            hexaLangSHA: "deadbeef",
            scopeNotes: "fixture",
            relErr: nil)
    }

    /// Round-trips the JSON shape that the producer scripts emit, so
    /// the computed flag is exercised on a fully-decoded record (not a
    /// hand-built Swift literal). Returns the decoded record.
    private func decodeUfo(_ json: String) throws -> UfoVerifyRecord {
        try JSONDecoder().decode(UfoVerifyRecord.self,
                                 from: Data(json.utf8))
    }

    func testUfoVerifyRecordReflectsParityRef() throws {
        let ufoPass = UfoVerifyRecord(
            domain: "ufo", verb: "verify", kind: "stub",
            stamp: "20260520T120000Z", producer: "stub@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            falsifiers: nil,
            hexaNativeParity: passRef(),
            alienIndex: nil, skippedReason: nil)
        XCTAssertTrue(ufoPass.isHexaNativeAbsorbed)

        let ufoFail = UfoVerifyRecord(
            domain: "ufo", verb: "verify", kind: "stub",
            stamp: "20260520T120000Z", producer: "stub@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            falsifiers: nil,
            hexaNativeParity: failRef(),
            alienIndex: nil, skippedReason: nil)
        XCTAssertFalse(ufoFail.isHexaNativeAbsorbed)

        let ufoNil = UfoVerifyRecord(
            domain: "ufo", verb: "verify", kind: "stub",
            stamp: "20260520T120000Z", producer: "stub@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            falsifiers: nil,
            hexaNativeParity: nil,
            alienIndex: nil, skippedReason: nil)
        XCTAssertFalse(ufoNil.isHexaNativeAbsorbed)
    }

    func testEnergyVerifyRecordReflectsParityRef() {
        let pass = EnergyVerifyRecord(
            domain: "energy", verb: "verify",
            kind: "openmc_keff_criticality",
            stamp: "20260520T120000Z",
            producer: "openmc@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            skippedReason: nil,
            kernelReuse: nil,
            hexaNativeParity: passRef(),
            measuredOracle: nil)
        XCTAssertTrue(pass.isHexaNativeAbsorbed)

        let nilParity = EnergyVerifyRecord(
            domain: "energy", verb: "verify",
            kind: "openmc_keff_criticality",
            stamp: "20260520T120000Z",
            producer: "openmc@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            skippedReason: nil,
            kernelReuse: nil,
            hexaNativeParity: nil,
            measuredOracle: nil)
        XCTAssertFalse(nilParity.isHexaNativeAbsorbed)
    }

    func testFusionVerifyRecordReflectsParityRef() {
        let pass = FusionVerifyRecord(
            domain: "fusion", verb: "verify",
            kind: "openmc_tbr_neutronics",
            stamp: "20260520T120000Z",
            producer: "openmc@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            skippedReason: nil,
            kernelReuse: nil,
            hexaNativeParity: passRef())
        XCTAssertTrue(pass.isHexaNativeAbsorbed)

        let nilParity = FusionVerifyRecord(
            domain: "fusion", verb: "verify",
            kind: "openmc_tbr_neutronics",
            stamp: "20260520T120000Z",
            producer: "openmc@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            skippedReason: nil,
            kernelReuse: nil,
            hexaNativeParity: nil)
        XCTAssertFalse(nilParity.isHexaNativeAbsorbed)
    }

    func testAuraVerifyRecordReflectsParityRef() {
        let pass = AuraVerifyRecord(
            domain: "aura", verb: "verify", kind: "stub",
            stamp: "20260520T120000Z",
            producer: "stub@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            falsifiers: nil,
            hexaNativeParity: passRef(),
            measuredOracle: nil,
            latticeInvariant: nil,
            skippedReason: nil)
        XCTAssertTrue(pass.isHexaNativeAbsorbed)

        let nilParity = AuraVerifyRecord(
            domain: "aura", verb: "verify", kind: "stub",
            stamp: "20260520T120000Z",
            producer: "stub@absent",
            measurementGate: .open,
            absorbed: false,
            scopeCaveats: [], citations: [],
            falsifiers: nil,
            hexaNativeParity: nil,
            measuredOracle: nil,
            latticeInvariant: nil,
            skippedReason: nil)
        XCTAssertFalse(nilParity.isHexaNativeAbsorbed)
    }

    func testChipAnalyzeRecordReflectsParityRef() {
        let prov = ChipAnalyzeProvenance(
            absorbed: true,
            producer: "hexa_native_booksim_oracle@stub",
            measurementGate: .closedMeasured,
            scopeCaveats: [])
        let pass = ChipAnalyzeRecord(
            interface: "chip+analyze",
            schemaVersion: "1.0.0",
            recordId: "stub",
            producedAtUtc: "20260520T120000Z",
            nNodes: 64,
            bounds: [],
            derivationCite: "stub",
            exitCode: 0,
            provenance: prov,
            hexaNativeParity: passRef())
        XCTAssertTrue(pass.isHexaNativeAbsorbed)

        let nilParity = ChipAnalyzeRecord(
            interface: "chip+analyze",
            schemaVersion: "1.0.0",
            recordId: "stub",
            producedAtUtc: "20260520T120000Z",
            nNodes: 64,
            bounds: [],
            derivationCite: "stub",
            exitCode: 0,
            provenance: prov,
            hexaNativeParity: nil)
        XCTAssertFalse(nilParity.isHexaNativeAbsorbed)
    }
}
