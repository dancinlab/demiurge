// ScopeAnalyzeProducer — θ-2 engine tool for `scope + analyze` (κ-35 / D67).
//
// Third cohort domain (after sscb D55 + aura κ-35) wired to a real
// measuring engine tool. Wraps POPPY (`pip install poppy`, BSD, STScI)
// — the established physical-optics propagation library used to
// flight-validate JWST — to compute deterministic PSF + Strehl +
// encircled-energy figures for a parametric segmented primary.
//
// D61 SSOT relocation (effective for NEW producers): the Python script
// SSOT is `~/core/hexa-lang/stdlib/scope/scope_poppy.py` (sibling repo).
// `cockpit/scripts/*.py` is forbidden for new producers.
//
// Architecture (mirrors AuraAnalyzeProducer + SSCBProducer):
//   1. locate `python3.12` (or any python with POPPY installed)
//   2. locate `~/core/hexa-lang/stdlib/scope/scope_poppy.py` (D61)
//   3. spawn `python scope_poppy.py <output_dir> 18` — 18 segments
//      = JWST reference per `domains/scope.md` §6 shelf option
//   4. parse `SCOPE_POPPY_RESULT <json>` on stderr, verify
//      `.fits` + `.meta.json` exist on disk
//   5. emit one typed `ScopeRecord` under `exports/scope/psf/<stamp>/`
//
// HONEST (g3 — non-negotiable):
//   • producer = "poppy@<version>" — pins the library, NOT a mirror.
//     The aperture is parametric. measurement_gate = GATE_OPEN +
//     absorbed = false ALWAYS.

import Foundation

public struct ScopeAnalyzeResult: Sendable {
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

public enum ScopeAnalyzeProducer {

    /// Default location for scope PSF records.
    public static let psfRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("scope/psf", isDirectory: true)

    /// JWST reference shelf option per `domains/scope.md` §6
    /// ("분할 수 = 7 / 18 / 36"). Default 18.
    public static let defaultSegments = 18

    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3.12",
        "/opt/homebrew/bin/python3.13",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    public static let scriptPath: String =
        NSString(string: "~/core/hexa-lang/stdlib/scope/scope_poppy.py")
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

