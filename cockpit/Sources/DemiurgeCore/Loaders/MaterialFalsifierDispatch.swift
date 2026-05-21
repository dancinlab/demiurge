// MaterialFalsifierDispatch — RTSC.md §8.7 Tier 4 dispatcher.
//
// THIS FILE IS THE THIN COCKPIT WRAPPER. The 273-LOC algorithm portion
// (F3.b-F3.h: 6 per-falsifier evaluators + aggregate verdict rule) was
// migrated to `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa`
// per D114 Phase B audit (audit § 1.3 + § 4) and D116 destination doctrine
// (sibling repos = docs only · substrate code = hexa-lang/stdlib).
//
// What stays cockpit-side (audit § 1.3 OK):
//   - F1 MaterialVerdictResult typed-record return surface.
//   - F2 verdictRecordsRoot URL constant.
//   - F3 preamble diagnostics.
//   - F3.a tier3 bucketing by kind (thin filter).
//   - F3.i stamp + carry-forward + InputTriple build.
//   - F3.j static §-citation literals (8 strings).
//   - F3.k MaterialVerdictRecord construction (Codable SSOT).
//   - F3.l mkdir + JSONEncoder write (JSONEncoder ownership ⇒
//     byte-identical on-disk JSON wire shape preserved).
//   - F3.m diagnostics.
//
// What was migrated to hexa-lang (audit § 1.3 R3-violator bands):
//   - F3.b F-SC-1 BCS isotope evaluator (50 → 25 LOC).
//   - F3.c F-SC-2 McMillan Tc evaluator (38 → 28 LOC).
//   - F3.d F-SC-3 Hc2 WHH evaluator (48 → 30 LOC).
//   - F3.e F-RTSC-1 Meissner evaluator (40 → 22 LOC).
//   - F3.f F-RTSC-2 R(T) drop evaluator (41 → 26 LOC).
//   - F3.g F-RTSC-3 replication evaluator (40 → 24 LOC).
//   - F3.h aggregate verdict (16 LOC pure rule).
//   - F3.j dynamic caveats (count-driven + replicated=0 — travel with
//     the aggregate; static §-citation literals stay cockpit-side).
//
// Wire protocol (hexa-side stdlib/rtsc/falsifier_dispatch.hexa):
//   INPUT  — JSON object on disk (path passed as argv[1]) describing the
//            tier-bucketed inputs already extracted by this wrapper.
//   OUTPUT — JSON object on stdout with shape:
//              {results: [...6 entries...],
//               aggregate_verdict: <string>,
//               dynamic_caveats: [<string>, ...]}
//
// Regression oracle (audit § 3 + § 4.5 + cockpit/Tests/DemiurgeCoreTests/
// MaterialFalsifierDispatchTests.swift): the 5 XCTest cases assert
// field-level invariants (per-id status, aggregateVerdict, absorbed=false,
// measurementGate=GATE_OPEN, replicatedByIndependentLabs carry-forward,
// non-empty evidence). The thin wrapper preserves the (sampleId, tier1,
// tier2, tier3Measurements) → MaterialVerdictResult signature and the
// on-disk file layout under exports/material_verdict/<sample_id>/<stamp>.json.
//
// g3 honest stance (RTSC.md §8.7 → §8.8 — unchanged from pre-migration):
//   - Dispatching SUCCEEDED (record written) ≠ falsifier PASSED.
//   - Missing input ⇒ SKIPPED-MISSING-INPUT (NEVER fabricated PASS).
//   - `replicatedByIndependentLabs` carried forward from Tier 2.
//   - absorbed=false ALWAYS — Tier 4 NEVER flips absorbed=true.
//   - Hexa binary or script missing ⇒ ok=false with explicit engine-tool-gap
//     banner; no silent success.
//
// @D g_cockpit_isolation: same exports tree as pre-migration —
// `RecordLoader.exportsRoot/material_verdict/<sample_id>/<stamp>.json`.

