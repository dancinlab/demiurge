# Changelog

Chronological log of notable changes. One section per ship batch, date-keyed. Decision gates tracked as `D<N>` in `DESIGN.log.md`; cycle phases as `κ-<N>`.

For the full audit trail, see `git log`.

---

## 2026-06-18

### RTSC 4×4×4 — bzip2 fix 통함(pw.x 설치) + GUARD-2 false-negative 정정 (c2)
- bzip2 보장 fix가 통해 micromamba 2.8.1 + qe env(pw.x·ph.x) **실제 설치 성공**. 단 fail-loud GUARD-2가 `pw.x -h`로 검증 → QE 바이너리엔 `-h` 도움말 플래그가 없어 비-0 종료 → 멀쩡한 설치를 "QE SETUP FAILED"로 오판(false-negative). fix=검증을 `which pw.x`(존재확인·exit0)로 교체 + env create 멱등(이미 있으면 skip). 재실행 → "QE SETUP DONE" 정직 출력 확인. 사이징 발사.

### RTSC 4×4×4 사이징 — 세션-장기 "SCF 무출력" 진짜근본원인 확정 + fail-loud fix (c1·c2)
- 포그라운드 캡처(v2)가 진짜 뿌리를 노출: `pod_setup_qe.sh`가 (1) 포드에 **bzip2 부재**로 micromamba `.tar.bz2`를 `tar -xj` 해제 실패("bzip2: Cannot exec") → micromamba 미설치, (2) 그런데도 `echo "QE SETUP DONE"`을 **무조건 출력**(거짓 성공) → 와처가 DONE 보고 사이징 발사 → pw.x 없음 → scf.out 빈 채. 이것이 summer·vast 가로지른 세션-장기 "SCF 무출력" 미스터리의 단일 근인.
- fix(c1 근본): `ensure_deps`로 bzip2/curl/tar apt 설치 보장(다운로드 전) + 설치 **검증 통과(pw.x 실행)시에만 "QE SETUP DONE", 아니면 "QE SETUP FAILED: <reason>" + exit 1**(거짓-DONE 박멸·fail-loud). 재발방지 원칙(트러블슈팅=도구개선) 일관 — 와처가 이제 거짓 DONE에 헛발사 안 함.