    public static func runAnalyze(segments: Int = defaultSegments) -> ScopeAnalyzeResult {
        var lines: [String] = []

        guard let python = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(brew install python@3.12 권장). scope + analyze 는 POPPY "
                + "(physical optics propagation, STScI) 를 producer 로 사용합니다 "
                + "(g3 — silent success 금지).")
            return ScopeAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — scope_poppy.py 를 찾지 못했습니다 "
                + "(D61 SSOT: ~/core/hexa-lang/stdlib/scope/scope_poppy.py). "
                + "sibling repo hexa-lang 의 stdlib/scope/ 에 producer 가 "
                + "존재해야 합니다 (g3).")
            return ScopeAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = psfRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ scope psf dir mkdir 실패: \(error.localizedDescription)")
            return ScopeAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: python)
        proc.arguments = [script, runDir.path, String(segments)]
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
            lines.append("⏳ engine tool gap — python scope_poppy.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return ScopeAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python = \(python)")
        lines.append("scope_poppy.py — exit \(exitCode)")
        if let v = summary.poppyVersion {
            lines.append("POPPY version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["fits", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — scope producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return ScopeAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let metaName = verified["meta"] ?? "scope_psf_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(ScopeProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) — record 미작성 (g3).")
            return ScopeAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "scope_psf_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let poppyVer = summary.poppyVersion ?? meta.poppyVersion ?? "unknown"
        let caveats: [String] = [
            "POPPY 의 Fraunhofer/Fresnel diffraction 결과 — 숫자는 실제 "
            + "(deterministic, ndarray IEEE-754) 이지만 aperture 는 "
            + "parametric (POPPY MultiHexagonAperture, n-segment 헥스). "
            + "polished mirror 의 wavefront map 흡수 아님 (g3).",
            "JWST 1.32 m flat-to-flat 헥스 세그먼트 (domains/scope.md §6 "
            + "shelf 옵션) — JWST 본체와 1:1 비교 0 (no NIRCam commissioning "
            + "data, no Zernike polynomial fit, no segment-co-phasing model).",
            "measurement_gate = GATE_OPEN 영구. closedMeasured 로 전환하려면 "
            + "(a) JWST commissioning hash 로 PSF/Strehl 재현 ±X%, 또는 "
            + "(b) 실제 polished primary 의 wavefront map 흡수 필요.",
            "absorbed=true 절대 금지 — Code V / Zemax 의 tolerancing gap "
            + "(domains/scope.md §4) 은 별도 (POPPY 는 PSF, ray-trace "
            + "tolerancing 아님). POPPY 흡수는 PSF/Strehl 한 셀에 한정.",
        ]

        let aperture = ScopeAperture(
            segmentsRequested: meta.aperture.segmentsRequested,
            rings: meta.aperture.rings,
            segmentFlatToFlatM: meta.aperture.segmentFlatToFlatM,
            effectiveDiameterM: meta.aperture.effectiveDiameterM,
            effectiveAreaM2: meta.aperture.effectiveAreaM2)
        let propagation = ScopePropagation(
            wavelengthM: meta.propagation.wavelengthM,
            fovArcsec: meta.propagation.fovArcsec,
            pixscaleArcsec: meta.propagation.pixscaleArcsec,
            oversample: meta.propagation.oversample)
        let measurements = ScopeMeasurements(
            peakIntensity: meta.measurements.peakIntensity,
            totalIntensity: meta.measurements.totalIntensity,
            strehlProxy: meta.measurements.strehlProxy,
            fwhmDiffractionLimitArcsec: meta.measurements.fwhmDiffractionLimitArcsec,
            fwhmMeasuredArcsec: meta.measurements.fwhmMeasuredArcsec,
            pixscaleArcsec: meta.measurements.pixscaleArcsec,
            encircledEnergy: meta.measurements.encircledEnergy,
            imageShape: meta.measurements.imageShape)

        let record = ScopeRecord(
            interface: "demiurge:scope:psf-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            psfSha256_16: meta.psfSha256_16,
            poppyVersion: poppyVer,
            aperture: aperture,
            propagation: propagation,
            measurements: measurements,
            artifacts: verified,
            provenance: ScopeProvenance(
                absorbed: false,
                producer: "poppy@\(poppyVer)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ scope record JSON 쓰기 실패: \(error.localizedDescription)")
            return ScopeAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let m = meta.measurements
        lines.append("---")
        lines.append("📸 scope psf record → exports/scope/psf/\(stamp)/\(recordId).json")
        if let fwhm = m.fwhmMeasuredArcsec, let strehl = m.strehlProxy {
            lines.append(String(format: "   diameter = %.2f m · "
                + "fwhm = %.4f arcsec · strehl ≈ %.3f · producer = poppy@%@",
                meta.aperture.effectiveDiameterM, fwhm, strehl, poppyVer))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — parametric "
            + "aperture (JWST 18-segment 흡수 아님). POPPY 흡수는 PSF/"
            + "Strehl 한 셀에 한정 (g3, scope_caveats 4종 참조).")

        return ScopeAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    private struct ScopeProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let psfSha256_16: String
        let poppyVersion: String?
        let aperture: ApertureDTO
        let propagation: PropagationDTO
        let measurements: MeasurementsDTO

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case psfSha256_16 = "psf_sha256_16"
            case poppyVersion = "poppy_version"
            case aperture
            case propagation
            case measurements
        }

        struct ApertureDTO: Decodable {
            let segmentsRequested: Int
            let rings: Int
            let segmentFlatToFlatM: Double
            let effectiveDiameterM: Double
            let effectiveAreaM2: Double

            enum CodingKeys: String, CodingKey {
                case segmentsRequested = "segments_requested"
                case rings
                case segmentFlatToFlatM = "segment_flat_to_flat_m"
                case effectiveDiameterM = "effective_diameter_m"
                case effectiveAreaM2 = "effective_area_m2"
            }
        }

        struct PropagationDTO: Decodable {
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

        struct MeasurementsDTO: Decodable {
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
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var poppyVersion: String? = nil
        var artifacts: [String: String] = [:]
    }

    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "SCOPE_POPPY_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["poppy_version"] as? String { out.poppyVersion = s }
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
