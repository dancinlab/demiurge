// ChipSpecifyRecord — chip + specify (D111 Phase C · chip cockpit half ·
// 16+1th domain after firmware).
//
// SSOT: ~/core/hexa-lang/stdlib/chip/specify.py (PR #279 chip stdlib
// substrate · concurrent hexa-lang half · this is the cockpit-side typed
// R3-compliant Codable sidecar that decodes the cellrun envelope).
//
// Honest gates (g3 — non-negotiable):
//   • measurement_gate = GATE_OPEN ALWAYS — RTL requirements.json template
//     is illustrative, NOT a tapeout-ready spec.
//   • absorbed = false ALWAYS — substrate absorption (yosys clean-room
//     phase-a per κ-43 chip §B) is at the synthesize/verify cells, not
//     specify.
//   • scope_caveats MUST surface: archive/comb/rtl/* are didactic chips,
//     NOT tapeout-ready · target freq / area budget are aspirational ·
//     PDK target is SKY130 only (no advanced node).
//
// Mirrors FirmwareSpecifyRecord (envelope) + adds chip-specific fields
// per chip §B/§D and domains/chip.md template.

import Foundation

public struct ChipSpecifyRecord: Codable, Equatable, Sendable {
    // ---- envelope (firmware/sscb pattern) -----------------------------
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

    // ---- chip + specify fields (from PR #279 specify.py emit shape) ---
    /// Top-level module name (e.g. "counter4", "router_d4").
    public let top: String?
    /// RTL family / pattern (e.g. "comb sequential", "FSM", "router").
    public let family: String?
    /// Target operating frequency in MHz (aspirational, NOT measured).
    public let freqMhz: Double?
    /// Area budget in µm² (aspirational, NOT measured).
    public let areaBudgetUm2: Double?
    /// PDK target identifier (e.g. "sky130_fd_sc_hd").
    public let pdkTarget: String?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case top, family
        case freqMhz = "freq_mhz"
        case areaBudgetUm2 = "area_budget_um2"
        case pdkTarget = "pdk_target"
    }
}
