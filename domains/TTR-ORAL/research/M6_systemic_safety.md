# TTR-ORAL — M6: 전신 off-target 안전성 (whole-body exposure · 이 track 의 핵심 wall)

> milestone: TTR-ORAL.md **M6-ORAL** — "전신 off-target 안전성 (이 track 의 핵심 wall · whole-body exposure) — TTR base M6 흡수 + 전신 독성 추가"
> base: `TTR/research/off_target_safety.md` (§6 진피 LOCAL off-target 24-cell matrix) · `oral_adme_wall.md` (f_target ≈ 8.9×10⁻⁵ · amplification 5600×) · `path_A_prodrug_activation.md` (spatial gating · r_dark) · `path_B_macrophage_migration.md` (k_eff 면역조절)
> 정직 원칙 (@D d5/d6): 전신 window 가 미입증이면 🟠 로 정직 표기. positive verdict 를 압력으로 강제하지 않음. wall 을 만나도 @D d2 로 돌파 경로를 surface.

---

## §0 정의상의 전환 — LOCAL(피부) → SYSTEMIC(전신)

TTR base §6 의 24-cell matrix 는 **진피 plume 반경 30–100 μm** 안의 off-target 만 평가했다 (MN/CREAM = 국소 전달). oral 은 그 가정이 깨진다:

```
   ┌─────────────────────────────────────────────────────────────────┐
   │  TTR base §6 (MN/CREAM)        │  TTR-ORAL M6 (oral)             │
   ├───────────────────────────────┼─────────────────────────────────┤
   │  노출 = 진피 plume 30–100 μm   │  노출 = 전신 Vd ≈ 42 L          │
   │  off-target = 6 dermal cell    │  off-target = 6 dermal + 전신    │
   │                                │     장기 (간·신·골수·GI·CNS)     │
   │  TI 분모 = plume 안 collagen   │  TI 분모 = 전신 가장 약한 장기   │
   └───────────────────────────────┴─────────────────────────────────┘
```

oral_adme_wall §2(e): 먹은 약의 **≈99.99% 가 전신**에 분포 (f_target ≈ 8.9×10⁻⁵). 반응성 화학이라면 이 99.99% 가 전부 off-target 으로 작용한다 → **base §6 의 6개 피부 off-target 에 더해, 약물이 거쳐가는 모든 장기가 새로 risk 에 진입.**

핵심 질문 재정의:
- ❌ base §6: "진피 plume 안에서 무엇이 손상되나"
- ✅ M6-ORAL: **"전신을 통과하는 dose(=표적의 5600배)가 어느 장기를 손상시키나, 그리고 lead track 이 이 노출을 어떻게 끄나"**

---

## §1 전신 off-target 장기 map — 새로 risk 에 진입하는 곳

경구 ADME 사슬(oral_adme_wall §1)을 따라 dose 가 거쳐가며 각 관문에 누적/희석된다. 농도가 *높은* 곳일수록 off-target risk 가 크다.

```
  먹음 ──▶ GI lumen/벽 ──▶ 간(1차통과) ──▶ 전신혈류 ──▶ {신장 배설 · 골수 · CNS · 피부}
          [국소高농도]      [대사 高농도]    [Vd 희석]      [관류·축적 의존]
            ▲ GI            ▲ 간             ▲ plasma       ▲ 청소/분포 장기
```

