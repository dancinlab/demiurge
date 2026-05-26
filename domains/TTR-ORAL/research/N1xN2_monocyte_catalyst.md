# TTR-ORAL — N1⊗N2: monocyte-운반 색소-게이트 촉매 (창발 결합 deep-dive)

> 🦠 **TTR-ORAL** — "면역세포 택배" · NOVEL 창발 결합 (@D d11)
> 핵심 통찰: N1 의 실패한 전제("pH-alone 이 자동으로 site-specific")는 **촉매를 *어디에* 두느냐**의 문제였다. N2 가 그 답을 준다 — 재포획자(혈중 monocyte)에 N1 촉매를 *미리 실어* 보내면, **방출 색소를 삼킨 그 monocyte 가 곧 촉매를 가진 세포**다. 색소-적재 phagolysosome = 산(acid)·색소·촉매가 *물리적으로 같이 모이는 유일한 곳* → pH × 색소-근접 AND-게이트가 **운반(carriage) 그 자체로 자동 충족(self-satisfied)**.
> device-free · erase-capable · ADME-bypass. sim = `sim/n1xn2.hexa` (verbatim §5).
> 정직 원칙 (@D d2/d5/d6): 낙관 강제 금지. 핵심 honest check 는 **§2 (경구 monocyte 로딩 자체가 새 벽인가)**.

---

## TL;DR

N1 의 치명적 결함은 "pH-alone 은 site-specific 하지 않다 — 온몸 모든 리소좀(산성 총부피 5.55 mL)이 켜지고 그 중 잉크-laden 은 **1.8×10⁻⁸**"였다. N2 는 "재포획자 = 혈중 monocyte = 경구약 도달 구획"임을 보였다. **결합**: N1 촉매를 순환 monocyte 에 적재 → 촉매는 더 이상 간질에 자유 분산하지 않고 *monocyte 안에만* 존재. monocyte 가 색소를 삼키면 그 산성 phagolysosome 에 색소·산·촉매가 동시 co-localize → AND-게이트가 운반으로 자동 충족. **off-target 은 비-운반 세포(3.7×10¹³개)에서 *범주적으로* 사라짐(~7.4×10⁵배 적은 세포 노출 · 산성부피 ~740배 감소).** N1 의 핵심 gap = **해소(🔵 형식적)**. 그러나 정직한 새 병목: **경구로 *순환* monocyte 를 로딩하는 효율이 ~5×10⁻⁴** (IV 선례 0.3–0.9 대비) — 벽이 사라진 게 아니라 "경구 순환-monocyte 촉매 로딩"으로 **이전(relocate)**됐다. carbon black 20–30% net-erase≈0 천장도 그대로.

---

## §1 ★ AND-게이트 해소 — 운반이 부피-예산 분할을 대체한다

N1 §4 의 실패는 *촉매가 산성(pH)만으로 분배*되는 데서 왔다. 촉매가 간질에 자유 분산하면 도달한 곳 어디든 산성 리소좀에서 ON → 분모 = 온몸 리소좀(5.55 mL). **운반(carriage)은 분배 규칙 자체를 바꾼다**: 촉매는 monocyte *내부에만* 있으므로, 촉매가 산을 만나는 곳은 *그 monocyte 자신의 phagolysosome* 뿐이다.

```
   N1 pH-alone (촉매 자유분산)            N1⊗N2 carriage (촉매 = monocyte 내부)
   ════════════════════════════          ═══════════════════════════════════════
   경구촉매 ──► 간질 자유분산              경구촉매 ──► 혈중 monocyte 내부 적재
              │ 산성 어디든 ON                        │ (촉매는 세포 밖으로 안 나감)
              ▼                                       ▼ 정상 homing
   온몸 3.7e13 세포 리소좀 ON              진피 진입 = 새 recapturer (촉매 보유)
   (5.55 mL · 잉크겹침 1.8e-8)                        │ 색소 재포획
                                                      ▼
                                          색소-laden phagolysosome:
                                          ┌─ 산(pH4.5)  ┐
                                          ├─ 색소(기질) ├─► AND 자동충족 → 분해
                                          └─ 촉매(운반) ┘
```

**정량 (sim §5 [1]·[4]·[5] verbatim):**

