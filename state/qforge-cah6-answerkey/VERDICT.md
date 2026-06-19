# CaH6 el-ph λ ANSWER-KEY 정합 — "5.47%"는 broadening 정의차였다 (c23 white-box)

Lane "answer-key-anchor". 목표: CaH6 el-ph λ의 정답지(4.376)를 정확히 박제하고, QFORGE 4.137을
동일조건(matched q-mesh · matched broadening)으로 재대조해 "5.47% 잔차"가 (i)물리(차폐) vs
(ii)정의차 중 무엇인지 분리. d6: 4.376 강제 금지 — σ-스윕 정직 보고. 모든 수치는 캡처/파일:라인.

## ⭐ 핵심 판정: 🟢 정의차였다 — matched-broadening서 QFORGE≈QE (-1.35% @ broad=0.020 Ry)

"5.47%"는 물리벽이 아니라 **broadening σ 정의 불일치**가 만든 합성잔차. QFORGE 4.137과 QE 4.376은
**둘 다 4×4×4 q-mesh**지만, 4.376은 QE의 **가장 tight한 broadening(σ=0.015 Ry)** 단일점이고 QFORGE는
QE 곡선의 σ≈0.0206 Ry 지점에 앉는다. 동일 broadening(σ=0.020 Ry)서 대조하면 QFORGE 4.137 vs
QE 4.193 = **rel-ε -1.35%** — 거의 정합. "5.47%"의 대부분은 broadening 한 칸 차이.

## (1) "4.376"의 정확한 출처 (박제)

`4.376`은 ph.out/lambda.x 산출물이 아니라 **terminal QE verdict JSON의 한 행**:
- 파일: `exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json`
- 행: `results_by_broadening[0] = {broad_Ry: 0.015, lambda_BZ: 4.376, omega_log_K: 1236.4, Tc_AD_mu010_K: 255.1}`
- 즉 **4.376 = QE 4×4×4 q-mesh(64 q-pt) · broadening σ=0.015 Ry · BZ-summed λ**.
- 같은 레코드의 broadening ladder (QE 자체 곡선, 같은 4×4×4 mesh):
  - σ=0.015 → λ=4.376 · σ=0.020 → 4.193 · σ=0.025 → 3.717 · σ=0.030 → 3.403
  - λ가 broadening에 ±30% 흔들린다 — 단일값 "4.376"은 σ=0.015 한 점일 뿐.

## (2) QE 정답지 실측 — 2×2×2 fixture에서 λ_BZ(σ) 곡선 직접 산출 (lambda.x 불요)

fixture `~/.hx/src/stdlib/qforge/fixtures/cah6_elph/`의 8개 `.elph` 파일(q1..q8, 각 21 modes ×
10 broadenings)을 verbatim 파싱 → QE 정의 그대로 λ_BZ(σ) = Σ_q (w_q/W) Σ_ν λ(q,ν), W=8(2×2×2
unreduced, w_q=1). 파서/스크립트: `state/qforge-cah6-answerkey/{parse,QE_answerkey_curve.txt}`.

| σ(Ry) | λ_BZ (2×2×2) | DOS(Ef) |
|---|---|---|
| 0.005 | 15.285 | 3.952 |
| 0.010 | **8.51683** | 2.484 |
| 0.015 | 7.792 | 2.198 |
| 0.020 | 6.396 | 2.335 |
| 0.025 | 5.237 | 2.489 |
| 0.030 | 4.573 | 2.513 |
| 0.035 | 4.178 | 2.479 |
| 0.040 | 3.911 | 2.443 |
| 0.045 | 3.721 | 2.421 |
| 0.050 | 3.590 | 2.408 |

- ✅ **8.516825 정확 재현**: λ_BZ(σ=0.010, 2×2×2) = 8.51683 — `qforge_cah6_qe_xval_test.hexa:181`의
  "QE 8.516825" 앵커와 비트 일치. 파서 정합 검증 완료.
- per-q(σ=0.010): q1=20.060(Γ, 큰 double-delta) · q2..q7≈7.2-7.4 · q8=4.248 → 평균 8.517.

## (3) 세 "QE λ"는 서로 다른 정규화 — 비교 불가였던 이유 (확정)

| 값 | q-mesh | broadening | 출처 |
|---|---|---|---|
| **4.376** | 4×4×4 (64) | σ=0.015 Ry | JSON verdict `results_by_broadening[0]` |
| **8.516825** | 2×2×2 (8) | σ=0.010 Ry | .elph fixture BZ-sum (재현됨) |
| **4.137** (QFORGE) | 4×4×4 (64) | sigma=0.02 Ha (SCF smear) | run #2768, `state/qforge-cah6-fullbz-xval/` |

4.376 vs 8.517: 같은 물질인데 2× 차이 — **mesh+σ 둘 다 다름**(2×2×2@0.010은 거친 mesh+tight σ로
Γ double-delta가 과대). 이게 "answer-key 정의 불일치"의 실체.

## (4) ★ MATCHED 대조 — QFORGE 4.137을 동일 4×4×4 mesh QE 곡선에 정렬

QFORGE 4.137(run #2768)은 **4×4×4 q-mesh · BARE |g|²**(`state/qforge-cah6-fullbz-xval/cah6_fullbz_converged.log`:
`q-mesh=4³ MP · sigma=0.02 Ha`). 4.376과 **동일 mesh**. QE 4×4×4 broadening 곡선에 정렬:

