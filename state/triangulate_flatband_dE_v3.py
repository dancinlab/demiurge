#!/usr/bin/env python3
"""
RTSC flat-band triangulation v3 — TWO-AXIS separation (chemistry/lattice vs doping).

v2 conflated a cross-material substitution slope (CoSn vs MoSn = +0.97 eV per
d-electron) with a rigid-band DOPING dial, and predicted electron-doped CoSn
would reach E_F. Two real QE doping scans this session REFUTED that:

  CoSn electron-doping:  dE = -0.445 -> -0.585 eV   (slope -0.23 eV / e-)
  CoSn hole-doping:      dE = -0.445 -> -0.544 eV   (slope -0.165 eV / hole)

BOTH dials push the flat band DEEPER (away from E_F). So within a fixed cell,
rigid carrier doping is NOT the alignment lever. v3 separates the two axes
using ALL real measured points and asks which axis actually lands dE ~ 0.

All dE are REAL QE DFT measurements (c9). Sibling dE are NOT fabricated — they
are flagged as next-experiments, not predictions (v2's honest-caveat lesson).
"""

# ── measured flat-band offsets (real QE DFT, this campaign) ──────────────────
# name : (lattice family, TM, d-count, dE_eV, m_uB, verdict)
MEASURED = {
    "CsV3Sb5":   ("kagome (V3Sb5)",     "V",  3, +0.92,  0.0,  "🟠 far above E_F"),
    "RbOs2O6":   ("pyrochlore",         "Os", 6,  0.00,  ">0", "🟠 at E_F but MAGNETIC"),
    "CoSn":      ("kagome (CoSn-type)", "Co", 7, -0.44,  0.09, "🔴 below + weak mag"),
    "MoSn":      ("kagome (CoSn-type)", "Mo", 5, -2.38,  0.0,  "🔴 deep below"),
    "LaRu3Si2":  ("kagome (CeCo3B2)",   "Ru", 7, -0.055, 0.00, "🟢 GATE PASS"),
}

# ── axis 1: rigid-band doping (MEASURED slopes, fixed CoSn cell) ─────────────
DOPING = {
    "CoSn e-dope": {"slope_eV_per_carrier": -0.23,  "dir": "deeper", "mag": "quenched (0->0)"},
    "CoSn h-dope": {"slope_eV_per_carrier": -0.165, "dir": "deeper", "mag": "woken (0.09->0.63)"},
}

print("=" * 70)
print("RTSC flat-band triangulation v3 — chemistry/lattice axis vs doping axis")
print("=" * 70)

print("\n[1] MEASURED flat-band offsets (real QE):")
for n, (lat, tm, d, dE, m, v) in MEASURED.items():
    print(f"    {n:10s} {lat:20s} {tm}{d}d  dE={dE:+.3f}  m={str(m):>4}  {v}")

print("\n[2] DOPING axis (rigid carriers in fixed CoSn cell) — MEASURED:")
for n, d in DOPING.items():
    print(f"    {n}: {d['slope_eV_per_carrier']:+.3f} eV/carrier -> band {d['dir']}; mag {d['mag']}")
print("    => VERDICT: doping axis is DEAD. Both dials push dE deeper, NOT to 0.")
print("       To close CoSn's -0.44 gap by e-doping at -0.23 eV/e- would need")
print("       the WRONG sign anyway; |slope| tiny + wrong direction. CLOSED.")

# ── axis 2: chemistry/lattice — the real lever ──────────────────────────────
# Span of dE across realized chemistries = 0.92 - (-2.38) = 3.30 eV.
# Doping moves dE by ~0.1 eV over a full carrier and in the wrong direction.
span_chem = MEASURED["CsV3Sb5"][3] - MEASURED["MoSn"][3]
print(f"\n[3] CHEMISTRY/LATTICE axis span = {span_chem:.2f} eV (CsV3Sb5 .. MoSn)")
print("    vs doping axis ~0.1 eV/carrier (wrong sign). => chemistry/lattice is")
print("    the ONLY effective alignment lever (~30x larger, correct reach).")

