// RtscAnalyzeProducer — θ-2 engine tool for `rtsc + analyze`.
// ROI rank 10, ⭐⭐⭐⭐ — FIRST producer in rtsc domain (whole-domain
// 0-producer before this). pyfemm 2-D axisymmetric HTS coil B-field
// map. Cited: arxiv:0811.2883, FEMM 4.2, HTS Modelling Workgroup;
// cohort pickup: `inbox/notes/cohort-pickup-rtsc-femm-producer.md`.
//
// D61: spawns `~/core/hexa-lang/stdlib/rtsc/pyfemm_magnetics.py`.
// D72: FEMM own ecosystem (NOT skfem); kernels/em_2d/ at 2nd consumer.
// g3:  GATE_OPEN / absorbed=false; macOS honest-skip (FEMM Windows
//      binary), Linux pool only.

import Foundation

public struct RtscAnalyzeResult: Sendable {
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

public enum RtscAnalyzeProducer {

    public static let analyzeRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("rtsc/analyze", isDirectory: true)

    public static func runAnalyze() -> RtscAnalyzeResult {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let scriptPath = "\(home)/core/hexa-lang/stdlib/rtsc/pyfemm_magnetics.py"
        guard FileManager.default.fileExists(atPath: scriptPath) else {
            return RtscAnalyzeResult(
                ok: false,
                lines: ["pyfemm_magnetics.py substrate missing at \(scriptPath)"],
                newRecordID: nil)
        }
        let stamp = ISO8601DateFormatter().string(from: Date())
            .replacingOccurrences(of: ":", with: "-")
        let outDir = analyzeRecordsRoot.appendingPathComponent(stamp)
        try? FileManager.default.createDirectory(
            at: outDir, withIntermediateDirectories: true)
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["python3", scriptPath, outDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        do { try proc.run() } catch {
            return RtscAnalyzeResult(
                ok: false,
                lines: ["spawn failed: \(error.localizedDescription)"],
                newRecordID: nil)
        }
        proc.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let out = String(data: data, encoding: .utf8) ?? ""
        let lines = out.split(separator: "\n").map(String.init)
        let jsons = (try? FileManager.default.contentsOfDirectory(
            at: outDir, includingPropertiesForKeys: nil))?
            .filter { $0.pathExtension == "json" } ?? []
        let recordPath = jsons.first
        let recordID = recordPath?.lastPathComponent
            .replacingOccurrences(of: ".json", with: "")
        return RtscAnalyzeResult(
            ok: proc.terminationStatus == 0,
            lines: lines + [
                "[rtsc+analyze] record dir: \(outDir.path)",
                "GATE_OPEN / absorbed=false (g3) — macOS honest-skip OR pyfemm-run on Linux pool",
            ],
            newRecordID: recordID)
    }
}
