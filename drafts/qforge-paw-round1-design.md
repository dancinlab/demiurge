# QFORGE-PAW round-1 — PAW/USPP el-ph deformation-potential design + lit-grounding

date: 2026-06-12 · scope: design/research round (0-pod, mini local + summer-free, $0)
domain: `domains/QFORGE-PAW.md` · parent: QFORGE engine
governance: d18 (round-1 = NOVEL + arxiv + web deep research) · d6/@L5 (HONEST, 4.376 never forced)

---

## 0. TL;DR — the lit-grounded culprit ranking

The ~3.3e4× (10^4.51) bare-vertex deficit named in `.verdicts/qforge-g2-audit/VERDICT.md`
is **NOT primarily a pseudopotential-type (NC vs PAW/USPP) effect.** The literature is
explicit on this. Ranked culprits, lit-grounded:

1. **PRIMARY (lit-decisive): the g2-audit 3.3e4× is an APPLES-TO-ORANGES artifact, not a
   real NC-pseudo deficiency.** The number was measured at a *tiny unconverged basis*
   (n=51 PW), at *q=Γ only* (where the local-ΔV head is zero by the acoustic sum rule), with
   the *bare* (unscreened) vertex, against the *λ=4.376 textbook deck*. The very next
   milestone (off-diag-integrated, 2026-06-12) using a **converged SCF n=64** got the
   from-scratch bare |g| to *physical order* — λ=1.1545 (rel-ε 0.736), NOT 3.3e4× off. So the
   live residual is **0.736× in λ (~1.95× in |g|), not 10^4.5×**. The 3.3e4× is dead.
2. **SECONDARY (the real ~1.95× |g| residual): XC functional + pseudo/core treatment TOGETHER**,
   with a STRONG lit caveat (§2): NC *can* reproduce PAW |g| once core regions are excluded —
   so a clean NC implementation should NOT be even 2× off for a pure-magnitude reason.
3. **The QE answer-key itself is mis-anchored.** The canonical CaH6 reference (Wang et al.
   PNAS 2012) reports **λ=2.69** (PAW + PBE + QE), NOT 4.376. The campaign's 4.376 is a
   *different, likely under-converged* QE deck (the textbook proof). Re-anchoring the gate
   target to a converged λ (lit CaH6 λ≈1.6–2.7) is a prerequisite — QForge's λ=1.15 may be
   nearer converged-truth than 4.376 implies.

**Net:** PAW/USPP augmentation is worth building for *accuracy + transferability*, but the
lit does NOT support "PAW recovers a 4-order |g| deficit." Honest round-1 conclusion:
(3) re-anchor + (2) **PBE-XC SCF alignment first**, with PAW augmentation as the accuracy
finisher — NOT a 4-order magic bullet. See §5 milestones.

---

## 1. arxiv/web lit-grounding (verbatim + DOI)

### (a) PAW/USPP el-ph deformation-potential theory — how augmentation enters ∂V/∂u

- **Dal Corso, "Density-functional perturbation theory with ultrasoft pseudopotentials,"
  Phys. Rev. B 64, 235118 (2001). DOI: 10.1103/PhysRevB.64.235118.** Canonical USPP-DFPT
  reference. The formulation "accounts for the **nonorthogonality of the orbitals, the
  augmentation of the electron density, and the dependence of the generalized orthogonality
  constraint on the atomic positions**." Structural consequence for el-ph: with USPP the KS
  orbitals satisfy a *generalized* eigenproblem with an **overlap operator S**, and ∂/∂u
  acquires extra terms from (i) the augmentation charge Q_ij(r) derivative and (ii) the
  position-dependence of S (the orthogonality constraint moves with the atom).
- **de Gironcoli/Dal Corso, "Density-functional perturbation theory for lattice dynamics with
  ultrasoft pseudopotentials," Phys. Rev. B 56, R11369 (1997). DOI:
  10.1103/PhysRevB.56.R11369.** First generalization of DFPT lattice dynamics to Vanderbilt
  USPP — establishes that "additional terms originate from the augmentation charges."
