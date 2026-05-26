# NUMB G6 — 인접 토픽 양립성 (동일 부위 co-application matrix)

> 🧊 **NUMB G6 (general-purpose mapping · per @D d10)** — NUMB(lid+tet eutectic · pH 5.5 lactate buffer · epi 1:200k Rx-V1)가 동일 시술 부위에서 **sunscreen · antiseptic(chlorhexidine·povidone-iodine) · moisturizer/화장품 · 다른 topical(retinoid·AHA/BHA)** 과 만났을 때 outcome 클래스 `{동시 · 시간차 · 금기}` 와 기전적 이유(pH · SC penetration 경쟁 · 화학 반응)를 정한다. + 안와/점막 wall(N6 통합).
>
> **honest tier verdict: 🟡 SUPPORTED-BY-CITATION (양립성 매트릭스 결정 로직 + 화학 기전은 임상/물리 정합 · 정량 multiplier는 보수적 lit 추정 → Franz/turbidimetry wet-lab gate)**. 닫힌형(HH f_free)은 🟢 hexa-native 검증. 핵심 outcome(CHG 침전 · PVP-I 순서 · 점막/안와 금기)는 published evidence 직접 anchor. **honest framing(@D d5/d6)**: cosmetic adjunct co-application 임상 데이터는 **희박** → default outcome = **시간차(staggered)**, "동시 안전 가정" 금지.
>
> sim = `NUMB/sim/g6_compatibility.hexa` (verbatim §7, hexa_real GREEN run).
>
> **honest framing (N1·N6·N7 학습 흡수, per @D d6)**: 인접제는 `J_ss = D_eff·K_sc·a` 의 **prefactor**(occlusion → SC hydration → permeability · pH → f_free · barrier 파괴 → K_sc)에만 작용 → **depth + LAST Cmax** 변화. `t_lag = h²/(6 D_eff)` 와 무관 → **"보습제 깔면 더 빨리 마취" = FALSE**.

---

## 1. 양립성 매트릭스 (인접제 × outcome × 이유)

| 인접제 | 동시 | 시간차 | 금기 | 핵심 이유 (pH · penetration · 화학) |
|---|---|---|---|---|
| **sunscreen (유기 UV필터)** | ✗ | ◐ (시술 **후** 도포 = ✅) | ✗ under-NUMB (시술 field) | (1) laser/광역학 빔 차단·산란 (2) 유기 필터(oxybenzone/octinoxate/octocrylene) = SC 침투 lipophilic **co-penetrant** → SC partition 경쟁 (3) oily vehicle = occlusion → NUMB J ↑. **시술 후 광민감 피부 보호 = RECOMMENDED** |
| **chlorhexidine (CHG, cationic)** | ✗ **CONTRA** (wet-mix) | ✅ **MANDATORY** (CHG → DRY 2-3min → NUMB) | wet 동시 혼합 | CHG di-cation + NUMB 음이온종(lactate buffer + carboxylate CPE) → **불용성 염 침전 ~5min** → 양쪽 모두 불활성화 |
| **povidone-iodine (PVP-I, oxidizer)** | ✗ | ✅ **ORDERED** (PVP-I → DRY → wipe → NUMB) | NUMB-first | amide lid 와 직접 파괴반응 없음. but **NUMB-first = I₂ 유리 차단 → 소독 실패** (IOVS 2011). epi(catechol)는 잔류 free I₂에 minor 산화 위험 (dry mitigates) |
| **moisturizer / 화장품 (occlusive)** | ✗ under-NUMB | ✅ (화장품은 시술 **후**) | occlusive under-NUMB | occlusion → SC hydration ↑ → barrier ↓ → 흡수 ↑ → **LAST Cmax ↑** (peel-film occlusion 위에 추가 stack). 메이크업/보습제는 NUMB field 아래·위 금지 |
| **retinoid / AHA / BHA (barrier-disrupting)** | ✗ | ✅ **DAYS** (3-5일 중단) | 갓 박피·찰과 피부 | SC 지질 barrier 파괴 → TEWL ↑ → co-active 흡수 ↑. **broken barrier = systemic 흡수 spike → LAST envelope 붕괴** → CONTRA on freshly-peeled/abraded skin |

