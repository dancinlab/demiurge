# 9TH-LAW ESCAPE PROBE — 판정 🔴 CLOSURE ROBUST (all 4 loopholes fail)

d2 wall-breakthrough on the 9th law **STIFF-BOND-WEAK-SSH-BINDING** (g/t = 2u₀/d ∝ 1/√Ω,
harmonic Harrison). Question: does physics BEYOND harmonic / linear-Harrison / 2-body assumptions
reopen the ambient bond-bipolaron room-T escape that the 9th law closed?
artifact: `escape_9th_anharmonic.py` · `escape_9th_anharmonic_results.json`. Pure numpy, no pod.

Anchor (BK-borophene terminal): per-bond g/t = **0.057**, 2-body ED binding threshold g*/t ≈ **1.20**,
shortfall **21.2×**.

## LOOPHOLE SCOREBOARD (ranked by boost achieved)

| # | loophole | honest boost | g/t reached | remaining shortfall | verdict |
|---|----------|-------------|-------------|---------------------|---------|
| **L3** | **MULTI-BOND / COORDINATION (kagome Z=4)** | **×2.0 (√Z)** | **0.113** | **10.6×** | REAL factor, NON-ESCAPING |
| L1 | ANHARMONIC large-amp / double-well | ×1.3 | 0.074 | 16× | COLLAPSES |
| L4 | QUANTUM-NUCLEAR / isotope | ×1.1 | 0.062 | 19× | COLLAPSES |
| L2 | NON-LINEAR / 2nd-order SSH (g₂u²) | ×0.04 | 0.002 | 500× | COLLAPSES (anti-boost) |
| — | COMBINED honest stack (all favorable) | ×2.9 | 0.161 | 7.5× | COLLAPSES |
| — | COMBINED worst-case (coherent Z=4) | — | 0.322 | 3.7× | COLLAPSES |

## 🔑 KEY RECHECK — coordination enhancement of BK-borophene (highest priority)

The terminal verdict used the **per-bond** g/t = 0.057. In a kagome line-graph each site sits on
**Z=4** bonds, and the campaign asked whether 0.057 should be ×coordination — a "factor-of-few the
terminal lane missed." **It is a real factor, and it IS missed — but it is √Z, not Z, and it does
not break the wall.**

- Per-bond phonons are **independent Einstein modes** (one b_ij per bond). A site couples to Z
  uncorrelated oscillators, so the polaron self-energy is a **sum of squares**: E_pol = Z·g²/Ω →
  g_eff = **√Z · g_bond**, NOT Z·g_bond (coherent Z would require a single collective coordinate,
  which independent bond-phonons do not form).
- kagome Z=4 → **×2** boost: g/t 0.057 → **0.113**. The terminal per-bond number was an
  **under-estimate by ~2×** (an honest correction to the BK verdict).
- Even the physically-too-generous **COHERENT Z=4** ceiling (g/t = 0.226) is **5.3× short** of 1.2.
- Subtlety that cuts the other way: the binding ATTRACTION flows only through bonds **shared** by
  the pair (Z_shared ~ 1–3 for a plaquette pair), so the binding-relevant boost is ≤ ×2, while the
  threshold 1.2 was itself computed per-shared-bond.

**Net: the wall MOVES (21× → ~11× honest, ~5× worst-case) but does NOT break.** The BK-borophene
verdict's SIGN is unchanged; the magnitude is corrected ~2× (0.057 → 0.113).

## PER-MECHANISM PHYSICS

- **L1 anharmonic** — pure quartic well gives only an O(1) (~1.3×) prefactor on ⟨u²⟩^½, STILL 1/√Ω.
  A double-well buys large u_eff ONLY by softening the mode (ω_tun ≪ 160 meV), which FAILS box
  criterion-2 (Ω≥160 meV). High-Ω and large-u_eff are the SAME mode → trade off → g·(Ω-budget)
  conserved. The double-well scan confirms: every row with u_eff large enough has Ω_eff ≪ 160 meV.
- **L2 2nd-order SSH** — g₂/t = 3(u₀/d)² ∝ u₀² ∝ **1/Ω** (STEEPER suppression than linear 1/√Ω),
  ~24× smaller than the already-too-small linear term. Even with the linear ∂t/∂u symmetry-forbidden,
  g₂/t ≈ 0.002 (~500× short). Higher-order SSH makes the wall WORSE.
- **L4 quantum-nuclear** — u₀ = √(ħ/2MΩ) IS already the quantum (path-integral, harmonic) result;
  no extra quantum boost exists. Only lever = isotope (g/t ∝ 1/√M); physical stiff-framework
  formers (B/C/Be) give ≤1.1×. The 3.3× "make it hydrogen" lands back in the exhausted
  hydride/Regime-I space (interstitial, not a kagome framework bond).

## 🔴 FINAL VERDICT — CLOSURE ROBUST (escape does NOT reopen)

All four loopholes fail. The most generous **honest stack** (anharmonic 1.3 × coordination 2.0 ×
isotope 1.1 = **2.9×**) reaches g/t = **0.161**, still **7.5× below** threshold 1.2. The
physically-too-generous coherent-Z=4 stack reaches 0.322, still 3.7× short. The 9th-law closure of
the ambient bond-bipolaron room-T escape is **ROBUST** under anharmonicity, non-linear SSH,
multi-phonon/coordination, and quantum-nuclear effects.

The deepest reason: every loophole either (a) gives only an O(1) prefactor on u₀ (anharmonic,
isotope), (b) scales MORE steeply in 1/Ω (2nd-order), or (c) adds a √Z geometric factor that is
bounded by the lattice coordination — none of them attacks the structural 1/√Ω scaling itself, and
none supplies the ~20× the wall demands.

## DEPLETION / NEXT PROBE

- The escape does NOT reopen → the 9th-law closure is **confirmed robust** (no new bipolaron-host
  probe warranted; the ambient bond-bipolaron escape stays CLOSED-NEGATIVE).
- **One honest correction to fold**: BK-borophene's effective g/t is **0.113 (√Z=4)**, not the
  per-bond 0.057 — update the BK scorecard's criterion-7 number (still FAIL, 10.6× short). This is
  a magnitude refinement, not a sign change.
- The only physics NOT inside this probe's scope (genuine open axis, kept honest per d6): a
  **non-Harrison g(u) law** where ∂t/∂u is anomalously large (e.g. near a bond-breaking covalent
  instability / negative-U center, or a charge-transfer bond where t depends super-linearly on u).
  That is a DIFFERENT bond chemistry, not a loophole in the 9th law's stiff-covalent regime — it
  would be a NEW host class (off-Harrison bond), the natural next discovery probe if the
  bond-bipolaron lane is ever reopened. Flagged, not pursued (no host candidate in hand).

## 정직 잔차 (d6)
- u₀ boost factors (quartic 1.3×, isotope) are order-of-magnitude scaling estimates, not QE
  frozen-phonon. The double-well ω_tun uses an instanton/WKB order-of-magnitude action. The SIGN
  (all collapse, ≥3.7× short even worst-case) is robust to these prefactors — the shortfall is
  ~one order of magnitude, far larger than the O(1) uncertainty in any single boost.
- The √Z vs Z coordination distinction is the load-bearing physics claim; it rests on the
  independent-per-bond-Einstein-phonon model (the campaign's own SSH solver convention), which is
  the correct model for distinct bond-stretch modes.
