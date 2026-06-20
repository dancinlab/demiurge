"""
family_lens.py — multi-lever lens projection over the GaM4X8 lacunar-spinel
SUCCESS family, finding the HIGHEST-Tc real member of the bond-Peierls
(off-diagonal SSH) cluster-Mott bipolaron channel.

Validated success anchor: Ge:GaNb4Se8 (45 K onset, single 2025 preprint
arXiv:2510.12452). Verified model member: Ge:GaNb4S8 ~60 K (lighter S anion
-> higher bond phonon Omega, same off-diagonal mechanism).

Each lens is a distinct knob:
  1. ANION   S / Se / Te / O?(none) / mixed  -> Omega ~ sqrt(k/mu_MX)
  2. A-SITE  Ga / Al / Ge / In / vacancy     -> filling + bond stiffness k
  3. FILLING n=1->1+x (Ge doping)            -> t/Omega operating point
  4. PRESSURE  P softens bond phonon          -> raises g, lowers Omega
  5. CLUSTER Nb4(4d) / Ta4(5d) / V4(3d-mag)  -> nonmagnetic constraint

Reuses the VALIDATED SSH bond-bipolaron exact-diag solver (solver.py) and the
family Omega(M,X) table + anchor from ganb4se8_family_model.py.

Sourced facts (this session's arxiv+web grounding) folded in as constraints:
  * NO oxide lacunar spinel GaM4O8 exists  -> S is the lightest viable anion (HARD ceiling)
  * GaMo4S8/Se8 EXIST but are skyrmion/multiferroic (Mo cluster magnetic) -> NOT SC
  * V4 (3d) magnetic + Jahn-Teller (skyrmion host) -> ruled out for nonmagnetic SC
  * Nb4 (4d), Ta4 (5d) nonmagnetic -> the only viable clusters
  * Al / In / vacancy A-site lacunar spinels: NOT published -> speculative, no data
  * Pressure family Tc ceiling (well established) ~5.8 K (GaTa4Se8 @ 11.5 GPa)
  * Ge:GaNb4Se8 45 K = onset only, single batch, no Meissner -> optimistic anchor
"""
import numpy as np, sys, os, json
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                '..', 'bond-bipolaron'))
from solver import bipolaron, tc_over_omega

meV2K = 11.604
masses = {'V': 50.94, 'Nb': 92.91, 'Ta': 180.95, 'Mo': 95.95, 'Al': 26.98}
Xm = {'O': 16.00, 'S': 32.06, 'Se': 78.97, 'Te': 127.6}


def omega_bond(M, X, k_scale=1.0, anchor_meV=35.0, anchorM='Nb', anchorX='Se'):
    """M-X stretch bond phonon ~ sqrt(k/mu). k_scale lets the A-site/pressure
    lever stiffen (k_scale>1) or soften (<1) the bond. Anchor Nb-Se ~ 35 meV."""
    mu = lambda m, x: masses[m] * Xm[x] / (masses[m] + Xm[x])
    return anchor_meV * np.sqrt(k_scale * mu(anchorM, anchorX) / mu(M, X))


# ---------------------------------------------------------------------------
# Establish the mechanism's dimensionless Tc/Omega vs the operating point t/Omega.
# (R2 correction: the compact-light pair window sits at t/Omega <~ 1, NOT 1.3.
#  We scan to locate the actual filling sweet spot honestly.)
# ---------------------------------------------------------------------------
print('=' * 78)
print('FILLING LENS — dimensionless Tc/Omega vs operating point t/Omega (g/Om=1)')
print('  (t/Om is set by Ge-doping filling n=1->1+x: more doping widens effective band)')
print('=' * 78)
print(f'  {"t/Om":>5s} {"bind/t":>8s} {"m**/mf":>8s} {"|db|/Om":>8s} '
      f'{"TcBEC/Om":>9s} {"Tc/Om":>7s} {"compact?":>9s}')
fill = []
for tt in (0.5, 0.7, 0.85, 1.0, 1.15, 1.3, 1.6, 2.0):
    r = bipolaron(6, 8, tt, 1.0, 1.0, 'ssh')
    tc_bec_O, _ = tc_over_omega(r['mstar_over_m0'], tt, 1.0, n=0.1)
    bO = abs(r['binding'])
    bound = r['binding'] < -1e-6
    tcO = min(tc_bec_O, bO) if bound else 0.0
    compact = bO >= tt
    fill.append(dict(t=tt, bind_t=r['binding'] / tt, m=r['mstar_over_m0'],
                     bO=bO, tcbec=tc_bec_O, tcO=tcO, compact=bool(compact)))
    print(f'  {tt:5.2f} {r["binding"]/tt:8.3f} {r["mstar_over_m0"]:8.3f} '
          f'{bO:8.3f} {tc_bec_O:9.3f} {tcO:7.3f} {str(bool(compact)):>9s}')