- 범례: ✅ = 권고 · ◐ = 조건부 · ✗ = 비권고 · **CONTRA** = 금기
- **공통 원칙**: 위 어느 항목도 **onset 단축 안 함** — 모두 depth/LAST/efficacy 만 변화 (N1·N6·N7 학습).

### 1.1 부위 wall (N6 통합) — 매트릭스 별도 행
| 부위 | OTC-A (lid 4%) | Rx-V1 (lid+tet+epi) | Rx-V2 (capric ternary) | 이유 |
|---|---|---|---|---|
| **안와/안검연 (미용 botox/filler 근처)** | small-area + eye shield only ("avoid eyes") | **CONTRA** | **CONTRA** | tet/BLT corneal damage class (JCAD 2016) |
| **구강·비강·결막 점막** | **CONTRA** | **CONTRA** | **CONTRA** | 각질 SC barrier 부재 → 급속 systemic 흡수 (≈ intratracheal-class) → LAST overdose route |

---

## 2. 화학 양립성 분석

### 2.1 chlorhexidine + NUMB (양이온 + 음이온 침전)
- **기전**: chlorhexidine gluconate = 강한 **di-cation**. 음이온/산성 counterion 과 만나면 **불용성 염 형성 → 침전 ~5min** (turbidity 5분 내 발생, 10일 관찰서 광범위 침전 — Tran/Huynh systematic review · Int J Pharm lidocaine-CHG study).
- **NUMB의 음이온종**: lactate buffer (pH 5.5) + linoleic acid CPE (carboxylate) + (Rx-V1) lid·anion ion-pair 후보. → CHG 와 wet-film 동시 접촉 시 침전 risk.
- **참고**: lidocaine HCl + CHG 직접 침전 documented; **cyclodextrin 포접 복합체**는 침전 rescue (urogenital gel 사례). NUMB 는 eutectic free-base 위주라 HCl 염보다 약하지만, lactate/carboxylate 존재로 risk 유지.
- **결론**: **wet-mix 금기 · 시간차 필수** (CHG 완전 건조 후 NUMB).

### 2.2 povidone-iodine + NUMB (산화 환경)
- **lid free-base + oxidizer**: amide 결합은 I₂에 안정 → lidocaine 자체 파괴반응 없음.
- **순서 효과 (결정적)**: lidocaine gel **먼저** = 물리적 barrier → **I₂ 유리 차단 → 소독 실패** (IOVS ARVO 2011, "lidocaine gel was a barrier to antisepsis when administered prior to PVP-I"). **PVP-I 먼저** = 소독 OK → 이후 NUMB.
- **epi(Rx-V1) 산화**: epinephrine = catechol → 잔류 free I₂ 환경에서 minor 산화 위험. dry + wipe 로 완화.
- **결론**: **시간차 + 순서 고정** (PVP-I → DRY(I₂ 작용) → wipe excess → NUMB). NUMB-first 금기.

### 2.3 sunscreen 유기 필터 (SC 점유 → penetration 경쟁/촉진)
- 유기 UV 필터(oxybenzone/octinoxate/octocrylene/homosalate) = **SC 침투 → 혈중·소변·모유 검출** (ScienceDirect 2019 systemic availability). = lipophilic **co-penetrant**.
- **경쟁 vs 촉진 양면**: (a) SC lipid partition 자리 경쟁 → lid free-base partition ~10% derate. (b) oily SPF vehicle = occlusion → NUMB SC hydration ↑ → J ↑ ~1.3×. → **net ≈ 1.17×** (sim §5).
- **UV 노출**: octocrylene SC penetration **1.4×**, epidermis **5.7×** (16분 UV) → 시술 전 SPF 가 빔에 의해 더 침투 → 불확실성 ↑.
- **결론**: 시술 field 아래 SPF = **CONTRA** (빔 차단 + 미특성 co-penetrant). 시술 **후** 광민감 피부 보호용 = RECOMMENDED.

### 2.4 moisturizer occlusion (SC hydration → penetration ↑)
- occlusion → SC hydration ↑ → barrier efficiency ↓ → **percutaneous absorption ↑** (Zhai 2001 · petrolatum PMC8705314 · lamellar body review). "often but not always" — 보수적으로 ↑ 가정.
- NUMB 는 이미 peel-film occlusive → **추가 occlusive 는 stack** → LAST Cmax 18 → **25.2 ng/mL** (occ 1.4×, sim §6).
- **결론**: NUMB field 아래/위 보습제·메이크업 금지. 깨끗·건조 피부 → NUMB. 화장품은 시술 후.

