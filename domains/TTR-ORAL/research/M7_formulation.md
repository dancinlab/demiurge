# TTR-ORAL — M7: 경구 제형 설계 (track B · device-free combination product)

> milestone: TTR-ORAL.md **M7-ORAL** — track B 경구 제형 (B2 emigration + B1 CSF1R pulse + r↓ recapture-down lever 조합 · 경구 BA · pulse schedule)
> 입력 = `M4_candidates.md` §2-3 (B2 S1P/CCR7 · B1 CSF1R lead) · `M5_pulsed_pkpd.md` (pulsed k_eff = k_emig+(1−r)k_death · 격주 펄스 · TI ~10×) · `B_breakthrough_roadmap.md` (3-lever pulsed thesis) · `M6_systemic_safety.md` (window gate · CYP/장기 노출) · `path_B_macrophage_migration.md` §3 (레버 매핑)
> 정직 원칙 (@D d5/d6): 실제 FDA 경구약의 BA/PK = 🟡 (라벨 citation). novel combination(이 조합의 fade efficacy·DDI 안전)은 🟠 (미입증). positive verdict 강제 금지.
> ⚠ scope: 제형 *설계* (formulation strategy · pulse mapping · CMC 골격)까지가 completed-form. 임상 efficacy/safety·생동성·실제 안정성 batch = M8/M9 wet-lab (🟠 deferred).

---

## §0 3-lever ↔ agent ↔ 제형 매핑 (M5 model 정합)

M5 model:  `k_eff = k_emig + (1−r)·k_death`,  per-pulse `phi = 1 − exp(−k_eff·τ_win)`,  `n90 = log(0.1)/log(1−phi)`

```
   레버 (k_eff 항)        agent class               제형 / 투여 리듬          M5 knob
   ───────────────────────────────────────────────────────────────────────────────
   k_emig↑  (이주 가속)   S1P1 modulator            연속-저용량 (continuous)   k_emig
   (B2)                   (etrasimod / ozanimod)     IR tablet QD (titration)
   ───────────────────────────────────────────────────────────────────────────────
   k_death↑ (turnover)    CSF1R inhibitor           PULSE (간헐 단기)          k_death
   (B1)                   (pexidartinib)             IR cap BID × 3d / 2주     ↑ + r↓
   ───────────────────────────────────────────────────────────────────────────────
   r↓  (recapture down)   = CSF1R pulse 의           pulse 직후 재증식 window  (1−r)↑
   (B3/recapture lever)   depletion→repopulation     + 비약물 lymph-flow 보조
                          (Baranska window)          (운동·온열·압박)
```

> 정직 핵심 (path_B §1·M5 §2): **r↓ 레버는 독립 약물이 아니라 CSF1R pulse 의 부수효과다.** Baranska 의 depletion→repopulation 에서, macrophage pool 이 일시 비면 release 된 색소를 재포획할 세포가 없어 (1−r) 가 일시 ↑ — 즉 *같은 pulse 가 k_death↑ 와 r↓ 를 동시에 만든다.* 별도 r↓ 전용 경구약(clodronate 경구 BA ~1-2%)은 비효율 → **r↓ 는 pulse 타이밍 + 비약물 lymph-flow 보조로 구현** (B4, BA 무관·🟢 safety). 따라서 combination product = **2 활성 (S1P modulator + pexidartinib)** + 비약물 adjunct.

---

## §1 combination-product 설계 — FDC vs pulse-timed 분리

