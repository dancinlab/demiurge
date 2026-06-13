# AGA-RX · RIBOZYME axis — siRNA / ASO design (round 3)

✂️ **RIBOZYME** — RNA-targeting catalytic arm · *비-소분자 AGA modality*

In-silico design of 19-mer siRNA duplexes against the AGA disease-driver mRNAs.
Androgen-axis-**independent** at the protein level (mRNA knockdown), so it sidesteps
the post-finasteride-syndrome (PFS) small-molecule liability. Precedent:
**OLX104C** (topical self-delivering anti-AR siRNA, Phase 1) proves topical scalp
siRNA is a viable route.

Anchor pathway: **DHT → DPC `Dkk1↑ / SFRP1↑` → Wnt↓**. Knocking down the driver
mRNA restores Wnt at the source.

| target | RefSeq | role in AGA | knockdown rationale |
|---|---|---|---|
| **DKK1** | NM_012242.4 | Wnt inhibitor, DHT-induced in DPC, pro-catagen | remove the Wnt brake directly |
| **SRD5A2** | NM_000348.4 | 5α-reductase type 2 (finasteride enzyme) | cut DHT synthesis w/o the small-molecule PFS risk |
| **AR** | NM_000044.6 | androgen receptor (OLX104C target) | block the upstream DHT signal receiver |
| **SFRP1** | NM_003012.5 | secreted Wnt antagonist (optional) | second Wnt brake, combinable w/ DKK1 |

---

## Method (rules + scoring)

`design.py` (pure-stdlib, runs free on pool — no special tooling) slides a 19-mer
window across each mRNA and scores the **sense** (target-matching) strand; the
**guide/antisense** = its reverse complement. Convention: sense position 1 = 5′;
antisense 5′ end corresponds to the sense 3′ end.

Filters / scores applied:

- **Hard gates**: GC 25-60% (soft-preferred 30-52%); reject homopolymer/repeat runs ≥ 5.
- **Reynolds 2004** (additive 0-8): GC 30-52%, A/U-rich antisense-5′ end, no run ≥4,
  position-specific base prefs (A@3, U@10, A@19, ¬G/C@19, ¬G@13).
- **Ui-Tei 2004** (PASS/fail): A/U at guide-5′, G/C at guide-3′, ≥4 A/U in guide pos 1-7,
  no GC stretch ≥ 9.
- **Amarzguioui / thermodynamic asymmetry** (`asym_ddG`): nearest-neighbour ΔG of the two
  duplex ends (RNA NN params). **More negative = better** (guide-5′ end relatively
  unstable → RISC loads the guide, not the passenger).
- **Synthesizability** (0-1): penalize G₄ runs (G-quadruplex / coupling failure) and high GC.
- **Composite rank** = `on_score × off_factor × synth`, where
  `on_score = Reynolds/8 + 0.5·(Ui-Tei PASS) + asym_bonus`,
  `off_factor = 1/(1 + off_cross)`.

Sort key: Ui-Tei PASS first, then descending composite rank.

> All listed candidates below **PASS Ui-Tei** and score **Reynolds ≥ 6/8**.

---

## Off-target screen — method + honest status (d6)

**Run locally (this report):** the miRNA-like **seed** = guide positions **2-8** (7mer),
the dominant driver of siRNA off-target silencing. `design.py` counts exact seed
target-site (`revcomp(seed)`) occurrences across (a) the *other* three driver mRNAs
on hand (`off_cross`) and (b) the candidate's own transcript (`off_self`, includes the
on-target site). **All top candidates have `off_cross = 0`** (no seed collision with the
sibling driver transcripts) and `off_self = 1-2` (the intended site, plus at most one
incidental seed echo within the same mRNA).

**PARTIAL — transcriptome-wide BLAST not run here.** A genome/transcriptome off-target
verdict needs the full human RefSeq mRNA set + a 3′UTR database, which is not fetched in
this session. We do **not** fabricate transcriptome hit counts. Exact pipeline to close it:

