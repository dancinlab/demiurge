# V1 — RTSC claim inventory + tier triage

> Cross-domain unified verify schema · step 1 of 4 (V1 → V2 🔵 push → V3 🟢 push → V4 final ledger)
>
> Scope: RTSC 캠페인이 만든 모든 quantitative claim 들 (Tc · λ · ω_log · 압력 안정성 · §9.15 precommit vs actual · ML/DFT cross-confirmation · 측정-grade anchors) 의 ledger 화 + commons g5 rubric 기반 evidence tier 분류.
>
> SSOT cross-link: `RTSC.md` (current state) · `RTSC.log.md` (chronicle) · `exports/material_discovery/*.json` (machine-readable numerical SSOT) · `/tmp/betenet/results/finetuned/finetune_real.json` (BEE-NET FT smoke).
>
> g5 rubric (verbatim from commons.tape):
> - 🔵 **SUPPORTED-FORMAL** — closed-form 재현 (예: Allen-Dynes Tc 함수 from λ·ω_log·μ*).
> - 🟢 **SUPPORTED-NUMERICAL** — libm/QE/Newton 재계산 매치 (예: DFT λ_BZ vs literature harmonic).
> - 🟡 **SUPPORTED-BY-CITATION** — atlas/literature 등록만, NO hexa recompute (예: arxiv paper-cited prediction).
> - 🟠 **INSUFFICIENT/DEFERRED** — calc path 없음 or external hw 의존 (예: wet-lab measurement).
> - 🔴 **FALSIFIED** — calc 가 명확히 불일치 (예: ALIGNN Tc 41× under vs measured).
> - ⚪ **SPECULATION-FENCED** — imagination/metaphor.
>
> Stamp: 2026-05-24 · §9.14 fanout 5 LANDED + CaH₆ + H₃S anchor state.

---

## Section A — Measurement-grade DFT anchors (known materials · measured-oracle comparison)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| A1 | **H₃S λ_BZ converges to 2.11–2.62** at 6×6×6 q · 24³ k (broad 0.015–0.030) | `exports/material_discovery/rtsc_h3s_dft_6x6x6q_textbook_proof_20260522.json` · RTSC.md §9.12 | 🟢 SUPPORTED-NUMERICAL | denser q-grid (8³) re-run yields λ outside 2.0–2.7 band → falsify; literature harmonic Errea 2016 λ≈2.2 disagreement >20% → falsify | textbook measurement-grade anchor; high-Tc strong-coupling axis |
| A2 | **H₃S Tc_AD = 175–195 K (μ*=0.10)** vs measured 203 K (Drozdov 2015) | same as A1 · RTSC.md §9.13 | 🟢 SUPPORTED-NUMERICAL | independent QE run on same cell yields Tc outside 170–200 K → falsify | 5–15% within measured · anharmonic SSCHA accounts for residual |
| A3 | **H₃S ω_log ≈ 1170 K** (lambda-weighted log-average from α²F) | same as A1 | 🟢 SUPPORTED-NUMERICAL | re-parse of ph.out a2F.dos with different ω₀ cutoff yields ω_log outside 1100–1250 K → falsify | matches H-derived high-frequency mode (lit. 1300 K harmonic) |
| A4 | **CaH₆ Tc(μ*=0.13) = 213 K** vs measured 215 K (Ma 2022, ambient anchor for clathrate topology — measured under 170 GPa) | `exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json` · RTSC.md §10.1 | 🟢 SUPPORTED-NUMERICAL | 6³ q re-run (the 4³ here is baseline) yields Tc outside 200–230 K → falsify; cell-choice regression (back to ibrav=1 nat=14) reproduces NaN spam → input-error hypothesis confirmed | 2 K parity — 2nd measurement-grade anchor (sodalite clathrate, different topology vs H₃S) |
| A5 | **CaH₆ λ_BZ = 3.40–4.38** at 4×4×4 q · 170 GPa | same as A4 | 🟢 SUPPORTED-NUMERICAL | 6³ q yields λ outside band → falsify; pressure sweep (130/200 GPa) shifts λ outside → confirms pressure-dependence | strong-coupling regime confirmed; clathrate H₂₄ cage |
| A6 | **CaH₆ ω_log = 1177–1236 K** (broadening sweep) | same as A4 | 🟢 SUPPORTED-NUMERICAL | re-parse with different broadening yields ω_log outside band → falsify | high-frequency H-stretch dominates moment |
| A7 | **Nb Tc_AD = 9.9–13 K (μ*=0.13)** vs measured 9.25 K (BCS-textbook ambient SC) | `exports/material_discovery/rtsc_nb_dft_elph_ambient_proof_20260522.json` · RTSC.md §9.13 #2b | 🟢 SUPPORTED-NUMERICAL | 6³ q + denser k → Tc outside 9–14 K → falsify; independent QE build yields different Tc → falsify | ambient-Tc gate-(c) axis proof · 10–40% accuracy = textbook |
| A8 | **Nb λ ≈ 1.0 · ω_log ≈ 192 K** at 4×4×4 q | same as A7 | 🟢 SUPPORTED-NUMERICAL | Re-run with different smearing yields λ outside 0.9–1.1 → falsify | literature-consistent (Allen-Dynes review values) |
| A9 | **H₃S k-grid convergence ladder: λ 0.85 (16³) → 1.15 (under-conv) → 2.3 (6³ q · 24³ k)** | RTSC.md §9.12 · §9.13 capstone | 🟢 SUPPORTED-NUMERICAL | re-run any rung with documented grid yields λ outside ±0.1 → falsify | ladder shows monotone q-convergence; under-convergence diagnostic |