# Within chemistry, what lands dE ~ 0 AND non-magnetic?
print("\n[4] dE ~ 0 realized points:")
for n, (lat, tm, d, dE, m, v) in MEASURED.items():
    if abs(dE) < 0.12:
        print(f"    {n}: dE={dE:+.3f} m={m} -> {v}")
print("    => RbOs2O6 hits E_F but is MAGNETIC (fails). LaRu3Si2 hits E_F AND")
print("       non-magnetic = the lone winner. Distinguishing trait: NOT CoSn-type")
print("       and NOT pyrochlore — it is the CeCo3B2-type R-T3-X2 kagome with a")
print("       4d (Ru) sub-lattice. d-count 7 (same as CoSn) but 4d (not 3d) +")
print("       different kagome stacking puts the flat band ON E_F intrinsically.")

# ── triangulated next candidates: LaRu3Si2 structural siblings ──────────────
# Honest: these are next-EXPERIMENTS (each needs a real gate-check), not closed
# predictions. The triangulation says the WINNING AXIS is the CeCo3B2-type
# 4d/5d-kagome family, so its siblings are the highest-prior candidates.
SIBLINGS = [
    ("LaRu3B2",   "Ru 4d7", "same Ru-kagome, B2 vs Si2 spacer — tests spacer sensitivity; known SC ~few K"),
    ("YRu3Si2",   "Ru 4d7", "La->Y (smaller R) — isovalent, contracts kagome; brackets dE vs LaRu3Si2"),
    ("LaOs3Si2",  "Os 5d7", "Ru->Os (4d->5d, same d7) — heavier SOC, wider band; tests 5d in winning lattice"),
    ("CeRu3Si2",  "Ru 4d7", "La->Ce (4f) — adds correlation/heavy-fermion lens (CAUTION: 4f may break gate)"),
    ("LaRh3Si2",  "Rh 4d8", "Ru->Rh (d7->d8) — one more d-electron in winning lattice; brackets fill direction"),
]
print("\n" + "-" * 70)
print("[5] TRIANGULATED next candidates = LaRu3Si2 structural siblings")
print("    (CeCo3B2-type R-T3-X2 4d/5d kagome — the winning AXIS, not doping):")
print("-" * 70)
for n, tm, note in SIBLINGS:
    print(f"    • {n:10s} ({tm}) — {note}")

print("\n" + "=" * 70)
print("TRIANGULATION v3 VERDICT (honest, c9):")
print("=" * 70)
print("""\
• Two axes, cleanly separated by data:
    - DOPING axis (rigid carriers, fixed cell): MEASURED dead — both dials push
      dE deeper by ~0.1-0.2 eV/carrier, wrong direction. CoSn route CLOSED.
    - CHEMISTRY/LATTICE axis: 3.3 eV span, the real lever. dE~0 is reached only
      by choosing the right element+lattice, NOT by doping a wrong one.
• The ONE non-magnetic dE~0 realization is LaRu3Si2 (CeCo3B2-type Ru-kagome).
  Its distinguishing trait vs all 🔴 points: 4d (not 3d) TM + CeCo3B2 stacking
  (not CoSn-type, not pyrochlore).
• Therefore the highest-prior UNTESTED candidates are LaRu3Si2's structural
  siblings (LaRu3B2 / YRu3Si2 / LaOs3Si2 / LaRh3Si2), each a real gate-check —
  NOT closed predictions (no fabricated dE; v2's lesson applied).
• This REPLACES 'dope CoSn to E_F' (now CLOSED) with 'sweep the CeCo3B2-type
  4d/5d-kagome family' as the next no-cooling lane.
• Caveat: still a DESIGN gate (flat-band-at-E_F), not room-temp; LaRu3Si2 itself
  is Tc~7K. Siblings are explore-not-promised.
""")
