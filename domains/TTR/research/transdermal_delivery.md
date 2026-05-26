# TTR §4 — 진피 전달(Transdermal Penetration) 메커니즘 설계

@scope: TTR.md milestone 4 of 10 — liposome · nano-emulsion · iontophoresis · microneedle first-principles 비교
@status: design-only, no wet-lab, no formulation lock (milestone 7 deferred)
@convention: 활성 분자는 "molecule X" 로 추상 표기 (milestone 3 산출물 의존)

---

## 4.1 문제 정의 — 잉크가 어디 있고, 분자가 어디까지 가야 하나

타투 잉크 입자(black carbon · color 유기 안료 · 금속 산화물)는 **진피(dermis) 상부 ~0.5–2 mm 깊이**에 macrophage / fibroblast 사이 ECM 에 봉입되어 영구 거주. 면역 청소가 안 되는 이유는 입자가 너무 커서(0.1–10 μm) 진피 림프드레이니지로 빠지지 못함.

→ **molecule X 가 진피 0.5–2 mm 까지 도달해서 잉크 입자 표면과 화학적으로 접촉**해야 milestone 5 의 분해 반응이 시작됨. 그 전에 SC(stratum corneum) lipid matrix 통과가 first wall.

```
[피부 단면 — 깊이 축 (μm, log-ish)]

  0 ┌─────────────────────────────────┐
    │ stratum corneum  ~10–20 μm      │  ← lipid matrix wall (corneocyte brick + lipid mortar)
 20 ├─────────────────────────────────┤     · MW <500 Da · logP 1-3 · 친유성 small molecule만 수동 통과
    │ viable epidermis ~50–100 μm     │
    │  · stratum granulosum / spinosum│  ← tight-junction (claudin) 2nd wall
    │  · stratum basale (멜라닌세포)  │  ← 멜라닌 OFF-target 위험구간 (milestone 6)
100 ├─────────────────────────────────┤
    │                                 │
    │ DERMIS  ~500–2000 μm            │  ░░░░ ← ink particles 0.5–2 mm 깊이에 거주
    │  · 콜라겐/엘라스틴 ECM          │  ░██░     (macrophage 안에 영구 봉입)
    │  · 혈관 · 림프 · 신경           │  ░░░░ ← molecule X 가 여기 도달해야 함
    │  · 모낭 · 한선 (shunt 경로)     │
2000└─────────────────────────────────┘
    │ 피하지방 / hypodermis           │  ← over-shoot 면 전신흡수 (toxicity 위험)
    └─────────────────────────────────┘
```

→ **목표 deposition window: 100–2000 μm**. SC 만 뚫고 epidermis 에 머무르면 ink 미접촉(under-shoot). 피하지방까지 가면 전신순환 흡수 → off-target (over-shoot).

---

## 4.2 First-principles 운반 물리 — 4가지 메커니즘의 driving force

| 메커니즘 | Driving force | 지배 방정식 | 1차 제약 |
|---|---|---|---|
| Liposome / LNP | 농도구배 + 지질융합 | Fick: J = −D·∂C/∂x · partition K_lipid | particle size · K_lipid/water |
| Nano-emulsion | 농도구배 + SC lipid 가용화 | Fick + SC permeabilizer 효과 (∂D/∂t↑) | surfactant 농도 · 입자 안정성 |
| Iontophoresis | 전기영동 (Nernst-Planck) | J = −D·∇C − (z·F·D·C/RT)·∇φ + C·v_solvent | molecule X 가 ionizable · z≠0 · MW ≲ 7 kDa |
| Microneedle | 기계적 SC 우회 (puncture) | 채널 = 직접 통로 (Fick 무관, geometric) | needle 길이 = 도달 깊이 직접 제어 |

### 4.2.1 Fick 1법칙 (수동 확산 baseline)

```
J  =  -D · (∂C/∂x)
flux       diffusivity     농도구배
```

SC 의 D 는 stratum corneum lipid matrix 통과 시 **D_SC ≈ 10⁻¹⁰ – 10⁻¹² cm²/s** (자유수의 D≈10⁻⁵ cm²/s 보다 3–7 orders 낮음). MW 500 Da 가 일반적 cutoff (`500 Da rule` — Bos & Meinardi 2000). MW > 500 Da, logP < 1, 또는 polar charged molecule 은 **수동 확산 영구 차단**.

