// STLExporter — phase λ-3 (rfc_011 §7 ComponentMode export).
//
// Serializes a `ComponentGeometry` to ASCII STL — each layer is an
// axis-aligned box (6 quads → 12 triangles). Pure Foundation, shared
// by the cockpit export menu and DemiurgeCLI (D50). STL carries
// geometry only (no colour, no units tag) — coordinates are in
// millimetres by the `ComponentGeometry` convention.
//
// `.obj` is intentionally NOT provided (D52 — overlaps STL's
// CAD / 3D-print role).

import Foundation

public enum STLExporter {
    /// `geometry` as ASCII STL. `explodeFactor` 0 = assembled.
    public static func stl(_ geometry: ComponentGeometry,
                           explodeFactor: Double = 0) -> String {
        let name = sanitize(geometry.id)
        var s = "solid \(name)\n"
        let hw = geometry.widthMM / 2.0
        let hd = geometry.depthMM / 2.0
        for (i, layer) in geometry.layers.enumerated() {
            let cy = geometry.explodedCenterY(i, explodeFactor: explodeFactor)
            s += boxFacets(hw: hw, ht: layer.thicknessMM / 2.0,
                           hd: hd, cy: cy)
        }
        s += "endsolid \(name)\n"
        return s
    }

    private typealias V = (Double, Double, Double)

    /// 12 triangles for an axis-aligned box centred at (0, cy, 0).
    private static func boxFacets(hw: Double, ht: Double,
                                  hd: Double, cy: Double) -> String {
        let x0 = -hw, x1 = hw
        let y0 = cy - ht, y1 = cy + ht
        let z0 = -hd, z1 = hd
        let p000: V = (x0, y0, z0), p100: V = (x1, y0, z0)
        let p110: V = (x1, y1, z0), p010: V = (x0, y1, z0)
        let p001: V = (x0, y0, z1), p101: V = (x1, y0, z1)
        let p111: V = (x1, y1, z1), p011: V = (x0, y1, z1)
        var s = ""
        s += quad((0, 0, -1), p000, p010, p110, p100)  // -Z
        s += quad((0, 0,  1), p001, p101, p111, p011)  // +Z
        s += quad((-1, 0, 0), p000, p001, p011, p010)  // -X
        s += quad(( 1, 0, 0), p100, p110, p111, p101)  // +X
        s += quad((0, -1, 0), p000, p100, p101, p001)  // -Y
        s += quad((0,  1, 0), p010, p011, p111, p110)  // +Y
        return s
    }

    /// A quad a→b→c→d (CCW from +normal) as two STL facets.
    private static func quad(_ n: V, _ a: V, _ b: V,
                             _ c: V, _ d: V) -> String {
        tri(n, a, b, c) + tri(n, a, c, d)
    }

    private static func tri(_ n: V, _ a: V, _ b: V, _ c: V) -> String {
        var s = "  facet normal \(f(n.0)) \(f(n.1)) \(f(n.2))\n"
        s += "    outer loop\n"
        s += "      vertex \(f(a.0)) \(f(a.1)) \(f(a.2))\n"
        s += "      vertex \(f(b.0)) \(f(b.1)) \(f(b.2))\n"
        s += "      vertex \(f(c.0)) \(f(c.1)) \(f(c.2))\n"
        s += "    endloop\n  endfacet\n"
        return s
    }

    private static func f(_ v: Double) -> String {
        String(format: "%.4f", v)
    }

    private static func sanitize(_ raw: String) -> String {
        var out = ""
        for ch in raw {
            out.append(ch.isLetter || ch.isNumber || ch == "_" ? ch : "_")
        }
        return out.isEmpty ? "component" : out
    }
}
