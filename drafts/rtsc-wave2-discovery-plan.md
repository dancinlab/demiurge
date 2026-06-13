---
slug: rtsc-wave2-discovery
mode: auto
auto-weights: "1:1:1:1 (완성도·단순·안전·표준)"
created: 2026-05-29
domain: RTSC
---

# RTSC Wave-2 — 발견-기반 6 substitution 발사

## task brief

발견 토대(YH10 🟢 227K@250GPa #1909 검증 + 파일럿 3 라인 Be/perovskite/BCS)로
6 substitution 후보를 deck build → ssh9 발사. YH10-family(검증 라인 확장) +
파일럿-라인(Be·perovskite 자매) 균형. absorbed=false 영구.

## locked decisions (5 · auto 1:1:1:1)

- Q1 대상: YH10-family + 파일럿-라인 확장 (발견 직접 토대)
- Q2 scope: subset 6 — YH10-family {A15 YAuH3 · B10 ScH9 · B08 LaY_H10} + 파일럿 {A02 KBeH8 · A08 SrPtH3 · A10 BaAuH3}
- Q3 surface: ssh9 $0 여유(현 32/128 core) + 초과분만 신규 vast(d17)
- Q4 deck: build phase — anchor 재사용 substitution (YH10/SrAuH3/AcBeH8 → 치환)
- Q5 wave: deck build agent ≤3(throttle) · 카테고리 2 agent(각 3 deck)

## anchor 재사용 매핑

| 후보 | anchor | 치환 | 비고 |
|---|---|---|---|
| A15 YAuH3 | SrAuH3 (Pm-3m perovskite) | A-site → Y | YH10-family (Y) |
| B10 ScH9 | YH9/CeH9 (clathrate) | Y/Ce → Sc | Sc-hydride (Y 자매원소) |
| B08 LaY_H10 | LaH10/YH10 (clathrate) | 이중금속 La+Y | YH10 직접 family |
| A02 KBeH8 | AcBeH8 (fcc Fm-3m) | Ac → K | Be-precompressor (파일럿 MgBeH8 자매) |
| A08 SrPtH3 | SrAuH3 (Pm-3m) | Au → Pt | perovskite (파일럿 CaAuH3 자매) |
| A10 BaAuH3 | SrAuH3 (Pm-3m) | Sr → Ba | perovskite |

## next-action checklist

- [ ] deck build agent A — YH10-family 3 deck (YAuH3·ScH9·LaY_H10) · anchor 재사용 · QE vc-relax/scf/ph + pseudo(d13) + preflight(#1885)
- [ ] deck build agent B — 파일럿-라인 3 deck (KBeH8·SrPtH3·BaAuH3) · 동일
- [ ] 6 deck INFRA-READY 확인 (Stage 1.5)
- [ ] fire — ssh9 $0 여유 + 초과분 신규 vast · system QE 적응(OMPI_ALLOW_RUN_AS_ROOT) · path 정규화
- [ ] manifest 등록 (pods.json jobs 6 추가) · watcher heartbeat 에 6잡 추가
- [ ] ship — deck PR + manifest PR

## completion criteria

- 6 deck INFRA-READY (4/4 prereq each)
- 6잡 ssh9(+신규) grinding · watcher 감시
- absorbed=false 영구 · falsifier 사전등록 (각 후보 imaginary mode = closed-negative)
- $0 우선 (ssh9 여유) · 초과분만 cost (d17 autonomous)
