# phanes — INBOX (콘셉트 / 계약 보관)

> 외부 sibling `~/core/phanes` 가 owner 였던 시기의 브릿지 계약을 콘셉트 텍스트로 보관.
> 실제 구현은 `stdlib/discover/` 로 이전했으므로 여기는 **참조용 historical contract**.

## 2026-05-26 — demiurge-discover-bridge (historical · resolved)

원래 demiurge ↔ phanes 외부 subprocess 브릿지 계약. 2026-05-27 demiurge `stdlib/discover/` 흡수로 폐기.

### 계약 (원본 그대로 보관)

```
phanes discover <objective>
                [--verifier <path>]    # 검증기 hexa/py 모듈 경로
                [--rounds N]           # OUROBOROS 라운드 cap
                [--json]               # JSON 출력 (default = human)
```

### JSON 응답 schema

```json
{
  "objective": "...",
  "rounds_used": 5,
  "rounds_cap": 8,
  "saturation_reached": true,
  "catalog": [
    { "id": "...", "score": 0.87, "verifier_pass": true, "provenance": "..." }
  ]
}
```

### 현재 (post-흡수)

위 schema 는 `stdlib/discover/discover.hexa` 의 출력 표면으로 그대로 보존됨. 사용자 CLI :

```
demiurge cli discover <objective> [--verifier <path>] [--rounds N] [--json]
```

→ `demiurge cli` 가 `stdlib/discover/discover.hexa` 를 직접 호출 (외부 binary subprocess 폐기).

## 2026-05-26 — arxiv-a4-autonomous-discovery-ingest

hexa-lang ARXIV A4 (PHANES axis) 가 흡수한 자율발견 / OUROBOROS 논문 10편 (cs.AI · cs.LG · cs.MA · cs.NE).

- AI-Scientist 루프
- self-improving agent
- verifier-driven RL / RLVR
- open-endedness · quality-diversity / novelty search
- LLM-진화탐색
- AutoML-Zero

전체 verdict 와 한글 docs 는 sibling `~/core/phanes/INBOX.log.md` 또는
`hexa-lang:ARXIV/docs/a4-phanes-axis.md` 에 archive 로 남아 있음.

## 폐기된 옵션 (참고)

- (a) Node.js wrapper script `bin/phanes` 가 phanes-http localhost 인스턴스 spawn
- (b) phanes-http 에 stdin/stdout JSON mode (`--once` flag)

두 옵션 모두 외부 subprocess 모델이 전제 → demiurge 흡수 후 불필요.