- **Audouze, Jollet, Torrent, Gonze, "Density functional perturbation theory within the
  projector augmented wave method," Phys. Rev. B 73, 235101 (2006). DOI:
  10.1103/PhysRevB.73.235101.** The PAW-DFPT analogue. PAW carries the *full* (non-pseudized)
  augmentation Q_ij(r); ∂V_scf/∂u includes the on-site D_ij derivative + Q_ij(r) derivative.

**Mechanism (lit-grounded synthesis, flagged REASONED not single-quote):** in NC the el-ph
vertex is g_mn = ⟨ψ_m|∂V_loc/∂u + ∂V_NL/∂u|ψ_n⟩ with V_NL = Σ|β_i⟩D_ij⟨β_j| (Kleinman-Bylander,
position-dependent via β(r−τ)). In USPP/PAW three NEW pieces appear:
- ∂(augmentation density)/∂u: ρ = |ψ|² + Σ_ij Q_ij(r)⟨ψ|β_i⟩⟨β_j|ψ⟩ → ∂ρ/∂u gets a
  ∂Q_ij(r−τ)/∂u term. **For H, Q_ij(r) is concentrated where the all-electron 1s peaks** —
  exactly the region NC pseudizes away — so the augmentation ∂ρ/∂u is largest near H.
- ∂D_ij/∂u (D_ij is now ρ-dependent: D_ij = D_ij^0 + ∫ V_eff Q_ij).
- ∂S/∂u (the overlap/orthogonality term, absent in NC).

### (b) NC vs USPP/PAW quantitative |g| / λ difference in hydrides

- **SMOKING-GUN (PrH9):** *"ultrasoft RRKJ pseudopotentials led to Tc > 60 K, but
  norm-conserving GHHT pseudopotentials gave λ < 0.3 and Tc < 1 K"* — same material,
  pseudo-type alone flips λ by a large factor. Source: superconducting-praseodymium-superhydride
  literature (arXiv:1904.06643 family). Shows pseudo-type CAN matter a lot in hydrides — BUT it
  is a *transferability/quality* effect of a *specific bad NC pseudo*, not a universal "NC is
  4-orders too small."
- **COUNTERWEIGHT — NC and PAW AGREE off-core (decisive caveat):** **"Real-space understanding
  of electron-phonon coupling in superconducting hydrides," arXiv:2507.06749 (2025).** Uses
  **PBE + PAW**, computes el-ph by finite-difference ∂v_KS/∂u_a. States the deformation-
  potential D²(r) is *"highly dependent on the pseudopotential"* in the core region, but proves
  in Appendix B (Fig. 3) that once core regions are excluded (per-element radii), the el-ph
  result is **"independent of the pseudopotential used"** — directly comparing PAW vs norm-
  conserving. **Load-bearing lit fact: a correctly-implemented NC vertex, evaluated over valence
  regions, should match PAW for hydride el-ph.** ⇒ a 3.3e4× (or even clean 2×) NC-vs-QE gap
  points at a QForge-side implementation/convergence issue, NOT an intrinsic NC limitation.

### (c) What pseudopotential did QE use for the CaH6 answer-key?

- **Wang, Tse, Tanaka, Iitaka, Ma, "Superconductive sodalite-like clathrate calcium hydride at
  high pressures," PNAS 109, 6463 (2012). DOI: 10.1073/pnas.1118168109** (canonical CaH6 ref).
  VERBATIM (PMC3340045 methods): *"The all-electron projector-augmented wave method was adopted
  with 1s and 3p⁶4s² treated as valence electrons for H and Ca, respectively."* Functional =
  **PBE-GGA**. Code = **VASP (structure) + Quantum ESPRESSO (el-ph)**. Reported **λ = 2.69**,
  Tc 220–235 K @150 GPa, 187 K @250 GPa.
