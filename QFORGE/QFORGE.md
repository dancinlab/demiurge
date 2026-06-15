@title: 🔨 QFORGE — 양자 대장간 (hexa-native 제일원리 el-ph 엔진)

@goal: QE(Quantum ESPRESSO) 외부 의존을 걷어내고, 원소→전자구조→포논→전자-포논 λ→Allen-Dynes/Eliashberg Tc 전 구간을 hexa-native로 직접 계산하는 자체 제일원리 엔진. 결과는 g5 verbatim 검증 + atlas fold. RTSC 캠페인의 계산 엔진(RTSC ← QFORGE 의존).

# 🔨 QFORGE

> **아이콘** 🔨 · **이름** `QFORGE` · **별칭** "양자 대장간" / "큐포지"
> 원소(쇠)부터 두들겨 초전도체(검)를 제련하는 자체 엔진. demiurge(창조신·장인) 결.

## 하위 도메인 (sub-domain tree)
루트 QFORGE(엔진)는 세 관측·백로그 도메인을 자식으로 둔다 (`domains/DOMAINS.tape` 등록):
```
🔨 QFORGE (engine · QFORGE/QFORGE.md)
├─ ⚙️ QFORGE-PROCESS  (domains/) — el-ph 파이프라인 공정 계측·병목 (run-time 관측)
├─ 🚀 QFORGE-PERF     (domains/) — GPU/algorithmic 가속 백로그 (roofline · bench)
└─ 🧰 QFORGE-FEATURE  (domains/) — 독립엔진까지 남은 기능 백로그 (correlation-XC·NVPTX·…)
```
- 엔진 자체(부품 제작) = 이 파일 · 공정 계측 = PROCESS · 가속 = PERF · 미구현 기능 = FEATURE.

## 정체성
- **하는 일**: `.in`을 외부 QE에 던지는 대신, DFT-SCF → DFPT 포논 → el-ph 결합 → Tc를 hexa가 직접 계산
- **vs QE**: QE = 검증된 외부 Fortran(30년) ↔ QFORGE = hexa-native · verify g5 박힘 · atlas fold · AI-orchestrated
- **vs RTSC**: RTSC = *무엇을* 찾나(후보·캠페인) ↔ QFORGE = *어떻게* 계산하나(엔진). NEXUS reuse edge: RTSC ← QFORGE

## 파이프라인 (목표 전 구간)
```
원소·격자 → [SCF: 평면파 DFT] → 전자구조·Ef
            → [DFPT: 선형응답 포논] → 동역학 행렬·ω
            → [el-ph: deformation potential] → a2F(ω)·λ
            → [Allen-Dynes / Eliashberg] → Tc
   전 구간 hexa-native · g5 verbatim · atlas fold
```

## ⭐ ENGINE STATUS — QFORGE가 실제로 무엇을 할 수 있나 (the honest SSOT)

> **"QFORGE는 셋업됐다 — 정확히 무엇이 되고 무엇이 안 되는가"의 단일 SSOT** (d6/@L5 정직).
> 엔진 결정의 ②(production 모드)+④(from-scratch 차폐정점)축을 여기서 종결한다.
> 측정값은 전부 g5-verified·verbatim — 강제 없음(d6). 두 PRODUCTION 모드 + 한 수렴-중 모드.

### ✅ 모드 (a) — bare full-basis vertex (QFORGE-only, QE 모먼트 0-의존)
- **무엇**: QFORGE 자체 SCF→DFPT→el-ph |g|² (bare ∂V_bare 정점, 차폐 OFF) → α²F → λ.
- **정확도**: **CaH6 λ = 4.13647 · rel-ε 5.47%** vs QE 4.376 (`qforge-lane1-basis-sweep`,
  npw_cap=0 full ecut shell n=645). **QE 모먼트 없이** 얻는 self-consistent from-scratch
  추정 — 단순·견고한 production rough-screening 모드.
- **용도**: 빠른 rough λ 스크리닝(~5.5% band). 게이트-급(<1%)은 아님 — 모드 (b) 사용.

### ✅ 모드 (b) — hybrid (QE |g|² → QFORGE L3 assembler), gate-grade
- **무엇**: 실 QE DFPT el-ph 하베스트(`.elph` = per-mode λ(q,ν)+ω(q,ν))를 QFORGE의
  검증된 α²F→λ→Tc **어셈블러**(`qforge_gaussian_delta` deposit + `qforge_a2f_lambda`
  적분기 + Allen-Dynes/McMillan)에 먹임. 어셈블러 = `~/.hx/src/stdlib/qforge/assembler.hexa`
  (+ `elph.hexa` `qforge_a2f_from_elph`); g5 RE-verify driver = `qforge_cah6_qe_xval_test.hexa`
  / `qforge_lah10_qe_xval_test.hexa`. (구 `sim/qforge_hybrid_lambda_tc.hexa` 경로는 부재 —
  실 어셈블러는 stdlib/qforge, hexa-native compile-home = ~/.hx/src.)
- **정확도**: **CaH6 rel-ε 1.65e-7 · LaH10 rel-ε 4.75e-7** (`qforge_cah6_qe_xval_test`/
  `qforge_lah10_qe_xval_test`, σ_ph→0 단조수렴 ng=8000). **QE DFPT 모먼트가 있으면
  언제든 gate-grade λ/Tc** — 후보 검증의 production 경로.
- **정직 스코프(d6)**: 이건 from-scratch 엔진이 **아니다** — QE |g|²/DFPT를 입력으로
  **여전히 필요**로 한다(DFPT를 대체하지 않음). *검증된 λ/Tc 어셈블러*다. 병목은
  어셈블러가 아니라 DFPT(후보 dispatch — 비용·user-deferred). cf. `QFORGE/HYBRID_VALIDATION.md`.

### 🟢 모드 (c) — from-scratch SCREENED vertex — R7 ENHANCES past bare (수렴 중, gate 미달)
- **무엇**: QFORGE 자체 self-consistent 차폐 정점(Woodbury Dyson ε⁻¹ + LIVE local-field
  f_xc[ρ(r)] convolution) — QE에서 완전 독립한 from-scratch el-ph |g|².
- **R7 전환 (2026-06-08, d6 — prior "CLOSED-NEGATIVE" 판정을 REVERSE)**: R6가 명명한
  마지막 死채널(공간변화 f_xc[ρ(r)] local-field, folds=0)을 R7이 engage 하자
  **차폐가 7라운드 만에 처음으로 bare 4.137을 돌파**. **VERBATIM: λ=4.1518 vs QE 4.376,
  rel-ε=5.12% — bare baseline 자체 거리(5.47%)도 beat**. f_xc-LIVE 검증: folds=24
  local-ALDA-folds=24 xc-pts=27648 ("ENGAGED — f_xc[ρ(r)]"). Tc(AD)=386.65K · Tc(ME)=415.75K.
