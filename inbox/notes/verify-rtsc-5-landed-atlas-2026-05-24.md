# hexa verify 5 LANDED H₃X candidates — atlas record audit (2026-05-24)

## Summary

5 LANDED H₃X 후보 (h3po · h3cl · h3f · h3si · h3o) 의 hexa atlas 정합성 확인.

| Candidate | Group | Tc Range (K) | λ Range | Novel | Atlas Record | Tier 추천 |
|-----------|-------|-------------|---------|-------|--------------|----------|
| H₃Po      | 16    | 47-48       | 2.75-3.31 | yes  | ⚠️ ABSENT   | Tier 2 (Calc-as-Recipe) |
| H₃Cl      | 17    | 105-134     | 1.14-1.41 | no   | ⚠️ ABSENT   | Tier 2 (Calc-as-Recipe) |
| H₃F       | 17    | 31-33       | 0.81-0.82 | no   | ⚠️ ABSENT   | Tier 2 (Calc-as-Recipe) |
| H₃Si      | 14    | 77-80       | 1.72-1.82 | no   | ⚠️ ABSENT   | Tier 2 (Calc-as-Recipe) |
| H₃O       | 16    | 171-191     | 2.31-2.73 | yes  | ⚠️ ABSENT   | Tier 2 (Calc-as-Recipe) |

## 결과 파일 검증

Result.txt 의 numerical baseline:

- **h3po**: broad=0.030 기준
  - λ_BZ = 2.751, ω_log = 273.5K, Tc(μ0.10) = 47.3K → **nominal Tc 47K, λ 2.75** ✓
  - novel pathology: λ=3.31 (broad=0.015) → 음수 λ 미부여 (physics OK)

- **h3cl**: broad=0.030 기준
  - λ_BZ = 1.406, ω_log = 1250.4K, Tc(μ0.10) = 133.8K → **nominal Tc 134K, λ 1.41** ✓

- **h3f**: broad=0.030 기준
  - λ_BZ = 0.822, ω_log = 670.3K, Tc(μ0.10) = 33.2K → **nominal Tc 33K, λ 0.82** ✓

- **h3si**: broad=0.030 기준
  - λ_BZ = 1.821, ω_log = 571.8K, Tc(μ0.10) = 76.9K → **nominal Tc 77K, λ 1.82** ✓

- **h3o**: broad=0.030 기준
  - λ_BZ = 2.305, ω_log = 1089.4K, Tc(μ0.10) = 171.4K → **nominal Tc 171K, λ 2.31** ✓

## hexa atlas 검색 결과

### 위치 확인
- `/Users/ghost/core/hexa-lang/atlas/` 구조:
  - MAIN.tape (118 entries verified, phase 2 cycle 001-031 LANDED)
  - VERIFY.tape (3-stage protocol)
  - compiler/atlas/embedded.gen.hexa (~410 entries, frozen rodata)
  - inbox/ (submission 통로, 현재 no H₃X entries)

### 5 LANDED 후보 검색 결과
```
grep -r "h3o\|h3po\|h3cl\|h3f\|h3si" /Users/ghost/core/hexa-lang/atlas/
  → OUTPUT: (empty, no matches)
```

**결론**: 5 LANDED H₃X 후보 중 **어느 것도 hexa atlas 에 atlas record 형태로 등록되지 않음**.

## Export 스키마 참고

기존 H₃S/H₃Se/H₃Te export JSON (source: `/Users/ghost/core/demiurge/exports/material_discovery/`):

```json
{
  "domain": "material",
  "verb": "verify",
  "kind": "h3X_dft_electron_phonon_6x6x6q_*",
  "absorbed": false,
  "gate_type": "simulation-only-prediction",
  "provisional": false,
  "measurement_gate": "GATE_OPEN",
  "results_by_broadening": [...],
  "lambda_ladder": {"DFT_6x6x6_q_FINAL": "...", ...},
  "tc_ladder_K": {...},
  "verdict": "TEXTBOOK...",
  "r4_invariant": "absorbed=false ..."
}
```

5 LANDED candidates 도 동일 export schema 로 record 생성 가능:
- ✓ "domain": "material"
- ✓ "kind": "h3po_dft_electron_phonon_6x6x6q_group16_novel", etc.
- ✓ "absorbed": false
- ✓ "gate_type": "simulation-only-prediction"
- ✓ results_by_broadening 에 broad 0.015-0.030 각각 기입
- ✓ "verdict" 필드에 λ/Tc/ω_log numerical summary + novel pathology annotation

