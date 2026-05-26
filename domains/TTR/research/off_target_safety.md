# TTR §6 — Off-target Safety (진피 비표적 손상 first-principles 예측)

@scope: TTR.md milestone 6 of 10 — 4 attack chemistry × 6 dermal off-target = 24-cell first-principles risk matrix
@status: design-only · first-principles 추론 · no wet-lab · 🟡 SUPPORTED-BY-CITATION (분자 BDE · E° · log K · 효소 dependence 표준 표 인용)
@input: §1 ink_classes.md (4 attack chemistry — oxidation · reductive · chelation · photo) + §4 transdermal_delivery.md (MN L≈1000–1500 μm, payload plume ~30–100 μm 반경)
@output: 🔴 critical pair list → M2/M3 의 chemistry / molecule X 선택 constraint + M9 in-vivo 검증 endpoint
@convention: payload concentration 가장 높은 영역은 needle tip 100 μm 이내 (M4 §4.6.2) — off-target proximity 는 이 plume 기준으로 평가

---

## 6.0 핵심 가정 — Microneedle delivery 가 safety question 을 어떻게 바꾸나

M4 결론: dissolving microneedle L≈1000–1500 μm 가 payload 를 **상-중부 진피 (papillary + 상부 reticular dermis)** 에 직접 deposition.

→ 안전성 질문이 재정의됨:
- ❌ Old: "SC 를 안전하게 통과하나" (수동 확산 paradigm)
- ✅ New: **"진피 안에서 payload plume 반경 (30–100 μm) 안의 *모든 것* 중 무엇이 off-target 으로 손상되나"**

```
[MN tip deposition geometry — single needle 단면]

         skin surface
              │
              ▼
   ════════════════════ SC 10–20 μm      ← MN 채널만 통과, 화학반응 무
   ┌──────────────────┐
   │  vEp 50–100 μm   │ ◯◯◯ basal melanocytes   ← L>120 μm needle 가 통과 시 직접 노출
   ├──────────────────┤
   │  papillary dermis│  ░░░░░░░░░░░░░░░░░       ← payload plume 반경 ~30–100 μm 시작
   │  100–300 μm      │  ░░░  ★MN tip★     ░░░
   │                  │  ░░░░░░░░░░░░░░░░░       ← 콜라겐 I/III · 모세혈관 · 신경말단
   ├──────────────────┤
   │  reticular dermis│  ░░░ ▓▓▓INK▓▓▓ ░░░       ← target ink 입자 + macrophage 잔류층
   │  300–2000 μm     │  ░░░░░░░░░░░░░░░░░       ← 면역세포 · 콜라겐 reticulum · 부속기
   └──────────────────┘
              │
              ▼
   hypodermis 2000+ μm                          ← over-shoot 시 전신 흡수 risk
```

핵심 사실: **payload plume 안에 ink 입자만 있는 게 아니다**. 거의 모든 off-target 세포·단백질·이온이 같은 ~30–100 μm 거리 안에 공존. 차이는 (a) 분자량별 확산속도 (b) chemistry-specific reactivity.

---

## 6.1 진피 Off-target inventory (depth × cell density)

| Off-target | 위치(깊이 μm) | 진피 cm³ 당 밀도 | 1차 구성 분자 | TTR plume 노출도 |
|---|---|---|---|---|
| **멜라닌세포 (melanocyte)** | basal vEp (60–100) + 드물게 dermal | ~1200/mm² basal (사람 평균) | eumelanin (DHI/DHICA polymer) + pheomelanin · TYR/TYRP1/TYRP2 효소 (Cu-dependent) | **L>120 μm needle 통과 시** + 진피로 일부 떨어진 melanocyte 의 경우 |
| **콜라겐 기질 (collagen I/III + 엘라스틴)** | 진피 전체 (100–2000) | 진피 dry mass 의 ~70–80% | Type I collagen triple helix (Gly-X-Y) + lysyl/hydroxylysyl crosslink (LOX — Cu-dependent) | **plume 전체 (질량적으로 압도)** |
| **혈관 (capillary · venule · arteriole)** | papillary plexus (200 μm) + reticular plexus (1500 μm) | 진피 부피의 ~5%, surface ~50–100 mm⁻² | endothelial cell + 기저막(laminin·col IV) + 적혈구(Hb·Fe) · ceruloplasmin(Cu) | **plume 반경에 ≥1 capillary 들어옴** (밀도 계산) |
| **면역세포 (macrophage · Langerhans · mast · T)** | 진피 전체 분포 | macrophage 50–200/mm³ · mast 5–10/mm³ · LC ~700/mm² (vEp) · T scattered | macrophage = ink reservoir (target 의 host cell!) · mast = histamine/serotonin granule · LC = MHC II · T = TCR | **target host 와 동일** — 표적과 비표적이 같은 세포 |
| **신경말단 (sensory nerve ending · C-fiber)** | 진피 전체, dense at vEp interface | free ending ~0.6/mm² + 0.4 myelinated · TRPV1/A1 receptor | TRPV1 (capsaicin/H⁺ sensor) · TRPA1 (electrophile sensor) · Nav1.7/1.8 | **plume 통과 시 직접 활성화 (통증·신경원성 염증)** |
| **부속기 (모낭 · 피지선 · 한선 + 줄기세포)** | bulge 진피경계 ~1500 μm + 피지 200–500 + 한선 700–1500 | 모낭 ~20–40/cm² · 피지선 ~100/cm² | 케라틴(hard) · 피지(squalene·트라이글리세라이드) · K15+ 줄기세포 (bulge) | **L≈1500 μm 가 bulge 깊이 직접 통과** — 줄기세포 plume 노출 |

