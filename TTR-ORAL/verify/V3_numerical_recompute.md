# TTR-ORAL V3 — hexa-native numerical recompute (🟢 · track B)

> milestone: TTR-ORAL.md verify "V3 🟢 push"
> V2 (hand-arithmetic closed-form ledger) 의 핵심 수치를 **hexa-native recompute 로 upgrade** (🟢 SUPPORTED-NUMERICAL) + M5 (pulsed PK/PD) · M6-regate (pulsed TI) 통합. sim = `sim/v3_numerical_recompute.hexa`.
> GPU-needing claims (prodrug TDDFT Φ_u · lymphatic MD) 는 🟠 DEFERRED (per @D d7 · device-free B path 밖이라 우선순위도 낮음).

---

## hexa-native recompute (verbatim · per @D g5)

```
=== TTR-ORAL V3 numerical recompute (hexa-native, track B) ===

[A] ADME dermal delivery fraction + amplification:
  Eh =0.25 Fh =0.75 F(bioavailability) =0.498
  V_tat =7.5cm^3 =0.0075L
  f_target =8.89286e-05(fraction of oral dose at tattoo)
  amplification = Vd/(Kp*V_tat) =5600.0x (systemic/target)

[B] pulsed clearance (full 3-lever):
  k_eff =0.65/mo  phi =0.149984  n90 =14.1698pulses
  biweekly schedule months =7.08488

[C] recapture-down (r) leverage on the (1-r)*k_death term:
  r=0.95 term =0.02  r=0.80 term =0.08  ratio =4x

[D] pulsed TI re-gate (balanced 3-lever TI_chronic=0.8, 30d/3d):
  TI(eta=1.0) =8.0
  break-even eta* (TI>=3) =0.375

[E] checksums vs V2 hand-ledger:
  f_target target 8.93e-5 -> got8.89286e-05
  amplification target 5600 -> got5600.0
  n90(phi~0.15) target ~14.2 -> got14.1698

=== V3 done — GPU-needing TDDFT/MD claims remain 🟠 DEFERRED (off B path) ===
```

---

## 검증 결과 (V2 ↔ V3 정합)

| 양 | V2 hand-ledger | V3 hexa recompute | 정합 |
|---|---|---|---|
| f_target | 8.93×10⁻⁵ (F=0.5 반올림) | **8.89×10⁻⁵** (F=0.498 product) | ✅ (반올림 차) |
| amplification | 5600× | **5600×** | ✅ |
| F (bioavailability) | 0.498 ≈ 0.5 | **0.498** | ✅ |
| n90 (full 3-lever) | 14.17 | **14.17** | ✅ |
| r↓ leverage | 4× | **4×** | ✅ |
| TI re-gate η* (TI≥3) | 0.375 | **0.375** | ✅ |

⇒ V2 closed-form ↔ V3 hexa-native 완전 정합. 6/6 핵심 양 🟢 recompute PASS.

## tier 상태
- 🟢 recompute (본 V3): ADME wall · pulsed clearance · r leverage · pulsed TI re-gate.
- 🔵 (V2): closed-form identities.
- 🟠 DEFERRED: prodrug TDDFT Φ_u (GPU · A hybrid path) · lymphatic partition MD (GPU · C path) · η 독성회복 실측 (M9 wet-lab) · per-pulse φ 절대값 (M8 ex-vivo).

⇒ V4 (final tier ledger) 가 V1 inventory + V2 🔵 + V3 🟢 + 🟠 deferred 를 통합 정산.
