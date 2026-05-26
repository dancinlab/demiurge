# 🔌 HEXA-PORT — 외부 수치솔버 hexa 토박이 이식 (alias: "솔버 토박이화" · Native-Solver Port Stack)

@goal: 도메인들이 wrap-as-is 로 끼고 있는 외부 과학계산 백엔드(PDE·FEM·MC 수치솔버 + 평가데이터)를 hexa native stdlib 로 Path A 재구현하고, 각 포트를 wrap-as-is 레퍼런스(=오라클)와의 수치 parity 로 검증(🟢) → absorbed 를 native 커널로 이관. **데이터-바운드 도구(OpenMC류)도 포팅 축에 포함** — 영구 wrap 제외 선언 안 함 (@D d2 · n6/n12/.tape 처럼 맨땅에서 키우는 장기 axis). 가로(infra) 도메인 — FUSION (c)(e)(f) · RTSC H-formulation · CERN 등이 공유.

> 형제 — `FUSION.md` ((c) FreeGS · (e) getdp · (f) OpenMC 의 wrap-run 오라클 공급원) · `RTSC.md` §9~ (H-formulation FEM = P2 getdp 와 공유 substrate) · `NUCLEAR.md` §6.3 Phase 4 (N7 WKB = wrap→parity→Path A 의 **첫 선례** · 본 도메인 방법론의 prototype).

---

## §1. Goal — 알고리즘 vs 데이터, 그리고 둘 다 축에 둔다

도메인들이 끼고 있는 외부 솔버를 hexa native 로 옮긴다. 분류 기준은 **알고리즘이냐 데이터냐**지만, 이는 *난이도 tier* 이지 *포함/제외 경계가 아니다*.

- **알고리즘-정의 솔버** (closed-form · PDE · FEM): 레시피만 옮기면 자체완결 native. → Tier A/B.
- **데이터-바운드 도구** (MC + GB 평가데이터): 알맹이가 외부 데이터. 엔진만 옮겨선 부족 → 데이터 자체를 *별도 포트 sub-axis* 로 (ENDF→hexa atlas corpus, 또는 first-principles 단면적 생성). → Tier C. **제외 아님** (@D d2).

> n6/n12/.tape 선례: 이들도 "맨땅"에서 키운 canonical SSOT 다. ENDF 단면적의 hexa-native corpus(atlas 확장) 또는 first-principles 단면적 생성기도 같은 급의 장기 ambition — "뭔가 나올수도" 를 영구 wrap 으로 닫지 않는다.

---

## §2. 이식성 tier 사다리

