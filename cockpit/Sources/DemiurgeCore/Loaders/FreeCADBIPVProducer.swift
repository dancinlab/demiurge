// FreeCADBIPVProducer — phase κ-33 (P-⑨ start) — θ-2 engine tool that
// promotes `component + synthesize` from a procedural Swift placeholder
// to a real **parametric** producer driven by FreeCAD's OpenCascade
// kernel (D54).
//
// The Swift side is a thin spawn-and-witness harness:
//   1. locate `freecadcmd` (FreeCAD ≥ 1.x bundled with the .app)
//   2. locate `cockpit/scripts/bipv_freecad.py` (the SSOT for layer
//      parametrics — kept in lockstep with
//      `ComponentGeometry.bipv5Layer`)
//   3. spawn `freecadcmd <script> --pass <output_dir>` and capture the
//      merged stdout/stderr stream
//   4. parse the `BIPV_FREECAD_RESULT <json>` summary line (the Python
//      side prints it on stderr because FreeCAD claims stdout for its
//      own chatter)
//   5. verify the .step / .brep / .stl / .meta.json artifacts were
//      written to disk (defence-in-depth — never trust the parsed line
//      alone; @F f6 "evidence over assertion")
//   6. return a `FreeCADBIPVResult` that ComponentEmitter wraps into
//      a typed `ComponentRecord` with
//      `producer = "freecad@<version>"` and
//      `measurement_gate = GATE_OPEN` (geometry is parametric, not
//      measured — D54 / g3).
//
// HONEST (g3 — non-negotiable):
//   • Parametric geometry from a CAD kernel is **still** a placeholder
//     for the absorbed-component sense — `absorbed = true` is NEVER
//     allowed here. The artifact is a precise model, not a measured
//     part with thermal / structural / optical verdicts.
//   • If FreeCAD is missing OR the script crashes OR the output files
//     are absent, this returns `ok = false` and ComponentEmitter falls
//     back to the procedural emitter (the honest-gap path). Silent
//     success is forbidden — the caveats record every gap.
//
// SSOT note (D50): both the Swift `ComponentGeometry.bipv5Layer` and
// the Python `LAYERS` table describe the same 5-layer BIPV module.
// They are sibling SSOTs by necessity (one drives the Swift exporters
// + viewer, the other drives FreeCAD's kernel) — a future refactor
// may emit the layer table from Swift into argv and let Python read
// it, eliminating the duplication. Until then: keep them in sync; the
// .meta.json layer table is the witness.

import Foundation

/// Outcome of one FreeCAD producer invocation — typed for
/// ComponentEmitter consumption.
public struct FreeCADBIPVResult: Sendable {
    /// Were all four artifacts (.step / .brep / .stl / .meta.json)
    /// written successfully AND did the summary JSON parse cleanly?
    public let ok: Bool
    /// Newline-joined log suitable for the chat panel / CLI stdout.
    public let lines: [String]
    /// Files written, keyed by extension (`step`, `brep`, `stl`,
    /// `meta`). Filenames are relative to `outputDir` — same shape
    /// as the existing procedural emitter so ComponentRecord can
    /// store them directly.
    public let artifacts: [String: String]
    /// The FreeCAD version triple, e.g. "1.1.1", or nil if we could
    /// not parse it from the summary line.
    public let freecadVersion: String?
    /// The geometry slug emitted by the Python side, e.g.
    /// `"bipv_freecad_v1"`. Becomes the ComponentRecord recordId.
    public let geometryId: String?
    /// Total stack thickness in mm reported by Python, for the
    /// ComponentRecord sidecar (so the cockpit doesn't need to
    /// re-tessellate the .step to learn it).
    public let totalThicknessMM: Double?
    /// Layer count reported by Python — sanity-checked against
    /// `ComponentGeometry.bipv5Layer.layers.count` upstream.
    public let layerCount: Int?

    public init(ok: Bool, lines: [String], artifacts: [String: String],
                freecadVersion: String?, geometryId: String?,
                totalThicknessMM: Double?, layerCount: Int?) {
        self.ok = ok
        self.lines = lines
        self.artifacts = artifacts
        self.freecadVersion = freecadVersion
        self.geometryId = geometryId
        self.totalThicknessMM = totalThicknessMM
        self.layerCount = layerCount
    }

    public var text: String { lines.joined(separator: "\n") }
}

public enum FreeCADBIPVProducer {

    /// Default candidate paths for `freecadcmd` — `brew install
    /// freecad` puts it inside the .app bundle, not on the user PATH.
    /// The Apple Silicon path is first since the rest of demiurge
    /// targets macOS 26 (Apple Silicon era).
    private static let freecadcmdCandidates: [String] = [
        "/Applications/FreeCAD.app/Contents/Resources/bin/freecadcmd",
        "/opt/homebrew/bin/freecadcmd",
        "/usr/local/bin/freecadcmd",
    ]

