# TTR-ORAL Path A — 경구 pro-drug + 외부 국소 활성화 (spatial gating) deep-dive

> 마일스톤 M3-ORAL의 4 breakthrough path 중 **Path A** 정밀 분석 (`oral_feasibility_scope.md` §3-A 확장).
> 핵심: 무해한 불활성 pro-drug를 경구 섭취 → 전신 분포 → **타투 피부 패치에만 외부 trigger 국소 인가** → 그 자리에서만 활성형 전환.
> 정직 원칙 (@D d5/d6): "된다"를 압력으로 강제하지 않음. Path A는 **hybrid** (먹는 약 + 시술)임을 명시하고, 부위 특이성 wall이 *원리상 닫히는지*만 정량.
>
> 입력 = `TTR/research/ink_classes.md` §4 (8 표적) · `TTR/research/moa_shortlist.md` §2(F2 reductive)/§3(F3 chelation)/§4(F4 photo) · `oral_feasibility_scope.md` §2 (site-specificity wall).
> 출력 = spatial-gating 정량 · 활성화 modality ≥3 · pro-drug→active 쌍 (azo/Fe MoA 교집합) · 정직 caveat · per-claim tier.

scope:
- in-scope: spatial-gating 1차 원리 · on/off contrast 정량 · 3 modality trigger physics + 침투깊이 + 정밀도 + 선례 · pro-drug 설계 제약 · honest tier
- out-of-scope: 경구 ADME 흡수율 (M2-ORAL) · pro-drug 합성 route (M7-ORAL) · 전신 off-target safety 정식 (M6-ORAL) · TDDFT 양자수율 recompute (M5-ORAL)

---

## 1. Spatial-gating 1차 원리 — 왜 이게 site-specificity wall을 깨는가

### 1.1 wall 재진술

`oral_feasibility_scope.md` §2: 경구 약은 60-70 kg **전신**에 퍼지는데 표적은 ~10-100 cm² 진피 패치다. 반응성 화학(azo 절단 reductant · Fe³⁺ chelator)을 전신 활성으로 투여하면 모든 조직을 공격 → therapeutic window 없음.

### 1.2 spatial gating = 활성화를 trigger 장(field)에 종속시킨다

핵심 전환: 약을 **활성형으로 먹지 않고**, *trigger가 켜진 곳에서만* 활성형으로 변하는 **불활성 caged pro-drug**를 먹는다. 활성화율을 외부 trigger 세기 `I(x)`의 함수로 만든다.

```
활성화율   r(x) = A · σ · I(x)^n · [P]      (P = pro-drug 농도, 전신 ~균일)

  σ   = uncaging cross-section (1광자) 또는 2광자 단면적 δ
  I(x)= trigger fluence/intensity (위치 x)
  n   = trigger 차수 (1광자 n=1 · 2광자 n=2 · sonodynamic ~1-2)
```

전신 [P]는 거의 균일하지만, **`I(x)`가 타투 패치 밖에서 0이면 off-site `r=0`**. 활성화는 trigger를 켜는 시술자가 공간을 100% 통제한다.

```
        ─── activation 전 (pro-drug only, trigger OFF 전신) ───
  머리   팔   간   타투패치   다리   발
   P     P    P      P        P     P        ← 불활성 pro-drug 균일 분포
   ·     ·    ·      ·        ·     ·        ← 활성형 A 농도 = 0  (어디에도 반응 없음)

        ─── activation 후 (trigger ON, 타투 패치에만 빛/US 인가) ───
  머리   팔   간   타투패치   다리   발
   P     P    P    ┃P→A┃      P     P        ← 패치 안에서만 P→active 전환
   ·     ·    ·    ┃███┃      ·     ·        ← 활성형 A: 패치 内 high, 외부 0
                  └ I(x)>0 ┘
```

### 1.3 on/off contrast 정량 (closed-form)

대조비를 trigger 세기 비로 직접 쓴다:

```
C = r_on / r_off = ( I_on / I_off )^n
```

- **이상적 차단** (trigger를 켜지 않은 부위 `I_off → 0`): `C → ∞`, 즉 off-site 활성화 ≈ 0. 이것이 wall 돌파의 형식적 핵심.
- **현실적 누설** (trigger가 새거나 pro-drug가 자가-uncage하는 dark rate `r_dark`): contrast가 유한해진다.

