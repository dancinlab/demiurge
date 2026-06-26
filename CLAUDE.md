# demiurge

demiurge is a universal, hexa-native technical-design architecture program: it drives any engineering system through one 7-verb pipeline (spec → structure → design → analyze ⟲ → synthesize → verify → handoff), with each field plugged in as a manifest-only domain. It exposes a Next.js web GUI (the human surface) and a hexa-native CLI (the AI-agent surface) over the same generic dispatch, and consumes reusable implementation from the sibling `hexa-lang` repo (it never owns stdlib itself).

> 📍 SSOT 포인터 (이 파일 = 진입점 + 거버넌스/워크플로우/작업규칙):
> · **구조·설계 → [ARCHITECTURE.json](ARCHITECTURE.json)** — 디렉토리·모듈 트리 + LAWS + reuse-graph 는 **여기 단일 SSOT** (JSON-트리 · AI/tool-parse; 사람은 `python3 serve.py` → [ARCHITECTURE.html](ARCHITECTURE.html) 뷰어 · ARCHITECTURE.md 은퇴 2026-06-16 c4)
> · 거버넌스 → **이 파일** `## 거버넌스` (`@D d*` directive family · project.tape 은퇴 2026-06-15 md 단일화) + cross-project [commons](.harness-engine/config/commons.md)
> · 이력 → [CHANGELOG.md](CHANGELOG.md) (append) · 개요 → [README.md](README.md)

> 🛠️ **트러블슈팅 재발방지 = 도구(hexa cloud · hexa deck) 개선으로 박제 (최상위 원칙)**
> 컴퓨트/포드/덱에서 트러블슈팅을 한 번 겪으면 — 그 자리에서 손으로 우회하지 말고 **그 예방 가드를
> `hexa cloud`(포드·클라우드 레이어) 또는 `hexa deck`(입력덱·런스크립트 레이어)에 코드로 박아** 같은
> 버그 재발을 0으로 만든다(self-improving 도구 = 규율 SSOT). c17대로 응용층(cloud·deck)은 **격리
> worktree서 직접 fix → `harness pr-cycle`**, 컴파일/런타임 코어는 ING 인계. d_deck_always(덱)·이 원칙
> (cloud)이 한 쌍. 매 트러블슈팅이 새 가드를 낳는다.

## 거버넌스 (governance)

The `@D d*` directive family (formerly `project.tape`, retired 2026-06-15). Each directive is faithful to the tape, in `do` / `dont` form.

### d1 — non-wet-lab verification → completed-form

- do: drive each non-wet-lab step (sim · proof · synthesis · gate · handoff) to completed-form pre wet-lab
- dont: leave non-wet-lab verification `partial` / `pending` when the path to completion is clear

### d2 — wall encountered — surface breakthrough paths, never concede

- do: on an empirically-demonstrated wall, propose 2-3 concrete breakthrough paths — `/gap` · `hexa kick`
- dont: concede `impossible with current methods` without naming concrete breakthrough paths to try

### d3 — implementation code lives in one canonical home

- do: implementation code lives in the canonical stdlib home — topical folders hold docs / manifests only
- dont: duplicate implementation across topical folders · treat per-domain repos as code homes

### d4 — single generic dispatch — instance = manifest only, no name hardcoding

- do: every variant / domain / tenant traverses one generic path — add / rename / remove is manifest-only
- dont: per-instance dispatcher / producer class · branch on instance name in the generic layer

### d5 — absorbed=true ⇔ all non-wet-lab gates PASS

- do: flip `absorbed=true` when all non-wet-lab gates pass — wet-lab is downstream confirmation
- dont: block `absorbed` on wet-lab measurement · flip from a projection · skip a non-wet-lab gate

### d6 — first-principles physics breaks the ML training-distribution wall

- do: when a wall is a model's training-distribution limit, break it with first-principles physics, not ML
- dont: force a target number under goal pressure · present an under-converged value as the result

### d7 — compute sizing for DFT electron-phonon

