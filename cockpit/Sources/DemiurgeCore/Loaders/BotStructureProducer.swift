// BotStructureProducer — θ-2 engine tool for `bot + structure`
// (D58; cohort-round producer, no standalone PLAN κ entry — post-merge
// reconstructed).
//
// The THIRD cohort domain (out of the 13 surveyed in domains/*.md)
// wired to a real measuring engine tool — chip / component / matter
// were the "deep" / hexa-lang-owner pillars; sscb (κ-34) was the first
// cohort breadth-survey producer, grid (NetworkX, pickup #1) is the
// sibling-worktree second, and bot is the third — yourdfpy 0.0.60 as
// the URDF parser.
//
// Architecture (mirrors SSCBProducer + MatterAnalyzer):
//   1. locate `python3` (system /usr/bin first because yourdfpy installs
//      cleanly there; brew /opt/homebrew next; PATH fallback)
//   2. locate `cockpit/scripts/bot_urdf.py`
//   3. spawn `python3 bot_urdf.py <output_dir>` — Python wraps the
//      yourdfpy invocation so the .urdf + .meta.json artifacts all
//      live in <output_dir> with no shell quoting hazards
//   4. parse the `BOT_URDF_RESULT <json>` summary line from stderr
//   5. verify the .urdf / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `BotRecord` under
//      `exports/bot/structure/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "yourdfpy@<version>" — pins the python library, not
//     the *robot platform*. The URDF is a self-generated hermetic
//     2-link revolute arm (no UR5/Franka manufacturer datasheet, no
//     bench-validated mass matrix). So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them to closedMeasured
//     — that requires a vendor-validated URDF + Drake constrained sim
//     + ros2_control HIL + ISO 10218 risk-assessment, which lives in
//     a later phase (domains/bot.md §1).
//   • The measurement VALUES are real (link_count = 4, joint_count = 3,
//     DOF = 2, total_mass = 3.6 kg, bbox = 0.2×0.2×0.7 m). They are
//     URDF *spec metadata*, NOT robot hardware measurements.
//   • urdfpy was the requested target — it is deprecated / abandoned
//     (last release 2020); we fell back to its maintained successor
//     yourdfpy 0.0.60 per the cohort-pickup note. Hard-fails honestly
//     if neither is importable.
//   • If python3/script is missing OR the script crashes OR the
//     summary JSON doesn't parse, returns ok=false and writes no
//     record. Silent success is forbidden.

import Foundation

/// One run of the bot-structure producer — kept as plain text + a
/// record ID so cockpit chat + CLI pretty-print identically (D50).
public struct BotStructureResult: Sendable {
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

public enum BotStructureProducer {

    /// Default location for bot structure records — sibling of
    /// `sscb/transient/`, `chip/noc/f1f2/records/`, `component/geometry/`,
    /// `matter/parity/`.
    public static let structureRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("bot/structure", isDirectory: true)

    /// Default candidate paths for `python3` — system Python 3.9 first
    /// (yourdfpy installs there cleanly via `--user` without a venv on
    /// macOS), brew next.
    private static let pythonCandidates: [String] = [
        "/usr/bin/python3",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
    ]

