🛠️ NOVEL-TOOL — "새 도구 발굴" · NOVEL primitive 발견 + verify schema

# NOVEL-TOOL — current state

@goal: NOVEL급 cross-check tool / stdlib-promotable primitive / atlas-foldable verifier 의 지속 발굴·구현·흡수 — Wheeler · n=6 · hexa-rtsc 어댑터 가족 확장 + width-first ideation · 발견→stdlib 캐노니컬화→topical thin wrapper→atlas 등록 파이프라인

## NOVEL-VERIFIER 스키마 (epistemic foundation)

### Pre-falsifier (NOVEL grade 박탈 조건)

다음 둘 중 하나라도 충족하면 NOVEL ✗:

1. **이미 hexa stdlib 에 있음** — `find ~/core/hexa-lang/stdlib -iname "*<slug>*"` 또는 `grep -r "<symbol>" stdlib/` 양성 결과.
2. **scipy 단독 1줄 trivial** — `from scipy.<sub> import <fn>; <fn>(x)` 한 줄로 끝나고, 정확도/안정성 함정이 명문화 가능한 수준이 아님.

### Brainstorm output triad (모든 후보에 강제)

```yaml
candidate: <slug>
claim:       <한 줄 NOVEL primitive 설명>
proof:       llm-prior | arxiv:<DOI> | textbook:<ref> | cross-source
severity:    low | medium | high     # 캠페인에 미치는 영향
as_of_date:  YYYY-MM-DD              # 판정 시점 (scipy 업데이트로 rot 추적)
scipy_grep:  found | not_found       # `pip show scipy && python -c "import scipy.<sub>" -> grep`
stdlib_grep: found | not_found       # `find ~/core/hexa-lang/stdlib -iname "<slug>*"`
arxiv_ref:   <DOI or null>
```

### 적용 시점

- M2/M3 brainstorm round 2 부터 모든 후보에 triad 부착 강제.
- 기존 round 1 결과 (M2 6개 + M3 6개 후보) 는 round 1 done 으로 인정하되, round 2 진입 전에 retroactive triad fill-in (별도 cycle).

## Milestones

- [x] Wheeler primitive stdlib promotion — hexa-lang/stdlib/material/magnet/wheeler.hexa 신규 + demiurge/RTSC/magnet/getdp/wheeler_axis_b.hexa thin wrapper refactor · per @D d3 + g61
- [x] /brainstorm depletion sweep — magnetostatics closed-form primitive 후보 · seed: Wheeler 외 stdlib-promotable 자기학 공식 — Helmholtz coil B, off-axis Bz expansion, Biot-Savart current-loop, finite-wire segment, mutual inductance closed-form, end-leakage correction, thick-coil Snow form, multi-layer envelope
- [x] /brainstorm depletion sweep — cross-domain general primitive 후보 · seed: signal · stats · info-theory · bitops · numerics — Welford running-stats, Kahan-Babuska summation, log-sum-exp, Newton-Raphson 가족, GCD/LCM, popcount/bit-reverse, Cooley-Tukey radix-N FFT, KL divergence, Jensen-Shannon, Wasserstein 1-D, Welch power-spectrum, autocorr/cross-corr
- [x] elliptic_K_E AGM stdlib 신규 — hexa-lang/stdlib/math/special/elliptic.hexa · pre-req unblocks mutual_M and loop_offaxis and A_phi cascade · arithmetic-geometric mean iteration
- [x] NOVEL-VERIFIER schema 명문화 — NOVEL-TOOL.md goal 아래에 pre-falsifier 둘 명시 + brainstorm output triad claim·proof·severity·as_of_date·scipy_grep·stdlib_grep·arxiv_ref 강제
- [x] solenoid_endleakage_calibrator libm-only — hexa-lang/stdlib/material/magnet/solenoid_endleakage.hexa · ratio = atan-only closed-form · Wheeler 보정 calibrator · atlas ⚪→🟢 빠른 승급
- [x] M2.1 mutual_M_coaxial_loops — hexa-lang/stdlib/material/magnet/mutual_M_coaxial.hexa · Maxwell elliptic K,E form · Wheeler self-L 의 mutual 자매 · elliptic 의존 unblocked
- [x] M2.4 current_loop_offaxis_B — hexa-lang/stdlib/material/magnet/current_loop_offaxis.hexa · 임의점 elliptic K,E full form · 모든 coil family Green fn building block
- [x] m3e-ks2 KS two-sample — hexa-lang/stdlib/stats/ks_two_sample.hexa · sorted CDF sup-Δ + Kolmogorov tail p-value · distribution-free 비교 primitive
- [x] RTSC stability↔coupling wall 정량자 (2개) — hexa-lang/stdlib/material/sim.hexa §4k `lambda_anharm_suppress(⟨ω²⟩h,Δω²)=⟨ω²⟩h/(⟨ω²⟩h+Δω²)` (anharmonic λ-suppression ratio) + §4l `stability_coupling_margin(⟨ω²⟩a,⟨ω²⟩λ)=(a−λ)/a` (escape m>0 / trapped m<0) · McMillan-Hopfield λ=η/(M⟨ω²⟩) 의 ⟨ω²⟩ 이중역할(λ분모 ∧ 안정성판별) 닫힌형태화 · verify_cli mirror + 🟢 SUPPORTED-NUMERICAL (h3o S=0.4034 · CaH₆ m=0.5 · h3o m=−1.479) · pre-falsifier 통과 (scipy/stdlib not_found) · RTSC/verify/V5_stability_coupling_wall.md · per @D d3 + g61 + d18 NOVEL