```
C_real = ( A σ I_on^n + r_dark ) / r_dark = 1 + (A σ I_on^n) / r_dark
```

dark activation이 contrast의 분모를 지배한다 → **pro-drug의 thermal/hydrolytic 안정성(`r_dark` 최소화)이 spatial gating 성패를 결정** (§4 설계 제약과 §5 caveat의 핵심).

2광자(n=2)는 `I²` 의존이라 초점 밖 fluence 제곱으로 급감 → **축방향(깊이) 공간 제한**까지 얻는다(1광자는 빔 경로 전체 활성화, 2광자는 초점 voxel만). 이것이 modality간 정밀도 차이의 1차 원리다.

> 형식 결론: `r_off = A σ I_off^n + r_dark`. trigger를 끄면 첫 항 = 0이므로, **off-site 활성화의 유일한 source는 `r_dark`**. wall은 "전신 균일 분포"가 아니라 "`r_dark`를 충분히 낮추는 pro-drug 설계 문제"로 환원된다 — 즉 wall이 *원리상 닫히지 않는다*. tier: **🔵 SUPPORTED-FORMAL** (활성화율 = trigger 세기 함수 · contrast = 세기비 멱승).

---

## 2. 활성화 modality ≥3 — trigger physics · 침투 · 정밀도 · 선례

진피 잉크는 500-2000 μm 깊이에 거주(`ink_classes.md` §0). modality는 이 깊이까지 trigger를 전달하면서 공간 정밀도를 유지해야 한다.

### 2.1 modality A — 광-uncaging 화학 (photo-uncaging · caged compound)

caged group이 광흡수 → 결합 절단 → 활성 약물 방출. cage별 1차 원리:

| cage 화학 | 흡수 λ (nm) | 절단 기전 | 1광자 / 2광자 | 진피 침투 (ink_classes §4 표) | 비고 |
|---|---|---|---|---|---|
| **o-nitrobenzyl (oNB)** | 254-365 (UV-A) | Norrish-type → o-nitroso + 약물 방출 | 1광자 주력 · 2광자 δ 낮음 | UV-A ~1.5 mm (진피 도달 가능, 경계) | 가장 검증된 cage; 부산물 nitroso 독성 평가 필요 |
| **coumarin-4-yl (DEACM 등)** | 350-470 (UV-A~청색) | heterolytic C-O 절단 → coumarinylmethyl cation | 1광자 + 2광자 δ ~1-40 GM | 청색 ~수 mm 경계 | red-shifted variant(ITC 등)로 가시광화 가능 |
| **BODIPY-cage (meso-methyl)** | 500-650 (녹색~적색) | visible-light heterolysis | 1광자 가시광 · 2광자 양호 | 가시광 ~3 mm (진피 관통) | **진피 깊이에 최적** — 적색쪽일수록 침투 ↑ |

광물리: `E(λ) = 1240/λ(nm)` eV (`moa_shortlist.md` §4.1과 동일 형식). 활성화 효율 = **uncaging quantum yield Φ_u × 흡수 ε × 도달 fluence**.

- **1광자**: 침투 깊이 = λ 함수 (UV-A 1.5 mm → BODIPY 적색 3 mm). 빔 경로 전체 활성화 → 깊이 선택성 없음(피부 표면도 활성화).
- **2광자**: `r ∝ I²` → 초점 voxel(μm³)만 활성화, 깊이 선택성 확보. 단 NIR fs-laser 필요 + 침투 fluence 제곱 손실 → 2 mm 깊이 활성화는 surface 대비 fluence 급감.

> 선례: caged-glutamate / caged-Ca²⁺ (신경과학 표준), coumarin/oNB cage는 약물전달 문헌의 수십년 검증 도구. BODIPY-cage = 가시광 photopharmacology 최신. tier: cage별 흡수 λ + Φ_u 일반값 **🟡 SUPPORTED-BY-CITATION**; 진피 도달 fluence는 `moa_shortlist.md` §4.1 침투깊이 표 외삽 **🟡**. 특정 pro-drug 쌍의 진피 *유효* Φ_u → **🟠 INSUFFICIENT-DEFERRED** (M5 TDDFT).

### 2.2 modality B — 집속 초음파 (focused ultrasound, FUS) / 온열 (mild photothermal)

기계적/열적 trigger로 결합 절단 또는 캡슐 파열.

