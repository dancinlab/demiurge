# 🧲 RTSC-magnet — "초전도 자석 만들기 도구"

> @title: 🧲 RTSC-magnet — "자석 청사진 그리기"
> RTSC 의 자매 트랙. 본체(DFT 발견) 와 별개의 응용 substrate — 발견된 초전도체로 자석 감을 때 어떻게 감을지 청사진 라이브러리.

## 한 줄 요약

- 하는 일: 발견될 상온 초전도체로 코일을 감았을 때, 그 자석이 만드는 자기장 모양을 미리 계산하는 시뮬레이션 데크
- 별칭: "자석 청사진 그리기"
- 비유: 종이도면 + 자 + 컴퍼스 대신 컴퓨터가 "자석 단면도"를 그려서 "여기 가운데에 몇 테슬라 떠?" 답을 미리 보여주는 도구
- 비교: ANSYS Maxwell (상용 GUI) = 한 사람용 캐드,  GetDP (오픈) = 코드로 자동화. 본 도구 = GetDP + Wheeler 해석해로 교차검증 = "두 자가 같은 길이 답하면 신뢰"

## 디렉토리 구조

```
domains/RTSC/magnet/getdp/
  solenoid_axisym.{geo,pro}   ── 1. 솔레노이드 (탑 모양, 좁고 길다)
  pancake_axisym.{geo,pro}    ── 2. 팬케이크 (납작하고 넓다)
  wheeler_axis_b.hexa         ── 3. Wheeler 공식 (해석해)
  wheeler_axis_b_result.md    ── 4. 검증 결과 기록
```

## 2가지 코일 모양 — 같은 와이어, 다른 감기

```
        SOLENOID (탑형)             PANCAKE (디스크형)

        ┃ │ ┃                       ━━━━━━━━━━━━
        ┃ │ ┃        ↑z             ━━━━━━━━━━━━
        ┃ │ ┃                       ━━━━━━━━━━━━     ↑z
        ┃ │ ┃        ← r=0  →       ━━━━━━━━━━━━     ←r=0→
        ┃ │ ┃                       ━━━━━━━━━━━━
        ┃ │ ┃        ↓              ━━━━━━━━━━━━     ↓
        가운데에 강한 B축방향        팬케이크 평면 위에 강한 B
        (MRI · 가속기 보어)         (양자컴 큐비트 · NMR 평면)
```

## 검증 2단 — "두 자로 같은 길이 재기"

```
   GetDP FEM 시뮬                Wheeler 해석해

   axisymmetric (r,z)            B(z) = (μ₀NI/2L) × [(L/2+z)/√(R²+(L/2+z)²)
   2-D 격자 ~수만셀                       + (L/2-z)/√(R²+(L/2-z)²)]
   A-φ 벡터포텐셜 푼다            ↑ 종이연필로 풀 수 있는 닫힌식

   결과 = 축상 B(z) 곡선          ┐  같은 곡선이면 🟢 cross-tool consistency (g5)
   결과 = 축상 B(z) 곡선          ┘  ≠ → 어느 쪽 버그
```

## 왜 RTSC 가 이걸 만들었나?

1. RTSC = 상온상압 초전도체 후보(LaH₁₀ · h3cl · 등) 발견 캠페인이 메인
2. "발견하면 끝"이 아님 — 발견된 SC 로 자석 감아 실용기기(MRI / 가속기 / 핵융합) 만들기
3. "어떤 모양 코일이 최적?" 미리 계산해두는 substrate
   → solenoid vs pancake 둘 다 데크 마련, 다른 도메인(UFO · NUCLEAR · QUBIT) 에서 재사용 가능
4. Wheeler verifier = paper monograph appendix F 의 핵심 검증축 — 정직 평가의 토대

## 다른 도메인 재사용 (NEXUS.tape · g67)

```
RTSC magnet substrate ─┬─→ UFO     6-coil 60° array B-map
                       ├─→ NUCLEAR fusion confinement magnet
                       ├─→ QUBIT   z-axis quantization field
                       └─→ ANTIMATTER trap (current_loop_offaxis reuse, d19)
                                          = "한 번 만든 자석 식, 4 도메인이 빌려쓴다"
```

## 비교 (vs 기존 도구)

| 축 | 상용 (ANSYS Maxwell) | 오픈 (GetDP raw) | 본 도구 (RTSC-magnet) |
|---|---|---|---|
| 인터페이스 | GUI 클릭 | 직접 .pro 코드 | 도메인 데크 + Wheeler cross-check |
| 검증 | 단일 도구 결과 | 단일 도구 결과 | 2-도구 교차 (g5 cross-tool-consistency) |
| 재사용성 | 1 프로젝트 | 1 솔버 | 4 도메인 reuse (NEXUS.tape g67) |
| 라이선스 | 유료 (수천만원) | MIT | MIT + 캠페인 기록 |

## 요약

RTSC-magnet = "초전도체가 발견되면 어디 어떻게 감아쓸지의 청사진 라이브러리". 본체 DFT 발견 (RTSC.md ▓▓▓▓░░ 47%) 과 별개의 응용 트랙 — 미리 깔아둔 substrate 다.
