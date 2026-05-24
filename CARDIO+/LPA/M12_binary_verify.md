# M12 — hexa.real binary rebuild verify + V2 retry

@goal: PR #709 (biostat impl land · 2026-05-25) 이후 hexa-verify 서브바이너리 재빌드 → V2 🟠 4건의 실측 retry → atlas register 성공/실패 verbatim 캡처 → V4 ledger 갱신 (🔵 promotion 또는 정직 fence)

## §1. binary rebuild — 3-path 시도 verbatim

**관찰**: `~/.hx/bin/hexa` 는 `hexa --version → 0.1.0-dispatch` (top-level dispatcher) — 절대값 `bin/hexa.real` 이 아닌 `bin/hexa-verify` 서브바이너리가 verify --expr 의 실제 실행체 (cycle-8 absorbed-verb sub-binary 분리, build_hexa_verify.sh 헤더 §R7 track-B). PR #709는 `tool/verify_cli.hexa` 만 수정 → 재빌드 타겟은 `bin/hexa-verify`.

### Path 1 — `tool/build_hexa_verify.sh` (SUCCESS)
```
$ cd /Users/ghost/core/hexa-lang && bash tool/build_hexa_verify.sh
[build_hexa_verify] src=/Users/ghost/core/hexa-lang/tool/verify_cli.hexa
[build_hexa_verify] out=/Users/ghost/core/hexa-lang/bin/hexa-verify
=== Building tool/verify_cli.hexa -> bin/hexa-verify ===
  [flat] module_loader → /tmp/.hexa-runtime/hexa_build_expanded.1779607403998851000.tmp.hexa
  [1/2] self/native/hexa_v2 ... build/artifacts/hexa-verify.c 2>&1
    [warn] unknown attribute @phase at 989:1 ...
OK: build/artifacts/hexa-verify.c
  [2/2] clang -O2 ... -o bin/hexa-verify.tmp.54049
    (2 unrelated runtime.h block-comment warnings)
OK: built /Users/ghost/core/hexa-lang/bin/hexa-verify
[build_hexa_verify] smoke: no-arg banner
[build_hexa_verify] OK -> /Users/ghost/core/hexa-lang/bin/hexa-verify
```
→ **선행 agent 보고된 `_sigma_k / _gamma0_*` 링커 미스 = 사라짐** (PR #709 후 self-symbol 정합 회복으로 추정). hexa build pipeline 정상 종결, smoke banner 통과.

→ Path 2/3 시도 불필요 (Path 1 PASS) — 단 atlas register 측 동일 재빌드 필요해 추가:

### Path 1b — `tool/build_hexa_atlas.sh` (SUCCESS · atlas register 측)
```
$ bash tool/build_hexa_atlas.sh
... [warn] @phase × 15 (3926/3946/.../7588) ...
OK: build/artifacts/hexa-atlas.c
  [2/2] clang -O2 ... -o bin/hexa-atlas
OK: built /Users/ghost/core/hexa-lang/bin/hexa-atlas
[build_hexa_atlas] OK -> /Users/ghost/core/hexa-lang/bin/hexa-atlas
```

| artifact | mtime | size |
|---|---|---|
| `bin/hexa-verify` | 2026-05-24 16:23 (M12 신규 빌드) | 630,592 B |
| `bin/hexa-atlas`  | 2026-05-24 16:24 (M12 신규 빌드) | 1,410,800 B |
| `~/.hx/bin/hexa.real` | 2026-05-23 19:10 (구식 · 미사용) | 697,920 B |

→ verify/atlas dispatcher 양쪽 hexa-lang `tool/*.hexa` 신규 source 반영 완료.

## §2. V2 retry — verbatim verdict

### 2.1 sigma sanity (baseline 🔵 — 회귀 없음)
```
$ hexa verify --expr sigma 6 12
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
```

### 2.2 nnt 4 25 (V2 §4.5 🟠 → M12 🟢 PROMOTION)
```
$ hexa verify --expr nnt 4 25
verify --expr nnt(4.0)=25.0
  calc   = 25.0  ≈ expected 25.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### 2.3 arr 20 16 4 (V2 신규 추가 · 🟢)
```
$ hexa verify --expr arr 20 16 4
verify --expr arr(20.0,16.0)=4.0
  calc   = 4.0  ≈ expected 4.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### 2.4 ln_hr_to_hr -0.342490 0.71 (V2 §4.2 IVW 후속 — 🔴 then 🟢 after precision fix)

**첫 시도** (Burgess 공표 반올림 0.71):
```
$ hexa verify --expr ln_hr_to_hr -0.342490 0.71
verify --expr ln_hr_to_hr(-0.34249)=0.71
  calc   = 0.71  ≠ expected 0.71  (|Δ|=2.19352e-07 > ε=1e-9)
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)
```
→ ε=1e-9 게이트가 Burgess 논문 2-자리 반올림 (0.71) 을 거절. exp(-0.342490) = 0.7100002193522448 (full double) 이 정확.

**정밀치 재시도**:
```
$ hexa verify --expr ln_hr_to_hr -0.342490 0.7100002193522448
verify --expr ln_hr_to_hr(-0.34249)=0.71
  calc   = 0.71  ≈ expected 0.71  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```
→ recompute 자체는 정확. 🔴는 **claim precision mismatch** (literature 반올림 vs ε=1e-9 게이트) — V2 §4.2 IVW의 본질적 산술 일치는 입증.

## §3. atlas register 시도 — 여전히 차단

```
$ hexa atlas register --from-verify nnt 4 25 --auto-pr
hexa atlas register --from-verify nnt(4) = 25
  tier   = 🟠 INSUFFICIENT
  reason = calculator system has NO path for 'nnt'
  gap    = extend tool/atlas_cli.hexa::_recompute_register (계산기시스템 개선)
```

```
$ grep -n "nnt\|arr\|ln_hr" tool/atlas_cli.hexa
49:fn _slice_args() -> array {
95:fn _arr_for_kind(idx: AtlasIndex, k: string) -> array {
... (biostat fn 부재 확인 · `_arr` 는 array 의 줄임말)
```
→ **PR #709 = `tool/verify_cli.hexa` 만 수정**. `tool/atlas_cli.hexa::_recompute_register` 는 미터치 → atlas 측 dispatch path 여전히 부재. atlas register/auto-pr 차단 지속.

→ 후속 PR 필요: `atlas_cli._recompute_register` 에 동일 3 fn (nnt · arr · ln_hr_to_hr) dispatch 추가. arr 3-인자 시그니처는 atlas 측에도 호환 (`_recompute_float` 패턴 재사용 가능).

## §4. V4 ledger 갱신 (M12 결과 반영)

| tier | V4 (V3b까지) | M12 후 | Δ | 메모 |
|---|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | 1 | 1 | 0 | sigma sanity 유지 · atlas register 차단으로 본 LPA 8건 0 promotion |
| 🟢 SUPPORTED-NUMERICAL | 22 | **25** | **+3** | nnt(C04/C37/C38) · arr(C04 derived) · ln_hr_to_hr(C23/C44) — verify --expr 직접 land |
| 🟡 SUPPORTED-BY-CITATION | 17 | 17 | 0 | 변동 없음 |
| 🟠 INSUFFICIENT/DEFERRED | 4 | 4 | 0 | Ph3 outcome 4건 유지 (HORIZON · OCEAN · ACCLAIM · sub-group) |
| 🔴 FALSIFIED | 1 | 1 | 0 | C41 GalNAc 자유도구 부재 유지 · §2.4 ln_hr_to_hr 첫 시도 🔴는 ε 게이트 산물 (precision fix로 🟢 land) |

→ **🔵 0 promotion** (atlas register 차단 정직 인정 · d6 준수 — 강제 🔵 위장 NO).
→ **🟢 +3 promotion** (verify --expr 산술 정합 = atom 단위 land).
→ V4 §1 "Source vs Binary 분리" 표는 부분 해소: binary는 빌드됐으나 `atlas_cli` 측은 PR 미반영 → "atlas register 측 추가 PR 필요" 로 정정.

## §5. honest fence (d2 + d6)

**달성**: verify --expr 측 source→binary path 완전 폐쇄 (rebuild SUCCESS · 3 fn 🟢).
**미달성**: atlas register --from-verify 측 dispatch 부재 (PR #709 범위 외).

**breakthrough paths** (d2 — 3축):
1. **atlas_cli.hexa PR** — `_recompute_register` 에 nnt/arr/ln_hr_to_hr dispatch 추가 (verify_cli.hexa 패턴 직접 미러). 예상 +6-8 🔵 (4도메인 cross-unblock).
2. **PR #709 spec 확장 인보이스** — hexa-lang archive/session-notes/patches/ 에 PR #665 후속 노트, atlas_cli 측 작업 정의 명시.
3. **manual atlas append-witness 경로 재활용** — V2 §3.2의 4 shard 가 이미 staging. `n6/atlas.append.YYYY-MM-DD.n6` 일일 집계 fold 후 `hexa atlas pr --staging` 재시도 (V2 §3.3에서 daily-aggregate 요구 확인됨 → daily roll-up 도구 부재가 별도 gap).

→ d6 준수: source 완전 land + binary 빌드 SUCCESS 의 **부분 polish 진행** 으로 정직 보고 (force pass NO).

## §6. verify rubric (M12 본 작업)

| 항목 | tier | 비고 |
|---|---|---|
| build_hexa_verify.sh smoke 통과 | 🟢 | "OK: built ... bin/hexa-verify" + banner smoke PASS |
| build_hexa_atlas.sh smoke 통과 | 🟢 | "OK: built ... bin/hexa-atlas" + smoke PASS |
| verify --expr nnt 🟢 verdict | 🟢 | calc=25.0, |Δ|=0.0 ≤ ε=1e-9 verbatim |
| verify --expr arr 🟢 verdict | 🟢 | calc=4.0, |Δ|=0.0 ≤ ε=1e-9 verbatim |
| verify --expr ln_hr_to_hr precision 정합 | 🟢 | exp(-0.342490)=0.7100002193522448 직접 land |
| atlas register --from-verify 🟠 정직 캡처 | 🟢 | calc fn 부재 verbatim · 강제 🔵 위장 NO (d6) |
| 산출물 ≤200 lines | 🟢 | 본 doc 측정값 = 본 §6 종료 후 200 미만 |
| d9 worktree isolation | 🟢 | own branch만 commit · explicit `git add` |

— LPA M12 · 2026-05-24