### 2.5 retinoid / AHA barrier disruption
- retinoid + glycolic acid(AHA) = SC 지질 barrier 파괴 → **TEWL ↑** + 다른 active 흡수 ↑ (PMC11344648 · Smith 1996 glycolic acid SC functional change). "glycolic acid can enhance skin absorption of other actives including retinol."
- broken barrier 위 NUMB → J_ss + systemic uptake 동반 상승 → LAST Cmax 18 → **28.8 ng/mL** (1.6×). 둘 다 stack(occ×barrier) = **40.3 ng/mL** worst-case.
- **결론**: 3-5일 중단(시간차-DAYS) 또는 NUMB area/농도 de-rate. 갓 박피/찰과 피부 = CONTRA.

---

## 3. 시간차 도포 순서 가이드 (canonical, 시술 당일)

```
1. 세척  — 화장품/보습제/SPF 제거 · pH 정상화 (acid mantle 5.5) · DRY
2. 소독  — 필요 시 PVP-I (또는 CHG) → DRY 2-3min
              · CHG 는 반드시 완전 건조 (wet-mix = 침전)
              · PVP-I 는 반드시 NUMB 보다 먼저 (NUMB-first = 소독 실패)
3. (옵션) excess antiseptic wipe — NUMB film 에 섞이지 않게
4. NUMB 도포 — 깨끗·건조 피부에만 · SKU 별 occlude · onset 대기
5. NUMB 제거 (wipe off) → 무균 깨졌으면 antiseptic 재도포 → PROCEDURE
6. 사후관리 — 광민감 피부(laser)엔 SPF · 화장품은 시술 후 (절대 전 ✗)
```

**NEVER**:
- 보습제/SPF/retinoid 를 NUMB **아래**에 layer
- CHG 를 NUMB 와 **wet-mix**
- NUMB 를 **점막/안검연**에 도포

**핵심 비대칭**:
- antiseptic → NUMB (순서 고정) — antiseptic 먼저, 건조 후
- NUMB → wipe → procedure → post-care
- **sunscreen 는 procedure 후** (laser 후 광보호) — 절대 NUMB 아래 ✗

---

## 4. 안와/점막 wall (N6 통합)

| wall | 정량/기전 | NUMB rule |
|---|---|---|
| **안와 (미용 botox/filler near eye)** | BLT/tet corneal damage class (JCAD 2016 case report) | Rx-V1(tet)·Rx-V2 = **CONTRA** in orbital rim/eyelid margin. OTC-A(lid 4%, tet 無) = small-area + **eye shield** only ("avoid eyes") |
| **점막 (구강·비강·결막)** | 각질 SC barrier 부재 → 급속 systemic 흡수 (lidocaine viscous USPI · oral soft tissue 풍부한 모세혈관 → intratracheal-class 속도). epi-on-oral-mucosa 흡수 modulation (PMC8246680) | **CONTRA 전 SKU** — NUMB 는 keratinized-skin 전용. 점막 사용 = LAST overdose route |

- mucosal systemic-absorption multiplier vs intact skin ≈ **5×** (보수적 order; sim §8).
- N6 corneal wall + 본 mucosa wall = NUMB 의 **physical exclusion zone** (눈·입·코 점막).

---

## 5. hexa-native co-application sim (verbatim · per @D g5 · 🟢 numerical)

전체 출력 (host = darwin local `hexa_real`, GREEN run, file = `NUMB/sim/g6_compatibility.hexa`):

