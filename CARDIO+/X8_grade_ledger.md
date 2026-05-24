# X8 — CARDIO+ unified g5 grade ledger (4 sub-domain 등급 합산 단일 진실 소스)

> CARDIO+ 메타도메인 X8 산출물 · current-state · no history.
> 목적 = 4 sub-domain (NOREFLOW · DAPTPGX · ISR · LPA) 의 모든 g5 등급을 단일 ledger 로 합산 — X7 DOCTOR feed 의 **단일 grade 진실 소스 (single source of grade truth)**.
> ⚠ 본 X8 은 **등급 합산 only** — 새 hexa verify / sim / atlas 실행 없음 · 4 sub-domain V4 ledger + X1 / X4 / X9 verdict VERBATIM 복사·합산 (수정 금지). **LLM self-judge 새 등급 부여 0건** (per @D g5). count 충돌 시 sub-domain V4 ledger 우선 (X4 선례 따름) · 불확실/추정은 "추정" 명시 (X1 선례 따름).

---

## §1. g5 rubric 6-tier 정의 (`hexa verify rubric` VERBATIM)

출처 = NOREFLOW V4 §1.2 의 `hexa verify rubric` CLI stdout 그대로 (4 sub-domain 공통 rubric).

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

→ X8 은 정확히 6-tier (🔵🟢🟡🟠🔴⚪) 채택 (🟠 INSUFFICIENT + 🟠 DEFERRED 는 동일 tier 의 2 변형 — 합산 시 🟠 1열로 통합).

**g5 합산 규약** (X4 선례 carry):
- 모든 등급은 sub-domain V4 ledger / X1 / X4 / X9 에 이미 기록된 `hexa verify` verdict VERBATIM 복사 — X8 가 새 판정 0건.
- count 충돌 시 sub-domain V4 ledger > X1 추정 (X4 §4.1 선례).
- count 불확실/표 내부 불일치 시 "추정" 명시 (X1 선례) — 숨기지 않음.

---

## §2. 마스터 ledger 표 (행=4 sub-domain · 열=6 tier · 셀=개수)

> 각 셀 = 해당 sub-domain V4 ledger 의 현재 filled count VERBATIM. 🔵 placeholder (PR-pending) 는 별도 표기 (§3 trajectory).

| sub-domain | 🔵 SUPPORTED-FORMAL | 🟢 SUPPORTED-NUMERICAL | 🟡 SUPPORTED-BY-CITATION | 🟠 INSUFF/DEFERRED | 🔴 FALSIFIED | ⚪ SPEC-FENCED | sub 총계 | V4 출처 |
|---|---:|---:|---:|---:|---:|---:|---:|---|
| **NOREFLOW** | **0** (11 ph) | **10** (+1 hybrid) | **33** | **10** | **4** | **15** | 72 (+6 metaphor) | V4 §9.1 |
| **DAPTPGX** | **0** | **5** | **13~18** † | **9** | **0** | **3** | 30 | V4 §7 + §1 |
| **ISR** | **0** (28 pot) | **0** (10 pot) | **150+** | **22** | **0** | **13** (10+3) | 200+ | V4 §9.2 |
| **LPA** | **1** | **28** ‡ | **17** | **4** | **1** | **0** | 45 | V4 본문 분포표 |
| **합산 (filled)** | **1** | **43** | **213~218** | **45** | **5** | **31** | **~347+** | — |

```
─────────────────────────────────────────────────────────────────────────
6-tier 합산 (filled, 현재):
  🔵 SUPPORTED-FORMAL        =   1   (LPA sigma sanity C30 만)
  🟢 SUPPORTED-NUMERICAL     =  43   (NOREFLOW 10 + DAPTPGX 5 + ISR 0 + LPA 28)
  🟡 SUPPORTED-BY-CITATION   = 213~218 (NOREFLOW 33 + DAPTPGX 13~18 + ISR 150+ + LPA 17)
  🟠 INSUFFICIENT/DEFERRED   =  45   (NOREFLOW 10 + DAPTPGX 9 + ISR 22 + LPA 4)
  🔴 FALSIFIED               =   5   (NOREFLOW 4 + LPA 1)
  ⚪ SPECULATION-FENCED      =  31   (NOREFLOW 15 + DAPTPGX 3 + ISR 13 + LPA 0)
─────────────────────────────────────────────────────────────────────────
  강한 근거 (🔵+🟢)         =  44   ← 현재 filled
─────────────────────────────────────────────────────────────────────────
```

