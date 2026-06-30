# demiurge

demiurge is a universal, hexa-native technical-design architecture program: it drives any engineering system through one 7-verb pipeline (spec → structure → design → analyze ⟲ → synthesize → verify → handoff), with each field plugged in as a manifest-only domain. It exposes a Next.js web GUI (the human surface) and a hexa-native CLI (the AI-agent surface) over the same generic dispatch, and consumes reusable implementation from the sibling `hexa-lang` repo (it never owns stdlib itself).

> 📍 SSOT pointer (this file = entry point + governance/workflow/work-rules):
> · **Structure·Design → [ARCHITECTURE.json](ARCHITECTURE.json)** — the directory·module tree + LAWS + reuse-graph is the **single SSOT here** (JSON-tree · AI/tool-parse; humans use `python3 serve.py` → [ARCHITECTURE.html](ARCHITECTURE.html) viewer · ARCHITECTURE.md retired 2026-06-16 c4)
> · Governance → **this file** `## Governance` (`@D d*` directive family · project.tape retired 2026-06-15, unified into md) + cross-project [commons](.harness-engine/config/commons.md)
> · History → [CHANGELOG.jsonl](CHANGELOG.jsonl) (append) · Overview → [README.md](README.md)

> 🛠️ **Troubleshooting recurrence-prevention = harden it into the tools (hexa cloud · hexa deck) (top principle)**
> Once you hit a troubleshooting issue in compute/pod/deck — don't hand-patch around it on the spot; instead **bake the prevention
> guard as code into `hexa cloud` (pod·cloud layer) or `hexa deck` (input-deck·run-script layer)** to drive the same
> bug's recurrence to 0 (self-improving tools = discipline SSOT). Per c17, the application layer (cloud·deck) is **fixed directly in an isolated
> worktree → `harness pr-cycle`**, while the compile/runtime core is handed off to ING. d_deck_always (deck) and this principle
> (cloud) are a pair. Every troubleshooting begets a new guard.

## Governance

The `@D d*` directive family (formerly `project.tape`, retired 2026-06-15). Each directive is faithful to the tape, in `do` / `dont` form.

### d1 — non-wet-lab verification → completed-form

- do: drive each non-wet-lab step (sim · proof · synthesis · gate · handoff) to completed-form pre wet-lab
- dont: leave non-wet-lab verification `partial` / `pending` when the path to completion is clear

### d2 — wall encountered — surface breakthrough paths, never concede

- do: on an empirically-demonstrated wall, propose 2-3 concrete breakthrough paths — `/gap` · `hexa kick`
- dont: concede `impossible with current methods` without naming concrete breakthrough paths to try

### d3 — implementation code lives in one canonical home

- do: implementation code lives in the canonical stdlib home — topical folders hold docs / manifests only
- dont: duplicate implementation across topical folders · treat per-domain repos as code homes

### d4 — single generic dispatch — instance = manifest only, no name hardcoding

- do: every variant / domain / tenant traverses one generic path — add / rename / remove is manifest-only
- dont: per-instance dispatcher / producer class · branch on instance name in the generic layer

### d5 — absorbed=true ⇔ all non-wet-lab gates PASS

- do: flip `absorbed=true` when all non-wet-lab gates pass — wet-lab is downstream confirmation
- dont: block `absorbed` on wet-lab measurement · flip from a projection · skip a non-wet-lab gate

### d6 — first-principles physics breaks the ML training-distribution wall

- do: when a wall is a model's training-distribution limit, break it with first-principles physics, not ML
- dont: force a target number under goal pressure · present an under-converged value as the result

### d7 — compute sizing for DFT electron-phonon

- do: small cells (4-7 atoms) → pool ubu-1/2 free · batch → Vast.ai CPU · ≥20 atoms / dense k → GPU pod
- dont: RunPod CPU pods (8-vCPU ceiling) · Vast.ai CPU-only rentals (use GPU offers) · GPU on small cells

