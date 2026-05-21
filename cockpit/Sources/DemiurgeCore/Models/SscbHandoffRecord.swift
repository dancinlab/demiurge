// SscbHandoffRecord — sscb + handoff (SSCB 7-verb walkthrough Step 4 ·
// LAST · 7th wired SSCB cell · first domain to reach 7/7 cellrun-wired
// closure under D111/D114/D116 doctrine · D72 adapter-only · cert-dossier
// bundle template emit).
//
// SSOT: ~/core/hexa-lang/stdlib/sscb/handoff.py (template emit derived
// from `~/core/demiurge/domains/sscb.md` §2 HANDOFF row (UL / TÜV / KTL
// type-test submission per UL 489I + IEC 60947-2; harmonization track
// per UL Solutions) + `sscb.demi` [cell.handoff] caveats. D116:
// hexa-lang stdlib is the producer SSOT.
//
// R3 compliance (constitution 1.4.1):
//   • Cockpit Swift = typed record + thin dispatch ONLY.
//   • Producer logic (UL 489I 1st-ed. (Oct 2025) lab-booking checklist ·
//     IEC 60947-2:2016 type-test dossier · IEEE C37.x family cross-
//     reference · Tier-2 fan-out list · bundle manifest) lives in
//     hexa-lang substrate (Python adapter). The full 5-markdown bundle
//     + sibling meta.json + record JSON are emitted as siblings;
//     downstream consumers (cert manager review · lab partner submission)
//     consume the .md docs directly without re-running the handoff cell.
//
// g3 (honest, non-negotiable):
//   • absorbed = false PERMANENTLY for this cell. Cert dossier =
//     template scaffold · NO actual UL/TÜV/KTL lab booking · NO actual
//     type-test execution · NO Icu/Ics numbers in the bundle
//     (bench-pending · upstream verify cell's bolted-fault rig scope).
//   • measurement_gate = GATE_OPEN always — no path here flips it.
//     absorbed=true requires lab partner sign-off + UL 489I §7 type-test
//     pass + IEC 60947-2 §7.2 harmonized verification + UL recognized
//     component DB entry + CE mark issuance (downstream regulatory
//     work · NOT handoff verb territory).
//   • Tier-2 fan-out list = derivative scaffold from Steps 1-3 ·
//     responsibilities + costs = rough estimates · cert manager review
//     required to finalize.
//   • IEEE C37.x cross-reference = scope-of-applicability mapping ·
//     NOT compliance proof · standards interpretation is legal / cert
//     manager territory.
//   • Sign-off blocks in bundle_manifest §3 = TEMPLATE checkboxes ·
//     actual program PM + vendor relations + cert manager naming pending.
//
// Mirrors the SscbDesignRecord top-level shape (domain · verb · kind ·
// stamp · producer · measurement_gate · absorbed · scope_caveats ·
// citations · skipped_reason · gate_type · provisional · artifacts)
// PLUS the handoff scalar roll-up fields (ul489i_checklist_item_count ·
// iec60947_2_checklist_item_count · ieee_c37_x_reference_count ·
// tier2_fanout_item_count · cert_blocking_count · bundle_artifact_count
// · cert_bundle_ready · notes).

import Foundation

public struct SscbHandoffRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let skippedReason: String?
    /// G7 typed gate_type — `"hexa-native-absent"` for template emit
    /// (cert dossier bundle is a doc scaffold, not a kernel).
    public let gateType: String?
    public let provisional: Bool?

    // ---- SSCB handoff scalar fields (Codable mirror of producer) --------
    /// Count of UL 489I 1st-ed. (Oct 2025) lab-booking checklist items
    /// (Section A samples + B type-test sequence + C documentation +
    /// D lab partner candidates).
    public let ul489iChecklistItemCount: Int
    /// Count of IEC 60947-2:2016 type-test dossier items
    /// (§7.2.1 operational + §7.2.2 temp rise + §7.2.3 dielectric +
    /// §7.2.4 making/breaking + §7.2.5 over-current + §7.2.6 additional).
    public let iec60947_2ChecklistItemCount: Int
    /// Count of IEEE C37.x family cross-reference sign-off items
    /// (C37.13 primary · C37.04 partial · IEEE Std 1789 closest direct
    /// fit · etc.).
    public let ieeeC37XReferenceCount: Int
    /// Count of Tier-2 fan-out items derived from Steps 1-3 artifacts
    /// (specify · structure · design bench-validation needs).
    public let tier2FanoutItemCount: Int
    /// Subset of `tier2FanoutItemCount` that is cert-blocking (must
    /// close before UL 489I lab booking can proceed). Typically 5/13
    /// for HEXA-SSCB mk1 first article (rated current + dielectric +
    /// Wolfspeed UL-recognized lookup + Wolfspeed .lib + bolted-fault
    /// rig).
    public let certBlockingCount: Int
    /// Bundle artifact count — number of markdown documents emitted in
    /// the cert dossier scaffold (typically 5: ul489i_checklist +
    /// iec60947_2_dossier + ieee_c37_x_xref + tier2_fanout + bundle_
    /// manifest).
    public let bundleArtifactCount: Int
    /// True iff all 5 bundle markdown documents emit with non-zero
    /// item counts. NOT a compliance claim — only a template-emit
    /// completeness flag.
    public let certBundleReady: Bool
    /// Free-form notes — scoping language for downstream verbs.
    public let notes: String?

    /// Artifact filenames (relative to `exports/sscb/handoff/<stamp>/`).
    /// Producer emits an array of artifact names (5 markdown docs).
    public let artifacts: [String]?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case gateType = "gate_type"
        case provisional
        case ul489iChecklistItemCount = "ul489i_checklist_item_count"
        case iec60947_2ChecklistItemCount = "iec60947_2_checklist_item_count"
        case ieeeC37XReferenceCount = "ieee_c37_x_reference_count"
        case tier2FanoutItemCount = "tier2_fanout_item_count"
        case certBlockingCount = "cert_blocking_count"
        case bundleArtifactCount = "bundle_artifact_count"
        case certBundleReady = "cert_bundle_ready"
        case notes
        case artifacts
    }
}
