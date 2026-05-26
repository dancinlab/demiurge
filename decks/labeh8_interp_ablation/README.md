# labeh8 METHOD-validity ablation — `electron_phonon='interpolated'` vs `'simple'`

@goal: measure whether `electron_phonon='simple'` overestimates λ_BZ on labeh8 vs the canonical `'interpolated'` (Fermi-surface lambda(k,q) interpolation) — historic Tc 117.24K (PR #248) integrity gate.

## context (PR #248 baseline — `'simple'`)
- σ=0.030 Ry plateau: λ_BZ=3.903 · ω_log=589.03K · Tc(μ\*=0.10)=117.24K
- IBZ q-points: 8 (4×4×4 grid)
- 240 modes total; 3 imag Γ-acoustic (mild, −8.19 cm⁻¹) → harmonic VALID
- Verdict: harmonic-clean; SSCHA anharmonic estimated 80–100K (deferred)
- Record: `exports/material_discovery/rtsc_labeh8_fullbz_elph_20260526.json`

## ablation hypothesis
Per /gap F2 finding — `simple` skips Fermi-surface lambda interpolation and overestimates λ_BZ on BCS conventional. Sibling h3cl ablation showed σ=0.030 `simple` plateau Tc=128K vs interpolated pending. labeh8 must verify the same Δ here.

## verdict gates
- Δλ_BZ < 0.05 (relative <2%) → `simple` ≡ `interpolated` → 117K Tc valid
- 0.05 ≤ Δλ_BZ ≤ 0.20 → caveat; record both
- Δλ_BZ > 0.20 (relative >5%) → `simple` overestimates → N5 wall doc revision mandatory, Tc claim revoked

## deck files
- `scf.in` — P6₃/mmc Z=2 (10 atoms) LaBeH8 @ 20 GPa, ibrav=4, celldm(1)=6.804, c/a=1.611, ecutwfc=80 Ry, 8×8×8 k-grid, mp-smear 0.02 Ry
- `ph.in` — 4×4×4 q-grid, `electron_phonon='interpolated'`, nk=32³ Fermi interpolation, σ-scan 10 values (el_ph_sigma=0.005, el_ph_nsigma=10), recover=.true.
- `run.hexa` — pool ubu-1 launcher (np=4, OMP=1, nice +10, walltime 6h timeout cap; share with h3br agent's running ph.x)

## host
- pool ubu-1 (shared); load already 44.15 from h3br ph.x runners (PID 1781209-1781212 running ph.interp.in for h3cl).
- our run uses small footprint (np=4 / OMP=1 / nice +10).
- cost: $0 (pool free).

## pseudo availability
- La : `/home/aiden/qe_runs/lah10/pseudo/La.pbe-spfn-rrkjus_psl.1.0.0.UPF` (found on ubu-1)
- H  : `/home/aiden/rtsc_h3cl_8q/pseudo/H.pbe-rrkjus_psl.1.0.0.UPF` (found on ubu-1)
- Be : NOT FOUND on ubu-1 — needs download from PSL repo before dispatch:
  ```
  wget -O /home/aiden/rtsc_labeh8_interp_ablation/pseudo/Be.pbe-n-rrkjus_psl.1.0.0.UPF \
    https://pseudopotentials.quantum-espresso.org/upf_files/Be.pbe-n-rrkjus_psl.1.0.0.UPF
  ```
  (validity gate g16 — deck syntax-validate free on pool before any run; missing pseudo would crash pw.x immediately.)

## next on JOB DONE
Parse `ph.out` → λ(σ), ω_log(σ), Tc(σ,μ\*); compute Δ vs PR #248 baseline; write `exports/material_discovery/rtsc_labeh8_interpolated_ablation_20260527.json`.

## status (this commit)
DECK ONLY — not yet dispatched. Pseudo gap (Be) must be filled before fire.
