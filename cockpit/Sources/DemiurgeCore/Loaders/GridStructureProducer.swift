// GridStructureProducer — θ-2 engine tool for `grid + structure`
// (D57; cohort-round producer, no standalone PLAN κ entry — post-merge
// reconstructed).
//
// The SECOND cohort domain (after κ-34 / D55's sscb+analyze ngspice
// producer) wired to a real measuring engine tool. NetworkX 3.2.1 is
// the producer; demiurge spawns it via Python and persists the graph-
// theoretic measurements as a typed GridRecord.
//
// Architecture (mirrors SSCBProducer):
//   1. locate `python3` (env shebang — networkx ships with /usr/bin
//      python3 on macOS; users can install with pip3 --user)
//   2. locate `cockpit/scripts/grid_networkx.py`
//   3. spawn `python3 grid_networkx.py <output_dir>` — Python builds
//      the IEEE 14-bus graph, computes metrics, writes .gml + .meta.json
//   4. parse the `GRID_NETWORKX_RESULT <json>` summary line from stderr
//   5. verify the .gml / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `GridRecord` under
//      `exports/grid/structure/<stamp>/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "networkx@<version>" — pins the library, NOT the
//     fabric. The TOPOLOGY (IEEE 14-bus) is a canonical published
//     reference (Christie 1962, UW Power Systems Test Case Archive).
//     The METRICS are deterministic mathematical facts about that
//     topology — so measurement_gate = GATE_CLOSED_MEASURED is
//     HONEST here (different from SSCB which stays GATE_OPEN because
//     the *circuit* is plausible-not-absorbed). The graph IS the
//     measurement, same epistemic class as a F1F2 record.
//   • absorbed = false ALWAYS. NetworkX is an EXTERNAL library, not
//     absorbed into hexa-lang stdlib (no `hexa-graph` yet). The flip
//     happens elsewhere, never here.
//   • IEEE 14-bus is a POWER-GRID test case; demiurge's `grid` domain
//     is AI DATACENTER fabric — this producer proves the WIRING
//     (cohort producer #2) on a canonical graph, NOT a real DC
//     fat-tree manifest. Caveat surfaced honestly on every record.
//   • If python3 is missing OR networkx import fails OR the summary
//     JSON does not parse, returns ok=false and writes no record.
//     Silent success forbidden.

import Foundation

/// One run of the grid+structure producer — kept as plain text + a
/// record ID so cockpit chat + CLI pretty-print identically (D50).
public struct GridStructureResult: Sendable {
    /// Did the producer report ok=true AND was a record written?
    public let ok: Bool
    /// Newline-joined lines for stdout / chat panel.
    public let lines: [String]
    /// The new record ID, if a record was written.
    public let newRecordID: String?

    public init(ok: Bool, lines: [String], newRecordID: String?) {
        self.ok = ok
        self.lines = lines
        self.newRecordID = newRecordID
    }

    public var text: String { lines.joined(separator: "\n") }
}

public enum GridStructureProducer {

    /// Default location for grid topology-structure records — sibling
    /// of `sscb/transient/`, `component/geometry/`, `matter/parity/`.
    public static let structureRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("grid/structure", isDirectory: true)

    /// Default candidate paths for `python3` — macOS system python
    /// ships networkx 3.2.1 in the user's site-packages or stdlib
    /// (verified at script-spawn time via the Python import).
    private static let pythonCandidates: [String] = [
        "/usr/bin/python3",
        "/opt/homebrew/bin/python3",
        "/usr/local/bin/python3",
    ]

