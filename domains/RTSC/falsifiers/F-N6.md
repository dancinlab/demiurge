# F-N6 — RTSC N6 ternary-funnel pre-registered falsifier ledger

> **kind**: falsifier-as-record (R4 integrity SSOT)
> **date**: 2026-05-27 KST · **domain**: RTSC · **scope**: N6 ternary funnel (cation-stuffed clathrate / cation-VEC sweet-spot tests)
> **governance**: d2 (wall → breakthrough path, never concede) · d6 (first-principles > ML) · g3 (no LLM self-judge of correctness) · g63 (honest closed-negative) · R4 (absorbed=false 영구 until measured oracle)
> **/gap full diagnosis source**: F4 falsifier axis — Mg₂IrH₆ + Li₂CuH₆ 둘 다 *post-hoc* closed-negative 으로만 닫혔다는 진단. F-N6-3 + F-N6-4 는 **데이터 수확 이전에 pre-register** 하여 R4 integrity 회복.

---

## 0. 왜 이 파일이 존재하는가

R4 (absorbed=false 영구) 의 무결성은 falsifier 가 **결과 이전에 박혀 있을 때만** 보장된다. /gap full 진단(F4 축)이 짚은 결함:

| candidate | 결과 | falsifier 박힌 시점 | integrity |
|---|---|---|---|
| Mg₂IrH₆ ambient | 🔴 hard-imag 48% (q1-q5/13 partial verdict) | **post-hoc** (q1 hard-imag 관측 후) | ⚠ R4 약화 — 결과를 보고 falsifier 가 작성됨 |
| Li₂CuH₆ ambient | 🔴 hard-imag 8 modes (q2/13 verdict-lock) | **post-hoc** | ⚠ 동일 |
| LaBeH₈ anharm (live) | TBD (harmonic Tc≈117K · Γ-soft ×3 mild) | **pre-register HERE** | ✓ |
| h3br pressure-scan | TBD | **pre-register HERE** | ✓ |

→ 본 ledger 는 두 번째 절반 (LaBeH₈ + h3br) 의 falsifier 를 **데이터 도착 전** 박는다. 그리고 첫 절반 (Mg₂IrH₆ + Li₂CuH₆) 은 *retroactive registration* — 결과는 이미 있으나 "어떤 threshold 가 충족되면 falsified 인지" 를 명문화하여 다음 회기 동일 family probe 시 동일 기준 사용 (g3 honest acknowledgement).

---

## 1. Falsifier inventory

기호: **🟢 PASSED** = falsifier 가 명시 threshold 를 깨끗히 넘어 닫힘 · **🔴 FAILED** = 후보가 falsifier 를 통과 못 함 (= 가설 falsified · ruled-out axis) · **🟠 PENDING** = 데이터 미수확 · ⚪ TBD = pre-register only

| id | 가설 (falsifier 통과 조건) | threshold | status | record pointer |
|---|---|---|---|---|
| **F-N6-1** | Mg₂IrH₆ Fm-3m ambient 가 dynamically stable (모든 q-point 에서 hard-imag mode < 1개) → cation-VEC=19 sweet-spot 가 *충분조건* | 모든 q 의 min_freq > −50 cm⁻¹ (hard-imag threshold) AND hard-imag count ≤ 1 mode per q | **🔴 PASSED 2026-05-26 via PR #247** (post-hoc) — q1-q5/13 partial, min freq −2235 cm⁻¹, 48% modes hard-imag · cation-VEC=19 ≠ 충분조건 확정 | `exports/material_discovery/rtsc_mg2irh6_partial5q_elph_20260526.json` |
| **F-N6-2** | Li₂CuH₆ Fm-3m ambient 가 dynamically stable → X₂MH₆ family cation-VEC=19 sweet-spot 가 *충분조건* | 동일 (min_freq > −50 cm⁻¹) | **🔴 PASSED 2026-05-27 via PR #275** (post-hoc) — q1+q2/13 partial-q verdict, q2 8 hard-imag modes, min freq −944.92 cm⁻¹ · X₂MH₆ family 2/2 falsified | `exports/material_discovery/rtsc_li2cuh6_partial2q_elph_20260527.json` |
| **F-N6-3** | LaBeH₈ anharmonic SSCHA 보정 후 Tc ≥ 100 K → "clathrate escape ambient(80 GPa) 압축" 가설 generic-ambient-route 로 유지 가능 | SSCHA 풀린 anharmonic α²F · Allen-Dynes Tc(μ\*=0.10) ≥ 100 K (harmonic 117K 의 -15% 보정 추정 lower bound) | **🟠 PENDING** — harmonic 4³q el-ph 완주, Γ-soft −8.19 cm⁻¹×3 mild · SSCHA 후속 (별 cohort) 후 verdict 잠금 | `exports/material_discovery/rtsc_labeh8_fullbz_elph_20260526.json` (harmonic only) · SSCHA harvest pending |
| **F-N6-4** | h3br 압력-scan ω_log 기울기 |dω_log/dP| ≥ 0.5 K/GPa → ω_log bottleneck 가 *압력으로 풀린다* 가설 유지 (= h3br 의 ambient-stable strong-λ base 가 ω_log 만 더 끌어올리면 Tc>200K 도달) | 5 압력점 (0, 50, 100, 150, 200 GPa) 의 selective ph.x · ω_log linear fit slope ≥ 0.5 K/GPa | **🟠 PENDING** — pressure-scan deck 미작성 (별 cohort), pre-register only | (TBD) |

