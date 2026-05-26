# TTR-ORAL — M8/M9 + measured-oracle: track B wet-lab 검증 설계 (정직 deferral)

> milestone: TTR-ORAL.md **M8-ORAL** (ex-vivo / PK PoC) · **M9-ORAL** (in-vivo efficacy+safety) · **measured-oracle PASS → absorbed=true**
> base: `M5_pulsed_pkpd.md` (pulsed 모델 · 핵심 measurable "독성 회복 timescale < pulse period") · `M6_systemic_safety.md` (전신 safety gate · TI 틀) · `path_B_macrophage_migration.md` (Baranska capture–release–recapture)
> 정직 원칙 (@D d1/d5/d6): 이 문서는 **wet-lab / live-animal 의존 단계의 설계**다. 결과를 주장하지 않는다 — 무엇을 측정하면 무엇이 결정되는지만 닫는다. NON-wet-lab 단계(M5/M6 closed-form·numerical)는 완료로 driven, **measured-oracle PASS 까지 absorbed=false 유지**. 🟠 DEFERRED 명시.

## TL;DR

M5 가 만든 closed-form 예측(n90 = log(0.1)/log(1−phi) · TI_pulsed/TI_chronic ≈ period/on-time)을 **falsifiable oracle** 로 환산한다. M8 은 live-animal 없이 측정 가능한 3량(ex-vivo emigration k_emig · per-pulse phi · oral combo PK)을 잡고, M9 는 tattooed-mouse 에서 **W3 measurable(독성 회복 timescale vs pulse period)** + **W1 measurable(skin clearance % · dLN ink burden)** 을 동시 측정한다. oracle PASS 4조건 모두 M5 수치에 묶여 거짓화 가능. 현 상태 = **🟠 DEFERRED** (외부 wet-lab/생체 의존) · absorbed=false.

---

## §0 무엇이 deferred 이고 무엇이 닫혔나 (정직 경계)

```
   ┌─ NON-wet-lab (닫힘 · @D d1 driven to completion) ──────────────┐
   │  M5 pulsed 모델 closed-form (n90 · phi · TI gain)      🔵/🟢   │
   │  M6 전신 off-target map + TI 형태 (window 부등식)       🔵     │
   │  path_B 1차 동역학 (k_eff = k_emig + (1−r)k_death)      🔵     │
   └───────────────────────────────────────────────────────────────┘
                              │  예측을 oracle 로 환산 (이 문서)
                              ▼
   ┌─ wet-lab / live-animal (이 문서가 설계만) ─── 🟠 DEFERRED ─────┐
   │  M8  ex-vivo emigration · per-pulse phi · oral combo PK        │
   │  M9  tattooed-mouse fade timeline + 독성 회복 timescale        │
   │  oracle  4-조건 PASS → absorbed=true                          │
   └───────────────────────────────────────────────────────────────┘
```

정직 명제: M5 가 닫은 것은 *모델의 self-consistency 와 ratio* 다 — phi·k_emig·독성 회복 timescale 의 **절대값은 모두 measured**(M5 §5 tier ledger 의 🟠 두 줄). 따라서 absorbed gate 는 본질적으로 이 세 절대값에 걸려 있고, 그 측정이 M8/M9 다.

---

## §1 M8-ORAL — ex-vivo / PK PoC (live-animal 없이 측정)

목표: live-animal 없이 M5 의 3개 미측정량을 잡아 M9 의 dose/schedule 를 선결정한다.

### §1.1 측정 3종 ↔ M5 변수 매핑

