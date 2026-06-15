# CoSn electron-doped — kagome flat-band alignment gate-check

Data-driven lead from triangulation v2: MEASURED flat-band offsets CoSn ΔE=−0.44 eV (Co 3d⁷),
MoSn ΔE=−2.38 eV (Mo 4d⁵) → rigid-band slope +0.97 eV per added d-electron. Adding ~0.4–0.5 e⁻
to CoSn should lift its kagome flat band TO E_F (ΔE→0), and the same doping may quench CoSn's
weak itinerant magnetism (the original CoSn blocker). Two-birds test.

## Hypothesis + pre-registered gate (frozen, no goalpost move)
Electron-doping by Δn ≈ +0.3–0.6 e⁻/f.u. brings the kagome flat band to E_F while keeping it NM.
Per Δn: ΔE = E_flatband − E_F, and total magnetization m.
- 🟢 PASS: some Δn∈[0.2,0.8] gives |ΔE|<0.10 eV AND m<0.5 μB → promote to DFPT λ/Tc.
- 🔴 FALSIFY: no Δn in range gives |ΔE|<0.10 with m<0.5 → CLOSED-negative, report real curves.
- 🟠 PARTIAL: ΔE aligns but m>0.5 (or vice-versa).
- Δn=0 control MUST reproduce the known CoSn ≈ −0.44 eV (sanity).

## Method — doping via QE tot_charge jellium
`tot_charge = -Δn` in &SYSTEM (negative = ADD electrons; QE adds a compensating uniform jellium
background → standard rigid-band-with-screening doping proxy). Scan Δn∈{0,0.2,0.4,0.6}.
Each: scf (nspin=2, start_mag(Co)=0.3 diagnostic) → bands Γ-K-M-Γ-A → locate Co-3d kagome flat
band, report ΔE vs E_F + final total magnetization.

**Caveat (recorded):** jellium background ≠ real chemical dopant (CoSn₁₋ₓSbₓ / Co₁₋ₓNiₓSn). If a
level PASSES, the follow-up is a real substitutional supercell / VCA to confirm.

## Files
| file | purpose |
|---|---|
| `scf.in.tmpl` | scf template; `__TOTCHG__` placeholder |
| `bands.in.tmpl` | bands template (Γ-K-M-Γ-A, 12 pts/seg, david diago_full_acc=.false. per MoSn proven path) |
| `run_scan.sh` | scan driver — 4 subdirs dn_{0.0,0.2,0.4,0.6}, scf+bands+bands.x each; `DRYRUN=1` = 1-iter Δn=0 syntax check (d16) |
| `parse_scan.py` | parse scf.out + bands.dat.gnu → ΔE(Δn), m(Δn), E_F(Δn) |
| `pseudo/` | Co_ONCV_PBE_sr.upf (z=17), Sn_ONCV_PBE_sr.upf (z=14). 93 e⁻/cell undoped. |

## Run (pod, MoSn-proven RTX-4090/128-core path)
```
DRYRUN=1 bash run_scan.sh 8      # d16 free dry-run first
bash run_scan.sh 16              # full 4-point scan
python3 parse_scan.py            # curves
```
