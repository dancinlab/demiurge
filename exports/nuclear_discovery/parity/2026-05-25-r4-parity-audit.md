# Shared R4 invariant parity audit — NUCLEAR ↔ RTSC

> RTSC+NUCLEAR.md milestone #2 — "Shared R4 invariant parity audit — NUCLEAR §3.1 ↔ RTSC §9.10
> (gate_type + absorbed=false 영구 wording + hardcoded-producer check, no runtime flip)".
> 작성 2026-05-25 · read-only audit (git commit 안 함 · demiurge 작업트리 공유).

목표: 두 자매 발견 도메인(NUCLEAR=원소 · RTSC=조성)이 **동일한 R4 불변식**을 일관된 문구로 carry 하고,
producer 단에서 **하드코드된 literal `false`** (런타임 flip 아님)임을 검증.

---

## (a) 문구 parity 표 (demiurge 문서)

검증 출처:
- NUCLEAR.md §1·§3.0·§3.1·§7 (`/Users/mini/dancinlab/demiurge/NUCLEAR.md`)
- RTSC.md §8.8·§8.9·§8.10·§9.10 (`/Users/mini/dancinlab/demiurge/RTSC.md`)

| 불변식 축 | NUCLEAR 문구 | RTSC 문구 | 판정 |
|---|---|---|---|
| **absorbed 영구성** | "`absorbed=false 영구` — no nuclear record EVER flips to `absorbed=true`" (§3.1) · "absorbed=false 영구" (§3.0/§7) | "`absorbed=false 영구` (R4 invariant 하드코드)" (§9.10) · "never absorbed=true" (§8.8) · "하나라도 SKIP/FAIL 이면 `absorbed=false` 로 강제 lock" (§8.9) | ✅ MATCH (동일 phrase "absorbed=false 영구") |
| **gate_type (발견-sim 값)** | `gate_type=nuclear-novel-discovery-simulation` (§1·§3.1·§7) — "new shape value (mirror of RTSC §9.10 N5 `novel-discovery-simulation`)" | `gate_type` 신규 값 `novel-discovery-simulation` (§9.10) | ⚠ DRIFT (의도적) — NUCLEAR 는 `nuclear-` prefix 접두. §3.1 가 명시적으로 "mirror of RTSC §9.10 N5 `novel-discovery-simulation`" 라고 선언 → namespace 분리용 **의도된** 차이. accidental 아님. |
| **sim PASS 의미** | "Sim PASS = '이 nuclide is worth wet-lab priority', NOT '이 nuclide exists'" (§1) · "ranked top-K nuclide candidate list for accelerator priority, not a discovery claim" (§3.2) | "산출의 의미 = wet-lab 우선순위 candidate list (top-K), NOT actual SC discovery" (§9.10) | ✅ MATCH (동일 형식: top-K 우선순위 list ≠ discovery) |
| **honest-correction "가능성 ≠ 임"** | "'Z=119 후보일 가능성' never 'Z=119 후보임' or 'Z=119 발견됨'. RTSC §8.10 LK-99/Nb attestation honest-correction pattern" (§3.1) · §7 headline block 동일 | "'이 후보가 RTSC 일 가능성 있음' ≠ '이 후보가 RTSC 임' — R4 Pattern 1 회피 영구" (§9.10) · Nb 정정 template (§8.10) | ✅ MATCH (동일 "가능성 ≠ 임" template · NUCLEAR 이 RTSC §8.10 를 명시적 출처로 인용) |
| **@D d6 measured-oracle 불변식** | "`absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true`. nuclear records 는 *permanent absorbed=false* (measured-oracle path 없음). record-type-agnostic by construction (4 record types audited · 0 helper code change)" (§3.0) | (간접) §8.9 (e) "측정-오라클 parity … Tier 4 verdict 의 `oracle_parity` block" · §8.10 future-proofing "`rtsc_5_gate_evaluation` block 이 5/5 PASS 출력" | ✅ MATCH (동일 measured-oracle gate semantics · NUCLEAR §3.0 가 invariant 의 formal 형태를 carry · RTSC 는 5-gate 의 (e) parity 로 표현 — 같은 측정-오라클 축) |
| **wet-lab 영구 의존 (promotion 요건)** | §7: absorbed=true 요건 5종 (가속기 빔타임 · recoil separator · decay-chain · 2nd-lab 재현 · IUPAC) — "None achievable from simulation … hardcoded in each producer, NOT a runtime decision" | §8.9 5-criteria gate (a 합성재현 · b Tc≥270K · c ambient · d ≥3 lab · e parity) "AND 가 absorbed=true 의 유일한 정문" | ✅ MATCH (둘 다 측정-측 gate 의 AND 가 유일한 promotion path · sim 단독 불가) |
| **install-gated = honest skip = PASS** | §3.3 "`install-gated` is the PASS verdict (mirror RTSC §9.9.1 Phase 1 wrap-as-is)" | §9.9.1 Phase 1 wrap-as-is (NUCLEAR 이 출처로 인용) | ✅ MATCH |
| **Pattern 2 (벽 ≠ 불가능)** | §3.0 @D d2 "never say 'Z=126 발견 불가능' … breakthrough paths 유지. Out-of-scope ≠ impossible" | §8.9/§9.10 "frontier: ambient-pressure superhydride … gate OPEN, 영구 폐기 아님" | ✅ MATCH (둘 다 flat-불가능 금지 · breakthrough path 유지) |

