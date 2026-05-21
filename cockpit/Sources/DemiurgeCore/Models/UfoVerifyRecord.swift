// UfoVerifyRecord — typed Codable for `ufo + verify` cell.
//
// G5 (ARCH.md §11.4) — preregistered falsifiers are typed array, not
// loose CSV. hexa-ufo v1.0.0 ships 13 OPEN falsifiers (F-WARP-{1..3}
// + F-WORM-{1..3} + F-DIM-{1..3} + F-USE-{1..4}); a verify run reports
// each entry's monotone status (OPEN / CONFIRMED / DEMOTED).
//
// D80 honesty: ufo+verify cannot flip `absorbed=true` until every
// Stage-4-7 falsifier has CONFIRMED evidence (currently 0/13). The
// substrate emits this record as a state snapshot, not as a parity
// closure.

import Foundation

public struct UfoVerifyRecord: Codable, Sendable, Equatable {
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
    /// G5 — 13 preregistered falsifiers (F-WARP/WORM/DIM/USE).
    public let falsifiers: [FalsifierEntry]?
    /// D80 — link to the hexa-native parity port path, when one
    /// exists (nil otherwise, signaling provisional=true if
    /// absorbed is set).
    public let hexaNativeParity: HexaNativeParityRef?
    public let alienIndex: String?
    public let skippedReason: String?
    /// D118 (κ-70 G36 cell-pick · D109 / D115 mirror) · D119 (κ-70
    /// G37 first-flip · D110 / D117 mirror) · RFC 013 §6.11 —
    /// external measured-oracle reference.
    /// Ufo Stage-2 sister-substrate fusion plasma diagnostic is the
    /// κ-70 third cell measured-oracle target (JET open-pulse
    /// archive mid-Ohmic single shot · Debye-length λ_D vs hexa-
    /// native `plasma_metrics_kernel::lambda_d`). Independent axis
    /// from `hexaNativeParity` above (D103 dimension-separation).
    /// `nil` until the per-cell measured-oracle round runs;
    /// populated by the producer adapter at emit time. The cell's
    /// stored `absorbed` flip remains a SEPARATE explicit writer
    /// action — emitting `measuredOracle` non-nil does NOT by
    /// itself trigger `absorbed = true` (D119 mirror of D110 / D117
    /// first-flip scope).
    ///
    /// D106 carve-out (D118 g3 invariant): this `measuredOracle`
    /// field applies ONLY to the Ufo Stage-2 sister-substrate
    /// fusion plasma diagnostic axis. Stage-4..7 (warp / wormhole /
    /// dim / use) cells remain D106 illustrative-physics — producers
    /// for those axes MUST keep `measuredOracle = nil` and rely on
    /// the `isIllustrativePhysics` exemption branch of the G30
    /// invariant. The `scopeCaveats` array carries the carve-out as
    /// a mandatory entry whenever `absorbed = true` is emitted on a
    /// Stage-2 record (κ-70 G37 cross-link gate).
    public let measuredOracle: MeasuredOracleRef?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case falsifiers
        case hexaNativeParity = "hexa_native_parity"
        case alienIndex = "alien_index"
        case skippedReason = "skipped_reason"
        case measuredOracle = "measured_oracle"
    }

    /// D95 — derived absorbed flag (computed, NOT stored).
    /// Reflects `hexaNativeParity?.isHexaNativeAbsorbed`; SSOT is
    /// `domains/PILOTS.demi → parity_status` (D86 / D90).
    ///
    /// D103 dimension separation — this is the HEXA-NATIVE-PORT
    /// dimension (substrate kernel parity), NOT the cell-level measured
    /// dimension. UI MUST NOT conflate the two: D99 chip renders
    /// `.provisional` (yellow) when this is `true` AND
    /// `absorbed == false`, and only `.absorbed` (green) when the
    /// cell's stored `absorbed` itself is `true` from a measured oracle.
    public var isHexaNativeAbsorbed: Bool {
        return hexaNativeParity?.isHexaNativeAbsorbed ?? false
    }
}

