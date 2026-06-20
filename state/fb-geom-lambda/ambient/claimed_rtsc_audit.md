# CLAIMED-RTSC AUDIT — ambient room-T superconductor claim space (honest)
> 📡 RTSC AMBIENT-ROOM-T LENS · `state/fb-geom-lambda/ambient/`
> GOAL: honest arxiv+web map of ALL claimed ambient (≈1 atm) room-temperature superconductors —
> mark debunked/retracted vs open, score against ROOMT-AMBIENT-PASS-CRITERIA (esp. TIER-2 B Meissner + E reproduce ≥2 labs)
> so we neither chase debunked claims (d_novel_only) nor miss a genuine open lead (d2).
> Date: 2026-06-19 · web+arxiv only · NO commit / NO ARCHITECTURE.json / NO pod.
> PASS-CRITERIA SSOT: `state/fb-geom-lambda/ROOMT_AMBIENT_PASS_CRITERIA.md`
>  - TIER-2 A zero-R · **B ★Meissner (shielding fraction)** · C ΔC jump · D isotope/gap · **E reproduce ≥2 labs**
>  - hard #4: Tc ≥ 293 K @ P = 1 atm.

## BOTTOM-LINE VERDICT (depletion test)
**NO credible OPEN ambient-pressure room-T (≥293 K @ 1 atm) superconductor lead exists as of June 2026.**
Every bulk ambient-RT claim is **DEBUNKED or RETRACTED** (LK-99 = Cu₂S/ferromagnetic artifact; Dias LuNH = retracted, only color-change reproduced). The single peer-reviewed ambient-RT claim still nominally alive (Kopelevich/Terra-Quantum graphite line-defect SC) is **localized-not-bulk, single-group-20yr-lineage, NEVER independently reproduced** — UNCONFIRMED, not a genuine lead. Do NOT resurrect any of these as candidates (d_novel_only).

**Verified ambient-pressure ceiling = cuprate Hg-1223 ≈ 134 K** (reproduced 30+ yr, Meissner confirmed). It passes every gate EXCEPT hard-#4 (134 K ≪ 293 K). Honest gap to room-T = **~159 K**. The frontier of genuinely-reproduced 2024-26 ambient work: pressure-quenched Hg-1223 **151 K** (metastable, PNAS 2026) and nickelate films **~30-48 K** — both real, neither room-T.

---

## 1. LK-99 — Cu-doped lead apatite Pb₁₀₋ₓCuₓ(PO₄)₆O (2023, Korea Q-Centre)
**STATUS: DEBUNKED** (not "retracted" — the two arXiv preprints were never peer-reviewed/published as SC).
- Claimed: Tc > 400 K (>126.85 °C) @ **ambient pressure** (the headline distinction vs hydrides).
- Preprints: **arXiv 2307.12008** (Lee, Kim, Kwon — "The First Room-Temperature Ambient-Pressure Superconductor") · **arXiv 2307.12037** (Lee, Kim, H-T Kim et al. — "Superconductor Pb₁₀₋ₓCuₓ(PO₄)₆O showing levitation…"). Split co-author lists = internal authorship dispute.
- **Artifact 1 (levitation = ferromagnetism, not Meissner):** partial/tilted "half-levitation" is soft-ferromagnetic balancing, not flux expulsion/pinning. arXiv **2308.03110**, **2308.11768**, **2310.08594**.
- **Artifact 2 (resistivity drop = Cu₂S impurity):** Cu₂S byproduct undergoes a **first-order** hexagonal→monoclinic structural transition at **~385 K (~112 °C)** dropping ρ ~3-4 orders — exactly where Q-Centre saw its "transition," and it **never reaches zero**. First-order + hysteretic ≠ second-order SC transition. *Matter* (Cell Press) **DOI 10.1016/j.matt.2023.11.001**.
- **Pure crystal = insulator:** Max Planck (Takagi group) floating-zone single crystals → transparent megaohm **insulator**, weak ferro/diamagnetism, no levitation. Puphal et al. arXiv **2308.13310** (ID high-confidence, not opened in session).
- Replication failures: arXiv **2308.03544** (PMC10633996), **2308.03823**, **2309.17445**; IOP *SUST* **DOI 10.1088/1361-6668/ad2b78**. Summary: Garisto, **Nature 620, 705 (2023), DOI 10.1038/d41586-023-02585-7**.
- **GATE FAIL:** TIER-2 **B (Meissner NEVER confirmed — levitation was ferromagnetic artifact)** + **A/E (zero-R never independently reproduced — drop was Cu₂S structural transition)**. Also fails hard-#4.

### 1b. PCPOSOS — LK-99 derivative (+S +Cu), APS March Meeting 2024 (SCTL, Korea)
- **STATUS: UNCONFIRMED / partially self-retracted.** No independent zero-R or Meissner reproduction; SCTL itself withdrew the "full levitation" claim (attributed to Lorentz force). Same impurity-artifact lineage. Not credible. Fails B + E.

