// LLMSettingsView — the ⚙ "AI 연결" settings modal (CLI+COCKPIT · D38).
//
// Lets the user pick the AI provider (Claude / Codex / Gemini — rendered
// from the LLMProvider manifest, no id hardcoding · @D d4), choose CLI vs
// API mode, enter an API key (stored per LLMKeyStore: Keychain, env-read
// first), and run a live connection test before saving.
//
// Reads/writes the SAME ~/.demiurge/llm.json + Keychain that the
// `demiurge llm` CLI uses (one settings source · D50).

import SwiftUI
import DemiurgeCore

struct LLMSettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var config = LLMSettings.load()
    @State private var keyInput: [String: String] = [:]   // provider id → typed key (unsaved)
    @State private var cliInput: [String: String] = [:]   // provider id → cli command string
    @State private var modelInput: [String: String] = [:] // provider id → model
    @State private var testing = false
    @State private var testResult: String?
    @State private var testOK = false

    private var providers: [LLMProvider] { LLMSettings.providers(config) }
    private var selected: LLMProvider { LLMSettings.active(config) }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("⚙ 설정 · AI 연결")
                .font(.title3.bold())

            // AI 제공자 — manifest ForEach (하드코딩 X)
            Picker("AI 제공자", selection: $config.selectedProvider) {
                ForEach(providers) { p in Text(p.displayName).tag(p.id) }
            }
            .pickerStyle(.segmented)

            // 연결 방식
            Picker("연결 방식", selection: $config.mode) {
                ForEach(LLMMode.allCases, id: \.self) { m in
                    Text(m.label).tag(m)
                }
            }
            .pickerStyle(.segmented)

            providerCard

            // 연결 테스트
            HStack(spacing: 12) {
                Button {
                    runTest()
                } label: {
                    Label("연결 테스트", systemImage: "bolt.horizontal")
                }
                .disabled(testing)
                if testing {
                    ProgressView().controlSize(.small)
                } else if let testResult {
                    Text(testResult)
                        .font(.callout)
                        .foregroundStyle(testOK ? .green : .red)
                        .lineLimit(2)
                }
                Spacer()
            }

            Divider()

            HStack {
                Text("키는 env(\(selected.keyEnv)) 우선 → 없으면 키체인")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Button("취소") { dismiss() }
                    .keyboardShortcut(.cancelAction)
                Button("저장") { save() }
                    .keyboardShortcut(.defaultAction)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(20)
        .frame(width: 500)
        .onAppear(perform: seedInputs)
    }

    @ViewBuilder private var providerCard: some View {
        let p = selected
        GroupBox(p.displayName) {
            VStack(alignment: .leading, spacing: 10) {
                if config.mode == .cli {
                    LabeledContent("CLI 명령") {
                        TextField(p.cliCommand.joined(separator: " "),
                                  text: bindingFor($cliInput, p.id,
                                                   default: p.cliCommand.joined(separator: " ")))
                        .textFieldStyle(.roundedBorder)
                    }
                    Text("예: `claude -p {prompt}` · `codex exec {prompt}` · `gemini -p {prompt}`")
                        .font(.caption).foregroundStyle(.secondary)
                } else {
                    LabeledContent("API 키") {
                        HStack {
                            SecureField(LLMKeyStore.keySource(for: p) == "없음"
                                        ? "키 입력 (\(p.keyEnv))" : "현재: \(LLMKeyStore.keySource(for: p))",
                                        text: bindingFor($keyInput, p.id, default: ""))
                            .textFieldStyle(.roundedBorder)
                            // 🗑 — only when a Keychain key is stored (env source
                            // isn't ours to clear). Mirrors CLI `llm key-rm`.
                            if LLMKeyStore.keySource(for: p) == "키체인" {
                                Button {
                                    LLMKeyStore.deleteKey(for: p)
                                    keyInput[p.id] = ""
                                } label: { Image(systemName: "trash") }
                                .help("저장된 키 삭제 (키체인) — env는 그대로")
                            }
                        }
                    }
                }
                LabeledContent("모델") {
                    TextField(p.defaultModel,
                              text: bindingFor($modelInput, p.id, default: p.defaultModel))
                    .textFieldStyle(.roundedBorder)
                }
            }
            .padding(6)
        }
    }

    // MARK: — actions

    private func seedInputs() {
        for p in providers {
            cliInput[p.id] = (config.cliOverrides[p.id] ?? p.cliCommand).joined(separator: " ")
            modelInput[p.id] = config.models[p.id] ?? p.defaultModel
        }
    }

    /// Fold the live text fields into a config + persist keys (Keychain).
    private func draftConfig() -> LLMConfig {
        var c = config
        for p in providers {
            if let m = modelInput[p.id], !m.isEmpty, m != p.defaultModel {
                c.models[p.id] = m
            }
            if let cli = cliInput[p.id], !cli.isEmpty {
                let parts = cli.split(separator: " ").map(String.init)
                if parts != p.cliCommand { c.cliOverrides[p.id] = parts }
            }
        }
        return c
    }

    private func runTest() {
        testing = true
        testResult = nil
        let c = draftConfig()
        // Persist a typed-but-unsaved key for the active provider so the
        // test exercises the real path (env-first read still wins).
        let p = LLMSettings.active(c)
        if let typed = keyInput[p.id], !typed.isEmpty {
            LLMKeyStore.setKey(typed, for: p)
        }
        let mode = c.mode
        Task.detached {
            let reply = LLMBridge.test(p, mode: mode)
            await MainActor.run {
                testing = false
                testOK = reply.ok
                testResult = reply.ok
                    ? "✅ 응답 OK — \(reply.detail)"
                    : "❌ \(reply.detail)"
            }
        }
    }

    private func save() {
        var c = draftConfig()
        // Store any typed keys to the Keychain (non-empty only).
        for p in providers {
            if let typed = keyInput[p.id]?.trimmingCharacters(in: .whitespaces),
               !typed.isEmpty {
                LLMKeyStore.setKey(typed, for: p)
            }
        }
        c.selectedProvider = config.selectedProvider
        c.mode = config.mode
        try? LLMSettings.save(c)
        dismiss()
    }

    /// A Binding into a `[String:String]` dictionary state with a default.
    private func bindingFor(_ dict: Binding<[String: String]>,
                            _ key: String, default def: String) -> Binding<String> {
        Binding(
            get: { dict.wrappedValue[key] ?? def },
            set: { dict.wrappedValue[key] = $0 }
        )
    }
}