### d8 — Vast.ai trouble → ING handoff (inbox retired 2026-06-22)

- do: Vast/upstream finding → record it into the ING.jsonl handoff via `harness ing add` so `hexa cloud` upstream-absorbs (old `hexa-lang/inbox/patches/` retired → unified into ING)
- dont: paper-over a Vast-discovered `hexa cloud` gap inside the campaign

### d9 — worktree concurrent agent index isolation

- do: sequential commit on main · stage+commit one agent at a time · `git add <explicit-files>` only
- dont: parallel worktree agents staged at once → index leak · stage absorbed into another agent's commit

### d10 — every domain wears an easy-style identity head — icon · name · alias

- do: head each <DOMAIN>.md with: 1 emoji icon · canonical NAME · short user-language alias
- dont: leave a domain id bare · coin a different alias per file within one domain

### d11 — pre-rent feasibility-size — atoms · basis-fn · method scaling first

- do: before paid GPU rent, size the job (atoms · basis-fn · method scaling) → single-pod-feasible?
- dont: rent before sizing confirms feasibility (4676-bf hybrid DFT single-pod = days/$$$)

### d12 — metal-oxide hybrid DFT — cluster model, not full NP

- do: metal-oxide DFT → carve neutral charge-balanced cluster (e.g., Ce₆O₁₂ singlet), not full NP
- dont: hybrid DFT on full metal-oxide NP single-pod — convergence + cost both fail

### d13 — basis/ECP element coverage check before run

- do: grep target lib for element entries before run (lanthanides → CRENBL/SARC in NWChem)
- dont: assume def2-TZVP covers Ce/lanthanides — NWChem's bundled def2 has no lanthanide entries

### d14 — DFT method tractability — PBE first for metal-oxide

- do: metal-oxide first run → pure PBE (xpbe96 cpbe96), not hybrid (PBE0/ωB97X-D) — 5-10× faster
- dont: default to hybrid DFT on large metal-oxide — exact exchange CPU-bound + harder SCF

### d15 — small-gap SCF aids — smear + damp + convergence lshift

- do: metal/small-gap SCF → `smear 0.01` + `convergence damp 70 lshift 0.5` + `maxiter 400`
- dont: expect default SCF to converge on metal-oxide clusters — f/d-electron near-degeneracy

### d16 — deck syntax-validate FREE on pool before rent

- do: build deck + 1-iter dry-run on pool free → catch directive/basis errors before paid rent
- dont: discover NWChem syntax errors on a billing pod — every iteration is wasted $

### d17 — cost-bearing fire — dispatch autonomously, no user gate

- do: validated deck (d16 free dry-run passed) → fire full-campaign rent autonomously · parallel
- do: state estimated cost in one line, then fire — no user consult / approval / confirm
- do: provider priority = vast.ai first, runpod fallback
- dont: ask 'may I rent?' · defer fire to shrink cost · gate scale-up behind a 1-cell step
- dont: $ cap / budget gate that requires user sign-off before firing

### d18 — round-1 of every cycle/domain — include NOVEL + arxiv + web deep research from the start

- do: round-1 fan-out includes >=1 NOVEL probe and >=1 arxiv+web deep-research search
- dont: round-1 with only incremental milestones · skip lit grounding · defer NOVEL to later round

### d_novel_only — never reproduce·re-verify what's already known · the goal is NOVEL discovery

