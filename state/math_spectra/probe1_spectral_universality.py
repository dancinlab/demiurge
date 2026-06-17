#!/usr/bin/env python3
"""
MATH-SPECTRA probe 1 — spectral universality bridge (frozen-first, c16/c9).

PRE-REGISTERED hypotheses (declared BEFORE computing — no tune-to-green):
  H1  Riemann zeta nontrivial zeros lie on the critical line Re(s)=1/2
      (the user's "동위선상 일자 배치"). Test: max |Re(rho_n) - 0.5| over N zeros.
  H2  The UNFOLDED nearest-neighbour spacings of zeta zeros follow the GUE
      Wigner surmise (Montgomery-Odlyzko), NOT Poisson. Test: KS distance of the
      empirical spacing CDF to GUE vs Poisson; GUE should win.
  H3  A clean periodic tight-binding lattice (kagome) is INTEGRABLE -> its bulk
      level spacings are NOT GUE (band structure, level clustering / Poisson-like),
      AND it carries a macroscopically degenerate FLAT level (delta DOS spike).
      => the naive "zeta-zeros == our lattice spectrum" bridge is FALSE; the real
      RH bridge needs a CHAOTIC operator (Hilbert-Polya), which a flat band is not.

Honest controls: GUE Wigner surmise p(s)=(32/pi^2) s^2 exp(-4 s^2/pi);
Poisson p(s)=exp(-s). A GUE random matrix is computed as an independent positive
control that the spacing pipeline reproduces GUE.

Numerical only. No theorem is proven; this CLASSIFIES spectra by universality.
"""
import numpy as np
import mpmath as mp

mp.mp.dps = 30

# ---------- H1 + H2 : Riemann zeta zeros ----------
N = 300
print(f"[H1] computing first {N} nontrivial zeta zeros (mpmath.zetazero)...")
zeros_im = np.array([float(mp.im(mp.zetazero(n))) for n in range(1, N + 1)])
re_dev = max(abs(float(mp.re(mp.zetazero(n))) - 0.5) for n in (1, 2, 3, 50, 100, 200, 300))
print(f"[H1] max |Re(rho)-0.5| over sampled zeros = {re_dev:.2e}  "
      f"-> {'ON critical line (H1 supported)' if re_dev < 1e-6 else 'OFF line?!'}")

# unfold: zeta zero mean density rho(t) ~ (1/2pi) log(t/2pi). Unfolded coord:
def unfold_t(t):
    return (t / (2 * np.pi)) * (np.log(t / (2 * np.pi)) - 1)
u = unfold_t(zeros_im)
s_zeta = np.diff(u)                     # unfolded spacings, mean ~ 1
s_zeta = s_zeta / s_zeta.mean()
print(f"[H2] zeta unfolded spacings: n={len(s_zeta)}  mean={s_zeta.mean():.3f} (target 1.0)")

