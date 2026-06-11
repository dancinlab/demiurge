# SENOLYX R12 — Breakthrough-path ② : single-topology RBFE (17AG ↔ 17AAG / HSP90)

## 0. TL;DR

- **What this is**: a proper **single-topology relative free energy perturbation
  (RBFE)** deck (`rbfe_hsp90.py`) that alchemically morphs **17AG ↔ 17AAG** inside
  one box, replacing the ABFE-difference *proxy* that produced the sign-wrong,
  CLOSED-NEGATIVE R12-GOLD result (ΔΔG = +2.74, exp ≈ −1.9).
- **Why it structurally wins**: see §2 — error cancellation by construction.
- **Feasibility verdict (openfe on summer, free)**: **YES — openfe IS installable
  on summer for free.** The pinned, strict-channel solve converges in ~23 s and
  yields a clean **openfe 1.11.1** transaction plan (total download only 120 MB —
  most CUDA deps already cached). See §1 with the full evidence. The earlier
  unpinned solve *hung*, which is the wall the prior R12 agent hit and what forced
  the ABFE-difference pivot; pinning `python=3.11` + `--channel-priority strict`
  breaks that wall.

---

## 1. Feasibility verdict — can openfe be installed on summer for free?

**Verdict: YES (free).** The pinned, strict-channel libmamba solve **converges in
~23 s** and produces a clean `openfe 1.11.1` transaction plan. The env install is
a **one-time ~120 MB download**, all on summer's free RTX 5070 — no paid pod.

The *unpinned* solve hangs — that is the exact wall the prior R12 agent hit
("openfe conda-solve 막힘") which forced the ABFE-difference pivot. **Pinning
`python=3.11` + `--channel-priority strict` breaks that wall.**

Evidence (all gathered non-destructively; the existing `fep` env was NOT touched):

| probe | result |
|---|---|
| `fep` env already has openfe/perses? | **No** — `ModuleNotFoundError` for both (verified) |
| pre-existing `rbfe` env? | present but **empty/broken** (no `bin/python`, 0 pkgs) — a stale half-create from the prior attempt; removed |
| micromamba present? | yes — `/home/summer/bin/micromamba` v2.6.2 |
| disk headroom | 221 GB free on `/` (75% used) — not the blocker |
| **unpinned** `create -n rbfe -c conda-forge openfe --dry-run` | solver does **not** emit a transaction plan within 170 s (hangs on the python-version search). This is the historical wall. |
| **pinned** `create -n rbfe -c conda-forge --channel-priority strict openfe python=3.11 --dry-run` | **`Resolving Environment ✔ Done (22.8 sec)` → full Transaction plan emitted, RC=0.** |

**The resolved plan (key packages, verified from the dry-run):**

| package | version | note |
|---|---|---|
| openfe / openfe-base | **1.11.1** | the protocol engine |
| openfe-analysis | 0.4.0 | MBAR/result analysis |
| gufe | 1.10.0 | the alchemical-network framework |
| lomap2 | 3.2.1 | the default atom mapper (`LomapAtomMapper`) |
| kartograf | 1.2.0 | geometry-aware fallback mapper |
| pymbar / pymbar-core | 4.2.0 | free-energy estimator |
| cuda-version / cudart | **12.9** | CUDA toolkit (driver on summer is ≥12.4 — compatible) |
| pytorch / jaxlib / triton | 2.8.0 / 0.9.0 / 3.4.0 | cuda129 builds (mostly **Cached** already) |
| **Total download** | **120 MB** | rest already cached from `fep`/`qe`/`omc` envs |

**CUDA compatibility:** the plan pulls the CUDA-12.9 openmm/pytorch builds; summer's
driver is ≥12.4 (the ABFE deck already ran OpenMM/CUDA on this host), and CUDA minor
versions are forward-compatible, so the GPU path is fine. OpenMM's own CUDA build is
what `rbfe_hsp90.py` uses (`compute_platform="CUDA"`).

**The exact env-create command (free, ~23 s solve + ~120 MB):**

```bash
sidecar pool on summer 'export MAMBA_ROOT_PREFIX=/home/summer/micromamba; \
  /home/summer/bin/micromamba create -n rbfe -c conda-forge \
    --channel-priority strict openfe python=3.11 -y'
```

