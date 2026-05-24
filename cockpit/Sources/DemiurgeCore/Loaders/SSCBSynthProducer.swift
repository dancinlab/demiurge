// SSCBSynthProducer — θ-2 engine tool for `sscb + synthesize`
// (D72 / κ-N · ROI rank 1 of archive/session-notes/absorption-empty-cells-research-
// 2026-05-20.md). D61-compliant-from-birth — substrate script SSOT
// `~/core/hexa-lang/stdlib/sscb/femmt_sweep.py`, NEVER in cockpit/
// scripts/.
//
// Architecture (mirrors ComponentVerifyProducer + ScopeAnalyzeProducer
// — Python-script-based D61 producers):
//   1. locate `python3.13` (or any python with numpy installed; femmt
//      optional — script gracefully falls back to analytic estimates)
//   2. locate `~/core/hexa-lang/stdlib/sscb/femmt_sweep.py` (D61 SSOT)
//   3. spawn `python3 femmt_sweep.py <output_dir>` — script writes
//      the candidates.csv + meta.json + emits `SSCB_FEMMT_RESULT
//      <json>` on stderr
//   4. parse the summary line, verify .csv + .meta.json exist on
//      disk (defence-in-depth — @F f6 evidence-over-assertion)
//   5. emit one typed `SSCBSynthRecord` under
//      `exports/sscb/synthesize/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "femmt@<v>" when femmt is importable, or
//     "analytic_fallback (femmt unavailable)" otherwise. Both paths
//     write a valid record — the solver field surfaces which one ran.
//     The analytic fallback uses the gapped-core textbook reluctance
//     formula (Hagedorn §7.4), deterministic and reproducible cross-host.
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS.
//     ABSORPTION.md sscb+synthesize row stays GATE_OPEN — femmt
//     pinning is honesty, not absorption.
//   • If python3 is missing OR the script crashes OR the summary JSON
//     doesn't parse, returns ok=false and writes no record. Silent
//     success is forbidden.

import Foundation

public struct SSCBSynthResult: Sendable {
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

public enum SSCBSynthProducer {

    /// Default location for sscb-synthesize records.
    public static let synthRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("sscb/synthesize", isDirectory: true)

    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3.13",
        "/opt/homebrew/bin/python3.12",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    public static let scriptPath: String =
        NSString(string: "~/core/hexa-lang/stdlib/sscb/femmt_sweep.py")
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

