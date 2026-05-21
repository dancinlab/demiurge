# RTSC — axis taxonomy + per-axis progress board

> Root-level domain expansion. SSOT for "the rtsc work" until each axis
> moves to its own UPPERCASE.md (ai-native principle 4 — domain-meta-domain).
>
> opened: 2026-05-21 KST · status: **axis-split in progress**
> parent ticket: rtsc + verify producer 실제 solve 확장 (Path 4)

---

## 0. TL;DR

`domain — RTSC` 라는 이름이 **두 축을 한 슬롯에 욱여넣은 상태**다:

1. **device 축** — 자석 / 코일 (솔레노이드 · 팬케이크 · 토로이드 · dipole · quadrupole)
2. **conductor material 축** — LTS / **HTS** / RTSC(가설) / 일반 Cu

현재 코드 (`RtscGeometry.swift::htsSolenoidProxy`, `pyfemm_magnetics.py`,
`getdp_hts.py`) 는 전부 **HTS 솔레노이드** — 즉 "device=솔레노이드 · conductor=HTS(REBCO 77 K)"
하나의 cell. 그런데 domain id 는 RTSC(Room-Temp, 300 K) 라서 **이름과 내용물의
온도 영역이 정반대**다. RTSC 는 conductor material 축의 한 값(LK-99 류 가설)에
불과한데 도메인 전체 이름이 돼버렸다.

이 파일에서 두 축을 명시적으로 분리하고, 다른 3개 축(solver / verb / formulation)
까지 5축 progress board 로 펼친다. 그리고 **§8 에서 device-side 와 직각으로 놓인
"물질합성 (material synthesis)" 트랙** — 후보 family · 합성 루트 · falsifier
characterization · demiurge↔hexa-rtsc handoff schema · g3 honest stance — 까지
같이 박는다 (코드 SSOT 는 hexa-rtsc 가 가지되, 문서로는 RTSC.md 가 양쪽을 보유).

---

## 1. Diagnosis (naming collision)

| 증상 | 위치 | 메모 |
|---|---|---|
| domain id "rtsc" 가 device 도메인을 가리킴 | `domains/rtsc.md:1` "RTSC (high-field / superconducting magnet & coil)" | RTSC 는 material category, 도메인 이름 자격 없음 |
| 본문/proxy/producer 가 전부 HTS | `domains/rtsc.md §1 §6` (REBCO · Bi-2212), `RtscGeometry.swift:93` (REBCO HTS tape), `pyfemm_magnetics.py:127` (HTS_proxy), `getdp_hts.py` 파일명 | HTS = 77 K, RTSC = 300 K — 정반대 temperature regime |
| sibling 줄: `room-temp-sc · superconductor` | `domains/rtsc.md:7` | 이건 그래도 "parent 안에 두 material 갈래" 의도지만 parent 이름이 잘못됨 |
| 71 occurrences in cockpit (`grep rtsc`) | LatticeInvariant / RtscGeometry / FalsifierCascade / RtscAnalyzeRecord / RtscVerifyRecord / SiblingRepoSpawner / RtscAnalyze·VerifyProducer / SubstrateLinksLoader / ActionDispatch | rename 시 7+ 파일 + record schema 마이그레이션 필요 |

---

## 2. The 5 axes (proposed split)

### Axis A — device geometry

| 값 | 형상 | 2-D axisym? | 현재 코드 | 진행 가능 (this session) |
|---|---|---|---|---|
| **솔레노이드** | 직사각 단면 환형 권선 | ✓ | `RtscGeometry::htsSolenoidProxy`, `solenoid_axisym.geo` (작성 중) | ✓ — 본세션 작업 cell |
| 팬케이크 | 평면 나선 (radial 권선) | ✓ (z=0 평면) | — | pancake_axisym.geo stub 추가 가능 |
| 토로이드 | toroidal coil (D자형) | ✗ (3-D) | — | 3-D 메쉬 — 별도 cohort |
| dipole | accelerator bending magnet | △ (2-D cross-section) | — | cern 도메인 (별개) |
| quadrupole | accelerator focusing magnet | △ (2-D) | — | cern 도메인 (별개) |

→ **이 도메인의 device 기본값은 solenoid**. dipole/quadrupole 는 `cern` 도메인에 살아야 함 (이미 `CernSynthProducer` 등 분리됨).

### Axis B — conductor material

| 값 | Tc (K) | Jc 모델 | 본 세션 producer 적용 | 메모 |
|---|---|---|---|---|
| Cu (normal) | — | σ(T) (Wiedemann-Franz) | linear nu=1/μ₀ 로 즉시 가능 | baseline |
| LTS NbTi | 9 | Bean / Kim Anderson | μ_r linear 근사 OK <2 T | baseline 코일 |
| LTS Nb₃Sn | 18 | scaling law (Summers/Bordini) | linear 근사 | ITER / 8 T 급 |
| **HTS REBCO** | ~93 | E-J power law (n=20-30), J_c(B,T,θ) anisotropy | **본 세션 cell** — linear μ_r=1 근사 (저전류 한정) | 본 producer 의 default. HONEST: 임계상태/quench 미적용 |
| HTS Bi-2212 | ~85 | E-J power law (n=10-15) | linear 근사 | round-wire 가능 → 등방 |
| RTSC (가설) | ~300 (LK-99 등) | **empirically unproven** | μ_r=1 가정 (재현 미확정) | hexa-rtsc 의 falsifier preregister 영역 (43/43 closure 별개) |

→ producer 입장에서 B 축은 **(a) μ_r 값 결정 (b) source J_phi = N·I / A_coil (c) saturation guard** 3가지로 환원. 본 세션은 (a)=1, (b)=parametric, (c)=경고만.

### Axis C — solver / verification path

