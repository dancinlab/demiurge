#!/usr/bin/env bash
# R13 harvest: pull ENS_RESULT from all pods, ensemble-average ABFE per TARGET.
# Exit 0 + writes RESULT.txt when all 9 cells done; exit 2 if partial.
#
# PERSIST-MERGE (failure-mode #9): combined.prog is THIS poll's fresh pull. The
# durable seen-store seen.prog ACCUMULATES every ENS_RESULT line ever observed. We
# only ever APPEND newly-pulled ENS_RESULT lines into seen.prog (never truncate it),
# and the tally/aggregate reads from seen.prog. So a transient SSH blip that returns
# 0 lines this poll can NEVER un-count a cell that already finished — the count is
# monotone non-decreasing and the watcher reliably reaches the final N/N. dedup
# keep-last per (lig,rep) is handled in python (a resumed rep's newer ENS_RESULT
# wins, because seen.prog preserves source order and python keeps the LAST match).
set -uo pipefail
cd "$(dirname "$0")"
COMBINED=combined.prog; SEEN=seen.prog; : > "$COMBINED"; touch "$SEEN"
awk -F'\t' '$6=="running" && $4!="-"{print $4"\t"$5}' cand_pods.tsv | sort -u | while IFS=$'\t' read -r HOST PORT; do
  # WHY </dev/null : ssh (under `hexa cloud exec`) inherits and DRAINS the parent
  # shell's stdin. Inside this `while read` loop that stdin IS the awk pipe, so an
  # un-redirected ssh would swallow the remaining HOST/PORT lines and the loop would
  # harvest only the FIRST pod. Redirecting the remote call's stdin from /dev/null
  # leaves the loop's pipe intact so every pod is polled. (failure-mode #2)
  hexa cloud exec root@$HOST --port $PORT --insecure -- \
    'grep -h "ENS_RESULT" /workspace/r13cand/cell_*.log 2>/dev/null' </dev/null 2>/dev/null >> "$COMBINED"
done
# persist-merge: append only the freshly-pulled ENS_RESULT lines into the durable
# seen-store (never truncate seen.prog), so a blip cannot regress the tally.
grep -h "ENS_RESULT" "$COMBINED" 2>/dev/null >> "$SEEN" || true
echo "harvested $(grep -c ENS_RESULT "$SEEN" 2>/dev/null || echo 0) ENS_RESULT lines"
python3 - "$SEEN" <<'PYEOF'
import sys, re, math
rows={}
pat=re.compile(r"ENS_RESULT lig=(\S+) rep=(\d+) dG_complex=(\S+) dG_solvent=(\S+) ssc=(\S+) dG_bind=(\S+)")
for line in open(sys.argv[1]):
    m=pat.search(line)
    if m: rows[(m.group(1),int(m.group(2)))]=float(m.group(6))
def stats(xs):
    n=len(xs); mu=sum(xs)/n
    sd=math.sqrt(sum((x-mu)**2 for x in xs)/(n-1)) if n>1 else float('nan')
    return mu,(sd/math.sqrt(n) if n>1 else float('nan')),n
EXP={"MCL1":"S63845 Kd~0.19nM (~ -13)","BCLXL":"3CQ BH3 inhibitor","CRBN":"IMiD Kd~uM"}
out=[]; total=0
for tgt in ("MCL1","BCLXL","CRBN"):
    reps=sorted(r for (t,r) in rows if t==tgt)
    total+=len(reps)
    if not reps: out.append(f"{tgt}: 0/3 reps"); continue
    mu,se,n=stats([rows[(tgt,r)] for r in reps])
    out.append(f"{tgt} (n={n}/3): ABFE_dG_bind = {mu:.2f} +/- {se if se==se else float('nan'):.2f} kcal/mol   [exp: {EXP[tgt]}]")
print("\n".join(out))
open("RESULT.txt","w").write("\n".join(out)+f"\ndone_cells={total}/9\n")
sys.exit(0 if total>=9 else 2)
PYEOF
