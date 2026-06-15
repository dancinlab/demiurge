# demiurge

demiurge is a universal, hexa-native technical-design architecture program: it drives any engineering system through one 7-verb pipeline (spec → structure → design → analyze ⟲ → synthesize → verify → handoff), with each field plugged in as a manifest-only domain. It exposes a Next.js web GUI (the human surface) and a hexa-native CLI (the AI-agent surface) over the same generic dispatch, and consumes reusable implementation from the sibling `hexa-lang` repo (it never owns stdlib itself).

> Governance SSOT — this markdown file. The `@D d*` directive family (formerly in `project.tape`, retired 2026-06-15 · md 단일화) now lives in the **## Governance** section below; this file is authoritative.

## Structure

```
demiurge/
├─ bin/demiurge        — hx package entry point; headless / AI-agent CLI shim → cli/
├─ cli/                — hexa-native CLI driver (demiurge_cli.hexa); the 7-verb command surface
├─ web/                — Next.js web GUI (human surface, deployed to Cloud Run)
├─ cockpit/            — Swift DemiurgeCLI + DemiurgeCore library + transient exports/references
├─ stdlib/             — local discover shims (canonical reusable code lives in hexa-lang, d3)
├─ domains/            — manifest-only domain maps (<DOMAIN>.md + .log.md + .demi decks)
├─ decks/              — concrete compute input decks (DFT / QE el-ph cells)
├─ sim/                — simulation drivers / readout watchers (.hexa)
├─ QFORGE/             — quantum-forge DFT electron-phonon compute campaign workspace
├─ proposals/          — absorption / seam / cockpit design RFCs (rfc_001..012)
├─ exports/            — pipeline output records (chip NoC f1/f2, chain seams, per-domain)
├─ PAPER/ · PAPERS/    — generated papers (atlas-atom-gated, one slug per terminal discovery)
├─ .discoveries/       — /kick · /gap discovery log tapes (<slug>.tape)
├─ .verdicts/          — verify-gate verdict records
├─ .harness/           — repo-local harness rule configs (enforcement / keywords / severity)
├─ .harness-engine/    — dancinlab/harness engine, pinned as a git submodule (harness-hardcore)
├─ ARCHITECTURE.md     — architecture SSOT (update-in-place)
└─ CHANGELOG.md        — append-only change log
```

## 거버넌스 (governance)

The `@D d*` directive family (formerly `project.tape`, retired 2026-06-15). Each directive is faithful to the tape — `do` → ✅, `dont` → ⛔.

### d1 — non-wet-lab verification → completed-form

- ✅ drive each non-wet-lab step (sim · proof · synthesis · gate · handoff) to completed-form pre wet-lab
- ⛔ leave non-wet-lab verification `partial` / `pending` when the path to completion is clear

### d2 — wall encountered — surface breakthrough paths, never concede

- ✅ on an empirically-demonstrated wall, propose 2-3 concrete breakthrough paths — `/gap` · `hexa kick`
- ⛔ concede `impossible with current methods` without naming concrete breakthrough paths to try

### d3 — implementation code lives in one canonical home

- ✅ implementation code lives in the canonical stdlib home — topical folders hold docs / manifests only
- ⛔ duplicate implementation across topical folders · treat per-domain repos as code homes

### d4 — single generic dispatch — instance = manifest only, no name hardcoding

- ✅ every variant / domain / tenant traverses one generic path — add / rename / remove is manifest-only
- ⛔ per-instance dispatcher / producer class · branch on instance name in the generic layer

### d5 — absorbed=true ⇔ all non-wet-lab gates PASS

- ✅ flip `absorbed=true` when all non-wet-lab gates pass — wet-lab is downstream confirmation
- ⛔ block `absorbed` on wet-lab measurement · flip from a projection · skip a non-wet-lab gate

### d6 — first-principles physics breaks the ML training-distribution wall

- ✅ when a wall is a model's training-distribution limit, break it with first-principles physics, not ML
- ⛔ force a target number under goal pressure · present an under-converged value as the result

### d7 — compute sizing for DFT electron-phonon

- ✅ small cells (4-7 atoms) → pool ubu-1/2 free · batch → Vast.ai CPU · ≥20 atoms / dense k → GPU pod
- ⛔ RunPod CPU pods (8-vCPU ceiling) · Vast.ai CPU-only rentals (use GPU offers) · GPU on small cells

