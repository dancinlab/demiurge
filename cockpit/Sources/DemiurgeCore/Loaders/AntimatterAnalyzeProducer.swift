// AntimatterAnalyzeProducer — θ-2 engine tool for `antimatter + analyze`
// (cohort round, no standalone PLAN κ / D-block — post-merge reconstructed).
// A cohort domain wired to a real measuring
// engine tool (after sscb κ-34, energy κ-35) and the FIRST particle-
// physics cell. Also the FIRST D61-compliant-from-birth producer —
// the Python script SSOT lives in `~/core/hexa-lang/stdlib/antimatter/
// pdg_lookup.py`, NEVER in demiurge (g_demiurge_pointer_only).
//
// Architecture (mirrors EnergyAnalyzeProducer + SSCBProducer, but
// resolves the script in hexa-lang instead of cockpit/scripts/):
//   1. locate `~/core/hexa-lang/stdlib/antimatter/pdg_lookup.py`
//   2. locate a Python 3 binary that has the `particle` package
//      (prefer `/opt/homebrew/bin/python3` where pip --user lands)
//   3. spawn `python3 pdg_lookup.py <output_dir>`
//   4. parse the `ANTIMATTER_PDG_RESULT <json>` summary line from
//      stderr
//   5. verify the .csv / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `AntimatterRecord` under
//      `exports/antimatter/pdg/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "particle@<version> (PDG live-data lookup)" — pin
//     the library, NOT the underlying experiment. The PDG values ARE
//     real measured constants but THIS run is not a demiurge
//     measurement; it copies the PDG aggregator's record. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them.
//   • The measurement_VALUES are real (e+ mass = 0.51099895 MeV,
//     antiproton mass = 938.27208816 MeV, antineutron lifetime =
//     878.4 s, antimuon lifetime = 2.197 µs — all matching the 2024
//     PDG live data).
//   • If `particle` is missing OR the Python script crashes OR the
//     summary JSON doesn't parse, returns ok=false and writes no
//     record. Silent success is forbidden.

import Foundation

/// One run of the antimatter PDG-lookup producer — kept as plain text
/// + a record ID so cockpit chat + CLI pretty-print identically (D50).
public struct AntimatterAnalyzeResult: Sendable {
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

public enum AntimatterAnalyzeProducer {

    /// Default location for antimatter PDG records — sibling of
    /// `chip/noc/f1f2/records/`, `sscb/transient/`, `energy/pv/`.
    public static let pdgRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("antimatter/pdg", isDirectory: true)

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. NO cockpit/scripts/ fallback
    /// (any such fallback would be a birth-violation of g_demiurge_
    /// pointer_only).
    public static func locateScript() -> String? {
        let candidate = NSString(
            string: "~/core/hexa-lang/stdlib/antimatter/pdg_lookup.py"
        ).expandingTildeInPath
        if FileManager.default.fileExists(atPath: candidate) {
            return candidate
        }
        return nil
    }

    /// Locate a Python 3 binary — prefer Homebrew's `/opt/homebrew/
    /// bin/python3` (where `pip install --user particle` lands on
    /// macOS), then PATH fallback. Same resolver shape as
    /// EnergyAnalyzeProducer.locatePython3().
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

