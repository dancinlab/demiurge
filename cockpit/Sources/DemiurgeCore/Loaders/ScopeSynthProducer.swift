// ScopeSynthProducer — θ-2 engine tool for `scope + synthesize`
// (cohort round, no standalone PLAN κ / D-block — absorption empty-cell
// fill 2026-05-20, per inbox/notes/absorption-empty-cells-research-
// 2026-05-20.md §3 ROI rank 4).
//
// SECOND scope-domain measurable producer (after scope+analyze =
// ScopeAnalyzeProducer's POPPY PSF). Wraps OpenMDAO
// (`pip install openmdao`, NASA OSS, Apache-2.0) coupled with POPPY
// (via the ①a wave_optics kernel) to size a parametric segmented
// primary mirror across 3 segment shelves (7 / 18 / 36 hexes).
//
// D61 SSOT: the Python script SSOT is
// `~/core/hexa-lang/stdlib/scope/openmdao_sizing.py` (sibling repo).
// `cockpit/scripts/*.py` is forbidden for new producers.
//
// D72 ①b adapter: all wave-optics math is delegated to the ①a kernel
// `stdlib/kernels/wave_optics/poppy_kernel.py`. OpenMDAO itself is
// adapter-local for now — promote to `kernels/mdo/` only when a 2nd
// MDO consumer appears (see `inbox/notes/openmdao-kernel-promotion-
// pickup.md`).
//
// Architecture (mirrors ComponentVerifyProducer + ScopeAnalyzeProducer):
//   1. locate `python3.12` (or any python with openmdao + poppy installed)
//   2. locate `~/core/hexa-lang/stdlib/scope/openmdao_sizing.py`
//   3. spawn `python openmdao_sizing.py <output_dir>` — script sweeps
//      3 shelves and writes meta + history CSV
//   4. parse `SCOPE_OPENMDAO_RESULT <json>` on stderr, verify
//      `.meta.json` + `.history.csv` exist on disk
//   5. emit one typed `ScopeSynthRecord` under
//      `exports/scope/synth/<stamp>/`
//
// HONEST (g3 — non-negotiable):
//   • producer = "openmdao@<v> + poppy@<v>" — pins the libraries,
//     NOT the primary. measurement_gate = GATE_OPEN + absorbed = false
//     ALWAYS.

import Foundation

public struct ScopeSynthResult: Sendable {
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

public enum ScopeSynthProducer {

    /// Default location for scope synthesize records — sibling of
    /// `exports/scope/psf/` (analyze) and the other producer roots.
    public static let synthRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("scope/synth", isDirectory: true)

    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3.12",
        "/opt/homebrew/bin/python3.13",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    public static let scriptPath: String =
        NSString(string: "~/core/hexa-lang/stdlib/scope/openmdao_sizing.py")
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

