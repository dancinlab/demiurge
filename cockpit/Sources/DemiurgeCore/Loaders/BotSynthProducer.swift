// BotSynthProducer — θ-2 engine tool for `bot + synthesize`
// (ROI rank 9, ⭐⭐⭐⭐ per absorption-empty-cells-research-2026-05-20.md
// §3). Pinocchio (stack-of-tasks SSOT) rigid-body dynamics + analytic
// derivatives over the same hermetic 2-link revolute arm as
// bot+structure (κ-37 / D58). Cross-cell parity = identical
// urdf_sha256_16 hash across bot+structure and bot+synthesize records.
//
// D61-compliant from birth: producer script SSOT lives in
// `~/core/hexa-lang/stdlib/bot/pinocchio_rbd.py`. Swift NEVER reaches
// into `cockpit/scripts/*` — that pattern was retired in the D61
// batch-migration round and re-introducing it would be a g_demiurge_
// pointer_only violation.
//
// D72 classification: existing `kernels/urdf/` (κ-45) owns URDF loading
// for hexa-native cohorts; Pinocchio = inverse kinematics / Jacobians /
// RNEA. We deliberately keep the Pinocchio path in the bot adapter
// (thin) rather than promoting to `kernels/rbd/` because no 2nd RBD
// consumer is on the horizon — promotion would be speculative kernel-
// design (lattice-as-tool anti-pattern: fit-to-convenient-number /
// constraining-first-question). If a 2nd RBD consumer lands later,
// promote then.
//
// Architecture (mirrors FusionAnalyzeProducer + BotStructureProducer):
//   1. locate `~/core/hexa-lang/stdlib/bot/pinocchio_rbd.py`
//   2. locate a Python 3 binary that has `pinocchio` (prefer Homebrew's
//      `/opt/homebrew/bin/python3` where `pip install --user --break-
//      system-packages pin` lands on macOS)
//   3. spawn `python3 pinocchio_rbd.py <output_dir>`
//   4. parse the `BOT_RBD_RESULT <json>` summary line from stderr
//   5. verify the .urdf / .rbd.json / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `BotSynthRecord` under
//      `exports/bot/synthesize/<stamp>/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "pinocchio@<ver> (open-loop torque eval)" — pin the
//     library AND the scope. The RNEA / CRBA / Jacobian outputs ARE
//     real (Featherstone algebra), BUT this slice omits contact,
//     payload, joint friction, actuator dynamics, dynamic stability
//     check (Drake / Gazebo territory — bot+verify, ROI rank 13,
//     deferred this round). So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them.
//   • The URDF is the same self-generated hermetic 2-link arm as
//     bot+structure — no UR5/Franka manufacturer datasheet, no bench-
//     validated mass matrix.
//   • If pinocchio is missing OR script crashes OR the summary JSON
//     doesn't parse, returns ok=false and writes no record. Silent
//     success is forbidden.

import Foundation

/// One run of the bot-synthesize producer — kept as plain text + a
/// record ID so cockpit chat + CLI pretty-print identically (D50).
public struct BotSynthResult: Sendable {
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

public enum BotSynthProducer {

    /// Default location for bot-synthesize records — sibling of
    /// `bot/structure/`, `fusion/plasma/`, `sscb/transient/`.
    public static let synthRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("bot/synthesize", isDirectory: true)

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. NO cockpit/scripts/ fallback
    /// (any such fallback would be a birth-violation).
    public static func locateScript() -> String? {
        let candidate = NSString(
            string: "~/core/hexa-lang/stdlib/bot/pinocchio_rbd.py"
        ).expandingTildeInPath
        if FileManager.default.fileExists(atPath: candidate) {
            return candidate
        }
        return nil
    }

