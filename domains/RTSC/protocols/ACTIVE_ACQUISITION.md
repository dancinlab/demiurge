# 🎯 ACTIVE_ACQUISITION — next-action triage rule (info_gain / (cost+time))

**alias**: "활성 획득 triage" · "다음 1순위 자동 선택"
**date**: 2026-05-27 KST · **domain**: RTSC · **stage**: PROTOCOL (Tier-3 governance doc from /gap full diagnosis)
**governance**: d2 (wall → breakthrough paths) · d17 (cost-bearing fire) · g64 (sweep budget cap) · feedback-closure-is-physical-limit
**diagnosis trigger**: /gap full · F7 active-acquisition — h3br / polymorph / Li₂CuH₆ 3-axis priority 미정의. 본 protocol = next-action 선택 rule.

> **honesty 경계**: 본 rule = *heuristic priority* — 모든 cohort case 에 절대 적용되진 않는다. info_gain 산정은 *falsifier resolution count* 의 정성평가 (LLM-free 그러나 cohort-specific). 본 rule 의 산출물 = *입력 ranking*. final 선택은 인간 검토 + sibling protocol (VALIDATION_FIRST · CANDIDATE_SCORING) 결합.

---

## 1. wall recap — 왜 triage 가 필요한가

현재 RTSC cohort 의 *후속 action* 후보 (rtsc.md milestone L15-L18):

- (A) **h3br ω_log 향상 probe** (N5 breakthrough — stable·강λ 확보, ω_log bottleneck 만 남음)
- (B) **Mg₂IrH₆ polymorph escape** (저대칭 K₂PtCl₆ variant · soft-mode condensation · 🛰️ DISPATCH LIVE 2026-05-27)
- (C) **Li₂CuH₆ harvest** (q1-q2 verdict locked-imag · q3-q13 ph.x in-flight harvest)
- (D) **LaBeH₈ SSCHA anharm Tc** (harmonic 117K → anharm 보류 · SSCHA 후속)
- (E) X₂MH₆ family **가압 안정화** (P>0 GPa · d2 path 3 from Mg₂IrH₆ verdict)
- (F) **light-X cation clathrate** (axis 1·2·3 동시 충족 후보 — tropical isocontour §6)

priority 가 미정의 — /gap full 의 F7 진단: "3-axis priority 미정의". 본 protocol = info_gain / (cost+time) 의 multi-axis triage rule.

→ **rule 없이는 cohort 가 가장 큰 spending 또는 가장 친숙한 axis 로 치우친다**.

---

## 2. rule — `info_gain / (cost + time)` triage

**ranking score**:

```
rank_score = info_gain / (cost_USD + time_h × time_weight)
```

with:

- `info_gain` = (falsifier resolution count) + (cross-axis hypothesis test count) — 정성평가 (cohort-specific)
- `cost_USD` = dispatch USD (pool free = 0 · Vast/RunPod ≈ §3 표)
- `time_h` = expected wall-time hours (sequential bottleneck — 같은 hardware 다른 후보 큐 차단)
- `time_weight` = $/h equivalent (default = $1/h — pool 1 hour 가 next-cand 의 dispatch 지연이라는 *기회 비용*)

higher score = higher priority.

---

## 3. info_gain 정의 — 두 component

### 3.1 falsifier resolution count

dispatch 결과가 *어느 hypothesis 를 resolve* 하는지 카운트:

- ✅ "결과 r 이면 hypothesis H 가 falsified" 가 dispatch 전에 *예측 가능* 한 경우 → +1
- ✅ "결과 r 이 hypothesis H 의 사다리 다음 위치를 *결정*" → +1
- ❌ "어느 결과도 가설을 못 falsify" (cohort burn) → 0

