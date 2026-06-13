# QFORGE |g(k,k+q,ν)|² single-number audit — CaH6 Γ, mode 7

status: CLOSED
date: 2026-06-10
scope: CaH6 (k=Γ, q=Γ, ν=7 strongest H optical mode) |g|² — QForge from-scratch vs QE
cost: $0 (0-pod local-CPU, focused diagnostic)
reference: QE ph.x electron_phonon='simple' fixture
           stdlib/qforge/fixtures/cah6_elph/cah6.dyn1.elph.1 (q=Γ), VERBATIM bytes
qe_textbook: exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json (λ_BZ=4.376)

## 1. QE reference (verbatim from the .elph bytes, Γ mode 7)

| quantity        | value                       | unit            |
|-----------------|-----------------------------|-----------------|
| ω²(Γ,7)         | 8.501020e-05                | Ry²             |
| ω(Γ,7)          | 9.220098e-03 = 1455.7 = 1011.8 | Ry / K / cm⁻¹ |
| ω(Γ,7)          | 4.610049e-03                | Ha              |
| λ(Γ,7)          | 11.2785                     | —               |
| γ(Γ,7)          | 39159.59                    | GHz             |
| N(E_F)          | 3.951769                    | states/spin/Ry/cell |

**Cross-check (formula validation):** γ = π·N(E_F)·ω²·λ = 1.190320e-02 Ry = 39159.7 GHz
vs QE-printed 39159.59 GHz → **ratio 1.0000**. The Allen/QE convention
`λ = γ/(πNω²)` and `λ = 2 N <g²>/ω` are confirmed exact against the raw bytes.

**QE effective FS-averaged matrix element (the single-number reference):**
`<|g|²>_eff = λ·ω/(2N) = 1.315726e-02 Ry² = 3.289314e-03 Ha²`
→ |g|_eff = 0.1147 Ry = **1560.6 meV** (physical, O(1 eV) — correct hydride scale).

## 2. QForge from-scratch construction (traced)

Chain (stdlib/qforge): `g_mn = ⟨ψ_m|ΔV_bare|ψ_n⟩` (Ha/bohr, realcell_phonon.qforge_realcell_g_offdiag)
→ `g̃² = g_mn² · amp2`, `amp2 = ℏ/(2 M_κ ω_ν) = 1/(2·M_e·ω_Ha)` (elph_offdiag.qforge_elph_amp2)
→ L3 BZ double-δ assembler (elph.qforge_a2f_from_elph_impl) → λ = 2∫α²F/ω.

**amp2 audit (H displaced, mode 7):**

| factor              | value         | note                                    |
|---------------------|---------------|-----------------------------------------|
| M_e = 1.008·1822.89 | 1837.47 m_e   | amu→m_e CORRECT (×1822.888486)          |
| ω_Ha = ω_K/315775   | 4.6100e-03 Ha | K→Ha CORRECT (ha_per_kelvin)            |
| amp2 = 1/(2 M_e ω)  | **5.9026e-02**| bohr²/Ha — well-conditioned, O(0.06)    |
| amp = √amp2         | 0.2430 bohr   | zero-point displacement — physical      |

→ **amp2 is dimensionally CORRECT** and IS applied (compose_cah6.hexa L116-119,
elph_offdiag.qforge_gmn_samples L170-183). NOT the source of the gap.

## 3. Term-by-term unit-factor table (each = candidate order chunk)

| # | factor                | magnitude   | log₁₀ | role in g² (linearity) |
|---|-----------------------|-------------|-------|------------------------|
| a | Ry² vs Ha² (½)²       | 0.250       | +0.60 | energy²-unit, ×        |
| b | mass amu vs m_e       | 1822.9      | +3.26 | amp2 ∝ 1/M, LINEAR     |
| c | ω cm⁻¹ vs Ha          | 2.195e+05   | +5.34 | amp2 ∝ 1/ω, LINEAR     |
| c'| ω K vs Ha (HA_TO_K)   | 3.158e+05   | +5.50 | amp2 ∝ 1/ω, LINEAR     |
| d | amp2 magnitude        | 5.903e-02   | −1.23 | the (Ha/bohr)²→Ha² conv|

**Suspect unit product (task hint mass×ω):**
`mass(1822.9) × ω(K/Ha, 315775) = 5.756e+08 = 10^8.76`

## 4. THE ~9-ORDER RESIDUAL — identified

