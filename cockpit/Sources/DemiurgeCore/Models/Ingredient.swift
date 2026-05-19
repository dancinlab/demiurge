// Ingredient — the ② work-zone "ingredient shelf" options (rfc_012 §5).
//
// The shelf offers plain-language design options for the project's
// current domain + verb; the user picks, then "[냄비에 넣기]" feeds
// the selection into the next chat turn.
//
// Options are sourced from the §6 "Design options (workbench shelf)"
// section of domains/<domain>.md — the domain map is the SSOT
// (@D g_ssot_single_source). Domains without a map (chip = rfc_001..003,
// matter = D17 pointer) yield an empty shelf — honest, not faked.
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
    /// Option groups for a domain + verb, parsed from the §6 section
    /// of `domains/<domain>.md`. Empty = "no shelf ingredients for
    /// this step" (advance by conversation instead) — also the honest
    /// result for a domain that has no map (chip, matter).
    public static func groups(domain: String, verb: Verb) -> [IngredientGroup] {
        guard let lines = section6Lines(domain: domain) else { return [] }
        var result: [IngredientGroup] = []
        for line in lines {
            guard line.hasPrefix("- ") else { continue }
            let body = String(line.dropFirst(2))
            guard let colon = body.firstIndex(of: ":") else { continue }
            let lineVerb = body[..<colon].trimmingCharacters(in: .whitespaces)
            // §6 writes the verb short ("해석"); Verb.canonical is "해석⟲".
            guard verb.canonical.hasPrefix(lineVerb) else { continue }
            let rest = String(body[body.index(after: colon)...])
            for groupStr in rest.components(separatedBy: ";") {
                let parts = groupStr.components(separatedBy: "=")
                guard parts.count == 2 else { continue }
                let title = parts[0].trimmingCharacters(in: .whitespaces)
                let options = parts[1]
                    .components(separatedBy: "/")
                    .map { $0.trimmingCharacters(in: .whitespaces) }
                    .filter { !$0.isEmpty }
                if !title.isEmpty, !options.isEmpty {
                    result.append(IngredientGroup(title: title, options: options))
                }
            }
        }
        return result
    }

    /// Lines inside the "## 6. Design options" section of a domain map.
    private static func section6Lines(domain: String) -> [String]? {
        let url = ArtifactRegistry.projectRoot
            .appendingPathComponent("domains/\(domain).md")
            .standardizedFileURL
        guard let content = try? String(contentsOf: url, encoding: .utf8) else {
            return nil
        }
        var lines: [String] = []
        var inSection = false
        for line in content.components(separatedBy: "\n") {
            if line.hasPrefix("## ") {
                if inSection { break }
                inSection = line.contains("Design options")
                continue
            }
            if inSection { lines.append(line) }
        }
        return lines.isEmpty ? nil : lines
    }
}
