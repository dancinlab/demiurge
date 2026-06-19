# QFORGE=QE parity — Lane "qe-parity-impl" R1 — CaH6 1:1 matched-σ 구현

Lane R1 (perpetual·fire-on-arrival). 목표: from-scratch |g|² gap을 QE 동등(≤1%)까지. 최우선 레버 =
**CaH6 1:1 matched-σ 완성** — QFORGE el-ph에 QE와 동일한 Gaussian double-δ σ를 명시 노출해,
answer-key의 "effective σ≈0.0206 Ry 투영"을 진짜 1:1 matched-σ로 승격, −1.35%가 물리잔차인지
σ-투영 artifact인지 확정.

## ⭐ 핵심 발견 (정직·d6): matched-σ서 "−1.35%"는 **물리잔차도 σ-투영 artifact도 아니었다**.
## prior 4.137은 비물리적으로 넓은 σ_el=0.05 Ha(=0.14 Ry-equiv)이 만든 artifact. 진짜 matched-σ서 λ→0.

answer-key가 못 본 진짜 implementation gap이 두 개였다:

### gap-1 — Gaussian convention 정의차 (구현·검증 완료)
- QFORGE `qforge_gaussian_delta(x,σ)` = `exp(−x²/2σ²)/(σ√2π)`  (variance σ²)
- QE per-δ (`elphon.f90:1058-1062`) = `exp(−x²/d²)/(d√π)`  (variance d²/2)
  - QE product double-δ = `exp(−((Ef−εk)²+(Ef−εk+q)²)/d²)/d²/π` → 두 δ의 곱 ((√π)²=π)
- 두 normalized Gaussian은 **σ² = d²/2 일 때 비트단위 동일** → `σ_QFORGE = degauss_QE / √2` (같은 단위).
  degauss는 Ry, σ는 Ha → `σ_el_Ha = qforge_qe_degauss_to_sigma(degauss_Ry · 0.5)`.
- 검증 `qforge_qe_sigma_convention_test.hexa`: degauss 7칸 × x 6점에서
  `qforge_gaussian_delta(x,d/√2) == QE δ(x;d)` **rel-ε ≤ 1e-12 (EXACT)**, 역브리지 round-trip ≤1e-12.
  PASS. (convention_test.txt)
- matched-σ 테이블: QE 0.015 Ry→σ_el 0.0053033 Ha · 0.020→0.0070711 · 0.025→0.0088388 Ha.

### gap-2 — el-ph FS double-δ σ_el이 코드에 frozen돼 있었다 (이게 진짜 R1 lever)
`pw_frontend.hexa`의 Einstein-default deck이 `sigma_el: 0.05` Ha를 **하드코딩**, phonons 엔트리가
이걸 노출 안 해 모든 full-BZ 런이 σ_el=0.05 Ha에 묶여 있었다. σ_el=0.05 Ha를 역브리지하면
**QE degauss=0.0707 Ha=0.1414 Ry** — QE 사다리(0.005~0.050 Ry)보다 ~7배 넓다. 즉 prior 4.137은
QE의 어떤 칸보다도 훨씬 넓은 broadening의 값. answer-key가 "QE 곡선 σ≈0.0206 Ry 칸에 앉는다"고 읽은
건 **넓은-σ QFORGE를 좁은-σ QE 값에 투영**한 것 — 두 값은 애초에 matched-σ가 아니었다.

## sanity (npw_cap=200·nq=2 — basis-truncated, NOT the 4.137 baseline)

| σ_el (Ha) | ⇔ QE degauss (Ry) | vertex | Σ|g|² | QFORGE λ |
|---|---|---|---|---|
| 0.00707 (matched 0.020 Ry) | 0.0200 | SCREENED | (유한) | 4.11e-44 |
| 0.00707 (matched 0.020 Ry) | 0.0200 | BARE | 3.40273 | 4.11e-44 |
| 0.03 | 0.0849 | BARE | (유한) | 2.29e-45 |
| 0.05 (legacy default) | 0.1414 | BARE | (유한) | **8.23e-46** |

