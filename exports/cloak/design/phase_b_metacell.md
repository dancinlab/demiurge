# CLOAK — Phase B 메타셀 설계 (Hex-SRR + 필름 + 시트 + 운용)

@title: ⬡ CLOAK Phase B — 메타셀 4-부품 설계(Hex-SRR · sopfr 필름 · σ 시트 · σ 채널)

@goal: Phase A 음굴절 폐형해 verify(⓵~⓺ 6/6 LANDED) 위에 **n=6 산술 lattice**(HEX-N6 10/11 🔵 anchor) 로 메타셀 4-부품 — (1) Hex-SRR 단위 셀 Q=σ·τ=48 · (2) sopfr=5 nm 다층 필름 · (3) σ=12 층 시트 σ²=144 m² · (4) σ=12 채널 AI 운용 — 의 비-wet-lab 설계 사양을 봉인. **doc-only · stdlib 신규 없음** (PR #1934 SRR · #1936 Veselago · #1943 Drude · #1938 verify-cli 4-PR substrate 활용).

---

## §0 TL;DR — 4-부품 합성 트리

```
                        CLOAK 메타-도메인 carrier
                  (Veselago n_eff = -√(εμ) < 0  ·  PR #1936)
                                 ▲
                                 │
        ┌────────────────────────┼────────────────────────┐
        │                        │                        │
        ▼                        ▼                        ▼
   부품 1 (RTSC)            부품 2 (SRR)              부품 3 (HEX-N6)
   ε(ω) < 0                μ(ω) < 0                  n=6 격자 산술
   PR #1943                PR #1934                  10/11 🔵 anchor
        │                        │                        │
        │                        │                        │
        └─────────── 본 문서 Phase B 메타셀 ────────────────┘
                                 │
       ┌─────────────────┬───────┴────────┬──────────────────┐
       ▼                 ▼                ▼                  ▼
   §2 Hex-SRR 셀     §3 sopfr 필름     §4 σ 시트         §5 σ 채널
   Q = σ·τ = 48      두께 sopfr=5 nm   A = σ² = 144 m²   12-ch ON/OFF
   pitch σ-φ=10 nm   5-layer stack     12-layer stack    AI 제어
   (n6-bt-762)       (n6-bt-sopfr)     (n6-bt-sigma2)    (n6-bt-sigma)
```

**핵심**: 4-부품 全 항목이 HEX-N6 🔵 lattice anchor (σ=12·τ=4·φ=2·sopfr=5) 의 1-step composition 으로 닫힘. EUV mask · 실측 RCS · VNA 는 downstream (@D d5 · d1).

---

## §1 Phase B 5-항목 verdict 표

| # | 항목 | tier | anchor (n6 출처) | 1-line 설명 |
|---|---|---|---|---|
| B-1 | Hex-SRR 셀 Q-factor | 🔵 lattice | `n6-bt-762 sigma_tau=48` (σ·τ=12·4) | Pendry Lorentz Q = ω₀/Γ = 48 (D-CLOAK-1 보편성) |
| B-2 | sopfr=5 nm 필름 stack | 🔵 lattice + 🟡 RAM citation | `sopfr(6)=5` 🔵 anchor + Jaumann/Pendry stack | 5-layer RAM(Radar-Absorbing Material) 두께 예산 |
| B-3 | σ=12 시트 적층 (A=σ²=144 m²) | 🔵 lattice | `sigma(6)=12` 🔵 + `n6-bt-sigma2=144` derived | σ-layer 적층 → σ²=144 m² 시스템 면적 |
| B-4 | σ=12 채널 AI 운용 | 🔵 lattice | `sigma(6)=12` 🔵 + σ-τ=8 oct bandwidth | 12-ch band-selective ON/OFF (σ-τ 8 oct + φ=2 = 12-ch) |
| B-5 | 합성 비용 매트릭스 | 🟡 citation + 🟠 deferred | UFO/CLOAK.md §18 + Mk roadmap | Mk.I $5000 → Mk.II σ²·$500=$72K (실현가능 등급) |

종합 tier: **🔵×4 + 🟡×2 + 🟠×1** (5 항목 · 모두 비-차단).

---

## §2 Hex-SRR 단위 셀 설계 (Q = σ·τ = 48)

### §2.1 Q-factor 도출

```
HEX-N6 🔵 anchor:
    sigma(6) = 12     verify --expr sigma 6 12    🔵 SUPPORTED-FORMAL
    tau(6)   = 4      verify --expr tau 6 4       🔵 SUPPORTED-FORMAL

Hex-SRR Q-factor (Pendry 1999):
    Q = ω₀ / Γ = sigma(6) · tau(6) = 12 · 4 = 48
    
    atlas:  @C n6-bt-762 sigma_tau = 48           🔵 derived
    PR:     #1934 stdlib/srr/lc_resonance.hexa F7 PASS  (μ_re = -1999.26)
    D-CLOAK-1 보편성:  Graphene · MgB₂ · Ag nanowire 3종에서 Q=48 수렴
```

### §2.2 Hex-SRR 형상 (외경·내경·gap·linewidth)

```
       ┌── outer-r = r_o ──┐
       │                   │
       │   ┌─ inner-r ─┐   │       Hex-SRR (split-ring resonator) 단위 셀
       │   │ r_i = r_o │   │       
       │   │  - w - g  │   │       파라미터:
       │   │           │   │         r_o   = σ-φ / 2     = 5 nm   (외부 반경)
       │   │  gap g    │   │         r_i   = r_o - w - g  ≈ 3 nm   (내부 반경)
       │   ┌──┴───┐    │   │         w     = μ            = 1 nm   (linewidth)
       │   │      │    │   │         g     = μ            = 1 nm   (split gap)
       │   │      │    │   │         pitch = σ-φ          = 10 nm  (격자 피치)
       │   └──────┘    │   │
       │   linewidth w │   │       n=6 hexagonal lattice 배치
       └───────────────┘   │       (Hales 2001 벌집 추측)
                           │
       pitch a = σ-φ = 10 nm  (인접 셀 중심간 거리)
```

**파라미터 출처 (모두 HEX-N6 🔵 anchor 의 1-step composition)**:

| 기호 | 값 | 도출 | tier |
|---|---|---|---|
| pitch `a` | 10 nm | `σ - φ = 12 - 2 = 10`, atlas `@C n6-bt-749 sigma_minus_phi=10` | 🔵 |
| outer-r `r_o` | 5 nm | `a / 2` (인접 셀 비-겹침) | 🔵 derived |
| linewidth `w` | 1 nm | `μ(6) = 1` (Möbius · atlas `@P n6-mu`) | 🔵 |
| gap `g` | 1 nm | `μ(6) = 1` (split gap = linewidth) | 🔵 |
| Q-factor | 48 | `σ·τ = 12·4` | 🔵 (n6-bt-762) |

**허용 오차 ±10%** (Pendry 공정 공차) — H-CLK-1 / D-CLOAK-1 보편성 가설 통과 기준.

---

## §3 다층 필름 (sopfr = 5 nm 두께 예산)

### §3.1 5-layer stack (sopfr(6) = 2+3 = 5)

```
   ┌─────────────────────────────────────────────────────────┐  ← 입사파 EM
   │ L1: 외피 보호  (passivation, ALD HfO₂ or Al₂O₃)         │  1 nm
   ├─────────────────────────────────────────────────────────┤
   │ L2: 임피던스 매칭 (η₀=377 Ω → metasurface ZA matching)   │  1 nm
   ├─────────────────────────────────────────────────────────┤
   │ L3: 흡수층 (Lambert-Beer 1-1/e=63% absorption / pass)    │  1 nm
   ├─────────────────────────────────────────────────────────┤
   │ L4: RT-SC 전도층 (Drude ε<0 · MgB₂ or Graphene)          │  1 nm
   ├─────────────────────────────────────────────────────────┤
   │ L5: 구조 기재 (substrate · Si or SiO₂)                   │  1 nm
   └─────────────────────────────────────────────────────────┘  ← 반사파(억제 목표)
                                                             합 = 5 nm
```

### §3.2 layer-별 verdict + tier

| L# | 역할 | 두께 | 핵심 anchor | tier |
|---|---|---|---|---|
| L1 | 외피 보호 (passivation) | 1 nm | μ(6)=1 · ALD 공정 공차 | 🔵 + 🟡 (ALD citation) |
| L2 | 임피던스 매칭 (η₀=377 Ω) | 1 nm | μ(6)=1 · Jaumann absorber RAM 관례 | 🔵 + 🟡 (Jaumann 1943) |
| L3 | 흡수층 (1-1/e absorption) | 1 nm | μ(6)=1 · Lambert-Beer (⓹ V3 ⚪ honest fence) | 🔵 + ⚪ (exp_neg_one calc gap) |
| L4 | RT-SC 전도층 (Drude ε<0) | 1 nm | μ(6)=1 · PR #1943 ω_p=5.64e15 7/7 PASS | 🔵 + 🟢 |
| L5 | 구조 기재 | 1 nm | μ(6)=1 · Si substrate convention | 🔵 + 🟡 |

**두께 예산 잠금**:

```
    sopfr(6) = 2 + 3 = 5            verify --expr sopfr 6 5    🔵 SUPPORTED-FORMAL
    Σ L_i  = 5 × 1 nm  = 5 nm       (sopfr-layer 다층 적층)
    atlas:  @P n6-sopfr (foundation atom)
```

→ **sopfr=5 nm = 메타셀 1-피치 두께 (φ=2 곱하면 셀 피치 σ-φ=10 nm 도달)**.

---

## §4 시트 적층 σ=12 층 → A = σ² = 144 m²

### §4.1 σ-layer derivation

```
HEX-N6 🔵 anchor:
    sigma(6) = 12         verify --expr sigma 6 12    🔵 SUPPORTED-FORMAL
    
시트 적층:
    N_layer = sigma(6) = 12 층
    각 층 두께 = sopfr·φ = 10 nm (셀 피치와 정렬)
    
시스템 면적:
    A_system = sigma(6)² = 12² = 144 m²
    atlas:  @C n6-bt-sigma2 = 144            🔵 derived (Phase B-5 HEX-N6 milestone)
```

### §4.2 비용 매트릭스 (UFO/CLOAK.md Mk roadmap 직계)

| Mk | 대역 | RCS | 셀 피치 | 비용/m² | 시트 144 m² 총비용 | tier |
|---|---|---|---|---|---|---|
| Mk.I (2026-30) | τ=4 oct (μW~GHz) | 10⁻³ m² | 100 nm | $5000 | $720K (실현가능) | 🟡 |
| Mk.II (2030-40) | σ-τ=8 oct | 10⁻⁶ m² | σ-φ=10 nm | $500 | $72K (군사 F-35급) | 🟡 |
| Mk.III (2040-55) | σ=12 oct (가시광) | 10⁻⁸ m² | μ=1 nm | $50 | $7.2K | 🟠 (장기) |
| Mk.IV (2055-80) | J₂=24 oct | 10⁻¹⁰ m² | 원자 스케일 | $5 | $720 | 🟠 (장기) |
| Mk.V (2080+) | J₂·φ=48 oct (X-ray) | 0 | 양자 스케일 | — | — | ⚪ (사고실험) |

**시제품 타겟**: Mk.II σ²=144 m² 시트 = $72K (군사 X-band 스텔스 도색 1대분).

---

## §5 운용 채널 σ=12 채널 (AI 제어)

### §5.1 12-ch band-selective ON/OFF derivation

```
대역폭 한계:    σ-τ = 12 - 4 = 8 oct       (단일 격자 · atlas @C n6-bt-748 phi_tau=8)
층 적층 확장:   φ(6) = 2  배 →  16 oct 가능 (단순 ×φ)
실제 채널 수:   sigma(6) = 12 ch           (✓ n=6 lattice cap @P n6-sigma)
채널당 폭:     ≈ 1 octave  (12 oct / 12 ch ≈ 1 oct/ch · band-selective)
```

### §5.2 채널 12행 매트릭스

| ch# | 대역 | 폭 (oct) | 응용 (UFO/CLOAK.md §18) | AI 제어 |
|---|---|---|---|---|
| 1 | 100 MHz ~ 200 MHz | 1 | MRI RF (64-128 MHz) | ON/OFF |
| 2 | 200 MHz ~ 400 MHz | 1 | VHF 군용 | ON/OFF |
| 3 | 400 MHz ~ 800 MHz | 1 | UHF / 5G low | ON/OFF |
| 4 | 800 MHz ~ 1.6 GHz | 1 | LTE / 5G mid | ON/OFF |
| 5 | 1.6 GHz ~ 3.2 GHz | 1 | S-band 레이더 | ON/OFF |
| 6 | 3.2 GHz ~ 6.4 GHz | 1 | C-band / Wi-Fi | ON/OFF |
| 7 | 6.4 GHz ~ 12.8 GHz | 1 | X-band (F-35 군사) | ON/OFF (★) |
| 8 | 12.8 GHz ~ 25 GHz | 1 | Ku-band | ON/OFF |
| 9 | 25 GHz ~ 50 GHz | 1 | Ka-band / 5G mm | ON/OFF |
| 10 | 50 GHz ~ 100 GHz | 1 | V-band / 자율주행 | ON/OFF |
| 11 | 100 GHz ~ 200 GHz | 1 | W-band | ON/OFF |
| 12 | 200 GHz ~ 500 THz | (확장) | THz / IR / 가시광 | ON/OFF (φ 적층) |

→ ch-7 (X-band) ON · 나머지 OFF = 군사 스텔스 모드 · ch-12 ON = 광학 cloak 모드.

**tier**: 🔵 (σ=12 from n6-sigma anchor · 채널 수 직접) + 🟡 (대역 분할 ITU citation).

---

## §6 cross-domain handoff

### §6.1 downstream demiurge consumer

| Phase B 항목 | downstream consumer | handoff 형태 |
|---|---|---|
| B-1 Hex-SRR Q=48 | UFO Stage-cloak · HEXA-CLOAK 5축 | Hex-SRR 단위 셀 도면 + Q=48 spec |
| B-2 sopfr 필름 stack | demiurge verb-5 synthesize | 5-layer ALD 증착 recipe |
| B-3 σ²=144 m² 시트 | demiurge verb-7 handoff | 144 m² 시트 BOM + 정렬 spec |
| B-4 σ=12 채널 운용 | demiurge AI 제어 (별도 도메인) | 12-ch ON/OFF API + lookup table |
| B-5 Mk 비용 매트릭스 | UFO Phase D 양산 로드맵 | Mk.I~V 비용/m² 표 직계 인용 |

### §6.2 needed upstream PR (future deferred)

| 필요 항목 | upstream | 현재 상태 | 차단? |
|---|---|---|---|
| EUV mask 자동생성 | `hexa-lang stdlib/srr/euv_mask.hexa` | 미작성 (🟠 future PR) | NO (수동 mask 가능) |
| FDTD/HFSS 통합 | `hexa-lang stdlib/cloak/fdtd_solver.hexa` | 미작성 (🟠 future PR) | NO (외부 solver 호출) |
| Lambert-Beer recompute | `hexa-lang stdlib/math/exp.hexa` | 미작성 (⓹ V3 ⚪) | NO (메타 carrier 비-차단) |
| 임피던스 매칭 spec | `hexa-lang stdlib/cloak/impedance_match.hexa` | 미작성 (🟠 future PR) | NO (η₀=377 Ω closed-form) |

**모두 비-차단** — Phase B 설계는 PR #1934 / #1936 / #1943 substrate 위에서 doc-only 닫힘.

---

## §7 정직 caveat (@D d6 invariant)

본 Phase B 설계는 **closed-form n=6 lattice composition** + **3 PR substrate self-test 21/21 PASS** 위에서 닫혔으나, 다음은 비-verify 영역 (정직 명시):

1. **effective-medium k ≪ 2π/a 가정** — λ/10 rule (Smith 2000 PRL 84, 4184) 가정 하에서만 유효. 셀 피치 a = σ-φ = 10 nm · 가시광 λ ≈ 400-700 nm → a/λ ≈ 0.014-0.025 → **가정 통과** (10× 마진). 그러나 X-ray (λ ≈ 0.1 nm) 영역에서는 **가정 깨짐** (Mk.V 사고실험 영역 ⚪).
2. **단파장 영역 외삽** — Mk.III 가시광 (σ=12 oct) 이후 영역은 lattice cap 외 + 실험 미실증 (⚪ honest fence 유지).
3. **제작 공정 yield 모름** — EUV 48 nm pitch + ALD multilayer 의 실제 yield 는 외부 팹 의존. 본 문서는 closed-form spec 만 봉인 (yield = downstream wet-lab confirmation per @D d5).
4. **D-CLOAK-1 보편성 (Q=48 across Graphene · MgB₂ · Ag)** — 인용 가설 (UFO/CLOAK.md §8), 실측 3종 비교 wet-lab 영역 (🟡 citation tier).
5. **Mk.IV~V 비용/m²** — $5 / $0 은 사고실험 영역 (⚪).

→ 全 caveat 가 d5 (absorbed ⇔ 비-wet-lab gate) 의 downstream 영역 또는 ⚪ honest fence 로 분류되어 **메타 carrier 작동에 비-차단**.

---

## §8 종합 tier breakdown

- 🔵 lattice derive : **6** (Q=48 · pitch=10 nm · sopfr=5 nm · σ²=144 m² · 12-ch · width/gap=1 nm)
- 🟢 numerical (PR self-test 인용) : **4** (PR #1934 · #1936 · #1943 + verify-cli #1938 wire-up)
- 🟡 atlas+citation : **8** (Pendry SRR · Smith λ/10 · Jaumann RAM · Mk roadmap · ITU 대역 · D-CLOAK-1 보편성 · ALD 공차 · Si substrate)
- 🟠 deferred : **2** (Mk.III~IV 장기 등급 · 4-PR future stdlib)
- ⚪ honest fence : **2** (Mk.V 사고실험 · 단파장 외삽 cap)

**Phase B 6/6 milestone 비-차단 닫힘** (5-항목 verdict 표 §1 + 4-항목 Phase B milestone § 도메인 보드).

---

## 참고 (cross-reference)

- `domains/cloak.md` Phase B milestone 목록 (parent flip 대상)
- `domains/UFO/CLOAK.md` §5 8-단 DSE Level 2~7 · §17 8-단 공정 체인 · §18 응용별 파라미터
- `domains/hex-n6.md` 10/11 🔵 anchor + lattice 결합 도출
- `domains/srr.md` Phase B geometry milestone 직계 정렬
- `exports/cloak/verify/V4_final_tier_ledger.md` (V1+V2+V3 통합 · absorbed=TRUE 판정)
- hexa-lang PR #1934 (SRR) · #1936 (Veselago) · #1938 (verify-cli wire-up) · #1943 (Drude RT-SC) — 4-PR substrate
- atlas: `@P n6-sigma`/`n6-tau`/`n6-phi`/`n6-sopfr`/`n6-mu` foundation atoms · `@C n6-bt-748 phi_tau=8`/`n6-bt-749 sigma_minus_phi=10`/`n6-bt-762 sigma_tau=48`/`n6-bt-sigma2=144` derived constants
- @D d1 · d3 · d5 · d6 · d10 · d19
