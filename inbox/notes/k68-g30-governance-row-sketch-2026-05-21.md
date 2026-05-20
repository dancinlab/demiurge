# DRAFT — AGENTS.tape `@D g_absorbed_needs_measured_oracle` row (G30 land 후보)

> **status**: draft · 2026-05-21
>
> **목적**: ARCH.md §11.4 Round 7 G30 (governance gate — absorbed-vs-
> measured invariant typed enforcement) 의 .tape v1.3 do/dont form
> @D row 사전 검토. land 위치 = `AGENTS.tape` INDEX (top) 1줄 +
> body block 1개 (post-8deeb7d format mirror).
>
> **dependency staging**: 본 @D 는 G28 (cell record schema 확장 ·
> `MeasuredOracleRef` typed field 추가) 가 land 한 *후* 에만
> 의미 있음 — 그 전에는 invariant 가 검사할 field 자체가 부재.
> 따라서 land 순서 = **G28 → G29 → G30**. 본 draft 는 G30 차례
> 시 즉시 land 가능한 형태로 사전 박제.

---

## 1. Name 결정

**Picked**: `g_absorbed_needs_measured_oracle`

이유:
- 의미 명료 — "cell-level absorbed = measured oracle 필요" 가
  immediate readable.
- 기존 `@D` 명명 패턴과 일관 (`g_hexa_only` · `g_no_hardcoded_data`
  · `g_swift_native` 등 — 'g_' prefix + snake_case + 의미 키워드).
- D103 dimension-separation 의 measured axis 를 직접 지칭.

**Rejected alternatives**:
| 이름 | reject 이유 |
|---|---|
| `g_absorbed_measured_required` | 어순 (cell absorbed 가 측정 *필요* 인지 *측정* 이 absorbed 필요 인지) 모호. |
| `g_absorbed_writer_explicit` | path-focused 인데 "왜 explicit 인지" 가 이름에 안 들림. D103 의 separation 의도가 흐려짐. |
| `g_measured_oracle_gate` | gate-focused 인데 어느 gate 인지 (absorbed flip / record emit / UI 표현) 추상. |

## 2. INDEX-top entry (1줄)

`AGENTS.tape` INDEX 의 `@D g_*` 행렬에 추가 — `# @D <name> — <one-
liner>` 형식, 다른 entry 들과 col-alignment 맞춤. (D-번호 인용 자리
는 D109 가 본 invariant 의 source decision 이므로 `(D109)` — 단,
G30 land 시점에 D109 가 design.md 에 실제 박혀 있어야 함.)

```
# @D g_absorbed_needs_measured_oracle — stored absorbed=true 는 record 안 measured_oracle PASS 일 때만; D95 computed projection 부산물 금지; D106 illustrative-physics cell 은 본 규칙 제외 (D103/D109)
```

## 3. Body block (.tape v1.3 do/dont form · 8deeb7d 후 style)

`AGENTS.tape` 의 body @D block 영역 (INDEX 직후) 끝에 추가. style
mirror = 8deeb7d commit 의 16 entries — 단일 do / 단일 dont / 단일
`@>` link.

```
@D g_absorbed_needs_measured_oracle := "cell absorbed = measured oracle PASS only" :: governance [required d=2026-05-21 active]
  do   = "stored absorbed=true 는 record 안 measured_oracle{meanRelErr<=threshold} PASS 일 때만 · writer 가 explicit set · D106 illustrative-physics cell 은 본 규칙 제외 (cell record 의 measured_oracle 미보유 · stored absorbed false 유지)"
  dont = "D95 computed isHexaNativeAbsorbed 의 부산물로 stored absorbed=true · measured_oracle 부재 시 absorbed=true · auto-derive (writer 가 항상 explicit set) · D106 illustrative cell 에 measured_oracle 강제 부여"
  @> CLAUDE.md
```

## 4. Exclusion clause 설계

D106 illustrative-physics gate 가 적용된 cell (현재 = `FusionVerify
Record` 의 mc_transport / mc_slab_demo path; 향후 patternproof / 단일
energy group 류) 은 **본 invariant 의 대상이 아님**. 이유:
- D106 의 honest stance 는 "substrate-parity PASS 이지만 measured-
  oracle 의 자격 자체 부재" — `MeasuredOracleRef` 가 nil 인 게
  *honest state*.
- 본 invariant 가 D106 cell 까지 강제하면 "측정-oracle 없으니
  absorbed=true 도 불가" 라는 *true-by-other-reason* 결론 (D106 가
  이미 그런 cell 의 absorbed 를 막고 있음) — invariant 의 의미가
  redundant + cyan tone 의 anti-conflation 메시지 약화.

**Implementation**: do/dont 본문에 명시 (위 §3 의 do/dont 양쪽).
별도 `@D` 추가는 *overhead* — 단일 do/dont 안의 "D106 illustrative
cell 제외" 조항으로 충분.

