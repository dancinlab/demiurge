#!/usr/bin/env bash
# SENOLYX single launch entry (failure-mode #7) — fire_cell.sh <kind> <CELL...>
#   kind = r13  -> round13 ABFE cells (TARGET:REP), pod from cand_pods.tsv
#   kind = r12  -> round12 RBFE cells (LIG:REP),    pod from ../round12-rbfe/ens_pods.tsv
#
# !!! THIS IS THE ONLY SANCTIONED WAY TO LAUNCH OR RESUME A PRODUCTION CELL !!!
# NEVER start a production cell with a bare `python abfe_*.py &` on a pod. A bare
# background launch has NO crash recovery: a transient OpenMM "terminate called"
# minimize/segfault abort kills the cell permanently and it silently never emits
# ENS_RESULT. That is exactly what killed the manually-launched 17AG/0 (R12) and
# MCL1:0 (R13) cells. There used to be TWO launch paths — the retry-resume runner
# (runcells_*.sh) and bare manual `python &`; this file collapses them to ONE.
#
# Every cell fired here is wrapped in the per-pod retry-resume runner
# (runcells_cand.sh for r13 / runcells.sh for r12), which retries up to 4x and RESUMES
# from the per-rep checkpoint .nc, so a minimize-abort resumes instead of dying.
#
# Cells are grouped by their assigned pod (HOST:PORT:ID from the manifest) and one
# nohup runcells_*.sh is launched per pod with that pod's full cell list — exactly the
# fanout launch recipe, so resume is identical to first launch.
set -uo pipefail
cd "$(dirname "$0")"

usage() { echo "usage: fire_cell.sh <r12|r13> <CELL...>   (CELL = TARGET:REP for r13, LIG:REP for r12)"; exit 64; }

KIND="${1:-}"; shift || usage
[ $# -ge 1 ] || usage

case "$KIND" in
  r13) MANIFEST="cand_pods.tsv";            WORKDIR="/workspace/r13cand"; RUNNER="runcells_cand.sh"; BOOT="runcells.boot" ;;
  r12) MANIFEST="../round12-rbfe/ens_pods.tsv"; WORKDIR="/workspace/r12ens";  RUNNER="runcells.sh";      BOOT="runcells.boot" ;;
  *) echo "ERROR unknown kind '$KIND' (expected r12 or r13)"; usage ;;
esac
[ -f "$MANIFEST" ] || { echo "ERROR manifest $MANIFEST not found"; exit 2; }

# Resolve each requested CELL to its assigned pod via the manifest, then group cells
# by pod so each pod gets ONE runcells_*.sh launch with all its requested cells.
# manifest row: KEY \t REP \t ID \t HOST \t PORT \t STATUS
declare -A POD_CELLS POD_HOST POD_PORT
for cell in "$@"; do
  KEY="${cell%%:*}"; REP="${cell##*:}"
  row=$(awk -F'\t' -v k="$KEY" -v r="$REP" '$1==k && $2==r {print; exit}' "$MANIFEST")
  if [ -z "$row" ]; then echo "ERROR cell $cell not in $MANIFEST — refusing to fire (unknown pod)"; exit 3; fi
  ID=$(echo "$row" | cut -f3); HOST=$(echo "$row" | cut -f4); PORT=$(echo "$row" | cut -f5)
  if [ "$ID" = "-" ] || [ -z "$HOST" ] || [ "$HOST" = "-" ] || [ -z "$PORT" ] || [ "$PORT" = "-" ]; then
    echo "ERROR cell $cell has no live pod in manifest (id=$ID host=$HOST port=$PORT) — re-rent via fanout first"; exit 3
  fi
  POD_CELLS["$ID"]="${POD_CELLS[$ID]:-} $cell"
  POD_HOST["$ID"]="$HOST"; POD_PORT["$ID"]="$PORT"
done

rc=0
for ID in "${!POD_CELLS[@]}"; do
  HOST="${POD_HOST[$ID]}"; PORT="${POD_PORT[$ID]}"; CELLS="${POD_CELLS[$ID]## }"
  echo ">> fire pod $ID @ $HOST:$PORT cells=[$CELLS] via $RUNNER (retry-resume)"
  if hexa cloud nohup root@"$HOST" "$WORKDIR/$BOOT" --port "$PORT" --insecure -- \
       bash "$WORKDIR/$RUNNER" $CELLS </dev/null 2>&1 | grep -E "remote pid" | head -1; then :; else
    echo "   WARN no 'remote pid' confirmation for pod $ID"; rc=1
  fi
done
echo "=== FIRE_CELL_DONE (kind=$KIND) ==="
exit $rc
