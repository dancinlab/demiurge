# 2026-05-22 — hexa atlas RTSC 데이터 채굴 (고갈)

`hexa atlas` (7448-node embedded SSOT · C/L/E/F/R/S/X/Q · ATLAS_HASH 663698a0…) 를 RTSC 증명 필요 데이터로 채굴. dist/atlas.hxc 가 비어 있어 `hexa run tool/atlas_build_hxc.hexa` 로 재생성 후 쿼리 (C 6246 · L 620 · E 10 · total 7448).

## 발견 (SC 관련 17 노드: P10 · C15 · E2)

1. **N6ARCH-DEEP-P039-ULTIMATE-SC** — n6 "Ultimate Superconductor" 통합 페이퍼 (325/325 atlas EXACT · 14 papers · papers/n6-ultimate-superconductor-integrated-paper.md 1654L). 구체 n=6 매핑:
   - Cooper pair φ=2 · Abrikosov CN=6 · BCS 비열도약 σ=12 · flux quantum Φ₀=h/(2e) denominator φ=2
   - **Tc 300K = RT-SC *target*** (측정 아님 · 목표/열망) · **Hc2 σ·τ=48T** (n=6 numerology)
2. **N6ARCH-CHIP-LADDER-L6-SC-VERIFIER** — HEXA-SC SFQ 칩 60/60 EXACT · superconductor.md 153/153
3. **SC-Cooper-pair-2, SC-Abrikosov-vortex-6, SC-Nb3Sn-A15-6Nb, SC-YBCO-metals** — 전부 σ·φ=n·τ=24 lattice numerological 매핑 (원자번호·배위수·차원과 cross-link)
4. **real_limits.\*** (21 노드 · CODATA 인용) — boltzmann k=1.381e-23 · planck ħ=1.055e-34 · c=2.998e8 · carnot · stefan-boltzmann · margolus-levitin 등 엄밀 물리 상수/한계 (LATTICE_POLICY.md)

## 핵심 결론 (honest)

- **atlas 에 measured-oracle Tc 데이터 ZERO**. Nb/MgB2/YBCO/hydride 의 실측 Tc(9.25/39/92/203K) 노드 없음 — 매칭된 것은 전부 numerological(SC-YBCO→E6 dim 78 · SC-Nb3Sn→탄소 Z6 · L1-Nb-Z41=원자번호 41).
- atlas SC 콘텐츠 = **n6 numerological/architectural 프레임워크** (Cooper/Abrikosov/BCS 를 n=6 lattice 에 매핑 + RT-SC 300K *목표*). 이는 정확히 **RTSC.md §8.8 의 hexa-rtsc n=6 claim-only 후보** 그 자체.
- 따라서 atlas 는 §8.9 5-gate 의 측정 게이트 (b)(d)(e) 를 공급 못 함 — 그러나 **(목표/numerology) ≠ (측정)** 임을 atlas provenance 로 확증 → RTSC.md §8.8 claim-only stance 강화.
- 유용 산출: real_limits CODATA 상수 (sim.hexa 상수 cross-check) + n6 RT-SC 가 target-based 임의 atlas-witnessed 증거.

## R4 보호

atlas 의 "Tc 300K" 는 *target* 노드 — absorbed=true 아님. Pattern 1 (numerology→측정 위장) 회피 명시. hexa-rtsc n=6 영구 claim-only (§8.8) 재확인.
