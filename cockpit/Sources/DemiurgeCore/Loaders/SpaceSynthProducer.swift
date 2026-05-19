// SpaceSynthProducer — θ-2 engine tool for `space + synthesize`
// (ROI rank 8 ⭐⭐⭐⭐ per inbox/notes/absorption-empty-cells-research-
// 2026-05-20.md §3 space block; OpenMDAO multidisciplinary opt,
// NASA GSC-17177-1).
//
// EIGHTH cohort cell crossing the measuring-producer threshold AND the
// FIRST `synthesize`-verb cell on the space domain (sibling of space+
// analyze's Skyfield SGP4 producer). D61-compliant-from-birth — the
// Python substrate SSOT lives at
// `~/core/hexa-lang/stdlib/space/openmdao_mission.py` (NEVER in
// `cockpit/scripts/*.py` — see D61).
//
// D72 classify-FIRST: OpenMDAO is the same situation as scope+synth
// (generic MDO solver). At this commit, NO `kernels/mdo/` promotion
// exists in hexa-lang — substrate stays as a domain-local adapter.
// When scope+synthesize lands its OpenMDAO consumer (2 consumers =
// promotion candidate per D72), pickup the kernel promotion per
// `inbox/notes/openmdao-kernel-promotion-pickup.md`.
//
// Architecture (mirrors SpaceAnalyzeProducer + ScopeAnalyzeProducer):
//   1. locate `python3` (brew Python preferred — openmdao is pip-
//      installed under /opt/homebrew/lib/python3.X/site-packages)
//   2. locate `~/core/hexa-lang/stdlib/space/openmdao_mission.py` (D61)
//   3. spawn `python3 openmdao_mission.py <output_dir>` — substrate
//      runs the ScipyOptimizeDriver sweep, writes meta.json + NDJSON
//      trade table, emits an `OPENMDAO_MISSION_RESULT <json>` summary
//      line on stderr
//   4. parse the summary, verify the artifacts exist on disk
//      (defence-in-depth — @F f6)
//   5. emit one typed `SpaceSynthRecord` under
//      `exports/space/synthesize/<stamp>/`
//
// HONEST (g3 — non-negotiable):
//   • producer = "openmdao@<v>+scipy@<v>" — the optimiser + numerical
//     backend pair. ScipyOptimizeDriver SLSQP IS a real MDO solver,
//     but the model is SCOPING-LEVEL (single-discipline Tsiolkovsky
//     rocket-equation rollup; no AOCS / thermal / staging / gravity
//     loss / drag).
//   • absorbed = false ALWAYS — OpenMDAO is an EXTERNAL Python library
//     (pip install). Same banned-absorbed stance as Skyfield (space+
//     analyze), POPPY (scope+analyze), ngspice (sscb+analyze).
//   • measurement_gate = GATE_OPEN영구 — closedMeasured would require
//     GMAT coupling (ROI rank 15, binary download, deliberately
//     skipped this round per spec) + multi-discipline coupling +
//     honest-input ascertainment.
//   • If python3 / openmdao / script is missing OR the Python crashes
//     OR the summary JSON doesn't parse, returns ok=false and writes
//     no record. Silent success is forbidden.

import Foundation

/// One run of the SpaceSynth producer — text + a record ID so cockpit
/// chat + CLI pretty-print identically (D50).
public struct SpaceSynthResult: Sendable {
    /// Did the producer report ok=true AND was a record written?
    public let ok: Bool
    /// Newline-joined lines for stdout / chat panel.
    public let lines: [String]
    /// The new record ID, if a record was written.
    public let newRecordID: String?

    public init(ok: Bool, lines: [String], newRecordID: String?) {
        self.ok = ok
        self.lines = lines
        self.newRecordID = newRecordID
    }

    public var text: String { lines.joined(separator: "\n") }
}

public enum SpaceSynthProducer {

    /// Default location for SpaceSynth MDO records — sibling of
    /// `space/orbit/` (the SpaceAnalyzeProducer artifact root).
    public static let synthRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("space/synthesize", isDirectory: true)

    /// Default candidate paths for `python3` — prefer brew Python so
    /// pip-installed OpenMDAO is on sys.path.
    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    /// D61 SSOT — substrate lives in the hexa-lang sibling repo,
    /// NEVER in `cockpit/scripts/`.
    public static let scriptPath: String =
        NSString(string: "~/core/hexa-lang/stdlib/space/openmdao_mission.py")
            .expandingTildeInPath

