# TTR-ORAL N9 — 햇빛-게이트 활성화 (free·device-free 외부 trigger)

> 🦠 **TTR-ORAL** — "면역세포 택배" · NOVEL 후보 N9 (per @D d11/d2 orthogonal probe)
> 컨셉: 불활성 prodrug를 삼킨다 → **타투 잉크가 햇빛을 흡수하는 곳 + 햇빛 닿는 피부**에서만 활성화.
> 햇빛은 공짜 + 환자 본인이 쬔다 → **device-free** (clinical laser=장비라 device-free 위반 → path A에서 OUT-OF-SCOPE). 잉크 자체가 antenna/photosensitizer, 주변광 UV-Vis-NIR이 에너지.
> N9의 질문: path A가 ruled-out한 laser 자리에, **AMBIENT SUNLIGHT**가 device-free trigger로 들어올 수 있는가?
> 정직 원칙 (@D d2/d6): "된다" 강제 금지. N9이 자기 벽에 부딪히면 그대로 적는다. sim = `sim/n9_sunlight.hexa`.

scope:
- in-scope: 태양 조도/스펙트럼 · 진피 잉크 깊이 도달 fluence · 잉크 광열/ROS · solar-vs-laser 정량 · prodrug uncaging chemistry · device-free 여부 · 부위특이성 · 광독성 safety · honest tier
- out-of-scope: caged active 경구 BA (M2-ORAL) · 특정 prodrug TDDFT 양자수율 (M5-ORAL) · 전신 safety 정식 (M6-ORAL)

---

## 1. 광물리 — 태양광이 진피 잉크까지 닿는가

### 1.1 피부 표면 태양 조도 + 스펙트럼 (AM1.5 1-sun)

전체 ~1000 W/m² (= 100 mW/cm²). 스펙트럼 분할 (Ossila): **UV 3-5% · Vis 42-43% · NIR 52-55%**.

| 대역 | 조도 (W/m²) | uncaging 관점 | 침투 |
|---|---|---|---|
| UV (~4%) | 40 | 고전 photo-uncage(oNB·coumarin)가 응답하는 대역 | **진피 거의 도달 못함** |
| Vis (43%) | 430 | 청색 cage는 표면, 적색쪽이 침투 | 적색 ~1.8 mm |
| NIR (53%) | 530 | 저에너지 광자(uncage 결합 못 깸) but 최심 침투 | ~2.5 mm |

### 1.2 진피 잉크 깊이(500-2000 μm) 도달 fluence — Beer-Lambert

`I(z) = I₀·exp(−z/δ)`. 잉크는 ~1 mm(중간 진피)에서 평가. δ = 1/e 침투깊이.

```
   해 ☀ (UV·Vis·NIR 1000 W/m²)
    │
 ───┼─── 표피 ~0.1 mm ────────  UV는 여기서 죽음 (δ_UV ≈ 0.1 mm)
    │ ▒▒▒                       Vis 적색·NIR만 통과
 ───┼─── 진피 ───────────────
    │  ▒                        z = 1 mm: 잉크 거주층
    ▼ ███ 잉크 (carbon black, 광대역 흡수)   ← 적색 ~57% · NIR ~67% 도달
                                                 UV ~0.0045%(사실상 0)
 ─── 잉크 깊이 500-2000 μm ───
```

verbatim (`hexa run TTR-ORAL/sim/n9_sunlight.hexa` §2):
```
[2] fraction of surface fluence reaching z=1mm ink (Beer-Lambert exp(-z/delta)):
  UV-A (delta 0.1mm) : 4.53999e-05  <- ~0.00453999% : UV essentially DEAD at depth
  red  (delta 1.8mm) : 0.573753  <- ~57.3753% reaches ink
  NIR  (delta 2.5mm) : 0.67032  <- ~67.032% reaches ink (best)
```

> **1차 발견**: 깊이 자체는 *치명적이지 않다* — 적색/NIR은 진피 잉크까지 57-67% 도달. 단 **UV는 진피에서 죽으므로**(0.005%) 고전 UV photo-uncage(oNB) 화학은 햇빛으로 진피에서 못 깬다. uncaging 대역은 **반드시 적색/NIR**이어야 함 → cage 화학이 묶인다 (path A §2.1 BODIPY 적색 cage와 동일 제약).

### 1.3 solar vs clinical laser — 활성화율 비 (결정적)

clinical Q-switched 타투 레이저: ~100 mJ / ~10 ns / ~3mm spot(0.07 cm²). 햇빛은 같은 면적에 ~10 mW(연속).

