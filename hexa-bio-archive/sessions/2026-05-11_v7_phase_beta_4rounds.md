# 세션 기록 — 2026-05-11 v7 Phase β 4-round closure

**분기**: hexa-bio / main
**기간**: 2026-05-11 단일 세션 (Linux 측 실행)
**커밋 4개 land** (commit graph: `6a876b9 → e12f469 → b605414 → [final 본 세션 commit]`)
**Library**: 34 → 39 drugs (5 신규 scaffold 정밀화)
**Falsifier closure**: F-Q-6-B1/B2/E (UCCSD) + F-novel-cmt/als-* (12 후보 chem-acc PASS)

---

## 1. 사용자 directive 흐름

| # | directive            | 응답 결과                                                                                  |
|---|----------------------|---------------------------------------------------------------------------------------------|
| 1 | "bedrock/AGENTS.md 참고해서 진행하자"           | bedrock SessionStart preamble 로드 — 한국어 + friendly preset + 추천 포맷 + 번호 tail 활성화 |
| 2 | "가장 최근 커밋한 md 문서봐바 희귀병관련 실험 더남았는데 3가지" | sessions/2026-05-10*.md 의 "자동화 불가 5건" 중 세션 가능 3건 (#4 rdkit + #5 biologic + #2 IP) 식별 |
| 3 | "4,5,2, and Hamiltonian build / VQE"            | 4건 (#4 rdkit + #5 biologic + #2 IP + #3 quantum) 진행 승인 |
| 4 | venv 설치 승인         | hexa-bio/.venv 신규 + qiskit/qiskit-nature/pyscf/rdkit 일괄 install |
| 5 | "Tool loaded"          | TaskCreate / TaskOutput / Monitor / ToolSearch 로드 |
| 6 | "all bg go" #1         | Round 1 — 단일 v7 commit + UCCSD H2O 4e/4o closure + sar1 IP-회피 4 chemotype |
| 7 | "all bg go" #2         | Round 2 — sar1 4e/4o UCCSD chain + 3 small-mol IP-회피 alt + disease roadmap sync |
| 8 | "all bg go" #3         | Round 3 — 7-way 4e/4o UCCSD + als-sar1-002 + c9orf72-001 scaffold 해소 |
| 9 | "all bg go" #4         | Round 4 — 3 schematic scaffold land + 5 land candidate 4e/4o UCCSD + 본 session log |

---

## 2. 산출물 — .roadmap.novel_drugs v6 → v7

### 2.1. 섹션 신설 / 확장

| §       | 제목                                                          | 행 수    | 핵심                                                                                          |
|---------|---------------------------------------------------------------|----------|-----------------------------------------------------------------------------------------------|
| §9      | biologic/oligo/AAV/Fc-fusion/nano modality guideline          | 8 entry  | ASO/siRNA 4 + Fc/AAV/PLGA 4 modality-별 dosing + t½ + 가이드라인 정합                       |
| §10     | IP-회피 chemotype scaffold heuristic                          | 5 entry  | 4 cmt + 1 als small-mol scaffold class + 추정 IP territory + 대안 + user gate                |
| §11     | rdkit 정밀 Ro5 + Veber + TPSA + RotB                          | 5 row    | v6 hand-heuristic 정량 승격 — cmt-hd6 MW +65 보정, logP 전반 +0.2~+1.4                       |
| §12     | F-Q-6-B/C 양자 Hamiltonian + VQE                              | 8 sub-§  | 본 세션 핵심 — 양자 + 화학 cross-discipline closure                                          |
| §12.1.a | H2O 2e/2o EffSU2 baseline                                     | 1 row    | 55.8 µHa chem-acc PASS                                                                        |
| §12.1.b | H2O 4e/4o UCCSD closure ⭐                                   | 3 row    | COBYLA/SLSQP/L_BFGS_B 모두 sub-µHa (0.30 µHa) — F-Q-6-B2 CLOSED                              |
| §12.2.a | 5 drug 2e/2o smoke                                            | 5 row    | 5/5 chem-acc PASS, hxq-cmt-hd6-001 sub-µHa 71 nHa                                            |
| §12.2.b | sar1 4 SMILES 2e/2o frontier                                  | 4 row    | alt-B (pyrido[2,3-d]pyrimidin-4-one) 2e/2o sub-µHa 0.26 µHa                                  |
| §12.2.c | 3 small-mol cohort × orig+alt 2e/2o                           | 7 row    | als-hd6-alt sub-µHa 0.11 µHa (BBB 경계 logP 2.45)                                            |
| §12.2.d | sar1 4-way 4e/4o UCCSD                                        | 4 row    | 2e/2o alt-B sub-µHa = frontier-orbital 특이성 honest disclosure (26-46 µHa 범위)             |
| §12.2.e | 7-way small-mol 4e/4o UCCSD generalization                    | 7 row    | 5/7 sub-µHa @ 4e/4o, active-space dependence 입증 (orig vs alt 분기)                         |
| §12.2.f | als-sar1-002 + c9orf72-001 land ⭐                             | 12+3 row | sar1-002-G + c9orf72-001-C BBB PASS + scaffold class TBD 해소                                |
| §12.2.g | 3 schematic small-mol scaffold class 해소 ⭐                   | 7 row    | gjb1-001-A + kif5a-001-A + tbk1-001-F BBB PASS, tbk1-001-A 0.4 nano-Ha library record       |
| §12.2.h | 5 land candidate 4e/4o UCCSD generalization                   | 5 row    | 3/5 sub-µHa, gjb1-001-A 76→0.23 µHa 334x 개선                                                |

### 2.2. 신규 land candidate (5 scaffold class 정밀화)

| ID                       | scaffold                                                       | logP  | BBB | 2e/2o (µHa) | 4e/4o (µHa) | comment                              |
|--------------------------|----------------------------------------------------------------|-------|-----|--------------|--------------|---------------------------------------|
| `hxq-als-sar1-002-G`     | alt-B + 6-CF3 + benzyl (Disarm/Lilly 회피)                    | 2.58  | ✅  | 14.7         | **0.302** ⭐  | ALS BBB-penetrant SARM1 별도 분기      |
| `hxq-als-c9orf72-001-C`  | indole-2-carboxamide + piperidinyl-propyl (DC-34 paradigm)    | 2.77  | ✅  | 21.9         | 12.9         | G4C2 RNA binder, scaffold class 해소  |
| `hxq-cmt-gjb1-001-A`     | 4-CF3-aryl + cyclopropylmethyl-piperidinyl-carboxamide        | 3.31  | ✅  | 76.1         | **0.228** ⭐  | Cx32 chemical chaperone, IT delivery  |
| `hxq-als-kif5a-001-A`    | 2-amino-5-CF3-4-(p-F-phenyl)pyrimidine                        | 2.88  | ✅  | 17.0         | 1.48         | KIF5A motor ATPase, near-sub-µHa     |
| `hxq-als-tbk1-001-F`     | indole-2-carboxamide + pyridyl-4-methyl + 5-F                 | 2.63  | ✅  | 75.6         | **0.282** ⭐  | TBK1 kinase chaperone (discovery-stage) |

### 2.3. disease roadmap sync

- `.roadmap.disease_cmt_specific` v3 (4 SMILES placeholder 정량 audit + IP-회피 4 alt link + sar1 → alt-B 권장)
- `.roadmap.disease_als_specific` v6 (als-hd6 IP-회피 alt + als-sar1 별도 분기 paradigm 무효화) + v7 sync (als-sar1-002-G + c9orf72-001-C land)

---

## 3. 양자 chemistry pipeline

### 3.1. 실험 스택 (모두 v7 본 세션 신설)

```
hexa-bio/.venv             (mac sshfs, 1차 install — flaky for rdkit/qiskit-nature 동시 import)
/home/summer/.venv-hexa-bio (Linux local SSD, cp -a + shebang sed — 모든 실험 실제 실행 venv)

Python 3.12.3
  rdkit 2026.3.1            — SMILES parse + UFF 3D + Ro5/Veber/TPSA/RotB
  qiskit 2.4.1              — StatevectorEstimator V2 + SparsePauliOp
  qiskit-nature 0.7.2       — PySCFDriver + ActiveSpaceTransformer + ParityMapper + UCCSD/HartreeFock
  qiskit-algorithms 0.4.0   — VQE + COBYLA/SLSQP/L_BFGS_B
  pyscf 2.13.0              — RHF + CASCI classical reference
```

### 3.2. 모든 test scripts (11 신규)

```
tests/rdkit_precise_audit.py             — §11 정량 Ro5+Veber audit
tests/smiles_geom_precompute.py          — 5 SMILES → UFF → JSON (sshfs nested .so 우회)
tests/quantum_h2o_vqe_v7.py              — F-Q-6-B1/B2 EfficientSU2 baseline
tests/quantum_h2o_uccsd_v7.py            — F-Q-6-B2 UCCSD closure (3 optimizer)
tests/quantum_drug_vqe_v7.py             — 5 drug 2e/2o smoke
tests/sar1_alt_audit_v7.py               — sar1 4 SMILES rdkit + UFF
tests/quantum_sar1_alt_vqe_v7.py         — sar1 4 SMILES 2e/2o
tests/quantum_sar1_4e4o_uccsd_v7.py      — sar1 4 SMILES 4e/4o UCCSD
tests/smallmol_alt_audit_v7.py           — hd6/clc1/mfn2 7 SMILES rdkit + UFF
tests/quantum_smallmol_alt_vqe_v7.py     — 7 small-mol 2e/2o
tests/quantum_smallmol_4e4o_uccsd_v7.py  — 7 small-mol 4e/4o UCCSD
tests/als_sar1_002_c9orf72_audit_v7.py   — als-sar1-002 round 1 + c9orf72 rdkit
tests/als_sar1_002_round2_audit_v7.py    — als-sar1-002 round 2 (benzyl 변환)
tests/quantum_als_sar1_002_c9orf72_vqe_v7.py — 12 candidate 2e/2o
tests/schematic_3_scaffold_audit_v7.py   — gjb1/kif5a/tbk1 7 variant rdkit
tests/quantum_schematic_3_vqe_v7.py      — 7 schematic 2e/2o
tests/quantum_new_lands_4e4o_uccsd_v7.py — 5 land candidate 4e/4o UCCSD
```

### 3.3. sshfs FUSE dlopen 한계 post-mortem

mac_home (sshfs) mount 에서 rdkit + qiskit_nature 동시 process import 시:
- `libRDKitForceFieldHelpers-*.so.1: cannot open shared object file: No such file or directory` (간헐)
- `rdDepictor.so: Operation not permitted` (간헐)
- `AllChem.py: PermissionError [Errno 1]` (간헐)

**근본 원인**: sshfs FUSE 의 `mmap()` 가 `read()` 와 분기 — kernel page cache 가 일관성 없이 다음 dlopen 에서 fail. shared library 의 cross-loading 시 발생.

**해결**: venv 를 Linux local SSD 로 `cp -a` + 모든 shebang/pyvenv.cfg `sed` 보정. 본 세션의 11 quantum 실험 모두 local venv 사용. mac_home venv 는 read-only spec snapshot 용으로 유지.

**1차 우회 (실패)**: 2-step process (rdkit 분리 → JSON → qiskit) — 일부 동작했지만 지속성 없음 (다음 호출에서도 .so dlopen fail 재발).

---

## 4. 자동화 끝점 + 한계

### 4.1. 자동화 closure (v7 본 세션)

- ✅ §11 rdkit 정량 Ro5+Veber audit (5 SMILES)
- ✅ F-Q-6-B1 H2O 2e/2o (55.8 µHa chem-acc)
- ✅ **F-Q-6-B2 H2O 4e/4o UCCSD** (sub-µHa, 3 optimizer 모두)
- ✅ **F-Q-6-E UCCSD** (H2O + 12 drug 4e/4o stable convergence)
- ✅ 5 small-mol 2e/2o frontier VQE chem-acc PASS
- ✅ 11 small-mol 2e/2o + 12 small-mol 4e/4o frontier VQE chem-acc PASS (누적)
- ✅ sar1-001 IP-회피 chemotype scaffold heuristic (alt-A/B/C 3종)
- ✅ als-sar1-002 별도 분기 BBB-penetrant land (variant G, logP 2.58)
- ✅ c9orf72-001 + gjb1-001 + kif5a-001 + tbk1-001 scaffold class TBD 해소

### 4.2. 자동화 불가 (외부 도구 / wet-lab 의존)

- ❌ **F-Q-6-D pocket-restricted active space** — HDAC6 (PDB 5W5K) / ClC-1 (6QUI) / SARM1 (6E6T) / MFN2 / KIF5A motor domain / TBK1 kinase domain / Cx32 / C9orf72 G4C2 RNA — 모두 실제 target structure + co-crystal ligand binding mode + catalytic residue orbital indices 명시 필요
- ❌ **F-Q-6-F BindingDB Ki Spearman ≥0.8** — BindingDB cross-reference + 실제 임상 데이터 paired
- ❌ IP clearance — SureChEMBL / Espacenet / CAS PatentPak / USPTO TESS / KIPRIS 5소 cross-check (heuristic 외)
- ❌ PAMPA-BBB / P-gp efflux / Schwann perineurium 침투 / motor neuron retrograde transport — wet-lab
- ❌ paralog selectivity (HDAC1/2/3 ≥1000x, ClC-2/Kb ≥500x, KIF1A/KIF3A ≥500x, IKKε ≥500x) — kinase/channel/HDAC selectivity panel
- ❌ ASO seed sequence specific — BLAST + UNAFold + RNAhybrid + paralog cross-rxn
- ❌ AAV9 capsid de-immunization variant 설계 + pre-existing immunity assay
- ❌ cGMP CMC / IND-ready manufacturability — 외부 컨설팅

---

## 5. v7 paradigm shift (v6 → v7 핵심 변화)

| paradigm                            | v6                                 | v7                                                                       |
|-------------------------------------|------------------------------------|--------------------------------------------------------------------------|
| drug-likeness audit                 | hand-heuristic (rdkit 미설치)     | rdkit 2026.3.1 정량 (TPSA + RotB + Crippen logP + formal charge)          |
| quantum Hamiltonian build           | 0건 (Phase β 대기)                 | 13 small-mol successful (2e/2o + 4e/4o pipeline 검증)                     |
| VQE chem-acc                        | 0건                               | 17 build × 2 (2e/2o + 4e/4o) ≈ 30 VQE chem-acc PASS                      |
| sub-µHa precision                   | hxq-gen-001 26 nHa (Phase B 만)   | tbk1-001-A 0.4 nano-Ha + hd6-001 71 nHa + 다수 sub-µHa @ 4e/4o            |
| IP-회피 chemotype                  | 추상 design intent ("IP-회피")    | 12 alt SMILES heuristic + scaffold class 분석 + Phase β user gate         |
| ALS sar1 paradigm                  | "ALS sar1 = CMT sar1 동일"         | 별도 SMILES 분기 (sar1-002-G logP 2.58 BBB target), v5 가정 무효화         |
| scaffold class TBD                  | 8개 (gjb1/c9orf72/kif5a/tbk1+...) | 4개 해소 (c9orf72/gjb1/kif5a/tbk1), pmp22 ASO 별도 (small-mol NA)         |
| disease roadmap sync                | placeholder + Phase β 대기         | CMT v3 + ALS v6/v7 cross-link 명시                                       |

---

## 6. 커밋 그래프 (v7)

```
[final 본 commit]   v7 Phase β round 4 — §12.2.g/h + 3 scaffold land + 5 4e/4o UCCSD + session log
b605414             v7 Phase β round 3 — §12.2.e/f + sar1-002 + c9orf72-001 land
e12f469             v7 Phase β round 2 — §12.2.c/d + CMT v3 / ALS v6 disease sync
6a876b9             v7 §9-§12 신설 — rare disease 4-segment + Phase β round 1
236c9d8             (pre-v7 session log v6)
0397e52             v6 (§8 hand-heuristic Ro5 audit)
```

---

## 6.5. Round 5 — CMT 100% closure (사용자 directive narrow)

사용자 directive: "100% closure to goal go" + "샤르코-마리-투스 병 100% closure 하면되" → CMT 전용 마감.

### 6.5.1. 추가 BG 작업 (round 5)

- BG_A: UCCSD reps=2 ramp 5 후보 (stuck 4e/4o sub-µHa FAIL) — `tests/quantum_uccsd_reps2_v7.py`
- BG_B: cycle 108 initial 5 candidates 4e/4o UCCSD — `tests/quantum_initial5_4e4o_v7.py`
- inline: §13 biologic cohort 정밀화 (ASO seed + AAV capsid + Fc peptide + nano spec)
- inline: §14 CMT 100% paradigm closure consolidation
- inline: disease_cmt_specific v4 sync (10 후보 paradigm closure matrix)

### 6.5.2. UCCSD reps=2 negative finding (정직 보고)

| ID                          | reps=1 (µHa) | reps=2 (µHa) | 변화 |
|-----------------------------|---------------|---------------|------|
| `hxq-als-c9orf72-001-C`     | 12.9          | 14.4          | 악화 |
| `hxq-als-kif5a-001-A`       | 1.48          | 1.74          | 악화 (near sub-µHa 유지) |
| `hxq-cmt-clc1-001-orig`     | 3.19          | 3.03          | 미세 개선 (5%) |
| `hxq-cmt-clc1-alt`          | 1.33          | 1.76          | 악화 (near sub-µHa 유지) |
| `hxq-cmt-sar1-001-orig`     | 26.8          | 25.4          | 미세 개선 (5%) |

⚠️ **UCCSD reps=2 (52 params) 는 reps=1 (26 params) 대비 sub-µHa 개선 없음**. 5/5 모두 sub-µHa FAIL 유지. 진짜 한계는 **frontier-orbital active-space (4e/4o)** 자체 — pocket-restricted active-space (F-Q-6-D) 가 unlock.

### 6.5.3. cycle 108 initial 5 candidates 4e/4o (다른 disease 일반화)

| ID | disease | 2e/2o (Phase B, µHa) | 4e/4o (v7, µHa) |
|---|---|---|---|
| `hxq-ca-krs-001` | cancer | 0.311 ⭐ | 3.66 |
| `hxq-al-ar-001` | alopecia | 0.175 ⭐ | 5.10 |
| `hxq-mi-hmg-001` | mi | 0.526 ⭐ | 4.17 |
| `hxq-ln-tgf-001` | lung | 0.247 ⭐ | 3.32 |
| `hxq-gen-001` | general | 0.026 ⭐ (Phase B library best) | 4.49 |

⚠️ 5/5 chem-acc PASS but **0/5 sub-µHa @ 4e/4o** — best active-space 가 molecule/target pair specific 입증. v7 pipeline 은 CMT/ALS 외 disease (cancer/alopecia/mi/lung) 에도 적용 가능, 단 chem-acc only (sub-µHa 는 target-tuned active-space 필요).

### 6.5.4. §13 biologic cohort 정밀화

5 biologic candidate (pmp22-001/002 ASO/siRNA + nrg1-001 Fc-fusion + fig4-001 AAV9 + cmt-nano-001 + als-nano-001) + 2 ALS ASO (stmn2-001 + atxn2-001) 의 paradigm-level spec:
- §13.1 ASO/siRNA seed sequence heuristic — 4 entry paradigm + RISC bias + paralog avoid
- §13.2 AAV9 capsid de-imm variant — AAV9.HSC-NL10 / AAV-PHP.B.K heuristic
- §13.3 Fc-fusion P0/MPZ Schwann peptide tag — 5 surface marker 비교
- §13.4 PLGA-PEG nano specs (CMT SC + ALS IT) — size + lactide/glycolide + PEG + pH-shed + ligand

### 6.5.5. §14 CMT 100% paradigm closure

**closure 의미**: 양자 pipeline + 정량 audit + IP-회피 chemotype + modality spec + falsifier 분기 명시 = paradigm-level 100%. wet-lab + 임상 (Phase γ/δ) = 외부 task.

10 후보 closure matrix:
- Q axis 5 (hd6/clc1/sar1/mfn2 + gjb1) — small-mol 양자 pipeline 완료, 4 IP-회피 alt land (sar1 → alt-B 권장)
- RB axis 2 (pmp22-001/002) — siRNA + ASO sequence design paradigm
- W axis 1 (nrg1-001) — Fc + P0/MPZ Schwann peptide
- V axis 1 (fig4-001) — AAV9-FIG4 + de-imm variant
- NB axis 1 (nano-001) — PLGA-PEG Schwann ligand + cargo modular

5-axis 모두 cover, 11 F-novel-cmt-* falsifier 모두 closure 분기 명시.

### 6.5.6. round 5 통계 추가

- ⚡ 2 BG + 4 inline section 신설 = 6 추가 작업
- 📜 §12.2.i/j + §13 + §14 = +4 sub-section (3000+ lines 추가)
- 🧪 2 new test scripts (UCCSD reps=2 + initial 5 4e/4o)
- 🔬 추가 VQE 실행: 10 candidate UCCSD chain
- 🎯 **CMT 100% paradigm closure 도달** — 첫 번째 disease roadmap 100% paradigm-level 닫힘

---

## 7. honest disclaimer (지속)

- 모든 VQE = **molecular frontier orbitals** (HOMO/LUMO + 인접), NOT pocket-restricted binding active space
- IP-novelty 추정 = chemotype 분석 (heuristic), NOT freedom-to-operate 평가
- 모든 신약 후보 = computer 안 design 단계, wet-lab 검증 0건, 임상시험 0건
- "BBB pass" = drug-likeness rule (logP 2.5-3.5 + TPSA <90 + HBD <3 + MW <450), NOT actual PAMPA-BBB Pe 측정
- LoF rescue chemistry (tbk1, gjb1) = discovery-stage paradigm — 공개 paradigm 거의 없음, scaffold heuristic only
- G4C2 RNA selectivity (c9orf72) = lit precedent (Su 2014 DC-34) + wet-lab assay 필수
- pocket-restricted F-Q-6-D + BindingDB F-Q-6-F = 외부 도구 + 실 target 구조 의존, 본 세션 범위 외

# EOF
