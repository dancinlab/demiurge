# MoSn — kagome flat-band 게이트체크 deck (no-cooling/ambient RTSC 트랙)

**가설(hypothesis)**: MoSn (kagome CoSn-type, P6/mmm No.191) 은 캠페인이 확인한 두 실패 모드를 모두 깬다 —
CoSn (flat band E_F 아래 0.44 eV + 자성) · CsV3Sb5 (flat band E_F 위 0.92 eV). Co→Mo 치환으로
**비자성(non-magnetic)** + **flat band E_F 근방** 을 예측. 자매물질 CoSn 데크에서 Co→Mo 치환으로 빌드.

## 구조 (structure)
- P6/mmm (No.191), hexagonal. ibrav=4. nat=6, ntyp=2.
- Mo kagome net z=0 (Wyckoff 3f): (0.5,0,0),(0,0.5,0),(0.5,0.5,0).
- Sn 1a(0,0,0) + 2d (1/3,2/3,1/2),(2/3,1/3,1/2).
- Wyckoff 3f/1a/2d 는 free internal param 이 없음 → vc-relax 는 셀(a, c/a)만 조정.
- ecutwfc=90 Ry, ecutrho=360 Ry (Mo 4d semicore, NC convention, CoSn 매칭). MP smearing 0.02 Ry.
- **nspin=2** + starting_magnetization(Mo)=0.3 = 자성 진단(diagnostic) (비자성으로 붕괴 예상).

## 격자 정직성 (lattice honesty — c9)
MoSn 의 격자상수는 **사전에 알려지지 않음** — a, c/a 를 지어내지 않는다. Mo 금속반경(~1.39 Å) >
Co(~1.25 Å) 이므로 CoSn(a=5.279 Å)보다 약간 큰 값에서 시작: **a≈5.5 Å (10.394 Bohr), c/a≈0.80**
을 STARTING GUESS 로 두고 **vc-relax → DFT 평형 격자** 를 찾는다. relaxed a, c/a 를 보고.

## Pseudos (d13 — NORM-CONSERVING)
- `Mo_ONCV_PBE_sr.upf` — SG15 ONCV PBE-1.2 (scalar-relativistic, z_valence=14: 4s²4p⁶4d⁵5s¹ semicore).
  fetch: http://quantum-simulation.org/potentials/sg15_oncv/upf/Mo_ONCV_PBE-1.2.upf
- `Sn_ONCV_PBE_sr.upf` — CoSn 데크에서 재사용 (SG15 ONCV PBE-1.2, z_valence=14). 동일 family → 일관성 ✓.

## 파일 (files)
| file | purpose |
|---|---|
| `vc-relax.in` | 셀 relax (Wyckoff free param 없음 → a, c/a 만 이동) |
| `scf.in` | ground-state SCF (nspin=2), tight conv_thr 1d-10 |
| `bands.in` | flat-band 측정 Γ–K–M–Γ–A; dE = E_flat − E_F 보고 |

## 사전등록 falsifiable 게이트 (PRE-REGISTERED — c9, 골대 이동 금지)
scf+bands 후 ΔE = E_flatband − E_F (kagome flat band offset) 와 magnetization m 측정.
- 🟢 **PASS**: |ΔE| < 0.10 eV **AND** m < 0.5 μB → DFPT λ/Tc 승급 (no-cooling RTSC lead 등재)
- 🔴 **FALSIFY**: ΔE > 0.2 eV **OR** m > 0.5 μB → CLOSED-negative, fallback (HfSn → LaRu3Si2 → LaCoSi)
- 🟠 **INCONCLUSIVE**: 0.1 ≤ |ΔE| ≤ 0.2 AND m<0.5 → 정직 보고, electron-doping 정렬 제안

## 워크플로우 (workflow)
1. vc-relax → relaxed a, c/a 를 scf.in / bands.in 의 celldm 에 반영.
2. scf (nspin=2) → bands → flat-band ΔE vs E_F + total magnetization.
3. d16 free dry-run (1-iter) 으로 directive/pseudo 검증 후 d17 full fire. host = summer pool-free QE (-np 4 plain).

## Status (2026-06-15)
deck authored · pseudo (Mo SG15-1.2 fetched + Sn reused) · d16 free validate + d17 fire = 본 게이트체크에서 실행.
