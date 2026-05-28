# HANDOFF — verify-atlas direct-fold (no-ledger architecture)

**Date**: 2026-05-29
**Plan SSOT**: `drafts/verify-atlas-direct-fold-no-ledger-plan.md` (demiurge)
**Trigger**: PR ≥ 3 merged (실제 6 PR · auto-trigger 충족)
**Sibling HANDOFF**: `domains/HANDOFF.md` (다른 작업 — Web GUI 9-step)

## 1. Summary

`hexa verify --harvest` 한 번에 `metric → calculator → tier → atlas atom direct fold` (assumes/recipe/provenance/falsifier meta 흡수). 시스템 전체에서 영구 verdict 파일 = `embedded.gen.hexa` 단 1개. 본 작업은 그 architecture 의 **stdlib + CLI infrastructure** 를 6 PR 로 land.

- **Phase 1 (hexa-lang stdlib · 5 PR)**: atom_meta side-table · calculators + @assumes · generic dispatch · kind-pluggable harvest · end-to-end CLI capstone.
- **Phase 2 (demiurge consumer · 1 PR)**: RTSC V2.2 — 7 identity 중 3 식 verbatim 🟢 등급 박음.

## 2. Merged PR list

| # | repo | id | scope | SLOC | smoke |
|---|---|---|---|---|---|
| 1 | hexa-lang | #2023 hx1 | atom_meta side-table | (prior) | (prior) |
| 2 | hexa-lang | **#2027 hx2** | calculators + @assumes | 292 | 6/6 |
| 3 | hexa-lang | **#2028 hx3** | generic dispatch | 253 | 19/19 |
| 4 | hexa-lang | **#2029 hx4** | kind-pluggable harvest | 342 | 14/14 |
| 5 | hexa-lang | **#2032 hx5** | end-to-end CLI capstone | 386 | 9/9 |
| 6 | demiurge | **#511 dm2** | RTSC V2.2 verbatim replay | 165 | (verdict atoms 4) |

총 **1438 SLOC across 6 PR** · smoke **48/48 PASS verbatim** (Phase 1 합).

