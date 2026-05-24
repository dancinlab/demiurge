// SSCBVerifyProducer — θ-2 engine tool for `sscb + verify`
// (D72 / κ-N · ROI rank 2 of archive/session-notes/absorption-empty-cells-research-
// 2026-05-20.md). D61-compliant-from-birth — substrate script SSOT
// `~/core/hexa-lang/stdlib/sscb/ngspice_breaking.py`, NEVER in
// cockpit/scripts/.
//
// Distinct from SSCBProducer (`sscb + analyze`) — analyze runs a
// normal-turn-off hard-switching transient and measures interrupt_ratio;
// VERIFY runs a bolted-fault breaking-capacity scenario and measures
// I_peak / I²t let-through / clearing_energy (UL 489I-style figures-
// of-merit per domains/sscb.md §4).
//
// Architecture (mirrors ComponentVerifyProducer + SSCBProducer):
//   1. locate `python3` (any python — script uses only stdlib)
//   2. locate `~/core/hexa-lang/stdlib/sscb/ngspice_breaking.py`
//   3. spawn `python3 ngspice_breaking.py <output_dir>` — script
//      writes the .cir / .data / .log / .meta.json and emits
//      `SSCB_BREAKING_RESULT <json>` on stderr
//   4. verify .cir / .log / .data / .meta.json artifacts exist
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   5. emit one typed `SSCBVerifyRecord` under
//      `exports/sscb/verify/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "ngspice@<v>" — pins the simulator binary, NOT the
//     device model. The SiC switch is a generic R_on/R_off model.
//     The snubber is generic (100 nF / 5 Ω), NOT engineered for this
//     fault current.
//   • OpenFOAM thermal-margin check is INTENTIONALLY skipped (see the
//     2026-05-20 absorption empty-cells research note: "OpenFOAM
//     thermal margin is heavy → skip with handoff note"). The skip
//     is recorded in scope_caveats so no silent thermal claim leaks
//     into downstream consumers.
//   • UL 489I certification is an accredited-lab type-test, NOT a
//     SPICE simulation. The verdict is a *first honest witness* of
//     the breaking-capacity envelope, NOT a regulatory verify.
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS.
//     Stage 4 absorbed=true requires Wolfspeed C3M0021120K-class .lib
//     + bench-validated load + DEVSIM TCAD coupling + measured stray-
//     inductance + OpenFOAM thermal + UL 489I type-test, none of
//     which sit in this slice.

import Foundation

public struct SSCBVerifyResult: Sendable {
    public let ok: Bool
    public let lines: [String]
    public let newRecordID: String?

    public init(ok: Bool, lines: [String], newRecordID: String?) {
        self.ok = ok
        self.lines = lines
        self.newRecordID = newRecordID
    }

    public var text: String { lines.joined(separator: "\n") }
}

public enum SSCBVerifyProducer {

    /// Default location for sscb-verify records.
    public static let verifyRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("sscb/verify", isDirectory: true)

    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3.13",
        "/opt/homebrew/bin/python3.12",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    public static let scriptPath: String =
        NSString(string: "~/core/hexa-lang/stdlib/sscb/ngspice_breaking.py")
            .expandingTildeInPath

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

    public static func locateScript() -> String? {
        FileManager.default.fileExists(atPath: scriptPath) ? scriptPath : nil
    }

