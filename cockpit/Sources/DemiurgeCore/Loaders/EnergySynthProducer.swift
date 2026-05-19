// EnergySynthProducer — θ-2 engine tool for `energy + synthesize`.
// The FIRST `energy + synthesize` cell, ROI rank 5 from `inbox/notes/
// absorption-empty-cells-research-2026-05-20.md` §3 (⭐⭐⭐⭐⭐ — pure
// pip, NREL / TUB academic OSS). The SECOND energy-domain producer
// after `energy + analyze` (pvlib clear-sky, EnergyAnalyzeProducer).
//
// Architecture (mirrors EnergyAnalyzeProducer + ComponentVerifyProducer
// — D61-compliant wrapper around a hexa-lang-owned Python script):
//   1. locate `~/core/hexa-lang/stdlib/energy/pypsa_capacity.py`
//   2. locate a Python 3 binary that has pypsa + highspy + pandas +
//      numpy installed (prefer `/opt/homebrew/bin/python3` where pip
//      --user --break-system-packages lands on macOS)
//   3. spawn `python3 pypsa_capacity.py <output_dir>` — Python writes
//      the .csv + .meta.json into <output_dir>
//   4. parse the `ENERGY_PYPSA_RESULT <json>` summary line from the
//      merged stdout/stderr
//   5. verify the .csv / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `EnergySynthRecord` under
//      `exports/energy/synth/<stamp>/<recordId>.json`
//
// D61 / g_demiurge_pointer_only — script SSOT in hexa-lang/stdlib/,
// NEVER in cockpit/scripts/. demiurge ONLY witnesses + types.
//
// D72 2-layer — PyPSA stays a thin domain adapter under `stdlib/
// energy/pypsa_capacity.py`. No `kernels/power_opt/` directory yet —
// 1st consumer only; promote if a 2nd power-opt consumer (mobility
// V2G, grid+verify, energy+verify storage) appears. Pickup note on
// the demiurge side: `inbox/notes/pypsa-kernel-promotion-pickup.md`.
//
// HONEST (g3 — non-negotiable):
//   • producer = "pypsa@<ver> + HiGHS@<ver>" — pin the libraries, NOT
//     the planned portfolio. The LP IS solved to optimality, the
//     numbers ARE real PyPSA outputs. PyPSA's capacity-expansion
//     formulation is the canonical academic reference (Brown·Hörsch·
//     Schlachtberger, JORS 2018 doi:10.5334/jors.188). So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them — that requires
//     sourced NREL ATB capital-cost data + real demand profile +
//     site-measured renewable capacity factors + multi-bus AC
//     power-flow with real topology.
//   • The measurement_VALUES are real LP outputs from a working
//     PyPSA + HiGHS stack. They are useful as a *first honest witness*
//     of the capacity-expansion stack in hexa-lang/stdlib (the LP is
//     feasible + optimal), NOT an investment signoff.
//   • If pypsa / HiGHS are missing OR the Python script crashes OR
//     the summary JSON doesn't parse, returns ok=false and writes no
//     record. Silent success is forbidden.

import Foundation

/// One run of the energy-synth producer — kept as plain text + a record
/// ID so cockpit chat + CLI pretty-print identically (D50).
public struct EnergySynthResult: Sendable {
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

public enum EnergySynthProducer {

    /// Default location for energy-synth records — sibling of
    /// `energy/pv/`, `component/verify/`, `sscb/transient/`.
    public static let synthRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("energy/synth", isDirectory: true)

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. NO cockpit/scripts/ fallback
    /// (any such fallback would be a birth-violation of g_demiurge_
    /// pointer_only). Honours `HEXA_LANG_ROOT` env var so a worktree
    /// can verify before the script lands on the live tree (the
    /// override is opt-in — production paths use ~/core/hexa-lang).
    public static func locateScript() -> String? {
        let fm = FileManager.default
        if let override = ProcessInfo.processInfo.environment["HEXA_LANG_ROOT"],
           !override.isEmpty {
            let path = (override as NSString).expandingTildeInPath
                + "/stdlib/energy/pypsa_capacity.py"
            if fm.fileExists(atPath: path) { return path }
        }
        let candidate = NSString(
            string: "~/core/hexa-lang/stdlib/energy/pypsa_capacity.py"
        ).expandingTildeInPath
        if fm.fileExists(atPath: candidate) {
            return candidate
        }
        return nil
    }

