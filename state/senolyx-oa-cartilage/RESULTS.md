# SENOLYX OA-cartilage — "additional requirement" research lane

SENOLYX 연골(OA) 팔이 다른 3개 senolytic-closable 치료(모발·치주·망막)와 다른 지점 규명 + 폐쇄.
설계 SSOT = `fable_design_verdict.json` (Fable 5). 상위 = `exports/OA-CURE/RESULTS.md`, `PAPERS/oa-cure-cartilage-regen/`.

## 결론 (규명 완료)

연골에만 고유한 **추가 요구사항 = 삼중 게이트(침투 δ × 청소 φ × 동화 A)**. 마스터 부등식:

```
Ceiling(φ=1) = 0.68 + 0.075·δ + 0.21·δ·A
GATE ⇔  δ·(0.075 + 0.21·A) ≥ 0.22
```

- ① **δ (무혈관 관절강내 전달)**: 연골=혈관 없음 → 활액에서 콜라겐/aggrecan 그물(FCD≈−0.15M)을 확산으로만 통과. Donnan 배제·크기체질·활액 세척(t½ 1–4h). 3개 혈관조직엔 δ≈1이라 이 축이 아예 없음.
- ② **A (연골신생 동화능)**: 완전 소실 연골=무세포 기질. 청소해도 빈 니치만 열릴 뿐 지을 세포/성장인자 공급 없음 → A0≈0.

## Step 0 (frontier/master_frontier.py) — 실행됨 🟢

- 코너: A=1→δ≥0.772 · δ=1→A≥0.690 · **A=0→δ≥2.93 (>1, 불가) = senolytic 청소만으론 어떤 전달로도 게이트 불가**.
- **가능 (δ,A) 영역 = 단위정사각형의 3.8%** — 치료창 극협. δ·A 둘 다 거의 최대여야 통과.
- 현실 코너 δ=0.3–0.5 / A0≈0 = 전부 BLOCK (ceiling 0.70–0.72).
- 격자 저장: `frontier/master_frontier_grid.npz`.

## 사전등록 falsifier (d6)

- **H1(전달)**: 최적 물성 소분자(중성·MW<500·logP1–3)의 2mm 연골 확산 δ_max ≥ 0.772. 실패 시 = 수동 소분자 전달 hard-wall closed-negative → cationic-avidity/depot 레버 강제.
- **H2(신생)**: senolytic 단독 A0 < 0.690 (연골신생 co-driver 필요). A0≥0.690이면 ② NULL, 단일제 캠페인으로 붕괴.

## Step 2 (neogenesis/neogenesis_A0.py) — 실행됨 🟢 → H2 CONFIRMED

- 점근 progenitor 풀 P_ss(φ=1)=0.900 (SASP 완전해소). 하지만 A0 = μ·P_ss (μ=무혈관 이주/충전율).
- **A0≥0.690은 μ≥0.767에서만** — 무세포 기질(혈관·화학주성 gradient 없음·조밀 기질)엔 구조적으로 μ≪1.
- ⇒ **A0≪0.690 = H2 CONFIRMED: 연골신생 동화 co-driver 추가 필수** (senolytic은 창만 열고 지을 것 안 줌). 파라미터-무관(합성속도∝세포밀도=0) 논증.

## 다음 (전부 무료 게이트 → 통과 시에만 유료)

- [x] Step 1 `pk-delivery/` : 1D 과도 반응확산 → δ. **passive 소분자 δ≤0.472 (H1 wall)**, **cationic GAG-avidity(Φ=3) → δ=1.23 PASS**. 전달설계=치료요구의 일부. (D_eff/τ/Φ = ORANGE 구간)
- [x] Step 2 `neogenesis/` : senolytic-only A0 → **H2 CONFIRMED, co-driver 필수** (μ≥0.767 불가능).

## Step 2b (neogenesis/neogenesis_A0_migration.py) — 실행됨 🟢 → H3 FALSE

- 반응-확산-이류로 μ를 μ_transport(우리 물리)×q(분화품질)로 분해. 우리 Step1 확산연산자 재사용.
- H3 falsifier(생리적 v로 fibro품질 q≤0.30에서 A_endo≥0.690?) = **FALSE**. 섬유연골 A_endo 최대 0.206.
- **자체 A 바닥 = 0.206 · 외부 A_ext 필요분 = 0.484** (자체크레딧 0이면 0.690). hyaline 분화노드 1개 불가피.

## ⚠️ 정정 (verdict-integrity) — δ=2.93 "불가능" 코너는 모델 아티팩트였음

- 이전 Step0가 A=0→δ≥2.93을 "불가능"의 근거로 제시했으나 이는 **선형모델 오류**: η_dorm=0.75+0.25δ가 δ>1에서 1 초과(비물리).
- η≤1 물리캡 적용: A=0, δ→∞ 천장 = **0.755 < 0.90 STILL BLOCK**. 결론(청소만으론 불가)은 유지되나 **근거는 캡-포화이지 δ발산 아님**. `master_frontier.py` `ceiling_capped()` 추가·정정.

