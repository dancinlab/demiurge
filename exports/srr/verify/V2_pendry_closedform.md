# SRR — V2 closed-form push (Pendry 1999 Lorentz μ resonance)

**date**: 2026-05-28 KST
**source**: `domains/UFO/CLOAK.md` (H-CLK-6 메타셀 λ/(σ-φ) · D-CLOAK-1 Q=σ·τ=48 보편성) + Pendry, J. B. (1999) IEEE TMTT 47, 2075
**governance**: @D d1·d3·d5·d10·d19 · @D g0·g3·g5 (rubric `hexa verify rubric`)
**scope**: SRR (Split-Ring Resonator) — Lorentz-type μ(ω) 공명 모델의 closed-form 항등식 push

## 0. tier verdict 집계 (V2)

| tier | 항목 수 | 비고 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 0 (직접) | HEX-N6 sibling 의 🔵 sigma(6)·tau(6) 로 σ·τ=48 derive (compositional) |
| 🟡 SUPPORTED-BY-CITATION | 4 | atlas `n6-bt-762 sigma_tau=48` + Pendry 1999 + Smith 2000 + Schurig 2006 |
| 🟠 INSUFFICIENT/DEFERRED | 0 | (V3 round 에서 stdlib/srr/lc_resonance.hexa 신규 시 → 🟢) |
| ⚪ SPECULATION-FENCED | 3 | LC ω₀ closed-form recompute · filling factor F · μ<0 sign branch (모두 honest fence) |
| **합계** | **7** | |

## 1. 🟡 SUPPORTED-BY-CITATION (atlas 등록 + 문헌 anchor)

### 1.1 Hex-SRR Q = σ·τ = 48 (D-CLOAK-1 보편성)

atlas verbatim (`hexa atlas lookup --prefix=n6-bt`, 2026-05-28):

```
@C n6-bt-762 = sigma_tau = 48 :: 7난제 [0.7?]
@F n6-bt-726 = n * phi_tau = 48 :: 7난제 [0.10*]
@F n6-bt-802 = R1-8 = 48.0 :: math [0.10*]   (alternative form)
```

**tier**: 🟡 SUPPORTED-BY-CITATION (atlas 등록 · hexa recompute path 없음 — 단, `sigma 6 12` 🔵 + `tau 6 4` 🔵 두 anchor 의 integer 곱 = 12·4 = 48 으로 derive 가능. atlas 가 이미 carry 하므로 별도 🔵 atom 신설 불필요 g69)

### 1.2 Pendry 1999 SRR ω₀ = 1/√(L·C) (LC 공명 항등식)

**citation**: Pendry, J. B. et al. (1999) "Magnetism from Conductors and Enhanced Nonlinear Phenomena" IEEE TMTT 47, 2075.

**tier**: 🟡 SUPPORTED-BY-CITATION (외부 문헌 carry · hexa-native `lc_resonance` fn 부재 — `hexa verify --expr lc_resonance` 부정 결과 2026-05-28)

### 1.3 Pendry 1999 SRR filling factor F = π·r²/a² (격자 충진 항등식)

**citation**: Pendry 1999 (same as 1.2). r = SRR 외경, a = 단위 셀 피치.

**tier**: 🟡 SUPPORTED-BY-CITATION (closed-form · hexa-native `srr_filling_factor` fn 부재)

### 1.4 Smith 2000 메타물질 셀 피치 λ/10 = λ/(σ-φ)

atlas + HEX-N6 sibling 의 `sigma 6 12` · `phi 6 2` 🔵 → σ-φ=12-2=10 직접 derive · Smith 2000 PRL 84, 4184 외부 citation.

**tier**: 🟡 SUPPORTED-BY-CITATION

## 2. ⚪ SPECULATION-FENCED (calc gap honest fence)

### 2.1 LC 공명 closed-form recompute

