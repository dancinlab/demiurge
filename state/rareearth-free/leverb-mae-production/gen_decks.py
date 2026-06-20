#!/usr/bin/env python3
"""leverb-mae-production deck generator (d_deck_always: programmatic, not hand-authored).

Force-theorem MAE for 3d-only escape candidates:
  - FeCo B2 (bct) c/a scan: 0.9, 1.0, 1.1, 1.2, 1.3 (volume-conserving distortion).
  - Fe16N2 alpha'' (bct, interstitial N).

Recipe per cell:
  scf.in     : noncollinear+SOC SCF, M||[001] (angle1=0), converge charge density.
  nscf_001.in: single-shot (force theorem) band energy, M||[001].
  nscf_100.in: single-shot (force theorem) band energy, M||[100] (angle1=90).
  MAE = E(100) - E(001);  K1 = MAE / V_cell.

Regularities baked in (hard-won, d_deck_always):
  FR pseudo (has_so=T) · noncolin+lspinorb · mv smearing degauss 0.02 (metal) ·
  ecutrho = 10x ecutwfc (rrkjus US) · conv_thr 1e-8 · david diag.
"""
import os, math, textwrap

ROOT = os.path.dirname(os.path.abspath(__file__))
DECKS = os.path.join(ROOT, "decks")

ECUTWFC = 60.0
ECUTRHO = 600.0

def scf_block(prefix, pseudo_dir, species, cell, positions, kpts, mag_lines):
    sp_lines = "\n".join(f"  {s}" for s in species)
    cell_lines = "\n".join(f"  {x:.6f}  {y:.6f}  {z:.6f}" for (x,y,z) in cell)
    pos_lines = "\n".join(f"  {name}  {x:.6f}  {y:.6f}  {z:.6f}" for (name,x,y,z) in positions)
    return f"""&CONTROL
  calculation   = 'scf'
  prefix        = '{prefix}'
  outdir        = './out'
  pseudo_dir    = '{pseudo_dir}'
  verbosity     = 'high'
  tprnfor       = .false.
  tstress       = .false.
/
&SYSTEM
  ibrav         = 0
  nat           = {len(positions)}
  ntyp          = {len(species)}
  ecutwfc       = {ECUTWFC}
  ecutrho       = {ECUTRHO}
  occupations   = 'smearing'
  smearing      = 'mv'
  degauss       = 0.02
  noncolin      = .true.
  lspinorb      = .true.
{mag_lines}
/
&ELECTRONS
  conv_thr      = 1.0d-8
  mixing_beta   = 0.3
  electron_maxstep = 250
  diagonalization = 'david'
/
ATOMIC_SPECIES
{sp_lines}
CELL_PARAMETERS angstrom
{cell_lines}
ATOMIC_POSITIONS crystal
{pos_lines}
K_POINTS automatic
  {kpts}
"""

def nscf_block(prefix, pseudo_dir, species, cell, positions, kpts, mag_lines):
    sp_lines = "\n".join(f"  {s}" for s in species)
    cell_lines = "\n".join(f"  {x:.6f}  {y:.6f}  {z:.6f}" for (x,y,z) in cell)
    pos_lines = "\n".join(f"  {name}  {x:.6f}  {y:.6f}  {z:.6f}" for (name,x,y,z) in positions)
    return f"""&CONTROL
  calculation   = 'nscf'
  prefix        = '{prefix}'
  outdir        = './out'
  pseudo_dir    = '{pseudo_dir}'
  verbosity     = 'high'
/
&SYSTEM
  ibrav         = 0
  nat           = {len(positions)}
  ntyp          = {len(species)}
  ecutwfc       = {ECUTWFC}
  ecutrho       = {ECUTRHO}
  occupations   = 'smearing'
  smearing      = 'mv'
  degauss       = 0.02
  noncolin      = .true.
  lspinorb      = .true.
{mag_lines}
/
&ELECTRONS
  conv_thr      = 1.0d-9
  diagonalization = 'david'
  electron_maxstep = 1
  startingpot   = 'file'
/
ATOMIC_SPECIES
{sp_lines}
CELL_PARAMETERS angstrom
{cell_lines}
ATOMIC_POSITIONS crystal
{pos_lines}
K_POINTS automatic
  {kpts}
"""

FE = "Fe  55.845  Fe.rel-pbe-spn-rrkjus_psl.0.2.1.UPF"
CO = "Co  58.933  Co.rel-pbe-spn-rrkjus_psl.0.3.1.UPF"
# N: scalar pseudo is fine for the light interstitial; use a FR-compatible PBE N.
N  = "N   14.007  N.pbe-n-rrkjus_psl.1.0.0.UPF"

