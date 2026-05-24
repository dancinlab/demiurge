# V2 — 🔵 SUPPORTED-FORMAL push via hexa atlas + verify

> V1 inventory의 🟢 closed-form 4개 atom을 🔵 SUPPORTED-FORMAL로 escalation 시도.
> hexa atlas append-witness + hexa verify round-trip · g5 verbatim · d2/d6 honest framing.

## 1. methodology — 5-phase audit

본 V2는 g5 governance에 따라 hexa CLI verdict를 VERBATIM 인용하며, 다음 5-phase로 진행:

- **Phase A** — hexa atlas / verify 능력 정찰 (`--help` · `hash` · `stats` · `lookup --prefix`)
- **Phase B** — V1 🟢 4-atom append-witness staging 시도 + 명령별 verdict
- **Phase C** — `hexa verify --expr` 적용 가능 영역 (built-in fn 목록 대조)
- **Phase D** — toolchain 한계 → inbox handoff (d2 breakthrough paths, concede 금지)
- **Phase E** — 최종 🔵 escalation 표 + honest 한계 보고

---

## 2. Phase A — hexa atlas 상태 정찰 (stdout VERBATIM)

### 2.1 atlas hash + stats

```
$ hexa atlas hash
atlas: loaded 16066 nodes from atlas.n6
6fae9277c3a8624c4e4bf2a5dd1096890d7e92a252547fa510d36c7fc86f4167

$ hexa atlas stats
ATLAS_HASH         6fae9277c3a8624c4e4bf2a5dd1096890d7e92a252547fa510d36c7fc86f4167
ATLAS_SOURCE_COUNT 15
P primitives       455
C constants        5763
L laws             531
E experiments      12
F formulas         1313
R relations        6319
S symmetries       10
X crossings        1580
Q open questions   83
total nodes        16066
```

### 2.2 PGx-domain 기존 atom 유무

```
$ hexa atlas lookup --prefix=CYP
# no nodes match prefix: CYP

$ hexa atlas lookup --prefix=PGx
# no nodes match prefix: PGx

$ hexa atlas lookup --prefix=PHARM
# no nodes match prefix: PHARM
```

→ **CYP2C19 / PGx / PharmGKB 관련 기존 atom = 0개**. 16066 노드 중 PGx 도메인은 미점유 → V2가 PGx atom 신설의 첫 번째 시도.

### 2.3 BIO 도메인 prior art

```
$ hexa atlas lookup --prefix=BIO
@F BIO-blood-ABO :: atlas.n6:29948
@F BIO-blood-ABO = tau :: bio [10*]
  "ABO 혈액형"
@F BIO-photosynthesis :: atlas.n6:29953
@F BIO-glycolysis-split :: atlas.n6:29958
@F BIO-ECG-leads-12 :: atlas.n6:30008
@F BIO-cranial-nerves :: atlas.n6:30013
...
```

→ BIO 영역은 `@F` (formula) kind로 등록. PGx atom도 동일 패턴 (F·L) 적용 권장.

### 2.4 verify --expr 지원 함수

```
$ hexa verify rubric | tail -3
  calc fns : sigma|sigma_0|sigma_2|phi|mu|tau|is_perfect|aliquot|gamma0_index|
             gamma0_cusps|gamma0_genus|isotropy_lcm|first_cusp_form_weight
             2-op: sigma_k|jacobi|kronecker|dim_cusp_forms  (extend _recompute on gap)
```

→ **모두 number-theory 함수**. Hardy-Weinberg / binomial CI / Markov / ICER 등 bio-stat 함수 부재 → 직접 `verify --expr` 으로 🔵 escalation은 불가, append-witness 경유 필요.

---

## 3. Phase B — 🔵 register 시도 (V1의 🟢 4-atom)

### 3.1 staged shard 4개 (모두 staging stdout VERBATIM 성공)

