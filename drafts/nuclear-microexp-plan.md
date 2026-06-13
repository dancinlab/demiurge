---
slug: nuclear-microexp
mode: auto
auto-weights: "1:1:1:1 (완성도·단순·안전·표준)"
created: 2026-05-29
domain: NUCLEAR (RTSC+NUCLEAR 메타도메인 산하 elemental funnel)
---

# NUCLEAR micro-exp — 차기 cohort 핵종 sweep

## task brief

RTSC 에 적용한 micro-exp 패턴을 NUCLEAR elemental funnel 에도 적용한다.
차기 cohort 후보 핵종(superheavy Z=119/120 + drip-line, N11 이후 미커버)을
nuclear-sim micro-exp 로 local-pool sweep — HFB mass/binding + WKB α/SF 반감기
→ island_weight rank → 가속기 beam-time priority. absorbed=false 영구
(sim PASS = wet-lab priority hint, NOT discovery claim).

## locked decisions (5 · auto-picked 1:1:1:1)

- Q1 대상: NUCLEAR elemental funnel (핵종 sweep) — 메타 cross-domain 아님 (bridge/parity [x] 완료)
- Q2 scope: 차기 cohort — N11 funnel(top_k_novel.json) 이후 미커버 superheavy Z=119/120 + drip-line
- Q3 kind: nuclear-sim — HFB mass(hfbtho_adapter) + WKB α/SF 반감기(sim.hexa) → island_weight rank
- Q4 surface: local-pool ($0 · nuclear sim 경량, RTSC DFT 와 달리 pod 불요)
- Q5 infra: hexa-lang stdlib/nuclear 재사용 (sim.hexa · dripline.hexa · hfbtho/shell/abinitio adapters · N11 funnel 패턴)

## next-action checklist

- [ ] NUCLEAR domain SELECT (active) — `domain set NUCLEAR`
- [ ] micro-exp Stage 1 — candidate matrix 도출 (차기 cohort 핵종 id·Z·N 목록)
- [ ] Stage 1.5 infra existence check — hexa-lang stdlib/nuclear sim 코드 + 입력(nubase/dripline) READY 확인 (MISSING 시 /cycle-bg HALT)
- [ ] Stage 2-3 pre-flight + plan table (local-pool host · candidate matrix)
- [ ] Stage 4 dispatch — local-pool sweep (HFB mass + WKB α/SF → island_weight) per 핵종
- [ ] Stage 5 aggregate — ledger (per-candidate verdict + island rank) · g63 honest (every candidate verify tier · FALSIFIED closed-negative)
- [ ] island_weight rank → top-K priority (가속기 beam-time hint)
- [ ] ship — ledger + rank 를 exports/nuclear_discovery/n12_funnel/ (또는 sweep/) + domains/NUCLEAR.log.md 한 줄

## completion criteria

- 차기 cohort 핵종 N개 각각 verify tier 도달 (g63 — FALSIFIED 도 closed-negative 로 보존)
- island_weight rank top-K 산출 (가속기 priority hint)
- ledger 영속 (exports/) + NUCLEAR.log.md 갱신
- absorbed=false 영구 유지 (sim ≠ measurement · wet-lab oracle 부재)
- local-pool $0 (pod rent 0)
