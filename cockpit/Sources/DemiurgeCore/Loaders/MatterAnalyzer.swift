// MatterAnalyzer — θ-2 engine tool for `matter + analyze` (κ-30 /
// design.md D53 / rfc_011 §6.3 / D50 — CLI ↔ cockpit byte-identical).
//
// Spawns hexa-matter's `verify/run_all.hexa` aggregator (the SSOT
// closure-invariant sweep: spec_presence · lattice_arithmetic ·
// real_limits_anchor · closure_consistency) and turns the captured
// stdout into a typed `MatterRecord` under
// `exports/matter/parity/<timestamp>.json`.
//
// Why `analyze` and not `verify` / `synthesize` (D53):
//   • hexa-matter's run_all is *not* synthesis — no new physical
//     artifact is built. It is a closure-invariant audit ("does this
//     materials substrate still cohere?").
//   • `verify` in demiurge's 7-verb spine means "측정으로 확인" —
//     bench measurement, not a documentation/anchor cross-check.
//     A spec_presence pass does not mean a material was measured.
//   • `analyze` (해석⟲) = "설계가 잘 됐는지 점검하고 따져봐요"
//     (Verb.hint) — closure consistency / lattice arithmetic /
//     real-limits anchoring IS that. Best semantic fit.
//
// HONESTY (g3 — non-negotiable):
//   • The PASS we record is hexa-matter's PASS, not demiurge's.
//     producer = "hexa_matter@<commit-hash>" pinning the witness.
//     If we cannot capture the commit hash (e.g. repo missing or
//     not git), we emit producer = "hexa_matter@unknown" AND drop
//     measurementGate to .open + absorbed = false (honest gap).
//   • Swift never simulates the matter substrate (D15 / D17 — that
//     is hexa-lang/hexa-matter's exclusive turf). This file only
//     spawns the producer's aggregator and witnesses its stdout.
//   • engine-tool gap when `hexa` is missing OR hexa-matter repo
//     is absent OR run_all.hexa is absent — never silent success.

import Foundation

/// One run of the matter analyzer — kept as plain text + ID list so
/// cockpit chat + CLI both pretty-print the same lines (D50).
public struct MatterAnalyzeResult: Sendable {
    /// Did every subscript PASS AND was a record persisted?
    public let ok: Bool
    /// Newline-joined lines, suitable for stdout / chat panel.
    public let lines: [String]
    /// The new record ID, if a record was successfully written.
    public let newRecordID: String?

    public init(ok: Bool, lines: [String], newRecordID: String?) {
        self.ok = ok
        self.lines = lines
        self.newRecordID = newRecordID
    }

    public var text: String { lines.joined(separator: "\n") }
}

public enum MatterAnalyzer {

    /// Default location for matter parity records — sibling of
    /// `chip/noc/f1f2/records/` and `component/geometry/`.
    public static let parityRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("matter/parity", isDirectory: true)

