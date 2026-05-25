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
