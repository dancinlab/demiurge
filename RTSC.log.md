# RTSC — historical log

Spec at [`./RTSC.md`](./RTSC.md). Log entries below preserve session-by-session evolution; the spec file holds only the current confirmed state.

## Log

- **2026-05-23 KST** — **§9.15 Precommit prediction — 8 H3X fanout candidates (group 14-17 screen)**. 결과 ETA 9-15h 전 closed-form 예측을 박아 d35 verifiable goal 충족. anchor: H₃S (λ=2.30, ω_log=1300K, Tc=200K, celldm=6.236 bohr), H₃Se (λ=1.03-1.26, ω_log=850K, Tc=98-128K, celldm=6.4), H₃Te (λ=2.25-2.41, ω_log=280K (broadening-crashed; ~467K stable), Tc=72-76K, celldm=6.7). 외삽 식 — ω_log ≈ ω_S · √(μ_HS/μ_HX) (3H+X reduced mass, μ=3·m_H·m_X/(3·m_H+m_X)), λ는 group-별 hypothesis (16=sweet 2.0-2.4 · 15=strong covalent ~1.5-2.0 · 14=moderate DOS 1.0-1.5 · 17=electronegativity-imbalance suppressed 0.8-1.4), Tc=Allen-Dynes(λ,ω_log,μ*=0.10). celldm seed = covalent radius scaling from H₃S baseline (r_X/r_S × 6.236).
  - [x] anchor table consolidated (group 16 trend captured)
  - [x] 8 candidates 예측 박힘 (h3o · h3f · h3n · h3si · h3p · h3cl · h3as · h3br)
  - [x] verification protocol 명시 (|Tc_pred - Tc_sim| < range_width → PASS)
  - [ ] DFT 결과 도착 시 prediction vs simulation pairwise compare (ETA ~9-15h)

  **표 — 8 H3X precommit prediction** (μ*=0.10, anchor-extrapolation only):

  | name  | group | X mass (amu) | celldm seed (bohr) | ω_log trend (K)        | λ trend          | Tc range (K) AD | confidence |
  |-------|-------|--------------|---------------------|------------------------|------------------|------------------|------------|
  | h3o   | 16    | 16.00        | 5.4                 | **~1700-2000** (↑↑)    | 1.5-2.2 (↑sweet) | **150-220**     | LOW        |
  | h3f   | 17    | 19.00        | 5.3                 | ~1500-1800 (↑)         | 0.7-1.1 (↓)      | 50-100          | MED        |
  | h3n   | 15    | 14.01        | 5.5                 | **~1800-2100** (↑↑)    | 1.4-1.9 (↑)      | **130-200**     | MED        |
  | h3si  | 14    | 28.09        | 6.5                 | ~900-1200 (~S/Se 중간) | 0.9-1.3 (mod)    | 50-110          | LOW        |
  | h3p   | 15    | 30.97        | 6.5                 | ~900-1100              | 1.3-1.8          | 90-150          | MED        |
  | h3cl  | 17    | 35.45        | 6.3                 | ~800-1000              | 0.7-1.0          | 25-60           | MED        |
  | h3as  | 15    | 74.92        | 6.7                 | ~500-650               | 1.4-1.9          | 50-95           | MED        |
  | h3br  | 17    | 79.90        | 6.6                 | ~480-620               | 0.7-1.0          | 12-35           | MED        |

  **ASCII trend diagram — group × atomic mass → Tc**:

  ```
                        light X ────────────────────► heavy X
                        mass→  14    16    19    28    32    35    75    80
  group 14 (C/Si)              ·     ·     ·    h3si  ·     ·     ·     ·       Tc~80
  group 15 (N/P/As)           h3n    ·     ·     ·   h3p    ·    h3as   ·       Tc 165→120→72
  group 16 (O/S/Se/Te) anchor  ·    h3o   ·    H₃S   ·    H₃Se  ·    H₃Te      Tc 185→200→113→74
                                          (anchor row, measured/computed)
  group 17 (F/Cl/Br)           ·     ·    h3f    ·    h3cl   ·    h3br   ·       Tc  75→ 42→ 23

  trend reading:
    · 가로축 (atomic mass↑) → ω_log↓ → Tc↓ (universal, all groups)
    · 세로축 (group):  16 = sweet (DOS+coupling balanced)
                        15 = covalent strong (Tc 살아남음, 무거워도)
                        14 = moderate (group 16의 ~half)
                        17 = suppressed (electronegativity imbalance → weak λ)
    · "lighter X" hypothesis confirmed if: h3o ≥ H₃S OR h3n ≥ 150K
    · "lighter group" hypothesis confirmed if: h3n > h3o (group 15 > group 16 light)
  ```

  **단일후보 spotlight — 왜 h3o가 LOW confidence인가**: O = chemically prone to molecular H₂O formation rather than Im-3m hydride; DFT가 Im-3m metastable로 수렴하면 ω_log >1800K, λ~1.8 가능 (Tc ~200K) — 그러나 phonon imaginary-mode instability 가능성 ≥40% (anchor 외 영역). h3n도 동일 metastability 우려 (NH₃ molecular ground state).

  **Verification protocol**:
  1. 결과 도착 시 각 후보별 (λ_sim, ω_log_sim, Tc_AD_sim) 추출.
  2. PASS = Tc_sim ∈ [Tc_range_pred] (range_width 안). FAIL = outlier (range 밖 = 흥미로운 새 정보, 가설 수정 트리거).
  3. ω_log_sim vs 1/√μ scaling check — 만약 ω_log_sim이 trend에서 >30% 벗어나면 phonon instability 또는 anharmonic effect 의심.
  4. λ_sim group-trend 일치 여부 — group 15가 group 16보다 강한 λ를 보이면 "covalent-bonding-dominant" 가설 강화.
  5. R4: 모든 산출 `absorbed=false`, gate_type=`simulation-only-prediction` (d6 invariant 보존).

