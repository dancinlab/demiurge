# Changelog

Chronological log of notable changes. One section per ship batch, date-keyed. Decision gates tracked as `D<N>` in `DESIGN.log.md`; cycle phases as `κ-<N>`.

For the full audit trail, see `git log`.

---

## 2026-05-23

- **RTSC H3X 그룹 14-17 스크린** — H3S(200K) · H3Se(98-128K) · H3Te(72-76K) baseline 위에 H3X 8 후보 본격 dispatch; Vast.ai 11-pod 자율 병렬 가동 (3 orchestrator · 8 fanout); DFT 완주 미도착 (in progress).
- **`process_completed_pod.sh` harness** — Vast.ai pod 결과 처리 21/21 schema 일치 · R4 invariant 박힘; `RTSC.log.md` §9.15 H3X precommit prediction 추가.
- **MONDALOY §9 reverse 캠페인 완주** — SX500급 단결정 초합금 candidate `demiurge-SX500-RE-c1` 도출; `exports/material_discovery/sx500_mondaloy_*_20260522.json` 커밋.
- **upstream patch 일괄 발사 (hexa-lang)** — PR #376 (2 patches: dft-runner NPROC overcommit · `hexa cloud` argv-guard shell-redirect false-pos); PR #378 (4 patches: vastai destroy -y · host CDI fast-fail · verified offer default · offer/machine claim-lock); 6 patches · 649 lines.
- **`dft_runner.sh` source fix** — nproc → physical cores · MPI bind-to-none.
- **project.tape `@D d9`** — Vast.ai trouble → hexa-lang inbox 경로 명문화 (f555697).

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
