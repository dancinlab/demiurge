// ComponentGeometry — phase λ-1 (rfc_011 §7 ComponentMode / D35).
//
// The single-source typed description of a layered component model.
// Before λ-1 the 5-layer box stack was hardcoded inside
// ComponentView3D.swift; pulling it into DemiurgeCore lets the
// viewer, the USD/STL exporters, the CLI emitter, and the CLI
// exporter all consume ONE definition (D50 g_ssot_single_source) —
// the viewer can never render a different model than `export` writes.
//
// HONEST (g3): the bundled `bipv5Layer` preset is PROCEDURAL
// PLACEHOLDER geometry — plausible dimensions, NOT a measured BIPV
// module. Anything emitted from it carries measurement_gate
// GATE_OPEN / absorbed=false. A measured component producer lives in
// hexa-lang/component (P-⑨) — demiurge consumes that when it exists.

import Foundation

/// How a layer is rendered into a rich USD export — a slab, a
/// photovoltaic cell grid, a perimeter frame, a finned heat sink,
/// or a mount base with corner brackets. `USDExporter` expands each
/// into detailed prims; STL and the procedural viewer treat every
/// layer as a plain slab.
public enum LayerRender: String, Codable, Sendable {
    case slab
    case cellGrid
    case frameBorder
    case finnedSink
    case mountBase
}

/// One stacked layer of a `ComponentGeometry`. Dimensions are real
/// millimetres so the STL/USD exports are dimensionally meaningful.
public struct ComponentLayer: Codable, Equatable, Sendable, Identifiable {
    public var id: String { name }
    /// Canonical (expert) name, e.g. "Glass Face".
    public let name: String
    /// Plain-language name for the non-expert layer (rfc_012 §6).
    public let plainName: String
    /// Material description, e.g. "tempered glass".
    public let material: String
    /// Layer thickness in millimetres.
    public let thicknessMM: Double
    /// `#RRGGBB` — shared by the viewer material and any export that
    /// carries colour. Kept as a string so DemiurgeCore stays
    /// Foundation-only (no AppKit `NSColor` dependency).
    public let colorHex: String
    /// Rich-USD render style (D50 — viewer & exporter share it).
    public let render: LayerRender
    /// `0...1` opacity — < 1 marks a translucent layer (e.g. glass).
    public let opacity: Double

    public init(name: String, plainName: String, material: String,
                thicknessMM: Double, colorHex: String,
                render: LayerRender = .slab, opacity: Double = 1.0) {
        self.name = name
        self.plainName = plainName
        self.material = material
        self.thicknessMM = thicknessMM
        self.colorHex = colorHex
        self.render = render
        self.opacity = opacity
    }
}

/// A layered component model. Layers are ordered top → bottom.
public struct ComponentGeometry: Codable, Equatable, Sendable {
    /// Stable slug, e.g. "bipv_5layer_v0" — used for file names.
    public let id: String
    /// Canonical display name.
    public let displayName: String
    /// Plain-language name (rfc_012 §6 non-expert layer).
    public let plainName: String
    /// Footprint width in millimetres (X axis).
    public let widthMM: Double
    /// Footprint depth in millimetres (Z axis).
    public let depthMM: Double
    /// Layers, top → bottom.
    public let layers: [ComponentLayer]

    public init(id: String, displayName: String, plainName: String,
                widthMM: Double, depthMM: Double,
                layers: [ComponentLayer]) {
        self.id = id
        self.displayName = displayName
        self.plainName = plainName
        self.widthMM = widthMM
        self.depthMM = depthMM
        self.layers = layers
    }

    /// Total stack height in millimetres.
    public var totalThicknessMM: Double {
        layers.reduce(0) { $0 + $1.thicknessMM }
    }