- do: small cells (4-7 atoms) → pool ubu-1/2 free · batch → Vast.ai CPU · ≥20 atoms / dense k → GPU pod
- dont: RunPod CPU pods (8-vCPU ceiling) · Vast.ai CPU-only rentals (use GPU offers) · GPU on small cells

### d8 — Vast.ai trouble → ING 핸드오프 (inbox 은퇴 2026-06-22)

- do: Vast/upstream finding → `harness ing add` 로 ING.jsonl 핸드오프에 기록해 `hexa cloud` 가 upstream absorb (구 `hexa-lang/inbox/patches/` 은퇴 → ING 단일화)
- dont: paper-over a Vast-discovered `hexa cloud` gap inside the campaign

### d9 — worktree concurrent agent index isolation

- do: sequential commit on main · stage+commit one agent at a time · `git add <explicit-files>` only
- dont: parallel worktree agents staged at once → index leak · stage absorbed into another agent's commit

### d10 — every domain wears an easy-style identity head — icon · name · alias

- do: head each <DOMAIN>.md with: 1 emoji icon · canonical NAME · short user-language alias
- dont: leave a domain id bare · coin a different alias per file within one domain

### d11 — pre-rent feasibility-size — atoms · basis-fn · method scaling first

- do: before paid GPU rent, size the job (atoms · basis-fn · method scaling) → single-pod-feasible?
- dont: rent before sizing confirms feasibility (4676-bf hybrid DFT single-pod = days/$$$)

### d12 — metal-oxide hybrid DFT — cluster model, not full NP

- do: metal-oxide DFT → carve neutral charge-balanced cluster (e.g., Ce₆O₁₂ singlet), not full NP
- dont: hybrid DFT on full metal-oxide NP single-pod — convergence + cost both fail

### d13 — basis/ECP element coverage check before run

- do: grep target lib for element entries before run (lanthanides → CRENBL/SARC in NWChem)
- dont: assume def2-TZVP covers Ce/lanthanides — NWChem's bundled def2 has no lanthanide entries

### d14 — DFT method tractability — PBE first for metal-oxide

- do: metal-oxide first run → pure PBE (xpbe96 cpbe96), not hybrid (PBE0/ωB97X-D) — 5-10× faster
- dont: default to hybrid DFT on large metal-oxide — exact exchange CPU-bound + harder SCF

### d15 — small-gap SCF aids — smear + damp + convergence lshift

- do: metal/small-gap SCF → `smear 0.01` + `convergence damp 70 lshift 0.5` + `maxiter 400`
- dont: expect default SCF to converge on metal-oxide clusters — f/d-electron near-degeneracy

### d16 — deck syntax-validate FREE on pool before rent

- do: build deck + 1-iter dry-run on pool free → catch directive/basis errors before paid rent
- dont: discover NWChem syntax errors on a billing pod — every iteration is wasted $

### d17 — cost-bearing fire — dispatch autonomously, no user gate

- do: validated deck (d16 free dry-run passed) → fire full-campaign rent autonomously · parallel
- do: state estimated cost in one line, then fire — no user consult / approval / confirm
- do: provider priority = vast.ai first, runpod fallback
- dont: ask 'may I rent?' · defer fire to shrink cost · gate scale-up behind a 1-cell step
- dont: $ cap / budget gate that requires user sign-off before firing

### d18 — round-1 of every cycle/domain — include NOVEL + arxiv + web deep research from the start

- do: round-1 fan-out includes >=1 NOVEL probe and >=1 arxiv+web deep-research search
- dont: round-1 with only incremental milestones · skip lit grounding · defer NOVEL to later round

### d_novel_only — 이미 알려진 것의 재현·검증 절대금지 · 목표는 NOVEL 발견

