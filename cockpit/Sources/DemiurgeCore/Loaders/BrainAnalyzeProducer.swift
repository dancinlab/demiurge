// BrainAnalyzeProducer — θ-2 engine tool for `brain + analyze` (κ-40 / D62).
//
// The SECOND cohort domain (after sscb / D55) wired to a real measuring
// engine tool. Producer = brian2 2.6.0 single LIF spike-rate (the lowest-
// hanging-fruit pick from domains/brain.md §2 — brian2 is pip-installable,
// has no heavy native deps, and a single-neuron LIF is the textbook
// algorithm-verification baseline).
//
// D61 / g_demiurge_pointer_only (ABSOLUTE):
//   • The Python script SSOT lives in `~/core/hexa-lang/stdlib/brain/
//     lif_brian2.py`, NOT in cockpit/scripts/. demiurge is a *pointer*
//     consumer — it spawns the script but never copies it. This is the
//     D17 hexa-matter precedent generalized: hexa-lang owns ALL reusable
//     producers; demiurge is consumer-only (g_stdlib_ownership / D15).
//   • Architecturally distinct from SSCBProducer (D55), which still
//     points to `cockpit/scripts/sscb_ngspice.py` — the sscb script
//     should migrate later, but the new pattern starts here.
//
// Architecture (mirrors SSCBProducer flow, but with hexa-lang script path):
//   1. locate `python3` (prefer /usr/bin/python3 — brian2 installed there
//      via `pip install --user brian2`)
//   2. locate `~/core/hexa-lang/stdlib/brain/lif_brian2.py`
//   3. spawn `python3 lif_brian2.py <output_dir>` — Python wraps the
//      brian2 simulation so the meta.json + spikes.json live in
//      <output_dir> with no shell quoting hazards
//   4. parse the `BRAIN_LIF_RESULT <json>` summary line from stderr
//   5. verify the meta + spikes artifacts exist on disk (defence-in-depth
//      — @F f6 evidence-over-assertion)
//   6. emit one typed `BrainRecord` under `exports/brain/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "brian2@<version>" — pins the SIMULATOR, not the model.
//     The LIF equation is textbook (Dayan & Abbott) with constant DC
//     drive, NOT a measured neuron. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them to closedMeasured
//     — that requires patch-clamp data fit + compartment model + Allen
//     Brain Atlas absorption, which is far beyond a single-neuron LIF.
//   • The measurement_VALUES are real (e.g. 142 Hz tonic firing,
//     CV_ISI ≈ 0 for deterministic drive). They are ALGORITHM VERIFICATION
//     — does brian2's `exact` integrator produce the textbook rate? — NOT
//     a measurement of any biological brain signal.
//   • If python3 is missing OR brian2 is not importable OR the script
//     crashes OR the summary JSON doesn't parse, returns ok=false and
//     writes no record. Silent success is forbidden.

import Foundation

/// One run of the brain producer — kept as plain text + a record ID so
/// cockpit chat + CLI pretty-print identically (D50).
public struct BrainAnalyzeResult: Sendable {
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

public enum BrainAnalyzeProducer {

    /// Default location for brain analyze records — sibling of
    /// `sscb/transient/`, `matter/parity/`, `component/geometry/`.
    public static let recordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("brain", isDirectory: true)

    /// Python candidates — /usr/bin/python3 first (brian2 was installed
    /// there via `pip install --user brian2`). brew python3 typically
    /// has PEP-668 lockout, so /usr/bin/python3 is the honest path.
    private static let pythonCandidates: [String] = [
        "/usr/bin/python3",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
    ]

    /// Locate a python3 binary — nil if none executable.
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

    /// Locate `~/core/hexa-lang/stdlib/brain/lif_brian2.py` — the script
    /// SSOT (D61). Demiurge spawns but never copies (g_demiurge_pointer_only).
    public static func locateScript() -> String? {
        let home = NSString(string: "~").expandingTildeInPath
        let candidate = "\(home)/core/hexa-lang/stdlib/brain/lif_brian2.py"
        if FileManager.default.fileExists(atPath: candidate) {
            return candidate
        }
        return nil
    }

