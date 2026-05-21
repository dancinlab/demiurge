# NUCLEAR — Nuclear Discovery Simulation Stack (5-gate · N6–N10 cohorts)

> Sibling of `RTSC.md` §9 (compositional discovery — *new SC material*). NUCLEAR.md target = *elemental discovery* — superheavy / drip-line **nuclides**. Same R4 invariant family (`absorbed=false` 영구 · prediction never claims measurement).

---

## §1. Goal

Build a 5-gate simulation funnel that **proposes top-K candidate nuclides** (superheavy `Z > 118` + neutron-rich / proton-rich drip-line) for accelerator beam-time priority. The stack:

- **CAN**: predict mass + binding energy (HFB) · deformation (RMF) · α-decay half-life (WKB cluster) · drip-line for light nuclei (ab-initio NCSM / CCSD / IM-SRG) · shell-model spectroscopy (KSHELL / BIGSTICK).
- **CANNOT**: synthesize a new atom (needs GSI / JINR / RIKEN heavy-ion accelerator beam-time) · detect it (needs SHIP / DGFRS / GARIS recoil separator + measurement chain).

R4 invariant — every nuclear record carries `gate_type = nuclear-novel-discovery-simulation` + `absorbed = false 영구`. Sim PASS = "this nuclide is worth wet-lab priority", NOT "this nuclide exists".

Mirror of RTSC §9 (compositional) for elemental:

| stack          | discovery axis              | g3 honest verdict on `absorbed=true` |
|----------------|------------------------------|----------------------------------------|
| RTSC §9        | new SC composition (a)(b)(c) | impossible from sim alone (§8.9)       |
| NUCLEAR (this) | new nuclide (a)(b)(c) → (d)(e) wet-lab | impossible from sim alone (§3 below)   |

---

## §2. 5-gate nuclear taxonomy

Mirror of RTSC §9.7 (a–e). Honest verdict per gate identical in shape: (a)(b)(c) sim-sufficient · (d)(e) wet-lab dependent permanently.

| gate | content | sim coverage | wet-lab dependence |
|------|---------|--------------|--------------------|
| **(a)** | Nuclear structure — mass + binding energy + deformation `(Z, N)` | HFB / RMF / FRDM mass-table inputs → DFT-of-nucleus predict | sim sufficient · ±0.5–1.5 MeV typical |
| **(b)** | Spectroscopic structure — shell-model level structure, B(E2), B(M1) | KSHELL / NuShellX / BIGSTICK / ANTOINE Lanczos | sim sufficient for valence-space tractable cases |
| **(c)** | Decay channels — α / β / spontaneous-fission half-life | WKB cluster model + Geiger-Nuttall + UNEDF predictors | sim sufficient · scatter 10× typical |
| **(d)** | Production cross-section for SHE synthesis (fusion-evaporation σ) | HIVAP / DNS / KEWPIE2 / NRV channels | ★ **WET-LAB DEPENDENT** — sim gives σ within ~10× of experiment, never alone confirms |
| **(e)** | Detection signature — SHIP / DGFRS / GARIS analysis | (no honest sim — the recoil-separator beam-line IS the measurement) | ★ **WET-LAB DEPENDENT** — sim NEVER substitutes for accelerator beam-time |

### §2.1 Gate verdict honest table (mirror RTSC §9.6)

| gate     | sim PASS 의 의미                                                         |
|----------|---------------------------------------------------------------------------|
| (a) PASS | HFB predicts bound state with reasonable Sn / Sp → *not yet observed atom* |
| (b) PASS | shell model predicts low-lying level structure → spectroscopy *prediction* |
| (c) PASS | T₁/₂ predicted ∈ μs-ms range (SHE) or longer (drip-line) → *prediction*    |
| (d) PASS | σ ≥ 1 pb @ optimal projectile-target combo → *accelerator priority hint*   |
| (e) PASS | (gate (e) has no meaningful sim PASS — only wet-lab)                       |

→ 5-gate **sim** PASS → `gate_type = nuclear-novel-discovery-simulation` · `absorbed = false 영구`. R4 invariant identical to RTSC §9 form.

