// EnergyAnalyzeProducer — θ-2 engine tool for `energy + analyze`
// (κ-35 / D59). The FOURTH cohort domain wired to a real measuring
// engine tool (after sscb κ-34) and the FIRST renewable-energy cell.
//
// Architecture (mirrors SSCBProducer + FreeCADBIPVProducer):
//   1. locate `cockpit/scripts/energy_pvlib.py`
//   2. spawn `python3 energy_pvlib.py <output_dir>` — Python wraps the
//      pvlib ModelChain so the CSV time series + meta.json all live in
//      <output_dir> with no shell quoting hazards
//   3. parse the `ENERGY_PVLIB_RESULT <json>` summary line from stderr
//   4. verify the .csv / .meta.json artifacts exist on disk (defence-
//      in-depth — @F f6 evidence-over-assertion)
//   5. emit one typed `EnergyRecord` under
//      `exports/energy/pv/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "pvlib@<version>" — pins the library, not the site
//     weather data. Ineichen clear-sky + CEC SAPM module model are
//     NREL SAM-verified, but ZERO real sky-measured irradiance is
//     used. This is the *clear-sky upper bound*, not a TMY yield
//     prediction. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them to closedMeasured
//     — that requires TMY3 / NSRDB sky-measured data + bench-validated
//     module I-V curves + system loss model.
//   • The measurement_VALUES are real (e.g. ~468 kWh/yr AC for a
//     standard 220 W CEC module at Phoenix latitude). They surface
//     the honest upper bound between this clear-sky algorithm output
//     and what TMY-derived simulation would produce (typically 70-85
//     % of clear-sky bound). That gap is the POINT of the record.
//   • If pvlib is missing OR the Python script crashes OR the summary
//     JSON doesn't parse, returns ok=false and writes no record.
//     Silent success is forbidden.

import Foundation

/// One run of the energy producer — kept as plain text + a record ID
/// so cockpit chat + CLI pretty-print identically (D50).
public struct EnergyAnalyzeResult: Sendable {
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

public enum EnergyAnalyzeProducer {

    /// Default location for energy PV records — sibling of
    /// `chip/noc/f1f2/records/`, `sscb/transient/`, etc.
    public static let pvRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("energy/pv", isDirectory: true)

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. Migrated 2026-05-20 in the D61
    /// batch-migration round
    /// from `cockpit/scripts/energy_pvlib.py`.
    public static func locateScript() -> String? {
        let path = NSString(
            string: "~/core/hexa-lang/stdlib/energy/pvlib_clearsky.py"
        ).expandingTildeInPath
        return FileManager.default.fileExists(atPath: path) ? path : nil
    }

