// RTSC5GateEnforcementTests — constitution.md v1.4.0 R4 Stage 1.
//
// Validates the MaterialAttestationRecord Codable decoder's R4
// (RTSC absorbed=true twin-error invariant) Stage 1 enforcement:
//   (1) HISTORICAL Nb attestation record (`rtsc_attestation_...json`)
//       is INVALID per the new invariant — by design (Pattern 1
//       audit evidence, preserved for the historical record);
//   (2) CURRENT Nb attestation record (`lts_attestation_...json`,
//       Path B migration 2026-05-22 · `domain: "lts"`) decodes cleanly
//       — R4 only constrains `domain == "rtsc"`, so the LTS record
//       is structurally legitimate (no over-reach);
//   (3) any future RTSC record with `aggregate != ALL_PASS` is
//       rejected at decode time;
//   (4) non-rtsc domain records (energy / solar pyranometer pattern)
//       remain unconstrained — invariant does not over-reach.
//
// Cross-refs:
//   - constitution.md R4
//   - RTSC.md §8.9 (5-criteria gate) · §8.10 (Nb correction + Path B
//     migration completed 2026-05-22)
//   - archive/session-notes/2026-05-21-r4-stage1-enforcement.md (migration plan,
//     Path B recommended + implemented)

import XCTest
@testable import DemiurgeCore

final class RTSC5GateEnforcementTests: XCTestCase {

    // MARK: Test 1a — HISTORICAL Nb attestation is INVALID (Pattern 1 audit)

    /// HONEST-FAIL by design — validates that the *historical* Nb
    /// attestation record (`exports/material_attestation/nb_bcs_v1/
    /// rtsc_attestation_nb_bcs_20260521T111656Z.json`, preserved as
    /// Pattern 1 audit evidence per RTSC.md §8.10 / inbox migration
    /// notes) has `domain: "rtsc"` + `absorbed: true` but NO
    /// `rtsc_5_gate_evaluation` field → MUST throw under the R4 Stage
    /// 1 invariant. This test asserts the throw — passing means the
    /// invariant *catches* the historical namespace exploit.
    ///
    /// Renamed from `testNbAttestationDomainRTSCRequires5GateField`
    /// after Path B migration (2026-05-22): the *current* Nb record
    /// now lives under `lts_attestation_*.json` with `domain: "lts"`
    /// (see Test 1b). The historical file is intentionally preserved
    /// so this invariant-catches-Pattern-1 assertion remains live.
    func testHistoricalNbAttestationRequires5GateField() throws {
        // #filePath = .../demiurge/cockpit/Tests/DemiurgeCoreTests/<this>.swift
        // exports root lives at .../demiurge/exports/ (sibling of cockpit/).
        let path = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent() // DemiurgeCoreTests
            .deletingLastPathComponent() // Tests
            .deletingLastPathComponent() // cockpit
            .deletingLastPathComponent() // demiurge
            .appendingPathComponent("exports")
            .appendingPathComponent("material_attestation")
            .appendingPathComponent("nb_bcs_v1")
            .appendingPathComponent("rtsc_attestation_nb_bcs_20260521T111656Z.json")

        let data = try Data(contentsOf: path)

        // Sanity precondition — the record IS domain=rtsc + absorbed=true.
        // (Use a minimal pass-through decoder to read these two fields
        // without triggering the invariant.)
        struct Peek: Codable {
            let domain: String
            let absorbed: Bool
            let rtsc_5_gate_evaluation: RTSC5GateEvaluation?
        }
        let peek = try JSONDecoder().decode(Peek.self, from: data)
        XCTAssertEqual(peek.domain, "rtsc",
            "Historical Nb attestation record IS in the rtsc namespace (Pattern 1 root, preserved as audit evidence)")
        XCTAssertTrue(peek.absorbed,
            "Historical Nb attestation record IS absorbed=true (pre-Path-B state)")
        XCTAssertNil(peek.rtsc_5_gate_evaluation,
            "Historical Nb attestation record does NOT carry rtsc_5_gate_evaluation (migration trigger)")

        // R4 Stage 1 invariant MUST reject the decode of the historical
        // record — Pattern 1 namespace exploit caught at the Codable
        // layer.
        XCTAssertThrowsError(
            try JSONDecoder().decode(MaterialAttestationRecord.self, from: data),
            "R4 invariant MUST reject historical Nb attestation: domain=rtsc + absorbed=true + no 5-gate field"
        ) { err in
            guard case DecodingError.dataCorrupted(let ctx) = err else {
                XCTFail("Expected DecodingError.dataCorrupted, got \(err)")
                return
            }
            XCTAssertTrue(ctx.debugDescription.contains("R4 invariant"),
                "Error message must cite R4 invariant; got: \(ctx.debugDescription)")
        }
    }

