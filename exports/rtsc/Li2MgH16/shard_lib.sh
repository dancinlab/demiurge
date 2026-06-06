#!/bin/bash
# Li2MgH16 q5-q8 2-level GRID shard helpers
# Source this. Provides: vssh, vscp_to, rent_offer, wait_ssh, push_stage, dispatch_shard
STAGE=/Users/mini/dancinlab/demiurge/exports/rtsc/Li2MgH16/li2mgh16_stage.tgz
SSHO="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=25 -o ServerAliveInterval=30"

# backoff wrapper for vastai (429-resilient)
vbackoff() {
  local delay=30 try=1
  while (( try <= 8 )); do
    out=$(vastai "$@" 2>&1)
    if echo "$out" | grep -qiE '429|too many|rate limit'; then
      echo "[backoff] 429 try=$try sleep=$delay" >&2
      sleep $delay; delay=$((delay*2)); try=$((try+1)); continue
    fi
    echo "$out"; return 0
  done
  echo "$out"; return 1
}

# rent: $1=offer_id $2=label -> prints new instance id
rent_offer() {
  local off=$1 label=$2
  out=$(vbackoff create instance "$off" --image quay.io/condaforge/miniforge3:latest \
        --disk 30 --label "$label" --ssh --direct 2>&1)
  echo "$out" >&2
  echo "$out" | grep -oE "'new_contract': [0-9]+" | grep -oE '[0-9]+' | head -1
}
