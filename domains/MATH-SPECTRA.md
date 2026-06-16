# 🔢 MATH-SPECTRA — "스펙트럼 탐정"

> icon 🔢 · NAME `MATH-SPECTRA` · alias "스펙트럼 탐정 (eigenvalue pattern hunter)"

@goal: 수학·물리 교차 스펙트럼 패턴을 자체 탐색·검증 — 리만 ζ 영점(임계선 위
동위선상 일자 배치) ↔ 랜덤행렬 보편성(GUE, 몽고메리-오들리츠코) ↔ 응집물질
인접행렬 스펙트럼(플랫밴드 CLS·힐베르트-폴리아) 의 공식 동형을 추적한다.
**정직(c9)**: 수치 탐색·검증 도메인이지 정리 증명이 아니다. RH 증명 주장 금지.

## 진행 (milestones)

- [x] M1 ζ 영점 임계선 검증 + 간격통계 GUE 대조 (probe 1)
- [x] M2 플랫밴드 인접행렬 스펙트럼 통계 — 보편성 클래스 판별 (kagome/Lieb)
- [x] M3 ζ ↔ 격자 스펙트럼 동형 여부 정직 판정 (다리 성립/불성립)
- [x] M4 플랫밴드 CLS 개수의 조합론·정수론 구조 탐색 (probe2) — 🔴 정수론 부재 / 🟢 선그래프·Lieb 정리 검증
- [x] M5 mod-q / gcd(L,q) 정합성 일반화 — 고불균형·r:1 격자 (dice/T₃, 일반 Lieb-n n=2,3,4, 장식 선그래프) (probe3) — 🔴 정수론 부재 종결 (전 플랫밴드족): 오프셋은 격자 기하주기 q_min 의 유한·유계 정합항(gcd(L,q_min)), 소수 무신호 — probe2 mod-2 패리티의 일반화일 뿐

## 메커니즘

manifest-only 도메인(d4). probe = 로컬 numpy/scipy/mpmath (무료, 렌트 불필요).
검증 = 수치 재현 + 사전등록 가설 대조(frozen-first) + 대조군(Poisson/GUE/GOE).
SSOT 결과 = exports/math-spectra/<probe>.json + RTSC_LEDGER 동위 MATH 행.

## 다리 (cross-domain)

- 힐베르트-폴리아: RH 영점 = 자기수반 연산자 고유값 (추측)
- 몽고메리-오들리츠코: ζ 영점 간격 = GUE = 양자카오스 해밀토니안 간격
- 우리 RTSC: 플랫밴드 = 인접행렬 CLS (선그래프·이분불균형 정리, 삼각측량 v4)