- **7-round λ 궤적(verbatim, `.verdicts/`)**:

  | round | 시도 | CaH6 λ | rel-ε vs QE 4.376 | verdict dir |
  |-------|------|--------|-------------------|-------------|
  | bare baseline | 차폐 OFF (= 모드 a) | 4.13647 | **5.47%** | `qforge-lane1-basis-sweep` |
  | r3 Lindhard | density-norm + static Lindhard ε(q) | 2.924 | 33% | `.verdicts/qforge-cah6-lindhard` |
  | r4 norm | Ntot²/Ω density-norm | 2.806 | 36% | `.verdicts/qforge-cah6-rpa-chi0-r4` |
  | r5 dvscf exact | Woodbury low-rank χ₀ + RPA Adler-Wiser | 3.094 | 29% | `.verdicts/qforge-cah6-dvscf-r5` |
  | r6 phonon-scr | screened phonon (capped) | 3.063 | 30% | `.verdicts/qforge-cah6-phonon-scr-r6` |
  | **r7 +live f_xc** | **+ live local-field f_xc[ρ(r)]** | **4.1518** | **5.12%** | `.verdicts/qforge-cah6-fxc-localfield-r7` ← **bare 최초 돌파** |

- **상태(d6 honest)**: R7은 차폐가 *감쇠가 아니라 enhance* 함을 실증 — R5/R6 enhancement
  가설 CONFIRMED, 누락 물리는 dead local-field f_xc였다. **게이트(≤1%)는 아직 NOT MET**
  (5.12% > 1%, 비-flip · 4.376 강제 안 함). 잔여 5.12% = LDA-vs-QE XC-functional 차이
  (QFORGE는 LDA-x+PW92-c ALDA로 차폐; QE의 |g|²는 full ε⁻¹).
- **R8 (GGA f_xc-in-χ) = COMPLETE · CLOSED-NEGATIVE (2026-06-08 verbatim, status-checked
  2026-06-15)**: PBE f_xc^GGA = ∂²e_xc^PBE/∂ρ²|_{∇ρ} (|∇ρ| spectral grad live, witness
  mean=1.089) 를 full-cell CaH6(n_PW=645, ecut 80 Ry)에 engage. **λ_GGA = 3.41256 ·
  rel-ε 22.02% vs QE 4.376 — Δλ vs ALDA = −0.00257(gradient kernel 사실상 NO 차이) ·
  GATE NOT MET**. 진단: 잔여 갭은 f_xc flavor(ALDA↔GGA)가 아니라 **from-scratch LDA-PW
  SCF**(QE 4.376은 PBE self-consistent end-to-end)이다 — DFT f_xc 레버는 소진. verdict
  `.verdicts/qforge-cah6-gga-fxc-in-chi/`. **R7(5.12%)이 차폐-vertex 최저 거리이며 이는
  bare(5.47%)를 돌파했으나 ≤1% 게이트는 미달; from-scratch 차폐-vertex 트랙은 HELD**
  (모든 DFT f_xc 레버 소진, 다음 레버 = from-scratch PBE-SCF로 별도 대형작업).
  이 모드는 R3-R6 ~30%에서 ~6× 줄여 5.12%까지 끌어내렸으나 gate 미달로 production 아님.
- **현 production 게이트**: 후보 Tc는 여전히 모드 (b) hybrid(1.65e-7)로 — R7이 gate를
  넘기 전까진 (b)가 gate-grade. (a)는 rough 스크리닝.

### 🧲 모드 (d) — QFORGE-LSDA 자성 엔진 (nspin=2 spin-DFT) — 빌드+brick g5, 모먼트 compute-walled
- **무엇**: QFORGE 자체 nspin=2 spin-polarized SCF (V_xc spin-split LDA/PW92 + spin-GGA PBE)
  → 자기 모먼트 m. CoSn kagome 트랙에서 빌드·검증됨.
- **brick 검증 (g5 PASS, 2026-06-15)**: `qforge_scf_spin_selftest`·`qforge_scf_pw_spin_selftest`·
  `qforge_smearing_spin_selftest`·`qforge_xc_spin_selftest`·`qforge_pbe_spin_selftest` 全 PASS
  (V_xc^↑<V_xc^↓ for ρ↑>ρ↓ · spin-GGA enhancement · spin-bisection E_F). 엔진은 작동.
- **모먼트 compute-wall (d6 정직)**: 실 셀 자기-모먼트 SCF는 TM-d/5d PW 비용에 막힘.
  CoSn(Co-3d, npw≥120) = ~580s/iter, npw=80(ecut~4Ry)에서만 tractable → 과소해상으로
  m≈0(QE m=0.43 미재현, 物理 아닌 basis wall). **RbOs2O6(Os-5d, 9-atom, ecut 70/560 Ry,
  77 val e⁻)은 CoSn 보다 무거워 동일/악화 wall** → mini 로컬에서 honest-skip(아래 cross-val).

### 결정 요약 (한 줄)
> **QFORGE는 작동한다 — (a) bare-vertex QFORGE-only ≈5.5%(rough λ 스크리닝) + (b)
> hybrid QE-moment→assembler 1e-7(gate-grade λ/Tc)이 두 production 모드. (c) from-scratch
> SCREENED vertex는 R7에서 bare를 돌파(λ=4.1518, 5.12% < bare 5.47%) — CLOSED 아님,
> gate ≤1% 미달·R8(GGA f_xc) CLOSED-NEGATIVE 로 DFT f_xc 레버 소진·트랙 HELD. (d)
> QFORGE-LSDA 자성 = brick g5-PASS, 실셀 모먼트는 TM-5d PW compute-wall.** 후보 Tc·자성의
> 현 게이트 = QE(DFPT |g|² + nspin=2 모먼트) — QFORGE 어셈블러는 즉시-사용 gate-grade.

### 📅 2026-06-15 cross-val — RTSC 세션 QE↔QFORGE 정직 분담 (g5 verbatim)
> 이번 RTSC 세션의 全 DFT(RbOs2O6 자성·ScH9/MgH6/ScH6/YH6 DFPT·CsOs2O6·CaH10/SrH10)는
> **QE(Quantum ESPRESSO)로만** 돌았다 — QFORGE migration gate 는 HELD. 이날 cross-val 로
> QFORGE 의 두 검증가능 조각을 박았다.

1. **hybrid assembler g5 RE-verify (모드 b) — ✅ PASS**. CaH6 QE |g|² 앵커
   (`exports/.../rtsc_cah6_*` 동일 캠페인의 terminal `.elph`)를 어셈블러에 RE-feed:
   parsed λ_BZ=8.516825 == QE (rel-ε 6.26e-16, 168 modes) · 어셈블러 λ_QFORGE=8.51682640
   @ ng=8000 σ_ph→0 단조수렴 **rel-ε = 1.647e-7 ≤ 1% gate (g5 threshold 2.5e-3 도 통과)**.
   LaH10 corroborate rel-ε 4.74e-7. → **어셈블러 즉시-사용 gate-grade 재확인**.
   verdict `.verdicts/qforge-xval/cah6-assembler-reverify/`.
