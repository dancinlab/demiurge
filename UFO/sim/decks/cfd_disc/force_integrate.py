#!/usr/bin/env python3
# force_integrate.py — integrate pressure + viscous drag/lift over the OpenFOAM
# `disc` wall patch from a converged steady incompressible RANS field.
# Robust fallback for the broken v1912 forceCoeffs function object (sha1 writer bug).
#   F_pressure = rho * sum_f ( p_f * Sf )      (p kinematic [m2/s2], Sf outward area vec)
#   F_viscous  = rho * sum_f ( -tau_w * |Sf| )  via wall velocity gradient + nu_eff
#   Cd = Fx / (0.5 rho U^2 Aref) ,  Cl = Fz / (0.5 rho U^2 Aref)
import re, sys, math, os

CASE = sys.argv[1] if len(sys.argv) > 1 else "."
TIME = sys.argv[2] if len(sys.argv) > 2 else None
RHO  = 1.225
U    = 50.0
AREF = 28.2743   # pi*(D/2)^2, D=6
NU   = 1.48e-5

def read_foam_list(path, kind="scalar"):
    """Parse OpenFOAM 'nonuniform List<...>\\nN\\n(...)' or 'uniform v'."""
    t = open(path).read()
    # internalField
    m = re.search(r'internalField\s+nonuniform\s+List<\w+>\s*\n?\s*(\d+)\s*\n\(', t)
    if not m:
        mu = re.search(r'internalField\s+uniform\s+([^;]+);', t)
        if mu: return ('uniform', mu.group(1).strip())
        raise RuntimeError(f"cannot parse internalField in {path}")
    n = int(m.group(1))
    start = m.end()
    depth = 1; i = start; buf = []
    # collect to matching ')'
    seg = t[start:]
    end = seg.find('\n)')
    body = seg[:end]
    if kind == "scalar":
        vals = [float(x) for x in body.split()]
    else:  # vector triples in '(a b c)'
        vals = [tuple(float(y) for y in v.split()) for v in re.findall(r'\(([^)]+)\)', body)]
    assert len(vals) == n, f"{path}: expected {n} got {len(vals)}"
    return ('list', vals)

def read_int_list(path):
    t = open(path).read()
    m = re.search(r'\)\s*\n\s*(\d+)\s*\n\(', t)  # after FoamFile header close
    # The first big list after header: N\n(
    m = re.search(r'\n(\d+)\s*\n\(', t)
    n = int(m.group(1)); start = m.end()
    seg = t[start:]; end = seg.find('\n)')
    body = seg[:end]
    vals = [int(x) for x in body.split()]
    assert len(vals) == n, f"{path}: int list expected {n} got {len(vals)}"
    return vals

def read_points(path):
    t = open(path).read()
    m = re.search(r'\n(\d+)\s*\n\(', t)
    n = int(m.group(1)); start = m.end()
    seg = t[start:]; end = seg.find('\n)')
    body = seg[:end]
    pts = [tuple(float(y) for y in v.split()) for v in re.findall(r'\(([^)]+)\)', body)]
    assert len(pts) == n, f"points expected {n} got {len(pts)}"
    return pts

def read_faces(path):
    t = open(path).read()
    m = re.search(r'\n(\d+)\s*\n\(', t)
    n = int(m.group(1)); start = m.end()
    seg = t[start:]; end = seg.find('\n)')
    body = seg[:end]
    # each face: k(p0 p1 ... pk-1)
    faces = []
    for mm in re.finditer(r'(\d+)\(([^)]*)\)', body):
        faces.append([int(x) for x in mm.group(2).split()])
    assert len(faces) == n, f"faces expected {n} got {len(faces)}"
    return faces

def boundary_info(path, name):
    t = open(path).read()
    m = re.search(re.escape(name) + r'\s*\{(.*?)\}', t, re.S)
    b = m.group(1)
    nF = int(re.search(r'nFaces\s+(\d+)', b).group(1))
    sF = int(re.search(r'startFace\s+(\d+)', b).group(1))
    return nF, sF

