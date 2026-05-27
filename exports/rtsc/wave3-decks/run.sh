#!/bin/bash
# Generic wave-3 el-ph chain. PREFIX = candidate dir basename.
# Avoids the nested-heredoc trap: cell-extract is a separate clean extract.py.
set -e
cd "$(dirname "$0")"
PREFIX="$(basename "$PWD")"
export PREFIX
export OMP_NUM_THREADS=1
ulimit -s unlimited
M="mpirun --allow-run-as-root -np 6 --bind-to none"
: > relax.out; : > scf.out; : > ph.out
echo "=== $PREFIX VC-RELAX start $(date -u) ===" | tee chain.log
nice -n 15 $M pw.x -in vc-relax.in > relax.out 2>&1
grep -q "JOB DONE" relax.out || { echo "RELAX FAIL" | tee -a chain.log; tail -25 relax.out; exit 1; }
echo "=== SCF build from relaxed cell ===" | tee -a chain.log
python3 extract.py | tee -a chain.log
echo "=== SCF start $(date -u) ===" | tee -a chain.log
nice -n 15 $M pw.x -in scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out || { echo "SCF FAIL" | tee -a chain.log; tail -20 scf.out; exit 1; }
echo "=== PH start $(date -u) ===" | tee -a chain.log
nice -n 15 $M ph.x -in ph.in > ph.out 2>&1
grep -q "JOB DONE" ph.out || { echo "PH FAIL" | tee -a chain.log; tail -20 ph.out; exit 1; }
echo "CHAIN DONE $(date -u)" | tee -a chain.log