| 장기 | 왜 새로 risk 인가 (oral 특이 노출) | 노출 농도 특성 | base §6 에 없던 이유 |
|---|---|---|---|
| **간 (first-pass · Kupffer)** | F = Fa·Fg·Fh 의 Fh 가 간 추출 — dose 전량이 1차통과로 간을 **최고농도**로 통과 (oral_adme_wall §2a) | 문맥혈 농도 ≫ 전신 plasma · CYP/UGT 대사물 노출 | LOCAL 전달은 간 1차통과를 우회 |
| **신장 (배설)** | chelate·대사물·금속착물이 사구체/세뇨관으로 농축 배설 — DFO/deferiprone class 의 알려진 신독성 경로 | 뇨 농축으로 plasma 의 수십× | 진피 plume 은 신장 미경유 |
| **골수 (조혈)** | 반응성 화학·면역조절이 빠르게 분열하는 조혈전구세포 타격 (deferiprone black-box = agranulocytosis) | plasma 평형 · 누적 독성 | LOCAL 노출량이 골수 도달 못함 |
| **GI (장벽·상피)** | 경구 first contact — 흡수 전 lumen 고농도가 장상피·점막 직접 노출 | lumen 농도 = dose/장액 부피 (≫ plasma) | 경구 경로 고유 |
| **CNS (BBB)** | 소분자(logP·MW 적정)는 BBB 통과 가능 → 면역조절·반응성 화학의 중추 노출 | BBB 투과율 의존 (Kp,uu) | LOCAL 은 BBB 무관 |
| **피부 (base §6 의 6 off-target)** | oral 도 Kp≈1 로 진피 분배 (oral_adme_wall §2c) — **단 표적 1자리뿐 아니라 전신 피부 전체**가 노출 | C_dermis = Kp·C_plasma (전신 균일) | base 와 동일 chemistry, 노출 면적만 전신화 |

```
   전신 off-target 노출 map (농도 상대 크기, 막대 길이 ∝ 노출)

   GI lumen   ████████████████████  (흡수 전 최고 — 경구 first contact)
   간 문맥혈  ███████████████       (first-pass 전량 통과)
   신장 뇨    ██████████            (배설 농축)
   plasma     █████                 (Vd 42 L 희석 기준선)
   골수       █████                 (plasma 평형 · 누적)
   CNS        ██                    (BBB 감쇠)
   타투 진피  ▏                     (f_target 8.9×10⁻⁵ — 거의 안 보임)
   ─────────────────────────────────────────────────────────────
   ★ 표적은 가장 노출이 적은 곳, off-target 장기들이 압도적으로 높다 = oral wall
```

> 형식 결론: oral 의 off-target 분모는 base §6 의 "plume 안 collagen" 이 아니라 **"전신에서 가장 약한 장기"** (간 1차통과 · 골수 · 신장)다. base §6 의 24-cell 피부 chemistry 등급은 여전히 유효하나, oral 에서는 *그 위에* 전신 장기 항이 곱해진다. tier: 노출 map 의 정성적 순서(GI>간>신>plasma>CNS>표적)는 ADME closed-form(F·Vd·Kp) 의 직접 귀결 → **🔵 SUPPORTED-FORMAL**; 각 장기의 *절대* 독성 threshold 는 분자별 → **🟠**.

---

## §2 lead track 별 therapeutic-index (TI) 분석

TI 의 1차 정의 (closed-form 골격):

```
   TI = C_tox / C_eff
   ──────────────────────────────────────────────
   C_tox = off-target 손상 시작 농도 (전신 가장 약한 장기 기준)
   C_eff = 표적(타투 진피)에서 작용에 필요한 활성형 농도
   TI > 1 (이상적으로 ≫ 10) 라야 therapeutic window 존재
```

두 lead track 은 C_eff 와 C_tox 를 *전혀 다른 메커니즘*으로 결정한다 — 그래서 oral wall(5600× amplification)에 대한 응답이 다르다.

### §2.1 TRACK A (pro-drug + 외부 국소 활성화) — spatial gating 이 독성을 표적도달과 decouple

핵심: **반응성 활성형 A 는 trigger 가 켜진 곳에서만 생긴다.** 전신에 도는 것은 불활성 pro-drug P. off-site 에서 활성형이 생기는 유일한 source 는 path_A §1.3 의 **dark/leak activation `r_dark`** (자가-uncage + trigger 누설).

```
   path_A §1.3:  r_off = A·σ·I_off^n + r_dark
   trigger OFF (off-site):  I_off → 0  ⇒  r_off = r_dark
   ───────────────────────────────────────────────────────
   즉 전신 활성형 농도 = r_dark 가 만든 누설분만.
```

이것이 **decoupling** 의 형식적 핵심이다. 전신에 도는 pro-drug 총량은 여전히 표적의 5600배지만(oral_adme_wall §2f), 그 5600배 중 *활성형으로 전환되는 분율은 r_dark 에 비례하는 누설분뿐*이다.

