# NUMB G5 — 포장 / 안정성 (form factor · Arrhenius shelf-life · epi pH wall)

> 🧊 **NUMB milestone G5** — DUAL SKU (G4: OTC-A lid 4% 단독 + Rx-V1 hexa-LAC v1) 의 **상업화 포장 + 24mo shelf-life** 정량.
> 3 form factor (단회용 sachet · multi-dose tube · patch) × 충전·비용·SKU 매핑 + **Arrhenius 가속수명** (성분별 degradation) + **N7 epi pH 8.5 wall 통합** (2-chamber) + 포장재 호환성.
> **sim** = `NUMB/sim/g5_stability.hexa` (Arrhenius AF·t90·shelf-life recompute · 🟢 hexa-native GREEN).
> **핵심 발견**: lid/tet amide 가수분해는 pH 5.5 에서 **shelf-limiter 아님** (Powell 1987 측정 Ea=33.8 kcal/mol → t90 ~ **17,700년** @25°C). 진짜 24mo 게이트 = **epinephrine 산화** (acidic + metabisulfite + 차광 + N2 + 2-chamber 필수).

---

## 0. honest framing (per @D d5/d6)

1. **lid/tet 가수분해 ≠ shelf-limiter**: Powell 1987 실측 Ea = 26.3-33.8 kcal/mol (3 경로) → pH 5.5 lactate buffer 에서 amide 가수분해 t90 (10% 손실) = **~17,700 년 @ 25°C**. amide 결합은 ester (예: procaine/tetracaine ester) 보다 훨씬 안정. **tetracaine 은 ester** 이지만 동일 pH 3-6 envelope 에서 commercial Pliaglis/EMLA 가 multi-year shelf 달성 → 가수분해는 pH 제어로 해결됨.
2. **EPI 산화가 진짜 병목**: epinephrine 은 catechol → adrenochrome 자동산화 (광·O2·alkaline 촉진). commercial LA+epi 의 shelf-limiter. 40°C/6mo 가속 → 25°C 외삽 = **25.7 mo** (Ea~18 kcal/mol) → **24mo 마진 +1.7mo 뿐**. antioxidant + 차광 + N2-headspace 없이는 FAIL.
3. **metabisulfite 의 역설 (deep research)**: Na-metabisulfite 는 **암실/무산소에서만** epi 를 보호. **광 존재 시 metabisulfite 가 epi 의 광분해를 오히려 촉진** (64.5% vs 89.3% remaining — Photodestabilization of epinephrine by sodium metabisulfite, PMID 10822984). → **차광이 절대조건**, metabisulfite 는 차광 전제 하에서만 추가.
4. **capric 산패 risk 는 가정보다 낮다**: capric acid = decanoic acid **C10:0 포화지방산** (C=C 이중결합 없음) → free-radical lipid peroxidation (산패) 경로가 본질적으로 약함. 산패 risk 를 과장하지 않되 (honest), **열-구동 가수분해/유리산 migration** 경로는 0 이 아님 → DSC + peroxide-value wet-lab gate 인정.
5. **가속시험 외삽 한계 명시**: 40°C/6mo → 25°C/24mo 외삽은 **단일 Arrhenius mechanism 가정** (ICH Q1A). 상전이·결정화·다중경로 전환이 있으면 외삽 무효 → real-time 25°C/24mo 확정시험이 최종 게이트. 본 G5 의 shelf-life 숫자는 **projection** 이지 measured 가 아님.

---

## 1. 3 form factor 정량 spec

