#!/usr/bin/env bash
# Install micromamba + QE 7.x on a bare vast pod (self-detaching).
# Idempotent: skips if pw.x already on PATH. Writes progress to ~/qe_setup.log.
#
# RECURRENCE GUARD (트러블슈팅 재발방지 · c14-c substrate): the prior version
# printed "QE SETUP DONE" UNCONDITIONALLY even when the micromamba curl|tar
# install had failed (line "No such file or directory"). A watcher keyed on
# "QE SETUP DONE" then fired sizing against a pod with no pw.x → silent empty
# scf.out → a whole session of "SCF produces no output" mystery. Fix: a robust
# install (verify the binary downloaded + is executable, retry once) AND a
# CONDITIONAL terminal line — "QE SETUP DONE" ONLY when pw.x actually runs,
# else "QE SETUP FAILED: <reason>" + exit 1 (fail LOUD, never false-DONE).
if [ "${BG:-}" != "1" ]; then
  BG=1 nohup bash "$0" > "$HOME/qe_setup.log" 2>&1 &
  echo "qe-setup launched pid=$!"
  exit 0
fi
set -uo pipefail
cd "$HOME"
export MAMBA_ROOT_PREFIX="$HOME/micromamba"
MM="$HOME/bin/micromamba"

ensure_deps() {
  # ROOT CAUSE (c1) of the session-long "SCF no output" saga: micro.mamba.pm
  # serves a .tar.bz2, and `tar -xj` shells out to an EXTERNAL bzip2 binary —
  # a bare vast/runpod pod often ships WITHOUT bzip2, so the extract dies with
  # "bzip2: Cannot exec: No such file or directory" and micromamba is never
  # installed. Guarantee bzip2 (+ curl/tar) before the download.
  if command -v bzip2 >/dev/null 2>&1 && command -v curl >/dev/null 2>&1; then return 0 ; fi
  echo "[setup] installing bzip2/curl/tar (tar -xj dep)..."
  (apt-get update -qq && apt-get install -y -qq bzip2 curl tar) >/dev/null 2>&1 || true
}

install_micromamba() {
  mkdir -p "$HOME/bin"
  ensure_deps
  # micro.mamba.pm serves a bzip2 tar with the binary at bin/micromamba.
  curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
    | tar -xj -C "$HOME" bin/micromamba 2>/dev/null
}

if [ ! -x "$MM" ]; then
  echo "[setup] installing micromamba (attempt 1)..."
  install_micromamba
  if [ ! -x "$MM" ]; then
    echo "[setup] micromamba missing after attempt 1 — retrying..."
    install_micromamba
  fi
fi
# GUARD 1: the install must have produced a runnable binary, else FAIL LOUD.
if [ ! -x "$MM" ] || ! "$MM" --version >/dev/null 2>&1; then
  echo "=== QE SETUP FAILED: micromamba not installed (curl|tar from micro.mamba.pm failed) ==="
  exit 1
fi
echo "[setup] micromamba $("$MM" --version 2>/dev/null) OK"

# Idempotent: skip env create if pw.x is already resolvable in the qe env.
if "$MM" run -n qe which pw.x >/dev/null 2>&1; then
  echo "[setup] qe env already has pw.x — skipping create"
else
  echo "[setup] creating qe env (qe + openmpi from conda-forge)..."
  "$MM" create -y -n qe -c conda-forge qe openmpi 2>&1 | tail -5
fi
echo "[setup] verify:"
"$MM" run -n qe which pw.x ph.x 2>&1 || true
# GUARD 2: declare DONE only when pw.x is RESOLVABLE in the env. QE binaries
# have no `-h`/`--version` that exits 0 (a prior `pw.x -h` probe false-FAILED a
# perfectly-installed QE), so `which pw.x` is the correct liveness check.
if "$MM" run -n qe which pw.x >/dev/null 2>&1; then
  echo "=== QE SETUP DONE ==="
else
  echo "=== QE SETUP FAILED: pw.x not found in qe env ==="
  exit 1
fi
