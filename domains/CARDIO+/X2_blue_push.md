# X2 — CARDIO+ cross-domain 🔵 push (honest formal-tier 평가 + atlas trajectory)

> CARDIO+ 메타도메인 X2 산출물 · current-state · no history.
> 목적 = 4 sub-domain 의 🔵 SUPPORTED-FORMAL 도달 가능성을 **mini 실측으로 honest 평가** + atlas 등록 trajectory 명시.
> ⚠ 핵심 정직성(d6): bio/clinical claim 을 목표 숫자 맞추려 🔵 로 강제하지 않는다. 🔵 = number-theory closed-form 전용 — bio fn 천장은 🟢. 본 X2 는 "🔵 몇 개" 가 아니라 "🔵 가 honest 하게 어디까지인가 + 어떻게 확장되는가" 를 닫는다.

---

## §1. mini 실측 — tier 천장 (2026-05-25 · `POOL_DISABLE=1`)

X2 blocker 였던 `hexa verify --expr` ubu-2 segfault 를 **mini(local)에서 우회** 하고, tier 천장을 직접 측정:

```
(a) genuine number-theory closed-form
$ hexa verify --expr sigma_k 6 1 12
  calc = 12 == expected 12
  tier = 🔵 SUPPORTED-FORMAL   (hexa-native closed-form, g_self_verify · TECS-L Tier1)

(b) bio MR estimator (no atlas path)
$ hexa verify --expr ivw 3 1
  tier = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'ivw'
  gap    = extend tool/verify_cli.hexa::_recompute

(c) bio dose-response (libm recompute path)
$ hexa verify --expr hill 0.5 0.001 1 0.998003992015968
  tier = 🟢 SUPPORTED-NUMERICAL   (hexa-native libm-class recompute)
```

→ **3가지 결론**:
1. **segfault 우회 입증** — mini 에서 `--expr` 정상 작동, 🔵 까지 도달 (ubu-2 불필요).
2. **🔵 = number-theory 전용** — `sigma_k` 등 closed-form 산술만 🔵. 
3. **bio fn 천장 = 🟢 또는 🟠** — libm 경로 있으면 🟢(`hill`), 없으면 🟠(`ivw`). **bio claim 은 auto-🔵 불가** (g5 rubric: "atlas/literature carry — never auto-🔵").

---

## §2. 현재 🔵 = 1 (honest)

| sub | 🔵 claim | 종류 | 근거 |
|---|---|---|---|
| LPA | C30 sigma sanity | number-theory closed-form | atlas-attested (X8 verbatim) |
| NOREFLOW | 0 | — | bio kernel = 🟢 (11 placeholder 는 atlas-PR 의존) |
| DAPTPGX | 0 | — | HW 항등식은 🟢 partition (closed-form이나 atlas 미등록) |
| ISR | 0 | — | bio-physical = kernel PR 의존 |

→ cross-domain 🔵 = **1** (X8 §1 ledger 정합). 이게 honest 현재값 — 무리한 inflation 없음.

---

## §3. bio claim 이 🔵 못 가는 이유 (구조적)

atlas surface (mini · `hexa atlas stats`): 16,082 nodes · F formulas 1,330 · 모두 **number-theory / physics canonical**. bio/clinical fn (`ivw` · `hill_mptp` · `pk_2comp` · `power_2sample`)은 atlas F-namespace 미등록 → `--expr` 가 "NO path" (🟠) 또는 libm 재현만 (🟢).

```
claim 종류        verify 경로                      천장
─────────────────────────────────────────────────────
number-theory  → atlas closed-form recompute   → 🔵 ✅
bio + libm fn  → hexa-native libm recompute     → 🟢 (auto-🔵 불가)
bio, no path   → calculator NO path             → 🟠 INSUFFICIENT
```

핵심: Hill 식·IVW estimator·2-comp PK 는 수학적으로 closed-form 이지만, **atlas 에 formal atom 으로 등록되어야** 🔵. 등록 전엔 g5 rubric 상 🟢 가 정직한 천장.

