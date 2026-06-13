# RTSC — DEFERRED candidates (NEVER deleted · kept in the pool)

> **Policy (project.tape `d_defer_no_delete`)**: a candidate that fails on a
> **technical / resource** ground (OOM · transient infra · endpoint-fail ·
> walltime) is **DEFERRED, never deleted** from the candidate pool. Only a
> 🔴 **FALSIFIED** scientific verdict (g63) ever closes a candidate. Deferrals
> are tracked **durably here + in `RTSC_LEDGER.jsonl` (`status: deferred`)** —
> never in an ephemeral `/tmp` log that vanishes on reboot/compaction.
>
> Each entry carries a **retry recipe** so a future parameter-tuned re-run has a
> clear path. Do NOT auto-retry a confirmed OOM-class on the same deck (burns
> money) — it needs the recipe applied first.

| candidate | reason | when | retry recipe | priority |
|---|---|---|---|---|
| ~~**Li2MgH16** @250GPa~~ **✅ RESOLVED 2026-05-31 → running (pod 38751850)** | **pseudo/pw.x parse crash — NOT OOM** (corrected). `pw.x` exits 2 + backtrace on relax: `end of file reached, tag PP_GIPAW_ORBITALS not found`. pod 38742079 had **251 GB RAM / 238 GB free** — memory was never the constraint. UPFs intact (all `</UPF>`-closed). The 3 prior "OOM @64/128/96GB-light" fails were the **SAME crash** mislabeled by the watcher's `pw.x-dead → OOM?` heuristic. | 2026-05-31 | **FIXED AT SOURCE** — `dft_dispatch.hexa _dft_pseudo_cmd` now seds `has_gipaw="true"→"false"` on every fetched UPF (el-ph never uses GIPAW). Verified on pod 38751850: all 3 UPFs `has_gipaw="false"`, relax SCF iterating clean. (Earlier ideas — `--image` / ONCV swap — unnecessary; k-grid tuning was the wrong axis.) | **HIGH** (highest-predicted clathrate Tc candidate) |
| **CaH6_NC** @170GPa (7-atom Im-3m · PWFORGE M6 NC-vs-NC anchor) | **`hexa cloud` build-dispatch gap — NOT scientific, NOT OOM**. The QE-NC reference run (g8 `hexa cloud dft-run`) cannot launch: `hexa cloud <verb>` rebuilds `cloud_cli.hexa` first, and that build phantom-fails on mac via a `$HOME/.hexa-cache` auto-GC race (concurrent-agent GC prunes the just-written tmp binary before the `test -x` check — the identical clang line by hand succeeds 2.2s exit 0). `HOME=/tmp` → Darwin /tmp panic-guard REFUSED; `HEXA_MAC_BUILD_OK=1` loses the same race; Linux pool hosts (summer/aiden) DOWN (`preflight rc=255 workdir missing`). Deck + NC pseudos are READY (`exports/rtsc/decks/CaH6_NC/` validated by d13 + upf_parse). Independent QFORGE side ALSO held on engine-chain gap (M5.5/M5.6, atoms→Tc orchestrator unwired). | 2026-06-01 | **FIX = d8 hexa-lang patch** (filed `inbox/patches/cloud-cli-mac-cache-gc-race.md`): make the post-clang existence check GC-race-proof (build into a PID-unique GC-exempt path, atomic-mv into cache after the check) OR exempt in-flight `hexa_run.*.tmp.*` from the cache GC OR per-build private cache subdir. After it lands (or a pool host recovers): `hexa cloud dft-run exports/rtsc/decks/CaH6_NC --detach` (vc-relax→scf→ph DFPT→el-ph, 2×2×2-q). Then run QFORGE-NC (needs M5.5+M5.6) + g5 λ·Tc rel-ε ≤0.5%. Do NOT direct-vastai/runpod (g8). | **HIGH** (closes PWFORGE M6 = QFORGE migration blocker #1 atoms→Tc half) |
| **Y2CdH18** @250GPa (21-atom 18-H clathrate) | **`hexa cloud`↔vast.ai transport gap — NOT scientific, NOT OOM** (verified). Recovery re-fires RENT a pod but relax **never launches**: `dft-run --detach` transport step dies at `direct_endpoint: non-array JSON — DEPRECATED: vastai show instances will be removed`. vast.ai retired the legacy `show instances` JSON shape (new form = `show instances-v1`, paginated). The **same** bug breaks `hexa cloud list` (returns runpod-only), so the "already has a live detached pod" dedup guard is blind → **every** `--detach` rents a fresh ORPHAN. Confirmed by 2 instances (`38865137`, `38865280`) that rented, failed endpoint-resolution, wrote NO `.dft_detach.state`, then were torn down + forgotten. | 2026-06-01 | **FIX = d8 hexa-lang patch** (filed `inbox/patches/vast-show-instances-v1.md`): migrate vast endpoint-resolution **and** `cloud list` parse from `vastai show instances` → `vastai show instances-v1` (handle the paginated/object JSON, not a bare array). **Do NOT auto-re-fire Y2CdH18** (deterministic → orphans + cost). After the patch lands: `hexa cloud dft-run exports/rtsc/decks/Y2CdH18 --detach` (deck already `.validated`). | **MED** (siblings Y2InH18/Ca2SnH18/LaY_H10 same class already running) |
| **Li2MgH16** @250GPa — **PHONON stage** (pod 38922322, QE 6.7MaX, `el-ph simple` 2×2×2-q) — *distinct from the RESOLVED relax-stage GIPAW issue above* | **QE-6.7 el-ph-collection restart crash at q_1=Γ — NOT OOM, NOT scientific** (503 GB RAM / 336 free; deck physics untouched). `ph.x` exits 2: `ph_restart_set_filename: cannot open file` ×3 → `end of file reached, tag PARTIAL_EL_PHON not found` → `xmltools.f90:965 Fortran runtime: READ after EOF`. **ROOT CAUSE (verified):** q_1's el-ph collection was interrupted mid-write — the 26 phonon irreps all `DONE_IRR=true` with 26 intact `elph.1.N.xml` (18 MB ea) + full dvscf/dwf/bar/recover, BUT the `<PARTIAL_EL_PHON>` blocks were never appended into `dynmat.1.N.xml` and `dynmat.1.0`/`1.1` were truncated (missing `</Root>`). QE's recover reader for `electron_phonon='simple'` reads back `PARTIAL_EL_PHON` from the dynmat files and hits EOF → fatal. **Tried & FAILED (5 attempts, crash-loop guard tripped):** (1) append `</Root>` to the 2 truncated dynmat (well-formed-verified) — still `PARTIAL_EL_PHON not found`; (2) move all 27 q_1 `dynmat.1.*.xml` aside to force el-ph recompute from dvscf — made it WORSE (3× `cannot open`, recover lost irrep-done status; **this recipe FIXED the analogous LaH10 q_3 crash but does NOT transfer to q_1=Γ** which uses the main collected save + top-level recover, a different restart path than a non-Γ per-q dir). q_1 dynmat files were RESTORED to the 27-file post-`</Root>`-repair state. NO physics changed; em-dash-free here (Li2MgH16 title is ASCII). | 2026-06-02 | **RECIPE A (cheapest, recommended): redo Γ el-ph collection only.** Keep `out/_ph0/li2mgh16.li2mgh16.dvscf1` + `li2mgh16.recover*` + `li2mgh16.dwf*` + `li2mgh16.bar*` + `phsave/elph.1.*.xml` (all el-ph linear-response intact). Delete the WHOLE `out/_ph0/li2mgh16.phsave/dynmat.1.*.xml` set AND clear the Γ-done bit in `phsave/control_ph.xml` so `ph.x` re-enters q_1, re-converges the (already-cheap, dvscf-seeded) phonon, and re-writes a CONSISTENT dynmat+PARTIAL_EL_PHON. **RECIPE B (robust, if A loops): split the el-ph into a 2-pass `recover=.false.` re-run of Γ ONLY** — set `start_q=1 last_q=1` in a Γ-only `ph.in`, `recover=.false.`, reuse dvscf via `fildvscf`, write a fresh phsave for Γ, then resume the rest with `start_q=2`. **RECIPE C (env, if FoX-parser fragility persists): `ulimit -s unlimited` + `OMP_STACKSIZE=512m` already applied; additionally try a QE ≥7.0 image** (`hexa cloud dft-run … --image <qe-7.x>`) whose `xmltools` el-ph restart path is more tolerant. All three are numerical-robustness/run-control knobs — **NO physics change** (tr2_ph, el_ph_sigma, mesh unchanged). DO NOT auto-retry recipe (2)-as-tried on the same deck. | **HIGH** (QFORGE-migration-gate anchor 2/3 — Sun et al. predicted Tc~473 K @ 250 GPa; el-ph linear-response is 100% DONE for Γ, only the readback envelope is inconsistent) |

## Why deferred, not deleted
A `pw.x` parse crash is *this pseudo/QE build can't read this file*, **not**
*the material is not superconducting*. Discarding it would silently drop a
high-Tc candidate for a fixable tooling reason. Only a 🔴 FALSIFIED scientific
verdict (g63) ever closes a candidate.

## Diagnosis correction (2026-05-31)
The watcher's terminal taxonomy reports `pw.x dead + no "Begin final coords"`
as **`OOM?`** — a *heuristic guess*, not a measurement. For Li2MgH16 that guess
was **wrong 3×**: the real fault is a QE UPF-parser crash on the PSL-1.0.0
pseudo set (`PP_GIPAW_ORBITALS` EOF). Lesson: **verify the actual `relax.out`
error before applying a recipe** — `free -g` (rule out OOM) + `grep -iE "Error
in routine|end of file|%%%%"` the QE log. Watcher should label `RELAX FAILED
(cause unverified — read relax.out)`, not assert `OOM?`.

## How to retry (when ready)
1. **Image route (preferred):** `hexa cloud dft-run exports/rtsc/decks/Li2MgH16
   --detach --image <qe-preinstalled-modern>` — a recent QE build reads PSL-1.0.0
   cleanly and skips the 10-min apt provision.
2. **Pseudo route:** regenerate the deck via `/deck` pointing Li/Mg/H at ONCV
   (PseudoDojo) or SSSP UPFs (no GIPAW section), re-`--validate`, then `--detach`.
3. On success the watcher resumes it like any other candidate; flip the ledger
   line `status: deferred → running`.

---

## scf-split scramble — ghost-pulled decks (deferred 2026-05-31)

| candidate | reason | retry recipe |
|---|---|---|
| ~~**CeH9** @pressure~~ **✅ RESOLVED → running phonon** | ~~`--resume` scf stage dies: `Error in routine cell_base_init`.~~ **FIXED** (PR#2278) — CeH9 was the first to pass the layout-robust split; scf clean, ph.x advancing. | n/a — resolved |
| ~~**ScH9** @pressure~~ **✅ RESOLVED 2026-06-01 → running (inst 38770609)** | ~~`--resume` scf stage dies: `Error in routine read_namelists`. The auto-split **scrambled** scf.in — `CELL_PARAMETERS` + `ATOMIC_POSITIONS` cards landed **inside the `&control` namelist**, before the actual `key=value` lines, so `read_namelists` chokes.~~ **FIXED** — the layout-robust `dft_scf_split` (PR#2278) is deployed in the active install (`~/.hx/src`; ghost-deck regression test PASS). `--resume` re-split the SOURCE `scf.in` canonically, re-uploaded a clean scf.in (outdir=./out, ibrav=0, namelists closed, 0 read_namelists errors), launched scf→ph. scf RUNNING clean. | n/a — resolved |
| ~~**YAuH3** @pressure~~ **✅ RESOLVED 2026-06-01 → running (inst 38770822)** | ~~`--resume` scf stage dies: `Error in routine read_namelists` — same scramble class.~~ **FIXED** (PR#2278). `--resume` → clean canonical scf.in, scf **JOB DONE**, ph advancing. | n/a — resolved |
| ~~**BaAuH3** @pressure~~ **✅ RESOLVED 2026-06-01 → running (inst 38772574)** | ~~`read_namelists` scramble — `outdir=/home/aiden/rtsc_baauh3/out`, CELL/ATOMIC in `&control`.~~ **FIXED** (PR#2278). `--resume` → clean canonical scf.in (outdir=./out, namelists closed, CELL_PARAMETERS after, 0 read_namelists err), pw.x scf RUNNING. The "comment false-match" worry was moot — `--resume` re-splits the SOURCE fresh. | n/a — resolved |
| ~~**SrPtH3** @pressure~~ **✅ RESOLVED 2026-06-01 → running (inst 38772758)** | ~~`read_namelists` scramble — `outdir=/home/aiden/rtsc_srpth3/out`.~~ **FIXED** (PR#2278). `--resume` → clean canonical scf.in, scf **JOB DONE**, ph advancing. | n/a — resolved |

**Root cause** — these **five** (CeH9 · ScH9 · YAuH3 · BaAuH3 · SrPtH3 — all the ghost-pulled perovskite/clathrate decks) are **ghost-pulled decks** (authored on host `aiden`, non-standard section layout: `CELL_PARAMETERS`/`ATOMIC_POSITIONS` interleaved differently + comments before the namelist keys). dft-run's *"scf.in auto-split at ATOMIC_POSITIONS"* mis-orders the sections for that layout → an invalid scf.in. The 12 standard decks split fine. **✅ ALL FIVE RESOLVED 2026-06-01.** Root cause was the pre-PR#2278 `scf.in auto-split` mis-ordering the cards for these aiden-host layouts. **PR#2278's layout-robust `dft_scf_split` is deployed in the active install** (`~/.hx/src/stdlib/cloud/dft_dispatch.hexa`; ghost-deck regression test PASS) — it pulls namelist blocks out regardless of source interleave and re-emits canonically. `--resume` re-splits the SOURCE `scf.in` fresh each time + re-normalizes the stale `outdir=/home/aiden/...` → `./out`, so the old scrambled pod scf.in is never reused. All five fired clean via `hexa cloud dft-run <deck> --resume` (reused alive pods, ~$0). No `/deck` regen and no code change were needed — the fix predated this sweep. NEVER delete (d_defer_no_delete) — a scf-input bug is not a 🔴 FALSIFIED verdict.

---

## ph.in fildyn aiden-abs-path q_points crash (2026-06-01 · hexa-lang PR#2296)

After the scf-split fix (PR#2278), scf passed but ph.x crashed at `Error in routine
q_points (2): cannot open file /home/aiden/rtsc_<slug>/<slug>.dyn0`. Root cause:
`hexa cloud --resume` normalized scf.in's stale absolute `outdir` but NOT ph.in's
`fildyn = '/home/aiden/rtsc_<slug>/<slug>.dyn'` — an aiden-host path absent on the pod.

**FIX** — hexa-lang PR#2296: `_dft_scfph_cmd` now normalizes ph.in's `outdir → './out'`
and `fildyn`/`fildvscf → bare basename`, mirroring the scf.in normalize.

**REMEDIATION** of the 4 alive stuck pods (fildyn rewritten in-place + ph.out cleared +
ph.x relaunched via `hexa cloud nohup`, pods NOT torn down):

| candidate | pod | post-fix state | retry recipe |
|---|---|---|---|
| **YAuH3** @50  | 38770822 @194.14.47.19:23179   | ✅ q_points cleared → **running/phonon** (Representation #1, SCF) | n/a — running |
| **SrPtH3** @50 | 38772758 @185.99.66.48:14029   | ✅ q_points cleared → **running/phonon** (iter#1 ddv_scf 3.66E-09) | n/a — running |
| **ScH9** @150  | 38770609 @107.205.138.127:33377| ✅ q_points cleared → **running/phonon** (Pert#1 iter#1) | n/a — running |
| **BaAuH3** @50 | 38772574 @93.91.156.99:43948   | ⚠ q_points cleared (baauh3.dyn0 written) but **NEW** terminal fail `find_mode_sym (1): unknown mode symmetry` → STOP | add `search_sym=.false.` to `&inputph` (skip mode-symmetry classification); or tighten relaxed-structure symmetry / lower `tr2_ph`. Pod ALIVE-retained, scf+dyn0 intact. |

**BaAuH3 stays deferred** (d_defer_no_delete) — a `find_mode_sym` symmetry-classification
fail is a parameter-tuning issue, NOT a 🔴 FALSIFIED verdict. The pod is kept alive with
completed scf + dyn0 so the retry only re-runs ph.x with `search_sym=.false.` (cheap).

---

## never-fired deck backlog — disposition (2026-06-01)

Decks built but never fired (no .dft_detach.state / relax.out), reviewed for fire-worth:

| deck | validated | disposition | reason |
|---|---|---|---|
| ThH10_clathrate | ✓ | 🔥 FIRING (canary 2026-06-01) | novel 250GPa LaH10-isostructural; was lost in the crashed novel-batch (pod 38444699 provision-fail) |
| LuH10_falsifier | ✓ | 🔥 fire (pending canary) | pre-registered falsifier; a closed-negative ruling out the LuH10-N axis is publishable (g63) |
| MgCaB2_x025 | ✓ | 🔥 fire (pending canary) | MgB2-class novel doping axis, unexplored; orphan (validated but fire cmd was never issued) |
| AcBeH8_ambient | ✗ | 🔥 validate→fire | **ambient**-pressure BeH8 clathrate — directly on the 293K@1atm target axis; needs d16 dry-run first |
| anharm-h3cl | ✗ | 📦 LOW-park | SSCHA anharmonic refine of h3cl (already terminal 140K); N5 binary-hydride axis CLOSED as wall (§9.16) |
| anharm-h3f | ✗ | 📦 LOW-park | refine of h3f (terminal 33K); binary axis closed |
| anharm-h3p | ✗ | 📦 LOW-park | refine of an h3p binary; binary axis closed |
| h3o-sscha | ✗ | 📦 LOW-park | H3O SSCHA already captured in the terminal H3O 🟢 record (9–109K anharmonic); duplicate |
| yh10-200gpa | ✗ | 📦 LOW-park | YH10 pressure-sweep point; YH10 base already 🟢 GATE_CLOSED 227K — incremental Tc(P) characterization, not a new discovery |
| yh10-300gpa | ✗ | 📦 LOW-park | "" |
| yh10-400gpa | ✗ | 📦 LOW-park | "" |

**LOW-park** = kept in the deck pool (NEVER deleted, d_defer_no_delete) but NOT queued — they refine/sweep already-CLOSED candidates, so they sit below every novel/target-aligned candidate. Re-prioritize only if the binary-wall or YH10-gate conclusions are reopened.

## 2026-06-01 — Li2MgH16 (QFORGE-gate anchor) ✅ UNBLOCKED → RUNNING — dft-run direct-endpoint scp255 RESOLVED

| candidate | validated | action | note |
|---|---|---|---|
| ~~**Li2MgH16**~~ **✅ RESOLVED 2026-06-01 → RUNNING (pod 38922322 @ 79.112.108.70, offer 29302413)** | ✓ | ✅ FIX LANDED + re-fired clean — relax DETACHED on the pod | QFORGE migration-gate anchor (needs terminal QE λ·Tc). The scp-255 loop was a **tooling blocker, NOT physics**: the `--direct` bare-IP endpoint of offer **28919799** (host 116.101.122.173) answered the reachability probe but refused scp (255), and a re-fire (even `--query "direct_port_count>=2"`) deterministically re-picked it (confirmed ×3: 38917013/38917304/38917745, all clean teardowns). **FIXED AT SOURCE** — hexa-lang PR#2451 (fix **a**: scp DIRECT→PROXY single-retry fallback via `vast_ssh_endpoint`, winning transport pinned + stamped for `--resume`) + PR#2453 (fix **c**: durable TTL'd cross-invocation offer-blacklist `~/.hx/cloud/offer-blacklist.json`, the rent search EXCLUDES blacklisted offers). Installed to `~/.hx/{src,bin}/stdlib`; `hexa cloud dft-run` recompiles clean (RC=0). Re-fire `hexa cloud dft-run exports/rtsc/decks/Li2MgH16 --detach` (2026-06-01) picked a DIFFERENT offer (29302413, host 79.112.108.70 — NOT 28919799), `reachability OK` → **upload OK** (no scp-255 on this direct-capable host) → provision OK → pseudo OK → **relax LAUNCHED detached** (pid 1047) → DETACH OK (no teardown). `--resume` reaches the pod via the stamped endpoint and reports relax STILL RUNNING. **Status: RUNNING (relax), not yet terminal** — poll `hexa cloud dft-run exports/rtsc/decks/Li2MgH16 --resume` to advance relax→scf→ph(DFPT 2×2×2 q)→harvest λ·ω_log·Tc. No terminal QE λ·Tc fabricated (d6). d8 inbox patch (hexa-lang/inbox/patches/dft-run-direct-endpoint-scp255.md) is RESOLVED by these two PRs. |

note: LaH10 (sibling gate anchor) is UNAFFECTED — its prior pod 38704336 is alive (adopted, project=demiurge) and its phonon DFPT is RUNNING; poll `hexa cloud dft-run exports/rtsc/decks/LaH10 --resume` for terminal harvest.

## 2026-06-02 — rtsc-discovery fleet inspection (14 pods, all IDLE-LEAK · DFPT crashed mid-q) — fleet sweep by agent (coordination w/ ac71837 on gates)

> **Class**: all 14 `rtsc-discovery` pods are **IDLE-LEAK** — relax `JOB DONE`
> on 2026-06-01, then the el-ph (`ph.x` DFPT, 4×4×4 q, `electron_phonon='simple'`,
> `tr2_ph=1.0d-14`) launched, ran partway, and **died** (signal-18 suspend / MPI
> exit 1 / "Run is not recoverable starting from scratch" / numerical divergence).
> Each pod's live workdir was reset (newest file = `relax.out`, `scf.out`/`out/_ph0`
> mostly gone) BUT partial dyn+elph files were preserved in `<deck>/harvest_partial/`.
> **NO candidate reached terminal λ/Tc** (no q2r/matdyn/lambda anywhere). Procs DEAD,
> ~0–1% CPU → billing for nothing. These are **technical fails → DEFER, never delete**
> (d_defer_no_delete). Retry recipe is per-class below.

| candidate | pod | nat | harvest (dyn/elph) | ph.out terminal state | reason | retry recipe | priority |
|---|---|---|---|---|---|---|---|
| BaAuH3 | 38950641 | 5 | 4/2 | DFPT iterating rep#3, killed | el-ph DFPT killed mid-rep (pod idle since 1Jun) | resume ph from `harvest_partial` dyn1–4+elph (recover dir) on a fresh pod; small cell → pool/Vast CPU OK (d7) | mid |
| H3S | 38950897 | 4 | 6/4 | "Run is not recoverable from scratch" | DFPT q-loop interrupted, .save lost | re-fire ph 4×4×4 from scratch (4-atom — cheap); cross-val anchor (H3S ~203K known) | high |
| CeH9 | 38951764 | 20 | 2/0 | signal 18 (suspended), only 2 dyn | 20-atom el-ph killed early; large cell | ≥20-atom dense-q → **GPU pod** (d7); resume from dyn0/dyn1 | mid |
| LaBH8 | 38952197 | 10 | 2/0 | iter#73 slow-converging, killed | DFPT SCF slow-converging (alpha_mix 0.3), killed before q2 | lower `tr2_ph→1d-12`, `alpha_mix 0.3`, more maxiter; GPU; resume dyn0 | mid |
| LaBeH8 | 38952382 | 10 | 3/1 | "not recoverable" | DFPT interrupted after q1 elph | re-fire from dyn0; 10-atom → GPU pod | mid |
| LuH10 | 38952686 | 11 | 2/0 | MPI exit 1 (mpirun abort) | el-ph MPI process aborted | inspect rep that aborted; re-fire GPU; LuH10-N falsifier axis (see above) | mid |
| ScBeH8 | 38954037 | 10 | 2/0 | "not recoverable" | DFPT interrupted | re-fire from scratch; GPU | low |
| **ThH10** | **38954231** | 11 | 2/0 | **DIVERGED** — Fermi shift −7.1456E+03, ddv_scf 1.638E+03, roots not converged | **numerical instability (NOT just a kill)** — metallic DFPT diverging | **PARAM-TUNE before re-fire**: add `alpha_mix=0.3`, `nmix_ph`, finer SCF, possibly larger `degauss`/`nbnd`; this is the d6 wall-class case (canary candidate per prior DEFERRED row) | **PARAM-TUNE** |
| ScH9 | 38954402 | 10 | 5/3 | signal 18 (suspended) | el-ph killed after q3 elph (most progress of the 10-atom set) | resume from `harvest_partial` (5 dyn / 3 elph) on GPU — closest to terminal | high |
| SrPtH3 | 38954645 | 5 | 6/4 | "not recoverable" | DFPT done thru q4 SCF then killed | re-fire from dyn0 (5-atom cheap); 6 dyn already harvested | mid |
| YAuH3 | 38955010 | 5 | 6/4 | "not recoverable" (rep#4 converged then killed) | el-ph near-complete, killed at rep4 | resume from `harvest_partial` (6 dyn / 4 elph) — closest to terminal of the 5-atom set | high |
| YBeH8 | 38955211 | 10 | 2/0 | "not recoverable" | DFPT interrupted after q1 | re-fire from scratch; GPU | low |
| YH9 | 38955371 | 20 | 2/0 | signal 18; pod uptime 1454h (~60d) | 20-atom el-ph killed early; **oldest pod by far** | ≥20-atom → GPU; resume dyn0; teardown this host after harvest (60d uptime) | mid |
| YSbH6 | 38955554 | 8 | 2/1 | MPI_ABORT exit 1 | el-ph MPI abort after q1 elph | inspect aborting rep; re-fire GPU from dyn0 | low |

**Closest-to-terminal (most harvestable, prioritize resume)**: ScH9 (5dyn/3elph), YAuH3 (6/4), SrPtH3 (6/4), H3S (6/4), BaAuH3 (4/2).
**Param-tune required (NOT a plain resume)**: ThH10 — DFPT numerically diverged (d6 first-principles tuning, not a re-fire).
**NONE deleted** (d_defer_no_delete) — all 14 stay in the pool; the live billing pods are the leak (see PROCESS log).

### 2026-06-02 — RECOVER-THEN-TEARDOWN complete (all 14 pods destroyed, ~$84/day leak STOPPED)

All 14 `rtsc-discovery` pods above were **harvested then torn down** to stop the
idle-billing leak. The teardown removed only the **POD** (the billing meter) —
**every candidate REMAINS in the pool** with its retry recipe in the table above.
Each candidate's partials were pulled to `exports/rtsc/<candidate>/harvest_partial/`
(plus the `vc-relax.in`/`scf.in`/`ph.in` so it is fully re-runnable). Harvest used
`tar | base64` over the working `hexa cloud run` channel because the vast.ai proxy
endpoint blocks `scp`/`rsync` (both exited 1; the interactive ssh exec works).

| candidate | pod | harvested (files in harvest_partial) | teardown |
|---|---|---|---|
| BaAuH3 | 38950641 | 7 (5 dyn / 2 elph / ph.out) | ✅ destroyed |
| H3S | 38950897 | 11 (6 dyn / 4 elph / ph.out) | ✅ destroyed |
| CeH9 | 38951764 | 3 (2 dyn / ph.out) | ✅ destroyed |
| LaBH8 | 38952197 | 3 (2 dyn / ph.out) | ✅ destroyed |
| LaBeH8 | 38952382 | 5 (3 dyn / 1 elph / ph.out) | ✅ destroyed |
| LuH10 | 38952686 | 3 (2 dyn / ph.out) | ✅ destroyed |
| ScBeH8 | 38954037 | 3 (2 dyn / ph.out) | ✅ destroyed |
| ThH10 | 38954231 | 3 (2 dyn / ph.out) | ✅ destroyed |
| ScH9 | 38954402 | 9 (5 dyn / 3 elph / ph.out) | ✅ destroyed |
| SrPtH3 | 38954645 | 11 (6 dyn / 4 elph / ph.out) | ✅ destroyed |
| YAuH3 | 38955010 | 11 (6 dyn / 4 elph / ph.out) | ✅ destroyed |
| YBeH8 | 38955211 | 3 (2 dyn / ph.out) | ✅ destroyed |
| YH9 | 38955371 | 4 (2 dyn / ph.out / scf.out) | ✅ destroyed |
| YSbH6 | 38955554 | 6 (2 dyn / 1 elph / ph.out / scf.out / refresh.tgz) | ✅ destroyed |

**Re-fire path**: each candidate stays in the table above — re-fire from its DEFERRED
recipe (resume from `exports/rtsc/<candidate>/harvest_partial`, or re-run from scratch
per the per-class note). 14/14 destroyed, confirmed via `hexa cloud down --force`
("destroyed (confirmed)") + post-check that none resolve on vast. Protected pods
(gate anchors 38943553/38922322, 38704336, @anima/@edge/@wt-h874, 4 runpod ghosts)
were NOT touched.
