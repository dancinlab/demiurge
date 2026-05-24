// LLMProvider — a generic AI-backend descriptor (CLI+COCKPIT · D38).
//
// @D d4 (single generic dispatch): providers are MANIFEST DATA, not code
// branches. Adding / renaming / removing a provider = editing this seed
// list (or the user's ~/.demiurge/llm.json) — NEVER touching the
// dispatcher. `LLMBridge` branches on `wireFormat` (a declared API-shape
// trait), not on a provider id, so a new OpenAI-compatible backend is a
// data-only change.
//
// Pure Foundation (Package.swift contract — no SwiftUI / AppKit).

import Foundation

/// How a turn reaches the model: an installed CLI, or the HTTPS API.
public enum LLMMode: String, Codable, Sendable, CaseIterable {
    case cli   // spawn an installed CLI (claude / codex / gemini)
    case api   // HTTPS to the provider's API (key required)

    public var label: String { self == .cli ? "CLI (설치된 명령)" : "API (키 입력)" }
}

/// The request/response shape of a provider's HTTPS API. The dispatcher
/// branches on THIS (a trait), not on the provider id (@D d4) — so two
/// providers sharing a format reuse one code path.
public enum LLMWireFormat: String, Codable, Sendable {
    case anthropic   // POST /v1/messages · header x-api-key
    case openai      // POST /v1/chat/completions · header Authorization: Bearer
    case gemini      // POST …/{model}:generateContent · ?key=
}

public struct LLMProvider: Codable, Sendable, Identifiable, Equatable {
    public let id: String            // "claude" — stable key (config · keychain account)
    public let displayName: String   // "Claude"
    public let cliCommand: [String]  // ["claude","-p","{prompt}"] — {prompt}/{model} substituted
    public let apiBaseURL: String    // "https://api.anthropic.com"
    public let apiPath: String       // "/v1/messages" — {model} substituted (gemini)
    public let keyEnv: String        // "ANTHROPIC_API_KEY" — env read FIRST (no keychain prompt)
    public let wireFormat: LLMWireFormat
    public let defaultModel: String

    public init(id: String, displayName: String, cliCommand: [String],
                apiBaseURL: String, apiPath: String, keyEnv: String,
                wireFormat: LLMWireFormat, defaultModel: String) {
        self.id = id; self.displayName = displayName; self.cliCommand = cliCommand
        self.apiBaseURL = apiBaseURL; self.apiPath = apiPath; self.keyEnv = keyEnv
        self.wireFormat = wireFormat; self.defaultModel = defaultModel
    }
}

public extension LLMProvider {
    /// Built-in seed manifest. Users override `model` / `cliCommand` per
    /// provider in ~/.demiurge/llm.json (LLMConfig) — this is only the
    /// starting list, and the dispatcher never special-cases these ids.
    static let builtins: [LLMProvider] = [
        LLMProvider(
            id: "claude", displayName: "Claude",
            cliCommand: ["claude", "-p", "{prompt}"],
            apiBaseURL: "https://api.anthropic.com", apiPath: "/v1/messages",
            keyEnv: "ANTHROPIC_API_KEY", wireFormat: .anthropic,
            defaultModel: "claude-opus-4-7"),
        LLMProvider(
            id: "codex", displayName: "Codex (OpenAI)",
            // `--skip-git-repo-check` lets codex run from cwd=/ (GUI .app
            // launch) — without it codex refuses with "Not inside a trusted
            // directory" since the .app's cwd isn't in its allowlist.
            cliCommand: ["codex", "exec", "--skip-git-repo-check", "{prompt}"],
            apiBaseURL: "https://api.openai.com", apiPath: "/v1/chat/completions",
            keyEnv: "OPENAI_API_KEY", wireFormat: .openai,
            defaultModel: "gpt-5-codex"),
        LLMProvider(
            id: "gemini", displayName: "Gemini",
            // `--skip-trust` lets gemini run from cwd=/ (GUI .app launch) —
            // same gotcha as codex (#104). Without it gemini refuses with
            // "Gemini CLI is not running in a trusted directory".
            cliCommand: ["gemini", "--skip-trust", "-p", "{prompt}"],
            apiBaseURL: "https://generativelanguage.googleapis.com",
            apiPath: "/v1beta/models/{model}:generateContent",
            keyEnv: "GEMINI_API_KEY", wireFormat: .gemini,
            defaultModel: "gemini-2.5-pro"),
    ]
}