    /// Locate a python3 binary — nil if none exists (extremely unlikely
    /// on macOS; CommandLineTools ships /usr/bin/python3).
    public static func locatePython() -> String? {
        let fm = FileManager.default
        for c in pythonCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
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

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. Migrated 2026-05-20 in the D61
    /// batch-migration round
    /// from `cockpit/scripts/bot_urdf.py` (born in worktree pre-D61;
    /// lifted to hexa-lang stdlib at consolidation).
    public static func locateScript() -> String? {
        let path = NSString(
            string: "~/core/hexa-lang/stdlib/bot/urdfpy_basics.py"
        ).expandingTildeInPath
        return FileManager.default.fileExists(atPath: path) ? path : nil
    }

    /// Run `python3 bot_urdf.py <structureRecordsRoot>/<stamp>/` and
    /// persist one `BotRecord` per call. Each call writes into its
    /// own timestamped subdirectory so consecutive runs do not stomp
    /// each other's .urdf / .meta.json artifacts.
    public static func runStructure() -> BotStructureResult {
        var lines: [String] = []

        guard let py = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(/usr/bin/python3 / brew). bot + structure 는 yourdfpy "
                + "0.0.60 으로 URDF spec metadata 를 측정 — python3 가 "
                + "필수 (g3 — silent success 금지).")
            return BotStructureResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — bot_urdf.py 를 찾지 못했습니다 "
                + "(cockpit/scripts/). 절차 fallback 없음 — 본 셀은 producer "
                + "필수 (g3).")
            return BotStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/bot/structure/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = structureRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ bot structure dir mkdir 실패: \(error.localizedDescription)")
            return BotStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the script. The script writes
        // BOT_URDF_RESULT <json> on stderr; we merge stdout+stderr.
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
            lines.append("⏳ engine tool gap — python3 bot_urdf.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return BotStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the BOT_URDF_RESULT <json> line.
        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the two artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python3 = \(py)")
        lines.append("python3 bot_urdf.py — exit \(exitCode), "
            + "links=\(summary.linkCount ?? 0), joints=\(summary.jointCount ?? 0), "
            + "dof=\(summary.dof ?? 0)")
        if let v = summary.yourdfpyVersion {
            lines.append("yourdfpy version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["urdf", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — bot producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return BotStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Topology + measurements come from
        // re-reading the meta.json (the Python side is the SSOT for
        // the numbers — Swift just witnesses + types).
        let metaName = verified["meta"] ?? "simple_arm_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(BotProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) — record 미작성 (g3).")
            return BotStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "bot_structure_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let yv = summary.yourdfpyVersion ?? meta.yourdfpyVersion ?? "unknown"
        let caveats: [String] = [
            "yourdfpy 의 URDF parse 결과 — 숫자는 실제 (link_count = 4, "
            + "joint_count = 3, DOF = 2, total_mass = 3.6 kg, bbox = "
            + "0.2×0.2×0.7 m) 이지만 *URDF spec metadata* 일 뿐, 실제 "
            + "로봇 하드웨어 측정 아님 (g3 — 본 producer 는 spec 의 "
            + "trimesh 시각 bounding box 까지만, 동역학 / 접촉 / 페이로드 "
            + "/ 액추에이터 응답 없음).",
            "URDF 는 self-generated hermetic 2-link revolute arm — "
            + "UR5 / Franka 같은 vendor datasheet 흡수 아님. 후속 phase "
            + "에서 ros-industrial/universal_robot 의 BSD URDF 를 vendoring "
            + "하면 cross-host parity 가능 (cohort-pickup note 참조).",
            "urdfpy 는 deprecated (2020 마지막 릴리스) — 본 producer 는 "
            + "그 maintained successor yourdfpy 0.0.60 으로 fallback. "
            + "두 lib 모두 미설치 시 honest gap, silent success 금지.",
            "measurement_gate = GATE_OPEN 영구 — Gazebo regression / "
            + "Drake verification primitives (Lyapunov, SOS, contact-"
            + "implicit) / ros2_control HIL / ISO 10218 risk-assessment "
            + "이 들어와야 GATE_CLOSED 후보 (domains/bot.md §2 7-verb "
            + "맵, ANALYZE / VERIFY / HANDOFF 칸).",
            "absorbed=true 절대 금지 — domains/bot.md §1 의 bot 결과물 "
            + "= URDF + actuator/sensor 선정 + controller architecture + "
            + "safety analysis 의 4중 트리 중 URDF parse 1 leaf 만 본 "
            + "producer 가 커버 (D17 — hexa-matter / hexa-lang 가 절차 "
            + "SSOT, demiurge 는 consumer).",
        ]

        let record = BotRecord(
            interface: "demiurge:bot:structure-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            urdfSha256_16: meta.urdfSha256_16,
            yourdfpyVersion: yv,
            topology: meta.topology,
            measurements: meta.measurements,
            artifacts: verified,
            provenance: BotProvenance(
                absorbed: false,
                producer: "yourdfpy@\(yv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ bot record JSON 쓰기 실패: \(error.localizedDescription)")
            return BotStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output line for the user.
        let m = meta.measurements
        lines.append("---")
        lines.append("📸 bot structure record → exports/bot/structure/"
            + "\(stamp)/\(recordId).json")
        let bbox = (m.bboxSizeM ?? []).map { String(format: "%.2f", $0) }.joined(separator: "×")
        let mass = m.totalMassKg.map { String(format: "%.2f kg", $0) } ?? "unknown"
        lines.append("   links = \(m.linkCount) · joints = \(m.jointCount) · "
            + "DOF = \(m.dof) · mass = \(mass) · bbox = \(bbox) m · "
            + "producer = yourdfpy@\(yv)")
        lines.append("   ⏳ GATE_OPEN · absorbed=false — URDF spec metadata "
            + "이지만 실제 로봇 하드웨어 측정 아님 (g3, scope_caveats 5종 참조).")

        return BotStructureResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `cockpit/scripts/bot_urdf.py::main`'s write to
    /// `simple_arm_v1.meta.json`.
    private struct BotProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let urdfSha256_16: String
        let yourdfpyVersion: String?
        let topology: BotTopology
        let measurements: BotMeasurements

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case urdfSha256_16 = "urdf_sha256_16"
            case yourdfpyVersion = "yourdfpy_version"
            case topology
            case measurements
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var yourdfpyVersion: String? = nil
        var linkCount: Int? = nil
        var jointCount: Int? = nil
        var dof: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `BOT_URDF_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "BOT_URDF_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["yourdfpy_version"] as? String { out.yourdfpyVersion = s }
            if let n = obj["link_count"] as? Int { out.linkCount = n }
            if let n = obj["joint_count"] as? Int { out.jointCount = n }
            if let n = obj["dof"] as? Int { out.dof = n }
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