- ⚠ **sanity는 결론 불가**: npw_cap=200(truncated basis) nq=2서는 **레거시 σ=0.05도 λ=8.2e-46≈0** —
  즉 4.137을 재현하지 못한다(4.137은 npw_cap=0 n=645 nq=4 full-shell 전용). σ-붕괴를 sanity서 단정할 수
  없음. matched-σ 판정은 **production n=645 nq=4**서만 정직(아래 RESULTS, 진행중).
- 다만 sanity가 보여준 것: `[elph] Σ|g|²=3.40`은 유한인데 `[a2f] λ`가 붕괴 = **FS double-δ가 λ를 지배**
  (|g|² 정상). 원인(파일:라인): `qforge_run.hexa:240-243` 점유밴드 nn마다 `eps_k=eps_kq=eps_occ[nn]`,
  `e_fermi=eps_occ[nocc-1]`(HOMO) → 좁은 basis서 E_F 근처 상태 희박 → δ(εnn−Ef)² 소멸.

## RESULTS — production (npw_cap=0·n=645·nq=4·BARE — the real 4.137 config) ★확정

**모든 런 동일 converged SCF/DFPT** (n=645·nocc=8·iters=17·**Σ|g|²=3.69554 4런 전부 동일**) — σ_el만 바뀜.
캡처: `prod_n645_{legacy,s015,s020,s025}.txt`.

| σ_el (Ha) | ⇔ QE degauss (Ry) | QE 4×4×4 ref λ | Σ\|g\|² | QFORGE λ | 판정 |
|---|---|---|---|---|---|
| 0.05 (legacy default) | 0.1414 (off-ladder) | — | 3.69554 | **4.13658** | #2768(4.13647) 비트재현 ✅ |
| 0.00530 (matched 0.015 Ry) | 0.015 | 4.376 | 3.69554 | **5.29e-30** | 🧱 붕괴 |
| 0.00707 (matched 0.020 Ry) | 0.020 | 4.193 | 3.69554 | **2.98e-30** | 🧱 붕괴 |
| 0.00884 (matched 0.025 Ry) | 0.025 | 3.717 | 3.69554 | **1.90e-30** | 🧱 붕괴 |

- ★ legacy n=645 = **4.13658 = #2768(4.13647) 비트재현** → production config 정합·basis 충분 확정.
- ★ matched-σ 3칸 전부 **Σ|g|²=3.69554는 legacy와 동일**(|g|² 정상)인데 **λ ~ 10⁻³⁰로 붕괴**.
  → λ 붕괴는 |g|²도 basis-truncation도 아닌 **순수 FS double-δ broadening 효과**임 확정(n=645 full-shell).
- λ가 σ에 ×10²⁹ 민감 = 물리적 Fermi-surface면 불가능. 이게 deck 결함의 **직접 정량 증거**.

## 판정 (정직·d6) ★확정
- ✅ **구현 완료·검증**: convention bridge(≤1e-12 EXACT) + explicit σ_el 노출(was frozen 0.05 Ha) =
  R1 lever 박제. PR#3658. 이제 QFORGE el-ph를 QE와 **동일 Gaussian σ로 1:1** 평가 가능.
- 🧱 **"−1.35% matched-σ"는 성립 안 함 — answer-key의 −1.35%는 mis-matched 비교였다(확정).**
  prior 4.137은 σ_el=0.05 Ha = **QE degauss 0.14 Ry-equiv**(QE 사다리 0.005~0.050 Ry보다 ~7배 넓음).
  answer-key가 "QFORGE가 QE 곡선 σ≈0.0206 Ry 칸에 앉는다 → −1.35%"로 읽은 건 **넓은-σ QFORGE를
  좁은-σ QE에 투영**한 것. 진짜 σ를 맞추면 QFORGE from-scratch λ는 QE 4.376 근처가 아니라 **0으로 붕괴**.
  −1.35%는 물리잔차도, σ-투영 후 잔차도 아니고, "거의 동등"이라는 인상 자체가 **σ artifact**였음을
  코드+실측으로 박제(c23 정답지-보지-않기: 넓은 σ로 4.376 근처를 "맞춘" 듯 보였던 것을 해체).