---

## §3. Honest invariants (g3 — non-negotiable)

### §3.1 R4 carry over from RTSC

Identical wording to RTSC §9.10 N5 g3:
- **`absorbed=false 영구`** — no nuclear record EVER flips to `absorbed=true`. That promotion requires GSI / JINR / RIKEN heavy-ion accelerator beam-time + SHIP-class separator detection + decay-chain identification. OUT OF SCOPE for this stack.
- **`gate_type=nuclear-novel-discovery-simulation`** — new shape value (mirror of RTSC §9.10 N5 `novel-discovery-simulation`).
- **"가능성" ≠ "임"** — record headlines must read "Z=119 후보일 가능성" never "Z=119 후보임" or "Z=119 발견됨". RTSC §8.10 LK-99 / Nb attestation honest-correction pattern.

### §3.2 (d)(e) wet-lab dependency — permanent

Even if (a)(b)(c) all PASS:
- (d) σ-prediction can be off by 10× — fusion-evaporation cross-section is famously hard (HIVAP statistical model, DNS dinuclear-system model, KEWPIE2 — each ~10× scatter is common).
- (e) detection involves recoil-separator efficiency, GSI/JINR's actual implant pad, alpha-decay chain verification, time-of-flight discrimination — *physical hardware*. No sim model substitutes.

→ NUCLEAR stack output is **a ranked top-K nuclide candidate list for accelerator priority**, not a discovery claim.

### §3.3 No fabrication

If HFBTHO / KSHELL / KEWPIE2 binaries are not available on the host:
- **`install-gated` is the PASS verdict** (mirror RTSC §9.9.1 Phase 1 wrap-as-is — *honest skip is acceptable first-land*).
- Don't invent numerical results. Don't synthesize plausible-sounding mass tables. Citation rigor: every record emits `citations: [arxiv:..., NSDC link, paper DOI]`.

### §3.4 Half-life threshold caveat (cross-stack)

- Z > 118 superheavy half-lives are typically μs–ms (oganesson: 0.7 ms; Ts: ~50 ms; Mc: ~150 ms; predicted Z=119 / 120: similar μs–ms range).
- **SHE that wouldn't form crystals = irrelevant for RTSC carryover**. The two stacks (RTSC = compositional, NUCLEAR = elemental) are *parallel funnels*, not unified — acknowledge but don't conflate.

### §3.5 Citation rigor (R4 protection)

Every cohort record emits:
- `citations: [arxiv:..., NSDC link, paper DOI]`
- `provenance.primary_refs` — at least one peer-reviewed reference per claim.
- `scope_caveats` — at least 3 lines including (i) sim ≠ measurement, (ii) 5-gate evaluation incompleteness, (iii) backend-specific limitations.

---

## §4. Cohort spec (N6 – N10)

Numbering continues from RTSC §9 (N1–N5). Mirror of RTSC §9.7 4-cohort + §9.10 N5 pattern.

| cohort  | role                                                | external lib candidates                                              | path        |
|---------|------------------------------------------------------|------------------------------------------------------------------------|-------------|
| **N6**  | Nuclear mass + binding energy + deformation `(Z,N)` | HFBTHO (Skyrme HFB) · HFODD · UNEDF · BSk22/24/27 · FRDM2012           | B (wrap-as-is) |
| **N7**  | α-decay · spontaneous fission · β-decay half-life   | WKB cluster (closed-form, libm-only) · Geiger-Nuttall · UNEDF half-life | A candidate (small closed-form kernel) |
| **N8**  | Fusion-evaporation σ for SHE synthesis              | HIVAP · DNS · KEWPIE2 · NRV                                            | B (wrap-as-is) |
| **N9**  | Shell-model spectroscopy (B(E2), B(M1), levels)     | KSHELL · NuShellX@MSU · BIGSTICK · ANTOINE                             | B (wrap-as-is) |
| **N10** | Ab-initio drip-line (light nuclei)                  | NCSM · CCSD · IM-SRG · symplectic NCSM                                 | B (wrap-as-is) |

