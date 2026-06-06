#!/bin/bash
# Parallel provision (QE install + SSH wait happen concurrently per pod),
# but uploads are MUTEX'd via flock so only one 595M scp runs at a time (no contention).
STAGE=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/li2mgh16_stage.tgz
LOCK=/tmp/li2mgh16_upload.lock
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=20 -o ServerAliveInterval=30 -o BatchMode=yes"
MAP=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/newmap.txt
D=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16

one() {
  local id=$1 host=$2 port=$3 q=$4 si=$5 li=$6 tag=$7
  local L=$D/heal_logs/$tag.log; mkdir -p $D/heal_logs
  echo "[$tag] start $(date +%H:%M:%S)" > $L
  # ssh wait (up to 12 min for slow loaders)
  local up=0
  for i in $(seq 1 60); do ssh $S -p $port root@$host 'echo ok' >/dev/null 2>&1 && { up=1; break; }; sleep 12; done
  [ $up -eq 0 ] && { echo "[$tag] SSH_FAIL" >> $L; return 11; }
  echo "[$tag] ssh up" >> $L
  # QE install (bg on pod)
  ssh $S -p $port root@$host 'test -x /opt/conda/envs/qe/bin/ph.x && echo HAVE || nohup bash -c "source /opt/conda/etc/profile.d/conda.sh; conda create -y -n qe -c conda-forge qe=7.5 >/root/qe.log 2>&1; echo DONE>>/root/qe.log" >/dev/null 2>&1 &' 2>/dev/null
  echo "[$tag] qe kicked" >> $L
  # MUTEX upload (mkdir-based lock, portable)
  while ! mkdir "$LOCK" 2>/dev/null; do sleep 3; done
  echo "[$tag] upload start $(date +%H:%M:%S)" >> $L
  scp $S -P $port "$STAGE" root@$host:/root/li2mgh16_stage.tgz >/dev/null 2>&1
  echo "[$tag] upload end $(date +%H:%M:%S)" >> $L
  rmdir "$LOCK" 2>/dev/null
  local rsz=$(ssh $S -p $port root@$host 'stat -c %s /root/li2mgh16_stage.tgz 2>/dev/null')
  local lsz=$(stat -f %z "$STAGE")
  [ "$rsz" != "$lsz" ] && { echo "[$tag] SCP_MISMATCH l=$lsz r=$rsz" >> $L; return 12; }
  echo "[$tag] stage ok $rsz" >> $L
  # wait QE ready
  for i in $(seq 1 50); do ssh $S -p $port root@$host 'test -x /opt/conda/envs/qe/bin/ph.x && echo R' 2>/dev/null | grep -q R && break; sleep 12; done
  ssh $S -p $port root@$host 'test -x /opt/conda/envs/qe/bin/ph.x && echo R' 2>/dev/null | grep -q R || { echo "[$tag] QE_FAIL" >> $L; return 13; }
  echo "[$tag] qe ready" >> $L
  # extract + ph.in + fire
  ssh $S -p $port root@$host "mkdir -p /root/work && cd /root/work && rm -rf out && tar xzf /root/li2mgh16_stage.tgz && cat > ph.in <<'PHEOF'
Li2MgH16 el-ph SHARD q$q irr $si-$li
&inputph
  prefix = 'li2mgh16'
  outdir = './out'
  fildyn = './li2mgh16.dyn'
  fildvscf = 'li2mgh16.dvscf'
  ldisp = .true.
  nq1 = 2, nq2 = 2, nq3 = 2
  start_q = $q
  last_q = $q
  start_irr = $si
  last_irr = $li
  tr2_ph = 1.0d-14
  recover = .false.
  electron_phonon = 'simple'
  el_ph_sigma = 0.005
  el_ph_nsigma = 10
/
PHEOF
nohup bash -c 'source /opt/conda/etc/profile.d/conda.sh; conda activate qe; export OMP_NUM_THREADS=1; echo START_\$(date +%s)>ph.log; mpirun --allow-run-as-root -np 8 ph.x -npool 4 -in ph.in > ph.out 2>&1; echo EXIT_\$?>>ph.log' >/dev/null 2>&1 & echo F" 2>/dev/null
  echo "[$tag] FIRED $(date +%H:%M:%S)" >> $L
}

while read id host port q si li tag; do
  one "$id" "$host" "$port" "$q" "$si" "$li" "$tag" &
done < "$MAP"
wait
echo "HEAL_PAR_DONE"