---

## 6.2 4 Chemistry × 6 Off-target = 24-cell risk matrix

표기:
- ✅ negligible — first-principles 반응성 부족 또는 thermodynamic barrier
- 🟡 caution — sub-lethal effect 가능 (회복 가능 산화 스트레스 / 일시적 효소 저해)
- 🟠 watch — dose-dependent damage (조사 권장, 회복 가능성 의존)
- 🔴 critical — therapeutic dose 에서 손상 likely (mitigation 필수)

### 6.2.1 매트릭스

| Off-target ↓ \ Chemistry → | **Oxidation (•OH / Fenton)** | **Reductive cleavage (azoreductase · dithionite · ascorbate)** | **Chelation (DFO · DTPA · EDTA · siderophore)** | **Photo-cleavage (UV-vis + sensitizer)** |
|---|---|---|---|---|
| **멜라닌세포** | 🔴 critical | 🟡 caution | 🟠 watch | 🔴 critical |
| **콜라겐 I/III 기질** | 🔴 critical | ✅ negligible | 🟠 watch | 🟡 caution |
| **혈관 (endothelium·기저막)** | 🟠 watch | 🟡 caution | 🟡 caution | 🟡 caution |
| **면역세포 (macrophage 등)** | 🟠 watch | 🟡 caution | 🟠 watch | 🟠 watch |
| **신경말단 (C-fiber)** | 🟠 watch | ✅ negligible | ✅ negligible | 🟡 caution |
| **부속기 (모낭 줄기세포 등)** | 🟠 watch | ✅ negligible | 🟡 caution | 🟠 watch |

### 6.2.2 cell-by-cell first-principles 근거

