#!/bin/bash
# Provision + dispatch ONE shard pod end-to-end.
# args: HOST PORT Q START_IRR LAST_IRR TAG
HOST=$1; PORT=$2; Q=$3; SI=$4; LI=$5; TAG=$6
STAGE=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/li2mgh16_stage.tgz
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=25 -o ServerAliveInterval=30 -o ServerAliveCountMax=4"
log(){ echo "[$TAG $(date +%H:%M:%S)] $*"; }

# 1. wait for ssh
for i in $(seq 1 40); do
  ssh $S -p $PORT root@$HOST 'echo ok' >/dev/null 2>&1 && { log "ssh up"; break; }
  sleep 12
done
ssh $S -p $PORT root@$HOST 'echo ok' >/dev/null 2>&1 || { log "SSH FAIL"; exit 11; }

# 2. install QE (background on pod) + start, then upload stage in parallel
ssh $S -p $PORT root@$HOST 'test -x /opt/conda/envs/qe/bin/ph.x && echo HAVE_QE || nohup bash -c "source /opt/conda/etc/profile.d/conda.sh; conda create -y -n qe -c conda-forge qe=7.5 >/root/qe_install.log 2>&1; echo DONE_\$? >>/root/qe_install.log" >/dev/null 2>&1 &' 2>/dev/null
log "qe install kicked"

# 3. upload stage
scp $S -P $PORT "$STAGE" root@$HOST:/root/li2mgh16_stage.tgz >/dev/null 2>&1 && log "stage uploaded" || { log "SCP FAIL"; exit 12; }

# 4. wait for QE install
for i in $(seq 1 40); do
  ssh $S -p $PORT root@$HOST 'test -x /opt/conda/envs/qe/bin/ph.x && echo READY' 2>/dev/null | grep -q READY && { log "qe ready"; break; }
  sleep 12
done
ssh $S -p $PORT root@$HOST 'test -x /opt/conda/envs/qe/bin/ph.x && echo READY' 2>/dev/null | grep -q READY || { log "QE INSTALL FAIL"; exit 13; }

# 5. extract + write ph.in + fire
ssh $S -p $PORT root@$HOST "mkdir -p /root/work && cd /root/work && tar xzf /root/li2mgh16_stage.tgz && cat > ph.in <<'PHEOF'
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
nproc > /root/work/ncpu" 2>/dev/null
log "extracted + ph.in written"

# choose np: min(16, effective). use 8 (matches anchor band-group ratio, npool 4)
ssh $S -p $PORT root@$HOST 'cd /root/work; nohup bash -c "source /opt/conda/etc/profile.d/conda.sh; conda activate qe; export OMP_NUM_THREADS=1; echo START_\$(date +%s) > ph.log; mpirun --allow-run-as-root -np 8 ph.x -npool 4 -in ph.in > ph.out 2>&1; echo EXIT_\$? >> ph.log" >/dev/null 2>&1 & echo FIRED' 2>/dev/null
log "ph.x FIRED q$Q irr $SI-$LI"