    public static func runVerify() -> SSCBVerifyResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — ngspice_breaking.py 를 찾지 "
                + "못했습니다 (D61 SSOT: ~/core/hexa-lang/stdlib/sscb/"
                + "ngspice_breaking.py). sibling repo hexa-lang 의 "
                + "stdlib/sscb/ 에 producer 가 존재해야 합니다 "
                + "(g3 — silent success 금지).")
            return SSCBVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let python = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3.13 권장). sscb + verify 는 "
                + "ngspice transient breaking-capacity 측정을 spawn 합니다 "
                + "(g3 — silent success 금지).")
            return SSCBVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = verifyRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ sscb verify dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return SSCBVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: python)
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
            lines.append("⏳ engine tool gap — python ngspice_breaking.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return SSCBVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts where !rel.isEmpty {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("script = \(script)")
        lines.append("python = \(python)")
        lines.append("ngspice_breaking.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let v = summary.ngspiceVersion {
            lines.append("ngspice version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["netlist", "log", "data", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — sscb verify producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 8)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return SSCBVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let metaName = verified["meta"] ?? "sscb_breaking_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                SSCBVerifyProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return SSCBVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "sscb_verify_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let nsv = summary.ngspiceVersion ?? meta.ngspiceVersion ?? "unknown"
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "ngspice transient bolted-fault — 숫자는 실제 (IEEE-754 SPICE "
            + "solver 출력) 이지만, 회로 자체는 plausible HEXA-SSCB mk1 "
            + "topology + R_fault = 0.01 Ω generic bolted short 이며 "
            + "datasheet 흡수 아님 (g3 — SiC 스위치 = generic Ron/Roff).",
            "snubber (100 nF · 5 Ω) 는 generic-not-engineered — 본 "
            + "bolted-fault 시나리오에서 v_sw_peak 가 수십 kV 까지 튀는 "
            + "것은 buggy 가 아니라 honest gap (TVS / clamp / engineered "
            + "snubber 가 후속). 이 값을 안전 마진 주장으로 쓰지 말 것.",
            "OpenFOAM 열 마진 체크는 본 phase 에서 INTENTIONAL skip "
            + "(absorption-empty-cells-research-2026-05-20.md §3 sscb "
            + "block: \"OpenFOAM thermal margin is heavy → skip with "
            + "handoff note\"). 실제 thermal envelope 는 measured-package "
            + "thermal model + coupled CFD 후속 phase. 본 record 는 "
            + "*electrical* breaking-capacity 만 측정.",
            "UL 489I 인증은 accredited lab type-test (impulse / arc / "
            + "endurance 8단계, type-test 통과 record 필요) 이지 SPICE 가 "
            + "아님 (domains/sscb.md §4). 본 producer 의 verdict 는 "
            + "*first honest electrical witness*, 인증 substitute 절대 "
            + "아님.",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 — "
            + "Stage 4 absorbed=true 는 (1) Wolfspeed C3M0021120K-class "
            + ".lib, (2) bench-validated load + measured stray-inductance, "
            + "(3) DEVSIM TCAD coupling, (4) measured snubber B-H, "
            + "(5) OpenFOAM thermal margin, (6) UL 489I type-test, 6종 "
            + "동시 필요. 본 phase 는 *breaking envelope* 의 first witness "
            + "(g3).",
        ]

        let citations: [String] = [
            "DEVSIM JOSS doi:10.21105/joss.03898 (Sanchez 2022) — TCAD anchor",
            "arxiv:2504.00214 SEMIDV (compact device sim w/ quantum effects)",
            "ngspice manual §16 .MODEL VDMOS / §11 device cards (Berkeley SPICE3)",
            "domains/sscb.md §1 HEXA-SSCB mk1 spec · §4 UL 489I breaker test discipline",
        ]

        let topology = SSCBVerifyTopology(
            vDcV: meta.topology.vDcV,
            rFaultOhm: meta.topology.rFaultOhm,
            lBusH: meta.topology.lBusH,
            switchRonOhm: meta.topology.switchRonOhm,
            switchRoffOhm: meta.topology.switchRoffOhm,
            snubberCF: meta.topology.snubberCF,
            snubberROhm: meta.topology.snubberROhm,
            tDetectionS: meta.topology.tDetectionS,
            tOpenRampS: meta.topology.tOpenRampS,
            simTimeS: meta.topology.simTimeS,
            stepS: meta.topology.stepS)

        let measurements = SSCBVerifyMeasurements(
            rows: meta.measurements.rows,
            iPeakA: meta.measurements.iPeakA,
            iPostClearA: meta.measurements.iPostClearA,
            tClearS: meta.measurements.tClearS,
            letThroughI2tA2s: meta.measurements.letThroughI2tA2s,
            clearingEnergyJ: meta.measurements.clearingEnergyJ,
            vSwPeakV: meta.measurements.vSwPeakV,
            clearedInWindow: meta.measurements.clearedInWindow)

        let record = SSCBVerifyRecord(
            interface: "demiurge:sscb:verify-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            netlistSha256_16: meta.netlistSha256_16,
            ngspiceVersion: nsv,
            ngspiceExit: meta.ngspiceExit,
            pythonVersion: pyv,
            topology: topology,
            measurements: measurements,
            artifacts: verified,
            provenance: SSCBVerifyProvenance(
                absorbed: false,
                producer: "ngspice@\(nsv)",
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
            lines.append("⏳ sscb verify record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return SSCBVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let m = meta.measurements
        lines.append("---")
        lines.append("📸 sscb verify record → exports/sscb/verify/"
            + "\(stamp)/\(recordId).json")
        if let ip = m.iPeakA, let tc = m.tClearS, let i2t = m.letThroughI2tA2s {
            lines.append(String(format:
                "   I_peak = %.1f A · t_clear = %.3f µs · "
                + "I²t = %.3g A²·s · cleared=%@",
                ip, tc * 1.0e6, i2t,
                m.clearedInWindow ? "true" : "false"))
        }
        lines.append("   producer = ngspice@\(nsv)")
        lines.append("   ⏳ GATE_OPEN · absorbed=false — 실제 SPICE 숫자 "
            + "이지만 datasheet/UL489I/OpenFOAM-thermal 흡수 아님 (g3, "
            + "scope_caveats 5종 참조; OpenFOAM intentional skip per "
            + "research note 2026-05-20).")

        return SSCBVerifyResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    private struct SSCBVerifyProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let netlistSha256_16: String
        let ngspiceVersion: String?
        let ngspiceExit: Int
        let pythonVersion: String?
        let topology: TopologyRaw
        let measurements: MeasurementsRaw

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case netlistSha256_16 = "netlist_sha256_16"
            case ngspiceVersion = "ngspice_version"
            case ngspiceExit = "ngspice_exit"
            case pythonVersion = "python_version"
            case topology
            case measurements
        }

        struct TopologyRaw: Decodable {
            let vDcV: Double
            let rFaultOhm: Double
            let lBusH: Double
            let switchRonOhm: Double
            let switchRoffOhm: Double
            let snubberCF: Double
            let snubberROhm: Double
            let tDetectionS: Double
            let tOpenRampS: Double
            let simTimeS: Double
            let stepS: Double

            enum CodingKeys: String, CodingKey {
                case vDcV = "v_dc_V"
                case rFaultOhm = "r_fault_ohm"
                case lBusH = "l_bus_H"
                case switchRonOhm = "switch_ron_ohm"
                case switchRoffOhm = "switch_roff_ohm"
                case snubberCF = "snubber_C_F"
                case snubberROhm = "snubber_R_ohm"
                case tDetectionS = "t_detection_s"
                case tOpenRampS = "t_open_ramp_s"
                case simTimeS = "sim_time_s"
                case stepS = "step_s"
            }
        }

        struct MeasurementsRaw: Decodable {
            let rows: Int
            let iPeakA: Double?
            let iPostClearA: Double?
            let tClearS: Double?
            let letThroughI2tA2s: Double?
            let clearingEnergyJ: Double?
            let vSwPeakV: Double?
            let clearedInWindow: Bool

            enum CodingKeys: String, CodingKey {
                case rows
                case iPeakA = "i_peak_a"
                case iPostClearA = "i_post_clear_a"
                case tClearS = "t_clear_s"
                case letThroughI2tA2s = "let_through_i2t_a2s"
                case clearingEnergyJ = "clearing_energy_j"
                case vSwPeakV = "v_sw_peak_v"
                case clearedInWindow = "cleared_in_window"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var ngspiceVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "SSCB_BREAKING_RESULT "
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
        let lines = text.split(separator: "\n",
                               omittingEmptySubsequences: false)
        guard lines.count > n else {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return lines.suffix(n).joined(separator: "\n")
    }
}