def write_cell(name, species, cell, positions, kpts_scf, kpts_nscf, mag_scf, vol_A3):
    d = os.path.join(DECKS, name)
    os.makedirs(d, exist_ok=True)
    pdir = "../../pseudo"
    # 001: angle1=0 ; 100: angle1=90 . Apply angle to all magnetic species.
    mag001 = mag_scf  # SCF runs at 001 reference
    # build per-axis mag lines for nscf
    open(os.path.join(d,"scf.in"),"w").write(
        scf_block(name, pdir, species, cell, positions, kpts_scf, mag_scf))
    open(os.path.join(d,"nscf_001.in"),"w").write(
        nscf_block(name, pdir, species, cell, positions, kpts_nscf, mag_axis(mag_scf,0.0)))
    open(os.path.join(d,"nscf_100.in"),"w").write(
        nscf_block(name, pdir, species, cell, positions, kpts_nscf, mag_axis(mag_scf,90.0)))
    open(os.path.join(d,"VOL_A3"),"w").write(f"{vol_A3:.6f}\n")
    return d

def mag_axis(mag_lines, angle):
    """Rewrite all angle1(i) lines to the given polar angle (deg)."""
    out=[]
    for ln in mag_lines.split("\n"):
        s=ln.strip()
        if s.startswith("angle1("):
            idx = s[s.find("(")+1:s.find(")")]
            out.append(f"  angle1({idx})     = {angle}")
        else:
            out.append(ln)
    return "\n".join(out)

# ---- FeCo B2 bct c/a scan (volume-conserving) ----
a0 = 2.840
V0 = a0**3
feco_mag = (
"  starting_magnetization(1) = 0.6\n"
"  starting_magnetization(2) = 0.4\n"
"  angle1(1)     = 0.0\n"
"  angle1(2)     = 0.0\n"
"  angle2(1)     = 0.0\n"
"  angle2(2)     = 0.0"
)
for r in [0.9, 1.0, 1.1, 1.2, 1.3]:
    a = a0 * r**(-1.0/3.0)
    c = a0 * r**(2.0/3.0)
    V = a*a*c
    cell = [(a,0,0),(0,a,0),(0,0,c)]
    pos = [("Fe",0.0,0.0,0.0),("Co",0.5,0.5,0.5)]
    # anisotropic k-grid: fewer along longer axis. base ~ 16 per ~2.8A.
    nk_a = max(8, round(16*2.866/a))
    nk_c = max(8, round(16*2.866/c))
    name = f"feco_ca{str(r).replace('.','p')}"
    write_cell(name, [FE,CO], cell, pos,
               kpts_scf=f"{nk_a} {nk_a} {nk_c}  0 0 0",
               kpts_nscf=f"{nk_a+4} {nk_a+4} {nk_c+4}  0 0 0",
               mag_scf=feco_mag, vol_A3=V)
    print(f"WROTE {name}: a={a:.4f} c={c:.4f} V={V:.4f} k_scf={nk_a}x{nk_a}x{nk_c}")

# ---- Fe16N2 alpha'' (bct) ----
# alpha''-Fe16N2: bct, a=5.72 A, c=6.29 A (conventional). 16 Fe + 2 N.
# Wyckoff (space group I4/mmm, #139). Standard fractional positions:
#   Fe(4d): (0,1/2,1/4)&sym ; Fe(4e): (0,0,z) z~0.31 ; Fe(8h): (x,x,0) x~0.25
#   N(2a):  (0,0,0)
# Using the widely-cited Jack 1951 / Sugita structure idealized positions.
aN = 5.72
cN = 6.29
VN = aN*aN*cN
fe16n2_pos = [
  # Fe 4d
  ("Fe",0.0,0.5,0.25),("Fe",0.5,0.0,0.25),("Fe",0.0,0.5,0.75),("Fe",0.5,0.0,0.75),
  # Fe 4e (z=0.3125)
  ("Fe",0.0,0.0,0.3125),("Fe",0.0,0.0,0.6875),("Fe",0.5,0.5,0.8125),("Fe",0.5,0.5,0.1875),
  # Fe 8h (x=0.25)
  ("Fe",0.25,0.25,0.0),("Fe",0.75,0.75,0.0),("Fe",0.25,0.75,0.0),("Fe",0.75,0.25,0.0),
  ("Fe",0.75,0.75,0.5),("Fe",0.25,0.25,0.5),("Fe",0.75,0.25,0.5),("Fe",0.25,0.75,0.5),
  # N 2a
  ("N",0.0,0.0,0.0),("N",0.5,0.5,0.5),
]
fe16n2_mag = (
"  starting_magnetization(1) = 0.5\n"
"  starting_magnetization(2) = 0.0\n"
"  angle1(1)     = 0.0\n"
"  angle2(1)     = 0.0"
)
cellN = [(aN,0,0),(0,aN,0),(0,0,cN)]
write_cell("fe16n2", [FE,N], cellN, fe16n2_pos,
           kpts_scf="6 6 6  0 0 0", kpts_nscf="8 8 8  0 0 0",
           mag_scf=fe16n2_mag, vol_A3=VN)
print(f"WROTE fe16n2: a={aN} c={cN} V={VN:.4f} (18 atoms)")
print("DONE")
