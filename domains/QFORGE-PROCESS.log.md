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