- 🧱 **진짜 벽 = deck의 Fermi-surface 구성**(차폐 closed-neg과 별개·더 앞단). 원인(파일:라인):
  `qforge_run.hexa:240-243`이 점유밴드 nn마다 `eps_k=eps_kq=eps_occ[nn]`, `e_fermi=eps_occ[nocc-1]`(HOMO).
  좁은(물리적) σ서 δ(εnn−Ef)²는 HOMO만 유의, 깊은 점유밴드(넓은 σ서 4.137을 채우던 비물리 기여)가 죽어
  λ→0. 즉 이 deck엔 **진짜 금속 E_F 교차 샘플(k×q mesh 위 ε_k 분포)이 없다** — 단일 on-shell Einstein형.
  4.137은 그 결함을 넓은 σ로 가린 값.

## PR (dancinlab/hexa-lang)
- **#3658** `feat(qforge): expose explicit QE-matched el-ph Gaussian σ` — pushed·생성.
  dev-clone selftest PASS(≤1e-12). 기존 콜러 무영향(σ_el≤0=레거시 0.05 Ha).

## 코드 변경 (dancinlab/hexa-lang main · explicit · no force · c2 selftest)
- `stdlib/qforge/elph.hexa` — `qforge_qe_degauss_to_sigma(d)`(=d/√2)·`qforge_sigma_to_qe_degauss(σ)`(=σ√2) 브리지 + 정의차 docstring.
- `stdlib/qforge/pw_frontend.hexa` — explicit-σ 엔트리 `qforge_pw_frontend_phonons_scr_sig(..., sigma_el_ha)` 노출(≤0=레거시 0.05 Ha 유지·기존 콜러 무영향); 헬퍼 `_qpwd_deck_with_sigma_el`; 기존 `_phonons`/`_phonons_scr`는 thin default.
- `stdlib/qforge/fixtures/cah6_fullbz_xval.hexa` — arg8=σ_el(Ha); matched-σ면 QE 4×4×4 λ(σ) 사다리 같은 칸과 대조(tight 4.376 강제 아님).
- `stdlib/qforge/qforge_qe_sigma_convention_test.hexa`(신규) — convention 게이트 selftest (≤1e-12).

## fire-on-arrival 다음 라운드 (R2)
matched-σ가 ✅ 아니라 🧱(더 앞단 FS-deck 결함)이므로 → named 레버 1개:
**진짜 metallic FS 샘플링** = qforge_run의 el-ph 샘플 스트림을 단일-Γ on-shell(eps_k=eps_kq=eps_occ)에서
**실 k-mesh 밴드구조 위 ε_k 분포**(k-grid × q-grid, 진짜 E_F 교차)로 교체. 이게 from-scratch λ가 σ에
물리적으로 둔감해지는 전제. (d_novel_only: 이미 닫힌 차폐 Broyden 재발사 금지 — 이번 발견은 차폐와
무관한 새 결함이라 별개 레인.) depletion test: FS-deck 교체 후 matched-σ λ(σ)가 QE 사다리와 평행하면 ✅,
여전히 붕괴/발산이면 정직 🧱 박제 후 종결.

## depletion test (fleet 프로토콜)
- R1 레버(CaH6 1:1 matched-σ)는 **소진됨** — convention bridge 구현+검증 완료, matched-σ 실측 완료,
  판정 확정(🧱: −1.35%는 mis-matched artifact였고 진짜 벽은 FS-deck). 이 레버서 더 짜낼 것 없음.
- 다음 레버(R2 = metallic FS 샘플링)는 **새 코드 영역**(qforge_run el-ph 샘플 스트림 재설계) — R1과
  독립. fire-on-arrival로 별개 라운드 발사 가능.
- d_novel_only: 차폐 Broyden/ALDA-floor/exact-Woodbury(이미 CLOSED-NEGATIVE 9 path)는 재발사 금지.
  이번 발견은 그 9 path와 **다른 축**(broadening×FS-sampling)이라 신규 — R2는 정당한 NOVEL 레인.
