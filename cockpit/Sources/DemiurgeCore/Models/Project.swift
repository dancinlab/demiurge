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

/// The 7-verb spine (GOAL.md · design.md D5). `canonical` is the
/// engineering term; `plain` is the rfc_012 §4 non-expert wording.
public enum Verb: Int, CaseIterable, Codable, Identifiable, Sendable {
    case specify, structure, design, analyze, synthesize, verify, handoff

    public var id: Int { rawValue }

    /// Engineering term (expert mode).
    public var canonical: String {
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
}

/// A verb stage's progress relative to the project's current verb.
public enum VerbState: String, Codable, Sendable {
    case done, current, upcoming
}

/// A user-created workbench project (rfc_012 §2).
public struct Project: Codable, Identifiable, Sendable {
    public var id: UUID
    /// User-typed project name (e.g. "우리 회사 칩").
    public var name: String
    /// Free-text "무엇을 만들고 싶으세요" answer (rfc_012 §3, D44).
    public var target: String
    /// Domain inferred from `target`, then user-confirmed (D44).
    public var domain: String
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
        currentVerb: Verb = .specify,
        doneVerbs: Set<Int> = [],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.target = target
        self.domain = domain
        self.currentVerb = currentVerb
        self.doneVerbs = doneVerbs
        self.createdAt = createdAt
    }

    /// Progress of a verb stage for the ① recipe rail.
    public func state(of verb: Verb) -> VerbState {
        if doneVerbs.contains(verb.rawValue) { return .done }
        if verb == currentVerb { return .current }
        return .upcoming
    }
}

/// Phase-κ-1 STUB domain inference (rfc_012 §3, D44 option C).
///
/// The user types a free-text goal; this maps it to one of demiurge's
/// domains by keyword. This is a deterministic placeholder — the real
/// AI inference (a Claude Code call) lands with the θ chat-agent path;
/// either way the user still ratifies via the [네 / 바꾸기] confirm
/// step, so the human stays the authority (g3, rfc_012 §3 note).
public enum DomainInference {
    private static let table: [(keys: [String], domain: String)] = [
        (["칩", "반도체", "chip", "soc", "asic", "프로세서", "cpu", "gpu", "noc"], "chip"),
        (["부품", "component", "기구", "케이스", "enclosure", "냉각", "heatsink", "방열"], "component"),
        (["물질", "재료", "material", "합금", "분자", "matter", "소재"], "matter"),
        (["에너지", "배터리", "energy", "태양", "solar", "전력", "발전"], "energy"),
        (["우주", "위성", "space", "로켓", "궤도", "satellite"], "space"),
        (["뇌", "brain", "신경", "neuro", "인지"], "brain"),
        (["가속기", "cern", "입자", "antimatter", "반물질"], "cern"),
    ]

    /// Best-effort domain key for a free-text target; "general" when
    /// nothing matches (the confirm step lets the user correct it).
    public static func infer(from target: String) -> String {
        let t = target.lowercased()
        for row in table where row.keys.contains(where: { t.contains($0) }) {
            return row.domain
        }
        return "general"
    }
}
