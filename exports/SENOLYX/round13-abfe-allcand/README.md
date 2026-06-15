# SENOLYX ABFE compute harness (round13-abfe-allcand)

Reusable absolute-binding-free-energy (ABFE) harness for SENOLYX candidate screening on
rented **vast.ai** GPU pods. One pod runs ≥1 `TARGET:REP` cell; each cell is a full
double-decoupling ABFE (complex + solvent legs, 20-window λ-schedule, MBAR) for one
ligand against its receptor, with K replicas ensemble-averaged per target.

This directory is the **SSOT** for how to operate the harness. It has been hardened
against the 6 failure modes observed in the live R12 (HSP90) / R13 (candidate) campaign
— see the [prevention table](#6-prevention-table) below.

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
| `runcells_cand.sh` | **Per-pod retry-resume launcher** — the ONLY sanctioned way to launch production cells. |
| `fanout_cand.sh` | Rent N pods, **copy-verify** files, launch `runcells_cand.sh`, write `cand_pods.tsv`. |
| `harvest_cand.sh` | Poll every pod (stdin-protected ssh loop), aggregate `ENS_RESULT` → `RESULT.txt`. |
| `watch_cand.sh` | Background poller — runs `harvest_cand.sh` every 6 min until all cells done / timeout. |
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

# 2) watch — background poller (harvests every 6 min); writes RESULT.txt:
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

- **Production cells launch ONLY through `runcells_cand.sh`** — never a bare `python abfe_cand.py &` (no crash recovery; that killed the manual 17AG/0 cell in R12).
- Every vast ssh/copy uses `--insecure --port <PORT>` and redirects remote-call stdin from `</dev/null` inside `while read` loops.
- `recover.sh reap` only ever touches `senolyx-*`-owned pods absent from BOTH manifests. The RTSC pod (`41001569`) and all manifest pods can never match.
- New pods are rented only by `fanout_cand.sh`. Re-rent on pod loss is manual.

## 6-prevention table

Each is a root-cause fix (c1) for a failure mode that actually occurred in the live campaign.

| # | Failure mode (observed) | Root cause | Fix |
|---|-------------------------|-----------|-----|
| 1 | Ligand clashes in tight/buried pocket → NaN at equilibration | Ideal conformer overlaid by centroid clashes in narrow grooves | `abfe_cand.py` prefers `lig_<RESN>_bound.sdf` (clash-free co-crystal pose from `extract_pose.py`) and **skips recenter** when bound; falls back to ideal+centroid if absent. Bound SDFs pre-generated for all 3 targets (3CQ/70R/EF2). |
| 2 | Harvest tallied only the FIRST pod | `ssh` inside a `while read` loop drains the loop's stdin pipe, swallowing remaining HOST/PORT lines | `</dev/null` on the remote call in both `harvest_cand.sh` and `../round12-rbfe/harvest.sh`, with a WHY comment. |
| 3 | A pod launched a doomed `runcells` after a silent copy failure | `copy-to` returned non-fatally; missing file only surfaced at runtime | `fanout_cand.sh` (+ `fanout_ens.sh`) **copy-verify**: after each copy, ssh `test -f`; retry ≤3×; if a required file is still missing, **abort that pod** and record `COPY_FAIL` in the manifest instead of launching. |
| 4 | Manual 17AG/0 production cell died and never recovered | Launched as a bare `python &` — no retry, no resume | Header on `runcells_cand.sh`: production cells MUST go through the retry-resume wrapper (≤4 attempts, resuming from per-rep `abfe_{leg}_rep{REP}.nc`). |
| 5 | A healthy mid-run pod torn down on a momentary ssh failure | ssh failure mis-read as pod death | `recover.sh alive` ssh-probes, and on ssh failure asks `hexa cloud alive <id>` — only **GONE/STOPPED** declares death; **RUNNING** = transient blip, report + do nothing. |
| 6 | Leaked `senolyx-*` pods billed with no assigned cell | No manifest-diff sweep | `recover.sh reap [--apply]` lists live vast pods owned by `senolyx-*` but absent from BOTH manifests (`ens_pods.tsv` + `cand_pods.tsv`); dry-run by default. RTSC + manifest pods never match. |