---

## §4. 🔵 trajectory — atlas 등록 PR (d2 breakthrough)

🔵 escalation = bio fn 을 atlas F-namespace 에 formal atom 으로 등록하는 hexa-lang PR. merge 후 **mini 에서 `--expr` 등록 가능** (ubu-2 segfault 무관 — §1 입증).

| atlas-PR (hexa-lang) | 등록 fn | 잠재 🔵 (merge 후) | 현재 상태 |
|---|---|---|---|
| PR #658 noreflow-clinical-calc | `hill_mptp` · `salvage_exp` · `pk_2comp` · `power_2sample` | NOREFLOW +~4 (V3.1/3.2/3.4) | OPEN (X9 N2) |
| PR #665 / `ivw(k)` fn | `ivw` MR estimator | LPA +3 (C22/C23/C44) | proposed (LPA V3b §6) |
| PR #707/#711 bio kernel | (이미 8 fn 🟢) → formal 등록 시 | ISR/NOREFLOW bio identity | phase1/2 land · phase3 pending |

→ 누적 🔵 target (atlas-PR merge 후): **1 → ~8-15** (X8 trajectory 의 보수 추정 ~23-53 중 hill/ivw/pk_2comp 계열). **단일 leverage = bio-verify-kernel + atlas F-namespace 확장 PR** (X9 §7 순위 1 과 정합).

---

## §5. d2 breakthrough 요약 (X2 blocker 종결)

| blocker | 상태 | 돌파 |
|---|---|---|
| `hexa verify --expr` ubu-2 segfault | ✅ **우회 완료** | mini(local) 에서 정상 — 모든 X2/X3 verify 는 mini 라우팅 (`POOL_DISABLE=1`) |
| bio fn auto-🔵 불가 | 구조적 (g5 정직) | atlas F-namespace 등록 PR (§4) — bio fn → formal atom |
| ubu-1 `hexa.real` 누락 | ❌ 미해결 | hexa-lang/inbox/patches (d8) handoff 후보 — pool 정상화 |

⚠ 인프라 회귀 2건(ubu-2 segfault · ubu-1 wrapper)은 hexa-lang 소관 → inbox patch handoff (PR #750 계열). **단 X2 milestone 자체는 mini 우회로 non-wet-lab completed-form 달성** (d1) — 🔵 현재 1 + 명확한 atlas trajectory + segfault 우회 입증.

---

## §6. g5 verdict table

| 항목 | 등급 | 근거 |
|---|---|---|
| `sigma_k(6)=12` 🔵 실측 | 🔵 SUPPORTED-FORMAL | mini stdout verbatim §1 |
| `ivw` no-path | 🟠 INSUFFICIENT | mini stdout verbatim §1 |
| `hill` libm recompute | 🟢 SUPPORTED-NUMERICAL | mini stdout verbatim §1 |
| 현재 cross-domain 🔵 = 1 | 🟡→집계 | X8 ledger verbatim (LPA C30) |
| bio fn 🔵 trajectory | 🟠 DEFERRED | atlas-PR merge 의존 (§4) |
| segfault mini 우회 | (운영 사실) | §1 실측 |

🔑 X2 결론: 🔵 push 의 honest 천장은 **number-theory 전용**이고 bio claim 은 🟢 가 정직한 상한. ubu-2 segfault blocker 는 mini 우회로 해소 — 🔵 escalation 은 이제 "호스트 문제" 가 아니라 "atlas 등록 PR" 문제로 환원됨 (hexa-lang lane). 억지 🔵 inflation 없이 milestone completed-form.

## ref
- mini 실측: `POOL_DISABLE=1 hexa verify --expr {sigma_k,ivw,hill}` · `hexa atlas stats`
- sub-V: LPA V3b §6 · NOREFLOW V3 §4 · X8 grade ledger · X9 §7 leverage
