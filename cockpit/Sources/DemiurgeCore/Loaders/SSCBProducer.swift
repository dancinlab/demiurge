// SSCBProducer — θ-2 engine tool for `sscb + analyze` (κ-34 / D55).
//
// The FIRST cohort domain (out of the 13 surveyed in domains/*.md)
// wired to a real measuring engine tool — chip / component / matter
// were the "deep" / hexa-lang-owner pillars; SSCB is the first
// breadth-survey cohort that crosses the producer threshold.
//
// Architecture (mirrors FreeCADBIPVProducer + MatterAnalyzer):
//   1. locate `ngspice` (brew → /opt/homebrew/bin, then PATH)
//   2. locate `cockpit/scripts/sscb_ngspice.py`
//   3. spawn `python3 sscb_ngspice.py <output_dir>` — Python wraps the
//      ngspice invocation so the netlist + log + meta.json all live in
//      <output_dir> with no shell quoting hazards
//   4. parse the `SSCB_NGSPICE_RESULT <json>` summary line from stderr
//   5. verify the .cir / .log / .raw / .meta.json artifacts exist on
//      disk (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `SSCBRecord` under
//      `exports/sscb/transient/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "ngspice@<version>" — pins the simulator, not the
//     device model. The netlist is plausible (HEXA-SSCB mk1 topology
//     from domains/sscb.md §1) but the SiC switch is a generic
//     R_on/R_off model, NOT a Wolfspeed C3M0021120K .lib. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them to closedMeasured
//     — that requires a bench-validated device model + paralleled-die
//     thermal coupling, which lives in a later phase.
//   • The measurement_VALUES are real (e.g. interrupt_ratio ≈ 0.35 at
//     t=1.5 µs with the generic snubber). They surface the honest gap
//     between the HEXA-SSCB mk1 ≤ 1 µs target and what a naïve snubber
//     can deliver — that gap is the POINT of the record, not a defect.
//   • If ngspice is missing OR the Python script crashes OR the
//     summary JSON doesn't parse, returns ok=false and writes no
//     record. Silent success is forbidden.

import Foundation

/// One run of the SSCB producer — kept as plain text + a record ID so
/// cockpit chat + CLI pretty-print identically (D50).
public struct SSCBAnalyzeResult: Sendable {
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

public enum SSCBProducer {

    /// Default location for SSCB transient records — sibling of
    /// `chip/noc/f1f2/records/`, `component/geometry/`, `matter/parity/`.
    public static let transientRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("sscb/transient", isDirectory: true)

    /// Default candidate paths for `ngspice` (brew is the macOS path).
    private static let ngspiceCandidates: [String] = [
        "/opt/homebrew/bin/ngspice",
        "/usr/local/bin/ngspice",
        "/usr/bin/ngspice",
    ]

