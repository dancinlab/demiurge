// ComponentVerifier — phase κ-34 (P-⑨ verify) — θ-2 engine tool that
// wires `component + verify` to **gmsh** (mesh producer) plus a
// honest-witness probe of the Salome-Meca docker image (D55).
//
// The Swift side is a spawn-and-witness harness — same shape as
// FreeCADBIPVProducer / MatterAnalyzer (D17 — Swift never simulates;
// it spawns the toolchain that does, then writes a typed record):
//
//   1. locate the latest `bipv_freecad_v1.step` (the upstream geometry
//      record from κ-33). If missing → honest gap, no record emitted.
//   2. locate the gmsh CLI (`brew install gmsh` → `/opt/homebrew/bin/
//      gmsh`). If missing → honest gap.
//   3. spawn `gmsh -3 -format msh4 -o <outdir>/<id>.msh <step>` —
//      matches the CLI default that produces 1944 nodes / 9226
//      elements in ~2s on the κ-33 STEP. The python API path is
//      slower (~10min) because it lacks the CLI's OCC-fuse step;
//      honest pick.
//   4. spawn `python3 cockpit/scripts/bipv_verify.py <msh> <outdir>`
//      with PYTHONPATH set — re-opens the .msh, reads node/element
//      counts + jacobian-quality histogram, writes MED for Salome.
//      Capture `BIPV_VERIFY_RESULT <json>` summary on stderr.
//   5. probe Salome-Meca docker — `docker images` for tefe/salome-
//      meca. This is a *witness*, not a sim — image presence is
//      enough of a signal for the record; the actual container run
//      happens in κ-35 (D55 gap ②).
//   6. build + write a typed `ComponentVerifyRecord` to
//      `exports/component/verify/<recordId>.json`. Producer = gmsh
//      today; salomeDockerReady tells the caller whether κ-35's
//      Code_Aster .comm authoring can proceed.
//
// HONESTY (g3 — non-negotiable):
//   * A mesh is NOT a thermal / structural verdict. The record carries
//     `absorbed=false` and `measurement_gate=GATE_OPEN` always.
//   * The Salome docker probe is a *witness*, not a measurement —
//     `salome_docker_ready` is an instrument-availability flag, not a
//     gate-flip signal.
//   * If gmsh meshes but MED export fails (some gmsh builds skip MED
//     by default), the record's `med_file` is nil and a caveat is
//     added — silent fallback is forbidden.
//   * If gmsh produces zero elements or the summary line is missing,
//     we refuse the record (ok=false) and let the chat/CLI surface
//     the gap.

import Foundation

/// Outcome of one verify run — typed for ActionDispatch consumption.
public struct ComponentVerifyResult: Sendable {
    public let ok: Bool
    public let lines: [String]
    public let newRecordID: String?
    public init(ok: Bool, lines: [String], newRecordID: String?) {
        self.ok = ok
        self.lines = lines
        self.newRecordID = newRecordID
    }
    public var text: String { lines.joined(separator: "\n") }
}

public enum ComponentVerifier {

    /// Candidate paths for the gmsh CLI binary (brew).
    private static let gmshCliCandidates: [String] = [
        "/opt/homebrew/bin/gmsh",
        "/usr/local/bin/gmsh",
    ]

    /// Candidate Cellar prefixes for locating the gmsh Python lib.
    private static let gmshLibCandidates: [String] = [
        "/opt/homebrew/Cellar/gmsh",
        "/usr/local/Cellar/gmsh",
    ]

    /// Locate `gmsh` CLI binary. Returns nil if not installed.
    public static func locateGmshCli() -> String? {
        let fm = FileManager.default
        for c in gmshCliCandidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "gmsh"]
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

    /// Locate the gmsh.py module by scanning brew Cellar. Returns the
    /// directory to add to PYTHONPATH (the lib/ dir containing
    /// `gmsh.py`), or nil if gmsh isn't brew-installed.
    public static func locateGmshPythonLib() -> String? {
        let fm = FileManager.default
        for cellar in gmshLibCandidates where fm.fileExists(atPath: cellar) {
            guard let versions = try? fm.contentsOfDirectory(atPath: cellar) else {
                continue
            }
            // Pick the highest semver-sorted version (lexical works
            // for `4.15.x` etc — same trick brew itself uses).
            for v in versions.sorted().reversed() {
                let lib = "\(cellar)/\(v)/lib"
                if fm.fileExists(atPath: "\(lib)/gmsh.py") {
                    return lib
                }
            }
        }
        return nil
    }

