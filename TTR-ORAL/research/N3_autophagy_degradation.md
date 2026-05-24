# TTR-ORAL N3 — autophagy / 리소좀-분해 유도 (in-cell 색소 소화 · NOVEL 기전 deep-dive)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> NOVEL 후보 (@D d11): 색소-laden macrophage 를 *이동시키거나* 재포획을 차단하는 대신, **그 세포 안에서 autophagy/리소좀 catabolism 을 경구로 유도**해 삼킨 색소를 *제자리에서 소화*시킨다 (erase, not relocate → W1 해소 시도).
> 경구 autophagy inducer 는 실재한다 — rapamycin(sirolimus) · spermidine · trehalose · metformin · CR-mimetic.
> 정직 원칙 (@D d5/d6): "된다" 강제 금지. **핵심 honest check = §2** — 색소-laden macrophage 는 *이미* 산성 phagolysosome 안에서 완전한 hydrolase/oxidase toolkit 를 갖고 평생 색소를 잡고 있는데도 **소화하지 못한다**(anthracosis · Baranska). 즉 율속단계는 **autophagic flux 가 아니라 기질(색소) 화학**.
> sim = `sim/n3_autophagy.hexa` (verbatim §5). 입력 = `cycle1_grounding_reconcile.md`(W1 relocate-not-erase · 90d 사이클) · `N1_phagolysosome_pH_gate.md` §2·§3(분해성·부피예산) · `oral_adme_wall.md`(f_target) · `M9_lit_grounded_recovery.md`(τ_rec·Baranska).

---

## 1. 개념 — autophagy 를 "in-cell 분해율"로 모델화

자연 색소 영속성은 **capture-release-recapture** 사이클(Baranska, ~90일/cycle)이다. 죽는 macrophage 가 색소를 방출 → 인접/신규 macrophage 가 재포획 → 무한 반복 → 평생 유지. autophagy 유도는 이 사이클에 **세포 내 소화율 `k_dig`** 을 추가해, 재포획(`k_recap ≈ 1/90 /day`)과 *경쟁*하는 erase 항으로 작동한다(분해 가능 분율에 한정):

```
   p_erase/cycle = k_dig / (k_dig + k_recap)        (분해 가능 cargo 한정)
   k_eff_erase   ≈ p_erase · (1/cycle)               (effective erase term)
```

- autophagic flux 유도 배율: rapamycin/spermidine 로 basal 대비 **~2-3×** 가 현실적 천장(아래 §3 inducer 표).
- ⇒ *만약* 색소가 정상 분해성 cargo 라면, 유도 시 사이클당 erase 0.6 → ~0.79-0.82 (sim §5 [1]). **이건 낙관 천장이다** — §2 가 이 가정을 깬다.

---

## 2. ★ 정직 핵심 check — autophagy 가 정말 색소를 분해할 수 있는가?

**대부분 아니다.** 결정적 증거는 자연이 이미 실험을 해놓았다는 것이다:

```
   "리소좀 toolkit 은 이미 거기 있고, 평생 실패한다"
   ┌────────────────────────────────────────────────────────────┐
   │ Baranska/Inserm 2018 : 색소는 phagolysosome 안에서          │
   │   *분해되지 않고* macrophage 세대 간 그대로 전달됨           │
   │ anthracosis (탄광/매연): carbon 입자가 폐 macrophage 안에서  │
   │   평생 잔존 — "neither destroyed nor removed by the body"    │
   └────────────────────────────────────────────────────────────┘
   ⇒ basal autophagic flux 는 색소에 대해 effectively 0.
     0 에 2-3× 를 곱해도 0 (carbon/robust 분율).
```

**핵심 논리**: 색소-laden macrophage 는 산성 phagolysosome(pH ~4.5) + 완전한 hydrolase/oxidase 효소군을 *이미* 보유하고 색소를 *수십 년* 잡고 있다. 그런데도 색소가 그대로 다음 세대로 넘어간다. 따라서 율속단계는 **autophagic flux(전달·소화 용량)가 아니라 기질의 화학적 분해성**이다. autophagy 를 더 켜는 것은 "효소를 더 가져다 놓는" 것인데, 효소가 이미 평생 거기 있었고 실패했다.

```
  k_dig(carbon) = 0   →   p_erase(carbon) = 0   (induction × ANY = 0)
```

이것이 N3 의 정직한 천장을 설정한다: autophagy 유도는 **분해성 기질이 있는 곳에서만** 의미가 있고, 색소가 본질적으로 효소-내성이면(carbon/Cu-Pc/Cr₂O₃) 아무리 켜도 erase = 0.

---

## 3. 경구 autophagy inducer 후보 — BA · 유도 배율 · 색소 특이성

