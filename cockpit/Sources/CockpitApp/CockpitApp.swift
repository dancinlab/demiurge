// Demiurge cockpit — entry point.
// rfc_009 / rfc_010 / rfc_011 (viewer) → rfc_012 (project workbench).
//
// Phase κ-1 scope (rfc_012, design.md D42–D48):
//   - viewer → WORKBENCH: a 3-column single screen (rfc_012 §5).
//       ① recipe rail (narrow)  — 7-verb spine, done/current/upcoming.
//       ③ LLM chat   (narrow)   — the "cooking teacher"; drives work.
//       ② work zone  (widest)   — VSplit: top ingredient shelf /
//                                 bottom result + reference browser.
//   - ④ top toolbar: `+` project creation (NewProjectSheet, §3),
//       project switch menu, 7-step progress, expert toggle (§4),
//       light/dark.
//   - Project = the cockpit's own work-state (in-memory in κ-1;
//       Application Support manifest persistence lands κ-2 — D45).
//
// Boundary: @D g_cockpit_isolation
//   (a) records strictly read from ../exports/** via RecordLoader;
//       navigation docs read-only via ArtifactRegistry (D41).
//   (e) the cockpit may hold its own app-state (Project) — NOT a
//       record, NOT under exports/ (D45). κ-1 keeps it in-memory.
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
        WindowGroup("Demiurge") {
            WorkbenchView()
        }
    }
}

/// Chat message (phase η-1). Backend = Claude Code CLI subprocess.
struct ChatMessage: Identifiable {
    enum Role { case user, assistant }
    let id = UUID()
    let role: Role
    let text: String
}

// MARK: — Workbench (rfc_012 §5)

struct WorkbenchView: View {
    // ④ project state — in-memory in κ-1 (D45 manifest persistence = κ-2).
    @State private var projects: [Project] = []
    @State private var activeProjectID: Project.ID?
    @State private var showNewProject = false

    // ④ display toggles.
    @State private var colorScheme: ColorScheme = .light   // light default
    @State private var expertMode = false                  // §4 — plain by default

    // ③ chat.
    @State private var chatMessages: [ChatMessage] = []
    @State private var chatInput = ""

    // ② reference browser — the original viewer role (rfc_012 §7).
    @State private var artifacts: [ArtifactStub] = []
    @State private var refSelection: ArtifactID?
    @State private var recordResult: Result<F1F2Record, RecordLoaderError>?

    private var activeProject: Project? {
        projects.first { $0.id == activeProjectID }
    }

    var body: some View {
        NavigationSplitView {
            recipeRail
                .navigationSplitViewColumnWidth(min: 150, ideal: 184, max: 240)
        } content: {
            chatColumn
                .navigationSplitViewColumnWidth(min: 280, ideal: 340, max: 460)
        } detail: {
            workZone
        }
        .frame(minWidth: 1180, minHeight: 680)
        .toolbar { toolbarContent }
        .preferredColorScheme(colorScheme)
        .sheet(isPresented: $showNewProject) {
            NewProjectSheet { project in
                projects.append(project)
                activeProjectID = project.id
                seedChat(for: project)
            }
        }
        .onAppear { artifacts = ArtifactRegistry.loadAll() }
        .onChange(of: refSelection) { _, newValue in
            handleRefSelection(newValue)
        }
    }

    // MARK: — ④ toolbar

