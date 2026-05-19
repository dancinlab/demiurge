// ScopeVerifyProducer — θ-2 engine tool for `scope + verify`
// (cohort round, no standalone PLAN κ / D-block — absorption empty-cell
// fill 2026-05-20, per inbox/notes/absorption-empty-cells-research-
// 2026-05-20.md §3 ROI rank 3).
//
// THIRD scope-domain measurable producer (after scope+analyze and
// scope+synthesize). Wraps POPPY (+ optional WebbPSF + synphot) via
// the ①a wave_optics kernel to run 5 signoff checks on the SAME
// parametric segmented primary: reproducibility, diffraction-limit
// closure (1.22 λ/D), encircled-energy monotonicity, WebbPSF
// NIRCam cross-check (skipped if not installed), synphot photometric
// round-trip (skipped if not installed).
//
// D61 SSOT: the Python script SSOT is
// `~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py` (sibling repo).
//
// D72 ①b adapter: all wave-optics math is delegated to the ①a kernel.
//
// Architecture (mirrors ComponentVerifyProducer + ScopeAnalyzeProducer):
//   1. locate `python3.12` (or any python with poppy installed)
//   2. locate `~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py`
//   3. spawn `python poppy_psf_verify.py <output_dir>`
//   4. parse `SCOPE_VERIFY_RESULT <json>` on stderr, verify
//      `.meta.json` + `.checks.csv` exist on disk
//   5. emit one typed `ScopeVerifyRecord` under
//      `exports/scope/verify/<stamp>/`
//
// HONEST (g3 — non-negotiable):
//   • producer = "poppy@<v>" (with optional webbpsf@<v> / synphot@<v>).
//     The verdict is reproducibility + analytic invariants on the SAME
//     parametric aperture, NOT a flight-data absorption.
//     measurement_gate = GATE_OPEN + absorbed = false ALWAYS,
//     regardless of how many checks GREEN.

import Foundation

public struct ScopeVerifyResult: Sendable {
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

public enum ScopeVerifyProducer {

    /// Default location for scope verify records — sibling of
    /// `exports/scope/psf/` (analyze) and `exports/scope/synth/`.
    public static let verifyRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("scope/verify", isDirectory: true)

    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3.12",
        "/opt/homebrew/bin/python3.13",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    public static let scriptPath: String =
        NSString(string: "~/core/hexa-lang/stdlib/scope/poppy_psf_verify.py")
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

    public static func runVerify() -> ScopeVerifyResult {
        var lines: [String] = []

        guard let python = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(brew install python@3.12 권장). scope + verify 는 "
                + "POPPY (+ optional WebbPSF + synphot) 를 producer 로 "
                + "사용합니다 (g3 — silent success 금지).")
            return ScopeVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — poppy_psf_verify.py 를 찾지 "
                + "못했습니다 (D61 SSOT: ~/core/hexa-lang/stdlib/scope/"
                + "poppy_psf_verify.py). sibling repo hexa-lang 의 stdlib/"
                + "scope/ 에 producer 가 존재해야 합니다 (g3).")
            return ScopeVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = verifyRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ scope verify dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return ScopeVerifyResult(ok: false, lines: lines, newRecordID: nil)
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
            lines.append("⏳ engine tool gap — python poppy_psf_verify.py "
                + "실행 실패: \(error.localizedDescription) (g3).")
            return ScopeVerifyResult(ok: false, lines: lines, newRecordID: nil)
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

