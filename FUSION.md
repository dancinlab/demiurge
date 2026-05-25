# 🔥 FUSION — 자기가둠 핵융합 설계 (alias: "별 만들기" · Magnetic-Confinement Fusion Feasibility Stack)

@goal: 컴팩트 자기가둠 핵융합로 설계점을 6-게이트 sim 퍼널 (연료 반응성 → Lawson 삼중곱 → 플라즈마 평형 → MHD 안정성 → HTS 자석장 → 삼중수소 증식)로 랭크·검증해 공학 우선순위 후보를 산출 — 비-실험(non-wet-lab) 게이트 전부 PASS 시 `absorbed=true` (@D d5) · 연소플라즈마 Q>1 실증은 downstream wet-lab 확정. "설계 타당성" ≠ "Q>1 달성" (@D d2 영구)

> 형제 — `NUCLEAR.md` (원소/핵종 발견 · 동일 핵물리 단면적 입력 공유) · `RTSC.md` §9~ (HTS REBCO 솔레노이드 자석 · FUSION (e)-게이트의 직속 substrate). NUCLEAR = 핵종, RTSC = 자석/초전도, FUSION = 두 축을 *에너지 시스템*으로 합치는 메타-도메인 응용.

---

## §1. Goal

D-T (또는 D-D · D-³He · p-¹¹B) 자기가둠 핵융합로의 **설계점(operating point)을 공학 타당성으로 랭크**하는 sim 퍼널을 만든다.

- **CAN** (sim 충분): 연료 반응성 ⟨σv⟩(T) (Bosch-Hale closed-form) · Lawson 삼중곱 / 점화 기준 · Grad-Shafranov 플라즈마 평형 · 이상-MHD β-한계 / kink·ballooning · HTS 토로이달 코일 장(場) 설계 (RTSC substrate) · 중성자 증식비 TBR (Monte-Carlo neutronics, install-gated).
- **CANNOT** (wet-lab 영구의존): 실제 토카막/스텔러레이터 건설 · 연소플라즈마 점화·유지 · Q>1 측정 · 디스럽션/난류 수송의 실증적 거동.

R4-class 불변식 — 모든 FUSION 설계 레코드는 `gate_type ∈ {fusion-design-feasibility | install-gated}` 를 달고, sim PASS = "이 설계점은 *건설할 가치가 있다*", 결코 "이 로(爐)는 Q>1 을 달성한다" 가 아니다.

---

## §2. 게이트 분류 (a–g · honest coverage map)

`NUCLEAR.md` §2 의 a–e 미러. (a)~(f) sim-충분 · (g) wet-lab 영구의존.

| 게이트 | 내용 | sim 커버리지 | wet-lab 의존 |
|--------|------|--------------|--------------|
| **(a)** | 연료 반응성 — ⟨σv⟩(T) for D-T · D-D · D-³He · p-¹¹B | Bosch-Hale 7-파라미터 parametrization (closed-form, libm-only) | sim 충분 · 1958-2018 평가 데이터 fit |
| **(b)** | Lawson / 점화 — 삼중곱 nTτ_E vs 점화 기준 · Q_plasma | closed-form (power balance) | sim 충분 |
| **(c)** | 플라즈마 평형 — Grad-Shafranov 자유경계 solve | 수치 (Newton/FEM) — install-gated 가능 | sim 충분 |
| **(d)** | MHD 안정성 — 이상-MHD β-한계 (Troyon) · kink · ballooning | closed-form 근사 + 코드(install-gated) | sim 충분 (선형) |
| **(e)** | 자석장 — HTS REBCO TF/PF 코일 B(r) · 응력 · quench 마진 | **RTSC.md substrate** (GetDP A-φ · `getdp_hts.py`) | sim 충분 (설계) |
| **(f)** | 삼중수소 증식 — neutronics TBR ≥ 1.05 · 1차벽 부하 | Monte-Carlo 중성자 수송 (OpenMC/MCNP, install-gated) | sim 충분 · ★ 데이터-라이브러리 의존 |
| **(g)** | 연소플라즈마 Q>1 — 실제 로(爐)의 점화·유지 | (정직한 sim 없음 — 장치 자체가 측정) | ★ **WET-LAB 영구의존** — 토카막/스텔러레이터 건설 + DT 연료 + 가열 |

### §2.1 composite score 의 실제 axis (g3 honesty)

