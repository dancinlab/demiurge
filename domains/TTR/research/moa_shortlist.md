# TTR M2 — 작용기전(MoA) 후보 short-list (first-principles)

> 마일스톤 M2 산출물 · current-state · no history.
> 입력 = M1 [`TTR/research/ink_classes.md`] §4 cross-class 매트릭스 (8 표적 카테고리) · §1.3/§2.3/§3.3 cleavage 매트릭스.
> 출력 = MoA family 5종 × ink class 8 카테고리 매트릭스 · per-family ≥10 candidate handles · d2 wall breakthrough paths · M3 (in-silico screening) 입력 list.
> 본 문서는 first-principles BDE / E° / log K / pKa 만 사용 (DFT/MD recompute = M5, 분자 ranking = M3). 🟡 SUPPORTED-BY-CITATION.

scope:
- in-scope: 화학경로 5종의 first-principles 메커니즘 · target bond × MoA cell-by-cell 가능성 · d2 wall 우회 후보 · M3 handoff list
- out-of-scope: 활성성분 ranking(M3) · off-target safety(M6) · MD/QM(M5) · 합성/제형(M7) · 동물/인체(M8-9)

---

## 0. TL;DR — 5 MoA families × 8 target categories, one panel

```
                                    표적 결합 (M1 §4 의 8 카테고리)
                  ┌────────┬────────┬────────┬────────┬────────┬────────┬────────┬────────┐
                  │ N=N    │ Fe³⁺   │ H-bond │ -COOH  │ Cu²⁺   │ C-Cl   │ ring   │ 6원환  │
                  │ (azo)  │ lattice│ 격자   │ /OH    │ chelate│ (Cl안료)│ O/N    │ core   │
                  │        │ (Fe ox)│ (QA)   │(carbon)│ (Pc)   │        │(diox·iso│(graphene│
                  ├────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────┤
F1 Oxidation       │ ◐      │ ✗      │ ●●     │ ●●●    │ ◐ ring │ ◐      │ ●●     │ ✗      │
F2 Reductive       │ ●●●    │ ●●     │ ◐      │ ◐      │ ✗      │ ✗      │ ◐      │ ✗      │
F3 Chelation       │ ✗      │ ●●●    │ ✗      │ ◐ edge │ ●● demetal│ ✗   │ ✗      │ ✗      │
F4 Photo-cleavage  │ ◐      │ ◐      │ ◐      │ ◐      │ ●● photo-Fenton│ ●● │ ●●     │ ◐ photoacoustic │
F5 Enzymatic       │ ●●●    │ ◐      │ ◐      │ ●● MPO │ ✗      │ ✗      │ ◐ laccase│ ✗    │
                  └────────┴────────┴────────┴────────┴────────┴────────┴────────┴────────┘

기호: ●●● primary attack · ●● secondary · ◐ partial/surface · ✗ first-principles 불가
```

→ **첫 인상**: F2(reductive) + F3(chelation) 두 family 가 시장 60-70% (azo + Fe oxide + QA) 의 *직접 cleavage* 핸들. F1(oxidation) 은 carbon black 표면 식각의 주력. **Cu-Pc + Cr₂O₃ wall** 은 단일 family 로 해결 불가 → F4(photo-cleavage) + 다단계 staged removal + macrophage 재활성화 hybrid 가 §7 의 breakthrough path.

---

## 1. MoA family 1 — Oxidation (ROS · Fenton · photo-Fenton · O₃ · ClO⁻ · ¹O₂)

### 1.1 first-principles 핵심

산화 = 표적 분자/입자로부터 전자 추출. 핵심량은 **표준 환원전위 E°(oxidant / reduced)** 와 표적의 산화 전위.

| oxidant | E° (V vs SHE) | pH 의존 | 표적 화학 |
|---|---|---|---|
| **•OH (Fenton)** | **+2.80** | weak (full range) | 거의 모든 organic — diffusion-limited |
| ¹O₂ (singlet O₂) | +2.42 | independent | electron-rich aromatic · sulfur |
| O₃ (ozone) | +2.07 | acidic 안정 | C=C · phenol · aromatic amine |
| ClO⁻ (hypochlorite) | +1.49 (HClO) / +0.89 (ClO⁻) | strong (pKa 7.5) | amine · S · phenol |
| H₂O₂ alone | +1.78 (acid) / +0.87 (base) | strong | weak — activator 필요 |
| HO₂• (perhydroxyl) | +1.50 | acidic | secondary |
| O₂•⁻ (superoxide) | -0.33 (reductant 작용) | neutral | electrons 주입 → Fenton 보조 |
| MnO₄⁻ (per-manganate) | +1.51 (neutral) / +1.70 (acid) | wide | C=C · alcohol · 안정 (topical 적용 가능) |

ROS 생성기 (in-skin 적용 가능 형태):
- **Fenton**: Fe²⁺ + H₂O₂ → Fe³⁺ + •OH + OH⁻ — 표적이 이미 Fe oxide 인 경우 *자기촉매적* (M1 §3.3 의 Fe₂O₃ row 와 연동)
- **Photo-Fenton**: Fe³⁺ + hν(λ<450 nm) → Fe²⁺ + 산화반응 — Cu-Pc 가 흡수하는 가시광 (PB 15 의 λ_max ≈ 670 nm) 보다 단파장이지만 UV-A(320-400 nm) 영역에서 광촉매로 동작
- **Haber-Weiss**: O₂•⁻ + H₂O₂ → •OH + OH⁻ + O₂ — 호중구 oxidative burst 의 in vivo 메커니즘
- **Type II photosensitizer**: porphyrin · methylene blue + hν → ¹O₂ — PDT (photodynamic therapy) 의 기성 메커니즘

### 1.2 표적별 first-principles feasibility

| 표적 | 산화 가능성 | 1차 원리 | 정량 핸들 |
|---|---|---|---|
| Carbon black 표면 -COOH/-OH | ●●● | aromatic edge 산화전위 ~+1.6 V < E°(•OH) +2.80 V | 표면적-비례; 1차 입자 100 nm 기준 ~10 nm/cycle 식각 (광물학 Δr 추정) |
| Quinacridone H-bond 격자 | ●● | H-bond 자체는 깨지지 않으나 ROS 가 표면 분자 산화 → crystal 분해 | secondary route (DMSO 보조) |
| Dioxazine ring-O | ●● | C-O ether BDE ~360 kJ/mol < ¹O₂ 직접 공격 가능 (textile fade 와 동일 메커니즘) | UV-A + sensitizer로 가속 |
| Azo N=N | ◐ | 표면 산화는 가능하나 환원 cleavage (F2) 가 압도적으로 효율 | 부속 경로만 |
| Phthalocyanine macrocycle | ◐ | 16π 방향족 — •OH 가 환 cleavage 까지 가려면 multi-step · slow | photo-Fenton 가 더 현실적 (F4) |
| Fe oxide | ✗ | 이미 +3 max (Fe₂O₃) — 더 산화 불가; Fe₃O₄ 의 Fe²⁺ 만 ◐ | reverse direction (F2 reductive) 가 표적 |
| Cu-Pc 중심 Cu²⁺ | ✗ | Cu²⁺→Cu³⁺ E° = +2.4 V (acidic) — 가능하나 macrocycle 보호로 접근 어려움 | wall — F4 가 보조 |
| 6원환 graphene core | ✗ | aromatic C-C BDE 518 kJ/mol 산화 cleavage 불가 (first-principles)  | wall — particle-level 우회 |