| 항목 | pH-alone (N1) | carriage (N1⊗N2) | 개선 |
|---|---|---|---|
| 촉매가 켜지는 곳 | 온몸 산성 리소좀 5.55 mL | 운반 monocyte 리소좀 **0.0075 mL** | 산성부피 **740×↓** |
| 촉매 노출 세포 수 | 3.7×10¹³ (전 세포) | ~5×10⁷ (운반 monocyte만) | **7.4×10⁵× 적음** |
| 촉매-활성부피 중 색소겹침 | 1.8×10⁻⁸ | **1.33×10⁻⁵** | enrichment **740×** |
| AND-게이트 충족 | ✗ (pH 단일조건) | ✅ (산∧색소∧촉매 co-loc) | 범주적 해소 |

- **범주적 제거가 핵심**: 운반은 단순히 비율을 줄이는 게 아니라, 비-운반 세포(3.7×10¹³개 — 뉴런·간세포·근육 등)에서 촉매를 **물리적으로 0**으로 만든다. pH-alone 이 *전부* 켜던 그 거대 분모가 통째로 제거된다. (sim §5 [5]: 7.4×10⁵배 적은 세포가 촉매에 노출.)
- **off-target ROS 과부하 해소 경로**: N1 §6 [4] 의 "5× ROS 과부하 → 무해 미보장"은 *촉매를 가진 모든 산성 리소좀*에 적용됐다. 이제 촉매 보유 = monocyte 한정 → 비-운반 세포는 ROS-ON 자체가 불가능. 잔여 off-target = 색소 없이 떠도는 운반 monocyte 의 산성 리소좀(~0.0075 mL)뿐이며, 이는 (a) 촉매적·무소모 → 기질(색소) 없으면 net 손상 작음 + (b) monocyte 자체 catalase/SOD 완충으로 흡수 가능한 수준.
- ⇒ **N1 이 "pH-alone 으로는 못 푼다"고 한 site-specificity 가, N2 의 운반으로 *구조적으로* 풀린다 (🔵 형식적).** AND-게이트의 두 번째 조건("색소-근접")이 별도 conjugate(N1 BP-N1a) 없이 *세포-운반 그 자체*로 무료 충족된다 — 이것이 결합의 진짜 창발성.

---

## §2 ★ 정직 핵심 check — 경구로 *순환* monocyte 를 로딩할 수 있나 (새 벽)

**여기가 결합의 새 병목이다.** §1 의 AND-게이트 해소는 "촉매가 순환 monocyte 안에 들어가 있다"를 *전제*한다. 그 전제(경구 로딩)가 device-free 제약 하에서 가장 약하다.

로딩 경로 3종 — 정직 평가:

| 경로 | 기전 | device-free? | 실재 효율 (문헌) | 정직 등급 |
|---|---|---|---|---|
| **(A) ex-vivo 적재** | 채혈 → monocyte 분리 → NP 로딩 → 재주입 | ✗ **제외** (채혈/재주입 = device·시술) | IV/ex-vivo 선례 多 (Thno·Sci Adv) | **scope-out** |
| **(B) IV monocyte-hitchhiking** | i.v. NP 가 순환 monocyte 에 *직접* 탐식/흡착 (T½~9.2h, exocytosis 지연) | ✗ (정맥주사 = device) | **0.3–0.9** (혈중 면역세포 탐식) | scope-out (단 효율 anchor) |
| **(C) 경구 NP → 순환 monocyte 흡수** | 경구 NP 가 장 통과 → 전신 혈류 → *순환* monocyte 적재 | ✅ device-free | **§아래 = 미성립** | 🟠 **새 벽** |

**(C) 경구 로딩의 정직한 분해** (sim §5 [2]):

```
   경구 NP dose ──translocate──► 전신혈류 ──assoc──► 순환 monocyte ──survive──► 진피 도달
        │ f_gut ~0.01              │ f_blood_mono ~0.1     │ f_active ~0.5
        │ (입자 크기-게이트:          │ (대부분은 *장-resident*  │ (T½~9.2h exocytosis
        │  50nm 34%·100nm 26%·       │  mono/DC 에 국소 적재;    │  전 진피 homing 생존)
        │  >300nm ~0 — 흡수풀 자체     │  순환풀 도달은 미입증)
        │  극소)
        ▼
   경구 순환-monocyte 로딩 효율 = 0.01 × 0.1 × 0.5 = ~5×10⁻⁴
```