/// D80 — pointer to the hexa-native kernel that proves parity for a
/// record. When emitted absorbed=true, this MUST be non-nil; otherwise
/// the record is `provisional` (D80 g_hexa_only).
///
/// Schema follows the connection-plan §4.1 shape
/// (`inbox/notes/hexa-native-connection-plan-2026-05-20.md`). The
/// fields below preserve the original `(ref / relErr / tolerance)`
/// trio under new names (kernelPath / relErr / parityTolerance) and
/// add the parity-method / status / hexa-lang SHA / scope-notes
/// envelope so a downstream loader can recover the full audit trail
/// without scraping the cell's free-text caveats.
///
/// Honesty (D80 g_hexa_only): emitting this struct does NOT flip
/// `absorbed` by itself — the cell-side absorbed gate stays capped
/// at provisional until the kernel's parity test runs green AND
/// the demiurge cell consumes the kernel (not just points at it).
///
/// D103 dimension separation — TWO orthogonal axes:
///   1. Cell-level measured absorbed (`<Record>.absorbed: Bool`,
///      stored) — flips on a measured oracle for the cell's own
///      outputs. Producer trigger = per-cell measurement round.
///   2. Substrate kernel parity (this struct's `isHexaNativeAbsorbed`,
///      computed from `parityStatus`) — flips on the hexa-native port
///      passing parity vs the transitional substrate. Producer trigger
///      = PILOTS.demi row with PASS-shaped `parity_status` (D86 / D90).
/// Producers (RFC 013 §6.1) MUST set these two axes INDEPENDENTLY.
/// Conflation would let a substrate-parity PASS silently flip the
/// measured dimension — exactly what NEXT_SESSIONS P-⑩ g3 forbids.
public struct HexaNativeParityRef: Codable, Sendable, Equatable {

    /// How the parity claim was established.
    ///
    /// - `.substrateToSubstrate` — both `.hexa` and `.py` implement
    ///   the same closed-form algebra; parity = "did the port
    ///   re-implement the same arithmetic correctly?" (e.g. solar
    ///   Hughes 1985 + Haurwitz 1945).
    /// - `.analyticOracle` — closed-form analytic oracle
    ///   (Beer-Lambert, analytic spectra) compared against the hexa
    ///   kernel.
    /// - `.pythonCompanionSeedMatch` — stochastic kernel parity via
    ///   same-RNG-seed bit-identical companion (mc_slab_demo).
    /// - `.roundtripIdentity` — `idft∘dft == I` style identity test.
    /// - `.heapqOracleExact` — python `heapq` event-for-event for
    ///   event schedulers (event_queue).
    /// - `.handMirroredPython` — hand-mirrored arithmetic; not
    ///   closed-form, but every line matches the python by
    ///   inspection.
    /// - `.other` — escape hatch; caller uses `scopeNotes` to
    ///   describe.
    public enum ParityMethod: String, Codable, Sendable, Equatable {
        case substrateToSubstrate     = "substrate_to_substrate"
        case analyticOracle           = "analytic_oracle"
        case pythonCompanionSeedMatch = "python_companion_seed_match"
        case roundtripIdentity        = "roundtrip_identity"
        case heapqOracleExact         = "heapq_oracle_exact"
        case handMirroredPython       = "hand_mirrored_python"
        case other                    = "other"
    }

    /// Repo path (hexa-lang-relative) of the hexa-native kernel,
    /// e.g. `"stdlib/kernels/solar/solar_kernel.hexa"`.
    public let kernelPath: String
    /// Repo path of the parity test, e.g.
    /// `"stdlib/kernels/solar/solar_kernel_test.hexa"`.
    public let parityTest: String
    /// Which kind of parity claim this ref is asserting.
    public let parityMethod: ParityMethod
    /// Numeric tolerance for parity acceptance (relative error).
    /// `nil` when the oracle is event-exact / integer-exact and the
    /// caller sets `parityToleranceNote` instead.
    public let parityTolerance: Double?
    /// Free-text caveat for non-numeric tolerances ("exact (integer
    /// outputs)", "event-for-event match"). `nil` when
    /// `parityTolerance` is numeric.
    public let parityToleranceNote: String?
    /// Pass status snapshot, e.g. `"21/21 PASS rel_err<=1e-13"`.
    public let parityStatus: String
    /// hexa-lang `origin/main` SHA at the time this ref was emitted
    /// (full 40-char or short — caller pins).
    public let hexaLangSHA: String
    /// One-line scope caveat — what the kernel does and does NOT
    /// cover. Required (D80 honesty floor).
    public let scopeNotes: String
    /// Observed relative error vs the transitional substrate, when
    /// the parity claim has a numeric error to report. `nil` when
    /// `parityMethod` is non-numeric (e.g. `.heapqOracleExact`).
    public let relErr: Double?

