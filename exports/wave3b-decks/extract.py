#!/usr/bin/env python3
# extract.py — pull the FINAL relaxed geometry from a QE vc-relax output and
# emit a CELL_PARAMETERS (bohr) + ATOMIC_POSITIONS block for the scf/ph chain.
#
# CRITICAL alat->bohr FIX (wave-3 bug): QE writes the relaxed cell as
#   CELL_PARAMETERS (alat= X.XXXX)
#   v1x v1y v1z   (vectors in UNITS OF alat)
# Copying those numbers into a deck declared `CELL_PARAMETERS bohr` collapses the
# cell to ~1 bohr -> `rgen: too many r-vectors` crash. Fix: multiply each relaxed
# cell vector by alat (bohr) and emit `CELL_PARAMETERS bohr`.
#
# usage: python3 extract.py <vc-relax.out>  -> writes geom.in
import sys, re

if len(sys.argv) < 2:
    sys.stderr.write("usage: extract.py <vc-relax.out>\n"); sys.exit(2)
out = open(sys.argv[1]).read()

cell_iter = list(re.finditer(
    r'CELL_PARAMETERS\s*\(\s*alat\s*=\s*([0-9.Ee+\-]+)\s*\)\s*\n'
    r'\s*([-0-9.Ee+]+)\s+([-0-9.Ee+]+)\s+([-0-9.Ee+]+)\s*\n'
    r'\s*([-0-9.Ee+]+)\s+([-0-9.Ee+]+)\s+([-0-9.Ee+]+)\s*\n'
    r'\s*([-0-9.Ee+]+)\s+([-0-9.Ee+]+)\s+([-0-9.Ee+]+)', out))
if not cell_iter:
    sys.stderr.write("extract.py: no CELL_PARAMETERS (alat=...) block — vc-relax unfinished?\n")
    sys.exit(3)
m = cell_iter[-1]
alat = float(m.group(1))                       # alat in BOHR (QE a.u. output)
vecs = [[float(m.group(2)), float(m.group(3)), float(m.group(4))],
        [float(m.group(5)), float(m.group(6)), float(m.group(7))],
        [float(m.group(8)), float(m.group(9)), float(m.group(10))]]
cell_bohr = [[c * alat for c in row] for row in vecs]

pos_iter = list(re.finditer(
    r'ATOMIC_POSITIONS\s*\(?\s*(crystal|angstrom|bohr|alat)?\s*\)?\s*\n((?:\s*[A-Za-z]{1,3}\s+[-0-9.Ee+]+\s+[-0-9.Ee+]+\s+[-0-9.Ee+]+.*\n)+)',
    out))
if not pos_iter:
    sys.stderr.write("extract.py: no ATOMIC_POSITIONS block.\n"); sys.exit(4)
pm = pos_iter[-1]
unit = (pm.group(1) or 'alat').strip()
atoms = []
for ln in pm.group(2).splitlines():
    if not ln.strip(): continue
    t = ln.split()
    atoms.append((t[0], float(t[1]), float(t[2]), float(t[3])))

with open('geom.in', 'w') as f:
    f.write("CELL_PARAMETERS bohr\n")
    for row in cell_bohr:
        f.write(f"  {row[0]:.10f}  {row[1]:.10f}  {row[2]:.10f}\n")
    f.write(f"ATOMIC_POSITIONS {unit}\n")
    for a in atoms:
        f.write(f"  {a[0]:<3s}  {a[1]:.10f}  {a[2]:.10f}  {a[3]:.10f}\n")

amag = (cell_bohr[0][0]**2 + cell_bohr[0][1]**2 + cell_bohr[0][2]**2) ** 0.5
sys.stderr.write(f"extract.py OK: alat={alat:.6f} bohr, {len(atoms)} atoms, |a|={amag:.4f} bohr, unit={unit}\n")
