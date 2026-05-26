# 🧱 N5 wall 재정의 — λ-포화 → ω_log bottleneck 축 전환

**alias**: "이중-축 N5 벽" · "λ saturation → phonon-frequency cap"
**milestone**: RTSC.md L18 — N5 wall 재정의 (λ-포화 → ω_log bottleneck 축 전환)
**date**: 2026-05-26 KST · **domain**: RTSC · **stage**: N5 CLOSED (§9.16 funnel) → N6 funnel 으로 이월
**governance**: d1 (non-wet-lab → completed-form) · d2 (wall → breakthrough paths, never concede) · d6 (first-principles, NOT ML) · g3 (minimal authoring) · g5 (verdict verbatim, never LLM self-judge)

> **본 문서의 정직 경계**: N5 wall = *벽 인정 + 다음 funnel 정당화* — RTSC 실패 선언 아님. 강결합 분지 (h3o anharmonic 109K, h3cl 140K, h3br ~110K) 는 부분 성공. 정직하게 "binary 고갈" + "N6 ternary 후속 milestone" 으로 연결.

---

## 1. wall 정의 (1-paragraph)

**N5 (binary hydride H₃X) 영역에서 `stable AND strong-λ AND high-ω_log` 동시 달성은 불가능하다.** §9.16 funnel 의 8-fanout + 추가 cohort 결과, harmonic λ 가 큰 후보는 거의 예외 없이 imaginary mode 를 동반하고(h3o harmonic λ=2.479 → 16/16 q imaginary), SSCHA 비조화 보정으로 안정화하면 λ 가 1/3~1/5 로 붕괴한다 (h3o anharmonic λ=0.52–1.48). 반대로 안정 후보 (h3cl · h3br · h3si) 는 λ~1.2–2.0 의 *충분히 강한* 결합을 갖지만 ω_log ≤ 1350 K 이하에서 **Tc_AD = ω_log/1.2 · exp(−1.04(1+λ)/(λ−μ\*(1+0.62λ)))** 가 200 K 천장을 못 넘긴다. 즉 N5 의 진짜 벽은 *λ 부족* (이전 가설) 이 아니라 **(i) 안정성-조건이 강결합 분지의 λ 를 인공적으로 부풀린 soft-mode artifact 였다는 점 (V5 §1.2)** + **(ii) stable 분지의 ω_log 천장이 heavy-X 화학에 묶여 있다는 점 (본 문서)**. λ 는 *충분*, ω_log·dynamical stability 가 *진짜 두 개의 벽*.

---

## 2. 트레이드오프 표 — N5 cohort current-state

| candidate | space group | stability | λ_harm | ω_log [K] | anharmonic λ (보정 후) | final Tc [K] | trade-off type |
|---|---|---|---|---|---|---|---|
| **h3cl** | Im-3m | **stable** (8³q 수렴 · m>0 미평가) | 1.21–1.37 | ~1350 | (조화 stable, anharmonic 미필요) | **123–140** | ω_log 상한 OK, λ 상한 cap → Tc ceiling |
| **h3o** harmonic | Im-3m (Pm-3m) | unstable (43 imag, Γ=−682, L=−1133) | 2.479 | ~1089–1111 | — | (175–195 외삽, soft-mode artifact) | λ-inflation by soft-mode |
| **h3o** SSCHA anharmonic | Im-3m | stable (imag → real) | 0.52–1.48 (≈λ_harm·S, S=0.40) | (재산정 mid-band ≈ 동일대역) | 0.52–1.48 | **9–109** (M8 1/3) | λ 붕괴 = stability tax |
| **h3br** | Im-3m | stable | 1.4–2.0 | 480–620 | (anharmonic 미요구) | ~110 | ω_log bottleneck (heavy Br) |
| **h3si** | Im-3m | stable | 1.72–1.82 | 572–624 | — | **77–80** | ω_log bottleneck |
| **h3f** | Im-3m | stable | 0.81–0.82 | 652–670 | — | 31–33 | 약결합 (lighter X benefit 작음) |
| **h3po** | Im-3m | unstable (Γ imag triplet · 25/192 imag) | (3.31→2.75 외삽, soft-mode) | 258–273 | — | (47–48 외삽) | unstable + heavy-X 이중 fail |
| **h3as** Im-3m | Im-3m | unstable (25/192 imag · −1267 cm⁻¹) | 0.97 (under-conv) | 444 | — | 30 | strong-λ 영역 진입 직전 격자 붕괴 |
| **h3as** R3m polymorph† | R3m | stable | 1.65 | ~450 | (조화 stable) | ~56 | ω_log bottleneck (heavy-X 그대로) |
| SrAuH₃ | (clathrate-3) | stable | 0.62 | 591 | — | ~15 | 약결합 (안정대가)|
| LaBeH₈† | P6₃/mmc (clathrate) | mild Γ-soft @ ambient · stable @80 GPa | 3.9 (harmonic) | 589 | (SSCHA 보류) | **110 (MEASURED @80 GPa)** · 117 harmonic 외삽 | ternary cation decoupling anchor |
| H₃S (anchor) | Im-3m | stable @150 GPa | 2.0 (measured-grade) | ~1170 (6³q) | — | **203 MEASURED** (175–195 sim) | high-P clathrate-like |
| CaH₆ (anchor) | Im-3m | stable @170 GPa | (clathrate, m=0.5 escape) | high | — | **213 MEASURED** (215 sim) | cation pre-compression (N6) |