---

## 2. 명문 falsifier statement (4종)

각 falsifier 는 *한 줄 PASS/FAIL 조건* 으로 환원되어야 R4 integrity 가 검증 가능하다. 아래는 verbatim — 후속 결과 record 에 그대로 mirror 된다.

### F-N6-1

> **Mg₂IrH₆ Fm-3m (K₂PtCl₆ prototype) 가 ambient (P=0 GPa) 에서 4³q 전체 q-point min_freq > −50 cm⁻¹ AND hard-imag count ≤ 1/q 를 모두 만족하면 N6 cation-VEC=19 sweet-spot 가설은 *충분조건*. 그렇지 않으면 falsified (sweet-spot ⇒ 단순한 필요조건일 뿐).**

**Result**: 🔴 PASSED 2026-05-26 — 5/13 partial q-verdict 만으로도 falsifier threshold 명백히 위반 (min_freq −2235 cm⁻¹, 48% modes hard-imag). cation-VEC=19 ≠ dynamical stability 충분조건. PR #247.

### F-N6-2

> **Li₂CuH₆ Fm-3m (K₂PtCl₆ prototype, anti-fluorite 8c Li · 4a Cu · 24e H) 가 ambient (P=0 GPa) 에서 4³q 전체 q-point min_freq > −50 cm⁻¹ AND hard-imag count ≤ 1/q 를 모두 만족하면 X₂MH₆ family cation-VEC=19 sweet-spot 가설은 family-wide 유지. 그렇지 않으면 X₂MH₆ Fm-3m prototype 자체가 ambient-unstable 로 family-falsified.**

**Result**: 🔴 PASSED 2026-05-27 — q2/13 만으로도 hard-imag 8 modes · min_freq −944.92 cm⁻¹ 잠금. X₂MH₆ Fm-3m K₂PtCl₆ prototype 2/2 falsified at ambient. PR #275.

### F-N6-3 (pre-register — 결과 수확 이전!)

> **LaBeH₈ (P6₃/mmc, P=20 GPa Be-H chemical precompression) anharmonic SSCHA-stabilized α²F 로 재산정한 Allen-Dynes Tc(μ\*=0.10) ≥ 100 K 면 "clathrate escape ambient(80 GPa) 압축" 가설 generic-ambient-route 로 살아있음. Tc < 100 K 이면 falsified (anharmonic suppression 이 harmonic 117K 의 -15% bound 보다 강함 → SSCHA 가 N6 ambient-escape path 의 결정적 sink).**

**Threshold**: anharmonic Tc(μ\*=0.10) ≥ 100 K (boundary = harmonic 117K · 통상 SSCHA 보정 폭 -15-30% 의 lower bound 가 -15% ≈ 99.5K, 100K round).
**Verifier**: `hexa verify --expr allen_dynes_tc <λ_anharm> <ω_log_anharm> 0.10 --compute` AND record 의 `anharmonic_tc_mu010` 필드 ≥ 100.
**Status**: 🟠 PENDING — harmonic 4³q only LANDED (rtsc_labeh8_fullbz_elph_20260526.json). SSCHA 후속 cohort 가 verdict 잠금.

