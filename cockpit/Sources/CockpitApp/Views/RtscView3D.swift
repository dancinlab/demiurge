// RtscView3D — minimal RealityKit 3D viewer for the rtsc HTS coil.
//
// Mirror of ComponentView3D's NSViewRepresentable shape, simplified to
// concentric cylinders (no exploded view, no presets — this is the
// κ-? test window).  The user-facing surface is a single SwiftUI
// view: orbit drag (yaw / pitch), scroll-zoom (ScrollableARView from
// ComponentView3D is reused), light/dark adaptive sky.
//
// HONEST (g3): the rendered geometry is `RtscGeometry.htsSolenoidProxy`
// — procedural placeholder, not a measured coil.

import SwiftUI
import RealityKit
import AppKit
import DemiurgeCore

struct RtscScene: NSViewRepresentable {
    let geometry: RtscGeometry
    let onScrollZoom: (CGFloat) -> Void
    var yaw: Float
    var pitch: Float

    func makeNSView(context: Context) -> ARView {
        let view = ScrollableARView(frame: .zero)
        view.environment.background = .color(.windowBackgroundColor)
        view.onScroll = onScrollZoom
        return view
    }

    func updateNSView(_ nsView: ARView, context: Context) {
        nsView.scene.anchors.removeAll()
        let anchor = AnchorEntity(world: .zero)
        let root = Entity()

        // RealityKit unit ≈ 1 m; convert mm.
        let mmToM: Float = 0.001
        let length = Float(geometry.lengthMM) * mmToM

        // Rings are drawn inner → outer so RealityKit's transparent
        // pass renders the cryostat last; the inner solid rings
        // become visible through the translucent shell + bore.
        for ring in geometry.rings {
            let rOuter = Float(ring.outerRadiusMM) * mmToM
            let rInner = Float(ring.innerRadiusMM) * mmToM
            guard rOuter > rInner else { continue }
            // Real annular tube — no z-fight with the neighbouring
            // ring because the inner surface stops exactly at the
            // previous ring's outer surface.
            let mesh = MeshResource.generateAnnulus(
                height: length,
                innerRadius: rInner,
                outerRadius: rOuter,
                segments: 64)
            var material = PhysicallyBasedMaterial()
            let nsColor = NSColor(hexString: ring.colorHex)
            material.baseColor = .init(tint: nsColor)
            material.roughness = .init(floatLiteral: 0.35)
            let isMetal = ring.material.contains("copper")
                || ring.material.contains("stainless")
                || ring.material.contains("REBCO")
            material.metallic = .init(floatLiteral: isMetal ? 0.85 : 0.1)
            if ring.opacity < 0.999 {
                material.blending = .transparent(
                    opacity: .init(floatLiteral: Float(ring.opacity)))
            }
            let entity = ModelEntity(mesh: mesh, materials: [material])
            entity.position = [0, 0, 0]
            // Lay solenoid on its side (axis along world X) so the
            // viewer sees the bore rather than the end-cap.
            entity.transform.rotation = simd_quatf(
                angle: .pi / 2, axis: [0, 0, 1])
            root.addChild(entity)
        }

        // Camera frame + orbit.
        root.transform.rotation = simd_quatf(angle: yaw, axis: [0, 1, 0])
            * simd_quatf(angle: pitch, axis: [1, 0, 0])
        anchor.addChild(root)

        // Pull the camera back enough to frame the full solenoid.
        let camera = PerspectiveCamera()
        camera.transform.translation = [0, 0, 0.5]
        camera.camera.fieldOfViewInDegrees = 50
        anchor.addChild(camera)

        // Soft directional light so the coil materials aren't flat.
        let light = DirectionalLight()
        light.light.intensity = 1800
        light.shadow = DirectionalLightComponent.Shadow(
            maximumDistance: 4, depthBias: 1.0)
        light.transform.rotation = simd_quatf(
            angle: -0.6, axis: [1, 0, 0])
        anchor.addChild(light)

        nsView.scene.anchors.append(anchor)
    }
}

struct RtscView3D: View {
    let geometry: RtscGeometry
    @State private var yaw: Float = 0.6
    @State private var pitch: Float = 0.25
    @State private var zoom: Float = 1.0

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                RtscScene(geometry: geometry,
                          onScrollZoom: { dy in
                              zoom = max(0.25, min(3.0, zoom + Float(dy) * 0.01))
                          },
                          yaw: yaw, pitch: pitch)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { v in
                                yaw += Float(v.translation.width) * 0.005
                                pitch = max(-1.5, min(1.5,
                                    pitch + Float(v.translation.height) * 0.005))
                            }
                    )
                    .scaleEffect(CGFloat(zoom))
                    .background(Color(.windowBackgroundColor))
                VStack(alignment: .leading, spacing: 4) {
                    Text(geometry.displayName)
                        .font(.headline)
                    Text("L \(Int(geometry.lengthMM)) mm · "
                         + "turns \(geometry.turns) · "
                         + "\(geometry.rings.count) rings")
                        .font(.caption.monospaced())
                    Text("g3 · GATE_OPEN · procedural HTS proxy")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(10)
                .background(Color(.windowBackgroundColor).opacity(0.7))
                .cornerRadius(6)
                .padding(12)
            }
            Divider()
            List(geometry.rings) { ring in
                HStack {
                    Circle()
                        .fill(Color(NSColor(hexString: ring.colorHex)))
                        .frame(width: 12, height: 12)
                    VStack(alignment: .leading) {
                        Text(ring.name).font(.caption.bold())
                        Text("\(ring.plainName) · \(ring.material)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text("r \(Int(ring.innerRadiusMM))–\(Int(ring.outerRadiusMM)) mm")
                        .font(.caption2.monospaced())
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 2)
            }
            .frame(height: 180)
        }
    }
}

