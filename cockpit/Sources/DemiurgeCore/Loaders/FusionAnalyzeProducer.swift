// FusionAnalyzeProducer — θ-2 engine tool for `fusion + analyze`
// (κ-41 / D69). The SIXTH cohort domain wired to a real measuring
// engine tool (after sscb κ-34, energy κ-35, the antimatter producer)
// and the FIRST plasma-physics cell. D61-compliant-from-birth — the Python
// script SSOT lives in `~/core/hexa-lang/stdlib/fusion/plasma_metrics.py`,
// NEVER in cockpit/scripts/ (g_demiurge_pointer_only).
//
// Architecture (mirrors AntimatterAnalyzeProducer, the prior D61-from-
// birth producer):
//   1. locate `~/core/hexa-lang/stdlib/fusion/plasma_metrics.py`
//   2. locate a Python 3 binary that has `plasmapy` (prefer
//      `/opt/homebrew/bin/python3` where `pip install --user plasmapy`
//      lands on macOS)
//   3. spawn `python3 plasma_metrics.py <output_dir>`
//   4. parse the `FUSION_PLASMAPY_RESULT <json>` summary line from
//      stderr
//   5. verify the .csv / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `FusionRecord` under
//      `exports/fusion/plasma/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "plasmapy@<ver> (ITER core reference derivation)" —
//     pin the library AND the scenario name. The derived parameters
//     (omega_pe / lambda_D / v_A / r_Li / gyrofrequencies / thermal
//     speeds) ARE real — Bohm·Debye·Lorentz algebra is mathematical
//     fact. BUT the inputs (n_e = 1e20, T_e = 10 keV, B = 5.3 T) are
//     textbook ITER reference values, NOT a measured-from-a-device
//     shot. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them — that requires
//     Thomson-scattering / interferometry / magnetic-probe readings
//     from an actual tokamak (JET / TFTR / KSTAR / SPARC / ITER).
//   • If `plasmapy` is missing OR the Python script crashes OR the
//     summary JSON doesn't parse, returns ok=false and writes no
//     record. Silent success is forbidden.

import Foundation

/// One run of the fusion plasma-metrics producer — kept as plain text
/// + a record ID so cockpit chat + CLI pretty-print identically (D50).
public struct FusionAnalyzeResult: Sendable {
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

public enum FusionAnalyzeProducer {

    /// Default location for fusion plasma records — sibling of
    /// `antimatter/pdg/`, `energy/pv/`, `sscb/transient/`.
    public static let plasmaRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("fusion/plasma", isDirectory: true)

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. NO cockpit/scripts/ fallback
    /// (any such fallback would be a birth-violation).
    public static func locateScript() -> String? {
        let candidate = NSString(
            string: "~/core/hexa-lang/stdlib/fusion/plasma_metrics.py"
        ).expandingTildeInPath
        if FileManager.default.fileExists(atPath: candidate) {
            return candidate
        }
        return nil
    }

    /// Locate a Python 3 binary — prefer Homebrew's `/opt/homebrew/
    /// bin/python3` (where `pip install --user plasmapy` lands on
    /// macOS), then PATH fallback. Same resolver shape as
    /// AntimatterAnalyzeProducer.locatePython3().
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

