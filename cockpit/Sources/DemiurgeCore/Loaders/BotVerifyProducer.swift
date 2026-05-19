// BotVerifyProducer — θ-2 engine tool for `bot + verify` (ROI 13).
// Drake Lyapunov / SOS primitives. g3: GATE_OPEN / absorbed=false;
// install-gated skip when pydrake missing.

import Foundation

public struct BotVerifyResult: Sendable {
    public let ok: Bool
    public let lines: [String]
    public let newRecordID: String?
    public init(ok: Bool, lines: [String], newRecordID: String?) {
        self.ok = ok; self.lines = lines; self.newRecordID = newRecordID
    }
    public var text: String { lines.joined(separator: "\n") }
}

public enum BotVerifyProducer {
    public static let verifyRecordsRoot: URL =
        RecordLoader.exportsRoot.appendingPathComponent("bot/verify", isDirectory: true)

    public static func runVerify() -> BotVerifyResult {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let scriptPath = "\(home)/core/hexa-lang/stdlib/bot/drake_verify.py"
        guard FileManager.default.fileExists(atPath: scriptPath) else {
            return BotVerifyResult(ok: false,
                lines: ["drake_verify.py substrate missing at \(scriptPath)"],
                newRecordID: nil)
        }
        let stamp = ISO8601DateFormatter().string(from: Date()).replacingOccurrences(of: ":", with: "-")
        let outDir = verifyRecordsRoot.appendingPathComponent(stamp)
        try? FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["python3", scriptPath, outDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe; proc.standardError = pipe
        do { try proc.run() } catch {
            return BotVerifyResult(ok: false,
                lines: ["spawn failed: \(error.localizedDescription)"],
                newRecordID: nil)
        }
        proc.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let out = String(data: data, encoding: .utf8) ?? ""
        let lines = out.split(separator: "\n").map(String.init)
        let jsons = (try? FileManager.default.contentsOfDirectory(at: outDir,
            includingPropertiesForKeys: nil))?.filter { $0.pathExtension == "json" } ?? []
        let recordID = jsons.first?.lastPathComponent.replacingOccurrences(of: ".json", with: "")
        return BotVerifyResult(ok: proc.terminationStatus == 0,
            lines: lines + ["[bot+verify] record dir: \(outDir.path)",
                            "GATE_OPEN / absorbed=false (g3)"],
            newRecordID: recordID)
    }
}