**parity 표 요약**: 8개 축 중 7개 ✅ MATCH · 1개 ⚠ DRIFT (gate_type prefix — **의도적**, §3.1 이 mirror 관계를 명시 선언).

### gate_type DRIFT 판정 (의도 vs 사고)

- NUCLEAR: `nuclear-novel-discovery-simulation`
- RTSC:    `novel-discovery-simulation`

→ **의도적 DRIFT (정상)**. NUCLEAR.md §3.1 이 직접 "new shape value (mirror of RTSC §9.10 N5 `novel-discovery-simulation`)"
라고 쓴다. `nuclear-` 접두는 record namespace 분리(R4 Pattern 1 namespace-collision 회피 — RTSC §8.10 Nb 사건의 교훈)
목적. 두 도메인이 같은 record store 에 섞일 때 elemental vs compositional 을 구분. accidental typo 아님 → **수정 불필요**.

---

## (b) Producer 하드코드 체크 결과 (hexa-lang code)

저장소: `/Users/mini/dancinlab/hexa-lang` (branch HEAD `9b0a01a1`).

> ⚠ 위치 주의: NUCLEAR.md §6.3 Phase 5 가 인용한 `stdlib/nuclear/{n8_fusion_evap,n9_shell_model,n10_abinitio}_adapter.py`
> (PR #907/#913/#917)는 main 체크아웃의 `stdlib/nuclear/` 에 **없음** — 현재 worktree
> `.claude/worktrees/agent-a214738e6922278bf/stdlib/nuclear/` 에만 존재 (PR merge 후 main 동기화는 별도).
> 본 감사는 worktree 사본을 Phase 5 canonical producer 로 간주해 검증했다 (3개 모두 동일 패턴 통과).

### 핵심 판정: `absorbed` 는 모든 producer 에서 literal `False`/`false` (런타임 flip 없음)

| producer (file) | absorbed 라인 | literal? | 증거 |
|---|---|---|---|
| `stdlib/nuclear/hfbtho_adapter.py` (N6) | **:331** | ✅ literal `False` | `"absorbed": False,  # R4 invariant — ALWAYS false (NUCLEAR §7)` — dict literal, 조건/표현식 아님 |
| `stdlib/nuclear/wkb_alpha_decay.py` (N7) | **:213** | ✅ literal `False` | `"absorbed": False,  # R4 invariant — ALWAYS false (NUCLEAR §7)` |
| `stdlib/nuclear/sim.hexa` (N7/N11 hexa-native) | **:278**, **:320** | ✅ literal `false` | JSON emit 문자열에 `"absorbed": false` 하드코드 (line 264 주석 "absorbed=false hardcoded per R4 (§3.1)") |
| `…/worktrees/…/stdlib/nuclear/n8_fusion_evap_adapter.py` (N8) | **:357** | ✅ literal `False` | `"absorbed": False,  # R4 invariant — ALWAYS false (NUCLEAR §7)` |
| `…/worktrees/…/stdlib/nuclear/n9_shell_model_adapter.py` (N9) | **:363** | ✅ literal `False` | `"absorbed": False,  # R4 invariant — ALWAYS false (NUCLEAR §7)` |
| `…/worktrees/…/stdlib/nuclear/n10_abinitio_adapter.py` (N10) | **:365** | ✅ literal `False` | `"absorbed": False,  # R4 invariant — ALWAYS false (NUCLEAR §7)` |
| `stdlib/material/novel_material_funnel.py` (RTSC N5) | **:630** | ✅ literal `False` | `"absorbed": False,        # R4 invariant — ALWAYS false` |
| `stdlib/material/askcos_adapter.py` (RTSC N3) | **:438** | ✅ literal `False` | `"absorbed": False,            # R4 invariant — ALWAYS false` |
| `stdlib/material/beenet_adapter.py` (RTSC N2) | **:427** | ✅ literal `False` | `"absorbed": False,          # R4 invariant — never absorb prediction` |
| `stdlib/material/cod_query.py` (RTSC) | **:318** | ✅ literal `False` | `"absorbed": False,            # structure ≠ Tc measurement (R4)` |
| `stdlib/material/aflow_query.py` (RTSC) | **:272** | ✅ literal `False` | `"absorbed": False,            # DFT != measurement; never absorb (R4)` |
| `stdlib/material/beenet_notebook_inference_producer.py` (RTSC) | **:185, :218, :287** | ✅ literal `False` | 모든 record emit 경로에서 `"absorbed": False` |

### 음성 통제 (negative control)

- **조건부/True 할당 검색**: nuclear+material producer 전체에서 `absorbed = <expr with if/and/or/==/>=>` 또는 `"absorbed": True` 형태의 **실제 할당은 0건**.
- grep 으로 잡힌 "absorbed=true" 매칭은 **전부 주석/scope_caveat 문자열 prose** ("promotion to absorbed=true *would require* …", "never absorbed=true", "the ONLY path to absorbed=true …") — 즉 promotion 이 *무엇을 요구하는지* 설명하는 문장이지 코드 할당이 아님.
- `gate_type` 만 분기됨 (honest-skip 시 `"install-gated"` / sim PASS 시 `"nuclear-novel-discovery-simulation"` 또는 `"novel-discovery-simulation"`) — 이는 **record 내용 분류자**이며 `absorbed` 와 무관. `absorbed` 는 분기와 상관없이 항상 `False`.

→ **producer 하드코드 체크 PASS**: 12/12 producer 에서 `absorbed` 가 literal `false`. 런타임 표현식·조건부 flip 0건.

### @D d6 measured-oracle 불변식 형태 + helper 위치

- 불변식: **`absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true`** (NUCLEAR.md §3.0).
- helper: `cockpit/Sources/DemiurgeCore/Models/MeasuredOracleRef.swift:104`
  ```swift
  public var isMeasuredOraclePASS: Bool { return meanRelErr <= threshold }
  ```
  - **computed (저장 아님)** — D86 `g_no_hardcoded_data` 따라 중복 boolean drift 방지.
  - **record-type-agnostic** — `MeasuredOracleRef` 는 EnergyVerifyRecord · UfoVerifyRecord · AuraVerifyRecord · EnergyWindVerifyRecord 4 carrier 가 공유 (NUCLEAR.md §3.0 의 "4 record types audited · 0 invariant-helper code change"와 일치). `NuclearVerifyRecord` 가 추가되면 자동 확장.
- **sim-only nuclear/RTSC record 경로**: `measuredOracle` 가 **nil** (가속기 빔타임/wet-lab 측정 record 가 없으므로 측정-오라클 path 자체가 존재하지 않음). `isMeasuredOraclePASS` 트리거가 없음 → `absorbed` flip 불가 → **영구 `absorbed=false`**. (`MeasuredOracleRef.swift:100-103` 의 D103 caveat: predicate 가 true 여도 producer 가 명시적으로 flip 해야 하며, 자동 flip 안 함 — sim-only 는 애초에 predicate 자체가 부재.)

---

## (c) 평결 + ready-to-paste fixes

### 평결: **parity PASS** ✅

- 문구 parity: 8축 중 7 MATCH · 1 의도적 DRIFT (gate_type `nuclear-` prefix — §3.1 이 mirror 관계를 명시 선언, namespace 분리 목적, accidental 아님).
- producer 하드코드: 12/12 producer 에서 `absorbed` literal `false` · 조건부/True 할당 0건 · 런타임 flip 0건.
- @D d6 measured-oracle 불변식: record-type-agnostic helper (`MeasuredOracleRef.swift:104`) · sim-only 경로는 measured-oracle path 부재 → 영구 `absorbed=false`. NUCLEAR §3.0 ↔ RTSC §8.9(e) 일치.

→ **두 자매 도메인은 동일한 R4 불변식 family 를 일관되게 carry 하며, 모든 producer 에서 하드코드되어 있다. 수정 불필요.**

### ready-to-paste fixes

없음 — discrepancy 없음. (gate_type DRIFT 는 의도된 설계이며 두 문서가 mirror 관계를 명시하므로 수정 대상 아님.)

#### (선택) 비-차단 관찰 — main 동기화 메모

기능적 결함은 아니나, NUCLEAR.md §6.3 가 `stdlib/nuclear/n8/n9/n10_*.py` 를 main SSOT 로 인용하는데
로컬 main 체크아웃에는 없고 worktree 에만 존재. PR #907/#913/#917 의 main merge ↔ 로컬 fetch 동기화
타이밍 문제로 추정. 다음 hexa-lang `git fetch origin && git status` 로 확인 권장 (parity 평결에는 영향 없음 —
worktree 사본 3개 모두 동일 패턴으로 PASS).

---

## (d) milestone-#2 done summary (ready-to-paste · RTSC+NUCLEAR.md 라인 8)

```
- [x] Shared R4 invariant parity audit — NUCLEAR §3.1 ↔ RTSC §9.10 parity PASS (8축 중 7 MATCH · gate_type `nuclear-` prefix는 §3.1 명시 mirror 의도 DRIFT) · producer 12/12 `absorbed` literal false 하드코드 (조건부/runtime flip 0건) · @D d6 measured-oracle helper record-agnostic(MeasuredOracleRef.swift:104), sim-only는 oracle path 부재 → 영구 false. exports/nuclear_discovery/parity/2026-05-25-r4-parity-audit.md
```
