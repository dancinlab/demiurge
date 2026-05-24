# V2 — LPA 🔵 SUPPORTED-FORMAL push (atlas register + verify --expr)

@goal: V1의 8건 🔵 target 중 가능한 만큼을 hexa atlas + verify --expr로 closed-form 등록 — 실패분은 hexa-lang inbox PR로 calculator gap을 upstream

## §1. hexa atlas / verify 현재 capability (2026-05-24 측정)

### atlas stats VERBATIM
```
atlas: loaded 16062 nodes from atlas.n6
ATLAS_HASH         67fbb6057245edf362999d8fa55ccf50990b771a17667e57869596f72fe97926
ATLAS_SOURCE_COUNT 11
P primitives       455
C constants        5763
L laws             531
E experiments      12
F formulas         1309
R relations        6319
S symmetries       10
X crossings        1580
Q open questions   83
total nodes        16062
```

### verify rubric (calc fns 한정)
```
calc fns : sigma|sigma_0|sigma_2|phi|mu|tau|is_perfect|aliquot|gamma0_index|
           gamma0_cusps|gamma0_genus|isotropy_lcm|first_cusp_form_weight
2-op: sigma_k|jacobi|kronecker|dim_cusp_forms  (extend _recompute on gap)
```

**관찰**: 현재 `_recompute`는 number-theory only. biostat (IVW · Schoenfeld · binary
sample · NNT)에 대한 dispatch는 **부재** → 모든 LPA 🔵 target이 🟠 INSUFFICIENT
로 떨어짐. atlas는 16,062 nodes이지만 biostat formula 0개 (sigma 6→12만 🔵 baseline).

### lookup 결과
```
$ hexa atlas lookup ivw
# not found: ivw (searched P, C, L, E, F, R, S, X, Q)
```

## §2. IVW formula 정의 + Burgess 인스트런먼트 예제 (PRIMARY)

```
β_xy = Σ(β_xi · β_yi / σ_yi²) / Σ(β_xi² / σ_yi²)
SE   = 1 / sqrt(Σ(β_xi² / σ_yi²))
HR   = exp(β_xy)
```

**Burgess 2018 JAMA Cardiol 3:619** — Lp(a) (1-SD ↓) → CHD
- instruments: 3 (rs10455872 · rs3798220 · rs186696265)
- n=72,869 (CARDIoGRAMplusC4D)
- β_IVW = **-0.342490** · SE = 0.028774 · Z = -11.90
- HR = exp(-0.342490) = **0.7099 ≈ 0.71** (95% CI 0.67-0.75)

## §3. atlas 등록 시도 결과

### 3.1 `hexa atlas register --from-verify` 시도 (verdict VERBATIM)

```
$ hexa atlas register --from-verify ivw 3 1
hexa atlas register --from-verify ivw(3) = 1
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'ivw'
  gap    = extend tool/atlas_cli.hexa::_recompute_register (계산기시스템 개선)
```

```
$ hexa atlas register --from-verify sigma 6 12
hexa atlas register --from-verify sigma(6) = 12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form; @D g_self_verify · TECS-L Tier1)
error: embedded.gen.hexa not found at ./compiler/atlas/embedded.gen.hexa
```
→ sanity는 🔵 verdict 확인되나 binary-built-in fold는 cwd 의존 (compiler/ 경로 부재). PR-only landing path 필요.

### 3.2 `hexa atlas append-witness` — 4건 staging 성공

| witness shard | kind | id |
|---|---|---|
| `n6/atlas.append.witness-1779574912000-lpa_ivw_burgess.n6` | F | lpa_ivw_burgess |
| `n6/atlas.append.witness-1779574920000-lpa_schoenfeld.n6` | F | lpa_schoenfeld |
| `n6/atlas.append.witness-1779574923000-lpa_binary_sample.n6` | F | lpa_binary_sample |
| `n6/atlas.append.witness-1779574924000-lpa_nnt.n6` | F | lpa_nnt |

병렬 agent가 이미 staging한 shard도 존재:
- `n6/atlas.append.witness-1779574445000-ivw-lpa-burgess2018.n6` (@L law-reference)

→ 본 V2는 **@F formula** kind, 병렬 agent는 **@L law**. 보완 관계로 둘 다 유지.

### 3.3 `hexa atlas pr --staging` 시도 (verdict VERBATIM)

```
$ hexa atlas pr --staging n6/atlas.append.witness-...-lpa_ivw_burgess.n6
promote_to_atlas: seen=0 new=0 merged=0 rejected=0
promote_to_atlas: manifest=/tmp/_promote_manifest.2026-05-23.txt
hexa atlas pr: nothing promoted — no append shard at ./atlas.append.2026-05-23.n6
  (the staging file produced 0 new/merged nodes; see the promote manifest above).
```
→ promote 파이프라인은 daily-aggregate (`atlas.append.YYYY-MM-DD.n6`)를 요구. 개별 witness shard 직접 PR 불가 → **gap** (per d2, breakthrough path §5 참조).

## §4. `hexa verify --expr` 시도 (5건 VERBATIM)

### 4.1 sigma sanity (baseline 🔵)
```
$ hexa verify --expr sigma 6 12
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

### 4.2 IVW (target C22/C23/C44)
```
$ hexa verify --expr ivw 3 1
verify --expr ivw(3)=1
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'ivw'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

### 4.3 Schoenfeld (target C07/C08/C35)
```
$ hexa verify --expr schoenfeld 920 1
verify --expr schoenfeld(920)=1
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'schoenfeld'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

### 4.4 binary_sample (target C12/C36)
```
$ hexa verify --expr binary_sample 13 85
verify --expr binary_sample(13)=85
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'binary_sample'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

