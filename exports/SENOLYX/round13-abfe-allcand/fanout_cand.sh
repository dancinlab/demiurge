#!/usr/bin/env bash
# SENOLYX R13 candidate ABFE fan-out — 3 targets x K=3 reps = 9 cells, 2/pod.
# Validated recipe (R12): cuda_max_good>=12.6 host + clean cuda-version=12.6 env.
set -uo pipefail
cd "$(dirname "$0")"
MANIFEST=cand_pods.tsv; : > "$MANIFEST"
printf "MCL1\t0\t41018985\tssh1.vast.ai\t18984\trunning\n" >> "$MANIFEST"  # validation pod = MCL1:0

PODSPECS=( "MCL1:1 CRBN:0" "MCL1:2 CRBN:1" "BCLXL:0 CRBN:2" "BCLXL:1 BCLXL:2" )
# REQUIRED files — every one MUST land on the pod or that pod is aborted (copy-verify,
# failure-mode #3). The lig_*_bound.sdf are the CLASH-FREE bound poses (extract_pose.py);
# abfe_cand.py prefers them and skips recenter (failure-mode #1). If a bound SDF is
# absent the deck still runs (graceful ideal+centroid fallback), so it is NOT required.
FILES="abfe_cand.py pockets.json 4QVX.pdb 4CI1.pdb 5LOF.pdb lig_3CQ.sdf lig_EF2.sdf lig_70R.sdf bootstrap_cand.sh runcells_cand.sh"
OPT_FILES="lig_3CQ_bound.sdf lig_70R_bound.sdf lig_EF2_bound.sdf"
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
  p=$((p+1)); TAG="senolyx-r13-pod$p"
  echo "############ POD $p cells=[$spec] ############"
  ID=""; HOST=""; PORT=""
  for try in 1 2 3; do
    OUT=$(hexa cloud rent vast --gpu "RTX_4090" --project SENOLYX --owner "$TAG" \
          --query "$QUERY" --image "nvidia/cuda:12.4.1-runtime-ubuntu22.04" \
          --disk 40 --max-wait-sec 300 --force-new 2>&1)
    echo "$OUT" | grep -E "picked offer|READY|never ready|Error|no matching" | tail -2
    ID=$(echo "$OUT" | sed -n 's/^instance_id=//p' | head -1)
    HOST=$(echo "$OUT" | sed -n 's/^host=//p' | head -1)
    PORT=$(echo "$OUT" | sed -n 's/^port=//p' | head -1)
    [ -n "$ID" ] && [ -n "$HOST" ] && [ -n "$PORT" ] && break; ID=""; HOST=""; PORT=""
  done
  if [ -z "$ID" ]; then echo "RENT_GAVEUP pod$p"; for cr in $spec; do printf "%s\t%s\t-\t-\t-\tRENT_FAIL\n" "${cr%%:*}" "${cr##*:}" >> "$MANIFEST"; done; continue; fi
  echo ">> pod$p = $ID @ $HOST:$PORT"
  hexa cloud exec root@$HOST --port $PORT --insecure -- 'mkdir -p /workspace/r13cand' </dev/null >/dev/null 2>&1
  # copy-verify every REQUIRED file; abort this pod if any is still missing after 3 tries.
  abort=0
  for f in $FILES; do
    if copy_verify "$HOST" "$PORT" "$f" "/workspace/r13cand/$f"; then echo "  copied+verified $f"; else echo "  COPY_FAIL $f (verify failed after 3 tries)"; abort=1; fi
  done
  # bound poses are optional — copy if present locally, never abort on their absence.
  for f in $OPT_FILES; do
    [ -f "$f" ] || continue
    copy_verify "$HOST" "$PORT" "$f" "/workspace/r13cand/$f" && echo "  copied+verified $f (bound pose)" || echo "  WARN bound pose $f not copied (deck will fall back to ideal+centroid)"
  done
  if [ "$abort" = 1 ]; then
    echo "POD_ABORT pod$p — required file missing, NOT launching runcells (doomed run prevented)"
    for cr in $spec; do printf "%s\t%s\t%s\t%s\t%s\tCOPY_FAIL\n" "${cr%%:*}" "${cr##*:}" "$ID" "$HOST" "$PORT" >> "$MANIFEST"; done
    continue
  fi
  hexa cloud nohup root@$HOST /workspace/r13cand/runcells.boot --port $PORT --insecure -- \
    bash /workspace/r13cand/runcells_cand.sh $spec 2>&1 | grep -E "remote pid" | head -1
  for cr in $spec; do printf "%s\t%s\t%s\t%s\t%s\trunning\n" "${cr%%:*}" "${cr##*:}" "$ID" "$HOST" "$PORT" >> "$MANIFEST"; done
done
echo "=== FANOUT_COMPLETE ==="; cat "$MANIFEST"