### 트러블슈팅 재발방지 원칙 + hexa cloud·deck 가드 (CLAUDE.md 최상위 박제)
- 유저 지시로 CLAUDE.md **최상위에 원칙 박제**: 트러블슈팅은 손으로 우회하지 말고 그 예방 가드를 `hexa cloud`(포드·클라우드 레이어)·`hexa deck`(입력덱·런스크립트 레이어)에 코드로 박아 재발 0 (self-improving 도구 SSOT; d_deck_always[덱]+이 원칙[cloud] 한 쌍). c17대로 응용층=격리 worktree 직접fix→pr-cycle, 컴파일/런타임 코어=ING 인계.
- 이번 세션 트러블슈팅 2건을 가드로 박제(hexa-lang PR #3547): (1) `hexa cloud rm` 비대화식 [y/N] EOF→조용한 cancel로 포드 생존+과금 누수 → LOUD "still alive+billing, --force 재실행" (2) `hexa deck` rtsc env `conda activate qe` 고정→micromamba 포드 마찰 → conda OR micromamba 자동감지. deck JIT 빌드+emit 검증, cloud 소스(재빌드는 f64 툴체인 대기).

### RTSC LaRu3Si2 4×4×4 사이징 — flaky 포드 교체 + 포그라운드 캡처 (v2)
- vast 41382613이 세션 내내 SCF 무출력(scf.out 빈 채)·flaky 전송으로 진척 0 → `hexa cloud rm --force`로 destroy(과금정지). 근본추정: 자가-detach 사이징(`setup_sizing_vast.sh`)이 빈 sizing.log를 남겨 진짜 에러가 안 보였음.
- 새 포드 vast 41411431(ssh4·≥120G·@demiurge) + **포그라운드 캡처 사이징**(`sizing_fg.sh` — 자가detach 제거, SCF/ph.x를 동기 실행해 출력 직접 캡처) 도입 → 다음 실패 시 진짜 에러 가시화. 체인 모니터 bpduy69ui(QE완료→fg사이징→q-list).

### QFORGE M4 fleet — from-scratch λ 벽 정밀 재분류 (3벽 모두 LOCAL-fixable·포드 불필요)
- 유저 "fleet으로 진행"에 따라 M4(from-scratch 차폐정점 λ 벽 돌파)를 병렬 다중에이전트 fleet(3레인)으로 굴림 → 모두 high-confidence 근본원인 + 안전 해법(결과 박제: `state/qforge-m4-fleet/FLEET_FINDINGS.json`). **핵심 반전(c9 재분류)**: 직전 "고RAM 포드 필요" 추정이 틀림 — 3벽 전부 **무료 로컬 수정** 가능.
  - **(A) 툴체인(#1 블로커)**: 로컬 ~/.hx가 main #3362(hexa_arr_f64_* 선언)보다 21h stale → 모든 hexa 빌드 실패. RT-NATIVE churn 아님(설치본 HEAD 자체가 stale). 해법=**격리 prefix 설치 `HX_HOME=~/.hx-m4`**(공유 ~/.hx 무손상·zero blast). ~/.hx 재동기화 금지(RT-NATIVE 102 dirty 파일 파괴·c17/c7).
  - **(B) SIGSEGV root**: Sternheimer-CG 버그 아님(crash-safe). 진짜 root=`davidson.hexa:185-191` collapse-and-restart가 near-degenerate manifold서 basis 축소(m<nbands) 후에도 nbands Ritz 행 패킹→evecs stale 행→`qforge_run.hexa:178-186` 언팩→`st_project_out` occ[j][i] 경계초과. 해법=collapse 후 evecs 재정규화/cull. 이번 세션 sternheimer.hexa len-guard는 backstop.
  - **(C) OOM**: n≈645 ~10GB은 할당 churn(하드 floor 아님) — `screening_pwfft.hexa`가 매 fold 새 Ntot grid 할당(L329-339·416-439·457) + `screening_anderson` push-before-cap. 해법=모듈버퍼 재사용 refactor(~4-6GB 절감·로컬 n=645 cap16 가능·수치변화 0).
- ARCHITECTURE.json `from_scratch_wall` 정밀화(모호한 "non-trivial DFPT"→정확한 file:line+로컬해법). 실행순서=툴체인→davidson→OOM refactor→CaH6 small λ측정. 거버넌스 c17(upstream 직접고침·격리 worktree) 적용 — hexa-lang-wt-pbescf 워크트리서 작업.

### QFORGE/QE 마이그레이션 아키텍쳐 통합 관리 + d_qforge_migration_routing 거버넌스 (유저지시)
- 유저 지시("QFORGE/QE 아키텍쳐 제대로 관리 + 최대한 마이그레이션 성공 + QFORGE 전환")에 따라 흩어져 있던 마이그레이션 상태(honest_standing·modes·migration_gate·fleet lanes·screening_wiring)를 **ARCHITECTURE.json `migration_gate` 단일 SSOT**로 통합: `boundary`(전환됨=L0-L5 어셈블러 전체가 native QFORGE gate-grade[CaH6 1.65e-7] / QE잔존=DFPT front-end |g|²·포논·nspin 모먼트만) · `from_scratch_wall`(2 deep walls + named breakthrough levers) · `roadmap`(M1✅ M2✅ M3🧱 M4⏳ M5⏳) · `routing_rule`.
- **정직한 전환 상태(c9)**: stage-1(λ/Tc 어셈블리 전체)은 **이미 QFORGE로 전환·gate-grade** = production mode-(b) hybrid. stage-2(from-scratch front-end |g|)는 **확정 terminal 벽** — process-split이 farr/val-arena 힙충돌은 우회했으나 (1)Sternheimer degenerate-subspace SIGSEGV (2)gate-grade ecut OOM 2벽 잔존. 즉 "최대 마이그레이션"=어셈블러 전환 완료, front-end는 M4 레버(degenerate-subspace Sternheimer OR 고RAM 포드)로 돌파 시도.
- 거버넌스 **`d_qforge_migration_routing`** 신설(CLAUDE.md) — piece-by-piece 전환·≤1% 통과분만 absorb·QE는 정직한 reference·벽은 named 레버로 돌파(c15/d2)·SSOT 1곳 강제.
- ① process-split 로컬 재실행(P1)은 line298이 이미 박제한 벽을 재실험하던 것이라 중단 + 임시 ~/.hx/src 패치(runtime.h·runtime_core.c) **원복**(공유 RT-NATIVE 툴체인 복원·c10).

### QFORGE screening 배선 — '인터페이스 불일치' 주장 철회 (c2/c9 정정)
- 직전(같은 날, PR #669) "screening 배선 인터페이스 불일치, fix 필요" 주장을 **철회**합니다 — 더 깊이 읽으니(`screening_anderson.hexa:132-146`, pw_frontend가 실제 부르는 변형) **FFT-Poisson 배선이 이미 완료**돼 있음: 루프가 `if qpwfft_is_on() { dvscr = qpwfft_dvscr_from_dpsi(states, dpsi_cols) }`로 자체 δψ(`dpsi_all`)를 언팩해 FFT 커널로 라우팅(diagonal은 fallback). 제 오류 = base 변형(`screened_dv.hexa`)+호출부 인자만 보고 `_anderson` 내부 라우팅을 놓침.
- 즉 screening은 **engage 함**(R7: λ=4.1518·5.12%<bare 5.47%). 진짜 잔여 게이트 갭 = (a)from-scratch PBE-SCF 정확도(f_xc CLOSED-NEGATIVE·SIGSEGV·process-split 필요) (b)converged n=645 OOM — 둘 다 배선 swap보다 어려움. **교훈(c2)**: verify-before-done이 이미 있는 코드의 중복 작성을 막음(실제 호출 변형을 읽어라, sibling 말고). ARCHITECTURE.json mode(c) `screening_wiring` + 메모리 재정정.

### QFORGE mode(c) screening 배선 갭 코드검증 + fix 착수 (d_qforge_fix 병행)
- "QFORGE 안 쓰는 이유" 규명 → 코드 정독(c2): QFORGE 마이그레이션 게이트 HELD인 진짜 이유 = converged-basis screening 미작동. **근본원인 = 인터페이스 불일치**(2026-06-05 메모리의 '한 줄 배선' 진단은 오진, 정정함): Anderson Dyson 루프(`pw_frontend.hexa:~1115`)가 밀도공간 closure `qpwd_drho_to_dvscf(drho:[float])`(converged n=645서 0)를 호출하는데, staged FFT-Poisson 커널 `qpwfft_dvscr_from_dpsi(psis,dpsi)`(`screening_pwfft.hexa:372`)는 파동함수공간(δψ) 입력 → drop-in swap 불가.
- **fix 착수**(유저 ① 선택·d_qforge_fix 병행): 격리 worktree서 Δρ↔δψ 어댑터(또는 루프 δψ화)→FFT 커널 배선→`pwfft_folds>0`+λ가 bare 4.137서 이탈 확인→고RAM 포드서 converged λ(n=645 OOM 2차벽). RTSC 4×4×4(vast 41382613 사이징·QE production)와 **동시 진행**. ARCHITECTURE.json mode(c) `screening_wiring_2026_06_18` 박제 + 메모리 정정.

### RTSC LaRu3Si2 4×4×4 사이징 — summer 무료풀 → vast 안정 포드 에스컬레이션 (c16-(c) 인프라벽)
- 4×4×4 사이징(SCF+ph.x init으로 irreducible q수 확인)을 summer 무료풀에서 시도했으나 **3연속 SCF 발사 실패**(scf.out 0바이트·출력 없이 죽음·메모리 19G여유라 OOM 아님·동시 RT-NATIVE 세션 간섭+flaky transport 의심). 정직 진단(c9·c1): 직전 자가치유 모니터가 transient proc-gone을 오판해 `rm -rf out`으로 SCF 진척을 반복 삭제하던 역효과도 있었음(→passive로 교체).
- summer가 이 작업엔 신뢰불가 substrate로 확정(c16-(c)) → **vast 안정 포드 41382613(≥120G·@demiurge)로 이전**(d17 비용자율·~$0.4/hr). 디스크 preflight 가드(방금 hexa-lang 머지)가 ≥100G 강제 — 첫 실전. micromamba+QE(conda-forge) 설치 후 SCF+ph.x init 자동발사(체인 모니터). q수 확정 후 production el-ph는 가드 박힌 hexa deck `run_resume.sh`로 발사. 덱·포드 스크립트 박제(`exports/rtsc/decks/laru3si2-444/`).

### QFORGE 병목개선 — POLAR (Fröhlich) Wannier |g| q-보간 (dense-per-q 레버를 극성물질로 확장)
- QFORGE 병목 매핑: **dense-per-q DFPT = #1 el-ph 비용**(29-pod teardown의 진짜 원인). #1 속도레버 = EPW식 Wannier |g| q-보간(`stdlib/qforge/wannier_ginterp`, coarse-q → 실공간 g(R) → dense-q 재보간)인데 **단거리 g(R)만 정확** — 자체 g5가 neg-control로 "장거리(극성) g(R)=coarse aliasing→보간 λ 미재현"을 박제(d6 gap). 이게 극성 산화물 후보(Os/Co metal-oxide, magmom k-벽 중첩)에서 레버를 막던 구멍.
- **hexa-lang PR#3510** — 신규 `stdlib/qforge/wannier_ginterp_polar.hexa` + `..._selftest.hexa`(@ci_gate). EPW 범위분리(Verdi-Giustino, PRL 115 176401): 닫힌형 `g_L(q)`를 보간 전 빼서 잔차 단거리화(정확 보간)→dense q'서 해석적 복원(`qforge_g_to_real_polar`·`qforge_g_at_q_polar`·`qforge_g2_at_q_polar`·`qforge_wann_lambda_dense_polar`).
- **g5 PASS(검증 출력)** — base gate의 장거리 neg-control fixture 그대로 재사용해 FAIL→PASS 뒤집음: `[plain]` rel-ε=0.679 🔴 → `[polar]` rel-ε=**3.4e-16** 🟢(dense λ 완전재현) · round-trip max|Δ|=5.6e-16 · fix-is-real Δrel=0.68. tune-to-green 아님.
- **d6 정직 범위**: METHOD(빼기→보간→복원)만 박제. 실셀 `g_L`은 DFPT Born전하 Z*·ε∞ 쌍극자 vertex(포논 provider 공급). 검증물 `state/qforge-wannier-polar/`. QFORGE.md milestones 박제.

### RTSC LaRu3Si2 4×4×4 q DFPT 발사 — head-to-head 승자 정밀화 (soft모드 artifact vs CDW)
- 2×2×2 head-to-head 승자 LaRu3Si2를 **4×4×4 q-grid DFPT**로 정밀화: 2×2×2서 physical λ=1.64는 허수모드(soft) 11개를 폐기한 상한이라, 더 촘촘한 q-격자에서 그 허수모드가 **경화(artifact → λ~1.6 신뢰)** vs **잔존(진짜 CDW 불안정)**인지 판별.
- 덱 `exports/rtsc/decks/laru3si2-444/`(검증된 2×2×2 덱 재사용 + nq=4 한 파라미터 변경 + `recover=.true.` 자가치유 · d19·d_deck_always). summer 무료풀서 SCF + ph.x init **사이징**(irreducible q수 확인) + d16 free dry-run 진행 → q수 확정 후 **d_qforge_parallel** q-분할로 vast ≥100G 병렬 발사(d17·d11 disk sizing; vast 40G는 el-ph 스크래치>40G/q로 ruled out).

### RTSC LaOs3Si2 DFPT el-ph 완주 + LaRu3Si2 head-to-head 확정 (flat-band→λ)
- LaOs3Si2 2×2×2 DFPT el-ph가 summer 무료풀(915G, vast 40G는 q당 스크래치>40G로 ruled out)에서 **완주**. summer가 동시 RT-NATIVE 경합으로 ~6회 재부팅했으나 **QE `recover=.true.` 자가치유**(`scripts/scratch/laos3si2_vast/summer_q4_resume.sh` + recover 카운트 전진추적 모니터)로 진행 보존하며 완료 — 비용 $0.
- 수확(`harvest_lambda_tc.py`, q-star 가중 Allen-Dynes, 허수제외): 4 irreducible q(w=1,1,3,3), 18모드, 10 broadening. **🔴 동적불안정**(가중 허수모드 24개, LaRu3Si2의 6개보다 많음; Γ도 5개 허수).
- **head-to-head 정직 정정(c9)**: LaRu3Si2 보고값 λ=1.64는 **σ=0.05 Ry**(el_ph index 10)에서 조립된 것 → **같은 σ로 맞춰 비교**. matched σ=0.05: **LaRu3Si2(Ru 4d) λ=1.64·Tc~7K가 LaOs3Si2(Os 5d) λ=0.81·Tc~4-5K를 이김**. Os의 높은 ω_log(109 vs 56K)는 더 많은 soft mode 제외의 인공. **Os 치환은 flat-band el-ph를 강화 못 함** — 4d Ru가 더 강한 coupler. flat-band→λ 가설은 정성적 지지(둘다 강결합)되나 깨끗한 고-Tc는 미확립(둘다 2×2×2 불안정, d6). 다음 레버=승자 LaRu3Si2의 4×4×4 q(artifact vs CDW 판별).
- 박제: `exports/rtsc/laos3si2_dft_elph.json`(전 broadening sweep + matched 비교) · `ARCHITECTURE.json` b_dfpt_lambda_tc verdict 갱신 · raw harvest tar `scripts/scratch/laos3si2_vast/harvest/`.

### hexa cloud 운영(클라우드 디스패치) — 트러블슈팅·upstream fix·정리 한 세션
- **hexa-lang upstream fix (PR #3477 MERGED)**: `hexa cloud run/exec/script` 가 vast/runpod SSH 프록시의 전송-잘림(간헐)으로 `bash: -c: option requires an argument`·`rm: missing operand` 간헐 실패하던 것을 `_ssh_capture_retry`(no-exit-marker 감지 시 backoff 자동 재시도)로 흡수. (참고: `hexa cloud` 는 별도 precompiled 바이너리 `~/.hx/bin/bin/hexa-cloud` — stdlib/cloud 편집은 `hexa run tool/build_hexa_cloud.hexa --install` 재빌드해야 라이브; ~/.hx/src 복사만으론 안 됨.)
- **auto-adopt 폐기 (PR #3486 SHIP → #3489 REVERT)**: `cloud pods` 가 orphan 을 사후 입양·라벨 추정하게 했으나 **잘못된 레이어** — 올바른 건 **배포(rent) 순간 무조건 라벨링**(이미 `_resolve_project`@repo + `_resolve_purpose` 로 line 1406/1454 unconditional). hexa cloud 가 자기가 배포 안 한 외부 포드를 사후 주워담는 건 역할 아님 → revert. orphan 은 surface(경고)만, 사람이 `cloud reap`/`attribute`.
- **vast 정리(d17 빌링 차단)**: 41069486(LaOs3Si2 가속) 🧱 40G 디스크벽(q당 el-ph 스크래치 >40G, ruled out) teardown · 40992986(RbOs2O6 nonmag DFPT) 🔴 **발산**(ddv_scf 8.9e25→4.0e29 폭증·49h·dyn1 0B = 비자성강제→DFPT 발산, 실바닥상태 자성) teardown. 증거 `scripts/scratch/rbos2o6_nonmag_diverge/`.

### RTSC LaOs3Si2 DFPT — summer 재부팅 → recover-resume (q4)
- LaOs3Si2 head-to-head(vs LaRu3Si2 λ1.64·Tc7K) 의 q4 el-ph(rep#12/16 iter#7 ddv 1.4e-11 **정상수렴 중**)가 summer 재부팅(`up 2min`)에 ph.x 쓸려나감 — **크래시 아님, 인프라 재부팅(c16-(c))**. q1·q2·q3 dyn.elph + out/_ph0 체크포인트 디스크 생존 → `recover=.true.` 추가 + ph.x 만 재발사(`run_elph.sh` 의 `rm -rf out` 회피, `scripts/scratch/laos3si2_vast/summer_q4_resume.sh` 박제). 6랭크 재개. 완주 시 4 q collect → 동적안정 체크 → λ/ω_log/Tc.

### 도메인 .md 전부 은퇴 → ARCHITECTURE.json `domains[]` SSOT 통합 (c4 단일문서)
- `domains/` 아래 **576개 .md(13만 줄)** 를 8개 병렬 요약 agent로 **126 논리도메인 → 144 구조화 엔트리**(`{id·alias·goal·status·key_verdicts·milestones·source_paths·notes}`)로 압축해 `ARCHITECTURE.json` 신규 `domains[]` 블록에 통합. **.log.md 117개 폐기**. 본문은 git history(`source_paths`)에 보존.
- 정직 보존(c9): status 분포 active 56·stub 32·🟢26·🟠21·🧱4·🔴2·DRAINED2·🔵1 — FALSIFIED/closed-negative/stub 그대로(QFORGE-PAW🔴·QFORGE from-scratch🧱·SENOLYX R12🧱·UFO Stage4~7 ⚪UNPROVEN·AURA medical UNPROVEN 등).
- 총 **693개 .md/.log.md 삭제**(`git rm`). `domains/` 잔존 = `.demi` 컴퓨트덱 + `.hexa` + `.tape` 로스터 + UFO sim 덱. `ARCHITECTURE.html` 뷰어에 `renderDomains` 추가(status·goal·milestone 표시). CLAUDE.md 구조설명 현행화. 배치/단편 `scripts/scratch/`(c5).

### hexa deck 검증기 — RTSC vc-relax/el-ph 트러블 가드 3종 추가 (G08·G09·G10)
- `d_deck_always`(hexa deck = self-improving 덱규율 SSOT — 매 트러블슈팅이 새 가드)에 따라, 최근 RTSC 캠페인에서 겪었으나 아직 가드가 없던 QE 덱 실패모드 3개를 `sim/deck_lint.hexa`에 박제(가드 7→10).
  - **G08 `vcrelax_convergence`** (WARN · d6): `vc-relax` 덱이 `etot_conv_thr`/`forc_conv_thr`/`press_conv_thr` 중 하나라도 빠지면 경고. QE 기본 임계값은 셀을 under-relaxed로 남겨 → matdyn 허수모드 다발(이번 세션 YH6 41·MgH6 34개) → 물리적 Tc 무효.
  - **G09 `elph_needs_relaxed_cell`** (WARN · d6): el-ph(`electron_phonon=`) ph.in 덱이 같은 디렉토리에 `relax.in`/`vc-relax.in`/`scf.in` 흔적도 없고 RUNBOOK에 relax 언급도 없으면 경고. **G06과 별개 축** — G06=동적안정 *검증*(q2r→matdyn) 존재 여부, G09=el-ph가 도는 셀이 *완화*됐는지 전제 확인.
  - **G10 `kgrid_zero`** (FAIL): `K_POINTS automatic` 메시가 0×…(손편집으로 nk 라인 0/공백)면 실제 k-메시 없음 → QE 에러 없이 엉터리 에너지. (코드 읽다 발견한 명백한 미커버 실패모드.)
- 각 가드: `all_guards()` push + `_guard_catalogue()` 행 + `_self_test()` good PASS + broken WARN/FAIL 케이스. self-test 14/14 green(`hexa run sim/deck_lint.hexa --self-test` → `# deck_lint self-test PASS`). 문서 `sim/DECK_LINT.md` 카탈로그 표 + `ARCHITECTURE.json` deck-lint role 갱신.

### QFORGE fleet verdict raw 기록 박제 (c5 보존 — pbe-scf 🧱 + magmom 🧱)
- QFORGE 갭 fleet 라운드(#653)의 두 lane verdict raw 기록이 `.verdicts/`에 미커밋으로 남아 있던 걸 박제(c5). 결론은 이미 #653 CHANGELOG/ARCHITECTURE.json에 반영됨 — 이번은 PREDICTION/VERDICT 원문 보존.
  - `.verdicts/qforge-cah6-pbe-scf-vertex/` — 🔴🧱 from-scratch gate-grade 확정벽: 3-D PBE 바닥상태는 계산 성공(wiring bug fix·singular-BCC miller fix)이나 진짜 잔여=엔진 메모리모델(farr↔val-arena)·near-degenerate 점유다양체 SIGSEGV + gate-grade ecut mini OOM. λ 날조 0(d6). production=하이브리드 1.65e-7 유지.
  - `.verdicts/qforge-magmom-kb-nonlocal/` — 🧱 CoSn 모먼트 벽 재국소화: 모든 fixture가 LOCAL-only pseudo(KB 비국소 projector OFF)였던 게 m≈0 모호함의 원인. KB-nonlocal ON에도 Γ 모먼트 ≈0 → 진짜 벽=k-샘플링(BZ-적분 Stoner), 레버=GPU-davidson.

### SENOLYX 캠페인 → ARCHITECTURE.json SSOT 정리 (R12 close-negative + R13 후보 ABFE)
- 신약(senolytic/표적분해) 캠페인 SENOLYX가 아키텍처 SSOT(JSON 트리)에 빠져 있던 걸 채움 — `campaigns.SENOLYX` + `results_index.SENOLYX` 신설. `.html` 뷰어는 `fetch('./ARCHITECTURE.json')` 동적 렌더라 자동 표시(재생성 불필요).
- **R12 HSP90 ΔΔG**: 🔴 close-negative 박제 — ΔΔG=+3.13±2.83 vs exp −1.9 (K=5 앙상블), R10b/R11/R12 3개 독립선이 affinity-precision 벽 일치. 메인 senolytic 파이프라인은 양성 유지, HSP90 정밀도 sub-axis만 음성.
- **R13 후보 ABFE 검증**(openmmtools 이중탈결합, vast GPU, K-앙상블 · 하니스 `exports/SENOLYX/round13-abfe-allcand/`): MCL1/S63845 ✅ −16.78±2.77 (3/3, 실험 −13 일치) · BCLXL/3CQ ⚠️ −29.28±0.71 (3/3, 재현되는 계통 과대결합 — 부호OK·세기 2× · c9 정직 플래그) · CRBN/EF2 🔵 −1.53 (1/3 진행중, IMiD µM 약결합 방향 일치, 세기판정 보류).
- 결과 영구저장 = `round13-abfe-allcand/seen.prog`(persist-merge), 도메인 SSOT = `domains/SENOLYX.md`. CRBN 3/3 완주 시 최종 per-후보 판정 + pod reap 별도 사이클.

### `hexa deck` 검증기 MVP — 덱규율 self-improving 가드 레지스트리 (`sim/deck_lint.hexa`)
- 이번 세션 손작성 QE 덱 버그 다발(verbosity·mass·pseudo·d15·d6)을 코드로 박제하는 **검증기**를 신설. 빌더(빵틀 `hexa-lang stdlib/deck/gen.hexa`)는 이미 있었고, 없던 건 *내용 규율 린터* — 그 갭을 채움.
- **self-improving 설계(핵심)**: 덱 트러블 발생 → 재발방지 가드를 한 줄(`fn guard_<slug>` + `all_guards()` push)로 추가하는 확장형 레지스트리. `--self-test` 가 good/broken 케이스로 각 가드 검증(@ci_gate). README(`sim/DECK_LINT.md`)에 "새 트러블 → 새 가드" 워크플로우 명시. 덱규율 SSOT.
- **시드 가드 7개**: G01 bands `verbosity='high'`@#k≥100(FAIL) · G02 zero mass(FAIL) · G03 wrong element mass(FAIL) · G04 pseudo-not-found(WARN·d13) · G05 d15 SCF aids(WARN) · G06 el-ph 동적안정 게이트(WARN·d6) · G07 QE-FoX non-ASCII 크래시(FAIL).
- **검증(c2 — 자가판정 아님, 출력)**: ① 실버그 `exports/rtsc/decks/cosn/bands.in` 린트 → **G01 FAIL 정확 포착**(band-path 161 k-points 계산: 40×4+1, verbosity 누락) + 보너스 G07(Γ–K–M 주석 non-ASCII) 적발. ② 클린 덱 `CaH6_NC/scf.in` → all-PASS(pseudo 2개 staged 확인). ③ `--self-test` 9-단언 PASS. ④ G01 scope=bands/nscf 한정(relax/scf 오탐 0 · c9 정직).
- d4 generic(후보명 하드코딩 0 · QE directive/card 키잉) · pure+network-free(read_file/file_exists/list_dir만). dft_run d16 dry-run 게이트의 *앞단*(더 싼 정적 게이트). 진입점 `hexa run sim/deck_lint.hexa <deck.in|deck-dir>`.
- ARCHITECTURE.json `sim` 노드에 `deck-lint` 자식 등록.

### 정정: `d_demi_always` → `d_deck_always` (사용자 정정 — demi 아닌 deck 의도)
- 직전 `d_demi_always`(설계는 hexa demi)는 사용자 단어 착오 기반 → **`d_deck_always`로 교체**: 모든 컴퓨트 입력덱(QE scf/ph/vc-relax/bands)은 `hexa deck`(빌더+검증) 경유, 손작성 `.in` 금지. 세션 덱버그(verbosity='high' 누락·Os질량 오기·vc-relax 미수렴·d15 aids 누락·불안정셀 el-ph)를 도구에 박제.
- **self-improving 규칙**: 트러블슈팅 발생 시 그 예방처리(가드/체크)를 hexa deck에 즉시 박제 → 같은 버그 재발 0. (hexa deck 빌더+검증 MVP 구축은 별도 PR 진행.)
- 잘못된 타깃 demi 개선 PR #656 닫음(미머지, 브랜치 보존) · agent worktree 제거.

### `d_demi_always` 거버넌스 추가 — 모든 설계·아키텍처는 `hexa demi` 7-verb 경유 (필수)
- CLAUDE.md 거버넌스에 `d_demi_always` 추가: 설계/아키텍처/도메인 구조 작업은 항상 `hexa demi`(명세→구조→설계→해석⟲→합성→검증→인계) 경유. 합성⑤=ARCHITECTURE.json(SSOT) · 검증⑥=harness verify · 인계⑦=ARCHITECTURE.json/.html. 실행("어떻게")=`/sbs` / 상류 설계("무엇을")=demi. (hexa demi 7-verb 개선 자체는 별도 PR 진행.)

### 무압 클라스레이트 3종 안정성 게이트 — 🟠 INCONCLUSIVE-deferred + 포드 down (정직·비용규율)
- AcBeH8(293K@1atm BeH8)·CaB3C3·LaB3C3 동적안정 게이트: vc-relax가 렌트 vast 포드(41193096/41193571/41194736)에서 **미수렴**(BFGS stall mid-relax) + 재개 에이전트 2회 인프라/API 사망 → **안정성 미판정**(stable도 unstable도 미확립). 3포드 **down**(`--force`, idle 과금 수시간 출혈 중단). 정직 deferred(c9, 날조 0) — 돌파=견고한 vc-relax(damped-MD/타이트 mixing) 재시도. X₂MH₆ Fm-3m(mg2irh6·li2cuh6)는 별도 🔴 ambient-unstable 확정 유지. RTSC_LEDGER 93행.

### QFORGE 갭-클로징 fleet 3-lane 라운드 완결 (정직 — 1 닫힘 · 2 검증된 벽)
- **fleet 발사**: QFORGE-FEATURE/PERF 실측 백로그에서 진짜 갭 3개를 동시 lane(hexa-lang worktree 격리·frozen-first)으로 닫음.
- **qforge-perf-gpu 🟢🏁 PERF 갭 닫힘**: GPU "size에서 안 빠름" 근본원인 = H·Ψ를 밴드별 GEMV로 쪼개 매 iter H 전체 재전송 → **배치 GEMM(H@Ψ) 하나로 묶어** davidson+sternheimer 실솔버 hot-path에 배선. 풀-솔브 **1.34–18.04×(Davidson)/2.56–18.6×(Sternheimer)** RTX5070(summer 무료), 머신-eps parity, 전 selftest PASS. PR hexa-lang#3442. 정직 floor: small-nocc(nb4–8) ~1.3–2.6×(전송 바운드).
- **qforge-magmom 🧱 벽 재국소화(정정)**: CoSn m≈0이 모호했던 진짜 원인 = 모든 fixture가 LOCAL-only 의사퍼텐셜(KB 비국소 projector OFF, Co d-채널 미결합). KB-nonlocal 켜니 d-shell 결합되나 Γ 모먼트 여전히 ≈0 → **진짜 벽=k-샘플링(BZ-적분 Stoner), PW-cutoff 아님**; finite-k davidson 처리량이 천장 → GPU-davidson이 레버(perf lane이 인프라 제공). PR hexa-lang#3447. memory [[qforge-cosn-co3d-pw-compute-wall]] 정정.
- **qforge-pbe-scf 🧱 from-scratch gate-grade = 확정벽**: ≤1% 게이트를 모든 DFT-함수 레버로 미달(R7 screened 5.12% 최저·R8 GGA f_xc closed-neg·PBE-SCF 퇴행). 3-D-PBE 바닥상태는 계산 성공(residual-3 해결, singular-BCC miller 버그 fix). process-split(gga_scf→H 체크포인트→2nd 프로세스 vertex)이 farr/val-arena 힙충돌은 우회했으나 λ 여전히 미측정 — **두 벽**: ① 3-D-PBE near-degenerate 점유다양체 → Sternheimer projected-CG SIGSEGV(QE식 축퇴처리 필요) ② gate-grade ecut(n≈645) mini OOM ~10GB. λ 날조 0(d6). production=모드(b) 하이브리드 1.65e-7 유지·migration_gate HELD. branch hexa-lang `qforge/pbe-scf-vertex`(2ae4e7aff, 미머지).
- **ARCHITECTURE.json**: `engines.QFORGE.fleet_2026_06_16` 3-lane 종결 상태로 갱신(pbe-scf in-flight→🧱), `updated`=2026-06-17.
- RTSC 컴퓨트 lane(LaRu3Si2/LaOs3Si2 DFPT λ/Tc · 무압 3포드 안정성)은 별도 in-flight — 착륙 시 별도 폴드.

### RTSC 핵심 수확 — LaRu3Si2 DFPT λ/Tc (flat-band→λ 테스트) · 🔴 2×2×2 동적불안정 (정직 d6/c9)
- **수확**: vast 포드 41069486에서 LaRu3Si2 DFPT el-ph(QE 7.5 ph.x `electron_phonon='simple'`, 2×2×2 q 4-irreducible, 16³ fine-k, PHONON WALL 22h59m, WRAPPER_EXIT=0) 완주 수확. DOS(E_F)=35.4078 states/spin/Ry, E_F=16.1099 eV.
- **안정성 FIRST(d6 게이트)**: dyn1~4 전 주파수 스캔 → **허수모드 11개**. dyn1(Γ): 3개(−29.7/−29.7/−21.0 cm⁻¹)=음향-Γ ASR 아티팩트(설명가능). **dyn2/3/4(비-Γ q): 6개 진짜 소프트모드** — dyn2 q=(0,0,−0.800) −77.1/−70.2/−70.2, dyn3 −44.2/−35.5, dyn4 −61.5 cm⁻¹. **min freq −77.14 cm⁻¹**. ph.x가 각 허수모드에 lambda(ν)<0 출력(과제가 짚은 lambda(1)=−0.1241@dyn4 = q4 진짜 소프트모드, **음향-Γ 아티팩트 아님**). → **🔴 동적불안정 = 절대 λ/Tc 신뢰불가**.
- **λ/ω_log/Tc 조립**(lambda.x가 'simple' 모드 per-q DOS 6번째 소수점 드리프트(35.407786 vs 35.407780)로 `inconsistent DOS(Ef) read` abort → lambda.x 동일 Allen-Dynes 알고리즘을 q-star 가중(w=[1,1,3,3])으로 직접 조립):
  - **NAIVE(lambda.x 관례, 전 모드 합)**: λ=**−0.339**(허수모드가 −1.98 기여, 비물리), Tc=0 — 불안정 격자가 무의미한 Tc를 주는 이유.
  - **PHYSICAL(허수모드 제외, 안정 7모드만)**: λ=**1.639**, ω_log=**56.3 K**(39.15 cm⁻¹), **Tc(μ*0.10)=6.96 K · Tc(μ*0.13)=6.40 K** — 실측 7K와 일치하나 11모드 폐기 = 소프트 상한, 수렴값 아님.
- **flat-band→λ 답(정직 c9/d6)**: PHYSICAL λ=1.64는 강결합 영역(flat-band N(E_F)=35.4 부스트 일관)이고 Tc~7K가 실재료와 일치 → flat band가 큰 el-ph 드라이브를 만든다는 정황. 그러나 **같은 소프트함이 2×2×2 거친 q-그리드에서 kagome 격자를 불안정화** → 'flat-band → 비정상 고-λ' 깨끗한 주장은 아직 미성립. 소프트모드는 kagome 금속의 거친-q 그리드-앨리어싱 가능성.
- **돌파경로(d2)**: 4×4×4 q DFPT로 소프트모드 경화(아티팩트→λ~1.6 신뢰) vs 잔존(진짜 CDW) 판별. QFORGE xval은 보류(불안정 손상 데이터 조립은 정보 무가치).
- **폴드**: `exports/rtsc/laru3si2_dft_elph.json`(전사 verbatim) · `RTSC_LEDGER.jsonl` LaRu3Si2-DFPT 행 추가(92행 검증) · `ARCHITECTURE.json` `campaigns.RTSC.branches.b_dfpt_lambda_tc` LaRu3Si2 PENDING→수확결과(LaOs3Si2 head-to-head 여전히 PENDING). 포드 SAVE_POD 유지.

## 2026-06-16

### 전 캠페인 결과 ARCHITECTURE.json 통합 — JSON 트리 = 단일 항해 SSOT (c4·c5·c9)
- **무압 wave 병합**: `rtsc-ambient-wave-20260616` `--no-ff` 병합(충돌 0) — 무압 동적안정 verdict 6건(Mg2IrH6·Li2CuH6 🔴 + AcBeH8·CaB3C3·LaB3C3 🟠 in-flight) + QFORGE-fs ambient lane + RTSC_LEDGER 6행 + scratch. `RTSC_LEDGER.jsonl` 91행 JSON-검증 PASS.
- **`ARCHITECTURE.json` 통합 인덱스화(c5: raw 기록은 보존, JSON은 종합 index+summary)**:
  - `campaigns.RTSC.branches` 를 (a) flat-band-at-E_F 패밀리(승자 LaRu3Si2 🟢 ΔE=−0.055/m=0/실Tc7K · LaOs3Si2 🟢 완화ΔE=+0.089/m=0; 패자 LaRh3Si2 🔴 d⁸오버슛 · MoSn/CoSn-edope/CoSn-hdope 🔴 · CsV3Sb5 🔴 · RbOs2O6 🟠; d⁷=승자/d⁸=오버슛 bracket; 메타=위상 필요조건·약혼성 d-kagome 레버; v2refuted/v3/v4/topology-sweep 삼각측량) (b) DFPT λ/Tc — LaRu3Si2+LaOs3Si2 IN-FLIGHT(q-grid 가동, 'flat-band→λ?' 테스트 pending) (c) 무압 초수소화물(X₂MH₆ Fm-3m 🔴 2/2 + AcBeH8/CaB3C3/LaB3C3 🟠 + QFORGE-fs lane 🟠 BLOCKED-upstream) (d) 전략(ω_log천장 λ-레퍼런스·상온=cRPA-DMFT 별도레버)로 구조화.
  - `campaigns.MATH-SPECTRA` 1D 완전차트 확장(probe1-6 verdict 전사) · lane 🏁.
  - `engines.QFORGE` 에 `fleet_2026_06_16` 추가: **perf-gpu 🟢🏁**(block-GEMM H·Ψ → davidson/sternheimer 1.34–18.6× RTX5070, machine-eps parity, PR hexa-lang#3442; 정직floor=nb4-8 ~1.3-2.6× transfer-bound) · **magmom 🧱**(KB-nonlocal 진단정정: CoSn m≈0 = k-sampling Stoner 벽, PW cutoff 아님 → GPU-davidson 레버, PR hexa-lang#3447) · **pbe-scf 🟠 in-flight(process-split)**(3-D-PBE ground state COMPUTES, in-process λ SIGSEGV farr↔val-arena, 최종레버=process-split). migration_gate=HELD, production=mode-(b) hybrid 1.65e-7.
  - 최상위 `results_index` 신설 — 주요 발견 → raw 기록 경로(RTSC_LEDGER material행·exports/rtsc/*.json·exports/math-spectra/*.json·.verdicts/qforge-*/) 포인터 맵. `updated`=2026-06-16.
- **`ARCHITECTURE.html` 뷰어 최소패치**(제네릭 유지): `fleet_2026_06_16` lane 렌더 + 캠페인 branch `verdict`/`note`/`qforge_fs_lane` 렌더 + 최상위 `results_index` 재귀 렌더러. JSON·`<script>` JS 문법 둘 다 검증 PASS. 정직(c9): 실측 verdict만 전사, in-flight=pending 표기.

### ARCHITECTURE 단일문서 마이그레이션 — `.md` 산문 → `.json` 트리 SSOT + `.html` 뷰어 (c4)
- **`ARCHITECTURE.md` 은퇴(git rm) → `ARCHITECTURE.json`(JSON 트리 SSOT · AI/툴 파싱) + `ARCHITECTURE.html`(자족 collapsible-tree 뷰어, inline CSS+JS) + `serve.py`(정적 서버 :8765 + 브라우저 자동 오픈)**. c4의 "`.json` 트리 채택" 경로. 전사 누락 0(원문 5개 헤딩 전부 nodes/overview/data_flow/governance로 매핑, 18 top-level·23 total 노드 + QFORGE 4모드 + RTSC frontier + MATH-SPECTRA 전사 후 자체대조).
- `harness.config.json` `docs.architecture` `ARCHITECTURE.md`→`ARCHITECTURE.json` 갱신(+`docs.allow`에 `.html` 추가) — c14 doc-gate 정합. `CLAUDE.md` ARCHITECTURE 포인터 5곳(트리노드·single-doc·harness docs·quick-ref) `.json`/`.html`로 전환.

### QFORGE ENGINE STATUS 확인 — from-scratch 전 파이프라인 구현·검증 실재 (정정 c9)
- 코드 직접 확인(`stdlib/qforge/` + `QFORGE/QFORGE.md`): **from-scratch SCF(`scf_pw.hexa`)→DFPT(`dfpt.hexa`·`sternheimer`)→el-ph(`elph.hexa`)→Tc(`eliashberg.hexa`) 전 구간 구현**, al_fcc/nb_bcc/pb_fcc el-ph xval PASS. 4모드: (a) bare-vertex from-scratch CaH6 rel-ε 5.47%(rough 스크리닝) · (b) hybrid QE|g|→어셈블러 1.6e-7(gate-grade) · (c) screened R7 5.12%(bare 돌파·gate미달·HELD) · (d) LSDA 자성 brick-PASS·모먼트 compute-wall. **"from-scratch=벽"은 부정확** — gate(<1%) 미달일 뿐, ~5% rough-screening은 작동.

### RTSC 상온 분기 — 패밀리=λ-레퍼런스 / 상온=별도 레버 + 무압 초수소화물 lane 발사
- **전략 분기(① 완성도)**: CeCo3B2 kagome 패밀리(LaRu3Si2·LaOs3Si2, 무거운 Ru/Os/Si)는 ω_log 천장으로 상온 후보 아님 → flat-band→λ **레퍼런스로 완주**. 상온은 (A)경량원자 ω_log↑ + (B)flat-band 전자상관 두 레버로 분기.
- **새-substrate 두-레버 후보맵**(`.discoveries/ambient-tc-levers.tape`, 무료 스코핑 🏁): Lever A(LiBC/MgB2류·경량 kagome) 무료 발사가능하나 phonon 천장 ~100K↓; Lever B(flat-band 상관)가 진짜 상온 후보지만 cRPA/DMFT 메서드 빌드 필요(현재 막힘). 정직 박제.
- **무압 초수소화물 완주 lane 발사**(QE front-end + QFORGE from-scratch 병행, Vast 자율): BeH8/BH8·B-C 클라스레이트·X2MH6 partial 8후보. 게이트순서=vc-relax→matdyn 동적안정→생존자만 el-ph(FLEET-DIAGNOSTIC 교훈). **초기 결과: Li2CuH6·Mg2IrH6 🔴 ambient-dynamically-unstable**(Fm-3m 1atm 허수모드 ~−2230cm⁻¹, "H 케이지가 압력을 원함" 벽 2/2 실증); AcBeH8(293K@1atm)·CaB3C3·LaB3C3 ⏳ 계산 중.

### MATH-SPECTRA probe6 — 2D 준결정(Ammann-Beenker) gap-labeling 🟠 INCONCLUSIVE (lane 🏁)
- 1D 호(probe1~5) 완성 후 2D 확장 시도: octagonal cut-and-project tight-binding(953정점 패치)으로 2D 실버 모듈 (a+b√2)/8 gap-labeling 검증. **결과 🟠**: 유한 패치가 유한크기 준위간격(8.83e-3) 위로 명확한 주요 간극 미해상(n_sig=0) → 결정적 2D 모듈 적합 불가, 강제 안 함(c9). 구성은 건전(평균 배위 3.83). 돌파경로(deferred): 4D 초격자 박스 확대/팔각 윈도우 샤프닝/inflation. agent가 서버측 rate-limit로 최종보고 직전 사망 → 산출물 워크트리에서 회수+재실행 검증(c2, fleet §4) 후 박제. RTSC_LEDGER `MATH-SPECTRA-probe6`. **MATH-SPECTRA lane 🏁**: 1D 산술-스펙트럼 지도 완전차트(음성 플랫밴드/ζ + 양성 준결정 Perron모듈), 2D는 inconclusive-deferred.
### RTSC LaOs3Si2 DFPT λ/Tc 발사 — 2번째 평탄밴드 승자 e-ph 승격 (summer 무료풀, FIRED·미수확)
- **2번째 flat-band-at-E_F 승자 LaOs3Si2(🟢 vc-relax 확정: alat=10.59910 bohr, c/a=0.66989, ΔE=+0.089, m=0.00)를 DFPT el-ph로 승격** — LaRu3Si2 DFPT 레시피 미러. 질문: flat-band-at-E_F → 이상고 λ인가? (정직 c9: kagome 수준 modest λ도 유효 결과).
- **레시피**: scf nspin=1(NM 확정, m=0 → 비스핀이 정확+저렴) 12×12×12 k, ecutwfc=90/ecutrho=360, MP degauss=0.02, conv 1e-12 → ph.x electron_phonon='simple' 2×2×2 q(LaRu3Si2 동일격자) + 16³ fine-k 더블델타 → q2r → **matdyn asr='crystal' 동역학 안정성 사전점검(d6/ScH9·YH6 교훈: 허수모드 0 확인 후에야 λ/Tc 신뢰)** → lambda.x Allen-Dynes Tc(μ*=0.10/0.13). Os 질량 실제값 190.23 보정.
- **d16 무료 dry-run PASS**(summer 1-iter pw.x: 6원자/41 KS state, ecut=90 정상 SCF). **summer 무료풀에 setsid 디태치 발사**(np 6 --bind-to none, pw.x=0이던 idle 노드 전체 점유, GPU rent 없음, $0). 자기로깅 `~/laos3si2_dfpt.log`. **수확 대기**: λ/Tc·안정성 점검 결과는 el-ph 완료 후 별도 라운드. 덱 박제 `exports/rtsc/decks/laos3si2_dfpt/`, JSON `exports/rtsc/laos3si2_dft_elph.json`(FIRED status), fire/note `scripts/scratch/qforge_harvest/laos3si2_dfpt_{fire.sh,note.md}`.

### RTSC 위상 sweep 종결 — checkerboard 🔴 + 메타결론(위상≠실현, d-kagome가 레버)
- **checkerboard Os-O 🔴**: Lieb와 동일하게 E_F 근처 평평 띠 없음(Os-O 혼성 분산), m=0.00. **2/2 이상화 Os-O 위상 실현이 같은 혼성벽으로 실패**.
- **메타결론(🧱 Os-O 실현벽 · 위상은 건전)**: 그래프-위상 생성기(v4)는 *추상 tight-binding*에선 플랫밴드를 보장하나, 실제 *재료*가 flat-band-at-E_F를 실현하려면 **약혼성 + 올바른 채움 + 비자성**이 필요. **증명됨**: d-궤도 kagome(LaRu3Si2 Ru-4d·LaOs3Si2 Os-5d 🟢) — 약혼성으로 d-kagome 플랫밴드가 평평+E_F 유지. **실패**: 이상화 Os-O Lieb+checkerboard(2/2) — O-bridge 강혼성으로 분산. **결론: 위상=필요조건(밴드 존재 보장), 실현(약혼성·채움·비자성)=실제 레버. 승리 레시피 = d-kagome CeCo3B2 패밀리**(임의 line-graph 산화물 아님). 돌파경로(c16): Lieb/checkerboard를 약혼성 사이트(국소 d/f·넓은 스페이서 s)로 재실현 = 새 덱 설계 quest(deferred; dice/T3를 Os-O로 또 쏘는 건 같은 벽 반복이라 회피). 박제 RTSC_LEDGER `Checkerboard-OsO-topology`+`TOPOLOGY-SWEEP-META`(83행).

### RTSC 위상 sweep — Lieb Os-O 🔴 (위상≠실현: 혼성으로 FB 분산)
- 삼각측량 v4 위상 생성기의 Lieb 격자(이분 2:1 = CuO₂ 동형) 게이트체크: 이상화 **Os-O Lieb**는 E_F 1.5 eV 이내에 평평한 띠 없음(Os-5d↔O 강혼성→would-be 플랫밴드 분산), m=0.00. **🔴 실현-특이적** — 위상정리상 플랫밴드는 존재하나 *이 재료 실현*이 두 직교 스크린 중 flatness에서 탈락(kagome Ru/Os는 약혼성으로 평평 유지·승리). 돌파경로(c16): 약혼성 실현(s-궤도/넓은 스페이서)으로 재시도 — checkerboard/dice 뒤로 deferred. 박제 RTSC_LEDGER `Lieb-OsO-topology`(80행).

### RTSC LaOs3Si2 🟢 vc-relax 확정 — 1차스크린 GREEN이 완전완화 후에도 GREEN
- 고정 LaRu3Si2 격자 1차스크린(ΔE=+0.039 🟢)을 **per-sibling vc-relax**로 확정: Os 반지름으로 셀 완전완화(alat=10.599 bohr, c/a=0.670) 후 재게이트 → **ΔE=+0.0886 eV(여전히 <0.10 GREEN), m=0.00 비자성, 밴드폭 0.544→0.411 eV(더 평평)**. 1차근사 GREEN이 격자완화에도 살아남음 — LaOs3Si2(Os 5d⁷ CeCo3B2)는 견고한 **2번째 플랫밴드-at-E_F 승자**(LaRu3Si2 다음), 5d가 4d만큼 작동 확정. 박제: RTSC_LEDGER `LaOs3Si2-vcrelax`(79행) + `scripts/scratch/qforge_harvest/sibling_gatecheck/laos3si2_vcrelax.log`. 다음(비용게이트): DFPT λ/Tc 승격(vast rent OR summer 무료 슬롯, go 필요).
### MATH-SPECTRA probe4 — 피보나치 사슬 gap-labeling 정수론 검증 (M6, 🟢 정수론 실재 확인·양성 북엔드)
- **사전등록(frozen-first, c16·c9, 로컬 무료)**: probe1~3 의 음성(ζ↔격자 다리 반증·플랫밴드 CLS=유계 gcd 정합성, 심층 산술 부재) 의 정직한 **양성 대응짝**. 비주기/준결정 tight-binding 스펙트럼에는 gap-labeling 정리(Bellissard)로 진짜 산술 구조가 산다 — 피보나치 사슬의 모든 스펙트럼 간극에서 IDOS 가 {n·α mod 1} (α=(√5−1)/2=1/φ) 모듈 Z+Zα 에 박힌다. **예측: 주요 간극 IDOS 가 소정수 n 의 n·α 에 잔차<0.01 로 군집, 주기 사슬은 α-라벨 간극 없음(단일 코사인 밴드), 무작위 사슬은 깨끗한 간극 없음 → 🟢.** 비대각(호핑) 피보나치 모델(A→AB,B→A; t_A=1,t_B=0.5), F_k=1597 주기 링 numpy 정확대각화(`eigvalsh`), IDOS 플래토=(#eig≤E_lo)/N.
- **결과**: 주요 8개 간극 **전부** {n·α mod 1} 에 매칭, 라벨 n=±1,±2,±3,±4, **최대 잔차 7.0e-7** (1/N 유한크기 바닥 수준 — 사실상 정확); n·α 가 최적 유리수 p/q 를 **8/8 간극에서 모두 압도**(예: IDOS 0.382 → n=−1 잔차 1.8e-7 vs 3/8 잔차 7.0e-3). **대조군**: 주기 사슬 = 단일 코사인 밴드, 내부 간극 0개(라벨 불가); 무작위 사슬 = 깨끗한 큰 간극 0개. 어느 대조군도 α-라벨 간극 사다리를 재현 못함.
- **정직 판정(🟢 CONFIRMED · 양성 북엔드)**: 비주기 스펙트럼에 **정수론(Z+Zα cut-and-project 모듈 / gap-labeling 정리)이 진짜로 존재**함을 수치 확인 — 플랫밴드 음성(probe2/3)의 정직한 양성 짝. 함께 산술이 스펙트럼의 **어디에 살고(준결정 간극라벨) 어디에 안 사는지(플랫밴드 CLS 개수)** 지도 완성. **정직 한계**: 유한 근사 N=1597 이라 IDOS 는 k/N 유리수로 N→∞ 에 {n·α} 로 수렴(잔차 O(1/N) 한정, 유한 N 정확등식 아님 — 군집/수렴 검정). 부차 Cantor(영측도) 신호는 **불확정**: 조잡한 간극임계 occupied_fraction 프록시가 N 창에서 비단조(~0.29 플래토, →0 아님) — 판정은 Cantor 프록시에 의존하지 않고 gap-labeling 매칭에만 근거. 박제 `exports/math-spectra/probe4_fibonacci_gaplabeling.json`, RTSC_LEDGER `MATH-SPECTRA-probe4`. M6 종결.

### MATH-SPECTRA probe5 — 치환사슬 gap-labeling 모듈의 **치환-특이성** (M7, 🟢 산술의 집=Perron 데이터·지도 완성 🏁)
- **사전등록(frozen-first, c16·c9, 로컬 무료)**: probe4 의 단일사슬 양성(피보나치 Z+Zα)을 일반화 — 비주기 스펙트럼의 산술이 **cut-and-project(Sturmian) 특이적**인가 아니면 일반 비주기질서의 산물인가? 세 치환사슬로 검정. **예측: gap-label 모듈 생성원 = 치환의 Perron 글자빈도(아벨화 고유값), 비주기성 자체 아님.** (A) silver-mean(A→AAB,B→A) → 자기 고유 모듈 Z+Z(1/√2), 피보나치 Z+Zα 와 별개; (B) period-doubling(A→AB,B→AA; λ=2) → dyadic Z[1/2]; (C) Thue–Morse(A→AB,B→BA; 등길이·비-Sturmian) → 단일 무리회전 모듈로 붕괴 안 함(falsifier). probe4 호핑링·IDOS 간극리더 재사용, numpy `eigvalsh`, N~2048–3363.
- **결과(🟢 ALL PASS)**: (A) silver 8/8 → **Z+Z(1/√2)** 잔차 1.6e-7(최선 단일모듈)·피보나치 1/φ 는 4/8 만(별개 모듈 확정); (B) period-doubling 8/8 → **dyadic k/2ᵐ** 잔차 1.5e-3(무리수 모듈 0–1/8); (C) Thue–Morse 최선 단일무리 4/8 → **단일 무리회전 모듈 아님**, dyadic 8/8(2-adic 계층 — 플래토가 1/3·1/6·dyadic 에 위치). 피보나치 자기검정 8/8 @1/φ(머신 건전).
- **사전등록 정정(c9/d6, 정직)**: 초기 비공식 추측은 silver 생성원을 β=√2−1(은빛비 역수)로 잡았으나 **틀림**(2/8, 잔차 2e-2). 데이터가 정답=**Perron 글자빈도 1/√2** 임을 판정(8/8 @1.6e-7). 검정 대상 **원리**(생성원=Perron 빈도, 치환-특이)는 불변이며 CONFIRMED — 구체 무리수 추측만 틀렸고 틀린추측 열을 감사 대조군으로 보존.
- **정직 판정(🟢 CONFIRMED)**: 비주기 스펙트럼의 산술 구조는 **치환-특이적**(모듈 생성원 = Perron 글자빈도/아벨화), 일반 비주기성의 산물 아님. 각 Sturmian 사슬이 자기 cut-and-project 회전수(=글자빈도)를 운반, 비-Sturmian(period-doubling·Thue–Morse)은 dyadic/계층 산술. **정직 한계**: 유한 PBC 근사(잔차 O(1/N), 군집/수렴 검정); res_tol=0.005 사전등록; period-doubling·TM 플래토는 sub-orbit 으로 1/3·1/6 도 닿음 — 판별 주장(dyadic / 비-단일무리)만 보고, 모든 비-Sturmian 간극의 닫힌형 라벨은 비주장. 박제 `exports/math-spectra/probe5_substitution_gaplabeling.json` + `scripts/scratch/math_spectra/probe5_substitution_gaplabeling.py`, RTSC_LEDGER `MATH-SPECTRA-probe5`. **M7 종결 = where-arithmetic-lives 지도 완성 🏁**.

### MATH-SPECTRA probe3 — 플랫밴드 CLS 중복도의 mod-q / gcd(L,q) 정합성 일반화 (M5, 🔴 정수론 부재 종결·전 플랫밴드족)
- **사전등록(frozen-first, c16·c9, 로컬 무료)**: probe2 의 mod-2 패리티가 고불균형·r:1 격자에서 mod-q / gcd(L,q) 로 일반화되는가? dice/T₃(허브+림), 일반 Lieb-n(n=2,3,4 변 삽입), 장식·세분 checkerboard 를 L×L 주기경계 토러스로 numpy 정확대각화(`eigvalsh`, tol 1e-9), μ(L,n) 산출. **예측: 유계 gcd 정합성(≤q 개 유한상수), 심층 산술 부재(모듈러형식·소수민감성 없음) → 🔴 negative.**
- **결과(정수 수열)**: dice/T₃ μ=[1,4,13,16,25,40,49,64,85,100,121,148] (q_min=3 잔여류 분할, 3류 모두 선두항 L² 공유, 오프셋 {0,0,4} 유계); Lieb-2 μ=[0,2,0,6,…] (q_min=2: 홀 L→0 영모드 없음, 짝 L→2L−2 — **체인길이 n 과 무관한 mod-2**); Lieb-3 μ=L²+2 단일 2차(q_min=1, 정합성 불필요); Lieb-4 μ=[0,2,0,6,…] **Lieb-2 와 동일 mod-2** (a-priori n+1 주기는 지배하지 않음 확인); 장식 checkerboard μ=[2,8,10,16,…] (플랫레벨 −1/+1 교대, q_min=2 양 패리티 4L+{0,−2}).
- **정직 판정(🔴 closed-negative · 전 플랫밴드족 종결)**: 모든 격자에서 μ(L) 은 단일 초등다항식이거나 **최소주기 q_min** 의 잔여류 분할(각 류 동일·소실 선두항의 초등다항식, **유계 상수 오프셋** = L mod q_min 의 주기함수 = gcd(L,q_min) 의 함수). 구별류 ≤ q_min (L-성장 없음), 소수 L 은 일반 coprime-to-q_min 류와 구별 불가(**소수 무신호**). **정직 정정 vs 사전등록**: 지배주기는 격자의 **기하·이분 주기 q_min**(이분체인은 체인길이 무관 2, dice 는 3)이지 순진한 a-priori 체인주기 n+1 이 아님 — mod-q 정합성 **성격은 정확히 예측**, 특정 q 만 기하적. probe2 mod-2 패리티의 일반화일 뿐, 더 깊은 것 없음. **선그래프+이분불균형 전 플랫밴드족의 숨은 정수론 질문 종결.** 박제 `exports/math-spectra/probe3_modq_structure.json`, RTSC_LEDGER `MATH-SPECTRA-probe3`. M5 종결. (재사용: probe2 `build_adjacency` 일반 디스패치·`count_flat`·`_exact_poly`, d19)

### MATH-SPECTRA probe2 — 플랫밴드 CLS 중복도의 정수론 구조 탐색 (M4, 🔴 정수론 부재 + 🟢 정리 검증)
- **사전등록(frozen-first, c16·c9, 로컬 무료)**: kagome/checkerboard/Lieb/pyrochlore 격자를 L×L(×L) 주기경계 토러스로 numpy 인접행렬 정확대각화(`eigvalsh`, tol 1e-9), 플랫레벨 중복도 μ(L) 수열 산출 + 선그래프·Lieb 정리 대조.
- **결과(정수 수열)**: kagome μ=L²+1 (=벌집 base graph 1차 베티수 E−V+1) 단일 2차다항식 — **선그래프 플랫밴드 정리 검증**; pyrochlore μ=2L³+1 (=다이아몬드 base 베티수) 단일 3차다항식 — **3D 검증**; checkerboard μ=L²(홀 L)/L²+1(짝 L), Lieb μ=L²(홀 L)/L²+2(짝 L) — **mod-2 패리티 분할**(Sutherland |N_A−N_B|=L²는 홀 L에서만 성립). 플랫매니폴드↔분산밴드 간격 깨끗(검증).
- **정직 판정(🔴 closed-negative on number theory + 🟢 theorem verified)**: CLS 중복도는 전부 L에 대한 **초등 저차다항식**(차수=격자차원) = 정확한 그래프 불변량(순환공간 차원=베티수 / 이분 부격자 불균형). checkerboard·Lieb은 추가로 **mod-2 commensurability** 보정항(짝 L 토러스에 확장상태 +1~2개)을 가지나 이는 **초등(경계/정합)**이지 산술이 아님 — 나눗셈/모듈러형식/소수분포 구조 없음, 소수 L과 일반 홀수 L 구별 불가. **숨은 정수론 없음**. 박제 `exports/math-spectra/probe2_cls_multiplicity.json`, RTSC_LEDGER `MATH-SPECTRA-probe2`. M4 종결.

### MATH-SPECTRA 도메인 신설 — 스펙트럼 보편성 probe (ζ영점 ↔ 플랫밴드) + ScH9 정직 종결
- **신규 도메인 `domains/MATH-SPECTRA.md`** ("스펙트럼 탐정") — 수학·물리 교차 스펙트럼 패턴을 자체 수치탐색·검증. 매니페스트-only(d4). 사용자 요청(리만가설 동위선상 일자배치류 자체 수학 탐색)으로 신설, RTSC와 **병렬 트랙**.
- **probe 1 (사전등록·frozen-first, c16·c9, 로컬 무료)**: ζ영점 vs 플랫밴드 인접행렬 스펙트럼.
  - H1 ✅ ζ영점 임계선 위(max|Re−½|=0.00, 수치) — "동위선상 일자배치" 재현.
  - H2 ✅ ζ영점 간격 = GUE (KS 0.058 ≪ Poisson 0.340; GUE 대조군 0.033으로 파이프라인 검증) — 몽고메리-오들리츠코 재현(검증용, c2).
  - H3 ✅ 카고메 = 플랫밴드 정확히 1/3(=0.333 이론) 델타 DOS + 분산부 Poisson(적분가능, KS 0.118).
  - **정직 판정(🔴 closed-negative)**: "RH영점 = 우리 격자 스펙트럼" 순진한 다리 **거짓** — ζ는 카오스(GUE), 주기 플랫밴드 격자는 적분가능. RH/힐베르트-폴리아 다리는 카오스 연산자 필요. → M4 신규질문: 플랫밴드 CLS 중복도의 정수론 구조. 박제 `exports/math-spectra/probe1_spectral_universality.json`.
- **ScH9 DFPT 정직 종결(🔴)**: el-ph가 q6에서 크래시(STOP 1, 5/8q만) — q6 음향모드 허수(−16 cm⁻¹) = under-relaxed/동역학 불안정 셀 → 물리적 λ/Tc 없음. YH6/MgH6과 같은 수소화물 벽(ARCHITECTURE 기록). 돌파경로(c16): target-P tight vc-relax → matdyn asr 안정성 사전검사 → 허수모드 0 확인 후 el-ph 재발사. 파드는 RbOs2O6 동거로 유지.

### RTSC 삼각측량 v4 — 그래프-위상 후보 생성기 (화학 추측 → 정리 기반) + Lieb↔cuprate 다리
- **교차도메인 동형 통찰**: 플랫밴드-at-E_F는 "물질의 성질"이 아니라 **그래프(연결망)의 성질** — 두 정리가 후보를 *보장*한다. (1) **선그래프 정리**: L(G)는 −2t에 플랫밴드를 반드시 가짐 (카고메=L(벌집)·파이로클로=L(다이아몬드)·체커보드=L(정사각)). (2) **이분 부격자 불균형(Lieb-Sutherland)**: |N_A−N_B| 개의 영에너지 플랫밴드 (Lieb·dice/T3). 같은 고유값 문제가 광결정·냉원자·LC회로·역학메타·휘켈MO(유기 폴리라디칼·삼각글렌·지그재그 그래핀)에 동일 출현.
- **후보 생성 전환**: 화학 추측 → 정리 enumeration + 두 직교 스크린(ΔE~0 AND 비자성)으로 거름. `scripts/scratch/flatband_graph_topology_candidates.py`.
- **역방향 일관성 검증(c9)**: 파이로클로 RbOs2O6는 ΔE~0(정리 정확)이고 탈락은 *자성 축*뿐 → 위상 생성기는 플랫밴드를 정확히 주고 자성은 별개 스크린(CeCo3B2 d⁷ 승자들이 통과한 같은 두 관문).
- **Lieb↔cuprate 다리**: Lieb 격자 = CuO₂면 위상동형 → 플랫밴드 트랙과 기존 고온초전도가 한 그래프에서 만남. 첫 위상 게이트체크 = **Os-O Lieb 평면**(4d/5d로 3d-자성 회피) summer에 QUEUED(vc-relax 코어 비면 자동 시작, 자체로깅). LaOs3Si2 GREEN vc-relax 확정도 진행 중.
- 박제: RTSC_LEDGER TRIANGULATE-V4(74행) + 생성기 스크립트 + Lieb 덱(`sib_work/lieb_oso2/`).

### RTSC 위상 게이트체크 — CHECKERBOARD 격자 (선그래프 L(정사각) = 2D 파이로클로/카고메 사촌) BUILT + QUEUED
- **위상**: 체커보드 = 정사각격자의 **선그래프** L(square) = 카고메(L(벌집))의 2D 사촌(2D 파이로클로). 정리-1 선그래프 플랫밴드 — CLS는 정사각 plaquette 위, −2t. Lieb 덱(이분 정리-2)에 이어 같은 lane 라운드 2의 **선그래프 트랙** 첫 미검증 위상.
- **실현(Os-O 평면)**: 선그래프 사이트 = 정사각격자 결합 중점 → Os 두 부격자를 모서리 중심 `(1/2,0,0)`·`(0,1/2,0)`에, O 가교 리간드를 코너 `(0,0,0)`·셀중심 `(1/2,1/2,0)`에 (교차 plaquette 결합 = 체커보드 구분점). 4원자/셀(2 Os + 2 O). **비자성-안정 5d Os** 선택(3d Co/Fe 자성 회피, 카고메·Lieb Os-O와 동일 논리) — `Os/O_ONCV_PBE_sr.upf` SG15 재사용(fetch 없음).
- **덱**: Lieb 덱 정확 미러 — `ibrav=6`, a≈3.80Å, 큰 c 진공(2D), `ecutwfc=80/ecutrho=320`, `12×12×1`, `nspin=2`, MP smear. **screen-first: scf+bands만, vc-relax 없음**(GREEN시에만 승격, 카고메/Lieb 형제와 동일). verbosity='high'(#k≥100 per-k 고유값 필수). 게이트: ΔE~0(|ΔE|<0.10 GREEN) AND 비자성(m<0.5).
- **정직 caveat(🟠)**: 이상화 고정 기하(Os-O=1.9Å, 무이완) → ΔE 근사. 1st-pass 위상 DESIGN 게이트(선그래프 플랫밴드가 비자성 5d 실현에서 E_F에 오나?), 상온예측 아님.
- **머신 부하 가드(d_qforge_parallel·d7)**: summer 6코어가 LaOs3Si2 vc-relax 실행 중 + Lieb 게이트 대기열. fire 스크립트는 **vc-relax DONE AND Lieb DONE AND `pgrep pw.x==0`** 까지 30초 폴링(~6h) 후 시작 — 대기열 3번째(vc-relax→Lieb→checkerboard), 오버서브스크립션 없음. detached setsid, 자체로깅 `~/checkerboard.log`.
- 산출물: `scripts/scratch/qforge_harvest/checkerboard_fire.sh`(가드 fire) + `checkerboard_deck_note.md` + summer `~/sib_work/checkerboard_oso2/`(덱 구문검증 통과, d16).

### RTSC no-cooling flat-band — CeCo3B2형 형제 게이트체크 (LaOs3Si2 🟢 / LaRh3Si2 🔴) + summer 디스크 38G 회수
- **삼각측량 v3 레인 검증**: 도핑축 죽음 후 연 "CeCo3B2형 R-T₃-X₂ 4d/5d-kagome 패밀리 스윕"의 첫 형제 2개를 **무료 summer 풀**에서 게이트체크(고정 LaRu3Si2 격자·치환만·1차 스크린, c9 근사 caveat).
  - **LaOs3Si2 (Os 5d⁷) 🟢 GATE PASS** — ΔE=+0.039 eV(E_F 위 39 meV) AND m=0.00 μB. **2번째 플랫밴드-at-E_F 승자**(LaRu3Si2 ΔE=−0.055 다음), 5d가 4d만큼 작동하고 |ΔE|는 오히려 더 작음. → per-sibling vc-relax + DFPT 승격 대상.
  - **LaRh3Si2 (Rh 4d⁸) 🔴 FALSIFY** — ΔE=+0.260 eV(>0.2) m=0.00. d⁸(전자 +1)이 E_F를 분산 매니폴드로 밀어올려 플랫밴드가 +0.26 eV 위로. **채움축 bracket 확정: d⁷=승자, d⁸=overshoot** → d-count가 화학 레버(v3 확증).
  - 박제: `exports/rtsc/cosn_sibling_gatecheck.json` + RTSC_LEDGER 2행(73행) + 증거 `scripts/scratch/qforge_harvest/sibling_gatecheck/`.
- **근본수정 3단(c1·c16)**: bands 고유값 stdout 누락 — disk_io=none(헛다리)·깨끗한 bands(헛다리) 거쳐 **진짜 원인 = QE의 "k점 ≥100이면 verbosity=high 없이 고유값 출력 생략"** 발견 → `verbosity='high'` 주입. + setsid detach 로그유실은 스크립트 **자체 로깅(`exec >> log`)**으로 해결. 드라이버 `scripts/scratch/qforge_harvest/fast_bands6.sh`.
- **summer 디스크 정리**: 100%(5.7G)→96%(43G), **누적 38G 회수**. 내 RTSC 컴퓨트 스크래치의 QE 파동함수 out/(재생성 가능)만 삭제(.out/.in 증거 보존) + pycache/재생성 캐시. 타 캠페인(anima 310G·bg 148G·rbfe 138G) 미터치(cross-project 보호).

### SENOLYX ABFE — 운영자(드라이버) 실수 방지 (demi 7-verb · probe.sh + 런북 + 메모리)
- 캠페인을 모는 동안 반복한 **에이전트-측 운영 실수 5종**(D1~D5)을 근본 차단. F1~F10이 컴퓨트 파이프라인이라면 이건 드라이버 워크플로우.
- **`probe.sh <manifest> <workdir>` 신규** — heredoc-fed 루프 + ssh `</dev/null` + 명시 필드분리 + bash-3.2 호환. 손으로 짠 `while read`+ssh 루프가 매번 (a)stdin 잠식→첫 pod만 (b)`set -- $hp` arg-split (c)`mapfile` 부재로 깨지던 것 차단. R13 9셀 전수 폴링으로 검증(c2).
- 런북(round13 README "운영자 실수 방지"): D2 Read前Edit · D3 commit前pr-cycle · D4 leg가 K회 결정론적 abort 시 무한retry 금지(다른 pod 재발사 OR n−1 수용; R13 MCL1:0이 solvent서 4회+ 결정론 사망) · D5 watcher 코드 머지 후 재시작 필요.
- 메모리 `senolyx-abfe-ops-gotchas` 등재(cross-session 차단).

### SENOLYX R12(HSP90) — 🧱 close-negative 확정 종결 (K=5 ensemble 10/10)
- R12 RBFE + R12-GOLD 마일스톤 CLOSED-NEGATIVE flip. K=5 ensemble 10/10 완주: ΔΔG=+3.13±2.83 (exp −1.9, |err|=5.03, 부호 반대 FAIL). ensemble 평균화로도 sign 불변 → R10b(절대 overbind)·R11(기계론 FF결함)·R12(상대 RBFE) 3개 독립라인이 "거대고리 안사마이신엔 범용 FF 부적합" 확증 (tune-to-green 불가, c9/d6 정직 terminal).
- vast 6-pod 회수(결과 seen.prog 10/10 + RESULT_FINAL_10of10.txt 보존 후 destroy, 비용정지). R13 후보검증(MCL1 양성 유지)만 open으로 잔존.

### RTSC no-cooling — 삼각측량 v3 (2축 분리): 도핑축 죽음 → CeCo3B2-type 4d/5d-kagome 패밀리가 새 lane
- **삼각측량 v3 — 화학/격자축 vs 도핑축 데이터 분리** (`scripts/scratch/triangulate_flatband_dE_v3.py`, 로컬 분석): 실측 5점(CsV3Sb5 +0.92 / RbOs2O6 0 / CoSn −0.44 / MoSn −2.38 / LaRu3Si2 −0.055) + CoSn 도핑 곡선 2개로 두 축을 분리.
  - **도핑축 = 실측으로 죽음**: CoSn 전자(−0.23)·정공(−0.165 eV/carrier) 둘 다 flat band을 더 깊게(잘못된 방향) → "CoSn 도핑해 E_F 맞추기" CLOSED. v2의 도핑-다이얼 전제 반증.
  - **화학/격자축 = 진짜 레버**: ΔE 범위 3.30 eV(CsV3Sb5..MoSn, 도핑축의 ~30배). ΔE~0은 도핑이 아니라 **올바른 원소+격자 선택**으로만 달성.
  - **유일 비자성 ΔE~0 = LaRu3Si2** (CeCo3B2-type Ru-kagome). 모든 🔴와의 구별점: 4d(3d 아님) TM + CeCo3B2 stacking(CoSn-type·pyrochlore 아님).
- **새 no-cooling lane**: "CoSn 도핑"(CLOSED)을 **"CeCo3B2-type R-T₃-X₂ 4d/5d-kagome 패밀리 스윕"**으로 교체 — LaRu3Si2 형제(LaRu3B2 · YRu3Si2 · LaOs3Si2 · LaRh3Si2), 각각 실제 게이트체크(날조 ΔE 없음, v2 교훈 적용). DESIGN 게이트지 room-temp 아님(LaRu3Si2 Tc~7K), 형제는 explore-not-promised.

### RTSC no-cooling — 정공도핑 CoSn 🔴 FALSIFY → CoSn rigid-doping 양방향 CLOSED (dead-end 확정)
- **정공도핑 CoSn flat-band 정렬 게이트체크 🔴 FALSIFY** (4점 tot_charge 양수 jellium scan, summer 무료풀 -np6, $0): 정공도핑이 E_F를 내리지만(~−0.06 eV/+0.2홀) **kagome flat band이 더 빨리 내려가** ΔE = E_flat − E_F가 오히려 더 깊어짐 — −0.445(control) → −0.481 → −0.512 → −0.544 eV (slope ~−0.165 eV/hole). flat band이 E_F에서 **멀어짐**. 게다가 자성 단조 상승 0.09→0.33→0.48→0.63 μB(~+0.45홀에서 게이트 0.5 돌파).
- **CoSn rigid-doping 양방향 CLOSED**: 전자도핑(−0.445→−0.585, −0.23 eV/e⁻)과 정공도핑(−0.165 eV/hole) **둘 다 flat band을 더 깊게** 민다. 이전 전자도핑 행이 추천한 정공 각도(c16 돌파)를 진짜로 시도 → 정직한 terminal 벽. **원인**: CoSn kagome flat band은 Co-3d manifold에 묶여 rigid 도핑이 E_F를 움직여도 d-유래 flat band이 함께(더 깊게) 따라가, 도핑으로 flat band을 독립적으로 E_F에 올릴 수 없음. "CoSn을 도핑해 E_F에 맞춘다" 축 전체 CLOSED.
- **대조 검증**: Δp=0 control이 미도핑 CoSn ΔE=−0.445/m=0.09 정확 재현(band-44 검출 파서 `parse_flatband_dE.py`가 4자리까지 일치) → 셋업·파서 검증, 반증 신뢰 가능(tune-to-green 없음). 박제 `exports/rtsc/cosn_hdope_gatecheck.json` + `scripts/scratch/qforge_harvest/cosn_hdope/`.
- **인프라**: 재사용 vast 파드(load 507 과점유 junk 호스트)에서 SCF 19분 무진전 → d7대로 작은 셀(6원자)을 무료 로컬풀 summer로 이전(1iter 1분20초). junk 파드 41001569 파괴(cah10/srh10 vcrelax 보존 후). 캠페인 표준 lead = **LaRu3Si2 🟢 (DFPT λ/Tc q=3 in flight)**.

### SENOLYX — vast 재가동 + R12 ensemble + R13 후보 전수 ABFE (🟢 MCL-1/S63845 결합 계산 확증)
- **B4(PTX-222) 근본해결** — conda `cuda-version=12.6` 선핀(host CUDA 13.0 < conda기본 13.3 충돌이 원인)으로 vast RTX_4090 다중 pod 가동. 이전 "vast 비가용·summer 단독" 가정 무효화.
- **R12(HSP90) K=5 ensemble 재가동** — bistability 평균화. 잠정 ΔΔG≈+2.3 (exp −1.9, 부호 ❌) → ensemble로도 안 뒤집힘 = R10b·R11 "거대고리 범용FF 부적합" **확증 방향**(close-negative 수렴중, 17AAG 완료시 확정).
- **R13 신설 — 후보 전수 ABFE 검증**: 일반화 deck `abfe_cand.py`(TARGET→수용체/리간드/포켓) + co-crystal 실측 bound-pose(`extract_pose.py`, rdkit). 🟢 **MCL-1/S63845 ABFE=−14.18±1.67 (n=2/3) vs 실험 ~−13 → |err|~1.2 일치 = 후보 결합력 첫 계산 확증**(일반약물형이라 ABFE 신뢰가능). BCLXL(3CQ NaN충돌→bound-pose fix)·CRBN 진행중.
- **재사용 ABFE 하니스 10-실패모드 하드닝** (PR #631 6모드 + #637 F7~F10) — SSOT=`exports/SENOLYX/round13-abfe-allcand/README.md`. 도메인 SSOT(SENOLYX.md/.log.md) 현행화. campaign 무인 가동중(watcher 2개).

### RTSC — 전자도핑 CoSn 정렬 검증 🔴 FALSIFY (방향 반증 + 정공도핑 새 각도)
- **삼각측량 v2 1순위 CLOSED-negative(정렬축)** — CoSn `tot_charge` jellium 도핑 스캔(Δn=0/0.2/0.4/0.6, 4점 SCF 전부 수렴, vast 32-core $0.35). Control Δn=0이 CoSn −0.445 eV 정확 재현(셋업 검증 ✅). **실측: 전자도핑이 flat band를 E_F에서 더 깊게**(−0.44→−0.59 eV, slope −0.23 eV/e⁻) — rigid-band 예측(+0.97 eV/d-e)과 **반대 방향**. N=2 CoSn-vs-MoSn 기울기가 d-밴드중심 화학과 전자수를 혼동 → 도핑 다이얼로는 반증. |ΔE|<0.10 도핑점 없음.
- **부분 성공 + 새 각도(c16)** — 자성은 통과(m 0.09→0.00 by Δn=0.2, 전자도핑이 CoSn itinerant 자성 제거 ✅, 일석이조의 한 마리). 데이터가 명확히 시사: **정공(hole)도핑**(tot_charge=+)이면 E_F를 flat band 쪽으로 내림 → CoSn 폐기 전 싼 2점 정공 스캔이 다음 각도. caveat: jellium=rigid-band-with-screening proxy(실 dopant 아님)지만 단조 wrong-direction이 명확해 substitutional 확인 불요. 박제 `exports/rtsc/cosn_edope_gatecheck.json` + deck + `RTSC_LEDGER.jsonl` CoSn-edope FALSIFIED.

### SENOLYX — ABFE 하니스 추가 4-실패모드(F7~F10) 하드닝 (라이브 캠페인 무중단)
- **대상** — `exports/SENOLYX/round13-abfe-allcand/` (+ `round12-rbfe/` 의 watch.sh/harvest.sh). PR #631이 막은 6개 너머, 24h 무인 캠페인의 ④analyze가 발굴한 **추가 4개 실패모드**를 근본 차단(c1). 코드/문서 전용 — 새 pod 렌트 0, 가동중 11 pod + watcher 2개(watch.sh PID 49500 · watch_cand.sh PID 18186) 무중단. live watcher가 매 폴 새로 실행하는 watch*.sh/harvest*.sh는 편집 후 `bash -n` + harvest 라이브 dry-run(여전히 `done_cells=N/9` 집계)으로 무파손 확인.
- **F7 단일 발사 entry** — `fire_cell.sh <r12\|r13> <CELL...>` 신규 = production 셀 발사/재개의 **유일 sanctioned 경로**. manifest에서 셀→pod 해석 후 retry-resume 러너(`runcells_*.sh`)로만 발사(≤4회 재시도·per-rep `.nc` 재개). 근본원인=발사경로 2개(러너 vs 수동 `python &`)였고 수동분(17AG/0·MCL1:0)이 "terminate called" minimize abort에 영구 사망. bare `python &` 금지를 README+헤더 주석에 명시.
- **F8 watcher 자동 재무장** — `watch_cand.sh`/`watch.sh`가 고정 poll cap 대신 "전 셀 done OR 무진행 `STALL_HOURS`(기본 12h)"까지 지속, per-arm 예산 만료 시 셀 미완이면 **자가 재실행**(`exec "$0" "$@"`). R12 watch.sh가 7.5h에 self-exit해 무감시로 돌던 사고 차단. 진짜 완주/stall 시 clean exit.
- **F9 harvest 영속 병합** — `harvest_cand.sh`·`round12-rbfe/harvest.sh`가 매 폴 truncate하던 것을 폐기하고, 관측한 `ENS_RESULT`를 영속 store `seen.prog`에 **append-merge(절대 truncate 안 함)** 후 거기서 집계. transient SSH blip이 완료셀 카운트를 깎던 사고(관측 5→4) 차단 — 카운트가 monotone 비감소가 되어 watcher가 최종 N/N에 반드시 도달. dedup keep-last(재개 rep의 최신 ENS_RESULT 우선)는 python에 유지.
- **F10 완주 시 auto-down** — watcher가 전 셀 done(harvest exit 0) 확인 시 결과 보존 후 `recover.sh reap --apply` 자동 호출(비용정지). 안전장치: **확정 완주에만** 발동(부분/blip 절대 금지), reap는 두 manifest에 모두 없는 `senolyx-*` orphan만 destroy — RTSC(41001569)+manifest pod 절대 불일치(기존 reap 가드 검증).
- **문서** — README 발사규약(fire_cell.sh 유일 경로)+10-방지표(6+F7~F10), ARCHITECTURE round13 줄 6→10 방지 갱신.

### RTSC — 🟢 LaRu3Si2 flat-band 게이트 PASS (캠페인 최초 통과 · 방법론 검증)
- **🟢 GATE PASS (사전등록 게이트, goalpost 이동 없음 c9)** — 폴백 #1 LaRu3Si2(Ru-kagome, CeCo3B2-유도)가 **두 조건 동시 통과**: 실측 **ΔE_flatband=−0.055 eV**(55 meV, <0.10 게이트) + **m=0.00 μB**(start_mag 1.54→0 붕괴 = 진짜 비자성, <0.5 게이트). vc-relax a=5.7175Å c=3.5732Å(실험 +0.7%), E_total=−645.935 Ry(20-iter 2.5e-11), Ru-4d kagome flat band(band34, 면내 대역폭 0.365 eV) mean 16.0115 eV vs E_F 16.0669 eV. **CoSn(−0.44+자성)·CsV3Sb5(+0.92)·MoSn(−2.38) 세 실패모드를 처음으로 동시 격파** + 실측 Tc=7K 실존 SC. 비용 $0.30(vast RTX4090 #41060369 전용코어, GPU-QE 부재→CPU 가속 정직 caveat), 포드 down, vast#1 무영향.
- **정직 프레이밍(c9)** — 이 🟢는 **flat-band-at-E_F "설계 게이트"** 통과(설계 가능성 입증)지, **상온 달성 아님**(Tc=7K는 극저온). 의미 = ① 게이트 방법론이 작동(실패 4 거른 뒤 진짜 통과 1) ② flat-band SC 실존 anchor 확보 → DFPT로 "flat band→coupling→Tc" 사슬 정량검증 발판 ③ 도핑/압력으로 Tc 끌어올릴 설계 출발점. 문헌(arXiv) Ru-dz² +0.1eV 위 vs 본 relaxed-PBE 55meV 아래 — 부호 다름·크기 일치(둘 다 |ΔE|<0.1).
- **다음** — LaRu3Si2 → DFPT el-ph(λ/Tc) 승격(측정 Tc=7K + 모드선택 kagome-phonon 재현). 박제 `exports/rtsc/decks/laru3si2/`(검증 deck, La/Ru/Si SG15 ONCV) + `exports/rtsc/laru3si2_flatband_gatecheck.json` + `RTSC_LEDGER.jsonl` GATE_PASS + `scripts/scratch/qforge_harvest/laru3si2/`.

## 2026-06-15

### 거버넌스 — d_qforge_fix 추가 (QFORGE upstream fix: 즉시해결 우선 · 장기 시 QE 병행)
- **CLAUDE.md `## 거버넌스`** 에 `d_qforge_fix` 신설(`d_qforge_parallel` 뒤): QFORGE upstream fix/개선이 **바로 해결 가능하면 즉시 고치고 진행**, **오래 걸리면 QE로 대체해 캠페인을 계속 전진시키되 QFORGE fix도 바로 함께(병행) 진행**(둘 동시). QE 대체는 임시우회가 아닌 정직한 production reference(migration gate 일관). 금지: fix 길다고 멈춤·QE만 하고 fix 미뤄 잊기·바로 고칠 걸 우회로 덮기.

### SENOLYX — 재사용 ABFE 하니스 6-실패모드 하드닝 (라이브 캠페인 무중단)
- **대상** — `exports/SENOLYX/round13-abfe-allcand/` (재사용 ABFE GPU fan-out 하니스). R12(HSP90)/R13(후보) 라이브 캠페인에서 **실측으로 터진 6개 실패모드**를 근본 차단(c1). 코드/문서 전용 — 새 pod 렌트 0, 가동중 11 pod + watcher 무중단.
- **① bound-pose 기본화** — `abfe_cand.py`가 clash-free 공결정 bound pose `lig_<RESN>_bound.sdf`(extract_pose.py 산출, ideal 컨포머 대신)를 우선 사용 + bound일 땐 recenter 생략(좁은 그루브 포켓 NaN 차단). **전 3타깃 bound SDF 생성**(3CQ/70R/EF2) — summer `fep` env(rdkit 2025.09.5)에서 extract_pose.py 실행해 로컬 적재(전부 BOUND_OK). SDF 부재 시 ideal+centroid graceful fallback.
- **② harvest stdin 보호** — `harvest_cand.sh`·`round12-rbfe/harvest.sh`의 `while read`+ssh 루프에 `</dev/null` 유지 + WHY 주석(ssh가 루프 stdin pipe를 삼켜 첫 pod만 집계되던 버그).
- **③ fanout copy-verify** — `fanout_cand.sh`(+ `fanout_ens.sh`)가 copy-to 후 ssh `test -f`로 원격 존재 확인, 재시도≤3, 필수파일 누락이면 그 pod **발사 abort + manifest에 COPY_FAIL**(doomed runcells 방지).
- **④ retry-resume 전용** — `runcells_cand.sh` 상단에 "production cell은 이 retry-resume 래퍼 경유 필수, 맨 `python &` 금지"(R12 17AG/0 수동셀 死의 원인) 명시. 래퍼는 ≤4회 재시도하며 per-rep `.nc`에서 resume.
- **⑤ ssh-blip alive-gate ⑥ orphan reap** — 신규 `recover.sh`: `alive <host> <port> <id>`=ssh실패 시 `hexa cloud alive`로 RUNNING 확인(GONE/STOPPED만 死 판정·blip은 무동작) · `reap [--apply]`=두 manifest(ens_pods.tsv/cand_pods.tsv)에 없는 `senolyx-*` 소유 live pod만 리포트/destroy(RTSC 41001569·manifest pod 절대 불가). dry-run 검증: 11 manifest pod 전부 보호, orphan 0.
- **검증(c2)** — 6 @L assert 전부 grep PASS · `harvest_cand.sh` 정상 집계(0/9, 라이브 watcher와 일치=셀 진행중) · live 13 vast pod 무중단 · 박제 `README.md`(SSOT) + `ARCHITECTURE.md` 등재.

### RTSC — 삼각측량 v2 (실측 ΔE 기반): 전자도핑 CoSn = 데이터 기반 신규 리드
- **데이터 기반 재삼각측량** — 이번 세션 누적 **실측 flat-band ΔE**(CsV3Sb5 +0.92·V3d³ / RbOs2O6 ~0·Os5d⁶자성 / CoSn −0.44·Co3d⁷자성 / MoSn −2.38·Mo4d⁵비자성)로 CoSn-type 같은구조 rigid-band 기울기 산출 = **+0.97 eV/d-전자**(d-전자↑ → flat band이 E_F로 상승). **1순위 = 전자도핑 CoSn(~0.4 e⁻/f.u.)** → 예측 ΔE≈−0.05eV(E_F 정렬) + 같은 도핑이 CoSn 약한 itinerant 자성(원래 블로커)도 억제 가능 = **일석이조**. 막연한 신규탐색을 **기보유 CoSn deck의 도핑 다이얼**로 전환. caveat(c9): N=2 같은구조 기울기라 정확한 x는 실제 도핑 scf 스캔 확정 — closed 아님, c16 돌파 각도. 박제 `scripts/scratch/triangulate_flatband_dE_v2.py` + `RTSC_LEDGER.jsonl`.

### RTSC — MoSn flat-band 게이트체크 종결: 벽 돌파 후 🔴 FALSIFY (CLOSED-negative)
- **벽 돌파 + 게이트 종결 🔴 FALSIFY** — Mo-4d PW 벽을 vast 전용코어 포드(RTX 4090 #41056723, 128 core, ~6s/iter = summer 무료코어 대비 >150× — 단 conda-forge QE에 CUDA 빌드 없어 GPU offload 아닌 전용-CPU 가속, 정직 caveat)로 돌파. **실측(fit 없음)**: 자성 **m=0.00 μB**(Co→Mo가 CoSn 자성 제거, 3.96→0 수렴 = 가설대로 PASS 절반) · **ΔE_flatband=−2.38 eV**(Mo-4d kagome flat band 36-38이 E_F보다 2.4 eV 아래, E_F=15.642 eV, 16-iter 2.5e-11 Ry 수렴). |ΔE|=2.38≫0.2 eV → **게이트 FALSIFY**. 통찰: Co→Mo(4d⁵<3d⁷)가 자성은 죽였지만 flat band를 CoSn(−0.44)보다 **더 깊이** 밀어냄 — kagome에서 flat band를 E_F로 올리려면 d-전자 증가/전자도핑 필요(반대 방향). 비용 $0.12, 포드 down, vast#1 무영향. 폴백→LaRu3Si2.

### RTSC — MoSn flat-band 게이트체크: 격자 확보 · 측정은 Mo-4d PW 벽 (🟡 PENDING→위에서 종결)
- **격자 확보 ✅** — MoSn(CoSn-type, Co→Mo)을 vc-relax: **a=5.606 Å, c/a=0.848**(BFGS 수렴, 엔탈피 −773.357 Ry). CoSn(5.279 Å)보다 a 6%↑ = Mo 금속반경 1.39 Å>Co 1.25 Å 일관 → CoSn-type 셀에서 **안정 완화**(좋은 신호). pseudo: SG15 ONCV PBE-1.2 Mo(z=14 semicore)+Sn. d16 free dry-run PASS.
- **게이트 측정 차단 🟡 PENDING** — flat-band ΔE + 자성 m은 nspin=2 ecut90/360 SCF 필요한데 summer 무료코어에서 **>16분/iter**(84 e⁻·Mo-4d·50k×2spin, 4-config 재현) = 문서화된 CoSn Co-3d PW 벽과 동류. ΔE·m **미측정** → 날조 없이 honest PENDING(green/red 아님, c9/d6). 무료 SCF는 summer에서 계속 grinding(완료 워처 무장).
- **돌파(d2/d7)** — ① ecut90 nspin=2 SCF용 GPU davidson pod(dense-k 전이금속→GPU) · ② 저-ecut 진단 SCF로 m-부호+E_F 빠르게 · ③ summer 무료런 완주 대기. 박제 `exports/rtsc/decks/mosn/`(검증된 deck) + `exports/rtsc/mosn_flatband_gatecheck.json` + `RTSC_LEDGER.jsonl` MoSn 행.

### QFORGE — engine현행화 + QE↔QFORGE 정직 분담 cross-val
- **honest division** — 이번 RTSC 세션의 全 production DFT(RbOs2O6 자성·ScH9/MgH6/ScH6/YH6 DFPT·CsOs2O6·CaH10/SrH10)는 **QE(Quantum ESPRESSO)로만** 실행 — QFORGE migration gate HELD. QE = production reference, QFORGE = canonical-engine(게이트 후 absorbed).
- **hybrid assembler g5 RE-verify ✅ PASS** — CaH6 QE|g|² → QFORGE L3 어셈블러(`stdlib/qforge/assembler.hexa`, `qforge_cah6_qe_xval_test`): λ_QFORGE=8.51682640 vs QE λ_BZ=8.516825, **rel-ε=1.647e-7 ≤1% gate**(LaH10 4.74e-7 corroborate) = 어셈블러 즉시-사용 gate-grade 재확인.
- **QFORGE-LSDA 자성 cross-val ⏸ HONEST-SKIP** — RbOs2O6/CsOs2O6 nspin=2 SCF 목표(QE ~3-5μB / ~1.8μB 재현?). spin-DFT brick(V_xc·E_F·smearing·spin-GGA) g5 全PASS 이나 실 모먼트 SCF는 Os-5d high-ecut PW compute-wall(9-atom·ecut 70/560 Ry·77 val e⁻ ≥ CoSn Co-3d wall) → mini 강제 시 intractable/spurious m≈0 → QE-production/QFORGE-gated, 날조 0(c9).
- **from-scratch 차폐정점 R8(GGA f_xc) status-only** — COMPLETE·CLOSED-NEGATIVE(λ_GGA=3.41256, rel-ε 22.02%; Δλ vs ALDA −0.00257 무차이) → DFT f_xc 레버 소진, 모드(c) 트랙 HELD.
- **YH6 QFORGE-L3 harvest (실물 end-to-end 실증) 🔴 CLOSED-NEGATIVE(데이터 월)** — 완주한 QE DFPT(4 q-pt Γ+3X, q-weight [1,3,3,1] W=8, N(E_F)=7.2705 st/spin/Ry/cell)를 canonical QFORGE L3 어셈블러로 harvest. **엔진 무결 입증** — per-mode λ 재구성이 QE 인쇄값을 rel-ε~1e-5로 재현(q1 mode15 4.66486 vs QE 4.6649) → canonical 엔진이 실물 QE el-ph 데이터로 처음 end-to-end 작동(migration-gate 관련 마일스톤). **벽 = 입력 셀(엔진 아님)**: (1) 84모드 중 44개 허수(ω²<0, 최저 −1618 cm⁻¹) → Eliashberg 미정의, (2) Γ-acoustic 1/ω² 발산(ASR 미적용, QE가 `********` 오버플로). 조립값 λ~5e10·Tc~16만K 전부 비물리 — 문헌 224K에 fit 안 함, verbatim 기록(c9/d6). **돌파(d2)**: Im-3m YH6를 166 GPa에서 tight vc-relax + `matdyn asr='crystal'` 후 DFPT 재발사 → 허수모드 소거 기대. 산출물 `exports/rtsc/qforge_yh6_harvest.json` + `scripts/scratch/qforge_harvest/yh6/QFORGE_HARVEST.md`.
- **MgH6 안정성 점검 + 함대 진단(근본원인) 🔴 CLOSED-NEGATIVE → PROCESS-FIX** — YH6 harvest가 표면화한 문제를 MgH6에서 확정: 두 Im-3m 고압 하이드라이드 DFPT가 **동역학 불안정 셀**로 발사됨(YH6 hard 허수모드 41개 min −1618 cm⁻¹; MgH6 34개 min −1554 cm⁻¹ — 음향 아닌 진짜 광학 불안정). 앞선 "naive λ가 Γ-발산에 오염"은 더 깊은 문제(셀 자체 불안정)를 가리고 있었음. **근본원인(c1)**: triangulate 고압 하이드라이드 deck이 미완화 발사. **FIX**(향후 全 고압 하이드라이드 deck): ① 목표압에서 tight vc-relax(force 1e-4·stress 0.5 kbar), ② el-ph 생산런 前 포논 동역학 안정성 사전점검(`matdyn asr='crystal'`, 허수모드 0 확인), ③ 그 후 ≥4×4×4-q. ScH9(진행중) 완주 시 동일 점검. 증거 `scripts/scratch/qforge_harvest/{yh6,mgh6}/*_freqs_cm1.txt`.
- **박제** — `QFORGE/QFORGE.md` §⭐ENGINE STATUS(모드 d 자성 추가 + §📅 2026-06-15 cross-val) · `domains/QFORGE-SYSTEM.md` engine-status note · `domains/rtsc.{md,log.md}` 정직 분담 cross-link · `.verdicts/qforge-xval/{cah6-assembler-reverify,rbos2o6-mag}/` · `RTSC_LEDGER.jsonl` cross-val 주석.

### RTSC — flat-band-at-E_F 신규 후보 발굴 (d18 discovery round-1)
- **목표** — no-cooling/앰비언트 flat-band SC: flat band가 **E_F에 정확히**(|ΔE|<0.1eV) + **비자성** + 앰비언트 안정인 host 발굴 = 캠페인의 확정된 두 실패모드(ΔE-오프셋: CoSn −0.44/CsV3Sb5 +0.92; 경쟁자성: RbOs2O6 robust ~3-5μB) 동시 돌파.
- **7 후보 (전부 실인용 또는 speculation-fence, c9)** — top-3: **① MoSn**(kagome CoSn-type, 비자성+FB-near-EF 예측, CoSn 가족이라 deck/엔진 기보유) · **② LaRu3Si2**(Ru-kagome 비자성 실측 Tc 7K, set 최고) · **③ LaCoSi**(NOVEL electride ΔE +33meV로 가장 얕음+상자성). 빈 레인 정직보고: Lieb line-graph(앰비언트 intermetallic SC 부재, cold-atom만).
- **MoSn 게이트(falsifiable, 선등록)** — QE/QFORGE scf+bands+projwfc nspin=2(≤9-atom 앰비언트, ecut~65/650, 풀-프리/CPU): **|ΔE|<0.10eV AND m<0.5μB → 🟢 DFPT λ/Tc 승격** / ΔE>0.2eV OR m>0.5μB → 🔴 HfSn→LaRu3Si2→LaCoSi 폴백. 박제 `.discoveries/flatband-at-ef-candidates-20260615.tape` + `RTSC_LEDGER.jsonl` 후보 행.

### RTSC — flat-band pivot + triangulate narrowing + multi-host DFPT sweep
- **RbOs₂O₆ 자성 battery** — anima ideal-PBE ~5μB가 아티팩트인지 검증: SOC(full-rel) ~3-4μB(quench 안 함)·rattling ~2μB·강한rattling ~2-4μB = **PBE robust 자성, static 레버로 제거 불가**(브리프 "SOC가 죽인다" 부분 반증). 비자성 강제 nspin=1 DFPT in-flight = 결정타. decks `exports/rtsc/decks/anima_rbos2o6/scf_{soc,rattle,rattle2,nm}.in`.
- **삼각측량 5-bearing narrowing** — coupling 4-bearing에 상압근접+측정안정성 추가 재랭킹(`scripts/scratch/triangulate_rerank_stability.py`). no-cooling shortlist YH9·CaH6·LaH10·ScH9·YH10·ScH6·YH6(10→7); MgH6·CaH10·SrH10 압력축 추락.
- **micro-exp DFPT 스윕** (`exports/sweep/rtsc-flatband-tri-20260615/`) — ScH9·MgH6·ScH6 DFPT + CsOs2O6 자성 + 재구성 클라스레이트 CaH10·SrH10 vc-relax(둘 다 수렴, isostructural-template 정직태깅). 8 DFT/4 host(vast×2+summer+aiden).
- **RTSC_LEDGER 정합화** — provider-GONE 30잡 running→deferred(d_defer_no_delete) + 발사 6행 추가.

### harness — perfect harness-standard setup (architecture SSOT + CLAUDE.md)

- **`.harness-engine` submodule** bumped to `harness-hardcore` tip (`docs.scopeDirs` support).
- **`ARCHITECTURE.md`** rewritten as the real architecture SSOT (English) — overview, component map, data flow, governance/verify sections (replacing the Korean stub).
- **`CLAUDE.md`** converted from a `project.tape` symlink to a real harness-standard markdown: project blurb + `## Structure` tree (per-node descriptions) + governance summary + `## Harness` section + quick-reference links. `project.tape` preserved as the governance SSOT.
- **`harness.config.json`** tuned — `lockdown.files` (bin/demiurge · cli/demiurge_cli.hexa · web/middleware.ts), added a `docs` block (`architecture`/`log`/`scratchDir`/`scopeDirs:[""]`/`allow`) so single-doc discipline applies to repo-root `.md` only.
- **Root scattered docs** given a one-line SSOT quickref pointer; `DOMAIN_AUDIT.md` allow-listed. `harness docs check` → `docs: ok` (0 quickref / 0 scatter / 0 CLAUDE-MD violations).

## 2026-05-25

### CLI+COCKPIT — LLM 연결 모듈 (D38) + 진행바 정리 + 7-verb 전 도메인 캠페인

- **LLM 연결 모듈** (#88·#89·#93·#95) — Claude · Codex · Gemini 멀티 provider × CLI/API 선택, 설정 모달(⚙), CLI `llm` 서브커맨드(`list[--json] · use · mode · model · key · key-rm · test · ask`). 키 저장 = Keychain + env(`ANTHROPIC_API_KEY`/`OPENAI_API_KEY`/`GEMINI_API_KEY`) 폴백. provider = manifest 데이터, dispatch는 `wireFormat` trait로만 분기(@D d4 generic dispatch, 이름 하드코딩 X). 채팅 `askClaude`는 `LLMBridge.ask`로 위임(호출부 안정, 더는 claude 전용 아님). 모달 ↔ CLI 1:1 패리티(🗑 키 삭제 ⇔ `key-rm`).
- **진행바 macOS 26 glass 박스 제거** (#87) — `.principal` toolbar 아이템에 `.sharedBackgroundVisibility(.hidden)` 적용. 7-step 캡슐만 보이고 라운딩+그림자 박스 사라짐. layout 유지.
- **7-verb 전 도메인 캠페인 — surface @goal 달성 확정** — 21 도메인 × 7-verb 실측: dispatch 21/21 보편 작동(0 crash), production 9 도메인(chip·firmware full 7/7 + sscb·bio·matter·component·cern·aura·chem partial), 미배선 12 (antimatter 등 10 honest-skip + clinical/ufo gap). 미배선 stdlib per-verb 스크립트 = hexa-lang INBOX PR #852 핸드오프(thin per-verb shim 또는 cellrun.hexa auto-discover fallback). @D d3 impl home=hexa-lang.

## 2026-05-24

- **`inbox/` 폴더 폐기 — open handoff INBOX 이관, 세션 노트 archive/ 이동** — 구 `inbox/`(notes 108 + INDEX.md + patches 2) 를 `git mv` 로 `archive/session-notes/` 이관 (data loss 0). 열린 handoff 15건(pickup-open 11 + pickup-blocked 2 + cross-repo patch 2) 은 `INBOX.md` `- [ ]` 로 이관, 나머지 ~93 historical 노트는 archive 보존(INBOX.log 범람 방지). repo 전역 `inbox/` 경로 인용 72개 파일 일괄 갱신(타 repo 인용 보존). INBOX scope = cross-repo + demiurge cross-session pickup 통합 수신함.
- **루트 INBOX 도메인 생성 — cross-repo handoff 수신용** (sidecar commons g11/g36/g48/g59 정합). demiurge 자체 archive/session-notes/(cross-session notes + INDEX.md, 108 entries)는 별개 내부 시스템으로 그대로 유지.

### 2026-05-24 cycle 9-full+ batch (5 commits · CaH₆ 측정-grade anchor #2 + d7 wall α²F grid 100→140 meV 돌파)

- **CaH₆ 측정-grade 검증 — DFT 213 K vs Ma 2022 측정 215 K (2 K 정합)** (`96eac8f`) — pool:ubu-2 retry (ibrav=3 BCC primitive 7-atom + 170 GPa vc-relax) 후 ph.x 4³q (8 IBZ · 16k) NaN=0 깨끗한 수렴 · λ_BZ=3.40–4.38 · ω_log=1177–1236 K · Tc(μ0.13)=213 K (broad=0.030). H₃S 와 함께 *측정-grade 일치 2번째 anchor* (clathrate topology). d2 wall 근본원인 = **input cell-choice** (ibrav=1 nat=14 conventional + press=0) — hexa cloud 버그 아님. 5 breakthrough hypothesis 중 #4 (cell pre-relax + 170 GPa) winner · #1+#2+#3 belt-and-suspenders.
- **§10.1 verdict 정정 — h3o imaginary mode → h3cl #1 stable 후보** (`d4cb538`) — h3o/h3f/h3si imaginary phonon mode 발견 (Im-3m metastable) → §10.1 ranking 재구성: h3cl 이 진짜 stable #1 candidate. h3o 191 K headline 은 metastability 단서 부착 · novel-prediction 박제는 유지 (R4 Pattern 1 보존).
- **BEE-NET step0 BLOCKER 해소 — grid ceiling 101 → 140 meV** (`b1aae78`) — `utils/data.py:15` Freq_final 51 → 71 bin · 첫 51 append-only · CPU smoke 4/4 PASS → d7 wall path B 잠금 해제. step1-3 unblocked · step4 fine-tune ~11-19 GPU-hr (병렬 8 GPU → 2-4h wall · H100 무의미, ensemble 100-member 병렬이 진짜 레버). Vast pod 37496985 4-shard launch.
- **DEMIURGE meta-domain scaffold + @goal** (`dee8987`) — `DEMIURGE.md` + `DEMIURGE.log.md` 스캐폴드. meta-domain (UPPERCASE+).
- **RTSC @goal + 10 milestones** (`4960c5e`) — `@goal: 상온·상압 초전도체` + 10 progress milestone (4 done: H₃S 측정-grade · CaH₆ 측정-grade · 5/8 H₃X LANDED + d7 grid 100 meV 정량 · BEE-NET grid 101→140). progress bar `▓▓░░░ 40% · 4/10`.

### 2026-05-24 cycle 9-full batch (4 commits + 2 sibling · d7 wall grid-ceiling 발견)

- **d7 wall mechanistic root — α²F grid ceiling** (RTSC §9.14) — ALIGNN α²F head 출력 grid = **0–100 meV 100-bin** (천장 100 meV). DFT ω_log 가 천장 초과/근접 (h3cl **107.9 meV** 초과 · h3o **94.5 meV** 근접) → 고압 H-derived stretching mode 가 grid 위에 살아 표현할 bin 부재 = ω_log under-prediction 의 root. 2 결손 채널: ① high-ω truncation · ② acoustic-edge sign-pathology (λ_dens = 2a²F/ω·dω 의 1/ω 가중이 음수 α²F 폭증 — h3o 0.5 meV bin **λ_dens=−0.489**, neg-λ 의 82%). d7 = "ML training-distribution wall" 의 정확 물리 = grid ceiling; breakthrough = first-principles DFT 또는 grid-extended retrain.
- **canonical numerical SSOT 지정** (`e60925d`) — 모든 H₃X DFT numerical value 의 single source-of-truth 를 `exports/material_discovery/rtsc_h3<X>_dft_6x6x6q_*.json` (Tier 2 schema · provenance) 로 명시 + README; §9 표 + RTSC.log.md 는 human-readable snapshot (값 불일치 시 JSON authority).
- **5 LANDED H₃X Tier 2 JSON** (`e9081b7`) — h3o/h3po/h3cl/h3f/h3si atlas-ready Tier 2 record 박제.
- **cycle 10 atlas closure log** (`42cec9b`) — 5 LANDED atlas-ready + ALIGNN 9/9 + CaH₆ root cause + g48 handoff track.
- **sibling: sidecar g54 + g55** — commons governance 후속.
- **sibling: hexa-lang PR #557 OPEN** — Vast.ai upstream 흡수 (d9 경로).

### 2026-05-24 cycle 7-8 batch (4 commits + 2 sibling · κ-74 out-of-band audit)

- **RTSC §9 4/8 LANDED · h3o novel 191 K headline** (`9e786fe`) — H₃O Vast 재스캔 회수 (group-16 light O · 6³q · λ_BZ=2.31–2.73 · ω_log=1089–1111 K · Tc(μ=0.10)=**171–191 K** · celldm=4.899). group-16 sweet-spot ladder 5-point mono 강화 (H₃S 203K → h3o 191K → H₃Se 113K → H₃Te 75K → H₃Po 48K). 잔여 4 active pods (h3n · h3p · h3as · h3br) + h3c serial · CaH₆ pool:ubu-1 DEAD (OOM SIGKILL, Vast live).
- **§9.15 closed-loop Bayesian update** (`d2060a3`) — 4 LANDED actual Tc · verdict · axis_violated 3 컬럼 추가; PASS(h3si·h3o) → FAIL above(h3cl) → FAIL below(h3f) → PENDING(h3n·h3p·h3as·h3br) 4-zone 정렬. light-X covalent-radius mass-scaling 가설 **falsified** (h3f χ=3.98 가 group-17 최저 Tc); electronegativity-damage axis dominant (4/5 evidence); group-16 sweet 강화. next critical = h3br (χ-damage 단독 분리).
- **§9 ALIGNN family-wide 통합 · h3br critical-test 가설** (`7eda05e`) — cycle 6+7 통합 9/9 H₃X family-wide ALIGNN per-candidate baseline 완주 (pool:ubu-1, alignn 2026.4.2 / torch 2.4.0+cpu, 평균 0.7 s/cand). 핵심 신규 발견: ① sign-pathology family-wide **3/9** (h3o·h3po·h3n — light X covalent localization), ② λ≥1 strong-coupling outlier 2/9 (h3cl·h3br 신규), ③ Tc-direct cap **4–6 K** family-wide (ambient ML training-distribution ceiling 정량), ④ group-15 ML λ 광범위 분산 −0.18~0.58.
- **inbox h3o headline + d7 wall breakthrough paths** (`006819b`) — h3o 191 K novel headline 노트 + d7 wall mechanism 돌파 paths 7개 + INDEX 갱신.
- **sibling: sidecar `8029c18`** — `commons @D g47` atomic-merge `archive/session-notes/patches/**` PR exemption (maintainer review 보존); `4e64f0b` pr-automerge 0.3.0 lockstep + `affc689` worktree disk fill-up trouble 노트 + `13afebd` 2 cross-project archive/session-notes/patches.
- **sibling: hexa-lang PR #541 MERGED + PR #548 OPEN** — Vast.ai upstream 흡수 (d9 경로 · `hexa cloud` argv-guard + dft-runner nproc fix 후속).
- **h3p a priori prediction 박제** — group-15 P · ETA ~05:38 KST 5/24 · pred Tc(μ=0.10) 90–150 K · ALIGNN per-cand λ=0.585 (정상 mid-range, sign-path 없음). group-15 covalent-bonding-dominant vs group-16 light-X sweet 가설의 첫 분리 datapoint.

## 2026-05-23

- **RTSC H3X 그룹 14-17 스크린** — H3S(200K) · H3Se(98-128K) · H3Te(72-76K) baseline 위에 H3X 8 후보 본격 dispatch; Vast.ai 11-pod 자율 병렬 가동 (3 orchestrator · 8 fanout); DFT 완주 미도착 (in progress).
- **`process_completed_pod.sh` harness** — Vast.ai pod 결과 처리 21/21 schema 일치 · R4 invariant 박힘; `RTSC.log.md` §9.15 H3X precommit prediction 추가.
- **MONDALOY §9 reverse 캠페인 완주** — SX500급 단결정 초합금 candidate `demiurge-SX500-RE-c1` 도출; `exports/material_discovery/sx500_mondaloy_*_20260522.json` 커밋.
- **upstream patch 일괄 발사 (hexa-lang)** — PR #376 (2 patches: dft-runner NPROC overcommit · `hexa cloud` argv-guard shell-redirect false-pos); PR #378 (4 patches: vastai destroy -y · host CDI fast-fail · verified offer default · offer/machine claim-lock); 6 patches · 649 lines.
- **`dft_runner.sh` source fix** — nproc → physical cores · MPI bind-to-none.
- **project.tape `@D d9`** — Vast.ai trouble → hexa-lang inbox 경로 명문화 (f555697).

### 2026-05-23 cycle 0-5 batch (9 commits · κ-73 out-of-band audit)

- **RTSC §9 H3X 8-fanout 3/8 LANDED** — `H₃Po`(group 16) + `H₃Cl`(group 17) + `H₃F`(group 17) + `H₃Si`(group 14) Vast.ai 회수 완주; `H₃S`/`H₃Se`/`H₃Te` baseline 위 d7 wall 본격 가시화 (commits `fe16791` · `63d9065`).
- **d7 wall ALIGNN per-cand 정량화** — ALIGNN ω_log 가 measured 대비 **15× under-predict** (per-candidate · group 17 funnel 가설 + DFT/ML 2.9× 비율 확정); RTSC §9 narrative 에 d7 mechanism 박힘 (`archive/session-notes/` h3cl 2건 + `adc0852` + `0c1b864`).
- **cockpit Stage 1+2a Swift rename** — `Rtsc*` → `Hts*` (View3D · CoilGeometry · Records/Analyze/Verify · 5+5 = 10 파일); `swift build` PASS · `RTSC5GateEnforcementTests` 6/6 PASS; Stage 2b Loaders 는 후속 stacked PR (`de45c44` · `019dcbb`).
- **PLAN/HANDOFF absorption follow-up** — 7 files 의 dangling live-pointer references → `.log.md` archive redirect (`26c4bfb`).
- **§9.15 precommit outlier 분석** — h3f / h3cl / h3si vs prediction 양방향 fail 원인 5-가설 사이즈 박제 (`4bbe58b`).
- **scope-shrink decision B** — RTSC 가설 vs HTS proxy 명시 (Swift rename 별도 stacked PR 분기 · `4b75289`).
- **ARCH `### 11.8` κ-73 entry** — RTSC §9 + d7 + cockpit rename 의 audit trail 박제 (out-of-band · non-R-round).
- **project.tape v1.4 → v1.5 (`@D d10`)** — worktree concurrent agent index isolation 학습 명문화 (cycle 5 cross-agent index contamination 사고 → sequential commit 원칙).

## 2026-05-22

- **RTSC DFT breakthroughs** — first-principles measurement-matched superconductivity: H3S 6×6×6-q final (96% of measured Tc), Nb ambient-SC capstone, first novel candidates H3Se / H3Te, §9.12 hydride DFT extension (LaH10 / CaH6 / YH6).
- **κ-71 / κ-72 cycles** — gates G40–G46; decisions D121 (4-record-type invariant) + D122 (kernel-refinement flip, 4/4 closure).
- **domain doc reorganization** — `<DOMAIN>.md` spec / `<DOMAIN>.log.md` history split across the root surface; `design.md` → `DESIGN.log.md` + live pointer; `YOSYS.md` reconstructed; `NEXT_SESSIONS.md` removed; `PLAN.md` + `HANDOFF.md` absorbed into `CHARTER.md`.
- **project.tape governance** — `@D d6/d7/d8` (compute sizing · first-principles-over-ML wall · downstream discipline), v1.2 → v1.4.

## 2026-05-21

- **RTSC.md domain** — first `absorbed=true` flip: Nb BCS universal-gap-ratio attestation; 5-axis Record schema + §8 material-synthesis 4-tier.
- **cockpit Phase B/C** — `sscb` cells dispatch via `cellrun.hexa`; 5 new domain producers; D111–D113 ratified.
- **κ-68 / κ-69 cycles** — gates G29–G34; first cell `absorbed=true` legitimate flip; measured-oracle invariant landed.

## 2026-05-20

- **cockpit build-out** — heaviest ship day: producer registry, domain loaders, payload flattening, governance `@D` entries rewritten to do/dont form (`.tape` v1.3).

## 2026-05-19

- **cockpit κ-cycles** — phases κ-11 through κ-28: ingredient shelf real data, 3D viewer, chat persistence, CLI gate commands, reference-browser filters, expert-mode depth.
- **first hexa-native F1F2 record** exported.

## 2026-05-18

- **scaffold** — hexa-arch initialized: universal hexa-native technical-design architecture program. 7-verb cited pipeline + `design.md` (D1–D5); shallow public-surface maps for 13 cohort domains; rfc_001 / rfc_002 contracts. Later rebranded **demiurge**.