| Cell | 등급 | First-principles 근거 |
|---|---|---|
| Mel × Ox | 🔴 | (a) eumelanin DHI/DHICA polymer 의 phenol/카테콜 잔기는 •OH (E° +2.80 V) 의 best target — semiquinone radical 형성 · BDE(O-H phenol) ≈ 360 kJ/mol << •OH 산화 능. (b) melanocyte 자체가 H₂O₂ stress 에 vitiligo precedent (Schallreuter 1991 H₂O₂ accumulation 모델). (c) Fenton (Fe²⁺+H₂O₂) → •OH 가 plume 내에서 비선택적. |
| Mel × Red | 🟡 | 환원제(dithionite·ascorbate)는 melanin 의 quinone↔hydroquinone 가역 reduction 만 — depigmentation 가역. TYR 효소가 Cu-active site 인데 환원제가 Cu²⁺→Cu⁺ 시 일시 활성↓ (회복). |
| Mel × Chel | 🟠 | TYR/TYRP1/TYRP2 의 binuclear Cu site 가 DFO (Fe-specific) 에는 거의 무영향이나 EDTA / DTPA 는 Cu (log K ≈ 18) 도 chelate → 새 melanin 합성 정지. 진피 melanocyte 직접 노출 시 영구 depigmentation 위험 (chemical leukoderma — hydroquinone precedent). |
| Mel × Photo | 🔴 | (a) 멜라닌이 광흡수 spectrum 거의 전 가시역 + UV. UV+sensitizer 적용 시 melanin 자체가 chromophore → 광열손상 + 광화학(¹O₂) 둘 다. (b) PUVA precedent — 8-MOP+UVA 가 melanocyte 표적치료(역으로 활용)이라는 사실은 melanocyte 가 광민감 표적임을 직증. Q-switched laser 시술 부작용으로 hyper/hypopigmentation 보고. |
| Col × Ox | 🔴 | (a) collagen Gly-X-Y triple helix 에서 hydroxyproline · lysyl crosslink 잔기 모두 •OH 산화 → carbonyl 형성 (Stadtman protein oxidation model · BDE(C-H α to N) ≈ 380 kJ/mol). (b) MMP 활성화 + 분해. (c) 진피 콜라겐은 turnover ~수개월–수년 → 단기 비가역. (d) Fenton chemistry 가 collagen scaffold 의 가장 큰 표적 (질량적으로 plume 의 ~80%). |
| Col × Red | ✅ | Type I collagen 의 peptide bond / Gly-X-Y backbone 은 표준 환원전위에 robust (E° 너무 음극). lysyl crosslink (allysine→Schiff→aldol) 의 환원 가능하나 collagen 강도에 미세 영향. |
| Col × Chel | 🟠 | (a) LOX (lysyl oxidase) = Cu²⁺-dependent — 강 Cu chelator (e.g. trientine, EDTA) 가 새 collagen crosslinking 차단 → 신규 합성된 collagen 의 tensile↓. 기존 crosslink 자체는 chelator 영향 X. (b) DFO (Fe-specific) 는 거의 무영향. (c) penicillamine 임상 부작용 cutis laxa 가 LOX 저해의 dermal precedent. |
| Col × Photo | 🟡 | 콜라겐 자체는 UV-C (<280 nm) 에서만 직접 흡수. UV-A/Visible + sensitizer → ¹O₂ 가 hydroxyproline · methionine 산화 → 광노화 (photoaging) precedent. 가역성 부분 (turnover). |
| Vess × Ox | 🟠 | (a) endothelial NO synthase (eNOS) 가 •OH 에 의해 uncoupling → NO bioavailability↓ → 혈관 일시적 dysfunction. (b) hemoglobin (Hb) 는 적혈구 안에 있어 plume 노출 제한적. (c) capillary 기저막 col IV 산화 → 미세누출 가능 (dose-dependent). |
| Vess × Red | 🟡 | ascorbate 는 endothelial NO bioavailability↑ (오히려 보호). dithionite 강도 환원제는 hemoglobin (Hb Fe²⁺→Fe³⁺ methemoglobinemia) 시 위험 — 그러나 plume 농도가 systemic 수준 못 미침. |
| Vess × Chel | 🟡 | ceruloplasmin (혈관 내 Cu carrier) chelation 가능하나 진피 plume 농도 ↘. DFO 는 Fe 만 → endothelial Fe pool 일시 감소 (가역). |
| Vess × Photo | 🟡 | 적혈구 Hb 는 가시광 흡수 (415/540/575 nm) — laser 시술의 vascular target 가 이 mechanism. PDT 적용 시 sensitizer 가 capillary 표적 가능. plume 안 sensitizer 농도가 PDT 임계 이하라면 가역. |
| Imm × Ox | 🟠 | (a) macrophage = ink 표적 host — Fenton 의 phagolysosome 산성환경(pH 4-5)에서 가속 (Fenton 최적). 의도된 ink contact 이 동시에 macrophage damage. (b) ROS → NLRP3 inflammasome 활성화 → IL-1β release → 만성염증·과각화. (c) mast cell 탈과립 → histamine 가려움. (d) Langerhans / T cell DNA 산화 손상 가능. |
| Imm × Red | 🟡 | 환원환경이 macrophage M1→M2 polarization 영향 가능. azoreductase 는 macrophage cytosol 내 자연 효소 — 외인성 환원제 추가 시 immune homeostasis 일시 변화. |
| Imm × Chel | 🟠 | (a) macrophage iron storage (ferritin/heme) — DFO 가 chelate 시 macrophage Fe deficiency → ROS production 변화 + M1/M2 균형 변화. (b) Cu chelation → MΦ 활성 변화 (ceruloplasmin antiinflammatory loss). (c) 만성 chelation 시 NK·T cell 기능 저하 보고. |
| Imm × Photo | 🟠 | LC (Langerhans cell) 가 UV 에 매우 민감 — UV-B 가 LC 이동/사멸 유도 (sunburn immunosuppression precedent). 진피 macrophage 도 PDT 표적. plume sensitizer 농도 따라 dose-dependent. |
| Nerve × Ox | 🟠 | (a) C-fiber 의 TRPA1 = electrophile sensor (4-HNE · acrolein 등 oxidation byproduct 감지) → 직접 활성화 → 통증·neurogenic inflammation. (b) TRPV1 도 ROS-sensitized. (c) 가역적 firing 이지만 반복시 hyperalgesia. |
| Nerve × Red | ✅ | 환원제 자체는 TRP 채널 활성화 거의 없음. lipid bilayer / 수초의 표준 환원전위 안전 범위. |
| Nerve × Chel | ✅ | DFO/EDTA 진피 농도에서 axon function 거의 무영향 (calcium chelation 은 EGTA 같은 specific chelator 가 아닌 한 무관). |
| Nerve × Photo | 🟡 | UV 직접 신경 손상은 낮음 (epidermis 흡수 후 진피 도달량 적음). sensitizer + visible 광 ¹O₂ 가 신경막 lipid 손상 가능 — 가역. |
| Adn × Ox | 🟠 | (a) bulge 줄기세포 (K15+) 가 dermis-vEp 경계 깊이 ~1500 μm — L=1500 μm needle 의 plume 안. (b) ROS 가 stem-cell aging 가속 (Tomasetti·Vogelstein style). (c) 한선 (Cl⁻ secretion) endothelium 손상 → 일시적 무한증 가능. |
| Adn × Red | ✅ | 부속기 구조단백질 (keratin 등) 의 환원 cleavage 는 강 환원제 (thioglycolate · permanent wave 강도) 필요 — TTR chemistry 범위 밖. |
| Adn × Chel | 🟡 | LOX-dependent keratin 가교 영향 — 단기 무영향. 피지선 Zn-dependent enzyme 일부 chelation 영향. |
| Adn × Photo | 🟠 | (a) UV + sensitizer 가 모낭 melanocyte 표적 → hair greying (precedent). (b) sebum (squalene) 광산화 → comedogenic. (c) 반복 시 모낭 줄기세포 손상 가능. |

