// OperationsView — the cockpit "운영" tab (CLI+COCKPIT M14-M17 GUI
// mirror · P3). Renders the SAME DemiurgeCore surfaces the CLI reads
// (OperabilityAudit · OperationRegistry · DomainComposer ·
// BackendResolver) so the two surfaces never diverge (D50). Plain by
// default (§4 신호등); expert reveals op ids / tier / target / milestone.
//
// External-product safe (M19): owner 사장실 ops appear only when the
// OperationRegistry owner gate is set; the plain view shows no internal
// host / atlas / governance jargon.

import SwiftUI
import DemiurgeCore

struct OperationsView: View {
    /// Active project (for the composition tree); nil → tree hidden.
    let project: Project?
    let expertMode: Bool

    private var audit: OperabilityAudit { OperabilityAudit.run() }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                auditCard
                backendCard
                if let project { composeCard(project) }
                operationsCard
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: — 운영 준비도 (operability audit)

    private var auditCard: some View {
        let a = audit
        return card(icon: "checklist", title: expertMode ? "operability audit" : "운영 준비도") {
            HStack(spacing: 14) {
                stat("✅", a.productOK, expertMode ? "ok" : "준비됨")
                stat("🔶", a.productPartial, expertMode ? "partial" : "부분")
                stat("❌", a.productBlocked, expertMode ? "blocked" : "막힘")
            }
            Text(a.productComplete
                 ? (expertMode ? "external operability COMPLETE" : "✅ 외부 운영 전부 가능")
                 : (expertMode
                    ? "pending — \(a.productBlocked) blocked / \(a.productPartial) partial"
                    : "🔶 일부 기능 준비 중 (\(a.productOK)/\(a.productOK + a.productPartial + a.productBlocked))"))
                .font(.caption)
                .foregroundStyle(a.productComplete ? .green : .secondary)
        }
    }

    private func stat(_ glyph: String, _ n: Int, _ label: String) -> some View {
        VStack(spacing: 1) {
            Text("\(glyph) \(n)").font(.callout.weight(.medium))
            Text(label).font(.caption2).foregroundStyle(.secondary)
        }
    }

    // MARK: — 계산 백엔드 (compute backend)

    private var backendCard: some View {
        let active = BackendResolver.active
        return card(icon: "cpu", title: expertMode ? "compute backend" : "계산 위치") {
            HStack(spacing: 6) {
                Image(systemName: active.kind == .local ? "laptopcomputer" : "network")
                    .foregroundStyle(.secondary)
                Text(active.label).font(.callout)
            }
            if expertMode {
                Text("active=\(active.id) · DEMIURGE_BACKEND 로 변경")
                    .font(.caption2).foregroundStyle(.tertiary)
            }
        }
    }

    // MARK: — 도메인 합성 (composition tree)

    private func composeCard(_ project: Project) -> some View {
        let c = DomainComposer.resolve(project.domain)
        let kindLabel: String = {
            switch c.kind {
            case .atomic:    return expertMode ? "atomic" : "단일"
            case .composite: return expertMode ? "composite" : "구성형"
            case .meta:      return expertMode ? "meta" : "메타(통합)"
            }
        }()
        return card(icon: "square.stack.3d.up",
                    title: expertMode ? "domain composition" : "구성 도메인") {
            HStack(spacing: 6) {
                Text("\(DomainCatalog.domain(for: project.domain).label)")
                    .font(.callout.weight(.medium))
                Text("· \(kindLabel) · 구성 \(c.stack.count)")
                    .font(.caption).foregroundStyle(.secondary)
                if c.crossesDiscipline {
                    Text(expertMode ? "cross-discipline" : "결합")
                        .font(.caption2)
                        .padding(.horizontal, 5).padding(.vertical, 1)
                        .background(Capsule().fill(Color.purple.opacity(0.18)))
                        .foregroundStyle(.purple)
                }
            }
            Text(c.ids.isEmpty ? project.domain : c.ids.joined(separator: " → "))
                .font(.caption.monospaced())
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            if expertMode {
                Text("clusters: " + c.clusterUnion.map { $0.rawValue }.joined(separator: " · "))
                    .font(.caption2).foregroundStyle(.tertiary)
            }
        }
    }

    // MARK: — 운영 목록 (operation registry)

    private var operationsCard: some View {
        let ops = OperationRegistry.visible()
        return card(icon: "list.bullet.rectangle",
                    title: expertMode ? "operations" : "할 수 있는 일") {
            ForEach(ops) { op in
                HStack(spacing: 8) {
                    Text(op.reach.glyph)
                    Text(op.title).font(.caption)
                    Spacer(minLength: 4)
                    if expertMode {
                        Text("\(op.id) · \(op.target.rawValue) · \(op.milestone)")
                            .font(.caption2.monospaced())
                            .foregroundStyle(.tertiary)
                    }
                }
            }
            if !OperationRegistry.ownerModeEnabled {
                Text(expertMode
                     ? "(owner ops hidden — DEMIURGE_OWNER)"
                     : "(일부 관리 기능은 숨겨져 있어요)")
                    .font(.caption2).foregroundStyle(.tertiary)
            }
        }
    }

    // MARK: — card chrome

    @ViewBuilder
    private func card<Content: View>(icon: String, title: String,
                                     @ViewBuilder _ content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.subheadline.weight(.medium))
            content()
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary.opacity(0.08)))
    }
}
