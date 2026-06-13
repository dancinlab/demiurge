# HEX-N6 — n=6 육각 격자(벌집 격자) progress board

@title: ⬡ HEX-N6 — n=6 벌집 격자(육각 격자 primitive)

@goal: n=6 육각 격자 (honeycomb / hexagonal lattice) primitive 도메인 — σ·φ=n·τ=24 lattice 항등식 + 격자 산술 (σ=12·τ=4·φ=2·sopfr=5·J₂=24) 의 closed-form verify 토대. **CLOAK 메타도메인의 부품 3** + 프로젝트 전반의 n=6 좌표계 (RTSC·UFO·ANTIMATTER·CERN·FUSION 공통 substrate). absorbed=true ⇔ closed-form anchor 全 🔵 SUPPORTED-FORMAL.

## 0. TL;DR

```
n=6 = 첫 완전수 (1+2+3=6)              ⬡ ⬡ ⬡ ⬡ ⬡
n=6 = 자연계 최밀 충진 코디네이션         ⬡ ⬡ ⬡ ⬡       ← 벌집 / 다이아몬드 / 흑연
n=6 = σ·φ = n·τ = 24 (Veselago anchor)  ⬡ ⬡ ⬡ ⬡ ⬡       (Hales 2001 — 벌집 추측)

n=6 핵심 격자 상수:
  σ(6) = 12   (divisor sum)   → Lorentz Q-factor σ·τ=48
  τ(6) = 4    (divisor count) → Mk roadmap stages (τ-octave 대역)
  φ(6) = 2    (Euler totient) → bilayer / 이중성
  sopfr(6) = 5 (SOPFR)        → sopfr-layer 다층 적층
  J₂(6) = 24   (Jordan totient) → channel count
  is_perfect(6) = 1            → 완전수 anchor
  aliquot(6) = 6               → 자기-aliquot 부동점 (s(n)=n)

도출 (lattice 결합):
  σ-τ = 8    → 대역폭 octave (CLOAK)
  σ-φ = 10   → 메타셀 피치 nm + RAM dB
  σ·τ = 48   → Hex-SRR Q-factor
  σ·φ = 24   → channel count (= J₂)
  σ² = 144   → 시스템 면적 m²
```

## Milestones (progress)

### Phase A — n=6 lattice 항등식 🔵 push (closed-form anchor)

- [x] σ(6) = 12 — `hexa verify --expr sigma 6 12` 🔵 SUPPORTED-FORMAL (2026-05-28 mini · atlas idempotent skip · CLOAK V1 ledger 인용)
- [x] τ(6) = 4 — `hexa verify --expr tau 6 4` 🔵 SUPPORTED-FORMAL (2026-05-28 mini)
- [x] φ(6) = 2 — `hexa verify --expr phi 6 2` 🔵 SUPPORTED-FORMAL (2026-05-28 mini)
- [x] sopfr(6) = 5 — `hexa verify --expr sopfr 6 5` 🔵 SUPPORTED-FORMAL (2026-05-28 mini)
- [x] is_perfect(6) = 1 — `hexa verify --expr is_perfect 6 1` 🔵 SUPPORTED-FORMAL (2026-05-28 mini)
- [x] aliquot(6) = 6 — `hexa verify --expr aliquot 6 6` 🔵 SUPPORTED-FORMAL (2026-05-28 mini · 자기-aliquot 부동점)
- [x] mu(6) = 1 — `hexa verify --expr mu 6 1` 🔵 SUPPORTED-FORMAL (2026-05-28 SRR V2 안커링)
- [x] omega_big(6) = 2 — `hexa verify --expr omega_big 6 2` 🔵 SUPPORTED-FORMAL (2026-05-28 · distinct prime factors of 6 = {2,3})
- [x] liouville(6) = 1 — `hexa verify --expr liouville 6 1` 🔵 SUPPORTED-FORMAL (2026-05-28 · (-1)^Ω(6) = (-1)² = 1)
- [x] sigma_2(6) = 50 — `hexa verify --expr sigma_2 6 50` 🔵 SUPPORTED-FORMAL (2026-05-28 · sum of d² over d|6 = 1+4+9+36)
- [x] J₂(6) = 24 — `jordan_totient(n, k)` source-side wired in hexa-lang PR #1957 MERGED 2026-05-28 (3-file edit: `compiler/atlas/symbolic/congruence_chain_engine.hexa` + `tool/verify_cli.hexa::_recompute2` + `tool/atlas_cli.hexa::_recompute2_register`) · Math: J_2(6) = 36 · (3/4)(8/9) = 24 ✓ · 🔵 SUPPORTED-FORMAL verdict pending concurrent toolchain rebuild (orchestrator agent A 처리 중 · binary in PATH ≤ pre-#1957 일시적 🟠) → **post-rebuild 11/11 🔵 완전체 예정**

