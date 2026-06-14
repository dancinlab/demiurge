> 📍 SSOT: [ARCHITECTURE.md](ARCHITECTURE.md) · governance [CLAUDE.md](CLAUDE.md)

# 🧬 AlphaFold vs hexa-bio — "the world's structure-prediction oracle" vs "a 5-axis in-silico molecular-design substrate"

> Comprehensive, **honest** head-to-head of **AlphaFold 3** (DeepMind/Isomorphic Labs, Abramson et al., *Nature* 2024 — the de-facto reference for biomolecular structure prediction) against **hexa-bio** — which is **two complementary surfaces**: (1) the `stdlib/bio` + `stdlib/chem` + `stdlib/protein-fold` family inside hexa-lang, driven by demiurge's CURE/RX domains; **and (2) the standalone `~/core/hexa-bio/` substrate repo** — a **5-axis molecular toolkit** (QUANTUM · WEAVE · NANOBOT · RIBOZYME · VIROCAPSID) on the n=6 invariant lattice (`dancinlab/hexa-bio` v1.0.0, registry L24). *The prior revision of this doc looked only at the protein-fold/`stdlib` surface and entirely missed surface (2) — this revision adds it.*
>
> Every hexa-bio capability below is tier-classified ✅ IMPLEMENTED+VERIFIED / 🟡 IN-SILICO SIMULATOR / ⚪ ASPIRATIONAL with its evidence (selftest · g5 · verdict · export). Where AF3 leads, it is conceded plainly (d6 / @L5 / g5). **No capability is claimed to surpass AF3 unless a real, verified measurement backs it — and every hexa-bio "win" is scoped to IN-SILICO simulator-consistency, NEVER a wet-lab / clinical / efficacy claim.**

> **⚠ Scope-honesty banner (carried verbatim from `~/core/hexa-bio/README.md` + `AXIS.tape`):** *"All 5 axes (synthetic biology / CRISPR / virocapsid / ribozyme catalysis / pocket VQE) are scientifically UNPROVEN at the wet-lab boundary — closure here is software-bookkeeping, never a medical or empirical claim."* A `PASS`/`HOLD` verdict (incl. the 16-cell C2 matrix) verifies **in-silico simulator + metadata internal consistency ONLY** — it is **NOT** therapeutic, clinical, regulatory, immunogenic, or efficacy progress. C3+ (wet-lab → IND → phase I) is explicitly out-of-repo.

- **하는 일 (AF3)**: amino-acid sequence (+ DNA/RNA/ligand/ion) → **3D atomic coordinates** of the folded complex, with per-atom confidence (pLDDT/PAE) — **one stage**, structure-prediction, **wet-lab-accurate**
- **하는 일 (hexa-bio)**: (a) a **7-verb design pipeline** (spec → structure → design → analyze → synthesize → verify → handoff) that *consumes* a structure (often an AlphaFold one) and runs **docking · MD · binding free-energy (FEP/ABFE)** toward a drug-candidate verdict; **and (b) a 5-modality molecular substrate** — composition (WEAVE) · actuation (NANOBOT) · catalysis (RIBOZYME) · assembly (VIROCAPSID) · computation (QUANTUM VQE) — each an **in-silico simulator** with a falsifier preregister + σ(6)=12 verification
- **비유**: AF3 = the **camera** that photographs a molecule's shape · hexa-bio = the **CAD+simulation+verification studio** with **five molecular workshops** (not one), that takes the photo and engineers a drug around it
- **비교 축**: AF3 is *one structure-prediction model* (deep, mature, wet-lab-accurate). hexa-bio is a *broad 5-axis in-silico design substrate* (wide scope, internally consistent, **wet-lab-UNVERIFIED**). They overlap only at the structure boundary — and **at that boundary, on real-world accuracy, AF3 wins**.

---

## TL;DR — 5-axis verdict

```
                          AlphaFold 3            │  hexa-bio (best tier)
 ─────────────────────────────────────────────── ┼ ───────────────────────────────────
 STRUCTURE  de-novo fold accuracy. State-of-art   │  ⚪/🟡 NO learned fold engine.
 PREDICTION diffusion model, PoseBuster +50% vs   │  protein-fold = 7-verb STUB
 (accuracy) docking, PDB-scale training,          │  (absorbed=false). CONSUMES AF
            WET-LAB-validated.                     │  PDBs as INPUT. ◀ BEHIND
            ▶ AF3 WINS — decisively.              │
 ─────────────────────────────────────────────── ┼ ───────────────────────────────────
 SCOPE      structure of complexes only           │  ✅/🟡 docking + MD + FEP +
 (pipeline) (protein·DNA·RNA·ligand·ion·          │  7-verb pipeline END-TO-END
            covalent). ONE stage.                  │  (spec→handoff).
            ▶ narrow-but-deep                     │  ▶ hexa-bio WINS on breadth
 ─────────────────────────────────────────────── ┼ ───────────────────────────────────
 MODALITY   structure-prediction ONLY — not a      │  🟡 5-AXIS substrate: WEAVE ·
 BREADTH    molecular-design substrate; one        │  NANOBOT · RIBOZYME · VIROCAPSID
 (5 axes)   modality.                              │  · QUANTUM-VQE (+19 expansion).
            ▶ AF3 does NOT occupy this            │  ▶ hexa-bio WINS breadth (in-silico)
 ─────────────────────────────────────────────── ┼ ───────────────────────────────────
 QUANTITATIVE NOT a binding-affinity predictor     │  ✅ REAL converged ABFE
 AFFINITY    (structure + confidence only;         │  (ΔG=−16.64±0.49 kcal/mol,
 (ΔG/ΔΔG)    Abramson §limitations).               │  SENOLYX R10b) + Vina + MM-GBSA.
            ▶ AF3 does NOT do this                │  ▶ hexa-bio WINS (different job)
 ─────────────────────────────────────────────── ┼ ───────────────────────────────────
 AI-NATIVE  diffusion net IS differentiable, but   │  ✅ stdlib/autograd + flame ML
 DIFFER-    weights are closed/server-gated; the   │  stack present & native; bio
 ENTIABLE   PIPELINE is not user-composable.       │  pipeline gradient end-to-end =
            ▶ model yes, stack no                  │  🟡 not yet wired. ▶ PARITY/🟡
```

