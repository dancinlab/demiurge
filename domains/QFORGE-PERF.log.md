# QFORGE-PERF — append-only step log

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
