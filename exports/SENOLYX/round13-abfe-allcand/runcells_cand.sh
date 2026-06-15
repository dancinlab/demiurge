#!/usr/bin/env bash
# Per-pod runner: provision once (clean cuda-12.6), then run assigned TARGET:REP cells
# serially with retry-resume (transient minimize abort -> resume from per-rep .nc).
# Usage: runcells_cand.sh "MCL1:0 BCLXL:0"
#
# !!! LAUNCH PRODUCTION CELLS ONLY THROUGH THIS RETRY-RESUME WRAPPER !!!  (failure-mode #4)
# NEVER start a production cell with a bare `python abfe_cand.py &`. A bare background
# launch has NO crash recovery: a transient OpenMM minimize/segfault abort kills the
# cell permanently and it silently never produces ENS_RESULT — that is exactly what
# killed the manually-launched 17AG rep0 cell in R12. This wrapper retries up to 4x,
# and because abfe_cand.py RESUMES from the per-rep checkpoint abfe_{leg}_rep{REP}.nc
# (see abfe_cand.py: `if os.path.exists(out_nc): ...from_storage(reporter); .extend(...)`),
# each retry continues the SAME trajectory rather than restarting from zero.
set -uo pipefail
cd /workspace/r13cand
PY=/workspace/r13cand/mm/envs/fep/bin/python
export MAMBA_ROOT_PREFIX=/workspace/r13cand/mm
if [ ! -x "$PY" ]; then env TARGET=MCL1 REP=0 RUN_PROD=0 CUDA_PIN=12.6 bash bootstrap_cand.sh; fi
"$PY" -c 'import openmm' 2>/dev/null || { echo ENV_BROKEN; exit 30; }
for cr in "$@"; do
  TGT="${cr%%:*}"; REP="${cr##*:}"; LOG="cell_${TGT}_rep${REP}.log"
  echo "=== CELL $TGT REP$REP ===" | tee -a runcells.progress
  ok=0
  for a in 1 2 3 4; do
    echo "[attempt $a $(date -u +%FT%TZ)]" >> runcells.progress
    TARGET="$TGT" REP="$REP" OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu "$PY" abfe_cand.py >> "$LOG" 2>&1
    if grep -q "dG_bind (ABFE" "$LOG"; then ok=1; break; fi
    echo "[retry rc=$? resume]" >> runcells.progress
  done
  [ "$ok" = 1 ] && echo "CELL_OK $TGT $REP" >> runcells.progress || echo "CELL_FAIL $TGT $REP" >> runcells.progress
done
echo "RUNCELLS_DONE $(date -u +%FT%TZ)" >> runcells.progress
grep -hE "ENS_RESULT" cell_*.log 2>/dev/null | tail -20
