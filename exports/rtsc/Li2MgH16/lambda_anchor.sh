#!/bin/bash
# Run lambda.x on the anchor over all 8 q-points (all elph files local there).
# Only run AFTER anchor JOB DONE (all 8 dynN.elph.N present).
S="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=15 -o BatchMode=yes"
H=74.126.26.42; P=40288
ssh $S -p $P root@$H 'cd /root/li2mgh16
n=$(ls li2mgh16.dyn?.elph.? 2>/dev/null | wc -l)
echo "elph files present: $n/8"
[ "$n" -lt 8 ] && { echo "NOT_ALL_8_YET"; exit 1; }
# lambda.x input. Format (QE PHonon/tools/lambda.x):
#  line1: <upper_freq_THz>  <broadening_degauss_Ry>  <smearing_method_int>
#  line2: <nq>
#  next nq lines: qx qy qz  weight   (weights sum to 1; nosym -> 1/8 each)
#  next nq lines: <elph filename>
#  last: <mu*>
cat > lambda.in <<LEOF
25.0  0.12  1
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
echo "=== LAMBDA.OUT ==="
cat lambda.out'
