# X26 — CARDIO+ living-doc 자동화 spec (X8 grade SSOT → DOCTOR/X-요약 자동 derive 파이프라인)

> CARDIO+ 메타도메인 X26 cross-cutting 산출물 · current-state · **spec only (구현 코드 아님)**.
> 목적 = grade 가 바뀌면 (예: X13 hedge 권고로 thesis 가 "mis-delivered" → "mis-delivered 일 수 있고" hedge, 또는 v8 ICER 🟠→🟢) DOCTOR H1-H10 + X-요약 문서를 **X8 grade ledger 단일 진실 소스에서 자동 재생성**하는 SSOT 파이프라인을 명세한다 — 수동 동기화로 인한 drift 위험 제거.

> ⚠ 본 X26 = **명세 only** — 새 hexa verify / sim / pool / cloud / python / atlas / git 실행 0건. grade 수치는 전부 X8 ledger VERBATIM 인용 (LLM self-judge 0건, per @D g5). DOCTOR/ · CARDIO+.md 는 읽기만 (X26 외 수정 0건, per d1 completed-form spec).

---

## §1. 현 drift 문제 — 수동 동기화 실태 (honest 사례)

현재 grade 진실 소스는 **X8 grade ledger** 단 하나이지만, 그 수치·등급·thesis hedge 는 여러 derived 문서에 **사람이 손으로 복사**되어 있다. grade 가 바뀌면 N 곳을 따로 고쳐야 하고, 한 곳이라도 빠지면 drift (문서 간 grade 불일치) 가 발생한다.

### 1.1 실제 발생 중인 수동 전파 사례 (grep 으로 실측)

| 사례 | source (변경 발생 지점) | 수동 전파 대상 (현재 손으로 복사된 곳) | drift 위험 |
|---|---|---|---|
| **X13 hedge** ("mis-delivered" → "**일 수 있고**" hedge 권고, X13 red-team) | X13 §thesis 권고 | (1) `X7_doctor_feed.md` L10 thesis · (2) `DOCTOR/H1_executive.md` L10 thesis — **2곳 수동 복사** (H2 L8 은 prose 변형) | thesis 문구가 X7·H1 2곳에 verbatim 중복 → X13 권고가 한쪽만 반영되면 교수님 1-page 와 H1 이 어긋남 |
| **6-tier 합산 count** (🔵1·🟢43·🟡~215·🟠45·🔴5·⚪31) | X8 §2 마스터 ledger | (1) `X7` ◆grade snapshot · (2) `DOCTOR/H1` grade snapshot · (3) `DOCTOR/H8` bar+합산표 · (4) `DOCTOR/H10` Figure1+요약표 — **4곳 수동 복사** | 한 sub-domain V4 등급 1건만 바뀌어도 4 derived 문서를 전부 수동 갱신해야 함 |
| **🔴 5종 closed-negative 목록** | X8 §5 | `X7` 정직성 박스 · `DOCTOR/H1` · `DOCTOR/H8` 정직성 박스2 — 3곳 수동 | F1-F5 중 1건이 wall→closed-negative 재분류되면 3곳 drift |
| **🔵+🟢 강한 근거 = 44 (12.7%)** | X8 §6 escalation | `X7` · `H1` L37 · `H8` L20/L100 · `H10` L29/L114 — 4곳 수동 | 🟢 1건 escalation 시 분자(44)·% 둘 다 4곳 수동 재계산 |

### 1.2 이미 발생한 latent 불일치 (drift 의 실증)

> grep 실측으로 확인된 **현재 진행 중인 미세 drift** — 수동 동기화가 이미 실패하기 시작한 증거:

```
H8_limits.md  L14:  🟢 SUPPORTED-NUMERICAL  ...  43  ( 12.4% )   ← 🟢 단독 %
H8_limits.md  L20:  강한 근거 (🔵+🟢) = 44 ( 12.7% )            ← 🔵+🟢 %
H10_figures.md L14:  🟢 ...  43  ( 12.4% )                       ← H8 와 동일 복사
H10_figures.md L29:  ...  44  (🔵 1 + 🟢 43 · 12.7% )            ← 재계산 복사
X8 §3 본문:   "🟢 43→~44"   vs   H8 L102 / H10 L31:  "🟢 ~44"   ← post-PR 🟢 표기 차이
```
→ % 컬럼(12.4 vs 12.7) 과 post-PR 🟢 표기(43→~44 vs ~44)가 문서마다 사람이 따로 계산해 넣은 결과라 이미 표기가 흔들린다. 분모 ~347 도 "~347+" / "% of ~347" 로 문서별 표기가 미묘하게 다르다. 이것이 자동 derive 가 필요한 직접 근거다.

