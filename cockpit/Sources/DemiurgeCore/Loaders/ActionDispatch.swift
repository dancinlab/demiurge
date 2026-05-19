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
// κ-38 (D59): adds `energy + analyze` → EnergyAnalyzeProducer
//             (pvlib clear-sky + CEC SAPM, 4th cohort producer).
// κ-43 (D65): adds `antimatter + analyze` → AntimatterAnalyzeProducer
//             (particle / PDG live-data lookup, 5th cohort producer;
//             FIRST D61-compliant-from-birth producer — script SSOT in
//             ~/core/hexa-lang/stdlib/antimatter/pdg_lookup.py, never
//             in cockpit/scripts/).
// κ-42 (D65): adds `cern + verify` → CernVerifyProducer (particle +
//             Bethe-Bloch analytic, 6th cohort cell and FIRST verify-
//             verb cell in the cohort domains; D61-compliant — script
//             SSOT in ~/core/hexa-lang/stdlib/cern/bethe_bloch_stopping.py).
// κ-44 (D66): adds `component + verify` → ComponentVerifyProducer
//             (gmsh + scikit-fem FEM on a Si die proxy box, 7th
//             measurable-only cell; D61-compliant — script SSOT in
//             ~/core/hexa-lang/stdlib/component/gmsh_skfem.py).
//
// Currently wired:
//   • component + synthesize → ComponentEmitter.emitBundled
//                              (FreeCAD parametric per κ-33 / D54)
//   • chip      + verify     → booksim self-test sniffer
//                              (honest-gap if hexa not on PATH or
//                               cmd_measure body not on local branch)
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
//                              (κ-38 / D59 — 4th cohort domain, FIRST
//                              renewable-energy cell; real NREL SAM-
//                              verified algorithm output but ZERO sky-
//                              measured data → clear-sky upper bound,
//                              GATE_OPEN영구 / absorbed=false ALWAYS)
//   • antimatter+ analyze    → particle (scikit-hep) PDG live-data
//                              lookup (κ-43 / D65 — 5th cohort domain,
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
                                     context: String) -> ActionResult {
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
            return runSSCBAnalyze()
        case (.analyze, "energy"):
            return runEnergyAnalyze()
        case (.analyze, "antimatter"):
            return runAntimatterAnalyze()
        case (.analyze, "fusion"):
            return runFusionAnalyze()
        case (.verify, "cern"):
            return runCernVerify()
        case (.verify, "component"):
            return runComponentVerify()
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
        case (.analyze, "cern"):
            return runCernAnalyze()
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

    /// `component + verify` engine tool (κ-34 / D55) — drive gmsh
    /// over the κ-33 BIPV STEP and probe Salome-Meca docker as a
    /// witness for the next gate. Honest: a mesh is NOT a thermal /
    /// structural verdict; `absorbed=false` and
    /// `measurement_gate=GATE_OPEN` are hard-coded in the record
    /// (g3). The .comm authoring + Code_Aster convergence run is the
    /// next pickup (κ-35 candidate).
    private static func runComponentVerify() -> ActionResult {
        let r = ComponentVerifier.runVerify()
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

    /// `energy + analyze` engine tool (κ-38 / D59) — spawn pvlib via
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

    /// `antimatter + analyze` engine tool (κ-43 / D65) — spawn the
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

    /// `fusion + analyze` engine tool (κ-42 / D67) — spawn plasmapy
    /// derived-parameter producer via
    /// `~/core/hexa-lang/stdlib/fusion/plasma_metrics.py` and persist a
    /// typed `FusionRecord` under `exports/fusion/plasma/<stamp>/`.
    /// Producer = `plasmapy@<v> (ITER core reference derivation)`.
    /// SEVENTH cohort cell crossing the measuring-producer threshold
    /// (after sscb κ-34, energy κ-38, antimatter κ-43, cern κ-42) and
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

    /// `cern + verify` engine tool (κ-42 / D65) — spawn the Bethe-Bloch
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

    /// `component + verify` engine tool (κ-44 / D66) — spawn the
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
        return ActionResult(
            text: r.text,
            newRecordIDs: r.newRecordID.map { [$0] } ?? [],
            usedEngineTool: true,
            engineToolSucceeded: r.ok)
    }

    /// `chip + analyze` engine tool (κ-45 / D56) — hexa-native Leighton
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

    /// `grid + structure` engine tool (κ-46 / D57) — NetworkX IEEE 14-bus
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

    /// `bot + structure` engine tool (κ-47 / D58) — yourdfpy URDF parser
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

    /// `space + analyze` engine tool (κ-48 / D60) — Skyfield SGP4
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

    /// `brain + analyze` engine tool (κ-49 / D62-cohort) — Brian2 single
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

    /// `mobility + analyze` engine tool (κ-50 / D63-cohort) — OSMnx
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

    /// `aura + analyze` engine tool (κ-51 / D67-cohort) — MNE-Python
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

    /// `scope + analyze` engine tool (κ-52 / D67-cohort) — Poppy optical
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

    /// `cern + analyze` engine tool (κ-53 / D66-cohort) — pylhe LHE
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
    private static func runChipVerify() -> ActionResult {
        let hexaBin = locateHexa()
        guard let hexaPath = hexaBin else {
            return ActionResult(
                text: "⏳ engine tool gap — `hexa` 실행 파일을 PATH 또는 "
                    + "~/core/hexa-lang/hexa 에서 찾지 못했습니다. chip + "
                    + "verify (rfc_001 §8) 는 booksim cmd_measure 가 "
                    + "F1F2 record 를 emit 해야 하지만, 그 본체는 아직 "
                    + "hexa-lang/rfc043-hexa-torch 브랜치에 없습니다 "
                    + "(g3 — silent success 금지).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }
        let booksim = NSString(string: "~/core/hexa-lang/stdlib/booksim/booksim.hexa")
            .expandingTildeInPath
        guard FileManager.default.fileExists(atPath: booksim) else {
            return ActionResult(
                text: "⏳ engine tool gap — booksim.hexa 를 찾지 못했습니다 "
                    + "(\(booksim)). chip + verify 는 hexa-lang stdlib 의 "
                    + "booksim 모듈을 필요로 합니다 (g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        // Note the existing /tmp record mtime (if any) so we can tell
        // if the self-test produced a *new* one this run.
        let tmpRecord = "/tmp/hexa_native_8x8_mesh_d4_uniform_22nm.json"
        let beforeMtime = mtimeOf(tmpRecord)

        // Spawn `hexa run booksim.hexa` — captures the self-test
        // output. With cmd_measure body landed, the self-test emits
        // one F1F2 record to /tmp; with the stub, exit 90 / no emit.
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: hexaPath)
        proc.arguments = ["run", booksim]
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        var stdoutText = ""
        var ranOK = false
        var exitCode: Int32 = -1
        do {
            try proc.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            proc.waitUntilExit()
            exitCode = proc.terminationStatus
            stdoutText = String(data: data, encoding: .utf8) ?? ""
            ranOK = (exitCode == 0)
        } catch {
            return ActionResult(
                text: "⏳ engine tool gap — hexa 실행 실패: "
                    + "\(error.localizedDescription) (g3).",
                newRecordIDs: [],
                usedEngineTool: true,
                engineToolSucceeded: false)
        }

        let afterMtime = mtimeOf(tmpRecord)
        let producedNew = (afterMtime != nil && afterMtime != beforeMtime)

        var lines: [String] = []
        lines.append("hexa run booksim.hexa — exit \(exitCode)")
        lines.append(stdoutText.trimmingCharacters(in: .whitespacesAndNewlines))

        if producedNew {
            // Self-test emitted a fresh record → copy to exports/.
            let dest = RecordLoader.f1f2RecordsRoot
                .appendingPathComponent("hexa_native_8x8_mesh_d4_uniform_22nm.json")
            do {
                try FileManager.default.createDirectory(
                    at: RecordLoader.f1f2RecordsRoot,
                    withIntermediateDirectories: true)
                if FileManager.default.fileExists(atPath: dest.path) {
                    try FileManager.default.removeItem(at: dest)
                }
                try FileManager.default.copyItem(
                    at: URL(fileURLWithPath: tmpRecord), to: dest)
                lines.append("---")
                lines.append("📸 새 측정 record → exports/chip/noc/f1f2/records/"
                    + "hexa_native_8x8_mesh_d4_uniform_22nm.json")
                lines.append("   GATE_OPEN · absorbed=false · single-point "
                    + "measurement (rfc_001 §8 full-curve parity 아직 미입증 — g3)")
                return ActionResult(
                    text: lines.joined(separator: "\n"),
                    newRecordIDs: ["hexa_native_8x8_mesh_d4_uniform_22nm"],
                    usedEngineTool: true,
                    engineToolSucceeded: true)
            } catch {
                lines.append("---")
                lines.append("⏳ /tmp record copy 실패: \(error.localizedDescription)")
                return ActionResult(
                    text: lines.joined(separator: "\n"),
                    newRecordIDs: [],
                    usedEngineTool: true,
                    engineToolSucceeded: false)
            }
        }

        // No new record — honest gap. Either cmd_measure is still a
        // stub (7/7 self-test, no emit) or the run failed outright.
        lines.append("---")
        if ranOK {
            lines.append("⏳ engine tool gap — booksim self-test 는 통과했지만 "
                + "cmd_measure body 가 아직 stub 입니다 (exit 90 / no record emit). "
                + "F1F2 record producer 본체는 hexa-lang 의 별도 브랜치에 있고 "
                + "현재 local rfc043-hexa-torch 에는 미머지 (g3 — 측정 record 0).")
        } else {
            lines.append("⏳ engine tool gap — hexa 실행 exit \(exitCode) "
                + "(stale binary / 미컴파일 모듈 가능성). chip + verify "
                + "측정 record 생성 0 (g3).")
        }
        return ActionResult(
            text: lines.joined(separator: "\n"),
            newRecordIDs: [],
            usedEngineTool: true,
            engineToolSucceeded: false)
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
}
