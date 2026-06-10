# SENOLYX R12-GOLD breakthrough ① — multi-replica ensemble-average ABFE

## Why this exists

The R12-GOLD definitive ABFE run (`abfe_hsp90_pair.py`, PR #613) gave:

| ligand | ABFE (kcal/mol) |
|--------|-----------------|
| 17AG   | +18.84 ± 0.39   |
| 17AAG  | +16.10 ± 0.57   |
| **ΔΔG** | **+2.74** |

Experiment is ΔΔG ≈ **−1.9** kcal/mol (17AG tighter, cb600224w). The gold run is
**WRONG sign**, and the prior R12-smallbox run gave −1.42 — a different number
again. Root cause (CLOSED-NEGATIVE in `SENOLYX.log.md`): the **per-leg dG are
run-to-run unstable / bistable**. The 17AG complex leg landed **58.12** in R12 vs
**53.55** in gold — a ~4.6 kcal/mol swing between two runs of the *same deck*. A
single ABFE-difference cannot cancel that: each run lands on one branch, and the
two ligands' branch-landings are uncorrelated, so the difference inherits the full
~4–5 kcal/mol noise rather than cancelling it.

## The fix (breakthrough ①)

Run **K independent replicas** per (ligand, leg), each with a **distinct seed** for
both the equilibration integrator + velocity assignment AND the replica-exchange
production move. Ensemble-average each leg's dG (**mean ± stderr over reps**) and
*then* form ΔΔG.

- If the bistability is **seed / sampling-driven** (different replicas land on
  different branches at random), the ensemble mean converges to the true dG and the
  stderr shrinks ~÷√K. With K=5 a ~4.5 kcal/mol single-run spread → ~2.0 kcal/mol
  stderr per leg → the ΔΔG sign should stabilize and become resolvable against −1.9.
- The seed is derived per `(LIG, leg, REP)` by SHA-256 hash (decorrelated streams,
  not a simple `REP*offset` that could alias the integrator's own RNG), and is
  **reproducible** so a resumed run continues the *same* trajectory.

## Grid & cost (honest)

```
K = 5  ×  2 ligands (17AG, 17AAG)  ×  2 legs (complex, solvent)  =  20 leg-runs
```

- Each `(LIG, REP)` invocation runs **both** legs ≈ **4–5 h** on the summer
  **RTX 5070** (N_ITER=1000, 20-window λ, complex ≈ 49.7k atoms).
- 10 `(LIG,REP)` cells × ~4–5 h, **serial on one GPU ⇒ ~4 days** wall-clock.
  (summer is a single free GPU; there is no parallel GPU here, so this is genuinely
  serial. This is the honest floor — d6.) The 20 *legs* are 10 cells because each
  cell does complex+solvent back-to-back.
- **Cost = $0** (summer free GPU; paid pods forbidden for this campaign).

## Resilience

- **Reboot-safe**: per-rep `.nc` checkpoints in persistent `~/abfe-ens/` (NOT /tmp).
  A killed run resumes from its last checkpoint.
- **flock-guarded**: one campaign process at a time; duplicate launches exit cleanly.
- **rc=0 skip-guard ONLY**: a cell is skipped *iff* it wrote its `.done` marker
  (exited rc=0). A killed leg (rc=143/137/≠0) leaves **no** marker, so the next pass
  **re-enters and resumes** it. This is the explicit fix for the gold-driver bug,
  where a `rc=143` SIGTERM-on-reboot was wrongly treated as "done" and the half-
  finished leg was silently skipped.
- **@reboot auto-resume** (install once on summer, documented in `run_ens.sh`):
  ```
  @reboot /home/summer/abfe-ens/run_ens.sh >> /home/summer/abfe-ens/ens_progress.log 2>&1
  ```

## Fire command (THE one command — ~4-day campaign; do NOT run during scaffold)

Install + fire on summer:

```bash
scp exports/SENOLYX/round12-rbfe/{abfe_hsp90_ens.py,run_ens.sh,hsp90_rec_clean.pdb,17AG.sdf,17AAG.sdf} summer@192.168.50.60:~/abfe-ens/
ssh summer@192.168.50.60 'bash ~/abfe-ens/run_ens.sh'
```

or via the sidecar pool:

```bash
sidecar pool on summer 'bash ~/abfe-ens/run_ens.sh'
```

Progress: `~/abfe-ens/ens_progress.log`. The final mean±stderr ensemble-average
(per-leg → ABFE → ΔΔG) prints at the tail of that log when all cells finish; it is
also recomputable any time by re-running `run_ens.sh` (finished cells skip; the
parser re-aggregates whatever ENS_RESULT lines exist so far).

## Honest risk → branch ②

If, after K=5 averaging, the ΔΔG **stderr is small but the sign is still wrong**,
the bistability is a **deterministic deck artifact** (e.g. an incomplete-decoupling
softcore path, an inadequate λ-schedule overlap, or a restraint/SSC mismatch) — NOT
seed noise. Averaging over seeds cannot fix a systematic deck error. In that case
**branch ② (RBFE — relative perturbation 17AG → 17AAG with a single-topology
mapping)** is the real fix: RBFE perturbs only the C17 amino↔allylamino difference,
so the shared ansamycin macrocycle never decouples and the ~50 kcal/mol per-leg
magnitudes that carry the bistability never enter the calculation at all.