| # | 측정 (ex-vivo / in-vitro) | M5 변수 | 방법 | go 임계 |
|---|---|---|---|---|
| **A1** | 진피 macrophage emigration rate k_emig (개입 ± ) | `k_emig` (k_eff 항) | ex-vivo skin explant + afferent-lymph mimic transwell, CCR7/S1P agonist ± | 개입군 k_emig / 자연 ≥ 3× (M5 "emig only" phi 0.073 재현) |
| **A2** | per-pulse 잉크 release 분율 phi | `phi = 1−exp(−k_eff·tau_win)` | ex-vivo explant 펄스 노출 1 cycle 후 잔존 색소 정량(이미지/ICP) | phi ≥ 0.10 (M5 n90 ≈ 22 — 격주 ~11 mo 권) |
| **A3** | oral combo PK (B2 emig + B1 CSF1R pulse) | dose → C_dermis (path_B k_eff 구동) | rodent plasma + skin biopsy LC-MS/MS · Kp,dermis 추정 | C_dermis ≥ m_eff (M6 TI_B 의 효과 측 threshold) |

### §1.2 ex-vivo emigration assay (A1·A2 — Baranska 정량판)

```
   ex-vivo skin explant (mouse tail / human discard)
   ┌────────────────────────┐
   │  진피 (잉크-load Mφ)    │  ← t0 색소 부하 정량 (baseline N₀)
   │      │ emigration       │
   │      ▼                  │   상부 chamber: CCR7/S1P agonist ± (k_emig knob)
   │  transwell (3-5 μm)     │   하부 chamber: CCL21 gradient (afferent-lymph mimic)
   │      │                  │
   │  migrated Mφ + 색소 ────┼──► 하부 회수 → 색소 정량 = phi (1 pulse 등가)
   └────────────────────────┘
   readout: HMB-45(잉크색소) · F4/80/CD68(Mφ) · 하부/상부 색소비 = phi_exvivo
```

- **k_emig** = (하부 migrated 색소) / (N₀ · tau_win) — 자연 대비 boost 비.
- **phi_exvivo** = 1 cycle 후 (제거 색소)/(N₀) — M5 §3[1] 의 phi 직접 대응.
- recapture knob(r): explant 에 신규 Mφ 재증식 차단(CSF1R inhibitor) ± 으로 (1−r) 변화 측정.

### §1.3 M8 go/no-go

```
   M8 GO  ⟺  A1(k_emig ≥3×)  AND  A2(phi ≥0.10)  AND  A3(C_dermis ≥ m_eff)
   ── 하나라도 FAIL → M9 진입 전 M7 제형 / M4 후보 재선정 루프 (닫힌 부정 아님)
   ── 전부 PASS → M9 dose/schedule 확정 (phi → n90 → pulse period 역산)
```

> tier: A1–A3 설계는 closed-form 매핑(🔵)이나 **측정값 자체는 🟠 DEFERRED** (ex-vivo wet-lab). M8 은 absorbed 을 flip 하지 않는다 — in-vivo 회복 timescale(W3)이 미측정이므로.

---

## §2 M9-ORAL — in-vivo tattooed-mouse fade-timeline 연구

목표: M5 의 두 measurable 을 *동시에* 측정 — (W3) **독성 회복 timescale vs pulse period** · (W1) **skin clearance % + dLN ink burden**.

### §2.1 모델 + 핵심 endpoint

```
   tattooed mouse (C57BL/6, 진피 표준 잉크 tattoo · n90 readout 가능 면적)
   ── intravital 2-photon (Baranska 방식) 로 동일 부위 종단 추적 ──
   측정축 2개 (M5 가 결정 대기 중인 바로 그 둘):
   ┌──────────────────────────────────────────────────────────────┐
   │ W1  skin clearance(t) = 1 − N(t)/N₀     ↔ M5 n90 곡선         │
   │ W3  독성 회복 timescale τ_rec vs pulse period T               │
   │       (τ_rec < T  ⟺  M5 TI gain ≈ T/on-time 가정 성립)        │
   └──────────────────────────────────────────────────────────────┘
   부수 W1: dLN(배수 림프절) ink burden — relocation≠erase 안전 확인
```

### §2.2 cohort (pulse schedule = M5 [3] 의 period/on 격자)

