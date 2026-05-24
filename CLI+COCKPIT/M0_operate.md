# M0 — 운영 manifest (operability SSOT)

> CLI+COCKPIT 도메인 P1(design) 산출물. `@goal` "외부 사용자가 app + CLI 2개만으로
> 완전 운영"을 **op 단위로 전수 분해**한 매핑표. M14-M21 구현은 이 표를 따른다.
> 본 문서는 surface 정의(spec)이며 구현 코드는 `cockpit/Sources/**` (작동부 demiurge 소유).
> M14 구현 = `cockpit/Sources/DemiurgeCore/Loaders/OperationRegistry.swift` (commit 0ec8dc4).

## 1. 소유 경계 (3-층)

```
┌──────────────── demiurge 소유 (real Swift · cockpit/Sources) ────────────────┐
│  작동부 = generic dispatcher · 7-verb workflow · project/domain 운영           │
│           routing 결정 · handoff orchestration · gate/provenance 상태머신       │
│                                                                               │
│   ┌─ 진열대 (external-product) ─────┐   🔒┌─ 사장실 (owner, env-gated) ──────┐ │
│   │ 프로젝트·7-verb·verify·결과     │     │ pool→내 호스트 · inbox handoff     │ │
│   │ export · 로컬/사용자 backend    │     │ atlas register-PR · @D enforce    │ │
│   └────────────────┬────────────────┘     └───────────────────────────────────┘ │
└────────────────────┼──────────────────────────────────────────────────────────┘
                     │ 계산 커널만 (leaf call · hx 의존성)
                     ▼
        hexa-lang stdlib = SSOT (가리킴, 복제 0): verify recompute · atlas · physics
```

| 층 | 소유 | 위치 | 외부 노출 |
|---|---|---|---|
| 작동부 (운영 로직) | **demiurge** | `cockpit/Sources/DemiurgeCore` | — (내부 엔진) |
| 진열대 (external-product) | demiurge | `DemiurgeCLI` + `CockpitApp` | ✅ 전체 |
| 사장실 (owner-internal) | demiurge | 같은 바이너리 · env/flag gate | 🔒 비노출 |
| stdlib 계산 커널 | **hexa-lang SSOT** | `hexa` (hx 의존성) | leaf call만 |

## 2. generic dispatcher (@D d4)

op는 하드코딩 분기가 아니라 **manifest 1개 + generic dispatcher 1개**로 흐른다. 기존
`ActionDispatch` + `ProducerRegistry` 패턴 확장. M14에서 `OperationRegistry`(매니페스트)
+ `demiurge operate list/audit`(읽기 surface) 착지 — per-target 실행은 M15-M17.

```
OperationRegistry (manifest · M14 ✅)
  op_id · tier(product|owner) · verb · target(swift|hexa|substrate) · reach · milestone
       │
       ▼
demiurge <op>  /  cockpit 패널  ──▶  OperationDispatch.run(op_id, args)  ← M15-M17
                                        ├ swift     → DemiurgeCore 함수 (작동부 소유)
                                        ├ hexa      → `hexa <...>` (stdlib 커널, hx-dep)
                                        └ substrate → pool/cloud/git (owner-gated)
```

추가/이름변경/제거 = **manifest 항목만** (instance-name 하드코딩 금지, @D d4).

## 3. operation 전수표 (17 op)

`tier`: 🛒 product(외부) · 🔒 owner(사장실) — `target`: swift(작동부 소유) · hexa(stdlib SSOT) · substrate(infra) — `now`: 현재 도달 surface — `M`: 담당 milestone.

| op id | tier | verb | target | now | 목표 surface | M |
|---|---|---|---|---|---|---|
| project | 🛒 | specify | swift | ✅ CLI+GUI | CLI+GUI | M15 |
| verb-nav | 🛒 | (all) | swift | 🔶 GUI (CLI 부분) | CLI+GUI | M15 |
| spec-capture | 🛒 | specify | swift | ✅ GUI | CLI+GUI | M15 |
| structure-view | 🛒 | structure | swift | ✅ GUI | CLI+GUI | M15 |
| design-pick | 🛒 | design | swift | ✅ GUI | CLI+GUI | M15 |
| analyze-loop | 🛒 | analyze | swift | 🔶 부분 | CLI+GUI | M15 |
| synthesize-run | 🛒 | synthesize | swift→hexa | 🔶 일부 도메인 | CLI+GUI | M15·M17 |
| **verify** | 🛒 | verify | **hexa** | ❌ (CLI verify=record 정합성만) | CLI+GUI | **M16** |
| record-view | 🛒 | verify | swift | ✅ CLI+GUI | CLI+GUI | M15 |
| export | 🛒 | handoff | swift | ✅ CLI | CLI+GUI | M15 |
| atlas-lookup | 🛒 | verify | hexa | ❌ | CLI+GUI | M16 |
| compute-backend | 🛒 | synthesize | substrate | ❌ (내 호스트 하드코딩) | CLI+GUI | **M17** |
| pool-route | 🔒 | synthesize | substrate | CLI(외부도구) | owner-mode | M20 |
| inbox-handoff | 🔒 | handoff | substrate | raw cp/git | owner-mode | M20 |
| atlas-register | 🔒 | verify | hexa+substrate | hexa CLI | owner-mode | M20 |
| governance | 🔒 | (all) | swift | 스킬/훅 | owner-mode | M20 |
| owner-domain | 🔒 | specify | swift | /domain 스킬 | owner-mode | M20 |