- **Re-anchoring consequence:** the literature CaH6 λ is **2.69 (PBE+PAW)**, and converged
  studies (J. Phys. Chem. C 2023, DOI 10.1021/acs.jpcc.3c06664; New J. Phys. 2022, DOI
  10.1088/1367-2630/ac8a0c = arXiv:2111.10797) sit at λ≈1.6–2.7 incl. anharmonic/quantum
  corrections. So **the gate's 4.376 target is an outlier** — almost certainly the campaign's
  under-converged textbook deck (matches the migration-memory note "QE 4.376 is likely under-
  converged"). The PAW project must re-anchor against a *converged PBE+PAW λ≈2.69*, not 4.376.

---

## 2. Diagnosis — is the ~3.3e4× deficit pseudo-type, PBE-band, or a QForge bug?

**Honest verdict (d6): the 3.3e4× number is an artifact and is already dead; the live residual
is ~1.95× in |g| (λ 0.736), and the lit says that residual is NOT a pure pseudo-magnitude effect.**

Evidence chain:
1. The 3.3e4× was a *tiny-basis (n=51 PW) + q=Γ + bare-vertex* audit vs the *4.376* deck
   (`.verdicts/qforge-g2-audit/VERDICT.md` §4). Three of those four are known suppressors:
   q=Γ zeroes the local-ΔV head (acoustic sum rule), n=51 ≪ converged, bare ≠ screened.
2. The converged-SCF (n=64) off-diag-integrated milestone (2026-06-12) reached λ=1.1545
   (rel-ε 0.736) — bare |g| now *physical order*. A basis change (same NC pseudo) removed ~4
   of the 4.5 orders → the pseudo-type cannot be the 3.3e4× cause.
3. **Lit (2507.06749 Appendix B): NC ≈ PAW for hydride el-ph once cores excluded.** A clean NC
   vertex should NOT be even 2× below PAW for magnitude reasons alone.

⇒ The live ~1.95× |g| residual is most plausibly a **combination of**: (i) **XC functional** —
QForge SCF is **LDA PW**, QE/lit is **PBE-GGA**; PBE shifts band positions, DOS at E_F, and the
screened ∂V. NOTE the gate memory's "PBE CLOSED-NEGATIVE" refers to PBE as a *Dyson screening
kernel* (f_xc-in-χ) — the **ground-state SCF functional was NEVER swapped to PBE**; that is the
un-tried lever. (ii) **residual core/basis treatment** of the steep H ∂V near 1s — where PAW
augmentation *would* improve accuracy. (iii) a possible **QForge NC-vertex implementation gap**
(lit says NC should match PAW off-core, so any clean ≥2× gap is suspicious and merits a same-
pseudo NC-vs-QE-NC head-to-head).

**Could augmentation alone make |g| 4–5 orders bigger? NO** (lit-grounded). Augmentation
*concentrates* ∂ρ near H (helps accuracy) but 2507.06749 shows the *converged* el-ph is
pseudo-independent off-core. A 4–5-order swing is supported nowhere in the lit. **Honest: the
3.3e4× framing in the domain @goal/task should be retired** in favor of "0.736× λ residual,
mostly LDA→PBE SCF + accuracy-grade augmentation."

---

## 3. QForge integration design — minimal path to QE-grade ground state

### Current architecture (live `~/.hx/src/stdlib/qforge/`, mapped this round)
- `upf.hexa` — **NC-only** UPF v2 parser. *Already detects & cleanly rejects* US/PAW via the
  `is_ultrasoft`/`is_paw` header flags + `PP_AUGMENTATION`/`PP_Q` (scope guard, lines ~254–266).
- `vloc.hexa` — radial V_loc(|G|) form factor.
- `projector.hexa` — KB-separable nonlocal `V_NL = Σ|β_i⟩D_ij⟨β_j|` (j_l up to l=2, Legendre
  addition theorem for angular). D_ij are *constant* (NC).
- `dvloc_du.hexa` — bare **local** deformation potential `∂V_loc/∂u = −iG_d·V_loc(|G|)·S(G)`.
  HONEST: local part ONLY; NO nonlocal ∂V_NL/∂u, NO augmentation term yet.
- `scf_pw.hexa` / `scf_pw_realspace.hexa` — PW SCF (currently **LDA** XC via `correlation.hexa`;
  `correlation_pbe.hexa` + `qforge_h_pbe` EXIST but the from-scratch SCF was never run on PBE).
- `dfpt_response.hexa` — Sternheimer self-consistent response (consumes a ΔV_bare provider).
- `elph_offdiag.hexa` / `elph.hexa` — vertex assembly + L3 BZ double-δ → λ.
- `screening_pwfft.hexa` — FFT-Poisson Dyson screening (RPA + ALDA/GGA f_xc-in-χ levers, all
  CLOSED-NEGATIVE as Dyson *screening* kernels).

### Two integration routes (d4-generic, manifest-only dispatch)

**Route A — full USPP/PAW rebuild (correct, large).** New bricks: `upf_uspp.hexa` (parse
PP_AUGMENTATION/PP_QIJ/PP_Q + PP_DIJ) · `augmentation.hexa` (Q_ij(r→G) on the dense grid) ·
overlap operator `S = 1 + Σ|β⟩q_ij⟨β|` threaded through SCF (generalized eigenproblem) · ρ_aug
in the density mixer · ∂S/∂u + ∂Q_ij/∂u + ∂D_ij/∂u in a new `dvnl_du.hexa`. Touches `upf`,
`scf_pw*`, `dfpt_response`, `elph_offdiag`. **Multi-month** — the "12-dataset / generalized
eigenproblem" rebuild the gate memory warns about.

**Route B (NOVEL shortcut, RECOMMENDED first) — PBE-SCF align + NC augmentation-correction
overlay, no generalized eigenproblem.** Three small, independently verifiable pieces, ordered
by lit-predicted payoff:
- **B1 (biggest λ-lever, smallest change): swap from-scratch SCF XC LDA→PBE.** The ground-
  state functional is the ONE un-tried gate lever (Dyson-kernel PBE was tried & CLOSED-NEG, but
  that is the *screening* kernel, not the *SCF* functional). `correlation_pbe.hexa` +
  `qforge_h_pbe` already exist. Wire them into `scf_pw.hexa`'s XC call behind manifest flag
  `xc="pbe"` (d4 — no name hardcoding). Re-measure CaH6 |g| & λ. Aligns band/DOS/ρ to the
  QE/lit starting point — the most likely source of the ~1.95× residual.
- **B2: ∂V_NL/∂u nonlocal deformation potential (NC, no augmentation).** `dvloc_du.hexa` only
  does the *local* head. KB V_NL is position-dependent (β(r−τ)); its displacement derivative
  ∂V_NL/∂u = Σ|∂β_i⟩D_ij⟨β_j| + h.c. is a genuine, *currently-missing* vertex contribution that
  needs NO augmentation. New brick `dvnl_du.hexa` reusing `projector.hexa` β-transforms — the
  largest clean-NC accuracy gain before touching USPP.
- **B3: NC + augmentation-correction overlay (the NOVEL minimal-PAW).** Rather than a full
  generalized eigenproblem, add ONLY the augmentation-density el-ph correction as a perturbative
  overlay on the converged NC ψ: load Q_ij(r) for H from a USPP/PAW UPF, build ρ_aug =
  Σ_ij Q_ij(r)⟨ψ|β_i⟩⟨β_j|ψ⟩, and add ∂ρ_aug/∂u into ∂V_scf/∂u. Skips ∂S/∂u + the generalized
  eigenproblem (approximation, flagged HONEST) — tests whether the *augmentation ∂ρ near H* is
  the residual without the full rebuild. If B3 moves |g| materially, escalate to Route A.

**Recommended sequence: B1 → B2 → (re-anchor λ to 2.69) → B3 → escalate to A only if needed.**
B1+B2 are pure-NC and need NO augmentation parsing — they isolate "is the residual XC+nonlocal-
∂V (cheap fix) vs genuinely augmentation (expensive)?" before committing to the USPP rebuild.

---

## 4. Round-2 first implementation step (smallest verify-able piece)

**STEP: B2 seed — `dvnl_du.hexa` brick 1: single-direction ∂β_i(q)/∂u_d form factor + a g5
norm/Hermiticity self-test on the existing l=0 analytic-Gaussian projector fixture from
`projector_selftest.hexa`.**

Why this first (not B1 or augmentation):
- Smallest *new physics* with a closed-form g5 anchor: ∂β_i(q)/∂u_d = −iG_d·β_i(q) (same
  structure-factor phase derivative already proven correct in `dvloc_du.hexa`), so the selftest
  is `‖∂β/∂u(−G) − conj(∂β/∂u(G))‖ < 1e-10` (Hermiticity → real-space realness) PLUS a finite-
  difference check ∂β/∂u ≈ [β(τ+ε)−β(τ−ε)]/2ε against the analytic Gaussian transform.
- Reuses `projector.hexa` (d19) — no new radial machinery.
- Verify (round-2): `hexa run ~/.hx/src/stdlib/qforge/dvnl_du_selftest.hexa` (g5 self-anchored,
  no pod), OR `hexa verify --expr` on the FD-vs-analytic ratio.
- Acceptance: Hermiticity < 1e-10 AND FD/analytic ratio within 1e-6. Then B2 brick 2 assembles
  the full Σ|∂β⟩D⟨β| block and feeds `elph_offdiag.hexa`; re-measure CaH6 |g|.

(B1 — the PBE-SCF swap — is *parallelizable* with B2 and is the higher-λ-payoff lever, but its
verify is a full CaH6 SCF re-run, not a single-brick g5; B2 is the cleaner *first* commit.
Round-2 should fire BOTH: B2 as the verify-anchored first brick, B1 as the parallel SCF lever.)

---

## 5. Domain milestone update (round-2 onward)

- [x] round-1 — lit-grounding + integration design (this draft)
- [ ] B1: from-scratch SCF XC LDA→PBE (manifest `xc="pbe"`, reuse `correlation_pbe`/`qforge_h_pbe`)
- [ ] B2: nonlocal ∂V_NL/∂u (`dvnl_du.hexa`, NC, no augmentation) — round-2 first brick
- [ ] re-anchor gate target: converged PBE+PAW CaH6 λ≈2.69 (PNAS), retire 4.376 outlier
- [ ] B3: NC + augmentation-correction overlay (∂ρ_aug/∂u, no generalized eigenproblem)
- [ ] (Route A, only if B1–B3 insufficient) full USPP/PAW: overlap S + Q_ij + generalized eig

---

## 6. Key DOIs (verbatim)

1. **Dal Corso, Phys. Rev. B 64, 235118 (2001)** — DOI 10.1103/PhysRevB.64.235118 (USPP-DFPT;
   augmentation ∂/∂u + overlap S).
2. **de Gironcoli/Dal Corso, Phys. Rev. B 56, R11369 (1997)** — DOI 10.1103/PhysRevB.56.R11369
   (first USPP lattice-dynamics DFPT; "additional terms from augmentation charges").
3. **Audouze/Jollet/Torrent/Gonze, Phys. Rev. B 73, 235101 (2006)** — DOI
   10.1103/PhysRevB.73.235101 (PAW-DFPT).
4. **Wang/Ma et al., PNAS 109, 6463 (2012)** — DOI 10.1073/pnas.1118168109 (CaH6 answer-key:
   PAW + PBE + QE, **λ=2.69** — re-anchor target).
5. **"Real-space understanding of el-ph in superconducting hydrides," arXiv:2507.06749 (2025)**
   — decisive caveat: NC ≈ PAW once cores excluded (PBE+PAW finite-difference ∂v_KS/∂u).

---

## 7. HONEST notes (d6/@L5)

- λ/Tc/DOI values are verbatim from the cited sources; the §1 augmentation *mechanism* and §2
  *ranking* are REASONED from the cited DFPT-USPP/PAW papers, not single-source quotes — flagged
  as reasoning, not measurement.
- The 3.3e4× → 0.736× correction is *internal* (verdict re-reading), grounded in two repo
  verdicts (`qforge-g2-audit`, `qforge-offdiag-integrated`).
- 4.376 NOT forced. If B1+B2+B3 land CaH6 at λ≈2.69 (the *converged* PBE+PAW answer-key), the
  gate should flip against THAT anchor, not 4.376. If they land at ~1.15 still, the residual is
  the genuine ground-state-engine wall and the hybrid path stays production.
- cost = $0 (0-pod, design/research only).
