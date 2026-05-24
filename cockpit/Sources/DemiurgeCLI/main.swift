// DemiurgeCLI — phase α-3 + β minimum read-only scaffold
// (rfc_011 §10 / D34 / D38).
//
// Subcommands (v0, read-only):
//   demiurge --version | -v           Print version banner
//   demiurge --help    | -h           This help
//   demiurge list-all                 List artifacts of all kinds
//   demiurge list-records             List F1F2 records under ../exports/
//   demiurge list-decisions           List design.md decisions
//   demiurge list-rfcs                List ../proposals/rfc_*.md
//   demiurge list-domains             List ../domains/*.md
//   demiurge show <path>              Show one F1F2 record + provenance
//   demiurge list-projects            List workbench projects (manifests)
//   demiurge show-project <name>      Show one project + 7-verb progress
//   demiurge list-shelf <domain>      Show a domain's §6 shelf options
//   demiurge action <verb>            θ-2 action — dispatch a 7-verb
//                                     stage to claude (rfc_011 §6, κ-5/κ-15)
//   demiurge list-gates               F1F2 records grouped by gate
//   demiurge verify <path|id>         provenance / claim-gate consistency
//   demiurge gate-summary             one-screen gate + absorbed totals
//
// Project subcommands read the SAME manifests the cockpit writes
// (~/Library/Application Support/lab.dancin.demiurge/projects/, D45)
// via the SAME DemiurgeCore functions — ProjectStore / DomainCatalog /
// Verb. cockpit and CLI never diverge (@D g_ssot_single_source).
//
// Action subcommands (rfc_011 §6, Phase θ — NOT here yet):
//   demiurge synth   <args>
//   demiurge measure <args>
//   demiurge verify  <args>
//   demiurge analyze <args>
//
// All `list-*` subcommands use `ArtifactRegistry` (DemiurgeCore) — the same
// abstraction that drives the GUI Artifacts tab. `show` uses `RecordLoader`
// with invariant-a runtime check (paths outside ../exports/** are
// rejected).

import Foundation
import DemiurgeCore

let version = "0.0.2 (phase α-3 + β, read-only — rfc_011 §10)"

func usage() {
    print("""
    demiurge — Demiurge cockpit CLI (read-only)

    USAGE:
      demiurge list-all                List artifacts of all kinds
      demiurge list-records            List F1F2 records under ../exports/
      demiurge list-decisions          List design.md decisions
      demiurge list-rfcs               List ../proposals/rfc_*.md
      demiurge list-domains            List ../domains/*.md
      demiurge show <path>             Show one F1F2 record + provenance
      demiurge list-projects           List workbench projects
      demiurge show-project <name>     Show one project + 7-verb progress
      demiurge project advance|retreat <name>
                                       Move a project's 7-verb pointer
                                       (M15 verb-nav · CLI side)
      demiurge list-shelf <domain>     Show a domain's §6 shelf options
      demiurge action <verb> [domain]  θ-2 action — dispatch a verb
                                       (specify/structure/design/analyze/
                                        synthesize/synth/verify/measure/
                                        handoff; 한글 명세/구조/설계/해석/
                                        합성/검증/인계 also accepted).
                                       optional domain (chip/component/…)
                                       routes to a real engine tool when
                                       one exists (e.g. component+synth
                                       → emit-component; chip+verify →
                                       booksim self-test; chip+synth →
                                       yosys.hexa dispatcher selftest).
      demiurge list-gates              F1F2 records grouped by gate
      demiurge verify <path|id>        provenance / claim-gate check
                                       (exit 0 consistent · 1 not)
      demiurge verify --expr <fn> <n> <v> | --fence "<claim>" | rubric
                                       hexa stdlib verify kernel (5-tier,
                                       M16) — verdict printed VERBATIM
                                       (@D g5; hexa = hx dependency)
      demiurge atlas <lookup|stats|hash|dump> [args]
                                       read the hexa atlas SSOT (M16,
                                       read-only). Write verbs = owner
                                       op (사장실 · M20).
      demiurge gate-summary            gate + absorbed totals
      demiurge operate [list|audit]    operation manifest (M14) — list
                                       all ops + reachability, or audit
                                       external operability. `--owner`
                                       reveals owner-only (사장실) ops.
      demiurge compose <domain>        resolve a domain into its
                                       constituent (prerequisite) domain
                                       stack + cluster union + kind
                                       (atomic/composite/meta) — M15.
      demiurge backend [list|current]  compute backend (M17) — local
                                       default + DEMIURGE_BACKEND remote.
                                       owner pool hosts (from ~/.pool/
                                       pool.json) only with --owner.
      demiurge emit-component          Emit the procedural BIPV
                                       artifact (.usda/.usdz + record)
                                       to exports/component/geometry/
      demiurge export-component <fmt> [path]
                                       Export bundled geometry —
                                       fmt = usda | stl
      demiurge --version | -v          Print version
      demiurge --help    | -h          This help

    NOTES:
      - Records strictly read from ../exports/** (@D g_cockpit_isolation a).
      - Navigation docs read READ-ONLY per design.md D41 clarification.
      - Action subcommands (synth / measure / verify / analyze) land in
        Phase θ via Claude Code CLI dispatch (D34 / D38 /
        @D g_ai_agent_action_surface).
    """)
}

