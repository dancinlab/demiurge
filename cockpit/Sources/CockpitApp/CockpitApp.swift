// Demiurge cockpit — entry point.
// rfc_009 / rfc_010 / rfc_011 + Phase α/α-2/α-3/β (this file at β).
//
// Phase β scope (rfc_011 §10):
//   - LEFT Artifacts tab populated by ArtifactRegistry (5 sections):
//     Records / Decisions / RFCs / Domains / Parameters(deferred ζ).
//   - Sidebar row selection drives CENTER:
//       F1F2 record → RecordView (D29)
//       Decision / RFC / Domain → MarkdownView (β minimum)
//   - Picker (D30) remains for ad-hoc Open Record from any path under
//     ../exports/** (clears sidebar selection; CENTER falls back to
//     recordResult).
//
// Boundary: @D g_cockpit_isolation
//   (a) records strictly read from ../exports/** via RecordLoader
//       (runtime invariant a); navigation docs (design.md / proposals /
//       domains) read READ-ONLY by ArtifactRegistry per D41 clarification.
//   (b/c/d) unchanged.
//
// Canonical-first (D26 g_swift_native): SwiftUI + AppKit + Foundation
// + UniformTypeIdentifiers + DemiurgeCore only.

import SwiftUI
import AppKit
import UniformTypeIdentifiers
import DemiurgeCore

@main
struct CockpitApp: App {
    var body: some Scene {
        WindowGroup("Demiurge Cockpit") {
            ContentView()
        }
    }
}

// MARK: — Tab enums

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
    @State private var artifacts: [ArtifactStub] = []
    @State private var selection: ArtifactID?
    @State private var recordResult: Result<F1F2Record, RecordLoaderError>?
    @State private var leftTab:  LeftTab  = .artifacts   // β: default to Artifacts so the populated tree is visible immediately
    @State private var rightTab: RightTab = .inspector   // D39

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
        .onAppear(perform: bootstrap)
        .onChange(of: selection) { newValue in
            handleSelectionChange(newValue)
        }
    }

    // MARK: — bootstrap

    private func bootstrap() {
        artifacts = ArtifactRegistry.loadAll()
        if selection == nil,
           let firstF1F2 = artifacts.first(where: { $0.id.kind == .f1f2 }) {
            selection = firstF1F2.id
        }
    }

    private func handleSelectionChange(_ newID: ArtifactID?) {
        guard let newID, newID.kind == .f1f2,
              let stub = artifacts.first(where: { $0.id == newID }) else {
            return
        }
        recordResult = RecordLoader.load(relativePath: stub.path)
    }

    // MARK: — LEFT pane

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
        .frame(minWidth: 280)
    }

    /// LEFT 1st (D37) — Chat tab placeholder (Phase η).
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
            Spacer()
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
        .padding(.horizontal, 12)
    }

    /// LEFT 2nd (D33) — Artifacts tree populated by ArtifactRegistry (phase β).
    @ViewBuilder private var artifactsTab: some View {
        List(selection: $selection) {
            ForEach(ArtifactKind.allCases) { kind in
                let stubs = artifacts.filter { $0.id.kind == kind }
                Section("\(kind.rawValue) (\(stubs.count))") {
                    if stubs.isEmpty {
                        placeholder("(empty)")
                    } else {
                        ForEach(stubs) { stub in
                            row(stub)
                                .tag(stub.id)
                        }
                    }
                }
            }
            Section("Parameters") {
                placeholder("phase ζ — gate · node · absorbed filters")
            }
        }
        .listStyle(.sidebar)
    }

    @ViewBuilder private func row(_ stub: ArtifactStub) -> some View {
        HStack(spacing: 8) {
            Text(stub.id.display)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
                .frame(width: 70, alignment: .leading)
            Text(stub.title)
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }

    // MARK: — CENTER canvas

    @ViewBuilder private var canvas: some View {
        Group {
            if let sel = selection,
               let stub = artifacts.first(where: { $0.id == sel }) {
                switch sel.kind {
                case .f1f2:
                    if let result = recordResult {
                        RecordView(result: result)
                    } else {
                        ProgressView("loading record…")
                    }
                case .decision, .rfc, .domain:
                    MarkdownView(stub: stub)
                }
            } else if let result = recordResult {
                RecordView(result: result)
            } else {
                ProgressView("loading…")
            }
        }
        .frame(minWidth: 540)
    }

    // MARK: — RIGHT pane

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

    /// RIGHT 1st (D39) — Inspector placeholder (phase δ).
    @ViewBuilder private var inspectorTab: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Inspector")
                .font(.headline)
            Text("phase δ placeholder")
                .font(.caption)
                .foregroundColor(.secondary)
            if let sel = selection,
               let stub = artifacts.first(where: { $0.id == sel }) {
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    LabeledContent("id",    value: stub.id.display)
                    LabeledContent("kind",  value: stub.id.kind.rawValue)
                    LabeledContent("title", value: stub.title)
                    LabeledContent("path",  value: stub.path)
                        .lineLimit(2)
                }
                .font(.system(.caption, design: .monospaced))
            }
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

    /// RIGHT 2nd — Action queue placeholder (phase θ).
    @ViewBuilder private var actionsTab: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Actions")
                .font(.headline)
            Text("phase θ placeholder")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
            Text("AI agent action surface (D34 / @D g_ai_agent_action_surface):")
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
    /// validates invariant (a); REJECTED card on out-of-scope path.
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
        selection = nil               // ad-hoc, not in registry
        recordResult = RecordLoader.load(url: url)
    }

    // MARK: — helpers

    @ViewBuilder private func placeholder(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}
