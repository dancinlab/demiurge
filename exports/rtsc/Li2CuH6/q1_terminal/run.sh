#!/usr/bin/env bash
# Li2CuH6 DFT el-ph — demiurge RTSC cation-VEC funnel (ambient X2MH6 VEC=19).
# PBE (pure, NOT hybrid — d14) · vc-relax → SCF(16^3 k) → ph.x el-ph 4^3 q (d7 small-cell).
# Pseudos staged at ./pseudo/  (Li.pbe-s-rrkjus_psl.1.0.0.UPF · Cu.pbe-dn-rrkjus_psl.1.0.0.UPF · H.pbe-rrkjus_psl.1.0.0.UPF).
# Host ubu-1 conda env qe, -np 6.
set -uo pipefail
source /home/aiden/miniforge3/bin/activate qe
WD=/home/aiden/rtsc_li2cuh6
cd "$WD"
NP=6
export OMP_NUM_THREADS=1
echo "=== START $(date -Is) host=$(hostname) np=$NP ===" > "$WD/run.log"

echo "=== VC-RELAX begin $(date -Is) ===" >> "$WD/run.log"
mpirun -np $NP pw.x -in relax.in > vcrelax.out 2> vcrelax.err
if ! grep -q 'JOB DONE' vcrelax.out; then
  echo "=== VC-RELAX FAILED $(date -Is) ===" >> "$WD/run.log"
  tail -20 vcrelax.out >> "$WD/run.log"
  echo DONE-VCRELAX-FAIL >> "$WD/run.log"
  exit 10
fi
echo "=== VC-RELAX done $(date -Is) ===" >> "$WD/run.log"
grep -m1 'CELL_PARAMETERS\|new unit-cell volume' vcrelax.out >> "$WD/run.log" || true

# Auto-extract relaxed alat & write scf_relaxed.in with updated celldm(1) + atomic positions.
python3 - <<'PYEOF'
import re, pathlib
vc = pathlib.Path('/home/aiden/rtsc_li2cuh6/vcrelax.out').read_text()
# last 'CELL_PARAMETERS (alat=  X.XXXXXX)' block contains the final lattice
m_cell = list(re.finditer(r'CELL_PARAMETERS \(alat=\s*([\d\.E+\-]+)\)([\s\S]+?)ATOMIC_POSITIONS', vc))
m_pos  = list(re.finditer(r'ATOMIC_POSITIONS\s+\((\w+)\)([\s\S]+?)\n\s*(?:End|$)', vc))
if m_cell and m_pos:
    alat_bohr = float(m_cell[-1].group(1))
    # cell vectors are in units of input alat (NOT bohr) — multiply by input celldm later if needed
    cell_lines = m_cell[-1].group(2).strip().splitlines()
    pos_block  = m_pos[-1].group(0)
    pos_units  = m_pos[-1].group(1)
    pos_lines  = m_pos[-1].group(2).strip().splitlines()
    print(f'parsed alat_bohr={alat_bohr} pos_units={pos_units}')
    scf = pathlib.Path('/home/aiden/rtsc_li2cuh6/scf.in').read_text()
    # replace celldm(1) value
    scf2 = re.sub(r'celldm\(1\)\s*=\s*[\d\.E+\-]+', f'celldm(1) = {alat_bohr:.6f}', scf)
    # replace ATOMIC_POSITIONS block
    scf2 = re.sub(r'ATOMIC_POSITIONS[\s\S]+?K_POINTS', f'ATOMIC_POSITIONS {pos_units}\n' + '\n'.join(pos_lines) + '\nK_POINTS', scf2)
    pathlib.Path('/home/aiden/rtsc_li2cuh6/scf_relaxed.in').write_text(scf2)
    print('wrote scf_relaxed.in')
else:
    print('WARN: could not parse vc-relax output — using stock scf.in')
PYEOF

SCF_IN=scf.in
if [ -f /home/aiden/rtsc_li2cuh6/scf_relaxed.in ]; then SCF_IN=scf_relaxed.in; fi
echo "=== SCF begin $(date -Is) using $SCF_IN ===" >> "$WD/run.log"
mpirun -np $NP pw.x -in $SCF_IN > scf.out 2> scf.err
if ! grep -q 'JOB DONE' scf.out; then
  echo "=== SCF FAILED $(date -Is) ===" >> "$WD/run.log"
  tail -20 scf.out >> "$WD/run.log"
  echo DONE-SCF-FAIL >> "$WD/run.log"
  exit 11
fi
echo "=== SCF done $(date -Is) ===" >> "$WD/run.log"
grep -m1 'the Fermi energy' scf.out >> "$WD/run.log" || true

echo "=== PH begin $(date -Is) ===" >> "$WD/run.log"
mpirun -np $NP ph.x -in ph.in > ph.out 2> ph.err
if ! grep -q 'JOB DONE' ph.out; then
  echo "=== PH FAILED/INCOMPLETE $(date -Is) ===" >> "$WD/run.log"
  tail -30 ph.out >> "$WD/run.log"
  echo DONE-PH-FAIL >> "$WD/run.log"
  exit 12
fi
echo "=== PH done $(date -Is) ===" >> "$WD/run.log"
echo DONE >> "$WD/run.log"
