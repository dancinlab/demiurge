# LIMIT_BREAKTHROUGH.md — hexa-bio

> Real-limits audit (Wave M) per `LATTICE_POLICY.md §1.2`.
> Domain: **cellular / molecular biology** — enzyme kinetics, DNA fidelity,
> protein folding, ribosome rate, viral capsid assembly, ATP economy.
> Honest scope: this audit asks *which physical/biochemical/engineering
> ceilings hexa-bio's 5-axis sandbox actually rides against*, separates
> HARD walls (biochemistry-forbidden) from SOFT/BREAKABLE engineering
> walls, and refuses lattice-tautology evidence for any of them.

---

## §1 Domain identification

`hexa-bio` exposes a 5-axis molecular toolkit:

- **WEAVE** — Caspar-Klug + Zlotnick cage-assembly ODE (viral capsids).
- **NANOBOT** — synthetic molecular machines / DNA origami.
- **RIBOZYME** — catalytic RNA / engineered ribozymes.
- **VIROCAPSID** — viral-vector design (AAV / phage scaffolds).
- **QUANTUM** — VQE compute bridge (H₂, LiH; pocket-VQE F-Q-6 open).

The repository is **in-silico simulator + falsifier preregister**, with
explicit honest-caveat that C2 PASS is internal-consistency only and
that wet-lab / IND / Phase-I are out-of-repo. The real ceilings below
operate at the boundary where a simulator's claims would have to land
to translate into wet-lab predictions — that is where this audit lives.

---

## §2 Real limits applicable

Six entries spanning math / biochem / engineering:

### L1 — DNA replication fidelity (HARD_WALL)
- **Bound**: per-base error ≈ 10⁻⁹ – 10⁻¹⁰ with polymerase proofreading
  + mismatch repair (Kunkel & Bebenek, *Annu. Rev. Biochem.* 2000).
- **Anchor**: thermodynamic discrimination of correct vs. incorrect
  base pair is bounded by ΔG ≈ a few kT at 310 K — Hopfield kinetic
  proofreading (PNAS 1974) shows you cannot beat this without paying
  ATP, and even with proofreading the floor is set by polymerase
  active-site geometry.

### L2 — Enzyme diffusion-limited k_cat/K_M (HARD_WALL)
- **Bound**: ~10⁸ – 10⁹ M⁻¹ s⁻¹ — the Smoluchowski diffusion encounter
  rate (Berg & von Hippel, *Annu. Rev. Biophys.* 1985).
- **Anchor**: collision theory. Triosephosphate isomerase, catalase,
  and acetylcholinesterase already sit at this ceiling; no engineering
  trick beats it without changing solvent or removing diffusion.

### L3 — Ribosomal translation rate (HARD_WALL with engineering jitter)
- **Bound**: 10–20 amino acids/sec in *E. coli*, ≈ 5 aa/s in eukaryotes
  (Bremer & Dennis, *EcoSal Plus* 2008).
- **Anchor**: GTP hydrolysis kinetics + tRNA accommodation. Cannot be
  pushed above ~22 aa/s without losing accuracy (~1 in 10⁴ misincorp).

### L4 — Protein-folding Kolmogorov / Levinthal (UNCLEAR → BREAKABLE_WITH_TECH)
- **Bound**: Levinthal paradox — a 100-residue chain has ~10⁶⁰
  conformations; brute-force impossible. **Real** folding solved on
  ms–s timescale via energy-landscape funneling (Dill & Chan, *Nat.
  Struct. Biol.* 1997).
- **Anchor**: AlphaFold2 (Jumper et al., *Nature* 2021) demonstrated
  a *learned* approximation hits ~Å RMSD for monomers — engineering
  broke the *practical* wall but the *physical* folding kinetics wall
  is untouched (mis-folding diseases still happen).

### L5 — Caspar-Klug / Zlotnick capsid assembly thermodynamics (HARD_WALL)
- **Bound**: capsid nucleation / elongation ΔG ≈ −6 to −10 kT per
  subunit; T-number geometry restricts capsid icosahedral classes
  (Caspar & Klug, *Cold Spring Harb. Symp.* 1962; Zlotnick, *J. Mol.
  Recognit.* 2005).
- **Anchor**: directly drives hexa-bio's WEAVE σ(6)=12 STRUCTURAL-EXACT
  audit — the lattice number happens to coincide with the Caspar-Klug
  quasi-equivalence count for T=1 capsids. *This is allowed
  (§3.1 native-invariant when used as geometric vocabulary)*; what is
  not allowed is using σ(6)=12 PASS as a wet-lab claim.