> **Scope is the headline asymmetry.** AF3 is **one** modality (structure prediction), **wet-lab-validated** to state-of-the-art accuracy. hexa-bio is **five** in-silico molecular modalities (+19 expansion sub-axes), **internally consistent but wet-lab-unverified**. hexa-bio wins on *breadth of scope*; AF3 wins on *depth + real-world accuracy* of its one axis. These are different victories — neither is "a better AlphaFold."

**Bottom line (3 honest headlines):**
1. **AF3 WINS — structure prediction, on real-world accuracy.** hexa-bio has **no learned fold network**; its `protein-fold` module is a 7-verb pipeline stub (`absorbed=false`) and its real pipelines *download AlphaFold PDBs as input* (e.g. `AF-Q8N474-F1-SFRP1.pdb` in AGA-RX). AF3 is Nature-published, server-deployed, and **wet-lab-accurate**; hexa-bio's axes are explicitly **wet-lab-UNVERIFIED**. This axis is not close.
2. **hexa-bio WINS — scope breadth, in-silico only.** AF3 occupies one modality. hexa-bio is a **5-axis molecular substrate** (composition · actuation · catalysis · assembly · quantum-VQE) plus a 7-verb pipeline with a real converged ABFE — a far wider footprint. **But the entire 5-axis breadth is IN-SILICO simulator-consistency, not therapeutic/empirical progress** (the C2 16/16 matrix verifies simulator+metadata internal consistency, nothing more).
3. **The real differentiator — a 5-axis, AI-native, verify-gated substrate vs. one oracle.** hexa-bio is one compose-able stack (`stdlib/autograd` + `flame` ML + `chem` + `bio` + the 5-axis `~/core/hexa-bio/` repo) with a g5/g8 honesty contract, whereas AF3 is a single closed-weight model behind a non-commercial server. Honest caveats: the *quantitative* ABFE wins ride partly on **external Python engines (OpenMM/openmmtools/openfe)**, and the *breadth* wins are **in-silico simulators with falsifier preregisters, not wet-lab assets** — reported below, not hidden.

---

## 1 · STRUCTURE PREDICTION — AF3 wins, decisively (conceded)

This is AF3's home turf and hexa-bio does **not** compete here. The honest accounting:

| Sub-capability | AlphaFold 3 | hexa-bio | Tier · evidence |
|----------------|-------------|----------|-----------------|
| De-novo protein fold (seq → 3D) | ✅ diffusion model, PDB-trained | ✗ none | ⚪ — `protein-fold/structure.hexa` prints `residues_target` + `absorbed=false` |
| Complex / multimer assembly | ✅ joint diffusion of all chains | ✗ | ⚪ |
| Per-residue confidence (pLDDT/PAE) | ✅ native output | ✗ | ⚪ |
| MSA / sequence alignment (a fold *input*) | ✅ Evoformer-fed MSA | 🟡 Smith-Waterman · Needleman-Wunsch · MSA | 🟡 `bio/seq_align/` (real algorithms, `*_test.hexa`) — alignment only, NOT a fold model |
| Uses AF structures | — (is the source) | ✅ as docking INPUT | ✅ `exports/AGA-RX/path-a-sfrp1/AF-Q8N474-F1-SFRP1.pdb` |

```
   AF3 pipeline                         hexa-bio's actual entry point
 ┌──────────────┐                      ┌────────────────────────────┐
 │ sequence     │                      │  AF-Q8N474-F1-SFRP1.pdb     │ ◀── an AlphaFold file
 │   ↓ Evoformer│                      │        ↓                    │
 │   ↓ diffusion│  ===> 3D structure   │   Vina dock · MD · FEP      │
 │ 3D structure │ ───────────────────▶ │        ↓                    │
 └──────────────┘   (hexa-bio CONSUMES │   drug-candidate verdict    │
                     this output)      └────────────────────────────┘
```

**Verdict: AF3 WINS.** hexa-bio's structure-prediction tier is ⚪ aspirational; it stands on AF3's shoulders rather than replacing it.

---

## 1.5 · hexa-bio = 5-axis molecular toolkit (beyond protein-fold) — the surface the prior revision missed

> **Source:** the standalone `~/core/hexa-bio/` substrate repo (`dancinlab/hexa-bio` v1.0.0, registry L24) — 59 directories · **5880 `.hexa` kernels** · 11,776 docs. README: *"**5-axis** molecular substrate organized around the **n=6 invariant lattice**."* This is a **different surface** from the `stdlib/bio` family the rest of this doc compares — and it is where hexa-bio's true scope-breadth lives. **It does NOT add structure-prediction accuracy; AF3's win in §1 stands.** Everything here is in-silico, falsifier-preregistered, wet-lab-UNVERIFIED.

