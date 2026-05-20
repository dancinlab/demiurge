// LatticeInvariant — G8 audit engine for the HEXA-family n=6 lattice.
//
// hexa-ufo / hexa-aura / hexa-cern / hexa-rtsc / hexa-bio / hexa-chip
// all share the invariant `σ · φ = n · τ = J₂ = 24` (n=6 substrate
// uniqueness, Π₀¹-arithmetical → Δ₀-absolute). When a HEXA-family
// substrate reports its lattice numbers, this helper verifies them.
//
// G8 (ARCH.md §11.4) — the engine doesn't compute σ / φ / τ / J₂
// itself; it accepts what the substrate reports and checks that the
// arithmetic identity holds. Substrate-level lattice DERIVATION is
// the sibling repo's job.

import Foundation

public enum LatticeInvariant {
    /// HEXA-family canonical lattice (n=6).
    public static let canonicalN: Int = 6
    /// `σ · φ = n · τ = J₂ = 24`.
    public static let canonicalProduct: Int = 24

    /// Audit a reported lattice tuple. Returns nil if the reported
    /// values satisfy `n == canonicalN AND σ·φ == n·τ == J₂ ==
    /// canonicalProduct`; otherwise a typed violation description.
    public static func audit(n: Int,
                              sigma: Int, phi: Int,
                              tau: Int, jTwo: Int) -> InvariantViolation? {
        var failures: [String] = []
        if n != canonicalN {
            failures.append("n = \(n) ≠ canonical \(canonicalN)")
        }
        if sigma * phi != canonicalProduct {
            failures.append("σ·φ = \(sigma * phi) ≠ \(canonicalProduct)")
        }
        if n * tau != canonicalProduct {
            failures.append("n·τ = \(n * tau) ≠ \(canonicalProduct)")
        }
        if jTwo != canonicalProduct {
            failures.append("J₂ = \(jTwo) ≠ \(canonicalProduct)")
        }
        guard !failures.isEmpty else { return nil }
        return InvariantViolation(
            n: n, sigma: sigma, phi: phi, tau: tau, jTwo: jTwo,
            failures: failures)
    }

    /// Audit a `LatticeInvariantResult` (already-decoded record
    /// field). Returns the same nil-pass / non-nil-violation shape.
    public static func audit(_ r: LatticeInvariantResult)
        -> InvariantViolation? {
        var failures: [String] = []
        if r.n != canonicalN {
            failures.append("n = \(r.n) ≠ canonical \(canonicalN)")
        }
        if r.sigmaPhi != canonicalProduct {
            failures.append("σ·φ = \(r.sigmaPhi) ≠ \(canonicalProduct)")
        }
        if r.nTau != canonicalProduct {
            failures.append("n·τ = \(r.nTau) ≠ \(canonicalProduct)")
        }
        if r.jTwo != canonicalProduct {
            failures.append("J₂ = \(r.jTwo) ≠ \(canonicalProduct)")
        }
        guard !failures.isEmpty else { return nil }
        return InvariantViolation(
            n: r.n, sigma: 0, phi: 0, tau: 0, jTwo: r.jTwo,
            failures: failures)
    }
}

public struct InvariantViolation: Sendable, Equatable, CustomStringConvertible {
    public let n: Int
    public let sigma: Int
    public let phi: Int
    public let tau: Int
    public let jTwo: Int
    public let failures: [String]

    public var description: String {
        "LatticeInvariant violation — " + failures.joined(separator: "; ")
    }
}
