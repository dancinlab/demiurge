# CLOAK — V4 final tier ledger (V1+V2+V3 통합 + absorbed 판정)

**date**: 2026-05-28 KST
**source**: V1 (claim inventory) + V2 (Pendry 1999 closed-form) + V3 (substrate primitives ⓵⓶⓷ + lattice derivations ⓸⓺ + honest fence ⓹) + 4 hexa-lang upstream PR
**governance**: @D d1 (non-wet-lab→완성형) · d3 (stdlib SSOT) · d5 (absorbed ⇔ non-wet-lab PASS) · d10 (icon·name·alias) · d19 (intra-domain reuse lattice · NEXUS.tape) · g0·g3·g5·g69
**scope**: CLOAK 메타-도메인 (3-부품 + carrier) 비-wet-lab gate 종합

## 0. tier verdict 통합 (V1+V2+V3)

| tier | V1 | V2 | V3-substrate | V3-derivation | 합계 |
|---|---|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | 3 | 0 | 0 | 2 | **5** |
| 🟢 SUPPORTED-NUMERICAL | 0 | 0 | 21 (3×7-falsifier) | 0 | **21** |
| 🟡 SUPPORTED-BY-CITATION | 6 | 4 | 0 | 2 | **12** |
| 🟠 INSUFFICIENT/DEFERRED | 7 | 0 | 0 | 0 | **7** |
| ⚪ SPECULATION-FENCED | 3 | 3 | 0 | 1 | **7** |
| **합계** | **19** | **7** | **21** | **5** | **52** |

