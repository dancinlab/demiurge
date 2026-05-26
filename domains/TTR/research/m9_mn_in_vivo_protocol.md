# TTR-MN M9 — in-vivo 동물 효능 protocol design

> 출처: `m8_mn_ex_vivo_protocol.md` (PoC pass cell list 가정) + `m7_mn_array_engineering.md` (GMP precursor patch) + `off_target_safety.md` (M6 endpoint)
> milestone: TTR-MN.md "M9-MN in-vivo 동물 효능 (rat / mini-pig 14-90일)"
> scope: in-vivo protocol design (실제 동물 실험은 CRO 외주 — IACUC 승인 필요)

## TL;DR

2-tier 동물 실험: **Tier 1 = SD rat** (small · 비용 ↓ · n=12/cohort · 28일) → **Tier 2 = mini-pig** (인간 피부 가장 유사 · n=8/cohort · 90일). Pass cell (ex-vivo M8) 3 payload × 2 species × 2-3 ink 클래스. Primary endpoint: ink removal % (digital + histology + OCT in vivo). Safety: 멜라닌 · 콜라겐 · 혈관 · 면역 (M6 🔴 3 pair) · 전신 PK · 1회 vs 3회 repeated dose. **비용 Tier 1 = $40-60k · Tier 2 = $200-300k**. Pass → IND prep (M10).

## Tier 1 — SD rat (14-28일 · screening)

### 모델 선택

| 모델 | 장점 | 단점 | 본 PoC 적합 |
|---|---|---|---|
| **Sprague-Dawley rat** | 비용 ↓ · 잘 알려진 species · 빠른 turnaround | SC 두께 인간 1/5 · 종간 차이 mid | ★★★ |
| Nude rat | 표피/진피 layer 명확 | 비용 ↑ · 면역 결핍 | ★★ |
| Hairless guinea pig | 피부 인간 유사 · 사이즈 mid | 비용 ↑ | ★★ |
| Yucatan mini-pig | 인간 유사 · 진짜 진피 두께 | 비용 매우 高 · 시간 ↑ | Tier 2 |

### Experimental design (Tier 1)

| group | payload | ink | n | duration |
|---|---|---|---|---|
| G1 | CeO₂ NP MN | azo (color) | 8 | 28일 |
| G2 | DyP+DFO MN | mixed (carbon + Fe₂O₃) | 8 | 28일 |
| G3 | AzoR+ascorbate MN | azo | 8 | 28일 |
| G4 | sham (HA only) | mixed | 6 | 28일 |
| G5 | untreated control | mixed | 6 | 28일 |

⇒ 총 36 rats. 4 cohort × 3 timepoint (Day 7, 14, 28) snapshot.

### Tier 1 endpoint

- **Primary**: ink removal % (digital photo + OCT in vivo)
- **Secondary (safety)**:
  - Skin biopsy histology (Day 28) — 콜라겐 · 멜라닌 (Fontana-Masson) · 혈관 · 면역세포 IHC
  - Systemic PK: serum CeO₂ ICP-MS · DFO LC-MS · 효소 ELISA
  - CBC + clinical chemistry (간 · 신 toxicity)
  - 체중 변화

### Tier 1 success criteria

| metric | gate (Tier 2 진입) | fail-fast |
|---|---|---|
| Removal % (Azo · 28일) | ≥ 60% | < 40% |
| Removal % (mixed · 28일) | ≥ 40% | < 25% |
| Collagen 손상 (Masson) | minimal | severe |
| Mel 손상 (Fontana-Masson) | ≤ 10% loss | ≥ 30% loss |
| 전신 PK | candidate ≤ LOD in serum | detectable systemic |
| 부작용 발견 | none significant | hematology · 간기능 abnormal |

### Tier 1 비용

| 항목 | $ |
|---|---|
| 36 SD rats · housing 28일 | 4,000 |
| MN patches × 3 application/rat · 36 = 108 patches | 5,400 |
| IACUC + ethics review | 3,000 |
| Histology + IHC + Fontana-Masson 5 stain × 36 | 12,000 |
| PK ICP-MS + LC-MS + ELISA | 8,000 |
| CBC + chemistry | 3,000 |
| CRO 인건비 | 15,000 |
| **합계** | **~$50,000** |