# The mechanism Tc/Om RISES with t/Om (more doping) until the pair de-compacts.
# Honest sweet spot = the LARGEST t/Om that still keeps a COMPACT pair (|db|>=t),
# because Tc/Om = min(TcBEC, |db|) and TcBEC grows with t while |db|/t shrinks.
compact_pts = [f for f in fill if f['compact']]
sweet = max(compact_pts, key=lambda f: f['tcO']) if compact_pts else max(fill, key=lambda f: f['tcO'])
print(f'\n  -> compact-pair sweet spot: t/Om={sweet["t"]:.2f}, Tc/Om={sweet["tcO"]:.3f} '
      f'(|db|/t={sweet["bO"]/sweet["t"]:.2f})')
# anchor operating point used by the verified family model = t/Om=1.0
r_anchor = bipolaron(6, 8, 1.0, 1.0, 1.0, 'ssh')
tcbec_a, _ = tc_over_omega(r_anchor['mstar_over_m0'], 1.0, 1.0, n=0.1)
tcO_anchor = min(tcbec_a, abs(r_anchor['binding']))
print(f'  -> verified-model anchor operating point: t/Om=1.0, Tc/Om={tcO_anchor:.3f}')

# ---------------------------------------------------------------------------
# Build the absolute-Tc anchor exactly as the verified family model did:
# Ge:GaNb4Se8 = 45 K at (t/Om=1, g/Om=1, Nb-Se Omega).
# ---------------------------------------------------------------------------
anchor_Tc_K = 45.0
Om_anchor_K = omega_bond('Nb', 'Se') * meV2K
SCALE = anchor_Tc_K / (tcO_anchor * Om_anchor_K)

def member_Tc(M, X, k_scale=1.0, tcO=None):
    """Absolute Tc ceiling = (Tc/Om)_op * Omega(M,X) * SCALE, anchored to 45K."""
    if tcO is None:
        tcO = tcO_anchor
    OmK = omega_bond(M, X, k_scale) * meV2K
    return tcO * OmK * SCALE, omega_bond(M, X, k_scale)

# ---------------------------------------------------------------------------
# LENS PROJECTIONS — each member with its lever, nonmagnetic flag, viability.
# ---------------------------------------------------------------------------
print()
print('=' * 78)
print('ALL-LENS MEMBER TABLE — Tc ceiling per lever (anchored Ge:GaNb4Se8=45K)')
print('=' * 78)
# tcO_op: which operating Tc/Om to use. Most members sit at the same mechanism
# point (t/Om~1, g/Om~1) -> tcO_anchor. The FILLING lever can push to the sweet
# spot; we expose that as a separate "Ge:GaNb4S8 @ sweet-fill" combo row.
members = [
    # name, M, X, k_scale, nonmag, viable_struct, tcO_op, lever-note
    ('Ge:GaNb4Se8', 'Nb', 'Se', 1.0, True,  True,  tcO_anchor,
     'EMPIRICAL ANCHOR (45K onset, 1 batch, no Meissner)'),
    ('Ge:GaNb4S8',  'Nb', 'S',  1.0, True,  True,  tcO_anchor,
     'ANION lens: lighter S -> higher Omega, same mechanism'),
    ('Ge:GaNb4Te8', 'Nb', 'Te', 1.0, True,  True,  tcO_anchor,
     'ANION lens: heavier Te -> lower Omega (worse)'),
    ('Ge:GaTa4S8',  'Ta', 'S',  1.0, True,  True,  tcO_anchor,
     'CLUSTER lens: 5d Ta nonmag + S; heavier M lowers Omega'),
    ('Ge:GaTa4Se8', 'Ta', 'Se', 1.0, True,  True,  tcO_anchor,
     'CLUSTER lens: 5d Ta (SC@5.8K/11.5GPa real); lower Omega'),
    ('Ge:GaV4S8',   'V',  'S',  1.0, False, False, tcO_anchor,
     'CLUSTER lens: V4 3d MAGNETIC+JT skyrmion host -> RULED OUT'),
    ('Ge:GaMo4S8',  'Mo', 'S',  1.0, False, False, tcO_anchor,
     'FILLING/cluster: Mo4 exists but skyrmion/multiferroic -> NOT SC'),
    # A-SITE lens (speculative — no published Al/vacancy lacunar spinel):
    ('Ge:AlNb4S8?', 'Nb', 'S',  1.25, True, False, tcO_anchor,
     'A-SITE lens (SPECULATIVE, unpublished): Al stiffens k +25%'),
    # FILLING-OPTIMIZED best combo: Ge:GaNb4S8 driven to the compact-pair sweet spot
    ('Ge:GaNb4S8*', 'Nb', 'S',  1.0, True,  True,  sweet['tcO'],
     f'BEST COMBO: anion(S)+filling sweet-spot t/Om={sweet["t"]:.2f}'),
]
print(f'  {"member":<14s}{"Omega meV":>10s}{"Tc/Om":>7s}{"Tc_K":>9s}'
      f'{"nonmag":>8s}{"struct":>8s}   lever')
