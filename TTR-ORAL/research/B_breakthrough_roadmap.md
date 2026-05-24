# TTR-ORAL — track B 돌파 roadmap (device-free 단독 lead)

> 사용자 결정 (2026-05-24): **B 로 돌파.** 순수 경구 (먹기만 · 기구 0). A(레이저 보조 hybrid) 는 device-free @goal 과 불일치 → 분리.
> M6 정직 판정: **B = NO-GO now** (전신 면역조절 therapeutic window 미입증). @D d2/d6 — 닫힌 부정 아님. 세 벽 각각에 구체 돌파경로를 박는다.

---

## B 의 세 벽 (M2·path_B·M6 통합)

```
잉크 든 macrophage  ──(W1)──▶  림프절로 "이동"     (파괴 아님 = fade ≠ erase)
       │                          │
     (W2) 자연 ~10 yr (k_nat 작음)  (W3) 전신 면역조절 = window 미입증 (M6 NO-GO)
```

| 벽 | 정직한 문제 | 출처 |
|---|---|---|
| **W1** | 잉크를 *부수지 않고* 림프절로 옮김 — 완전 erase 아님 | path_B · M6 |
| **W2** | 속도 — 자연 fade `k_nat ≈ 0.019/month` (t_90 ~10 yr) | path_B 1차모델 |
| **W3** | 전신 면역조절 therapeutic window 미입증 (강한 lever=독성 겹침 · 안전 lever=약함 · clean 경구 CCR7 부재) | M6 NO-GO |

핵심 model (path_B): `dN/dt = −k_eff·N`,  `k_eff = k_emig + (1−r)·k_death`,  `t_90 = ln(10)/k_eff`
3 knob — **k_emig↑** (이주) · **k_death↑** (turnover) · **r↓** (재포획 감소).

---

## W3 돌파 (핵심 게이트) — "window 를 어떻게 여나"

### ⭐ 통합 thesis: pulsed sub-toxic combination
chronic 단일 강lever (CSF1R 고용량 = 전신 macrophage 고갈 = 독성) 대신:
1. **pulse (간헐 단기 투여)** — Baranska 고갈→재증식은 **1회성 transient**, chronic 억제 불필요. 짧은 pulse(수일) → 재증식 wave 가 재포획 약한 상태로 잉크 방출. 독성은 시간적분 `∫C dt` → duty-cycle 만큼 감소.
2. **sub-threshold 3-lever 조합** — 각 agent 개별 안전역 내(sub-toxic) 저용량, but k_eff 3 term 에 각각 기여 → 합산/시너지로 efficacy 문턱 돌파. agent 별 TI 보존.

```
 단일 강lever (chronic)        pulsed combination
 ┌──────────────┐            ┌──────────────┐
 │ 효과 ▓▓▓▓▓▓   │ 독성 겹침   │ 효과 ▓▓▓▓▓▓   │ 효과는 합산
 │ 독성 ▓▓▓▓▓▓   │ → 좁은 window│ 독성 ▒░░  ▒░░ │ 독성은 각각 낮음 + pulse
 └──────────────┘            └──────────────┘  → window 넓어짐
```

### W3 breakthrough paths (≥3 · @D d2)
| # | path | window 를 넓히는 원리 | tier |
|---|---|---|---|
| W3-a | pulse dosing (전신 노출 시간 ↓) | TI 는 시간적분 → duty-cycle τ_p/T 배 독성 감소 | 🔵 (TI 정의 closed-form) |
| W3-b | sub-threshold 3-lever 조합 (k_emig·k_death·r 분담) | 각 agent 안전역 보존 · k_eff 합산 | 🟡 (조합 시너지 가정) |
| W3-c | 자연 신호 supraphysiological nudge (CCR7/CCL21 gradient 상한) | 내인성 경로라 novel-target 독성 회피 | 🟡 |
| W3-d | dermal-macrophage subset 선택 uptake (oral 부분 농축) | 전신 노출 줄임 — M5 PK/PD 검증 필요 | 🟠 |

M4 lead 매핑: **B2 S1P/CCR7** (k_emig knob · oral-native) + **B1 CSF1R pulse** (k_death knob · pexidartinib 경구) + r↓ lever (재포획 억제 — 추가 탐색).

---

## W2 돌파 (속도) — closed-form ledger

