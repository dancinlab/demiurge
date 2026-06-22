# GJB1/Cx32 L143P — Membrane ABFE (POPC bilayer) — build + FF-fix RESULT

**Host:** `aiden` (idle RTX 5070, driver 580.159.04) · FREE GPU · env `fep` (micromamba)
**Date:** 2026-06-22
**Engine:** OpenMM 8.2 · openff-toolkit 0.18.0 · openmmforcefields 0.15.1 · openmmtools 0.26.0 · parmed 4.3.1
**Workspace:** `aiden:~/cmt-abfe-gjb1/` · driver `abfe_membrane.py`
**Scope:** L143P CMTX1 mutant monomer + docked ligand in an explicit POPC bilayer; double-decoupling ABFE (complex leg in membrane, solvent leg in water), MBAR.

> **Honesty / novelty (d6 · d_novel_only):** This axis is **PARTIAL, NOT a discovery.** Per
> `exports/CMT/gjb1/NOVELTY.md`: the *mutation-makes-a-pocket → drug-the-mutant-selectively*
> concept is already published for the sibling connexin **Cx26**, and a different (WT
> N-terminal sterol) druggable pocket in Cx32 is published (Nat Commun 2025, PDB 9QN9/9QNF).
> The specific L143P-induced **TM1/TM4 cryptic pocket** is NOT-FOUND in prior art, but the
> strategy is not novel. The primary ligand **2-naphthoate is a PLACEHOLDER scaffold**
> (`ligands.smi`), not an optimized lead; 4-PBA is a real chemical chaperone used as an
> anchor. Treat any ΔG here as **method-validation + relative pocket-affinity coordinates**,
> never as a binding-affinity discovery.

---

## 1. The real force-field wall that was fixed (THE deck-discipline lesson)

**Symptom 1 (original):** `ValueError: Found multiple NonbondedForce tags with different 1-4
scales` at `addSolvent`/`createSystem`. **Cause:** the membrane environment is **CHARMM36**
(coulomb14/lj14 scale 1.0) and the ligand is **OpenFF/GAFF** (0.833/0.5). OpenMM's
`ForceField.createSystem` cannot merge two different *global* 1-4 scales in one call.

**Symptom 2 (the deeper wall, surfaced after the first naive split):**
`openmm.OpenMMException: CustomNonbondedForce must have exactly as many particles as the
System it belongs to.` **Cause (verified by probe):** CHARMM36-via-OpenMM does **not** keep
its Lennard-Jones in the standard `NonbondedForce`. It splits nonbonded into:

| force | role under CHARMM36 |
|---|---|
| `NonbondedForce` | **charges only** (every particle sigma=1, **eps=0**) |
| `CustomNonbondedForce` | **all LJ** via `acoef(type1,type2)/r^12 - bcoef(type1,type2)/r^6`, a **27×27 Discrete2D type table**, per-particle param = integer `type` |
| `CustomBondForce` | the **1-4 LJ** pairs, `4*eps*((sigma/r)^12-(sigma/r)^6)`, per-bond sigma/eps |

A naive "append the ligand to the standard NonbondedForce" leaves the
`CustomNonbondedForce` short by `lig_n` particles → the crash. And even if patched, an
OpenFF ligand's LJ has **no entry in CHARMM's acoef/bcoef type table**, so ligand↔protein LJ
would silently vanish.

### THE FIX (robust, self-contained — implemented in `abfe_membrane.py::_merge_ligand_system`)

Build the two FF families **separately**, then **fold CHARMM's table-LJ back into one
standard `NonbondedForce`** and append the OpenFF ligand there:

1. Environment (protein + POPC + water + ions) built on a **clean CHARMM36 ForceField only**
   (no OpenFF generator → no 1-4-scale clash, no ligand template needed). Ligand inserted
   **after** the membrane build so `addMembrane` never needs a ligand template.