**† DAPTPGX 🟡 표기 honest 추정**: DAPTPGX V4 §7 핵심 통찰 VERBATIM = "30 claim 중 5개 🟢 + 0 🔵 (V4 시점)" + "⚪ 3 유지" + "🔴 0". §1 분포표 "V2 후 (staged 포함 미흡수)" 열 = 🟡 18 · 🟠 9. 그러나 §2 30-claim per-claim ledger 에서 V4 시점 현재 🟡 잔존 = C04·C07·C08·C09·C10·C11·C12·C13·C14·C16·C17·C18·C19 = **13** (C22·C23·C24 는 V4 final 🟢 catalog 로 escalation). §1 (18) 과 §2 (13) 의 5건 차이 = §1 표가 C22/C23/C24 catalog 🟢 escalation + C01/C02/C03 V3 🟢 escalation 을 🟡 18 에서 미차감한 **V4 ledger 내부 표 불일치** — X8 은 숨기지 않고 honest 하게 **13~18 range** 로 표기 (per @D g5). per-claim ledger (§2, 13) 가 더 granular 하나 §1 분포표 (18) 가 도메인 공식 분포표이므로 양쪽 carry. sub 총계 30 은 불변 (DAPTPGX claim 분모는 30 으로 확정).

**‡ LPA 🟢 표기 honest reconcile**: LPA V4 본문 분포표 = 🟢 **28** (R1 4 + R2 4 + V3a 5 + V3c 5 + V3b 5 + M12 +3 − 1 🔴 보정). LPA.md milestone 헤더 (verify §V4 줄) = "🟢 **22**" — 이는 **V3b 보류 전 잠정치** (V4.md 본문 "최종 tier 분포 (V3b 보류 잠정)" 표기). V3b MR/IVW MC (5건 🟢) land 후 22 → 28 확정. X8 은 V4 본문 분포표 (28, V3b land 후) 를 SSOT 로 채택 — LPA.md 헤더 22 는 V3b-land 전 잠정으로 명시.

---

## §3. 🔵 trajectory 표 (현재 filled vs atlas-PR merge 후 target)

> 🔵 SUPPORTED-FORMAL 은 4 sub-domain 모두 hexa-lang bio-verify-kernel / atlas PR merge 에 의존하는 placeholder trajectory 가 핵심. X9 wall map §6.3 의 단일 PR cross-domain leverage 와 정합.

### 3.1 🔵 현재 filled vs PR merge 후 target

| sub-domain | 🔵 현재 filled | 🔵 placeholder (PR-pending) | PR merge 후 target | 의존 PR (X9 §6.3 VERBATIM) |
|---|---:|---:|---:|---|
| **NOREFLOW** | 0 | 11 (V4 §3.2) | ~11 (+4 register chain → 15 potential) | **PR #658** OPEN · mergedAt=null (noreflow-clinical-calc) |
| **DAPTPGX** | 0 | 4 (staged shard · §3) | 4~10 (V2 흡수 + V3.5 후) | atlas promoter bug + 'P' kind 확장 (inbox patch 2건) · **PR #665** |
| **ISR** | 0 | 28 potential (5 enum/set ⚪ 유지 제외 시 23) | 7~28 (phase 1: 7-10 · phase 1+2: 14-22 · 전체: 22-28) | **bio-verify-kernel phase 2** PR (hill·cheng_prusoff·higuchi·fick) |
| **LPA** | 1 | 0 (🟢 ceiling by design) | 1 (+KIV-2 정수 copy / Schoenfeld 정수 events 잠재) | PR #709/#736/#700 **MERGED** — 🔵 정정 완료 (float-num = 🟢 ceiling) |
| **합산** | **1** | **~43** (NOREFLOW 11 + DAPTPGX 4 + ISR 28) | **~23~53** | bio-verify-kernel phase 2 + PR #658 + PR #665 |

```
🔵 SUPPORTED-FORMAL trajectory:
  현재 filled =  1  (LPA sigma sanity 만 — 유일하게 atlas-attested closed-form)
                ↓  단일 hexa-lang bio-verify-kernel phase 2 PR + PR #658 + PR #665 merge
  PR 후 target = 23~53  (NOREFLOW 11 + DAPTPGX 4-10 + ISR 7-28 + LPA 1)
```

