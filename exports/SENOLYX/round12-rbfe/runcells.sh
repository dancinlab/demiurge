#!/usr/bin/env bash
# Per-pod runner: provision once (clean cuda-12.6 env), then run an assigned list
# of (LIG:REP) cells serially, each with retry-resume (transient minimize abort →
# resume from per-rep .nc). Usage: runcells.sh "17AG:1 17AAG:0"
set -uo pipefail
cd /workspace/r12ens
PY=/workspace/r12ens/mm/envs/fep/bin/python
export MAMBA_ROOT_PREFIX=/workspace/r12ens/mm

# provision (clean) + smoke once
if [ ! -x "$PY" ]; then
  env LIG=17AG REP=0 RUN_PROD=0 CUDA_PIN=12.6 bash bootstrap_ens.sh
fi
"$PY" -c 'import openmm' 2>/dev/null || { echo "ENV_BROKEN"; exit 30; }

for cr in "$@"; do
  LIG="${cr%%:*}"; REP="${cr##*:}"
  LOG="cell_${LIG}_rep${REP}.log"
  echo "=== CELL $LIG REP$REP ===" | tee -a runcells.progress
  ok=0
  for attempt in 1 2 3 4; do
    echo "[attempt $attempt] $(date -u +%FT%TZ)" >> runcells.progress
    LIG="$LIG" REP="$REP" OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu "$PY" abfe_hsp90_ens.py >> "$LOG" 2>&1
    rc=$?
    if grep -q "dG_bind (ABFE" "$LOG"; then ok=1; echo "[done attempt $attempt rc=$rc]" >> runcells.progress; break; fi
    echo "[retry: rc=$rc, resuming from .nc]" >> runcells.progress
  done
  [ "$ok" = 1 ] && echo "CELL_OK $LIG $REP" >> runcells.progress || echo "CELL_FAIL $LIG $REP" >> runcells.progress
done
echo "RUNCELLS_DONE $(date -u +%FT%TZ)" >> runcells.progress
grep -E "ENS_RESULT|dG_bind .ABFE" cell_*.log 2>/dev/null | tail -20