- **장 통과(f_gut) 자체가 작다**: 경구 입자상의 전신 혈류 도달은 *크기-게이트*(50 nm 34% · 100 nm 26% · >300 nm ≈0)이며, 그조차 *이미 작은 흡수풀*의 비율이다. CeO₂ nanozyme 의 경구 전신 노출은 N1 §3 에서 <4%(대부분 분변 배출)로 확인됨.
- **장-resident vs 순환의 함정 (가장 정직한 gap)**: 경구 NP 가 장을 통과해도, 흡수하는 면역세포는 주로 **Peyer's patch/장점막의 *국소* mono/DC** 이다 (Peyer's patch 문헌). N1 촉매가 필요한 곳은 *진피로 homing 할 순환 monocyte* 인데, **경구 dose 로 *순환* monocyte 풀을 로딩한다는 직접 in-vivo 증거는 부재** — 모든 monocyte-hitchhiking/trafficking 실증은 IV/말초주사다 (PLOS One·PNAS 2024·Sci Adv). 이건 N2 자체의 "타투-표적 경구 reprogram 제 부재 🟠" gap 과 동형(同型).
- **로딩 용량 천장**: 적재되더라도 세포당 한계 — 막 표면 ~5% 점유 시 <1.0 µg/10⁶ cells, 또는 ~100 NP/cell(thiol). 즉 monocyte 한 대가 나르는 촉매량 자체가 작다.
- ⇒ **결합은 N1 의 AND-게이트 벽을 풀지만, 그 대가로 "경구 순환-monocyte 촉매 로딩"이라는 새 벽을 만든다 (🟠).** device-free 효율 ~5×10⁻⁴ 는 IV 선례(0.3–0.9) 대비 **~10³배 낮다**. 벽이 *사라진* 게 아니라 *이전*됐다 — 정직하게.

---

## §3 결합 모델 — erase 분율(N1) × monocyte turnover(N2)

운반 monocyte 가 진피 재포획자 pool 을 turnover(N2 τ_rep~90d) 하며 교체. 색소를 삼킨 운반 monocyte 가 AND-게이트를 자동 충족 → N1 의 addressable 색소(~60–70%, azo+Fe-oxide+QA)를 *그 자리에서* 분해. carbon black(BDE 5.37 eV) 은 분해 불가 floor.

```
   erase(t) = addressable × f_replaced(t),   f_replaced(t)=1−exp(−t/τ_rep),  τ_rep=90d
   ceiling: addressable=0.65 (carbon-black 25% 제외) · 절대 cap = 1−carbon = 0.75
   ※ 단 모든 (t) 는 §2 의 경구 로딩(~5e-4)이 충분량을 공급한다는 전제 — sim §5 [4] 가 그 전제를 검정.
```

### hexa-native recompute 발췌 (verbatim · 🟢 · 전문 §5)
```
[3] combined erase timeline (N1 erase-frac x N2 monocyte turnover)
  t(mo)  f_replaced   erase_fraction   pigment_remaining
   1     0.286646  0.18632  0.81368
   3     0.636993  0.414045  0.585955
   6     0.868226  0.564347  0.435653
  12     0.982674  0.638738  0.361262
  erase ceiling (t->inf) = addressable 0.65 ; absolute cap (1-carbon) = 0.75

[4] loading-limited net: AND-gate solved, but loading gates throughput
  carriers x oral_load_eff = effective catalyst-bearing monocytes = 25000.0
  effective bearers / pigment-capturing monocytes = 0.025
  -> if <1, loading (not AND-gate) is rate-limiting; AND-gate win is real but starved.
```

```
   erase 분율 (운반-AND-게이트가 *공급된다면*)
   ────────────────────────────────────────────────────────
   1mo   ███       0.19
   3mo   ██████    0.41
   6mo   ████████  0.56
   12mo  █████████ 0.64   ← addressable 0.65 천장에 수렴
   천장  ──────────────── carbon black 25% 로 절대 cap 0.75 (≥90% 불가)
```

- **속도**: τ_rep~90d 라 turnover-제한. ~6개월 0.56 · 12개월 0.64 로 addressable(0.65)에 수렴. N2 단독의 "r↓ 만으론 多년" 문제와 달리, N1 운반은 *분해(erase)* 라 k_death 증폭기 없이도 turnover 속도로 진행 (단 §2 로딩 공급 전제).
- **로딩-제한 현실 (sim §5 [4] · 정직)**: 효과적 촉매-보유 monocyte = 5×10⁷ 운반 × 5×10⁻⁴ 로딩 = **~2.5×10⁴개**, 색소-포획 monocyte(10⁶) 대비 **비율 0.025 (<1)**. 즉 §3 의 erase 곡선은 *AND-게이트가 율속이 아니라 로딩이 율속*임을 보인다 — 게이트 승리는 진짜지만 **dose-starved**. 위 timeline 은 "로딩이 충분하다면"의 상한이며, 현 device-free 로딩(~5e-4)에선 실효 분율이 0.025배로 깎인다.
- **carbon black 천장 불변**: N1 §2 와 동일 — sp² C-C BDE 5.37 eV ≫ •OH +2.80 V → bulk 분해 불가. 운반으로 *전달*은 개선돼도 *화학*은 안 바뀐다. ≥90% erase 는 device-free 단독으로 여전히 불가.

