// CernSynthProducer — θ-2 engine tool for `cern + synthesize`.
// ROI rank 7, ⭐⭐⭐⭐. Xsuite FODO twiss + tune fit. Cited:
// arxiv:2310.00317 (Xsuite), arxiv:2412.16006 (MAD-NG).
//
// D61: spawns `~/core/hexa-lang/stdlib/cern/xsuite_optics.py`.
// D72: accelerator optics single-domain; kernel promotion at 2nd
//      consumer.
// g3:  GATE_OPEN / absorbed=false; honest skip on Xsuite ImportError.

import Foundation

public struct CernSynthResult: Sendable {
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

public enum CernSynthProducer {

    public static let synthRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("cern/synthesize", isDirectory: true)

    public static func runSynthesize() -> CernSynthResult {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let scriptPath = "\(home)/core/hexa-lang/stdlib/cern/xsuite_optics.py"
        guard FileManager.default.fileExists(atPath: scriptPath) else {
            return CernSynthResult(
                ok: false,
                lines: ["xsuite_optics.py substrate missing at \(scriptPath)"],
                newRecordID: nil)
        }
        let stamp = ISO8601DateFormatter().string(from: Date())
            .replacingOccurrences(of: ":", with: "-")
        let outDir = synthRecordsRoot.appendingPathComponent(stamp)
        try? FileManager.default.createDirectory(
            at: outDir, withIntermediateDirectories: true)
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["python3", scriptPath, outDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        do { try proc.run() } catch {
            return CernSynthResult(
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
        return CernSynthResult(
            ok: proc.terminationStatus == 0,
            lines: lines + [
                "[cern+synthesize] record dir: \(outDir.path)",
                "GATE_OPEN / absorbed=false (g3)",
            ],
            newRecordID: recordID)
    }
}
