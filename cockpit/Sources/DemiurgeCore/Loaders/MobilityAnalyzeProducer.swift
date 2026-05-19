// MobilityAnalyzeProducer — θ-2 engine tool for `mobility + analyze`
// (cohort round, no standalone PLAN κ / D-block — post-merge reconstructed).
// A cohort domain (out of the 13 surveyed in
// domains/*.md) wired to a real measuring engine tool — after sscb
// (κ-34, ngspice) and energy (κ-35, pvlib). FIRST autonomous-driving
// cell.
//
// Architecture (mirrors EnergyAnalyzeProducer + SSCBProducer):
//   1. locate `~/core/hexa-lang/stdlib/mobility/road_network.py` —
//      D61 g_demiurge_pointer_only: the script SSOT lives in
//      hexa-lang, NEVER in cockpit/scripts/. demiurge holds only
//      this spawn wrapper.
//   2. locate brew python3 (the osmnx + networkx + shapely + pyproj
//      install lands there on macOS — explicit resolver because the
//      Xcode-bundled python3 on inherited PATH has none of them).
//   3. spawn `python3 road_network.py <output_dir>` — Python wraps
//      the osmnx ModelChain so the edges.csv + meta.json all live
//      in <output_dir> with no shell quoting hazards.
//   4. parse the `MOBILITY_ROAD_NETWORK_RESULT <json>` summary line
//      from stderr.
//   5. verify the .edges.csv / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion).
//   6. emit one typed `MobilityRecord` under
//      `exports/mobility/road/<stamp>/<recordId>.json`.
//
// HONEST (g3 — non-negotiable):
//   * producer = "osmnx@<version>" — pins the library, not the
//     road-network *data*. The current implementation builds a
//     synthetic 10x10 Manhattan grid (deterministic, offline). The
//     measurements ARE real graph statistics OF that synthetic
//     grid. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them to
//     closedMeasured — that requires real OSM extract + traffic
//     demand calibration + validated micro-simulation.
//   * If osmnx/networkx are missing OR the Python script crashes
//     OR the summary JSON doesn't parse, returns ok=false and
//     writes no record. Silent success is forbidden.

import Foundation

/// One run of the mobility producer — kept as plain text + a record
/// ID so cockpit chat + CLI pretty-print identically (D50).
public struct MobilityAnalyzeResult: Sendable {
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

public enum MobilityAnalyzeProducer {

    /// Default location for mobility road-graph records — sibling of
    /// `energy/pv/`, `sscb/transient/`, `matter/parity/` etc.
    public static let roadRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("mobility/road", isDirectory: true)

    /// Locate `~/core/hexa-lang/stdlib/mobility/road_network.py` —
    /// D61 (g_demiurge_pointer_only): the script lives in hexa-lang,
    /// demiurge holds only this spawn wrapper. NEVER look under
    /// `cockpit/scripts/` for this producer.
    public static func locateScript() -> String? {
        let fm = FileManager.default
        let path = NSString(
            string: "~/core/hexa-lang/stdlib/mobility/road_network.py")
            .expandingTildeInPath
        if fm.fileExists(atPath: path) {
            return path
        }
        return nil
    }