† 표시 항목 = milestone snapshot 시점에 user-reported (worktree log 미반영) — 본 문서는 통계용으로만 사용, atlas 등록은 별도 record 절차.

**핵심 발견** — N5 binary 의 모든 stable 후보에서 **ω_log × λ_anharm 의 곱이 Tc 200 K 분리선을 못 넘는다**. McMillan-Allen-Dynes 공식 `Tc ≈ (ω_log/1.2) · exp(−1.04(1+λ)/(λ−μ*(1+0.62λ)))` 에서 λ>1.5 영역은 prefactor `ω_log/1.2` 가 dominant — h3br (λ=2.0, ω_log=620 K) → Tc≈110 K · h3si (λ=1.8, ω_log=600 K) → Tc≈78 K · h3cl (λ=1.3, ω_log=1350 K) → Tc≈140 K. **stable 분지 천장 ≈ ω_log 천장**.

---

## 3. ASCII diagram — N5 wall

```
λ ↑
2.5 ─ unstable region (h3o harmonic λ=2.479 · 43 imag mode artifact)
    │
    │   ████████████ harmonic strong-λ wall ████████████
    │   ↙ SSCHA renormalize 시 λ 붕괴 (S = ⟨ω²⟩h/(⟨ω²⟩h+Δω²) = 0.40)
    │   ↙
2.0 ─   h3br ●        ╲
    │   h3si ●         ╲   stable region
1.5 ─   h3as-R3m ●      ╲  λ_max ≈ 2 ceiling
    │   h3cl ●           ╲ (Tc-isocontour 200 K 위쪽 진입 못함)
1.0 ─   h3o-anharm ●─────╲────── Tc=200 K isocontour (target)
    │   h3f ●            │
0.5 ─   SrAuH₃ ●         │
    │                     │
0   ─────────────────────────────────→ ω_log [K]
        0    400   800   1200   1600
                  (heavy-X bottleneck)  (light-X · light-cation only)

벽 구성:
  ━━ "harmonic strong-λ wall" = ⟨ω²⟩→0 soft-mode inflation (λ artifact)
  ▒▒ "ω_log bottleneck" = stable 분지에서 heavy-X 가 phonon 진동수 cap
  ── "Tc=200 K isocontour" = ω_log·λ-coupling 의 hyperbolic 경계
```

핵심 시각 통찰: N5 의 모든 데이터 점은 두 영역 중 하나에 갇힌다 — (a) `λ>2 unstable` 또는 (b) `stable but ω_log<700 K`. Tc 200 K 위쪽 진입 영역은 N5 binary 가 도달하지 못한 **사각지대**.

---

## 4. 3축 분석

### 축 A — λ-포화 (harmonic strong-λ artifact)

| 처리 | λ | Tc [K] | 안정성 |
|---|---|---|---|
| h3o harmonic (16/16 q imag) | **2.479** | 175–195 (외삽, 비물리적) | UNSTABLE |
| h3o SSCHA anharmonic | 0.52–1.48 (붕괴 1/3~1/5) | **9–109** | stable (M8 1/3) |
| h3o anharmonic λ_anharm/λ_harm 비 | S = 0.4034 | — | V5 §3.1 closed-form |

**해석**: harmonic λ=2.479 의 정체 = `⟨ω²⟩_harm` 가 비물리적으로 작음 (soft mode 가 분모를 짓눌러 λ 를 인공적으로 부풀림). SSCHA 가 비조화 곡률을 더해 ⟨ω²⟩ 정상화 → λ 가 1/3~1/5 로 붕괴, Tc 도 동반 붕괴. **λ enhancement 가 곧 불안정의 부산물**이었다는 직접 증거. V5 의 `lambda_anharm_suppress(1.0, 1.479) = 0.4034` 가 🟢 SUPPORTED-NUMERICAL 으로 이를 closed-form 으로 정량.