### d8 — Vast.ai trouble → hexa-lang inbox

- ✅ Vast finding → `hexa-lang/inbox/patches/<slug>.md` so `hexa cloud` absorbs upstream
- ⛔ paper-over a Vast-discovered `hexa cloud` gap inside the campaign

### d9 — worktree concurrent agent index isolation

- ✅ sequential commit on main · stage+commit one agent at a time · `git add <explicit-files>` only
- ⛔ parallel worktree agents staged at once → index leak · stage absorbed into another agent's commit

### d10 — every domain wears an easy-style identity head — icon · name · alias

- ✅ head each <DOMAIN>.md with: 1 emoji icon · canonical NAME · short user-language alias
- ⛔ leave a domain id bare · coin a different alias per file within one domain

### d11 — pre-rent feasibility-size — atoms · basis-fn · method scaling first

- ✅ before paid GPU rent, size the job (atoms · basis-fn · method scaling) → single-pod-feasible?
- ⛔ rent before sizing confirms feasibility (4676-bf hybrid DFT single-pod = days/$$$)

### d12 — metal-oxide hybrid DFT — cluster model, not full NP

- ✅ metal-oxide DFT → carve neutral charge-balanced cluster (e.g., Ce₆O₁₂ singlet), not full NP
- ⛔ hybrid DFT on full metal-oxide NP single-pod — convergence + cost both fail

### d13 — basis/ECP element coverage check before run

- ✅ grep target lib for element entries before run (lanthanides → CRENBL/SARC in NWChem)
- ⛔ assume def2-TZVP covers Ce/lanthanides — NWChem's bundled def2 has no lanthanide entries

### d14 — DFT method tractability — PBE first for metal-oxide

- ✅ metal-oxide first run → pure PBE (xpbe96 cpbe96), not hybrid (PBE0/ωB97X-D) — 5-10× faster
- ⛔ default to hybrid DFT on large metal-oxide — exact exchange CPU-bound + harder SCF

### d15 — small-gap SCF aids — smear + damp + convergence lshift

- ✅ metal/small-gap SCF → `smear 0.01` + `convergence damp 70 lshift 0.5` + `maxiter 400`
- ⛔ expect default SCF to converge on metal-oxide clusters — f/d-electron near-degeneracy

### d16 — deck syntax-validate FREE on pool before rent

- ✅ build deck + 1-iter dry-run on pool free → catch directive/basis errors before paid rent
- ⛔ discover NWChem syntax errors on a billing pod — every iteration is wasted $

### d17 — cost-bearing fire — dispatch autonomously, no user gate

- ✅ validated deck (d16 free dry-run passed) → fire full-campaign rent autonomously · parallel
- ✅ state estimated cost in one line, then fire — no user consult / approval / confirm
- ✅ provider priority = vast.ai first, runpod fallback
- ⛔ ask 'may I rent?' · defer fire to shrink cost · gate scale-up behind a 1-cell step
- ⛔ $ cap / budget gate that requires user sign-off before firing

### d18 — round-1 of every cycle/domain — include NOVEL + arxiv + web deep research from the start

- ✅ round-1 fan-out includes >=1 NOVEL probe and >=1 arxiv+web deep-research search
- ⛔ round-1 with only incremental milestones · skip lit grounding · defer NOVEL to later round

### d19 — MATLAB-grade in-silico 100% closure · intra-domain reuse lattice

> The tape carries two `@D d19` records (governance closure + reuse lattice); both are preserved here.

- ✅ in-silico path (ngspice · openEMS · MNE-Python · MATLAB-grade) to 100% closure
- ✅ apply d1+d5: non-wet-lab gates PASS → flip absorbed=true · no closure delay
- ✅ datasheet mismatch → open-model / direct derivation / sympy+scipy bypass
- ✅ before building a domain primitive, grep the atlas + sibling DOMAIN.md for a verified one
- ✅ inherit it — e.g. ANTIMATTER trap reuses RTSC current_loop_offaxis
- ✅ stamp each record with reused[] / provides[] cross-domain edges
- ✅ keep repo-root NEXUS.tape (cross-domain reuse graph) current
- ⛔ trailer wet-lab / external-lab / funding / paid / multi-year as 'excluded'
- ⛔ repeat 'absorbed=false PERMANENTLY' trailer — d1/d5/d19 already covers it
- ⛔ rebuild a sibling domain's verified primitive · leave a reuse edge off NEXUS.tape
- ⛔ link domains across repos — intra-project only