---

## §4 정직 한계 + tier (positive 강제 금지)

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | 운반이 AND-게이트를 자동충족 — 촉매=monocyte내부 한정 | 🔵 SUPPORTED-FORMAL | localization 논리 + 부피예산 sim §5 [1] |
| 2 | off-target: 비-운반 세포(3.7e13)에서 범주적 제거 ~7.4e5×↓ 세포·~740×↓ 산성부피 | 🔵 SUPPORTED-FORMAL | sim §5 [1]·[5] (입력값 🟡) |
| 3 | 색소-근접 조건이 conjugate 없이 세포-운반으로 무료 충족 | 🔵 SUPPORTED-FORMAL | co-localization 자명 (N1 BP-N1a 대체) |
| 4 | 재포획자 = 혈중 monocyte → 운반 표적이 곧 재포획자 | 🟡 SUPPORTED-BY-CITATION | Baranska 2018 · Lin 2024 (N2 §5) |
| 5 | IV monocyte-hitchhiking 로딩 0.3–0.9 (효율 anchor) | 🟡 SUPPORTED-BY-CITATION | 혈중 면역세포 탐식 · T½9.2h (Sources) |
| 6 | 경구 입자 전신 도달 = 크기-게이트(50nm34%·>300nm≈0)·CeO₂<4% | 🟡 SUPPORTED-BY-CITATION | 장 translocation 문헌 · N1 §3 |
| 7 | 결합 erase = addressable×f_replaced, 12mo 0.64→천장 0.65 | 🟢 SUPPORTED-NUMERICAL | sim §5 [3] verbatim |
| 8 | **경구 *순환* monocyte 로딩 ~5e-4 · 순환풀 도달 미입증 (새 벽)** | 🟠 INSUFFICIENT | 경구 trafficking in-vivo 부재; IV만 실증 |
| 9 | 로딩-제한 dose-starved (bearers/laden 0.025<1) | 🟠 INSUFFICIENT | sim §5 [4]; f_gut/f_blood_mono 가정 |
| 10 | carbon black 20–30% net-erase≈0 천장 불변 | 🔵 SUPPORTED-FORMAL | BDE 5.37 eV (N1 §2·V2 §4) |
| 11 | monocyte subset-선택성·만성 로딩 안전성 | 🟠 INSUFFICIENT | N2 §4 전신효과 gate 동일 상속 |

```
   tier 분포:  🔵 4 · 🟢 1 · 🟡 3 · 🟠 3 · 🔴 0
   ──────────────────────────────────────────────────────────────
   AND-게이트 해소(촉매 localization) = 닫힘 (🔵).  결합 erase 모델 = 🟢.
   재포획자=monocyte·로딩 anchor·경구 천장 = 🟡.
   경구 순환-monocyte 로딩·dose·선택성 = 🟠 (새 병목 — 개념단계).
   → "AND-게이트는 진짜 풀린다. 단 벽은 경구 순환-monocyte 로딩으로 이전됐다."
```

**상속·신규 gap 정직 분리:**
- N1 에서 *풀린 것*: site-specificity (AND-게이트). conjugate(BP-N1a)도 dose-ceiling(BP-N1c)도 불요 — 운반이 둘 다 무료 충족.
- N2 에서 *상속*: subset-선택성(모든 순환 monocyte 로딩 → 진피-homing 만 못 고름) · 만성 노출 안전성 (monocyte 골수 신생 → 지속 로딩 필요).
- **신규(결합이 만든) 벽**: 경구로 *순환* monocyte 를 로딩하는 효율. ex-vivo(A)·IV(B)는 device → 제외. 경구(C)는 device-free 지만 ~5e-4 + 순환풀 도달 미입증.
- *불변* 천장: carbon black 20–30% (화학 한계, 전달로 안 풀림). ⇒ device-free 단독 erase 천장 ~65–75%, ≥90% 불가.