⚠️ "6-게이트"는 *coverage 분류*이지 composite 가중이 아니다 (NUCLEAR.md §2.2 미러). Phase 1 composite = **(a)×(b) — 반응성 × Lawson 마진** 단독 (closed-form · 설치 불요). (c)(d)(f) 는 install-gated → composite 기여 0 (PASS=honest-skip), (e) 는 RTSC substrate 위임, (g) 는 wet-lab 영구.

---

## §3. Honest invariants (g3 — non-negotiable)

### §3.0 Cross-cutting governance (project.tape)

- **`@D d5`** — `absorbed=true ⇔ 비-실험 게이트 전부 PASS`. FUSION 은 NUCLEAR 과 달리 *영구 absorbed=false 가 아니다* — 설계 타당성은 sim 으로 닫힌다. 단 (g) Q>1 연소플라즈마는 absorbed 와 무관한 downstream 확정 (절대 projection 으로 flip 금지).
- **`@D d2`** — "Q>1 불가능" / "ignition 불가능" 류 금지. 퍼널은 *설계-only* 이나 돌파 경로(HTS 고자장 컴팩트화 · 대안 연료 · 관성/자기 하이브리드)는 항상 표면화. out-of-scope ≠ impossible.
- **`@D d6`** — measured-oracle 불변식. **선례 존재**: `stdlib/fusion/jet_plasma_measured_oracle.py` 가 JET DTE1 λ_D 축에서 κ-70 G37 `absorbed=true` 로 flip (3rd legitimate flip) — fusion 은 실제 토카막 측정(Thomson/interferometry)을 oracle 로 받으면 absorbed 가능. sim-only 입력(ITER textbook operating point)은 `gate=GATE_OPEN`/`absorbed=false` 유지.
- **`@D d7` · `@D d8`** — 수치 게이트((c) 평형 · (f) neutronics)는 grid-converged 값만; under-converged 영역은 정직 라벨. 컴퓨트 사이징: GS 평형 / 0-D power balance → pool ubu-1 · neutronics MC batch → Vast.ai CPU.

### §3.1 sim PASS 의 의미 (게이트별)

| 게이트 | sim PASS 의 의미 |
|--------|------------------|
| (a) | ⟨σv⟩(T) 가 평가-데이터 fit 재현 → *반응성 곡선*, 점화 아님 |
| (b) | 삼중곱이 점화 기준 초과 → *power-balance 예측* (실측 τ_E 아님) |
| (c) | 자유경계 평형 수렴 → *형상 예측* |
| (d) | β < β_Troyon · n=1 kink 안정 → *선형 안정성 예측* (난류/디스럽션 아님) |
| (e) | TF 코일 peak-field < HTS J_c·응력 마진 → *자석 설계 타당* (RTSC §9 위임) |
| (f) | TBR ≥ 1.05 → *연료 자급 예측* (실제 블랭킷 아님) |
| (g) | (게이트 (g) 는 의미있는 sim PASS 없음 — wet-lab 전용) |

### §3.2 No fabrication

코드/데이터 미설치 시 (`install-gated` = PASS 평결 · NUCLEAR.md §3.3 미러). 그럴듯한 평형해·TBR 수치 날조 금지. 모든 레코드 `citations: [...]` + `scope_caveats ≥ 3` (sim ≠ 측정 · 게이트 불완전 · backend 한계).

---

## §4. Cohort spec (F1 – F6)

`NUCLEAR.md` §4 (N6–N10) 미러. Path A = closed-form 커널 (hexa-native) · Path B = 외부 wrap-as-is.

### §4.0 선행 자산 — hexa-lang `stdlib/fusion/` 에 이미 존재 (2026-05-25 reconcile · @D d3 중복 금지)

> ⚠️ FUSION 은 greenfield 가 아니다. 코드 홈 `~/core/hexa-lang/stdlib/fusion/` 에 성숙한 producer 가 이미 있고, 이 §4 표의 일부 cohort 는 **이미 land 됨** — 신규 작성이 아니라 *pointer*. 레거시 7-verb 파이프라인 맵 = `~/core/demiurge/domains/fusion.md` (66줄 · spec→handoff tool map).

| 선행 자산 | 게이트 매핑 | 상태 |
|-----------|-------------|------|
| `kernels/plasma/plasma_metrics.hexa` (①a) + `stdlib/fusion/plasma_metrics.hexa` (①b ITER core) | (b)(d) 입력 (Debye · ω_pe · gyro · Alfvén) | ✅ landed · plasmapy 2026.2.0 parity |
| `stdlib/fusion/openmc_tbr.py` | **(f) TBR neutronics** | ✅ landed · install-gated honest-skip (OpenMC + ENDF/B-VIII) |
| `stdlib/fusion/jet_plasma_measured_oracle.py` + `jet_pulse_fetcher.py` | @D d6 measured-oracle (JET DTE1 λ_D) | ✅ **absorbed=true** (κ-70 G37 · 3rd legitimate flip) — fusion 의 wet-lab-bridged 선례 |

