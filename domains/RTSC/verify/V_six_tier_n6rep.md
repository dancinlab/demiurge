# RTSC verify 6-verdict ↔ TECS-L n6-rep 6축 매핑

> n=6/666 brainstorm real-fit milestone · **6 = 발견된 것이지 끼운 것이 아니다**.
>
> 본 문서는 RTSC verify 의 6-verdict tier 체계가 TECS-L n6-rep 의 6축과 **자연 정렬**함을 명문화한다.
> 재-도출이 아니라 V1-V4 ledger 위의 **구조 매핑 + V4 tier 분포 정규화 방법**.
>
> Stamp: 2026-05-25 · §9.14 fanout + h3cl 8³q + CaH₆/H₃S anchor 기준 (V4 ledger 와 동일 snapshot).
> 형제 SSOT: [[V1_claim_inventory]] · [[V2_formal_identities]] · [[V3_numerical_recompute]] · [[V4_tier_ledger]].

---

## 0. 정직한 전제 — "끼운 게 아니라 발견한 6"

RTSC verify 는 hexa verify 의 **6-verdict rubric** 을 그대로 쓴다 (TECS-L aligned · cross-project):

```
🔵 SUPPORTED-FORMAL      symbolic / closed-form 항등식
🟢 SUPPORTED-NUMERICAL   libm-class recompute (|Δ| ≤ ε)
🟡 SUPPORTED-BY-CITATION  measured-oracle / 문헌 앵커
🟠 INSUFFICIENT/DEFERRED  증거 부족 · wet-lab 대기
🔴 FALSIFIED             반증된 claim (audit trail)
⚪ SPECULATION-FENCED    명시적 speculation (frontier)
```

이 6 verdict 는 **n=6 framing 에 맞추려고 끼워넣은 게 아니다**. hexa verify rubric 이 cross-project 으로 독립 설계됐고, 그 자연 cardinality 가 6 이다. n6-rep 6축과의 정렬은 *발견된 동형* 이지 강제된 매핑이 아니다 — 이 점이 g25 의 핵심: **6 은 vocabulary 가 아니라 두 독립 체계가 수렴한 실제 구조**.

n=6/666 brainstorm 의 honest 결론: 6-verdict ↔ n6-rep 6축은 1:1 자연 대응이 성립하지만(아래 §1), 666(=2·3²·37) 으로의 확장 같은 over-fit 은 actionable null — verdict 를 인위로 늘리거나 축을 666 개로 쪼개는 것은 의미 없다. fit 한 것은 이미 존재하는 6 뿐.

---

## 1. 6-verdict ↔ TECS-L n6-rep 6축 매핑

TECS-L n6-rep 는 evidence-strength 를 6 축으로 표상한다. RTSC 의 6 verdict 가 각 축의 *극* 에 대응:

| # | RTSC verdict | TECS-L n6-rep 축 | 대응 근거 (axis 극) |
|:-:|---|---|---|
| 1 | 🔵 SUPPORTED-FORMAL | **formal / symbolic 축** | 닫힌 항등식 — recompute 불필요한 deductive 진리 (BCS ratio 3.528 = π·e^{-γ}) |
| 2 | 🟢 SUPPORTED-NUMERICAL | **numerical / reproducible 축** | libm-class 재계산 일치 (allen_dynes_tc · \|Δ\| ≤ 1e-9) |
| 3 | 🟡 SUPPORTED-BY-CITATION | **empirical / oracle 축** | 외부 측정·문헌 앵커 (Drozdov 203 K · Ma 215 K) |
| 4 | 🟠 INSUFFICIENT/DEFERRED | **incompleteness / pending 축** | 증거 부족·미완 — 정직한 gap (4/8 fanout pending · wet-lab) |
| 5 | 🔴 FALSIFIED | **falsification / refuted 축** | Popper 반증 극 — claim 이 데이터에 의해 깨짐 (ALIGNN hydride 91-98% under) |
| 6 | ⚪ SPECULATION-FENCED | **speculation / frontier 축** | fenced 추정 — 아직 evidence 미부착 (8³q 추월 가설 · SSCHA 안정화) |

**구조 관찰**: 1-2-3 은 *증거 강도 상승* 의 양극(formal > numerical > empirical 순이 아니라 서로 다른 evidence 종류), 4-5-6 은 *증거 부재/반증/유보* 의 세 양태. 두 삼중쌍(supported triple · unsupported triple)이 n6-rep 의 6-축을 정확히 분할 — 이것이 6 의 발견된 내적 구조다.