### §4.1 N6 — HFB mass + binding energy + deformation

- **Primary backend**: HFBTHO 3.00+ — Skyrme HFB axially deformed, Fortran 95, open-source.
- **Cited cross-validation**: BSk22/24/27 (Goriely et al.) functional family — 8 multi-functional outputs for σ-spread estimation (mirror of N4 cross-code DFT pattern from RTSC §9.4).
- **Reference table fallback**: FRDM2012 (Möller-Nix 2012) — openly cited mass table covering Z=8–110, N=8–250.
- **Input**: `(Z, N)` pair (or list for batch).
- **Output**: mass excess (MeV) · binding energy per nucleon · β2 (quadrupole) · β4 (hexadecapole) deformation · 2-σ uncertainty band.

### §4.2 N7 — α / β / SF half-life

- **Primary form**: WKB cluster model (Gamow penetrability + preformation factor). Small closed-form kernel — Path A candidate after wrap-stabilization (Phase 4 of RTSC §9.9.1 schedule).
- **Cited form**: Geiger-Nuttall log T₁/₂ = a·Q_α^{-1/2} + b — empirical 2-parameter fit (Royer, Viola-Seaborg variants).
- **UNEDF half-life predictors**: density-dependent cluster model (DDCM) by Royer / Ren / Xu — published parameter tables, no install.
- **Input**: `(Z, N, Q_α)` — Q_α from N6 mass output (chained).
- **Output**: log T₁/₂ (s) · α-branching ratio prediction · honest spread vs. published Geiger-Nuttall scatter.

### §4.3 N8 — fusion-evaporation cross-section

- **Backends**: HIVAP (statistical evaporation model) · DNS (dinuclear system, Adamian/Antonenko) · KEWPIE2 (Vance/Hagino) · NRV web-resource (atomic-data.jinr.ru/NRV).
- **★ Wet-lab dependent gate**: σ prediction is famously off by 10× — sim gives accelerator priority hint, NEVER confirmation.
- **Input**: `(Z_proj, A_proj, Z_target, A_target, E_lab)` quintuple.
- **Output**: σ (pb or fb) for evaporation channels (1n, 2n, 3n, 4n, 5n, αxn) · honest 10× scatter caveat.

### §4.4 N9 — shell-model spectroscopy

- **Backends**: KSHELL (Shimizu, Lanczos) · NuShellX@MSU (Brown) · BIGSTICK (Johnson, OpenMP/MPI) · ANTOINE (Caurier, original).
- **Massive numerical infrastructure** — `_setup/` install footprint typically 1–10 GB.
- **Input**: `(Z, N)` + valence space (e.g., `pf-shell`, `sd-shell`, `sdpfm`) + interaction (USDA/USDB/KB3G/GXPF1).
- **Output**: low-lying level energies (MeV) · B(E2) (e²fm⁴) · B(M1) (μ_N²) · 2-σ band from cross-interaction comparison.

### §4.5 N10 — ab-initio drip-line (light nuclei)

- **Backends**: NCSM (Navratil/Barrett No-Core Shell Model) · CCSD (Hagen/Papenbrock coupled cluster) · IM-SRG (Hergert/Bogner in-medium SRG) · symplectic NCSM.
- **Scope**: A ≤ 30 (NCSM/CCSD basis explosion) — proton drip-line + neutron drip-line for light elements.
- **Input**: `(Z, N)`, A ≤ 30 nominally.
- **Output**: ground-state energy (MeV) · proton/neutron separation energies Sp/Sn · drip-line flag (Sp < 0 or Sn < 0).

---

## §5. External library survey

### §5.1 N6 — mass / structure

| tool | algorithm | license | source |
|------|-----------|---------|--------|
| **HFBTHO** | Axially deformed Skyrme HFB | open-source | https://gitlab.com/hfbtho/hfbtho · github mirror |
| **HFODD** | Triaxial Skyrme HFB (more general) | open-source | github.com/skyrme-hfb/hfodd |
| **UNEDF** | Universal Nuclear Energy Density Functional | open results | unedf.mps.ohio-state.edu (legacy URL) |
| **BSk22/24/27** | Brussels-Skyrme functional family (Goriely/Chamel/Pearson) | published tables | arxiv:1607.06961 (BSk32 release) |
| **FRDM2012** | Finite-Range Droplet Model (Möller, Nix) | published table | arxiv:1508.06294 (release paper) |

