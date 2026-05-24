// ComputeBackend — where heavy compute runs (CLI+COCKPIT M17).
//
// @goal: external users operate with NO owner infra. So the default
// backend is `.local` (this machine); an optional user remote comes
// from the `DEMIURGE_BACKEND` env. Owner pool hosts are NOT hardcoded
// in demiurge (the @goal forbids `ubu-1`/`mini` literals) — they are
// read at runtime from the owner's OWN `~/.pool/pool.json`, and only
// when DEMIURGE_OWNER is set (사장실 · M0_operate.md §1). External users
// never see them.
//
// This is the backend-selection surface; the actual dispatch-to-backend
// execution (synthesize on the chosen host) is the M15 7-verb wiring.

import Foundation

public enum BackendKind: String, Sendable {
    case local    // this machine (default · external)
    case remote   // user-configured remote (DEMIURGE_BACKEND · external)
    case pool     // owner pool host (read from ~/.pool/pool.json · 🔒)
}

public struct ComputeBackend: Sendable, Identifiable {
    public let id: String       // "local" · "remote:<host>" · "pool:<name>"
    public let label: String
    public let kind: BackendKind
    public let host: String     // ssh target ("this machine" for local)
    public let owner: Bool      // owner-gated (사장실)

    public init(id: String, label: String, kind: BackendKind,
                host: String, owner: Bool) {
        self.id = id; self.label = label; self.kind = kind
        self.host = host; self.owner = owner
    }
}

public enum BackendResolver {

    public static let local = ComputeBackend(
        id: "local", label: "내 컴퓨터 (local)", kind: .local,
        host: "this machine", owner: false)

    /// User-configured remote via `DEMIURGE_BACKEND` (bare "host" or
    /// "ssh:<target>"). `nil` / "local" → use the local default.
    static func userRemote() -> ComputeBackend? {
        guard let spec = ProcessInfo.processInfo
                .environment["DEMIURGE_BACKEND"]?
                .trimmingCharacters(in: .whitespaces),
              !spec.isEmpty, spec.lowercased() != "local" else { return nil }
        let host = spec.hasPrefix("ssh:") ? String(spec.dropFirst(4)) : spec
        return ComputeBackend(
            id: "remote:\(host)", label: "원격 백엔드 (\(host))",
            kind: .remote, host: host, owner: false)
    }

    /// Owner pool hosts read from the owner's OWN `~/.pool/pool.json`
    /// (NOT hardcoded — @goal). Empty when the file is absent (external).
    static func poolHosts() -> [ComputeBackend] {
        let url = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".pool/pool.json")
        guard let data = try? Data(contentsOf: url),
              let cfg = try? JSONDecoder().decode(PoolConfig.self, from: data)
        else { return [] }
        return cfg.hosts.map {
            ComputeBackend(
                id: "pool:\($0.name)",
                label: "pool · \($0.name) (\($0.os))",
                kind: .pool, host: $0.ssh, owner: true)
        }
    }

    /// Backends visible to the current process. Always `local`; the user
    /// remote if configured; owner pool hosts only in owner mode.
    public static func available(ownerMode: Bool? = nil) -> [ComputeBackend] {
        let owner = ownerMode ?? OperationRegistry.ownerModeEnabled
        var out: [ComputeBackend] = [local]
        if let r = userRemote() { out.append(r) }
        if owner { out.append(contentsOf: poolHosts()) }
        return out
    }

    /// The active backend — the user remote if configured, else local.
    /// (Selecting an owner pool host is an explicit owner action · M20,
    /// never the default.)
    public static var active: ComputeBackend { userRemote() ?? local }

    private struct PoolConfig: Codable { let hosts: [PoolHost] }
    private struct PoolHost: Codable {
        let name: String
        let ssh: String
        let os: String
    }
}