- do: every campaign·round targets **NOVEL (undiscovered) findings** — don't spend compute/time re-producing results already known in the literature·clinic
- do: before a target·candidate, check novelty via arxiv+web (d18 lit grounding); if known (e.g., MCL1 = S63845·AMG-176·AZD5991 clinical red-ocean) it's to avoid not reproduce — pivot to NOVEL
- do: known-value comparison = a one-shot method-validation anchor only — never bank it as campaign output; real results are a Δ in unknown territory (new target·mechanism·material·closed-negative)
- do: never compute-reproduce the literature (hard rule): re-deriving a published value (FeCo bct K1 0.7-1.0·Fe16N2 ~1.0·known λ) via DFT·QE·ABFE IS reproduction — banned for method-anchor/closed-neg
- do: axis closed by a literature anchor → close with that paper (DOI), cite in verdict; compute only unknown Δ. Before queueing a cell/property ask "new Δ or reproduction?" — cancel if reproduction
- do: this-session slip: leverb-mae-production tried to recompute FeCo/Fe16N2 K1 (literature already pre-registered FAIL) at summer disk 99% → closing it was the right call
- do: novelty gate auto·mandatory·upfront — fire arxiv+web probe inline when a candidate first appears; before its verdict (`PUBLISHED`/`PARTIAL`/`NOVEL` + rival id) never report "success/discovery"
- do: novelty check is step-1 of the candidate pipeline (fleet round-1 = d18), not a late user step. Slip: Mg2PtH6·CoSn·light-element kagome novelty-checked only after compute→success → never invert
- dont: report "matched a known coupling/property" (ABFE·DFT) as discovery · full-campaign a red-ocean w/o novelty check · defer NOVEL+reproduce first · bank "success/discovery" then novelty-probe
- dont: a novelty-undetermined report always carries the `신규성 PENDING` tag, grade finalized after the verdict (w/ d2·d6·d18·d_discovery·d_paper_significance — meaningless unless a discovery)

### d19 — MATLAB-grade in-silico 100% closure · intra-domain reuse lattice

> The tape carries two `@D d19` records (governance closure + reuse lattice); both are preserved here.

- do: in-silico path (ngspice · openEMS · MNE-Python · MATLAB-grade) to 100% closure
- do: apply d1+d5: non-wet-lab gates PASS → flip absorbed=true · no closure delay
- do: datasheet mismatch → open-model / direct derivation / sympy+scipy bypass
- do: before building a domain primitive, grep the atlas + sibling DOMAIN.md for a verified one
- do: inherit it — e.g. ANTIMATTER trap reuses RTSC current_loop_offaxis
- do: stamp each record with reused[] / provides[] cross-domain edges
- do: keep the cross-domain reuse graph current in `ARCHITECTURE.json` (single SSOT — NEXUS.tape retired 2026-06-21)
- dont: trailer wet-lab / external-lab / funding / paid / multi-year as 'excluded'
- dont: repeat 'absorbed=false PERMANENTLY' trailer — d1/d5/d19 already covers it
- dont: rebuild a sibling domain's verified primitive · leave a reuse edge off the ARCHITECTURE.json reuse-graph
- dont: link domains across repos — intra-project only

### d_deploy — web GUI surface ONLY — local hot-reload work mode · deploy gated on user approval

- do: web GUI: iterate live in localdev git tree (~/core/demiurge-localdev/web · next dev Fast Refresh)
- do: web deploy (push main → Cloud Run demiurge.dancinlab.org) ONLY on explicit user approval
- do: scope = web GUI surface ONLY — compute/campaign autonomy (d17) unaffected
- dont: auto-merge/push/deploy web changes per tweak without approval

### d_parallel_first — parallel-first — minimize wall-clock, never run independent work serially

- do: default to parallel fan-out — independent tasks run concurrently, not one-at-a-time
- do: pick the partition that MINIMIZES walltime, not the one that's simplest to launch
- do: scale fan-out width to the work (N independent units → N workers), bounded by the real floor
- dont: run independent units serially when they can fan out · accept a long serial walltime by default
- dont: add workers past the floor where fixed cost (setup·collect) dominates — waste, not speed

### d_qforge_parallel — QFORGE/compute campaigns — GRID-parallel to the walltime floor

