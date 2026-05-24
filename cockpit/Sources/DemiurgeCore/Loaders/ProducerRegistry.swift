// ProducerRegistry — minimal alternative-producer mechanism for cells
// that carry more than one substrate (decision: archive/session-notes/
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

        // Tier 3 — post-merge overrides that WRAP a Tier 2 sibling-repo
        // variant with a Swift-side fallback. The wrapping preserves
        // the sibling-repo dispatch as the primary path; only when the
        // spawn returns exit != 0 does the fallback fire.
        //
        // aura+verify: the cycle-4 gap-bridges agent landed an
        // anima-physics bridge record at
        // `exports/aura/verify/<UTC>Z/anima_aura_*.json`, but the
        // sibling-repo dispatch (`~/core/hexa-aura/verify/run_all.hexa`)
        // never cited it — bypass reported in cycle-5 (2026-05-21).
        // This override wraps the sibling spawn with
        // `AuraVerifyProducer.verifyFromExports()` so that a sibling
        // failure (or missing repo) falls back to citing the anima
        // record. The sibling-repo dispatch pattern is preserved (G3 /
        // ARCH.md §11.4) — fallback only on exit != 0.
        let auraKey = ProducerCellKey(verb: .verify, domain: "aura")
        if let auraEntry = swiftClassEntries[auraKey] {
            let originalVariants = auraEntry.variants
            var wrappedVariants: [String: ProducerVariant] = [:]
            for (vid, variant) in originalVariants {
                let innerRun = variant.run
                wrappedVariants[vid] = ProducerVariant(
                    id: variant.id,
                    displayName: variant.displayName
                ) {
                    let primary = innerRun()
                    if primary.engineToolSucceeded == true {
                        return primary
                    }
                    // sibling-repo dispatch failed → anima record fallback.
                    let fb = AuraVerifyProducer.verifyFromExports()
                    let combined = primary.text + "\n---\n" + fb.text
                    return ActionResult(
                        text: combined,
                        newRecordIDs: primary.newRecordIDs
                            + fb.newRecordIDs,
                        usedEngineTool: true,
                        engineToolSucceeded: fb.engineToolSucceeded)
                }
            }
            swiftClassEntries[auraKey] = ProducerEntry(
                defaultID: auraEntry.defaultID,
                variants: wrappedVariants)
        }

        return swiftClassEntries
    }()

    /// Convenience predicate for CLI / cockpit — has this cell got
    /// alternative producers?
    public static func hasAlternatives(verb: Verb, domain: String) -> Bool {
        entries[ProducerCellKey(verb: verb, domain: domain)] != nil
    }
}