```
$ hexa atlas append-witness --kind P --id CYP2C19.kor.PM.freq \
    --raw '0.1521 = (0.31 + 0.08)^2 — Hardy-Weinberg closed-form: kor *2 freq 0.31, *3 freq 0.08, PM diplotypes = *2/*2 + *2/*3 + *3/*3 = p2^2 + 2*p2*p3 + p3^2 = (p2+p3)^2 = 0.39^2 = 0.1521' \
    --dir /tmp/daptpgx-staging
/tmp/daptpgx-staging/atlas.append.witness-1779575080000-CYP2C19-kor-PM-freq.n6

$ hexa atlas append-witness --kind P --id CYP2C19.kor.IM_plus_PM.freq \
    --raw '0.6279 = HW closed-form: IM+PM diplotypes sum...' \
    --dir /tmp/daptpgx-staging
/tmp/daptpgx-staging/atlas.append.witness-1779575093000-CYP2C19-kor-IM_plus_PM-freq.n6

$ hexa atlas append-witness --kind P --id CYP2C19.kor.diplotype.star2_star2.freq \
    --raw '0.0961 = p2^2 = 0.31^2 — Hardy-Weinberg homozygous *2/*2 diplotype closed-form for Korean cohort' \
    --dir /tmp/daptpgx-staging
/tmp/daptpgx-staging/atlas.append.witness-1779575093000-CYP2C19-kor-diplotype-star2_star2-freq.n6

$ hexa atlas append-witness --kind L --id HardyWeinberg.identity.binomial \
    --raw 'p^2 + 2pq + q^2 = (p+q)^2 = 1 — Hardy-Weinberg principle...' \
    --dir /tmp/daptpgx-staging
/tmp/daptpgx-staging/atlas.append.witness-1779575093000-HardyWeinberg-identity-binomial.n6
```

→ **4 shard staged 성공**, 형식 `@<K> <id>\n  "<raw>"` 단일 라인.

### 3.2 staged shard 1개 inspect (VERBATIM)

```
$ cat /tmp/daptpgx-staging/atlas.append.witness-1779575080000-CYP2C19-kor-PM-freq.n6
// witness shard — hexa atlas append-witness
// emitter: manual
// kind: P
// id: CYP2C19.kor.PM.freq
// timestamp_ms: 1779575080000

@P CYP2C19.kor.PM.freq
  "0.1521 = (0.31 + 0.08)^2 — Hardy-Weinberg closed-form: kor *2 freq 0.31, *3 freq 0.08, PM diplotypes = *2/*2 + *2/*3 + *3/*3 = p2^2 + 2*p2*p3 + p3^2 = (p2+p3)^2 = 0.39^2 = 0.1521"

// EOF — hexa atlas append-witness
```

### 3.3 round-trip verify 시도 (실패 VERBATIM)

```
$ hexa verify CYP2C19.kor.PM.freq
verify CYP2C19.kor.PM.freq
  tier   = 🟠 INSUFFICIENT
  reason = binary built-in atlas (dist/atlas.hxc) empty/absent

$ hexa atlas lookup CYP2C19.kor.PM.freq
# not found: CYP2C19.kor.PM.freq (searched P, C, L, E, F, R, S, X, Q)
```

→ staging shard는 atlas binary로 promote되지 않은 상태 → lookup/verify에서 🟠.

### 3.4 promoter 실행 시도 (실패 VERBATIM)

```
$ cd ~/core/hexa-lang && hexa atlas pr --staging /tmp/daptpgx-staging/atlas.append.witness-1779575080000-CYP2C19-kor-PM-freq.n6
promote_to_atlas: seen=0 new=0 merged=0 rejected=0
promote_to_atlas: manifest=/tmp/_promote_manifest.2026-05-23.txt
hexa atlas pr: nothing promoted — no append shard at ./atlas.append.2026-05-23.n6
  (the staging file produced 0 new/merged nodes; see the promote manifest above).

$ cat /tmp/_promote_manifest.2026-05-23.txt
# hexa atlas promote manifest — 2026-05-23T22:25:10Z
# staging: /tmp/daptpgx-staging/atlas.append.witness-1779575080000-CYP2C19-kor-PM-freq.n6
# append:  ./atlas.append.2026-05-23.n6
proposals_seen: 0
promoted_new:  0
merged_alias:  0
rejected_collision: 0
```