    public static func runSynth() -> SSCBSynthResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — femmt_sweep.py 를 찾지 못했습니다 "
                + "(D61 SSOT: ~/core/hexa-lang/stdlib/sscb/femmt_sweep.py). "
                + "sibling repo hexa-lang 의 stdlib/sscb/ 에 producer 가 "
                + "존재해야 합니다 (g3 — silent success 금지).")
            return SSCBSynthResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let python = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3.13 권장). sscb + synthesize 는 "
                + "FEMMT (또는 analytic fallback) 을 producer 로 사용합니다 "
                + "(g3 — silent success 금지).")
            return SSCBSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = synthRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ sscb synthesize dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return SSCBSynthResult(ok: false, lines: lines, newRecordID: nil)
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
            lines.append("⏳ engine tool gap — python femmt_sweep.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return SSCBSynthResult(ok: false, lines: lines, newRecordID: nil)
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
        lines.append("femmt_sweep.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let s = summary.solver {
            lines.append("solver: \(s)")
        }
        if let v = summary.femmtVersion {
            lines.append("femmt version: \(v)")
        } else {
            lines.append("femmt: not installed → analytic_fallback (정직).")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["csv", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — sscb synth producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 8)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return SSCBSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let metaName = verified["meta"] ?? "sscb_magnetics_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                SSCBSynthProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return SSCBSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "sscb_synth_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let femmtVer = summary.femmtVersion ?? meta.femmtVersion
        let pyv = meta.pythonVersion ?? "unknown"
        let producerLabel: String
        if let v = femmtVer {
            producerLabel = "femmt@\(v)"
        } else {
            producerLabel = "analytic_fallback (femmt unavailable)"
        }

        let caveats: [String] = [
            "FEMMT 또는 analytic-fallback (gapped-core reluctance, "
            + "Hagedorn §7.4) sweep — 숫자는 실제 (deterministic 분석값) "
            + "이지만 core / winding / gap geometry 가 PARAMETRIC EE-class "
            + "ferrite 카탈로그 값일 뿐 measured datasheet 흡수 아님 (g3).",
            "B-H curve / saturation flux / loss density = N87 ferrite 의 "
            + "textbook 100 °C reference (B_sat ≈ 0.30 T). 실제 lot-to-lot "
            + "drift / temperature derating / DC-bias permeability 변화 "
            + "0 종 적용. 흡수에 해당하려면 supplier datasheet B-H + Hot-"
            + "Disk thermal + Bertotti loss split 필요.",
            "OpenMagnetics 카탈로그 + FEMMT GPL-3 = cited synthesis "
            + "instrument (domains/sscb.md §2). 본 producer 가 femmt 의 "
            + "full GetDP/ONELAB FEM solve 를 invoke 하지는 않음 — analytic "
            + "estimate (gap-dominated reluctance) 가 reproducibility "
            + "anchor. 풀 FEM solve 는 후속 phase.",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 — "
            + "absorbed=true 는 (1) 실제 magnetic-material datasheet B-H "
            + "흡수, (2) 한 candidate 의 bench winding-loss 측정, (3) "
            + "thermal coupling (Φ-N 측정 + 열저항), (4) measured stray-"
            + "inductance 회로 통합, 4종 동시 필요. 본 phase 는 sizing의 "
            + "*first honest witness* (g3).",
        ]

        let citations: [String] = [
            "DEVSIM JOSS doi:10.21105/joss.03898 (Sanchez 2022) — TCAD anchor",
            "FEMMT (upb-lea/FEM_Magnetics_Toolbox, GPL-3) — cited synthesis instrument",
            "OpenMagnetics catalogue — analytic A_L fallback reference",
            "Hagedorn, Magnetic Components §7.4 (gapped-core reluctance)",
        ]

        let target = SSCBSynthTarget(
            lTargetH: meta.target.lTargetH,
            iPeakA: meta.target.iPeakA,
            fSwHz: meta.target.fSwHz,
            bSatT: meta.target.bSatT)
        let sweep = SSCBSynthSweep(
            cores: meta.sweep.cores,
            turnsGrid: meta.sweep.turnsGrid,
            nCandidates: meta.sweep.nCandidates,
            nSafe: meta.sweep.nSafe)
        let best = SSCBSynthCandidate(
            coreId: meta.best.coreId,
            turns: meta.best.turns,
            lUH: meta.best.lUH,
            bPeakMT: meta.best.bPeakMT,
            lossEstW: meta.best.lossEstW,
            saturates: meta.best.saturates,
            score: meta.best.score)
        let candidates = meta.candidates.map { c in
            SSCBSynthCandidate(
                coreId: c.coreId,
                turns: c.turns,
                lUH: c.lUH,
                bPeakMT: c.bPeakMT,
                lossEstW: c.lossEstW,
                saturates: c.saturates,
                score: c.score)
        }

        let record = SSCBSynthRecord(
            interface: "demiurge:sscb:synthesize-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            fingerprint: meta.fingerprint,
            femmtVersion: femmtVer,
            pythonVersion: pyv,
            solver: meta.solver,
            target: target,
            sweep: sweep,
            best: best,
            candidates: candidates,
            artifacts: verified,
            provenance: SSCBSynthProvenance(
                absorbed: false,
                producer: producerLabel,
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
            lines.append("⏳ sscb synth record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return SSCBSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        lines.append("---")
        lines.append("📸 sscb synth record → exports/sscb/synthesize/"
            + "\(stamp)/\(recordId).json")
        lines.append(String(format:
            "   best = %@/N=%d · L = %.3f µH · B_peak = %.1f mT · "
            + "saturates=%@",
            best.coreId, best.turns, best.lUH, best.bPeakMT,
            best.saturates ? "true" : "false"))
        lines.append("   producer = \(producerLabel)")
        lines.append("   ⏳ GATE_OPEN · absorbed=false — parametric ferrite "
            + "catalogue (measured B-H 흡수 아님). FEMMT 흡수는 sizing 한 "
            + "셀에 한정 (g3, scope_caveats 4종 참조).")

        return SSCBSynthResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    private struct SSCBSynthProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let fingerprint: String
        let femmtVersion: String?
        let pythonVersion: String?
        let solver: String
        let target: TargetRaw
        let sweep: SweepRaw
        let best: CandidateRaw
        let candidates: [CandidateRaw]

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case fingerprint
            case femmtVersion = "femmt_version"
            case pythonVersion = "python_version"
            case solver
            case target
            case sweep
            case best
            case candidates
        }

        struct TargetRaw: Decodable {
            let lTargetH: Double
            let iPeakA: Double
            let fSwHz: Double
            let bSatT: Double

            enum CodingKeys: String, CodingKey {
                case lTargetH = "L_target_H"
                case iPeakA = "I_peak_A"
                case fSwHz = "f_sw_Hz"
                case bSatT = "B_sat_T"
            }
        }

        struct SweepRaw: Decodable {
            let cores: [String]
            let turnsGrid: [Int]
            let nCandidates: Int
            let nSafe: Int

            enum CodingKeys: String, CodingKey {
                case cores
                case turnsGrid = "turns_grid"
                case nCandidates = "n_candidates"
                case nSafe = "n_safe"
            }
        }

        struct CandidateRaw: Decodable {
            let coreId: String
            let turns: Int
            let lUH: Double
            let bPeakMT: Double
            let lossEstW: Double
            let saturates: Bool
            let score: Double

            enum CodingKeys: String, CodingKey {
                case coreId = "core_id"
                case turns
                case lUH = "L_uH"
                case bPeakMT = "B_peak_mT"
                case lossEstW = "loss_est_W"
                case saturates
                case score
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var fingerprint: String? = nil
        var femmtVersion: String? = nil
        var solver: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "SSCB_FEMMT_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["fingerprint"] as? String { out.fingerprint = s }
            if let s = obj["femmt_version"] as? String { out.femmtVersion = s }
            if let s = obj["solver"] as? String { out.solver = s }
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
