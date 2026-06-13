#!/bin/bash
# Report status of all 16 shards. Builds livemap.txt from shard_map.txt (healthy) + newmap.txt (healed).
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o BatchMode=yes"
D=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16
# Healthy 8 (from shard_map): q5-s1 q6-s1 q6-s2 q6-s3 q7-s2 q7-s4 q8-s3 q8-s4
grep -E " (q5-s1|q6-s1|q6-s2|q6-s3|q7-s2|q7-s4|q8-s3|q8-s4)$" $D/shard_map.txt > $D/livemap.txt
cat $D/newmap.txt >> $D/livemap.txt
printf "%-7s %-9s %s\n" TAG STATE "irr_done/elph/expected"
done_total=0
while read id host port q si li tag; do
  exp=$((li-si+1))
  r=$(timeout 12 ssh $S -p $port root@$host "cd /root/work 2>/dev/null && { x=\$(grep -oE 'EXIT_[0-9]+' ph.log 2>/dev/null|tail -1); e=\$(ls out/_ph0/li2mgh16.phsave/elph.$q.*.xml 2>/dev/null|wc -l); j=\$(grep -c 'JOB DONE' ph.out 2>/dev/null); err=\$(grep -cE 'allocate already|Error termination' ph.out 2>/dev/null); echo \"\$x|\$e|\$j|\$err\"; }" 2>/dev/null | grep -vE "Warning|Welcome|Have fun" | tail -1)
  IFS='|' read x e j err <<< "$r"
  state=RUN; [ "$j" = "1" ] && state=DONE; [ -n "$x" ] && [ "$x" != "EXIT_0" ] && state=$x; [ "${err:-0}" -gt 0 ] && state=ERR
  [ -z "$r" ] && state=UNREACH
  [ "$state" = "DONE" ] && done_total=$((done_total+1))
  printf "%-7s %-9s %s/%s/%s\n" "$tag" "$state" "${e:-?}" "${e:-?}" "$exp"
done < $D/livemap.txt
echo "SHARDS_DONE: $done_total / 16"