// MARK: - Annulus mesh

/// Build a hollow tube (annulus extruded along Y) with proper inner /
/// outer / cap normals so neighbouring rings don't z-fight and the
/// inner surface is visible through translucent outer shells.
///
/// `innerRadius == 0` collapses cleanly to a solid disk (the inner
/// strip degenerates to a line — the renderer drops zero-area
/// triangles).
private extension MeshResource {
    static func generateAnnulus(
        height: Float,
        innerRadius: Float,
        outerRadius: Float,
        segments: Int
    ) -> MeshResource {
        var positions: [SIMD3<Float>] = []
        var normals: [SIMD3<Float>] = []
        var indices: [UInt32] = []
        let halfH = height * 0.5
        let n = max(segments, 8)

        // ── outer side: outward normals
        let outerSideBase = UInt32(positions.count)
        for k in 0...n {
            let t = Float(k) / Float(n) * 2 * .pi
            let cx = cos(t), cz = sin(t)
            positions.append(SIMD3(outerRadius * cx, -halfH, outerRadius * cz))
            normals.append(SIMD3(cx, 0, cz))
            positions.append(SIMD3(outerRadius * cx, +halfH, outerRadius * cz))
            normals.append(SIMD3(cx, 0, cz))
        }
        for k in 0..<n {
            let b0 = outerSideBase + UInt32(k * 2)
            let t0 = b0 + 1
            let b1 = b0 + 2
            let t1 = b0 + 3
            indices.append(contentsOf: [b1, t0, b0])
            indices.append(contentsOf: [b1, t1, t0])
        }

        // ── inner side: inward normals, reversed winding
        let innerSideBase = UInt32(positions.count)
        for k in 0...n {
            let t = Float(k) / Float(n) * 2 * .pi
            let cx = cos(t), cz = sin(t)
            positions.append(SIMD3(innerRadius * cx, -halfH, innerRadius * cz))
            normals.append(SIMD3(-cx, 0, -cz))
            positions.append(SIMD3(innerRadius * cx, +halfH, innerRadius * cz))
            normals.append(SIMD3(-cx, 0, -cz))
        }
        for k in 0..<n {
            let b0 = innerSideBase + UInt32(k * 2)
            let t0 = b0 + 1
            let b1 = b0 + 2
            let t1 = b0 + 3
            indices.append(contentsOf: [b0, t0, b1])
            indices.append(contentsOf: [t0, t1, b1])
        }

        // ── top cap (y = +halfH, normal +Y), annular ring
        let topCapBase = UInt32(positions.count)
        for k in 0...n {
            let t = Float(k) / Float(n) * 2 * .pi
            let cx = cos(t), cz = sin(t)
            positions.append(SIMD3(outerRadius * cx, +halfH, outerRadius * cz))
            normals.append(SIMD3(0, 1, 0))
            positions.append(SIMD3(innerRadius * cx, +halfH, innerRadius * cz))
            normals.append(SIMD3(0, 1, 0))
        }
        for k in 0..<n {
            let o0 = topCapBase + UInt32(k * 2)
            let i0 = o0 + 1
            let o1 = o0 + 2
            let i1 = o0 + 3
            indices.append(contentsOf: [o0, o1, i0])
            indices.append(contentsOf: [i0, o1, i1])
        }

        // ── bottom cap (y = -halfH, normal -Y), reversed winding
        let botCapBase = UInt32(positions.count)
        for k in 0...n {
            let t = Float(k) / Float(n) * 2 * .pi
            let cx = cos(t), cz = sin(t)
            positions.append(SIMD3(outerRadius * cx, -halfH, outerRadius * cz))
            normals.append(SIMD3(0, -1, 0))
            positions.append(SIMD3(innerRadius * cx, -halfH, innerRadius * cz))
            normals.append(SIMD3(0, -1, 0))
        }
        for k in 0..<n {
            let o0 = botCapBase + UInt32(k * 2)
            let i0 = o0 + 1
            let o1 = o0 + 2
            let i1 = o0 + 3
            indices.append(contentsOf: [o0, i0, o1])
            indices.append(contentsOf: [i0, i1, o1])
        }

        var descriptor = MeshDescriptor(name: "rtsc_annulus")
        descriptor.positions = MeshBuffer(positions)
        descriptor.normals = MeshBuffer(normals)
        descriptor.primitives = .triangles(indices)
        return try! MeshResource.generate(from: [descriptor])
    }
}

// Convenience: hex → NSColor (mirror of ComponentView3D's helper if any).
private extension NSColor {
    convenience init(hexString: String) {
        var s = hexString
        if s.hasPrefix("#") { s.removeFirst() }
        var rgb: UInt64 = 0
        Scanner(string: s).scanHexInt64(&rgb)
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8)  & 0xFF) / 255.0
        let b = CGFloat( rgb        & 0xFF) / 255.0
        self.init(srgbRed: r, green: g, blue: b, alpha: 1.0)
    }
}