---

## Section B — Novel-prediction DFT (no measured-oracle yet)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| B1 | **h3o Tc(μ*=0.10) = 171–191 K** · λ_BZ = 2.31–2.73 · ω_log = 1089–1111 K (6³ q · 24³ k · novel high-Tc candidate, group-16 light-X sweet spot) | `exports/material_discovery/rtsc_h3o_dft_6x6x6q_novel_20260524.json` | 🟢 SUPPORTED-NUMERICAL | 8³ q convergence → Tc outside 150–220 K → falsify; wet-lab synthesis & R(T) < 100 K → falsify | top novel rank; **but** subsequent imaginary-mode finding (RTSC.md §10.1) downgrades structural reliability — see C8 |
| B2 | **h3cl Tc(μ*=0.10) = 105–134 K** · λ_BZ = 1.14–1.41 · ω_log = 1252 K (6³ q, broadening-monotone = under-converged) | `exports/material_discovery/rtsc_h3cl_dft_6x6x6q_novel_20260524.json` | 🟢 SUPPORTED-NUMERICAL | 8³ q yields Tc outside 90–180 K → falsify; broadening sweep plateaus < 130 K → falsify; wet-lab R(T) absent → defer | dynamically stable (real modes); §9.15 verdict 🔴 FAIL above precommit 25–60 K |
| B3 | **h3f Tc(μ*=0.10) = 31–33 K** · λ_BZ = 0.81–0.82 · ω_log = 652–670 K (6³ q · broadening-stable converged) | `exports/material_discovery/rtsc_h3f_dft_6x6x6q_novel_20260524.json` | 🟢 SUPPORTED-NUMERICAL | 8³ q yields Tc > 40 K → falsify; ω_log re-parse outside 600–700 K → falsify | electronegativity-damage hypothesis confirmation; §9.15 verdict 🔴 FAIL below 50–100 K |
| B4 | **h3si Tc(μ*=0.10) = 77–80 K** · λ_BZ = 1.72–1.82 · ω_log = 572–624 K (6³ q · converged) | `exports/material_discovery/rtsc_h3si_dft_6x6x6q_novel_20260524.json` | 🟢 SUPPORTED-NUMERICAL | 8³ q yields Tc outside 70–90 K → falsify | group-14 sweet spot; §9.15 verdict 🟢 PASS pred 50–110 K |
| B5 | **h3po Tc(μ*=0.10) = 47–48 K** · λ_BZ = 2.75–3.31 · ω_log = 258–273 K (6³ q · 10/16 q-block provisional) | `exports/material_discovery/rtsc_h3po_dft_6x6x6q_novel_20260524.json` · RTSC.md §9.14 | 🟢 SUPPORTED-NUMERICAL | full 16/16 q-block re-run yields Tc outside 40–55 K → falsify | dynamically stable; group-16 heaviest |
| B6 | **H₃Se Tc_AD = 98–128 K (μ*=0.10)** · λ_BZ = 1.03–1.26 · ω_log ≈ 1350 K (6³ q · novel) — Flores-Livas 2016 prediction ~110 K | `exports/material_discovery/rtsc_h3se_dft_6x6x6q_novel_20260522.json` · RTSC.md §9.14 | 🟢 SUPPORTED-NUMERICAL | 8³ q yields Tc outside 90–130 K → falsify; literature cross-check disagreement | matches Flores-Livas PRB 93:020508(R) within band |
| B7 | **H₃Te Tc_AD = 72–76 K (μ*=0.10)** · λ_BZ = 2.25–2.41 · ω_log ≈ 467 K (6³ q · broadening-stable) | `exports/material_discovery/rtsc_h3te_dft_6x6x6q_novel_20260522.json` · RTSC.md §9.14 | 🟢 SUPPORTED-NUMERICAL | 8³ q yields Tc outside 60–80 K → falsify | matches Liu 2017 PRB 96:014505 (50–100 K band); heavy-X group-16 dead-end signal |
| B8 | **group-16 H₃X mass-scaling ladder** — H₃S(195) > h3o(191) > H₃Se(113) > H₃Te(75) > H₃Po(48) — Tc∝1/√m_X monotone reinforced (5-point) | RTSC.md §9.15.A Bayesian update | 🟢 SUPPORTED-NUMERICAL | any group-16 LANDED point outside ladder by >25% → falsify | leading active hypothesis post-4/8 fanout |
| B9 | **group-17 electronegativity-damage axis dominant** — h3f(31, χ=3.98) < h3cl(134, χ=3.16) — mass-scaling inverted vs group-16 | RTSC.md §9.15.A | 🟢 SUPPORTED-NUMERICAL | h3br LANDED yields Tc > h3cl → falsify χ-damage (mass dominates); h3br < h3cl → reinforce | partially falsifies precommit "light X→Tc↑" universal; h3br is the critical next test |

