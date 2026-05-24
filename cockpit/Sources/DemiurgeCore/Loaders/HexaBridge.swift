// HexaBridge — call the hexa stdlib CLI (CLI+COCKPIT M16).
//
// hexa-lang is the SSOT for the compute KERNELS only (verify recompute,
// atlas, physics). demiurge OWNS the dispatch + render (작동부); it calls
// `hexa` as an hx-installed DEPENDENCY (M18) and never reimplements the
// kernel (@D d3 — stdlib-only SSOT). g5: the verdict is pasted VERBATIM
// — demiurge never re-judges a hexa result (LLM self-judge is forbidden).
//
// This is the single spawn point for every hexa leaf-call (verify now;
// atlas-lookup reuses it). The cockpit + CLI both route through here so
// neither carries its own `hexa` invocation (D50).

import Foundation

public enum HexaBridge {

    /// One hexa CLI invocation outcome. `ran=false` means `hexa` is not
    /// on PATH (hx dependency missing) — an honest gap, NOT a verdict.
    public struct Result: Sendable {
        public let text: String     // hexa stdout+stderr, verbatim
        public let exitCode: Int32
        public let ran: Bool

        public init(text: String, exitCode: Int32, ran: Bool) {
            self.text = text
            self.exitCode = exitCode
            self.ran = ran
        }
    }

    /// Spawn `hexa <args>` synchronously, capturing output verbatim.
    /// Honest (g3): a missing `hexa` returns `ran=false` + a plain
    /// install hint — never a fabricated verdict. Off the UI thread
    /// (CLI main, or a Task.detached in the cockpit).
    public static func run(_ args: [String]) -> Result {
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["hexa"] + args
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            let out = String(data: data, encoding: .utf8) ?? ""
            return Result(text: out, exitCode: proc.terminationStatus, ran: true)
        } catch {
            return Result(
                text: "hexa invocation failed: \(error.localizedDescription)\n"
                    + "(`hexa` must be installed — hx dependency, CLI+COCKPIT M18)",
                exitCode: 127, ran: false)
        }
    }

    /// `verify` passthrough — forward args to `hexa verify <args>` and
    /// return the verdict verbatim (@D g5). Caller prints `.text` as-is.
    public static func verify(_ passthrough: [String]) -> Result {
        run(["verify"] + passthrough)
    }
}
