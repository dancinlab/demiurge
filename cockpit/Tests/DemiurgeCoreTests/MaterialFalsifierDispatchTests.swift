// MaterialFalsifierDispatchTests — RTSC.md §8.7 Tier 4 dispatch smoke.
//
// Jobs:
//   (1) Honest demo — dispatch the existing LK-99 Tier 2 recipe
//       (replicated_by_independent_labs=0) with tier1=nil and
//       tier3Measurements=[]. Assert aggregate = FAILS-AT-LEAST-ONE
//       (because F-RTSC-3 FAILs on replicated=0) AND assert the
//       verdict JSON lands under exports/material_verdict/.
//   (2) absorbed=false invariant — even a hypothetical PASSES-ALL
//       triple still produces absorbed=false (g3 honest限界 from
//       RTSC.md §8.7 → §8.8).
//   (3) Four non-LK-99 dispatches (Nb · MgB2 · YBCO · Nb3Sn) — the
//       first multi-material Tier 4 batch. Tier 3 measurement records
//       just landed (RTSC.md §8.4 R(T) · Meissner · Cp · Hc2 rows),
//       so falsifiers actually evaluate rather than uniformly SKIP.
//       The YBCO row is the FIRST F-RTSC-3 replication=PASS in the
//       project (REBCO MOCVD recipe replicated_by_independent_labs=5).
//
// The first test is also what generates the canonical LK-99 verdict
// stub the task requires under exports/material_verdict/lk99_lee2023_v1/.

import XCTest
@testable import DemiurgeCore

final class MaterialFalsifierDispatchTests: XCTestCase {

    // MARK: helpers

    /// Decode the LK-99 Tier 2 recipe stub from exports/.
    private func loadLk99Recipe() throws -> SynthesisRecipeRecord {
        let path = RecordLoader.exportsRoot
            .appendingPathComponent("synthesis_recipe", isDirectory: true)
            .appendingPathComponent("lk99_lee2023.json")
        let data = try Data(contentsOf: path)
        return try JSONDecoder().decode(SynthesisRecipeRecord.self, from: data)
    }

    /// Decode an existing on-disk SynthesisRecipeRecord under exports/.
    private func loadRecipe(_ filename: String) throws -> SynthesisRecipeRecord {
        let path = RecordLoader.exportsRoot
            .appendingPathComponent("synthesis_recipe", isDirectory: true)
            .appendingPathComponent(filename)
        let data = try Data(contentsOf: path)
        return try JSONDecoder().decode(SynthesisRecipeRecord.self, from: data)
    }

    /// Decode an existing on-disk MeasurementRecord under
    /// exports/measurement/<kind>/<filename>.
    private func loadMeasurement(kindDir: String, filename: String) throws -> MeasurementRecord {
        let path = RecordLoader.exportsRoot
            .appendingPathComponent("measurement", isDirectory: true)
            .appendingPathComponent(kindDir, isDirectory: true)
            .appendingPathComponent(filename)
        let data = try Data(contentsOf: path)
        return try JSONDecoder().decode(MeasurementRecord.self, from: data)
    }

    /// Decode an existing on-disk ConductorRecord under exports/conductor/.
    private func loadConductor(_ filename: String) throws -> ConductorRecord {
        let path = RecordLoader.exportsRoot
            .appendingPathComponent("conductor", isDirectory: true)
            .appendingPathComponent(filename)
        let data = try Data(contentsOf: path)
        return try JSONDecoder().decode(ConductorRecord.self, from: data)
    }