| 솔버 | 차원 | 설치 | 본 세션 cell | 메모 |
|---|---|---|---|---|
| **GetDP** | 2-D axisym + 3-D | macOS arm64 binary 다운로드 진행 중 (3.5.0-r) | **본 producer 의 backend** | A-φ formulation; H-A-φ HTS 본해는 multi-week |
| Gmsh | mesh only | brew installed ✓ | mesher 로 사용 | OK |
| pyfemm | 2-D axisym | macOS=blocked (Windows binary + Wine) / Linux pool=OK | 별도 cell (κ-48 analyze) | 이미 platform-gated record 떨굼 |
| Elmer | 2-D/3-D | brew available | 미사용 | 후보 |
| scipy closed-form | analytic | numpy/scipy ✓ | 추가 가능 (cross-check) | Wheeler / Lorentz 공식, on-axis only |
| ANSYS Maxwell / COMSOL | 3-D coupled | 상용 (public docs only) | 미사용 | clean-room 위반 |
| HTS Workgroup `.pro` files | 3-D HTS | downloadable | 미사용 — multi-week scope | 본해 reference |

### Axis D — verb (7-verb spine)

| verb | 현재 producer | 본 세션 작업 |
|---|---|---|
| 명세 SPECIFY | (없음) | stub만 가능 — target field/current/temp spec text |
| 구조 ARCHITECT | (없음) | `RtscGeometry::htsSolenoidProxy` 자체가 architect 산출물 격 |
| 설계 DESIGN | (없음) | 본 세션 범위 밖 (FEMM winding definition 영역) |
| 해석 ANALYZE | `RtscAnalyzeProducer` → `pyfemm_magnetics.py` (Linux pool) | 이미 κ-48 landing, macOS=platform-gated skip |
| 합성 SYNTHESIZE | (없음) | FEM Magnetics Toolbox 영역, FEMM 종속 → 별개 |
| **검증 VERIFY** | `RtscVerifyProducer` → `getdp_hts.py` (record-only) | **본 세션 — 실제 solve 로 확장** |
| 인계 HANDOFF | (없음) | winding/cryostat fab handoff doc — 본 세션 범위 밖 |

### Axis E — formulation (EM physics layer)

| formulation | 차원 | HTS-grade? | 본 세션 |
|---|---|---|---|
| **Magnetostatic A-φ** (linear) | 2-D axisym | ✗ (선형 매질만) | **본 producer 의 default** — 저전류 한정 |
| Magnetostatic A-φ (nonlinear B-H) | 2-D | iron yoke OK / HTS ✗ | 후속 |
| MagDyn A-V (transient) | 2-D/3-D | ramp-loss 가능 | 후속 |
| H-formulation (A. Stenvall) | 2-D/3-D | ✓ HTS E-J power law | hexa-rtsc 의 `numerics_tdgl_vortex.hexa` 와 인접; multi-week |
| H-A-φ coupled (Sirois) | 3-D | ✓ HTS REBCO tape stack | arxiv:0811.2883 — multi-week |

→ 본 세션은 가장 얇은 layer (선형 magnetostatic) 만. 헤드라인 측정: B_center, B_max(on-axis), L = 2W/I².

---

## 3. State matrix (axis × axis)

기호: ✓ done · ◐ in-flight (this session) · ○ workable · ✗ blocked · — N/A

### 3.1 device × verb (device-side)

|              | 솔레노이드 | 팬케이크 | 토로이드 | dipole | quadrupole |
|---|:---:|:---:|:---:|:---:|:---:|
| Cu  · analyze | ✗ pyfemm macOS-gated | ○ | — (3-D) | — (별 도메인) | — |
| HTS · analyze | ✓ κ-48 record (Linux pool 본해) | ○ | — | — | — |
| HTS · **verify** | ✓ 본 세션 cross-check Δ=-1.40% | ○ | — | — | — |
| HTS · design | ✗ FEMM 종속 | ○ | — | — | — |
| RTSC · verify | ✗ empirically unproven — hexa-rtsc falsifier 영역 | — | — | — | — |

### 3.2 material-side (§8 — 합성/특성평가 트랙)

|              | LTS | MgB₂ | FeSC | HTS Cuprate | Hydride | TBG | LK-99 | hexa-rtsc n=6 |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 합성 (synthesis) | ✓ industry | ✓ industry | ✓ lab | ✓ industry | △ DAC only | △ lab | ✗ claim only | — closed-form only |
| Meissner 검증 | ✓ | ✓ | ✓ | ✓ | ✓ (under GPa) | ✓ | ✗ | — |
| device-side ingest | ○ vendor datasheet | ○ vendor datasheet | ✗ | ◐ §8.5 schema | ✗ (압력 풀면 unstable) | ✗ | ✗ never (claim-only) | ✗ never (empirically unproven) |
| demiurge absorbed? | 가능 if datasheet ingest | 가능 | 미정 | 가능 if Jc table | 절대 (device 불가) | 절대 (1.7 K) | 절대 | 절대 |

---

## 4. In-flight (this session, 2026-05-21)

### 4.1 작업 단위 (one cell)
device=**솔레노이드** · conductor=**HTS REBCO (μ_r≈1)** · solver=**GetDP 3.5.0** · verb=**verify** · formulation=**2-D axisym A-φ 선형 magnetostatic**

### 4.2 진행 상태 (세션 종료 시점 스냅샷)

| step | 상태 | 산출물 |
|---|---|---|
| getdp 바이너리 확보 (macOS arm64, Rosetta) | ✓ getdp 3.5.0 (`bin/getdp`, x86_64, Rosetta 경유) | `~/local/getdp/getdp-3.5.0-MacOSX/bin/getdp` (PATH 미등록; `$GETDP_BIN` env로 producer 인식) |
| `solenoid_axisym.geo` 파라메트릭 템플릿 (OCC + BooleanFragments) | ✓ | `~/core/hexa-lang/stdlib/rtsc/templates/solenoid_axisym.geo` |
| `solenoid_axisym.pro` 파라메트릭 템플릿 (Form1P A-φ, axis Dirichlet) | ✓ | `~/core/hexa-lang/stdlib/rtsc/templates/solenoid_axisym.pro` |
| `getdp_hts.py` 5-axis 확장 (closed-form V1 + getdp V2 + 2π post-correction + cross-check) | ✓ | `~/core/hexa-lang/stdlib/rtsc/getdp_hts.py` |
| `RtscVerifyRecord` 5-axis 스키마 | ✓ | `cockpit/Sources/DemiurgeCore/Models/RtscVerifyRecord.swift` |
| `RtscVerifyProducer` nested-dir fix | ✓ | `cockpit/Sources/DemiurgeCore/Loaders/RtscVerifyProducer.swift` |
| 첫 closed-form-only record (FEM install-gated skip) | ✓ | `exports/rtsc/verify/2026-05-21T05-27-14Z/...` |
| **첫 cross-check record (FEM + closed-form)** | ✓ | `exports/rtsc/verify/2026-05-21T06-06-21Z/rtsc_verify_20260521T060621Z.json` |