```
   ┌─ 후보 1: 고정용량복합제 (FDC, 단일 정제) ─────────────────────┐
   │  S1P modulator + pexidartinib 한 알.                          │
   │  ✗ 리듬 불일치: S1P=연속 QD / pexidartinib=간헐 pulse.        │
   │    FDC 는 두 약을 같은 빈도로 묶어 pulse duty-cycle 을 파괴 → │
   │    M5 의 TI ~10× (period/on-time) 이득 소멸 → 채택 불가.       │
   └───────────────────────────────────────────────────────────────┘
   ┌─ 후보 2: pulse-timed 분리 투여 (채택) ★ ──────────────────────┐
   │  • 연속 backbone:  S1P modulator IR QD (매일 1회·저용량 유지)  │
   │  • 간헐 pulse:     pexidartinib IR BID × 3일 / 2주 1회         │
   │  → 두 리듬 독립 → M5 duty-cycle (period 14-30d / on 3d) 보존.  │
   │  → co-packaged blister (요일/펄스 표시) 로 adherence 관리.     │
   └───────────────────────────────────────────────────────────────┘
```

**결론: pulse-timed 분리 투여 (separate dosing, co-packaged) 채택.** FDC 는 두 활성의 투여 리듬이 근본적으로 다르므로(연속 vs 펄스) M5 의 핵심 TI 이득과 충돌 → 단일 정제 불가. 대신 **부속 blister-pack** (연속 backbone 일일정 + 2주 pulse 키트)로 묶어 제품화. r↓ 레버는 비약물(운동·압박·온열) 처방으로 라벨에 동반.

```
   ── pulse-timed 투여 타임라인 (period = 14d biweekly · M5 §4 격주) ──

   day  0   1   2   3   ...        14  15  16  17  ...        28
   S1P  ●   ●   ●   ●   ●●●●●●●●●   ●   ●   ●   ●   ●●●●●●●●●   ●    (연속 QD backbone)
   PXB  ▓   ▓   ▓   ·   ·········   ▓   ▓   ▓   ·   ·········   ▓    (3d pulse / 14d)
        └on=3d┘                     └on=3d┘
   recap ↓↓↓ window  (depletion→repopulation = r 일시↓)
   lymph  운동/압박/온열 = pulse 후 7-10d (재증식 window 에 dLN 배수↑)

   ● S1P QD · ▓ pexidartinib BID pulse · duty-cycle on/period = 3/14 ≈ 0.21
   → M5 §3:  TI gain ~ period/on = 14/3 ≈ 4.7× (격주)  ·  30/3 = 10× (월간 옵션)
```

---

## §2 제형 표 — agent별 PK + formulation strategy + pulse 매핑

| agent (lever) | MW (g/mol) | logP | 경구 BA | food effect | t½ | 제형 strategy | pulse schedule | tier (PK 값) |
|---|---|---|---|---|---|---|---|---|
| **etrasimod** (B2 k_emig, backbone 1순위) | ~414 (free base; arginine salt 631.7) | ~5 (고친유) | 높음 (소분자 S1P, 라벨 high BA) | 첫 3일 식사 권장 (부작용 완화), 이후 무관 | ~30–37 h (QD 적합) | IR film-coated tablet **QD** · titration 불요(일부 무) → backbone 단순 | **연속** (매일 저용량) | 🟡 (Velsipity 라벨) |
| **ozanimod** (B2 대안) | ~404 (base) | ~3.6 | 높음 | **무** (식사 무관) | ~21 h (parent) · ~10 d (active metabolite) | IR capsule **QD** · 7일 dose **titration** 필수(서맥 완화) | **연속** | 🟡 (Zeposia 라벨) |
| **fingolimod** (B2 차선) | 307.5 (base; HCl 343.9) | ~4.3 | ~93% (식사 무관) | **무** | **6–9 일** (매우 긺 → 펄스 부적합) | IR cap QD · first-dose 6h 심전 모니터 | 연속만 (t½ 길어 washout 느림 → pulse backbone 부적) | 🟡 (Gilenya 라벨) |
| **pexidartinib** (B1 k_death + r↓, pulse lever) | ~417.8 | ~3.5 | >90% | **고지방 +100% / 저지방 +60% 흡수↑** → 저지방식 동반 라벨 | ~26.6 h | IR capsule **BID**, **pulse 3일/2주** · 간헐 dosing 으로 누적 간독성·macrophage 고갈 회피 | **펄스** (on=3d / period 14d) | 🟡 (Turalio 라벨) |
| r↓ adjunct (B4, 비약물) | — | — | (BA 무관) | — | — | 비약물: 운동·압박·국소 온열 (lymph-flow↑) — pulse 후 재증식 window 에 처방 | pulse 후 7–10d 집중 | 🟢 (비약물 safety) / 🟠 (fade 기여 정량 미입증) |

