// Ingredient — the ② work-zone "ingredient shelf" options (rfc_012 §5).
//
// The shelf offers plain-language design options for the project's
// current domain + verb; the user picks, then "[냄비에 넣기]" feeds
// the selection into the next chat turn.
//
// Phase κ-3 carries a STUB option table — a handful of domains/verbs.
// The real per-domain option sets are sourced from the domain maps
// (domains/**) in a later phase; κ-3 builds the pick → pot mechanism.
//
// DemiurgeCore stays pure Foundation (Package.swift contract).

import Foundation

/// One group of mutually-exclusive options on the shelf (pick one).
public struct IngredientGroup: Identifiable, Sendable {
    /// Stable across re-renders — the title is unique within a verb.
    public var id: String { title }
    public let title: String
    public let options: [String]

    public init(title: String, options: [String]) {
        self.title = title
        self.options = options
    }
}

public enum IngredientShelf {
    /// Option groups for a given domain + verb. Empty = "no shelf
    /// ingredients for this step — advance by conversation instead."
    public static func groups(domain: String, verb: Verb) -> [IngredientGroup] {
        var groups: [IngredientGroup] = []

        // Generic — every domain, the SPECIFY verb: what matters most.
        if verb == .specify {
            groups.append(IngredientGroup(
                title: "가장 중요한 것",
                options: ["속도", "비용", "전력 효율", "신뢰성"]))
        }

        switch (domain, verb) {
        case ("chip", .structure):
            groups.append(IngredientGroup(
                title: "토폴로지", options: ["mesh", "torus", "hex"]))
            groups.append(IngredientGroup(
                title: "공정 노드", options: ["22nm", "7nm", "3nm"]))
        case ("chip", .design):
            groups.append(IngredientGroup(
                title: "최적화 목표", options: ["면적 최소", "지연 최소", "전력 최소"]))
        case ("component", .structure):
            groups.append(IngredientGroup(
                title: "냉각 방식", options: ["수동 방열", "팬", "수냉"]))
        case ("component", .design):
            groups.append(IngredientGroup(
                title: "재질", options: ["알루미늄", "구리", "복합소재"]))
        case ("energy", .structure):
            groups.append(IngredientGroup(
                title: "에너지원", options: ["태양광", "배터리", "하이브리드"]))
        default:
            break
        }

        return groups
    }
}