func printVersion() {
    print("demiurge \(version)")
}

func list(kind: ArtifactKind) -> Int32 {
    let stubs = ArtifactRegistry.load(kind: kind)
    print("\(kind.rawValue) (\(stubs.count)):")
    // pad to the longest id in this batch so columns align without
    // truncating the id (matters for $DOM:<name> which varies in length)
    let maxLen = stubs.map { $0.id.display.count }.max() ?? 0
    for s in stubs {
        let pad = String(repeating: " ", count: max(0, maxLen - s.id.display.count))
        print("  \(s.id.display)\(pad)  \(s.title)")
    }
    return 0
}

func listAll() -> Int32 {
    for k in ArtifactKind.allCases {
        _ = list(kind: k)
        print("")
    }
    return 0
}

func show(_ path: String) -> Int32 {
    let result = RecordLoader.load(relativePath: path)
    switch result {
    case .failure(let e):
        FileHandle.standardError.write(Data("show: \(e.errorDescription ?? "unknown error")\n".utf8))
        return 2
    case .success(let r):
        print("record_id:                  \(r.recordId)")
        print("interface:                  \(r.interface)")
        print("schema_version:             \(r.schemaVersion)")
        print("produced_at_utc:            \(r.producedAtUtc)")
        print("topology.kind:              \(r.topology.kind)")
        print("topology.degree:            \(r.topology.degree)")
        print("topology.node_count:        \(r.topology.nodeCount)")
        print("topology.routing:           \(r.topology.routing)")
        print("traffic:                    \(r.traffic)")
        print("verdict.f1:                 \(r.verdict.f1)")
        print("verdict.f2:                 \(r.verdict.f2)")
        print("verdict.rationale:          \(r.verdict.rationale)")
        print("provenance.measurement_gate:\(r.provenance.measurementGate.displayLabel)")
        print("provenance.absorbed:        \(r.provenance.absorbed)")
        print("provenance.sim_engine:      \(r.provenance.simEngine)")
        print("provenance.sim_commit:      \(String(r.provenance.simCommitHash.prefix(12)))")
        print("provenance.consumer_target: \(r.provenance.consumerTarget)")
        print("provenance.atlas_cite:      \(r.provenance.atlasCiteBlock)")
        print("provenance.gate_failures:   \(r.provenance.gateFailures.count)")
        for (i, gf) in r.provenance.gateFailures.enumerated() {
            print("  [\(i)] \(gf)")
        }
        print("provenance.scope_caveats:   \(r.provenance.scopeCaveats.count)")
        for (i, c) in r.provenance.scopeCaveats.enumerated() {
            print("  [\(i)] \(c)")
        }
        return 0
    }
}