### L6 — Drug discovery cost / FDA attrition (SOFT_WALL / engineering)
- **Bound**: ~$2.6B per approved drug (DiMasi et al., *J. Health Econ.*
  2016), Phase I→approval ≈ 9.6 % (Wong et al., *Biostatistics* 2019),
  oncology ≈ 5.1 %.
- **Anchor**: pure pipeline-engineering wall; **breakable** by
  cell-based screens, AI-assisted target validation, organoid
  pre-clinical models. Repo's CANCER-THERAPY.md and CRISPR specs
  ride this wall.

### L7 — ATP cost of macromolecular synthesis (HARD_WALL — thermodynamic floor)
- **Bound**: ≈ 4 ATP/peptide-bond (1 for charging, 1 for GTP·EF-Tu,
  2 for GTP·EF-G + initiation amortised); 25–30 ATP/nt for
  transcription/replication when proofreading is included.
- **Anchor**: ATP hydrolysis ΔG ≈ −30.5 kJ/mol (Alberts *MBoC* 6e).
  Synthetic life cannot duck this without redesigning the genetic
  code itself.

### L8 — CRISPR-Cas off-target specificity (BREAKABLE_WITH_TECH)
- **Bound**: SpCas9 off-target rate ~10⁻³ – 10⁻⁵ per locus (Tsai et
  al., *Nat. Biotechnol.* 2015); base-editor / prime-editor reduce
  this 10–100× (Anzalone et al., *Nature* 2019).
- **Anchor**: ride for hexa-bio's CRISPR-CAS13-POC-DIAGNOSTIC and
  CRISPR-GENE-EDITING specs. Engineering improvable — high-fidelity
  Cas variants (eSpCas9, HiFi-Cas9) shave another order; the floor
  is set by PAM degeneracy + DNA mismatch tolerance.

---

## §3 Per-limit breakthrough assessment

| ID | Limit | Wall type | hexa-bio touches it via | Breakthrough vector | Honest verdict |
|----|-------|-----------|-------------------------|---------------------|----------------|
| L1 | DNA fidelity 10⁻⁹/base | HARD | virocapsid vector design, base-editing specs | None (biochemistry-forbidden); can only redistribute errors | unbreakable |
| L2 | k_cat/K_M ≤ 10⁹ M⁻¹s⁻¹ | HARD | ribozyme axis k_cat targets | None; only change solvent / enzyme channeling (e.g., metabolons) | unbreakable in dilute aqueous |
| L3 | 5–20 aa/s translation | HARD | quantum-VQE→ribozyme bridge claims | Cell-free systems can hit 30 aa/s with reduced accuracy | tight wall, ~1.5× headroom |
| L4 | Levinthal / Kolmogorov fold | UNCLEAR→ BREAKABLE | weave / virocapsid de-novo design | AlphaFold-class ML; *practical* wall broken, *physical* not | ML-broken; physics intact |
| L5 | Caspar-Klug T-number / Zlotnick ΔG | HARD | WEAVE σ(6)=12 audit | None; geometry is fixed | unbreakable (and aligns w/ n=6 vocabulary) |
| L6 | $2.6B / drug, 10 % Phase-I→approval | SOFT | CANCER-THERAPY, BIO-PHARMA specs | Organoids, AI target ID, decentralized trials | improvable 3–5× |
| L7 | 4 ATP/peptide-bond | HARD | all bio axes | None | unbreakable |
| L8 | CRISPR off-target 10⁻³–10⁻⁵ | BREAKABLE | CRISPR specs | Prime editor, base editor, structural HiFi variants | improvable 10–100× |

---

## §4 Top-3 breakthrough opportunities

### #1 — Organoid + AI-screen pipeline (rides L6, L4-practical)
Reduce Phase-I attrition by replacing the murine→primate→human
translation chain with iPSC-derived organoid screens validated by
AlphaFold-class structure prediction. Realistic 3–5× improvement
in pre-clinical→IND survival; **does not** touch HARD walls L1–L3,
L5, L7. Repo touchpoint: CANCER-THERAPY.md, BIO-PHARMA.md.

### #2 — High-fidelity CRISPR + base-editor scaffolds (rides L8)
Prime-editing for in-tree CRISPR-GENE-EDITING.md spec. Engineering
improvable 10–100× off-target reduction; physical floor still
governed by L1 (mismatch ΔG). Realistic deliverable: spec-level
constraint that any hexa-bio CRISPR claim must be ≤ 10⁻⁵
off-target before C3 (wet-lab) escalation.

