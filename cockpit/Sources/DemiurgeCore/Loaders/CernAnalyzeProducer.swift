// CernAnalyzeProducer — θ-2 engine tool for `cern + analyze`
// (κ-44 / D66). The FIFTH cohort domain wired to a real measuring
// engine tool (after sscb κ-34, energy κ-38) and the FIRST particle-
// accelerator-physics cell.
//
// D61 compliance (NEW — first producer landed already-correct):
// the producer script SSOT lives in `~/core/hexa-lang/stdlib/cern/
// lhe_stats.py`, NOT in `cockpit/scripts/`. demiurge holds only this
// `Process` spawn wrapper — the compute logic + pylhe import + LHE
// round-trip all live in hexa-lang. (Earlier producers — bipv_freecad,
// sscb_ngspice, energy_pvlib — are AGENTS.tape birth-violations
// pending a D61 migration batch; this one is the first that lands
// already compliant.)
//
// Architecture (mirrors EnergyAnalyzeProducer + SSCBProducer):
//   1. locate `~/core/hexa-lang/stdlib/cern/lhe_stats.py`
//   2. spawn `python3 lhe_stats.py <output_dir>` — Python wraps the
//      pylhe LHE-write + LHE-re-read round-trip so the .lhe + meta.json
//      all live in <output_dir> with no shell quoting hazards
//   3. parse the `CERN_LHE_STATS_RESULT <json>` summary line from stderr
//   4. verify the .lhe / .meta.json artifacts exist on disk (defence-
//      in-depth — @F f6 evidence-over-assertion)
//   5. emit one typed `CernAnalyzeRecord` under
//      `exports/cern/lhe/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "pylhe@<version>" — pins the library, not the LHC.
//     pylhe correctly round-trips the standards-compliant LHE format
//     we emit; the round-trip statistics ARE real algorithm output.
//   • BUT the input events are synthetic kinematics (e+ e- -> Z ->
//     mu+ mu- at sqrt(s) = M_Z with deterministic angles), NOT a
//     tuned MadGraph/POWHEG/Sherpa generator output and NOT real LHC
//     data. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them to closedMeasured
//     — that requires a tuned generator card + detector simulation
//     (Delphes/Geant4) + tuned ATLAS/CMS object selection.
//   • The measurement_VALUES are real (e.g. n_events round-tripped =
//     100, final-state energy total = 100 × sqrt(s) = 9118.76 GeV by
//     per-event energy conservation). They surface that pylhe's
//     parser handles our LHE v3 write end-to-end — that is the POINT
//     of the record.
//   • If pylhe is missing OR the Python script crashes OR the summary
//     JSON doesn't parse, returns ok=false and writes no record.
//     Silent success is forbidden.

import Foundation

/// One run of the cern producer — kept as plain text + a record ID
/// so cockpit chat + CLI pretty-print identically (D50).
public struct CernAnalyzeResult: Sendable {
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

public enum CernAnalyzeProducer {

    /// Default location for cern LHE records — sibling of
    /// `chip/noc/f1f2/records/`, `sscb/transient/`, `energy/pv/`.
    public static let lheRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("cern/lhe", isDirectory: true)

    /// Locate `~/core/hexa-lang/stdlib/cern/lhe_stats.py` — D61-compliant
    /// SSOT location (NOT `cockpit/scripts/`). nil = engine-tool gap.
    public static func locateScript() -> String? {
        let home = NSString(string: "~").expandingTildeInPath
        let candidate = URL(fileURLWithPath: home)
            .appendingPathComponent("core/hexa-lang/stdlib/cern/lhe_stats.py")
            .standardizedFileURL
        if FileManager.default.fileExists(atPath: candidate.path) {
            return candidate.path
        }
        return nil
    }