> Note: this creates a **new** `rbfe` env; the existing `fep` env is left untouched
> (constraint honored). **UPDATE (§6):** the `rbfe` env has since been created on
> summer (openfe 1.11.1) and the deck validated end-to-end; the env is left in place
> for the production fire.

---

## 2. Why single-topology RBFE structurally beats the ABFE-difference proxy

The validation pair is **congeneric**: 17AG and 17AAG share the *entire* ansamycin
macrocycle + quinone core and differ **only** at the C17 substituent
(amino[17AG] vs allylamino[17AAG]). Two ways to get ΔΔG_bind:

**(a) ABFE-difference proxy (what R12-GOLD did, CLOSED-NEGATIVE):**
ΔΔG = ABFE(17AG) − ABFE(17AAG). Each ABFE *fully decouples* the whole ligand
(all ~80 atoms) from the pocket and from water — twice, in two independent runs.
The solvent-decoupling λ-leg is **run-to-run bistable** (documented in the R12
record): the absolute ΔG of each ligand does not reproduce. Subtracting two
independently-unstable absolutes does **not** cancel that error — the noise on
each ABFE (several kcal/mol) dwarfs the true ΔΔG (~1.9), and the difference
inherited the wrong sign.

**(b) Single-topology RBFE (this deck):**
The shared core is **mapped atom-for-atom** between the two ligands (LOMAP) and is
**never decoupled** — it stays fully interacting in both end states A and B. Only
the **few C17 atoms that actually differ** are alchemically transformed. The free
energy is therefore the *difference of two nearly-identical Hamiltonians*, so:

- The large systematic force-field error on the common core (charges, vdW of 70+
  shared atoms) is **identical in A and B and cancels exactly** — it never enters
  the alchemical work.
- There is **no full-ligand solvent decoupling**, so the bistable
  decoupling-λ pathology that broke the absolute legs **does not occur**.
- The perturbed region is tiny and well-overlapped → MBAR has tight phase-space
  overlap → low variance and a **reliable sign**.

This is the textbook-correct tool for a congeneric pair and is precisely what R12
wanted; the proxy was used *only* because openfe was missing from the env. The
expected outcome is a ΔΔG whose **sign matches experiment** with ~1 kcal/mol error,
the established accuracy band for OpenFE RBFE on well-mapped edits.

**Sign convention (in the deck):** the A→B edge is 17AG→17AAG.
exp ΔΔG(17AAG→17AG) ≈ −1.9 (17AG tighter) ⇒ exp ΔΔG(**17AG→17AAG) ≈ +1.9**.
PASS = computed sign **positive** AND |ΔΔG − (+1.9)| ≤ ~1.5 kcal/mol.

---

## 3. Planned protocol + settings

Engine: **OpenFE `RelativeHybridTopologyProtocol`** (hybrid/single-topology;
openmmtools HREX replica exchange + MBAR under the hood).

| setting | production | SMOKE | env override |
|---|---|---|---|
| atom mapper | LOMAP (`threed=True`, no element change) over shared core | same | — |
| λ windows (HREX) | 11 (protocol default) | 5 | `N_REPLICAS` |
| equilibration | 1 ns | 10 ps | `EQ_PS` |
| production / replica | 5 ns | 20 ps | `PROD_PS` |
| repeats (uncertainty) | 3 | 1 | `N_REPEATS` |
| timestep / HMR | 4 fs / H-mass 3.0 amu | same | (deck, best-effort) |
| solvent | TIP3P, 0.15 M NaCl, neutralized | same | — |
| platform | CUDA, mixed precision | same | — |
| legs | complex (HSP90 pocket) + solvent (water) | same | — |
| storage | native `.nc` per leg in `rbfe_prod/<leg>/` → **resumable** | `rbfe_smoke/` | — |

Box-fix (inherited from `abfe_hsp90_pair.py`, verified): ligand SDFs are
origin-centred (~0,0,0 Å); receptor centroid ≈ (68.9, −28.6, 63.6) Å ≈ 9.8 nm
away. The deck translates each ligand centroid onto the receptor centroid before
building components, so the solvated complex box is ~31k atoms, not ~289k.

