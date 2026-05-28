@V := "tape" :: spec [active]
  version = "1.6"

@I := "demiurge" :: identity [active]
  kind     = "Universal hexa-native technical-design architecture (7-verb pipeline · domain-plugin web GUI + CLI surface)"
  brief    = "spec → structure → design → analyze ⟲ → synthesize → verify → handoff · materials → chip → component"
  parent   = "dancinlab"
  ssot     = "github.com/dancinlab/demiurge (`hx install demiurge`)"
  siblings = "hexa-lang"
  run      = "web GUI (user surface): demiurge.dancinlab.org (Next.js · Cloud Run) · CLI (AI-agent + web-bridge surface): `demiurge cli <verb>`. macOS SwiftUI cockpit GUI scrapped 2026-05-27 — Swift = DemiurgeCLI + DemiurgeCore only."

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

@D d17 := "cost-bearing fire — dispatch autonomously, no user gate" :: governance [required active]
  do   = "validated deck (d16 free dry-run passed) → fire full-campaign rent autonomously · parallel"
  do   = "state estimated cost in one line, then fire — no user consult / approval / confirm"
  do   = "provider priority = vast.ai first, runpod fallback"
  dont = "ask 'may I rent?' · defer fire to shrink cost · gate scale-up behind a 1-cell step"
  dont = "$ cap / budget gate that requires user sign-off before firing"

@D d18 := "round-1 of every cycle/domain — include NOVEL + arxiv + web deep research from the start" :: governance [required active]
  do   = "round-1 fan-out includes >=1 NOVEL probe and >=1 arxiv+web deep-research search"
  dont = "round-1 with only incremental milestones · skip lit grounding · defer NOVEL to later round"

@D d19 := "MATLAB-grade in-silico 100% closure — push to limit, no wet-lab trailer" :: governance [required active]
  do   = "in-silico path (ngspice · openEMS · MNE-Python · MATLAB-grade) to 100% closure"
  do   = "apply d1+d5: non-wet-lab gates PASS → flip absorbed=true · no closure delay"
  do   = "datasheet mismatch → open-model / direct derivation / sympy+scipy bypass"
  dont = "trailer wet-lab / external-lab / funding / paid / multi-year as 'excluded'"
  dont = "repeat 'absorbed=false PERMANENTLY' trailer — d1/d5/d19 already covers it"

#
# Adapted from anima a_paper_* / a_claim_* (itself a port of hexa-codex cx_paper_*).
# Prefix = `d_` (matches demiurge's d1-d17 directive family).
# demiurge does NOT mint a new oracle — the typed record IS the verdict:
#   exports/material_attestation/<m>/*.json  (measurement_gate · absorbed)
#   exports/material_verdict/<m>/*.json        (aggregate_verdict · absorbed)
# Groups = ABSORPTION · SYNTHESIS · ARCH (one canonical paper each).
#
# LINT: every `do =` / `dont =` value is ≤100 chars (verified pre-merge).
#
# Paste the block below between d17 and the philosophy/closing section.

# ── PAPER auto-generation flow (ported from anima a_paper_* · cx_paper_* lineage) ──
# research result → typed record (attestation/verdict) → .verdicts/<slug>/<id>.txt → CLAIMS.tape → /paper

@D d_claim_manifest := "CLAIMS.tape — single audit index of verifiable demiurge claims" :: workflow [required active]
  do   = "every verifiable claim in root CLAIMS.tape — id · text · method · slug · group · record pointer"
  dont = "scatter claims across domain logs without a CLAIMS.tape index — no audit surface"

@D d_claim_verify := "every claim closed by a typed record, excerpt persisted verbatim" :: workflow [required active]
  do   = "close each CLAIMS.tape entry with a typed record (attestation/verdict) or `hexa verify` (g5)"
  do   = "mirror the record's field excerpt verbatim into `.verdicts/<slug>/<id>.txt`"
  dont = "LLM self-judge correctness (g3) · paraphrase the record · hide an INCONCLUSIVE / unfenced claim"

@D d_paper_gate := "/paper gated on terminal verdict AND significance" :: workflow [required active]
  do   = "`/paper new <slug>` only when every section claim is terminal AND significance satisfied"
  do   = "terminal = 🔵 formal / 🟢 GATE_CLOSED_MEASURED / 🔴 CLOSED-negative — not 🟠 INCONCLUSIVE / 🟡 citation"
  dont = "scaffold w/ any 🟠 INCONCLUSIVE / MISSING-INPUT · 🟡 citation-only · ⚪ speculation · trivial recheck"