→ **promoter parser가 append-witness emitter format을 0 proposals로 인식**. 동일 증상이 hexa-lang/n6/atlas.append.witness-1779574445000-ivw-lpa-burgess2018.n6 (기존 다른 도메인 landed shard) 에도 재현 — 즉 `append-witness` emitter shard 전체가 promote 안 됨. **toolchain bug** (DAPTPGX-specific 아님).

### 3.5 register --from-verify 시도 (built-in 함수만 작동)

```
$ hexa atlas register --from-verify phi 100 40   # number-theory built-in
hexa atlas register --from-verify phi(100) = 40
  calc   = 40  == expected 40
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form; @D g_self_verify · TECS-L Tier1)
  embed  = appended @F verified-phi-100 to ./compiler/atlas/embedded.gen.hexa (ATLAS_F_NODES section)
```

→ **number-theory 함수에는 작동** — 직접 embedded.gen.hexa 수정 후 binary 재컴파일 시 🔵 lookup 가능. 그러나 `phi/sigma/tau/...` 만 지원, **Hardy-Weinberg / binomial / ICER 함수 부재** → DAPTPGX claim에는 부적용.

### 3.6 verdict 표

| atom | 의도 kind | staging | promote | round-trip verify | 최종 |
|---|---|---|---|---|---|
| CYP2C19.kor.PM.freq | P | 🟢 staged | 🔴 0 proposed | 🟠 INSUFFICIENT (binary 미흡수) | toolchain blocker |
| CYP2C19.kor.IM_plus_PM.freq | P | 🟢 staged | 🔴 0 proposed | 🟠 INSUFFICIENT | toolchain blocker |
| CYP2C19.kor.diplotype.star2_star2.freq | P | 🟢 staged | 🔴 0 proposed | 🟠 INSUFFICIENT | toolchain blocker |
| HardyWeinberg.identity.binomial | L | 🟢 staged | 🔴 0 proposed | 🟠 INSUFFICIENT | toolchain blocker |

→ **4 staged shard 모두 atlas binary 흡수 못함** — promoter 0-proposal 버그가 단일 블로커. 본 V2 라운드의 🔵 escalation = **0개** (정직 보고).

---

## 4. Phase C — `verify --expr` 적용 가능 영역

DAPTPGX의 closed-form claim 중 현 hexa verify --expr 내장 함수로 직접 검증 가능한 항목:

| DAPTPGX claim | 적용 가능 fn (built-in) | verdict |
|---|---|---|
| HW phenotype freq (C05/C06) | 🔴 없음 | hw_phenotype/wilson_ci 부재 |
| binomial CI (C01-C04/C12/C13) | 🔴 없음 | wilson_lo / wilson_hi / clopper_pearson 부재 |
| Markov^n row-stochastic (C25 5y) | 🔴 없음 | markov_iterate 부재 |
| ICER 부호 (C25) | 🔴 없음 | icer_sign 부재 |
| 약가 catalog lookup (C22-C24) | 🔴 N/A | external DB ref (lookup ≠ closed-form) |

→ **현 built-in fn 12개 (phi/sigma/tau/...)는 모두 number-theory** — DAPTPGX의 bio-stat 함수와 교집합 ∅. inbox handoff 필요 (Phase D).

### Sanity check — built-in fn은 정상 동작 확인

