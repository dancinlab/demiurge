# CoSn — kagome flat-band RTSC deck (anima handoff [8e6ad1b2]/[bb095261])

**Hypothesis pivot**: ambient room-temp Type-II SC via high-quantum-metric flat-band kagome (NOT hydrides). CoSn = clean non-magnetic/no-CDW base (RTSC_14). Goal: confirm kagome FLAT BAND + measure ΔE vs E_F + ⟨g⟩, then electron-dope to align flat band → ~200-240 K predicted.

## Structure
- P6/mmm (No.191), hexagonal. ibrav=4, a=5.279 Å (9.9760 Bohr), c/a=0.8068.
- Co kagome net at z=0 (Wyckoff 3f); Sn 1a(z=0) + 2d(z=1/2). nat=6, ntyp=2.
- ecutwfc=65 Ry, ecutrho=520 Ry. MP smearing 0.02 Ry.
- **nspin=2** + starting_magnetization(Co)=0.3 = magnetism DIAGNOSTIC (expect collapse → non-mag clean base; confirms RTSC_13).

## Files
| file | purpose |
|---|---|
| `vc-relax.in` | cell relax (Wyckoff has no free internal params → only a, c/a move) |
| `scf.in` | ground-state SCF (nspin=2), tight conv_thr 1d-12 for DFPT |
| `bands.in` | flat-band measurement Γ–K–M–Γ–A; report ΔE = E_flat − E_F |
| `ph.in` | DFPT el-ph 2×2×2 q (phase-2, after flat-band aligned) |

## Pseudos (d13) — NORM-CONSERVING required (3rd blocker resolved)
- **QFORGE is norm-conserving ONLY** — standard eigenproblem (no overlap S), UPF parser hard-rejects ultrasoft, no augmentation density. → ultrasoft rrkjus **cannot run in QFORGE** (would only work in QE).
- **Fix = NC substitution**: `Co_ONCV_PBE_sr.upf` + `Sn_ONCV_PBE_sr.upf` (PseudoDojo PBE/std/SR or SG15 ONCV), ecutwfc raised 65→90 Ry for Co 3d. Matches existing `CaH6_NC/` deck convention.
- **fetch pending (network-gated)**: PseudoDojo http://www.pseudo-dojo.org/ (PBE·standard·SR·UPFv2) or SG15 http://quantum-simulation.org/potentials/sg15_oncv/ → `pseudo/`. Co 3d semicore: confirm valence/ecut on download.

## Measurement plan (1 = phase-1 free/cheap, 2 = phase-2 cost-gated)
1. SCF (nspin=2) → bands → **flat-band ΔE vs E_F + magnetization check**. nat=6 small (d7: pool-free / Vast-CPU).
2. DFPT → λ → Tc (QE) + QFORGE cross-val (g5 gate) → doping/strain sweep (RTSC_14 x≈0.6).

## Status (2026-06-14)
deck authored · d11 sizing + d16 free validate pending · pseudo fetch pending · rent/fire = user-gated.
QFORGE prereq [bb095261 gap2]: nspin=2/LSDA implementation (hexa-lang stdlib/qforge) IN PROGRESS.