@D d_paper_significance := "paper requires a falsifiable hypothesis + real measurement + a finding" :: workflow [required active]
  do   = "trigger only on a pre-registered falsifier + real measurement (record / sim / FEM / DFT / verify)"
  do   = "finding = Δ vs baseline OR a closed-negative ruling out an axis"
  dont = "paper for a bookkeeping closure · known identity · unverified prediction · 🟠 residual"

@D d_paper_negative_ok := "closed-negative findings are publishable" :: workflow [required active]
  do   = "a 🔴 FALSIFIED record that deterministically rules out a path is a valid paper"
  do   = "frame as a negative result — the falsifier + the ruled-out space (e.g. an axis ⊥ the target)"
  dont = "treat a closed-negative as a non-finding · bury a falsification · publish 🟠 as if closed"

@D d_paper_format := "paper sections — hypothesis · method · measurement · finding" :: workflow [required active]
  do   = "§hypothesis (falsifier) · §method · §measurement · §finding (Δ OR ruled-out axis)"
  do   = "commons g51 — compile ≥10 pages + ≥1 fal.ai figure"
  dont = "narrative-only · measurement substitute for hypothesis · skip §finding · vague claims"

@D d_paper_sections := "every paper section claim links to its record mirror" :: workflow [required active]
  do   = "every section claim links to its `.verdicts/<slug>/<id>.txt` record excerpt (verbatim)"
  do   = "an `RTSC absorbed=true` literal also passes `_tools/check_rtsc_claim.sh` (5-gate ALL_PASS)"
  dont = "ship paper with any unresolved residual section · treat the verdict matrix as optional"

@D d_paper_violation := "violating paper immediately revoked" :: workflow [required active]
  do   = "violating paper (gate / significance fail) revoked immediately — PAPERS/<slug>/ removed"
  dont = "keep a violating paper as draft · mark WIP · defer revocation · allow a residual"

@D d_paper_on_discovery := "any verified discovery becomes a paper — free slug, no fixed domain" :: workflow [required active]
  do   = "every terminal discovery → its own paper slug (named by the finding, not a fixed bucket)"
  do   = "replace/supersede in place when a stronger finding lands on the same slug"
  dont = "pre-assign papers to fixed domain buckets · cap the paper set · force a finding into wrong slug"

@D d_discovery := "discovery runs continuously, not only at cycle tail" :: workflow [required active]
  do   = "interleave /kick · /gap discovery every batch — a discovery lane runs alongside verify"
  dont = "defer discovery to the end · single tail-only round · stop discovering once a paper ships"

@D d_discovery_log := "discoveries persist at .discoveries/<slug>.tape" :: workflow [required active]
  do   = "log every kick/gap discovery to `.discoveries/<slug>.tape` — id · seed · verdict-tier-target"
  dont = "discard discovery output · paraphrase findings · skip linking discovery → next-cycle claim"

@D d19 := "intra-domain reuse lattice — atlas-first + provenance + NEXUS.tape" :: governance [required active]
  do   = "before building a domain primitive, grep the atlas + sibling DOMAIN.md for a verified one"
  do   = "inherit it — e.g. ANTIMATTER trap reuses RTSC current_loop_offaxis"
  do   = "stamp each record with reused[] / provides[] cross-domain edges"
  do   = "keep repo-root NEXUS.tape (cross-domain reuse graph) current"
  dont = "rebuild a sibling domain's verified primitive · leave a reuse edge off NEXUS.tape"
  dont = "link domains across repos — intra-project only"

@D d_deploy := "web GUI surface ONLY — local hot-reload work mode · deploy gated on user approval" :: governance [required active]
  do   = "web GUI: iterate live in localdev git tree (~/core/demiurge-localdev/web · next dev Fast Refresh)"
  do   = "web deploy (push main → Cloud Run demiurge.dancinlab.org) ONLY on explicit user approval"
  do   = "scope = web GUI surface ONLY — compute/campaign autonomy (d17) unaffected"
  dont = "auto-merge/push/deploy web changes per tweak without approval"
