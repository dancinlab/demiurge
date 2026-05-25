# INDEX — demiurge 도메인 재사용 격자 (cross-domain reuse lattice)

> @D g67 (commons · universal) + @D d19 (project) 의 구현 surface.
> repo **내부** 도메인이 형제 도메인의 검증된 부품·발견을 재사용하는 그래프.
> 발견 substrate = hexa-lang atlas (verified atoms) · 부품 home = hexa-lang stdlib (@D d3).
> intra-project only — 다른 repo와 잇지 않음 (@D g67).

## 1. 재사용 그래프

```
NOVEL-TOOL ──current_loop_offaxis (M2.4)──┬──→ RTSC (Wheeler on-axis B · solenoid getdp)
                                          └──→ ANTIMATTER ⓺가둠 (Ioffe-Pritchard 트랩 depth 0.35K)
RTSC ──getdp 4.0 toolchain────────────────────→ ANTIMATTER ⓺가둠
```

## 2. 엣지 원장 (verified reuse edges)

| provides (출처) | primitive | reused by | 증거 |
|---|---|---|---|
| NOVEL-TOOL M2.4 | `current_loop_offaxis` (elliptic K/E on-axis B Green fn) | RTSC · ANTIMATTER ⓺ | PR #900 → #168 |
| RTSC | Wheeler on-axis B 검증기 · getdp 4.0 solenoid templates | ANTIMATTER ⓺ | RTSC 3b33c26 → ANTIMATTER #168 |

## 3. provides[] 레지스트리 (도메인별 제공 부품 · atlas fn)

| 도메인 | 제공 primitive |
|---|---|
| NOVEL-TOOL | `current_loop_offaxis` |
| RTSC | Wheeler B · getdp solenoid templates · supercon fns (McMillan · Allen-Dynes · WHH) |
| ANTIMATTER | `penning_*` · `pair_threshold_*` · `rel_kinetic/p` · `cyclotron_cool_*` · `recomb_3body_*` · `ioffe_*` · `h1s2s_rydberg` |
| CERN | 가속기 (plasma-wakefield cold-linear) |

## 4. 사용법 (atlas-first · @D g67 / d19)

1. 부품 만들기 전 — `hexa atlas lookup --prefix=<topic>` + grep 형제 `<DOMAIN>.md`
2. 재사용 시 record에 `reused[]`, 제공 시 `provides[]` 스탬프
3. 이 INDEX에 엣지 1줄 추가 (그래프 + 원장)

## 5. 후보 엣지 (개념적 · 아직 코드 reuse 없음)

| 후보 | 비고 |
|---|---|
| CERN 가속기 ↔ ANTIMATTER ⓶감속·⓵생성 | 상대론 운동학·감속 ladder 공유 가능 — 미검증 |
| NUCLEAR ↔ RTSC+NUCLEAR | 메타-도메인(`+`) 합성 |
