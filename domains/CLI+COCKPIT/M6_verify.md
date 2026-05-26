# M6 verify — `hexa verify` CLI surface + cockpit verbatim spec

> @D g5 enforcement instance — `hexa verify` 출력을 cockpit이 VERBATIM 표시.
> 살아있는 사례: DAPTPGX 도메인 V1/V3 verify push (2026-05-24).

## 1. 7-verb pipeline 위치

```
spec → structure → design → analyze ⟲ → synthesize → [VERIFY] → handoff
                                                          ↑
                                                       M6 (본 문서)
```

verify는 합성 산출의 등급화 단계 — pipeline의 통일 gate. cockpit은 verdict를 자기검열 없이 그대로 표시 (g5 핵심).

## 2. CLI 명령 카탈로그

| 명령 | 용도 | 출력 등급 |
|---|---|---|
| `hexa verify rubric` | 6-tier rubric 출력 (canonical reference) | (메타) |
| `hexa verify --expr <fn> <n> <v>` | 1-operand closed-form (phi/sigma/mu/tau/...) | 🔵 SUPPORTED-FORMAL |
| `hexa verify --expr <fn> <a> <b> <v>` | 2-operand closed-form | 🔵 |
| `hexa verify <id>` | atlas atom lookup + recompute | 🔵 또는 🟠 INSUFFICIENT (atom 미등록) |
| `hexa verify <id> --absorb` | 검증 후 atlas/inbox/verified_equations.tape 흡수 | 🔵 + atlas grow |
| `hexa verify --fence "<claim>"` | 정직 fence — hexa-bio AXIS imagination | ⚪ SPECULATION-FENCED |

## 3. 살아있는 사례 ① — rubric VERBATIM 캡처

```
hexa verify — cross-project tier rubric (TECS-L-aligned, LATTICE_POLICY real-limits-first)

  🔵 SUPPORTED-FORMAL      hexa-native calc reproduces a CLOSED-FORM/symbolic
                           identity exactly — TECS-L n6-rep Tier 1 (pure-math,
                           deterministic) · g_self_verify · anima HEXAD g_verdict_tier_blue(a)
  🟢 SUPPORTED-NUMERICAL   hexa-native NUMERICAL recompute matches (libm/Newton,
                           non-symbolic) — TECS-L n6-rep Tier 2 (~10min suite)
  🟡 SUPPORTED-BY-CITATION atlas/literature registered, NO hexa recompute
                           (external sympy/citation carry — never auto-🔵)
  🟠 INSUFFICIENT          not in atlas + no calc path (g_tier_default default)
  🟠 DEFERRED              external hw/data/API dep — TECS-L Tier 3 (GPU) /
                           g_external_calc_forbidden (closure-external)
  🔴 FALSIFIED             calc DETERMINISTICALLY disagrees with the claim —
                           a CLOSED negative (TECS-L result-agnostic: PASS or
                           FAIL both verified-closed; ≠ INSUFFICIENT)
  ⚪ SPECULATION-FENCED    imagination/metaphor (hexa-bio AXIS) — verify N/A,
                           SF ≠ proven (g4 honest fence)
```

## 4. 살아있는 사례 ② — 🔵 SUPPORTED-FORMAL (number theory)

```
$ hexa verify --expr phi 100 40
verify --expr phi(100)=40
  calc   = 40  == expected 40
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

cockpit display rule: `tier =` 줄 단독 표시 + calc/expected 동등성 visual cue (예: ✓ aside).

## 5. 살아있는 사례 ③ — ⚪ SPECULATION-FENCED (hexa-bio AXIS)

```
$ hexa verify --fence "DAPTPGX CLI surface 검증 cockpit instance"
verify --fence
  claim  = DAPTPGX CLI surface 검증 cockpit instance
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

cockpit display rule: ⚪ tier에는 reason까지 모두 표시 (사용자가 "왜 verify N/A 인가" 즉시 파악).

## 6. atlas 현재 상태 (cockpit dashboard용)

```
$ hexa atlas stats
ATLAS_HASH         6fae9277c3a8624c4e4bf2a5dd1096890d7e92a252547fa510d36c7fc86f4167
ATLAS_SOURCE_COUNT 15
P primitives       455
C constants        5763
L laws             531
E experiments      12
F formulas         1313
R relations        6319
S symmetries       10
X crossings        1580
Q open questions   83
total nodes        16066
```