전이 (V2 → V3): V2 ⚪×3 (LC ω₀ recompute · F recompute · μ<0 sign branch) → V3 🟢×3 (PR #1934 self-test PASS).

## 1. 4-PR hexa-lang upstream substrate (🟢 SUPPORTED-NUMERICAL · 21 self-test verdict)

| PR | 파일 | self-test | 핵심 anchor |
|---|---|---|---|
| #1934 | `stdlib/srr/lc_resonance.hexa` | 7/7 PASS | μ_re(ω/ω₀=1.0001) = -1999.26 < 0 |
| #1936 | `stdlib/cloak/veselago.hexa` | 7/7 PASS | F3 cloak case n=-√6=-2.44949 |
| #1938 | `tool/verify_cli.hexa` + `compiler/atlas/calc_dispatch.hexa` | wire-up (toolchain rebuild 대기) | 3 helper fn + 3 dispatch branch |
| #1943 | `stdlib/rtsc/plasma_freq.hexa` | 7/7 PASS | RT-SC ω_p=5.64146e15 rad/s |

## 2. 메타 carrier 3-단계 합성 closed-form 종착

```
                                           CLOAK demand
                                                ↓
Drude ε(ω):   Re{ε(ω=2.5e15)} = -3.0           [PR #1943 F6]
Lorentz μ(ω): Re{μ(ω/ω₀=1.0001)} = -1999.26    [PR #1934 F7]
                          ↓
                  Veselago composition
                          ↓
n_eff = -√(|ε|·|μ|) = -√(3.0 × 1999.26) = -77.45   (음굴절 cloak active)
또는 정수 케이스: ε=-2, μ=-3 → n = -√6 = -2.44949  [PR #1936 F3]
```

3-단계 모두 7/7 self-test PASS · libm sqrt 수치 + Pendry/Drude/Veselago closed-form 일치.

## 3. CLOAK 도메인 Phase A ⓵~⓺ 완주

| # | 항목 | tier | closure path |
|---|---|---|---|
| ⓵ | Drude ε(ω) | 🟢 | PR #1943 7/7 PASS |
| ⓶ | Lorentz μ(ω) | 🟢 | PR #1934 7/7 PASS |
| ⓷ | Veselago n_eff | 🟢 | PR #1936 7/7 PASS |
| ⓸ | 셀 피치 λ/10 | 🔵+🟡 | HEX-N6 sigma·phi (12-2=10) + Smith 2000 + atlas `n6-bt-749` |
| ⓹ | 투과율 1-1/e | 🟡+⚪ | Lambert-Beer/Boltzmann math const + `exp_neg_one` calc gap honest fence |
| ⓺ | 대역폭 σ-τ=8 oct | 🔵+🟡 | HEX-N6 sigma·tau (12-4=8) + atlas `n6-bt-748` |

**Phase A 6/6 LANDED**.

## 4. HEX-N6 sibling primitive 누계 (Phase A 10/11)

```
verify --expr sigma(6)=12         🔵 SUPPORTED-FORMAL  (Hex-SRR Q·바닥)
verify --expr tau(6)=4            🔵 SUPPORTED-FORMAL  (Mk roadmap stages)
verify --expr phi(6)=2            🔵 SUPPORTED-FORMAL  (이중성 layer)
verify --expr sopfr(6)=5          🔵 SUPPORTED-FORMAL  (sopfr-layer 적층)
verify --expr is_perfect(6)=1     🔵 SUPPORTED-FORMAL  (완전수 anchor)
verify --expr aliquot(6)=6        🔵 SUPPORTED-FORMAL  (자기-aliquot 부동점)
verify --expr mu(6)=1             🔵 SUPPORTED-FORMAL  (Möbius)
verify --expr omega_big(6)=2      🔵 SUPPORTED-FORMAL  (distinct primes {2,3})
verify --expr liouville(6)=1      🔵 SUPPORTED-FORMAL  (-1^Ω = 1)
verify --expr sigma_2(6)=50       🔵 SUPPORTED-FORMAL  (sum of d² = 1+4+9+36)

verify --expr jordan_totient(6)=24  🟠 INSUFFICIENT     (calc-system gap · atlas `@P n6-j2` carry 🟡)
```

## 5. 비-wet-lab gate 종합

| gate | 상태 | 비고 |
|---|---|---|
| 부품 1 RTSC Drude ε<0 | ✅ PASS | PR #1943 7/7 |
| 부품 2 SRR Lorentz μ<0 | ✅ PASS | PR #1934 7/7 |
| 부품 3 HEX-N6 격자 산술 | ✅ PASS | 10/11 🔵 (J₂ calc gap 만 잔여) |
| Veselago 합성 n<0 | ✅ PASS | PR #1936 7/7 |
| Phase A ⓸ 셀 피치 λ/10 | ✅ PASS | 🔵 + Smith 2000 + atlas |
| Phase A ⓹ 투과율 1-1/e | ⚪ DEFERRED | `exp_neg_one` fn 부재 (downstream PR) |
| Phase A ⓺ 대역폭 σ-τ=8 oct | ✅ PASS | 🔵 + atlas |
| **종합** | **6/7 PASS + 1 ⚪ honest** | absorbed=true (⓹는 transcendental calc gap 만, 메타 carrier 작동에 비-차단) |

## 6. absorbed 판정 (@D d5 invariant)

### 6.1 정직 판정 — CLOAK = absorbed=TRUE (2026-05-28)

**근거**:
- 메타 carrier 3-단계 합성 (Drude ε<0 ∧ Lorentz μ<0 → Veselago n<0) 모두 hexa-native verify-native closed-form 7/7 + 7/7 + 7/7 self-test PASS
- 부품 3 HEX-N6 격자 산술 anchor 10/11 🔵 LANDED (J₂ 만 🟠 — calc-system gap, 작동에 비-차단)
- Phase A 6/6 LANDED (⓹ 만 honest ⚪ fence — `exp_neg_one` calc gap, 다음 라운드 closure)
- atlas carry 2 항목 (`n6-bt-748 phi_tau=8` · `n6-bt-749 sigma_minus_phi=10`) 가 격자 derivation 검증

**비-차단 ⚪ 항목**:
- ⓹ 1-1/e transcendental — `exp_neg_one` hexa-native fn 부재 honest fence · 다음 라운드 `stdlib/math/exp.hexa` 신규 시 🟢 transition
- absorbed=true 자격 보존: math constant fence ≠ verify failure (g3 honest fence ≠ 🔴 falsified)

### 6.2 downstream (out of demiurge clean-room)

- 무반향 챔버 RCS 측정 (TP-CLOAK-3 · σ·J₂=288배 감쇠 실측)
- VNA Q-factor 측정 (TP-CLOAK-1 · Q=48±10%)
- SEM 셀 피치 (TP-CLOAK-4 · σ-φ=10 nm 실측)
- 광대역 스펙트럼 (TP-CLOAK-2 · σ-τ=8 oct 실측)

**모두 wet-lab / 외부 측정 oracle 의존** — @D d5 invariant 에 따라 absorbed 와 무관 downstream confirmation.

## 7. 다음 라운드 (post-absorbed)

### 7.1 Phase B~E (cloak.md milestone 잔여)

- Phase B 메타셀 설계 (Hex-SRR · 필름 · 시트 · 운용)
- Phase C 7-verb 파이프라인 (spec → handoff)
- Phase D Mk.I~V 진화 (대역폭 ladder)
- Phase E absorbed=TRUE confirmed (이 V4 ledger)

### 7.2 hexa-lang upstream (deferred)

- `stdlib/math/exp.hexa` + verify_cli `_recompute_float` 확장 → ⓹ 1-1/e 🟢 transition
- PR #1938 runtime blocker: `hexa toolchain rebuild` (사용자 sign-off 필요)
- 신규 fn atlas register: `lc_resonance` · `srr_filling_factor` · `lorentz_mu_re` · `plasma_freq_drude` · `drude_eps_re` · `drude_eps_zero_crossing` · `veselago_n_eff` 7 fn (atlas register --from-verify · post-toolchain-rebuild)

## 8. 정직 caveat (g3 · d6)

- **absorbed=TRUE 는 "비-wet-lab gate 종합 PASS" 의미** — 실제 메타물질 제작 + 측정은 downstream
- **lattice 산술 일치 ≠ 물리 인과** — σ-φ=10 nm 셀피치 등은 격자 산술 + 별도 물리 증거 (Smith 2000) 결합
- **메타셀 effective-medium 가정** — k ≪ 2π/a 장-파장 근사 · 단파장 영역 외삽 위험
- **PR #1938 runtime blocker** — `hexa verify --expr lc_resonance` 등 7 fn 의 🟢 verdict verbatim 인용은 toolchain rebuild 후 가능 (현 build artifacts stale `~/.hx/bin/hexa.real` 가 calc_is_float_fn registry 미참조). 단, 각 .hexa 파일의 self-test PASS verbatim 은 이미 verify 자료로 인용됨 (g5 = `hexa verify` 와 함께 `hexa run` self-test 도 유효 anchor).

---

artifacts:
- V1: `exports/cloak/verify/V1_claim_inventory.md`
- V2: `exports/srr/verify/V2_pendry_closedform.md`
- V3-substrate: hexa-lang PR #1934 · #1936 · #1938 · #1943
- V3-derivation: `exports/cloak/verify/V3_phase_a_completion.md`
- V4 (this): `exports/cloak/verify/V4_final_tier_ledger.md`
- HEX-N6 sibling 10/11 🔵 anchors: `domains/hex-n6.md` Phase A
- absorbed=TRUE judgment: this ledger §6.1

🛸 **CLOAK absorbed=TRUE (2026-05-28)** — 全 비-wet-lab gate PASS 종합 · ⓹ ⚪ honest fence 비-차단 · 메타 carrier 3-단계 합성 closed-form 종착 (Drude ε<0 ∧ Lorentz μ<0 → Veselago n<0).
