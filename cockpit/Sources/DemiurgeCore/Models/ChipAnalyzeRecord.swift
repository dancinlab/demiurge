// ChipAnalyzeRecord — phase κ-35 (θ-2 / chip + analyze · D56).
//
// Typed sidecar for a `chip + analyze` producer run — captures the
// Leighton analytic lower bounds (bisection · diameter) that
// `stdlib/booksim/booksim.hexa::cmd_oracle` emits for the canonical
// 8×8 / n=64 reference topology (d4 mesh + d6 hex). The producer is
// the hexa-native booksim oracle dispatch (no external CLI), pinned
// by hexa-lang commit hash.
//
// HONESTY (g3 — non-negotiable) — see D56 rationale:
//   • The Leighton bound IS a mathematical fact (Leighton 1984 Thm 2,
//     DOI 10.1007/BF01744433; Bhatt-Leighton VLSI graph-layout
//     framework; Dally & Towles PPIN 2004 §3.2-3.3 closed forms),
//     so this cell legitimately closes `measurement_gate = GATE_
//     CLOSED_MEASURED` even though no NoC wire was actually clocked.
//     "측정" here = analytic verification of an algebraic lower bound,
//     and that verification IS what the oracle dispatch performs.
//   • `absorbed = true` is allowed BECAUSE the oracle is hexa-native
//     (`stdlib/booksim/leighton.hexa`); no external library or wire-
//     latency dataset is being absorbed — the math is owned by
//     hexa-lang. Mirrors the matter+analyze stance (D17): when
//     hexa-native code IS the producer, "absorbed" measures hexa-
//     lang's own claim and not an external substrate.
//   • scope_caveats MUST surface the gap between (a) an analytic
//     lower bound and (b) a real chip's wire latency. The record is
//     the FLOOR every measured F1F2 record must clear (rfc_001 §7.3
//     / §8) — NOT a substitute for cmd_measure's full-curve parity.

import Foundation

/// Provenance for a `ChipAnalyzeRecord` — mirrors MatterProvenance /
/// SSCBProvenance (same absorbed + measurementGate + caveats
/// discipline). producer points to the hexa-native booksim oracle.
public struct ChipAnalyzeProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "hexa_native_booksim_oracle@<commit>".
    /// Pins the algorithm + the hexa-lang commit it was dispatched from.
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let scopeCaveats: [String]

    public init(absorbed: Bool, producer: String,
                measurementGate: F1F2Record.MeasurementGate,
                scopeCaveats: [String]) {
        self.absorbed = absorbed
        self.producer = producer
        self.measurementGate = measurementGate
        self.scopeCaveats = scopeCaveats
    }

    enum CodingKeys: String, CodingKey {
        case absorbed
        case producer
        case measurementGate = "measurement_gate"
        case scopeCaveats = "scope_caveats"
    }
}

/// One topology's Leighton lower bounds (bisection + diameter) — the
/// 8×8 / n=64 reference (k_by_k for d4 mesh, hex_axial_r for d6 hex).
public struct ChipLeightonBounds: Codable, Equatable, Sendable {
    /// Topology label echoed verbatim from the oracle stdout:
    /// `"d4 mesh"` or `"d6 hex "` (booksim.hexa prints a trailing
    /// space for d6 — we trim it on parse).
    public let topology: String
    public let bisectionLower: Int
    public let diameterLower: Int

    enum CodingKeys: String, CodingKey {
        case topology
        case bisectionLower = "bisection_lower"
        case diameterLower = "diameter_lower"
    }
}

/// A chip-analyze record (D56 / κ-35). Captures `booksim oracle`
/// Leighton analytic bounds for the d4 mesh + d6 hex 8×8 reference.
/// `gate_closed_measured` IS legitimate here (analytic verification),
/// but the scope_caveats clarify the bound is mathematical — NOT a
/// substitute for cmd_measure's full-curve wire-latency parity.
public struct ChipAnalyzeRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    /// Reference n (nodes) — 64 for the canonical 8×8 self-test.
    public let nNodes: Int
    /// Per-topology Leighton bounds (d4 mesh + d6 hex on the same n).
    public let bounds: [ChipLeightonBounds]
    /// Derivation cite line echoed verbatim from oracle stdout —
    /// the rfc_001 §7.3 audit trail (Leighton 1984 + Dally & Towles).
    public let derivationCite: String
    /// Hexa runtime exit code (0 = oracle dispatch + selftest passed).
    public let exitCode: Int
    public let provenance: ChipAnalyzeProvenance

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                nNodes: Int, bounds: [ChipLeightonBounds],
                derivationCite: String, exitCode: Int,
                provenance: ChipAnalyzeProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.nNodes = nNodes
        self.bounds = bounds
        self.derivationCite = derivationCite
        self.exitCode = exitCode
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case nNodes = "n_nodes"
        case bounds
        case derivationCite = "derivation_cite"
        case exitCode = "exit_code"
        case provenance
    }
}
