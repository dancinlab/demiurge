// OperationRegistry — the operation manifest (CLI+COCKPIT M14).
//
// The single d4-generic enumeration of EVERY operation the product
// surface (app + CLI) exposes, classified so we can prove the goal:
// "an external user can fully operate demiurge from app + CLI alone"
// (CLI+COCKPIT.md @goal, spec = CLI+COCKPIT/M0_operate.md §3).
//
// This file is data + read helpers only — the generic execution path
// (OperationDispatch) and the per-op wiring land in M15-M17. cockpit
// and CLI consult the SAME table (D50 byte-identical), so neither
// surface can drift from the manifest (@D d4 — add/rename/remove is a
// table edit here, never a hardcoded branch in a surface).
//
// Tier model (M0_operate.md §1, 3-layer ownership):
//   • .product — 진열대: visible to external users. The @goal target.
//   • .owner   — 사장실: owner-only, env-gated (DEMIURGE_OWNER), never
//                shown to external users (M20).
//
// Target = who actually does the leaf work (M0_operate.md §1):
//   • .swift     — demiurge-owned operation code (cockpit/Sources).
//   • .hexa      — hexa-lang stdlib SSOT, called as an hx dependency.
//   • .substrate — infra primitive (pool / cloud / git); owner-gated.

import Foundation

public enum OperationTier: String, Sendable, CaseIterable {
    case product   // 진열대 (external)
    case owner     // 사장실 (owner-only, env-gated)
}

public enum OperationTarget: String, Sendable {
    case swift     // demiurge-owned 작동부
    case hexa      // hexa-lang stdlib SSOT (hx dependency)
    case substrate // pool / cloud / git infra
}

/// Current reachability of an operation FROM the two surfaces (not from
/// external tools). The audit (M21) drives `@goal` off this column.
public enum OperationReach: String, Sendable {
    case ok        // ✅ fully reachable from app + CLI
    case partial   // 🔶 one surface only, or honest-gap path
    case blocked   // ❌ not yet reachable — needs the named milestone

    public var glyph: String {
        switch self {
        case .ok:      return "✅"
        case .partial: return "🔶"
        case .blocked: return "❌"
        }
    }
}

/// One row of the operation manifest (M0_operate.md §3).
public struct Operation: Sendable, Identifiable {
    public let id: String            // kebab op id (stable)
    public let title: String         // Korean display label
    public let tier: OperationTier
    public let verb: Verb?           // owning 7-verb stage (nil = cross-cutting)
    public let target: OperationTarget
    public let reach: OperationReach
    public let milestone: String     // owning milestone (e.g. "M16")

    public init(id: String, title: String, tier: OperationTier,
                verb: Verb?, target: OperationTarget,
                reach: OperationReach, milestone: String) {
        self.id = id; self.title = title; self.tier = tier
        self.verb = verb; self.target = target
        self.reach = reach; self.milestone = milestone
    }
}

public enum OperationRegistry {