```
   ── TI 의 decoupling 다이어그램 ──

   [brute-force 경구 활성약]          [TRACK A pro-drug + gating]
   전신 활성형 = C_systemic           전신 활성형 = r_dark·C_systemic
        │ (전량 반응성)                    │ (누설분만 반응성)
        ▼                                  ▼
   C_tox 분모 = 전신 5600× 노출       C_tox 분모 = r_dark × (전신 노출)
        │                                  │
   TI ∝ 1/5600 (≪1)                   TI ∝ 1/(r_dark·5600) = 1/(r_dark) × ...
                                            ↑ r_dark→0 이면 TI→∞
   ────────────────────────────────────────────────────────────
   spatial gating 이 5600× amplification 항을 r_dark 로 곱해 누른다.
   wall(5600×)은 사라지지 않고, r_dark 라는 설계변수에 갇힌다.
```

**TI 의 closed-form (estimate 표기 명시):**

표적 site 에서는 trigger ON 이라 활성형이 `r_on = A·σ·I_on^n + r_dark` 비율로 생기고, off-site 장기에서는 `r_off = r_dark` 만 생긴다. 두 곳 모두 같은 전신 pro-drug 농도 `C_P` 를 본다고 두면 (전신 ≈ 균일, oral_adme_wall §2b–c):

```
   C_eff(site)      = r_on  · C_P · τ_act        (활성형 site 농도)
   C_off(systemic)  = r_dark · C_P · τ_act        (활성형 누설 농도)

   ── off-site 활성형 기준 TI ──   [closed-form 골격 · 값은 estimate]
   TI_A = C_tox / C_off
        = C_tox / ( r_dark · C_P · τ_act )

   ── 더 본질적 비(site:off contrast) ──   [closed-form · path_A §1.3]
   C_eff(site) / C_off(systemic) = r_on / r_dark = 1 + (A·σ·I_on^n)/r_dark = C_real

   ⇒ TRACK A 의 안전여유 ∝ dark-stability ratio  R_dark := r_on/r_dark
```

핵심 명제: **TI_A 는 5600× amplification(f_target)이 아니라 dark-activation fraction `r_dark` 가 지배한다.** f_target wall 은 "표적에 약이 적게 간다"는 efficacy 문제로 남지만(C_eff 가 작음 → dose 키워야), 그 dose 증가가 toxicity 로 직결되지 않는다 — 활성형이 안 생기므로.

dark-activation fraction `f_d := r_dark/r_on` 의 함수로 본 TI estimate (order-of-magnitude · base §6 의 TI 추산 방식과 동일 자릿수 추론):

| dark fraction f_d = r_dark/r_on | 전신 활성형 / site 활성형 | TI_A (상대, site C_eff 대비) | 판정 |
|---|---|---|---|
| 10⁻¹ (cage 누설 큼) | 0.1 | ~10× contrast | 🟠 불충분 — 누설 활성형 10% |
| 10⁻³ (보통 광-cage) | 0.001 | ~10³× contrast | 🟡 가능성 — window 열림 |
| 10⁻⁵ (안정 cage) | 0.00001 | ~10⁵× contrast | 🔵→🟢 window 충분 (값은 measured 필요) |

> 형식 결론: TRACK A 는 **spatial gating 으로 oral wall(5600×)의 toxicity 항을 r_dark 로 decouple** 한다 — TI 가 amplification 이 아니라 pro-drug dark-stability(r_dark↓)에 의해 결정됨을 closed-form 으로 보인다(🔵). 단 **r_dark 절대값은 분자별 measured(M5 TDDFT + 가수분해/열 안정성 assay) → 🟠**. 따라서 TI_A 의 *형태*는 닫히나(🔵), *값*은 미입증(🟠).

### §2.2 TRACK B (macrophage 이주 가속) — 반응성 화학 없음, 면역조절 window 가 TI

핵심 차이: **TRACK B 는 진피에 반응성 화학을 전달하지 않는다.** off-target 은 화학적 손상이 아니라 path_B §3 의 **전신 면역조절 그 자체**다 — CSF1R/CCR7/S1P 조절은 부위 특이성이 없어 전신 macrophage·림프계 전체에 작용한다(path_B §3.1 caveat).