```
# 1. seed-level (miRNA-style) — the high-value screen
#    pull all human 3'UTRs (Ensembl biomart / UCSC) -> seedDB
#    for each candidate guide: count 7mer-m8 + 8mer seed sites in 3'UTRs
#    rank by TargetScan-style context++ ; flag any with >~10-20 conserved seed sites
seedscan --guide <guide> --utr-db gencode_v45_3utr.fa --kmer 7,8

# 2. full-length specificity — BLAST/Bowtie of the 19mer guide vs RefSeq mRNA
makeblastdb -in refseq_human_rna.fa -dbtype nucl -out human_rna
blastn -task blastn-short -query guides.fa -db human_rna \
       -word_size 7 -evalue 1000 -strand minus -outfmt 6
#    FLAG any non-target hit with <=2 mismatches in the guide seed region (pos 2-8)
#    or >=16/19 contiguous identity  -> potential silencing off-target

# 3. (optional) siSPOTR / GESS specificity-spectrum + s-Biopredsi efficacy CV
```

A candidate is **dropped** if step-1 surfaces a highly-seed-complementary off-target
transcript (esp. a hair/skin-expressed gene) or step-2 returns a ≤2-seed-mismatch
full-length hit to an essential gene.

---

## Per-target candidate tables

Sequences are RNA (use 2′-OMe / 2′-F / PS chemistry + 3′-dTdT overhangs for the
synthesized duplex; tables show the bare 19-mer core).

### DKK1 (NM_012242.4)

| rank | pos | sense (5′→3′) | guide / antisense (5′→3′) | GC% | Rey | Ui-Tei | asym ΔΔG | off_cross | off_self | score | region |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 971 | GCAGUGAACUCCUUUUAUA | UAUAAAAGGAGUUCACUGC | 36.8 | 7/8 | PASS | −5.16 | 0 | 2 | 1.875 | 3′UTR |
| 2 | 1713 | CUGCAUUGAUAAACUCAAA | UUUGAGUUUAUCAAUGCAG | 31.6 | 7/8 | PASS | −3.40 | 0 | 2 | 1.875 | 3′UTR |
| 3 | 539 | CCCGGGAAUUACUGCAAAA | UUUUGCAGUAAUUCCCGGG | 47.4 | 6/8 | PASS | −7.24 | 0 | 1 | 1.75 | CDS |
| 4 | 888 | GCCGGAUACAGAAAGAUCA | UGAUCUUUCUGUAUCCGGC | 47.4 | 6/8 | PASS | −4.63 | 0 | 1 | 1.75 | CDS |
| 5 | 1061 | CAGUUAAGCAUUCCAAUAA | UUAUUGGAAUGCUUAACUG | 31.6 | 6/8 | PASS | −3.07 | 0 | 2 | 1.75 | 3′UTR |

**Best DKK1:** candidate 1 (pos 971) by composite score, with the best asymmetry of the
two 3′UTR hits. If a **CDS** site is preferred (more robust across UTR isoforms),
**candidate 3 (pos 539, CDS)** has the strongest asymmetry (−7.24) of the whole set — the
recommended dual pick.

### SRD5A2 (NM_000348.4)

| rank | pos | sense (5′→3′) | guide / antisense (5′→3′) | GC% | Rey | Ui-Tei | asym ΔΔG | off_cross | off_self | score | region |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 1427 | GCAGUGUCUUAGUUGAUGA | UCAUCAACUAAGACACUGC | 42.1 | 8/8 | PASS | −2.42 | 0 | 1 | 1.903 | 3′UTR |
| 2 | 414 | CAAGGCUACUAUCUGAUUU | AAAUCAGAUAGUAGCCUUG | 36.8 | 7/8 | PASS | −3.31 | 0 | 1 | 1.875 | CDS |
| 3 | 579 | CCACAAGGUGGCUUGUUUA | UAAACAAGCCACCUUGUGG | 47.4 | 7/8 | PASS | −4.16 | 0 | 1 | 1.875 | CDS |
| 4 | 1724 | CACCAGAUGUCCACAACAA | UUGUUGUGGACAUCUGGUG | 47.4 | 7/8 | PASS | −3.51 | 0 | 1 | 1.875 | 3′UTR |
| 5 | 1726 | CCAGAUGUCCACAACAAUA | UAUUGUUGUGGACAUCUGG | 42.1 | 7/8 | PASS | −4.09 | 0 | 1 | 1.875 | 3′UTR |

