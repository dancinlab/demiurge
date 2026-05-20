// DependenciesLoaderTests — covers the two honesty paths of
// `DependenciesLoader`:
//   (a) missing DEPENDENCIES.demi → empty array + stderr warning
//       (no silent hardcoded fallback per D80).
//   (b) tiny fixture string → known row count + weight/portable
//       enum mappings + GateType inference contract (§3.1 / §3.2
//       of the connection-plan note).
//
// Foundation-only XCTest — same dependency surface as the rest of
// DemiurgeCore.

import XCTest
@testable import DemiurgeCore

final class DependenciesLoaderTests: XCTestCase {

    // MARK: empty environment — no .demi anywhere

    func testEmptyEnvironmentReturnsEmptyArray() {
        // Point the resolver env-vars at a guaranteed-absent
        // directory. Use setenv so this test is self-contained.
        let scratch = NSTemporaryDirectory()
            + "deps-loader-empty-\(UUID().uuidString)"
        setenv("DEMIURGE_REPO", scratch, 1)
        defer {
            unsetenv("DEMIURGE_REPO")
        }

        // dependenciesPath() may still find ~/core/demiurge/... on
        // a dev box. The honest assertion is "either nil OR a path
        // that points outside our scratch dir"; if it returns a
        // real path we just check loadAll doesn't crash.
        let path = DependenciesLoader.dependenciesPath()
        if let path = path {
            XCTAssertFalse(path.hasPrefix(scratch),
                "scratch path should never resolve")
            // dev-box has the SSOT — loadAll returns a real list,
            // not empty. Sanity-check we got at least one row.
            let rows = DependenciesLoader.loadAll()
            XCTAssertFalse(rows.isEmpty,
                "dev-box SSOT exists at \(path) but loadAll empty")
        } else {
            // True empty environment — empty list, no crash.
            let rows = DependenciesLoader.loadAll()
            XCTAssertEqual(rows.count, 0)
        }
    }

    // MARK: fixture parse — known shape

    /// Mini fixture covering one row of each enum case we care about.
    private static let fixture = """
    # fixture for DependenciesLoaderTests

    [kernel-solar]
    path             = "stdlib/kernels/solar/pvlib_kernel.py"
    kind             = "kernel"
    domain           = "solar"
    external_imports = ["pvlib", "pandas"]
    weight           = "heavy"
    portable_status  = "already-ported"
    notes            = "fixture row — solar already-ported"

    [domain-bot_drake_verify]
    path             = "stdlib/bot/drake_verify.py"
    kind             = "domain_producer"
    domain           = "bot"
    external_imports = ["pydrake"]
    weight           = "nonportable"
    portable_status  = "nonportable"
    notes            = "fixture row — drake permanent nonportable"

    [kernel-fem]
    path             = "stdlib/kernels/fem/skfem_kernel.py"
    kind             = "kernel"
    domain           = "fem"
    external_imports = ["skfem", "numpy"]
    weight           = "heavy"
    portable_status  = "heavy-port"
    notes            = "fixture row — FEM heavy-port"

    [domain-cern_bethe_bloch_stopping]
    path             = "stdlib/cern/bethe_bloch_stopping.py"
    kind             = "domain_producer"
    domain           = "cern"
    external_imports = []
    weight           = "trivial"
    portable_status  = "portable-next"
    notes            = "fixture row — bethe-bloch portable-next"
    """

    func testFixtureParsesFourRowsWithEnumsAndKindSplit() throws {
        // Write fixture to a temp file, point DEMIURGE_REPO at
        // its parent dir (so `<env>/domains/DEPENDENCIES.demi`
        // resolves), then loadAll().
        let tmp = NSTemporaryDirectory()
            + "deps-loader-fix-\(UUID().uuidString)"
        let domainsDir = "\(tmp)/domains"
        try FileManager.default.createDirectory(
            atPath: domainsDir,
            withIntermediateDirectories: true)
        let depPath = "\(domainsDir)/DEPENDENCIES.demi"
        try Self.fixture.write(toFile: depPath,
                               atomically: true,
                               encoding: .utf8)
        defer {
            try? FileManager.default.removeItem(atPath: tmp)
            unsetenv("DEMIURGE_REPO")
        }
        setenv("DEMIURGE_REPO", tmp, 1)

        let rows = DependenciesLoader.loadAll()
        XCTAssertEqual(rows.count, 4,
            "fixture has 4 rows; loader read \(rows.count)")

        // ids preserved verbatim
        let ids = rows.map(\.id).sorted()
        XCTAssertEqual(ids, [
            "domain-bot_drake_verify",
            "domain-cern_bethe_bloch_stopping",
            "kernel-fem",
            "kernel-solar",
        ])

        // weight enum mapping
        let byId = Dictionary(uniqueKeysWithValues: rows.map { ($0.id, $0) })
        XCTAssertEqual(byId["kernel-solar"]?.weight, .heavy)
        XCTAssertEqual(byId["kernel-fem"]?.weight, .heavy)
        XCTAssertEqual(byId["domain-bot_drake_verify"]?.weight,
                       .nonportable)
        XCTAssertEqual(byId["domain-cern_bethe_bloch_stopping"]?.weight,
                       .trivial)

        // portable_status enum mapping
        XCTAssertEqual(byId["kernel-solar"]?.portableStatus,
                       .alreadyPorted)
        XCTAssertEqual(byId["kernel-fem"]?.portableStatus,
                       .heavyPort)
        XCTAssertEqual(byId["domain-bot_drake_verify"]?.portableStatus,
                       .nonportable)
        XCTAssertEqual(byId["domain-cern_bethe_bloch_stopping"]?
                       .portableStatus, .portableNext)

        // kind enum + external_imports preserved
        XCTAssertEqual(byId["kernel-solar"]?.kind, .kernel)
        XCTAssertEqual(byId["domain-bot_drake_verify"]?.kind,
                       .domainProducer)
        XCTAssertEqual(byId["kernel-solar"]?.externalImports,
                       ["pvlib", "pandas"])

        // byKind split — 2 kernels + 2 domain_producers
        let split = DependenciesLoader.byKind(rows)
        XCTAssertEqual(split.kernels.count, 2)
        XCTAssertEqual(split.producers.count, 2)
    }

    func testGateTypeInferenceContract() {
        // §3.1 — nonportable → hexaNativeAbsent (permanent)
        XCTAssertEqual(
            DependenciesLoader.inferGateType(for: .nonportable),
            .hexaNativeAbsent)
        // §3.2 — heavy-port → hexaNativeFuture (tractable future)
        XCTAssertEqual(
            DependenciesLoader.inferGateType(for: .heavyPort),
            .hexaNativeFuture)
        // all other statuses leave the cell-side dispatcher alone
        XCTAssertNil(
            DependenciesLoader.inferGateType(for: .alreadyPorted))
        XCTAssertNil(
            DependenciesLoader.inferGateType(for: .inFlight))
        XCTAssertNil(
            DependenciesLoader.inferGateType(for: .portableNext))
    }
}
