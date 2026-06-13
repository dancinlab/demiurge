---
slug: verify-atlas-direct-fold-no-ledger
mode: auto
auto-weights: "complete=3, simple=1, safe=1, std=3 (완성도+표준 우선)"
created: 2026-05-29
scope: cross-repo (hexa-lang stdlib + demiurge)
trigger: 완전 구현 (HANDOFF.md 9-section 강제)
---

# verify atlas-direct-fold · no-ledger architecture

## task brief

`hexa verify --harvest` 한 번에 metric→calculator→tier→atlas atom direct fold
(assumes/recipe/provenance/falsifier meta 흡수). 시스템 전체에서 영구 verdict
파일 = `embedded.gen.hexa` 단 1개. exports/material_*/* · CLAIMS.tape ·
V_six_tier ledger · F-N6.md · attestation JSON · verdict mirror — 모두 git rm.

핵심 원칙 (사용자 명시):
- **소유**: SSOT 파일은 다른 repo 도 쓰니까 hexa-lang stdlib 가 소유 (g61 · d3)
- **확장**: 새 물질/method 들어와도 거부 안 함 — schema-driven dispatch (d4)
- **흡수**: 중간에 발생되는 파일 = 0 (atlas atom 의 meta_blob 으로 모든 정보 흡수)

## locked decisions (8 · auto: complete=3, simple=1, safe=1, std=3)

| Q | 결정 |
|---|---|
| Q1 SSOT | atlas `embedded.gen.hexa` 단일 (영구 파일 1개) |
| Q2 소유 | hexa-lang `stdlib/verify/*` + `stdlib/atlas/atom_format/*` 전체 |
| Q3 harvest flow | `verify --harvest <pod_tar>` (in-process metric→calc→fold) |
| Q4 atom format | `AtomMeta` 확장 (assumes · recipe · provenance · falsifier · timestamp) |
| Q5 ledger 파일 | 전부 폐기 (exports/material_*/* · CLAIMS · V_six ledger · F-N6.md · attestation · recipe JSON · assumption .md · .verdicts mirror) |
| Q6 derive view | atlas dump 위 read-only stdout (영구 파일 아님) |
| Q7 dispatch | generic registry (d4 · 새 fn = registry row 1개) |
| Q8 PR 분할 | hexa-lang 5 PR stacked + demiurge 3 PR (override + cleanup) |

## atlas atom format 확장

```hexa
// stdlib/atlas/atom_format.hexa
record AtlasAtom {
  id:         str            // "allen_dynes_tc::1.21::1350::0.10"
  fn:         str
  args:       [f64]
  value:      f64
  expected:   f64
  tier:       Tier           // 🔵 🟢 🟡 🟠 🔴 ⚪

  meta: AtomMeta {
    assumes:     [str]       // calculator @assumes derive
    domain:      str
    material:    str
    provenance:  str         // 1-line summary
    recipe:      opt str
    falsifier:   opt str
    timestamp:   str         // ISO-8601
    raw_tar_sha: opt str
  }
}
```

## new verify CLI signature

```
hexa verify --harvest <pod_tar_or_path> \
            --domain rtsc \
            --material h3cl \
            [--falsifier F-N6-X] \
            [--recipe @path/recipe.txt]
  ↓
  1. tar 안 metric (λ, ω_log 등) 추출 (kind-pluggable)
  2. dispatch → calculator(allen_dynes_tc)
  3. tier 판정 (recompute vs literature)
  4. atlas atom direct fold (meta 박힘)
  5. verdict verbatim emit (g5)
  6. tar 폐기 또는 transient cache

# 기존 verify --expr <fn> <args> <expected> 도 유지 (simple recompute)
# 변경: --expr 도 pass 시 atlas auto-fold (별 register 명령 불필요)
```

## next-action checklist

### Phase 1 — hexa-lang stdlib (5 PR stacked, 본가 소유, active job 영향 없음)

