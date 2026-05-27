#!/usr/bin/env python3
"""Clean cell-extract: build scf.in from a finished vc-relax.out final cell.
Reads PREFIX from env (set by run.sh). No inline-heredoc nesting (avoids the
cabeh8 SyntaxError trap). Writes scf.in in the cwd.
"""
import re
import os

prefix = os.environ.get("PREFIX", "job")
src = open("vc-relax.in").read()
t = open("relax.out").read()

nat = re.search(r"nat\s*=\s*(\d+)", src).group(1)
ntyp = re.search(r"ntyp\s*=\s*(\d+)", src).group(1)
ec = re.search(r"ecutwfc\s*=\s*(\S+)", src).group(1)
er = re.search(r"ecutrho\s*=\s*(\S+)", src).group(1)

blk = t.split("Begin final coordinates")[-1].split("End final coordinates")[0]
cell = re.search(r"CELL_PARAMETERS[^\n]*\n((?:[^\n]*\n){3})", blk).group(1)
pos = "ATOMIC_POSITIONS" + blk.split("ATOMIC_POSITIONS")[1].split("K_POINTS")[0].rstrip() + "\n"
species = "ATOMIC_SPECIES" + src.split("ATOMIC_SPECIES")[1].split("ATOMIC_POSITIONS")[0]

scf = (
    "&control\n"
    "  calculation='scf'\n"
    "  prefix='%s'\n"
    "  outdir='./out'\n"
    "  pseudo_dir='./pseudo'\n"
    "  tprnfor=.true.\n"
    "  tstress=.true.\n"
    "/\n"
    "&system\n"
    "  ibrav=0\n"
    "  nat=%s\n"
    "  ntyp=%s\n"
    "  ecutwfc=%s\n"
    "  ecutrho=%s\n"
    "  occupations='smearing'\n"
    "  smearing='mp'\n"
    "  degauss=0.02\n"
    "/\n"
    "&electrons\n"
    "  conv_thr=1.0d-12\n"
    "  mixing_beta=0.4\n"
    "  electron_maxstep=300\n"
    "/\n"
    "%s"
    "CELL_PARAMETERS angstrom\n"
    "%s"
    "%s\n"
    "K_POINTS automatic\n"
    "  12 12 12 0 0 0\n"
) % (prefix, nat, ntyp, ec, er, species, cell, pos)

open("scf.in", "w").write(scf)
print("scf.in OK (prefix=%s nat=%s ntyp=%s)" % (prefix, nat, ntyp))