    /// Locate `cockpit/scripts/bipv_verify.py` relative to the
    /// project root (same pattern as FreeCADBIPVProducer.locateScript).
    public static func locateScript() -> String? {
        let candidate = ArtifactRegistry.projectRoot
            .appendingPathComponent("cockpit/scripts/bipv_verify.py")
            .standardizedFileURL
        if FileManager.default.fileExists(atPath: candidate.path) {
            return candidate.path
        }
        return nil
    }

    /// Locate the upstream geometry .step. We pick the most recent
    /// `bipv_freecad_v1.step` under `exports/component/geometry/`
    /// (κ-33's output); if missing, return nil — the caller surfaces
    /// the honest gap.
    public static func locateGeometryStep() -> URL? {
        let stepURL = RecordLoader.exportsRoot
            .appendingPathComponent("component/geometry/bipv_freecad_v1.step")
        return FileManager.default.fileExists(atPath: stepURL.path)
            ? stepURL : nil
    }

    // MARK: - Main entry

    /// Drive the full mesh + witness pipeline and emit a typed
    /// `ComponentVerifyRecord`. Same shape as
    /// `ComponentEmitter.emitBundled()` — idempotent on disk.
    public static func runVerify() -> ComponentVerifyResult {
        var lines: [String] = []

        guard let stepURL = locateGeometryStep() else {
            lines.append("⏳ engine tool gap — 상위 geometry record "
                + "(bipv_freecad_v1.step) 가 exports/component/geometry/ "
                + "에 없습니다. 먼저 `component + synthesize` 를 돌려서 "
                + "STEP 을 생성해야 합니다 (κ-33 / D54 producer).")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }
        guard let script = locateScript() else {
            lines.append("⏳ engine tool gap — bipv_verify.py 스크립트를 "
                + "찾지 못했습니다 (cockpit/scripts/). 빌드 시 누락 가능성 "
                + "— g3 (silent success 금지).")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }
        guard let gmshCli = locateGmshCli() else {
            lines.append("⏳ engine tool gap — `gmsh` CLI 를 찾지 못했습니다 "
                + "(`brew install gmsh` 가 필요합니다). component + verify "
                + "(P-⑨) 의 mesh 단계는 gmsh CLI 를 spawn 합니다 (g3).")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }
        guard let pyLib = locateGmshPythonLib() else {
            lines.append("⏳ engine tool gap — brew gmsh 의 python 바인딩 "
                + "(gmsh.py) 을 찾지 못했습니다 — `brew install gmsh` 가 "
                + "필요합니다. stats / MED 단계는 gmsh python API 를 "
                + "사용합니다 (g3).")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }

        // Output dir = exports/component/verify/.
        let outDir = RecordLoader.exportsRoot
            .appendingPathComponent("component/verify", isDirectory: true)
        do {
            try FileManager.default.createDirectory(
                at: outDir, withIntermediateDirectories: true)
        } catch {
            lines.append("verify: mkdir failed — \(error)")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }

        // Stage 1: CLI mesh — `gmsh -3 -format msh4 -o <out>.msh <step>`.
        // Matches the CLI default that produces 1944 / 9226 in ~2s
        // (the python API path takes ~10min because it lacks the CLI's
        // OCC-fuse step). Honest pick.
        let mshURL = outDir.appendingPathComponent("bipv_freecad_v1.msh")
        let meshProc = Process()
        meshProc.executableURL = URL(fileURLWithPath: gmshCli)
        meshProc.arguments = [
            "-3", "-format", "msh4",
            "-o", mshURL.path, stepURL.path,
        ]
        let meshPipe = Pipe()
        meshProc.standardOutput = meshPipe
        meshProc.standardError = meshPipe
        var meshExit: Int32 = -1
        var meshCaptured = ""
        do {
            try meshProc.run()
            let data = meshPipe.fileHandleForReading.readDataToEndOfFile()
            meshProc.waitUntilExit()
            meshExit = meshProc.terminationStatus
            meshCaptured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — gmsh CLI 실행 실패: "
                + "\(error.localizedDescription) (g3).")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }
        lines.append("gmsh -3 -o \(mshURL.lastPathComponent) — exit \(meshExit)")
        let fm = FileManager.default
        guard meshExit == 0, fm.fileExists(atPath: mshURL.path),
              (try? fm.attributesOfItem(atPath: mshURL.path)[.size] as? Int) ?? 0 > 0
        else {
            lines.append("⏳ honest gap — gmsh CLI 메싱 실패 / .msh 미생성 "
                + "(g3).")
            let tail = lastLines(meshCaptured, 6)
            if !tail.isEmpty {
                lines.append("gmsh tail:")
                lines.append(tail)
            }
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }

