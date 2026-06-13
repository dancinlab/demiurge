#!/bin/bash
# Emit a shard ph.in to stdout. args: Q START_IRR LAST_IRR
Q=$1; SI=$2; LI=$3
cat <<EOF
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
EOF