### 3.2 🔵 placeholder 사유 분리 (honest)

| placeholder 종류 | sub-domain | count | un-fence/un-block 조건 |
|---|---|---:|---|
| **PR-pending atlas 확장** (closed-form 도달 가능) | NOREFLOW | 11 | PR #658 merge → V2 agent re-fire → `hexa verify --expr` 11건 fill |
| **PR-pending atlas promoter** (수학 항등식 + freq) | DAPTPGX | 4 | inbox patch 2건 흡수 → staged 4 shard 즉시 🔵 promote |
| **PR-pending bio-verify-kernel** (bio identity float ABI) | ISR | 28 (23 + 5 enum ⚪) | bio-verify-kernel phase 2 merge → 7-28 escalation (5 enum/set 은 ⚪ 영구 유지) |
| **🟢 ceiling by design** (float-numerical → 🔵 unreachable) | LPA | 0 (1 filled) | PR #736 정정 — float fn 은 🟢 천장 · 🔵 = integer closed-form 만 (KIV-2 copy 잠재) |

→ **honest 핵심**: 현재 🔵 = 1 (LPA C30) 은 **유일하게 PR 의존 없이 atlas-attested closed-form (sigma sanity)**. 나머지 3 sub-domain 의 🔵 = 전부 PR-pending placeholder. **단일 hexa-lang bio-verify-kernel phase 2 PR** 이 NOREFLOW (11) + DAPTPGX (4) + ISR (잔여) 를 동시 unlock — X9 §7 순위 1 leverage 와 정합.

---

## §4. X1 추정 ↔ X8 확정 reconcile 표 (정직한 차이 기록)

> X1 §13 추정치는 ISR V4 ledger 확정 **전** 보수치 (X1 §2.1 † note: "ISR V4_tier_ledger 확정 시 200+ 정확 분모"). X8 은 4 sub V4 확정 후 정량 — X4 §4.1 이 ⚪ 에서 한 것과 동일하게 **어느 tier 가 왜 달라졌나** honest 기록.

| tier | X1 추정 (current, §13) | X8 확정 (V4 합산) | 차이 | 차이 사유 (honest) |
|---|---:|---:|---:|---|
| 🔵 | 1 | **1** | 0 | LPA C30 sigma sanity 동일 — X1 도 LPA 1 만 인지 (정합) |
| 🟢 | 14 | **43** | **+29** | **최대 reconcile 차이** — X1 은 LPA 14 만 (V3a/c/b·M12 land 전). X8 = NOREFLOW V3 10 + DAPTPGX 5 + LPA 28 (V3b+M12 land 후) 합산 |
| 🟡 | ~133 | **213~218** | +80~85 | X1 은 ISR "inline 50+" 만 카운트 (ISR V4 미확정 ~140 carry 제외). X8 = ISR V4 확정 150+ 전수 반영 |
| 🟠 | ~44 | **45** | +1 | 거의 정합 — ISR 22 + NOREFLOW 10 + DAPTPGX 9 + LPA 4 = 45 (X1 추정 정확) |
| 🔴 | 1 | **5** | +4 | X1 은 LPA C41 1 만. X8 = NOREFLOW 4 large RCT null (EMPACT-MI·CLEAR SYNERGY·Korean nicorandil 6mo·CHIPS-PCI) V4 §7 추가 + LPA 1 |
| ⚪ | 3 | **31** | +28 | X1 §13 은 DAPTPGX 3 만 (보수). X4 가 이미 31 (raw) 로 정량 — ISR 13 (kernel 10 + enum 3) + NOREFLOW 15 (9 핵심 + 6 metaphor) 미포함이 원인 |

```
X1 추정 합산 (current)    →    X8 확정 합산 (V4 land 후)
🔵 1 · 🟢 14 · 🟡 ~133    →    🔵 1 · 🟢 43 · 🟡 213~218
🟠 ~44 · 🔴 1 · ⚪ 3       →    🟠 45 · 🔴 5 · ⚪ 31
강한 근거 (🔵+🟢) 15      →    강한 근거 (🔵+🟢) 44
```