**precedent**:
- Mg₂IrH₆ ambient (2026-05-26): falsifier resolution 2 (cation-VEC=19 충분조건 가설 + K₂PtCl₆ Fm-3m 동역학적 안정 가설). 둘 다 closed-neg locked.
- Li₂CuH₆ ambient (2026-05-27): falsifier resolution 1 (X₂MH₆ Fm-3m prototype 전체 *2/2* falsified → prototype 자체 의문). Mg₂IrH₆ 직후 Li₂CuH₆ 의 *추가* info_gain 은 작음 (같은 axis).

### 3.2 cross-axis hypothesis test count

같은 dispatch 가 *복수 axis* 의 hypothesis 를 동시 test 하면 +N:

- 1-axis: 한 hypothesis 만 test → +1
- 2-axis: 화학 axis + topology axis 동시 → +2
- 3-axis: 화학 + topology + pressure 동시 → +3

**precedent**:
- h3br ω_log probe (lighter substitution): group-17 axis + σ-plateau axis 동시 test → +2
- LaBeH₈ SSCHA: anharmonic axis + h3o pattern 검증 axis + isocontour axis 3 → +3
- Li₂CuH₆ ambient (post-hoc): K₂PtCl₆ axis + cation-VEC axis 동시 → +2 (but Mg₂IrH₆ 의 결과 이후 K₂PtCl₆ axis 의 *증분 info* 는 작음 → effective +1)

**총 info_gain** = falsifier resolution count + cross-axis hypothesis test count.

---

## 4. cost · time table — hardware tier

| hardware | cost_USD/h | typical wall_h (4³q DFT chain) | bottleneck |
|---|---|---|---|
| pool ubu-1/2 (free) | 0 | 12-25 h (single chain) · 25 h (parallel 2-chain at -np 6) | ubu-1/2 6-core | 
| Vast.ai CPU (16-32 vCPU) | $0.10-0.30/h | 8-15 h | CPU thrash if oversub |
| Vast.ai GPU (RTX/A100) | $0.50-2.50/h | 1-5 h (full chain) | OOM if cell >20 atoms |
| RunPod CPU | (8 vCPU ceiling — avoid) | N/A | d7 미적합 |
| RunPod GPU | $0.80-3.00/h | 1-5 h | $-cap |

**기회비용 시간 가중치** (`time_weight`): pool 1 시간 ≈ next-cand 의 dispatch 지연. cohort 의 다음 가장 promising action 의 *score* 이 (다음 1 시간) 대기로 줄어드는 비례 — heuristic 으로 $1/h ($1/h × time_h = time cost proxy).

---

## 5. 현재 cohort 적용 — 6 action ranking

(2026-05-27 KST 기준; ACTIVE_ACQUISITION 가 protocol 화 되는 시점)

| # | action | info_gain | cost_USD | time_h | rank_score | rank |
|---|---|---|---|---|---|---|
| A | **h3br pscan** (ω_log 향상 probe, 압력/lighter sub) | **2** (group-17 + σ-plateau) | **0** (pool ubu free) | 12 | **2/12 = 0.167** | **1** |
| B | **Mg₂IrH₆ polymorph escape** (h3as method transfer · DISPATCH LIVE) | 2 (R3m escape mechanism + Ir-H covalent rigid axis) | 0 (pool ubu-2 free) | 12-25 | 2/18.5 ≈ **0.108** | 2 |
| E | **Li₂CuH₆ harvest** (verdict already locked partial · q3+ harvest only) | 1 (X₂MH₆ Fm-3m 2/2 falsified 봉합 only · same axis) | 0 (pool free, ph.x already in-flight) | 5-10 (harvest only · ph.x 완주 대기) | 1/7.5 ≈ **0.133** | 3 |
| D | **LaBeH₈ SSCHA** (anharm Tc 확정 · h3o pattern 검증) | 3 (anharm + h3o pattern + isocontour axis 3) | ~$50 (Vast GPU 25h × $2/h) | 25 | 3/75 = **0.040** | 5 |
| F | **light-X cation clathrate** (Mg₂CuH₈ 류 · axis 1·2·3 동시) | 3 (cation chem + clathrate topology + light-X) | 0 (pool free initial) | 25 (4³q + vc-relax) | 3/25 = **0.120** | 4 |
| E' | X₂MH₆ **가압 안정화** (Mg₂IrH₆ @50 GPa) | 2 (pressure ↑ → stiffen ⟨ω²⟩ axis + retain VEC=19 chem) | 0 (pool free) | 25 (4³q) | 2/25 = **0.080** | 6 |

