# RTSC.md §9.9.1 Phase 4 #2 — composition.hexa (C3+C4) parity verify

> Anchor: `RTSC.md §9.9.1 Phase 4` · `hexa-lang stdlib/material/composition.hexa`
> Date: 2026-05-22
> Parity result: **32/32 PASS** (18 parse element-counts + 14 classify labels · 5/5 rule coverage)

---

## 1. Finding — Phase 4 #2 LANDED via hand-rolled tokenizer (regex blocker 우회)

직전 audit (`2026-05-22-rtsc-9-phase4-2-prep.md`) 는 Phase 4 #2 를 "READY · BLOCKED on PR #276 (regex header)" 로 기록. 하지만 재조사 결과 **이미 LANDED**:

- `hexa-lang stdlib/material/composition.hexa` (concurrent commit `9f343d1b`) 에 C3+C4 모두 포팅됨:
  - `pub fn parse_formula_elements(formula: string) -> Composition` (C3)
  - `pub fn classify_composition_domain(formula: string) -> Classification` (C4)
- **regex 를 안 씀** — hand-rolled char-scan tokenizer (`_is_upper` / `_is_lower` / `_is_digit_ch` / `_scan_count` / `_scan_elements` / `_expand_one_paren_pass` / `_expand_all_parens`). 즉 PR #276 regex header gate 를 *우회* — 내 이전 audit 의 Option B (~280 LOC hand-rolled) path 가 선택됨 (Option A regex 가 아니라).

이는 [[feedback-audit-distinguish-impl-vs-header]] 의 연장 교훈: "blocked on X" 결론 전에 *대체 경로로 이미 done* 인지 grep 으로 확인. composition.hexa 의 존재를 grep 하지 않고 prep note 가 BLOCKED 로 단정.

## 2. Surface (composition.hexa)

```hexa
pub struct Composition { symbols: [string], counts: [float] }      // parallel arrays
pub struct Classification { label: string, rationale: string }

pub fn parse_formula_elements(formula: string) -> Composition       // C3
pub fn classify_composition_domain(formula: string) -> Classification  // C4
```

Classification labels: `inorganic_sc` · `organic_molecular` · `ambiguous`.

## 3. Harness

`/tmp/rtsc-phase4-2-parity/composition_parity_test.hexa` — `use "stdlib/material/composition"` · 32 assertions. Ran via `hexa run` from `~/core/hexa-lang` (copied as `_composition_parity_test.hexa`, removed post-run).

Ground truth: `/tmp/rtsc-phase4-2-parity/python_ground_truth.txt` (14 formulas × `_parse_formula_elements` + `_classify_composition_domain` from `askcos_adapter.py`).

## 4. Result matrix

`parse_formula_elements` (7 cases · 18 element-count assertions) — ALL PASS:

| formula | element counts verified |
|---|---|
| Nb | Nb=1 |
| MgB2 | B=2, Mg=1 |
| YBa2Cu3O7 | Ba=2, Cu=3, O=7, Y=1 |
| Pb10Cu(PO4)6O | Cu=1, **O=25** (single-level paren expansion: 6×4+1), P=6, Pb=10 |
| H3S | H=3, S=1 |
| LaH10 | H=10, La=1 |
| C6H12O6 | C=6, H=12, O=6 |

`classify_composition_domain` (14 cases · 14 label assertions) — ALL PASS:

| formula | label | rule |
|---|---|---|
| Nb · MgB2 · YBa2Cu3O7 · Pb10Cu(PO4)6O · H3S · LaH10 | inorganic_sc | rule 1 allow-list / rule 2 no-carbon |
| Al2O3 · Fe2O3 | inorganic_sc | rule 2 no-carbon |
| YBa2Cu3CO7 | inorganic_sc | rule 3 carbon + heavy-metal + ≥2 O |
| CH4 · C2H6O · C6H12O6 · SiC | organic_molecular | rule 4 small organic |
| C40H50 | ambiguous | rule 5 carbon + no oxide + >30 heavy |

**32/32 PASS · 5/5 classification rules exercised · single-level paren expansion verified.**

## 5. Honest notes

- **Transient compile failure on first run**: `hexa run` 첫 시도가 clang compile fail (runtime.c `MM` dirty state — concurrent agent 가 iter-2c/2d 로 `self/runtime.c` 편집 중). 재시도 clean PASS. `hexa` binary 가 hardcoded `~/core/hexa-lang/self/runtime.c` 사용하므로 concurrent runtime.c 편집에 민감 ([[feedback-hexa-lang-main-land-via-pr]] 의 shared-worktree 위험 연장).
- **LK-99 scrub 영향 0**: composition.hexa 가 LK-99 scrub (`1cbf4ff2` · apatite-class anonymization) 됐지만 `Pb10Cu(PO4)6O` parse + classify 결과 불변 (label `inorganic_sc` 는 allow-list 든 no-carbon rule 2 든 robust).
- **R4 invariant 무영향**: composition.hexa 는 pure compute (formula → element counts / domain label) · `absorbed` 와 무관. N3 askcos_adapter 의 `gate_type=domain-mismatch` 정책은 Python orchestrator 에 그대로.
- **fractional stoichiometry** (e.g. YBa2Cu3O6.5) 는 scaffold 에 없음 — rare edge case · follow-on 시 추가.

## 6. Phase 4 closure

RTSC.md §9.9.1 Phase 4 microkernel port:
- Phase 4 #1 (C1+C2 consensus) ✅ LANDED · 22/22 parity (sim.hexa v0.2.0)
- Phase 4 #2 (C3+C4 parser+classifier) ✅ LANDED · 32/32 parity (composition.hexa)
- N1 (CSP) · N2 (BEE-NET) = 0 microkernel candidates (Phase 3 audit · wrap-as-is forever)

→ **RTSC §9.9.1 Phase 4 microkernel port COMPLETE** (P1 + P2 both LANDED · 0 remaining candidates).

## Anchors

- RTSC.md §9.9.1 Phase 4 (B→A microkernel transition)
- hexa-lang `stdlib/material/composition.hexa` (concurrent `9f343d1b` land · `1cbf4ff2` LK-99 scrub)
- `inbox/notes/2026-05-21-rtsc-9-phase3-microkernel-audit.md` §C3+C4 (P2 candidate spec)
- `inbox/notes/2026-05-22-rtsc-9-phase4-2-prep.md` (prep note · BLOCKED 오진 정정)
- `inbox/notes/2026-05-22-rtsc-9-phase4-1-parity-verify.md` (P1 verify · mirror shape)
- `/tmp/rtsc-phase4-2-parity/{composition_parity_test.hexa,python_ground_truth.txt}` (harness + ground truth)