/// List workbench projects — reads the same manifests the cockpit
/// writes (ProjectStore, D45) and the same domain/verb metadata
/// (DomainCatalog / Verb) the cockpit renders — @D g_ssot_single_source.
func listProjects() -> Int32 {
    let projects = ProjectStore.loadAll()
    print("projects (\(projects.count)):")
    for p in projects {
        let domain = DomainCatalog.domain(for: p.domain)
        let verb = p.currentVerb
        print("  \(p.name)  —  \(domain.label) · \(verb.rawValue + 1)/7 \(verb.koreanLabel)")
    }
    return 0
}

/// Show one project's manifest + 7-verb progress.
func showProject(_ name: String) -> Int32 {
    let projects = ProjectStore.loadAll()
    guard let p = projects.first(where: { $0.name == name }) else {
        FileHandle.standardError.write(Data("show-project: no project named '\(name)'\n".utf8))
        return 2
    }
    let domain = DomainCatalog.domain(for: p.domain)
    print("name:        \(p.name)")
    print("target:      \(p.target)")
    print("domain:      \(p.domain) (\(domain.label))")
    print("canvas_mode: \(domain.canvasMode.rawValue)")
    print("created_at:  \(p.createdAt)")
    print("7-verb progress:")
    for verb in Verb.allCases {
        let mark: String
        switch p.state(of: verb) {
        case .done:     mark = "[x] done (measured)"
        case .current:  mark = "[>] current"
        case .visited:  mark = "[~] visited (unmeasured)"
        case .upcoming: mark = "[ ] upcoming"
        }
        print("  \(verb.rawValue + 1). \(verb.koreanLabel) (\(verb.plain))  \(mark)")
    }
    return 0
}

/// Show a domain's ingredient-shelf options per verb — parsed from
/// the §6 section of domains/<domain>.md via the SAME IngredientShelf
/// the cockpit ② work zone uses (@D g_ssot_single_source).
func listShelf(_ domain: String) -> Int32 {
    print("ingredient shelf — domain '\(domain)' (\(DomainCatalog.domain(for: domain).label)):")
    var any = false
    for verb in Verb.allCases {
        let groups = IngredientShelf.groups(domain: domain, verb: verb)
        guard !groups.isEmpty else { continue }
        any = true
        print("  \(verb.rawValue + 1). \(verb.koreanLabel):")
        for g in groups {
            let tag = g.multiSelect ? " (multi)" : ""
            print("       \(g.title)\(tag) = \(g.options.joined(separator: " / "))")
        }
    }
    if !any {
        print("  (no §6 design-options section — domains/\(domain).md absent or mapless)")
    }
    return 0
}

/// Map a CLI verb string (English short-name or Korean canonical) to a
/// Verb enum value. `synth` / `measure` are accepted aliases for
/// `synthesize` / `verify` per rfc_011 §6.3's named action set.
func parseVerbArg(_ s: String) -> Verb? {
    switch s.lowercased() {
    case "specify", "명세":             return .specify
    case "structure", "구조":            return .structure
    case "design", "설계":               return .design
    case "analyze", "해석", "해석⟲":     return .analyze
    case "synthesize", "synth", "합성":  return .synthesize
    case "verify", "measure", "검증", "측정": return .verify
    case "handoff", "인계":              return .handoff
    default: return nil
    }
}

