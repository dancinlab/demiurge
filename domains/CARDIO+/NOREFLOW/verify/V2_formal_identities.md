# V2 — NOREFLOW 🔵/🟢 closed-form / numerical push (`hexa verify --expr`)

> verify-V2 산출물 · current-state · 본 V2 는 V1 inventory 의 quantitative claim 중 hexa-lang bio kernel (PR #707/#711) 으로 재현 가능한 identities 만 escalate.
> 범위 = NOREFLOW M1-M9 + V1 의 closed-form/numerical 가능 claim subset.
> 본질적으로 인체 RCT/registry 의존 claim 은 본 file 에서 다루지 않음 (V4 ledger 의 🟡/🟠 영역).

## §1. hexa-lang bio kernel 현재 상태 (2026-05-25)

- **PR #707** (phase 1) — `exp_release` · `ldl_pct` · `beer_lambert` (3-arg float dispatch)
- **PR #711** (phase 2) — `hill` · `cheng_prusoff` · `fick1` · `laplace` · `stokes_einstein`
- 8 identities total · 모두 🟢 SUPPORTED-NUMERICAL tier (libm `exp`/`sqrt` recompute · ε=1e-9)
- 미지원 (Phase 3 PR 대기): `higuchi` (4-arg) · `tafel` (5-arg)

## §2. NOREFLOW identity 매핑

| identity | NOREFLOW claim source | 적용 사례 |
|---|---|---|
| `exp_release` | M3 미세혈관 약물 PK · M4 IC bolus | adenosine 1차 elution kinetics · IC bolus washout |
| `hill` | M2 mPTP 차단 dose-response · M3 receptor binding | cyclosporin-A mPTP Kd · adenosine A2A receptor |
| `cheng_prusoff` | M2 inhibitor Ki conversion | sanglifehrin Ki from IC50 |
| `fick1` | M4 distal protection diffusion | drug particle diffusion across protected segment |
| `stokes_einstein` | M4 micro/nanoparticle delivery | cyclosporin lipid particle D in blood |
| `laplace` | M5 IMR vessel wall stress (간접) | microvascular wall pressure at no-reflow |
| `ldl_pct` | (skip — LDL 무관) | n/a |
| `beer_lambert` | (skip — OCT 미사용 NOREFLOW) | n/a |

## §3. VERBATIM verdicts (2026-05-25 local · SIDECAR_NO_POOL_ROUTE=1)

### §3.1 `exp_release` — adenosine IC bolus PK

claim: adenosine IC bolus 5분 elution `k=0.1 min⁻¹` · `M_0=1` (정규화) → `M_5 = 0.393`.

```
$ hexa verify --expr exp_release 1.0 0.1 5 0.39346934028736657
verify --expr exp_release(1.0,0.1,5.0)=0.393469
  calc   = 0.393469  ≈ expected 0.393469  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### §3.2 `hill` — adenosine A2A receptor saturation

claim: adenosine `L=0.5 μM` · `Kd=0.001 μM` (A2A 고친화) · `n=1` → near saturation `0.998`.

```
$ hexa verify --expr hill 0.5 0.001 1 0.998003992015968
verify --expr hill(0.5,0.001,1.0)=0.998004
  calc   = 0.998004  ≈ expected 0.998004  (|Δ|=1.11022e-16 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### §3.3 sanity 🔴 — wrong expected

```
$ hexa verify --expr hill 0.5 0.001 1 0.998
verify --expr hill(0.5,0.001,1.0)=0.998
  calc   = 0.998004  ≠ expected 0.998  (|Δ|=3.99202e-06 > ε=1e-9)
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)
```

## §Σ V2 결과 요약

| tier | count | identities |
|---|---|---|
| 🟢 SUPPORTED-NUMERICAL | 2 | exp_release · hill |
| 🔴 FALSIFIED | 1 | hill (sanity check, wrong expected) |
| 🟠 candidate (extend) | 4 | cheng_prusoff · fick1 · stokes_einstein · laplace |
| 🟠 phase-3 dep | 2 | higuchi · tafel |

note: 본 V2 는 minimal escalation — 추가 4 candidates 는 NOREFLOW M2-M5 의 verbatim 수치를 후속 확장 시 추가.

## §Δ 다음 단계

- M2 mPTP cyclosporin-A `cheng_prusoff` verbatim — sanglifehrin Ki conversion
- M4 distal protection `fick1` · `stokes_einstein` verbatim — particle delivery PK
- M5 IMR `laplace` verbatim — microvascular wall stress
- phase 3 PR 머지 후 `higuchi` · `tafel` 추가 (drug release matrix · IRI redox)

## ref

- hexa-lang PR #707 (bio kernel phase 1) · PR #711 (phase 2)
- NOREFLOW V1 §3 (claim inventory) · V4 (final tier ledger)