### #3 — Capsid assembly empirical sandbox at thermodynamic floor (rides L5)
hexa-bio's WEAVE axis already encodes Zlotnick ΔG — the breakthrough
is *not* beating L5 but using L5 as a **verification anchor** so any
designed VLP / AAV / phage capsid in the repo must satisfy
ΔG_subunit ∈ [−10, −6] kT before being declared structurally valid.
This makes σ(6)=12 a *geometric* check, not an evidentiary one.

---

## §5 Honest caveats

1. **The C2 PASS gate is not therapeutic evidence.** Repo README is
   explicit on this. Every L1–L8 anchor in this audit applies only
   to simulator/metadata internal consistency; wet-lab predictions
   are not made.
2. **σ(6)=12 is a geometric coincidence with Caspar-Klug T=1, not
   evidence for the lattice.** Using it as a *vocabulary* for capsid
   audits is allowed (§3.1 native-invariant); using it as a *claim*
   about therapeutic efficacy is forbidden (§1.2 violation).
3. **AlphaFold did not "solve protein folding."** It learned a
   monomer-structure regression. Multimers, IDPs, conformational
   ensembles, and folding *kinetics* remain open. Mis-folding
   diseases (prion, Alzheimer's β-amyloid) still happen.
4. **CRISPR off-target reductions are population-level statistics,
   not per-patient safety.** Spec-level claim must include 95 % CI
   per-locus, not aggregate enrichment ratio.
5. **The HARD walls (L1, L2, L5, L7) are biochemistry-forbidden.**
   Any spec in the repo that claims to "break" them is a falsifier
   trigger, not a breakthrough.
6. **VQE quantum bridge (axis 5) currently lands at H₂ / LiH
   chemical-spectroscopic accuracy.** Pocket-VQE (drug-target
   binding pocket) F-Q-6 is open and is the realistic next gate;
   "VQE solves drug discovery" is over-claim until F-Q-6 PASSes.
7. **In-silico cage-assembly ODE posterior 0.97 is internal
   consistency.** It is not a probability of wet-lab assembly.

---

## §6 References

- Kunkel TA, Bebenek K. DNA replication fidelity. *Annu. Rev. Biochem.*
  69:497–529 (2000). PMID 10966467.
- Hopfield JJ. Kinetic proofreading. *PNAS* 71(10):4135–9 (1974).
- Berg OG, von Hippel PH. Diffusion-controlled macromolecular
  interactions. *Annu. Rev. Biophys.* 14:131–60 (1985). PMID 3890878.
- Bremer H, Dennis PP. Modulation of chemical composition and other
  parameters of the cell by growth rate. *EcoSal Plus* 3 (2008).
- Dill KA, Chan HS. From Levinthal to pathways to funnels. *Nat.
  Struct. Biol.* 4:10–9 (1997). PMID 8989315.
- Jumper J et al. Highly accurate protein structure prediction with
  AlphaFold. *Nature* 596:583–9 (2021). doi:10.1038/s41586-021-03819-2.
- Caspar DLD, Klug A. Physical principles in the construction of
  regular viruses. *Cold Spring Harb. Symp. Quant. Biol.* 27:1–24
  (1962).
- Zlotnick A. Theoretical aspects of virus capsid assembly. *J. Mol.
  Recognit.* 18:479–90 (2005). PMID 16193532.
- DiMasi JA et al. Innovation in the pharmaceutical industry: new
  estimates of R&D costs. *J. Health Econ.* 47:20–33 (2016).
- Wong CH, Siah KW, Lo AW. Estimation of clinical trial success
  rates. *Biostatistics* 20:273–86 (2019). doi:10.1093/biostatistics/kxx069.
- Tsai SQ et al. GUIDE-seq enables genome-wide profiling of off-target
  cleavage by CRISPR-Cas nucleases. *Nat. Biotechnol.* 33:187–97 (2015).
- Anzalone AV et al. Search-and-replace genome editing without
  double-strand breaks or donor DNA. *Nature* 576:149–57 (2019).
- Alberts B et al. *Molecular Biology of the Cell* 6e (2014), Ch. 2
  for ATP economy.

---

*Wave M — real-limits audit; no n=6 lattice anchor used as evidence.*
*HARD walls L1, L2, L5, L7 are biochemistry-forbidden and cannot be
broken by simulator improvements alone.*