| inducer | 기전 | 경구 BA | autophagy 유도 크기 | 색소에 도움? (정직) |
|---|---|---|---|---|
| **rapamycin (sirolimus)** | mTORC1 직접 억제 (FKBP12) | 경구 흡수 OK (generic, compounded ~3-3.5× 낮음) | 강력·검증된 inducer | flux↑ 명확하나 **carbon 무력** · 면역억제제(부작용 큼) |
| **spermidine** | 폴리아민 · macroautophagy 자극 | 장에서 빠르게 흡수·전신 분포 (식이 BA 양호) | 생리적 inducer (배율 온건) | 마찬가지 flux↑ · 기질 게이트 못 넘음 |
| **trehalose** | SLC2A(GLUT) 억제 → AMPK → autophagy | **경구 BA 낮음** — 장 trehalase 가 대부분 분해, 1st-pass 청소 | 기전 논란(autophagy-비의존 경로 가능성) | 전신 도달 자체가 1차 벽 |
| **metformin** | AMPK → ULK1↑·mTOR↓ → **TFEB** 핵 이동 (리소좀 biogenesis) | 경구 표준약 (검증) | **macrophage 에서 phagocytosis·phagolysosome fusion·autophagy 촉진** + 리소좀 생합성↑ | inducer 중 macrophage 친화 최상 · 그래도 기질 게이트 동일 |

- **공통 정직 한계**: 네 inducer 모두 **전신(whole-body) autophagy = general housekeeping** 을 올릴 뿐, *잉크 macrophage 선택적*이지 않다. 색소-특이 표적화 기전이 없다.
- **metformin** 이 그나마 macrophage 리소좀 생합성(TFEB)을 직접 올려 색소 분해성 분율(azo)에 가장 유리하나, **carbon 천장은 동일**.
- **trehalose** 는 trehalase 1st-pass 로 전신 도달이 약해 경구 단독 효과가 의심.

---

## 4. 색소 클래스별 분해성 — autophagy 가 켜진 *이후*의 기질 게이트

`N1 §2` 의 분해성 ledger 를 autophagy(효소-매개 환원/가수분해) 관점으로 재평가:

```
              ┌──────────────┬───────────────────────────────────────────┐
   azo 유기   │ N=N cleavable│ ●● 리소좀/간 azoreductase 환원절단 (xenobiotic│
              │              │     대사 선례) → 색소 소실 (단 방향족 아민 독성)│
   Fe oxide   │ 산성 용해     │ ◐ "소화"보단 산성 pH 용해 + ferritin 처리(부분)│
   quinacridon│ H-bond 격자  │ ◐ 효소 핸들 빈약 — 대부분 저항                │
   carbon blk │ sp²C-C 5.37eV│ ✗ NONE — 효소·ROS 모두 bulk 분해 불가 (anthracosis)│
   Cu-Pc/Cr2O3│ 배위 wall     │ ✗ wall — 효소 무력                          │
              └──────────────┴───────────────────────────────────────────┘
```

- **azo (●●)**: 가장 신뢰할 만한 핸들. azoreductase 는 N=N 을 환원절단해 무색 방향족 아민 생성(포유류 간·xenobiotic 대사 선례). 단 산물 = 방향족 아민(독성 우려, moa §9-1). 시장 분율 중 azo 부분(~45%)이 실효 표적.
- **Fe oxide (◐)**: 엄밀히는 autophagy "소화"가 아니라 phagolysosome 산성 용해 + ferritin 격리 — 부분적·발색 회복 불확실.
- **quinacridone (◐)**: H-결합 결정 격자 → 효소 접근 빈약, 대부분 저항.
- **carbon black (✗)**: **honest floor.** sp² C-C BDE 5.37 eV. anthracosis 가 직접 증명 — 폐 macrophage 가 평생 효소를 들이대도 분해 못 함. autophagy 유도로도 **net erase ≈ 0**.
- **Cu-Pc/Cr₂O₃ (✗)**: 배위 wall, 효소 무력.

⇒ **enzymatically digestible band ≈ 0.45 (azo) ~ 0.55 (azo + Fe oxide 부분).** N1 의 산화-기반 ~60-70% 보다 *좁다* — autophagy 는 산화(•OH bulk 식각)보다 효소-환원/가수분해에 의존해 quinacridone·표면식각 분율을 못 잡기 때문.

---

## 5. hexa-native recompute (verbatim · 🟢 · `hexa run TTR-ORAL/sim/n3_autophagy.hexa`)

