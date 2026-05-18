// ComponentView3D — phase ι (rfc_011 §7 ComponentMode / §9, D35).
// RealityKit placeholder exploded-isometric 3D viewer. Mouse-drag
// rotates the stack (D35 — rotate only, NO auto-animation).
//
// HONEST (g3): the 5-layer box stack is PROCEDURAL PLACEHOLDER
// geometry, NOT a real component record. `../exports/**` holds zero
// USDZ/STL geometry — no component-domain producer has emitted any.
// This view demonstrates the viewer + mouse-drag interaction and is
// explicitly labelled "PLACEHOLDER" so it is never mistaken for
// measured component data. When a producer emits real USDZ, the
// procedural stack is swapped for a loaded ModelEntity (phase ι-2).
//
// Canonical-first (D26 g_swift_native): RealityKit + SwiftUI, Apple
// frameworks only — no third-party 3D engine.

import SwiftUI
import RealityKit
import AppKit
import DemiurgeCore

/// RealityKit scene wrapped for SwiftUI. A non-AR `ARView` hosts a
/// procedural exploded box stack; `yaw`/`pitch` rotate its root anchor.
struct ExplodedStackView: NSViewRepresentable {
    var yaw: Float
    var pitch: Float

    func makeNSView(context: Context) -> ARView {
        // macOS RealityKit has no ARKit session — `ARView(frame:)` is a
        // plain virtual 3D viewport (the AR/visionOS spatial path, the
        // reason D35 picked RealityKit, kicks in on those platforms).
        let arView = ARView(frame: .zero)

        // exploded BIPV-style placeholder stack — 5 layers, top→bottom
        let root = AnchorEntity(world: .zero)
        let layers: [(SIMD3<Float>, NSColor)] = [
            ([0,  0.40, 0], .systemTeal),    // Glass Face
            ([0,  0.20, 0], .systemIndigo),  // PV Cells
            ([0,  0.00, 0], .systemGray),    // Corrosion-Proof Frame
            ([0, -0.20, 0], .systemOrange),  // Thermal Sink
            ([0, -0.40, 0], .darkGray),      // Structural Mount
        ]
        for (pos, color) in layers {
            let mesh = MeshResource.generateBox(width: 0.7, height: 0.05, depth: 0.7)
            let mat  = SimpleMaterial(color: color, isMetallic: false)
            let ent  = ModelEntity(mesh: mesh, materials: [mat])
            ent.position = pos
            root.addChild(ent)
        }
        arView.scene.addAnchor(root)
        context.coordinator.root = root

        // camera (non-AR scene needs an explicit camera)
        let cam = PerspectiveCamera()
        cam.position = [0, 0, 2.6]
        let camAnchor = AnchorEntity(world: .zero)
        camAnchor.addChild(cam)
        arView.scene.addAnchor(camAnchor)

        return arView
    }

    func updateNSView(_ arView: ARView, context: Context) {
        guard let root = context.coordinator.root else { return }
        root.transform.rotation =
            simd_quatf(angle: yaw,   axis: [0, 1, 0]) *
            simd_quatf(angle: pitch, axis: [1, 0, 0])
    }

    func makeCoordinator() -> Coordinator { Coordinator() }
    final class Coordinator { var root: AnchorEntity? }
}

/// ComponentMode CENTER view — exploded-isometric 3D + honest
/// placeholder banner.
struct ComponentView3D: View {
    let stub: ArtifactStub
    @State private var yaw: Float   = 0.6
    @State private var pitch: Float = 0.3
    @State private var baseYaw: Float   = 0.6
    @State private var basePitch: Float = 0.3

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                Text(stub.id.display)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.secondary)
                Text("ComponentMode — exploded-isometric 3D viewer (phase ι)")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            Divider()

            ExplodedStackView(yaw: yaw, pitch: pitch)
                .gesture(
                    DragGesture()
                        .onChanged { v in
                            yaw   = baseYaw   + Float(v.translation.width)  * 0.01
                            pitch = basePitch + Float(v.translation.height) * 0.01
                        }
                        .onEnded { _ in
                            baseYaw   = yaw
                            basePitch = pitch
                        }
                )

            Divider()
            Text("⚠ PLACEHOLDER geometry — procedural 5-layer box stack "
               + "(Glass · PV · Frame · Sink · Mount). NOT a real component "
               + "record: ../exports/** holds zero USDZ/STL. When a "
               + "component-domain producer emits real geometry, this view "
               + "loads it (phase ι-2). Mouse-drag rotates (D35 — no "
               + "auto-animation).")
                .font(.caption)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
        }
    }
}
