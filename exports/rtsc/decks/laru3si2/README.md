# LaRu3Si2 — Ru-kagome flat-band 게이트체크 deck (no-cooling/ambient RTSC 트랙)

**가설(hypothesis)**: LaRu3Si2 는 **실제 ambient 초전도체** (Ru-kagome, 측정 Tc=7 K — 본 후보군 중 유일한
실측 SC). 캠페인의 두 실패 모드(CoSn: flat band E_F 아래 + 자성 · CsV3Sb5: flat band E_F 위 0.92 eV ·
MoSn: flat band E_F 아래 2.38 eV)를 깬다 — 비자성 + Ru-4d kagome flat band 이 **E_F 근방**.
문헌 DFT (arXiv:2503.20867 / 2303.12273): Ru-dz² kagome flat band 이 **E_F 위 ~0.1 eV**, M-점 vHs ~50 meV,
K-점 Dirac ~0.2 eV 아래. → 본 게이트의 PASS/INCONCLUSIVE 경계에 정확히 걸침 = 의미 있는 테스트.

이것은 **MoSn FALSIFY 후의 사전등록 fallback #1** (deck 명시: MoSn → LaRu3Si2 → LaCoSi).

## 구조 (structure — c9 정직)
- P6/mmm (No.191), hexagonal. ibrav=4. nat=6, ntyp=3.
- **La 1a** (0,0,0) — triangular net.
- **Ru 3g** (1/2,0,1/2),(0,1/2,1/2),(1/2,1/2,1/2) — **KAGOME net at z=1/2** (flat-band layer).
- **Si 2c** (1/3,2/3,0),(2/3,1/3,0) — honeycomb net at z=0.
- Wyckoff 1a/3g/2c 는 free internal param 이 없음 → vc-relax 는 셀(a, c/a)만 조정.
- ecutwfc=90 Ry, ecutrho=360 Ry (Ru 4d + La 5s5p semicore, NC convention, mosn/cosn 매칭). MP smearing 0.02 Ry.
- **nspin=2** + starting_magnetization(Ru)=0.1 = 자성 진단(diagnostic). LaRu3Si2 는 알려진 비자성 SC →
  m≈0 예상 (FM fluctuation 보고는 있으나 정적 모멘트 없음). 실제 테스트는 ΔE.

## 격자 정직성 (lattice honesty — c9)
LaRu3Si2 격자는 **문헌 실측값을 STARTING POINT 로 사용** (지어내지 않음):
**a≈5.68 Å (10.733 Bohr), c≈3.57 Å → c/a≈0.6285** (CeCo3B2-type 실험 격자, kagome-SC 문헌).
이 값에서 **vc-relax → DFT 평형 격자** 를 찾아 relaxed a, c 를 보고. (고온 P6/mmm 상; 저온 charge-order
폴리모프(P6₃/m)는 별도 — 표준 DFT 참조는 고대칭 P6/mmm.)

## Pseudos (d13 — NORM-CONSERVING · 커버리지 확인 완료)
- `La_ONCV_PBE_sr.upf` — SG15 ONCV PBE-1.2 (scalar-relativistic, **z_valence=11**: 5s²5p⁶5d¹6s² semicore).
  fetch: http://quantum-simulation.org/potentials/sg15_oncv/upf/La_ONCV_PBE-1.2.upf (란타나이드 5s5p semicore 확인 ✓)
- `Ru_ONCV_PBE_sr.upf` — SG15 ONCV PBE-1.2 (**z_valence=16**: 4s²4p⁶4d⁷5s¹ semicore).
  fetch: http://quantum-simulation.org/potentials/sg15_oncv/upf/Ru_ONCV_PBE-1.2.upf
- `Si_ONCV_PBE_sr.upf` — SG15 ONCV PBE-1.2 (**z_valence=4**: 3s²3p²).
  fetch: http://quantum-simulation.org/potentials/sg15_oncv/upf/Si_ONCV_PBE-1.2.upf
- 전자 총수 = 11 + 3×16 + 2×4 = **67 e⁻**. 동일 SG15 family → 일관성 ✓.

## 파일 (files)
| file | purpose |
|---|---|
| `vc-relax.in` | 셀 relax (Wyckoff free param 없음 → a, c/a 만 이동) |
| `scf.in` | ground-state SCF (nspin=2), tight conv_thr 1d-10 |
| `bands.in` | flat-band 측정 Γ–K–M–Γ–A–L–H; dE = E_flat − E_F 보고; nbnd=80 |

## 사전등록 falsifiable 게이트 (PRE-REGISTERED — c9, 골대 이동 금지)
scf+bands 후 ΔE = E(Ru-kagome flat band) − E_F 와 magnetization m 측정.
- 🟢 **PASS**: |ΔE| < 0.10 eV **AND** m < 0.5 μB → DFPT λ/Tc 승급 (no-cooling RTSC lead 등재)
- 🔴 **FALSIFY**: ΔE > 0.2 eV **OR** m > 0.5 μB → CLOSED-negative, fallback LaCoSi
- 🟠 **INCONCLUSIVE**: 0.1 ≤ |ΔE| ≤ 0.2 AND m<0.5 → 정직 보고, electron-doping 정렬 제안

## 워크플로우 (workflow)
1. vc-relax → relaxed a, c/a 를 scf.in / bands.in 의 celldm 에 반영.
2. scf (nspin=2) → bands → Ru-kagome flat-band ΔE vs E_F + total magnetization.
3. d16 free dry-run (1-iter) 으로 directive/pseudo 검증 후 d17 full fire.
   host = vast dedicated-core pod (MoSn-proven 경로; CPU free-core 는 Ru-4d Davidson 에서 wall).

## Status (2026-06-16) — 🟢 GATE PASS
deck authored · pseudo (La/Ru/Si SG15-1.2 fetched, z_valence 확인) · d16 dry-run PASS · d17 fire 완료.
**측정 결과 (vast RTX 4090 pod 41060369, ~$0.30, micromamba qe=7.5, 16 dedicated cores):**
- relaxed lattice (vc-relax, 5 bfgs, P=-0.21 kbar): **a=5.7175 Å, c=3.5732 Å** (c/a=0.625, +0.7% vs exptl)
- **E_F = 16.0669 eV** · E_total = -645.935 Ry · SCF 20 iter conv 2.5e-11 Ry
- **m = 0.00 μB** (NON-MAGNETIC — start_mag(Ru)=0.1 붕괴 1.54→…→0.00, true NM ground state)
- **Ru-kagome flat band (band 34)**: Γ–K–M in-plane bw 0.365 eV, mean 16.0115 eV → **ΔE = −0.055 eV** (E_F 아래 55 meV)
- metallic (5 bands cross E_F, Ru-4d), real ambient SC (Tc=7K)
- **게이트: |ΔE|=0.055 < 0.10 eV AND m=0.00 < 0.5 μB → 🟢 PASS (GREEN)** — DFPT λ/Tc 승급
- 세 실패모드 동시 격파: CoSn(-0.44+자성)·CsV3Sb5(+0.92)·MoSn(-2.38). 후보군 중 최강 no-cooling RTSC lead.
- 증거: `exports/rtsc/laru3si2_flatband_gatecheck.json` + `scripts/scratch/qforge_harvest/laru3si2/`
- 다음: DFPT el-ph 승급 (Tc=7K 재현 + mode-selective kagome-phonon coupling, arXiv:2503.22477)
- HONEST (d6): real GPU davidson UNAVAILABLE (conda-forge QE no CUDA) — win은 dedicated CPU cores. bands default-david가 empty band에서 stall → diago_full_acc=.false. fix (MoSn과 동일).