---

## §2. SSOT → derived 의존 그래프 (어느 게 source · 어느 게 derived)

> **단일 규칙**: grade 진실은 X8 ledger 한 곳에만 산다. X-ledger (X1/X4/X9/X13) 는 X8 의 **upstream feeder** (sub-domain V4 verdict 를 X8 로 모으는 입력), DOCTOR H* · X7 은 X8 의 **downstream derived** (X8 에서 자동 생성). derived 는 grade 를 **직접 보관하지 않고** X8 을 transclude (인용·삽입) 한다.

```
 ┌──────────────────────── upstream feeders (grade 원천) ────────────────────────┐
 │                                                                                │
 │   NOREFLOW V4   DAPTPGX V4   ISR V4   LPA V4     ← sub-domain `hexa verify`      │
 │   §9.1          §7+§1        §9.2     본문분포표     verdict (진짜 1차 source)       │
 │      │             │           │          │                                    │
 │      └──────┬──────┴─────┬─────┴────┬─────┘                                    │
 │             ▼            ▼          ▼                                          │
 │          X1 추정     X4 ⚪dedup   X9 §6.3 PR    X13 thesis-hedge 권고            │
 │       (V4확정 전)   (fence)      (🔵 traj)     (numerical→causal over-read)      │
 │             └────────────┴──────────┴───────────────┐                          │
 └────────────────────────────────────────────────────┼──────────────────────────┘
                                                        ▼
                            ╔═══════════════════════════════════════╗
                            ║   ★ X8_grade_ledger.md  =  SSOT ★      ║   ← 단 1개 진실 소스
                            ║   §2 6-tier 마스터표 · §3 🔵traj ·      ║      (grade 합산 + thesis hedge state)
                            ║   §5 🔴 5종 · §6 🔵+🟢 escalation ·     ║
                            ║   §8 1줄 요약 · thesis hedge state      ║
                            ╚═══════════════════════╤═══════════════╝
                                                    │  auto-derive (regen)
                  ┌────────────────┬────────────────┼────────────────┬────────────────┐
                  ▼                ▼                ▼                ▼                ▼
          X7_doctor_feed     DOCTOR/H1        DOCTOR/H8        DOCTOR/H10       DOCTOR/H7
          ◆grade snapshot    executive        honest limits    figures          timeline
          ◆4-track 표        grade snapshot   bar+합산표        Fig1 bar+        (grade 無 ·
          ◆정직성 박스        thesis hedge     🔴/⚪ box         Fig2 traj         X7 carry만)
          (derived)          (derived)        (derived)        합산표(derived)   (derived)
                  │                │                                │
                  └────────────────┴────── 추가 derived (grade 직접 인용) ─────────┘
                         DOCTOR/H2(🔴4·🟢10) · H3(🟢5·🟠9) · H4(🟡150+) · H5(🟢28·🔴1·🔵1)
                         = 4-track 표 행을 sub-domain별로 인용 (전부 X8 §2 row VERBATIM)

  ─────────────────────────────────────────────────────────────────────────────────
  source-of-truth 1개  :  X8_grade_ledger.md
  upstream feeder      :  sub-domain V4(4) + X1·X4·X9·X13   → X8 로만 흐름 (derived 직결 금지)
  downstream derived   :  X7 · H1 · H2 · H3 · H4 · H5 · H7 · H8 · H10  (= 9개)
  ─────────────────────────────────────────────────────────────────────────────────
```

**핵심 불변식 (invariant)**:
- ① grade 숫자/등급/thesis hedge state 는 **X8 에만** 1차 보관. derived 는 인용(transclude)만.
- ② upstream feeder → X8 → derived 의 **단방향**. derived 가 다른 derived 를 참조하거나 (예: H8 가 H1 의 숫자를 복사), upstream 을 건너뛰고 derived 가 sub-domain V4 를 직접 인용하면 위반.
- ③ X8 의 count 충돌·추정 표기 규약 (DAPTPGX 🟡 13~18 range, LPA 🟢 28, ISR 🟡 150+) 도 derived 에 **그대로** 전파 — derived 가 임의로 단일값으로 "정리"하면 위반.

