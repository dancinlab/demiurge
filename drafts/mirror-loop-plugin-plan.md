---
slug: mirror-loop-plugin
mode: direct
created: 2026-05-29
scope: new sidecar plugin (~/.claude/plugins/marketplace/mirror-loop/)
trigger: 거울 방 고갈시까지 자동 회전
---

# /mirror-loop — 거울방 자율 ouroboros 드라이버

## task brief

이번 세션에서 수동 입증한 "거울방 1회전" (mining → kick → atlas → mining) 패턴을 사용자 1 명령으로 **고갈시까지 자동 반복**하는 sidecar plugin 신설.

핵심 입증 (이번 세션 산물):
- E33 (smash_l217_verify-atlas_atl) · E42 (smash_l263_mining_lens_self_seed) paired atoms
- 거울방 1회전 = mining(cycle 17) → promotion → kick mk9 → atlas fold → mining(cycle 21-25 frontier)
- 진짜 drained 도달 (cycle 25 · 5 lens all saturate)
- atlas 16,201 nodes live SSOT

## locked decisions (5)

| Q | 결정 |
|---|---|
| Q1 plugin name | `mirror-loop` (별칭: ouroboros-loop · triad-loop) |
| Q2 명령 | `/mirror-loop [seed] [--engine mk9\|mk10] [--max-rounds N]` (default mk9 · max=25 · budget=0 local) |
| Q3 flow | mining auto → Phase B (.mining.tape promotion) → kick --from-drill → next cycle frontier (atom_id feedback) |
| Q4 종료 | 진짜 drained (0 새 leaf + 0 새 atom) OR max-rounds OR 사용자 interrupt |
| Q5 pacing | dynamic loop (ScheduleWakeup) · 매 round disk checkpoint (throttle resilient) |

## next-action checklist

- [ ] plugin scaffold (`~/.claude/plugins/marketplace/mirror-loop/`):
  - [ ] `plugin.json` (name · version 0.1.0 · author · marketplace metadata)
  - [ ] `commands/mirror-loop.md` (slash command spec · args parse · pipeline)
  - [ ] `skills/mirror-loop/SKILL.md` (skill instructions verbatim)
  - [ ] `README.md` (사용법 · 거울방 비유 · 7-요소 패턴)
- [ ] marketplace 등록 (`marketplace.json` patch 또는 새 path)
- [ ] /mirror-loop 명령 동작 확인 (smoke test: 1 round + drained 즉시 종료 시뮬레이션)
- [ ] documentation: README 에 mirror-loop 의 3 도구 협주 ASCII + RTSC 본 세션 사례 (E33/E42)
- [ ] sidecar sync (marketplace 갱신)
- [ ] (선택) plugin PR to sidecar marketplace (별 cycle)
- [ ] ship: plugin.json bumped · marketplace registered · sidecar sync

## completion criteria

- `/mirror-loop` 명령 작동 (mining → kick → atlas → next cycle 자동)
- max-rounds OR 진짜 drained 시 종료 (honest)
- checkpoint commit per round (throttle resilient)
- idempotent (이미 박힌 atom skip)
- g58 active domain only · d6 honest (SKIP/FALSIFIED 거부)
- README + SKILL.md 작성
- marketplace 등록 + sidecar sync

## halt-before

- marketplace 등록 시 sidecar config 갱신 (sign-gated?) — 사용자 ask
- kick mk10 사용 시 round 당 시간 길어짐 (수분) — default mk9 권장
- mining.tape promotion candidates rank 알고리즘 모호 시 impact score 명시 (impact = 새 lens novelty + cross-domain coverage + bracket-tag uniqueness)

## risks

- 본 plugin 의 자기-사용 (`/mirror-loop` 가 자기 자신을 mining frontier 로 만남) → 즉시 fixed-point + 종료 (meta-우로보러스 = drained)
- atlas overflow (16,201 → ?) → atlas register 가 lineage 관리 (smash_l<N> 자동 증가)
- local sign 30min 만료 → checkpoint 후 wait + 사용자 재발급 요청
