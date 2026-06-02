# AGA-RX — log

Append-only history sister of `AGA-RX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-03 — hexa-loop round-2 RESULTS: measured ΔG (AutoDock Vina 1.2.7) + AR gate 🟠

Toolchain UP locally (micromamba dock env, mini/arm64 — vina 1.2.7 + openbabel + meeko + rdkit; no pool needed).
DEFERRED→MEASURED. exports/AGA-RX/round2-docking/ (RESULTS.md + 57 files: poses, vina logs, score TSVs).

- [x] design CLOSED: measured ΔG —
  - PATH A: **WAY-316606 → SFRP1-CRD = −7.77 kcal/mol** (on-band vs lit −5.6 est; NOT artifact)
  - PATH B (LRP6 PE3 funnel, top-3): 2-naphthylguanidine −7.17 · 4-guanidinobenzoic acid −7.16 · tyramine-guanidine −6.87
- AR off-target gate (2AM9 AR-LBD; controls DHT −5.57 / finasteride −5.90 / testosterone −5.50):
  all 4 leads literally within 1.5 kcal/mol of DHT (WAY −6.20, frags −4.9..−5.3) → **literal falsifier FAILS**,
  BUT honest verdict = **🟠 INCONCLUSIVE** (NOT closed FAIL): rigid Vina can't discriminate — all 7 compress into
  ~1.3 kcal/mol band inside Vina's ±1.5-2 error; DHT redock landed ~6Å off native (selectivity unresolvable at this
  resolution). Leads neither cleared nor confirmed AR-active. No candidate closed (d_defer_no_delete).
- breakthrough paths (d2): (1) flexible-receptor / AutoDock-GPU redock gated on DHT <2Å native reproduction;
  (2) MM-GBSA rescoring for discriminating ΔΔG; (3) AF-2 H-bond-signature filter (agonism mechanism, not total affinity).
- SRD5A2 7BW1 DEFERRED — cofactor(NADPH)-coupled catalytic site, no clean orthosteric box (d6 honesty).
- next: AR-gate needs the flexible-redock breakthrough before analyze(off-target) can close; PATH C decks ready to dock.

## 2026-06-03 — hexa-bio 5-axis reflected into AGA-RX (modality expansion · d19)

Migrated hexa-bio-archive README 5 axes mapped to AGA therapeutic modalities (snapshot matrix added):
- ⚛️ QUANTUM → pocket-VQE quantum-accurate ΔG (upgrade PATH A/B/C docking to chem-accuracy; hexa-bio F-Q-6)
- 🧶 WEAVE → Caspar-Klug/Zlotnick self-assembling delivery cage for follicular payload
- 🤖 NANOBOT → DNA-origami trigger-release nanocarrier → dermal papilla (pH/enzyme-gated)
- ✂️ RIBOZYME → ribozyme/siRNA vs DKK1·SRD5A2·AR mRNA (non-small-molecule arm; OLX104C precedent)
- 🦠 VIROCAPSID → AAV/capsid gene therapy → DPC (Wnt-restore / anti-Dkk1 payload)
5 axis milestones added (now 3/13). Each inherits hexa-bio-archive verified simulators (σ(6)=12 · Caspar-Klug · cage-ODE · VQE). These become round-3+ discover lanes.

## 2026-06-03 — hexa-loop round-2: docking-measure (DEFERRED→measured) + AR off-target gate

round-1 absorbed. exports/AGA-RX/ consolidated into main tree (path-a-sfrp1 · path-b-dkk1-lrp6 · discover-frontier).
- [x] structure CLOSED: PATH A SFRP1 = AlphaFold **Q8N474** (P48451 was WRONG = Drosophila calcineurin; corrected) CRD pocket pLDDT 92.7; PATH B = PDB 3S2K, LRP6 PE3 funnel hotspot mapped (E663/E708/D811/D830/D878/W767/F836 + box).
- residual: docking DEFERRED both paths — no vina/smina/obabel/conda on mini (d_defer_no_delete; decks ready).
- WAY-316606 lit estimate ΔG≈−5.6 kcal/mol (Kd 0.08 mM, weak mM binder, shallow groove) — treat Vina deeper than −8 as artifact.

round-2 dispatched (free pool linux per d7 — summer/aiden):
- [ ] R2-A docking-measure: install micromamba+vina on pool host → run PATH A (WAY-316606 vs SFRP1) + PATH B (8 frag vs LRP6) decks → measured ΔG; rank.
- [ ] R2-B AR off-target gate (frontier #1): dock leads vs AR-LBD 2AM9 + SRD5A2 7BW1 → FALSIFIER = any lead binding AR/SRD5A2 comparably to finasteride kills the non-AR safety thesis.
- [ ] R2-C PATH C structure prep: LDHA 6Q0D (counter LDHB 1I0Z) + BCL-xL 3ZLR + mTOR-FKBP12 → pockets + decks (parallel, no toolchain dep).

## 2026-06-03 — hexa-loop round-1: structure→design fan-out (adapter note + env fix)

Loop engine = /hexa-loop. Toolchain fix: `hexa` CLI needs `export HEXA_LANG=/Users/mini/dancinlab/hexa-lang`
(module root unset → atlas/kick/drill compile-fail; with it, atlas loads 17265 nodes OK).
Honest adapter note (d6): `--adapter=atlas` discover half = hexa kick/drill = math-theorem prover,
a poor fit for a wet/clinical in-silico drug domain → built-in atlas-math VERIFY substituted with
domain-correct in-silico compute (docking/ADMET/PK agents). discover(ideation) retained.

- [ ] DISPATCHED (worktree agents, in-flight): PATH A SFRP1 structure(AlphaFold P48451)+pocket+WAY-316606 docking → exports/AGA-RX/path-a-sfrp1/
- [ ] DISPATCHED: PATH B Dkk1-LRP6 PDB 3S2K hotspot map + fragment docking → exports/AGA-RX/path-b-dkk1-lrp6/
- [ ] DISPATCHED: discover-frontier — PATH C combo scoping + design/analyze next-list + d19 reuse edges → exports/AGA-RX/discover-frontier/
- next: absorb the 3 results → flip structure/design milestones → round-2 fan-out from the frontier inventory; DEFERRED any candidate whose docking tooling is absent (d_defer_no_delete), never delete.

## 2026-06-03 — round-1 (d18): NOVEL non-AR target probe + arxiv/web pipeline grounding

Domain seeded. Two parallel research lanes (NOVEL discovery + literature/pipeline) landed.
Unifying strategy: **intervene DOWNSTREAM of the androgen signal** (Wnt restoration / HFSC
reactivation / regeneration) so DHT + AR stay physiologically intact systemically → avoids
the 5α-reductase-inhibitor (finasteride/dutasteride) PFS/sexual-dysfunction liability.

- [x] spec: AGA mechanism map + marketed/pipeline drugs quantified (see below)
- [x] spec: NOVEL non-AR target discovery (round-1) — 7 viable targets ranked

### NOVEL non-AR targets (ranked, 5ARI-side-effect-free angle)

| # | Target | Mechanism | Novelty | Safety vs fin | Structure (docking) |
|---|---|---|---|---|---|
| T1 | **SFRP1 inhibition** (WAY-316606 class) | de-repress Wnt (extracellular antagonist) | high | excellent | AlphaFold P48451 |
| T2 | **Dkk1–LRP6 disruptor** | block the literal effector of DHT→Dkk1→Wnt↓ | high | excellent | **PDB 3S2K** ✅ (+3S8V,5FWW) |
| T4 | metabolic HFSC switch (MPC inh / LDH↑, PP405 class) | wake dormant follicle stem cells | high | top (topical, no endocrine) | LDH many; MPC AlphaFold |
| T5 | DPC senescence / autophagy reversal | rescue root-cause aging substrate | highest | good (intermittent senolytic) | small-mol |
| T6 | CXXC5-PPI / GSK3β Wnt agonism | raise β-catenin output node | high | GSK3β LOW (oncogenesis); prefer CXXC5 | GSK3β many PDBs |
| T3 | SCUBE3 agonism | replace lost DPC pro-anagen signal | highest | good | biologic (no SM pocket) |
| ~~T8~~ | ~~PGD2/CRTH2 antagonism~~ | **FALSIFIED**: Setipiprant Ph2a no efficacy vs placebo | — | — | PDB 6D26 (de-prioritized) |

### Breakthrough paths (d2) — pursue first
- **PATH A** — SFRP1 small-molecule inhibitor as lead first-in-class (best novelty+druggability+safety balance; WAY-316606 starting chemotype).
- **PATH B** — structure-based Dkk1–LRP6 interface disruptor on **PDB 3S2K** (patent-clear: existing IP is antibody-only; topical-feasible small molecule).
- **PATH C** — differentiated metabolic(T4)+senescence(T5) combination (avoid PP405 me-too).

### Marketed SoC — quantified (placebo-adjusted)
- Finasteride 1mg: +107 hairs/yr1, +138/yr2, decays to +38/yr5; sexual AE ~2-4%; **PFS ~0.3-2.1%** persistent (the dominant class liability, reversibility unresolved).
- Dutasteride 0.5mg: most efficacious monotherapy (network meta-analysis); +17.4 hairs/cm² 3×/wk; same/greater AE; not FDA-approved for AGA.
- Minoxidil 5% topical (K-ATP opener, androgen-independent): significant regrowth; irritation/shedding/hypertrichosis. LDOM 1mg ≈ topical 5%; hypertrichosis ~15%.
- Combo ceiling: min+fin adds +9.22 hairs/cm² over min alone.

### Clinical pipeline frontier (2024-2026)
- **Clascoterone 5% (Breezula, Cosmo)** — topical AR antagonist, **Phase 3 met** (TAHC +539%/+168% vs vehicle, n=1465), US/EU submission 2026 → **front-runner**.
- **GT20029 (Kintor)** — first-in-class topical PROTAC AR degrader, Phase 2 hit (p<0.001), → Phase 3.
- **PP405 (Pelage)** — topical MPC inhibitor (metabolic HFSC), Phase 2a: ~31% responders >20% density gain vs 0% placebo, no systemic absorption, Phase 3 2026 → most distinct mechanism near clinic.
- **HMI-115 (Hope Medicine)** — prolactin-receptor antagonist (non-androgen), Phase 1b positive.
- **Verteporfin (repurposed)** — YAP inhibitor → de novo follicle neogenesis (transplant-adjunct axis).
- Closed-negatives (avoid): **SM04554** Wnt activator Phase 3 marginal → ceased; **JAK** = alopecia areata only, off-axis for AGA.

### Open white-space (target product profile vector)
1. **Regeneration not maintenance** — every approved drug is anti-miniaturization; only PP405 + verteporfin/SCUBE3 aim at true new-follicle formation (largest white space).
2. **Decouple efficacy from androgen-axis liability** — a truly side-effect-free efficacious agent is unclaimed.
3. **Female AGA** — pipeline data almost entirely male-only; clean female label is wide-open.
4. **Durability / reversal-resistance** — all require indefinite use; disease-modifying agent unaddressed.

### arXiv (sparse field — AGA is wet/clinical, not arXiv)
- [A1] **arXiv 2502.15035** (Dobreva 2025) — follicle-cycle model; AGA shows greater anagen-duration uncertainty vs control. The only quantitative AGA follicle-dynamics model.
- [A2] arXiv 2506.03565 — chemotaxis PDE for alopecia areata (math companion).
- 1808.10045 — transdermal/follicular PBPK delivery (relevant to topical-AGA-drug PK).
- **Modeling white-space**: no arXiv paper on AGA drug PK/PD or in-silico AGA drug design → couple [A1] anagen model to a DHT/AR-occupancy PK/PD layer = novel demiurge in-silico contribution.

### Next (structure → design)
- structure: pull PDB **3S2K** (Dkk1-LRP6) + SFRP1 AlphaFold P48451; define binding pockets/hotspots.
- design: dock WAY-316606 vs SFRP1; fragment-dock the Dkk1-CRD2/LRP6 interface; free-energy scoring.
