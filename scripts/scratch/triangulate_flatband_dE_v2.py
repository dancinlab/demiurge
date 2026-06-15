#!/usr/bin/env python3
"""
RTSC flat-band triangulation v2 — data-driven ΔE alignment.

Uses the MEASURED flat-band offsets (ΔE = E_flat − E_F) accumulated this
session to triangulate which composition / electron-doping lands the kagome
flat band AT E_F (|ΔE| < 0.10 eV) WITHOUT waking competing magnetism.

All ΔE values are REAL DFT measurements (QE), not fabricated (c9).
HONEST CAVEAT: the rigid-band slope is fit from only the two same-structure
CoSn-type points (CoSn, MoSn) crossing 3d↔4d — small-N, direction-robust but
magnitude approximate. Cross-lattice points (CsV3Sb5, RbOs2O6) are shown for
context, NOT used in the same-structure slope.
"""

# ── measured data points (real QE DFT, this campaign) ───────────────────────
# material : (lattice, TM, nominal TM d-count, ΔE_flatband_eV, magnetic?, source)
MEASURED = {
    "CoSn":    ("kagome CoSn-type", "Co", 7, -0.44, True,  "anima/RTSC_14 QE"),
    "MoSn":    ("kagome CoSn-type", "Mo", 5, -2.38, False, "mosn gatecheck (vast 41056723)"),
    "CsV3Sb5": ("kagome",          "V",  3, +0.92, False, "anima QE (context, diff lattice)"),
    "RbOs2O6": ("pyrochlore",      "Os", 6,  0.00, True,  "anima QE (context, diff lattice)"),
}

# ── same-structure rigid-band slope (CoSn-type only: CoSn vs MoSn) ──────────
# d-electron count is a proxy for band filling within the SAME CoSn-type frame.
co = MEASURED["CoSn"]; mo = MEASURED["MoSn"]
d_Co, dE_Co = co[2], co[3]
d_Mo, dE_Mo = mo[2], mo[3]
# slope = dΔE / d(electron count)  [eV per added d-electron, rigid-band proxy]
slope = (dE_Co - dE_Mo) / (d_Co - d_Mo)        # (−0.44 − (−2.38)) / (7 − 5)
print("=" * 64)
print("RTSC flat-band triangulation v2 — data-driven ΔE alignment")
print("=" * 64)
print(f"\nSame-structure CoSn-type anchor points (real QE ΔE):")
print(f"  MoSn (Mo 4d^5): ΔE = {dE_Mo:+.2f} eV  (non-magnetic)")
print(f"  CoSn (Co 3d^7): ΔE = {dE_Co:+.2f} eV  (magnetic)")
print(f"  → rigid-band slope ≈ {slope:+.3f} eV per added d-electron (N=2, rough)")

# ── electrons needed to bring each candidate's flat band TO E_F (ΔE→0) ──────
# Starting from CoSn (closest at −0.44), how many electrons to add to reach 0?
need_e_from_CoSn = -dE_Co / slope    # electrons to add to CoSn to reach ΔE=0
print(f"\nFrom CoSn (ΔE=−0.44, the CLOSEST point):")
print(f"  electrons to add for ΔE→0:  ~{need_e_from_CoSn:+.2f} e⁻/f.u. (rigid-band)")
print(f"  → light ELECTRON doping (flat band rises toward E_F as d-fills)")

# ── candidate ranking (data-driven) ─────────────────────────────────────────
# Estimate ΔE for hypothetical CoSn-type variants via rigid-band from CoSn.
# Δ(d-count) vs Co → predicted ΔE = dE_Co + slope*(d_var − 7)
def pred_dE(d_count):
    return dE_Co + slope * (d_count - d_Co)

candidates = [
    # (name, route, est d-count or doping, note on magnetism)
    ("CoSn + e-dope ~0.4e⁻ (CoSn₁₋ₓSbₓ / Co₁₋ₓNiₓSn)", 7.4,
     "closest start; doping may also suppress weak itinerant magnetism — must re-check m"),
    ("NiSn / Co₀.₅Ni₀.₅Sn (Ni 3d⁸)", 8,
     "more d-electrons → flat band may OVERSHOOT above E_F; bracket with CoSn"),
    ("FeSn (Fe 3d⁶)", 6,
     "fewer e → deeper below (worse direction); strong magnet — likely 🔴"),
]
print("\n" + "-" * 64)
print("Triangulated candidate ranking (rigid-band ΔE estimate):")
print("-" * 64)
ranked = []
for name, dcount, note in candidates:
    est = pred_dE(dcount)
    ranked.append((abs(est), name, est, note))
ranked.sort()
for i, (absE, name, est, note) in enumerate(ranked, 1):
    flag = "🟢 near E_F" if absE < 0.3 else ("🟠 marginal" if absE < 0.8 else "🔴 far")
    print(f"  {i}. {name}")
    print(f"     est ΔE ≈ {est:+.2f} eV  {flag}")
    print(f"     {note}")

print("\n" + "=" * 64)
print("TRIANGULATION VERDICT (honest, c9):")
print("=" * 64)
print("""\
• Direction is ROBUST: within CoSn-type kagome, MORE d-electrons → flat band
  rises toward E_F. CoSn (−0.44 eV) is the closest realized point.
• Top data-driven lead: ELECTRON-DOPED CoSn (~0.4 e⁻/f.u.) — smallest
  correction, and the doping is the SAME knob that may quench CoSn's weak
  itinerant magnetism (the original CoSn blocker). Two-birds.
• This REPLACES blind new-material search with a targeted dial on a material
  we already have decks/engine for (CoSn deck exists).
• Pre-registered gate (unchanged): |ΔE|<0.10 eV AND m<0.5 μB → 🟢 DFPT promote.
• CAVEAT: slope from N=2 same-structure points; magnitude approximate, so the
  exact doping x needs a real scf+bands doping scan (rigid-band is the guide,
  not the answer). NOT a closed result — a next-experiment design.
""")