**reconcile 핵심 (X1 → X8 가장 큰 차이 1개)**:
> **🟢 +29** (14 → 43) 이 단일 최대 reconcile 차이. X1 추정 시점에는 LPA 만 V3 land 상태 (🟢 14) 였고 NOREFLOW V3 (10) / DAPTPGX V3 (5) / LPA V3b+M12 (+14) 가 모두 미반영이었다. X8 시점에는 4 sub V4 ledger 가 모두 확정되어 NOREFLOW 10 + DAPTPGX 5 + LPA 28 = 43 으로 정량. 이는 X1 §2.1 † 가 예고한 "V4 확정 시 분포 갱신" 그대로 — 등급 자체는 V4 verdict VERBATIM, 차이는 land 시점 차이.

**ISR ⚪ 13 추가 효과** (X4 §4.1 와 동일 관찰 carry): X1 §13 ⚪ 3 (DAPTPGX 만) → X8 ⚪ 31. ISR V4 가 13 (kernel-temporary 10 + enum 영구 3) 을 명시 carry + NOREFLOW 15 (metaphor 6 포함) 가 합산되며 상향. X4 가 이미 raw 31 / dedup ~25 로 정량 — X8 ⚪ 31 (raw) 은 X4 와 정합 (X8 은 dedup 전 raw 합산 ledger).

---

## §5. 🔴 FALSIFIED 명세 (X9 closed-negative 5종 grade)

> 🔴 FALSIFIED = "calc DETERMINISTICALLY disagrees — CLOSED negative" (rubric VERBATIM). **wall 이 아니라 닫힌 음성** (X9 §9 honest fence: 🔴 영역은 wall 아닌 closed negative, audit trail 보존). X9 가 wall 에서 분리한 5종 closed-negative 를 grade 로 명시.

| # | claim | falsifying 근거 | sub-domain | grade | source (VERBATIM) |
|---|---|---|---|---|---|
| **F1** | SGLT2i acute MI MACE 가설 | EMPACT-MI HR 0.90 NS (Butler 2024 NEJM) | NOREFLOW | 🔴 | NOREFLOW V4 §7 R1 |
| **F2** | colchicine acute MI MACE 가설 | CLEAR SYNERGY HR 0.99 NS (Jolly 2024 NEJM) | NOREFLOW | 🔴 | NOREFLOW V4 §7 R2 |
| **F3** | nicorandil 한국 STEMI 6mo infarct size 차이 가설 | Korean nicorandil RCT 6mo 차이 없음 (Heart 2023) | NOREFLOW | 🔴 | NOREFLOW V4 §7 R3 |
| **F4** | nicorandil 동아시아 PO 6mo MACE 가설 | CHIPS-PCI 6mo 무효 (Lancet Reg Health W Pac 2023) | NOREFLOW | 🔴 | NOREFLOW V4 §7 R4 |
| **F5** | GalNAc-siRNA in-silico 종합 free tool 부재 | Alnylam/Arrowhead 사내 IP wall (closed negative) | LPA | 🔴 | LPA V4 §🔴 C41 |

```
🔴 FALSIFIED 합산 = 5  (NOREFLOW 4 + LPA 1)
  ├─ NOREFLOW 4 = large RCT primary endpoint deterministic disagreement (acute MACE 가설 falsify)
  └─ LPA 1 = GalNAc free-tool IP wall (closed negative, ≠ INSUFFICIENT)
  ✅ DAPTPGX 0 (V4 §4: V3 ICER sign mismatch 는 model gap, FALSIFIED 부여 거부 per @D d6)
  ✅ ISR 0 (V4 §6: kernel 부재 = 🟠 INSUFFICIENT, not 🔴; literature mismatch 도 ⚪ 였음)
```

**X9 §9 정합 note**: X9 honest fence 가 wall 에서 분리한 closed-negative 목록 = "PON1·darapladib·GalNAc free-tool·SGLT2i acute·colchicine acute·한중 nicorandil 6mo". 이 중 V4 ledger 에 명시적 🔴 grade 로 등재된 것 = 위 5종 (NOREFLOW 4 RCT + LPA GalNAc). PON1 (DAPTPGX M16 🔴 FALSIFIED) · darapladib 는 DAPTPGX M16 deep-dive 의 🔴 이나 DAPTPGX V4 §2 30-claim ledger 의 V4 final 열에는 🔴 0 (PON1 은 M16 modifier 로 30-claim 분모 외부) — X8 은 V4 ledger 30-claim 분모 기준 DAPTPGX 🔴 = 0 carry (honest: PON1 🔴 는 M16 deep-dive 영역으로 V4 30-claim ledger 외부 closed-negative).