    /// Build a synthetic ConductorRecord test fixture via JSON round-trip
    /// (same pattern as makeRecipe — the memberwise init is module-internal,
    /// and we don't add an on-disk conductor record per RTSC.md §8.5 since
    /// some materials in this batch don't yet have one).
    /// `family` is the ConductorMaterial raw value; `tcK` predicts the
    /// transition temperature; `hc2At4K` (optional) the upper critical field.
    private func makeConductor(
        family: String,
        compound: String,
        tcK: Double,
        hc2At4K: Double? = nil
    ) throws -> ConductorRecord {
        var spec: [String: Any] = [
            "tc_k": tcK,
            "hc2_t_at_77k": NSNull(),
            "peak_jc_a_per_m2_at_4k": NSNull(),
            "peak_jc_a_per_m2_at_77k": NSNull(),
            "anisotropy_gamma": NSNull(),
            "jc_data_table_ref_record_id": NSNull()
        ]
        if let h = hc2At4K {
            spec["hc2_t_at_4k"] = h
        } else {
            spec["hc2_t_at_4k"] = NSNull()
        }
        let dict: [String: Any] = [
            "domain": "conductor",
            "verb": "ingest",
            "kind": "test_fixture",
            "stamp": "20260521T000000Z",
            "family": family,
            "compound": compound,
            "spec": spec,
            "vendor": NSNull(),
            "source_provenance": [
                "source_substrate": "lab-measured",
                "source_record_url": NSNull(),
                "source_citation": "test fixture — predicted Tc from RTSC.md §8.2 family-canonical value"
            ],
            "measurement_gate": "GATE_OPEN",
            "absorbed": false,
            "gate_type": "test-fixture",
            "provisional": true,
            "scope_caveats": [],
            "citations": []
        ]
        let data = try JSONSerialization.data(withJSONObject: dict)
        return try JSONDecoder().decode(ConductorRecord.self, from: data)
    }

    /// Build a synthetic SynthesisRecipeRecord via JSON round-trip — the
    /// type's memberwise init is module-internal, so cross-module tests
    /// build instances via Codable.
    private func makeRecipe(replicated: Int) throws -> SynthesisRecipeRecord {
        let dict: [String: Any] = [
            "domain": "synthesis_recipe",
            "verb": "ingest",
            "kind": "mocvd",
            "stamp": "20260521T000000Z",
            "family": "hts_cuprate",
            "target_compound": "YBa2Cu3O7-delta",
            "reagents": [],
            "conditions": [
                "temperature_profile_c": [],
                "atmosphere_gas": "oxygen",
                "atmosphere_pressure_bar": 1.0,
                "duration_hours": 1.0
            ],
            "replicated_by_independent_labs": replicated,
            "measurement_gate": "GATE_OPEN",
            "absorbed": false,
            "gate_type": "vendor-datasheet",
            "provisional": true,
            "provenance": [
                "source_url": "test://synthetic",
                "source_citation": "synthetic test fixture"
            ],
            "scope_caveats": [],
            "citations": []
        ]
        let data = try JSONSerialization.data(withJSONObject: dict)
        return try JSONDecoder().decode(SynthesisRecipeRecord.self, from: data)
    }

    // MARK: tests

    func testLk99DispatchFailsAtLeastOne() throws {
        let recipe = try loadLk99Recipe()
        XCTAssertEqual(recipe.replicatedByIndependentLabs, 0,
                       "LK-99 stub must keep replicated_by_independent_labs=0 (RTSC.md §8.8).")

        let result = MaterialFalsifierDispatch.dispatch(
            sampleId: "lk99_lee2023_v1",
            tier1: nil,
            tier2: recipe,
            tier3Measurements: []
        )

        XCTAssertTrue(result.ok, "Dispatch ok=true means record landed (≠ falsifier PASS).")
        XCTAssertNotNil(result.newRecordID)
        // F-RTSC-3 FAILs on replicated=0 → aggregate must be
        // FAILS-AT-LEAST-ONE (overrides any multi-skip aggregate).
        XCTAssertEqual(result.aggregateVerdict, "FAILS-AT-LEAST-ONE")

        // Verify the JSON landed on disk and parses back round-trip.
        let outDir = MaterialFalsifierDispatch.verdictRecordsRoot
            .appendingPathComponent("lk99_lee2023_v1", isDirectory: true)
        let contents = try FileManager.default.contentsOfDirectory(at: outDir,
            includingPropertiesForKeys: nil)
        let jsons = contents.filter { $0.pathExtension == "json" }
        XCTAssertFalse(jsons.isEmpty, "verdict JSON must land under \(outDir.path)")

        if let first = jsons.first {
            let data = try Data(contentsOf: first)
            let decoded = try JSONDecoder().decode(MaterialVerdictRecord.self, from: data)
            XCTAssertEqual(decoded.domain, "material_verdict")
            XCTAssertEqual(decoded.verb, "dispatch")
            XCTAssertEqual(decoded.kind, "tier4_falsifier_dispatch")
            XCTAssertEqual(decoded.aggregateVerdict, "FAILS-AT-LEAST-ONE")
            XCTAssertFalse(decoded.absorbed, "g3: Tier 4 NEVER flips absorbed=true.")
            XCTAssertEqual(decoded.replicatedByIndependentLabs, 0,
                           "carried forward from tier2; never auto-incremented.")
            XCTAssertEqual(decoded.measurementGate, .open,
                           "GATE_OPEN — dispatch alone never closes the gate.")
            XCTAssertEqual(decoded.falsifierResults.count, 6)
            for r in decoded.falsifierResults {
                XCTAssertFalse(r.evidence.isEmpty,
                               "evidence must never be empty for \(r.id)")
            }
            let f3 = decoded.falsifierResults.first(where: { $0.id == "F-RTSC-3-replication" })
            XCTAssertEqual(f3?.status, "FAIL")
        }
    }