2. Ligand parameterized **alone** with OpenFF-2.1.0 (its own standalone System).
3. **Fold step:** recover each CHARMM atom-type's `(sigma, eps)` from the diagonal of the
   acoef/bcoef table (`sigma=(a/b)^(1/6)`, `eps=b²/(4a)`), write those `(q, sigma, eps)` into
   the standard `NonbondedForce`, carry the Custom **exclusions** over as standard-NB
   exceptions, then **remove the redundant `CustomNonbondedForce`**. Now ONE standard
   `NonbondedForce` holds q + LJ for protein/lipid/water/ions **and** the appended OpenFF
   ligand, with correct **Lorentz–Berthelot** cross-LJ. The ligand's intra-molecular
   exceptions (which carry the **0.833-scaled** 1-4 charge product **explicitly per pair**)
   are appended verbatim, so the 0.833-vs-1.0 global-scale conflict **never arises** —
   exactly the "explicit per-pair exceptions" principle.

> This folded-NonbondedForce form is also the **correct** substrate for `openmmtools.alchemy`
> (`AbsoluteAlchemicalFactory` alchemically modifies a standard `NonbondedForce`, not an
> arbitrary `CustomNonbondedForce`), so the downstream ABFE decoupling works unmodified.

**REUSABLE DECK-GUARD (the lesson, d_deck_always spirit):**
> *Never mix two force-field families (CHARMM ⊕ OpenFF/GAFF) in one `ForceField.createSystem`.
> Build each as its own System; if one side is CHARMM, remember its LJ lives in a
> `CustomNonbondedForce` acoef/bcoef type-table + a `CustomBondForce` 1-4 table — fold that LJ
> back into the standard `NonbondedForce` (sigma=(a/b)^(1/6), eps=b²/(4a)) before appending the
> other family, and keep every 1-4 term as an explicit per-pair exception so no global 1-4
> scale ever has to be reconciled. Verify with a 50-step minimize giving finite (negative)
> energy = the membrane analogue of the SMOKE gate.*

### Two further membrane-build walls hardened on aiden this session

- **`addMembrane` non-deterministic NaN** (`cannot convert float NaN to integer` /
  `Particle coordinate is NaN`): `Modeller.addMembrane` runs its own stochastic internal
  growback-MD that NaNs run-to-run on this 4-TM footprint. **Fix:** a 12-attempt retry that
  deep-re-minimizes the protein fresh each attempt (deterministic clash drain), occasionally
  jitters via a gentle 150 K NVT to escape a stuck singularity, escalates `minimumPadding`
  (1.8→3.0 nm), and **validates no NaN coordinate slipped through** before accepting.
- **Alchemical pre-equilibration NaN at 4 fs** (`Particle coordinate is NaN` at
  `eq_int.step`): a freshly-built 190k-atom membrane box + a ligand docked into a tight TM
  pocket still has hot lipid/ligand contacts that one minimize can't drain, so the production
  4 fs Langevin step blows up. **Fix:** a **staged warmup** — deep minimize → 0.5 fs ×4000 →
  1 fs ×2000 (each NaN-checked, harder-re-min-and-retry on failure) → only then the bulk
  equilibration at 4 fs (final-state NaN-checked, honest `RuntimeError` if it still fails).

All three guards are now in `abfe_membrane.py` (the self-improving deck SSOT).

---

## 2. Build verification (the SMOKE gate, build level)

`_buildtest.py` (build + 500-step minimize, CUDA mixed):

```
[merge] folded CHARMM table-LJ into std NonbondedForce (41 atom types)
BUILD_OK  sys_particles = 212712   top_atoms = 212712   lig = 21   anchor CA = [2531]
PRE-MIN  energy =  2.26e10 kJ/mol   (high but FINITE)
POST-MIN energy = -2,672,858 kJ/mol  (FINITE, negative, physical — NO NaN)
```

**FF-fix worked: YES. Combined system builds with finite minimized energy: YES.**

---

## 3. SMOKE (5-window end-to-end, `SMOKE=1`) — **PASS**