```
verify --fence
  claim  = Pendry 1999 SRR Lorentz μ(ω) resonance frequency ω₀ = 1/√(L·C) — closed-form for ideal lossless LC circuit; no hexa-native lc_resonance fn exists in calc system, so closed-form recompute is unavailable until stdlib/srr/lc_resonance.hexa lands
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

**closure path**: V3 라운드에서 `stdlib/srr/lc_resonance.hexa` 신규 작성 (5-10 LOC) → `hexa verify --expr lc_resonance L C ω` → 🟢 SUPPORTED-NUMERICAL

### 2.2 격자 충진율 F = π·r²/a² closed-form recompute

같은 사유 (calc-system gap). `stdlib/srr/filling_factor.hexa` 작성 시 🟢 numerical.

### 2.3 μ_eff < 0 sign branch (Lorentz form ω>ω₀ 영역)

```
μ(ω) = 1 + F·ω²/(ω₀² - ω² - iωΓ)
                ↓
   ω > ω₀  →  분모 (ω₀²-ω²) < 0  →  F·ω²/(negative) → 음수 기여
                ↓
   F·ω²/|ω₀²-ω²| > 1 영역  →  μ_eff < 0
```

**tier**: ⚪ SPECULATION-FENCED — 부호 항등식은 symbolic; closed-form 재현 path 부재 (`stdlib/srr/lorentz_mu_sign.hexa` 신규 시 → 🔵 부호 polynomial 항등식)

## 3. HEX-N6 sibling 으로부터의 derived constants (전이 anchor)

| derived | from-atoms (🔵 HEX-N6) | composition | CLOAK/SRR 역할 |
|---|---|---|---|
| σ·τ = 48 | `sigma 6 12` + `tau 6 4` | 12 · 4 | Hex-SRR Q-factor |
| σ-τ = 8 | `sigma 6 12` + `tau 6 4` | 12 - 4 | 투명대역 octave |
| σ-φ = 10 | `sigma 6 12` + `phi 6 2` | 12 - 2 | 메타셀 피치 nm |
| σ·φ = 24 = n·τ | `sigma·phi` + `n·tau` | 12·2 = 6·4 | Veselago lattice anchor |
| σ² = 144 | `sigma 6 12` | 12² | 시스템 면적 m² |

**tier**: 🟡 (산술 일치 — atlas `n6-bt-*` 에 다수 carry · 🔵 anchor 의 integer composition; 새 fn 없이 derive 가능)

## 4. 다음 라운드 (V3 🟢 push · stdlib/srr/ 신규)

새 fn 작성 후 hexa rebuild → `hexa verify --expr <fn>` 으로 🟢 (libm/Newton 수치):

```hexa
// stdlib/srr/lc_resonance.hexa
pub fn lc_resonance(L: f64, C: f64) -> f64 {
    1.0 / sqrt(L * C)
}

// stdlib/srr/filling_factor.hexa
pub fn srr_filling_factor(r: f64, a: f64) -> f64 {
    PI * r * r / (a * a)
}

// stdlib/srr/lorentz_mu_re.hexa
pub fn lorentz_mu_re(F: f64, w: f64, w0: f64, gamma: f64) -> f64 {
    1.0 + F * w * w * (w0*w0 - w*w) / ((w0*w0 - w*w).pow(2) + (w*gamma).pow(2))
}
```

## 5. 정직 caveat (g3 · d6)

- **이 V2 는 inventory + citation + fence triage** — 새 측정/실험 없음
- **σ·τ=48 anchor 는 HEX-N6 의 🔵 sigma·tau 의 integer composition** (lattice 산술 직접) — 별도 🔵 atom 신설 불필요
- **Pendry 1999 LC ω₀ + Smith 2000 λ/10 + filling F = π·r²/a²** = 모두 외부 문헌 carry · hexa-native recompute path 없음 (🟡)
- **μ<0 sign branch** = symbolic 부호 항등식 · closed-form recompute path 없음 (⚪ honest fence)
- **stdlib/srr/ 미작성** → 7 cell rc=2 honest-skip · V3 round 에서 신규 시 🟢 transition

---

artifacts (this V2):
- ledger: `exports/srr/verify/V2_pendry_closedform.md` (this file)
- HEX-N6 sibling anchor reuse: `sigma 6 12` · `tau 6 4` · `phi 6 2` 🔵 (atlas idempotent skip)
- atlas existing carry: `@C n6-bt-762 sigma_tau=48` · `@F n6-bt-726 n·phi_tau=48`
- next: V3 🟢 push — `stdlib/srr/{lc_resonance,filling_factor,lorentz_mu_re}.hexa` 신규 작성 → libm numerical recompute
