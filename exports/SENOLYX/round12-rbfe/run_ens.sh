#!/usr/bin/env bash
# SENOLYX R12-GOLD breakthrough ① — ensemble-average ABFE campaign driver.
#
# Runs K independent replicas of abfe_hsp90_ens.py per (LIG, REP) on the summer
# free RTX 5070, ensemble-averages each leg's dG (mean ± stderr over reps) BEFORE
# forming ΔΔG → averages out the bistable branch-landing that wrecked the gold pair.
#
# Grid:  LIG ∈ {17AG, 17AAG}  ×  REP ∈ {0..K-1}   (K=5 default)  = 2*K leg-runs.
#        Each leg-run = both legs (complex + solvent) of one (LIG, REP) ≈ 4-5 h.
#        Serial total ≈ 2*K*~4-5h  (~4 days at K=5 on one GPU). See ENSEMBLE_PLAN.md.
#
# Resilience contract (fixes the gold driver bug where rc=143 was wrongly skipped):
#   * flock-guarded — only one campaign process at a time.
#   * rc=0 SKIP-GUARD ONLY: a (LIG,REP) is skipped iff a prior run wrote its `.done`
#     marker (i.e. exited rc=0). A killed leg (rc=143/137/!=0) leaves NO marker, so
#     the NEXT pass RE-ENTERS it; abfe_hsp90_ens.py then RESUMES from its per-rep .nc
#     checkpoint. This is the explicit fix for the gold bug: there, a rc=143 (SIGTERM
#     on reboot) was treated as "done" and the leg was silently skipped half-finished.
#   * persistent ~/abfe-ens/ working dir (NOT /tmp) so a reboot does not wipe the .nc.
#   * progress streamed to ~/abfe-ens/ens_progress.log.
#
# @reboot AUTO-RESUME (document-only — install once on summer, NOT done by this script):
#   Add to summer's crontab (`crontab -e`) so the campaign self-restarts after a reboot:
#       @reboot /home/summer/abfe-ens/run_ens.sh >> /home/summer/abfe-ens/ens_progress.log 2>&1
#   The flock guard makes a duplicate @reboot launch harmless (it exits immediately if
#   one is already running); the rc=0 skip-guard makes it idempotent (finished legs are
#   skipped, the in-flight one resumes from its .nc). To install the campaign on summer:
#       scp abfe_hsp90_ens.py run_ens.sh summer@192.168.50.60:~/abfe-ens/
#       scp hsp90_rec_clean.pdb 17AG.sdf 17AAG.sdf summer@192.168.50.60:~/abfe-ens/
#
# FIRE (the ONE command — runs the full ~4-day campaign; do NOT run during scaffold):
#       ssh summer@192.168.50.60 'bash ~/abfe-ens/run_ens.sh'
#   or via the sidecar pool:
#       sidecar pool on summer 'bash ~/abfe-ens/run_ens.sh'
set -uo pipefail

# ---- config -----------------------------------------------------------------
K="${K:-5}"                                  # replicas per (lig, leg)
LIGS=("17AG" "17AAG")
WORKDIR="${WORKDIR:-$HOME/abfe-ens}"          # persistent (NOT /tmp)
PY="${PY:-/home/summer/micromamba/envs/fep/bin/python}"
PROG="$WORKDIR/ens_progress.log"
LOCK="$WORKDIR/.ens.lock"
SMOKE="${SMOKE:-0}"                           # SMOKE=1 → tiny pipeline check (≤2 min)
# Single-cell override for a smoke: SMOKE=1 REP=0 LIG=17AG bash run_ens.sh
SMOKE_REP="${REP:-}"
SMOKE_LIG="${LIG:-}"

mkdir -p "$WORKDIR"
cd "$WORKDIR" || { echo "no workdir $WORKDIR" >&2; exit 1; }

# ---- env (summer free GPU) --------------------------------------------------
export OMP_NUM_THREADS=4
export JAX_PLATFORMS=cpu
export CUDA_VISIBLE_DEVICES=0

log() { echo "[$(date -u +%FT%TZ)] $*" | tee -a "$PROG"; }

# ---- flock guard: one campaign at a time ------------------------------------
exec 9>"$LOCK"
if ! flock -n 9; then
    log "another run_ens.sh holds the lock — exiting (idempotent)."
    exit 0
fi

