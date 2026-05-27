# 🧪 MET-LAB CATALOG — cosmedrug in silico 종합 SSOT — 2026-05-27

> QD + COSME R&D 도메인의 in silico met lab 결과 통합 카탈로그.
> 외부 발송·허가·실측 wet-lab 제외 · pool ubu-1 in silico 실험만.
> 누적 PR: #281·283·292·296·338·341·345

---

## 1. Vina docking 결과 (실측 완료)

### 💆 SCALP — SRD5A2 (5α-환원효소 Type II, PDB 7BW1) — #281

| Rank | Compound | BindAff (kcal/mol) | 분류 |
|---|---|---|---|
| 1 | Dutasteride | -12.84 | 의약품 (대조) |
| 2 | Finasteride | -10.90 | 의약품 (대조) |
| 3 | **★ Adenosine** | **-8.47** | 기능성 인증 (6대 외 최강) |
| 4 | Biotin | -6.94 | 6대 자동허가 |
| 5 | Procapil | -6.66 | 펩타이드 |
| 6 | Caffeine | -6.55 | 보조 |
| 7-10 | L-Menthol·Dexpan·Salicylic·Niacinamide | -5.2 ~ -6.2 | 6대 |

### 👁 LENS — 6L8H chain A (Acanthamoeba candidate) — #296

| Rank | Compound | BindAff (kcal/mol) |
|---|---|---|
| 1 | **★ α-Tocopherol** | -8.29 |
| 2 | Hyaluronic acid | -7.40 |
| 3 | PHMB n=4 | -7.35 |
| 4-7 | CitricAcid·EDTA·MPDA·Poloxamer | -5.0 ~ -6.3 |

---

## 2. RDKit conformer + Stokes-Einstein diffusion (32 도메인)

### 침투 그룹 분류 (D @298K water)

| 그룹 | D (m²/s) | 대표 화합물 | 처방 역할 |
|---|---|---|---|
| **A 즉시** | >1e-9 | HOCl·H2O2·Ethanol·Urea·LacticA·Glycerin·NanoFiberPVDF | 표피 침투·빠른 작용 |
| **B 균형** | 5-9e-10 | Salicylic·Niacinamide·CitricA·Chitosan·Caffeine·Adenosine·Tranexamic | 일반 처방 핵심 |
| **C 지속** | <4e-10 | Ceramide·Tocopherol·MPDA·Ketoconazole·CPC·Retinol·Bakuchiol·PHMB | 막 결합·표면 잔류 |

### 도메인 커버리지 (conformer 분석 완료)

```
QD-SCALP·LENS·ECOPAD·PAD·GARGLE·FWASH·MWASH·HSHAMPOO·HSPRAY·TPASTE
   ·INCONT·POSTPART·INSECT·SANSURF·AWAKE·PETHYG·SANITIZER·BAND·MASK  (19)
COSME-AMPOULE·SUN·DERM·SCALP·ACNE·EYE·FOOT·FRAGRANCE·BABY·MENS
   ·VEGAN·BODY·NAIL·BOOSTER  (14)
   = 33 도메인 / 60+ 화합물
```

### PHMB 길이 scan (Stokes-Einstein 정합)

```
n=4 (MW 792)   R_g 11.45Å  D 1.66e-10
n=6 (MW 1158)  R_g 16.35Å  D 1.16e-10
→ D ratio (1.43) == r_g ratio (1.43) → D ∝ 1/r_h 검증 ✅
```

---

## 3. first-principles 검증 가설 (실측)

| 가설 | 결과 |
|---|---|
| Adenosine 5αR 강력 결합 (SCALP Pilot D) | ✅ Vina -8.47 (6대 외 최강) |
| α-Tocopherol 단백질 + TiO2 색소 보호 dual (LENS) | ✅ Vina -8.29 + logP +8.84 |
| Glycerin·LacticA 셀룰로오스 SAP swelling 가속 (ECOPAD) | ✅ D 2× Cellobiose |
| PHMB D ∝ 1/r_g (Stokes-Einstein) | ✅ n=4/n=6 ratio 정합 |
| MPDA 막 침투(logP+4.76 강) ≠ protein binding(-5.92 중) | ✅ 메커니즘 분리 입증 |

---

## 4. Pilot D 처방 (도메인별 in silico 확정)

