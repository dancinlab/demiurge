# MP cache schema (R1 P1.3)

> MP.md Phase 1.3 — 로컬 MP 캐시 디렉토리의 JSON record 형식 정의.
> 모든 entry 는 `exports/material_cache/mp/<formula_slug>.json` 경로.
> Migration applied: 2026-05-22 (P1.5 cached_at + mp_id + source_dump_version
> 보강 — 28/28 files).

## Required top-level fields

| field | type | note |
|---|---|---|
| `domain` | string | `"material"` |
| `verb` | string | `"query"` |
| `kind` | string | `"mp_query"` |
| `stamp` | string | ISO8601 (`YYYY-MM-DDTHH:MM:SSZ`) |
| `producer` | string | `"mp_query.py@<version>"` or `"mp_batch_ingest.py@<version>"` |
| `measurement_gate` | string | `"GATE_OPEN"` (MP DFT is *prediction*, not measurement) |
| `absorbed` | bool | **MUST be `false`** (R4 invariant: MP DFT ≠ measurement) |
| `gate_type` | string | `"external-api"` (live hit) · `"cached-mirror"` (disk cache hit) · `"api-key-missing"` |
| `provisional` | bool | `true` (Tier 1 sim, RTSC.md §8.7 永遠 honest限界) |
| `query` | object | `{formula, mp_id?}` |
| `rows` | array | MP REST response entries; may be empty |
| `row_count` | int | `len(rows)` |
| `scope_caveats` | array of string | 본 cache 의 한계 명시 |
| `citations` | array | provenance citations |
| **`cached_at`** | string | ISO8601 시점 (P1.5) |
| **`mp_id`** | string or null | First-hit MP material_id (P1.5) |
| **`source_dump_version`** | string | Batch ID 또는 dump version tag (P1.5) |
| **`_attribution`** | string | CC-BY-4.0 attribution verbatim (P1.5) |

## CC-BY-4.0 attribution

모든 cached file 의 `_attribution` 필드는:

```
Cached from Materials Project (materialsproject.org). Licensed CC-BY-4.0. Cite: Jain et al. APL Materials 1, 011002 (2013).
```

DOI: 10.1063/1.4812323

## Batch summary file

`exports/material_cache/mp/_batch_summary.json` — 일괄 cache 작업의 summary record. R1 P1.2 가 ~100 SC family entry batch ingest 결과를 여기 기록.

| field | note |
|---|---|
| `batch_stamp` | ISO8601 |
| `total_queried` / `total_hit` / `total_miss` | 통계 |
| `api_calls_made` | live hit 수 (`cached_skips` 와 별도) |
| `per_family_stats` | RTSC.md §8.2 family 별 hit/miss breakdown |
| `scrub_note` | 후속 scrub 작업 anchor (예: 2026-05-22 LK-99 family 제거) |

## Honest invariants (R4 보호)

- **absorbed=false 영구** — MP DFT 결과는 *prediction*, *measurement* 아님 (R4 + RTSC.md §8.7 Tier 1 honest限界)
- `gate_type=cached-mirror` (disk cache 활용 시) — *namespace exploit 아님*: domain="material" 이지 "rtsc" 아님
- `_attribution` field 누락 시 cache record invalid (CC-BY-4.0 의무)
- `cached_at` + `mp_id` 누락 시 audit/dedup 불가 → P1.5 field 의무

## 후속 — Phase 4 (sim_adapter input pipeline)

MP cache 가 sim_adapter input 의 *cache layer* 가 됨 (MP.md §2 Phase 4):
- priority chain: measured > DFT-computed-cached > **MP-cached** > COD > AFLOW > literature > hard-code
- `provenance.source_chain` 에 cache hit 명시 (`mp_cache:Nb` 같은 form)

## Cross-reference

- MP.md (parent roadmap · §2 Phase 1)
- RTSC.md §8.7 Tier 1 (sim 영역)
- constitution R4 invariant (intentionally removed by project.tape session — doctrinal source 별 보관 예정)
- `~/core/hexa-lang/stdlib/material/mp_batch_ingest.py` (cache writer · 현재 origin 에서 제거됨 by project.tape · 본 cache 는 이전 batch ingest 산출물)
