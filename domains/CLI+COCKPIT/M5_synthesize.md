# M5 synthesize — synth dispatcher (pool/cloud routing)

> 7-verb pipeline의 5번째 verb. synthesize = analyze ⟲ 수렴 후 산출을 생산 (sim/build/render).
> per @D d7 (compute sizing: small → pool ubu-1/2 · batch → Vast CPU · ≥20 atoms/dense → GPU pod).

## 1. 7-verb pipeline 위치

```
spec → structure → design → analyze ⟲ → [SYNTHESIZE] → verify → handoff
                                              ↑
                                           M5 (본 문서)
```

synthesize의 입력 = design.md SSOT + analyze 수렴 결과. 출력 = sim asset 실행/build/렌더링 산출.

## 2. routing 결정 트리 (per @D d7)

```
                  synthesis input
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
  closed-form       numerical sim    heavy compute
  (closed-form      (1-10 min        (≥20 atoms ·
   identity)          per run)         dense k-grid)
        │               │               │
        ▼               ▼               ▼
   hexa atlas      pool ubu-1/2     Vast.ai GPU
   (atom register) (free linux)     (RunPod 금지: 8-vCPU)
        │               │               │
        ▼               ▼               ▼
       🔵              🟢             🟢 (sim) → 🟡 (cite)
```

## 3. CLI 명령 패턴

| 입력 sim 유형 | 대표 명령 | 호스트 |
|---|---|---|
| closed-form 검증 | `hexa verify --expr phi 100 40` | 로컬 (instant) |
| atlas atom register | `hexa atlas append-witness --kind P --id <id> --from-file <n6>` | 로컬 |
| 단일 .hexa run (light) | `hexa run <file>.hexa` | 로컬 또는 mini |
| .hexa run on pool (free) | `scp <file>.hexa ubu-1:/tmp/ && ssh ubu-1 'hexa run /tmp/<file>'` | ubu-1/ubu-2 |
| Vast.ai GPU dispatch | `hexa cloud run vast-<job> ...` | Vast GPU |
| RunPod GPU dispatch | `hexa cloud run runpod-<job> ...` | RunPod |

## 4. 살아있는 사례 ① — DAPTPGX V3 numerical recompute

**input**: `/Users/ghost/core/demiurge/DAPTPGX/sims/v3_recompute.hexa` (Hardy-Weinberg + ICER + Markov)

**의도된 route** (per d7 small): pool ubu-1
```bash
scp v3_recompute.hexa ubu-1:/tmp/
ssh ubu-1 'hexa run /tmp/v3_recompute.hexa'
```

**실제 route**: ubu-1 hexa binary 누락 (`hexa.real` 경로 깨짐) → mini host fallback
```bash
scp v3_recompute.hexa mini:/tmp/
ssh mini 'hexa run /tmp/v3_recompute.hexa'
# → stdout 32줄 (HW · phenotype · PM×HBR · ICER · Markov · budget)
```

**관찰된 issue**:
- `pool` wrapper 자체 hexa-compile bug (별도 inbox: `hexa-pool-wrapper-compile-bug.md`) → SIDECAR_NO_POOL_ROUTE도 무력
- ubu-1 binary 누락 → mini fallback 정상
- → M5 dispatcher 구현 시 **fallback chain spec** 필수 (ubu-1 → ubu-2 → mini → local)

## 5. 살아있는 사례 ② — DAPTPGX V2 atlas register

**input**: 4 staged shards `/tmp/daptpgx-staging/atlas.append.witness-*.n6`

**의도된 route** (closed-form identity → atlas P kind):
```bash
hexa atlas append-witness --kind P --id CYP2C19.kor.PM.freq --from-file <shard.n6>
hexa verify CYP2C19.kor.PM.freq    # round-trip 🔵
```

**실제 result**: promoter 0-proposal bug → atom unregistered, shards remain staged. → M5 dispatcher는 promoter health 모니터링 + 실패 시 inbox 자동 escalation 필요.

## 6. cockpit 패널 spec

```
┌─────────────────────────────────────────────────────┐
│ M5 synth panel                                       │
├─────────────────────────────────────────────────────┤
│ Input:    [/path/to/asset.hexa]                      │
│ Route:    auto (d7) ▼  [ubu-1 │ ubu-2 │ mini │ local]│
│ Status:   ● running on mini (0:12)                   │
│ Fallback: ubu-1 binary missing → mini (logged)       │
│ Output:   [stdout pane VERBATIM, 32 lines]           │
│ Tier:     🟢 SUPPORTED-NUMERICAL (V3 instance)        │
└─────────────────────────────────────────────────────┘
```

cockpit 책무:
- routing 결정 트리 시각화 + 사용자 override 허용 (host 선택)
- fallback chain 자동 + 실패 stage 로그
- stdout VERBATIM 표시 (g5 — self-judge 금지)
- M6 verify panel과 연동 (synth output → verify input)

## 7. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §4 V3 sim mini 실행 | 🟢 SUPPORTED-NUMERICAL | DAPTPGX/verify/V3_numerical_recompute.md 본문 stdout |
| §5 V2 promoter bug | 🟠 INSUFFICIENT (toolchain blocker) | DAPTPGX/verify/V2_formal_identities.md §3-4 verbatim |
| §6 cockpit panel spec | 🟠 INSUFFICIENT (디자인 명세) | spec 단계, 구현 미완 |

## 8. 핵심 통찰

- **d7 결정 트리는 cockpit 시각화 1순위** — sim 입력 크기 → host 자동 매핑. cockpit이 host 선택 시 d7 위반 시 경고 (예: GPU pod로 4 atom 작은 cell 보낼 때).
- **fallback chain spec 필수** — V3 instance에서 ubu-1 binary 누락 → mini 자동 fallback이 작업 살림. M5 구현은 다음 fallback order 강제: ubu-1 → ubu-2 → mini → 로컬 hexa.
- **promoter health = synth gate의 잠재 blocker** — V2 인스턴스에서 atom register failed. M5 dispatcher는 promoter 사전체크 + 실패 시 inbox 자동 escalation 필요.
- **stdout VERBATIM 보존이 synth → verify 핸드오프 키** — synth가 자체 등급 부여하면 g5 위반. cockpit은 sim stdout을 verify 패널로 그대로 forwarding만.
