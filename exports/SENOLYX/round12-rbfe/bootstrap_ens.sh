#!/usr/bin/env bash
# SENOLYX R12 ensemble ABFE — vast pod bootstrap (one (LIG,REP) cell per pod).
# Reuses the validated R10b/R12 openmmtools double-decoupling deck via abfe_hsp90_ens.py.
# B4 (CUDA-PTX 222) gate: only rent hosts with cuda_max_good >= 12.4.
#   env: LIG=17AG|17AAG  REP=0..K-1  RUN_PROD=0|1  (SMOKE always run first)
set -uo pipefail
WORK=/workspace/r12ens
mkdir -p "$WORK" && cd "$WORK"
MM="$WORK/bin/micromamba"
PY="$WORK/mm/envs/fep/bin/python"
export MAMBA_ROOT_PREFIX="$WORK/mm"
LIG="${LIG:-17AG}"; REP="${REP:-0}"; RUN_PROD="${RUN_PROD:-1}"

echo "=== [0] host CUDA driver (B4 gate) ==="
nvidia-smi --query-gpu=name,driver_version --format=csv,noheader || true

if [ ! -x "$PY" ]; then
  echo "=== [1] bzip2 + micromamba ==="
  command -v bzip2 >/dev/null 2>&1 || (apt-get update -qq && apt-get install -y -qq bzip2) 2>&1 | tail -2
  curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest -o mm.tar.bz2
  tar -xjf mm.tar.bz2 bin/micromamba
  "$MM" --version || { echo "MM_INSTALL_FAIL"; exit 11; }
  echo "=== [2] fep env (no openfe — reliable subset) ==="
  # B4 PTX-222 fix: pin cuda-version <= host nvidia-smi CUDA, else conda-forge
  # resolves openmm against a TOO-NEW cudatoolkit (e.g. 13.3 on a 13.0 driver).
  HOSTCUDA=$(nvidia-smi 2>/dev/null | sed -n 's/.*CUDA Version: \([0-9][0-9.]*\).*/\1/p' | head -1)
  PIN="${CUDA_PIN:-12.6}"   # 12.6 PTX runs on any driver >= 12.6 (fwd-compat)
  echo "host CUDA=$HOSTCUDA  pinning cuda-version=$PIN"
  "$MM" create -y -p "$WORK/mm/envs/fep" -c conda-forge \
    "cuda-version=$PIN" python=3.11 openmm openmmtools openff-toolkit openff-nagl openmmforcefields \
    pdbfixer pymbar netcdf4 rdkit ambertools numpy 2>&1 | tail -5
  test -x "$PY" || { echo "ENV_CREATE_FAIL"; exit 12; }
fi

echo "=== [3] platform check (B4 confirm) ==="
"$PY" -c 'from openmm import Platform; import openmm; print("openmm",openmm.__version__); print("platforms",[Platform.getPlatform(i).getName() for i in range(Platform.getNumPlatforms())])' 2>&1 | tail -3

echo "=== [4] SMOKE gate (must print dG_bind, no PTX-222) ==="
SMOKE=1 LIG=17AG REP=0 OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu "$PY" abfe_hsp90_ens.py > smoke.log 2>&1
if grep -q "dG_bind (ABFE" smoke.log; then
  echo "SMOKE_PASS"
else
  echo "SMOKE_FAIL"; tail -20 smoke.log; exit 20
fi

if [ "$RUN_PROD" = "1" ]; then
  echo "=== [5] PRODUCTION cell LIG=$LIG REP=$REP ==="
  echo "START $(date -u +%FT%TZ) LIG=$LIG REP=$REP" > cell_${LIG}_rep${REP}.progress
  LIG="$LIG" REP="$REP" OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu \
    "$PY" abfe_hsp90_ens.py > cell_${LIG}_rep${REP}.log 2>&1
  echo "DONE $(date -u +%FT%TZ) rc=$?" >> cell_${LIG}_rep${REP}.progress
  echo "=== cell result ==="; grep -E "ENS_RESULT|dG_bind|dG_decouple" cell_${LIG}_rep${REP}.log | tail -10
fi