| cohort | 개입 | pulse period T | on-time | M5 예측 (TI gain · n90) | 검증 대상 |
|---|---|---|---|---|---|
| C0 vehicle | 없음 (자연 fade) | — | — | phi 0.006 · n90 ≈ 409 | baseline / 거짓화 대조 |
| C1 chronic | full 3-lever 연속 | (연속) | (연속) | TI gain 1× (window 無) | W3 회복 가정 反例 |
| **C2 pulse-30/3** | full 3-lever | 30 d | 3 d | **TI ~10× · n90 ≈14 (~7 mo 격주환산)** | **주력 — W3+W1** |
| C3 pulse-30/5 | full 3-lever | 30 d | 5 d | TI ~6× | on-time 민감도 |
| C4 pulse-14/3 | full 3-lever | 14 d | 3 d | TI ~4.7× · 더 빠른 누적 | period 민감도 |
| C5 emig-only | B2 단독 | 30 d | 3 d | phi 0.073 · n90 ≈30 | lever 분해 (A1 in-vivo 확인) |

> n=8–10/cohort (sex-balanced) · 사전 power 계산은 phi 분산(M8 A2)에서 산출 · 종단 동일-동물 imaging 으로 within-subject 변동 흡수.

### §2.3 readout 패널 (W1 efficacy + W3 safety 동시)

| 축 | readout | 시점 | M5/M6 연결 |
|---|---|---|---|
| W1 efficacy | intravital 2-photon skin clearance %(종단) · HMB-45/색소 면적 | 0,2,4,6,9,12 mo | M5 n90 곡선 fit → phi_invivo 역산 |
| W1 efficacy | 종료 histology: 진피 잔존 색소 + Mφ marker(F4/80·CD68) | 종료 | capture–release–recapture 잔여 (path_B §1) |
| W1 safety | dLN + 원거리 장기 ink burden (ICP-MS 금속 · 조직 색소) | 종료 | relocation 경계 — dLN 외 전신 분산 無 (M6 B-G4) |
| W3 safety | CBC(호중구·림프구) · 감염 surveillance — **펄스 후 회복 곡선** | 각 pulse off 구간 dense | **τ_rec 측정** (M5 핵심 가정) |
| W3 safety | 간효소(ALT/AST)·신(BUN/Cr)·골 turnover — pulse 간 회복 | 각 pulse off 구간 | M6 전신 off-target 장기 (간·신·골수) |
| W3 safety | Kupffer/osteoclast 고갈·재증식 (CSF1R lever) | 종료 ± 중간 | M6 §2.2 (a) lever window |

### §2.4 τ_rec 측정이 W3 를 닫는 방식 (핵심)

```
   각 pulse 후 독성 marker(예: 호중구 최저점 → 회복) 곡선에서 τ_rec 추출:

   marker  │      ╲                  ╱‾‾‾‾  ← 회복 (repopulation)
   (정상)  │       ╲                ╱
           │        ╲______________╱
           │        ▲  on   ▲ off  ▲
           │       pulse    │      회복 완료
           └────────────────┼──────────────► t
                            │  τ_rec ─┤
   판정:  τ_rec < T (pulse period)  ⟺  누적 독성이 chronic 처럼 안 쌓임
          ⟺  M5 §2 비선형 2조건 中 "독성 펄스 사이 회복" 성립
          ⟺  TI_pulsed/TI_chronic ≈ T/on-time (M5 [3]) 가 in-vivo 로 입증
   반례:  τ_rec ≥ T → 독성 누적 → C2 가 C1(chronic) 처럼 행동 → W3 falsified
```

이것이 M5 §5 tier ledger 의 🟠 "독성 회복 timescale < period" 를 거짓화 가능하게 만드는 단일 측정이다.

### §2.5 timeline (study Gantt)