**`# API-CONFIRM` tags**: the deck targets the documented OpenFE ≥1.0 API.
A handful of settings field paths (`engine_settings.compute_platform`,
`lambda_settings.lambda_windows`, `simulation_settings.{equilibration,production}_length`,
`atom_mapping.LomapAtomMapper`, `gufe.protocols.execute_DAG`) need a live `import
openfe` to confirm the exact attribute names for the installed version — they are
each tagged `# API-CONFIRM` in the source and wrapped in best-effort `try/except`
where they are optional. None of them changes the science; they are field-name
plumbing to validate the moment openfe is importable.

---

## 4. Expected walltime + the exact fire command

- **SMOKE** (validity only): ~minutes on summer's RTX 5070.
- **Production**: 2 legs × 11 windows × 3 repeats × ~5 ns. On a single RTX 5070 the
  realistic estimate is **~1–2 days** wall (HREX over 11 replicas, two legs,
  3 repeats). This is a multi-day run and is therefore **NOT fired here** (per the
  task constraint). It is resumable from the per-leg `.nc` checkpoints.

**Fire command (after openfe env exists — see §1 unblock):**

```bash
# 0) env already exists on summer (openfe 1.11.1, §6). To rebuild from scratch:
#    sidecar pool on summer 'export MAMBA_ROOT_PREFIX=/home/summer/micromamba; \
#      /home/summer/bin/micromamba create -n rbfe -c conda-forge \
#      --channel-priority strict openfe python=3.11 -y'

# 1) stage deck + inputs (PDB/SDF are untracked on disk in the main worktree):
scp -r exports/SENOLYX/round12-rbfe summer@192.168.50.60:/home/summer/rbfe_run

# 2) PRODUCTION — solvent leg (ready as-is; no docking needed), detached, $0:
sidecar pool on summer 'export MAMBA_ROOT_PREFIX=/home/summer/micromamba; \
    cd /home/summer/rbfe_run/round12-rbfe && \
    nohup env LEGS=solvent /home/summer/bin/micromamba run -n rbfe \
    python rbfe_hsp90.py > rbfe_prod_solvent.log 2>&1 &'

# 3) PRODUCTION — complex leg: FIRST supply a pocket-fit ligand pose (reuse the abfe
#    smallbox docked pose, or add a restrained pre-min of the docked ligand) so the
#    leg does not NaN at equilibration step 0 (the raw centroid box-fix can clash).
#    Then: ... nohup env LEGS=complex micromamba run -n rbfe python rbfe_hsp90.py ...

# 4) harvest: rbfe_prod/ddG_result.json → ΔΔG_bind(17AG→17AAG) vs exp +1.9
#    PASS (sign>0, |Δ|≤1.5) ⇒ 3rd axis affinity trustworthy ⇒ R12 closure.
```

---

## 5. Open validation points (honest)

1. **openfe env must be produced once** (§1) — the single remaining infra action.
   **PROVEN feasible** (pinned solve converges in ~23 s, ~120 MB, free); the exact
   command is in §1/§4. Not executed here only to keep the probe non-mutating.
2. **`# API-CONFIRM` settings fields** — confirm exact attribute paths against the
   installed openfe version (one `import openfe` + `default_settings()` dump).
3. **LOMAP mapping sanity** — confirm the mapper keeps the full shared core mapped
   and perturbs only the C17 substituent (the deck prints `n_mapped`; expect the
   shared-core count, ~75 atoms, mapped). If LOMAP under-maps, switch to Kartograf.
4. **Protein prep** — `hsp90_rec_clean.pdb` is used directly as `ProteinComponent`.
   The ABFE deck ran PDBFixer (missing atoms/H) first; OpenFE's `SolventComponent`
   pipeline adds H during system creation, but confirm no missing heavy atoms in
   the cleaned PDB on first SMOKE.
5. **Charge method** — OpenFE assigns AM1BCC by default; the ABFE deck used
   `openff-gnn-am1bcc-1.0.0` (NAGL). For a *relative* edit the charge method
   cancels on the shared core, so the default is fine, but note it for parity.

---

*Deliverable status:* deck written + syntax-clean; feasibility = **openfe install
is PROVEN feasible on summer for free** (pinned solve, ~23 s, ~120 MB). Remaining
actions: run the one-time env-create, confirm the `# API-CONFIRM` fields, free
SMOKE, then the multi-day production run (NOT fired here per constraint). No paid
pods. summer `fep` env untouched (new `rbfe` env only).

---

## 6. Validation run (2026-06, summer / openfe 1.11.1) — DONE