    // MARK: Test 1b — CURRENT Nb attestation (Path B, domain=lts) decodes cleanly

    /// HAPPY-PATH after Path B migration (2026-05-22) — the current
    /// Nb attestation record (`exports/material_attestation/nb_bcs_v1/
    /// lts_attestation_nb_bcs_*.json`, emitted by
    /// `nb_bcs_absorbed_attestation_producer.py@v2`) has
    /// `domain: "lts"` + `absorbed: true`. R4 only constrains
    /// `domain == "rtsc"`, so this record decodes CLEANLY without
    /// requiring a `rtsc_5_gate_evaluation` field.
    ///
    /// Together with `testHistoricalNbAttestationRequires5GateField`
    /// (Test 1a) this pair documents the migration: the same physical
    /// claim (BCS universal ratio parity for Nb at <5%) is REJECTED
    /// when carried under `domain: "rtsc"` (Pattern 1) and ACCEPTED
    /// when carried under `domain: "lts"` (honest material classification).
    func testCurrentNbAttestationIsLtsDomainNoConstraint() throws {
        // Locate the most recent `lts_attestation_nb_bcs_*.json`
        // (producer emits a timestamped file each run; pick the latest
        // by lexical sort since timestamps are ISO-style sortable).
        let dir = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent() // DemiurgeCoreTests
            .deletingLastPathComponent() // Tests
            .deletingLastPathComponent() // cockpit
            .deletingLastPathComponent() // demiurge
            .appendingPathComponent("exports")
            .appendingPathComponent("material_attestation")
            .appendingPathComponent("nb_bcs_v1")

        let fileManager = FileManager.default
        let entries = try fileManager.contentsOfDirectory(atPath: dir.path)
        let ltsRecords = entries
            .filter { $0.hasPrefix("lts_attestation_nb_bcs_") && $0.hasSuffix(".json") }
            .sorted()
        guard let latestName = ltsRecords.last else {
            XCTFail("No lts_attestation_nb_bcs_*.json found in \(dir.path) — Path B producer not run?")
            return
        }
        let path = dir.appendingPathComponent(latestName)

        let data = try Data(contentsOf: path)

        // Decode through the R4-enforcing MaterialAttestationRecord — must succeed.
        let rec = try JSONDecoder().decode(MaterialAttestationRecord.self, from: data)
        XCTAssertEqual(rec.domain, "lts",
            "Path B migration: current Nb record carries domain=lts (not rtsc)")
        XCTAssertTrue(rec.absorbed,
            "Current Nb record preserves absorbed=true (legitimate BCS universal ratio parity)")
        XCTAssertNil(rec.rtsc_5_gate_evaluation,
            "R4 only constrains domain=rtsc — domain=lts MUST decode without a 5-gate field")
        XCTAssertEqual(rec.kind, "nb_bcs_universal_gap_ratio_attestation",
            "Path B migration: lts_ prefix dropped from kind (domain field carries the material class)")
        XCTAssertEqual(rec.gateType, "bcs-universal-ratio-attestation",
            "BCS-universal-ratio gate is preserved across migration")
    }

    // MARK: Test 2 — future RTSC attestation w/ ANY_FAIL is rejected

    func testFutureRTSCAttestationRequiresAllPass() throws {
        // Synthetic future record — domain=rtsc + absorbed=true but
        // 5-gate aggregate = ANY_FAIL → decoder MUST throw.
        let json = """
        {
          "domain": "rtsc",
          "verb": "verify",
          "kind": "synth_future_rtsc_candidate",
          "stamp": "20260601T000000Z",
          "producer": "synth_future_producer.py@v1",
          "measurement_gate": "GATE_CLOSED_MEASURED",
          "absorbed": true,
          "gate_type": "rtsc-5-gate-attestation",
          "provisional": false,
          "rtsc_5_gate_evaluation": {
            "a_synthesis_replicated": "PASS",
            "b_tc_above_270k": "PASS",
            "c_ambient_pressure": "FAIL",
            "d_independent_lab_replication": "PASS",
            "e_measurement_oracle_parity": "PASS",
            "aggregate": "ANY_FAIL",
            "evidence": ["synth fixture · (c) pressure FAIL trigger"],
            "rtsc_absorbed_eligible": false
          },
          "scope_caveats": ["synth fixture for R4 invariant"],
          "citations": []
        }
        """.data(using: .utf8)!

        XCTAssertThrowsError(
            try JSONDecoder().decode(MaterialAttestationRecord.self, from: json),
            "R4 invariant MUST reject: aggregate=ANY_FAIL is incompatible with absorbed=true"
        ) { err in
            guard case DecodingError.dataCorrupted(let ctx) = err else {
                XCTFail("Expected DecodingError.dataCorrupted, got \(err)")
                return
            }
            XCTAssertTrue(ctx.debugDescription.contains("ALL_PASS"),
                "Error message must cite ALL_PASS requirement; got: \(ctx.debugDescription)")
        }
    }