/// `demiurge action <verb> [domain]` — dispatch a θ-2 action through
/// the SAME ActionDispatch the cockpit's "▶ 실제로 돌리기" button uses
/// (@D g_ssot_single_source / D50 — CLI↔cockpit byte-identical).
/// κ-29: when a real engine tool exists for (verb, domain), we route
/// to IT (record-producing); otherwise honest-gap via claude CLI (g3).
/// Wired engine tools: component+synthesize · chip+verify ·
/// chip+synthesize (yosys.hexa dispatcher · rfc_006 §5 gate OPEN) ·
/// matter+analyze · sscb+analyze · grid+structure (NetworkX IEEE 14-bus
/// · κ-36 / D57 — second cohort producer · GATE_CLOSED_MEASURED honest
/// since graph metrics are mathematical facts, absorbed=false).
func cliAction(_ verbStr: String, _ domainArg: String?,
               _ producerArg: String? = nil) -> Int32 {
    guard let verb = parseVerbArg(verbStr) else {
        FileHandle.standardError.write(
            Data(("action: unknown verb '\(verbStr)' — try one of "
                  + "specify/structure/design/analyze/synthesize/verify/handoff\n").utf8))
        return 2
    }
    // Domain hint — caller may pass it explicitly; else default to a
    // "general" cohort that hits the claude-CLI honest-gap path.
    let domain = domainArg ?? "general"
    let context = "CLI-invoked action — domain=\(domain)."
    let producerNote = producerArg.map { " · producer=\($0)" } ?? ""
    print("action: \(verb.koreanLabel) (\(verb.plain)) · domain=\(domain)\(producerNote) — dispatching…")
    let result = ActionDispatch.runEngineTool(
        verb: verb, domain: domain, context: context,
        producer: producerArg)
    print(result.text)
    print("---")
    if result.newRecordIDs.isEmpty {
        if result.usedEngineTool, result.engineToolSucceeded == false {
            print("⏳ engine tool gap — no new measured record (g3).")
        } else {
            print("⏳ no new measured record — this stage has not been measured (g3).")
        }
    } else {
        print("📸 new record ID(s): \(result.newRecordIDs.joined(separator: ", "))")
    }
    return result.engineToolSucceeded == false ? 1 : 0
}

/// Resolve a CLI arg to a record — try it as a relative exports/ path
/// first, then as a recordId via ArtifactRegistry (same DemiurgeCore
/// loaders the cockpit uses — @D g_ssot_single_source).
func resolveRecord(_ arg: String) -> Result<F1F2Record, RecordLoaderError> {
    let byPath = RecordLoader.load(relativePath: arg)
    if case .success = byPath { return byPath }
    for stub in ArtifactRegistry.loadF1F2() {
        let r = RecordLoader.load(relativePath: stub.path)
        if case .success(let rec) = r, rec.recordId == arg { return r }
    }
    return byPath
}

/// `list-gates` — every F1F2 record grouped by measurement_gate.
func listGates() -> Int32 {
    var byGate: [F1F2Record.MeasurementGate: [(String, Bool, String)]] = [:]
    for stub in ArtifactRegistry.loadF1F2() {
        guard case .success(let r) = RecordLoader.load(relativePath: stub.path) else { continue }
        byGate[r.provenance.measurementGate, default: []]
            .append((r.recordId, r.provenance.absorbed, stub.title))
    }
    for gate in F1F2Record.MeasurementGate.allCases {
        let rows = byGate[gate] ?? []
        print("\(gate.displayLabel) (\(rows.count)):")
        for (rid, absorbed, title) in rows {
            print("  \(rid)  absorbed=\(absorbed)  \(title)")
        }
    }
    return 0
}

/// `gate-summary` — one-screen gate + absorbed totals.
func gateSummary() -> Int32 {
    var counts: [F1F2Record.MeasurementGate: Int] = [:]
    var total = 0, absorbedTrue = 0, absorbedFalse = 0
    for stub in ArtifactRegistry.loadF1F2() {
        guard case .success(let r) = RecordLoader.load(relativePath: stub.path) else { continue }
        total += 1
        counts[r.provenance.measurementGate, default: 0] += 1
        if r.provenance.absorbed { absorbedTrue += 1 } else { absorbedFalse += 1 }
    }
    print("total records: \(total)")
    for gate in F1F2Record.MeasurementGate.allCases {
        let n = counts[gate] ?? 0
        let pct = total > 0 ? Double(n) / Double(total) * 100 : 0
        let label = gate.displayLabel
        let pad = String(repeating: " ", count: max(0, 22 - label.count))
        print("  \(label)\(pad)\(n)  (\(String(format: "%.1f", pct))%)")
    }
    print("absorbed=true:  \(absorbedTrue)")
    print("absorbed=false: \(absorbedFalse)")
    return 0
}

