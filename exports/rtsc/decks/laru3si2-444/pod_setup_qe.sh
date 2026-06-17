#!/usr/bin/env bash
# Install micromamba + QE 7.x on a bare vast pod (self-detaching).
# Idempotent: skips if pw.x already on PATH. Writes progress to ~/qe_setup.log.
if [ "${BG:-}" != "1" ]; then
  BG=1 nohup bash "$0" > "$HOME/qe_setup.log" 2>&1 &
  echo "qe-setup launched pid=$!"
  exit 0
fi
set -uo pipefail
cd "$HOME"
export MAMBA_ROOT_PREFIX="$HOME/micromamba"
if [ ! -x "$HOME/bin/micromamba" ]; then
  echo "[setup] installing micromamba..."
  mkdir -p "$HOME/bin"
  curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj -C "$HOME" bin/micromamba
fi
MM="$HOME/bin/micromamba"
echo "[setup] creating qe env (qe + openmpi from conda-forge)..."
"$MM" create -y -n qe -c conda-forge qe openmpi 2>&1 | tail -5
echo "[setup] verify:"
"$MM" run -n qe which pw.x ph.x
"$MM" run -n qe pw.x -h 2>&1 | head -2 || true
echo "=== QE SETUP DONE ==="