**AF3 occupies exactly ONE of these five axes (structure → coordinates), and even there hexa-bio defers to AF3.** The other four are modalities AF3 has no equivalent for — *because AF3 is not a molecular-design substrate at all.* The breadth is real; the in-silico-only scope is the honest fence.

### 5-axis ASCII tree (AXIS.tape core-5 + expansion layer)

```
                       hexa-bio (~/core/hexa-bio/)  ── n=6 invariant lattice
                                     │  σ(6)=12 · τ(6)=4 · φ(6)=2 · J₂=24
            ┌────────────────────────┼────────────────────────┐
            │   CORE-5 (AXIS.tape SSOT — locked, in-silico)    │
            │                        │                         │
   ┌────────┴───────┐                │                 ┌───────┴────────┐
   │  WEAVE         │ composition    │                 │  VIROCAPSID    │ assembly
   │  ✅ IMPL+VERIF │ Caspar-Klug +  │                 │  🟡 SIMULATOR  │ VIPERdb n=527
   │  cage ODE,     │ Zlotnick ODE + │                 │  T-number disc │ T=1 exact;
   │  post 0.97     │ Bayes σ=12     │                 │  + Bayes audit │ T>1 candidate
   └────────────────┘                │                 └────────────────┘
   ┌────────────────┐                │                 ┌────────────────┐
   │  NANOBOT       │ actuation      │                 │  RIBOZYME      │ catalysis
   │  🟡 SIMULATOR  │ DNA-origami    │                 │  🟡 SIMULATOR  │ hammerhead
   │  4-state sim,  │ 4-state, J₂=24 │                 │  Eyring k_cat, │ Nussinov MFE
   │  C0b skeleton  │ work 50 kT     │                 │  off-target    │ + RIsearch2
   └────────────────┘                │                 └────────────────┘
                        ┌────────────┴────────────┐
                        │  QUANTUM (5th axis)      │ computation
                        │  🟡 SIMULATOR (Phase 1+) │ VQE via qmirror CLI
                        │  H₂ 0.4µHa / LiH path;   │ (no shadow .hexa) +
                        │  pocket-VQE F-Q-6 open   │ ML pilots (MPNN/Boltz-2)
                        └──────────────────────────┘
   ┌─────────────────────────────────────────────────────────────────────┐
   │  EXPANSION LAYER (AXIS/HIERARCHY.tape — NON-core, user-directed)      │
   │  4 expansion-MAIN: COVALENT · BIFUNCTIONAL · METALLODRUG ·           │
   │                    OLIGONUCLEOTIDE        (each ✅ IMPL+VERIF sim)    │
   │  15 sub-axes :> parent: PROTAC·LYTAC·AUTAC·RIBOTAC·COVALENT-DEGRADER· │
   │    MOLECULAR-GLUE (:>BIFUNC) · ALLOSTERIC·CRYPTIC-POCKET·PPI (:>QUANT)│
   │    · PEPTIDE·MACROCYCLE (:>WEAVE) · RNA-TARGETING-SM·APTAMER (:>RIBO) │
   │    · CAPSID-ASSEMBLY-MODULATOR (:>VIRO) · REVERSIBLE-COVALENT (:>COV) │
   │  TOTAL = 5 core + 4 main + 15 sub = 24 axes (architectural, not       │
   │          lattice-derived).  All 🟡 in-silico simulator-consistency.   │
   └─────────────────────────────────────────────────────────────────────┘
```

### Core-5 axis table (axis · role · tier · evidence)