### d_deploy — web GUI surface ONLY — local hot-reload work mode · deploy gated on user approval

- ✅ web GUI: iterate live in localdev git tree (~/core/demiurge-localdev/web · next dev Fast Refresh)
- ✅ web deploy (push main → Cloud Run demiurge.dancinlab.org) ONLY on explicit user approval
- ✅ scope = web GUI surface ONLY — compute/campaign autonomy (d17) unaffected
- ⛔ auto-merge/push/deploy web changes per tweak without approval

### d_parallel_first — parallel-first — minimize wall-clock, never run independent work serially

- ✅ default to parallel fan-out — independent tasks run concurrently, not one-at-a-time
- ✅ pick the partition that MINIMIZES walltime, not the one that's simplest to launch
- ✅ scale fan-out width to the work (N independent units → N workers), bounded by the real floor
- ⛔ run independent units serially when they can fan out · accept a long serial walltime by default
- ⛔ add workers past the floor where fixed cost (setup·collect) dominates — waste, not speed

### d_qforge_parallel — QFORGE/compute campaigns — GRID-parallel to the walltime floor

- ✅ QE/QFORGE el-ph: split q (start_q/last_q) AND representations (start_irr/last_irr) across pods
- ✅ share one converged SCF out/ to all shards (skip per-pod SCF regen) — collapse the fixed floor
- ✅ size shards so each ≫ SCF+collect floor (~2-3h realistic min); recover/collect to assemble
- ✅ a long single-pod sequential el-ph run = a bug to parallelize, not a wait to endure
- ⛔ run an 8-q el-ph serially on one pod when q×irr GRID finishes in hours · leave walltime on table
- ⛔ add shards below the floor (SCF/transfer/collect dominates) — report the floor honestly (d6)

### d_qforge_fix — QFORGE upstream fix·개선 — 즉시해결 우선 · 장기지연 시 QE 병행(동시)

- ✅ QFORGE upstream fix/개선이 **바로 해결 가능**하면 즉시 고치고 진행(우회·미루기 금지)
- ✅ fix가 **오래 걸리는(장기)** 경우 → QE로 대체해 캠페인을 **계속 전진**시키되, QFORGE fix도 **바로 함께(병행)** 진행 — 둘을 동시에 굴린다(QE production + QFORGE fix in-flight)
- ✅ QE 대체는 임시 우회가 아니라 정직한 production reference (d_qforge_parallel·migration gate와 일관) — 결과는 QE-grade로 박제, QFORGE는 게이트 후 absorb
- ⛔ QFORGE fix가 길다고 캠페인을 멈춰 세우기 · QE 대체만 하고 QFORGE fix를 뒤로 미뤄 잊기 · 바로 고칠 수 있는 걸 우회로 덮기

## 워크플로우 (workflow)

PAPER auto-generation flow — atlas-as-audit-SSOT lineage (`research result → hexa verify pass → atlas atom direct fold → /paper`).

### d_atlas_as_audit_ssot — atlas embedded.gen.hexa single SSOT — zero intermediate ledger files

- ✅ verify pass → atlas atom direct fold (assumes · recipe · provenance · falsifier meta)
- ✅ audit index = `hexa atlas dump --json` (per-claim · per-domain · per-group queries)
- ⛔ CLAIMS.tape · per-domain ledger · attestation JSON · .verdicts mirror · any intermediate index

### d_claim_verify — every claim closed by an atlas atom (hexa verify pass · direct fold)

- ✅ close each claim via `hexa verify` (g5) → atlas atom direct fold into embedded.gen.hexa
- ✅ atom meta carries the verdict verbatim — assumes · recipe · provenance · falsifier · tier
- ⛔ LLM self-judge correctness (g3) · paraphrase the atom · hide an INCONCLUSIVE / unfenced claim

### d_paper_gate — /paper gated on terminal verdict AND significance

- ✅ `/paper new <slug>` only when every section claim is terminal AND significance satisfied
- ✅ terminal = 🔵 formal / 🟢 GATE_CLOSED_MEASURED / 🔴 CLOSED-negative — not 🟠 INCONCLUSIVE / 🟡 citation
- ⛔ scaffold w/ any 🟠 INCONCLUSIVE / MISSING-INPUT · 🟡 citation-only · ⚪ speculation · trivial recheck

