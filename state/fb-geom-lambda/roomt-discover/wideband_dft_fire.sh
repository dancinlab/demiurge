#!/usr/bin/env bash
# WIDEBAND-DFT fire — metallic-hbond-wideband R2 decisive compute (summer-FREE).
# ============================================================================
# Tests the L13-escape spec: does a short O-H-O bridge sit ON a WIDE metallic
# TM-4d band (eps_F >= 0.63 eV) AND gate that band's transfer (g/t >= 0.38)?
#
# Host: cubic ReO3-type MoO3 (corner-sharing MoO6, Mo-4d t2g band crosses E_F
#   in the H-reduced bronze) + 1 interstitial H on a Mo-O...H...O-Mo bridge.
#   This is the SMALL-cell idealization of the H_xMoO3 metallic bronze — the
#   real wide-band short-H-bond host. 5 atoms (Mo + 3 O + 1 H) = tractable free.
#
# MEASUREMENT (the verdict drivers):
#   (1) eps_F of the metallic Mo-4d band = (E_F - band_bottom) for the band
#       crossing E_F  -> L13 test (need >= 0.63 eV for 293 K).
#   (2) frozen-phonon proton scan: move H by +-du along the O-H-O axis, read
#       the shift of the Mo-4d band manifold near E_F -> dt/du -> g/t.
#       g = (dt/du)*u0,  u0 = proton ZPM from the O-H-O stretch Omega.
#   The KEY adverse-prior test: is dt/du/t SMALL because the band is wide
#       (proton = near-spectator on a delocalized 4d band)?  Or does the
#       in-path O-H-O bridge actually gate it?
#
# d6 HONEST: idealized cubic cell, x=1 (not the real x~0.3-1.7 incommensurate
#   bronze). Frozen-phonon (not full DFPT). The number it produces is TB-grade
#   anchored by a REAL DFT band response, not a pure model. Resume = real
#   bronze supercell DFPT, sized at tail.
set -euo pipefail
WD=/home/summer/rtsc_hmoo3
PSE=$WD/pseudo
cd "$WD"
source /home/summer/miniforge3/etc/profile.d/conda.sh
conda activate qe
export OMP_NUM_THREADS=1
NP=6

# --- cubic ReO3-type MoO3 lattice (a ~ 3.75 A); H displaced along O-H-O axis ---
# Mo at (0,0,0); O at (0.5,0,0),(0,0.5,0),(0,0,0.5). H near the O at (0.5,0,0),
# displaced along x toward Mo (the O-Mo-O bridge axis). We scan H x-fraction.
ALAT=3.75   # Angstrom (cubic)

mk_scf () {
  local TAG=$1 HX=$2 CALC=$3 KP=$4
  cat > scf_${TAG}.in <<EOF
&control
  calculation = '${CALC}'
  prefix = 'hmoo3_${TAG}'
  outdir = './out_${TAG}'
  pseudo_dir = '${PSE}'
  verbosity = 'high'
  tprnfor = .true. , tstress = .true.
/
&system
  ibrav = 1, celldm(1) = $(python3 -c "print(${ALAT}/0.52917721)")
  nat = 5, ntyp = 3
  ecutwfc = 50, ecutrho = 400
  occupations = 'smearing', smearing = 'mv', degauss = 0.02
  nspin = 1
/
&electrons
  conv_thr = 1.0d-7
  mixing_beta = 0.3
  electron_maxstep = 300
/
ATOMIC_SPECIES
  Mo 95.95  Mo.UPF
  O  16.00  O.UPF
  H   1.008 H.UPF
ATOMIC_POSITIONS crystal
  Mo  0.0  0.0  0.0
  O   0.5  0.0  0.0
  O   0.0  0.5  0.0
  O   0.0  0.0  0.5
  H   ${HX}  0.0  0.0
K_POINTS automatic
  ${KP} ${KP} ${KP} 0 0 0
EOF
}

# 1) SCF at the symmetric H position (proton centered on the O-Mo-O bridge midway
#    between Mo(0) and O(0.5) — the SHORT-SYMMETRIC-like reference). HX scan below.
echo "=== [1] SCF reference (H at bridge) ==="
mk_scf ref 0.30 scf 6
mpirun -np $NP --bind-to none pw.x -in scf_ref.in > scf_ref.out 2>&1 || { echo "SCF ref FAILED"; tail -30 scf_ref.out; exit 1; }
grep -E "Fermi|highest occupied|convergence has been achieved|!.*total energy|number of k points" scf_ref.out | tail -8

# 2) frozen-phonon proton scan: HX in {0.26,0.28,0.30,0.32,0.34} along O-Mo axis.
#    du in crystal frac -> Angstrom = dHX*ALAT. Track E_F + band manifold shift.
echo "=== [2] proton frozen-phonon scan ==="
for HX in 0.26 0.28 0.30 0.32 0.34; do
  TAG=hx${HX/./}
  mk_scf $TAG $HX scf 6
  mpirun -np $NP --bind-to none pw.x -in scf_${TAG}.in > scf_${TAG}.out 2>&1 || { echo "scan $HX FAILED"; tail -15 scf_${TAG}.out; continue; }
  EF=$(grep -E "Fermi energy" scf_${TAG}.out | tail -1)
  EN=$(grep -E "^!.*total energy" scf_${TAG}.out | tail -1)
  echo "HX=$HX  $EF  $EN"
done

# 3) dense band/eps_F probe at reference: nscf + bands to get band bottom of the
#    band crossing E_F (eps_F = E_F - band_bottom of partially-filled band).
echo "=== [3] eps_F probe (nscf dense + band extrema) ==="
mk_scf nscf 0.30 nscf 10
mpirun -np $NP --bind-to none pw.x -in scf_nscf.in > scf_nscf.out 2>&1 || { echo "nscf FAILED"; tail -20 scf_nscf.out; }
grep -E "Fermi energy|highest occupied, lowest unoccupied" scf_nscf.out | tail -4

echo "=== DONE — outputs in $WD/scf_*.out ==="
