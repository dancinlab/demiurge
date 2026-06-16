# .discoveries — 연속 발견 로그

> `*_discovery` / `*_discovery_log` — `/kick` · `/gap` 발견을 매 배치 연속 수행하고
> 결과를 `.discoveries/<slug>.tape` 에 적재 (id · seed · verdict-tier-target).

흐름: 발견 → `CLAIMS.tape` claim → `hexa verify` → `.verdicts/` → `paper_on_discovery` (자유 slug 논문).
발견은 cycle 끝에 몰지 않고 verify 와 병행. 모든 발견은 폐기/의역 없이 기록.

## 로그 (log)

- 2026-06-16 · `ambient-tc-levers` — AMBIENT-pressure room-temp SC scoping: Lever A (light-atom ω_log↑, phonon-mediated, QE/QFORGE-testable) + Lever B (flat-band correlation, non-phonon, method-blocked). seed=branch off heavy-atom flat-band kagome λ-reference. verdict-tier-target=🟢 GATE_CLOSED_MEASURED via free-pool QE scf+bands metallicity/flat-band screen (Lever A); Lever B = ingredient-only (cRPA/DMFT build-out long-pole). FREE local reasoning, no pods.