/// `compose <domain>` — resolve a domain into its constituent
/// (prerequisite) domain stack + cluster union + kind (CLI+COCKPIT
/// M15). 선행도메인 = 구성도메인 (M0_operate.md §8). Shares the SAME
/// `DomainComposer` the cockpit NewProject wizard + 7-verb dispatch
/// use (D50). Read-only.
func compose(_ domainArg: String) -> Int32 {
    let c = DomainComposer.resolve(domainArg)
    let start = DomainCatalog.domain(for: domainArg)
    let combinedTag = c.crossesDiscipline ? " · 결합(cross-discipline)" : ""
    print("compose \(c.start) — \(start.label) · \(c.kind.rawValue)\(combinedTag)")
    print("  구성 도메인 (topo foundation→apex · \(c.stack.count)):")
    print("    " + (c.ids.isEmpty ? "(none)" : c.ids.joined(separator: " → ")))
    print("  cluster union: "
          + c.clusterUnion.map { $0.rawValue }.joined(separator: " · "))
    if !c.substrateSSOTs.isEmpty {
        print("  substrate SSOT: " + c.substrateSSOTs.joined(separator: " · "))
    }
    return 0
}

/// `project advance|retreat <name>` — move a project's 7-verb pointer
/// (CLI+COCKPIT M15 verb-nav · CLI side, mirrors the cockpit stepper).
/// Conversation-default progress (D48): the pointer moves, but a stage
/// turns ✅ only via a measured run (g3). Writes the SAME ProjectStore
/// manifest the cockpit reads (D50 byte-identical).
func projectStep(_ direction: String, _ name: String) -> Int32 {
    let projects = ProjectStore.loadAll()
    guard var p = projects.first(where: { $0.name == name }) else {
        FileHandle.standardError.write(Data("project: no project named '\(name)'\n".utf8))
        return 2
    }
    switch direction {
    case "advance":
        guard p.canAdvance else {
            print("project '\(name)' 이미 마지막 단계 (\(p.currentVerb.koreanLabel))")
            return 0
        }
        p.advance()
    case "retreat":
        guard p.canRetreat else {
            print("project '\(name)' 이미 첫 단계 (\(p.currentVerb.koreanLabel))")
            return 0
        }
        p.retreat()
    default:
        FileHandle.standardError.write(
            Data("project: unknown direction '\(direction)' — use advance | retreat\n".utf8))
        return 2
    }
    do { try ProjectStore.save(p) } catch {
        FileHandle.standardError.write(Data("project: save failed — \(error)\n".utf8))
        return 1
    }
    print("project '\(name)' → \(p.currentVerb.rawValue + 1)/7 "
          + "\(p.currentVerb.koreanLabel)(\(p.currentVerb.plain))")
    return 0
}

/// `backend [list|current]` — the compute-backend surface (CLI+COCKPIT
/// M17). Local default + `DEMIURGE_BACKEND` user remote; owner pool
/// hosts (from ~/.pool/pool.json, NOT hardcoded) only in owner mode.
/// Shares `BackendResolver` with the cockpit (D50). Read-only.
func backend(_ args: [String]) -> Int32 {
    let sub = args.first(where: { !$0.hasPrefix("--") }) ?? "list"
    let owner = args.contains("--owner") || OperationRegistry.ownerModeEnabled
    switch sub {
    case "list":
        let active = BackendResolver.active
        for b in BackendResolver.available(ownerMode: owner) {
            let mark = b.id == active.id ? "▶" : " "
            let gate = b.owner ? " 🔒" : ""
            print("\(mark) \(b.id)\(gate)  [\(b.kind.rawValue)]  \(b.label) — \(b.host)")
        }
        if !owner {
            print("(🔒 owner pool hosts hidden — DEMIURGE_OWNER + ~/.pool/pool.json)")
        }
        print("active: \(active.id)  (change via DEMIURGE_BACKEND env)")
        return 0
    case "current":
        let b = BackendResolver.active
        print("active backend: \(b.id) · \(b.label) — \(b.host)")
        return 0
    default:
        FileHandle.standardError.write(
            Data("backend: unknown subcommand '\(sub)' — use list | current\n".utf8))
        return 2
    }
}

