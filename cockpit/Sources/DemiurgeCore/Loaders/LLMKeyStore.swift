// LLMKeyStore — API-key resolution + secure storage (CLI+COCKPIT · D38).
//
// User-chosen policy: Keychain + env fallback.
//   READ  — env var (provider.keyEnv) FIRST, then the macOS Keychain.
//           Env-first means CLI / power users never trigger a Keychain
//           access prompt (relevant for unsigned `swift run` dev builds).
//   WRITE — the "저장" button / `demiurge llm key` writes the Keychain
//           (service = lab.dancin.demiurge.llm, account = provider id).
//
// `Security` is a headless system framework (works in CLI + app, no UI
// dependency) so DemiurgeCore keeps its "Foundation, no SwiftUI/AppKit"
// contract intact (Package.swift).

import Foundation
import Security

public enum LLMKeyStore {
    private static let service = "lab.dancin.demiurge.llm"

    /// The key to use for a request: env var first, else Keychain. `nil`
    /// when neither is set (API mode then surfaces an honest error).
    public static func resolvedKey(for provider: LLMProvider) -> String? {
        if let env = ProcessInfo.processInfo.environment[provider.keyEnv]?
            .trimmingCharacters(in: .whitespacesAndNewlines), !env.isEmpty {
            return env
        }
        return keychainRead(account: provider.id)
    }

    /// Where the resolved key comes from — for the settings UI ("env" /
    /// "키체인" / "없음") without revealing the value.
    public static func keySource(for provider: LLMProvider) -> String {
        if let env = ProcessInfo.processInfo.environment[provider.keyEnv]?
            .trimmingCharacters(in: .whitespacesAndNewlines), !env.isEmpty {
            return "env (\(provider.keyEnv))"
        }
        return keychainRead(account: provider.id) != nil ? "키체인" : "없음"
    }

    @discardableResult
    public static func setKey(_ key: String, for provider: LLMProvider) -> Bool {
        let value = key.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty, let data = value.data(using: .utf8) else {
            return false
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: provider.id,
        ]
        SecItemDelete(query as CFDictionary)   // replace if present
        var add = query
        add[kSecValueData as String] = data
        add[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
        return SecItemAdd(add as CFDictionary, nil) == errSecSuccess
    }

    public static func deleteKey(for provider: LLMProvider) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: provider.id,
        ]
        SecItemDelete(query as CFDictionary)
    }

    private static func keychainRead(account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
        var item: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
              let data = item as? Data,
              let str = String(data: data, encoding: .utf8) else { return nil }
        return str
    }
}