(prior governance PR: #510 demiurge `d_atlas_as_audit_ssot` 신설 + `d_claim_manifest` 폐기.)

## 3. SSOT files

| path | repo | role |
|---|---|---|
| `stdlib/atlas/atom_meta.hexa` | hexa-lang | AtomMeta + AtomMetaStore side-table (PR-hx1) |
| `stdlib/verify/calculators/{bcs_gap_ratio, eliashberg_full, assumes_meta, mod}.hexa` | hexa-lang | new calculators + @assumes registry (PR-hx2) |
| `stdlib/verify/dispatch.hexa` | hexa-lang | generic name→fn registry (PR-hx3) |
| `stdlib/verify/harvest.hexa` | hexa-lang | kind-pluggable metric extraction (PR-hx4) |
| `tool/verify_harvest_cli.hexa` | hexa-lang | end-to-end CLI entry (PR-hx5 capstone) |
| `domains/RTSC/verify/V2_formal_identities.md` (§ V2.2) | demiurge | 7 identity verbatim replay (PR-dm2) |
| `project.tape` `@D d_atlas_as_audit_ssot` | demiurge | governance directive (PR #510, prior) |

## 4. Public CLI

```
hexa run tool/verify_harvest_cli.hexa \
    --harvest <pod_tar_or_dir_or_file> \
    --kind     <dft-elph|sscha|llm-bench|web-smoke> \
    --fn       <allen_dynes_tc|mcmillan_tc|bcs_gap_ratio|eliashberg_full|universal_cooper_tc> \
    --domain   <rtsc|...> \
    --material <h3s|...> \
    [--expected <float>]
    [--falsifier <id>]
```

PIPELINE: harvest → dispatch → tier judgment 🔵/🟢/🟠/🔴/⚪ → AtomMeta in-process side-table fold → verbatim emit (g5 compliant).

## 5. QA 4축 (auto-run)

| 축 | 결과 |
|---|---|
| Functional | **48/48** smoke PASS (calculators 6/6 · dispatch 19/19 · harvest 14/14 · CLI 9/9) verbatim |
| Visible | V2.2 verdict origin/main 에 present (allen_dynes_tc::1100.0::2.5::0.13 atom_id + GREEN_MEASURED marker) |
| Conformance | d4 (no name hardcoding · single dispatch.hexa registry) · d6 (sscha/llm-bench/web-smoke honest STUB) · g5 (verbatim verdict) 모두 ✓ |
| Regression | 기존 stdlib/math/exp.hexa 7/7 PASS · atom_meta no-main module · 깨진 것 없음 |

## 6. Known limitations / deferred

1. **`tool/verify_cli.hexa` baseline broken at origin/main** — `jordan_totient` undeclared (clang link). 본 PR-hx5 책임 아님 (memory#1213 stale-binary 추정). 새 CLI 는 **독립 entry** 로 우회.
2. **atlas-persistence to `embedded.gen.hexa`** — PR-hx5 의 AtomMeta fold 는 in-process side-table demo. embedded.gen.hexa direct fold 는 verify_cli main path 복구 후 별 PR.
3. **`omega_log_moment` · `beenet_grid_bins` · `migdal_ratio` · `lambda_eliashberg`** — V2 의 Identity 4-7 calculator 부재. d6 honest 🟠. 별 PR 로 stdlib/verify/calculators/{...}.hexa 추가 필요.
4. **`sscha` · `llm-bench` · `web-smoke` harvest kind** — d6 honest STUB (ok=false). concrete fixture 확보 후 별 PR.
5. **Phase 3 — legacy exports cleanup** — `exports/material_verdict/*` · `exports/material_attestation/*` · `exports/material_discovery/*` · `exports/sweep/*/ledger.json` · `.verdicts/*` 등 50+ JSON git rm. **active RTSC jobs (A11 + Wave-2 6) terminal + 사용자 confirm 후** 별 PR.

## 7. How to extend (new calculator)

새 closed-form fn 추가 절차 — **3 곳에 한 줄씩**:

1. `stdlib/verify/dispatch.hexa` if-else cascade (`dispatch_known` + `arity_of` + `dispatch`)
2. `stdlib/verify/calculators/assumes_meta.hexa` (`known_calculators` + `assumes_for` + `provenance_for`)
3. 만약 fn impl 이 numerics_* 외부에 있으면 새 파일 `stdlib/verify/calculators/<fn>.hexa`

verify_cli 자체 수정 필요 없음 (d4 generic dispatch · CLI 가 fn 이름을 박지 않음).

## 8. How to extend (new harvest kind)

새 sim/bench kind 추가:

1. `stdlib/verify/harvest.hexa` `harvest()` dispatch 에 `if kind == "<new>"` 분기 + private `_harvest_<new>(path) -> Metrics` 추가
2. `supported_kinds()` 에 한 줄 추가
3. fixture-based smoke 행 추가

## 9. Reproduction (end-to-end)

```bash
# 1. fresh hexa-lang main
cd ~/core/hexa-lang
git pull origin main  # PR #2032 머지 후

# 2. fixture (mock QE ph.out)
mkdir -p /tmp/repro && cat > /tmp/repro/ph.out << 'EOF'
     Average el-ph coupling lambda  =   2.5
     Average <log w>                =   1100.0 K
EOF

# 3. verbatim verdict
hexa run tool/verify_harvest_cli.hexa \
    --harvest /tmp/repro \
    --kind dft-elph --fn allen_dynes_tc \
    --domain rtsc --material h3o \
    --expected 181.16 --falsifier F-RTSC-AD-1

# expected verbatim emit:
#   DISPATCH: allen_dynes_tc[1100.0, 2.5, 0.13] = 171.086
#   TIER: 🟢 GATE_CLOSED_MEASURED (code=G)
#   ATOM_META (in-process side-table fold):
#     atom_id    = allen_dynes_tc::1100.0::2.5::0.13
#     ...
#   __VERIFY_HARVEST__ GREEN_MEASURED
```

---

**governance trail**: PR #510 (project.tape d_atlas_as_audit_ssot) → 5-PR hexa-lang chain (#2023·#2027·#2028·#2029·#2032) → PR #511 demiurge V2.2 verbatim replay.

**plan halt-before 발동 1건**: PR-hx5 시 `tool/verify_cli.hexa` baseline broken — 독립 entry 로 우회 (사용자 보고 in PR #2032 body).