```
=== NUMB G6 — adjacent-topical co-application compatibility matrix ===

[2] pH-shift sub-model — does a co-applied alkaline product perturb NUMB f_free / epi?
  lid f_free @ native pH 5.5 = 0.00396511  (ionized, epi stable)
  lid f_free @ alkaline 8.5  = 0.799233  (free-base, BUT epi degrades)
  -> alkaline co-product would BOTH raise f_free AND destroy epi 1:200k -> LAST Cmax UP.

[3] ANTISEPTIC — chlorhexidine gluconate (CHG, cationic)
  precipitation risk flag (CHG + NUMB anionic species) = 1.0 (TRUE)
  OUTCOME = STAGGERED MANDATORY: CHG -> let DRY fully (2-3min) -> then NUMB.
  CONTRAINDICATED concurrent (do not mix in same wet film).

[4] ANTISEPTIC — povidone-iodine (PVP-I, oxidizing free I2)
  epi oxidation risk under residual free I2 = 1.0 (TRUE, minor; dry mitigates)
  OUTCOME = STAGGERED, ORDERED: PVP-I -> DRY -> wipe excess -> NUMB.
  NUMB-first is CONTRAINDICATED (antisepsis defeated).

[5] SUNSCREEN — net co-application factor on NUMB J = 1.17
  OUTCOME (BEFORE) = CONTRAINDICATED under NUMB at treatment field (beam + co-penetrant)
  OUTCOME (AFTER)  = RECOMMENDED (post-care photoprotection)

[6] MOISTURIZER — added occlusion factor = 1.4 -> Cmax 25.2 ng/mL (vs 18 baseline)
  OUTCOME = STAGGERED / AVOID under NUMB

[7] RETINOID/AHA — disrupted-barrier multiplier = 1.6 -> Cmax 28.8 ng/mL
  OUTCOME = STAGGERED-DAYS (3-5d); broken barrier = CONTRAINDICATED

[8] PERIORBITAL+MUCOSA — mucosal absorption multiplier vs skin = 5.0
  periorbital tet SKUs CONTRA (cornea); mucosa CONTRA all SKUs

[10] OUTCOME CLASSIFIER
  sunscreen=under-CONTRA/after-OK · CHG=STAGGERED-MANDATORY · PVP-I=STAGGERED-ORDERED
  moisturizer=AVOID-under · retinoid/AHA=STAGGERED-DAYS · periorbital=tet-CONTRA · mucosa=all-CONTRA
  NONE shortens onset; all affect depth / LAST / efficacy only.

[11] LAST stacking (baseline 18 ng/mL)
  extra occlusion -> 25.2 · disrupted barrier -> 28.8 · both -> 40.32 ng/mL (all << toxic 5000)

=== verdict: STAGGERED is the safe default for ALL adjuncts ===
=== CHG wet-mix + sunscreen-under-NUMB + retinoid-broken-barrier + mucosa = CONTRAINDICATED ===
=== PVP-I and CHG are STAGGERED-ORDERED (antiseptic first, dry, then NUMB) ===
=== no co-applied adjunct shortens onset (t_lag D-driven); they move depth + LAST Cmax only ===
```

- HH f_free (0.00397 / 0.799 @ pH 5.5/8.5) = N7 검증 anchor 와 정확 일치 → 🟢 numerical.
- LAST stacking 산술(18×1.4=25.2 · 18×1.6=28.8 · 18×1.4×1.6=40.32) = self-consistent.

---

## 6. deep research 발견 (arxiv + web · per @D d18)

### 6.1 arXiv — multi-layer / co-application transdermal modeling
| paper | id | 핵심 발견 | G6 적용 |
|---|---|---|---|
| **Pontrelli et al. 2019** | **2001.03058** | pH-responsive 2-layer (core + polymeric shell) drug delivery PDE — 2상 eigenvalue · interface flux continuity | co-application = 피부 계면에 **다중 superposed layer** → 동일 2-layer PDE formalism 으로 antiseptic/SPF/NUMB stack 의 flux 연속 조건 풀이 |
| Pontrelli & de Monte 2014 | 1405.1413 | two-phase two-layer SC + viable epi eigenvalue | co-applied 외부 layer = K_sc layer-dependent boundary condition |
> ⚠ live arxiv API fetch 는 본 세션 sandbox IP rate-limit (HTTP "Rate exceeded") → N7 deep research 에서 검증된 peer-reviewed arxiv anchor 재인용. multi-layer co-application 의 정확한 PDE grounding 으로 직접 적용.