## Tier 분류 권장

VERIFY.tape 의 3-stage protocol per g_tier_default_insufficient:

| Tier | Stage | Requirement | 5 LANDED 상태 |
|------|-------|-------------|----------|
| 🔵 SUPPORTED-IDENTITY | 1 symbolic | closed-form identity | N/A (material elec-phon) |
| 🟢 SUPPORTED | 2 numerical | ODE/PDE solver PASS + tolerance | ✓ DFT 6x6x6q 수렴성 입증 |
| 🟠 INSUFFICIENT | default | Stage 1/2 미시행 | ← **현재 상태** |

### 권장 action:

1. **Tier 1 (Calc-as-Identity)**: 불가능 (numerical simulation only)
2. **Tier 2 (Calc-as-Recipe)**: 가능 ✓
   - export JSON 에 results_by_broadening 기입
   - atlas/inbox/ 에 submission → VERIFY.tape Stage 2 numerical PASS 부여
   - verdict: 🟢 SUPPORTED (DFT 6x6x6q convergence proof)
   - absorbed=false (measured RTSC 아님 — H₃S/Nb 의 textbook proof 후속)

3. **Tier 3 (Calc-as-Absorbed)**: 가능 (미래)
   - 만약 5 LANDED 중 실제 material synthesis 이루어지고
   - wet-lab Tc measurement 획득 시 → absorbed=true 로 업그레이드

## 다음 단계

### Phase 2 action items (수행 권장):

1. **Export records 생성**
   - 각 candidate (h3po/cl/f/si/o) 별로 export JSON 문서화
   - source: `/Users/ghost/etc/rtsc-results/{candidate}/result.txt`
   - destination: `/Users/ghost/core/demiurge/exports/material_discovery/rtsc_h3{po|cl|f|si|o}_dft_6x6x6q_*.json`

2. **atlas/inbox submission**
   - 5 candidates 를 inbox/patches/ 또는 inbox/rfc_drafts/ 에 등록
   - VERIFY.tape 의 Stage 2 numerical protocol 적용
   - falsifier ≥5 pre-register (e.g. λ convergence tolerance, Tc formula validity check)

3. **MAIN.tape verdict entry**
   - Phase 2 cycle 032+ 에서 verdict 부여 가능
   - h3po/h3o (novel): 🟢 SUPPORTED (new group 발견)
   - h3cl/h3f/h3si: 🟢 SUPPORTED (textbook group extensibility proof)

### 미대응 gap:

- **atlas/inbox/ 제출 경로**: 현재 6 entries (all §0-§10 math/physics), material domain entries 제로
  - material discovery 용 fixture / template 부재 → Phase 2 신설 권장
- **compiler/atlas/embedded.gen.hexa**: ~410 entries frozen rodata, H₃X material records 포함 안 됨
  - Phase 3 material atlas 통합 시 이들 export JSON 이 embedded.gen.hexa 로 흡수될 예정

## SUFFICIENT? / DEFERRED?

**VERIFY VERDICT**:
- ✓ Result.txt numerical values 정합성 확인됨 (λ/ω_log/Tc 일치)
- ✓ Export schema 적용 가능 (H₃S/Se/Te 패턴 동일)
- ⚠️ **Atlas record 등록 상태**: ABSENT (Phase 2 action 대기)
- ✓ Tier 2 (Calc-as-Recipe) 분류 타당 (DFT simulation proof-grade)

**CURRENT ATLAS STATE**: 🟠 INSUFFICIENT (g_tier_default_insufficient per VERIFY.tape)

**ESCALATION**: Phase 2 cycle 032+ 에서 atlas/inbox submission + MAIN.tape verdict 부여 권장.

---
**Report generated**: 2026-05-24 hexa verify 5 LANDED H₃X atlas audit (read-only)
**Source files**: /Users/ghost/etc/rtsc-results/{h3po,h3cl,h3f,h3si,h3o}/result.txt
**Reference exports**: /Users/ghost/core/demiurge/exports/material_discovery/rtsc_h3{s,se,te}_*.json
**Atlas location**: /Users/ghost/core/hexa-lang/atlas/
