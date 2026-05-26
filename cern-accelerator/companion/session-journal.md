# session-journal — CERN tabletop-accelerator 모노그래프

> 사람-읽기용 한글 narrative. 하루의 작업 arc를 압축한다. 이 SCAFFOLD+BODY 패스의
> 기록이며, fill 배치마다 아래에 append 된다.

## 패스 0 — SCAFFOLD + BODY (2026-05-26)

CERN 도메인(🔬 입자가속기·빔물리 7-verb · "가속기 도장")을 HEXA-FUSION 58-page
모노그래프 구조에 맞춰 모노그래프화. 이 패스는 **body §1-9 + §Full Pipeline +
appendix SKELETON + companion + cover** 까지. 본문 fill 은 다음 배치.

### 한 일

- `feat/cern-monograph` 워크트리를 origin/main 에서 분기 (`/Users/ghost/wt-cern-mono`).
- `cern-accelerator/` 스캐폴드 — fusion 구조(Makefile · preamble · `\tierBlue` 매크로 ·
  §Full Pipeline 표 · `\appendix` 와이어링 · pgfplots) 미러.
- `main.tex` — 9-section spine + §Full Pipeline (탁상가속기 체인 7-stage 표) + §Limitations +
  §Reproducibility. xelatex · tier-disc 매크로(이모지 글리프 부재 대응).
- appendix A–J SKELETON 10종 — 각 `\section`+`\label`+scope intro + `% TODO (fill batch)`.
- `references.bib` — DOI 보유 실참조 16종 (Bethe 1930 · PDG 2024 · Dawson 1959 ·
  Tajima-Dawson 1979 · Esarey-Schroeder-Leemans 2009 RMP · Lehe 2016 FBPIC ·
  WarpX · MAD-X · Xsuite · Wiedemann · Lee · Geant4 Agostinelli 2003 · pylhe ·
  LHE format · Gonsalves 2019 8 GeV LWFA).
- `figures/_scripts/fig03_pipeline.tex` — 7-stage tier-color flow (green=closed, orange=경계).
- `figures/_prompts/cover.txt` + fal.ai cover.png 생성.
- `companion/` — verify-ledger.json · pr-roll.json · session-journal.md · README(Korean).

### 정직 경계 (CERN 의 시그니처 축)

- **closed**: cold-linear closed form (🟢×2) · 1-D linear PIC parity (FBPIC, Δ=3.56%) ·
  FODO twiss (absorbed=true ALGORITHM closure, rel 1e-6) · Bethe-Bloch (🟢, relerr 4e-10).
- **GATE_OPEN 영구**: pylhe LHE event-stats (absorbed=false · synthetic · 검출기 시뮬 없음).
- **downstream 🟠 (clean-room scope 외)**: Geant4-MC Stage 4 (source build + geant4_pybind
  segfault) · 2-D nonlinear blowout PIC (GPU FBPIC/WarpX) · measured-ring optics
  (sourced deck). 도메인 *미완성*이 아니라 외부-dependency hand-off — "불가능" 프레이밍 금지,
  돌파 경로(GPU pod cycle · /micro-exp sweep · external-data ingest) 명시.

### 다음 배치 (fill)

- A: Bethe-Bloch eq.34.5 전개 + 4 PDG ref row + Stage-3-vs-4 honesty box.
- B: cold-linear 식 + density→gradient 표 + selftest 5/5.
- C: FBPIC run-config + field-amplitude 비교 + Δ=3.56% 유도.
- D: thick-quad transfer-matrix + Xsuite-vs-closed-form parity 표.
- E: LHE record schema + per-event kinematic summary + 영구 GATE_OPEN box.
- F: 4 stub verb record-schema + rc=2 _cellrun.log.
- G: 3-row downstream 표 (외부 dependency + hand-off 경로).
- H/I: verify-ledger / pr-roll verbatim 전사 (gh-measured).
- J: per-atom `hexa verify` 호출 목록 + exports/cern/ tree.

---

## 패스 1 — Stage-5 9-PR sweep PARTIAL UPDATE (2026-05-26)

이번 패스는 모노그래프의 PARTIAL EXTEND — 본문 §1-9 구조는 유지하고, **Bethe-Bloch
Stage-4 측정 + Stage-5 보정 본해 + 2-D blowout 전이 sweep + xsuite analyze 셀**
을 appendix 와 본문 단락에 흡수한다. 9개 PR 이 origin/main 에 이미 머지된 상태.

### 한 일 (요약)

