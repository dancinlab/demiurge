// ComponentView3D — phase ι + λ (rfc_011 §7 ComponentMode, D35).
//
// A RealityKit 3D viewer for a layered `ComponentGeometry`. The
// model is drawn from RealityKit-native box meshes — each layer
// expands by its `LayerRender` (DemiurgeCore `layerBoxes`, shared
// with USDExporter, D50): a PV layer becomes an 8×8 cell grid, the
// frame a 4-side border, the sink a fin array, the mount a base +
// brackets. Layers breathe (assembled ⇄ exploded) and auto-rotate;
// drag orbits, scroll/pinch zooms, presets snap the camera, the
// layer list selects-and-highlights.
//
// Why native meshes, not a loaded .usdz: RealityKit's USD importer
// does not reliably render hand-authored procedural USD, so the
// viewer builds the geometry itself. The .usda/.usdz files are
// still emitted (export menu / `emit-component`) for EXTERNAL use
// — Quick Look, AR, other DCC tools.
//
// HONEST (g3): the bundled BIPV geometry is PROCEDURAL PLACEHOLDER
// — plausible dimensions, not a measured component. The provenance
// banner renders the emitted `ComponentRecord`'s gate verbatim.
//
// Canonical-first (D26 g_swift_native): RealityKit + SwiftUI +
// TimelineView, Apple frameworks only.

import SwiftUI
import RealityKit
import AppKit
import DemiurgeCore

/// Shared handle so the export menu can reach the live ARView for
/// PNG snapshots (an NSViewRepresentable's Coordinator is not
/// otherwise visible to the enclosing SwiftUI view).
final class ComponentSceneHandle {
    weak var arView: ARView?
}

/// An ARView that forwards mouse-wheel scroll to a closure — SwiftUI
/// has no scroll-wheel gesture, so zoom-by-scroll is captured here.
final class ScrollableARView: ARView {
    var onScroll: ((CGFloat) -> Void)?
    override func scrollWheel(with event: NSEvent) {
        onScroll?(event.scrollingDeltaY)
    }
}

/// Camera viewpoint presets (yaw, pitch in radians).
enum CameraPreset: String, CaseIterable {
    case iso, top, front, side
    var label: String {
        switch self {
        case .iso: return "ISO"
        case .top: return "TOP"
        case .front: return "FRONT"
        case .side: return "SIDE"
        }
    }
    var yawPitch: (Float, Float) {
        switch self {
        case .iso:   return (0.6, 0.3)
        case .top:   return (0.0, 1.45)
        case .front: return (0.0, 0.0)
        case .side:  return (1.57, 0.0)
        }
    }
}

/// RealityKit scene wrapped for SwiftUI.
struct ExplodedStackView: NSViewRepresentable {
    /// Procedural slab thickness (RealityKit units) — layer i sits
    /// at `indexY · slabH · spread`; at spread ≈ 1 the slabs touch.
    static let slabH: Float = 0.11
    /// On-screen footprint width (RealityKit units).
    static let viewW: Float = 0.62

    let geometry: ComponentGeometry
    let sceneHandle: ComponentSceneHandle
    let onScrollZoom: (CGFloat) -> Void
    var yaw: Float
    var pitch: Float
    var explode: Float
    var cameraDistance: Float
    var selectedLayer: Int?
    /// Viewport background tracks the system light/dark appearance —
    /// a 3D viewer never uses white (it hides translucent materials
    /// like the glass layer).
    var isDark: Bool

    func makeNSView(context: Context) -> ARView {
        let arView = ScrollableARView(frame: .zero)
        arView.onScroll = { delta in
            DispatchQueue.main.async { onScrollZoom(delta) }
        }
        sceneHandle.arView = arView

        let root = AnchorEntity(world: .zero)
        arView.scene.addAnchor(root)
        context.coordinator.root = root
        context.coordinator.build(geometry)

        let cam = PerspectiveCamera()
        cam.position = [0, 0, cameraDistance]
        let camAnchor = AnchorEntity(world: .zero)
        camAnchor.addChild(cam)
        arView.scene.addAnchor(camAnchor)
        context.coordinator.camera = cam

        return arView
    }

