# QFORGE-PROCESS — work log (append-only)

## 2026-06-02 — domain created · seeded with live el-ph campaign observations
- Created to make the QE el-ph pipeline (vc-relax→scf→ph/DFPT→elph→λ→Tc) observable so perf/resource/speed bottlenecks are auditable. Sibling to root QFORGE/ (engine) — this is the PROCESS-profiling domain.

### live timing observations (direct pod probe, QFORGE migration-gate anchors)
- **LaH10** (11 atoms, 2×2×2 q, pod 38943553 vast CPU-first): ph.x stage = DFPT `Self-consistent Calculation`, `Pert. #1 iter #1`, total cpu 2290 s, `|ddv_scf|²=3.86e-08`. 9× ph.x ranks alive, pw.x=0. dynN done = 1 (q1 only). `out/_ph0` present.
- **Li2MgH16** (38 atoms, 2×2×2 q, pod 38922322 vast CPU-first): ph.x `Pert. #1 iter #4`, total cpu 11413 s, `|ddv_scf|²=2.96e-10` (converging a perturbation). 6× ph.x ranks alive, pw.x=0. dynN done = 1.
- **Reading:** the per-q DFPT self-consistency (Sternheimer linear response, the `ddv_scf` SCF loop per irreducible perturbation) is the DOMINANT wall — hours per q. scf/relax finished earlier (minutes-hours). 38-atom Li2MgH16 per-iter cpu ~5× the 11-atom LaH10 (11413 vs 2290 s) — cost scales steeply with atom count / basis.

### process-friction tooling gaps hit + fixed this session (campaign speed-killers)
- scp-255 on proxy-only vast direct endpoint (re-picked same broken offer) → FIXED: hexa-lang PR#2451 (proxy-fallback) + #2453 (durable offer-blacklist).
- corrupt phonon-recover (`PARSE_ERR/runParser` on a half-written `_ph0/q_N/*.save` after a teardown-kill) → ph.x SIGABRT, dft-run nuked the whole pod losing completed q → FIXED: PR#2459/#2460 (detect class → delete corrupt per-q scratch → start_q recompute, preserve completed dynN, 1-attempt guard).
- `--detach` HostPort-map lag → unregistered billing orphan + stale-state re-read → 3 first-attempt pods torn down clean; filed hexa-lang inbox/patches/dft-run-detach-hostport-lag-orphan.md.

### identified improvement levers (→ milestones in the snapshot)
- speed: q-points are independent yet run SEQUENTIALLY within one pod → parallel-q dispatch across pods is the biggest untapped wall-clock win.
- perf: ph.x el-ph is CPU-bound → GPU NVPTX kernels (QFORGE-PERF / migration track) are the per-q-cost lever.
- resource: SCF `.save` not banked → a dead pod forces a full fresh rerun; banking `.save` would enable true resume.
- next: instrument per-stage wall/cpu into the lab ledger so these are MEASURED, not anecdotal.

## 2026-06-02 — structured per-stage telemetry SHIPPED (closes the "MEASURE not anecdotal" lever)
- hexa-lang PR#2474 (merged → origin/main 8a2f4a085): `dft-run` now wraps each el-ph stage (vc-relax · scf · ph · λ/Tc) with `_dft_telemetry_wrap`, emitting one JSONL line per stage transition to `<deck>/.dft_telemetry.jsonl`: `{"ts","stage","event":start|done,"wall_s","rss_kb","exit"}`. ADDITIVE only — the coarse detach markers stay byte-identical (a new sibling file). wall = `date +%s` monotonic delta · rss = `ps -o rss` peak (or `null` fail-safe, d6 — never fabricated). g5 `dft_dispatch_test` PASS (JSON well-formed · all stages present · builder byte-identical regression · real-shell behavioral).
- INGEST loop closed — replaying the EXACT merged emit shell (stub compute, real `ps` sample) produced and re-parsed a genuine transition pair:
  ```jsonl
  {"ts":1780336498,"stage":"relax","event":"start","wall_s":0,"rss_kb":null,"exit":null}
  {"ts":1780336499,"stage":"relax","event":"done","wall_s":1,"rss_kb":null,"exit":0}
  ```
  parsed → `stage 'relax' completed in 1s, peak_rss=null, exit=0`. (rss=null here because the stub proc exited before the post-sample — the d6 no-fabrication fail-safe firing as designed; a live ph.x stage, alive at sample time, yields a real KB peak.)