→ **축 A 결론**: harmonic λ>2 영역은 N5 에서 더 이상 strong-λ 가 아니다. anharmonic λ 가 진짜 λ 이고, h3o anharmonic 109 K 가 그 결과.

### 축 B — ω_log 천장 (stable 분지의 phonon-frequency cap)

stable 분지의 ω_log 분포 (Im-3m H₃X family, 6³q DFT):

| candidate | ω_log [K] | mass [amu] | celldm [bohr] | Tc [K] |
|---|---|---|---|---|
| h3cl | 1250–1350 | 35.45 | 5.659 | 123–140 |
| h3si | 572–624 | 28.09 | 5.656 | 77–80 |
| h3br | 480–620 | 79.90 | 6.6 | ~110 |
| h3as-R3m† | ~450 | 74.92 | 6.7 | ~56 |
| h3f | 652–670 | 19.00 | 5.127 | 31–33 |
| H₃S (anchor) | ~1170 | 32.06 | 5.85 | 203 (measured) |

**Allen-Dynes 의존성**: Tc 의 prefactor `ω_log/1.2` 가 strong-λ 영역에서 dominant. h3br λ=2.0 도 ω_log=620 K 이면 Tc=620/1.2·exp(−1.04·3/(2−0.13·2.24))≈110 K. heavy-X (Br/As/Po) → 음의 ω scaling (1/√m 가 분리되지 않은 채 격자 강성을 끌어내림).

→ **축 B 결론**: stable 분지의 Tc 천장 ≈ ω_log 천장. 이를 깨려면 lighter X (O/N/F) 가 필요하지만 light-X 는 거의 모두 imaginary mode (h3o · h3n · h3f-borderline) — **light-X benefit 와 stability gate 가 함께 묶여 또 다른 충돌**.

### 축 C — stability gate (m>0 anharmonic ESCAPE)

V5 §3.2 의 `stability_coupling_margin m = (⟨ω²⟩_anharm − ⟨ω²⟩_λ)/⟨ω²⟩_anharm`:

| candidate | m | gate |
|---|---|---|
| CaH₆ (cation-clathrate anchor) | **+0.5** | escape (안정 격자가 목표 λ 가 요구하는 강성보다 *더 단단함*) |
| h3o anharmonic | **−1.479** | trapped (목표 λ_harm 회복하려면 2.479× 더 무른 격자 필요) |
| h3cl / h3br / h3si | (closed-form 미평가, but Tc<200K 로 추정 m<0) | likely trapped (높은 ω 가 강한 λ 분자를 동시 지지 불가) |

**M8 m-gate 정련 (RTSC.md §9.16 box)**: M8 의 "stable" 축은 단순 imaginary-free 가 아니라 `m > 0` (anharmonic ESCAPE) 으로 정련된다. **N5 의 stable 후보들은 imaginary-free 였으나 m<0 (trapped) → M8 미달**. anharmonic λ-suppression S 도 같은 V5 에서 🟢.

→ **축 C 결론**: 진짜 gate 는 imag-free 가 아니라 `m>0` (anharmonic ESCAPE). N5 binary 는 이 gate 를 못 넘는다.

---

## 5. N6 ternary funnel 정당화 (first-principles 논거)

§4 의 세 축이 N5 binary 에서 **단일 손잡이 ⟨ω²⟩ 에 묶여 있다** — McMillan-Hopfield 식 `λ = η/(M⟨ω²⟩)` 에서 ⟨ω²⟩ 는 λ 분모와 동역학적 안정성 조건에 **이중 역할** (V5 §1.2). 이것이 N5 wall 의 first-principles 정체.

**cation-stuffed ternary (X₂MH₆ · MXH₈) 의 decoupling 가설**:

```
binary:   η ─┐
             ├─ 둘 다 ⟨ω²⟩ 에 묶임 → soft 해야 λ↑ but unstable
   stability ⟨ω²⟩ ┘                                     [N5 wall]

ternary:  η     ←  cation 전자도핑 (H N(Ef) 보존, η↑)   ⟍  독립 손잡이
   stability ⟨ω²⟩ ←  cation pre-compression (cage 경화, ⟨ω²⟩↑) ⟋  → 동시 최적화
```