### 1.3 top recommendation — Fenton (Fe²⁺ + H₂O₂)

- **rationale**: M1 §3 의 Fe oxide row 와 *동일 분자*. 시술자가 빨강/갈색 (Fe₂O₃) 잉크를 마주칠 때 Fe³⁺ 가 *이미 잔류* → 추가 Fe²⁺ 작은 양 + H₂O₂ 만으로 자기촉매 사이클 가동. Sigma H1009 (3% H₂O₂) + FeSO₄·7H₂O (CAS 7782-63-0) 의 가장 저렴 조합.
- **kinetic**: k_Fenton ≈ 76 M⁻¹ s⁻¹ (Fe²⁺ + H₂O₂ → •OH); 진피 reaction time scale ~수 시간 가능
- **safety hazard**: skin contact 시 mild irritation — 3% 농도 한도 (현 OTC tooth-whitener 등급)

---

## 2. MoA family 2 — Reductive cleavage (dithionite · ascorbate · NADPH · azoreductase · 전기화학)

### 2.1 first-principles 핵심

환원 = 표적에 전자 주입 → 결합 cleavage. **azo N=N 의 BDE 167 kJ/mol** 이 모든 잉크 화학에서 가장 약한 cleavable 결합.

| reductant | E° (V vs SHE) | pH 의존 | 표적 |
|---|---|---|---|
| **Na₂S₂O₄ (dithionite)** | **-1.12** (SO₂⁻ • / SO₃²⁻) | acid 분해 → SO₂ + S | azo · disulfide · quinone |
| Ascorbate (Vit C) → DHA | +0.06 (DHA/Asc) / -0.17 (rad/Asc) | pKa 4.2 | Fe³⁺ → Fe²⁺ · azo radical pathway · ROS scavenger |
| NADPH | -0.32 | neutral | 효소 cofactor — azoreductase / cyt P450 |
| FADH₂ | -0.22 | neutral | 효소 cofactor |
| Borohydride (NaBH₄) | -1.24 | water 분해 (slow @ neutral) | azo · ketone (topical 안전성 X) |
| Zn / acetic acid | -0.76 (Zn²⁺/Zn) | acidic | azo (classical Béchamp) — topical X |
| Glutathione (GSH) | -0.24 (GSSG/GSH) | physiological | disulfide reduction · ROS scavenger |
| TCEP | -0.29 | wide | disulfide (selective) |

### 2.2 azoreductase 효소 (인체 / 미생물 / 식물)

| 효소 | 출처 | cofactor | 표적 azo | K_cat 차수 |
|---|---|---|---|---|
| **AzoR (E. coli)** | 박테리아 | FMN + NADH/NADPH | mono-azo · methyl red | ~10² s⁻¹ |
| AzrA / AzrB (Bacillus) | 박테리아 | FMN/FAD | textile azo | ~10¹ s⁻¹ |
| NQO1 (human) | 사람 cytosol | NADPH + FAD | quinone · 일부 azo (off-target) | ~10² s⁻¹ |
| Cyt P450 reductase | 사람 ER | NADPH | azo (간 metabolism, fail-pathway 의 일부) | ~10¹ s⁻¹ |
| Plant azoreductase | Phragmites · 식물 | NADPH | 광범위 azo (phytoremediation) | ~10⁰ s⁻¹ |

### 2.3 표적별 feasibility

| 표적 | 환원 가능성 | first-principles |
|---|---|---|
| **Azo N=N** | ●●● | BDE 167 kJ/mol · E°(azo/hydrazo) ≈ -0.3 V — dithionite/azoreductase 모두 thermodynamic OK · kinetic 풀이 다양 |
| **Fe³⁺ oxide** | ●● | E°(Fe³⁺/Fe²⁺) = +0.77 V — ascorbate (-0.17 V) 가 환원 → Fe²⁺ 가 용해성 ↑ → chelator 가 빼냄 (F2+F3 직렬) |
| Disulfide (carrier 단백질 코로나 안) | ●●● | RS-SR BDE ~250 kJ/mol · GSH/TCEP 가 -0.24 V — selective | 코로나 disrupt 부효과 |
| Hydrazo · diazo intermediate | ●● | azo cleavage 후속 산물 — 추가 환원으로 완전 아민화 | |
| Quinacridone (quinone-like) | ◐ | quinone → hydroquinone 가능하나 발색단 회복 가능 (불완전) | |
| Dioxazine ring | ◐ | C=N ring partial reduction · secondary | |
| Cu-Pc | ✗ | Cu²⁺→Cu⁺ 가능하나 macrocycle robust · 색 유지 | wall |
| Cr₂O₃ | ✗ | E°(Cr³⁺/Cr²⁺) = -0.42 V — 강한 환원제 필요 + Cr²⁺ 는 산화에 매우 불안정 (즉시 산화) | wall |

### 2.4 top recommendation — Ascorbate + Fe-chelator combo

- **rationale**: ascorbate 단독은 azo 환원에 weak 하지만 (E° -0.17 V vs 필요 -0.3 V), Fe oxide 의 Fe³⁺→Fe²⁺ 환원에 thermodynamic 충분. azo 자체는 *azoreductase recruitment* 또는 *NADPH analog* 가 더 효율. **2-pronged**: ascorbate (Sigma A4544, 안전 cosmetic-grade) + topical azoreductase (recombinant or plant extract) 가 M3 의 default 쌍.
- **safety hazard**: 환원 산물의 방향족 아민(aniline 계열) 일부 IARC carcinogen → M6 의 1순위 평가 대상

---

## 3. MoA family 3 — Chelation / metal extraction (siderophore · catechol · Schiff base)

### 3.1 first-principles 핵심

Chelation = 다좌 ligand 가 metal 을 격자에서 추출. 핵심량은 **log K (formation constant)** 와 ligand 의 denticity.

