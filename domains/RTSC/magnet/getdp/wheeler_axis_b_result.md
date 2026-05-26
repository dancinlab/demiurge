# 📐 WHEELER-AXIS-B — 솔레노이드 축 자기장 손계산 결과

> 출처: PR #106 (`feat(RTSC-magnet): Wheeler on-axis B closed-form verifier`)
> 검증 대상: §4.2.1 FEM cross-check — PR #92 `solenoid_axisym.{pro,geo}` geometry

- 하는 일: 유한 솔레노이드 축 위 `B_z` 를 닫힌형(공식 한 줄)으로 계산
- 비유: 무한루프 적분기(FEM) 대신 자 한 자루로 자기장 재기

## 기하 + 공식

```
유한 솔레노이드  N=120 turns · I=100A · L=20cm · R≈4.25cm

        ┌────────────────────┐
   ───>>│   ▲ B_z(z=0)       │<<───  N·I·μ₀ ·
        │   │                │       [(z+L/2)/√..
        │   │ ≈ 0.0694 T     │      -(z-L/2)/√..]
        │   ▼                │       / (2·L)
        └────────────────────┘
              z=0     z=L/2   →
            0.0694    0.0369  T
```

## 결과 표

```
┌───────┬─────────────┬────────────┬──────────────┬──────────────────┐
│ 위치  │  Wheeler    │    FEM     │     |Δ|      │       비고       │
│       │   손계산    │  (§4.2.1)  │              │                  │
├───────┼─────────────┼────────────┼──────────────┼──────────────────┤
│ z=0   │ 0.069391 T  │ 0.06842 T  │ 0.971 mT     │ 3% tier-target   │
│       │             │            │ (1.42 %)     │ 이내 ✓           │
├───────┼─────────────┼────────────┼──────────────┼──────────────────┤
│ z=L/4 │ 0.064996 T  │ —          │ —            │ 축 따라 감쇠     │
├───────┼─────────────┼────────────┼──────────────┼──────────────────┤
│ z=L/2 │ 0.036876 T  │ —          │ —            │ 끝단 ~ half      │
└───────┴─────────────┴────────────┴──────────────┴──────────────────┘
```

## Envelope sanity

`B(R_outc=5.5cm)=0.0661 < FEM 0.0684 < B(R_in=3.0cm)=0.0722 T` ✓ — FEM 이 thin-shell envelope 안에 갇힘.

## 참조 파일

- 구현: `RTSC/magnet/getdp/wheeler_axis_b.hexa` (281줄, `self/runtime/math_pure` 위)
- 솔레노이드 geometry: `RTSC/magnet/getdp/solenoid_axisym.{pro,geo}` (PR #92)
- README 한국어 append: `RTSC/magnet/getdp/README.md` (호출법 · scope · @D d3 배치 근거)

## 후속 (d3 stdlib promotion 추후 작업)

현재 `wheeler_axis_b.hexa` 는 demiurge topical folder 에 있음 — Wheeler 식 자체는 magnetostatics 일반 primitive 이므로 @D d3 + g61 룰에 따라 `hexa-lang/stdlib/material/magnet/` 로 promote 필요 (별도 PR). demiurge 측은 `use` + §4.2.1 cross-check 만 남기는 thin wrapper 로 refactor 예정.
