# 💧 H₃O imaginary mode −682 cm⁻¹ origin 규명 (RTSC N5 · gap F8)

**alias**: "h3o 가상모드 출처" · **gap**: `/gap h3o` F8 (unowned load-bearing — imaginary mode 물리적 origin)
**입력**: `~/etc/rtsc-results/h3o/ph.out` (6×6×6 q · 16 irr q-point) + `scf.in` / `scf.out`
**분석**: 로컬 parse only (pod 0). `.dyn` 파일은 로컬에 없어 명시적 변위 벡터(eigenvector)는 직접 못 읽음 → **mode-symmetry(군론) + 질량가중 frequency 논증**으로 규명. 직접 변위 벡터는 후속(아래 §6) 필요.

---

## 1. 구조 (확인됨)

- `ibrav=3` (bcc), `celldm(1)=4.89945`, `nat=4`, `ntyp=2`.
- O 1개 @ (0,0,0) + H 3개 @ (½,0,0)·(0,½,0)·(0,0,½) (alat).
- = **cubic inverse-perovskite / ReO₃-type, 공간군 Pm-3m (O_h, 221)**. scf.out: `48 Sym. Ops., with inversion, found` ✅
- Wyckoff: O = 1a (점군 m-3m, **반전중심**) · H ×3 = 3d (점군 4/mmm, edge-midpoint).

## 2. imaginary mode q-point · freq (parse 결과)

ph.out 에 **16 irreducible q-point** 전부 진단됨. imaginary(음수) frequency 가 **거의 모든 q-point** 에 다수 존재 — 총 **43개 imaginary 분기**.

| 위치 | q (2π/a) | 대표 imaginary freq | mode symmetry |
|---|---|---|---|
| **Γ** (zone center) | (0,0,0) | **−682.0 cm⁻¹ (×3)** | **T₁u (Γ₁₅ / Γ₄⁻), IR-active** |
| Δ/Σ 근방 | (0,−⅙,⅙) | −882.6 / −641.8 / −623.2 | B₁ / A₁ / B₂ |
| **L** (zone boundary) | (−⅓,⅔,−⅓) | **−1133.1 cm⁻¹ (worst, ×2)** | **E (L₃)** + −774.9 A₁(L₁) |
| H/N 등 기타 | 다수 | −1077 · −1043 · −1004 · −970 … | E·A·B 혼합 |

- **−682 cm⁻¹** 은 사용자 지목값 = **Γ-point(zone-center) 의 삼중축퇴 optical T₁u mode**.
- 단, 이것은 가장 약한 imaginary 가 아니다. **불안정성의 진짜 천장은 zone boundary(L) 의 −1133 cm⁻¹** — 즉 안정화의 핵심 표적은 Γ 가 아니라 zone-boundary(주기 배증/구조 distortion) 쪽.

## 3. eigenvector — 어느 atom / 어느 방향 (군론 논증)

`.dyn` 변위 벡터 미보유 → 두 독립 논거로 **H-부격자 변위**로 확정:

**(a) 질량가중 frequency 논거.** ω ∝ 1/√m. O/H 질량비 = 15.999/1.008 ≈ 15.9 → √비 ≈ 3.98. O 가 주로 움직이는 분기는 H 분기보다 ~4배 낮은 주파수 영역(≲ 400–500 cm⁻¹, acoustic 근처)에만 존재. **|−682| cm⁻¹ 및 그 이상 영역(−623 ~ −1133)은 전부 H-지배 고주파 대역**. (대조: 이 셀의 최고 실수 mode 1953·1767·1738 cm⁻¹ = O–H stretch, 전형적 H 운동.)

**(b) Γ-point 군론 논거 (결정적).** Pm-3m 에서 O 는 반전중심(1a). Γ optical mode 의 기약표현 분해에서 **O 원자는 반전중심에 있으므로 acoustic T₁u 에만 기여**하고, optical 분기에는 변위로 들어갈 수 없다 (site-symmetry 가 O 의 모든 변위를 acoustic 병진으로 흡수). 따라서:
- Γ modes 4–6 (−5.5 cm⁻¹, T₁u, ≈0) = **acoustic 병진** (수치 잡음, 무시).
- Γ modes 1–3 (**−682 cm⁻¹, T₁u optical**) = **순수 H-부격자 변위** — O 는 정지, 3개 H 가 함께 한 방향으로 횡(transverse) 변위.