| 축 | 단회용 sachet/ampoule | multi-dose tube | patch (Synera/DESCRIBE class) |
|---|---|---|---|
| **충전량** | 2.5 g / sachet | 30 g / tube | ~1 g drug-in-film / patch (10 cm²) |
| **1회 사용량** | 2.5 g (전량 = 1회) | ~2 g (thin layer 40 cm²) | 1 patch = 1회 (10 cm²) |
| **회당 수** | 1 (단회) | **15회** (30g / 2g) | 1 (단회) |
| **비용 (COGS)** | $0.85 / sachet | $1.40 / tube | $1.75 / patch |
| **$/g delivered** | $0.34 | $0.047 | $1.75 |
| **방부제** | **불필요** (단회·무균 충전 가능) | **필요** (multi-dose, 개봉 후 contamination) | 불필요 (단회·foil 밀봉) |
| **차광/O2 barrier** | foil sachet (Al-laminate) | Al-lined tube + 외부 carton | foil overwrap |
| **적합 SKU** | **Rx-V1 / Rx-V2** (procedure-direct, +epi → 2-chamber) | **OTC-A** (home-care, epi 없음 → single-chamber) | **Rx-V1** (clinic; Synera 는 heating element 추가) |
| **precedent** | EMLA single-dose patch · 의료 sachet | EMLA/LMX/Pliaglis 30g tube | Synera (lid 70mg/tet 70mg + heating) · DESCRIBE laser-assist |
| **장점** | 정확 단회 dose · 방부제 free · epi-acid + alkaline 물리분리 가능 | 가장 저렴 ($/g) · home-care 반복사용 · 친숙 | 무도포 (clinic workflow) · peel-film 일체 · 압력균일 |
| **단점** | $/g 높음 · 일회용 폐기물 | 방부제 필요 · 개봉 후 epi 산화 가속 · multi-dose epi 부적합 | $/g 최고 · heating element COGS · 면적 고정 |

### 1.1 SKU × form factor 권고 매핑

| SKU | 1차 form factor | 2차 | 비고 |
|---|---|---|---|
| **OTC-A** (lid 4%, no epi) | **multi-dose tube 30g** | 단회 sachet (travel) | epi 없음 → tube 가 stability 가장 단순 (single-chamber + 방부제) |
| **Rx-V1** (lid7+tet7+epi+peel-film) | **단회 sachet** (procedure-direct) | patch (clinic) | epi → 방부제-free 단회 + 차광 foil + (N7 결합 시) 2-chamber |
| **Rx-V2** (V1 + capric ternary) | **단회 sachet** (대면적 sleeve) | — | capric + epi → 2-chamber + foil + peroxide-value 모니터링 |

**핵심 로직**: multi-dose tube 는 epi-함유 SKU 에 부적합 (반복 개봉 → O2 유입 → epi 산화 가속). 따라서 **epi 가 있는 Rx-V1/V2 = 단회 sachet** (또는 patch), **epi 없는 OTC-A = tube**. 이는 G4 의 SKU 분리와 자연 정합.

---

## 2. Arrhenius shelf-life 정량 (성분별 degradation · 24mo 판정)

### 2.1 모델 (closed-form · per @D g5)

```
k(T)      = A · exp(-Ea/(R·T))                      1차 분해 속도상수
AF(T2/T1) = k(T2)/k(T1) = exp( (Ea/R)·(1/T1 - 1/T2) )   가속계수
t90(T)    = -ln(0.9)/k(T)                           10% 손실 시간 (1차)
shelf25   = t_accel(40°C) · AF(40/25)               가속→실온 외삽
```
R = 1.987×10⁻³ kcal/mol/K · T25 = 298.15 K · T40 = 313.15 K

### 2.2 성분별 Arrhenius 표 (hexa GREEN)

| 성분 | 경로 | Ea (kcal/mol) | 출처 | AF(40/25) | 40°C/6mo → 25°C | 24mo 판정 |
|---|---|---:|---|---:|---:|---|
| **lid amide** | 가수분해 (pH 5.5) | **33.8** (ko protonated) | Powell 1987 PMID 3508528 측정 | 15.39 | t90 = **~17,700 년** | ✅ PASS 압도 |
| **tet ester** | 가수분해 (pH 5.5) | ~26-30 (ester, lid<tet) | Powell class + ester 일반 | ~8-12 | t90 = years (pH 3-6 max stab) | ✅ PASS (pH 제어) |
| **epinephrine** | **산화** (catechol→adrenochrome) | **~18** (lit 13-21) | acidic+metabisulfite anchor | **4.29** | **25.7 mo** | ⚠ PASS-marginal (+1.7mo) |
| **capric (V2)** | 산패 (자동산화) | — (C10:0 포화, low) | saturated FA → 약함 | — | 산패 risk LOW | ✅ (heat/hydrolysis만) |
| **capric (V2)** | 열-가수분해/유리산 | ~20 (가정) | 보수 추정 | 5.05 | 30.3 mo | ✅ PASS (wet-lab gate) |