**Best SRD5A2:** candidate 1 (pos 1427, Reynolds **8/8**, top composite). For a CDS-anchored
pick, **candidate 3 (pos 579, CDS, asym −4.16)** is the recommended functional lead.

### AR (NM_000044.6)

| rank | pos | sense (5′→3′) | guide / antisense (5′→3′) | GC% | Rey | Ui-Tei | asym ΔΔG | off_cross | off_self | score | region |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2857 | GCUGCAAGGUCUUCUUCAA | UUGAAGAAGACCUUGCAGC | 47.4 | 7/8 | PASS | −4.71 | 0 | 1 | 1.875 | CDS |
| 2 | 2666 | CAGUCCCACUUGUGUCAAA | UUUGACACAAGUGGGACUG | 47.4 | 7/8 | PASS | −2.46 | 0 | 1 | 1.785 | CDS |
| 3 | 2152 | CUACCCUGUCUCUCUACAA | UUGUAGAGAGACAGGGUAG | 47.4 | 7/8 | PASS | −2.30 | 0 | 1 | 1.758 | CDS |
| 4 | 1186 | GAGGAGCUUUCCAGAAUCU | AGAUUCUGGAAAGCUCCUC | 47.4 | 6/8 | PASS | −3.10 | 0 | 1 | 1.75 | CDS |
| 5 | 1690 | GCACCAUGCAACUCCUUCA | UGAAGGAGUUGCAUGGUGC | 52.6 | 6/8 | PASS | −3.43 | 0 | 1 | 1.75 | CDS |

**Best AR:** candidate 1 (pos 2857, CDS, Reynolds 7/8, asym −4.71, top score) — all AR
leads are in the LBD-encoding CDS, which is exactly the region OLX104C-class anti-AR siRNAs
target.

### SFRP1 (NM_003012.5) — optional

| rank | pos | sense (5′→3′) | guide / antisense (5′→3′) | GC% | Rey | Ui-Tei | asym ΔΔG | off_cross | off_self | score | region |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3006 | GGAGAGUUAUCCUGAUAAA | UUUAUCAGGAUAACUCUCC | 36.8 | 8/8 | PASS | −5.27 | 0 | 1 | 2.00 | 3′UTR |
| 2 | 1464 | GCAAGGGCCAUUUAGAUUA | UAAUCUAAAUGGCCCUUGC | 42.1 | 7/8 | PASS | −3.07 | 0 | 1 | 1.875 | 3′UTR |
| 3 | 2937 | GGAUGGUAGAUUCUGUUAA | UUAACAGAAUCUACCAUCC | 36.8 | 7/8 | PASS | −3.15 | 0 | 1 | 1.875 | 3′UTR |
| 4 | 3235 | GGGUCUUAGUUCUGGUUGA | UCAACCAGAACUAAGACCC | 47.4 | 7/8 | PASS | −3.72 | 0 | 2 | 1.875 | 3′UTR |
| 5 | 3350 | GGGUUUACCUGGAACAUUA | UAAUGUUCCAGGUAAACCC | 42.1 | 7/8 | PASS | −4.22 | 0 | 1 | 1.875 | 3′UTR |

**Best SFRP1:** candidate 1 (pos 3006, Reynolds **8/8**, asym −5.27, top score). Note all
high-scoring SFRP1 hits land in the long 3′UTR (the CDS is GC-rich/G-run-heavy → fails the
synthesizability + Ui-Tei GC-stretch gates), so a 3′UTR-targeting siRNA is the pragmatic
choice here.

---

## Gapmer ASO option (alternative modality)

