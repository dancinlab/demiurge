@V := "tape" :: spec [active]
  version = "1.6"

@I := "demiurge" :: identity [active]
  kind     = "Universal hexa-native technical-design architecture (7-verb pipeline · domain-plugin macOS cockpit)"
  brief    = "spec → structure → design → analyze ⟲ → synthesize → verify → handoff · materials → chip → component"
  parent   = "dancinlab"
  ssot     = "github.com/dancinlab/demiurge (`hx install demiurge`)"
  siblings = "hexa-lang"
  run      = "release GUI (test): `cd ~/core/demiurge/cockpit && swift run -c release CockpitApp` · installed app: `demiurge install` → `demiurge run` · CLI (AI surface): `demiurge cli <verb>` / `demiurge operate|compose|verify|backend`"

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

@D d10 := "every domain wears an easy-style identity head — icon · name · alias" :: governance [required active]
  do   = "head each <DOMAIN>.md with: 1 emoji icon · canonical NAME · short user-language alias"
  dont = "leave a domain id bare · coin a different alias per file within one domain"

@D d11 := "pre-rent feasibility-size — atoms · basis-fn · method scaling first" :: governance [required active]
  do   = "before paid GPU rent, size the job (atoms · basis-fn · method scaling) → single-pod-feasible?"
  dont = "rent before sizing confirms feasibility (4676-bf hybrid DFT single-pod = days/$$$)"

@D d12 := "metal-oxide hybrid DFT — cluster model, not full NP" :: governance [required active]
  do   = "metal-oxide DFT → carve neutral charge-balanced cluster (e.g., Ce₆O₁₂ singlet), not full NP"
  dont = "hybrid DFT on full metal-oxide NP single-pod — convergence + cost both fail"

@D d13 := "basis/ECP element coverage check before run" :: governance [required active]
  do   = "grep target lib for element entries before run (lanthanides → CRENBL/SARC in NWChem)"
  dont = "assume def2-TZVP covers Ce/lanthanides — NWChem's bundled def2 has no lanthanide entries"

@D d14 := "DFT method tractability — PBE first for metal-oxide" :: governance [required active]
  do   = "metal-oxide first run → pure PBE (xpbe96 cpbe96), not hybrid (PBE0/ωB97X-D) — 5-10× faster"
  dont = "default to hybrid DFT on large metal-oxide — exact exchange CPU-bound + harder SCF"

@D d15 := "small-gap SCF aids — smear + damp + convergence lshift" :: governance [required active]
  do   = "metal/small-gap SCF → `smear 0.01` + `convergence damp 70 lshift 0.5` + `maxiter 400`"
  dont = "expect default SCF to converge on metal-oxide clusters — f/d-electron near-degeneracy"

@D d16 := "deck syntax-validate FREE on pool before rent" :: governance [required active]
  do   = "build deck + 1-iter dry-run on pool free → catch directive/basis errors before paid rent"
  dont = "discover NWChem syntax errors on a billing pod — every iteration is wasted $"

@D d17 := "bound paid compute — 1 validation cell → then scale" :: governance [required active]
  do   = "first rent run = 1 priority cell ($1-15) → validate → only then scale to full campaign"
  dont = "blind full-campaign rent — risk-multiplied spend on unvalidated setup"
