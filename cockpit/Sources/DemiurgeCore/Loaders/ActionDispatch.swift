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
            return runComponentSynthesize()
        case (.verify, "component"):
            return runComponentVerify()
        case (.verify, "chip"):
            return runChipVerify()
        case (.synthesize, "chip"):
            return runChipSynthesize()
        case (.analyze, "matter"):
            return runMatterAnalyze()
        case (.analyze, "sscb"):
            // D111 Phase B (this commit): route sscb cells through the
            // generic cellrun.hexa dispatcher backed by
            // `domains/sscb.demi`. The legacy `runSSCBAnalyze()` Swift
            // producer is kept under cockpit/Sources/.../SSCBProducer.swift
            // as a Phase C backup until roundtrip verify lands.
            return CellrunDispatch.run(verb: verb, domain: domain)
        case (.analyze, "energy"):
            return runEnergyAnalyze()
        case (.synthesize, "energy"):
            return runEnergySynthesize()
        case (.analyze, "antimatter"):
            return runAntimatterAnalyze()
        case (.analyze, "fusion"):
            return runFusionAnalyze()
        case (.verify, "cern"):
            return runCernVerify()
        case (.analyze, "chip"):
            return runChipAnalyze()
        case (.structure, "grid"):
            return runGridStructure()
        case (.structure, "bot"):
            return runBotStructure()
        case (.analyze, "space"):
            return runSpaceAnalyze()
        case (.analyze, "brain"):
            return runBrainAnalyze()
        case (.analyze, "mobility"):
            return runMobilityAnalyze()
        case (.analyze, "aura"):
            return runAuraAnalyze()
        case (.analyze, "scope"):
            return runScopeAnalyze()
        // (.analyze, "cern") — handled by ProducerRegistry (D74).
        // Kept here as a comment so the switch's domain coverage is
        // still readable; the early-return above means this case is
        // unreachable. runCernAnalyze (pylhe) is still invoked via
        // the `pylhe` variant entry in the registry.
        case (.structure, "sscb"):
            // SSCB walkthrough Step 2 — BOM tree (networkx DiGraph)
            // producer routes through cellrun.hexa generic dispatcher
            // backed by `domains/sscb.demi [cell.structure]`. SSOT:
            // `~/core/hexa-lang/stdlib/sscb/structure.py` (D116). Typed
            // mirror: `SscbStructureRecord` (this commit).
            return CellrunDispatch.run(verb: verb, domain: domain)
        case (.synthesize, "sscb"):
            // D111 Phase B — see (.analyze, "sscb") above.
            return CellrunDispatch.run(verb: verb, domain: domain)
        case (.verify, "sscb"):
            // D111 Phase B — see (.analyze, "sscb") above.
            return CellrunDispatch.run(verb: verb, domain: domain)
        case (.specify, "sscb"):
            // SSCB 7-verb walkthrough Step 1 — 4th wired SSCB cell.
            // Producer: ~/core/hexa-lang/stdlib/sscb/specify.py
            // (template emit transcribing domains/sscb.md §1 HEXA-SSCB
            // mk1 spec). g3: absorbed=false permanently — spec without
            // measurement is illustrative, not absorption.
            return CellrunDispatch.run(verb: verb, domain: domain)
        case (.design, "sscb"):
            // SSCB 7-verb walkthrough Step 3 — 6th wired SSCB cell.
            // Producer: ~/core/hexa-lang/stdlib/sscb/design.py (ngspice
            // netlist + KiCad PCB stub + dossier template emit · sscb.md
            // §2 DESIGN row open-source col · KiCad + ngspice substrate).
            // Typed mirror: `SscbDesignRecord`. g3: absorbed=false
            // permanently — datasheet bindings = placeholder vendor
            // parts (NOT absorbed .lib).
            return CellrunDispatch.run(verb: verb, domain: domain)
        case (.synthesize, "bot"):
            return runBotSynthesize()
        case (.synthesize, "scope"):
            return runScopeSynthesize()
        case (.verify, "scope"):
            return runScopeVerify()
        case (.synthesize, "space"):
            return runSpaceSynthesize()
        case (.analyze, "component"):
            return runComponentAnalyze()
        case (.synthesize, "cern"):
            return runCernSynthesize()
        case (.analyze, "rtsc"):
            return runRtscAnalyze()
        case (.verify, "fusion"):
            return runFusionVerify()
        case (.verify, "energy"):
            return runEnergyVerify()
        case (.verify, "bot"):
            return runBotVerify()
        case (.verify, "space"):
            return runSpaceVerify()
        case (.verify, "rtsc"):
            return runRtscVerify()
        case (.verify, "material"):
            return runMaterialVerify()
        case (.verify, "mobility"):
            return runMobilityVerify()
        case (.verify, "antimatter"):
            return runAntimatterVerify()
        case (.verify, "brain"):
            return runBrainVerify()
        case (.verify, "bio"):
            return runBioVerify()
        case (.verify, "chem"):
            return runChemVerify()
        case (.verify, "grid"):
            return runGridVerify()
        case (.specify, "firmware"):
            return runFirmwareSpecify()
        case (.structure, "firmware"):
            return runFirmwareStructure()
        case (.design, "firmware"):
            return runFirmwareDesign()
        case (.analyze, "firmware"):
            return runFirmwareAnalyze()
        case (.synthesize, "firmware"):
            return runFirmwareSynthesize()
        case (.verify, "firmware"):
            return runFirmwareVerify()
        case (.handoff, "firmware"):
            return runFirmwareHandoff()
        default:
            let prompt = actionPrompt(verb: verb)
            let reply = askClaude(prompt: prompt, context: context)
            return ActionResult(
                text: reply,
                newRecordIDs: parseRecordIDs(reply),
                usedEngineTool: false,
                engineToolSucceeded: nil)
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

    /// `matter + analyze` engine tool (κ-30 / D53) — spawn hexa-matter's
    /// `verify/run_all.hexa` aggregator (the closure-invariant SSOT
    /// sweep) and persist a typed `MatterRecord` under
    /// `exports/matter/parity/`. Producer = `hexa_matter@<commit>` —
    /// demiurge witnesses, hexa-matter measures (D17 — hexa-lang /
    /// hexa-matter own the materials toolkit; Swift never simulates
    /// the substrate). Even on PASS the gate stays GATE_OPEN unless we
    /// captured a real commit hash (honest pinning, g3).
    private static func runMatterAnalyze() -> ActionResult {
        let r = MatterAnalyzer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `sscb + analyze` engine tool (κ-34 / D55) — spawn ngspice 46 via
    /// `cockpit/scripts/sscb_ngspice.py` to run a 600 V / 100 A DC
    /// hard-switching transient (HEXA-SSCB mk1 plausible topology),
    /// then persist a typed `SSCBRecord` under
    /// `exports/sscb/transient/<stamp>/`. Producer = `ngspice@<v>` —
    /// the simulator is the instrument, but the circuit is plausible-
    /// not-absorbed so measurement_gate stays GATE_OPEN AND absorbed
    /// is permanently false (g3 — see SSCBProducer scope_caveats).
    /// FIRST cohort domain (out of 13 in domains/*.md) crossing the
    /// measuring-producer threshold — proves the breadth survey can
    /// turn into real producers, narrow scope is honest g3.
    private static func runSSCBAnalyze() -> ActionResult {
        let r = SSCBProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `energy + analyze` engine tool (κ-35 / D59) — spawn pvlib via
    /// `cockpit/scripts/energy_pvlib.py` to run a 1-year hourly clear-
    /// sky simulation (Phoenix AZ, standard CEC module + inverter),
    /// then persist a typed `EnergyRecord` under
    /// `exports/energy/pv/<stamp>/`. Producer = `pvlib@<v>` — the
    /// library is the instrument, but no sky-measured data was used
    /// so measurement_gate stays GATE_OPEN AND absorbed is permanently
    /// false (g3 — see EnergyAnalyzeProducer scope_caveats). FOURTH
    /// cohort domain crossing the measuring-producer threshold and
    /// the FIRST renewable-energy cell.
    private static func runEnergyAnalyze() -> ActionResult {
        let r = EnergyAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `energy + synthesize` engine tool — spawn the PyPSA + HiGHS
    /// capacity-expansion producer via
    /// `~/core/hexa-lang/stdlib/energy/pypsa_capacity.py` and persist a
    /// typed `EnergySynthRecord` under `exports/energy/synth/<stamp>/`.
    /// Producer = `pypsa@<v> + HiGHS@<v>`. The SECOND energy-domain
    /// producer after `energy + analyze` (pvlib clear-sky), and the
    /// FIRST `synthesize`-verb cell in the energy domain — ROI rank 5
    /// from `inbox/notes/absorption-empty-cells-research-2026-05-20.md`
    /// (⭐⭐⭐⭐⭐ pure pip).
    /// D61-compliant from birth (script SSOT in hexa-lang/stdlib/,
    /// never in cockpit/scripts/). D72 thin domain adapter — PyPSA is
    /// power-system optimization, not FEM/MC/graph; promotes to
    /// `kernels/power_opt/` only if 2nd consumer appears.
    /// LP IS solved to optimality (HiGHS reports termination optimal)
    /// but inputs (capital_cost · demand · CF · topology) are textbook
    /// / synthetic, so measurement_gate stays GATE_OPEN AND absorbed
    /// is permanently false (g3 — see EnergySynthProducer
    /// scope_caveats; citation: PyPSA — Brown·Hörsch·Schlachtberger,
    /// JORS 2018, doi:10.5334/jors.188).
    private static func runEnergySynthesize() -> ActionResult {
        let r = EnergySynthProducer.runSynthesize()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `antimatter + analyze` engine tool (cohort round, no standalone
    /// PLAN κ / D-block — post-merge reconstructed) — spawn the
    /// `particle` (scikit-hep, BSD-3) PDG live-data lookup via
    /// `~/core/hexa-lang/stdlib/antimatter/pdg_lookup.py` and persist
    /// a typed `AntimatterRecord` under
    /// `exports/antimatter/pdg/<stamp>/`. Producer = `particle@<v> (PDG
    /// live-data lookup)`. FIRST cohort domain that ships D61-compliant-
    /// from-birth — the Python script lives in hexa-lang/stdlib/, NEVER
    /// in cockpit/scripts/ (g_demiurge_pointer_only). FIFTH cohort
    /// domain crossing the measuring-producer threshold and the FIRST
    /// particle-physics cell. PDG values ARE real measured constants
    /// but THIS run is not a demiurge measurement — it copies the PDG
    /// aggregator's record, so measurement_gate stays GATE_OPEN AND
    /// absorbed is permanently false (g3 — see scope_caveats).
    private static func runAntimatterAnalyze() -> ActionResult {
        let r = AntimatterAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `fusion + analyze` engine tool (κ-41 / D69) — spawn plasmapy
    /// derived-parameter producer via
    /// `~/core/hexa-lang/stdlib/fusion/plasma_metrics.py` and persist a
    /// typed `FusionRecord` under `exports/fusion/plasma/<stamp>/`.
    /// Producer = `plasmapy@<v> (ITER core reference derivation)`.
    /// SEVENTH cohort cell crossing the measuring-producer threshold
    /// (after sscb κ-34, energy κ-35, antimatter [cohort round], cern
    /// κ-38) and
    /// the FIRST plasma-physics cell. D61-compliant-from-birth — the
    /// Python script lives in hexa-lang/stdlib/, NEVER in cockpit/
    /// scripts/ (g_demiurge_pointer_only). Bohm·Debye·Lorentz algebra
    /// IS real but the inputs (n_e=1e20 · T_e=10 keV · B=5.3 T) are
    /// textbook ITER values, NOT device-measured — so measurement_gate
    /// stays GATE_OPEN AND absorbed is permanently false (g3 — see
    /// FusionAnalyzeProducer scope_caveats; Stage 4 absorbed=true
    /// requires Thomson-scattering / interferometry / magnetic-probe
    /// readings from a real tokamak shot per ABSORPTION.md §"hexa
    /// 포팅 단계").
    private static func runFusionAnalyze() -> ActionResult {
        let r = FusionAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

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

    /// `chip + analyze` engine tool (D56; cohort-round producer, no
    /// standalone PLAN κ entry — post-merge reconstructed) — hexa-native Leighton
    /// booksim oracle (worktree-a8727a55, hexa-lang stdlib). g3 honest:
    /// 측정 결과는 record 로 emit, gate/absorbed flip 은 측정 record 자체에
    /// 인용된 값을 따름 (Producer 코드가 임의로 closure 하지 않음).
    private static func runChipAnalyze() -> ActionResult {
        let r = ChipAnalyzer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `grid + structure` engine tool (D57; cohort-round producer, no
    /// standalone PLAN κ entry — post-merge reconstructed) — NetworkX IEEE 14-bus
    /// topology producer. Script SSOT migrated to hexa-lang/stdlib/grid/
    /// (D61, post-merge migration). GATE_OPEN / absorbed=false (toy
    /// topology, not a measured grid).
    private static func runGridStructure() -> ActionResult {
        let r = GridStructureProducer.runStructure()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `bot + structure` engine tool (D58; cohort-round producer, no
    /// standalone PLAN κ entry — post-merge reconstructed) — yourdfpy URDF parser
    /// over a hermetic 2-link arm. Script migrated to hexa-lang/stdlib/
    /// bot/ (D61, post-merge migration). GATE_OPEN / absorbed=false
    /// (URDF spec meta, not robot hardware measurement).
    private static func runBotStructure() -> ActionResult {
        let r = BotStructureProducer.runStructure()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `space + analyze` engine tool (D60; cohort-round producer, no
    /// standalone PLAN κ entry — post-merge reconstructed) — Skyfield SGP4
    /// propagator on ISS TLE. Script migrated to hexa-lang/stdlib/space/
    /// (D61). GATE_OPEN / absorbed=false (TLE input not a demiurge
    /// measurement, propagator is upstream).
    private static func runSpaceAnalyze() -> ActionResult {
        let r = SpaceAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `brain + analyze` engine tool (cohort-round producer, no standalone
    /// PLAN κ / D-block — post-merge reconstructed) — Brian2 single
    /// LIF spike-rate producer. D61-from-birth (script SSOT in hexa-lang
    /// stdlib/brain/lif_brian2.py). GATE_OPEN / absorbed=false (toy
    /// neuron model).
    private static func runBrainAnalyze() -> ActionResult {
        let r = BrainAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `mobility + analyze` engine tool (cohort-round producer, no standalone
    /// PLAN κ / D-block — post-merge reconstructed) — OSMnx
    /// road-network topology. D61-from-birth (hexa-lang stdlib/mobility/
    /// road_network.py). GATE_OPEN / absorbed=false (OSM topology meta).
    private static func runMobilityAnalyze() -> ActionResult {
        let r = MobilityAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `aura + analyze` engine tool (cohort-round producer, no standalone
    /// PLAN κ / D-block — post-merge reconstructed) — MNE-Python
    /// EEG band-power. D61-from-birth (hexa-lang stdlib/aura/aura_mne.py).
    /// GATE_OPEN / absorbed=false (synthetic input).
    private static func runAuraAnalyze() -> ActionResult {
        let r = AuraAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `scope + analyze` engine tool (cohort-round producer, no standalone
    /// PLAN κ / D-block — post-merge reconstructed) — Poppy optical
    /// PSF. D61-from-birth (hexa-lang stdlib/scope/scope_poppy.py).
    /// GATE_OPEN / absorbed=false (textbook configuration).
    private static func runScopeAnalyze() -> ActionResult {
        let r = ScopeAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

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

    /// `chip + verify` engine tool — try to spawn the local booksim
    /// self-test (rfc_001 §8 / rfc_003 Phase B). On THIS branch, the
    /// local `~/core/hexa-lang/stdlib/booksim/booksim.hexa` ships with
    /// the cmd_measure body as a gate-90 stub (the F1F2-producer body
    /// has not merged into the rfc043 branch yet — see PLAN logs
    /// ①-step2c). The hexa-lang `hexa-arch` CLI entry-point is also
    /// not wired, so `hexa run` cannot pass `--emit <dir>` argv.
    ///
    /// Honest path (g3, D17 — Swift never simulates the chip; that
    /// belongs to hexa-lang): we spawn the self-test, inspect any
    /// newly-written `/tmp/hexa_native_*.json` (mtime check), and if
    /// one appears we copy it into `exports/chip/noc/f1f2/records/`.
    /// If hexa is missing OR no record is produced, report engine-tool
    /// gap honestly — never silent success (g3).
    /// `chip + verify` engine tool (κ-43 / D70; path decided κ-37 / D64)
    /// — spawn the hexa-native
    /// `sweep_oracle_parity.hexa` orchestrator (rfc_001 §8 + rfc_003 §4)
    /// and witness its §B+§D oracle-parity verdict.
    ///
    /// D61 / g_demiurge_pointer_only: ALL compute lives in
    /// `hexa-lang/stdlib/booksim/sweep_oracle_parity.hexa`; this Swift
    /// path only `Process`-spawns `hexa build` then runs the compiled
    /// binary, parses the stdout banner + jsonl, and witnesses the
    /// emitted F1F2Records onto disk. The compiled path is used (not
    /// `hexa run`) because the orchestrator IS the compute — the hexa
    /// interpreter is ~1000× slower on this workload; `hexa build`
    /// transpiles to C → native (κ-43 measurement, 2026-05-20).
    ///
    /// g3: the gate flip to GATE_CLOSED_MEASURED + absorbed=true is
    /// witnessed from the orchestrator's own 12/12 verdict — Swift
    /// never upgrades the claim. If the orchestrator reports < 12/12,
    /// the records carry GATE_B_PINNED_MET and engineToolSucceeded
    /// is false.
    private static func runChipVerify() -> ActionResult {
        let hexaBin = locateHexa()
        guard let hexaPath = hexaBin else {
            return ActionResult(
                text: "⏳ engine tool gap — `hexa` 실행 파일을 PATH 또는 "
                    + "~/core/hexa-lang/hexa 에서 찾지 못했습니다. chip + "
                    + "verify (rfc_001 §8) 는 hexa-lang 의 "
                    + "sweep_oracle_parity.hexa 를 컴파일·실행해야 합니다 "
                    + "(g3 — silent success 금지).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }
        let hexaLangRoot = NSString(string: "~/core/hexa-lang")
            .expandingTildeInPath
        let module = "stdlib/booksim/sweep_oracle_parity.hexa"
        let modulePath = hexaLangRoot + "/" + module
        guard FileManager.default.fileExists(atPath: modulePath) else {
            return ActionResult(
                text: "⏳ engine tool gap — sweep_oracle_parity.hexa 를 "
                    + "찾지 못했습니다 (\(modulePath)). chip + verify 는 "
                    + "hexa-lang stdlib 의 booksim 오케스트레이터를 "
                    + "필요로 합니다 (D61 — SSOT = hexa-lang, g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        // ── 1. hexa build (transpile → C → native) ──
        let build = Process()
        build.executableURL = URL(fileURLWithPath: hexaPath)
        build.arguments = ["build", module]
        build.currentDirectoryURL = URL(fileURLWithPath: hexaLangRoot)
        let buildPipe = Pipe()
        build.standardOutput = buildPipe
        build.standardError = buildPipe
        var buildOut = ""
        do {
            try build.run()
            let data = buildPipe.fileHandleForReading.readDataToEndOfFile()
            build.waitUntilExit()
            buildOut = String(data: data, encoding: .utf8) ?? ""
            if build.terminationStatus != 0 {
                return ActionResult(
                    text: "⏳ engine tool gap — hexa build "
                        + "sweep_oracle_parity.hexa 실패 (exit "
                        + "\(build.terminationStatus)). 측정 record 0 (g3).\n"
                        + lastLinesOf(buildOut, 8),
                    newRecordIDs: [],
                    usedEngineTool: true,
                    engineToolSucceeded: false)
            }
        } catch {
            return ActionResult(
                text: "⏳ engine tool gap — hexa build 실행 실패: "
                    + "\(error.localizedDescription) (g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        // ── 2. run the compiled orchestrator binary ──
        let appPath = hexaLangRoot + "/build/artifacts/app"
        guard FileManager.default.isExecutableFile(atPath: appPath) else {
            return ActionResult(
                text: "⏳ engine tool gap — 컴파일 산출물 \(appPath) 이 "
                    + "없습니다 (hexa build 가 app 을 만들지 못함, g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }
        let run = Process()
        run.executableURL = URL(fileURLWithPath: appPath)
        run.currentDirectoryURL = URL(fileURLWithPath: hexaLangRoot)
        let runPipe = Pipe()
        run.standardOutput = runPipe
        run.standardError = runPipe
        var runOut = ""
        var exitCode: Int32 = -1
        do {
            try run.run()
            let data = runPipe.fileHandleForReading.readDataToEndOfFile()
            run.waitUntilExit()
            exitCode = run.terminationStatus
            runOut = String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ActionResult(
                text: "⏳ engine tool gap — sweep_oracle_parity 바이너리 "
                    + "실행 실패: \(error.localizedDescription) (g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        // exit 91 == Leighton oracle violated — record MUST NOT be
        // emitted (rfc_001 §7.3). Honest hard stop.
        if exitCode == 91 {
            return ActionResult(
                text: "❌ chip + verify — Leighton 오라클 위반 (exit 91). "
                    + "rfc_001 §7.3: record emit 금지 — SIM 이 틀린 것이지 "
                    + "정리(theorem)가 틀린 게 아님 (g3).\n"
                    + lastLinesOf(runOut, 6),
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        // ── 3. parse banner + jsonl, witness records to disk ──
        var bannerLines: [String] = []
        var jsonlLines: [String] = []
        for raw in runOut.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = String(raw)
            if line.hasPrefix("{\"interface\"") {
                jsonlLines.append(line)
            } else if !line.trimmingCharacters(in: .whitespaces).isEmpty {
                bannerLines.append(line)
            }
        }

        var newIDs: [String] = []
        do {
            try FileManager.default.createDirectory(
                at: RecordLoader.f1f2RecordsRoot,
                withIntermediateDirectories: true)
        } catch { /* dir may already exist */ }
        for jl in jsonlLines {
            guard let data = jl.data(using: .utf8),
                  let obj = try? JSONSerialization.jsonObject(with: data)
                      as? [String: Any],
                  let rid = obj["record_id"] as? String
            else { continue }
            let dest = RecordLoader.f1f2RecordsRoot
                .appendingPathComponent("2026-05-20_\(rid).json")
            // Re-serialize pretty so the on-disk record matches the
            // existing exports/chip/noc/f1f2/records/ house style.
            if let pretty = try? JSONSerialization.data(
                    withJSONObject: obj,
                    options: [.prettyPrinted, .sortedKeys]) {
                if (try? pretty.write(to: dest)) != nil {
                    newIDs.append(rid)
                }
            }
        }

        let green = runOut.contains("ACCEPTANCE: 12/12")
            && runOut.contains("gate_state=GATE_CLOSED_MEASURED")
        var lines: [String] = []
        lines.append("hexa build + run sweep_oracle_parity — exit \(exitCode)")
        lines.append(bannerLines.joined(separator: "\n"))
        lines.append("---")
        if green && exitCode == 0 {
            lines.append("✅ chip + verify — §B+§D oracle parity 12/12 GREEN. "
                + "GATE_CLOSED_MEASURED · absorbed=true. "
                + "rfc_001 §8 measurement gate CLOSED — 첫 chip 도메인 "
                + "measured-parity (rfc_003 §4 §B 4행 + §D 6행 + Leighton 2).")
            lines.append("📸 F1F2Record \(newIDs.count)건 → "
                + "exports/chip/noc/f1f2/records/2026-05-20_*.json")
        } else {
            lines.append("🔶 chip + verify — 일부 행만 GREEN "
                + "(< 12/12 또는 gate 미달). records 는 "
                + "GATE_B_PINNED_MET 로 emit, absorbed=false 유지 (g3).")
        }
        return ActionResult(
            text: lines.joined(separator: "\n"),
            newRecordIDs: newIDs,
            usedEngineTool: true,
            engineToolSucceeded: green && exitCode == 0)
    }

    /// `chip + synthesize` engine tool — spawn the local Yosys
    /// dispatcher self-test (rfc_006 §4 module-7) via `hexa run
    /// stdlib/yosys/yosys.hexa`. D53 (measurable-only cell mapping):
    /// Yosys IS the producer for chip-synth, so this cell maps even
    /// though rfc_006 §5 SKY130 area-oracle gate is OPEN — the
    /// dispatcher is live, the SKY130 absorption claim is not.
    ///
    /// Honest path (g3, rfc_006 §5 — three blockers: no SKY130 lib,
    /// no `abc` binary, read_verilog scope limited to synth-subset):
    ///   1. If `yosys.hexa` is missing from the local hexa-lang
    ///      checkout (demiurge's hexa-lang working tree may be on a
    ///      branch without the rfc_006 land — observed during this
    ///      κ-31 cycle), report "yosys not in current hexa-lang
    ///      checkout" gap.
    ///   2. If `hexa` binary itself is missing, same gap path as
    ///      chip+verify.
    ///   3. If hexa run succeeds — parse "yosys dispatcher selftest:
    ///      N/N PASS" line. `cmd_synth` returns exit 90 (gate-open)
    ///      and emits no F1F2 record — that is the BANNED-absorbed
    ///      stance, NOT a failure to report as success (g3).
    ///   4. Never set `absorbed=true` here. measurement_gate stays
    ///      GATE_OPEN (or GATE_FAILED on blocker). When/if SKY130
    ///      area-oracle is met within ±5 %, the gate flips elsewhere
    ///      — not in Swift.
    private static func runChipSynthesize() -> ActionResult {
        let hexaLangRoot = NSString(string: "~/core/hexa-lang")
            .expandingTildeInPath
        let yosys = NSString(string: "~/core/hexa-lang/stdlib/yosys/yosys.hexa")
            .expandingTildeInPath
        let fm = FileManager.default
        guard fm.fileExists(atPath: yosys) else {
            return ActionResult(
                text: "⏳ engine tool gap — yosys.hexa 가 현재 "
                    + "hexa-lang checkout 에 없습니다 (\(yosys)). "
                    + "rfc_006 §4 module-7 dispatcher 본체는 origin/main "
                    + "에 머지되었지만 demiurge 의 ~/core/hexa-lang "
                    + "working tree 가 다른 브랜치 (예: rfc043-hexa-torch "
                    + "/ t4-emt-calc) 일 가능성 — `cd ~/core/hexa-lang "
                    + "&& git checkout main && git pull` 후 재실행 "
                    + "필요 (g3 — silent success 금지).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }
        guard let hexaPath = locateHexa() else {
            return ActionResult(
                text: "⏳ engine tool gap — `hexa` 실행 파일을 PATH 또는 "
                    + "~/core/hexa-lang/hexa 에서 찾지 못했습니다. chip + "
                    + "synthesize (rfc_006 §4) 는 yosys.hexa dispatcher 를 "
                    + "spawn 하려면 hexa 바이너리가 필요합니다 (g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        // Spawn `hexa run yosys.hexa` — runs the dispatcher selftest
        // (8 routing checks). cwd = hexa-lang root so any relative
        // `use` paths in module bodies resolve.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: hexaPath)
        proc.arguments = ["run", yosys]
        proc.currentDirectoryURL = URL(fileURLWithPath: hexaLangRoot)
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        var stdoutText = ""
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            stdoutText = String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ActionResult(
                text: "⏳ engine tool gap — hexa 실행 실패: "
                    + "\(error.localizedDescription) (g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        let trimmed = stdoutText.trimmingCharacters(in: .whitespacesAndNewlines)
        var lines: [String] = []
        lines.append("hexa run yosys.hexa — exit \(exitCode)")
        lines.append(trimmed)
        lines.append("---")

        // Parse "yosys dispatcher selftest: N/N PASS" (cmd_selftest /
        // dispatcher self-test in yosys.hexa main()). A PASS line is
        // a green dispatcher — NOT a green SKY130 area measurement.
        let passOK = (exitCode == 0)
            && (trimmed.contains(" PASS") || trimmed.contains("/PASS"))

        if passOK {
            lines.append("📸 yosys dispatcher selftest GREEN — rfc_006 §4 "
                + "module-7 라우팅 동작 확인.")
            lines.append("   GATE_OPEN · absorbed=false — rfc_006 §5 "
                + "SKY130 area-oracle (router_d4≈61763 / d6≈93609 µm² "
                + "1.516×) 는 측정 불가 (blocker 3종: SKY130 lib 없음, "
                + "abc 바이너리 없음, read_verilog scope=synth-subset). "
                + "dispatcher 자체는 live — `Yosys absorbed` 주장 금지 (g3).")
            // Mirror dispatcher selftest log into exports/chip/yosys/
            // as a non-F1F2 trace (gate is OPEN, no measured record).
            let exportsDir = RecordLoader.exportsRoot
                .appendingPathComponent("chip/yosys/dispatcher-selftest")
            do {
                try fm.createDirectory(at: exportsDir,
                                       withIntermediateDirectories: true)
                let stamp = ISO8601DateFormatter().string(from: Date())
                    .replacingOccurrences(of: ":", with: "-")
                let logURL = exportsDir.appendingPathComponent(
                    "selftest-\(stamp).txt")
                let header = "# yosys.hexa dispatcher selftest — \(stamp)\n"
                    + "# rfc_006 §5 gate OPEN · absorbed=false · g3\n"
                    + "# exit \(exitCode)\n---\n"
                try (header + trimmed + "\n").write(to: logURL,
                                                    atomically: true,
                                                    encoding: .utf8)
                lines.append("   trace → \(logURL.path)")
            } catch {
                lines.append("   (trace mirror 실패: \(error.localizedDescription))")
            }
            return ActionResult(
                text: lines.joined(separator: "\n"),
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: true)
        }

        // exit != 0 OR no PASS line — honest gap. Either dispatcher
        // FAIL or hexa run blew up before reaching main().
        lines.append("⏳ engine tool gap — yosys.hexa selftest 미통과 "
            + "(exit \(exitCode)). dispatcher 라우팅 자체가 실패했거나 "
            + "stale binary / 미컴파일 모듈 가능성. chip + synthesize "
            + "측정 record 생성 0 (g3). rfc_006 §5 gate 는 어차피 OPEN — "
            + "absorbed 주장 절대 금지.")
        return ActionResult(
            text: lines.joined(separator: "\n"),
            newRecordIDs: [],
            usedEngineTool: true,
            engineToolSucceeded: false)
    }

    /// Find a hexa binary — prefer local `~/core/hexa-lang/hexa`
    /// wrapper (D17 SSOT), then `$HOME/.hx/bin/hexa`, then PATH.
    /// Returns nil if none is executable.
    private static func locateHexa() -> String? {
        let fm = FileManager.default
        let home = NSString(string: "~").expandingTildeInPath
        let candidates = [
            "\(home)/core/hexa-lang/hexa",
            "\(home)/.hx/bin/hexa",
            "/usr/local/bin/hexa",
            "/opt/homebrew/bin/hexa",
        ]
        for c in candidates where fm.isExecutableFile(atPath: c) {
            return c
        }
        // Fallback — `which hexa` via /usr/bin/env (synchronous).
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        proc.arguments = ["which", "hexa"]
        let pipe = Pipe()
        proc.standardOutput = pipe
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            let out = (String(data: data, encoding: .utf8) ?? "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if !out.isEmpty, fm.isExecutableFile(atPath: out) {
                return out
            }
        } catch {
            return nil
        }
        return nil
    }

    private static func mtimeOf(_ path: String) -> Date? {
        let attrs = try? FileManager.default.attributesOfItem(atPath: path)
        return attrs?[.modificationDate] as? Date
    }

    /// Last `n` non-empty lines of a captured stream — for honest
    /// failure tails (g3 — surface the real error, never a silent OK).
    private static func lastLinesOf(_ text: String, _ n: Int) -> String {
        let all = text.split(separator: "\n", omittingEmptySubsequences: true)
        return all.suffix(n).joined(separator: "\n")
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

    /// `sscb + synthesize` engine tool (ROI rank 1 — FEMMT + analytic
    /// fallback magnetics sizing). SSOT = `~/core/hexa-lang/stdlib/sscb/
    /// femmt_sweep.py` (D61). D72 ①b thin adapter — magnetics math stays
    /// adapter-local until 2nd consumer. GATE_OPEN / absorbed=false (g3
    /// — parametric EE-class ferrite catalogue, not measured datasheets;
    /// see SSCBSynthProducer scope_caveats).
    private static func runSSCBSynth() -> ActionResult {
        let r = SSCBSynthProducer.runSynth()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `sscb + verify` engine tool (ROI rank 2 — ngspice bolted-fault
    /// breaking-capacity, UL 489I-style figures-of-merit: I_peak / I²t /
    /// t_clear). SSOT = `~/core/hexa-lang/stdlib/sscb/ngspice_breaking.py`
    /// (D61). Distinct from sscb+analyze (interrupt_ratio transient).
    /// OpenFOAM thermal-margin skipped (heavy, separate session).
    /// GATE_OPEN / absorbed=false (g3 — generic device model).
    private static func runSSCBVerify() -> ActionResult {
        let r = SSCBVerifyProducer.runVerify()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `bot + synthesize` engine tool (ROI rank 9 — Pinocchio FK / Jacobian
    /// / RNEA on the bot+structure URDF). SSOT = `~/core/hexa-lang/stdlib/
    /// bot/pinocchio_rbd.py` (D61). D72: `kernels/urdf/` (κ-45) owns URDF
    /// loading; Pinocchio stays in bot adapter until 2nd RBD consumer.
    /// Cross-cell parity via byte-identical URDF (urdf_sha256_16 matches
    /// bot+structure κ-37). GATE_OPEN / absorbed=false (open-loop, no
    /// contact/payload/actuator dynamics — bot+verify Drake/Gazebo
    /// deferred per ROI rank 13).
    private static func runBotSynthesize() -> ActionResult {
        let r = BotSynthProducer.runSynthesize()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `scope + synthesize` engine tool (ROI rank 4 — OpenMDAO segmented-
    /// primary aperture sizing). SSOT = `~/core/hexa-lang/stdlib/scope/
    /// openmdao_sizing.py` (D61). D72 ①b adapter; wave-optics math
    /// delegated to `kernels/wave_optics/`. OpenMDAO kernel promotion
    /// candidate at 2nd MDO consumer (note: space+synthesize is 2nd —
    /// `inbox/notes/openmdao-kernel-promotion-pickup.md`). GATE_OPEN /
    /// absorbed=false (parametric aperture + areal-density placeholder
    /// mass).
    private static func runScopeSynthesize() -> ActionResult {
        let r = ScopeSynthProducer.runSynthesize()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `scope + verify` engine tool (ROI rank 3 — POPPY + optional WebbPSF
    /// + synphot signoff via `kernels/wave_optics/`). SSOT = `~/core/hexa-
    /// lang/stdlib/scope/poppy_psf_verify.py` (D61). 5 checks: repro,
    /// diffraction-limit closure (1.22 λ/D ±20%), encircled-energy
    /// monotonicity, WebbPSF cross-check (skipped if missing), synphot
    /// round-trip (skipped if missing). GATE_OPEN / absorbed=false
    /// (parametric aperture, not flight data).
    private static func runScopeVerify() -> ActionResult {
        let r = ScopeVerifyProducer.runVerify()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `space + synthesize` engine tool (ROI rank 8 — OpenMDAO SLSQP wet-
    /// mass sweep via single-discipline Tsiolkovsky rollup). SSOT =
    /// `~/core/hexa-lang/stdlib/space/openmdao_mission.py` (D61). 2nd
    /// OpenMDAO consumer after scope+synthesize → kernel-promotion
    /// candidate (see `inbox/notes/openmdao-kernel-promotion-pickup.md`).
    /// GATE_OPEN / absorbed=false (scoping-level MDO, textbook nominal
    /// inputs, no GMAT coupling). Citation NASA GSC-17177-1.
    private static func runSpaceSynthesize() -> ActionResult {
        let r = SpaceSynthProducer.runSynthesize()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

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

    /// `rtsc + analyze` engine tool (ROI rank 10 — pyfemm 2-D HTS
    /// magnetics, FIRST producer in rtsc domain). SSOT = `~/core/hexa-
    /// lang/stdlib/rtsc/pyfemm_magnetics.py` (D61). Cohort pickup:
    /// `inbox/notes/cohort-pickup-rtsc-femm-producer.md`. D72: FEMM
    /// own ecosystem (NOT skfem); `kernels/em_2d/` at 2nd consumer.
    /// Citations: arxiv:0811.2883, FEMM manual, HTS Modelling Workgroup.
    /// GATE_OPEN / absorbed=false (placeholder HTS-tape proxy; macOS
    /// honest-skip — FEMM Windows binary, Wine-only on macOS; Linux
    /// pool only).
    private static func runRtscAnalyze() -> ActionResult {
        let r = RtscAnalyzeProducer.runAnalyze()
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `fusion + verify` engine tool (ROI 11 — OpenMC TBR neutronics).
    /// SSOT = `~/core/hexa-lang/stdlib/fusion/openmc_tbr.py` (D61).
    /// D72: `kernels/mc_transport/` 2nd consumer.
    private static func runFusionVerify() -> ActionResult {
        let r = FusionVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `energy + verify` engine tool (ROI 12 — OpenMC k-eff criticality).
    /// SSOT = `~/core/hexa-lang/stdlib/energy/openmc_keff.py` (D61).
    /// D72: `kernels/mc_transport/` 3rd consumer.
    private static func runEnergyVerify() -> ActionResult {
        let r = EnergyVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `bot + verify` engine tool (ROI 13 — Drake Lyapunov / SOS).
    /// SSOT = `~/core/hexa-lang/stdlib/bot/drake_verify.py` (D61).
    private static func runBotVerify() -> ActionResult {
        let r = BotVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `space + verify` engine tool (ROI 15 — GMAT trajectory + Basilisk
    /// ADCS). SSOT = `~/core/hexa-lang/stdlib/space/gmat_basilisk.py` (D61).
    private static func runSpaceVerify() -> ActionResult {
        let r = SpaceVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `rtsc + verify` engine tool (ROI 16 — GetDP HTS H-/A-phi 3-D EM).
    /// SSOT = `~/core/hexa-lang/stdlib/rtsc/getdp_hts.py` (D61).
    private static func runRtscVerify() -> ActionResult {
        let r = RtscVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

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

    /// `mobility + verify` engine tool (ROI 17 — CARLA / ScenarioRunner).
    /// SSOT = `~/core/hexa-lang/stdlib/mobility/carla_scenario.py` (D61).
    /// macOS hard-block — Linux pool only.
    private static func runMobilityVerify() -> ActionResult {
        let r = MobilityVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `antimatter + verify` engine tool (ROI 18 — Geant4 antiproton).
    /// SSOT = `~/core/hexa-lang/stdlib/antimatter/geant4_verify.py` (D61).
    /// D72: `kernels/mc_transport/` 4th consumer — clearest N+M payoff.
    private static func runAntimatterVerify() -> ActionResult {
        let r = AntimatterVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    // ── firmware domain (D73, 16th domain) — Track A 7-verb dispatch ──
    // SSOT = ~/core/hexa-lang/stdlib/firmware/<verb>.py per D61.
    // D72: firmware = adapter-only (build/run/sign orchestration, no
    // shared math kernel). Reference target = QEMU mps2-an385 (Cortex-M3,
    // zero hardware dependency per domains/firmware.md §1).
    // g3: every cell records GATE_OPEN / absorbed=false; QEMU / west /
    // arm-none-eabi-gcc / clang-tidy / imgtool absence → honest install-
    // gated skip (never silent success).

    /// `firmware + specify` engine tool — requirements.json template.
    private static func runFirmwareSpecify() -> ActionResult {
        let r = FirmwareSpecifyProducer.runSpecify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `firmware + structure` engine tool — Zephyr/FreeRTOS task tree
    /// arch.json + west version probe.
    private static func runFirmwareStructure() -> ActionResult {
        let r = FirmwareStructureProducer.runStructure()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `firmware + design` engine tool — arm-none-eabi-gcc probe +
    /// CMake / hello.c scaffolding emit.
    private static func runFirmwareDesign() -> ActionResult {
        let r = FirmwareDesignProducer.runDesign()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `firmware + analyze` engine tool — clang-tidy + cppcheck probes,
    /// analysis.json skeleton.
    private static func runFirmwareAnalyze() -> ActionResult {
        let r = FirmwareAnalyzeProducer.runAnalyze()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `firmware + synthesize` engine tool — arm-none-eabi-gcc Cortex-M3
    /// cross-compile of hello.c → firmware.elf + firmware.bin.
    private static func runFirmwareSynthesize() -> ActionResult {
        let r = FirmwareSynthesizeProducer.runSynthesize()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `firmware + verify` engine tool — QEMU mps2-an385 boot smoke of
    /// the synthesize-cell firmware.bin (Cortex-M3 reference target).
    private static func runFirmwareVerify() -> ActionResult {
        let r = FirmwareVerifyProducer.runVerify()
        // scan-foreign: surface canonical + foreign bridge record IDs
        // directly (B1+B2 cohort, 2026-05-21).
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordIDs,
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    /// `firmware + handoff` engine tool — CycloneDX SBOM skeleton +
    /// release.tar.gz bundle + MCUboot imgtool probe.
    private static func runFirmwareHandoff() -> ActionResult {
        let r = FirmwareHandoffProducer.runHandoff()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

    // ── D74 cohort — anima-physics bridge scan-only verify producers ──
    // Architectural distinction from prior verify-cells:
    //   • {brain,bio,chem,grid} + verify SCAN exports/<domain>/verify/
    //     <UTC>Z/anima_*.json — records the anima-physics bridge
    //     (anima/anima-physics/{hw/kuramoto_neuromorphic/src,tool}/
    //      demiurge_<domain>_bridge.py) has ALREADY dropped from
    //     hexa-native substrate runs. Demiurge witnesses + aggregates;
    //     never re-measures (g3 / D17 g_stdlib_ownership).
    //   • This closes the brain/bio/chem/grid ❌ → ⏳ GATE_OPEN cells in
    //     the cohort gap-table; the dropped records carry the honest
    //     scope_caveats ("oracle parity TODO") from the bridge side.

    /// `brain + verify` engine tool (D74) — scan anima-physics kuramoto
    /// neuromorphic bridge records under exports/brain/verify/<UTC>Z/.
    /// GATE_OPEN / absorbed=false ALWAYS (g3 — substrate is reference
    /// numpy not silicon spike-event; demiurge witness only).
    private static func runBrainVerify() -> ActionResult {
        let r = BrainVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }

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

    /// `grid + verify` engine tool (D74) — scan anima-physics Kuramoto
    /// power-grid analog bridge records under exports/grid/verify/
    /// <UTC>Z/. Distinct from `grid + structure` (NetworkX IEEE 14-bus,
    /// cohort D57). GATE_OPEN / absorbed=false ALWAYS (g3 — Kuramoto N=8
    /// is intersubjective oscillator analog NOT real PMU/SCADA; Filatrella
    /// 2008 mapping is qualitative; demiurge witness only).
    private static func runGridVerify() -> ActionResult {
        let r = GridVerifyProducer.runVerify()
        return ActionResult(text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true, engineToolSucceeded: r.ok)
    }
}