따라서 TRACK B 의 TI 는 화학 농도비가 아니라 **면역조절 강도의 window** 로 표현된다:

```
   ── 면역조절 window TI ──   [estimate · path_B §2 k_eff 연동]

   효과 측:  진피 fade 가속에 필요한 면역조절 강도 m_eff
             (k_eff = k_emig + (1−r)·k_death 를 의미있게 올리는 dose)
   독성 측:  전신 부작용 발생 면역조절 강도 m_tox
             (과면역억제: 감염/agranulocytosis · 과활성: 사이토카인)

   TI_B = m_tox / m_eff

   양방향 wall (window 가 위·아래로 닫힘):
   ── 너무 약하면 → fade 안 됨 (k_eff 변화 미미, path_B §2.1 ratio<1)
   ── 너무 강하면 → 전신 immunosuppression / over-activation
```

```
   면역조절 강도 축 (window 다이어그램)

   |── 무효과 ──|███ 치료 window ███|── 독성 ──────────────────|
   0          m_eff                m_tox
              ↑                    ↑
        진피 k_eff 가속 시작    전신 부작용 시작
   ────────────────────────────────────────────────────────────
   TI_B = m_tox/m_eff = window 폭.  좁으면 🟠, 넓으면 사용 가능.
```

레버별 window 폭 (path_B §3 의 safety 함의를 TI 로 환산 · 모두 estimate):

| 레버 (path_B §3) | C_eff (fade 효과) | C_tox (전신 독성) | window TI_B | 정직 등급 |
|---|---|---|---|---|
| (a) CSF1R turnover | 강함 (r↓ 큼) | 전신 macrophage/Kupffer/osteoclast 고갈 → 감염·간효소·골 | **좁음** (강효과=강독성) | 🟠 — transient·저용량만 |
| (b) CCR7/S1P emig | 중간 (k_emig↑) | S1P modulator black-box (림프구감소·서맥·황반) · CCR7 직접 agonist 약물 부재 | **미정** (약물 실재성 결여) | 🟠 — oral agent 부재 |
| (c) depletion pulse | 강함 (r↓ + 외부보조) | (a)+timing risk | 좁음 · timing 의존 | 🟠 |
| (d) lymph-flow 지원 (운동·압박·온열) | 약함 (k_emig sink↑) | **거의 없음** (비약물) | **넓음** (안전 최상) | 🟡 — 단 효과 약함 |

> 형식 결론: TRACK B 의 off-target 은 **반응성 화학이 아니라 전신 면역조절** — TI 가 dark-stability 가 아니라 **면역조절 window m_tox/m_eff** 로 정의된다(🔵 형태). 그러나 (a)(c) 는 효과·독성이 같은 메커니즘이라 window 가 본질적으로 좁고, (b) 는 경구 CCR7 agonist 가 부재하며, window 폭의 정량은 인간 면역조절 dose-response 부재로 **미입증 → 🟠**. (d) 만 safety 가 넓으나 fade 효과가 약함 → 효과·안전 trade-off 가 닫히지 않음.

---

## §3 1차 TI 부등식 / closed-form 요약 (closed-form vs estimate 명시)

| 항목 | 식 | 종류 |
|---|---|---|
| TI 일반 정의 | `TI = C_tox / C_eff` | 🔵 closed-form (정의) |
| oral 표적 도달 분율 | `f_target = Kp·F·V_tat/Vd ≈ 8.9×10⁻⁵` | 🔵 closed-form (oral_adme_wall §2e, V2 검증) |
| oral amplification (wall) | `amp = Vd/(Kp·V_tat) ≈ 5600×` | 🔵 closed-form (oral_adme_wall §2f) |
| **A: off-site 활성형** | `C_off = r_dark · C_systemic`  (trigger OFF ⇒ I_off→0) | 🔵 closed-form (path_A §1.3 r_off 분해) |
| **A: site:off contrast** | `C_eff/C_off = r_on/r_dark = 1 + (Aσ I_on^n)/r_dark` | 🔵 closed-form |
| **A: TI 부등식** | `TI_A = C_tox/(r_dark·C_systemic·τ) ≫ 1  ⟺  r_dark ≪ C_tox/(C_systemic·τ)` | 🔵 형태 / 🟠 r_dark 값 estimate |
| **A: decoupling 명제** | `∂TI_A/∂(amp) ≈ 0`,  `TI_A ∝ 1/r_dark` (amplification 이 아니라 r_dark 지배) | 🔵 형태 / 🟠 값 |
| **B: window TI** | `TI_B = m_tox/m_eff` (면역조절 강도 window) | 🔵 형태 / 🟠 m 값 estimate |
| **B: fade ratio** | `t½(개입)/t½(자연) = k_eff(자연)/k_eff(개입)` | 🔵 closed-form (path_B §2) / ratio 🟢 |

