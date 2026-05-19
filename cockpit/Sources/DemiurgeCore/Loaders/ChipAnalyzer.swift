// ChipAnalyzer — θ-2 engine tool for `chip + analyze` (D56;
// cohort-round producer, no standalone PLAN κ entry — post-merge
// reconstructed).
//
// Spawns the hexa-native booksim oracle dispatch (`hexa run
// stdlib/booksim/booksim.hexa`) — the dispatcher self-test exercises
// `cmd_oracle` as one of its 8 checks (booksim.hexa:492), emitting
// the Leighton analytic lower bounds for the canonical 8×8 / n=64
// reference (d4 mesh + d6 hex). We parse the oracle stdout lines:
//
//     booksim oracle — Leighton analytic bounds (8x8, n=64):
//       d4 mesh: bisection_lower=8 diameter_lower=14
//       d6 hex : bisection_lower=8 diameter_lower=14
//       cite: Leighton 1984 Thm 2 (DOI 10.1007/BF01744433) + …
//
// and persist a typed `ChipAnalyzeRecord` under
// `exports/chip/noc/analyze/<recordId>.json`.
//
// Why `analyze` and not `verify` (D53 / D56):
//   • `verify` in demiurge's 7-verb spine = 측정으로 확인 — bench/sim
//     wire-latency parity (booksim cmd_measure F1F2 records live there).
//   • `analyze` (해석⟲) = "설계가 잘 됐는지 점검하고 따져봐요" — the
//     Leighton bound IS an analytic floor check: any measured F1F2
//     record must clear it. Best semantic fit (mirrors matter+analyze).
//
// HONESTY (g3) — see D56 + record scope_caveats:
//   • GATE_CLOSED_MEASURED is LEGITIMATE here — the Leighton bound is
//     a mathematical theorem (Leighton 1984), and the oracle dispatch
//     IS that verification. "측정" = analytic verification of an
//     algebraic lower bound, not a wire clocking.
//   • absorbed = true is LEGITIMATE — `stdlib/booksim/leighton.hexa`
//     IS hexa-native; no external library is being absorbed (mirrors
//     matter+analyze stance, D17: when hexa-native code IS the
//     producer, "absorbed" measures hexa-lang's own claim).
//   • scope_caveats MUST surface that the bound is mathematical —
//     NOT a substitute for cmd_measure's full-curve wire-latency
//     parity. The record IS the floor any F1F2 record must clear.
//   • If `hexa` is missing OR booksim.hexa is missing OR the oracle
//     lines don't parse OR exit != 0 OR the cite line is empty,
//     return ok=false with no record. Silent success forbidden.

import Foundation

/// One run of the chip analyzer — kept as plain text + ID list so
/// cockpit chat + CLI both pretty-print the same lines (D50).
public struct ChipAnalyzeResult: Sendable {
    /// Did the oracle dispatch succeed AND was a record persisted?
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

public enum ChipAnalyzer {

    /// Default location for chip-analyze records — sibling of
    /// `chip/noc/f1f2/records/`, `matter/parity/`, `sscb/transient/`.
    public static let analyzeRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("chip/noc/analyze", isDirectory: true)

