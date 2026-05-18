// MarkdownView — minimum-new-structure renderer for non-F1F2 artifacts
// (Decisions / RFCs / Domains) in CENTER canvas, phase β scope. Phase γ
// replaces this with per-kind Artifact cards (Decision rationale list,
// RFC sections, Domain summary).
//
// Uses Foundation's AttributedString markdown init (macOS 13+,
// Apple-canonical) — D26 g_swift_native. No third-party markdown parser.
// `interpretedSyntax: .full` enables headings + lists + code blocks; if
// parsing fails, falls back to monospaced raw text (still legible).

import SwiftUI
import DemiurgeCore

struct MarkdownView: View {
    let stub: ArtifactStub
    @State private var raw: String = ""
    @State private var loaded: Bool = false
    @State private var loadError: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                header
                Divider()
                body_
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear(perform: load)
        .id(stub.id.id)   // reload on selection change
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stub.id.display)
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .foregroundColor(.secondary)
            Text(stub.title)
                .font(.system(size: 18, weight: .semibold))
            Text(stub.path)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.middle)
        }
    }

    @ViewBuilder private var body_: some View {
        if let err = loadError {
            Text("load failed: \(err)")
                .foregroundColor(.red)
                .font(.system(.body, design: .monospaced))
        } else if !loaded {
            ProgressView("loading…")
        } else if let attr = try? AttributedString(
            markdown: raw,
            options: AttributedString.MarkdownParsingOptions(
                interpretedSyntax: .full
            )
        ) {
            Text(attr)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            Text(raw)
                .font(.system(.callout, design: .monospaced))
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func load() {
        loaded = false
        loadError = nil
        raw = ""
        do {
            raw = try String(contentsOfFile: stub.path, encoding: .utf8)
            loaded = true
        } catch {
            loadError = error.localizedDescription
            loaded = true
        }
    }
}
