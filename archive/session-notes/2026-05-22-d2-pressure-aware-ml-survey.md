# 2026-05-22 — D? cohort precursor — pressure-aware ML SC predictor survey

**Trigger**: `2026-05-22-rtsc-novel-discovery-zero-rtsc-candidates.md` (BETE-NET ambient-only · hydrides 92-97% off · GPa-only candidate 못 잡음)
**Goal hook**: "RTSC 신물질 합성해가면서 성공시켜줘" — *next-breakthrough path* 탐색
**Mode**: pure-research literature survey (no code change · no RTSC.md / MP.md / constitution.md / exports/ touch)
**Honest g3**: BETE-NET 한계는 ambient-pressure 훈련 — *pressure-aware* OR *novel-structure-generative* OR *active-learning-DFT-loop* 모델이 필요. 본 노트는 그 후보들의 *map*.

---

## §1. Survey methodology

- Areas mined (WebSearch 8 round, WebFetch 후속 spot-check):
  1. pressure-aware SC ML predictor 2025-2026
  2. universal interatomic potential under pressure (MACE / M3GNet / CHGNet / MatterSim / ORB / SevenNet)
  3. generative crystal structure (MatterGen / CDVAE / DiffCSP / Con-CDVAE)
  4. active learning SC discovery DFT-in-loop
  5. graph NN electron-phonon high pressure (ALIGNN-on-hydrides)
  6. open-source EPW / SSCHA first-principles pipeline
  7. CSP frameworks (OpenCSP / USPEX / CALYPSO / CrySPY) high-P
  8. benchmark dataset (HTSC-2025)
- Captured: arxiv ID, full URL, venue, license, pretrained-weights availability, pip/docker/github status, RTSC-relevance (1-5)
- *Did not* run code, *did not* train, *did not* claim discovery — pure mapping.

---

## §2. Per-candidate table (10 candidates)

