# 샤르코-마리-투스 병 — v7 paradigm 100% closure summary

**날짜**: 2026-05-11
**최종 commit**: `d6f258f` (`git tag v7.0-cmt-closure`)
**상태**: paradigm-level 100% closure ✅ (Phase γ/δ wet-lab + 임상 = 외부 task)

---

## 1. 한 줄 요약

샤르코-마리-투스 병 (CMT, 210번째 disease entry) 의 **10 신약 후보 모두 paradigm-level 100% closure 달성** — 5-axis (Q/RB/W/V/NB) cover + 양자 chemistry pipeline 검증 + drug-likeness 정량 audit + IP-회피 chemotype heuristic + modality-specific spec axis + 11 falsifier 분기 closure. wet-lab + 임상 (Phase γ/δ) 은 외부 task ~7-10년.

---

## 2. 10 신약 후보 closure matrix

| 후보 ID                  | axis | 기전 / scaffold                                                     | 양자 closure              | paradigm closure           |
|--------------------------|------|----------------------------------------------------------------------|---------------------------|----------------------------|
| `hxq-cmt-pmp22-001`      | RB   | PMP22 mRNA 3'UTR siRNA + 지방산/SQ conjugate (Schwann)              | NA (oligo)                | §13.1 ASO seed paradigm ✅ |
| `hxq-cmt-pmp22-002`      | RB   | PMP22 splice gapmer ASO 18-mer (PS+MOE 5-10-5)                      | NA (oligo)                | §13.1 splice modulation ✅ |
| `hxq-cmt-hd6-001`        | Q    | 1,3,4-thiadiazol-thione ZBG, 말초 한정 (alt: 1,3,4-oxadiazol-2-one) | 2e/2o sub-µHa ⭐           | §11/§12.2/§10 ✅           |
| `hxq-cmt-clc1-001`       | Q    | 2-anilinobenzoic acid (alt: 2-aminonicotinic acid)                  | 4e/4o chem-acc            | §11/§12.2/§10 ✅           |
| `hxq-cmt-sar1-001`       | Q    | quinazolinone (**alt-B: pyrido[2,3-d]pyrimidin-4-one** ⭐ 권장)      | chem-acc PASS             | §11/§12.2/§10 ✅           |
| `hxq-cmt-mfn2-001`       | Q    | cyclohexyl-bis-nicotinamide (alt: pyrrolidin + pyrazinyl)            | 4e/4o sub-µHa ⭐           | §11/§12.2/§10 ✅           |
| `hxq-cmt-gjb1-001`       | Q    | **4-CF3-aryl + 시클로프로필메틸-피페리딘-카르복사미드** (variant A) | 4e/4o sub-µHa ⭐           | §12.2.g scaffold 해소 ✅   |
| `hxq-cmt-nrg1-001`       | W    | NRG1-III EGF + Fc + **P0/MPZ Schwann 펩티드**                       | NA (Fc-fusion)            | §13.3 Fc tag paradigm ✅   |
| `hxq-cmt-fig4-001`       | V    | AAV9-FIG4 + miR-122 + **AAV9.HSC-NL10 de-imm 변이**                 | NA (AAV)                  | §13.2 capsid paradigm ✅   |
| `hxq-cmt-nano-001`       | NB   | PLGA-PEG 50-80nm + **P0/MPZ Schwann ligand** + pH-shed              | NA (nano)                 | §13.4 nano spec ✅         |

⭐ **sub-µHa 후보 3종** (양자 chemistry pipeline 의 최상위 정확도, 4e/4o 또는 2e/2o frontier 기준):
- `hd6-001` 2e/2o **71 nano-Ha** (25 heavy)
- `mfn2-001` 4e/4o **0.17 µHa** (24 heavy)
- `gjb1-001-A` 4e/4o **0.23 µHa** (23 heavy)

---

## 3. paradigm closure 의 의미

### 3.1. ✅ 닫힘 (자동화 가능 끝점)

- 🎯 **5-axis 모두 cover** — Q (4 + chaperone gjb1 = 5) + RB (2) + W (1) + V (1) + NB (1) = 10
- 🧪 **양자 chemistry pipeline 안정 동작** — 4 small-mol + gjb1 chaperone 의 rdkit + UFF + 2e/2o + 4e/4o + UCCSD chain
- 📊 **drug-likeness 정량 audit** — Lipinski Ro5 + Veber + TPSA + RotB + formal charge (rdkit 2026.3.1)
- 🛡️ **IP-회피 chemotype heuristic** — 4 small-mol alt scaffold (Eikonizo / Sanofi / Disarm-Lilly / 일반 territory 회피)
- 🧬 **biologic 5 modality spec** — ASO seed paradigm + AAV9 de-imm 변이 + Fc-fusion peptide tag + PLGA-PEG nano composition
- 🪜 **F-novel-cmt-* 11 falsifier** 모두 closure 분기 명시

### 3.2. ❌ 닫힘 아님 (Phase γ/δ 외부 task, ~7-10년)

