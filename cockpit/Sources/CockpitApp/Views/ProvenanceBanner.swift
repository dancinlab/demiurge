// ProvenanceBanner — rfc_009 §4 honesty-as-feature, the cockpit's
// differentiator. Renders rfc_002 §4 provenance fields VERBATIM, never
// upgrading a claim. The visible gate color + absorbed flag IS the contract
// the cockpit makes with the user: "what you see is what was measured."
//
// Color semantics — derived from the gate state, NOT chosen by the app:
//   GATE_OPEN              -> orange (no claim, treat as scaffold)
//   GATE_B_PINNED_MET      -> blue   (partial — pinned only, full not done)
//   GATE_CLOSED_MEASURED   -> green  (full parity measured)
//   GATE_FAILED            -> red    (explicit failure)
//   absorbed=true          -> tint reinforced
//   absorbed=false         -> tint muted (default shape — see CHARTER)
//
// rfc_012 §4 expert toggle: `expertMode` shows the raw GATE_* /
// provenance fields verbatim; plain mode shows the signal-light
// wording (MeasurementGate.plainGlyph / .plainLabel — DemiurgeCore
// SSOT). The toggle picks WHICH SIDE is shown; the gate state itself
// is never altered (g3 — the honesty boundary holds either way).
//
// Apple-canonical (D26 g_swift_native): SwiftUI tokens (.orange/.green/...),
// `LabeledContent` / `GroupBox`, system fonts. No custom Color literals.

import SwiftUI
import DemiurgeCore

struct ProvenanceBanner: View {
    let provenance: F1F2Record.Provenance
    /// rfc_012 §4 — expert shows raw GATE_* / provenance verbatim;
    /// plain shows the signal-light wording. Defaults to expert so
    /// verbatim-context callers need pass nothing.
    var expertMode: Bool = true

    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) {
                gateRow
                if expertMode {
                    Divider()
                    LabeledContent("engine",   value: provenance.simEngine)
                    LabeledContent("commit",   value: String(provenance.simCommitHash.prefix(12)))
                    LabeledContent("consumer", value: provenance.consumerTarget)
                    LabeledContent("atlas",    value: provenance.atlasCiteBlock)
                }
                if !provenance.gateFailures.isEmpty {
                    Divider()
                    Text(expertMode
                         ? "gate failures (\(provenance.gateFailures.count))"
                         : "측정에서 막힌 점 (\(provenance.gateFailures.count))")
                        .font(.caption).foregroundColor(.red)
                    ForEach(provenance.gateFailures, id: \.self) { f in
                        Text("• \(f)").font(.callout).foregroundColor(.red)
                    }
                }
                if !provenance.scopeCaveats.isEmpty {
                    Divider()
                    Text(expertMode
                         ? "scope caveats (\(provenance.scopeCaveats.count))"
                         : "주의할 점 (\(provenance.scopeCaveats.count))")
                        .font(.caption).foregroundColor(.secondary)
                    ForEach(provenance.scopeCaveats, id: \.self) { c in
                        Text("• \(c)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(8)
        } label: {
            Text(expertMode
                 ? "provenance (verbatim · rfc_002 §4)"
                 : "이 결과를 믿어도 되는 이유")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(tint, lineWidth: 1)
        )
    }

    private var gateRow: some View {
        HStack(spacing: 10) {
            Circle().fill(tint).frame(width: 12, height: 12)
            Text(expertMode
                 ? provenance.measurementGate.displayLabel
                 : "\(provenance.measurementGate.plainGlyph) \(provenance.measurementGate.plainLabel)")
                .font(expertMode ? .system(.body, design: .monospaced) : .body)
                .foregroundColor(tint)
            Spacer()
            Text(absorbedLabel)
                .font(expertMode ? .system(.body, design: .monospaced) : .body)
                .foregroundColor(provenance.absorbed ? .green : .secondary)
        }
    }

    /// Plain wording mirrors rfc_012 §4: absorbed=false → "참고용 ·
    /// 검증 전" (the honest default), absorbed=true → "검증 완료".
    private var absorbedLabel: String {
        if expertMode {
            return "absorbed: \(provenance.absorbed ? "true" : "false")"
        }
        return provenance.absorbed ? "검증 완료" : "참고용 · 검증 전"
    }

    private var tint: Color {
        switch provenance.measurementGate {
        case .open:             return .orange
        case .bPinnedMet:       return .blue
        case .closedMeasured:   return .green
        case .failed:           return .red
        }
    }
}