### §5.2 N7 — half-life

| tool | form | source |
|------|------|--------|
| WKB cluster (closed-form) | Gamow penetrability × preformation factor | libm-only ~50–100 LOC kernel |
| Geiger-Nuttall (Royer 2000) | log T₁/₂ = a·Q^{-1/2} + b | published parameters |
| Viola-Seaborg | same shape, different params | published |
| UNEDF half-life (Goriely et al.) | density-dependent cluster | published tables |

### §5.3 N8 — fusion-evaporation

| tool | model | source |
|------|-------|--------|
| **HIVAP** | statistical evaporation (Reisdorf) | request from authors; legacy Fortran |
| **DNS** | dinuclear system (Adamian/Antonenko) | publications + Dubna codes |
| **KEWPIE2** | Vance/Hagino | github.com/kewpie2 |
| **NRV** | JINR atomic-data nuclear reactions video | http://nrv.jinr.ru/nrv/ (web) |

### §5.4 N9 — shell model

| tool | core | source |
|------|------|--------|
| **KSHELL** | Shimizu Lanczos | https://sites.google.com/alumni.tsukuba.ac.jp/kshell-nuclear |
| **NuShellX@MSU** | Brown | https://people.frib.msu.edu/~brown/resources/resources.html |
| **BIGSTICK** | Johnson, OpenMP/MPI | https://github.com/cwjsdsu/BigstickPublick |
| **ANTOINE** | Caurier (legacy) | http://www.iphc.cnrs.fr/nutheo/code_antoine/ |

### §5.5 N10 — ab-initio

| tool | method | source |
|------|--------|--------|
| **NCSM** | No-Core Shell Model | Navratil's group · published parameters |
| **CCSD / CCSDT** | coupled cluster | Hagen/Papenbrock (ORNL) |
| **IM-SRG** | in-medium SRG | Hergert/Bogner (MSU) |
| **symplectic NCSM** | Sp(3,R) basis | Dytrych/Draayer (LSU) |

### §5.6 Data corpora (cross-validation)

- **IAEA NSDC** — `nds.iaea.org/relnsd/` (live evaluated nuclear data)
- **AME 2020** (Wang/Audi/Kondev) — `https://www-nds.iaea.org/amdc/` (mass evaluation tables)
- **NUBASE 2020** — half-life + decay-mode evaluation companion to AME
- **JINR NRV** — `http://nrv.jinr.ru/nrv/` (low-energy nuclear reactions video)

---

## §6. Phase 1 land target

Mirror of RTSC §9.9.1 Phase 1 wrap-as-is — single-cohort first-land, then sweep.

### §6.1 N6 first (HFBTHO wrap)

**Rationale**: HFBTHO is the most-mature open-source HFB binary · BSk22/24/27 cross-validation reference table is openly cited · matches RTSC §9 N4 cross-code DFT pattern (sim_adapter → mp_query → csp_adapter shape) closest.

**Adapter**: `hexa-lang/stdlib/nuclear/hfbtho_adapter.py`

**Honest skip paths** (mirror RTSC §9.9.1 Phase 1):
1. **`install-gated`** — HFBTHO binary not on PATH and `$HFBTHO_BIN` env var unset. Skip with install hint.
2. **`weights-missing`** — BSk parameter files (`.dat`) not in `$HFBTHO_PARAM_DIR`. Skip with download hint (Brussels-Nuclear-Library URL).
3. **`network-fail`** — IAEA NSDC AME2020 fetch failed (offline / endpoint down). Skip; record retains `gate_type=install-gated` to surface honesty.

**CLI**:
```
python3 stdlib/nuclear/hfbtho_adapter.py <Z> <N> <out_dir>
```

**Output**: `exports/nuclear_discovery/<run_stamp>/n6_<Z>_<N>.json`

