# CLI+COCKPIT — current state

@goal: demiurge 7-verb pipeline (spec→structure→design→analyze⟲→synthesize→verify→handoff)을 CLI 명령 + cockpit TUI 두 surface에서 dispatch · 관찰 · handoff 완주 — materials→chip→component 스케일 축 전부 native

## Milestones

- [ ] M1 spec — domain spec capture surface (CLI 명령 + cockpit 입력 패널)
- [ ] M2 structure — 구조 분해 뷰 (계층/의존 ASCII or table, 양 surface)
- [ ] M3 design — design.md SSOT (D-number reserve) cockpit 통합
- [ ] M4 analyze — analyze ⟲ loop runner (수렴 판정 포함)
- [ ] M5 synthesize — synth dispatcher (pool/cloud 라우팅, per @D d7)
- [ ] M6 verify — `hexa verify` 결과 cockpit verbatim (per @D g5)
- [ ] M7 handoff — handoff packet emitter (next-stage 입력 패킷)

---

## Cross-domain 검증 사례 — NOREFLOW (cycle 5 완료, leak 0)

NOREFLOW 도메인 12 base milestone + V1-V4 verify schema 작업으로 본 CLI+COCKPIT 7-verb pipeline 의 각 M? surface 가 실제 동작함을 cross-domain 입증. 본 표는 NOREFLOW 경험에서 induce된 generic learning (다른 도메인에 재사용 가능).

| 본 M? | NOREFLOW 검증 산출 | generic learning |
|---|---|---|
| M1 spec | `NOREFLOW.md` (@goal + 12 milestone + V1-V4 verify schema) | spec 캡처 surface = `<DOMAIN>.md` + `<DOMAIN>.log.md` 양식. table + ASCII first |
| M2 structure | M1-M12 / V1-V4 의존 graph (verify schema가 M10/M11/M12 native 구현) | 2-tier (base 12 + verify 4) hierarchy = scalable |
| M3 design | (demiurge design.md SSOT 별도 — NOREFLOW 적용 X) | per-domain milestone 자체가 design space scout |
| M4 analyze | `/cycle` skill × 5 iteration + `/gap` skill × 40 lens (F2/F4/F8 hot) | convergence = open `- [ ]` 소진 + gap report fixpoint |
| M5 synthesize | M12 simulation 4 tracks → pool ubu-1/2 ssh fallback (pool CLI `hexa_index_get` 회귀 우회) | pool routing = `pool on <host>` 권장 · 회귀 시 ssh direct fallback · cloud per d7 |
| M6 verify | V1 72 claims tier triage (🔵 11 · 🟢 13 · 🟡 majority · 🟠 deferred · 🔴 4 · ⚪ 15) | g5 5-tier 적용 + ⚪ fence 영역 분류 (LLM self-judge 회피) |
| M7 handoff | Tier-A 3약물 권고 + Trial-A NICORADENO-MVO protocol + 한국 first-in-class consortium | handoff packet = ranking + protocol design + 한국 capacity 매핑 |

### Cross-domain caveats (NOREFLOW에서 induce)

