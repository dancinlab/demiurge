// DependenciesLoader — load `demiurge/domains/DEPENDENCIES.demi`
// (D80 + D86 + D87 + D88) into typed `DependencyEntry` rows.
//
// SSOT: `~/core/demiurge/domains/DEPENDENCIES.demi`. The κ-65 audit
// originally landed this file in hexa-lang; D88 relocated it to
// demiurge (`.demi` is a demiurge family format per D87 — all .demi
// SSOTs live in demiurge/domains/). The file carries 44 rows (13
// kernels + 31 domain producers). Each row classifies a substrate
// by `weight` (trivial → nonportable) and `portable_status`
// (already-ported → nonportable), so demiurge can choose the right
// `GateType` at cell-emit time without copying the table into Swift
// (D86 g_no_hardcoded_data).
//
// HONESTY (D80 / per-`ProducerLoader` pattern): when the file is
// absent (the demiurge repo isn't on disk yet, or the env vars are
// misconfigured) this loader emits a stderr warning and returns an
// empty array — it does NOT crash and it does NOT silently fall back
// to a hardcoded Swift mirror. Caller-side dispatch keeps the cell
// at `GateType = unspecified` until the SSOT is readable.
//
// SCHEMA: see the head-of-file comment in
// `demiurge/domains/DEPENDENCIES.demi`. The fields below mirror the
// .demi keys (path / kind / domain / external_imports / weight /
// portable_status / notes).

import Foundation

/// One row from `domains/DEPENDENCIES.demi` — a substrate kernel or
/// domain-producer audit entry.
public struct DependencyEntry: Sendable, Equatable {

    /// `weight` — single-dimension scale of how big a hexa-native
    /// port would be. Mirrored from the .demi enum verbatim.
    public enum Weight: String, Sendable, Equatable, CaseIterable {
        /// `math` / stdlib only — no numpy, no scipy.
        case trivial     = "trivial"
        /// numpy / pandas only.
        case small       = "small"
        /// scipy / matplotlib / mid-size domain library.
        case medium      = "medium"
        /// multi-year port (openmc / drake / pinocchio / xsuite / …).
        case heavy       = "heavy"
        /// proprietary / GPU-tied — port not in scope (CARLA / Drake
        /// / Geant4 / GMAT / Basilisk / FEMM).
        case nonportable = "nonportable"
    }

    /// `portable_status` — current state of the hexa-native port.
    /// Drives the demiurge cell's GateType at emit time.
    public enum PortableStatus: String, Sendable, Equatable, CaseIterable {
        /// A `.hexa` substrate exists AND parity-tests against the
        /// `.py` substrate.
        case alreadyPorted  = "already-ported"
        /// Sub-agent landed a `.hexa` port on a branch (not on
        /// origin/main yet).
        case inFlight       = "in-flight"
        /// Small primitive, candidate for the next pilot round.
        case portableNext   = "portable-next"
        /// Large numeric stack (FEM / MGXS / CFD) — pattern proof
        /// useful, full port is a multi-round project.
        case heavyPort      = "heavy-port"
        /// Closed-source / GPU-tied substrate; permanent
        /// `GateType.hexaNativeAbsent`.
        case nonportable    = "nonportable"
    }

    /// `kind` — kernel vs domain-producer. Matches the .demi vocab.
    public enum Kind: String, Sendable, Equatable, CaseIterable {
        case kernel         = "kernel"
        case domainProducer = "domain_producer"
    }

    /// Row id — `[<id>]` in the .demi file (e.g. `kernel-solar`).
    public let id: String
    /// `path` — repo-relative path to the substrate file (e.g.
    /// `"stdlib/kernels/solar/pvlib_kernel.py"`).
    public let path: String
    /// `kind` — kernel | domain_producer.
    public let kind: Kind
    /// `domain` — for kernels, the kernel folder name; for domain
    /// producers, the producer's domain id (e.g. `"energy"`).
    public let domain: String
    /// `external_imports` — third-party Python imports only. Stdlib
    /// (os/sys/json/math/...) and first-party kernel imports are NOT
    /// listed in the .demi (so they're NOT in this array either).
    public let externalImports: [String]
    /// `weight` — see Weight enum.
    public let weight: Weight
    /// `portable_status` — see PortableStatus enum.
    public let portableStatus: PortableStatus
    /// `notes` — one-line justification or blocker. Free-text caveat,
    /// often the most informative field at a glance.
    public let note: String

    public init(id: String,
                path: String,
                kind: Kind,
                domain: String,
                externalImports: [String],
                weight: Weight,
                portableStatus: PortableStatus,
                note: String) {
        self.id              = id
        self.path            = path
        self.kind            = kind
        self.domain          = domain
        self.externalImports = externalImports
        self.weight          = weight
        self.portableStatus  = portableStatus
        self.note            = note
    }
}

