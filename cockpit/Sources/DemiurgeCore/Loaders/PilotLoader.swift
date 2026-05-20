// PilotLoader — load `demiurge/domains/PILOTS.demi` (D87 + D90 + D91)
// into typed `PilotEntry` rows.
//
// SSOT: `demiurge/domains/PILOTS.demi` — declarative parity SSOT for
// `stdlib/kernels/<X>/*.hexa` pilots on hexa-lang origin/main. Each
// row mirrors the (planned) `HexaNativeParityRef` Swift struct 1:1
// (D90); a Producer at T7 will look up its kernel via `find(kernelPath:)`
// and inject the row's 8 fields into the cell-record without copying
// the table into Swift code (D86 g_no_hardcoded_data).
//
// Companion SSOT (D93): `hexa-lang:inbox/notes/hexa-native-port-
// pattern-pilot.md` — same kernels, prose dimension. Cross-link in
// both directions; this file is the field-level authority, the .md
// is the rationale + gotchas authority.
//
// HONESTY (D80, same contract as DependenciesLoader / ProducerLoader):
// when the file is absent the loader emits a stderr warning and
// returns an empty array. It does NOT crash and does NOT silently
// substitute a Swift-hardcoded mirror. Producers downstream then
// leave `HexaNativeParityRef` nil on the record, which keeps the
// cell at its current GateType.
//
// SCHEMA (D90): see the head-of-file comment in `domains/PILOTS.demi`.
// Eight fields per section, each mapped to one `PilotEntry` property.

import Foundation

/// One row from `domains/PILOTS.demi` — a hexa-native parity pilot
/// for a single `stdlib/kernels/<X>/*.hexa` kernel file (D91 — kernel
/// granularity, NOT assertion granularity).
public struct PilotEntry: Sendable, Equatable {

    /// Row id — `[pilot-<id>]` in the .demi file (e.g. `pilot-solar`).
    /// D91 convention: lowercase, dash-separated, `pilot-` prefix.
    public let id: String

    /// `kernel_path` — repo-relative path to the .hexa kernel on
    /// hexa-lang (e.g. `"stdlib/kernels/solar/solar_kernel.hexa"`).
    /// This is the `find(kernelPath:)` lookup key (T7 phase).
    public let kernelPath: String

    /// `parity_test` — repo-relative path to the parity test on
    /// hexa-lang (e.g. `"stdlib/kernels/solar/solar_kernel_test.hexa"`).
    public let parityTest: String

    /// `parity_method` — one-line method description (what was
    /// compared against what; sample set; oracle source).
    public let parityMethod: String

    /// `parity_tolerance` — tolerance string (D80 ceiling or actual
    /// observed gap).
    public let parityTolerance: String

    /// `parity_status` — `"NN/NN PASS at rel_err=…"` summary string.
    /// D91 — when sub-test counts grow this string is updated; new
    /// row is NOT added.
    public let parityStatus: String

    /// `hexa_lang_sha` — short commit SHA on hexa-lang origin/main
    /// where the kernel + parity-test landed.
    public let hexaLangSha: String

    /// `algorithm_ref` — textbook / paper reference (e.g.
    /// `"NRL Plasma Formulary p.34"`).
    public let algorithmRef: String

    /// `scope_notes` — one-line caveat (what this does NOT prove —
    /// the g3 honesty field).
    public let scopeNotes: String

    public init(id: String,
                kernelPath: String,
                parityTest: String,
                parityMethod: String,
                parityTolerance: String,
                parityStatus: String,
                hexaLangSha: String,
                algorithmRef: String,
                scopeNotes: String) {
        self.id              = id
        self.kernelPath      = kernelPath
        self.parityTest      = parityTest
        self.parityMethod    = parityMethod
        self.parityTolerance = parityTolerance
        self.parityStatus    = parityStatus
        self.hexaLangSha     = hexaLangSha
        self.algorithmRef    = algorithmRef
        self.scopeNotes      = scopeNotes
    }
}

public enum PilotLoader {

