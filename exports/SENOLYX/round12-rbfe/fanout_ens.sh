#!/usr/bin/env bash
# SENOLYX R12 ensemble fan-out v2 — pack 2 cells/pod, robust rent, retry-resume.
# Validated recipe: cuda_max_good>=12.6 host + clean cuda-version=12.6 env (PTX-222 clear).
set -uo pipefail
cd "$(dirname "$0")"
MANIFEST=ens_pods.tsv
: > "$MANIFEST"
printf "17AG\t0\t41008015\tssh1.vast.ai\t18014\trunning\n" >> "$MANIFEST"   # validated pod, cell 17AG/0

# 9 remaining cells, packed 2 per pod (last pod 1 cell)
PODSPECS=( "17AG:1 17AAG:0" "17AG:2 17AAG:1" "17AG:3 17AAG:2" "17AG:4 17AAG:3" "17AAG:4" )
FILES="abfe_hsp90_ens.py hsp90_rec_clean.pdb 17AG.sdf 17AAG.sdf bootstrap_ens.sh runcells.sh"
QUERY="reliability > 0.98 num_gpus = 1 cuda_max_good >= 12.6 dph < 0.7 inet_down > 200 rentable = true"

# copy-verify: copy a file to the pod, then ssh `test -f` to CONFIRM it actually
# landed (a silent copy-to failure used to launch a doomed runcells). Retries up to
# 3x. Returns 0 only if the remote file exists. (failure-mode #3)
copy_verify() {  # args: HOST PORT SRC DST
  local H="$1" P="$2" SRC="$3" DST="$4" try
  for try in 1 2 3; do
    hexa cloud copy-to root@"$H" "$SRC" "$DST" --port "$P" --insecure </dev/null >/dev/null 2>&1
    if hexa cloud exec root@"$H" --port "$P" --insecure -- "test -f '$DST'" </dev/null >/dev/null 2>&1; then
      return 0
    fi
    echo "    copy-verify retry $try/3 for $SRC"
  done
  return 1
}

p=0
for spec in "${PODSPECS[@]}"; do
  p=$((p+1)); TAG="senolyx-r12-pod$p"
  echo "############ POD $p cells=[$spec] ############"
  ID=""; HOST=""; PORT=""
  for try in 1 2 3; do
    echo "--- rent try $try (owner=$TAG) ---"
    OUT=$(hexa cloud rent vast --gpu "RTX_4090" --project SENOLYX --owner "$TAG" \
          --query "$QUERY" --image "nvidia/cuda:12.4.1-runtime-ubuntu22.04" \
          --disk 40 --max-wait-sec 300 --force-new 2>&1)
    echo "$OUT" | grep -E "picked offer|created instance|READY|never ready|Error|no matching" | tail -3
    ID=$(echo "$OUT"   | sed -n 's/^instance_id=//p' | head -1)
    HOST=$(echo "$OUT" | sed -n 's/^host=//p' | head -1)
    PORT=$(echo "$OUT" | sed -n 's/^port=//p' | head -1)
    [ -n "$ID" ] && [ -n "$HOST" ] && [ -n "$PORT" ] && break
    ID=""; HOST=""; PORT=""
  done
  if [ -z "$ID" ]; then
    echo "RENT_GAVEUP pod$p [$spec]"
    for cr in $spec; do printf "%s\t%s\t-\t-\t-\tRENT_FAIL\n" "${cr%%:*}" "${cr##*:}" >> "$MANIFEST"; done
    continue
  fi
  echo ">> pod$p = $ID @ $HOST:$PORT"
  hexa cloud exec root@$HOST --port $PORT --insecure -- 'mkdir -p /workspace/r12ens' </dev/null >/dev/null 2>&1
  # copy-verify every file; abort this pod if any is still missing after 3 tries.
  abort=0
  for f in $FILES; do
    if copy_verify "$HOST" "$PORT" "$f" "/workspace/r12ens/$f"; then echo "  copied+verified $f"; else echo "  COPY_FAIL $f (verify failed after 3 tries)"; abort=1; fi
  done
  if [ "$abort" = 1 ]; then
    echo "POD_ABORT pod$p — required file missing, NOT launching runcells (doomed run prevented)"
    for cr in $spec; do printf "%s\t%s\t%s\t%s\t%s\tCOPY_FAIL\n" "${cr%%:*}" "${cr##*:}" "$ID" "$HOST" "$PORT" >> "$MANIFEST"; done
    continue
  fi
  echo ">> launching runcells [$spec]"
  hexa cloud nohup root@$HOST /workspace/r12ens/runcells.boot --port $PORT --insecure -- \
    bash /workspace/r12ens/runcells.sh $spec 2>&1 | grep -E "remote pid" | head -1
  for cr in $spec; do printf "%s\t%s\t%s\t%s\t%s\trunning\n" "${cr%%:*}" "${cr##*:}" "$ID" "$HOST" "$PORT" >> "$MANIFEST"; done
done
echo "=== FANOUT_COMPLETE ==="
cat "$MANIFEST"
