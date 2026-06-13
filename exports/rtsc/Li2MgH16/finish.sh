#!/bin/bash
# Self-contained: wait all 16 done (pod-direct) -> assemble each q -> harvest. Survives via disown.
D=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=8 -o ServerAliveInterval=30 -o BatchMode=yes"
LOG=$D/finish.log
echo "=== FINISH START $(date) ===" >> $LOG
get(){ grep " $1\$" $D/allmap.txt | head -1; }

# Phase 1: wait all 16
while true; do
  nd=0; pend=""
  while read id host port q si li tag; do
    j=$(timeout 12 ssh $S -p $port root@$host "grep -c 'JOB DONE' /root/work/ph.out 2>/dev/null" 2>/dev/null|tail -1)
    [ "$j" = "1" ] && nd=$((nd+1)) || pend="$pend $tag"
  done < $D/allmap.txt
  echo "[$(date +%H:%M:%S)] done=$nd/16 pend:$pend" >> $LOG
  [ $nd -ge 16 ] && { echo "ALL16_DONE $(date)" >> $LOG; break; }
  sleep 180
done

# Phase 2: assemble each q (gather 4 shards' XMLs onto s1 pod, ph.x recover full-irr)
for q in 5 6 7 8; do
  read i1 h1 p1 a b c t1 <<< "$(get q$q-s1)"
  read i2 h2 p2 a b c t2 <<< "$(get q$q-s2)"
  read i3 h3 p3 a b c t3 <<< "$(get q$q-s3)"
  read i4 h4 p4 a b c t4 <<< "$(get q$q-s4)"
  echo "[asm q$q] base $h1:$p1 + $h2:$p2 $h3:$p3 $h4:$p4" >> $LOG
  L=$D/assembly/q$q; mkdir -p $L
  # pull s2,s3,s4 per-irrep XMLs to local, push to s1
  for hp in "$h2:$p2" "$h3:$p3" "$h4:$p4"; do
    hh=${hp%:*}; pp=${hp#*:}
    scp $S -P $pp "root@$hh:/root/work/out/_ph0/li2mgh16.phsave/dynmat.$q.*.xml" $L/ 2>/dev/null
    scp $S -P $pp "root@$hh:/root/work/out/_ph0/li2mgh16.phsave/elph.$q.*.xml"   $L/ 2>/dev/null
  done
  scp $S -P $p1 $L/dynmat.$q.*.xml $L/elph.$q.*.xml "root@$h1:/root/work/out/_ph0/li2mgh16.phsave/" 2>/dev/null
  ad=$(ssh $S -p $p1 root@$h1 "ls /root/work/out/_ph0/li2mgh16.phsave/dynmat.$q.*.xml 2>/dev/null|wc -l")
  ae=$(ssh $S -p $p1 root@$h1 "ls /root/work/out/_ph0/li2mgh16.phsave/elph.$q.*.xml 2>/dev/null|wc -l")
  echo "[asm q$q] s1 now has dynmat=$ad elph=$ae (want 114)" >> $LOG
  # run recover full-irr
  ssh $S -p $p1 root@$h1 "cd /root/work && cat > ph_asm$q.in <<PHEOF
Li2MgH16 assemble q$q
&inputph
  prefix = 'li2mgh16'
  outdir = './out'
  fildyn = './li2mgh16.dyn'
  fildvscf = 'li2mgh16.dvscf'
  ldisp = .true.
  nq1 = 2, nq2 = 2, nq3 = 2
  start_q = $q
  last_q = $q
  tr2_ph = 1.0d-14
  recover = .true.
  electron_phonon = 'simple'
  el_ph_sigma = 0.005
  el_ph_nsigma = 10
/
PHEOF
source /opt/conda/etc/profile.d/conda.sh; conda activate qe; export OMP_NUM_THREADS=1
mpirun --allow-run-as-root -np 8 ph.x -npool 4 -in ph_asm$q.in > ph_asm$q.out 2>&1
echo ASM${q}_EXIT_\$?" >> $LOG 2>&1
  echo "[asm q$q] done $(date)" >> $LOG
done

# Phase 3: harvest dyn5-8 + elph5-8
mkdir -p $D/harvest_final
for q in 5 6 7 8; do
  read i1 h1 p1 a b c t1 <<< "$(get q$q-s1)"
  scp $S -P $p1 "root@$h1:/root/work/li2mgh16.dyn$q" "$D/harvest_final/" 2>/dev/null
  scp $S -P $p1 "root@$h1:/root/work/li2mgh16.dyn$q.elph.$q" "$D/harvest_final/" 2>/dev/null
  scp $S -P $p1 "root@$h1:/root/work/ph_asm$q.out" "$D/harvest_final/" 2>/dev/null
done
echo "=== HARVEST DONE $(date) ===" >> $LOG
ls -la $D/harvest_final/li2mgh16.dyn{5,6,7,8} 2>/dev/null >> $LOG
echo "FINISH_COMPLETE" >> $LOG