→ molecule X 가 MW > 500 Da 또는 hydrophilic / charged 이면 **수동 확산만으로는 SC 통과 불가** → active delivery 필요.

### 4.2.2 Nernst-Planck (iontophoresis)

```
J_ion  =  -D·∇C  +  (zFD/RT)·C·E
            확산항        전기영동항 (E = 전류밀도/전도도)
```

FDA 권장 한도 **i ≤ 0.5 mA/cm²** (≥30 min) — 그 이상은 표피 화상 + 갈바닉 자극. 0.5 mA/cm² 의 typical depth gain: SC 우회 후 epidermis–상부 dermis (200–500 μm) — **진피 깊은 곳까지는 못 감**.

### 4.2.3 Microneedle geometry

```
  needle length L  ─────►   직접 통로 깊이
  
  L = 500 μm  →  SC + viable epidermis 까지
  L = 1000 μm →  상부 dermis (ink layer 도달)
  L = 1500 μm →  중부 dermis (ink layer 중앙)
  L > 2000 μm →  과침투, 혈관/신경 자극 risk
```

→ microneedle 만이 **`L` 을 직접 dialing 해서 ink 거주 깊이(500–2000 μm)에 정확히 deposition window 형성** 가능. Fick / Nernst-Planck 무관, 단순 기하.

---

## 4.3 메커니즘 별 상세

### 4.3.1 Liposome / Lipid Nanoparticle (LNP)

| 항목 | 값 / 설명 |
|---|---|
| 구조 | 인지질 이중층(phosphatidylcholine + cholesterol ± PEG) 베지클 |
| 크기 | 50–500 nm (small unilamellar 50–100 nm · large 200–500 nm) |
| Payload | hydrophilic → aqueous core · hydrophobic → bilayer 내부 · amphiphilic 둘 다 |
| Payload MW 한계 | 사실상 무제한 (bilayer 내부 또는 core 봉입) |
| SC 통과 기전 | (a) lipid fusion (b) hair follicle shunt (c) intercellular lipid 가용화 |
| 일반적 도달 깊이 | **SC + viable epidermis (50–150 μm)** — dermis 까지 도달은 한계, 모낭 shunt 로 보조 |
| Dermis 도달율 | 낮음 (보통 < 5% 적용량) |
| 제조 정밀도 | extrusion / microfluidic — size CV ≤ 10% 산업 표준 |
| FDA precedent | mRNA 백신 (Comirnaty · Spikevax) · Doxil (1995 antitumor) · Epaxal |
| 비용 | 중 (lipid raw $20–200/g · GMP scale-up 성숙) |

→ **혼자서는 dermis 미도달**. 보조 (microneedle 채널 통한 deposition · iontophoresis 와 hybrid) 로 가치.

### 4.3.2 Nano-emulsion (NE)

| 항목 | 값 / 설명 |
|---|---|
| 구조 | O/W 또는 W/O 액적 + surfactant + cosurfactant |
| 크기 | 20–200 nm (수동 자가조립 시 100–200 nm · high-pressure homogenize 시 < 50 nm) |
| Payload | 주로 hydrophobic (오일상에 용해) · hydrophilic 은 W/O |
| SC 통과 기전 | surfactant 가 SC ceramide / cholesterol 일부 가용화 → D_SC ↑ (permeation enhancer 효과) |
| 도달 깊이 | **SC + epidermis + 상부 dermis (~200–500 μm)** — surfactant 강도 의존 |
| Dermis 깊은 곳 도달율 | 중하 (5–15%) |
| 제조 정밀도 | high-pressure homogenization · 자가-emulsify (저비용) |
| FDA precedent | 화장품 ubiquitous · 의약품 less (예: Restasis cyclosporine 안약) |
| 비용 | 저 (homogenize 1 pass · surfactant 저가) |
| 안전성 우려 | **surfactant 가 SC barrier 손상 → sensitization · 자극성 risk** (보통 10–30% 자극 보고) |

→ 자극성 trade-off. 잉크-mineral oil 봉입 잉크 (color pigment) 와 amine partition matching 측면에서 유리하나, 진피 ink 까지 가는 데는 부족.

### 4.3.3 Iontophoresis

