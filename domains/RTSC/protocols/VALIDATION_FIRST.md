# 🛡️ VALIDATION-FIRST — pre-dispatch mandate for every new candidate

**alias**: "검증-우선 protocol" · "blind-dispatch 금지" · "1-cell first"
**date**: 2026-05-27 KST · **domain**: RTSC · **stage**: PROTOCOL (Tier-3 governance doc from /gap full diagnosis)
**governance**: d1 (non-wet-lab → completed-form) · d6 (first-principles, NOT ML) · d11 (pre-rent feasibility-size) · d13 (basis/ECP coverage check) · d16 (deck syntax-validate FREE on pool before rent) · d17 (1-validation cell before scale)
**diagnosis trigger**: /gap full · F5 fixpoint — N6 blind-dispatch convergence rate 0 (Mg₂IrH₆ + Li₂CuH₆ 둘 다 사전 validation 없이 발사 → 둘 다 ambient hard-imaginary → cohort burn 그러나 falsifier resolution 1/2 (둘 다 같은 K₂PtCl₆ Fm-3m 축))

> **honesty 경계**: 본 문서 = *protocol* — 모든 case 에 절대 적용되진 않는다. 이미 측정-grade reference data 가 있는 anchor(H₃S · CaH₆) 같은 *재현 검증* 라운드는 1-cell pre-validation 의의가 작다(목적이 다름). 본 protocol 은 **novel-candidate dispatch** (가설→첫 DFT) 라운드의 mandatory gate.

---

## 1. wall recap — 왜 mandate 가 필요한가

직전 N6 funnel 2 후보 (Mg₂IrH₆ · Li₂CuH₆ · 같은 K₂PtCl₆ Fm-3m prototype) 가 *둘 다* 사전 validation 없이 ambient full el-ph chain 으로 발사되었다. 결과 (2026-05-26 — 2026-05-27, rtsc.log.md 참조):

| candidate | dispatch | first-imag detection | total ph.x budget | falsifier shape |
|---|---|---|---|---|
| Mg₂IrH₆ ambient | ubu-1 4³q full chain | q1 (Γ) **min freq −2235 cm⁻¹** | 13 IBZ q-points (q1-q5 locked verdict, q6-q13 in-flight) | **48% modes hard-imag** — clean closed-negative |
| Li₂CuH₆ ambient | ubu-1 4³q full chain | q2 hard 8 modes **min −944.92 cm⁻¹** | 13 IBZ q-points (q1-q2 locked verdict) | 동일 prototype → 동일 axis falsification |

**낭비**: q1 phonon Γ 계산 한 번이면 *둘 다* hard-imag (<-50 cm⁻¹) 식별 가능했다. 4³q full chain 의 q6+ ph.x in-flight 는 verdict 이후 잉여 cycle (cost $0 pool 이지만 **wall-time + ubu-1 점유** = next candidate 의 latency cost). **F5 fixpoint convergence rate 0** = 같은 axis 의 후보 2개 burn 후에도 cohort 정보-획득은 1차원 falsification 만.

→ **mandate 가 없으면 cohort 가 같은 함정에 거듭 빠진다**.

---

## 2. mandate — 모든 신규 후보 dispatch 전 4 gates

### gate 1 (d11) — feasibility-size pre-check (cost-cap)

| 측정 | 산식 / threshold | red-line |
|---|---|---|
| atoms-per-cell | primitive cell atom count | ≤9 (binary H₃X · X₂MH₆ prototype) — pool ubu free OK · >20 → GPU pod |
| basis-fn estimate | sum(ecutwfc=80Ry-relevant PW count) | <200K PW · single-cell SCF wall <1h on 6-core |
| method scaling | DFT scaling factor | PBE pure (d14) preferred · hybrid 만일 m_oxide cluster (d12) |

**산출물**: 한 줄 estimate `"<cand>: <atoms>-atom primitive, ~<X>K PW, PBE pure, est <wall>h/q × <N>q = <total>h"` 을 dispatch record 머리에 박는다.

### gate 2 (d13) — basis/ECP element coverage check

```
for each element in cell:
    check UPF/basis lib for element entry
    if missing → resolve (download / alternate lib) before deck author
```

- ✅ **success precedent** (Li₂CuH₆ 2026-05-26): Cu/Li UPF 부재 실측 확인 → PSL 1.0.0 다운로드 stage → d13 게이트 통과 후 dispatch.
- ❌ **failure mode**: assume default lib covers — NWChem def2 lanthanide 부재 (MEMORY.md reference) · cycle 통째로 burn.

### gate 3 (d16) — deck syntax dry-run on pool free

```
build deck → 1-iter dry-run on pool free → catch directive/basis errors
```

- `niter=1` SCF + `nstep=1` vc-relax + ph.x `last_q=1` dry-run = ~5-10 min wall on pool ubu-1/2.
- catches: typo in &control, wrong ibrav, missing pseudo, broken occupations.
- **반드시** dry-run PASS 후에야 full-cohort dispatch.

### gate 4 (NEW, this doc) — **stability_pre_check**

```
1. vc-relax (BFGS, ~1-4h wall, 8³ k-mesh fine, ecutwfc=80Ry)
2. Γ-only phonon (ph.x trans, q=0,0,0 only) — ~1-2h wall
3. inspect dyn0/dyn1 lowest mode
4. branch:
   - hard imag (<-50 cm⁻¹) → 🔴 closed-negative LOCK (pkill OK, ph.x q2+ 미발사)
   - mild Γ-soft (-50 ~ 0 cm⁻¹) → 🟡 AMBER (anharmonic 보류 보고 · SSCHA branch · 또는 폴리모프 escape)
   - all real → 🟢 PROCEED full-grid el-ph (q2..qN dispatch)
```

