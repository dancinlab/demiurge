// ComponentVerifyProducer — θ-2 engine tool for `component + verify`
// (κ-39 / D66). The SIXTH measurable-only cell crossing the engine-tool
// threshold (after component+synthesize, chip+verify, chip+synthesize,
// matter+analyze, sscb+analyze, energy+analyze, antimatter+analyze) and
// the SECOND D61-compliant-from-birth producer (after the antimatter
// producer — cohort round, no standalone PLAN κ entry)
// — the Python script SSOT lives in `~/core/hexa-lang/stdlib/component/
// gmsh_skfem.py`, NEVER in demiurge (g_demiurge_pointer_only).
//
// Architecture (mirrors AntimatterAnalyzeProducer — D61-compliant
// wrapper around a hexa-lang-owned Python script):
//   1. locate `~/core/hexa-lang/stdlib/component/gmsh_skfem.py`
//   2. locate a Python 3 binary that has gmsh + scikit-fem + numpy +
//      meshio installed (prefer `/opt/homebrew/bin/python3` where pip
//      --user --break-system-packages lands on macOS)
//   3. spawn `python3 gmsh_skfem.py <output_dir>` — Python writes the
//      .msh + .csv + .meta.json into <output_dir>
//   4. parse the `COMPONENT_GMSH_SKFEM_RESULT <json>` summary line
//      from the merged stdout/stderr
//   5. verify the .csv / .meta.json artifacts exist on disk
//      (defence-in-depth — @F f6 evidence-over-assertion)
//   6. emit one typed `ComponentVerifyRecord` under
//      `exports/component/verify/<stamp>/<recordId>.json`
//
// HONEST (g3 — non-negotiable):
//   • producer = "gmsh@<v> + scikit-fem@<v>" — pin the libraries, NOT
//     the part. The geometry is a TOY box (10×10×2 mm Si die proxy),
//     NOT a measured component STEP file from the rfc_008 chip→component
//     handoff dossier. So:
//       measurementGate = GATE_OPEN
//       absorbed = false
//     ALWAYS. There is no path here that flips them — that requires
//     a real cited component + measured material datasheet + measured
//     load case + mesh convergence study.
//   • The measurement_VALUES are real PDE outputs (ΔT, σ_vM, u_max on
//     the toy box, physically correct given the inputs). They surface
//     a *first honest thermal/structural witness* for an electronics
//     package, NOT a signoff verdict.
//   • If gmsh / scikit-fem / meshio are missing OR the Python script
//     crashes OR the summary JSON doesn't parse, returns ok=false and
//     writes no record. Silent success is forbidden.

import Foundation

/// One run of the component-verify producer — kept as plain text + a
/// record ID so cockpit chat + CLI pretty-print identically (D50).
public struct ComponentVerifyResult: Sendable {
    /// Did the producer report ok=true AND was a record written?
    public let ok: Bool
    /// Newline-joined lines for stdout / chat panel.
    public let lines: [String]
    /// All record IDs cited by this run: canonical first (if written),
    /// then foreign bridge records (anima_*, upduino_*, …) found via
    /// scan-foreign across `exports/component/verify/<stamp>/**`.
    public let newRecordIDs: [String]

    public init(ok: Bool, lines: [String], newRecordIDs: [String]) {
        self.ok = ok
        self.lines = lines
        self.newRecordIDs = newRecordIDs
    }

    /// Backward-compat: first cited record (canonical when present).
    public var newRecordID: String? { newRecordIDs.first }

    public var text: String { lines.joined(separator: "\n") }
}

public enum ComponentVerifyProducer {

    /// Default location for component-verify records — sibling of
    /// `component/geometry/`, `chip/noc/f1f2/records/`, `sscb/transient/`,
    /// `energy/pv/`, `antimatter/pdg/`.
    public static let verifyRecordsRoot: URL =
        RecordLoader.exportsRoot
            .appendingPathComponent("component/verify", isDirectory: true)

    /// scan-foreign: foreign record prefixes the consumer auto-cites
    /// alongside canonical `component_verify_*` records. Add new bridge
    /// substrates here — single point of extension. Originally mirrored
    /// the same pattern in `FirmwareVerifyProducer` (B1+B2 cohort,
    /// 2026-05-21); that Swift producer was removed during the D111
    /// Phase C firmware migration (2026-05-22) once firmware moved fully
    /// to the generic cellrun route (domains/firmware.demi).
    public static let foreignRecordPrefixes: [String] = [
        "anima_",       // anima-side bridge records (HEXAD physics, etc.)
        "upduino_",     // upduino_enclosure_thermal_* (real-PCB enclosure
                        // STEP→FEM bridge from anima component STEP cycle)
        // future: "hexa-aura_", "hexa-sense_", ...
    ]

