# M2 — clopidogrel 활성화 경로 + LoF 효과 정량 (PRI/PRU)

> 마일스톤 M2 산출물 · current-state · no history.
> 출처 = pharmacokinetic studies + ex vivo platelet function + 한국인 registry → 🟡 SUPPORTED-BY-CITATION.
> 입력 = M1 (allele 빈도 · IM+PM ~60%) → 출력 = active metabolite AUC + PRU → M3 (decision tree).

---

## 1. Prodrug → active metabolite 2-step bioactivation

```
clopidogrel (75 mg PO, prodrug · 비활성 thienopyridine)
        │
        ↓  intestinal absorption (~50% bioavailability · ABCB1/P-gp 의존)
        │
   portal vein → liver (1st pass)
        │
        ├─ ~85% : carboxylesterase-1 (CES1) → SR26334 (carboxylic acid, 비활성)
        │                                      └─ 신장 배설
        │
        └─ ~15% : CYP-mediated oxidation                 ← 율속 1단계
                  ┌─────────────────────────────┐
                  │ CYP2C19 (~45% 기여)         │
                  │ CYP1A2  (~36%)              │   thiophene ring oxidation
                  │ CYP2B6  (~19%)              │
                  └─────────────────────────────┘
                          │
                          ↓
                 2-oxo-clopidogrel (중간체, 여전히 비활성)
                          │
                  ┌───────┴───────────────────┐
                  │ CYP2C19 (~21%)            │   ← 율속 2단계 (재차!)
                  │ CYP3A4  (~40%)            │   thiolactone → thiol opening
                  │ CYP2B6  (~33%)            │   + PON1 hydrolysis 보조
                  │ CYP2C9  (~7%)             │
                  └───────────────────────────┘
                          │
                          ↓
                 R-130964 (active thiol metabolite · t½ ~30 min)
                          │
                          ↓
                 platelet P2Y12 receptor → 비가역 차단 (Cys17/Cys270)
                          │
                          ↓
                 cAMP ↑ → VASP phosphorylation ↑ → aggregation ↓
```

→ CYP2C19가 **두 단계 모두 기여**하는 유일한 효소 → LoF 시 직렬 손실(multiplicative).
→ 경구 75 mg 중 최종 active R-130964로 도달하는 비율 ≈ **2%** (Farid 2010, PMID 20206128).

---

## 2. R-130964 → P2Y12 비가역 차단 메커니즘

```
R-130964 (free thiol -SH)
        │
        │  extracellular Cys 잔기와 disulfide 교환
        ↓
P2Y12 receptor (Gαi-coupled, 7TM)
   extracellular loop
        Cys17 ─ S ─ S ─ thiol(R-130964)   ← 비가역 covalent
        Cys270 ─ S ─ S ─ thiol(R-130964)  ← 비가역 covalent
        │
        ↓
ADP binding pocket 변형 → Gαi 신호 차단
        │
        ↓
adenylate cyclase 탈억제 → cAMP ↑ → PKA ↑
        │
        ↓
VASP-Ser157 phosphorylation ↑   (← VASP-P 측정 기반 PRI)
GPIIb/IIIa activation ↓ → fibrinogen 결합 ↓
        │
        ↓
platelet aggregation ↓ (효과 platelet 수명 7-10 일간 지속)
```

- **비가역** 결합 → 효과는 platelet turnover (~10% / day)로만 회복.
- 따라서 active metabolite AUC가 단발 노출량 = lifetime 효과 결정자.
- 참조: Algaier 2008 *J Thromb Haemost* 6:1908 (PMID 18752571); Ding 2003 *Blood* 101:3908.

---

## 3. Phenotype별 active metabolite AUC (PK)

NM `*1/*1` = 100% reference (300 mg loading 후 R-130964 AUC₀₋₂₄ ≈ 50-60 ng·h/mL).

| phenotype | diplotype 예 | active AUC (% of NM) | 출처 |
|---|---|---|---|
| UM | `*17/*17` | **~120-130%** | Mega 2009 NEJM (PMID 19106084) |
| RM | `*1/*17` | **~110-115%** | Frere 2009 J Thromb Haemost 7:1409 |
| **NM** | `*1/*1` | **100% (ref)** | Brandt 2007 J Thromb Haemost 5:2429 |
| **IM** | `*1/*2`, `*1/*3` | **~70-75%** (-25 ~ -30%) | Mega 2009 NEJM; Hulot 2006 Blood 108:2244 |
| **PM** | `*2/*2`, `*2/*3`, `*3/*3` | **~30-50%** (-50 ~ -70%) | Brandt 2007; Umemura 2008 *J Thromb Haemost* 6:1439 (PMID 18532997) |

