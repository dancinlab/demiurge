// MeasuredOracleRefTests — D109 (κ-68 G27 land) · RFC 013 §6.11.
//
// Covers:
//   (1) MeasuredOracleRef Codable round-trip (snake_case JSON wire ↔
//       camelCase Swift property).
//   (2) `isMeasuredOraclePASS` predicate — true when meanRelErr <=
//       threshold, false otherwise (boundary + ordinary cases).
//   (3) `EnergyVerifyRecord.measuredOracle` optional decode — nil
//       branch (backwards compat with existing records) AND non-nil
//       branch (new G27 record carries the field).
//   (4) D103 dimension separation invariant — `measuredOracle` PASS
//       must NOT auto-flip stored `absorbed`. (G29 will land the
//       explicit-writer path; here we assert the decode does NOT
//       project measured PASS into the stored bool.)

import XCTest
@testable import DemiurgeCore

final class MeasuredOracleRefTests: XCTestCase {

    // MARK: (1) Codable round-trip

    func testMeasuredOracleRefCodableRoundTrip() throws {
        let ref = MeasuredOracleRef(
            oracleSource: "NREL MIDC SRRL Golden CO · pyranometer GHI · 2026-05-15 · clear-sky day · 1-min cadence",
            unit: "W/m^2",
            sampleCount: 1440,
            meanRelErr: 0.032,
            maxRelErr: 0.087,
            threshold: 0.05,
            datasetCaveats: "clear-sky filter applied; nighttime samples dropped",
            datasetCitation: nil
        )
        let enc = JSONEncoder()
        let dec = JSONDecoder()
        let data = try enc.encode(ref)
        let back = try dec.decode(MeasuredOracleRef.self, from: data)
        XCTAssertEqual(back, ref)
    }

    func testMeasuredOracleRefJSONKeysAreSnakeCase() throws {
        let ref = MeasuredOracleRef(
            oracleSource: "test",
            unit: "1",
            sampleCount: 10,
            meanRelErr: 0.01,
            maxRelErr: nil,
            threshold: 0.05,
            datasetCaveats: "n/a",
            datasetCitation: "doi:1234"
        )
        let data = try JSONEncoder().encode(ref)
        let s = String(data: data, encoding: .utf8) ?? ""
        XCTAssertTrue(s.contains("\"oracle_source\""))
        XCTAssertTrue(s.contains("\"sample_count\""))
        XCTAssertTrue(s.contains("\"mean_rel_err\""))
        XCTAssertTrue(s.contains("\"dataset_caveats\""))
        XCTAssertTrue(s.contains("\"dataset_citation\""))
        // camelCase keys must NOT appear on the wire
        XCTAssertFalse(s.contains("\"oracleSource\""))
        XCTAssertFalse(s.contains("\"meanRelErr\""))
    }

    // MARK: (2) isMeasuredOraclePASS predicate

    func testIsMeasuredOraclePASSTrueWhenWithinThreshold() {
        let pass = MeasuredOracleRef(
            oracleSource: "test", unit: "W/m^2", sampleCount: 100,
            meanRelErr: 0.032, maxRelErr: 0.08, threshold: 0.05,
            datasetCaveats: "n/a", datasetCitation: nil)
        XCTAssertTrue(pass.isMeasuredOraclePASS)
    }

    func testIsMeasuredOraclePASSTrueAtExactBoundary() {
        let boundary = MeasuredOracleRef(
            oracleSource: "test", unit: "W/m^2", sampleCount: 100,
            meanRelErr: 0.05, maxRelErr: nil, threshold: 0.05,
            datasetCaveats: "n/a", datasetCitation: nil)
        XCTAssertTrue(boundary.isMeasuredOraclePASS,
            "boundary case (meanRelErr == threshold) should PASS")
    }

    func testIsMeasuredOraclePASSFalseWhenOverThreshold() {
        let fail = MeasuredOracleRef(
            oracleSource: "test", unit: "W/m^2", sampleCount: 100,
            meanRelErr: 0.061, maxRelErr: 0.15, threshold: 0.05,
            datasetCaveats: "n/a", datasetCitation: nil)
        XCTAssertFalse(fail.isMeasuredOraclePASS)
    }

    // MARK: (3) EnergyVerifyRecord.measuredOracle decode

    func testEnergyVerifyRecordDecodesNilMeasuredOracle() throws {
        // Pre-D109 record shape (no measured_oracle key): MUST still
        // decode (backwards compat with all prior exports/energy
        // records).
        let json = """
        {
          "domain": "energy",
          "verb": "verify",
          "kind": "energy_verify",
          "stamp": "20260520T120000Z",
          "producer": "openmc_keff",
          "measurement_gate": "GATE_OPEN",
          "absorbed": false,
          "scope_caveats": ["OpenMC install-gated"],
          "citations": [],
          "skipped_reason": "OpenMC not installed",
          "kernel_reuse": null,
          "hexa_native_parity": null
        }
        """.data(using: .utf8)!
        let rec = try JSONDecoder().decode(EnergyVerifyRecord.self, from: json)
        XCTAssertNil(rec.measuredOracle)
        XCTAssertFalse(rec.absorbed)
    }

    func testEnergyVerifyRecordDecodesNonNilMeasuredOracle() throws {
        // D109 G27 record shape: measured_oracle non-nil + absorbed
        // still false (G28 schema half land; G29 explicit-writer
        // gate has NOT run yet).
        let json = """
        {
          "domain": "energy",
          "verb": "verify",
          "kind": "energy_verify",
          "stamp": "20260521T120000Z",
          "producer": "nrel_midc_pyranometer",
          "measurement_gate": "GATE_OPEN",
          "absorbed": false,
          "scope_caveats": [],
          "citations": ["NREL MIDC SRRL 2026-05-15"],
          "skipped_reason": null,
          "kernel_reuse": null,
          "hexa_native_parity": null,
          "measured_oracle": {
            "oracle_source": "NREL MIDC SRRL Golden CO · pyranometer GHI · 2026-05-15 · clear-sky day · 1-min cadence",
            "unit": "W/m^2",
            "sample_count": 1440,
            "mean_rel_err": 0.032,
            "max_rel_err": 0.087,
            "threshold": 0.05,
            "dataset_caveats": "clear-sky filter applied; nighttime samples dropped",
            "dataset_citation": null
          }
        }
        """.data(using: .utf8)!
        let rec = try JSONDecoder().decode(EnergyVerifyRecord.self, from: json)
        XCTAssertNotNil(rec.measuredOracle)
        XCTAssertEqual(rec.measuredOracle?.sampleCount, 1440)
        XCTAssertTrue(rec.measuredOracle?.isMeasuredOraclePASS ?? false,
            "0.032 <= 0.05 should be PASS")
        // (4) D103 separation invariant — even though measured PASS,
        // stored absorbed remains false (G29 explicit-writer not run).
        XCTAssertFalse(rec.absorbed,
            "stored absorbed must NOT auto-flip from measured PASS (D103 / G29 scope)")
    }
}
