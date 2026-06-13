#!/bin/bash
# Watch the anchor's sequential q5-q8 progress to final JOB DONE. Disowned-survivable.
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=10 -o ServerAliveInterval=30 -o BatchMode=yes"
H=74.126.26.42; P=40288
D=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16
LOG=$D/anchor_watch.log
echo "=== ANCHOR WATCH START $(date) ===" >> $LOG
while true; do
  out=$(timeout 20 ssh $S -p $P root@$H 'cd /root/li2mgh16; cq=$(grep -oE "<CURRENT_Q>[0-9]+" out/_ph0/li2mgh16.phsave/status_run.xml 2>/dev/null|grep -oE "[0-9]+"); jd=$(grep -c "JOB DONE" ph.out 2>/dev/null); ndyn=$(ls li2mgh16.dyn?.elph.? 2>/dev/null|wc -l); cr=$(grep "Representation #" ph.out|tail -1|grep -oE "[0-9]+"|head -1); echo "CQ=$cq JD=$jd NDYN=$ndyn REP=$cr"' 2>/dev/null | tail -1)
  echo "[$(date +%H:%M:%S)] $out" >> $LOG
  echo "$out" | grep -q "JD=1" && { echo "ANCHOR_JOB_DONE $(date)" >> $LOG; break; }
  echo "$out" | grep -q "NDYN=8" && { echo "ALL8_DYN_PRESENT $(date)" >> $LOG; break; }
  sleep 600
done
echo "ANCHOR_WATCH_COMPLETE" >> $LOG