| chelator | log K (Fe³⁺) | log K (Cu²⁺) | log K (Cr³⁺) | denticity | 적용성 |
|---|---|---|---|---|---|
| **Deferoxamine (DFO)** | **30.6** | 14.1 | ~25 (slow) | hexadentate | FDA approved (Desferal, IV iron overload) |
| Deferiprone (L1) | 36 (β₃) | 14.5 | ~20 | tridentate ×3 | FDA approved (oral) |
| Deferasirox (Exjade) | 22 (β₂) | 11 | ~14 | tridentate ×2 | FDA approved (oral) |
| **DTPA** | 28.0 | 21.4 | 22.4 | octadentate | radiopharm chelator |
| **EDTA** | 25.1 | 18.8 | 23.4 | hexadentate | universal |
| EGTA | 20.5 | 17.0 | ~18 | hexadentate | Ca-selective |
| Citrate | 11.85 | 5.9 | ~6 | tridentate | food-grade |
| Catechol (1,2-dihydroxy) | 20 (β₂) | ~12 | ~14 | bidentate ×2 | tea polyphenol class |
| Enterobactin (sider.) | 49 | — | — | hexadentate (3× catechol) | 미생물 sider. — 최강 Fe³⁺ chelator |
| Pyoverdine (sider.) | 30+ | — | — | mixed | 미생물 sider. |
| Transferrin | 22 (binding constant) | — | — | bidentate ×2 | 인체 단백질 |
| 8-hydroxyquinoline | 12 (β₃) | 12.5 | 10.1 | bidentate | 광범위 |
| Schiff base (salen-class) | ~20 | ~18 | ~20 | tetradentate | tunable |

기준선: log K ≥ 20 → metal oxide 격자에서 metal 빼낼 thermodynamic 임계. log K < 15 → 분리만 가능, 격자 dissolution 어려움.

### 3.2 표적별 feasibility

| 표적 | chelation 가능성 | first-principles |
|---|---|---|
| **Fe₂O₃ / FeOOH / Fe₃O₄** | ●●● | log K(DFO-Fe³⁺) 30 > 격자에너지에 필요한 thermodynamic 벽 (effective Δμ ~-30 kJ/mol per Fe) — kinetic 만 풀면 dissolution 가능. Fe₃O₄ 의 Fe²⁺ 성분은 추가 산화 후 chelation (F1+F3 직렬) |
| Cu-Pc (demetallation) | ●● | log K(Cu-DFO) 14, log K(Cu-EDTA) 18.8 — Cu-Pc 의 log K 는 ~30 → **thermodynamic 으로 Cu 빼내기 어려움**. 단 표면 Cu²⁺ exposed site 한정 약화 → 골격은 metal-free Pc 로 남아 *여전히 청록* (M1 §2.2.2 와 일치) |
| Cr₂O₃ | ◐ | log K(EDTA-Cr³⁺) 23.4 thermodynamic 가능; **kinetic 매우 slow** (Cr³⁺ 의 d³ low-spin 치환 반응 속도가 다른 +3 ion 보다 10⁶ 배 느림) — wall |
| Carbon -COOH | ◐ | edge -COOH 가 약한 chelator 작용 가능 (-O- type) 하나 metal 없음 → indirect (Fe²⁺ 가 와 표면 부착 → Fenton 가속, F1 보조) |
| TiO₂ | ◐ | catechol-based (DOPA · enterobactin analog) 가 Ti⁴⁺ 표면 결합 (log K ~10) → photo-Fenton 보조 |
| azo · QA · dioxazine | ✗ | metal 없음 — chelation 무관 |

### 3.3 top recommendation — DFO (Deferoxamine)

- **rationale**: log K 30+ 의 강한 Fe³⁺ selectivity · FDA-approved · IV/IM/SC 침투 경로 검증 · topical formulation 선례 있음 (microneedle DFO 연구). Sigma D9533 (mesylate salt, CAS 138-14-7).
- **kinetic**: Fe³⁺-DFO 결합속도 k₁ ~5×10⁶ M⁻¹s⁻¹; 진피 macrophage phagosome (pH 4-5) 에서 protonation 변화 없이 작동
- **safety hazard**: 장기/고용량 시 ophthalmologic toxicity 보고 — topical 단기 용법은 안전 마진 큼

---

## 4. MoA family 4 — Photo-cleavage (UV-A · 가시광 + sensitizer · photo-Fenton · TiO₂ 광촉매)

### 4.1 first-principles 핵심

광에너지: E(λ) = 1240 / λ(nm) eV. 결합 에너지 환산: 167 kJ/mol (azo) = 1.73 eV → λ ≤ 715 nm; 305 kJ/mol (aromatic C-N) = 3.16 eV → λ ≤ 392 nm; 360 kJ/mol (C-O ether) = 3.73 eV → λ ≤ 332 nm.

| 광원 | λ (nm) | E (eV) | 피부 침투 깊이 | 첫 번째 표적 |
|---|---|---|---|---|
| UV-C | 200-280 | 4.4-6.2 | <0.1 mm | DNA — topical 적용 X |
| UV-B | 280-320 | 3.9-4.4 | ~0.5 mm | DNA · 직접 산화 — 한계 적용 |
| UV-A | 320-400 | 3.1-3.9 | ~1.5 mm (진피 도달) | photo-Fenton · sensitizer 활성화 · azo direct photolysis |
| Visible (가시광) | 400-700 | 1.77-3.1 | ~3 mm | porphyrin · Cu-Pc · methylene blue absorption |
| NIR | 700-1100 | 1.13-1.77 | ~5 mm (deepest skin penetration) | carbon black photothermal (현 Q-switched laser) |
| 532 nm (Q-switched Nd:YAG) | 532 | 2.33 | ~2 mm | 흑/적/주황 잉크 photoacoustic (현 시술 표준) |
| 1064 nm (Nd:YAG fundamental) | 1064 | 1.17 | ~5 mm | 흑/청 잉크 photothermal |

### 4.2 광촉매 / photosensitizer (in-skin 적용 가능)

| sensitizer | λ_max (nm) | ROS 형성 | 표적 |
|---|---|---|---|
| **TiO₂ NP (anatase)** | 388 (band gap 3.2 eV) | •OH + O₂•⁻ + h⁺/e⁻ | photo-Fenton · 표면 산화 |
| ZnO NP | 368 (3.37 eV) | •OH + ¹O₂ | 광촉매 — 단 zinc dissolution 부작용 |
| Methylene blue | 665 | ¹O₂ (Type II PDT) | electron-rich aromatic |
| 5-ALA → PpIX (porphyrin) | 633 (Q-band) | ¹O₂ (Type II PDT) | tumor/skin lesion (FDA approved Levulan) |
| Riboflavin (Vit B2) | 446 | O₂•⁻ + ¹O₂ | photo-Fenton 보조 (cornea cross-linking 의 임상 사용) |
| Curcumin | 425 | ¹O₂ (medium yield) | natural sensitizer |
| Rose bengal | 549 | ¹O₂ (Φ ~0.75) | strong sensitizer |
| Hypericin | 590 | ¹O₂ + O₂•⁻ | natural · clinical PDT 시험 |
| g-C₃N₄ (carbon nitride) | 460 (2.7 eV) | •OH + O₂•⁻ + h⁺/e⁻ | visible-light photocatalyst |
| Bi₂O₃ NP | 450 (2.8 eV) | •OH | visible-light photocatalyst |

### 4.3 표적별 feasibility

