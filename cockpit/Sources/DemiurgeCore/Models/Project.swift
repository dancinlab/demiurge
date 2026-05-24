// Project — the workbench's unit of user-created work (rfc_012 §2).
//
// A "project" is NOT an exports/ record: it is the cockpit's own
// work-state (rfc_012 §7, design.md D45). DemiurgeCore stays pure
// Foundation (Package.swift contract) so Project is Codable here and
// the manifest persistence layer (phase κ-2) reuses it verbatim.
//
// Honesty (g3, rfc_012 §6): a verb stage turns `.done` only through a
// measured record — phase κ-1 carries the state enum; the signal-light
// binding to provenance.measurement_gate lands with the θ-2 run path.

import Foundation

/// The 7-verb spine (GOAL.md · design.md D5).
///
/// D112 — `canonical` is the **English wire form** (enum case name) used
/// for serialization / cell-id dispatch / LLM prompts / any identifier
/// crossing a process boundary (e.g. Swift → hexa cellrun, JSON exports).
/// `koreanLabel` is the **Korean display label** used in cockpit chrome,
/// CLI human output, and chat banners. `plain` is the rfc_012 §4
/// non-expert Korean wording. Convention: English = wire, Korean =
/// display, plain = non-expert chat. See `archive/session-notes/2026-05-21-d111-
/// phaseb-bug2-verb-naming-options.md` for the option-α rationale.
public enum Verb: Int, CaseIterable, Codable, Identifiable, Sendable {
    case specify, structure, design, analyze, synthesize, verify, handoff

    public var id: Int { rawValue }

    /// Engineering wire form — English enum-case name (D112). Stable
    /// across process boundaries; safe to embed in serialized records,
    /// LLM prompts, and Swift→hexa dispatch arguments. For UI / CLI
    /// display in Korean use `koreanLabel`; for the non-expert chat
    /// register use `plain`.
    public var canonical: String {
        switch self {
        case .specify:    return "specify"
        case .structure:  return "structure"
        case .design:     return "design"
        case .analyze:    return "analyze"
        case .synthesize: return "synthesize"
        case .verify:     return "verify"
        case .handoff:    return "handoff"
        }
    }

    /// Korean display label (expert-mode UI chrome · CLI rendering ·
    /// chat banners). D112 — previously the return value of `canonical`;
    /// split out so identifier sites and display sites can diverge
    /// cleanly. The `해석⟲` glyph on `.analyze` is intentional — it
    /// marks the loop-back verb in the recipe-rail rendering.
    public var koreanLabel: String {
        switch self {
        case .specify:    return "명세"
        case .structure:  return "구조"
        case .design:     return "설계"
        case .analyze:    return "해석⟲"
        case .synthesize: return "합성"
        case .verify:     return "검증"
        case .handoff:    return "인계"
        }
    }

    /// Plain-language wording (rfc_012 §4 — default, non-expert).
    public var plain: String {
        switch self {
        case .specify:    return "무엇을"
        case .structure:  return "어떻게"
        case .design:     return "설계"
        case .analyze:    return "점검"
        case .synthesize: return "만들기"
        case .verify:     return "검증"
        case .handoff:    return "넘기기"
        }
    }

    /// SF Symbol for the ① recipe rail (canonical macOS iconography).
    public var symbol: String {
        switch self {
        case .specify:    return "doc.text"
        case .structure:  return "square.grid.3x3"
        case .design:     return "pencil.and.ruler"
        case .analyze:    return "arrow.triangle.2.circlepath"
        case .synthesize: return "hammer"
        case .verify:     return "checkmark.seal"
        case .handoff:    return "arrow.right.doc.on.clipboard"
        }
    }

    /// Plain-language one-line hint for the chat teacher (rfc_012 §5).
    /// Lives here so cockpit and CLI share it (g_ssot_single_source).
    public var hint: String {
        switch self {
        case .specify:    return "무엇을 만들지, 가장 중요한 게 뭔지 같이 정해요."
        case .structure:  return "전체를 어떤 짜임새로 나눌지 그려봐요."
        case .design:     return "각 부분을 구체적으로 설계해요."
        case .analyze:    return "설계가 잘 됐는지 점검하고 따져봐요."
        case .synthesize: return "실제로 만들 수 있는 형태로 합쳐요."
        case .verify:     return "측정으로 맞는지 확인해요."
        case .handoff:    return "결과를 다음 단계로 넘길 수 있게 정리해요."
        }
    }
}

/// A verb stage's progress relative to the project's current verb.
public enum VerbState: String, Codable, Sendable {
    /// Measured ✅ — a θ-2 run produced a record (g3, rfc_012 §6).
    case done
    /// The verb the project is working on now (◉).
    case current
    /// The verb pointer has passed this stage but no measurement
    /// backs it yet — honest ⏳, never silently upgraded to ✅.
    case visited
    /// Not reached yet (grey).
    case upcoming
}

/// A user-created workbench project (rfc_012 §2).
public struct Project: Codable, Identifiable, Sendable {
    public var id: UUID
    /// User-typed project name (e.g. "우리 회사 칩").
    public var name: String
    /// Free-text "무엇을 만들고 싶으세요" answer (rfc_012 §3, D44).
    public var target: String
    /// Domain inferred from `target`, then user-confirmed (D44).
    /// D78/D82 — also the *start node* of the project's DAG walk.
    public var domain: String
    /// D78 — transitive-closure walk over the domain graph, topologically
    /// sorted (foundation first, integration apex last). Computed at
    /// project creation from `domain` via `DomainGraph`. The project is
    /// a *pointer* over this walk; domains themselves stay in
    /// `DomainCatalog`. Optional + default `[]` for backward-compat
    /// with manifests created before D78.
    public var walk: [String]
    /// The verb the project is currently working on.
    public var currentVerb: Verb
    /// Raw values of verbs already completed (a measured ✅, g3).
    public var doneVerbs: Set<Int>
    public var createdAt: Date

    public init(
        id: UUID = UUID(),
        name: String,
        target: String,
        domain: String,
        walk: [String] = [],
        currentVerb: Verb = .specify,
        doneVerbs: Set<Int> = [],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.target = target
        self.domain = domain
        self.walk = walk
        self.currentVerb = currentVerb
        self.doneVerbs = doneVerbs
        self.createdAt = createdAt
    }

    /// Progress of a verb stage for the ① recipe rail.
    public func state(of verb: Verb) -> VerbState {
        if doneVerbs.contains(verb.rawValue) { return .done }
        if verb == currentVerb { return .current }
        if verb.rawValue < currentVerb.rawValue { return .visited }
        return .upcoming
    }

    /// Whether the verb pointer can step forward / back. The 7-verb
    /// spine is sequential, so advance/retreat move one stage only.
    public var canAdvance: Bool { currentVerb != .handoff }
    public var canRetreat: Bool { currentVerb != .specify }

    /// Step the verb pointer (conversation-default progress — D48).
    /// This moves the *pointer* only; it never marks a stage `.done`,
    /// which stays reserved for a measured θ-2 record (g3).
    public mutating func advance() {
        if let next = Verb(rawValue: currentVerb.rawValue + 1) {
            currentVerb = next
        }
    }

    public mutating func retreat() {
        if let prev = Verb(rawValue: currentVerb.rawValue - 1) {
            currentVerb = prev
        }
    }
}
