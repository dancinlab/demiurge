// NewProjectSheet — the `+` button's project-creation flow (rfc_012 §3).
//
// Three steps, plain-language throughout (rfc_012 §4):
//   1. 이름        — user types a project name
//   2. 무엇을      — user types a free-text goal (D44 option C)
//   3. 도메인 확인 — DomainInference proposes; user [네 / 바꾸기] (g3:
//                   the AI infers, the human ratifies)
//
// Canonical-first (D26 g_swift_native): SwiftUI + DemiurgeCore only.

import SwiftUI
import DemiurgeCore

struct NewProjectSheet: View {
    enum Step { case name, target, confirm }

    @Environment(\.dismiss) private var dismiss

    @State private var step: Step = .name
    @State private var name: String = ""
    @State private var target: String = ""
    @State private var inferredDomain: String = ""
    @State private var editingDomain: Bool = false

    /// Called with the finished project when the user confirms.
    let onCreate: (Project) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            Divider()
            Group {
                switch step {
                case .name:    nameStep
                case .target:  targetStep
                case .confirm: confirmStep
                }
            }
            Spacer(minLength: 0)
            Divider()
            footer
        }
        .padding(20)
        .frame(width: 520, height: 420)
    }

    // MARK: — header

    private var header: some View {
        HStack(spacing: 8) {
            Image(systemName: "plus.square.on.square")
                .font(.title2)
                .foregroundStyle(.tint)
            VStack(alignment: .leading, spacing: 2) {
                Text("새 프로젝트")
                    .font(.headline)
                Text(stepCaption)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var stepCaption: String {
        switch step {
        case .name:    return "1 / 3 — 프로젝트 이름"
        case .target:  return "2 / 3 — 무엇을 만들고 싶으세요?"
        case .confirm: return "3 / 3 — 분야 확인"
        }
    }

    // MARK: — step 1: name

    private var nameStep: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("새 프로젝트 이름은?")
                .font(.callout)
            TextField("예: 우리 회사 칩", text: $name)
                .textFieldStyle(.roundedBorder)
                .onSubmit { advance() }
            Text("나중에 ④ 상단에서 프로젝트를 전환할 때 이 이름이 보입니다.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: — step 2: free-text target

    private var targetStep: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("무엇을 만들고 싶으세요?")
                .font(.callout)
            Text("평범한 말로 적어 주세요 — 분야 이름을 몰라도 됩니다.")
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField("예: 저전력 무선 이어폰용 칩", text: $target, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(2...4)
                .onSubmit { advance() }
        }
    }

    // MARK: — step 3: domain confirm (+ D78/D82 DAG closure preview)

    /// D78/D82 — direct + transitive prerequisites for the picked
    /// domain, topologically sorted (foundation → integration apex).
    private var closureWalk: [String] {
        let closure = DomainGraph.transitiveClosure(
            of: inferredDomain.trimmingCharacters(in: .whitespaces))
        return DomainGraph.topologicalSort(closure.map { $0.id })
    }

    private var confirmStep: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Text("🍳")
                Text("적어 주신 내용을 보니 —")
                    .font(.callout)
            }
            if editingDomain {
                TextField("분야 키 (`u/<id>` 가능 — 사용자 도메인)",
                          text: $inferredDomain)
                    .textFieldStyle(.roundedBorder)
            } else {
                HStack(spacing: 6) {
                    Image(systemName: inferredDomain.hasPrefix("u/")
                          ? "person.crop.square" : "tag")
                        .foregroundStyle(.tint)
                    Text("\(DomainCatalog.domain(for: inferredDomain).label) 프로젝트군요")
                        .font(.callout.weight(.medium))
                    if inferredDomain.hasPrefix("u/") {
                        Text("내 도메인")
                            .font(.caption2)
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(Color.purple.opacity(0.18))
                            .cornerRadius(4)
                    }
                }
            }

            // D78/D82 — closure preview (chip stack of prereq chain)
            if !editingDomain && closureWalk.count > 1 {
                VStack(alignment: .leading, spacing: 6) {
                    Text("필요한 분야들 (자동 인계 — \(closureWalk.count)개)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    HStack(spacing: 5) {
                        ForEach(Array(closureWalk.enumerated()), id: \.offset) { idx, did in
                            let isStart = did == inferredDomain
                            Text(DomainCatalog.domain(for: did).label)
                                .font(.caption2)
                                .padding(.horizontal, 7).padding(.vertical, 3)
                                .background(isStart
                                            ? Color.accentColor.opacity(0.25)
                                            : Color.secondary.opacity(0.13))
                                .cornerRadius(4)
                            if idx < closureWalk.count - 1 {
                                Image(systemName: "arrow.right")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 4)
            } else if !editingDomain {
                Text("이 분야로 시작할게요 — 맞나요?")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 8) {
                Button(editingDomain ? "이걸로" : "바꾸기") {
                    editingDomain.toggle()
                }
                .buttonStyle(.bordered)
                Spacer()
            }
        }
    }

    // MARK: — footer

    private var footer: some View {
        HStack {
            Button("취소") { dismiss() }
            Spacer()
            if step != .name {
                Button("이전") { back() }
            }
            Button(step == .confirm ? "프로젝트 만들기" : "다음") { advance() }
                .buttonStyle(.borderedProminent)
                .disabled(!canAdvance)
        }
    }

    private var canAdvance: Bool {
        switch step {
        case .name:    return !name.trimmingCharacters(in: .whitespaces).isEmpty
        case .target:  return !target.trimmingCharacters(in: .whitespaces).isEmpty
        case .confirm: return !inferredDomain.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }

    // MARK: — navigation

    private func advance() {
        guard canAdvance else { return }
        switch step {
        case .name:
            step = .target
        case .target:
            inferredDomain = DomainCatalog.infer(from: target)
            step = .confirm
        case .confirm:
            let d = inferredDomain.trimmingCharacters(in: .whitespaces)
            onCreate(Project(
                name: name.trimmingCharacters(in: .whitespaces),
                target: target.trimmingCharacters(in: .whitespaces),
                domain: d,
                walk: closureWalk
            ))
            dismiss()
        }
    }

    private func back() {
        switch step {
        case .name:    break
        case .target:  step = .name
        case .confirm: step = .target; editingDomain = false
        }
    }
}