`t_90 = ln(10)/k_eff = 2.3026/k_eff`  ·  boost = k_eff/k_nat (k_nat ≈ 0.019/month)

| k_eff (/month) | boost | t_90 | 비고 |
|---|---|---|---|
| 0.019 (자연) | 1× | **121 month (~10 yr)** | 영구성 수준 |
| 0.2 | ~10× | **11.5 month** | 단일 강lever 추정 |
| 0.5 | ~26× | **4.6 month** | pulsed 3-lever 목표 |
| 1.0 | ~53× | **2.3 month** | 상한 (시너지 가정) |

> 손검산: ln10 = 2.3026 ; 2.3026/0.5 = 4.605 month ✅ · 0.5/0.019 = 26.3× ✅
> ⇒ **months not years** 는 k_eff ~0.5/month (≈26× boost) 면 닫힘 — 3-lever 합산으로 달성 가능역.

r↓ 의 지렛대: `(1−r)·k_death` 에서 r: 0.95→0.80 시 (1−r): 0.05→0.20 = **4×** (재포획 억제가 가장 큰 단일 배율).

---

## W1 돌파 (fade ≠ erase) — endpoint 재정의 + 보강

| # | path | 내용 | 정직 caveat |
|---|---|---|---|
| W1-a | **cosmetic endpoint 재정의** | 제품 목표 = "skin 에서 안 보임". 림프절 이동은 *모든 자연 fade 의 기전* — 자연을 가속할 뿐 | 림프절 색소 잔존 (무증상이나 영상 관찰 가능) — M6 림프절 safety 게이트 |
| W1-b | 이동 + 하류 청소 결합 | 림프 이동 중 단편화/배출 보강 | 화학 재도입 — device-free 순수성 약화 |
| W1-c | 소단편 배설 (담즙/신) | 배설 가능 크기로 쪼개진 잉크만 | carbon black 미배설 — 한계 명시 |

⇒ W1 은 **부분 reframe**: 림프 relocation = 자연 sink 가속 이므로 "skin clearance" 정의 시 blocker 아님. 단 림프절 부하 safety 는 M6 게이트로 남김 (정직).

---

## hexa verify --fence — B 돌파 thesis (verbatim · @D g5)

```
verify --fence
  claim  = Device-free oral track B (macrophage-migration) breaks its therapeutic-window wall (W3) via a PULSED COMBINATION of sub-toxic emigration levers (k_eff = k_emig + (1-r)*k_death, each term pushed sub-threshold) riding the natural CCR7/CCL21+S1P gradient, front-loaded with a brief CSF1R repopulation pulse; cosmetic endpoint t_90 = ln(10)/k_eff reaches months not years; lymph-node relocation is the natural sink accelerated
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

⇒ thesis *방향* ⚪ fence. t_90/boost **수치**는 closed-form arithmetic (위 ledger, hand-verifiable). efficacy/window 의 *실측* 은 🟠 (M5 PK/PD + wet-lab).

---

## 정직한 B 종합 판정 (@D d5/d6)

- W1 = 부분 reframe (cosmetic endpoint) ✅ · W2 = closed-form 상 ~26× boost 면 months ✅ (🔵 수치) · **W3 = 여전히 게이트** — pulsed sub-toxic combination 은 first-principles 상 window 를 넓히는 구조이나 **실측 미입증 → 🟠** (M6 NO-GO 해소 안 됨, 단 닫힌 부정 아님).
- ⇒ B 는 device-free 유일 lead 로서 **돌파 path 가 구체적으로 존재** (pulse + 3-lever 조합 + cosmetic endpoint). absorbed=false 유지.

## next (B 단독 트랙 재조준)
- **M5-ORAL** → pulsed 3-lever PK/PD 시뮬 (k_eff 합산 · pulse duty-cycle TI · pool/GPU per @D d7) — W3 window 정량.
- **M6 re-gate** → pulsed combination 의 TI 재계산 (duty-cycle 반영).
- **M7-ORAL** → B oral 제형 (B1 pexidartinib-class + B2 S1P/CCR7 + r↓ lever 조합 · 경구 BA).
- M8/M9 wet-lab (🟠 deferred): ex-vivo 재포획 억제 → in-vivo 마우스 tattoo fade timeline.