- [ ] PR-hx1: `stdlib/atlas/atom_format.hexa` — `AtomMeta` 확장 (meta_blob field). 기존 `register --from-verify` 호환 유지 (meta optional).
- [ ] PR-hx2: `stdlib/verify/calculators/*` — `allen_dynes_tc · mcmillan_tc · bcs_gap_ratio · eliashberg_full` 각 fn 에 `@assumes: [str]` metadata 박음. introspect 가능.
- [ ] PR-hx3: `stdlib/verify/dispatch.hexa` — generic registry (d4). `dispatch(fn_name, args) → value`. 새 fn = registry row 1개로 확장. no-name-hardcoding.
- [ ] PR-hx4: `stdlib/verify/harvest.hexa` — `harvest(tar_path, kind) → metrics`. kind-pluggable (dft-elph/sscha/llm-bench/web-smoke). DFT 부터 first impl.
- [ ] PR-hx5: `tool/verify_cli.hexa` 재설계 — `--harvest <tar>` + `--expr <fn> <args> <expected>` 통합. pass 시 atlas auto-fold (별 register 명령 불필요). stale-binary fix (`reference_hexa_verify_expr_stale_binary` 참조 — full self-rebuild).

### Phase 2 — demiurge thin consumer (2 PR + 1 sign-gated)

- [ ] PR-dm1 ⚠ sign-gated: `CLAUDE.md` 의 `d_claim_manifest` directive 폐기 (override 사유 명시). **USER signoff 필요** (sign-gated CLAUDE.md edit) — handoff agent 가 BEFORE EXECUTING 사용자에게 ask.
- [ ] PR-dm2: `RTSC.md` V2 의 7 identity row → `hexa verify --expr` verbatim 명령 + verdict 박기 (smoke-test anchor, hexa-lang Phase 1 의 5 PR 검증).
- [ ] PR-dm3: cleanup + migration — `exports/material_verdict/*` · `exports/material_discovery/*` · `exports/material_attestation/*` · `exports/sweep/*/ledger.json` · `.verdicts/*` · `CLAIMS.tape` (만약 이미 도입됐다면) · per-domain `F-N6.md`·`V_six_tier_*.md` ledger 파일 · `assumption_table*.md` — 모두 git rm. 마이그레이션: 기존 50+ JSON 의 (fn, args, value, expected) 추출 → `verify --expr` 재실행 → atlas fold. 1회성 migration script in handoff agent.

### Phase 3 — verification + closure

- [ ] active RTSC jobs (A11 + Wave-2 6) terminal 후 마이그레이션 진행 (현 진행 중 job 의 harvest 결과는 새 `verify --harvest` 로 처리)
- [ ] `atlas dump --json | jq` 로 모든 기존 verdict 조회 가능 확인
- [ ] V2 7 identity 모두 🟢 / 🔵 (verbatim emit + atlas fold 검증)
- [ ] `RTSC.md` 47% → 새 calculator coverage 반영 갱신
- [ ] HANDOFF.md 9-section 자동 작성 (PR ≥ 3 → trigger)
- [ ] memory mirror: `~/.claude/projects/-Users-ghost-core-demiurge/memory/project_verify_atlas_direct_fold_handoff.md` + `MEMORY.md` 한 줄 pointer
- [ ] ship: 8 PR merged · 마이그레이션 PR · HANDOFF.md · MEMORY 갱신

## completion criteria

- hexa-lang 5 PR merged (atom_format · calculators · dispatch · harvest · verify_cli 재설계)
- demiurge 3 PR merged (CLAUDE override · RTSC.md V2 verbatim · cleanup migration)
- 기존 exports/material_*/* 50+ JSON 마이그레이션 + git rm 완료
- atlas dump 가 모든 기존 verdict 표출
- 새 material 등록 = `verify --harvest <tar>` 1회 (코드 변경 0, 파일 생성 0)
- `embedded.gen.hexa` 가 유일한 영구 verdict 파일 (시스템 전체)
- d_claim_manifest CLAUDE.md 폐기

## halt-before (sbs Step 6 · irreversible/destructive/outward-facing)

handoff agent 는 다음 시점 USER 에게 ask:
1. **CLAUDE.md sign-gated edit** (PR-dm1) — sidecar sign 요청 필요
2. **exports/material_*/* mass git rm** (PR-dm3) — 50+ JSON 파일 irreversible
3. **hexa-lang main land** — `gh pr create --head` 패턴 (local FF rejected per memory)

