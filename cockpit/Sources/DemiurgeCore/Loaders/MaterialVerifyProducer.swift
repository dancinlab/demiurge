// MaterialVerifyProducer — RTSC.md §8.7 Tier 1 aggregator for
// `material + verify`. Spawns four Tier 1 sub-producers under
// `exports/material/verify/<stamp>/{sim_adapter,cube_producer,
// hexa_rtsc_crosslink,mp_query}/` and returns a consolidated
// list of record IDs.
//
// g3 honest stance (RTSC.md §8.7 → §8.8):
//   • Each sub-producer keeps its OWN absorbed=false / GATE_OPEN.
//     This dispatcher does NOT compute a combined verdict — that's
//     Tier 4 MaterialFalsifierDispatch's job, NOT this one.
//   • Aggregated `ok` is true iff at least ONE sub-producer landed
//     a record. Per-producer success/skip is captured per line.
//   • Cube_producer's 480s default budget is overridden to a 60s
//     smoke-check via subprocess wall-time termination — the cube
//     run emits an honest install-gated / partial-cycle record on
//     timeout (NEVER silent success).
//   • mp_query is skipped when MP_API_KEY / MP_API_KEY_NEW absent.

import Foundation

public struct MaterialVerifyResult: Sendable {
    public let ok: Bool
    public let lines: [String]
    public let newRecordIDs: [String]
    public init(ok: Bool, lines: [String], newRecordIDs: [String]) {
        self.ok = ok
        self.lines = lines
        self.newRecordIDs = newRecordIDs
    }
    public var text: String { lines.joined(separator: "\n") }
}

public enum MaterialVerifyProducer {

    /// Default location for material-verify aggregated runs.
    public static let verifyRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("material/verify", isDirectory: true)

    /// Cube_producer wall budget for the aggregator's smoke-check.
    /// The producer itself reserves 480s for solve + 60s for mesh; we
    /// SIGTERM it at 60s on the Swift side so the dispatcher stays
    /// quick. A real ≥480s budget run is a separate cohort.
    private static let cubeBudgetSeconds: TimeInterval = 60

    /// SSOT script paths under ~/core/hexa-lang/stdlib/material/.
    private static let scriptsRoot: String = {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        return "\(home)/core/hexa-lang/stdlib/material"
    }()

    /// One sub-producer run outcome.
    private struct SubResult {
        let name: String
        let ok: Bool
        let recordIDs: [String]
        let lines: [String]
    }