---

## Section C — Precommit hypothesis verdicts (§9.15 closed-loop)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| C1 | **§9.15 8-fanout precommit predictions sealed pre-DFT** — 8 H₃X (h3o · h3f · h3n · h3si · h3p · h3cl · h3as · h3br) with closed-form anchor extrapolation (ω_log ∝ √(μ_HS/μ_HX), λ group-trend, Tc=AD) | RTSC.log.md 2026-05-23 §9.15 entry · RTSC.md §9.14 | 🔵 SUPPORTED-FORMAL | recomputation of any predicted Tc_range from anchor (H₃S λ=2.3, ω_log=1300K) + group hypothesis with documented formula yields band outside cited values → falsify | closed-form prediction; provides verifiable goalpost (d35) |
| C2 | **h3si PASS** — predicted 50–110 K · actual 77–80 K · centered in band | RTSC.log.md §9.15 · B4 | 🔵 SUPPORTED-FORMAL | re-derivation with closed-form formula yields different band → falsify | tetrel group-14 hypothesis validated |
| C3 | **h3o PASS** — predicted 150–220 K · actual 171–191 K · centered | RTSC.log.md §9.15 · B1 | 🔵 SUPPORTED-FORMAL | re-derivation → falsify | group-16 light-X confirmed |
| C4 | **h3cl FAIL above** — predicted 25–60 K · actual 105–134 K (+75% above upper) — broadening-monotone → under-conv caveat | RTSC.log.md §9.15.A · B2 | 🔵 SUPPORTED-FORMAL | 8³ q re-run yields Tc < 60 K (reconciliation toward band) → caveat upheld; if still > 100 K → hypothesis itself falsified | partially falsifies group-17 covalent-suppressed assumption |
| C5 | **h3f FAIL below** — predicted 50–100 K · actual 31–33 K (−38%) — broadening-stable converged | RTSC.log.md §9.15.A · B3 | 🔵 SUPPORTED-FORMAL | re-derivation → falsify | confirms electronegativity-damage > light-X benefit (4/5 outlier evidence) |
| C6 | **PENDING h3n · h3p · h3as · h3br** (4/8 still in pod, ETA +24–29h as of 2026-05-23) | RTSC.log.md 2026-05-23 §9.15 · RTSC.md §9.14 | 🟠 INSUFFICIENT/DEFERRED | predicted bands sealed (above) — wait for DFT delivery to compare | h3br = CRITICAL next test (electronegativity vs volume axis separation) |
| C7 | **Precommit verification protocol** — `|Tc_pred − Tc_sim| < range_width → PASS, else FAIL → trigger hypothesis revision` | RTSC.log.md §9.15 protocol | 🔵 SUPPORTED-FORMAL | independent verifier applies protocol to same 4/8 LANDED and gets different verdict counts → falsify | verifiable rule of evaluation |
| C8 | **h3o/h3f/h3si imaginary phonon modes** (ω_min ≈ −140 meV) — Im-3m metastable, dynamical instability | RTSC.md §10.1 self-DFT augment finding | 🟢 SUPPORTED-NUMERICAL | re-parse ph.out raw mode block yields no imaginary mode → falsify | downgrades h3o from #1 to **non-stable** — Tc 191 K = unstable-mode-drop convention upper-bound, not physically reliable |
| C9 | **#1 stable novel verdict — h3cl** (real modes only, under-converged → 8³ q likely raises Tc 150–180 K) | RTSC.md §10.1 verdict 정정 | 🟢 SUPPORTED-NUMERICAL | 8³ q yields h3cl Tc unchanged or lower → falsify the "8³q raise" hypothesis; another stable candidate (h3po full 16/16) yields higher Tc → re-rank | current best stable novel; verdict re-rank 2026-05-24 |

---