## 종합 (양축 규명 + 소유권 판정 · 무료 게이트 4/4)

**"우리 발견만으론 연골은 안 됨" = PARTIAL** (정직):
- 혈관치료 3개(모발·치주·망막): 우리 senolytic 발견으로 **됨**.
- 연골: 우리가 δ(cationic 침투 물리)+φ(senolytic 청소)+A_endo(≈0.21 내생 전구세포 이주)까지 커버 → **외부 hyaline-분화 노드 딱 1개(A_ext≥0.48)만 불가피**. hyaline 품질 q는 우리 자산으로 도출 불가(정보/신호 과정, 보존/확산 아님).
- 그 1개 후보 = ZDHHC11 palmitoylation 축(또는 APT1/APT2 depalmitoylase, PDB 5SYN 도킹가능) = senescence↔chondrogenesis 결합노드. 우리 자산이 외부노드 부담을 0.69→0.48로 축소. SSOT=`novelty/fable_step3_target_shortlist.json`.

신규성 = **첫 기질침투 소분자 on palmitoylation 노드**(신규성 PENDING, Step4 후 확정) · 또는 closed-negative(단일분자 삼중게이트 구조적 불가 → co-formulation 필요).

## Step 4 (docking/) — 실행됨 🟢 예비 PASS

- 타깃 **5SYN = APT2/LYPLA2 + ML349(71T)** (Fable "APT1" 오표기 정정: 5SYN은 APT2). depalmitoylase eraser 루트.
- env: mini conda `dock` (smina 2020.12.10 · rdkit 2023.09 · obabel 3.1). 수용체=chain A, box=chain A 71T autobox+8.
- **방법검증**: ML349 재도킹 RMSD **0.46Å**, aff −13.1 (self) / −8.97(pubchem SMILES) · ML348 −9.41.
- **게이트(aff≤−8 AND 순전하+1/2)**: N1–N10 전부 −8.04~−9.00 & +1/+2 → **양팔 통과**. 최상위 N10(−9.00 구아니디늄)·N5(−8.91)·N3(−8.88)·N6(−8.78).
- **대조군 정상작동**: NC1(묻힌양이온) −5.71 · NC2(워헤드없음) −7.46 → 둘 다 −8 못넘고 FAIL = 게이트가 실제 판별.
- SSOT=`docking/dock_results.tsv` · verdict ledger `oa-cartilage-step4-docking`.

### ⚠️ Step4 예비성 한계 (정직)
- N-시리즈는 Fable **근사 워헤드**(2-acylaminothiophene) 위에 구축 — 실제 ML349 코어(thienobenzothiazine) 아님. v2=실제코어 grafting.
- smina **도킹점수**지 MM-GBSA 아님 → 진짜 MM-GBSA = summer OpenMM fep env(무료 GPU) 미실행.
- δ≥0.772는 순전하 기반 추론(Step1 모델), 분자별 재시뮬 아님.

## 신규성 판정 (d_novel_only) — 조립=高신뢰 novel · 분자=PENDING

- **조립 Δ(최강)**: 삼중게이트(침투×청소×동화) 동시만족 구조 + 외부부담 buy-down(0.69→0.48) 정량 = 우리 발명. 외부노드가 novel이든 아니든 무관(composition 신규성).
- **분자 Δ**: 웹 프로브 직접충돌 없음(OA문헌=cPLA2·ACOT12·SOX9-FAO; "양이온 기질침투 APT2 억제제 for 연골" 미발견) → 잠재 novel. **특허(Google Patents/USPTO/Lens) 미검색 → 신규성 PENDING**.
- kill-criteria: cationic/GAG-avid APT2 억제제 or 염기성 exit-vector 단 acylaminothiophene의 연골/관절강 용도 hit 나오면 PUBLISHED/PARTIAL로 강등.
- [ ] Step 3 신규성 target ID (② 확정 시) — kartogenin(filamin-A/CBFβ→RUNX1)·sprifermin·lorecivivint = red-ocean 앵커, 출력 아님.
- [ ] Step 4 docking + MM-GBSA (Pareto 공동게이트: ΔG≤−8 AND δ≥0.772).
- [ ] Step 5 ABFE (summer RTX5070 fep env, 유료 vast는 OOM 시만).

## 신규성 Δ (d_novel_only)

핵심 Δ = **침투×청소×동화 삼중 공최적화를 만족하는 기질-침투 소분자 동화제** (기존 OA 동화제는 전부 단백질이라 δ≈0, 표면만 작용). 또는 이중기전 단일제, 또는 senescence↔chondrogenesis 결합노드 신규 타깃. 또는 δ-wall closed-negative(논문급).