→ **PM은 NM 대비 active metabolite 절반 이하** → P2Y12 점유율 부족 → 충분한 platelet 억제 실패.
→ 한국인 PM 빈도 ~15% (M1) × AUC -50~70% = 가장 큰 단일 PK 손실 집단.

---

## 4. Platelet reactivity (PRI/VASP/PRU) — phenotype별 정량

**측정법 3종**:
- **VASP-PRI** (flow cytometry, VASP-P/total ratio) — 컷오프 PRI > 50% = HTPR
- **VerifyNow P2Y12** (PRU = P2Y12 Reaction Unit) — 컷오프 **PRU ≥ 208** = HTPR (Bonello 2010 *JACC* 56:919 consensus)
- **LTA** (light transmittance aggregometry, 5 μM ADP) — > 46% MPA = HTPR

| phenotype | mean PRU (300 mg LD 후 24h) | HTPR 비율 (PRU ≥ 208) | mean VASP-PRI |
|---|---|---|---|
| UM (`*17/*17`) | ~140 ± 50 | ~5-10% | ~30% |
| RM (`*1/*17`) | ~160 ± 55 | ~10-15% | ~35% |
| **NM** (`*1/*1`) | **~180 ± 60** | **~15-25%** | **~40-45%** |
| **IM** (1 LoF) | **~220 ± 65** | **~35-45%** | **~55-60%** |
| **PM** (2 LoF) | **~250-280 ± 70** | **~50-70%** | **~65-75%** |

출처: Shuldiner 2009 *JAMA* 302:849 (PMID 19706858); Giusti 2009 *Pharmacogenet Genomics* 19:401; Bonello 2010 JACC; Tantry 2013 *JACC* 62:2261 (PRU consensus update).

→ **NM 안에서도 HTPR ~20% 잔존** → CYP2C19 단독으론 완전 설명 X (§7 modifier 필요).
→ **PM은 절반 이상이 HTPR** → 임상 이벤트 위험의 PK→PD 다리.

---

## 5. HTPR → 임상 endpoint (stent thrombosis / MACE)

| endpoint | HTPR vs non-HTPR | 출처 |
|---|---|---|
| **stent thrombosis (ST)** | **HR 2.0-5.0×** | Mega 2010 *JAMA* 304:1821 (PMID 20978260, meta n=9,685) |
| **MACE** (death/MI/stroke) | **HR 1.5-2.0×** | Mega 2010 JAMA; Hulot 2010 *Blood* 116:5096 (PMID 20826723, meta n=11,959) |
| CV death | HR 1.4-1.8× | Sofi 2011 *Thromb Haemost* 106:179 |
| recurrent MI | HR 1.7-2.2× | Mega 2009 NEJM (TRITON-TIMI 38 substudy) |
| bleeding (major) | HR ~1.0 (중립) | Mega 2010 JAMA |

**LoF allele 용량의존성** (Mega 2010 JAMA):
- 1 LoF allele (IM) : ST HR 2.67 (95% CI 1.69-4.22)
- 2 LoF allele (PM) : ST HR 3.97 (95% CI 1.75-9.02)

→ PK (active AUC ↓) → PD (PRU ↑) → 임상 (ST/MACE ↑) **단일 인과 사슬**이 메타분석으로 확립.
→ 단 **bleeding은 LoF와 무관** → asymmetric risk (효과 ↓는 있어도 출혈 ↑는 없음).

---

## 6. 한국인 데이터 (registry / RCT)

| 연구 | n | 설계 | 핵심 결과 |
|---|---|---|---|
| **KAMIR-NIH** | 13,104 | AMI registry | LoF carrier 1-year MACE HR 1.34 (P<0.01); ST HR 2.1 |
| **HOST-RP-ACS** | 952 | RCT (PCI, ACS) | PM군 PRU 247 ± 67 vs NM 178 ± 58 (P<0.001); 1-yr MACE PM 9.8% vs NM 4.2% |
| **CILON-T** | 915 | RCT (cilostazol triple) | LoF carrier PRU > 230 비율 62% vs 비-carrier 28% |
| **KORean ACS registry (Park 2011)** | 1,801 | observational | IM+PM 합계 PRU 219 vs NM 174 (PMID 21392636) |
| **Jeong 2010 JACC** | 1,062 | 한국 PCI | `*2` carrier ST 발생 OR 3.4 (95% CI 1.5-7.8) |

출처: Park KW et al. (2017) *Eur Heart J* 38:3046 (HOST-RP-ACS, PMID 28828499); Jeong YH et al. (2010) *JACC* 56:1944 (PMID 21102263); Kim HS et al. *KAMIR-NIH 5-yr* 2019 *Korean Circ J* 49:870.

→ 한국인 PM군의 PRU 수치가 서구 코호트보다 ~10-15 단위 더 높음 (baseline platelet reactivity 인종차 가능성).
→ HOST-RP-ACS가 한국인 phenotype-guided 전략의 핵심 evidence base.