    /// Foreign bridge records (any timestamp dir under `root`) — shallow
    /// walk: `root/<stamp>/<prefix>*.json`. Deduped + sorted for
    /// deterministic output (D26 g_swift_native).
    private static func scanForeignRecords(under root: URL) -> [String] {
        let fm = FileManager.default
        guard let stampDirs = try? fm.contentsOfDirectory(
                at: root, includingPropertiesForKeys: [.isDirectoryKey])
        else { return [] }
        var ids: [String] = []
        for stampDir in stampDirs {
            let isDir = (try? stampDir.resourceValues(forKeys: [.isDirectoryKey]))?
                .isDirectory ?? false
            guard isDir,
                  let files = try? fm.contentsOfDirectory(
                    at: stampDir, includingPropertiesForKeys: nil)
            else { continue }
            for url in files {
                let name = url.lastPathComponent
                guard url.pathExtension == "json" else { continue }
                if foreignRecordPrefixes.contains(where: { name.hasPrefix($0) }) {
                    ids.append(String(name.dropLast(".json".count)))
                }
            }
        }
        return Array(Set(ids)).sorted()
    }

    /// Locate the producer script — SSOT in hexa-lang stdlib per
    /// D61 / g_demiurge_pointer_only. NO cockpit/scripts/ fallback
    /// (any such fallback would be a birth-violation of g_demiurge_
    /// pointer_only).
    public static func locateScript() -> String? {
        let candidate = NSString(
            string: "~/core/hexa-lang/stdlib/component/gmsh_skfem.py"
        ).expandingTildeInPath
        if FileManager.default.fileExists(atPath: candidate) {
            return candidate
        }
        return nil
    }

    /// Locate a Python 3 binary — prefer Homebrew's `/opt/homebrew/
    /// bin/python3` (where `pip install --user --break-system-packages
    /// gmsh scikit-fem numpy meshio` lands on macOS), then PATH
    /// fallback. Same resolver shape as AntimatterAnalyzeProducer.
    public static func locatePython3() -> String? {
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

    /// Run `python3 gmsh_skfem.py <verifyRecordsRoot>/<stamp>/` and
    /// persist one `ComponentVerifyRecord` per call. Each call writes
    /// into its own timestamped subdirectory so consecutive runs do
    /// not stomp each other's .csv / .meta.json / .msh artifacts.
    public static func runVerify() -> ComponentVerifyResult {
        var lines: [String] = []

        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — gmsh_skfem.py 를 찾지 못했습니다 "
                + "(~/core/hexa-lang/stdlib/component/). D61 / "
                + "g_demiurge_pointer_only: producer script SSOT 는 "
                + "hexa-lang 안에 살아야 합니다 (g3 — silent success 금지).")
            return ComponentVerifyResult(
                ok: false, lines: lines, newRecordIDs: [])
        }

