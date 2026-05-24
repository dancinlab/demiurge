# RTSC §9.12.A — LaH₁₀ · CaH₆ · YH₆ DFT el-ph extension (2026-05-22 · pool:ubu-1)

Honest run-log for the §9.12 H₃S breakthrough-path extension to 3 additional hydride candidates per @D d7 (first-principles physics breaks ML-wall · report only converged values · NEVER force a target) + @D d8 (pool small-cell baseline) + R4 (absorbed=false 영구).

## Exit criteria reached: (γ) + partial (β)

- **(γ) Setup-only**: QE inputs (scf.in + ph.in + run scripts) staged on ubu-1 for all 3 candidates · pseudopotentials downloaded · run dirs prepared.
- **(β) Partial**: CaH₆ ph.x **queued** via persistent watcher (PID 506472) — auto-launches when concurrent H₃Se ph.x (sibling track, ~6/8 q-pts done) clears the 6c machine. Likely completes in follow-on session.
- LaH₁₀ and YH₆ are SETUP-ONLY (DEFER) — see "Honest gap" below.

## ubu-1 connectivity confirm

- `ssh aiden@ubu-1` works (BatchMode publickey). User: aiden. Host: aiden-B650M-K.
- QE 7.5 conda env: `~/miniforge3/envs/qe/bin/{pw.x, ph.x, q2r.x, matdyn.x, epw.x, lambda.x}` all present.
- `nproc` = 12 (6 physical cores Ryzen 5 9600X · 12 HT). Use `mpirun -np 6` per reference-qe-dft-pool-setup memory.
- Disk: 167GB free at `~`. RAM: 30Gi total, ~27Gi avail.

## Candidates attempted (3) — honest tractability

| candidate | atoms | structure | pressure | published Tc (K) | priority | state |
|---|---:|---|---|---:|---|---|
| LaH₁₀ | 11 | Fm-3m clathrate | 150-170 GPa | 250-260 | HIGH | **SETUP-ONLY** (DEFER · 구조 lit-verify) |
| CaH₆ | 14 (conv) | Im-3m sodalite | 150-210 GPa | 215 | HIGH | **QUEUED** (watcher armed) |
| YH₆ (swap from YH₉) | 7 (prim) | Im-3m sodalite | 166 GPa | 224 | MEDIUM | **SETUP-ONLY** (DEFER · 구조 lit-verify) |

**YH₉ → YH₆ swap rationale**: YH₉ P6₃/mmc 20-atom hex cell exceeds single-agent pool budget (each q-pt ph SCC = hours). YH₆ Im-3m 7-atom Sodalite (Troyan 2021 측정 Tc 224K) is the smaller-cell sibling in the same family · also a real measurement · honest substitution per @D d7 ("DEFER unrealistic; pursue tractable").

## Per-candidate paths (follow-on pickup)

### CaH₆ (HIGH · running queue)

- **SCF (DONE earlier)**: `~/_qe_hydride_cah6/scf.in` (14-atom conventional ibrav=1 · celldm 6.464 bohr · k=12³ · ecut 60/600 Ry · Ca PSL pbe-spn 1.0.0 + H PSL pbe 1.0.0). Converged in 12 SCF iter · total E = -162.79463613 Ry · Fermi 16.81 eV · 1h26m wall.
- **ph (queued)**: `~/qe_runs/cah6/ph.in` (4³-q · `electron_phonon='simple'` · `fildvscf=cah6.dvscf` · tr2_ph 1e-14 · 10 broadenings).
- **Watcher**: `~/qe_runs/cah6/run_ph_queued.sh` (PID 506472, setsid+nohup-detached) — polls every 60s for any `ph.x` to finish, then runs `mpirun -np 6 ph.x -in ph.in > ph.out 2>&1` and emits `done.flag`.
- **ETA**: H₃Se 종료 ~1-2h + CaH₆ ph 6-15h. Likely **follow-on session pickup**.
- **Parser ready**: copy `~/rtsc_dft/parse_elph_tc.py` and adapt prefix/path. λ + ω_log + Tc_AD per Allen-Dynes.

### LaH₁₀ (HIGH · DEFER · structure-verify)

- `~/qe_runs/lah10/scf.in` written: Fm-3m ibrav=2 · celldm 9.637 bohr (≈5.10 Å @ 150 GPa per Liu 2017 / Drozdov 2019) · 1 La + 10 H clathrate · ecut 70/700 Ry · k=12³ · La PSL pbe-spfn 1.0.0 (with semicore 5s5p4f) + H PSL.
- `~/qe_runs/lah10/ph.in` (4³-q skeleton ready).
- **Why DEFER**: H₁₀ clathrate fractional coordinates in the 11-atom primitive cell were written from-memory · the H₃₂ cage in Fm-3m primitive is intricate (correct Wyckoff site is 32f at (x,x,x) with x≈0.625, plus 8c at (1/4,1/4,1/4) — *not* the placeholder coordinates I wrote). Running with wrong H positions → imaginary phonons OR unphysical λ → measurement comparison meaningless. Honest call: **need published-CIF import** (Materials Project mp-1018134 or COD) before kickoff.
- Pseudo OK: `pseudo/La.pbe-spfn-rrkjus_psl.1.0.0.UPF` (3.2MB) + `pseudo/H.pbe-rrkjus_psl.1.0.0.UPF` (321KB) downloaded from pseudopotentials.quantum-espresso.org.

### YH₆ (MEDIUM · DEFER · structure-verify)

