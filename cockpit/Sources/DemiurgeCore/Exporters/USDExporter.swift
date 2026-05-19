// USDExporter — phase λ-2 + λ-rich (rfc_011 §7 ComponentMode export).
//
// Serializes a `ComponentGeometry` to USD ASCII (.usda 1.0). Pure
// Foundation — no USD library dependency, so the same function runs
// in the cockpit export menu and the headless DemiurgeCLI (D50
// g_ssot_single_source).
//
// λ-rich: each layer expands by its `LayerRender` style — a PV layer
// becomes an 8×8 cell grid, the frame becomes a 4-side border, the
// sink becomes a fin array, the mount a base + corner brackets. Every
// layer carries a UsdPreviewSurface material (diffuse / metallic /
// roughness / opacity) so glass renders translucent and metal
// renders metallic in any USD viewer (RealityKit included).
//
// HONEST (g3): still a PROCEDURAL PLACEHOLDER — more detailed, but
// not a measured component. `demiurge:provenance` says so.

import Foundation

public enum USDExporter {
    /// `geometry` as USD ASCII. `explodeFactor` 0 = assembled.
    public static func usda(_ geometry: ComponentGeometry,
                            explodeFactor: Double = 0) -> String {
        var s = "#usda 1.0\n(\n"
        s += "    defaultPrim = \"Component\"\n"
        s += "    metersPerUnit = 0.001\n"
        s += "    upAxis = \"Y\"\n"
        s += "    doc = \"demiurge ComponentGeometry export — "
        s += "\(geometry.id). PROCEDURAL PLACEHOLDER geometry (g3), "
        s += "not a measured component.\"\n"
        s += ")\n\n"
        s += "def Xform \"Component\" (\n    kind = \"component\"\n)\n{\n"
        s += "    custom string demiurge:geometryId = \"\(geometry.id)\"\n"
        s += "    custom string demiurge:displayName = "
        s += "\"\(geometry.displayName)\"\n"
        s += "    custom double demiurge:explodeFactor = "
        s += "\(fmt(explodeFactor))\n"
        s += "    custom string demiurge:provenance = "
        s += "\"procedural_placeholder · GATE_OPEN · absorbed=false\"\n\n"

        s += materialsBlock(geometry)
        for (i, layer) in geometry.layers.enumerated() {
            let y = geometry.explodedCenterY(i, explodeFactor: explodeFactor)
            s += layerXform(geometry, layer, index: i, centerY: y)
        }
        s += "}\n"
        return s
    }

    // MARK: — materials

    private static func materialsBlock(_ g: ComponentGeometry) -> String {
        var s = "    def Scope \"Materials\"\n    {\n"
        for layer in g.layers {
            let mat = "mat_\(primName(layer.name))"
            let (r, gg, b) = layer.rgb
            let metallic = isMetal(layer.render) ? 0.85 : 0.0
            let rough = isMetal(layer.render) ? 0.35 : 0.12
            s += "        def Material \"\(mat)\"\n        {\n"
            s += "            token outputs:surface.connect = "
            s += "</Component/Materials/\(mat)/Shader.outputs:surface>\n"
            s += "            def Shader \"Shader\"\n            {\n"
            s += "                uniform token info:id = \"UsdPreviewSurface\"\n"
            s += "                color3f inputs:diffuseColor = "
            s += "(\(fmt(r)), \(fmt(gg)), \(fmt(b)))\n"
            s += "                float inputs:metallic = \(fmt(metallic))\n"
            s += "                float inputs:roughness = \(fmt(rough))\n"
            s += "                float inputs:opacity = "
            s += "\(fmt(layer.opacity))\n"
            s += "                token outputs:surface\n"
            s += "            }\n        }\n"
        }
        s += "    }\n\n"
        return s
    }

    private static func isMetal(_ r: LayerRender) -> Bool {
        switch r {
        case .frameBorder, .finnedSink, .mountBase: return true
        case .slab, .cellGrid: return false
        }
    }

    // MARK: — per-layer geometry

    private static func layerXform(_ g: ComponentGeometry,
                                   _ layer: ComponentLayer,
                                   index: Int, centerY: Double) -> String {
        let xn = primName(layer.name)
        let mat = "mat_\(xn)"
        var s = "    def Xform \"Layer_\(xn)\"\n    {\n"
        s += "        float3 xformOp:translate = (0, \(fmt(centerY)), 0)\n"
        s += "        uniform token[] xformOpOrder = [\"xformOp:translate\"]\n"
        s += "        custom string demiurge:layerName = \"\(layer.name)\"\n"
        s += "        custom double demiurge:thicknessMM = "
        s += "\(fmt(layer.thicknessMM))\n"

        let boxes = g.layerBoxes(index)
        let (r, gg, b) = layer.rgb
        for (bi, p) in boxes.enumerated() {
            s += "        def Cube \"Box_\(bi)\"\n        {\n"
            s += "            double size = 1\n"
            s += "            float3 xformOp:translate = "
            s += "(\(fmt(p.cx)), \(fmt(p.cy)), \(fmt(p.cz)))\n"
            s += "            float3 xformOp:scale = "
            s += "(\(fmt(p.sx)), \(fmt(p.sy)), \(fmt(p.sz)))\n"
            s += "            uniform token[] xformOpOrder = "
            s += "[\"xformOp:translate\", \"xformOp:scale\"]\n"
            s += "            rel material:binding = "
            s += "</Component/Materials/\(mat)>\n"
            s += "            color3f[] primvars:displayColor = "
            s += "[(\(fmt(r)), \(fmt(gg)), \(fmt(b)))]\n"
            s += "        }\n"
        }
        s += "    }\n"
        return s
    }

    // MARK: — helpers

    /// Sanitize a name into a valid USD prim identifier.
    private static func primName(_ raw: String) -> String {
        var out = ""
        for ch in raw {
            out.append(ch.isLetter || ch.isNumber ? ch : "_")
        }
        if let first = out.first, first.isNumber { out = "_" + out }
        return out.isEmpty ? "Layer" : out
    }

    private static func fmt(_ v: Double) -> String {
        if v == v.rounded() && abs(v) < 1e15 { return String(Int(v)) }
        return String(format: "%.4f", v)
    }

    /// Package a `.usda` file into a `.usdz` via a system USD tool
    /// (`usdzip` or `usdcat`). Returns false — an HONEST gap, not a
    /// silent failure — if no USD tool is on the system; the `.usda`
    /// still stands alone. Shared by the CLI emitter and the cockpit
    /// export menu (D50 g_ssot_single_source).
    public static func packageUSDZ(from usda: URL, to usdz: URL) -> Bool {
        let candidates = [
            "/usr/local/bin/usdzip", "/usr/bin/usdzip",
            "/usr/bin/usdcat", "/usr/local/bin/usdcat",
        ]
        guard let tool = candidates.first(where: {
            FileManager.default.isExecutableFile(atPath: $0)
        }) else { return false }
        try? FileManager.default.removeItem(at: usdz)
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: tool)
        proc.arguments = tool.hasSuffix("usdzip")
            ? [usdz.path, usda.path]            // usdzip <out> <in>
            : [usda.path, "-o", usdz.path]      // usdcat <in> -o <out>
        proc.standardOutput = FileHandle.nullDevice
        proc.standardError = FileHandle.nullDevice
        do {
            try proc.run()
            proc.waitUntilExit()
            return proc.terminationStatus == 0
                && FileManager.default.fileExists(atPath: usdz.path)
        } catch { return false }
    }
}