```
   mo  0   1   2   3   4   5   6   7   8   9   10  11  12
   ────┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┼───┤
   tattoo + baseline imaging   █
   dosing (C2 pulse 30/3)      ▓░░░▓░░░▓░░░▓░░░▓░░░▓░░░▓  (▓=on 3d · ░=off 회복)
   intravital imaging          █   █       █       █   ...   █   (0,2,4,6,9,12)
   CBC/장기 tox (pulse off dense)  ··· ··· ··· ··· ··· ··· ···  τ_rec 추출
   dLN/장기 ink burden                                          █ (종료)
   histology (HMB-45·Mφ)                                        █ (종료)
   ────────────────────────────────────────────────────────────
   1차 readout = 6 mo (M5 ~7 mo 격주환산 부근) · 확정 = 12 mo
```

> tier: M9 전체 = **🟠 DEFERRED** (live-animal · 외부 GLP/IACUC 의존). 본 문서는 설계·예측·판정규칙만 제시 · 결과 미주장.

---

## §3 measured-oracle — absorbed=true 를 flip 하는 falsifiable PASS 기준

@D d5: absorbed=true ⇔ 모든 non-wet-lab gate PASS. 단 oral track 의 결정 gate(phi 절대값 · τ_rec · TI_B window)는 본질적으로 measured → oracle 은 **measured PASS** 로 정의되고, 그 전엔 absorbed=false. 각 조건을 M5/M6 의 닫힌 예측에 묶어 거짓화 가능하게 한다.

| oracle | 측정량 (M9) | PASS 기준 | 묶인 M5/M6 예측 | wall |
|---|---|---|---|---|
| **O1 skin clearance** | intravital clearance %(종료) | C2 ≥ 90% (또는 cosmetic "skin 안 보임" endpoint) | M5 n90 — phi_invivo 가 n90 곡선에서 12 mo 내 90% 도달 | W1 |
| **O2 fade timeline** | 90% 도달 월수 | ≤ 12 mo (목표 ~7 mo 격주) · C0 대비 단축 ≥ 6× | M5 §4: full 3-lever ratio ~6×(7년→~14 mo) · 격주 ~7 mo | W2 |
| **O3 systemic TI margin** | τ_rec vs T + 장기 NOAEL | **τ_rec < T** AND TI_B ≥ 10 (M6 B-G1) | M5 [3] TI gain ≈ T/on-time (회복 가정) · M6 TI_B = m_tox/m_eff | W3 |
| **O4 lymph-node safety** | dLN + 전신 장기 ink burden | dLN 착색 한정 · 원거리 장기 ink 무유의 · 발암 surveillance clean | M6 B-G4 (relocation→전신 분산 無) | W1 안전 |

```
   measured-oracle PASS  ⟺  O1 ∧ O2 ∧ O3 ∧ O4   (모두 measured · 모두 M5/M6 예측에 묶임)
   ───────────────────────────────────────────────────────────────────────────────
   PASS  → absorbed=true  (W1 cosmetic + W2 속도 + W3 window 전부 실측 입증)
   FAIL  → absorbed=false 유지 + 어느 oracle 이 깨졌나 = 어느 M5/M6 예측이 falsified 인지 직결
          (예: O3 의 τ_rec ≥ T → M5 회복 가정 反例 → W3 NO-GO 정직 기록 · @D d2 돌파 루프)
```

거짓화 가능성 명시: O1–O4 는 각각 단일 측정으로 PASS/FAIL 이 갈리고, FAIL 시 *어느 closed-form 가정이 깨졌는지*가 일대일로 매핑된다 — 이것이 oracle 을 falsifiable 하게 만든다 (positive 강제 금지 · @D d6).

---

