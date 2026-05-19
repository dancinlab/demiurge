// RecordView — render one F1F2 record header + topology summary + verdict
// + ProvenanceBanner. The provenance banner is the unique product surface
// (rfc_009 §4); the rest are summary fields the analyst orients with.
//
// Error states (rfc_009 §4 "missing provenance -> REJECTED card"):
//   - file not found / read fails / decode fails -> red REJECTED card
//     (provenance absent or unparseable = the cockpit cannot make a claim
//      on the analyst's behalf; @F f4 mirror in app form)

import SwiftUI
import DemiurgeCore

struct RecordView: View {
    let result: Result<F1F2Record, RecordLoaderError>
    /// rfc_012 §4 expert toggle — passed through to ProvenanceBanner.
    var expertMode: Bool = true

    var body: some View {
        switch result {
        case .success(let record):
            loaded(record)
        case .failure(let error):
            rejected(error)
        }
    }

    @ViewBuilder
    private func loaded(_ r: F1F2Record) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                header(r)
                Divider()
                summary(r)
                Divider()
                verdict(r)
                Divider()
                ProvenanceBanner(provenance: r.provenance, expertMode: expertMode)
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder
    private func header(_ r: F1F2Record) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(r.recordId)
                .font(.system(size: 18, weight: .medium, design: .monospaced))
            Text("\(r.interface) · schema v\(r.schemaVersion)")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("produced: \(r.producedAtUtc)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private func summary(_ r: F1F2Record) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("topology").font(.caption).foregroundColor(.secondary)
            LabeledContent("kind",       value: r.topology.kind)
            LabeledContent("degree",     value: String(r.topology.degree))
            LabeledContent("nodes",      value: String(r.topology.nodeCount))
            LabeledContent("routing",    value: r.topology.routing)
            LabeledContent("traffic",    value: r.traffic)
        }
    }

    @ViewBuilder
    private func verdict(_ r: F1F2Record) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("verdict").font(.caption).foregroundColor(.secondary)
            LabeledContent("F1", value: r.verdict.f1)
            LabeledContent("F2", value: r.verdict.f2)
            Text(r.verdict.rationale)
                .font(.callout)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    @ViewBuilder
    private func rejected(_ error: RecordLoaderError) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Circle().fill(.red).frame(width: 14, height: 14)
                Text("REJECTED")
                    .font(.system(.title3, design: .monospaced))
                    .foregroundColor(.red)
                Spacer()
            }
            Text("rfc_009 §4 honesty-as-feature: the cockpit refuses to render a record without parseable provenance.")
                .font(.callout)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Divider()
            Text(error.errorDescription ?? "Unknown error.")
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.red)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.red.opacity(0.04))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.red, lineWidth: 1)
        )
        .padding(24)
    }
}