현재 audit (M14 `demiurge operate audit`): product **6✅ · 3🔶 · 3❌** (of 12) · owner 5🔒.

## 4. 배포 모델 (외부 사용자)

- **app**: notarized `.app` (현 `hx install <repo>` + `swift run` = owner-only → 탈피) — M18
- **CLI**: standalone 바이너리 (homebrew/installer) — M18
- **hexa stdlib**: **hx 의존성 설치** (번들 X · 재구현 X) — 설치 시 fetch, 버전 선언. verify/atlas 계산은 설치된 `hexa` 호출 — M16
- 외부 사용자 사전조건: `hx` + `hexa` 설치 (의존성) · 그 외 owner-infra(pool·내 호스트·dancinlab repo) **불필요**

## 5. plain / expert UX 격리 (M19)

기본(plain) 모드는 외부 안전 — 아래 내부 토큰 **누출 0**:

| 누출 금지 (plain) | 대체 표기 |
|---|---|
| `GATE_OPEN`/`absorbed`/`F1F2Record` | ⏳ 진행중 / 🔶 검토 / ✅ 완료 신호등 |
| `@D dN`/`@D gN` 거버넌스 | (숨김) |
| `rfc_0NN`/`Dxx` 내부 참조 | (숨김) |
| host명 `ubu-1`/`mini`/`pool` | "내 컴퓨터" / "원격 백엔드" |
| `hexa-lang`/`atlas`/`inbox` 경로 | (숨김 · owner-mode만) |

expert 모드 = 위 원문 노출 (현 cockpit 토글 재사용). 단 expert 모드도 **사장실 op는 env-gate** 없이는 비노출.

## 6. acceptance — operability audit (M21)

`demiurge operate audit` (CLI · M14 skeleton 동작) + cockpit 패널이 다음을 증명:

```
[product] 외부 사용자 경로 — owner-infra 의존 0
  ✅ project → 7-verb → verify(hexa hx-dep) → export  전부 2-surface reachable
  ✅ plain-mode 내부 토큰 누출 0 스캔 통과
  ✅ ~/.pool · 내 호스트 · dancinlab repo 미참조 (정적 스캔)
[owner]   사장실 op — env-gate 하에서만 노출 + 동작
  ✅ DEMIURGE_OWNER=1 일 때만 pool/inbox/atlas-register/거버넌스 op 등장
```

product 전부 ✅ ⇒ `productComplete=true` ⇒ `@goal` 달성 (M21 flip · audit exit 0).

## 7. milestone 매핑 요약

| milestone | 본 문서 근거 | 종류 | 상태 |
|---|---|---|---|
| M14 dispatcher/manifest | §2 | 작동부 (foundation) | ✅ commit 0ec8dc4 |
| M15 standalone 7-verb | §3 product rows | 진열대 | ⏳ |
| M16 verify hx-call | §3 verify/atlas-lookup · §4 | 진열대 (hexa 가리킴) | ⏳ |
| M17 compute backend | §3 backend row | 진열대 | ⏳ |
| M18 외부 배포 | §4 | 진열대 | ⏳ |
| M19 plain-mode 격리 | §5 | 진열대 | ⏳ |
| M20 owner-mode 사장실 | §3 owner rows | 사장실 (gate) | ⏳ |
| M21 operability audit | §6 | acceptance | ⏳ (skeleton ✅) |

## 8. 도메인 합성 실행 규칙 (선행도메인 = 구성도메인 · M15)

도메인 모델은 **2축** (D82): 가로 `clusters`(성격 결합) × 세로 `prerequisites`(구성).
한 도메인은 선행(구성) 도메인들로 이루어지고, transitive closure가 전체 구성 stack이다.

`DomainComposer.resolve(start)` (M15 · commit 818fbfe):
- `stack` = `DomainGraph.transitiveClosure` → `topologicalSort` (foundation→apex)
- `clusterUnion` = stack 전 cluster 합집합 · `substrateSSOTs` = 구성 stack의 hexa-* SSOT
- `kind` = atomic(구성 1) / composite(구성>1·non-system) / meta(scale=system apex)
- `crossesDiscipline` = start 자체 clusters가 life(bio·chem·life) ∩ tech(eng·phys·…) → "기술+바이오 결합"

| kind | 정의 | 예 (구성수) | 7-verb 합성 작동 |
|---|---|---|---|
| atomic | 선행 없음 | chip · matter · rtsc · space (1) | 단일 도메인 파이프라인 |
| composite | 구성>1 | bio(3) · brain(4) · aura(8) | 구성 stack을 topo 순서로 합성 실행 |
| meta | scale=system | ufo(10) · fusion(9) · grid | apex — 구성 도메인 전체 roll-up |
| 결합(flag) | life∩tech | aura · brain | cluster별 파이프라인 병합 |

규칙:
- project 생성 → `resolve(domain)` → 구성 stack + cluster union 확인(사용자 confirm)
- 7-verb 각 단계 = stack을 topo 순서로, 구성 도메인별 cluster-aware producer 실행 후 합성
- 메타·결합·단일 모두 **동일 generic 경로**(@D d4) — `kind`는 진행 표시/순서용, 분기 하드코딩 아님
- CLI `demiurge compose <domain>` 가 이 resolve 결과를 노출 (M15 ✅) · cockpit NewProject mirror = P3

> 다음 단계: M15 7-verb 합성 실행 — stack을 topo 순서로 cluster-aware 실행 (M16 verify hx-call +
> M17 backend dep). cockpit이 `OperationRegistry`·`DomainComposer`를 GUI로 mirror (D50). 각 = stacked PR (@D g4).