        // Stage 2: Python stats — open the .msh, read counts + quality,
        // write MED for Salome.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["python3", script, mshURL.path, outDir.path]
        var env = ProcessInfo.processInfo.environment
        let existing = env["PYTHONPATH"] ?? ""
        env["PYTHONPATH"] = existing.isEmpty ? pyLib : "\(pyLib):\(existing)"
        proc.environment = env
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe

        var captured = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            captured = String(data: data, encoding: .utf8) ?? ""
        } catch {
            lines.append("⏳ engine tool gap — python3 stats 실행 실패: "
                + "\(error.localizedDescription) (g3).")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }

        lines.append("python3 \(script) — exit \(exitCode)")

        let summary = parseSummary(captured)
        guard summary.ok else {
            let tail = lastLines(captured, 8)
            lines.append("⏳ honest gap — bipv_verify.py 가 ok=false "
                + "리턴: \(summary.errorOrNil ?? "(no error msg)") (g3).")
            if !tail.isEmpty {
                lines.append("verify tail:")
                lines.append(tail)
            }
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }

        // Defence-in-depth — every claimed file must exist non-empty.
        var verified: [String: String] = [:]
        for (kind, name) in summary.artifacts {
            let url = outDir.appendingPathComponent(name)
            if fm.fileExists(atPath: url.path),
               (try? fm.attributesOfItem(atPath: url.path)[.size] as? Int) ?? 0 > 0 {
                verified[kind] = name
            }
        }
        if verified["msh"] == nil {
            lines.append("⏳ honest gap — .msh 파일이 디스크에 없습니다 "
                + "(producer 가 ok=true 라고 했지만 실제 파일 없음 — g3 "
                + "defence-in-depth).")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }
        lines.append("artifacts written: " + verified.keys.sorted()
            .joined(separator: ", "))
        if let n = summary.nodeCount, let e = summary.elementCount {
            lines.append("mesh: \(n) nodes, \(e) elements"
                + (summary.volumeCount.map { ", \($0) volumes" } ?? ""))
        }

        // Load the mesh.json sidecar back as typed ComponentMeshStats.
        var meshStats: ComponentMeshStats? = nil
        if let statsName = verified["stats"] {
            let statsURL = outDir.appendingPathComponent(statsName)
            if let data = try? Data(contentsOf: statsURL) {
                let dec = JSONDecoder()
                meshStats = try? dec.decode(ComponentMeshStats.self, from: data)
            }
        }

        // Probe Salome-Meca docker — witness only, no sim.
        let salomeProbe = probeSalomeDocker()
        if let ready = salomeProbe.ready {
            lines.append(ready
                ? "Salome-Meca docker: ready (image=\(salomeProbe.image ?? "?"))"
                : "Salome-Meca docker: not ready (image=\(salomeProbe.image ?? "?")) "
                  + "— next gate blocked")
        } else {
            lines.append("Salome-Meca docker: not probed (docker CLI 미발견)")
        }

        // Build + write the typed verify record.
        let iso = ISO8601DateFormatter().string(from: Date())
        let recordId = "bipv_verify_v1"
        let record = ComponentVerifyRecord.gmshMesh(
            geometryId: "bipv_freecad_v1",
            producedAtUtc: iso,
            gmshVersion: summary.gmshVersion ?? "unknown",
            recordId: recordId,
            mshFile: verified["msh"],
            medFile: verified["med"],
            meshStatsFile: verified["stats"],
            meshStats: meshStats,
            salomeDockerReady: salomeProbe.ready,
            salomeImage: salomeProbe.image)
        let jsonURL = outDir.appendingPathComponent("\(recordId).json")
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: jsonURL)
        } catch {
            lines.append("verify: write \(recordId).json failed — \(error)")
            return ComponentVerifyResult(ok: false, lines: lines,
                                         newRecordID: nil)
        }
        lines.append("verify: wrote \(recordId).json")
        lines.append("---")
        lines.append("📦 component verify artifact → "
            + "exports/component/verify/\(recordId).{msh,med,mesh.json,json}")
        lines.append("   GATE_OPEN · absorbed=false · "
            + "producer=gmsh@\(summary.gmshVersion ?? "?") (mesh-only · g3)")
        if salomeProbe.ready != true {
            lines.append("   다음 단계 (κ-35 후보): Salome-Meca Code_Aster "
                + ".comm authoring + as_run 수렴 — D55 honest gap ②.")
        }
        return ComponentVerifyResult(ok: true, lines: lines,
                                     newRecordID: recordId)
    }

    // MARK: - Summary parsing

    private struct ParsedSummary {
        var ok: Bool = false
        var geometryId: String? = nil
        var gmshVersion: String? = nil
        var nodeCount: Int? = nil
        var elementCount: Int? = nil
        var volumeCount: Int? = nil
        var artifacts: [String: String] = [:]
        var errorOrNil: String? = nil
    }

    private static func parseSummary(_ text: String) -> ParsedSummary {
        var out = ParsedSummary()
        let marker = "BIPV_VERIFY_RESULT "
        for raw in text.components(separatedBy: "\n") {
            guard let r = raw.range(of: marker) else { continue }
            let json = String(raw[r.upperBound...])
            guard let data = json.data(using: .utf8) else { continue }
            guard let obj = try? JSONSerialization.jsonObject(with: data)
                as? [String: Any] else { continue }
            if let b = obj["ok"] as? Bool { out.ok = b }
            if let s = obj["geometry_id"] as? String { out.geometryId = s }
            if let s = obj["gmsh_version"] as? String { out.gmshVersion = s }
            if let i = obj["node_count"] as? Int { out.nodeCount = i }
            if let i = obj["element_count"] as? Int { out.elementCount = i }
            if let i = obj["volume_count"] as? Int { out.volumeCount = i }
            if let exp = obj["exports"] as? [String: Any] {
                for (k, v) in exp {
                    if let s = v as? String { out.artifacts[k] = s }
                }
            }
            if let e = obj["error"] as? String { out.errorOrNil = e }
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

    // MARK: - Salome-Meca docker witness

    public struct SalomeProbe: Sendable {
        public let ready: Bool?
        public let image: String?
    }

    /// Honest probe — checks docker CLI exists, then `docker images`
    /// for tefe/salome-meca. Does NOT spawn a container; the run-and-
    /// `which as_run` confirmation is too slow (~30s container start)
    /// to gate every verify call. Image presence + name is enough of
    /// a witness for the record; the next pickup (κ-35) is where the
    /// actual container exec happens.
    public static func probeSalomeDocker() -> SalomeProbe {
        let docker = locateDocker()
        guard let dockerPath = docker else {
            return SalomeProbe(ready: nil, image: nil)
        }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: dockerPath)
        proc.arguments = ["images", "--format", "{{.Repository}}:{{.Tag}}"]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = Pipe()
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            let out = String(data: data, encoding: .utf8) ?? ""
            for line in out.components(separatedBy: "\n") {
                let t = line.trimmingCharacters(in: .whitespaces)
                if t.hasPrefix("tefe/salome-meca:") {
                    return SalomeProbe(ready: true, image: t)
                }
            }
            return SalomeProbe(ready: false, image: nil)
        } catch {
            return SalomeProbe(ready: false, image: nil)
        }
    }

    private static func locateDocker() -> String? {
        let fm = FileManager.default
        let candidates = [
            "/opt/homebrew/bin/docker",
            "/usr/local/bin/docker",
            "/usr/bin/docker",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        return nil
    }
}