- **2026-05-22 KST** — **H₃Te 두번째 novel 완주 + 그룹 16 H₃X 패턴 명확화 + CaH₆ clathrate 발사**. H₃Te ubu-2 6×6×6 q 16/16 완료: λ_BZ=2.25-2.41 (broadening-stable!), ω_log=467K, Tc_AD 72-76K (μ*=0.10). Liu 2017 PRB 96 014505 prediction (~50-100K) 정합. **그룹 16 verdict**: H₃S (λ=2.4, ω_log=1170K, Tc=195K · 측정 203K) = sweet spot; H₃Se (λ=1.1, ω_log=1350K, Tc=113K · novel) outlier with weaker coupling; H₃Te (λ=2.4, ω_log=467K, Tc=75K · novel) — λ는 H₃S 동급이나 ω_log 추락 (Te 무거움 + 큰 격자) → Tc 손해. "go heavier hydride" 전략은 dead end (chalcogenide family 한계). Honest negative (R4 Pattern 2 — concrete breakthrough paths needed elsewhere · ternary/clathrate/ambient frontier). 즉시 후속: **CaH₆ sodalite clathrate** ubu-2 발사 (7-atom Im-3m, a=3.62Å @ 172 GPa, Ca.pbe-spn-rrkjus_psl, 6×6×6 q · 측정 215K Ma 2022 NATURE 605:147 · 다른 cell topology pipeline cross-validation · ~6-9h ETA). record: `exports/material_discovery/rtsc_h3te_dft_6x6x6q_novel_20260522.json` (ab28d4f).
- **2026-05-22 KST** — **H₃Se 첫 novel 완주**. ubu-1 6×6×6 q 16/16: λ_BZ=1.03-1.26, ω_log≈1350K, Tc_AD 98-128K (μ*=0.10). Flores-Livas 2016 PRB 93 020508(R) prediction (~110K) 정합. H₃Po chain ubu-1 자동 시작 (12:32:09Z H3Se done flag detection → scf start). record: `exports/material_discovery/rtsc_h3se_dft_6x6x6q_novel_20260522.json` (57224a6).
- **2026-05-22 KST** — **H₃X 13-후보 Group 14-17 Vast.ai 병렬 screen 발사**. Tier A 직접 확장 — 그룹별 H₃X 전체 sweep: H₃O/F/N/C (light X) · H₃P/Si/Cl/As/Ge/Br (medium) · H₃Sb/I/Bi (heavy). 각자 별도 Vast 인스턴스 (RTX 3090 80 vCPU $0.135/h, 13개 × 1.5h ≈ **$2.6 total**). Pipeline 동일: 4-atom Im-3m + 24³-k + 6×6×6-q (H₃S 96% 검증 baseline). orchestrator `/tmp/h3x_orchestrator.py` 병렬 임대→SSH→QE 설치→inputs scp→detached launch. SSH key `demiurge-rtsc-2026-05-22` (Vast key id 862004). Vast.ai 운영 교훈: ① `verified=true` server-side filter 0 matches → 제거 필요; ② `cpu_ram>=N` 서버-side filter 작동 안함 → client-side filter; ③ `--allow-run-as-root` + `OMP_NUM_THREADS=1` MPI×OMP fork-limit 회피 필수; ④ 실제 key 이름 `vast.ssh_private` (오타 `vast.ssh_priv` 빈 출력); ⑤ `/Users/ghost/.ssh/id_vast_anima` 디스크 priv도 가용. 13 candidates 결과 ~50min 후 일괄 수집. R4: 전 산출 absorbed=false · gate_type=simulation-only-prediction.
- **2026-05-22 KST** — **노벨 후보 3-트랙 발사 (pool) + 외부 클라우드 sizing 교훈** (§9.14 신설 보류, project.tape d8 v1.4). 그룹-16 H₃X 시리즈 동시 발사:
  - **H₃Se** (ubu-1, Se+3H Im-3m 4-atom, a≈2.95Å) — measured zero (novel for experiment) · 6×6×6 q DFT 진행 중
  - **H₃Te** (ubu-2, Te+3H, a≈3.1Å · Te pseudo dn → n 변형으로 정상화) — 진행 중
  - **H₃Po** (ubu-1 chained · Po dn USPP scalar-relativistic, ecut 70/700) — H₃Se 완료 후 자동 발사 (group-16 시리즈 완성, 미발표 prediction)
  - **외부 가속 시도**: RunPod CPU pod 천장 8 vCPU 확인 (`docs.runpod.io/flash/configuration/cpu-types`, sweet-spot 없음, 우리 워크로드 부적합) → Vast.ai 전환. Vast.ai *CPU-only* offers 15+ 모두 `no_such_ask` ($257 credit · email_verified=true · has_rented=true 상태에서도 systemic block, root cause 불명); **Vast.ai GPU offers 정상 rent** (offer 36440479 Titan Xp 56vCPU 10GB $0.048/h 첫 시도 성공) → GPU 사용 안 하고 host CPU만 활용 가능. SSH 접근은 등록 pubkey 의 priv가 disk OR active keychain 필수 (`vast.ssh_priv` 가 missing `dancinlab.keychain-db` 에 → `secret get` 빈 출력 silent, ssh `invalid format` 실패). 인스턴스 destroy 처리 (idle billing 방지). project.tape d8 v1.4 + PATCH update 로 거버넌스화.