    /// Locate python3 — nil if not found (honest gap path).
    public static func locatePython() -> String? {
        let fm = FileManager.default
        for c in pythonCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // PATH fallback via `which`.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "python3"]
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

    public static func locateScript() -> String? {
        FileManager.default.fileExists(atPath: scriptPath) ? scriptPath : nil
    }

    /// Run `python3 openmdao_mission.py <synthRecordsRoot>/<stamp>/`
    /// and persist one `SpaceSynthRecord` per call. Each call writes
    /// into its own timestamped subdirectory so consecutive runs do
    /// not stomp each other's trade NDJSON artifacts.
    public static func runSynthesize() -> SpaceSynthResult {
        var lines: [String] = []

        guard let py = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장 — OpenMDAO 가 brew "
                + "Python site-packages 에 설치되어 있어야 합니다). "
                + "space + synthesize 는 OpenMDAO ScipyOptimizeDriver 를 "
                + "producer 로 사용합니다 (NASA GSC-17177-1 SSOT, g3 — "
                + "silent success 금지).")
            return SpaceSynthResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — openmdao_mission.py 를 찾지 "
                + "못했습니다 (D61 SSOT: ~/core/hexa-lang/stdlib/space/"
                + "openmdao_mission.py). sibling repo hexa-lang 의 "
                + "stdlib/space/ 에 substrate 가 존재해야 합니다 (g3).")
            return SpaceSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/space/synthesize/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = synthRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ space synthesize dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return SpaceSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the substrate. OpenMDAO + scipy resolution
        // is the script's job (importlib); Swift just resolves python3.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — substrate writes the
                                    // OPENMDAO_MISSION_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 openmdao_mission.py "
                + "실행 실패: \(error.localizedDescription) (g3).")
            return SpaceSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the headline artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python3 = \(py)")
        lines.append("openmdao_mission.py — exit \(exitCode), "
            + "samples=\(summary.samplesCount ?? 0)")
        if let ov = summary.openmdaoVersion, let sv = summary.scipyVersion {
            lines.append("openmdao = \(ov) · scipy = \(sv)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["meta", "trade_ndjson"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — openmdao_mission ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return SpaceSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Model + samples + best come from re-
        // reading the meta.json (the Python side is the SSOT — Swift
        // just witnesses + types).
        let metaName = verified["meta"] ?? "space_synthesize.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                SpaceSynthProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return SpaceSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "space_synth_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let openmdaoV = summary.openmdaoVersion ?? meta.openmdaoVersion ?? "unknown"
        let scipyV = summary.scipyVersion ?? meta.scipyVersion ?? "unknown"
        let numpyV = meta.numpyVersion ?? "unknown"
        let producer = "openmdao@\(openmdaoV)+scipy@\(scipyV)"

        // Honest scope_caveats — surface every "scoping-level" weakness
        // so downstream consumers cannot mistake this for a mission-
        // designed verdict (g3).
        let caveats: [String] = [
            "OpenMDAO ScipyOptimizeDriver (SLSQP) 의 converged 출력 — "
            + "최적화 자체는 deterministic 하지만 모델은 SCOPING-LEVEL: "
            + "단일 discipline (Tsiolkovsky 로켓방정식), gravity loss / "
            + "atmospheric drag / staging / AOCS / thermal / comms 일체 "
            + "포함 안 함. mission design 결론 아님 (g3).",
            "input 은 텍스트북 nominal — Isp=320 s, m_dry=1500 kg, "
            + "propellant_budget=12000 kg 모두 generic upper-stage 값. "
            + "실제 launcher spec sheet 흡수 아님 (g3 — 측정 input 부재).",
            "GMAT 결합 부재 — flight-validated mission profile 은 "
            + "별도 ROI rank 15 셀 (binary download, 본 라운드 deliberately "
            + "skip). closedMeasured 로 게이트 닫으려면 GMAT 또는 "
            + "AGI STK 의 verified scenario 와 trade point parity 필요.",
            "propellant constraint 가 active 한 sample 에서는 trade 가 "
            + "propellant budget 의 hard wall 에 pinning — optimiser 가 "
            + "ΔV upper-bound 쪽으로 밀려가는 corner. 본 record 의 "
            + "samples[].solver.propellant_constraint_active 로 surface.",
            "OpenMDAO 는 EXTERNAL Python 라이브러리 (pip install) — "
            + "hexa-lang / hexa-arch 로 absorbed 아님 (D17 — demiurge "
            + "consumer, upstream tool owner). absorbed=true 절대 금지.",
            "D72 kernel-promotion 후보 — OpenMDAO 는 generic MDO (도메인 "
            + "독립). scope+synthesize 가 두 번째 consumer 로 OpenMDAO "
            + "를 채택하면 ~/core/hexa-lang/stdlib/kernels/mdo/ 로 "
            + "promotion 후보. pickup 노트: "
            + "inbox/notes/openmdao-kernel-promotion-pickup.md.",
        ]

        let cite = "NASA GSC-17177-1 (OpenMDAO 오픈소스 SSOT, BSD-3, "
            + "Glenn Research Center · https://openmdao.org · "
            + "MDO framework for multidisciplinary analysis & optimisation)"

        let record = SpaceSynthRecord(
            interface: "demiurge:space:synthesize-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            inputSha256_16: meta.inputSha256_16,
            openmdaoVersion: openmdaoV,
            scipyVersion: scipyV,
            numpyVersion: numpyV,
            model: meta.model,
            samples: meta.samples,
            best: meta.best,
            runAtUtc: meta.runAtUtc,
            artifacts: verified,
            provenance: SpaceSynthProvenance(
                absorbed: false,
                producer: producer,
                measurementGate: .open,
                scopeCaveats: caveats,
                atlasCiteBlock: cite))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ space synthesize record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return SpaceSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output for the user.
        lines.append("---")
        lines.append("📸 space synthesize record → "
            + "exports/space/synthesize/\(stamp)/\(recordId).json")
        if let best = meta.best {
            lines.append(String(format:
                "   best trade · m_initial=%.0f kg → ΔV=%.1f m/s → "
                + "m_payload=%.1f kg (m_prop=%.1f kg)",
                best.mInitialKg, best.dvMps, best.mPayloadKg,
                best.mPropellantKg))
        }
        for sample in meta.samples {
            let opt = sample.optimised
            let activeTag = sample.solver.propellantConstraintActive
                ? " · prop_budget ACTIVE" : ""
            lines.append(String(format:
                "   sample m_initial=%.0f kg · ΔV=%.1f m/s · "
                + "payload=%.1f kg · solver_ok=%@%@",
                sample.mInitialKg, opt.dvMps, opt.mPayloadKg,
                sample.solver.ok ? "true" : "false", activeTag))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — scoping-level "
            + "MDO (1 discipline · Tsiolkovsky · textbook inputs). "
            + "flight-validated mission 흡수 아님 (g3, scope_caveats "
            + "6종 참조).")
        lines.append("   atlas: \(cite)")

        return SpaceSynthResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the substrate's `meta.json`. Kept in
    /// step with `~/core/hexa-lang/stdlib/space/openmdao_mission.py::main`'s
    /// meta dict.
    private struct SpaceSynthProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let inputSha256_16: String
        let openmdaoVersion: String?
        let scipyVersion: String?
        let numpyVersion: String?
        let model: SpaceSynthModel
        let samples: [SpaceSynthSample]
        let best: SpaceSynthBest?
        let runAtUtc: String

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case inputSha256_16 = "input_sha256_16"
            case openmdaoVersion = "openmdao_version"
            case scipyVersion = "scipy_version"
            case numpyVersion = "numpy_version"
            case model
            case samples
            case best
            case runAtUtc = "run_at_utc"
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var openmdaoVersion: String? = nil
        var scipyVersion: String? = nil
        var samplesCount: Int? = nil
        var bestDvMps: Double? = nil
        var bestMPayloadKg: Double? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `OPENMDAO_MISSION_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of other
    /// lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "OPENMDAO_MISSION_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["openmdao_version"] as? String {
                out.openmdaoVersion = s
            }
            if let s = obj["scipy_version"] as? String { out.scipyVersion = s }
            if let n = obj["samples_count"] as? Int { out.samplesCount = n }
            if let d = obj["best_dv_mps"] as? Double { out.bestDvMps = d }
            if let d = obj["best_m_payload_kg"] as? Double {
                out.bestMPayloadKg = d
            }
            if let arts = obj["artifacts"] as? [String: String] {
                out.artifacts = arts
            }
        }
        return out
    }

    private static func lastLines(_ text: String, _ n: Int) -> String {
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false)
        guard lines.count > n else {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return lines.suffix(n).joined(separator: "\n")
    }
}
