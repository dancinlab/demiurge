# RTSC AMBIENT-ROOM-T — Exotic / Beyond-BCS Mechanism Survey (d2 breakthrough-paths lens)

🧊 RTSC · 상압-상온 비-phonon 기전 서베이 · alias "the 293K@1atm wall, exotic-glue edition"

> GOAL: arxiv-grounded survey of NON-phonon / beyond-BCS mechanisms that could *in principle*
> give Tc≥293K at 1 atm, since conventional el-ph at ambient is family-capped ≪293K
> (Gao–Marques–Errea 2025: attainable conventional ambient ceiling ~100–120K).
> Scored against `../ROOMT_AMBIENT_PASS_CRITERIA.md` (T-1 #4 = Tc≥293K@1atm is the bottleneck).
> NO hype — most routes are unrealized; this file says so explicitly (d6).

---

## 0. The wall being attacked

`ROOMT_AMBIENT_PASS_CRITERIA` T-1 #4 (Tc≥293K @ 1 atm) is the decisive bottleneck. Our own
off-diagonal bond family caps ~40–80K. Conventional el-ph at ambient is now *quantitatively*
bounded: **Gao, Marques & Errea, Nat. Commun. (2025)** — the Tc-maximizing α²F(ω) is
"physically unattainable" because λ and ω_log are coupled, and high-λ compounds destabilize the
lattice → attainable ambient conventional ceiling **~100–120K** (best candidate Li₂AuH₆/Li₂AgH₆
~91–116K but thermodynamically unstable, 0.172 eV/atom above hull). So the question: does ANY
beyond-BCS mechanism leave a credible (even unrealized) door to 293K at 1 atm?

---

## 1. MECHANISM SCOREBOARD — ambient (1 atm) Tc ceiling each

| # | Mechanism | Best real / proposed material | **Demonstrated ambient Tc** | **Credible ambient ceiling** | In-principle 293K@1atm? | Gate that blocks 293K (PASS-CRITERIA) |
|---|---|---|---|---|---|---|
| 1 | **Cuprate / nickelate magnetic glue** (d-wave, AFM spin-fluct) | Hg-1223 (cuprate); (La,Pr)₃Ni₂O₇ film | **134K** (Hg-1223); ~45K onset / ~9K coherent (bilayer nickelate film); ~15K (infinite-layer) | **~134K**, optimistically ~160–200K | **No** | T-1 #4. Tc/J ≈ 0.04–0.07 intrinsic bound (arXiv:2402.07128); 293K needs J≈400–700 meV (~2× cuprate, unphysical). Trilayer optimum + charge-order + pseudogap |
| 2 | **Excitonic / electronic glue** (Little, Ginzburg, polar metals) | none realized; doped SrTiO₃ / KTaO₃ interface (polar metals) | **0** (excitonic); ~0.4K (STO), ~2.9K (KTaO₃) — and likely soft-PHONON not electronic | demonstrated 0; theoretical ~2000K (Little) | **In principle YES, but 0 realized in 60yr** | T-1 #4 + #3/#5. Retardation paradox: eV scale = no retardation = Coulomb repulsion not screened away; 1D Peierls/CDW; Ginzburg = 2nd-order surface-only |
| 3 | **Flat-band / quantum-geometric** | MATBG; CsV₃Sb₅ kagome | **~1–3K** (MATBG, AV₃Sb₅) | **tens-of-K** at most (Tc ∝ U × quantum-metric) | **No** | T-1 #4 + #5. 2026 no-go (arXiv:2604.04719): geometric D_s is NOT a Tc predictor (tracks topology, not pairing). U bounded ~few eV; CDW/magnetism/Wigner pre-empt; isolation bound |
| 4 | **Bipolaron / BEC** (light/SSH bipolaron) | bond-SSH model; ?FeSe analog | (model) ~1–3K class | **~20–70K** (QMC-grade Tc/Ω≈0.2–0.3); ~200K only in one unreproduced parametric estimate | **No** (one disputed claim) | T-1 #4. mass–Tc tension survives off-diagonal escape; needs t~Ω + Ω≳1000K simultaneously; density/non-overlap; phase separation |
| 5 | **Metallic-hydrogen-like** (atomic/molecular H) | atomic H (McMahon–Ceperley) | **0 at ambient** | ~356–481K *predicted* — **but only at 400–700 GPa** | **YES — the only one** | T-1 #1/#2 (stability). Forms only at 400–700 GPa; ambient metastability (~1 eV barrier) NEVER demonstrated; 2017 Dias–Silvera claim disputed/sample lost |
| — | **Conventional el-ph** (baseline, for reference) | MgB₂; Mg₂IrH₆ (metastable pred.) | **39K** (MgB₂) | **~100–160K** (metastable hydride predictions, unsynthesized) | No | T-1 #1/#4. Gao–Marques–Errea ~100–120K wall; λ↔ω_log trade-off + ambient instability |

**Retracted / debunked (NOT established, listed for honesty):** CSH (Dias 2020, 288K@267GPa —
RETRACTED 2022, and never ambient); LK-99 (2023, claimed ambient 293K — DEBUNKED, Cu₂S artifact,
pure phase is an insulator).

---

## 2. Per-mechanism honest detail

### 1 — Cuprate / nickelate magnetic glue
- d-wave pairing glued by AFM spin fluctuations; near-linear J–Tc relation. Hg-1223 STM gap
  Δ~98 meV ≈ superexchange J → authors exclude phonons (npj Quantum Mater. 2025).
- **Design routes FAIL to clear 134K:** epitaxial strain only moves within-family from baseline
  (LSCO 25→49K; YBCO ~0.75K/%), never past the family record. Layering ceiling = **3 CuO₂ planes**
  (Tc *decreases* for n≥4; inner-plane doping/screening degrades). 30 GPa pressure → ~164K, but
  that gain is exactly what ambient strain cannot stably recover.
- Nickelates: ambient SC now *exists* (strain/thin-film substitutes for pressure) but recovers only
  ~half the ~80K pressurized value, with film disorder dragging coherent Tc to ~9K; smaller J than
  cuprates → ceiling *below* cuprates.
- **Decider:** Tc/J ≈ 0.04–0.07 (arXiv:2402.07128) → families have nearly exhausted Tc given their J;
  293K needs unphysical J. arXiv's own answer to room-T magnetic glue: "probably no."

### 2 — Excitonic / electronic glue
- Little (1964): polymer + polarizable side chains, exciton glue, eV scale → Tc up to ~2200K *predicted*.
  Never realized in 60 yr. Killers: **no retardation** (excitons as fast as pairing electrons → bare
  Coulomb repulsion not averaged away, stays repulsive) + 1D Peierls/CDW + disorder.
- Ginzburg sandwich: interfacial attraction is 2nd-order, confined to ~1 interatomic distance →
  diluted to undetectability for any practical film (cond-mat/9912180: "not realized until now").
- Polar metals (the only REAL ambient materials here): doped SrTiO₃ ~0.4K, KTaO₃ interface ~2.9K —
  and best evidence says **soft-phonon**, not electronic glue (PNAS 2016). Anderson–Blount irony: a
  polar metal exists *because* electrons decouple from the polar mode — fatal for SC glue.
- Modern (moiré plasmon TBG, exciton condensates): all electronic-glue SC claims are THEORETICAL;
  realized exciton condensates are **neutral superfluids, not charged superconductors**.

### 3 — Flat-band / quantum-geometric (our own FB-GEOM lens bounds this)
- Verified mechanism: Peotta–Törmä (D_s from quantum metric, D_s≥|C|); Verma–Hazra–Randeria
  upper bound Tc ≤ (π/8)D_s, D_s ≲ n(1−n)|U|·⟨metric/spread⟩ → **Tc ∝ |U|** in isolated flat band
  (confirmed by QMC/DMRG/DMFT). Real materials: MATBG ~1–3K, AV₃Sb₅ ~2.5K (CDW at 94K pre-empts).
- **2026 no-go (arXiv:2604.04719, Zhou — VERIFIED exists, submitted 6 Apr 2026):** geometric D_s
  is NOT a universal Tc predictor — it tracks single-particle band topology, not pairing strength.
  Two-channel phonon+spin-fluct Allen-Dynes fits 19 SCs (0.4–250K) at R²=0.96 with **no geometric
  term**. High Tc = pairing physics, not geometry. The no-go forbids *geometry-as-Tc-knob*, not
  flat-band SC per se.
- **Door the no-go leaves open (narrow, unrealized):** strong CONVENTIONAL pairing (phonon/spin-fluct)
  + large quantum metric for stiffness + isolated flat band + suppressed competing order. Geometry
  then supplies *coherence*, not the *gap*. So the RT question reduces to the conventional strong-glue
  question — flat-band geometry is NOT an independent road to room-T.

### 4 — Bipolaron / BEC
- Fundamental tension (Chakraverty–Ranninger–Feinberg): strong e-ph coupling binds the pair but makes
  it heavy (self-trapping) → Tc_BEC ∝ n^(2/3)/m* crushed. This is the load-bearing wall.
- Alexandrov superlight (Coulomb–Fröhlich, cond-mat/0701412): intersite "crab-like" tunneling →
  mass ∝ polaron mass (linear, not exponential) → claims **~200K / "above room-T."** Honest read:
  *parametric/analytical only*, leans on favorable density + 80 meV phonon; NOT a controlled
  many-body result, and NOT reproduced.
- **Rigorous QMC (Zhang–Prokof'ev–Svistunov, PRX 2023; perspective arXiv:2605.16625):** bond/SSH
  coupling → Tc/Ω ≈ 0.2–0.3 (peak at t/Ω≈1–2), beats Migdal-Eliashberg bound but → **~20–40K**
  (3D+Coulomb ~20K); explicitly "does not reach room temperature."
- Off-diagonal (SSH/bond) IS the real escape from self-trapping (light mobile pairs), but ceiling
  ~70K only "if the unusual limit t~Ω is achieved." 293K needs Ω≳1000–1500K AND t~Ω simultaneously
  — no real ambient lattice provides this. **Confirms our prior session's tens-of-K cap.**

### 5 — Metallic-hydrogen-like (the only in-principle ≥293K path)
- Atomic metallic H (McMahon–Ceperley): predicted Tc ~356K@500GPa → ~481K@700GPa. Molecular metallic
  H also near room-T (Cudazzo PRL 2008). This is the ONE system whose *predicted* Tc exceeds 293K.
- Ambient hope = a predicted ~1 eV metastability barrier letting it survive decompression. **Unproven.**
  2017 Dias–Silvera Wigner-Huntington claim is disputed (pressure calibration, reflectivity-only, no
  conductivity, sample LOST). No reproducible synthesis; ambient metastability never demonstrated.
- Chemical pre-compression (Ashcroft) lowers the stabilizing pressure (clathrates, H₃S, ternaries) and
  2024–26 theory reaches ~100–160K ambient *predictions* (Mg₂IrH₆ ~160K, RbPH₃ ~100K via anharmonicity)
  — all metastable/unsynthesized, none at 293K. Trade-off is rigid: enough pre-compression for a
  293K-class H network = a structure no longer stable at 1 atm.

---

## 3. THEORETICAL UPPER-BOUND landscape (the honest ceiling)

- **Fundamental-constants bound** (Trachenko–Monserrat–Hutcheon–Pickard 2025, arXiv:2406.08129):
  fundamental constants cap the highest phonon ω → Tc at order **10²–10³ K**. Room-T is *possible in
  principle* but sits near the top; does NOT distinguish pressure.
- **Ambient-specific bound** (Gao–Marques–Errea 2025): attainable **conventional ambient ceiling
  ~100–120K** — the binding wall is STABILITY, not the constants.
- **Phonon-mediated heuristics** (Moussa–Cohen 2006; Semenok 2025): λ cannot be pushed arbitrarily
  without lattice instability.
- **Magnetic-glue bound** (arXiv:2402.07128): Tc/J ≈ 0.04–0.07 → unconventional families near-exhausted.
- **Flat-band no-go** (arXiv:2604.04719): geometry buys coherence, not pairing.

Synthesis: the *universe* permits ~100–1000K phonon-mediated Tc, but at 1 atm the attainable ceiling
collapses to ~100–160K for every chemistry where stability is required. Every door to >160K@1atm
hinges on metallic-hydrogen-like metastability — unproven.

---

## 4. DEPLETION TEST

**Mechanism scoreboard ambient Tc ceilings (one line):**
metallic-H ~356–481K *predicted but only @≥400 GPa, 0 at ambient* ▸ cuprate/nickelate ~134K (demonstrated ambient record) ▸ conventional el-ph hydride ~100–160K (metastable predictions) ▸ bipolaron/BEC ~20–70K (one unreproduced ~200K claim) ▸ flat-band/geometric tens-of-K (1–3K demonstrated) ▸ excitonic 0 realized (~2000K paper-only). **No DEMONSTRATED ambient material exceeds 134K.**

**Single most-promising open mechanism for ambient room-T:**
**Metallic-hydrogen-like (atomic/molecular hydrogen), via chemical pre-compression toward ambient
metastability** — the ONLY mechanism with an in-principle ≥293K Tc. All others are intrinsically
capped below 293K at 1 atm by named theory bounds (Tc/J, geometric no-go, mass–Tc tension,
retardation paradox, Gao–Marques–Errea conventional ceiling).

**Its single deciding theoretical question:**
> Can a hydrogen-rich, strongly-coupled (metallic-hydrogen-like) phase be made **dynamically AND
> thermodynamically metastable at 1 atm** — does a real chemistry retain the high-ω, high-λ hydrogen
> network after decompression, or does the λ↔stability trade-off forbid it for *every* chemistry?
> (Equivalently: is the ~1 eV ambient metastability barrier of metallic hydrogen real, and is the
> ~100–120K Gao–Marques–Errea conventional ambient ceiling a true wall for all el-ph chemistry?)

---

## 5. VERDICT (d6, no hype)

- **Highest credible ambient-room-T potential: metallic-hydrogen-like** — and it is the ONLY mechanism
  with an in-principle 293K@1atm path. Even it is **unproven at ambient** (forms at 400–700 GPa; ambient
  metastability never demonstrated; 2017 synthesis claim disputed & sample lost).
- **All other known mechanisms cap below 293K at 1 atm:** cuprate/nickelate ≤~134–200K (J-bound),
  flat-band/geometric tens-of-K (no-go: geometry isn't the Tc knob), bipolaron-BEC ~20–70K (mass–Tc
  tension persists), excitonic 0-realized (retardation paradox, 60yr unrealized).
- **Pass-criteria mapping:** every non-hydrogen mechanism FAILS T-1 #4 (Tc≥293K@1atm) by an intrinsic,
  named theory bound — not a mere engineering gap. Metallic-H FAILS T-1 #1/#2 (1-atm thermodynamic +
  dynamic stability), not #4.
- **Net (matches the closing formula in `../RTSC_DISCOVERY_CLOSING_FORMULA.md`):** at 1 atm, conventional
  + every beyond-BCS glue is structurally capped well below room-T; the sole in-principle escape is
  metallic-hydrogen-like metastability, which is **unproven**. The two CSH/LK-99 ambient-293K headlines
  are retracted/debunked. There is currently NO established ambient-293K superconductor and NO mechanism
  with a *credible demonstrated* (vs in-principle-only) ambient-293K path.

---

### Key citations
- Gao, Marques, Errea — Maximum Tc of conventional SC at ambient pressure, Nat. Commun. 2025 (arXiv via nature s41467-025-63702-w)
- arXiv:2402.07128 — intrinsic Tc/J ≈ 0.04–0.07 magnetic-glue bound
- arXiv:2604.04719 — Zhou, two-channel Allen-Dynes + quantum-metric no-go (2026)
- Peotta–Törmä, Nat. Commun. 2015 (1506.02815); Verma–Hazra–Randeria PNAS 2021 (2103.08540)
- Zhang et al. PRX 13, 011010 (2023) (2203.07380); perspective arXiv:2605.16625 — bond-bipolaron QMC
- Alexandrov, cond-mat/0701412 — superlight bipolaron ~200K (parametric, unreproduced)
- Little cond-mat/0408212; Ginzburg cond-mat/9912180 — excitonic, unrealized
- Trachenko et al. arXiv:2406.08129 — fundamental-constants Tc bound; Moussa–Cohen cond-mat/0607832
- Dolui et al. PRL 132, 166001 (2024) — Mg₂IrH₆ ~160K metastable; RbPH₃ ScienceDirect 2025
- McMahon–Ceperley — atomic metallic H ~356–481K@500–700GPa; Dias–Silvera Science 2017 (disputed, 1702.05125)
- CSH retraction Nature 2022 (s41586-022-05294-9); LK-99 debunk PMC10633996 (Cu₂S artifact)