    func updateNSView(_ arView: ARView, context: Context) {
        let coord = context.coordinator
        arView.environment.background = .color(isDark
            ? NSColor(srgbRed: 0.15, green: 0.16, blue: 0.18, alpha: 1)
            : NSColor(srgbRed: 0.80, green: 0.81, blue: 0.84, alpha: 1))
        guard let root = coord.root else { return }
        root.transform.rotation =
            simd_quatf(angle: yaw,   axis: [0, 1, 0]) *
            simd_quatf(angle: pitch, axis: [1, 0, 0])
        coord.camera?.position = [0, 0, cameraDistance]
        // layer groups — indexY·slabH·spread: slabs touch at rest
        // (spread≈1, no z-fighting) and separate widely when
        // exploded (spread up to ~3.6 — a clearly visible breathe).
        let spread = 1.0 + explode * 2.6
        for (i, pair) in coord.layers.enumerated() {
            let nudge: Float = (selectedLayer == i) ? 0.30 : 0
            pair.0.position =
                [nudge, pair.1 * ExplodedStackView.slabH * spread, 0]
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    final class Coordinator {
        var root: AnchorEntity?
        var camera: PerspectiveCamera?
        /// (layer group entity, integer rank) per layer.
        var layers: [(Entity, Float)] = []

        /// Build the layered model from RealityKit-native box meshes
        /// — one group Entity per layer, expanded via `layerBoxes`.
        func build(_ geometry: ComponentGeometry) {
            guard let root = root else { return }
            for c in Array(root.children) { root.removeChild(c) }
            layers.removeAll()

            let n = geometry.layers.count
            let h = ExplodedStackView.slabH
            let scaleXZ = ExplodedStackView.viewW
                / Float(geometry.widthMM)

            for (i, layer) in geometry.layers.enumerated() {
                let group = Entity()
                let scaleY = h / Float(layer.thicknessMM)
                let (r, g, b) = layer.rgb
                let mat = SimpleMaterial(
                    color: NSColor(srgbRed: CGFloat(r),
                                   green: CGFloat(g),
                                   blue: CGFloat(b),
                                   alpha: CGFloat(layer.opacity)),
                    isMetallic: isMetal(layer.render))
                for box in geometry.layerBoxes(i) {
                    let mesh = MeshResource.generateBox(
                        width:  Float(box.sx) * scaleXZ,
                        height: Float(box.sy) * scaleY,
                        depth:  Float(box.sz) * scaleXZ)
                    let ent = ModelEntity(mesh: mesh, materials: [mat])
                    ent.position = [Float(box.cx) * scaleXZ,
                                    Float(box.cy) * scaleY,
                                    Float(box.cz) * scaleXZ]
                    group.addChild(ent)
                }
                let indexY = Float(n - 1) / 2 - Float(i)
                group.position = [0, indexY * h, 0]
                root.addChild(group)
                layers.append((group, indexY))
            }
        }

        private func isMetal(_ r: LayerRender) -> Bool {
            switch r {
            case .frameBorder, .finnedSink, .mountBase: return true
            case .slab, .cellGrid: return false
            }
        }
    }
}

/// ComponentMode CENTER view — animated 3D viewer + honest banner.
struct ComponentView3D: View {
    let stub: ArtifactStub
    private let geometry = ComponentGeometry.bipv5Layer

    @State private var yaw: Float = 0.6
    @State private var pitch: Float = 0.3
    @State private var baseYaw: Float = 0.6
    @State private var basePitch: Float = 0.3
    @State private var cameraDistance: Float = 2.6
    @State private var baseCameraDistance: Float = 2.6
    @State private var autoAnimate = true
    @State private var manualExplode: Double = 1.0
    @State private var selectedLayer: Int?
    @State private var record: ComponentRecord?
    @State private var sceneHandle = ComponentSceneHandle()
    @State private var exportNote: String?
    @Environment(\.colorScheme) private var colorScheme

    /// The emitted .usdz, if `demiurge emit-component` has run — used
    /// only by the export menu (the viewer renders native meshes).
    private var usdzURL: URL? {
        let u = RecordLoader.exportsRoot.appendingPathComponent(
            "component/geometry/\(geometry.id).usdz")
        return FileManager.default.fileExists(atPath: u.path) ? u : nil
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            viewport
            Divider()
            controlBar
            Divider()
            layerList
            Divider()
            banner
        }
        .onAppear(perform: loadRecord)
    }

    // MARK: — header

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(stub.id.display)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
            Text("ComponentMode — \(geometry.displayName) (phase λ)")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
    }

    // MARK: — 3D viewport