public enum DependenciesLoader {

    /// Resolve the canonical path for demiurge's
    /// `domains/DEPENDENCIES.demi` (D87 + D88 — `.demi` lives in
    /// demiurge, NOT hexa-lang). Priority:
    /// 1. `$DEMIURGE_REPO/domains/DEPENDENCIES.demi`
    /// 2. `$PWD/domains/DEPENDENCIES.demi`
    /// 3. `~/core/demiurge/domains/DEPENDENCIES.demi` (last resort)
    public static func dependenciesPath() -> String? {
        let env = ProcessInfo.processInfo.environment
        if let repo = env["DEMIURGE_REPO"] {
            let p = "\(repo)/domains/DEPENDENCIES.demi"
            if FileManager.default.fileExists(atPath: p) { return p }
        }
        let cwd = FileManager.default.currentDirectoryPath
        let pwdPath = "\(cwd)/domains/DEPENDENCIES.demi"
        if FileManager.default.fileExists(atPath: pwdPath) { return pwdPath }
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let homePath = "\(home)/core/demiurge/domains/DEPENDENCIES.demi"
        if FileManager.default.fileExists(atPath: homePath) { return homePath }
        return nil
    }

    /// Load + parse + project. Returns empty array + stderr warning
    /// when the file is missing (D80 honesty: no silent hardcoded
    /// fallback — the cell stays at `GateType.unspecified` and the
    /// G2 dashboard surfaces the gap).
    public static func loadAll() -> [DependencyEntry] {
        guard let path = dependenciesPath() else {
            FileHandle.standardError.write(
                Data(("DependenciesLoader: DEPENDENCIES.demi not "
                      + "found (tried $DEMIURGE_REPO/domains, "
                      + "$PWD/domains, ~/core/demiurge/domains) — "
                      + "returning [] (D80)\n"
                ).utf8))
            return []
        }
        guard let src = try? String(contentsOfFile: path, encoding: .utf8)
            else {
            FileHandle.standardError.write(
                Data(("DependenciesLoader: cannot read \(path) "
                      + "— returning [] (D80)\n").utf8))
            return []
        }
        let sections = DemiParser.parse(src)
        return sections.compactMap { project($0) }
    }

    /// Project one `DemiSection` into a `DependencyEntry`. Tolerant
    /// — returns nil on missing required fields or unknown enum
    /// values (logged to stderr).
    public static func project(_ s: DemiSection) -> DependencyEntry? {
        guard let path = s.string("path"),
              let kindRaw = s.string("kind"),
              let kind = DependencyEntry.Kind(rawValue: kindRaw),
              let domain = s.string("domain"),
              let weightRaw = s.string("weight"),
              let weight = DependencyEntry.Weight(rawValue: weightRaw),
              let statusRaw = s.string("portable_status"),
              let status = DependencyEntry.PortableStatus(
                  rawValue: statusRaw) else {
            FileHandle.standardError.write(
                Data(("DependenciesLoader: section '\(s.id)' "
                      + "missing or invalid path/kind/domain/"
                      + "weight/portable_status — skipped\n").utf8))
            return nil
        }
        let imports = s.list("external_imports")
        let note = s.string("notes") ?? ""
        return DependencyEntry(
            id: s.id,
            path: path,
            kind: kind,
            domain: domain,
            externalImports: imports,
            weight: weight,
            portableStatus: status,
            note: note)
    }

    /// D80 — inference helper: map a `portable_status` to the cell
    /// record's `GateType`. The mapping is the contract documented
    /// in `inbox/notes/hexa-native-connection-plan-2026-05-20.md`
    /// §3.1 (permanent → `hexaNativeAbsent`) and §3.2 (heavy-port
    /// → `hexaNativeFuture`). All other statuses return nil — the
    /// cell-side dispatcher decides (likely keeps its current type).
    ///
    /// Caller uses this at cell-emit time:
    ///
    ///     let gate = DependenciesLoader.inferGateType(
    ///         for: dep.portableStatus) ?? record.gateType
    public static func inferGateType(for status: DependencyEntry.PortableStatus)
        -> GateType?
    {
        switch status {
        case .nonportable: return .hexaNativeAbsent
        case .heavyPort:   return .hexaNativeFuture
        case .alreadyPorted, .inFlight, .portableNext:
            return nil
        }
    }

    /// Convenience: dependency entries grouped by `kind` for the
    /// G2 dashboard ("kernels vs producers" split).
    public static func byKind(_ entries: [DependencyEntry])
        -> (kernels: [DependencyEntry],
            producers: [DependencyEntry])
    {
        var k: [DependencyEntry] = []
        var p: [DependencyEntry] = []
        for e in entries {
            switch e.kind {
            case .kernel:         k.append(e)
            case .domainProducer: p.append(e)
            }
        }
        return (k, p)
    }
}