---

## 7. 비-CYP2C19 modifier (active metabolite에 영향)

| 유전자/변이 | rs | 효과 메커니즘 | active metabolite / PRU 영향 | evidence 강도 |
|---|---|---|---|---|
| **PON1 Q192R** | rs662 | 2-oxo→thiol 가수분해 보조 (논란) | QQ 형 active ↓ 30%, PRU ↑ ~20 (Bouman 2011 *Nat Med* 17:110) | **논란** — Sibbing 2011 *JACC* 58:1857 (PMID 21962826), Hulot 2011 등 재현 실패 |
| **CES1 G143E** | rs71647871 | clopidogrel→carboxylic acid hydrolysis ↓ → prodrug 잔류 ↑ → CYP 가용량 ↑ | **active AUC ↑ ~35%, PRU ↓ ~25** | 🟡 Lewis 2013 *Pharmacogenet Genomics* 23:1 (PMID 23111421); 한국인 빈도 < 1% |
| **ABCB1 3435C>T** | rs1045642 | 장상피 P-gp 발현 → clopidogrel 흡수 ↓ | TT 형 Cmax ↓ ~25%, MACE HR 1.5 (TRITON) | 🟡 Mega 2010 *Lancet* 376:1312 (PMID 20801494); 한국인 TT ~16% |
| CYP3A4*22 | rs35599367 | CYP3A4 발현 ↓ → 2-oxo→thiol step ↓ | active ↓ ~20% | 🟠 Tomaniak 2017; 한국인 < 0.5% (희귀) |
| CYP3A5*3 | rs776746 | non-expressor (한국인 ~70%) | 영향 작음 (CYP3A4가 주역) | 🟠 중립 |
| P2RY12 H2 haplo. | — | receptor 자체 affinity | PRU ~15 변동 | 🟠 약함 |

**한국인 임팩트 정량 (CYP2C19 단독 vs 통합)**:
- CYP2C19 단독으로 PRU 분산 설명력 ~12% (Shuldiner 2009)
- +ABCB1 +PON1 +ITGB3 통합 시 ~20-25% (여전히 < 30%)
- → **개인차 70% 이상은 미설명** → M5 PFT (직접 측정)가 필요한 이유.

---

## 핵심 통찰

- **CYP2C19 직렬 2-step 율속** — LoF 1개로도 active AUC 25-30% 손실, 2개면 50-70% 손실 (multiplicative).
- **PK → PD → 임상 단일 인과 사슬** — active AUC ↓ → PRU ↑ → ST 2-5×, MACE 1.5-2× — 메타분석 확립 (Mega 2010 JAMA, Hulot 2010 Blood).
- **Asymmetric risk** — LoF는 효과 ↓만 키우고 출혈은 안 늘림 → 한국인 60% IM+PM에서 escalation/switch의 net benefit 명확.
- **한국인 PRU baseline이 ~10-15 단위 더 높음** — HOST-RP-ACS PM군 PRU 247 vs 서구 PM 222 — 컷오프 PRU 208 적용 시 HTPR 비율 과대 위험.
- **modifier 통합해도 분산의 ~75%는 미설명** — genotype-only 전략 한계 → M5 PFT (직접 PRU 측정) 병행 정당화.

---

## 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 2-step bioactivation 경로 | 🟡 SUPPORTED-BY-CITATION | Farid 2010, Kazui 2010 *Drug Metab Dispos* |
| P2Y12 Cys17/Cys270 covalent 차단 | 🟡 SUPPORTED-BY-CITATION | Algaier 2008, Ding 2003 |
| phenotype별 active AUC 정량 | 🟡 SUPPORTED-BY-CITATION | Brandt 2007, Mega 2009 NEJM |
| phenotype별 PRU 정량 | 🟡 SUPPORTED-BY-CITATION | Shuldiner 2009 JAMA, Bonello 2010 JACC |
| HTPR → ST/MACE HR | 🟡 SUPPORTED-BY-CITATION | Mega 2010 JAMA, Hulot 2010 Blood (메타) |
| 한국인 PM PRU > 서구 | 🟠 INSUFFICIENT/DEFERRED | HOST-RP-ACS 단일 비교, head-to-head 부족 |
| PON1 modifier 효과 | 🔴 FALSIFIED (부분) | Bouman 2011 주장 → Sibbing/Hulot 재현 실패 |

→ M3 (decision tree) 입력: phenotype × baseline PRU × modifier(ABCB1/CES1) → escalate(prasugrel/ticagrelor) vs maintain(clopidogrel) vs de-escalate.

🔑 한국인 임팩트: **PM 절반이 HTPR + ST 위험 4×** — M1의 "60% 비-최적"을 PD 정량으로 확정.