    /// Locate a Python 3 binary that has pvlib installed — prefer
    /// Homebrew's `/opt/homebrew/bin/python3` (where `pip install pvlib`
    /// lands on macOS), then PATH fallback. Xcode-bundled `python3`
    /// (`/Applications/Xcode.app/.../python3`) does NOT have pvlib and
    /// `/usr/bin/env python3` resolves to it first in DemiurgeCLI's
    /// inherited PATH — so an explicit resolver is required (g3 —
    /// silent fallback to a python without pvlib would surface as
    /// a confusing ModuleNotFoundError).
    public static func locatePython3() -> String? {
        let fm = FileManager.default
        let candidates = [
            "/opt/homebrew/bin/python3",
            "/usr/local/bin/python3",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // PATH fallback via `which python3` — last resort.
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

    /// Run `python3 energy_pvlib.py <pvRecordsRoot>/<stamp>/` and
    /// persist one `EnergyRecord` per call. Each call writes into its
    /// own timestamped subdirectory so consecutive runs do not stomp
    /// each other's .csv / .meta.json artifacts.
    public static func runAnalyze() -> EnergyAnalyzeResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — energy_pvlib.py 를 찾지 못했습니다 "
                + "(cockpit/scripts/). 절차 fallback 없음 — 본 셀은 producer "
                + "필수 (g3).")
            return EnergyAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/energy/pv/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = pvRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ energy pv dir mkdir 실패: \(error.localizedDescription)")
            return EnergyAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the script. pvlib import resolution is
        // the script's job (its own `import pvlib` will fail honestly
        // if not installed). We pick the brew python3 first because
        // that's where `pip install pvlib` lands on macOS (the Xcode-
        // bundled python3 first on PATH does NOT have pvlib).
        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). pvlib import 가 "
                + "필요합니다 (g3 — silent success 금지).")
            return EnergyAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // ENERGY_PVLIB_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 energy_pvlib.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return EnergyAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the ENERGY_PVLIB_RESULT <json> line.
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
        lines.append("python3 energy_pvlib.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let v = summary.pvlibVersion {
            lines.append("pvlib version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["csv", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — energy producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            // Even on failure, do not silently succeed — return without
            // writing a typed record.
            return EnergyAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Site + system + measurements come
        // from re-reading the meta.json (the Python side is the SSOT
        // for the numbers — Swift just witnesses + types).
        let metaName = verified["meta"] ?? "pv_clearsky_phoenix_az_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(EnergyProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) "
                + "— record 미작성 (g3).")
            return EnergyAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "energy_pv_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let pvv = summary.pvlibVersion ?? meta.pvlibVersion ?? "unknown"
        let caveats: [String] = [
            "pvlib 의 clear-sky 시뮬레이션 출력 — 숫자는 실제 "
            + "(Ineichen + CEC SAPM 알고리즘, NREL SAM 검증) 이지만, "
            + "*sky-measured irradiance 데이터는 0* (no TMY3 / NSRDB). "
            + "이것은 *clear-sky upper bound* 이지 TMY yield 예측이 "
            + "아니다 (g3 — 실제 yield 는 보통 70-85 % 수준).",
            "module = CEC database lookup (\(meta.system?.module ?? "?")) "
            + "— bench-validated I-V curves 가 아님. 진짜 흡수는 "
            + "datasheet flash-test + bench 측정이 들어와야.",
            "system losses 미적용 — DC wiring (~2 %), 모듈 mismatch "
            + "(~2 %), soiling (~3-5 %), inverter clipping 등이 빠져 "
            + "있어 honest 하게 optimistic. 본 record 는 알고리즘 "
            + "upper bound 단일점.",
            "measurement_gate = GATE_OPEN 영구 / absorbed=false 영구 "
            + "— pvlib BSD-3 + 표준 알고리즘은 흡수 충분이지만, "
            + "*site 의 absorbed weather data* 가 없으므로 yield "
            + "claim 은 미흡수. NREL SAM 자체 인증 ≠ 본 record (g3).",
        ]

        let pyv = meta.pythonVersion ?? "unknown"

        let site = meta.site ?? EnergySite(
            name: "unknown", latitude: 0, longitude: 0,
            altitudeM: 0, timezone: "UTC")
        let system = meta.system ?? EnergySystemSpec(
            module: "unknown", inverter: "unknown",
            surfaceTilt: 0, surfaceAzimuth: 0,
            modulesPerString: 0, strings: 0,
            tempAirC: 25.0, windSpeedMs: 0)
        let sim = meta.simulation ?? EnergySimulation(
            year: 0, freq: "1h", model: "unknown")

        // Convert {Int: Double} monthly dict from python json to
        // {String: Double} for stable Codable.
        var monthlyStr: [String: Double] = [:]
        for (k, v) in (meta.measurements?.monthlyAcKwh ?? [:]) {
            monthlyStr[k] = v
        }
        let m = meta.measurements
        let measurements = EnergyMeasurements(
            rows: m?.rows ?? 0,
            annualEnergyKwh: m?.annualEnergyKwh,
            annualEnergyDcKwh: m?.annualEnergyDcKwh,
            dcPeakKw: m?.dcPeakKw,
            acPeakKw: m?.acPeakKw,
            ghiAnnualMwhPerM2: m?.ghiAnnualMwhPerM2,
            monthlyAcKwh: monthlyStr)

        let record = EnergyRecord(
            interface: "demiurge:energy:pv-clearsky-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            pvlibVersion: pvv,
            pythonVersion: pyv,
            site: site,
            system: system,
            simulation: sim,
            measurements: measurements,
            artifacts: verified,
            provenance: EnergyProvenance(
                absorbed: false,
                producer: "pvlib@\(pvv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ energy record JSON 쓰기 실패: \(error.localizedDescription)")
            return EnergyAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output line for the user.
        lines.append("---")
        lines.append("📸 energy pv record → exports/energy/pv/"
            + "\(stamp)/\(recordId).json")
        if let kwh = measurements.annualEnergyKwh,
           let pk = measurements.acPeakKw {
            lines.append(String(format: "   annual_energy_kwh = %.1f · "
                + "ac_peak_kw = %.3f · producer = pvlib@%@",
                kwh, pk, pvv))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — 표준 알고리즘 "
            + "출력 (NREL SAM 검증) 이지만 sky-measured 데이터 없음 "
            + "→ clear-sky upper bound (g3, scope_caveats 4종 참조).")

        return EnergyAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `cockpit/scripts/energy_pvlib.py::main`'s write_meta().
    private struct EnergyProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let pvlibVersion: String?
        let pythonVersion: String?
        let site: EnergySite?
        let system: EnergySystemSpec?
        let simulation: EnergySimulation?
        let measurements: MeasurementsRaw?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case pvlibVersion = "pvlib_version"
            case pythonVersion = "python_version"
            case site
            case system
            case simulation
            case measurements
        }

        /// Raw measurements — monthly_ac_kwh is keyed by int in the
        /// Python JSON (1..12), Swift JSONDecoder accepts those as
        /// string keys when target is `[String: Double]`.
        struct MeasurementsRaw: Decodable {
            let rows: Int
            let annualEnergyKwh: Double?
            let annualEnergyDcKwh: Double?
            let dcPeakKw: Double?
            let acPeakKw: Double?
            let ghiAnnualMwhPerM2: Double?
            let monthlyAcKwh: [String: Double]?

            enum CodingKeys: String, CodingKey {
                case rows
                case annualEnergyKwh = "annual_energy_kwh"
                case annualEnergyDcKwh = "annual_energy_dc_kwh"
                case dcPeakKw = "dc_peak_kw"
                case acPeakKw = "ac_peak_kw"
                case ghiAnnualMwhPerM2 = "ghi_annual_mwh_per_m2"
                case monthlyAcKwh = "monthly_ac_kwh"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var pvlibVersion: String? = nil
        var pythonVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `ENERGY_PVLIB_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "ENERGY_PVLIB_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["pvlib_version"] as? String { out.pvlibVersion = s }
            if let s = obj["python_version"] as? String { out.pythonVersion = s }
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