## Section D — ML baselines (BEE-NET · ALIGNN cross-confirmation)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| D1 | **BETE-NET (ambient-trained) Tc rel_err on H₃S = 92.3%, LaH₁₀ = 97.1%, CaH₆ = 91%, YH₆ = 93%** (4-hydride under-prediction) | RTSC.md §9.11.B empirical calibration | 🔴 FALSIFIED | re-run 100-ensemble with same publication-grade CIF yields Tc within 30% of measured → falsify | ambient training-distribution limit · pressure-aware ML / EPW required |
| D2 | **BETE-NET A15 family rel_err 21.7–35.2%** (Nb₃Al · V₃Ga) — sweet spot reliability | RTSC.md §9.11.C family-level finding | 🟢 SUPPORTED-NUMERICAL | independent inference yields A15 rel_err > 50% → falsify | multi-atom strong-coupling phonon-mediated SC = BEE-NET trust region |
| D3 | **ALIGNN ambient ML hydride rel_err ≥97% for H₃S/LaH₁₀/CaH₆/YH₆** (jv_supercon_tc_alignn) — same wall as BETE-NET | RTSC.md §9.11.H cross-model finding | 🔴 FALSIFIED | re-run on pool:ubu-1 with different version yields hydride rel_err < 50% → falsify | confirms cross-architecture ambient-ML wall |
| D4 | **a2F-decomposition: λ_ALIGNN ≈ 0.34–0.48 vs literature λ ≈ 2.0–2.5 for hydrides** (4–5× under) — ω_log roughly correct, failure localized to λ | `exports/material_discovery/rtsc_a2f_allendynes_lambda_diagnosis_20260522.json` · RTSC.md §9.11.I | 🟢 SUPPORTED-NUMERICAL | re-run with same dataset yields λ > 1.5 → falsify; lit. λ < 1.0 → falsify the under-prediction characterization | precise numerical fingerprint of ML failure mode |
| D5 | **BEE-NET fine-tune (h-rich · 5/5 hydrides) λ_pred_mean ≈ 1.20 ± 0.55 for h3o** — but raw individual λ samples range 0.54–3.63 (variance dominates), 100-member ensemble | `/tmp/betenet/results/finetuned/finetune_real.json` h3o block | 🟢 SUPPORTED-NUMERICAL | re-run with different seed yields mean outside 1.0–1.4 → falsify | high σ → all-OOD by ensemble disagreement; FT still cannot resolve to DFT 2.3–2.7 range |
| D6 | **ALIGNN cross-model 9/9 H₃X family-wide d7 wall**: per-cand baseline 9/9 finished, sign-pathology in 3/9 (h3o = −0.42 · h3po = −0.21 · h3n = −0.18) — light-X polar covalent localization → negative λ | RTSC.md §9.14 ALIGNN family table | 🟢 SUPPORTED-NUMERICAL | re-run 9-candidate sweep with documented input.vasp yields different sign pattern → falsify; mathematical anti-bonding projection mechanism reproducible | mechanistic root: α²F grid ceiling 100 meV + anti-bonding projection at acoustic edge |
| D7 | **α²F grid ceiling diagnostic: ALIGNN bin = 0–100 meV · 100-bin, h3cl DFT ω_log = 107.9 meV (above ceiling), h3o = 94.5 meV (truncated tail)** | RTSC.md §9.14 d7 wall mechanistic root | 🔵 SUPPORTED-FORMAL | grid-extension to 140 meV in BEE-NET (Freq_final 51→71 bin) yields same ω_log truncation → falsify | identifies precise structural cause of ML failure (independent of model architecture) |
| D8 | **ALIGNN h3br λ = 1.11 (strong-coupling outlier)** — only group-17 candidate flagged > 1.0 by family-wide ML baseline | RTSC.md §9.14 cycle 7 finding | 🟢 SUPPORTED-NUMERICAL | independent ALIGNN inference yields h3br λ < 0.8 → falsify | critical next DFT cross-check (h3br LANDED would close family-wide loop) |

---

