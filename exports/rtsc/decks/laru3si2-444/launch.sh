#!/usr/bin/env bash
# Robust detached launcher for run_prod.sh — a SHORT remote command (`bash
# launch.sh`) is less truncation-prone over a flaky vast proxy than an inline
# `nohup ... &` one-liner. Kills any stale run_prod/ph.x, clears phonon scratch
# (SCF out/*.save preserved), then backgrounds the q-batched production runner.
pkill -9 -f run_prod.sh 2>/dev/null || true
pkill -9 -f "ph.x"      2>/dev/null || true
sleep 4
cd /root/laru3si2_444 || exit 2
rm -rf out/_ph0 2>/dev/null || true
# q-range args (SQ LQ) for d_qforge_parallel sharding — default full 1..12.
SQ="${1:-1}"; LQ="${2:-12}"
nohup bash /root/run_prod.sh "$SQ" "$LQ" > /root/laru3si2_444/prod.log 2>&1 &
echo "LAUNCHED run_prod q$SQ..$LQ pid=$!"