---

## 2. Dias group (U. Rochester) — both RETRACTED, misconduct substantiated
### 2A. CSH (carbonaceous sulfur hydride, ~CH₈S) — 287.7 K @ 267 GPa
- **STATUS: RETRACTED** (not ambient anyway — 267 GPa).
- Original: Snider, Dias et al., **Nature 586, 373 (2020), DOI 10.1038/s41586-020-2801-z**. Retracted **26 Sep 2022**, Nature 610, E15, DOI 10.1038/s41586-022-05294-9.
- **Why:** editors lost confidence in the **magnetic susceptibility (diamagnetic) data** — a non-standard, **undisclosed user-defined background-subtraction**. Hirsch critique: arXiv **2110.12854** ("…anatomy of a probable scientific fraud"). Some co-authors contested the retraction.
- **GATE FAIL:** the Meissner/diamagnetic evidence itself (TIER-2 B) was the disputed/processed data; never reproduced (E). Plus 267 GPa = not ambient.

### 2B. NLuH — N-doped lutetium hydride "reddmatter" — 294 K @ ~1 GPa
- **STATUS: RETRACTED.**
- Original: Dasenbrock-Gammon … Salamat, Dias, **Nature 615, 244 (2023), DOI 10.1038/s41586-023-05742-0**. Retracted **7 Nov 2023**, Nature 624, 460, DOI 10.1038/s41586-023-06774-2 (requested by co-authors; Dias dissented).
- **Why caught by reproduction:** independent groups reproduced ONLY the **pressure-induced color change** (blue LuH₂ → pink/red) — an optical/structural effect, NOT SC. Ming et al. **Nature 620, 72 (2023), DOI 10.1038/s41586-023-06162-w** (arXiv **2303.08759**) — no SC 1.8-300 K, 0-6 GPa. Also Nat. Commun. **DOI 10.1038/s41467-023-41777-7**; arXiv **2307.00201** (metal→poor-conductor, not SC); Hirsch arXiv **2304.00190**; color theory arXiv **2304.07326**; PNAS PMC10477194.
- **Context:** Rochester 124-pp investigation (2024) found **fabrication, falsification, plagiarism** across 4 studies; 2021 PRL also retracted; Dias no longer employed by U. Rochester (Nov 2024). Nature d41586-024-00976-y.
- **GATE FAIL:** TIER-2 **B (diamagnetic signature = disputed/processed)** + **E (independent reproduction FAILED — only color change reproduced)**. ~1 GPa is also not strictly ambient.

---

## 3. VERIFIED AMBIENT RECORD — cuprate Hg-1223 (HgBa₂Ca₂Cu₃O₈₊δ)
**STATUS: VERIFIED · reproduced 30+ yr · Meissner confirmed — the genuine ambient-pressure record holder.**
- **Ambient-pressure Tc ≈ 133-135 K (~134 K).** Original: Schilling, Cantoni, Guo, Ott, **Nature 363, 56 (1993), DOI 10.1038/363056a0** (max Tc ≈ 133 K, 3-layer phase). Optimized single-phase: Meissner onset ~135.4 K, zero-R ~133.9 K.
- **Under pressure (NOT ambient — for contrast):** Tc → ~150-153 K @ ~15 GPa, **~164 K @ ~31 GPa**. Gao, Xue, Chu et al., **Phys. Rev. B 50, 4260 (1994), DOI 10.1103/PhysRevB.50.4260**; Chu et al. Nature 365, 323 (1993).
- **Gate scoring:** TIER-2 **A zero-R ✅ · B Meissner ✅ · E reproduce-many-labs ✅**. Passes TIER-1 stability/carrier/novelty. **Fails ONLY hard-#4** (134 K @ 1 atm ≪ 293 K). This is the honest ambient ceiling.
- Gap to room-T: **293 − 134 = ~159 K**, unmoved in equilibrium since 1993.

---

## 4. NEW 2024-2026 claims — honest status (no open ambient-RT lead found)
- **Hg-1223 pressure-quench → 151 K @ ambient** — Wu, Deng, Chu (U. Houston TcSUH), **PNAS 2026, DOI 10.1073/pnas.2536178123** (arXiv 2603.12437). **VERIFIED-grade (peer-reviewed) but METASTABLE non-equilibrium + 151 K = −122 °C, NOT room-T.** Paper itself states equilibrium ambient record "unchanged since 1993" and RT-SC still ~140 °C away. Most credible NEW ambient record of the period; still fails hard-#4.
- **Ruddlesden-Popper nickelates La₃Ni₂O₇ / (La,Pr)₃Ni₂O₇** — GENUINE, reproduced progress but NOT room-T:
  - bulk UNDER PRESSURE: ~80 K (2023) → **96 K @ ~14-40 GPa** (Nature 2025, DOI 10.1038/s41586-025-09954-4; d-wave gap arXiv 2509.12606). Diamond-anvil, not ambient.
  - **ambient-pressure strained thin films:** onset **26-42 K** (Ko et al. Nature 638, 935, DOI 10.1038/s41586-024-08525-3); (La,Pr) films >40 K (DOI 10.1038/s41586-025-08755-z); La₂PrNi₂O₇ onset >48 K, zero-R >30 K. **VERIFIED + multi-lab reproduced — but ~30-48 K, far below room-T.**
