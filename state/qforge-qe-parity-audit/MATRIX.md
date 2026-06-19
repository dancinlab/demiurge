# QFORGE↔QE 동등(parity) 전수 감사 — 정직 매트릭스 (c23 렌즈) 2026-06-19

## 핵심: "동등"은 두 종류
- (A) assembler/closed-form 레그 — QE의 |g|²·ω를 **입력 공유**, 어셈블만 비교 → **진짜 matched ✅** (1.65e-7은 여기)
- (B) from-scratch front-end |g|² — QFORGE 독립 정점계산 → **전부 🧱 gate 미달**(best 5.12%, 대개 closed-neg)
SSOT가 이 분리를 정확히 박제(c9). "1.65e-7 gate-grade"는 assembler 레그로 한정됨(from-scratch 동등 아님).

## 매트릭스
✅ 동등(matched-condition 검증):
  - L3 α²F→λ 어셈블러: CaH6 1.65e-7 · LaH10 4.74e-7 · YH10 9.76e-5 (σ/mesh 라벨 명시 xval:180-182)
  - L0 Allen-Dynes/McMillan · L1 Eliashberg · L2 a2F moments (closed-form 13/13 PASS)
  - L4 DFPT 포논 solver (해석해 1D/2D 1e-6) · L5 PW-SCF bricks (Sternheimer CPU↔GPU byte-parity 3e-16)
🟡 부분:
  - 포논 ω from-scratch +0.67% (anchor=QE-derived 순환위험·full-BZ만)
  - nspin2 moment: brick PASS, 실셀 k-mesh wall (CoSn m≈0 vs QE 0.43)
  - RbOs2O6/CsOs2O6 moment: HONEST-SKIP (Os-5d PW wall·날조0)
🧱 gap (from-scratch |g|²): mode-a bare 5.47%(matched 1.35%) · mode-c R7 5.12% · GGA f_xc 22%(CLOSED-NEG)
  · normalization ladder 100% · off-diag 73.6% · PAW 72.4% (9 path terminal CLOSED-NEGATIVE)

## c23 위험 플래그
1. CaH6 4.376 σ-라벨 누락 → 이미 정정중(PR#3646·answer-key). 지배적 1건.
2. L3 1.65e-7 → c23 위험 없음(라벨 명시) but "어셈블러 레그"로 한정 인용(일반화시 과대평가).
3. 포논 ω 0.67% → 경미(anchor QE-derived 순환).
4. ★YH10 단위버그(NEW): PR#2502가 qforge_a2f_lambda Hartree-scale로 바꿈 → YH10 L3 테스트 현 main서
   Ha/K=315775 over-count로 깨짐(CaH6는 ha_per_kelvin 수정됨·YH10 follow-up 미적용). 검증 재현성 위험.

## 판정
SSOT는 동등↔gap을 정직 분리·박제(d6·날조0). "동등 미검증을 동등으로 보고"한 사례 0.
즉 production 경로(hybrid: QE|g|²→QFORGE assembler)는 QE-동등 ✅ / from-scratch는 closed-negative(별개 도전).
다음: ①CaH6 1:1 matched-σ 완성(QE Gaussian σ 노출) ②YH10 단위버그 follow-up ③answer-key 라벨 PR#3646 ④from-scratch davidson/screening fix