| sub-modality | trigger physics | 침투 깊이 | 공간 정밀도 | 선례 |
|---|---|---|---|---|
| **FUS (sonodynamic)** | 음향 초점에서 cavitation/국소 가열 → thermo-labile pro-drug 절단 또는 sonosensitizer ROS | cm 단위 (음파는 조직 거의 무손실 관통) — 진피 여유 | 초점 ~mm³ (주파수·F-number 함수) | HIFU 종양 ablation · sonodynamic therapy(SDT) 임상 |
| **mild photothermal** | NIR(808/1064 nm) → photothermal agent 흡수 → 국소 ΔT (40-45°C) → thermo-cleavable linker 절단 | NIR ~5 mm (`ink_classes.md` §4: 가장 깊은 피부 침투) | 빛 spot 크기 (mm) + 열 확산 한계 | NIR photothermal drug release 광범위 문헌 |

1차 원리:
- FUS 깊이 = **광보다 압도적** (음파 감쇠 << 광 산란). 진피 500-2000 μm는 FUS에 trivial depth. 단 thermo-labile pro-drug는 본질적으로 `r_dark`가 체온(37°C)에서 0이 아님 → §1.3 contrast 분모 악화 risk.
- mild photothermal: ΔT trigger. Arrhenius `r ∝ exp(-Ea/kT)` → 활성화 vs dark의 contrast는 `exp(Ea/k · (1/T_body - 1/T_trigger))`. **Ea가 충분히 커야 37°C dark가 억제됨** (이것이 thermal modality의 설계 제약).

> 선례: HIFU/SDT는 임상 ablation·약물방출 양쪽으로 확립. tier: FUS 침투(음향 감쇠) **🔵 SUPPORTED-FORMAL** (감쇠 계수 closed-form); thermal contrast Arrhenius **🔵 SUPPORTED-FORMAL** (단 Ea는 분자별 → 🟠); SDT ROS 양자수율 진피값 **🟠 INSUFFICIENT-DEFERRED**.

### 2.3 modality C — 잉크-as-photosensitizer (기존 타투 레이저 파장 leverage) ★자기표적화

가장 우아한 경로: **잉크 자체가 외부 레이저를 흡수**해 국소 열/ROS를 만들고, 그 열/ROS가 *인접한* pro-drug를 uncage한다. 잉크가 있는 곳 = 활성화되는 곳 → 별도 trigger 정렬 불필요(자기표적화).

```
       기존 타투 레이저 (755 nm Alexandrite / 1064 nm Nd:YAG)
              │ hν
              ▼
        ╔═════════════╗
        ║ 잉크 입자    ║  ← carbon black: 흑체 흡수율 ~1.0 (ink_classes §1.3)
        ║ (흡수체)     ║     Cu-Pc: Q-band; Fe oxide: 광흡수
        ╚══════╤══════╝
               │  photothermal ΔT (국소 ns 펄스 → μm 반경 열점)
               │  + photo-Fenton •OH (Fe oxide / TiO₂가 있을 때, moa §1.1)
               ▼
        ┌──────────────┐
        │ 인접 pro-drug │  ← 잉크 표면 ~μm 이내 caged 분자만
        │   P → active │     (열/ROS gradient가 거리로 급감 → 자기표적)
        └──────────────┘
```

| 레이저 | λ (nm) | E (eV) | 진피 침투 | 흡수 잉크 | trigger 산물 |
|---|---|---|---|---|---|
| Q-switched Alexandrite | 755 | 1.64 | ~3-4 mm | 흑·청·녹 (carbon, Cu-Pc) | photothermal ΔT (ns 펄스 → 국소 고온) |
| Q-switched Nd:YAG | 1064 | 1.17 | ~5 mm (최심) | 흑·청 (carbon, Fe₃O₄) | photothermal ΔT |
| (frequency-doubled) Nd:YAG | 532 | 2.33 | ~2 mm | 적·주황 (azo, Fe₂O₃) | photothermal + photoacoustic |

