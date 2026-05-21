// CellrunDispatch — generic (verb, domain) → hexa-native cellrun.hexa
// dispatcher (D111 Phase B · ARCH §4.5 · constitution R2).
//
// This is the Swift-side thin wrapper. The HEAVY lifting (.demi manifest
// load · dep probe · substrate spawn · record envelope emit · g3 gate
// application) is in `~/core/hexa-lang/stdlib/cockpit/cellrun.hexa`
// (Phase A scaffold, branch `cellrun-generic-dispatcher-scaffold@cc1ad85`,
// pending PR #267 against hexa-lang main).
//
// We spawn `hexa run cellrun.hexa <domain> <verb>` with three env-tunables
// so the dispatcher resolves manifest paths / exports paths / script root
// against this demiurge checkout:
//
//   HEXA_CELLRUN_DEMI_ROOT       — points at demiurge `<repo>/domains/`
//   HEXA_CELLRUN_EXPORTS_ROOT    — points at demiurge `<repo>/exports/`
//   HEXA_CELLRUN_HEXA_LANG_ROOT  — points at hexa-lang checkout root
//
// Until PR #267 merges and `~/core/hexa-lang/stdlib/cockpit/cellrun.hexa`
// exists on main, we point at the Phase A branch worktree at
// `~/core/hexa-lang-cellrun/`. After merge the env-default
// `~/core/hexa-lang/` will Just Work. Override at runtime via
// `HEXA_CELLRUN_CELLRUN_PATH=/path/to/cellrun.hexa` or
// `HEXA_CELLRUN_HEXA_LANG_ROOT=/path/to/hexa-lang-checkout`.
//
// HONEST (g3 — non-negotiable):
//   • Phase B step 3 ADDS a new dispatch path next to the existing
//     SSCBProducer*.swift trio — old producers are NOT deleted (Phase C
//     cleanup, after roundtrip verify across all 46 cells).
//   • cellrun's rc semantics: 0=ok · 2=manifest-missing-or-script-missing
//     (honest-skip) · 3=deps-missing (honest-skip) · 4=substrate-fail ·
//     5=record-write-fail. Swift surfaces every non-zero as ok=false +
//     `[cellrun]` banner text so the user sees the gap (no silent
//     success).
//   • payload shape is a generic envelope (substrate · script · exit_code
//     · log_path · run_dir · provenance) — does NOT yet carry the
//     domain-specific fields (rise_time / interrupt_ratio / etc) that
//     the legacy SSCBRecord typed structs surfaced. That's expected
//     Phase A scope — Phase C will either (a) re-parse the script's
//     stdout markers on the Swift side from `_cellrun.log`, or (b)
//     teach cellrun.hexa to capture domain-specific marker lines into
//     the envelope's `payload.measurements` map.

import Foundation

/// One CellrunDispatch invocation outcome — mirrors `SSCBAnalyzeResult` /
/// `EnergyAnalyzeResult` etc so the Swift→ActionResult bridging stays
/// uniform.
public struct CellrunDispatchResult: Sendable {
    /// Did cellrun return rc=0 AND emit a record JSON?
    public let ok: Bool
    /// Newline-joined banner lines for the chat panel / CLI stdout.
    public let lines: [String]
    /// The newly-emitted record ID (cellrun's `record_id` field).
    public let newRecordID: String?
    /// rc from cellrun.hexa (0/2/3/4/5 — see file header).
    public let exitCode: Int32

    public init(ok: Bool, lines: [String], newRecordID: String?,
                exitCode: Int32) {
        self.ok = ok
        self.lines = lines
        self.newRecordID = newRecordID
        self.exitCode = exitCode
    }

    public var text: String { lines.joined(separator: "\n") }
}

public enum CellrunDispatch {

    /// Canonical default for the cellrun.hexa script path during Phase B
    /// (PR #267 on hexa-lang pending merge). After merge, set env
    /// `HEXA_CELLRUN_CELLRUN_PATH` empty (or the default below) to use
    /// `<hexa_lang_root>/stdlib/cockpit/cellrun.hexa`.
    private static let phaseBBranchWorktree: String =
        NSString(string: "~/core/hexa-lang-cellrun").expandingTildeInPath

    private static let mainHexaLangCheckout: String =
        NSString(string: "~/core/hexa-lang").expandingTildeInPath

    /// Resolve the cellrun.hexa script path. Strategy:
    ///   1. Honor `HEXA_CELLRUN_CELLRUN_PATH` if set (test / override).
    ///   2. Try main hexa-lang worktree `stdlib/cockpit/cellrun.hexa`
    ///      (post-merge happy path).
    ///   3. Fall back to Phase B branch worktree (pre-merge).
    ///   4. Return nil — surfaces as honest-gap.
    public static func locateCellrun() -> String? {
        let fm = FileManager.default
        if let override = ProcessInfo.processInfo.environment["HEXA_CELLRUN_CELLRUN_PATH"],
           !override.isEmpty, fm.fileExists(atPath: override) {
            return override
        }
        let mainPath = mainHexaLangCheckout
            + "/stdlib/cockpit/cellrun.hexa"
        if fm.fileExists(atPath: mainPath) { return mainPath }
        let branchPath = phaseBBranchWorktree
            + "/stdlib/cockpit/cellrun.hexa"
        if fm.fileExists(atPath: branchPath) { return branchPath }
        return nil
    }

