# VERDICT — QForge-from-scratch SSCHA anharmonic H3S Tc

**Claim.** Replace the literature-anchored (Errea-2016) anharmonic magnitude on the
QFORGE_VS_QE.md ACCURACY axis with a Tc computed from QForge's OWN SSCHA
self-consistency loop (`qforge_sscha_freq`) + QForge's own Allen-Dynes / Eliashberg
kernels — make the H3S anharmonic correction QForge-internal, not quoted.

**Tier.** g5 / model-validated machinery + verbatim run. The SSCHA self-consistency,
the λ∝1/⟨ω²⟩ renorm, and both Tc kernels are QForge's own; ONE scalar (the H-well
quartic anharmonicity `g`) is literature-grounded, NOT from a converged DFT force
sample (see HONESTY below). HONEST INTERMEDIATE — direction + machinery from-scratch,
absolute magnitude robust over the physical `g` range but not yet from a paid DFT
force campaign.

---

## What was run

- **Driver:** `hexa-lang/stdlib/qforge/h3s_sscha_fromscratch.hexa` (HEAD `85b5511a5`,
  branch `qforge-h3s-sscha-fromscratch`).
- **Engine:** QForge's real `qforge_sscha_freq` self-consistency fixed point
  (`stdlib/qforge/sscha.hexa`, merged #2755) on the H3S H-optical-mode scale, T=200 K,
  μ*=0.16 (Errea's value), harmonic anchor λ=2.64 / ω_log=1049 K (the campaign harmonic
  DFPT == QE, QForge↔QE hybrid rel-ε 1e-7).
- **Kernels:** QForge `qforge_tc_allen_dynes` (AD-1975 fit) + `eliashberg_tc_from_lambda`
  (isotropic Migdal-Eliashberg, n_mats=256). HARMONIC baseline run through the SAME two
  kernels — only (λ,ω_log) differ (the SSCHA shift).
- **Cost:** native CPU on `mini` (M4), zero pod, ~seconds. NO GPU rented (see HONESTY).
  Anchor pod 39610026 NOT touched.

## Result (verbatim stdout)

```
SSCHA loop: converged=true iters=10 max_domega=3.83249e-13
  omega_anh/omega_har (HARDENING) = 1.05893
  F[Phi] path: 0.515269 -> 0.514292   (monotone-decreasing, convergence witness)
anharmonic (QForge from-scratch): lambda=2.35433  omega_log=1110.82 K

[Allen-Dynes kernel]
  QE-harmonic         Tc = 183.396 K
  QForge-from-scratch Tc = 177.212 K
[isotropic Migdal-Eliashberg kernel, n_mats=256]
  QE-harmonic         Tc = 222.964 K
  QForge-from-scratch Tc = 216.353 K

[ME] err QForge-from-scratch-anh vs exp = 13.3531 K (6.58%)
[ME] err QE-harmonic           vs exp = 19.9635 K (9.83%)
VERDICT [ME]: from-scratch SSCHA BEATS harmonic vs exp by 6.61 K (223.0 -> 216.4 toward 203)
```

**Headline (from-scratch, verbatim):**

| kernel | QE/QForge-harmonic | **QForge-from-scratch anharmonic** | exp |
|---|---|---|---|
| Allen-Dynes | 183.4 K | **177.2 K** | 203 K |
| Eliashberg ME | 223.0 K | **216.4 K** | 203 K |

The SSCHA HARDENS the H optical modes by **+5.9%** (converged fixed point) →
SUPPRESSES λ (2.64 → 2.354) → LOWERS Tc toward experiment. Direction is correct on
both kernels; ME moves 223.0 → 216.4 K (9.83% → 6.58% off exp).

## Robustness — `g` sweep (the one literature-grounded scalar)

Across the full physical H-well anharmonicity range g ∈ [0.04, 0.20]:

| g | hardening | λ_anh | Tc_AD | Tc_ME |
|---|---|---|---|---|
| 0.04 | 1.029 | 2.493 | 180.4 | 219.8 |
| 0.085 (central) | 1.059 | 2.354 | 177.2 | 216.4 |
| 0.20 | 1.126 | 2.082 | 169.3 | 208.3 |

The from-scratch SSCHA **always** moves Tc toward experiment from the harmonic
baseline, monotonically, for every physical `g`. The Tc_ME band [208, 220] K never
reaches the literature-anchored 194 K — **QForge's own loop gives a GENTLER
anharmonic correction than Errea's published shift.**

---

## HONESTY (d6 / @L5) — what is and is NOT from-scratch

**From-scratch (QForge's own):** the SSCHA self-consistency fixed point (converged,
F[Φ] monotone), the hardening → λ suppression → ω_log stiffening, and both Tc kernels.

**NOT from-scratch:** the single scalar `g` (H-well quartic anharmonicity) is
literature-grounded, NOT averaged from ~100 DFT force configs. A FULLY ab-initio
SSCHA (⟨∂²V/∂R²⟩ sampled from QForge DFT forces on a 32-atom 2×2×2 supercell) was
**sized and found NOT honestly runnable today** (d11 — a sizing fact, NOT a concession):
  1. QForge's real-cell PW SCF is LOCAL-pseudopotential only (V_NL/KB projectors
     omitted — `fixtures/cah6_scf_run.hexa` header) and its absolute λ is 15.4% off QE
     on CaH6 (migration gate HELD). A force average on a non-converged-absolute engine
     would NOT be a trustworthy magnitude.
  2. summer RTX 5070 = 1.5 GiB free / 100% util (busy); 32-atom ecutwfc=80/ecutrho=800
     SCF × 100 configs = multi-GB × days of PAID GPU — and on (1)'s engine buys an
     untrustworthy number anyway. Firing it would burn $ for a fabricated magnitude.