**rank 1**: **h3br ω_log 향상 probe** (rank_score 0.167)

→ N5 wall 의 ω_log bottleneck axis 의 직접 probe — `h3br + lighter substitution (e.g. h3br_high-P deck @50 GPa with ω_log 강화)` 또는 *H3-X composition perturbation*. stable·강λ 의 후보가 *ω_log axis 만 남았다* 는 wall redefinition (N5_wall_redefinition.md) 의 후속 milestone (rtsc.md L18).

---

## 6. tie-break rule — 같은 score 면

```
if rank_score 가 같으면:
  1. lower cost_USD 우선
  2. lower time_h 우선
  3. higher cross-axis count 우선 (information diversity 우선)
  4. (final) cohort-leader 의 manual call
```

(현재 cohort 에 tie 없음 — A=0.167 > E=0.133 > B=0.108 > F=0.120 > E'=0.080 > D=0.040)

---

## 7. d17 cost-bearing fire interplay

본 protocol 은 d17 (autonomously dispatch, no user gate) 과 정합:

- rank 1 action 의 cost_USD ≤ $5 (small-cell pool free) → **자동 fire**
- rank 1 의 cost_USD > $5 → 한 줄 estimate 보고 후 fire (d17 — no approval)
- 단, rank_score < 0.05 (heuristic threshold) → fire 보류 + cohort review 트리거 (info_gain 너무 작음, *axis stagnation* 신호)

**현재 rank 1** (h3br pscan, $0) → **자동 fire OK**.

---

## 8. closed-loop — 매 LANDED 마다 재triage

매 후보가 LANDED (verdict locked) 후:
1. `rank_score` 표 재계산 (info_gain 갱신 — falsifier 가 닫혔으므로 새 hypothesis 도출 시 변동)
2. next rank 1 action 식별
3. CANDIDATE_SCORING 의 `composite_score` 와 비교 (cross-check)
4. fire

**F5 closed-loop fixpoint** (gap diagnosis 의 *원래 갭*): 본 protocol 이 매 LANDED 마다 재triage → next-cand 자동 선택 = closure 정착.

---

## 9. cross-ref

- `RTSC/protocols/VALIDATION_FIRST.md` — selected action 의 dispatch 4 gates (본 rank 1 도 적용)
- `RTSC/protocols/CANDIDATE_SCORING.md` — composite_score (info_gain 의 quantitative refinement)
- `RTSC/walls/tropical_isocontour.md` — 3-axis 동시 충족 평면 (rank 의 cross-axis count 의 가치 평가)
- `RTSC/walls/N5_wall_redefinition.md` — λ-saturated → ω_log bottleneck → h3br pscan rank 1 의 근거
- `domains/rtsc.log.md` — Mg₂IrH₆ polymorph escape DISPATCH LIVE 2026-05-27 (B action live state)

---

## 10. status

- **status**: PROTOCOL ACTIVE (이 PR 이후 매 LANDED 후 다음 fire 전 rank 표 재계산 mandate)
- **next 1순위 action (2026-05-27 KST)**: **h3br ω_log 향상 probe** (rank_score 0.167, cost $0 pool free, 12 h wall)
- **honesty**: §6 tie-break + §7 d17 interplay 명시 · rank 표는 *입력*. 최종 fire 는 cohort review (LLM-free recompute + 인간 ack).
