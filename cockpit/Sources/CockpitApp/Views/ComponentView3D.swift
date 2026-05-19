// ComponentView3D — phase ι (rfc_011 §7 ComponentMode / §9, D35).
// RealityKit placeholder exploded-isometric 3D viewer.
//
// κ-28: auto-animation landed — the 5-layer stack continuously
// "breathes" (assembled ⇄ exploded) and auto-rotates; a mouse-drag
// adds a manual yaw/pitch offset on top (D35's rotate path kept, the
// "NO auto-animation" clause superseded by this demo animation).
//
// HONEST (g3): the 5-layer box stack is PROCEDURAL PLACEHOLDER
// geometry, NOT a real component record. `../exports/**` holds zero
// USDZ/STL geometry — no component-domain producer has emitted any.
// The animation is a viewer demo, NOT measured component motion.
// When a producer emits real USDZ, the procedural stack is swapped
// for a loaded ModelEntity (phase ι-2) — that is a separate gate.
//
// Canonical-first (D26 g_swift_native): RealityKit + SwiftUI +
// TimelineView, Apple frameworks only — no third-party 3D engine.

import SwiftUI
import RealityKit
import AppKit
import DemiurgeCore

/// RealityKit scene wrapped for SwiftUI. A non-AR `ARView` hosts a
/// procedural exploded box stack. `yaw`/`pitch` rotate the root;
/// `explode` ∈ [0,1] scales each layer's vertical spread (0 =
/// assembled, 1 = fully exploded).
struct ExplodedStackView: NSViewRepresentable {
    var yaw: Float
    var pitch: Float
    var explode: Float

    func makeNSView(context: Context) -> ARView {
        // macOS RealityKit has no ARKit session — `ARView(frame:)` is
        // a plain virtual 3D viewport (the AR/visionOS spatial path,
        // the reason D35 picked RealityKit, kicks in on those OSes).
        let arView = ARView(frame: .zero)

        let root = AnchorEntity(world: .zero)
        // (baseY, color) — top→bottom BIPV-style placeholder layers.
        let layers: [(Float, NSColor)] = [
            ( 0.40, .systemTeal),    // Glass Face
            ( 0.20, .systemIndigo),  // PV Cells
            ( 0.00, .systemGray),    // Corrosion-Proof Frame
            (-0.20, .systemOrange),  // Thermal Sink
            (-0.40, .darkGray),      // Structural Mount
        ]
        for (baseY, color) in layers {
            let mesh = MeshResource.generateBox(width: 0.7, height: 0.05, depth: 0.7)
            let mat  = SimpleMaterial(color: color, isMetallic: false)
            let ent  = ModelEntity(mesh: mesh, materials: [mat])
            ent.position = [0, baseY, 0]
            root.addChild(ent)
            context.coordinator.layers.append((ent, baseY))
        }
        arView.scene.addAnchor(root)
        context.coordinator.root = root

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
        for (ent, baseY) in context.coordinator.layers {
            // explode 0 → collapsed to y=0; 1 → full baseY spread.
            ent.position = [0, baseY * explode, 0]
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator() }
    final class Coordinator {
        var root: AnchorEntity?
        var layers: [(ModelEntity, Float)] = []
    }
}

/// ComponentMode CENTER view — animated exploded-isometric 3D +
/// honest placeholder banner.
struct ComponentView3D: View {
    let stub: ArtifactStub
    @State private var yaw: Float       = 0.6
    @State private var pitch: Float     = 0.3
    @State private var baseYaw: Float   = 0.6
    @State private var basePitch: Float = 0.3

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
                Text(stub.id.display)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.secondary)
                Text("ComponentMode — animated exploded-isometric 3D (phase ι)")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            Divider()

            // TimelineView(.animation) drives a continuous breathe +
            // auto-rotate; the drag gesture adds a manual offset.
            TimelineView(.animation) { tl in
                let t = Float(tl.date.timeIntervalSinceReferenceDate)
                // breathe: assembled ⇄ exploded, period ≈ 7 s.
                let explode = 0.55 + 0.45 * sin(t * 0.9)
                ExplodedStackView(
                    yaw: yaw + t * 0.25,   // auto-rotate + drag offset
                    pitch: pitch,
                    explode: explode
                )
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
            }

            Divider()
            Text("⚠ PLACEHOLDER geometry — procedural 5-layer box stack "
               + "(Glass · PV · Frame · Sink · Mount), auto exploded-"
               + "breathe + auto-rotate; mouse-drag adds a manual "
               + "offset. NOT a real component record: ../exports/** "
               + "holds zero USDZ/STL. When a component-domain producer "
               + "emits real geometry this view loads it (phase ι-2 — "
               + "a separate gate, g3).")
                .font(.caption)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
        }
    }
}