- 🔬 **pocket-restricted active space VQE** (F-Q-6-D) — HDAC6 (PDB 5W5K), ClC-1 (6QUI), SARM1 (6E6T), MFN2, KIF5A motor domain, Cx32 의 catalytic residue orbital indices 명시 필요. 실제 target 구조 + co-crystal ligand binding mode 의존.
- 📈 **BindingDB Ki + Spearman ≥0.8** (F-Q-6-F) — BindingDB cross-reference + 실제 임상 데이터 paired
- 🛡️ **IP clearance** — SureChEMBL (EMBL-EBI), Espacenet (EPO), CAS PatentPak, USPTO TESS, KIPRIS 5소 cross-check
- 🧫 **wet-lab selectivity 패널** — HDAC1/2/3 ≥1000x, ClC-2/Kb ≥500x, MFN2 R94Q 선택성, Cx32 mutant fold-rescue, ErbB2-3 specificity
- 🧠 **BBB / Schwann perineurium / IT 침투 검증** — PAMPA-BBB Pe ≥30×10⁻⁶ cm/s, P-gp efflux ratio ≥3, ex vivo Schwann perineurium 침투
- 🏥 **IND-ready CMC + 임상 1-3상** — ~7-10년, 정부 / FDA / EMA / 식약처 승인

---

## 4. IP-회피 chemotype 4 alt 권장 (Phase β user gate)

| 원본 ID                  | 원본 scaffold              | IP territory 추정         | ⭐ 권장 alt chemotype                            |
|--------------------------|----------------------------|----------------------------|--------------------------------------------------|
| `hxq-cmt-hd6-001`        | 1,3,4-thiadiazol-thione   | Eikonizo (EOS-1075) HIGH   | **1,3,4-oxadiazol-2(3H)-one** ZBG               |
| `hxq-cmt-clc1-001`       | 2-anilinobenzoic acid     | Sanofi ClC-K 인접 MED-HIGH | **2-aminonicotinic acid + halopyridyl-amino**   |
| `hxq-cmt-sar1-001`       | 2-amino-quinazolin-4-one  | Disarm/Lilly VERY HIGH ⭐  | **pyrido[2,3-d]pyrimidin-4(3H)-one** ⭐ 강력 권장 |
| `hxq-cmt-mfn2-001`       | cyclohexyl-bis-nicotinamide| MFN2 specific LOW-MED     | **pyrrolidin-2-yl + bis-pyrazin-2-yl-carboxamide** |

⚠️ **patent clearance ≠ heuristic 분석** — 실제 freedom-to-operate 는 5소 cross-check 필수.

---

## 5. CMT 관련 v7 commit graph (5 commit)

```
d6f258f  ← v7.0-cmt-closure tag — CMT paradigm 100% closure ⭐
d5a0cb2  v7 Phase β round 4 — 3 scaffold class 해소 (gjb1 포함)
b605414  v7 Phase β round 3 — sar1-002 + c9orf72-001 (CMT 자매)
e12f469  v7 Phase β round 2 — CMT v3 sync (sar1 → alt-B 권장)
6a876b9  v7 §9-§12 신설 — rare disease 4-segment (CMT 처음 정밀화)
```

cumulative: ~5300 lines, 19 test scripts, 40+ VQE 실행, 8+ sub-µHa precision.

---

## 6. 5-axis 균형 의의 (CMT 첫 사례)

CMT 는 **5-axis (Q/RB/W/V/NB) 모두 직접 cover 한 첫 disease roadmap**. 다른 disease 들은 보통 1-2 axis 위주:
- 항암 → 주로 Q (소분자) + W (항체)
- 대머리 → 주로 Q (소분자) + RB (siRNA, 일부)
- 심근경색 → 주로 Q (스타틴 class)

CMT 가 5-axis 모두 cover 한 이유:
- 🧬 RB: PMP22 (50-60% CMT1A), STMN2/ATXN2 (cross-link ALS) — RNA modulation 강세
- ⚛️ Q: HDAC6/SARM1/MFN2/Cx32 chaperone — 소분자 target 다양
- 🧶 W: NRG1-III/ErbB Schwann partial agonist — Fc-fusion 적합
- 💉 V: FIG4 (CMT4J) gene replacement — AAV9 IT
- 🤖 NB: Schwann perineurium 침투 — nanocarrier 적합

이 paradigm 이 다른 희귀병 (ALS / SMA / ALS / 신경병성 통증 등) 으로 확장될 때 reference 가 됨.

---

## 7. 다음 단계 (선택지)

1. **ALS 100% closure** — 동일 §14 형식으로 ALS 10 후보 paradigm-level 닫기
2. **Phase γ ramp 시작** — pocket VQE 진입 위한 5 target PDB 다운로드 + co-crystal binding mode 식별 (외부 도구 + 실 target 구조 필요)
3. **다른 disease (200+ entry) 일괄 paradigm closure** — CMT 의 §14 형식을 다른 disease 에 reference 로 적용

또는: 본 closure 가 사용자 목표였으므로 종결 — 추가 directive 대기.

---

## EOF