- **2026-05-22 KST** — **DFT 돌파 + 합성-증명 capstone** (§9.11.H/I · §9.12 · §9.13). 종합:
  - **ambient-ML 한계 cross-confirm** (§9.11.H/I): BETE-NET + ALIGNN 둘 다 hydride λ 0.34-0.48 (vs 측정 ~2.0) 로 실패 — 실패가 *λ(전자-포논 결합)* 에 국한 (ω_log 는 맞음). figshare 21370572 = dataset (별도 hydride 모델 없음). ambient-ML path 소진.
  - **DFT el-ph 파이프라인 가동** (pool:ubu-1/2 · conda QE 7.5 · apt 6.7 FORTIFY-broken 우회 · `electron_phonon='simple'`): structure → pw.x → ph.x → α²F/λ/ω_log → Allen-Dynes Tc.
  - **H₃S 고-Tc 트랙** (§9.12): k-수렴 24³ λ=0.85 (16³ 1.15 는 broadening-unstable 정정) → q-수렴 4×4×4 (8 irreducible) **λ=1.3 · Tc 125K**. λ-ladder 0.48→0.85→1.3→측정 2.0 단조 상승. 잔여=6×6×6 q + 비조화 SSCHA.
  - **Nb ambient 트랙** (§9.13 2b): DFT el-ph 4×4×4 q 가 **측정 Tc 9.25K 를 9.9K (λ≈1.0) 로 재현** — 상압 SC measurement-MATCH · PR #299 BCS-비 attestation 과 이중 first-principles 검증.
  - **hexa-native** `eliashberg_moments` (PR #299 · sim.hexa v0.3.0 · 3/3 bit-exact) — α²F→Tc 폐회로 SSOT.
  - **hexa atlas 채굴(고갈)**: 7448 노드 SC 콘텐츠 = n6 numerological 프레임워크 (Tc 300K=*target*), measured-oracle Tc ZERO → §8.8 hexa-rtsc claim-only 를 atlas-provenance 로 확증.
  - **capstone** (§9.13): SC 합성을 제1원리로 *증명하는 역량* = ambient(Nb 측정일치) + 고-Tc(H₃S 수렴) 두 축 measurement-grade 확립. 실제 RTSC 물질 absorbed=true 는 적격물질+wet-lab 의존 (§8.9 gate OPEN · 불가능 아님). 교훈 → **project.tape d7** (v1.3 거버넌스). 전 산출물 absorbed=false · simulation-only-prediction (R4 보존).
- **2026-05-21 KST** — **§9 신설** (5-gate 시뮬레이션 stack · 외부 라이브러리 deep-research 영구 보관). §8.9 의 5-gate 별 open-source 라이브러리 + 2024-2026 arxiv reference 인덱스. 5 sub-section (9.1 합성가능성 sim · 9.2 Tc sim · 9.3 압력-의존 sim · 9.4 cross-code "독립" analog · 9.5 oracle parity) + 9.6 시뮬레이션 limit table + 9.7 4-cohort 발사 후보 (N1 CSP adapter · N2 BEE-NET adapter · N3 ASKCOS adapter · N4 cross-code DFT) + 9.8 arxiv 인덱스 (10 papers, full URL) + 9.9 non-arxiv URL 인덱스 (13 sources). honest: 시뮬레이션 PASS 라도 `gate_type=simulation-only-prediction` · `absorbed=false 영구` (R4 invariant 보호). 의미는 candidate funnel — wet-lab 우선순위 정렬용.
- **2026-05-21 KST** — opened. 5축 분리 + 본 세션 cell(solenoid·HTS·getdp·verify·linear-A-φ) 진행 시작. domain rename 은 후속 PR 로 보류.
- **2026-05-21 KST** — V1 closed-form (Lorenz + Wheeler) producer landing. `exports/rtsc/verify/2026-05-21T05-27-14Z/rtsc_verify_20260521T052714Z.json` — B_center=69.4 mT, L=431 μH, W=2.155 J. CLI dispatch (`demiurge action 검증 rtsc`) 정상 동작. V2 getdp FEM stage 는 install-gated skip (getdp.info 다운로드 connection-flaky).
- **2026-05-21 KST** — `RtscVerifyRecord` 5-axis 스키마 (Axes / Geometry / Headline / ClosedForm / FEM / CrossCheck) Swift Codable 컴파일 통과. `RtscVerifyProducer` nested-stamp-dir 버그 수정 (Swift가 stamp dir 만든 다음 Python도 또 만들던 문제).
- **2026-05-21 KST** — getdp 3.5.0 (MacOSXr build, ~11 MB) 다운로드 결국 성공. `~/local/getdp/getdp-3.5.0-MacOSX/bin/getdp` 추출 + 동작 확인 (Rosetta 경유 x86_64). PATH 미등록 — producer는 `$GETDP_BIN` env로 인식 (D80 명시 install-경로).
- **2026-05-21 KST** — **V2 getdp FEM stage 통과**. 디버그 여정 5가지 (placeholder prefix / gmsh edge recovery / Form1P scalar js / axis DOF unconstrained / VolAxiSqu 2π) 모두 해결 → `exports/rtsc/verify/2026-05-21T06-06-21Z/rtsc_verify_20260521T060621Z.json`. **B_center FEM=0.06842 T vs closed-form=0.06939 T, Δ=-1.40%** — finite-thick-solenoid axisymmetric A-φ FEM이 Lorenz 해석해 1.4%로 재현 (gate_type=hexa-native-absent, absorbed=false, provisional=true).
- **2026-05-21 KST** — `getdp_hts.py` 의 5-axis 확장이 SSOT 단순화 차원에서 gate-landing 형태(record-only · honest install-gated · `getdp@absent` skip)로 의도적 revert. 5-axis solve 로직은 `templates/solenoid_axisym.{geo,pro}` + `RTSC.md §4.2.2` 에 영구 보존되어 후속 cohort가 thin adapter 1개로 다시 합칠 수 있음. `RtscVerifyRecord` 의 5-axis Optional 필드는 forward-compat 형태로 잔류 (단순 record는 nil 디코드).
- **2026-05-21 KST** — **§8 (물질합성 material synthesis) 신설**. domain의 device-side 와 직각으로 놓인 material-side 트랙 전체를 RTSC.md 에 박음: 두 트랙 분리 (§8.1) · 8 family matrix (§8.2: LTS · MgB₂ · FeSC · HTS Cuprate · Hydride · TBG · claim-only RT-SC · hexa-rtsc n=6 — 2026-05-22 aggressive scrub: claim-only RT-SC slot was originally a specific historical claim, anonymized to a generic slot) · 합성 루트 7개 (§8.3, 모두 demiurge clean-room 바깥) · falsifier 9-test (§8.4, hexa-rtsc verify scripts 와 매핑) · `exports/conductor/` handoff schema (§8.5) · this-session vs deferred 작업 (§8.6) · g3 honest stance (§8.7: RTSC 가설은 never absorbed=true). §3 state matrix 도 device × verb (§3.1) + material-side (§3.2) 로 분할.
- **2026-05-21 KST** — **§8.7 (4-tier expansion path) 추가**. §8.3 의 "모든 합성 루트 = demiurge ✗" 를 *현재 상태이지 영구 아님* 으로 재정의: Tier 1 (Computational sim — hexa-rtsc calc_*.hexa thin adapter) · Tier 2 (Recipe-as-record — typed JSON, 외부 lab 실행) · Tier 3 (Measurement ingest — 외부 instrument 결과 typed record) · Tier 4 (Falsifier dispatch — 3-tier triple 통합 verdict). 각 tier 는 독립 PR 가능, 1→4 순서로 가면 매 단계 demiurge 책임 영역 +1 칸. 재분류: **REBCO HTS + PIT wire (LTS/MgB₂) 만 4-tier 전부 ✓ 가능** — vendor Jc datasheet 충실. claim-only RT-SC/hydride/TBG 는 Tier 1-3 부분만 ✓. g3 stance 는 §8.7 → §8.8 로 밀어내고 4-tier 와 정합 (물리적 합성은 영원히 외부 / RTSC 가설 never absorbed).
- **2026-05-21 KST** — **Stage 1+2 cohort 6개 안착** (§4.2.1.b). M5 sim.hexa = Python 과 libm 0.0000 K 정밀도 일치. D1 hts_workgroup license-unclear honest stance (콘텐츠 vendor 거부 · provenance manifest 만 안착). M4 MPRester 3-gate path 검증. GetDP 4.0.0 ARM native 다운로드 + `RhoPowerLaw` 내장 확인. **F (Tier 4 dispatch) — claim-only first verdict = FAILS-AT-LEAST-ONE** (replicated=0), XCTest 가 absorbed=false 불변 코드-레벨 보호. G h_formulation_adapter 3 skip mode 검증. demiurge commit f4defee (concurrent session 이 bundle), hexa-lang commit d06c8ae9 (이 세션).
- **2026-05-21 KST** — **§4.2.1.c HTS-grade H-formulation 본해 실증**. GetDP 4.0.0 + life-hts/cube/cube.pro (RhoPowerLaw E-J power law) 가 macOS Apple Silicon 에서 **transient solve 정상 동작**: 1937 nodes / 3601 DOFs / KSP residual ~1.9 → 5e-16 수렴 / MagDyn_energy 8/8 PostOp 정상. §4.3 의 (s1) "linear magnetostatic — HTS critical state 미반영" caveat 의 **해결 경로가 실제로 열려 있음** 확정. absorbed=false (외부 reference benchmark, license-unclear). 다음 단계: full-cycle 완주 + benchmark1_tape EUCAS REBCO 실측 비교.
- **2026-05-21 KST** — **§4.2.1.d Cube full-cycle 완주 확정**. 같은 세션 후속 run 으로 timeout 1800s 잡았는데 **GetDP가 617s (10.3 min) 에 자연 종료** — TimeStep 248~249 (t=0.025s AC-cycle 끝) 까지 전 step KSP residual ~5-8e-16 수렴. macOS Apple Silicon native 만으로 HTS-grade H-formulation full-cycle 가능. Linux pool 불필요. cube.pro 의 `res/dummy.txt` overwrite-only 한계로 last-step 6-PostOp 값만 보존됨 (전 transient capture 별 cohort). **(s1) caveat 해결 경로가 솔버 수렴 레벨까지 실증**.
- **2026-05-21 KST** — Stage 3 cohort 3개 (H cube_producer.py · J hexa_rtsc_crosslink.py · K MPRester real-query probe) + Stage 4 (L MaterialVerifyProducer.swift / ActionDispatch.material+verify wiring · M 3 Tier 2 recipe stubs · 2 cube full-cycle bg run) 모두 안착. M 의 claim-only 외 stub 3건 추가 (REBCO MOCVD replicated=5 · NbTi PIT wire replicated=8 · hexa-rtsc n=6 replicated=0). L 의 `demiurge action 검증 material` CLI dispatch 가 4 sub-producer 병렬 (sim_adapter ✓ · cube_producer 60s SKIP · hexa_rtsc_crosslink ✓ · mp_query SKIP no-key) aggregated ok=true 안착. J 의 hexa-rtsc cross-link 가 1 MATCH (bcs σ·φ=24 by construction) + 2 DEVIATION (algebraic ceiling ≠ concrete sample · honest informative) + 1 SKIPPED (upstream claim-class verifier parse error noexisten) 산출.
