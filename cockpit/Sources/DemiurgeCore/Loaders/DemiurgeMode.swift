// DemiurgeMode — process-level display / privilege gates (CLI+COCKPIT
// M19·M20). The single place both surfaces read so plain/expert and
// external/owner behavior never diverge (D50).
//
// @goal: the product is for EXTERNAL users. So BOTH gates default OFF —
// plain register (no internal jargon · M19) and external-only ops (no
// 사장실 · M20). The owner unlocks them with env vars on their own box.

import Foundation

public enum DemiurgeMode {
    /// Expert register — reveals internal ids / tier / target / milestone
    /// / SSOT paths. OFF by default (plain · external-safe, M19). Owner
    /// opt-in via `DEMIURGE_EXPERT`.
    public static var expert: Bool {
        ProcessInfo.processInfo.environment["DEMIURGE_EXPERT"] != nil
    }

    /// Owner 사장실 — unlocks owner-only ops (pool routing · atlas
    /// register · inbox handoff · governance). OFF by default (external
    /// users never see them, M20). Opt-in via `DEMIURGE_OWNER`.
    /// (Mirrors `OperationRegistry.ownerModeEnabled`, kept as the
    /// canonical name so callers read one gate.)
    public static var owner: Bool {
        ProcessInfo.processInfo.environment["DEMIURGE_OWNER"] != nil
    }
}
