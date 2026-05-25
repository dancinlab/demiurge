@title: 🔬 CERN — 입자가속기·빔물리 7-verb 스택 (별칭 "가속기 도장")

@goal: 입자가속기/빔물리 7-verb 파이프라인을 public-surface clean-room 으로 구동 — Bethe-Bloch dE/dx · Xsuite optics · LHE event-stats 를 hexa-native parity 까지 끌어올리고, 각 cell 의 absorbed gate 를 정직하게 박는다. `absorbed=true` 는 ALGORITHM closure 한정 — measured-ring optics + Geant4-MC parity 는 downstream wet-lab 확인.

## Milestones (progress)

- [x] `cern + verify` — Bethe-Bloch dE/dx Stage 3 GREEN hexa-native parity (`bethe_bloch_stopping.hexa`, relerr ≤ 4e-10, 4/4 PDG ref points)
- [x] `cern + synthesize` — Xsuite FODO twiss ⨯ Wiedemann/Lee thick-quad closed-form parity (rel err ≤ 1e-6 · `absorbed=true` ALGORITHM closure)
- [x] `cern + analyze` — pylhe LHE event-stats round-trip (synthetic e⁺e⁻→Z→µ⁺µ⁻, 100 events · `absorbed=false` GATE_OPEN)
- [ ] `cern + verify` Geant4-MC — `particle` 모듈 부재 `engine_tool_gap` 해소 → Geant4 stopping-power 본해
- [ ] Bethe-Bloch **Stage 4** — Geant4-MC parity (shell corr · density effect · straggling · nuclear stopping) → absorbed 판정
- [ ] `cern + specify / architect / design / handoff` — 나머지 4-verb stub (lattice/optics deck → TDR handoff schema)
- [ ] measured-ring optics parity — sourced LHC/FCC-ee/SPS deck + measured tune (현재 textbook FODO 한정)
- [ ] **탁상가속기** (LWFA/PWFA) — 가속 메커니즘 축 `plasma-wakefield` cell 개시 (WarpX/FBPIC PIC · §1.5). 커지면 `LPA.md` 로 lazy-split

---

## 0. TL;DR

`domain — CERN` = **입자가속기 / 고에너지물리(HEP) 의 7-verb 스택**. public-surface
clean-room 맵 (상용 FLUKA/CST/OPERA 는 공개문서로만 역량분석, 코드 미접촉).
오픈 빔물리 레이어 (MAD-X · Xsuite · elegant · Geant4) 위에서 cell 을 채운다.

코드 SSOT = `~/core/hexa-lang/stdlib/cern/` (d3). demiurge 는 cockpit producer +
record + export 만 보유.

```
CERN (도메인)
├─ verify     : Bethe-Bloch dE/dx  → hexa-native Stage 3 GREEN (relerr 4e-10)
│               Geant4-MC          → ⏭ particle 모듈 부재 (engine_tool_gap)
├─ synthesize : Xsuite FODO twiss  → absorbed=true (알고리즘 closure, rel 1e-6)
└─ analyze    : pylhe LHE stats    → absorbed=false GATE_OPEN (합성 kinematics)
```

---

## 1. 7-verb 도구 맵 (public-surface · `domains/cern.md` 1:1)

| verb | 오픈소스 | 본 도메인 cell 상태 |
|---|---|---|
| 명세 SPECIFY | (physics case / CDR) | — stub 미작성 |
| 구조 ARCHITECT | (ring/lattice topology) | — stub 미작성 |
| 설계 DESIGN | **MAD-X** · **Xsuite** | — (Xsuite synth 가 사실상 대행) |
| 해석 ANALYZE ⟲ | **elegant** · **Xsuite** · WarpX/BLAST | ✓ pylhe LHE stats · ◐ xsuite analyze |
| 합성 SYNTHESIZE | MAD-X/Xsuite optics matching | ✓ Xsuite FODO twiss (absorbed=true) |
| 검증 VERIFY | **Geant4** · elegant · MAD-X survey | ✓ Bethe-Bloch hexa-native · ⏭ Geant4-MC |
| 인계 HANDOFF | (TDR → construction) | — stub 미작성 |

> 상용 우위 집중 영역 = 3-D RF-cavity + 초전도자석 EM 설계 (CST/OPERA) + 전체
> FLUKA shielding. 오픈 빔-옵틱스/트래킹 레이어는 성숙·운용 가능 (`domains/cern.md` §3·§4).

---

## 1.5 가속 메커니즘 축 (탁상가속기 포함 · scope 결정 2026-05-25)

CERN 도메인은 verb 축과 직각으로 **"어떻게 가속하느냐"** 축을 하나 더 갖는다.
탁상가속기(레이저-플라스마)는 이 축의 한 값이며, 별도 도메인이 아니라 CERN 안에 산다.

| 메커니즘 | 구배 | 스케일 | 대표 코드 | 본 도메인 cell |
|---|---|---|---|---|
| **RF cavity** (관행) | ~수십 MV/m | km | MAD-X · Xsuite · elegant | ✓ 현 cell 전부 (§2) |
| **plasma-wakefield** (LWFA/PWFA · 탁상가속기) | ~수십 GV/m | cm–m | **WarpX/BLAST** · FBPIC · Smilei · OSIRIS | ⏳ 미개시 (milestone) |
| dielectric-laser (DLA) | ~GV/m | µm–mm | ACE3P · 자체 PIC | — deferred |

```
가속 메커니즘 축      ↓ 빔 생성 후 하류는 공통
 RF ───┐
        ├─→ [가속 단계: 코드 진영 분기] ─→ 빔수송·옵틱스 (Xsuite/elegant 공유)
 plasma ┘                                    ─→ 검출기 verify (Geant4 공유)
```