    /// Locate a Python 3 binary — prefer Homebrew, then PATH (matches
    /// ComponentVerifyProducer.locatePython3).
    private static func locatePython3() -> String? {
        let fm = FileManager.default
        let candidates = [
            "/opt/homebrew/bin/python3",
            "/usr/local/bin/python3",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
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

    /// Spawn one Python producer with an optional wall-time budget.
    /// `timeout == nil` ⇒ no SIGTERM; runs to completion. Captures
    /// stdout+stderr, scans `outDir` for `recordPrefixes`-prefixed
    /// `*.json` files, and returns the basenames (sans `.json`) as
    /// record IDs.
    private static func spawnPython(
        name: String,
        python: String,
        script: String,
        argv: [String],
        env: [String: String],
        outDir: URL,
        recordPrefixes: [String],
        timeout: TimeInterval?
    ) -> SubResult {
        var lines: [String] = []
        guard FileManager.default.fileExists(atPath: script) else {
            lines.append("[\(name)] SKIP — script missing at \(script)")
            return SubResult(name: name, ok: false, recordIDs: [], lines: lines)
        }
        do {
            try FileManager.default.createDirectory(
                at: outDir, withIntermediateDirectories: true)
        } catch {
            lines.append("[\(name)] SKIP — mkdir failed: \(error.localizedDescription)")
            return SubResult(name: name, ok: false, recordIDs: [], lines: lines)
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: python)
        proc.arguments = [script] + argv
        // Inherit parent env, then layer our additions on top.
        var mergedEnv = ProcessInfo.processInfo.environment
        for (k, v) in env { mergedEnv[k] = v }
        proc.environment = mergedEnv
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        do {
            try proc.run()
        } catch {
            lines.append("[\(name)] SKIP — spawn failed: \(error.localizedDescription)")
            return SubResult(name: name, ok: false, recordIDs: [], lines: lines)
        }

        // Manual wall-clock budget — Process has no built-in timeout
        // on Swift Foundation. Schedule a terminate() on a background
        // queue and detect the timeout post-hoc from termination
        // reason (uncaughtSignal indicates SIGTERM).
        let started = Date()
        if let t = timeout {
            let timerQueue = DispatchQueue.global(qos: .utility)
            timerQueue.asyncAfter(deadline: .now() + t) { [weak proc] in
                guard let p = proc, p.isRunning else { return }
                p.terminate()
            }
        }
        proc.waitUntilExit()
        let elapsed = Date().timeIntervalSince(started)
        let didTimeout = (timeout != nil)
            && (proc.terminationReason == .uncaughtSignal
                || (elapsed >= (timeout ?? .infinity) - 0.5))
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let out = String(data: data, encoding: .utf8) ?? ""
        let producerLines = out.split(separator: "\n").map(String.init)
        for l in producerLines { lines.append("[\(name)] \(l)") }
        if didTimeout {
            lines.append(
                "[\(name)] wall-clock budget \(Int(timeout ?? 0))s exhausted — "
                + "process terminated (partial-cycle record may still have landed)"
            )
        }

        // Scan outDir for record JSONs matching any of `recordPrefixes`.
        let fm = FileManager.default
        let files = (try? fm.contentsOfDirectory(
            at: outDir, includingPropertiesForKeys: nil)) ?? []
        var ids: [String] = []
        for url in files {
            guard url.pathExtension == "json" else { continue }
            let basename = url.lastPathComponent
            if recordPrefixes.contains(where: { basename.hasPrefix($0) }) {
                ids.append(String(basename.dropLast(".json".count)))
            }
        }
        ids = Array(Set(ids)).sorted()

        // Success = produced at least one record (Python's exit status
        // is allowed to be non-zero when the producer emits an
        // install-gated/skip record but still lands valid JSON).
        let ok = !ids.isEmpty
        lines.append(
            "[\(name)] result: " + (ok ? "OK" : "SKIP")
            + " · records=\(ids.count) · exit=\(proc.terminationStatus)"
        )
        return SubResult(name: name, ok: ok, recordIDs: ids, lines: lines)
    }

    /// Spawn all four Tier 1 sub-producers and aggregate their record
    /// IDs. No combined absorbed verdict (Tier 4 territory).
    public static func runVerify() -> MaterialVerifyResult {
        var lines: [String] = []
        var allRecordIDs: [String] = []
        var subResults: [SubResult] = []

        guard let python = locatePython3() else {
            return MaterialVerifyResult(
                ok: false,
                lines: ["python3 not found on PATH — cannot spawn material Tier 1 producers"],
                newRecordIDs: [])
        }

        let stamp = ISO8601DateFormatter().string(from: Date())
            .replacingOccurrences(of: ":", with: "-")
        let runRoot = verifyRecordsRoot.appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runRoot, withIntermediateDirectories: true)
        } catch {
            return MaterialVerifyResult(
                ok: false,
                lines: ["[material+verify] mkdir \(runRoot.path) failed: \(error.localizedDescription)"],
                newRecordIDs: [])
        }
        lines.append("[material+verify] run dir: \(runRoot.path)")
        lines.append("[material+verify] python3: \(python)")

        // ─── 1. sim_adapter — BCS/McMillan/Allen-Dynes/WHH closed-form ──
        let simDir = runRoot.appendingPathComponent("sim_adapter", isDirectory: true)
        let simResult = spawnPython(
            name: "sim_adapter",
            python: python,
            script: "\(scriptsRoot)/sim_adapter.py",
            argv: [simDir.path],
            env: [:],
            outDir: simDir,
            recordPrefixes: ["material_verify_"],
            timeout: nil)
        subResults.append(simResult)
        lines.append(contentsOf: simResult.lines)
        allRecordIDs.append(contentsOf: simResult.recordIDs)

        // ─── 2. cube_producer — H-formulation cube smoke check (60s) ──
        // Honor caller env when set; otherwise opt-in for the license-
        // unclear path so the solve actually runs if life-hts/cube/ is
        // local. GETDP_BIN: prefer caller's; else the ~/local/getdp/
        // candidate if present (cube_producer's _pick_getdp would also
        // find it, but explicit ENV makes the choice auditable).
        var cubeEnv: [String: String] = [:]
        if ProcessInfo.processInfo.environment["DEMIURGE_RTSC_USE_LICENSE_UNCLEAR"] == nil {
            cubeEnv["DEMIURGE_RTSC_USE_LICENSE_UNCLEAR"] = "1"
        }
        if ProcessInfo.processInfo.environment["GETDP_BIN"] == nil {
            let getdpCandidate = "\(FileManager.default.homeDirectoryForCurrentUser.path)"
                + "/local/getdp/getdp-4.0.0-MacOSARM/bin/getdp"
            if FileManager.default.isExecutableFile(atPath: getdpCandidate) {
                cubeEnv["GETDP_BIN"] = getdpCandidate
            }
        }
        let cubeDir = runRoot.appendingPathComponent("cube_producer", isDirectory: true)
        let cubeResult = spawnPython(
            name: "cube_producer",
            python: python,
            script: "\(scriptsRoot)/cube_producer.py",
            argv: [cubeDir.path],
            env: cubeEnv,
            outDir: cubeDir,
            recordPrefixes: ["material_verify_h_formulation_cube_"],
            timeout: cubeBudgetSeconds)
        subResults.append(cubeResult)
        lines.append(contentsOf: cubeResult.lines)
        allRecordIDs.append(contentsOf: cubeResult.recordIDs)

        // ─── 3. hexa_rtsc_crosslink — calc_*.hexa vs sim_adapter ──
        let crosslinkDir = runRoot.appendingPathComponent(
            "hexa_rtsc_crosslink", isDirectory: true)
        let crosslinkResult = spawnPython(
            name: "hexa_rtsc_crosslink",
            python: python,
            script: "\(scriptsRoot)/hexa_rtsc_crosslink.py",
            argv: [crosslinkDir.path],
            env: [:],
            outDir: crosslinkDir,
            recordPrefixes: ["material_crosslink_"],
            timeout: nil)
        subResults.append(crosslinkResult)
        lines.append(contentsOf: crosslinkResult.lines)
        allRecordIDs.append(contentsOf: crosslinkResult.recordIDs)

        // ─── 4. mp_query — Materials Project (skip if no API key) ──
        let mpDir = runRoot.appendingPathComponent("mp_query", isDirectory: true)
        let env = ProcessInfo.processInfo.environment
        let mpKey = env["MP_API_KEY_NEW"] ?? env["MP_API_KEY"] ?? ""
        if mpKey.isEmpty {
            try? FileManager.default.createDirectory(
                at: mpDir, withIntermediateDirectories: true)
            let skipLine = "[mp_query] SKIP — MP_API_KEY (or MP_API_KEY_NEW) not set in env"
            lines.append(skipLine)
            lines.append("[mp_query] result: SKIP · records=0 · exit=n/a")
            subResults.append(SubResult(
                name: "mp_query", ok: false, recordIDs: [],
                lines: [skipLine]))
        } else {
            let mpResult = spawnPython(
                name: "mp_query",
                python: python,
                script: "\(scriptsRoot)/mp_query.py",
                argv: [mpDir.path, "MgB2"],
                env: [:],
                outDir: mpDir,
                recordPrefixes: ["material_query_"],
                timeout: nil)
            subResults.append(mpResult)
            lines.append(contentsOf: mpResult.lines)
            allRecordIDs.append(contentsOf: mpResult.recordIDs)
        }

        // ─── Aggregate verdict (g3: NO combined absorbed flip) ─────
        let okCount = subResults.filter { $0.ok }.count
        let overallOk = okCount >= 1
        lines.append("[material+verify] aggregated:")
        for r in subResults {
            let tag = r.ok ? "OK  " : "SKIP"
            let recs = r.recordIDs.isEmpty ? "—" : r.recordIDs.joined(separator: ", ")
            lines.append("  · \(tag) \(r.name)  · records: \(recs)")
        }
        lines.append(
            "[material+verify] honest g3: this aggregator does NOT compute "
            + "a combined absorbed verdict. Each sub-producer keeps its own "
            + "GATE_OPEN / absorbed=false. Tier 4 (MaterialFalsifierDispatch) "
            + "is the only path that synthesizes a falsifier verdict.")

        return MaterialVerifyResult(
            ok: overallOk,
            lines: lines,
            newRecordIDs: allRecordIDs.sorted())
    }
}