| 항목 | 값 / 설명 |
|---|---|
| 원리 | 약한 DC (0.1–0.5 mA/cm²) 로 ionized molecule 을 전기영동 |
| Molecule 요건 | (a) ionizable / charged · (b) MW ≤ ~7 kDa · (c) 수용성 |
| 도달 깊이 | **SC 우회 후 상부 dermis (200–500 μm) 까지** — 깊이는 전류·시간 의존 |
| 한도 | FDA i ≤ 0.5 mA/cm² · ≤ 30 min · 반복 시 피부 자극 |
| Payload 종류 | hydrophilic charged small molecule (예: lidocaine·HCl · fentanyl·citrate · iron oxide nanoparticle) |
| FDA precedent | LidoSite (lidocaine iontophoresis 2004 · 단종) · IontoPatch · Ionsys (fentanyl 2006 · 단종) |
| 비용 | 중 (배터리 패치 일회용 $5–20/dose) |
| 안전성 우려 | 갈바닉 화상 · pH shift · pacemaker 환자 금기 |

→ molecule X 가 **반드시 ionizable + MW < 7 kDa** 일 때만 의미. 깊은 dermis 도달은 한계 (500 μm 부근). 단독으로는 깊은 ink 까지 부족.

### 4.3.4 Microneedle (MN) array

| 타입 | 재질 | Payload 전달 방식 | 비고 |
|---|---|---|---|
| **Solid** (coated) | stainless / silicon | needle 표면 코팅 → 삽입 → 코팅 용해 | dosage 낮음, batch coating 어려움 |
| **Hollow** | silicon / glass / metal | needle 내부 채널 + 시린지 펌프 | dose precision 高, 단가↑ |
| **Dissolving** | polymer (PVA · HA · CMC · maltose) | 삽입 후 needle 자체 용해 → payload release | **MoA 최적** — pain↓ · biohazard 폐기물 없음 |
| **Hydrogel-forming** | crosslinked polymer | 삽입 → swell → reservoir 패치에서 약물 wick | sustained release |

| 항목 | 값 / 설명 |
|---|---|
| Needle 길이 | 100 μm – 2000 μm (재단 가능) |
| 도달 깊이 | **L 그대로 — 1000 μm needle = 1000 μm 깊이 (직접 기하)** |
| Payload MW | 무제한 (mAb · siRNA · vaccine · DNA · nanoparticle 모두 가능) |
| Payload 종류 | hydrophilic / hydrophobic / charged 무관 |
| Pain | 거의 없음 (자유신경말단은 진피 중부, microneedle 짧으면 회피) |
| 도포자 | 자가도포 가능 (vaccine patch precedent) |
| FDA precedent | Soluvia (sanofi influenza microneedle 2010) · Zosano Qtrypta (zolmitriptan MN 2021 CRL → 2024 재신청) · 다수 cosmetic 승인 |
| 비용 | 중상 (dissolving polymer MN array 패치 $5–50/dose, 양산 시 < $5) |
| 안전성 우려 | 감염 (멸균 array · 일회용) · needle 파편 잔류 (dissolving 은 무관) |

→ **모든 axis 에서 dermis ink target 에 가장 직접적**. L 을 ink 깊이에 맞춰 dialing → ink 입자 표면에 molecule X 를 직접 deposition.

---

## 4.4 비교 매트릭스 (decision table)

| 축 | Liposome | Nano-emulsion | Iontophoresis | Microneedle |
|---|---|---|---|---|
| Max 도달 깊이 (μm) | 50–150 | 200–500 | 200–500 | **100–2000 (L 제어)** |
| Payload MW 한계 | 무제한 | 무제한 | ≤ ~7 kDa | **무제한** |
| Payload 종류 (수용/소수/이온) | 모두 | 주로 소수성 | **반드시 이온성** | **모두** |
| Dermis ink 입자 접촉률 | 낮음 (< 5%) | 중하 (5–15%) | 중 (10–30% 상부) | **높음 (≥ 50% w/ L≈1000 μm)** |
| Pain | 무 | 무 | 약 (tingling) | 약 (≤ 1500 μm 무통) |
| Cost / dose (양산가정) | $1–5 | < $1 | $5–20 (배터리) | $1–5 (dissolving) |
| FDA precedent strength | **강** (mRNA vaccine, Doxil) | 중 (cosmetic dominant) | 약 (대부분 단종) | 중-강 (vaccine MN, Soluvia, Zosano 진행) |
| 자가-도포 가능 | ○ (크림) | ○ (크림) | △ (패치 + 배터리) | ○ (패치) |
| 분자 종류 비의존성 | ◐ | ◐ | ✗ (이온성 강제) | ◯ |