/// `operate [list|audit]` — the operability surface (CLI+COCKPIT M14).
/// Reads the SAME `OperationRegistry` manifest the cockpit will render
/// (D50 byte-identical). Owner 사장실 ops show only with `--owner` or
/// `DEMIURGE_OWNER` set — external users never see them (M0 §1 / M20).
func operate(_ args: [String]) -> Int32 {
    let sub = args.first(where: { !$0.hasPrefix("--") }) ?? "list"
    let owner = args.contains("--owner") || OperationRegistry.ownerModeEnabled
    switch sub {
    case "list":
        for tier in OperationTier.allCases {
            let rows = OperationRegistry.visible(ownerMode: owner)
                .filter { $0.tier == tier }
            guard !rows.isEmpty else { continue }
            let label = tier == .product ? "🛒 진열대 (external)" : "🔒 사장실 (owner)"
            print("\(label) — \(rows.count):")
            for o in rows {
                let verb = o.verb?.canonical ?? "—"
                print("  \(o.reach.glyph) \(o.id)  [\(o.target.rawValue) · \(verb) · \(o.milestone)]  \(o.title)")
            }
            print("")
        }
        if !owner {
            print("(🔒 owner ops hidden — set DEMIURGE_OWNER or pass --owner)")
        }
        return 0
    case "audit":
        let a = OperabilityAudit.run()
        print("operability audit (CLI+COCKPIT M21):")
        print("  product: \(a.productOK) ✅ · \(a.productPartial) 🔶 · \(a.productBlocked) ❌  (of \(a.productTotal))")
        print("  owner:   \(a.ownerTotal) 🔒 (env-gated)")
        if a.productComplete {
            print("  verdict: ✅ external operability COMPLETE — @goal met")
            return 0
        }
        let pend = OperationRegistry.all
            .filter { $0.tier == .product && $0.reach != .ok }
            .map { "\($0.id)(\($0.milestone))" }
            .joined(separator: ", ")
        print("  verdict: ⏳ pending — \(pend)")
        return 1
    default:
        FileHandle.standardError.write(
            Data("operate: unknown subcommand '\(sub)' — use list | audit\n".utf8))
        return 2
    }
}

/// `verify --expr|--fence|rubric ...` — forward to the hexa stdlib
/// verify kernel (CLI+COCKPIT M16) and print the verdict VERBATIM
/// (@D g5 — demiurge never re-judges; the stdlib SSOT owns the verdict,
/// demiurge owns only the dispatch). `hexa` = hx dependency (M18).
func verifyHexa(_ passthrough: [String]) -> Int32 {
    let r = HexaBridge.verify(passthrough)
    print(r.text, terminator: r.text.hasSuffix("\n") ? "" : "\n")
    return r.ran ? r.exitCode : 127
}

/// `atlas <verb> [args]` — read the hexa atlas SSOT (CLI+COCKPIT M16,
/// atlas-lookup op). READ verbs (lookup/stats/hash/dump) forward to
/// `hexa atlas` VERBATIM via HexaBridge. WRITE verbs (register/
/// append-witness/pr) are the OWNER atlas-register op (사장실 · M20) —
/// refused here so external users get read-only atlas (M0_operate.md §1).
func atlasCmd(_ args: [String]) -> Int32 {
    let readVerbs: Set<String> = ["lookup", "stats", "hash", "dump"]
    let verb = args.first ?? "stats"
    guard readVerbs.contains(verb) else {
        FileHandle.standardError.write(Data(
            ("atlas: '\(verb)' is not a read verb. External read = "
             + "lookup / stats / hash / dump (M16). Write "
             + "(register/append-witness/pr) = owner op 사장실 · M20 "
             + "(아직 미노출).\n").utf8))
        return 2
    }
    let r = HexaBridge.run(["atlas"] + args)
    print(r.text, terminator: r.text.hasSuffix("\n") ? "" : "\n")
    return r.ran ? r.exitCode : 127
}