    /// Run `python3 plasma_metrics.py <plasmaRecordsRoot>/<stamp>/`
    /// and persist one `FusionRecord` per call. Each call writes into
    /// its own timestamped subdirectory so consecutive runs do not
    /// stomp each other's .csv / .meta.json artifacts.
    public static func runAnalyze() -> FusionAnalyzeResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — plasma_metrics.py 를 찾지 못했습니다 "
                + "(~/core/hexa-lang/stdlib/fusion/). D61 / "
                + "g_demiurge_pointer_only: producer script SSOT 는 "
                + "hexa-lang 안에 살아야 합니다 (g3 — silent success 금지).")
            return FusionAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/fusion/plasma/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = plasmaRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ fusion plasma dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return FusionAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). `plasmapy` 패키지 "
                + "(BSD-2, scikit-hep adjacent) import 가 필요합니다 (g3 — "
                + "silent success 금지).")
            return FusionAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // FUSION_PLASMAPY_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 plasma_metrics.py "
                + "실행 실패: \(error.localizedDescription) (g3).")
            return FusionAnalyzeResult(
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
        lines.append("python3 plasma_metrics.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let v = summary.plasmapyVersion {
            lines.append("plasmapy version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["csv", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — fusion producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return FusionAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Re-read the meta.json — the Python side is the SSOT for
        // the numbers; Swift just witnesses + types.
        let metaName = verified["meta"] ?? "plasma_iter_core_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                FusionProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return FusionAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "fusion_plasma_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let pv = summary.plasmapyVersion ?? meta.plasmapyVersion ?? "unknown"
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "plasmapy@\(pv) 의 derived 파라미터 (omega_pe · lambda_D · "
            + "v_A · gyrofrequencies · thermal speeds) 는 *real* — "
            + "Bohm·Debye·Lorentz algebra 의 수학적 사실이지만, **이 "
            + "record 는 demiurge 의 device 측정이 아니라 textbook "
            + "ITER reference 입력 (n_e=1e20 · T_e=10 keV · B=5.3 T) "
            + "을 derived 한 것** (g3 — demiurge 가 가속기/토카막을 "
            + "돌린 적 없음).",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 "
            + "— 진짜 흡수에 해당하려면 Thomson-scattering / "
            + "interferometry / magnetic-probe 측정이 producer 에 연결 "
            + "되어야 함 (JET / TFTR / KSTAR / SPARC / ITER 실측). "
            + "본 cell 의 scope 는 *textbook-derived parameters* 이지 "
            + "in-house plasma 측정이 아님.",
            "scenario = D+ majority 1종만 (real ITER 는 D-T 50:50; "
            + "T+ contribution 본 v1 에서 미포함). 다른 ion mix "
            + "(H · He³ · He⁴ · D-T) 는 별도 record 후속.",
            "cold-plasma 가정 — 상대론적 보정은 T_e = 10 keV 에서 "
            + "v_th_e ≈ 0.2c 정도이므로 ~2 % 수준이지만 미적용. "
            + "equilibrium (G-S solution) · edge/SOL turbulence · "
            + "neutronics 는 본 record scope 밖 (각각 FreeGS / BOUT++ / "
            + "OpenMC — domains/fusion.md §2).",
        ]

        let scenario = meta.scenario ?? FusionScenario(
            name: "unknown", neM3: 0, teKev: 0, tiKev: 0, bT: 0,
            ionSpecies: "?")
        let m = meta.measurements
        let measurements = FusionMeasurements(
            rows: m?.rows ?? 0,
            omegaPeRadS: m?.omegaPeRadS,
            omegaPiRadS: m?.omegaPiRadS,
            omegaCeRadS: m?.omegaCeRadS,
            omegaCiRadS: m?.omegaCiRadS,
            fPeHz: m?.fPeHz,
            fPiHz: m?.fPiHz,
            fCeHz: m?.fCeHz,
            fCiHz: m?.fCiHz,
            lambdaDM: m?.lambdaDM,
            rLeM: m?.rLeM,
            rLiM: m?.rLiM,
            vThEMs: m?.vThEMs,
            vThIMs: m?.vThIMs,
            vAMs: m?.vAMs)

        let record = FusionRecord(
            interface: "demiurge:fusion:plasma-derived-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            plasmapyVersion: pv,
            pythonVersion: pyv,
            scenario: scenario,
            measurements: measurements,
            artifacts: verified,
            provenance: FusionProvenance(
                absorbed: false,
                producer: "plasmapy@\(pv) (\(scenario.name) derivation)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ fusion record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return FusionAnalyzeResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output lines for the user.
        lines.append("---")
        lines.append("📸 fusion plasma record → exports/fusion/plasma/"
            + "\(stamp)/\(recordId).json")
        lines.append("   scenario = \(scenario.name) · producer = "
            + "plasmapy@\(pv)")
        if let omegaPe = measurements.omegaPeRadS,
           let lambdaD = measurements.lambdaDM,
           let vA = measurements.vAMs {
            lines.append(String(
                format: "   omega_pe = %.3e rad/s · lambda_D = %.3e m · "
                + "v_A = %.3e m/s",
                omegaPe, lambdaD, vA))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — textbook ITER "
            + "inputs 의 derivation 이지 device 측정 아님 (g3, "
            + "scope_caveats 4종 참조).")

        return FusionAnalyzeResult(
            ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// Shape we parse out of the producer's `meta.json`. Kept in step
    /// with `~/core/hexa-lang/stdlib/fusion/plasma_metrics.py::main`'s
    /// write of the meta file.
    private struct FusionProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let plasmapyVersion: String?
        let pythonVersion: String?
        let scenario: FusionScenario?
        let measurements: MeasurementsRaw?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case plasmapyVersion = "plasmapy_version"
            case pythonVersion = "python_version"
            case scenario
            case measurements
        }

        struct MeasurementsRaw: Decodable {
            let rows: Int
            let omegaPeRadS: Double?
            let omegaPiRadS: Double?
            let omegaCeRadS: Double?
            let omegaCiRadS: Double?
            let fPeHz: Double?
            let fPiHz: Double?
            let fCeHz: Double?
            let fCiHz: Double?
            let lambdaDM: Double?
            let rLeM: Double?
            let rLiM: Double?
            let vThEMs: Double?
            let vThIMs: Double?
            let vAMs: Double?

            enum CodingKeys: String, CodingKey {
                case rows
                case omegaPeRadS = "omega_pe_rad_s"
                case omegaPiRadS = "omega_pi_rad_s"
                case omegaCeRadS = "omega_ce_rad_s"
                case omegaCiRadS = "omega_ci_rad_s"
                case fPeHz = "f_pe_Hz"
                case fPiHz = "f_pi_Hz"
                case fCeHz = "f_ce_Hz"
                case fCiHz = "f_ci_Hz"
                case lambdaDM = "lambda_D_m"
                case rLeM = "r_Le_m"
                case rLiM = "r_Li_m"
                case vThEMs = "v_th_e_m_s"
                case vThIMs = "v_th_i_m_s"
                case vAMs = "v_A_m_s"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var plasmapyVersion: String? = nil
        var pythonVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `FUSION_PLASMAPY_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "FUSION_PLASMAPY_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["plasmapy_version"] as? String { out.plasmapyVersion = s }
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