    /// Run `python3 lif_brian2.py <recordsRoot>/<stamp>/` and persist one
    /// `BrainRecord` per call. Each call writes into its own timestamped
    /// subdirectory so consecutive runs do not stomp each other's
    /// meta.json / spikes.json artifacts.
    public static func runAnalyze() -> BrainAnalyzeResult {
        var lines: [String] = []

        guard let py = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(brain + analyze 는 brian2 단일 LIF 시뮬을 producer 로 "
                + "사용합니다 — pip 한 줄, /usr/bin/python3 -m pip install "
                + "--user brian2). g3 — silent success 금지.")
            return BrainAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — lif_brian2.py 를 찾지 못했습니다 "
                + "(~/core/hexa-lang/stdlib/brain/). D61: producer script "
                + "SSOT 는 hexa-lang 소유, demiurge 는 pointer 만 — script "
                + "가 hexa-lang 에 없으면 cockpit/scripts/ 에 만드는 것은 "
                + "FORBIDDEN (AGENTS.tape g_demiurge_pointer_only).")
            return BrainAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/brain/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = recordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ brain run dir mkdir 실패: \(error.localizedDescription)")
            return BrainAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the script. Merged stdout/stderr — brian2
        // logs to stderr (compiler fallback messages) and the script
        // writes BRAIN_LIF_RESULT line on stderr.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 lif_brian2.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return BrainAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the BRAIN_LIF_RESULT <json> line.
        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python3 = \(py)")
        lines.append("python3 lif_brian2.py — exit \(exitCode), "
            + "spikes=\(summary.spikeCount ?? 0)")
        if let v = summary.brian2Version {
            lines.append("brian2 version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["meta", "spikes"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — brain producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            if let err = summary.error {
                lines.append("error: \(err)")
            }
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            // Even on failure, do not silently succeed — return without
            // writing a typed record.
            return BrainAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Model + measurements come from re-reading
        // the meta.json (Python side is SSOT for the numbers — Swift just
        // witnesses + types).
        let metaName = verified["meta"] ?? "lif_brian2_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(BrainProducerMeta.self,
                                                    from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) "
                + "— record 미작성 (g3).")
            return BrainAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "brain_lif_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let bv = summary.brian2Version ?? meta.brian2Version ?? "unknown"
        let caveats: [String] = [
            "brian2 IS the instrument (IEEE-754 LIF integrator); 측정 숫자 "
            + "(예: 142 Hz tonic firing, CV_ISI≈0) 는 실제 — but the MODEL "
            + "is textbook LIF (Dayan & Abbott) with constant DC drive, "
            + "NOT a measured neuron. plausible-not-fitted, datasheet "
            + "absorption 아님 (g3).",
            "single LIF + constant drive 는 *algorithm verification* — "
            + "does brian2's exact integrator produce the textbook firing "
            + "rate? — 이지 실제 brain 신호 측정 아님. domains/brain.md "
            + "§2 의 proprietary gap (Sim4Life MDDT, COMSOL) 는 untouched.",
            "measurement_gate = GATE_OPEN 영구. closedMeasured 로 flip 하려면 "
            + "patch-clamp data fit + multi-compartment Hodgkin-Huxley + "
            + "Allen Brain Atlas absorption + bench-validated implant 가 "
            + "들어와야 함 — 본 producer 의 scope 를 한참 넘음.",
            "absorbed=true 절대 금지 — D17 / g_stdlib_ownership: script SSOT "
            + "는 hexa-lang (`stdlib/brain/lif_brian2.py`), demiurge 는 "
            + "consumer-pointer 만. 진짜 흡수는 hexa-lang 측 다음 phase.",
        ]

        let record = BrainRecord(
            interface: "demiurge:brain:analyze-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            equationSha256_16: meta.equationSha256_16,
            brian2Version: bv,
            model: meta.model,
            measurements: meta.measurements,
            artifacts: verified,
            provenance: BrainProvenance(
                absorbed: false,
                producer: "brian2@\(bv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ brain record JSON 쓰기 실패: \(error.localizedDescription)")
            return BrainAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output line for the user.
        let m = meta.measurements
        lines.append("---")
        lines.append("📸 brain analyze record → exports/brain/"
            + "\(stamp)/\(recordId).json")
        lines.append(String(format: "   spike_count=%d · firing_rate=%.1f Hz "
            + "· producer = brian2@%@", m.spikeCount, m.firingRateHz, bv))
        if let cv = m.cvIsi {
            lines.append(String(format: "   CV_ISI=%.3e (≈0 = 결정론적 "
                + "tonic firing — sanity OK)", cv))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — 실제 숫자 이지만 "
            + "textbook LIF (Dayan & Abbott), 측정 brain 신호 아님 "
            + "(g3, scope_caveats 4종 참조).")

        return BrainAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `~/core/hexa-lang/stdlib/brain/lif_brian2.py::main`.
    private struct BrainProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let equationSha256_16: String
        let brian2Version: String?
        let model: BrainModel
        let measurements: BrainMeasurements

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case equationSha256_16 = "equation_sha256_16"
            case brian2Version = "brian2_version"
            case model
            case measurements
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var brian2Version: String? = nil
        var spikeCount: Int? = nil
        var firingRateHz: Double? = nil
        var artifacts: [String: String] = [:]
        var error: String? = nil
    }

    /// Extract `BRAIN_LIF_RESULT <json>` from the merged Python stdout
    /// /stderr and decode the JSON payload. Tolerant of any other
    /// lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "BRAIN_LIF_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["brian2_version"] as? String { out.brian2Version = s }
            if let n = obj["spike_count"] as? Int { out.spikeCount = n }
            if let f = obj["firing_rate_hz"] as? Double { out.firingRateHz = f }
            if let arts = obj["artifacts"] as? [String: String] {
                out.artifacts = arts
            }
            if let e = obj["error"] as? String { out.error = e }
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