    private var viewport: some View {
        TimelineView(.animation) { tl in
            // Double throughout — Float(absolute-epoch) loses ~64 s
            // of precision at today's reference offset, which froze
            // the breathe (frame-to-frame deltas rounded away).
            // Rotation never uses the timeline — yaw/pitch are pure
            // drag-accumulated orbit state.
            let t = tl.date.timeIntervalSinceReferenceDate
            // explode ∈ [0,1]: 0 = assembled, 1 = fully separated.
            let explode: Float = autoAnimate
                ? Float(0.5 + 0.5 * sin(t * 0.55))
                : Float(manualExplode)
            ExplodedStackView(
                geometry: geometry,
                sceneHandle: sceneHandle,
                onScrollZoom: { adjustZoom($0) },
                yaw: yaw,
                pitch: pitch,
                explode: explode,
                cameraDistance: cameraDistance,
                selectedLayer: selectedLayer,
                isDark: colorScheme == .dark)
            .gesture(
                DragGesture()
                    .onChanged { v in
                        yaw = baseYaw + Float(v.translation.width) * 0.01
                        // pitch clamped to ±~85° — a canonical orbit
                        // viewer never lets the model flip past the pole.
                        let p = basePitch
                            + Float(v.translation.height) * 0.01
                        pitch = min(1.5, max(-1.5, p))
                    }
                    .onEnded { _ in
                        baseYaw = yaw
                        basePitch = pitch
                    })
            .simultaneousGesture(
                MagnificationGesture()
                    .onChanged { scale in
                        let d = baseCameraDistance / Float(scale)
                        cameraDistance = min(8.0, max(0.2, d))
                    }
                    .onEnded { _ in baseCameraDistance = cameraDistance })
        }
        .frame(minHeight: 240)
    }

    // MARK: — control bar

