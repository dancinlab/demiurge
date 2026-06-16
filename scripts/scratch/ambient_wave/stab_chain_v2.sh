#!/usr/bin/env bash
# Ambient-superhydride STABILITY-GATE chain v2 (system QE via apt) — vc-relax -> scf
#   -> ph(DFPT no el_ph) -> q2r -> matdyn -> count imaginary modes.
# FROZEN-FIRST gate order: el_ph runs ONLY if 0 imaginary modes.
set -uo pipefail
cd "$(dirname "$0")"
PREFIX="${PREFIX:?set PREFIX e.g. acbeh8_amb}"
export OMP_NUM_THREADS=1
NP="${NP:-$(nproc)}"
[ "$NP" -gt 36 ] && NP=36   # cap MPI ranks (small cell; oversubscribe hurts)
RUN(){ echo "[chain] mpirun -np $NP $1 ..."; mpirun --allow-run-as-root -np "$NP" --bind-to none "$@"; }

# --- pseudo fetch (PSL 1.0.0 PBE) ---
mkdir -p pseudo
for upf in $(grep -hoE '[A-Za-z0-9._+-]+\.UPF' *.in | sort -u); do
  f="pseudo/$upf"
  [ -s "$f" ] && continue
  for url in \
    "https://pseudopotentials.quantum-espresso.org/upf_files/$upf" \
    "https://www.quantum-espresso.org/upf_files/$upf"; do
    wget -q "$url" -O "$f" && [ -s "$f" ] && break
    curl -sL "$url" -o "$f" && [ -s "$f" ] && break
  done
  [ -s "$f" ] && echo "[pseudo] OK $upf" || echo "[pseudo] MISSING $upf"
done

# --- 1. vc-relax @ press=0 ---
RUN pw.x -inp vc-relax.in > vc-relax.out 2>&1
grep -q "JOB DONE" vc-relax.out || { echo "STAB-FAIL: vc-relax"; tail -25 vc-relax.out; exit 1; }
echo "[chain] vc-relax JOB DONE"

# --- 1b. patch relaxed celldm + ATOMIC_POSITIONS into scf.in ---
python3 - <<'PYEOF'
import re
o=open("vc-relax.out").read()
cm=re.findall(r"CELL_PARAMETERS \(alat=\s*([0-9.]+)\)",o)
blocks=o.split("ATOMIC_POSITIONS")
pos=None
if len(blocks)>1:
    last=blocks[-1]
    lines=[]
    for l in last.splitlines()[1:]:
        if re.match(r"\s*[A-Za-z]+\s+[-0-9.]+\s+[-0-9.]+\s+[-0-9.]+", l): lines.append(l.rstrip())
        elif lines: break
    if lines: pos=lines
s=open("scf.in").read()
if cm: s=re.sub(r"celldm\(1\)\s*=\s*[0-9.]+","celldm(1) = %s"%cm[-1],s,count=1)
if pos:
    head=s.split("ATOMIC_POSITIONS")[0]
    kp="K_POINTS"+s.split("K_POINTS",1)[1]
    s=head+"ATOMIC_POSITIONS crystal\n"+"\n".join(pos)+"\n"+kp
open("scf.in","w").write(s)
print("[patch] scf.in celldm=%s natpos=%d"%(cm[-1] if cm else "kept", len(pos) if pos else 0))
PYEOF

# --- 2. scf ---
RUN pw.x -inp scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out || { echo "STAB-FAIL: scf"; tail -25 scf.out; exit 1; }
echo "[chain] scf JOB DONE"

# --- 3. ph DFPT (stability only, no el_ph) ---
RUN ph.x -inp ph_stab.in > ph_stab.out 2>&1
grep -q "JOB DONE" ph_stab.out && echo "[chain] ph JOB DONE" || echo "[chain] WARN ph not JOB DONE (walltime?) — matdyn on partial dyn"

# --- 4. q2r + matdyn ---
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
0.00 0.00 0.00
0.50 0.00 0.00
0.50 0.50 0.00
0.50 0.50 0.50
0.25 0.25 0.25
0.50 0.25 0.00
0.50 0.50 0.25
0.25 0.00 0.00
EOF
RUN matdyn.x -inp matdyn.in > matdyn.out 2>&1 || echo "WARN matdyn"

# --- 5. count imaginary modes (matdyn .freq + dyn fallback) ---
python3 - "$PREFIX" <<'PYEOF'
import re,sys,glob,json
pref=sys.argv[1]; freqs=[]
try:
    t=open(pref+".freq").read()
    # matdyn .freq: header "&plot nbnd=.. nks=.." then blocks of q + freq rows
    body=t.split("/",1)[-1] if "/" in t else t
    rows=re.findall(r"[-+]?\d+\.\d+",body)
    # skip the 3 q-coords per block heuristically by taking all and trusting cm-1 magnitudes
    freqs=[float(x) for x in rows]
    # matdyn freqs are typically the non-coordinate floats; filter coords (|x|<=1.0 in groups of 3 are q)
except: pass
if not freqs:
    for f in sorted(glob.glob(pref+".dyn*")):
        try:
            for line in open(f):
                m=re.search(r"freq.*=\s*[-0-9.]+\s*\[THz\]\s*=\s*([-0-9.]+)",line)
                if m: freqs.append(float(m.group(1)))
        except: pass
# robust: re-parse matdyn.out 'omega' if available
omega=[]
try:
    for line in open("matdyn.out"):
        m=re.findall(r"omega\(\s*\d+\)\s*=\s*[-0-9.]+\s*\[THz\]\s*=\s*([-0-9.]+)",line)
        omega+=[float(x) for x in m]
except: pass
use=omega if omega else freqs
hard=[f for f in use if f< -50]; mild=[f for f in use if -50<=f< -5]
res={"prefix":pref,"n_freqs":len(use),
     "n_imag_hard_below_-50cm-1":len(hard),"n_imag_mild_-50_to_-5":len(mild),
     "min_freq_cm1":min(use) if use else None,"max_freq_cm1":max(use) if use else None,
     "verdict_hint":"UNSTABLE" if hard else ("BORDERLINE" if mild else "STABLE")}
open("STABILITY_RESULT.json","w").write(json.dumps(res,indent=2))
print(json.dumps(res,indent=2))
PYEOF
echo "[chain] STABILITY-GATE complete -> STABILITY_RESULT.json"