→ **🔴 critical 셀 = 3개**: (Mel × Ox), (Mel × Photo), (Col × Ox).

---

## 6.3 Worst-cell deep dives — 3개 🔴 critical pairs

### 6.3.1 Mel × Oxidation — 멜라닌세포 산화 손상

**문제**: Fenton (Fe²⁺ + H₂O₂ → •OH) 는 ink 표면 -COOH/-OH 산화 (carbon black 표적) 및 azo cleavage (N=N 환원 후 산화로 보조) 의 backbone. 그러나 •OH 가 plume 내 비선택적 → melanocyte phenol/catechol-rich melanin 가 high-affinity off-target. 결과: 영구 hypopigmentation (vitiligo-like) 또는 hyperpigmentation (염증 후).

**First-principles mitigation paths** (≥1 항상 surface — @D d2):

1. **Depth targeting** — MN length L 을 ink layer 에 정확 매칭 (1000–1500 μm), basal melanocyte (60–100 μm) 위로 plume 이 역확산하지 않도록 **needle shaft 의 polymer dissolution 을 tip-only 로 설계** (M4 가 가능성 명시 §4.3.4 dissolving). plume 의 90% 가 진피 깊이로 한정 → epidermal melanocyte 노출 ~10⁻¹ 으로 감소.

2. **ROS scavenger gradient (co-formulation)** — needle 의 *shaft* 에 ascorbate / 만니톨 (•OH scavenger, k(•OH+ascorbate) ≈ 1.1×10¹⁰ M⁻¹s⁻¹) 을 1차 dissolve 하도록 적층, *tip* 에 Fenton 시약을 2차 dissolve. 시간차로 *얕은 깊이의 ROS 는 즉시 quench, 깊은 ink target 만 산화*. ROS lifetime (~10⁻⁹ s × diffusion 2-3 nm) 의 super-localization 활용.

3. **Chemistry switch** — carbon black target 의 경우 Fenton 대신 **peroxidase 효소 (MPO/LPO)** 사용 시 효소가 melanocyte 안에 침투 어려움 (분자량 > 60 kDa, 세포막 차단) → off-target 감소. M2 MoA short-list 에 "효소 mediator 우선" 입력.

4. **Sub-threshold + multi-cycle dosing** — 1회 도포 시 ROS dose 를 melanocyte LD50 (∼10⁻⁴ M •OH-equivalent dose) 아래로 keeping, ink 분해는 cycle 누적 (TTR.md 의 "1 튜브 = 1 cycle" + multi-month treatment 가 이미 multi-cycle 구조).

### 6.3.2 Mel × Photo — 멜라닌세포 광열·광화학 손상

**문제**: 멜라닌이 거의 모든 가시광/UV 흡수 → photo-activation chemistry 의 1번 chromophore. UV + sensitizer 적용 시 melanin 자체가 ¹O₂ 생성 sensitizer 가 되고 동시에 광열 damage 까지 받음. 결과: Q-switched laser 의 부작용 (영구 hypo/hyperpigmentation) 과 동일 메커니즘.

**First-principles mitigation paths**:

1. **Wavelength selection** — melanin 흡수 spectrum (Sλ ∝ 1/λ^β · β≈3.5) 의 trough 인 **NIR 1064 nm 영역 사용** (Q-switched Nd:YAG 1064 nm 가 darker skin 에 안전한 이유). 잉크 입자 (graphitic carbon) 는 NIR 도 흡수, melanin 흡수는 ~10× 낮음. sensitizer 도 NIR-activated 종 선택 (e.g. IR700 phthalocyanine-based PDT).

2. **Sensitizer co-localization** — sensitizer 를 **ink-binding antibody / aptamer** 또는 **ink particle 표면 -COOH 친화 화학 link (carbodiimide-type)** 로 미리 ink 표면에 결합시켜 두고, 광 조사 시 sensitizer 가 ink 근방에서만 ¹O₂ 생성. 자유 sensitizer (melanin 결합 가능) 제거.

3. **Depth targeting** — 광 조사 epidermis 통과 시 melanin 의 1차 흡수 → 광에너지의 ~30–60% 가 epidermis 에서 소실. 광 fluence 를 melanin damage threshold 이하 + ink damage threshold 이상의 window (Q-switched 시술의 기존 안전 범위, 약 4–8 J/cm²) 로 설정.

4. **Chemistry switch** — photo-chemistry 단독 대신 **chelation 우선 → photo 보조**. M1 에서 Cu-Pc/Cr₂O₃ 가 photo 가 유일한 경로 (chelation 무력) 인데, photo 가 mel × photo 🔴 면 macrophage 재활성화 (M2 우회 전략, M1 §7 caveat) 로 chemistry 자체를 swap.

### 6.3.3 Col × Oxidation — 진피 콜라겐 기질 산화 손상