### 2.3 lid 가수분해 절대 t90 (Powell 1987 → 25°C 외삽 · hexa verbatim)

```
k(80°C) = 1.37×10⁻⁹ /s          (Powell 1987 ko protonated, 80°C 측정)
arg     = (33.8/0.001987) × (1/298.15 - 1/353.15) = 8.886
k(25°C) = 1.37e-9 × exp(-8.886) = 1.885×10⁻¹³ /s
t90(25°C) = -ln(0.9)/k = 0.10536 / 1.885e-13 = 5.59×10¹¹ s = 17,723 년
```
→ **lid/tet 가수분해는 pH 5.5 lactate buffer 에서 절대 shelf-limiter 가 아니다.** Powell 1987 의 "max stability pH 3-6" 와 정합. 제형 pH 타겟 = **5.5 (lactate buffer)** 가 가수분해를 사실상 동결.

### 2.4 epinephrine 산화 = 24mo 게이트 (정량)

- commercial LA+epi (acidic salt + Na-metabisulfite + EDTA + 차광): t90 ~ 18-24 mo @ 25°C (산업 anchor)
- 40°C/6mo 가속 → 25°C 외삽 = 6 × AF_epi(4.29) = **25.7 mo** → **24mo 마진 +1.7mo (얇음)**
- **PASS 조건 (모두 필수)**: ① pH 5.5 acidic ② Na-metabisulfite 0.1% ③ EDTA (금속 chelation; Powell 1987 metal-ion 촉매 차단) ④ N2-headspace ⑤ **차광 (foil/opaque)** ⑥ epi-acid 와 alkaline 물리분리 (N7 결합 시 2-chamber)
- **차광 역설 (deep research)**: metabisulfite 는 **광 존재 시 epi 광분해를 촉진** (64.5% vs 89.3%). → 차광이 metabisulfite 보다 우선. 차광 전제 하에서만 metabisulfite 가 O2-scavenger 로 작동.

### 2.5 capric (V2) 산패 — honest risk 인정

- capric = **decanoic acid C10:0 포화** → C=C 없음 → free-radical 산패 경로 본질적으로 약함 (불포화지방산 대비). caprylic-capric triglyceride 가 화장품에서 "oxidatively stable" 로 쓰이는 이유.
- **그러나 0 은 아님**: ① 광·열 하 미량 산화 ② ester carrier 의 열-가수분해 → 유리 capric acid migration → pH drift ③ peroxide value 상승 가능.
- → **DSC (m.p. 안정성) + peroxide-value HPLC** wet-lab gate (N6 batch 와 cost-share). V2 는 어차피 wet-lab trigger gated (G4) 이므로 G5 에서 산패는 wet-lab gate 항목으로 이월.

---

## 3. N7 epi pH 8.5 wall 통합 (2-chamber 필요성)

### 3.1 wall 정량 (N7 §2·§7 상속)

| wall | 정량 | 출처 |
|---|---|---|
| **epi @ pH 8.5 분해** | **30% loss @ 30min · 100% @ 2주** | ScienceDirect 1990 (alkalinized stability) |
| lid amide @ pH 8.5 | t½ ~ months (산성 대비 빠름) but 단시간 OK | Powell 1987 (max stab pH 3-6) |

### 3.2 통합 결론

```
                  epi 함유?
                 /         \
              YES (Rx-V1/V2)   NO (OTC-A)
                 |              |
          N7 alkaline-top?   single-chamber
            /        \        (epi 게이트 부재 → 안정성 SIMPLE)
         YES          NO
          |            |
    2-CHAMBER     단회 sachet
    MANDATORY     (epi-acid + 차광 foil + N2)
    (또는 N7-A
     2-SKU 분리)
```

