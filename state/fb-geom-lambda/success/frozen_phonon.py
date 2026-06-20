#!/usr/bin/env python3
"""
frozen_phonon.py — REAL frozen-phonon Omega(M-X breathing) + d t/d u extractor
for GaNb4S8 / GaNb4Se8 lacunar spinels (success-model DFT verification).

The M-X breathing mode = symmetric radial displacement of the 4 INNER X1 atoms
(the Nb-X1 'breathing-active' bonds, d_NbX=2.43 S / 2.56 Se) along their bond to
the Nb4 cluster center.  We:
  (1) generate displaced-geometry SCF inputs at u in {-0.06..+0.06 Ang},
  (2) E(u) parabola  ->  k_eff = d2E/du2  ->  Omega = sqrt(k_eff/mu_breathing),
  (3) (optional) HOMO/cluster-level splitting vs u -> d t / d u  (Peierls).

Run AFTER a converged reference SCF (out/ charge density present).
This script only EMITS inputs + PARSES outputs; the pw.x runs are driven on summer.

mu_breathing: the 4 inner X1 move coherently against the (heavier, ~rigid) Nb4
core, so the effective reduced mass of the symmetric breathing coordinate is
mu ~ m_X (anion-dominated, as the FIR data show).  We report BOTH m_X and the
Nb-X two-body reduced mass so the Omega is bracketed honestly.
"""
import numpy as np, os, sys, re, json

HARTREE2meV = 27211.386
RY2meV      = 13605.693
BOHR        = 0.529177
amu_meV_A   = 9648.5  # hbar^2/(amu*A^2) in meV: hbar^2/(1 amu * 1 A^2) = 4.18e-3 meV... see below

# Omega[meV] = hbar*sqrt(k/mu).  With k in [eV/A^2] and mu in [amu]:
#   Omega[meV] = 1000 * 6.4655e-2 * sqrt(k[eV/A^2]/mu[amu])   (standard const)
# const: hbar*sqrt(eV/(amu*A^2)) = 64.654 meV  (i.e. 1 eV/A^2 over 1 amu -> 64.654 meV)
OMEGA_CONST = 64.654  # meV per sqrt(eV/A^2 / amu)

STRUCT = {
  'GaNb4S8':  dict(a=9.95,  Xmass=32.06,  X='S',  xNb=0.6016, xX1=0.3627, xX2=0.865),
  'GaNb4Se8': dict(a=10.41, Xmass=78.971, X='Se', xNb=0.5988, xX1=0.3599, xX2=0.865),
}
Nbmass = 92.906

# ---- primitive FCC cell, conv->prim conversion (same as deck builder) ----
A_prim = np.array([[-0.5,0,0.5],[0,0.5,0.5],[-0.5,0.5,0]])  # rows in conv-a units
Ainv = np.linalg.inv(A_prim.T)
def conv2prim(fr): return tuple(np.round((Ainv@np.array(fr))%1.0, 8))
def prim_orbit(x): return [tuple(np.array(b)%1.0) for b in
                           [(x,x,x),(x,-x,-x),(-x,x,-x),(-x,-x,x)]]

def breathing_positions(name, u_ang):
    """Return ATOMIC_POSITIONS (crystal, primitive) with inner X1 displaced by
    u_ang Angstrom RADIALLY along each Nb-X1 bond (breathing).  +u = bond stretch."""
    d = STRUCT[name]; a = d['a']
    Nb_conv = prim_orbit(d['xNb'])
    X1_conv = prim_orbit(d['xX1'])
    X2_conv = prim_orbit(d['xX2'])
    # cluster center = centroid of the 4 Nb (in conv frac) -> use (0.5,0.5,0.5)*?
    # The Nb4 tetra centroid for x~0.6 sits near the 4a-shifted center; compute it.
    center = np.mean([np.array(p) for p in Nb_conv], axis=0)
    du_frac = u_ang / a  # fractional displacement magnitude (conv cell)
    rows = [('Ga', conv2prim((0,0,0)))]
    for p in Nb_conv: rows.append(('Nb', conv2prim(p)))
    for p in X1_conv:
        v = np.array(p) - center
        v = v/np.linalg.norm(v)           # outward radial unit (conv frac dir ~ cartesian since cubic)
        pos = np.array(p) + v*du_frac     # +u stretches Nb-X1 outward
        rows.append((d['X'], conv2prim(pos)))
    for p in X2_conv: rows.append((d['X'], conv2prim(p)))
    return rows