**돌파경로 (@D d2 — 포기 금지):**
1. **BP-x1**: 경구 → *gut-resident* monocyte 로딩을 인정하고, gut-derived monocyte 의 *전신 재순환* 분율을 실측 anchor (장→혈류 monocyte egress).
2. **BP-x2**: M-cell 표적 경구 NP(만노스/Co1 ligand)로 Peyer's patch 흡수↑ → 순환 진입 분율 끌어올림 (f_gut·f_blood_mono 동시 공략).
3. **BP-x3**: device-free 포기 없이 "최소-침습 경계" 재정의 — *경구 prodrug 이 in-situ 로 순환 monocyte 안에서 촉매로 self-assemble*(PNAS 2024 in-vivo monocyte programming 류) → ex-vivo 없이 순환 로딩.

---

## §5 hexa-native recompute (verbatim · 🟢 · `hexa run TTR-ORAL/sim/n1xn2.hexa`)

```
=== TTR-ORAL N1xN2: monocyte-carried pigment-gated catalyst ===

[1] AND-gate: pH-alone vs monocyte-carried catalyst localization
  N1 pH-alone overlap (ink-laden / acidic volume) = 1.8018e-08
  N1xN2 carrier monocytes              = 50000000.0
  carriers that ALSO captured pigment  = 1000000.0
  AND-gate self-satisfied fraction     = 0.02  (pigment-capturers / carriers)

  off-target acidic volume carrying catalyst = 0.0075 mL
  off-target REDUCTION vs pH-alone (5.55 mL) = 740.0x
  pigment-laden fraction of catalyst-active volume:
    pH-alone  = 1.8018e-08
    carriage  = 1.33333e-05
  AND-gate enrichment (carriage / pH-alone)  = 740.0x

[2] oral monocyte-loading efficiency (compose the gates)
  f_gut_translocate (oral->systemic particulate) = 0.01
  f_reach_blood_mono (circulating, not gut-res)  = 0.1
  f_loaded_active (survives exocytosis to dermis)= 0.5
  => oral circulating-monocyte loading efficiency = 0.0005
  (IV-loading precedent ~0.3-0.9; oral is ~0.0005 = THE relocated wall)

[3] combined erase timeline (N1 erase-frac x N2 monocyte turnover)
  tau_rep=90.0d ; addressable=0.65 ; carbon floor (non-erasable)=0.25
  t(mo)  f_replaced   erase_fraction   pigment_remaining
   1     0.286646  0.18632  0.81368
   3     0.636993  0.414045  0.585955
   6     0.868226  0.564347  0.435653
  12     0.982674  0.638738  0.361262

  erase ceiling (t->inf) = addressable 0.65 ; absolute cap (1-carbon) = 0.75

[4] loading-limited net: AND-gate solved, but loading gates throughput
  carriers x oral_load_eff = effective catalyst-bearing monocytes = 25000.0
  effective bearers / pigment-capturing monocytes = 0.025
  -> if <1, loading (not AND-gate) is rate-limiting; AND-gate win is real but starved.

[5] categorical off-target removal (non-carrier cells never see catalyst)
  body cells / carrier monocytes = 740000.0x cells made catalyst-free
  (pH-alone: ALL 3.7e13 cells' lysosomes ON; carriage: only 50000000.0 carriers)

=== N1xN2 done ===
verdict: carriage CONVERTS pH-alone 1.8e-8 overlap into a self-satisfied AND-gate
         (off-target acidic-volume reduction ~740x; ~7.4e5x fewer cells exposed) — N1 gap SOLVED.
         BUT the wall RELOCATES to oral circulating-monocyte loading (~5e-4 device-free,
         bearers/laden ~0.025 = dose-starved), and carbon-black ~25% floor caps erase ~65-75%.
```

---

## §6 정직 top-line 판정 (@D d2/d5/d6)

```
   "monocyte 운반이 N1 의 AND-게이트를 푸는가?"
   ──────────────────────────────────────────────────────────────
   AND-게이트 (site-specificity)  ✅ 푼다 — 촉매=monocyte내부 → 색소∧산∧촉매 co-loc 자동충족 (🔵)
                                       비-운반 3.7e13 세포 범주적 제거 (~7.4e5×↓ 세포)
   색소-근접 조건                  ✅ conjugate 불요 — 세포-운반이 무료 충족 (N1 BP-N1a 대체)
   off-target ROS 과부하           ✅ 비-운반 세포 ROS-ON 불가 — N1 §6[4] 5× 과부하 구조적 해소
   ──────────────────────────────────────────────────────────────
   경구 순환-monocyte 로딩          ❌ 새 벽 — device-free ~5e-4 (IV 0.3-0.9 대비 ~10³×↓) (🟠)
                                       순환풀 도달 in-vivo 미입증 (장-resident 만 실증)
   carbon black 20-30%             ❌ 불변 — BDE 5.37 eV, 전달로 안 풀림 → erase 천장 ~65-75%
```