1. **OTC-A (epi 없음)** → epi 산화 게이트 **부재** → single-chamber tube 로 충분. 안정성 가장 단순. lid 4% pH 5.5 만 관리하면 24mo 압도적 PASS.
2. **Rx-V1/V2 (epi 함유, N7 결합 없음)** → epi 산화만 관리 → 단회 sachet (acidic + metabisulfite + EDTA + N2 + 차광 foil). epi-acid 와 alkaline 이 같은 chamber 에 없으므로 1-chamber 가능.
3. **Rx-V1/V2 + N7 alkaline-top (bilayer)** → epi-acid layer (pH 5.5) 와 alkaline top (pH 8.5) 이 접촉하면 epi 30% loss @30min → **2-chamber 물리분리 MANDATORY**. N7 §4 의 후보 A (2-step apply, 2 SKU) 가 packaging 관점에서 가장 단순 — 별도 sachet 2개 = 자연스러운 chamber 분리.
4. **2-chamber packaging 옵션**: ① dual-compartment sachet (격벽 + break-seal) ② 2-step 별도 sachet (N7-A) ③ microcapsule (N7-C, GMP novelty). G5 권고 = **N7-A 2-SKU 단회 sachet 쌍** (regulatory + packaging 모두 최단).

---

## 4. 포장재 호환성 매트릭스

| 포장재 | lid free-base 흡착 | epi O2/광 barrier | HPC 수분 barrier | 적합 SKU/form |
|---|---|---|---|---|
| **bare LDPE tube** | **HIGH (✗)** — lid free-base = 피부온 oil → polyolefin 흡수 → 역가 손실 + tube 연화 | 낮음 | 낮음 | ✗ 부적합 |
| **epoxy-phenolic-lined Al tube** | **negligible (✓)** — lined barrier | 좋음 (opaque Al) | 좋음 | **OTC-A tube** |
| **foil sachet (Al-laminate)** | negligible (✓) | **최상 (✓)** — 광+O2+수분 3중 barrier | **최상 (✓)** | **Rx-V1/V2 sachet · patch overwrap** |
| **PET/clear** | medium | ✗ (광 투과) | medium | ✗ epi-함유 부적합 |

### 4.1 핵심 호환성 규칙

1. **lid free-base 흡착 → bare LDPE 금지**. 피부온에서 oil 인 lid free-base 는 LDPE/PP 에 흡수되어 역가 손실 + 용기 연화. → **epoxy-phenolic-lined aluminum tube** (또는 Al-laminate sachet) 필수.
2. **epi 함유 → foil (Al-laminate) sachet** — 광·O2·수분 3중 barrier. 차광이 metabisulfite 역설 때문에 절대조건 (§2.4).
3. **HPC peel-film 수분 민감** (deep research: HPC 필름은 수화 시 불투명화·물성변화; 40°C/75%RH 가속에서 hydrolysis 가속) → patch/film SKU 는 **foil overwrap** + desiccant 고려.
4. **single-dose 무방부제** ↔ multi-dose 방부제: sachet/patch = 단회 무균 = 방부제 free 가능. tube = 반복 개봉 = 방부제 (예: phenoxyethanol/parabens) 필요.

---

## 5. hexa-native recompute (verbatim · 🟢 · per @D g5)

`run`: `hexa run NUMB/sim/g5_stability.hexa`

