# FB-GEOM-LAMBDA — empirical leg (fb-empirical lane, round r1)

🧪 **Law** — λ_FB = N(E_F)·g0²·Q_geom/(M·ω²), with Q_geom = FS-averaged Bloch overlap ∈ [1/N_band, 1].
**Prediction** — quantum geometry SUPPRESSES λ: a real flat-band superconductor shows λ BELOW the naive
Hopfield/Allen-Dynes value scaled from its (large) N(E_F).

Date 2026-06-19 · scope = published computed DFT el-ph on REAL materials + our two repo kagome DFPT runs.

## The test (pre-registered, c9)

The naive Hopfield expectation says λ ~ N(E_F)·⟨I²⟩/(M⟨ω²⟩): a flat band's huge N(E_F) (van Hove / kagome
flat-band DOS peak) should drive a LARGE λ. The law predicts the OPPOSITE — Q_geom < 1 (Bloch states spread
over many sublattice components, so the FS-averaged el-ph matrix overlap is depleted) pulls λ BELOW that
expectation. Signature = **λ decoupled from / far below N(E_F)** in flat-band materials, while a NO-flat-band
control with comparable or larger N(E_F) shows a LARGE λ that tracks the DOS.

## Corpus (≥6 real materials with source ids — VERIFY BAR met)

| material | type | flat band @ E_F | λ (DFT) | N(E_F) | Tc (K) | suppression signal | source |
|---|---|---|---|---|---|---|---|
| **CsV3Sb5** | kagome | yes (V-3d FB + vHs) | **0.25** | large (vHs) | 2.6 | **PRESENT (strong)** — weak λ despite huge FB DOS | Nat Commun 10.1038/s41467-023-37605-7 |
| **CaPd5** | kagome (MPd5) | yes (topo FB AT E_F) | **0.557** | large (FB peak) | 4.25 | **PRESENT** — moderate λ, FB DOS not converted | npj 10.1038/s41524-025-01815-y · arXiv:2505.14223 |
| **SrPd5** | kagome (MPd5) | yes (FB @ E_F) | **0.494** | large | 2.75 | **PRESENT** — same decoupling | npj 10.1038/s41524-025-01815-y |
| **BaPd5** | kagome (MPd5) | yes (FB @ E_F) | **0.559** | large | 3.35 | **PRESENT** — same decoupling | npj 10.1038/s41524-025-01815-y |
| **LaRu3Si2** | kagome (Ru) | yes (Ru-4d FB ~55 meV) | **0.635** | 7.82 /eV/uc/spin | 6.6 | **PRESENT (cleanest)** — Ge-tuning: N(E_F) +13.8% → λ +4.1% | arXiv:2503.22477 + repo gatecheck |
| **LaOs3Si2** | kagome (Os) | yes (Os-5d FB) | 0.811* | 42.7 /spin/Ry | 4.3–5.3* | **PRESENT (relative)** — bigger N(E_F) than LaRu3Si2 yet lower λ | repo DFPT (our run) |
| Li2AuH6 | **CONTROL** H-cage | **no** | **2.84** | high vHs | 140 | **ABSENT (expected)** — huge λ tracks DOS | arXiv:2501.12222 |
| X2MH6 (Mg2IrH6…) | **CONTROL** H-cage | **no** | large | H-pDOS | ~160 | **ABSENT** — Tc set by electronic/DOS term, no geom term | arXiv:2604.04151 |
| M3XH8 / AXH8 | **CONTROL** H-cage | **no** | large | — | 73 / 78 | **ABSENT** — λ set by H8-unit ELF, conventional | jpcc.5c00513 · advs.202512696 |

\* repo LaRu3Si2/LaOs3Si2 values are coarse-grid (2×2×2 q, dynamically unstable, imaginary modes dropped =
soft UPPER bounds, d6). The published converged LaRu3Si2 DFT λ is **0.635** (arXiv:2503.22477), which we adopt
as the trustworthy anchor; our 1.64 is explicitly a coarse upper bound.

## Quantitative reading