### 4.5 nnt (target C04/C37/C38)
```
$ hexa verify --expr nnt 4 25
verify --expr nnt(4)=25
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'nnt'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

### 4.6 arr_to_nnt 대체명 시도
```
$ hexa verify --expr arr_to_nnt 4 25
verify --expr arr_to_nnt(4)=25
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'arr_to_nnt'
  gap    = extend tool/verify_cli.hexa::_recompute (계산기시스템 개선 후보)
```

## §5. hexa-lang inbox PR — calculator 확장 요청

per memory `feedback_hexa_lang_main_land_via_pr.md` + d8 (Vast-style inbox absorbing):

**PR #665 — OPEN** · https://github.com/dancinlab/hexa-lang/pull/665
- title: `inbox(notes): LPA IVW MR formula — atlas calculator extension request`
- head: `inbox/lpa-ivw-mr-formula` · base: `main`
- file: `inbox/notes/2026-05-24-lpa-ivw-mr-formula.md` (105 lines)
- 요청: `tool/verify_cli.hexa::_recompute` + `tool/atlas_cli.hexa::_recompute_register`에 5종
  biostat 추가 — **ivw · schoenfeld · binary_sample · nnt · ln_HR↔HR**
- cross-domain demand: LPA + DAPTPGX + NOREFLOW + HERPES (4도메인 막힘)
- API 경로 사용 (concurrent worktree 회피 per memory `feedback_hexa_lang_concurrent_agents.md`)

### breakthrough paths (per d2) — 3 axes: (1) **calculator extension** (PR #665 머지, root) (2) **daily-aggregate manual fold** (`n6/atlas.append.YYYY-MM-DD.n6` 합치기 → `hexa atlas pr` 통과) (3) **own atlas root** (`--atlas-root <repo>` 옵션, demiurge 내부 mirror)

## §5.5 ldl_pct (PR #707/#711 absorption · 2026-05-25)

hexa-lang PR #707 (bio kernel phase 1) merged 2026-05-25 — `ldl_pct(baseline, final)` 가 `_recompute_float` 에 dispatch 됨. LPA V1 목표 중 **Lp(a) Δ%** identity (HORIZON pelacarsen -80% · OCEAN(a) olpasiran -98% · 등 trial endpoint) 가 본 fn 으로 closed-form 재현 가능.

### VERBATIM verdicts (2026-05-25 local · SIDECAR_NO_POOL_ROUTE=1)

```
$ hexa verify --expr ldl_pct 100 70 -30
verify --expr ldl_pct(100.0,70.0)=-30.0
  calc   = -30.0  ≈ expected -30.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

$ hexa verify --expr ldl_pct 100 20 -80
verify --expr ldl_pct(100.0,20.0)=-80.0
  calc   = -80.0  ≈ expected -80.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### LPA trial endpoint 매핑

| trial | drug | baseline (nmol/L) | final | observed Δ% | hexa verify | tier |
|---|---|---|---|---|---|---|
| HORIZON | pelacarsen 80 mg | 100 | 20 | -80% | ldl_pct 100 20 -80 | 🟢 |
| OCEAN(a) Ph2 | olpasiran 225 mg | 100 | 2 | -98% (illustrative ratio) | ldl_pct 100 2 -98 | 🟢 (verbatim 추가 시) |
| FOURIER (LDL) | evolocumab | 100 | 30 | -70% (LDL surrogate) | ldl_pct 100 30 -70 | 🟢 (verbatim 추가 시) |

note: 본 identity 는 **baseline-relative % 변화** 의 closed-form. 환자 individual outcome (HR · MACE) 는 V3 numerical (S2 IVW MC) 의존 — 본 V2 는 *identity-grade* 만 escalate.

## §6. 🔵 도달 결과 — 0/8 (atlas extension 필수)

| target | claim | 결과 |
|---|---|---|
| C22/C23/C44 | IVW Burgess HR 0.71 | 🟠 (calc fn 부재) |
| C07/C08/C35 | Schoenfeld events D=920 | 🟠 (calc fn 부재) |
| C12/C36 | binary sample n=8,323 | 🟠 (calc fn 부재) |
| C04/C37/C38 | NNT = 1/ARR | 🟠 (calc fn 부재) |

**도달 0/8** — V1 목표 +7 🔵 미달. 단 **4건 atlas witness shard staging 성공** + **hexa-lang PR #665 OPEN** = 정직한 deferred + upstream breakthrough path 가동.

| tier | V1 후 | V2 후 | Δ |
|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | 1 (C30 sigma sanity) | 1 | 0 |
| 🟠 INSUFFICIENT/DEFERRED | 5 | 5 (8 target 모두 PENDING until PR #665 머지) | 0 |

## §7. V3 입력 — 등록 시도된 atom IDs + 결론

| id | kind | staging shard | 🔵 차단 사유 |
|---|---|---|---|
| `lpa_ivw_burgess` | F | `n6/...lpa_ivw_burgess.n6` | calc fn `ivw` 부재 |
| `lpa_schoenfeld` | F | `n6/...lpa_schoenfeld.n6` | calc fn `schoenfeld` 부재 |
| `lpa_binary_sample` | F | `n6/...lpa_binary_sample.n6` | calc fn `binary_sample` 부재 |
| `lpa_nnt` | F | `n6/...lpa_nnt.n6` | calc fn `nnt` 부재 |
| `ivw-lpa-burgess2018` | L | (parallel agent) | promote daily-aggregate 요구 |

**V3 출발선**: PR #665 머지 = unblock → V3 numerical (pool ubu-1/2) 후 🟢→🔵 promotion 자동. d6 (force 금지) 준수 — atlas 미지원을 🔵로 위장 NO. d9 (worktree isolation) 준수 — hexa-lang main 무touch (GitHub API route).

— LPA V2 · 2026-05-24