    public init(kernelPath: String,
                parityTest: String,
                parityMethod: ParityMethod,
                parityTolerance: Double?,
                parityToleranceNote: String?,
                parityStatus: String,
                hexaLangSHA: String,
                scopeNotes: String,
                relErr: Double?) {
        self.kernelPath          = kernelPath
        self.parityTest          = parityTest
        self.parityMethod        = parityMethod
        self.parityTolerance     = parityTolerance
        self.parityToleranceNote = parityToleranceNote
        self.parityStatus        = parityStatus
        self.hexaLangSHA         = hexaLangSHA
        self.scopeNotes          = scopeNotes
        self.relErr              = relErr
    }

    enum CodingKeys: String, CodingKey {
        case kernelPath          = "kernel_path"
        case parityTest          = "parity_test"
        case parityMethod        = "parity_method"
        case parityTolerance     = "parity_tolerance"
        case parityToleranceNote = "parity_tolerance_note"
        case parityStatus        = "parity_status"
        case hexaLangSHA         = "hexa_lang_sha"
        case scopeNotes          = "scope_notes"
        case relErr              = "rel_err"
    }

    /// D95 — derived absorbed flag (computed, NOT stored).
    ///
    /// SSOT for "did this kernel's hexa-native port pass parity?" is
    /// `domains/PILOTS.demi → parity_status` (D86 / D90). This Swift
    /// flag is a strict projection of that string — a stored boolean
    /// would duplicate the truth and violate D86 `g_no_hardcoded_data`.
    ///
    /// Conservative predicate (matches every PASS phrasing observed
    /// in the 10 seeded rows — `"21/21 PASS at rel_err <=1e-13"`,
    /// `"PASS (concurrent branch, ...)"`, `"36/36 PASS exact"`,
    /// `"41/41 PASS at rel_err = 0.0"`):
    ///
    ///   * `parityStatus` contains the token `PASS` (case-sensitive
    ///     — PILOTS.demi 의 convention 은 ALLCAPS), AND
    ///   * `parityStatus` contains no `FAIL` / `SKIP` / `ERROR`
    ///     marker, AND
    ///   * the leading `<num>/<den>` pair (when present) is `num
    ///     == den` (full PASS, not partial).
    ///
    /// All other shapes (nil-like inputs are unrepresentable — the
    /// record-side computed uses `?? false`) collapse to `false`,
    /// honoring D80 g3 honesty floor.
    public var isHexaNativeAbsorbed: Bool {
        return HexaNativeParityRef.isPassStatus(parityStatus)
    }

    /// D95 — pure predicate over a `parity_status` string. Exposed
    /// `static` so tests can exercise it without constructing a full
    /// `HexaNativeParityRef`.
    public static func isPassStatus(_ status: String) -> Bool {
        let s = status.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !s.isEmpty else { return false }
        // Must contain the PASS token (ALLCAPS — PILOTS.demi
        // convention).
        guard s.contains("PASS") else { return false }
        // Negative markers veto.
        if s.contains("FAIL") { return false }
        if s.contains("SKIP") { return false }
        if s.contains("ERROR") { return false }
        // If a leading "<num>/<den>" pair is present, require equality
        // (full PASS, not partial). Free-text statuses without that
        // shape (e.g. "PASS (concurrent branch ...)") are accepted on
        // the PASS-token check alone.
        if let pair = leadingFractionPair(s) {
            return pair.num == pair.den
        }
        return true
    }

    /// Parses an optional `"<num>/<den> ..."` prefix into a numeric
    /// pair. Returns `nil` when the string does not start with that
    /// shape — caller treats absence as "no fraction constraint."
    private static func leadingFractionPair(_ s: String)
        -> (num: Int, den: Int)?
    {
        // Find first whitespace to bound the prefix token.
        let head: String
        if let sp = s.firstIndex(where: { $0.isWhitespace }) {
            head = String(s[..<sp])
        } else {
            head = s
        }
        let parts = head.split(separator: "/")
        guard parts.count == 2,
              let num = Int(parts[0]),
              let den = Int(parts[1]) else {
            return nil
        }
        return (num, den)
    }
}