        lines.append("python = \(python)")
        lines.append("poppy_psf_verify.py — exit \(exitCode)")
        if let p = summary.poppyVersion {
            let wp = summary.webbpsfVersion ?? "?"
            let sp = summary.synphotVersion ?? "?"
            lines.append("POPPY \(p) · WebbPSF \(wp) · synphot \(sp)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        // Required artifacts: meta + checks_csv. FITS is opportunistic.
        let needed = ["meta", "checks_csv"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        // ok = the producer reported all_required_passed = true AND
        // artifacts landed. Exit code != 0 is also fine when checks
        // intentionally FAIL — but for the record to be written, we
        // demand artifacts present + valid meta.json. The PASS/FAIL
        // verdict is carried by the tally inside the record.
        let canEmit = allPresent
        if !canEmit {
            lines.append("⏳ honest gap — scope verify producer "
                + "ok=\(summary.allRequiredPassed), exit=\(exitCode), "
                + "present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 8)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return ScopeVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let metaName = verified["meta"] ?? "scope_verify_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                ScopeVerifyProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return ScopeVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "scope_verify_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let ppv = summary.poppyVersion ?? meta.poppyVersion ?? "unknown"
        let wpv = summary.webbpsfVersion ?? meta.webbpsfVersion ?? "not-installed"
        let spv = summary.synphotVersion ?? meta.synphotVersion ?? "not-installed"
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "verdict 는 reproducibility + analytic invariants on the "
            + "SAME parametric aperture (POPPY MultiHexagonAperture via "
            + "①a wave_optics kernel), NOT a flight-data absorption. "
            + "checks 모두 GREEN 이어도 measurement_gate = GATE_OPEN, "
            + "absorbed = false 영구 (g3).",
            "diffraction-limit check 은 real (1.22 λ/D Airy formula) "
            + "이지만 *parametric* aperture 에 대한 것이지 JWST "
            + "commissioning PSF 에 대한 것이 아님. ±20% 허용 밴드는 "
            + "POPPY tutorial 의 multi-segment aperture 가이드라인이지 "
            + "ESA/STScI signoff threshold 아님.",
            "WebbPSF cross-check 는 loose (±50% FWHM) — WebbPSF 모델은 "
            + "OPD, secondary-mirror obscuration, struts, segment-tilt "
            + "errors 를 포함하지만 bare MultiHexagonAperture 는 그렇지 "
            + "않음. strict equality 는 정직하지 못함 (g3). 또한 "
            + "NIRCam 의 minimum filter 는 F480M (≈ 4.8 μm) — 본 "
            + "verify producer 의 550 nm 와 다른 band 이므로 비교는 "
            + "order-of-magnitude 수준만 honest.",
            "synphot 의 photometric round-trip 은 flat 1.0 FLAM source × "
            + "100-nm top-hat @ 550 nm — synthetic source 의 sanity "
            + "(finite + positive count) 만 검증. real flux calibration "
            + "이 아니라 ASCL 1811.001 SSOT 의 round-trip 정상 동작 "
            + "확인. 표준성 (Vega / AB / fluxd) 흡수는 별도.",
            "citations (g3 — record 안에 보존): POPPY = https://github.com/"
            + "spacetelescope/poppy (STScI, BSD-3); WebbPSF = "
            + "https://github.com/spacetelescope/webbpsf (STScI, BSD-3); "
            + "synphot = ASCL 1811.001 (https://ascl.net/1811.001); "
            + "OpenMDAO = https://github.com/OpenMDAO/OpenMDAO (NASA OSS, "
            + "Apache-2.0).",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 — "
            + "흡수에 해당하려면 (a) WebbPSF parity within ±X% on a JWST "
            + "NIRCam commissioning hash, AND (b) hexa-native FFT "
            + "re-propagation matching POPPY to IEEE-754. 둘 다 이번 "
            + "phase 에서는 미달.",
        ]

        let aperture = ScopeVerifyAperture(
            segmentsRequested: meta.aperture.segmentsRequested,
            rings: meta.aperture.rings,
            segmentFlatToFlatM: meta.aperture.segmentFlatToFlatM,
            effectiveDiameterM: meta.aperture.effectiveDiameterM)
        let propagation = ScopeVerifyPropagation(
            wavelengthM: meta.propagation.wavelengthM,
            fovArcsec: meta.propagation.fovArcsec,
            pixscaleArcsec: meta.propagation.pixscaleArcsec,
            oversample: meta.propagation.oversample)
        let measurements = ScopeVerifyMeasurements(
            peakIntensity: meta.measurements.peakIntensity,
            totalIntensity: meta.measurements.totalIntensity,
            strehlProxy: meta.measurements.strehlProxy,
            fwhmDiffractionLimitArcsec: meta.measurements.fwhmDiffractionLimitArcsec,
            fwhmMeasuredArcsec: meta.measurements.fwhmMeasuredArcsec,
            pixscaleArcsec: meta.measurements.pixscaleArcsec,
            encircledEnergy: meta.measurements.encircledEnergy,
            imageShape: meta.measurements.imageShape)
        let tally = ScopeVerifyTally(
            nRequired: meta.tally.nRequired,
            nPassed: meta.tally.nPassed,
            nSkipped: meta.tally.nSkipped,
            allRequiredPassed: meta.tally.allRequiredPassed)
        let checks: [ScopeVerifyCheck] = meta.checks.map { c in
            ScopeVerifyCheck(
                name: c.name,
                passed: c.passed,
                skipped: c.skipped ?? false,
                note: c.note,
                relErr: c.relErr,
                tolerance: c.tolerance)
        }

        // Producer pin string — surface WebbPSF / synphot presence.
        let producerStr: String = {
            var parts = ["poppy@\(ppv)"]
            if wpv != "not-installed" { parts.append("webbpsf@\(wpv)") }
            if spv != "not-installed" { parts.append("synphot@\(spv)") }
            return parts.joined(separator: " + ")
        }()

        let record = ScopeVerifyRecord(
            interface: "demiurge:scope:poppy-psf-verify-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            psfSha256_16: meta.psfSha256_16,
            poppyVersion: ppv,
            webbpsfVersion: wpv,
            synphotVersion: spv,
            pythonVersion: pyv,
            aperture: aperture,
            propagation: propagation,
            measurements: measurements,
            tally: tally,
            checks: checks,
            artifacts: verified,
            provenance: ScopeVerifyProvenance(
                absorbed: false,
                producer: producerStr,
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ scope verify record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return ScopeVerifyResult(ok: false, lines: lines, newRecordID: nil)
        }

        let ok = tally.allRequiredPassed
        lines.append("---")
        lines.append("📸 scope verify record → exports/scope/verify/"
            + "\(stamp)/\(recordId).json")
        lines.append("   checks \(tally.nPassed)/\(tally.nRequired) "
            + "passed (skipped \(tally.nSkipped)) · "
            + "producer = \(producerStr)")
        if ok {
            lines.append("   ✅ all required checks GREEN — but "
                + "measurement_gate = GATE_OPEN 영구, absorbed = false "
                + "영구 (parametric aperture, NOT flight data). "
                + "scope_caveats 6종 참조.")
        } else {
            lines.append("   ⏳ honest gap — \(tally.nRequired - tally.nPassed) "
                + "required check(s) failed. record 는 emit 되지만 "
                + "engineToolSucceeded=false (g3).")
        }

        return ScopeVerifyResult(ok: ok, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    private struct ScopeVerifyProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let psfSha256_16: String
        let poppyVersion: String?
        let webbpsfVersion: String?
        let synphotVersion: String?
        let pythonVersion: String?
        let aperture: ApertureRaw
        let propagation: PropagationRaw
        let measurements: MeasurementsRaw
        let tally: TallyRaw
        let checks: [CheckRaw]

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case psfSha256_16 = "psf_sha256_16"
            case poppyVersion = "poppy_version"
            case webbpsfVersion = "webbpsf_version"
            case synphotVersion = "synphot_version"
            case pythonVersion = "python_version"
            case aperture
            case propagation
            case measurements
            case tally
            case checks
        }

        struct ApertureRaw: Decodable {
            let segmentsRequested: Int
            let rings: Int
            let segmentFlatToFlatM: Double
            let effectiveDiameterM: Double

            enum CodingKeys: String, CodingKey {
                case segmentsRequested = "segments_requested"
                case rings
                case segmentFlatToFlatM = "segment_flat_to_flat_m"
                case effectiveDiameterM = "effective_diameter_m"
            }
        }

        struct PropagationRaw: Decodable {
            let wavelengthM: Double
            let fovArcsec: Double
            let pixscaleArcsec: Double
            let oversample: Int

            enum CodingKeys: String, CodingKey {
                case wavelengthM = "wavelength_m"
                case fovArcsec = "fov_arcsec"
                case pixscaleArcsec = "pixscale_arcsec"
                case oversample
            }
        }

        struct MeasurementsRaw: Decodable {
            let peakIntensity: Double
            let totalIntensity: Double
            let strehlProxy: Double?
            let fwhmDiffractionLimitArcsec: Double
            let fwhmMeasuredArcsec: Double?
            let pixscaleArcsec: Double
            let encircledEnergy: [String: Double?]
            let imageShape: [Int]

            enum CodingKeys: String, CodingKey {
                case peakIntensity = "peak_intensity"
                case totalIntensity = "total_intensity"
                case strehlProxy = "strehl_proxy"
                case fwhmDiffractionLimitArcsec = "fwhm_diffraction_limit_arcsec"
                case fwhmMeasuredArcsec = "fwhm_measured_arcsec"
                case pixscaleArcsec = "pixscale_arcsec"
                case encircledEnergy = "encircled_energy"
                case imageShape = "image_shape"
            }
        }

        struct TallyRaw: Decodable {
            let nRequired: Int
            let nPassed: Int
            let nSkipped: Int
            let allRequiredPassed: Bool

            enum CodingKeys: String, CodingKey {
                case nRequired = "n_required"
                case nPassed = "n_passed"
                case nSkipped = "n_skipped"
                case allRequiredPassed = "all_required_passed"
            }
        }

        /// Per-check JSON shape varies (rel_err, ee_r1, sha_a, etc.) —
        /// only `name` + `passed` are required; `skipped` / `note` /
        /// `rel_err` / `tolerance` are optional. Other fields (sha_a,
        /// ee_r2, …) are intentionally NOT decoded here — the CSV
        /// already captures them and the full meta.json is on disk.
        struct CheckRaw: Decodable {
            let name: String
            let passed: Bool
            let skipped: Bool?
            let note: String?
            let relErr: Double?
            let tolerance: Double?

            enum CodingKeys: String, CodingKey {
                case name
                case passed
                case skipped
                case note
                case relErr = "rel_err"
                case tolerance
            }
        }
    }

    private struct ParsedSummary {
        var allRequiredPassed: Bool = false
        var geometryId: String? = nil
        var poppyVersion: String? = nil
        var webbpsfVersion: String? = nil
        var synphotVersion: String? = nil
        var artifacts: [String: String] = [:]
    }

    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "SCOPE_VERIFY_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["all_required_passed"] as? Bool {
                out.allRequiredPassed = b
            }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["poppy_version"] as? String {
                out.poppyVersion = s
            }
            if let s = obj["webbpsf_version"] as? String {
                out.webbpsfVersion = s
            }
            if let s = obj["synphot_version"] as? String {
                out.synphotVersion = s
            }
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