    func testAbsorbedAlwaysFalseEvenWithReplication() throws {
        // tier2 with replicated=3 (F-RTSC-3 PASS), tier1=nil, tier3=[] →
        // 5 of 6 SKIPPED + 1 PASS = INCONCLUSIVE-MULTIPLE-MISSING.
        // The contract under test: absorbed=false regardless of any verdict.
        let recipe = try makeRecipe(replicated: 3)
        let result = MaterialFalsifierDispatch.dispatch(
            sampleId: "synthetic_absorbed_invariant_test",
            tier1: nil,
            tier2: recipe,
            tier3Measurements: []
        )
        XCTAssertTrue(result.ok)
        XCTAssertEqual(result.aggregateVerdict, "INCONCLUSIVE-MULTIPLE-MISSING")
    }

    // MARK: 4-material batch — first non-LK-99 Tier 4 dispatches.
    //
    // Each test: load real Tier 1 / 2 / 3 inputs from exports/, dispatch,
    // assert the verdict JSON lands and at least one falsifier evaluated
    // (i.e. status ≠ SKIPPED-MISSING-INPUT). For YBCO, additionally assert
    // F-RTSC-3 PASS — the first replication=PASS in the project.

    /// Assert that a verdict JSON file exists on disk under the expected
    /// sample-id directory and decode-round-trips with absorbed=false.
    private func assertVerdictLanded(
        sampleId: String,
        expectedAggregate: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> MaterialVerdictRecord {
        let outDir = MaterialFalsifierDispatch.verdictRecordsRoot
            .appendingPathComponent(sampleId, isDirectory: true)
        let contents = try FileManager.default.contentsOfDirectory(
            at: outDir, includingPropertiesForKeys: nil)
        let jsons = contents.filter { $0.pathExtension == "json" }
        XCTAssertFalse(jsons.isEmpty,
            "verdict JSON must land under \(outDir.path)", file: file, line: line)
        // Round-trip-decode the most-recent file (lexicographic stamp ⇒ last).
        let latest = jsons.sorted { $0.lastPathComponent < $1.lastPathComponent }.last!
        let data = try Data(contentsOf: latest)
        let decoded = try JSONDecoder().decode(MaterialVerdictRecord.self, from: data)
        XCTAssertFalse(decoded.absorbed,
            "g3: Tier 4 NEVER flips absorbed=true.", file: file, line: line)
        XCTAssertEqual(decoded.measurementGate, .open,
            "GATE_OPEN — dispatch alone never closes the gate.", file: file, line: line)
        if let agg = expectedAggregate {
            XCTAssertEqual(decoded.aggregateVerdict, agg, file: file, line: line)
        }
        return decoded
    }

    /// Nb — F-RTSC-1 Meissner PASS (chi_volumetric=-1.0 < 0).
    /// tier1=nil (no Nb conductor record), tier2=nil (no Nb recipe).
    /// 4 falsifiers SKIPPED-MISSING-INPUT + 1 PASS + 1 SKIPPED ⇒
    /// INCONCLUSIVE-MULTIPLE-MISSING.
    func testNbDispatchMeissnerPass() throws {
        let meissner = try loadMeasurement(
            kindDir: "meissner_chi_t",
            filename: "nb_finnemore1966.json")
        XCTAssertEqual(meissner.kind, "meissner_chi_t")

        let result = MaterialFalsifierDispatch.dispatch(
            sampleId: "nb_finnemore1966_v1",
            tier1: nil,
            tier2: nil,
            tier3Measurements: [meissner]
        )
        XCTAssertTrue(result.ok)
        XCTAssertEqual(result.aggregateVerdict, "INCONCLUSIVE-MULTIPLE-MISSING")

        let decoded = try assertVerdictLanded(
            sampleId: "nb_finnemore1966_v1",
            expectedAggregate: "INCONCLUSIVE-MULTIPLE-MISSING")

        let f1 = decoded.falsifierResults.first(where: { $0.id == "F-RTSC-1-meissner" })
        XCTAssertEqual(f1?.status, "PASS",
            "F-RTSC-1 (Meissner) must PASS on Nb chi_volumetric=-1.0")
    }

    /// MgB2 — F-RTSC-2 R(T) PASS (measured Tc=39 K within [0.5·39, 2.0·39])
    /// + F-SC-2 McMillan PASS (predicted 39 K vs measured 39 K).
    /// tier1 synthesized from MP query (mp-763): predicted Tc=39 K.
    /// tier2=nil (no MgB2-specific recipe; the PIT recipes are NbTi). Two
    /// tier3 records (R(T) + Cp). Expect F-SC-2 + F-RTSC-2 PASS, F-RTSC-3
    /// SKIPPED (no recipe), others SKIPPED ⇒ PARTIAL (2 of 6 PASS).
    func testMgB2DispatchRtAndMcMillanPass() throws {
        let mgb2Conductor = try makeConductor(
            family: ConductorMaterial.mgB2.rawValue,
            compound: "MgB2",
            tcK: 39.0)
        let rT = try loadMeasurement(
            kindDir: "r_t",
            filename: "mgb2_budko2001.json")
        let cp = try loadMeasurement(
            kindDir: "specific_heat_c_p",
            filename: "mgb2_bouquet2001.json")

        let result = MaterialFalsifierDispatch.dispatch(
            sampleId: "mgb2_budko2001_v1",
            tier1: mgb2Conductor,
            tier2: nil,
            tier3Measurements: [rT, cp]
        )
        XCTAssertTrue(result.ok)

        let decoded = try assertVerdictLanded(sampleId: "mgb2_budko2001_v1")

        let fSc2 = decoded.falsifierResults.first(where: { $0.id == "F-SC-2-mcmillan-tc" })
        XCTAssertEqual(fSc2?.status, "PASS",
            "F-SC-2 must PASS — predicted Tc=39 K vs measured Tc=39 K (Δ=0)")
        let fRtsc2 = decoded.falsifierResults.first(where: { $0.id == "F-RTSC-2-r-of-t" })
        XCTAssertEqual(fRtsc2?.status, "PASS",
            "F-RTSC-2 must PASS — measured Tc=39 K ∈ [19.5, 78.0]")
    }

    /// YBCO — F-RTSC-3 replication=PASS (replicated_by_independent_labs=5).
    /// First non-LK-99, first replication-PASS in the project.
    /// tier1 = on-disk rebco_hts_baseline.json (REBCO, predicted Tc=92.5 K).
    /// tier2 = on-disk rebco_mocvd_2g_hts_tape.json (replicated=5).
    /// tier3 = ybco_wu1987.json (R(T), measured Tc=92 K).
    /// Expect F-RTSC-2 PASS + F-RTSC-3 PASS + F-SC-2 PASS, F-RTSC-1/F-SC-1/
    /// F-SC-3 SKIPPED ⇒ PARTIAL.
    func testYbcoDispatchReplicationFirstPass() throws {
        let ybcoConductor = try loadConductor("rebco_hts_baseline.json")
        let rebcoRecipe = try loadRecipe("rebco_mocvd_2g_hts_tape.json")
        XCTAssertEqual(rebcoRecipe.replicatedByIndependentLabs, 5,
            "REBCO MOCVD recipe must carry replicated_by_independent_labs=5.")
        let rT = try loadMeasurement(
            kindDir: "r_t",
            filename: "ybco_wu1987.json")

        let result = MaterialFalsifierDispatch.dispatch(
            sampleId: "ybco_wu1987_v1",
            tier1: ybcoConductor,
            tier2: rebcoRecipe,
            tier3Measurements: [rT]
        )
        XCTAssertTrue(result.ok)

        let decoded = try assertVerdictLanded(sampleId: "ybco_wu1987_v1")

        // The headline assertion of this whole batch — first replication-PASS.
        let f3 = decoded.falsifierResults.first(where: { $0.id == "F-RTSC-3-replication" })
        XCTAssertEqual(f3?.status, "PASS",
            "F-RTSC-3 replication=PASS — REBCO replicated_by_independent_labs=5 ≥ 2 (first non-LK-99 replication-PASS).")
        XCTAssertEqual(decoded.replicatedByIndependentLabs, 5,
            "Carry-forward from tier2; never auto-incremented.")
        // F-RTSC-2: measured Tc=92 K within [0.5·92.5, 2.0·92.5] = [46.25, 185.0]
        let fRtsc2 = decoded.falsifierResults.first(where: { $0.id == "F-RTSC-2-r-of-t" })
        XCTAssertEqual(fRtsc2?.status, "PASS")
    }

    /// Nb3Sn — F-SC-3 Hc2 WHH PASS (measured Hc2=27 T vs predicted ~30 T).
    /// tier1 synthesized: Nb3Sn predicted Tc=18 K, Hc2(4K)=30 T (Godeke WHH).
    /// tier2 = nbti_pit_wire_industrial.json (closest LTS PIT recipe — note
    /// the Nb3Sn vs NbTi family mismatch in evidence).
    /// tier3 = nb3sn_godeke2006.json (Hc2(T) ladder, measured Hc2(4.2K)=27 T).
    /// Expect F-SC-3 PASS + F-RTSC-3 PASS (NbTi recipe replicated=8 ≥ 2),
    /// F-RTSC-2 (R(T)) skipped, F-RTSC-1 skipped, F-SC-1 skipped, F-SC-2
    /// SKIPPED (no r_t measurement) ⇒ PARTIAL.
    func testNb3SnDispatchHc2WhhPass() throws {
        let nb3snConductor = try makeConductor(
            family: ConductorMaterial.ltsNb3Sn.rawValue,
            compound: "Nb3Sn",
            tcK: 18.0,
            hc2At4K: 30.0)
        let nbtiRecipe = try loadRecipe("nbti_pit_wire_industrial.json")
        let hc2 = try loadMeasurement(
            kindDir: "hc2_t",
            filename: "nb3sn_godeke2006.json")

        let result = MaterialFalsifierDispatch.dispatch(
            sampleId: "nb3sn_godeke2006_v1",
            tier1: nb3snConductor,
            tier2: nbtiRecipe,
            tier3Measurements: [hc2]
        )
        XCTAssertTrue(result.ok)

        let decoded = try assertVerdictLanded(sampleId: "nb3sn_godeke2006_v1")

        let fSc3 = decoded.falsifierResults.first(where: { $0.id == "F-SC-3-hc2-whh" })
        XCTAssertEqual(fSc3?.status, "PASS",
            "F-SC-3 must PASS — predicted Hc2=30 T vs measured Hc2=27 T (|Δ|/Hc2_pred=0.1)")
        // NbTi recipe is replicated_by_independent_labs=8 — also a PASS, though
        // family-mismatched (note in evidence). Carry-forward count = 8.
        let f3 = decoded.falsifierResults.first(where: { $0.id == "F-RTSC-3-replication" })
        XCTAssertEqual(f3?.status, "PASS",
            "F-RTSC-3 — NbTi PIT recipe replicated_by_independent_labs=8 ≥ 2 (family-mismatch caveat in evidence).")
    }
}