    private var controlBar: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                Toggle("자동 분해 애니메이션", isOn: $autoAnimate)
                    .toggleStyle(.checkbox)
                Spacer()
                ForEach(CameraPreset.allCases, id: \.self) { preset in
                    Button(preset.label) { apply(preset) }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                }
                Button("zoom ↺") {
                    cameraDistance = 2.6
                    baseCameraDistance = 2.6
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
            HStack(spacing: 8) {
                Menu("내보내기 ⤓") {
                    Button("USD ASCII (.usda)") { exportUSDA() }
                    Button("USD 패키지 (.usdz)") { exportUSDZ() }
                    Button("STL (.stl)") { exportSTL() }
                    Button("PNG 스냅샷") { exportPNG() }
                }
                .frame(maxWidth: 132)
                if let note = exportNote {
                    Text(note)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                Spacer()
            }
            if !autoAnimate {
                HStack(spacing: 8) {
                    Text("분해").font(.caption).foregroundColor(.secondary)
                    Slider(value: $manualExplode, in: 0...1.4)
                    Text(String(format: "%.2f", manualExplode))
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(12)
    }

    private func apply(_ preset: CameraPreset) {
        let (y, p) = preset.yawPitch
        yaw = y; baseYaw = y
        pitch = p; basePitch = p
    }

    /// Mouse-wheel zoom — scroll up moves the camera closer.
    private func adjustZoom(_ delta: CGFloat) {
        let next = cameraDistance - Float(delta) * 0.05
        cameraDistance = min(8.0, max(0.2, next))
        baseCameraDistance = cameraDistance
    }

    // MARK: — selectable layer list

    private var layerList: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("레이어 (\(geometry.layers.count)겹 · 총 "
                     + "\(fmt(geometry.totalThicknessMM)) mm)")
                    .font(.caption).foregroundColor(.secondary)
                Spacer()
                if selectedLayer != nil {
                    Button("선택 해제") { selectedLayer = nil }
                        .buttonStyle(.borderless)
                        .controlSize(.small)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            ForEach(Array(geometry.layers.enumerated()), id: \.offset) {
                idx, layer in
                layerRow(idx, layer)
            }
        }
    }

    private func layerRow(_ idx: Int, _ layer: ComponentLayer) -> some View {
        let selected = (selectedLayer == idx)
        return HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 2)
                .fill(swatch(layer))
                .frame(width: 14, height: 14)
            VStack(alignment: .leading, spacing: 1) {
                Text(layer.name)
                    .font(.system(.caption, design: .monospaced))
                Text("\(layer.plainName) · \(layer.material)")
                    .font(.caption2).foregroundColor(.secondary)
            }
            Spacer()
            Text("\(fmt(layer.thicknessMM)) mm")
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(selected ? Color.accentColor.opacity(0.18) : Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedLayer = selected ? nil : idx
        }
    }

    private func swatch(_ layer: ComponentLayer) -> Color {
        let (r, g, b) = layer.rgb
        return Color(.sRGB, red: r, green: g, blue: b)
    }

    // MARK: — honest provenance banner

    private var banner: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let rec = record {
                Text("\(rec.provenance.measurementGate.plainGlyph) "
                     + "\(rec.provenance.measurementGate.displayLabel) · "
                     + "absorbed=\(rec.provenance.absorbed) · "
                     + "producer=\(rec.provenance.producer)")
                    .font(.caption).bold()
                ForEach(rec.provenance.scopeCaveats, id: \.self) { c in
                    Text("• \(c)").font(.caption2)
                        .foregroundColor(.secondary)
                }
            } else {
                Text("⚠ PLACEHOLDER — 절차적 5겹 모델입니다. "
                     + "`demiurge emit-component` 로 .usda/.usdz 산출물을 "
                     + "생성하면 provenance 가 여기 표시됩니다 (g3).")
                    .font(.caption2).foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .padding(12)
    }

    // MARK: — helpers

    private func loadRecord() {
        let u = RecordLoader.exportsRoot.appendingPathComponent(
            "component/geometry/\(geometry.id).json")
        guard let data = try? Data(contentsOf: u),
              let rec = try? JSONDecoder().decode(
                ComponentRecord.self, from: data) else {
            record = nil
            return
        }
        record = rec
    }

    private func fmt(_ v: Double) -> String {
        v == v.rounded() ? String(Int(v)) : String(format: "%.1f", v)
    }

    // MARK: — λ-8 export

    /// Run a save panel and report the outcome into `exportNote`.
    private func savePanel(_ name: String,
                           _ write: (URL) throws -> Void) {
        let panel = NSSavePanel()
        panel.nameFieldStringValue = name
        panel.canCreateDirectories = true
        guard panel.runModal() == .OK, let url = panel.url else { return }
        do {
            try write(url)
            exportNote = "저장됨 → \(url.lastPathComponent)"
        } catch {
            exportNote = "저장 실패: \(error.localizedDescription)"
        }
    }

    private func exportUSDA() {
        savePanel("\(geometry.id).usda") { url in
            try USDExporter.usda(geometry)
                .write(to: url, atomically: true, encoding: .utf8)
        }
    }

    private func exportSTL() {
        savePanel("\(geometry.id).stl") { url in
            try STLExporter.stl(geometry)
                .write(to: url, atomically: true, encoding: .utf8)
        }
    }

    private func exportUSDZ() {
        savePanel("\(geometry.id).usdz") { url in
            if let src = usdzURL {
                try? FileManager.default.removeItem(at: url)
                try FileManager.default.copyItem(at: src, to: url)
            } else {
                let tmp = FileManager.default.temporaryDirectory
                    .appendingPathComponent("\(geometry.id)-export.usda")
                try USDExporter.usda(geometry)
                    .write(to: tmp, atomically: true, encoding: .utf8)
                if !USDExporter.packageUSDZ(from: tmp, to: url) {
                    throw ComponentExportError.usdzUnavailable
                }
            }
        }
    }

    private func exportPNG() {
        guard let arView = sceneHandle.arView else {
            exportNote = "PNG 실패: 3D 뷰가 준비되지 않음"
            return
        }
        arView.snapshot(saveToHDR: false) { image in
            DispatchQueue.main.async {
                guard let image = image,
                      let tiff = image.tiffRepresentation,
                      let rep = NSBitmapImageRep(data: tiff),
                      let png = rep.representation(
                        using: .png, properties: [:]) else {
                    exportNote = "PNG 실패: 스냅샷 생성 불가"
                    return
                }
                savePanel("\(geometry.id).png") { url in
                    try png.write(to: url)
                }
            }
        }
    }
}

/// λ-8 export failure surfaced honestly to the user (g3 — no silent
/// fallback to a wrong format).
enum ComponentExportError: LocalizedError {
    case usdzUnavailable
    var errorDescription: String? {
        switch self {
        case .usdzUnavailable:
            return "USD 패키징 도구(usdzip/usdcat)가 없어 .usdz 를 "
                + "만들 수 없습니다 — .usda 로 내보내세요 (g3)."
        }
    }
}
