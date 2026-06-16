#!/usr/bin/env bash
# LaOs3Si2 GREEN confirmation: per-sibling vc-relax (the fixed-LaRu3Si2-cell screen
# gave dE=+0.039 GREEN; this checks the GREEN survives lattice relaxation to Os radii).
# Chain: vc-relax (Os cell) -> extract relaxed celldm -> patch scf/bands -> scf
# -> bands (verbosity='high') -> parse_flatband.py. Self-logging (survives detach).
exec >> "$HOME/laos3si2_vcrelax.log" 2>&1
set -u
cd "$HOME/sib_work/laos3si2_fx" || { echo "NO DIR"; exit 1; }
QE=/home/summer/micromamba/envs/qe/bin
export OMP_NUM_THREADS=1
run() { "$QE/mpirun" -np 6 --bind-to none "$QE/pw.x" -in "$1" > "$2" 2>&1; }

echo "#### LaOs3Si2 vc-relax $(date) ####"

# 1) build vc-relax.in FROM the verified Os scf.in (calc -> vc-relax + ions/cell blocks)
python3 - <<'PY'
t = open("scf.in").read()
t = t.replace("calculation = 'scf'", "calculation = 'vc-relax'")
# append ions/cell namelists before ATOMIC_SPECIES if not present
if "ion_dynamics" not in t:
    t = t.replace("ATOMIC_SPECIES",
        "&ions\n  ion_dynamics = 'bfgs'\n/\n&cell\n  cell_dynamics = 'bfgs'\n  press_conv_thr = 0.5\n/\nATOMIC_SPECIES", 1)
open("vcrelax_os.in","w").write(t)
print("built vcrelax_os.in from Os scf.in")
PY

echo "-- vc-relax --"; run vcrelax_os.in vcrelax_os.out
grep -q "JOB DONE" vcrelax_os.out || { echo "VCRELAX FAIL"; exit 1; }
grep -i "Final enthalpy\|new unit-cell volume\|JOB DONE" vcrelax_os.out | tail -3

# 2) extract relaxed celldm(1)/celldm(3) from vc-relax output
python3 - <<'PY'
import re
t=open("vcrelax_os.out").read()
# CELL_PARAMETERS (alat= ..) blocks: take the LAST one; alat in bohr
al=re.findall(r"CELL_PARAMETERS \(alat=\s*([\d.]+)\)\n\s*([-\d. ]+)\n\s*([-\d. ]+)\n\s*([-\d. ]+)", t)
if al:
    alat=float(al[-1][0])
    v1=[float(x) for x in al[-1][1].split()]
    v3=[float(x) for x in al[-1][3].split()]
    import math
    a=alat*math.sqrt(v1[0]**2+v1[1]**2+v1[2]**2)
    c=alat*math.sqrt(v3[0]**2+v3[1]**2+v3[2]**2)
    print(f"RELAXED alat_bohr={a:.5f} c_over_a={c/a:.5f}")
    open("relaxed_celldm.txt","w").write(f"{a:.5f} {c/a:.5f}")
else:
    print("WARN: no CELL_PARAMETERS(alat) block; cell may be reported as celldm — fallback")
PY
[ -s relaxed_celldm.txt ] || { echo "NO relaxed celldm extracted"; exit 1; }
read A3 C3 < relaxed_celldm.txt
echo "patching scf/bands to relaxed celldm(1)=$A3 celldm(3)=$C3"

# 3) patch scf.in + bands.in celldm to relaxed values (work on relaxed copies)
for f in scf bands; do
  python3 - "$f.in" "$A3" "$C3" <<'PY'
import sys,re
f,a,c=sys.argv[1],sys.argv[2],sys.argv[3]
t=open(f).read()
t=re.sub(r"celldm\(1\)\s*=\s*[\d.]+", f"celldm(1) = {a}", t)
t=re.sub(r"celldm\(3\)\s*=\s*[\d.]+", f"celldm(3) = {c}", t)
open(f.replace(".in","_rlx.in"),"w").write(t)
PY
done

echo "-- scf (relaxed) --"; run scf_rlx.in scf_rlx.out
grep -q "JOB DONE" scf_rlx.out || { echo "SCF(rlx) FAIL"; exit 1; }
grep "absolute magnetization" scf_rlx.out | tail -1
echo "-- bands (relaxed, verbosity high) --"; run bands_rlx.in bands_rlx.out
echo "JOBDONE=$(grep -c 'JOB DONE' bands_rlx.out) kpts=$(grep -c 'bands (ev)' bands_rlx.out)"
echo "== LaOs3Si2 RELAXED GATE =="
# parse reads scf.out (E_F) + bands.out -> point both at the relaxed outputs
cp scf_rlx.out scf.out
cp bands_rlx.out bands.out
python3 parse_flatband.py 2>&1
echo "=== LaOs3Si2 vc-relax DONE $(date) ==="
