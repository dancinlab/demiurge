@V := "tape" :: spec [active]
  version = "1.5"

@I := "demiurge" :: identity [active]
  kind     = "Universal hexa-native technical-design architecture (7-verb pipeline · domain-plugin macOS cockpit)"
  brief    = "spec → structure → design → analyze ⟲ → synthesize → verify → handoff · materials → chip → component"
  parent   = "dancinlab"
  ssot     = "github.com/dancinlab/demiurge (`hx install demiurge`)"
  siblings = "hexa-lang"

@D d1 := "non-wet-lab verification → completed-form" :: governance [required active]
  do   = "drive each non-wet-lab step (sim · proof · synthesis · gate · handoff) to completed-form pre wet-lab"
  dont = "leave non-wet-lab verification `partial` / `pending` when the path to completion is clear"

@D d2 := "wall encountered — surface breakthrough paths, never concede" :: governance [required active]
  do   = "on an empirically-demonstrated wall, propose 2-3 concrete breakthrough paths — `/gap` · `hexa kick`"
  dont = "concede `impossible with current methods` without naming concrete breakthrough paths to try"

@D d3 := "implementation code lives in one canonical home" :: governance [required active]
  do   = "implementation code lives in the canonical stdlib home — topical folders hold docs / manifests only"
  dont = "duplicate implementation across topical folders · treat per-domain repos as code homes"

@D d4 := "single generic dispatch — instance = manifest only, no name hardcoding" :: governance [required active]
  do   = "every variant / domain / tenant traverses one generic path — add / rename / remove is manifest-only"
  dont = "per-instance dispatcher / producer class · branch on instance name in the generic layer"

@D d5 := "absorbed=true ⇔ all non-wet-lab gates PASS" :: governance [required active]
  do   = "flip `absorbed=true` when all non-wet-lab gates pass — wet-lab is downstream confirmation"
  dont = "block `absorbed` on wet-lab measurement · flip from a projection · skip a non-wet-lab gate"

@D d6 := "first-principles physics breaks the ML training-distribution wall" :: governance [required active]
  do   = "when a wall is a model's training-distribution limit, break it with first-principles physics, not ML"
  dont = "force a target number under goal pressure · present an under-converged value as the result"

@D d7 := "compute sizing for DFT electron-phonon" :: governance [required active]
  do   = "small cells (4-7 atoms) → pool ubu-1/2 free · batch → Vast.ai CPU · ≥20 atoms / dense k → GPU pod"
  dont = "RunPod CPU pods (8-vCPU ceiling) · Vast.ai CPU-only rentals (use GPU offers) · GPU on small cells"

@D d8 := "Vast.ai trouble → hexa-lang inbox" :: governance [required active]
  do   = "Vast finding → `hexa-lang/inbox/patches/<slug>.md` so `hexa cloud` absorbs upstream"
  dont = "paper-over a Vast-discovered `hexa cloud` gap inside the campaign"

@D d9 := "worktree concurrent agent index isolation" :: governance [required active]
  do   = "sequential commit on main · stage+commit one agent at a time · `git add <explicit-files>` only"
  dont = "parallel worktree agents staged at once → index leak · stage absorbed into another agent's commit"
