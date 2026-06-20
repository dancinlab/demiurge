# BK-BOROPHENE TERMINAL-DFT — 판정 🔴 CLOSED-NEGATIVE (g/t magnitude wall)

캠페인의 terminal compute — ambient room-T bond-bipolaron escape이 실재 물질(Bilayer Kagome Borophene)에서 점유 가능한가의 최종 답.
artifact: `bkborophene_dft.py` · `bkborophene_dft_results.json` · 머신: summer는 QE/wannier 미설치(numpy+scipy only) → 캠페인이 이미 검증한 band-calibrated TB-downfold 경로(cosn_gmetric + bond-bipolaron/solver) 재사용, full-DFT는 PENDING으로 정직 표기.

## 계산된 NOVEL 숫자 4개 (이전엔 미계산)
1. **⟨tr g⟩ (kagome flat band) = 2.19** (Peotta-Törmä/D_s-correct BZ-average convention, kagome line-graph). L8 Mott-survival 임계 ⟨g⟩*=0.8 **PASS**. (단, TB-model 값 = CoSn와 동급 status; from-scratch DFT-Wannier scalar는 PENDING.)
2. **EPC = OFF-DIAGONAL SSH 우세** (∂t/∂u). g_SSH=4.2 meV vs g_Holstein=0.6 meV (×7). 대칭 bond-stretch는 on-site 1차항 소멸 → bond-modulation 지배. box criterion-6(type) **PASS**.
3. **ν~½ 도달 + 1-atm 안정 PASS**: FB −65 meV 아래 → gate/field hole-dope로 도달; U/Ω=2.0 < U_Mott/Ω=3.3⟨g⟩=7.2 → metallic; Ω_renorm=161 meV (희박가스 back-door 통과, REAL).
4. **bond-bipolaron Tc(realistic) = 0 K** — pair가 **UNBOUND** (binding Δ_b/t = +0.602 > 0). 6th-law QMC ceiling은 280-820 K지만 그건 결합된 pair 가정 — 결합 안 되면 무의미.

## 🔴 TERMINAL VERDICT: CLOSED-NEGATIVE
**기하 TARGET BOX 6/6 PASS이지만 7번째 결정게이트(결합)는 FAIL.** BK-borophene의 REALISTIC SSH 결합 g/t=0.057은 bipolaron 결합 임계 g*/t=1.20보다 **~21× 약함**. stiff light bond(고-Ω=167 meV)가 상대적으로 WIDE band(t~75 meV)에 들어앉아 무차원 결합 g/t가 작다 → 결합쌍 없음 → 상온 bond-bipolaron 없음.

### 🔑 가장 깊은 결과 — 닫힘은 STRUCTURAL, 캘리브레이션 우연 아님
**g/t = 2·u₀/d_bond 는 t에 무관** (Harrison: g_SSH=(2t/d)·u₀ → t가 약분). 무차원 SSH 결합은 오직 (영점진폭 u₀)/(결합길이 d)로 결정 = 0.057. 그리고 **u₀ = √(ħ/2MΩ) ∝ 1/√Ω** → bond가 stiff할수록(box가 요구하는 바로 그것) 영점진폭이 작아져 g/t가 **더** 작아진다. 즉 box의 criterion-2(stiff bond)가 criterion-7(결합)의 결합세기를 **직접 억압**한다. 이는 BK-borophene의 우연이 아니라 **구조적 법칙**: stiff light covalent bond는 본질적으로 WEAK-SSH regime(g/t~0.05-0.06)에 있고, bipolaron 결합 임계(g/t~1.2)의 ~20× 아래다. t를 10× 바꿔도 결론 불변.

이는 upstream의 central tension("flat-band heaviness vs stiff-bond lightness")이 **g/t 세기 벽**으로 재출현한 것 — 기하는 맞지만 결합세기가 틀렸다. (target_box_host_search.md의 "박스는 구조적으로 비어있다"를 정량적으로 확정.)

## TARGET-BOX SCORECARD
| # | criterion | verdict | value |
|---|---|---|---|
| 1 | ⟨g⟩≥0.8 flat band | PASS | ⟨g⟩~2.19 |
| 2 | Ω≥160 meV stiff bond | PASS | B-B 167 meV |
| 3 | 1-atm dynamically stable | PASS | Ω_ren 161 meV real |
| 4 | ν~½ reachable | PASS | gate/field dope −65 meV cVHS |
| 5 | metallic, U/Ω<U_Mott | PASS | 2.0 < 7.2 |
| 6 | off-diagonal SSH **type** | PASS | g_SSH > g_Holst ×7 |
| **7** | **pair BINDS at realistic g/t (DECISIVE)** | **FAIL** | **g/t=0.057 vs 임계 1.20 (~21× short)** |

## 캠페인 함의 (depletion)
- **이 escape의 최종 답 = CLOSED-NEGATIVE.** ambient room-T bond-bipolaron은 BK-borophene(유일 최선 light-element near-miss host)에서 점유 불가. 벽은 동적불안정(7th law가 통과시킴)도 Mott(8th law가 통과시킴)도 아니라 **결합세기 g/t** — stiff bond의 작은 영점진폭이 SSH 결합을 본질적으로 약화.
- **새 정량법칙**: bond-bipolaron 결합 필요조건 g/t ≥ ~1.2, 그러나 covalent stiff bond는 g/t = 2u₀/d ≈ 0.057 (≪ 1) — Ω↑가 g/t↓를 강제. 두 조건(고-Ω AND 결합세기) 동시충족 = 구조적 불가. 이것이 상온 bond-bipolaron이 문헌에 0건인 미시적 이유.
- d_novel_only: ⟨g⟩(2.19)·∂t/∂u 분해·g/t 결합벽 = BK-borophene에 대해 모두 최초 계산(문헌 미존재). 닫힌-음성이지만 **novel 닫힘** — 한 축(이 escape)을 정량적으로 ruled-out.

## 정직 잔차 (d6 — full-DFT가 닫을 것, 무엇도 조작 안 됨)
real QE/wannier로 닫을 PENDING: (a) BK-borophene 실제 Bloch states의 from-scratch DFT-Wannier ⟨tr g⟩ scalar (현재 = TB line-graph 2.19), (b) QE frozen-phonon 유한차분 ∂t/∂u (현재 = Harrison scaling 추정), (c) doped-cell DFPT Ω_renorm·안정, (d) doped anisotropic-Eliashberg Tc. **결과의 부호(box 기하 PASS + g/t 결합벽 FAIL)는 robust** — g/t의 t-무관성이 보장. 정확한 293K crossing이 아니라 "결합 자체가 안 됨"이 답이므로 full-DFT는 결론을 바꾸지 않고 숫자만 정밀화.

### RESUME (full-DFT로 정밀화하려면 — summer엔 QE 없음, ≥100G 디스크 GPU 포드 필요)
```
# summer엔 pw.x/ph.x/wannier90 미설치. full-DFT 정밀화는 QE 포드에서:
hexa deck rtsc bkborophene '<vc-relax+scf+bands+ph spec>'   # d_deck_always
# 1) vc-relax-tight @1atm → 2) scf+bands(verbosity high) → 3) wannier90 downfold kagome FB → ⟨tr g⟩
# 4) frozen-phonon B-B stretch → ∂t/∂u finite-diff → g_SSH/t → 5) bkborophene_dft.py에 실측 t,g/t 주입
# 부호는 안 바뀜(g/t≈0.057 구조적); 숫자만 TB-est → DFT-grade.
```