**문제**: 진피 plume 의 ~80% (질량 기준) 가 collagen. •OH 는 비선택적이고 collagen 의 Gly-X-Y backbone + hydroxyproline + lysyl crosslink 가 모두 산화 표적 (Stadtman model). 결과: 진피 기계강도 ↓, scar / atrophy / wrinkle (photoaging mechanism 과 동일). TTR.md @goal 의 "흉터 없음" 위반.

**First-principles mitigation paths**:

1. **Spatial confinement of ROS** — Fenton 의 •OH lifetime ~10⁻⁹ s · diffusion length ~2–3 nm. ROS 생성을 **ink particle 표면에서만** 트리거하도록 Fe 촉매를 ink 표면 -COOH 와 carbodiimide-link (또는 H₂O₂ 만 free, Fe 는 ink 표면 결합) → ROS 가 collagen 도달 전 소멸. plume 농도가 아닌 *반응자리 농도* 가 결정변수.

2. **Selective oxidant** — •OH 대신 **azoreductase + 후속 효소 산화 (LiP/MnP)** 등 효소 mediator → 효소가 collagen mesh 사이 (∼10–100 nm 격자) 통과 어려움 → ink 입자 표면에서만 반응. 비효소 산화 (•OH) 의 비선택성 회피.

3. **Scavenger 적층** — 6.3.1 과 동일 원리: needle shaft 에 ascorbate / 글루타치온 / catalase 적층 → plume 의 *bulk* 영역에서 collagen 보호, *tip* 근방에서 ink-targeted ROS only.

4. **Dose · cycle 분할** — collagen turnover 가 수개월 단위라는 점이 양날: 비가역적이지만 신규 합성이 일어남. cycle 당 collagen 산화 dose 를 turnover 보충량 이하로 유지 + cycle 사이 4–8 주 휴지기 → net collagen mass 보존. (NB: LOX 차단 chelator 와 병용 금지 — 신규 합성 방해.)

---

## 6.4 Therapeutic index 추산 (order of magnitude · first-principles)

### 가정 (모두 first-principles)

- MN dissolving array, plume 반경 r ≈ 50 μm (Fick-mass-balance 추정, M4 §4.6.2)
- Ink particle 밀도 ρ_ink ≈ 10⁶ /cm³ (M1 §5) → plume 1개 안 ink 입자 수 ≈ (4/3)π(50 μm)³ × 10⁶ /cm³ ≈ 5×10² particles
- Collagen 질량밀도 ρ_col ≈ 0.7 g/cm³ (진피 dry mass × 80%) → plume 안 collagen 분자 ≈ 5×10⁻⁷ g × N_A / 285 kDa ≈ 10¹² molecules
- Melanocyte ≈ 0 in dermal plume (basal 60–100 μm 만, MN tip 1000+ μm 와 분리) — depth targeting 성공 시
- Rate constants:
  - k(•OH + aromatic C) ≈ 10⁹ M⁻¹s⁻¹
  - k(•OH + collagen α-C-H) ≈ 5×10⁸ M⁻¹s⁻¹ (peptide BDE 380 kJ/mol)
  - k(•OH + ink surface -COOH/-OH) ≈ 10⁹ M⁻¹s⁻¹ (graphitic edge)
  - k(•OH + melanin phenol) ≈ 10¹⁰ M⁻¹s⁻¹ (catechol 가장 빠름)

### Naive TI (직접 비율 — no mitigation)

```
TI_naive = (rate_ink × n_ink × k_ink) / (rate_off × n_off × k_off)
        ≈ (5×10² × 10⁹) / (10¹² × 5×10⁸)
        ≈ 5×10¹¹ / 5×10²⁰
        ≈ 10⁻⁹              ← TI ≈ 10⁻⁹ (즉 collagen 손상이 10⁹ 배 우세)
```

→ **naive Fenton broadcast 면 TI ≪ 1, scar 압도**. 이게 "Fenton 직접 도포가 산업적으로 안 쓰이는" first-principles 이유.

### Mitigated TI (Fe-on-ink-surface localization, §6.3.3 mitigation 1)

- Fe 촉매를 ink 표면에 carbodiimide-link → ROS 생성반경 = Fe 위치 = ink 표면 nm-scale
- •OH diffusion length d ≈ √(D τ) = √(10⁻⁵ × 10⁻⁹) ≈ 3 nm
- collagen reach probability ∝ (d / 입자크기)² × volume fraction
- ink 입자 직경 ~500 nm → •OH 의 99%+ 가 ink 표면 3 nm 안에 소멸
- collagen reach: ~3 nm shell × 4π(250 nm)² = 0.5% 만 collagen
- TI_mitigated ≈ TI_naive × (1/0.005) ≈ **10⁻⁹ × 200 = 2×10⁻⁷**

→ surface-localized Fenton 만으로는 여전히 unsafe. 추가 scavenger 적층 필요.

### Fully-mitigated TI (Fe-on-surface + ascorbate shaft scavenger)

- ascorbate 가 plume bulk 의 free •OH 99% 이상 quench (k≈10¹⁰, 농도 ≈ 10 mM → t_quench ≈ 10⁻⁸ s vs •OH lifetime 10⁻⁹ s 같은 자릿수)
- 추가 factor ≈ 100
- TI_total ≈ 10⁻⁷ × 100 = **10⁻⁵**