---

## §3. 재생성 파이프 spec (derived 산출별 source · trigger · 일관성 검사)

> 각 derived 산출이 X8 의 **어느 섹션을 source 로** 삼아, **어떤 trigger 에** 재생성되고, 재생성 후 **무엇으로 일관성 검사**되는지 명세. 재생성 = X8 의 해당 블록을 derived 의 marker 구간에 삽입(transclude)하는 1방향 연산.

| derived 산출 (구간) | source (X8 섹션) | trigger | 일관성 검사 (regen 후 PASS 조건) |
|---|---|---|---|
| `X7` ◆grade snapshot | X8 §2 + §6 ASCII 블록 | X8 §2/§6 변경 commit | derived 6-tier count == X8 §2 합산행 (6값 전부 일치) |
| `X7` ◆4-track 표 grade 열 | X8 §2 sub-domain 행 (4행) | X8 §2 sub-domain 행 변경 | 각 track 대표 grade == 해당 V4 행 VERBATIM |
| `X7` thesis (◆Thesis) | X8 thesis-hedge state (X13 권고 반영본) | X13 hedge state 변경 | thesis 문자열 == X8 thesis-hedge state (byte-identical) |
| `H1` executive grade snapshot | X8 §2 + §6 | X8 §2/§6 변경 | == X7 ◆grade snapshot (둘 다 X8 derive → 상호 일치 보장) |
| `H1` thesis (L10) | X8 thesis-hedge state | X13 hedge state 변경 | thesis == X7 thesis (둘 다 X8 derive · byte-identical) |
| `H8` 6-tier bar + % | X8 §6 ASCII (count+%) | X8 §2/§6 변경 | 각 tier % == round(count / 분모 ×100); 분모·% 표기 == X8 §6 |
| `H8` 합산표 (L32) | X8 §2 합산행 | X8 §2 변경 | 6값 == X8 §2 합산행 |
| `H8` 🔴 5 정직성박스 | X8 §5 표 (F1-F5) | X8 §5 변경 | F1-F5 claim/근거/grade == X8 §5 VERBATIM |
| `H8` ⚪ 31 정직성박스 | X8 §2 ⚪열 + X4 dedup | X8 ⚪ 또는 X4 변경 | ⚪ raw count == X8; dedup note == X4 |
| `H10` Fig1 bar | X8 §6 ASCII | X8 §2/§6 변경 | == H8 6-tier bar (둘 다 X8 §6 derive) |
| `H10` Fig2 🔵+🟢 traj | X8 §3 + §6 escalation | X8 §3/§6 변경 | 현재 44 / target ~67~97 / 🔵 23~53 == X8 §6 |
| `H10` 합산표 (L114) | X8 §2 합산행 | X8 §2 변경 | == H8 합산표 (동일 source) |
| `H2` NOREFLOW grade (🔴4·🟢10) | X8 §2 NOREFLOW 행 | X8 §2 NOREFLOW 행 변경 | == X8 §2 NOREFLOW (🔵0·🟢10·🔴4...) |
| `H3` DAPTPGX grade (🟢5·🟠9) | X8 §2 DAPTPGX 행 | X8 §2 DAPTPGX 행 변경 | == X8 §2 DAPTPGX (🟡 13~18 range 표기 유지) |
| `H4` ISR grade (🟡150+·🟢0) | X8 §2 ISR 행 | X8 §2 ISR 행 변경 | == X8 §2 ISR (150+ 추정 표기 유지) |
| `H5` LPA grade (🟢28·🔴1·🔵1) | X8 §2 LPA 행 | X8 §2 LPA 행 변경 | == X8 §2 LPA (🟢 28 = V3b land 후) |
| `H7` timeline | (grade 無 — X7 carry) | X7 timeline 변경 | grade 토큰 0개여야 함 (timeline 은 grade-free) |

