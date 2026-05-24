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
            // κ-28 — standalone 3D-animation test window, gated by an
            // env var so it needs no separate executable target:
            //   DEMIURGE_TEST_3D=1 swift run CockpitApp
            if ProcessInfo.processInfo.environment["DEMIURGE_TEST_3D"] != nil {
                ComponentView3D(stub: ArtifactStub(
                    id: ArtifactID(kind: .domain, key: "component"),
                    title: "test-3d-animation",
                    path: ""))
                    .frame(minWidth: 720, minHeight: 600)
            } else if ProcessInfo.processInfo.environment["DEMIURGE_TEST_3D_HTS"] != nil {
                // Standalone HTS solenoid test window.
                //   DEMIURGE_TEST_3D_HTS=1 swift run CockpitApp
                HtsView3D(geometry: .htsSolenoidProxy)
                    .frame(minWidth: 720, minHeight: 600)
            } else {
                WorkbenchView()
            }
        }
    }
}

// ChatMessage moved to DemiurgeCore (κ-22 — shared with ChatStore;
// @D g_ssot_single_source / D50).

/// ② work-zone result view tab (κ-7) — the domain-aware canvas mode
/// vs the exports/ reference browser (rfc_012 §7 reference view).
enum ResultTab: String, CaseIterable, Identifiable {
    case result, reference, operations
    var id: String { rawValue }
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

    // ② ingredient-shelf picks (group title → chosen option(s)).
    // Single-pick groups hold ≤1 element; multi-pick groups (§6
    // `[multi]` marker) hold the toggled set.
    @State private var shelfPicks: [String: Set<String>] = [:]

    // θ-2 "▶ 실제로 돌리기" action in flight (D49).
    @State private var isRunningAction = false

    // ② reference-browser gate filter (κ-14, phase ζ filter-only).
    @State private var recordFilterMeasuredOnly = false
    @State private var recordGates: [ArtifactID: F1F2Record.MeasurementGate] = [:]

    // ② work-zone result view tab (κ-7).
    @State private var resultTab: ResultTab = .result

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
            loadRecordGates()                            // κ-14 — cache for filter
            if let active = activeProject {              // κ-22 — restore chat
                chatMessages = ChatStore.load(for: active)
                reflagChat()
            }
        }
        .onChange(of: refSelection) { _, newValue in
            handleRefSelection(newValue)
        }
        .onChange(of: activeProjectID) { _, _ in         // κ-22 — swap chat
            if let active = activeProject {
                chatMessages = ChatStore.load(for: active)
                reflagChat()
            } else {
                chatMessages = []
            }
        }
        .onChange(of: chatMessages) { _, _ in            // κ-22 — persist
            persistChat()
        }
    }

    // MARK: — ④ toolbar

    @ToolbarContentBuilder private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button { showNewProject = true } label: {
                Label("새 프로젝트", systemImage: "plus")
            }
            .keyboardShortcut("n", modifiers: .command)
            .help("새 프로젝트 만들기 — ⌘N (rfc_012 §3)")
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
                + "\(verb.plain)(\(verb.koreanLabel)) 입니다. \(verb.hint)"))
    }

    // MARK: — θ-2 action dispatch (rfc_011 §6 / D48 / D49)

    /// "▶ 실제로 돌리기" — dispatch the current verb as an action.
    /// κ-29: routes through `ActionDispatch.runEngineTool(verb:, domain:)`
    /// so (component, synthesize) → ComponentEmitter and
    /// (chip, verify) → booksim self-test sniffer get real records
    /// when their engine tools succeed; every other cell still hits
    /// the claude-CLI honest-gap path. Same dispatcher as
    /// `DemiurgeCLI action <verb> <domain>` (D50 byte-identical).
    private func runAction() {
        guard let project = activeProject else { return }
        let verb = project.currentVerb
        let domain = project.domain
        chatMessages.append(ChatMessage(
            role: .user,
            text: "▶ \(verb.plain)(\(verb.koreanLabel)) 단계 실제로 돌리기"))
        let thinkingIndex = chatMessages.count
        chatMessages.append(ChatMessage(role: .assistant, text: "🍳 … 실행 경로 확인 중 …"))
        let context = chatContext()
        isRunningAction = true
        Task {
            let result = await dispatch(verb: verb, domain: domain, context: context)
            await MainActor.run {
                if thinkingIndex < chatMessages.count {
                    chatMessages[thinkingIndex] = ChatMessage(
                        role: .assistant, text: result.text)
                }
                if result.newRecordIDs.isEmpty {
                    let why: String
                    if result.usedEngineTool, result.engineToolSucceeded == false {
                        why = "⏳ engine tool gap — 새 측정 record 없음. "
                            + "보고된 사유를 확인하세요 (g3 — silent success 금지)."
                    } else {
                        why = "⏳ 새 측정 record 없음 — 이 단계는 아직 측정되지 "
                            + "않았습니다 (g3 — 측정 없이는 ✅ 로 바뀌지 않습니다)."
                    }
                    chatMessages.append(ChatMessage(role: .assistant, text: why))
                } else {
                    chatMessages.append(ChatMessage(
                        role: .assistant,
                        text: "📸 새 record: \(result.newRecordIDs.joined(separator: ", ")) "
                            + "— ② 참고 자료에서 확인하세요."))
                    artifacts = ArtifactRegistry.loadAll()
                }
                flagIfOverclaim(result.text)
                isRunningAction = false
            }
        }
    }

    /// Async wrapper around `ActionDispatch.runEngineTool` — detaches
    /// so the synchronous engine-tool subprocess (or claude CLI) does
    /// not block the UI thread.
    private func dispatch(verb: Verb, domain: String,
                          context: String) async -> ActionResult {
        await Task.detached(priority: .userInitiated) {
            ActionDispatch.runEngineTool(
                verb: verb, domain: domain, context: context)
        }.value
    }

