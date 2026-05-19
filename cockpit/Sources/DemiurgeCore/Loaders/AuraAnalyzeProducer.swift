// AuraAnalyzeProducer — θ-2 engine tool for `aura + analyze`
// (cohort round, no standalone PLAN κ / D-block — post-merge reconstructed).
//
// Second cohort domain (after sscb κ-34 / D55) wired to a real measuring
// engine tool. Wraps MNE-Python (`pip install mne`, BSD, stsci) — the
// established EEG signal-processing library — to compute deterministic
// band-power + mains-rejection figures for a *synthesized* EEG epoch.
//
// D61 SSOT relocation (effective for NEW producers): the Python script
// SSOT is `~/core/hexa-lang/stdlib/aura/aura_mne.py` (sibling repo —
// hexa-lang owns the producers; demiurge witnesses + types the records).
// `cockpit/scripts/*.py` is forbidden for new producers; sscb +
// component predate the rule and stay in place until a follow-on
// migration sweep (κ-3X pickup).
//
// Architecture (mirrors SSCBProducer + MatterAnalyzer):
//   1. locate `python3.12` (or any python with MNE installed — falls
//      back through brew → /usr/bin → PATH)
//   2. locate `~/core/hexa-lang/stdlib/aura/aura_mne.py` (sibling repo
//      SSOT — D61)
//   3. spawn `python aura_mne.py <output_dir>` — the Python writes the
//      `.fif` + `.meta.json` and prints `AURA_MNE_RESULT <json>` on
//      stderr
//   4. parse the summary JSON, verify both artifacts exist on disk
//      (defence-in-depth — @F f6 evidence over assertion)
//   5. emit one typed `AuraRecord` under `exports/aura/eeg/<stamp>/`
//
// HONEST (g3 — non-negotiable):
//   • producer = "mne@<version>" — pins the library, NOT a subject.
//     The signal is synthesized (fixed RNG seed). measurement_gate =
//     GATE_OPEN and absorbed = false ALWAYS.
//   • To flip closedMeasured we'd need (a) a real subject + IRB or
//     (b) a public dataset (PhysioNet) pinned by commit hash with a
//     bench-validated spectrum check — both are later phases.
//   • If python / mne / the script is missing OR fails, returns
//     ok=false and writes no record. Silent success is forbidden.

import Foundation

/// One run of the aura producer — mirrors SSCBAnalyzeResult shape.
public struct AuraAnalyzeResult: Sendable {
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

public enum AuraAnalyzeProducer {

    /// Default location for aura EEG records — sibling of
    /// `sscb/transient/`, `component/geometry/`, `matter/parity/`.
    public static let eegRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("aura/eeg", isDirectory: true)

    /// Python candidates — MNE needs a recent stdlib; brew python3.12+
    /// is preferred. The system /usr/bin/python3 (3.9 on macOS 14+) is
    /// allowed as last resort if mne installed there.
    private static let pythonCandidates: [String] = [
        "/opt/homebrew/bin/python3.12",
        "/opt/homebrew/bin/python3.13",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
        "/usr/bin/python3",
    ]

    /// SSOT script path under hexa-lang (D61).
    public static let scriptPath: String =
        NSString(string: "~/core/hexa-lang/stdlib/aura/aura_mne.py")
            .expandingTildeInPath