**Record schema**:
```
{
  "domain": "nuclear",
  "verb": "verify",
  "kind": "hfb_mass_prediction",
  "gate_type": "nuclear-novel-discovery-simulation" | "install-gated",
  "absorbed": false,
  "provisional": true,
  "query": { "Z": ..., "N": ... },
  "backend_probe": { ... },
  "scope_caveats": [...],
  "citations": [...],
  ...
}
```

### §6.2 Phase 2+ deferred

- **N7 WKB** small closed-form kernel — same session if budget allows, else next session.
- **N8 / N9 / N10** wraps — separate sessions (each external lib install audit non-trivial).
- **N6–N10 stabilization audit** — mirror RTSC §9.9.1 Phase 2 (4-baseline × 5-cohort sanity matrix). Baseline candidates: Z=118 Oganesson (known), Z=119 (predicted SHE), Z=120 (predicted SHE), drip-line ⁸B (proton), drip-line ²⁴O (neutron).
- **N11 funnel cohort** — mirror RTSC §9.10 N5 compositional-explorer for nuclides: enumerate `(Z, N)` candidate space, rank by (a)(b)(c) composite score, emit top-K accelerator priority list.

### §6.3 Phase progress (2026-05-22 update · mirror RTSC §9.9.1 Phase progress table · D116 demiurge=pointer)

| Phase | 상태 | hexa-lang SSOT | demiurge pointer |
|---|---|---|---|
| Phase 1 (N6 + N7 wrap-as-is land) | ✅ **LANDED** | hexa-lang `nuclear-discovery-phase1` · `stdlib/nuclear/{hfbtho_adapter,wkb_alpha_decay}.py` | `inbox/notes/2026-05-22-nuclear-discovery-system-launch.md` |
| Phase 2 (5-baseline × 2-cohort = 10-cell stabilization audit) | ✅ **LANDED** · 10/10 PASS · 0 absorbed=true · 8 install-gated + 2 simulation (²³⁸U + ²⁹⁴Og) · ²⁹⁴Og anchor reproduced (-2.93±0.22 dex vs obs -3.15) · ²³⁸U +0.30 dex deviation honest (low-Q_α calibration edge) | (audit only) | `inbox/notes/2026-05-22-nuclear-9-phase2-stabilization.md` |
| Phase 3 (microkernel identification audit · N6+N7) | ✅ **LANDED** (rolled into Phase 2 audit §7) · NC1 (`_viola_seaborg_log10_t`) · NC2 (`_royer_log10_t`) · NC3 (`_consensus`) — all in N7 · N6 = 0 candidates (HFB SCF anti-pattern carve-out) | (audit only) | `inbox/notes/2026-05-22-nuclear-9-phase2-stabilization.md` §7 |
| Phase 4 #1 (Path A microkernel port · NP1 bundle = NC1+NC2+NC3) | ✅ **LANDED** · 250 LOC actual · `stdlib/nuclear/sim.hexa` v0.1.0 (new module · mirror of `stdlib/material/sim.hexa` v0.2.0) · **31/31 parity PASS** · all rel_err=0.0 IEEE 754 bit-for-bit · ²³⁸U + ²⁹⁴Og Phase 2 anchors reproduced verbatim (regression=0) · NC3 dedicated struct (Option B · MIRROR comment to material/sim.hexa Consensus) | hexa-lang `bf16ebdd` (`stdlib/nuclear/sim.hexa` v0.1.0) | `inbox/notes/2026-05-22-nuclear-phase4-1-parity-verify.md` |
| Phase 5 (N8/N9/N10 wrap land) | ⏳ **DEFERRED** · per Phase 1 launch note §10 (separate sessions per external lib install audit) | — | — |
| Phase 6 (N11 funnel cohort · mirror RTSC §9.10) | ⏳ **DEFERRED** · enumerate (Z, N) candidate space, rank by (a)(b)(c) composite, emit top-K accelerator priority list | — | — |

#### Phase 2 honest blockers (resolved · documented · or carry-forward)