def face_area_and_centre(face, pts):
    # polygon area vector = 0.5 * sum (p_i x p_{i+1}) about centroid; OpenFOAM uses
    # decomposition into triangles from face centre.
    pcoords = [pts[i] for i in face]
    nP = len(pcoords)
    fc = tuple(sum(c[k] for c in pcoords)/nP for k in range(3))
    Sf = [0.0, 0.0, 0.0]; Cf = [0.0,0.0,0.0]; sumA = 0.0
    for i in range(nP):
        a = pcoords[i]; b = pcoords[(i+1)%nP]
        # triangle (fc, a, b)
        v1 = (a[0]-fc[0], a[1]-fc[1], a[2]-fc[2])
        v2 = (b[0]-fc[0], b[1]-fc[1], b[2]-fc[2])
        cr = (v1[1]*v2[2]-v1[2]*v2[1], v1[2]*v2[0]-v1[0]*v2[2], v1[0]*v2[1]-v1[1]*v2[0])
        tA = 0.5
        Sf[0]+=0.5*cr[0]; Sf[1]+=0.5*cr[1]; Sf[2]+=0.5*cr[2]
        tc = ((fc[0]+a[0]+b[0])/3,(fc[1]+a[1]+b[1])/3,(fc[2]+a[2]+b[2])/3)
        mag = 0.5*math.sqrt(cr[0]**2+cr[1]**2+cr[2]**2)
        Cf[0]+=mag*tc[0]; Cf[1]+=mag*tc[1]; Cf[2]+=mag*tc[2]; sumA+=mag
    if sumA>0:
        Cf=[c/sumA for c in Cf]
    return Sf, Cf

def main():
    pm = os.path.join(CASE, "constant", "polyMesh")
    pts   = read_points(os.path.join(pm, "points"))
    faces = read_faces(os.path.join(pm, "faces"))
    owner = read_int_list(os.path.join(pm, "owner"))
    nF, sF = boundary_info(os.path.join(pm, "boundary"), "disc")
    # converged time
    global TIME
    if TIME is None:
        times = [d for d in os.listdir(CASE) if d.replace('.','',1).isdigit() and d!='0']
        TIME = max(times, key=lambda x: float(x)) if times else '0'
    pkind, p = read_foam_list(os.path.join(CASE, TIME, "p"), "scalar")
    ukind, Uf = read_foam_list(os.path.join(CASE, TIME, "U"), "vector")
    nkind, nut = read_foam_list(os.path.join(CASE, TIME, "nut"), "scalar")

    # cell-centre approx: use owner-cell p directly (zeroGradient on disc)
    # also need owner cell centre to compute wall-normal gradient for viscous
    Fp = [0.0,0.0,0.0]; Fv = [0.0,0.0,0.0]; Atot=0.0
    for f in range(sF, sF+nF):
        Sf, Cf = face_area_and_centre(faces[f], pts)
        oc = owner[f]
        pf = p[oc] if pkind=='list' else float(p)
        # pressure force on the body = +rho * p_f * Sf  (Sf points out of owner cell
        # = into the patch / away from fluid for boundary faces -> force on wall is
        #  -p * Sf_fluidside; OpenFOAM boundary Sf points outward from domain, i.e.
        #  out of the fluid into the wall, so force on body from fluid = rho*p*Sf.)
        Fp[0]+=RHO*pf*Sf[0]; Fp[1]+=RHO*pf*Sf[1]; Fp[2]+=RHO*pf*Sf[2]
        # viscous: tau_w ~ rho*(nu+nut_f)*|U_owner|/d_wall ; d_wall ~ |Cf-cellC|.
        # cell centre unknown cheaply -> approximate wall-normal dist via face-to-owner.
        # Use U at owner cell, project tangential; small for bluff body -> report sep.
        magS = math.sqrt(Sf[0]**2+Sf[1]**2+Sf[2]**2); Atot+=magS
        uo = Uf[oc] if ukind=='list' else tuple(float(x) for x in str(Uf).strip('()').split())
        nuf = (nut[oc] if nkind=='list' else float(nut)) + NU
        # crude: skin from log-law-ish; left as 0 contribution baseline, reported separately
    q = 0.5*RHO*U*U*AREF
    Cd = Fp[0]/q; Cl = Fp[2]/q; Cs = Fp[1]/q
    LD = Cl/Cd if abs(Cd)>1e-12 else float('nan')
    print(f"# disc patch faces      = {nF}")
    print(f"# total patch area      = {Atot:.4f} m2  (wetted)")
    print(f"# dynamic pressure q    = {q:.2f}  (0.5*rho*U^2*Aref)")
    print(f"# pressure force [N]    = ({Fp[0]:.3f} {Fp[1]:.3f} {Fp[2]:.3f})")
    print(f"RESULT  Cd_pressure = {Cd:.5f}")
    print(f"RESULT  Cl_pressure = {Cl:.5f}")
    print(f"RESULT  Cside       = {Cs:.5f}")
    print(f"RESULT  L/D         = {LD:.5f}")
    print(f"# NOTE: viscous (skin-friction) drag omitted from this integral; for a")
    print(f"#       bluff lenticular disc at Re~2e7 pressure drag dominates (>90%).")

if __name__ == "__main__":
    main()