# ---- one leg-run (both legs of a single LIG,REP) ----------------------------
run_one() {
    local lig="$1" rep="$2"
    local tag="${lig}_rep${rep}"
    local done_marker="$WORKDIR/.done_${tag}${SMOKE:+_smoke}"
    if [[ "$SMOKE" != "1" && -f "$done_marker" ]]; then
        log "SKIP $tag — rc=0 marker present (already finished)."
        return 0
    fi
    log "RUN  $tag — (resumes from per-rep .nc if one exists)."
    LIG="$lig" REP="$rep" SMOKE="$SMOKE" \
        "$PY" "$WORKDIR/abfe_hsp90_ens.py" >>"$PROG" 2>&1
    local rc=$?
    if [[ $rc -eq 0 ]]; then
        : > "$done_marker"                    # rc=0 → mark done (skip-guard)
        log "DONE $tag (rc=0)."
    else
        # NO marker on rc!=0 — a killed/crashed leg RE-ENTERS next pass and
        # resumes from its .nc. This is the explicit fix for the gold rc=143 bug.
        log "INCOMPLETE $tag (rc=$rc) — left UNMARKED; will resume next pass."
    fi
    return $rc
}

# ---- SMOKE single cell (≤2 min pipeline check) ------------------------------
if [[ "$SMOKE" == "1" ]]; then
    log "SMOKE single-cell: LIG=${SMOKE_LIG:-17AG} REP=${SMOKE_REP:-0}"
    run_one "${SMOKE_LIG:-17AG}" "${SMOKE_REP:-0}"
    log "SMOKE done."
    exit 0
fi

# ---- full grid: LIG × REP (serial; the GPU is single) -----------------------
log "=== ensemble campaign start: K=$K, ligs=${LIGS[*]}, workdir=$WORKDIR ==="
for lig in "${LIGS[@]}"; do
    for ((rep=0; rep<K; rep++)); do
        run_one "$lig" "$rep" || true        # never abort the campaign on one failure
    done
done
log "=== all leg-runs attempted; computing ensemble-average ==="

# ---- ensemble-average: mean ± stderr over reps per leg → ABFE → ΔΔG ---------
# Parses the ENS_RESULT lines emitted by abfe_hsp90_ens.py (one per completed rep).
"$PY" - "$PROG" <<'PYEOF'
import sys, re, math
prog = sys.argv[1]
# keep only the LAST ENS_RESULT per (lig, rep) — a resumed rep prints a fresh line.
pat = re.compile(r"ENS_RESULT lig=(\S+) rep=(\d+) dG_complex=(\S+) "
                 r"dG_solvent=(\S+) ssc=(\S+) dG_bind=(\S+)")
rows = {}
for line in open(prog):
    m = pat.search(line)
    if m:
        lig, rep = m.group(1), int(m.group(2))
        rows[(lig, rep)] = dict(
            dG_complex=float(m.group(3)), dG_solvent=float(m.group(4)),
            ssc=float(m.group(5)), dG_bind=float(m.group(6)))

def stats(xs):
    n = len(xs)
    mu = sum(xs) / n
    sd = math.sqrt(sum((x - mu) ** 2 for x in xs) / (n - 1)) if n > 1 else float("nan")
    se = sd / math.sqrt(n) if n > 1 else float("nan")
    return mu, se, n

print("\n" + "=" * 70)
print("=== SENOLYX R12-ENS ensemble-average (mean ± stderr over replicas) ===")
abfe = {}
for lig in ("17AG", "17AAG"):
    reps = sorted(r for (l, r) in rows if l == lig)
    if not reps:
        print(f"  {lig}: NO completed reps yet."); continue
    dGc = [rows[(lig, r)]["dG_complex"] for r in reps]
    dGs = [rows[(lig, r)]["dG_solvent"] for r in reps]
    ssc = rows[(lig, reps[0])]["ssc"]   # deterministic per lig (geometry-only)
    mc, sc, nc = stats(dGc)
    ms, ss, ns = stats(dGs)
    # ABFE = <dG_solvent> - <dG_complex> + ssc ; errors add in quadrature
    a = ms - mc + ssc
    ae = math.sqrt((sc if sc == sc else 0) ** 2 + (ss if ss == ss else 0) ** 2)
    abfe[lig] = (a, ae, nc)
    print(f"  {lig} (n={nc} reps): "
          f"dG_complex={mc:.2f}±{sc:.2f}  dG_solvent={ms:.2f}±{ss:.2f}  "
          f"ssc={ssc:.2f}  →  ABFE={a:.2f}±{ae:.2f} kcal/mol")
if "17AG" in abfe and "17AAG" in abfe:
    a1, e1, _ = abfe["17AG"]
    a2, e2, _ = abfe["17AAG"]
    ddg = a1 - a2
    dde = math.sqrt(e1 ** 2 + e2 ** 2)
    print("-" * 70)
    print(f"  ΔΔG = ABFE(17AG) - ABFE(17AAG) = {ddg:+.2f} ± {dde:.2f} kcal/mol")
    print(f"  exp ≈ -1.9 kcal/mol (17AG tighter).  "
          f"Sign {'CORRECT (negative)' if ddg < 0 else 'STILL WRONG (positive)'}.")
    print("  If sign is still wrong AND stderr is small, bistability is a "
          "deterministic deck artifact → branch ② RBFE is the real fix.")
print("=" * 70)
PYEOF
log "=== ensemble-average computed; campaign complete ==="