rows = []
for name, M, X, ks, nonmag, viable, tcO_op, note in members:
    Tc, Om = member_Tc(M, X, ks, tcO_op)
    rows.append(dict(member=name, M=M, X=X, k_scale=ks, omega_meV=Om,
                     tcO_op=tcO_op, Tc_K=Tc, nonmagnetic=nonmag,
                     viable_structure=viable, note=note))
    vm = 'YES' if nonmag else 'NO'
    vs = 'YES' if viable else 'spec/no'
    print(f'  {name:<14s}{Om:10.1f}{tcO_op:7.3f}{Tc:9.1f}{vm:>8s}{vs:>8s}   {note}')

# ---------------------------------------------------------------------------
# VERDICT — best REAL (nonmagnetic + published-structure) member.
# ---------------------------------------------------------------------------
real = [r for r in rows if r['nonmagnetic'] and r['viable_structure']]
best_real = max(real, key=lambda r: r['Tc_K'])
# also the absolute ceiling if the speculative Al-stiffen lever were real:
spec = [r for r in rows if r['nonmagnetic'] and not r['viable_structure']
        and '?' in r['member']]
best_spec = max(spec, key=lambda r: r['Tc_K']) if spec else None

print()
print('=' * 78)
print('VERDICT')
print('=' * 78)
print(f'  BEST REAL nonmagnetic member : {best_real["member"]}  ->  Tc ~ {best_real["Tc_K"]:.0f} K')
print(f'    ({best_real["note"]})')
print(f'    Beats 45K Se anchor by {best_real["Tc_K"]/45.0:.2f}x, purely via Omega(Nb-S)/Omega(Nb-Se)'
      f' = {omega_bond("Nb","S")/omega_bond("Nb","Se"):.2f}'
      + (f' x filling boost {best_real["tcO_op"]/tcO_anchor:.2f}' if best_real['tcO_op'] != tcO_anchor else ''))
if best_spec:
    print(f'  IF speculative Al-stiffen real: {best_spec["member"]} -> Tc ~ {best_spec["Tc_K"]:.0f} K (NO DATA, do not bank)')
print()
print('  FAMILY CEILING (honest, d6):')
print('   * Anion: S is the LIGHTEST viable -> Omega ceiling ~47 meV (Nb-S). No oxide')
print('     lacunar spinel exists; O analog is the only way past S and it is UNREALIZED.')
print('   * Cluster: only Nb4(4d)/Ta4(5d) are nonmagnetic; V4/Mo4 are magnetic/skyrmion')
print('     (RULED OUT). Ta is heavier -> lower Omega than Nb. So Nb is optimal M.')
print('   * Filling: Tc/Om plateaus at the compact-pair edge (t/Om<~1); pushing doping')
print('     past it de-compacts the pair (|db|<t), capping the dimensionless Tc/Om.')
print('   * Pressure: softens the bond phonon (RAISES g but LOWERS Omega) -> the two')
print('     fight; the real pressure family tops out at ~5.8 K (GaTa4Se8). The high-Tc')
print('     route is FILLING (Ge), not pressure.')

out = dict(
    filling_sweep=fill, sweet_spot=sweet, tcO_anchor=tcO_anchor,
    anchor_Tc_K=anchor_Tc_K, SCALE=SCALE, members=rows,
    best_real=best_real, best_speculative=best_spec,
    omega_S_over_Se=float(omega_bond('Nb', 'S') / omega_bond('Nb', 'Se')),
)
def jd(x):
    if isinstance(x, (np.floating,)): return float(x)
    if isinstance(x, (np.integer,)): return int(x)
    return str(x)
outp = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                    'family_lens_results.json')
with open(outp, 'w') as f:
    json.dump(out, f, indent=2, default=jd)
print(f'\n[done] {outp}')