/// `verify <path|id>` — provenance completeness + claim/gate
/// consistency (rfc_002 §4 + rfc_011 §4.2). exit 0 = consistent.
func verifyRecord(_ arg: String) -> Int32 {
    let result = resolveRecord(arg)
    guard case .success(let r) = result else {
        if case .failure(let e) = result {
            FileHandle.standardError.write(
                Data("verify: \(e.errorDescription ?? "load failed")\n".utf8))
        }
        return 1
    }
    var ok = true
    func check(_ name: String, _ pass: Bool, _ detail: String = "") {
        let tag = pass ? "[OK]  " : "[FAIL]"
        print("\(tag) \(name)\(detail.isEmpty ? "" : " — \(detail)")")
        if !pass { ok = false }
    }
    let p = r.provenance
    check("recordId", !r.recordId.isEmpty)
    check("provenance.simEngine non-empty", !p.simEngine.isEmpty)
    check("provenance.simCommitHash non-empty", !p.simCommitHash.isEmpty)
    check("provenance.consumerTarget non-empty", !p.consumerTarget.isEmpty)
    check("provenance.atlasCiteBlock non-empty", !p.atlasCiteBlock.isEmpty)
    let claimText = "\(r.verdict.f1) \(r.verdict.f2) \(r.verdict.rationale)".lowercased()
    let markers = ["absorbed", "parity", "측정완료", "gate_closed", "검증완료"]
    let claims = markers.contains { claimText.contains($0) }
    let measured = (p.measurementGate == .bPinnedMet || p.measurementGate == .closedMeasured)
    check("verdict claim vs gate consistent",
          !(claims && !measured),
          claims && !measured
            ? "verdict asserts a measurement but gate = \(p.measurementGate.displayLabel)"
            : "")
    if !ok {
        FileHandle.standardError.write(
            Data("verify: REJECTED — record inconsistent (rfc_011 §4.2 / @F f6)\n".utf8))
    }
    return ok ? 0 : 1
}

/// `emit-component` — the demiurge procedural component producer.
/// Now delegates to DemiurgeCore.ComponentEmitter so that this CLI
/// subcommand and `action synthesize` for a component project share
/// ONE writer (D50 — CLI↔cockpit byte-identical). HONEST (g3):
/// producer = demiurge_procedural_placeholder, GATE_OPEN,
/// absorbed=false.
func emitComponent() -> Int32 {
    let r = ComponentEmitter.emitBundled()
    print(r.text)
    return r.ok ? 0 : 1
}

/// `export-component <format> [path]` — write the bundled geometry to
/// a chosen path/format. Shares the SAME DemiurgeCore exporters the
/// cockpit export menu uses (@D g_ssot_single_source / D50).
func exportComponent(_ formatArg: String, _ pathArg: String?) -> Int32 {
    let geometry = ComponentGeometry.bipv5Layer
    let fmt = formatArg.lowercased()
    let body: String
    let ext: String
    switch fmt {
    case "usda", "usd": body = USDExporter.usda(geometry); ext = "usda"
    case "stl":         body = STLExporter.stl(geometry);   ext = "stl"
    default:
        FileHandle.standardError.write(
            Data(("export-component: unknown format '\(formatArg)' — "
                  + "use usda | stl  (usdz: emit-component packages it)\n").utf8))
        return 2
    }
    let outURL = URL(fileURLWithPath:
        pathArg ?? "\(geometry.id).\(ext)")
    do {
        try body.write(to: outURL, atomically: true, encoding: .utf8)
    } catch {
        FileHandle.standardError.write(
            Data("export-component: write failed — \(error)\n".utf8))
        return 1
    }
    print("export-component: wrote \(outURL.path) (\(ext))")
    print("   procedural placeholder geometry — GATE_OPEN (g3)")
    return 0
}

