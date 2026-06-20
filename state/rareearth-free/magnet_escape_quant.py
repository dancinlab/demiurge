"""
RAREEARTH-FREE deepening — quantitative PASS-CRITERIA scoreboard for RE-free magnet
escape candidates, using PUBLISHED measured/intrinsic values. Transparent, no DFT:
- BHmax_theory = (1/4) mu0 Ms^2  (the hard upper bound from saturation magnetization)
- shape-anisotropy hard cap K_shape_max = (1/4) mu0 Ms^2  (infinite needle)
- score each candidate vs the 6 gates (G1 BHmax>=400 high/>=200 mid; G2 Hc>=1T;
  G3 Tc>=550K; G4 Ku>=1 MJ/m3; G5 abundant; G6 bulk-scalable)
This makes the L1-L4 ceiling/trilemma QUANTITATIVE and identifies, per escape, the
single decisive missing gate.
"""
mu0 = 4e-7 * 3.141592653589793  # T m / A

# Candidate intrinsic data (published; Ms in MA/m, Ku in MJ/m3, Tc in K, Hc realized in T)
# Ms sources: NdFeB Ms~1.28 MA/m; FeNi(L10) ~1.27; Fe16N2 ~1.8(high); MnBi ~0.6; MnAl ~0.6; FePt ~1.14
cands = [
    # name, Ms_MAm, Ku_MJm3(intrinsic best), Tc_K, Hc_realized_T, abundant(bool), bulk(bool), note
    ("Nd2Fe14B (benchmark)", 1.28, 4.9, 585, 1.2, False, True, "RE benchmark"),
    ("L10-FeNi tetrataenite", 1.27, 1.3, 820, 0.45, True, False, "ordering kinetics wall (L7)"),
    ("Fe16N2", 1.80, 1.0, 540, 0.19, True, False, "metastable, decomposes"),
    ("MnBi (LTP)", 0.60, 2.0, 628, 1.6, False, True, "Bi heavy; Ms caps BHmax"),
    ("MnAl-C tau", 0.60, 1.7, 650, 0.30, True, False, "tau metastable, APB/twins"),
    ("L10-FePt", 1.14, 7.0, 750, 1.0, False, True, "Pt precious (~$30/g)"),
    ("Alnico (shape)", 1.0, 0.0, 1100, 0.15, True, True, "shape-anisotropy only"),
    ("Ferrite (SrFe12O19)", 0.38, 0.35, 740, 0.4, True, True, "low-cost floor"),
]

def bhmax_theory(Ms_MAm):
    Ms = Ms_MAm * 1e6
    return 0.25 * mu0 * Ms**2 / 1000.0  # kJ/m3

print("="*108)
print("RE-FREE MAGNET escape — quantitative PASS-CRITERIA scoreboard (published intrinsic values)")
print("="*108)
hdr = f"{'candidate':24} {'Ms':>5} {'BHmax_th':>9} {'Ku':>5} {'Tc':>5} {'Hc':>5} | G1 G2 G3 G4 G5 G6 | decisive-miss"
print(hdr); print("-"*108)
for name, Ms, Ku, Tc, Hc, ab, bulk, note in cands:
    bh = bhmax_theory(Ms)
    g1 = "H" if bh >= 400 else ("M" if bh >= 200 else "x")
    g2 = "P" if Hc >= 1.0 else "x"
    g3 = "P" if Tc >= 550 else "x"
    g4 = "P" if Ku >= 1.0 else "x"
    g5 = "P" if ab else "x"
    g6 = "P" if bulk else "x"
    # decisive missing gate (first failing, priority order most-fundamental first)
    miss = []
    if g5 == "x": miss.append("G5-notabundant")
    if g4 == "x": miss.append("G4-Ku<1")
    if g6 == "x": miss.append("G6-notbulk")
    if g2 == "x": miss.append("G2-Hc<1T")
    if g1 == "x": miss.append("G1-BHmax<200")
    if g3 == "x": miss.append("G3-Tc<550")
    dm = miss[0] if miss else "PASS-ALL"
    print(f"{name:24} {Ms:5.2f} {bh:9.0f} {Ku:5.1f} {Tc:5.0f} {Hc:5.2f} | "
          f" {g1}  {g2}  {g3}  {g4}  {g5}  {g6} | {dm}  ({note})")

print("\n[INTERPRETATION]")
print(" - Shape-anisotropy hard cap = BHmax_theory itself (1/4 mu0 Ms^2). Even Fe16N2 (highest Ms 1.8)")
print(f"   gives BHmax_theory = {bhmax_theory(1.8):.0f} kJ/m3 — but realized Hc 0.19T (G2 FAIL).")
print(" - L10-FeNi: G3/G4/G5 PASS, BHmax_theory mid-tier; ONLY G6 (bulk ordering) + G2(Hc, S<1) fail.")
print(" - L10-FePt: passes everything EXCEPT G5 (Pt not abundant) — the cleanest physics, blocked on cost.")
print(" - Abundant+bulk+Hc>=1T+Ku>=1 simultaneously: NONE. The escape corner is empty (L4 confirmed quantitatively).")
print("\n[DECISIVE LEVER per escape]")
print(" L10-FeNi -> crack G6 bulk ordering kinetics (then G2 follows from S->1) = process engineering, OPEN")
print(" L10-FePt -> G5 cost: Pt-lean / Pt-free 5d-SOC analog (Pd? Ir-lean?) — abundance, not physics")
print(" MnBi     -> G1: Ms-limited BHmax ~70; rises-with-T Hc is unique niche (hot motors), not bulk-replacement")