## Tier 2 — mini-pig (60-90일 · 본격 efficacy + safety)

### Experimental design (Tier 2)

| group | payload | ink | n | duration |
|---|---|---|---|---|
| G1 | CeO₂ NP MN | azo color | 6 | 90일 (multi-cycle) |
| G2 | DyP+DFO MN | mixed | 6 | 90일 |
| G3 | AzoR+ascorbate MN | azo | 6 | 90일 |
| G4 | sham (HA only) | mixed | 4 | 90일 |
| G5 | untreated control | mixed | 4 | 90일 |

⇒ 총 26 mini-pigs (Yucatan). Multi-cycle: 30일 1회 × 3회 (Day 0, 30, 60) · final Day 90 측정.

### Tier 2 endpoint

- **Primary**: ink removal % (digital + OCT + ultrasound · multi-cycle 누적)
- **Secondary (efficacy)**:
  - Per-cycle removal % (각 30일 라운드 후 측정)
  - Dose-response (low vs high MN density)
  - Ink class별 (Azo · carbon · Fe₂O₃)
- **Safety (M6 🔴 endpoint focus)**:
  - **Melanocyte**: HMB-45 + Fontana-Masson · 5 yr melanoma registry (long-term track)
  - **Collagen I/III**: multiphoton SHG · cutometer · 흉터 hyperechoic ultrasound
  - **Vessel**: CD31 IHC · capillary density
  - **Immune**: CD68 macrophage · IgE serology · DTH 반응
  - **Aromatic amine**: serum LC-MS · 24-72h kinetic
- **Histology**: Day 30, 60, 90 biopsy

### Tier 2 success criteria (M10 IND 진입 gate)

| metric | gate (IND 진입) | fail-fast |
|---|---|---|
| Removal % (90일 3-cycle 누적) | ≥ 80% (TTR-MN.md @goal) | < 60% |
| Scar (cutometer 탄성) | within 10% normal | > 30% 손실 |
| 멜라닌 손실 | ≤ 5% (Fitzpatrick I-III) · ≤ 15% (IV-VI) | ≥ 20% |
| 전신 부작용 | none significant | hematology · 간 · 신 abnormal |
| Aromatic amine serum | < 10 ng/mL peak | > 100 ng/mL |
| IgE 증가 (효소 면역원성) | < 2× baseline | ≥ 5× |

### Tier 2 비용

| 항목 | $ |
|---|---|
| 26 Yucatan mini-pigs · housing 90일 ($30-50/day each) | 80,000 |
| MN patches × 3 cycle × 3 site/pig · 26 = ~234 patches | 12,000 |
| GMP small batch precursor (cost premium) | 30,000 |
| IACUC + ethics + GLP audit | 8,000 |
| Histology + IHC + Fontana-Masson × multiple timepoint | 40,000 |
| Multiphoton SHG + cutometer + ultrasound | 25,000 |
| LC-MS PK (multi-timepoint) | 25,000 |
| CD31 + CD68 + IgE serology | 18,000 |
| CRO 인건비 + project mgmt | 60,000 |
| **합계** | **~$300,000** |

## Pretreatment design

- **Tattoo creation**: tattoo artist (consent · IACUC override 절차) · 2×3 cm 영역 · 표준 ink (carbon · azo · Fe₂O₃ 3 site/animal)
- **Healing**: 8주 후 (잉크 macrophage 안정 distribution)
- **Treatment start**: Day 0

## Multi-cycle dosing schedule

```
Day 0   Day 30   Day 60   Day 90
 ▼       ▼        ▼        ▼
 cycle 1 cycle 2  cycle 3  endpoint
 patch   patch    patch    biopsy + measure
   │       │        │        │
   ▼       ▼        ▼        ▼
 24h    24h      24h      final
 photo  photo    photo
```

⇒ 30일 1회 용법 (TTR-MN.md @goal "30일 1회") 정합.

