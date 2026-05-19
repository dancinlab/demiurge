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
/// `.rejected` = an over-claim REJECTED banner (rfc_011 §4.2 / @F f6).
struct ChatMessage: Identifiable {
    enum Role { case user, assistant, rejected }
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
    @State private var showDeleteConfirm = false

    // ④ display toggles.
    @State private var colorScheme: ColorScheme = .light   // light default
    @State private var expertMode = false                  // §4 — plain by default

    // ③ chat.
    @State private var chatMessages: [ChatMessage] = []
    @State private var chatInput = ""

    // ② ingredient-shelf picks (group title → chosen option).
    @State private var shelfPicks: [String: String] = [:]

    // θ-2 "▶ 실제로 돌리기" action in flight (D49).
    @State private var isRunningAction = false

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
                try? ProjectStore.save(project)          // D45 — App Support manifest
                projects.append(project)
                activeProjectID = project.id
                seedChat(for: project)
            }
        }
        .confirmationDialog(
            "이 프로젝트를 삭제할까요?",
            isPresented: $showDeleteConfirm,
            titleVisibility: .visible
        ) {
            Button("삭제", role: .destructive) { deleteActiveProject() }
            Button("취소", role: .cancel) {}
        } message: {
            if let project = activeProject {
                Text("\"\(project.name)\" 의 manifest 가 삭제됩니다. "
                     + "exports/ 의 측정 기록은 영향받지 않습니다.")
            }
        }
        .onAppear {
            artifacts = ArtifactRegistry.loadAll()
            projects = ProjectStore.loadAll()            // D45 — restore manifests
            if activeProjectID == nil { activeProjectID = projects.last?.id }
        }
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
            if let active = activeProject {
                Divider()
                Button(role: .destructive) {
                    showDeleteConfirm = true
                } label: {
                    Label("\"\(active.name)\" 삭제", systemImage: "trash")
                }
            }
        } label: {
            Text(activeProject?.name ?? "프로젝트 선택")
        }
        .help("프로젝트 전환 / 삭제")
    }

    /// Delete the active project's manifest (D45) and drop it from the
    /// in-memory list; exports/ records are never touched (rfc_012 §7).
    private func deleteActiveProject() {
        guard let project = activeProject else { return }
        try? ProjectStore.delete(project)
        projects.removeAll { $0.id == project.id }
        activeProjectID = projects.last?.id
        chatMessages = []
        shelfPicks = [:]
    }

    // MARK: — verb progress (rfc_012 §5 / D48)

    /// Step the active project's verb pointer forward and re-save its
    /// manifest. Conversation-default progress (D48) — the pointer
    /// moves, but a stage turns ✅ only via a measured θ-2 record (g3).
    private func advanceVerb() {
        guard var project = activeProject else { return }
        project.advance()
        persistActive(project)
        announceVerb(project)
    }

    private func retreatVerb() {
        guard var project = activeProject else { return }
        project.retreat()
        persistActive(project)
        announceVerb(project)
    }

    /// Post a teacher message when the verb pointer moves — keeps the
    /// chat (③) and the recipe rail (①) in sync (rfc_012 §5).
    private func announceVerb(_ project: Project) {
        let verb = project.currentVerb
        chatMessages.append(ChatMessage(
            role: .assistant,
            text: "🍳 이제 \(verb.rawValue + 1)단계 — "
                + "\(verb.plain)(\(verb.canonical)) 입니다. \(verbHint(verb))"))
    }

    private func verbHint(_ verb: Verb) -> String {
        switch verb {
        case .specify:    return "무엇을 만들지, 가장 중요한 게 뭔지 같이 정해요."
        case .structure:  return "전체를 어떤 짜임새로 나눌지 그려봐요."
        case .design:     return "각 부분을 구체적으로 설계해요."
        case .analyze:    return "설계가 잘 됐는지 점검하고 따져봐요."
        case .synthesize: return "실제로 만들 수 있는 형태로 합쳐요."
        case .verify:     return "측정으로 맞는지 확인해요."
        case .handoff:    return "결과를 다음 단계로 넘길 수 있게 정리해요."
        }
    }

    // MARK: — θ-2 action dispatch (rfc_011 §6 / D48 / D49)

    /// "▶ 실제로 돌리기" — dispatch the current verb as an action to the
    /// Claude Code CLI (rfc_011 §6.3). κ-5 is the mechanism skeleton:
    /// demiurge has no engine tool yet (D49), so the agent reports "no
    /// tool" honestly and no measured record is produced (g3). When a
    /// real engine tool lands, the same path drives the measurement.
    private func runAction() {
        guard let project = activeProject else { return }
        let verb = project.currentVerb
        chatMessages.append(ChatMessage(
            role: .user,
            text: "▶ \(verb.plain)(\(verb.canonical)) 단계 실제로 돌리기"))
        let thinkingIndex = chatMessages.count
        chatMessages.append(ChatMessage(role: .assistant, text: "🍳 … 실행 경로 확인 중 …"))
        let context = chatContext()
        let prompt = Self.actionPrompt(verb: verb)
        isRunningAction = true
        Task {
            let reply = await Self.runClaude(prompt: prompt, context: context)
            await MainActor.run {
                if thinkingIndex < chatMessages.count {
                    chatMessages[thinkingIndex] = ChatMessage(role: .assistant, text: reply)
                }
                let ids = Self.parseRecordIDs(reply)
                if ids.isEmpty {
                    chatMessages.append(ChatMessage(
                        role: .assistant,
                        text: "⏳ 새 측정 record 없음 — 이 단계는 아직 측정되지 "
                            + "않았습니다 (g3 — 측정 없이는 ✅ 로 바뀌지 않습니다)."))
                } else {
                    chatMessages.append(ChatMessage(
                        role: .assistant,
                        text: "📸 새 측정 record: \(ids.joined(separator: ", ")) "
                            + "— ② 참고 자료에서 확인하세요."))
                    artifacts = ArtifactRegistry.loadAll()
                }
                flagIfOverclaim(reply)
                isRunningAction = false
            }
        }
    }

    /// Action prompt for a verb run — instructs the agent to look for a
    /// real engine tool and report honestly, never claiming a
    /// measurement without a backing exports/ record (g3 / @F f6).
    private static func actionPrompt(verb: Verb) -> String {
        return "The user clicked '실제로 돌리기' (run for real) on the "
            + "\(verb.canonical) stage of a demiurge project. Check "
            + "whether demiurge has a real engine tool for this stage "
            + "and whether any measured record exists under exports/**. "
            + "If a tool is available, describe how it would run. If "
            + "NOT, state plainly in Korean that there is no engine "
            + "tool yet — do NOT claim anything was measured or "
            + "verified (g3 — no over-claim). Never assert ✅ / 측정완료 "
            + "without a backing exports/ record ID."
    }

    /// Best-effort extraction of F1F2 record IDs from agent output —
    /// rfc_011 §6.3 "output piped + parsed for new record IDs".
    private static func parseRecordIDs(_ text: String) -> [String] {
        let pattern = "F1F2[-_][A-Za-z0-9._-]+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return []
        }
        let range = NSRange(text.startIndex..., in: text)
        let ids = regex.matches(in: text, range: range).compactMap {
            Range($0.range, in: text).map { String(text[$0]) }
        }
        return Array(Set(ids)).sorted()
    }

    /// rfc_011 §4.2 / @F f6 — does a reply assert a measurement /
    /// parity / absorption WITHOUT a backing exports/ record ID?
    /// Such a reply is an over-claim and must be flagged in the UI.
    private static func overclaims(_ reply: String) -> Bool {
        let claimMarkers = [
            "측정으로 확인", "측정 완료", "측정완료", "측정됐", "측정했",
            "검증 완료", "검증완료", "검증됐", "흡수 완료", "흡수완료",
            "parity", "29/29", "38/38", "absorbed: true", "gate_closed",
            "달성했", "확인됐습니다",
        ]
        let lower = reply.lowercased()
        let claims = claimMarkers.contains { lower.contains($0.lowercased()) }
        guard claims else { return false }
        // A claim is honest only if it carries a backing record ID.
        return parseRecordIDs(reply).isEmpty
    }

    /// Append a red REJECTED banner right after an over-claiming reply
    /// (rfc_011 §4.2). The reply itself stays visible — the banner
    /// marks it as not-trustworthy, it does not hide it.
    private func flagIfOverclaim(_ reply: String) {
        guard Self.overclaims(reply) else { return }
        chatMessages.append(ChatMessage(
            role: .rejected,
            text: "이 응답은 측정·parity·흡수를 주장하지만 그것을 뒷받침하는 "
                + "exports/ record 가 없습니다. 측정 없이는 ✅ 로 인정되지 "
                + "않습니다 (g3 / @F f6)."))
    }

    /// Project context handed to the chat agent so the "cooking
    /// teacher" answers within the project's verb-stage frame (κ-4).
    private func chatContext() -> String {
        guard let project = activeProject else {
            return "The user has not created a project yet — gently "
                 + "suggest the ＋ button to start one."
        }
        let verb = project.currentVerb
        return "Project \"\(project.name)\" — 목표: \(project.target), "
             + "분야: \(project.domain). Current 7-verb stage: "
             + "\(verb.rawValue + 1)/7 \(verb.canonical)(\(verb.plain))."
    }

    /// Write a mutated project back to the in-memory list + manifest,
    /// and clear shelf picks (the shelf changes with the verb).
    private func persistActive(_ project: Project) {
        if let idx = projects.firstIndex(where: { $0.id == project.id }) {
            projects[idx] = project
        }
        try? ProjectStore.save(project)
        shelfPicks = [:]
    }

    /// "[냄비에 넣기]" — fold the shelf picks into the chat input as the
    /// next turn's draft (rfc_012 §5 — the user still presses 보내기).
    private func addToPotFromShelf(_ groups: [IngredientGroup]) {
        let picked = groups.compactMap { group -> String? in
            guard let option = shelfPicks[group.title] else { return nil }
            return "\(group.title): \(option)"
        }
        guard !picked.isEmpty else { return }
        chatInput = "[재료 선반] " + picked.joined(separator: " · ")
        shelfPicks = [:]
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
        case .visited:  return .orange
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
            if let project = activeProject {
                Section(expertMode ? "verb pointer" : "단계 이동") {
                    verbStepper(project)
                }
            } else {
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

    /// Verb-pointer stepper — conversation-default progress (D48). It
    /// moves the pointer only; a stage stays ⏳ until a measured θ-2
    /// record turns it ✅ (g3 — never upgraded by a click).
    @ViewBuilder private func verbStepper(_ project: Project) -> some View {
        HStack(spacing: 6) {
            Button { retreatVerb() } label: {
                Image(systemName: "chevron.left")
            }
            .buttonStyle(.borderless)
            .disabled(!project.canRetreat)
            Spacer()
            Text(expertMode ? project.currentVerb.canonical : project.currentVerb.plain)
                .font(.caption.weight(.medium))
            Spacer()
            Button { advanceVerb() } label: {
                Image(systemName: "chevron.right")
            }
            .buttonStyle(.borderless)
            .disabled(!project.canAdvance)
        }
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
        case .visited:  return "hourglass"
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
            if let project = activeProject {
                Button { runAction() } label: {
                    Label(isRunningAction
                          ? "실행 경로 확인 중…"
                          : "\(project.currentVerb.plain)(\(project.currentVerb.canonical)) 단계 실제로 돌리기",
                          systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(.orange)
                .disabled(isRunningAction)
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .help("θ-2 — 이 단계의 실제 도구를 돌려 측정 record 를 만듭니다 (D48 / D49)")
            }
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
        if msg.role == .rejected {
            rejectionBanner(msg.text)
        } else {
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
    }

    /// rfc_011 §4.2 — the red REJECTED banner for an over-claiming
    /// reply (a measurement / parity / absorption claim with no
    /// backing exports/ record). g3's honesty enforced in the UI.
    @ViewBuilder private func rejectionBanner(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "exclamationmark.octagon.fill")
                .foregroundStyle(.red)
            VStack(alignment: .leading, spacing: 2) {
                Text("REJECTED")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.red)
                Text(text)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .textSelection(.enabled)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding(8)
        .background(Color.red.opacity(0.10))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.red.opacity(0.40))
        )
        .cornerRadius(8)
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
                .frame(minHeight: 72, idealHeight: 132, maxHeight: 240)
            resultZone
                .frame(minHeight: 320)
        }
        .navigationTitle(activeProject?.name ?? "Demiurge")
    }

    /// ② top — ingredient shelf (rfc_012 §5). Plain option pick →
    /// "[냄비에 넣기]" drafts the choice into the next chat turn. The
    /// option sets are a κ-3 stub (IngredientShelf); real per-domain
    /// option data is sourced from the domain maps in a later phase.
    @ViewBuilder private var ingredientShelf: some View {
        let groups = activeProject.map {
            IngredientShelf.groups(domain: $0.domain, verb: $0.currentVerb)
        } ?? []
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Label(expertMode ? "Ingredient shelf" : "재료 선반",
                          systemImage: "tray.full")
                        .font(.subheadline.weight(.medium))
                    Spacer()
                    Button {
                        addToPotFromShelf(groups)
                    } label: {
                        Label("냄비에 넣기", systemImage: "arrow.down.to.line")
                    }
                    .disabled(shelfPicks.isEmpty)
                }
                if groups.isEmpty {
                    Text(activeProject == nil
                         ? "프로젝트를 만들면 이 단계의 재료가 여기에 나옵니다."
                         : "이 단계엔 고를 재료가 아직 없어요 — 대화로 진행하세요.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    ForEach(groups) { group in
                        shelfGroup(group)
                    }
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder private func shelfGroup(_ group: IngredientGroup) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(group.title)
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
            HStack(spacing: 6) {
                ForEach(group.options, id: \.self) { option in
                    let picked = shelfPicks[group.title] == option
                    Button {
                        shelfPicks[group.title] = picked ? nil : option
                    } label: {
                        Text(option).font(.caption)
                    }
                    .buttonStyle(.bordered)
                    .tint(picked ? .accentColor : .secondary)
                }
            }
        }
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
        let context = chatContext()
        Task {
            let reply = await Self.runClaude(prompt: text, context: context)
            await MainActor.run {
                if thinkingIndex < chatMessages.count {
                    chatMessages[thinkingIndex] = ChatMessage(role: .assistant, text: reply)
                }
                flagIfOverclaim(reply)
            }
        }
    }

    /// Invoke `claude -p <prompt>` as a subprocess and capture stdout.
    /// `/usr/bin/env` resolves `claude` on PATH; shell aliases (and so
    /// `--dangerously-skip-permissions`) are NOT inherited by Process —
    /// print mode without tool permissions stays read-only.
    private static func runClaude(prompt: String, context: String) async -> String {
        let guarded = "[demiurge cockpit chat — you are 요리 선생님, a friendly "
            + "engineering-design guide. Answer concisely in Korean, in plain "
            + "language a non-expert understands. Do NOT modify files, run "
            + "builds, or invoke tools. Project context: \(context)] \(prompt)"
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