    /// Locate a Python 3 binary that has pylhe installed — prefer
    /// Homebrew's `/opt/homebrew/bin/python3` (where `pip install pylhe`
    /// lands on macOS), then PATH fallback. Same resolver as
    /// EnergyAnalyzeProducer.locatePython3() — pip-installed packages
    /// live on the brew python, not on Xcode-bundled / /usr/bin
    /// python3 (g3 — silent ModuleNotFoundError must surface).
    public static func locatePython3() -> String? {
        let fm = FileManager.default
        let candidates = [
            "/opt/homebrew/bin/python3",
            "/usr/local/bin/python3",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
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

    /// Run `python3 lhe_stats.py <lheRecordsRoot>/<stamp>/` and
    /// persist one `CernAnalyzeRecord` per call. Each call writes into its
    /// own timestamped subdirectory so consecutive runs do not stomp
    /// each other's .lhe / .meta.json artifacts.
    public static func runAnalyze() -> CernAnalyzeResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — lhe_stats.py 를 찾지 못했습니다 "
                + "(~/core/hexa-lang/stdlib/cern/lhe_stats.py). D61 = "
                + "스크립트 SSOT 는 hexa-lang stdlib (g3 — silent "
                + "fallback 없음).")
            return CernAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/cern/lhe/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = lheRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ cern lhe dir mkdir 실패: \(error.localizedDescription)")
            return CernAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the script. pylhe import resolution is
        // the script's job (its own `import pylhe` will fail honestly
        // if not installed). brew python3 first — pip-installed pylhe
        // lives there.
        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). pylhe import 가 "
                + "필요합니다 (g3 — silent success 금지).")
            return CernAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // CERN_LHE_STATS_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 lhe_stats.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return CernAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the CERN_LHE_STATS_RESULT <json> line.
        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the two artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts where !rel.isEmpty {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python3 = \(py)")
        lines.append("script = \(script)")
        lines.append("python3 lhe_stats.py — exit \(exitCode), "
            + "n_events=\(summary.nEvents ?? 0)")
        if let v = summary.pylheVersion {
            lines.append("pylhe version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["lhe", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — cern producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return CernAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Process + sample + measurements come
        // from re-reading the meta.json (the Python side is the SSOT
        // for the numbers — Swift just witnesses + types).
        let metaName = verified["meta"] ?? "lhe_zmumu_synth_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(CernProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) "
                + "— record 미작성 (g3).")
            return CernAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "cern_lhe_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let plv = summary.pylheVersion ?? meta.pylheVersion ?? "unknown"
        let pyv = meta.pythonVersion ?? "unknown"
        let caveats: [String] = [
            "pylhe 의 LHE round-trip 결과 — 숫자는 실제 (pylhe 가 "
            + "표준 LHE v3 포맷을 정확히 파싱하는 알고리즘 출력) 이지만, "
            + "입력 이벤트는 합성 kinematics (e+e- → Z → mu+mu-, "
            + "deterministic 각도) 이며 MadGraph/POWHEG/Sherpa 등 "
            + "tuned 생성기 출력이 아니고 실제 LHC 데이터도 아님 (g3).",
            "channel = \(meta.process?.channel ?? "?") at sqrt(s) = "
            + "\(meta.process?.sqrtSGev ?? 0) GeV — on-shell mass + "
            + "per-event 4-momentum 보존만 만족, 분포 (rapidity, "
            + "transverse momentum, angular) 는 tuned MC 가 아님.",
            "detector simulation 미적용 — Delphes / Geant4 smearing, "
            + "efficiency, acceptance, trigger 가 빠져 있어 ATLAS/CMS "
            + "analysis 와 직접 비교 불가. 본 record 는 LHE 파서 "
            + "round-trip 단일점.",
            "measurement_gate = GATE_OPEN 영구 / absorbed=false 영구 "
            + "— pylhe BSD-3 + LHE 표준은 흡수 충분이지만, *물리적 "
            + "예측력* 은 tuned 생성기 + 검출기 시뮬 + ATLAS/CMS object "
            + "selection 이 들어와야. 실제 LHC 측정 데이터 ≠ 본 record "
            + "(g3).",
        ]

        let process = meta.process ?? CernProcess(
            channel: "unknown", sqrtSGev: 0,
            nEventsRequested: 0, rngSeed: 0, lheVersion: "unknown")
        let sample = meta.sample ?? CernSample(
            lheArtifact: verified["lhe"] ?? "", lheBytes: 0)
        let m = meta.measurements
        let measurements = CernAnalyzeMeasurements(
            nEvents: m?.nEvents ?? 0,
            multiplicityMean: m?.multiplicityMean,
            multiplicityMin: m?.multiplicityMin,
            multiplicityMax: m?.multiplicityMax,
            nFinalState: m?.nFinalState ?? 0,
            finalStateEnergyGevTotal: m?.finalStateEnergyGevTotal,
            finalStateAbsPzGevTotal: m?.finalStateAbsPzGevTotal,
            pidCounts: m?.pidCounts ?? [:])

        let record = CernAnalyzeRecord(
            interface: "demiurge:cern:lhe-stats-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            pylheVersion: plv,
            pythonVersion: pyv,
            process: process,
            sample: sample,
            measurements: measurements,
            artifacts: verified,
            provenance: CernAnalyzeProvenance(
                absorbed: false,
                producer: "pylhe@\(plv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ cern record JSON 쓰기 실패: \(error.localizedDescription)")
            return CernAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output line for the user.
        lines.append("---")
        lines.append("📸 cern lhe record → exports/cern/lhe/"
            + "\(stamp)/\(recordId).json")
        if let mult = measurements.multiplicityMean,
           let etot = measurements.finalStateEnergyGevTotal {
            lines.append(String(format: "   n_events = %d · "
                + "multiplicity_mean = %.2f · final_E_total = %.2f GeV · "
                + "producer = pylhe@%@",
                measurements.nEvents, mult, etot, plv))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — pylhe round-trip "
            + "는 실제이지만 입력 events 는 합성 kinematics, 실제 LHC "
            + "데이터 아님 (g3, scope_caveats 4종 참조).")

        return CernAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `~/core/hexa-lang/stdlib/cern/lhe_stats.py::main`'s
    /// write block.
    private struct CernProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let pylheVersion: String?
        let pythonVersion: String?
        let process: CernProcess?
        let sample: CernSample?
        let measurements: MeasurementsRaw?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case pylheVersion = "pylhe_version"
            case pythonVersion = "python_version"
            case process
            case sample
            case measurements
        }

        struct MeasurementsRaw: Decodable {
            let nEvents: Int
            let multiplicityMean: Double?
            let multiplicityMin: Int?
            let multiplicityMax: Int?
            let nFinalState: Int
            let finalStateEnergyGevTotal: Double?
            let finalStateAbsPzGevTotal: Double?
            let pidCounts: [String: Int]?

            enum CodingKeys: String, CodingKey {
                case nEvents = "n_events"
                case multiplicityMean = "multiplicity_mean"
                case multiplicityMin = "multiplicity_min"
                case multiplicityMax = "multiplicity_max"
                case nFinalState = "n_final_state"
                case finalStateEnergyGevTotal = "final_state_energy_gev_total"
                case finalStateAbsPzGevTotal = "final_state_abs_pz_gev_total"
                case pidCounts = "pid_counts"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var pylheVersion: String? = nil
        var pythonVersion: String? = nil
        var nEvents: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `CERN_LHE_STATS_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "CERN_LHE_STATS_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["pylhe_version"] as? String { out.pylheVersion = s }
            if let s = obj["python_version"] as? String { out.pythonVersion = s }
            if let n = obj["n_events"] as? Int { out.nEvents = n }
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
