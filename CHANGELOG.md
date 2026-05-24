# Changelog

Chronological log of notable changes. One section per ship batch, date-keyed. Decision gates tracked as `D<N>` in `DESIGN.log.md`; cycle phases as `κ-<N>`.

For the full audit trail, see `git log`.

---

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
