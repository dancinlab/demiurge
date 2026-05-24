# X35 — inaction cost (비채택 비용 · 배포 well capstone)

> CARDIO+ 메타도메인 X35 산출물 · current-state · no history.
> 목적 = 3-axis 층화 케어를 배포하지 **않고** 표준(S1 universal clopidogrel)에 머물 때 매년 한국 PCI 인구가 지불하는 부담 정량 — **채택 동인의 거울상**.
> ⚠ illustrative population projection ⚪ proposal (실측 인구 결과 아님 · 효과 가정 의존 · d6). event rate는 M8 §5.1 VERBATIM grounding.

---

## §1. 모델 (mini 실측 · `CARDIO+/DAPTPGX/sims/x35_inaction_cost.hexa`)

- Korea PCI **~80,000명/yr** (M8 budget pci_per_y VERBATIM) × per-100 event rate 차이(비채택 S1 − 채택 S4, M8 §5.1 VERBATIM)
- 사건 단가 M8 §2 (ST 15M · death 10M · bleed 8M KRW) · 약가 M8 §5.1 (S1 5.5M / S4 34.5M per-100)

## §2. mini 실측 (VERBATIM)

```
--- per-100 (비채택 S1 − 채택 S4) ---
excess_ST_per100    =0.5
excess_bleed_per100 =-0.3   (음수=비채택이 출혈 적음·potent trade-off)
excess_death_per100 =0.3

--- 연간 Korea PCI 80000명 (비채택 초과) ---
annual_excess_ST    =400 건/yr
annual_excess_bleed =-240 건/yr (회피)
annual_excess_death =240 명/yr
annual_excess_event_cost_Eok =64.8
annual_drug_save_by_inaction_Eok =232.0
net_1y_inaction_Eok =-167.2
annual_QALY_toll =3315.84 QALY/yr
```

| 비채택(표준 유지) 연간 toll | 값 |
|---|---|
| 초과 사망 | **+240명/yr** |
| 초과 ST(스텐트혈전증) | +400건/yr |
| 출혈 | −240건/yr (회피 · potent 안 써서) |
| 초과 사건비 | +64.8억/yr |
| 약가 절약(targeted 미사용) | +232억/yr |
| **net 1y 경제** | **−167.2억 (비채택이 1y 돈은 아낌)** |
| QALY toll | ~3,316 QALY/yr |

---

## §3. 정직한 해석 (d6 — devil's bargain)

- **핵심**: 비채택은 **1년 예산을 ~167억 아끼지만, 매년 240명 사망 + 400 ST + 3,316 QALY를 지불**한다. "지금 돈 아끼고 생명·장기비용으로 갚는" 거래.
- **거울상**: 채택(배포)은 1y 예산 +(약가) 들지만 생명·QALY를 사고 5y에 비용도 절약(X19 ① CYP2C19 5y −44억) — 즉 inaction net이 1y 음수인 건 **X19와 정합**(1y 절약 → 5y 손실 반전). X35는 그 1y 절약의 **숨은 가격표**(생명·QALY)를 드러냄.
- **출혈 trade-off 정직**: 비채택은 출혈은 오히려 −240건 적음(potent 안 씀). 따라서 "비채택이 무조건 나쁘다"가 아니라 **ST·사망 ↑ vs 출혈 ↓의 net trade-off** — 사망(가중 큼)이 지배해 net health toll은 비채택 불리.
- **honest 한계**: population projection ⚪ · S1/S4 event rate(M8) + X28 ΔQALY 가정 의존 · IM/PM 0.628 가중 · 비할인. 인과 확정은 X25 wet-lab/RCT gate 후 (X13 numerical→causal 경계).

## §4. 연결
- **배포 well capstone** — X29-X34(어떻게 배포)의 "왜 서둘러야 하나" 정량 답: 지연 1년당 ~240명.
- X19(budget 인구) · X28(개인 microsim) · X3 §3.2(ICER)와 동일 rate, inaction 단위로 재구성.
- adoption lever(X30): inaction cost가 P4P·정책(#3·#19)의 정량 근거 — "미채택 = 연 240명" 이 격상 명분.

## ref
- mini 실측: `POOL_DISABLE=1 hexa run CARDIO+/DAPTPGX/sims/x35_inaction_cost.hexa`
- grounding: M8 §5.1(event rate)·§2(단가)·budget(pci_per_y) · X19(budget)·X28(ΔQALY)·X3 §3.2(ICER)