### d_paper_significance — paper requires a falsifiable hypothesis + real measurement + a finding

- ✅ trigger only on a pre-registered falsifier + real measurement (record / sim / FEM / DFT / verify)
- ✅ finding = Δ vs baseline OR a closed-negative ruling out an axis
- ⛔ paper for a bookkeeping closure · known identity · unverified prediction · 🟠 residual

### d_paper_format — paper sections — hypothesis · method · measurement · finding

- ✅ §hypothesis (falsifier) · §method · §measurement · §finding (Δ OR ruled-out axis)
- ✅ commons g51 — compile ≥10 pages + ≥1 fal.ai figure
- ⛔ narrative-only · measurement substitute for hypothesis · skip §finding · vague claims

### d_paper_sections — every paper section claim links to its atlas atom

- ✅ every section claim links to its atlas atom id (resolved via `hexa atlas lookup <id>`)
- ✅ an `RTSC absorbed=true` literal also passes `_tools/check_rtsc_claim.sh` (5-gate ALL_PASS)
- ⛔ ship paper with any unresolved residual section · treat the verdict matrix as optional

### d_paper_violation — violating paper immediately revoked

- ✅ violating paper (gate / significance fail) revoked immediately — PAPERS/<slug>/ removed
- ⛔ keep a violating paper as draft · mark WIP · defer revocation · allow a residual

### d_paper_on_discovery — any verified discovery becomes a paper — free slug, no fixed domain

- ✅ every terminal discovery → its own paper slug (named by the finding, not a fixed bucket)
- ✅ replace/supersede in place when a stronger finding lands on the same slug
- ⛔ pre-assign papers to fixed domain buckets · cap the paper set · force a finding into wrong slug

### d_discovery — discovery runs continuously, not only at cycle tail

- ✅ interleave /kick · /gap discovery every batch — a discovery lane runs alongside verify
- ⛔ defer discovery to the end · single tail-only round · stop discovering once a paper ships

### d_discovery_log — discoveries persist at .discoveries/<slug>.tape

- ✅ log every kick/gap discovery to `.discoveries/<slug>.tape` — id · seed · verdict-tier-target
- ⛔ discard discovery output · paraphrase findings · skip linking discovery → next-cycle claim

### Single-doc discipline

- ✅ architecture goes in `ARCHITECTURE.md` (update-in-place); history in `CHANGELOG.md` (append-only); scratch under `scripts/scratch/`

## Harness

This repo is governed by the **`dancinlab/harness`** engine, pinned as a git submodule at `.harness-engine` (branch `harness-hardcore`).

Activate the submodule after cloning:

```bash
git submodule update --init --recursive
```

Run any harness command via the bundled wrapper:

```bash
bash .harness-engine/bin/harness <cmd>
#   docs check     single-doc discipline (ARCHITECTURE.md SSOT + CHANGELOG.md log + quickref)
#   docs status    CLAUDE-MD discipline + scatter/quickref counts
#   lint           staged-L0 + freshness + changelog convergence
#   audit          6-axis self-scorecard
```

Config lives in **`harness.config.json`** (profile `hardcore`):
- `lockdown.files` — core source files that emit an L0-edit reminder on change.
- `lint.changelog` — staged code changes require `CHANGELOG.md` to be staged too.
- `lint.protectedBranches` — `main` / `master` (no direct commits).
- `docs` — `architecture=ARCHITECTURE.md`, `log=CHANGELOG.md`, `scratchDir=scripts/scratch`, and `scopeDirs:[""]` (scatter/quickref discipline applies to repo-root `.md` only, so the large research / domain document corpus under subdirectories is exempt).

The harness hooks are wired into `.claude/settings.json` (PreToolUse / PostToolUse / UserPromptSubmit / SessionStart), each guarded with `[ -x .harness-engine/bin/harness ] && … || true` so the repo stays usable when the submodule is uninitialized.

## Quick reference

- Architecture SSOT — [ARCHITECTURE.md](ARCHITECTURE.md)
- Governance SSOT — this file (`## 거버넌스 (governance)` · `## 워크플로우 (workflow)`)
- Project overview — [README.md](README.md)
- Change log — [CHANGELOG.md](CHANGELOG.md)