    /// Assembled-state centre Y (mm) of layer `index`, with the whole
    /// model centred on the origin. Index 0 is the top layer. This is
    /// the shared anchor the viewer and every exporter use, so an
    /// exploded view and a written file stay consistent.
    public func layerCenterY(_ index: Int) -> Double {
        var top = totalThicknessMM / 2.0
        for i in 0..<index { top -= layers[i].thicknessMM }
        return top - layers[index].thicknessMM / 2.0
    }

    // MARK: — bundled procedural preset

    /// 5-layer BIPV (building-integrated photovoltaic) module —
    /// PROCEDURAL PLACEHOLDER (g3). Dimensions are plausible, not
    /// measured. Aesthetic reference:
    /// `cockpit/references/bipv-module-exploded-isometric.jpg`.
    public static let bipv5Layer = ComponentGeometry(
        id: "bipv_5layer_v0",
        displayName: "BIPV Module (5-layer)",
        plainName: "건물일체형 태양광 모듈 (5겹)",
        widthMM: 1000.0,
        depthMM: 1000.0,
        layers: [
            ComponentLayer(
                name: "Glass Face", plainName: "유리 표면",
                material: "tempered glass",
                thicknessMM: 3.2, colorHex: "#A8D8E8",
                render: .slab, opacity: 0.32),
            ComponentLayer(
                name: "PV Cells", plainName: "태양전지 셀",
                material: "monocrystalline silicon",
                thicknessMM: 0.2, colorHex: "#1B2A6B",
                render: .cellGrid, opacity: 1.0),
            ComponentLayer(
                name: "Corrosion-Proof Frame", plainName: "부식 방지 프레임",
                material: "anodized aluminium",
                thicknessMM: 8.0, colorHex: "#9AA0A6",
                render: .frameBorder, opacity: 1.0),
            ComponentLayer(
                name: "Thermal Sink", plainName: "방열판",
                material: "finned aluminium plate",
                thicknessMM: 12.0, colorHex: "#FF9500",
                render: .finnedSink, opacity: 1.0),
            ComponentLayer(
                name: "Structural Mount", plainName: "구조 마운트",
                material: "galvanised steel",
                thicknessMM: 18.0, colorHex: "#555555",
                render: .mountBase, opacity: 1.0),
        ])
}

extension ComponentLayer {
    /// `colorHex` parsed to RGB in [0,1]. Mid-grey on a malformed hex.
    public var rgb: (r: Double, g: Double, b: Double) {
        var hex = colorHex
        if hex.hasPrefix("#") { hex.removeFirst() }
        guard hex.count == 6, let v = Int(hex, radix: 16) else {
            return (0.5, 0.5, 0.5)
        }
        return (Double((v >> 16) & 0xFF) / 255.0,
                Double((v >> 8) & 0xFF) / 255.0,
                Double(v & 0xFF) / 255.0)
    }
}

extension ComponentGeometry {
    /// Centre Y (mm) of layer `index` under an explode factor.
    /// `0` = assembled (real stack); `> 0` widens the gaps uniformly
    /// about the origin. Shared by the viewer and every exporter so
    /// an exploded render and an exploded export agree.
    public func explodedCenterY(_ index: Int,
                                explodeFactor: Double) -> Double {
        layerCenterY(index) * (1.0 + max(0, explodeFactor))
    }
}

/// A detail box within a layer — millimetres, layer-local (cy is
/// within the layer thickness; 0 = the layer's mid-plane).
public struct ComponentBox: Equatable, Sendable {
    public let cx, cy, cz: Double
    public let sx, sy, sz: Double
    public init(cx: Double, cy: Double, cz: Double,
                sx: Double, sy: Double, sz: Double) {
        self.cx = cx; self.cy = cy; self.cz = cz
        self.sx = sx; self.sy = sy; self.sz = sz
    }
}

