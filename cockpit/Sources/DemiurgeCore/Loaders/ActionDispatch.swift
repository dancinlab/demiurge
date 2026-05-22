// ActionDispatch — the shared θ-2 / chat backend (rfc_011 §6, D49).
//
// cockpit's chat + "▶ 실제로 돌리기" action AND DemiurgeCLI's action
// subcommand both go through the same three functions here, so the
// action prompt, the record-ID parser, and the claude-CLI invocation
// are byte-identical across both surfaces (@D g_ssot_single_source /
// D50 — CLI ↔ cockpit 멱등성).
//
// κ-29: adds `runEngineTool(verb:, domain:)` — when a real demiurge
// engine tool exists for the (verb, domain) cell, the dispatcher calls
// IT (record-producing, deterministic) instead of the claude-CLI LLM
// fallback.
//
// κ-30 (this commit, D53): adds `matter + analyze` → MatterAnalyzer.
// κ-34 (D55): adds `sscb + analyze` → SSCBProducer (ngspice 46 transient).
// κ-35 (D59): adds `energy + analyze` → EnergyAnalyzeProducer
//             (pvlib clear-sky + CEC SAPM, 4th cohort producer).
// (cohort round, no standalone PLAN κ / D-block — post-merge
//  reconstructed): adds `antimatter + analyze` → AntimatterAnalyzeProducer
//             (particle / PDG live-data lookup, 5th cohort producer;
//             FIRST D61-compliant-from-birth producer — script SSOT in
//             ~/core/hexa-lang/stdlib/antimatter/pdg_lookup.py, never
//             in cockpit/scripts/).
// κ-38 (D65): adds `cern + verify` → CernVerifyProducer (particle +
//             Bethe-Bloch analytic, 6th cohort cell and FIRST verify-
//             verb cell in the cohort domains; D61-compliant — script
//             SSOT in ~/core/hexa-lang/stdlib/cern/bethe_bloch_stopping.py).
// κ-39 (D66): adds `component + verify` → ComponentVerifyProducer
//             (gmsh + scikit-fem FEM on a Si die proxy box, 7th
//             measurable-only cell; D61-compliant — script SSOT in
//             ~/core/hexa-lang/stdlib/component/gmsh_skfem.py).
// κ-43 (D70): rewires `chip + verify` → sweep_oracle_parity.hexa, the
//             §B+§D oracle-parity orchestrator. `hexa build` → native
//             binary spawn; 12/12 acceptance rows GREEN flips
//             measurement_gate to GATE_CLOSED_MEASURED + absorbed=true.
//             FIRST chip-domain dynamic-measurement absorption (vs
//             chip+analyze's static Leighton analytic). Compute SSOT
//             in ~/core/hexa-lang/stdlib/booksim/.
//
// Currently wired:
//   • component + synthesize → ComponentEmitter.emitBundled
//                              (FreeCAD parametric per κ-33 / D54)
//   • chip      + verify     → sweep_oracle_parity.hexa orchestrator
//                              (κ-43 / D70 — hexa build + native
//                               binary spawn; 12/12 §B+§D GREEN →
//                               GATE_CLOSED_MEASURED, absorbed=true)
//   • chip      + synthesize → yosys.hexa selftest sniffer
//                              (κ-31 · D53 measurable-cell mapping ·
//                               rfc_006 §5 gate OPEN — no absorbed
//                               claim, gate stays open until SKY130
//                               area-oracle is met within ±5 %)
//   • matter    + analyze    → hexa-matter verify/run_all.hexa sweep
//                              (honest-gap if hexa-matter SSOT missing
//                               or commit hash not capturable — D17:
//                               hexa-matter is owner, demiurge consumer)
//   • sscb      + analyze    → ngspice 46 transient producer (κ-34 /
//                              D55 — FIRST cohort domain crossing the
//                              measuring-producer threshold; real
//                              numbers, plausible-not-absorbed circuit,
//                              GATE_OPEN永구 / absorbed=false ALWAYS)
//   • energy    + analyze    → pvlib clear-sky + CEC SAPM producer
//                              (κ-35 / D59 — 4th cohort domain, FIRST
//                              renewable-energy cell; real NREL SAM-
//                              verified algorithm output but ZERO sky-
//                              measured data → clear-sky upper bound,
//                              GATE_OPEN영구 / absorbed=false ALWAYS)
//   • antimatter+ analyze    → particle (scikit-hep) PDG live-data
//                              lookup (cohort round, no standalone PLAN
//                              κ / D-block — post-merge reconstructed;
//                              5th cohort domain,
//                              FIRST particle-physics cell AND FIRST
//                              D61-compliant-from-birth producer
//                              (script SSOT in hexa-lang/stdlib/);
//                              real PDG measured constants but COPIED
//                              from PDG aggregator, NOT demiurge
//                              experiment → GATE_OPEN영구 /
//                              absorbed=false ALWAYS)
//
// Honesty (g3, @F f6): the action prompt instructs the agent to
// report "no engine tool" plainly when none is available, and never
// to claim a measurement without a backing exports/ record. The
// cockpit's REJECTED guard (rfc_011 §4.2 — overclaims/) is an
// independent second line of defense.

