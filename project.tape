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

@D d3 := "algorithm code lives in hexa-lang/stdlib only" :: governance [required active]
  do   = "every domain algorithm (bio · rtsc · chemical · materials · firmware · chip · ...) lives in `hexa-lang/stdlib/<domain>/` — sidecar domain folders (hexa-bio · hexa-rtsc · hexa-chip · ...) are doc-only"
  dont = "duplicate algorithm code across sidecar domain folders · write per-domain Swift in cockpit · keep `hexa-<domain>` repo as a code home (docs-only post-D116)"

@D d4 := "domain dispatch via cellrun.hexa (no per-domain Swift)" :: governance [required active]
  do   = "every domain dispatches through one `cellrun.hexa` generic path · new domain = drop a `.demi` manifest, nothing else"
  dont = "per-domain Swift producer / dispatcher class (SSCBProducer.swift / FirmwareProducer.swift family) · hard-coded domain branches in cockpit ActionDispatch"

@D d5 := "universal generic path — no domain hardcoding" :: governance [required active]
  do   = "all 20+ domains (sscb · firmware · chip · cern · component · bot · scope · energy · matter · grid · brain · aura · antimatter · fusion · mobility · space · ufo · rtsc · bio · chem) traverse the same generic code path"
  dont = "branch on domain name in the generic layer · add per-domain hardcoded checks (D116 + D111 doctrine: 1 universal socket, not 18 shapes)"
