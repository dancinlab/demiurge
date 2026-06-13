#!/usr/bin/env bash
# R12 17AAG ABFE — pod bootstrap v2 (runpod/vast fallback for summer parallelization).
# B4 (CUDA-PTX 222) is solved on a host with CUDA-driver >= 12.4 (this pod = 13.0).
# v2 fixes: (a) pod image lacks bzip2 -> apt-install it before untarring micromamba;
#           (b) use ABSOLUTE micromamba path, never rely on PATH/shell-hook.
# Engine == the validated R10b/R12 deck (openmmtools double-decoupling, NO openfe).
set -uo pipefail
WORK=/workspace/r12_17aag
mkdir -p "$WORK" && cd "$WORK"
MM="$WORK/bin/micromamba"
PY="$WORK/mm/envs/fep/bin/python"
export MAMBA_ROOT_PREFIX="$WORK/mm"

echo "=== [0] host CUDA driver (B4 gate) ==="
nvidia-smi --query-gpu=name,driver_version --format=csv,noheader || true

echo "=== [1] bzip2 + micromamba (absolute path) ==="
command -v bzip2 >/dev/null 2>&1 || (apt-get update -qq && apt-get install -y -qq bzip2) 2>&1 | tail -2
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest -o mm.tar.bz2
tar -xjf mm.tar.bz2 bin/micromamba
"$MM" --version || { echo "MM_INSTALL_FAIL"; exit 11; }

echo "=== [2] env (no openfe — the reliable subset) ==="
"$MM" create -y -p "$WORK/mm/envs/fep" -c conda-forge \
  python=3.11 openmm openmmtools openff-toolkit openff-nagl openmmforcefields \
  pdbfixer pymbar netcdf4 rdkit ambertools numpy 2>&1 | tail -5
test -x "$PY" || { echo "ENV_CREATE_FAIL"; exit 12; }

echo "=== [3] platform check (B4 confirm) ==="
"$PY" -c 'from openmm import Platform; import openmm; print("openmm",openmm.__version__); print("platforms",[Platform.getPlatform(i).getName() for i in range(Platform.getNumPlatforms())])' 2>&1 | tail -3

echo "=== [4] SMOKE gate (fast validity — must print dG_bind, no PTX-222) ==="
SMOKE=1 OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu "$PY" abfe_hsp90.py > smoke.log 2>&1
if grep -q "dG_bind (ABFE" smoke.log; then
  echo "SMOKE_PASS"
  echo "=== [5] PRODUCTION 17AAG (full 2-leg ABFE) ==="
  echo START_17AAG_POD "$(date)" > prod_progress.log
  nohup env OMP_NUM_THREADS=4 JAX_PLATFORMS=cpu "$PY" abfe_hsp90.py > prod.log 2>&1 &
  echo "PROD_PID $!"
  echo DISPATCHED_17AAG "$(date)" >> prod_progress.log
else
  echo "SMOKE_FAIL — tail:"
  tail -30 smoke.log
fi