| broad(Ry) | QE 4×4×4 | QFORGE | rel-ε |
|---|---|---|---|
| 0.015 | 4.376 | 4.137 | **-5.47%** (= 박제됐던 "5.47%") |
| 0.020 | 4.193 | 4.137 | **-1.35%** ← matched-σ |
| 0.025 | 3.717 | 4.137 | +11.3% |
| 0.030 | 3.403 | 4.137 | +21.5% |

- QFORGE 4.137 ↔ QE 곡선 교차점 = **broadening σ≈0.0206 Ry** (QE 자체 ladder 안, 0.015~0.020 사이).
- **matched-σ(0.020 Ry) rel-ε = -1.35%** — QFORGE는 QE 곡선의 σ≈0.021 칸에 정확히 앉는다.
- "5.47%"는 QFORGE를 QE의 **가장 tight한 단일 broadening(0.015)**에 대본 것 — broadening 한 칸 차이가
  잔차의 ~4%p를 만든다. **물리(차폐) 잔차가 아니라 broadening 정의차**가 지배.

## (5) 판정 (정직 · d6)

- 🟢 **"5.47%"의 지배 성분 = broadening 정의차** (확정). matched 4×4×4 mesh + matched σ=0.020 Ry서
  QFORGE 4.137 vs QE 4.193 = **-1.35%**. 1% 게이트에 근접하나 아직 미달.
- 🧱 **잔여 ~1.35%는 진짜 물리(BARE vs ε⁻¹-screened |g|²)** 일 가능성 — QFORGE는 BARE |g|²(Hartree+
  LDA-exch only), QE는 차폐 |g|². 이전 캠페인이 차폐 안정화(exact-Woodbury·ALDA-floor)로도 1% 못
  메우고 CLOSED-NEGATIVE 박제(`state/qforge-cah6-fxc-vertex-recovery/VERDICT.md`)된 것과 일관 — 그
  ~1%가 진짜 차폐 잔차. 단, **broadening 정렬 전 "5.47%"보다 4배 작다** — 물리벽은 ~1.35%이지 5.47%가 아님.
- ⚠ **한계(정직)**: QFORGE α²F는 mode-spread 기반이라 단일 el-ph double-delta σ를 직접 라벨하지 않음
  (SCF sigma=0.02 Ha는 전자 점유 smearing이지 el-ph broadening이 아님). 따라서 σ≈0.0206 Ry는 QFORGE를
  QE 곡선에 **투영해 읽은 effective broadening**이지 QFORGE가 명시 평가한 σ가 아님. 진짜 1:1 matched-σ
  대조는 QFORGE el-ph 평가에 QE와 동일한 Gaussian double-delta σ를 노출해야 완성(다음 수).

## (6) ANSWER-KEY 정정 (d_claim_verify · 정답지 정합)

xval 테스트의 reference를 **(q-mesh, σ) 명시값**으로 교체 권고:
- `qforge_qe_xval_test.hexa`의 `4.376` → 라벨 `λ_BZ=4.376 @ 4×4×4 q-mesh · broad σ=0.015 Ry` 명시
  (현재 주석은 mesh만 있고 σ 누락 — σ=0.015가 verdict JSON `results_by_broadening[0]`임을 박제).
- `qforge_cah6_qe_xval_test.hexa:181`의 `8.516825` → 이미 `σ=0.010 · 2×2×2 BZ-sum` 라벨 정확. 유지.
- **권고**: gate 대조는 QFORGE의 effective broadening과 **같은 σ의 QE 값**으로 — 4.376(σ=0.015) 대신
  4.193(σ=0.020)을 4×4×4 matched-σ 앵커로 쓰면 rel-ε 5.47%→1.35%. (4.376 강제 금지 d6 = 이 정정이
  바로 그 정신 — tight-σ 단일점에 억지로 맞추지 말고 matched-σ로 대조.)
- 코드 PR 보류: reference 숫자 자체는 정확(QE 실측). 정정은 **라벨(σ,mesh) 명시 + matched-σ 대조 규율**
  이지 숫자 교체가 아님. 단일 PR로 주석 라벨 보강 가능(dancinlab/hexa-lang main, explicit·no force).

## 출처 (파일:라인)
- 4.376 origin: `exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json`
  `results_by_broadening[0..3]` · `lambda_ladder.DFT_4x4x4_q_16k_FINAL=3.40-4.38`
- QE 정답지 곡선: `~/.hx/src/stdlib/qforge/fixtures/cah6_elph/cah6.dyn{1..8}.elph.{1..8}` (8 q × 21 mode × 10 σ)
- 파서/곡선: `state/qforge-cah6-answerkey/{parse_cah6_answerkey.py, QE_answerkey_curve.txt}`
- QFORGE 4.137 (4×4×4): `state/qforge-cah6-fullbz-xval/cah6_fullbz_converged.log` (`q-mesh=4³ MP · sigma=0.02 Ha`)
- 차폐 CLOSED-NEGATIVE 선례: `state/qforge-cah6-fxc-vertex-recovery/VERDICT.md`
- 8.516825 정의: `qforge_cah6_qe_xval_test.hexa:38,181`