verbatim (§3):
```
[3] peak-irradiance ratio (laser pulse vs ambient sun):
  laser peak irradiance   = 1.42857e+12 W/m2  (100mJ / 10ns / 0.07cm2)
  ambient sun irradiance  = 1000.0 W/m2
  laser / sun (peak)      = 1.42857e+09 x   (~10 orders of magnitude)
```

> 레이저 peak 조도가 햇빛의 **~1.4×10⁹배**. 선형(1광자) 활성화율 `r ∝ I`이면 햇빛은 *순간당* ~10⁹배 느리다. 햇빛은 연속(6h/day)이라 *적분* fluence는 따라잡을 수 있으나(아래 1.4), **비선형/2광자(`r ∝ I²`)** 처럼 순간 고fluence가 필요한 어떤 항도 10⁹ peak gap을 못 메운다 → 2광자 깊이선택성(path A §1.2의 핵심 장점)은 햇빛에선 **소멸**.

### 1.4 광열 ΔT — 햇빛 정상상태 vs 레이저 ns 열가둠

레이저 ns 펄스 = 잉크 입자 내 **열가둠**(thermal confinement) → 단열 ΔT 수백 K(잉크 기화 → path A modality C). 햇빛 CW = 열이 확산+관류로 빠져나감 → 정상상태 ΔT 미미.

verbatim (§4):
```
[4] photothermal DeltaT — sun steady-state vs laser ns-confined:
  sun:   absorbed q at ink = 355.27 W/m2 ; DeltaT = q/h_eff = 2.36846 K
  laser: adiabatic local DeltaT = 238.095 K  (ns confinement -> 100s of K, ink vaporizes)
  => sun cannot reach the DeltaT that ns-laser confinement does, by ~100.527 x.
```

> 햇빛은 잉크층에 **~2.4 K 벌크 상승**만 만든다 (= "검은 타투가 햇빛에 따뜻해진다"는 일상 체감 그대로). 이는 thermo-cleavable linker 절단 문턱(국소 수백 K · path A §2.2 Arrhenius)에 **두 자릿수 못 미친다**. 관류가 열을 clamp. → **광열 uncaging 경로는 햇빛으로 닫힌다.**

---

## 2. Prodrug uncaging — 햇빛이 깰 수 있는 화학은?

§1에서 (a) UV cage = 깊이로 막힘, (b) 광열 = ΔT로 막힘. 남는 단 하나의 살아있는 경로 = **잉크-photosensitized ROS uncaging** (적색/NIR 흡수 → ¹O₂/•OH → ROS-labile cage 절단).

| uncaging modality | 햇빛 적합성 | 막히는 이유 / 살아있는 이유 |
|---|---|---|
| UV photo-cleavage (oNB) | ✗ | UV가 진피 도달 0.005% (§1.2) |
| 광열 thermo-labile linker | ✗ | 햇빛 ΔT ~2.4 K << 절단 문턱 (§1.4) |
| 2광자 voxel uncage | ✗ | `I²` 의존 + 10⁹ peak gap (§1.3) → voxel 선택성 소멸 |
| **잉크-photosensitized ROS** | △ | 잉크가 적색/NIR 흡수 → ¹O₂ → amino-acrylate/aminoacrylate linker 절단 (가시광 prodrug 선례 존재). 단 carbon-black은 좋은 photosensitizer가 아님(주로 열로 변환); Fe/유기 잉크라야 ROS↑ |

후보 caged chemistry (path A §3와 교집합, 단 **적색/NIR + ROS-labile**로 제약):
- **amino-acrylate-caged active**: ¹O₂가 amino-acrylate linker 절단 → active 방출 (visible-light prodrug 문헌의 확립 linker). active = caged deferiprone(경구 BA 검증) 또는 caged reductant(azo F2).
- **thioether/세렌 ROS-labile cage**: ROS 산화로 친수화 → 절단. 단 dark ROS(내인성)에 자가-활성화 risk → `r_dark` 악화 (path A §1.3).

> tier: 잉크 적색/NIR 흡수 → ROS는 원리상 가능(🟡 photosensitizer 문헌); 단 carbon-black의 ¹O₂ 양자수율은 낮음(열 변환 우세) → **진피에서 햇빛-구동 ROS flux가 uncage에 충분한가는 🟠 미실측**.

---

## 3. 정직한 self-check (critical) — N9은 벽을 넘는가, 부딪히는가

### (a) 깊이 벽 + 10⁹ 약함

깊이는 적색/NIR로 부분 통과(§1.2, 57-67%)하나, **leverage 가능한 uncage 화학(UV·열·2광자)이 모두 막히고** 남은 ROS 경로는 햇빛 조도에서 flux가 미미. peak 조도 ~10⁹배 약함(§1.3)은 비선형 게이팅을 죽인다.

### (b) 부위 특이성 — 전신 prodrug + 전신 햇빛 = 모든 노출 피부 활성화 (치명적)