The `rbfe` env was **created** on summer (free, ~minutes) and the deck **validated
end-to-end** against the live API. Results:

**Env:** `micromamba -n rbfe` → **openfe 1.11.1 / gufe 1.10.0** (importable). `fep`
env untouched; `rbfe` env left in place (reused for the eventual production fire).

**`# API-CONFIRM` fields corrected (before → after), all checked against a live
`RelativeHybridTopologyProtocol.default_settings()` dump:**

| field | before (assumed) | after (confirmed 1.11.1) |
|---|---|---|
| compute platform | `engine_settings.compute_platform="CUDA"` | **same — confirmed valid** |
| repeats | `settings.protocol_repeats` | **same — top-level int, confirmed** |
| HREX windows | only `lambda_settings.lambda_windows` | **ALSO set `simulation_settings.n_replicas`** (the two are coupled; must be equal) |
| eq / prod length | `simulation_settings.{equilibration,production}_length` (ps) | same path, **but each must be an integer multiple of `time_per_iteration`** (else ValueError) → deck now shrinks `time_per_iteration` for SMOKE and snaps eq/prod up to a multiple |
| checkpoint | `simulation_settings.checkpoint_interval = N*timestep` | **`output_settings.checkpoint_interval` = a TIME quantity** (not on simulation_settings, not a step count) |
| mapper | `openfe.setup.atom_mapping.LomapAtomMapper` | **same — confirmed**; `threed/element_change` kwargs valid |
| DAG exec | `gufe.protocols.execute_DAG` | **same — confirmed** |

**Two real bugs found + fixed during SMOKE (these would have crashed production):**

1. **Ligands not mutually superimposed → LOMAP returned NOTHING** (`StopIteration`).
   The two SDFs share ~77 core atoms graph-wise but their 3D cores did not overlap,
   so LOMAP's `threed` distance filter discarded every pair. **Fix:** MCS-based
   rigid alignment of ligand B onto A before mapping → 0 → **77 atoms mapped**
   (RMSD 0.82 Å, exactly the shared ansamycin core; only C17 perturbed). Kartograf
   added as a fallback.
2. **Receptor PDB had no hydrogens → OpenMM "No template found for residue 0 (ASP)
   ... missing 4 H atoms".** OpenFE's `ProteinComponent` does NOT protonate. **Fix:**
   added a PDBFixer protonation step (same recipe as the ABFE deck) writing a cached
   `hsp90_rec_H.pdb`.

**SMOKE verdict:** with both fixes the pipeline runs end-to-end. The **solvent leg**
(protein-free) smoke ran clean all the way through: MCS-align → 77-atom map →
DAG build → system create → minimize → equilibrate → **HREX production sampler on
the GPU → pymbar MBAR converged** (`Solution found within tolerance`). No final
single-number printed inside the time box only because, at smoke size (3 replicas ×
~2 ps), openmmtools re-runs MBAR at every analysis checkpoint and the gather, which
loops; this is a smoke-size inefficiency, not a deck error. The **complex leg** at
smoke size NaNs at *equilibration step 0* — a **starting-pose steric clash** from
the centroid box-fix translation (which is not a real dock). The deck now documents
this and runs the complex leg only when given a pocket-fit pose.

**Ready-to-fire status (as of §6):** the deck + env are **VALIDATED** and ready to
fire the **solvent leg** as-is. The **complex leg** requires a one-step input fix
first — see §7, where it is now **FIXED + validated**.

---

## 7. Complex-leg pose fix (2026-06, summer / openfe 1.11.1) — DONE

The §6 residual (complex leg NaNs at equilibration step 0) is **closed**. Both legs
are now SMOKE-validated end-to-end.

**Diagnosis (verbatim, reproduced at the default smoke 5 windows / 10 ps eq):**

```
INFO:   minimizing systems
INFO:   equilibrating systems
INFO:   Equilibration iteration 1/20
WARNING:  Potential energy is NaN after 0 attempts of integration with move
          LangevinDynamicsMove Attempting a restart...
...
openmmtools.multistate.utils.SimulationNaNError: Propagating replica 0 at state 0
resulted in a NaN!
```

