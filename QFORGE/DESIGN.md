# QFORGE 설계 SSOT — 아키텍처 + 다축 브레인스토밍

> 자체 제일원리 el-ph 엔진. 아래 축들은 브레인스토밍 고갈(depletion)까지 채운다.
> 작동부 코드는 hexa-lang `stdlib/qforge/` (d3 canonical home); 이 문서는 docs.
> 정직(d2/d6): "QE를 하룻밤에 대체" 주장 안 함. **상단 닫힌식부터 내려가며 QE와 layer-by-layer cross-validate** — QE는 하단 layer 완성까지 캠페인 엔진으로 계속 가동.

## 아키텍처 개요
```
원소·격자 → SCF(평면파 DFT) → DFPT 포논 → el-ph a2F·λ → Allen-Dynes/Eliashberg Tc
  ↑ 가장 무거움 (마지막 빌드)                              ↑ 이미 닫힌식 (첫 빌드, 일부 atlas 🟢 존재)
```

## ⭐ 핵심 발견 (grep 결과 — 빌드 출발점이 이미 절반 있음)
| atom / 모듈 | 위치 | tier | QFORGE 의미 |
|---|---|---|---|
| `allen_dynes_tc(λ,ω_log,μ*)` | atlas `verified-allen_dynes_tc-num` · `stdlib/material/sim.hexa:87` | 🟢 SUPPORTED-NUMERICAL | **Tc layer 이미 hexa-native·g5 박힘** |
| `allen_dynes_full(λ,ω_log,ω₂,μ*)` | atlas `verified-allen_dynes_full-num` · sim.hexa:134 | 🟢 | strong-coupling f₁·f₂ 보정항 포함 |
| `mcmillan_tc(λ,ω_log,μ*)` | atlas `verified-mcmillan_tc-num` · sim.hexa:70 | 🟢 | Tc 하한 sanity |
| `lambda_eliashberg(...)` | atlas `verified-lambda_eliashberg-num` | 🟢 | Eliashberg λ |
| `eliashberg_moments_from_a2f(ω[],a2f[])` | sim.hexa:173 · atlas `rtsc_eliashberg_moments_from_alpha2F` | hexa-native (PR#299 3/3 Python bit-exact) | **a2F→λ·ω_log·ω₂ 적분기 이미 있음** (사다리꼴, 비균일 grid) |
| Nb DFT el-ph 검증 | atlas `rtsc_nb_dft_tc_measurement_match` | 측정-grade (λ=0.93-1.08, Tc_AD 9.9-13K vs 9.25K) | **cross-validation 앵커 이미 존재** |
| 측정 앵커 H3S/LaH10/CaH6 | atlas `rtsc-exp-*` E-nodes | SUPPORTED-BY-CITATION | upper layer 회귀 타겟 |

→ **상위 2개 layer(Tc·a2F적분)는 신규 빌드가 아니라 "이관·강화"**. 진짜 신규 빌드는 el-ph matrix → DFPT → SCF 하단 3개.

---

## 브레인스토밍 축 (depletion까지 채움)

### ⚙️ 성능 (numerical accuracy)  — 5 rounds to depletion
**R1 — 정확도 floor가 어디서 정해지나**
- λ는 a2F(ω)/ω 적분 → **저주파(soft mode) 정확도가 λ를 지배**. ω→0 분모 발산 ⇒ 저주파 grid·smearing이 1차 정확도 손잡이.
- ω_log는 ln(ω) 가중 ⇒ 중간 주파 정확도가 지배. Tc ∝ ω_log·exp(-1/λ) ⇒ **λ 5% 오차 → Tc ~10-15% 오차** (지수 증폭).

**R2 — pseudopotential**
- QE 정확도 출처 #1 = PP 품질. 하이드라이드는 H 1s + 금속 semicore가 까다로움.
- QFORGE 전략: 직접 PP 생성 안 함(거대 작업) → **PP 파일 포맷(UPF) 파서 + ONCVPSP/SSSP 라이브러리 재사용**. PP는 "검증된 입력 데이터"로 취급, 엔진은 그 위에서 동작.
- floor: norm-conserving(ONCV) 우선(평면파 수식 단순) → USPP/PAW는 후순위(augmentation 항 복잡).

**R3 — plane-wave cutoff·k/q 수렴**
- ecutwfc(파동함수)·ecutrho(밀도). 하이드라이드 H 때문에 **ecutwfc 60-90 Ry 필요**(딱딱한 H pseudo). NC면 ecutrho=4·ecutwfc.
- k-grid: Ef 부근 DOS 정확도. q-grid: 포논 BZ 적분. **el-ph는 dense k + coarse q + interpolation** (EPW식)이 표준.
- 정직: 수렴 안 한 값 제출 금지(d6). atlas `falsified-h3o_6cubed_converged`가 q-undersample 반례 — **수렴 테스트를 verify gate로 박는다**.

**R4 — XC functional·smearing**
- PBE(GGA) = 하이드라이드 표준. 엔진은 XC를 plugin(LDA·PBE·PBEsol)으로 — d4 generic dispatch.
- 금속/small-gap: Methfessel-Paxton 또는 Marzari-Vanderbilt cold smearing(d15 결: smear+damp). degauss 정확도가 DOS(Ef)→λ에 직결.

**R5 — QE 정확도를 어떻게 "match"하나 (depletion)**
- 동일 PP·동일 cutoff·동일 grid ⇒ 같은 물리. 차이는 알고리즘 수치오차뿐 ⇒ **QE 결과를 ε-tier 회귀 앵커로**(Nb λ=0.93-1.08 재현이 첫 gate).
- 닫힌식 layer는 abs-ε 1e-9(g5). 수치 layer(SCF/DFPT)는 rel-ε tier(예: λ 1%, Tc 5%) — 측정-grade 합의.
- *depleted*: 정확도는 PP·cutoff·grid·XC·smearing 5축 + 지수증폭 인식 + 회귀앵커로 닫힘.

### 💾 자원 (memory / pod sizing) — 4 rounds
**R1 — 무엇이 RAM 지배**
- 파동함수 ψ: `N_pw × N_bands × N_k × 16B`(complex128). 하이드라이드 7-21 atom, ecut 80Ry ⇒ N_pw ~10⁴-10⁵, N_bands ~수십-수백, N_k ~수백 → **수 GB ~ 수십 GB**.
- DFPT 응답 Δψ: q마다 perturbation × 3·N_atom 방향 → ψ와 같은 크기 × (3N_atom) → **DFPT가 SCF보다 메모리 무거움**.

**R2 — small cell에 맞추기 (7-21 atom)**
- 7-atom(CaH6류)는 단일 노드 RAM(64-128GB) 충분. 21-atom + dense k는 빠듯.
- 절감: (a) Γ-only 초기 수렴 후 k-grid 확장, (b) band 분할 저장, (c) iterative diag는 ψ + 소수 작업벡터만 상주(전체 H 행렬 비저장 — Davidson 핵심 이점).

**R3 — GPU가 언제 도움 (d7 결)**
- d7: ≥20 atom / dense k → GPU. small cell(4-7) → pool CPU free. batch → Vast CPU.
- GPU 이점 = FFT·sgemm 처리량. 7-atom은 GPU 띄우는 오버헤드 > 이득(d7 "GPU on small cells" 금지).

**R4 — QFORGE 메모리 모델 (depletion)**
- 평면파 = H 행렬 explicit 저장 안 함(matrix-free, FFT로 Hψ 적용) ⇒ 메모리는 ψ 저장이 전부. **N_pw·N_bands·N_k가 단일 손잡이**.
- pod sizing 식을 `hexa cloud preflight`로 닫힌식 GPU-mem budget check(스킬에 이미 존재) — 렌트 전 OOM 사전체크.
- *depleted*: RAM = ψ(SCF) < Δψ(DFPT); small cell=CPU, ≥20atom=GPU, matrix-free가 근본 절감.

### ⚡ 속도 (wall-clock / scaling) — 4 rounds
**R1 — SCF 병목**
- 평면파 SCF = **FFT-bound**. ψ(G)↔ψ(r) 변환이 매 Hψ마다. N log N × (N_bands·N_k·N_iter).
- 재사용: `stdlib/signal/core_fft.hexa` radix-2 Cooley-Tukey(fft_native/ifft_native) 이미 존재 → 3D FFT로 확장 필요(gap).

**R2 — iterative diagonalization**
- Davidson(QE 기본): H 대각화 대신 부분공간 반복. matrix-free Hψ + Rayleigh-Ritz. `stdlib/alloc/math/eigen.hexa`(eigh_jacobi)는 작은 부분공간 행렬(N_bands×N_bands) 대각화에 재사용 가능.
- 대안: 직접최적화(arXiv 2411.05033 "Diagonalization without Diagonalization") — autograd 친화, QFORGE differentiable 노선과 결 맞음.

**R3 — DFPT per-q 비용 + 병렬화**
- DFPT는 q마다 독립 선형응답(Sternheimer) → **q-point embarrassingly parallel** ⇒ 후보 fleet에 q를 뿌리는 게 자연스러움.
- 병렬 축: k-point(독립) · band(부분) · G-vector(FFT 분산). small cell은 **k-point 병렬이 최선** (G분산은 통신 오버헤드 > 이득).

**R4 — 캠페인 small cell 실제 병목 (depletion)**
- 7-21 atom은 **FFT + Davidson 반복수**가 wall-clock 지배, 통신 아님 ⇒ 단일 노드 멀티코어로 충분(d7 pool CPU).
- DFPT q-sweep이 전체 시간의 대부분 ⇒ q를 pod fleet에 분산(d8 Vast batch)이 가장 큰 속도 레버.
- *depleted*: SCF=FFT-bound, diag=Davidson matrix-free, DFPT=q-parallel; small cell 레버 = q-fanout.

### 💡 아이디어 (novel approaches) — 6 rounds (가장 width 큰 축)
> 표기: ✅실현가능 · 🟡연구필요 · ⚪투기(speculative, d6 flag)

**R1**
- ✅ **atlas-cached 수렴밀도**: 한 후보의 수렴 ρ(r)·ψ를 atlas/디스크 fold → 압력·조성 이웃 후보의 SCF 초기추정으로 재사용(warm start). fleet 전체 SCF 반복수 절감.
- ✅ **verify-gated 수렴**: SCF/포논 수렴을 LLM 판단 아닌 닫힌식 잔차 gate(g5)로 — d6 "under-converged 제출 금지"를 기계화.

**R2**
- 🟡 **ML-accelerated SCF guess**: 경량 모델로 ρ 초기추정(SCF 반복 단축). 단 d6 — ML은 *초기추정만*, 최종값은 제일원리 SCF가 수렴(ML이 λ를 정하지 않음 ⇒ training-distribution wall 회피).
- 🟡 **differentiable DFT**: autograd 테이프(`stdlib/autograd.hexa`)로 ∂Tc/∂(구조·압력) 해석미분 → 후보 최적화·역설계. (Grad DFT 2309.15127, 2602.05345 결.)

**R3**
- 🟡 **active-learning q-grid**: coarse q로 a2F 추정 → 불확실성 큰 q 영역만 dense 재계산(adaptive). soft mode 부근 자동 정밀화 — R3-성능의 "저주파 지배"와 직결.
- ✅ **fleet reuse lattice**: 같은 PP·cutoff 묶음 후보군 ⇒ PP 적분·구조인자 캐시 공유(d19 reuse). NEXUS.tape에 QFORGE→RTSC 엣지.

**R4**
- ⚪ **Wannier interpolation 없이 dense-k 직접**(투기): EPW의 핵심 비용절감(Wannier 보간)을 small cell에선 dense-k 직접계산이 더 단순할 수 있음 — 검증필요, 21atom에선 거짓일 가능성 높음(d6 flag).
- 🟡 **anharmonic via SSCHA hook**: 하이드라이드는 양자 비조화가 Tc 20-25K·λ 20-25% 좌우(Errea 1907.11916). 조화 DFPT 위에 SSCHA layer를 *나중에* 얹는 모듈 경계 설계.

**R5**
- ✅ **layer별 atlas 노드 = 회귀 스위트**: 각 layer 출력(λ·ω_log·Tc·동역학행렬 고유값)을 atom으로 fold ⇒ 코드 변경 시 자동 회귀(verify recompute).
- 🟡 **µ\* 자동 보정**: Morel-Anderson µ\*(env 의존)를 atlas atom `morel_anderson_mustar`로 — Tc 마지막 자유파라미터 닫기.

**R6 (depletion)**
- ⚪ **end-to-end 미분으로 PP까지 역최적화**(투기): 정확도 vs 안정성 트레이드, 현 단계 과도. 명시적 기각.
- 신규 아이디어 고갈 — R5/R6은 R1-R3 변주. *depleted at R6.*

### 🧭 패러다임 (architecture paradigm) — 5 rounds
**R1 — bottom-up 빌드 순서 (완성도 우선 위→아래)**
```
L0 Allen-Dynes/McMillan Tc        ← 닫힌식, atlas 🟢 이미 존재 (이관·강화)
L1 Eliashberg 갭방정식 (μ*)        ← 적분방정식, 수치
L2 a2F(ω) 적분기 (λ·ω_log·ω₂)      ← sim.hexa:173 이미 존재 (강화)
L3 el-ph matrix (deformation pot.) ← 신규, dynamical matrix × δV_scf
L4 DFPT 포논 (Sternheimer 선형응답)  ← 신규, 무거움
L5 평면파 SCF (DFT 코어)            ← 신규, 가장 무거움
```
**R2 — closed-form(🔵/🟢) vs numerical 경계**
- 🔵/🟢 verify 가능: L0(Allen-Dynes 대수식)·L2(사다리꼴 적분, 해석적 검증가능)·µ\* 식.
- numerical(rel-ε tier): L1(반복解)·L3·L4·L5(SCF/DFPT 수치수렴) — abs-ε 1e-9 불가, 회귀앵커+측정-grade tier.
- → **L0·L2는 g5 박힌 닫힌식, L3-L5는 QE 회귀로 묶는 수치** — 이 경계가 빌드 철학.

**R3 — incremental cross-validation (QE 계속 가동)**
| 단계 | QFORGE 빌드 | QE 역할 | gate |
|---|---|---|---|
| 1 | L0+L2(이관) | a2F·λ 공급(QE ph.x) | L0 g5 🟢 (완료) |
| 2 | L3 el-ph matrix | DFPT 행렬 공급 | QFORGE λ vs QE λ rel-ε≤1% |
| 3 | L4 DFPT | SCF 밀도 공급 | 동역학행렬 고유값 vs QE |
| 4 | L5 SCF | (없음, 완전대체) | Nb Tc 9.25K 재현 |
- **각 단계는 위 layer를 QE 출력으로 먹여 격리 검증** ⇒ 캠페인은 멈추지 않음.

**R4 — d3/d4 준수**
- 작동부 = `stdlib/qforge/`(d3). QFORGE/ = docs (repo root, NOT domains/).
- d4 generic dispatch: 후보·PP·XC·grid 전부 manifest 입력, 엔진은 이름 분기 없음. 새 후보 = deck만.

**R5 (depletion)**
- 모듈 경계 = layer 경계 = verify 경계 = atlas 노드 경계 (4중 일치) ⇒ 각 layer 독립 교체가능.
- *depleted*: bottom-up 6 layer, 닫힌식/수치 2분, QE-fed incremental validation, d3/d4.

---

## 🔧 참고: hexa CLI 기능 (layer→verb 매핑)
| layer | hexa verb | 역할 |
|---|---|---|
| L0/L2 닫힌식 | `hexa verify --expr <fn> <args> <expected>` | g5 abs-ε 1e-9 gate · 이미 4개 atom 🟢 |
| 모든 layer 출력 | `hexa atlas register --from-verify` | 검증값을 embedded.gen.hexa로 직접 fold(회귀 스위트) |
| 수렴밀도·상수 | `hexa atlas lookup / dump` | warm-start 캐시 · 측정앵커(H3S/LaH10) 조회 |
| 신규 layer 발견 | `hexa kick` / drill | el-ph 식 변형·근사 탐색(투기 fence) |
| L4/L5 무거운 run | `hexa cloud preflight/run/nohup/poll` | GPU-mem budget 사전체크 · pod dispatch(d7) |
| 결정주의 검증 | atlas atom recompute | LLM 자가판정 금지(g3), 타입레코드가 verdict |

## 📚 참고: 타 stdlib (d3/d19 reuse-first)
| 필요 primitive | 재사용 파일 | 비고 |
|---|---|---|
| el-ph 적분·Tc 식 | `stdlib/material/sim.hexa` (allen_dynes·mcmillan·eliashberg_moments) | **직접 이관 — 신규 아님** |
| 대칭행렬 고유값 | `stdlib/alloc/math/eigen.hexa` (eigh·eigvalsh·eigh_jacobi) | 동역학행렬 대각화 · Davidson 부분공간 |
| BLAS-class | `stdlib/linalg/` (sgemm/sgemv/sdot/saxpy/snrm2 ffi+ref) · 빌트인 matmul/matvec | Hψ·Rayleigh-Ritz |
| FFT | `stdlib/signal/core_fft.hexa` (fft_native/ifft_native, radix-2) | **1D만 — 3D FFT는 gap(아래)** |
| 수치적분 | `stdlib/math/quadrature/gauss_legendre.hexa` · `stdlib/mc_integrate/` | a2F·BZ 적분 보강 |
| 자동미분 | `stdlib/autograd.hexa` (ag_var/mul/pow/sin…) | differentiable DFT 노선 |
| ODE/적분방정식 | `stdlib/math/ode.hexa` (rk4·rk45) | Eliashberg 갭방정식 반복解 |
| 최적화 | `stdlib/optim/cpgd.hexa` | 직접최적화 SCF(2411.05033 노선) |
| 텐서 ops | `stdlib/tensor/ops.hexa` · `stdlib/matrix/` | ψ·행렬 저장 |

**stdlib gap (신규 빌드 필요)**
1. **3D FFT** — 평면파 핵심. 현 core_fft는 1D radix-2 → 3D(또는 mixed-radix) 확장 또는 신규 `stdlib/qforge/fft3d`.
2. **Davidson iterative eigensolver** — eigh_jacobi는 full small matrix용. matrix-free Davidson은 신규.
3. **UPF pseudopotential 파서** — PP 라이브러리 입력 파싱(생성 아님).
4. **Sternheimer 선형응답 솔버 (DFPT 코어)** — 신규, L4의 심장.
5. **Brillouin-zone k/q grid 생성 + 대칭** (Monkhorst-Pack) — 신규.
> 정직(d2): 1-5는 진짜 빌드. 단 1·2는 기존 1D-FFT/eigh 위 확장, 4·5는 from-scratch. breakthrough path = "QE-fed 격리검증"으로 한 layer씩(위 §패러다임 R3).

## 📄 참고: arxiv (구현 레퍼런스)
| arXiv id | 한 줄 관련성 |
|---|---|
| `cond-mat/0012092` (Baroni RMP 2001) | **DFPT 형식론 정전(L4 청사진)** — 평면파 PP linear-response 포논 |
| Allen & Dynes 1975, PRB **12** 905 (arXiv 이전) | **L0 Tc 닫힌식 출처** (atlas allen_dynes_full f₁·f₂ 식) |
| `1603.06965` (Giustino RMP 2017) | el-ph 제일원리 종합 리뷰 — L3 a2F·λ 정의·수렴 |
| `1604.03525` (EPW, Poncé 2016) · `1005.4418` (EPW 원전) | **Wannier 보간 el-ph 구현** — dense-k 비용절감(L3) |
| `1907.11916` (Errea, LaH10 SSCHA 2019) | 하이드라이드 양자 비조화 — λ·Tc 보정(idea R4 anharmonic hook) |
| `2309.15127` (Grad DFT) · `2602.05345` · `2411.05033` | **differentiable/JAX DFT** — autograd 노선·직접최적화 SCF(idea R2) |
| `2603.10295` (EPW exascale GPU 2026) | GPU Wannier 보간 — L4/L5 GPU 스케일링(d7) |

---

## 🎯 수렴 (convergence) — load-bearing 아이디어 top 5
1. **상위 2 layer는 신규 빌드 아님** — `sim.hexa`의 allen_dynes·eliashberg_moments + atlas 4개 🟢 atom을 `stdlib/qforge/`로 이관·강화. 첫 milestone이 즉시 닫힌다.
2. **QE-fed incremental cross-validation** (§패러다임 R3) — 한 layer 빌드 시 위 layer를 QE 출력으로 먹여 격리검증 ⇒ 캠페인 무중단. "하룻밤 대체" 거짓주장 회피의 실질 경로.
3. **layer=verify=atlas 노드 4중 일치** — 각 layer 출력을 atom으로 fold ⇒ 회귀 스위트 + g5 gate + d6 under-converged 차단을 기계화.
4. **저주파 a2F 정확도가 λ·Tc 지수증폭 손잡이** — active-learning q-grid(soft mode 자동 정밀화)가 정확도·속도 동시 레버.
5. **matrix-free + q-fanout** — small cell(7-21atom) 실제 병목은 FFT·Davidson·DFPT q-sweep. ψ-only 메모리 + q를 pod fleet 분산이 근본 절감.

## cross-validation 계획
- RTSC 후보(LaH10·Li2MgH16·CaH6 등)로 QFORGE vs QE λ·Tc 대조 → g5 verbatim.
- **첫 앵커 = Nb BCC ambient** (atlas `rtsc_nb_dft_tc_measurement_match`: λ=0.93-1.08, Tc_AD 9.9-13K vs 측정 9.25K) — L0가 이미 이 값을 재현하는지가 1차 gate.