- do: 모든 캠페인·라운드의 목표는 **NOVEL(미발견) 발견** — 문헌·임상에 이미 알려진 결과를 똑같이 다시 내는 일에 compute/시간을 쓰지 않는다
- do: 표적·후보 착수 **전** arxiv+web으로 신규성을 먼저 확인(d18 lit grounding) — 이미 알려졌으면(예: MCL1 = S63845·AMG-176·AZD5991 임상 레드오션) 그 표적은 **재현 대상이 아니라 회피 대상**, 즉시 NOVEL 각도로 피벗
- do: 기지값과의 대조가 필요하면 그건 **방법 검증용 1회 앵커**로만(파이프라인 정합성 확인) — 그 자체를 캠페인 산출/성과로 박제 금지. 진짜 결과는 항상 미지 영역의 Δ(새 표적·새 기전·새 물질·closed-negative)
- do: **문헌 재현 compute 절대금지 (하드 규칙)** — 이미 출판된 값(예: FeCo bct K1 0.7-1.0·Fe16N2 ~1.0·known 강결합 λ)을 우리 도구(DFT·QE·ABFE·계산)로 **다시 산출하는 것 자체가 재현** — *closed-negative 확정·method-anchor·"실측으로 박제" 목적이라도 금지*
- do: axis가 문헌 anchor로 이미 닫혔으면 **그 문헌(DOI)으로 종결**하고 verdict에 인용 박제, compute는 오직 미지 영역(Δ)에만 발사한다. 어떤 셀/물성을 계산 큐에 올리기 **전**, "이게 새 Δ인가, 출판값 재현인가"를 자문해 재현이면 발사 취소(compute·디스크·시간 낭비 0)
- do: 이번 세션 슬립: leverb-mae-production이 문헌이 이미 FAIL을 사전등록한 FeCo/Fe16N2 K1을 summer disk 99%에서 재계산하려 함 → 종결이 정답이었음
- do: **신규성 게이트는 자동·필수·선행 (재발방지 핵심)** — 어떤 후보/표적/물질이라도 그 이름이 처음 등장하는 **그 라운드 안에서** arxiv+web 신규성 프로브를 **함께(인라인) 발사**하고, 판정(`PUBLISHED`/`PARTIAL`/`NOVEL` + 경쟁 논문 id)을 받기 **전에는** 그 후보를 "후보 성공·발견·돌파"로 보고하지 않는다
- do: 신규성 확인은 **유저가 "arxiv 조사해봐"라고 시켜서 뒤늦게 도는 단계가 아니라**, 후보를 계산·명명하는 파이프라인의 1단계(fleet round-1 = d18). 이 세션 반복 슬립: Mg2PtH6·CoSn·경원소 kagome 를 **계산→성공 보고 후에야** 신규성 확인 → 순서 역전 금지
- dont: 이미 알려진 강결합/물성을 ABFE·DFT 등으로 "맞췄다"를 발견·성과로 보고 · 신규성 확인 없이 레드오션 표적에 풀 캠페인 발사 · NOVEL을 다음 라운드로 미루고 재현부터 하기 · **후보를 먼저 "성공/발견"으로 박제·보고하고 신규성 프로브를 나중에(혹은 유저 지시 후) 돌리기**
- dont: 신규성 미확정 후보의 성과 보고는 항상 `신규성 PENDING` 꼬리표를 달고, 판정 후 등급 확정 (d2·d6·d18·d_discovery·d_paper_significance와 한 묶음 — 발견 아니면 의미 없음)

### d19 — MATLAB-grade in-silico 100% closure · intra-domain reuse lattice

> The tape carries two `@D d19` records (governance closure + reuse lattice); both are preserved here.