## §4 tier 판정 (project rubric · positive 강제 금지)

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | M8 A1–A3 / M9 cohort 설계가 M5 변수(k_emig·phi·TI gain)에 일대일 매핑 | 🔵 SUPPORTED-FORMAL | M5 closed-form 변수 → 측정 endpoint 직접 대응 |
| 2 | oracle O1–O4 PASS ⟺ absorbed=true 의 부등식 구조 | 🔵 SUPPORTED-FORMAL | @D d5 gate 정의 + M5/M6 예측 묶음 |
| 3 | τ_rec < T 가 M5 TI gain ≈ T/on-time 을 검증/거짓화 | 🔵 형태 SUPPORTED-FORMAL | M5 §2 비선형 2조건의 직접 측정 환산 |
| 4 | M8 ex-vivo k_emig·phi 절대값 | 🟠 DEFERRED | ex-vivo wet-lab 미수행 (외부 의존) |
| 5 | M9 skin clearance · τ_rec · dLN burden 절대값 | 🟠 DEFERRED | live-animal 미수행 (GLP/IACUC 외부 의존) |
| 6 | absorbed=true 여부 | 🟠 DEFERRED | measured-oracle PASS 전까지 false 유지 |

```
   tier 분포:  🔵 3  ·  🟢 0  ·  🟡 0  ·  🟠 3  ·  🔴 0
   ────────────────────────────────────────────────────
   설계·매핑·oracle 부등식 = 닫힘 (🔵).
   모든 측정 절대값 + absorbed flip = 🟠 DEFERRED (wet-lab/live-animal).
   → positive verdict 강제 안 함. "설계는 first-principles 상 닫히고
      falsifiable 하나, 측정은 외부 생체 의존으로 미수행 — absorbed=false 유지."
```

---

## §5 정직 결론 + next (@D d1/d2/d5/d6)

- **NON-wet-lab 은 완료로 driven**(@D d1): M5/M6 closed-form·numerical + 본 문서의 oracle 환산까지 — 측정 직전 단계까지 모두 닫힘.
- **measured-oracle 는 4-조건 falsifiable**: O1(clearance ≥90%) · O2(≤12 mo · ≥6× 단축) · O3(τ_rec < T ∧ TI_B ≥10) · O4(dLN 한정). 각각 M5/M6 의 닫힌 예측에 묶여 FAIL 시 어느 가정이 깨졌는지 직결.
- **absorbed=false 유지** (@D d5): M8/M9 미수행 · 어떤 wet-lab 결과도 주장하지 않음. 본 문서는 *설계와 판정규칙* 만 제공.
- **닫힌 부정 아님**(@D d2): 각 go/no-go FAIL 마다 돌파 루프 명시 — M8 FAIL→M7 제형/M4 후보 재선정 · O3 FAIL(τ_rec ≥ T)→M6 §6.1 돌파 경로(이중-cage·A+B hybrid·lever 조합).
- next: M7-ORAL(B 경구 제형 확정 → M8 dose 입력) · M8 ex-vivo 실행(외부 wet-lab 파트너 · 🟠) · M9 IACUC/GLP 프로토콜 제출(외부 · 🟠) · V3 numerical(PBPK 진피 농도 → A3 C_dermis 사전 예측).

## Cross-reference

- M5 pulsed 모델: `M5_pulsed_pkpd.md` §1(k_eff) · §3[1](phi→n90) · §3[3](TI gain ≈ period/on) · §5(🟠 τ_rec·phi measured)
- M6 전신 safety: `M6_systemic_safety.md` §2.2(TI_B window) · §4.2(B-G1..G4 gate) · §6.1(돌파 경로)
- path_B 생물학: `path_B_macrophage_migration.md` §1(capture–release–recapture · Baranska 2018 PMID 29511065) · §2(k_eff·t½) · §4(relocation≠erase caveat)
- @D d1: NON-wet-lab 단계(M5/M6/oracle 환산) 완료로 driven · @D d2: 모든 FAIL 에 돌파 루프 · @D d5: absorbed=false 유지(measured PASS 전) · @D d6: oracle falsifiable · positive 강제 없음 · first-principles(M5 closed-form 묶음)만 사용
