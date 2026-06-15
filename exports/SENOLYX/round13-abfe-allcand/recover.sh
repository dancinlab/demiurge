#!/usr/bin/env bash
# SENOLYX ABFE recovery helper — two prevention subcommands.
#
#   recover.sh alive <host> <port> <id>
#       failure-mode #5 (SSH-blip false-death). ssh-probe the pod; if ssh FAILS, do
#       NOT declare it dead — ask the PROVIDER API (`hexa cloud alive <id>`). Only a
#       GONE/STOPPED verdict means the pod is really dead (-> exit 3, caller may
#       re-rent that cell). A RUNNING verdict means the ssh failure was a transient
#       network blip: report it and DO NOTHING (exit 0). This stops a momentary ssh
#       hiccup from tearing down a healthy, billing, mid-run pod.
#
#   recover.sh reap [--apply]
#       failure-mode #6 (orphan reap). List live vast pods that are owned by a
#       `senolyx-*` tag (provider registry PURPOSE column) but are ABSENT from BOTH
#       campaign manifests (round12 ens_pods.tsv + round13 cand_pods.tsv). These are
#       leaked SENOLYX pods burning money with no cell assigned. Bare = dry-run
#       report; --apply = `hexa cloud rm <id> --force` each.
#       SAFETY: only ever touches `senolyx-*`-owned pods that are in NEITHER manifest.
#       The RTSC pod (41001569) and every manifest pod can NEVER match and are SAFE.
set -uo pipefail
cd "$(dirname "$0")"

R13_MANIFEST="cand_pods.tsv"
R12_MANIFEST="../round12-rbfe/ens_pods.tsv"

usage() { echo "usage: recover.sh alive <host> <port> <id>  |  recover.sh reap [--apply]"; exit 64; }

# ---- manifest id set (both campaigns) ---------------------------------------
manifest_ids() {
  { awk -F'\t' '$3!="-"&&$3!=""{print $3}' "$R13_MANIFEST" 2>/dev/null
    awk -F'\t' '$3!="-"&&$3!=""{print $3}' "$R12_MANIFEST" 2>/dev/null
  } | sort -u
}

cmd_alive() {
  local HOST="$1" PORT="$2" ID="$3"
  echo "[alive] ssh-probe $HOST:$PORT (id=$ID)"
  if hexa cloud exec root@"$HOST" --port "$PORT" --insecure -- 'echo PONG' </dev/null 2>/dev/null | grep -q PONG; then
    echo "ALIVE ssh OK — pod $ID reachable"; return 0
  fi
  echo "[alive] ssh FAILED — NOT declaring dead; asking provider API (hexa cloud alive $ID)"
  local OUT; OUT=$(hexa cloud alive "$ID" 2>&1); local RC=$?
  echo "$OUT"
  # exit-code contract of `hexa cloud alive`: 0=RUNNING 3=STOPPED 4=GONE 255=UNKNOWN
  case "$RC" in
    0) echo "VERDICT transient ssh-blip — provider says RUNNING. Reporting only, doing NOTHING."; return 0 ;;
    3|4) echo "VERDICT pod $ID is DEAD (provider GONE/STOPPED). Caller may re-rent this cell."; return 3 ;;
    *) echo "VERDICT UNKNOWN (provider unreachable / missing cred) — treat as transient, do NOTHING."; return 0 ;;
  esac
}

cmd_reap() {
  local APPLY=0; [ "${1:-}" = "--apply" ] && APPLY=1
  local MIDS; MIDS=$(manifest_ids)
  echo "[reap] manifest pod ids (NEVER reaped):"; echo "$MIDS" | sed 's/^/    /'
  echo "[reap] scanning live vast pods for senolyx-* owners absent from both manifests..."
  # registry table rows: "<id> <provider> <status> <project> <purpose>"; purpose holds the owner tag.
  local LIST; LIST=$(hexa cloud list --provider vast 2>&1)
  local found=0
  # parse the registry-attribution block (lines with a numeric id + a senolyx-* purpose)
  echo "$LIST" | awk '/^[[:space:]]*[0-9]+[[:space:]]+vast/{id=$1; purpose=$NF; print id"\t"purpose}' \
    | while IFS=$'\t' read -r ID PURPOSE; do
        case "$PURPOSE" in
          senolyx-*) : ;;        # candidate owner
          *) continue ;;          # not a senolyx-owned pod -> NEVER reap (RTSC/untracked safe)
        esac
        if echo "$MIDS" | grep -qx "$ID"; then continue; fi   # in a manifest -> keep
        found=1
        echo "  ORPHAN $ID (owner=$PURPOSE) — senolyx-owned but in NEITHER manifest"
        if [ "$APPLY" = 1 ]; then
          echo "    -> hexa cloud rm $ID --force"
          hexa cloud rm "$ID" --force </dev/null 2>&1 | sed 's/^/       /'
        fi
      done
  if [ "$APPLY" = 1 ]; then echo "[reap] --apply done."; else echo "[reap] DRY-RUN (pass --apply to destroy). No pod touched."; fi
}

case "${1:-}" in
  alive) shift; [ $# -eq 3 ] || usage; cmd_alive "$@" ;;
  reap)  shift; cmd_reap "${1:-}" ;;
  *) usage ;;
esac