| Axis | Role | What it actually does (in-silico) | Tier | Evidence (`~/core/hexa-bio/`) |
|------|------|-----------------------------------|------|-------------------------------|
| **WEAVE** | composition | Protein-cage / icosahedral self-assembly: Caspar-Klug quasi-equivalence + Zlotnick nucleation-elongation cage-assembly ODE + Bayesian σ(6)=12 STRUCTURAL-EXACT audit (T=1 60-subunit cage, **posterior 0.97**) | ✅ **IMPLEMENTED+VERIFIED** | `weave/module/weave.hexa` (`__HEXA_BIO_WEAVE__ PASS`) + `_python_bridge/.../cage_assembly_simulation.py` + `polyhedral_cage_bayesian_audit.py`; **the only axis with a full numerical empirical sandbox** |
| **VIROCAPSID** | assembly | Viral-capsid T-number discrimination over a **VIPERdb v3.0 corpus n=527** / 87 families / 15 T-strata (log10_BF 876.27, posterior 1.0) + Caspar-Klug + Zlotnick ODE; F-VIROCAPSID-1-c/1-d CLOSED in-repo | 🟡 **IN-SILICO SIMULATOR** (T=1 STRUCTURAL-EXACT via WEAVE; T>1 candidate) | `virocapsid/module/virocapsid.hexa` + `_python_bridge/.../virocapsid_pdb_corpus.py` + `viperdb_corpus_snapshot.json`; C5 schema lock + 4-fixture conformance |
| **RIBOZYME** | catalysis | Hammerhead 4-state kinetics (Eyring TST, k_cat≈0.6/min) + Nussinov MFE + Hamming off-target screen + **full GENCODE v47 pc-transcriptome screen via RIsearch2 v2.1**; J₂=\|S₄\|=24 quotient | 🟡 **IN-SILICO SIMULATOR** (12-nt core STRUCTURAL-EXACT-CANDIDATE, deductive PASS) | `ribozyme/module/ribozyme.hexa` + `kinetics_simulation.py` + `ribozyme_mfe_nussinov.py` + `ribozyme_off_target_screen.py`; F-RB-4 6/6 |
| **NANOBOT** | actuation | DNA-origami 4-state actuation sim (work 50 kT, J₂=24 pose-canon, no Brownian collapse), both truncated-icosahedron & cuboctahedron skeletons; thermal-noise floor kT=4.1 pN·nm real-limit | 🟡 **IN-SILICO SIMULATOR** (12-vertex C0b skeleton, STRUCTURAL-EXACT-CANDIDATE, deductive PASS) | `nanobot/module/nanobot.hexa` + `actuation_simulation.hexa` + `_python_bridge/.../nanobot_actuation_simulation.py`; N-R1/N-R2 reference emitters locked |
| **QUANTUM** | computation | Molecular VQE: H₂ (0.4 µHa) / LiH path (chemical/spectroscopic acc), Mpro pocket-VQE (sub-µHa vs CASCI), 5-warhead library ranking, ADAPT-VQE/UCCSD ladders up to 10-qubit 4e/6o — runs via the **`qmirror` CLI** (no shadow chemistry-VQE `.hexa` in hexa-bio by design) + ML pilots (ProteinMPNN/Boltz-2/RhoFold+ smokes) | 🟡 **IN-SILICO SIMULATOR** (Phase 1+; F-Q-1…5 PASS, **pocket-VQE F-Q-6 the open Phase-C gate**) | `quantum/module/quantum.hexa` + `external_pilot_runner.hexa` + `n6_lattice_check.hexa`; bridges `dancinlab/qmirror` v2.1.0 (ANU QRNG + Aer state-vector) |

### Expansion layer (NON-core, user-directed 2026-05-16 — brief)

| Layer | Members | Tier | Note |
|-------|---------|------|------|
| **Expansion-MAIN** (4) | COVALENT · BIFUNCTIONAL · METALLODRUG · OLIGONUCLEOTIDE | ✅ each IMPL+VERIF (`.hexa` module + deterministic real-limits Python sim + draft-07 schema, `hexa verify` 🟢 SUPPORTED-NUMERICAL) | own drug precedent (ibrutinib · PROTAC/ARV-471 · cisplatin · nusinersen), NOT lattice-fit |
| **Sub-axes** (15 :> parent) | PROTAC·LYTAC·AUTAC·RIBOTAC·COVALENT-DEGRADER·MOLECULAR-GLUE (:>BIFUNCTIONAL) · ALLOSTERIC·CRYPTIC-POCKET·PPI (:>QUANTUM) · PEPTIDE·MACROCYCLE (:>WEAVE) · RNA-TARGETING-SMALL-MOLECULE·APTAMER (:>RIBOZYME) · CAPSID-ASSEMBLY-MODULATOR (:>VIROCAPSID) · REVERSIBLE-COVALENT (:>COVALENT) | 🟡 each IN-SILICO SIMULATOR (Python sim + `.hexa` announce verb + schema + passing sentinel) | 17 cross-axis bridges (A1–A5·F1–F3·G1–G5·J1–J3 + 1 three-axis); 12 falsifiers HOLD; 32 sims DETERMINISTIC |
| **UNPLACED (honest)** | THERANOSTIC (CDER+CDRH mix) · GENETIC-MEDICINE (CBER) · ADC (CBER antibody) | ⚪ NOT code axes | scope-disqualified (drug-only/CDER criterion); implementing as code axes would breach the g8 in-silico fence |

> **24 axes total (5 core + 4 expansion-main + 15 sub)** — an **architectural** decision per `AXIS/README.md` §4 (the rigorous "keep-5" dissent is preserved verbatim; the expansion is a user-directed override). The count is **NOT derived from the n=6 lattice** (`f_lattice_fit` forbids derivation; lattice tokens are naming/observation only).

**Verdict (§1.5): hexa-bio's true scope is 5 modalities, not 1 — but the breadth is IN-SILICO.** AF3 has no analogue for actuation / catalysis / assembly / quantum-VQE design because AF3 is not a design substrate; on its own one axis (structure), AF3 is wet-lab-accurate and hexa-bio defers. hexa-bio's 5-axis breadth is a genuine, real-implemented (5880 `.hexa`, 35/35 selftest) substrate — whose every verdict is **simulator-consistency, never a medical/empirical claim**.

---

## 2 · SCOPE — the downstream design pipeline (hexa-bio's breadth)

Where AF3 is one stage (coordinates), hexa-bio is a **7-verb pipeline** (`specify · structure · design · analyze · synthesize · verify · handoff`) wrapping **a docking engine, an MD engine, and 28 therapeutic modalities**. Honest tiering:

