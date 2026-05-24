# TTR-ORAL — BP1 deep-dive: 재포획 차단 (r↓) lever (round-2)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> cycle-1 reconcile 가 지목한 **새 dominant lever = r↓ (재포획 차단)** 를 정량. "β(phagocytosis 차단효율)을 얼마나 올릴 수 있나 = 타임라인 결정". sim = `sim/bp1_recapture_block.hexa`.

---

## 1. 모델 — β → r → 타임라인

```
natural r0 = 0.95  →  k_phago/k_drain = r0/(1−r0) = 19
blockade β:  r(β) = 19(1−β) / (19(1−β) + 1)       (재탐식률을 (1−β)배로)
k_eff = k_emig + (1−r)·k_death  (k_death=0.50 CSF1R펄스 · k_emig=0.02)
phi = 1−exp(−k_eff·τ) · n90 = log0.1/log(1−phi) · months = n90·T/30.4 (T=28d)
```

## 2. hexa-native recompute (verbatim · 🟢)

```
beta(차단)  r(recapture)   k_eff    phi      n90     months   기전-현실성
  0.00      0.95  0.045  0.011187  204.674  188.516  baseline
  0.30      0.93007  0.054965  0.0136473  167.567  154.338  oral FcgR (wrong arm?)
  0.60      0.883721  0.0781395  0.0193453  117.87  108.565  strong FcgR
  0.90      0.655172  0.192414  0.0469648  47.8674  44.0884  multi-receptor (biologic)
  0.95      0.487179  0.27641  0.066769  33.3213  30.6906  near-total block
```

## 3. 정직한 발견

```
   β (재포획 차단효율)        timeline      oral 실현성
   0.00  ████████████ 188mo   (CSF1R펄스만)   —
   0.30  ██████████ 154mo     fostamatinib?   ⚠ FcγR=잉크에 wrong-arm 가능
   0.60  ███████ 109mo        강한 FcγR       ⚠ 여전히 wrong-arm
   0.90  ███ 44mo             multi-receptor  ✗ biologic (비경구)
   0.95  ██ 31mo (~2.6yr)     near-total      ✗ biologic
```

- ✅ **r↓ = dominant lever 확인**: β 0→0.95 가 188mo→31mo (**~6× 단축**). cycle-1 의 "r↓가 make-or-break" 정량 확정.
- ⚠ **그러나 oral-agent gap (새 벽)**:
  - **Fostamatinib** (FDA 경구 Syk 억제제, ITP) = **FcγR-매개** phagocytosis 차단. 그런데 **무른 잉크 입자 재포획은 항체-매개(FcγR) 아님** — scavenger-receptor(MARCO/SR-A) + actin-의존 *일반* phagocytosis. ⇒ fostamatinib 의 잉크-재포획 β 는 **낮을 가능성** (wrong arm).
  - **CD47-SIRPα**: anti-CD47 은 phagocytosis 를 *촉진*(역방향). 우리가 원하는 SIRPα-작용(don't-eat-me 유지)/CD47-mimetic 코팅 = 대부분 **biologic(비경구)** + 잉크에 in-situ 코팅 난해.
  - high-β (β≥0.9 · ~2.6yr) 에 필요한 multi-receptor 차단 = **biologic = device-free oral 제약 위반**.

⇒ **BP1 verdict**: 올바른 lever 이나 **高-β 경구 agent 부재** → device-free 단독은 여전히 **다년(10yr+ 현실 β에서)**. 닫힌 부정 아님 — agent gap 이 구체 타겟으로 환원됨.

## 4. 벽 앞 돌파 (@D d2 · BP1 내부)

| # | path | 내용 | tier |
|---|---|---|---|
| BP1a ⭐ | **경구 scavenger-receptor(MARCO/SR-A/MSR1) 길항제** | 잉크 재포획의 *올바른* 수용체 표적 · 高-β 경구 가능성 | 🟠 (임상 agent 부재 = 발굴 타겟) |
| BP1b | **fostamatinib 펄스 시험** | 잉크 재포획에 FcγR 기여분이라도 있으면 부분 β · 이미 경구 FDA | 🟡 (기전 부분 · 실측 필요) |
| BP1c | **actin/PI3Kγ 일반 phagocytosis 억제** | 광범 차단 → 高 β but 전신 독성 (펄스 한시 완화) | 🟠 (독성 wall) |
| BP1d ⭐ | **레이저-병용 (BP4 합류)** | 레이저가 잉크 단편화 → 작은 단편은 drainage↑ · 경구 r↓(낮은 β)와 시너지 → device 1회 + 경구 보조 | 🟡 (가장 credible near-term) |

## 5. tier + 도메인 영향

| claim | tier |
|---|---|
| r(β)·k_eff·n90 recompute | 🟢 verbatim |
| r↓ = dominant lever (6× 단축) | 🔵/🟢 (모델) |
| fostamatinib FcγR 차단 (경구 FDA) | 🟡 (Wikipedia/Blood/FDA) |
| 잉크 재포획 = scavenger-receptor (FcγR 아님) | 🟡 (general phagocytosis 문헌) |
| 경구 scavenger-receptor 길항제 高-β | 🟠 (agent 부재) |

> **결론**: device-free **경구 단독**으로 months 는 비현실 (高-β 경구 agent 부재 + φ 천장). 가장 정직한 near-term = **BP1d 레이저-병용** (1회 시술 + 경구 r↓ 보조). 진정한 device-free 의 핵심 미해결 = **경구 scavenger-receptor 길항제** (BP1a, 발굴 타겟). absorbed=false 유지.

---

## Sources
- Fostamatinib (oral Syk inhibitor, FcγR phagocytosis block, FDA 2018 ITP) — Wikipedia · *Blood* 2019 (ashpublications.org/blood/article/133/19/2027)
- CD47–SIRPα "don't eat me" (blockade *promotes* phagocytosis · mostly biologics) — PMC9216458 · Front Pharmacol 2023
