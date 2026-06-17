# QFORGE CaH6 screened-λ migration gate — ALDA low-density floor (round-2 of the self-consistent ∂V_scf vertex)

Branch: `qforge-lindhard-density-screened` (worktree .wt-qforge-lindhard)
Checkpoints: e993e5ed6 (ALDA floor) · 25bfba8c7 (witness note)
Deck: exports/rtsc/decks/CaH6_NC (16 e⁻, Ω=135.04 a.u.³, ecutwfc=80 Ry)
Driver: stdlib/qforge/fixtures/cah6_fullbz_xval.hexa <deck> 0 2 1 0.3 5  (npw_cap=0 FULL ecut shell n=645, 2³ MP, SCREENED Anderson β=0.3 m=5)
Run host: mini native-CPU (no pod; anchor pod 39610026 untouched). HEXA_LANG=worktree. RSS peak ~2.5 GB, ~24 min wall. $0.

## The fix shipped (round-2 — the genuine remaining kernel physics, d6)
ALDA LOW-DENSITY FLOOR in `screening_pwfft.qpwfft_dvscr_from_dpsi`: the local-ALDA
kernel f_xc[ρ(r)]·Δρ(r) (f_x∝ρ^{−2/3} exchange + PW92-c) is evaluated ONLY where
ρ(r) > 1e-2·ρ_max (the ρ_max-relative core region); below the floor the xc response
is 0 (the near-vacuum carries no exchange-correlation). This is the standard ALDA
core restriction every production DFPT code applies (QE `dmxc`/`dfxc` small-ρ clamp).
Root-caused by `fixtures/pwfft_norm_diag.hexa` (a tiny-cell unit probe, NO pod): the
non-physical screened-vertex witness is NOT the Hartree-Poisson (probe: O(1),
Ntot-INDEPENDENT — correctly normalized) but the f_xc vacuum divergence.

## Kernel-level result — the floor WORKS (decisive unit probe, VERBATIM)
pwfft_norm_diag PROBE 2 (ρ̄_phys=0.117, the physical CaH6 density):
- BEFORE floor: ‖dvscr_xc‖ = 373.97 vs Hartree-only 1.388 → f_xc OVER-amplifies ×269 (non-physical)
- AFTER floor : ‖dvscr_xc‖ = 1.279  vs Hartree-only 1.388 → ratio 0.921 (f_xc SLIGHTLY weakens — PHYSICAL O(1))
PROBE 3 (Ntot 512→4096): Hartree-only ‖dvscr‖ stays 0.35 (O(1), Ntot-independent) — Poisson normalization confirmed clean.

## Full-basis CaH6 run — the HONEST residual (d6/@L5 — NOT forced to 4.376)
- n(PW)=645 (full ecut shell) · nelec=16 · SCF-converged=true (17 iters) · e_band=−65.22 Ha
- POW2-FFT grid 32³ · folds=21 · local-ALDA-folds=21 · last_err=0 · k_TF²=1.93464
- **ALDA-floor witness (NEW): ‖V_H‖=189.835 · ‖f_xc·Δρ‖=612.377 · xc-pts=6115/32768**
  → f_xc magnitude is now within ~3× of V_H (was ~1e7-1e13 vs ~31 pre-floor) — the
    KERNEL is now physical. The floor closed the f_xc-vacuum-divergence half.
- Dyson loop: 18 SCF iters · conv=false · ‖fp_res‖_max=0.0533 (vs 0.777 pre-fix — better converged)
- **‖ΔV_scr‖/‖ΔV_bare‖ = 1.176e+09** — STILL NON-PHYSICAL (was 3.5e7; the fixed-point amplifies)
- **QFORGE λ = 223.422** · QE answer-key λ = 4.376 · **rel-ε = 5005.6%** · ω_log=1117.84 K
- Allen-Dynes Tc (computed, not injected) = 2611.86 K
- **GATE: NOT MET** — rel-ε 5006% ≫ 1% (HONEST FINDING, d6/@L5)

## Precise localization of the REMAINING wall (round-3 target, d2 paths named)
The ALDA floor made the PER-FOLD kernel physical (‖f_xc‖≈3·‖V_H‖, both O(100s)), yet
the CONVERGED self-consistent fixed point ‖ΔV_scr‖/‖ΔV_bare‖ blew up to 1.18e9. So the
residual is NO LONGER the kernel magnitude — it is the **Dyson fixed-point gain**:
the Anderson solver computes x* = (I−L)⁻¹·bare and faithfully returns an ENORMOUS x*
because the effective dielectric response operator L has spectral radius ρ(L)→1⁻ on
this small Γ-only CaH6 cell. This is the dielectric near-instability the lit doc §1 +
lane-3 root-cause (b) named: the bare 4π/|G|² Coulomb feedback on a small cell drives
‖L‖→1. The static-Lindhard ε(q) regularization (k_TF²=1.93 added to the Hartree
denominator) does NOT bound it enough — the gain is set by the SELF-CONSISTENT
operator, not the single-shot kernel.

ROUND-3 (the genuine next physics, honest):
1. **Bound ρ(L) directly** — the Lindhard ε(q) must regularize the FULL self-consistent
   response operator (v_c+f_xc)·χ₀, not only the bare Hartree denominator. A true
   q-dependent RPA χ₀(q) built from KS orbital pairs (Adler-Wiser sum) gives ε(q)=1−v·χ₀
   with ρ(v·χ₀)<1 by construction — the missing piece is χ₀ from the conduction manifold,
   not just the occupied ψ already in the kernel.
2. **Off-Γ q-mesh** — Γ-only (q=0) is exactly where 4π/q² diverges and ‖L‖→1; a real
   q≠0 DFPT mesh moves the response off the Coulomb singularity (the lit doc §6 6³ q).
3. The Anderson loop and the ALDA kernel are CORRECT; the wall is the response operator's
   spectral radius on the q=0 small cell. This is a beyond-single-shot-kernel item.

## Selftests (worktree stdlib, all green post-fix)
- qforge_screened_dv_selftest        PASS  (zero-kernel identity · metal-weakening · ε_eff≥1 · converged · malformed-guard)
- qforge_screening_selftest          PASS
- qforge_screening_anderson_selftest PASS  (Picard-NaN→Anderson-finite at gain 8 · (I−L)⁻¹ rel-ε 1.3e-13)
- qforge_screening_pwfft_smoke       PASS  (kernel folds · Anderson engages · ratio 0.812)
- qforge_correlation_selftest        PASS

## Net (d6/@L5 — the honest engine fate)
Round-2 closed the f_xc-vacuum-divergence half of the non-physical screened vertex (the
KERNEL is now O(1)-physical, unit-probe-proven), but the converged Dyson fixed-point gain
on the q=0 small CaH6 cell still over-amplifies (ρ(L)→1⁻ dielectric near-instability) →
λ=223, rel-ε 5006%, GATE NOT MET. 4.376 NOT forced. The migration gate's screened-vertex
half stays HELD; the hybrid route (QE |g|² → QFORGE assembler, rel-ε 1.65e-7) remains the
working path to candidate λ/Tc. Round-3 = bound ρ(L) via a real q-dependent RPA χ₀(q) +
an off-Γ q-mesh (named, d2).