→ 여전히 < 1. 결론: **순수 화학(•OH) 만으로는 first-principles 불가능, M2 MoA 에서 *효소 mediator + chelation* family 우선**해야 함. 이게 M2 short-list 의 first-principles 입력.

### TI 결론 (1줄)

- **TI naive Fenton**: 10⁻⁹ (압도적으로 collagen 손상)
- **TI surface-Fe + scavenger**: 10⁻⁵ (여전히 unsafe)
- **TI 효소 mediator (peroxidase + H₂O₂)**: TI 추산 ≥ 1 — 효소 자체 size 가 collagen mesh 통과 못함 + ink 표면 affinity 활용. **M2 의 1순위 chemistry**.
- **TI chelation (Fe oxide ink)**: TI ≈ 10²–10³ — DFO/DTPA 의 ink-Fe³⁺ 선택성 (log K ≥ 25) vs 진피 free Fe pool (≈ μM, DFO 결합 정상 작용). **M2 의 2순위**.
- **TI reductive (azo)**: TI ≈ 10²–10⁴ — azoreductase 가 macrophage cytosol 자연 효소, exogenous co-factor 추가 시 ink 안에서만 환원반응. **M2 의 azo-specific 1순위**.

### 주요 가정 (TI 추산의)

1. plume 반경 50 μm 는 M4 §4.6.2 의 "10–100 s diffusion at D=10⁻⁶ cm²/s" 추산 — diffusion 모델이 단순 Fick (대류·전기영동 무시).
2. Rate constant 들은 표준 pulse radiolysis 값 — phagolysosome pH 4–5 환경 보정 없음.
3. ROS lifetime 10⁻⁹ s 는 free •OH — 실제 dermis 의 protein-rich 환경에서는 더 짧을 수 있음 (보수적).
4. **Melanocyte TI 는 별도 평가** — depth targeting 성공 시 plume 에 mel 없음 ≈ TI 무한대; targeting 실패 (L<120 μm needle 또는 plume backflow) 시 TI ≈ 10⁻¹⁰ (mel × ox 의 phenol affinity 가 collagen 보다 빠름). depth control 이 TI 의 binary switch.

---

## 6.5 ASCII 진피 단면 — MN plume × off-target proximity

```
                                  ▼ MN dissolving needle (L=1200 μm)
                                  │
  z=0  ════════════════════════════│════════════════════════════════════════
        SC 10-20 μm (MN 채널 통과)  ●
  20   ─────────────────────────── │ ───────────────────────────────────────
        viable EP 50-100 μm        │      ◯ basal melanocyte (60-100 μm)
        ─ stratum granulosum/spin. │                       ↑
        ─ stratum basale           │            🔴 Ox / 🔴 Photo if plume backflow
 100   ────────────── ◯◯◯ ────── │ ── ◯◯◯ ───────────────────────────────
        papillary dermis           ░░ ┃  ← plume 시작 (반경 ~30 μm)
        100-300 μm                ░░░┃░░░
                                  ░░░┃░░░    █ collagen I/III (전체 부피의 80%)
                                  ░░░┃░░░    ░ payload plume
                                  ░░░┃░░░    🔴 Col × Ox / 🟠 Col × Chel
 300   ───── ╋vessel ─────────── ░░░┃░░░ ──────────────────────────────────
        reticular dermis  ▒▒NeRv▒▒░░░┃░░░ ★ MN tip 1000 μm
        300-2000 μm       ░░░░░░░░░░░┃░░░░░  ← payload deposition 최대
                          ░░░░░░░░░░░┃░░░░░
                          ░░ ▓▓INK▓▓░┃░░ ▓ macrophage host (target)
                          ░░░░░░░░░░░┃░░░░░  🟠 Imm × Ox / 🟠 Imm × Chel
                                                ▒ nerve C-fiber 🟠 Nerve × Ox
                                                ╋ capillary 🟠 Vess × Ox
1200   ───────────────────────────── ★ (needle bottom) ──────────────────
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░ residual plume (gradient ↓) ░░░░░    ╧ bulge stem cell 1500 μm
1500   ──────────────────────────────── ╧ ────────────────────────────────
                                                  🟠 Adn × Ox (모낭 줄기)
2000   ─────────────────────────────────────────────────────────────────
        hypodermis (over-shoot zone — 전신흡수 risk)

  Legend:  ● MN needle shaft  ░ plume gradient  ▓ ink (target)  ◯ melanocyte
           █ collagen           ╋ vessel        ▒ nerve         ╧ bulge stem
```

핵심 관찰:
- L=1200 μm needle 의 plume center 는 reticular dermis 깊이 → **basal melanocyte (60–100 μm) 와 z-방향 1000 μm+ 분리** → mel × ox / mel × photo 의 🔴 가 *depth targeting 성공 시* 실효 mitigation.
- 반대로 plume 반경 (~30–100 μm, lateral)은 **collagen / vessel / nerve / macrophage / 모낭 줄기 모두에 동시 닿음** → 이들은 *lateral targeting 으로 분리 불가* → chemistry 선택 + spatial confinement (6.3.3 mitigation 1) 으로 해결.

