# RTSC.md §9.9.1 Phase 4 #2 — C3+C4 ASKCOS parser+classifier port prep

> Anchor: `RTSC.md §9.9.1 Phase 4` · Phase 3 audit P2 bundle (`inbox/notes/2026-05-21-rtsc-9-phase3-microkernel-audit.md` §C3+C4)
> Date: 2026-05-22
> Verdict: **DEFERRED** — prerequisite (`hexa-lang regex runtime backend`) un-LANDED. Hand-rolled tokenizer alternative ↑280 LOC, ROI ↓ vs P1 ratio.

---

## 1. Phase 3 audit recap

`askcos_adapter.py:137-163` (`_parse_formula_elements`, 27 LOC) + `:166-249` (`_classify_composition_domain`, 84 LOC) = **P2 bundle**. Estimated ~110 LOC port *if hexa-lang regex available*; ~200 LOC hand-rolled tokenizer otherwise.

## 2. hexa-lang regex API audit (2026-05-22)

### 2.1 Surface land verify

`hexa-lang stdlib/regex/mod.hexa` v0.1.0 (`pure` capability) 존재 ✅. Public API:

```
pub fn regex_test(pat, s) -> bool                     // anywhere match
pub fn regex_full_match(pat, s) -> bool               // whole-string match
pub fn regex_find(pat, s) -> [int]                    // [start, end]
pub fn regex_find_all(pat, s) -> [[int]]              // all matches
pub fn regex_split_str(pat, s) -> [string]
pub fn regex_replace_all(pat, s, repl) -> string
pub fn regex_pcre_lite_translate(pat) -> string       // \d→[[:digit:]] etc.
```

Flavor: POSIX Extended Regular Expressions. (`.roadmap.stdlib G3`, 2026-05-06)

### 2.2 Runtime backend verify — **FAIL**

```
$ cd ~/core/hexa-lang
$ /Users/ghost/.hx/bin/hexa run stdlib/regex/regex_test.hexa
error: clang compile failed — binary not produced
  build/artifacts/hexa_run.*.c:187:24: error: call to undeclared function
    'hexa_regex_match'; ISO C99 and later do not support implicit function
    declarations [-Wimplicit-function-declaration]
  ... passing 'int' to parameter of incompatible type 'HexaVal'
```

**stdlib surface 는 `regex_match` / `regex_match_full` / `regex_search` / `regex_findall` / `regex_split` / `regex_replace` builtin 을 호출, codegen 도 그대로 emit — 그러나 컴파일이 깨짐.**

### 2.3 Status verdict — 정정 (2026-05-22 오후)