이게 N9의 **고유 벽**이다. prodrug는 전신 균일. 햇빛은 타투만 못 겨냥한다 → **햇빛 닿는 모든 피부**에서 활성화. 타투의 높은 흡수(잉크 antenna)는 *돕지만*, 맨피부도 햇빛+자체 chromophore(melanin/hemoglobin)로 활성화.

verbatim (§5):
```
[5] site-specificity under whole-body sun + systemic prodrug:
  ink vs bare-skin absorption contrast = 100.0 x  (ink IS a far stronger antenna)
  but bare sun-exposed skin area (0.3 m2) >> tattoo (0.005 m2)
  tattoo's share of total photo-activation events = 0.625
```

```
        clinical LASER (path A)            ambient SUN (N9)
   ┌────────────────────┐          ☀ 전신 노출 (얼굴·팔·목 0.3 m²)
   │   ▼ aim only 타투   │          ░░░░░░░░░░░░░░  ← 맨피부도 활성화
   │  ███ 타투만 활성    │          ░░░░░███░░░░░  ← 타투는 share 0.625뿐
   └────────────────────┘          타투 겨냥 = 불가 (해는 못 조준)
   share ≈ 1.0  ✓ 부위특이          share ≈ 0.6  ✗ 비특이
```

> 잉크가 맨피부보다 ~100배 강한 antenna여도, 맨 노출피부 면적(0.3 m²)이 타투(0.005 m²)의 60배라 **희석**된다 → 타투의 활성화 share는 ~0.625에 그침. clinical laser는 타투만 조준해 share≈1.0. **햇빛은 조준이 없어 부위특이성을 못 만든다** — path A §1.2의 spatial-gating(`I(x)=0 off-site`) 핵심 전제가 햇빛에선 깨진다 (`I(x)>0` 전신).

### (c) 광독성/광민감성 safety

전신 photosensitizing prodrug + 햇빛 = **drug-induced photosensitivity** (DermNet/Frontiers). DIP는 피부 약물이상반응의 ~8%, 주로 UVA 매개 phototoxic(과장된 일광화상). N9은 ROS-생성 prodrug를 전신 순환시키므로 **노출 피부 전체가 phototoxic risk** → (b)의 비특이성이 safety 벽으로 직결.

### (d) "햇빛에 서 있기" = device-free인가, 약한 통제불능 레이저인가?

명목상 device-free(공짜·환자 적용·장비 없음 → TTR-ORAL @goal "no needles·no rub-on" 충족, "swallow only"는 미충족 — path A와 동일 hybrid). 하지만 **물리적으로는 통제불능·미조준·~10⁹배 약한 광원**. clinical laser의 두 핵심 무기(조준=부위특이성 · 고fluence=활성화율)를 **둘 다 잃는다**. → device-free 라벨은 얻으나, laser를 device-free로 대체한다는 N9의 전제 자체가 물리적으로 성립하지 않음.

---

## 4. honest tier + verdict

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | 태양 조도 1000 W/m² · UV4/Vis43/NIR53% · Beer-Lambert 깊이 도달(적색57·NIR67·UV0.005%) | 🔵→🟡 | exp(-z/δ) closed-form(🔵) · δ값/스펙트럼 출처 인용(🟡) |
| 2 | laser/sun peak 조도 ~1.4×10⁹× · 비선형/2광자 게이팅 소멸 | 🔵 | E/(t·A) closed-form |
| 3 | 햇빛 정상상태 ΔT ~2.4 K << thermo-linker 문턱 | 🔵→🟡 | q/h_eff closed-form(🔵) · h_eff/μ_a order(🟡) |
| 4 | 전신 prodrug+전신 햇빛 → 타투 share ~0.625 (비특이) | 🔵→🟠 | 면적·흡수 budget closed-form(🔵) · 실제 μ_a/면적은 🟠 |
| 5 | 잉크-photosensitized ROS = 유일 살아있는 uncage 경로, but flux 미실측 | 🟠 | photosensitizer 문헌(🟡) · 진피 햇빛-ROS flux 충분성 🟠 |
| 6 | 전신 photosensitizer+햇빛 = drug-induced photosensitivity 광독성 | 🟡 | DermNet/Frontiers DIP |

```
   N9 honest scorecard (verbatim §6)
   depth (UV uncage @1mm)      : 4.5e-05  → UV photo-uncage UNREACHABLE
   peak-irradiance gap vs laser: 1.4e9 x
   sun photothermal DeltaT     : 2.4 K    → no thermal uncaging
   tattoo activation share     : 0.625    → NOT site-specific
```