- **Geant4 벽 돌파 (hexa-lang #239)** — conda-forge `geant4` env on pool/ubu-1
  (geant4_pybind ABI-매칭). 이전 라운드의 pip geant4-pybind trampoline segfault
  완전히 우회. Smoke PASS — RunManager + NIST materials (I-값 PDG 정확) +
  G4ParticleTable. Stage-4/5 substrate prerequisite.
- **Stage 4 측정 (demiurge #241)** — 28-point Geant4 parity grid (Al/Cu/W/Pb ×
  KE 1-1000 MeV, antiproton, FTFP_BERT). max|Δ|=23.55% Cu@1MeV · mean|Δ|=6.25%.
  Regime-resolved: shell at βγ<0.3 (9-24%) · plateau βγ~0.3-1 (~1%) ·
  density-effect βγ>1 (<1%). **HONEST-FALSE with measured gap** — 검사box 가
  아니라 4개 누락 보정의 물리적 크기를 직접 측정.
- **Stage 5 보정 본해 (hexa-lang #1296 + demiurge #243)** — Sternheimer
  density-effect (PDG eq 34.6) + Andersen-Ziegler 1977 shell + Bloch 1933 L₂ +
  Barkas Ashley-Ritchie-Brandt 1972 L₁ (antiproton z₁=-1 부호 반전). 모두
  textbook 공식, Geant4 에 핏 없음. **mean|Δ|: 6.25 → 4.39% (30% 흡수)** ·
  max 23.55→21.64% (8%) · **mid-plateau 91-98% closed** (Cu@100MeV 98.6%,
  W@30MeV 91.1%, Pb@100MeV 98.4%). 4개 verify atoms 🟢 (sternheimer/shell/
  bloch/barkas). 잔여 솔직-naming: Cu@1MeV 21.64% AZ out-of-calibration η<0.05
  · Pb@1MeV 부호 cancellation reveal · 300-1000 MeV 약간 over (교과서 L1/L2 vs
  Geant4 표 microdiff).
- **2-D blowout 전이 sweep (demiurge #235)** — FBPIC 2-D cylindrical (Nm=2),
  free pool/ubu-1 CPU ($0; GPU 풀-와이드 brokenness → 무료 CPU pivot per @D d11).
  a₀={0.5, 2.0, 4.0} → E_z={1.70, 73.62, 405.64} GV/m = {0.018, 0.766, 4.218}E₀.
  Blowout 전이 재현 — diffraction-limited → bubble onset → deep blowout
  (relativistic boost). Anchor E₀ 🟢 (#1007); PIC field 자체는 sim-wall (g63).
- **xsuite analyze 셀 (demiurge #236)** — 7 TeV proton textbook FODO full 4-D
  twiss-table: β_x/y=83.58/81.52m · Q_x=Q_y=0.0042422 · 자연색수차
  dQ=-0.0042424 · D_x=D_y=0 (dipole-free) · momentum-compaction≈0.
  Synthesize headlines 와 float64 cross-consistent. GATE_OPEN (textbook FODO,
  not measured ring). Env: xtrack 0.104.1 PEP-604 `float|None` → py3.12 필요.
- **CERN.md 룻 reconcile (demiurge #240·#242·#244)** — §4 ledger / §1 verb-map
  / §2.1 gate 갱신 + downstream Geant4 row 갱신.

### 정직 framing 한 줄

- **Stage 4 → Stage 5**: 4개 누락 보정의 측정된 물리 크기를 본해로 30% 흡수.
  나머지 70% 는 textbook 공식의 보정-적합 한계 — 명명된 잔여(AZ η<0.13 out-of-
  calibration · Pb@1MeV 부호 cancellation · 고-βγ L1/L2 microdiff).
- **closure-is-physical-limit**: "stopping-power solved" 가 아니라
  "30% 평균 closure / 91-98% mid-plateau closure — 측정된 textbook 상한,
  잔여는 명명된 물리 한계 클래스." per feedback-closure-is-physical-limit.
- **돌파 경로 (@D d2)**: Stage 6 = ICRU-49/Lindhard-Sorensen · AZ-1989 LEAR p̄ L₁
  · Mott z²α/β · Pb@1MeV physical-floor honest row. 4개 모두 textbook 참조 +
  목표 reduction 명시 — "impossible" 프레이밍 절대 금지.

### 이 패스의 PARTIAL UPDATE 범위 (no structural rewrite)

- appendix A: Stage 4 grid · Stage 5 corrections · 잔여 · Stage 6 paths.
- appendix B+C: 2-D blowout transition sweep · 1-D linear과의 commplementary 표.
- appendix D: xsuite analyze cell · GATE_OPEN 정당화 · py3.12 env footnote.
- appendix H: 4 신규 Stage-5 atoms verbatim 전사 (sternheimer/shell/bloch/barkas).
- appendix I: 9-PR roll (#1296·#235·#236·#239·#240·#241·#242·#243·#244).
- main.tex §Bethe-Bloch / §Plasma-Wakefield / §Limitations / §Future / §Conclusion
  단락 확장. 구조 (§1-9 · appendix A-J) 손대지 않음.
- companion/: pr-roll.json + 9 entries · verify-ledger.json + 4 atoms · 이 journal.
