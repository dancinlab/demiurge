"""
ganb4se8_family_model.py — bond-bipolaron Tc-ceiling estimate for the GaM4X8
lacunar-spinel cluster-Mott family (RTSC FB-GEOM discovery lane).

Mechanism (sourced):
  GaM4X8 lacunar spinels = cluster-Mott insulators (one unpaired e- in the M4
  cluster molecular t2 orbital, S=1/2). Under pressure they go Mott->metal->SC
  with Tc connected to "a pressure-induced decrease of the MX6 octahedral
  distortion and SIMULTANEOUS SOFTENING OF THE PHONON ASSOCIATED WITH M-X BONDS"
  (Abd-Elmeguid et al; high-P XRD/Raman). A softening BOND phonon that modulates
  the M-X (hence cluster-cluster) hopping = off-diagonal / SSH (Peierls) e-ph —
  exactly the LIGHT-bipolaron escape channel of our closing formula.

  Ge->Ga substitution adds 1 electron to the t2 molecular orbital (n: 1 -> ~1+x),
  filling-controlling AWAY from the half-filled-per-cluster Mott point — the
  doped-Mott high-Tc route (paper: Ga0.9Ge0.2Nb4Se8, onset 45K).

This script:
  (A) estimates the bond-phonon Omega TREND across X (S/Se/Te) and M from M-X
      reduced mass (Omega ~ sqrt(k/mu); lighter X -> higher Omega -> higher Tc
      prefactor),
  (B) runs the validated SSH bond-bipolaron exact-diag solver at family-realistic
      (t/Omega, g/Omega) to get the pair mass enhancement m**/mf and Tc/Omega,
  (C) multiplies Tc/Omega (dimensionless, mechanism) by the X-dependent Omega
      (meV) to get an absolute Tc CEILING per family member, ANCHORED so the
      best-known empirical point (Ge:GaNb4Se8, 45K) is reproduced — every other
      member is then a RELATIVE prediction off that anchor (no free overclaim).
"""
import numpy as np, sys, os, json
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                '..', 'bond-bipolaron'))
from solver import bipolaron, tc_over_omega

meV2K = 11.604
masses = {'V': 50.94, 'Nb': 92.91, 'Ta': 180.95, 'Mo': 95.95}
Xm = {'S': 32.06, 'Se': 78.97, 'Te': 127.6}


def omega_bond(M, X, anchor_meV=35.0, anchorM='Nb', anchorX='Se'):
    """M-X stretch bond phonon ~ sqrt(k/mu), k taken roughly transferable.
    Anchor: Nb-Se ~ 35 meV (selenide soft bond phonon, the SC-relevant mode)."""
    mu = lambda m, x: masses[m] * Xm[x] / (masses[m] + Xm[x])
    return anchor_meV * np.sqrt(mu(anchorM, anchorX) / mu(M, X))


print('=' * 74)
print('(A) BOND-PHONON Omega(M-X) trend  [meV]   (Omega ~ sqrt(k/mu), k transferable)')
print('=' * 74)
print(f'  {"M":3s} {"S":>8s} {"Se":>8s} {"Te":>8s}')
omega_tab = {}
for M in ['V', 'Nb', 'Ta', 'Mo']:
    vals = {X: omega_bond(M, X) for X in ['S', 'Se', 'Te']}
    omega_tab[M] = vals
    print(f'  {M:3s} {vals["S"]:8.1f} {vals["Se"]:8.1f} {vals["Te"]:8.1f}')
print('  -> lighter X (S) and lighter M (V,Nb) give the HIGHEST bond Omega.')
print('     Nb-S ~ %.0f meV  vs  Nb-Se ~ %.0f meV  vs  Nb-Te ~ %.0f meV'
      % (omega_tab['Nb']['S'], omega_tab['Nb']['Se'], omega_tab['Nb']['Te']))

# ---------------------------------------------------------------------------
# (B) SSH bond-bipolaron mechanism at family-realistic params.
# Cluster-Mott narrow band: inter-cluster hopping t ~ 30-60 meV, comparable to
# bond Omega ~ 25-50 meV => t/Omega ~ 0.7-1.5 (the LIGHT-bipolaron sweet zone).
# Filling control (Ge doping) puts n slightly off the 1-per-cluster Mott point;
# in the 2-particle solver we probe the dilute-pair (low n) condensation that the
# doped carriers form. g/Omega ~ 1 (moderate, from soft-mode enhanced coupling).
# ---------------------------------------------------------------------------
print()
print('=' * 74)
print('(B) SSH bond-bipolaron solver — family-realistic (t/Om, g/Om) sweep')
print('=' * 74)
print(f'  {"t/Om":>5s} {"g/Om":>5s} {"bind/t":>8s} {"m**/mf":>8s} {"TcBEC/Om":>9s} '
      f'{"|db|/Om":>8s} {"Tc/Om":>7s} bound')
