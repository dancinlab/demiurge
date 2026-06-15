#!/usr/bin/env bash
# SENOLYX R13 candidate ABFE — vast pod bootstrap (clean cuda-12.6 env + smoke).
#   env: TARGET=BCLXL|CRBN|MCL1  REP=0..K-1  RUN_PROD=0|1
set -uo pipefail
WORK=/workspace/r13cand
mkdir -p "$WORK" && cd "$WORK"
MM="$WORK/bin/micromamba"; PY="$WORK/mm/envs/fep/bin/python"
export MAMBA_ROOT_PREFIX="$WORK/mm"
TARGET="${TARGET:-MCL1}"; REP="${REP:-0}"; RUN_PROD="${RUN_PROD:-1}"

echo "=== [0] host CUDA (B4 gate) ==="; nvidia-smi --query-gpu=name,driver_version --format=csv,noheader || true
if [ ! -x "$PY" ]; then
  echo "=== [1] micromamba ==="
  command -v bzip2 >/dev/null 2>&1 || (apt-get update -qq && apt-get install -y -qq bzip2) 2>&1 | tail -1
  curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest -o mm.tar.bz2
  tar -xjf mm.tar.bz2 bin/micromamba; "$MM" --version || { echo MM_FAIL; exit 11; }
  echo "=== [2] fep env (cuda-version pin = B4 fix) ==="
  PIN="${CUDA_PIN:-12.6}"
  "$MM" create -y -p "$WORK/mm/envs/fep" -c conda-forge \
    "cuda-version=$PIN" python=3.11 openmm openmmtools openff-toolkit openff-nagl openmmforcefields \
    pdbfixer pymbar netcdf4 rdkit ambertools numpy 2>&1 | tail -4
  test -x "$PY" || { echo ENV_FAIL; exit 12; }
fi
echo "=== [3] platform ==="; "$PY" -c 'from openmm import Platform; print([Platform.getPlatform(i).getName() for i in range(Platform.getNumPlatforms())])'
echo "=== [4] SMOKE ($TARGET) ==="
SMOKE=1 TARGET="$TARGET" REP=0 OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu "$PY" abfe_cand.py > smoke_${TARGET}.log 2>&1
if grep -q "dG_bind (ABFE" smoke_${TARGET}.log; then echo "SMOKE_PASS"; else echo "SMOKE_FAIL"; tail -25 smoke_${TARGET}.log; exit 20; fi
if [ "$RUN_PROD" = "1" ]; then
  echo "=== [5] PROD $TARGET REP$REP ==="
  TARGET="$TARGET" REP="$REP" OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu "$PY" abfe_cand.py > cell_${TARGET}_rep${REP}.log 2>&1
  grep -E "ENS_RESULT|dG_bind .ABFE" cell_${TARGET}_rep${REP}.log | tail -4
fi
