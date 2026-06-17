# .verdicts — claim 검증 결과 영구 보존소 (typed-record mirror)

> `d_claim_verify` — `CLAIMS.tape` 의 각 claim 을 demiurge 의 **typed
> record** (attestation · verdict) 로 닫고, 그 record 의 **원문 발췌를
> 그대로** 여기 보존한다. LLM 자가판정·paraphrase 금지 (g3 honest stance).

## demiurge 의 verdict surface = 기존 typed record

demiurge 는 별도 oracle 을 새로 만들지 않는다. verdict 의 SSOT 는 이미
`exports/` 안의 typed record 다:

| record | 위치 | 닫는 필드 |
|--------|------|-----------|
| **attestation** (absorbed-gate) | `exports/material_attestation/<m>/*.json` | `measurement_gate` · `absorbed` |
| **verdict** (tier4 falsifier-dispatch) | `exports/material_verdict/<m>/*.json` | `aggregate_verdict` · `absorbed` |
| **closed-form atom** | `hexa verify --expr …` stdout | tier glyph |

`.verdicts/<slug>/<id>.txt` 는 그 record 의 **verbatim 발췌 미러** — paper
섹션이 링크하는 단일 포인터다. record 와 경쟁하는 두 번째 진실이 아니다.

## 레이아웃

```
.verdicts/
  <slug>/
    <claim-id>.txt      ← attestation/verdict record 의 원문 발췌 (verbatim)
    .gitkeep
  <slug>.tape           ← (선택) slug 전체 verdict 매트릭스 요약
```

## 규칙

- 파일명 = `CLAIMS.tape` 의 `raw =` 포인터와 1:1 일치.
- 내용 = typed record 의 **field 원문**. 재가공·요약·의역 금지 (g3).
- record 가 `measurement_gate = GATE_CLOSED_MEASURED` (또는
  `aggregate_verdict = ALL_PASS`) → terminal 가능.
- 🟠 INCONCLUSIVE / MISSING-INPUT / 🟡 citation-only / ⚪ 미검증은 게이트
  통과 불가 (`d_paper_gate`) — 보존은 하되 paper 섹션 링크로 쓰지 않는다.
- terminal (🔵 / 🟢 / 🔴 CLOSED-negative) 만 `PAPERS/<slug>/` 섹션에 링크.
- absorbed=true 주장 paper 는 `PAPERS/_tools/check_rtsc_claim.sh` 게이트도
  통과해야 한다 (RTSC absorbed=true literal 은 동반 record 의 5-gate
  ALL_PASS 필수).