    /// Resolve the canonical path for `demiurge/domains/PILOTS.demi`
    /// (D87 — `.demi` lives in demiurge, NOT hexa-lang). Priority:
    /// 1. `$DEMIURGE_REPO/domains/PILOTS.demi`
    /// 2. `$PWD/domains/PILOTS.demi`
    /// 3. `~/core/demiurge/domains/PILOTS.demi` (last resort)
    public static func pilotsPath() -> String? {
        let env = ProcessInfo.processInfo.environment
        if let repo = env["DEMIURGE_REPO"] {
            let p = "\(repo)/domains/PILOTS.demi"
            if FileManager.default.fileExists(atPath: p) { return p }
        }
        let cwd = FileManager.default.currentDirectoryPath
        let pwdPath = "\(cwd)/domains/PILOTS.demi"
        if FileManager.default.fileExists(atPath: pwdPath) { return pwdPath }
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let homePath = "\(home)/core/demiurge/domains/PILOTS.demi"
        if FileManager.default.fileExists(atPath: homePath) { return homePath }
        return nil
    }

    /// Load + parse + project. Returns empty array + stderr warning
    /// when the file is missing (D80 honesty: no silent hardcoded
    /// fallback — `HexaNativeParityRef` stays nil on the cell-record
    /// and the G2 dashboard surfaces the gap).
    public static func loadAll() -> [PilotEntry] {
        guard let path = pilotsPath() else {
            FileHandle.standardError.write(
                Data(("PilotLoader: PILOTS.demi not found (tried "
                      + "$DEMIURGE_REPO/domains, $PWD/domains, "
                      + "~/core/demiurge/domains) — returning [] "
                      + "(D80)\n").utf8))
            return []
        }
        guard let src = try? String(contentsOfFile: path, encoding: .utf8)
            else {
            FileHandle.standardError.write(
                Data(("PilotLoader: cannot read \(path) "
                      + "— returning [] (D80)\n").utf8))
            return []
        }
        let sections = DemiParser.parse(src)
        return sections.compactMap { project($0) }
    }

    /// Project one `DemiSection` into a `PilotEntry`. Tolerant —
    /// returns nil on missing required fields (logged to stderr).
    public static func project(_ s: DemiSection) -> PilotEntry? {
        guard let kernelPath = s.string("kernel_path"),
              let parityTest = s.string("parity_test"),
              let parityMethod = s.string("parity_method"),
              let parityTolerance = s.string("parity_tolerance"),
              let parityStatus = s.string("parity_status"),
              let hexaLangSha = s.string("hexa_lang_sha"),
              let algorithmRef = s.string("algorithm_ref")
        else {
            FileHandle.standardError.write(
                Data(("PilotLoader: section '\(s.id)' missing or "
                      + "invalid required field (kernel_path / "
                      + "parity_test / parity_method / "
                      + "parity_tolerance / parity_status / "
                      + "hexa_lang_sha / algorithm_ref) — skipped\n"
                ).utf8))
            return nil
        }
        let scopeNotes = s.string("scope_notes") ?? ""
        return PilotEntry(
            id: s.id,
            kernelPath: kernelPath,
            parityTest: parityTest,
            parityMethod: parityMethod,
            parityTolerance: parityTolerance,
            parityStatus: parityStatus,
            hexaLangSha: hexaLangSha,
            algorithmRef: algorithmRef,
            scopeNotes: scopeNotes)
    }

    /// Lookup by `kernel_path` — the primary key for Producer / cell-
    /// emit dispatch (D94, T7 phase). Returns nil if no row matches.
    public static func find(kernelPath: String,
                            in entries: [PilotEntry]? = nil) -> PilotEntry?
    {
        let rows = entries ?? loadAll()
        return rows.first(where: { $0.kernelPath == kernelPath })
    }

    /// Lookup by row `id` — for cross-link tooling that already knows
    /// the `pilot-<X>` id (e.g. pattern-pilot.md → PILOTS.demi
    /// reverse cross-link verification).
    public static func find(id: String,
                            in entries: [PilotEntry]? = nil) -> PilotEntry?
    {
        let rows = entries ?? loadAll()
        return rows.first(where: { $0.id == id })
    }
}