2. **QFORGE-LSDA 자성 cross-val — RbOs2O6/CsOs2O6 — ⏸ HONEST-SKIP (compute-wall)**.
   목표 = QFORGE nspin=2 SCF 가 QE 모먼트(RbOs2O6 SOC ~3-4μB·rattling ~2μB·nspin=2 ideal
   ~5μB / CsOs2O6 ~1.8μB)와 같은 부호·차수 재현하나? **brick(spin-LDA/GGA V_xc·E_F·
   smearing)은 g5 全 PASS — 엔진은 검증됨.** 그러나 실 모먼트 SCF는 Os-5d PW compute-wall:
   9-atom·ecut 70/560 Ry·77 val e⁻ 는 이미 m≈0 으로 과소해상되는 CoSn(Co-3d npw≥120,
   ~580s/iter) 보다 무겁다 → mini 로컬에서 강제 시 intractable 또는 날조-급 spurious m≈0.
   c9 정직: **모먼트는 QE-production / QFORGE-gated(미재현)** — 날조 0. breakthrough = GPU
   davidson · reduced-basis(LCAO/PAW) · 실 HPC. verdict `.verdicts/qforge-xval/rbos2o6-mag/`.
3. **from-scratch 차폐정점 next-lever(R8 GGA f_xc) — status-only**: COMPLETE · CLOSED-NEGATIVE
   (λ_GGA=3.41256, rel-ε 22.02%; Δλ vs ALDA −0.00257 = 무차이). DFT f_xc 레버 소진, 잔여 갭
   = from-scratch PBE-SCF(별도 대형작업). 모드 (c) 트랙 HELD. (실행 아님 · 기존 verdict 점검만.)

## 빌드 전략 — bottom-up (검증된 상단부터, d2/d6 정직)
완성도 우선 위→아래: 이미 닫힌 식(Allen-Dynes)부터 hexa-native로 내려가며 QE와 cross-validate.

