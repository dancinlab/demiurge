# QFORGE — 작업 로그 (append-only)

## 2026-05-29 — 도메인 생성
- 🔨 QFORGE "양자 대장간" 도메인 신설 (domains/QFORGE/ 폴더형, CARDIO+ 선례).
- 동기: RTSC 캠페인이 외부 QE(pw.x/ph.x)에 의존 → hexa-native 자체 제일원리 el-ph 엔진으로 대체 목표.
- 정체성 d10 head 작성 · @goal · bottom-up milestones (Allen-Dynes→Eliashberg→a2F→el-ph→DFPT→SCF).
- DOMAINS.tape 로스터 등록 (물리/소재 그룹, RTSC 아래).
- 다음: DESIGN.md에 다축 브레인스토밍 고갈까지 (성능·자원·속도·아이디어·패러다임 + hexa-cli/타-stdlib/arxiv 참고).

## 2026-05-29 — 루트로 이동 + 거버넌스 명시
- 폴더 domains/QFORGE → **repo-root QFORGE/** 이동 (위 신설 로그의 domains/QFORGE 경로는 과거 기록).
- 사유: project.tape `d_domains_demi_only` — domains/=.demi 도메인 전용, 엔진/코드 프로젝트는 루트 + DOMAINS.tape roster link.
- DOMAINS.tape 경로 `QFORGE/QFORGE.md`로 갱신 · 내부 DESIGN.md 참조 정정.
- L0 SHIPPED: hexa-lang PR#2071 (stdlib/qforge/tc.hexa) · Nb 앵커 g5 PASS (Tc=10.45K@λ0.93·11.99K@λ1.0 ∈[9.9,13]K).

## 2026-06-01 — 통합③ metallic SCF convergence (M5.8) CLOSED
- M5.7 PR3 residual (CaH6 self-consistency divergence: charge-sloshing limit-cycle, residual pinned ~0.83–1.7) — root cause = scf.hexa FIXED integer occupation + plain linear mixing on a metallic spectrum (bands straddling E_F swap occupation between iters).
- FIX merged to origin/main `9c16de5f0` (3 stacked PRs):
  - PR1 #2437 `smearing.hexa` — fractional Fermi-Dirac occupation + E_F bisection (Σspin·f=nelec). g5 PASS 0 fail (anchors A–E, none tuned · d6).
  - PR2 #2438 `mixing.hexa` — Anderson (Pulay/DIIS) depth-m density mixing. g5 PASS 0 fail (LOAD-BEARING anchor D: undamped limit-cycle res=1.95 → Anderson 3-iter MONOTONE converge).
  - PR3 #2440 `scf.hexa qforge_scf_smeared` + `scf_pw.hexa qforge_scf_pw_h_multi_smeared` — OPT-IN wire (sigma≤0 ∧ and_depth≤0 → qforge_scf bit-identical, regression-pinned).
- CaH6 real-cell re-run (σ=0.02 Ha, Anderson depth=6): converged=true (was FALSE) · iters=86 · e_total=-14.9469 Ha · λ=0.0207576 · ω_log=1236.28 K.
- HONEST scope (d6): λ = INDEPENDENT QFORGE-NC output — NOT cross-val · NOT production · NOT absorbed (Γ-only single-Einstein coarse, QE-NC pod torn down → cross-val deferred).
- migration dispatch default = STILL HELD (3-anchor QE cross-val LaH10·CaH6·Li2MgH16 pending). M5.8 = independent proof the engine converges a real metallic cell, no more.
- demiurge QFORGE.md milestone 통합③ flipped [x].

## 2026-06-02 — QE 7.5 설치 (FREE pool: summer + aiden) — el-ph reference 무료화
- 동기: QE cross-val reference 계산(Li2MgH16 recipe-A 류)을 rented pod(QE 6.7) 대신 FREE 12-core linux 호스트에서 실행.
- 방법 = conda-forge (micromamba 2.6.2 user-space, no root) → isolated env `qe`. 두 호스트 동일 경로.
  - micromamba: `~/bin/micromamba` (MAMBA_ROOT_PREFIX=~/micromamba).
  - `micromamba create -y -n qe -c conda-forge qe` → **qe-7.5** (openmpi + scalapack + elpa + hdf5, MPI-enabled).
  - 설치된 바이너리: pw.x · ph.x · q2r.x · matdyn.x · pp.x (~/micromamba/envs/qe/bin/).
- 비고: 요청은 7.4.x였으나 conda-forge 최신 = 7.5 (상위 호환, MPI el-ph 완비) — 7.5 채택.
- **sidecar 비대화형 셸 작동 invocation (PATH 의존 X · g9 — raw ssh 금지)**:
  - 단일: `sidecar pool on <host> 'export MAMBA_ROOT_PREFIX=$HOME/micromamba; $HOME/bin/micromamba run -n qe pw.x -in <deck>'`
  - MPI(12-core 권장): `... $HOME/bin/micromamba run -n qe mpirun -np <N> pw.x -in <deck>'`
  - ph.x 동일: `... micromamba run -n qe mpirun -np <N> ph.x -in <ph.in>'`
- VERIFY (per host, VERBATIM):
  - summer: pw.x `Program PWSCF v.7.5` · ph.x `Program PHONON v.7.5` · bulk-Si SCF (2-atom, 4³ k, ecut 18 Ry, MPI np=2) → `!    total energy = -15.84452726 Ry` · `convergence has been achieved in 6 iterations` · `JOB DONE.` (exit 0).
  - aiden:  pw.x `Program PWSCF v.7.5` · ph.x `Program PHONON v.7.5` · 동일 deck → `!    total energy = -15.84452726 Ry` · `convergence has been achieved in 6 iterations` · `JOB DONE.` (exit 0).
- 두 호스트 total energy bit-identical → 설치 일관성 확인. Si.pz-vbc.UPF pseudo fetch from pseudopotentials.quantum-espresso.org (smoke deck @ ~/qe_smoke/).
- 디스크: summer 44G free · aiden 14G free (99% 사용 — qe env ~2.6GB 수용했으나 여유 빠듯, 대형 outdir는 모니터 필요).
- 결과: **FREE pool이 이제 QE el-ph reference 계산 실행 가능** (d7 small-cell 4-7원자 pool-free 경로에 부합). 미래 dft-run/recipe는 위 invocation으로 summer/aiden 타게팅 가능.

## 2026-06-03 — FEATURE + PROCESS bricks merged to hexa-lang main

- FEATURE (PR#2586, `kmesh_elph.hexa`): real k-mesh el-ph BZ scattering sum — walks (k,k+q)×(m,n)×ν channels into the L3 α²F assembler. g5 `qforge_kmesh_elph_selftest PASS` (flat-band nk-invariance · Γ-limit=analytic Einstein rel-ε 6.5e-5 · BZ λ>Γ-collapse · off-diag |g_mn| raises λ). 2 new files, 0-diff to existing, no regression.
- PROCESS (PR#2587, `telemetry_cli.hexa`): `hexa qforge telemetry {report|regress|rollup}` CLI subverb over harvested `.dft_telemetry.jsonl` — surfaces the #2477/#2483/#2487 observability stack on the command line. g5 `qforge_cli_telemetry_selftest PASS` (14/14). READ-ONLY, missing-file→rc1 (d6, no phantom report).
- @L5/d6 HONEST: neither brick closes the CaH6 λ gate. kmesh_elph supplies BZ-summation MACHINERY only; real CaH6 λ closure stays compute-gated (converged 4×4×4q SCF) + the screening/correlation accuracy gap (Hartree+LDA x+c) remains a separate front-end limit. Migration gate CaH6-NC = HELD (1/3); no forced flip; nothing tuned toward QE λ. PR2503-audit residual (Γ-only BZ-sampling) now has its machinery; the heavy converged run is the named next compute step.

## 2026-06-04 — recover-EOF crash family 실증 → QFORGE resume crash-resilience milestone 등록

- INCIDENT: 4개 게이트 앵커(CaH6·LaH10·Li2MgH16·ScH9)가 QE ph.x `recover=.true.` 단일경로 재개의 손상 recover scratch(EOF marker) 맹목 replay로 전부 crash-loop(self-resume 8/8 소진, mpirun exit-2 / `Sequential READ after EOF`). salvage = `recover=.false.`+`start_q=<첫 미완>` 재개로 4/4 무손실 복구(완료 dyn skip, 손상 q만 clean 재계산).
- MILESTONE 등록(QFORGE.md `## 진행 milestones`): QFORGE 자체 DFPT/SCF resume은 이 모드가 구조적으로 불가능해야 함 — (1) per-q atomic done-marker (2) 미완 q만 clean 재계산, 손상 blob replay 금지 (3) checkpoint 무결성 검증(truncation/EOF→자동 재계산 fallback). selftest = 의도적 truncated checkpoint 주입→crash 없이 재계산 PASS.
- 근거 handoff: hexa-lang `fc2331a3`(QE 측 no-recover fallback 갭). QFORGE는 그 갭을 애초에 갖지 않도록 설계 — QE의 부서지는 재개를 답습하지 않음. d6: 부분결과 silent 사용 금지.

## 2026-06-04 — recover-EOF resilience 구현 SHIP (hexa-lang PR#2688+#2691, draft·g5 PASS)

- PR#2688 (`stdlib/qforge/checkpoint.hexa`, 204L): crash-resilient per-q checkpoint primitive — `qforge_checkpoint_write`(temp→flush→atomic rename, done-marker last) · `qforge_checkpoint_read`(length-prefix + adler32 검증 → {ok,payload}) · `qforge_resume_scan`(dir,nq → {done_q[],next_q}). generic payload-bytes(d4). g5: `qforge_checkpoint_selftest PASS` 16/16 — 적대적 (a)truncated→reject no-crash · (b)bad-checksum→reject no-crash · (c)interrupted-write→not-done · (d)완료q보존.
- PR#2691 (base=pr1; `scf.hexa`+122 · `realcell_qmesh.hexa`+92 · integration selftest 197): opt-in 배선 `qforge_scf_resumable`·`qforge_qmesh_dispersion_resumable` — resume_dir=="" → 기존 함수 위임(0-diff regression-pin), else per-q checkpoint skip/clean-recompute. g5: `qforge_checkpoint_integration_selftest PASS` 13/13 (I-DFPT corrupt q1/q2 → resume skip q0/q3·recompute q1/q2·nq==4 no-crash·ω==clean ≤직렬화floor 1e-6) + `qforge_scf_selftest PASS` regression.
- 둘 다 DRAFT (사용자 리뷰 후 머지) · origin/main 미접촉(resilience 커밋 0). 머지 시 QFORGE.md 마일스톤 `[x]` flip. 정직(d6): ω round-trip은 to_string 6자리 직렬화 정밀도(~1e-6 rel, 물리·λ 무의미) — bit-exact codec은 follow-up.

## 2026-06-04 — end-to-end 앵커 (자체 |g| vs QE) 자동트리거 등록

- 사용자 결정: 라우팅 전환(3-앵커 L3 게이트 ALL_PASS)과 QE 완전대체는 별개 단계로 분리. true QFORGE-only(QE 0-의존)는 앞쪽 절반(자체 SCF→DFPT→|g|)도 QE와 1% 일치해야 성립 — 현 게이트는 QE의 |g|를 어셈블러에 먹여 뒤쪽(λ·Tc)만 검증.
- 자동 트리거 잡아둠: 3-앵커 terminal+L3 ALL_PASS 도달 시 → CaH6에서 QFORGE 자체 |g| vs QE |g| end-to-end 앵커 1개 자동발사. 통과=QE 완전졸업, 갭잔존=d6/g6 정직 blocker(screening/correlation Hartree+LDA x+c, production-migration @L5). QFORGE.md 마일스톤 등록.

## 2026-06-07 — universal multi-scale 확장 축 + bio-scale 병목 상세기록 (SENOLYX RBFE 캠페인 도출)

QFORGE를 materials 전용 -> 전 스케일(원자·물질·바이오·화학·칩·시스템) hexa-native 엔진으로 확장. 이 기록의 모든 병목은 SENOLYX RBFE 캠페인(2026-06-06~07, geldanamycin/HSP90 senolytic)에서 외부도구로 bio-scale을 돌리다 실증된 것 — QFORGE-native가 풀어야 할 요구사항이다.

### A. bio-scale 병목 7종 (외부의존 실패모드 — QFORGE-native가 원천제거 대상)

| # | 병목 | 정량/근거 | 외부도구 | QFORGE-native 해법 |
|---|------|-----------|----------|--------------------|
| B1 | 거대고리 FF 부정확 | openff-2.1.0이 geldanamycin 형태에너지 지형을 GFN2 대비 2.2x over-spread(274 vs 125 kcal/mol), RMSE 75.5, Spearman 0.80; 용매(ALPB) screening 1.05x로 불변=진공 인공물 아님 | openff Sage | QM-derived 전하/토션(GFN2/DFT) native refit + 거대고리 인지 |
| B2 | 단일포즈 ABFE 절대값 무효 | ABFE −16.64±0.49(수렴) vs 실험 −8.1~−10.9 -> ~5.7 over-bind; 원인=B1(FF) | openmmtools ABFE | 상대(RBFE)로 우회 + QM-corrected FF; 절대정확 필요시 GFN2 endpoint 보정 |
| B3 | RBFE 엔진 provisioning 실패 | openfe conda-solve가 "Resolving Environment" 단계서 무한대기(15min+ 무진전) | openfe(conda-forge) | native alchemical FEP(hybrid-topology·HREX·MBAR) -> 외부 openfe 제거 |
| B4 | GPU CUDA-PTX 불일치 | vast 3-pod 전부 CUDA_ERROR_UNSUPPORTED_PTX_VERSION(222): conda openmm cuda-version(12.9/13.3) > 호스트 드라이버(12.8/13.2); 재설치 트리거로 pod 소멸 | conda openmm CUDA | QFORGE 자체 GPU(hexa eigen/fft, no openmm/CUDA-toolkit dep) — d8 hexa-lang/535ab138 |
| B5 | MD throughput | ABFE complex leg ~5h+/RTX5070(20-win·1000iter·4ns/win); 2-ABFE RBFE ~10h | openmm CUDA | el-ph FFT/eigen GPU 커널을 MD에 재사용 |
| B6 | 실험 앵커 취약 | 문헌 Kd 1.2µM은 pre-equilibrium(slow tight-binding); 평형 9nM(−10.9) -> over-bind 8.5->5.7 재앵커 | — | verify-adapter가 redox/protonation-matched congeneric ΔΔG 강제(계통오차 상쇄) |
| B7 | env 취약성 | summer fep env가 micromamba(miniforge 아님) 경로, reboot간 toolchain 깨짐; xtb 별도설치 필요 | conda/micromamba | QFORGE self-contained(외부 conda env 무) |

### B. materials-scale 병목 (기존, 참고 — 동형 패턴)
- 상관-XC gap: screening=Hartree+LDA-exch only -> production 정확도 블로커시 정직 보고(d6).
- pool toolchain(summer) 깨짐 이력 · pow2 FFT-Poisson screening 벽(CaH6 λ=4.137, QE 대비 5.47% off).
=> bio도 동일: 외부의존(QE<->openff) 걷어내기 = QFORGE 정체성.

### C. 스케일 확장 마일스톤 (상세 · 진행가능 단위 · 각 = front-end -> core -> verify)

#### atoms (QM 단분자)
- [ ] M-A1 GFN2-xtb 등가 tight-binding 단분자 엔진(hexa-native) — 전하·토션·conformer 상대에너지; verify: xtb/DFT ref g5. (SENOLYX R11이 외부 xtb로 한 일 = native화)
- [ ] M-A2 DFT 단분자 SCF — 전자구조·ESP 전하(RESP); verify: NWChem/QE 분자. 재사용: materials SCF(주기경계 -> 분자 클러스터).

#### bio (MD/FEP) — 최우선 (캠페인이 수요 입증)
- [ ] M-B1 native explicit-solvent MD: LangevinMiddle + PME + 강체물 — verify: openmm 에너지/force 일치 g5. (el-ph FFT를 PME에 재사용)
- [ ] M-B2 alchemical factory: soft-core λ(elec/sterics) hybrid-topology — verify: openmmtools ABFE/RBFE 수치 일치.
- [ ] M-B3 HREX replica-exchange + MBAR estimator — verify: pymbar 일치; 수렴진단(overlap matrix·forward/reverse).
- [ ] M-B4 QM-derived FF 파이프(M-A1 연결): GFN2 전하·토션 refit -> B1 거대고리 부정확 해결; verify: GFN2 conformer 지형 재현.
- [ ] M-B5 atom-mapping(Kartograf 등가, 기하기반) — 거대고리 substituent perturbation; verify: 매핑 정합.
- [ ] M-B6 docking + MM-GBSA front-end (AGA-RX/SENOLYX 스택 흡수). 검증쌍 표준: redox/protonation-matched congeneric ΔΔG (17-AAG<->17-AG hydroquinone ΔΔG_exp −0.65, cb600224w).

#### chem (반응)
- [ ] M-C1 NEB/string TS 탐색(DFPT 선형응답·force 재사용) — verify: 실험/CCSD(T) 장벽.
- [ ] M-C2 반응경로 IRC + 촉매 turnover.

#### chip (소자)
- [ ] M-D1 밴드구조·effective mass front-end(materials SCF 재사용).
- [ ] M-D2 수송(NEGF/Boltzmann) + 자기발열(열전); verify: TCAD/측정.

#### system (multi-scale)
- [ ] M-S1 QM/MM 결합 드라이버(bio active-site QM + 환경 MM).
- [ ] M-S2 coarse-grain/연속체 bridge(스케일 일관성 verify).

#### 공통 인프라
- [ ] M-X1 verify-adapter 일반화: scale별 cross-val ref 플러그인(materials=QE · bio=실험ΔΔG · chem=QM · chip=TCAD) — hexa verify g5 통일.
- [ ] M-X2 NEXUS edge QFORGE->{SENOLYX·AGA-CURE·IVD-CURE·OA-CURE·…}(bio 엔진 의존; materials c7 패턴 복제).
- [ ] M-X3 self-contained GPU 배포(B4 해결): no 외부 openmm/CUDA-toolkit; hexa eigen/fft + PTX 호스트 드라이버 자동매칭.

### D. 진행 우선순위 (d2 breakthrough-path)
1. bio가 최고가치(4 CURE 도메인 + SENOLYX 즉시 소비; 캠페인이 수요·병목 다 입증).
2. M-B1(native MD) -> M-B2/B3(FEP) 가 핵심경로; M-A1(QM)이 M-B4(FF교정) 선결.
3. materials c7(GATE CLOSED)가 템플릿: front-end+core+verify 3분할 + QE자리에 scale별 ref.
4. 각 마일스톤 g5 verify + atlas fold (d_atlas_as_audit_ssot).