import Foundation

public struct MaterialVerdictResult: Sendable {
    public let ok: Bool
    public let lines: [String]
    public let newRecordID: String?
    public let aggregateVerdict: String?
    public init(ok: Bool, lines: [String], newRecordID: String?, aggregateVerdict: String?) {
        self.ok = ok
        self.lines = lines
        self.newRecordID = newRecordID
        self.aggregateVerdict = aggregateVerdict
    }
    public var text: String { lines.joined(separator: "\n") }
}

public enum MaterialFalsifierDispatch {

    public static let verdictRecordsRoot: URL =
        RecordLoader.exportsRoot.appendingPathComponent("material_verdict", isDirectory: true)

    // MARK: hexa script + binary path resolution

    /// Candidate hexa-lang checkouts to probe for the migrated script.
    /// Resolution strategy:
    ///   1. Env override `HEXA_FALSIFIER_DISPATCH_PATH` (test / one-off).
    ///   2. Main hexa-lang worktree at `~/core/hexa-lang`.
    ///   3. Phase B branch worktree at `~/core/hexa-lang-falsifier-dispatch`
    ///      (pre-merge; this PR has not landed on main yet).
    ///   4. nil → surfaces as ok=false + engine-tool-gap banner.
    public static func locateFalsifierDispatchScript() -> String? {
        let fm = FileManager.default
        let env = ProcessInfo.processInfo.environment
        if let override = env["HEXA_FALSIFIER_DISPATCH_PATH"],
           !override.isEmpty, fm.fileExists(atPath: override) {
            return override
        }
        let candidates = [
            NSString(string: "~/core/hexa-lang").expandingTildeInPath,
            NSString(string: "~/core/hexa-lang-falsifier-dispatch").expandingTildeInPath,
        ]
        for root in candidates {
            let path = root + "/stdlib/rtsc/falsifier_dispatch.hexa"
            if fm.fileExists(atPath: path) {
                return path
            }
        }
        return nil
    }

    private static let hexaCandidates: [String] = [
        NSString(string: "~/.hx/bin/hexa").expandingTildeInPath,
        "/opt/homebrew/bin/hexa",
        "/usr/local/bin/hexa",
    ]