def emit_scf(name, u_ang, template_path, out_path):
    """Write an scf input at displacement u from a reference scf.in template."""
    with open(template_path) as f: txt = f.read()
    rows = breathing_positions(name, u_ang)
    block = "ATOMIC_POSITIONS crystal\n"
    for sym, q in rows:
        block += f"  {sym:2s} {q[0]:.8f} {q[1]:.8f} {q[2]:.8f}\n"
    # replace the ATOMIC_POSITIONS ... up to K_POINTS
    txt = re.sub(r"ATOMIC_POSITIONS crystal.*?(?=K_POINTS)", block, txt, flags=re.S)
    # nudge prefix so out/ dirs don't collide (use shared SCF restart actually -> keep prefix)
    with open(out_path,'w') as f: f.write(txt)
    return out_path

def mu_breathing(name):
    d = STRUCT[name]
    m_X = d['Xmass']
    mu_NbX = Nbmass*m_X/(Nbmass+m_X)
    return m_X, mu_NbX

def parse_total_energy(scf_out):
    E = None
    with open(scf_out) as f:
        for line in f:
            if '!' in line and 'total energy' in line:
                m = re.search(r'=\s*(-?\d+\.\d+)\s*Ry', line)
                if m: E = float(m.group(1))*RY2meV  # meV
    return E

def fit_omega(us, Es, name):
    """Es in meV vs us in Angstrom; fit parabola E = E0 + 0.5 k u^2 ; k in meV/A^2
    -> convert to eV/A^2, Omega = OMEGA_CONST*sqrt(k_eVA2/mu)."""
    us=np.array(us); Es=np.array(Es); Es=Es-Es.min()
    c = np.polyfit(us, Es, 2)              # c[0]=0.5k
    k_meV_A2 = 2*c[0]
    k_eV_A2  = k_meV_A2/1000.0
    m_X, mu_NbX = mu_breathing(name)
    # 4 inner X1 move -> the symmetric coordinate normal-mode mass.  Report per-bond mu.
    Om_mX   = OMEGA_CONST*np.sqrt(max(k_eV_A2,0)/m_X)     if k_eV_A2>0 else float('nan')
    Om_muNbX= OMEGA_CONST*np.sqrt(max(k_eV_A2,0)/mu_NbX)  if k_eV_A2>0 else float('nan')
    return dict(name=name, k_eV_A2=k_eV_A2, m_X=m_X, mu_NbX=mu_NbX,
                Omega_mX_meV=Om_mX, Omega_muNbX_meV=Om_muNbX,
                Omega_mX_cm=Om_mX/0.123984, Omega_muNbX_cm=Om_muNbX/0.123984,
                stable=bool(k_eV_A2>0))

if __name__ == '__main__':
    cmd = sys.argv[1] if len(sys.argv)>1 else 'help'
    if cmd == 'emit':
        name = sys.argv[2]; tmpl = sys.argv[3]; outdir = sys.argv[4]
        us = [-0.06,-0.04,-0.02,0.0,0.02,0.04,0.06]
        os.makedirs(outdir, exist_ok=True)
        for u in us:
            tag = f"{u:+.2f}".replace('+','p').replace('-','m').replace('.','')
            emit_scf(name, u, tmpl, os.path.join(outdir, f"u_{tag}.in"))
        print(json.dumps(dict(name=name, us=us, outdir=outdir)))
    elif cmd == 'fit':
        name = sys.argv[2]; outdir = sys.argv[3]
        us=[-0.06,-0.04,-0.02,0.0,0.02,0.04,0.06]; Es=[]; uu=[]
        for u in us:
            tag = f"{u:+.2f}".replace('+','p').replace('-','m').replace('.','')
            p = os.path.join(outdir, f"u_{tag}.out")
            if os.path.exists(p):
                E = parse_total_energy(p)
                if E is not None: uu.append(u); Es.append(E)
        if len(uu)>=3:
            res = fit_omega(uu, Es, name)
            res['n_points']=len(uu); res['us']=uu; res['E_meV']=list(np.array(Es)-min(Es))
            print(json.dumps(res, indent=2))
        else:
            print(json.dumps(dict(error='insufficient points', got=len(uu))))
    else:
        print(__doc__)
