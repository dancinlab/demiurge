// AuraVerifyRecord — typed Codable for `aura + verify` cell.
//
// G5 (ARCH.md §11.4) — F-AURA-{1..4} (15 sub-IDs) preregistered
// falsifiers carry typed status. G6 cascade rule: if hexa-rtsc's
// F-RTSC-* flips to DEMOTED, F-AURA-2 auto-DEMOTED (hexa-aura
// README §[!NOTE]). FalsifierEntry.demotedIf field carries that
// dependency.

import Foundation

public struct AuraVerifyRecord: Codable, Sendable, Equatable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    /// Cell-level absorbed flag (LEGACY / measured-oracle dimension —
    /// distinct from `isHexaNativeAbsorbed` below). Producer policy
    /// (D103): a substrate-parity PASS on the linked `hexaNativeParity`
    /// kernel MUST NOT auto-flip this to `true`. Cell-level absorbed
    /// requires a measured oracle for THIS cell's outputs (per-cell
    /// parity round), not substrate kernel parity (D80 honesty floor +
    /// RFC 013 §4.3 substrate-parity ≠ measurement-parity).
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    /// G5 — F-AURA-{1..4} 15 sub-IDs + G6 cascade demotedIf.
    public let falsifiers: [FalsifierEntry]?
    /// D80 — hexa-native parity port pointer (nil = provisional).
    public let hexaNativeParity: HexaNativeParityRef?
    /// Lattice invariant audit (G8) — σ·φ = n·τ = J₂ = 24 check.
    public let latticeInvariant: LatticeInvariantResult?
    public let skippedReason: String?
    /// D115 (κ-69 G32 cell-pick · D109 mirror) · D117 (κ-69 G33 first-
    /// flip) · RFC 013 §6.11 — external measured-oracle reference.
    /// Aura/EEG is the κ-69 second cell measured-oracle target
    /// (PhysioNet Sleep-EDF Expanded alpha-band PSD vs hexa-native
    /// `dft_naive.hexa` alpha-band PSD). Independent axis from
    /// `hexaNativeParity` above (D103 dimension-separation). `nil`
    /// until the per-cell measured-oracle round runs; populated by the
    /// producer adapter at emit time. The cell's stored `absorbed`
    /// flip remains a SEPARATE explicit writer action — emitting
    /// `measuredOracle` non-nil does NOT by itself trigger
    /// `absorbed = true` (D117 mirror of D110 / G29 land scope).
    public let measuredOracle: MeasuredOracleRef?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case falsifiers
        case hexaNativeParity = "hexa_native_parity"
        case latticeInvariant = "lattice_invariant"
        case skippedReason = "skipped_reason"
        case measuredOracle = "measured_oracle"
    }

    /// D95 — derived absorbed flag (computed, NOT stored).
    /// Reflects `hexaNativeParity?.isHexaNativeAbsorbed`; SSOT is
    /// `domains/PILOTS.demi → parity_status` (D86 / D90).
    ///
    /// D103 dimension separation — see `HexaNativeParityRef` (Ufo
    /// VerifyRecord.swift) header for the two-axis policy. This is the
    /// substrate-parity dimension; `absorbed` above is the measured
    /// dimension. Producers set them independently.
    public var isHexaNativeAbsorbed: Bool {
        return hexaNativeParity?.isHexaNativeAbsorbed ?? false
    }
}

/// G8 — n=6 lattice invariant audit result. hexa-aura / hexa-ufo /
/// hexa-cern share the `σ·φ = n·τ = J₂ = 24` invariant; verify cells
/// emit this audit so cross-domain consistency is machine-checkable.
public struct LatticeInvariantResult: Codable, Sendable, Equatable {
    public let n: Int
    public let sigmaPhi: Int
    public let nTau: Int
    public let jTwo: Int
    public let passed: Bool
    public let note: String?

    public init(n: Int, sigmaPhi: Int, nTau: Int, jTwo: Int,
                passed: Bool, note: String? = nil) {
        self.n = n
        self.sigmaPhi = sigmaPhi
        self.nTau = nTau
        self.jTwo = jTwo
        self.passed = passed
        self.note = note
    }

    enum CodingKeys: String, CodingKey {
        case n
        case sigmaPhi = "sigma_phi"
        case nTau = "n_tau"
        case jTwo = "j_two"
        case passed
        case note
    }
}