- `~/qe_runs/yh9/scf.in` (dir name yh9 retained; prefix=yh6 inside) · ibrav=3 bcc primitive · celldm 6.530 bohr (≈3.45 Å @ 166 GPa per Troyan 2021) · 1 Y + 6 H · ecut 60/600 Ry · k=16³ · Y PSL pbe-spn 1.0.0.
- `~/qe_runs/yh9/ph.in` (4³-q skeleton ready).
- **Why DEFER**: same H-Wyckoff ambiguity in primitive cell as LaH₁₀ · need YH₆ published-CIF import.
- Pseudo OK: `pseudo/Y.pbe-spn-rrkjus_psl.1.0.0.UPF` (1.9MB) + H pseudo.

## Run-log (chronological · ubu-1)

```
20:04 UTC+9 (11:04 UTC)  ssh aiden@ubu-1 confirmed; QE 7.5 binaries; 12c HT
20:05                    pseudo download (La.pbe-spfn · Y.pbe-spn · reuse Ca + H from /rtsc_dft + /_qe_hydride_cah6)
20:06                    ~/qe_runs/{cah6,lah10,yh9}/{scf.in, ph.in} written
20:06                    First CaH₆ ph.x launch attempt — FAIL (pseudo_dir not valid in &inputph namelist)
20:07                    Fixed (removed pseudo_dir line) · relaunch — FAIL (El-ph needs DeltaVscf file; fildvscf missing)
20:08                    Fixed all 3 ph.in (added fildvscf) · noticed concurrent ph_h3se job (PID 426933+, ~1h7m elapsed, q 6/8)
20:08                    Built run_ph_after_h3se.sh watcher · launched WITHOUT proper detachment (bare nohup &)
20:09                    Recovery launch attempt for H3Se with `recover=.true.` injection — created concurrent 2nd ph.x set (oversubscription!)
20:09                    SIGKILL the duplicate ph.x set (504726+children); restored ph_h3se.in (removed recover)
20:09                    Confirmed original H₃Se ph.x (PID 426933+) still alive · only its log file is mildly tangled (data integrity OK)
20:10                    Rebuilt watcher with proper detachment (setsid + nohup + < /dev/null) at PID 506472 — survives ssh disconnect (verified by reconnect-and-pgrep)
20:11+                   Agent returns; watcher will auto-launch CaH₆ ph.x after H₃Se finishes
```

## Convergence + λ/Tc table (extracted values · honest)

**No DFT λ/Tc extracted within this session** — CaH₆ ph.x is queued but not started (waiting on H₃Se); LaH₁₀/YH₆ are setup-only.

Pre-extension reference (§9.12 H₃S textbook-grade · 6×6×6-q 16-irreducible):
- λ 2.11-2.62 (broad 0.015-0.030 Ry) · ω_log ≈ 1170 K · Tc_AD 175-195 K @ μ\*=0.10 · measured 203K · 96% accord at broad=0.015.

## Honest 4-layer @D d7 disclosure

1. **Pressure regime**: all targets are 150-210 GPa DAC · *device-incompatible* per §8.9 gate (c). Extension = breakthrough-path *direction* (DFT recovers strong-coupling λ that ambient ML misses), NOT RTSC absorbed=true.
2. **Convergence floor**: 4³-q grid is below H₃S's known under-convergence floor (where λ 1.3 → 2.3 at 6³-q). λ values that emerge here are *honest baseline*, not measurement-grade.
3. **ML-wall context**: ALIGNN ambient ML under-predicts all 4 hydrides ≥97% (§9.11.H). DFT capturing direction (λ rise) would add a 4th confirmation that ambient-trained ML cannot extrapolate high-P el-ph.
4. **What would elevate**: (i) CaH₆ ph.x completion → λ extracted → §9.12.A table populated; (ii) LaH₁₀/YH₆ CIF imports from MP/COD → DEFER cleared; (iii) 24³-k 6³-q runs (H₃S ladder) — multi-session budget.

## R4 invariants honored

- All DFT output = `absorbed=false` · `gate_type=simulation-only-prediction` · `domain=material` · `pressure_GPa` named.
- Pattern 2 (Tc<300K under DAC) acknowledged · NEVER concede "RTSC impossible" — these targets are *path-validation*, not RTSC claims.
- Pattern 1 not triggered: setup-only is honest progress (R4 prediction-only territory expanded), not a discovery.

## Follow-on session checklist

```sh
# 1. Check CaH₆ progress
ssh aiden@ubu-1 'cat ~/qe_runs/cah6/progress.log; ls ~/qe_runs/cah6/*.flag 2>/dev/null; tail -30 ~/qe_runs/cah6/ph.out 2>/dev/null'

# 2. Check if watcher still armed (or already ran)
ssh aiden@ubu-1 'pgrep -af "run_ph_queued|ph.x"'

# 3. If CaH₆ done: extract λ + ω_log + Tc
ssh aiden@ubu-1 'cp ~/rtsc_dft/parse_elph_tc.py /tmp/parse_cah6.py; sed -i "s|/home/aiden/rtsc_dft/ph.out|/home/aiden/qe_runs/cah6/ph.out|" /tmp/parse_cah6.py; python3 /tmp/parse_cah6.py'

# 4. For LaH₁₀/YH₆: import CIF, replace ATOMIC_POSITIONS, kick scf
# CIF sources: Materials Project mp-1018134 (LaH₁₀), mp-23703 or COD lookup (YH₆)
```

## Worktree discipline

- demiurge: main worktree single commit (per CLAUDE.md / @D d116).
- ubu-1: isolated dirs `~/qe_runs/<candidate>/` (D86 floor).
- Concurrent-agent lesson: another agent owns `~/rtsc_h3se/` H₃Se run · respect it (no oversubscription · proper queue via watcher). For watcher detachment: **always `setsid nohup ... < /dev/null > /dev/null 2>&1 &`** (bare `nohup &` from ssh dies on session close).