**중요 정정**: 이전 (DAPTPGX V1 + M12 audit) 에서 "atlas 비어있음"이라 기술한 부분은 **거짓** — 위 16066 nodes 확인. 다만 PGx kind (P primitive) 중 `CYP2C19` literal id는 미등록 (V2의 1차 register 대상).

## 7. cockpit ↔ CLI surface 매핑

```
cockpit panel               CLI 호출                          cockpit render
───────────────────────────  ──────────────────────────────   ─────────────────────
[Rubric reference]           hexa verify rubric                stdout VERBATIM
[Atlas hash badge]           hexa atlas hash                   first 16 chars only
[Atlas count grid]           hexa atlas stats                  table rows
[Single verify result]       hexa verify <id|--expr|--fence>   tier 줄 highlight
[Register witness]           hexa atlas append-witness         success/fail badge
```

## 8. 살아있는 사례 ④ — DAPTPGX V3 numerical recompute (🟢)

cockpit이 V3 sim 결과를 표시할 때:
- input: `/Users/ghost/core/demiurge/DAPTPGX/sims/v3_recompute.hexa`
- exec: `ssh mini 'hexa run /tmp/v3_recompute.hexa'`
- output: cockpit는 stdout (32 줄) 전체 표시 + claim별 tolerance check 결과 부여

발췌 (`1_HW_PM = 0.1521` 등 핵심 라인 highlight)는 별도 spec.

## 9. cockpit 책무 vs CLI 책무

| 책무 | CLI (hexa verify) | cockpit |
|---|---|---|
| recompute / 등급 결정 | ✅ (단일 진실 원천) | ❌ (절대 self-judge 금지 — g5) |
| stdout 표시 | (생성) | ✅ VERBATIM 표시 |
| tier 라벨 강조 | (포함) | ✅ 색상/아이콘 매핑 |
| 누적 ledger | ❌ | ✅ session/domain tier 분포 추적 |
| atlas 흡수 | ✅ (`--absorb`) | trigger button 만 |

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §3 rubric VERBATIM | 🟡 SUPPORTED-BY-CITATION | hexa CLI stdout (메타-참조) |
| §4 phi(100)=40 | 🔵 SUPPORTED-FORMAL | `hexa verify --expr phi 100 40` |
| §5 fence demonstration | ⚪ SPECULATION-FENCED | 본문 verbatim verdict |
| §6 atlas state | 🟢 SUPPORTED-NUMERICAL | atlas stats 직접 캡처 |
| §7 cockpit ↔ CLI 매핑 | 🟠 INSUFFICIENT (디자인 명세) | spec 단계, 구현 미완 |
| §8 DAPTPGX V3 사례 | 🟢 SUPPORTED-NUMERICAL | `/Users/ghost/core/demiurge/DAPTPGX/verify/V3_numerical_recompute.md` 본문 |

## 11. 핵심 통찰 5 bullets

- **g5 enforcement는 verify의 단방향 → cockpit의 표시 책무** — cockpit은 절대 자기 verify 하지 않음. CLI 출력 그대로 표시. 위반 시 LLM self-judge 위험 → 본 spec이 architectural firewall.
- **rubric은 일회 캡처, atlas는 매 turn 캡처** — cockpit 상단 rubric badge는 정적, atlas hash/stats는 매 dispatch마다 refresh (state drift detect).
- **DAPTPGX V1/V3가 살아있는 reference** — verify push의 실제 사례 30개 claim + 1개 🔵 sanity + 6 fence + 2 sign mismatch 추적. M6 spec 검증의 first-party 데이터.
- **🟢 사례 결핍 = 잠재 inbox handoff** — DAPTPGX V3 sim도 hexa CLI가 직접 등급 부여하지 않음 (.hexa run은 단순 실행). M6 spec에서 .hexa sim → 🟢 verdict 자동화 라우팅이 향후 개선 후보 (hexa-lang inbox).
- **atlas 16066 nodes는 cockpit dashboard 핵심 자원** — 도메인 작업 시 "이 atom이 이미 atlas에 있는가" 즉시 lookup이 verify push의 첫 단계. M6 spec은 lookup-first workflow를 cockpit 기본 동작으로 설정.

## 12. 후속 작업

- M7 handoff와 연결 — verify verdict가 handoff packet의 mandatory 필드
- M5 synthesize와 연결 — sim 라우팅 결과의 verify gate
- cockpit 구현 (별도 milestone) — 본 spec은 surface 정의만