For each target the same `seedscan`/BLAST off-target pipeline applies to a **16-20mer
gapmer ASO** (5-10-5 MOE/cEt wings, PS backbone, central DNA gap for RNase-H1 cleavage).
ASOs are carrier-light (often gymnotic uptake) so they pair more naturally with a simple
topical penetration-enhancer formulation than siRNA. The siRNA leads above double as ASO
target-site anchors — pick the same CDS windows (DKK1 pos 539, SRD5A2 pos 579, AR pos 2857)
and re-screen the gapmer for hepatotoxic-motif (G-rich / CpG / TCC) liabilities before
synthesis. (ASO sequences not enumerated this round — flagged as a fast follow.)

---

## Deliverability — delivery-axis pairing (reuse AGA-RX context)

siRNA is large, polyanionic, nuclease-labile → it **needs a carrier**; naked topical siRNA
will not reach the dermal-papilla (DPC) bulb. From the AGA-RX 5-axis frontier
(`exports/AGA-RX/discover-frontier/FRONTIER.md`):

| delivery axis | what it is | pairing with RIBOZYME |
|---|---|---|
| 🧶 **WEAVE** | Caspar-Klug / Zlotnick self-assembling cage | **primary pairing** — encapsulate the siRNA duplex in a self-assembling protein/peptide cage for follicular delivery scaffold; protects from nucleases + carries the polyanion |
| 🤖 **NANOBOT** | DNA-origami / molecular-machine switch, pH/enzyme-gated | **trigger-release pairing** — DPC-targeted nanocarrier that gates payload release at the follicle (pH/enzyme) → spatially-confined knockdown, supports the topical-confinement thesis |
| (formulation) | LNP / GalNAc-style or cholesterol/lipid conjugate | OLX104C-style **self-delivering siRNA** (cholesterol/lipid conjugate, no nanoparticle) is the lowest-complexity precedent-backed route; LNP is the standard alternative |

**Route:** trans-follicular shunt (infundibulum) to the DPC bulb (~2-4 mm), reusing the
AGA-RX follicular PK model (`t_lag = h²/6D`, `C(z) = C_surf·exp(−z/λ)` re-λ'd for the
follicular path — `AGA-RX ⟵ TTR-LAC/A1,A3`). The conjugate/LNP/cage carrier sets the
effective D and λ; the delivery axes (WEAVE primary, NANOBOT for gated release) are the
in-silico design targets that make this arm physically deliverable.

`reused[TTR-LAC/A1,A3; FRONTIER WEAVE,NANOBOT axes]` · `provides[siRNA driver-knockdown arm]`

---

## Final ranking (best candidate per target)

| target | best siRNA (guide 5′→3′) | sense site (pos) | GC% | Reynolds | asym ΔΔG | off_cross | delivery pairing |
|---|---|---|---|---|---|---|---|
| **SRD5A2** | `UCAUCAACUAAGACACUGC` | 1427 (3′UTR) · CDS alt: 579 | 42.1 | 8/8 | −2.42 | 0 | WEAVE cage / self-deliv conjugate |
| **SFRP1** | `UUUAUCAGGAUAACUCUCC` | 3006 (3′UTR) | 36.8 | 8/8 | −5.27 | 0 | WEAVE cage |
| **DKK1** | `UAUAAAAGGAGUUCACUGC` (CDS alt: `UUUUGCAGUAAUUCCCGGG` pos 539) | 971 (3′UTR) / 539 (CDS) | 36.8 / 47.4 | 7/8 / 6/8 | −5.16 / −7.24 | 0 | WEAVE cage + NANOBOT gate |
| **AR** | `UUGAAGAAGACCUUGCAGC` | 2857 (CDS) | 47.4 | 7/8 | −4.71 | 0 | NANOBOT gated (OLX104C precedent) |

**Synthesizability** = 1.0 for every listed lead (no G₄ runs, GC ≤ 53%, no GC-stretch ≥ 9).

**Off-target verdict:** local cross-driver seed screen **clean (off_cross = 0 for all)**;
transcriptome-wide BLAST/seedDB screen **PARTIAL** — pipeline specified above, must be run
before any synthesis commit (no fabricated transcriptome hit counts per d6).
