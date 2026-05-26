# TTR-ORAL — M5b: per-pulse 잉크-release 분율 φ 의 실측 grounding (track B)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> 목표: M5 가 **가정(🟠)** 으로 둔 per-pulse φ (≈0.15) 를 실제 문헌 측정값으로 grounding.
> φ = capture–release–recapture **1 사이클(≈90일)당** 재포획을 탈출해 림프로 배수되는 색소 분율.
> 방법: 문헌 mass-balance + fade timescale → φ 범위 도출 → 검증된 M5/M9 모델에 넣어 n90·timeline 재계산.
> sim = `sim/m5b_phi.hexa`. M9 (τ_rec grounding) 의 자매편 — 그쪽은 **safety knob**, 이쪽은 **efficacy knob**.

---

## 1. 문헌 실측값 (🟡 SUPPORTED-BY-CITATION)

φ 의 *직접* 측정값은 문헌에 **없다**(아래 §2 에서 정직히 명시). 대신 두 종류의 mass-balance 가 φ 를 **양쪽에서 bound** 한다.

| 측정량 | 실측값 | 위상 | 출처 |
|---|---|---|---|
| 주입 색소 중 dLN 으로 translocate (6주) | **~32 %** | 초기(fast) | Sepehri/Engel 계열 · ScienceInsights 종합 |
| 주입 색소 중 dLN 으로 translocate (평생, 누적) | **60–90 %** (일부 "as much as 99 %") | 누적 | BfR/뉴스 종합 · ScienceInsights |
| 적색 색소 피부 농도 감소 (수년 후 vs fresh) | **87–99 % ↓** | 누적(수년) | Lehner et al. 2011 (*JEADV*) PMID 21349116 |
| 림프 도달 동역학 | 주입 후 **수분 내 peak** · 주 첫날~수주가 主 transport | 초기(fast) | Synchrotron νXRF (Sci Rep 2017) |
| porcine 색소 biokinetics | dLN **fast distribution · 7일 후 steady-state** | 초기→고원 | 28-day porcine model (PMC10997244) |
| recapture 효율 r | "**대부분(majority) 재포획**되나 perfect 아님" — 일부는 keratinocyte 등 단명세포에서도 검출(오래된 타투에서도) | 정성 only | Baranska 2018 (CD64dtr 모델) PMID 29511065 |
| 자연 fade 형태 | **첫해 가장 빠름 → 이후 점진 둔화** (생체 biphasic) | — | nipple-areola fade (PMC11288766) · 임상 종합 |

### 1.1 두 위상(biphasic) 을 분리해야 한다 — φ 정의의 핵심

```
   주입
    │   [위상 A · fast]              [위상 B · slow steady-state]
    │   healing window               recapture-locked
    │   ~수분~수주, day-7 고원         ~90일 capture-release-recapture 사이클
    ▼   ┌─────────────┐             ┌──────────────────────────────┐
   ████ │ 32%→6wk 배수 │ ───────────▶│ 87-99% over 수년 (느린 tail)  │
        └─────────────┘             └──────────────────────────────┘
        ← 측정 풍부(문헌 here)        ← M5 가 모델하는 위상(φ 의 정의역)
```

⚠ **함정**: 문헌이 풍부히 측정한 32 %/6주·"수분 peak" 는 **위상 A (fresh 타투의 healing 배수)** 다. M5 의 φ 는 **위상 B (recapture-locked steady-state, 사이클≈90일)** 의 per-cycle 분율 — *전혀 다른 양*이다. 위상 A 숫자를 그대로 φ 로 쓰면 낙관 과대평가가 된다 (§2).

---

## 2. φ 의 정직한 도출 — 어디서 문헌이 침묵하는가

**직접 φ 는 미측정.** 따라서 M5 의 정의(위상 B, 90일 사이클)에 맞춰 *역산*한다:
색소가 lifetime L (년) 동안 분율 f 만큼 소실되고, 한 사이클=0.25 년이면 사이클 수 N = L/0.25,
정상상태 등비감쇠 가정 하에 `(1−φ)^N = 1−f` → **φ = 1 − (1−f)^(1/N)**.

- **f (lifetime loss)**: 적색-색소 피부 87–99 % ↓ (Lehner) · dLN 누적 60–99 % · 보수적 하한 50 %.
- **L (lifetime)**: path_B §2.1 의 자연 t½ ≈ 7년 → N=28 · "decades persistence" → 20년 → N=80.

위상 A (32 %/6주) 는 **상한 bracket** 으로만 환산 (steady-state 아님을 명시).

⇒ 정직 결론: **φ 의 절대값은 문헌이 직접 주지 않는다.** lifetime-loss + 90일 사이클로 bound 하면 정상상태 φ 는 **수% 대**이며, M5 의 0.15 는 **가장 낙관적 끝(7년·99% 소실)에서만** 닿는다.

---

## 3. hexa-native 재계산 (verbatim · 🟢 SUPPORTED-NUMERICAL · per @D g5)