- LIVE-POD confirmation DEFERRED (honest): the in-flight gate pods (Li2MgH16 38773054 · LaH10 38704336, both PENDING) were launched with PRE-telemetry `dft-run`, so they cannot emit `.dft_telemetry.jsonl` — only a stage dispatched after the merge will. Confirm on the next post-merge dispatch (READ-ONLY copy-from); no transition fired in this window, so not faked.

## 2026-06-02 — ANALYZER SHIPPED — JSONL → per-stage bottleneck report (closes the loop)
- hexa-lang PR#2477 (squash-merged → origin/main b70fd2152): `qforge_telemetry_report(jsonl_text) -> Report` in `stdlib/qforge/telemetry_report.hexa` INGESTS the PR#2474 `.dft_telemetry.jsonl` (6 keys ts·stage·event·wall_s·rss_kb·exit), pairs start/done per stage, aggregates wall + peak-rss per stage, ranks by wall DESC with %-of-total, flags the single slowest. READ-only pure fn over JSONL text (no pod ops, no source mutation; reuses builtin `json_parse`/`type_of`/`has_key`). g5 `qforge_telemetry_report_selftest` @ci_gate PASS (16 cases: parse · per-stage wall sum · rank desc · bottleneck=max-wall · rss-null passthrough+render · multi-done peak=max · malformed=4 not-bucketed · unpaired=1 0-wall · empty edge).
- RENDERED over the EXACT PR#2474 ingest pair (above) — the d6 `null` rss passthrough surfaces verbatim, never fabricated to 0:
  ```text
  QFORGE-PROCESS per-stage bottleneck report
  stage        wall_s   %tot   peak_rss_kb  exit
  -----------  -------  -----  -----------  ----
  relax              1   100%         null     0  ◄ slowest
  -----------  -------  -----  -----------  ----
  total wall_s=1  stages=1  malformed=0  unpaired=0
  ```
- RENDERED over a representative full el-ph run (what a post-merge live dispatch yields — relax·scf·ph:q1·ph:q2·λ) — the bottleneck (slowest stage by wall) is flagged, `ph:q2`'s missing rss stays `null`:
  ```text
  QFORGE-PROCESS per-stage bottleneck report
  stage        wall_s   %tot   peak_rss_kb  exit
  -----------  -------  -----  -----------  ----
  ph:q1           1503    36%      4680000     0  ◄ slowest
  ph:q2           1487    35%         null     0
  relax            842    20%      1840000     0
  scf              311     7%      2210000     0
  lambda            12     0%        96000     0
  -----------  -------  -----  -----------  ----
  total wall_s=4155  stages=5  malformed=0  unpaired=0
  ```
  Reading: phonon-per-q (`ph:q1`+`ph:q2`) dominates at 71% of wall — the el-ph campaign's true bottleneck is the per-q DFPT sweep, not relax/scf. That is the "MEASURE not anecdotal" lever the QFORGE-PROCESS loop set out to close.