| Capability | What it does | AF3 | hexa-bio | Tier · evidence |
|-----------|--------------|-----|----------|-----------------|
| **Ligand docking** | pose + score receptor×ligand | ✅ (structure of bound pose) | 🟡 AutoDock-Vina **5-term scoring port** | 🟡 `chem/vina/scoring.hexa` — *scoring only*; MC/BFGS search · grid maps · PDBQT IO all DEFERRED. Production runs call real Vina (AGA-RX) |
| **Molecular dynamics** | integrate atomic motion over time | ✗ (static only) | 🟡 Velocity-Verlet + LJ + Ewald + bonded | 🟡 `chem/md/` (real algorithms, `*_test.hexa`); PBC·PME·thermostat·trajectory-IO DEFERRED — not production-MD |
| **Cheminformatics** | SMILES · descriptors · PDB/SDF IO | ✗ | ✅ RDKit-subset + OpenBabel-free | ✅ `chem/rdkit_subset/` · `chem/babel_free/` (`*_test.hexa` green) |
| **Database access** | UniProt · PubChem · Entrez · BRENDA | ✗ | ✅ live clients | ✅ `bio/uniprot.hexa` · `chem/pubchem.hexa` (`*_test.hexa`) |
| **PPI hotspot** | alanine-scan ΔΔG, hotspot mimicry | partial (antibody-antigen struct) | 🟡 Bogan-Thorn alanine scan | 🟡 `bio/ppi/` + `_hexa_bridge/selftest/ppi_sim.hexa` (in-silico estimate) |
| **28 therapeutic modalities** | protac · aptamer · ribozyme · macrocycle · nanobot · covalent · molecular-glue · oligonucleotide · capsid · LYTAC · AUTAC · … | ✗ | 🟡 design-pipeline simulators | 🟡 `bio/*/module/` (28 dirs) + **108 cross-modal selftests** in `_hexa_bridge/selftest/` (Bayesian audits, witness-emission — design simulations, NOT wet-lab) |

```
 AF3 scope                          hexa-bio scope
 ──────────                         ──────────────
 [structure] ────────────▶ DONE     [spec]→[structure]→[design]→[analyze]
                                            │           │         │
                                       (AF input)   28 modalities  Vina
                                            │           │         │
                                     →[synthesize]→[verify(g5)]→[handoff(IND draft)]
```

**Verdict: hexa-bio WINS on breadth** — it occupies the entire spec→handoff drug-design pipeline; AF3 is a single (excellent) stage inside it. The honest caveat: most modality modules are **🟡 design simulations**, not wet-lab-validated assets.

---

## 2.5 · The 16-cell C2 matrix — what "16/16 PASS" actually means (in-silico)

The `~/core/hexa-bio/` repo's headline closure claim is the **16-cell C2 matrix** (4 bio axes × 4 disease classes). It is the clearest example of why hexa-bio's "PASS" verdicts must be read with the in-silico fence — **a 16/16 PASS is NOT a 16/16 cure, drug, or efficacy result.**

```
 16-CELL C2 MATRIX  (cycle 25, ~/core/hexa-bio/ — all cells verified on disk)
 ───────────────────────────────────────────────────────────────────────────
  Axis \ Class   │ α (AML)  │ β (SCD)  │ γ (pan-cov) │ δ (senolytic)
 ────────────────┼──────────┼──────────┼─────────────┼──────────────
  W (weave)      │  PASS    │  PASS    │   PASS      │   PASS
  N (nanobot)    │  PASS    │  PASS    │   PASS      │   PASS
  R (ribozyme)   │  PASS    │  PASS    │   PASS      │   PASS
  V (virocapsid) │  PASS    │  PASS    │   PASS      │   PASS
 ────────────────┴──────────┴──────────┴─────────────┴──────────────
  Aggregate = 16/16 PASS  →  IN-SILICO simulator+metadata internal
                             consistency ONLY.
```

- **What each cell verifies (verbatim scope):** (a) the C0b simulator runs deterministically, (b) the candidate-spec metadata schema validates, and (c) the verifier's internal-consistency check holds. **That is all.**
- **What it does NOT mean:** "It does **NOT** imply any therapeutic, clinical, regulatory, immunogenic, pharmacokinetic, or efficacy property. The disease-class markers are publicly catalogued reference annotations — not medical claims. C3+ (wet-lab → in-vitro → in-vivo → IND → phase I) is explicitly out-of-repo." (carried verbatim from `~/core/hexa-bio/README.md`)
- **On disk:** all 16 candidate kernels exist — `{weave,nanobot,ribozyme,virocapsid}/module/{aml,scd,pancov,senolytic}_*_candidate.hexa`; each emits one `raw_77_c2_<verb>_<class>_v1` witness row to `state/discovery_absorption/registry.jsonl`, archived under `design/kick/`.
- **vs. AF3:** AF3 makes **no disease-class or candidate claim at all** — it returns a structure. The C2 matrix is a hexa-bio-only artifact, and its honest scope (simulator-consistency) is *narrower* than its impressive "16/16" headline suggests. This is the matrix the prior revision of this doc never saw.

**Verdict (§2.5): the C2 16/16 is a real, deterministic, internally-consistent IN-SILICO result — and explicitly not a therapeutic one.** It demonstrates substrate maturity (all four bio axes traverse all four disease scaffolds), not clinical progress.

---

## 3 · QUANTITATIVE AFFINITY — hexa-bio's real measurement (the strongest honest win)

**AF3 does not predict binding affinity.** It returns a structure + confidence; quantitative ΔG/ΔΔG is explicitly out of scope (Abramson et al., stated limitation; static structure only, no dynamics, no conformational change on binding). hexa-bio, via its CURE/RX domains, computes **real, converged free energies** — though through *external* engines:

| Method | What it produced | Tier · evidence |
|--------|------------------|-----------------|
| **Absolute binding FEP (ABFE)** | SENOLYX R10b geldanamycin/HSP90 → **ΔG_bind = −16.64 ± 0.49 kcal/mol** (converged: solvent leg ±76→±0.34, 224× improvement; 20-window double-decoupling, ReplicaExchange+MBAR) | ✅ **real converged measurement** — engine = OpenMM 8.5.1 + openmmtools (summer RTX 5070, $0). `exports/SENOLYX/round10-fep-abfe/` |
| **ABFE — honest negative** | same run **FALSIFIED** the "moderate −8…−11" hypothesis (~5.7 kcal/mol overbind vs re-anchored Kd≈9 nM); cause traced (R11) to macrocycle force-field over-expansion (2.2× vs GFN2-xTB) | ✅ closed-negative (d6/g63) — a *finding*, reported not buried |
| **MM-GBSA** | AGA-RX WAY-316606 → SFRP1 ΔG = −17.96 kcal/mol (corroborates Vina −7.77) | ✅ `domains/AGA-RX.md` D2, real run |
| **Vina docking score** | AGA-RX leads vs SFRP1/AR-LBD, ΔΔG-ranked | ✅ real Vina, `exports/AGA-RX/round2-docking/` |
| **Relative FEP (RBFE)** | SENOLYX R12 17-AAG↔17-AG pair (ΔΔG_exp≈−1.9) | 🟡 **in-flight** — openfe stack, deck built + smoke-passed, production run not yet harvested |

```
 AF3                          hexa-bio (SENOLYX)
 ───                          ──────────────────
 structure ──▶ [confidence]   structure ──▶ ABFE ──▶ ΔG = −16.64 ± 0.49 kcal/mol
              (NO ΔG)                              └─▶ hypothesis FALSIFIED → cause = FF
                                                       (honest closed-negative finding)
```

**Verdict: hexa-bio WINS — but with a load-bearing honest caveat.** The affinity numbers are *real and converged*, and AF3 produces no such number at all. **However**, they are computed by **external Python FEP engines (OpenMM/openmmtools/openfe)**, NOT by pure-hexa code — the hexa-native `chem/md` module is a Velocity-Verlet stub, not the production engine. So this is "**hexa-bio the pipeline** wins on quantitation," not "hexa-native code wins."

---

## 4 · AI-NATIVE / DIFFERENTIABLE — parity, with a real hexa edge unrealized (🟡)

AF3's diffusion network is differentiable internally, but its **weights are closed** and it runs behind a non-commercial **AlphaFold Server** (code/weights released Nov-2024 for academic use only) — you cannot compose it into a custom differentiable objective. hexa-lang ships a **full native ML stack** (`stdlib/autograd.hexa` + `stdlib/flame/` — tensor · train · quant · spiking libs, 40k+ LOC) that *could* make the bio pipeline end-to-end differentiable.

| Aspect | AF3 | hexa-bio | Tier |
|--------|-----|----------|------|
| Native autodiff engine | internal only | ✅ `stdlib/autograd` + `flame` exist & tested | ✅ (stack) |
| End-to-end differentiable design (∂verdict/∂molecule) | ✗ (closed weights, server-gated) | not yet wired into bio pipeline | 🟡 **aspirational for bio** |
| Open / composable | ✗ server + non-commercial licence | ✅ stdlib, g5-verifiable | ✅ |
| QFORGE integration (quantum-accurate ΔG) | ✗ | 🟡 AGA-RX "pocket-VQE" axis claims chem-accuracy upgrade | 🟡 design-stage |