import Foundation

/// One θ-2 action dispatch outcome — what to show the user and
/// whether a new record was produced. The cockpit + CLI both render
/// this the same way (D50 byte-identical).
public struct ActionResult: Sendable {
    /// The body text — engine-tool stdout or claude-CLI reply.
    public let text: String
    /// New F1F2 / component record IDs produced by this dispatch.
    public let newRecordIDs: [String]
    /// Did we route to a real engine tool (true) or fall back to the
    /// claude-CLI LLM honest-gap path (false)?
    public let usedEngineTool: Bool
    /// If we routed to a real tool, did it succeed? `nil` for the
    /// LLM-fallback path (success is text-only, not record-backed).
    public let engineToolSucceeded: Bool?

    public init(text: String, newRecordIDs: [String],
                usedEngineTool: Bool, engineToolSucceeded: Bool?) {
        self.text = text
        self.newRecordIDs = newRecordIDs
        self.usedEngineTool = usedEngineTool
        self.engineToolSucceeded = engineToolSucceeded
    }
}

public enum ActionDispatch {

    /// rfc_011 §6.3 action prompt for a verb — instructs the agent to
    /// check for a real engine tool / existing measured record and
    /// report honestly (g3 / @F f6). Identical across cockpit + CLI.
    public static func actionPrompt(verb: Verb) -> String {
        return "The user clicked '실제로 돌리기' (run for real) on the "
            + "\(verb.canonical) stage of a demiurge project. Check "
            + "whether demiurge has a real engine tool for this stage "
            + "and whether any measured record exists under exports/**. "
            + "If a tool is available, describe how it would run. If "
            + "NOT, state plainly in Korean that there is no engine "
            + "tool yet — do NOT claim anything was measured or "
            + "verified (g3 — no over-claim). Never assert ✅ / 측정완료 "
            + "without a backing exports/ record ID."
    }