> backbone 선택 근거: **etrasimod 또는 ozanimod 가 fingolimod 보다 우선** — fingolimod t½ 6–9일은 washout 이 느려 pulse-friendly 하지 않고 first-dose 서맥 모니터링 부담. etrasimod/ozanimod 는 t½ 가 QD 연속에 적합하고 selectivity(S1P1±5) 가 높아 off-target(서맥·황반) 측면 우위. **pexidartinib 는 pulse lever 의 유일 FDA 경구 CSF1R 억제제** (Turalio, TGCT 승인) → B1 anchor.

```
   ── 제형 release 전략 요약 (ASCII) ──
   S1P backbone   : IR · QD · 위장관 흡수 (고친유 → 용해도 향상 부형제)
   PXB pulse      : IR · BID×3d · 저지방식 동반(food-effect 활용·표준화)
   modified-release? : 둘 다 IR 우선. enteric coat 은 PXB 의 위 자극 완화
                       옵션이나 BA(food-effect)와 상충 → 1차 설계는 IR 유지.
```

---

## §3 DDI · sequencing — pulse 가 emigration 에 선행해야 하나

### §3.1 sequencing — 기전상 순서 (Baranska window 정렬)

```
   순서 가설:  CSF1R pulse  ──선행──▶  emigration backbone 효과 극대화
   ──────────────────────────────────────────────────────────────────
   1) pulse (pexidartinib 3d) → 진피 macrophage 일시 고갈 → 재포획 pool↓ (r↓)
   2) 고갈 직후 = 색소가 "자유" 상태 (재포획될 세포 부족)
   3) 이때 S1P 축이 신규/잔존 macrophage 의 dLN 이주(k_emig↑)를 받아 색소 배수
   ⇒ pulse 가 r 을 낮춘 window 안에서 emigration 이 작동해야 net flux 최대.
```

- **정렬 결론**: backbone(S1P)은 *연속*이므로 항상 켜져 있고, **pulse 가 그 위에 r↓ window 를 주기적으로 연다.** 따라서 "pulse 선행"은 일회 선후가 아니라 **연속 backbone + 주기적 pulse 의 위상 정렬** — pulse 직후 재증식 window(7–10d)에 emigration 이 가장 효과적 (M5 event-driven 효과 §2 정합). 비약물 lymph-flow 보조도 이 window 에 집중.
- ⚠ 정직 (🟠): 이 위상 정렬의 *실제 fade 기여*는 인간 타투 k_emig·r 측정값 부재로 미입증 (M4 gap §2.4 · M8). 순서 *원리*는 Baranska window(🟡) 정합이나 *정량*은 deferred.

### §3.2 CYP / transporter 상호작용 (M6 §1 간 1차통과 노출 연동)

| 상호작용 | 기전 | 임상 함의 | tier |
|---|---|---|---|
| **pexidartinib = CYP3A4 + UGT1A4 기질** | 강 CYP3A4 억제제/유도제 병용 시 PXB 노출 변동 | pulse dose 정밀도 영향 — 강 inducer/inhibitor 금기 | 🟡 (Turalio 라벨) |
| **pexidartinib = CYP3A4 시간의존 억제/유도 가능** | PXB 자신이 CYP3A4 perpetrator | 병용 S1P modulator 가 CYP3A4 기질이면 노출↑ risk | 🟡 (라벨) |
| **etrasimod = CYP2C8/2C9/3A4 다중 대사** | PXB 의 CYP3A4 perpetrator 효과와 부분 중첩 | pulse 3일 간 etrasimod 노출 소폭 변동 가능 → backbone 영향 평가 필요 | 🟠 (조합 미평가) |
| **ozanimod = CYP/MAO-B + 강 BCRP 기질** | PXB-CYP3A4 경로와 비중첩 (MAO-B 주경로) → DDI 약함 | **DDI 회피 관점 ozanimod backbone 우위** (CYP 중첩 최소) | 🟠 (조합 미평가) / 🟡 (각 라벨) |
| **fingolimod = CYP4F2 주경로** | PXB-CYP3A4 와 비중첩 → DDI 약함 | DDI 측 유리하나 t½ 길어 pulse 정렬 부적 | 🟡 (라벨) |

