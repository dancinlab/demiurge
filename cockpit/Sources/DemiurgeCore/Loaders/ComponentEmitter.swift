// ComponentEmitter — θ-2 engine tool for `component + synthesize`
// (κ-29 + κ-33 / rfc_011 §6.3 / D50 — CLI ↔ cockpit byte-identical
// engine).
//
// Wraps the bundled BIPV geometry emission into one DemiurgeCore
// function so:
//   • cockpit's "▶ 실제로 돌리기" button (component·합성 stage)
//   • DemiurgeCLI's `emit-component` subcommand
//   • DemiurgeCLI's `action synthesize` (for a component project)
// all share the SAME writer — never byte-diverge.
//
// κ-33 (P-⑨ start, D54): introduces a two-stage emitter — when
// FreeCAD is installed locally, `emitBundled()` invokes
// `FreeCADBIPVProducer.runProducer` for a real parametric model
// (.step + .brep + .stl + meta.json) and records
// `producer = "freecad@<version>"`. If FreeCAD is missing OR the
// FreeCAD producer fails for any reason, we fall back to the
// procedural placeholder (.usda + .usdz) — the historic κ-29 path —
// and record `producer = "demiurge_procedural_placeholder"`. Both
// records still carry `measurement_gate = GATE_OPEN` and
// `absorbed = false` (g3 — geometry, not a measured verdict).
//
// HONEST (g3 / @F f6): A FreeCAD parametric model is *more precise*
// than the procedural placeholder — but it is **still** a placeholder
// in the "absorbed BIPV module" sense. Thermal / structural / optical
// verdicts come from separate downstream gates (gmsh + Elmer /
// Code_Aster). `absorbed = true` is forbidden in this file.

import Foundation

/// One run of the component emitter — kept as plain text + ID list so
/// the cockpit chat + CLI both pretty-print the same lines (D50).
public struct ComponentEmitResult: Sendable {
    /// Was every step (mkdir + .usda + record JSON) ok?
    public let ok: Bool
    /// Lines suitable for stdout / chat — newline-joined.
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

public enum ComponentEmitter {
    /// Emit the bundled BIPV 5-layer geometry to
    /// `exports/component/geometry/`. κ-33 (D54) two-stage:
    ///   1. If FreeCAD is installed locally, invoke
    ///      `FreeCADBIPVProducer` — emits .step / .brep / .stl /
    ///      .meta.json + a typed record with
    ///      `producer = "freecad@<version>"`.
    ///   2. Otherwise (or on FreeCAD failure), fall back to the
    ///      procedural emitter — .usda / .usdz + a typed record with
    ///      `producer = "demiurge_procedural_placeholder"`.
    ///
    /// In both cases `measurement_gate = GATE_OPEN`,
    /// `absorbed = false` (g3 — geometry, not measured verdict).
    /// Idempotent on disk — overwrites prior files.
    public static func emitBundled() -> ComponentEmitResult {
        let geometry = ComponentGeometry.bipv5Layer
        let dir = RecordLoader.exportsRoot
            .appendingPathComponent("component/geometry", isDirectory: true)
        var lines: [String] = []
        do {
            try FileManager.default.createDirectory(
                at: dir, withIntermediateDirectories: true)
        } catch {
            lines.append("emit-component: mkdir failed — \(error)")
            return ComponentEmitResult(ok: false, lines: lines, newRecordID: nil)
        }

        // κ-33 — try FreeCAD parametric producer first (D54). If it
        // succeeds, we record the parametric artifact and return.
        // Otherwise we surface the gap and continue to the procedural
        // fallback (honest-gap path, D53 measurable-only stance).
        if FreeCADBIPVProducer.locateFreeCADCmd() != nil {
            let freecadResult = emitFreeCAD(geometry: geometry, dir: dir)
            if freecadResult.ok {
                return freecadResult
            }
            // Surface the FreeCAD producer's gap before falling back.
            lines.append(contentsOf: freecadResult.lines)
            lines.append("emit-component: FreeCAD producer 실패 → "
                + "절차 placeholder fallback (g3 — honest gap).")
            lines.append("---")
        }

        return emitProcedural(geometry: geometry, dir: dir,
                              prefixLines: lines)
    }

