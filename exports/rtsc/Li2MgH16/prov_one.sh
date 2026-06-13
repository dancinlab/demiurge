#!/bin/bash
# Provision ONE pod independently (no shared mutex). Timeout-guarded upload.
# args: HOST PORT Q SI LI TAG
HOST=$1; PORT=$2; Q=$3; SI=$4; LI=$5; TAG=$6
STAGE=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/li2mgh16_stage.tgz
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=20 -o ServerAliveInterval=30 -o ServerAliveCountMax=4 -o BatchMode=yes"
log(){ echo "[$TAG $(date +%H:%M:%S)] $*"; }

# ssh wait
up=0; for i in $(seq 1 40); do ssh $S -p $PORT root@$HOST 'echo ok' >/dev/null 2>&1 && { up=1; break; }; sleep 12; done
[ $up -eq 0 ] && { log SSH_FAIL; exit 11; }
log "ssh up"
# QE install if needed
ssh $S -p $PORT root@$HOST 'test -x /opt/conda/envs/qe/bin/ph.x && echo HAVE || nohup bash -c "source /opt/conda/etc/profile.d/conda.sh; conda create -y -n qe -c conda-forge qe=7.5 >/root/qe.log 2>&1; echo DONE>>/root/qe.log" >/dev/null 2>&1 &' 2>/dev/null
log "qe kicked"
# upload with timeout (10 min max); retry once
ok=0
for attempt in 1 2; do
  timeout 600 scp $S -P $PORT "$STAGE" root@$HOST:/root/li2mgh16_stage.tgz >/dev/null 2>&1
  rsz=$(ssh $S -p $PORT root@$HOST 'stat -c %s /root/li2mgh16_stage.tgz 2>/dev/null')
  lsz=$(stat -f %z "$STAGE")
  [ "$rsz" = "$lsz" ] && { ok=1; break; }
  log "upload retry (got $rsz want $lsz)"
done
[ $ok -eq 0 ] && { log SCP_FAIL; exit 12; }
log "stage ok"
# wait QE
for i in $(seq 1 50); do ssh $S -p $PORT root@$HOST 'test -x /opt/conda/envs/qe/bin/ph.x && echo R' 2>/dev/null|grep -q R && break; sleep 12; done
ssh $S -p $PORT root@$HOST 'test -x /opt/conda/envs/qe/bin/ph.x && echo R' 2>/dev/null|grep -q R || { log QE_FAIL; exit 13; }
log "qe ready"
# extract + fire
ssh $S -p $PORT root@$HOST "mkdir -p /root/work && cd /root/work && rm -rf out && tar xzf /root/li2mgh16_stage.tgz && cat > ph.in <<'PHEOF'
Li2MgH16 el-ph SHARD q$Q irr $SI-$LI
&inputph
  prefix = 'li2mgh16'
  outdir = './out'
  fildyn = './li2mgh16.dyn'
  fildvscf = 'li2mgh16.dvscf'
  ldisp = .true.
  nq1 = 2, nq2 = 2, nq3 = 2
  start_q = $Q
  last_q = $Q
  start_irr = $SI
  last_irr = $LI
  tr2_ph = 1.0d-14
  recover = .false.
  electron_phonon = 'simple'
  el_ph_sigma = 0.005
  el_ph_nsigma = 10
/
PHEOF
nohup bash -c 'source /opt/conda/etc/profile.d/conda.sh; conda activate qe; export OMP_NUM_THREADS=1; echo START_\$(date +%s)>ph.log; mpirun --allow-run-as-root -np 8 ph.x -npool 4 -in ph.in > ph.out 2>&1; echo EXIT_\$?>>ph.log' >/dev/null 2>&1 & echo F" 2>/dev/null
log "FIRED q$Q irr$SI-$LI"