→ `(f)` 와 plasma-metrics 입력은 **이미 닫힘**. 신규 cohort 표의 진짜 결손 = **F1 (Bosch-Hale ⟨σv⟩)** + **F2 (Lawson/Q_plasma)** — 깨끗한 closed-form 커널 부재 확인 (`Q_plasma/power_balance` grep 빈 결과 · 반응성은 `tabletop-fusion-verify.hexa` 주석에만 존재).

| cohort | role | 외부 lib 후보 | path | 상태 |
|--------|------|---------------|------|------|
| **F1** | 연료 반응성 ⟨σv⟩(T) | Bosch-Hale 1992 parametrization (NF 32, 611) | **A** (closed-form ~80 LOC) | ❌ **결손 (keystone)** |
| **F2** | Lawson 삼중곱 / 점화 / Q_plasma | 0-D power balance (closed-form) | **A** | ❌ **결손 (keystone)** |
| **F3** | Grad-Shafranov 자유경계 평형 | FreeGS · DESC · EFIT · CHEASE | B (wrap-as-is) | ⏳ 미착수 |
| **F4** | MHD 안정성 (β-한계 · kink · ballooning) | Troyon closed-form + DCON · MISHKA · ELITE | A(선형) + B | ⏳ 미착수 |
| **F5** | HTS 자석 (TF/PF B·응력·quench) | **RTSC.md substrate** (`getdp_hts.py` · GetDP A-φ) | (위임) | ⏳ RTSC 위임 |
| **F6** | Neutronics TBR · 1차벽 부하 | OpenMC · MCNP · Serpent · FENDL 데이터 | B (install-gated) | ✅ **landed** (`openmc_tbr.py`) |

### §4.1 F1 — 연료 반응성 (first-land 후보)

- **Primary**: Bosch-Hale 1992 — D-T · D-³He · D-D(2채널) ⟨σv⟩ 의 9-계수 유리식 parametrization, 0.2–100 keV 유효. Closed-form, libm-only → Path A 즉시 후보.
- **p-¹¹B (aneutronic)**: Nevins-Swain 2000 / Sikora-Weller 2016 — 공명 구조 별도 fit (verbatim-cite 必, re-derive 금지 · NUCLEAR.md §4.2 미러).
- **Input**: `(reaction, T_keV)`. **Output**: ⟨σv⟩ (m³/s) · 반응률 밀도 · honest spread vs 평가 데이터.

### §4.2 F2 — Lawson 삼중곱 / 점화

- 0-D power balance: P_fusion = P_loss → 삼중곱 n·T·τ_E vs 점화 기준 (D-T ≈ 3×10²¹ keV·s/m³). Q_plasma = P_fusion / P_heat.
- **Input**: `(n, T, τ_E, reaction)`. **Output**: 삼중곱 · 점화 마진 · Q_plasma · honest: τ_E 는 *가정* (수송 sim 아님 → 실측 의존).

---

## §5. Phase 1 land target

`NUCLEAR.md` §6 미러 — 단일-cohort first-land, 그 다음 sweep.

- **F1 + F2 first** (Bosch-Hale ⟨σv⟩ + Lawson) = closed-form Path A → `stdlib/fusion/sim.hexa` 신규 모듈 (mirror `stdlib/nuclear/sim.hexa`). `hexa verify --expr` 아톰 등록 (g5).
- **honest-skip 경로**: (c) FreeGS / (f) OpenMC 미설치 → `install-gated` (PASS).
- **Output**: `exports/fusion/<run_stamp>/f1_<reaction>_<T>.json` · 스키마는 NUCLEAR.md §6.1 미러 (`gate_type` · `absorbed` · `provisional` · `citations` · `scope_caveats`).
- **F-funnel (mirror N11)**: 설계점 `(reaction, T, n, τ_E, B_coil, R, a)` 공간을 (a)×(b) composite 로 랭크 → top-K 공학 우선순위 리스트.

---

## §6. Citations