- **AND-게이트는 진짜로 풀린다 (🔵 핵심).** N1 이 "pH-alone 으로 불가능"이라 판정한 site-specificity 는 *촉매를 어디 두느냐*의 문제였고, N2 운반(monocyte 내부)이 그 위치를 색소-포획 세포로 한정해 색소∧산∧촉매를 자동 co-localize. conjugate(BP-N1a)·dose-ceiling(BP-N1c) 둘 다 불요 — 결합의 창발성이며 N1 단독으로 못 푼 gap 을 닫는다. **단 벽은 *없어진 게 아니라 이전*됐다 (🟠)**: 새 병목 = device-free 경구로 *순환* monocyte 적재(~5e-4, IV 0.3–0.9 대비 ~10³×↓ · 순환풀 in-vivo 미입증 · dose-starved 0.025). carbon black 20–30% net-erase≈0 천장은 화학 한계로 불변 → 단독 erase ~65–75%.

⇒ **종합: monocyte-운반은 N1 의 AND-게이트(site-specificity)를 *진짜로* 푼다 — 결합의 창발성은 실재한다. 단 벽이 사라진 게 아니라 "경구 순환-monocyte 촉매 로딩"으로 *이전*됐고(개념단계 🟠), 이것이 새 결정 gate 다.** carbon black 천장(~65–75%)·subset 선택성·만성 로딩 안전성은 N1·N2 에서 상속. honest 판정: **"AND-게이트 = 해소(🔵) · 벽은 경구 순환-monocyte 로딩으로 relocate(🟠) · erase 천장 ~65–75% · ≥90% 불가."** absorbed=false 유지 — 새 wet-lab gate = *경구 dose 가 순환 monocyte 를 실제로 로딩하는가*.

---

## Sources
- IV monocyte/macrophage-hitchhiking · 순환 면역세포 NP 적재·T½9.2h·exocytosis 지연 — *Theranostics* hitchhiking nanomaterials (PMC10526662 · thno.org/v13p4781) · in-situ cellular hitchhiking (PMC10841869) · Selective Blood Cell Hitchhiking PLGA (PMC10371090) · *JACS* monocyte/macrophage-hitchhiked intratumoral (10.1021/jacs.9b11046) · *Sci Adv* immune-cell shuttle (10.1126/sciadv.abf2400)
- monocyte-hitchhiking 로딩 용량 (막 ~5% → <1.0 µg/10⁶ cells · ~100 NP/cell thiol) — Cell-Mediated Delivery review (PMC4142097) · macrophage-based drug delivery challenges (S2452199X2400135X) · monocyte subset Fe-oxide 차등 흡수 (PMC3184946)
- 경구 입자 장 translocation = 크기-게이트 (50nm 34% · 100nm 26% · >300nm ≈0) — intestinal translocation of particulates (0169409X9090020S) · GI nano/microparticle uptake 평가 (S0169409X98000416) · ACS Nano 장 통과 기전 (10.1021/acsnano.3c02403)
- 경구 NP = Peyer's patch / M-cell / *장-resident* mono·DC 국소 적재 (순환풀 도달 미입증) — oral vaccination Peyer's patch update (PMID 28847272) · human M-cell-like model (10.1038/nprot.2017.041) · polymeric oral NP delivery (PMC4835173)
- 말초투여 NP 가 *순환·resident* monocyte 표적 (IV/peripheral, 경구 아님) — *PLOS One* peripherally administered NP target monocytic myeloid cells (10.1371/journal.pone.0061646) · *PNAS* 2024 in-vivo monocyte programming polycation/mRNA (10.1073/pnas.2400194121) · monocyte trafficking NP into inflamed brain (PMC4846033)
- 재포획자 = 혈중 monocyte · 경구약 도달 구획 (N2 상속) — Baranska 2018 *J Exp Med* (PMID 29511065) · Lin 2024 *Immunology* (10.1111/imm.13714) — `N2_monocyte_trojan_horse.md` Sources
- pH-게이트·부피예산·CeO₂ ΔE·carbon black BDE·addressable 60–70% (N1 상속) — `N1_phagolysosome_pH_gate.md` §4·§6 · `TTR/verify/V2_formal_identities.md` §4·§7