- do: in-silico path (ngspice · openEMS · MNE-Python · MATLAB-grade) to 100% closure
- do: apply d1+d5: non-wet-lab gates PASS → flip absorbed=true · no closure delay
- do: datasheet mismatch → open-model / direct derivation / sympy+scipy bypass
- do: before building a domain primitive, grep the atlas + sibling DOMAIN.md for a verified one
- do: inherit it — e.g. ANTIMATTER trap reuses RTSC current_loop_offaxis
- do: stamp each record with reused[] / provides[] cross-domain edges
- do: keep the cross-domain reuse graph current in `ARCHITECTURE.json` (단일 SSOT — NEXUS.tape 은퇴 2026-06-21)
- dont: trailer wet-lab / external-lab / funding / paid / multi-year as 'excluded'
- dont: repeat 'absorbed=false PERMANENTLY' trailer — d1/d5/d19 already covers it
- dont: rebuild a sibling domain's verified primitive · leave a reuse edge off the ARCHITECTURE.json reuse-graph
- dont: link domains across repos — intra-project only

### d_deploy — web GUI surface ONLY — local hot-reload work mode · deploy gated on user approval

- do: web GUI: iterate live in localdev git tree (~/core/demiurge-localdev/web · next dev Fast Refresh)
- do: web deploy (push main → Cloud Run demiurge.dancinlab.org) ONLY on explicit user approval
- do: scope = web GUI surface ONLY — compute/campaign autonomy (d17) unaffected
- dont: auto-merge/push/deploy web changes per tweak without approval

### d_parallel_first — parallel-first — minimize wall-clock, never run independent work serially

- do: default to parallel fan-out — independent tasks run concurrently, not one-at-a-time
- do: pick the partition that MINIMIZES walltime, not the one that's simplest to launch
- do: scale fan-out width to the work (N independent units → N workers), bounded by the real floor
- dont: run independent units serially when they can fan out · accept a long serial walltime by default
- dont: add workers past the floor where fixed cost (setup·collect) dominates — waste, not speed

### d_qforge_parallel — QFORGE/compute campaigns — GRID-parallel to the walltime floor

- do: QE/QFORGE el-ph: split q (start_q/last_q) AND representations (start_irr/last_irr) across pods
- do: share one converged SCF out/ to all shards (skip per-pod SCF regen) — collapse the fixed floor
- do: size shards so each ≫ SCF+collect floor (~2-3h realistic min); recover/collect to assemble
- do: a long single-pod sequential el-ph run = a bug to parallelize, not a wait to endure
- dont: run an 8-q el-ph serially on one pod when q×irr GRID finishes in hours · leave walltime on table
- dont: add shards below the floor (SCF/transfer/collect dominates) — report the floor honestly (d6)

### d_qforge_fix — QFORGE upstream fix·개선 — 즉시해결 우선 · 장기지연 시 QE 병행(동시)

- do: QFORGE upstream fix/개선이 **바로 해결 가능**하면 즉시 고치고 진행(우회·미루기 금지)
- do: fix가 **오래 걸리는(장기)** 경우 → QE로 대체해 캠페인을 **계속 전진**시키되, QFORGE fix도 **바로 함께(병행)** 진행 — 둘을 동시에 굴린다(QE production + QFORGE fix in-flight)
- do: QE 대체는 임시 우회가 아니라 정직한 production reference (d_qforge_parallel·migration gate와 일관) — 결과는 QE-grade로 박제, QFORGE는 게이트 후 absorb
- dont: QFORGE fix가 길다고 캠페인을 멈춰 세우기 · QE 대체만 하고 QFORGE fix를 뒤로 미뤄 잊기 · 바로 고칠 수 있는 걸 우회로 덮기

### d_qforge_migration_routing — QE→QFORGE 전환은 piece-by-piece, 게이트(≤1% vs QE) 통과분만 absorb

> 마이그레이션 SSOT = `ARCHITECTURE.json` QFORGE.migration_gate. 사람은 `QFORGE/QFORGE.md §⭐ ENGINE STATUS`.