```
=== TTR-ORAL N3 autophagy / lysosomal-degradation induction ===

[1] in-cell digestion vs recapture (DEGRADABLE cargo only):
  k_recap (natural)            = 0.0111111 /day
  basal:  k_dig=0.0166667 -> p_erase/cycle = 0.6
  rapa2.5x: k_dig=0.0416667 -> p_erase/cycle = 0.789474
  max3.0x:  k_dig=0.05 -> p_erase/cycle = 0.818182

[2] substrate gate (carbon black sp2 C-C, BDE 5.37 eV):
  k_dig(carbon) = 0.0 /day  (anthracosis floor)
  p_erase(carbon) = 0.0  -> induction x ANY = still 0
  (lysosome toolkit present for LIFE & fails = flux is not the bottleneck)

[3] addressable pigment fraction (k_dig>0 = enzymatically degradable):
  azo (azoreductase N=N cleave)  : 0.45
  Fe oxide (acid dissolve/ferritin, partial): 0.1
  quinacridone (poor handle)     : 0.1  (mostly resists)
  carbon black (NONE)            : 0.25
  Cu-Pc + Cr2O3 (wall)           : 0.1
  => realistic DIGESTIBLE band ~ 0.45 - 0.55 (azo +/- Fe oxide)

[4] specificity of an ORAL (systemic) autophagy inducer:
  ink-laden fraction of body acidic compartments = 1.8e-08
  -> benefit is point-source; autophagy induction is whole-body
  (rapamycin = immunosuppressant; non-specific housekeeping boost)

[5] timeline IF autophagy digested the azo band (rapa 2.5x):
  p_erase/cycle (azo) = 0.789474
  n90 cycles          = 1.47777
  -> ~4.43332 months to 90% of the AZO fraction only
  (whole-tattoo color floor still set by carbon/Cu-Pc/Cr2O3 = un-erasable)

=== N3 done ===
```

**[1] 의 basal p=0.6 은 *반사실(counterfactual)* 천장** — "색소가 정상 분해성 cargo 였다면"의 수학이다. [2] 가 이 가정을 깬다: 실제 색소의 basal k_dig ≈ 0 (평생 비분해). 따라서 [5] 의 ~4.4개월은 **azo 분율에 *한정*된, 기질 게이트를 통과한 부분에 대해서만** 성립하며, 전체 타투 색상 바닥은 carbon/Cu-Pc/Cr₂O₃ 가 영구 설정한다.

---

## 6. 정직 한계 요약 + tier

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | p_erase = k_dig/(k_dig+k_recap) · effective erase 항 | 🔵 SUPPORTED-FORMAL | closed-form (sim §5 [1]) |
| 2 | §5 recompute (p_erase · n90 · band) | 🟢 SUPPORTED-NUMERICAL | verbatim |
| 3 | 색소가 phagolysosome 에서 *비분해*·세대간 전달 (capture-release-recapture) | 🟡 SUPPORTED-BY-CITATION | Baranska 2018 · Inserm |
| 4 | **anthracosis — carbon 평생 비분해·비제거** (honest floor) | 🟡 SUPPORTED-BY-CITATION | anthracosis 문헌 (§Sources) |
| 5 | carbon black bulk 분해 불가 (BDE 5.37 eV) | 🔵 SUPPORTED-FORMAL | unit-conv (V2 §4 / N1 §2) |
| 6 | rapamycin/spermidine/metformin 경구 autophagy 유도 (~2-3×) | 🟡 SUPPORTED-BY-CITATION | mTOR/AMPK-TFEB 문헌 |
| 7 | trehalose 경구 BA 낮음 (장 trehalase 1st-pass) | 🟡 SUPPORTED-BY-CITATION | trehalase 문헌 |
| 8 | azo azoreductase 환원절단 → 무색 아민 (xenobiotic 선례) | 🟡 SUPPORTED-BY-CITATION | azoreductase 문헌 |
| 9 | 오럴 inducer 비특이 (whole-body autophagy · ink 1.8e-8) | 🔵 SUPPORTED-FORMAL | 부피예산 N1 §3 |
| 10 | azo 분율 실효 디지털 efficacy in-vivo · 방향족 아민 독성 정량 | 🟠 INSUFFICIENT | wet-lab (M8/M9) |

---

## 7. 정직 top-line 판정 (@D d2/d5/d6)

