// CernVerifyProducer — θ-2 engine tool for `cern + verify` (κ-38 / D65).
//
// SIXTH cohort-domain cell crossing the measuring-producer threshold
// (after sscb κ-34, energy κ-35, the antimatter+analyze and cern+analyze
// cohort-round producers, etc.) and the FIRST `verify`-verb cell in the
// cohort domains
// (chip+verify is a separate booksim path). D61-compliant-from-birth —
// the producer script SSOT lives in ~/core/hexa-lang/stdlib/cern/
// bethe_bloch_stopping.py, NEVER in cockpit/scripts/.
//
// Architecture (mirrors AntimatterAnalyzeProducer):
//   1. locate `~/core/hexa-lang/stdlib/cern/bethe_bloch_stopping.py`
//   2. locate a Python 3 binary that has the `particle` package
//      (prefer `/opt/homebrew/bin/python3` where pip --user lands;
//      `uproot` is optional — its absence omits the `.root` artifact
//      but does not fail the producer, by design)
//   3. spawn `python3 bethe_bloch_stopping.py <output_dir>`
//   4. parse the `CERN_G4_RESULT <json>` summary line from stderr
//   5. verify the .csv / .meta.json artifacts exist on disk (and the
//      .root artifact if the meta claimed it) — defence-in-depth, @F f6
//   6. emit one typed `CernRecord` under
//      `exports/cern/stopping/<stamp>/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "particle@<v> + Bethe-Bloch analytic (no Geant4 MC)"
//     — pin library + algorithm, NOT experiment identity.
//   • Bethe-Bloch values ARE real measured-physics constants (PDG K,
//     mean-excitation I, antiproton mass, electron mass), but THIS run
//     omits four pieces vs full Geant4 MC: shell corrections, density
//     effect, straggling distribution, nuclear stopping. So:
//       measurementGate = GATE_OPEN ALWAYS
//       absorbed = false ALWAYS
//     There is no path here that flips them. Stage 2 hexa-native port
//     + Stage 3 parity check against Geant4 is the only route to
//     absorbed=true (per ABSORPTION.md §"hexa 포팅 단계"; Geant4 hexa
//     port = ⭐⭐⭐⭐⭐ months-to-year scope).
//   • If `particle` is missing OR the Python script crashes OR the
//     summary JSON doesn't parse, returns ok=false and writes no
//     record. Silent success forbidden.

import Foundation

/// One run of the cern Bethe-Bloch stopping-power producer — kept as
/// plain text + a record ID so cockpit chat + CLI pretty-print
/// identically (D50).
public struct CernVerifyResult: Sendable {
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

public enum CernVerifyProducer {

    /// Default location for cern stopping-power records — sibling of
    /// `chip/noc/f1f2/records/`, `sscb/transient/`, `energy/pv/`,
    /// `antimatter/pdg/`.
    public static let stoppingRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("cern/stopping", isDirectory: true)

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. NO cockpit/scripts/ fallback
    /// (any such fallback would be a birth-violation of g_demiurge_
    /// pointer_only — D61).
    public static func locateScript() -> String? {
        let candidate = NSString(
            string: "~/core/hexa-lang/stdlib/cern/bethe_bloch_stopping.py"
        ).expandingTildeInPath
        if FileManager.default.fileExists(atPath: candidate) {
            return candidate
        }
        return nil
    }

    /// Locate a Python 3 binary — prefer Homebrew's `/opt/homebrew/
    /// bin/python3` (where `pip install --user particle` lands on
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

