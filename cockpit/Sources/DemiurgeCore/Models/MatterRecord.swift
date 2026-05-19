// MatterRecord — phase κ-30 (θ-2 / matter + analyze · D53).
//
// The typed sidecar JSON that travels with a matter-parity / closure-
// invariant sweep dispatched by demiurge through the hexa-matter
// SSOT (D17 — hexa-matter / hexa-lang owns the absorbed materials
// toolkit; demiurge is a consumer, never re-implements).
//
// HONESTY (g3 — non-negotiable):
//   • producer = "hexa_matter@<commit>" (never "demiurge_…") — the
//     measurement was performed by hexa-matter's `verify/run_all.hexa`,
//     not by Swift. demiurge only spawns the spawner and witnesses.
//   • measurement_gate = .closedMeasured ONLY when (a) every subscript
//     PASSed AND (b) we captured a real hexa-matter commit hash to
//     pin provenance to. If either is missing → .open (honest gap).
//   • absorbed = true ONLY when measurement_gate == .closedMeasured —
//     "absorbed" here means "the parity check has been run end-to-end
//     under demiurge's dispatch with a pinned producer commit". A
//     run-failure or a missing commit hash leaves absorbed = false.
//
// rfc_002 §4 spirit — record honesty travels with the record, not
// with the caller. cockpit's REJECTED card (rfc_011 §4.2) is the
// independent second line of defense.

import Foundation

/// Provenance for a `MatterRecord` — mirrors `ComponentProvenance` /
/// `F1F2Record.Provenance` (same absorbed + measurementGate +
/// caveats discipline; producer points to hexa-matter not demiurge).
public struct MatterProvenance: Codable, Equatable, Sendable {
    public let absorbed: Bool
    /// Producer identifier — e.g. "hexa_matter@315eebe" (when we
    /// captured the commit) or "hexa_matter@unknown" (honest gap).
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

/// A matter-parity sweep record (D53).  Captures the outcome of
/// `hexa run verify/run_all.hexa` for `~/core/hexa-matter` — N/M
/// scripts passed, plus per-script PASS/FAIL — as a typed sidecar
/// the cockpit can render with the same provenance discipline as
/// chip F1F2 records.
public struct MatterRecord: Codable, Equatable, Sendable {
    public let interface: String
    public let schemaVersion: String
    public let recordId: String
    public let producedAtUtc: String
    /// Path of the run_all.hexa script (relative to producer repo).
    public let entryScript: String
    /// Total subscripts executed (= scripts that ran, not the union
    /// of all matter selftests — see scope_caveats).
    public let totalScripts: Int
    /// Subscripts that PASSed.
    public let passedScripts: Int
    /// Per-subscript outcome (ordered) — `verify/<name>.hexa` ⇒ PASS/FAIL.
    public let perScript: [SubscriptResult]
    /// Hexa runtime exit code (0 = success).
    public let exitCode: Int
    public let provenance: MatterProvenance

    public struct SubscriptResult: Codable, Equatable, Sendable {
        public let script: String
        public let passed: Bool
        public init(script: String, passed: Bool) {
            self.script = script
            self.passed = passed
        }
    }

    public init(interface: String, schemaVersion: String,
                recordId: String, producedAtUtc: String,
                entryScript: String, totalScripts: Int,
                passedScripts: Int, perScript: [SubscriptResult],
                exitCode: Int, provenance: MatterProvenance) {
        self.interface = interface
        self.schemaVersion = schemaVersion
        self.recordId = recordId
        self.producedAtUtc = producedAtUtc
        self.entryScript = entryScript
        self.totalScripts = totalScripts
        self.passedScripts = passedScripts
        self.perScript = perScript
        self.exitCode = exitCode
        self.provenance = provenance
    }

    enum CodingKeys: String, CodingKey {
        case interface
        case schemaVersion = "schema_version"
        case recordId = "record_id"
        case producedAtUtc = "produced_at_utc"
        case entryScript = "entry_script"
        case totalScripts = "total_scripts"
        case passedScripts = "passed_scripts"
        case perScript = "per_script"
        case exitCode = "exit_code"
        case provenance
    }
}