1차 원리:
- carbon black 흡수율 ~1.0 (`ink_classes.md` §1.3) → 755/1064 nm 펄스의 거의 전 에너지를 열로 전환. ns 펄스 → 입자 표면 μm 반경에 순간 고온점.
- 열/ROS gradient는 거리로 급감 → §1.3의 `I(x)`가 *잉크 입자 자체*가 되어 공간 정밀도 = 잉크 분포 정밀도(μm). **이미 시술 인프라(타투 제거 레이저)가 존재**하는 것이 결정적 이점.
- 단, 이 modality는 thermo/oxidation-labile pro-drug를 요구 → §2.2 thermal과 동일한 `r_dark` 제약 + ROS-labile cage 설계.

> 선례: 755 nm Alexandrite · 1064 nm Nd:YAG = **현 타투 제거 임상 표준 장비** (`moa_shortlist.md` §4.1 표). 광열 약물방출은 NP 문헌 확립. tier: 레이저 침투 깊이 + 잉크 흡수 **🟡 SUPPORTED-BY-CITATION** (임상/광물성 데이터); 잉크 열점 반경 + 인접 uncaging 효율 **🟠 INSUFFICIENT-DEFERRED** (열확산 + ROS 확산 reaction-diffusion 모델 = M5).

### 2.4 modality 비교 요약

| 축 | A 광-uncaging | B FUS/photothermal | C 잉크-as-sensitizer |
|---|---|---|---|
| 진피 침투 (500-2000 μm) | UV-A 경계 · 가시광/BODIPY 도달 | FUS 충분 · NIR 충분 | 755/1064 nm 충분 |
| 공간 정밀도 | 1광자 빔경로 · 2광자 voxel | 초점 mm³ | **잉크 분포 = μm (최고)** |
| trigger 인프라 | UV/가시 LED·laser | HIFU/NIR laser | **기존 타투 레이저 (이미 존재)** |
| `r_dark` 부담 | 낮음 (cage는 광에만 응답) | 중간 (thermal labile) | 중간 (thermo/ROS labile) |
| 1차 원리 깊이 | 양자수율 · 흡수 | 음향감쇠 · Arrhenius | 흑체흡수 · 열/ROS 확산 |

---

## 3. Pro-drug → active 쌍 — 공유 TTR ink 화학과의 교집합

active는 `moa_shortlist.md`의 MoA를 *실행*해야 한다: **azo N=N 환원 절단(F2)** 또는 **Fe³⁺ chelation(F3)**. pro-drug는 이 active를 cage/mask한 불활성 전구체.

### 3.1 azo 절단 active (F2 reductive · `ink_classes.md` §2.2.1)

azo는 시장 60-70%의 가장 cleavable 표적 (BDE 167 kJ/mol, E°(azo/hydrazo) ≈ -0.3 V).

| pro-drug (caged) | active (uncaged) | MoA 교집합 | uncaging trigger | 설계 메모 |
|---|---|---|---|---|
| **caged reductant** (oNB-mask된 thiol/ascorbate) | 유리 thiol·ascorbate → azo N=N 환원 | F2 reductive (moa §2.2) | 광-uncage (modality A) | thiol을 disulfide/oNB로 mask → 광 절단시 유리 환원체 |
| **caged azoreductase cofactor** (caged-NADPH) | NADPH → azoreductase 구동 (moa §2.2, K_cat ~10² s⁻¹) | F5/F2 효소 | 광-uncage | 효소는 내인성(인체 NQO1·CYP P450 reductase) 활용 가능 |
| **azo-quinone redox pro-drug** | photo/thermal로 ROS → azo radical pathway (moa §1.1 ¹O₂) | F1+F2 hybrid | modality C (잉크 ROS) | azo 자체가 잉크일 때 잉크-sensitizer가 인접 환원 구동 |

### 3.2 Fe³⁺ chelation active (F3 · `ink_classes.md` §3.2)

Fe oxide (PR 101 적/갈 · PY 42 황)는 log K(DFO-Fe³⁺)=30+로 chelation thermodynamic 충분.

| pro-drug (caged) | active (uncaged) | MoA 교집합 | uncaging trigger | 설계 메모 |
|---|---|---|---|---|
| **caged deferiprone** (oral chelator, ink_classes §3 표) | deferiprone → Fe³⁺ 격자 추출 (log K 36) | F3 chelation | 광-uncage 또는 thermal | **deferiprone·deferasirox는 이미 경구 BA 검증된 FDA 약** → 경구성 충족 |
| **photo-Fe-reductant** (caged ascorbate) | ascorbate → Fe³⁺→Fe²⁺ 환원 (E° -0.17 V, moa §2.4) → 용해 후 chelation | F2→F3 직렬 | modality A/C | Fe oxide가 잉크일 때 잉크-광-Fenton(moa §1.1)과 직렬 |
| **caged DFO** (hexadentate mask) | DFO → Fe³⁺ (log K 30.6, moa §3.3) | F3 chelation | 광-uncage | DFO는 IV/SC 약; 경구 BA 낮음 → deferiprone이 경구엔 우선 |