### 6.2 web — co-application 임상/화학 evidence
| source | URL | 핵심 발견 | G6 적용 |
|---|---|---|---|
| **Tran/Huynh systematic review** (CHG anionic incompat) | researchgate.net/publication/359653415 | CHG cation = 음이온제와 **불활성화+침전** | §2.1 CHG wet-mix 금기 anchor |
| **lid-HCl + CHG cyclodextrin gel** | PMC3148842 / tandfonline IJN.S20409 | lid+CHG **침전 5min 내** · cyclodextrin 포접 rescue | §2.1 침전 kinetics anchor |
| **lid + irrigants NMR** | PMC4119375 / PMID 25097652 | lid HCl + various irrigants 상호작용 (NMR) | §2.1 ion 의존 침전 보강 |
| **PVP-I before lidocaine gel** (IOVS ARVO) | iovs.arvojournals.org/article.aspx?articleid=2358277 · PMID 21366185 | **순서 결정적**: PVP-I 먼저 = 소독 OK · lid-gel 먼저 = barrier → 소독 실패 | §2.2 PVP-I 순서 anchor |
| **lid gel + PVP-I infection ↓** | PMC7423597 | 혼합도 소독력 유지(PVP-I 단독 수준) — but 순서 권고 | §2.2 보강 |
| **organic UV filter SC penetration** | sciencedirect S0160412019320008 · S0928098718302574 | 유기 필터 SC 침투 → 혈중/소변 검출 · 캡슐화 시 표면 잔류 | §2.3 SC co-penetrant anchor |
| **UV exposure raises octocrylene penetration** | (ScienceDirect diffusion cell) | UV 16min → SC 1.4×, epidermis 5.7× | §2.3 빔-유발 침투 anchor |
| **occlusion raises percutaneous absorption** | Zhai 2001 (Contact Dermatitis) · PMC8705314 · escholarship 6z32h7hm | occlusion → SC hydration → barrier ↓ → 흡수 ↑ | §2.4 occlusion anchor |
| **petrolatum occlusive barrier** | PMC3565729 | occlusive cream = TEWL ↓ 통한 SC hydration | §2.4 보강 |
| **retinoid/AHA barrier disruption** | PMC11344648 · PMID 8651024 (Smith 1996) | retinoid+AHA → TEWL ↑ · 지질 production ↓ · co-active 흡수 ↑ | §2.5 barrier-disrupt anchor |
| **lidocaine viscous mucosa absorption** | drugs.com lidocaine-topical-oral-solution · DailyMed lidocaine viscous | 점막 = 농도·부위·시간 의존 급속 흡수 · 농축액 gargle = 독성 위험 | §4 점막 금기 anchor |
| **epi on oral mucosa absorption** | PMC8246680 | epi 가 oral mucosa lid 흡수 modulation (rat) | §4 점막 보강 |
| **chlorhexidine vs PVP-I skin prep** | PMC4796470 · academic.oup.com bjsopen zrab117 | CHG > PVP-I 소독력 · CHG-alcohol 피부 반응 ↑ | §1 antiseptic 선택 맥락 |

### 6.3 deep research 종합 → G6 design implication
1. **CHG + NUMB = wet-mix 금기** (cation-anion 침전 5min) → 시간차 mandatory (건조 우선).
2. **PVP-I 순서 결정적** (PVP-I 먼저, NUMB-first 금기) — 화학 파괴 아닌 physical barrier 효과.
3. **sunscreen 유기 필터 = co-penetrant + occlusion** → NUMB field 아래 금기, 시술 후만.
4. **occlusion + barrier-disruption 은 LAST stack** → Cmax 25-40 ng/mL (안전하나 envelope tighten).
5. **점막/안와 = 급속 흡수/corneal wall** → 전 SKU 점막 금기, tet SKU 안와 금기 (N6 통합).
6. co-application 임상 데이터 **희박** → default 시간차 · honest "임상 미확인" flag.

---

## 7. residual walls + breakthrough paths (per @D d2)

| wall | 정량 | breakthrough |
|---|---|---|
| **W1 cosmetic-adjunct 임상 co-application data SPARSE** | SPF/보습제 + NUMB 동시 Franz 미측정 | **1-point Franz co-application study** (NUMB ± SPF/moisturizer) ($500-1000) |
| **W2 CHG-NUMB 침전 kinetics (THIS formulation)** | lid-HCl 일반 침전은 known, NUMB eutectic 정량 미측정 | **turbidimetry mix test** (NUMB + 2% CHG · t=0/5/10min) ($100-200) |
| **W3 epi 산화 by 잔류 PVP-I free I₂** | 정량 미측정 | **epi-HPLC after PVP-I contact** ($200-400) |
| **W4 barrier-disruption Cmax multiplier (1.6×)** | 보수적 lit 추정, 미측정 | **TEWL-graded Franz series** ($800-1500) |