    /// Run `python3 bethe_bloch_stopping.py <stoppingRecordsRoot>/
    /// <stamp>/` and persist one `CernRecord` per call. Each call
    /// writes into its own timestamped subdirectory so consecutive runs
    /// do not stomp each other's .csv / .meta.json / .root artifacts.
    public static func runVerify() -> CernVerifyResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — bethe_bloch_stopping.py 를 "
                + "찾지 못했습니다 (~/core/hexa-lang/stdlib/cern/). "
                + "D61 / g_demiurge_pointer_only: producer script SSOT "
                + "는 hexa-lang 안에 살아야 합니다 (g3 — silent success "
                + "금지).")
            return CernVerifyResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = stoppingRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ cern stopping dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return CernVerifyResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). `particle` 패키지 "
                + "(scikit-hep, BSD-3) import 가 필요합니다. `uproot` "
                + "도 있으면 .root artifact 까지 생성 (g3 — silent "
                + "success 금지).")
            return CernVerifyResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe  // merge — script writes the
                                   // CERN_G4_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 "
                + "bethe_bloch_stopping.py 실행 실패: "
                + "\(error.localizedDescription) (g3).")
            return CernVerifyResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify artifacts on disk (defence-in-depth, @F f6).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts where !rel.isEmpty {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int)
                ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("script = \(script)")
        lines.append("python3 = \(py)")
        lines.append("python3 bethe_bloch_stopping.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let v = summary.particleVersion {
            lines.append("particle version: \(v)")
        }
        if let uv = summary.uprootVersion {
            lines.append("uproot version: \(uv) (ROOT artifact emitted)")
        } else {
            lines.append("uproot: missing — .root artifact 생략 (csv + "
                + "meta only)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        // csv + meta are mandatory; root is optional.
        let needed = ["csv", "meta"]
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
            return CernVerifyResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Re-read the meta.json — the Python side is the SSOT for the
        // numbers; Swift just witnesses + types.
        let metaName = verified["meta"] ?? "cern_g4_stopping_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                CernProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return CernVerifyResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "cern_g4_stopping_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let pv = summary.particleVersion ?? meta.particleVersion ?? "unknown"
        let uv = summary.uprootVersion ?? meta.uprootVersion
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "Bethe-Bloch IS the closed-form expression Geant4 의 "
            + "G4hIonisation 이 non-relativistic 영역에서 stopping-power "
            + "table 을 채우는 형식이지만, **본 run 은 네 가지를 생략**: "
            + "(a) shell corrections (low E 에서 Z/β 보정), (b) density-"
            + "effect δ (high γ Sternheimer), (c) straggling 분포, "
            + "(d) nuclear stopping channel. 따라서 trap-design scoping "
            + "용 — Geant4 MC absorbed-claim 대체 아님 (g3).",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구. "
            + "Stage 4 absorbed=true 진입 조건은 hexa-native re-derivation "
            + "(stdlib/cern/.hexa) 후 Geant4 MC 와 tolerance 내 parity 측정 "
            + "(ABSORPTION.md §\"hexa 포팅 단계\"). Geant4 hexa 포팅 = "
            + "⭐⭐⭐⭐⭐ (Monte-Carlo 입자 시뮬레이터 전체).",
            "antiproton mass · 전자질량 · K_BB factor · I_eV 는 PDG 2024 "
            + "aggregator copy — 본 cell 은 **demiurge 가 측정한 것이 "
            + "아니라 PDG-aggregated 값 + Bethe-Bloch 함수 합성**. "
            + "absorbed 권한은 PDG aggregation pipeline clean-room 재유도 "
            + "(다년 가속기 프로그램) 가 별도 필요 (antimatter+analyze "
            + "scope_caveat 와 동일 구조).",
            "재료 4종 = (Al, Cu, W, Pb) — CERN-style shielding + "
            + "antiproton trap 의 표준 short-list (PDG RPP Table 34.1). "
            + "KE grid = (1, 3, 10, 30, 100, 300, 1000) MeV — ELENA "
            + "injection 영역부터 fixed-target 까지 7-point 거친 grid, "
            + "fine sweep 은 후속 record (premature optimization 회피).",
        ]

        let rows = (meta.measurements?.table ?? []).map { r in
            StoppingPowerRow(
                material: r.material,
                zTarget: r.zTarget,
                aTargetGpermol: r.aTargetGpermol,
                iEv: r.iEv,
                keMev: r.keMev,
                beta: r.beta,
                gamma: r.gamma,
                tmaxMev: r.tmaxMev,
                dedxMevcm2PerG: r.dedxMevcm2PerG)
        }
        let measurements = CernMeasurements(
            rows: meta.measurements?.rows ?? rows.count,
            materials: meta.measurements?.materials ?? [],
            keMevSamples: meta.measurements?.keMevSamples ?? [],
            table: rows)
        let constants = CernConstants(
            kBbMevcm2PerG: meta.constants?.kBbMevcm2PerG ?? 0.307075,
            antiprotonMassMev: meta.constants?.antiprotonMassMev ?? 0,
            electronMassMev: meta.constants?.electronMassMev ?? 0)

        let record = CernRecord(
            interface: "demiurge:cern:stopping-power-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            fingerprint: meta.fingerprint ?? "unknown",
            particleVersion: pv,
            uprootVersion: uv,
            pythonVersion: pyv,
            constants: constants,
            measurements: measurements,
            artifacts: verified,
            provenance: CernProvenance(
                absorbed: false,
                producer: "particle@\(pv) + Bethe-Bloch analytic "
                    + "(no Geant4 MC)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ cern record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return CernVerifyResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        lines.append("---")
        lines.append("📸 cern stopping record → exports/cern/stopping/"
            + "\(stamp)/\(recordId).json")
        lines.append("   rows = \(measurements.rows) · materials = "
            + measurements.materials.joined(separator: ", "))
        // Surface a couple of headline dE/dx values for chat-friendliness.
        if let pb100 = rows.first(where: {
            $0.material == "Pb" && abs($0.keMev - 100.0) < 1e-6 }) {
            lines.append(String(
                format: "   Pb @ 100 MeV: dE/dx = %.4f MeV·cm²/g · β = %.4f",
                pb100.dedxMevcm2PerG, pb100.beta))
        }
        if let al1000 = rows.first(where: {
            $0.material == "Al" && abs($0.keMev - 1000.0) < 1e-6 }) {
            lines.append(String(
                format: "   Al @ 1 GeV : dE/dx = %.4f MeV·cm²/g · γ = %.4f",
                al1000.dedxMevcm2PerG, al1000.gamma))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — Bethe-Bloch "
            + "analytic, Geant4 MC 4종 보정 (shell · density · straggling "
            + "· nuclear) 미적용 (g3, scope_caveats 4종 참조).")

        return CernVerifyResult(
            ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// Shape we parse out of the producer's `meta.json`. Kept in step
    /// with `~/core/hexa-lang/stdlib/cern/bethe_bloch_stopping.py::main`'s
    /// write of the meta file.
    private struct CernProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let fingerprint: String?
        let particleVersion: String?
        let uprootVersion: String?
        let pythonVersion: String?
        let constants: ConstantsRaw?
        let measurements: MeasurementsRaw?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case fingerprint
            case particleVersion = "particle_version"
            case uprootVersion = "uproot_version"
            case pythonVersion = "python_version"
            case constants
            case measurements
        }

        struct ConstantsRaw: Decodable {
            let kBbMevcm2PerG: Double
            let antiprotonMassMev: Double
            let electronMassMev: Double

            enum CodingKeys: String, CodingKey {
                case kBbMevcm2PerG = "k_bb_mevcm2_per_g"
                case antiprotonMassMev = "antiproton_mass_mev"
                case electronMassMev = "electron_mass_mev"
            }
        }

        struct MeasurementsRaw: Decodable {
            let rows: Int
            let materials: [String]
            let keMevSamples: [Double]
            let table: [RowRaw]

            enum CodingKeys: String, CodingKey {
                case rows
                case materials
                case keMevSamples = "ke_mev_samples"
                case table
            }
        }

        struct RowRaw: Decodable {
            let material: String
            let zTarget: Int
            let aTargetGpermol: Double
            let iEv: Double
            let keMev: Double
            let beta: Double
            let gamma: Double
            let tmaxMev: Double
            let dedxMevcm2PerG: Double

            enum CodingKeys: String, CodingKey {
                case material
                case zTarget = "z_target"
                case aTargetGpermol = "a_target_gpermol"
                case iEv = "i_ev"
                case keMev = "ke_mev"
                case beta
                case gamma
                case tmaxMev = "tmax_mev"
                case dedxMevcm2PerG = "dedx_mevcm2_per_g"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var particleVersion: String? = nil
        var uprootVersion: String? = nil
        var pythonVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `CERN_G4_RESULT <json>` from the merged Python stdout /
    /// stderr and decode the JSON payload. Tolerant of any other lines
    /// around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "CERN_G4_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["particle_version"] as? String {
                out.particleVersion = s
            }
            if let s = obj["uproot_version"] as? String {
                out.uprootVersion = s
            }
            if let s = obj["python_version"] as? String {
                out.pythonVersion = s
            }
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
