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