### 4.2.1 cross-check record headline (V1 closed-form ⨯ V2 getdp FEM)

```
device       = solenoid (L=200 mm · r∈[30,55] mm · 120 turns · I=100 A)
conductor    = rebco_hts_linear_mu1  (HONEST: μ_r=1 가정, HTS critical state 미반영)
solver       = getdp 3.5.0 (Rosetta) + scipy closed-form
formulation  = magstat_a_axisym_linear (Form1P A-φ · VolAxiSqu · OCC mesh)

                  closed-form     FEM            Δ
B_center [T]      0.06939        0.06842        -1.40%   ← excellent agreement
B_max_axis [T]    0.06939        0.06842        (= B_center; both)
L [μH]            431.0 (Wheeler) 340.2 (FEM)   -21%    ← Wheeler은 thin-coil 근사 한계 (b/a=1.83 thick)
W [J]             2.155          1.701          (∝ L)

gate_type        = hexa-native-absent  (D80: getdp 미흡수 — hexa-native EM 커널 없음)
absorbed         = false
measurement_gate = GATE_OPEN
provisional      = true
```

### 4.2.1.b Stage 1+2 cohort 결과 (post-FEM cross-check)

세션 후속에서 5축 cell 을 더 확장 + material 트랙도 평행 진행:

| Stage | Cohort | 산출물 | 핵심 결과 |
|---|---|---|---|
| 1 | M5 (hexa port) | `stdlib/material/sim.hexa` | hexa-native 4-formula port (BCS · McMillan · AD · WHH) — Python sim_adapter 와 **0.0000 K 차** (libm 정밀도) |
| 1 | D1 (HTS Workgroup) | `stdlib/rtsc/templates/hts_workgroup/{benchmark1_tape,life_hts_pancakes_ref}/` | 외부 reference benchmark provenance manifests. **license-unclear → 콘텐츠 vendor 거부**, fetch.sh + gitignored `_external/` 캐시. |
| 1 | M4 (MPRester) | `stdlib/material/mp_query.py` | Materials Project REST API thin adapter. 3-gate path (install · api-key · external-api) 전부 honest skip 검증. |
| 2 | GetDP 4.0.0 ARM | `~/local/getdp/getdp-4.0.0-MacOSARM/bin/getdp` | Apple Silicon native (Rosetta 불필요). `RhoPowerLaw` 내장 → HTS Workgroup .pro 즉시 실행 가능. |
| 2 | F (Tier 4 dispatch) | `MaterialVerdictRecord.swift` + `MaterialFalsifierDispatch.swift` + XCTest 2건 | **LK-99 first verdict (HONEST DEMO)** — `exports/material_verdict/lk99_lee2023_v1/2026-05-21T08-58-24Z.json` — aggregate_verdict=FAILS-AT-LEAST-ONE, F-RTSC-3 replication FAIL (Tier 2 replicated=0), 나머지 SKIPPED-MISSING-INPUT. **absorbed=false 불변** (testAbsorbedAlwaysFalseEvenWithReplication 보호). |
| 2 | G (H-formulation adapter) | `stdlib/rtsc/h_formulation_adapter.py` | 3 skip mode (license-unclear · install-gated · getdp_solve_timeout) — getdp_hts.py 의 gate-landing 상태 유지하면서 별 파일로 H-formulation 진입 경로 확보. |

### 4.2.1.c HTS Workgroup H-formulation 본해 실증 (cube benchmark)

GetDP 4.0.0 + life-hts `cube` benchmark (single SC cube, RhoPowerLaw E-J power law) 로 **진짜 H-formulation transient solve 가 macOS Apple Silicon 에서 동작 확인**:

```
solver        = GetDP 4.0.0 ARM native
benchmark     = life-hts/cube/cube.pro (HTS Modelling Workgroup ref)
formulation   = H-formulation (h-φ MagDyn) · RhoPowerLaw E-J power law
mesh          = 1937 nodes / 5589 elements (3-D tet)
DOFs          = 3601
solver iter   = MUMPS LU (PETSc) · KSP residual ~1.9 → 5e-16 per time-step (수렴)
post-ops      = MagDyn_energy 8/8 per time-step (정상 진행)
gate_type     = hexa-native-absent (D80)
absorbed      = false  (외부 reference benchmark, license-unclear 콘텐츠)
measurement   = transient solve 정상 — full-cycle 완주는 별 cohort
```

→ **세션의 진짜 결론**: 4.2.1 의 linear A-φ FEM cross-check (Δ=-1.40%) 위에 **HTS-grade H-formulation 본해 toolchain 이 완전히 동작**한다는 것을 가벼운 cube benchmark 로 확정. §4.3 의 (s1) "linear magnetostatic — HTS critical state 미반영" caveat 의 *해결 경로가 실제로 열려 있음*. 다음 단계는 cube 본해 결과 풀-사이클 수렴 + life-hts/benchmark1_tape 의 EUCAS REBCO tape 실측 비교.

### 4.2.2 디버그 여정 (참고 — 동일 패턴 재발 시 빠른 진단)

5축 producer를 실제 solve로 확장할 때 부딪힌 4가지 함정 — 둘 다 "FEM이 돌긴 도는데 결과가 이상함" 류:

1. **placeholder prefix collision** — `$R_OUT` substitution이 `$R_OUTC`까지 잡아먹어 `0.25C` 라는 invalid identifier 생성. 길이 내림차순 치환으로 해결 (`getdp_hts.py::_render_template`).
2. **gmsh classical kernel edge-recovery 실패** — `Curve Loop` 내부 hole 으로 정의한 coil 경계를 air 표면이 회수 못 함 (19 warnings, "Impossible to recover edge"). **OpenCASCADE + BooleanFragments** 로 air-around-coil 을 사전 stitch 시켜 해결.
3. **Form1P scalar js → 0 RHS** — `js[Coil] = scalar` 로 정의하면 `[ -js[], {a} ]` 가 RHS=0 떨굼 (perpendicular-edge 테스트 함수가 vector라 scalar inner product 가 0). `js[Coil] = Vector[0, 0, J_phi]` 로 perpendicular-z 벡터 명시.
4. **axis(r=0) DOF unconstrained → numerical garbage** — `VolAxiSqu` Jacobian이 r²·A_φ 치환으로 r=0 특이점을 *암묵적으로는* 처리하지만, Form1P node DOF에 명시 Dirichlet 안 걸어주면 axis 근처 B field 가 wild artifact (B_max=0.168 T at z=-0.12, outside coil!). `Constraint Axis → 0` 명시 추가하니 즉시 깨끗해짐 (B_max = B_center, 1.4% closed-form 일치).
5. **VolAxiSqu 2π 누락** — getdp의 axisym Jacobian은 (r,z) 평면 적분만 하고 azimuthal 2π 적분은 user post-multiplication. Stored energy / L 계산 시 producer에서 `w_stored *= 2π` 보정 (`getdp_hts.py` parse 단계).

이 5개 함정은 흔한 패턴이라 RTSC.md 영구 보존. 동일한 5-axis 시각화/검증을 다른 device(pancake, toroid) 로 확장할 때 1·2·5 는 그대로 재발할 수 있음.

### 4.3 honest scope caveats (record 에 반드시 박을 것)

- (s1) 선형 magnetostatic — HTS critical state / quench dynamics 미포함
- (s2) 2-D axisym — leads / support / 3-D return path 미포함
- (s3) μ_r=1 가정 — HTS magnetization (M ≠ 0) 미반영, persistent current 미포함
- (s4) procedural geometry — sourced coil 아님; absorbed=false, GATE_OPEN

---

## 5. Per-axis next-step ledger (this session에서 progress 가능한 것들)

### Axis A — device
- [x] **솔레노이드** geo template 작성
- [ ] 솔레노이드 .pro template 작성
- [ ] **팬케이크** geo stub 추가 (`pancake_axisym.geo`) — 동일 .pro 재사용 가능
- [ ] device enum 추가 (`RtscDevice = solenoid | pancake | toroid`), default=solenoid
- [ ] (deferred) 토로이드 — 3-D 별 cohort

### Axis B — conductor material
- [ ] `ConductorMaterial` enum 추가 (cu | nbti | nb3sn | rebco | bi2212 | rtsc_hypothetical)
- [ ] producer 파라미터로 받아 J_phi 계산에 N·I/A 만 사용 (μ_r=1 공통)
- [ ] record 에 `conductor` 필드 박기 (default="rebco_hts")
- [ ] (deferred) Jc(B,T,θ) data table — 측정/문헌 참조 필요, 별 PR

### Axis C — solver
- [x] gmsh 4.15.2 확보
- [ ] getdp 3.5.0 (다운로드 완료 대기)
- [ ] solver path enum 추가 (`getdp | pyfemm | scipy_analytic`)
- [ ] **scipy closed-form parallel verifier** 추가 (`getdp_hts.py` 에서 cross-check) — Wheeler formula on-axis B
- [ ] (deferred) Elmer 후보

### Axis D — verb
- [x] verify (본 세션)
- 그 외 verb 는 본 세션 범위 밖. 단 record schema 는 4축 (device·conductor·solver·formulation) 동일하게 분리해두면 향후 verb 추가 시 재사용

### Axis E — formulation
- [x] 2-D axisym A-φ 선형 (본 세션)
- [ ] formulation enum 추가 (`magstat_a_linear | magstat_a_nonlinear | magdyn_av | h_formulation`)
- [ ] (deferred) nonlinear B-H — iron yoke 옵션 받을 때
- [ ] (deferred) H-formulation — HTS-grade, multi-week

---

## 6. Domain rename plan (NOT this session)

축 분리만으로는 "이름과 내용이 반대" 문제는 안 풀림. 별도 PR 로:

- **옵션 B (권장)** — domain id `rtsc` → `sc-magnet` (또는 `hts-magnet` / `magnet`). cockpit Rtsc* prefix → Magnet* / SCMagnet*. RTSC(상온) 는 conductor 축의 한 값으로 내려가고, hexa-rtsc 리포는 sibling material 영역 (room-temp-sc + superconductor) 그대로 유지.
- 코드 footprint: 71 grep hit, 7 파일 + record schema (`rtsc_analyze_*.json`, `rtsc_verify_*.json` 파일명 prefix). 마이그레이션 PR 1건 + record codec backward-compat alias 1개.
- `domains/rtsc.md` 헤더 + sibling 줄 + 본문 §1 §6 다시 씀.
- 이 RTSC.md 는 그 PR landing 후 `SC-MAGNET.md` 로 rename + 헤더 disclaimer 갱신.

본 세션에서는 **rename 보류**, 대신 record 에 `domain`, `device`, `conductor`, `solver`, `formulation` 5필드를 모두 박아 *데이터 레벨에서는 축 분리가 이미 끝나 있게* 만든다. 다음 PR 에서 이름만 갈아끼우면 됨.

---

## 7. Cross-reference

- `domains/rtsc.md` — legacy domain doc (rename 대상)
- `~/core/hexa-rtsc/` — sibling material substrate (n=6 closed-form, falsifier preregister, 43/43 closure). **별개 substrate** — 이쪽은 RTSC 물질 자체의 empirical falsifier 트랙.
- `inbox/notes/cohort-pickup-rtsc-femm-producer.md` — κ-35 pickup note, 본 세션 Path 4 진행의 출발점
- `~/core/hexa-lang/stdlib/rtsc/{getdp_hts.py, pyfemm_magnetics.py}` — substrate SSOT
- `~/core/hexa-lang/stdlib/rtsc/templates/` — `.geo`/`.pro` parametric templates (신설)
- D61 — producer SSOT 위치 정책
- D72 — em-kernel promotion candidate (pyfemm + getdp 2 consumers)

---

## 8. 물질합성 (material synthesis) — domain의 다른 반쪽

지금까지 §1–§7 은 전부 **device-side** (자석/코일 engineering: 주어진 conductor가 있을 때 어떻게 감고 어떻게 자기장을 풀어내는가). 그런데 RTSC 라는 이름의 진짜 출신지는 **material-side** — *어떤 물질이 상온에서 R=0 인가, 그리고 어떻게 만들 것인가*. 이 §은 그 반쪽을 RTSC.md 안에 정합적으로 박는다.