```
=== NUMB G5 — packaging / stability (Arrhenius shelf-life + form factors) ===

[1] Arrhenius acceleration factors AF(40C/25C)
  (1/T25 - 1/T40) [1/K] = 0.000160659
  epi   (Ea=18.0 kcal/mol) arg = 1.45539
  epi   AF(40/25) = 4.289
  lid   (Ea=33.8 kcal/mol, Powell 1987) arg = 2.73289
  lid   AF(40/25) = 15.39
  capric(Ea=20.0 kcal/mol) AF(40/25) = 5.049

[3] lid amide hydrolysis absolute t90 (Powell 1987 -> 25C extrapolation)
  arg (Ea/R * (1/T25-1/T80)) = 8.88562
  k(25C) [1/s] = 1.88512e-13
  t90 (10% loss) [yr] = 17722.8
  >> lid/tet hydrolysis t90 >> 24mo at pH 5.5 -> NOT shelf-limiting (pH 3-6 max stability, Powell 1987)

[4] epinephrine oxidation (THE shelf-limiter; 40C/6mo accel -> 25C)
  extrapolated 25C shelf-life [mo] = 25.734
  margin over 24mo [mo] = 1.734
  >> PASS 24mo ONLY with: acidic pH 5.5 + Na-metabisulfite 0.1% + EDTA + N2-headspace + LIGHT-PROTECT + 2-chamber
  >> CAVEAT: metabisulfite can PHOTO-destabilize epi under light (64.5% vs 89.3%)

[5] capric acid (V2-only) — saturated FA, low autoxidation
  extrapolated 25C shelf-life [mo] (Ea=20) = 30.294
  margin over 24mo [mo] = 6.294

[6] form-factor fill / dose / cost / SKU
  ampoule/sachet : fill=2.5 g · cost=$0.85 · $/g=0.34
  multi-dose tube: fill=30 g · uses=15 · $/g=0.0467
  patch          : fill=1 g · cost=$1.75 · $/g=1.75

[7] N7 epi pH-8.5 wall integration
  epi loss @ pH 8.5, 30 min = 0.3 · @ 2 weeks = 1.0
  2-chamber needed Rx-V1+N7 = 1.0 · OTC-A = 0.0

[8] packaging-material compatibility
  lid free-base sorption LDPE=1.0 · lined-Al=0.0 · HPC moisture=1.0

[9] 24mo verdict
  OTC-A tube (no epi)          : PASS easily (lid t90 ~1.7e4 yr)
  Rx-V1 sachet (epi, foil)     : PASS (epi 25.7mo) w/ antioxidant+N2+dark
  Rx-V1 patch (epi+HPC, foil)  : PASS-conditional (HPC + epi gated)
  Rx-V2 sachet (epi+capric)    : PASS (capric 30.3mo) WET-LAB gate
  Rx-V1/V2 + N7 alkaline       : 2-chamber MANDATORY

=== G5 PASS — lid/tet hydrolysis NOT limiting; EPI OXIDATION = 24mo gate ===
```

전 출력값이 closed-form python 계산과 일치 (lid t90 = 17,723 yr · epi AF = 4.289 · shelf 25.7mo).

---

## 6. competitor shelf-life anchor (실제 라벨 · deep research)

| 제품 | shelf-life | 보관 | epi? | 적용 |
|---|---|---|---|---|
| **EMLA cream 5%** (lid2.5+pri2.5) | **3년** (SmPC §6.3) | **<30°C, freeze 금지** | ✗ | epi 없는 eutectic → 3년 = NUMB OTC-A 의 24mo target 충분 달성 가능 anchor |
| **LMX-4** (lid 4% liposomal) | **2년** · 개봉 후 30-60일 | 25°C (15-30°C 허용) | ✗ | NUMB OTC-A 직접 class 선례 (lid 단독 2년) |
| **Pliaglis** (lid7+tet7 eutectic) | RT **3개월** (개봉 후 폐기) | RT | ✗ | 짧음 — eutectic oil 의 보관 challenge; NUMB Rx-V1 은 단회 sachet 로 이 문제 회피 |

→ **핵심 비교**: Pliaglis (multi-use jar, eutectic) 가 RT 3개월로 짧은 이유 = 개봉 후 eutectic oil 노출. **NUMB Rx-V1 의 단회 sachet 전략이 이 약점을 직접 해결** (개봉 = 즉시 사용). EMLA (3년) · LMX-4 (2년) 가 epi-free 라 long-shelf 달성 → NUMB OTC-A (epi-free tube) 가 24mo+ 달성 가능 증명.

---

## 7. deep research 발견 (arxiv 1 + web 3 · per @D d18)

### 7.1 arXiv — Arrhenius degradation modeling