### 4.4.1 진피 ink 접촉 효율 ASCII vs-diagram

```
                                                              잉크 거주 깊이 (500–2000 μm)
                                                                       ▼
  0 ────────────────────────────────────────────────────────────────────────
  SC ▓▓ liposome ●●●● (멈춤, 모낭 shunt 약간)
 20 ────────────────────────────────────────────────────────────────────────
  vEp ▓▓ NE ●●●●●●● (surfactant SC 가용화로 좀 더 깊이)
100 ────────────────────────────────────────────────────────────────────────
  vEp ▓▓ Iono ●●●●●●●●●●● (Nernst-Planck, 단 ionizable 한정)
200 ────────────────────────────────────────────────────────────────────────
      ┃          
      ┃   MN needle L=1000 μm ──────────────────────────────────────────►
      ┃   payload reservoir/dissolving polymer 가 needle tip 에서 release
      ┃                                                          ★ INK ★
1000────────────────────────────────────────────────────────────────────────
      ┃   MN L=1500 μm ──────────────────────────────────────────────────►
      ┃                                                          ★ INK ★
1500────────────────────────────────────────────────────────────────────────
2000────────────────────────────────────────────────────────────────────────
  hypodermis (over-shoot, 전신흡수 risk)
```

→ Microneedle (L≈1000–1500 μm dissolving polymer) 만이 잉크 깊이에 직접 deposition window 형성.

---

## 4.5 추천 — first-principles 결론

### 추천 #1: **Dissolving microneedle (L ≈ 1000–1500 μm)**

근거 (first-principles):
1. **기하 직접성**: needle 길이 = 도달 깊이. Fick / Nernst-Planck 의 분자 의존 제약을 우회. molecule X 가 milestone 3 에서 무엇으로 결정되든 (MW, charge, logP 무관) 모두 통과.
2. **dermis ink 입자 표면에 직접 deposition**: needle tip 에서 polymer 가 용해되면서 molecule X 가 ink 근방 100 μm 이내에 점농도 spike → Fick 의 ∂C/∂x 가 ink 표면에 의해 결정 (확산거리 100 μm scale 만 필요, 분 단위).
3. **payload-agnostic**: liposome / 효소 / chelator / ROS generator (milestone 3 후보 4 family 모두) 다 실음. milestone 3 결정 전에 lock-in 가능 — **분자 선택과 decoupled**.
4. **FDA precedent**: Soluvia influenza MN, Zosano zolmitriptan MN, 다수 cosmetic MN — 안전성 baseline 확보.
5. **scar-free goal 부합**: needle 직경 ~50 μm, 채널은 24–48h 내 SC 재봉합, scar 보고 없음.

### 추천 #2 (보조): **Liposome / LNP encapsulation + MN co-delivery**

근거:
1. molecule X 가 **불안정 / 친수성 / 효소성** 이면 raw deposition 보다 LNP 봉입이 ink 접촉 전 분해/희석 방지.
2. needle 안 dissolving polymer matrix 에 LNP 분산 → MN 으로 진피 deposition → LNP 가 ink 표면에서 lipid fusion 후 payload release.
3. mRNA vaccine 의 LNP + MN combo (Pfizer · Vaxxas 등) 이 first-in-kind 가 아닌 precedented route.

### Iontophoresis · Nano-emulsion 단독 — 권장하지 않음

- **Iontophoresis**: molecule X 가 ionizable 한정 → milestone 3 자유도 제약. 깊이 500 μm 한계로 ink 도달률 낮음. FDA-승인 제품 대부분 단종 (Ionsys, LidoSite).
- **Nano-emulsion**: surfactant 가 SC barrier 손상 → 반복 도포 시 sensitization. 깊이 한계 500 μm 로 깊은 ink 도달 못함. "30 일 1회 용법" (TTR.md @goal) 측면에서 부적합.

---

## 4.6 솔직한 미지수 & 범위 caveat

### 4.6.1 first-in-kind vs precedented combo

