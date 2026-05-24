// MaterialAttestationRecord — constitution.md v1.4.0 R4 Stage 1 carrier.
//
// Combined record type for any future material attestation (RTSC, LTS,
// HTS, Hydride …). The Stage 1 enforcement vehicle for R4
// (RTSC absorbed=true twin-error invariant) — Pattern 1 (namespace
// exploit) doctrinal lock at the Swift Codable layer.
//
// R4 invariant (constitution.md §R4 + RTSC.md §8.9) — enforced by
// `init(from:)`:
//   If `domain == "rtsc"` AND `absorbed == true`:
//     (i)  `rtsc_5_gate_evaluation` MUST be non-nil; null → reject.
//     (ii) `rtsc_5_gate_evaluation.aggregate` MUST be `.allPass`
//          (5/5 PASS); anything else → reject.
//     (iii) `rtsc_5_gate_evaluation.rtsc_absorbed_eligible` MUST be
//          true when aggregate is .allPass (producer-intent
//          cross-check).
//
// Honest narrative: this record TYPE is the carrier for *future*
// RTSC attestations. Existing `nb_bcs_v1` JSON (Nb LTS attestation
// emitted before R4 ratification · 2026-05-21) will FAIL this
// invariant when decoded by this type — that is by design
// (see RTSCTSC5GateEnforcementTests · testNbAttestation…). Migration
// path: see `archive/session-notes/2026-05-21-r4-stage1-enforcement.md`.
//
// Cross-refs:
//   - constitution.md R4 + R1 (Measured-Oracle Invariant precursor)
//   - RTSC.md §8.9 (5-criteria gate) · §8.10 (Nb correction)
//   - RTSC5GateEvaluation.swift (5-gate struct + Aggregate enum)
//   - MeasurementRecord.swift / MaterialVerdictRecord.swift (existing
//     Codable pattern reference)

import Foundation

public struct MaterialAttestationRecord: Codable, Equatable, Sendable {

    // MARK: Standard envelope (mirror of existing record types)

    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String

    /// Measured-oracle / falsifier gate state (F1F2Record SSOT enum).
    public let measurementGate: F1F2Record.MeasurementGate

    /// Cell-level absorbed flag. For `domain == "rtsc"` the R4
    /// invariant requires absorbed=true → 5-gate ALL_PASS.
    public let absorbed: Bool

    public let gateType: String?
    public let provisional: Bool?

    // MARK: R4 Stage 1 — 5-gate evaluation field (Optional)

    /// RTSC.md §8.9 5-criteria gate evaluation. Optional → existing
    /// non-rtsc records (e.g. energy / solar pyranometer) need not
    /// carry it. Required when `domain == "rtsc"` AND `absorbed ==
    /// true` (R4 Stage 1 invariant assertion in `init(from:)`).
    public let rtsc_5_gate_evaluation: RTSC5GateEvaluation?

    // MARK: Provenance + caveats

    public let scopeCaveats: [String]
    public let citations: [String]

    public init(
        domain: String,
        verb: String,
        kind: String,
        stamp: String,
        producer: String,
        measurementGate: F1F2Record.MeasurementGate,
        absorbed: Bool,
        gateType: String? = nil,
        provisional: Bool? = nil,
        rtsc_5_gate_evaluation: RTSC5GateEvaluation? = nil,
        scopeCaveats: [String] = [],
        citations: [String] = []
    ) {
        self.domain = domain
        self.verb = verb
        self.kind = kind
        self.stamp = stamp
        self.producer = producer
        self.measurementGate = measurementGate
        self.absorbed = absorbed
        self.gateType = gateType
        self.provisional = provisional
        self.rtsc_5_gate_evaluation = rtsc_5_gate_evaluation
        self.scopeCaveats = scopeCaveats
        self.citations = citations
    }

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case gateType = "gate_type"
        case provisional
        case rtsc_5_gate_evaluation = "rtsc_5_gate_evaluation"
        case scopeCaveats = "scope_caveats"
        case citations
    }

    // MARK: R4 invariant enforcement (Stage 1)

    /// Custom decoder — enforces R4 (RTSC absorbed=true twin-error
    /// invariant) at decode time. Records emitted before R4
    /// ratification (e.g. nb_bcs_v1 Nb LTS attestation) that have
    /// `domain == "rtsc"` AND `absorbed == true` but lack a 5-gate
    /// ALL_PASS evaluation → throws `DecodingError.dataCorrupted` with
    /// a load-bearing rationale string.
    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.domain = try c.decode(String.self, forKey: .domain)
        self.verb = try c.decode(String.self, forKey: .verb)
        self.kind = try c.decode(String.self, forKey: .kind)
        self.stamp = try c.decode(String.self, forKey: .stamp)
        self.producer = try c.decode(String.self, forKey: .producer)
        self.measurementGate = try c.decode(
            F1F2Record.MeasurementGate.self, forKey: .measurementGate)
        self.absorbed = try c.decode(Bool.self, forKey: .absorbed)
        self.gateType = try c.decodeIfPresent(String.self, forKey: .gateType)
        self.provisional = try c.decodeIfPresent(Bool.self, forKey: .provisional)
        self.rtsc_5_gate_evaluation = try c.decodeIfPresent(
            RTSC5GateEvaluation.self, forKey: .rtsc_5_gate_evaluation)
        self.scopeCaveats = try c.decodeIfPresent(
            [String].self, forKey: .scopeCaveats) ?? []
        self.citations = try c.decodeIfPresent(
            [String].self, forKey: .citations) ?? []

        // R4 Stage 1 invariant — namespace-exploit lock.
        if domain == "rtsc" && absorbed == true {
            guard let gate = rtsc_5_gate_evaluation else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "R4 invariant violation: domain=rtsc + absorbed=true requires rtsc_5_gate_evaluation field (RTSC.md §8.9 5-criteria gate). Null → claim REJECTED. See constitution.md R4."
                    )
                )
            }
            guard gate.aggregate == .allPass else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "R4 invariant violation: domain=rtsc + absorbed=true requires rtsc_5_gate_evaluation.aggregate == ALL_PASS; got \(gate.aggregate.rawValue). RTSC.md §8.9 (a)-(e) AND only. See constitution.md R4."
                    )
                )
            }
            guard gate.rtsc_absorbed_eligible == true else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "R4 invariant violation: aggregate=ALL_PASS but rtsc_absorbed_eligible=false (producer-intent mismatch). See constitution.md R4."
                    )
                )
            }
        }
    }
}