---

## 6.6 정직한 scope caveats

### 6.6.1 first-principles 의 한계

1. **Rate constant 표준 조건** — k(•OH+X) 값들은 25 °C · 중성 pH · pulse radiolysis 측정. phagolysosome (pH 4–5, 단백질 부하 高) 보정 없음. 실제 in-vivo 에서 ±1 자릿수 변동 가능.
2. **Diffusion 단순 Fick** — dermis 의 ECM 은 등방성 아님 (collagen fiber alignment), 대류 (혈류·간질액 flow) 항이 추가됨 (plume 반경 ±2× 가능).
3. **Microneedle plume 형상** — 실측 데이터 없음. needle tip dissolution 의 diffusion-vs-convection ratio 가 깊이별 profile 결정 — M9 in-vivo 에서 fluorescent payload tracer 로 매핑 필요.
4. **ROS 부산물 사슬** — •OH 1차 반응 후 lipid peroxidation 부산물 (4-HNE, acrolein) 이 2차로 TRPA1 활성화 → 신경 손상 (6.2.2 Nerve × Ox 🟠 의 mechanism). 사슬 길이 first-principles 추산 어려움.

### 6.6.2 종별 변동

- **Mouse vs human dermis cellularity** — mouse 진피는 ~1.5 mm (vs human 1.5–4 mm), macrophage 밀도 ~2× 높음, follicle 밀도 ~5× 높음. M8 ex-vivo 돼지 / M9 in-vivo mouse 결과의 human translation 시 **부속기 손상 (Adn × Ox/Photo) 은 mouse 가 더 보수적 (worst-case 추정 OK), 콜라겐 손상은 human 이 더 보수적** (human dermis 가 mass thicker).
- **Fitzpatrick I–VI** — Type IV–VI 환자의 epidermal melanin 농도 ~5–10× higher → mel × photo 🔴 의 risk 가 darker skin 에서 더 큼. depth targeting 의 plume backflow tolerance margin 이 더 좁아짐. (Q-switched 1064 nm 의 darker-skin precedent 와 동일 logic.)

### 6.6.3 장기 효과 · 2차 독성

- **콜라겐 turnover months–years** — 단일 cycle 의 collagen 손상이 가역적이지만 multi-cycle 누적 + 12 cycle/year × 5 year (90%+ removal goal) 시 net loss 우려. M9 endpoint 에 진피 두께 (B-mode 초음파) + collagen density (multiphoton microscopy SHG) 필수.
- **azo cleavage byproduct = 방향족 아민** — 일부 IARC carcinogen (benzidine, 4-aminobiphenyl 류). M1 §1.3 에서 이미 caveat 명시. M6 의 추가 함의: macrophage 가 cleavage 산물을 phagocytose 후 림프절 이동 → 전신 분포 → 장기 발암성 risk. M9 endpoint 에 cleavage byproduct 의 urinary metabolite quantification (LC-MS) 필수.
- **금속 산화물 chelation 후 free Fe³⁺/Cu²⁺** — chelator 가 ink 표면에서 떨어진 후 free metal 이 plume 에 진입하면 다시 Fenton 촉매 → 2차 ROS. chelator turnover 와 metal binding kinetics 의 균형 필요.
- **PUVA-like cumulative photo dose** — 광 chemistry cycle 누적 시 melanoma risk (PUVA precedent 의 squamous/melanoma 증가). M2 chemistry 선택 시 photo family 의 후순위 사유.

### 6.6.4 first-principles vs measured 의 경계

| 항목 | first-principles | measured 필요 (M9) |
|---|---|---|
| BDE / E° / log K | ✅ 표준 표 | — |
| Rate constant (free solution) | ✅ pulse radiolysis 표 | — |
| Plume 농도 profile (실제 needle) | ◐ Fick + 가정 | ✅ tracer 영상 |
| Macrophage in-vivo dynamics | ✗ | ✅ IHC + cytokine |
| 콜라겐 SHG density 변화 | ✗ | ✅ multiphoton |
| Hyperpigmentation / hypopigmentation | ✗ (시간상수 月-年) | ✅ 6–12 mo follow-up |

---

## 6.7 M9 In-vivo handoff — 🔴 critical 검증 endpoint

각 🔴 의 falsification 조건 + 측정 방법:

### Mel × Ox / Photo

- **biopsy**: 시술 영역 6 mm punch biopsy (시술 전 · 1 wk · 4 wk · 3 mo · 6 mo) — 진피·표피 5층
- **IHC stain**:
  - Fontana-Masson (melanin pigment, brown)
  - HMB-45 (gp100 marker — melanocyte 특이)
  - MART-1 (melanocyte cytoplasm)
  - TYR / TYRP1 (효소 활성 surrogate)
- **functional readout**:
  - colorimetric (CIE L\*a\*b\*) 시술 부위 vs adjacent — ΔL\* > 5 가 임상적 hypopigmentation 정의
  - reflectance spectrophotometry (Mexameter melanin index)
  - 6 mo 시점에 시술부위 vitiligo-like patch 의 dermoscopy