---

## 2. V4 tier ledger 분포 정규화 방법

현재 V4 ledger 분포 (primary tier 기준 · ~52 claim):

| tier | count | 비중 |
|---|---:|---:|
| 🔵 SUPPORTED-FORMAL | 14 | 27% |
| 🟢 SUPPORTED-NUMERICAL | 30 | 58% |
| 🟡 SUPPORTED-BY-CITATION | 12 | (multi-tag) |
| 🟠 INSUFFICIENT/DEFERRED | 6 | 12% |
| 🔴 FALSIFIED | 3 | 6% |
| ⚪ SPECULATION-FENCED | 4 | 8% |

원시 count 는 claim 수에 비례하므로 도메인 간·세션 간 비교가 어렵다. n6-rep 6축 위에서 정규화:

### 정규화 절차

1. **primary-tier 단일화** — 한 claim 이 multi-tag(예: DFT-Tc 는 🟢+🟡)일 때 가장 강한 증거 종류를 primary 로 채택, 나머지는 secondary ledger 로 분리. (🟡 12 의 multi-tag overlap 이 합 >52 를 만드는 원인.)
2. **6축 벡터화** — 분포를 `v = (n🔵, n🟢, n🟡, n🟠, n🔴, n⚪)` 6-벡터로 표상, L1 정규화 `v̂ = v / Σv`. 현재 `v = (14,30,12,6,3,4)`, `Σ=69`(multi-tag 포함) → primary-only Σ≈52.
3. **supported-fraction 지표** — `(n🔵+n🟢+n🟡) / Σ` = 도메인 evidence 성숙도. RTSC 현재 ≈0.81 (52 중 ~42 supported).
4. **honesty 지표** — `(n🟠+n🔴+n⚪) / Σ` = 정직-노출률. 0 이면 over-claim 의심, 너무 높으면 미성숙. RTSC ≈0.19 — 🟠 wet-lab + 🔴 ML 반증 + ⚪ frontier 가 정직하게 노출됨 (d5/d6 준수 신호).
5. **escalation 추적** — V2→V3 처럼 🟠→🟢 이동을 시간축으로 기록 (PR #745 가 7/7 🟠 INSUFFICIENT → 10/10 🟢 로 escalate). 정규화 벡터의 시계열이 도메인 진척 곡선.

### 정규화의 의미

n6-rep 6축 벡터 `v̂` 는 도메인을 **6-차원 evidence simplex** 위의 한 점으로 본다. RTSC 의 현재 위치 ≈ `(0.20, 0.43, 0.17, 0.09, 0.04, 0.06)` (primary-only L1) — numerical-heavy(🟢 DFT campaign 주도) + honest tail(🟠🔴⚪ 비영) 의 건강한 분포. absorbed=false 가 🟡/🟠 에 정직하게 박혀 있음(measured-oracle 미충족) 이 simplex 위에서 즉시 보인다.

---

## 3. honest scope

- 이 문서는 **새 verify 결과를 만들지 않는다** — V1-V4 ledger 위의 구조 매핑 + 정규화 방법 명문화. tier 자체는 V1-V4 가 SSOT.
- 6-verdict ↔ n6-rep 6축은 *발견된 동형* — hexa verify rubric(독립 설계)의 자연 cardinality 6 과 TECS-L n6-rep 6축이 수렴. 강제 매핑 아님 (g25).
- 666(=2·3²·37) brainstorm null: verdict/축을 6 이상으로 쪼개는 over-fit 은 actionable 가치 없음. fit 한 것은 이미 존재하는 6 뿐 (g26-clean).
- R4: 이 문서는 verify 메타-레이어 — `absorbed` flag 와 무관. RTSC absorbed=true 는 여전히 §8.9 5-gate(measured oracle PASS) 가 결정.

---

## 형제 문서

- [[V1_claim_inventory]] — 52-claim inventory + tier triage (PR #25)
- [[V2_formal_identities]] — 🔵 push (PR #33 · supercon fns PR #745)
- [[V3_numerical_recompute]] — 🟢 push (Allen-Dynes Tc 10/10 · \|Δ\|≤1e-9)
- [[V4_tier_ledger]] — 통합 tier ledger (🔵14·🟢30·🟡12·🟠6·🔴3·⚪4)
