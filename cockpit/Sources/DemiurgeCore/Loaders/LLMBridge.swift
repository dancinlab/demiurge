// LLMBridge — the single generic AI dispatch path (CLI+COCKPIT · D38).
//
// One entry — `ask(...)` — for cockpit chat AND `demiurge llm ask`. It
// reads the active provider + mode (LLMSettings) and routes:
//   .cli  → spawn provider.cliCommand ({prompt}/{model} substituted)
//   .api  → HTTPS POST, body/parse selected by provider.wireFormat
//
// @D d4: the ONLY switch is on `wireFormat` (a trait), never on a
// provider id — adding an OpenAI-compatible backend is manifest-only.
// Synchronous (semaphore) so it drops into the existing off-main
// `Task.detached { … }` chat path without an API-shape change.
//
// Pure Foundation (Package.swift contract).

import Foundation

public struct LLMReply: Sendable {
    public let text: String
    public let ok: Bool
    public let detail: String   // "claude · cli · 1.2s" or the failure reason
    public init(text: String, ok: Bool, detail: String) {
        self.text = text; self.ok = ok; self.detail = detail
    }
}

public enum LLMBridge {

    /// The user's login-shell PATH — captured ONCE (lazy + thread-safe).
    /// Lets the bridge see whatever .zshrc / .bashrc / npm-prefix / nvm /
    /// homebrew shellenv put on PATH for an interactive terminal, which a
    /// GUI .app would otherwise NOT inherit.
    private static let loginShellPath: String = {
        let shell = ProcessInfo.processInfo.environment["SHELL"] ?? "/bin/zsh"
        guard FileManager.default.isExecutableFile(atPath: shell) else { return "" }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: shell)
        proc.arguments = ["-lc", "printf %s \"$PATH\""]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = Pipe()
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            return String(data: data, encoding: .utf8)?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        } catch {
            return ""
        }
    }()

    /// Wrap the user turn with the cockpit's read-only guard (mirrors the
    /// former askClaude prelude) so every provider gets the same framing.
    private static func guarded(_ prompt: String, context: String) -> String {
        "[demiurge — answer concisely in Korean, plain language; do NOT "
        + "modify files, run builds, or invoke tools. Project context: "
        + "\(context)] \(prompt)"
    }

    /// Main entry — used by the cockpit chat and the CLI.
    public static func ask(_ prompt: String, context: String,
                           config: LLMConfig? = nil) -> LLMReply {
        let cfg = config ?? LLMSettings.load()
        let provider = LLMSettings.active(cfg)
        let text = guarded(prompt, context: context)
        switch cfg.mode {
        case .cli: return runCLI(provider, prompt: text)
        case .api: return runAPI(provider, prompt: text)
        }
    }

    /// Connection test — a tiny fixed prompt, for the settings modal /
    /// `demiurge llm ask`. Honours the explicitly-passed provider+mode so
    /// the user can test before saving.
    public static func test(_ provider: LLMProvider, mode: LLMMode) -> LLMReply {
        let probe = "ping — reply with the single word: pong"
        switch mode {
        case .cli: return runCLI(provider, prompt: probe)
        case .api: return runAPI(provider, prompt: probe)
        }
    }

    // MARK: — .cli

    private static func runCLI(_ provider: LLMProvider, prompt: String) -> LLMReply {
        guard let exe = provider.cliCommand.first else {
            return LLMReply(text: "", ok: false,
                            detail: "\(provider.id): cliCommand 비어 있음")
        }
        let args = provider.cliCommand.dropFirst().map {
            $0.replacingOccurrences(of: "{prompt}", with: prompt)
              .replacingOccurrences(of: "{model}", with: provider.defaultModel)
        }
        let start = Date()
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = [exe] + args
        // macOS GUI .app processes inherit a MINIMAL PATH (no .zshrc /
        // .bashrc). Three-layer augmentation so claude / codex / gemini
        // are found wherever the user installed them:
        //   1) the user's login-shell PATH (covers brew · npm-global ·
        //      pipx · hexa · nvm · cargo · pyenv · custom — whatever
        //      their shell rc sets up).
        //   2) a static safety net of well-known dev bin paths.
        //   3) the .app's existing minimal PATH.
        // Highest precedence first.
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let staticPaths = [
            "/opt/homebrew/bin", "/opt/homebrew/sbin",
            "/usr/local/bin", "/usr/local/sbin",
            "/opt/local/bin",
            "\(home)/.hx/bin", "\(home)/.local/bin",
            "\(home)/.cargo/bin", "\(home)/.npm-global/bin",
            "\(home)/.deno/bin", "\(home)/.bun/bin", "\(home)/.volta/bin",
        ].joined(separator: ":")
        var env = ProcessInfo.processInfo.environment
        let appPath = env["PATH"] ?? "/usr/bin:/bin"
        env["PATH"] = [Self.loginShellPath, staticPaths, appPath]
            .filter { !$0.isEmpty }.joined(separator: ":")
        proc.environment = env
        // Close stdin — codex / claude / gemini print "Reading additional
        // input from stdin..." and block reading when stdin isn't closed.
        // In a GUI .app launch the parent's stdin is a launchd descriptor
        // the child can't drain, so the CLI hangs / errors. /dev/null →
        // immediate EOF so the providers proceed with the prompt argv only.
        proc.standardInput = FileHandle.nullDevice
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            let out = (String(data: data, encoding: .utf8) ?? "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let dt = String(format: "%.1fs", Date().timeIntervalSince(start))
            if proc.terminationStatus != 0 {
                // Surface the CLI's actual stderr/stdout snippet so the user
                // sees WHY it failed (auth · network · syntax — not just exit
                // code). Truncated to keep the modal's status line readable.
                let snippet = out.isEmpty
                    ? "(no output)"
                    : String(out.prefix(240)).replacingOccurrences(of: "\n", with: " ⏎ ")
                return LLMReply(
                    text: out, ok: false,
                    detail: "\(provider.id) · cli · exit \(proc.terminationStatus) — \(snippet)")
            }
            if out.isEmpty {
                return LLMReply(text: "", ok: false,
                                detail: "\(provider.id) · cli · 빈 출력")
            }
            return LLMReply(text: out, ok: true, detail: "\(provider.id) · cli · \(dt)")
        } catch {
            return LLMReply(
                text: "", ok: false,
                detail: "\(provider.id) · cli 실행 실패 — `\(exe)` 가 PATH에 있어야 함 (\(error.localizedDescription))")
        }
    }

    // MARK: — .api

    private static func runAPI(_ provider: LLMProvider, prompt: String) -> LLMReply {
        guard let key = LLMKeyStore.resolvedKey(for: provider) else {
            return LLMReply(
                text: "", ok: false,
                detail: "\(provider.id) · api · 키 없음 — 설정에서 키 입력 또는 \(provider.keyEnv) export")
        }
        let model = provider.defaultModel
        var urlString = provider.apiBaseURL + provider.apiPath
            .replacingOccurrences(of: "{model}", with: model)
        var headers: [String: String] = ["content-type": "application/json"]
        let body: [String: Any]

        switch provider.wireFormat {
        case .anthropic:
            headers["x-api-key"] = key
            headers["anthropic-version"] = "2023-06-01"
            body = ["model": model, "max_tokens": 1024,
                    "messages": [["role": "user", "content": prompt]]]
        case .openai:
            headers["authorization"] = "Bearer \(key)"
            body = ["model": model,
                    "messages": [["role": "user", "content": prompt]]]
        case .gemini:
            urlString += "?key=\(key)"
            body = ["contents": [["parts": [["text": prompt]]]]]
        }

        guard let url = URL(string: urlString),
              let payload = try? JSONSerialization.data(withJSONObject: body) else {
            return LLMReply(text: "", ok: false,
                            detail: "\(provider.id) · api · 요청 구성 실패")
        }

        let start = Date()
        let (data, response, error) = httpPOST(url: url, headers: headers, body: payload)
        let dt = String(format: "%.1fs", Date().timeIntervalSince(start))

        if let error { return LLMReply(text: "", ok: false,
                                       detail: "\(provider.id) · api · 네트워크 오류 — \(error.localizedDescription)") }
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard let data else { return LLMReply(text: "", ok: false,
                                              detail: "\(provider.id) · api · 응답 없음 (status \(status))") }
        guard status == 200 else {
            let msg = String(data: data, encoding: .utf8)?
                .prefix(200) ?? ""
            return LLMReply(text: "", ok: false,
                            detail: "\(provider.id) · api · HTTP \(status) — \(msg)")
        }
        guard let text = parse(data, format: provider.wireFormat) else {
            return LLMReply(text: "", ok: false,
                            detail: "\(provider.id) · api · 응답 파싱 실패")
        }
        return LLMReply(text: text, ok: true, detail: "\(provider.id) · api · \(dt)")
    }

    /// Pull the assistant text out of a provider response by wire format.
    private static func parse(_ data: Data, format: LLMWireFormat) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { return nil }
        switch format {
        case .anthropic:
            let content = json["content"] as? [[String: Any]]
            return (content?.first? ["text"] as? String)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
        case .openai:
            let choices = json["choices"] as? [[String: Any]]
            let message = choices?.first? ["message"] as? [String: Any]
            return (message?["content"] as? String)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
        case .gemini:
            let candidates = json["candidates"] as? [[String: Any]]
            let content = candidates?.first? ["content"] as? [String: Any]
            let parts = content?["parts"] as? [[String: Any]]
            return (parts?.first? ["text"] as? String)?
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    /// Blocking POST (the bridge is sync; callers already run it off-main).
    private static func httpPOST(url: URL, headers: [String: String],
                                 body: Data) -> (Data?, URLResponse?, Error?) {
        var req = URLRequest(url: url, timeoutInterval: 60)
        req.httpMethod = "POST"
        req.httpBody = body
        for (k, v) in headers { req.setValue(v, forHTTPHeaderField: k) }

        final class Box: @unchecked Sendable {
            var data: Data?; var response: URLResponse?; var error: Error?
        }
        let box = Box()
        let sem = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: req) { d, r, e in
            box.data = d; box.response = r; box.error = e; sem.signal()
        }.resume()
        sem.wait()
        return (box.data, box.response, box.error)
    }
}