    /// Run `hexa run verify/run_all.hexa` against the hexa-matter
    /// SSOT (`~/core/hexa-matter`) and persist a `MatterRecord`.
    /// Idempotent — each call writes a fresh timestamp-keyed record.
    public static func runAnalyze() -> MatterAnalyzeResult {
        var lines: [String] = []
        let home = NSString(string: "~").expandingTildeInPath
        let matterRoot = "\(home)/core/hexa-matter"
        let runAll = "\(matterRoot)/verify/run_all.hexa"

        guard let hexaPath = locateHexa() else {
            lines.append("⏳ engine tool gap — `hexa` 실행 파일을 PATH 또는 "
                + "~/core/hexa-lang/hexa 에서 찾지 못했습니다. matter + "
                + "analyze 는 hexa-matter `verify/run_all.hexa` 를 spawn "
                + "해야 합니다 (g3 — silent success 금지).")
            return MatterAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard FileManager.default.fileExists(atPath: runAll) else {
            lines.append("⏳ engine tool gap — hexa-matter run_all.hexa 를 "
                + "찾지 못했습니다 (\(runAll)). matter + analyze 는 "
                + "hexa-matter SSOT 의 closure-invariant aggregator 를 "
                + "필요로 합니다 (D17 — hexa-matter 가 owner, demiurge 는 "
                + "consumer). (g3).")
            return MatterAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let commitHash = gitCommitHash(repoRoot: matterRoot)

        // Spawn `hexa run verify/run_all.hexa` from the hexa-matter
        // repo root (run_all's `_resolve_root` checks $OLDPWD / $PWD
        // for hexa.toml, so cwd must be the repo).
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: hexaPath)
        proc.arguments = ["run", runAll]
        proc.currentDirectoryURL = URL(fileURLWithPath: matterRoot, isDirectory: true)
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        var stdoutText = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            stdoutText = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — hexa 실행 실패: "
                + "\(error.localizedDescription) (g3).")
            return MatterAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the aggregator's per-script outcome from stdout.
        // Format (verify/run_all.hexa lines 86-95):
        //   "  → verify/<name>.hexa PASS"
        //   "  → verify/<name>.hexa FAIL (rc=...)"
        let perScript = parsePerScript(stdoutText)
        // The aggregator's summary line: "  N/M scripts passed".
        let (passed, total) = parseSummary(stdoutText) ?? (
            perScript.filter { $0.passed }.count, perScript.count)

        // Echo the most informative tail of run_all output for the
        // chat panel — but cap to keep the chat readable.
        let tail = lastLines(stdoutText, 8)
        lines.append("hexa run verify/run_all.hexa — exit \(exitCode)")
        if !tail.isEmpty { lines.append(tail) }

        // Honesty gate: GATE_CLOSED_MEASURED only if (a) exit 0 AND
        // (b) every subscript PASSed AND (c) we captured a commit.
        let allPassed = (passed == total && total > 0)
        let runSucceeded = (exitCode == 0 && allPassed)
        let producerCommit = commitHash ?? "unknown"
        let pinnable = (commitHash != nil)

        let gate: F1F2Record.MeasurementGate =
            (runSucceeded && pinnable) ? .closedMeasured : .open
        let absorbed = (gate == .closedMeasured)
        var caveats: [String] = []
        if !runSucceeded {
            caveats.append("hexa-matter run_all 가 PASS 가 아님 "
                + "(\(passed)/\(total) scripts passed, exit \(exitCode)) "
                + "— measurement_gate = GATE_OPEN (g3).")
        }
        if !pinnable {
            caveats.append("hexa-matter 커밋 해시 캡처 실패 — producer 를 "
                + "특정 commit 에 핀할 수 없어 measurement_gate = GATE_OPEN "
                + "(g3 — 정직 갭, hexa-matter 가 .git 인지 확인하세요).")
        }
        if runSucceeded && pinnable {
            caveats.append("matter parity = hexa-matter SSOT 의 closure-"
                + "invariant aggregator (spec_presence · lattice_arithmetic "
                + "· real_limits_anchor · closure_consistency) — "
                + "documentation/anchor cross-check 이며 물리적 시료 "
                + "측정 아님 (rfc_002 §4 spirit, g3).")
            caveats.append("absorbed=true 의 의미: 'demiurge 가 hexa-matter "
                + "의 측정 사실을 commit-pinned record 로 흡수' (D17 — "
                + "hexa-matter 가 owner, demiurge 는 consumer).")
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        // record_id: matter_parity_<utc-compact>
        let stamp = iso.replacingOccurrences(of: ":", with: "")
            .replacingOccurrences(of: "-", with: "")
        let recordId = "matter_parity_\(stamp)"

        let record = MatterRecord(
            interface: "hexa-matter:verify:closure-aggregator",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            entryScript: "verify/run_all.hexa",
            totalScripts: total,
            passedScripts: passed,
            perScript: perScript,
            exitCode: Int(exitCode),
            provenance: MatterProvenance(
                absorbed: absorbed,
                producer: "hexa_matter@\(producerCommit)",
                measurementGate: gate,
                scopeCaveats: caveats))

        // Persist under exports/matter/parity/<recordId>.json.
        do {
            try FileManager.default.createDirectory(
                at: parityRecordsRoot, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ matter parity dir mkdir 실패: \(error.localizedDescription)")
            return MatterAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        let dest = parityRecordsRoot.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ matter record JSON 쓰기 실패: \(error.localizedDescription)")
            return MatterAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        lines.append("---")
        lines.append("📸 matter parity record → exports/matter/parity/\(recordId).json")
        let gateGlyph = gate.plainGlyph
        let gateLabel = gate.displayLabel
        let absorbedStr = absorbed ? "true" : "false"
        lines.append("   \(gateGlyph) \(gateLabel) · absorbed=\(absorbedStr) · "
            + "producer=hexa_matter@\(producerCommit) · "
            + "\(passed)/\(total) scripts passed")
        if !runSucceeded || !pinnable {
            lines.append("⏳ honest gap — 위 caveats 참조 (g3 — silent success 금지).")
        }
        return MatterAnalyzeResult(
            ok: runSucceeded && pinnable,
            lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// Parse `  → verify/<name>.hexa PASS|FAIL` lines from run_all stdout.
    private static func parsePerScript(_ text: String) -> [MatterRecord.SubscriptResult] {
        var out: [MatterRecord.SubscriptResult] = []
        for raw in text.split(separator: "\n") {
            let line = raw.trimmingCharacters(in: .whitespaces)
            guard line.hasPrefix("→ verify/") else { continue }
            // "→ verify/foo.hexa PASS" or "→ verify/foo.hexa FAIL (rc=...)"
            let after = String(line.dropFirst("→ ".count))
            // First token = script path; trailing PASS/FAIL.
            let parts = after.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            guard parts.count == 2 else { continue }
            let script = String(parts[0])
            let verdict = String(parts[1])
            let passed = verdict.hasPrefix("PASS")
            out.append(MatterRecord.SubscriptResult(script: script, passed: passed))
        }
        return out
    }

    /// Parse "  N/M scripts passed" summary from run_all stdout.
    private static func parseSummary(_ text: String) -> (Int, Int)? {
        for raw in text.split(separator: "\n") {
            let line = raw.trimmingCharacters(in: .whitespaces)
            guard line.hasSuffix("scripts passed"),
                  let slash = line.firstIndex(of: "/") else { continue }
            let lhs = line[line.startIndex..<slash]
                .trimmingCharacters(in: .whitespaces)
            let afterSlash = line.index(after: slash)
            // Take digits after `/` up to the next space.
            let restRaw = line[afterSlash...]
            let rest = restRaw.split(separator: " ").first.map(String.init) ?? ""
            if let n = Int(lhs), let m = Int(rest) {
                return (n, m)
            }
        }
        return nil
    }

    /// Last `n` lines of `text`, joined by newline — empty if blank.
    private static func lastLines(_ text: String, _ n: Int) -> String {
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false)
        guard lines.count > n else { return text.trimmingCharacters(in: .whitespacesAndNewlines) }
        return lines.suffix(n).joined(separator: "\n")
    }

    /// Find a hexa binary — same resolution as ActionDispatch.locateHexa
    /// but local (DemiurgeCore loaders are siblings, no cross-file
    /// private leak). Returns nil if none is executable.
    private static func locateHexa() -> String? {
        let fm = FileManager.default
        let home = NSString(string: "~").expandingTildeInPath
        let candidates = [
            "\(home)/core/hexa-lang/hexa",
            "\(home)/.hx/bin/hexa",
            "/usr/local/bin/hexa",
            "/opt/homebrew/bin/hexa",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "hexa"]
        let pipe = Pipe()
        proc.standardOutput = pipe
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

    /// `git rev-parse --short HEAD` in `repoRoot` — nil if not a repo
    /// or git is unavailable. Used to pin the producer in provenance.
    private static func gitCommitHash(repoRoot: String) -> String? {
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["git", "-C", repoRoot, "rev-parse", "--short", "HEAD"]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = Pipe() // swallow stderr
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            if proc.terminationStatus != 0 { return nil }
            let out = (String(data: data, encoding: .utf8) ?? "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            return out.isEmpty ? nil : out
        } catch {
            return nil
        }
    }
}
