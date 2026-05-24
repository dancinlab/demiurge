🛠️ NOVEL-TOOL — "새 도구 발굴" · NOVEL primitive 발견 + verify schema

# NOVEL-TOOL — current state

@goal: hexa stdlib 에 없고 scipy 단독으로도 trivial 하지 않은 NOVEL primitive 후보를 brainstorm/atlas 로 발굴 + epistemic schema 로 cross-validatable 하게 만들기 (M2/M3 가족 NOVEL-TOOL brainstorm output 전부 schema 강제)

## NOVEL-VERIFIER 스키마 (epistemic foundation)

### Pre-falsifier (NOVEL grade 박탈 조건)

다음 둘 중 하나라도 충족하면 NOVEL ✗:

1. **이미 hexa stdlib 에 있음** — `find ~/core/hexa-lang/stdlib -iname "*<slug>*"` 또는 `grep -r "<symbol>" stdlib/` 양성 결과.
2. **scipy 단독 1줄 trivial** — `from scipy.<sub> import <fn>; <fn>(x)` 한 줄로 끝나고, 정확도/안정성 함정이 명문화 가능한 수준이 아님.

### Brainstorm output triad (모든 후보에 강제)

```yaml
candidate: <slug>
claim:       <한 줄 NOVEL primitive 설명>
proof:       llm-prior | arxiv:<DOI> | textbook:<ref> | cross-source
severity:    low | medium | high     # 캠페인에 미치는 영향
as_of_date:  YYYY-MM-DD              # 판정 시점 (scipy 업데이트로 rot 추적)
scipy_grep:  found | not_found       # `pip show scipy && python -c "import scipy.<sub>" -> grep`
stdlib_grep: found | not_found       # `find ~/core/hexa-lang/stdlib -iname "<slug>*"`
arxiv_ref:   <DOI or null>
```

### 적용 시점

- M2/M3 brainstorm round 2 부터 모든 후보에 triad 부착 강제.
- 기존 round 1 결과 (M2 6개 + M3 6개 후보) 는 round 1 done 으로 인정하되, round 2 진입 전에 retroactive triad fill-in (별도 cycle).
