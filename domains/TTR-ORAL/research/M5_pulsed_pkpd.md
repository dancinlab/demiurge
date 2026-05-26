# TTR-ORAL — M5: B pulsed PK/PD · W3 window 정량 (hexa-native)

> 목표: track B (device-free) 의 핵심 게이트 **W3 (전신 면역조절 therapeutic window)** 를 수치로 연다.
> 방법: closed-form pulsed 모델 (exact) + hexa-native 수치 적분 confirmation (🟢) · sim = `TTR-ORAL/sim/m5_pulsed_pkpd.hexa`.

---

## 1. 모델 (path_B 1차 모델 + pulse)

```
잉크 든 macrophage pool  N  ──emigration──▶  림프절   (dN/dt = −k_eff·N)
   per-pulse 청소율   phi = 1 − exp(−k_eff·tau_win)
   k_eff = k_emig + (1−r)·k_death        [1/month]   ← 3 knob
   n90 = log(0.1)/log(1−phi)             (pulses to 90% skin clearance · 밑 무관)
```

3 knob: **k_emig↑** (B2 S1P/CCR7) · **k_death↑** (B1 CSF1R pulse) · **r↓** (재포획 억제).

---

## 2. W3 window — 펄스가 창을 여는 조건 (핵심)

⚠ 정직: **단순 duty-cycle 은 창을 못 연다.** 효과·독성이 노출시간에 둘 다 선형이면 펄스는 양쪽을 같은 비율로 깎아 무이득.
창이 열리는 건 **비선형 2조건**일 때:
1. **독성이 펄스 사이에 회복** (조직/면역 repopulation) → 누적 독성이 chronic 처럼 쌓이지 않음.
2. **효과는 event-driven** (Baranska 재증식 wave = 1회 pulse 당 고정 phi, 지속노출 불요).

이 2조건 하에서 `TI_pulsed / TI_chronic ≈ period / on-time` (회복 가정 시).

```
chronic 강lever        pulsed (회복형)
효과 ▓▓▓▓▓ 독성 ▓▓▓▓▓   효과 ▓░▓░▓ (합산·event)   ← 효과는 누적
→ 독성 겹침 = NO-GO     독성 ▒_▒_▒ (회복)         ← 독성은 리셋
                        → TI ~ period/on 배 개선
```

---

## 3. hexa-native 수치 결과 (verbatim · 🟢 SUPPORTED-NUMERICAL · per @D g5)

```
=== TTR-ORAL M5 pulsed PK/PD (track B) ===

[1] per-pulse phi -> n90 (pulses to 90% skin clearance):
  phi=0.05 n90 =44.8906pulses
  phi=0.10 n90 =21.8543pulses
  phi=0.15 n90 =14.1681pulses
  phi=0.20 n90 =10.3189pulses
  phi=0.25 n90 =8.00392pulses
  phi=0.30 n90 =6.4557pulses

[2] 3-lever k_eff -> per-pulse phi -> n90 (tau_win=0.25):
  natural          k_eff =0.0225 phi =0.00560921 n90 =409.348
  emig only        k_eff =0.3025 phi =0.0728362 n90 =30.4474
  emig+turnover    k_eff =0.32 phi =0.0768837 n90 =28.7823
  +recapture down  k_eff =0.38 phi =0.0906271 n90 =24.2377
  full 3-lever     k_eff =0.65 phi =0.149984 n90 =14.1698

[3] TI_pulsed/TI_chronic ~ period/on-time (full tox recovery between pulses):
  period 30d on 3d -> TI gain ~10.0x
  period 30d on 5d -> TI gain ~6.0x
  period 14d on 3d -> TI gain ~4.66667x

[4] numerical confirmation vs closed-form (k_hi=0.65 k_lo=0.0225 on=0.25 T=1.0 month):
  per-cycle phi =0.164208
  closed-form n90 =12.8367pulses
  numerical: 90% clearance at pulses =13 months =13.0
  (numerical ceils to whole pulses; closed-form is the exact continuous value)

=== M5 done ===
```

수치 ↔ closed-form 일치: §4 numerical 13 pulses vs closed-form 12.84 (whole-pulse ceil 차이만) → 모델 self-consistent.

---

## 4. 해석 (정직)

| 시나리오 | per-pulse phi | n90 | 월간(monthly) | 격주(biweekly) |
|---|---|---|---|---|
| 자연 baseline | 0.006 | 409 | ~34 yr | — |
| emig only (B2) | 0.073 | 30 | ~30 mo | ~15 mo |
| +turnover+r↓ | 0.091 | 24 | ~24 mo | ~12 mo |
| **full 3-lever** | **0.150** | **14** | **~14 mo** | **~7 mo** |

- **W2 (속도) 닫힘**: full 3-lever + 격주 펄스 → **~7개월** skin clearance. "months not years" 정합 (단 공격적 가정).
- **W3 (window)**: 펄스 + 회복 가정 시 **TI ~10× 개선** (period 30d / on 3d). M6 의 NO-GO (chronic 강lever window 부재) 를 → **conditional-go 로 이동시킬 수 있는 정량 경로**. 단 "독성 회복 timescale < period" 가정이 핵심 measurable.

---

## 5. tier 판정 (per @D g5)

| claim | tier | 근거 |
|---|---|---|
| n90 = log(0.1)/log(1−phi) closed-form | 🔵 | base-independent identity |
| §1–§4 수치 recompute | 🟢 | hexa-native run verbatim (위) |
| 3-lever k_eff 합산 → phi | 🟢 | hexa exp/log recompute |
| TI ~ period/on (회복 가정) | 🟡 | 조건부 closed-form (회복 가정 필요) |
| **독성 회복 timescale < period** (W3 의 핵심) | 🟠 | 실측 미입증 (M6 re-gate / ex-vivo·in-vivo) |
| per-pulse phi 절대값 (잉크 release 효율) | 🟠 | wet-lab 측정 (M8) |

---

## 6. 정직 결론 + next

- W2 닫힘 (🔵/🟢 · ~7-14 mo) · W3 의 **수치 경로 확보** (펄스+회복 → TI ~10×) but **회복 가정 자체는 🟠 (M6 re-gate + wet-lab)**.
- ⇒ B 는 M6 의 NO-GO 에서 **"conditional-go (회복 timescale 입증 시)"** 로 격상 가능 — 단 absorbed=false 유지 (핵심 가정 미측정).
- next: **M6 re-gate** (duty-cycle TI 반영해 window 재계산) · **M7** (B 경구 제형: B2+B1 pulse + r↓ lever) · **M8/M9** wet-lab (🟠: ex-vivo 재포획 억제 phi 측정 → in-vivo 독성 회복 timescale).
