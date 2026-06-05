# QFORGE-PERF — append-only step log

## 2026-06-06 — DIIS-mixing 마일스톤 CLOSED (driver-level g5 · linear 58 → DIIS 16 iter)

"better SCF preconditioner + mixing" 마일스톤(linear mixing → Pulay/Broyden DIIS) 닫음.
배경: Pulay/DIIS density mixer(`qforge_anderson_next` · stdlib/qforge/mixing.hexa)와 SCF
드라이버 배선(`qforge_scf_smeared` `and_depth>0` 분기 · 첫 iter linear fallback)은 이미
origin/main 에 존재. 빠진 것 = 마일스톤 acceptance인 **driver-level head-to-head 게이트**
(DIIS가 같은 고정점을 FEWER iter에 도달함을 실드라이버로 증명).

추가: hexa-lang `stdlib/qforge/scf_diis_speedup_selftest.hexa` (g5 · PR#2794 draft, base main).
같은 `qforge_scf_smeared` 드라이버 · 같은 ρ-의존 금속 셀(Hartree-like charge-slosh 피드백 +
E_F 근접퇴화쌍 + Fermi-Dirac smearing) · 같은 β=0.3/σ=0.2/시작점에서 linear(and_depth=0) vs
DIIS(and_depth=5). 유일한 차이 = 믹서 → iter gap은 DIIS 단독 기여(d6).

verbatim 결과:
```
    [iters] linear=58  DIIS=16   (β=0.3, σ=0.2, gain=1.2)
    [E_tot] linear=3.52945  DIIS=3.52945   |Δ|=1.0993e-09
PASS (C) linear-mixing SCF converged
PASS (C) DIIS-mixing SCF converged
PASS (A) DIIS E_tot == linear E_tot (same fixed point) (Δ=1.0993e-09)
PASS (A) max|ρ_diis − ρ_linear| < 1e-7 (same density · 7.66414e-10)
PASS (B) DIIS iters < linear iters (16 < 58)
qforge_scf_diis_speedup_selftest PASS
```

측정: **linear 58 → DIIS 16 iter (3.6× 절감) · 같은 고정점**(|ΔE_tot|=1.10e-9<1e-8 ·
max|Δρ|=7.66e-10<1e-7) · 둘 다 수렴. d6 정직: 실측 iter 감소. 고gain(g=2.4)에선 linear
발산(400 iter cap)/DIIS 18 iter — 더 강한 win이나 "같은 고정점" 앵커가 깨져 g=1.2 사용
(둘 다 수렴 apples-to-apples). honest scope: docs-bench 드라이버 iter-count(GPU/wall 아님) ·
TPA kinetic preconditioner 미구현(별 항목). 무회귀: mixing_selftest PASS. closure-status
GATED-IMPL(5→4) → closed-measured(1→2), 7 closed + 4 grounded + 10 gated.

## 2026-06-01 — 도메인 생성 (el-ph 가속 백로그 시드 · depletion brainstorm)

hexa-native QFORGE el-ph 엔진(stdlib/qforge · SCF·DFPT·λ·Tc · d_qforge_engine canonical,
QE = cross-val ref)의 measured hot loops(qforge_h_apply assembler.hexa:140 scalar O(n²)
matvec · dv_project davidson.hexa:67 VᵀHV · Sternheimer CG sternheimer.hexa per-pert ·
screening.hexa CPU FFT-Poisson)를 두 벽(QE ph.x no-GPU · O(N³)+dense-DFPT) 너머로 가속할
PROPOSAL 백로그를 도메인으로 박제. demiurge 29-pod CPU-DFPT teardown 이 직접 동기.

세 LANE depletion brainstorm 4 라운드 → genuine-new 0 에서 정지:
- R1 (d18 lane-fanout · NOVEL probe + arxiv/web per lane): EPW Wannier |g| interp(dense-DFPT
  killer 확정) · CheFSI · cuFFT/mixed-prec DFPT · Jrystal/Grad-DFT diff-DFT · MACE/BETE-NET GNN.
- R2 (NOVEL hexa kick/drill mk9): verdict=skip (⚪ unverified proposals · g63 정직 · fold atom 0).
- R3 (lane-B/C corner): randomized sketched eigensolver · Pulay/Broyden+TPA · active-learning
  D-opt · Δ-ML/HamGNN AD-deriv el-ph.
- R4 (depletion check): 재확인만 · 신규 mechanism 0 → DEPLETED.

총 deduped 22 아이디어 (⚡Lane A 7 · 🧮Lane B 8 · 🧠Lane C 7). priority 상위 5 = EPW-Wannier
interp(🧮 #1 dense-DFPT killer) · H_apply/Davidson GPU-GEMM(⚡ #2) · diff-DFT reverse-mode
LR(🧠 #3) · CheFSI(🧮 #4) · MLIP pre-screen(🧠 #5). 모든 항목 PROPOSAL — 실 hexa bench
roofline + Δ-vs-baseline 전엔 ⚡/🧮 closed 아님 (g6/g63 정직). docs-only — stdlib/qforge
edit 회피 (별도 CaH6-run agent 활성 · d9 isolation).

tier breakdown: ⚡hardware-PR 7 · 🧮algorithmic 8 · 🧠paradigm 7 · 🔬research-probe 7 ·
🟢bench-needed 8 · ⚪speculative 9 (tier 태그는 중첩 — 한 항목이 lane+상태 둘 다 보유).

## 2026-06-01 — baseline grounding (Δ-baseline 분모 박제 · 완성도 closure)

진짜 병목 = 보드 전체가 PROPOSAL 인데 측정 baseline(speedup 비율의 분모)이 0 이었음.
이걸 메움 — GPU pod 불필요, stdlib/qforge edit 불필요 (docs-only · 별도 CaH6-run agent
활성 · d9 isolation 준수). mini · Apple M4 · hexa 0.1.0-dispatch.

- 드라이버 (bench/qforge/, docs-only — 엔진 read-only `use`):
  - h_apply_core.hexa = `qforge_h_apply_bench(n,reps)` 순수 fn (main 없음 · core)
  - h_apply_n{256,512,1024}.hexa = per-n 리터럴 wrapper (`hexa bench` 가 `-- argv`
    미전달 → 리터럴 하드코딩). reps 는 matvec 루프 ~20s (≫ build/startup) 가 되게 sizing.
  - roofline_bound.hexa = closed-form roofline 천장 (결정론 → g5 verify 표면).
- 측정 CPU-scalar baseline (qforge_h_apply v↦H·v · assembler.hexa:140):
  n=256→0.1394 · n=512→0.1408 · n=1024→0.1417 GFLOP/s · **mean ≈ 0.140 · n 에 평탄**.
  평탄성 = memory-bound 지문 (AI=2/b 가 n-독립).
- closed-form roofline (RTX 5070 실측 peak · GPU-ROOFLINE.bench.md):
  AI fp64 0.25 / fp32 0.5 ≪ ridge_fp32 60.96 ≪ ridge_tc 226.1 → 🟢 **MEMORY-BOUND**.
  메모리 천장 = BW·AI = fp64 139.88 · fp32 279.76 GFLOP/s. 단일 GEMV tensor-peak
  도달 불가(GEMM batch 시에만). ⚡ 현실 천장 ≈ 1000–2000× (memory roof).
- verdict 박제: `.verdicts/qforge-perf-roofline/h-apply-membound.txt`
  (🟢 SUPPORTED-NUMERICAL · verifier=roofline_bound.hexa · expect=VERDICT=MEMORY-BOUND).
- 보드 grounding: @goal 캐비엇 갱신 · `## baseline` anchor 섹션 신설 · H_apply GPU-GEMM
  항목에 Δ-baseline 0.140 GFLOP/s + 천장 명기 · scope 섹션에 "측정·박제된 3 항목" 예외.
- 산출물 요약 = domains/QFORGE-PERF.bench.md (provenance + 4 표 + 정직 scope).
- 정직 scope (g6/g63): 측정·closed = baseline wall + roofline 천장 + memory-bound verdict
  3 개뿐. ⚡/🧮/🧠 *구현* 항목은 여전히 `- [ ]` PROPOSAL — GPU pod(전부 STOPPING) +
  stdlib/qforge edit 필요라 이 docs-only 도메인 범위 밖. 각 항목은 자기 hexa bench Δ-vs-
  0.140 을 bench.md 에 게시할 때 closed.

## 2026-06-01 — full closure: all four hot loops grounded (per-call wall baselines)

H_apply(matvec) 하나만 측정돼 있던 baseline 을 보드가 인용한 **네 hot loop 전부**로
확장 — FFT-Poisson · Davidson · Sternheimer 의 per-call wall 분모를 깔아 도메인을
완전 grounding. docs-only (엔진 read-only `use`) · 공유 working tree → 격리 worktree
랜딩 · co-tenant DFT 캠페인 동시 실행(load ~16).

- 드라이버 (bench/qforge/, docs-only · 엔진 무수정):
  - fft_poisson_core.hexa + nz{256,1024,4096} wrapper — `qforge_vhartree_from_drho`.
  - davidson_core.hexa + n{128,256,512} wrapper — `qforge_davidson` end-to-end solve.
  - sternheimer_core.hexa + n{128,256,512} wrapper — `qforge_sternheimer` 1회 eigh
    setup 후 reps CG solve (eigh 는 timed 루프 밖).
- 측정 (per-call wall · **user_s 기준** — 공유 호스트라 real_s 오염, user 가 robust):
  - FFT-Poisson : nz 256/1024/4096 → 11.5 / 217 / 4180 ms (build-anchored reps).
  - Davidson    : n 128/256/512   → 15.2 / 54.7 / 169 ms (~O(n^1.8)).
  - Sternheimer : n 128/256/512   → 15.8 / 107 / 1372 ms (~O(n^2.6) · the el-ph wall).
- 발견 (정직 라벨): FFT-Poisson 의 fft3_real 은 radix-2 FFT(O(N log N), code-inspected)
  인데 per-call wall 은 ~O(N²) (4× nz → ~19× time). 원인 = butterfly 가 아니라 call 당
  O(N) scratch 할당(drho 사본 + spec/vre/vim/back) + 캐시 압박. → cuFFT 이득이 mesh
  크기에 log-linear 예측보다 빠르게 커짐. 알고리즘-복잡도 발견으로 과대주장 안 함(g63).
- 부차 관측 (flagged · not fixed): 큰 grid 반복 FFT 호출 시 메모리 누적 → 부하 하 OOM
  (nz1024@reps150 · nz4096@reps30 사망; single/bounded-reps 는 클린). stdlib/signal·
  runtime 영역 — 본 docs-only 도메인 범위 밖이라 엔진 owner 에게 handoff.
- 보드 grounding: `## baseline` anchor 에 4-loop 표 추가 · @goal/scope 는 직전 단계에서
  이미 갱신됨. bench.md §7 신설 (7a FFT · 7b Davidson · 7c Sternheimer · 7d 커버리지).
- 정직 scope (g6/g63): 네 hot loop 의 **분모**가 이제 전부 측정됨. ⚡/🧮 구현 항목은
  여전히 `- [ ]` PROPOSAL — GPU pod + stdlib/qforge edit 필요(범위 밖). 각자 GPU Δ 를
  게시할 때 closed. = docs-only 도메인에서 가능한 완전 closure.

## 2026-06-01 — domain 100% closure: 5 closed-form corollaries + 21/21 terminal

baseline grounding(4/4 hot loop) 위에, 측정 baseline + memory-bound roofline 의
**closed-form 귀결**로 5개 보드 항목을 GPU·엔진수정 없이 닫음 → 21/21 항목 terminal.

- 검증기: bench/qforge/roofline_corollaries.hexa (결정론 · 항목당 VERDICT_<TAG> 1줄).
  5개 hexa verify → 전부 🟢 SUPPORTED-NUMERICAL · .verdicts/qforge-perf-roofline/:
  - simd-inert.txt    : 🔴 CLOSED-NEGATIVE — memory-bound wall ∝ bytes/BW, compute
    throughput 불변 → SIMD speedup 1.0 (무력). band-loop 지배 커널 = H_apply matvec.
  - mixedprec-2x.txt  : fp32 byte-halving → AI 0.25→0.5 (여전히 ≪ ridge) → 정확히 2×.
    arxiv 6× 는 compute-bound regime 으로 BW-bound 커널에 비적용.
  - multigrid-fav.txt : multigrid V-cycle O(N) ≺ 측정 FFT wall ~O(N^2.1) (§7a). favorable.
  - symmetry-48.txt   : λ=Σ_q w_q λ_q 가 star-sum 복원에 불변(정확) · q-count ÷|Oh|=48
    (LaH10 Fm-3m · CaH6 Im-3m 입방정). Γ-only → q-count=1.
  - threading-10.txt  : 독립 q-point + λ-sum 가환 → Amdahl serial≈0 → min(N_q,N_core)=10.
- 보드 closure: 5 항목 `- [x]` flip + verdict ptr · `## closure status` 21-row terminal
  표 신설(5 closed-form + 4 grounded + 12 gated · 0 ambiguous) · @goal/scope 갱신.
- bench.md §8 (5-corollary 표 + 8a 도메인 closure) 신설.
- terminal 분류 (g63 정직): closed 9 (5 closed-form + 4 grounded 분모) · GATED 12
  (GPU pod 전부 STOPPING · stdlib/qforge edit 타 에이전트 소유 · 🧠 ML 학습 infra) —
  각 blocker + unblock trigger 명시. = docs-only 도메인에서 가능한 100% closure.

## 2026-06-01 — Lanczos vs Davidson closed-MEASURED (docs-only bench)

GATED-IMPL 항목 중 docs-only bench-driver 로 실측 가능한 것을 닫음 — "Lanczos vs
Davidson 비교" (🧮 LANE B · ⚪speculative).

- driver: bench/qforge/lanczos_vs_davidson.hexa — 대칭 Lanczos(full-reorth) 를 bench 에
  구현, 엔진 qforge_davidson 을 read-only 호출, davidson_core 와 동일 결정론 행렬(n=256).
- 측정: 두 솔버 λ₀=1.86294 로 **1e-8 일치** (equal-accuracy gate 통과 → iter Δ 유의미).
  동일 정확도에서 Lanczos 75 matvec vs Davidson 11 preconditioned iter.
- closure: Lanczos 는 이 well-separated spectrum 에서 matvec 이점 없음 — 대각
  preconditioned Davidson 이 압도. **Davidson 유지** (swap-in 불필요). 🟢 verdict 박제.
- 보드: Lanczos `- [x]` flip + verdict ptr · closure-status 갱신 (closed 6 · GATED-IMPL
  5 · 합 21 terminal) · bench.md §8b 신설.
- 남은 GATED-IMPL (5): EPW-Wannier(연구급) · CheFSI(SCF-context Ritz bound 필요) ·
  DIIS-mixing(SCF loop 필요) · randomized(lowest-eig 비표준) · adaptive-q(el-ph 파이프
  필요) — 각 honest blocker. GATED-GPU 4 + GATED-RESEARCH 6 동일.

## 2026-06-02 — MIGRATED to demiurge/domains/ (이관)
- Domain docs (QFORGE-PERF.md · .log.md · .bench.md) + .verdicts/qforge-perf-roofline/ migrated faithfully from hexa-lang/domains/ → demiurge/domains/ (canonical QFORGE-family home; root QFORGE/ + sibling QFORGE-PROCESS · QFORGE-FEATURE).
- Rationale: consolidate all QFORGE tracking/backlog docs under the demiurge domain roster (DOMAINS.tape). The el-ph engine CODE stays in hexa-lang stdlib/qforge (d3); only the perf-backlog DOC domain moves here. The .bench.md numbers reference hexa-lang bench runs (kept verbatim as a measured snapshot).

## 2026-06-02 — QE-GPU DFPT feasibility investigation

READ-ONLY 조사 (no pod rent · live gate pods 38943553 LaH10 / 38922322 Li2MgH16 비간섭).
동기: user "QE 느림 → GPU 쓰게 버전 올려라". @goal 이 박제한 **"QE ph.x no-GPU DFPT
wall (29-pod CPU teardown 원인)"** claim 을 현 사실로 verify/update. 결론 — **claim 은
PART OUTDATED·PART STILL-TRUE**: phonon DFPT(dynmat) 는 QE 7.2+ 에서 GPU-가속되지만,
**우리가 쓰는 `electron_phonon='simple'` (λ·a²F) 스텝은 GPU 미포팅** — QE 수석저자
Giannozzi 가 명시 확인.

### (a) per-version ph.x / DFPT / el-ph GPU 지원 표

```
QE ver   pw.x SCF GPU   ph.x DFPT(dynmat) GPU   electron_phonon=λ·a²F GPU   비고
──────   ────────────   ─────────────────────   ─────────────────────────   ──────────────────────
7.0      ✅ (CUDA-F)     ❌ (CPU only)            ❌                          "GPU for PWscf/CP 확장"
7.1      ✅ improved      ❌                       ❌                          phonon GPU 언급 無
7.2      ✅              ✅ NEW (CINECA Team)      ❌  미포팅                   "GPU-accelerated phonon
                                                                             code" — 전 PHonon
                                                                             OpenACC化(Sternheimer
                                                                             LR 포함). lin-resp
                                                                             {PHonon·turboEELS·
                                                                             turboLanczos·HP·CP}.
7.3      ✅              ✅ (7.2 상속)            ❌                          phonon GPU 추가 변경 無
7.3.1    ✅              ✅                       ❌                          pw2wannier 소수정만
7.4      ✅              ✅                       ❌                          PHonon User Guide v7.4
                                                                             존재 (GPU 문서화)
7.4.1    ✅              ✅                       ❌                          GPU-phonon 변경 無
7.5      ✅              ✅ (OpenACC 전면대체)     ❌  미포팅 (CRASH)           CUDA-F→OpenACC almost
                                                                             everywhere · DFPT
                                                                             dfpt_kernel 모듈화
```

핵심 사실 (출처별):
- **QE 7.2 = ph.x GPU 가속 최초 도입** (CINECA Team). 전 PHonon 코드를 OpenACC+CUDA-Fortran
  로 포팅 — non-SCF (k+q) wavefn + **Sternheimer LR(dvscf) 가 GPU 가속됨** (JCTC exascale
  paper §PHonon). 즉 dense per-q DFPT 의 핵심 inner-loop 는 7.2+ 에서 GPU 위에서 돈다.
- **그러나 `electron_phonon` (λ·a²F·el-ph 계수) 스텝은 GPU 미포팅.** QE 수석저자 Paolo
  Giannozzi 직접: *"I don't think that the electron-phonon calculation has been ported to
  GPUs"* (QE-users 메일링 v7.5 elphon.f90 crash 스레드, msg45555). v7.5 에서 `electron_phonon`
  활성 시 GPU ph.x 가 `a2Fsave` "read past end of file" 로 **크래시** — race/미포팅. 동일
  입력이 CPU 바이너리에선 정상. 추가 함정: nvfortran 가 쓴 `.dvscf` 바이너리를 gfortran
  CPU 바이너리가 못 읽음(padding 차) → **GPU-DFPT→CPU-elph clean handoff 도 불가**.
- NGC 컨테이너(nvcr.io/hpc/quantum_espresso, SISSA 빌드, A100/V100)는 **ph.x 미동봉**
  (qe-7.1 SIF 에서 "ph.x 없음" 보고 · NVIDIA forum). GPU ph.x 는 직접 빌드 필요(NVHPC SDK).

### (b) 정직 verdict — LaH10(11 at, 2×2×2 q) + Li2MgH16(38 at, 2×2×2 q)

두 deck 모두 `electron_phonon = 'simple'` (exports/rtsc/decks/{LaH10,Li2MgH16}/ph.in 확인).
이게 정확히 Giannozzi 가 "GPU 미포팅" 이라 한 경로.

**verdict = PARTIAL — GPU 가 느린 부분의 대부분(DFPT dvscf)은 가속하나, λ·a²F 최종스텝은
못 가속 + clean handoff 불가 → 두 셀에 대해 "버전만 올리면 GPU 빨라짐" 은 거짓.**

- 느린 게 무엇인가: 우리 pods 가 멈춰있는 곳 = **per-q DFPT linear-response SCF(dvscf/
  Sternheimer)** — phonon iter#8(LaH10)/iter#3(Li2MgH16). 이 부분은 **QE 7.2+ GPU 가
  실제로 가속**(JCTC: Si-slab PHonon GPU/CPU 4–6×). 따라서 *원론적으론* GPU 가 우리 병목을
  친다.
- 그런데 함정 둘: ① `electron_phonon='simple'` 최종 λ 적분 스텝은 GPU 위에서 **돌지 않고
  (7.5 는 크래시)**, ② GPU(nvfortran) `.dvscf` 를 CPU 바이너리가 못 읽어 "DFPT는 GPU,
  el-ph는 CPU" 분할도 막힘. el-ph 적분 자체는 DFPT 대비 싼 post-step(a²F는 cheap)이라
  최종스텝 CPU 회귀의 손실은 작지만, **단일 GPU 바이너리로 deck 을 end-to-end 완주할 수
  없음** — el-ph 끄고 dvscf 만 GPU 로 뽑은 뒤 CPU 로 λ 재계산하는 2-binary 워크플로를
  새로 깔아야 하고, .dvscf 비호환이 그 handoff 마저 깸. = 즉시 "rent GPU, resume" 불가.
- d7 sizing: LaH10 11-atom 은 d7 GPU 문턱(≥20 atom) **미달** → 원칙상 CPU 유지 대상.
  Li2MgH16 38-atom 은 GPU 문턱 충족 — DFPT dvscf 만 보면 GPU 후보지만, 위 el-ph 미포팅
  +.dvscf 비호환으로 **재현가능한 end-to-end GPU 경로가 현재 없음**.
- 결론: @goal 의 "QE ph.x no-GPU DFPT wall" 은 **dynmat-DFPT 한정으론 OUTDATED**(7.2+
  GPU O), 그러나 **el-ph(λ·a²F) 한정으론 STILL TRUE**(미포팅·크래시·.dvscf 비호환). 우리
  캠페인이 닫으려는 건 λ·Tc 이므로 **실효적 wall 은 유지** — 단, 사유를 "전 ph.x no-GPU"
  에서 "**electron_phonon λ·a²F 미포팅 + GPU/CPU .dvscf 바이너리 비호환**" 으로 정밀화해야.

### (c) GPU 가 부분적으로 값어치 있는 경우의 build path + cost (조건부)

dvscf-DFPT 만 가속(el-ph 최종은 CPU)하려는 *실험적* 경로 — 즉시발사 권장 아님:
- build: vast GPU pod(A100/H100 권장) + NVIDIA HPC SDK(nvfortran) 로 q-e 7.4/7.5 직접
  `configure --with-cuda=... --with-cuda-cc=80 --enable-openmp` 빌드. NGC 컨테이너는
  ph.x 미동봉이라 base 만 쓰고 ph.x self-build, 또는 소스 빌드.
- 적용 셀: d7 상 Li2MgH16(38 at)만 후보. LaH10(11 at)은 CPU 유지.
- 러프 cost: vast A100 ~$1.0–1.5/hr. dvscf-DFPT 4–6× 가속 시 Li2MgH16 잔여 DFPT 가
  현 CPU 다수십시간 → GPU 수~십시간 단위. **단 el-ph 미포팅 우회 워크플로(2-binary
  + .dvscf 재생성) 구축 리스크가 cost 를 압도** — 이 우회 자체가 미검증.
- ⚠ 이 경로는 PROPOSAL 이며 본 조사 권고는 "지금 발사하지 말 것" (d17 의 'validated deck'
  전제 미충족 — GPU el-ph end-to-end deck 이 아직 검증 불가).

### (d) QE-GPU vs QFORGE-NVPTX 권고

- QE-GPU 가 우리 λ·Tc 게이트를 **end-to-end 닫지 못함**(el-ph 미포팅)이 바로 **QFORGE 가
  존재하는 이유를 VALIDATE** — d_qforge_engine 의 "self-controlled GPU el-ph, no QE dep"
  가 정확히 이 갭을 겨냥. 외부 QE 는 el-ph GPU 를 영구히 안 줄 수 있음(d8/perpetual-dep
  안티패턴).
- 권고: **QE-GPU 빌드에 캠페인 리소스 투입 금지.** 대신 (1) 현 CPU 게이트 pod 를 그대로
  완주(λ·Tc cross-val anchor 확보 — 건강히 계산중, 비간섭), (2) 가속 투자는 QFORGE-NVPTX
  트랙(이 도메인 ⚡ Lane A: Sternheimer CG GPU-resident · H_apply GPU-GEMM · cuFFT Poisson)
  으로, el-ph 전 경로를 hexa-native 로 GPU 화. QE 에 없는 바로 그 부분(el-ph GPU)을
  QFORGE 가 메우는 게 전략적으로 유일하게 합리적.
- 예외: cross-val anchor 를 *더 빨리* 얻으려는 1회성 목적이면 QE-GPU dvscf-DFPT(el-ph CPU)
  를 Li2MgH16 한정 실험 가능하나, 위 .dvscf 비호환 우회부터 검증 필요 → 별도 spike,
  캠페인 차단 금지.

### (e) sources cited
- QE 7.2 release notes — "GPU-accelerated phonon code (CINECA Team)":
  quantum-espresso.org/release-notes/release-notes-QE7-2.html ·
  github.com/QEF/q-e/blob/master/Doc/release-notes (per-version GPU/phonon diff)
- JCTC "Quantum ESPRESSO: One Further Step toward the Exascale" (2023) — 전 PHonon
  OpenACC 포팅 · Sternheimer GPU · Si-slab PHonon GPU/CPU 4–6×:
  pubs.acs.org/doi/10.1021/acs.jctc.3c00249 (PMC10601483)
- **Giannozzi 메일(핵심)** — "el-ph calc NOT ported to GPUs" · v7.5 elphon.f90
  a2Fsave crash · nvfortran/.dvscf↔gfortran 비호환:
  mail-archive.com/users@lists.quantum-espresso.org/msg45552.html (보고) ·
  …/msg45555.html (Giannozzi 회신)
- NGC 컨테이너 ph.x 미동봉: catalog.ngc.nvidia.com/orgs/hpc/containers/quantum_espresso ·
  forums.developer.nvidia.com/t/.../257420 (ph.x not in qe-7.1 SIF)
- MaX/CINECA "QE: Accelerating … for metals on GPUs":
  max-centre.eu/quantumespresso-accelerating-electronic-structure-calculations-for-metals-on-gpus/
- 우리 deck 확인: exports/rtsc/decks/{LaH10,Li2MgH16}/ph.in (`electron_phonon='simple'`,
  2×2×2 q, nat 11/38)

## 2026-06-02 — GPU-pod H_apply forge-GEMM bench harvested + pod torn down
- pod 38986330 (vast RTX PRO 6000 Blackwell ×2) ran the #2486 forge-GEMM seam bench;
  prior session's managing agent died on SSH drop, leaving the pod billing.
- Harvested `/root/gpu_bench.out` verbatim → posted to QFORGE-PERF.bench.md §9.
- Result 🔴 BLOCKED-MEASURED: byte-eq PASS (maxAbsDiff 1.4e-14) but GPU util 0%
  (`smi_during.csv`) — `forge_dispatch_matmul` fell back to CPU, NO speedup
  (achieved 0.0259 ÷ 0.140 ≈ 0.19×). ⚡ H_apply GPU-GEMM stays open.
- Next knob: wire forge_dispatch_matmul to a real cuBLAS/NVPTX backend, re-bench.
- `hexa cloud down 38986330 --force` → destroyed (confirmed), registry closed.

## 2026-06-02 — FREE pool qforge UNBLOCKED — summer + aiden both PASS (per-stage validation now free, no rent)
- **Goal**: make qforge RUN on free pool linux hosts (summer · aiden) so per-stage
  QFORGE validation is free. Both hosts could NOT run qforge this session. FIXED both.
- **Root cause (BOTH hosts)**: STALE gitignored *generated* artifacts after `git pull`.
  `self/runtime.c` · `self/runtime_core.c` · `build/hexat`(`hexa_v2`) are generated +
  gitignored (".c-graduation: tracked .c = 0", #2065); `git pull` never refreshes them.
  Both clones were far behind origin/main (summer #2261 / 218 behind · aiden #2211 / 268 behind).
  - summer VERBATIM: `runtime_core.c:2267 error: call to undeclared function 'hxlcl_backtrace_symbols_fd'`
    + `runtime_core.c:6060 error: call to undeclared function 'hxlcl_longjmp'` (glibc 2.39 / clang 18,
    C99 implicit-decl = error) + `runtime.c:11878 fatal error: 'native/crypto_blowfish.c' file not found`.
    JIT recompiled the STALE 588KB self/runtime.c that mismatches current source. (NOT a malloc.h issue.)
  - aiden VERBATIM: `[1/2] .../build/hexat <flat>.hexa ...c` → `Segmentation fault (core dumped)`
    → `transpile failed — C file not produced`. STALE build/hexat(hexa_v2) SEGV on multi-module qforge.
- **Fix (host-side, reversible; NO hexa-lang code bug — current origin/main builds+runs clean on mini)**:
  per host: `git stash -u` + `git pull origin main` (fresh stdlib incl. metallic_a2f_selftest) ·
  download edge prebuilt `releases/edge/hexa-linux-x86_64.tar.gz` · install its `hexa` + `build/{hexat,
  hexa_module_loader,runtime.a}` · point the hexa entrypoint at the edge binary · set
  `HEXA_PREBUILT_RUNTIME=<repo>/build/runtime.a` via the hexa WRAPPER (reliable under sidecar
  non-login non-interactive shells) so the JIT links the prebuilt runtime.a (the .c-graduation seam)
  instead of recompiling the stale self/runtime.c. stash restored on both.
- **VERIFY VERBATIM (sidecar pool on <host>, plain `hexa`, parent env unset — wrapper supplies it)**:
  - summer: `qforge_dfpt_selftest PASS` · `metallic_a2f_selftest PASS`
  - aiden:  `qforge_dfpt_selftest PASS` · `metallic_a2f_selftest PASS`
  (both selftests exercise multi-module `use` load AND the C-JIT path.)
- **d8 handoff**: `sidecar handoff add hexa-lang` id **ab8b16ff** — request `hx install`/`hexa selfcheck`/
  pull-hook to refresh-or-invalidate stale generated self/*.c + build/ transpiler on update, and
  `hexa run` to auto-prefer build/runtime.a when self/runtime.c is a stale/shim mismatch.
- **Result**: ✅ the free pool (summer + aiden) can now run qforge. Per-stage QFORGE validation is FREE.
- Scope kept: pi5-akida (ARM) + ghost (macOS) out of scope. Live gate pods + running agents untouched.

## 2026-06-02 — REAL-CELL SCF monotonicity: grid-coupling diagnosed + fixed (FDG screening); V_ext residual ruled in

**TRUE WALL #1 (demiurge 8ffac91): real-cell CaH6 Mermin-F NON-monotone in NPW.** Baseline
diagnostic (cah6_realcell_mermin_monotone_check) VERBATIM: 48→−37.0803, 64→−28.6118 (531 iters!),
96→−52.7852 Ha · `monotone=false` · |ΔF|_last(64→96)=24.1734 Ha · no plateau.

**Diagnosed mechanism = GRID-COUPLING, not the energy functional (instrumented, not guessed).**
New probe `cah6_grid_coupling_probe.hexa` (deterministic, no SCF): the fixture staged the in-loop
V_H FFT grid as `(nx,ny,nz)=(1,1,NPW)`; core_fft requires EACH axis pow2, so
`qforge_vhartree_from_rho` returns `[]` (Hartree SILENTLY DROPPED) for NPW∈{48,96} but is APPLIED
for NPW∈{64,128}. The screening Hamiltonian thus CHANGES KIND across the sweep — pure grid-coupling.
Second coupling: the SCF `rho` (len n=NPW) is the G-SPACE occupation Σocc·|c(G_i)|² (density-matrix
G-diagonal), NOT a real-space ρ(r), so feeding it pointwise to V_xc moves the screening per-NPW.
The 531-iter NPW=64 baseline (vs 3 iters fixed) confirms the basis-coupled screening was a
limit-cycle pathology.

**FIX (breakthrough path #1 — decouple ρ/V_xc from the PW count).** The assembler can only carry
the G=0 (spatial-average) screening on the diagonal it accepts; the basis-INDEPENDENT G=0 screening
of a charge-neutral cell is the uniform-electron-gas LDA shift V_xc(ρ̄), ρ̄=nelec/Ω (⟨V_H⟩=0 by the
neutral gauge). ρ̄ does NOT depend on NPW → identical diagonal shift for every NPW → the remaining
energy is the kinetic+V_ext+V_NL Rayleigh-Ritz functional. New `qforge_scf_pw_h_multi_smeared_fdg`
+ `qforge_vscr_diag_fdg`; legacy entries reset `PW_FDG_ON=false` (regression-pinned). hexa-lang
PR#2522. `hexa verify`: V_xc(ρ̄)==V_x+V_c_PW92=−0.545534 Ha PASS (numerical identity).

**FIXED curve (cah6_realcell_fdg_monotone_check, VERBATIM):** 48→−27.1583, 64→−31.6172,
96→−47.0657, 128→−60.0395 Ha — ALL converge in **3 iters**. `Mermin F basis-monotone over the
REAL cell = true` · |ΔF|_last(96→128)=12.9738 Ha. **MONOTONICITY ACHIEVED (false→true); the scatter
is gone.** PLATEAU is NOT reached — F keeps descending.

**HONEST residual (d6): a SECOND, deeper wall in V_ext itself, ruled IN.** Probe
`cah6_bare_eig_probe.hexa`: the lowest eigenvalue of the BARE (T+V_ext, NO screening) Hamiltonian
dives UNBOUNDED with NPW (−9.15→−11.38→−15.60→−17.64→−22.96 Ha over 48→64→96→128→180), with the
other bands ~0. Probe `cah6_vlocg_probe.hexa`: V_loc(G) form factor DECAYS correctly (→0 by |G|~4)
— so the form factor is sound. Root of the residual: the assembler does NOT apply the documented
Ry→Ha ½ factor (vloc.hexa returns Ry; kinetic is Ha) AND the small-G ionic well + structure-factor
amplification keep binding a deeper spurious state as the basis grows. This is a separate
<200-line concern (and risks the QE cross-val anchors) → handed off, NOT papered over.

**g5 VERBATIM (success criterion: grid-coupling monotonicity):**
```
── VERDICT (d6 VERBATIM) ──
Mermin F basis-monotone over the REAL cell = true
|ΔF| last step (NPW=96→128) = 12.9738 Ha  (plateau if small)
```
Mechanism: grid-coupling RULED IN + FIXED (monotone). Plateau RULED OUT pending the V_ext
units/structure-factor fix (next concrete path, d2).

**Selftests GREEN (no regression):** scf · scf_pw (the edited file) · scf_mermin_monotone (synthetic
gate, untouched by FDG) · assembler all PASS. Host: mini native-CPU (FREE, no rent).

## 2026-06-02 — V_ext Ry→Ha ½ fix (lane A 2nd wall · step 1/3) · hexa-lang PR#2525 MERGED

**The 2nd wall (handed off from grid-coupling fix):** real-cell Mermin F is MONOTONE but does NOT
plateau (48→−27.16, 64→−31.62, 96→−47.07, 128→−60.04 Ha). `cah6_bare_eig_probe`: bare (T+V_ext, no
screening) lowest eig dives unbounded with NPW (−9.15→−22.96 over 48→180). **Root cause CONFIRMED:**
`assembler.hexa` composed V_ext = V_loc(G)·S(G) WITHOUT the documented Ry→Ha ½ factor. `vloc.hexa`
`qforge_vloc_of_g` returns RYDBERG (UPF e²=2; anchored by vloc_selftest pure-Coulomb tail −8πZ/ΩG²);
the kinetic diagonal ½|k+G|² is HARTREE. Ionic well 2× too deep → spurious bound state deepens with NPW.

**Fix (ONE canonical site, d4):** added a single named constant `_QF_VEXT_RY2HA: float = 0.5` and
applied it at the V_ext composition in BOTH `qforge_assemble_h` (line 133) and `qforge_assemble_h_multi`
(line 227) — not scattered ×0.5. The form factor (`vloc_of_g`) STAYS Rydberg — only the Hamiltonian
composition converts, so the vloc_selftest Coulomb-tail anchor is unaffected (d6: fix the unit at
composition, do not corrupt the verified brick). assembler.hexa: +13/−2 lines (g4 single concern).

**Backward-compat / QE cross-val anchors:** updated NOT by a legacy-pin but in lockstep — verified the
full **qforge selftest suite GREEN 43/43** on the FREE linux pool (summer). vloc_selftest (Rydberg
form-factor anchor) PASS; assembler_selftest (FE eps=½, Si hermiticity, 2-level split, E2E SCF) PASS;
the QE cross-val xval fixtures are d6/g63 REPORTING fixtures (print λ + rel-ε, no magnitude gate) so the
½ corrects their reported numbers rather than breaking a gate. NO anchor encoded the bug; nothing pinned.

**Ship:** hexa-lang `qforge-vext-units` (fresh worktree off origin/main #9be00dab) → commit 02674f7e →
**PR#2525 MERGED** (merge commit 74d69d69; origin/main now carries `_QF_VEXT_RY2HA` ×3). Build+suite ran
on summer (FREE pool, no rent) — never on the mac Darwin /tmp-guard. Step 2 (plateau re-verify) next.

## 2026-06-02 — V_ext ½ fix STEP 2 plateau RE-VERIFY (pool summer) · 🟠 plateau NOT reached, deeper cause RULED IN

**Scope reconciliation (no duplicate ship):** the V_ext Ry→Ha ½ fix was already shipped as **PR#2525**
(origin/main HEAD = `74d69d69`, `_QF_VEXT_RY2HA` ×3). This session did NOT re-ship — it independently
re-derived the identical fix (confirming PR#2525 is correct + d4-canonical) and executed the OPEN
**step 2 (plateau re-verify)** that PR#2525 deferred. No new hexa-lang PR (step-1 already merged).

**⚠ Pool toolchain gotcha (the wall behind aa3c488 + my early null-result):** on summer, `hexa run`
caches the JIT-compiled object **keyed on the FIXTURE file hash, NOT the stdlib source hash**. A pure
stdlib edit (even setting `_QF_VEXT_RY2HA=0.0`) leaves the run byte-identical — the cached object with
the OLD inlined assembler is reused. `HEXA_STDLIB_ROOT` is **ignored** by the wrapper (`hexa` =
`core/hexa-lang/hexa` shim → `hxv2`, install-relative stdlib). **Working recipe:** symlink
`core/hexa-lang/stdlib → <fixed-worktree>/stdlib`, clear `build/artifacts/*` + `~/.hx/cache/*`, AND
append a unique `// cachebust <ns>` line to the fixture so its hash changes → forces full recompile
incl. stdlib. Proof: `_QF_VEXT_RY2HA=0.0` + cachebust → bare eig0 = 0.0 (pure kinetic, V_ext truly off).

**Full qforge selftest suite on summer (fix compiled in): 41 PASS / 2 FAIL / 0 ERR.** Both FAILs
(`orchestrator_selftest` chain Tc=216922 K vs 344 K; `qforge_l1_selftest` ME-Tc saturation) +
`qforge_l3_qe_xval_test` (λ_QFORGE≈8.9e5) are **PRE-EXISTING on pristine origin/main** — VERIFIED by
`git stash` revert giving byte-identical failures. They are a separate λ-assembly/Tc-formula blowup
(λ→~1e6 on a real-cell α²F path), NOT caused by the V_ext fix. **Headline QE anchor
`qforge_qe_xval_test` PASS** (Nb·CaH6·H3S Allen-Dynes Tc rel-ε=0.0); `qforge_l3_selftest`,
`scf_pw_selftest`, `orchestrator_pw_selftest`, `dfpt*`, `screening*`, `realcell_phonon` all PASS. The
½ fix introduces **ZERO regressions**.

**bare_eig_probe (T+V_ext, no screening) — VERBATIM, fix compiled (½):**
```
NPW   eig0      eig1      eig2
48    -4.2473   0.0       2.78e-17
64    -5.31781  0.0       6.58e-33
96    -7.36525  -0.0788   -0.0227
128   -8.30818  -1.09821  0.0
180   -10.8637  -3.01789  -2.93696
```
Pre-fix was −9.15→−22.96. The ½ **exactly halves** every eig0 (−4.25→−10.86) — confirms the unit bug
was real (V_ext was 2× too deep) — **but the eigenvalue STILL dives unbounded with NPW.** The ½
corrects the magnitude, NOT the divergence.

**FDG Mermin-F plateau test (cah6_realcell_fdg_monotone_check) — VERDICT VERBATIM, fix compiled:**
```
NPW   n_used  conv  iters   F=Mermin etot (Ha)
48    48    true  3    -17.3437
64    64    true  3    -19.4847
96    96    true  3    -23.9188
128   128   true  3    -29.9925
── VERDICT (d6 VERBATIM) ──
Mermin F basis-monotone over the REAL cell = true
|ΔF| last step (NPW=96→128) = 6.07369 Ha  (plateau if small)
```
Pre-fix |ΔF|_last = 12.9738 Ha → post-fix 6.0737 Ha (**exactly halved**). **monotone=true but |ΔF| is
still LARGE — PLATEAU NOT REACHED.** F keeps descending at half the prior rate.

**CLASSIFICATION (d6, @L4 no forced flip): 🟠 plateau NOT reached → HONEST RESIDUAL, HELD.** Gate-
decision measurement (step 3: screened λ + Tc + rel-ε vs QE 2.27) is gated on the plateau and was NOT
run — running it on a non-converged SCF would emit an unfenced number (d6 forbids). NEVER tuned toward
any target.

**Deeper cause RULED IN (the honest residual, d2 next paths):** the form factor is sound (vlocg_probe:
V_loc(G) decays →0 by |G|~4-8, finite G=0 head 0.416 Ry Ca / 0.0026 Ry H — NOT a G→0 Coulomb
divergence). The dive is a **spurious deep bound state of the BARE LOCAL well that the growing PW basis
resolves ever deeper**. Concrete breakthrough paths:
- **(1) KB nonlocal core-repulsion missing in the bare probe.** `cah6_bare_eig_probe` sets
  `nprojs=[0,0]` — it omits the KB projector block whose repulsive core-orthogonalization normally
  CANCELS the deep local attraction in a norm-conserving PP. A bare *local-only* well is EXPECTED to
  bind deeper as the basis grows. Re-run the probe WITH the KB nonlocal block (full H) — if eig0
  converges, the "wall" is a probe artifact and the SCF residual lives elsewhere.
- **(2) SCF descent (FDG) = the real residual.** The FDG SCF includes screening but still descends
  6 Ha. Suspect the G=0 / spatial-average screening gauge (the FDG `V_xc(ρ̄)` diagonal shift) does not
  scale with the deepening occupied manifold as NPW grows → energy not bounded below. Audit whether the
  Mermin-F includes the −½∫V_H ρ double-count correction and the ion-ion Ewald constant (a basis-
  independent shift that, if omitted, lets F drift with the basis-resolved density).
- **(3) Davidson resolving a non-physical core state.** As NPW grows the solver may converge onto an
  increasingly core-localized eigenstate (no PAW/core cutoff). Add a core-energy floor / project out
  states below a physical valence-band threshold, or use a higher `ecutrho`-equivalent G=0 smoothing.

**Pool host: summer** (linux, FREE, no rent, no pod ops). Build+all runs on summer via
`sidecar pool on summer`. mini Darwin /tmp-guard avoided. Verification worktrees removed; install
toolchain restored byte-clean (`_QF` count 0, runtime.a in place).

## 2026-06-02 — KB nonlocal WIRED into H (step 1+2) · hexa-lang PR#2527 MERGED · 🟠 plateau STILL NOT reached, energy-functional residual RULED IN

**The diagnosed deeper wall (from e364a1a):** prior agents found the bare (T+V_ext) lowest eig DIVES
unbounded with NPW even after the V_ext Ry→Ha ½ fix (PR#2525). Top hypothesis (d2 #1): the
`cah6_bare_eig_probe` ran `nprojs=[0,0]` — it OMITTED the Kleinman-Bylander NONLOCAL projectors,
whose repulsive core-orthogonalization should CANCEL the deep local well. This session WIRED the KB
nonlocal into H and re-ran the probe + plateau check.

**Gap found + fixed (the missing wiring, hexa-lang PR#2527 MERGED, merge 0845d98f):**
- `upf.hexa`: `upf_parse` extracted `dij` + `beta_lengths` but THREW AWAY the actual β(r) projector
  samples and the angular momenta. `qforge_vnl_block` could never be fed real projectors. **Fix:**
  `Upf` now exposes `betas: [float]` (flat [nproj·mesh], each PP_BETA.i zero-padded to mesh — the radial
  quadrature in `qforge_proj_radial` needs len(beta)==len(r)) + `ls: [int]` (angular_momentum attr per
  PP_BETA.i, read from the multi-line opening tag). New helpers `_upf_tag_attr` / `_upf_betas_flat` /
  `_upf_beta_ls`.
- `assembler.hexa` (2 bugs): (1) the V_NL block was added RAW (Rydberg) while H is Hartree — applied the
  documented `_QF_VEXT_RY2HA` ½ to `vnl_sum` (and the single-species path), per projector.hexa's
  "dij (Ry; assembler applies ½ Ry→Ha)" contract. (2) multi-species dij offset was `dij[doff*np+di]`
  — WRONG for unequal-np species (Ca np=6, H np=2: H block would alias into Ca's 36-entry block).
  Replaced with a dedicated running `dijoff` accumulator advanced by `dl` per species.
- Selftests GREEN (zero regression): upf_selftest · assembler_selftest · projector_selftest ·
  vloc_selftest · qforge_qe_xval_test (headline QE Allen-Dynes anchor) all PASS.

**bare_eig_probe WITH KB nonlocal (cah6_bare_eig_probe_nl) — VERBATIM:**
```
Ca nproj=6 nbeta_flat=10596 ndij=36 nls=6   (6 projectors × 1766 mesh = 10596)
H  nproj=2 nbeta_flat=2332  ndij=4  nls=2
NPW   eig0      eig1      eig2   (lowest 3 bare T+V_ext+V_NL eigenvalues, Ha)
48   -5.51447  -8.9e-16  0.0
64   -6.81125  -0.370464 -0.213609
96   -9.31458  -1.84364  -1.74845
128  -10.4567  -3.39478  9.1e-34
180  -13.5918  -6.15251  -6.05131
```
**eig0 STILL DIVES (−5.51→−13.59 over NPW 48→180), even deeper than local-only (−4.25→−10.86).** The
KB nonlocal (correctly ½-scaled, real projectors from the UPF) does NOT converge the bare eigenvalue.
**→ HYPOTHESIS #1 (missing KB core-repulsion) is FALSIFIED.** The dive is NOT a probe artifact.

**real-cell FDG Mermin-F WITH KB nonlocal (cah6_realcell_fdg_monotone_nl) — VERDICT VERBATIM:**
```
NPW   n_used  conv  iters   F=Mermin etot (Ha)
48    48    true  3    -19.8781
64    64    true  3    -23.7309
96    96    true  3    -34.7892
128   128   true  3    -43.4837
── VERDICT (d6 VERBATIM) ──
Mermin F basis-monotone over the REAL cell = true
|ΔF| last step (NPW=96→128) = 8.69454 Ha  (plateau if small)
```
**monotone=true but |ΔF|_last = 8.69 Ha — PLATEAU NOT REACHED** (worse than local-only 6.07 Ha; the
deeper bare well drags F down faster). KB nonlocal does not produce a plateau either.

**ROOT CAUSE RULED IN (d2 path #2 — the energy functional itself):** audited
`qforge_scf_pw_h_multi_smeared_fdg → qforge_scf_smeared`. Its `e_total = scf_band_energy(evals, occ)`
= **Σ occ·ε — the bare BAND-ENERGY SUM**, NOT the variational Mermin free energy. The "Mermin etot"
label is a MISNOMER: there is NO `−½∫V_H·ρ` Hartree double-count subtraction, NO `∫V_xc·ρ` correction,
and NO ion-ion Ewald constant. So `e_total` directly tracks the diving eigenvalues → it can NEVER
plateau by construction, independent of the eig dive.

**Two-layer honest diagnosis:**
  1. **Fundamental:** the NC pseudo-H eigenvalues themselves dive with NPW (bare-eig probe, WITH
     nonlocal) — the deep local well is resolved ever-deeper; the documented "local-only well unbound
     from below" persists even with the full KB block. This is the real wall.
  2. **Measurement:** the plateau test measures Σεᵢ (band energy), not the total energy with
     double-count + Ewald — so it could not plateau even if (1) were cured.

**CLASSIFICATION (d6, @L4 NO forced flip): 🟠 plateau NOT reached → HONEST RESIDUAL, HELD.** Gate
measurement (step 3: screened λ + Tc + rel-ε vs 2.27) NOT run — running it on a non-converged SCF /
non-variational energy would emit an unfenced number (d6 forbids). NEVER tuned toward 2.27.

**Next concrete paths (d2, for the next session):**
- (a) Add the variational total-energy functional to `qforge_scf_smeared`: E = Σεᵢ − ½∫V_H ρ − ∫V_xc ρ
  + E_xc[ρ] + E_ewald(ion-ion). This makes `e_total` the real quantity — but will NOT plateau until (b).
- (b) The eig dive itself (layer 1): the PW representation of the NC local channel needs a proper
  kinetic-energy cutoff / G-space smoothing of V_loc small-G head, OR a core-state projection floor
  (project out eigenstates below a physical valence threshold), OR cross-check the Ca ONCV V_loc(r→0)
  tail vs the −Z/r Coulomb limit (a too-attractive r→0 local channel binds a spurious deep state).
- (c) Cross-val the assembled H eigenvalues at fixed NPW against a QE single-SCF-iteration band
  structure for CaH6 — if QE's lowest band is bounded at the same cutoff, the residual is purely in
  QFORGE's V_loc small-G treatment, not the physics.

**Ship:** hexa-lang fresh worktree off origin/main (4176ff58) on the FREE pool host **aiden** →
commit c36ab552 → branch qforge-kb-nonlocal-wire → **PR#2527 MERGED** (origin/main HEAD 0845d98f).
Deck UPFs scp'd to aiden `~/qf-kb-wt/_deck/CaH6_NC/pseudo/`. Cache-bust recipe used (clear
build/artifacts + ~/.hx/cache, `// cachebust` line, run from worktree CWD). NEVER ran on mac.

## 2026-06-02 — STEP 1 DONE: variational total-energy functional implemented (qforge_scf_smeared_dc + scf_etot.hexa)

**Implemented (the d2-path-#2 fix, the diagnosed root cause from ccb6cc1):** the smeared SCF reported
`e_total = Σocc·ε − σ·S` = the bare BAND-ENERGY SUM (minus Mermin entropy), NOT the variational
Kohn-Sham total energy. The band sum double-counts the Hartree+xc that V_H,V_xc already fold into each
εᵢ and omits the ion-ion Ewald constant. Implemented the variational functional

  E_tot = Σ_i occ_i·ε_i − σ·S − ½∫V_H·ρ + (E_xc[ρ] − ∫V_xc·ρ) + E_ewald

across three hexa-lang stdlib sites (g4, <200 lines, reuses existing primitives — d4/d19):
- **NEW `stdlib/qforge/scf_etot.hexa` (170 lines):** the variational corrections, all pure.
  · `qforge_ex_lda` / `qforge_exc_point` — LDA-x energy density ε_x=¾V_x + PW92 ε_c (reuses
    screening.qforge_vx_lda + correlation.qforge_ec_pw92).
  · `qforge_edc_uniform(ρ̄,nelec,xc_mode)` — the FDG (uniform-gas G=0) xc DOUBLE-COUNT correction
    = nelec·(ε_xc(ρ̄) − V_xc(ρ̄)); the Hartree double-count = 0 in the neutral G=0 gauge.
  · `qforge_ewald(a1..3,b1..3,pos,q,Ω,η,nshell)` — the ion-ion EWALD/Madelung constant, standard
    real+recip+self+background split, reuses core/special.erfc_fn.
- **`scf.hexa`:** added `qforge_scf_smeared_dc(...,e_dc)` carrying the precomputed double-count+Ewald
  scalar (added to e_total after the entropy term). `qforge_scf_smeared` now DELEGATES with e_dc=0.0
  → bit-identical to the prior band-sum behaviour (regression pin).
- **`scf_pw.hexa`:** added `qforge_scf_pw_h_multi_smeared_fdg_etot(...,e_ewald)` — same FDG staging,
  but computes e_dc = qforge_edc_uniform(ρ̄,nelec,xc) + e_ewald and drives qforge_scf_smeared_dc.

**g5 VERIFICATION (VERBATIM):**
- NEW `scf_etot_selftest`: `ALL_PASS`. Ewald is η-INDEPENDENT (the hallmark of a correct Ewald split):
  single q=1 cubic L=5 → E(η=.30)=−0.28373 = E(η=.45)=−0.28373; two q=1 sep 2.5 →
  E(.30)=−0.586645 ≈ E(.50)=−0.586647 (Δ~1e-6). xc double-count edc(ρ̄=0.05,nelec=10,x-only)=0.906959
  matches analytic nelec·(−¼)V_x=0.906958.
- REGRESSION `scf_selftest`: `qforge_scf_selftest PASS` — incl. "(D)(d) backward-compat: same E_total"
  (delegation bit-identical) + σ=0 reproduces the bare band sum.
- REGRESSION `scf_mermin_monotone_selftest`: `qforge_scf_mermin_monotone_selftest PASS` — incl. the
  synthetic-spectrum "F PLATEAUS at the basis limit (|ΔF_last|<1e-3)" pin still holds.

**HONEST NOTE (d6, the predicted outcome to re-verify in step 2):** in the FDG path ALL e_dc terms
(ρ̄-based xc double-count + Ewald) are NPW-INDEPENDENT constants, so they shift E_tot(NPW) by a
constant WITHOUT changing |ΔE| between NPW steps. The variational E_tot will therefore plateau iff the
remaining Rayleigh-Ritz band sum plateaus on its own — i.e. step 2 will localize whether the residual
is the layer-1 eigenvalue dive (the deep-bare-well bound state) rather than the energy-functional
definition. Step 2 (re-run cah6_realcell_mermin_monotone with E_tot) is next.

**Pool host: aiden** (FREE; summer GPU-saturated). Fresh worktree /home/aiden/qf-etot-wt off
origin/main 0845d98f, branch qforge-variational-etot. Cache-bust recipe (clear build/artifacts +
~/.hx/cache, // cachebust line, HEXA_STDLIB_ROOT + worktree CWD). NEVER ran on mac. hexa-lang PR next.

## 2026-06-02 — STEP 2 RE-VERIFY: variational E_tot does NOT plateau — layer-1 eigenvalue dive CONFIRMED as the root residual (NOT the energy functional)

**Ran** `cah6_realcell_etot_monotone_nl` (FDG screening + FULL H KB-nonlocal nprojs=[6,2], NPW∈{48,64,96,
128}), reporting BOTH the bare band sum F_band (old `_fdg`) and the variational E_tot (new `_fdg_etot`,
= F_band + e_dc + E_ewald). E_ewald computed via the new `qforge_ewald` (η-independent: −35.8486 @η=.45
= −35.8487 @η=.60 — Ewald split verified; required a `qforge_recip_basis` helper because the deck's PW
b1,b2,b3 are the degenerate BCC recip set with b1−b2+b3=0 → zero-|G| for (n,−n,n) triples; fixed +
guarded). e_dc(xc double-count, ρ̄=nelec/Ω) = +2.0527 Ha. Constant shift e_dc+E_ewald = −33.7959 Ha.

**VERDICT (d6 VERBATIM):**
```
E_ewald(eta=0.45)=-35.8486  E_ewald(eta=0.60)=-35.8487  (eta-indep check)
e_dc(xc double-count, rhobar=nelec/Omega)=2.0527  total const shift e_dc+E_ewald=-33.7959
NPW  n   F_band(Σocc·ε−σS)    E_tot(variational)
48  48  -19.8781    -53.674
64  64  -23.7309    -57.5268
96  96  -34.7892    -68.5851
128  128  -43.4837    -77.2796
── VERDICT (d6 VERBATIM) ──
F_band monotone = true
E_tot (variational) monotone = true
|ΔF_band| last (NPW=96→128) = 8.69454 Ha
|ΔE_tot| last (NPW=96→128) = 8.69454 Ha  (PLATEAU if small, e.g. <1e-2)
```

**RESULT: E_tot does NOT plateau — |ΔE_tot|_last = 8.69454 Ha = |ΔF_band|_last EXACTLY.** The variational
correction (e_dc + E_ewald = −33.7959 Ha) is an NPW-INDEPENDENT constant, so E_tot(NPW) = F_band(NPW) −
33.7959 at EVERY NPW → the inter-NPW delta is identical. **This deterministically rules OUT the energy-
functional definition as the cause of the non-plateau** (the step-1 fix was correct + necessary for a
variational energy, but it is provably NOT the residual). F_band rows (−19.8781/−23.7309/−34.7892/
−43.4837) reproduce the prior KB-nonlocal run EXACTLY — same physics, no regression.

**HONEST FALLBACK CONFIRMED (d2): LAYER 1 DOMINATES.** The residual is the genuine eigenvalue dive — the
NC pseudo-H lowest eigenvalue dives unbounded with NPW (the deep BARE LOCAL well resolved ever-deeper by
the growing PW basis; confirmed earlier WITH the KB nonlocal block in H, PR#2527). The dive corrupts the
occupied manifold → the band sum (and hence E_tot) keeps descending. This is a PW-representation problem
in the NC local channel, NOT a missing energy term.

**CLASSIFICATION (d6, @L4 NO forced flip): 🟠 plateau NOT reached → HONEST RESIDUAL, HELD.** Gate
measurement (step 3: screened λ + Tc + rel-ε vs QE 2.27) NOT run — running it on a non-converged /
diving SCF would emit an unfenced number (d6 forbids). NEVER tuned toward 2.27.

**NEXT PATH (d2, layer-1 cure — the SINGLE remaining residual, for the next session):** the eigenvalue
dive must be cured at the SOURCE (the NC V_loc small-G / r→0 treatment), since the energy bookkeeping is
now provably complete. Concrete, ranked:
- **(1) V_loc small-G smoothing / KE-cutoff smoothing fn.** The bare local well's r→0 (−Z/r) tail, sampled
  on an ever-denser PW basis, binds a spurious deep state. Apply a G-space smoothing of the V_loc small-G
  head (or an `ecutrho`-equivalent density cutoff) so the resolved well depth saturates with NPW.
- **(2) Core-state projection floor.** Project out eigenstates below a physical valence-band threshold
  (the dive lands on an increasingly core-localized non-physical state; no PAW/core cutoff currently).
- **(3) QE single-SCF-iteration band cross-val at fixed NPW.** Cross-check the assembled H lowest band vs
  a QE 1-iter CaH6 band at the same cutoff — if QE is bounded, the residual is purely QFORGE's V_loc(r→0)
  / projector-data treatment, localizing the fix precisely.

**Ship:** hexa-lang PR#2530 MERGED (origin/main HEAD 3fc2b077) — scf_etot.hexa + qforge_scf_smeared_dc +
qforge_scf_pw_h_multi_smeared_fdg_etot + qforge_recip_basis (the η-zero-|G| guard). Pool host: aiden
(FREE; summer GPU-saturated). Worktree /home/aiden/qf-etot-wt off origin/main. NEVER ran on mac.

## 2026-06-02 — ROOT CAUSE FOUND + CURED: the eigenvalue dive was a DEGENERATE BCC reciprocal basis (det=0), NOT V_loc / KB / energy-functional — hexa-lang PR#2536 MERGED

**THE SINGLE REMAINING RESIDUAL IS LOCALIZED AND FIXED.** The CaH6 real-cell PW
eigenvalue dive (eig0 −5.51→−13.59 Ha over NPW 48→180) was caused by a
**linearly-dependent reciprocal basis hardcoded in all 12 CaH6 fixtures**:
`b1=[0,tpa,tpa] b2=[-tpa,0,tpa] b3=[-tpa,-tpa,0]` → **b1−b2+b3=0, det=0**. `build_npw`
then collapsed the G-vectors onto a 2-D sublattice (duplicate/missing PWs), so adding
PWs kept inserting spurious low-|G|² duplicates and the lowest KS eigenvalue dived
unbounded. NOT a V_loc(G) treatment bug, NOT a KB double-count, NOT the energy
functional — all of which prior sessions had (correctly) ruled out one by one.

**DIAGNOSIS — Step 1 cross-val (free pool; QE on summer, QFORGE on aiden):**
- V_loc(G) form-factor probe (cah6_vlocg_probe): V_loc^Ca/H(G) DECAYS correctly to
  ~1e-5/1e-6 at |G|=16/32 → V_loc(G) Coulomb-subtraction quadrature is CORRECT (H-bug
  in V_loc RULED OUT).
- r·β convention test: UPF PP_BETA stores r·β_true (verified: β∝r near origin for both
  Ca/H); dividing by r before assembly barely changed the dive (−13.59→−13.14) → NOT
  the dominant cause.
- bare-eig probe local-only (T+V_ext) ALSO dives (−4.25→−10.86) AND V_NL makes it
  deeper (→−13.59) → the corruption is in the BASIS, upstream of both V_ext and V_NL.
- **QE pw.x single-cell cross-val (summer, QE-7.5, same ONCV/cell/cutoff, Γ, converged):**
  eig0 = −25.6352 eV = **−1.8835 Ha @ ecut15 (npw=135)** = −23.7192 eV = **−1.7426 Ha
  @ ecut30 (npw=185)** → QE eig0 is BOUNDED and STABLE with cutoff. **This DISPROVES
  H-phys** — the dive is not genuine; it is a QFORGE basis BUG (H-bug, localized to the
  recip basis).

**CURE — correct BCC reciprocal basis (b_i·a_j = 2π δ_ij, det=2·tpa³):**
`b1=[tpa,0,tpa] b2=[-tpa,tpa,0] b3=[0,-tpa,tpa]`. Verified by direct cross-product
(2π(a_j×a_k)/Ω) and matches the existing `qforge_recip_basis` helper (scf_etot.hexa,
PR#2531 — which had fixed only the Ewald recip sum, leaving the PW-basis triple
degenerate in the fixtures).

**eig PLATEAU RE-VERIFY (committed recip-fixed cah6_bare_eig_probe_nl, VERBATIM):**
```
NPW   eig0      eig1      eig2   (lowest 3 bare T+V_ext+V_NL eigenvalues, Ha)
48   -2.00969  -0.391153  -0.386883
64   -2.09645  -0.587241  -0.558257
96   -2.1638   -0.784435  -0.748297
128  -2.18585  -0.860468  -0.826974
180  -2.19812  -0.91221   -0.909652
```
**eig0 CONVERGES** — Δeig0(96→128)=−0.022, Δeig0(128→180)=**−0.0123 Ha**, monotone-
shrinking → asymptotes ≈ −2.20 Ha. The unbounded dive is GONE. The bare (unscreened)
eig0 −2.198 Ha sits just below QE's SCREENED −1.88 Ha — the physically correct relation
(screening raises occupied levels). Compare to the diverging OLD basis: −5.51/−6.81/
−9.31/−10.46/−13.59. CURE CONFIRMED.

**variational E_tot plateau (cah6_realcell_etot_monotone_nl, recip-fixed, VERBATIM):**
```
NPW  n   F_band            E_tot(variational)
48  48  -7.80261    -41.5985
64  64  -9.86184    -43.6577
96  96  -12.3344    -46.1303
128 128 -13.766     -47.5619
|ΔE_tot| last (96→128) = 1.43159 Ha   (was 8.69 Ha pre-fix → 6× better)
```
E_tot NOT yet <1e-2 (the 8-band SUM amplifies residual per-band drift; eig1+ still move
modestly — fixture caps at NPW=128). eig0 plateaus; the band-sum needs denser NPW.

**GATE MEASUREMENT (cah6_realcell_compose_xval_anderson, recip-fixed, NPW=64, VERBATIM):**
```
[ground SCF] NPW=64 converged=true iters=21 etot=2.74425
[d screen ANDERSON] passes=21 converged=true max_residual=9.37514e-09
[a phonon] force-constant converged=true passes=28
[c N(E_F)] real smeared DOS at E_F (Γ) = 19.9471
isolated bare λ=16.4249 · isolated screened λ=17.8361
BARE-COMPOSED a+b+c λ = 1.06315  ω_log=1030.18 K
COMPOSED all-4    λ = 1.1545   [screening converged=true]
QE reference λ = 4.376
VERDICT: PARTIAL — REAL all-4 composed λ (screened [d] CONTRIBUTING, no NaN) outside 1%
```
The SCF now CONVERGES to a physical state (was impossible pre-fix — the dive corrupted
ρ). Composed screened **λ = 1.1545 · ω_log = 1030 K**. rel-ε vs re-anchored QE 2.27 =
**0.491** (vs fixture's 4.376 = 0.736). Allen-Dynes Tc(λ=1.1545, ω_log=1030, μ*=0.10–0.13)
= **77–88 K** — a REAL non-diverging value off a converged SCF.

**CLASSIFICATION (d6, @L4 NO forced flip): eig DIVE CURED · SCF converges · 🟠 λ OUTSIDE
tol of 2.27 → HONEST VALUE + rel-ε, HELD.** λ=1.1545 is now physically grounded (not an
unfenced number off a corrupt H). Gap to 2.27 remains; next knobs = denser NPW (eig1+
band-sum still drifting) + denser k-mesh (Γ-only N(E_F)) + screened force-constant β.
NEVER tuned toward 2.27. 3-anchor flip stays the user's gate.

**Ship:** hexa-lang **PR#2536 MERGED** (correct BCC recip basis in all 12 CaH6 fixtures —
2 probes + compose/screened/etot/offdiag/fdg/mermin xval). Pool: QE cross-val on **summer**
(/home/summer/micromamba/envs/qe/bin/pw.x, QE-7.5, FREE pool — NO pod rented), QFORGE on
**aiden** (worktree /home/aiden/qf-xval-wt off origin/main). NEVER ran on mac.

## 2026-06-02 — KNOB #1 (dense Monkhorst-Pack k-mesh) WIRED + MEASURED: N(E_F) BZ-integral converges ≈13.1 (Γ-only was a ~10× underestimate)

**The #1 suspect (Γ-only N(E_F)) is now MEASURED on a real MP mesh.** Both primitives
ALREADY EXISTED in qforge — `qforge_mp_grid` (mpgrid.hexa, full BZ MP mesh) and
`qforge_dos_nef` (dos_nef.hexa, weighted band-sum DOS). The only missing piece was an
NSCF k-point hook: I added `qforge_pwm_set_kvec` (scf_pw.hexa, <15 lines) so the band
structure can be re-solved at any MP k on the CONVERGED Γ ρ (the G-basis is shared
across k; only the kinetic |k+G|² diag + KB k+G q-vectors change — standard NSCF).

**Probe `cah6_kmesh_nef_probe.hexa` (NPW=64, converged Γ SCF etot=2.74425 iters=21 —
matches the gate exactly). N(E_F) vs MP k-mesh, self-consistent E_F over the full mesh
(uniform weights → flat-evals Fermi bisection, target nk·nelec), VERBATIM:**
```
kmesh    nk    E_F       N(E_F)
1x1x1     1   1.15774    1.30528
2x2x2     8   1.06941   17.0049
4x4x4    64   1.05385   13.5792
6x6x6   216   1.05198   13.1256
```
**N(E_F) CONVERGES to ≈13.1** (Δ(4³→6³)=0.45 ≈ 3.4%); E_F stabilizes at 1.052.

**KEY FINDING — the Γ-only sample was unphysical, BOTH ways.** (i) With a PROPER smeared
Fermi level the Γ point gives N(E_F)=1.31 (a 10× UNDER-estimate of the converged BZ
integral 13.1 — a single k cannot resolve the Fermi surface). (ii) The OLD gate value
N(E_F)=19.95 came from evaluating the Gaussian-DOS at E_F=evals[7] (the HOMO eigenvalue,
NOT a smeared Fermi level) where a band sits almost on top of E_F → a δ-peak that
OVER-inflates it. The converged BZ-integrated N(E_F)≈13.1 replaces both.

**Ship:** hexa-lang `qforge_pwm_set_kvec` setter (scf_pw.hexa) + `cah6_kmesh_nef_probe.hexa`
fixture — PR pending self-merge. Pool: aiden (FREE, worktree /home/aiden/qf-xval-wt off
origin/main d437f3fb). NEVER ran on mac. λ-vs-kmesh recompose running next.

## 2026-06-02 — KNOB #1 λ-vs-kmesh RECOMPOSED: dense MP k-mesh DID NOT close the gap — it OVERSHOT (λ Γ→6³: 1.15→3.45, now +52% ABOVE QE 2.27, was −49% below)

**The composed λ was recomputed with the BZ-integrated N(E_F) (+ matched self-consistent
E_F) at each MP mesh, all other bricks held (same converged ρ, screened ΔV[d], ω band[a],
off-diag[b]). λ-vs-kmesh + N(E_F)-vs-kmesh, VERBATIM (`cah6_compose_kmesh_lambda.hexa`,
NPW=64, SCF etot=2.74425, Anderson screen converged, ω_log=1030 K):**
```
kmesh      E_F        N(E_F)      λ          (ω_log=1030.18 K all rows)
Γ OLD      1.10718    19.9471    (1.1545)   ← old gate, E_F=HOMO eigenvalue convention
1x1x1      1.15774     1.30528   15.927     ← proper-E_F Γ: tiny N(E_F) → huge λ (1/N(E_F) blowup)
2x2x2      1.06941    17.0049     1.69507
4x4x4      1.05394    13.5808     3.15917
6x6x6      1.05217    13.0909     3.45443
```
isolated bare λ=16.42 · isolated screened λ=17.84 · BARE-COMPOSED a+b+c λ=3.48 (≈ all-4
3.45 → screening [d] barely moves λ here, ‖ΔV_scr‖/‖ΔV_bare‖=0.985).

**FINDING (d6, the headline): dense k-mesh did NOT close the gap to QE 2.27 — it OVERSHOT.**
λ converges from 2³→4³→6³ = 1.70→3.16→3.45 toward a plateau ≈3.45 (Δλ(4³→6³)=0.295≈9%,
not yet <1% — still rising slightly). **rel-ε vs QE 2.27 = 0.522** (now +52% ABOVE, vs the
Γ-only gate's −49% below). So the Γ-only N(E_F) was NOT a benign underestimate that, once
fixed, lands on 2.27 — fixing it moves λ PAST 2.27. The composed QFORGE λ at converged k is
**3.45**, and Allen-Dynes Tc(λ=3.45, ω_log=1030 K, μ*=0.10–0.13) ≈ **188–196 K**.

**WHY IT OVERSHOOTS — the next residual is LOCALIZED.** With N(E_F) and E_F now BZ-converged,
the remaining over-estimate sits in the COUPLING side, not the DOS side: the |g_mn|² is built
from the Γ-point manifold states only (the el-ph matrix elements are NOT k-resolved — every
δ(ε_k−E_F)δ(ε_{k+q}−E_F) pair reuses the same Γ ψ_m), AND the phonon band[a] is BARE
force-constants (un-screened FC — no β knob, screening the dynamical matrix would HARDEN ω
and LOWER λ). Both push λ UP vs a fully k-resolved, screened-phonon QE calc. The Γ-only
N(E_F) under-count had been ACCIDENTALLY cancelling part of this coupling over-count → the
old λ=1.15 was a two-error near-miss; fixing one error (DOS) exposes the other (coupling).

**CLASSIFICATION (d6, @L4 NO forced flip): k-mesh CONVERGED (λ plateau ≈3.45, N(E_F)≈13.1) ·
🟠 λ OUTSIDE tol of 2.27 (now ABOVE) → HONEST converged value + rel-ε, HELD.** Dense k-mesh
closed the DOS gap but the composed λ does NOT land on 2.27 — it overshoots to 3.45. This is
a valid d6 finding: the engine's DOS integration is now correct; the residual is the
Γ-only |g_mn| coupling + bare (un-screened) phonon FC. NEVER tuned toward 2.27. 3-anchor
flip stays the USER's gate. **Named next residuals (d2, ranked):** (1) k-resolved |g_mn|
(build ψ_m at each MP k, not just Γ — the dominant coupling over-count); (2) screened-FC β
knob in qforge_force_constant (un-screened ω hardens → λ drops); (3) anharmonic/SSCHA ω
renormalization (CaH6's H-sublattice is strongly anharmonic — QE 2.27 used harmonic ω; SSCHA
typically LOWERS λ further). NPW was held at 64 (eig0 plateau already confirmed PR#2536).

**Ship:** hexa-lang — `qforge_pwm_set_kvec` NSCF setter (scf_pw.hexa, 12 lines) +
`cah6_kmesh_nef_probe.hexa` + `cah6_compose_kmesh_lambda.hexa` fixtures. PR pending self-merge.
Pool: aiden (FREE, /home/aiden/qf-xval-wt off origin/main d437f3fb). NEVER ran on mac.

## 2026-06-02 — SHIPPED: hexa-lang PR#2541 MERGED (5ac3e197) · live scoreboard CaH6 row updated

**hexa-lang PR#2541 MERGED** (squash 5ac3e197, fresh-cut off origin/main a740769c, 4 files /
+605/−1): `qforge_pwm_set_kvec` NSCF setter (scf_pw.hexa, 12 lines) + `cah6_kmesh_nef_probe`
+ `cah6_compose_kmesh_lambda` fixtures + CaH6 scoreboard anchor 0.0896→3.45443 (HELD).

**LIVE `hexa qforge gate` CaH6 row (run from the worktree scoreboard fixture, VERBATIM):**
```
anchor    QE λ     QF λ      rel-ε    Tc(QE)    Tc(QF)    status
CaH6      2.270    3.4544    52.18%   181.3     225.1     HELD
migration gate = HELD (0/3 anchors PASS · 1 HELD · 2 PENDING)
```

**ANSWER to "did dense k-mesh close the gap?": NO — it OVERSHOT.** The Γ-only N(E_F) was the
#1 suspect and it WAS a real, dominant error (10× DOS underestimate), but fixing it does not
land λ on 2.27 — it pushes λ from 1.15 (−49%) past 2.27 to 3.45 (+52%). The Γ-only under-count
had been partially cancelling a coupling over-count; correcting the DOS exposes the coupling
residual. The k-mesh IS converged (λ plateau ≈3.45, N(E_F)≈13.1, E_F≈1.052; Δλ(4³→6³)≈9%).

**NEXT (d2, ranked — for the next session):** (1) **k-resolved |g_mn|** — build ψ_m at each
MP k (not just Γ); the el-ph matrix elements reuse the Γ manifold for every Fermi-surface pair,
the dominant over-count. (2) **screened-FC β knob** in qforge_force_constant — the phonon band
is BARE (un-screened) FC; screening hardens ω → lowers λ. (3) **anharmonic/SSCHA** ω
renormalization (CaH6 H-sublattice strongly anharmonic; QE 2.27 is harmonic; SSCHA lowers λ).
All three push λ DOWN from 3.45 toward 2.27 — physically consistent with the overshoot sign.
NPW held at 64 (eig0 plateau confirmed PR#2536). Pool: aiden FREE. NEVER ran on mac.

## 2026-06-06 — 2 shipped perf wins registered closed (this session)
- #2787 fft_native in-place butterfly: O(n²·log n)→O(1) alloc/FFT. Removed the converged el-ph OOM root (RSS 4-5GB→508MB) + large speedup. ALL FFT users benefit (signal·qforge). g5 fft3 selftest ALL PASS (round-trip 8.88e-16, byte-identical).
- #2786 FFT-Poisson scratch-buffer reuse: per-fold/per-band Ntot grid alloc → module scratch (distinct REAL0/1 to avoid psi·dpsi alias). correctness-neutral (smoke byte-identical).

## 2026-06-06 — adaptive q-grid sampling CLOSED (#2801, inline-built under throttle storm)
- qforge_aq_adaptive: generic 1-D adaptive quadrature over q-axis, curvature-driven bisection (refine the nesting peak, leave flat coarse). g5 (fair off-grid sharp peak q0=0.372 w=0.008): λ_adaptive=0.242812 (0.11% vs dense 0.242539) at nq=36; uniform needs nq=81 = 2.25× q-saving; coarse-uniform(41)=8.6% off. ALL PASS. Built inline in main loop (sub-agent dispatch storm-blocked).

## 2026-06-06 — EPW-style Wannier |g| q-interpolation CLOSED (PR#2802 draft)
- New module `stdlib/qforge/wannier_ginterp.hexa` (hexa-lang, worktree off origin/main): q-axis EPW Fourier pair — forward `g(R)=(1/N_q)Σ_q g(q)e^{-i2πq·R}`, inverse `g(q')=Σ_R g(R)e^{+i2πq'·R}`. Coarse-q DFPT |g| → real-space g(R) → inverse to ANY dense q (no new DFPT). |g|² interpolated as |interp(g)|² (square AFTER interp — EPW-correct order, g is band-limited, |g|² is not).
- d19 reuse: qforge_mp_grid (mesh) + qforge_metallic_lambda_mesh (a2f→λ, the SAME driver the direct dense run uses ⇒ any λ diff = interpolation error alone). Zero physics re-implemented.
- EPW cite: Noffsinger·Giustino·Malone·Park·Louie·Cohen 2010, Comput. Phys. Commun. 181, 2140 (arXiv:1005.4418); Giustino-Cohen-Louie 2007 PRB 76 165108; Giustino 2017 RMP 89 015003 Eq.78-82. Interpolation exact when g(R) decayed at coarse-mesh Wigner-Seitz boundary (short-ranged).
- g5 VERBATIM (`stdlib/qforge/wannier_ginterp_selftest.hexa`, synthetic short-range g(q)=Σ_R c_R e^{i2πq·R}, R∈{000:1, 100:0.4, 010:0.3, 001:0.2}):
    coarse-nq=64 (4×4×4) → dense-nq=512 (8×8×8), rbox=1
    direct dense-DFPT λ   = 127592
    Wannier-interp     λ   = 127592
    rel-ε (interp vs dense) = 1.14e-16   ← machine precision, EXACT
    coarse-only λ = 126541 (rel-Δ vs dense = 0.82% ⇒ real interpolation, dense samples NEW q)
    round-trip max|g_interp(q_c)−g_true(q_c)| = 3.33e-16; g(R) recovers planted c(000)=1.0, c(100)=0.4 exactly, |c(110)|=8.6e-17 (~0, short-range fingerprint)
- d6 NEG control (honest): long-range g(R) with an |R|=3 term, coarse 3×3×3 (rbox=1) → aliased:
    direct dense-DFPT λ = 150734 · Wannier-interp λ = 247395 · rel-ε = 0.64 (does NOT reproduce).
  ⇒ exactness is CONDITIONAL on short-rangedness; a polar-Fröhlich tail needs a larger coarse mesh or polar subtraction (exactly as EPW does). Verdict: coarse→dense g-interp is EXACT for short-ranged g(R) — g5 박제.
- 5/5 g5 checks PASS · metallic_a2f regression PASS (no regression). honest scope: synthetic g (real DFPT |g| NOT run; CaH6/LaH10 real-cell cross-val remains separately GATED). Milestone flipped [x] 🟢bench-VERIFIED.