    /// The 17-op census (M0_operate.md §3). Order = product first, then
    /// owner. EDIT HERE to add/rename/remove an operation (@D d4).
    public static let all: [Operation] = [
        // ── 진열대 (product · external) — 12 ──
        Operation(id: "project",         title: "프로젝트 생성·목록·전환·삭제", tier: .product, verb: .specify,    target: .swift,     reach: .ok,      milestone: "M15"),
        Operation(id: "verb-nav",        title: "7단계 앞/뒤 이동",          tier: .product, verb: nil,         target: .swift,     reach: .partial, milestone: "M15"),
        Operation(id: "spec-capture",    title: "spec 입력 (재료 선반)",      tier: .product, verb: .specify,    target: .swift,     reach: .ok,      milestone: "M15"),
        Operation(id: "structure-view",  title: "structure 구조 분해 뷰",     tier: .product, verb: .structure,  target: .swift,     reach: .ok,      milestone: "M15"),
        Operation(id: "design-pick",     title: "design 옵션 선택",          tier: .product, verb: .design,     target: .swift,     reach: .ok,      milestone: "M15"),
        Operation(id: "analyze-loop",    title: "analyze ⟲ 수렴 runner",     tier: .product, verb: .analyze,    target: .swift,     reach: .partial, milestone: "M15"),
        Operation(id: "synthesize-run",  title: "synthesize 실행 (engine)",   tier: .product, verb: .synthesize, target: .swift,     reach: .partial, milestone: "M15"),
        Operation(id: "verify",          title: "verify (5-tier 검증)",       tier: .product, verb: .verify,     target: .hexa,      reach: .ok,      milestone: "M16"),
        Operation(id: "record-view",     title: "record·gate 열람",          tier: .product, verb: .verify,     target: .swift,     reach: .ok,      milestone: "M15"),
        Operation(id: "export",          title: "결과 export (usd/stl/record)", tier: .product, verb: .handoff,  target: .swift,     reach: .ok,      milestone: "M15"),
        Operation(id: "atlas-lookup",    title: "atlas 조회 (읽기)",          tier: .product, verb: .verify,     target: .hexa,      reach: .blocked, milestone: "M16"),
        Operation(id: "compute-backend", title: "compute 백엔드 선택 (로컬/원격)", tier: .product, verb: .synthesize, target: .substrate, reach: .blocked, milestone: "M17"),
        // ── 사장실 (owner · env-gated DEMIURGE_OWNER) — 5 ──
        Operation(id: "pool-route",      title: "pool → 내 호스트 라우팅",     tier: .owner,   verb: .synthesize, target: .substrate, reach: .partial, milestone: "M20"),
        Operation(id: "inbox-handoff",   title: "inbox/patches → hexa-lang 핸드오프", tier: .owner, verb: .handoff, target: .substrate, reach: .partial, milestone: "M20"),
        Operation(id: "atlas-register",  title: "atlas 등록 PR → dancinlab",   tier: .owner,   verb: .verify,     target: .substrate, reach: .partial, milestone: "M20"),
        Operation(id: "governance",      title: "@D 거버넌스 enforcement",     tier: .owner,   verb: nil,         target: .swift,     reach: .partial, milestone: "M20"),
        Operation(id: "owner-domain",    title: "내 연구 domain <NAME>.md 운영", tier: .owner,  verb: .specify,    target: .swift,     reach: .partial, milestone: "M20"),
    ]

    /// True when the owner 사장실 is unlocked for this process — gated on
    /// the `DEMIURGE_OWNER` env var. External users never set it, so
    /// owner ops stay invisible to them (M0_operate.md §1 / M20).
    public static var ownerModeEnabled: Bool {
        ProcessInfo.processInfo.environment["DEMIURGE_OWNER"] != nil
    }

    /// Operations the current process may see. Product ops always;
    /// owner ops only when the 사장실 is unlocked (or `force`-shown for
    /// an owner-side audit).
    public static func visible(ownerMode: Bool? = nil) -> [Operation] {
        let owner = ownerMode ?? ownerModeEnabled
        return all.filter { $0.tier == .product || owner }
    }

    public static func op(id: String) -> Operation? {
        all.first { $0.id == id }
    }
}

/// Operability acceptance snapshot (CLI+COCKPIT M21 foundation). The
/// @goal is met when `productComplete` is true — every product-tier op
/// reachable from the two surfaces with no ❌/🔶 remaining.
public struct OperabilityAudit: Sendable {
    public let productOK: Int
    public let productPartial: Int
    public let productBlocked: Int
    public let ownerTotal: Int

    public var productTotal: Int { productOK + productPartial + productBlocked }
    public var productComplete: Bool { productBlocked == 0 && productPartial == 0 }

    public static func run() -> OperabilityAudit {
        let product = OperationRegistry.all.filter { $0.tier == .product }
        return OperabilityAudit(
            productOK:      product.filter { $0.reach == .ok }.count,
            productPartial: product.filter { $0.reach == .partial }.count,
            productBlocked: product.filter { $0.reach == .blocked }.count,
            ownerTotal:     OperationRegistry.all.filter { $0.tier == .owner }.count)
    }
}