> **DDI 종합**: pexidartinib 의 CYP3A4 perpetrator 성격이 핵심 변수. **CYP3A4 중첩이 적은 backbone(ozanimod MAO-B / fingolimod CYP4F2)이 DDI 회피에 유리**하나, etrasimod 는 QD·titration 단순·selectivity 이점이 커 trade-off. pulse 가 간헐(3d/2주)이라 노출 중첩 시간 자체가 짧음(duty-cycle 0.21) → DDI 시간적분도 그만큼 작음 (M5 duty-cycle 논리의 부수 이득). 단 **이 특정 조합의 DDI 정량은 미평가 → 🟠** (M9 임상 DDI 연구).

---

## §4 CMC · 제형/안정성 · OTC vs Rx (high-level)

### §4.1 oral solid dosage · CMC 골격

```
   ── 정제 조성 골격 (backbone IR tablet · 예시 구조, 정량 미확정) ──
   ┌───────────────────────────────────────────────────────┐
   │ 활성 (S1P modulator)         저용량 (mg 단위, 라벨 용량) │
   │ 희석제   (lactose / MCC)     bulk · 압축성              │
   │ 붕해제   (croscarmellose)    IR 신속 붕해               │
   │ 활택제   (Mg stearate)       타정                       │
   │ 용해보조 (고친유 logP~5 → 계면활성제/고체분산)  ★ etrasimod│
   │ film coat (안정성·차광)                                  │
   └───────────────────────────────────────────────────────┘
   pexidartinib pulse cap: 기존 Turalio 250mg IR capsule 형식 차용
                           (저지방식 동반 라벨 — food-effect 표준화)
```

- **용해도 과제**: etrasimod logP ~5 (고친유) → 용출 한계 가능 → 고체분산(amorphous solid dispersion)·계면활성제 부형제 또는 염(arginine salt) 활용. ozanimod/fingolimod 는 logP 중간이라 표준 IR 로 충분.
- **안정성**: S1P modulator·pexidartinib 모두 기존 FDA 승인 고체제형 존재 → 단일성분 안정성 프로파일은 라벨 확보(🟡). **조합/co-pack 안정성**(blister 내 상호작용·습도·차광) batch 데이터는 미생산 → 🟠 (M7 후속 CMC 단계 ICH Q1A 안정성 시험).
- **제조 적합성**: 두 약 모두 직접압축/캡슐충전 표준 공정 호환 (신규 합성 불요 — 기존 API 차용) → CMC risk 낮음. co-packaging(blister·요일/펄스 라벨링)이 주된 신규 제조 요소.

### §4.2 OTC vs Rx 포지셔닝

```
   ┌──────────────────────────────────────────────────────────────┐
   │  Rx (처방) 확정 — OTC 불가                                     │
   │  근거: ① 전신 면역조절 (S1P=림프구감소·서맥·황반 black box ·   │
   │           pexidartinib=간독성 black box, REMS)                 │
   │        ② pulse dosing 정밀도 + CBC/간효소/심전 모니터링 필수   │
   │        ③ M6 window 미입증 (🟠) — 의료 감독 하 dose 관리 요구   │
   │  → cosmetic 적응증이라도 immunomodulator 조합은 본질적 Rx.     │
   └──────────────────────────────────────────────────────────────┘
```