| paper | id | 핵심 발견 | G5 적용 |
|---|---|---|---|
| **Escobar & Meeker 2006** | **0708.0369** (Statistical Science 21(4)) "A Review of Accelerated Test Models" | 가속수명시험 (AT) 표준 review — **Arrhenius (k=A·exp(-Ea/RT)) + Eyring 온도-습도 가속** relationship, 1차 degradation path model, 외삽의 physically-motivated 모델 필요성 | G5 Arrhenius shelf-life 외삽의 정통 방법론 grounding; "단일 mechanism 가정 시에만 외삽 유효" 한계 = 본 review 의 핵심 경고 |
| **Chemical Reaction Neural Networks 2024** | **2408.11984** | 화학분해 kinetics 를 **multiple Arrhenius ODE** 로 표현 (각 반응 = Arrhenius rate × enthalpy) → 가속 열량 데이터 fitting | NUMB 다성분 (lid·tet·epi·capric) 병렬 분해 = multi-Arrhenius ODE 구조; 각 성분 독립 Ea → G5 의 성분별 분리 분석 정당화 |

### 7.2 web — shelf-life 라벨 · epi 안정화 · HPC 수분

| source | URL | 핵심 발견 | G5 적용 |
|---|---|---|---|
| **EMLA SmPC §6.3/6.4** | medicines.org.uk/emc/product/7994/smpc | shelf-life **3년** · <30°C · freeze 금지 (lid2.5+pri2.5, epi-free) | OTC-A (epi-free) 24mo+ 달성 가능 직접 anchor |
| **Pliaglis PI** | accessdata.fda.gov/...021717s005lbl.pdf · drugs.com/pro/pliaglis | RT **3개월** (개봉 후 폐기) · eutectic oil emulsion | Rx-V1 단회 sachet 가 Pliaglis 의 short-shelf 약점 해결 |
| **LMX-4 (Ferndale)** | dailymed · ferndalehealthcare.com | **2년** · 25°C · 개봉 후 30-60일 · liposomal | OTC-A lid-단독 class 선례 |
| **Powell 1987 Pharm Res** | PMID 3508528 · link.springer.com/article/10.1023/A:1016477810629 | lid amide 가수분해 **Ea = 26.3/30.5/33.8 kcal/mol** (3 경로) · k(80°C) 측정 · **max stability pH 3-6** · 금속이온 촉매 | **§2.3 lid t90 외삽의 measured anchor** — pH 5.5 게이트 정당화 |
| **Photodestabilization of epi by Na-metabisulfite** | PMID 10822984 · researchgate 12495062 | metabisulfite 가 **광 존재 시 epi 광분해 촉진** (64.5% vs 89.3% remaining) | **차광 절대조건** + metabisulfite 역설 honest framing (§2.4) |
| **Stabilization of epi w/ reduced metabisulfite + EDTA** | tandfonline 10.3109/03639049209040858 | LA injectable 에서 metabisulfite 저감 + EDTA → epi 안정화 | EDTA (금속 chelation) 첨가 정당화 (Powell metal-ion 촉매와 연결) |
| **EpiPen 조성** | (web) | epi free-base 1mg + NaCl + metabisulfite 1.7mg + HCl pH **2.2-5.0** | epi 안정 = acidic pH 필수 anchor (NUMB pH 5.5 정합 — acidic 범위 상한) |
| **capric/caprylic-capric oxidative stability** | chemicalbook · wikipedia decanoic acid | C10:0 **포화 FA** → 산패 본질적 약함 ("oxidatively stable, prevents rancidity") | capric 산패 risk LOW honest 정정 (§2.5) |
| **HPC film moisture sensitivity** | sciencedirect HPC topics · PMC6520314 (HPC/ASA 40°C/75%RH 5wk) | HPC 수화 시 불투명화·물성변화; HPC/ASA 가속 가수분해 연구 | HPC peel-film = foil overwrap + 수분 barrier 정당화 (§4) |

### 7.3 prior art / 안정성 정량 종합
- **epi 안정성 = acidic pH + 차광 + antioxidant(metabisulfite, 차광 전제) + EDTA + N2** = 산업 표준 (EpiPen·LA+epi 선례). NUMB 가 새 화학 없이 표준 적용.
- **lid/tet 가수분해 = pH 제어 (3-6) 로 해결** (Powell 1987 measured) — NUMB pH 5.5 lactate 가 정답.
- **eutectic oil 의 보관 challenge (Pliaglis RT 3mo)** → NUMB 의 단회 sachet 전략이 구조적 회피.

