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
    ///
    /// D85 + D86 — sibling-repo variants live in `domains/PRODUCERS.
    /// demi` (declarative SSOT), loaded at runtime by `ProducerLoader`
    /// and merged with the Swift-class variants below. Swift function
    /// references (e.g., the cern+analyze Xsuite / pylhe pair) are the
    /// documented `@D g_no_hardcoded_data` exception — they cannot be
    /// reflected from a `.demi` file at runtime, so they remain coded.
    public static let entries: [ProducerCellKey: ProducerEntry] = {
        // Tier 1 — Swift-class variants (D86 exception: Swift function
        // reference cannot be declarative).
        var swiftClassEntries: [ProducerCellKey: ProducerEntry] = [
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
        ]
        // Tier 2 — sibling-repo variants loaded from PRODUCERS.demi
        // (D85). One section per cell; ProducerLoader.project builds
        // the siblingRepoVariant.
        for (key, entry) in ProducerLoader.loadAll() {
            swiftClassEntries[key] = entry
        }
        return swiftClassEntries
    }()

    /// Convenience predicate for CLI / cockpit — has this cell got
    /// alternative producers?
    public static func hasAlternatives(verb: Verb, domain: String) -> Bool {
        entries[ProducerCellKey(verb: verb, domain: domain)] != nil
    }
}
