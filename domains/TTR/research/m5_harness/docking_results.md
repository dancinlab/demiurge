# M5 docking 결과 (pool CPU 무료 스테이지 · 2026-05-25)

> 실행: ubu-1 `ttr-m5-prep` env (AutoDock Vina 1.2 · exhaustiveness=8 · seed=42) · **과금 0** (pool CPU, @D d7).
> 범위: docking = 결합 pose/친화도 1차 스크리닝. 반응 ΔG·Ea·ROS·K_cat 는 GPU MD/DFT 스테이지(유료) 별도.

## 1. 효소-기질 docking 친화도

| cell | 복합체 | box 중심 | top ΔG_bind | 해석 |
|---|---|---|---|---|
| c05 | DyP(4G2C/A) + azo | heme Fe (-16.8,-15.7,45.8) | **-7.30** kcal/mol | 강한 결합 (Kd ~수 μM) · azo 환원 자리 정합 |
| c06 | DyP(4G2C/A) + Cu-Pc | heme Fe | **-7.18** kcal/mol | ★ **Cu-Pc 벽 안료에도 DyP 결합** → DyP-engineered 돌파 path 지지 |
| c07 | AzoR(1V4B/A) + azo | FMN centroid | **-5.38** kcal/mol | 느슨 (Kd ~100 μM) · FMN 외부권 전자전달엔 충분 |

- pose 파일: `ubu-1:~/ttr-m5/out/c0{5,6,7}_*_poses.pdbqt` (각 5 pose)
- ⚠ tier: **Vina 경험적 scoring (외부 도구)** — hexa-native 🔵/🟢 아님. 결합 pose **랭킹/타당성** 용도 (절대 ΔG 아님).

## 2. CeO₂ 나노자임 NP 구조

`out/ceo2_np.xyz` — mp-20194 fluorite 에서 carve: **Ce43 · O56 · 99원자 · r=6.7 Å**. 표면 산소공공(ratio 1.30 < 2.0) = **나노자임 ROS 활성 자리**(Ce³⁺/Ce⁴⁺ redox)로 물리적 적절. c01-c04 DFT 입력.

## 3. 준비 완료 입력 (GPU 스테이지 직전)

| 항목 | 상태 |
|---|---|
| 효소 PDB ×5 · 리간드 ×5 (2D→3D embed 포함) · 산화물 ×4 | ✅ staged ubu-1/mini |
| CeO₂ NP carve | ✅ `ceo2_np.xyz` |
| 효소 docking pose (c05·c06·c07) | ✅ MD 입력 pose 확보 |
| 🔧 근사 cofactor (Compound-I · FMNH⁻) | docking 은 resting-state 사용 (cofactor 활성화는 **반응 ΔG MD/DFT 단계**에서 의미 → GPU 스테이지로 이연) |

## 4. 다음 = GPU MD/DFT 스테이지 (유료 · fire-checklist)

docking 으로 결합 타당성 확인 완료 → 이제 GPU pod 에서 MD(결합 안정성) + DFT(반응 ΔG·Ea·ROS). vast on-demand ~$203 (README §7). **rent 는 최종 승인 후에만.**
