#!/usr/bin/env python3
"""
RTSC flat-band candidate GENERATOR via graph topology (not chemistry guessing).

KEY INSIGHT (cross-domain isomorphism): a flat (dispersionless) electronic band
is NOT a material property — it is a property of the LATTICE GRAPH. Two exact
linear-algebra theorems generate flat bands, and the SAME math recurs in
photonics / cold atoms / LC circuits / mechanical metamaterials / Hueckel MO
theory of organic polyradicals. So we can ENUMERATE flat-band hosts by theorem
instead of guessing chemistries (the lesson the CeCo3B2 sweep stumbled onto).

THEOREM 1 — Line-graph flat bands:
  The line graph L(G) of any graph G has a flat band at energy -2 (tight-binding,
  adjacency spectrum). Its compact localized states (CLS) live on the loops of G.
  -> kagome = L(honeycomb); pyrochlore = L(diamond); checkerboard = L(square).

THEOREM 2 — Bipartite sublattice-imbalance (Lieb / Sutherland):
  A bipartite lattice with sublattice site counts N_A != N_B has exactly
  |N_A - N_B| flat zero-energy bands. Same theorem = Hueckel non-bonding MOs of
  odd alternant hydrocarbons, graphene zigzag-edge states, triangulene radicals.
  -> Lieb lattice (3 sites, 2:1) ; dice/T3 lattice ; decorated-square nets.

This file is an ANALYTIC enumeration (no DFT) — it ranks flat-band-guaranteed
lattices and notes a known realized chemistry for each, so the campaign can pick
the next gate-checks by topology. dE/m still require a real QE gate-check (c9);
nothing here is a closed prediction.
"""

# lattice : (theorem, flat-band mechanism, a known/candidate realization, campaign status)
LATTICES = {
    "kagome": (
        "line graph of honeycomb",
        "CLS on hexagon loops; flat band at -2t",
        "CoSn-type (CoSn, MoSn) AND CeCo3B2-type (LaRu3Si2, LaOs3Si2, LaRh3Si2)",
        "ACTIVE WINNERS: LaRu3Si2 dE=-0.055 / LaOs3Si2 dE=+0.039 (both d7, non-mag, GREEN)",
    ),
    "pyrochlore": (
        "line graph of diamond (3D)",
        "CLS on tetrahedron loops; flat band",
        "beta-pyrochlore osmates RbOs2O6 / CsOs2O6 / KOs2O6",
        "TESTED: RbOs2O6 dE~0 (theorem held!) but MAGNETIC -> 🔴 on the magnetism axis, not flatband",
    ),
    "checkerboard": (
        "line graph of square (2D pyrochlore analog)",
        "CLS on square plaquettes; flat band",
        "planar d-electron oxides / designed 2D nets; some MOF planes",
        "UNTESTED — 2D cousin of kagome; same d7 non-magnetic filter should apply",
    ),
    "Lieb": (
        "bipartite imbalance 2:1 (CuO2-type)",
        "1 zero-energy flat band at sublattice imbalance",
        "CuO2 planes of cuprate HTS!; designed Lieb optical/photonic lattices",
        "UNTESTED + HIGH INTEREST — topologically the cuprate plane; bridges flat-band track to HTS",
    ),
    "dice_T3": (
        "bipartite imbalance (3-site, hub+rim)",
        "flat band + Dirac cones (alpha-T3 family)",
        "trilayer oxide / cold-atom realizations; some intermetallic nets",
        "UNTESTED — flat band + Dirac may give unusual N(E_F)",
    ),
}

print("=" * 74)
print("RTSC flat-band candidate generator — by GRAPH TOPOLOGY (theorem, not guess)")
print("=" * 74)
for name, (thm, mech, real, status) in LATTICES.items():
    print(f"\n[{name}]")
    print(f"  theorem     : {thm}")
    print(f"  flat-band   : {mech}")
    print(f"  realization : {real}")
    print(f"  campaign    : {status}")

print("\n" + "=" * 74)
print("CROSS-DOMAIN ISOMORPHISM (same eigenproblem, different field):")
print("=" * 74)
print("""\
  - photonics / cold atoms / LC circuits / mechanical metamaterials:
      flat-band localization = the SAME adjacency-matrix CLS (material-free).
  - chemistry (Hueckel MO): non-bonding orbitals of odd alternant hydrocarbons
      = bipartite zero modes = THEOREM 2 (triangulene, zigzag graphene edges).
  - so a flat band confirmed in ANY of these analogs is the SAME linear algebra;
    cross-checks are legitimate (not analogy hand-waving).

ACTIONABLE BRIDGES for the campaign:
  1) Lieb lattice <-> cuprate CuO2 plane: the flat-band track and conventional
     high-Tc cuprates meet at ONE graph. A non-magnetic d-count that lands the
     Lieb flat band at E_F is the highest-value untested topology.
  2) checkerboard: 2D kagome cousin; reuse the d7 non-magnetic filter.
  3) RbOs2O6 retrospect: the pyrochlore THEOREM was correct (dE~0); it failed on
     the magnetism axis only -> topology generator works; magnetism is a separate
     orthogonal screen, exactly as the CeCo3B2 d7 winners also had to pass.

VERDICT: flat-band-at-E_F search = a GRAPH-TOPOLOGY search (line graphs +
bipartite imbalance) gated by TWO orthogonal physics screens (dE~0 AND
non-magnetic). The chemistry is just which compound realizes the graph.
""")