**trigger 공통 규칙**:
- **유일한 1차 trigger** = `X8_grade_ledger.md` 의 git commit (또는 파일 mtime 변경). X8 이 안 바뀌면 derived regen 안 함 (idempotent).
- **2차 trigger** = X13 thesis-hedge state 변경 (thesis 문구는 grade-count 와 별개 SSOT 항목 → X8 안에 hedge-state 블록을 둬서 X8 commit 하나로 일원화 권고).
- regen 은 **derived 구간 marker 사이만** 덮어쓰기 (예: `<!-- X8:6tier:begin -->` … `<!-- X8:6tier:end -->`) — derived 의 prose·H-매핑·g5 박스는 보존.

---

## §4. drift 감지 규칙 (derived grade ↔ X8 불일치 lint)

> 자동 regen 이 실패/누락된 derived 를 잡아내는 검사. **derived 에 직접 박힌 grade 가 X8 SSOT 와 다르면 lint FAIL** — CLI 와 CLI+COCKPIT M6 verify surface 양쪽에서 노출.

### 4.1 lint 규칙 (R1-R6)

| 규칙 | 검사 내용 | FAIL 시 verdict |
|---|---|---|
| **R1 count 일치** | 각 derived 의 6-tier count == X8 §2 합산행 6값 | 🔴 DRIFT — "{file} {tier} = {n}, X8 = {m}" |
| **R2 % 재계산** | derived % == round(count / 분모 × 100, 1) (자체 산술) | 🟠 STALE-% — §1.2 의 12.4 vs 12.7 류 |
| **R3 분모 통일** | 모든 derived 분모 표기 == X8 (~347+ 단일 토큰) | 🟠 분모 drift |
| **R4 🔴 list 일치** | derived 🔴 목록 == X8 §5 F1-F5 (claim+grade) | 🔴 DRIFT |
| **R5 thesis hedge** | X7.thesis == H1.thesis == X8.hedge-state (byte) | 🔴 HEDGE-DRIFT — X13 권고 미전파 |
| **R6 range/추정 보존** | DAPTPGX 🟡 "13~18" · ISR 🟡 "150+" · LPA 🟢 "28" 표기가 derived 에 그대로 (단일값 임의 정리 금지) | 🟠 over-precision (g5 위반) |

### 4.2 lint 동작 (CLI + COCKPIT M6 연계)

```
[CLI]  hexa verify --living-doc  (또는 cardio lint --ssot=X8)
        ├─ X8 §2/§3/§5/§6 + hedge-state 파싱 → canonical grade-state
        ├─ 9개 derived 의 marker 구간 grade 토큰 추출
        ├─ R1-R6 비교
        └─ stdout:  ✅ 9/9 in-sync   또는   🔴 H8 R2 STALE-% (12.4 vs 12.7) ...

[COCKPIT M6 verify surface]
        ┌─────────────────────────────────────────────────────────┐
        │ M6 · CARDIO+ living-doc drift                            │
        │ ─────────────────────────────────────────────────────── │
        │  SSOT  X8_grade_ledger.md      🔵1 🟢43 🟡~215 🟠45 🔴5 ⚪31 │
        │  derived 9개 sync:                                       │
        │    X7   ✅   H1  ✅   H8  🟠 R2(% 12.4≠12.7)              │
        │    H10  🟠 R2   H2 ✅  H3 ✅  H4 ✅  H5 ✅  H7 ✅(grade-free)│
        │  thesis hedge (R5):  X7≡H1≡X8  ✅                        │
        │  ──────────────────────────────────────────────────     │
        │  verdict:  🟠 2 STALE-%  →  `regen H8 H10`               │
        └─────────────────────────────────────────────────────────┘
```
- M6 surface 는 **read-only 감지** (자동 수정 안 함) — drift 를 표면화하고 `regen` 액션을 제안만. 실제 regen 은 §3 파이프(§5 구현 단계)가 수행.
- lint 는 `git commit` PreCommit hook 또는 COCKPIT 진입 시 1회 실행 권고 (X8 변경 후 derived 미갱신 commit 을 차단).
- **d1 정합**: lint FAIL (drift) 는 "partial/pending" 상태 → regen 으로 completed-form (9/9 in-sync) 까지 구동. drift 를 방치하지 않는다.

---

## §5. 구현 단계 제안 (hexa-native script · CLI+COCKPIT M-surface — spec only)

