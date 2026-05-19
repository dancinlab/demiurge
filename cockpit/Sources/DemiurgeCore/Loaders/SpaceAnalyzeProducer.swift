// SpaceAnalyzeProducer — θ-2 engine tool for `space + analyze`
// (D60; cohort-round producer, no standalone PLAN κ entry — post-merge
// reconstructed).
//
// The FIFTH cohort domain (after sscb / grid / bot / brain) wired to a
// real measuring engine tool — Skyfield SGP4 orbit propagation over
// standard NORAD TLEs (ISS ZARYA + HST). Producer is the
// Skyfield+SGP4 library pair; demiurge spawns it and persists the
// per-satellite aggregates as a typed `SpaceRecord`.
//
// Architecture (mirrors SSCBProducer + MatterAnalyzer):
//   1. locate `python3` (brew Python preferred — Skyfield is pip-
//      installed under /opt/homebrew/lib/python3.X/site-packages)
//   2. locate `cockpit/scripts/space_skyfield.py`
//   3. spawn `python3 space_skyfield.py <output_dir>` — Python wraps
//      the Skyfield invocation so the TLE + tracks + meta.json all
//      live in <output_dir> with no shell quoting hazards
//   4. parse the `SPACE_SKYFIELD_RESULT <json>` summary line from stderr
//   5. verify the artifacts exist on disk (defence-in-depth — @F f6)
//   6. emit one typed `SpaceRecord` under
//      `exports/space/orbit/<id>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "skyfield@<v>+sgp4@<v>" — pins the propagator
//     library pair. Numbers ARE real (SGP4 is the NORAD-standard
//     propagator, validated by Vallado 2006 against the NORAD
//     reference implementation; ~1 km positional accuracy at epoch).
//   • TLE accuracy DECAYS with age (~1 km/day; ~3 km/week; loses
//     usefulness past ~14 days). Gate path:
//       - worst_tle_age_days ≤ 7  → GATE_CLOSED_MEASURED
//         (within SGP4 nominal validity window — Skyfield + SGP4 are
//         bench-validated against NORAD reference; the only g3 caveat
//         is TLE-age, not absorption — and inside 7 days that caveat
//         is below threshold)
//       - worst_tle_age_days > 7  → GATE_OPEN (drifted TLE, predictions
//         degrade outside nominal window; surfaced honestly)
//   • absorbed = false ALWAYS — Skyfield is an EXTERNAL Python library
//     (pip install), NOT absorbed into hexa-lang / hexa-arch. Same
//     banned-absorbed stance as ngspice (sscb), networkx (grid), URDF
//     (bot), nibabel (brain). g3-CRITICAL: even with GATE_CLOSED on
//     a fresh TLE, absorbed stays false — closed measurement gate ≠
//     absorbed tool ownership.
//   • If python3 / skyfield / script is missing OR the Python crashes
//     OR the summary JSON doesn't parse, returns ok=false and writes
//     no record. Silent success is forbidden.

import Foundation

/// One run of the Space producer — kept as plain text + a record ID so
/// cockpit chat + CLI pretty-print identically (D50).
public struct SpaceAnalyzeResult: Sendable {
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

public enum SpaceAnalyzeProducer {

    /// Default location for Space orbit records — sibling of
    /// `chip/noc/f1f2/records/`, `component/geometry/`, `matter/parity/`,
    /// `sscb/transient/`.
    public static let orbitRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("space/orbit", isDirectory: true)

    /// TLE-age threshold (days) below which the propagation is INSIDE
    /// SGP4's nominal validity window — eligible for
    /// GATE_CLOSED_MEASURED. Above this the gate is GATE_OPEN.
    /// Conservative pick: 7 days (Vallado 2006: ~3 km drift / week).
    public static let tleFreshnessThresholdDays: Double = 7.0