## 5. Dependency staging

```
G27 (D109 land)  →  G28 (MeasuredOracleRef + EnergyVerifyRecord field)  →  G29 (첫 absorbed=true flip)  →  G30 (본 @D + XCTest invariant)
```

- **G28 미land 시 본 @D land 금지** — invariant 가 검사할 field
  자체 부재. land 자체는 무해하나 honest 하지 않음 (governance
  가 enforcement 대상 없이 존재).
- **G29 land 직후 본 @D land** — invariant 가 "이미 PASS 한 state"
  를 가드 + 미래 의 reverse-engineering / accidental-flip 방어.
- **본 @D 와 XCTest 의 staged binding**: AGENTS.tape `@D` row +
  cockpit `XCTest` (이름 후보: `AbsorbedNeedsMeasuredOracleTests`)
  가 한 commit 으로 land — governance + enforcement 가 같은 사이클.

## 6. XCTest invariant sketch (G30 land 동반)

본 @D 와 함께 land 할 XCTest 의 minimal shape (구현은 G30 land
사이클에서):

```swift
// AbsorbedNeedsMeasuredOracleTests.swift — G30 · @D g_absorbed_needs_measured_oracle

func testAbsorbedRequiresMeasuredOraclePASS() {
    // For every cell record JSON under exports/ that carries
    // absorbed=true, assert: either
    //   (a) the record carries `measured_oracle` non-nil AND
    //       `meanRelErr <= threshold`, OR
    //   (b) the record's gate_type == "illustrative-physics" (D106
    //       exclusion).
    // Otherwise FAIL.
}

func testAbsorbedNotAutoflippedByD95Computed() {
    // Synthesize a record with `hexaNativeParity.parityStatus =
    // "PASS"` (D95 isHexaNativeAbsorbed → true) AND `measured_oracle
    // = nil` AND `absorbed = true`. Assert FAIL (writer must NOT
    // promote computed → stored).
}

func testD106IllustrativeCellExemptFromMeasuredOracle() {
    // Synthesize a FusionVerifyRecord with gate_type =
    // "illustrative-physics", measured_oracle = nil, absorbed =
    // false. Assert PASS (D106 exclusion).
}
```

## 7. Open questions (사용자 review point)

1. **Enforcement scope** — XCTest invariant 만 (test-level guard)
   vs CI hook 추가 (pre-commit / pre-merge) vs hexa-lang governance
   plugin 의 entry 추가. 현 sketch 는 XCTest 단독 — 첫 land 의
   honest floor. CI 추가는 후속 round.
2. **본 @D 의 `[required]` flag** — 다른 @D 와 일관성 `required`
   적용 (현 sketch). non-`required` 로 두는 옵션 (전환기 honest
   stance) 도 있으나 G30 의 exit criterion 이 typed enforcement 라
   `required` 가 맞음.
3. **`@>` link 의 대상** — 현 sketch 는 `CLAUDE.md` (다른 @D 와
   일관). `CLAUDE.md` 가 user-global identity 이고 본 invariant 는
   demiurge-project-local 이라 link 부적정 의문 — 다른 @D 도 모두
   `CLAUDE.md` 로 link 되어 있어 일관성 유지가 더 honest. ARCH.md
   §11.4 G30 + design.md D109 의 추가 link 는 `@>` 가 single field
   라서 직접 못 추가 — INDEX 의 one-liner 에 `(D109)` reference 로
   대체 (위 §2 의 line 끝).
4. **이름 final lock-in 시점** — 본 draft 의 name `g_absorbed_
   needs_measured_oracle` 이 사용자 final 인지 확인. land 후 rename
   은 commit-level 변경이라 비용 큼 — G30 land 직전 한번 더 확인
   recommended.
5. **D109 박제 timing 과의 ordering** — 본 @D 는 *INDEX 의
   one-liner* 안에 "(D109)" 를 인용. D109 가 design.md 에 land 한
   *후* 에만 본 @D land 가능 (cite-validity). 즉 **D109 land →
   G28 land → G29 land → G30 (본 @D) land** 순서가 honest.

---

## Cross-references

- ARCH.md §11.4 Round 7 G30 (`[ ]` placeholder · 본 sketch 가 land
  base)
- `AGENTS.tape` (8deeb7d 후 .tape v1.3 do/dont form mirror anchor)
- design.md D103 (dimension-separation docstring · 본 invariant 의
  semantic source) · D106 (illustrative-physics gate · 본 invariant
  의 exclusion source) · D109 (cell pick + decision gate · 본
  invariant 의 reference)
- proposals/rfc_013_hexa_native_parity_connection.md §6.11
- inbox/notes/k68-cell-pick-2026-05-21.md · k68-d109-draft-2026-05-21.md
  · k68-g28-measured-oracle-ref-sketch-2026-05-21.md
