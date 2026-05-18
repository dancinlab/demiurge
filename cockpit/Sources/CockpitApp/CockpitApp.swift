// Demiurge cockpit — entry point.
// rfc_009 macOS Swift cockpit · D22 design · D27 monorepo · D28 SwiftPM
// · D29 first slice (F1F2 viewer + ProvenanceBanner)
// · D30 file picker (NSOpenPanel pinned to ../exports/**)
// · D31 rfc_010 cockpit-architecture spec
// · Phase α — NavigationSplitView 3-pane shell (rfc_010)
// · D32..D40 rfc_011 control surface (Quiver-mirror tabbed 4-zone)
// · Phase α-2 — LEFT TabView + RIGHT TabView + TOP toolbar (this file).
//
// Phase α-2 scope (intentionally narrow — rfc_011 §10):
//   LEFT TabView    [Chat (1st, D37)] [Artifacts (2nd, D33)]
//                   Chat tab placeholder for Claude Code CLI+API (D38)
//                   landing in phase η.
//                   Artifacts tab keeps the rfc_010 phase α placeholder
//                   sections — phase β populates by filesystem walk.
//   CENTER          existing D29 RecordView embedded verbatim.
//   RIGHT TabView   [Inspector (1st, D39)] [Action queue (2nd)]
//                   Inspector tab is the phase α RIGHT placeholder
//                   pending phase δ tab realisation.
//                   Action queue tab is a phase θ placeholder for
//                   agent jobs (rfc_011 §6).
//   TOP toolbar     [Open Record…] (D30) + [+ Synthesize] [+ Measure]
//                   disabled-with-help (phase θ — action surface).
//
// Each tab is a single VStack today; phase η/θ/δ/ι fill them in.
// Canonical-first (D26 g_swift_native): SwiftUI + AppKit + Foundation
// + UniformTypeIdentifiers only. No third-party deps.

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

// MARK: — Tab enums (top-level so Picker can iterate)

enum LeftTab: String, CaseIterable, Identifiable {
    case chat       = "Chat"
    case artifacts  = "Artifacts"
    var id: String { rawValue }
}

enum RightTab: String, CaseIterable, Identifiable {
    case inspector  = "Inspector"
    case actions    = "Actions"
    var id: String { rawValue }
}

struct ContentView: View {
    /// First-slice default record (D29). Relative to the cockpit/ package
    /// dir (SwiftPM `swift run` sets pwd to package root). Phase β replaces
    /// this entry-point with Artifacts-tab tree selection.
    private static let firstSliceRecord =
        "../exports/chip/noc/f1f2/records/2026-05-18_d8_king_tornado_7nm_1ghz.json"

    @State private var result: Result<F1F2Record, RecordLoaderError>?
    @State private var currentDisplayPath: String = firstSliceRecord
    @State private var leftTab:  LeftTab  = .chat        // D37 — Chat 1st
    @State private var rightTab: RightTab = .inspector   // D39 — Inspector 1st

