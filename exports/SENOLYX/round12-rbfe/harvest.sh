#!/usr/bin/env bash
# SENOLYX R12-ens harvest: pull ENS_RESULT from all pods, aggregate ensemble ΔΔG.
# Exit 0 + writes RESULT.txt when all 10 cells done; exit 2 if still partial.
#
# PERSIST-MERGE (failure-mode #9): combined.prog is THIS poll's fresh pull; the
# durable seen-store seen.prog ACCUMULATES every ENS_RESULT ever observed. We only
# APPEND newly-pulled ENS_RESULT into seen.prog (never truncate) and tally from it,
# so a transient SSH blip returning 0 lines can NEVER un-count a finished cell — the
# count is monotone non-decreasing and the watcher reliably reaches the final N/N.
# dedup keep-last per (lig,rep) stays in python (a resumed rep's newer line wins).
set -uo pipefail
cd "$(dirname "$0")"
COMBINED=combined.prog
SEEN=seen.prog
: > "$COMBINED"
touch "$SEEN"
# unique pods (host port) from manifest, skipping RENT_FAIL rows
awk -F'\t' '$6=="running" && $4!="-"{print $4"\t"$5}' ens_pods.tsv | sort -u | while IFS=$'\t' read -r HOST PORT; do
  # WHY </dev/null : ssh (under `hexa cloud exec`) inherits and DRAINS the parent
  # shell's stdin. Inside this `while read` loop that stdin IS the awk pipe, so an
  # un-redirected ssh would swallow the remaining HOST/PORT lines and the loop would
  # harvest only the FIRST pod. Redirecting the remote call's stdin from /dev/null
  # leaves the loop's pipe intact so every pod is polled. (failure-mode #2)
  hexa cloud exec root@$HOST --port $PORT --insecure -- \
    'grep -h "ENS_RESULT" /workspace/r12ens/cell_*.log 2>/dev/null' </dev/null 2>/dev/null >> "$COMBINED"
done
# persist-merge: append only freshly-pulled ENS_RESULT into the durable seen-store
# (never truncate seen.prog) so a blip cannot regress the tally. (failure-mode #9)
grep -h "ENS_RESULT" "$COMBINED" 2>/dev/null >> "$SEEN" || true
# dedup: keep last ENS_RESULT per (lig,rep) handled in python
N=$(grep -c "ENS_RESULT" "$SEEN" 2>/dev/null || echo 0)
echo "harvested $N ENS_RESULT lines"
python3 - "$SEEN" <<'PYEOF'
import sys, re, math
rows={}
pat=re.compile(r"ENS_RESULT lig=(\S+) rep=(\d+) dG_complex=(\S+) dG_solvent=(\S+) ssc=(\S+) dG_bind=(\S+)")
for line in open(sys.argv[1]):
    m=pat.search(line)
    if m:
        rows[(m.group(1),int(m.group(2)))]=dict(c=float(m.group(3)),s=float(m.group(4)),ssc=float(m.group(5)),b=float(m.group(6)))
def stats(xs):
    n=len(xs); mu=sum(xs)/n
    sd=math.sqrt(sum((x-mu)**2 for x in xs)/(n-1)) if n>1 else float('nan')
    return mu,(sd/math.sqrt(n) if n>1 else float('nan')),n
out=[]; abfe={}
for lig in ("17AG","17AAG"):
    reps=sorted(r for (l,r) in rows if l==lig)
    if not reps: out.append(f"{lig}: 0 reps done"); continue
    mc,sc,nc=stats([rows[(lig,r)]['c'] for r in reps])
    ms,ss,ns=stats([rows[(lig,r)]['s'] for r in reps])
    ssc=rows[(lig,reps[0])]['ssc']; a=ms-mc+ssc
    ae=math.sqrt((0 if sc!=sc else sc)**2+(0 if ss!=ss else ss)**2)
    abfe[lig]=(a,ae,nc)
    out.append(f"{lig} (n={nc}): complex={mc:.2f}±{sc:.2f} solvent={ms:.2f}±{ss:.2f} ssc={ssc:.2f} -> ABFE={a:.2f}±{ae:.2f}")
done_cells=len(rows)
verdict="PARTIAL"
if "17AG" in abfe and "17AAG" in abfe:
    a1,e1,n1=abfe["17AG"]; a2,e2,n2=abfe["17AAG"]
    ddg=a1-a2; dde=math.sqrt(e1**2+e2**2)
    out.append(f"ΔΔG = {ddg:+.2f} ± {dde:.2f}  (exp -1.9; sign {'CORRECT' if ddg<0 else 'WRONG'})")
    if n1>=5 and n2>=5:
        err=abs(ddg-(-1.9))
        verdict = "PASS" if err<=1.5 else "FAIL"
        out.append(f"|err vs exp| = {err:.2f}  ->  R12 {verdict} (gate |err|<=1.5)")
print("\n".join(out))
open("RESULT.txt","w").write("\n".join(out)+f"\ndone_cells={done_cells}/10\nverdict={verdict}\n")
sys.exit(0 if done_cells>=10 else 2)
PYEOF