    /// Default candidate paths for `python3` — prefer brew Python so
    /// pip-installed Skyfield is on sys.path.
    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    /// Locate the python3 binary — nil if not found (honest gap path).
    public static func locatePython() -> String? {
        let fm = FileManager.default
        for c in pythonCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // PATH fallback via `which`.
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
    /// from `cockpit/scripts/space_skyfield.py` (born in worktree
    /// pre-D61; lifted to hexa-lang stdlib at consolidation).
    public static func locateScript() -> String? {
        let path = NSString(
            string: "~/core/hexa-lang/stdlib/space/skyfield_sgp4.py"
        ).expandingTildeInPath
        return FileManager.default.fileExists(atPath: path) ? path : nil
    }

    /// Run `python3 space_skyfield.py <orbitRecordsRoot>/<stamp>/` and
    /// persist one `SpaceRecord` per call. Each call writes into its
    /// own timestamped subdirectory so consecutive runs do not stomp
    /// each other's track artifacts.
    public static func runAnalyze() -> SpaceAnalyzeResult {
        var lines: [String] = []

        guard let py = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장 — Skyfield 가 brew "
                + "Python site-packages 에 설치되어 있습니다). space + "
                + "analyze 는 Skyfield SGP4 propagation 을 producer 로 "
                + "사용합니다 (g3 — silent success 금지).")
            return SpaceAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — space_skyfield.py 를 찾지 못했습니다 "
                + "(cockpit/scripts/). 절차 fallback 없음 — 본 셀은 "
                + "producer 필수 (g3).")
            return SpaceAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/space/orbit/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = orbitRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ space orbit dir mkdir 실패: \(error.localizedDescription)")
            return SpaceAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the script. Skyfield + sgp4 resolution is
        // the script's job (importlib); the Swift side just resolved
        // python3 itself.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // SPACE_SKYFIELD_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 space_skyfield.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return SpaceAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the SPACE_SKYFIELD_RESULT <json> line.
        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the headline artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python3 = \(py)")
        lines.append("python3 space_skyfield.py — exit \(exitCode), "
            + "sats=\(summary.satellitesCount ?? 0)")
        if let sv = summary.skyfieldVersion, let gv = summary.sgp4Version {
            lines.append("skyfield = \(sv) · sgp4 = \(gv)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["meta", "tle"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — space producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return SpaceAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Aggregates + per-sat data come from
        // re-reading the meta.json (the Python side is the SSOT — Swift
        // just witnesses + types).
        let metaName = verified["meta"] ?? "space_orbit.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(SpaceProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) — record 미작성 (g3).")
            return SpaceAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "space_orbit_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let skyV = meta.skyfieldVersion ?? "unknown"
        let sgpV = meta.sgp4Version ?? "unknown"
        let producer = "skyfield@\(skyV)+sgp4@\(sgpV)"

        // Gate decision — TLE age is the g3 driver. Inside 7 days the
        // propagation is within SGP4's nominal validity window; outside
        // it the prediction degrades. absorbed stays false either way.
        let gate: F1F2Record.MeasurementGate
        let ageNote: String
        if meta.worstTleAgeDays <= tleFreshnessThresholdDays {
            gate = .closedMeasured
            ageNote = String(format:
                "worst_tle_age = %.2f d ≤ %.1f d threshold → "
                + "GATE_CLOSED_MEASURED (SGP4 nominal validity window). "
                + "g3 caveat = TLE-age, NOT absorption — Skyfield + SGP4 "
                + "는 NORAD reference 대비 bench-validated.",
                meta.worstTleAgeDays, tleFreshnessThresholdDays)
        } else {
            gate = .open
            ageNote = String(format:
                "worst_tle_age = %.2f d > %.1f d threshold → GATE_OPEN "
                + "(drifted TLE, ~1 km/d position drift 누적; SGP4 의 "
                + "nominal validity window 초과). honest gap 으로 surface, "
                + "buggy 가 아님.",
                meta.worstTleAgeDays, tleFreshnessThresholdDays)
        }

        let caveats: [String] = [
            ageNote,
            "Skyfield 는 EXTERNAL Python 라이브러리 (pip install) — "
            + "hexa-lang / hexa-arch 로 absorbed 아님 (D17 — demiurge "
            + "consumer, upstream tool owner). absorbed=true 절대 금지 "
            + "(GATE_CLOSED 상태에서도 마찬가지 — 측정 게이트 닫힘 ≠ "
            + "도구 흡수).",
            "관측자 = Seoul (37.5665°N, 126.978°E, 38 m) 고정 — "
            + "prototype 단계에서 reproducibility 우선. 사용자 위치/시간 "
            + "configurable 화는 후속 phase.",
            "TLE 는 inline-bundled (Celestrak 2026-05-01 snapshot) — "
            + "live fetch 가 아니라 deterministic input. 매번 다른 결과 "
            + "방지 = typed-record contract 준수 (g3 — silent success "
            + "방지).",
            "UL / range-safety / 발사허가 등 별도 게이트 — Skyfield 의 "
            + "propagation ≠ 임무 인증 (domains/space.md §1). 본 record "
            + "는 trajectory analyze 까지가 scope.",
        ]

        let record = SpaceRecord(
            interface: "demiurge:space:orbit-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            tleSha256_16: meta.tleSha256_16,
            tleCount: meta.tleCount,
            skyfieldVersion: skyV,
            sgp4Version: sgpV,
            observer: meta.observer,
            window: meta.window,
            runAtUtc: meta.runAtUtc,
            worstTleAgeDays: meta.worstTleAgeDays,
            satellites: meta.satellites,
            artifacts: verified,
            provenance: SpaceProvenance(
                absorbed: false,
                producer: producer,
                measurementGate: gate,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ space record JSON 쓰기 실패: \(error.localizedDescription)")
            return SpaceAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output line for the user.
        lines.append("---")
        lines.append("📸 space orbit record → exports/space/orbit/"
            + "\(stamp)/\(recordId).json")
        for sat in meta.satellites {
            let a = sat.aggregates
            let maxAlt = a.maxAltDeg.map { String(format: "%.1f°", $0) } ?? "—"
            lines.append(String(format:
                "   %@ (NORAD %d) · visible %.1f%% · max_alt %@ · "
                + "longest_pass %.1f min",
                sat.name, sat.noradId,
                a.visibilityRatio * 100.0, maxAlt, a.maxPassMinutes))
        }
        switch gate {
        case .closedMeasured:
            lines.append(String(format:
                "   ✅ GATE_CLOSED_MEASURED · absorbed=false · worst TLE age "
                + "%.2f d (≤ %.1f d) — SGP4 nominal validity 안. g3 caveat "
                + "는 TLE-age 만, absorbed 는 영원히 false.",
                meta.worstTleAgeDays, tleFreshnessThresholdDays))
        case .open:
            lines.append(String(format:
                "   ⏳ GATE_OPEN · absorbed=false · worst TLE age %.2f d "
                + "(> %.1f d) — TLE 가 drift, SGP4 nominal window 밖. "
                + "honest gap 으로 surface (g3).",
                meta.worstTleAgeDays, tleFreshnessThresholdDays))
        default:
            lines.append("   ⏳ gate 결정 미해석 — record 의 provenance 참조.")
        }

        return SpaceAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `cockpit/scripts/space_skyfield.py::main`'s meta dict.
    private struct SpaceProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let tleSha256_16: String
        let tleCount: Int
        let skyfieldVersion: String?
        let sgp4Version: String?
        let observer: SpaceObserver
        let window: SpaceWindow
        let runAtUtc: String
        let worstTleAgeDays: Double
        let satellites: [SpaceSatellite]

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case tleSha256_16 = "tle_sha256_16"
            case tleCount = "tle_count"
            case skyfieldVersion = "skyfield_version"
            case sgp4Version = "sgp4_version"
            case observer
            case window
            case runAtUtc = "run_at_utc"
            case worstTleAgeDays = "worst_tle_age_days"
            case satellites
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var skyfieldVersion: String? = nil
        var sgp4Version: String? = nil
        var satellitesCount: Int? = nil
        var worstTleAgeDays: Double? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `SPACE_SKYFIELD_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any
    /// other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "SPACE_SKYFIELD_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["skyfield_version"] as? String { out.skyfieldVersion = s }
            if let s = obj["sgp4_version"] as? String { out.sgp4Version = s }
            if let n = obj["satellites_count"] as? Int { out.satellitesCount = n }
            if let d = obj["worst_tle_age_days"] as? Double { out.worstTleAgeDays = d }
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