        // Build per-run output dir under exports/component/verify/<stamp>/.
        let iso = ISO8601DateFormatter().string(from: Date())
        let stamp = iso.replacingOccurrences(of: ":", with: "-")
        let runDir = verifyRecordsRoot
            .appendingPathComponent(stamp, isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: runDir, withIntermediateDirectories: true)
        } catch {
            lines.append("⏳ component verify dir mkdir 실패: "
                + "\(error.localizedDescription)")
            return ComponentVerifyResult(
                ok: false, lines: lines, newRecordIDs: [])
        }

        guard let py = locatePython3() else {
            lines.append("⏳ engine tool gap — python3 를 찾지 못했습니다 "
                + "(/opt/homebrew/bin/python3 권장). gmsh + scikit-fem + "
                + "meshio + numpy import 가 필요합니다 (g3 — silent "
                + "success 금지).")
            return ComponentVerifyResult(
                ok: false, lines: lines, newRecordIDs: [])
        }

        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: py)
        proc.arguments = [script, runDir.path]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe   // merge — script writes the
                                    // COMPONENT_GMSH_SKFEM_RESULT line on stderr

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 gmsh_skfem.py 실행 "
                + "실패: \(error.localizedDescription) (g3).")
            return ComponentVerifyResult(
                ok: false, lines: lines, newRecordIDs: [])
        }

        let summary = parseSummary(captured)
        let fm = FileManager.default

        // Verify the artifacts exist on disk (defence-in-depth, @F f6).
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
        lines.append("python3 gmsh_skfem.py — exit \(exitCode), "
            + "rows=\(summary.rows ?? 0)")
        if let g = summary.gmshVersion, let s = summary.skfemVersion {
            lines.append("gmsh \(g) · scikit-fem \(s)")
        }
        if !verified.isEmpty {
            lines.append("artifacts: "
                + verified.keys.sorted().joined(separator: ", "))
        }

        let needed = ["csv", "meta"]
        let allPresent = needed.allSatisfy { verified[$0] != nil }
        let ok = (exitCode == 0) && allPresent && summary.ok

        if !ok {
            lines.append("⏳ honest gap — component verify producer "
                + "ok=\(summary.ok), exit=\(exitCode), "
                + "present=\(allPresent ? "all" : "partial")")
            let tail = lastLines(captured, 8)
            if !tail.isEmpty {
                lines.append("python tail:")
                lines.append(tail)
            }
            return ComponentVerifyResult(
                ok: false, lines: lines, newRecordIDs: [])
        }

        // Re-read the meta.json — the Python side is the SSOT for the
        // numbers; Swift just witnesses + types.
        let metaName = verified["meta"] ?? "die_proxy_box_v1.meta.json"
        let metaURL = runDir.appendingPathComponent(metaName)
        guard let metaData = try? Data(contentsOf: metaURL),
              let meta = try? JSONDecoder().decode(
                ComponentVerifyProducerMeta.self, from: metaData)
        else {
            lines.append("⏳ honest gap — meta.json 파싱 실패 "
                + "(\(metaURL.path)) — record 미작성 (g3).")
            return ComponentVerifyResult(
                ok: false, lines: lines, newRecordIDs: [])
        }

        let recordId = "component_verify_"
            + stamp.replacingOccurrences(of: "-", with: "")
        let gv = summary.gmshVersion ?? meta.gmshVersion ?? "unknown"
        let sv = summary.skfemVersion ?? meta.skfemVersion ?? "unknown"
        let pyv = meta.pythonVersion ?? "unknown"

        let caveats: [String] = [
            "geometry = 10×10×2 mm silicon die proxy box — *toy geometry*, "
            + "NOT a measured component STEP file (rfc_008 chip→component "
            + "handoff dossier 의 실제 부품이 들어오기 전까지 placeholder). "
            + "이 record 의 숫자는 *real PDE solutions on a toy box*, 즉 "
            + "측정 가능한 신호이지 그 부품의 thermal/structural 인증값이 "
            + "아니다 (g3).",
            "material constants = textbook silicon at 300 K (k=148 W/m·K, "
            + "ρ=2329 kg/m³, E=169 GPa, ν=0.22) — Lide CRC + AZoM 데이터시트 "
            + "전형값이지 *측정된 wafer-lot constants* 아님. 흡수에 해당하려면 "
            + "supplier datasheet flash-test + bench measurement (Hot Disk / "
            + "DMA) 가 record 안으로 들어와야 한다.",
            "load case = single steady-state (5 W on top 1 mm, ambient on "
            + "back, gravity body force) — transient / convection coupling / "
            + "thermal interface material (TIM) / 외력 모두 미적용. 실제 "
            + "package signoff 은 multi-load-case + sensitivity sweep + "
            + "mesh convergence study 가 필수 (Elmer / ANSYS Icepak / "
            + "Code_Aster level). 본 record 는 *first honest witness*, 즉 "
            + "엔지니어링 verdict 의 lower bound.",
            "structural solve = scikit-fem 의 built-in linear_elasticity "
            + "model + lame_parameters (κ-39 디버깅에서 hand-rolled form "
            + "이 closed-form 단축 검증 u=T·L/E 대비 ~44× 너무 무름 + "
            + "ElementVector DOF 를 component-major 로 잘못 가정한 두 "
            + "버그를 발견·정정함 — 정정 후 σ_vM_max ≈ 38 Pa 가 1D "
            + "self-weight 추정 ρgL ≈ 46 Pa 와 ~16 % 안에서 일치, u_max "
            + "≈ 2.8e-13 m 가 1D ρgL²/2E ≈ 2.7e-13 m 와 ~3 % 안에서 "
            + "일치). load = gravity body force 단독 (외력 traction 0, "
            + "thermal-structural coupling 0) — back face 전체 Dirichlet "
            + "u=0 clamp 는 standard 이지만 단일 load case 임.",
            "mesh convergence 미검증 — 본 record 는 단일 element size "
            + "(0.8 mm target → ~2200 tets) 에서 단일 점 측정. h-refinement "
            + "sweep 으로 ΔT / σ_vM 변화가 5 % 이내인지 확인되지 않은 한 "
            + "*점 추정* 이지 *수렴된 측정* 이 아님 (g3).",
            "measurement_gate = GATE_OPEN 영구 / absorbed = false 영구 — "
            + "흡수에 해당하려면 (real STEP geometry · measured material · "
            + "validated load · mesh convergence · 3rd-party signoff tool "
            + "cross-check) 5 종이 모두 record 안으로 들어와야. 본 phase "
            + "의 scope 는 *FEM 스택이 hexa-lang/stdlib 에서 동작함을 측정* "
            + "이지 packaging signoff 가 아님.",
        ]

        // Build typed sub-blocks from the meta payload.
        let geometry = ComponentVerifyGeometry(
            id: meta.geometry.id,
            displayName: meta.geometry.displayName,
            lengthM: meta.geometry.lengthM,
            widthM: meta.geometry.widthM,
            thicknessM: meta.geometry.thicknessM,
            meshSizeM: meta.geometry.meshSizeM,
            nNodes: meta.geometry.nNodes,
            nElements: meta.geometry.nElements)

        let material = ComponentVerifyMaterial(
            name: meta.material.name,
            kWPerMK: meta.material.kWPerMK,
            rhoKgPerM3: meta.material.rhoKgPerM3,
            youngsPa: meta.material.youngsPa,
            poissons: meta.material.poissons)

        let load = ComponentVerifyLoad(
            diePowerW: meta.load.diePowerW,
            heatingRegionThicknessM: meta.load.heatingRegionThicknessM,
            tAmbientK: meta.load.tAmbientK,
            gravityMPerS2: meta.load.gravityMPerS2)

        let thermal = ComponentVerifyThermal(
            tMinK: meta.measurements.thermal.tMinK,
            tMaxK: meta.measurements.thermal.tMaxK,
            tMeanK: meta.measurements.thermal.tMeanK,
            deltaTK: meta.measurements.thermal.deltaTK,
            dofCount: meta.measurements.thermal.dofCount)

        let structural = ComponentVerifyStructural(
            uMaxM: meta.measurements.structural.uMaxM,
            sigmaVmMaxPa: meta.measurements.structural.sigmaVmMaxPa,
            dofCount: meta.measurements.structural.dofCount)

        let rows = meta.measurements.table.map { r in
            ComponentVerifyRow(
                measurementKey: r.measurementKey,
                value: r.value,
                unit: r.unit)
        }
        let measurements = ComponentVerifyMeasurements(
            rows: meta.measurements.rows,
            table: rows,
            thermal: thermal,
            structural: structural)

        let record = ComponentVerifyRecord(
            interface: "demiurge:component:gmsh-skfem-verify-record",
            schemaVersion: "1.0",
            recordId: recordId,
            producedAtUtc: iso,
            geometryId: meta.geometryId,
            fingerprint: meta.fingerprint ?? "unknown",
            gmshVersion: gv,
            skfemVersion: sv,
            pythonVersion: pyv,
            geometry: geometry,
            material: material,
            load: load,
            measurements: measurements,
            artifacts: verified,
            provenance: ComponentVerifyProvenance(
                absorbed: false,
                producer: "gmsh@\(gv) + scikit-fem@\(sv)",
                measurementGate: .open,
                scopeCaveats: caveats))

        let dest = runDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys,
                                .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: dest)
        } catch {
            lines.append("⏳ component verify record JSON 쓰기 실패: "
                + "\(error.localizedDescription)")
            return ComponentVerifyResult(
                ok: false, lines: lines, newRecordIDs: [])
        }

        // Headline output lines for the user.
        lines.append("---")
        lines.append("📸 component verify record → exports/component/verify/"
            + "\(stamp)/\(recordId).json")
        lines.append(String(format:
            "   ΔT = %.3f K · T_max = %.2f K · σ_vM_max = %.4g Pa · "
            + "u_max = %.4g m",
            thermal.deltaTK, thermal.tMaxK,
            structural.sigmaVmMaxPa, structural.uMaxM))
        lines.append("   mesh: \(geometry.nNodes) nodes · "
            + "\(geometry.nElements) tetrahedra · "
            + "producer = gmsh@\(gv) + scikit-fem@\(sv)")
        lines.append("   ⏳ GATE_OPEN · absorbed=false — toy box geometry + "
            + "textbook material + single load case, 흡수에 해당하려면 "
            + "real STEP + 측정 datasheet + mesh convergence 필요 (g3, "
            + "scope_caveats 6종 참조).")

        // scan-foreign: pick up sibling bridge records (anima_*,
        // upduino_*, …) living under exports/component/verify/<other-stamp>/
        // so the cockpit consumer auto-cites them alongside the canonical
        // record (B1+B2 cohort, 2026-05-21).
        let foreign = scanForeignRecords(under: verifyRecordsRoot)
        if !foreign.isEmpty {
            lines.append("[component+verify] scan-foreign cited \(foreign.count) "
                + "bridge record(s): "
                + foreign.joined(separator: ", "))
        }
        let cited = [recordId] + foreign

        return ComponentVerifyResult(
            ok: true, lines: lines, newRecordIDs: cited)
    }

    // MARK: - Parsing helpers (private)

    /// Shape we parse out of the producer's `meta.json`. Kept in step
    /// with `~/core/hexa-lang/stdlib/component/gmsh_skfem.py::main`'s
    /// write of the meta file.
    private struct ComponentVerifyProducerMeta: Decodable {
        let ok: Bool
        let geometryId: String
        let fingerprint: String?
        let gmshVersion: String?
        let skfemVersion: String?
        let pythonVersion: String?
        let geometry: GeometryRaw
        let material: MaterialRaw
        let load: LoadRaw
        let measurements: MeasurementsRaw

        enum CodingKeys: String, CodingKey {
            case ok
            case geometryId = "geometry_id"
            case fingerprint
            case gmshVersion = "gmsh_version"
            case skfemVersion = "skfem_version"
            case pythonVersion = "python_version"
            case geometry
            case material
            case load
            case measurements
        }

        struct GeometryRaw: Decodable {
            let id: String
            let displayName: String
            let lengthM: Double
            let widthM: Double
            let thicknessM: Double
            let meshSizeM: Double
            let nNodes: Int
            let nElements: Int

            enum CodingKeys: String, CodingKey {
                case id
                case displayName = "display_name"
                case lengthM = "length_m"
                case widthM = "width_m"
                case thicknessM = "thickness_m"
                case meshSizeM = "mesh_size_m"
                case nNodes = "n_nodes"
                case nElements = "n_elements"
            }
        }

        struct MaterialRaw: Decodable {
            let name: String
            let kWPerMK: Double
            let rhoKgPerM3: Double
            let youngsPa: Double
            let poissons: Double

            enum CodingKeys: String, CodingKey {
                case name
                case kWPerMK = "k_w_per_mk"
                case rhoKgPerM3 = "rho_kg_per_m3"
                case youngsPa = "youngs_pa"
                case poissons
            }
        }

        struct LoadRaw: Decodable {
            let diePowerW: Double
            let heatingRegionThicknessM: Double
            let tAmbientK: Double
            let gravityMPerS2: Double

            enum CodingKeys: String, CodingKey {
                case diePowerW = "die_power_w"
                case heatingRegionThicknessM = "heating_region_thickness_m"
                case tAmbientK = "t_ambient_k"
                case gravityMPerS2 = "gravity_m_per_s2"
            }
        }

        struct MeasurementsRaw: Decodable {
            let rows: Int
            let table: [RowRaw]
            let thermal: ThermalRaw
            let structural: StructuralRaw
        }

        struct RowRaw: Decodable {
            let measurementKey: String
            let value: Double
            let unit: String

            enum CodingKeys: String, CodingKey {
                case measurementKey = "measurement_key"
                case value
                case unit
            }
        }

        struct ThermalRaw: Decodable {
            let tMinK: Double
            let tMaxK: Double
            let tMeanK: Double
            let deltaTK: Double
            let dofCount: Int

            enum CodingKeys: String, CodingKey {
                case tMinK = "t_min_k"
                case tMaxK = "t_max_k"
                case tMeanK = "t_mean_k"
                case deltaTK = "delta_t_k"
                case dofCount = "dof_count"
            }
        }

        struct StructuralRaw: Decodable {
            let uMaxM: Double
            let sigmaVmMaxPa: Double
            let dofCount: Int

            enum CodingKeys: String, CodingKey {
                case uMaxM = "u_max_m"
                case sigmaVmMaxPa = "sigma_vm_max_pa"
                case dofCount = "dof_count"
            }
        }
    }

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var gmshVersion: String? = nil
        var skfemVersion: String? = nil
        var pythonVersion: String? = nil
        var rows: Int? = nil
        var artifacts: [String: String] = [:]
    }

    /// Extract `COMPONENT_GMSH_SKFEM_RESULT <json>` from the merged
    /// Python stdout/stderr and decode the JSON payload. Tolerant of
    /// any other lines around it.
    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "COMPONENT_GMSH_SKFEM_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["gmsh_version"] as? String { out.gmshVersion = s }
            if let s = obj["skfem_version"] as? String { out.skfemVersion = s }
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