---

## 8. tier ledger + verdict

| claim | tier |
|---|---|
| lid amide 가수분해 Ea = 33.8 kcal/mol · k(80°C)=1.37e-9/s | 🟡 cite (Powell 1987 PMID 3508528 measured) |
| lid t90 @ 25°C pH 5.5 ~ 17,700 년 (NOT shelf-limiting) | 🟢 numerical (Powell Ea Arrhenius 외삽, hexa GREEN) |
| epi 산화 shelf-life 25.7mo (40°C/6mo → 25°C, Ea~18) | 🟡 cite + 🟢 (외삽 closed-form; Ea 는 lit 범위) |
| epi @ pH 8.5 분해 30% @30min · 100% @2wk | 🟡 cite (ScienceDirect 1990) |
| metabisulfite 광 존재 시 epi 광분해 촉진 (64.5% vs 89.3%) | 🟡 cite (PMID 10822984) |
| capric C10:0 포화 → 산패 risk LOW | 🟡 cite (decanoic acid 포화 FA) |
| Arrhenius AF(40/25): epi 4.29 · lid 15.39 · capric 5.05 | 🟢 numerical (hexa GREEN, closed-form) |
| EMLA 3년 · LMX-4 2년 · Pliaglis RT 3mo shelf-life | 🟡 cite (SmPC · DailyMed · FDA label) |
| 2-chamber 필요성 (epi vs alkaline) | 🔵 closed-form (epi pH 8.5 분해 anchor + 물리분리 논리) |
| form factor 충전/비용 ($0.85 sachet · $1.40 tube · $1.75 patch) | 🟠 추정 (산업 COGS anchor; 실제 BOM 미확정) |
| lid free-base LDPE 흡착 / HPC 수분 민감 | 🟡 cite (polyolefin sorption + HPC film 수분 문헌) |
| 가속시험 외삽 24mo PASS | 🟠 projection (단일 Arrhenius 가정; real-time 25°C 확정시험 미수행) |
| Escobar-Meeker 2006 / CRNN 2024 arxiv grounding | 🟡 cite (가속수명 방법론) |

### G5 verdict (per @D d5)

> **G5 PASS (포장/안정성 spec 완성)**. 3 form factor 정량 (sachet 2.5g/$0.85 · tube 30g/$1.40·15uses · patch 1g/$1.75) × SKU 매핑 (**OTC-A=tube** epi-free single-chamber · **Rx-V1/V2=단회 sachet** epi 2-chamber-capable · **Rx-V1 patch** Synera-class) 완료. Arrhenius 가속수명 (hexa GREEN): **lid/tet 가수분해는 shelf-limiter 아님** (Powell 1987 measured Ea=33.8 → t90 ~17,700년 @pH5.5) — pH 5.5 lactate buffer 가 정답. **epinephrine 산화가 진짜 24mo 게이트** (40°C/6mo→25°C = 25.7mo, 마진 +1.7mo 뿐) → acidic + Na-metabisulfite + EDTA + N2 + **차광(절대)** + epi/alkaline 2-chamber 필수. **차광 역설** (metabisulfite 가 광 하 epi 광분해 촉진) = 핵심 honest framing. **capric 산패 risk 는 가정보다 낮음** (C10:0 포화) but heat-hydrolysis/peroxide-value wet-lab gate 인정. N7 epi pH 8.5 wall → epi+alkaline bilayer 는 **2-chamber MANDATORY** (또는 N7-A 2-SKU); OTC-A (no epi) 는 안정성 단순. 포장재: **Al-lined tube** (lid free-base 흡착 차단) · **foil sachet** (HPC 수분 + epi 광/O2 3중 barrier). competitor anchor: EMLA 3년/LMX-4 2년 (epi-free) = OTC-A 24mo+ 달성 가능 증명; Pliaglis RT 3mo (eutectic jar) = Rx-V1 단회 sachet 가 구조적 해결. **외삽 한계 honest 명시** (단일 Arrhenius 가정; real-time 25°C/24mo 확정시험이 최종 게이트). absorbed=false 유지 (G6 인접토픽 · NUMB measured-oracle · V-track verify 미완).

