@V := "tape" :: spec [active]
  version = "1.3"

@I := "demiurge" :: identity [active]
  kind   = "Universal hexa-native technical-design architecture (7-verb pipeline · domain-plugin macOS cockpit)"
  brief  = "spec → structure → design → analyze ⟲ → synthesize → verify → handoff. Materials → chip → component meta-conductor."
  parent = "dancinlab"
  ssot   = "github.com/dancinlab/demiurge (`hx install demiurge`)"

@D d1 := "non-wet-lab verification → completed-form" :: governance [required active]
  do   = "drive every non-wet-lab verification step (simulation · in-silico analysis · proof · synthesis · cockpit gate · handoff) to completed-form / done state — the entire pre-experiment pipeline reaches `verified` BEFORE the wet-lab boundary"
  dont = "leave non-wet-lab verification in `partial` / `in-progress` / `pending` / `tbd` when the path to completion is clear — only the physical wet-lab experiment itself is the legitimate `not yet` boundary"

@D d2 := "wall encountered: surface breakthrough paths, never concede" :: governance [required active]
  do   = "when current methods + current understanding hit an empirically-demonstrated wall (any domain — materials · biology · chemical), propose 2-3 concrete breakthrough hypotheses to test (new lens · new dataset · new method · feedback loop · domain extension · re-framing) — use `/gap full` for systematic 40-lens axis sweep + `hexa kick` for engine-driven gap traversal"
  dont = "concede `impossible with current methods` as terminal without naming concrete breakthrough paths to try"

@D d3 := "implementation code lives in one canonical home" :: governance [required active]
  do   = "algorithm / implementation code lives in the canonical stdlib home (per-language root) — topical sister folders / per-domain repos hold docs · manifests · examples only"
  dont = "duplicate implementation across topical sister folders · maintain the same code in N places · treat topical / per-domain repos as code homes"

@D d4 := "single generic dispatch — new instance = manifest only" :: governance [required active]
  do   = "dispatch all variants / domains / tenants through one generic code path — adding an instance = drop a manifest file, nothing else"
  dont = "per-instance dispatcher / producer class (the `FooProducer` / `BarProducer` family) · hard-coded instance branches in the router"

@D d5 := "universal generic path — no instance-name hardcoding" :: governance [required active]
  do   = "every instance / variant / domain traverses the same generic path — rename / add / remove is a manifest-only change"
  dont = "branch on instance name in the generic layer · add per-instance hardcoded checks (1 universal socket, not N shapes)"

@D d6 := "absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true (measured-oracle invariant · 4-carrier audited · κ-71 G41 PARTIAL)" :: governance [required active]
  do   = "flip stored `absorbed: Bool` to true only when an attached `MeasuredOracleRef` records `isMeasuredOraclePASS=true` against its PASS criterion — keep `absorbed` (measurement axis) orthogonal to D95/D103 `hexa_native_parity` (substrate-port axis); load-bearing enforcement = `cockpit/Tests/DemiurgeCoreTests/AbsorbedNeedsMeasuredOracleTests.swift` (`fee34cc` G30 Stage 1 · invariant helper record-type-agnostic — κ-68 EnergyVerifyRecord G29/D110 · κ-69 AuraVerifyRecord G33/D117 · κ-70 UfoVerifyRecord G37/D119 LANDED 3rd carrier per D118 · κ-70 R9 4/4 CLOSURE G38 · κ-71 EnergyWindVerifyRecord G41/D121 NEW 4th carrier · invariant-test PASS · κ-71 R10 G41 [~] PARTIAL — absorbed flip DEFERRED on honest gap mean_rel_err=0.0708 > 0.05 D120 criterion · invariant audit nonetheless LANDED & confirms record-type-agnostic generalization) — **4-carrier audit COMPLETE**: 4 record types × identical `invariantHolds(absorbed, measuredOracle, isIllustrativePhysics)` predicate × invariant-helper edit 0 = strongest cross-cell evidence to date that the invariant is record-type-agnostic by construction"
  dont = "flip `absorbed=true` from D95 computed-projection alone (substrate-parity ≠ measurement-parity · D103 dimension-separation) · attach `MeasuredOracleRef` to `.illustrativePhysics` cells (D106 carve-out · RFC 013 §6.12 anti-conflation · Ufo Stage-4..7 warp/wormhole/dim/use excluded — measured-oracle scope OUT, governance-affirmed) · branch the invariant on record type (auto-extend per record-type-agnostic design · 3rd carrier audit landed at κ-70 G37/D119) · edit this row in-place except for PATCH wording (append new rows · semver = MINOR for new governance event)"

@D d7 := "first-principles physics breaks the ML training-distribution wall · report only converged values, never force a target under goal pressure" :: governance [required active]
  do   = "when an empirically-demonstrated wall is a *model's training-distribution limit* (ambient-trained ML under-predicts out-of-distribution physics — BETE-NET & ALIGNN both gave hydride electron-phonon λ≈0.34-0.48 vs literature ~2.0, cross-confirmed, RTSC.md §9.11.H/I), the breakthrough path is *first-principles physics* (DFT electron-phonon on pool:ubu-1/2 conda QE), NOT more ML (d2 instance); drive that prediction to completed-form (d1); report ONLY grid-converged values — label under-converged / broadening-unstable numbers as such (H3S 16³-k λ=1.15 broadening-unstable → 24³-k λ=0.85 broadening-stable; §9.12) and name the dominant remaining under-convergence (q-grid + anharmonicity)"
  dont = "force a target number under goal / Stop-hook pressure · present an under-converged or broadening-sensitive value as *the* result (the stale-temp-file failure mode applied to convergence) · concede `impossible` for RTSC (d2 — §8.9 5-gate stays OPEN; frontier = ambient-pressure superhydride · arxiv:2310.07562 · 2403.13496) · flip `absorbed=true` from a simulation-only-prediction (d6 — DFT & ML are Tier-1 *prediction* · `gate_type=simulation-only-prediction` · NEVER a measured-oracle · hexa atlas n6 'Tc 300K' is a *target* not a measurement, §8.8/§9 atlas-witnessed)"