- do: QE/QFORGE el-ph: split q (start_q/last_q) AND representations (start_irr/last_irr) across pods
- do: share one converged SCF out/ to all shards (skip per-pod SCF regen) — collapse the fixed floor
- do: size shards so each ≫ SCF+collect floor (~2-3h realistic min); recover/collect to assemble
- do: a long single-pod sequential el-ph run = a bug to parallelize, not a wait to endure
- dont: run an 8-q el-ph serially on one pod when q×irr GRID finishes in hours · leave walltime on table
- dont: add shards below the floor (SCF/transfer/collect dominates) — report the floor honestly (d6)

### d_qforge_fix — QFORGE upstream fix·improvement — fix-now first · run QE in parallel (concurrent) on long delays

- do: if a QFORGE upstream fix/improvement is **immediately solvable**, fix it now and proceed (no workaround·deferral)
- do: if the fix takes long → substitute QE to keep the campaign moving forward, but pursue the QFORGE fix concurrently right away — run both at once (QE production + QFORGE fix in-flight)
- do: QE substitution is not a temporary workaround but an honest production reference (consistent with d_qforge_parallel·migration gate) — record results as QE-grade; QFORGE absorbs after the gate
- dont: halt the campaign because the QFORGE fix is long · substitute QE only and defer/forget the QFORGE fix · cover an immediately-fixable thing with a workaround

### d_qforge_migration_routing — QE→QFORGE migration is piece-by-piece; absorb only what passes the gate (≤1% vs QE)

> Migration SSOT = `ARCHITECTURE.json` QFORGE.migration_gate. Humans use `QFORGE/QFORGE.md §⭐ ENGINE STATUS`.

- do: migration is **piece-by-piece** (per-layer/per-piece) — QFORGE absorbs a piece only after it passes **≤1%** vs QE (g5 verified) (d5)
- do: already migrated: full λ/Tc assembly (L0-L5: Allen-Dynes·Eliashberg·a2F·α²F·DFPT-solver·PW-SCF) = QFORGE gate-grade (CaH6 1.65e-7) → production = mode-(b) hybrid (QE |g|² → QFORGE assembler)
- do: **QE remains (for now)**: DFPT **front-end |g|²** + phonons + nspin=2 moment — from-scratch screened-vertex (mode a/c) is below gate, so HELD
- do: close the gate anchor with QE (honest production ref) · for a wall, classify then breakthrough via named levers (c15·d2) — degenerate-subspace Sternheimer · high-RAM pod (OOM=substrate)
- dont: force from-scratch λ to 4.376 (tune-to-green·d6) · bank gate-failing as absorbed · call a wall a ceiling early (single-lens block=incomplete) · scatter migration state (SSOT=migration_gate)

### d_qforge_default — default compute engine = QFORGE (instead of QE) · QE fallback only for unmigrated pieces

- do: el-ph/DFT default engine = QFORGE-native — gate-passing (≤1% vs QE) pieces run QFORGE: L0-L5 λ/Tc assembly·PW-SCF·Sternheimer·GPU block davidson (RTX5070 · davidson/SCF/el-ph hot-path · c24)
- do: production = mode-(b) hybrid (QE |g|² → QFORGE assembler) also treats QFORGE-native output as the default
- do: QE for two uses only: (a) ref for gate-failing pieces (from-scratch front-end |g|²·phonons·nspin=2 moment) = HELD list in d_qforge_migration_routing (b) gate anchor once (production ref)
- do: for any other new compute, try QFORGE first
- do: payoff = free summer RTX5070 QFORGE-native el-ph → avoid paid vast GPU. If QFORGE blocks, run QE in parallel at once (d_qforge_fix) while pushing the QFORGE-native migration (no deferral)
- dont: run gate-passing on QE by habit · "QE, familiar" default · QFORGE=experimental/QE=production (inverted) · force unmigrated to QFORGE-native, bank gate-failing absorbed (d6·migration_gate)