```
$ hexa verify --expr phi 100 40
verify --expr phi(100)=40
  calc   = 40  == expected 40
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

→ verify --expr 자체는 정상. DAPTPGX 적용 영역의 fn이 누락된 것.

---

## 5. Phase D — inbox handoff (d2 breakthrough paths)

toolchain의 두 한계 (promoter parser bug · bio-stat fn 부재) 각각에 대해 inbox patch 작성:

### 5.1 작성된 patches

| path | target_kind | 흡수 후 효과 |
|---|---|---|
| `/Users/ghost/core/demiurge/inbox/patches/hexa-lang-stdlib-bio-stats.md` | stdlib-extension (verify --expr 분기 + stdlib/bio/stats/*) | 8 bio-stat fn 추가 → DAPTPGX 10+ claim 🟡→🔵 round-trip 가능 |
| `/Users/ghost/core/demiurge/inbox/patches/hexa-atlas-pgx-kind-extension.md` | atlas-spec-extension (promoter parser fix + 9 K kind documentation) | 4 staged shard promote 정상화 → DAPTPGX 4 atom 🔵 escalation |

### 5.2 d2 breakthrough paths — 2 patch 흡수 후 예상 경로

1. **Phase B 4-atom 재실행** (promoter fix 후) → 4 atom 모두 🔵 round-trip 가능
2. **8 bio-stat fn 추가 후** `hexa verify --expr hw_phenotype "0.59,0.31,0.08,0.02" 1.0` 같은 직접 verify → V1 inventory의 10+ claim 직행 🔵
3. **cross-domain win** — HERPES · LPA · 다른 PGx 도메인의 epidemiological identity도 동일 kernel 재사용 (1회 patch, ∞ domain ROI)

### 5.3 hexa-lang 기존 동일 영역 inbox 발견 (중복 회피 메모)

`hexa-lang/inbox/patches/bio-verify-kernel-extension-2026-05-25.md` 가 hexa-lang 측에 이미 존재 (atlas-pr-20260523-222533 branch 의 untracked file 목록에서 확인). DAPTPGX의 patch는 더 구체적인 8-fn signature + DAPTPGX claim-by-claim 매핑 제공 → **상호 보강 관계**, 흡수 시 dedup 후 통합 권장.

---

## 6. 최종 🔵 escalation 표 (V1 inventory 30 claim 대비)

| 등급 | V1 현 | V2 후 (본 라운드) | bio-stat kernel 흡수 후 (예상) |
|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | 0 | **0** (promoter blocker) | 4 (V2 4-atom) + 6 (HW/binomial direct verify) = **10** |
| 🟢 SUPPORTED-NUMERICAL | 4 (V3) | 4 | 4 |
| 🟡 SUPPORTED-BY-CITATION | 18 | 18 | 14 (4개 🔵 escalation) |
| 🟠 INSUFFICIENT/DEFERRED | 9 | 9 | 5 (4개 🔵 escalation + 일부 model recon) |
| 🔴 FALSIFIED | 0 | 0 | 0 |
| ⚪ SPECULATION-FENCED | 3 | 3 | 3 (forward 유지) |

→ **현 라운드 🔵 = 0** (정직 보고, d6 honest framing). 2 inbox patch 흡수 사이클 통과 후 🔵 = 10 가능 (33% escalation).

---

## 7. honest 한계 보고 (d6)

본 V2 라운드는 **🔵 0개 도달** — staging은 성공했으나 promote → binary 흡수 cycle이 closed가 아님. 다음과 같이 정직 분류:

### 7.1 본 라운드에서 closed인 것

- ✅ Phase A 정찰 (atlas hash · 16066 노드 · PGx prior art = 0 · verify --expr fn 목록) — stdout VERBATIM, 🟢
- ✅ Phase B staging (4 shard 생성, 형식 정합) — staging stdout 4건 VERBATIM, 🟢
- ✅ Phase D inbox patch 2개 작성 (target_repo: hexa-lang) — 흡수 path 명시, 🟢

### 7.2 본 라운드에서 closed 못한 것 (정직 사유)

- ❌ Phase B promote — promoter parser bug (append-witness format 0 proposals 인식). DAPTPGX-specific 아닌 toolchain-wide blocker.
- ❌ Phase C verify --expr — bio-stat fn (HW/binomial/Markov/ICER) 부재. number-theory 함수만 지원.
- ❌ V1 30 claim 중 🔵 도달 = 0. V1 §4 "목표 분포" 0-2개 🔵 도 미달.

### 7.3 d6 framing — "불가능" 사용 금지

본 V2의 한계는 **method 한계가 아닌 toolchain coverage 한계**. d2 breakthrough paths 명시:

- (path 1) `hexa-atlas-pgx-kind-extension.md` 흡수 → promoter fix → 4 staged shard 재promote → 4 atom 🔵
- (path 2) `hexa-lang-stdlib-bio-stats.md` 흡수 → bio-stat 8 fn → `verify --expr hw_phenotype` 직접 호출 → 6+ atom 🔵
- (path 3) `hexa atlas register --from-verify` 의 in-process node-gen path 를 bio-stat fn에 확장 → embedded.gen.hexa 직접 수정 → binary 재컴파일 → round-trip 🔵

각 path 모두 hexa-lang 흡수 사이클 통과 후 **mechanical** — 새로운 발견 없이도 실행 가능. "🔵 도달 불가능" 표현 금지 (V1 §6 d2 invariant).

---

## 8. 핵심 통찰 (5 bullets · d2 paths 명시)

- **본 라운드 🔵 = 0 (정직)** — staging 4 shard 모두 정합, 그러나 promoter parser가 0 proposals 인식. V1 §4 목표 (0-2 🔵)도 미달. 사유는 toolchain 한계 (DAPTPGX 문제 아님).
- **2 inbox patch가 cross-domain ROI** — `hexa-lang-stdlib-bio-stats` 흡수 시 DAPTPGX 10+ atom 🔵 가능 + HERPES/LPA/향후 PGx 도메인 무한 재사용. `hexa-atlas-pgx-kind-extension` 흡수 시 4 staged shard 즉시 promote.
- **register --from-verify 는 number-theory에만 작동** — DAPTPGX claim과 교집합 ∅. Hardy-Weinberg 등 bio-stat 확장 없이는 직행 🔵 path 없음 → inbox 흡수 의존.
- **atlas 16066 노드 중 PGx 도메인 = 0** — DAPTPGX가 PGx K-kind 사용의 첫 시도. F/L 매핑이 BIO 도메인 prior art (29948+) 와 정합. 신 K kind 신설 불요.
- **d2 breakthrough 3-path (concede 금지)** — (1) promoter fix 후 staged shard promote, (2) bio-stat fn 추가 후 직접 verify --expr, (3) register --from-verify path를 bio-stat fn에 확장. 각 path 모두 흡수-후-mechanical, "불가능" 명사 사용 금지.

---

## 9. 후속 작업

- V2 라운드 종료 후 hexa-lang 측의 2 patch 흡수 대기 (외부 의존)
- 흡수 완료 후 V2-bis 라운드 — `/tmp/daptpgx-staging/*.n6` 4 shard 재promote + round-trip verify 재실행
- V4 final ledger — V1+V2+V2-bis+V3+V3.5 합쳐 30 claim final tier 분포 확정 (목표: 🔵 10 + 🟢 8 + 🟡 8 + 🟠 4 + ⚪ 3)
- 본 V2의 stdout VERBATIM 4 attempt는 toolchain regression test의 fixture로 hexa-lang/test/atlas/ 에 추가 가능

---

## 10. cross-reference

- V1 inventory: `/Users/ghost/core/demiurge/DAPTPGX/verify/V1_claim_inventory.md`
- V3 numerical: `/Users/ghost/core/demiurge/DAPTPGX/verify/V3_numerical_recompute.md`
- V3 sim asset: `/Users/ghost/core/demiurge/DAPTPGX/sims/v3_recompute.hexa`
- inbox patches (작성):
  - `/Users/ghost/core/demiurge/inbox/patches/hexa-lang-stdlib-bio-stats.md`
  - `/Users/ghost/core/demiurge/inbox/patches/hexa-atlas-pgx-kind-extension.md`
- staged shards (toolchain blocker 해결 시 promote 대상):
  - `/tmp/daptpgx-staging/atlas.append.witness-1779575080000-CYP2C19-kor-PM-freq.n6`
  - `/tmp/daptpgx-staging/atlas.append.witness-1779575093000-CYP2C19-kor-IM_plus_PM-freq.n6`
  - `/tmp/daptpgx-staging/atlas.append.witness-1779575093000-CYP2C19-kor-diplotype-star2_star2-freq.n6`
  - `/tmp/daptpgx-staging/atlas.append.witness-1779575093000-HardyWeinberg-identity-binomial.n6`
- related hexa-lang inbox (dedup 후 통합 권장): `~/core/hexa-lang/inbox/patches/bio-verify-kernel-extension-2026-05-25.md`