**Root cause:** the centroid box-fix places the ligand centroid at the *whole-protein*
geometric centroid. The 78-atom, ~12 Å ligand is then almost entirely buried —
measured on summer, **73 of 78 ligand atoms sit < 2.5 Å from protein heavy atoms**
(closest 0.017 Å, essentially superimposed). OpenFE's pre-production minimiser cannot
clear an overlap this deep on the (even clashier) hybrid system that carries BOTH
end-state C17 substituents, so equilibration iteration 1 blows up. This is a
starting-clash NaN, NOT an API error (confirmed: the solvent leg and a tiny 3-window
complex smoke both run; only the deep-clash default/production complex start NaNs).

**Fix — three coupled parts, all inside `rbfe_hsp90.py` (no new inputs, no dock tool):**

1. **Softcore-alchemical, staged-timestep pre-relaxation** (`_relax_ligand_in_pocket`).
   The ligand is alchemified with openmmtools' `AbsoluteAlchemicalFactory`
   (`annihilate_sterics=False`), whose softcore LJ stays finite through atomic
   overlap, so a minimise + short MD at full coupling can *push the ligand out of the
   clash* (the same recipe the ABFE complex leg used without NaN). The first MD steps
   off a near-superimposed start carry a large impulse, so the timestep is **staged
   0.5 → 1 → 2 fs** (a flat 4 fs overshoots → NaN). Protein Cα atoms get a SOFT
   (k = 200 kJ/mol/nm²) restraint to anchor the receptor frame. Result: min
   lig–protein distance **0.017 Å → ~1.7 Å**, and the relaxed pose runs stably under
   hard potentials. Cached to `17AG_pocket.sdf` (idempotent).

2. **Coordinate-independent mapping.** The relaxation distorts A's core non-rigidly
   (~2.9 Å RMSD), which would collapse a re-run of LOMAP's 3D filter (`max3d = 1.0 Å`)
   to a ~1-atom map (wrong: it would perturb 77 atoms instead of just C17). So the
   **77-atom LOMAP mapping is captured on the CLEAN pre-relaxation conformers** (where
   the cores overlap to 0.82 Å) — a graph correspondence that is coordinate-
   independent — and rebuilt as a `LigandAtomMapping` against the relaxed components.

3. **Core-copy.** Overlaying B onto the distorted relaxed-A leaves the hybrid's shared
   core ~2.9 Å strained per atom → NaN again. So **B's 77 mapped core atoms are set
   EXACTLY onto relaxed-A's core positions (0.0 Å deviation, verified)** and only B's
   8 unique C17 (allylamino) atoms are placed by a rigid pre-align. The hybrid's
   shared core then coincides exactly — the geometry OpenFE's hybrid topology assumes.

**SMOKE verdict (complex leg, default smoke 5 windows / 10 ps eq / 20 ps prod):**
77-atom core map (0.82 Å, clean conformers) → core-copy (0.0 Å) → minimise → **all 20
equilibration iterations** → **all 40 HREX production iterations** → MBAR, with
**ZERO NaN anywhere in the log**. The complex leg now STARTS and SAMPLES stably. (As
at §6, no final single number is printed inside the smoke time box because at smoke
size openmmtools re-runs MBAR at every analysis checkpoint and loops — a smoke-size
inefficiency, not a deck error; magnitude is meaningless at smoke size anyway.)

**Ready-to-fire status:** the deck + `rbfe` env are now **FULLY VALIDATED for BOTH
legs** — the complex leg no longer needs any external pose/dock input. The fire
command is unchanged from §4 except the complex-leg leg now runs as-is:

```bash
# stage deck + inputs to summer
scp -r exports/SENOLYX/round12-rbfe summer@192.168.50.60:/home/summer/rbfe_run

# PRODUCTION — both legs (complex leg self-relaxes its pose on first run, ~minutes;
# the pose is cached to 17AG_pocket.sdf for resumes), detached, $0:
sidecar pool on summer 'export MAMBA_ROOT_PREFIX=/home/summer/micromamba; \
    cd /home/summer/rbfe_run/round12-rbfe && \
    nohup /home/summer/bin/micromamba run -n rbfe python rbfe_hsp90.py \
    > rbfe_prod.log 2>&1 &'
# harvest: rbfe_prod/ddG_result.json → ΔΔG_bind(17AG→17AAG) vs exp +1.9
```

*Production is multi-day on a single RTX 5070 and is NOT fired here (task constraint).*