let args = CommandLine.arguments

guard args.count >= 2 else {
    usage()
    exit(0)
}

let exitCode: Int32
switch args[1] {
case "--version", "-v":
    printVersion()
    exitCode = 0
case "--help", "-h":
    usage()
    exitCode = 0
case "list-all":
    exitCode = listAll()
case "list-records":
    exitCode = list(kind: .f1f2)
case "list-decisions":
    exitCode = list(kind: .decision)
case "list-rfcs":
    exitCode = list(kind: .rfc)
case "list-domains":
    exitCode = list(kind: .domain)
case "show":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("show: missing <path> argument\n".utf8))
        usage()
        exit(2)
    }
    exitCode = show(args[2])
case "list-projects":
    exitCode = listProjects()
case "show-project":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("show-project: missing <name> argument\n".utf8))
        usage()
        exit(2)
    }
    exitCode = showProject(args[2])
case "list-shelf":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("list-shelf: missing <domain> argument\n".utf8))
        usage()
        exit(2)
    }
    exitCode = listShelf(args[2])
case "action":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("action: missing <verb> argument\n".utf8))
        usage()
        exit(2)
    }
    // Parse optional `--producer <name>` flag for cells with
    // ProducerRegistry alternatives (e.g. cern + analyze →
    // xsuite-tracking | pylhe).
    var actionArgs = Array(args.dropFirst(2))
    var producerArg: String? = nil
    if let pIdx = actionArgs.firstIndex(of: "--producer"),
       pIdx + 1 < actionArgs.count {
        producerArg = actionArgs[pIdx + 1]
        actionArgs.remove(at: pIdx + 1)
        actionArgs.remove(at: pIdx)
    }
    let cliVerb = actionArgs.first ?? ""
    let cliDomain = actionArgs.count >= 2 ? actionArgs[1] : nil
    exitCode = cliAction(cliVerb, cliDomain, producerArg)
case "list-gates":
    exitCode = listGates()
case "gate-summary":
    exitCode = gateSummary()
case "operate":
    exitCode = operate(Array(args.dropFirst(2)))
case "backend":
    exitCode = backend(Array(args.dropFirst(2)))
case "project":
    guard args.count >= 4 else {
        FileHandle.standardError.write(Data("project: usage — project <advance|retreat> <name>\n".utf8))
        usage()
        exit(2)
    }
    exitCode = projectStep(args[2], args[3])
case "compose":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("compose: missing <domain> argument\n".utf8))
        usage()
        exit(2)
    }
    exitCode = compose(args[2])
case "verify":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("verify: missing <path|id> argument\n".utf8))
        usage()
        exit(2)
    }
    // M16 — hexa stdlib verify kernel (5-tier). `--expr` / `--fence` /
    // `rubric` forward to `hexa verify` (verdict VERBATIM, @D g5); a
    // bare <path|id> stays the local record-consistency check.
    switch args[2] {
    case "--expr", "--fence", "rubric":
        exitCode = verifyHexa(Array(args.dropFirst(2)))
    default:
        exitCode = verifyRecord(args[2])
    }
case "atlas":
    exitCode = atlasCmd(Array(args.dropFirst(2)))
case "emit-component":
    exitCode = emitComponent()
case "export-component":
    guard args.count >= 3 else {
        FileHandle.standardError.write(Data("export-component: missing <format> argument (usda|stl)\n".utf8))
        usage()
        exit(2)
    }
    exitCode = exportComponent(args[2], args.count >= 4 ? args[3] : nil)
default:
    FileHandle.standardError.write(Data("unknown subcommand: \(args[1])\n".utf8))
    usage()
    exit(2)
}

exit(exitCode)
