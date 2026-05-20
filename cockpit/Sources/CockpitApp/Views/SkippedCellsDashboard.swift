// SkippedCellsDashboard — G2 cockpit view (ARCH.md §11.4).
//
// Shows the honest project-wide gap: cells that emitted records with
// `skipped_reason` set, grouped by GateType (G7). The dashboard
// answers two questions the ufo/aura simulations exposed:
//   1. "왜 이 cell 이 측정 안 됐나?"  →  GateType label + reason
//   2. "내가 풀 수 있는 갭은 몇 개?"  →  userResolvable filter
//
// Pure SwiftUI + DemiurgeCore — no AppKit-specific surface.

import SwiftUI
import DemiurgeCore

struct SkippedCellsDashboard: View {
    @State private var entries: [SkippedCellEntry] = []
    @State private var refreshedAt: Date? = nil
    @State private var filter: GateType? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            Divider()
            if entries.isEmpty {
                empty
            } else {
                summary
                Divider()
                list
            }
        }
        .padding(16)
        .frame(minWidth: 540, minHeight: 440)
        .onAppear { reload() }
    }

    // MARK: — header

    private var header: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle")
                .foregroundStyle(.orange)
                .font(.title3)
            VStack(alignment: .leading, spacing: 2) {
                Text("측정 누락 셀 (g3 정직 표면)")
                    .font(.headline)
                if let at = refreshedAt {
                    Text("스캔 시각 \(at, format: .dateTime.hour().minute().second())  ·  \(entries.count) 셀")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Text("스캔 중…").font(.caption).foregroundStyle(.secondary)
                }
            }
            Spacer()
            Button("새로고침") { reload() }
                .buttonStyle(.borderless)
        }
    }

    private var empty: some View {
        VStack(spacing: 8) {
            Spacer(minLength: 12)
            Image(systemName: "checkmark.seal")
                .foregroundStyle(.green)
                .font(.largeTitle)
            Text("아직 누락 셀 record 가 없습니다")
                .font(.callout.weight(.medium))
            Text("(또는 exports/ 가 비어 있음)")
                .font(.caption).foregroundStyle(.secondary)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: — gate-type summary chips

    private var summary: some View {
        let groups = SkippedCellsAggregator.byGateType(entries)
        return VStack(alignment: .leading, spacing: 6) {
            Text("게이트 종류별")
                .font(.caption).foregroundStyle(.secondary)
            HStack(spacing: 6) {
                ForEach(groups, id: \.0) { (gt, list) in
                    Button {
                        filter = (filter == gt) ? nil : gt
                    } label: {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(color(for: gt))
                                .frame(width: 8, height: 8)
                            Text("\(gt.label) ").font(.caption.bold())
                            Text("\(list.count)").font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(filter == gt
                                    ? Color.accentColor.opacity(0.22)
                                    : Color.secondary.opacity(0.12))
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
                Spacer(minLength: 0)
            }
            // 풀 수 있는 갭 = userResolvable.
            let resolvable = entries.filter { $0.gateType.userResolvable }.count
            Text("내가 풀 수 있는 갭 (설치 / 데이터 / 플랫폼): \(resolvable) / \(entries.count)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: — list

    private var filteredEntries: [SkippedCellEntry] {
        guard let f = filter else { return entries }
        return entries.filter { $0.gateType == f }
    }

    private var list: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(Array(filteredEntries.enumerated()),
                        id: \.offset) { _, e in
                    SkippedCellRow(entry: e, accent: color(for: e.gateType))
                }
            }
            .padding(.vertical, 4)
        }
    }

    private func reload() {
        entries = SkippedCellsAggregator.scan(under: RecordLoader.exportsRoot)
        refreshedAt = Date()
    }

    private func color(for gt: GateType) -> Color {
        switch gt {
        case .installGated:      return .blue
        case .platformGated:     return .purple
        case .dataGated:         return .teal
        case .regulatoryGated:   return .red
        case .proprietaryOnly:   return .pink
        case .hexaNativeAbsent:  return .orange
        case .hexaNativeFuture:  return .yellow
        // D106 — illustrative-physics paints `.cyan` (distinct from the
        // green absorbed chip + the yellow heavy-port chip): substrate
        // parity PASS but cell-level measured oracle absent.
        case .illustrativePhysics: return .cyan
        case .producerAbsent:    return .gray
        case .unspecified:       return .secondary
        }
    }
}

private struct SkippedCellRow: View {
    let entry: SkippedCellEntry
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Text("\(entry.domain) · \(entry.verb)")
                    .font(.callout.weight(.medium))
                Text(entry.gateType.label)
                    .font(.caption2)
                    .padding(.horizontal, 6).padding(.vertical, 1)
                    .background(accent.opacity(0.18))
                    .cornerRadius(3)
                // D99 — hexa-native parity chip (3-case: nil / absorbed
                // / provisional). Gray for the common skipped-row case
                // where no kernel is attached.
                HexaNativeParityChip(ref: entry.hexaNativeParity)
                Spacer()
                if !entry.producer.isEmpty {
                    Text(entry.producer)
                        .font(.caption2.monospaced())
                        .foregroundStyle(.secondary)
                }
            }
            Text(entry.skippedReason)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color.secondary.opacity(0.06))
        .cornerRadius(6)
    }
}