- **HFBTHO binary not in env** (expected · honest-skip is PASS) — install path documented in adapter `_INSTALL_HINTS["hfbtho"]`.
- **FRDM2012 `.dat` mass table not in env** (expected · honest-skip is PASS) — lightest install path; Phase 3 follow-on: `_fetch_frdm2012()` helper.
- **BSk22/24/27 tables not in env** (expected · honest-skip is PASS) — same install class as FRDM.
- **²⁹⁹Uue N6→N7 chain dependency** (informational) — N7 install-gates when N6 install-gates rather than fabricating Q_α from external mention; honest cascade per §3.3 "Don't invent" rule.
- **Brown 1992 / SemFIS-2 third formula honest-skipped** — published coefficients don't reproduce SHE regime within honest spread; re-derivation would mis-cite. Phase 3+ follow-on: substitute Denisov-Khudenko 2009 with verbatim coefficients.

---

## §7. R4 invariant block — explicit wet-lab dependency (mirror RTSC §8.10 honest-correction pattern)

> Every nuclear sim record must read in headline / scope_caveats:
>
> **"Z=119 후보일 가능성"** — sim says: "if synthesized + detected, this (Z, N) point should sit at this binding-energy / half-life region of the chart". The record is a *prediction* — it does NOT, and CANNOT, claim "Z=119 후보임" or "Z=119 발견됨" or "Z=119 atom exists".
>
> **What promotion to `absorbed=true` would require** (out of scope, permanent):
> 1. Heavy-ion accelerator beam-time at GSI / JINR / RIKEN (or future FRIB-class facility).
> 2. SHIP / DGFRS / GARIS recoil-separator detection chain.
> 3. Decay-chain identification (α-decay correlations to known daughter nuclide).
> 4. Independent replication at a second laboratory (mirror of RTSC §8.9 5-criteria gate (d)).
> 5. IUPAC / IUPAP Joint Working Party priority assignment + name approval.
>
> None of (1)–(5) is achievable from simulation. R4 invariant `absorbed=false 영구` is therefore identical to RTSC §9 — **hardcoded** in each producer, NOT a runtime decision.

### §7.1 Honest correction stance (preemptive)

If any future record (NUCLEAR or hexa-lang stdlib/nuclear adapter) ever surfaces `absorbed=true` for a sim-only prediction, that record is a **g3 violation** in the RTSC §8.10 Nb-attestation honest-correction pattern. The producer must be rejected.

---

## §8. Citations + Web URLs

### §8.1 arxiv primary references

- `arxiv:1607.06961` — Goriely et al., "Further explorations of Skyrme-Hartree-Fock-Bogoliubov mass formulas. XV. The spin-orbit coupling" (BSk family)
  - https://arxiv.org/abs/1607.06961
- `arxiv:1508.06294` — Möller et al., "Nuclear ground-state masses and deformations: FRDM(2012)"
  - https://arxiv.org/abs/1508.06294
- `arxiv:2103.07016` — Modern HFB / EDF nuclear-mass review
  - https://arxiv.org/abs/2103.07016
- `arxiv:2208.11471` — SHE production cross-section review / KEWPIE2-class analysis
  - https://arxiv.org/abs/2208.11471
- `arxiv:1810.10825` — HFBTHO 3.00 release paper (Stoitsov / Schunck / Kortelainen / Nazarewicz / Ring / Werner — axially-deformed Skyrme HFB)
  - https://arxiv.org/abs/1810.10825
- `arxiv:2004.06135` — UNEDF (Universal Nuclear Energy Density Functional) program review
  - https://arxiv.org/abs/2004.06135
- `arxiv:nucl-th/0510074` — Royer Geiger-Nuttall / WKB α-decay analytic-formula paper
  - https://arxiv.org/abs/nucl-th/0510074
- `arxiv:1611.07916` — AME2016 (predecessor to AME2020) — `Audi / Wang / Kondev`
  - https://arxiv.org/abs/1611.07916
- `arxiv:2105.01035` — AME2020 release (Wang / Huang / Kondev / Audi / Naimi)
  - https://arxiv.org/abs/2105.01035