- do: 전환은 **조각 단위**(per-layer/per-piece) — 각 조각이 QE 대비 **≤1%** 통과(g5 검증)한 뒤에만 QFORGE가 absorb (d5)
- do: **이미 전환됨**: λ/Tc **어셈블리 전체**(L0-L5: Allen-Dynes·Eliashberg·a2F·α²F·DFPT-solver·PW-SCF bricks) = native QFORGE gate-grade(CaH6 1.65e-7) → production = mode-(b) hybrid(QE |g|² → QFORGE assembler)
- do: **QE 잔존(아직)**: DFPT **front-end |g|²** + 포논 + nspin=2 모먼트 — from-scratch 차폐정점(mode a/c)이 게이트 미달이라 HELD
- do: gate anchor는 QE로 마감(정직한 production reference) · 벽은 **분류 후 named 레버로 돌파 시도**(c15·d2) — degenerate-subspace Sternheimer · 고RAM 포드(OOM=substrate)
- dont: from-scratch λ를 4.376으로 강제(tune-to-green·d6) · 게이트 미통과분을 absorbed로 박제 · 벽을 천장으로 조기 확정(단일렌즈 1회 막힘=미완) · 마이그레이션 상태를 흩어진 노드로 방치(SSOT=migration_gate 1곳)

### d_qforge_default — 컴퓨트 기본 엔진 = QFORGE (QE 대신) · 미전환 조각만 QE fallback

- do: el-ph/DFT 컴퓨트의 **기본 엔진은 QFORGE-native** — gate-통과(≤1% vs QE) 조각은 항상 QFORGE 경로로 실행: L0-L5 λ/Tc 어셈블리·PW-SCF bricks·Sternheimer·**GPU block davidson**(RTX5070 실측·davidson/SCF/el-ph hot path 배선·c24)
- do: production = mode-(b) hybrid(QE |g|² → QFORGE assembler)도 QFORGE-native 산출을 기본으로 본다
- do: **QE는 두 용도로만**: (a) 아직 gate-미통과 조각(from-scratch front-end |g|²·포논·nspin=2 moment)의 reference/fallback — d_qforge_migration_routing의 HELD 목록 (b) gate anchor 1회(정직한 production reference)
- do: 그 외 새 컴퓨트는 QFORGE 먼저 시도
- do: 페이오프 = **summer RTX5070 무료 QFORGE-native el-ph → 유료 vast GPU 회피**. QFORGE가 막히면 즉시 QE 병행(d_qforge_fix)하되 QFORGE-native 전환을 함께 추진(미루지 않음)
- dont: gate-통과 조각을 습관적으로 QE로 돌리기(QFORGE 기본 무시) · "QE가 익숙하니 QE로" 디폴트 · QFORGE를 실험취급하고 QE를 production취급(역전) · 미전환 조각을 QFORGE-native로 강제해 게이트 미달분 absorbed 박제(d6·migration_gate 위반)

### d_deck_always — 모든 컴퓨트 입력덱은 `hexa deck`(빌더+검증)을 통과 (필수)