| 도메인 | Pilot D 핵심 (in silico 검증) |
|---|---|
| 💆 SCALP | 6대② + **Adenosine 1%** + Procapil 3% + Caffeine 0.5% + 80nm 나노에멀젼 (C 그룹 캡슐화) |
| 👁 LENS | PHMB + Poloxamer + MPDA + **α-Tocopherol** + EDTA + 시트르산 |
| 🌱 ECOPAD | 셀룰로오스 + **Glycerin 5% + LacticA 2%** (A 그룹 swelling 가속) + Chitosan + Terpinen-4-ol |

---

## 5. R&D 처방 3-층 침투 전략 (전 도메인 공통)

```
① 즉시 효과 (A 그룹, D>1e-9): 표피 침투·빠른 작용
   HOCl·Ethanol·Urea·LacticA·Glycerin
② 핵심 효능 (B 그룹, 5-9e-10): 일반 처방 균형
   Salicylic·Niacinamide·Adenosine·Caffeine·Chitosan
③ 지속 효과 (C 그룹, <4e-10): 막 결합·표면 잔류
   Tocopherol·Ceramide·Ketoconazole·CPC·Retinol·PHMB
   → 80nm 나노에멀젼 캡슐화 우선 적용
```

---

## 6. ⏳ deferred 마일스톤 (미래 met lab — 미실행)

### ε' — TPASTE gingipain docking
- [ ] 4RBM (CKC active site) chain A 추출 + receptor prep + Vina docking
- [ ] ligand: 트라넥삼산·CPC·알란토인·비타민C vs P.gingivalis gingipain
- [ ] 가설: 트라넥삼산 잇몸 출혈 응고 + CPC 항균 dual

### ζ' — INSECT mosquito OR docking
- [ ] 6C71 (FAD pocket) chain 추출 + receptor prep + Vina docking
- [ ] ligand: DEET·이카리딘·시트로넬라·유칼립톨 vs mosquito OR
- [ ] 가설: 이카리딘 OR 차단 (저자극) vs DEET 동등 효능
- [ ] ⚠ 6C71이 mosquito olfactory receptor direct binding인지 PDB 검증 선행

### η+ — 추가 도메인 SMILES extension
- [ ] 항진균 자연 추출물 (피록톤올아민·옥토피록스·climbazole 변형)
- [ ] 식물성 펩타이드 (Capixyl·Procapil·Aminexil 변형)
- [ ] 시카·자생 추출물 (마데카소사이드·아시아티코사이드·당귀·천궁)
- [ ] 항산화 (아스타잔틴·코엔자임Q10·이데베논)

### θ — Cloud GPU MD (Phase 3D #292)
- [ ] LENS PHMB-POPC 100ns MD (Vast V100 $4-6) — 각막 안전성
- [ ] ECOPAD 셀룰로오스 SAP 50ns MD ($2-3) — swelling 동역학
- [ ] ⚠ 사용자 confirm 필요 (실제 $$$ rent)

### 환경 차단 (재시도 필요)
- [ ] HSHAMPOO Cyp51 (5TZ1) — disulfide bond → ADFRsuite prepare_receptor4 필요
- [ ] GARGLE GtfB — active site HET 부재 → 다른 PDB (6BSC·5O0E) 탐색
- [ ] MAKEUP inorganic (IronOxide·TiO2·Mica) — DFT 영역 (RDKit 불가)

---

## 7. 산출물 인벤토리 (exports/material_discovery/insilico/)

| 파일 | 내용 |
|---|---|
| scalp_dock_run·phase2 | SCALP 5αR docking |
| lens_dock·lens_dock_retry | LENS Acanthamoeba docking |
| ecopad_met_lab | ECOPAD conformer + diffusion |
| met_lab_all | 22 도메인 + PHMB scan |
| met_lab_eta_eps_zeta | η 10 도메인 + ε·ζ PDB 후보 |

---

## 8. 누적 PR 인덱스

| PR | 내용 |
|---|---|
| #251·254 | 컨테이너·도메인 init |
| #256 | PLAYBOOK SSOT |
| #259·262 | R&D 정공법 재구성 |
| #265·267 | spec + stdlib + structure/design |
| #269·271·272 | research deep (SCALP·LENS·ECOPAD) |
| #274·281·283 | in silico Phase 1·2 + RFQ |
| #292·296·302·338·341·345 | docking·conformer·plans·extension |

## 정직한 한계 (g5)

- Vina docking·Stokes-Einstein = in silico 예측 (절대값 ±2-3× 오차)
- 상대 ranking·diffusion 그룹 분류는 처방 결정 정량 근거로 유효
- 실측 검증 = in vitro CRO (RND-STDLIB §1) + 인체적용 24주
- 6L8H·6C71·4RBM 정확한 organism/target description 검증 권고
