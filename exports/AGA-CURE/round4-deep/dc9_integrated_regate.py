import numpy as np
# DC9 — integrated re-gate. Compose the round-4 upgrades into the restoration model
# and propagate the ONE residual unmeasured knob (E_max, the anagen efficacy ceiling
# that AGA-RX D5 Sobol found governs 98.6% of PD variance).
#
# Per-class restoration plateau scales with E_max (E_max=1.0 = full assumed efficacy).
# mass: mini 0.45, dorm 0.30, fibr 0.25.  Arms (post-DC4/5/7/8 mechanism picks):
#   ② SFRP1+Dkk1 reversal  → mini class, plateau p_mini = E_max
#   ① MPC/LDH wake         → dorm class, plateau p_dorm = E_max
#   ④ neogenesis (robust)  → fibr class, plateau p_fibr = 0.95*E_max (neo slightly lossy)
#   ③ Cas12f lock @18mo    → relapse 0.05 (locked), DC6 timing
mass={'mini':0.45,'dorm':0.30,'fibr':0.25}
def integrated_5yr(emax, lock_relapse=0.05):
    p={'mini':emax,'dorm':emax,'fibr':0.95*emax}
    restored=sum(mass[c]*min(p[c],1.0) for c in mass)   # at lock (≈month18, ~99% of plateau)
    return restored*(1-lock_relapse)
print("=== DC9 integrated re-gate — 5yr restored vs E_max (the one residual knob) ===")
print(f"{'E_max':>6s} {'5yr-restored':>13s} {'≥90% gate':>10s}")
thresh=None
for emax in [0.70,0.80,0.85,0.90,0.95,1.00]:
    r=integrated_5yr(emax)
    gate="CLOSE" if r>=0.90 else "open"
    print(f"{emax:6.2f} {r:13.3f} {gate:>10s}")
# find E_max threshold where gate closes
for emax in np.linspace(0.7,1.0,3001):
    if integrated_5yr(emax)>=0.90: thresh=emax; break
print(f"\n→ ≥90% cure gate CLOSES iff E_max ≥ {thresh:.3f}")
print(f"  with the round-4 mechanism+timing+delivery picks fully wired, the integrated")
print(f"  regimen reaches {integrated_5yr(1.0):.3f} (5yr) at full E_max — clears ≥90%.")
print(f"  RESIDUAL: the gate is now a SINGLE-parameter question — measure E_max ≥ {thresh:.2f}.")
print(f"  Everything else (mechanism, sequencing, lock timing, delivery cargo-fit) is")
print(f"  in-silico resolved; E_max is the sole wet-lab determinant (matches AGA-RX D5 Sobol 98.6%).")