    /// Resolve `freecadcmd`. Returns nil if FreeCAD is not installed
    /// — ComponentEmitter falls back to the procedural emitter and
    /// records the honest gap.
    public static func locateFreeCADCmd() -> String? {
        let fm = FileManager.default
        for c in freecadcmdCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // Fallback to `which freecadcmd`.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "freecadcmd"]
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
    /// D61 / g_demiurge_pointer_only. NO `cockpit/scripts/` fallback
    /// (the directory holds only a tombstone README — see
    /// `cockpit/scripts/README.md`). Migration: 2026-05-20 κ-54 round.
    public static func locateScript() -> String? {
        let path = NSString(
            string: "~/core/hexa-lang/stdlib/freecad/bipv.py"
        ).expandingTildeInPath
        return FileManager.default.fileExists(atPath: path) ? path : nil
    }

    /// Run the FreeCAD producer and write artifacts into `outputDir`.
    /// `outputDir` must already exist (the caller — ComponentEmitter —
    /// creates `exports/component/geometry/`). Returns a typed result;
    /// the caller decides whether to persist a `ComponentRecord`.
    public static func runProducer(outputDir: URL) -> FreeCADBIPVResult {
        var lines: [String] = []

        guard let cmd = locateFreeCADCmd() else {
            lines.append("⏳ engine tool gap — `freecadcmd` 를 찾지 못했습니다 "
                + "(brew install freecad 가 필요합니다). component + "
                + "synthesize 는 절차 placeholder 로 fallback (g3 — "
                + "silent success 금지).")
            return FreeCADBIPVResult(
                ok: false, lines: lines, artifacts: [:],
                freecadVersion: nil, geometryId: nil,
                totalThicknessMM: nil, layerCount: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — bipv_freecad.py 스크립트를 "
                + "찾지 못했습니다 (cockpit/scripts/). 절차 placeholder 로 "
                + "fallback (g3).")
            return FreeCADBIPVResult(
                ok: false, lines: lines, artifacts: [:],
                freecadVersion: nil, geometryId: nil,
                totalThicknessMM: nil, layerCount: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: cmd)
        // `--pass <arg>` tells FreeCAD to leave `<arg>` in sys.argv
        // for the script without trying to open it as a document
        // (verified empirically — without `--pass`, FreeCAD prints
        // "File format not supported" for the output dir).
        proc.arguments = [script, "--pass", outputDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — FreeCAD chatters on both

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — freecadcmd 실행 실패: "
                + "\(error.localizedDescription) (g3).")
            return FreeCADBIPVResult(
                ok: false, lines: lines, artifacts: [:],
                freecadVersion: nil, geometryId: nil,
                totalThicknessMM: nil, layerCount: nil)
        }

        // Parse the `BIPV_FREECAD_RESULT <json>` summary line.
        let summary = parseSummary(captured)
        let producedFiles = summary.artifacts
        // Verify each claimed file actually exists on disk
        // (defence-in-depth — never trust the parsed line alone, @F f6).
        let fm = FileManager.default
        var verified: [String: String] = [:]
        for (kind, name) in producedFiles {
            let url = outputDir.appendingPathComponent(name)
            if fm.fileExists(atPath: url.path),
               (try? fm.attributesOfItem(atPath: url.path)[.size] as? Int) ?? 0 > 0 {
                verified[kind] = name
            }
        }
        // .meta.json sits beside the geometry artifacts — surface it
        // as the fourth verified artifact key so ComponentRecord can
        // point to it.
        let metaName = (summary.geometryId ?? "bipv_freecad_v1") + ".meta.json"
        let metaURL = outputDir.appendingPathComponent(metaName)
        if fm.fileExists(atPath: metaURL.path) {
            verified["meta"] = metaName
        }

        lines.append("freecadcmd \(script) — exit \(exitCode)")
        if let v = summary.freecadVersion {
            lines.append("FreeCAD version: \(v)")
        }
        if !verified.isEmpty {
            let keys = verified.keys.sorted().joined(separator: ", ")
            lines.append("artifacts written: \(keys)")
        }

        let needed = ["step", "brep", "stl", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            let missing = needed.filter { verified[$0] == nil }
            if !missing.isEmpty {
                lines.append("⏳ honest gap — 누락된 artifact: "
                    + missing.joined(separator: ", ")
                    + " (g3 — silent success 금지).")
            }
            if exitCode != 0 {
                lines.append("⏳ honest gap — freecadcmd exit \(exitCode) "
                    + "(FreeCAD log 의 tail 을 확인 — g3).")
                // Append the last few captured lines for chat visibility.
                let tail = lastLines(captured, 6)
                if !tail.isEmpty {
                    lines.append("freecadcmd tail:")
                    lines.append(tail)
                }
            }
        }

        return FreeCADBIPVResult(
            ok: ok,
            lines: lines,
            artifacts: verified,
            freecadVersion: summary.freecadVersion,
            geometryId: summary.geometryId,
            totalThicknessMM: summary.totalThicknessMM,
            layerCount: summary.layerCount)
    }

    // MARK: - Summary parsing

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var freecadVersion: String? = nil
        var totalThicknessMM: Double? = nil
        var layerCount: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract the `BIPV_FREECAD_RESULT <json>` line from the merged
    /// FreeCAD stdout/stderr stream and decode the JSON payload.
    /// Tolerates the chatty progress bars FreeCAD interleaves —
    /// scans every line and picks the last well-formed one.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "BIPV_FREECAD_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let arr = obj["freecad_version"] as? [String] {
                out.freecadVersion = arr.prefix(3).joined(separator: ".")
            }
            if let d = obj["total_thickness_mm"] as? Double {
                out.totalThicknessMM = d
            } else if let i = obj["total_thickness_mm"] as? Int {
                out.totalThicknessMM = Double(i)
            }
            if let n = obj["layer_count"] as? Int { out.layerCount = n }
            if let exp = obj["exports"] as? [String: String] {
                out.artifacts = exp
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
