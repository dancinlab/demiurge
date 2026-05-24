# TTR-ORAL — lever benchmark scorecard (NOVEL 발굴 + 벤치마킹)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> 지금까지 탐색한 모든 lever 를 공통 축에서 점수화. per @D d11. sim = `sim/benchmark_levers.hexa`.
> **🔒 scope (TTR-ORAL 기준)**: TTR-ORAL = **device-free 경구만**. 레이저-병용·prodrug+외부활성 = **out-of-scope** (device 필요 · 별도 트랙 · 아래 참조선). **승자는 device-free 안에서만 판정.**

## timeline (hexa-native verbatim · 🟢)

```
B-core (CSF1R+r↓0.50, oral)        : 31.42 mo
d11 bolus (D1.5 + s_sat0.7, oral)  : 22.27 mo   ← device-free best (so far)
drainage alone (D1.5, oral)        : 149.92 mo
laser monotherapy (incumbent)      : 8.04 sessions = 12.87 mo
laser + oral r↓0.50 (BP1d)         : 4.29 sessions = 6.87 mo
laser + oral r↓0.40 (BP1d aggr)    : 3.34 sessions = 5.35 mo  ← fastest overall (device)
```

## scorecard (다축)

| approach | timeline | device-free | erase vs relocate | 부위특이성 | best tier | near-term | 핵심 blocker |
|---|---|---|---|---|---|---|---|
| **laser + 경구 r↓** (BP1d) | **~5-7 mo** | ✗ (레이저) | 단편화+배출 | 시술 국소 | 🟡 | **★ 최단** | 경구 β 미입증 |
| 레이저 monotherapy (incumbent) | ~13 mo | ✗ | 단편화+재포획 | 시술 국소 | 임상표준 | 기존 | 다회 시술 |
| A) prodrug + 외부활성화 | 시술의존 | ✗ (hybrid) | 분해 | ★ 게이팅 강 | 🔵5/🟠4 | 중기 | r_dark·시술 |
| **d11 bolus** (배출+포화) | **~22 mo** | ✅ | relocate | 약 | 🟢/🟠 | ★ device-free best | s_sat·φ 미실측 |
| B-core (CSF1R펄스+r↓) | ~31 mo | ✅ | relocate | 약 | 🟢/🟠 | — | r↓ 경구 agent |
| BP1a rhein-SR 길항 | (r↓ 기여) | ✅ | relocate | 약 | 🟡/🟠 | scaffold-in-hand | MARCO 선택성·β |
| drainage alone (lymphagogue) | ~150 mo | ✅ | relocate | 약 | 🟢/🟡 | ✗ 단독 약함 | D 현실 ~1.5× |
| B2 S1P (original) | — | ✅ | — | — | 🔴 역부호 | ✗ 폐기 | egress 억제제 |
| **N1 phagolysosome-pH-gate** | (erase 경로) | ✅ | **★ erase ~60-70%** | 🔴 pH-alone falsified → AND-gate 필요 | 🔵gate/🟠 | 중기 | pH×pigment AND-gate |
| **N2 monocyte 트로이목마** | solo ~16yr | ✅ | relocate | **★ ADME 우회 (~5000×)** | 🟢/🟠 | 중기 | 표적 reprogram agent 부재 |
| **N1⊗N2 (emergent)** | erase ~0.65 (~75% 천장) | ✅ | **★ erase + ADME우회** | **🔵 AND-gate 해결** | 🔵4/🟠 | **핵심 후보** | 경구 순환-monocyte 적재 ~5e-4 |
| N3 autophagy | ~45-55% only | ✅ | erase (조직내) | 비특이(1.8e-8) | 🔴 dominated | ✗ | 색소 화학 floor (anthracosis) |
| N4 ink-tagging glue | (freed pool) | ✅ | **★ carbon tag-drag** | 약 | 🟢결합/🟠 | carbon niche | ADME×세포내 이중벽 1e-6 |

## 읽는 법 (정직)

```
빠름 ──────────────────────────────────────────► 느림
5mo   7mo        13mo              22mo   31mo        150mo
레이저  레이저     레이저            d11    B-core      배출
+r↓0.4 +r↓0.5    단독(기존)        bolus  (경구)       단독
└──── device 필요 ────┘            └──── device-free ────┘
```

- 🔒 **scope: device-free only 안에서만 승자 판정** (레이저-병용 5-7mo·레이저단독 13mo = out-of-scope 참조선, TTR-ORAL 답 아님).
- **device-free 단독 = 다년** — 현 best = bolus ~22mo. N1/N2 단독은 각각 falsified-gating / solo-느림 → 어느 것도 단독으로 "months" 못 냄.
- **emergent 후보 = N1⊗N2**: N2(혈중 monocyte = ADME 우회 + r-lever 전달) ⊗ N1(pigment-gated 촉매 = erase) → monocyte 가 촉매를 싣고 잉크 먹은 세포로 진입 ⇒ **AND-gate 자동충족 + erase + device-free**. 두 NOVEL 이 서로의 honest 갭 상보. 정량 미검증(🟠) = 핵심 다음 deep-dive.

## tier
- 모든 timeline = 🟢 hexa recompute. 미실측 결정 = φ·s_sat·rhein β·N1 AND-gate·N2 표적 reprogram·N1⊗N2 조합.
- **종합 verdict (device-free only 기준 · round-2 갱신)**:
  - **best device-free 개념 = N1⊗N2** — AND-gate 형식적 해결(🔵)이나 벽이 *경구 순환-monocyte 적재*(~5e-4·in-vivo 근거 없음, 🟠)로 이동. 사라지지 않고 relocate.
  - 🧱 **모든 device-free degradation lever 공통 HARD floor = carbon black ~25% 비분해** (anthracosis · sp²C-C 5.37eV). N3=이 floor에 dominated. **분해로는 절대 ≥90% 불가 (천장 ~75%).**
  - 🎯 carbon 25%를 다룰 유일 device-free 경로 = **N4 tag-and-drag** (분해 아닌 결착·견인), 단 freed pool + freeing lever 필요.
  - ⇒ 완전 device-free ≥90% 가설 recipe = **N1⊗N2(organic 65% 분해) + N4(carbon 25% tag-drag) + bolus(freed pool 공급)** — 3중 합성. 각 요소 🟠, 합성 미검증.
  - absorbed=false · 도메인 falsified 아님 (개별 가정 S1P·pH-alone·autophagy-flux 만 🔴/dominated).

## next
- N1/N2 착지 → 이 표 pending 행 채움 + 재랭킹.
- 계속 NOVEL 발굴 (d11): 다음 후보 — autophagy 유도(intracellular 분해) · ink-tagging molecular-glue(lymphatic export) · gut-microbiome 활성화 prodrug.
