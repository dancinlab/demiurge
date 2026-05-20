// ProducerRegistry — minimal alternative-producer mechanism for cells
// that carry more than one substrate (decision: inbox/notes/
// cern_analyze_producer_alternative_decision_2026-05-20.md, Option C).
//
// Most cells map (verb, domain) → exactly one Producer via the
// hardcoded ActionDispatch switch. A small set of cells carry
// alternatives — e.g. cern+analyze has the legacy pylhe LHE-round-trip
// AND the Xsuite tracking substrate. ActionDispatch consults this
// registry FIRST; if the (verb, domain) pair is registered, the picked
// variant's `run` closure replaces the switch-case dispatch.
//
// Cells NOT in this registry continue through the switch unchanged —
// this is additive, not invasive. New cells join the registry only
// when they actually carry alternatives.

import Foundation

public struct ProducerVariant: Sendable {
    public let id: String
    public let displayName: String
    /// Run the producer and return a generic ActionResult.
    public let run: @Sendable () -> ActionResult

    public init(id: String, displayName: String,
                run: @Sendable @escaping () -> ActionResult) {
        self.id = id
        self.displayName = displayName
        self.run = run
    }
}

public struct ProducerEntry: Sendable {
    /// Variant ID used when no `--producer <name>` is given.
    public let defaultID: String
    public let variants: [String: ProducerVariant]

    public init(defaultID: String, variants: [String: ProducerVariant]) {
        self.defaultID = defaultID
        self.variants = variants
    }

    public func pick(_ requested: String?) -> ProducerVariant? {
        let id = requested ?? defaultID
        return variants[id]
    }
}

public struct ProducerCellKey: Hashable, Sendable {
    public let verb: Verb
    public let domain: String
    public init(verb: Verb, domain: String) {
        self.verb = verb
        self.domain = domain
    }
}

public enum ProducerRegistry {

    /// Cells that carry alternative producers. Keyed by (verb, domain);
    /// missing keys fall through to ActionDispatch's switch.
    public static let entries: [ProducerCellKey: ProducerEntry] = [
        // cern + analyze — pylhe LHE round-trip (legacy) vs Xsuite
        // 100-turn tracking (real physics, ROI 14 substrate κ-49).
        // Default = xsuite-tracking per user gate 2026-05-20.
        ProducerCellKey(verb: .analyze, domain: "cern"): ProducerEntry(
            defaultID: "xsuite-tracking",
            variants: [
                "xsuite-tracking": ProducerVariant(
                    id: "xsuite-tracking",
                    displayName: "Xsuite 100-turn FODO tracking (real physics)"
                ) {
                    let r = CernAnalyzeXsuiteProducer.runAnalyze()
                    return ActionResult(
                        text: r.text,
                        newRecordIDs: r.newRecordID.map { [$0] } ?? [],
                        usedEngineTool: true,
                        engineToolSucceeded: r.ok)
                },
                "pylhe": ProducerVariant(
                    id: "pylhe",
                    displayName: "pylhe LHE round-trip (legacy, synthetic)"
                ) {
                    let r = CernAnalyzeProducer.runAnalyze()
                    return ActionResult(
                        text: r.text,
                        newRecordIDs: r.newRecordID.map { [$0] } ?? [],
                        usedEngineTool: true,
                        engineToolSucceeded: r.ok)
                },
            ]),

        // G4 sibling-repo cells (κ-62) — ProducerRegistry now hosts
        // sibling-repo dispatch as a first-class variant pattern via
        // siblingRepoVariant. Adding a new sibling-cell is a single
        // dict line. D80 — these are TRANSITIONAL POINTERS, never an
        // ultimate endpoint; absorbed=true non-provisional still
        // requires the hexa-native parity port.

        // ufo + synthesize — hexa-ufo selftest dispatch (HEXA-Disc
        // 7-stage propulsion atlas).
        ProducerCellKey(verb: .synthesize, domain: "ufo"): ProducerEntry(
            defaultID: "hexa-ufo",
            variants: [
                "hexa-ufo": ProducerRegistry.siblingRepoVariant(
                    id: "hexa-ufo",
                    domainID: "ufo",
                    verb: "synthesize",
                    displayName: "hexa-ufo selftest (sibling repo)"),
            ]),

        // ufo + verify — 13 falsifier preregister state check.
        ProducerCellKey(verb: .verify, domain: "ufo"): ProducerEntry(
            defaultID: "hexa-ufo",
            variants: [
                "hexa-ufo": ProducerRegistry.siblingRepoVariant(
                    id: "hexa-ufo",
                    domainID: "ufo",
                    verb: "verify",
                    displayName: "hexa-ufo verify (13 falsifier state)"),
            ]),

        // aura + verify — F-AURA-{1..4} 15 sub-IDs state check
        // + G6 cascade if hexa-rtsc demoted.
        ProducerCellKey(verb: .verify, domain: "aura"): ProducerEntry(
            defaultID: "hexa-aura",
            variants: [
                "hexa-aura": ProducerRegistry.siblingRepoVariant(
                    id: "hexa-aura",
                    domainID: "aura",
                    verb: "verify",
                    displayName: "hexa-aura verify (F-AURA-{1..4} state)"),
            ]),
    ]

    /// Convenience predicate for CLI / cockpit — has this cell got
    /// alternative producers?
    public static func hasAlternatives(verb: Verb, domain: String) -> Bool {
        entries[ProducerCellKey(verb: verb, domain: domain)] != nil
    }
}