### 8.1 두 트랙의 분리

```
┌──────────────────────────────────┬───────────────────────────────────────┐
│  device-side (이 repo · demiurge) │  material-side (~/core/hexa-rtsc)     │
├──────────────────────────────────┼───────────────────────────────────────┤
│ 입력: conductor record (Tc · Jc · │ 입력: BCS / Eliashberg / DFT 후보       │
│       Hc2 · 이방성 등)           │       물질 family + 합성 레시피         │
│ 출력: B-field map · L · stored E ·│ 출력: T_c 예측 · falsifier 통과 여부 ·   │
│       coil winding/cryostat 사양 │       Meissner / R(T) 데이터           │
│ 도구: gmsh · getdp · pyfemm ·     │ 도구: hexa-lang verify scripts (35개) · │
│       FEM (EM)                    │       arxiv 메타 audit · DFT 외부 호출 │
│ verb 위치: 검증 VERIFY (본세션) +  │ verb 위치: hexa-rtsc 자체가 substrate · │
│             해석/설계 등          │       n=6 closed-form spec PR 형태     │
│ 절대 안 다루는 것: T_c 자체가       │ 절대 안 다루는 것: 코일 권선 / 자력선   │
│   몇 K냐, 합성이 가능하냐         │   배치 / cryostat (= device-side)     │
└──────────────────────────────────┴───────────────────────────────────────┘
```

→ **demiurge 의 rtsc 도메인은 device-side 만 직접 다룬다**. material-side 의 진척은 hexa-rtsc 가 가지고, demiurge 는 그 결과(예: "REBCO Jc(B,T,θ) tape spec record")를 *consume* 한다. 본 RTSC.md 는 양쪽 트랙을 모두 *문서로는* 보유하지만 *코드 SSOT 는 분리*되어 있음.

### 8.2 Candidate material families matrix

| family | Tc 범위 | 대표 화합물 | 합성 난이도 | empirical status (2026-05) |
|---|---|---|---|---|
| **LTS** (저온) | 4–18 K | NbTi · Nb₃Sn · Nb₃Ge | low (industry mature) | ✓ replicated 60+ years · MRI/LHC standard |
| **MgB₂** | ~39 K | MgB₂ (단일 화합물) | low–mid (PIT wire) | ✓ replicated 2001~, 상용화 |
| **Iron-based** (FeSC) | 25–55 K | LaFeAsO · BaFe₂As₂ · FeSe | mid (single crystal hard) | ✓ replicated 2008~, no large-scale device yet |
| **HTS Cuprates** | 77–135 K | YBCO (REBCO) · BSCCO · Hg-1223 | mid–high (텍스처 제어) | ✓ replicated 1986~, 본 데모 producer 의 default |
| **Heavy hydrides** (≥GPa 압력) | 200–260 K | H₃S · LaH₁₀ · CaH₆ · ScH₉ · YH₆ | very high (DAC + 150 GPa) | ✓ replicated 2015~ (Eremets 등), **GPa 압력 풀면 unstable** — device 불가 |
| **Twisted bilayer graphene** | ~1.7 K (UTBG) | TBG @ 1.1° magic angle | high (exfoliation + alignment) | ✓ replicated 2018~ (Cao/Jarillo-Herrero) |
| **LK-99 family** | 가설 300 K | Pb₁₀₋ₓCuₓ(PO₄)₆O (가설) | low (claimed) | **✗ NOT replicated** — Lee et al 2023, 후속 다수 실패 |
| **hexa-rtsc n=6 candidate** | 가설 300 K | n=6 σ·τ=48 closed-form spec | ? | **closed-form only** — `~/core/hexa-rtsc` falsifier preregister, 합성 sandbox 부재 |

→ 본 producer의 `conductor=rebco_hts_linear_mu1` default 는 위 표의 **HTS Cuprates** 행. RTSC 가설(LK-99 / hexa-rtsc n=6)은 *실제 device 권선의 입력으로 사용 금지* — empirical proof 가 없음. demiurge 가 가설 물질을 "absorbed=true" 로 기록하면 그 자체가 g3 위반.

### 8.3 합성 루트 (synthesis routes)

| 루트 | 적용 family | 대표 장비 | 본 세션 demiurge 영역? |
|---|---|---|---|
| **Solid-state reaction** | LK-99 · Cuprates · MgB₂ · FeSC | 박스 furnace · 진공 ampoule | ✗ — material-side만 |
| **Diamond Anvil Cell (DAC)** | Heavy hydrides | DAC + Raman + 라이저 | ✗ — material-side, 압력 풀면 무너짐 |
| **Single-crystal growth** | Cuprates · FeSC · TBG | melt-textured / floating-zone / CVT | ✗ |
| **MOCVD · sputtering · PLD** | REBCO tape · 박막 | reactor · target · 기판 | ✗ (외주 / 상용 tape 매입) |
| **Twisted exfoliation** | TBG | scotch-tape + AFM + 정렬 | ✗ |
| **Sol-gel + 소결** | Cuprates (Bi-2212 round wire) | precursor 합성 + draw + heat | ✗ |
| **합금 가공 (PIT wire)** | NbTi · Nb₃Sn · MgB₂ | drawing / bundling / 열처리 | ✗ |

→ **모든 row 의 demiurge 영역 = ✗**. demiurge 는 합성을 *직접 수행/시뮬* 하지 않음. 합성 결과로 나온 conductor 의 *측정된 spec* 만 consume.

### 8.4 Characterization (falsifier set) — "RTSC인지 어떻게 검증하나"

material-side 의 verify verb. hexa-rtsc 의 35 verify 스크립트 + 6 falsifier (F-RTSC-{1,2,3} + F-SC-{1,2,3}) 가 여기에 정렬됨.