- **기전은 매력적이나 자연이 이미 반증한다 (핵심 honest check)** — 색소-laden macrophage 는 산성 phagolysosome + 완전 효소 toolkit 를 갖고 *평생* 색소를 잡고도 소화 못 한다(Baranska 비분해 전달 · anthracosis 영구 잔존). 즉 **율속단계는 autophagic flux 가 아니라 기질 화학** — autophagy 를 더 켜는 것은 "이미 평생 실패해온 효소를 더 켜는" 것.
- **carbon black (시장 ~25%) = 🔴 floor** — sp² C-C 5.37 eV ≫ 효소/ROS 가용 에너지. anthracosis 가 직접 cautionary precedent. **autophagy 유도 × ANY = net erase 0.** 절대 못 지움.
- **organic azo (~45%) = 🟡 partial** — 리소좀/간 azoreductase 가 N=N 을 환원절단할 수 있다(xenobiotic 선례). + Fe oxide 산성 용해(부분) → digestible band **~45-55%** (N1 의 ~60-70% 보다 좁음). 단 (a) 방향족 아민 산물 독성 · (b) in-vivo 실효 미검증(🟠).
- **inducer 비특이성 = 🟠 부작용** — rapamycin/spermidine/trehalose/metformin 모두 *전신* autophagy(general housekeeping)를 올릴 뿐 잉크 macrophage 선택적이지 않다. 잉크-laden 은 체내 산성 구획의 **1.8×10⁻⁸**. 이득은 점-광원, 비용(rapamycin 면역억제 · trehalose GI/장내균 · 전신 catabolism)은 whole-body. metformin 이 macrophage 리소좀 생합성(TFEB)에 그나마 친화.

⇒ **종합: N3 은 "erase, not relocate" 의 진짜 erase 경로를 *원리상* 제시하나, anthracosis/Baranska 가 "macrophage 는 색소(특히 carbon)를 소화 못 한다"를 *이미 증명*했다는 정직한 반례에 부딪힌다.** autophagy 유도는 **분해성 기질(azo ~45%, +Fe oxide ~55%)** 에 한해서만 의미가 있고, **carbon black ~25% 는 효소-내성 floor(🔴)**, Cu-Pc/Cr₂O₃ ~10% 는 wall. 게다가 경구 inducer 는 비특이 전신작용이라 부작용 trade-off 가 크다. honest 판정: **"기전 매력적 · 그러나 율속단계는 기질이지 flux 아님 · digestible ~45-55% (azo 위주) · carbon 25% = 🔴 영구 floor · ≥90% 색상 erase 도달 불가 · inducer 비특이(🟠 부작용)."** N1(산화-게이트, ~60-70%)이 색소 적용범위는 더 넓고, N3 의 고유 가치는 **device-free·경구약 기존성(rapamycin/metformin)** 과 **erase 직접성**에 있으나 carbon floor 는 공유한다.

---

## Sources
- Tattoo 색소 macrophage 영속성 · capture-release-recapture · **색소 비분해 세대간 전달** — Baranska et al. 2018, *J Exp Med* (rupress.org/jem/article/215/4/1115) · Inserm Newsroom "Tattoos: are they really indelible?" (presse.inserm.fr/en/tattoos-are-they-really-indelible/58117) · ScienceDaily 2018 (sciencedaily.com/releases/2018/03/180306101708.htm)
- **anthracosis — carbon 입자 폐 macrophage 평생 비분해·비제거** (honest floor) — *Anthracosis: Etiology/Clinical/Diagnosis* (PMC4386010) · anthracosis mini-review (PMC11607103) · Black lung disease (en.wikipedia.org/wiki/Anthracosis) · airway macrophage black carbon SPIROMICS (PMC9664618)
- rapamycin(sirolimus) mTORC1 autophagy inducer · 경구 BA — *JCI* mTOR autophagy (jci.org/articles/view/73939) · MedChemExpress Rapamycin · Healthspan rapamycin dosing (gethealthspan.com/research/article/rapamycin-dosing-for-longevity)
- spermidine 생리적 autophagy inducer · 장 흡수 BA — *Autophagy* 2018 (tandfonline.com/doi/full/10.1080/15548627.2018.1530929 · PMC6287690) · *Science* AGING review (science.aan2788)
- metformin AMPK→ULK1/mTOR→**TFEB 리소좀 biogenesis** · macrophage phagolysosome fusion/autophagy — *Front. Genet.* 2022 (frontiersin.org/.../2022.1022739) · macrophage immunometabolism autophagy (PMID 33262773) · AMPK-FoxO1-TFEB foam cell (PMC8184689)
- trehalose SLC2A→AMPK autophagy · **경구 BA 낮음(장 trehalase 1st-pass)** · 기전 논란 — *Cell Death Dis.* 2018 (nature.com/articles/s41419-018-0749-9) · trehalose metabolic review (PMC8864729) · trehalase overview (sciencedirect trehalase)
- azo dye azoreductase 환원절단 N=N → 방향족 아민 (xenobiotic 대사) — *Bioresour. Bioprocess.* azoreductase review (link.springer.com/article/10.1186/s40643-018-0206-8) · gut microbiota azoreductase (nature.com/articles/s41598-019-41894-8)
- 색소 클래스 분해성 ledger · 시장 분율 · carbon BDE 5.37 eV — `N1_phagolysosome_pH_gate.md` §2 · `TTR/research/ink_classes.md` §6 · `TTR/verify/V2_formal_identities.md` §4
