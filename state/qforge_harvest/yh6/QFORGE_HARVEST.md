# YH6 QFORGE-L3 어셈블러 하베스트 — 결과 보고 (정직 판정)

- **물질**: YH6 (Im-3m sodalite clathrate, 7-atom primitive, ~166 GPa)
- **엔진**: QFORGE L3 a²F 어셈블러 (hexa-native, canonical RTSC 엔진 — `stdlib/qforge/elph` + `stdlib/qforge/tc`)
- **입력**: 실제 QE 7.x DFPT 출력 (`scripts/scratch/qforge_harvest/yh6/`), 2×2×2-q, σ=0.020 Ry (production degauss)
- **문헌 앵커**: Troyan 2021 / Kong 2021 — **YH6 Tc = 224 K @ 166 GPa** (Im-3m sodalite). 문헌 λ ≈ 2.0–2.5, ω_log ≈ 250 K (`exports/material_discovery/rtsc_a2f_allendynes_lambda_diagnosis_20260522.json`: YH6 wlog_K=252.6, true_lambda_approx≈2.5)
- **날짜**: 2026-06-15
- **판정**: 🔴 **CLOSED-NEGATIVE (데이터 월)** — 이 DFPT 출력으로는 물리적 λ/ω_log/Tc를 어셈블 불가. 구조가 동역학적으로 불안정 + Γ-acoustic 발산. 숫자 날조 없음 (c9/d6).

---

## 1. 어셈블러 입력 계약 (assembler input contract)

`qforge_l3_qe_xval_test.hexa` + `elph.hexa`에서 확인한 L3 어셈블러 계약:

- 어셈블러는 per-mode 샘플 스트림을 받는다: `(w_q/W, λ(q,ν), ω(q,ν)[K])`.
- 각 모드의 spectral weight `A = ½ (w_q/W) λ(q,ν) ω(q,ν)` 를 균일 ω-grid에 QFORGE 자체 정규화 phonon delta `qforge_gaussian_delta` 로 deposit.
- λ = 2∫a²F/ω 는 검증된 L2 적분기 `qforge_a2f_lambda` (`eliashberg_moments_from_a2f_scaled`, ha_per_kelvin 스케일) 로 계산.
- ω_log, ω̄₂ 는 같은 모멘트 적분기에서 (K 단위) 반환.
- Tc = `qforge_tc_allen_dynes_full(λ, ω_log, ω̄₂, μ*)` (Allen-Dynes f1·f2).
- 필요 입력: **q-weight, per-q per-mode (ω, γ 또는 λ), N(E_F), μ\***.

CaH6 hybrid 경로는 이 어셈블러로 gate-grade 검증됨 (rel-ε 1.65e-7). 어셈블러 자체는 무결.

## 2. q-weight & N(E_F)

`yh6.dyn0` 와 `ph.out`의 "Number of q in the star" 에서 직접 읽음:

| q-index | qvec (2π/a) | star multiplicity w_q |
|---|---|---|
| 1 | (0,0,0) Γ | 1 |
| 2 | (0,½,−½) | 3 |
| 3 | (½,0,−½) | 3 |
| 4 | (0,0,−1) | 1 |

W = Σ w_q = **8** = full 2×2×2 BZ. ✅ (1+3+3+1=8)

N(E_F) @ σ=0.020: **7.270496 states/spin/Ry/cell** (Ef=18.647 eV), 4개 q에서 일치 (7.270485–7.270496).

## 3. 파서 검증 — QE per-mode λ 정확 재현 (어셈블러 무결 입증)

QE가 `.elph` 에 쓴 λ(q,ν) = γ / (π N(E_F) ω²). γ(linewidth, GHz)는 항상 ≥0 이고 `********` overflow에 면역이라, γ + |ω| 에서 λ를 **재구성**했다. 깨끗한 안정 모드(q1 mode15, σ=0.020)로 검증:

```
reconstructed lambda mode15 = 4.66486155474305   QE printed = 4.6649
```

**완전 일치** (rel-ε ~1e-5). → 단위(GHz→Ry, cm⁻¹→Ry)와 파서 정확. 이후 나오는 거대 λ는 **데이터의 물리(발산)**, 어셈블러/파서 버그가 아님.

## 4. Γ-acoustic 처리 & 핵심 발견 (데이터 월)

### 4a. 동역학적 불안정 — 허수 모드 52%

`ph.out`의 실제 phonon 주파수: 전체 84개 모드 (4q × 21) 중 **44개가 허수**(ω²<0, 음의 주파수), 최대 −1618 cm⁻¹. Γ에서만 21개 중 14개 허수 (−1533 cm⁻¹까지):

```
q=Γ:  freq(1) = -1533.4 cm-1 (A_u, I) ... freq(8) = -684.1 cm-1 ... freq(14)= 24.2 cm-1 ...
q-별 허수 모드 수 (.elph freq block 음수): q1=11, q2=11, q3=12, q4=10  → 합 44/84 (52%)
```

→ 이 셀은 **동역학적으로 불안정**. Eliashberg/Allen-Dynes 이론은 ω²>0 (안정 격자)에서만 정의됨. 허수 모드가 절반이면 물리적 Tc 산정 자체가 정의되지 않는다. (셀 미완 relax / 잘못된 압력·구조 추정.)