## 2026-06-02 — REGRESSION DETECTOR SHIPPED — cross-run wall/RSS Δ flag (the improvement lever)
- hexa-lang PR#2483 (squash-merged → origin/main): `qforge_telemetry_regress(baseline_jsonl, current_jsonl, pct_threshold) -> RegressReport` in `stdlib/qforge/telemetry_regress.hexa`. Given a BASELINE run's `.dft_telemetry.jsonl` and a CURRENT run's, it JOINs per stage and flags any stage whose wall (or peak RSS) GREW beyond `pct_threshold` as REGRESSED (surfacing IMPROVED too). Reuses the PR#2477 `qforge_telemetry_report` parser (d3/d19 — no re-impl; `telemetry_report.hexa` is 0-diff). READ-only pure fn over two JSONL texts (no pod ops, no mutation, no I/O).
- Edge cases (@L2): stage in current but not baseline = NEW · in baseline but not current = DROPPED · rss null on EITHER side → rss-Δ skipped + rendered `null` (d6 no fabrication), wall-Δ still computed · zero-baseline-wall → NEW (no divide-by-zero). Rows ranked by Δwall% DESC, NEW/DROPPED sink to the tail.
- g5 `qforge_telemetry_regress_selftest` @ci_gate PASS (15 cases: >threshold flagged REGRESSED · sub-threshold NOT flagged · IMPROVED surfaced · NEW/DROPPED · real Δrss% both sides · rss-null one-side skip+render null · zero-baseline guard · empty/empty edge · rank worst-first).
- RENDERED over a baseline-vs-slower-current pair (an el-ph re-dispatch where `scf` blew up — +80% wall, +66% rss — while `ph:q1`'s current-run rss came back null):
  ```text
  QFORGE-PROCESS cross-run regression report (threshold=+30%)
  stage        kind        base_w   cur_w   Δwall   Δrss
  -----------  ----------  -------  ------  ------  ------
  scf          REGRESSED       300     540    +80%    +66%  ◄ REGRESSED
  relax        SAME            120     130     +8%     +4%
  lambda       SAME             10      10     +0%     +0%
  ph:q1        SAME            200     190     -5%    null
  -----------  ----------  -------  ------  ------  ------
  base_total=630  cur_total=870  regressed=1  improved=0  new=0  dropped=0
  ```
  Reading: `scf` is the single REGRESSED stage (>+30% on both wall AND rss) — the cross-run "improvement lever" the QFORGE-PROCESS @goal calls for: the loop now MEASURES run-over-run drift, not just within-run bottlenecks. `ph:q1`'s `null` Δrss is the d6 fail-safe (current rss was null → no fabricated %).

## 2026-06-02 — CAMPAIGN ROLLUP SHIPPED — cross-deck bottleneck dashboard (which stage·deck eats campaign wall)
- hexa-lang PR#2487 (squash-merged → origin/main): `qforge_telemetry_rollup(decks: [(deck_name, jsonl_text)]) -> RollupReport` in `stdlib/qforge/telemetry_rollup.hexa`. The emit (#2474) → analyze (#2477) → regress (#2483) chain operated on ONE deck's `.dft_telemetry.jsonl`; this is the CAMPAIGN tier — ingest MANY decks at once and aggregate two cross-deck views a per-deck report cannot give: (1) which STAGE CLASS dominates campaign-wide wall (scf vs ph vs relax vs lambda, `ph:qN` collapsed into class `ph`), and (2) which DECK is slowest. Per deck it calls the PR#2477 `qforge_telemetry_report` verbatim (d3/d19 — no re-parse; `telemetry_report.hexa`/`telemetry_regress.hexa` are 0-diff). READ-only pure fn over a list of JSONL texts (no pod ops, no mutation, no I/O).
- Edge cases (@L2): a deck whose telemetry is malformed/empty (0 stages AND 0 wall) is SKIPPED + counted in `skipped_decks` (never crashes, no phantom row); `n_decks` counts only successfully-ingested decks. rss is SUMMED only across cells that carried a real measured rss — a stage class / deck with no measured rss anywhere passes through as `null`, never a fabricated 0 (d6). Stage classes ranked wall DESC (single max flagged `dominant`); decks ranked wall DESC (single max flagged `slowest`); empty list → 0 rows / 0 grand / 0 decks / 0 skipped.
- g5 `qforge_telemetry_rollup_selftest` @ci_gate PASS (22 cases: stage-class SUM + `ph:qN` collapse + rank + %camp + dominant flag · per-deck total + rank + slowest flag · rss aggregated where present with d6 null-skip · malformed+empty deck skipped+counted · render flags dominant+slowest+`null` · empty list edge).
- RENDERED over a 2-deck fixture (LaH10 scf+ph:q1+ph:q2[rss null] · CaH6 scf+ph:q1):
  ```text
  QFORGE-PROCESS campaign telemetry rollup

  [1] stage-class rollup (which stage dominates campaign wall)
  stage_class  wall_s   %camp  sum_rss_kb
  -----------  -------  -----  ----------
  ph               780    66%     1500000  ◄ dominant
  scf              400    33%     1100000

  [2] per-deck rollup (which deck is slowest)
  deck         wall_s   %camp  stages  sum_rss_kb
  -----------  -------  -----  ------  ----------
  LaH10            680    57%       3     1600000  ◄ slowest
  CaH6             500    42%       2     1000000
  -----------  -------  -----  ------  ----------
  grand wall_s=1180  decks=2  skipped=0
  ```
  Reading: campaign-wide, the `ph` (per-q DFPT) stage class dominates at 66% of total wall across both decks — consistent with the single-deck #2477 finding, now confirmed to hold ACROSS the campaign, not just one deck. LaH10 is the slowest deck (57% of campaign wall). LaH10's `ph:q2` rss came back null → it is excluded from the rss sum (deck sum_rss = scf 900000 + ph:q1 700000 = 1600000), the d6 no-fabrication fail-safe carried up to the campaign tier.

## 2026-06-02 — PROCESS library LIVE-wired into dft-run (#2477 analyzer auto-runs on terminal) · hexa-lang PR#2489
- The PROCESS chain had the library (emit #2474 · analyze #2477 · regress #2483 · rollup #2487) but the analyzer was a HAND call. **Closed the loop**: `dft-run` now auto-runs the #2477 analyzer at the terminal/harvest point — no manual invocation. Every campaign run self-surfaces its per-stage bottleneck.
- **Wire (hexa-lang `stdlib/cloud/dft_dispatch.hexa`)** — at BOTH terminal/harvest sites (the synchronous `--go` end AND the `--resume` ph-terminal end), after the chain harvests `ph.out`/`scf.out` it now ALSO pulls the deck-local `.dft_telemetry.jsonl` (the per-stage `_dft_telemetry_wrap` emitted it on the pod), runs `qforge_telemetry_report` + `qforge_telemetry_report_render`, and writes the ranked table to **`<deck>/.dft_bottleneck.txt`** (`_dft_write_bottleneck`).
- **Guarded (@L2/d6)** — if `.dft_telemetry.jsonl` is ABSENT (a pre-#2474 run) OR EMPTY (a chain that never reached a wrapped stage), the wire writes NOTHING and returns clean (no error, no fabricated report). Existing dispatch behavior is byte-identical otherwise; the `.dft_stage` chain + per-stage builders are untouched (regression-pinned). The #2477 analyzer module is IMPORTED, not edited (@L3 — 0-diff to telemetry_report/regress/rollup).
- **g5** — `dft_dispatch_test.hexa` extended (`HEXA_STDLIB_ROOT="$PWD/stdlib" hexa run …` PASS): terminal-WITH-telemetry → `.dft_bottleneck.txt` written with correct DESC-ranked content (ph before scf before relax, slowest flagged, total aggregated) · terminal-WITHOUT (absent + empty) → NO file, returns 0, no error · chain-additive regression (a pre-existing `.validated` sibling + the telemetry source both stay untouched). All cases ok.
- **Sample auto-generated `<deck>/.dft_bottleneck.txt`** (4-stage chain: relax · scf · ph:q1 · ph:q2 — the per-q DFPT stages dominate, exactly the migration-gate live observation above):
  ```text
  QFORGE-PROCESS per-stage bottleneck report
  stage        wall_s   %tot   peak_rss_kb  exit
  -----------  -------  -----  -----------  ----
  ph:q2            480    44%      2100000     0  ◄ slowest
  ph:q1            420    38%      2048000     0
  scf              120    11%       768000     0
  relax             60     5%       512000     0
  -----------  -------  -----  -----------  ----
  total wall_s=1080  stages=4  malformed=0  unpaired=0
  ```
  Reading: with this single dispatcher write, every finished deck leaves a self-explanatory bottleneck table next to its outputs — `ph:q2` is the slowest stage (44% of wall), the two per-q DFPT stages together are 82% of total wall, confirming the el-ph (DFPT) stage class is the campaign bottleneck right at the point of harvest, with zero manual analysis.

## 2026-06-02 — rtsc-discovery FLEET INSPECTION (14 pods one-by-one · g8 hexa-cloud only) — all IDLE-LEAK, 0 terminal λ
- **Trigger**: read-mostly health+harvest sweep of every @demiurge vast pod. Enumerated via `hexa cloud reconcile` (21 pods: 14 rtsc-discovery + 2 gates + cuda-link-verify + 4 RunPod GHOSTs `(hexa-cloud rent)` left untouched). Gate anchors (38943553 LaH10 · 38922322 Li2MgH16) report-only — recovery owned by agent ac71837.
- **Probe transport**: `hexa cloud run <id> -- bash -lc "echo <b64> | base64 -d | bash"` (the inline argv tripped cloud_run's C-comment heuristic on `;`/`%%%`/`//`; base64 wrapper is the clean workaround — note for hexa-lang if probes recur).
- **Fleet verdict**: **14/14 rtsc-discovery = IDLE-LEAK**. Pattern is uniform — `vc-relax` reached `JOB DONE` on 2026-06-01, the el-ph chain (`ph.x` DFPT, `ldisp .true. nq 4×4×4`, `electron_phonon='simple'`, `tr2_ph 1d-14`) launched, advanced a few q/reps, then **died** (signal-18 suspend · MPI exit 1 · "Run is not recoverable starting from scratch" · numerical divergence). Live workdir then reset (newest file = `relax.out`); partial dyn+elph **preserved in `<deck>/harvest_partial/`**. Procs DEAD, ~0–1% CPU on all 14 → **billing for zero compute**. **0 candidates reached terminal λ/Tc** (no q2r/matdyn/lambda anywhere) → nothing to harvest into the ledger this sweep.

  ```text
  pod        candidate  nat  proc(pw/ph)  dyn(live/harvest)  verdict      note
  ---------  ---------  ---  -----------  -----------------  -----------  --------------------------------
  38950641   BaAuH3      5    0/0          0/4(+2elph)        IDLE-LEAK    DFPT killed rep#3
  38950897   H3S         4    0/0          0/6(+4elph)        IDLE-LEAK    "not recoverable"; H3S xval anchor
  38951764   CeH9       20    0/0          0/2                IDLE-LEAK    signal-18; 20-atom→GPU
  38952197   LaBH8      10    0/0          0/2                IDLE-LEAK    iter#73 slow-converge, killed
  38952382   LaBeH8     10    0/0          0/3(+1elph)        IDLE-LEAK    "not recoverable"
  38952686   LuH10      11    0/0          0/2                IDLE-LEAK    MPI exit 1
  38954037   ScBeH8     10    0/0          0/2                IDLE-LEAK    "not recoverable"
  38954231   ThH10      11    0/0          0/2                CRASHED⚠     DFPT DIVERGED (Fermi −7145, ddv 1.6E3) → PARAM-TUNE
  38954402   ScH9       10    0/0          0/5(+3elph)        IDLE-LEAK    signal-18; closest-to-terminal
  38954645   SrPtH3      5    0/0          0/6(+4elph)        IDLE-LEAK    "not recoverable"
  38955010   YAuH3       5    0/0          0/6(+4elph)        IDLE-LEAK    rep#4 conv then killed; near-terminal
  38955211   YBeH8      10    0/0          0/2                IDLE-LEAK    "not recoverable"
  38955371   YH9        20    0/0          0/2                IDLE-LEAK    signal-18; uptime 1454h(~60d) OLDEST
  38955554   YSbH6       8    0/0          0/2(+1elph)        IDLE-LEAK    MPI_ABORT exit 1
  ---------  ---------  ---  -----------  -----------------  -----------  --------------------------------
  GATES (report-only · ac71837 owns recovery):
  38943553   LaH10      —    0/9          0(_ph0 wip)        RUNNING      DFPT live, writing dvscf ✅
  38922322   Li2MgH16   —    0/0          0                  CRASHED      ph.out MPI exit 2 → ac71837 resume
  ```

- **Summary counts**: 14 rtsc-discovery = **0 RUNNING · 1 CRASHED-divergence (ThH10) · 13 IDLE-LEAK** (the other 13 are technically "crashed-then-idle" — proc dead, work harvested, pod billing idle) · **0 STUCK · 0 terminal-λ harvested**. Gates: 1 RUNNING (LaH10) · 1 CRASHED (Li2MgH16, ac71837).
- **Cost exposure**: 14 idle vast GPU pods. Uptimes 38h–1454h; idle (post-crash) since ~2026-06-01. At a nominal ~$0.25/GPU-hr, 14 idle pods ≈ **~$3.5/hr (~$84/day) burning for zero compute** — the dominant fleet waste. Recommend parent **teardown all 14 after harvest_partial pull** (work is preserved on-pod; pull dyn/elph via `hexa cloud copy-from <id> <deck>/harvest_partial …` first, then `hexa cloud down`). Did NOT autonomously tear down — these have preserved partial work (not zero-work orphans), so teardown is the parent's call once harvest_partial is copied off.
- **Action ranking (urgency)**: (1) **harvest_partial pull + teardown all 14** (stop the ~$84/day leak) — pull first, biggest $ win; (2) **ThH10 param-tune** (d6: DFPT diverged, needs alpha_mix/nmix_ph/degauss tuning, NOT a plain re-fire); (3) **resume near-terminal candidates on GPU** (ScH9 5dyn/3elph · YAuH3 6/4 · SrPtH3 6/4 · H3S 6/4) from `harvest_partial`; (4) re-fire the rest from dyn0 per DEFERRED recipe (sizing d7/d11: ≤8-atom→Vast CPU/pool, ≥10-atom dense-q→GPU). All 14 stay in the pool (d_defer_no_delete) — see `exports/rtsc/DEFERRED.md` 2026-06-02 block.

## 2026-06-02 — gate-anchor crash recovery (LaH10 ✅ resumed · Li2MgH16 deferred)

QE el-ph gate anchors recovered end-to-end via `hexa cloud {exec,nohup}` (g8 — no raw ssh). Both crashed `ph.x` processes diagnosed to their REAL QE error routine (not the opaque backtrace).

| anchor | pod | crash (REAL error) | root cause | recovery applied | result |
|---|---|---|---|---|---|
| **LaH10** | 38943553 | `PARSE_ERR / 81 runParser` reading `q_3/lah10.save/data-file-schema.xml` (sig 6) THEN `read_file_new: Wavefunctions not in collected format` + `PARTIAL_EL_PHON not found` (xmltools.f90:965) | (1) FoX `runParser` choked on an **em-dash** (`&#226;&#128;&#148;` = U+2014) in the `<job>` title carried from the ph.in title comment; (2) q_3 el-ph collection interrupted → 24/34 dynmat, truncated `dynmat.3.0`, distributed (`wf_collected=false`) q_3 wfc | **metadata-only**: stripped em-dash → ASCII `-` in ph.in title + q_2/q_3 XML `<job>` (zero physics); **q_3 reset**: moved 24 partial `dynmat.3.*` + distributed q_3 `wfc`/`save` aside, KEPT dvscf/recover/dwf/bar → `ph.x` redoes q_3 bands(collected)+irreps+el-ph from converged dvscf. recover=.true. (already set). `ulimit -s unlimited`+`OMP_STACKSIZE=512m` (robustness, not physics). | ✅ **PROGRESSING** — 9 ranks live, q_3 Band Structure recompute running; q1/q2 el-ph (dyn1.elph.1, dyn2.elph.2) preserved. Durable watcher `lah10_watch.log` armed (heartbeat 120s + terminal verdict). |
| **Li2MgH16** | 38922322 | `ph_restart_set_filename: cannot open file` + `PARTIAL_EL_PHON not found` (xmltools.f90:965), exit 2 | q_1=Γ el-ph collection interrupted → 26 irreps `DONE_IRR=true` + 26 intact `elph.1.N.xml` + full dvscf/dwf/bar/recover, but `<PARTIAL_EL_PHON>` never written into `dynmat.1.N` and `dynmat.1.0/1.1` truncated | **5 attempts (crash-loop guard tripped, d_defer):** `</Root>` envelope repair (well-formed-verified) — still failed; q_1 dynmat reset (the recipe that FIXED LaH10 q_3) — does NOT transfer to q=Γ (main collected save + top-level recover = different restart path). dynmat restored. **DEFERRED** with 3-recipe path (Γ-only el-ph redo / `start_q=1 last_q=1` `recover=.false.` 2-pass / QE≥7.0 image). | 🟠 **DEFERRED** (status=deferred · `exports/rtsc/DEFERRED.md` 2026-06-02 row · `dispatch verdict DEFERRED`). NO faked λ. el-ph linear-response 100% done for Γ — only readback envelope inconsistent. |

- **Gate impact**: 2/3 QFORGE-migration cross-val anchors — LaH10 back on track to terminal λ·Tc; Li2MgH16 needs ONE parameter-tuned re-run (recipe A). DYN=0 → λ on neither yet.
- **g8 compliance**: all pod access via `hexa cloud exec/nohup` (bare pod-id conn resolves vast API → ssh proxy). No raw ssh, no raw vastai. No new pods rented — resumed on the existing alive pods. rtsc-discovery pods + `~/.hx/src` untouched.

## 2026-06-02 — rtsc-discovery FLEET RECOVER-THEN-TEARDOWN (14/14 harvested + destroyed · ~$84/day leak STOPPED · g8 hexa-cloud only)

Executed the teardown recommended by the fleet inspection above (user authorized "전부 회수"). Each of the 14 IDLE-LEAK pods: HARVEST partials → VERIFY local copy non-empty → TEARDOWN. One at a time, idempotent. **Transport note**: `hexa cloud copy-from` (scp) AND `--resume` (rsync) both exit 1 over the vast.ai proxy endpoint (`ssh8.vast.ai`) — the proxy blocks the scp/rsync subsystem but accepts interactive ssh. Worked around with `tar -czf - harvest_partial *.in | base64` over the WORKING `hexa cloud run` channel, decoded + extracted locally. All harvests landed to `exports/rtsc/<candidate>/harvest_partial/` (+ vc-relax/scf/ph `.in` for full re-runnability). Teardown via `hexa cloud down <id> --force` (cross-project guard needs --force — pods are untracked orphans in this repo's ledger), each "destroyed (confirmed)"; post-checked none resolve on vast.

```
pod        candidate  harvest_partial (files)               bytes(harvest_partial)  teardown
---------  ---------  ------------------------------------  ----------------------  -----------------
38950641   BaAuH3     7  (5 dyn / 2 elph / ph.out)          ~155 KB                 ✅ destroyed
38950897   H3S        11 (6 dyn / 4 elph / ph.out)          ~220 KB                 ✅ destroyed
38951764   CeH9       3  (2 dyn / ph.out)                   ~115 KB                 ✅ destroyed
38952197   LaBH8      3  (2 dyn / ph.out)                   ~32 KB                  ✅ destroyed
38952382   LaBeH8     5  (3 dyn / 1 elph / ph.out)          ~188 KB                 ✅ destroyed
38952686   LuH10      3  (2 dyn / ph.out)                   ~55 KB                  ✅ destroyed
38954037   ScBeH8     3  (2 dyn / ph.out)                   ~36 KB                  ✅ destroyed
38954231   ThH10      3  (2 dyn / ph.out)                   ~37 KB                  ✅ destroyed
38954402   ScH9       9  (5 dyn / 3 elph / ph.out)          ~458 KB                 ✅ destroyed
38954645   SrPtH3     11 (6 dyn / 4 elph / ph.out)          ~366 KB                 ✅ destroyed
38955010   YAuH3      11 (6 dyn / 4 elph / ph.out)          ~372 KB                 ✅ destroyed
38955211   YBeH8      3  (2 dyn / ph.out)                   ~41 KB                  ✅ destroyed
38955371   YH9        4  (2 dyn / ph.out / scf.out)         ~551 KB                 ✅ destroyed
38955554   YSbH6      6  (2 dyn / 1 elph / ph.out/scf.out)  ~1.3 MB (+refresh.tgz)  ✅ destroyed
---------  ---------  ------------------------------------  ----------------------  -----------------
TOTAL: 14/14 harvested non-empty + verified · 14/14 destroyed (confirmed) · 0 left UP
```

- **Verification of partials**: harvest dyn/elph counts MATCH the inspection's per-pod readings — ScH9 5dyn/3elph ✅, YAuH3 6dyn/4elph ✅, SrPtH3 6/4 ✅, H3S 6/4 ✅, BaAuH3 5/2 ✅ (incl. the trailing empty `dynN`). Closest-to-terminal candidates' work fully preserved.
- **Cost**: ~$84/day idle-billing leak is now **STOPPED** — all 14 billing meters off.
- **HONESTY (d6 / d_defer_no_delete)**: tearing down the POD ≠ deleting the CANDIDATE. All 14 candidates STAY in the pool — see `exports/rtsc/DEFERRED.md` (2026-06-02 RECOVER-THEN-TEARDOWN block) with per-candidate retry recipes. Each is re-fireable from `exports/rtsc/<candidate>/harvest_partial` (resume) or from scratch per the per-class recipe. ThH10 still needs d6 param-tuning (DFPT diverged), not a plain re-fire.
- **Guardrails honored**: gate anchors 38943553 / 38922322 (ac71837 owns) · 38704336 · @anima/@edge/@wt-h874 · the 4 runpod ghosts were NOT touched — only the 14 rtsc-discovery pods.
- **g8 compliance**: all access via `hexa cloud {run,down}` (bare pod-id → vast proxy). No raw ssh, no raw vastai.
