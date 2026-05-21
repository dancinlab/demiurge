@V := "tape" :: spec [active]
  version = "1.2"

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

@D d6 := "absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true (measured-oracle invariant · 3-carrier audited)" :: governance [required active]
  do   = "flip stored `absorbed: Bool` to true only when an attached `MeasuredOracleRef` records `isMeasuredOraclePASS=true` against its PASS criterion — keep `absorbed` (measurement axis) orthogonal to D95/D103 `hexa_native_parity` (substrate-port axis); load-bearing enforcement = `cockpit/Tests/DemiurgeCoreTests/AbsorbedNeedsMeasuredOracleTests.swift` (`fee34cc` G30 Stage 1 · invariant helper record-type-agnostic — κ-68 EnergyVerifyRecord G29/D110 · κ-69 AuraVerifyRecord G33/D117 · κ-70 UfoVerifyRecord G37/D119 pre-committed 3rd carrier per D118)"
  dont = "flip `absorbed=true` from D95 computed-projection alone (substrate-parity ≠ measurement-parity · D103 dimension-separation) · attach `MeasuredOracleRef` to `.illustrativePhysics` cells (D106 carve-out · RFC 013 §6.12 anti-conflation · Ufo Stage-4..7 warp/wormhole/dim/use excluded) · branch the invariant on record type (auto-extend per record-type-agnostic design · 3rd carrier audit pending G37 land) · edit this row in-place except for PATCH wording (append new rows · semver = MINOR for new governance event)"
