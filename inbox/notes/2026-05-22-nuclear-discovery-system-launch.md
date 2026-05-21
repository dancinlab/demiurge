# Nuclear Discovery Simulation Stack — System Launch (Phase 1 land)

> Anchor: `NUCLEAR.md` (new doc · this session)
> Cross-anchor: `RTSC.md §9` (compositional discovery sibling stack)
> Date: 2026-05-22
> Outputs:
>   - demiurge: `NUCLEAR.md` + `RTSC.md §9` cross-link footnote + this inbox note
>   - hexa-lang: `stdlib/nuclear/hfbtho_adapter.py` (N6 first wrap) + `stdlib/nuclear/wkb_alpha_decay.py` (N7 closed-form)

---

## 1. Decision — launch NUCLEAR stack as RTSC §9 sibling

User: "새로운원자발견 시스템 go" → launch a new 5-gate simulation
stack for **nuclide discovery** (superheavy / drip-line atom), parallel
to RTSC §9 (which is for *compositional* discovery — new SC material).

Two stacks now exist:

| stack          | discovery axis              | numbering    | g3 absorbed=true verdict     |
|----------------|------------------------------|--------------|-------------------------------|
| RTSC §9        | new SC composition (a)(b)(c) | N1-N5        | impossible from sim (§8.9)    |
| **NUCLEAR**    | new nuclide (Z, N)           | **N6-N10**   | impossible from sim (§3)      |

Same R4 invariant family. Same `absorbed=false 영구`. Distinct
`gate_type` shape value (`nuclear-novel-discovery-simulation`).

---

## 2. Phase 1 Cohort pick — N6 (HFBTHO mass / binding / deformation)

Mirror of RTSC §9.9.1 Phase 1 wrap-as-is pattern. N6 picked first because:

1. **HFBTHO** is the most-mature open-source HFB binary (Fortran 95,
   Stoitsov/Schunck 3.00 release `arxiv:1810.10825`).
2. **BSk22/24/27** cross-validation reference table is openly cited
   (`arxiv:1607.06961`), enabling honest cross-functional σ spread
   (mirror of N4 cross-code DFT consensus pattern from RTSC §9.4).
3. **FRDM2012** (`arxiv:1508.06294`) is a published mass table —
   lightest install path (no binary, just `.dat` lookup).
4. Closest analog to existing `stdlib/material/` adapter shape
   (csp_adapter / mp_query / cross_code_dft).

---

## 3. Honest scope statement

- **Sim CAN** (3 of 5 gates): (a) mass + binding + deformation via HFB ·
  (b) shell-model spectroscopy via KSHELL/BIGSTICK · (c) α / β / SF
  half-life via WKB cluster + Geiger-Nuttall.
- **Sim CANNOT** (2 of 5 gates permanently): (d) production cross-
  section for SHE synthesis — sim gives σ within ~10× of experiment,
  never alone confirms · (e) detection — needs SHIP / DGFRS / GARIS
  recoil-separator beam-line, physical hardware, NEVER substitutable
  by simulation.
- **Promotion path to `absorbed=true`** (out of scope, permanent):
  1. Heavy-ion accelerator beam-time at GSI / JINR / RIKEN.
  2. Recoil-separator detection chain.
  3. Decay-chain identification.
  4. Independent replication at second laboratory.
  5. IUPAC / IUPAP priority assignment.
- **What this stack delivers**: ranked top-K candidate list for
  accelerator beam-time priority. NOT discovery claims.

---

## 4. External library survey results (NUCLEAR.md §5)

### 4.1 N6 (mass / structure)

- **HFBTHO** — gitlab.com/hfbtho/hfbtho · open-source · Fortran 95 +
  OpenMP + LAPACK. Active maintenance (3.00 release 2018).
- **HFODD** — github.com/skyrme-hfb/hfodd · triaxial generalization,
  heavier compute.
- **FRDM2012** — Möller-Nix-Iwamoto-Kratz · `arxiv:1508.06294` ·
  openly-cited published mass table, lightest install (table only).
- **BSk22/24/27** — Brussels-Nuclear-Library · www-astro.ulb.ac.be/
  bruslib/ · functional family with multi-functional ensemble for σ.
- **AME2020** — `arxiv:2105.01035` · cross-validation oracle (measured
  masses for ~3500 known nuclei, comparison baseline for sim).

### 4.2 N7 (half-life — closed-form, no install)

- **Viola-Seaborg 1966** (Sobiczewski-Parkhomenko 2005 refit) — primary.
- **Royer 2000** · `arxiv:nucl-th/0510074` — mass-dependent refinement.
- (Brown 1992 / SemFIS-2 candidate dropped from first land — published
  coefficients didn't reproduce SHE Q_α regime within honest spread.
  "Don't invent" rule per NUCLEAR.md §3.3. Phase 2 follow-on:
  re-derive or substitute Denisov-Khudenko 2009.)

### 4.3 N8-N10 (deferred to next sessions)

- N8 fusion-evaporation σ — HIVAP · DNS · KEWPIE2 · NRV (each has
  separate install audit; not in scope for first land).