- **인덱스 leak risk** — 동시 세션 작업 시 `git commit -o <paths>` 격리 commit 필수 (M5 synthesize surface의 commit step 거버넌스)
- **🔵 도달 dependency** — bio/clinical 도메인은 hexa-lang atlas 확장 (PR #658 style) 선행 필요 (M6 verify surface block)
- **⚪ fence 정직성** — subjective/prognostic claim 산식 강제 금지 — 절차적 honest fence가 거버넌스 (M6 verify surface 부속)
- **pool CLI 회귀 fallback** — `hexa_index_get` 컴파일 회귀 발견 → ssh direct fallback patch 후속 필요 (M5 synthesize surface 의 robustness)

---

## CLI 실증 — M6 verify surface verbatim (NOREFLOW + demiurge CLI dual)

본 시연으로 M6 surface 의 두 dispatch path (hexa verify · demiurge cli action verify) 모두 작동 확인 (per @D g5 verbatim citation).

### `hexa verify --fence` — ⚪ SPECULATION-FENCED dispatch

```
$ hexa verify --fence "재관류 첫 5분 lethal window는 mPTP 자물쇠 깨기 비유"

verify --fence
  claim  = 재관류 첫 5분 lethal window는 mPTP 자물쇠 깨기 비유
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

→ NOREFLOW M10 ⚪ fence 15건 모두 이 path 로 verdict-attach 가능 (M10 → M6 surface 매핑).

### `demiurge cli action verify <domain>` — 7-verb dispatch

```
$ demiurge cli action verify bio
action: 검증 (검증) · domain=bio — dispatching…
[bio+verify] scanning /Users/ghost/core/demiurge/exports/bio/verify
scanned 1 anima bridge record(s); latest = anima_bio_20260521T083318Z.json
producer = anima-bio-hippocampus-memristor-bridge
            (anima-physics owns substrate; demiurge witnesses)
⏳ GATE_OPEN · absorbed=false — bio producer oracle parity TODO
   (per record scope_caveats); demiurge 가 측정한 게 아니라
   anima bridge 결과를 witness 했을 뿐 (g3).
📸 record → exports/bio/verify/2026-05-21T08-33-18Z/anima_bio_*.json
📸 new record ID(s): bio_compr12.0_hebb0.94_pac0.71_local_sim
```

→ d5 거버넌스 작동 확인 (absorbed=true ⇔ measured-oracle PASS) · M6 verify surface 의 GATE_OPEN/absorbed 2-상태 머신 정상.

### `demiurge cli list-domains` — M1 spec/scope surface

```
$ demiurge cli list-domains
Domains (20):
  $DOM:antimatter $DOM:aura $DOM:bio $DOM:bot $DOM:brain
  $DOM:cern $DOM:chem $DOM:chip $DOM:component $DOM:energy
  $DOM:firmware $DOM:fusion $DOM:grid $DOM:matter $DOM:mobility
  $DOM:rtsc $DOM:scope $DOM:space $DOM:sscb $DOM:ufo
```

→ NOREFLOW · DAPTPGX · ISR · LPA · TTR · HERPES 등 **clinical/cardio sub-domain은 demiurge 등록 부재** = `bio` 산하 sub-domain pointer 또는 `cardio` 신규 도메인 등록 candidates (M3 design surface upstream 후보).

### Upstream 후보 (demiurge cli 자체 기여)

| 후보 | 위치 | 효과 |
|---|---|---|
| `cardio` 도메인 신규 등록 | `domains/cardio.demi` + `domains/cardio.md` | NOREFLOW · ISR · DAPTPGX · LPA가 `$DOM:cardio` 산하 hierarchy로 정렬 |
| `demiurge cli list-noreflow-claims` (또는 generic `list-claims <domain>`) | DemiurgeCLI Sources | M6 verify surface 가 V1 schema 직접 enumerate |
| `demiurge cli action verify cardio --tier-report` | DemiurgeCLI Sources | 도메인 전체 g5 tier 분포 즉시 출력 (V1 collapse) |

---

## Cross-domain 검증 사례 — ISR (cycle 5 verify-phase wall hit)

ISR V1-V4 진행으로 본 M5/M6 surface 의 **walls + breakthrough paths** 입증. NOREFLOW 결과와 일관 (concurrent 작업).

| 본 M? | ISR 검증 산출 | generic learning |
|---|---|---|
| M5 synthesize | `hexa cloud copy-to ubu-1` + `hexa cloud run ubu-1 -- python3 ...` × 3 pipelines 성공 · scp + remote exit 0 | cloud-route 작동 ✓ · `pool list` 직접 호출은 compile error → 우회 `hexa cloud run` (per [[pool-cli-compile-errors]] inbox patch) |
| M6 verify | `hexa verify --expr <bio_fn>` 7건 모두 🟠 INSUFFICIENT — kernel 부재 wall + `hexa verify --fence` 정직 ⚪ 작동 ✓ | bio 도메인 (ISR · DAPTPGX · LPA · NOREFLOW · TTR · HERPES) 6 도메인 동일 wall — single PR ([[bio-verify-kernel-extension]]) 으로 ≥50-90 🔵 unlock 가능 |
| M6 verify | `hexa atlas stats` = 16066 nodes (F 1313 · L 531 · P 455 · ...) · ATLAS_HASH `6fae9277...` | atlas 읽기 read-only 안정 · 쓰기 = PR-only (`atlas register --from-verify --auto-pr` honest degrade if 🟠) |
| M7 handoff | inbox/patches/ pattern 사용 — cross-project handoff 표준 (`bio-verify-kernel-extension-2026-05-25.md` · `pool-cli-compile-errors-2026-05-25.md`) | wall 발견 시 demiurge 도메인 → hexa-lang inbox 의 P0/P1 priority + LOC 추정 + 검증 시나리오 표준 패턴 |

### Cross-domain wall analysis (ISR + NOREFLOW 공통)

```
bio/clinical 도메인 V2 🔵 push
  │
  ▼
hexa verify --expr <bio_fn> args
  │  (현재 → number-theoretic only)
  ▼
🟠 INSUFFICIENT  ←─── single PR으로 unlock
                     hexa-lang/tool/verify_cli.hexa::_recompute
                     + float-arg parser + bio kernel (~400-600 LOC)
                     → 6 도메인 × 5-15 identity ≈ 50-90 🔵 동시 escalation
```

- **wall = leverage point** — 단일 hexa-lang PR이 cross-domain 50-90 🔵 unlock
- **NOREFLOW PR #658 style** — atlas 확장 선례 적용 가능 (NOREFLOW 항목에서 induce)
- **honest degrade ✓** — `register --from-verify` 가 🟠 verdict 시 PR 거부 (불성실 register 방지)

---

## Cross-domain 검증 사례 — LPA (cycle 4 simulation + verify in-flight)

LPA V1-V4 진행으로 NOREFLOW + ISR 결과를 **3rd 도메인 reproduction** + 새 evidence 추가.

| 본 M? | LPA 검증 산출 | generic learning |
|---|---|---|
| M5 synthesize | V3a `ssh ubu-1` 0.58s (siRNA ODE 4분자) + V3c `ssh ubu-2` 0.054s (10K PSA Monte Carlo) — pool CLI 회귀 우회 | ssh direct = 안정 fallback 패턴 cross-domain 3건째 (ISR · NOREFLOW · LPA 일관) |
| M6 verify | `hexa verify --expr ivw/schoenfeld/binary_sample/nnt/arr_to_nnt` 5건 모두 🟠 INSUFFICIENT — ISR 7건 wall과 동일 | bio/clinical kernel wall **4도메인 confirmed** (LPA + ISR + DAPTPGX + HERPES) — PR #665 (V2 agent 등록) merge 시 일제 unlock |
| M6 verify | LPA V2 agent → hexa-lang **PR #665 OPEN** (`inbox/notes/2026-05-24-lpa-ivw-mr-formula.md` · 105 lines · biostat 5 fn 요청) | ISR `bio-verify-kernel-extension` inbox 패턴 적용 = cross-project handoff 표준 작동 |
| M6 verify | 4 witness shards staged `atlas.append.witness-1779574*.n6` (ivw · schoenfeld · binary_sample · nnt) | PR merge 후 즉시 흡수 가능한 staging 패턴 |
| M7 handoff | V4 final tier ledger pending — V2 완료 후 인라인 작성 예정 | (예정) |

### LPA cycle 4 CLI verbatim 캡처 (M6 surface)

```
$ hexa verify --expr sigma 6 12
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)

$ hexa verify --expr ivw 3 1
verify --expr ivw(3)=1
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'ivw'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)

$ hexa atlas stats
atlas: loaded 16066 nodes from atlas.n6
ATLAS_HASH  6fae9277c3a8624c4e4bf2a5dd1096890d7e92a252547fa510d36c7fc86f4167
P 455 · C 5763 · L 531 · E 12 · F 1313 · R 6319 · S 10 · X 1580 · Q 83 · total 16066
```

→ NOREFLOW + ISR 결과와 일관 (ATLAS_HASH 동일 = 동시 세션 atlas 변경 없음).

### Cross-domain wall confirmation (3rd reproduction)

```
bio/clinical 도메인 V2 🔵 push
  │
  ▼ (ISR 7건 wall + LPA 5건 wall + DAPTPGX/HERPES wall = 누적)
hexa verify --expr <bio_fn>  →  🟠 INSUFFICIENT × 17+ identities
  │
  ▼
hexa-lang PR #665 (V2 agent) → biostat kernel 5개 fn 등록
  │
  ▼ merge 후
17+ identity × 4 도메인 = 🟢→🔵 동시 escalation 가능