    /// Locate a Python 3 binary that has osmnx + networkx installed —
    /// prefer Homebrew's `/opt/homebrew/bin/python3` (where `pip
    /// install osmnx` lands on macOS), then PATH fallback. The
    /// Xcode-bundled `python3` (`/Applications/Xcode.app/.../python3`)
    /// does NOT have osmnx and `/usr/bin/env python3` resolves to
    /// it first in DemiurgeCLI's inherited PATH — so an explicit
    /// resolver is required (g3 — silent fallback to a python without
    /// osmnx would surface as a confusing ModuleNotFoundError).
    public static func locatePython3() -> String? {
        let fm = FileManager.default
        let candidates = [
            "/opt/homebrew/bin/python3",
            "/usr/local/bin/python3",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
            return c
        }
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

    /// Run `python3 road_network.py <roadRecordsRoot>/<stamp>/` and
    /// persist one `MobilityRecord` per call. Each call writes into
    /// its own timestamped subdirectory so consecutive runs do not
    /// stomp each other's .edges.csv / .meta.json artifacts.
    public static func runAnalyze() -> MobilityAnalyzeResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — road_network.py 를 찾지 못했습니다 "
                + "(~/core/hexa-lang/stdlib/mobility/). D61 — script SSOT 는 "
                + "hexa-lang/stdlib/<domain>/ 에 있어야 합니다 (g3 — silent "
                + "success 금지).")
            return MobilityAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = roadRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ mobility road dir mkdir 실패: \(error.localizedDescription)")
            return MobilityAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). osmnx + networkx "
                + "import 가 필요합니다 (g3 — silent success 금지).")
            return MobilityAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // MOBILITY_ROAD_NETWORK_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 road_network.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return MobilityAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts where !rel.isEmpty {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("python3 = \(py)")
        lines.append("python3 road_network.py — exit \(exitCode), "
            + "nodes=\(summary.nodeCount ?? 0), "
            + "edges=\(summary.edgeCount ?? 0)")
        if let v = summary.osmnxVersion {
            lines.append("osmnx version: \(v)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: " + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["edges_csv", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — mobility producer ok=\(summary.ok), "
                + "exit=\(exitCode), present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 6)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return MobilityAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let metaName = verified["meta"]
            ?? "road_network_manhattan_grid_10x10_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                MobilityProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 (\(metaURL.path)) "
                + "— record 미작성 (g3).")
            return MobilityAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "mobility_road_\(stamp.replacingOccurrences(of: "-", with: ""))"
        let oxv = summary.osmnxVersion ?? meta.osmnxVersion ?? "unknown"
        let nxv = summary.networkxVersion ?? meta.networkxVersion ?? "unknown"
        let pyv = summary.pythonVersion ?? meta.pythonVersion ?? "unknown"
        let caveats: [String] = [
            "osmnx 의 road-network 분석 출력 — 숫자는 실제 "
            + "(osmnx.basic_stats + networkx.diameter 표준 알고리즘 "
            + "출력) 이지만, 분석 대상 그래프는 *합성 10x10 Manhattan "
            + "grid topology fixture* (실제 OSM extract 가 아님, "
            + "Overpass 네트워크 호출 없음). 결정론적 · 오프라인 · "
            + "cross-host 재현 가능 — g3 입장에서 record SSOT 로 "
            + "안전하지만, *실제 도시 도로망* 이라고 주장하지 않음.",
            "본 셀은 *graph topology only* — traffic flow / travel "
            + "time / vehicle simulation / SUMO micro-sim / CARLA "
            + "scenario regression 전혀 없음. domains/mobility.md §2 "
            + "의 SPECIFY/ARCHITECT/DESIGN/SYNTHESIZE/VERIFY/HANDOFF "
            + "verb 들은 본 record 의 scope 밖.",
            "measurement_gate = GATE_OPEN 영구 / absorbed=false 영구 "
            + "— osmnx MIT + 표준 그래프 알고리즘은 흡수 충분이지만, "
            + "*real-place 의 absorbed road-network data + 검증된 "
            + "traffic 모델* 이 없으므로 mobility claim 은 미흡수. "
            + "ISO 26262 / ISO 21448 SOTIF / UN R157 ALKS 안전 게이트는 "
            + "별도 (domains/mobility.md §1).",
            "real-OSM extract 흡수 (osmnx.graph_from_place, "
            + "graph_from_bbox via Overpass) 는 의도적으로 우회 — "
            + "(a) 도달 가능한 Overpass 서버 필요, (b) 시간 변동 결과 "
            + "(같은 query 도 다른 시각엔 다른 graph) 가 demiurge 의 "
            + "cross-host record drift 원칙을 깨므로. 후속 phase 가 "
            + "snapshot-pinned OSM extract + traffic demand calibration "
            + "을 들이면 흡수 후보 — 본 phase 의 scope 밖.",
        ]

        let measurements = MobilityMeasurements(
            nodeCount: meta.measurements?.nodeCount ?? 0,
            edgeCount: meta.measurements?.edgeCount ?? 0,
            intersectionCount: meta.measurements?.intersectionCount ?? 0,
            kAvg: meta.measurements?.kAvg,
            edgeLengthTotalM: meta.measurements?.edgeLengthTotalM,
            edgeLengthAvgM: meta.measurements?.edgeLengthAvgM,
            streetsPerNodeAvg: meta.measurements?.streetsPerNodeAvg,
            streetsPerNodeCounts: meta.measurements?.streetsPerNodeCounts ?? [:],
            connectedComponents: meta.measurements?.connectedComponents ?? 0,
            diameterUndirected: meta.measurements?.diameterUndirected)

        let place = meta.place ?? MobilityPlace(
            label: "unknown", originLat: 0, originLon: 0, isSynthetic: true)
        let topo = meta.topology ?? MobilityTopology(
            gridN: 0, blockLengthM: 0, model: "unknown")

        let record = MobilityRecord(
            interface: "demiurge:mobility:road-network-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            osmnxVersion: oxv,
            networkxVersion: nxv,
            pythonVersion: pyv,
            place: place,
            topology: topo,
            measurements: measurements,
            artifacts: verified,
            provenance: MobilityProvenance(
                absorbed: false,
                producer: "osmnx@\(oxv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ mobility record JSON 쓰기 실패: \(error.localizedDescription)")
            return MobilityAnalyzeResult(ok: false, lines: lines, newRecordID: nil)
        }

        lines.append("---")
        lines.append("📸 mobility road record → exports/mobility/road/"
            + "\(stamp)/\(recordId).json")
        if let kavg = measurements.kAvg,
           let diam = measurements.diameterUndirected {
            lines.append(String(format: "   nodes=%d · edges=%d · k_avg=%.2f · "
                + "diameter=%d · producer = osmnx@%@",
                measurements.nodeCount, measurements.edgeCount,
                kavg, diam, oxv))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — 표준 그래프 "
            + "알고리즘 출력 (osmnx.basic_stats) 이지만 *합성 grid* "
            + "이지 real-OSM 아님, traffic flow 0 → topology only "
            + "(g3, scope_caveats 4종 참조).")

        return MobilityAnalyzeResult(ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// The shape we parse out of the producer's `meta.json`. Kept in
    /// step with `hexa-lang/stdlib/mobility/road_network.py::main`.
    private struct MobilityProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let osmnxVersion: String?
        let networkxVersion: String?
        let pythonVersion: String?
        let place: MobilityPlace?
        let topology: MobilityTopology?
        let measurements: MeasurementsRaw?

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case osmnxVersion = "osmnx_version"
            case networkxVersion = "networkx_version"
            case pythonVersion = "python_version"
            case place
            case topology
            case measurements
        }

        struct MeasurementsRaw: Decodable {
            let nodeCount: Int
            let edgeCount: Int
            let intersectionCount: Int
            let kAvg: Double?
            let edgeLengthTotalM: Double?
            let edgeLengthAvgM: Double?
            let streetsPerNodeAvg: Double?
            let streetsPerNodeCounts: [String: Int]?
            let connectedComponents: Int
            let diameterUndirected: Int?

            enum CodingKeys: String, CodingKey {
                case nodeCount = "node_count"
                case edgeCount = "edge_count"
                case intersectionCount = "intersection_count"
                case kAvg = "k_avg"
                case edgeLengthTotalM = "edge_length_total_m"
                case edgeLengthAvgM = "edge_length_avg_m"
                case streetsPerNodeAvg = "streets_per_node_avg"
                case streetsPerNodeCounts = "streets_per_node_counts"
                case connectedComponents = "connected_components"
                case diameterUndirected = "diameter_undirected"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var osmnxVersion: String? = nil
        var networkxVersion: String? = nil
        var pythonVersion: String? = nil
        var nodeCount: Int? = nil
        var edgeCount: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `MOBILITY_ROAD_NETWORK_RESULT <json>` from the merged
    /// Python stdout/stderr and decode the JSON payload. Tolerant of
    /// any other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "MOBILITY_ROAD_NETWORK_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["osmnx_version"] as? String { out.osmnxVersion = s }
            if let s = obj["networkx_version"] as? String { out.networkxVersion = s }
            if let s = obj["python_version"] as? String { out.pythonVersion = s }
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
