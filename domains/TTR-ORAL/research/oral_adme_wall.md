# TTR-ORAL — M2: 경구 ADME wall · 진피 도달 분율 정량 (first-principles)

> 질문: 먹은 약 1 dose 중 **타투 진피 잉크 자리에 실제로 도달하는 비율**은? → site-specificity wall 을 숫자로 못박는다.
> 정직 원칙 (@D d5/d6): 숫자를 목표에 맞춰 강제하지 않음. 결과가 wall 을 키우면 그대로 기록.

---

## 1. 경구 ADME 사슬 (GI → 혈류 → 진피)

```
  먹음        흡수         간 1차통과     전신순환      진피 분배     잉크 자리
 ┌────┐  Fa  ┌────┐  Fg  ┌────┐  Fh  ┌────┐  Kp  ┌────┐  V_tat ┌────┐
 │dose│ ───▶ │ gut│ ───▶ │wall│ ───▶ │liver│ ──▶ │plasma│ ──▶ │dermis│ ──▶ │ ink │
 └────┘      └────┘      └────┘      └─────┘      └──────┘     └──────┘     └─────┘
              희석되는 곳 ↑↑↑          전신 분포 Vd (~42 L) 에 녹아 사라짐
```

각 관문이 분율을 곱으로 깎는다 → **진피 잉크 자리는 사슬의 맨 끝 · 극소 부피**.

---

## 2. 핵심 closed-form (V2 에서 verify)

### (a) 경구 생체이용률 (oral bioavailability)
```
F = Fa · Fg · Fh        Fh = 1 - Eh
```
well-stirred 간 추출:  `Eh = (fu·CL_int) / (Qh + fu·CL_int)`,  Qh ≈ 90 L/h
대표값으로 **F = 0.5** 사용 (소분자 경구 0.1–0.9 범위 중앙).

### (b) 전신 혈중 농도 (단회 dose 상한, 흡수 중 소실 무시)
```
C_plasma ≈ F · D / Vd        Vd ≈ 42 L  (≈ 0.6 L/kg × 70 kg, total body water 기준)
```

### (c) 진피 조직 농도
```
C_dermis = Kp · C_plasma     Kp(skin:plasma) ≈ 1  (0.5–2 범위)
```

### (d) 타투 자리 부피 (잉크 거주 진피층)
```
V_tat = A_tat · d_ink = 50 cm² × 0.15 cm = 7.5 cm³ = 7.5 mL = 0.0075 L
  (A_tat 중간 크기 타투 50 cm² · d_ink 잉크층 ~1.5 mm = 500–2000 μm 대표)
```

### (e) ★ 진피 도달 분율 (dermal delivery fraction)
타투 자리에 (peak 시점) 머무는 dose 비율:
```
f_target = m_tat / D = Kp · F · V_tat / Vd
         = 1 × 0.5 × 0.0075 / 42
         = 8.93 × 10⁻⁵   ≈ 0.0089%   ≈ ~10⁻⁴
```

> **먹은 약의 약 1/11,000 만 타투 자리에 있다.** 나머지 ≈ 99.99% 는 전신에 퍼져, 반응성 화학이라면 전부 off-target 독성으로 작용.

### (f) site-specificity wall = 전신/표적 dose 증폭률
표적 치료농도 C\* 를 만들려면 전신을 다음 배율만큼 노출시켜야 한다:
```
amplification = Vd / (Kp · V_tat) = 42 / (1 × 0.0075) = 5600×
```
⇒ 타투에 필요한 양의 **약 5600배**를 온몸에 통과시켜야 함 = 정량화된 wall.

---

## 3. 3 track 진피-잉크 자리 도달 분율 비교 (왜 oral 이 최악인가)

| track | 도달 경로 | 잉크 자리 도달 분율 (대략) | 비고 |
|---|---|---|---|
| TTR-MN (붙임) | 바늘이 진피에 직접 주입 | **~0.5–1.0** | payload 를 자리에 직접 심음 (TTR-MN 흡수) |
| TTR-CREAM (바름) | SC 투과 후 국소 | **~0.01–0.1** | SC 장벽이 천장 (TTR-CREAM 흡수) |
| **TTR-ORAL (먹음)** | 전신 혈류 → 진피 분배 | **~10⁻⁴** | 전신 부피에 희석 (본 M2) |

> oral 은 자리 도달 기준 MN 대비 **약 3–4 자릿수 열세**. 이게 A/B 경로가 우회해야 할 정확한 벽.

---

## 4. 1차 시간상수 (path B fade · dosing 공통)
```
C(t) = C₀ · e^(−k_e·t)        t½ = ln2 / k_e
```
- path B (macrophage 이주) 의 fade 도 1차 청소로 근사: `N(t)=N₀·e^(−k_eff·t)`, `t½ = ln2/k_eff` — 경구 면역조절이 k_eff 를 올려 t½ 단축 (path B doc 정량).

---

## 5. wall 을 우회하는 두 경로 (M2 결론이 M3 으로 넘기는 것)

| 경로 | wall 우회 원리 | f_target(10⁻⁴) 가 더는 치명적이지 않은 이유 |
|---|---|---|
| **A) pro-drug + 외부 활성화** | 전신엔 불활성 분포 → 타투 자리만 외부 trigger 로 활성화 | 독성과 표적도달이 **decouple** — off-site 활성 ≈ 0 이므로 5600× 증폭의 독성 항이 사라짐 |
| **B) macrophage 이주 가속** | 반응성 화학을 진피에 안 보냄 — 내인성 청소 가속 | 국소 화학 농도 자체가 불필요 — 전신 면역조절이 자연 경로로 작동 |
| C) lymphatic lipid · D) ink-homing NP | f_target 를 키우려는 시도 | wall 을 줄이지만 못 없앰 — A/B 보다 약함 (path_CD doc) |

---

## 6. 정직한 M2 판정

- **brute-force 경구 잉크-분해약** (전신 활성 반응성 화학): f_target ~10⁻⁴ + 5600× 증폭 ⇒ therapeutic window 미확보 → **🟠 INSUFFICIENT** (현 시점 닫힌 부정은 아님 — A/B 우회 존재).
- 핵심 수치 (`f_target ≈ 8.9×10⁻⁵`, `amplification ≈ 5600×`) 는 closed-form arithmetic → V2 ledger 에서 검증.
- meta-feasibility 주장은 `hexa verify --fence` ⚪ 처리 (V2 §0 verbatim).

→ M3: A/B/C/D 경로 deep-dive 가 받음. M2 의 숫자가 A/B 가 "왜 필요한지"의 정량 근거.