    /// Run `python3 pdg_lookup.py <pdgRecordsRoot>/<stamp>/` and
    /// persist one `AntimatterRecord` per call. Each call writes
    /// into its own timestamped subdirectory so consecutive runs do
    /// not stomp each other's .csv / .meta.json artifacts.
    public static func runAnalyze() -> AntimatterAnalyzeResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — pdg_lookup.py 를 찾지 못했습니다 "
                + "(~/core/hexa-lang/stdlib/antimatter/). D61 / "
                + "g_demiurge_pointer_only: producer script SSOT 는 "
                + "hexa-lang 안에 살아야 합니다 (g3 — silent success 금지).")
            return AntimatterAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/antimatter/pdg/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = pdgRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ antimatter pdg dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return AntimatterAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). `particle` 패키지 "
                + "(scikit-hep, BSD-3) import 가 필요합니다 (g3 — "
                + "silent success 금지).")
            return AntimatterAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // ANTIMATTER_PDG_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 pdg_lookup.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return AntimatterAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
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
        lines.append("python3 pdg_lookup.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let v = summary.particleVersion {
            lines.append("particle version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["csv", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — antimatter producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return AntimatterAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Re-read the meta.json — the Python side is the SSOT for
        // the numbers; Swift just witnesses + types.
        let metaName = verified["meta"] ?? "pdg_antiparticles_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                AntimatterProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return AntimatterAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "antimatter_pdg_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let pv = summary.particleVersion ?? meta.particleVersion ?? "unknown"
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "particle@\(pv) 의 PDG 데이터는 *real measured constants* "
            + "(decades 동안 accelerator-experiment 가 측정·집계한 PDG "
            + "공식값) 이지만, **이 record 는 demiurge 의 실험 측정이 "
            + "아니라 PDG aggregator 의 record 를 복사한 것** (g3 — "
            + "demiurge 가 가속기를 돌린 적 없음).",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 "
            + "— 흡수에 해당하려면 PDG aggregation pipeline 자체의 "
            + "clean-room re-derivation 이 필요 (다년 가속기 프로그램). "
            + "본 cell 의 scope 는 *citable lookup* 이지 in-house "
            + "measurement 가 아님.",
            "decay_summary 필드는 *brief text* — 각 입자의 full PDG "
            + "decay-mode table (per-mode branching fractions, daughter "
            + "id) 은 record 10× 비대화를 막기 위해 보류 (andrej-"
            + "karpathy minimum-new-structure). 후속 record 가 필요시 "
            + "확장.",
            "antiparticle short-list = 4 개 (positron · antiproton · "
            + "antineutron · antimuon) — domains/antimatter.md §2 의 "
            + "trap + PET 컨텍스트에 등장하는 standard 입자 집합. "
            + "다른 antiparticle (anti-tau · anti-quark) 은 본 cell scope "
            + "밖 — 별도 record 후속.",
        ]

        // Build typed rows from meta.measurements.table.
        let rows = (meta.measurements?.table ?? []).map { r in
            AntiparticleRow(
                label: r.label,
                pdgId: r.pdgId,
                name: r.name,
                pdgName: r.pdgName,
                massMev: r.massMev,
                massLowerMev: r.massLowerMev,
                massUpperMev: r.massUpperMev,
                charge: r.charge,
                lifetimeS: r.lifetimeS,
                ctauM: r.ctauM,
                widthPdgUnits: r.widthPdgUnits,
                spinType: r.spinType,
                isSelfConjugate: r.isSelfConjugate,
                antiFlag: r.antiFlag,
                decaySummary: r.decaySummary)
        }
        let measurements = AntimatterMeasurements(
            rows: meta.measurements?.rows ?? rows.count,
            table: rows)

        let record = AntimatterRecord(
            interface: "demiurge:antimatter:pdg-lookup-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            fingerprint: meta.fingerprint ?? "unknown",
            particleVersion: pv,
            pythonVersion: pyv,
            measurements: measurements,
            artifacts: verified,
            provenance: AntimatterProvenance(
                absorbed: false,
                producer: "particle@\(pv) (PDG live-data lookup)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ antimatter record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return AntimatterAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output lines for the user.
        lines.append("---")
        lines.append("📸 antimatter pdg record → exports/antimatter/pdg/"
            + "\(stamp)/\(recordId).json")
        lines.append("   rows = \(measurements.rows) · producer = "
            + "particle@\(pv)")
        // Surface a couple of the headline values for chat-friendliness.
        if let positron = rows.first(where: { $0.pdgId == -11 }),
           let mass = positron.massMev {
            lines.append(String(
                format: "   positron mass = %.8f MeV · charge = %+.1f e",
                mass, positron.charge))
        }
        if let antiproton = rows.first(where: { $0.pdgId == -2212 }),
           let mass = antiproton.massMev {
            lines.append(String(
                format: "   antiproton mass = %.6f MeV · charge = %+.1f e",
                mass, antiproton.charge))
        }
        if let antimuon = rows.first(where: { $0.pdgId == -13 }),
           let lt = antimuon.lifetimeS {
            lines.append(String(
                format: "   antimuon lifetime = %.4g s",
                lt))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — PDG aggregator "
            + "copy 이지 demiurge 의 실험 측정 아님 (g3, "
            + "scope_caveats 4종 참조).")

        return AntimatterAnalyzeResult(
            ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// Shape we parse out of the producer's `meta.json`. Kept in step
    /// with `~/core/hexa-lang/stdlib/antimatter/pdg_lookup.py::main`'s
    /// write of the meta file.
    private struct AntimatterProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let fingerprint: String?
        let particleVersion: String?
        let pythonVersion: String?
        let measurements: MeasurementsRaw?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case fingerprint
            case particleVersion = "particle_version"
            case pythonVersion = "python_version"
            case measurements
        }

        struct MeasurementsRaw: Decodable {
            let rows: Int
            let table: [RowRaw]
        }

        struct RowRaw: Decodable {
            let label: String
            let pdgId: Int
            let name: String
            let pdgName: String?
            let massMev: Double?
            let massLowerMev: Double?
            let massUpperMev: Double?
            let charge: Double
            let lifetimeS: Double?
            let ctauM: Double?
            let widthPdgUnits: Double?
            let spinType: String?
            let isSelfConjugate: Bool
            let antiFlag: Int
            let decaySummary: String

            enum CodingKeys: String, CodingKey {
                case label
                case pdgId = "pdg_id"
                case name
                case pdgName = "pdg_name"
                case massMev = "mass_mev"
                case massLowerMev = "mass_lower_mev"
                case massUpperMev = "mass_upper_mev"
                case charge
                case lifetimeS = "lifetime_s"
                case ctauM = "ctau_m"
                case widthPdgUnits = "width_pdg_units"
                case spinType = "spin_type"
                case isSelfConjugate = "is_self_conjugate"
                case antiFlag = "anti_flag"
                case decaySummary = "decay_summary"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var particleVersion: String? = nil
        var pythonVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `ANTIMATTER_PDG_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "ANTIMATTER_PDG_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["particle_version"] as? String { out.particleVersion = s }
            if let s = obj["python_version"] as? String { out.pythonVersion = s }
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