---

## §6. 합산 요약 ASCII — 🔵+🟢 (강한 근거) 현재 vs target escalation

```
📊 CARDIO+ 통합 g5 grade 분포 (4 sub-domain V4 합산 · filled)
─────────────────────────────────────────────────────────────────────────
🔵 SUPPORTED-FORMAL        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    1   ( 0.3%)
🟢 SUPPORTED-NUMERICAL     ███░░░░░░░░░░░░░░░░░░░░░░░░░░░   43   (12.4%)
🟡 SUPPORTED-BY-CITATION   ████████████████░░░░░░░░░░░░░  ~215  (61.9%)
🟠 INSUFFICIENT/DEFERRED   ███░░░░░░░░░░░░░░░░░░░░░░░░░░░   45   (13.0%)
🔴 FALSIFIED               ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    5   ( 1.4%)
⚪ SPECULATION-FENCED      ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░   31   ( 8.9%)
                                                          ─────
                                                          ~347+   (% of ~347)
─────────────────────────────────────────────────────────────────────────

🔵+🟢 (강한 근거) escalation trajectory:
─────────────────────────────────────────────────────────────────────────
  현재 filled         ████░░░░░░░░░░░░░░░░░░░░░░    44   (🔵 1 + 🟢 43)
                            ↓ bio-verify-kernel phase 2 PR + #658 + #665 merge
  PR merge 후 target  ████████░░░░░░░░░░░░░░░░░░   ~67~97  (🔵 23~53 + 🟢 ~44)
─────────────────────────────────────────────────────────────────────────
  단일 leverage = bio-verify-kernel phase 2 PR (X9 §7 순위 1)
    NOREFLOW 🔵 0→11 · DAPTPGX 🔵 0→4 · ISR 🔵 0→(7~28) + 🟢 0→(1~10) 동시
```

**escalation 정직성 note**:
- 현재 강한 근거 (🔵+🟢) = **44** (filled) — 분모 ~347 의 12.7%.
- PR merge 후 target = **~67~97** — 주 leverage = 단일 hexa-lang bio-verify-kernel phase 2 PR (NOREFLOW 11 + DAPTPGX 4 + ISR 7~28 🔵 동시 + ISR 1~10 🟢).
- 🟢 합산 (43) 은 PR 의존 없이 이미 land 된 강한 근거 — LPA (28) 가 최대 기여 (V3a/b/c + M12 pool dispatch 완료). PR merge 는 주로 🔵 escalation (현재 1 → 23~53) 에 작용.
- 🟡 ~215 (61.9%) = 도메인 본질적 floor — 인체 RCT/registry/guideline citation-locked (ISR 150+ 가 최대). 영구 carry (IPD 없이 closed-form 재현 불가).

---

## §7. g5 grade — X8 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 g5 rubric verbatim | 🟡 | NOREFLOW V4 §1.2 `hexa verify rubric` CLI stdout 그대로 |
| §2 마스터 ledger 표 | 🟢 | 4 sub V4 ledger count 산술 합산 (재현 가능) · DAPTPGX 표 불일치 honest range 표기 |
| §3 🔵 trajectory | 🟡 | 4 sub V4 placeholder + X9 §6.3 PR 의존 VERBATIM carry |
| §4 X1↔X8 reconcile | 🟢 | X1 §13 추정 ↔ V4 확정 산술 차이 (X4 §4.1 선례 따름) |
| §5 🔴 FALSIFIED 명세 | 🔴 | 4 sub V4 🔴 verdict + X9 §9 closed-negative VERBATIM |
| §6 escalation 요약 | 🟢 | 🔵+🟢 합산 산술 + PR target (X9 §7 leverage carry) |
| §7 X8 자체 grade | 🟡 (compositional) | 4 sub V4 grade VERBATIM 통합 — X8 새 판정 0건 |

**X8 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 4 sub V4 ledger / X1 / X4 / X9 verdict VERBATIM 합산. **새 등급 LLM self-judge 0건** (per @D g5). DAPTPGX 🟡 range (13~18) + LPA 🟢 (22 잠정 → 28 확정) 차이를 honest 명시 (count 충돌 시 V4 우선 · 불확실 시 추정 표기).