| 테스트 | 측정량 | 통과 조건 (RTSC claim) | hexa-rtsc verifier |
|---|---|---|---|
| **R(T) drop** | 4-probe 저항 vs T | T<Tc 에서 R → 0 (실험 noise 한도) | `empirical_lk99_arxiv.hexa` 등 |
| **Meissner 효과** | 외부 B-field 차폐 (zero-field-cooled / field-cooled) | χ < 0 (반자성) · 자기 levitation | `empirical_abrikosov_sans_arxiv.hexa` |
| **AC susceptibility** | χ'(T,ω) · χ''(T,ω) | dissipation peak @ Tc | (hexa-rtsc verify pool 포함) |
| **Specific heat 도약** | Cp(T) at Tc | BCS 도약 ΔCp/γT_c ≈ 1.43 | `empirical_specific_heat_arxiv.hexa` · `calc_bcs.hexa` |
| **Isotope effect** | Tc vs isotope mass | T_c ∝ M⁻ᵅ (α ≈ 0.5 BCS) | (BCS 검증 트랙) |
| **Hc2 측정** | resistive transition vs B | WHH 외삽으로 Hc2(0) | `calc_hc2_48t.hexa` · `numerics_whh_full.hexa` · `numerics_hc2_48t*.hexa` |
| **McMillan/Allen-Dynes** | λ · ω_log · μ* 로 Tc 예측 | predicted Tc 일관성 | `calc_mcmillan.hexa` · `numerics_mcmillan*.hexa` |
| **Vortex lattice (Abrikosov)** | STM/SANS 로 vortex 격자 관측 | type-II SC 확인 | `empirical_abrikosov_sans_arxiv.hexa` · `numerics_tdgl_vortex.hexa` |
| **DFT band structure** | first-principles N(E_F) · λ | EM coupling 추정 | `numerics_lk99_dft.hexa` |

→ "RTSC 라고 주장한다" → 위 9개 테스트 중 최소 **R(T)=0 + Meissner + 재현성** 3 개를 동시에 통과해야 함. LK-99 류는 R(T) 단독 (재현 실패) 까지만 통과 → "claim only" 영역. hexa-rtsc 는 본 9-test 매트릭스의 closed-form 일관성을 43/43 닫았지만 **empirical sandbox 없음** (= 진짜 합성+측정이 없음).

### 8.5 demiurge ↔ material-side handoff schema (planned)

본 세션에서 진짜 wire 는 안 함 — 다음 PR 의 ingredient. 현재는 schema 만 박음:

```yaml
# ~/core/demiurge/exports/conductor/<family>/<stamp>/conductor_<id>.json
domain: conductor
verb: ingest                       # material-side → device-side handoff
kind: rebco_2g_hts_tape
stamp: 2026-XX-XXTXXZ
provenance:
  source_substrate: hexa-rtsc      # or external paper / vendor datasheet
  source_record_url: ...
  vendor: SuperPower / Fujikura / SuperOx / ...
spec:
  family: hts_cuprate
  compound: "YBa2Cu3O7-δ"
  Tc_K: 92.5
  Hc2_T_at_4K: 150
  Jc_data_table_url: ...           # J_c(B, T, θ) typed table
  anisotropy_gamma: 5.0
absorbed: false                    # device-side absorption 별개
gate_type: vendor-datasheet | hexa-rtsc-derived | external-paper
provisional: true
scope_caveats:
  - "Vendor datasheet Jc curves — not per-batch lot-tested"
```

→ device producer (`getdp_hts.py` 등) 가 시작할 때 위 record 를 읽어 `nu[Coil]`, `Jc_limit`, `Hc2_limit` 같은 함수를 채워야 함. 본 세션은 그 단계 전 — `nu=1/μ₀` 상수 + 임계상태 미반영 (s1/s3 caveat 으로 명시).

### 8.6 진행 가능한 작업 (this session에서 actionable / deferred)

#### 본 세션에서 즉시 가능 (record-level)
- [x] §8 작성 — RTSC.md 의 material-side 반쪽 문서화 (본 작업)
- [ ] `exports/conductor/` 디렉토리 + handoff schema stub JSON 1개 (HTS REBCO baseline, vendor=null, source=hexa-rtsc-derived)

#### deferred (별 PR)
- [ ] hexa-rtsc 의 `numerics_*_solver.hexa` 35개 verifier 결과를 `exports/conductor/hexa-rtsc-baseline/` 로 ingest 하는 thin adapter
- [ ] `ConductorRecord` Swift 모델 + `ConductorLoader` (DemiurgeCore) — `RtscAnalyzeProducer` / `RtscVerifyProducer` 가 시작 시 conductor record 1건을 인자로 받는 형태로 리팩
- [ ] `ConductorMaterial` enum (§5 Axis B 의 ledger 와 동일) — record 의 `spec.family` 와 1:1
- [ ] vendor datasheet ingest (예: SuperPower 2G HTS tape Jc(B,T,θ) CSV)
- [ ] LK-99 / hexa-rtsc n=6 후보를 `absorbed=false · provisional=true · gate_type=empirically-unproven` 로 import (claim-only 영역 명시)

### 8.7 demiurge 영역으로 들이려면 — 4-tier expansion path

§8.3 의 "모든 합성 루트 = demiurge ✗" 는 **현재의 상태이지 영구 한정이 아님**. demiurge clean-room (`design.md` D1) 은 "public-surface 측정 / 시뮬레이션 / typed record" 까지 허용 — *물리적 합성 자체* 만 바깥. 그래서 4-tier 로 쪼개면 각 tier 가 독립 PR 로 demiurge 영역에 들어올 수 있음.

#### Tier 1 — Computational synthesis (first-principles 시뮬레이션)
- **무엇**: BCS · McMillan · Allen-Dynes · Eliashberg 로 Tc 예측. λ · ω_log · μ* 가 입력.
- **위치**: `~/core/hexa-lang/stdlib/material/{bcs,mcmillan,allen_dynes,eliashberg}.py` (D61)
- **이미 존재**: hexa-rtsc `calc_bcs.hexa` · `calc_mcmillan.hexa` · `numerics_*.hexa` (n=6 closed-form)
- **demiurge ✓ 진입 조건**: hexa-rtsc 의 .hexa 스크립트를 thin adapter (D72 패턴) 로 `exports/material_sim/` 에 떨구는 Python wrapper 1개
- **honest 한계**: 시뮬레이션 결과는 *예측* 이지 *측정* 이 아님 → **absorbed=false 영원히**. gate_type=`hexa-native-absent` (Eliashberg 본해 부재) 또는 `closed-form-only` (BCS).