## 13. verbatim 보장 메커니즘 (byte-passthrough + sha256 이중검증)

verdict 바이트는 **raw byte-passthrough pipe** 로 cockpit/CLI 표시 레이어에 도달한다. (a) `hexa verify` 자식 process stdout 을 LLM 컨텍스트에 절대 통과시키지 않는다 — 단일 경로 child stdout → ring buffer → renderer. (b) markdown 재래핑·trim·정규화 모두 비활성. (c) `hexa verify --json` 의 `evidence_hash` (sha256) 를 **buffer-in 시점과 paint 시점 두 곳** 에서 검증 — 1바이트라도 어긋나면 `⚠ verdict-tamper-detected` 배지로 강제 강등. (d) cockpit 의 verdict 영역은 **read-only widget** (사용자 편집·LLM 후가공 모두 차단).

```
 hexa verify (child proc)
        │  stdout bytes
        ▼
   [ ring buffer ]  ──► sha256 = H_in
        │  raw bytes (no LLM, no markdown)
        ▼
   [ renderer / TUI widget ]  ──► sha256 = H_out
        │
        ▼
  H_in == H_out  ?  ──► YES: display verbatim
                       NO : ⚠ verdict-tamper-detected → 🔴 forced
```

LLM 우회 경로는 architectural firewall — verdict 바이트는 모델 컨텍스트 윈도우를 한 번도 거치지 않는다 (g5 enforcement 의 물리적 보장).

## 14. 표시 규칙 보강 (byte-level)

§3 rubric / §4-5 사례 / §7 cockpit↔CLI 매핑 위에 추가 강제 — 모든 verdict 표시 surface (CLI · cockpit · clipboard) 공통:

| 규칙 | 강제 | 위반 시 |
|---|---|---|
| glyph emoji 는 raw unicode byte 그대로 | 🔵 🟢 🟡 🟠 🔴 ⚪ 보존 (재인코딩 금지) | sha256 mismatch → 🔴 |
| `hexa verify` stdout 바이트 무가공 mono-font | trim / wrap / 정규화 금지 | render-tamper 배지 |
| 다건 verdict 은 `\n` 구분 그대로 | 재정렬 · 재포맷 금지 | order-tamper 배지 |
| reason / evidence paragraph 는 원본 줄바꿈 보존 | markdown 재래핑 비활성 | (자동) 무가공 fallback |
| cockpit verdict 영역 = read-only widget | 사용자 편집 · LLM 후가공 차단 | input 무시 |

## 15. M7 handoff packet shape

verify verdict 는 M7 handoff 의 mandatory 입력. `hexa verify --json` 단일 blob 직렬화로 다음 8개 필드를 동봉:

```json
{
  "claim":            "<NL claim or atom id or --expr argv>",
  "glyph":            "🔵 | 🟢 | 🟡 | 🟠 | 🔴 | ⚪",
  "tier":             "SUPPORTED-FORMAL | SUPPORTED-NUMERICAL | SUPPORTED-BY-CITATION | INSUFFICIENT | DEFERRED | FALSIFIED | SPECULATION-FENCED",
  "reason":           "<one-line rationale from hexa stdout>",
  "evidence_hash":    "sha256:<64-hex>",
  "recomputed_value": "<numeric scalar | null (citation/fence/insufficient)>",
  "hexa_verify_argv": ["hexa", "verify", "...", "..."],
  "stdout_raw":       "<bit-exact hexa verify stdout bytes>"
}
```

| 필드 | 출처 | 검증 |
|---|---|---|
| `claim` | CLI argv 또는 cockpit input | echo back (no transform) |
| `glyph` / `tier` | hexa verify 1줄 verdict header | rubric 6-tier 화이트리스트 |
| `reason` | hexa verify stdout 의 `reason:` 라인 | byte slice |
| `evidence_hash` | hexa verify --json 필드 | §13 이중검증 (buffer-in / paint-time) |
| `recomputed_value` | `--expr` / atom recompute 결과 | tolerance check (M5 sim 동봉 시) |
| `hexa_verify_argv` | 호출 argv 보존 | reproducibility — M7 가 재실행 가능 |
| `stdout_raw` | child process stdout 전체 | sha256 == `evidence_hash` 동치성 |

M7 는 이 packet 을 그대로 handoff bundle 에 삽입 (재포맷 금지) — verbatim chain 이 verify → handoff → 외부 surface 까지 지속.