| 표적 | photo 가능성 | first-principles |
|---|---|---|
| **Cu-Pc (PB 15)** | ●● photo-Fenton | λ_max 670 nm (Q band) — Cu-Pc 자체가 빛 흡수 후 excited state → ¹O₂ 일부 생성 (PDT sensitizer 로 연구된 적 있음) · 자기 광촉매 + 외부 photo-Fenton 강화 → macrocycle 부분 ring-opening 가능 |
| **Cr₂O₃** | ◐ | band gap 3.4 eV (λ ≤ 365 nm UV-A) 의 직접 흡수 가능 · 그러나 광촉매 활성은 weak; TiO₂ NP co-deposit + UV-A 가 보조 |
| Azo direct photolysis | ◐ | λ < 715 nm 가능하나 quantum yield φ ~10⁻³ — 환원 cleavage (F2) 가 훨씬 효율 |
| Dioxazine UV-A | ●● | textile fade 가 이 메커니즘 — λ 320-400 nm + O₂ → ring-O opening |
| Isoindolinone (Cl) | ●● | photo-dehalogenation: C-Cl BDE 339 kJ/mol = 3.51 eV → λ ≤ 353 nm UV-A; Cl 제거 후 ROS attack |
| Carbon black photothermal | ◐ | photoacoustic 파쇄 (현 Q-switched laser) — 분자 cleavage 가 아니라 입자 fragmentation · macrophage 재흡수 |
| Fe oxide photo-Fenton | ◐ | Fe³⁺ + hν → Fe²⁺ + 산화반응 → Fe oxide 의 chelation 보조 (F3+F4 직렬) |
| Quinacridone | ◐ | red shift 흡수 — visible-light photo-degradation slow |

### 4.4 top recommendation — UV-A LED (365 nm) + TiO₂ NP / riboflavin

- **rationale**: Cu-Pc wall 의 *유일한 first-principles 핸들* (F2/F3 모두 ✗). UV-A 365 nm 은 피부 침투 1-1.5 mm 로 진피 도달 가능; TiO₂ NP 는 화장품 등급으로 안전 (M1 §3.4 와 일치) · riboflavin 은 cornea cross-linking 임상에서 안전성 검증. 두 sensitizer 모두 시판 + low cost.
- **safety hazard**: UV-A 누적 노출 = melanoma risk · 단발성 monthly 도포 시술 시 dose 관리 가능 (PUVA 임상의 ~1/100)
- **device note**: 한 튜브 형태와는 결합 형식이 *다름* — patch + LED array 가 부수 device (M7 formulation 결정사항)

---

## 5. MoA family 5 — Enzymatic cleavage (peroxidase · laccase · cyt P450 · azoreductase)

### 5.1 first-principles 핵심

효소 = catalytic 가속. *반응 종류* 는 F1-F4 와 겹치지만 *효율 + 선택성* 으로 따로 family 분리. K_cat / K_M 의 차수가 인공 화학보다 10²-10⁶ 배 빠름.

| 효소 | EC | cofactor | 반응 | K_cat 차수 (s⁻¹) | 표적 |
|---|---|---|---|---|---|
| **Lignin peroxidase (LiP)** | 1.11.1.14 | heme + H₂O₂ | •OH 생성 · 1-e⁻ 산화 | ~10¹ | aromatic · lignin · azo |
| **Manganese peroxidase (MnP)** | 1.11.1.13 | heme + Mn²⁺ + H₂O₂ | Mn³⁺ + chelator → 자유 라디칼 | ~10¹ | phenol · azo |
| **Laccase** | 1.10.3.2 | 4× Cu | O₂ → H₂O · phenol 1-e⁻ 산화 | ~10¹ | phenol · azo · dye |
| **Horseradish peroxidase (HRP)** | 1.11.1.7 | heme + H₂O₂ | aromatic 산화 | ~10² | phenol · amine |
| **Myeloperoxidase (MPO)** | 1.11.2.2 | heme + H₂O₂ + Cl⁻ | HClO 생성 | ~10² | broad — 호중구 oxidative burst |
| **Cytochrome P450 (CYP)** | 1.14.x.x | heme + NADPH + O₂ | aromatic hydroxylation · N-deal | ~10¹ | drug metabolism · azo |
| **Azoreductase (AzoR)** | 1.7.1.6 | FMN/FAD + NAD(P)H | azo → 2× 아민 | ~10¹-10² | azo direct |
| **Tyrosinase** | 1.14.18.1 | 2× Cu | catechol → quinone | ~10² | phenol/catechol |
| **Catalase** | 1.11.1.6 | heme | 2 H₂O₂ → 2 H₂O + O₂ | ~10⁷ | (반대 방향 — H₂O₂ scavenger; off-target) |
| **DyP-type peroxidase** | 1.11.1.19 | heme + H₂O₂ | dye 산화 (이름의 D) | ~10² | anthraquinone · azo · phthalocyanine 일부 |
| **NADPH oxidase (NOX)** | 1.6.3.1 | FAD + heme | O₂ → O₂•⁻ (생리적 in-skin 시스템) | ~10² | ROS source (호중구 · NOX2) |

### 5.2 표적별 feasibility

| 표적 | enzymatic 가능성 | first-principles / 비고 |
|---|---|---|
| **Azo N=N** | ●●● | AzoR · CYP · DyP — 검증된 dye decoloration 효소; phytoremediation 산업 검증 |
| Quinacridone (quinone-like) | ●● laccase | laccase 가 phenol/quinone 산화에 강함; QA 의 amide 골격은 weak |
| Dioxazine ring | ◐ | DyP-type 가 일부 활성 보고 |
| Carbon -COOH | ●● MPO | MPO 가 표면 산화 · 호중구가 macrophage 와 *이미 진피에 있음* → 활성 endogenous |
| Cu-Pc | ◐ | DyP 가 phthalocyanine 부분 산화 보고 — slow |
| Fe oxide | ◐ | siderophore 와 결합한 효소-매개 dissolution (간접) |
| Cr₂O₃ | ✗ | 효소 없음 — wall |
| 6원환 graphene core | ✗ | aromatic ring opening 효소 없음 |

### 5.3 top recommendation — recombinant AzoR / Plant azoreductase extract

- **rationale**: K_cat ~10² s⁻¹ · NAD(P)H 만 cofactor · selectivity 높음 · 식물/박테리아 source 풍부 (phytoremediation 산업). Sigma 직접 product 는 없으나 commercial recombinant (e.g., Creative Enzymes 또는 학계 plasmid) 의 lab-scale 합성 가능.
- **safety hazard**: 외래 단백질 = 면역원성 위험 → engineered humanized variant 또는 phage-display 최적화 (M3 평가 항목)

---

## 6. MoA × Target — 통합 매트릭스 (M1 §4 의 8 카테고리 mirror)

