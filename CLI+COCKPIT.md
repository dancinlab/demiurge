# CLI+COCKPIT — current state

@goal: 외부 사용자가 app(Swift macOS) + CLI 2개만으로 demiurge 7-verb 기술설계 파이프라인(spec→structure→design→analyze⟲→synthesize→verify→handoff)을 완전히 운영 — 프로젝트·verify·결과·export까지 owner-infra 의존 0. 작동부(generic dispatch·7-verb·routing·handoff orchestration)는 demiurge 소유(real Swift, cockpit/Sources), stdlib 계산 커널(verify recompute·atlas·physics)만 hexa-lang SSOT를 hx 의존성으로 호출, 소유자 전용 운영(pool·inbox·atlas register·거버넌스)은 env-gated 사장실로 비노출

## Milestones

- [x] M1 spec — domain spec capture surface (CLI 명령 + cockpit 입력 패널)
- [x] M2 structure — 구조 분해 뷰 (계층/의존 ASCII or table, 양 surface)
- [x] M3 design — design.md SSOT (D-number reserve) cockpit 통합
- [x] M4 analyze — analyze ⟲ loop runner (수렴 판정 포함)
- [x] M5 synthesize — synth dispatcher (pool/cloud 라우팅, per @D d7)
- [x] M6 verify — `hexa verify` 결과 cockpit verbatim (per @D g5)
- [x] M7 handoff — handoff packet emitter (next-stage 입력 패킷)
- [ ] M8 verify host-health 라우팅 — M6 verify surface가 hexa-capable host 자동 감지·라우팅 (mini ✅ / ubu-1 hexa.real 누락 / ubu-2 segfault) + cockpit host-health 패널 (CARDIO+ X2 induce)
- [ ] M9 macOS-only 자원 pool-route 예외 — M5 synth dispatch가 load-escalate 시 macOS-only(secret·pdflatex·pool CLI·skill wrapper) 라우팅 제외 + `POOL_DISABLE`/`SIDECAR_NO_POOL_ROUTE` hard-honor (CARDIO+ skill --root/pool-route induce · sidecar INBOX 이관)
- [ ] M10 commit-isolation 강제 — M5/M7 commit step이 동시 worktree 하 `git commit -o <explicit>` 격리(d9) 강제 + staged-leak / `git add -A` 경고 (CARDIO+ 11 commit leak-0 패턴 induce)
- [ ] M11 agent fan-out cap guard — cockpit/cycle dispatch가 parallel agent 2-3 auto-cap + overflow defer (4+ rate-limit-kill 방지 · CARDIO+ fan-out induce)
- [ ] M12 upstream INBOX reflex 패널 — cockpit이 unfiled cross-repo finding 노출 + 1-click 핸드오프 (commons @D g60 enforcement surface · CARDIO+ induce)
- [x] M13 folder-nested domain resolution — domain picker가 `<NAME>/<NAME>.md` 중첩 SSOT 인지 (✅ domain 0.8.0/0.8.1 해소 · sidecar PR #120→#121 · CARDIO+ 빈-스캐폴드 재발 induce)

### 외부-제품 운영 완결성 milestone (M14-M21 · @goal 재정의 induce · spec = `CLI+COCKPIT/M0_operate.md`)

- [x] M14 operation manifest + operability surface — `OperationRegistry`(17-op · external/owner tier · op→target swift/hexa/substrate · @D d4) + `demiurge operate list/audit` CLI + `OperabilityAudit`(M21 gate skeleton) · 빌드 green · commit 0ec8dc4 · cockpit GUI mirror = P3 · per-target 실행 dispatch = M15-M17
- [ ] M15 external standalone 7-verb — 프로젝트 생성·진행·실행을 owner-infra 의존 0으로 완주 (no `~/.pool` · no 내 호스트 · no hexa-lang repo 경로 가정)
- [ ] M16 verify hx-dependency call — `hexa verify` 5-tier를 hx 의존성으로 호출, verdict plain verbatim 렌더 (@D g5) · M8 host-health 흡수
- [ ] M17 compute backend 추상화 — 로컬 기본 + 사용자 설정 remote (내 ubu/mini 하드코딩 제거) · d7 라우팅을 generic backend 개념으로 · M9 흡수
- [ ] M18 외부 배포 — notarized `.app` + standalone CLI + hexa hx 의존성 선언 (`swift run`/`hx install <my-path>` owner-only 탈피)
- [ ] M19 plain-mode 격리 — 기본 모드에서 내부 jargon/host/atlas/rfc/거버넌스(@D) 누출 0 (외부 안전 UX)
- [ ] M20 owner-mode 사장실 (env-gated) — pool 라우팅·inbox/patches handoff·atlas register-PR·거버넌스 enforcement를 flag/env gate (기존 M10·M11·M12 흡수)
- [ ] M21 operability audit — 외부 사용자가 owner-infra 0으로 7-verb 완주 증명 + owner-mode 동작 (acceptance gate · `demiurge operate audit`)

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

## Cross-domain 검증 사례 — CARDIO+ 메타도메인 (cycle-full + 심화, leak 0)

CARDIO+ 메타도메인(4 sub-domain + X1-X13 + DOCTOR H1-H10) 작업서 induce된 CLI/cockpit 개선 교훈. 각 교훈은 위 M8-M13 milestone 으로 등재 (구현은 후속 — 본 기록은 milestone-level).

| 교훈 | 증거 (CARDIO+ 세션) | 영향 surface | milestone | status |
|---|---|---|---|---|
| **verify host-health** | `hexa verify --expr` mini ✅ · ubu-1 `hexa.real` 누락 · ubu-2 segfault → 아무도 mini 미시도라 "blocked" 오판 | M6 verify | M8 | open · hexa-lang PR #760 (host matrix) |
| **macOS-only pool-route 예외** | load-escalate가 secret·pdflatex·skill wrapper를 ubu로 라우팅 → 도달 불가 · `POOL_DISABLE=1`로 우회 | M5 synth | M9 | open · sidecar INBOX 이관 (resolved-obsolete) |
| **commit-isolation (d9)** | 30+ 동시 worktree · `git commit -o <explicit>` 격리로 commit 14건 staged-leak 0 | M5/M7 commit | M10 | open · 패턴 입증됨 |
| **agent fan-out cap** | parallel agent 2-3 초과 시 rate-limit-kill (~3.5min) → cap 준수로 안정 fan-out | cockpit/cycle dispatch | M11 | open |
| **upstream INBOX reflex** | cross-repo gap을 chat-only로 남기던 패턴 → commons `@D g60` 신설(자율 same-turn 핸드오프) | cockpit | M12 | open · g60 commons 0.10.2 MERGED |
| **folder-nested domain** | `CARDIO+/CARDIO+.md` 중첩 SSOT인데 `/domain set`이 root 빈-스캐폴드 재생성 (세션 2회) | domain picker | M13 | ✅ domain 0.8.0/0.8.1 (PR #120→#121) |

### CARDIO+ induce caveats (generic learning)

- **honest tier 천장** — bio/clinical claim 의 verify 천장은 🟢 (libm recompute) · 🔵는 number-theory closed-form 전용 (atlas F-namespace 등록 선행) — M6 verify surface가 bio fn에 auto-🔵 부여 금지 (g5)
- **numerical → causal over-read 경계** — 🟢(산술 재현)을 인과 확정으로 over-read 금지 — 산술층은 견고해도 인과 라벨은 외부 RCT/실측 downstream (CARDIO+ X13 red-team 적발 패턴) — handoff(M7) packet은 numerical/causal 층 분리 명시
- **d6 no-forcing 실증** — model-mismatch 질적 fix는 정직 달성하되 양적 목표 미달이면 🟠 유지 (목표숫자에 안 맞춤) — 목표숫자 강제 금지가 M4 analyze 수렴판정의 정직성 기준 (CARDIO+ 심화서 실증)
- **메타도메인(`+`) 패턴** — CARDIO+ = 5 sub-domain self-contained 폴더 통합 + cross-cutting X-series — `+` 메타도메인은 cockpit이 sub-domain roll-up(진행도 합산) surface 필요

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

---

## Cross-domain 검증 사례 — DAPTPGX (cycle 5 verify-phase, V1-V4 완료)

DAPTPGX 14/14 milestone (M1-M11 + V1-V4) 완수로 NOREFLOW · ISR · LPA의 cross-domain wall pattern을 4번째 reproduce. 별도 spec 추출 docs를 induce → `CLI+COCKPIT/M5_synthesize.md` · `M6_verify.md` · `M7_handoff.md` (3 surface 정식 spec).

| 본 M? | DAPTPGX 검증 산출 | generic learning |
|---|---|---|
| M5 synthesize | `scp v3_recompute.hexa mini:/tmp/ && ssh mini 'hexa run ...'` 32줄 stdout — pool wrapper hexa-compile bug fallback | ssh direct fallback = cross-domain 4번째 (LPA+ISR+NOREFLOW+DAPTPGX) — d7 routing 결정트리에 fallback chain (ubu-1→ubu-2→mini→로컬) 필수 |
| M6 verify | `hexa verify --fence "..."` 4 claim → ⚪ + `hexa verify --expr phi 100 40` → 🔵 sanity + `hexa atlas stats` 16066 nodes | rubric · fence · expr · atlas-stats 4 dispatch path 모두 verified VERBATIM — M6_verify.md spec의 입력 데이터 |
| M6 verify | V2 promoter 0-proposal bug — `atlas append-witness` syntactic 성공/promoter reject → 4 shard staged `/tmp/daptpgx-staging/` | atlas register의 hidden gate = promoter health · M6 surface dispatch에 사전체크 step 필요 (M6 spec §8) |
| M7 handoff | `cp /Users/ghost/core/demiurge/inbox/patches/{stdlib-bio-stats,atlas-pgx-kind}.md ~/core/hexa-lang/inbox/patches/daptpgx-*-2026-05-25.md` ✅ | cross-project handoff = cp 1줄 + frontmatter convention · M7 spec의 살아있는 데이터 |
| M7 handoff | 6 inbox notes (M11 PGx 라이브러리 인벤토리) + 2 inbox patches (V2 stdlib + atlas extension) = 8 handoff packets | inbox notes (design) vs patches (code spec) 2-channel · cockpit M7 panel 책무 매핑 |
| V4 ledger | 30 claim final: 🔵 0 + 🟢 5 + 🟡 18 + 🟠 4 + ⚪ 3 + 🔴 0 (V2 흡수 후 🔵 4 + 🟢 12 escalation 예상) | NOREFLOW V1 72-claim + ISR 7-fn + LPA 5-fn과 합산 17+ identity × 4 도메인 → PR #665 merge 시 일제 escalation |

### DAPTPGX V2 4 shards (NOREFLOW + LPA staging 패턴과 동일)

```
/tmp/daptpgx-staging/
  atlas.append.witness-...-CYP2C19-kor-PM-freq.n6              (HW: (0.31+0.08)² = 0.1521)
  atlas.append.witness-...-CYP2C19-kor-IM_plus_PM-freq.n6      (0.4758 + 0.1521 = 0.6279)
  atlas.append.witness-...-CYP2C19-kor-diplotype-star2_star2.n6 (0.31² = 0.0961)
  atlas.append.witness-...-HardyWeinberg-identity-binomial.n6   ((p+q)² = p² + 2pq + q²)
```

PR #665 (LPA V2 agent 등록) merge + DAPTPGX 측 patch (`daptpgx-atlas-pgx-kind-2026-05-25.md`) 흡수 시 4 shard 즉시 🔵 promote.

### CLI+COCKPIT spec docs induce (DAPTPGX 사례 1차 정리)

본 cross-domain 누적 learning을 받아 별도 spec docs 작성:

| spec doc | 내용 | 살아있는 사례 출처 |
|---|---|---|
| `CLI+COCKPIT/M5_synthesize.md` | d7 routing 트리 + fallback chain + promoter health + cockpit panel | DAPTPGX V3 sim · V2 promoter bug |
| `CLI+COCKPIT/M6_verify.md` | rubric/expr/fence/atlas 4 dispatch + cockpit verbatim render rules | DAPTPGX V1 rubric + V2 fence + V3 sim |
| `CLI+COCKPIT/M7_handoff.md` | 3-channel (inbox/atlas/PR) + packet yaml + d9 commit discipline | DAPTPGX M11 6 notes + V2 2 patches |

→ NOREFLOW · ISR · LPA에서 induced된 generic learning을 spec 형태로 결정화. cockpit 구현은 별도 milestone (본 spec은 surface 정의만).