**total pre-validation budget**: ~2-6h pool ubu free per candidate (Γ-only phonon = 1/13 of 4³q workload). 후보당 ph.x 75-90% 절약 if 🔴.

**근거**: Mg₂IrH₆ q1 (Γ) 가 이미 verdict locked-imag — Γ-only check 만으로 즉시 클로즈드. h3o harmonic 도 Γ 에서 −682 cm⁻¹ 즉시 식별 (SSCHA branch trigger). 8-cohort fanout (RTSC.log §9.15) 에서 stable 후보의 Γ 는 항상 real → Γ-imag = 강한 falsifier.

---

## 3. **blind-dispatch 금지** — anti-pattern catalog

다음 패턴은 **즉시 abort** (개정 명시):

1. **prototype-가설 + 즉시 full-grid dispatch** — "N6 K₂PtCl₆ Fm-3m VEC=19 자가정합 → 발사" — Mg₂IrH₆ + Li₂CuH₆ 가 한 prototype 함정에 2번 빠진 사례.
2. **literature 추정 lattice 로 SCF 직진 (vc-relax skip)** — Li₂CuH₆ +38% volume relax 가 lit estimate 가 압축이었음을 사후 발견 (rtsc.log 2026-05-26).
3. **measured anchor 외 첫 후보를 GPU pod 에 발사** — d7 위반 + d17 위반. 1-cell pool free → 그 다음 scale.
4. **falsifier 의 *축* 을 점검 없이 후보 enumerate** — 같은 axis 의 후보 N 개를 동시 dispatch 시 falsifier resolution = 1 (cohort 전체가 1차원). 다른 axis 의 후보를 mix.

---

## 4. record schema — `validation_log` block (mandatory in dispatch record)

dispatch 시점에 export 하는 record (e.g. `exports/material_discovery/rtsc_<cand>_dispatch_live_<date>.json`) 의 `validation_log` 블록 — 4 gates 의 yes/no + 산출물 path.

```json
{
  "validation_log": {
    "gate_1_d11_feasibility": {
      "pass": true,
      "atoms": 9,
      "pw_estimate_K": 180,
      "method": "PBE pure",
      "wall_estimate_total_h": 11.5
    },
    "gate_2_d13_basis_coverage": {
      "pass": true,
      "elements": ["H", "Cu", "Li"],
      "upf_paths": ["~/rtsc_li2cuh6/pseudo/H.pbe-rrkjus_psl.1.0.0.UPF", "..."],
      "notes": "PSL 1.0.0 PBE rrkjus convention verified"
    },
    "gate_3_d16_deck_dryrun": {
      "pass": true,
      "deck_path": "decks/li2cuh6/",
      "dryrun_log": "/tmp/li2cuh6_dryrun.log",
      "wall_min": 7
    },
    "gate_4_stability_pre_check": {
      "pass": "PROCEED|AMBER|RED",
      "vcrelax_volume_delta_pct": +38,
      "gamma_min_freq_cm-1": -8.19,
      "branch": "AMBER",
      "rationale": "mild Γ-soft, anharmonic 보류 보고 → full-grid 진행"
    }
  }
}
```

→ harvest agent 가 본 블록을 parse · post-mortem 시 어느 gate 가 fail 했는지 1-grep.

---

## 5. exemption list — protocol 면제 case

다음 case 는 gate 4 (stability_pre_check) 면제 (이미 stability 가 measured anchor):

- H₃S @ 150-200 GPa (Drozdov 2015 measured · 203 K reference)
- CaH₆ @ 150-200 GPa (Ma 2022 measured · 215 K reference)
- LaBeH₈ @ 80 GPa (measured 110 K reference · SSCHA branch 진행 시 별도)

이 anchor 들은 **재현 검증** (reproducibility cell) 라운드 — full 4³q el-ph 직진 OK.

신규 후보 (novel chemistry · 새 prototype · 새 pressure)는 **모두** gate 1-4 적용.

---

## 6. cross-ref

- `RTSC/walls/N5_wall_redefinition.md` — N5 wall 정의 + breakthrough paths (본 protocol 이 paths 의 dispatch-side gate)
- `RTSC/verify/V5_stability_coupling_wall.md` — stability_coupling_margin m 정의 (gate 4 의 quantitative refinement)
- `RTSC/protocols/CANDIDATE_SCORING.md` — gate 4 PROCEED 이후 후보 ranking (sibling protocol)
- `RTSC/protocols/ACTIVE_ACQUISITION.md` — gate 4 결과 후 next-action 선택 (sibling protocol)
- `domains/rtsc.log.md` — Mg₂IrH₆ + Li₂CuH₆ blind-dispatch precedent (이 문서의 motivating evidence)

---

## 7. status — protocol activation

- **status**: PROTOCOL ACTIVE (이 PR 이후 모든 신규 후보 dispatch 에 mandatory)
- **enforcement**: dispatch record 에 `validation_log` 블록 부재 시 atlas register reject (후속 atlas-side 검증 hook 제안 — 별도 PR)
- **rollback**: 본 protocol 의 limitations 를 §1 의 "honesty 경계" 에 박았다 — anchor 재현 / pre-relaxed structure 등은 면제 (§5).