    /// Locate the `hexa` binary (mirrors SSCBProducer.locateNgspice style).
    private static let hexaCandidates: [String] = [
        NSString(string: "~/.hx/bin/hexa").expandingTildeInPath,
        "/opt/homebrew/bin/hexa",
        "/usr/local/bin/hexa",
    ]

    public static func locateHexa() -> String? {
        let fm = FileManager.default
        for c in hexaCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // PATH fallback via `which`.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "hexa"]
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

    /// Resolve the demiurge `<repo>/domains/` path.
    /// Mirrors RecordLoader.exportsRoot resolution (DEMIURGE_REPO env →
    /// cwd-relative `../domains` fallback for `swift run` from cockpit/).
    public static var demiRootURL: URL {
        let env = ProcessInfo.processInfo.environment
        if let repo = env["DEMIURGE_REPO"], !repo.isEmpty {
            return URL(fileURLWithPath: repo, isDirectory: true)
                .appendingPathComponent("domains").standardizedFileURL
        }
        let cwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath,
                      isDirectory: true)
        return cwd.appendingPathComponent("../domains").standardizedFileURL
    }

    /// Drive cellrun.hexa for (verb, domain). Returns an
    /// ActionResult-shaped outcome via CellrunDispatchResult.
    public static func runRaw(verb: Verb, domain: String)
        -> CellrunDispatchResult
    {
        var lines: [String] = []

        guard let hexa = locateHexa() else {
            lines.append("⏳ engine tool gap — `hexa` 바이너리 미발견 "
                + "(~/.hx/bin/hexa 또는 PATH). cellrun dispatcher 는 "
                + "hexa-lang runtime 필요 (g3).")
            return CellrunDispatchResult(ok: false, lines: lines,
                newRecordID: nil, exitCode: -1)
        }
        guard let cellrun = locateCellrun() else {
            lines.append("⏳ engine tool gap — cellrun.hexa 미발견. "
                + "기대 경로: ~/core/hexa-lang/stdlib/cockpit/cellrun.hexa "
                + "(PR #267 merge 후) 또는 "
                + "~/core/hexa-lang-cellrun/stdlib/cockpit/cellrun.hexa "
                + "(Phase A branch worktree, pre-merge). g3.")
            return CellrunDispatchResult(ok: false, lines: lines,
                newRecordID: nil, exitCode: -1)
        }

        let demiRoot = demiRootURL.path
        let exportsRoot = RecordLoader.exportsRoot.path
        // hexa_lang_root is the parent of stdlib/cockpit/cellrun.hexa,
        // i.e. two levels up.
        let hexaLangRoot = URL(fileURLWithPath: cellrun)
            .deletingLastPathComponent()   // stdlib/cockpit/
            .deletingLastPathComponent()   // stdlib/
            .deletingLastPathComponent()   // <root>
            .path

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: hexa)
        proc.arguments = ["run", cellrun, domain, verb.canonical]
        var env = ProcessInfo.processInfo.environment
        env["HEXA_CELLRUN_DEMI_ROOT"] = demiRoot
        env["HEXA_CELLRUN_EXPORTS_ROOT"] = exportsRoot
        env["HEXA_CELLRUN_HEXA_LANG_ROOT"] = hexaLangRoot
        proc.environment = env

        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — cellrun.hexa banners on stdout

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — hexa run cellrun.hexa "
                + "spawn 실패: \(error.localizedDescription) (g3).")
            return CellrunDispatchResult(ok: false, lines: lines,
                newRecordID: nil, exitCode: -1)
        }

        // Surface the cellrun banner to the user verbatim — it contains
        // the [cellrun] honest-skip / honest-fail / record-path lines.
        for ln in captured.split(separator: "\n", omittingEmptySubsequences: false) {
            lines.append(String(ln))
        }

        // Parse the record path from `[cellrun] record → /abs/path/...json`
        // line, if present.
        let recordPath = parseRecordPath(captured)
        let recordID: String? = recordPath.map { url -> String in
            (url as NSString).lastPathComponent
                .replacingOccurrences(of: ".json", with: "")
        }

        let ok = (exitCode == 0) && (recordPath != nil)
        if !ok && exitCode == 0 {
            lines.append("⏳ honest gap — cellrun rc=0 but no record-path "
                + "banner parsed (g3). Check log tail above.")
        }
        return CellrunDispatchResult(ok: ok, lines: lines,
            newRecordID: recordID, exitCode: exitCode)
    }

    /// ActionResult-flavored entry point (used by ActionDispatch).
    public static func run(verb: Verb, domain: String) -> ActionResult {
        let r = runRaw(verb: verb, domain: domain)
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// Extract the absolute record path from the `[cellrun] record →
    /// /abs/path.json` banner line emitted by cell_run_with_roots().
    /// Returns nil if not found.
    private static func parseRecordPath(_ captured: String) -> String? {
        for raw in captured.split(separator: "\n") {
            let line = String(raw)
            // Be tolerant of both ASCII "->" and unicode "→".
            if let arrowRange = line.range(of: "[cellrun] record ") {
                let tail = line[arrowRange.upperBound...]
                // Strip leading marker (→ or -> or :) and whitespace.
                let stripped = tail
                    .drop(while: { ch in
                        ch == "→" || ch == "-" || ch == ">"
                            || ch == " " || ch == "\t" || ch == ":"
                    })
                let candidate = String(stripped).trimmingCharacters(
                    in: .whitespaces)
                if candidate.hasPrefix("/"), candidate.hasSuffix(".json") {
                    return candidate
                }
            }
        }
        return nil
    }
}