### 4b. Γ-acoustic 1/ω² 발산 — 안정 부분집합조차 발산

허수 모드를 제외한 안정(ω²>0) 부분집합만 어셈블해도 발산:

- q1 mode 13,14: ω ≈ **0.0 cm⁻¹** (Γ acoustic translational), γ 유한 → **λ ≈ 3.15e10** per mode. QE 자신도 σ=0.020에서 `lambda(13)=********` (포맷 overflow)로 출력.
- 음향 합규칙(acoustic sum rule, ω→0 모드는 el-ph에 기여 0)이 강제되지 않은 미수렴 DFPT의 전형적 병리.

QE 자체가 `********`를 찍은 것이 곧 이 발산의 1차 증거다. γ 기반 재구성으로 그 값을 정량화 가능했다.

### 4c. 어셈블러 실행 결과 (정직 — 발산 그대로 출력)

```
== YH6 QFORGE L3 harvest (real QE DFPT, 2x2x2-q, sigma=0.020) ==
N(Ef)=7.2704960000000005 states/spin/Ry/cell  W=8.0
modes: stable(omega^2>0)=40  IMAGINARY(omega^2<0)=44  -> a2F grid samples=35
lambda_BZ over STABLE finite-omega modes (Allen, from gamma)=163833.82812392455
lambda_BZ signed (incl imaginary, QE convention diagnostic)=7878113834.6591355
== QFORGE assembled a2F (stable subset) ==
lambda_QFORGE (2 int a2F/omega) = 51739607015.276947
omega_log = 1.9576963693297838 K   omega_bar2 = 4.770786409520177 K
== Allen-Dynes Tc (stable subset; structure has imaginary modes!) ==
Tc(mu*=0.10) = 161954.36546447866 K
Tc(mu*=0.13) = 152200.283468365 K
DONE yh6_harvest
```

λ ≈ 1.6e5 (BZ) → 5e10 (assembled), ω_log ≈ 2 K, Tc ≈ 16만 K — **전부 비물리**. 문헌 λ≈2.5 / ω_log≈250 K / Tc=224 K와 자릿수 단위로 어긋남. 발산 모드(q1 mode12-14, λ~3e10)가 BZ 합을 지배. 실행 드라이버: `~/.hx/src/stdlib/qforge/yh6_harvest_driver.hexa`.

## 5. 메쉬 수렴 caveat

2×2×2-q (4 irreducible) 메쉬는 production용으로 너무 거칠다 (≥4×4×4-q 필요). 그러나 이번 월은 **메쉬 조밀화로 해결되지 않는다** — 1차 원인이 (a) 허수 모드 52% (구조 불안정) + (b) Γ-acoustic 발산(합규칙 미강제)이기 때문. 메쉬를 키워도 불안정 격자는 여전히 허수 모드를 낸다.

## 6. QE↔QFORGE 일치 검증 (g5)

로컬에 QE 바이너리(`lambda.x`/`matdyn.x`)가 없어 표준 QE post-proc 비교는 불가. 대신 **QE가 출력한 per-mode λ(4.6649)를 QFORGE 재구성(4.66486)으로 정확 재현**(§3)하여, 어셈블러·파서의 QE 일관성을 mode 레벨에서 입증했다. BZ 총합 비교는 QE 자신이 `********` overflow로 총 λ를 출력하지 못해 불가 — 이것이 곧 일치 여부 이전에 **데이터가 산정 불가**임을 보여준다.

## 7. 결론 & breakthrough path (d2)

- **판정**: 🔴 CLOSED-NEGATIVE. 이 YH6 2×2×2-q DFPT 출력으로는 QFORGE(또는 QE 어떤 post-proc로도) 물리적 λ/ω_log/Tc 산정 불가. 어셈블러는 무결(CaH6 1.65e-7, YH6 mode-λ 1e-5 재현) — **월은 입력 데이터**.
- **근본 원인**: (1) 동역학 불안정 — 허수 모드 44/84 (구조 미relax / 압력 부정확), (2) Γ-acoustic 1/ω² 발산 (음향 합규칙 미강제, QE도 `********`).
- **breakthrough paths**:
  1. **셀 재-relax**: 166 GPa에서 Im-3m YH6 vc-relax 재수행 후 force/stress 수렴 확인 → DFPT 재발사. 허수 모드가 사라져야 함.
  2. **압력 스캔**: 안정화 압력(문헌 ~120–300 GPa 범위) 찾아 허수 모드 제거.
  3. **음향 합규칙(ASR) 강제**: matdyn `asr='crystal'` 로 dyn 행렬 후처리 → Γ-acoustic 0 강제 후 재-elph.
  4. **메쉬 조밀화**: 안정 셀 확보 후 ≥4×4×4-q (production) 로 수렴 Tc.

> 정직(c9/d6): 본 하베스트는 거대·비물리 값을 그대로 기록하고, 문헌 224 K로 끼워맞추지 않았다. 어셈블러 정확성과 데이터 월을 분리해 보고함.