```
=== TTR-ORAL M5b phi grounding ===

[1] STEADY-STATE per-cycle phi from lifetime loss f over L years (90d cycle):
  L=7yr  (N=28): f=0.50 phi=0.0244514 f=0.87 phi=0.0702737 f=0.99 phi=0.151657
  L=20yr (N=80): f=0.50 phi=0.00862691 f=0.87 phi=0.0251803 f=0.99 phi=0.0559391

[2] EARLY-PHASE phi (fast healing drainage; NOT steady-state):
  32% in 6wk -> per-90d-equiv phi =0.562387 (upper bracket only)

[3] phi -> n90 -> fade time (T from M9: 21d / 28d sweet spot):
  phi=0.02 n90=113.974 -> T=21d 78.7321mo  T=28d 104.976mo
  phi=0.05 n90=44.8906 -> T=21d 31.0099mo  T=28d 41.3466mo
  phi=0.10 n90=21.8543 -> T=21d 15.0968mo  T=28d 20.129mo
  phi=0.15 n90=14.1681 -> T=21d 9.78718mo  T=28d 13.0496mo (M5 assumed)

[4] implied recapture fraction r (release-per-cycle ~ 1):
  phi=0.02 -> r~0.98
  phi=0.05 -> r~0.95
  phi=0.10 -> r~0.9
  phi=0.15 -> r~0.85

=== M5b done ===
```

(`pow(`/`log(` 빌트인 사용 · float-literal. M5 의 [1] φ→n90 와 동일 closed-form 으로 cross-check: phi=0.05 n90=44.89 · phi=0.15 n90=14.17 — M5_pulsed_pkpd.md §3 와 **자릿수까지 일치** → self-consistent.)

---

## 4. 결과 표 — grounded φ 범위와 fade timeline (정직 · 낙관 강제 금지)

### 4.1 φ 의 honest 범위

| anchor (f, L) | per-cycle φ | 위상 | 신뢰 |
|---|---|---|---|
| f=0.50, L=20yr | **0.009** | B steady-state | 보수 하한 |
| f=0.87, L=20yr | 0.025 | B | 중앙-보수 |
| f=0.50, L=7yr | 0.024 | B | 중앙-보수 |
| f=0.87, L=7yr | **0.070** | B | 중앙 |
| f=0.99, L=7yr | **0.152** | B | 낙관 상한 (= M5 가정에 우연 일치) |
| 32 %/6주 환산 | 0.56 | **A (steady-state 아님)** | 상한 bracket only |

> **정직 grounded φ 범위 = 0.02–0.10** (정상상태 위상 B, 중앙대) · 넓게 **0.009–0.15** (보수~낙관).
> M5 의 **φ=0.15 는 grounded 범위의 낙관 상한** (7년 lifetime + 99 % 소실에서만 도달). 중앙값은 그 **1.5–7× 작다**.

### 4.2 fade timeline 함의 (n90 × T · M9 의 T=21–28일 sweet spot)

```
   φ 가 작아질수록 fade 가 길어진다 (n90 = log0.1/log(1-φ), total = n90·T)
   φ=0.15  ████ 13mo (T=28d)   ← M5 옛 가정 (낙관 상한)
   φ=0.10  ██████ 20mo
   φ=0.05  ██████████████ 41mo (~3.4yr)
   φ=0.02  ███████████████████████████████████ 105mo (~8.7yr)
```

| φ (grounded) | n90 (pulses) | T=21d (3주) | T=28d (4주) | 해석 |
|---|---|---|---|---|
| 0.02 (보수) | 114 | ~79 mo | ~105 mo | **수년~10년** — 펄스해도 자연과 큰 차이 X |
| 0.05 (중앙-보수) | 45 | ~31 mo | ~41 mo | **~3–3.5년** |
| 0.10 (중앙-낙관) | 22 | ~15 mo | ~20 mo | **~1.5년** |
| 0.15 (M5 가정) | 14 | ~10 mo | ~13 mo | ~1년 (낙관 상한) |

> **timeline 정직 수정**: M9 의 "3–4주 펄스 → ~10–13개월" 은 **φ=0.15 (낙관 상한)** 에서만 성립. grounded **중앙 φ=0.05** 면 같은 3–4주 펄스로 **~3–3.5년**, 보수 φ=0.02 면 **수년~10년**. ⇒ φ 의 절대값이 **속도 게이트의 지배 인자**이고, 문헌은 이를 낙관쪽으로 강제하지 않는다.

### 4.3 recapture 분율 r

문헌은 r 의 **숫자를 주지 않는다** ("majority recaptured, not perfect" — 정성). per-cycle release≈1 가정 하 φ=(1−r)·release ⇒ **r ≈ 1−φ ≈ 0.85–0.98**. path_B §2.1 의 "r≈0.99+" 정성과 정합 — r 을 0.99→0.95 로 조금만 내려도 φ 가 5×(0.01→0.05) 뛰는 leverage 구조 그대로. **즉 efficacy lever 의 본질은 여전히 recapture 억제** (path_B 결론 재확인).

---