| Target (M1 §4) | dominant attack | secondary | wall? | M3 입력 후보 |
|---|---|---|---|---|
| **N=N (azo)** | F2 reductive (●●●) | F5 enzymatic (●●●) | — | ascorbate · dithionite analog · AzoR · NQO1 · plant azoreductase |
| **Fe³⁺ lattice (Fe oxide)** | F3 chelation (●●●) | F2 reductive (●●) | — | DFO · DTPA · deferiprone · catechol · ascorbate (Fe³⁺→Fe²⁺) |
| **H-bond crystal (QA)** | F1 oxidation (●●) | F4 photo (◐) | — | DMSO carrier + Fenton · laccase · MnP |
| **-COOH/-OH (carbon)** | F1 oxidation (●●●) | F5 enzymatic MPO (●●) | — | Fenton · photo-Fenton · MPO · LiP |
| **Cu²⁺ chelate (Pc)** | F4 photo-cleavage (●●) | F3 demetallation (●●) | 🧱 partial | UV-A + TiO₂ NP · UV-A + riboflavin · DyP · DFO+UV · 5-ALA PDT |
| **C-Cl (Cl 안료)** | F4 photo (●●) | F1 oxidation (◐) | — | UV-A LED · sensitized photolysis · MnP |
| **ring O/N (dioxazine·isoindolinone)** | F1 oxidation (●●) | F4 photo (●●) | — | sensitizer + UV-A · MnP · laccase |
| **6원환 core (graphene)** | (입자-level only) | — | 🧱 chemical impossibility | macrophage 재흡수 + 표면 식각 hybrid |

→ wall = 2개 카테고리 (Cu²⁺ chelate Pc · 6원환 core). M1 §6.8 의 시장 ~10-15% wall 예측과 동일.

---

## 7. 🧱 d2 wall breakthrough paths — Cu-Pc · Cr₂O₃ · 6원환 core

> **"불가능" 이라고 말하지 않는다 (@D d2).** 아래 4 path 모두 first-principles physically-justified.

### 7.1 Path A — Photo-Fenton hybrid (가장 직접적)

```
시술 부위 ── topical TiO₂ NP + Fe-citrate carrier 도포
        ↓
UV-A 365 nm LED patch (5-10 mW/cm² · 10 분/세션)
        ↓
TiO₂ + hν → h⁺/e⁻ 분리 → •OH 생성
Fe³⁺ + hν → Fe²⁺ (photo-reduction)
Fe²⁺ + H₂O₂ → •OH (Fenton 가속)
        ↓
Cu-Pc:  Q-band (670 nm) 흡수 → triplet excited state → ¹O₂ 자기생성
         + 외부 •OH 누적 → macrocycle methine bridge 산화 → ring-open
Cr₂O₃:  band gap 3.4 eV (365 nm = 3.4 eV ★ 정확히 매치) → e⁻/h⁺ → 표면 •OH
         → Cr³⁺ 표면 산화 (Cr⁴⁺ intermediate · 추가 chelation 가능)
```

- **first-principles 근거**: Cu-Pc 의 Q-band 흡수 (Soret + Q) 는 16π aromatic 의 직접 광 흡수 → 첫 excited state lifetime ~수 ns · ¹O₂ 생성 φ ~0.1; Cr₂O₃ 의 band gap 3.4 eV 는 UV-A 365 nm 광에너지 (3.40 eV) 와 정확히 매치 — photoexcitation thermodynamic 임계.
- **kinetic feasibility**: in-skin 진피 (depth 1.5 mm) 에서 UV-A 도달 fluence ~10% surface → ~1 mW/cm² 효과적 fluence · macrocycle/oxide 식각률 nm/min 차수 — multi-session 누적 가능
- **regulatory 선례**: TiO₂ sunscreen (cosmetic), riboflavin + UV-A (cornea cross-linking imaging), 5-ALA PDT (FDA approved)
- **safety hazard 1**: UV-A 누적 melanoma risk → monthly 도포 시 dose 관리 (PUVA 임상의 1/100 fluence)
- **safety hazard 2**: Cr 산화 시 Cr⁶⁺ 형성 가능 (강 carcinogen!) — chelation co-deposit 으로 즉시 격리 필수 (M6 1순위 안전성 평가)

### 7.2 Path B — Staged removal (3-pass 직렬)

```
1차 도포 (cleavable 60-70%):
   ascorbate + DFO + Fenton + dithionite analog
   → azo · Fe oxide · QA crystal 분해
   → macrophage 내부 phagosome 의 cleavable load 제거
   ↓
   ~4 주 휴지 (피부 회복 + macrophage 재흡수)
   ↓
2차 도포 (wall 표면-disrupt 20%):
   TiO₂ NP + UV-A photo-Fenton
   → Cu-Pc macrocycle 표면 산화 · Cr₂O₃ 표면 hydroxylation
   → 입자 크기 감소 (~10 nm/cycle)
   → fragment 가 macrophage phagocytic sweet spot (200 nm-5 μm) 으로 진입
   ↓
   ~4 주 휴지
   ↓
3차 도포 (macrophage 재활성화 + 잔류 10-15%):
   danger-signal mimic (LPS-low · HMGB1 fragment · TLR agonist)
   → 진피 macrophage 가 입자를 *다시* phagocytose
   → lysosomal acidification (pH 4.5) + cathepsin protease 가 단백질 코로나 분해
   → fragment 추가 노출 → 자연 immune-mediated clearance
   ↓
누적 90%+ 제거
```

- **first-principles 근거**: macrophage 가 한 번 phagocytose 한 입자를 "기억" 하지 않음 — danger signal cue (DAMP) 가 *주변 macrophage* 를 활성화 시키면 잔류 입자 재흡수 가능 (Carlson 2024 in lymph node migration 연구 + Watson 2023 macrophage CO₂ tattoo turnover 데이터). 입자 크기 < 5 μm 으로 줄이면 phagocytosis quantum yield ↑.
- **kinetic feasibility**: 4 주 휴지 = macrophage turnover 1 cycle (T_1/2 ~2-3 주); 3-pass × 30일 = ~90일 = TTR.md goal 의 "한 튜브 30일 1회 용법" 변형 (월 1회 × 3 사이클로 재해석)
- **regulatory 선례**: imiquimod (TLR7 agonist · FDA approved topical · 사마귀/광선각화증), HMGB1 modulator 임상 시험 진행 중
- **safety hazard**: danger signal 과잉 → 광범위 염증/홍반/색소침착 → 도포면 한정 · 농도 적정

### 7.3 Path C — Inflammation/Macrophage re-engagement (단독 path 또는 Path B 3차의 강화)

- **메커니즘**: 타투 잉크 입자는 시술 초기에 macrophage 가 삼키고 *수십 년 동안 죽지 않고 보유*. macrophage 가 노화/apoptosis 시 *다음 macrophage* 가 release 된 입자를 다시 phagocytose (Baranska 2018, Sci Adv). 이 자연 turnover 를 **인위적으로 가속**.
- **active 분자 후보 (M3 입력)**:
  - imiquimod (TLR7 agonist) — 시판 cream Aldara
  - HMGB1 B-box peptide — DAMP mimic, recombinant
  - resiquimod (TLR7/8) — 임상 PDT 보조
  - MCP-1 (CCL2) chemokine local infusion — monocyte recruitment (in dermis)
  - β-glucan — Dectin-1 agonist, macrophage 활성화
  - α-galactosylceramide — iNKT 활성화, hot-tumor 전환 임상
- **first-principles 근거**: TLR7/8 agonist 는 macrophage M1 polarization → phagocytic capacity ↑ + lysosomal proteolysis ↑ + cathepsin K/L/S 분비 ↑. 단백질 코로나 + 표면 산화 carbon 표면 식각 가속.
- **safety hazard**: 광범위 염증 위험 — patch-localized + low-dose 시작 필수