- 미용(tattoo fade) 적응증이지만 활성이 면역조절제이므로 **Rx 전용** (전문의약품). pexidartinib 은 미국 REMS(간독성) 대상 — pulse 라도 모니터링 동반. S1P modulator 는 first-dose 심전·안과 검사·CBC 추적 요구.
- 규제 경로: 신규 적응증의 **505(b)(2)**(기승인 약 데이터 차용) 또는 조합제품(combination product) 경로 가능성 — 단 fade efficacy 임상(M8/M9) 선행 필수. 본 M7 은 그 이전 *설계* 단계.

---

## §5 per-claim tier ledger (project rubric · positive 강제 금지)

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | combination = S1P modulator(연속) + pexidartinib(펄스) 분리 투여; FDC 는 리듬 충돌로 불가 | 🔵→🟠 | duty-cycle 논리 = M5 closed-form 귀결(🔵 형태) / 이 조합의 실제 채택 적합성 = 🟠 |
| 2 | k_eff = k_emig+(1−r)k_death 의 3-lever ↔ agent 매핑 (S1P=k_emig · CSF1R pulse=k_death+r↓) | 🔵 SUPPORTED-FORMAL | path_B §2 + M5 model 직접 매핑 |
| 3 | etrasimod/ozanimod/fingolimod/pexidartinib = 승인 경구약 · BA·t½·food-effect 값 | 🟡 SUPPORTED-BY-CITATION | Velsipity/Zeposia/Gilenya/Turalio FDA 라벨 |
| 4 | pexidartinib 저지방식 +60%/고지방 +100% 흡수↑ · CYP3A4+UGT1A4 기질·CYP3A4 perpetrator | 🟡 SUPPORTED-BY-CITATION | Turalio 라벨·food-effect 연구 |
| 5 | fingolimod t½ 6–9일 → pulse backbone 부적 / etrasimod·ozanimod t½ QD 적합 | 🟡 SUPPORTED-BY-CITATION | 각 라벨 PK |
| 6 | r↓ 레버 = CSF1R pulse 의 depletion→repopulation 부수효과 (별도 경구약 불요) | 🟡 SUPPORTED-BY-CITATION | Baranska 2018 window + clodronate 경구 BA 낮음(문헌) |
| 7 | pulse 가 r↓ window 를 열고 그 위에서 emigration 작동 (위상 정렬) | 🟡→🟠 | 기전 정렬 Baranska(🟡) / 인간 fade 기여 정량 미입증(🟠) |
| 8 | pulse duty-cycle(on 3d/period 14d ≈0.21)이 DDI 시간적분도 축소 | 🔵 형태 / 🟠 값 | M5 duty-cycle closed-form 귀결(🔵) / 이 조합 DDI 정량 미평가(🟠) |
| 9 | 이 특정 조합의 fade efficacy · DDI 안전 · co-pack 안정성 | 🟠 INSUFFICIENT/DEFERRED | novel combination 미임상 — M8/M9 + ICH Q1A 안정성 |
| 10 | Rx 전용 포지셔닝 (면역조절 black box + 모니터링 + window 미입증) | 🟡 SUPPORTED-BY-CITATION | S1P/pexidartinib 라벨 black box·REMS |
| 11 | etrasimod logP~5 용해도 → 고체분산/염 부형제 필요 | 🟢→🟠 | logP citation(🟡)→용출 한계 추론(🟢)/실제 batch 미생산(🟠) |
| 12 | DDI 회피 관점 ozanimod backbone(MAO-B 주경로, CYP 비중첩) 우위 | 🟠 INSUFFICIENT/DEFERRED | 조합 DDI 미평가 — 정성 추론만 |