    /// Best-effort extraction of F1F2 record IDs from agent output —
    /// rfc_011 §6.3 "output piped + parsed for new record IDs".
    public static func parseRecordIDs(_ text: String) -> [String] {
        let pattern = "F1F2[-_][A-Za-z0-9._-]+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return []
        }
        let range = NSRange(text.startIndex..., in: text)
        let ids = regex.matches(in: text, range: range).compactMap {
            Range($0.range, in: text).map { String(text[$0]) }
        }
        return Array(Set(ids)).sorted()
    }

    /// κ-29 — main dispatch entry. Routes (verb, domain) to a real
    /// demiurge engine tool when one exists; otherwise falls back to
    /// `askClaude` (LLM honest-gap path). Used by both cockpit's
    /// "▶ 실제로 돌리기" button and `DemiurgeCLI action <verb>`.
    public static func runEngineTool(verb: Verb, domain: String,
                                     context: String,
                                     producer: String? = nil) -> ActionResult {
        // ProducerRegistry takes priority for cells with alternatives
        // (cern + analyze has pylhe vs xsuite-tracking — default
        // xsuite-tracking per the 2026-05-20 user gate).
        let cellKey = ProducerCellKey(verb: verb, domain: domain)
        if let entry = ProducerRegistry.entries[cellKey] {
            if let variant = entry.pick(producer) {
                return variant.run()
            }
            // Requested variant not registered — honest fail rather
            // than silently falling back.
            return ActionResult(
                text: "unknown producer '\(producer ?? "?")' for "
                    + "\(verb.canonical) + \(domain). Available: "
                    + entry.variants.keys.sorted().joined(separator: ", "),
                newRecordIDs: [],
                usedEngineTool: false,
                engineToolSucceeded: false)
        }
        switch (verb, domain) {
        case (.synthesize, "component"):
            // D111 Phase C cern+component migration (2026-05-22) —
            // (.synthesize, "component") deliberately STAYS on the legacy
            // ComponentEmitter / FreeCADBIPVProducer path (D54 / D114
            // Phase C BIPV substrate). cellrun.hexa documents the cell
            // in domains/component.demi but never executes it because
            // this explicit case wins. ComponentEmitter is preserved per
            // task safety constraint + driven by DemiurgeCLI emit-component
            // subcommand. R3: typed ComponentRecord stays.
            return runComponentSynthesize()
        // sscb cells (D111 Phase B · all 7 verbs) — removed in D111 Phase
        // C generalization (2026-05-22). All sscb (verb) routes through
        // the generic `default → CellrunDispatch.run(...)` arm below;
        // explicit cases were behaviorally identical (same call) and only
        // added per-domain hardcoding noise. Manifest: domains/sscb.demi.
        //
        // bot / scope / energy / matter / grid / brain (6-domain bundle ·
        // D111 Phase C · 2026-05-22) — removed in this commit alongside
        // firmware reference pattern (PR #9). All (verb) tuples for these
        // 6 domains route via the generic `default → CellrunDispatch.run`
        // arm below. Manifests: domains/{bot,scope,energy,matter,grid,
        // brain}.demi. Substrate SSOT: ~/core/hexa-lang/stdlib/<domain>/
        // (where present — see manifest scope_caveats for unwired cells).
        // matter is the special case: NO stdlib/matter/ dir exists in
        // hexa-lang (sibling-repo D17 — ~/core/hexa-matter owns the
        // materials toolkit); all 7 matter cells honest-skip rc=2 until
        // either a shim adapter lands under stdlib/matter/<verb>.py or
        // cellrun.hexa learns a sibling-repo substrate kind.
        // Typed records preserved at Models/<Domain>*Record.swift (R3).
        // EnergyVerifyProducer.swift preserved — PilotProducerWireTests
        // consumes its `injectHexaNativeParity` static (PILOTS.demi pilot-
        // solar wire, not legacy-bridge). All other producers in this
        // 6-domain set deleted in this commit.
        // cern verify/synthesize cells — removed in D111 Phase C
        // cern+component migration (2026-05-22). Both routes go through
        // the generic `default → CellrunDispatch.run(...)` arm below.
        // Manifest: domains/cern.demi. Substrate SSOT:
        // ~/core/hexa-lang/stdlib/cern/{bethe_bloch_stopping,xsuite_optics}.py.
        // (.analyze, "cern") — handled by ProducerRegistry (D74)
        // alternatives pattern. ProducerRegistry early-returns BEFORE
        // this switch executes, so cellrun default arm not reached for
        // cern+analyze. domains/cern.demi documents the substrate for
        // forward-compat (CLI bypass via CellrunDispatch.runRaw) only.
        // scope (analyze/synthesize/verify) · bot (synthesize) · cases
        // removed in D111 Phase C 6-domain bundle migration · cellrun
        // default arm handles them via domains/{scope,bot}.demi.
        // component verify/analyze cells — removed in D111 Phase C
        // cern+component migration (2026-05-22). Both routes go through
        // the generic `default → CellrunDispatch.run(...)` arm below.
        // Manifest: domains/component.demi. Substrate SSOT:
        // ~/core/hexa-lang/stdlib/component/{gmsh_skfem,calculix}.py.
        // (.synthesize, "component") STAYS hardcoded above (D54 / D114
        // Phase C ComponentEmitter / FreeCADBIPVProducer legacy bridge).
        case (.verify, "material"):
            return runMaterialVerify()
        case (.verify, "bio"):
            return runBioVerify()
        case (.verify, "chem"):
            return runChemVerify()
        // firmware cells (D111 Phase C reference legacy-domain migration ·
        // all 7 verbs) — removed in D111 Phase C generalization
        // (2026-05-22). All firmware (verb) routes through the generic
        // `default → CellrunDispatch.run(...)` arm below; explicit cases
        // were behaviorally identical. Manifest: domains/firmware.demi.
        // Substrate SSOT: ~/core/hexa-lang/stdlib/firmware/<verb>.py.
        default:
            // D111 Phase C generalization (2026-05-22) — 사용자 directive
            // "던지는 도메인마다 모든 과정에 특정 도메인에 맞춘 하드코딩이
            // 없어야 된다" 박제. Any (verb, domain) not in the per-domain
            // hardcoded switch above (which is being retired domain-by-
            // domain via D111 Phase C migrations — sscb · firmware
            // already migrated, ~16 more domains pending) routes through
            // the generic cellrun.hexa dispatcher backed by
            // `domains/<domain>.demi`. Manifest absent → honest-skip
            // rc=2 with explicit gap message. Manifest present → spawn
            // substrate command for the matching cell. NEVER an LLM
            // placeholder reply — that was a silent dishonesty path
            // because the user could not tell whether the response was
            // measured or hallucinated (g3 / @F f6).
            return CellrunDispatch.run(verb: verb, domain: domain)
        }
    }

    /// `component + synthesize` engine tool — emits the bundled BIPV
    /// procedural geometry to `exports/component/geometry/`. Same path
    /// as `DemiurgeCLI emit-component` (both call ComponentEmitter).
    /// Result: GATE_OPEN / absorbed=false (geometry, not a measured
    /// verdict — g3).
    private static func runComponentSynthesize() -> ActionResult {
        let r = ComponentEmitter.emitBundled()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    // `runMatterAnalyze()` (κ-30/D53), `runEnergyAnalyze()` (κ-35/D59),
    // `runEnergySynthesize()` — removed in D111 Phase C 6-domain bundle
    // migration (2026-05-22). All matter / energy cells route via the
    // generic `default → CellrunDispatch.run(...)` arm. Manifests:
    // domains/matter.demi (sibling-repo SSOT ~/core/hexa-matter — all 7
    // cells honest-skip rc=2 until adapter shim lands under stdlib/matter/),
    // domains/energy.demi (stdlib/energy/pvlib_clearsky.py · pypsa_capacity.py
    // · openmc_keff.py — analyze · synthesize · verify wired). MatterAnalyzer.swift
    // + EnergyAnalyzeProducer.swift + EnergySynthProducer.swift deleted.
    // EnergyVerifyProducer.swift PRESERVED — PilotProducerWireTests consumes
    // its `injectHexaNativeParity` static (PILOTS.demi pilot-solar wire,
    // not legacy bridge). Models/<Domain>Record.swift preserved (R3).

    // `runSSCBAnalyze()` — removed in D111 Phase C generalization
    // (2026-05-22). Was dead code even before sscb case removal because
    // (.analyze, "sscb") already routed via CellrunDispatch directly,
    // not via this static. SSCBProducer.swift (and the κ-34/D55 ngspice
    // legacy path) remains in tree as historical reference until
    // exports-roundtrip parity gate lands.

    /// `cern + verify` engine tool (κ-38 / D65) — spawn the Bethe-Bloch
    /// antiproton stopping-power producer via
    /// `~/core/hexa-lang/stdlib/cern/bethe_bloch_stopping.py` and persist
    /// a typed `CernRecord` under `exports/cern/stopping/<stamp>/`.
    /// Producer = `particle@<v> + Bethe-Bloch analytic (no Geant4 MC)`.
    /// SIXTH cohort cell crossing the measuring-producer threshold and
    /// the FIRST `verify`-verb cell in the cohort domains. The PDG
    /// constants + Bethe-Bloch formula ARE real measured-physics, but
    /// this slice omits four pieces vs full Geant4 MC (shell corrections,
    /// density effect, straggling, nuclear stopping) — so
    /// measurement_gate stays GATE_OPEN AND absorbed is permanently
    /// false (g3 — see CernVerifyProducer scope_caveats; Stage 4
    /// absorbed=true requires hexa-native re-derivation + Geant4 MC
    /// parity per ABSORPTION.md §"hexa 포팅 단계").
    private static func runCernVerify() -> ActionResult {
        let r = CernVerifyProducer.runVerify()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `component + verify` engine tool (κ-39 / D66) — spawn the
    /// (gmsh + scikit-fem + meshio + numpy) FEM pipeline via
    /// `~/core/hexa-lang/stdlib/component/gmsh_skfem.py` and persist a
    /// typed `ComponentVerifyRecord` under
    /// `exports/component/verify/<stamp>/`. Producer =
    /// `gmsh@<v> + scikit-fem@<v>`. The SEVENTH measurable-only cell
    /// crossing the engine-tool threshold (after component+synthesize,
    /// chip+verify, chip+synthesize, matter+analyze, sscb+analyze,
    /// energy+analyze, antimatter+analyze, cern+verify) and a
    /// D61-compliant-from-birth producer (script SSOT in hexa-lang/
    /// stdlib/, never in cockpit/scripts/). FIRST package/board/system
    /// engineering verdict cell. PDE solutions ARE real numbers but
    /// the geometry is a TOY box (10×10×2 mm Si die proxy), the
    /// material is textbook silicon, and the load case is single
    /// steady-state — so measurement_gate stays GATE_OPEN AND absorbed
    /// is permanently false (g3 — see scope_caveats).
    private static func runComponentVerify() -> ActionResult {
        let r = ComponentVerifyProducer.runVerify()
        // scan-foreign: surface canonical + foreign bridge record IDs
        // directly (B1+B2 cohort, 2026-05-21).
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordIDs,
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    // `runGridStructure()` (D57), `runBotStructure()` (D58),
    // `runBrainAnalyze()` (cohort), `runScopeAnalyze()` (cohort) —
    // removed in D111 Phase C 6-domain bundle migration (2026-05-22).
    // All grid / bot / brain / scope cells route via the generic
    // `default → CellrunDispatch.run(...)` arm. Manifests: domains/
    // {grid,bot,brain,scope}.demi. Substrate SSOT: hexa-lang stdlib/
    // {grid/networkx_basics.py, bot/urdfpy_basics.py · pinocchio_rbd.py
    // · drake_verify.py, brain/lif_brian2.py, scope/scope_poppy.py ·
    // openmdao_sizing.py · poppy_psf_verify.py}. GridStructureProducer.swift +
    // BotStructureProducer.swift + BrainAnalyzeProducer.swift +
    // ScopeAnalyzeProducer.swift deleted.

    /// `cern + analyze` engine tool (cohort-round producer, no standalone
    /// PLAN κ / D-block — post-merge reconstructed) — pylhe LHE
    /// round-trip stats. D61-from-birth (hexa-lang stdlib/cern/lhe_stats.py).
    /// GATE_OPEN / absorbed=false (LHE meta, not detector measurement).
    /// Distinct from `cern + verify` (Bethe-Bloch shielding).
    private static func runCernAnalyze() -> ActionResult {
        let r = CernAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// Invoke `claude -p <guarded>` as a SYNCHRONOUS subprocess and
    /// return the captured stdout. Read-only — `claude -p` (print
    /// mode) without inherited tool permissions cannot modify files
    /// or run builds (g3 / @F f6). The cockpit wraps this in a
    /// Task.detached so the UI thread does not block; the CLI calls
    /// it directly (its main is already off the UI thread).
    public static func askClaude(prompt: String, context: String) -> String {
        let guarded = "[demiurge — answer concisely in Korean, plain "
            + "language; do NOT modify files, run builds, or invoke "
            + "tools. Project context: \(context)] \(prompt)"
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["claude", "-p", guarded]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            let out = (String(data: data, encoding: .utf8) ?? "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if out.isEmpty {
                return "(claude returned no output; exit \(proc.terminationStatus))"
            }
            return out
        } catch {
            return "claude invocation failed: \(error.localizedDescription)\n"
                + "(`claude` must be on PATH)"
        }
    }

    // `runSSCBSynth()` + `runSSCBVerify()` — removed in D111 Phase C
    // generalization (2026-05-22). Dead code even before case removal;
    // sscb cells already routed via CellrunDispatch directly. The
    // corresponding SSCBSynthProducer.swift / SSCBVerifyProducer.swift
    // Swift wrappers remain in tree as historical reference until
    // exports-roundtrip parity gate lands.

    // `runBotSynthesize()` (ROI 9 Pinocchio), `runScopeSynthesize()` (ROI 4
    // OpenMDAO aperture), `runScopeVerify()` (ROI 3 POPPY+WebbPSF) — removed
    // in D111 Phase C 6-domain bundle migration (2026-05-22). Routes via
    // generic `default → CellrunDispatch.run(...)`. BotSynthProducer.swift +
    // ScopeSynthProducer.swift + ScopeVerifyProducer.swift deleted.

    /// `component + analyze` engine tool (ROI rank 6 — CalculiX FEA,
    /// independent cited measurement vs component+verify gmsh+skfem).
    /// SSOT = `~/core/hexa-lang/stdlib/component/calculix.py` (D61).
    /// D72: shares mesh primitive with `kernels/fem/skfem_kernel.py`;
    /// `kernels/fem/calculix_kernel.py` extraction at 2nd consumer.
    /// GATE_OPEN / absorbed=false (placeholder die, honest install-
    /// gated skip when ccx missing).
    private static func runComponentAnalyze() -> ActionResult {
        let r = ComponentAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `cern + synthesize` engine tool (ROI rank 7 — Xsuite FODO twiss
    /// + tune fit). SSOT = `~/core/hexa-lang/stdlib/cern/xsuite_optics.py`
    /// (D61). D72: accelerator-optics single-domain; promote to
    /// `kernels/accelerator_optics/` at 2nd consumer. Citations:
    /// arxiv:2310.00317, arxiv:2412.16006. GATE_OPEN / absorbed=false
    /// (textbook FODO, honest skip on Xsuite ImportError).
    private static func runCernSynthesize() -> ActionResult {
        let r = CernSynthProducer.runSynthesize()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    // `runEnergyVerify()` (ROI 12 OpenMC k-eff) + `runBotVerify()` (ROI 13
    // Drake Lyapunov) — static functions removed in D111 Phase C 6-domain
    // bundle migration (2026-05-22). Routes via generic `default →
    // CellrunDispatch.run(...)`. EnergyVerifyProducer.swift PRESERVED —
    // PilotProducerWireTests consumes its `injectHexaNativeParity` static
    // (PILOTS.demi pilot-solar wire, not legacy-bridge runVerify path).
    // BotVerifyProducer.swift deleted.

    /// `material + verify` Tier 1 aggregator (RTSC.md §8.7 — first-
    /// principles synthesis cohort). Spawns the four Tier 1 sub-
    /// producers under `exports/material/verify/<stamp>/{sim_adapter,
    /// cube_producer,hexa_rtsc_crosslink,mp_query}/` and returns the
    /// concatenated record IDs. SSOT scripts under `~/core/hexa-lang/
    /// stdlib/material/*.py` (D61). g3 honest: this dispatcher does
    /// NOT compute a combined absorbed verdict; each sub-producer keeps
    /// its own GATE_OPEN / absorbed=false. Tier 4 falsifier dispatch
    /// (MaterialFalsifierDispatch) is the only path that synthesizes a
    /// verdict.
    private static func runMaterialVerify() -> ActionResult {
        let r = MaterialVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordIDs,
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    // ── firmware domain (D73 · 16th domain) ──
    // D111 Phase C migration (2026-05-22 · first reference legacy-domain
    // migration after SSCB walkthrough): legacy runFirmware*() statics
    // REMOVED · all 7 verbs route via CellrunDispatch + domains/firmware.demi.
    // Substrate SSOT: ~/core/hexa-lang/stdlib/firmware/<verb>.py (D61 · D72
    // adapter-only · reference target QEMU mps2-an385 Cortex-M3 per
    // domains/firmware.md §1). Typed Codable records preserved at
    // Models/Firmware*Record.swift (R3 cockpit consumer side).

    // ── D74 cohort — anima-physics bridge scan-only verify producers ──
    // Architectural distinction from prior verify-cells:
    //   • {brain,bio,chem,grid} + verify SCAN exports/<domain>/verify/
    //     <UTC>Z/anima_*.json — records the anima-physics bridge
    //     (anima/anima-physics/{hw/kuramoto_neuromorphic/src,tool}/
    //      demiurge_<domain>_bridge.py) has ALREADY dropped from
    //     hexa-native substrate runs. Demiurge witnesses + aggregates;
    //     never re-measures (g3 / D17 g_stdlib_ownership).
    //   • brain + verify, grid + verify — D111 Phase C 6-domain bundle
    //     migration (2026-05-22) routes these via generic `default →
    //     CellrunDispatch.run(...)`. Manifests domains/brain.demi +
    //     domains/grid.demi mark them WIRED at stdlib/<domain>/verify.py
    //     (anima-bridge records remain the canonical aggregator surface;
    //     cellrun honest-skip rc=2 until the verify.py shim lands).
    //     BrainVerifyProducer.swift + GridVerifyProducer.swift deleted.
    //   • bio + verify, chem + verify — D116 bio/chem domain migrations
    //     pending (parallel A2 background agent); leave intact for now.

    /// `bio + verify` engine tool (D74) — scan anima-physics hippocampus
    /// + memristor composite bridge records under exports/bio/verify/
    /// <UTC>Z/. GATE_OPEN / absorbed=false ALWAYS (g3 — hexa-lang
    /// reference sim, NOT wet-lab; demiurge witness only).
    private static func runBioVerify() -> ActionResult {
        let r = BioVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `chem + verify` engine tool (D74) — scan anima-physics Langevin
    /// double-well thermodynamic-consciousness bridge records under
    /// exports/chem/verify/<UTC>Z/. GATE_OPEN / absorbed=false ALWAYS
    /// (g3 — consciousness-analog NOT real chemistry, generic
    /// U(x)=(x²-1)² potential; demiurge witness only).
    private static func runChemVerify() -> ActionResult {
        let r = ChemVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }
}
