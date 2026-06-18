#!/usr/bin/env bash
# short detached launcher for pod2 shard (SCF regen + el-ph q7-12)
pkill -9 -f run_prod.sh 2>/dev/null || true
pkill -9 -f "ph.x"      2>/dev/null || true
pkill -9 -f "pw.x"      2>/dev/null || true
sleep 3
nohup bash /root/pod2_run.sh > /root/laru3si2_444/prod.log 2>&1 &
echo "POD2 LAUNCHED pid=$!"
