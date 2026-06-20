"""
altmodel_solver.py — run the bond-SSH (off-diagonal/Peierls) bipolaron solver on
the TOP alternative success-model candidates vs the GaNb4S8 anchor.

Reuses bond-bipolaron/solver.py (exact-diag SSH bipolaron). Each candidate is
mapped to the dimensionless SSH triple (t/Ω, g/Ω, Ω_meV):

  Ω_meV  = the OFF-DIAGONAL (bond-modulating) phonon energy
             - σ-bond class (MgB2/LiBC): the B-B / B-C bond-stretch E2g mode
             - Chevrel: the intermolecular Mo6-cluster Peierls mode (11-17 meV)
             - A15: the soft Nb-Nb chain bond mode
             - GaNb4S8: the Nb4-cluster molecular-orbital bond mode (anchor)
  t/Ω    = (cluster/band hopping)/(Ω). Light, dispersive σ bands → t/Ω ~ 1-2 (mobile
             pair regime); flat cluster bands → t/Ω < 1.
  g/Ω    = off-diagonal coupling strength. We probe the converged g/Ω≈1.0 regime
             (the validated bond-bipolaron operating point) and also g/Ω from each
             material's λ where a published λ_σ exists (g/Ω ~ sqrt(λ·Ω/(N·t)) scale,
             taken ~1.0-1.5 for the strong σ couplers MgB2/LiBC).

This is a RELATIVE ranking off the published light-SSH anchor (Tc/Ω=0.1 at the
anchor point), NOT a from-scratch DFT Tc. Honest (d6): solver gives Tc/Ω; the
Tc_K scale is set by Ω_meV, so a HIGH-Ω light-bond material wins on Ω alone.
"""
import sys, os, json
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'bond-bipolaron'))
from solver import bipolaron, tc_over_omega   # noqa: E402
import numpy as np                            # noqa: E402

meV2K = 11.604

# (name, t/Ω, g/Ω, Ω_meV, note)
# Ω chosen as the OFF-DIAGONAL bond-modulating phonon energy of each family.
CANDS = [
    # --- ANCHOR: the verified success model -------------------------------
    ("Ge:GaNb4S8 (anchor)", 0.5, 1.0, 22.0,
     "Nb4-cluster MO bond mode; flat cluster band t/Ω<1; ~60K bond-Peierls projection"),

    # --- σ-bond-stretch class (LIGHT bond, HIGH Ω) ------------------------
    ("LiBC (hole-doped)",   1.6, 1.2, 78.0,
     "B-C sigma bond-stretch E2g; predicted Tc=65K (Rosner-Pickett); lighter than MgB2 -> higher Ω"),
    ("MgB2 (sigma band)",   1.5, 1.1, 70.0,
     "B-B bond-stretch E2g 70meV; measured Tc=40K; λ_σ≈0.87; off-diagonal bond-stretch"),

    # --- A15 bond-stretch -------------------------------------------------
    ("Nb3Ge (A15)",         1.0, 1.3, 20.0,
     "soft Nb-Nb chain bond mode; measured Tc=23K; λ=1.83; off-diagonal chain dimerization"),

    # --- Chevrel cluster Peierls -----------------------------------------
    ("PbMo6S8 (Chevrel)",   0.6, 1.1, 14.0,
     "intermolecular Mo6 Peierls mode 11-17meV; measured Tc~15K; explicit Peierls character"),

    # --- spinel breathing -------------------------------------------------
    ("LiTi2O4 (spinel)",    0.7, 1.0, 40.0,
     "Ti-O breathing/bond mode; measured Tc=13K; polaronic; partly on-site (Holstein-leaning)"),

    # --- β-pyrochlore rattling (CONTROL: rattling is ON-SITE, not bond) ---
    ("KOs2O6 (pyrochlore)", 0.8, 1.0, 7.0,
     "K rattling anharmonic mode ~7meV; Tc=9.6K; rattling is ON-SITE (Holstein-like), NOT off-diagonal"),
]

L, Nb, n = 6, 8, 0.1
rows = []
print("="*120)
print("ALTERNATIVE SUCCESS-MODEL bond-SSH bipolaron scan  (L=%d Nb=%d n=%.2f, off-diagonal SSH coupling)" % (L, Nb, n))
print("="*120)
print(f"{'candidate':<24}{'t/Ω':>5}{'g/Ω':>5}{'Ω meV':>7}{'bind/t':>8}{'m**/mf':>8}{'TcBEC/Ω':>9}{'|Δb|/Ω':>8}{'Tc/Ω':>7}{'Tc_K':>8}  bound")
for name, tO, gO, Om, note in CANDS:
    r = bipolaron(L, Nb, tO, 1.0, gO, 'ssh')
    tc_bec_O, _ = tc_over_omega(r['mstar_over_m0'], tO, 1.0, n=n)
    binding_O = abs(r['binding'])
    bound = bool(r['binding'] < -1e-6)
    tcO = min(tc_bec_O, binding_O) if bound else 0.0
    Tc_K = tcO * Om * meV2K
    rows.append(dict(name=name, t_over_O=tO, g_over_O=gO, Omega_meV=Om,
                     binding_over_t=r['binding']/tO, mstar=r['mstar_over_m0'],
                     tc_bec_over_O=tc_bec_O, binding_over_O=binding_O,
                     tc_over_O=tcO, Tc_K=Tc_K, bound=bound, note=note))
    print(f"{name:<24}{tO:>5.1f}{gO:>5.1f}{Om:>7.1f}{r['binding']/tO:>8.3f}{r['mstar_over_m0']:>8.3f}"
          f"{tc_bec_O:>9.3f}{binding_O:>8.3f}{tcO:>7.3f}{Tc_K:>8.1f}  {bound}")

# rank by Tc_K among bound, compact candidates
ranked = sorted([x for x in rows if x['bound']], key=lambda x: -x['Tc_K'])
print("\nRANK (by solver Tc_K, bound pairs):")
for i, x in enumerate(ranked, 1):
    print(f"  {i}. {x['name']:<24} Tc≈{x['Tc_K']:6.1f} K   (Ω={x['Omega_meV']:.0f}meV, m**/mf={x['mstar']:.2f}, Tc/Ω={x['tc_over_O']:.3f})")

outp = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'altmodel_solver_results.json')
def jd(x):
    if isinstance(x, (np.floating,)): v=float(x); return v if np.isfinite(v) else None
    if isinstance(x, (np.integer,)): return int(x)
    if isinstance(x, float) and not np.isfinite(x): return None
    return None
with open(outp, 'w') as f:
    json.dump(rows, f, indent=2, default=jd)
print(f"\n[done] {outp}")