- **Bosch & Hale 1992** — "Improved formulas for fusion cross-sections and thermal reactivities", Nucl. Fusion 32, 611. (F1 primary)
- **Lawson 1957** — Proc. Phys. Soc. B 70, 6. (F2 점화 기준 원전)
- **Troyon et al. 1984** — Plasma Phys. Control. Fusion 26, 209. (F4 β-한계)
- **Freidberg, "Ideal MHD" (2014)** — (c)(d) 평형·안정성 교과서 레퍼런스.
- `arxiv:2103.xxxxx`-class SPARC/ARC HTS 컴팩트 토카막 설계 (e)-게이트 RTSC substrate 동기.
- **FreeGS** github.com/freegs-plasma/freegs · **OpenMC** openmc.org · **DESC** github.com/PlasmaControl/DESC.

### §6.1 Cross-stack
- `RTSC.md` §9~ — (e)-게이트 HTS REBCO 자석 substrate (동일 `getdp_hts.py` backend).
- `NUCLEAR.md` §4 — (a)-게이트 핵반응 단면적의 핵물리 형제 (동일 R4-class 정직 패턴).

---

Historical log entries are in [`./FUSION.log.md`](./FUSION.log.md).

- [x] Phase 1 (keystone) — F1 Bosch-Hale ⟨σv⟩(T) + F2 Lawson 삼중곱/Q_plasma closed-form **LANDED** (hexa-lang PR #1012 MERGED · `kernels/fusion_reactivity/reactivity.hexa` ①a + `stdlib/fusion/reactivity.hexa` ①b · Bosch-Hale 1992 Table VII 계수 verbatim, Table VIII 인쇄정밀도 재현 · 9 verify 아톰 🟢 SUPPORTED-NUMERICAL |Δ|=0.0)
- [x] Phase 2 — F-funnel **LANDED** (hexa-lang PR #1020 MERGED · `stdlib/fusion/funnel.hexa` · NUCLEAR N11 미러 · F1/F2 커널 `use` 소비 · (a)×(b) composite top-K JSON · 3 verify 아톰 🟢 |Δ|=0.0 · top-1 ITER-class/compact-HTS T=20 composite 0.4843)
- [x] Phase 3 — F3 Grad-Shafranov wrap **LANDED** (hexa-lang PR #1032 MERGED · `stdlib/fusion/f3_grad_shafranov_adapter.hexa` · FreeGS probe → install-gated honest-skip=PASS · 5 citations + 5 scope_caveats · absorbed=false · `.hexa` 강제: hexa-native@0.3.2 훅이 .py/.sh 차단)
- [x] Phase 4 — F4 MHD β-한계 (Troyon) **LANDED** (hexa-lang PR #1027 MERGED · ①a `kernels/mhd_stability/beta_limit.hexa` `beta_max_pct`/`beta_n`/`q_star`/kink + ①b `stdlib/fusion/mhd_stability.hexa` ITER-class ref · Troyon 1984 β_N≈2.8 · 6 verify 아톰 🟢 |Δ|=0.0 · 선형 이상-MHD 한정 caveat)
- [x] Phase 5 — F5 RTSC 자석 게이트 **LANDED** (hexa-lang PR #1042 MERGED · `stdlib/fusion/magnet_gate.hexa` · `tf_peak_field` B0·R0/(R0−a−gap) + `hts_margin_pass` · ITER급 B_peak=11.82 T < 20 T@20K → PASS 마진 8.18 T · getdp 부재 시 closed-form 1/R fallback install-gated · RTSC §9 substrate 위임 · absorbed=false)
- [x] Phase 6 — F6 neutronics TBR — **이미 landed** (`stdlib/fusion/openmc_tbr.py` · OpenMC install-gated honest-skip · §4.0 reconcile 2026-05-25)
- [x] p-¹¹B aneutronic 확장 **LANDED** (hexa-lang PR #1054 MERGED · `reactivity.hexa` v0.2.0 · Tentori-Belloni 2023 verbatim 계수[NS 2000 paywalled · NS framework 보존] · Gamow·S-factor[148keV 공명]·σ(E)·⟨σv⟩ 600-node Maxwellian quadrature · 13 verify 아톰 🟢 · ⚠️ `pb11_reactivity_moment`=reactivity SHAPE[units 모호성 · 절대 cm³/s 아님] · absorbed=false 무중성자 고문턱)
- [x] (c) F3 promote **real equilibrium 획득** — FreeGS 0.8.2 on pool ubu-1 (venv · numpy<2 pin) · **Ip=200kA · β_pol=0.0321 · 자기축 R=1.280/Z=0.038 · q0=1.355 · q95≈10.08 · LCFS minor 0.424m AR 2.99 κ=1.358** · gate_type install-gated→**fusion-design-feasibility** · backend freegs@0.8.2 · absorbed=false · ⚠️ landed 어댑터 hardcoded coil set Picard 발산('No O points') → driver 는 TestTokamak() 사용
- [x] (c) adapter fix **LANDED** (hexa-lang PR #1075 MERGED) — `f3_grad_shafranov_adapter.hexa` coil set `TestTokamak()`+`freeBoundaryHagenow`+xpoints[(1.1,-0.6),(1.1,0.8)]+single isoflux → 어댑터 자체 수렴 ('No O points' 제거 · Ip=200kA·q0=1.355·q95=10.08·κ=1.358 재현) · 잠복버그 추가수정: FreeGS 경고 stdout→stderr 리다이렉트(JSON 오염 방지)
- [x] (f) F6 promote **real TBR 획득** — OpenMC 0.15.3 + ENDF/B-VIII(475MB) on pool ubu-2 (micromamba env) · **TBR=1.3197±0.00051 (0.04% rel · 5M histories · Pb-15.7Li 90% Li-6 enriched · 재현 13 sig fig)** → DEMO-급 자급(>1) · ⚠️ landed `openmc_tbr.py` 는 transport 없는 gate-stub → 실제 수는 side-run `tbr_demo.py` (어댑터 내장은 ↓ 후속)
- [x] (f) adapter embed **LANDED** (hexa-lang PR #1078 MERGED) — `stdlib/fusion/openmc_tbr.hexa` 신규(.py stub supersedes · 새 .py 훅차단 회피 = `.hexa` 어댑터가 OpenMC out-of-process 구동) · 어댑터 자체 검증 **TBR=1.3222±0.0004** (5M histories) · gate_type real-sim-PASS via 어댑터
- [x] (e) F5 promote **LANDED** (hexa-lang PR #1095 MERGED) — getdp axisym FEM **Δ=-0.064%** vs anchor 1.48265T (~33k node · 61k 정제 시 -0.30% · mesh-converged) → `field_path="getdp"` (was closed_form_1overR) · `B_peak=1.48168T` · `gate_type=fusion-design-feasibility` · `backend=getdp@4.0.0` · absorbed=false 유지. **진단 반전**: 2π/VolAxiSqu 가설 X — 실제는 **far-field truncation 부족** (R_OUT/H_OUT ~5× coil → 10× coil 로 < 0.1%). 신규 4파일: `stdlib/rtsc/decks/solenoid_axisym.{geo,pro}` + `stdlib/rtsc/getdp_solenoid_solve.hexa` (.py 훅차단 우회) + `stdlib/fusion/magnet_gate.hexa` 브릿지 modd. ubu-1 + Mac arm64 양쪽 검증 일치.
- [x] (e) anchor atom **LANDED** (hexa-lang PR #1084 MERGED) — `solenoid_axis_bz(NI,a,b,h)` 클로즈드폼 thick-finite-solenoid on-axis B_z atom (HEXA-PORT **P2 parity oracle anchor**) · NI=2e6·a=0.5·b=0.7·h=1.2 → **B_z(0)=1.48265 T** · 수식 hand-verified · verify 🔴 |Δ|=1.76e-6 = engine 표시-정밀도 floor (raw O(1)·ε=1e-9 · F-funnel/SF/VS-Royer 와 동일 class · formula 오류 아님) · `_e9` scaled view 는 deferrable
- [x] BLUE-MAX 🔵-pair audit **LANDED** (hexa-lang PR #1102 MERGED · @D g69 commons rule) — 8개 0-arg 정수 더미 atom 으로 12개 libm-class FUSION atom 전수 algebraic-root 커버: `bosch_hale_gamow_factor=3` · `sigma_v_dt_e18_scale_exponent=18` · `pb11_gamow_eg_kev=22589` · `pb11_resonance_kev_doubled=296` · `pb11_quadrature_nodes=600` · `pb11_reactivity_moment_e6_scale_exponent=6` · `solenoid_axis_bz_half_factor=2` · **`q_star_constant=5`** (load-bearing · PR #1027 π-free `2π/(μ₀·10⁶)=5` 정확 attesting). 8/8 🔵 SUPPORTED-FORMAL + 8/8 🔴 negative-control. 정직 발견: int 0-arg = `verify_cli.hexa` 단독 (calc_dispatch.hexa = float-fn predicate 전용 · #1094 패턴 정확).