### 7.1 minimum-spend wet-lab gate (~$1600-3100)
W2 turbidimetry($100-200) + W3 epi-HPLC($200-400) + W1 Franz co-app($500-1000) + W4 TEWL-Franz($800-1500). W2 가 가장 cheap → 가장 먼저 (CHG 침전 정량 → 🟡→🟢).

---

## 8. NUMB.md 갱신 안 (G6 milestone flip)

```diff
-- [ ] G6 — 인접 토픽 양립성 — sunscreen · antiseptic (chlorhexidine·povidone) · moisturizer · 화장품 · 동일부위 시간차 도포 가이드
+- [x] G6 → `NUMB/research/G6_compatibility.md` (+ sim `g6_compatibility.hexa`) · 🟡 · **양립성 매트릭스 (인접제 × {동시·시간차·금기} × 이유)** — CHG=시간차-MANDATORY (cation-anion 침전 5min, wet-mix 금기) · PVP-I=시간차-ORDERED (PVP-I 먼저, NUMB-first 소독실패) · sunscreen=under-NUMB 금기 (빔차단+co-penetrant)/시술후 권고 · moisturizer=AVOID under (occlusion→LAST↑ 25.2ng/mL) · retinoid/AHA=시간차-DAYS 3-5d (barrier파괴→LAST↑ 28.8ng/mL, broken barrier 금기) · **안와=tet SKU CONTRA (cornea, N6) · 점막=전 SKU CONTRA (급속흡수 5×)** · canonical 순서: 세척→antiseptic→DRY→NUMB→wipe→procedure→post-care SPF · honest framing: 인접제는 J_ss prefactor/LAST 만 변화, **onset 무관** (t_lag D-driven) · co-app 임상데이터 희박→default 시간차 · arxiv Pontrelli 2019 (2001.03058) 2-layer PDE grounding · breakthrough $1600-3100 (turbidimetry+epi-HPLC+Franz co-app+TEWL-Franz)
```

---

## 9. honest verdict

🟡 **SUPPORTED-BY-CITATION** — 양립성 매트릭스 outcome 결정 로직 + 화학 기전이 published evidence 직접 anchor; 닫힌형 pH/LAST 산술은 🟢 hexa-native 검증. 정량 multiplier(occlusion 1.4× · barrier 1.6× · mucosa 5×)는 보수적 lit 추정 → wet-lab measurement gate.

| 축 | tier | 근거 |
|---|---|---|
| CHG cation-anion 침전 금기 | 🟡 | Tran/Huynh review · lid-CHG 침전 5min (PMC3148842) |
| PVP-I 순서 (PVP-I first) | 🟡 | IOVS ARVO 2011 (PMID 21366185) 직접 |
| sunscreen co-penetrant + 빔차단 | 🟡 | ScienceDirect SC penetration + UV 1.4-5.7× |
| occlusion → 흡수↑ LAST stack | 🟡 | Zhai 2001 · petrolatum occlusive |
| retinoid/AHA barrier disruption | 🟡 | PMC11344648 · Smith 1996 (PMID 8651024) |
| 점막 급속 흡수 금기 | 🟡 | lidocaine viscous USPI · PMC8246680 |
| 안와 corneal wall (N6) | 🟡 | JCAD 2016 (inherited N6) |
| HH f_free closed-form | 🟢 | hexa-native (N7 검증 재현, 0.00397/0.799) |
| LAST stacking 산술 | 🟢 | self-consistent (25.2/28.8/40.3 ng/mL) |
| onset 가속 (만약 주장 시) | 🔴 FALSIFIED | N1·N6·N7 학습; prefactor ≠ t_lag |
| co-application 정량 multiplier | 🟠 | 보수적 lit 추정 (Franz/turbidimetry 측정 필요) |

**다음 cycle 액션**:
1. W2 turbidimetry($100-200) 가장 cheap → CHG-NUMB 침전 정량 (🟡→🟢)
2. G7 user-guide 의 dispatcher 에 G6 co-application 경고 통합 (antiseptic 순서 + 점막/안와 veto + "no SPF/moisturizer under NUMB")
3. G6 매트릭스 → OTC-A Drug Facts "Other warnings" + Rx-V1 USPI "Drug Interactions" 섹션 반영
4. arxiv 2001.03058 (Pontrelli 2019) 2-layer PDE hexa-native 구현 → multi-layer co-application flux 정량 (V3 verify 보강)