## Section E — Closed-form physics identities (V2 escalation candidates)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| E1 | **Allen-Dynes Tc formula** — Tc = (ω_log/1.2) · exp[−1.04(1+λ)/(λ−μ*(1+0.62λ))] | `~/core/hexa-lang/stdlib/material/sim.hexa allen_dynes_tc` (libm parity 0.0000 K vs Python reference) | 🔵 SUPPORTED-FORMAL | hexa allen_dynes_tc with (λ=2.3, ω_log=1170, μ*=0.10) ≠ 185–195 K → falsify | hexa-native already lands as bit-exact closed-form |
| E2 | **McMillan Tc formula** — Tc = (Θ_D/1.45) · exp[−1.04(1+λ)/(λ−μ*(1+0.62λ))] | sim.hexa mcmillan_tc | 🔵 SUPPORTED-FORMAL | reference test vector fails → falsify | closed-form |
| E3 | **BCS gap ratio 2Δ(0)/k_B·T_c ≈ 3.528** (universal weak-coupling) — Nb 측정 일치 (PR #299 attestation) | `~/core/hexa-lang/stdlib/material/sim.hexa bcs_universal_gap_ratio` · PAPERS/sample-nb-bcs-absorbed/ | 🔵 SUPPORTED-FORMAL | hexa bcs gap-ratio ≠ 3.528 (to 1e-9 precision) → falsify | already attested for Nb at <5% threshold (LTS attestation, not RTSC) |
| E4 | **WHH upper critical field formula** — Hc2(0) = 0.693 · |dHc2/dT|_Tc · T_c | sim.hexa numerics_whh | 🔵 SUPPORTED-FORMAL | hexa whh yields ≠ closed-form for known input → falsify | hexa-native closed-form |
| E5 | **Eliashberg moments — λ = 2∫α²F(ω)/ω dω · ω_log = exp[(2/λ)∫log(ω)·α²F(ω)/ω dω]** | sim.hexa v0.3.0 `eliashberg_moments` (PR #299, 3/3 bit-exact parity vs Python ref) | 🔵 SUPPORTED-FORMAL | hexa moments ≠ Python reference (1e-9) → falsify | DFT α²F OR ML α²F → same kernel |
| E6 | **Inverse-variance consensus** — σ_consensus² = 1/Σ(1/σᵢ²) · μ_consensus = Σ(μᵢ/σᵢ²)/Σ(1/σᵢ²) (cross-code DFT consensus, Nb attestation pattern) | sim.hexa v0.2.0 `inverse_variance_consensus` · `sigma_from_spread` (Phase 4 #1 LANDED 22/22 PASS) | 🔵 SUPPORTED-FORMAL | hexa consensus ≠ Python ref (1e-9) → falsify | bit-exact 22/22 |
| E7 | **Hill formula reduction** — `_hill_formula` (composition string canonicalization for OPTIMADE/JARVIS cross-code lookup) | sim.hexa / cross_code_dft.py `_hill_formula` | 🔵 SUPPORTED-FORMAL | reference vector (e.g., `Ca₁H₆` → `CaH6`) mismatch → falsify | string-formal |

---

## Section F — Atlas / literature claims (no hexa recompute)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| F1 | **arxiv:2401.16611 BETE-NET MAE 0.87 K vs DFT-Allen-Dynes** (Gibson et al., npj Comput. Mater. 11:11, 2025) | RTSC.md §9.2 · §9.8 | 🟡 SUPPORTED-BY-CITATION | full re-train + 5-fold CV on same dataset yields MAE > 2 K → falsify | atlas-registerable; paper-cited |
| F2 | **Nature s41524-026-01964-8 AI-accelerated SC discovery: 1.3M cand → 741 stable** (2026 SOTA workflow) | RTSC.md §9.2 · §9.8 | 🟡 SUPPORTED-BY-CITATION | re-run workflow yields different funnel size by > 2× → falsify | atlas-registerable |
| F3 | **arxiv:2312.12694 — 900+ hydride DFT+DL · 122 stable · Tc > 39K** (high-P universal MLFF) | RTSC.md §9.3 · §9.8 | 🟡 SUPPORTED-BY-CITATION | re-run on same dataset yields different count → falsify | hexa cannot recompute (model weights restricted) |
| F4 | **arxiv:2505.09203 InvDesFlow-AL discovers LiAuH₆ 140 K** (active learning DFT loop) | RTSC.md §9.11.E D2 survey | 🟡 SUPPORTED-BY-CITATION | hexa-side independent DFT on LiAuH₆ yields Tc < 100 K → partial falsify; > 200 K → re-eval | external claim · not hexa-recomputed |
| F5 | **Drozdov 2015 — H₃S measured Tc 203 K @ 150 GPa** (Nature 525:73 — original measurement) | atlas-registerable · cited throughout §9.12 · A2 | 🟡 SUPPORTED-BY-CITATION | independent lab measurement < 150 K or > 250 K → falsify | empirical oracle that A1–A3 DFT was validated against |
| F6 | **Ma 2022 — CaH₆ measured Tc 215 K @ 170 GPa** (Nature 605:147) | atlas-registerable · cited §9.12.A · A4 | 🟡 SUPPORTED-BY-CITATION | independent lab Tc < 180 K or > 240 K → falsify | empirical oracle for CaH₆ DFT |
| F7 | **Errea 2016 — H₃S harmonic λ ≈ 2.2** (NPB 532:81, anharmonic SSCHA reference) | atlas-registerable · §9.12 cite | 🟡 SUPPORTED-BY-CITATION | re-derive from H₃S 24³ k · 8³ q harmonic DFT and find λ outside 2.0–2.4 → falsify | harmonic-DFT systematic 5–15% gap absorbed |
| F8 | **Houston 2026 — Hg1223 pressure-quench Tc 151 K ambient** (D6 survey, RTSC-closest 2024-2026 candidate) | RTSC.md §9.11.E D6 finding | 🟡 SUPPORTED-BY-CITATION | independent lab replication fails → falsify | (a)(c) PASS · (b) 151 < 270 → still gate FAIL · (d) 1 lab only |
| F9 | **arxiv:2509.10293 OpenCSP — deep learning CSP ambient → high-P** | RTSC.md §9.1 · §9.8 | 🟡 SUPPORTED-BY-CITATION | independent re-run yields different stability count → falsify | external |
| F10 | **arxiv:2501.01835 ASKCOS retrosynthesis (MIT)** — synthesis route prediction | RTSC.md §9.1 · §9.8 | 🟡 SUPPORTED-BY-CITATION | independent run on novel hydride yields no route → partial null | external |
| F11 | **Flores-Livas 2016 H₃Se prediction ~110 K** (PRB 93:020508R) | atlas-registerable · §9.14 H₃Se row · B6 | 🟡 SUPPORTED-BY-CITATION | independent DFT yields outside 80–140 K → falsify | matches our DFT 98–128 K |
| F12 | **Liu 2017 H₃Te prediction 50–100 K** (PRB 96:014505) | atlas-registerable · §9.14 H₃Te row · B7 | 🟡 SUPPORTED-BY-CITATION | independent DFT outside 50–100 K → falsify | matches our DFT 72–76 K |

---

## Section G — Pipeline / infrastructure claims

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| G1 | **QE 7.5 (conda) is operational on pool:ubu-1 — apt 6.7 FORTIFY-broken** | RTSC.md §9.11.I · `reference_qe_dft_pool_setup` user-memory | 🟢 SUPPORTED-NUMERICAL | fresh conda re-install yields same Allen-Dynes Tc ladder → reproducible; pool:ubu-3 re-test → reproducible | reproducibility floor |
| G2 | **CaH₆ Sternheimer NaN spam root cause = input cell-choice (ibrav=1 nat=14 conv + press=0 → ibrav=3 nat=7 BCC primitive + 170 GPa fix)** | RTSC.log.md 2026-05-24 entry · A4 verdict | 🟢 SUPPORTED-NUMERICAL | revert to ibrav=1 nat=14 press=0 reproduces NaN spam → confirms; new ibrav=3 + 170 GPa yields NaN > 0 → falsifies fix | input-error diagnosis (not hexa cloud bug) |
| G3 | **process_completed_pod.sh harness — 21/21 schema fields conform, hardcoded absorbed=false** | RTSC.md §9.14 harness row | 🟢 SUPPORTED-NUMERICAL | run on novel pod output yields record with absorbed≠false → falsify | R4 invariant hardcoded |
| G4 | **BEE-NET step0 grid ceiling extension 101→140 meV (`utils/data.py:15` Freq_final 51→71 bin)** — CPU smoke 4/4 PASS · pretrained backbone transferable | RTSC.md §10.3 step0 · commit b1aae78 | 🟢 SUPPORTED-NUMERICAL | re-run smoke yields any of 4 tests FAIL → falsify | path B unblocked |
| G5 | **Phase 1 (N1-N4 wrap-as-is) LANDED at hexa-lang `701bfe1b`** — 4 thin-adapter producers (csp · beenet · askcos · cross_code_dft) | RTSC.md §9.9.1 Phase progress table | 🟢 SUPPORTED-NUMERICAL | git inspect of commit yields different file set → falsify | infrastructure milestone |
| G6 | **Phase 2 16-cell stabilization 15/16 PASS (1 DEVIATION = YBCO × cross_code_dft, AFLOW gap)** → extended 18/20 PASS (5th baseline H₃S) → JARVIS adapter 20/20 PASS | RTSC.md §9.9.1 Phase progress | 🟢 SUPPORTED-NUMERICAL | re-run audit yields different PASS/FAIL count → falsify | audit reproducible |
| G7 | **Phase 4 #1 C1+C2 consensus port — 22/22 parity PASS (≤1e-9 rel · max 3.93e-16)** | RTSC.md §9.9.1 Phase 4 #1 | 🔵 SUPPORTED-FORMAL | re-run parity test yields any > 1e-9 → falsify | bit-exact hexa-native parity |
| G8 | **Phase 4 #2 C3+C4 ASKCOS parser+classifier — 32/32 parity PASS vs Python ground-truth** (regex blocker bypassed via hand-rolled char-scan) | RTSC.md §9.9.1 Phase 4 #2 | 🔵 SUPPORTED-FORMAL | re-run parity yields any FAIL → falsify | hand-rolled (now PR #276 unblocked) |
| G9 | **Vast.ai burn $2.55/h → $1.14/h** (6/11 instances destroyed during cohort wind-down 2026-05-24) | RTSC.log.md 2026-05-23 / 2026-05-24 entries | 🟢 SUPPORTED-NUMERICAL | independent Vast API query yields different running instance count → falsify | operational cost accounting |

---

## Section H — Speculation-fenced (frontier claims)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| H1 | "h3br DFT λ likely > 1.5 if under-conv pattern of h3cl repeats" — strong-coupling outlier hypothesis | RTSC.md §9.14 d7 wall · D8 | ⚪ SPECULATION-FENCED | h3br LANDED with λ < 1.0 → falsify | speculative; awaits LANDED |
| H2 | "8³ q-grid for h3cl raises Tc to 150–180 K (h3o 추월 후보)" | RTSC.md §10.1 verdict | ⚪ SPECULATION-FENCED | 8³ q yields Tc < 120 K → falsify | speculative roadmap |
| H3 | "anharmonic SSCHA stabilizes h3o imaginary modes" (H₃S/LaH₁₀ precedent) | RTSC.md §10.1 imaginary-mode note | ⚪ SPECULATION-FENCED | SSCHA on h3o reveals persistent imaginary modes → falsify | precedent-based speculation |
| H4 | "ambient-pressure superhydride 등장이 RTSC absorbed=true 의 유일한 frontier path" | RTSC.md §9.13 capstone honest 한계 | ⚪ SPECULATION-FENCED | ambient-P SC discovery in non-hydride class (e.g., Hg1223 pressure-quench) achieves Tc ≥ 270 K → falsify | frontier hypothesis · gate OPEN |

---

## Section I — Wet-lab dependent (deferred)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| I1 | **All §8.9 5-gate (b)+(c)+(d) for any current RTSC candidate** — Tc≥270K + ambient + ≥3 lab repl | RTSC.md §8.9 gate matrix | 🟠 INSUFFICIENT/DEFERRED | wet-lab measurement of any candidate yielding gate (b)+(c)+(d) PASS → falsify (gate closes) | wet-lab dependent · no candidate currently qualifies |
| I2 | **Wet-lab R(T)=0 + Meissner + Cp jump 3-test set for h3o/h3cl/h3si novel candidates** | RTSC.md §8.4 falsifier set | 🟠 INSUFFICIENT/DEFERRED | wet-lab synthesis + measurement → PASS/FAIL → tier escalates | external instrument required |
| I3 | **HTS REBCO Jc(B,T,θ) vendor datasheet ingest (SuperPower 2G tape)** | RTSC.md §8.5 handoff schema | 🟠 INSUFFICIENT/DEFERRED | vendor csv ingest → typed record emit → escalates 🟠 → 🟡 | Tier 3 ingest schema designed, source not yet wired |
| I4 | **Hg1223 pressure-quench (Houston 2026) independent ≥3-lab replication** | RTSC.md §9.11.E D6 finding · F8 | 🟠 INSUFFICIENT/DEFERRED | 3rd independent lab confirms Tc 151K @ ambient → tier escalates | replication path = unblock |
| I5 | **Real device-side HTS solenoid Jc/Hc2/quench characterization** — currently µ_r=1 linear approximation only | RTSC.md §4.3 honest scope caveats s1–s4 | 🟠 INSUFFICIENT/DEFERRED | HTS Workgroup benchmark1_tape EUCAS REBCO measurement match within 5% → escalates to 🟢 | currently device-side proxy at GATE_OPEN |

---

## Section J — Falsified (calc clearly mismatched measurement)

| # | claim | source | tier | falsifier | note |
|---|---|---|---|---|---|
| J1 | **ALIGNN Tc-direct on Nb = 51.3 K vs measured 9.25 K (454% over) · Al = 10.7 K vs 1.2 K (810% over) · V = 82.3 K vs 5.4 K (1424% over) · BaPbO₃ = 15.4 K vs 0.5 K (2978% over)** | RTSC.md §9.11.B empirical calibration | 🔴 FALSIFIED | re-run ALIGNN with documented version yields different rel_err → falsify | confirms ML training-distribution failure on 1-atom bulk + bismuthate |
| J2 | **Pattern 1 namespace exploit — historical `rtsc_attestation_nb_bcs_*.json` rejected by R4 Stage 1 RTSC5GateEnforcementTests** | RTSC.md §8.10 Migration completed | 🔴 FALSIFIED | (the historical record itself, declared falsified by structure-only test — R4 invariant) | R4 invariant audit evidence preservation |
| J3 | **Universal "lighter X → ω_log↑ → Tc↑" hypothesis is NOT universal (falsified by group-17 h3f 31 K vs h3cl 134 K, mass-scaling inverted)** | RTSC.log.md §9.15.A | 🔴 FALSIFIED | independent re-derivation rebuilds same falsifier evidence → confirmed | partially falsified — group-16 still monotone, group-17 inverted |

---

## Tier distribution + insight

### Count per tier (current inventory)

| tier | count | section coverage |
|---|---:|---|
| 🔵 SUPPORTED-FORMAL | 14 | §C precommit identities (7) · §E closed-form (7) · §G7 G8 (2) · §D7 (1) — *note: G7/G8 overlap with E counted once* |
| 🟢 SUPPORTED-NUMERICAL | 30 | §A measurement-grade DFT (9) · §B novel DFT (9) · §C8 C9 imaginary mode (2) · §D ML diagnostic (5 — D2,D4,D5,D6,D8) · §G infrastructure (6 — G1,G2,G3,G4,G5,G6) |
| 🟡 SUPPORTED-BY-CITATION | 12 | §F literature/atlas (12) |
| 🟠 INSUFFICIENT/DEFERRED | 6 | §C6 PENDING fanout + §I wet-lab (5) |
| 🔴 FALSIFIED | 3 | §D ALIGNN/BETE-NET hydride (D1+D3 = 2 falsified) · §J calc-falsified (3) — overlap normalization: D1+D3+J1+J2+J3 = 5 distinct rows, deduplicated to 3 unique findings |
| ⚪ SPECULATION-FENCED | 4 | §H frontier (4) |
| **TOTAL** | **~52 unique claims** | (some claims span multiple tiers · count = primary tier assignment) |

### 🟢 → 🔵 escalation candidates (closed-form reproducible by hexa-native — V2 push targets)

V2 (next step in V-series) will push 🟢 → 🔵 by closed-form re-derivation. Best targets:

1. **A1–A3 H₃S λ/Tc/ω_log** — already have `eliashberg_moments` + `allen_dynes_tc` hexa-native (E1, E5). Re-deriving from α²F(ω) table (output of QE ph.x) closes 🟢 → 🔵 if a2F.dos ingest adapter lands.
2. **A4–A6 CaH₆ λ/Tc/ω_log** — same chain. Same hexa kernels apply.
3. **A7–A8 Nb λ/Tc** — already 🟢. PR #299 `bcs_universal_gap_ratio` (E3) attests Nb at 🔵-grade for BCS-ratio axis; the AD axis is also escalatable.
4. **C1 §9.15 closed-form precommit ω_log extrapolation** — re-derive `ω_log_X = ω_log_S · √(μ_HS/μ_HX)` in hexa-native → bit-exact reproduction across 8 candidates → 🔵.
5. **B8 group-16 mass-scaling Tc∝1/√m_X** — escalates to 🔵 if hexa-native fit yields ladder reproduction within tolerance.
6. **D7 α²F grid ceiling diagnostic** — already 🔵 (purely structural); deduplicate from 🟢 lift list.

Estimated work: ~150 LOC `stdlib/material/sim.hexa` extensions (a2F.dos parser + moment extractor — partially already in `eliashberg_moments`) + 1 closed-form harness producer. ROI: 8–10 claim escalations.

### 🟠 → 🟢/🟡 nearest unblock (one tool / dataset / calc raises a tier)

1. **C6 PENDING 4/8 fanout (h3n · h3p · h3as · h3br)** — single tool: complete pod harvest (ETA already < 24h for h3br). Raises 🟠 → 🟢 by direct DFT delivery. **CRITICAL h3br = group-17 electronegativity-vs-volume axis separation**.
2. **I3 HTS REBCO Jc datasheet ingest** — single dataset: SuperPower 2G HTS tape Jc(B,T,θ) csv. Raises 🟠 → 🟡 immediately, → 🟢 after recomputed cross-check with HTS Workgroup benchmark1_tape.
3. **I5 cube_producer H-formulation benchmark1_tape EUCAS comparison** — single calc: GetDP 4.0.0 on benchmark1_tape mesh, compare to EUCAS measurement table. Raises 🟠 → 🟢 (device-side gate-(c) parity).
4. **I4 Hg1223 Houston 2026 replication path** — external (independent lab) but atlas can register the F8 citation upgrade to 🟡 immediately; tier escalation contingent on replication.
5. **G4 BEE-NET step1–step4 (DFT→α²F target formalization → fine-tune)** — already step0 LANDED. step1-3 unblocked; step4 = single GPU dispatch (~12–20 GPU-hr A100). Raises path B to a 🟢 ladder of FT predictions.

### 🔴 explicit falsifications (recorded for d6 + d2 governance audit trail)

- **J1 ALIGNN/BETE-NET hydride under-prediction by 91–98%** + Pb/Al/Nb/V/BaPbO₃ over-prediction up to 2978% (BETE-NET ambient-trained training-distribution wall — confirmed across 2 architectures). Pattern d6 broken successfully ("first-principles physics breaks the ML training-distribution wall") · DFT 6³ q anchors A1–A8 recover.
- **J3 universal "lighter X → Tc↑" precommit hypothesis** — partially falsified by h3f vs h3cl mass-scaling inversion within group-17 (electronegativity-damage axis dominates within halides; group-16 ladder remains monotone). Bayesian update absorbed in §9.15.A 2026-05-23.
- **J2 R4 namespace exploit (historical rtsc_attestation_nb_bcs)** — structurally rejected by RTSC5GateEnforcementTests, preserved as audit evidence (not deleted).

---

## SSOT references (provenance chain)

- **Numerical authority** (overrides snapshots): `exports/material_discovery/rtsc_*.json` (9 LANDED + 1 anchor + 1 CaH₆) · `exports/material_attestation/nb_bcs_v1/lts_attestation_*.json` · `/tmp/betenet/results/finetuned/finetune_real.json`.
- **State matrix** (current): `RTSC.md` §3, §9.14, §9.15, §10.1.
- **Chronicle**: `RTSC.log.md` 2026-05-21 → 2026-05-24 entries.
- **Governance**: `@D d1` (drive non-wet-lab to completed-form) · `@D d2` (wall → breakthrough paths) · `@D d5` (absorbed=true ⇔ measured-oracle PASS) · `@D d6` (first-principles breaks ML wall) · `@D d7` (compute sizing).
- **Cross-domain V-series**: this is RTSC's V1 inventory; companion V2 (🔵 push: closed-form identities) · V3 (🟢 push: numerical recompute) · V4 (final tier ledger) planned per RTSC.md milestone V-row.

---

## Honest scope (this inventory's own limits)

- **R4 invariant intact**: all 🟢 claims are Tier-1 predictions (DFT or hexa-native closed-form, not measured-oracle). No claim in this inventory upgrades any record to `absorbed=true`. Per @D d5, only Section A's measurement-oracle parity (within 5–15%) is *evidence for* the pipeline's measurement-grade capability — not for the candidate's RTSC status (§8.9 gate-(b)+(c)+(d) all still OPEN).
- **Range vs point value**: many DFT entries report `λ_BZ` and `Tc_AD` as broadening ranges (typically 4 broadenings 0.015–0.030 Ry). The range itself is the claim — point values within would constitute over-claiming. Reviewers should treat overlap with measured value as *partial concord*, not exact match.
- **Imaginary-mode caveat**: h3o (B1) — Tc 191 K is `unstable-mode-drop` convention upper-bound; structural reliability downgraded by C8 finding. The claim is preserved in the inventory at 🟢 (numerical reproducibility of the parsing path is intact), but operational ranking (RTSC.md §10.1) moves h3o below h3cl. This split is intentional — tier reflects evidence reproducibility, not policy ranking.
- **Atlas/citation tier (🟡)**: §F claims are atlas-registerable but not hexa-recomputed. Upgrading to 🟢 requires either (a) ingest of the cited dataset + hexa-native re-derivation, or (b) an independent calc producing the same value. Currently none of F1–F12 has been re-derived.
- **inventory is a snapshot, not a contract**: §9.14 fanout has 4/8 LANDED at file-write time. PENDING rows (C6) will graduate to 🟢 or 🔴 within ~24-29h ETA, requiring inventory refresh. The V2/V3/V4 path SHOULD be re-run when fanout closes.