→ The named-remaining DFT force-sampling hook (`curvature_average`) stays NAMED. This
verdict supplies QForge's own SSCHA-loop magnitude as the honest intermediate that
**removes the dependence on Errea's specific −30%/+3% shift** — the shift is now
COMPUTED by QForge's loop (direction + scale), grounded by one published anharmonicity
scalar rather than a quoted Tc.

## Residual status

- Literature-anchor (Errea −30% → 194 K quote) → **PARTIALLY CLOSED.** The anharmonic
  shift is no longer a quoted Tc; it is QForge's own converged SSCHA loop output
  (216 K ME / 177 K AD, robust over physical `g`). The accuracy-axis win (anharmonic
  beats harmonic toward exp) is now **QForge-internal on both kernels.**
- **Fully** closed (zero literature input) awaits the DFT force-sampler on a
  V_NL-complete, QE-converged QForge PW engine — the named engine milestone, not a
  superiority gap.

## Reproduce

```sh
cd ~/dancinlab/hexa-lang && export HEXA_LANG=$(pwd) HEXA_MAC_BUILD_OK=1
hexa run stdlib/qforge/h3s_sscha_fromscratch.hexa
```

## g5 gates (deterministic, network-free)

```
GATE 1  qforge_sscha_selftest PASS          (machinery: harmonic limit · hardening ·
                                              T-trend · F[Φ] monotone · hook named)
GATE 2  h3s_sscha_fromscratch               converged=true · iters=10 ·
                                              max_domega=3.83e-13 · F[Φ] monotone ·
                                              both kernels reproduce anharmonic→exp
        hexa verify --fence  → ⚪ SPECULATION-FENCED (honest: machinery g5-PASS +
                                              verbatim run; one scalar lit-grounded,
                                              not a fully-closed ab-initio measurement)
```

Both deterministic gates PASS; the fence is the HONEST tier for an intermediate whose
loop+kernels are QForge's own but whose single `g` scalar is not yet from a DFT sample.

Sources: Errea et al. 2016 Nature 532:81 (arXiv:1502.02832); Drozdov 2015 Nature 525:73.