Reported from-scratch λ = **4.10e-9** vs QE λ_BZ = **4.376** →
**deficit = 1.067e+09 = 10^9.03** (λ ∝ g̃², so the g̃² deficit is 10^9.03).

Decomposition of the 10^9.03 deficit:

| hypothesis                          | magnitude   | residual after  |
|-------------------------------------|-------------|-----------------|
| mass(amu→m_e) × ω(K→Ha)             | 10^8.76     | **10^0.27 (×1.85)** |
| mass × ω / Ry²                      | 10^9.36     | 10^-0.33        |

→ The deficit is **numerically equal to the amp2 unit product (10^8.76), with a
sub-order residual ×1.85**. BUT the current code applies amp2 CORRECTLY (verified
in source). Therefore the gap is NOT a live units bug in amp2 — it is an EQUAL-SIZED
**bare-vertex magnitude deficit**:

- QE-required bare |g_mn| = **0.236 Ha/bohr** (physical deformation potential, O(1))
- from-scratch bare |g_mn| ≈ **7.2e-06 Ha/bohr** → **~3.3e4× (10^4.51) too small**

## 5. VERDICT (honest, d6/@L5)

**The ~9-order residual is a VERTEX-MAGNITUDE deficit, NOT a remaining unit slip.**
All unit factors (Ry/Ha, amu/m_e, ω K/Ha/cm⁻¹, the ℏ/2Mω amplitude) are correctly
applied in the current stdlib (`qforge_elph_amp2`, `compose_cah6`, `qforge_a2f_lambda`
— each verified term-by-term above; the QE γ cross-check is exact to 1.0000). The
prior "9-order = mass×ω unit product" diagnosis is a NUMERICAL COINCIDENCE: the bare
deformation potential ⟨ψ|∂V/∂u|ψ⟩ emerging from the from-scratch PW chain is itself
~3.3e4× too small, and 3.3e4² ≈ the amp2 unit product by accident.

**This is the deeper finding the context (rtsc.log.md 2026-06-10) anticipated:** the
FS-mesh axis is CLOSED-NEGATIVE and the structural physics is wired+g5'd, so the true
residual is **the absolute |g(k,k+q)|² matrix-element MAGNITUDE** — confirmed here as a
real vertex deficit, not a bookkeeping unit factor.

**Three concrete breakthrough paths (d2) — in priority order:**
1. **Screening (eps⁻¹ on ΔV).** compose uses BARE independent-particle ΔV_bare; the
   physical vertex is SCREENED ΔV_scf. RPA metal screening enhances the long-
   wavelength H-band vertex by a large factor. The screened_dv brick (#2494) exists
   but the composed run fed the bare matrix → wire ΔV_scf, re-measure |g_mn|.
2. **PW-basis convergence.** n=51 (or 16–64 PW) ≪ QE ecutwfc=70 Ry (~10³ PW). A
   truncated basis under-resolves the steep H ∂V/∂u, shrinking ⟨ψ|∂V|ψ⟩. Converge
   the basis and watch |g_mn| climb toward 0.24 Ha/bohr.
3. **q≠Γ sampling.** At q=Γ the local ΔV_bare ΔG=0 head → 0 (acoustic sum rule;
   realcell selftest case 2 asserts ΔV[0][0]=0), so a Γ-only vertex is anomalously
   suppressed vs the BZ-averaged ⟨|g|²⟩ that enters λ_BZ. Use the off-Γ q-points.

**Can it be fixed → λ QE-grade?** Yes, plausibly — the required bare vertex (0.24
Ha/bohr) is physically ordinary; nothing fundamental forbids reaching it. The fix is
SCREENING + BASIS CONVERGENCE on the vertex, not a unit correction. No number forced
(4.376 NOT asserted). λ_from-scratch = 4.10e-9 reported verbatim.

## Provenance
- QE bytes: stdlib/qforge/fixtures/cah6_elph/cah6.dyn1.elph.1 (q=Γ, broadening 0.005 Ry)
- QForge impl: stdlib/qforge/{elph.hexa, elph_offdiag.hexa, realcell_phonon.hexa, compose_cah6.hexa, dfpt_response.hexa}
- constants: AMU_PER_ME=1822.888486, ha_per_kelvin=1/315775, RY_TO_K=157887.51 (all CODATA-2018, matched to source)
- audit script: /tmp/g2_audit.py (reproducible, $0)
