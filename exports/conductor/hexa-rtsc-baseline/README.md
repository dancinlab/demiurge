# `exports/conductor/hexa-rtsc-baseline/` — hexa-rtsc verifier → conductor handoff

RTSC.md §8.6 deferred 항목 M465 (`hexa-rtsc 의 numerics_*_solver.hexa verifier 결과를 exports/conductor/hexa-rtsc-baseline/ 로 ingest 하는 thin adapter`) 의 첫 wired drop.

PR #90 (`exports/conductor/hts_rebco/.../conductor_rebco_hts_baseline.json`) 에서 정의된 `conductor-handoff/0.1.0` schema 를 그대로 매칭하여, hexa-rtsc verifier 의 identity (pillar · falsifier · sentinel · 호출 경로) 를 typed JSON record 로 떨군다.

## 핵심 설계

- **재실행 안 함**: 어댑터는 verifier 의 **identity 만** 인코딩한다 (어떤 falsifier 를 공격하는지, 어떤 pillar 인지, 어떤 sentinel 을 PASS 로 갖는지). 실제 수치 재실행은 caller 책임:
  ```sh
  hexa run stdlib/rtsc/verify/numerics_bcs_solver.hexa
  ```
- **gate_type=hexa-rtsc-derived · absorbed=false · provisional=true 영구**: PR #90 의 derived-path 계약 그대로. 시뮬레이션 lineage 는 측정이 아니다 (RTSC.md §8.5).
- **family=rtsc_hypothetical**: solver baseline 은 *universal closed-form lineage* 이지 per-material characterization 이 아니므로 `rtsc_hypothetical` slot 사용 (RTSC.md §5 Axis B / §8.6).

## 어댑터 사용법

어댑터 위치: `RTSC/conductor/hexa_rtsc_baseline_adapter.hexa` (demiurge-topical wrapper).
Canonical verifier 위치: `~/core/hexa-lang/stdlib/rtsc/verify/numerics_<pillar>_solver.hexa` (실제 numerical 작업물).

**CLI 형식** — JSON 을 stdout 으로 emit, caller 가 redirect:

```sh
# 디렉토리 준비
STAMP=$(date -u +%Y%m%dT%H%M%SZ)
OUT_DIR=exports/conductor/hexa-rtsc-baseline/bcs/$STAMP
mkdir -p "$OUT_DIR"

# 어댑터 실행 → JSON emit → redirect
hexa run RTSC/conductor/hexa_rtsc_baseline_adapter.hexa bcs "$OUT_DIR" \
    > "$OUT_DIR/conductor_bcs.json"
```

`<verifier_id>` 는 4개 중 하나 — `bcs · mcmillan · csh · hc2_48t`.

**왜 stdout redirect 인가** — hexa stdlib 의 file-write surface 는 `.hexa`-only 제약 (memory `reference_demiurge_sim_hexa_only.md`) 안에서 안정적 보장 미확보. 어댑터는 pure-stdout emit 으로 단순화; redirect 패턴은 UNIX 관용. `worked example 2개` 는 이 PR 에서 손으로 작성된 ground-truth — 어댑터 output 과 스키마 동일.

## 35-verifier 로드맵

| # | verifier_id | pillar | falsifier(s) | 산출 핵심 | 상태 |
|---|---|---|---|---|---|
| 1 | `bcs` | sc | F-SC-{1,2,3} | BCS gap Δ(0)/ℏω_D · 2Δ/kTc 비 | ✅ wired (this PR) |
| 2 | `mcmillan` | rtsc | F-RTSC-2 | BCS-λ McMillan ceiling, λ inversion from Tc | ✅ wired (this PR) |
| 3 | `csh` | rtsc | F-RTSC-1 | claim-only RT-SC reproduction (Clopper-Pearson UCL) | ⏳ mapped, JSON pending |
| 4 | `hc2_48t` | rtsc | F-RTSC-3 | Hc2 48T fusion gate (WHH Newton inversion) | ⏳ mapped, JSON pending |
| 5–35 | (TBD) | (TBD) | (TBD) | (TBD) | 🟡 pending — 동일 패턴 wire 가능 |

**Honest note** — 위 milestone (RTSC.md line 465) 은 35개를 언급하지만, 현재 `~/core/hexa-lang/stdlib/rtsc/verify/` 에 실제 존재하는 `numerics_*_solver.hexa` 는 4개 (bcs · mcmillan · csh · hc2_48t). 31개 추가 verifier 의 정체는 아직 hexa-rtsc 내부에 author 되지 않은 상태 (recipe §1 slot #6 들 — pillar 확장 시 단계적으로 등장). 이 PR 은:

- 4 worked → 2개 JSON emit (`bcs`, `mcmillan`) + 어댑터에 4개 모두 매핑 enum 등록
- 31 pending → 어댑터 패턴은 그대로 — 새 verifier 가 stdlib 에 author 되면 `verifier_pillar/falsifiers/kind/sentinel/doc` mapping fn 들에 한 분기만 추가하면 wire 됨.

## 산출 record 예시 2개

- `bcs/20260524T214725Z/conductor_bcs.json` — pillar=sc · falsifier=F-SC-{1,2,3} · kind=`bcs_gap_solver_baseline`
- `mcmillan/20260524T214725Z/conductor_mcmillan.json` — pillar=rtsc · falsifier=F-RTSC-2 · kind=`mcmillan_lambda_inversion_baseline`

두 파일 모두 PR #90 schema 와 1:1 매치 (vendor=null · source=`hexa-rtsc-derived` · gate_type=`hexa-rtsc-derived` · absorbed=false · provisional=true · scope_caveats 에 `hexa-rtsc verifier output ingested · sim-derived · not wet-lab` 포함).

## 한계 (honest)

- 어댑터는 verifier 를 **재실행하지 않는다** — `verifier_run_invocation` 으로만 캡쳐. caller 가 직접 invoke 해서 sentinel PASS 확인은 별 step.
- `family=rtsc_hypothetical` 은 universal-form lineage 표시. per-material binding (예: REBCO-specific Hc2 inversion) 은 PR #90 의 vendor-datasheet path 와 sibling record 형태로 ingest.
- `absorbed=false` 영구 — derived/sim → measurement record 로 supersede 되어야 device-side absorption 가능 (RTSC.md §8.7 Tier-3).

## 관련 링크

- 어댑터: `RTSC/conductor/hexa_rtsc_baseline_adapter.hexa`
- PR #90 sibling schema: `exports/conductor/hts_rebco/20260525T000000Z/conductor_rebco_hts_baseline.json`
- Canonical verifier source: `~/core/hexa-lang/stdlib/rtsc/verify/numerics_*_solver.hexa` (4 entries)
- RTSC milestone: RTSC.md line 465 (`§8.6 deferred — hexa-rtsc 의 numerics_*_solver.hexa 35개 verifier 결과를 exports/conductor/hexa-rtsc-baseline/ 로 ingest 하는 thin adapter`)
