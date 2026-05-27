# stdlib/discover — 8번째 verb `discover`

> demiurge canonical home for the OUROBOROS autonomous-discovery loop.
> 콘셉트 SSOT 는 `phanes/README.md`, 작동 코드는 여기.

## CLI 진입점

```
demiurge cli discover <objective>
                      [--verifier <path>]    # verifier 모듈 (.hexa)
                      [--rounds N]           # 라운드 cap (기본 8)
                      [--json]               # JSON 출력 (default = human)
```

## 출력 schema (with `--json`)

```json
{
  "objective": "high-Tc ambient-pressure RTSC",
  "rounds_used": 5,
  "rounds_cap": 8,
  "saturation_reached": true,
  "catalog": [
    { "id": "atlas:R/rtsc_h3s_full_bz_elph", "score": 0.87, "verifier_pass": true, "provenance": "atlas.embedded.gen.hexa#L1234" }
  ]
}
```

## 알고리즘 (요약)

```
1. seed: objective + verifier
2. round 1..N:
     a. candidate generation (hexa atlas + LLM draft)
     b. per-candidate verifier gate (hexa verify · 5-tier)
     c. survivors → next round's seed pool
     d. saturation check (새 발견 0 → break)
3. emit provenance-tracked catalog
```

## 의존

- `hexa verify` — 5-tier 판정 (g5)
- `hexa atlas` — verified atom 조회 + register
- `domains/DOMAINS.tape` — verifier 경로 dispatch (d4)

## 흡수 history

원래 sibling repo `~/core/phanes` 의 외부 binary subprocess 였음 (`demiurge cli discover` →
`bin/phanes` exec). 2026-05-27 흡수:

- 외부 subprocess 폐기 → in-process .hexa 호출
- 사용자 install 1단계 줄음 (`hx install demiurge` 만)
- d3 (canonical stdlib home) · d4 (generic dispatch) 부합

## 상태

- [ ] `discover.hexa` skeleton land (이 PR)
- [ ] OUROBOROS round 루프 본문 구현 (다음 PR)
- [ ] `domains/DOMAINS.tape` `discover` row dispatch (다음 PR)
- [ ] `web/app/discover/DiscoverForm` → API 우회 직접 호출 (다음 PR)