- N9 shell model — KSHELL · NuShellX@MSU · BIGSTICK · ANTOINE
  (massive numerical infra; first-land scope creep risk).
- N10 ab-initio — NCSM · CCSD · IM-SRG · symplectic NCSM (each
  community has separate tooling).

---

## 5. Adapter implementation — N6 HFBTHO

`hexa-lang/stdlib/nuclear/hfbtho_adapter.py` · Path B wrap-as-is ·
`gate_type=nuclear-novel-discovery-simulation` (or `install-gated`).

### 5.1 4-backend fallback chain

`hfbtho → hfodd → frdm_table → bsk_table`

Probe per backend (PATH + env-var + canonical layout):

| backend     | env var          | layout                          |
|-------------|------------------|----------------------------------|
| hfbtho      | `$HFBTHO_BIN`    | binary `hfbtho_main` / `hfbtho`  |
| hfodd       | `$HFODD_BIN`     | binary `hfodd`                   |
| frdm_table  | `$FRDM_TABLE_DIR`| `FRDM2012.dat`                   |
| bsk_table   | `$BRUSLIB_DIR`   | `BSk{22,24,27}.dat`              |

### 5.2 3 honest skip paths

1. **`install-gated`** — all 4 backends absent → skipped with full
   install hints (mirror RTSC csp_adapter pattern).
2. **`weights-missing`** — equivalent to `install-gated` here
   (parameter file absent in env-var dir).
3. **`network-fail`** — N/A for first land (no network calls in
   wrap-as-is shape; AME2020 cross-validation deferred to Phase 2).

### 5.3 Smoke test results

```
Test A: Z=119, N=178 (predicted SHE, no backend installed)
  → gate_type: install-gated
  → absorbed: false ✓ (R4 invariant)
  → backend: all-skipped
  → wrote nuclear_verify_n6_hfb_119_178_<stamp>.json

Test B: Z=118, N=176 (²⁹⁴Og, FRDM_TABLE_DIR fake env var)
  → gate_type: nuclear-novel-discovery-simulation
  → absorbed: false ✓ (R4 invariant)
  → backend: frdm_table (presence acknowledged, no SCF launched)
  → wrote nuclear_verify_n6_hfb_118_176_<stamp>.json
```

R4 invariant `absorbed=false` holds across both paths. Honest skip is
the PASS verdict per NUCLEAR.md §3.3.

---

## 6. Adapter implementation — N7 WKB α-decay (bonus same-session land)

`hexa-lang/stdlib/nuclear/wkb_alpha_decay.py` · libm-only closed-form ·
Path A microkernel candidate (mirror RTSC §9.9.1 Phase 4 schedule).

### 6.1 2-formula ensemble

- Viola-Seaborg (Sobiczewski-Parkhomenko 2005 refit coefficients).
- Royer 2000 (mass-dependent).
- (Brown 1992 dropped — see §4.2 honest correction.)

### 6.2 Smoke test — ²⁹⁴Og (Oganesson)

```
Input: Z=118, N=176, A=294, Q_α=11.65 MeV (AME2020 evaluated)
Output:
  - Viola-Seaborg log10 T₁/₂ = -2.82 (s)
  - Royer         log10 T₁/₂ = -3.04 (s)
  - Consensus mean log10 T   = -2.93 ± 0.22 dex
  - T_geomean estimate       = 1.17 ms

Observed (AME2020 + NUBASE2020): T₁/₂(²⁹⁴Og) ≈ 0.7 ms (log10 ≈ -3.15)

Match within 0.22 dex spread (honest agreement). g3 PASS.
absorbed=false ✓
gate_type=nuclear-novel-discovery-simulation ✓
```

### 6.3 Missing-Q_α honest skip

```
Input: Z=119, N=178 (no Q_α)
Output: gate_type=install-gated · skipped_reason="No Q_alpha provided"
absorbed=false ✓
```

Workflow expects N6 HFB mass prediction → daughter mass → Q_α chain.
First-land accepts Q_α as explicit CLI input; chained workflow
deferred to Phase 2.

---

## 7. R4 invariant audit (both adapters)

| record path                                                  | gate_type                          | absorbed |
|--------------------------------------------------------------|-------------------------------------|----------|
| nuclear_verify_n6_hfb_119_178_<stamp>.json (no backend)      | install-gated                      | false ✓ |
| nuclear_verify_n6_hfb_118_176_<stamp>.json (frdm table)      | nuclear-novel-discovery-simulation | false ✓ |
| nuclear_verify_n7_alpha_118_176_<stamp>.json (Og + Q_α)      | nuclear-novel-discovery-simulation | false ✓ |
| nuclear_verify_n7_alpha_119_178_<stamp>.json (no Q_α)        | install-gated                      | false ✓ |

**0 / 4 records have `absorbed=true`**. R4 invariant holds. Hardcoded
in both producers (mirror RTSC §9 N1-N5 pattern).

---

## 8. Citations added (NUCLEAR.md §8.1)

arxiv IDs cataloged (9 papers):

