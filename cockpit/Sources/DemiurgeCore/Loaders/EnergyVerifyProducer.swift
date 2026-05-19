// EnergyVerifyProducer — θ-2 engine tool for `energy + verify` (ROI 12).
// OpenMC k-eff criticality via kernels/mc_transport/ (D72 3rd consumer).
// g3: GATE_OPEN / absorbed=false; install + data gated.

import Foundation

public struct EnergyVerifyResult: Sendable {
    public let ok: Bool
    public let lines: [String]
    public let newRecordID: String?
    public init(ok: Bool, lines: [String], newRecordID: String?) {
        self.ok = ok; self.lines = lines; self.newRecordID = newRecordID
    }
    public var text: String { lines.joined(separator: "\n") }
}

public enum EnergyVerifyProducer {
    public static let verifyRecordsRoot: URL =
        RecordLoader.exportsRoot.appendingPathComponent("energy/verify", isDirectory: true)

    public static func runVerify() -> EnergyVerifyResult {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let scriptPath = "\(home)/core/hexa-lang/stdlib/energy/openmc_keff.py"
        guard FileManager.default.fileExists(atPath: scriptPath) else {
            return EnergyVerifyResult(ok: false,
                lines: ["openmc_keff.py substrate missing at \(scriptPath)"],
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
            return EnergyVerifyResult(ok: false,
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
        return EnergyVerifyResult(ok: proc.terminationStatus == 0,
            lines: lines + ["[energy+verify] record dir: \(outDir.path)",
                            "GATE_OPEN / absorbed=false (g3)"],
            newRecordID: recordID)
    }
}
