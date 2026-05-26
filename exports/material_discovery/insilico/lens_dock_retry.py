#!/usr/bin/env python3
"""LENS docking — 6L8H chain A only (single-chain) retry"""
import os, subprocess, sys, glob

FIXED = "/tmp/6l8h_fixed.pdb"
CHAINA = "/tmp/6l8h_chainA.pdb"
RECEPTOR_BASE = "/tmp/6l8h_chainA_recep"

# Extract chain A only
with open(FIXED) as f, open(CHAINA, "w") as out:
    for l in f:
        if l.startswith("ATOM") and len(l) > 21 and l[21] == "A":
            out.write(l)
        elif l.startswith("TER"):
            out.write(l)
    out.write("END\n")
print("Chain A extracted: {}".format(CHAINA))
print("  ATOM lines: {}".format(sum(1 for l in open(CHAINA) if l.startswith("ATOM"))))

# HEM coords on chain A only — find HEM near chain A
import statistics
with open("/tmp/6L8H.pdb") as f:
    lines = f.readlines()
hem_a = [(float(l[30:38]), float(l[38:46]), float(l[46:54]))
         for l in lines if l.startswith("HETATM") and l[17:20].strip() == "HEM" and len(l) > 21 and l[21] == "A"]
if not hem_a:
    # Fallback: any HEM
    hem_a = [(float(l[30:38]), float(l[38:46]), float(l[46:54]))
             for l in lines if l.startswith("HETATM") and l[17:20].strip() == "HEM"][:50]
cx = statistics.mean(c[0] for c in hem_a)
cy = statistics.mean(c[1] for c in hem_a)
cz = statistics.mean(c[2] for c in hem_a)
print("HEM chain A box center ({} atoms): ({:.2f}, {:.2f}, {:.2f})".format(len(hem_a), cx, cy, cz))

# Receptor prep
MK = "/home/aiden/.venv-cosmedrug/bin/mk_prepare_receptor.py"
r = subprocess.run([MK, "--read_pdb", CHAINA, "-o", RECEPTOR_BASE, "-p"],
                   capture_output=True, text=True, timeout=600)
print("mk_prepare_receptor rc={}".format(r.returncode))
if r.stderr and len(r.stderr) > 200:
    print("stderr tail:", r.stderr[-300:])

receptor = None
for c in glob.glob(RECEPTOR_BASE + "*.pdbqt"):
    receptor = c; break
if not receptor:
    print("Receptor PDBQT FAIL"); sys.exit(2)
print("Receptor PDBQT: {} ({} bytes)".format(receptor, os.path.getsize(receptor)))

# Vina docking
from vina import Vina
v = Vina(sf_name="vina", cpu=4, verbosity=0)
v.set_receptor(receptor)
v.compute_vina_maps(center=[cx, cy, cz], box_size=[24.0, 24.0, 24.0])
print("Vina maps computed.")

results = []
for lig_path in sorted(glob.glob("/tmp/lig_lens/*.pdbqt")):
    name = os.path.basename(lig_path).replace(".pdbqt", "")
    try:
        v.set_ligand_from_file(lig_path)
        v.dock(exhaustiveness=8, n_poses=3)
        e = v.energies(n_poses=1)
        aff = float(e[0][0]) if len(e) > 0 else None
        results.append((name, aff, "OK"))
    except Exception as ex:
        results.append((name, None, "ERR:" + type(ex).__name__))

print()
print("=" * 60)
print("{:18s} {:>20s} {:>14s}".format("Compound", "BindAff (kcal/mol)", "Status"))
print("=" * 60)
sorted_r = sorted(results, key=lambda x: x[1] if isinstance(x[1], (int, float)) else 99)
for name, aff, st in sorted_r:
    aff_str = "{:+.2f}".format(aff) if isinstance(aff, (int, float)) else "-"
    print("{:18s} {:>20s} {:>14s}".format(name, aff_str, st))
print("=" * 60)
print("Box: center=({:.2f},{:.2f},{:.2f}) size=24A | target=6L8H chain A".format(cx, cy, cz))