> **종합 (🟠 INSUFFICIENT → 사실상 WALL)**: N9은 device-free 라벨은 얻지만, laser를 햇빛으로 대체한다는 전제가 **세 겹으로 막힌다** — (1) uncage 가능 화학(UV·열·2광자)이 깊이/ΔT/비선형으로 모두 닫히고 단 ROS만 남는데 햇빛 flux가 미미, (2) ~10⁹배 약한 peak 조도, (3) **부위 특이성 부재**(전신 prodrug + 미조준 햇빛 → 모든 노출 피부 활성화, 타투 share ~0.6). (3)은 path A spatial-gating의 `I(x)=0 off-site` 전제를 정면으로 깬다 → 비특이성이 광독성 safety 벽으로 직결. **N9은 자기 벽에 부딪힌다.** "불가능"이 아니라 — *only 살아있는 좁은 틈* = §5의 잉크-photosensitized ROS(carbon-black 아닌 ROS-active 잉크 + ROS-labile red/NIR cage)이며, 이조차 부위특이성을 풀지 못한다.

### 벽 앞 돌파경로 (@D d2 — 포기 금지 · 정직 fence)
| # | path | 원리 | 한계 |
|---|---|---|---|
| BP1 | **2-gate AND (햇빛 ∧ 진피-국소조건)** | 햇빛 단독 대신 [햇빛-ROS] ∧ [진피 phagolysosome pH(N1)/효소] 직렬 게이트 → 맨피부엔 잉크-phagolysosome 없어 2nd gate fail → 부위특이성 복구 | ROS flux 여전히 미미; 복잡도↑ |
| BP2 | **포지셔닝: "햇빛 보조 점진 fade"** | sub-year 지우개 아님 → 자연 fade를 햇빛-잉크 ROS가 *살짝* 가속하는 보조제(cycle1 §4 BP4와 동형) — 정직한 near-term fit | 효과 미약·정량 미실측 |
| BP3 | **NIR 우선 + ROS-active 잉크 한정** | carbon-black(열 우세) 대신 Fe-oxide/유기 잉크의 photo-Fenton(•OH) 활용, 적색/NIR로 깊이 확보 | 잉크-클래스 의존 · Cu-Pc/Cr₂O₃ 벽 |

→ N9의 가장 정직한 위치: **device-free 라벨은 OK이나, 부위특이성+활성화율 벽으로 laser 대체 불가. 살아있는 틈은 2-gate AND(BP1)로 부위특이성을 복구할 때뿐이며, 단독 햇빛-게이트는 walls-3겹.**

---

## Sources
- Solar spectrum / AM1.5 (UV3-5·Vis42-43·NIR52-55%, ~1000 W/m²): [Ossila — The Solar Spectrum](https://www.ossila.com/pages/the-solar-spectrum) · [Solar irradiance — Wikipedia](https://en.wikipedia.org/wiki/Solar_irradiance)
- 피부 광 침투 깊이 (UV~0.1mm · 적색1.8 · NIR2.5mm · optical window): [Finlayson 2022, *Photochem Photobiol*](https://onlinelibrary.wiley.com/doi/full/10.1111/php.13550) · [NIR window — Wikipedia](https://en.wikipedia.org/wiki/Near-infrared_window_in_biological_tissue) · [skin optical properties review, PMC10368038](https://pmc.ncbi.nlm.nih.gov/articles/PMC10368038/)
- Q-switched ns laser (100mJ/~6-10ns, photothermal tattoo): [Q-switched laser — ScienceDirect](https://www.sciencedirect.com/topics/physics-and-astronomy/q-switched-laser) · [ns Q-switched 1064/532 clinical, PMC8544362](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8544362/)
- Carbon-black 타투 잉크 광흡수/열물성: [black ink thermal/physical props, PubMed 22983425](https://pubmed.ncbi.nlm.nih.gov/22983425/) · [carbon black 타투 잉크, ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S0143720824006946)
- 가시광-활성 prodrug / ¹O₂ uncage (amino-acrylate linker 절단): [Visible-light prodrug, PMC11298069](https://pmc.ncbi.nlm.nih.gov/articles/PMC11298069/) · [Caged photosensitizers ¹O₂ tuning, Nat Commun 2024](https://www.nature.com/articles/s41467-024-51872-y)
- 광열 NP 정상상태 ΔT / 관류 (1-sun): [Nanoparticle bioheat review, PMC6568271](https://pmc.ncbi.nlm.nih.gov/articles/PMC6568271/)
- Drug-induced photosensitivity (전신 photosensitizer + 햇빛, UVA, ~8% ADR): [DermNet — DIP](https://dermnetnz.org/topics/drug-induced-photosensitivity) · [Frontiers Allergy DIP, PMC9552952](https://pmc.ncbi.nlm.nih.gov/articles/PMC9552952/)
