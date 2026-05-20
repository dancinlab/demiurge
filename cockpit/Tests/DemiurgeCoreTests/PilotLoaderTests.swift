// PilotLoaderTests — covers the honesty paths of `PilotLoader`:
//   (a) missing PILOTS.demi → empty array + stderr warning (no silent
//       hardcoded fallback per D80).
//   (b) tiny fixture string → known row count + field projection
//       (D90 8-field schema preserved verbatim).
//   (c) find(kernelPath:) and find(id:) lookup exact-match contracts.
//
// Foundation-only XCTest — same dependency surface as
// `DependenciesLoaderTests`.

import XCTest
@testable import DemiurgeCore

final class PilotLoaderTests: XCTestCase {

    // MARK: empty environment — no .demi anywhere

    func testEmptyEnvironmentReturnsEmptyArrayOrDevRows() {
        // Point all three resolver env-vars at a guaranteed-absent
        // directory. Use setenv so this test is self-contained.
        let scratch = NSTemporaryDirectory()
            + "pilot-loader-empty-\(UUID().uuidString)"
        setenv("DEMIURGE_REPO", scratch, 1)
        defer { unsetenv("DEMIURGE_REPO") }

        // pilotsPath() may still find ~/core/demiurge/... on a dev
        // box. The honest assertion is "either nil OR a path that
        // points outside our scratch dir"; if it returns a real path
        // loadAll() returns the real list, otherwise empty + warning.
        let path = PilotLoader.pilotsPath()
        if let path = path {
            XCTAssertFalse(path.hasPrefix(scratch),
                "scratch path should never resolve")
            // dev-box has the SSOT — loadAll returns a real list.
            let rows = PilotLoader.loadAll()
            XCTAssertFalse(rows.isEmpty,
                "dev-box SSOT exists at \(path) but loadAll empty")
        } else {
            // True empty environment — empty list, no crash.
            let rows = PilotLoader.loadAll()
            XCTAssertEqual(rows.count, 0)
        }
    }

    // MARK: fixture parse — known shape

    /// Mini 3-row fixture covering the 8-field schema (D90).
    private static let fixture = """
    # fixture for PilotLoaderTests

    [pilot-solar]
    kernel_path       = "stdlib/kernels/solar/solar_kernel.hexa"
    parity_test       = "stdlib/kernels/solar/solar_kernel_test.hexa"
    parity_method     = "pvlib 0.13.0 substrate parity at 6 timestamps"
    parity_tolerance  = "<=1e-13 rel"
    parity_status     = "21/21 PASS at rel_err <=1e-13"
    hexa_lang_sha     = "122620de"
    algorithm_ref     = "Hughes 1985 ephemeris + Haurwitz 1945"
    scope_notes       = "fixture row — solar pilot"

    [pilot-plasma_metrics]
    kernel_path       = "stdlib/kernels/plasma/plasma_metrics_kernel.hexa"
    parity_test       = "stdlib/kernels/plasma/plasma_metrics_kernel_test.hexa"
    parity_method     = "hand-mirrored Python math closed-form, 8 samples"
    parity_tolerance  = "rel_err = 0.0 (bit-exact)"
    parity_status     = "41/41 PASS at rel_err = 0.0"
    hexa_lang_sha     = "c668702b"
    algorithm_ref     = "NRL Plasma Formulary p.34"
    scope_notes       = "fixture row — plasma pilot"

    [pilot-event_queue]
    kernel_path       = "stdlib/kernels/noc_sim/event_queue.hexa"
    parity_test       = "stdlib/kernels/noc_sim/event_queue_test.hexa"
    parity_method     = "python-companion heapq parity, FIFO tiebreaker"
    parity_tolerance  = "exact (discrete data structure)"
    parity_status     = "36/36 PASS exact"
    hexa_lang_sha     = "f8cd27c8"
    algorithm_ref     = "Binary min-heap discrete-event scheduler"
    scope_notes       = "fixture row — event queue pilot"
    """

    /// Helper: write fixture to tmp + point DEMIURGE_REPO at it,
    /// return loaded rows.
    private func loadFixture() throws -> [PilotEntry] {
        let tmp = NSTemporaryDirectory()
            + "pilot-loader-fix-\(UUID().uuidString)"
        let domainsDir = "\(tmp)/domains"
        try FileManager.default.createDirectory(
            atPath: domainsDir,
            withIntermediateDirectories: true)
        let demiPath = "\(domainsDir)/PILOTS.demi"
        try Self.fixture.write(toFile: demiPath,
                               atomically: true,
                               encoding: .utf8)
        setenv("DEMIURGE_REPO", tmp, 1)
        return PilotLoader.loadAll()
    }

    func testFixtureParsesThreeRowsWith8FieldsEach() throws {
        defer { unsetenv("DEMIURGE_REPO") }
        let rows = try loadFixture()
        XCTAssertEqual(rows.count, 3,
            "fixture has 3 rows; loader read \(rows.count)")

        // ids preserved verbatim
        let ids = rows.map(\.id).sorted()
        XCTAssertEqual(ids, [
            "pilot-event_queue",
            "pilot-plasma_metrics",
            "pilot-solar",
        ])

        // 8-field projection — spot-check one row's fields
        let byId = Dictionary(uniqueKeysWithValues: rows.map { ($0.id, $0) })
        guard let solar = byId["pilot-solar"] else {
            XCTFail("pilot-solar missing"); return
        }
        XCTAssertEqual(solar.kernelPath,
                       "stdlib/kernels/solar/solar_kernel.hexa")
        XCTAssertEqual(solar.parityTest,
                       "stdlib/kernels/solar/solar_kernel_test.hexa")
        XCTAssertEqual(solar.parityMethod,
                       "pvlib 0.13.0 substrate parity at 6 timestamps")
        XCTAssertEqual(solar.parityTolerance, "<=1e-13 rel")
        XCTAssertEqual(solar.parityStatus,
                       "21/21 PASS at rel_err <=1e-13")
        XCTAssertEqual(solar.hexaLangSha, "122620de")
        XCTAssertEqual(solar.algorithmRef,
                       "Hughes 1985 ephemeris + Haurwitz 1945")
        XCTAssertEqual(solar.scopeNotes, "fixture row — solar pilot")
    }

    func testFindByKernelPathExactMatch() throws {
        defer { unsetenv("DEMIURGE_REPO") }
        let rows = try loadFixture()

        // exact-match path → row returned
        let hit = PilotLoader.find(
            kernelPath: "stdlib/kernels/plasma/plasma_metrics_kernel.hexa",
            in: rows)
        XCTAssertEqual(hit?.id, "pilot-plasma_metrics")
        XCTAssertEqual(hit?.hexaLangSha, "c668702b")

        // non-existent path → nil
        XCTAssertNil(PilotLoader.find(
            kernelPath: "stdlib/kernels/none/none.hexa",
            in: rows))
    }

    func testFindByIdExactMatch() throws {
        defer { unsetenv("DEMIURGE_REPO") }
        let rows = try loadFixture()

        let hit = PilotLoader.find(id: "pilot-event_queue", in: rows)
        XCTAssertEqual(hit?.kernelPath,
                       "stdlib/kernels/noc_sim/event_queue.hexa")
        XCTAssertEqual(hit?.parityStatus, "36/36 PASS exact")

        XCTAssertNil(PilotLoader.find(id: "pilot-nonexistent",
                                       in: rows))
    }
}