    public static func locatePython() -> String? {
        let fm = FileManager.default
        for c in pythonCandidates where fm.isExecutableFile(atPath: c) {
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

    /// Returns nil if the SSOT script is missing (honest-gap path).
    public static func locateScript() -> String? {
        FileManager.default.fileExists(atPath: scriptPath) ? scriptPath : nil
    }

    /// Run the aura producer and persist one `AuraRecord` per call.
    /// Each run lives in its own timestamped subdir so consecutive
    /// runs do not stomp each other's .fif / .meta.json.
    public static func runAnalyze() -> AuraAnalyzeResult {
        var lines: [String] = []

        guard let python = locatePython() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(brew install python@3.12 권장). aura + analyze 는 MNE-Python "
                + "을 producer 로 사용합니다 (g3 — silent success 금지).")
            return AuraAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — aura_mne.py 를 찾지 못했습니다 "
                + "(D61 SSOT: ~/core/hexa-lang/stdlib/aura/aura_mne.py). "
                + "sibling repo hexa-lang 의 stdlib/aura/ 에 producer 가 "
                + "존재해야 합니다 (g3).")
            return AuraAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Per-run output dir under exports/aura/eeg/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = eegRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ aura eeg dir mkdir 실패: \(error.localizedDescription)")
            return AuraAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn `python aura_mne.py <runDir>` — the Python prints the
        // AURA_MNE_RESULT line on stderr; capture both streams.
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
            lines.append("⏳ engine tool gap — python aura_mne.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return AuraAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the AURA_MNE_RESULT <json> line.
        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify artifacts on disk (defence-in-depth — @F f6).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python = \(python)")
        lines.append("aura_mne.py — exit \(exitCode)")
        if let v = summary.mneVersion {
            lines.append("MNE version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["fif", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — aura producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return AuraAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Re-read meta.json (Python is SSOT for the numbers).
        let metaName = verified["meta"] ?? "aura_eeg_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(AuraProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) — record 미작성 (g3).")
            return AuraAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "aura_eeg_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let mneVer = summary.mneVersion ?? meta.mneVersion ?? "unknown"
        let caveats: [String] = [
            "MNE-Python 의 Welch PSD 결과 — 숫자는 실제 (deterministic, "
            + "fixed-seed) 이지만 신호 자체는 합성 (alpha 사인 + pink 잡음 "
            + "+ 60 Hz mains). 실제 피험자/전극 없음 (g3 — substrate = "
            + "synthesized, NOT recorded).",
            "post-aural 8-채널 montage (F3/F4/C3/C4/P3/P4/T7/T8) 는 "
            + "라벨일 뿐 — 공간 물리 시뮬레이션 0 (no leadfield, no "
            + "head model, no electrode impedance).",
            "measurement_gate = GATE_OPEN 영구 (synthesized stimulus). "
            + "closedMeasured 로 전환하려면 (a) PhysioNet 같은 공개 "
            + "데이터셋을 commit-hash 로 고정 + spectrum 일치 ±X dB 검증, "
            + "또는 (b) IRB-승인 실제 acquisition + 벤치 검증 필요.",
            "absorbed=true 절대 금지 — domains/aura.md §4 의 Sim4Life "
            + "MRI-safety gap 은 별도 (MNE 는 signal processing, EM "
            + "simulation 아님). MNE 흡수는 EEG-DSP 한 verb 한 셀에 한정.",
        ]

        let stimulus = AuraStimulus(
            sfreqHz: meta.stimulus.sfreqHz,
            durationS: meta.stimulus.durationS,
            nChannels: meta.stimulus.nChannels,
            channelNames: meta.stimulus.channelNames,
            rngSeed: meta.stimulus.rngSeed,
            alphaHz: meta.stimulus.alphaHz,
            alphaAmpUv: meta.stimulus.alphaAmpUv,
            mainsHz: meta.stimulus.mainsHz,
            mainsAmpUv: meta.stimulus.mainsAmpUv,
            pinkAmpUv: meta.stimulus.pinkAmpUv)
        let measurements = AuraMeasurements(
            nChannels: meta.measurements.nChannels,
            nFreqs: meta.measurements.nFreqs,
            freqMinHz: meta.measurements.freqMinHz,
            freqMaxHz: meta.measurements.freqMaxHz,
            bandPowerGrandAvgV2: meta.measurements.bandPowerGrandAvgV2,
            mains60HzRatio: meta.measurements.mains60HzRatio,
            mains60HzDb: meta.measurements.mains60HzDb)

        let record = AuraRecord(
            interface: "demiurge:aura:eeg-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            signalSha256_16: meta.signalSha256_16,
            mneVersion: mneVer,
            stimulus: stimulus,
            measurements: measurements,
            artifacts: verified,
            provenance: AuraProvenance(
                absorbed: false,
                producer: "mne@\(mneVer)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ aura record JSON 쓰기 실패: \(error.localizedDescription)")
            return AuraAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let m = meta.measurements
        lines.append("---")
        lines.append("📸 aura eeg record → exports/aura/eeg/\(stamp)/\(recordId).json")
        if let alpha = m.bandPowerGrandAvgV2["alpha"], let mdb = m.mains60HzDb {
            lines.append(String(format: "   alpha = %.3e V² · "
                + "mains 60 Hz = %+.2f dB · producer = mne@%@",
                alpha, mdb, mneVer))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — 신호 합성된 것 "
            + "(no subject, no electrode). MNE 흡수는 EEG-DSP 한 셀에 "
            + "한정 (g3, scope_caveats 4종 참조).")

        return AuraAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// Mirror the .meta.json shape written by aura_mne.py::main.
    private struct AuraProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let signalSha256_16: String
        let mneVersion: String?
        let stimulus: StimulusDTO
        let measurements: MeasurementsDTO

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case signalSha256_16 = "signal_sha256_16"
            case mneVersion = "mne_version"
            case stimulus
            case measurements
        }

        struct StimulusDTO: Decodable {
            let sfreqHz: Double
            let durationS: Double
            let nChannels: Int
            let channelNames: [String]
            let rngSeed: Int
            let alphaHz: Double
            let alphaAmpUv: Double
            let mainsHz: Double
            let mainsAmpUv: Double
            let pinkAmpUv: Double

            enum CodingKeys: String, CodingKey {
                case sfreqHz = "sfreq_hz"
                case durationS = "duration_s"
                case nChannels = "n_channels"
                case channelNames = "channel_names"
                case rngSeed = "rng_seed"
                case alphaHz = "alpha_hz"
                case alphaAmpUv = "alpha_amp_uV"
                case mainsHz = "mains_hz"
                case mainsAmpUv = "mains_amp_uV"
                case pinkAmpUv = "pink_amp_uV"
            }
        }

        struct MeasurementsDTO: Decodable {
            let nChannels: Int
            let nFreqs: Int
            let freqMinHz: Double
            let freqMaxHz: Double
            let bandPowerGrandAvgV2: [String: Double]
            let mains60HzRatio: Double?
            let mains60HzDb: Double?

            enum CodingKeys: String, CodingKey {
                case nChannels = "n_channels"
                case nFreqs = "n_freqs"
                case freqMinHz = "freq_min_hz"
                case freqMaxHz = "freq_max_hz"
                case bandPowerGrandAvgV2 = "band_power_grand_avg_v2"
                case mains60HzRatio = "mains_60_hz_ratio"
                case mains60HzDb = "mains_60_hz_db"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var mneVersion: String? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `AURA_MNE_RESULT <json>` from the merged stdout/stderr.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "AURA_MNE_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["mne_version"] as? String { out.mneVersion = s }
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