> ⚠ 아래는 **명세·단계 제안**이며 코드가 아니다 (d1 completed-form spec). 구현은 hexa-lang SSOT (d3: 구현은 stdlib canonical home, topical folder 는 docs/manifest 만) 에 두고 demiurge 는 pointer.

| 단계 | 산출 (spec) | 위치 | 비고 |
|---|---|---|---|
| **S1 marker 주입** | 9개 derived 의 grade 구간을 `<!-- X8:<block>:begin/end -->` marker 로 감싸기 (6tier · 4track-row · thesis · 🔴list · traj) | DOCTOR/H* · X7 (derived) | regen 이 prose 를 안 건드리도록 경계 확정 (수동 1회) |
| **S2 X8 파서** | X8 §2/§3/§5/§6 + hedge-state → canonical grade-state 구조 추출 | hexa-lang stdlib | 단일 generic 파서 (d4: instance=manifest only — H-file 목록은 manifest, 파일명 하드코딩 금지) |
| **S3 regen 엔진** | grade-state → 각 derived marker 구간 transclude (§3 표를 manifest 로 구동) | hexa-lang stdlib | derived 목록 = manifest(§3 표) · 새 H-file 추가 = manifest 1행 (d4) |
| **S4 lint** | R1-R6 비교 → verdict (§4) · `hexa verify --living-doc` surface | hexa-lang verify kernel | bio-verify-kernel 과 별개 doc-lint path |
| **S5 COCKPIT M6** | M6 verify surface 에 living-doc drift 카드 (§4.2 ASCII) 추가 | CLI+COCKPIT M-surface | read-only 감지 + `regen` 액션 제안 |
| **S6 hook** | PreCommit hook: X8 변경 staged 인데 derived 미동기화면 차단 → `regen` 안내 | demiurge project hook | d9 정합 (commit 단위 isolation) |

**manifest-only 원칙 (d4)**: regen·lint 의 derived 대상 목록과 각각의 source-블록·trigger 는 §3 표를 그대로 **manifest** 로 직렬화한다. derived 추가/삭제/이름변경은 manifest 1행 수정만 — generic regen/lint 엔진에 파일명 하드코딩·per-file 분기 없음.

**확장 hook**: 향후 X25/X27 등 신규 cross-cutting 요약이 grade 를 인용하면 §3 manifest 에 1행 추가로 자동 편입 (X-요약 일반화).

---

## §6. X26 산출 요약 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 drift 사례 | 🟢 | grep 실측 (X7·H1·H8·H10 grade 토큰 위치 + 12.4 vs 12.7 latent 불일치) |
| §2 의존 그래프 | 🟡 | X8 §1 "단일 grade 진실 소스" + CARDIO+.md handoff 그림 carry · 파일 의존 grep 검증 |
| §3 재생성 파이프 표 | 🟡 (spec) | X8 §2/§3/§5/§6 source 매핑 + derived marker 위치 실측 |
| §4 drift lint 규칙 | 🟡 (spec) | R1-R6 = §1.2 실측 drift 일반화 · COCKPIT M6 surface 연계 |
| §5 구현 단계 | ⚪ (proposal) | hexa-native script · M-surface 구현 제안 — 코드 아님 (d1 spec) |

**X26 종합 등급**: 🟡 SUPPORTED-BY-CITATION (spec, compositional) — grade 수치는 전부 X8 ledger VERBATIM 인용 (🔵1·🟢43·🟡~215·🟠45·🔴5·⚪31, 강한근거 44). **X26 새 grade 판정 0건** (per @D g5 · LLM self-judge 0). 파이프라인·lint·구현은 명세 단계 (⚪ proposal, d1 completed-form spec). DOCTOR/·CARDIO+.md 는 읽기만 (X26 외 수정 0건).

→ **핵심**: grade SSOT = X8 1개 → derived 9개 (X7·H1·H2·H3·H4·H5·H7·H8·H10) 단방향 auto-derive. 가장 drift 위험 높은 derived = **thesis hedge (X7≡H1 2곳 verbatim 중복, X13 권고가 한쪽만 반영되면 즉시 교수님 1-page drift)** + **🟢 % 컬럼 (이미 12.4 vs 12.7 latent 불일치 진행 중)**. 재생성 핵심 trigger = `X8_grade_ledger.md` git commit 단일 신호 → §3 manifest 구동 regen + §4 R1-R6 lint (COCKPIT M6).
