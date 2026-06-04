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