### d_deck_always — every compute input-deck passes through `hexa deck` (builder+validation) (mandatory)

- do: DFT/QE el-ph compute input-decks (scf · ph · vc-relax · bands · matdyn, etc.) are **always built/validated with `hexa deck` (build+validate)**
- do: no hand-writing `.in` files (this session's hand-write bugs: missing bands verbosity='high' [#k≥100]·wrong atomic mass [Os 190.23]·vc-relax non-convergence·missing d15 SCF aids)
- do: `hexa deck` bakes deck-discipline: mass/pseudopotential (d13 grep) · bands verbosity='high' (#k≥100) · metal/small-gap SCF aids (d15: smear+damp+lshift) · fire after FREE d16 dry-run on pool
- do: before DFPT el-ph, a **d6 dynamic-stability pre-check** (matdyn imaginary modes 0)
- do: decks are recorded in `decks/` (root input-decks) · `exports/rtsc/decks/` (c5 preserve) · prefer `hexa deck` over raw curl/ad-hoc hand-writing (consistent with commons c12 harness-first)
- do: on troubleshooting → bake the prevention (guard/check/default) into `hexa deck` — once you hit a deck bug·failure, code its prevention for 0 recurrence (hexa deck = self-improving deck SSOT)
- dont: unvalidated deck at a billing pod (d16) · deck missing mass/pseudo/verbosity/SCF-aid · el-ph on dyn-unstable cell (FLEET-DIAGNOSTIC waste) · one-off deck-fix w/o `hexa deck` guard (recur open)

### d_roomt_ambient — ambient-pressure·room-temperature superconductivity pass-criteria (ROOMT-AMBIENT-PASS-CRITERIA · hard gate)

> SSOT = `ARCHITECTURE.json` LAWS/ROOMT-AMBIENT-PASS-CRITERIA · detail `state/fb-geom-lambda/ROOMT_AMBIENT_PASS_CRITERIA.md`. A "room-temperature/ambient-pressure superconductivity" claim is recorded only if it explicitly passes this gate.

- do: hard thresholds: Tc ≥ 293.15K (margin, 300K recommended) · P = 1 atm (≈0 GPa — GPa-class hydrides [LaH10 etc.] not ambient, excluded) · bulk (thin-film/interface SC = separate label)
- do: TIER-1 pre-gate (g5; all PASS→wet-lab rec): (1) ambient thermo (convex-hull/ΔH_f<0) (2) ambient dyn (matdyn imag 0; high-P≠ambient) (3) carrier (E_F metal/dopable·N(E_F)>0; gap=FAIL)
- do: (4) **Tc≥293K** (conventional=DFPT λ+Allen-Dynes/Eliashberg; unconv=order-parameter Tc + calibrated estimator) (5) magnetism/CDW non-preemption (U-scan) (6) novelty (d_novel_only)
- do: TIER-2 wet-lab confirm gate (d1/d5, ALL→absorbed=true): A zero-R (ρ→0 @≥293K) · B ★Meissner shielding-frac (zero-R alone insufficient) · C spec-heat jump ΔC+Hc1/Hc2 · D isotope/gap (mechanism)
- do: E **reproduction ≥2 independent batches/labs (a single-batch preprint is insufficient)**
- do: scoring (d6): Tc<threshold → not "room-temp" — Ge:GaNb4S8 ~50K·MgB2 39K·LiBC ~45K all FAIL #4 (Tc≥293K). Bottleneck #4 = light-element coupling + ambient dyn-stability OR non-phonon (wall)
- dont: claim zero-R alone·1-batch preprint·projected as "room-temp pass" · a GPa high-P Tc as "ambient" · TIER-1-fail as room-temp · Tc<293K as "room-temp" (d6; w/ d_novel_only·d_paper_significance)

### d_production_grade — real-production (commercialization) pass-criteria (lab validation ≠ production · hard gate)

> SSOT = the PRODUCTION-CRITERIA node of each campaign in `ARCHITECTURE.json`. Any claim that a new material/replacement candidate is "actually mass-producible·commercializable" is recorded only if it explicitly passes this gate. Session lesson (Gd→Mn²⁺ MRI): reaching Phase-2 clinical (principle proof) ≠ replacing the Gd market — relaxivity (spin 7 vs 5)·Mn toxicity·established-market friction keep it uncommercialized.

- do: **2-tier distinction mandatory**: **TIER-L (lab/in-silico)** = principle proof (performance-parity gate PASS + novelty) — only "proof it works"
- do: TIER-P (production; ALL PASS='production-ready'): P1 perf parity (± vs bench — BHmax·MRI relaxivity·CMP removal·Ga mobility) · P2 safety (toxicity·degradation·lifetime — manganism·MnAl)
- do: P3 mfg scale (bulk/continuous/yield, not film·powder·1-batch — tetrataenite G6·semi fab) · P4 cost (≤existing/clear — FePt Pt-cost fail) · P5 cert/reg/market (FDA·semi qual·customer·incumbent)
- do: P6 **supply-chain resilience** (the point of replacement — avoid China-dependent critical materials [Ga·Ge·Sb·heavy-REE·CMP], ★don't create a new single-source dependence)
- do: scoring (d6): a TIER-L pass = "principle works", not "commercializable". Don't call a TIER-P-failing `production-ready` — name the P-gate (e.g., Gd→Mn = P1 relaxivity+P2 toxicity+P5 market)
- dont: claim "commercializable" from in-silico parity alone · generalize 1-batch/film/clinical to bulk · bank a replacement adding new China-dependent critical-mat dep as "supply-chain solved" (P6)
- dont: call a "replacement success" a commercial success without the TIER-P gate (bundled with d_novel_only·d_roomt_ambient)

## Workflow

PAPER auto-generation flow — atlas-as-audit-SSOT lineage (`research result → hexa verify pass → atlas atom direct fold → /paper`).

### d_atlas_as_audit_ssot — atlas embedded.gen.hexa single SSOT — zero intermediate ledger files

- do: verify pass → atlas atom direct fold (assumes · recipe · provenance · falsifier meta)
- do: audit index = `hexa atlas dump --json` (per-claim · per-domain · per-group queries)
- dont: CLAIMS.tape · per-domain ledger · attestation JSON · state/ verdict mirror · any intermediate index

### d_claim_verify — every claim closed by an atlas atom (hexa verify pass · direct fold)

- do: close each claim via `hexa verify` (g5) → atlas atom direct fold into embedded.gen.hexa
- do: atom meta carries the verdict verbatim — assumes · recipe · provenance · falsifier · tier
- dont: LLM self-judge correctness (g3) · paraphrase the atom · hide an INCONCLUSIVE / unfenced claim

### d_paper_gate — /paper gated on terminal verdict AND significance

- do: `/paper new <slug>` only when every section claim is terminal AND significance satisfied
- do: terminal = 🔵 formal / 🟢 GATE_CLOSED_MEASURED / 🔴 CLOSED-negative — not 🟠 INCONCLUSIVE / 🟡 citation
- dont: scaffold w/ any 🟠 INCONCLUSIVE / MISSING-INPUT · 🟡 citation-only · ⚪ speculation · trivial recheck

### d_paper_significance — paper requires a falsifiable hypothesis + real measurement + a finding

- do: trigger only on a pre-registered falsifier + real measurement (record / sim / FEM / DFT / verify)
- do: finding = Δ vs baseline OR a closed-negative ruling out an axis
- dont: paper for a bookkeeping closure · known identity · unverified prediction · 🟠 residual

### d_paper_format — paper sections — hypothesis · method · measurement · finding

- do: §hypothesis (falsifier) · §method · §measurement · §finding (Δ OR ruled-out axis)
- do: commons g51 — compile ≥10 pages + ≥1 fal.ai figure
- dont: narrative-only · measurement substitute for hypothesis · skip §finding · vague claims

### d_paper_sections — every paper section claim links to its atlas atom

- do: every section claim links to its atlas atom id (resolved via `hexa atlas lookup <id>`)
- do: an `RTSC absorbed=true` literal also passes `_tools/check_rtsc_claim.sh` (5-gate ALL_PASS)
- dont: ship paper with any unresolved residual section · treat the verdict matrix as optional

### d_paper_violation — violating paper immediately revoked

- do: violating paper (gate / significance fail) revoked immediately — PAPERS/<slug>/ removed
- dont: keep a violating paper as draft · mark WIP · defer revocation · allow a residual

### d_paper_on_discovery — any verified discovery becomes a paper — free slug, no fixed domain

- do: every terminal discovery → its own paper slug (named by the finding, not a fixed bucket)
- do: replace/supersede in place when a stronger finding lands on the same slug
- dont: pre-assign papers to fixed domain buckets · cap the paper set · force a finding into wrong slug

### d_discovery — discovery runs continuously, not only at cycle tail

- do: interleave /kick · /gap discovery every batch — a discovery lane runs alongside verify
- dont: defer discovery to the end · single tail-only round · stop discovering once a paper ships

### d_discovery_log — discoveries persist at .discoveries/<slug>.tape

- do: log every kick/gap discovery to `.discoveries/<slug>.tape` — id · seed · verdict-tier-target
- dont: discard discovery output · paraphrase findings · skip linking discovery → next-cycle claim

### Single-doc discipline

- do: architecture goes in `ARCHITECTURE.json` (JSON-tree SSOT · AI/tool-parse; humans use `ARCHITECTURE.html` via `python3 serve.py`); history in `CHANGELOG.jsonl` (append-only)
- do: all work artifacts under `state/` (commons c5 · single artifact root) — `ARCHITECTURE.md` retired (2026-06-16 · c4 JSON-tree adopted)

## Harness

This repo is governed by the **`dancinlab/harness`** engine, pinned as a git submodule at `.harness-engine` (branch `harness-hardcore`).

Activate the submodule after cloning:

```bash
git submodule update --init --recursive
```

Run any harness command via the bundled wrapper:

```bash
bash .harness-engine/bin/harness <cmd>
#   docs check     single-doc discipline (ARCHITECTURE.json SSOT + CHANGELOG.jsonl log + quickref)
#   docs status    CLAUDE-MD discipline + scatter/quickref counts
#   lint           staged-L0 + freshness + changelog convergence
#   audit          6-axis self-scorecard
```

Config lives in **`harness.config.json`** (profile `hardcore`):
- `lockdown.files` — core source files that emit an L0-edit reminder on change.
- `lint.changelog` — staged code changes require `CHANGELOG.jsonl` to be staged too.
- `lint.protectedBranches` — `main` / `master` (no direct commits).
- `docs` — `architecture=ARCHITECTURE.json`, `log=CHANGELOG.jsonl`, `scratchDir=state`, and `scopeDirs:[""]` (scatter/quickref discipline applies to repo-root `.md` only, so the large research / domain document corpus under subdirectories is exempt).

The harness hooks are wired into `.claude/settings.json` (PreToolUse / PostToolUse / UserPromptSubmit / SessionStart), each guarded with `[ -x .harness-engine/bin/harness ] && … || true` so the repo stays usable when the submodule is uninitialized.

## Quick reference

- Architecture SSOT — [ARCHITECTURE.json](ARCHITECTURE.json) (JSON tree · humans use the [ARCHITECTURE.html](ARCHITECTURE.html) viewer — `python3 serve.py`)
- Governance SSOT — this file (`## Governance` · `## Workflow`)
- Project overview — [README.md](README.md)
- Change log — [CHANGELOG.jsonl](CHANGELOG.jsonl)
