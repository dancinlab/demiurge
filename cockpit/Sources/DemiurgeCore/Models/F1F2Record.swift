// F1F2Record — Codable mirror of rfc_002 v1.0 schema (the chip:noc:F1F2 typed
// record produced by demiurge[chip] for downstream consumers).
//
// rfc_002 §3 (schema) + §4 (provenance / no-over-claim required fields).
// Forward-compat per rfc_002 §6 unknown-key idiom: this struct decodes only
// the fields the consumer renders; Swift Codable already ignores extra keys,
// so producer schema growth never breaks the cockpit.
//
// Phase α-3 (rfc_011 §10): moved into the DemiurgeCore library target so
// both CockpitApp (GUI) and DemiurgeCLI (headless) can share this single
// typed-interface model. All members are `public` so cross-module access
// works; the Codable synthesised init(from:) stays internal but that is
// fine — JSONDecoder.decode is invoked from inside DemiurgeCore
// (RecordLoader), and the consumer modules only read public properties.
//
// @D g_cockpit_isolation (a): this file decodes records read from
// ../exports/** only; it neither imports nor writes any producer-side state.

import Foundation

public struct F1F2Record: Codable, Identifiable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    public let topology: Topology
    public let traffic: String
    public let verdict: Verdict
    public let provenance: Provenance

    public var id: String { recordId }

    public struct Topology: Codable {
        public let kind: String
        public let degree: Int
        public let nodeCount: Int
        public let routing: String
    }

    public struct Verdict: Codable {
        public let f1: String
        public let f2: String
        public let rationale: String
    }

    /// rfc_002 §4 — the honesty-as-feature payload.
    /// The cockpit MUST render every field VERBATIM (rfc_009 §4); it never
    /// upgrades a claim. Missing -> the consumer renders a REJECTED card.
    public struct Provenance: Codable {
        public let absorbed: Bool
        public let measurementGate: MeasurementGate
        public let simEngine: String
        public let simCommitHash: String
        public let gateFailures: [String]
        public let consumerTarget: String
        public let atlasCiteBlock: String
        public let scopeCaveats: [String]
    }

    /// rfc_002 §4 measurement_gate enum.
    public enum MeasurementGate: String, Codable {
        case open               = "GATE_OPEN"
        case bPinnedMet         = "GATE_B_PINNED_MET"
        case closedMeasured     = "GATE_CLOSED_MEASURED"
        case failed             = "GATE_FAILED"

        /// Raw enum label (expert mode) — e.g. "GATE_CLOSED_MEASURED".
        public var displayLabel: String { rawValue }

        /// rfc_012 §4 plain-language wording (non-expert workbench).
        public var plainLabel: String {
            switch self {
            case .open:           return "아직 측정 안 됨"
            case .bPinnedMet:     return "일부만 측정됨"
            case .closedMeasured: return "측정으로 확인됨"
            case .failed:         return "측정 실패"
            }
        }

        /// rfc_012 §4 signal-light glyph.
        public var plainGlyph: String {
            switch self {
            case .open:           return "⏳"
            case .bPinnedMet:     return "🔶"
            case .closedMeasured: return "✅"
            case .failed:         return "❌"
            }
        }
    }
}