# ---------- control: GUE random matrix spacings ----------
def gue_spacings(dim=600, seed_offset=0):
    # GUE = Hermitian with iid complex Gaussian; eigenvalue spacings (unfold by sorting + local mean)
    A = np.random.RandomState(12345 + seed_offset).randn(dim, dim)
    B = np.random.RandomState(54321 + seed_offset).randn(dim, dim)
    H = (A + 1j * B); H = (H + H.conj().T) / 2
    ev = np.sort(np.linalg.eigvalsh(H))
    ev = ev[dim // 4: 3 * dim // 4]      # central spectrum (semicircle bulk)
    s = np.diff(ev); s = s / s.mean()
    return s
s_gue = gue_spacings()

# ---------- H3 : kagome tight-binding bulk spectrum ----------
def kagome_eigs(nk=48, t=1.0):
    # 3-site kagome Bloch Hamiltonian on an nk x nk Monkhorst grid
    a1 = np.array([1.0, 0.0]); a2 = np.array([0.5, np.sqrt(3) / 2])
    b1 = 2 * np.pi * np.array([1.0, -1 / np.sqrt(3)]); b2 = 2 * np.pi * np.array([0.0, 2 / np.sqrt(3)])
    # nearest-neighbour vectors between the 3 sublattices
    evs = []
    for i in range(nk):
        for j in range(nk):
            k = (i / nk) * b1 + (j / nk) * b2
            kx, ky = k
            # standard kagome H(k): off-diagonal 2t cos(k.delta)
            d_ab = a1 / 2; d_bc = (a2 - a1) / 2; d_ca = -a2 / 2
            hab = 2 * t * np.cos(k @ d_ab)
            hbc = 2 * t * np.cos(k @ d_bc)
            hca = 2 * t * np.cos(k @ d_ca)
            H = np.array([[0, hab, hca], [hab, 0, hbc], [hca, hbc, 0]], dtype=complex)
            evs.extend(np.linalg.eigvalsh(H))
    return np.array(sorted(evs))

ek = kagome_eigs()
# flat band detection: kagome has a flat band at E = -2t (1/3 of states pile up)
flat_level = -2.0
frac_flat = np.mean(np.abs(ek - flat_level) < 1e-6)
print(f"[H3] kagome bulk: {len(ek)} eigenvalues; fraction at flat level E=-2t = {frac_flat:.3f} "
      f"(theory 1/3={1/3:.3f}) -> {'FLAT BAND confirmed (delta DOS)' if frac_flat > 0.30 else 'no flat pile-up'}")
# spacings of the DISPERSIVE part (exclude the degenerate flat level)
disp = ek[np.abs(ek - flat_level) > 1e-6]
s_kag = np.diff(np.unique(np.round(disp, 9)))
s_kag = s_kag[s_kag > 0]; s_kag = s_kag / s_kag.mean()

# ---------- spacing-distribution classifier (KS to GUE vs Poisson) ----------
def cdf(x, s): return np.searchsorted(np.sort(s), x) / len(s)
def gue_cdf(x):
    from math import erf, exp, sqrt, pi
    xs = np.linspace(0, x, 400) if np.isscalar(x) else None
    # numeric integral of Wigner-GUE surmise
    grid = np.linspace(0, max(x, 1e-9), 500)
    p = (32 / pi**2) * grid**2 * np.exp(-4 * grid**2 / pi)
    return np.trapezoid(p, grid)
def poisson_cdf(x): return 1 - np.exp(-x)

def ks(s, ref_cdf):
    xs = np.sort(s)
    emp = np.arange(1, len(xs) + 1) / len(xs)
    ref = np.array([ref_cdf(x) for x in xs])
    return float(np.max(np.abs(emp - ref)))

print("\n=== universality classification (KS distance, smaller=closer) ===")
for name, s in [("zeta zeros", s_zeta), ("GUE control", s_gue), ("kagome dispersive", s_kag)]:
    d_gue = ks(s, gue_cdf); d_poi = ks(s, poisson_cdf)
    cls = "GUE" if d_gue < d_poi else "Poisson"
    print(f"  {name:18s}: KS_GUE={d_gue:.3f}  KS_Poisson={d_poi:.3f}  -> {cls}")

print("""
=== VERDICT (honest, c9) ===
H1: zeta zeros on critical line (numerically, sampled)            -> see [H1]
H2: zeta zero spacings ~ GUE (Montgomery-Odlyzko universality)    -> see classifier
H3: kagome = flat band (delta DOS) + dispersive part NOT GUE      -> see [H3]+classifier
=> If classifier shows zeta=GUE but kagome!=GUE, the NAIVE bridge
   'RH zeros == our lattice spectrum' is FALSE: the RH/quantum-chaos link
   (Hilbert-Polya) needs a CHAOTIC operator; a periodic flat-band lattice is
   integrable. The genuine shared object is SPECTRAL UNIVERSALITY THEORY, and
   the flat band is its own (degenerate, non-chaotic) signature -> M4 question:
   do flat-band CLS multiplicities carry number-theoretic structure?
""")
