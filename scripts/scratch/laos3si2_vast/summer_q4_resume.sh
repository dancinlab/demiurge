#!/usr/bin/env bash
# LaOs3Si2 q4 el-ph RESUME after summer reboot (killed at rep #12/16, NOT a crash).
# QE recover: out/_ph0 checkpoint survived reboot → resume q4 from last rep.
# Runs ph.x ONLY (NOT run_elph.sh, which `rm -rf out` would destroy the checkpoint).
set -uo pipefail
D=/home/summer/laos3si2_dfpt
QE=/home/summer/micromamba/envs/qe/bin
cd "$D" || { echo "no deck dir"; exit 2; }

# 1. idempotent: add recover = .true. right after &inputph (resume, not restart-from-scratch)
if ! grep -qi 'recover' ph.in; then
  awk '{print} /&inputph/{print "  recover = .true."}' ph.in > ph.in.tmp && mv ph.in.tmp ph.in
  echo "[resume] added recover=.true. to ph.in"
else
  echo "[resume] recover already present"
fi
grep -i recover ph.in

# 2. guard: refuse if a ph.x is already running (don't double-launch)
if pgrep -f '[p]h.x' >/dev/null; then echo "[resume] ph.x already running — abort"; exit 0; fi

# 3. relaunch ph.x detached, reusing the existing out/_ph0 checkpoint
export OMP_NUM_THREADS=1
nohup "$QE/mpirun" -np 6 --bind-to none "$QE/ph.x" -in ph.in >> ph_elph.out 2>&1 &
echo "[resume] ph.x RESUMED pid=$! (log appended to ph_elph.out)"
sleep 4
pgrep -f '[p]h.x' | head && echo "[resume] live ranks confirmed"
