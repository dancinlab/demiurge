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

/// Inspector sub-tabs (phase δ). Provenance is first per rfc_009 §4 /
/// D39. Data / Citations / DEPENDENCIES land in phase δ-2.
enum InspectorSubTab: String, CaseIterable, Identifiable {
    case provenance = "Provenance"
    case raw        = "Raw JSON"
    var id: String { rawValue }
}

/// Chat message (phase η-1). Backend stays a local stub until phase η-2
/// (Claude Code API) / θ (Claude Code CLI) wire real dispatch (D38).
struct ChatMessage: Identifiable {
    enum Role { case user, assistant }
    let id = UUID()
    let role: Role
    let text: String
}

struct ContentView: View {
    @State private var artifacts: [ArtifactStub] = []
    @State private var selection: ArtifactID?
    @State private var recordResult: Result<F1F2Record, RecordLoaderError>?
    @State private var rawRecordJSON: String = ""        // phase δ — Raw JSON sub-tab
    @State private var leftTab:  LeftTab  = .artifacts   // β: default to Artifacts so the populated tree is visible immediately
    @State private var rightTab: RightTab = .inspector   // D39
    @State private var inspectorSubTab: InspectorSubTab = .provenance  // δ — Provenance first (rfc_009 §4)
    @State private var chatMessages: [ChatMessage] = []                // η-1
    @State private var chatInput: String = ""                         // η-1

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
        rawRecordJSON = (try? String(contentsOfFile: stub.path, encoding: .utf8)) ?? ""
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

