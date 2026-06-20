# RTSC 물질 발견 — 종결식 (FINAL, 4-lens converged) · 2026-06-19

**Question closed:** can an ambient room-temperature superconductor be found, what is the ceiling,
and what is the breakthrough route?

## THE CLOSING FORMULA — two regimes split by the Migdal-validity boundary

Let μ_M ≡ λ·ω_log/E_F (Migdal parameter; flat bands → E_F~W→0 → μ_M large).

  ┌ REGIME I  (adiabatic phonon, μ_M ≪ 1):
  │     Tc ≤ 0.364 · ω_log(W*) · Q_geom^{p/(1+2p)}
  │     λ stability-limited (~4, an ⟨I²⟩/M·lattice-stability ceiling, NOT a theorem)
  │     → room-Tc needs ω_log(W*) ≳ 69 meV = H-phonon budget = the (exhausted) hydride space
  │     Q_geom = Q_diag + Q_phase ∈ [1/N_band, 1]  (geometry SUPPRESSES, lowers ceiling)
  │     STATUS: FINAL in this channel (route-hydride wall + ceiling-escape C1/C2/C3 all confirm)
  │
  └ REGIME II  (light-bipolaron escape, μ_M ≳ 1, flat-band E_F→0):
        Allen-Dynes/Eliashberg BREAKS → real-space bipolaron condensation
        Tc ~ a3 · t**(m**)   — set by the bipolaron MASS, NOT ω_log√λ
        ESCAPES Regime-I ceiling (E=Tc/0.364ω_log = 3.4–5.0) ONLY for LIGHT bipolarons:
          • Holstein (on-site density) → m** ~ e^{g²} exponentially heavy → FALSE escape (E<1)
          • SSH/bond/Peierls (hopping-modulated, off-diagonal) → LIGHT → REAL escape

## THE DISCOVERY RECIPE (actionable payoff)
To exceed the conventional ceiling 0.364·ω_log(W*): engineer a flat-band light-atom material with
**BOND/PEIERLS (off-diagonal) electron-phonon coupling, NOT Holstein (on-site density)**, entering
the light-bipolaron regime and avoiding the heavy-mass penalty m**~e^{g²}.

## VERDICT (honest, d6)
- Ambient ROOM-Tc via the conventional el-ph channel is CLOSED (Regime I ceiling, H-phonon budget,
  hydride space exhausted — externally corroborated Gao Nat Commun 2025 / arXiv:2502.18281).
- The λ≲4 "fundamental cap" is NOT a theorem (Sadovskii arXiv:2506.19326 disputes neg-C_el); it is
  evaded in non-adiabatic/bipolaron regimes.
- THREE independent lenses (cap-escape, route-nonconv, ceiling-escape) CONVERGE: the one route that
  mathematically escapes the ceiling = **bond/Peierls light-bipolaron** SC. The geometric
  superfluid-weight alternative is RULED OUT by a no-go theorem (arXiv:2604.04719).
- HONEST CAVEAT: known bond-bipolaron Tc estimates are tens-of-K (~20–40 K) — a genuine NOVEL,
  first-principles-computable campaign (DFT downfold → bond-Peierls ∂t/∂u + U → bipolaron QMC → Tc),
  NOT a guaranteed room-Tc material. Room-Tc remains open ONLY in Regime II and ONLY if a real
  light-bond-bipolaron host with large t** is found.

## Provenance (4-lens fleet, all g5 PASS)
route-hydride (Regime I wall, Gao corroboration) · cap-escape (λ-cap not a theorem) ·
route-nonconv (no room-Tc channel; bipolaron best lever ~20-40K) · ceiling-escape (bipolaron escape
E=3.4-5.0; no-go theorem kills geometric route). Mechanism law: MASTER_CLOSING_FORMULA.md.
Bipolaron refs: PRX 13,011010 / arXiv:2210.14236 / 2203.07380. Cap: 2407.12922 / 2506.19326.