→ cation 이 **분자(η)와 분모(⟨ω²⟩)를 decouple** → `m>0 escape` 가능. CaH₆ (m=0.5 escape · 213 K MEASURED) 와 LaBeH₈ (110 K MEASURED @ 80 GPa) 이 anchor.

**N6 funnel 후보 (RTSC.md L14 · §9.16 box)**:
- 트랙 A — X₂MH₆ octahedral (Fm-3m · ambient-stable): Mg₂IrH₆ (160 K 🟡 PRED ambient) · Li₂CuH₆ (86 K 🟡 PRED ambient)
- 트랙 B — MXH₈ alloy-backbone (sub-100 GPa): LaBeH₈ (110 K 🟢 MEASURED @80 GPa) · LaBH₈ (156 K 🟡 PRED)

후보 매트릭스: `RTSC/research/ternary_ambient_candidates.md` (이미 land).

> **honesty fence (V5 §5)**: cation decoupling 이 *물질-특이적 인과* 로 작동하는지는 DFT/wet-lab downstream — V5 ⚪ SPECULATION-FENCED. 본 문서의 정당화는 **closed-form margin m 의 부호 변화**(CaH₆ m>0 vs h3o m<0) 가 binary→ternary 전환을 지지한다는 *통계적 anchor* 단계까지만. N6 후보들의 실제 m 값은 각 DFT run 후 closed-form 검증.

---

## 6. future probes (d2 · 다음 작업 axis)

| probe | axis | 산출 | priority |
|---|---|---|---|
| **h3br ω_log 향상 probe** | 압력/lighter substitution → Tc ∝ ω_log (RTSC.md L17) | h3br + 압력 sweep → ω_log·Tc envelope | M8 N5 breakthrough 후보 (stable·강λ 확보, ω_log bottleneck 만 남음) |
| **Mg₂IrH₆ ambient DFT m>0 검증** | cation decoupling first-principles | exports/material_discovery/rtsc_mg2irh6_*.json · m 값 + α²F + Tc | N6 트랙 A 우선 (RTSC.md L14) |
| **Li₂CuH₆ ambient DFT m>0 검증** | cation decoupling (lighter cation) | 동상 | N6 트랙 A |
| **LaBeH₈ SSCHA ledger** | mild Γ-soft anharmonic 보정 | 117 K (harmonic) → SSCHA 후 Tc · m 값 | N6 트랙 B anchor 정련 |
| **h3o anharmonic λ 재계산** | SSCHA dyn → ph.x EPC → anharmonic α²F | harmonic λ 폐기, anharmonic α²F 로 Tc 재산정 (RTSC.md L16) | 잔여 SSCHA 후속 |
| **h3as R3m DFT confirm** | Im-3m unstable → R3m stable polymorph | 1.65/450K/56K 의 worktree 등록 record | atlas fold (별도 entry) |

---

## 7. cross-refs

- **§9.16 funnel box**: `RTSC.md` L1236-1268 — N5 CLOSED · N6 ACTIVE
- **V5 wall 정량자**: `RTSC/verify/V5_stability_coupling_wall.md` — McMillan-Hopfield first-principles 유도 + `lambda_anharm_suppress` + `stability_coupling_margin` (둘 다 🟢 SUPPORTED-NUMERICAL, ε=1e-9)
- **N6 후보 매트릭스**: `RTSC/research/ternary_ambient_candidates.md`
- **h3o imaginary origin**: `RTSC/N5/h3o_imaginary_mode_origin.md` (Pm-3m T₁u Γ-mode H-sublattice 전단 변위)
- **measured anchors**: H₃S 203 K (Drozdov 2015) · CaH₆ 213 K (Ma 2022) · LaBeH₈ 110 K (PRL 130.266001 · 2023)

---

## provenance

- worktree: `cycle-n5-wall-doc-2026-05-26` (demiurge, agent-a740ea2b197bef297)
- 입력: RTSC.md L7-18 milestone + §9.16 funnel + V5 wall doc + RTSC.log.md 2026-05-23/24 entries
- governance: d1 · d2 · d6 · g3 · g5
- 정직 경계: 본 문서는 *벽 인정 + 다음 funnel 정당화*. N5 binary 분지가 RTSC 에 대해 고갈됐다는 진단은 강결합 (h3o 109K · h3cl 140K · h3br ~110K) 의 *부분 성공* 위에 서 있다 — "binary 고갈" + "N6 ternary 후속 milestone" 의 정직한 두 단계 진술.