    /// LEFT 1st (D37) — Chat tab. Phase η-1: real message-bubble UI +
    /// working input; backend is a local stub. Phase η-2 wires Claude Code
    /// API (conversational); phase θ wires Claude Code CLI (action,
    /// slash-commands) — D38 / @D g_ai_agent_chat_surface.
    @ViewBuilder private var chatTab: some View {
        VStack(spacing: 0) {
            if chatMessages.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Chat")
                        .font(.headline)
                    Text("phase η-1 — UI shell, backend stub")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Claude Code API (conversational) + CLI (action: /synth /measure /verify /analyze) dispatch lands in η-2 / θ. Action replies will carry a full provenance banner (rfc_011 §4.2).")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(chatMessages) { msg in
                        chatBubble(msg)
                    }
                }
                .padding(12)
            }
            Divider()
            HStack(spacing: 8) {
                TextField("type a message…", text: $chatInput)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { sendChat() }
                Button("Send") { sendChat() }
                    .disabled(chatInput.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(12)
        }
    }

    @ViewBuilder private func chatBubble(_ msg: ChatMessage) -> some View {
        HStack(spacing: 0) {
            if msg.role == .user { Spacer(minLength: 20) }
            Text(msg.text)
                .font(.callout)
                .textSelection(.enabled)
                .padding(8)
                .background(
                    (msg.role == .user ? Color.accentColor : Color.secondary)
                        .opacity(0.14)
                )
                .cornerRadius(8)
                .fixedSize(horizontal: false, vertical: true)
            if msg.role == .assistant { Spacer(minLength: 20) }
        }
    }

    /// Phase θ — dispatch chat input to the Claude Code CLI (`claude -p`)
    /// as a subprocess (D34 / D38 / @D g_ai_agent_chat_surface). Since the
    /// `claude` binary is on PATH, the dual-dispatch of D38 collapses onto
    /// one backend: the CLI serves both conversational and action prompts.
    ///
    /// Safety (g3 / @F f6): the prompt is prefixed with a read-only
    /// instruction, and `claude -p` (print mode) without granted tool
    /// permissions cannot run builds / write files from a GUI subprocess
    /// (no way to answer a permission prompt) — so the cockpit chat stays
    /// a *trigger + viewer*, never silently performs synthesis. Real
    /// action dispatch with scoped tool-permissions is phase θ-2.
    private func sendChat() {
        let text = chatInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        chatMessages.append(ChatMessage(role: .user, text: text))
        chatInput = ""
        let thinkingIndex = chatMessages.count
        chatMessages.append(ChatMessage(role: .assistant, text: "… dispatching to Claude Code CLI …"))
        Task {
            let reply = await Self.runClaude(prompt: text)
            await MainActor.run {
                if thinkingIndex < chatMessages.count {
                    chatMessages[thinkingIndex] = ChatMessage(role: .assistant, text: reply)
                }
            }
        }
    }

    /// Invoke `claude -p <prompt>` as a subprocess and capture stdout.
    /// `/usr/bin/env` resolves `claude` on PATH (shell aliases do not apply
    /// to Process, so the `--dangerously-skip-permissions` alias is NOT
    /// inherited — print mode without tool permissions stays read-only).
    private static func runClaude(prompt: String) async -> String {
        let guarded = "[demiurge cockpit chat — answer concisely; do NOT modify files, run builds, or invoke tools] \(prompt)"
        return await withCheckedContinuation { cont in
            DispatchQueue.global(qos: .userInitiated).async {
                let proc = Process()
                proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
                proc.arguments = ["claude", "-p", guarded]
                let pipe = Pipe()
                proc.standardOutput = pipe
                proc.standardError = pipe
                do {
                    try proc.run()
                    let data = pipe.fileHandleForReading.readDataToEndOfFile()
                    proc.waitUntilExit()
                    let out = (String(data: data, encoding: .utf8) ?? "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    if out.isEmpty {
                        cont.resume(returning: "(claude returned no output; exit \(proc.terminationStatus))")
                    } else {
                        cont.resume(returning: out)
                    }
                } catch {
                    cont.resume(returning: "claude invocation failed: \(error.localizedDescription)\n(phase θ — `claude` must be on PATH)")
                }
            }
        }
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

    /// True when the current selection (or picker ad-hoc) is an F1F2 record.
    private var isF1F2Selected: Bool {
        if let sel = selection { return sel.kind == .f1f2 }
        return recordResult != nil          // picker ad-hoc result
    }

    /// RIGHT 1st (D39) — Inspector. Phase δ: F1F2 selection gets sub-tabs
    /// (Provenance / Raw JSON); non-record artifacts show metadata
    /// (Data / Citations / DEPENDENCIES sub-tabs land in phase δ-2).
    @ViewBuilder private var inspectorTab: some View {
        if isF1F2Selected, let result = recordResult {
            VStack(spacing: 0) {
                Picker("sub", selection: $inspectorSubTab) {
                    ForEach(InspectorSubTab.allCases) { t in
                        Text(t.rawValue).tag(t)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding(8)
                Divider()
                switch result {
                case .success(let record):
                    switch inspectorSubTab {
                    case .provenance:
                        ScrollView {
                            ProvenanceBanner(provenance: record.provenance)
                                .padding(16)
                        }
                    case .raw:
                        ScrollView {
                            Text(rawRecordJSON.isEmpty ? "(raw JSON not loaded)" : rawRecordJSON)
                                .font(.system(.caption, design: .monospaced))
                                .textSelection(.enabled)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(16)
                        }
                    }
                case .failure(let err):
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("REJECTED")
                                .font(.system(.title3, design: .monospaced))
                                .foregroundColor(.red)
                            Text(err.errorDescription ?? "unknown error")
                                .font(.callout)
                                .foregroundColor(.red)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(20)
                    }
                }
            }
        } else {
            metadataInspector
        }
    }

    /// Inspector body for Decision / RFC / Domain selections (phase δ
    /// minimum — full per-kind provenance facets land in phase δ-2).
    @ViewBuilder private var metadataInspector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Inspector")
                .font(.headline)
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
                Divider()
                Text("Provenance / Citations / DEPENDENCIES facets for non-record artifacts land in phase δ-2 (rfc_011 §5).")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text("no selection")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
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
        rawRecordJSON = (try? String(contentsOf: url, encoding: .utf8)) ?? ""
    }

    // MARK: — helpers

    @ViewBuilder private func placeholder(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
}
