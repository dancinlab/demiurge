#!/usr/bin/env bash
# QE 7.x env bootstrap (micromamba) — hexa deck canonical · fail-loud.
if [ "${BG:-}" != "1" ]; then
  BG=1 nohup bash "$0" > "$HOME/qe_setup.log" 2>&1 & echo "qe-setup launched pid=$!"; exit 0
fi
set -uo pipefail
export MAMBA_ROOT_PREFIX="$HOME/micromamba"
MM="$HOME/bin/micromamba"
ensure_deps() {
  command -v bzip2 >/dev/null 2>&1 && command -v curl >/dev/null 2>&1 && return 0
  echo '[setup] installing bzip2/curl/tar (tar -xj dep)...'
  (apt-get update -qq && apt-get install -y -qq bzip2 curl tar) >/dev/null 2>&1 || true
}
if [ ! -x "$MM" ]; then
  ensure_deps; mkdir -p "$HOME/bin"
  for try in 1 2; do
    curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xj -C "$HOME" bin/micromamba 2>/dev/null
    [ -x "$MM" ] && break
  done
fi
if [ ! -x "$MM" ] || ! "$MM" --version >/dev/null 2>&1; then
  echo '=== QE SETUP FAILED: micromamba not installed (bzip2/curl tar -xj from micro.mamba.pm) ==='; exit 1
fi
echo "[setup] micromamba $("$MM" --version 2>/dev/null) OK"
if "$MM" run -n qe which pw.x >/dev/null 2>&1; then
  echo '[setup] qe env already has pw.x — skipping create'
else
  echo '[setup] creating qe env (qe + openmpi from conda-forge)...'
  "$MM" create -y -n qe -c conda-forge qe openmpi 2>&1 | tail -5
fi
if "$MM" run -n qe which pw.x >/dev/null 2>&1; then
  echo '=== QE SETUP DONE ==='
else
  echo '=== QE SETUP FAILED: pw.x not found in qe env ==='; exit 1
fi