#### Tier 2 — Recipe-as-record (typed 합성 레시피)
- **무엇**: 합성 단계 (reagent · 비율 · 온도 프로파일 · 분위기 · 시간) 를 typed JSON record. demiurge 가 *직접 합성 안 하지만* 레시피의 SSOT 는 보유.
- **위치**: `exports/synthesis_recipe/<family>/<id>.json` + Codable `SynthesisRecipeRecord` (DemiurgeCore Models)
- **demiurge ✓ 진입 조건**: 레시피는 paper / vendor datasheet 인용 (provenance.source_url 필수). 실행은 외부 lab — demiurge 는 *recipe authoring* + *citation* 만 책임.
- **honest 한계**: 레시피 있음 ≠ 합성 성공. LK-99 레시피는 ingest 가능하되 `replicated_by_independent_labs: 0` 명시 → claim-only 영역.

#### Tier 3 — Measurement ingest (외부 측정 결과 흡수)
- **무엇**: R(T) · Meissner χ(T,B) · AC susceptibility · Cp(T) · Jc(B,T,θ) · Hc2(T) 등 §8.4 의 9-test 결과를 typed record 로 ingest.
- **입력**: 외부 instrument csv/json (PPMS · MPMS · 4-probe rig · vendor datasheet)
- **위치**: `exports/measurement/<test>/<sample_id>/<stamp>.json` + `MeasurementRecord` + `MeasurementIngestProducer`
- **demiurge ✓ 진입 조건**: provenance.instrument · operator · sample_id · raw_data_hash 필수. measurement_gate 에 새 값 `MEASURED` 추가 (현재 GATE_OPEN / GATE_CLOSED 외).
- **honest 한계**: 1회 측정 ≠ 재현. `replication_count` 필드 + 독립 lab confirm 후에야 absorbed 후보.

#### Tier 4 — Falsifier dispatch (3-tier 통합 verdict)
- **무엇**: Tier 1 시뮬레이션 ⨯ Tier 2 레시피 ⨯ Tier 3 측정 의 일관성 검사. hexa-rtsc 의 6 falsifier (F-RTSC-{1,2,3} + F-SC-{1,2,3}) 와 1:1 매핑.
- **입력**: 위 3-tier 의 record_id triple
- **출력**: `exports/material_verdict/<sample_id>/<stamp>.json` with `passes_falsifier_set` · `gate_decision`
- **위치**: `cockpit/.../Loaders/MaterialFalsifierDispatch.swift`
- **demiurge ✓ 진입 조건**: 3-tier triple 의 record_id 가 전부 박혀야 dispatch 가능. 하나라도 누락이면 honest skip.
- **honest 한계**: PASS 라도 absorbed=true 가 자동 아님. 별도 cohort 가 `replicated_by_independent_labs ≥ 2` 같은 메타 조건과 결합해 결정.

#### Roll-out 순서 (가장 가벼운 cohort 부터)
1. **Tier 1 thin adapter** — hexa-rtsc `calc_*.hexa` 5개 (BCS · McMillan · Hc2 · LK-99 · Abrikosov) 결과를 `exports/material_sim/` 로 떨구는 thin adapter (D72 패턴, ROI 견조)
2. **Tier 2 schema + LK-99 recipe stub** — Codable + LK-99 paper recipe 1건 (replicated=false)
3. **Tier 3 ingest + REBCO baseline** — SuperPower 2G HTS tape Jc(B,T,θ) csv 1건 → typed record (vendor datasheet 인용)
4. **Tier 4 dispatch** — 위 3개를 묶어 verdict 떨구는 Swift loader

각 tier 는 독립 PR. 1→2→3→4 순서로 가면 매 단계마다 demiurge 책임 영역이 한 칸씩 늘어남.

#### 4-tier 적용 후 §8.3 재분류

| 합성 루트 | Tier 1 sim | Tier 2 recipe | Tier 3 measure | Tier 4 absorbed? |
|---|:---:|:---:|:---:|:---:|
| Solid-state (LK-99 류) | ◐ Eliashberg | ○ recipe | ○ R(T) | ✗ (재현 실패) |
| DAC + 고압 (hydride) | ✗ 압력 DFT | △ recipe (압력 포함) | △ under GPa only | ✗ (device 불가) |
| Single-crystal growth | ✗ | ○ growth spec | ○ Hc2/Jc | △ |
| MOCVD/sputter/PLD (REBCO) | ✗ | ○ deposition recipe | ✓ **vendor Jc** | ✓ **가능** |
| TBG exfoliation | △ flat-band sim | △ angle spec | △ R(T,n) | ✗ (Tc=1.7 K) |
| Sol-gel + 소결 | ✗ | ○ recipe | ○ | △ |
| PIT wire (NbTi/Nb₃Sn/MgB₂) | ✗ | ○ recipe | ✓ **vendor Ic** | ✓ **가능** |

→ **REBCO HTS** 와 **PIT wire (LTS/MgB₂)** 만 4-tier 전부 ✓ 가능 — vendor datasheet 충실 + BCS 시뮬레이션 영역. **LK-99 / hydride / TBG** 는 Tier 1-3 부분 ✓, Tier 4 absorbed 영역 ✗ (재현성/device 한계).

→ **demiurge 가 가장 가까이서 absorbed=true 까지 갈 수 있는 진짜 길은 HTS REBCO baseline ingest** (Tier 3 SuperPower datasheet) — §8.5 의 handoff schema 가 가리키는 첫 PR이 이 자리.

### 8.8 g3 honest stance (material 축)

- 합성 자체는 demiurge clean-room 의 *바깥*. §8.7 의 4-tier 는 *합성을 둘러싼* typed record / 시뮬레이션 / 검증 만 demiurge 로 들임 — *물리적 합성은 영원히 외부*.
- RTSC 가설은 **never absorbed=true**. LK-99 / hexa-rtsc n=6 가 *합성+측정으로* 재현되기 전까지 claim-only (Tier 2-3 까지 ✓ 도달 가능, Tier 4 absorbed ✗).
- HTS REBCO 는 `absorbed=true` 가능하지만, 그러려면 *vendor 측정 Jc(B,T,θ)* 테이블이 Tier 3 record 로 박혀야 함. 본 세션은 그것도 없음 → `nu=1/μ₀` 선형 근사 + s1/s3 caveat 으로 GATE_OPEN 유지.
- 모든 material-side claim 의 source 는 `provenance.source_record_url` 로 추적 가능해야 함. 추적 불가능한 claim 은 ingest 거부.