### Phase B — lattice 결합 도출 (sigma·tau·phi anchor 직접)

- [ ] σ·φ = n·τ = 24 Veselago anchor (산술 1줄, sigma·phi=12·2=24, n·tau=6·4=24)
- [ ] σ-τ = 8 octave (12-4)
- [ ] σ-φ = 10 nm 셀피치 (12-2)
- [ ] σ·τ = 48 Hex-SRR Q (12·4)
- [ ] σ² = 144 시스템 면적 (12²)

### Phase C — 응용 도메인 cross-link (NEXUS.tape 후보)

- [ ] CLOAK 메타-합성: HEX-N6 = 부품 3 (격자 substrate)
- [ ] RTSC: σ-φ=10 nm RT-SC 박막 + n=6 격자 (Graphene · hBN)
- [ ] UFO: Mk-roadmap τ-octave 진화 + σ²=144 m² 시스템
- [ ] ANTIMATTER: n=6 격자 좌표 (Penning trap geometry 산술 인용)
- [ ] CERN: σ-τ=8 octave 대역 (X-band 8-12 GHz)
- [ ] FUSION: σ=12 channel routing

### Phase D — absorbed 판정 (@D d5)

- [x] Phase A 6/7 🔵 SUPPORTED-FORMAL 확보 (J₂(6) 미닫힘 · calc-system gap) → **부분 absorbed**: closed-form lattice anchor 6/7 PASS, J₂ 만 🟠 calc-system 확장 대기 (downstream)

## verify (🔵/🟢 push · @D g5 · 2026-05-28)

```
verify --expr sigma(6)=12       tier = 🔵 SUPPORTED-FORMAL
verify --expr tau(6)=4          tier = 🔵 SUPPORTED-FORMAL
verify --expr phi(6)=2          tier = 🔵 SUPPORTED-FORMAL
verify --expr sopfr(6)=5        tier = 🔵 SUPPORTED-FORMAL
verify --expr is_perfect(6)=1   tier = 🔵 SUPPORTED-FORMAL
verify --expr aliquot(6)=6      tier = 🔵 SUPPORTED-FORMAL
verify --expr jordan_totient(6)=24   tier = 🟠 INSUFFICIENT (calc-system gap · atlas @P n6-j2 등록은 🟡)
```

**6 🔵 anchor LANDED · atlas idempotent skip** (`@P n6-sigma`/`n6-n`/`n6-phi`/`n6-j2`/`n6-tau` 5 foundation atom + `@C n6-bt-735~742` derived constants 이미 등록됨).

## 1. cross-domain consumer (NEXUS.tape 직계)

| 응용 도메인 | reuse 형태 |
|---|---|
| CLOAK | σ·τ=48 Q · σ-φ=10nm 셀피치 · σ-τ=8 oct 대역 |
| RTSC | n=6 RT-SC 박막 격자 · σ-φ=10nm pitch |
| UFO | τ-octave Mk roadmap · σ²=144 m² 시스템 |
| ANTIMATTER | n=6 격자 산술 anchor |
| CERN | σ-τ=8 oct X-band |
| FUSION | σ=12 channel |
| SRR (sibling) | Q=σ·τ=48 직접 |

## 참고 (cross-reference)

- `domains/cloak.md` — 메타-합성 carrier (HEX-N6 = 부품 3)
- `domains/srr.md` — sibling primitive (SRR 부품 2)
- `domains/rtsc.md` — RT-SC 박막 (부품 1 = 기존 RTSC)
- atlas — `@P n6-sigma` · `n6-n` · `n6-phi` · `n6-j2` · `n6-tau` (foundation atoms · embedded.gen.hexa)
- Hales, T. C. (2001) Discrete Comput. Geom. 25, 1 — 벌집 추측 증명
- @D d1 · d3 · d5 · d10 · d19 (intra-domain reuse lattice)