    /// FreeCAD parametric producer path (κ-33 / D54). Spawns
    /// `bipv_freecad.py` through `freecadcmd`, verifies the
    /// artifacts, and writes a typed `ComponentRecord` with
    /// `producer = "freecad@<version>"`. Caller has already
    /// ensured `dir` exists.
    public static func emitFreeCAD(geometry: ComponentGeometry,
                                   dir: URL) -> ComponentEmitResult {
        var lines: [String] = []
        let r = FreeCADBIPVProducer.runProducer(outputDir: dir)
        lines.append(contentsOf: r.lines)

        guard r.ok else {
            return ComponentEmitResult(ok: false, lines: lines,
                                       newRecordID: nil)
        }
        // Sanity check — the Python side should report 5 layers and
        // ~41.4mm total. If it drifts, that's an SSOT-drift bug
        // (g3 / @D g_ssot_single_source D50) — refuse the record.
        if let layerCount = r.layerCount, layerCount != geometry.layers.count {
            lines.append("emit-component: FreeCAD producer 의 layer "
                + "count \(layerCount) ≠ Swift SSOT \(geometry.layers.count) "
                + "— SSOT drift, record 거부 (g3).")
            return ComponentEmitResult(ok: false, lines: lines,
                                       newRecordID: nil)
        }
        if let t = r.totalThicknessMM,
           abs(t - geometry.totalThicknessMM) > 0.05 {
            lines.append("emit-component: FreeCAD producer 의 total "
                + "thickness \(t)mm ≠ Swift SSOT "
                + "\(geometry.totalThicknessMM)mm — SSOT drift, "
                + "record 거부 (g3).")
            return ComponentEmitResult(ok: false, lines: lines,
                                       newRecordID: nil)
        }

        // Build + persist the typed ComponentRecord. recordId =
        // geometry slug emitted by Python (e.g. "bipv_freecad_v1").
        let iso = ISO8601DateFormatter().string(from: Date())
        let version = r.freecadVersion ?? "unknown"
        let record = ComponentRecord.freecad(
            for: geometry, producedAtUtc: iso,
            producerVersion: version, artifacts: r.artifacts)
        let jsonName = "\(record.recordId).json"
        let jsonURL = dir.appendingPathComponent(jsonName)
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: jsonURL)
        } catch {
            lines.append("emit-component: write \(jsonName) failed — \(error)")
            return ComponentEmitResult(ok: false, lines: lines, newRecordID: nil)
        }
        lines.append("emit-component: wrote \(jsonName)")
        lines.append("---")
        lines.append("📦 component artifact → exports/component/geometry/"
            + "\(record.recordId).{step,brep,stl,meta.json,json}")
        lines.append("   GATE_OPEN · absorbed=false · "
            + "producer=freecad@\(version) (parametric · g3)")
        return ComponentEmitResult(
            ok: true, lines: lines, newRecordID: record.recordId)
    }

    /// Procedural placeholder path (κ-29). Used directly when
    /// FreeCAD is unavailable, and as the honest-gap fallback when
    /// the FreeCAD producer fails.
    public static func emitProcedural(geometry: ComponentGeometry,
                                      dir: URL,
                                      prefixLines: [String] = []) -> ComponentEmitResult {
        var lines = prefixLines
        let usdaName = "\(geometry.id).usda"
        let usdzName = "\(geometry.id).usdz"
        let jsonName = "\(geometry.id).json"
        let usdaURL = dir.appendingPathComponent(usdaName)
        let usdzURL = dir.appendingPathComponent(usdzName)
        let jsonURL = dir.appendingPathComponent(jsonName)

        do {
            try USDExporter.usda(geometry).write(
                to: usdaURL, atomically: true, encoding: .utf8)
        } catch {
            lines.append("emit-component: write \(usdaName) failed — \(error)")
            return ComponentEmitResult(ok: false, lines: lines, newRecordID: nil)
        }
        lines.append("emit-component: wrote \(usdaName)")

        let usdzOK = USDExporter.packageUSDZ(from: usdaURL, to: usdzURL)
        lines.append(usdzOK
            ? "emit-component: wrote \(usdzName)"
            : "emit-component: usdz packaging unavailable — .usda only "
              + "(honest gap, g3)")

        let iso = ISO8601DateFormatter().string(from: Date())
        let record = ComponentRecord.procedural(
            for: geometry, producedAtUtc: iso,
            usdaFile: usdaName, usdzFile: usdzOK ? usdzName : nil)
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            try enc.encode(record).write(to: jsonURL)
        } catch {
            lines.append("emit-component: write \(jsonName) failed — \(error)")
            return ComponentEmitResult(ok: false, lines: lines, newRecordID: nil)
        }
        lines.append("emit-component: wrote \(jsonName)")
        lines.append("---")
        lines.append("📦 component artifact → exports/component/geometry/")
        lines.append("   GATE_OPEN · absorbed=false · procedural placeholder (g3)")
        return ComponentEmitResult(
            ok: true, lines: lines, newRecordID: geometry.id)
    }
}