extension ComponentGeometry {
    /// Expand layer `index` into detail boxes per its `LayerRender` —
    /// a slab, an 8×8 cell grid, a 4-side frame, a finned sink, or a
    /// mount base + brackets. Shared by `USDExporter` and the cockpit
    /// 3D viewer (D50 g_ssot_single_source) so the file and the
    /// on-screen model are the same geometry.
    public func layerBoxes(_ index: Int) -> [ComponentBox] {
        let l = layers[index]
        switch l.render {
        case .slab:
            return [ComponentBox(cx: 0, cy: 0, cz: 0,
                                 sx: widthMM, sy: l.thicknessMM,
                                 sz: depthMM)]
        case .cellGrid:    return cellGridBoxes(l)
        case .frameBorder: return frameBoxes(l)
        case .finnedSink:  return finBoxes(l)
        case .mountBase:   return mountBoxes(l)
        }
    }

    /// 8×8 photovoltaic cell grid inset from the footprint edge.
    private func cellGridBoxes(_ l: ComponentLayer) -> [ComponentBox] {
        let n = 8
        let area = widthMM * 0.92
        let pitch = area / Double(n)
        let cell = pitch * 0.86
        var out: [ComponentBox] = []
        for i in 0..<n {
            for j in 0..<n {
                let cx = -area / 2 + pitch * (Double(i) + 0.5)
                let cz = -area / 2 + pitch * (Double(j) + 0.5)
                out.append(ComponentBox(cx: cx, cy: 0, cz: cz,
                                        sx: cell, sy: l.thicknessMM,
                                        sz: cell))
            }
        }
        return out
    }

    /// 4-side perimeter frame (hollow centre).
    private func frameBoxes(_ l: ComponentLayer) -> [ComponentBox] {
        let w = widthMM, d = depthMM, t = l.thicknessMM
        let bar = min(w, d) * 0.09
        let innerD = d - 2 * bar
        return [
            ComponentBox(cx: 0, cy: 0, cz: (d - bar) / 2,
                         sx: w, sy: t, sz: bar),
            ComponentBox(cx: 0, cy: 0, cz: -(d - bar) / 2,
                         sx: w, sy: t, sz: bar),
            ComponentBox(cx: (w - bar) / 2, cy: 0, cz: 0,
                         sx: bar, sy: t, sz: innerD),
            ComponentBox(cx: -(w - bar) / 2, cy: 0, cz: 0,
                         sx: bar, sy: t, sz: innerD),
        ]
    }

    /// Finned heat sink — a thin base plate + a row of fins.
    private func finBoxes(_ l: ComponentLayer) -> [ComponentBox] {
        let w = widthMM, d = depthMM, t = l.thicknessMM
        let baseT = t * 0.28
        let finT = t - baseT
        var out: [ComponentBox] = [
            ComponentBox(cx: 0, cy: (baseT - t) / 2, cz: 0,
                         sx: w, sy: baseT, sz: d)
        ]
        let count = 15
        let span = w * 0.94
        let pitch = span / Double(count)
        let fin = pitch * 0.5
        for i in 0..<count {
            let cx = -span / 2 + pitch * (Double(i) + 0.5)
            out.append(ComponentBox(cx: cx, cy: baseT / 2, cz: 0,
                                    sx: fin, sy: finT, sz: d * 0.9))
        }
        return out
    }

    /// Structural mount — a base plate + 4 corner brackets.
    private func mountBoxes(_ l: ComponentLayer) -> [ComponentBox] {
        let w = widthMM, d = depthMM, t = l.thicknessMM
        let baseT = t * 0.5
        var out: [ComponentBox] = [
            ComponentBox(cx: 0, cy: (baseT - t) / 2, cz: 0,
                         sx: w * 0.82, sy: baseT, sz: d * 0.82)
        ]
        let br = min(w, d) * 0.16
        let ox = w * 0.41, oz = d * 0.41
        for (sx2, sz2) in [(1.0, 1.0), (-1.0, 1.0),
                           (1.0, -1.0), (-1.0, -1.0)] {
            out.append(ComponentBox(cx: ox * sx2, cy: 0, cz: oz * sz2,
                                    sx: br, sy: t, sz: br))
        }
        return out
    }
}