> 경구성 핵심: **deferiprone·deferasirox는 이미 oral iron-chelator로 시판** → "경구 BA"라는 가장 큰 oral 장벽이 active 자체에는 이미 풀려 있다. caging만 추가하면 spatial-gating pro-drug가 된다. tier: active의 MoA thermodynamic(log K·E°) **🔵 SUPPORTED-FORMAL** (`moa_shortlist.md` 인용 closed-form); deferiprone 경구 BA **🟡 SUPPORTED-BY-CITATION** (FDA 라벨); caged 형태 경구 BA + 진피 도달 농도 **🟠 INSUFFICIENT-DEFERRED** (M2-ORAL ADME).

### 3.3 pro-drug 설계 제약 (3대 요건)

```
①  경구 BA          : caged 분자가 GI 흡수 → first-pass 생존 → 전신 도달
                      (deferiprone-class active는 ✓; oNB cage 추가시 logP/MW 재평가)
②  전신 inertness    : 활성형 활성 0 + dark rate r_dark ≈ 0  (§1.3 contrast 분모)
                      → cage가 active의 결합/킬레이트 site를 완전히 차폐해야
③  clean uncaging    : trigger 1회로 high Φ_u 절단 · 부산물 무독성
                      (oNB → nitroso 부산물 독성 평가; coumarin/BODIPY 부산물 양성)
```

---

## 4. 정직한 caveat (@D d5/d6 — "된다" 강제 금지)

1. **이것은 HYBRID다, "먹기만" 아님.** Path A는 *경구 pro-drug + in-clinic 광/US 세션*. `oral_feasibility_scope.md` §3-A의 framing 그대로 — 사용자 체감은 "먹는 약 + 빛 쪼임"이라 침습/도포는 없지만, **순수 경구는 아니다.** TTR-ORAL @goal의 "no needles · no rub-on"은 충족하나 "swallow only"는 아님.
2. **활성화 깊이 한계.** 잉크는 500-2000 μm. UV-A oNB cage(~1.5 mm)는 깊은 진피 잉크에 fluence 부족 → 가시광/BODIPY cage 또는 modality B/C(NIR·FUS·잉크-sensitizer)가 깊이를 푼다. 즉 **cage 화학과 modality는 깊이 제약으로 묶여 선택된다.**
3. **off-target risk = trigger 누설 + 자가-활성화.** §1.3에서 off-site `r_off = A σ I_off^n + r_dark`. (a) trigger 산란/누설로 `I_off > 0`이면 패치 주변 정상 피부도 활성화 → 홍반/색소변화. (b) pro-drug가 체온/가수분해로 자가-uncage(`r_dark > 0`)하면 **전신 어디서나 저농도 활성화** → oral track 최대 wall인 전신 독성(M6-ORAL)으로 직결. → pro-drug 안정성이 안전성을 지배.
4. **반응 산물 안전성.** azo 절단 산물의 방향족 아민(aniline·benzidine class, IARC group 1/2A)은 `moa_shortlist.md` §9-1과 동일 risk — 진피 활성화여도 림프/혈류로 systemic exposure 가능 (M6-ORAL 1순위).
5. **잉크-as-sensitizer는 잉크가 흡수해야 성립.** Cu-Pc/Cr₂O₃ wall(`moa_shortlist.md` §7)처럼 흡수가 약하거나 ROS 생성이 낮은 잉크에는 modality C가 약함 → 잉크 클래스 의존적.

---

## 5. Per-claim tier ledger (project rubric · 🔵/🟢/🟡/🟠)