⚠ **honest count note**: (1) DAPTPGX V4 §1 분포표 (🟡 18) ↔ §2 per-claim ledger (🟡 13) 내부 불일치 — X8 은 13~18 range carry (숨기지 않음). (2) LPA 🟢 = V4 본문 28 (V3b land 후 확정) 우선, LPA.md 헤더 22 는 V3b 보류 전 잠정. (3) ISR 🟡 "150+" 는 V4 §3 atlas-registerable 추정 (PR-landed 0 · registerable 100%) — 정확 분모 미확정이라 "150+" 추정 표기 carry.

---

## §8. X7 입력용 1줄 요약 (교수님 1-page grade 한 문장)

> **CARDIO+ 4 sub-domain (no-reflow · DAPT-PGx · ISR · Lp(a)) 통합 ~347+ claim 중 강한 근거 (🔵 closed-form 1 + 🟢 numerical 43 = 44건, 12.7%) 가 현재 검증 완료되었고, 단일 hexa-lang bio-verify-kernel PR merge 시 🔵 1→23~53 escalation 으로 ~67~97건 (~25%) 까지 확장 가능하며, 나머지 ~215건 (62%) 은 인체 RCT/registry citation-locked (🟡 영구 carry), 5건은 large RCT null 로 정직하게 falsify (🔴), 31건은 가치판단·미래 trial·metaphor 로 honest fence (⚪) 되었습니다 — 모든 등급은 `hexa verify` verdict VERBATIM 합산이며 LLM self-judge 새 판정 0건입니다.**

---

## §9. X8 산출 요약

- **6-tier 총 합산 (filled)**: 🔵 1 · 🟢 43 · 🟡 ~215 (213~218) · 🟠 45 · 🔴 5 · ⚪ 31 (분모 ~347+)
  - NOREFLOW: 🔵 0(11ph) · 🟢 10 · 🟡 33 · 🟠 10 · 🔴 4 · ⚪ 15
  - DAPTPGX: 🔵 0 · 🟢 5 · 🟡 13~18 · 🟠 9 · 🔴 0 · ⚪ 3
  - ISR: 🔵 0(28pot) · 🟢 0(10pot) · 🟡 150+ · 🟠 22 · 🔴 0 · ⚪ 13
  - LPA: 🔵 1 · 🟢 28 · 🟡 17 · 🟠 4 · 🔴 1 · ⚪ 0
- **🔵+🟢 (강한 근거) escalation**: 현재 **44** filled → PR merge 후 target **~67~97** (🔵 1→23~53 + 🟢 43→~44)
  - 단일 leverage = hexa-lang bio-verify-kernel phase 2 PR (NOREFLOW 11 + DAPTPGX 4 + ISR 7~28 🔵 동시 · X9 §7 순위 1)
- **X1 추정 대비 가장 큰 reconcile 차이**: **🟢 +29** (X1 14 → X8 43) — X1 추정 시점 LPA 만 V3 land (🟢 14) 였고 NOREFLOW V3 (10) · DAPTPGX V3 (5) · LPA V3b+M12 (+14) 미반영. V4 확정 후 정량 (등급은 VERBATIM, 차이는 land 시점 차이)
- **🔴 5종 closed-negative** (wall 아닌 닫힌 음성): NOREFLOW 4 large RCT null + LPA GalNAc free-tool IP wall
- **honest fence**: ⚪ 31 (raw) = X4 와 정합 (X4 dedup 후 ~25) · DAPTPGX 🟡 range (13~18) + LPA 🟢 (22→28) count 불일치 정직 명시
- **g5 준수**: 모든 등급 sub-domain V4 / X1 / X4 / X9 verdict VERBATIM 합산 · **X8 새 판정 0건** · count 충돌 시 V4 우선 · 불확실 시 추정 표기

→ **다음 단계**: 본 X8 = X7 DOCTOR feed 의 단일 grade 진실 소스. 교수님 1-page (§8) + X10 figures (6-tier 분포 radar / 🔵+🟢 escalation bar) 입력. 단일 bio-verify-kernel phase 2 PR merge 가 🔵 1→23~53 escalation 트리거.