→ **−682 cm⁻¹ = H 원자(들)의 자유도. O 는 움직이지 않음.** 방향: T₁u(Γ₄⁻, 극성/IR-active) → H 부격자가 O 격자에 대해 **off-center 횡변위(proton off-centering / O–H 결합 굽힘·전단)**. O–H stretch(종방향, 1700+ cm⁻¹ 실수)가 아니라 **H 의 횡(bend/libration·off-center)** 채널이 soft.

## 4. 물리 해석 (1–2줄)

고대칭 Pm-3m H₃O 격자는 **프로톤(H 부격자)을 대칭 edge-midpoint 에 묶어두는 복원력이 음(陰)** → 구조가 H 를 off-center 로 밀어내며 더 낮은 대칭으로 자발 distortion 하려 한다 (전형적 hydrogen-bonded·hydride proton off-centering / soft-mode 불안정). Γ(−682)는 이 불안정의 한 단면일 뿐, **L(−1133)에서 더 강해** 실제 바닥상태는 zone-boundary mode 가 응결한 주기-배증·저대칭 구조다.

## 5. 안정화 후보 3 (어느 자유도를 잡나)

1. **저대칭 구조 relax (1순위, freeze-distortion).** 가장 음인 mode(L −1133, Γ −682)의 변위를 따라 H 를 off-center 시킨 supercell(주기 배증)을 ionic-relax → R3m/Cmcm/lower 후보. precedent 와 동일 패턴(고대칭 dynamical-unstable → 저대칭 stable). **이게 "imaginary 제거"의 정공법.** 단 relax 된 구조의 λ·Tc 는 재계산 필요(저대칭화는 보통 λ↓ 위험).
2. **압력 (proton 복원력 회복).** 압축은 O–H 거리·격자를 줄여 proton off-centering 우물을 단일 우물로 되돌리는 경향 → soft mode hardening. 압력 스윕(예 50·100·150·200 GPa)에서 Γ·L imaginary 가 real 로 넘어가는 임계압 탐색. (H₃S 의 압력-유도 R3m→Im-3m 경화와 동형.)
3. **동위원소·양자 핵효과(NQE)는 신중히.** D 치환은 ω·anharmonic well 을 바꾸지만 **조화 imaginary 자체(곡률 음수)는 질량무관** → 단순 D 치환만으론 imaginary 안 사라짐. 대신 **anharmonic/SSCHA(stochastic self-consistent harmonic approx) 로 자유에너지 곡률 재계산** — 강한 양자/비조화 프로톤계에서 조화-imaginary 가 비조화-실수로 살아나는 경우 다수(H₃S·LaH₁₀ precedent). **조화 ph.x 가 과대 불안정을 보고했을 가능성**을 SSCHA 로 검증.

## 6. 정직성 (d2/d6)

- **eigenvector 직접 미확보**: `.dyn`(`/root/rtsc/h3o/h3o.dyn*`) 파일이 로컬에 없어 명시적 변위 벡터는 못 읽음. §3 결론은 **군론 + 질량가중 논증**(둘 다 독립적으로 H-부격자 지목) — 견고하나 직접 검증 후속 권장: pod 에서 `h3o.dyn1`(Γ) 회수 또는 `dynmat.x`/`matdyn.x` 로 `eigen_displacements`(amass·eigenvectors) 출력 재run → H 변위 성분 직접 확인.
- **d2 — 안정화 불가가 아니다**: 43개 imaginary 는 고대칭 Pm-3m 가 **동역학적으로 깊이 불안정**(metastable 도 아님)임을 뜻한다. 그러나 이는 "물질 불가"가 아니라 "**이 가상의 고대칭 구조가 바닥상태가 아님**" — breakthrough path = (i) 저대칭 바닥상태 구조 탐색(§5-1) → 진짜 H₃O 다형체에서 재평가, (ii) 압력 안정화 창(§5-2), (iii) SSCHA 비조화 구제(§5-3), (iv) 조성 변형(O→다른 음이온 / H 부분치환)으로 proton 우물 복원. **고대칭 H₃O 의 λ_BZ=2.7·Tc≈190K 수치는 imaginary 분기를 포함·외삽한 값이라 물리적으로 신뢰 불가 — 안정 구조 확정 전까지 Tc 주장 보류.**