## 5. tier 판정 (per `hexa verify rubric` · 정직)

| claim | tier | 근거 |
|---|---|---|
| φ = 1 − (1−f)^(1/N) 역산식 · n90=log0.1/log(1−φ) | 🔵 closed-form | 등비감쇠 identity |
| §3 hexa 재계산 (φ·n90·timeline·r) | 🟢 verbatim | hexa run 위 · M5 §3 와 자릿수 일치 |
| 32 %/6주 · 60–99 % 누적 · 87–99 % 적색 피부 · 90일 사이클 · day-7 고원 | 🟡 문헌 | Lehner 2011 · Sepehri/Engel · porcine · Baranska |
| **steady-state(위상 B) per-cycle φ 의 직접 측정값** | 🟠 미측정 | 문헌은 위상 A(fast) + lifetime 누적만 — per-cycle φ 는 lifetime 에서 *역산* (가정: 등비·release≈1) |
| recapture r 의 **수치** | 🟠 미측정 | Baranska 정성("majority")만 — r≈1−φ 는 모델 추론 |
| φ=0.15 가 대표값 | 🔴→정정 | grounded 중앙은 0.05 · 0.15 는 낙관 상한 (7yr·99%) — M5 가정은 **상한으로 재라벨** |

> tier 분포: 🔵 1 · 🟢 1 · 🟡 1 · 🟠 2 (+ M5 가정 1건 낙관-상한 재라벨). **positive 강제 없음** — φ 를 낙관으로 밀지 않고, 중앙값이 작아 timeline 이 길어짐을 그대로 보고.

---

## 6. 정직 결론 + next (M5/M9 입력)

- **φ 직접 측정값은 부재** — 문헌이 측정한 건 (A) fresh-타투 fast 배수(32 %/6주, 수분 peak)와 (B) lifetime 누적(60–99 %)뿐. M5 가 필요한 **per-cycle steady-state φ** 는 lifetime-loss 에서 *역산*하는 수밖에 없다(가정 명시).
- **grounded φ = 0.02–0.10 (중앙대) · 넓게 0.009–0.15.** M5 의 **0.15 는 낙관 상한**(7년·99 % 소실)이지 중앙값이 아니다 → M5 §4 표의 "full 3-lever 0.15" 는 *달성 목표(lever 로 끌어올릴 상한)* 로 재해석해야 정직.
- **timeline 함의**: M9 의 3–4주 펄스에서 φ=0.15 면 ~10–13개월이지만, **grounded 중앙 φ=0.05 면 ~3–3.5년**, 보수 φ=0.02 면 수년~10년. ⇒ "months not years" 는 **lever 가 r 을 충분히 내려 φ 를 0.10–0.15 로 끌어올릴 때만** 성립 — 이는 wet-lab 측정 대상.
- **r 은 efficacy 의 지배 lever** 그대로 (r 0.99→0.95 = φ 5×). M9 의 τ_rec(safety) 와 쌍을 이루는 efficacy knob 가 φ↔r.
- **next**:
  - M8 ex-vivo — recapture 억제 정도별 **per-cycle φ 직접 측정** (위상 B 특이값 · 문헌 공백 1).
  - M9 in-vivo — dermal tattoo-laden 특이 φ + τ_rec 동시 측정 (efficacy×safety 곡면).
  - V — `hexa verify --expr` 로 φ=1−(1−f)^(1/N) 단조성(∂φ/∂f>0, ∂φ/∂N<0) 등록 + atlas.

---

## Sources

- Lehner et al. 2011, *JEADV* — 적색 색소 피부 농도 87–99 % 감소 (https://pubmed.ncbi.nlm.nih.gov/21349116/ · https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1468-3083.2011.03987.x)
- Baranska et al. 2018, *J Exp Med* 215:1115 (PMID 29511065) — capture–release–recapture · recapture "majority but not perfect" (CD64dtr) (https://rupress.org/jem/article/215/4/1115)
- Synchrotron νXRF/μFTIR, *Sci Rep* 2017 — 색소 피부/림프 분포 · 수분 내 peak (https://www.nature.com/articles/s41598-017-11721-z)
- 28-day porcine biokinetics — fast dLN distribution, day-7 steady-state (https://pmc.ncbi.nlm.nih.gov/articles/PMC10997244/)
- ScienceInsights — 32 %/6주 translocation · 60–90 % 누적 dLN 종합 (https://scienceinsights.org/what-happens-to-tattoo-ink-in-lymph-nodes/)
- BfR Q&A — 림프절 나노입자 분포 (https://www.bfr.bund.de/en/service/frequently-asked-questions/topic/questions-and-answers-on-the-study-lead-of-bfr-investigating-the-distribution-of-tattoo-ink-as-nano-sized-particles-in-lymph-nodes/)
- nipple-areola fade, PMC11288766 — fade rate 첫해 최대 → 둔화 (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11288766/)
- PNAS 2025 — tattoo ink dLN 염증/면역영향 (배경) (https://www.pnas.org/doi/10.1073/pnas.2510392122)