**핵심 부등식 (track A go 조건):**
```
   TRACK A 전신 safe  ⟺  r_dark · (5600 × C_target) · τ_act  <  C_tox(가장 약한 장기)
   ───────────────────────────────────────────────────────────────────────────
   ⟺  r_dark  <  C_tox / (5600 · C_target · τ_act)        [closed-form 형태]
   → 우변은 측정 가능한 양(C_tox 장기 threshold · C_target 치료농도 · τ_act 활성형 수명).
     좌변 r_dark 가 이 상한보다 작도록 cage 를 설계하면 전신 window 확보.  (값=🟠 measured)
```

> 이것이 oral wall 의 정직한 재진술이다: TRACK A 는 5600× wall 을 *없애지 않는다*. 그 wall 을 **"r_dark 를 측정 가능한 상한 아래로 내릴 수 있나"** 라는 단일 설계부등식으로 환원한다. wall 이 *원리상 닫히지 않음*(🔵)을 보이되, *값으로 닫혔다*고 말하지 않는다(🟠).

---

## §4 safety endpoint + go/no-go gate (absorbed=true 를 통제하는 정직 gate)

@D d5: absorbed=true 는 *모든 non-wet-lab gate PASS* 일 때만. M6 의 gate 는 전신 safety 의 closed-form/numerical 입증 + wet-lab confirm endpoint 분리.

### §4.1 TRACK A gate

| gate | endpoint (측정량) | PASS 기준 | 현 tier | wet-lab/sim 단계 |
|---|---|---|---|---|
| A-G1 | r_dark 절대값 (cage 자가-uncage + 가수분해/열) | `r_dark < C_tox/(5600·C_target·τ)` 상한 만족 | 🟠 미측정 | M5 sim(가수분해 ΔG‡·TDDFT dark Φ) + in-vitro 안정성 assay |
| A-G2 | trigger 누설 I_off (산란·반사로 패치 밖 fluence) | off-site 활성화 < C_tox 의 1/10 | 🟠 | M7 제형 + 광학 phantom |
| A-G3 | 활성화 부산물 systemic exposure (oNB→nitroso · azo→방향족 아민, base §6.6.3) | 24h 뇨 LC-MS 발암성 아민 < 규제 한도 | 🟠 | M9 in-vivo |
| A-G4 | caged pro-drug 자체의 전신 독성 (불활성이어야) | 간/신/골수 NOAEL ≥ 100× 임상 dose | 🟠 | M9 GLP tox |
| A-G5 | 간 1차통과 대사물 안전 (oral 특이) | CYP 대사물 비활성·비독성 | 🟠 | M5 대사 예측 + M9 |

### §4.2 TRACK B gate

| gate | endpoint | PASS 기준 | 현 tier | 단계 |
|---|---|---|---|---|
| B-G1 | 면역조절 window m_tox/m_eff | TI_B ≥ 10 (혹은 ≥ 임상 수용 margin) | 🟠 미입증 | M5 PK/PD + M9 면역 panel |
| B-G2 | 전신 면역억제 깊이 (CSF1R 레버) | 호중구/감염 surveillance 정상 유지 · agranulocytosis 無 | 🟠 | M9 CBC 추적 |
| B-G3 | 경구 활성 면역조절 agent 의 실재성 (특히 CCR7) | dose 가능한 oral agent 존재 | 🟠 약물 부재 | M4 후보 선정 |
| B-G4 | dLN 잉크 relocation 후 전신 분포·발암 (path_B §4) | dLN 착색 외 전신 잉크 분산 無 | 🟠 | M9 영상 |

