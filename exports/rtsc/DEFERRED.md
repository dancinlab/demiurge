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