- **"Global Room-T SC in Graphite" (line defects/wrinkles in HOPG)** — Kopelevich, Vinokur et al. (Terra Quantum/UNICAMP), arXiv **2208.00854**, *Adv. Quantum Technol.* 2024 **DOI 10.1002/qute.202300230**. Claims Tc > 300 K @ ambient. **STATUS: UNCONFIRMED / DISPUTED** — localized to line defects (NOT bulk), 20-yr single-group lineage (cf. Esquinazi graphite-interface claims arXiv 1709.00259, 1606.09425), **NEVER independently reproduced.** Fails TIER-2 **E (no ≥2-lab reproduction)** + **B (no bulk Meissner shielding fraction)**. The only peer-reviewed ambient-RT claim still nominally alive — but treat as unconfirmed, not a genuine open lead.
- **X₄H₁₅ hole-doped hydrides (2025)** — DFT-only theory prediction, no synthesis/measurement. UNCONFIRMED THEORY, not a lead.
- **Theory bound:** Nat. Commun. **DOI 10.1038/s41467-025-63702-w** — max Tc of conventional (phonon) ambient SC is bounded; ambient conventional RT-SC "extremely unlikely." All confirmed near-RT SC = hydrides at 100-200+ GPa (LaH₁₀ ~250-260 K @ 170-190 GPa = highest independently-validated Tc, NOT ambient).

---

## 5. The honest record + depletion test
- **Verified highest-Tc ambient-pressure SC (reproduced, Meissner): cuprate Hg-1223 ≈ 134 K.** Gap to 293 K = **~159 K**.
- **Credible OPEN ambient-RT lead: NONE.** All ambient-RT claims are DEBUNKED (LK-99, PCPOSOS), RETRACTED (Dias CSH/NLuH), or UNCONFIRMED-single-group (graphite line-defect). No reproduced result has closed any meaningful fraction of the 159 K gap in 30+ years.
- **Claim-space map (status · gate-fail):**

| Claim | Claimed Tc / P | Status | arXiv / DOI | Gate failed |
|---|---|---|---|---|
| LK-99 apatite | >400 K @ 1 atm | DEBUNKED | 2307.12008 / .12037; Matter 10.1016/j.matt.2023.11.001 | B Meissner (ferro artifact) + A/E zero-R (Cu₂S) + #4 |
| PCPOSOS | RT @ 1 atm | UNCONFIRMED / part-retracted | APS March 2024 | B + E |
| Dias CSH | 287.7 K @ 267 GPa | RETRACTED | Nature 10.1038/s41586-020-2801-z (retr. 2022) | B (disputed χ) + E + not-ambient |
| Dias NLuH | 294 K @ ~1 GPa | RETRACTED | Nature 10.1038/s41586-023-05742-0 (retr. 2023) | B (disputed χ) + E (only color reproduced) |
| Graphite line-defect | >300 K @ 1 atm | UNCONFIRMED / DISPUTED | 2208.00854; 10.1002/qute.202300230 | B (no bulk Meissner) + E (never reproduced) |
| Hg-1223 quench | 151 K @ 1 atm | VERIFIED-grade, metastable | PNAS 10.1073/pnas.2536178123 | #4 (151 K ≪ 293 K) |
| Nickelate films | 30-48 K @ 1 atm | VERIFIED, reproduced | Nature 10.1038/s41586-024-08525-3 | #4 |
| **Hg-1223 (record)** | **~134 K @ 1 atm** | **VERIFIED, reproduced, Meissner ✅** | **Nature 10.1038/363056a0** | **ONLY #4 (134 ≪ 293)** |

**Honest closing (d6 · d_novel_only):** the verified ambient ceiling is ~134 K (cuprate). There is no credible open ambient-RT-SC lead to chase — all such claims are artifacts, retracted, or unconfirmed-single-group. This is consistent with the campaign's RTSC closing-formula finding (ambient conventional RT-SC closed; any room-T escape needs an exotic non-phonon / bond-Peierls bipolaron mechanism, not these candidates). Resurrecting any of the above as a "candidate" would violate d_novel_only.