    /// Locate a Python 3 binary — prefer Homebrew's `/opt/homebrew/
    /// bin/python3` (where `pip install --user --break-system-packages
    /// pin` lands on macOS), then PATH fallback. Same resolver shape as
    /// FusionAnalyzeProducer.locatePython3().
    public static func locatePython3() -> String? {
        let fm = FileManager.default
        let candidates = [
            "/opt/homebrew/bin/python3",
            "/usr/local/bin/python3",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // PATH fallback via `which python3`.
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

    /// Run `python3 pinocchio_rbd.py <synthRecordsRoot>/<stamp>/` and
    /// persist one `BotSynthRecord` per call. Each call writes into its
    /// own timestamped subdirectory so consecutive runs do not stomp
    /// each other's .urdf / .rbd.json / .meta.json artifacts.
    public static func runSynthesize() -> BotSynthResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — pinocchio_rbd.py 를 찾지 "
                + "못했습니다 (~/core/hexa-lang/stdlib/bot/). D61 / "
                + "g_demiurge_pointer_only: producer script SSOT 는 "
                + "hexa-lang 안에 살아야 합니다 (g3 — silent success 금지).")
            return BotSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/bot/synthesize/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = synthRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ bot synthesize dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return BotSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). `pinocchio` (pip 패키지 "
                + "이름 `pin`, BSD-2 / LGPL-3) import 가 필요합니다 (g3 — "
                + "silent success 금지).")
            return BotSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // BOT_RBD_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 pinocchio_rbd.py "
                + "실행 실패: \(error.localizedDescription) (g3).")
            return BotSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the artifacts exist on disk (defence-in-depth, @F f6).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts where !rel.isEmpty {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("script = \(script)")
        lines.append("python3 = \(py)")
        lines.append("python3 pinocchio_rbd.py — exit \(exitCode), "
            + "nq=\(summary.nq ?? 0), nv=\(summary.nv ?? 0)")
        if let v = summary.pinocchioVersion {
            lines.append("pinocchio version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["urdf", "rbd", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — bot+synth producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return BotSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Re-read the meta.json — the Python side is the SSOT for the
        // numbers; Swift just witnesses + types.
        let metaName = verified["meta"] ?? "simple_arm_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                BotSynthProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return BotSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "bot_synth_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let pinV = summary.pinocchioVersion ?? meta.pinocchioVersion ?? "unknown"
        let pyv = summary.pythonVersion ?? meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "pinocchio@\(pinV) 의 RNEA / CRBA / frame Jacobian 출력 "
            + "(tau · M · J) 은 *real* — Featherstone 알고리즘은 URDF "
            + "spatial inertia 가 주어졌을 때 수학적 사실. 하지만 이 "
            + "slice 는 open-loop torque eval 일 뿐 — **contact / payload "
            + "/ joint friction / actuator dynamics / dynamic stability "
            + "check 없음** (g3 — 그 부분은 bot+verify Drake/Gazebo ROI "
            + "rank 13, 본 라운드 deferred).",
            "URDF = bot+structure (κ-37 / D58) 와 byte-identical 해야 함 — "
            + "urdf_sha256_16 가 두 record 에서 같으면 cross-cell parity OK. "
            + "self-generated hermetic 2-link revolute arm 이지 UR5/Franka "
            + "manufacturer datasheet 아님.",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 — "
            + "진짜 흡수에는 Drake constrained-sim parity, Gazebo "
            + "regression, ros2_control HIL, ISO 10218/13482 risk "
            + "assessment 가 필요 (domains/bot.md §1 — URDF + actuator/"
            + "sensor + controller + safety 4중 트리 중 본 producer 는 "
            + "RBD analytic 1 leaf 만 커버).",
            "sample 평가점 (q, v, a) 는 static-arbitrary — trajectory "
            + "optimization, OMPL planning, contact-implicit solve 모두 "
            + "본 record scope 밖. 다른 (q, v, a) 에서 재실행하면 record "
            + "가 늘어남 — 본 cell 은 'open-loop 정적 평가 1점' 으로 honest.",
            "D72 classification: kernels/urdf/ (κ-45) 가 URDF loading 을 "
            + "이미 소유 — Pinocchio 는 IK / Jacobian / RNEA. 본 producer "
            + "는 bot adapter (thin) 에 머무름. 2nd RBD consumer 가 "
            + "보이면 그때 kernels/rbd/ 로 promote — 지금 promote 하면 "
            + "speculative kernel design (lattice-as-tool anti-pattern).",
        ]

        let citations: [String] = [
            "stack-of-tasks/pinocchio (BSD-2 / LGPL-3) — https://github.com/stack-of-tasks/pinocchio",
            "Carpentier et al., \"The Pinocchio C++ library\", SII 2019 — analytic RBD + spatial-algebra reference.",
            "Featherstone, \"Rigid Body Dynamics Algorithms\", Springer 2008 — RNEA / CRBA derivation.",
        ]

        let scenario = meta.scenario ?? BotSynthScenario(
            name: "unknown", kind: "?", source: "?",
            endEffectorFrame: "?",
            qRad: [], vRadS: [], aRadS2: [])
        let m = meta.measurements
        let measurements = BotSynthMeasurements(
            nq: m?.nq ?? 0,
            nv: m?.nv ?? 0,
            actuatedJoints: m?.actuatedJoints ?? [],
            eeTranslationM: m?.eeTranslationM,
            tauRneaNm: m?.tauRneaNm,
            gravityTorqueNm: m?.gravityTorqueNm,
            jacobian6xNv: m?.jacobian6xNv,
            massMatrixCrbaNvxNv: m?.massMatrixCrbaNvxNv)

        let record = BotSynthRecord(
            interface: "demiurge:bot:synthesize-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            urdfSha256_16: meta.urdfSha256_16,
            pinocchioVersion: pinV,
            pythonVersion: pyv,
            scenario: scenario,
            measurements: measurements,
            artifacts: verified,
            provenance: BotSynthProvenance(
                absorbed: false,
                producer: "pinocchio@\(pinV) (open-loop torque eval, no contact)",
                measurementGate: .open,
                scopeCaveats: caveats,
                citations: citations))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ bot synth record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return BotSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output lines for the user.
        lines.append("---")
        lines.append("📸 bot synthesize record → exports/bot/synthesize/"
            + "\(stamp)/\(recordId).json")
        lines.append("   geometry = \(meta.geometryId) · urdf_sha = "
            + meta.urdfSha256_16
            + " · producer = pinocchio@\(pinV)")
        if let tau = measurements.tauRneaNm,
           let g = measurements.gravityTorqueNm,
           let ee = measurements.eeTranslationM, ee.count == 3 {
            let tauStr = tau.map { String(format: "%+.4f", $0) }
                .joined(separator: ", ")
            let gStr = g.map { String(format: "%+.4f", $0) }
                .joined(separator: ", ")
            lines.append("   tau_rnea = [\(tauStr)] Nm · "
                + "gravity_tau = [\(gStr)] Nm")
            lines.append(String(
                format: "   ee_pos = (%.4f, %.4f, %.4f) m",
                ee[0], ee[1], ee[2]))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — open-loop torque "
            + "eval 일 뿐, contact / dynamic stability check 없음 "
            + "(bot+verify Drake/Gazebo deferred, g3 / scope_caveats 5종).")

        return BotSynthResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// Shape we parse out of the producer's `meta.json`. Kept in step
    /// with `~/core/hexa-lang/stdlib/bot/pinocchio_rbd.py::main`'s
    /// write of the meta file.
    private struct BotSynthProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let urdfSha256_16: String
        let pinocchioVersion: String?
        let pythonVersion: String?
        let scenario: BotSynthScenario?
        let measurements: MeasurementsRaw?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case urdfSha256_16 = "urdf_sha256_16"
            case pinocchioVersion = "pinocchio_version"
            case pythonVersion = "python_version"
            case scenario
            case measurements
        }

        struct MeasurementsRaw: Decodable {
            let nq: Int
            let nv: Int
            let actuatedJoints: [String]
            let eeTranslationM: [Double]?
            let tauRneaNm: [Double]?
            let gravityTorqueNm: [Double]?
            let jacobian6xNv: [[Double]]?
            let massMatrixCrbaNvxNv: [[Double]]?

            enum CodingKeys: String, CodingKey {
                case nq
                case nv
                case actuatedJoints = "actuated_joints"
                case eeTranslationM = "ee_translation_m"
                case tauRneaNm = "tau_rnea_Nm"
                case gravityTorqueNm = "gravity_torque_Nm"
                case jacobian6xNv = "jacobian_6xnv"
                case massMatrixCrbaNvxNv = "mass_matrix_crba_nvxnv"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var urdfSha256_16: String? = nil
        var pinocchioVersion: String? = nil
        var pythonVersion: String? = nil
        var nq: Int? = nil
        var nv: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `BOT_RBD_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "BOT_RBD_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["urdf_sha256_16"] as? String {
                out.urdfSha256_16 = s
            }
            if let s = obj["pinocchio_version"] as? String {
                out.pinocchioVersion = s
            }
            if let s = obj["python_version"] as? String {
                out.pythonVersion = s
            }
            if let n = obj["nq"] as? Int { out.nq = n }
            if let n = obj["nv"] as? Int { out.nv = n }
            if let arts = obj["artifacts"] as? [String: String] {
                out.artifacts = arts
            }
        }
        return out
    }

    private static func lastLines(_ text: String, _ n: Int) -> String {
        let lines = text.split(separator: "\n",
                               omittingEmptySubsequences: false)
        guard lines.count > n else {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return lines.suffix(n).joined(separator: "\n")
    }
}
