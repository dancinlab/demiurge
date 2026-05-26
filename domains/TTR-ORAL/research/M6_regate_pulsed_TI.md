# TTR-ORAL — M6 re-gate: pulsed TI recompute (track B = CONDITIONAL-GO)

> M6 1차: B = **NO-GO** (chronic 강lever window 부재). M5: 펄스가 창 여는 조건 = 독성 펄스간 회복.
> 본 re-gate: 펄스 TI 를 recompute → B 를 NO-GO → **CONDITIONAL-GO** 로 정식 재판정. sim = `sim/m6_regate_ti.hexa`.

---

## 모델

```
TI_pulsed = TI_chronic × (T/on) × eta_recovery
   TI_chronic   M6 chronic-dosing TI (<1 = NO-GO)
   T/on         pulse 주기/투약시간 (duty 역수 · 독성 회복 활용 배율)
   eta_recovery 펄스 사이 독성 회복 효율 (0~1) ← 핵심 measurable (M9 wet-lab)
GO if TI ≥ 1 (break-even) · comfortable if TI ≥ 3
break-even:  eta* = TI_target / (TI_chronic × T/on)
```

---

## hexa-native recompute (verbatim · 🟢 · per @D g5)

```
=== TTR-ORAL M6 re-gate: pulsed TI recompute (track B) ===

[1] TI_pulsed = TI_chronic * (T/on) * eta_recovery   (T/on = 10, period 30d/on 3d)
  -- strong lever (TI_chronic = 0.5) --
  eta=0.0  TI =0.0
  eta=0.2  TI =1.0
  eta=0.5  TI =2.5
  eta=1.0  TI =5.0
  -- balanced 3-lever (TI_chronic = 0.8) --
  eta=0.2  TI =1.6
  eta=0.5  TI =4.0
  eta=1.0  TI =8.0

[2] break-even recovery efficiency eta* (eta to reach TI target):
  strong   TI>=1 : eta* =0.2
  strong   TI>=3 : eta* =0.6
  balanced TI>=1 : eta* =0.125
  balanced TI>=3 : eta* =0.375

[3] sensitivity to pulse spacing (balanced, TI>=3 target):
  period 14d/on 3d (T/on=4.67): eta* =0.803571
  period 30d/on 3d (T/on=10.0): eta* =0.375
  period 30d/on 2d (T/on=15.0): eta* =0.25

=== re-gate verdict: B = CONDITIONAL-GO if measured recovery eta >= eta* ===
=== eta is the wet-lab measurable (M9 in-vivo) ; absorbed=false until then ===
```

---

## 판정 (정직 · @D d5/d6)

| 시나리오 (30d/3d 펄스) | 통과 회복효율 η* | 해석 |
|---|---|---|
| balanced 3-lever · GO (TI≥1) | **0.125** | 12.5% 회복이면 break-even |
| balanced 3-lever · 안전 (TI≥3) | **0.375** | 37.5% 회복이면 편안한 마진 |
| strong lever · 안전 (TI≥3) | 0.60 | 강lever 단독은 60% 회복 필요 (어려움) |
| 넓은 간격 30d/2d · 안전 | 0.25 | 간격 넓힐수록 η* 완화 |

- **B = NO-GO → CONDITIONAL-GO 격상**: 펄스 + 회복 모델 하에서 `η ≥ 0.125~0.375` (margin 선택)면 TI 통과. 강lever 단독(η*=0.6)보다 **balanced 3-lever 가 훨씬 유리** (η*≈0.375) — M4 의 3-lever 조합 선택을 정량 지지.
- ⚠ **여전히 absorbed=false**: `η` (독성 회복 효율) 는 *실측 미입증* → 🟠. M9 in-vivo 가 η 를 재면 go/no-go 확정.
- 닫힌 부정 아님: B 는 "회복효율만 적당하면(>13-38%) 통과"라는 **좁고 구체적인 측정 게이트**로 환원됨 — M6 의 막연한 NO-GO 보다 크게 전진.

## tier
- TI_pulsed = TI_chronic·(T/on)·η · η* = TI_target/(TI_chronic·T/on) → 🔵 (closed-form) · recompute 🟢 (verbatim).
- TI_chronic 절대값 · η 실측 → 🟠 (M6 wet-lab / M9).

⇒ next: V3 (🟢 numerical 통합) · V4 (tier ledger) · M7/M8/M9 (제형·wet-lab).