| 조합 | 선례 | TTR 사용 |
|---|---|---|
| MN dissolving + small molecule | ○ (zolmitriptan, lidocaine MN) | 직접 적용 |
| MN dissolving + LNP | ◐ (mRNA MN vaccine — Vaxxas, 임상 단계) | 정확히 동일 architecture |
| MN dissolving + 효소 (예: protease) | ✗ first-in-kind | enzyme 활성 유지 검증 필요 (lyophilize-in-polymer stability) |
| MN dissolving + ROS generator | ✗ first-in-kind | polymer matrix 와 ROS 안정성 충돌 위험 |
| MN dissolving + chelator (small MW) | ◐ (cosmetic MN 일부) | 친수성 chelator 호환성 OK |

→ molecule X 가 효소 / ROS generator 면 milestone 7 formulation 에서 **polymer matrix 호환성 검증**이 별도 risk. milestone 3 후보 선택 시 이 호환성을 고려해야 함.

### 4.6.2 일반 미지수

- **30 일 1회 용법** (TTR.md @goal) 과 needle 1회 적용의 약물동력학 (sustained release vs single-shot) 가 milestone 5 의 잉크 분해 반응 시간상수와 정합해야 — milestone 5 가 분해를 minutes 안에 끝낸다면 single-shot OK, hours-days 걸리면 sustained release 필요.
- **needle 분포 밀도** (per cm²) × **잉크 분포 밀도** 가 ink 입자 접촉률을 좌우. 일반적 MN array 는 100–500 needles/cm². 잉크는 dermis 에 ~10⁶ particles/cm³ → needle channel 당 ~1000 particles cover. 평균 needle-ink 거리는 ~30 μm scale → molecule X 가 30 μm 확산 (D ≈ 10⁻⁶ cm²/s 자유 dermis 가정) 에 ~10–100 s 필요. 이는 milestone 5 의 반응 시상수와 비교 검증 필요.
- **반복 도포 시 dermis fibrosis / immune reaction**: MN 30 일 1회는 안전 범위 추정이지만 1년 12회 반복 (90%+ removal 달성까지) 의 dermal 안전성 데이터 부족 — milestone 6 (안전성) + milestone 9 (in-vivo) 에서 확인.
- **잉크 깊이 individual variation**: 깊은 잉크 (≥ 2000 μm, 전문가 깊은 시술) 에는 L=1500 μm MN 도 under-reach. **needle 길이 SKU 2종** (L=1000 μm shallow / L=1800 μm deep) 으로 분기 필요할 수 있음.
- **SC permeation enhancer 미사용**: MN 은 SC 를 우회하므로 enhancer 가 필요 없음 (sensitization risk 회피) — 이는 NE/liposome 대비 안전성 우위.

### 4.6.3 milestone 4 의 범위 — 본 문서 NOT 다룬 것

- 활성 분자 X 의 구체적 선택 (milestone 3 산출물)
- needle polymer 성분 / 용해 속도 / payload 안정성 lock (milestone 7)
- MD/QM 시뮬레이션의 SC 통과 (out-of-scope — 본 문서는 phenomenological depth · Fick 으로 충분)
- ex-vivo 돼지 피부 검증 (milestone 8)
- in-vivo 효능 / 독성 (milestone 9)

---

## 4.7 milestone 4 closure checklist

- [x] 피부 cross-section ASCII + ink 거주 깊이 명시
- [x] 4 메커니즘 first-principles 운반 물리 (Fick · Nernst-Planck · 기하) 비교
- [x] 메커니즘별 detail (구조 · 크기 · payload · 깊이 · 안전성 · FDA precedent · 비용)
- [x] 9-axis 비교 매트릭스
- [x] vs-diagram (깊이 별 분자 deposition)
- [x] 추천 #1 (MN dissolving L≈1000–1500 μm) + 추천 #2 (LNP + MN combo) first-principles 근거
- [x] first-in-kind vs precedented 조합 정직 caveat
- [x] 미지수 list (반복 도포 안전성 · 잉크 깊이 분포 · 분자-polymer 호환)

→ **milestone 4 = design-completed-form**. 다음 milestone (5) 의 잉크-분자 반응 시뮬레이션은 본 추천 mechanism (MN ± LNP) 의 deposition assumption (분자가 ink 표면 30–100 μm 이내) 위에서 진행하면 됨.