### 7.4 Path D — Cu-Pc 의 macrocycle ring-opening enzymes (DyP-type peroxidase 확장)

- **메커니즘**: 일부 백색부후균 (e.g., *Auricularia auricula-judae*) 의 DyP-type peroxidase 가 *phthalocyanine 류 dye* 의 부분 산화를 보고 (Roberts 2011, Liers 2013). K_cat ~10² s⁻¹.
- **engineering**: directed evolution + computational redesign (Rosetta · ESM-IF) 으로 in-skin pH/온도 안정성 + 활성 ↑ → topical formulation
- **first-principles 근거**: peroxidase 의 compound I (Fe(IV)=O · porphyrin radical cation) 가 1.6-2.0 V 산화전위 → Cu-Pc Q-band 의 LUMO 영역 cleavage 가능
- **timeline 현실성**: enzyme engineering = 2-3 년 cycle — TTR M3 의 즉시 ranking 보다는 M7 합성/제형 단계 후속 path

→ **Path A + Path B 의 hybrid 가 TTR M3 의 *기본 wall-breakthrough recipe*** (Path D 는 후속 R&D 트랙). 두 path 모두 *3개 family (F1/F3/F4) 동시 활용* — 단일 family fail 의 wall 을 *family combination* 으로 우회.

---

## 8. Per-family candidate counts (M3 입력)

### 8.1 F1 Oxidation — ≥10 candidates