    public static func runSynthesize() -> ScopeSynthResult {
        var lines: [String] = []

        guard let python = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(brew install python@3.12 권장). scope + synthesize 는 "
                + "OpenMDAO + POPPY 를 producer 로 사용합니다 (g3 — silent "
                + "success 금지).")
            return ScopeSynthResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — openmdao_sizing.py 를 찾지 "
                + "못했습니다 (D61 SSOT: ~/core/hexa-lang/stdlib/scope/"
                + "openmdao_sizing.py). sibling repo hexa-lang 의 stdlib/"
                + "scope/ 에 producer 가 존재해야 합니다 (g3).")
            return ScopeSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = synthRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ scope synth dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return ScopeSynthResult(ok: false, lines: lines, newRecordID: nil)
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
            lines.append("⏳ engine tool gap — python openmdao_sizing.py "
                + "실행 실패: \(error.localizedDescription) (g3).")
            return ScopeSynthResult(ok: false, lines: lines, newRecordID: nil)
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
        lines.append("openmdao_sizing.py — exit \(exitCode)")
        if let v = summary.openmdaoVersion, let p = summary.poppyVersion {
            lines.append("OpenMDAO \(v) · POPPY \(p)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["meta", "history_csv"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — scope synth producer "
                + "ok=\(summary.ok), exit=\(exitCode), "
                + "present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 8)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return ScopeSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Re-read the meta.json — Python is the SSOT for the numbers.
        let metaName = verified["meta"] ?? "scope_synth_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                ScopeSynthProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return ScopeSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "scope_synth_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let omv = summary.openmdaoVersion ?? meta.openmdaoVersion ?? "unknown"
        let ppv = summary.poppyVersion ?? meta.poppyVersion ?? "unknown"
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "OpenMDAO 의 ScipyOptimizeDriver (SLSQP) IS doing real MDO "
            + "on a coupled optics×structure model (Fraunhofer/Fresnel "
            + "PSF via ①a wave_optics kernel × areal-density mass) — "
            + "converged J 는 진짜 optimum of THIS scalarisation 임. 단, "
            + "구조 모델은 areal-density placeholder (60 kg/m² + 40 kg/m² "
            + "backing + 20 kg/segment hw) 이고 FEM 기반 mass budget 이 "
            + "아니다 (g3).",
            "scalarisation weights (w_mass=0.01, w_fwhm=1.0, w_aper=0.2) "
            + "는 designer choice 이지 measured Pareto front 가 아님. "
            + "meta.json 의 `scalarisation_weights` block 을 편집해서 "
            + "재가중하는 것은 OK — 같은 record 에서 다른 verdict 를 "
            + "주장하는 건 금지 (g3).",
            "mass model 계수 (areal_primary 60 kg/m², areal_backing "
            + "40 kg/m², per_segment_hardware 20 kg) 는 open-literature "
            + "placeholder (JWST primary ≈ 23 kg/m² beryllium 보다 보수적). "
            + "흡수에 해당하려면 STEP-level primary backing structure 의 "
            + "FEM mass model (CalculiX / Elmer) 이 별도 kernel 로 들어와야.",
            "측정된 aperture 가 아니라 *parametric* MultiHexagonAperture "
            + "(POPPY ①a kernel) 임 — segment 수는 7 / 18 / 36 hex 만 "
            + "지원 (POPPY ring config). 18-segment shelf 는 JWST 와 1:1 "
            + "비교 0 (no NIRCam commissioning data, no Zernike polynomial "
            + "fit, no segment-co-phasing model).",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 — "
            + "OpenMDAO 흡수에 해당하려면 (a) FEM mass model 별도 kernel, "
            + "(b) measured-grade Pareto front vs flight reference, (c) "
            + "2nd MDO consumer 등장 시 `kernels/mdo/` 승격 — 3종 모두 "
            + "이번 phase 에서는 미달.",
        ]

        // Map producer meta into typed sub-blocks.
        let designSpace = ScopeSynthDesignSpace(
            ftfLowerM: meta.designSpace.ftfLowerM,
            ftfUpperM: meta.designSpace.ftfUpperM,
            ftfInitialM: meta.designSpace.ftfInitialM,
            segmentShelves: meta.designSpace.segmentShelves)
        let weights = ScopeSynthWeights(
            wMass: meta.scalarisationWeights.wMass,
            wFwhm: meta.scalarisationWeights.wFwhm,
            wAper: meta.scalarisationWeights.wAper)
        let massModel = ScopeSynthMassModel(
            arealPrimaryKgPerM2: meta.massModel.arealPrimaryKgPerM2,
            arealBackingKgPerM2: meta.massModel.arealBackingKgPerM2,
            perSegmentHardwareKg: meta.massModel.perSegmentHardwareKg)
        let propagation = ScopeSynthPropagation(
            wavelengthM: meta.propagation.wavelengthM,
            fovArcsec: meta.propagation.fovArcsec,
            pixscaleArcsec: meta.propagation.pixscaleArcsec,
            oversample: meta.propagation.oversample)

        let shelves: [ScopeSynthShelf] = meta.shelves.map { s in
            let conv = s.converged.map { c in
                ScopeSynthConverged(
                    ftfM: c.ftfM,
                    segments: c.segments,
                    rings: c.rings,
                    effectiveDiameterM: c.effectiveDiameterM,
                    effectiveAreaM2: c.effectiveAreaM2,
                    fwhmArcsec: c.fwhmArcsec,
                    strehlProxy: c.strehlProxy,
                    psfSha256_16: c.psfSha256_16,
                    massKg: c.massKg,
                    objectiveJ: c.objectiveJ)
            }
            return ScopeSynthShelf(
                segments: s.segments,
                ok: s.ok,
                nIter: s.nIter,
                converged: conv,
                error: s.error)
        }
        let wc = meta.winner.converged
        let winner = ScopeSynthWinner(
            segments: meta.winner.segments,
            nIter: meta.winner.nIter,
            converged: ScopeSynthConverged(
                ftfM: wc.ftfM,
                segments: wc.segments,
                rings: wc.rings,
                effectiveDiameterM: wc.effectiveDiameterM,
                effectiveAreaM2: wc.effectiveAreaM2,
                fwhmArcsec: wc.fwhmArcsec,
                strehlProxy: wc.strehlProxy,
                psfSha256_16: wc.psfSha256_16,
                massKg: wc.massKg,
                objectiveJ: wc.objectiveJ))

        let record = ScopeSynthRecord(
            interface: "demiurge:scope:openmdao-synth-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            openmdaoVersion: omv,
            poppyVersion: ppv,
            pythonVersion: pyv,
            designSpace: designSpace,
            scalarisationWeights: weights,
            massModel: massModel,
            propagation: propagation,
            shelves: shelves,
            winner: winner,
            artifacts: verified,
            provenance: ScopeSynthProvenance(
                absorbed: false,
                producer: "openmdao@\(omv) + poppy@\(ppv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ scope synth record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return ScopeSynthResult(ok: false, lines: lines, newRecordID: nil)
        }

        lines.append("---")
        lines.append("📸 scope synth record → exports/scope/synth/"
            + "\(stamp)/\(recordId).json")
        lines.append(String(format:
            "   winner shelf = %d segments · ftf = %.3f m · diameter = "
            + "%.2f m · fwhm = %.4f arcsec · mass = %.1f kg · J = %.4f",
            winner.segments, winner.converged.ftfM,
            winner.converged.effectiveDiameterM,
            winner.converged.fwhmArcsec,
            winner.converged.massKg,
            winner.converged.objectiveJ))
        lines.append("   producer = openmdao@\(omv) + poppy@\(ppv)")
        lines.append("   ⏳ GATE_OPEN · absorbed=false — parametric "
            + "aperture + placeholder mass model + designer-chosen "
            + "scalarisation weights (g3, scope_caveats 5종 참조).")

        return ScopeSynthResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    private struct ScopeSynthProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let openmdaoVersion: String?
        let poppyVersion: String?
        let pythonVersion: String?
        let designSpace: DesignSpaceRaw
        let scalarisationWeights: WeightsRaw
        let massModel: MassModelRaw
        let propagation: PropagationRaw
        let shelves: [ShelfRaw]
        let winner: WinnerRaw

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case openmdaoVersion = "openmdao_version"
            case poppyVersion = "poppy_version"
            case pythonVersion = "python_version"
            case designSpace = "design_space"
            case scalarisationWeights = "scalarisation_weights"
            case massModel = "mass_model"
            case propagation
            case shelves
            case winner
        }

        struct DesignSpaceRaw: Decodable {
            let ftfLowerM: Double
            let ftfUpperM: Double
            let ftfInitialM: Double
            let segmentShelves: [Int]

            enum CodingKeys: String, CodingKey {
                case ftfLowerM = "ftf_lower_m"
                case ftfUpperM = "ftf_upper_m"
                case ftfInitialM = "ftf_initial_m"
                case segmentShelves = "segment_shelves"
            }
        }

        struct WeightsRaw: Decodable {
            let wMass: Double
            let wFwhm: Double
            let wAper: Double

            enum CodingKeys: String, CodingKey {
                case wMass = "w_mass"
                case wFwhm = "w_fwhm"
                case wAper = "w_aper"
            }
        }

        struct MassModelRaw: Decodable {
            let arealPrimaryKgPerM2: Double
            let arealBackingKgPerM2: Double
            let perSegmentHardwareKg: Double

            enum CodingKeys: String, CodingKey {
                case arealPrimaryKgPerM2 = "areal_primary_kg_per_m2"
                case arealBackingKgPerM2 = "areal_backing_kg_per_m2"
                case perSegmentHardwareKg = "per_segment_hardware_kg"
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

        struct ConvergedRaw: Decodable {
            let ftfM: Double
            let segments: Int
            let rings: Int
            let effectiveDiameterM: Double
            let effectiveAreaM2: Double
            let fwhmArcsec: Double
            let strehlProxy: Double?
            let psfSha256_16: String
            let massKg: Double
            let objectiveJ: Double

            enum CodingKeys: String, CodingKey {
                case ftfM = "ftf_m"
                case segments
                case rings
                case effectiveDiameterM = "effective_diameter_m"
                case effectiveAreaM2 = "effective_area_m2"
                case fwhmArcsec = "fwhm_arcsec"
                case strehlProxy = "strehl_proxy"
                case psfSha256_16 = "psf_sha256_16"
                case massKg = "mass_kg"
                case objectiveJ = "objective_j"
            }
        }

        struct ShelfRaw: Decodable {
            let segments: Int
            let ok: Bool
            let nIter: Int?
            let converged: ConvergedRaw?
            let error: String?

            enum CodingKeys: String, CodingKey {
                case segments
                case ok
                case nIter = "n_iter"
                case converged
                case error
            }
        }

        struct WinnerRaw: Decodable {
            let segments: Int
            let nIter: Int
            let converged: ConvergedRaw

            enum CodingKeys: String, CodingKey {
                case segments
                case nIter = "n_iter"
                case converged
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var openmdaoVersion: String? = nil
        var poppyVersion: String? = nil
        var artifacts: [String: String] = [:]
    }

    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "SCOPE_OPENMDAO_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["openmdao_version"] as? String {
                out.openmdaoVersion = s
            }
            if let s = obj["poppy_version"] as? String {
                out.poppyVersion = s
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