- `arxiv:1810.10825` — HFBTHO 3.00 release
- `arxiv:1607.06961` — BSk22/24/27 functional family
- `arxiv:1508.06294` — FRDM2012 mass table
- `arxiv:2103.07016` — Modern HFB/EDF nuclear-mass review
- `arxiv:2208.11471` — SHE production σ review
- `arxiv:2004.06135` — UNEDF program review
- `arxiv:nucl-th/0510074` — Royer α-decay analytic formula
- `arxiv:1611.07916` — AME2016 evaluation
- `arxiv:2105.01035` — AME2020 evaluation (cross-validation oracle)

Library / data corpora URLs (11): HFBTHO · UNEDF · IAEA-NSDC · AME2020 ·
NUBASE2020 · JINR NRV · KSHELL · BIGSTICK · NuShellX@MSU · ANTOINE ·
Brussels Nuclear Library.

---

## 9. Cross-link to RTSC §9

`RTSC.md §9` (pre-§9.1 paragraph) gained a sibling-stack pointer:

> Sibling stack — atom discovery: §9 (this stack) is *compositional*
> discovery (new SC material). *Elemental* discovery (new nuclide) is
> in `NUCLEAR.md` — same R4 invariant family, different discovery
> axis. 2 stacks are parallel funnels (not unified).

---

## 10. Phase 2+ next-pickup pointer

Mirror of RTSC §9.9.1 Phase 2 (16-cell stabilization audit). For nuclear:

### Phase 2 candidate matrix (5 baselines × N6/N7 = 10 cells)

| baseline             | N6 (mass)        | N7 (α-decay)           |
|----------------------|------------------|-------------------------|
| ²³⁸U   (Z=92, N=146) | published        | observed (4.27 MeV)    |
| ²⁰⁸Pb  (Z=82, N=126) | doubly magic     | stable (no α-decay)    |
| ²⁹⁴Og  (Z=118, N=176)| predicted        | observed (~0.7 ms)     |
| ²⁹⁹Uue (Z=119, N=180)| **target — predicted** | needs N6 chain  |
| ⁸B     (Z=5,  N=3)   | proton drip-line | β-only (no α)          |

Each cell emits a record; aggregate stats: % PASS · σ-spread across
backends · agreement with AME2020 cross-validation oracle for the
3 observed baselines.

### Phase 2 also-includes

- N6 stub → real SCF: parse HFBTHO output / FRDM2012 `.dat` lookup
  for actual mass_excess / binding_energy values (currently the
  stub emits `null` predictions even when backend present).
- N7 third formula (re-derive Brown or substitute Denisov-Khudenko).
- N6 → N7 workflow chaining (Q_α from M(Z,N) − M(Z-2,N-2) − M_α).

### Phase 3 (deferred to separate sessions)

- N8 HIVAP / KEWPIE2 wrap (fusion-evaporation σ — wet-lab dep gate).
- N9 KSHELL wrap (shell-model spectroscopy — heavy install).
- N10 NCSM wrap (ab-initio drip-line — community variant tooling).

### Phase 4 (microkernel port, after N7 wrap stabilization)

- WKB closed-form kernels → hexa-native (mirror of M5 sim.hexa
  BCS/McMillan/AD/WHH precedent · libm-only ~50-100 LOC each).
- Anti-pattern carve-out hardcoded: HFBTHO Fortran ecosystem · KSHELL
  Lanczos engine · ab-initio CCSD/IM-SRG · ML mass-formula training —
  all stay wrap-as-is forever (NUCLEAR.md §3.3 + RTSC.md §9.9.1
  anti-pattern table).

### Phase 5 (compositional funnel — mirror RTSC §9.10 N5)

- **N11 funnel cohort**: enumerate `(Z, N)` candidate space, rank by
  (a)(b)(c) composite score, emit `exports/nuclear_discovery/<stamp>/
  top_k.json` for accelerator priority. Mirror of N5 compositional
  funnel pattern.

---

## 11. Cross-stack honest separation

NUCLEAR ↔ RTSC are *parallel funnels*, NOT unified:

- Z > 118 SHE half-lives are typically μs–ms → won't form crystals →
  not RTSC carryover candidates.
- The two stacks share R4 invariant family + `gate_type` shape value
  pattern, but their (a)(b)(c) gates are different physical content
  (compositional vs elemental).
- Cross-link is documentation-level only (RTSC §9 footnote pointing to
  NUCLEAR.md, this note pointing to RTSC §9). No code coupling.

---

## 12. Worktree discipline

- demiurge: this Agent's worktree (`agent-aea1df762d649cb5a`).
  Branch: `worktree-agent-aea1df762d649cb5a`. Files added:
  `NUCLEAR.md` (new) · `RTSC.md` (1 cross-link block) · this note.
- hexa-lang: separate isolated worktree at `~/core/hexa-lang-nuclear`
  on branch `nuclear-discovery-phase1`. Files added:
  `stdlib/nuclear/hfbtho_adapter.py` (new) ·
  `stdlib/nuclear/wkb_alpha_decay.py` (new).
- D116 carry-over: demiurge = pointer doc · hexa-lang = SSOT for code.
  This launch respects D116 — `NUCLEAR.md` is documentation only;
  every executable line lives in hexa-lang.