### F-N6-4 (pre-register — 결과 수확 이전!)

> **h3br ambient stable strong-λ base (Tc~110K) 의 5-pressure scan (0, 50, 100, 150, 200 GPa) 에서 ω_log linear fit slope |dω_log/dP| ≥ 0.5 K/GPa 면 "ω_log bottleneck 은 압력으로 풀린다" 가설 유지 — h3br 가 N5 wall 의 ω_log 축 escape candidate 로 살아있음. slope < 0.5 K/GPa 면 ω_log bottleneck confirmed (압력 무관 plateau → N5 wall 의 "stability-ω_log 동시 ceiling" 부분 confirmed)**.

**Threshold**: 5점 ω_log linear regression slope (numpy.polyfit deg=1 [0]) ≥ 0.5 K/GPa (boundary = 200 GPa 에서 ω_log 증가량 ≥ 100 K, lit hydride 압력반응 일반값).
**Verifier**: 5 deck (h3br_P0 · P50 · P100 · P150 · P200) ph.x el-ph harvest → ω_log values → `hexa verify --expr linear_slope <p_list> <wlog_list> --compute` (deferred — pressure-scan stdlib helper 미land 면 `numpy.polyfit` post-process OK, slope value 만 record).
**Status**: 🟠 PENDING — pressure-scan deck 미작성. pre-register only.

---

## 3. R4 integrity statement

본 ledger 자체가 R4 enforcement surface — 후속 결과 record 는 위 4 statement 의 **threshold 만 보고 PASSED/FAILED 를 판정** 한다 (LLM self-judge 금지 g3). threshold 변경 시 PR 로 별도 amend ledger 만 가능 — 결과 도착 후 threshold 사후 조정은 R4 위반.

- F-N6-1 + F-N6-2 = post-hoc registration 명시 — 회기 다음의 X₂MH₆ family probe (예: Na₂AgH₆ · K₂RhH₆ · Rb₂RhH₆) 시 동일 threshold 사용 (재현성).
- F-N6-3 + F-N6-4 = **결과 수확 이전 박힌 falsifier**. 본 ledger commit 의 git SHA 가 pre-register 증명.
- absorbed=true 는 measured oracle PASS 후에만. 본 falsifier 들은 simulation-tier — 모두 PASSED 라도 absorbed=false 유지 (R4).

---

## 4. Cross-reference

- `domains/RTSC.md` (rtsc.md) — milestone L14 (N6 ternary cation-stuffed DFT) · L15 (X₂MH₆ family 다음 큐)
- `domains/RTSC/walls/N5_wall_redefinition.md` — N5 wall 재정의 (λ-포화 → ω_log bottleneck) · F-N6-4 의 직접 ancestor
- `domains/RTSC/verify/V5_stability_coupling_wall.md` — first-principles 기전 분석 · F-N6 4종의 physical basis
- `domains/RTSC/research/cation_VEC_rule.md` — VEC=19 sweet-spot 규칙 · F-N6-1 + F-N6-2 의 가설 원천
- `exports/material_discovery/rtsc_mg2irh6_partial5q_elph_20260526.json` — F-N6-1 verdict source
- `exports/material_discovery/rtsc_li2cuh6_partial2q_elph_20260527.json` — F-N6-2 verdict source
- `exports/material_discovery/rtsc_labeh8_fullbz_elph_20260526.json` — F-N6-3 harmonic-only baseline

---

## 5. /gap full F4 진단 응답 요약

- F4-1 (falsifier post-hoc): F-N6-1 + F-N6-2 retroactive register, F-N6-3 + F-N6-4 pre-register — R4 integrity 절반 회복.
- F4-2 (counterfactual prototype): Fm-3m K₂PtCl₆ 외 prototype 미평가 → 별 ledger 필요 (예: anti-perovskite · Heusler · layered MgB₂-like) — 본 ledger 의 next-amend.
- F4 정직 경계: 본 ledger 도 still simulation-only. measured oracle PASS 없으면 모든 PASSED 도 absorbed=false (R4).