> **초기 가설 (오진)**: "runtime backend 미land · broken stub". 실제 상태는 *header-only gap*.
>
> **재조사 결과** (hexa-lang PR #276 작업 중 발견): `self/runtime.c:10202-10374` 에 **6 builtin 모두 완전 구현돼 있음** — POSIX `regcomp`/`regexec` glue + `(?i)` inline flag → `REG_ICASE` strip 포함. 빌드 실패의 원인은 `self/runtime.h` 에 6 builtin 선언이 빠져서 clang 이 implicit-declaration (`int(...)`) 로 처리 → HexaVal 타입 불일치. **22 LOC header-only fix** 로 해결.

| 계층 | LANDED? | 비고 |
|---|---|---|
| Spec (POSIX ERE flavor + `(?i)` inline flag + PCRE translator) | ✅ | mod.hexa 헤더 |
| stdlib surface (6 pub fn) | ✅ | mod.hexa |
| Runtime implementation (`hexa_regex_*` in `self/runtime.c`) | ✅ | **이미 LANDED · runtime.c:10202-10374 · POSIX regcomp/regexec 완전 구현** |
| Runtime header declaration (`self/runtime.h`) | ⏳ | hexa-lang PR #276 — 22 LOC fix · 24/24 local PASS · CI queued |
| Self-test (`stdlib/regex/regex_test.hexa`) | ⏳ | PR #276 머지 후 PASS · 24/24 local verified |

**`stdlib/regex/` = ready (PR #276 머지 대기)** — 머지 시 즉시 caller 사용 가능. 본 audit 의 초기 "broken stub" framing 은 오진.

## 3. Hand-rolled tokenizer alternative — string-iterator API audit

`stdlib/core/string.hexa` (shim → `stdlib/core/string.hexa`) public API:

```
pub fn char_at(s, i)            // implicitly available (used in starts_with)
pub fn starts_with(s, prefix) -> bool
pub fn ends_with(s, suffix) -> bool
pub fn is_empty(s) -> bool
pub fn is_digit(ch) -> bool
pub fn is_alpha(ch) -> bool
pub fn repeat / pad_left / pad_right / reverse
```

**Verdict: char_at + is_digit + is_alpha 로 formula tokenizer 손수 작성 가능 ✅**.

## 4. ROI 재평가

| Option | LOC | session est | unblock |
|---|---|---|---|
| A — regex route (Phase 3 audit 가정) | ~110 | 1-2 | ❌ regex runtime backend land 필요 (별도 cohort 작업) |
| B — hand-rolled tokenizer | ~280 | 2-3 | ✅ 즉시 가능 (string API 충분) |
| C — defer Phase 4 #2 | 0 | 0 | wait for (a) regex runtime backend OR (b) 외부 consumer (bio/chem cohort) 가 formula parser 필요 → ROI 명확 |

P1 (consensus port) 의 ROI 비교: 50 LOC · 1 session · 22/22 parity. P2 hand-rolled (B) 는 280 LOC · 2-3 session · P1 보다 5.6× 비용. 외부 consumer 무 (현재 ASKCOS gate 만 사용) 인 상태에서 **ROI ↓ 명확**.

## 5. 권장 — READY (PR #276 머지 대기 · DEFER 정정)

> **2026-05-22 오후 정정**: 초기 권장은 "DEFER" 였지만 hexa-lang regex 의 실제 상태가 *implementation LANDED + header gap* 임이 PR #276 작업 중 밝혀짐. 22 LOC header fix 로 해결 가능 — DEFER 사유 (broken stub) 가 사라짐.

**현재 권장**: Phase 4 #2 (C3+C4 ASKCOS parser+classifier 의 110 LOC port) 는 **hexa-lang PR #276 머지 후 즉시 진행 가능**. ROI 평가:

| Option | LOC | session est | unblock |
|---|---|---|---|
| A — regex route | ~110 | 1-2 | ⏳ hexa-lang PR #276 머지 (CI queued · 본 세션 OPEN) |
| B — hand-rolled tokenizer | ~280 | 2-3 | (불필요 — A 가 unblock 임박) |

PR #276 머지 후의 Phase 4 #2 진행 우선순위는 다른 트랙 (κ-69 G33 first-flip · Phase 2 ext 후속 등) 과 비교하여 별도 평가. 즉 *기술적 blocker* 는 해소, *priority decision* 만 남음.

## 6. R4 invariant 영향

- Phase 4 #2 deferral 은 N3 askcos_adapter 의 `gate_type=domain-mismatch` 동작 무영향.
- N1-N4 의 `absorbed=false 영구` invariant 보존.
- Phase 4 #1 의 22/22 PASS 와 독립 — 본 deferral 은 *추가* port 의 scope 결정일 뿐.

## 7. Phase progress table update — 정정 (2026-05-22 오후)

RTSC.md §9.9.1 Phase progress table 의 "Phase 4 #2" row 갱신: ⏳ DEFERRED → ⏳ READY (PR #276 머지 대기). 머지 land 시 즉시 110 LOC port 가능.

## Anchors

- RTSC.md §9.9.1 Phase 4 (B→A microkernel transition)
- `inbox/notes/2026-05-21-rtsc-9-phase3-microkernel-audit.md` §C3+C4 (P2 candidate spec)
- hexa-lang `stdlib/regex/mod.hexa` (surface ✅) + `self/runtime.c:10202-10374` (impl ✅ 이미 LANDED) + `self/runtime.h` (header gap → PR #276)
- hexa-lang PR #276 (`regex-runtime-backend` branch · `f90ba2f5` · 22 LOC header fix · 24/24 local PASS · CI queued)
- hexa-lang `.roadmap.stdlib G3` (regex runtime backend cohort · 2026-05-06)
- D116 (sibling repos = 문서만 · demiurge=pointer)

---

## Closure (2026-05-22 — session 2: parity scaffold land + status recheck)

**PR #276 상태 재확인** (2026-05-22 본 세션): OPEN · **CI = ALL FAILURE** across all 4 checks.
- `bootstrap (macos-arm64 / linux-x86_64 / linux-arm64)` — linker errors (`undefined reference to hexa_int`, `hexa_array_new`, `__hexa_fn_arena_return`, etc.). Origin: pre-existing Stage 0 transpiler bootstrap infra issue, NOT caused by the 22-LOC `runtime.h` header addition.
- `check @grace consent trailers` — environmental (`no hexa interpreter found (expected build/hexa_interp.linux or PATH:hexa)`). Pre-existing infra issue.

→ Phase 4 #2 Path A (full 110 LOC port) **여전히 unblocked 불가** — 본 세션은 Path B (prep-only) 으로 진행.

### Path B 산출물 (본 세션 land)

1. **Parity test scaffold** — `/tmp/rtsc-phase4-2-parity/formula_parity_test.hexa` ✅
   - 21 cases · 32 assertions (parse 7 cases × 18 elem-count checks + classify 14 cases × 14 label checks).
   - Per-rule 5/5 coverage: rule 1 allow-list (6×) · rule 2 no-carbon (2×) · rule 3 carbon+metal+oxide (1×) · rule 4 small-organic (4×) · rule 5 ambiguous (1×).
   - Uses assumed `use "stdlib/material/formula"` surface — drop-in for the NEXT session that picks up Path A once PR #276 merges.
2. **Python ground-truth dump** — `/tmp/rtsc-phase4-2-parity/python_ground_truth.txt` ✅
   - 14 formulas × `_parse_formula_elements` + `_classify_composition_domain` outputs.
   - Pre-cached so the next-session agent does NOT have to re-derive (mirrors `python_expected.txt` precedent from Phase 4 #1).

### NOT done in this session (intentional — Path B scope)

- ❌ `stdlib/material/formula.hexa` — depends on regex runtime backend being usable.
- ❌ hexa-lang PR (formula port) — same dependency.
- ❌ RTSC.md §9.9.1 row flip — still `⏳ READY (PR #276 머지 대기)`. Same state as session 1 closure; no demotion / promotion.

### Next-pickup criteria (when to resume Path A)

1. PR #276 CI 4/4 green ⟶ merge ⟶ proceed Path A using the scaffold + ground-truth above.
2. OR PR #276 bootstrap infra failures resolved on `main` (independent track) and re-tested.
3. OR pivot decision: hand-rolled tokenizer (Path B-alt §4) becomes ROI-positive when an external consumer (bio/chem cohort) appears — currently no consumer exists, so deferring remains correct.

### Honest invariants (g3 — confirmed unchanged)

- N3 `gate_type=domain-mismatch` 동작 무영향 (port = math, NOT policy).
- R4 `absorbed=false 영구` carry over from N3 wrap — pure-compute port plan does not touch.
- Phase 4 #1 22/22 PASS 그대로 — 본 세션은 #2 만 다루며 #1 영역 무수정.
- Scaffold land 위치 = `/tmp/...` (transient) · demiurge note 가 영구 record · D116 pointer 원칙 준수.

**Session verdict**: Path B exit (β) — prep scaffold landed in `/tmp` · prep-note closure 박제 · DEFER pending PR #276 merge.