- **falsification trigger**: 시술 14 day 후 melanocyte 밀도 (HMB-45+) 가 baseline 의 < 70% → 🔴 confirmed, mitigation revisit 필수

### Col × Ox

- **biopsy**: 동일 6 mm punch
- **IHC / 영상**:
  - Picro-sirius red + polarized light (collagen I/III 비율)
  - **multiphoton SHG** (collagen fiber density, second-harmonic generation) — 정량적
  - elastica van Gieson (elastin 동반 평가)
  - MMP-1 / MMP-9 IHC (degradation enzyme upregulation)
  - carbonyl content (DNPH derivatization → IHC) — direct oxidation marker
- **functional readout**:
  - cutometer (피부 탄성 R0, R7 parameter)
  - 초음파 dermal thickness (B-mode 20 MHz)
- **falsification trigger**: 시술 3 mo 후 SHG density 가 baseline 의 < 80% → 🔴 confirmed, ROS spatial confinement 강화 또는 chemistry 변경 mandatory

### Cross-cutting

- **dermal residue mass spec** — biopsy 의 LC-MS/MS 로 (a) ink particle 잔류 (target reduction 확인) (b) cleavage byproduct (방향족 아민 등) (c) chelator residue
- **systemic** — 24 h urine LC-MS (방향족 amine metabolite, 금속 chelate), CBC + 간기능 (chelator hepatotoxicity), 신기능 (chelate excretion)
- **photo 사용 시** — 시술 부위 + 인접 부위 dermoscopy 매 cycle, nevus mapping (melanoma surveillance) + 5 yr long-term registry (PUVA precedent 따라)
- **장기 cohort** — 90% removal 도달까지 multi-cycle 환자의 12 mo / 24 mo / 60 mo follow-up (collagen turnover · melanoma latency)

---

## 6.8 M2 / M3 로의 constraint (handoff)

1. **Chemistry priority (TI 기반)**:
   - 1순위: **효소 mediator (peroxidase · azoreductase · laccase)** — TI ≥ 1, collagen mesh 통과 못함 + ink 표면 affinity
   - 2순위: **chelation (DFO · DTPA · siderophore)** — Fe-oxide ink 한정, TI 10²–10³
   - 3순위: **reductive (효소 보조)** — azo 한정, TI 10²–10⁴, byproduct (방향족 아민) M9 mandatory
   - 후순위: **순수 oxidation (•OH broadcast)** — naive TI 10⁻⁹, mitigation 으로도 TI 10⁻⁵, *uncombined* 사용 금지
   - 후순위: **순수 photo** — mel × photo 🔴, multi-cycle melanoma risk; chelation 보조 또는 NIR wavelength 한정

2. **Molecule X 의 first-principles 제약** (M3 screening 입력):
   - MW > 60 kDa (효소 크기) — collagen 보호용 size selectivity
   - 또는 ink-surface 친화 group (-COOH binding, π-stacking, Fe³⁺ chelating) 보유
   - melanin phenol/catechol 친화 group 회피 (off-target affinity 차단)
   - phagolysosome pH 4–5 활성 (Fenton 환경)

3. **MN architecture 제약 (M4 추가)**:
   - **layered dissolution**: shaft 적층 (ascorbate / catalase scavenger) + tip 적층 (active payload)
   - L = 1000–1500 μm window strict — basal melanocyte 회피
   - needle 밀도 100–500 /cm² → plume overlap 최소화 (lateral over-coverage 방지)

4. **결정적 unknowns 우선순위** (M9 mandatory):
   - plume 농도 실제 분포 (fluorescent tracer 영상)
   - Fitzpatrick IV–VI 환자 mel × photo dose-response curve
   - multi-cycle collagen turnover net balance (12 mo+ cohort)
   - cleavage byproduct (방향족 아민 등) systemic exposure
   - long-term melanoma surveillance (photo-chemistry 사용 시)

---

## 6.9 Milestone 6 closure checklist

- [x] Dermal off-target inventory (6 cell type) — 위치 · 밀도 · 1차 분자 · plume 노출도
- [x] 4 chemistry × 6 off-target = 24-cell risk matrix (✅/🟡/🟠/🔴)
- [x] 24 cell first-principles 근거 (BDE · E° · log K · 효소 dependence · chromophore overlap)
- [x] 🔴 critical = 3 (Mel×Ox · Mel×Photo · Col×Ox) deep dive + 각 ≥4 mitigation path
- [x] Therapeutic index 추산 (10⁻⁹ naive → 10⁻⁵ mitigated → ≥1 enzyme-route)
- [x] ASCII 진피 단면 with plume + off-target proximity
- [x] 종별 / 장기 / 2차 독성 caveat
- [x] M9 in-vivo endpoint (IHC · SHG · cutometer · mass spec · long-term registry)
- [x] M2 / M3 / M4 handoff constraints

→ **milestone 6 = design-completed-form**. 다음 milestone (7 formulation · 8 ex-vivo · 9 in-vivo) 의 chemistry 선택 / scavenger 적층 / endpoint set 모두 본 문서의 입력을 받아 진행.