## risks

- d9 (worktree concurrent agent index isolation): sequential commit, explicit `git add <files>`
- pr-cycle hook auto-merges (`gh pr create` → `&& gh pr merge --squash --admin --delete-branch`)
- worktree `/tmp/wt-*` reaper → `~/core/<repo>-<slug>` 사용 (feedback_tmp_worktree_reaped)
- hexa-lang main FF rejected → `gh pr create --head` (feedback_hexa_lang_main_land_via_pr)
- verify_cli stale binary (#1213) — full self-rebuild on hexa-lang Phase 1 land
- RTSC active jobs (A11 grinding + Wave-2 6) 와 cleanup 충돌 → Phase 3 = active terminal 후

## stacked PR-cycle hint

8 PR 진행 시 단일 worktree (`~/core/hexa-lang-verify-pr-cycle` · `~/core/demiurge-verify-pr-cycle`) 안 branch 갈아끼우는 패턴 권장 — `git reset --hard origin/main && git checkout -b feat/<n>` 매 PR. 5-10× 빠름.

## qa-results (2026-05-29 · 6 PR landed)

5 hexa-lang PR (#2023 + **#2027 + #2028 + #2029 + #2032**) + 1 demiurge PR (**#511**) merged. 총 1438 SLOC.

### QA 4축

| 축 | 결과 |
|---|---|
| Functional | 48/48 smoke PASS verbatim — calculators 6/6 · dispatch 19/19 · harvest 14/14 · CLI 9/9 |
| Visible | V2.2 verdict origin/main 에 present (`allen_dynes_tc::1100.0::2.5::0.13` atom_id + `GREEN_MEASURED` marker) |
| Conformance | d4 (no name hardcoding) · d6 (sscha/llm-bench/web-smoke honest STUB) · g5 (verdict verbatim) 모두 ✓ |
| Regression | 기존 stdlib/math/exp.hexa 7/7 PASS 유지 · 깨진 것 없음 |

### qa-deferred (plan halt-before 발동 1건)

- **PR-hx5 시 `tool/verify_cli.hexa` baseline broken at origin/main** (`jordan_totient` undeclared, memory#1213 stale-binary 추정). 본 chain 책임 아님 — 새 CLI `tool/verify_harvest_cli.hexa` 를 **독립 entry** 로 우회. atlas-persistence (embedded.gen.hexa direct fold) 는 verify_cli main path 복구 후 별 PR.

### Deferred (별 PR 후속)

1. `tool/verify_cli.hexa` baseline 복구 (jordan_totient declare 또는 stale binary regenerate)
2. `embedded.gen.hexa` atlas-persistence (현재는 in-process side-table demo)
3. `omega_log_moment` · `beenet_grid_bins` · `migdal_ratio` · `lambda_eliashberg` calculators (V2 Identity 4-7, d6 honest 🟠 유지)
4. `sscha` · `llm-bench` · `web-smoke` harvest kind impl (concrete fixture 확보 후)
5. **Phase 3 cleanup** — `exports/material_*` · `.verdicts/*` · per-domain ledger git rm. active RTSC jobs (A11 + Wave-2 6) terminal + 사용자 confirm 후.

### end-user-dossier

SKIP — developer-internal infrastructure (사용자 직접 사용 surface 아님).

### Artifacts

- HANDOFF: `domains/HANDOFF_verify_atlas_direct_fold.md` (9-section)
- Memory: `project_verify_atlas_direct_fold_handoff.md` + MEMORY.md L1 한 줄 pointer
- Plan SSOT: this file