    /// Locate a Python 3 binary — prefer Homebrew's `/opt/homebrew/
    /// bin/python3` (where `pip install --user --break-system-packages
    /// pypsa` lands on macOS), then PATH fallback. Same resolver shape
    /// as EnergyAnalyzeProducer / ComponentVerifyProducer.
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

    /// Run `python3 pypsa_capacity.py <synthRecordsRoot>/<stamp>/` and
    /// persist one `EnergySynthRecord` per call. Each call writes into
    /// its own timestamped subdirectory so consecutive runs do not
    /// stomp each other's .csv / .meta.json artifacts.
    public static func runSynthesize() -> EnergySynthResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — pypsa_capacity.py 를 찾지 못했습니다 "
                + "(~/core/hexa-lang/stdlib/energy/). D61 / "
                + "g_demiurge_pointer_only: producer script SSOT 는 "
                + "hexa-lang 안에 살아야 합니다 (g3 — silent success 금지).")
            return EnergySynthResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Build per-run output dir under exports/energy/synth/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = synthRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ energy synth dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return EnergySynthResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). pypsa + highspy + "
                + "pandas + numpy import 가 필요합니다 (g3 — silent "
                + "success 금지).")
            return EnergySynthResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // ENERGY_PYPSA_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 pypsa_capacity.py "
                + "실행 실패: \(error.localizedDescription) (g3).")
            return EnergySynthResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the two artifacts exist on disk (defence-in-depth).
        var verified: [String: String] = [:]
        for (kind, rel) in summary.artifacts where !rel.isEmpty {
            let url = runDir.appendingPathComponent(rel)
            if fm.fileExists(atPath: url.path),
               ((try? fm.attributesOfItem(atPath: url.path)[.size]) as? Int) ?? 0 > 0 {
                verified[kind] = rel
            }
        }

        lines.append("script = \(script)")
        lines.append("python3 = \(py)")
        lines.append("python3 pypsa_capacity.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let pv = summary.pypsaVersion, let hv = summary.highsVersion {
            lines.append("pypsa \(pv) · HiGHS \(hv)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["csv", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — energy synth producer "
                + "ok=\(summary.ok), exit=\(exitCode), "
                + "present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 8)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return EnergySynthResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Re-read the meta.json — the Python side is the SSOT for the
        // numbers; Swift just witnesses + types.
        let metaName = verified["meta"]
            ?? "single_bus_capex_4tech_168h_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                EnergySynthProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return EnergySynthResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        let recordId = "energy_synth_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let pv = summary.pypsaVersion ?? meta.pypsaVersion ?? "unknown"
        let hv = summary.highsVersion ?? meta.highsVersion ?? "unknown"
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "capital_cost 숫자는 round figures (solar 35k · wind 55k · "
            + "gas 25k EUR/MW/yr) — NREL ATB tendencies 에서 영감 받았으나 "
            + "*sourced ATB pull 이 아님*. 실제 흡수에 해당하려면 "
            + "atb.nrel.gov 에서 modelling year 의 capital_cost / "
            + "fixed_om / variable_om 을 사이트 SSOT 로 끌어와야 함 (g3).",
            "demand profile = synthetic 단일 버스 toy (주중/주말 + 아침/"
            + "저녁 피크 더블 피크, 168시간 1주). 실제 capacity-expansion "
            + "은 ERCOT / PJM / ENTSO-E 의 historical hourly 8760-시간 "
            + "load profile 또는 clustered-typical-day 표본을 사용. "
            + "본 record 의 demand 는 *deterministic synthetic*, 실측이 "
            + "아니다 (g3).",
            "renewable capacity factor = 결정론적 삼각 함수 (clear-sky "
            + "근사 + 다일 envelope 의 wind). 실제 LP 는 TMY3 / NSRDB / "
            + "ERA5 / NREL WIND 의 site-measured irradiance·wind speed "
            + "시계열을 입력으로 받음. 본 record 의 CF 는 *synthetic*, "
            + "측정이 아니다 (g3).",
            "network topology = single-bus (transmission 없음). 실제 "
            + "capacity-expansion 은 multi-bus AC power-flow (KCL/KVL + "
            + "line capacity + losses) 를 함께 푸는 SCOPF / OPF "
            + "formulation. 본 record 는 *copper-plate* 단일 버스 — "
            + "transmission constraint 의 영향을 보지 못한다 (g3).",
            "snapshot weighting = 8760/168 ≈ 52.14 (1주를 1년으로 "
            + "scale-up). 실제 planning 은 8760-h sequential 또는 "
            + "clustered-typical-day (CTD) 표본으로 storage cycling / "
            + "ramping constraint 를 보존. 본 record 의 LP 는 *aggregated "
            + "week*, week 내부의 storage / unit-commitment 동역학이 "
            + "honest 하게 단순화되어 있다 (g3).",
            "storage / unit-commitment 미모델링 — 본 record 에는 "
            + "Store / StorageUnit 객체가 없고, ramp_limit_up/_down · "
            + "min_up_time · min_down_time 등 commitment 제약이 모두 "
            + "off. 실제 시스템에서 renewable share 90%+ 의 dispatch 는 "
            + "storage 가 결정한다 — 본 record 의 dispatch 는 *upper "
            + "bound* 이지 운영 가능한 schedule 이 아니다 (g3).",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 "
            + "— PyPSA BSD-3 + HiGHS MIT 는 흡수 가능한 OSS 스택이지만, "
            + "본 LP 의 *입력 (capital_cost · demand · CF · topology)* 이 "
            + "모두 textbook / synthetic. 본 phase 의 scope 는 *PyPSA "
            + "capacity-expansion 스택이 hexa-lang/stdlib 에서 동작함을 "
            + "측정* 이지 portfolio signoff 가 아님. 흡수에 해당하려면 "
            + "(sourced ATB · 실측 demand · 실측 CF · multi-bus AC · "
            + "storage cycling · UC 제약) 6 종이 모두 record 안으로 "
            + "들어와야 한다 (g3).",
        ]

        // Build typed sub-blocks from the meta payload.
        let problem = EnergySynthProblem(
            horizonHours: meta.problem.horizonHours,
            nBuses: meta.problem.nBuses,
            nGenerators: meta.problem.nGenerators,
            nLoads: meta.problem.nLoads,
            solver: meta.problem.solver,
            formulation: meta.problem.formulation)

        let catalogue = meta.generatorsCatalogue.map { c in
            EnergySynthGeneratorSpec(
                name: c.name,
                carrier: c.carrier,
                capitalCostEurPerMwYr: c.capitalCostEurPerMwYr,
                marginalCostEurPerMwh: c.marginalCostEurPerMwh,
                availability: c.availability)
        }

        var perGen: [String: EnergySynthGeneratorResult] = [:]
        for (k, v) in meta.measurements.perGenerator {
            perGen[k] = EnergySynthGeneratorResult(
                carrier: v.carrier,
                pNomOptMw: v.pNomOptMw,
                generationMwh: v.generationMwh,
                peakMw: v.peakMw,
                capitalCostEurPerMwYr: v.capitalCostEurPerMwYr,
                marginalCostEurPerMwh: v.marginalCostEurPerMwh)
        }

        let measurements = EnergySynthMeasurements(
            rows: meta.measurements.rows,
            horizonHours: meta.measurements.horizonHours,
            totalLoadMwh: meta.measurements.totalLoadMwh,
            objectiveEur: meta.measurements.objectiveEur,
            renewableShare: meta.measurements.renewableShare,
            perGenerator: perGen)

        let record = EnergySynthRecord(
            interface: "demiurge:energy:pypsa-capacity-synth-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            pypsaVersion: pv,
            highsVersion: hv,
            pythonVersion: pyv,
            problem: problem,
            generatorsCatalogue: catalogue,
            measurements: measurements,
            artifacts: verified,
            provenance: EnergySynthProvenance(
                absorbed: false,
                producer: "pypsa@\(pv) + HiGHS@\(hv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ energy synth record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return EnergySynthResult(
                ok: false, lines: lines, newRecordID: nil)
        }

        // Headline output lines for the user.
        lines.append("---")
        lines.append("📸 energy synth record → exports/energy/synth/"
            + "\(stamp)/\(recordId).json")
        if let obj = measurements.objectiveEur,
           let share = measurements.renewableShare,
           let load = measurements.totalLoadMwh {
            lines.append(String(format:
                "   objective = %.0f EUR/yr · renewable share = %.1f %% · "
                + "load = %.0f MWh/yr",
                obj, share * 100.0, load))
        }
        // Per-tech p_nom_opt rollup for human-readable presentation.
        let sortedGen = perGen.sorted { $0.key < $1.key }
        for (name, r) in sortedGen {
            lines.append(String(format:
                "   - %@ (%@): p_nom_opt = %.1f MW · gen = %.0f MWh/yr",
                name, r.carrier, r.pNomOptMw, r.generationMwh))
        }
        lines.append("   ⏳ GATE_OPEN · absorbed=false — textbook capital_cost + "
            + "synthetic demand + single-bus, 흡수에 해당하려면 sourced "
            + "NREL ATB + 실측 demand + multi-bus AC + storage cycling "
            + "필요 (g3, scope_caveats 7종 참조).")
        // Citation pointer for the producer's underlying algorithm.
        lines.append("   citation: PyPSA — Brown·Hörsch·Schlachtberger, "
            + "JORS 2018, doi:10.5334/jors.188 (BSD-3, NREL/TUB OSS).")

        return EnergySynthResult(
            ok: true, lines: lines, newRecordID: recordId)
    }

    // MARK: - Parsing helpers (private)

    /// Shape we parse out of the producer's `meta.json`. Kept in step
    /// with `~/core/hexa-lang/stdlib/energy/pypsa_capacity.py::main`'s
    /// write of the meta file.
    private struct EnergySynthProducerMeta: Decodable {
        let ok: Bool
        let problemId: String
        let geometryId: String
        let pypsaVersion: String?
        let highsVersion: String?
        let pythonVersion: String?
        let problem: ProblemRaw
        let generatorsCatalogue: [GeneratorRaw]
        let measurements: MeasurementsRaw

        enum CodingKeys: String, CodingKey {
            case ok
            case problemId = "problem_id"
            case geometryId = "geometry_id"
            case pypsaVersion = "pypsa_version"
            case highsVersion = "highs_version"
            case pythonVersion = "python_version"
            case problem
            case generatorsCatalogue = "generators_catalogue"
            case measurements
        }

        struct ProblemRaw: Decodable {
            let horizonHours: Int
            let nBuses: Int
            let nGenerators: Int
            let nLoads: Int
            let solver: String
            let formulation: String

            enum CodingKeys: String, CodingKey {
                case horizonHours = "horizon_hours"
                case nBuses = "n_buses"
                case nGenerators = "n_generators"
                case nLoads = "n_loads"
                case solver
                case formulation
            }
        }

        struct GeneratorRaw: Decodable {
            let name: String
            let carrier: String
            let capitalCostEurPerMwYr: Double
            let marginalCostEurPerMwh: Double
            let availability: String

            enum CodingKeys: String, CodingKey {
                case name
                case carrier
                case capitalCostEurPerMwYr = "capital_cost_eur_per_mw_yr"
                case marginalCostEurPerMwh = "marginal_cost_eur_per_mwh"
                case availability
            }
        }

        struct MeasurementsRaw: Decodable {
            let rows: Int
            let horizonHours: Int
            let totalLoadMwh: Double?
            let objectiveEur: Double?
            let renewableShare: Double?
            let perGenerator: [String: GeneratorResultRaw]

            enum CodingKeys: String, CodingKey {
                case rows
                case horizonHours = "horizon_hours"
                case totalLoadMwh = "total_load_mwh"
                case objectiveEur = "objective_eur"
                case renewableShare = "renewable_share"
                case perGenerator = "per_generator"
            }
        }

        struct GeneratorResultRaw: Decodable {
            let carrier: String
            let pNomOptMw: Double
            let generationMwh: Double
            let peakMw: Double
            let capitalCostEurPerMwYr: Double
            let marginalCostEurPerMwh: Double

            enum CodingKeys: String, CodingKey {
                case carrier
                case pNomOptMw = "p_nom_opt_mw"
                case generationMwh = "generation_mwh"
                case peakMw = "peak_mw"
                case capitalCostEurPerMwYr = "capital_cost_eur_per_mw_yr"
                case marginalCostEurPerMwh = "marginal_cost_eur_per_mwh"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var pypsaVersion: String? = nil
        var highsVersion: String? = nil
        var pythonVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `ENERGY_PYPSA_RESULT <json>` from the merged Python
    /// stdout/stderr and decode the JSON payload. Tolerant of any other
    /// lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "ENERGY_PYPSA_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["pypsa_version"] as? String { out.pypsaVersion = s }
            if let s = obj["highs_version"] as? String { out.highsVersion = s }
            if let s = obj["python_version"] as? String { out.pythonVersion = s }
            if let n = obj["rows"] as? Int { out.rows = n }
            if let arts = obj["artifacts"] as? [String: String] {
                out.artifacts = arts
            }
        }
        return out
    }

    private static func lastLines(_ text: String, _ n: Int) -> String {
        let lines = text.split(separator: "\n",
                               omittingEmptySubsequences: false)
        guard lines.count > n else {
            return text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return lines.suffix(n).joined(separator: "\n")
    }
}
