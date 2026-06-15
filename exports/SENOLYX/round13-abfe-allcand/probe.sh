#!/usr/bin/env bash
# Campaign pod probe — the stdin-safe / arg-safe / bash-3.2-safe replacement for
# the ad-hoc `while read … hexa cloud exec …` loops that kept breaking:
#   M1 ssh eats the while-read stdin → only first pod polled  (fix: ssh </dev/null)
#   M2 `set -- $hp` arg-split under zsh→bash → "flag --port needs a value"
#   M2b macOS ships bash 3.2 — NO mapfile / ${x,,} (fix: heredoc-fed loop, tr)
#   usage: probe.sh <manifest.tsv> <remote-workdir>
#   e.g.   bash probe.sh cand_pods.tsv r13cand
# manifest cols (tab): LIG/TARGET  REP  ID  HOST  PORT  STATUS
set -uo pipefail
MAN="${1:?manifest.tsv}"; WORK="${2:?remote-workdir}"
ROWS="$(awk -F'\t' '$6=="running" && $4!="-"{print $4"\t"$5"\t"$1":"$2}' "$MAN" | sort -u)"
# feed the loop via heredoc (NOT a pipe) so the ssh inside can't drain the manifest
# stream; ssh ALSO gets </dev/null so it never touches the loop's heredoc fd.
while IFS=$'\t' read -r H P CELL; do
  [ -z "${H:-}" ] && continue
  r=$(hexa cloud exec "root@$H" --port "$P" --insecure -- \
        "cd /workspace/$WORK 2>/dev/null; \
         e=\$(grep -h ENS_RESULT cell_*.log 2>/dev/null|grep -c .); \
         a=\$(ps aux|grep -c '[a]bfe_'); \
         lg=\$(grep -hoE '\[(complex|solvent) rep[0-9]' cell_*.log 2>/dev/null|tail -1); \
         g=\$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader 2>/dev/null|head -1); \
         echo \"ENS=\$e proc=\$a \$lg gpu=\$g\"" \
        </dev/null 2>/dev/null | grep -vE "deprecated|remote exit")
  [ -z "$r" ] && r="SSH-blip (check 'hexa cloud alive <id>' — RUNNING=무시)"
  printf "  %-6s [%-10s] %s\n" "$P" "$CELL" "$r"
done <<EOF
$ROWS
EOF
