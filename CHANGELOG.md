# Changelog

Chronological log of notable changes. One section per ship batch, date-keyed. Decision gates tracked as `D<N>` in `DESIGN.log.md`; cycle phases as `κ-<N>`.

For the full audit trail, see `git log`.

---

## 2026-06-16

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