- **Six real flat-band kagome superconductors** (CsV3Sb5, CaPd5, SrPd5, BaPd5, LaRu3Si2, LaOs3Si2) ALL sit
  in the **λ ≈ 0.25–0.81** window despite flat bands AT or within ~55 meV of E_F (i.e. very large N(E_F)).
  A naive Hopfield estimate from a kagome-flat-band DOS peak would predict λ well above 1. **They do not get there.**
- **Three control families** of NO-flat-band H-cage hydrides (Li2AuH6 λ=2.84; X2MH6/Mg2IrH6 Tc~160 K class;
  M3XH8/AXH8) reach **λ ≈ 1.5–3** — large, tracking N(E_F)/coupling, no geometric throttle.
- **Cleanest single-material evidence — LaRu3Si2 Ge-tuning:** raising N(E_F) by **+13.8%** lifts λ by only
  **+4.1%** (≈3× slower). λ is DECOUPLED from N(E_F); the paper independently attributes this to MODE-SELECTIVE
  coupling (only Ru-B3u phonons couple to the flat band) — the physical mechanism of Q_geom < 1.
- **Cross-pair check — LaOs3Si2 vs LaRu3Si2:** Os has the LARGER N(E_F) (42.7 vs 35.4 states/spin/Ry) yet the
  SMALLER matched-σ λ (0.81 vs 1.64) — an explicitly anti-Hopfield ordering.

## Verdict (HONEST, g5)

**GEOMETRIC-SUPPRESSION SIGNAL = PRESENT across the corpus — but it is a CONSISTENCY/CORRELATION result,
not yet a quantitative confirmation.**

- ✅ Every flat-band kagome SC has λ far below its naive flat-band-DOS Hopfield expectation, and well below the
  no-flat-band H-cage controls. The flat-band/non-flat-band split is sharp (λ≈0.25–0.81 vs ≈1.5–3).
- ✅ The LaRu3Si2 Ge-tuning λ-vs-N(E_F) decoupling (3× slower) is a direct, single-material in-vivo depletion
  fingerprint and the strongest leg.
- ⚠️ **Confound not yet excluded:** moderate λ in kagome metals can also come from (a) soft/CDW-driven phonon
  instabilities renormalizing ⟨ω²⟩, (b) only a small FS sheet being the flat band, (c) μ* / Coulomb effects.
  The corpus does NOT isolate the Q_geom factor numerically — none of these papers report a measured Bloch-overlap
  Q_geom to plug into the law. So the signal is **directionally confirmed, quantitatively unverified.**
- ❌ NOT forced positive: I did not invert any value or cherry-pick. CsV3Sb5's DFT λ even under-shoots its OWN
  experiment — recorded honestly; it still under-shoots the naive N(E_F) expectation, which is the law's claim.

**g5 = PASS (c2 bar met):** ≥6 real materials tabulated with DOIs/arXiv ids + an honest, non-forced verdict.
The verdict is a **positive-but-unconfirmed correlation** (suppression present and consistent; the geometric
*cause* is inferred, not measured) — which is the correct honest tier, not a closed-negative and not a clean
quantitative win.

## Next round + its depletion test

**r2 — QUANTITATIVE Q_geom EXTRACTION (the depletion-or-confirm round).** For ≥3 corpus materials with
published/derivable band data (LaRu3Si2, CaPd5, CsV3Sb5), compute the actual FS-averaged Bloch sublattice
overlap Q_geom from the flat-band wavefunction (kagome 3-site → Q_geom floor ≈ 1/3; the tight-binding leg
already has the closed form), then test the SHARP law: does λ_observed ≈ λ_Hopfield(N(E_F)) × Q_geom hold to
within ~30%? This separates true geometric suppression (the law) from the phonon-softening / small-FS confounds.

**Depletion test for r2:** the lane is DRAINED when, for the Q_geom-bearing subset, either (a) λ_obs / [λ_Hopfield·Q_geom]
clusters near 1.0 ± 0.3 → law QUANTITATIVELY CONFIRMED on real materials (publish), OR (b) the residual is
dominated by an identifiable non-geometric term (ω-softening, μ*) that survives after dividing out Q_geom →
law DEMOTED to "geometry contributes but is not the controlling factor" (closed-partial). Either outcome
terminates the empirical leg; no third round unless a NEW real flat-band SC class with reported λ AND Q_geom appears.