    var body: some View {
        NavigationSplitView {
            leftPane
        } content: {
            canvas
        } detail: {
            rightPane
        }
        .frame(minWidth: 1180, minHeight: 660)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("+ Synthesize") {}
                    .disabled(true)
                    .help("Phase θ — AI agent action via Claude Code CLI (D34 / D38). Disabled until the action surface lands.")
            }
            ToolbarItem(placement: .primaryAction) {
                Button("+ Measure") {}
                    .disabled(true)
                    .help("Phase θ — AI agent action via Claude Code CLI (D34 / D38). Disabled until the action surface lands.")
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Open Record…") { presentPicker() }
                    .help("Open an F1F2 JSON record from ../exports/** (D30 picker, @D g_cockpit_isolation a)")
            }
        }
        .onAppear {
            self.result = RecordLoader.load(relativePath: Self.firstSliceRecord)
        }
    }

    // MARK: — LEFT pane (D40 — TabView wrapper around D37 Chat 1st + D33 Artifacts 2nd)

    @ViewBuilder private var leftPane: some View {
        VStack(spacing: 0) {
            Picker("LEFT", selection: $leftTab) {
                ForEach(LeftTab.allCases) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal, 8)
            .padding(.vertical, 8)

            Divider()

            Group {
                switch leftTab {
                case .chat:      chatTab
                case .artifacts: artifactsTab
                }
            }
        }
        .frame(minWidth: 260)
    }

    /// LEFT 1st (D37) — Claude Code CLI + API chat surface placeholder (phase η).
    @ViewBuilder private var chatTab: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Chat")
                .font(.headline)
            Text("phase η placeholder")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("Claude Code CLI + API dual dispatch (D38). Action results render with full provenance banner (rfc_011 §4.2). Slash-commands /synth /measure /verify /analyze route to CLI; otherwise API.")
                .font(.callout)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    placeholder("conversation history renders here")
                    placeholder("AI replies that produce a record carry a ProvenanceBanner inline")
                    placeholder("REJECTED banner on @F f6 (unmeasured outcome claim)")
                }
                .padding(.horizontal, 12)
            }
            Divider()
            HStack(spacing: 8) {
                TextField("type a message…", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                Button("Send") {}
                    .disabled(true)
            }
            .padding(12)
        }
        .padding(.top, 12)
    }

    /// LEFT 2nd (D33) — Artifacts tree placeholder; phase β fills by filesystem walk.
    @ViewBuilder private var artifactsTab: some View {
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
                placeholder("phase β — design.md walk · $D1..$D40")
            }
            Section("RFCs") {
                placeholder("phase β — proposals/* walk · $RFC1..$RFC11")
            }
            Section("Domains") {
                placeholder("phase β — domains/*.md walk · $DOM:chip etc.")
            }
            Section("Parameters") {
                placeholder("phase ζ — gate · node · absorbed filters")
            }
        }
        .listStyle(.sidebar)
    }

    // MARK: — CENTER canvas (rfc_010 §4 — D29 single-record view in v0; phase γ adds card protocol)

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

    // MARK: — RIGHT pane (D40 — TabView wrapper around D39 Inspector 1st + Actions 2nd)

    @ViewBuilder private var rightPane: some View {
        VStack(spacing: 0) {
            Picker("RIGHT", selection: $rightTab) {
                ForEach(RightTab.allCases) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal, 8)
            .padding(.vertical, 8)

            Divider()

            Group {
                switch rightTab {
                case .inspector: inspectorTab
                case .actions:   actionsTab
                }
            }
        }
        .frame(minWidth: 320)
    }

    /// RIGHT 1st (D39) — Inspector / Provenance verbatim placeholder; phase δ realises sub-tabs.
    @ViewBuilder private var inspectorTab: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Inspector")
                .font(.headline)
            Text("phase δ placeholder")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
            Text("Selection-bound sub-tabs (rfc_011 §5):")
                .font(.callout)
                .foregroundColor(.secondary)
            VStack(alignment: .leading, spacing: 4) {
                Text("• Provenance — gate / absorbed / atlas_cite / caveats (default first)")
                Text("• Data — record fields")
                Text("• Citations — resolved atlas references")
                Text("• Raw JSON — verbatim file contents")
                Text("• DEPENDENCIES — citation graph upstream + downstream")
            }
            .font(.callout)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(20)
    }

    /// RIGHT 2nd — Action queue (rfc_011 §6.3, phase θ).
    @ViewBuilder private var actionsTab: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Actions")
                .font(.headline)
            Text("phase θ placeholder")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
            Text("AI agent action surface (D34, @D g_ai_agent_action_surface):")
                .font(.callout)
                .foregroundColor(.secondary)
            VStack(alignment: .leading, spacing: 4) {
                Text("• Running jobs — Claude Code CLI subprocesses")
                Text("• Tool calls log (Bash / Write / Read)")
                Text("• New records emitted to ../exports/**")
                Text("• Per-job progress + result-record link")
            }
            .font(.callout)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(20)
    }

    // MARK: — picker (D30)

    /// NSOpenPanel pinned to `RecordLoader.f1f2RecordsRoot`. Loader runtime-
    /// validates the URL (`@D g_cockpit_isolation` invariant a) so paths outside
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
            .fixedSize(horizontal: false, vertical: true)
    }
}