```
   tier 분포:  🔵 1  ·  🔵→🟠 2  ·  🟡 6  ·  🟢→🟠 1  ·  🟠 2  ·  🔴 0
   ───────────────────────────────────────────────────────────────────
   3-lever↔agent 매핑·duty-cycle 귀결 = 닫힘(🔵 형태).
   실제 FDA 약 BA/PK/food/CYP/black box = 🟡 (라벨 citation).
   이 조합의 fade efficacy·DDI 정량·co-pack 안정성 = 🟠 deferred (M8/M9).
   → positive verdict 강제 안 함. M7 은 "제형 설계 + pulse 매핑 + CMC 골격"
     까지가 completed-form; 임상/생동성/안정성 batch 는 wet-lab gate.
```

---

## §6 정직 결론 + next

- **combination**: S1P1 modulator (etrasimod 또는 ozanimod) **연속-저용량 QD backbone** + pexidartinib **간헐 pulse (3d/2주)** + 비약물 lymph-flow adjunct. FDC 불가(리듬 충돌) → **co-packaged blister 분리 투여**.
- **pulse schedule**: 격주 펄스 (M5 §4) — pexidartinib on=3d / period=14d (duty-cycle ≈0.21, TI gain ~4.7×) 또는 월간 옵션(period 30d, TI gain ~10×). S1P backbone 은 매일 연속. r↓ window·lymph-flow 보조는 pulse 직후 7–10d 집중.
- **CMC/positioning**: 기존 API 차용(신규 합성 불요) → 제조 risk 낮음, 주신규 요소 = co-packaging. **Rx 전용 확정** (면역조절 black box + 모니터링 + M6 window 미입증).
- **honest**: 실제 약 BA/PK/food/CYP = 🟡 (라벨). **이 조합의 fade efficacy·DDI·co-pack 안정성 = 🟠** (M8 ex-vivo/PK PoC · M9 in-vivo + ICH Q1A 안정성). absorbed=false 유지 (M6 window gate 미해소 · 이 제형이 그 가정을 해소하지 못함, 단 pulse duty-cycle 로 DDI·독성 시간적분을 줄여 window 측 부담을 낮추는 설계).
- next:
  - **M8-ORAL** — ex-vivo / PK PoC: 경구 dose → 진피 잉크 노출 + pulse window 재포획 억제 phi 측정 (M5 per-pulse phi 절대값 🟠 닫기).
  - **M9-ORAL** — in-vivo: 조합 DDI · 독성 회복 timescale (M5 §5 W3 핵심 가정) · fade timeline.
  - **CMC 후속** — co-pack 안정성 ICH Q1A · etrasimod 고체분산 용출 · 생동성(BE) 설계.

---

## Cross-reference

- M4 lead: `M4_candidates.md` §2.1(B1 CSF1R/pexidartinib · B2 S1P/CCR7) · §3.2(track B top-2 lead · open gap)
- M5 model: `M5_pulsed_pkpd.md` §1(k_eff·phi·n90) · §3(TI ~period/on) · §4(full 3-lever 격주 ~7mo)
- 3-lever thesis: `B_breakthrough_roadmap.md` (W3 pulsed sub-toxic combination · W2 t_90 closed-form)
- safety/DDI 노출: `M6_systemic_safety.md` §1(간 1차통과 CYP 노출 map) · §2.2(면역조절 window) · §4.2(B-gate)
- 레버 기전: `path_B_macrophage_migration.md` §1(capture-release-recapture) · §3(4 레버 · CSF1R/S1P precedent · safety)
- @D d1 (non-wet-lab 완료형) — M7 은 제형 설계+pulse 매핑+CMC 골격까지 completed-form; 임상/생동성/안정성 batch 는 M8/M9
- @D d2 (wall breakthrough) — "불가능" 미언급; FDC 충돌 wall 을 pulse-timed 분리 + co-pack 로 해소, DDI wall 을 duty-cycle 로 환원
- @D d5/d6 (정직·first-principles) — 라벨 PK citation·M5 closed-form duty-cycle 만 사용, positive 강제 없음, ML 의존 X