---

## 9. Sources

### arxiv (per @D d18)
- Escobar & Meeker 2006 — "A Review of Accelerated Test Models", Statistical Science 21(4) — [arxiv.org/abs/0708.0369](https://arxiv.org/abs/0708.0369)
- Chemical Reaction Neural Networks for Fitting Accelerated Rate Calorimetry Data (2024) — [arxiv.org/abs/2408.11984](https://arxiv.org/abs/2408.11984)

### 안정성 (measured anchors)
- Powell 1987 — Stability of lidocaine in aqueous solution: effect of temperature, pH, buffer, and metal ions on amide hydrolysis — *Pharm Res* PMID 3508528 — [link.springer.com/article/10.1023/A:1016477810629](https://link.springer.com/article/10.1023/A:1016477810629) · [pubmed.ncbi.nlm.nih.gov/3508528](https://pubmed.ncbi.nlm.nih.gov/3508528/)
- Photodestabilization of epinephrine by sodium metabisulfite — PMID 10822984 — [pubmed.ncbi.nlm.nih.gov/10822984](https://pubmed.ncbi.nlm.nih.gov/10822984/)
- Stabilization of epinephrine in a local anesthetic injectable solution using reduced sodium metabisulfite and EDTA — *Drug Dev Ind Pharm* 18(14) — [tandfonline.com/doi/abs/10.3109/03639049209040858](https://www.tandfonline.com/doi/abs/10.3109/03639049209040858)
- Stability of epinephrine in alkalinized solutions — *ScienceDirect* 1990 (S0196064405822814) — N7 §8.2 상속 (epi pH 8.5 30% @30min)

### competitor shelf-life 라벨
- EMLA Cream 5% SmPC §6.3/6.4 (shelf 3년 · <30°C) — [medicines.org.uk/emc/product/7994/smpc](https://www.medicines.org.uk/emc/product/7994/smpc)
- EMLA FDA label — [accessdata.fda.gov/drugsatfda_docs/label/2018/019941s021lbl.pdf](https://www.accessdata.fda.gov/drugsatfda_docs/label/2018/019941s021lbl.pdf)
- Pliaglis PI (RT 3mo) — [accessdata.fda.gov/drugsatfda_docs/label/2013/021717s005lbl.pdf](https://www.accessdata.fda.gov/drugsatfda_docs/label/2013/021717s005lbl.pdf) · [drugs.com/pro/pliaglis](https://www.drugs.com/pro/pliaglis.html)
- LMX-4/5 (Ferndale, 2년) — [ferndalehealthcare.com/lmx5](https://ferndalehealthcare.com/lmx5/) · DailyMed setid 34f8ed6b
- Synera (lid/tet patch + heating element) — DESCRIBE/Synera class precedent

### 부형제 / 포장재
- Capric acid (decanoic acid C10:0 saturated) — [en.wikipedia.org/wiki/Capric_acid](https://en.wikipedia.org/wiki/Capric_acid) · caprylic-capric triglyceride oxidative stability (ChemicalBook)
- Hydroxypropyl Cellulose moisture sensitivity — [sciencedirect.com/topics/medicine-and-dentistry/hydroxypropyl-cellulose](https://www.sciencedirect.com/topics/medicine-and-dentistry/hydroxypropyl-cellulose) · HPC/ASA 40°C/75%RH stability — [pmc.ncbi.nlm.nih.gov/articles/PMC6520314](https://pmc.ncbi.nlm.nih.gov/articles/PMC6520314/)

### inherited
- G4 (`NUMB/research/G4_sku_split.md`) — DUAL SKU (OTC-A + Rx-V1) · Rx-V2 wet-lab trigger
- N7 (`NUMB/research/N7_pH_gradient.md`) — epi pH 8.5 wall · 2-step/laminated/microcap bilayer
- N6 (`NUMB/research/N6_ion_pair_eutectic.md`) — capric ternary (V2 deferred)
- N1 (`NUMB/research/N1_phase_change_peelfilm.md`) — HPC peel-film
- (재현) `NUMB/sim/g5_stability.hexa` — `hexa run NUMB/sim/g5_stability.hexa`