> WarpX/BLAST 는 이미 §1 해석 verb 칸에 등재 — 도구 맵 차원에선 한 지붕 아래.
> **lazy-split 약속**: `plasma-wakefield` cell 이 자체 milestone 을 채울 만큼 커지면
> `LPA.md` 로 분리 (RTSC §9 → NUCLEAR 분리 선례 · ai-native 원칙 4 domain-meta-domain).
> record 에는 지금부터 `accel_mechanism` 필드를 박아 데이터 레벨 축 분리를 선행.

---

## 2. cell 별 현황 + 정직 gate

### 2.1 `cern + verify` — Bethe-Bloch 반양성자 stopping power

| 축 | 값 |
|---|---|
| producer | `stdlib/cern/bethe_bloch_stopping.{py,hexa}` (κ-42 / D65) |
| 물리 | PDG eq. 34.5 closed-form dE/dx · Al·Cu·W·Pb × KE 1 MeV–1 GeV |
| Stage | **Stage 3 GREEN** — hexa-native re-derivation, Python substrate 와 numeric parity (relerr ≤ 4e-10, 4/4 ref) |
| gate | `absorbed=false` · `GATE_OPEN` — Stage 4 (Geant4-MC: shell/density/straggling/nuclear) 필요 |
| Geant4 cell | ⏭ `particle` 모듈 부재 → `engine_tool_gap` (latest `_cellrun.log`) |

> ⚠️ Stage 3 GREEN ≠ absorbed. hexa 포팅이 Python substrate 와 일치함만 증명 —
> 둘 다 동일한 4개 Geant4-MC 보정을 생략. absorbed=true 는 Stage 4 가 필요.

### 2.2 `cern + synthesize` — Xsuite FODO twiss

| 축 | 값 |
|---|---|
| producer | `stdlib/cern/xsuite_optics.py` · xsuite@0.51.1 |
| 물리 | FODO cell (L_d=1 m · L_q=0.1 m · k1=0.25) · 7 TeV proton |
| parity | Xsuite ⨯ Wiedemann §6.2+§7.4 thick-quad closed-form · β_x_max rel err **2.7e-14** · q_x rel err 4.1e-14 |
| gate | `absorbed=true` · `GATE_CLOSED_MEASURED` — **단, ALGORITHM closure 한정** |
| caveat | textbook FODO (실제 ring 미보정) · optics-only (space charge·IBS·impedance·beam-beam 없음) |

> absorbed=true 의 의미 = "Xsuite twiss 알고리즘이 해석 closed-form 과 1e-6 이내 일치".
> *measured* lattice flip 은 sourced ring optics deck + measured tune 필요.

### 2.3 `cern + analyze` — pylhe LHE event-stats

| 축 | 값 |
|---|---|
| producer | `stdlib/cern/lhe_stats.py` · pylhe@1.0.4 (κ-44 / D66) |
| 입력 | 합성 e⁺e⁻→Z→µ⁺µ⁻ @ √s=91.1876 GeV · 100 events |
| gate | `absorbed=false` · `GATE_OPEN` 영구 |
| caveat | LHE 파서 round-trip 단일점 — tuned MC (MadGraph/POWHEG/Sherpa) 아님 · 검출기 시뮬(Delphes/Geant4) 없음 → ATLAS/CMS 직접비교 불가 |

---

## 3. 코드 SSOT + cockpit surface

| 위치 | 파일 |
|---|---|
| stdlib (d3 SSOT) | `~/core/hexa-lang/stdlib/cern/` — `bethe_bloch_stopping.{py,hexa,hexa.stub}` · `xsuite_optics.py` · `elegant_tracking.py` · `lhe_stats.py` · `README.md` |
| cockpit producer | `CernAnalyzeProducer` · `CernAnalyzeXsuiteProducer` · `CernSynthProducer` · `CernVerifyProducer` |
| cockpit record | `CernRecord` · `CernAnalyzeRecord` · `CernAnalyzeXsuiteRecord` · `CernSynthRecord` |
| export | `exports/cern/{verify,synthesize,analyze,lhe,stopping}/<stamp>/` |
| legacy doc | `domains/cern.md` (public-surface map) · `domains/cern.demi` |

---

## 4. 다음 단계 ledger

- [ ] Geant4 + `particle` 설치 경로 (pool ubu-1 / cloud) → `cern + verify` Geant4-MC 본해
- [ ] Bethe-Bloch Stage 4 — Geant4-MC 4-보정 parity round → absorbed 판정
- [ ] `xsuite analyze` cell 산출물 채우기 (현재 빈 stamp dir)
- [ ] specify / architect / design / handoff stub — lattice deck → TDR handoff schema
- [ ] measured-ring deck ingest (sourced LHC/FCC-ee/SPS) → optics parity 확장
- [ ] `plasma-wakefield` cell — WarpX/FBPIC PIC 1-D wakefield 해석 (탁상가속기) · `accel_mechanism` record 필드 선행

---

## 5. Cross-reference

- `domains/cern.md` — public-surface 7-verb 맵 (clean-room boundary)
- `~/core/hexa-lang/stdlib/cern/README.md` — Stage 1/2/3 parity 서술 SSOT
- `~/core/hexa-cern/` — sibling substrate (particle-accelerator)
- RTSC.md §2 Axis A — dipole/quadrupole accelerator magnet 은 CERN 도메인 소속 (RTSC 는 solenoid 기본값)
- D65 (Bethe-Bloch) · D66 (pylhe LHE) — producer SSOT 정책