    /// Locate the ngspice binary — nil if not installed (honest gap path).
    public static func locateNgspice() -> String? {
        let fm = FileManager.default
        for c in ngspiceCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // PATH fallback via `which`.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "ngspice"]
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

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. Migrated 2026-05-20 κ-54 round
    /// from `cockpit/scripts/sscb_ngspice.py`.
    public static func locateScript() -> String? {
        let path = NSString(
            string: "~/core/hexa-lang/stdlib/sscb/ngspice.py"
        ).expandingTildeInPath
        return FileManager.default.fileExists(atPath: path) ? path : nil
    }

    /// Run `python3 sscb_ngspice.py <transientRecordsRoot>/<stamp>/` and
    /// persist one `SSCBRecord` per call. Each call writes into its
    /// own timestamped subdirectory so consecutive runs do not stomp
    /// each other's .raw / .log artifacts.
    public static func runAnalyze() -> SSCBAnalyzeResult {
        var lines: [String] = []

        guard let ngs = locateNgspice() else {
            lines.append("⏳ engine tool gap — `ngspice` 를 찾지 못했습니다 "
                + "(brew install ngspice 필요). sscb + analyze 는 "
                + "ngspice 의 transient 시뮬레이션을 producer 로 사용합니다 "
                + "(g3 — silent success 금지).")
            return SSCBAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — sscb_ngspice.py 를 찾지 못했습니다 "
                + "(cockpit/scripts/). 절차 fallback 없음 — 본 셀은 producer "
                + "필수 (g3).")
            return SSCBAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/sscb/transient/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = transientRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ sscb transient dir mkdir 실패: \(error.localizedDescription)")
            return SSCBAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the script. ngspice resolution is the
        // script's job (it has its own candidate path list), but the
        // Swift side resolved it already so we surface that to the
        // user as part of the engine-tool banner.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["python3", script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // SSCB_NGSPICE_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 sscb_ngspice.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return SSCBAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the SSCB_NGSPICE_RESULT <json> line.
        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the four artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("ngspice = \(ngs)")
        lines.append("python3 sscb_ngspice.py — exit \(exitCode), rows=\(summary.rows ?? 0)")
        if let v = summary.ngspiceVersion {
            lines.append("ngspice version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["netlist", "log", "raw", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — sscb producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            // Even on failure, do not silently succeed — return without
            // writing a typed record.
            return SSCBAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Topology + measurements come from
        // re-reading the meta.json (the Python side is the SSOT for
        // the numbers — Swift just witnesses + types).
        let metaName = verified["meta"] ?? "sscb_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(SSCBProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) — record 미작성 (g3).")
            return SSCBAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "sscb_transient_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let nsv = summary.ngspiceVersion ?? meta.ngspiceVersion ?? "unknown"
        let caveats: [String] = [
            "ngspice 의 transient 시뮬레이션 결과 — 숫자는 실제 "
            + "(IEEE-754 솔버 출력) 이지만, 회로 자체는 plausible "
            + "HEXA-SSCB mk1 topology 이며 datasheet 흡수 아님 (g3 — "
            + "SiC 스위치 = generic Ron/Roff 모델).",
            "snubber (100 nF · 5 Ω) 는 generic-not-engineered — "
            + "post-trip interrupt_ratio (~0.35 at 1.5 µs) 가 HEXA-SSCB "
            + "mk1 ≤ 1 µs 목표를 만족하지 않는 것은 buggy 가 아니라 "
            + "honest gap (스너버 sizing + 자기적 보조 차단이 후속).",
            "measurement_gate = GATE_OPEN 영구 (단일점 시뮬, 디바이스 "
            + "모델 미흡수). UL 489I 인증은 별도 게이트 — accredited "
            + "lab type-test 이지 ngspice 가 아님 (domains/sscb.md §4).",
            "absorbed=true 절대 금지 — Wolfspeed C3M0021120K class "
            + ".lib + bench-validated load + DEVSIM TCAD coupling 이 "
            + "들어와야 진짜 흡수 (D17 — hexa-matter / hexa-lang 가 "
            + "절차 SSOT, demiurge 는 consumer).",
        ]

        let record = SSCBRecord(
            interface: "demiurge:sscb:transient-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            netlistSha256_16: meta.netlistSha256_16,
            ngspiceVersion: nsv,
            ngspiceExit: meta.ngspiceExit,
            topology: meta.topology,
            measurements: meta.measurements,
            artifacts: verified,
            provenance: SSCBProvenance(
                absorbed: false,
                producer: "ngspice@\(nsv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ sscb record JSON 쓰기 실패: \(error.localizedDescription)")
            return SSCBAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output line for the user.
        let m = meta.measurements
        lines.append("---")
        lines.append("📸 sscb transient record → exports/sscb/transient/"
            + "\(stamp)/\(recordId).json")
        if let rt = m.riseTimeS, let ir = m.interruptRatio {
            lines.append(String(format: "   rise_time = %.3g µs · "
                + "interrupt_ratio = %.3f · producer = ngspice@%@",
                rt * 1.0e6, ir, nsv))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — 실제 숫자 "
            + "이지만 datasheet 흡수 아님 (g3, scope_caveats 4종 참조).")

        return SSCBAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `cockpit/scripts/sscb_ngspice.py::main`'s write_meta().
    private struct SSCBProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let netlistSha256_16: String
        let ngspiceVersion: String?
        let ngspiceExit: Int
        let topology: SSCBTopology
        let measurements: SSCBMeasurements

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case netlistSha256_16 = "netlist_sha256_16"
            case ngspiceVersion = "ngspice_version"
            case ngspiceExit = "ngspice_exit"
            case topology
            case measurements
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var ngspiceVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `SSCB_NGSPICE_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "SSCB_NGSPICE_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["ngspice_version"] as? String { out.ngspiceVersion = s }
            if let n = obj["rows"] as? Int { out.rows = n }
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
