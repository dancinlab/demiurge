# CLOAK — V1 claim inventory + tier triage

**date**: 2026-05-28 KST
**source**: `domains/UFO/CLOAK.md` (~990 lines · Mk.I~V 로드맵 + H-CLK-1~12 가설 + D-CLOAK-1~3 discovery + TP-CLOAK-1~7 testable predictions + 13 BT 링크)
**governance**: @D d1·d3·d5·d10·d19 · @D g0·g3·g5 (rubric `hexa verify rubric`)
**scope**: 전자기 스텔스 망토(투명망토) — 음굴절률(n<0) 메타물질 n=6 육각 격자

## 0. tier verdict 집계

| tier | 항목 수 | 비고 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 3 | n=6 lattice 항등식 (`hexa verify --expr` 2026-05-28 verbatim) |
| 🟢 SUPPORTED-NUMERICAL | 0 | hexa-native libm/Newton 재현 — V3 라운드 대기 (atlas plasma/lorentz/veselago 미등록) |
| 🟡 SUPPORTED-BY-CITATION | 6 | Pendry 2006 · Veselago 1968 · Smith 2000 · F-22/B-2/F-117 공개 제원 · X-band 표준 |
| 🟠 INSUFFICIENT/DEFERRED | 7 | sim 본해 미수렴 · 외부 측정 oracle 의존 |
| ⚪ SPECULATION-FENCED | 3 | Mk.IV~V 사고실험 · 양자스케일 셀 (UNPROVEN) |
| **합계** | **19** | H-CLK-1~12 (12) + D-CLOAK-1~3 (3) + TP-CLOAK-1~7 (7 — 일부 H-CLK 와 중복 카운트 제외 → 4 신규) — 도합 19 |

## 1. 🔵 SUPPORTED-FORMAL (closed-form identity, 2026-05-28 verbatim)

> ⚠ `hexa verify` mini-host verdict 그대로 인용. 추가 lattice 도출 (σ-τ=8 · σ·τ=48 · σ·φ=n·τ=24 · σ-φ=10) 는 아래 3 atom 의 직접 결과.

```
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
  absorb = · already in atlas — idempotent skip (default · @D g69)

verify --expr tau(6)=4
  calc   = 4  == expected 4
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
  absorb = · already in atlas — idempotent skip (default · @D g69)

verify --expr phi(6)=2
  calc   = 2  == expected 2
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
  absorb = · already in atlas — idempotent skip (default · @D g69)
```

이 3 atom 으로부터 closed-form 도출되는 CLOAK 핵심 lattice 상수:

| 도출 상수 | 값 | 정의 | CLOAK 역할 |
|---|---|---|---|
| σ·τ | 48 | 12·4 | Hex-SRR 공명 Q-factor |
| σ-τ | 8 | 12-4 | 투명 대역폭 (octave) |
| σ-φ | 10 | 12-2 | 메타셀 피치 (nm) · RAM 흡수율 dB |
| σ·φ = n·τ | 24 | 12·2 = 6·4 | n=6 핵심 항등식 (Veselago lattice consistency) |
| J₂ | 24 | Jordan totient | 다층 적층 채널 수 |

## 2. 🟡 SUPPORTED-BY-CITATION (atlas/literature 등록 · hexa recompute 없음)

| # | 가설 | 출처 | 정직 caveat |
|---|---|---|---|
| H-CLK-1 | B-2 날개폭 172 ft ≈ σ²+J₂+τ = 172 | USAF 공개 제원 | 산술 일치만 — 물리 인과 미증명 |
| H-CLK-2 | F-22 RCS ≈ 10⁻⁴ m² = 10^(-τ) | 비밀 추정치 (RAND 공개 보고서) | 추정치 자체가 ±1 자릿수 |
| H-CLK-4 | X-band 8-12 GHz = σ-τ ~ σ | IEEE 표준 IEEE 521-2002 | 표준 정의이지 발견 아님 |
| H-CLK-6 | 메타물질 셀 λ/10 = λ/(σ-φ) | Smith et al. 2000 PRL 84, 4184 | 교과서 표준 — 발견 아님 |
| H-CLK-9 | RAM 흡수율 10 dB = σ-φ | 군용 RAM 설계 기준 | 산업 표준 |
| H-CLK-12 | 스텔스 6대 설계 원칙 = n | 공학 분류 컨벤션 | 분류 자체 임의성 존재 |

## 3. 🟠 INSUFFICIENT/DEFERRED (calc 경로 없음 · 외부 측정 oracle 필요)

| # | 가설 | 차단 사유 | 해결 경로 |
|---|---|---|---|
| H-CLK-3 | RAM 코팅 층수 n/φ=3 ~ sopfr=5층 | "전형값" 정의 모호 — 무엇이 layer 단위인가 | 구체 RAM 스택 1 case 사양 fix 후 재정의 |
| H-CLK-5 | F-22 내부 무장창 3개 | 공학 분류 · CLOAK 도메인 핵심 아님 | scope 외 — UFO/aerospace 도메인 |
| H-CLK-7 | IR 대기창 3개 (SWIR/MWIR/LWIR) | 분광학 사실이나 n=6 인과 미증명 | 산술 일치 → 🟡 강등 검토 |
| H-CLK-8 | B-2 엔진 4기 = τ | 공학 분류 · 산술 일치만 | 산술 일치 → 🟡 강등 검토 |
| H-CLK-10 | F-117 평면 ~72 = σ·n (CLOSE) | "CLOSE" 60-80 추정 → 정확값 미확정 | 정확 평면 카운트 oracle 필요 |
| H-CLK-11 | 스텔스 4세대 시작 = τ | 세대 분류 컨벤션 임의성 | 분류 정의 fix 후 재평가 |
| Mk.III~V 로드맵 | $50/m² · 양자스케일 셀 | 미래 양산 시나리오 — 측정 oracle 부재 | 시간 경과 + downstream 측정 |