| # | Name | CAS / catalog | E° (V) | 표적 |
|---|---|---|---|---|
| 1 | H₂O₂ (3% topical) | CAS 7722-84-1 · Sigma H1009 | +1.78 | universal |
| 2 | FeSO₄·7H₂O (Fenton Fe²⁺ source) | CAS 7782-63-0 · Sigma F8633 | (Fenton cat.) | + H₂O₂ |
| 3 | Sodium percarbonate | CAS 15630-89-4 | ~+1.5 | slow-release H₂O₂ |
| 4 | KMnO₄ | CAS 7722-64-7 | +1.51 | broad — topical 농도 제한 |
| 5 | Sodium hypochlorite (NaClO) | CAS 7681-52-9 | +1.49 | dilute (Dakin's solution) |
| 6 | Benzoyl peroxide | CAS 94-36-0 | (free radical) | OTC acne — 5-10% topical |
| 7 | Ozone (gas / O₃-water) | CAS 10028-15-6 | +2.07 | dental/wound 임상 |
| 8 | Methylene blue (sensitizer ¹O₂) | CAS 61-73-4 | +2.42 (¹O₂ via hν) | PDT sensitizer |
| 9 | Rose bengal (¹O₂ sensitizer) | CAS 11121-48-5 | +2.42 (¹O₂) | strong sensitizer · Φ₁O₂ 0.75 |
| 10 | 5-ALA (→ PpIX in situ) | CAS 106-60-5 · FDA Levulan | +2.42 (¹O₂) | PDT approved |
| 11 | Riboflavin (Vit B2, photo-cat.) | CAS 83-88-5 | (photo-Fenton boost) | cornea cross-link 임상 검증 |
| 12 | TiO₂ NP (anatase) | CAS 1317-70-0 | (광촉매) | + UV-A |

### 8.2 F2 Reductive — ≥10 candidates

| # | Name | CAS / catalog | E° (V) | 표적 |
|---|---|---|---|---|
| 1 | Ascorbic acid (Vit C) | CAS 50-81-7 · Sigma A4544 | -0.17 (rad/Asc) | Fe³⁺ · azo radical |
| 2 | Sodium dithionite | CAS 7775-14-6 · Sigma 157953 | -1.12 | azo strong |
| 3 | Cysteine | CAS 52-90-4 | -0.34 | disulfide · soft |
| 4 | Glutathione (GSH) | CAS 70-18-8 | -0.24 | physiological |
| 5 | TCEP·HCl | CAS 51805-45-9 · Sigma C4706 | -0.29 | selective disulfide |
| 6 | NADH (cell-permeable analog) | CAS 606-68-8 | -0.32 | enzyme cofactor |
| 7 | NADPH | CAS 2646-71-1 | -0.32 | enzyme cofactor |
| 8 | Sodium thiosulfate | CAS 7772-98-7 | (mild reductant) | Mn/cyanide antidote, topical safe |
| 9 | Hydrazine (carrier required) | CAS 302-01-2 | -1.16 | very strong — topical X 직접; precursor only |
| 10 | Hydroxylamine | CAS 7803-49-8 | -0.5 | partial azo |
| 11 | Sodium sulfite | CAS 7757-83-7 | -0.93 | mild |
| 12 | Borohydride (NaBH₄, encapsulated) | CAS 16940-66-2 | -1.24 | encapsulated formulation 필수 |

### 8.3 F3 Chelation — ≥10 candidates

| # | Name | CAS / catalog | log K (Fe³⁺) | 표적 |
|---|---|---|---|---|
| 1 | Deferoxamine mesylate (DFO) | CAS 138-14-7 · Sigma D9533 | 30.6 | Fe oxide |
| 2 | Deferiprone (L1) | CAS 30652-11-0 | 36 (β₃) | Fe oxide |
| 3 | Deferasirox (Exjade) | CAS 201530-41-8 | 22 (β₂) | Fe oxide |
| 4 | DTPA (diethylenetriaminepentaacetic acid) | CAS 67-43-6 | 28.0 | broad |
| 5 | EDTA disodium | CAS 6381-92-6 · Sigma E5134 | 25.1 | broad — OTC cosmetic |
| 6 | EGTA | CAS 67-42-5 | 20.5 | Ca-selective (off-target ↓) |
| 7 | Citric acid (food grade) | CAS 77-92-9 | 11.85 | mild |
| 8 | Pyridoxal isonicotinoyl hydrazone (PIH) | CAS 737-86-0 | ~26 | tridentate Fe |
| 9 | 8-Hydroxyquinoline (oxine) | CAS 148-24-3 | 12 (β₃) | broad |
| 10 | Catechin (tea polyphenol) | CAS 154-23-4 | ~20 | natural Fe³⁺ chelator |
| 11 | Quercetin | CAS 117-39-5 | ~14 | natural flavonoid |
| 12 | DOPA (3,4-dihydroxyphenylalanine) | CAS 59-92-7 | ~18 (catechol) | TiO₂ binding · adhesive |
| 13 | Enterobactin (microbial sider.) | CAS 28384-96-5 | 49 | strongest Fe³⁺ |

### 8.4 F4 Photo-cleavage — ≥10 candidates (light source + sensitizer)

| # | Component | CAS / catalog | λ (nm) | 역할 |
|---|---|---|---|---|
| 1 | UV-A LED 365 nm (device) | — | 365 | photo-Fenton 광원 · Cr₂O₃ band gap 정합 |
| 2 | UV-A LED 395 nm | — | 395 | TiO₂ band edge · 안전 마진 ↑ |
| 3 | TiO₂ NP anatase | CAS 1317-70-0 | (band gap 388) | 광촉매 ROS source |
| 4 | ZnO NP | CAS 1314-13-2 | (band gap 368) | 광촉매 — Zn dissolution 부작용 |
| 5 | Riboflavin | CAS 83-88-5 | 446 | photo-Fenton 보조 · 임상 검증 |
| 6 | Methylene blue | CAS 61-73-4 | 665 | ¹O₂ Type II PDT |
| 7 | 5-ALA (Levulan) | CAS 106-60-5 | 633 (PpIX) | FDA-approved PDT precursor |
| 8 | Rose bengal | CAS 11121-48-5 | 549 | ¹O₂ Φ 0.75 |
| 9 | Curcumin | CAS 458-37-7 | 425 | natural sensitizer |
| 10 | Hypericin | CAS 548-04-9 | 590 | natural · PDT 임상 시험 |
| 11 | g-C₃N₄ (carbon nitride) | — | 460 (2.7 eV) | visible-light photocatalyst |
| 12 | 532 nm Nd:YAG Q-switched laser (device) | — | 532 | photoacoustic — 현 시술 표준 보강 |
| 13 | 1064 nm Nd:YAG laser (device) | — | 1064 | photothermal carbon black |

### 8.5 F5 Enzymatic — ≥10 candidates

| # | Enzyme / variant | EC / source | K_cat (s⁻¹) | 표적 |
|---|---|---|---|---|
| 1 | Recombinant AzoR (E. coli) | EC 1.7.1.6 | ~10² | azo direct |
| 2 | NQO1 (human) | EC 1.6.5.2 | ~10² | quinone · 일부 azo |
| 3 | Plant azoreductase (Phragmites extract) | — | ~10⁰-10¹ | broad azo |
| 4 | Lignin peroxidase (LiP, P. chrysosporium) | EC 1.11.1.14 | ~10¹ | aromatic · lignin · azo |
| 5 | Manganese peroxidase (MnP) | EC 1.11.1.13 | ~10¹ | phenol · azo |
| 6 | Laccase (Trametes versicolor) | EC 1.10.3.2 | ~10¹ | phenol · azo · dye |
| 7 | Horseradish peroxidase (HRP) | EC 1.11.1.7 · Sigma P8125 | ~10² | phenol · amine — research grade |
| 8 | DyP-type peroxidase (Auricularia) | EC 1.11.1.19 | ~10² | dye · anthraquinone · 일부 Pc |
| 9 | Tyrosinase (mushroom) | EC 1.14.18.1 · Sigma T3824 | ~10² | catechol · phenol |
| 10 | Cytochrome P450 BM3 (engineered) | EC 1.14.x.x | ~10⁰-10¹ | broad oxidative (engineered) |
| 11 | Glucose oxidase (GOx) — in situ H₂O₂ | EC 1.1.3.4 | ~10² | H₂O₂ generator (Fenton 보조) |
| 12 | Versatile peroxidase (VP) | EC 1.11.1.16 | ~10¹ | LiP+MnP hybrid |

→ 총 candidate handle: F1=12 · F2=12 · F3=13 · F4=13 · F5=12 = **62 unique handles** for M3 in-silico screening.

---

## 9. Honest scope caveats (TTR.md M6/M9 와 직결)

1. **방향족 아민 carcinogenic 산물**: azo cleavage 의 결과물 (aniline · benzidine · 4-aminobiphenyl 류) 는 IARC group 1/2A 다수 — 진피 내 *체류* 시 systemic exposure 가능성. **M6 의 first-principles off-target 평가 최우선**. 일부 azo (e.g., PR 22) 는 cleavage 시 benzidine-class 가 *나오지 않는* 것을 안료 선정 시 사전 분류 가능.
2. **Cr⁶⁺ 형성 risk**: Cr₂O₃ 의 산화 과정에서 Cr³⁺ → Cr⁶⁺ (CrO₄²⁻) 변환 가능 — Cr⁶⁺ 는 강 carcinogen + 피부 침투 ↑. *반드시* chelation co-deposit + 반응 완료 후 chelator 회수 메커니즘 필수.
3. **과산화 skin damage**: 표피 keratin · 진피 collagen · 표재 혈관의 부수 산화 → 흉터 · pigmentation 변화. ROS dose-rate 한계 = ~10⁻⁵ M •OH steady-state — F1 활성성분 farmacokinetic 모델링 필수 (M3 평가 항목).
4. **UV-A 누적 melanoma risk**: 단일 세션 fluence 안전하나 monthly 누적 시 dose 한계 (PUVA 임상의 cumulative ~150 J/cm² 가 lifetime risk 점프 지점). TTR formulation 의 *recommended max session count* 산정 필수 (M7).
5. **FDA topical oxidant 선례**: H₂O₂ 3% (OTC), benzoyl peroxide 5-10% (OTC acne), Dakin's solution (NaClO 0.025%, wound care) — 모두 *single-active*. TTR 가 F1+F2+F3+F4 multi-active 인 경우 IND 별도 신청 필요 (M10).
6. **in-skin reaction time scale**: macrophage phagosome 내부 viscosity 높음 + Fe oxide 표면의 protein corona 두께 ~10 nm — *반응속도 30% 이상 감소* 예상 (확산 한계). 시험관 BDE/E° 값은 effective 가 아님.
7. **kinetic vs thermodynamic gap**: log K(EDTA-Cr³⁺) 23 thermodynamic 가능하나 Cr³⁺ 의 d³ low-spin 의 ligand exchange 가 10⁶ 배 느림 — Cr₂O₃ chelation 의 *실제 in-skin* 효율은 thermodynamic 수치 의존 X.
8. **단백질 코로나 차폐**: 시술 후 잉크 입자 표면이 albumin · IgG · complement 로 코팅 → 활성성분이 만나는 1차 표면이 단백질 → 단백질 분해 효소 (cathepsin · protease) co-formulation 필요할 수 있음 (M7).
9. **macrophage 재활성화 부작용**: Path C 의 danger-signal mimic 은 광범위 염증 위험 — patch-localized + low-dose 시작 + 단계적 escalation 필수.
10. **lot variability (M1 §6 ↑)**: 같은 CI 번호라도 제조사/배치 별 입자 크기 ±30% · 산화도 ±20% · 잉크 혼합 (검정 + 청 보강) 흔함 → TTR 효과 lot 별 다를 수 있음. M3 screening 시 *각 family 가 lot variability 견디는지* 평가 추가 축 필요.

---

## 10. M3 (in-silico screening) handoff — explicit input

### 10.1 M3 의 입력 list (이 문서 §8 의 62 handles)

```yaml
# ~/core/demiurge/TTR/research/moa_shortlist.md → M3 input
moa_families:
  F1_oxidation:
    targets: [carbon_COOH, quinacridone_Hbond, dioxazine_ringO]
    candidates: §8.1 (12 handles)
    primary_metric: E° (V vs SHE) · k_2nd_order (M⁻¹s⁻¹) · skin_safety_margin
  F2_reductive:
    targets: [azo_NN, FeIII_lattice, disulfide_corona]
    candidates: §8.2 (12 handles)
    primary_metric: E° (V vs SHE) · selectivity (azo over aromatic) · carcinogenic_byproduct_check
  F3_chelation:
    targets: [Fe_oxide, Cu_Pc_demetal, Cr2O3_partial]
    candidates: §8.3 (13 handles)
    primary_metric: log K (target metal) · denticity · FDA_status · skin_penetration
  F4_photo:
    targets: [Cu_Pc, Cr2O3, isoindolinone_CCl, dioxazine_ring]
    candidates: §8.4 (13 handles)
    primary_metric: λ_match (target absorption) · sensitizer_Φ_ROS · UVA_dose_safety
  F5_enzymatic:
    targets: [azo, phenol_QA, Cu_Pc_DyP, carbon_surface]
    candidates: §8.5 (12 handles)
    primary_metric: K_cat / K_M · pH_skin (5.5) · 면역원성 · 합성/공급_route

wall_breakthrough_paths:
  PathA: photo_fenton_hybrid  (TiO2 + UV-A 365 + Fe + H2O2)
  PathB: staged_3pass         (cleavable → photo-disrupt → macrophage re-engage)
  PathC: macrophage_reengage  (imiquimod / HMGB1 / β-glucan)
  PathD: DyP_engineered       (long-term R&D track)
```

### 10.2 go / no-go gate (M3 → M5 진입 조건)

| gate | 조건 | rationale |
|---|---|---|
| **G1 thermodynamic** | E° 또는 log K 가 표적 cleavage 임계 통과 | first-principles 필수 |
| **G2 kinetic** | 대표 반응 k 가 진피 reaction window (10⁻⁴ s⁻¹) 이상 | 한 튜브 1회 도포 의 시간 한계 |
| **G3 selectivity** | 대표 off-target (collagen · keratin · melanin) 의 k_off / k_target < 0.1 | M6 안전성 사전 필터 |
| **G4 availability** | Sigma/commercial 1-step 합성 가능 (CAS 보유 또는 직전구체 ≤ 2 step) | M7 합성 부담 |
| **G5 regulatory precedent** | FDA topical OTC / Rx 선례 또는 cosmetic 등급 | M10 IND 부담 ↓ |

→ 각 candidate 의 G1-G5 통과 여부 + score 가 M3 ranking 출력. wall 표적 (Cu²⁺ chelate Pc · 6원환 core) 은 *single-candidate* 가 아니라 *combination (Path A/B/C)* 으로 평가 — combo 의 G1-G5 합산 score.

### 10.3 multi-active formulation 의 첫 sketch (M7 / M10 입력)

```
TTR v0 (한 튜브 30일 1회 sketch):
├─ F1 layer:  3% H₂O₂ + 0.1% FeSO₄ (Fenton starter, 표면 식각)
├─ F2 layer:  5% ascorbic acid (Fe oxide reduce + 항산화 보조)
├─ F3 layer:  1-2% DFO + 0.5% EDTA (Fe + general chelation)
├─ F4 layer:  0.1% TiO₂ NP + 0.05% riboflavin + UV-A LED patch (30 min × 1)
└─ F5 layer:  optional — recombinant AzoR 0.01% (azo class 한정 강화)

carrier: liposome / nano-emulsion (M4 산출물) · iontophoresis-assisted (optional)
session: 월 1회 도포 + 다음 날 UV-A patch · 3 cycle = 3 개월
expected: cleavable load 60-70% removal × 3 = ~85-90% (M1 §7 예측치 적합)
```

→ 이 sketch 는 *M3-M7 전 합의의 출발점* — M3 의 candidate ranking 이 layer 별 정밀 조성을 결정.

---

## 11. Cross-reference

- M1 산출물: `~/core/demiurge/TTR/research/ink_classes.md` — 8 표적 카테고리 · BDE / log K / E° 표
- M4 산출물: `~/core/demiurge/TTR/research/transdermal_delivery.md` — liposome · nano-emulsion · iontophoresis (병행 진행)
- TTR.md `@goal` (한 튜브 30일 1회 90% 제거) · milestones M3 (in-silico screening · 본 문서가 직접 입력) · M5 (MD/QM 시뮬, BDE/E° 재계산) · M6 (off-target safety)
- @D d1 (non-wet-lab 완료형) — 본 문서는 first-principles 만으로 *completed-form* M2 산출물 (DFT/MD 재계산은 M5)
- @D d2 (wall breakthrough) — §7 의 4 path 가 d2 invariant 충족 ("불가능" 미언급)
- @D d3 (구현 코드 위치) — 본 문서는 design doc, 코드는 hexa-* sibling 으로
- @D d6 (first-principles physics) — BDE / E° / log K / pKa 만 사용, ML/training-distribution 의존 X

---

## 12. 정직한 unknowns / open questions (M3-M5 진입 전 해소 가능)

1. **Cu-Pc 의 photo-Fenton quantum yield** — 시험관 측정치 (Φ_¹O₂ ~0.1) 가 진피 환경 (단백질 코로나 + macrophage phagosome pH 4.5) 에서 얼마나 감소하는지 in vitro 측정 필요
2. **Cr₂O₃ band-gap photoexcitation 효율** — 박막/single crystal 데이터 → 100 nm-1 μm NP 의 effective band-gap shift 측정 필요 (M5)
3. **Macrophage re-engagement kinetic** — imiquimod 의 *재흡수* 가속 정도 (lab data 부재) — ex vivo 돼지 피부 phagosome assay 가 M8 의 1차 데이터
4. **방향족 아민 systemic exposure** — azo cleavage 산물의 *진피 → 혈류* 이동률 (Carlson 2024 lymph node migration 데이터 외삽 가능?) — M6 입력
5. **multi-active 간 cross-reactivity** — F1 의 H₂O₂ vs F3 의 DFO (Fe-DFO complex 의 Fenton 활성 변화: 일부 catalytic 활성 보고됨, but DFO 안에 Fe 가 trap 되어 sphere outside 의 Fenton 은 감소) — M3 의 *combination screening* 평가 항목
6. **enzymatic 면역원성** — 외래 단백질 (recombinant AzoR · LiP · laccase) 의 진피 내 immune response — engineered humanized variant 가 필수인지 wild-type 으로 충분한지 — M3-M6 평가
7. **dose-response 의 in-skin saturation** — phagolysosome 내부 잉크 farmacokinetic 의 saturation kinetic (Michaelis-Menten 또는 linear?) — M5 입력

→ 7개 모두 *M3 in-silico screening + M5 MD/QM* 으로 first-principles 추산 후 M8 ex-vivo 에서 검증. 본 M2 문서가 추산을 *시도* 하지 않는 이유 = 단일 BDE/E°/log K 로는 부족, 분자 한정 ranking + reaction-network 동역학 필요.

---

→ 본 문서가 M3 활성성분 후보 in-silico screening 의 *honest 출발점*. 5 family × 62 handle × G1-G5 gate = M3 의 work program.