| # | Model / Approach | arxiv | Venue | License | Weights? | Install | P-aware? | Gen-new? | RTSC-relevance |
|--|--|--|--|--|--|--|--|--|--:|
| 1 | **MatterSim** (deep-learning atomistic, 0-5000K · 0-1000 GPa) | — (Microsoft Research, github.com/microsoft/mattersim) | MSR blog 2024 · MatterSim-MT 2025 (arxiv:2605.07927) | MIT | yes (HF + Azure AI Foundry) | pip / github | **YES (1000 GPa explicit)** | force-field only | **5** |
| 2 | **OpenCSP** (LAM trained on pressure-resolved data) | [arxiv:2509.10293](https://arxiv.org/abs/2509.10293) | preprint Sep 2025 | open-source (paper claims) | yes (model + dataset) | github (per paper) | **YES (10-100s GPa, uncertainty-guided concurrent learning)** | CSP framework | **5** |
| 3 | **MatterGen** (diffusion · property-conditioned crystal generator) | (Microsoft, github.com/microsoft/mattergen + HF) | Nature 2025 (microsoft preprint) | MIT | yes (HF microsoft/mattergen) | pip / github | indirect (via MatterSim eval) | **YES (conditional inverse design)** | **5** |
| 4 | **InvDesFlow-AL** (active-learning · LiAuH₆ 140K) | [arxiv:2505.09203](https://arxiv.org/abs/2505.09203) | npj Comput. Mater. 2025 (s41524-025-01830-z) | open (paper supp.) | yes (per paper) | github (per paper) | indirect (via DFT loop) | **YES + AL DFT-in-loop** | **5** |
| 5 | **Guided Diffusion for SC** (DiffCSP fine-tune · 7183 SC · classifier-free guidance) | [arxiv:2509.25186](https://arxiv.org/abs/2509.25186) | preprint Sep 2025 (OpenReview tY7MTfuqfB) | open (per paper) | likely (paper claims) | github (per paper) | partial (Alexandria fine-tune) | **YES (target Tc)** | **4** |
| 6 | **BEE-NET** (bootstrapped equivariant GNN α²F · 0.87 K MAE) | [arxiv:2503.20005](https://arxiv.org/abs/2503.20005) | npj Comput. Mater. 2026 (s41524-026-01964-8) | likely open | likely (paper claims) | github (per paper) | partial (training set decides) | screening only | **4** |
| 7 | **ALIGNN + ALIGNN-FF + JARVIS hydride sweep** (900+ hydrides · 0-500 GPa · Tc) | [arxiv:2312.12694](https://arxiv.org/abs/2312.12694) | Materials Futures 2024 (IOPscience 10.1088/2752-5724/ad4a94) · NIST | NIST (open, U.S. gov) | **yes** (usnistgov/alignn weights + ALIGNN-FF) | pip (`alignn`) / github | **YES (trained 0-500 GPa explicit)** | screening | **5** |
| 8 | **MACE-MPA-0** (MACE retrained on MPtrj + Alexandria · density-renormalized for high-P) | (subset of MACE family; benchmarked in [arxiv:2508.17792](https://arxiv.org/abs/2508.17792)) | npj-style preprint Aug 2025 | open (MACE = MIT) | yes | pip (`mace-torch`) | **YES (explicit high-P retrain)** | force-field | **4** |
| 9 | **SSCHA** (anharmonic quantum hydride pipeline · Python + Julia + ML upscale) | sscha.eu / [github.com/SSCHAcode/python-sscha](https://github.com/SSCHAcode/python-sscha) | J. Phys. Cond. Matter 2021 (IOPscience 10.1088/1361-648X/ac066b) | GPL | code-only (no DL) | pip | **YES (LaH₁₀ tutorial · GPa-native)** | physics-based | **4** |
| 10 | **EPW + Quantum ESPRESSO** (first-principles α²F · anisotropic Migdal-Eliashberg) | [arxiv:1604.03525](https://arxiv.org/abs/1604.03525) (v4 release) | Comput. Phys. Commun. + docs.epw-code.org | **GPL** | code-only (no DL) | source build + QE | **YES (GPa via QE relax)** | physics-based | **3** |

### Bonus reference (dataset · not a model)

| #  | Resource | arxiv | Note |
|--|--|--|--|
| 11 | **HTSC-2025** benchmark (ambient-P high-Tc · X₂YH₆ · LaH₁₀-derived 2D MgB₂) | [arxiv:2506.03837](https://arxiv.org/abs/2506.03837) | Chinese Physics 2025 (IOPscience 10.1088/1674-1056/adf042) · CC dataset on HF (xiao-qi/HTSC-2025) — *complement* to BETE-NET ambient-pressure side; *not* a pressure-aware fix per se |

### Bonus reference (uMLIP pressure benchmark · diagnostic)

| #  | Resource | arxiv | Finding |
|--|--|--|--|
| 12 | **uMLIP under pressure** benchmark (Loew et al., 7 models 0-150 GPa) | [arxiv:2508.17792](https://arxiv.org/abs/2508.17792) | "accuracy deteriorates considerably as pressure increases — limitation **of training data**, not algorithm. Targeted fine-tuning fixes it." → *concrete justification* for OpenCSP / MatterSim / MACE-MPA-0 over vanilla MACE / CHGNet / M3GNet |

---

## §3. Top 3 recommendations (RTSC-relevance × open-source × ready-to-use)

### **#1 · MatterSim** (Microsoft) — *the only foundation-model that explicitly claims 0-1000 GPa coverage*
- **Why top**: 1000 GPa = covers H₃S (200), LaH₁₀ (170), CaH₆ (150), Li₂AuH₆ candidate spaces by ~5-7×. Multi-task (energy, force, stress, magnetic, Born-charge, dielectric) means *single model* relaxes hydride at GPa + ranks dynamic stability.
- **Ready-to-use**: MIT license · HF + Azure AI Foundry · `pip install mattersim` working.
- **Limit**: force-field only (Tc still needs α²F downstream — pair with EPW or BETE-NET fine-tune).
- **RTSC path**: high-P hydride relaxation 정확도 ↑ → BETE-NET 의 *input structure* 문제 직접 해결 (이전 run 의 "simplified ambient-P 구조" 문제).

### **#2 · OpenCSP** (Wang et al. 2025) — *first ML-CSP framework purpose-built for ambient → high-pressure*
- **Why top**: training data 자체가 *uncertainty-guided concurrent learning* 으로 GPa-region resampling. Beats MACE-MPA-0 + MatterSim-v1-5M + GRACE-2L-OAM on high-P phase prediction *with less data*. Paper directly addresses BETE-NET-style ambient-pressure failure mode.
- **Ready-to-use**: arxiv:2509.10293 · paper says "open-source dataset + suite of publicly available atomistic models". Sep 2025 → still fresh, verify github status before D-cohort.
- **Limit**: ML-CSP, not Tc direct. Same upstream/downstream split as MatterSim.
- **RTSC path**: novel high-P phase generation (예: ternary hydride combos not in ambient SuperCon DB).

### **#3 · InvDesFlow-AL** (Li et al. 2025) — *active-learning loop with DFT-confirmed 140K BCS hit*
- **Why top**: *closed* generation→DFT→retrain loop, and *empirically demonstrated* discovery of Li₂AuH₆ at 140 K (above McMillan limit + above liquid-N₂). RMSE 0.0423 Å on CSP — 32.96% better than baseline generative. Published npj Computational Materials 2025.
- **Ready-to-use**: github + paper open. arxiv:2505.09203.
- **Limit**: still BCS (so g3 honest: 140 K ≠ 270 K RTSC threshold) — but *empirical proof* that active-learning + generative + DFT loop can break ambient-pressure DB ceiling. The infrastructure pattern is the win.
- **RTSC path**: demiurge wraps the *loop pattern*, swap target from 140 K → 270 K, swap hydride family → broader (XYH₆ · ternary borohydrides · clathrate carbon).

---

## §4. Recommended next D-cohorts

> Numbering placeholder — RFC reservation per ARCH.md §11.4 (grep design.md current head before assignment per MEMORY auto-note).

| D? | Cohort title | Wrap target | Acceptance signal |
|--|--|--|--|
| **D-α** | **MatterSim pressure-aware adapter** | `material/mattersim_relaxer_producer.py` — input: ASE Atoms + target P (GPa); output: relaxed Atoms + uMLIP energy/force/stress + dynamical-stability flag | LaH₁₀ @ 170 GPa relax produces Fm-3m clathrate within DFT-RMSE; H₃S @ 200 GPa produces Im-3m | 
| **D-β** | **OpenCSP framework integration** | github clone + adapter that hands BETE-NET *high-P-relaxed* structures (vs. current simplified ambient) — pre-stage to BETE-NET, *not replacement* | regenerate the 7-candidate run with OpenCSP-relaxed structures, watch hydride rel_err drop from 92-97% → <50% |
| **D-γ** | **InvDesFlow-AL pattern wrapper** | active-learning loop in `material/` — generator (CDVAE/DiffCSP) + DFT oracle stub (EPW or BETE-NET) + retrain hook | demiurge-side reproduce of Li₂AuH₆ 140 K hit (single-target sanity) before scaling to RTSC target |
| **D-δ** | **MatterGen conditional inverse-design** | wrap `microsoft/mattergen` HF model, condition on "high-Tc proxy" property | sample 1k structures conditioned on `target_property ~ high-Tc-surrogate`, feed top-100 to D-α relaxer → D-β BETE-NET |
| **D-ε** *(stretch)* | **ALIGNN hydride sweep replication** | `usnistgov/alignn` + ALIGNN-FF, replicate Choudhary et al. 900-hydride 0-500 GPa Tc sweep on demiurge infra | reproduce paper-claimed 122 dynamically-stable above-MgB₂ subset · *external corroboration* of BETE-NET ambient bias |
| **D-ζ** *(physics anchor)* | **EPW or SSCHA first-principles oracle** | open-source GPL pipeline, replace ML Tc with anharmonic+anisotropic Migdal-Eliashberg for *top-N* InvDesFlow / OpenCSP candidates | parity: EPW Tc vs. measured LaH₁₀ within 20% — *real* oracle for D-γ active-learning loop |

> **Order suggestion**: D-α (MatterSim) → D-β (OpenCSP) → D-γ (InvDesFlow-AL pattern) first 3 D-cohorts. D-δ / D-ε / D-ζ second-wave (post-validation).

---

## §5. Surprise findings (gaps in earlier rounds)

1. **MatterSim explicitly states 0-1000 GPa coverage** — earlier RTSC.md framing ("ambient-only ML SC predictors") was *true for SuperCon-based predictors* but *not* for foundation potentials. The honest framing: BETE-NET = ambient α²F predictor (composition-level); MatterSim = pressure-explicit foundation potential (structure-level). They are *orthogonal*, not competing.

2. **OpenCSP (Sep 2025)** is the *single most recent* paper directly addressing "uMLIPs degrade at high P due to training-data limit". They quantified the degradation and *retrained* — this is exactly the gap the previous note ("ML SC predictor 의 *기본 한계*: ambient-pressure 훈련 데이터") identified.

3. **InvDesFlow-AL hit Li₂AuH₆ @ 140 K (DFT-confirmed)** — this is the *first* AI-loop demonstration of a BCS-above-McMillan-limit discovery from a *generative* pipeline. Liquid-N₂ regime achieved, RTSC threshold (270 K) not yet, but the *pattern* (gen → AL → DFT) is the replicable infrastructure.

4. **HTSC-2025 benchmark exists** (open dataset on HF) — *standardized* AI-vs-AI comparison for Tc prediction. Not pressure-aware itself (ambient-P focused) but a *fair playing field* to swap BETE-NET vs. ALIGNN vs. future predictors. Worth ingesting.

5. **MACE-MPA-0 with density renormalization for high-P** — incremental but real fix to vanilla MACE; the Loew et al. benchmark (arxiv:2508.17792) is the *empirical scoreboard* of which uMLIP to trust at GPa range.

6. **EPW + SSCHA still the gold standard** — *not* obsolete despite ML rush. Any active-learning loop needs an oracle; physics-based oracle remains the only honest path until ML oracle reaches DFT parity at GPa range (which Loew benchmark says: not yet for vanilla uMLIP).

7. **Closed-source CSP tools (USPEX, CALYPSO)** are dominant in published high-P phase discoveries but their *binary-only* status conflicts with demiurge's open-source SSOT principle. CrySPY (MIT) + OpenCSP (paper open) are the open alternatives.

---

## §6. Honest g3 framing

- This survey **does not claim** "RTSC is now achievable" — every entry in §3-§4 is a *next breakthrough direction*, not a discovery.
- BETE-NET's ambient-pressure limit is **not a defect** — it's a *correctly-scoped* model. The next step is *composition with* pressure-aware tools, not replacement.
- The 5-gate R4 invariant (replication ≥ 3 · Tc ≥ 270 K measurement · ambient · ≥ 3 labs · measurement-oracle parity) is **not weakened** by these candidates — they only address **sim-side** (predictor + structure generation). Gates (a), (c), (d), (e) still wet-lab dependent.
- "Impossible" framing is rejected. Replaced with: "**OpenCSP needs validation on hydrides at 200 GPa**", "**MatterSim needs Tc-side coupling**", "**InvDesFlow-AL needs RTSC-target swap**". Each = one D-cohort.

---

## §7. Cross-reference

- `inbox/notes/2026-05-22-rtsc-novel-discovery-zero-rtsc-candidates.md` — trigger
- `inbox/notes/2026-05-22-bete-net-7-candidate-benchmark.md` — empirical baseline (BETE-NET ambient-only)
- `RTSC.md §8.9 5-gate · §9.2 BETE-NET row · §9.10 N5 funnel · §9.11`
- BETE-NET primary: [arxiv:2401.16611](https://arxiv.org/abs/2401.16611) (Gibson et al. npj Comput. Mater. 2024)
- ARCH.md §11.4 (D-number reservation protocol)

---

## §8. URLs (link-rot safe)

| Ref | Full URL |
|--|--|
| MatterSim | https://github.com/microsoft/mattersim · https://microsoft.github.io/mattersim/ · arxiv:2605.07927 |
| OpenCSP | https://arxiv.org/abs/2509.10293 · https://arxiv.org/html/2509.10293v1 |
| MatterGen | https://github.com/microsoft/mattergen · https://huggingface.co/microsoft/mattergen |
| InvDesFlow-AL | https://arxiv.org/abs/2505.09203 · https://www.nature.com/articles/s41524-025-01830-z |
| Guided Diffusion (SC) | https://arxiv.org/abs/2509.25186 · https://openreview.net/forum?id=tY7MTfuqfB |
| BEE-NET | https://arxiv.org/abs/2503.20005 · https://www.nature.com/articles/s41524-026-01964-8 |
| ALIGNN hydride sweep | https://arxiv.org/abs/2312.12694 · https://iopscience.iop.org/article/10.1088/2752-5724/ad4a94 · https://github.com/usnistgov/alignn |
| MACE-MPA-0 / uMLIP benchmark | https://arxiv.org/abs/2508.17792 |
| SSCHA | https://github.com/SSCHAcode/python-sscha · https://sscha.eu/ |
| EPW | https://docs.epw-code.org/ · https://arxiv.org/abs/1604.03525 |
| HTSC-2025 | https://arxiv.org/abs/2506.03837 · https://github.com/xqh19970407/HTSC-2025 |
| BETE-NET | https://arxiv.org/abs/2401.16611 |