## 4. ⚪ SPECULATION-FENCED (UNPROVEN · 사고실험)

| # | 가설 | 정직 fence |
|---|---|---|
| Mk.V | J₂·φ=48 oct (X-ray) 투명화 | 사고실험 표시 — Mk 표 자체에 "사고실험" 명기 |
| 양자스케일 셀 | <10 nm 원자 한계 너머 | 물리 lower bound — 양자 산란 한계 10⁻¹⁰ m² 명시 |
| RT-SC 300K 가정 | 상온 초전도 달성 가정 | RTSC 도메인 의존 (RT-SC 자산 reuse · @D d19) — RTSC 자체 R4 absorbed=false |

## 5. discovery + testable predictions (D-CLOAK-1~3 + TP-CLOAK-1~7)

### D-CLOAK-1: Hex-SRR Q=σ·τ=48 보편성 → 🟡 (3종 실험 인용만)
- Graphene / MgB₂ / Ag nanowire 3종 실험 인용 — 실험 raw 데이터 미접근
- closed-form 부분 (σ·τ=48 산술) 은 §1 의 sigma·tau=12·4=48 로 🔵 anchored

### D-CLOAK-2: 음굴절 대역폭 한계 σ-τ=8 oct → 🟠
- "단일 격자 한계" 주장 — 구체 격자 클래스 정의 + 한계 정리 부재
- 산술 부분 σ-τ=12-4=8 은 🔵 도출

### D-CLOAK-3: 가시광 셀 피치 σ-φ=10 nm → 🟡
- λ/10 = 60nm/6 = 10nm — Smith 2000 의 λ/10 rule 적용
- σ-φ=12-2=10 산술은 🔵 도출 · 가시광 600 nm 정의는 표준

### TP-CLOAK-1~7: testable predictions → 측정 미실시 ⇒ 🟠 (DEFERRED · 무반향 챔버·VNA·SEM 의존)

| TP | 측정 방법 | 차단 |
|---|---|---|
| TP-CLOAK-1 | VNA 공명 폭 Q=48±10% | VNA 장비 + 시편 제작 필요 |
| TP-CLOAK-2 | 광대역 스펙트럼 8 oct | 광원 + 시편 필요 |
| TP-CLOAK-3 | 무반향 챔버 RCS 288× | 챔버 시설 필요 |
| TP-CLOAK-4 | SEM 셀 피치 10 nm | SEM + 시편 필요 |
| TP-CLOAK-5 | 광선 측정 1-1/e=63% | 광원 + 시편 필요 |
| TP-CLOAK-6 | S-파라미터 12 층 최적 | VNA + 다층 시편 |
| TP-CLOAK-7 | 바이어스 전류 10 mW/m² | 시편 + 전원 |

## 6. 다음 라운드 (V2 🔵 push · V3 🟢 push)

### V2 (🔵 push · closed-form identity)
- [ ] Veselago n_eff = -√(εμ) when ε<0 ∧ μ<0 → 부호 항등식 polynomial-degree closed-form
- [ ] Drude ε(ω) = 1 - ω_p²/(ω² + iωγ) → ω → ∞ limit 1, ω → 0 limit < 0 closed-form
- [ ] Lorentz μ(ω) = 1 + F·ω²/(ω₀² - ω² - iωΓ) → ω = ω₀ resonance Q closed-form
- [ ] 셀 피치 λ/10 effective-medium 한계 (Smith 2000 derivation)

### V3 (🟢 push · numerical recompute via libm)
- [ ] `plasma_freq_drude(n_e, m_e, ε₀)` hexa-native fn — RT-SC n_e=1e28 m⁻³ → ω_p ≈ 5.64e15 Hz
- [ ] `lorentz_resonance_q(L, C, R)` hexa-native fn — Hex-SRR Q=48 매칭
- [ ] `effective_pitch_nm(λ_nm, divisor)` hexa-native fn — 600/10=60, 600/12=50 매칭
- [ ] 의존: `stdlib/cloak/{plasma_freq.hexa, lorentz_q.hexa, effective_pitch.hexa}` 신규 작성 → atlas register --from-verify fold

### V4 (final tier ledger)
- V1+V2+V3 통합 + Mk.I~V 로드맵 + absorbed 판정 (@D d5 invariant)

## 7. 정직 caveat (g3 · d6)

- **이 V1 은 inventory · triage 만** — 새 측정/실험 없음
- **lattice 산술 일치 ≠ 물리 인과 증명** — H-CLK-1 등 "X = σ²+J₂+τ" 류는 수론 일치이지 발견 아님 (CLOAK 자체가 RTSC/UFO 와 같이 n=6 격자 산술 위에 좌표화된 도메인)
- **stdlib/cloak/ 미작성** → 모든 cell rc=2 honest-skip (cloak.demi STUB)
- **absorbed=false 영구** until V2~V3 라운드 완주 + 외부 측정 oracle (downstream)

---

artifacts (this V1):
- ledger: `exports/cloak/verify/V1_claim_inventory.md` (this file)
- 🔵 anchor: 3 atom (sigma/tau/phi at n=6) — atlas idempotent skip (이미 등록됨)
- next: V2 🔵 push (Veselago/Drude/Lorentz closed-form) + V3 🟢 push (hexa-native libm recompute, stdlib/cloak/ 신규)