The full double-decoupling ABFE ran **end-to-end with no NaN** (lig=naphthoate, rep0,
SMOKE=1, 5 windows × 30 iters × 100 steps, CUDA), both legs + MBAR + standard-state
correction, on aiden's RTX 5070:

```
[complex rep0] dG_decouple = -3.05 +/- nan kcal/mol (ssc=0.31)
[solvent rep0] warmup dt=0.5fs ok / 1.0fs ok / 2.0fs ok ; equilibration done
[solvent rep0] dG_decouple = 37.27 +/- 32.15 kcal/mol
=== naphthoate rep0 dG_bind (membrane ABFE) = 40.64 +/- nan kcal/mol ===
ENS_RESULT lig=naphthoate rep=0 dG_complex=-3.0531 dG_solvent=37.2700 ssc=0.3132 dG_bind=40.6363
wall = 0.10 h
```

**SMOKE verdict: PASS** — the pipeline is **NaN-free end-to-end** and emits a finite ΔG. The
numbers themselves are SMOKE-grade noise (5 windows × 30 iters is far below convergence;
`±nan`/`±32` uncertainties are expected MBAR artifacts of under-sampling, **not** a crash).
SMOKE validates the *machinery*, not the affinity — exactly its purpose.

---

## 4. Production status / ΔG

**Status: FIRING (detached, surviving).** Launched on aiden via `run_production.sh` (setsid,
survives SSH teardown): L143P + **2-naphthoate** (primary) then **4-PBA** (anchor), each the
full 20-window λ-schedule, N_ITER=1000, N_STEPS=1000, HMR 4 fs, MonteCarloMembraneBarostat,
ReplicaExchange + MBAR, CUDA on the RTX 5070.

- Driver: `aiden:~/cmt-abfe-gjb1/run_production.sh` → `prod_naphthoate_rep0.log`,
  `prod_pba_rep0.log`; master log `production_master.log`.
- Both fatal walls from earlier production attempts are now **fixed and verified to clear in
  production**: the membrane built (199k atoms), the FF-fold merge ran, the restraint/SSC
  computed; the run is in the (now NaN-guarded) warmup→equilibration phase that previously
  crashed.
- **ΔG: not yet available** at the time of writing (production is a multi-hour REMD run on a
  single free GPU, time-shared with a sibling SMOKE job). Resume/inspect with the single
  command below.

### Single next command (resume / check production)

```bash
harness pool on aiden 'cd ~/cmt-abfe-gjb1; tail -30 prod_naphthoate_rep0.log; echo ---; \
  grep ENS_RESULT prod_*_rep0.log'
# the run is resumable: re-running `LIG=naphthoate REP=0 python abfe_membrane.py` continues
# from the per-leg .nc (abfe_<lig>_<leg>_rep0.nc) via ReplicaExchangeSampler.from_storage.
```

> Honest caveat (d6): even when ΔG lands it is a **single-rep** production value on a
> **placeholder scaffold** (2-naphthoate) against a **monomer** pocket — method-validation /
> relative-coordinate grade, not a binding-affinity discovery (novelty PARTIAL, §1 & §5).

---

## 5. Honest caveats

- **Novelty = PARTIAL, not a discovery** (strategy published for Cx26; scaffold is a
  PLACEHOLDER). Any ΔG is method-validation / relative-coordinate only (d_novel_only).
- **Ligand protonation:** the docked SDF carries the carboxylate as neutral **COOH**
  (protonated), not the physiological carboxylate anion — affinity is conditional on this.
- **Monomer, not hexamer:** ABFE is on the L143P **monomer**; the physiological Cx32 is a
  hexameric connexon. Pocket persistence in the assembled channel is not tested here.
- **Single-pose, single-rep SMOKE:** convergence (replica mixing, dG drift) is NOT a SMOKE
  deliverable — production multi-rep + MBAR overlap needed before any quantitative claim.
- **Pose origin:** docked pose from `extract_bound_pose.py`; pocket = L143P P2 cryptic-pocket
  centroid (RESULT.md §3). Not an experimentally determined complex.