    /// Locate the python3 binary — nil if not installed (honest gap).
    public static func locatePython3() -> String? {
        let fm = FileManager.default
        for c in pythonCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // PATH fallback via `which`.
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

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. Migrated 2026-05-20 in the D61
    /// batch-migration round
    /// from `cockpit/scripts/grid_networkx.py` (born in worktree
    /// pre-D61; lifted to hexa-lang stdlib at consolidation).
    public static func locateScript() -> String? {
        let path = NSString(
            string: "~/core/hexa-lang/stdlib/grid/networkx_basics.py"
        ).expandingTildeInPath
        return FileManager.default.fileExists(atPath: path) ? path : nil
    }

    /// Run `python3 grid_networkx.py <structureRecordsRoot>/<stamp>/`
    /// and persist one `GridRecord` per call. Each call writes into
    /// its own timestamped subdirectory so consecutive runs do not
    /// stomp each other's .gml / .meta.json artifacts.
    public static func runStructure() -> GridStructureResult {
        var lines: [String] = []

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — `python3` 를 찾지 못했습니다 "
                + "(/usr/bin/python3 또는 brew). grid + structure 는 "
                + "NetworkX 의 graph 분석을 producer 로 사용합니다 "
                + "(g3 — silent success 금지).")
            return GridStructureResult(ok: false, lines: lines, newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — grid_networkx.py 를 찾지 못했습니다 "
                + "(cockpit/scripts/). 본 셀은 producer 필수 (g3).")
            return GridStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/grid/structure/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = structureRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ grid structure dir mkdir 실패: \(error.localizedDescription)")
            return GridStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Spawn python3 with the script — networkx import happens
        // inside the script (honest failure path if missing).
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // GRID_NETWORKX_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 grid_networkx.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return GridStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Parse the GRID_NETWORKX_RESULT <json> line.
        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python3 = \(py)")
        lines.append("python3 grid_networkx.py — exit \(exitCode), "
            + "nodes=\(summary.nodeCount ?? 0), edges=\(summary.edgeCount ?? 0)")
        if let v = summary.networkxVersion {
            lines.append("networkx version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["gml", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — grid producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return GridStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Build the typed record. Topology + measurements come from
        // re-reading the meta.json (the Python side is the SSOT for
        // the numbers — Swift just witnesses + types).
        let metaName = verified["meta"] ?? "grid_ieee14_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(GridProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) — record 미작성 (g3).")
            return GridStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "grid_structure_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let nxv = summary.networkxVersion ?? meta.networkxVersion ?? "unknown"
        let caveats: [String] = [
            "IEEE 14-bus 는 power-grid 표준 reference (Christie 1962 / "
            + "UW Power Systems Test Case Archive / pglib-opf case14). "
            + "demiurge `grid` 도메인은 AI 데이터센터 fabric — 본 producer "
            + "는 cohort producer #2 의 WIRING 을 canonical graph 위에 "
            + "증명, 실제 hyperscaler DC fat-tree manifest 아님 (g3).",
            "bisection_min_cut_edges 는 LINK 수 (정수) — Gbps 아님. "
            + "SerDes channel 모델·congestion control 가정 없음. 실제 "
            + "DC bisection bandwidth gate 는 ns-3/SST (domains/grid.md "
            + "§2 ANALYZE) + HFSS/Sigrity SI (§4 gap) 후속 phase.",
            "measurement_gate = GATE_CLOSED_MEASURED — graph metrics "
            + "는 deterministic 수학적 사실 (NetworkX IEEE-754 솔버). "
            + "F1F2 chip record 와 동일한 epistemic class — 단 SCOPE 는 "
            + "POWER-GRID reference (위 caveat #1 참조).",
            "absorbed=false 영구 — NetworkX 는 외부 Python 라이브러리, "
            + "hexa-lang stdlib 미흡수. `hexa-graph` stdlib 가 들어와 "
            + "동일 metric 을 수치 동일 재현하면 그때 absorbed flip "
            + "(이번 phase 는 scope out, D17 mirror — 외부 도구가 owner, "
            + "demiurge 는 consumer).",
        ]

        let record = GridRecord(
            interface: "demiurge:grid:structure-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            edgesSha256_16: meta.edgesSha256_16,
            networkxVersion: nxv,
            topology: meta.topology,
            measurements: meta.measurements,
            computeElapsedS: meta.computeElapsedS,
            artifacts: verified,
            provenance: GridProvenance(
                absorbed: false,
                producer: "networkx@\(nxv)",
                measurementGate: .closedMeasured,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ grid record JSON 쓰기 실패: \(error.localizedDescription)")
            return GridStructureResult(ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output for the user.
        let m = meta.measurements
        lines.append("---")
        lines.append("📸 grid structure record → exports/grid/structure/"
            + "\(stamp)/\(recordId).json")
        let diameterStr = m.diameter.map { String($0) } ?? "n/a"
        let avgSpStr: String
        if let a = m.avgShortestPathHops {
            avgSpStr = String(format: "%.3f", a)
        } else {
            avgSpStr = "n/a"
        }
        let bisectionStr = m.bisectionMinCutEdges.map { String($0) } ?? "n/a"
        lines.append("   IEEE 14-bus · nodes=\(m.nodeCount) · "
            + "edges=\(m.edgeCount) · diameter=\(diameterStr) · "
            + "avg_sp=\(avgSpStr) hops · bisection=\(bisectionStr) links")
        if let top = m.topBetweenness.first {
            lines.append(String(format: "   top betweenness: bus %d "
                + "(score %.3f) · producer = networkx@%@",
                top.node, top.score, nxv))
        }
        lines.append("   ✅ GATE_CLOSED_MEASURED · absorbed=false — "
            + "수학적 그래프 사실 이지만 SCOPE 는 power-grid reference "
            + "(AI DC fabric 아님, scope_caveats 4종 참조).")

        return GridStructureResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `cockpit/scripts/grid_networkx.py::main`.
    private struct GridProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let edgesSha256_16: String
        let networkxVersion: String?
        let topology: GridTopology
        let measurements: GridMeasurements
        let computeElapsedS: Double?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case edgesSha256_16 = "edges_sha256_16"
            case networkxVersion = "networkx_version"
            case topology
            case measurements
            case computeElapsedS = "compute_elapsed_s"
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var networkxVersion: String? = nil
        var nodeCount: Int? = nil
        var edgeCount: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `GRID_NETWORKX_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "GRID_NETWORKX_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["networkx_version"] as? String { out.networkxVersion = s }
            if let n = obj["node_count"] as? Int { out.nodeCount = n }
            if let n = obj["edge_count"] as? Int { out.edgeCount = n }
            if let arts = obj["artifacts"] as? [String: String] {
                out.artifacts = arts
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