## 진행 milestones
> bottom-up 빌드 순서 = 완성도 우선 위→아래(L0…L5). 상위 2 layer는 **이미 🟢 atom 존재 → 신규 빌드 아닌 이관**(grep 완료, DESIGN.md ⭐핵심발견 참조).
- [x] **L0 Allen-Dynes Tc layer = stdlib/qforge 로 이관** — 기존 🟢 atom 재사용: `allen_dynes_tc`·`allen_dynes_full`·`mcmillan_tc`·`lambda_eliashberg` (atlas verified-*-num, `stdlib/material/sim.hexa`). 첫 verifiable layer = 즉시 닫힘. ✅ hexa-lang PR#2071 (`stdlib/qforge/tc.hexa` — `use`로 합성, d3/d4 준수, 재구현/이동 없음).
- [x] **L0 cross-val 앵커** — Nb BCC ambient(atlas `rtsc_nb_dft_tc_measurement_match`: λ=0.93-1.08, Tc_AD 9.9-13K vs 측정 9.25K) 재현이 1차 g5 gate. ✅ `qforge_l0_selftest` PASS — Tc=10.45K(λ=0.93)·11.99K(λ=1.0) ∈ [9.9,13]K. (@ci_gate)
- [ ] L2 a2F(ω) 적분기 이관·강화 — `eliashberg_moments_from_a2f` (sim.hexa:173, PR#299 3/3 Python bit-exact) → λ·ω_log·ω₂.
- [x] **L1 Eliashberg 갭 방정식 솔버** (μ* 포함) — 등방 단일밴드 Migdal-Eliashberg를 Matsubara 축에서 직접 풀이(선형화 갭 커널 고유값 `ρ_max(Tc)=1`, Z 재규격화 대각, 대칭화 후 `eigvalsh` 재사용). ✅ hexa-lang PR#2074 (`stdlib/qforge/eliashberg.hexa`+`tc.hexa` `qforge_tc_eliashberg`). `qforge_l1_selftest` 11/11 PASS (@ci_gate): 🔵 `λ(0)=2∫α²F/ω`=ln2 항등식 · 🟢 falsifiable 순서 `Tc_Eliashberg=14.64K ≥ Tc_AllenDynes=12.00K ≥ Tc_McMillan=11.48K`(Nb-scale λ=1·ω_log=192K·μ*=0.13 — ME가 AD 밴드 9.9-13K 위, 예측대로) · 🟢 고유값 자기일관 `ρ_max(Tc)=1`(독립 eigvalsh 교차검증) · grid-α²F 경로 · malformed guard. d3/d19: `sim.hexa`(모멘트·AD·McMillan)+`eigen.hexa` 0-diff 무수정 재사용. tier=🟢 rel-ε(신규 수치 솔버) — 문헌 ME-Tc 정확 앵커는 full α²F+μ* cutoff 규약 의존이라 날조 대신 순서+자기일관 게이트(d6). 비고: ODE rk45 대신 표준 Matsubara 고유값 형식 채택(Allen-Dynes 1975가 피팅을 유도한 그 형식).
- [x] **L3 α²F(ω) ASSEMBLER** — el-ph 행렬요소 |g(k,q,ν)|² · 포논 ω(q,ν) · 전자 ε_k · N(E_F) → 페르미면 **이중-δ BZ 합**(Gaussian-smeared δ) → Eliashberg 스펙트럴 함수 α²F(ω) 직접 조립. ✅ hexa-lang PR#2075 (`stdlib/qforge/elph.hexa` 신규 + `tc.hexa` L3 surface `qforge_a2f_from_elph` 노출, d4 generic). `qforge_l3_selftest` 13/13 PASS (@ci_gate): 🔵 Einstein λ-normalization `2∫α²F/ω=λ`(조립∘적분=독립 closed-form, analytic λ=0.999994 vs 조립 1.0) · 🟢 **smearing→0 수렴 MONOTONE** σ_ph=12→6→3→1.5K rel-err `1.61e-3 > 4.00e-4 > 1.00e-4 > 2.50e-5`, **O(σ²) bias** e6/e3=4.00 e3/e15=4.00(해석 보정 `2D/ω₀·(1+σ²/ω₀²)` 정확 재현), 최고밀도 2.5e-5≤1% · 🟢 2-mode 이중-δ 가법성 `λ=λ₁+λ₂`(조립 2.37519 vs 해석 2.375) · 🟢 round-trip 조립 α²F→L2 모멘트→L0 AD `ω_log=299.989≈ω₀=300K`, `Tc(L3→L2→L0)=18.7424K = Tc(direct L0)=18.7422K`(cross-layer 일관) · guard malformed→[-1.0]. tier=🟢 rel-ε(신규 조립기·해석 수렴 입증)+🔵(λ-normalization 항등식). d3/d19: `sim.hexa`(모멘트 PR#299 bit-exact)·`eigen`·`eliashberg.hexa` 0-diff 무수정 재사용. d6: **날조 QE 앵커 없음** — 합성-해석 케이스로만 마감. **deferred 다음 sub-step = real QE-DFPT |g| cross-val**(LaH10/CaH6 DFPT 행렬을 L3에 먹여 격리검증, λ rel-ε≤1%).
- [x] **L4 DFPT 포논 (동역학행렬 조립기 + 포논 solver) DONE** (`stdlib/qforge/dfpt.hexa`, hexa-lang PR#2090 MERGED, ubu-1 네이티브 빌드+실행). `qforge_dynmat(phi, masses, qvec, natoms, ncells, cell_R) → DynMat` = `D_αβ(q)=(1/√(MαMβ))Σ_R Φ_αβ(R)cos(q·R)` 질량가중+Hermitize(실대칭) · `qforge_phonons(dynmat, masses, natoms) → PhononResult { omega2[asc], omega(부호보존 sqrt), modes, n_acoustic_zero }`. **generic 조립기 (d4)**: 행렬 hardcode 없음 — caller 가 실공간 Φ 공급(selftest=해석적, 실엔진=L5 Sternheimer 선형응답 유도). **d19 재사용**: `stdlib/alloc/math/eigen` `eigh()` 로 D(q) 대각화(L1/Davidson/Sternheimer 동일 solver) · selftest q-점에 `qforge_mp_grid`. 131줄(<200 g4). `dfpt_selftest.hexa` @ci_gate **11/11 PASS** — 🟢 (A) 1D 단원자 사슬 `ω(q)=2√(K/M)|sin(qa/2)|` 영역경계 q=π/a → ω=2.0 · mid-zone q=π/2a → ω=√2 (rel ~1e-6) · 🟢 (B) 음향 sum rule q=Γ → ω_acoustic=0 (n_acoustic_zero) · 🟢 (C) 2원자 사슬 Γ optical `ω=√(2K(1/M1+1/M2))`=√3 + acoustic=0 · 🟢 (D) D(q) Hermiticity + 안정 ω²≥0 · 🟢 (E) 불안정 Φ(음의 곡률) → **NEGATIVE ω² 반환**(soft mode 정직 표시, clamp 안 함 — d6). regression: L0/L1/L3/UPF/MP/Davidson/Sternheimer+signal/fft3 selftest 전부 green, 기존 파일 0-diff. **Sternheimer→FC 어댑터는 후속**(>200줄 — half-impl 회피, 다리는 doc-comment 명시). **L4 = 엔진 마지막 레이어 → 엔진 layer 구조 완성: L0·L1·L3·L4·L5 전부 DONE.**
- [x] **L5 평면파 SCF 빌딩블록 5/5 완료** (DFT 코어 — 5 stdlib brick 전부 DONE+g5 PASS: 3D FFT(#2076)·UPF 파서(#2079)·MP grid(#2082)·Davidson(#2083)·Sternheimer(#2084)). SCF 본체 조립은 L4 DFPT assembly 와 함께 다음 layer.
  - [x] **brick 1/5 — 3D FFT DONE** (`stdlib/signal/core_fft.hexa` `fft3`/`ifft3`/`fft3_real`, hexa-lang PR#2076 MERGED). 분리가능 axis-wise 분해로 기존 1D `fft_native` verbatim 재사용(d3/d19, 1D 0-diff). `fft3_selftest.hexa` @ci_gate 7/7 PASS — 🔵 delta·planewave·Parseval · 🔵 **round-trip abs-err=8.88e-16**(≪1e-10) · 🟢 Gaussian·separability · malformed guard. ψ(G)↔ψ(r)·전하밀도·Hartree 의 load-bearing primitive.
  - [x] **brick 2/5 — UPF v2 NC 파서 DONE** (`stdlib/qforge/upf.hexa`, hexa-lang PR#2079 MERGED, ubu-1 네이티브 빌드+실행). UPF v2 norm-conserving → header(element·Z_val·mesh·NC/US/PAW flag·l_max·nproj) + radial r[]/rab[] + V_loc(Ry) + β projectors + flat D_ij + ρ(r). NC-only: US/PAW = header flag 감지 → clean `unsupported` 에러(deferred scope, 날조 안 함). `upf_selftest.hexa` @ci_gate **23/23 PASS** — **REAL** NC 파일(`Si.pz-vbc.UPF`, 공식 QE pseudopotential 서버) 파싱: 🟢 header vs 파일 선언 attr(Si·NC·Z_val=4·mesh=431·l_max=1·nproj=2) · 🟢 정수성 불변량 (a)mesh monotone↑ (b)`∫ρ(r)dr=Z_val` 4.0000000001 vs 4 (rel 1.9e-11, 실제 물리 불변량) (c)`V_loc tail→-2Z/r`(Ry) rel 3.0e-12 (d)모든 PP_BETA.i len=mesh·len(PP_DIJ)=nproj² · US-guard(H.pbe-rrkjus USPP→ok=false) · malformed-guard. tier=🟢 parser/integrity(closed-form 아님 — 파일 자체 attr + universal NC 불변량 앵커). d3/d4: element-agnostic, hardcode 없음. d19: 기존 qforge/*·core_fft 0-diff, L0/L1/L3+brick1/5 selftest 전부 green 유지.
  - [x] **brick 3/5 — Monkhorst-Pack k/q-grid 생성기 DONE** (`stdlib/qforge/mpgrid.hexa`, hexa-lang PR#2082 MERGED, ubu-1 네이티브 빌드+실행). `qforge_mp_grid(n1,n2,n3,shift1,shift2,shift3) → MpGrid` — canonical MP 공식 `u_r=(2r−n−1)/(2n)` per axis + optional half-grid shift `1/(2n)`. flat 좌표 리스트(3 float/point, fractional) + uniform weight `1/(n1·n2·n3)` (FULL BZ). **one path, two callers**(d4): 동일 생성기가 SCF k-mesh + DFPT q-mesh 둘 다 서빙. hardcode grid table 없음 — (n,shift) 입력만으로 mesh 계산. IBZ 대칭 reduction = 후속 brick deferred(crystal point group 필요 — half-impl 안 함, 전 point uniform weight). `mpgrid_selftest.hexa` @ci_gate **21/21 PASS** — 🔵 point count=N(4×4×4→64) · 🔵 weights sum=1.0 exact · 🔵 n=4 1-D={−3/8,−1/8,1/8,3/8} 정확한 유리수 · 🔵 Γ-inclusion(odd∋Γ, even∌Γ) · 🔵 shift=unshifted+1/(2n). regression: L0/L1/L3/UPF+signal/fft3 selftest 전부 green, 기존 파일 0-diff.
  - [x] **brick 4/5 — Davidson 블록 반복 대각화기 DONE** (`stdlib/qforge/davidson.hexa`, hexa-lang PR#2083 MERGED, ubu-1 네이티브 빌드+실행). `qforge_davidson(H_apply, diag, n, nbands, tol, max_iter) → DavidResult { evals[asc], evecs[row-major], iters, converged }` — 거대 Hermitian KS H 에서 최저 nbands 고유쌍만 추출. **matrix-free 계약 (one solver, two callers, d4)**: `H_apply(v)→H·v` 닫힌 연산자 — selftest 의 명시적 작은 행렬 곱 + 미래 평면파 H(FFT 기반) 모두 동일 solver, 이름 hardcode 없음. `diag`=Jacobi 전처리기. **d19 재사용**: 투영 부분공간 대각화는 `stdlib/alloc/math/eigen` 의 cyclic-Jacobi `eigh()` 호출(L1 Eliashberg 가 이미 재사용한 동일 solver) — 재유도 안 함. 200줄(<200 g4). `davidson_selftest.hexa` @ci_gate **PASS** — 🔵 diag(5,1,3,2,4) 최저3={1,2,3} 정확+오름차순+고유벡터=단위벡터 · 🔵 2×2 [[2,1],[1,2]] 최저=1 · 🔵 1D-Laplacian n=8 λ_k=2−2cos(kπ/9) rel-tol 1e-6 · 🔵 잔차 ‖H xᵢ−λᵢxᵢ‖<tol · 🔵 직교정규성 xᵢ·xⱼ=δᵢⱼ ~1e-8 · 🔵 converged=true · 🔵 cross-check dense eigh 최저-3 == Davidson 최저-3. regression: L0/L1/L3/UPF/MP+signal/fft3 selftest 전부 green, 기존 파일 0-diff.
  - [x] **brick 5/5 — Sternheimer DFPT 선형 응답 solver DONE** (`stdlib/qforge/sternheimer.hexa`, hexa-lang PR#2084 MERGED, ubu-1 네이티브 빌드+실행 — L5 마지막 brick). `qforge_sternheimer(H_apply, eps_n, psi_n, occ_states, dV_psi, n, tol, max_iter) → SternResult { dpsi, iters, converged, residual }` — DFPT 1차 파동함수 응답 |Δψₙ⟩ 을 빈 상태 합 없이 투영 선형계 `(H−εₙ)|Δψₙ⟩ = −P_c ΔV|ψₙ⟩` (`P_c = 1−Σ_occ|ψₘ⟩⟨ψₘ|`) 으로 풀이 — **투영 켤레기울기(CG)**, RHS·모든 iterate 를 점유상태 전부(ψₙ 포함)에 직교 사영해 전도공간 유지. **matrix-free 계약 (one solver, two callers, d4)**: `H_apply(v)→H·v` = Davidson(#2083) 동일 계약 — selftest dense 행렬 + 미래 평면파 H(FFT) 모두, 이름 hardcode 없음. ΔV 적용은 brick 밖(caller 가 `dV_psi=ΔV|ψₙ⟩` 공급 → solver generic). **d19 재사용**: dot/norm = davidson.hexa `dv_dot/dv_norm` 동일 계약(pub 아님 → 최소 로컬 사본 `st_dot/st_norm`, note 명기) · selftest KEY anchor = `stdlib/alloc/math/eigen` `eigh()` 재사용. 166줄(<200 g4). `sternheimer_selftest.hexa` @ci_gate **PASS** — 🔵 **(A) Sternheimer CG == 해석적 sum-over-states 스펙트럴 공식** `Δψₙ=Σ_{m≠n}|ψₘ⟩⟨ψₘ|ΔV|ψₙ⟩/(εₙ−εₘ)` 5/5 성분 일치(abs 1e-6) · 🔵 (B) 잔차 `‖(H−εₙ)Δψ+P_cΔVψₙ‖<tol` · 🔵 (C) `⟨ψₘ|Δψ⟩≈0` 모든 점유 m(~1e-8, 전도공간) · 🔵 (D) converged=true · 🔵 (E) 유한차분 교차검증 cos(dpsi,fd)~1. regression: L0/L1/L3/UPF/MP/Davidson+signal/fft3 selftest 전부 green, 기존 파일 0-diff. **L5 5/5 완료.**
- [x] **통합① — KS-SCF 자기무모순 드라이버 DONE** (`stdlib/qforge/scf.hexa`, hexa-lang PR#2091 MERGED, ubu-1 네이티브 빌드+실행). `qforge_scf(H_of_rho, rho_of_psi, n, nbands, nelec, mix, tol, max_iter) → ScfResult { rho, evals, e_total, iters, converged }` — L5 brick(Davidson·eigh)을 하나의 KS 자기무모순 루프로 엮음: ρ→H_of_rho(ρ)→H_apply→`qforge_davidson` 대각화→occupy→`rho_of_psi`→선형혼합 ρ_new=(1−mix)ρ_in+mix·ρ_out→Δρ/ΔE<tol 수렴. **d4 generic**: 호출자가 H_of_rho·rho_of_psi 클로저 공급 → 같은 드라이버가 selftest 모델 H 와 미래 실제 PW H 둘 다 구동, 이름 hardcode 없음. **d19 재사용**: 대각화=`qforge_davidson`(→`eigh`), 신규 eigensolver 없음. mixing 안정성 clamp(과대 mix damp, silent divergence 금지). 183줄(<200 g4). `scf_selftest.hexa` @ci_gate **14/14 PASS** — 🟢 (A) ρ-무관 1D-Laplacian: 고유값 2−2cos(kπ/9) rel 1e-6 + 종료 시 자기무모순 잔차<tol · 🟢 (B) ρ-의존 2-level toy H(ρ)=diag(1+λρ₀,10+λρ₁) λ=1: 해석적 고정점 ρ*=(2,0)·ε₀*=3·E*=6 모두 1e-6 일치 · 🟢 (C) mixing 안정성: 과대 mix=2.0 damp(clamp→1.0) 동일 고정점 수렴+ρ 유계[0,2](발산 안 함). regression: davidson·mpgrid·upf·sternheimer·L0/L1/L3·dfpt·signal/fft3·core_fft 전부 green, 기존 파일 0-diff. **명시적 NEXT(half-impl 회피)**: 실제 PW H_of_rho 조립 = Ewald 합 · FFT-Poisson Hartree[ρ](fft3 재사용) · LDA 교환-상관 V_xc/E_xc · UPF-구동 V_loc+비국소 투영 · 운동에너지(|G+k|²/2) — 본 PR 은 DRIVER 만, 상위 호출자가 위 조각을 H_of_rho 클로저로 조립(d4).
- [x] **통합② — Sternheimer→force-constant DFPT 응답 어댑터 DONE** (`stdlib/qforge/dfpt_response.hexa`, hexa-lang PR#2092 MERGED, ubu-1 네이티브 빌드+실행). L4(#2090)에서 DEFERRED 됐던 Sternheimer→Φ 다리를 놓음. `qforge_force_constant(H_apply, occ_states, eps, dV_bare_provider, drho_to_dvscf, natoms_dim, tol, max_iter) → ForceConstResult { phi[dim*dim], scf_iters, converged, max_residual }` — 원자변위→ΔV→Sternheimer 1차응답 Δψ→2차 에너지미분→힘상수 블록 Φ_αβ, 그대로 `qforge_dynmat` 투입. **d4 generic**: caller 가 `H_apply`·`dV_bare_provider`(변위→bare 섭동)·`drho_to_dvscf`(Hartree+XC 차폐 커널) 공급 — 동일 어댑터가 selftest 조화모델 + 미래 PW 실계, 이름 hardcode 없음. **SCF 차폐 정직 스코프**: 자기무모순 차폐 반복을 generic 하게 완전 구현 — `drho_to_dvscf=0` → 독립입자(bare) 경로(이번 g5 검증대상), 비자명 커널 → 자기무모순 차폐(동일 generic 경로); **실 Hartree+XC 커널 작성은 후속(real PW)**. **d19 재사용**: `qforge_sternheimer`(#2084) 선형응답 · `qforge_dynmat`/`qforge_phonons`(#2090, L4) · `eigh`(stdlib/alloc/math/eigen). 199줄(<200 g4). `dfpt_response_selftest.hexa` @ci_gate **11/11 PASS** — 🟢 (A) Φ_adapter ≈ Φ_spectral(닫힌형 2차 섭동이론 합, 4성분 rel<1e-6: Φ[0,0]=0.136673·Φ[0,1]=Φ[1,0]=0.104762·Φ[1,1]=0.113693) · 🟢 **(B) 유한차분 곡률 교차검증(강): H+t·ΔV 재대각화 d²E/dt² == 어댑터 Φ[0,0]=0.136673** · 🟢 (C) Sternheimer converged + max_residual<tol · 🟢 (D) Φ 대칭 Φ_αβ=Φ_βα · 🟢 **(E) end-to-end: Φ→qforge_dynmat→qforge_phonons → ω(영역경계)=2√(K/M)=2.0 + 음향 sum rule ω(Γ)=0**. regression: qforge sternheimer/dfpt(L4)/davidson/mpgrid + signal/fft3 selftest 전부 green, 기존 파일 0-diff. **후속 ✅ DONE — 실 Hartree+XC 차폐 커널 `stdlib/qforge/screening.hexa` (hexa-lang PR#2363, 14/14 PASS): `ΔV_scf[Δρ]=V_H[Δρ]+f_xc[ρ]·Δρ`, G-space Hartree(4π/|G|² · fft3 재사용) + LDA exchange(`V_x=−(3ρ/π)^{1/3}`, f_x FD교차검증), drho_to_dvscf 클로저로 `qforge_force_constant`에 주입 → L4 end-to-end 합성 확인(Φ 대칭·ω 영역경계·음향 sum rule). **LDA correlation(PZ81/PW92) ✅ DONE — hexa-lang PR#2402** (`stdlib/qforge/correlation.hexa`): `xc_mode=2` = Hartree + LDA x+c (Slater exchange + PW92 correlation), `qforge_dvscf_from_drho(...,xc_mode=2)`가 `ΔV_c=f_c[ρ]·Δρ`(`qforge_fc_pw92`)를 DFPT screening 경로로 합산(REACHABLE). g5: `correlation_selftest` PASS(PZ81+PW92 ε_c/V_c closed-form 9 anchors) + `screening_selftest` (G) PASS(mode2−mode1=f_c[ρ]·Δρ). PBE-GGA correlation도 동봉. **완전 자기무모순 DFPT (x+c level).**
- [x] **QE cross-validation L0 Tc layer GATE A PASS** (hexa-lang PR#2362 `qforge_qe_xval_test` 12/12) — QFORGE Tc ↔ QE 기록 5앵커(Nb·CaH6·H3S·YH10·H3O) rel-ε≤2.5e-3(YH10 5.9e-7 정확). **발견(g6)**: 캠페인 기록 "Allen-Dynes Tc"는 실제 McMillan closed-form = QFORGE `mcmillan_tc`와 bit-faithful. QFORGE 진짜 AD(`qforge_tc_allen_dynes` f1·f2)는 λ-monotone 리프트(Nb +6%→CaH6 +35%) = 기록 Tc가 하한. NEXUS c7 verified 승격. **잔여**: L3 |g| cross-val (Li2MgH16/LaH10 terminal el-ph 기록 대기 — 둘 다 ledger running).
- [x] **L3 |g|/α²F cross-validation DONE — full migration 마지막 게이트 CLOSED** (hexa-lang PR#2380 MERGED, `qforge_l3_qe_xval_test` @ci_gate PASS). QFORGE의 α²F(ω) ASSEMBLER(`qforge_a2f_from_elph`)를 **실제 QE-DFPT el-ph 출력으로 격리검증**. **앵커 = YH10**(소달라이트 클라트레이트, 11원자, ~250 GPa): QE 7.5 ph.x `electron_phonon='simple'` 4×4×4-q 출력 **8개 IBZ q-point `.elph` 파일 verbatim**(RTSC wave3 read-only harvest; `stdlib/qforge/fixtures/yh10_elph/` 체크인; star weights [1,8,4,6,24,12,3,6] sum=64=full BZ). **Li2MgH16/LaH10(둘 다 q=1/8 running, non-terminal) 대기 불필요** — YH10이 이미 full a2F 출력을 가진 terminal el-ph 앵커. **검증**: (1) 파서 재검증 — raw `.elph` 바이트에서 BZ-합 λ_BZ=2.81965 == QE 기록 2.8197 (rel-ε=1.7e-5, 264 모드). (2) 어셈블러 — 모드별 A=½(w_q/W)λ(q,ν)ω(q,ν) 를 QFORGE 자체 정규화 포논 δ(`qforge_gaussian_delta`)로 ω-그리드 deposit → 검증된 L2 적분기(`qforge_a2f_lambda`)로 λ=2∫α²F/ω. σ_ph→0 **단조수렴** rel-ε 8.5e-4 → 4.5e-4 → **9.8e-5**(ng=1000→4000→8000). **L3 GATE: QFORGE λ within 1% of QE λ_BZ — rel-ε=9.76e-5 ≪ 1%. 🟢**. **정직한 발견(g6)**: WIDE σ_ph deposit 은 수렴 안 함 — 유한-ω 모드 가우시안 꼬리가 ω→0 음향영역 누설, 1/ω 모멘트 가중 발산 → λ 를 ~9%(=음향-Γ Σw_qλ) LOW-bias. histogram-α²F 의 알려진 수치 병리이지 어셈블러 결함 아님; σ_ph→0 deposit 제거; 테스트가 단조수렴 PIN. d3/d19: elph.hexa·sim.hexa 0-diff 재사용. **→ QFORGE α²F 어셈블러 QE-validated. FULL MIGRATION GATE GREEN.** **2026-06-04 — CaH6 두 번째 REAL-데이터 앵커 추가**(hexa-lang PR#2698 DRAFT, `qforge_cah6_qe_xval_test` @ci_gate PASS): CaH6 의 terminal QE el-ph(2×2×2-q 8 IBZ `.elph` verbatim, Im-3m 7원자 150 GPa, `stdlib/qforge/fixtures/cah6_elph/` 체크인, w_q=1 ∀q W=8 = crystal-coord 분석으로 미병합 격자점 확인)을 동일 어셈블러로 격리검증. primary σ=0.010 Ry(=scf MP degauss), λ_QE(BZ)=8.516825(raw 바이트 파싱, rel-ε=4e-16 168모드). σ_ph→0 단조수렴 rel-ε 1.06e-5→6.6e-7→**1.65e-7**(ng=1000→4000→8000) ≪ 1% 🟢. CaH6 = fixture→real-data 업그레이드. **정직한 발견(g6)**: PR#2502(F2 ω-unit)가 `qforge_a2f_lambda` 를 Hartree-scaled 로 바꿨으나 YH10 테스트 미갱신 → 현 main 에서 YH10 L3 테스트는 Ha/K=315775 over-count 로 깨짐; CaH6 테스트는 deposit 에 `ha_per_kelvin()` 곱해 단위 일치(YH10 동일수정 follow-up). **migration gate 는 HELD — LaH10·Li2MgH16 PENDING, gate ALL_PASS 미도달(flip 안 함).**
- [x] **통합③ — metallic real-cell SCF convergence (M5.8) DONE** (hexa-lang PR#2437+#2438+#2440 MERGED → origin/main `9c16de5f0`). M5.7 PR3 잔차(CaH6 self-consistency 발산: bands straddling E_F swap occupation between SCF iters → charge-sloshing limit-cycle, residual pinned ~0.83–1.7)를 닫음. **두 primitive 추가**: (PR1 #2437) `smearing.hexa` — fractional Fermi-Dirac occupation `f(ε)=1/(1+exp((ε−E_F)/σ))` + E_F bisection so `Σ spin·f(ε_k)=nelec` → band가 E_F를 가로질러도 occupation이 CONTINUOUS (discrete swap 제거); `qforge_smearing_selftest` g5 PASS, 0 fail (anchors A–E, none tuned · d6). (PR2 #2438) `mixing.hexa` — `qforge_anderson_next` depth-m Anderson(Pulay/DIIS) density mixing: 마지막 m개 residual-history의 L²-optimal 조합으로 oscillating mode collapse; `qforge_mixing_selftest` g5 PASS, 0 fail (LOAD-BEARING anchor D: undamped linear limit-cycle residual pinned 1.95 over 200 iters → Anderson 3 iters MONOTONE 수렴). (PR3 #2440) `scf.hexa` `qforge_scf_smeared(..., sigma, spin_deg, and_depth)` + `scf_pw.hexa` `qforge_scf_pw_h_multi_smeared` — 두 primitive를 SCF 드라이버에 **OPT-IN entry**로 배선 (sigma≤0 AND and_depth≤0 → `qforge_scf` bit-identical, regression-pinned). **CaH6 real-cell fixture re-run (σ=0.02 Ha, Anderson depth=6)**: `converged = true` (was FALSE in M5.7 PR3) · `iters = 86` · `e_total = -14.9469 Ha`. el-ph chain: λ=0.0207576 · ω_log=1236.28 K. **정직 스코프(d6)**: 이 λ는 INDEPENDENT QFORGE-NC 엔진 출력 — NOT cross-val · NOT production · NOT absorbed (Γ-only single-Einstein coarse verify, QE-NC pod torn down → cross-val deferred). g5 VERBATIM: `qforge_scf_selftest` PASS (metal anchor D: integer occ misses half-fill ρ≉(1,1); smeared+Anderson reaches ρ*=(1,1)) · `qforge_scf_pw_selftest`/`screening`/`orchestrator_pw_selftest` PASS (regression). **migration dispatch default = 여전히 HELD** — 3-anchor cross-val 하네스 machinery는 DONE(hexa-lang PR#2473 `qforge_migration_gate_test` @ci_gate PASS, CaH6 terminal rel-ε 1.4e-4 · LaH10·Li2MgH16 PENDING → 집계 HELD, 날조 0/d6); 남은 것은 두 PENDING 앵커의 실 QE-DFPT λ·Tc 착지뿐(착지 시 fixture-only로 ALL_PASS 자동승격, d4). M5.8은 엔진이 실 metallic 셀을 수렴시킨다는 독립 증명까지만.
- [ ] **GPU 가속 트랙 (NVPTX, migration 후)** — QFORGE 핫커널(fft3·eigh·davidson·sternheimer·α²F BZ합)을 hexa NVPTX codegen(`compiler/codegen/nvptx_target.hexa` 7914줄, gemm/matmul/reduce/warp-reduce 테스트 존재)으로 GPU-백킹. **QE와 차이 = 불가능 아닌 미구현**(우리 컴파일러·우리 커널). 진행: NVPTX e2e 실행검증 → 1커널 파일럿(CPU-parity g5) → 로드맵. 파일럿 dispatch 2026-06-01. de-risk: NVPTX는 stub 아님(P3~P11 staged).
- [x] **3-앵커 게이트 data-half 3/3 TERMINAL (CaH6·LaH10·Li2MgH16 QE el-ph 조립 完)** (2026-06-09) — `qforge_migration_gate_test`(PR#2473) CaH6 terminal rel-ε 1.4e-4 PASS + **LaH10 terminal(2026-06-08)** + **Li2MgH16 terminal(2026-06-09)**. 세 앵커 모두 QE `electron_phonon='simple'` 2×2×2-q el-ph 회수 → byte-identical 검증 조립경로(`qforge_a2f_lambda`, CaH6 xval rel-ε **1.65e-7**)로 λ·ω_log·Tc 직접 조립. **Li2MgH16(파괴 vast anchor pod 39610026 회수, 8/8 q)**: λ=5.79 · ω_log=741 K · Tc_AD=164 K(μ*0.10)/158 K(μ*0.13) @0.020 Ry primary. **문헌(Sun 2019, 473 K@250 GPa, λ≈3.3) 대비 8-q coarse-mesh UNDER-CONVERGED(d6 정직, 473 K 강제 안 함)** — λ over-shoot(Γ/small-q 1/8 과대가중) + ω_log under-shoot(soft small-q log-avg 지배) → Tc≈1/3. verdict `.verdicts/qforge-li2mgh16-8q-assembled/` · log rtsc.log.md 2026-06-09. **data-half 集計 = 3/3 PASS**; full migration flip 잔여 = front-end QFORGE-자체 |g| accuracy-half(독립 CaH6 λ=0.18 24× MISS, 차폐-vertex 갭) — data-half 와 별개 단계(아래 end-to-end 마일스톤).
- [ ] **DFPT/SCF checkpoint-resume crash-resilience by design (recover-EOF 구조적 불가능화)** — QE ph.x `recover=.true.` 단일경로 재개가 손상된 recover scratch(EOF marker)를 맹목 replay → **4개 게이트 앵커(CaH6·LaH10·Li2MgH16·ScH9) 전부 crash-loop**(self-resume 8/8 소진, mpirun exit-2 / `Sequential READ after EOF`) 실증(2026-06-04). salvage = no-recover `start_q=<첫 미완>`·`recover=.false.` 재개로 4/4 무손실 복구(완료 dyn skip, 손상 q만 clean 재계산). **QFORGE 자체 DFPT/SCF resume은 이 모드가 구조적으로 불가능해야 함**: (1) per-q **atomic done-marker** — 완료 q는 durable 마커로 skip, 부분쓰기 중단 시 마커 미생성(반쪽 결과가 done으로 보이지 않음) · (2) resume = 미완 q만 **clean state에서 재계산**, 손상 blob replay 금지 · (3) checkpoint 읽기 시 **무결성 검증**(truncation/EOF 감지 → 해당 q 자동 재계산 fallback, crash 대신). selftest(@ci_gate) = 의도적 truncated checkpoint 주입 → resume이 crash 없이 그 q 재계산 PASS + 완료 q 보존 PASS. 근거 handoff: hexa-lang `fc2331a3`(QE 측 no-recover fallback 갭) — QFORGE는 그 갭을 **애초에 갖지 않도록** 설계. d6: 부분결과 silent 사용 금지. **구현 2026-06-04 (g5 PASS, 머지대기)**: hexa-lang PR#2688(`checkpoint.hexa` primitive — write[temp→atomic rename·마커 last]·read[len+adler32 검증]·resume_scan, `qforge_checkpoint_selftest PASS` 16/16: 적대적 truncate·bad-checksum·interrupted·완료q보존) + PR#2691(opt-in 배선 `qforge_scf_resumable`·`qforge_qmesh_dispersion_resumable` — 미사용시 0-diff, 손상 q clean 재계산, `qforge_checkpoint_integration_selftest PASS` 13/13 + scf regression PASS). 둘 다 draft → 사용자 머지 시 본 마일스톤 `[x]` flip.
- [ ] **end-to-end QFORGE 앵커 (자체 |g| vs QE |g|) = QE 완전졸업 진짜 게이트** — 현 `qforge_migration_gate_test`는 QE의 |g|(.elph)를 QFORGE 어셈블러에 먹여 **λ·Tc(뒤쪽 절반)만** 검증(CaH6 L3 rel-ε 1.65e-7, `qforge_cah6_qe_xval_test`/PR#2698). QE 0-의존(true QFORGE-only)은 **앞쪽 절반**(QFORGE 자체 SCF→DFPT→el-ph |g| 생성)도 QE와 1% 내 일치해야 성립 — 여기에 screening/correlation 정확도 갭(현 Hartree+LDA x+c · `qforge-production-migration` @L5 honesty-gate)이 있음. **자동 트리거(잡아둠)**: 3-앵커 L3 게이트 ALL_PASS(CaH6✓ + LaH10 + Li2MgH16 terminal) 도달 시 → 한 앵커(CaH6, 7-atom 최소)에서 QFORGE 자체 |g|를 SCF→DFPT로 계산해 QE harvest |g|와 대조하는 **end-to-end 앵커 1개 자동발사** → 1% 내 통과 시 QE 완전 졸업(라우팅 전환은 그 전 게이트로 이미 가능), 갭 잔존 시 d6/g6 정직 blocker 보고(날조 금지). 라우팅 전환(게이트 ALL_PASS)과 QE 완전대체(end-to-end)는 별개 단계.
- [ ] hexa-lang stdlib/qforge 포팅 (작동부 = stdlib SSOT, domains/는 docs · d3)

## 설계 SSOT
- QFORGE/DESIGN.md (아키텍처 + 다축 브레인스토밍: 성능·자원·속도·아이디어·패러다임 / 참고: hexa-cli·타 stdlib·arxiv)

## 🌐 universal multi-scale 확장 축 (원자·물질·바이오·화학·칩·시스템) — 2026-06-07
QFORGE를 materials 전용에서 전 스케일 hexa-native 제일원리 엔진으로 확장. 공통코어(평면파 DFT + 선형응답 DFPT + stdlib/autograd·flame ML 스택) 위에 스케일별 front-end + g5 verify-adapter. demiurge 7-verb 파이프 결.

scale ladder (각 = front-end -> core -> verify-adapter):
```
atoms      QM(GFN2/DFT 단분자·전하·토션·conformer)   <- verify: QM ref           [신규]
materials  DFT el-ph SCF·DFPT·λ·Tc                    <- verify: QE el-ph         DONE (NEXUS c7, GATE CLOSED)
bio        MD/FEP: ABFE·RBFE·docking·MM-GBSA          <- verify: 실험 ΔΔG(redox-matched)  [최우선 신규]
chem       reaction: TS·NEB·반응경로·촉매              <- verify: 고-level QM/실험   [신규]
chip       device: 밴드·수송·열(TCAD)                  <- verify: 측정/TCAD ref      [신규]
system     multi-scale 결합: QM/MM·CG·연속체            <- verify: 하위스케일 일관성   [신규]
```
why hexa-native universal (논거): bio 스케일 캠페인(SENOLYX RBFE, 2026-06-06~07)이 외부의존 3대 실패모드를 실증 — (1) FF 부정확(openff-2.1.0이 거대고리 형태에너지 2.2x over-spread, RMSE 75 kcal/mol, 용매-강건; ABFE가 geldanamycin/HSP90 ~5.7 over-bind) (2) 엔진 provisioning(openfe conda-solve 무한대기) (3) GPU CUDA 불일치(vast 3-pod 전부 CUDA_ERROR_UNSUPPORTED_PTX_VERSION 222 -> 소멸). materials에서 QE를 걷어낸 것과 동형(同型)으로, QFORGE-native가 이 실패모드를 원천제거. 상세 병목 = QFORGE.log.md 2026-06-07 항목.

- [ ] atoms: GFN2-xtb/DFT 단분자 엔진(전하·토션·conformer 에너지) hexa-native + g5 (외부 xtb 대체)
- [ ] bio: native alchemical FEP (hybrid-topology RBFE · HREX · MBAR) — 외부 openfe/openmm/openmmtools 제거
- [ ] bio: QM-derived FF (GFN2/DFT 전하·토션 refit + 거대고리 인지) — openff 거대고리 부정확 해결(R11 입증)
- [ ] bio: native explicit-solvent MD (el-ph FFT/eigen 커널 재사용 GPU 가속) — RTX5070 ABFE ~5h/leg 가속
- [ ] chem: NEB/TS 반응경로 엔진 (DFPT 선형응답 재사용)
- [ ] chip: 밴드·수송·열 front-end (SCF 전자구조 재사용)
- [ ] system: QM/MM·CG 결합 드라이버 (스케일 bridge)
- [ ] axis: NEXUS edge QFORGE->{SENOLYX·AGA-CURE·IVD-CURE·…} (bio 엔진 의존, materials c7 패턴 복제)
- [ ] verify-adapter 일반화: scale별 cross-val ref 표준화 (materials=QE · bio=실험ΔΔG · chem=QM · chip=TCAD)