| tier | 본질 | 대표 | 포팅 난이도 | 데이터 의존 |
|------|------|------|-------------|-------------|
| **A** | closed-form / 소규모 numerical | Bosch-Hale ⟨σv⟩ · Lawson · Troyon · TF peak · WKB α-decay | ✅ 이미 native (FUSION #1012/1020/1027/1042 · NUCLEAR N7) | 없음 |
| **B** | 알고리즘-정의 PDE / FEM | FreeGS (2D 타원 GS) · getdp (FEM 자기정역학) | 🟡 effort (FD/FEM + 선형 solver) | 없음 |
| **C** | 데이터-바운드 (엔진+평가데이터) | OpenMC (MC 중성자수송 + ENDF/B-VIII) | 🟠 hard · 다단계 | **GB 외부 데이터** → sub-axis 로 분리 포트 |

> tier 는 *언제/어떻게* 의 순서일 뿐 *할까 말까* 가 아니다. A→B→C 순으로 ROI·난이도 오름차순.

---

## §3. 방법론 — wrap → 오라클 → Path A → parity (NUCLEAR N7 선례)

본 도메인의 표준 이식 파이프라인. NUCLEAR `sim.hexa` v0.1.0 (N7 WKB)이 정확히 이 경로로 갔다 (wrap-as-is `wkb_alpha_decay.py` → 31/31 bit-for-bit parity → Path A native).

```
① wrap-as-is 실행      외부 솔버를 pool/cloud 에서 1회 real-run
   (FUSION 이 공급)  →  real 출력 JSON = 진실값
        │
② 오라클 박제          그 출력을 parity 기준선으로 고정
        │
③ Path A 재구현        hexa native 커널 작성 (kernels/<solver>/)
        │
④ parity verify        hexa verify --expr / 전용 parity 하니스로
        │              native vs 오라클 비교 → 🟢/🔵 (g5)
        ▼
   absorbed 이관        parity PASS 시 native 커널이 canonical home
```

honest: parity 가 🟢 나기 전엔 native 커널은 `provisional`. 오라클과 bit/numerical 일치를 paste-verbatim 으로 증명해야 승격 (g5 · LLM 자판단 금지).

---

## §4. 포트 cohort (P0 – P4)

| cohort | 대상 | tier | 오라클 출처 | 비고 |
|--------|------|------|-------------|------|
| **P0** | 이식성 triage 표 | — | 전 도메인 wrap 어댑터 스캔 | algorithm/data 분류 · ROI 랭크 |
| **P1** | FreeGS Grad-Shafranov | B | FUSION (c) wrap-run | 2D FD 타원 PDE + 자유경계 Picard/Newton · 제일 ROI 좋음 |
| **P2** | getdp FEM 자기정역학 | B | FUSION (e) hifi + RTSC §9 | A-φ / H-formulation · RTSC 와 substrate 공유 · multi-week |
| **P3** | hexa 선형대수 substrate | (B 공통) | — | array · sparse solver · P1/P2 공통 의존 — 먼저 깔면 P1/P2 가속 |
| **P4** | OpenMC native | C | FUSION (f) wrap-run | (a) native MC transport 엔진 + (b) **단면적 데이터 corpus 포트** (ENDF→hexa atlas n6-style SSOT) ⊕/OR (c) first-principles 단면적 생성기 (R-matrix·optical model) — @D d2 장기 axis |
| **P8** | Geant4 MC 입자수송 native | C | **CERN (e) wrap-run** | MC 하전입자 수송 오라클 — CERN Bethe-Bloch Stage 4 의 4개 보정(shell·density·straggling·nuclear)을 Geant4-MC 가 공급. P4a(native MC 엔진)와 substrate 공유 (random-walk·충돌샘플링·tally) · 단면적/평가데이터는 Geant4 자체 corpus(ENSDF·particlexs) ⊃ P4b 와 인접. 등록=wrap-as-is 오라클 (native 포트는 후순위). 의존: scikit-hep `particle` (PDG mass/charge) |
| **dep** | `particle` (Scikit-HEP) | A | — | PDG 입자 속성(mass·charge·lifetime) 경량 라이브러리 — CERN Bethe-Bloch / P8 Geant4 검증 입력. closed-form 데이터 lookup (Tier-A 급, 포팅 불필요 · pip 자명 설치) |

### §4.0 데이터 corpus 저장 정책 (사용자 결정 2026-05-25)

데이터-바운드 포트(P4b · 미래 다른 corpus 포트)의 binary/HDF5/대용량 데이터는 **hexa-lang 의 git-LFS** 에 보관 (= hexa-lang 이 SSOT carrier · @D d3 canonical home). git-LFS 가 hexa-lang 의 일반 git 워크플로(worktree·PR) 안에서 그대로 작동 → 별도 데이터 저장소 분리 안 함. 정책:

- 데이터 경로: `data/<domain>/<corpus>/…` (예 `data/nuclear/endf_b8_0/`) 또는 `stdlib/corpora/<corpus>/…` — `.gitattributes` 에 LFS 추적 패턴 명시.
- 기존 stdlib 코드(.hexa·.py·.md)는 LFS 대상 아님 (텍스트 SSOT 유지).
- 기존 >1MB 파일(`n6/atlas.n6`·`compiler/atlas/embedded.gen.hexa` 등)은 별도 마이그레이션 안 함 (atlas SSOT 텍스트 형식 유지 · 위험 없음).
- LFS 인프라 land 후 P4b ENDF/B-VIII (~475MB-2GB 서브셋) ingest 가 첫 corpus 시드.

### §4.1 P4 (OpenMC) 의 정직한 분해 — "뭔가 나올수도"

데이터-바운드라 한 PR 로 안 닫힌다. 3개 독립 sub-path 로 분해하되 **어느 것도 영구 제외 아님**:

- **P4a — native MC transport 엔진**: 입자 random-walk · 충돌 샘플링 · tally. 순수 알고리즘 → hexa 로 작성 가능 (Tier-B 급). 단독으론 데이터 없이 무의미하나 (b)/(c) 의 소비자.
- **P4b — 단면적 데이터 corpus 포트**: ENDF/B-VIII 평가데이터를 hexa-native 형식(atlas F-namespace 확장 · n6 corpus)으로 ingest/repack → "데이터를 외부에서 읽는다"를 "SSOT 가 보유한다"로. **저장 = hexa-lang git-LFS** (§4.0 정책 · `data/nuclear/endf_b8_0/`). n6/atlas 가 검증노드를 쥐는 방식의 확장.
- **P4c — first-principles 단면적 생성**: R-matrix / optical-model 핵반응 이론으로 단면적을 *생성* (읽지 않고 계산). 가장 ambitious — 성공 시 데이터 의존 자체가 사라짐 (@D d6 first-principles 가 데이터-벽 돌파). NUCLEAR 도메인 핵물리와 직접 인접.

honest: P4b/P4c 는 multi-month research-grade. 그러나 ROI 가 낮다고 *제외* 하지 않고 *후순위 axis* 로 둔다 — 선례 n6/n12/.tape 가 그랬듯.

---

## §5. Honest invariants (g3)

- **parity-gated 승격** — native 포트는 오라클과 parity 🟢/🔵 paste-verbatim 전엔 `provisional`. LLM 자판단 금지 (g5).
- **@D d2 (영구 제외 금지)** — 데이터-바운드라도 "native 불가능" 선언 안 함. P4 처럼 sub-axis 로 분해해 돌파 경로 표면화. out-of-scope ≠ impossible.
- **@D d3 (canonical home)** — native 커널은 `hexa-lang/stdlib/kernels/<solver>/` 1곳. demiurge=pointer. wrap 어댑터는 parity 전까지 공존, 승격 후 deprecate.
- **@D d6 (measured-oracle)** — solver 포트의 parity 오라클은 *wrap-run sim* 이지 측정이 아니다. native 포트가 parity PASS 해도 그 도메인 레코드의 `absorbed` 은 measured-oracle 규칙 그대로 (포트는 *계산 경로*를 바꿀 뿐, 측정 지위를 안 바꿈).
- **선형대수 substrate 정직** — hexa array/solver 성숙도가 P1/P2 의 진짜 게이트. P3 를 먼저 점검 (@D d11 pre-rent feasibility-size 정신: 능력 확인 후 착수).

---

## §6. Citations + cross-stack

- **NUCLEAR.md §6.3 Phase 4** — N7 WKB wrap→parity(31/31 bit-for-bit)→Path A `sim.hexa` = 본 도메인 방법론의 작동 선례.
- **FUSION.md §4.0** — (c)(e)(f) wrap-run 오라클 공급원 (PR #1032/1042 + (f) OpenMC promote 진행 중).
- **RTSC.md §9.12 / §4.2.1** — H-formulation FEM (Stenvall/Sirois) = P2 getdp 와 공유 substrate · "multi-week" 난이도 사전경고.
- FreeGS github.com/freegs-plasma/freegs · GetDP getdp.info · OpenMC openmc.org · ENDF/B-VIII (NNDC).
- **Geant4** geant4.org (NIM A 506 (2003) 250-303 · IEEE-TNS 53 (2006) 270-278 · NIM A 835 (2016) 186-225) — MC 입자수송 · **CERN 도메인이 Bethe-Bloch Stage 4 wrap-as-is 오라클 공급** (P8). conda-forge `geant4` 11.3.2 = 공식 python 바인딩 (3rd-party `geant4_pybind` trampoline segfault 회피 경로). scikit-hep **particle** github.com/scikit-hep/particle (PDG mass/charge dep · P8/CERN 입력).
- CalculiX calculix.de (ccx FEM) · SU2 su2code.github.io · OpenFOAM openfoam.com · gmsh gmsh.info — **UFO 도메인이 wrap-as-is 오라클 공급** (응력 ccx 2.23 PR#225 · EM getdp PR#223 · CFD SU2/OpenFOAM · mesh gmsh). UFO 는 외부 solver 로 absorbed 게이트를 닫고(별도 목표), 그 wrap-run 출력이 P5/P6/P7 의 parity 오라클이 된다 (FUSION 과 동일 패턴).

---

Historical log entries are in [`./HEXA-PORT.log.md`](./HEXA-PORT.log.md).

- [ ] P0 — 이식성 tier 분류표 (전 도메인 wrap 어댑터 스캔 → Tier A/B/C · ROI 랭크)
- [x] P0.5 — git-LFS infra in hexa-lang **LANDED** (PR #1090 MERGED · `.gitattributes` 18줄 14 패턴 [data/**/* + stdlib/corpora/**/* × hdf5/h5/dat/bin/endf/ace/xml.gz/tar.gz] + README "Data corpora (git-LFS)" 섹션 · 검증: 신규 경로 `filter: lfs` · 기존 7개 ≥1MB 파일 전부 `unspecified` (sweep 0) · `git lfs ls-files` empty · 마이그레이션 없음)
- [ ] P3 — hexa 선형대수 substrate 점검 (array · dense/sparse solver 성숙도 → P1/P2 feasibility 게이트)
- [ ] P1 — FreeGS Grad-Shafranov native (Tier B · 2D FD 타원 PDE + 자유경계 · FUSION (c) 오라클 parity 🟢)
- [ ] P2 — getdp FEM 자기정역학 native (Tier B · A-φ · FUSION (e) + RTSC H-formulation 공유 · multi-week)
- [ ] P4a — OpenMC native MC transport 엔진 (Tier C · random-walk·충돌샘플링·tally · 데이터 소비자)
- [ ] P4b — 단면적 데이터 corpus 포트 (ENDF/B-VIII → hexa atlas n6-style SSOT)
- [ ] P4c — first-principles 단면적 생성기 (R-matrix/optical · @D d6 데이터-벽 돌파 · NUCLEAR 인접)
- [ ] P5 — CalculiX (ccx) FEM 구조해석 native (Tier B · 3D 탄성 von Mises · UFO 응력 LC-1~5 오라클 PR#225 ccx 2.23 13886-node 공급 · gmsh mesh 공유)
- [ ] P6 — SU2/OpenFOAM CFD FVM native (Tier B · 비압축/압축 RANS · C_d·L/D · UFO CFD 디스크 항공역학 오라클 공급 · multi-week)
- [ ] P7 — gmsh mesh generator native (Tier B utility · OCC + BooleanFragments + Delaunay/frontal · P2 getdp·P5 ccx·P6 CFD 공유 전처리 · UFO 6-coil/disc/frame mesh 오라클)
- [x] P8 등록 — Geant4 11.3.2 MC 입자수송 오라클 (Tier C · CERN Bethe-Bloch Stage 4 의 4-보정 공급) **설치+스모크 PASS** — conda-forge `geant4` 11.3.2 env on pool ubu-1 (Geant4 11.04-patch-01) · `geant4_pybind` import OK · `G4RunManagerFactory.CreateRunManager` 구성 OK · NIST 재질 + 이온화 속성(Si I=173 eV · Water I=78 eV) 조회 OK · **기존 `geant4_pybind` trampoline-ownership segfault 벽 = conda-forge 공식 빌드로 돌파** (exit 0 · 세그폴트 없음)
- [x] dep 등록 — scikit-hep `particle` 0.26.2 (+hepunits 2.4.5) 로컬 설치 검증 (muon mass=105.6583755 MeV·charge=−1 · proton 938.27208816 MeV·charge=+1) — P8/CERN Bethe-Bloch PDG 입력 dep
- [ ] P8 Path A native MC 입자수송 재구현 (Tier C · P4a 와 substrate 공유 · multi-month 후순위 · wrap→오라클→Path A→parity)
