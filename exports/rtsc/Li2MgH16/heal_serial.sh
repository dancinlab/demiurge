#!/bin/bash
# Serial heal: provision replacement pods ONE AT A TIME (no bandwidth contention).
# Reads newmap.txt lines: ID HOST PORT Q SI LI TAG
STAGE=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/li2mgh16_stage.tgz
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=20 -o ServerAliveInterval=30 -o BatchMode=yes"
MAP=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/newmap.txt

while read id host port q si li tag; do
  echo "=================== $tag ($host:$port q$q irr$si-$li) ==================="
  # wait ssh
  up=0
  for i in $(seq 1 30); do
    ssh $S -p $port root@$host 'echo ok' >/dev/null 2>&1 && { up=1; break; }
    sleep 12
  done
  [ $up -eq 0 ] && { echo "$tag SSH_FAIL"; continue; }
  echo "$tag ssh up"
  # install QE (bg) if needed
  ssh $S -p $port root@$host 'test -x /opt/conda/envs/qe/bin/ph.x && echo HAVE || nohup bash -c "source /opt/conda/etc/profile.d/conda.sh; conda create -y -n qe -c conda-forge qe=7.5 >/root/qe.log 2>&1; echo DONE>>/root/qe.log" >/dev/null 2>&1 &' 2>/dev/null
  # SERIAL upload (the whole point)
  scp $S -P $port "$STAGE" root@$host:/root/li2mgh16_stage.tgz >/dev/null 2>&1
  rsz=$(ssh $S -p $port root@$host 'stat -c %s /root/li2mgh16_stage.tgz 2>/dev/null')
  lsz=$(stat -f %z "$STAGE")
  [ "$rsz" != "$lsz" ] && { echo "$tag SCP_SIZE_MISMATCH local=$lsz remote=$rsz"; continue; }
  echo "$tag stage ok ($rsz)"
  # wait QE
  for i in $(seq 1 40); do
    ssh $S -p $port root@$host 'test -x /opt/conda/envs/qe/bin/ph.x && echo R' 2>/dev/null | grep -q R && break
    sleep 12
  done
  ssh $S -p $port root@$host 'test -x /opt/conda/envs/qe/bin/ph.x && echo R' 2>/dev/null | grep -q R || { echo "$tag QE_FAIL"; continue; }
  echo "$tag qe ready"
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
nohup bash -c 'source /opt/conda/etc/profile.d/conda.sh; conda activate qe; export OMP_NUM_THREADS=1; echo START_\$(date +%s)>ph.log; mpirun --allow-run-as-root -np 8 ph.x -npool 4 -in ph.in > ph.out 2>&1; echo EXIT_\$?>>ph.log' >/dev/null 2>&1 & echo FIRED" 2>/dev/null
  echo "$tag FIRED"
done < "$MAP"
echo "HEAL_DONE"