### §4.3 absorbed gate 종합

```
   absorbed=true(M6 측면)  ⟺  (A-G1..G5 all PASS)  OR  (B-G1..G4 all PASS)
   현 상태:  A · B 모두 G1(핵심 정량 gate)이 🟠 미입증
   ⇒ M6-ORAL 은 absorbed=false 유지 — 단 @D d2 닫힌 부정 아님 (돌파 경로 존재, §6)
```

---

## §5 정직한 tier 판정 (project rubric · positive 강제 금지)

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | oral 노출 분모 = 전신 장기(간·신·골수·GI·CNS), base §6 6 피부 off-target 의 *위에* 곱해짐 | 🔵 SUPPORTED-FORMAL | f_target·F·Vd·Kp ADME closed-form 의 직접 귀결 |
| 2 | 노출 농도 순서 GI>간>신>plasma>CNS>표적 | 🔵 SUPPORTED-FORMAL | ADME 사슬 곱셈 구조 |
| 3 | A: trigger OFF ⇒ off-site 활성형 = r_dark·C_systemic (활성형 유일 source = r_dark) | 🔵 SUPPORTED-FORMAL | path_A §1.3 r_off 분해 |
| 4 | A: TI_A ∝ 1/r_dark, amplification(5600×) 에 무관 (decoupling) | 🔵 SUPPORTED-FORMAL | C_off = r_dark·C_systemic 의 미분 구조 |
| 5 | A: go 부등식 r_dark < C_tox/(5600·C_target·τ) | 🔵 형태 SUPPORTED-FORMAL | 위 closed-form 재배열 |
| 6 | A: r_dark·C_tox·τ_act 의 **절대값** (window 실제 닫힘 여부) | 🟠 INSUFFICIENT/DEFERRED | M5 TDDFT/안정성 + M9 tox measured |
| 7 | B: off-target = 전신 면역조절, TI_B = m_tox/m_eff (window 형태) | 🔵 형태 / 🟠 값 | path_B §3 caveat 형식화 / m 값 미측정 |
| 8 | B: (a)(c) window 본질적으로 좁음 (효과=독성 동일 메커니즘) | 🟡 SUPPORTED-BY-CITATION | pexidartinib/CSF1R 전신 독성 라벨 + path_B §3 |
| 9 | B: 경구 CCR7 직접 agonist 부재 · S1P black-box | 🟡 SUPPORTED-BY-CITATION | path_B §3 (b) (Förster/Cyster 인용) |
| 10 | base §6 피부 off-target chemistry 등급(24-cell)이 oral 에서도 유효 | 🟡 SUPPORTED-BY-CITATION | base §6 BDE/E°/log K 인용 carry |
| 11 | 활성화 부산물(방향족 아민 IARC) 전신 발암 risk | 🟠 INSUFFICIENT/DEFERRED | M9 뇨 metabolite LC-MS |

```
   tier 분포:  🔵 5  ·  🟢 0  ·  🟡 3  ·  🟠 3  ·  🔴 0
   ─────────────────────────────────────────────────────
   형식 골격(노출 map · A decoupling · TI 형태) = 닫힘 (🔵).
   문헌 carry(피부 등급 · 면역조절 독성) = 🟡.
   핵심 정량 gate(r_dark 값 · 면역 window 값 · 부산물) = 🟠 deferred.
   → positive verdict 강제 안 함.
```

---

## §6 정직한 top-line 판정 + go/no-go (@D d2/d5/d6)