    public static func locateHexa() -> String? {
        let fm = FileManager.default
        for c in hexaCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "hexa"]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = Pipe()
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            let out = (String(data: data, encoding: .utf8) ?? "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !out.isEmpty, fm.isExecutableFile(atPath: out) {
                return out
            }
        } catch {
            return nil
        }
        return nil
    }

    // MARK: hexa wire shape (output envelope decoder)

    private struct FalsifierEnvelope: Decodable {
        let results: [MaterialVerdictRecord.FalsifierResult]
        let aggregateVerdict: String
        let dynamicCaveats: [String]
        enum CodingKeys: String, CodingKey {
            case results
            case aggregateVerdict = "aggregate_verdict"
            case dynamicCaveats = "dynamic_caveats"
        }
    }

    // MARK: dispatch entry

    /// Tier 4 dispatch. The three tier inputs are optional / open-ended:
    ///   - `tier1` — ConductorRecord providing predicted Tc + Hc2(0).
    ///     nil ⇒ F-SC-1, F-SC-2, F-SC-3 all SKIPPED-MISSING-INPUT.
    ///   - `tier2` — SynthesisRecipeRecord providing replication count.
    ///     nil ⇒ F-RTSC-3 SKIPPED-MISSING-INPUT (replication unknown).
    ///   - `tier3Measurements` — zero or more MeasurementRecord; this
    ///     function picks by `kind`:
    ///       "r_t"            → F-RTSC-2 + F-SC-2
    ///       "meissner_chi_t" → F-RTSC-1
    ///       "hc2_t"          → F-SC-3
    ///       "isotope_effect" → F-SC-1
    ///     Empty ⇒ all measurement-dependent falsifiers SKIPPED.
    public static func dispatch(
        sampleId: String,
        tier1: ConductorRecord?,
        tier2: SynthesisRecipeRecord?,
        tier3Measurements: [MeasurementRecord]
    ) -> MaterialVerdictResult {
        var lines: [String] = []
        lines.append("[tier4 dispatch] sample_id=\(sampleId)")
        lines.append("  tier1 (ConductorRecord)        : \(tier1 == nil ? "MISSING" : "present")")
        lines.append("  tier2 (SynthesisRecipeRecord)  : \(tier2 == nil ? "MISSING" : "present")")
        lines.append("  tier3 (MeasurementRecord[])    : count=\(tier3Measurements.count)")

        // ─── F3.a Tier 3 measurement bucketing (stays cockpit) ────────
        let rT = tier3Measurements.first(where: { $0.kind == "r_t" })
        let meissner = tier3Measurements.first(where: { $0.kind == "meissner_chi_t" })
        let hc2 = tier3Measurements.first(where: { $0.kind == "hc2_t" })
        let isotope = tier3Measurements.first(where: { $0.kind == "isotope_effect" })

        // ─── Invoke hexa-side dispatcher ──────────────────────────────
        let hexaEnvelope: FalsifierEnvelope
        do {
            hexaEnvelope = try invokeHexaDispatcher(
                tier1: tier1,
                tier2: tier2,
                rT: rT,
                meissner: meissner,
                hc2: hc2,
                isotope: isotope
            )
        } catch let err as DispatchError {
            lines.append("[tier4 dispatch] engine-tool-gap: \(err.message)")
            return MaterialVerdictResult(
                ok: false,
                lines: lines,
                newRecordID: nil,
                aggregateVerdict: nil
            )
        } catch {
            lines.append("[tier4 dispatch] engine-tool-gap: \(error.localizedDescription)")
            return MaterialVerdictResult(
                ok: false,
                lines: lines,
                newRecordID: nil,
                aggregateVerdict: nil
            )
        }

        let results = hexaEnvelope.results
        let aggregate = hexaEnvelope.aggregateVerdict

        // ─── F3.i Stamp + record-id ───────────────────────────────────
        let rawStamp = ISO8601DateFormatter().string(from: Date())
        let stamp = rawStamp.replacingOccurrences(of: ":", with: "-")

        // ─── F3.i Carry-forward replication count ─────────────────────
        let replicated = tier2?.replicatedByIndependentLabs ?? 0

        // ─── F3.i InputTriple build ───────────────────────────────────
        let inputTriple = MaterialVerdictRecord.InputTriple(
            tier1SimRecordId: tier1.map { "conductor:\($0.compound):\($0.stamp)" },
            tier2RecipeRecordId: tier2.map { "synthesis_recipe:\($0.targetCompound):\($0.stamp)" },
            tier3MeasurementRecordIds: tier3Measurements.map { "measurement:\($0.kind):\($0.sampleId):\($0.stamp)" }
        )

        // ─── F3.j Static caveats (SSOT pointer text) + dynamic caveats from hexa ─
        var caveats: [String] = [
            "RTSC.md §8.7 honest限界: Tier 4 PASS still requires a separate meta-cohort (cross-lab attestation) to flip absorbed=true. This record has absorbed=false unconditionally.",
            "replicated_by_independent_labs is carried forward from tier2; never auto-incremented by this dispatcher.",
            "measurement_gate remains GATE_OPEN — a dispatch verdict alone does not close the measurement gate."
        ]
        caveats.append(contentsOf: hexaEnvelope.dynamicCaveats)

        let citations: [String] = [
            "RTSC.md §8.4 (9-test characterization matrix)",
            "RTSC.md §8.5 (handoff schema)",
            "RTSC.md §8.7 Tier 4 (falsifier dispatch)",
            "RTSC.md §8.8 (g3 honest stance — RTSC claims never absorbed=true)",
            "hexa-rtsc verify/calc_bcs.hexa (F-SC-1)",
            "hexa-rtsc verify/calc_mcmillan.hexa (F-SC-2)",
            "hexa-rtsc verify/calc_hc2_48t.hexa (F-SC-3)",
            "hexa-rtsc verify/falsifier_check.hexa (6-falsifier registry)"
        ]

        // ─── F3.k Build the record ────────────────────────────────────
        let record = MaterialVerdictRecord(
            stamp: stamp,
            sampleId: sampleId,
            inputRecords: inputTriple,
            falsifierResults: results,
            aggregateVerdict: aggregate,
            replicatedByIndependentLabs: replicated,
            scopeCaveats: caveats,
            citations: citations
        )

        // ─── F3.l Write JSON ──────────────────────────────────────────
        let outDir = verdictRecordsRoot.appendingPathComponent(sampleId, isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)
        } catch {
            lines.append("[tier4 dispatch] mkdir failed: \(error.localizedDescription)")
            return MaterialVerdictResult(ok: false, lines: lines, newRecordID: nil, aggregateVerdict: aggregate)
        }

        let outFile = outDir.appendingPathComponent("\(stamp).json")
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data: Data
        do {
            data = try encoder.encode(record)
        } catch {
            lines.append("[tier4 dispatch] encode failed: \(error.localizedDescription)")
            return MaterialVerdictResult(ok: false, lines: lines, newRecordID: nil, aggregateVerdict: aggregate)
        }
        do {
            try data.write(to: outFile, options: .atomic)
        } catch {
            lines.append("[tier4 dispatch] write failed: \(error.localizedDescription)")
            return MaterialVerdictResult(ok: false, lines: lines, newRecordID: nil, aggregateVerdict: aggregate)
        }

        // ─── F3.m Return + diagnostics ────────────────────────────────
        let recordID = "material_verdict:\(sampleId):\(stamp)"
        lines.append("[tier4 dispatch] aggregate=\(aggregate)")
        for r in results {
            lines.append("  · \(r.id) — \(r.status) — \(r.name)")
        }
        lines.append("[tier4 dispatch] wrote: \(outFile.path)")
        lines.append("[tier4 dispatch] honest g3: absorbed=false (Tier 4 verdict ≠ absorbed-promotion)")
        return MaterialVerdictResult(ok: true, lines: lines, newRecordID: recordID, aggregateVerdict: aggregate)
    }

    // MARK: hexa subprocess plumbing

    private struct DispatchError: Error {
        let message: String
    }

    /// Build the JSON envelope expected by stdlib/rtsc/falsifier_dispatch.hexa,
    /// spawn `hexa run`, and decode the output JSON. Throws DispatchError on
    /// any honest-gap (binary missing · script missing · spawn fail · non-zero
    /// rc · JSON decode fail).
    private static func invokeHexaDispatcher(
        tier1: ConductorRecord?,
        tier2: SynthesisRecipeRecord?,
        rT: MeasurementRecord?,
        meissner: MeasurementRecord?,
        hc2: MeasurementRecord?,
        isotope: MeasurementRecord?
    ) throws -> FalsifierEnvelope {
        guard let hexa = locateHexa() else {
            throw DispatchError(message:
                "`hexa` 바이너리 미발견 (~/.hx/bin/hexa 또는 PATH). " +
                "falsifier dispatcher 는 hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa 실행 필요 (g3).")
        }
        guard let script = locateFalsifierDispatchScript() else {
            throw DispatchError(message:
                "stdlib/rtsc/falsifier_dispatch.hexa 미발견. " +
                "기대 경로: ~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa (PR merge 후) 또는 " +
                "~/core/hexa-lang-falsifier-dispatch/stdlib/rtsc/falsifier_dispatch.hexa (pre-merge worktree). g3.")
        }

        // ─── Build hexa input envelope ────────────────────────────────
        var env: [String: Any] = [
            "isotope_present":  isotope != nil,
            "t1_present":       tier1 != nil,
            "hc2_present":      hc2 != nil,
            "meissner_present": meissner != nil,
            "rt_present":       rT != nil,
            "t2_present":       tier2 != nil,
        ]
        if let isotope = isotope {
            env["isotope_stamp"] = isotope.stamp
            if let alphaPoint = isotope.dataPoints.first(where: { $0.dependentVarName == "alpha" }) {
                env["isotope_alpha"] = alphaPoint.dependentVarValue
            }
        }
        if let t1 = tier1 {
            env["t1_tc_k"] = t1.spec.tcK
            if let hc2At4K = t1.spec.hc2TAt4K { env["t1_hc2_at_4k"] = hc2At4K }
        }
        if let hc2 = hc2, let measuredHc2 = hc2.headline.hc2T {
            env["hc2_measured"] = measuredHc2
        }
        if let m = meissner {
            env["meissner_stamp"] = m.stamp
            if let chi = m.headline.chiVolumetric { env["meissner_chi"] = chi }
        }
        if let rt = rT {
            env["rt_stamp"] = rt.stamp
            if let tcK = rt.headline.tcK { env["rt_tc_k"] = tcK }
        }
        if let t2 = tier2 {
            env["t2_replicated"] = t2.replicatedByIndependentLabs
        }

        // ─── Tempfile for input envelope ──────────────────────────────
        let tmpDir = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tmpFile = tmpDir.appendingPathComponent("falsifier_dispatch_input_\(UUID().uuidString).json")
        let inputData: Data
        do {
            inputData = try JSONSerialization.data(withJSONObject: env, options: [.sortedKeys])
        } catch {
            throw DispatchError(message:
                "hexa input envelope JSONSerialization failed: \(error.localizedDescription)")
        }
        do {
            try inputData.write(to: tmpFile, options: .atomic)
        } catch {
            throw DispatchError(message:
                "hexa input tempfile write failed: \(error.localizedDescription)")
        }
        defer { try? FileManager.default.removeItem(at: tmpFile) }

        // ─── Spawn ────────────────────────────────────────────────────
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: hexa)
        proc.arguments = ["run", script, tmpFile.path]

        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        proc.standardOutput = stdoutPipe
        proc.standardError = stderrPipe

        var stdoutData = Data()
        var exitCode: Int32 = -1
        do {
            try proc.run()
            stdoutData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
            // Drain stderr so the pipe doesn't fill; surface tail in error path.
            _ = stderrPipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
        } catch {
            throw DispatchError(message:
                "hexa run falsifier_dispatch.hexa spawn failed: \(error.localizedDescription)")
        }
        if exitCode != 0 {
            let stderrTail = String(decoding: stdoutData, as: UTF8.self)
                .split(separator: "\n").suffix(3).joined(separator: " · ")
            throw DispatchError(message:
                "hexa run falsifier_dispatch.hexa rc=\(exitCode) (tail: \(stderrTail))")
        }

        // ─── Decode output envelope ───────────────────────────────────
        // Hexa emits log lines mixed with the JSON pretty-print. Locate
        // the first '{' — the pretty-printer always starts the result
        // object at column 0 in our protocol.
        let raw = String(decoding: stdoutData, as: UTF8.self)
        guard let jsonStart = raw.firstIndex(of: "{") else {
            throw DispatchError(message:
                "hexa stdout did not contain a JSON object — \(raw.prefix(120))")
        }
        let jsonText = String(raw[jsonStart...])
        guard let jsonData = jsonText.data(using: .utf8) else {
            throw DispatchError(message: "hexa stdout JSON not UTF-8")
        }
        do {
            return try JSONDecoder().decode(FalsifierEnvelope.self, from: jsonData)
        } catch {
            let preview = String(jsonText.prefix(200))
            throw DispatchError(message:
                "hexa output envelope decode failed: \(error.localizedDescription) — preview: \(preview)")
        }
    }
}