/// rfc_011 §4.2 / @F f6 — does the reply assert a measurement /
    /// parity / absorption that NO real measured record backs?
    private static func overclaims(_ reply: String) -> Bool {
        guard mentionsClaim(reply) else { return false }
        return !hasMeasuredBacking(reply)
    }

    /// Claim-language detection — a measurement / parity / absorption
    /// assertion. This is a heuristic (string match); the backing
    /// check below is the real gate, so a missed marker only means a
    /// non-claim reply goes unflagged — it never lets an unbacked
    /// claim through (the backing check is independent).
    private static func mentionsClaim(_ reply: String) -> Bool {
        let markers = [
            "측정으로 확인", "측정 완료", "측정완료", "측정됐", "측정했",
            "측정 결과", "검증 완료", "검증완료", "검증됐", "검증되었",
            "흡수 완료", "흡수완료", "흡수했", "흡수됐", "재현했",
            "통과했", "달성했", "확인됐",
            "parity", "29/29", "38/38",
            "absorbed: true", "absorbed=true",
            "gate_closed", "gate_b_pinned",
        ]
        let lower = reply.lowercased()
        return markers.contains { lower.contains($0.lowercased()) }
    }

    /// rfc_011 §4.2 — a claim is backed ONLY by a real exports/ record
    /// whose measurement_gate is a measured state (GATE_B_PINNED_MET /
    /// GATE_CLOSED_MEASURED) AND whose exact recordId the reply names.
    /// A fabricated ID, or the ID of an unmeasured (GATE_OPEN) record,
    /// does not count — the check resolves every mentioned ID against
    /// the actual exports/ records, not the reply's own text.
    private static func hasMeasuredBacking(_ reply: String) -> Bool {
        for stub in ArtifactRegistry.loadF1F2() {
            guard case .success(let record) =
                    RecordLoader.load(relativePath: stub.path) else { continue }
            let gate = record.provenance.measurementGate
            let measured = (gate == .bPinnedMet || gate == .closedMeasured)
            if measured, reply.contains(record.recordId) {
                return true
            }
        }
        return false
    }

    /// Append a red REJECTED banner right after an over-claiming reply
    /// (rfc_011 §4.2). The reply itself stays visible — the banner
    /// marks it as not-trustworthy, it does not hide it.
    static let rejectionBannerText =
        "이 응답은 측정·parity·흡수를 주장하지만 그것을 뒷받침하는 "
        + "exports/ record 가 없습니다. 측정 없이는 ✅ 로 인정되지 "
        + "않습니다 (g3 / @F f6)."

    private func flagIfOverclaim(_ reply: String) {
        guard Self.overclaims(reply) else { return }
        chatMessages.append(ChatMessage(role: .rejected, text: Self.rejectionBannerText))
    }

    /// After a disk load, regenerate REJECTED banners from the live
    /// guard (κ-22) — banners are never persisted (ChatStore drops
    /// `.rejected`), so the honesty marker always reflects the
    /// current guard, not a stale copy (g3).
    private func reflagChat() {
        var rebuilt: [ChatMessage] = []
        for msg in chatMessages where msg.role != .rejected {
            rebuilt.append(msg)
            if msg.role == .assistant, Self.overclaims(msg.text) {
                rebuilt.append(ChatMessage(role: .rejected, text: Self.rejectionBannerText))
            }
        }
        chatMessages = rebuilt
    }

    /// Persist the active project's chat (κ-22). `.rejected` banners
    /// are filtered out by ChatStore — only user/assistant round-trip.
    private func persistChat() {
        guard let active = activeProject else { return }
        try? ChatStore.save(chatMessages, for: active)
    }

    /// Async wrapper around the shared `ActionDispatch.askClaude`
    /// (DemiurgeCore — cockpit + CLI share it, @D g_ssot_single_source).
    /// Detached so the synchronous claude subprocess does not block
    /// the UI thread.
    private func ask(_ prompt: String, _ context: String) async -> String {
        await Task.detached(priority: .userInitiated) {
            ActionDispatch.askClaude(prompt: prompt, context: context)
        }.value
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
             + "\(verb.rawValue + 1)/7 \(verb.koreanLabel)(\(verb.plain))."
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
            guard let chosen = shelfPicks[group.title], !chosen.isEmpty else {
                return nil
            }
            // Multi-pick: join the group's options with ` · ` in the
            // domain map's declared order. Single-pick: the lone value.
            let value = group.options
                .filter { chosen.contains($0) }
                .joined(separator: " · ")
            return "\(group.title): \(value)"
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
                Text(expertMode ? verb.koreanLabel : verb.plain)
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
        // ④ 7-step bar sits in the toolbar principal slot — give it
        // left/right breathing room so the 무엇을›어떻게›… capsules
        // aren't flush against the toolbar edges (user UI feedback).
        .padding(.horizontal, 20)
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
            .keyboardShortcut(.leftArrow, modifiers: .command)
            .disabled(!project.canRetreat)
            .help("이전 단계 — ⌘←")
            Spacer()
            Text(expertMode ? project.currentVerb.koreanLabel : project.currentVerb.plain)
                .font(.caption.weight(.medium))
            Spacer()
            Button { advanceVerb() } label: {
                Image(systemName: "chevron.right")
            }
            .buttonStyle(.borderless)
            .keyboardShortcut(.rightArrow, modifiers: .command)
            .disabled(!project.canAdvance)
            .help("다음 단계 — ⌘→")
        }
    }

    @ViewBuilder private func verbRow(_ verb: Verb) -> some View {
        let state = activeProject?.state(of: verb) ?? .upcoming
        HStack(spacing: 8) {
            // SF Symbol + gate-color tint = the §4 signal light.
            // (An emoji glyph here renders as an oversized colored
            // circle on macOS — SF Symbols stay crisp and sized.)
            Image(systemName: verbRowSymbol(state, verb: verb))
                .foregroundStyle(progressTint(state))
                .imageScale(.medium)
                .frame(width: 18)
            VStack(alignment: .leading, spacing: 1) {
                Text(expertMode ? verb.koreanLabel : verb.plain)
                    .font(.callout)
                    .foregroundStyle(state == .upcoming ? .secondary : .primary)
                if !expertMode {
                    Text(verb.koreanLabel)
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
                          : "\(project.currentVerb.plain)(\(project.currentVerb.koreanLabel)) 단계 실제로 돌리기",
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
                    + "1단계 \(Verb.specify.plain)(\(Verb.specify.koreanLabel))부터 "
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
            HStack(spacing: 4) {
                Text(group.title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                if group.multiSelect {
                    Image(systemName: "checklist")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(expertMode ? "(multi)" : "(여러 개)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            HStack(spacing: 6) {
                ForEach(group.options, id: \.self) { option in
                    let picked = shelfPicks[group.title]?.contains(option) ?? false
                    Button {
                        toggleShelfPick(group: group, option: option, picked: picked)
                    } label: {
                        Text(option).font(.caption)
                    }
                    .buttonStyle(.bordered)
                    .tint(picked ? .accentColor : .secondary)
                }
            }
        }
    }

    /// Toggle one option in a shelf group. Multi-pick groups add/remove
    /// the option from the set; single-pick groups keep ≤1 element
    /// (tapping a new option replaces the prior choice).
    private func toggleShelfPick(
        group: IngredientGroup, option: String, picked: Bool
    ) {
        if group.multiSelect {
            var set = shelfPicks[group.title] ?? []
            if picked { set.remove(option) } else { set.insert(option) }
            shelfPicks[group.title] = set.isEmpty ? nil : set
        } else {
            shelfPicks[group.title] = picked ? nil : [option]
        }
    }

    /// ② bottom — result visualization + reference browser (§5 / §7).
    @ViewBuilder private var resultZone: some View {
        if activeProject == nil {
            emptyWorkbench
        } else {
            VStack(spacing: 0) {
                projectResultHeader
                Picker("result view", selection: $resultTab) {
                    Text(expertMode ? "Canvas mode" : "결과 보기")
                        .tag(ResultTab.result)
                    Text(expertMode ? "exports/ ref" : "참고 자료")
                        .tag(ResultTab.reference)
                    Text(expertMode ? "operations" : "운영")
                        .tag(ResultTab.operations)
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                Divider()
                switch resultTab {
                case .result:     domainModeView
                case .reference:  referenceBrowser
                case .operations: OperationsView(project: activeProject, expertMode: expertMode)
                }
            }
        }
    }

    /// Domain-aware canvas mode (rfc_011 §7 mode registry) — the ②
    /// bottom shows a different body per the project's domain.
    @ViewBuilder private var domainModeView: some View {
        if let project = activeProject {
            switch DomainCatalog.domain(for: project.domain).canvasMode {
            case .component: componentModeView
            case .matter:    matterPointerView
            case .chip:      chipModeView
            case .cohort:    cohortShallowView(project)
            }
        }
    }

    /// ComponentMode (rfc_011 §7) — the phase-ι RealityKit 3D viewer.
    @ViewBuilder private var componentModeView: some View {
        if let stub = artifacts.first(where: {
            $0.id.kind == .domain && $0.id.key == "component"
        }) {
            ComponentView3D(stub: stub)
        } else {
            modePlaceholder(
                icon: "shippingbox",
                title: expertMode ? "ComponentMode" : "부품 설계 결과",
                body: "component 도메인 자료를 찾지 못했습니다.")
        }
    }

    /// MatterPointer (rfc_011 §7 / D17) — matter computation's SSOT is
    /// hexa-lang; demiurge is a consumer, so this is a pointer card.
    @ViewBuilder private var matterPointerView: some View {
        modePlaceholder(
            icon: "atom",
            title: expertMode ? "MatterPointer (D17)" : "물질·재료",
            body: "물질 계산의 SSOT 는 hexa-lang/stdlib/matter 입니다 — "
                + "demiurge 는 소비자입니다 (D17). 측정 결과는 "
                + "typed-interface 로 가져와 표시됩니다.")
    }

    /// ChipMode (rfc_011 §7) — chip record card. A project carries a
    /// record only after a measured θ-2 run; until then, honest ⏳.
    @ViewBuilder private var chipModeView: some View {
        modePlaceholder(
            icon: "cpu",
            title: expertMode ? "ChipMode" : "칩 설계 결과",
            body: "이 프로젝트는 아직 측정 record 가 없습니다 ⏳ — "
                + "③ 에서 \"실제로 돌리기\" 로 측정하거나, \"참고 자료\" "
                + "에서 기존 chip 측정 기록을 볼 수 있어요.")
    }

    /// CohortShallow (rfc_011 §7) — a shallow domain card. Renders the
    /// domain's `.md` map if loaded, else a plain placeholder.
    @ViewBuilder private func cohortShallowView(_ project: Project) -> some View {
        if let stub = artifacts.first(where: {
            $0.id.kind == .domain && $0.id.key == project.domain
        }) {
            MarkdownView(stub: stub)
        } else {
            modePlaceholder(
                icon: "map",
                title: expertMode ? "CohortShallow — \(project.domain)"
                                  : "\(project.domain) 분야",
                body: "이 분야의 설계는 7단계 대화로 진행합니다. 측정 "
                    + "결과는 \"실제로 돌리기\" 후 여기에 나타납니다.")
        }
    }

    @ViewBuilder private func modePlaceholder(
        icon: String, title: String, body: String
    ) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(.tertiary)
            Text(title)
                .font(.headline)
            Text(body)
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(40)
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
            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    Toggle(expertMode ? "measured only" : "측정된 것만",
                           isOn: $recordFilterMeasuredOnly)
                        .toggleStyle(.switch)
                        .controlSize(.small)
                        .help("gate ∈ {GATE_B_PINNED_MET, GATE_CLOSED_MEASURED} 만 (rfc_011 §4.2)")
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                Divider()
                List(selection: $refSelection) {
                    let records = filteredRecords
                    Section(referenceSectionTitle(visible: records.count)) {
                        if records.isEmpty {
                            Text(recordFilterMeasuredOnly
                                 ? "(필터 — 측정된 record 0)"
                                 : "(없음)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        ForEach(records) { stub in
                            recordRow(stub)
                                .tag(stub.id)
                        }
                    }
                }
            }
            .frame(minWidth: 220, maxWidth: 320)

            referenceCanvas
                .frame(minWidth: 360)
        }
    }

    private var filteredRecords: [ArtifactStub] {
        let all = artifacts.filter { $0.id.kind == .f1f2 }
        guard recordFilterMeasuredOnly else { return all }
        return all.filter { stub in
            guard let gate = recordGates[stub.id] else { return false }
            return gate == .bPinnedMet || gate == .closedMeasured
        }
    }

    private func referenceSectionTitle(visible: Int) -> String {
        let total = artifacts.filter { $0.id.kind == .f1f2 }.count
        let count = recordFilterMeasuredOnly ? "\(visible) / \(total)" : "\(visible)"
        return expertMode
            ? "exports/** (reference, \(count))"
            : "참고 자료 (\(count))"
    }

    /// One record row — gate dot (color = the gate) + title.
    @ViewBuilder private func recordRow(_ stub: ArtifactStub) -> some View {
        HStack(spacing: 6) {
            Image(systemName: recordRowSymbol(stub))
                .foregroundStyle(recordRowTint(stub))
                .imageScale(.small)
                .frame(width: 14)
            Text(stub.title)
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }

    private func recordRowSymbol(_ stub: ArtifactStub) -> String {
        guard let gate = recordGates[stub.id] else { return "questionmark.circle" }
        switch gate {
        case .open:           return "hourglass"
        case .bPinnedMet:     return "diamond.fill"
        case .closedMeasured: return "checkmark.seal.fill"
        case .failed:         return "xmark.octagon.fill"
        }
    }

    private func recordRowTint(_ stub: ArtifactStub) -> Color {
        guard let gate = recordGates[stub.id] else { return .secondary }
        switch gate {
        case .open:           return .orange
        case .bPinnedMet:     return .blue
        case .closedMeasured: return .green
        case .failed:         return .red
        }
    }

    /// Load every F1F2 record once and cache its measurement_gate so the
    /// filter is a dict lookup — not a 50-record reload per render.
    private func loadRecordGates() {
        var gates: [ArtifactID: F1F2Record.MeasurementGate] = [:]
        for stub in artifacts where stub.id.kind == .f1f2 {
            if case .success(let r) = RecordLoader.load(relativePath: stub.path) {
                gates[stub.id] = r.provenance.measurementGate
            }
        }
        recordGates = gates
    }

    @ViewBuilder private var referenceCanvas: some View {
        Group {
            if let result = recordResult {
                RecordView(result: result, expertMode: expertMode)
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
            let reply = await ask(text, context)
            await MainActor.run {
                if thinkingIndex < chatMessages.count {
                    chatMessages[thinkingIndex] = ChatMessage(role: .assistant, text: reply)
                }
                flagIfOverclaim(reply)
            }
        }
    }

}
