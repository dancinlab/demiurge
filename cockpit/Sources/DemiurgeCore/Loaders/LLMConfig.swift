// LLMConfig — non-secret LLM settings (CLI+COCKPIT · D38).
//
// Stored at ~/.demiurge/llm.json (shared by cockpit + CLI). Holds the
// SELECTION only — selected provider, mode, and per-provider model /
// CLI-command overrides. API KEYS are NOT here (user chose Keychain +
// env fallback · LLMKeyStore).
//
// Resolution mirrors BackendResolver (manifest + overrides, no instance
// hardcoding · @D d4): `providers()` = builtins with the user's per-id
// overrides applied; `active()` picks the selected one.
//
// Pure Foundation (Package.swift contract).

import Foundation

public struct LLMConfig: Codable, Sendable, Equatable {
    public var selectedProvider: String
    public var mode: LLMMode
    public var models: [String: String]        // provider id → model override
    public var cliOverrides: [String: [String]] // provider id → cliCommand override

    public init(selectedProvider: String = LLMProvider.builtins[0].id,
                mode: LLMMode = .cli,
                models: [String: String] = [:],
                cliOverrides: [String: [String]] = [:]) {
        self.selectedProvider = selectedProvider
        self.mode = mode
        self.models = models
        self.cliOverrides = cliOverrides
    }
}

public enum LLMSettings {
    public static var configDir: URL {
        FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".demiurge", isDirectory: true)
    }
    public static var configURL: URL {
        configDir.appendingPathComponent("llm.json")
    }

    /// Load settings (defaults on miss / malformed — a sane default beats
    /// a crash, matching ChatStore).
    public static func load() -> LLMConfig {
        guard let data = try? Data(contentsOf: configURL),
              let cfg = try? JSONDecoder().decode(LLMConfig.self, from: data)
        else { return LLMConfig() }
        return cfg
    }

    /// Persist settings (0600 — owner-only, even though no secrets live
    /// here, the directory may later hold them via env-dump habits).
    public static func save(_ cfg: LLMConfig) throws {
        try FileManager.default.createDirectory(
            at: configDir, withIntermediateDirectories: true,
            attributes: [.posixPermissions: 0o700])
        let enc = JSONEncoder()
        enc.outputFormatting = [.prettyPrinted, .sortedKeys]
        try enc.encode(cfg).write(to: configURL, options: .atomic)
        try? FileManager.default.setAttributes(
            [.posixPermissions: 0o600], ofItemAtPath: configURL.path)
    }

    /// Resolved provider list: builtins with the user's per-id `model` /
    /// `cliCommand` overrides folded in. (Unknown override ids are
    /// ignored — the manifest stays the source of truth.)
    public static func providers(_ cfg: LLMConfig? = nil) -> [LLMProvider] {
        let c = cfg ?? load()
        return LLMProvider.builtins.map { p in
            LLMProvider(
                id: p.id, displayName: p.displayName,
                cliCommand: c.cliOverrides[p.id] ?? p.cliCommand,
                apiBaseURL: p.apiBaseURL, apiPath: p.apiPath, keyEnv: p.keyEnv,
                wireFormat: p.wireFormat,
                defaultModel: c.models[p.id] ?? p.defaultModel)
        }
    }

    /// The active provider — the selected id, or the first builtin if the
    /// selection is stale.
    public static func active(_ cfg: LLMConfig? = nil) -> LLMProvider {
        let c = cfg ?? load()
        let list = providers(c)
        return list.first { $0.id == c.selectedProvider } ?? list[0]
    }
}