**TRACK A (pro-drug + 외부 활성화):**
- spatial gating 이 oral wall 의 **toxicity 항을 r_dark 로 decouple** 함을 closed-form 으로 보임 (🔵). 5600× amplification 은 efficacy 부담(C_eff 작음)으로 남되 toxicity 로 직결되지 않는다 — 전신엔 불활성 pro-drug 만 돌고, 활성형은 r_dark 누설분뿐.
- **GO/NO-GO 판정: CONDITIONAL-GO (🟠 pending A-G1).** 전신 window 가 *원리상 존재 가능*(🔵)하나, 그 존재는 `r_dark < C_tox/(5600·C_target·τ)` 단일 부등식 만족에 걸려 있고 r_dark 절대값이 미측정 → **honest 🟠**. r_dark 가 충분히 작은 cage 가 실증되기 전엔 "전신 safe" 라 말하지 않는다.

**TRACK B (macrophage 이주 가속):**
- 반응성 화학을 전신에 안 보내므로 화학적 off-target 은 없으나, **전신 면역조절 자체가 off-target** 이며 부위 특이성이 없다. TI 가 면역조절 window(m_tox/m_eff)로 정의됨(🔵 형태).
- **GO/NO-GO 판정: NO-GO (현재 · 🟠 unproven window).** 효과가 큰 레버((a)(c) CSF1R/depletion)는 효과·독성이 같은 메커니즘이라 window 가 본질적으로 좁고, 안전한 레버((d) lymph-flow)는 fade 효과가 약하며, 중간 레버((b) CCR7)는 경구 약물이 부재한다. 전신 면역조절 therapeutic window 가 존재한다는 입증이 없으므로 **honest 🟠** — 단 닫힌 부정 아님(약물 발굴·레버 조합 여지).

**M6-ORAL 종합:** 두 track 모두 핵심 정량 gate(G1)가 🟠 미입증 → **absorbed=false 유지.** TRACK A 가 전신 safety 측면에서 우위(decoupling 으로 wall 을 단일 설계변수에 가둠) — oral track 의 1순위 안전 경로는 A. @D d2 돌파 경로(§6.1)를 surface 하며 "불가능" 으로 닫지 않는다.

### §6.1 돌파 경로 (@D d2 — wall 을 만나도 닫지 않는다)

1. **A 의 r_dark 하한 push** — bistable/이중-cage(두 trigger 동시 요구) 로 dark uncage 를 곱셈적으로 억제 → r_dark² scale. M5 TDDFT 로 dark Φ 정량.
2. **A 의 self-targeting modality C 활용** (path_A §2.3) — 잉크-as-sensitizer 는 trigger 정렬 불필요 + I_off 누설을 잉크 분포(μm)로 자연 한정 → A-G2 완화.
3. **B 의 window 확장** — (d) lymph-flow(안전) + (b) 약한 emig boost 조합으로 효과 측을 올리고 독성 측은 비약물에 의존 → window 폭 확대 시도.
4. **A+B hybrid** — A 로 국소 잉크 분해 + B 로 잔여 색소 dLN 배수 가속, 각각 저용량 → 두 TI 를 곱해 margin 확보.

---

## Cross-reference

- base LOCAL off-target: `TTR/research/off_target_safety.md` §6.1(inventory) · §6.2(24-cell matrix) · §6.4(TI 추산 방법론) · §6.6.3(방향족 아민·금속 2차 독성)
- oral wall 수치: `oral_adme_wall.md` §2e(f_target 8.9×10⁻⁵) · §2f(amplification 5600×) · §5(A/B 우회 원리)
- TRACK A 형식: `path_A_prodrug_activation.md` §1.3(r_off = AσI^n + r_dark · contrast) · §4(누설/자가활성화 caveat) · §5 #9(M6 deferred)
- TRACK B 형식: `path_B_macrophage_migration.md` §2(k_eff·t½) · §3(4 레버 + 전신 safety) · §3.1(부위 특이성 부재 caveat) · §5(전신 window = 결정 gate)
- 다음: M5-ORAL(r_dark TDDFT·면역 PK/PD) · M7-ORAL(제형·trigger 누설) · M9-ORAL(in-vivo 전신 tox endpoint)
- @D d2: 본 문서는 두 track 의 wall 을 정량 부등식으로 환원하고 돌파 경로(§6.1)를 surface — "불가능" 미사용
- @D d5/d6: absorbed gate 를 정직 정의 · positive verdict 강제 없음 · first-principles(ADME closed-form + r_dark 부등식 + k_eff window)만 사용, ML 의존 X
