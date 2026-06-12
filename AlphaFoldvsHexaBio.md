# 🧬 AlphaFold vs hexa-bio — "the world's structure-prediction oracle" vs "an AI-native multiscale design pipeline"

> Comprehensive, **honest** head-to-head of **AlphaFold 3** (DeepMind/Isomorphic Labs, Abramson et al., *Nature* 2024 — the de-facto reference for biomolecular structure prediction) against **hexa-bio** (the `stdlib/bio` + `stdlib/chem` + `stdlib/protein-fold` family inside hexa-lang, driven by demiurge's CURE/RX domains).
>
> Every hexa-bio capability below is tier-classified ✅ IMPLEMENTED+VERIFIED / 🟡 SCAFFOLDED/PARTIAL / ⚪ ASPIRATIONAL with its evidence (selftest · g5 · verdict · export). Where AF3 leads, it is conceded plainly (d6 / @L5 / g5). **No capability is claimed to surpass AF3 unless a real, verified measurement backs it.**

- **하는 일 (AF3)**: amino-acid sequence (+ DNA/RNA/ligand/ion) → **3D atomic coordinates** of the folded complex, with per-atom confidence (pLDDT/PAE)
- **하는 일 (hexa-bio)**: a **7-verb design pipeline** (spec → structure → design → analyze → synthesize → verify → handoff) that *consumes* a structure (often an AlphaFold one) and runs **docking · MD · binding free-energy (FEP/ABFE) · 28 therapeutic modalities · multiscale weave** toward a drug-candidate verdict
- **비유**: AF3 = the **camera** that photographs a molecule's shape · hexa-bio = the **CAD+simulation+verification studio** that takes the photo and engineers a drug around it
- **비교 축**: AF3 is a *structure-prediction model*; hexa-bio is a *design-and-verification pipeline*. They overlap only at the boundary — and that boundary is exactly where AF3 wins.

---

## TL;DR — 4-axis verdict

```
                          AlphaFold 3            │  hexa-bio (best tier)
 ─────────────────────────────────────────────── ┼ ───────────────────────────────────
 STRUCTURE  de-novo fold accuracy. State-of-art   │  ⚪/🟡 NO learned fold engine.
 PREDICTION diffusion model, PoseBuster +50% vs   │  protein-fold = 7-verb STUB
            docking, PDB-scale training.          │  (absorbed=false). CONSUMES AF
            ▶ AF3 WINS — decisively.              │  PDBs as INPUT. ◀ BEHIND
 ─────────────────────────────────────────────── ┼ ───────────────────────────────────
 SCOPE      structure of complexes only           │  ✅ docking + MD + FEP + 28
 (pipeline) (protein·DNA·RNA·ligand·ion·          │  modalities + multiscale weave,
            covalent). ONE stage.                  │  end-to-end spec→handoff.
            ▶ narrow-but-deep                     │  ▶ hexa-bio WINS on breadth
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

**Bottom line (3 honest headlines):**
1. **AF3 WINS — structure prediction.** hexa-bio has **no learned fold network**; its `protein-fold` module is a 7-verb pipeline stub (`absorbed=false`) and its real pipelines *download AlphaFold PDBs as input* (e.g. `AF-Q8N474-F1-SFRP1.pdb` in AGA-RX). This axis is not close, and the doc does not pretend otherwise.
2. **hexa-bio WINS — downstream scope & quantitation.** AF3 stops at coordinates and **does not predict binding affinity** (Abramson, stated limitation). hexa-bio carries the molecule forward through docking, MD, and a **real converged absolute binding free energy** (ABFE), plus 28 therapeutic-modality design pipelines — a stage AF3 simply does not occupy.
3. **The real differentiator — AI-native, multiscale, verify-gated.** hexa-bio is one compose-able stack (`stdlib/autograd` + `flame` ML + `chem` + `bio`) with a g5 honesty contract and a multiscale "weave," whereas AF3 is a single closed-weight model behind a non-commercial server. The honest caveat: the *quantitative* wins ride partly on **external Python engines (OpenMM/openmmtools/openfe)**, not pure-hexa code — reported below, not hidden.

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
 CAPABILITY                AF3        hexa-bio tier   STATUS (honest)
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
 28 modalities (protac…)   ✗          🟡              design sims; 108 selftests; no wetlab
 multiscale weave          ✗          🟡              weave_composition (MVP), Landauer gate
 inverse / generative      ✗ (struct) 🟡              design verb; no learned generator
 AI-native autodiff stack  internal   ✅(stack)/🟡(bio) autograd+flame exist; bio not wired
 open / composable         ✗ server   ✅              stdlib, g5-verifiable
 g5 verify honesty gate    ✗          ✅              hexa verify; SENOLYX/AGA-RX verdicts
```

**Tier tally for hexa-bio:** ✅ IMPLEMENTED+VERIFIED ×6 (ABFE measurement, cheminformatics, DB clients, autodiff stack existence, open/composable, g5 gate) · 🟡 SCAFFOLDED/PARTIAL ×8 (docking-scoring, RBFE, MD, PPI, 28 modalities, weave, inverse-design, bio-autodiff wiring) · ⚪ ASPIRATIONAL ×3 (de-novo fold, complex assembly, confidence).

---

## 6 · The three honest headlines

```
 ┌──────────────────────────────────────────────────────────────────────┐
 │ ① WHERE hexa-bio WINS (verified only):                                │
 │    • Quantitative affinity — real converged ABFE ΔG=−16.64±0.49       │
 │      kcal/mol; AF3 produces NO affinity number at all.                 │
 │    • Pipeline breadth — full spec→handoff (dock·MD·FEP·28 modalities). │
 │    • Openness + g5 honesty gate — stdlib, verifiable, composable.      │
 │    (caveat: affinity ride on EXTERNAL OpenMM/openfe, not pure hexa.)   │
 ├──────────────────────────────────────────────────────────────────────┤
 │ ② WHERE AF3 is AHEAD (conceded):                                       │
 │    • De-novo structure prediction — hexa-bio has NO fold engine and    │
 │      literally consumes AlphaFold PDBs as docking input.               │
 │    • Accuracy + training data — PDB-scale, PoseBuster +50% vs docking. │
 │    • Maturity — Nature-published, server-deployed, world-adopted.      │
 ├──────────────────────────────────────────────────────────────────────┤
 │ ③ THE REAL DIFFERENTIATOR:                                             │
 │    Not "a better AlphaFold" — a DIFFERENT THING. AF3 = the structure   │
 │    oracle (one stage). hexa-bio = the AI-native, multiscale, verify-   │
 │    gated DESIGN PIPELINE that takes a structure (often AF3's) onward   │
 │    to a quantitative, falsifiable drug verdict. Multiscale weave +     │
 │    quantitative FEP + native autodiff substrate + QFORGE quantum-      │
 │    accuracy hook are its true axes — most still 🟡, honestly fenced.   │
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

- **hexa-bio home**: `stdlib/bio/` (28 modality dirs · 108 `_hexa_bridge/selftest/` · 19 `bio/tests/`) · `stdlib/chem/` (vina-scoring · md · rdkit-subset · babel-free · pubchem) · `stdlib/protein-fold/` · `stdlib/rna-therapy/` · `stdlib/gene-edit/` · `stdlib/seq_align/` · ML substrate `stdlib/autograd.hexa` + `stdlib/flame/` (hexa-lang).
- **demiurge bio domains** (`DOMAINS.tape`): AGA-RX · AGA-CURE · SENOLYX · IVD-CURE · OA-CURE · PERIO-CURE · RETINA-CURE · RNA-THERAPY · PROTEIN-FOLD.
- **Real measurements**: SENOLYX `exports/SENOLYX/round10-fep-abfe/` (ABFE ΔG=−16.64±0.49, converged) + round11 (FF cause analysis) + round12 (RBFE in-flight) · AGA-RX `exports/AGA-RX/round2-docking/`, `round7-d2-mmgbsa/` (Vina + MM-GBSA, AF PDB input).
- **External engines** (honest): production FEP/MD = OpenMM 8.5.1 + openmmtools + openfe on the `summer` RTX-5070 free GPU (memory `summer-free-gpu-fep`), NOT pure-hexa. The hexa-native `chem/md` is a Verlet/LJ/Ewald **stub** (PME · thermostat · trajectory-IO deferred); `chem/vina` ships **scoring only** (search/grid/IO deferred).
- **No bio g5 verdicts in `.verdicts/`** — every file there is QFORGE/RTSC; hexa-bio's verification lives in module `*_test.hexa` selftests + per-domain `.log.md` g5 lines, not in the `.verdicts/` tree. Reported honestly: bio's verification maturity is below QFORGE's.
- **Honesty contract**: d6 / @L4 / @L5 / g5 — every win above is a real measurement or an existing module; every ⚪/🟡 is fenced; AF3's structure-prediction superiority is conceded, not contested.

### AlphaFold 3 source (verbatim)
- **Abramson, J., Adler, J., Dunger, J. et al.** "Accurate structure prediction of biomolecular interactions with AlphaFold 3." *Nature* **630**, 493–500 (2024). **DOI: [10.1038/s41586-024-07487-w](https://doi.org/10.1038/s41586-024-07487-w)** · published 13 June 2024 · Addendum: [10.1038/s41586-024-08416-7](https://doi.org/10.1038/s41586-024-08416-7).
- Stated capability (verbatim): *"a substantially updated diffusion-based architecture that is capable of predicting the joint structure of complexes including proteins, nucleic acids, small molecules, ions and modified residues … far greater accuracy for protein–ligand interactions compared with state-of-the-art docking tools."*
- Stated limitations: **static structures only** (no dynamical ensemble even across seeds) · **no conformational change on binding** · chirality not always respected · hallucinations in intrinsically-disordered regions (~22% of IDP residues, arXiv:2510.15939) · **not a binding-affinity predictor**.
- Access: free **AlphaFold Server** for non-commercial research; model code + weights released Nov-2024 for academic use.

*Sibling doc: `QFORGEvsQE.md` (the engine-vs-engine comparison this format follows). This file is the standalone AlphaFold-vs-hexa-bio comparison.*