---

## Log

- **2026-05-21 KST** — opened. 5축 분리 + 본 세션 cell(solenoid·HTS·getdp·verify·linear-A-φ) 진행 시작. domain rename 은 후속 PR 로 보류.
- **2026-05-21 KST** — V1 closed-form (Lorenz + Wheeler) producer landing. `exports/rtsc/verify/2026-05-21T05-27-14Z/rtsc_verify_20260521T052714Z.json` — B_center=69.4 mT, L=431 μH, W=2.155 J. CLI dispatch (`demiurge action 검증 rtsc`) 정상 동작. V2 getdp FEM stage 는 install-gated skip (getdp.info 다운로드 connection-flaky).
- **2026-05-21 KST** — `RtscVerifyRecord` 5-axis 스키마 (Axes / Geometry / Headline / ClosedForm / FEM / CrossCheck) Swift Codable 컴파일 통과. `RtscVerifyProducer` nested-stamp-dir 버그 수정 (Swift가 stamp dir 만든 다음 Python도 또 만들던 문제).
- **2026-05-21 KST** — getdp 3.5.0 (MacOSXr build, ~11 MB) 다운로드 결국 성공. `~/local/getdp/getdp-3.5.0-MacOSX/bin/getdp` 추출 + 동작 확인 (Rosetta 경유 x86_64). PATH 미등록 — producer는 `$GETDP_BIN` env로 인식 (D80 명시 install-경로).
- **2026-05-21 KST** — **V2 getdp FEM stage 통과**. 디버그 여정 5가지 (placeholder prefix / gmsh edge recovery / Form1P scalar js / axis DOF unconstrained / VolAxiSqu 2π) 모두 해결 → `exports/rtsc/verify/2026-05-21T06-06-21Z/rtsc_verify_20260521T060621Z.json`. **B_center FEM=0.06842 T vs closed-form=0.06939 T, Δ=-1.40%** — finite-thick-solenoid axisymmetric A-φ FEM이 Lorenz 해석해 1.4%로 재현 (gate_type=hexa-native-absent, absorbed=false, provisional=true).
- **2026-05-21 KST** — `getdp_hts.py` 의 5-axis 확장이 SSOT 단순화 차원에서 gate-landing 형태(record-only · honest install-gated · `getdp@absent` skip)로 의도적 revert. 5-axis solve 로직은 `templates/solenoid_axisym.{geo,pro}` + `RTSC.md §4.2.2` 에 영구 보존되어 후속 cohort가 thin adapter 1개로 다시 합칠 수 있음. `RtscVerifyRecord` 의 5-axis Optional 필드는 forward-compat 형태로 잔류 (단순 record는 nil 디코드).
- **2026-05-21 KST** — **§8 (물질합성 material synthesis) 신설**. domain의 device-side 와 직각으로 놓인 material-side 트랙 전체를 RTSC.md 에 박음: 두 트랙 분리 (§8.1) · 8 family matrix (§8.2: LTS · MgB₂ · FeSC · HTS Cuprate · Hydride · TBG · LK-99 · hexa-rtsc n=6) · 합성 루트 7개 (§8.3, 모두 demiurge clean-room 바깥) · falsifier 9-test (§8.4, hexa-rtsc verify scripts 와 매핑) · `exports/conductor/` handoff schema (§8.5) · this-session vs deferred 작업 (§8.6) · g3 honest stance (§8.7: RTSC 가설은 never absorbed=true). §3 state matrix 도 device × verb (§3.1) + material-side (§3.2) 로 분할.
- **2026-05-21 KST** — **§8.7 (4-tier expansion path) 추가**. §8.3 의 "모든 합성 루트 = demiurge ✗" 를 *현재 상태이지 영구 아님* 으로 재정의: Tier 1 (Computational sim — hexa-rtsc calc_*.hexa thin adapter) · Tier 2 (Recipe-as-record — typed JSON, 외부 lab 실행) · Tier 3 (Measurement ingest — 외부 instrument 결과 typed record) · Tier 4 (Falsifier dispatch — 3-tier triple 통합 verdict). 각 tier 는 독립 PR 가능, 1→4 순서로 가면 매 단계 demiurge 책임 영역 +1 칸. 재분류: **REBCO HTS + PIT wire (LTS/MgB₂) 만 4-tier 전부 ✓ 가능** — vendor Jc datasheet 충실. LK-99/hydride/TBG 는 Tier 1-3 부분만 ✓. g3 stance 는 §8.7 → §8.8 로 밀어내고 4-tier 와 정합 (물리적 합성은 영원히 외부 / RTSC 가설 never absorbed).
- **2026-05-21 KST** — **Stage 1+2 cohort 6개 안착** (§4.2.1.b). M5 sim.hexa = Python 과 libm 0.0000 K 정밀도 일치. D1 hts_workgroup license-unclear honest stance (콘텐츠 vendor 거부 · provenance manifest 만 안착). M4 MPRester 3-gate path 검증. GetDP 4.0.0 ARM native 다운로드 + `RhoPowerLaw` 내장 확인. **F (Tier 4 dispatch) — LK-99 first verdict = FAILS-AT-LEAST-ONE** (replicated=0), XCTest 가 absorbed=false 불변 코드-레벨 보호. G h_formulation_adapter 3 skip mode 검증. demiurge commit f4defee (concurrent session 이 bundle), hexa-lang commit d06c8ae9 (이 세션).
- **2026-05-21 KST** — **§4.2.1.c HTS-grade H-formulation 본해 실증**. GetDP 4.0.0 + life-hts/cube/cube.pro (RhoPowerLaw E-J power law) 가 macOS Apple Silicon 에서 **transient solve 정상 동작**: 1937 nodes / 3601 DOFs / KSP residual ~1.9 → 5e-16 수렴 / MagDyn_energy 8/8 PostOp 정상. §4.3 의 (s1) "linear magnetostatic — HTS critical state 미반영" caveat 의 **해결 경로가 실제로 열려 있음** 확정. absorbed=false (외부 reference benchmark, license-unclear). 다음 단계: full-cycle 완주 + benchmark1_tape EUCAS REBCO 실측 비교.
