// ChipVerifyRecord — chip + verify (D111 Phase C · chip cockpit half).
//
// SSOT: ~/core/hexa-lang/stdlib/chip/verify.py (PR #279 chip stdlib
// substrate). Yosys equiv_make + equiv_induct + equiv_simple flow
// (combinational equivalence pre vs post-synth).
//
// Honest gates (g3):
//   • measurement_gate = GATE_OPEN ALWAYS — combinational equivalence
//     does NOT verify sequential behavior · no SymbiYosys SBY formal
//     sequential equivalence · no UVM/cocotb dynamic verify.
//   • absorbed = false ALWAYS — tapeout signoff (post-P&R LVS · DRC ·
//     STA) is chip §D handoff cell territory, not this cell.
//   • scope_caveats: equiv flow only covers pre vs post-synth combo
//     equivalence (Yosys SAT-solver default · no abc miter) · sequential
//     unrolling depth-bounded.
//
// Distinct from κ-43 / D70 chip+verify (sweep_oracle_parity.hexa booksim
// orchestrator) — that path is preserved in ActionDispatch.runChipVerify
// as the κ-43 12/12 oracle-parity legacy. Migration leaves κ-43 intact;
// the cellrun path is the NEW chip+verify default that PR #279 substrate
// fills in via stdlib/chip/verify.py.

import Foundation

public struct ChipVerifyRecord: Codable, Equatable, Sendable {
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

    // ---- chip + verify fields ---------------------------------------
    /// Equivalence-check result (e.g. "EQUIV", "NOT_EQUIV", "UNKNOWN").
    public let equivResult: String?
    /// Pre-synthesis cell count (yosys read_verilog · pre-opt).
    public let preCellCount: Int?
    /// Post-synthesis cell count (after synth + abc + map).
    public let postCellCount: Int?
    /// True only if equiv flow returned EQUIV across ALL miter points.
    public let cleared: Bool?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case equivResult = "equiv_result"
        case preCellCount = "pre_cell_count"
        case postCellCount = "post_cell_count"
        case cleared
    }
}
