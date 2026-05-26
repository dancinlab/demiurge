# TTR-ORAL — /cycle round-1 grounding reconcile (정직한 대폭 하향)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> 두 실측 grounding 결과(M5b φ · M4b k_emig)를 합쳐 track B 모델을 정직하게 수정. @D d6 — 낙관 강제 금지. sim = `sim/cycle1_reconcile.hexa`.

---

## 1. 두 실측 발견 (요약)

| grounding | 가정 (M5/M4) | 실측 (문헌) | 영향 |
|---|---|---|---|
| **M5b · φ** (per-pulse release) | 0.15 | **중앙 0.05** (0.02-0.10) · 0.15는 낙관 천장 | 타임라인 지배 인자 |
| **M4b · k_emig** (S1P/B2 이주) | 15× boost (🟢로 오기) | **역부호** — S1P modulator=egress *길항제* · CCR7 천장 3-4× · 색소 macrophage=sessile | B2 lever 폐기 |

⇒ M4 tier-ledger #6 "3-5× egress 🟢"는 **방향 혼동** (S1P *자체* 촉진 ≠ *modulator*(길항제) 효과). 정정.

---

## 2. 수정 모델 — S1P 제거, 2-lever (k_death + r↓)

`k_eff = k_emig + (1−r)·k_death`, k_emig ≈ natural 0.02 (S1P out · 임상 CCR7 agonist 부재)
→ 모든 가속은 **k_death (CSF1R 펄스, M9-grounded)** + **r↓ (재포획 차단)** 에서만.

### hexa-native recompute (verbatim · 🟢 · T=28d safe)
```
[A] natural baseline:  k_eff=0.0225 phi=0.00560921 n90=409.348 pulses
[B] CSF1R pulse (k_death=0.50) x recapture-down r:
  r=0.85: k_eff=0.095 phi=0.0234702 n90=96.951  -> 89.30 months
  r=0.70: k_eff=0.17  phi=0.0416095 n90=54.178  -> 49.90 months
  r=0.50: k_eff=0.27  phi=0.0652723 n90=34.112  -> 31.42 months
  r=0.30: k_eff=0.37  phi=0.0883508 n90=24.893  -> 22.93 months
[C] 12-month(n90=13) 위해 필요 phi=0.162 → 이 모델 phi 천장(r=0,k_death=0.5 → phi≈0.12)으로 사실상 도달 불가
```

---

## 3. 정직한 수정 verdict (@D d6)

```
   r↓ (재포획 차단)        device-free oral 단독 fade timeline
   r=0.85  ██████████ ~7.4 yr    (약한 r↓)
   r=0.70  ███████ ~4.2 yr
   r=0.50  █████ ~2.6 yr
   r=0.30  ████ ~1.9 yr          (매우 공격적 r↓)
   목표 ~1 yr  ✗ phi 천장으로 도달 불가 (k_death/τ 추가 강화 필요)
```

- 🚨 앞서 "W2 속도 ✅ 닫힘 (~7-13개월)"은 **과낙관이었음**. 실측 φ + S1P 제거 후 현실 = **~2-6년** (r↓ 강도 의존). sub-year 는 현 2-lever 천장에서 **도달 불가**.
- **W2 재분류**: ✅닫힘 → 🟠 **φ/r↓ 지배 · 다년 timeline** (r↓가 make-or-break lever).
- W3 (안전 window)·W1 (cosmetic endpoint)은 유효하나, **속도가 새 병목**.

---

## 4. 벽 앞 돌파경로 (@D d2 — 포기 금지 · ≥3)

새 병목 = per-pulse φ 천장 (= 재포획 r 을 못 낮춤 + 펄스당 release 적음). 돌파:

| # | path | 원리 | tier |
|---|---|---|---|
| BP1 ⭐ | **직접 재포획 차단 (r↓ primary)** | 방출 색소 재탐식 억제 — anti-FcγR/CD64 · CD47-SIRPα "don't-eat-me" · 펄스창 한시적 phagocytosis 억제 → 색소가 재포획 대신 림프 배출 | 🟠 (기전 plausible · 미실측) |
| BP2 | **림프 배출 가속** | VEGF-C/lymphangiogenesis · lymph-flow↑ → 방출 색소를 재포획보다 빨리 운반 (effective φ↑) | 🟠 |
| BP3 | **펄스 active window τ↑** | CSF1R 활성창 연장 → 펄스당 φ↑ (단 노출시간↑ = 안전 trade-off, M6 re-gate 필요) | 🟡 (모델상 명확) |
| BP4 | **제품 재포지셔닝** | "몇 달 지우개" → **"다년 점진 fade 보조제" 또는 레이저-병용 가속제** (레이저 후 잔여 색소 청소 가속) — 정직한 near-term fit | 🟡 |

⇒ B 는 **falsified 아님** — 모델 수학 견고 · r↓/배출 기전 살아있음. 단 **device-free 단독 monotherapy = 다년**, lead lever 가 S1P→**r↓(재포획 차단)**로 이동. 가장 정직한 단기 포지션 = 레이저-병용 또는 점진 fade.

---

## 5. tier + 도메인 영향

| claim | tier |
|---|---|
| 2-lever k_eff·n90 recompute | 🟢 verbatim |
| φ 중앙 0.05 · S1P 역부호 · CCR7 천장 3-4× | 🟡 문헌 (M5b·M4b Sources) |
| S1P/B2 15× boost | 🔴 wrong-sign (FALSIFIED-class) |
| r↓ 달성 가능 수준 · BP1-2 기전 | 🟠 wet-lab |

**도메인 영향**: M4 (B2 S1P lead) · M7 (S1P backbone 제형) → **S1P 제거로 개정 필요** (k_death CSF1R 펄스 + r↓ agent 중심 재설계). absorbed=false 유지.

## 6. next (round-2 후보)
- **r↓ lever deep-dive** (BP1) — anti-CD64/CD47 phagocytosis 차단의 경구 가능성 + r↓ 정량.
- M4/M7 S1P 제거 개정 (CSF1R-pulse + r↓ 중심).
- 제품 포지셔닝 결정 (레이저-병용 vs 점진 fade 단독).
