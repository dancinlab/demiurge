"""
공식으로 발견 — apply the closing-formula Regime-II light-bipolaron Tc estimate to the
3 converged candidates, using PUBLISHED band/phonon parameters. Transparent order-of-magnitude
estimate (NOT a QMC bipolaron solve — that is the campaign's step 4). d6: this ranks the
candidates by the formula; absolute Tc needs the QMC mass.

Regime-II scaling (bond-SSH light bipolaron, PRX 13,011010 / arXiv:2210.14236):
  - the bipolaron is LIGHT iff dimensionless coupling λ_ssh = α²/(K·t) is moderate AND t/Ω ~ 1-2
  - lattice-BEC condensation: kB·Tc ≈ C_BEC · (ħ²/m**) · n^(2/3),  with n = pair density
  - in tight-binding units the PRX result compresses to  Tc/Ω ≈ f(t/Ω, λ_ssh) with a broad
    optimum Tc/Ω ~ 0.1-0.3 near t/Ω~1, dropping fast for t/Ω«1 (heavy) or λ_ssh large (heavy).
We use the published-parameter proxy:  Tc ≈ η · Ω · g(t/Ω),  η∈[0.1,0.3] (PRX band),
  g(x) = x/(1+x²) normalized to peak 0.5 at x=1 (light-window envelope; 0 at x→0 heavy, decays x»1).
This is an ENVELOPE/UPPER-bound-ish estimate, explicitly bracketed.
"""
import numpy as np

def g_window(x):              # light-bipolaron window envelope, peak at t/Ω=1
    return (x/(1+x*x))/0.5    # normalized so g(1)=1

# candidate params (published / estimated). Ω = dominant bond-Peierls phonon (meV); t = hopping (meV)
# Tc_meV → Tc_K via 1 meV = 11.604 K
meV2K = 11.604
cands = [
    # name, t (meV), Omega (meV), note/source
    ("Re6Se8Cl2 (superatomic, narrow band)", 90.0, 10.7, "W~300-400meV→t~75-100; 2.6THz cluster-twist=10.7meV; t/Ω~8 (heavy side)"),
    ("sp2C N-Lieb COF (flat band)",          40.0, 80.0, "π-network flat band, narrow t~tens meV; C-C bond phonon ~80meV; t/Ω~0.5"),
    ("graphene Kekule / oSSH",               300.0,160.0, "C-C hopping t~0.3eV; E2g/iTO bond phonon ~0.16eV (1369K budget); t/Ω~1.9"),
    ("MATBG (moire flat)",                   5.0,  16.0, "moire flat band t~few meV; K-pt iTO ~16meV; t/Ω~0.3"),
]
print("="*94)
print("공식으로 발견 — Regime-II light-bipolaron Tc ENVELOPE estimate (η∈[0.1,0.3]·Ω·g(t/Ω))")
print("="*94)
print(f"{'candidate':<40}{'t(meV)':>7}{'Ω(meV)':>7}{'t/Ω':>6}{'g(t/Ω)':>7}{'Tc_K [η0.1–0.3]':>18}")
rows=[]
for name,t,om,note in cands:
    x=t/om; gg=g_window(x)
    tc_lo=0.1*om*gg*meV2K; tc_hi=0.3*om*gg*meV2K
    rows.append((name,x,gg,tc_lo,tc_hi,note))
    print(f"{name:<40}{t:>7.0f}{om:>7.1f}{x:>6.2f}{gg:>7.2f}   {tc_lo:>6.1f} – {tc_hi:<6.1f}")
print("\nnotes:")
for name,x,gg,lo,hi,note in rows:
    print(f"  - {name.split(' (')[0]}: {note}")
print("\nHONEST (d6): envelope estimate from published t,Ω + the light-window g(t/Ω); NOT a QMC")
print("bipolaron-mass solve. Ranks candidates; absolute Tc needs step-4 QMC. The window g(t/Ω)")
print("peaks at t/Ω=1 — graphene-Kekule (t/Ω~1.9) & COF (~0.5) sit IN the light window; Re6Se8Cl2")
print("(t/Ω~8) is on the heavy side (small g) so its Ω advantage is offset → consistent with its")
print("measured ~8K. The recipe-pure light hosts have the higher Tc-ceiling potential.")
