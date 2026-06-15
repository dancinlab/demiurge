# Changelog

Chronological log of notable changes. One section per ship batch, date-keyed. Decision gates tracked as `D<N>` in `DESIGN.log.md`; cycle phases as `κ-<N>`.

For the full audit trail, see `git log`.

---

## 2026-06-15

### SENOLYX — 재사용 ABFE 하니스 6-실패모드 하드닝 (라이브 캠페인 무중단)
- **대상** — `exports/SENOLYX/round13-abfe-allcand/` (재사용 ABFE GPU fan-out 하니스). R12(HSP90)/R13(후보) 라이브 캠페인에서 **실측으로 터진 6개 실패모드**를 근본 차단(c1). 코드/문서 전용 — 새 pod 렌트 0, 가동중 11 pod + watcher 무중단.
- **① bound-pose 기본화** — `abfe_cand.py`가 clash-free 공결정 bound pose `lig_<RESN>_bound.sdf`(extract_pose.py 산출, ideal 컨포머 대신)를 우선 사용 + bound일 땐 recenter 생략(좁은 그루브 포켓 NaN 차단). **전 3타깃 bound SDF 생성**(3CQ/70R/EF2) — summer `fep` env(rdkit 2025.09.5)에서 extract_pose.py 실행해 로컬 적재(전부 BOUND_OK). SDF 부재 시 ideal+centroid graceful fallback.
- **② harvest stdin 보호** — `harvest_cand.sh`·`round12-rbfe/harvest.sh`의 `while read`+ssh 루프에 `</dev/null` 유지 + WHY 주석(ssh가 루프 stdin pipe를 삼켜 첫 pod만 집계되던 버그).
- **③ fanout copy-verify** — `fanout_cand.sh`(+ `fanout_ens.sh`)가 copy-to 후 ssh `test -f`로 원격 존재 확인, 재시도≤3, 필수파일 누락이면 그 pod **발사 abort + manifest에 COPY_FAIL**(doomed runcells 방지).
- **④ retry-resume 전용** — `runcells_cand.sh` 상단에 "production cell은 이 retry-resume 래퍼 경유 필수, 맨 `python &` 금지"(R12 17AG/0 수동셀 死의 원인) 명시. 래퍼는 ≤4회 재시도하며 per-rep `.nc`에서 resume.
- **⑤ ssh-blip alive-gate ⑥ orphan reap** — 신규 `recover.sh`: `alive <host> <port> <id>`=ssh실패 시 `hexa cloud alive`로 RUNNING 확인(GONE/STOPPED만 死 판정·blip은 무동작) · `reap [--apply]`=두 manifest(ens_pods.tsv/cand_pods.tsv)에 없는 `senolyx-*` 소유 live pod만 리포트/destroy(RTSC 41001569·manifest pod 절대 불가). dry-run 검증: 11 manifest pod 전부 보호, orphan 0.
- **검증(c2)** — 6 @L assert 전부 grep PASS · `harvest_cand.sh` 정상 집계(0/9, 라이브 watcher와 일치=셀 진행중) · live 13 vast pod 무중단 · 박제 `README.md`(SSOT) + `ARCHITECTURE.md` 등재.

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
