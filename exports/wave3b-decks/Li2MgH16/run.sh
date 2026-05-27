#!/bin/bash
# Li2MgH16 el-ph chain: vc-relax -> extract(alat->bohr) -> scf -> ph -> CHAIN DONE
set -e
cd "$(dirname "$0")"
source /root/miniforge3/etc/profile.d/conda.sh 2>/dev/null || true
conda activate qe 2>/dev/null || true
PW=$(command -v pw.x); PH=$(command -v ph.x)
NP=${NP:-6}
echo "=== Li2MgH16 chain start $(date -u +%FT%TZ) np=$NP pw=$PW ===" | tee chain.log

: > vc-relax.out; : > scf.out; : > ph.out

echo "--- vc-relax ---" | tee -a chain.log
mpirun --allow-run-as-root -np $NP "$PW" -inp vc-relax.in > vc-relax.out 2>&1
grep -q "JOB DONE" vc-relax.out && echo "vc-relax JOB DONE" | tee -a chain.log

echo "--- extract (alat->bohr) ---" | tee -a chain.log
python3 extract.py vc-relax.out 2>> chain.log

NAT=$(awk '/ATOMIC_POSITIONS/{p=1;next} p&&NF>=4{n++} END{print n}' geom.in)
echo "NAT=$NAT" | tee -a chain.log
sed "s/__NAT__/$NAT/" scf.in.head > scf.in
cat geom.in >> scf.in
cat scf.in.tail >> scf.in

echo "--- scf ---" | tee -a chain.log
mpirun --allow-run-as-root -np $NP "$PW" -inp scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out && echo "scf JOB DONE" | tee -a chain.log

echo "--- ph (el-ph simple) ---" | tee -a chain.log
mpirun --allow-run-as-root -np $NP "$PH" -inp ph.in > ph.out 2>&1
grep -q "JOB DONE" ph.out && echo "ph JOB DONE" | tee -a chain.log

echo "CHAIN DONE $(date -u +%FT%TZ)" | tee -a chain.log
