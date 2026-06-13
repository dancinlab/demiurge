#!/bin/bash
# Compute the QE answer-key lambda for Li2MgH16 from all 8 q-points' dynN.elph.N files.
# Runs on the anchor (has q1-4) after pushing shard-derived dyn5-8.elph.5-8.
# args: ANCHOR_HOST ANCHOR_PORT  (defaults to 39610026)
AH=${1:-74.126.26.42}; AP=${2:-40288}
D=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=15 -o BatchMode=yes"

# push harvested dyn5-8 + elph onto a lambda workdir on the anchor (NON-destructive: separate dir)
ssh $S -p $AP root@$AH 'mkdir -p /root/lambda_work && cd /root/lambda_work && cp /root/li2mgh16/li2mgh16.dyn{1,2,3,4}.elph.{1,2,3,4} . 2>/dev/null; cp /root/li2mgh16/li2mgh16.dyn{1,2,3,4} . 2>/dev/null; cp /root/li2mgh16/li2mgh16.dyn0 . 2>/dev/null; ls' 2>/dev/null
for q in 5 6 7 8; do
  scp $S -P $AP "$D/harvest_final/li2mgh16.dyn$q" "$D/harvest_final/li2mgh16.dyn$q.elph.$q" "root@$AH:/root/lambda_work/" 2>/dev/null
done

# Build lambda.in. Format (QE lambda.x):
#  line1: emax(THz?)  degauss(of lambda)  smearing_index? -> actually: <upper_freq> <degauss> <nsig?>
#  Standard PH/examples lambda.in:
#    <emax_meV> <degauss> <ngauss>
#    <nq>
#    q1x q1y q1z wq1
#    ... per q (cartesian 2pi/a, weights sum to 1)
#    file.elph.1
#    ... per q
#    mu*
ssh $S -p $AP root@$AH "cd /root/lambda_work && cat > lambda.in <<'LEOF'
20.0  0.12  1
8
   0.000000000   0.000000000   0.000000000  0.125
  -0.353553399  -0.353553386   0.353553387  0.125
  -0.353553390   0.353553387  -0.353553377  0.125
  -0.707106789   0.000000001   0.000000010  0.125
   0.353553400  -0.353553394  -0.353553393  0.125
   0.000000001  -0.707106780  -0.000000006  0.125
   0.000000010  -0.000000007  -0.707106770  0.125
  -0.353553389  -0.353553393  -0.353553383  0.125
li2mgh16.dyn1.elph.1
li2mgh16.dyn2.elph.2
li2mgh16.dyn3.elph.3
li2mgh16.dyn4.elph.4
li2mgh16.dyn5.elph.5
li2mgh16.dyn6.elph.6
li2mgh16.dyn7.elph.7
li2mgh16.dyn8.elph.8
0.10
LEOF
source /opt/conda/etc/profile.d/conda.sh; conda activate qe
lambda.x < lambda.in > lambda.out 2>&1
echo '=== LAMBDA.OUT ==='; cat lambda.out"
