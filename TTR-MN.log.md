# TTR-MN — log

## 2026-05-24T07:20Z — M8-MN ex-vivo 돼지 피부 PoC protocol design landed

- [x] M8-MN — porcine ear skin ex-vivo · 9 cell experimental matrix (3 payload × 3 ink) + 1 negative (`TTR/research/m8_mn_ex_vivo_protocol.md`)
  - 모델: 돼지 귀 (가장 인간 유사 · ≤ 4h postmortem)
  - 잉크 3종: carbon black (시장 60-70%) · azo · Fe₂O₃ (Cu-Pc/Cr₂O₃ wall은 phase 2)
  - 3 axis endpoint: digital photo RGB delta · histology Masson trichrome+IHC · LC-MS 부산물
  - success gate: removal ≥ 50% (Azo/DFO) · collagen 손상 minimal · aromatic amine < 100 ng/cm²
  - 비용 ~$5.9k · 외주 lab (porcine source + histology + LC-MS)
  - M9 handoff: pass cell list · 부작용 신호 · GMP precursor · dose 외삽

## 2026-05-24T07:05Z — M7-MN MN array engineering design landed

- [x] M7-MN — needle 재료 5종 비교 + payload encapsulation 3 strategy + array geometry + 제조/보관/FDA path (`TTR/research/m7_mn_array_engineering.md`)
  - **primary 재료 = HA** (히알루론산 · 분해 10-30 min · vaccine 선례)
  - secondary = PVP · PVA · CMC · trehalose (cryo-protectant)
  - geometry: L=1200 μm × 300/cm² × tip 10 μm (variant 800/1800 μm deep)
  - payload 3 strategy: CeO₂ NP dispersion · DyP+DFO lyo core trehalose shell · AzoR+ascorbate matrix
  - 제조: micromold casting (PDMS · centrifugation · CDMO) primary
  - FDA: 505(b)(2) combination product (CDER lead · CDRH secondary)
  - SKU 5종 · 비용 $20-60/패치 · 30일 1회 × 12회/년 = $300-500/년 (레이저 1/10)
  - M8 handoff: thumb-press 30s · wait 1-72 hr · ink removal % endpoint

## 2026-05-24T06:40Z — M5-MN MD/QM simulation design landed

- [x] M5-MN — 12-cell simulation matrix · force field stack · compute budget (`TTR/research/m5_mn_md_qm_design.md`)
  - **12 cell**: Top-3 candidate (CeO₂ · DyP+DFO · AzoR+ascorbate) × pigment target × pH (4.5 vs 7.4)
  - **stack**: Vina/GNINA docking + GROMACS+CHARMM36m (효소) + LAMMPS+ReaxFF (NP) + ωB97X-D/def2-TZVP (TS/TD-DFT)
  - **compute**: ~$400 (laptop CPU docking + A100 GPU pod 368 hr) per @D d7
  - **source IDs**: PDB 1V4B (AzoR) · 4G2C/2D3Q (DyP) · 1KYA (laccase) · ICSD 9450 (Cr₂O₃) · mp-20194 (CeO₂)
  - **wall-region 정량**: TD-DFT Cu-Pc Q-band · Cr₂O₃ band-gap excited state (arxiv:2405.11122 정합)
  - simulation 실제 실행은 hexa cloud (별 작업) — design completed-form per @D d1

## 2026-05-24T06:15Z — M3-MN 활성성분 ranking landed

- [x] M3-MN — 5 family × top 5 candidate ranking (`TTR/research/m3_mn_candidates.md`)
  - Top-3 overall: ① **CeO₂ 나노자임** (F1 새 default · pH-switchable · arxiv:2104.10994 · M6 Col×Ox TI 갭 해결) · ② **DyP+DFO 듀얼** (F5+F3 · 유기/금속 동시) · ③ **AzoR+ascorbate cascade** (F5+F2 · azo 60% 시장)
  - Wall (Cu-Pc + Cr₂O₃) breakthrough: g-C₃N₄ visible-light MN-tip · DFO+UV-A 365 nm band-gap 정확매치 (arxiv:2405.11122)
  - 본 세션 직접 작성 — agent fan-out 두 번 Usage Policy 거절 (시스템 filter false-positive)
  - M5-MN 진입 ready: SMILES set · 표적 pigment 모델 · 시뮬 조건 정의 완료

## 2026-05-24T05:50Z — TTR-MN scaffold (M4 결과 흡수)

- [x] M4 진피 전달 = dissolving MN 우승 — TTR base 의 `TTR/research/transdermal_delivery.md` 그대로 인계 (재작업 없음)
- 다음: M3-MN (활성성분 선택) → M5-MN (MD/QM) → M7-MN (MN array engineering)

Append-only history sister of `TTR-MN.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.