    /// Run `hexa run stdlib/booksim/booksim.hexa` (which exercises
    /// `cmd_oracle` as part of the dispatcher self-test, booksim.hexa
    /// L492), parse the Leighton bound lines, and persist a typed
    /// `ChipAnalyzeRecord`. Idempotent — each call writes a fresh
    /// timestamp-keyed record under `exports/chip/noc/analyze/`.
    public static func runAnalyze() -> ChipAnalyzeResult {
        var lines: [String] = []
        let home = NSString(string: "~").expandingTildeInPath
        let hexaLangRoot = "\(home)/core/hexa-lang"
        let booksim = "\(hexaLangRoot)/stdlib/booksim/booksim.hexa"

        guard let hexaPath = locateHexa() else {
            lines.append("⏳ engine tool gap — `hexa` 실행 파일을 PATH 또는 "
                + "~/core/hexa-lang/hexa 에서 찾지 못했습니다. chip + "
                + "analyze 는 booksim.hexa 의 cmd_oracle dispatch 를 "
                + "spawn 해야 합니다 (g3 — silent success 금지).")
            return ChipAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard FileManager.default.fileExists(atPath: booksim) else {
            lines.append("⏳ engine tool gap — booksim.hexa 를 찾지 못했습니다 "
                + "(\(booksim)). chip + analyze 는 hexa-lang stdlib 의 "
                + "booksim 모듈을 필요로 합니다 (D17 — hexa-lang 가 owner). "
                + "(g3).")
            return ChipAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let commitHash = gitCommitHash(repoRoot: hexaLangRoot)

        // Spawn `hexa run booksim.hexa` from the hexa-lang repo root
        // so any `use` paths resolve. main() runs the dispatcher
        // self-test, which calls cmd_oracle (line 492) and emits the
        // Leighton bound lines to stdout.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: hexaPath)
        proc.arguments = ["run", booksim]
        proc.currentDirectoryURL = URL(fileURLWithPath: hexaLangRoot,
                                       isDirectory: true)
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
            return ChipAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the oracle's three signature lines.
        let parsed = parseOracle(stdoutText)

        lines.append("hexa run booksim.hexa — exit \(exitCode)")
        if let n = parsed.nNodes {
            lines.append("Leighton oracle (n=\(n)):")
        }
        for b in parsed.bounds {
            lines.append("  \(b.topology): bisection_lower="
                + "\(b.bisectionLower) diameter_lower=\(b.diameterLower)")
        }
        if !parsed.cite.isEmpty {
            lines.append("cite: \(parsed.cite)")
        }

        // Honesty gate: GATE_CLOSED_MEASURED only if (a) exit 0 AND
        // (b) we parsed both topologies' bounds AND (c) we have the
        // cite line AND (d) we captured a hexa-lang commit hash.
        let parsedOK = (parsed.bounds.count == 2
                        && !parsed.cite.isEmpty
                        && parsed.nNodes != nil)
        let runSucceeded = (exitCode == 0 && parsedOK)
        let producerCommit = commitHash ?? "unknown"
        let pinnable = (commitHash != nil)

        let gate: F1F2Record.MeasurementGate =
            (runSucceeded && pinnable) ? .closedMeasured : .open
        let absorbed = (gate == .closedMeasured)

        var caveats: [String] = []
        if !runSucceeded {
            caveats.append("booksim oracle dispatch 가 PASS 가 아님 "
                + "(exit \(exitCode), bounds_parsed=\(parsed.bounds.count)/2) "
                + "— measurement_gate = GATE_OPEN (g3).")
        }
        if !pinnable {
            caveats.append("hexa-lang 커밋 해시 캡처 실패 — producer 를 "
                + "특정 commit 에 핀할 수 없어 measurement_gate = GATE_OPEN "
                + "(g3 — 정직 갭, ~/core/hexa-lang 가 .git 인지 확인).")
        }
        if runSucceeded && pinnable {
            caveats.append("Leighton 하한은 **수학적 사실** (Leighton 1984 "
                + "Thm 2 / Dally & Towles PPIN 2004 §3.2-3.3) — oracle "
                + "dispatch 는 그 algebraic 표현을 평가할 뿐이지 NoC wire "
                + "를 실제 clocking 하지 않음. record 는 cmd_measure 의 "
                + "full-curve wire-latency parity 의 *대체*가 아니라 "
                + "*floor* — 모든 F1F2 record 가 이 bound 를 만족해야 함 "
                + "(rfc_001 §7.3 / §8, g3).")
            caveats.append("scope = 8×8 / n=64 reference 만 (d4 mesh + d6 "
                + "hex 두 토폴로지). 다른 n / 다른 topology shape (torus, "
                + "fat-tree …) 은 별도 oracle 호출이 필요 — 본 record 가 "
                + "covers 하지 않음.")
            caveats.append("absorbed=true 의 의미: 'hexa-native "
                + "stdlib/booksim/leighton.hexa 가 producer' (D17 — "
                + "external library 가 들어오지 않음, 수학 자체가 "
                + "hexa-lang 의 closed form). matter+analyze 와 동일 "
                + "stance: hexa-native code 가 producer 면 absorbed=true "
                + "가능 (외부 substrate 의존 0).")
            caveats.append("real chip 의 wire latency 측정과는 별개 게이트 "
                + "— 이 record 는 *bisection / diameter* 하한이지 *delay* "
                + "측정이 아님. delay 측정은 booksim cmd_measure 의 F1F2 "
                + "record 가 담당, 본 record 는 cmd_measure 가 emit 한 "
                + "값이 위배되지 않는지의 cross-floor (g3).")
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        // record_id: chip_analyze_leighton_<utc-compact>
        let stamp = iso.replacingOccurrences(of: ":", with: "")
            .replacingOccurrences(of: "-", with: "")
        let recordId = "chip_analyze_leighton_\(stamp)"

        let provenance = ChipAnalyzeProvenance(
            absorbed: absorbed,
            producer: "hexa_native_booksim_oracle@\(producerCommit)",
            measurementGate: gate,
            scopeCaveats: caveats)

        let record = ChipAnalyzeRecord(
            interface: "demiurge:chip:noc:analyze-leighton",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            nNodes: parsed.nNodes ?? 0,
            bounds: parsed.bounds,
            derivationCite: parsed.cite,
            exitCode: Int(exitCode),
            provenance: provenance)

        // Persist under exports/chip/noc/analyze/<recordId>.json.
        do {
            try FileManager.default.createDirectory(
                at: analyzeRecordsRoot, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ chip analyze dir mkdir 실패: \(error.localizedDescription)")
            return ChipAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        let dest = analyzeRecordsRoot.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ chip analyze record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return ChipAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        lines.append("---")
        lines.append("📸 chip analyze record → exports/chip/noc/analyze/"
            + "\(recordId).json")
        let gateGlyph = gate.plainGlyph
        let gateLabel = gate.displayLabel
        let absorbedStr = absorbed ? "true" : "false"
        lines.append("   \(gateGlyph) \(gateLabel) · absorbed=\(absorbedStr) · "
            + "producer=hexa_native_booksim_oracle@\(producerCommit)")
        if !runSucceeded || !pinnable {
            lines.append("⏳ honest gap — 위 caveats 참조 (g3 — silent success 금지).")
        } else {
            lines.append("   scope_caveat: 수학적 하한 (Leighton 1984) — "
                + "real chip wire latency 측정 아님 (g3).")
        }
        return ChipAnalyzeResult(
            ok: runSucceeded && pinnable,
            lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    private struct ParsedOracle {
        var nNodes: Int? = nil
        var bounds: [ChipLeightonBounds] = []
        var cite: String = ""
    }

    /// Extract the four lines emitted by `cmd_oracle` from the
    /// merged hexa-run stdout:
    ///   `booksim oracle — Leighton analytic bounds (8x8, n=N):`
    ///   `  d4 mesh: bisection_lower=B diameter_lower=D`
    ///   `  d6 hex : bisection_lower=B diameter_lower=D`
    ///   `  cite: …`
    /// Tolerant of surrounding noise — the dispatcher self-test
    /// emits other commands' output as well, we only key on these
    /// prefixes.
    private static func parseOracle(_ text: String) -> ParsedOracle {
        var out = ParsedOracle()
        // Track whether we are *inside* an oracle block (some other
        // commands print look-alike lines; only count lines that
        // follow the header until cite).
        var inBlock = false
        for raw in text.components(separatedBy: "\n") {
            let line = raw
            if line.contains("booksim oracle —") || line.contains("booksim oracle ?") {
                inBlock = true
                // Extract `n=NN` from header — accept any digits.
                if let n = extractNNodes(from: line) {
                    out.nNodes = n
                }
                continue
            }
            if !inBlock { continue }
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            // d4 / d6 line — "d4 mesh:" or "d6 hex :" prefix.
            if let colon = trimmed.firstIndex(of: ":"),
               trimmed.hasPrefix("d4") || trimmed.hasPrefix("d6") {
                let topology = String(trimmed[trimmed.startIndex..<colon])
                    .trimmingCharacters(in: .whitespaces)
                let rest = String(trimmed[trimmed.index(after: colon)...])
                if let bis = extractInt(rest, key: "bisection_lower="),
                   let dia = extractInt(rest, key: "diameter_lower=") {
                    out.bounds.append(ChipLeightonBounds(
                        topology: topology,
                        bisectionLower: bis,
                        diameterLower: dia))
                }
                continue
            }
            if trimmed.hasPrefix("cite:") {
                let after = String(trimmed.dropFirst("cite:".count))
                out.cite = after.trimmingCharacters(in: .whitespaces)
                inBlock = false  // cite closes the oracle block
            }
        }
        return out
    }

    /// "(8x8, n=64)" → 64.
    private static func extractNNodes(from header: String) -> Int? {
        guard let r = header.range(of: "n=") else { return nil }
        let after = header[r.upperBound...]
        var digits = ""
        for ch in after {
            if ch.isNumber { digits.append(ch) } else { break }
        }
        return Int(digits)
    }

    /// "bisection_lower=8 diameter_lower=14" + "bisection_lower=" -> 8.
    private static func extractInt(_ text: String, key: String) -> Int? {
        guard let r = text.range(of: key) else { return nil }
        let after = text[r.upperBound...]
        var digits = ""
        for ch in after {
            if ch.isNumber { digits.append(ch) } else { break }
        }
        return Int(digits)
    }

    /// Find a hexa binary — same resolution as MatterAnalyzer.locateHexa
    /// (DemiurgeCore loaders are siblings, no cross-file private leak).
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

    /// `git rev-parse --short HEAD` in `repoRoot` — nil if not a repo.
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