| # | claim | tier | 근거 |
|---|---|---|---|
| 1 | 활성화율 `r(x) = A σ I(x)^n [P]` · contrast `C = (I_on/I_off)^n` | 🔵 SUPPORTED-FORMAL | closed-form photophysics; 멱승 의존 |
| 2 | trigger OFF시 off-site activation의 유일 source = `r_dark` → wall이 "pro-drug 안정성 문제"로 환원 | 🔵 SUPPORTED-FORMAL | §1.3 `r_off` 분해 |
| 3 | 2광자 `r ∝ I²` → 초점 voxel 축방향 깊이 선택성 | 🔵 SUPPORTED-FORMAL | 2광자 흡수 closed-form |
| 4 | FUS 침투 깊이(음향 감쇠) · thermal contrast Arrhenius `exp(Ea/k·ΔT⁻¹)` | 🔵 SUPPORTED-FORMAL | 감쇠/Arrhenius closed-form (단 Ea 분자별 미정 → 행 7) |
| 5 | cage 흡수 λ · 침투 깊이 (oNB UV-A 1.5mm · 가시광 3mm · 755/1064nm 3-5mm) | 🟡 SUPPORTED-BY-CITATION | `moa_shortlist.md` §4.1 침투 표 + 임상 laser 데이터 |
| 6 | active MoA 교집합 (azo E° -0.3V · deferiprone log K 36 · DFO 30.6) | 🔵→🟡 | thermodynamic은 🔵 closed-form / 값 출처는 🟡 인용 |
| 7 | 특정 pro-drug 쌍의 진피 *유효* Φ_u / 잉크 열점 반경 / 인접 uncaging 효율 / `r_dark` 절대값 | 🟠 INSUFFICIENT-DEFERRED | M5-ORAL TDDFT + reaction-diffusion 필요 |
| 8 | caged active의 경구 BA + 진피 도달 농도 | 🟠 INSUFFICIENT-DEFERRED | M2-ORAL ADME PBPK |
| 9 | 전신 off-target(trigger 누설·자가활성화·방향족 아민) safety | 🟠 INSUFFICIENT-DEFERRED | M6-ORAL |

---

## 6. 정직한 top-line 판정 (per @D d2/d5)

- **부위 특이성 wall은 원리상 닫히지 않는다 (🔵).** spatial gating은 전신 균일 분포를 trigger 장으로 국소화하며, off-site 활성화의 유일한 source가 `r_dark`로 환원됨을 closed-form으로 보인다 — wall은 "전신 분포"가 아니라 "pro-drug 안정성(`r_dark`↓) 설계 문제"가 된다.
- **단 Path A는 hybrid다 (정직 caveat).** 순수 경구가 아니라 경구 pro-drug + in-clinic 광/US 세션. TTR-ORAL @goal의 "swallow only"는 미충족, "no needles/no rub-on"은 충족.
- **결정적 미해소 (🟠).** 진피 유효 양자수율 · 잉크 열점 reaction-diffusion · caged active 경구 BA · 전신 누설/자가활성화 safety — 4개 모두 M5/M2/M6-ORAL로 정직하게 deferred. 이것들이 풀리기 전엔 "된다"고 말하지 않는다.

→ **종합: Path A는 oral track의 부위 특이성 wall을 first-principles로 *부분 개방*한다. 형식적 핵심(🔵)은 닫히지 않으나, 정량 효율·경구 BA·전신 safety(🟠)가 미해소이므로 honest 판정은 "wall partly open, hybrid 전제, 정량 검증 deferred".**

---

## Cross-reference

- 입력: `oral_feasibility_scope.md` §3-A (Path A scope) · §2 (site-specificity wall)
- ink 화학: `TTR/research/ink_classes.md` §2.2.1 (azo) · §3.2 (Fe oxide) · §4.1 (침투 깊이 표) · §0 (진피 깊이 500-2000 μm)
- MoA: `TTR/research/moa_shortlist.md` §2 (F2 reductive · azo·Fe) · §3 (F3 chelation · DFO/deferiprone) · §4.1 (광물리·laser λ) · §1.1 (photo-Fenton) · §9 (방향족 아민 safety)
- 다음: M2-ORAL (caged active 경구 BA·진피 농도 PBPK) · M5-ORAL (진피 유효 Φ_u TDDFT · 잉크 reaction-diffusion) · M6-ORAL (전신 누설·자가활성화 safety)
- @D d2 (wall breakthrough): 본 문서는 Path A를 "불가능" 언급 없이 정량 개방
- @D d6 (first-principles): photophysics closed-form (활성화율·contrast·Arrhenius·음향감쇠) + BDE/E°/log K 인용만 사용, ML 의존 X