### §8.2 Library / data URLs

- **HFBTHO** — https://gitlab.com/hfbtho/hfbtho
- **UNEDF** — https://unedf.mps.ohio-state.edu (legacy) · https://nucleartheory.cscs.ch (CECAM)
- **IAEA NSDC** (live evaluated nuclear data) — https://nds.iaea.org/relnsd/
- **AME 2020 mass evaluation** — https://www-nds.iaea.org/amdc/
- **NUBASE 2020 half-life evaluation** — https://www-nds.iaea.org/amdc/
- **JINR NRV** (nuclear reactions video) — http://nrv.jinr.ru/nrv/
- **KSHELL** — https://sites.google.com/alumni.tsukuba.ac.jp/kshell-nuclear
- **BIGSTICK** — https://github.com/cwjsdsu/BigstickPublick
- **NuShellX@MSU** — https://people.frib.msu.edu/~brown/resources/resources.html
- **Brussels Nuclear Library** (BSk parameter files) — http://www-astro.ulb.ac.be/bruslib/

### §8.3 Cross-stack reference

- **RTSC.md §9** (compositional discovery sibling) — same R4 invariant family. NUCLEAR ↔ RTSC = elemental ↔ compositional. Same `gate_type` mechanic, distinct discovery axis.
- **RTSC.md §8.10** (Nb-attestation honest-correction precedent) — template for "sim-PASS ≠ measurement" g3 correction language.
- **RTSC.md §8.7 Tier 1** (Computational synthesis tier) — NUCLEAR is the nuclear-physics analog of RTSC Tier 1 material synthesis; Tier 2–4 (recipe / measurement / falsifier) are intrinsically wet-lab and out-of-scope.

---

## Log

- **2026-05-22 KST** — **NUCLEAR.md neu**. 5-gate nuclear discovery sim stack — sibling of RTSC.md §9 (elemental discovery vs compositional discovery, same R4 invariant family). Sections: §1 goal · §2 5-gate taxonomy (a)(b)(c) sim · (d)(e) wet-lab · §3 honest invariants (R4 carry over · wet-lab dependency permanent · half-life cross-stack caveat · citation rigor) · §4 cohort spec N6-N10 · §5 external library survey (HFBTHO · UNEDF · BSk · FRDM · KSHELL / BIGSTICK / NuShellX · NCSM/CCSD/IM-SRG) · §6 Phase 1 land target (N6 HFBTHO wrap-as-is first) · §7 R4 invariant block (5-step promotion path · all five out-of-scope) · §8 citations + URLs (9 arxiv IDs + 11 library / data corpora). Honest: every record carries `gate_type=nuclear-novel-discovery-simulation` + `absorbed=false 영구`. Sim PASS = wet-lab accelerator priority hint, NEVER discovery claim.
- **2026-05-22 KST** — **§6.3 Phase progress 신설** + **Phase 2 stabilization audit LANDED**. 5-baseline (²³⁸U · ²⁰⁸Pb · ²⁹⁴Og · ²⁹⁹Uue · ⁸B) × 2-cohort (N6 · N7) = 10-cell matrix. 10/10 PASS · 0 absorbed=true · 8 install-gated + 2 simulation (²³⁸U log T=17.45±0.21 dex vs obs 17.15 = +0.30 deviation honest at low-Q_α calibration edge · ²⁹⁴Og log T=-2.93±0.22 dex vs obs -3.15 = anchor reproduced from Phase 1). R4 invariant intact. Brown 1992 / SemFIS-2 third-formula re-derivation status: **honest-skipped** per §3.3 "Don't invent" rule — Phase 3+ may substitute Denisov-Khudenko 2009 with verbatim coefficients. Phase 3 microkernel candidates identified (preliminary): NC1 (`_viola_seaborg_log10_t`) · NC2 (`_royer_log10_t`) · NC3 (`_consensus`) all in N7; N6 = 0 candidates (HFB SCF anti-pattern carve-out per §3.3). Audit note: `inbox/notes/2026-05-22-nuclear-9-phase2-stabilization.md`.