    @ToolbarContentBuilder private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button { showNewProject = true } label: {
                Label("새 프로젝트", systemImage: "plus")
            }
            .help("새 프로젝트 만들기 (rfc_012 §3)")
        }
        ToolbarItem(placement: .navigation) {
            projectMenu
        }
        ToolbarItem(placement: .principal) {
            progressBar
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle(isOn: $expertMode) {
                Label("전문가 모드", systemImage: "wrench.and.screwdriver")
            }
            .toggleStyle(.button)
            .help(expertMode
                  ? "전문가 모드 — GATE_* / provenance 원문 표시 (§4)"
                  : "쉬운 말 모드 — ⏳ / 🔶 / ✅ 신호등 표시 (§4)")
        }
        ToolbarItem(placement: .primaryAction) {
            Button {
                colorScheme = (colorScheme == .light) ? .dark : .light
            } label: {
                Image(systemName: colorScheme == .light ? "moon" : "sun.max")
            }
            .help("밝게 / 어둡게")
        }
    }

    private var projectMenu: some View {
        Menu {
            if projects.isEmpty {
                Text("프로젝트 없음")
            }
            ForEach(projects) { project in
                Button {
                    activeProjectID = project.id
                } label: {
                    if project.id == activeProjectID {
                        Label(project.name, systemImage: "checkmark")
                    } else {
                        Text(project.name)
                    }
                }
            }
        } label: {
            Text(activeProject?.name ?? "프로젝트 선택")
        }
        .help("프로젝트 전환")
    }

    /// ④ 7-step progress bar — the verb spine, current verb highlighted.
    private var progressBar: some View {
        HStack(spacing: 4) {
            ForEach(Verb.allCases) { verb in
                let state = activeProject?.state(of: verb) ?? .upcoming
                Text(expertMode ? verb.canonical : verb.plain)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule().fill(progressTint(state).opacity(0.18))
                    )
                    .foregroundStyle(progressTint(state))
                if verb != Verb.allCases.last {
                    Image(systemName: "chevron.compact.right")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }
        }
    }

    private func progressTint(_ state: VerbState) -> Color {
        switch state {
        case .done:     return .green
        case .current:  return .accentColor
        case .upcoming: return .secondary
        }
    }

    // MARK: — ① recipe rail (rfc_012 §5)

    @ViewBuilder private var recipeRail: some View {
        List {
            Section(expertMode ? "7-verb spine" : "7단계 레시피") {
                ForEach(Verb.allCases) { verb in
                    verbRow(verb)
                }
            }
            if activeProject == nil {
                Section {
                    Text("＋ 로 첫 프로젝트를 만들면\n레시피가 켜집니다.")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .listStyle(.sidebar)
    }

    @ViewBuilder private func verbRow(_ verb: Verb) -> some View {
        let state = activeProject?.state(of: verb) ?? .upcoming
        HStack(spacing: 8) {
            Image(systemName: verbRowSymbol(state, verb: verb))
                .foregroundStyle(progressTint(state))
                .frame(width: 18)
            VStack(alignment: .leading, spacing: 1) {
                Text(expertMode ? verb.canonical : verb.plain)
                    .font(.callout)
                    .foregroundStyle(state == .upcoming ? .secondary : .primary)
                if !expertMode {
                    Text(verb.canonical)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 2)
    }

    private func verbRowSymbol(_ state: VerbState, verb: Verb) -> String {
        switch state {
        case .done:     return "checkmark.circle.fill"
        case .current:  return "circle.inset.filled"
        case .upcoming: return verb.symbol
        }
    }

    // MARK: — ③ LLM chat ("cooking teacher", rfc_012 §5)

    @ViewBuilder private var chatColumn: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Text("🍳")
                Text(expertMode ? "LLM chat" : "요리 선생님")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)
            .padding(.bottom, 6)
            Divider()

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    if chatMessages.isEmpty {
                        Text(activeProject == nil
                             ? "왼쪽 위 ＋ 로 프로젝트를 만들면\n여기서 대화로 설계를 진행합니다."
                             : "무엇이든 물어보세요 — 대화로 7단계를 진행합니다.")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    ForEach(chatMessages) { msg in
                        chatBubble(msg)
                    }
                }
                .padding(12)
            }

            Divider()
            HStack(spacing: 8) {
                TextField("입력…", text: $chatInput)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { sendChat() }
                Button("보내기") { sendChat() }
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

    /// Greet a freshly created project — the teacher opens verb 1.
    private func seedChat(for project: Project) {
        chatMessages = [
            ChatMessage(
                role: .assistant,
                text: "🍳 \"\(project.name)\" 프로젝트를 시작했어요. "
                    + "'\(project.target)' — \(project.domain) 분야로 잡았습니다. "
                    + "1단계 \(Verb.specify.plain)(\(Verb.specify.canonical))부터 "
                    + "같이 정리해 볼까요?")
        ]
    }

    // MARK: — ② work zone (rfc_012 §5 — widest, VSplit)

    @ViewBuilder private var workZone: some View {
        VSplitView {
            ingredientShelf
                .frame(minHeight: 64, idealHeight: 96, maxHeight: 168)
            resultZone
                .frame(minHeight: 320)
        }
        .navigationTitle(activeProject?.name ?? "Demiurge")
    }

    /// ② top — ingredient shelf (rfc_012 §5). Phase κ-1 placeholder;
    /// the option-pick → "[냄비에 넣기]" → next chat turn lands κ-2.
    @ViewBuilder private var ingredientShelf: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(expertMode ? "Ingredient shelf" : "재료 선반",
                  systemImage: "tray.full")
                .font(.subheadline.weight(.medium))
            Text("설계 옵션을 골라 \"[냄비에 넣기]\" 로 대화에 넘기는 자리입니다 — phase κ-2.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
    }

    /// ② bottom — result visualization + reference browser (§5 / §7).
    @ViewBuilder private var resultZone: some View {
        if activeProject == nil {
            emptyWorkbench
        } else {
            VStack(spacing: 0) {
                projectResultHeader
                Divider()
                referenceBrowser
            }
        }
    }

    private var emptyWorkbench: some View {
        VStack(spacing: 12) {
            Image(systemName: "plus.viewfinder")
                .font(.system(size: 44))
                .foregroundStyle(.tertiary)
            Text("아직 프로젝트가 없습니다")
                .font(.title3)
            Text("왼쪽 위 ＋ 버튼으로 첫 프로젝트를 만들어 보세요.")
                .font(.callout)
                .foregroundStyle(.secondary)
            Button {
                showNewProject = true
            } label: {
                Label("새 프로젝트", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
    }

    private var projectResultHeader: some View {
        HStack(spacing: 8) {
            Image(systemName: "hourglass")
                .foregroundStyle(.orange)
            VStack(alignment: .leading, spacing: 1) {
                Text(expertMode ? "Project records — none" : "이 프로젝트 결과 — 아직 없음")
                    .font(.subheadline.weight(.medium))
                Text(expertMode
                     ? "θ-2 run path emits measured records here (g3)."
                     : "측정을 돌리면 결과가 여기에 ✅ 로 쌓입니다.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(12)
    }

    /// Reference browser — the cockpit's original viewer role: the ~50
    /// existing exports/ records are viewable but never folded into the
    /// project (rfc_012 §7, D47 option C).
    @ViewBuilder private var referenceBrowser: some View {
        HSplitView {
            List(selection: $refSelection) {
                Section(expertMode ? "exports/** (reference)" : "참고 자료 (기존 측정 기록)") {
                    let records = artifacts.filter { $0.id.kind == .f1f2 }
                    if records.isEmpty {
                        Text("(없음)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    ForEach(records) { stub in
                        Text(stub.title)
                            .font(.caption)
                            .lineLimit(1)
                            .tag(stub.id)
                    }
                }
            }
            .frame(minWidth: 200, maxWidth: 300)

            referenceCanvas
                .frame(minWidth: 360)
        }
    }

    @ViewBuilder private var referenceCanvas: some View {
        Group {
            if let result = recordResult {
                RecordView(result: result)
            } else {
                VStack(spacing: 8) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.largeTitle)
                        .foregroundStyle(.tertiary)
                    Text("참고 자료에서 측정 기록을 선택하세요")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(40)
            }
        }
    }

    private func handleRefSelection(_ newID: ArtifactID?) {
        guard let newID, newID.kind == .f1f2,
              let stub = artifacts.first(where: { $0.id == newID }) else {
            return
        }
        recordResult = RecordLoader.load(relativePath: stub.path)
    }

    // MARK: — chat dispatch (phase η-1 / θ — Claude Code CLI)

    /// Dispatch chat input to the Claude Code CLI (`claude -p`) as a
    /// subprocess (D34 / D38 / @D g_ai_agent_chat_surface). Read-only:
    /// print mode without granted tool permissions cannot write files
    /// or run builds from a GUI subprocess — the chat stays a trigger +
    /// viewer (g3 / @F f6). Scoped action dispatch is phase θ-2.
    private func sendChat() {
        let text = chatInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        chatMessages.append(ChatMessage(role: .user, text: text))
        chatInput = ""
        let thinkingIndex = chatMessages.count
        chatMessages.append(ChatMessage(role: .assistant, text: "🍳 … 생각 중 …"))
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
    /// `/usr/bin/env` resolves `claude` on PATH; shell aliases (and so
    /// `--dangerously-skip-permissions`) are NOT inherited by Process —
    /// print mode without tool permissions stays read-only.
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
}
