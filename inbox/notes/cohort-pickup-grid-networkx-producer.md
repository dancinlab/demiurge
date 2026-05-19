# incoming note: cohort-pickup-grid-networkx-producer — next cohort producer candidate after κ-34 (sscb)

> **id**: `cohort-pickup-grid-networkx-producer` · **opened**: 2026-05-20 KST · **status**: `pickup — not yet implemented`
> **source**: P-⑧ lowest-hanging-fruit analysis (κ-34 prep). κ-34 picked **sscb + analyze (ngspice)** as the first cohort producer; this note carries the runner-up so the next round can pick it up without re-doing the analysis.
> **scope**: ONE cell of grid.md — `grid + structure` (= architect) — wired to a real NetworkX-based topology producer. NOT the full 7-verb grid stack.

---

## Why grid is the runner-up (after sscb)

From the κ-34 scan of all 13 cohort domains in `domains/*.md` §2 tool maps:

| factor | grid (networkx) | sscb (ngspice) — picked κ-34 |
|---|---|---|
| 도구 설치 | python3 + networkx 3.2.1 already on host (no install) | ngspice 46 already on host (brew) |
| CLI 한 줄 | `python3 -c "import networkx as nx; ..."` → JSON | `ngspice -b sscb_v1.cir` → log + raw |
| 측정 명확도 | graph metrics (diameter, avg path, bisection BW) — combinatorial, deterministic | transient (rise_time, interrupt_ratio) — IEEE-754, deterministic |
| GOAL 정합 | DC fabric topology IS a measurable design artifact (rfc_009 spirit) | SSCB transient IS a measurable circuit verdict |
| caveat 분명함 | "그래프 메트릭 ≠ 실제 BW (no SerDes channel model)" | "ngspice ≠ datasheet 흡수 (no Wolfspeed .lib)" |

Both score 9-10/10 on tooling-access; grid is **slightly behind** only because the verb fit is `structure` (architect, a "specify"-adjacent verb that D53 deferred to LLM fallback originally) — sscb's `analyze` lands cleanly in the "측정 가능한 2 verb" set per D53.

## The producer skeleton (for the next agent)

**Files** (mirror sscb κ-34 layout):
- `cockpit/scripts/grid_networkx.py` — generates a fat-tree / leaf-spine / dragonfly topology with NetworkX, computes `diameter`, `avg_shortest_path`, `bisection_bandwidth` (min-cut), writes `<output_dir>/grid_topology_v1.{gml,meta.json}`.
- `cockpit/Sources/DemiurgeCore/Models/GridRecord.swift` — typed sidecar mirroring SSCBRecord (interface = `"demiurge:grid:topology-record"`, producer = `"networkx@<version>"`, gate = GATE_OPEN, absorbed = false).
- `cockpit/Sources/DemiurgeCore/Loaders/GridProducer.swift` — Swift spawner.
- `ActionDispatch.swift` add `case (.structure, "grid")` → `runGridStructure()`.

**Measurements** (deterministic, no datasheet):
- `radix` · `pod_count` · `host_count`
- `diameter` (max shortest path between any two hosts)
- `avg_shortest_path_hops`
- `bisection_bandwidth_links` (min-cut size, links not Gbps — no SerDes assumption, honest g3)
- `link_count`

**Scope caveats** (record these in provenance):
1. NetworkX graph metrics ≠ real BW (no SerDes channel, no congestion-control model — domains/grid.md §4 "3-D full-wave SI" gap stays open).
2. plausible fat-tree per Al-Fares 2008 / OCP open-rack topology — not pulled from a Meta/Google production manifest.
3. measurement_gate = GATE_OPEN — NetworkX IS the instrument (graph metrics are real numbers) but the *abstraction* is plausible-not-absorbed.
4. absorbed=true 금지 — real fabric design requires ns-3 / SST simulation (domains/grid.md §2 ANALYZE) + HFSS / Sigrity SI (§4 gap). NetworkX layer is one verb of a longer chain.

## Effort estimate

- script: 1-2 hours (NetworkX is stdlib-like, no install)
- Swift record + loader: 30 min (sscb κ-34 is the template)
- ActionDispatch + design.md D-decision: 30 min
- build + smoke test: 30 min
- **total: half day** — comparable to κ-34's sscb wiring.

## Status

Not implemented. The next session can pick this up. Producer scope is intentionally narrow (one cell) per D53 measurable-only mapping — do NOT try to wire all 7 grid verbs at once.

## Cross-reference

- κ-34 commit (sscb producer prototype) — the template to copy.
- `domains/grid.md` §2 tool map row "구조 ARCHITECT" (NetworkX) — the canonical citation.
- D53 (measurable-only cell mapping) — the policy that allows narrow scope.
- D55 (κ-34 — cohort producer mapping policy) — the precedent.
