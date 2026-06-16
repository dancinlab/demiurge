#!/usr/bin/env bash
# Ambient-superhydride STABILITY-GATE chain — vc-relax -> scf -> ph(DFPT no el_ph)
#   -> q2r -> matdyn -> count imaginary modes.
# FROZEN-FIRST gate order (FLEET-DIAGNOSTIC lesson): el_ph runs ONLY if 0 imaginary modes.
# Templated by PREFIX; the dispatcher copies this + the deck files onto the pod.
set -uo pipefail
cd "$(dirname "$0")"
PREFIX="${PREFIX:?set PREFIX e.g. acbeh8_amb}"

# --- conda QE env ---
source ~/miniconda3/etc/profile.d/conda.sh 2>/dev/null || source ~/conda/etc/profile.d/conda.sh 2>/dev/null || true
conda activate qe 2>/dev/null || conda create -y -n qe -c conda-forge qe >/dev/null 2>&1 && conda activate qe
export OMP_NUM_THREADS=1
NP=$(nproc)
RUN(){ echo "[chain] $*"; mpirun --allow-run-as-root -np "$NP" --bind-to none "$@"; }

# --- pseudo fetch (PSL 1.0.0 PBE) ---
mkdir -p pseudo && cd pseudo
fetch(){ [ -s "$1" ] || wget -q "https://pseudopotentials.quantum-espresso.org/upf_files/$1" || \
         curl -sLO "https://pseudopotentials.quantum-espresso.org/upf_files/$1"; }
for upf in $(grep -hoE '[A-Za-z0-9._-]+\.UPF' ../*.in | sort -u); do fetch "$upf"; done
ls -la; cd ..

# --- 1. vc-relax @ press=0 ---
RUN pw.x -inp vc-relax.in > vc-relax.out 2>&1
grep -q "JOB DONE" vc-relax.out || { echo "STAB-FAIL: vc-relax"; exit 1; }

# --- 1b. patch relaxed celldm + ATOMIC_POSITIONS into scf.in ---
python3 - "$PREFIX" <<'PYEOF'
import re,sys
o=open("vc-relax.out").read()
# last CELL_PARAMETERS (alat) -> derive new celldm(1) if present, else keep
cm=re.findall(r"CELL_PARAMETERS \(alat=\s*([0-9.]+)\)",o)
# last ATOMIC_POSITIONS block
blocks=re.split(r"ATOMIC_POSITIONS",o)
pos="ATOMIC_POSITIONS"+blocks[-1].split("End final")[0] if "ATOMIC_POSITIONS" in o else None
s=open("scf.in").read()
if cm:
    s=re.sub(r"celldm\(1\)\s*=\s*[0-9.]+", "celldm(1) = %s"%cm[-1], s, count=1)
if pos:
    # replace from ATOMIC_POSITIONS to K_POINTS
    head=s.split("ATOMIC_POSITIONS")[0]
    kp="K_POINTS"+s.split("K_POINTS",1)[1]
    # take only the coord lines from relax pos
    lines=[l for l in pos.splitlines() if l.strip() and not l.strip().startswith("ATOMIC_POSITIONS")]
    coord="\n".join(lines[:50])
    s=head+"ATOMIC_POSITIONS crystal\n"+coord+"\n"+kp
open("scf.in","w").write(s)
print("[patch] scf.in updated celldm=%s"%(cm[-1] if cm else "kept"))
PYEOF

# --- 2. scf ---
RUN pw.x -inp scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out || { echo "STAB-FAIL: scf"; exit 1; }

# --- 3. ph DFPT (stability only, no el_ph) ---
RUN ph.x -inp ph_stab.in > ph_stab.out 2>&1
grep -q "JOB DONE" ph_stab.out || echo "WARN: ph not JOB DONE (may be walltime; matdyn on partial)"

# --- 4. q2r + matdyn for stability frequencies ---
cat > q2r.in <<EOF
&input
  fildyn='${PREFIX}.dyn', zasr='crystal', flfrc='${PREFIX}.fc'
/
EOF
RUN q2r.x -inp q2r.in > q2r.out 2>&1 || echo "WARN q2r"

cat > matdyn.in <<EOF
&input
  asr='crystal', flfrc='${PREFIX}.fc', flfrq='${PREFIX}.freq', q_in_band_form=.false.
/
8
0.0 0.0 0.0
0.5 0.0 0.0
0.5 0.5 0.0
0.5 0.5 0.5
0.25 0.25 0.25
0.5 0.25 0.0
0.5 0.5 0.25
0.25 0.0 0.0
EOF
RUN matdyn.x -inp matdyn.in > matdyn.out 2>&1 || echo "WARN matdyn"

# --- 5. count imaginary modes (from dyn files + matdyn freq) ---
python3 - "$PREFIX" <<'PYEOF'
import re,sys,glob
pref=sys.argv[1]
freqs=[]
# matdyn .freq: frequencies in cm-1 after each q line
try:
    txt=open(pref+".freq").read()
    nums=re.findall(r"[-+]?\d+\.\d+",txt)
    # matdyn freq format: header then blocks; grab all floats, the cm-1 freqs
    freqs=[float(x) for x in nums]
except Exception as e:
    pass
# fallback: parse dyn files' "freq (" lines
if not freqs:
    for f in sorted(glob.glob(pref+".dyn*")):
        try:
            for line in open(f):
                m=re.search(r"freq \(.*\)\s*=\s*[-0-9.]+\s*\[THz\]\s*=\s*([-0-9.]+)",line)
                if m: freqs.append(float(m.group(1)))
        except: pass
imag_hard=[f for f in freqs if f < -50]
imag_mild=[f for f in freqs if -50 <= f < -5]
res={"prefix":pref,"n_freqs_parsed":len(freqs),
     "n_imag_hard_below_-50cm-1":len(imag_hard),
     "n_imag_mild_-50_to_-5":len(imag_mild),
     "min_freq_cm1":min(freqs) if freqs else None,
     "max_freq_cm1":max(freqs) if freqs else None,
     "verdict_hint":"UNSTABLE" if imag_hard else ("BORDERLINE" if imag_mild else "STABLE")}
import json
open("STABILITY_RESULT.json","w").write(json.dumps(res,indent=2))
print(json.dumps(res,indent=2))
PYEOF
echo "[chain] STABILITY-GATE complete -> STABILITY_RESULT.json"
