// CernSpecifyRecord — cern + specify STUB (4-verb scaffold round).
//
// Typed cockpit-consumer sidecar (R3) for the `cern + specify` cell.
// SSOT substrate = ~/core/hexa-lang/stdlib/cern/specify.py (NOT YET
// AUTHORED — cellrun.hexa honest-skips rc=2 until it lands; this record
// is the decode target the cell WILL fill, mirroring FirmwareSpecifyRecord
// / CernSynthRecord). Dispatch is manifest-driven via domains/cern.demi
// [cell.specify] → CellrunDispatch.run("cern", .specify) — NO per-verb
// Swift producer class, NO ActionDispatch branch (@D d4 single generic
// dispatch; instance = manifest only).
//
// 명세 SPECIFY = physics-case / Conceptual Design Report (CDR) spec text —
// target field / energy / luminosity. domains/cern.md §1 (lattice/optics
// deliverable) is the SSOT candidate the producer would convert to JSON.
//
// HONEST (g3 — non-negotiable):
//   • producer = "stub — a real impl would parse a physics-case / CDR
//     brief (target B-field [T], beam energy [GeV/TeV], luminosity
//     [cm⁻²s⁻¹]) into a typed spec record; no substrate authored yet."
//   • measurement_gate = GATE_OPEN ALWAYS · absorbed = false ALWAYS —
//     a requirements/CDR skeleton is never an absorption claim.

import Foundation

/// Optional headline for a cern + specify record — the CDR-level targets
/// (all nullable: a stub run leaves them nil; a real CDR parse fills them).
public struct CernSpecifyHeadline: Codable, Equatable, Sendable {
    /// Target peak dipole field [T] (e.g. ~8.3 T LHC, ~16 T FCC-hh).
    public let targetFieldT: Double?
    /// Target beam energy [GeV] (per-beam centre-of-mass anchor).
    public let beamEnergyGeV: Double?
    /// Target peak luminosity [cm⁻²s⁻¹].
    public let luminosityCm2S: Double?
    /// Free-text machine class (collider / light-source / fixed-target).
    public let machineClass: String?

    enum CodingKeys: String, CodingKey {
        case targetFieldT = "target_field_T"
        case beamEnergyGeV = "beam_energy_GeV"
        case luminosityCm2S = "luminosity_cm2_s"
        case machineClass = "machine_class"
    }
}

public struct CernSpecifyRecord: Codable, Equatable, Sendable {
    public let domain: String
    public let verb: String
    public let kind: String
    public let stamp: String
    public let producer: String
    /// Acceleration-mechanism axis (CERN.md §1.5 — rf_cavity /
    /// plasma_wakefield / dielectric_laser) stamped from birth so the
    /// data layer carries the axis split before any lazy-split.
    public let accelMechanism: String?
    public let measurementGate: F1F2Record.MeasurementGate
    public let absorbed: Bool
    public let scopeCaveats: [String]
    public let citations: [String]
    public let skippedReason: String?
    public let headline: CernSpecifyHeadline?

    enum CodingKeys: String, CodingKey {
        case domain, verb, kind, stamp, producer
        case accelMechanism = "accel_mechanism"
        case measurementGate = "measurement_gate"
        case absorbed
        case scopeCaveats = "scope_caveats"
        case citations
        case skippedReason = "skipped_reason"
        case headline
    }
}