sweep = []
for tt in (0.7, 1.0, 1.3):
    for gg in (0.8, 1.0, 1.2):
        r = bipolaron(6, 8, tt, 1.0, gg, 'ssh')
        tc_bec_O, _ = tc_over_omega(r['mstar_over_m0'], tt, 1.0, n=0.1)
        binding_O = abs(r['binding'])
        bound = bool(r['binding'] < -1e-6)
        tcO = min(tc_bec_O, binding_O) if bound else 0.0
        sweep.append(dict(t=tt, g=gg, bind=r['binding'] / tt,
                          m=r['mstar_over_m0'], tcbec=tc_bec_O,
                          bO=binding_O, tcO=tcO, bound=bound))
        print(f'  {tt:5.1f} {gg:5.1f} {r["binding"]/tt:8.3f} '
              f'{r["mstar_over_m0"]:8.3f} {tc_bec_O:9.3f} {binding_O:8.3f} '
              f'{tcO:7.3f} {bound}')

# pick a representative central operating point (t/Om=1.0, g/Om=1.0) as the
# mechanism's dimensionless Tc/Om for the family.
r0 = bipolaron(6, 8, 1.0, 1.0, 1.0, 'ssh')
tcbec0, _ = tc_over_omega(r0['mstar_over_m0'], 1.0, 1.0, n=0.1)
tcO_mech = min(tcbec0, abs(r0['binding'])) if r0['binding'] < 0 else 0.0
print(f'\n  representative family Tc/Om (t/Om=g/Om=1, n=0.1) = {tcO_mech:.3f}')

# ---------------------------------------------------------------------------
# (C) Absolute Tc ceiling per member: Tc = (Tc/Om) * Omega(M,X), ANCHORED so the
# empirical best (Ge:GaNb4Se8, 45K onset) is reproduced. The anchor folds in all
# the prefactor uncertainty (n, C_BEC, k) so the RELATIVE family trend is the
# honest deliverable.
# ---------------------------------------------------------------------------
print()
print('=' * 74)
print('(C) ABSOLUTE Tc ceiling per member  (anchored to Ge:GaNb4Se8 onset 45K)')
print('=' * 74)
anchor_Tc_K = 45.0
anchor_M, anchor_X = 'Nb', 'Se'
# absolute scale s.t. Tc(anchor) = (Tc/Om)_mech * Omega(anchor) * SCALE = 45 K
Om_anchor_K = omega_tab[anchor_M][anchor_X] * meV2K   # Omega(Nb-Se) in Kelvin
SCALE = anchor_Tc_K / (tcO_mech * Om_anchor_K)
print(f'  anchor: Ge:GaNb4Se8  Omega(Nb-Se)={omega_tab[anchor_M][anchor_X]:.1f} meV, '
      f'Tc/Om_mech={tcO_mech:.3f}, SCALE={SCALE:.3f}')
print(f'  Tc_member = Tc/Om_mech * Omega(M,X)[K] * SCALE   (relative to 45K anchor)')
print()
print(f'  {"member":<14s}{"Omega meV":>10s}{"Tc_ceiling_K":>14s}   note')
rows = []
# Family members; "viable" = does it superconduct / can it be filling-doped?
members = [
    ('Ge:GaNb4S8',  'Nb', 'S',  'lighter X (sulfide): higher Omega, SAME mechanism'),
    ('Ge:GaNb4Se8', 'Nb', 'Se', 'EMPIRICAL ANCHOR (onset 45K, single batch)'),
    ('Ge:GaNb4Te8', 'Nb', 'Te', 'heavier X: lower Omega'),
    ('Ge:GaV4S8',   'V',  'S',  'lightest M+X: highest Omega BUT V4 magnetic/JT'),
    ('Ge:GaV4Se8',  'V',  'Se', 'V magnetic competition'),
    ('Ge:GaTa4Se8', 'Ta', 'Se', 'heavy M (5d): strong SOC, lower Omega'),
    ('Ge:GaTa4S8',  'Ta', 'S',  '5d + sulfide'),
]
for name, M, X, note in members:
    OmK = omega_tab[M][X] * meV2K
    Tc = tcO_mech * OmK * SCALE
    rows.append(dict(member=name, M=M, X=X, omega_meV=omega_tab[M][X],
                     Tc_ceiling_K=Tc, note=note))
    print(f'  {name:<14s}{omega_tab[M][X]:10.1f}{Tc:14.1f}   {note}')

best = max((r for r in rows if 'magnetic' not in r['note'] and 'JT' not in r['note']),
           key=lambda r: r['Tc_ceiling_K'])
print()
print(f'  BEST non-magnetic lever: {best["member"]}  ->  Tc_ceiling ~ {best["Tc_ceiling_K"]:.0f} K')
print(f'  (sulfide-substituted Nb cluster: {best["Tc_ceiling_K"]/anchor_Tc_K:.2f}x the 45K Se anchor,'
      f' purely from Omega(Nb-S)/Omega(Nb-Se) = '
      f'{omega_tab["Nb"]["S"]/omega_tab["Nb"]["Se"]:.2f})')

out = dict(omega_table=omega_tab, sweep=sweep, tcO_mech=tcO_mech,
           anchor_Tc_K=anchor_Tc_K, SCALE=SCALE, members=rows,
           best=best)
def jd(x):
    if isinstance(x, (np.floating,)): return float(x)
    if isinstance(x, (np.integer,)): return int(x)
    return str(x)
outp = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                    'ganb4se8_family_results.json')
with open(outp, 'w') as f:
    json.dump(out, f, indent=2, default=jd)
print(f'\n[done] {outp}')
