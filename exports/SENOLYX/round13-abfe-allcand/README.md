# SENOLYX ABFE compute harness (round13-abfe-allcand)

Reusable absolute-binding-free-energy (ABFE) harness for SENOLYX candidate screening on
rented **vast.ai** GPU pods. One pod runs ≥1 `TARGET:REP` cell; each cell is a full
double-decoupling ABFE (complex + solvent legs, 20-window λ-schedule, MBAR) for one
ligand against its receptor, with K replicas ensemble-averaged per target.

This directory is the **SSOT** for how to operate the harness. It has been hardened
against the 10 failure modes observed in the live R12 (HSP90) / R13 (candidate) campaign
— see the [prevention table](#10-prevention-table) below.

> Sibling RBFE harness `../round12-rbfe/` shares the same fan-out / harvest / copy-verify
> pattern (`fanout_ens.sh`, `harvest.sh`, `runcells.sh`).

## Files

| File | Role |
|------|------|
| `abfe_cand.py` | The ABFE deck. Per-`(TARGET, REP)` double-decoupling + MBAR; emits `ENS_RESULT`. Prefers the clash-free **bound pose** `lig_<RESN>_bound.sdf`, else falls back to ideal-conformer + pocket-centroid recenter. |
| `pockets.json` | TARGET → `{pdb, lig (RESN), chain, center (Å), natoms}`. BCLXL=4QVX/3CQ/A · MCL1=5LOF/70R/A · CRBN=4CI1/EF2/B. |
| `extract_pose.py` | Builds `lig_<RESN>_bound.sdf` from a co-crystal PDB HETATM pose + ideal-SDF bond orders (needs **rdkit**). |
| `lig_<RESN>_bound.sdf` | Clash-free co-crystal bound poses (pre-generated for 3CQ/70R/EF2). |
| `bootstrap_cand.sh` | On-pod env build (micromamba `fep` env, `cuda-version=12.6` pin) + SMOKE + optional PROD. |
| `runcells_cand.sh` | **Per-pod retry-resume launcher** (runs on the pod). The wrapper `fire_cell.sh` is the launch contract. |
| `fire_cell.sh` | **Single launch entry** — `fire_cell.sh <r12\|r13> <CELL...>`; the ONLY sanctioned way to launch/resume production cells (wraps `runcells_*.sh`). |
| `fanout_cand.sh` | Rent N pods, **copy-verify** files, launch `runcells_cand.sh`, write `cand_pods.tsv`. |
| `harvest_cand.sh` | Poll every pod (stdin-protected ssh loop), **persist-merge** `ENS_RESULT` into `seen.prog` → `RESULT.txt`. |
| `watch_cand.sh` | Background poller — `harvest_cand.sh` every 6 min; **auto re-arms** until done/stall; **auto-down** (reap) on full completion. |
| `recover.sh` | `alive <host> <port> <id>` (ssh-blip alive-gate) · `reap [--apply]` (orphan pod reaper). |
| `cand_pods.tsv` | Manifest: `TARGET  REP  ID  HOST  PORT  STATUS` (one row per cell). |

## Pipeline (rent → copy-verify → runcells → harvest → watch → recover/reap)

```bash
# 0) (one-time, off-pod) generate bound poses — needs rdkit (e.g. summer `fep` env):
#    python extract_pose.py <PDB> <RESN> <CHAIN> lig_<RESN>.sdf lig_<RESN>_bound.sdf
#    abfe_cand.py auto-prefers lig_<RESN>_bound.sdf when present; falls back gracefully.

# 1) fan out — rents pods, COPY-VERIFIES each required file (retry≤3, abort pod on
#    persistent miss → COPY_FAIL in manifest), then launches the retry-resume runner:
bash fanout_cand.sh

# 1b) launch / RESUME a specific cell — the ONLY sanctioned launch path (fire_cell.sh).
#     Resolves each cell's pod from the manifest and fires the retry-resume runner.
#     NEVER `python abfe_cand.py &` by hand (no crash recovery — that killed MCL1:0 / 17AG/0).
bash fire_cell.sh r13 MCL1:0 CRBN:2     # r13 cells (TARGET:REP)
bash fire_cell.sh r12 17AG:0            # r12 cells (LIG:REP)

# 2) watch — background poller (harvests every 6 min); auto re-arms + auto-down:
nohup bash watch_cand.sh > watch_cand.log 2>&1 &

# 3) harvest on demand (idempotent; the watcher runs this for you):
bash harvest_cand.sh    # exit 0 = all 9 cells done, exit 2 = partial

# 4a) ssh blip? do NOT assume the pod died — alive-gate via the provider API:
bash recover.sh alive <host> <port> <id>
#     RUNNING → transient blip, do nothing.  GONE/STOPPED (exit 3) → really dead.

# 4b) leaked pod sweep — senolyx-* owned but in NEITHER manifest:
bash recover.sh reap            # dry-run report
bash recover.sh reap --apply    # destroy the orphans
```

### Hard operating rules

- **Launch contract — production cells launch/resume ONLY through `fire_cell.sh`** (which wraps the retry-resume runner `runcells_*.sh`). NEVER a bare `python abfe_cand.py &` (no crash recovery; that killed the manual 17AG/0 and MCL1:0 cells). There is now exactly ONE launch path.
- Every vast ssh/copy uses `--insecure --port <PORT>` and redirects remote-call stdin from `</dev/null` inside `while read` loops.
- `harvest_*.sh` **persist-merge** every observed `ENS_RESULT` into a durable `seen.prog` (never truncated) and tally from it — a transient SSH blip can never un-count a finished cell.
- The watcher **auto re-arms** (`exec "$0" "$@"` on per-arm budget while cells remain) so the campaign is never left unwatched, and exits cleanly on full completion or a multi-hour stall.
- On **confirmed full completion** the watcher calls **`recover.sh reap --apply`** (auto-down). `reap` only ever touches `senolyx-*`-owned pods absent from BOTH manifests — the RTSC pod (`41001569`) and all manifest pods can never match. Never fired on partial/blip.
- New pods are rented only by `fanout_cand.sh`. Re-rent on pod loss is manual; re-launch the cell with `fire_cell.sh`.

## 10-prevention table

Each is a root-cause fix (c1) for a failure mode that actually occurred in the live campaign.
Modes 1–6 shipped in PR #631; modes 7–10 were surfaced by the 24h unattended campaign.

| # | Failure mode (observed) | Root cause | Fix |
|---|-------------------------|-----------|-----|
| 1 | Ligand clashes in tight/buried pocket → NaN at equilibration | Ideal conformer overlaid by centroid clashes in narrow grooves | `abfe_cand.py` prefers `lig_<RESN>_bound.sdf` (clash-free co-crystal pose from `extract_pose.py`) and **skips recenter** when bound; falls back to ideal+centroid if absent. Bound SDFs pre-generated for all 3 targets (3CQ/70R/EF2). |
| 2 | Harvest tallied only the FIRST pod | `ssh` inside a `while read` loop drains the loop's stdin pipe, swallowing remaining HOST/PORT lines | `</dev/null` on the remote call in both `harvest_cand.sh` and `../round12-rbfe/harvest.sh`, with a WHY comment. |
| 3 | A pod launched a doomed `runcells` after a silent copy failure | `copy-to` returned non-fatally; missing file only surfaced at runtime | `fanout_cand.sh` (+ `fanout_ens.sh`) **copy-verify**: after each copy, ssh `test -f`; retry ≤3×; if a required file is still missing, **abort that pod** and record `COPY_FAIL` in the manifest instead of launching. |
| 4 | Manual 17AG/0 production cell died and never recovered | Launched as a bare `python &` — no retry, no resume | Header on `runcells_cand.sh`: production cells MUST go through the retry-resume wrapper (≤4 attempts, resuming from per-rep `abfe_{leg}_rep{REP}.nc`). |
| 5 | A healthy mid-run pod torn down on a momentary ssh failure | ssh failure mis-read as pod death | `recover.sh alive` ssh-probes, and on ssh failure asks `hexa cloud alive <id>` — only **GONE/STOPPED** declares death; **RUNNING** = transient blip, report + do nothing. |
| 6 | Leaked `senolyx-*` pods billed with no assigned cell | No manifest-diff sweep | `recover.sh reap [--apply]` lists live vast pods owned by `senolyx-*` but absent from BOTH manifests (`ens_pods.tsv` + `cand_pods.tsv`); dry-run by default. RTSC + manifest pods never match. |
| 7 | Manual cells (17AG/0, MCL1:0) died on the "terminate called" minimize abort and never recovered | TWO launch paths existed — the retry-resume runner AND bare manual `python &` (no recovery) | `fire_cell.sh <r12\|r13> <CELL...>` is the SINGLE sanctioned launch entry; it resolves each cell's pod from the manifest and fires it through the retry-resume runner (≤4 attempts, resume from per-rep `.nc`). Bare `python &` forbidden in README + `fire_cell.sh` header. |
| 8 | R12 ran UNWATCHED after its watcher self-exited at a fixed 7.5h budget | Fixed poll cap exited even while cells were still completing | `watch_cand.sh` / `watch.sh` loop until all-done OR no-progress for `STALL_HOURS`; on hitting the per-arm budget while cells remain they **re-exec themselves** (`exec "$0" "$@"`). Clean exit only on true completion or stall. |
| 9 | Count regressed (5→4) on a transient SSH blip → watcher could miss the final N/N | `harvest_*.sh` truncated `combined.prog` every poll, so a pod's blip dropped its finished cells' `ENS_RESULT` that poll | **Persist-merge**: append freshly-pulled `ENS_RESULT` into a durable `seen.prog` (never truncated) and tally from it. The count is monotone non-decreasing; dedup keep-last per cell stays in python. |
| 10 | Pods kept billing after the campaign finished | No completion → teardown link | On **confirmed full completion** (harvest exit 0 = all cells) the watcher calls `recover.sh reap --apply` (auto-down). Guarded: only on full completion (never partial/blip), and reap only touches `senolyx-*` orphans absent from BOTH manifests (RTSC + manifest pods safe). |

## 운영자(드라이버) 실수 방지 — operator gotchas

위 표(F1~F10)는 **컴퓨트 파이프라인**의 실패모드. 아래는 캠페인을 **모는 사람/에이전트가 반복한 운영 실수**와 그 차단책. 상태확인·발사·커밋 때 이걸 따른다.

| # | 운영 실수 (반복 관찰) | 근본원인 | 차단 |
|---|------------------------|----------|------|
| D1 | 상태확인 루프가 첫 pod만 조회 / `flag --port needs a value` | `while read` 안 ssh가 stdin 잠식(M1) · `set -- $hp` arg-split(M2) · macOS bash 3.2엔 `mapfile`/`${x,,}` 없음 | **`probe.sh <manifest> <workdir>` 만 쓴다**. heredoc-fed 루프 + ssh `</dev/null` + 명시 필드분리로 셋 다 차단. 손으로 while-read+ssh 루프 짜지 말 것. |
| D2 | `Read` 없이 `Edit` → 툴 에러 | 순서 누락 | 모든 파일 Edit 전 반드시 Read. |
| D3 | `commit` 없이 `pr-cycle` → 빈 브랜치, gh 실패 | stage≠commit | pr-cycle 전 반드시 `git commit`. (stage만으론 부족) |
| D4 | 한 leg가 결정론적으로 minimize abort 반복(예: MCL1:0 4회+) | resume·fresh-.nc 둘 다 그 pod에선 안 풀림 = 환경 결정론 | **K회(≤4) 실패하면 무한 retry 금지** — (a) 그 rep을 다른 pod로 재발사 OR (b) ensemble n−1 수용(이미 n≥2 양성이면 충분). 한 stuck rep이 캠페인을 막지 않게. |
| D5 | 머지한 watcher 신코드가 라이브에 미적용 | watcher는 in-memory 루프라 파일 재편집 무시 | watcher 코드 머지 후엔 watcher를 **재시작**해야 신코드 적용(F8 auto-rearm 포함). |

**상태확인 표준**: `bash probe.sh <manifest> <workdir>` (pod별 leg/proc/gpu) + `bash harvest*.sh`(누적 결과). SSH-blip 행은 죽음 아님 — `hexa cloud alive <id>`가 RUNNING이면 무시(F5).