## 5-tier safety endpoint stacking (M6 정합)

| tier | endpoint | M6 cross-ref |
|---|---|---|
| 1 (immediate) | local 자극 · 발적 · 통증 | basic |
| 2 (24-72h) | aromatic amine serum · 부산물 PK | M6 §6 unknowns |
| 3 (Day 7-28) | 멜라닌 · 콜라겐 · 면역 (IHC) | M6 🔴 3 pair |
| 4 (Day 30-90) | scar · 탄성 · 색소침착 | TTR @goal "흉터 없음" |
| 5 (long-term registry · 5 yr) | 멜라노마 · 광노화 · 발암 | M9 endpoint extension |

## Bridging 시험 (Tier 1 → Tier 2)

- Tier 1 (rat) pass 후 Tier 2 (mini-pig) species translation:
  - **PK 외삽**: rat → human equivalent dose (HED) via allometric scaling (BW × 0.13 = mini-pig dose · ÷ 0.16 = human dose)
  - **Skin permeability**: rat SC 두께 5 μm vs mini-pig 15 μm vs human 20 μm — penetration force 보정 · MN length variant 사용 (rat 800 μm · mini-pig 1200 μm · human 1200-1800 μm)
  - **Macrophage density**: 종간 유사 (per cm² · M6 §6.4)

## Stop-go decision matrix

| Tier 1 outcome | Tier 2 진입 | M10 IND |
|---|---|---|
| Pass all gates | ✅ Tier 2 진행 | conditional |
| Partial (removal OK · safety borderline) | Tier 2 with reduced dose / formulation 변경 | conditional |
| Fail efficacy (removal < 40%) | M3-MN candidate 재검토 | ❌ |
| Fail safety (severe collagen/mel loss) | M6 mitigation 재설계 | ❌ |
| 전신 PK 발견 | M7 formulation 재설계 (encapsulation 강화) | ❌ |

## CRO 후보 (per external_libraries.md §10 regulatory)

- Charles River Laboratories (rat + mini-pig · GLP)
- Covance / LabCorp (rat preclinical)
- Sinclair Bio Resources (mini-pig)
- WuXi AppTec (China · 비용 ↓)
- 한국: KIT (Korea Institute of Toxicology) · KOTERA

## M10 handoff — IND 진입 조건

다음 milestone (M10 measured-oracle PASS · IND 패키지) 가 받는 입력:
- Tier 2 pass cohort 데이터 (efficacy + safety)
- GMP MN array lot · payload lot 정합
- PK/PD modeling
- 5-tier safety stacking 결과
- FDA pre-IND 미팅 자료 (Type B 미팅 요청)

## Honest unknowns

- **Mini-pig vs human SC 정확 비교**: dermis 두께 일치 · 모낭 밀도 차이
- **Tattoo creation in animal**: consent · IACUC 절차 복잡 (인공 ink가 ethical OK?)
- **Multi-cycle 효과 비선형성**: cycle 2-3 시 잉크 distribution 변동 (이동 · macrophage redistribution)
- **5-yr melanoma registry 비용**: 별 funding 필요 (post-market 형식)
- **Aromatic amine serum LOD**: 100 ng/mL gate가 충분히 conservative?
- **Allometric scaling 정확성**: skin permeation은 단순 BW scaling 부정확 (별 모델)
- **GMP precursor cost premium**: 30k+ · M10 시 추가 증가

## 진행 상태

- ✅ 2-tier 설계 (rat → mini-pig) · 26+36 = 62 animal · 90일 max
- ✅ 5-tier safety endpoint stacking (M6 🔴 cross-ref 완전)
- ✅ Multi-cycle dosing (30일 1회 × 3회 · @goal 정합)
- ✅ Bridging 시험 (allometric scaling · MN length variant)
- ✅ Stop-go decision matrix · CRO 후보
- ✅ 비용 Tier 1 $50k + Tier 2 $300k = $350k 총 in-vivo 비용
- design completed (per @D d1) — 실제 lab 실행은 CRO 외주
- next: MN measured-oracle PASS endpoint 정의 + FDA IND 패키지 (M10)