- do: DFT/QE el-ph 컴퓨트 입력덱(scf · ph · vc-relax · bands · matdyn 등)은 **항상 `hexa deck`(빌드+검증)** 으로 생성/검증
- do: 손수 `.in` 작성 금지(이번 세션 손작성 버그 다발: bands verbosity='high' 누락[#k≥100]·원자질량 오기[Os 190.23]·vc-relax 미수렴·d15 SCF aids 누락)
- do: `hexa deck` 은 hard-won 덱규율을 코드로 박제: 정확한 원자질량/의사퍼텐셜(d13 element 커버 grep) · bands verbosity='high'(#k≥100) · 금속/소갭 SCF aids(d15: smear+damp+lshift) · **d16 1-iter dry-run 검증 FREE on pool 후 발사**
- do: DFPT el-ph 전 **d6 동적안정 사전체크**(matdyn 허수모드 0)
- do: 덱은 `decks/`(루트 입력덱) · `exports/rtsc/decks/` 에 박제(c5 보존) · raw curl/애드혹 손작성 대신 `hexa deck` 우선(commons c12 harness-first 일관)
- do: **트러블슈팅 발생 시 → 그 예방처리(가드/체크/기본값)를 `hexa deck`에 즉시 박제** — 덱 관련 버그·실패를 한 번 겪으면 그 재발방지 규칙을 도구에 코드로 넣어 **같은 버그 재발 0** (hexa deck = self-improving 덱규율 SSOT; 매 트러블슈팅이 새 가드를 낳는다)
- dont: 검증 안 된 손작성 덱을 billing 포드에 발사(d16 위반) · 원자질량/pseudo/verbosity/SCF-aid 누락된 덱 · 동적불안정 셀에 el-ph 발사(FLEET-DIAGNOSTIC 낭비) · **덱 버그를 일회성으로 고치고 `hexa deck`에 가드 안 박기**(재발 방치)

### d_roomt_ambient — 상압·상온 초전도 통과기준 (ROOMT-AMBIENT-PASS-CRITERIA · 하드 게이트)

> SSOT = `ARCHITECTURE.json` LAWS/ROOMT-AMBIENT-PASS-CRITERIA · 상세 `state/fb-geom-lambda/ROOMT_AMBIENT_PASS_CRITERIA.md`. "상온/상압 초전도" 주장은 이 게이트를 명시적으로 통과해야만 박제.

- do: **하드 임계**: Tc ≥ **293.15K**(여유 측정 300K 권장) · P = **1 atm**(≈0 GPa — **GPa-급 수소화물[LaH10 등]은 상압 아님, 제외**) · **벌크**(박막/계면 SC는 별도 라벨)
- do: **TIER-1 in-silico 사전게이트(g5, 전부 PASS여야 wet-lab 추천·🟡 GATED)**: (1) 상압 열역학 안정(convex-hull/ΔH_f<0) (2) **상압 동적안정**(matdyn 허수모드 0 — *고압 안정 ≠ 상압 안정*) (3) 캐리어 채널(E_F 금속/도달가능 도핑·N(E_F)>0; 매장/wide-gap=FAIL)
- do: (4) **Tc≥293K**(conventional=DFPT λ+Allen-Dynes/Eliashberg; unconv=order-parameter Tc + calibrated estimator) (5) 자성/CDW 비-선점(U-scan) (6) 신규성(d_novel_only)
- do: **TIER-2 wet-lab 확정게이트(d1/d5 downstream, absorbed=true 조건 ALL)**: A zero-R(ρ→0 @≥293K) · B **★Meissner 차폐분율(zero-R 단독 불충분 — 세션교훈)** · C 비열점프 ΔC+Hc1/Hc2 · D 동위원소/갭(기전)
- do: E **재현 ≥2 독립 배치/랩(단일배치 preprint 불충분)**
- do: 정직 채점(d6): 후보 Tc가 임계 미달이면 "상온 후보"라 부르지 말 것 — 예) Ge:GaNb4S8 ~50K·MgB2 39K·LiBC ~45K 모두 #4(Tc≥293K) **FAIL** → "상압이나 상온 미달". 병목=#4(경원소 강결합+상압 동적안정 동시 OR 비-phonon 기전 — 미해결 벽)
- dont: zero-R 단독·단일배치 preprint·투영(모델)값을 "상온 초전도 통과"로 보고 · GPa 고압 Tc를 "상압"으로 보고 · TIER-1 미통과 후보를 상온후보로 박제 · Tc<293K를 "상온"으로 호칭(d6 위반·d_novel_only·d_paper_significance와 한 묶음)

### d_production_grade — 실제 프로덕션(상용화) 통과기준 (lab 검증 ≠ production · 하드 게이트)

> SSOT = `ARCHITECTURE.json` 각 캠페인의 PRODUCTION-CRITERIA 노드. 어떤 신소재/대체후보를 "실제로 양산·상용화 가능"이라 주장할 땐 이 게이트를 명시 통과해야만 박제. 세션교훈(Gd→Mn²⁺ MRI): Phase2 임상 도달(원리검증)이 ≠ Gd 시장 대체 — relaxivity(spin 7vs5)·Mn 독성·확립된 시장 마찰로 미상용.

- do: **2-tier 구분 필수**: **TIER-L(lab/in-silico)** = 원리검증(성능 패리티 게이트 PASS + 신규성) — "작동 증명"일 뿐
- do: **TIER-P(production 상용화, ALL PASS여야 'production-ready')**: P1 **성능 패리티**(기존 벤치 대비 정량 ±허용 — 자석 BHmax·MRI relaxivity·CMP 제거율·Ga 캐리어이동도) · P2 **안정성/안전/신뢰성**(독성·분해·수명·환경 — manganism·MnAl metastability)
- do: P3 **제조 확장성**(벌크/연속/수율, 박막·분말·단일배치 only 아님 — tetrataenite G6·반도체 fab 통합) · P4 **비용 경쟁력**(≤ 기존 또는 명확한 가치 — FePt Pt 비용 실패) · P5 **인증/규제/시장 진입**(FDA·반도체 qual·고객 인증·기존 시장 진입장벽)
- do: P6 **공급망 회복력**(대체의 목적 — 중국-의존 임계소재[Ga·Ge·Sb·중희토류·CMP] 회피, ★새 단일소스 의존 안 만들기)
- do: 정직 채점(d6): TIER-L 통과(원리검증)는 "상용화 가능"이 아니라 "원리 작동"으로만 보고. TIER-P 미통과 후보는 `production-ready`라 부르지 말 것 — 어느 P-게이트에서 막혔는지 명시(예: Gd→Mn=P1 relaxivity+P2 독성+P5 시장).
- dont: lab/in-silico 패리티만으로 "상용화 가능·production 낼 수 있다" 보고 · 단일배치/박막/임상초기 결과를 벌크 production으로 일반화 · **새 임계소재(다른 중국-의존 원소) 의존을 만드는 대체를 "공급망 해결"로 박제**(P6 위반)
- dont: TIER-P 게이트 없이 "대체 성공"을 상용 성공으로 호칭(d_novel_only·d_roomt_ambient와 한 묶음)

## 워크플로우 (workflow)

PAPER auto-generation flow — atlas-as-audit-SSOT lineage (`research result → hexa verify pass → atlas atom direct fold → /paper`).

### d_atlas_as_audit_ssot — atlas embedded.gen.hexa single SSOT — zero intermediate ledger files

- do: verify pass → atlas atom direct fold (assumes · recipe · provenance · falsifier meta)
- do: audit index = `hexa atlas dump --json` (per-claim · per-domain · per-group queries)
- dont: CLAIMS.tape · per-domain ledger · attestation JSON · state/ verdict mirror · any intermediate index

### d_claim_verify — every claim closed by an atlas atom (hexa verify pass · direct fold)

- do: close each claim via `hexa verify` (g5) → atlas atom direct fold into embedded.gen.hexa
- do: atom meta carries the verdict verbatim — assumes · recipe · provenance · falsifier · tier
- dont: LLM self-judge correctness (g3) · paraphrase the atom · hide an INCONCLUSIVE / unfenced claim

### d_paper_gate — /paper gated on terminal verdict AND significance

- do: `/paper new <slug>` only when every section claim is terminal AND significance satisfied
- do: terminal = 🔵 formal / 🟢 GATE_CLOSED_MEASURED / 🔴 CLOSED-negative — not 🟠 INCONCLUSIVE / 🟡 citation
- dont: scaffold w/ any 🟠 INCONCLUSIVE / MISSING-INPUT · 🟡 citation-only · ⚪ speculation · trivial recheck

### d_paper_significance — paper requires a falsifiable hypothesis + real measurement + a finding

- do: trigger only on a pre-registered falsifier + real measurement (record / sim / FEM / DFT / verify)
- do: finding = Δ vs baseline OR a closed-negative ruling out an axis
- dont: paper for a bookkeeping closure · known identity · unverified prediction · 🟠 residual

### d_paper_format — paper sections — hypothesis · method · measurement · finding

- do: §hypothesis (falsifier) · §method · §measurement · §finding (Δ OR ruled-out axis)
- do: commons g51 — compile ≥10 pages + ≥1 fal.ai figure
- dont: narrative-only · measurement substitute for hypothesis · skip §finding · vague claims

### d_paper_sections — every paper section claim links to its atlas atom

- do: every section claim links to its atlas atom id (resolved via `hexa atlas lookup <id>`)
- do: an `RTSC absorbed=true` literal also passes `_tools/check_rtsc_claim.sh` (5-gate ALL_PASS)
- dont: ship paper with any unresolved residual section · treat the verdict matrix as optional

### d_paper_violation — violating paper immediately revoked

- do: violating paper (gate / significance fail) revoked immediately — PAPERS/<slug>/ removed
- dont: keep a violating paper as draft · mark WIP · defer revocation · allow a residual

### d_paper_on_discovery — any verified discovery becomes a paper — free slug, no fixed domain

- do: every terminal discovery → its own paper slug (named by the finding, not a fixed bucket)
- do: replace/supersede in place when a stronger finding lands on the same slug
- dont: pre-assign papers to fixed domain buckets · cap the paper set · force a finding into wrong slug

### d_discovery — discovery runs continuously, not only at cycle tail

- do: interleave /kick · /gap discovery every batch — a discovery lane runs alongside verify
- dont: defer discovery to the end · single tail-only round · stop discovering once a paper ships

### d_discovery_log — discoveries persist at .discoveries/<slug>.tape

- do: log every kick/gap discovery to `.discoveries/<slug>.tape` — id · seed · verdict-tier-target
- dont: discard discovery output · paraphrase findings · skip linking discovery → next-cycle claim

### Single-doc discipline

- do: architecture goes in `ARCHITECTURE.json` (JSON-tree SSOT · AI/tool-parse; 사람은 `ARCHITECTURE.html` via `python3 serve.py`); history in `CHANGELOG.md` (append-only)
- do: all work artifacts under `state/` (commons c5 · single artifact root) — `ARCHITECTURE.md` 은퇴(2026-06-16 · c4 JSON-트리 채택)

## Harness

This repo is governed by the **`dancinlab/harness`** engine, pinned as a git submodule at `.harness-engine` (branch `harness-hardcore`).

Activate the submodule after cloning:

```bash
git submodule update --init --recursive
```

Run any harness command via the bundled wrapper:

```bash
bash .harness-engine/bin/harness <cmd>
#   docs check     single-doc discipline (ARCHITECTURE.json SSOT + CHANGELOG.md log + quickref)
#   docs status    CLAUDE-MD discipline + scatter/quickref counts
#   lint           staged-L0 + freshness + changelog convergence
#   audit          6-axis self-scorecard
```

Config lives in **`harness.config.json`** (profile `hardcore`):
- `lockdown.files` — core source files that emit an L0-edit reminder on change.
- `lint.changelog` — staged code changes require `CHANGELOG.md` to be staged too.
- `lint.protectedBranches` — `main` / `master` (no direct commits).
- `docs` — `architecture=ARCHITECTURE.json`, `log=CHANGELOG.md`, `scratchDir=state`, and `scopeDirs:[""]` (scatter/quickref discipline applies to repo-root `.md` only, so the large research / domain document corpus under subdirectories is exempt).

The harness hooks are wired into `.claude/settings.json` (PreToolUse / PostToolUse / UserPromptSubmit / SessionStart), each guarded with `[ -x .harness-engine/bin/harness ] && … || true` so the repo stays usable when the submodule is uninitialized.

## Quick reference

- Architecture SSOT — [ARCHITECTURE.json](ARCHITECTURE.json) (JSON 트리 · 사람은 [ARCHITECTURE.html](ARCHITECTURE.html) 뷰어로 — `python3 serve.py`)
- Governance SSOT — this file (`## 거버넌스 (governance)` · `## 워크플로우 (workflow)`)
- Project overview — [README.md](README.md)
- Change log — [CHANGELOG.md](CHANGELOG.md)