**Verdict: PARITY on principle, 🟡 unrealized for bio.** The *substrate* for AI-native differentiable drug design exists in hexa (and is genuinely more open than AF3's server), but the bio pipeline is **not yet** wired through it end-to-end. No win is claimed where none is verified.

---

## 5 · Full capability matrix

```
 CAPABILITY                AF3        hexa-bio tier   STATUS (honest · in-silico)
 ───────────────────────── ────────── ────────────── ──────────────────────────────────
 de-novo structure pred.   ✅ WIN     ⚪              no fold engine; consumes AF PDBs
 complex/multimer          ✅ WIN     ⚪              —
 confidence (pLDDT/PAE)     ✅ WIN     ⚪              —
 MSA / seq-align           ✅ (input) 🟡              SW/NW/MSA real, not a fold model
 ligand docking            ✅ (pose)  🟡              Vina SCORING port; search deferred
 binding affinity ΔG       ✗          ✅              real converged ABFE −16.64±0.49
 relative ΔΔG (RBFE)       ✗          🟡              openfe in-flight, not harvested
 molecular dynamics        ✗          🟡              Verlet/LJ/Ewald stub; PME deferred
 cheminformatics           ✗          ✅              RDKit-subset, babel-free (tested)
 PPI hotspot               partial    🟡              alanine-scan sim
 ───── 5-AXIS SUBSTRATE (~/core/hexa-bio/ — surface the prior rev missed) ─────────────
 WEAVE (composition)       ✗          ✅              cage ODE + Bayes σ=12, post 0.97
 VIROCAPSID (assembly)     ✗          🟡              VIPERdb n=527 T-disc; T=1 exact
 RIBOZYME (catalysis)      ✗          🟡              Eyring kinetics + GENCODE off-target
 NANOBOT (actuation)       ✗          🟡              DNA-origami 4-state sim, C0b
 QUANTUM (VQE compute)     ✗          🟡              H₂/LiH VQE via qmirror; F-Q-6 open
 19 expansion sub-axes     ✗          ✅/🟡           4 main IMPL+VERIF; 15 sub sims
 C2 16-cell matrix         ✗          🟡              16/16 PASS = in-silico consistency
 ─────────────────────────────────────────────────────────────────────────────────────
 AI-native autodiff stack  internal   ✅(stack)/🟡(bio) autograd+flame exist; bio not wired
 open / composable         ✗ server   ✅              stdlib, g5-verifiable
 g5/g8 honesty gate        ✗          ✅              hexa verify + in-silico fence
```

**Tier tally for hexa-bio:** ✅ IMPLEMENTED+VERIFIED ×8 (ABFE measurement, cheminformatics, DB clients, **WEAVE axis**, **4 expansion-main axes**, autodiff stack existence, open/composable, g5/g8 gate) · 🟡 IN-SILICO SIMULATOR ×12 (docking-scoring, RBFE, MD, PPI, **VIROCAPSID**, **RIBOZYME**, **NANOBOT**, **QUANTUM-VQE**, **15 sub-axes**, **C2 matrix**, weave-pipeline, bio-autodiff wiring) · ⚪ ASPIRATIONAL ×3 (de-novo fold, complex assembly, confidence). **Every ✅/🟡 in the 5-axis block is in-silico simulator-consistency — never a wet-lab/clinical claim (g8 fence).**

---

## 6 · The three honest headlines

```
 ┌──────────────────────────────────────────────────────────────────────┐
 │ ① WHERE hexa-bio WINS (in-silico scope only):                         │
 │    • Scope breadth — a 5-AXIS molecular substrate (WEAVE·NANOBOT·      │
 │      RIBOZYME·VIROCAPSID·QUANTUM-VQE) +19 expansion sub-axes; AF3 is   │
 │      ONE axis (structure). 5880 .hexa, 35/35 selftest, C2 16/16.       │
 │    • Quantitative affinity — real converged ABFE ΔG=−16.64±0.49        │
 │      kcal/mol; AF3 produces NO affinity number at all.                 │
 │    • Openness + g5/g8 honesty gate — stdlib, verifiable, composable.   │
 │    (caveat: breadth = IN-SILICO simulators w/ falsifier preregisters,  │
 │     NOT wet-lab assets; affinity rides on EXTERNAL OpenMM/openfe.)     │
 ├──────────────────────────────────────────────────────────────────────┤
 │ ② WHERE AF3 is AHEAD (conceded):                                       │
 │    • De-novo structure prediction — hexa-bio has NO fold engine and    │
 │      literally consumes AlphaFold PDBs as docking input.               │
 │    • Accuracy + training data — PDB-scale, PoseBuster +50% vs docking, │
 │      WET-LAB-validated. hexa-bio's 5 axes are wet-lab-UNVERIFIED.      │
 │    • Maturity — Nature-published, server-deployed, world-adopted.      │
 ├──────────────────────────────────────────────────────────────────────┤
 │ ③ THE REAL DIFFERENTIATOR:                                             │
 │    Not "a better AlphaFold" — a DIFFERENT THING. AF3 = the structure   │
 │    oracle (ONE modality, wet-lab-accurate). hexa-bio = a 5-AXIS,       │
 │    AI-native, verify-gated in-silico DESIGN SUBSTRATE (composition·    │
 │    actuation·catalysis·assembly·quantum-VQE) + a pipeline that takes a │
 │    structure (often AF3's) onward to a quantitative, falsifiable       │
 │    verdict. Breadth wins are real but IN-SILICO; AF3 keeps the         │
 │    accuracy crown on its one axis. Honestly fenced (g8), not contested.│
 └──────────────────────────────────────────────────────────────────────┘
```

---

## 7 · Contribution & impact

```
 [ AF3: structure ] ──▶ [ hexa-bio pipeline ] ──▶ [ what becomes possible ]
                                │
        ┌───────────────────────┼────────────────────────┐
        ▼                       ▼                         ▼
  quantitative ΔG          28 modalities             one open stack
  (FEP/ABFE)               (protac→nanobot)          (autodiff·g5·QFORGE)
  → go/no-go decision      → modality choice         → verifiable, composable
```

1. **Complements, not competes.** The cleanest framing: **AF3 → hexa-bio** is a *handoff*, not a rivalry. AF3 gives the best structure; hexa-bio decides whether a molecule actually binds it (ΔG), how to drug it (28 modalities), and proves the verdict (g5). AGA-RX literally does this — AF SFRP1 PDB → Vina → MM-GBSA → IND draft.
2. **Quantitation AF3 won't give.** A structure is not a decision. hexa-bio's ABFE turned a hypothesis into a *falsified* result with a mechanistic cause (force-field) — the kind of honest negative that AF3's confidence score cannot produce.
3. **Open + verifiable.** Unlike AF3's non-commercial server, hexa-bio is stdlib code under a g5 honesty contract — every claim is `hexa verify`-able, every negative is logged, no number is forced.
4. **The unrealized upside (honest).** The native autodiff stack + QFORGE quantum-accuracy hook + multiscale weave are real assets but **mostly 🟡** — the document claims them as *direction*, not *done*. That is the gap a future cycle closes.

```
 BEFORE (AF3 alone)            →   AFTER (AF3 + hexa-bio)
 ─────────────────────             ──────────────────────────────
 structure + confidence            structure → does it bind? (ΔG)
 no affinity                       → how to drug it? (28 modalities)
 static, no dynamics               → MD / FEP ensemble (external engine)
 closed server, non-commercial     → open stdlib, g5-verifiable
 one stage                         → spec → handoff (IND draft)
```

---

## 8 · Provenance & verification

- **hexa-bio surface (1) — `stdlib` family**: `stdlib/bio/` (28 modality dirs · 108 `_hexa_bridge/selftest/` · 19 `bio/tests/`) · `stdlib/chem/` (vina-scoring · md · rdkit-subset · babel-free · pubchem) · `stdlib/protein-fold/` · `stdlib/rna-therapy/` · `stdlib/gene-edit/` · `stdlib/seq_align/` · ML substrate `stdlib/autograd.hexa` + `stdlib/flame/` (hexa-lang).
- **hexa-bio surface (2) — standalone substrate repo `~/core/hexa-bio/`** (`dancinlab/hexa-bio` v1.0.0, registry L24): the **5-axis molecular toolkit** the prior revision missed. 59 dirs · **5880 `.hexa`** · 11,776 docs. SSOTs: `AXIS.tape` (core-5: QUANTUM·WEAVE·NANOBOT·RIBOZYME·VIROCAPSID) · `AXIS/HIERARCHY.tape` (expansion: 4 main + 15 sub = 24 total) · `README.md`. Per-axis: `weave/module/weave.hexa` (✅) · `virocapsid/` · `ribozyme/` · `nanobot/` (🟡 C0b sims) · `quantum/module/quantum.hexa` (🟡, VQE via `dancinlab/qmirror` v2.1.0 CLI — no shadow `.hexa`). Gates: `selftest/run_all.sh` → **35/35 PASS**; `selftest/n6_axis_computational_verification.py` 42/42; 32 sims DETERMINISTIC; 12 falsifiers HOLD; tier roster 42🟢+1🔵+1🟠. **16-cell C2 matrix (`design/kick/`): 16/16 PASS = in-silico simulator+metadata internal consistency ONLY** (carried verbatim: *"NOT therapeutic, clinical, regulatory, immunogenic, pharmacokinetic, or efficacy … C3+ explicitly out-of-repo"*). All 5 axes scientifically UNPROVEN at the wet-lab boundary (`AGENTS.tape g8_in_silico_only`).
- **demiurge bio domains** (`DOMAINS.tape`): AGA-RX · AGA-CURE · SENOLYX · IVD-CURE · OA-CURE · PERIO-CURE · RETINA-CURE · RNA-THERAPY · PROTEIN-FOLD.
- **Real measurements**: SENOLYX `exports/SENOLYX/round10-fep-abfe/` (ABFE ΔG=−16.64±0.49, converged) + round11 (FF cause analysis) + round12 (RBFE in-flight) · AGA-RX `exports/AGA-RX/round2-docking/`, `round7-d2-mmgbsa/` (Vina + MM-GBSA, AF PDB input).
- **External engines** (honest): production FEP/MD = OpenMM 8.5.1 + openmmtools + openfe on the `summer` RTX-5070 free GPU (memory `summer-free-gpu-fep`), NOT pure-hexa. The hexa-native `chem/md` is a Verlet/LJ/Ewald **stub** (PME · thermostat · trajectory-IO deferred); `chem/vina` ships **scoring only** (search/grid/IO deferred).
- **No bio g5 verdicts in `.verdicts/`** — every file there is QFORGE/RTSC; hexa-bio's verification lives in module `*_test.hexa` selftests + per-domain `.log.md` g5 lines, not in the `.verdicts/` tree. Reported honestly: bio's verification maturity is below QFORGE's.
- **Honesty contract**: d6 / @L4 / @L5 / g5 / **g8 (in-silico-only fence)** — every win above is a real measurement or an existing module; every ⚪/🟡 is fenced; the **entire 5-axis substrate breadth is in-silico simulator-consistency, NEVER a wet-lab / clinical / efficacy claim**; AF3's structure-prediction superiority (and its wet-lab accuracy) is conceded, not contested.

### AlphaFold 3 source (verbatim)
- **Abramson, J., Adler, J., Dunger, J. et al.** "Accurate structure prediction of biomolecular interactions with AlphaFold 3." *Nature* **630**, 493–500 (2024). **DOI: [10.1038/s41586-024-07487-w](https://doi.org/10.1038/s41586-024-07487-w)** · published 13 June 2024 · Addendum: [10.1038/s41586-024-08416-7](https://doi.org/10.1038/s41586-024-08416-7).
- Stated capability (verbatim): *"a substantially updated diffusion-based architecture that is capable of predicting the joint structure of complexes including proteins, nucleic acids, small molecules, ions and modified residues … far greater accuracy for protein–ligand interactions compared with state-of-the-art docking tools."*
- Stated limitations: **static structures only** (no dynamical ensemble even across seeds) · **no conformational change on binding** · chirality not always respected · hallucinations in intrinsically-disordered regions (~22% of IDP residues, arXiv:2510.15939) · **not a binding-affinity predictor**.
- Access: free **AlphaFold Server** for non-commercial research; model code + weights released Nov-2024 for academic use.

*Sibling doc: `QFORGEvsQE.md` (the engine-vs-engine comparison this format follows). This file is the standalone AlphaFold-vs-hexa-bio comparison.*
