#!/bin/bash
# Assemble one q-point's full dynN + elphN from its 4 shards' per-irrep XMLs.
# Runs the assembly ON the s1 shard of that q (it has full save + the q's q_N dvscf scratch
# for irr 1-29; we add the other shards' dynmat/elph XMLs, then ph.x recover full-irr).
# args: Q  ASSEMBLE_HOST ASSEMBLE_PORT  SRC2 SRC3 SRC4 (each "host:port")
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=20 -o ServerAliveInterval=30 -o BatchMode=yes"
Q=$1; AH=$2; AP=$3; S2=$4; S3=$5; S4=$6
D=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16
LOC=$D/assembly/q$Q; mkdir -p $LOC

# 1. pull per-irrep XMLs from the 3 other shards to local
for src in "$S2" "$S3" "$S4"; do
  h=${src%:*}; p=${src#*:}
  scp $S -P $p "root@$h:/root/work/out/_ph0/li2mgh16.phsave/dynmat.$Q.*.xml" $LOC/ 2>/dev/null
  scp $S -P $p "root@$h:/root/work/out/_ph0/li2mgh16.phsave/elph.$Q.*.xml"   $LOC/ 2>/dev/null
done
echo "[q$Q] local dynmat=$(ls $LOC/dynmat.$Q.*.xml 2>/dev/null|wc -l) elph=$(ls $LOC/elph.$Q.*.xml 2>/dev/null|wc -l)"

# 2. push them onto the assemble host's phsave (which already has s1's irr 1-29)
scp $S -P $AP $LOC/dynmat.$Q.*.xml $LOC/elph.$Q.*.xml "root@$AH:/root/work/out/_ph0/li2mgh16.phsave/" 2>/dev/null
ad=$(ssh $S -p $AP root@$AH "ls /root/work/out/_ph0/li2mgh16.phsave/dynmat.$Q.*.xml 2>/dev/null|wc -l")
ae=$(ssh $S -p $AP root@$AH "ls /root/work/out/_ph0/li2mgh16.phsave/elph.$Q.*.xml 2>/dev/null|wc -l")
echo "[q$Q] assemble-host now has dynmat=$ad elph=$ae (expect 114 each)"

# 3. run ph.x recover full-irr for this q to write dynN + dynN.elph.N aggregate
ssh $S -p $AP root@$AH "cd /root/work && cat > ph_asm$Q.in <<'PHEOF'
Li2MgH16 assemble q$Q
&inputph
  prefix = 'li2mgh16'
  outdir = './out'
  fildyn = './li2mgh16.dyn'
  fildvscf = 'li2mgh16.dvscf'
  ldisp = .true.
  nq1 = 2, nq2 = 2, nq3 = 2
  start_q = $Q
  last_q = $Q
  tr2_ph = 1.0d-14
  recover = .true.
  electron_phonon = 'simple'
  el_ph_sigma = 0.005
  el_ph_nsigma = 10
/
PHEOF
nohup bash -c 'source /opt/conda/etc/profile.d/conda.sh; conda activate qe; export OMP_NUM_THREADS=1; echo ASMSTART>ph_asm$Q.log; mpirun --allow-run-as-root -np 8 ph.x -npool 4 -in ph_asm$Q.in > ph_asm$Q.out 2>&1; echo ASMEXIT_\$?>>ph_asm$Q.log' >/dev/null 2>&1 & echo ASM_FIRED_q$Q"
echo "[q$Q] assembly ph.x fired on $AH"
