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

**stdlib surface 는 `regex_match` / `regex_match_full` / `regex_search` / `regex_findall` / `regex_split` / `regex_replace` builtin 을 호출, runtime backend (`self/runtime.h` + `runtime.c`) 미land — POSIX `regcomp` / `regexec` 의 builtin glue 가 빠짐.**

### 2.3 Status verdict

| 계층 | LANDED? | 비고 |
|---|---|---|
| Spec (POSIX ERE flavor + `(?i)` inline flag + PCRE translator) | ✅ | mod.hexa 헤더 |
| stdlib surface (6 pub fn) | ✅ | mod.hexa |
| Runtime builtin (`hexa_regex_*`) | ❌ | runtime.h 미선언 · runtime.c 구현 부재 |
| Self-test (`stdlib/regex/regex_test.hexa`) | ❌ | compile blocked on (2) |

**`stdlib/regex/` = broken stub (API surface 만 land, runtime 미land)** — `.roadmap.stdlib G3` 완성 전까지 caller 가 호출하면 compile error.

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

## 5. 권장 — DEFER (Option C)

**불러옴**: Phase 4 #2 는 다음 두 조건 중 하나 충족 시 재opens:

1. **`stdlib/regex/` runtime backend land** (별도 `.roadmap.stdlib G3` cohort 작업) — 그 때 Option A 부활, 110 LOC 1-2 session 비용으로 ROI 회복.
2. **외부 consumer 출현** — bio cohort 의 protein-formula parser 또는 chem cohort 의 IUPAC-formula parser 가 같은 코드 필요 → 280 LOC 가 ≥2 consumer 에 amortize → Option B 가치 회복.

본 deferral 은 anti-pattern 아님 — Phase 3 audit 의 "P2 (~110 LOC, 1-2 sessions, **regex-blocked** — defer if hexa-lang regex absent)" caveat 가 명시한 path 그대로.

## 6. R4 invariant 영향

- Phase 4 #2 deferral 은 N3 askcos_adapter 의 `gate_type=domain-mismatch` 동작 무영향.
- N1-N4 의 `absorbed=false 영구` invariant 보존.
- Phase 4 #1 의 22/22 PASS 와 독립 — 본 deferral 은 *추가* port 의 scope 결정일 뿐.

## 7. Phase progress table update

RTSC.md §9.9.1 Phase progress table 의 "Phase 4 #2" row 는 ⏳ PENDING 상태 유지, **prerequisite = `.roadmap.stdlib G3` (regex runtime backend) OR 외부 consumer 출현** 으로 명시 (본 commit 에서 갱신).

## Anchors

- RTSC.md §9.9.1 Phase 4 (B→A microkernel transition)
- `inbox/notes/2026-05-21-rtsc-9-phase3-microkernel-audit.md` §C3+C4 (P2 candidate spec)
- hexa-lang `stdlib/regex/mod.hexa` (surface ✅) + `self/runtime.c` (backend ❌)
- hexa-lang `.roadmap.stdlib G3` (regex runtime backend cohort · 2026-05-06)
- D116 (sibling repos = 문서만 · demiurge=pointer)
