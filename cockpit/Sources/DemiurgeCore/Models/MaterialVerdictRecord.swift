// MaterialVerdictRecord — RTSC.md §8.7 Tier 4 (falsifier dispatch).
//
// Tier 4 is the *integrating* tier of the 4-tier expansion path
// (§8.7 Tier 1 sim · Tier 2 recipe · Tier 3 measurement → Tier 4
// dispatch). It does NOT run simulations or measurements — it
// consumes already-landed Tier 1 / 2 / 3 records and emits a single
// verdict-record per sample that scores the 6 falsifiers
// (F-RTSC-{1,2,3} + F-SC-{1,2,3}) defined in RTSC.md §8.4 +
// hexa-rtsc/verify/{calc_*,falsifier_check}.hexa.
//
// g3 honest stance (RTSC.md §8.7 → §8.8) — NON-NEGOTIABLE:
//   • Tier 4 NEVER flips absorbed=true. Even when aggregateVerdict =
//     PASSES-ALL, this record has `absorbed: false` — absorbed-promotion
//     requires a separate meta-cohort with cross-lab attestation, which
//     is not in this struct's scope.
//   • `replicatedByIndependentLabs` is *carried forward* from the input
//     Tier 2 SynthesisRecipeRecord, NEVER auto-incremented.
//   • Every FalsifierResult MUST have a non-empty `evidence` string
//     citing the specific input record line that drove the call.
//   • Missing input ⇒ SKIPPED-MISSING-INPUT (NEVER fabricated PASS).
//   • measurementGate stays GATE_OPEN — a dispatch verdict alone does
//     NOT close the measurement gate.
//
// Codable pattern mirrors HtsVerifyRecord / MeasurementRecord /
// SynthesisRecipeRecord — camelCase Swift surface + explicit
// CodingKeys → snake_case JSON wire form. Reuses F1F2Record.MeasurementGate
// (the SSOT for gate state across the cockpit).

import Foundation

public struct MaterialVerdictRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let sampleId: String
    public let inputRecords: InputTriple
    public let falsifierResults: [FalsifierResult]
    public let aggregateVerdict: String
    public let replicatedByIndependentLabs: Int
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let gateType: String?
    public let provisional: Bool?
    public let scopeCaveats: [String]
    public let citations: [String]

    /// The 3-tier record-id triple that this verdict consumed.
    /// `tier1SimRecordId` is the Tier 1 material_sim record (predicted
    /// Tc). `tier2RecipeRecordId` is the Tier 2 synthesis_recipe record
    /// (reproducibility / replicated lab count). `tier3MeasurementRecordIds`
    /// is the list of Tier 3 measurement records (R(T), Meissner, Jc,
    /// Hc2 …); any subset of §8.4's 9-test matrix may be present.
    public struct InputTriple: Codable, Equatable, Sendable {
        public let tier1SimRecordId: String?
        public let tier2RecipeRecordId: String?
        public let tier3MeasurementRecordIds: [String]

        public init(
            tier1SimRecordId: String?,
            tier2RecipeRecordId: String?,
            tier3MeasurementRecordIds: [String]
        ) {
            self.tier1SimRecordId = tier1SimRecordId
            self.tier2RecipeRecordId = tier2RecipeRecordId
            self.tier3MeasurementRecordIds = tier3MeasurementRecordIds
        }

        enum CodingKeys: String, CodingKey {
            case tier1SimRecordId = "tier1_sim_record_id"
            case tier2RecipeRecordId = "tier2_recipe_record_id"
            case tier3MeasurementRecordIds = "tier3_measurement_record_ids"
        }
    }

    /// One falsifier outcome. `id` is the canonical hexa-rtsc falsifier
    /// id (e.g. "F-SC-1-bcs-isotope"). `status` is one of:
    ///   "PASS" | "FAIL" | "INCONCLUSIVE" | "SKIPPED-MISSING-INPUT"
    /// `evidence` MUST cite the specific tier+record line that drove the
    /// call (g3: no empty evidence). `confidence` is a conservative
    /// 0.0–1.0 score; SKIPPED-MISSING-INPUT → 0.0; single-measurement
    /// PASS → ≤ 0.5; replicated PASS → up to 0.9 (never 1.0 because
    /// absorbed-promotion is outside this struct's scope).
    public struct FalsifierResult: Codable, Equatable, Sendable {
        public let id: String
        public let name: String
        public let status: String
        public let evidence: String
        public let confidence: Double

        public init(
            id: String,
            name: String,
            status: String,
            evidence: String,
            confidence: Double
        ) {
            self.id = id
            self.name = name
            self.status = status
            self.evidence = evidence
            self.confidence = confidence
        }
    }

    public init(
        domain: String = "material_verdict",
        verb: String = "dispatch",
        kind: String = "tier4_falsifier_dispatch",
        stamp: String,
        sampleId: String,
        inputRecords: InputTriple,
        falsifierResults: [FalsifierResult],
        aggregateVerdict: String,
        replicatedByIndependentLabs: Int,
        measurementGate: F1F2Record.MeasurementGate = .open,
        absorbed: Bool = false,
        gateType: String? = "tier4-falsifier-dispatch",
        provisional: Bool? = true,
        scopeCaveats: [String],
        citations: [String]
    ) {
        self.domain = domain
        self.verb = verb
        self.kind = kind
        self.stamp = stamp
        self.sampleId = sampleId
        self.inputRecords = inputRecords
        self.falsifierResults = falsifierResults
        self.aggregateVerdict = aggregateVerdict
        self.replicatedByIndependentLabs = replicatedByIndependentLabs
        self.measurementGate = measurementGate
        self.absorbed = absorbed
        self.gateType = gateType
        self.provisional = provisional
        self.scopeCaveats = scopeCaveats
        self.citations = citations
    }

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp
        case sampleId = "sample_id"
        case inputRecords = "input_records"
        case falsifierResults = "falsifier_results"
        case aggregateVerdict = "aggregate_verdict"
        case replicatedByIndependentLabs = "replicated_by_independent_labs"
        case measurementGate = "measurement_gate"
        case absorbed
        case gateType = "gate_type"
        case provisional
        case scopeCaveats = "scope_caveats"
        case citations
    }
}
