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

## 2026-06-01 — Li2MgH16 (QFORGE-gate anchor) DEFERRED — dft-run direct-endpoint scp255

| candidate | validated | action | note |
|---|---|---|---|
| Li2MgH16 | ✓ | ⛔ HELD-DEFERRED (confirmed scp-255 class · tooling blocker, NOT physics) | QFORGE migration-gate anchor (needs terminal QE λ·Tc). FRESH re-fire failed **×3** (instances 38917013, 38917304, **38917745**): `reachability OK` then `scp exit 255` → dft-run tore each down cleanly (zero orphan, verified via `hexa cloud reap --provider vast` dry-run — all 3 IDs absent). NOT transient — the offer's `--direct` bare-IP endpoint (116.101.122.173:59xxx) is proxy-only / refuses scp. **CRITICAL (2026-06-01): the changed recipe `--query "direct_port_count>=2"` did NOT bypass the broken offer — dft-run STILL re-picked 28919799 AND scp-255'd again.** So `direct_port_count` ≠ "scp works", and `--query` is ANDed into the search rather than excluding a known-bad pick. This is now a CONFIRMED class on this deck → per "stop auto-retrying a confirmed class on the SAME deck", NO further blind re-fires. **Blocker:** dft-run needs (a) scp proxy-fallback + (c) in-campaign offer blacklist (proposal (b) direct-port filter alone is insufficient — proven). **retry recipe (post-fix only):** `hexa cloud dft-run exports/rtsc/decks/Li2MgH16 --detach` once (a)+(c) land (offer 28919799 then auto-blacklisted + proxy-endpoint upload fallback). Interim manual route if needed: rent a known-direct/GPU offer by ID, `hexa cloud copy-to` the deck over the **proxy** endpoint (`hexa cloud resolve <id>` → sshN.vast.ai:PORT), launch relax there. d8 filed + updated (hexa-lang/inbox/patches/dft-run-direct-endpoint-scp255.md, 2026-06-01 section). |

note: LaH10 (sibling gate anchor) is UNAFFECTED — its prior pod 38704336 is alive (adopted, project=demiurge) and its phonon DFPT is RUNNING; poll `hexa cloud dft-run exports/rtsc/decks/LaH10 --resume` for terminal harvest.
