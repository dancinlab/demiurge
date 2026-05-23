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
- **2026-05-23 KST** — **Phase 2 P2.1 LANDED** (Cycle-4 follow-up). COD CIF parser thin adapter `~/core/hexa-lang/stdlib/material/cod_query.py` (397 LOC, pure python · stdlib HTTP + pymatgen) recognized as Phase 2 first deliverable. Adapter shape:
  - Endpoint chain: `http://www.crystallography.net/cod/result?text=<comp>&format=csv` → 7-digit COD ID 인덱스 추출 → `/cod/<id>.cif` 다운로드 (MAX_CIFS_TO_FETCH=3 courtesy cap, 30s timeout) → `pymatgen.Structure.from_str(fmt="cif")` → `{cod_id, formula_reduced, formula_full, nsites, lattice{a,b,c,α,β,γ,vol}, spacegroup, density_g_cm3, parse_error, cif_url}` row.
  - Record schema 는 MP cache (`_SCHEMA.md`) 와 mirror — same R4 invariants: `domain=material` · `verb=query` · `kind=cod_lookup` · `measurement_gate=GATE_OPEN` · **`absorbed=false` 영구** (structure-only-no-property 한계, scope_caveats s1-s4 명시) · `gate_type` ∈ {external-api, external-api-failed, install-gated} · `provisional=true` · provenance + citations + attribution + license=public-domain.
  - Family classifier 는 mp_query / oqmd_query 와 sync (lts · mgb2 · heavy-hydride · hts-cuprate · iron-sc · apatite-class · unclassified).
  - **Live test (MgB2)**: 6 COD ID 발견 → 3 CIF parse PASS · sample row `cod=4339017 reduced=MgB6H28(C2O)2 sg=Pca2_1 nsites=164` · gate_type=external-api · record at `/tmp/mp_p21_test/material_query_cod_*.json`.
  - **Canonical home (d3)**: MP/COD/OQMD/JARVIS adapter는 `~/core/hexa-lang/stdlib/material/` 의 sibling (mp_query.py · oqmd_query.py · cross_code_dft.py 와 동일 레이어). demiurge 는 spec/log 만 (MP.md · MP.log.md). Original land: hexa-lang commit `9f343d1b` (wip rocm + stdlib material), aggressive LK-99 scrub 1cbf4ff2 통과. Phase 2 첫 source 로서 P2.4 (priority chain) 의 입력 한 줄 확보.