    // MARK: Test 3 — non-RTSC domain unconstrained (no over-reach)

    func testNonRTSCDomainNoConstraint() throws {
        // domain=energy + absorbed=true → R4 invariant must NOT
        // require rtsc_5_gate_evaluation. Mirrors the existing solar-
        // pyranometer absorbed=true precedent (D110 / κ-68 G29 land).
        let json = """
        {
          "domain": "energy",
          "verb": "verify",
          "kind": "solar_pyranometer_attestation",
          "stamp": "20260521T030739Z",
          "producer": "nrel_midc_pyranometer@v1",
          "measurement_gate": "GATE_CLOSED_MEASURED",
          "absorbed": true,
          "gate_type": "measured-oracle-attestation",
          "provisional": false,
          "scope_caveats": ["clear-sky filter applied"],
          "citations": ["NREL MIDC SRRL"]
        }
        """.data(using: .utf8)!

        let rec = try JSONDecoder().decode(MaterialAttestationRecord.self, from: json)
        XCTAssertEqual(rec.domain, "energy")
        XCTAssertTrue(rec.absorbed)
        XCTAssertNil(rec.rtsc_5_gate_evaluation,
            "non-rtsc domain MUST NOT require rtsc_5_gate_evaluation (invariant does not over-reach)")
    }

    // MARK: Bonus — round-trip + ALL_PASS happy path

    func testRTSCAttestationAllPassRoundTrip() throws {
        let gate = RTSC5GateEvaluation(
            a_synthesis_replicated: .pass,
            b_tc_above_270K: .pass,
            c_ambient_pressure: .pass,
            d_independent_lab_replication: .pass,
            e_measurement_oracle_parity: .pass,
            aggregate: .allPass,
            evidence: [
                "(a) 3-lab synthesis replication · synth fixture",
                "(b) Tc=295K · synth fixture",
                "(c) ambient · synth fixture",
                "(d) 3 indep lab Meissner · synth fixture",
                "(e) model-vs-measured rel_err 0.02 < 0.05 · synth fixture"
            ],
            rtsc_absorbed_eligible: true)

        let rec = MaterialAttestationRecord(
            domain: "rtsc",
            verb: "verify",
            kind: "synth_future_rtsc_allpass",
            stamp: "20260701T000000Z",
            producer: "synth_allpass@v1",
            measurementGate: .closedMeasured,
            absorbed: true,
            gateType: "rtsc-5-gate-attestation",
            provisional: false,
            rtsc_5_gate_evaluation: gate,
            scopeCaveats: ["synth"],
            citations: [])

        let enc = JSONEncoder()
        let dec = JSONDecoder()
        let data = try enc.encode(rec)
        let back = try dec.decode(MaterialAttestationRecord.self, from: data)
        XCTAssertEqual(back, rec, "ALL_PASS round-trip must be lossless")
        XCTAssertEqual(back.rtsc_5_gate_evaluation?.aggregate, .allPass)
        XCTAssertTrue(back.absorbed)
    }

    // MARK: Bonus — deriveAggregate helper sanity

    func testDeriveAggregateHelper() {
        XCTAssertEqual(
            RTSC5GateEvaluation.deriveAggregate(.pass, .pass, .pass, .pass, .pass),
            .allPass)
        XCTAssertEqual(
            RTSC5GateEvaluation.deriveAggregate(.pass, .fail, .pass, .pass, .pass),
            .anyFail)
        XCTAssertEqual(
            RTSC5GateEvaluation.deriveAggregate(.pass, .skipped, .pass, .pass, .pass),
            .insufficient)
        XCTAssertEqual(
            RTSC5GateEvaluation.deriveAggregate(.skipped, .skipped, .skipped, .skipped, .skipped),
            .insufficient)
    }
}
