// Demiurge cockpit — entry point.
// rfc_009 macOS Swift cockpit · D22 design · D27 monorepo · D28 SwiftPM
// · D29 first slice (F1F2 viewer + ProvenanceBanner)
// · D30 file picker (NSOpenPanel pinned to ../exports/**)
// · D31 rfc_010 cockpit-architecture spec
// · Phase α — NavigationSplitView 3-pane shell (this file).
//
// Phase α scope (intentionally narrow per rfc_010 §6):
//   - LEFT (sidebar)  : placeholder sections (Records / Decisions /
//                       RFCs / Domains / Parameters) → phase β populates
//   - CENTER (content): existing D29 single-record view (canvas evolves
//                       to multi-card in phase γ/ε)
//   - RIGHT  (detail) : placeholder inspector → phase δ adds tabs
//                       (Provenance / Data / Citations / Raw)
//
// Each pane lives in NavigationSplitView's three slots — Apple-canonical
// 3-column layout (D26 g_swift_native). No third-party deps.

import SwiftUI
import AppKit
import UniformTypeIdentifiers

@main
struct CockpitApp: App {
    var body: some Scene {
        WindowGroup("Demiurge Cockpit") {
            ContentView()
        }
    }
}

struct ContentView: View {
    /// First-slice default record (D29). Relative to the cockpit/ package
    /// dir (SwiftPM `swift run` sets pwd to package root). Phase β replaces
    /// this entry-point with sidebar tree selection.
    private static let firstSliceRecord =
        "../exports/chip/noc/f1f2/records/2026-05-18_d8_king_tornado_7nm_1ghz.json"

    @State private var result: Result<F1F2Record, RecordLoaderError>?
    @State private var currentDisplayPath: String = firstSliceRecord

    var body: some View {
        NavigationSplitView {
            sidebar
        } content: {
            canvas
        } detail: {
            inspector
        }
        .frame(minWidth: 1100, minHeight: 640)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Open Record…") { presentPicker() }
                    .help("Open an F1F2 JSON record from ../exports/**")
            }
        }
        .onAppear {
            self.result = RecordLoader.load(relativePath: Self.firstSliceRecord)
        }
    }

    // MARK: — LEFT sidebar (phase β placeholder)

    /// Sidebar with placeholder sections matching rfc_010 §4.1 LEFT layout.
    /// Phase β will populate each section by walking `../exports/`,
    /// `../proposals/`, and `../design.md`. The currently-displayed record
    /// is shown in the Records section so the user knows what's loaded.
    @ViewBuilder private var sidebar: some View {
        List {
            Section("Records") {
                Label {
                    Text(currentDisplayPath)
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .font(.caption)
                } icon: {
                    Image(systemName: "doc.text")
                }
            }
            Section("Decisions") {
                placeholder("phase β — design.md walk")
            }
            Section("RFCs") {
                placeholder("phase β — proposals/* walk")
            }
            Section("Domains") {
                placeholder("phase β — domains/*.md walk")
            }
            Section("Parameters") {
                placeholder("phase ζ — gate · node · absorbed filters")
            }
        }
        .listStyle(.sidebar)
        .frame(minWidth: 240)
    }

    // MARK: — CENTER canvas (D29 single-record view; phase γ adds card protocol)

    @ViewBuilder private var canvas: some View {
        Group {
            if let result {
                RecordView(result: result)
            } else {
                ProgressView("loading record …")
            }
        }
        .frame(minWidth: 540)
    }

    // MARK: — RIGHT inspector (phase δ placeholder)

    /// Placeholder inspector. Phase δ replaces this with a selection-bound
    /// view containing Provenance / Data / Citations / Raw tabs and the
    /// DEPENDENCIES list (rfc_010 §3.2.6, §5.1).
    @ViewBuilder private var inspector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Inspector")
                .font(.headline)
            Text("phase δ placeholder")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
            Text("Selection-bound details will land here:")
                .font(.callout)
                .foregroundColor(.secondary)
            VStack(alignment: .leading, spacing: 4) {
                Text("• Provenance tab (verbatim, default)")
                Text("• Data tab (record fields)")
                Text("• Citations tab (resolved atlas refs)")
                Text("• Raw JSON tab")
                Text("• DEPENDENCIES list (citation graph)")
            }
            .font(.callout)
            .foregroundColor(.secondary)
            Spacer()
        }
        .padding(20)
        .frame(minWidth: 300)
    }

    // MARK: — picker (D30)

    /// NSOpenPanel pinned to `RecordLoader.f1f2RecordsRoot`. Loader runtime-
    /// validates the URL (`@D g_cockpit_isolation` a) so paths outside
    /// `../exports/**` surface as REJECTED cards.
    private func presentPicker() {
        let panel = NSOpenPanel()
        panel.title = "Open F1F2 record"
        panel.message = "Select a record under ../exports/** (typed-consumer scope, @D g_cockpit_isolation)."
        panel.directoryURL = RecordLoader.f1f2RecordsRoot
        panel.allowedContentTypes = [.json]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        guard panel.runModal() == .OK, let url = panel.url else { return }
        self.currentDisplayPath = url.path
        self.result = RecordLoader.load(url: url)
    }

    // MARK: — helpers

    @ViewBuilder private func placeholder(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.secondary)
    }
}
