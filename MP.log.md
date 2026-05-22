# MP — historical log

Spec at [`./MP.md`](./MP.md). Log entries below preserve session-by-session evolution; the spec file holds only the current confirmed state.

## Log

- **2026-05-21 KST** — opened. RTSC.md §8.7 Tier 1 의 입력 데이터 100% self-contained 화 로드맵. Phase 1-5 (P1 MP cache · P2 COD/AFLOW/NIMS · P3 QE+W90+EPW DFT · P4 sim_adapter input pipeline · P5 own H-formulation .pro) + API-key-dependent 선택 enhancement. 핵심 주장: **MP_API_KEY 없이도 sim 입력 100% 채울 수 있음**.
- **2026-05-22 KST** — **R1 cohort partial complete** (rate-limit hit + 수동 완성). Phase 1.2-1.5 land:
  - **P1.2** 28 entry cache 안착 (LK-99 family 3 entry 는 2026-05-22 aggressive scrub 으로 제거 — `inbox/notes/2026-05-22-lk99-final-scrub.md`). per_family_stats: lts 7/7 · mgb2 1/1 · fesc 7/8 · cuprate 6/6 · 등 · cached_skips 28
  - **P1.3** Schema doc at `exports/material_cache/mp/_SCHEMA.md` (top-level field 정의 + CC-BY-4.0 attribution + Batch summary 형식)
  - **P1.4** mp_query.py disk-cache fallback — DEFERRED (mp_query.py 가 project.tape session 에 의해 origin 제거됨; constitution.md 와 함께 user 수작업 예정)
  - **P1.5** Cache provenance migration — 28/28 files 에 `cached_at` + `mp_id` + `source_dump_version` field 보강 (Python migration script · `_attribution` 는 기존 batch ingest 가 이미 박음)
  - **B**: BETE-NET activation milestone (`inbox/notes/2026-05-22-bete-net-activation.md`) — venv + 100-ensemble Nb inference 35s · 454% rel_err vs 측정 (R4 invariant 의 empirical 강화)
  - **R4** Stage 3 audit hook LANDED (`PAPERS/_tools/audit_attestation_records.sh` · 323 lines · 4/4 fixture PASS · live audit 0 violations · 1 historical · 1 ok)
