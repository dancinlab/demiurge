// IllustrativePhysicsGateTests — D106 (P-⑩ ③ · RFC 013 §6.3) — first-
// class `GateType.illustrativePhysics` case + SkippedCellsAggregator
// inference rule.
//
// Anti-conflation contract (RFC 013 §6.3): `illustrativePhysics` is
// structurally distinct from the two port-blocked buckets — substrate
// parity PASSED on the linked hexa-native kernel, but the kernel is
// illustrative (pattern-proof) so cell-level absorbed flip still
// requires an external measured oracle. The chip MUST paint a 4th
// tone, NOT the green absorbed tone.
//
// Pure DemiurgeCore — no SwiftUI / no exports/ fixture write. The
// inference branch is exercised via an in-test JSON fixture written
// to a tmp dir.

import XCTest
@testable import DemiurgeCore

final class IllustrativePhysicsGateTests: XCTestCase {

    // MARK: — enum case + raw value

    /// D106 — the new case MUST round-trip via its raw value (this is
    /// the wire shape producers emit into the record JSON's
    /// `gate_type` field; if the rawValue changes silently, every
    /// emitted record breaks).
    func testIllustrativePhysicsRawValueRoundTrip() {
        XCTAssertEqual(GateType.illustrativePhysics.rawValue,
                       "illustrative-physics",
                       "wire shape MUST match RFC 013 §6.3 token")
        let parsed = GateType(rawValue: "illustrative-physics")
        XCTAssertEqual(parsed, .illustrativePhysics)
    }

    /// D106 — `allCases` must surface the new case so the dashboard's
    /// `byGateType` grouping (which iterates `GateType.allCases`) can
    /// bucket it.
    func testIllustrativePhysicsIsInAllCases() {
        XCTAssertTrue(GateType.allCases.contains(.illustrativePhysics))
    }

    // MARK: — anti-conflation predicates (RFC 013 §6.3)

    /// D106 — `illustrativePhysics` MUST NOT classify as
    /// `hexaNativeBlocked`. The port is landed and parity-passing;
    /// the blocker is the cell-level measured oracle, NOT the port.
    /// Conflating them would mask the honest gap.
    func testIllustrativePhysicsIsNotHexaNativeBlocked() {
        XCTAssertFalse(GateType.illustrativePhysics.hexaNativeBlocked,
                       "RFC 013 §6.3 anti-conflation — illustrative-"
                       + "physics is NOT a port-blocked bucket")
        // Cross-check: the two port-blocked cases still classify.
        XCTAssertTrue(GateType.hexaNativeAbsent.hexaNativeBlocked)
        XCTAssertTrue(GateType.hexaNativeFuture.hexaNativeBlocked)
    }

    /// D106 — the new predicate `isIllustrativePhysics` MUST fire only
    /// on this case (callers branch on it to paint the 4th chip tone).
    func testIsIllustrativePhysicsPredicate() {
        XCTAssertTrue(GateType.illustrativePhysics.isIllustrativePhysics)
        XCTAssertFalse(GateType.hexaNativeAbsent.isIllustrativePhysics)
        XCTAssertFalse(GateType.hexaNativeFuture.isIllustrativePhysics)
        XCTAssertFalse(GateType.installGated.isIllustrativePhysics)
        XCTAssertFalse(GateType.unspecified.isIllustrativePhysics)
    }

    /// D106 — `illustrativePhysics` is NOT user-resolvable (no
    /// `brew install` or dataset download flips the measurement
    /// oracle gap; the cell waits on an external measured-MGXS run).
    func testIllustrativePhysicsIsNotUserResolvable() {
        XCTAssertFalse(GateType.illustrativePhysics.userResolvable)
    }

    /// D106 — Korean label must call out BOTH halves of the doubly-
    /// provisional state (substrate parity PASS + measured oracle
    /// absent) so the dashboard reader cannot mistake it for the
    /// absorbed branch.
    func testIllustrativePhysicsLabel() {
        let label = GateType.illustrativePhysics.label
        XCTAssertTrue(label.contains("illustrative-physics"),
                      "label must name the dimension: \(label)")
        XCTAssertTrue(label.contains("PASS"),
                      "label must surface the substrate-parity-PASS half: \(label)")
        XCTAssertTrue(label.contains("oracle"),
                      "label must surface the measured-oracle-absent half: \(label)")
    }

    // MARK: — SkippedCellsAggregator inference

    /// D106 — explicit `gate_type = "illustrative-physics"` in the
    /// record JSON MUST decode straight into `.illustrativePhysics`
    /// (the producer-side wire shape per RFC 013 §6.3).
    func testAggregatorDecodesExplicitIllustrativePhysicsGateType() throws {
        let tmp = try makeTmpExportsRoot(payload:
            """
            {
              "domain": "fusion",
              "verb": "verify",
              "kind": "fusion+verify",
              "stamp": "2026-05-20T00:00:00Z",
              "producer": "test-fixture",
              "measurement_gate": "GATE_OPEN",
              "absorbed": false,
              "scope_caveats": [],
              "citations": [],
              "skipped_reason": "mc_slab_demo is illustrative-physics; OpenMC measured-MGXS oracle absent",
              "gate_type": "illustrative-physics"
            }
            """)
        defer { try? FileManager.default.removeItem(at: tmp) }

        let entries = SkippedCellsAggregator.scan(under: tmp)
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries.first?.gateType, .illustrativePhysics)
    }

    /// D106 — when the producer has NOT yet adopted G7 (no
    /// `gate_type` field), the aggregator's heuristic fallback MUST
    /// classify records whose `skipped_reason` mentions illustrative-
    /// physics phrasing into `.illustrativePhysics` (not the catch-
    /// all `.unspecified`). This is the bridge that keeps the
    /// dashboard honest before producer-emit (P-⑩ ①) lands.
    func testAggregatorHeuristicFallbackClassifiesIllustrativePhysics() throws {
        let tmp = try makeTmpExportsRoot(payload:
            """
            {
              "domain": "fusion",
              "verb": "verify",
              "kind": "fusion+verify",
              "stamp": "2026-05-20T00:00:00Z",
              "producer": "test-fixture",
              "measurement_gate": "GATE_OPEN",
              "absorbed": false,
              "scope_caveats": [],
              "citations": [],
              "skipped_reason": "mc_slab_demo pattern-proof kernel — illustrative; measured oracle pending"
            }
            """)
        defer { try? FileManager.default.removeItem(at: tmp) }

        let entries = SkippedCellsAggregator.scan(under: tmp)
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries.first?.gateType, .illustrativePhysics,
                       "heuristic must classify on 'illustrative' / "
                       + "'pattern-proof' / 'mc_slab_demo' tokens")
    }

    // MARK: — helpers

    /// Writes a single fixture record JSON under
    /// `<tmp>/<domain>/<verb>/<stamp>.json` so the aggregator's
    /// directory walker finds it. Caller `defer`-removes the root.
    private func makeTmpExportsRoot(payload: String) throws -> URL {
        let fm = FileManager.default
        let root = fm.temporaryDirectory
            .appendingPathComponent("illustrative-physics-test-\(UUID().uuidString)")
        let cellDir = root
            .appendingPathComponent("fusion")
            .appendingPathComponent("verify")
        try fm.createDirectory(at: cellDir,
                               withIntermediateDirectories: true)
        let recordURL = cellDir.appendingPathComponent("record.json")
        try Data(payload.utf8).write(to: recordURL)
        return root
    }
}
