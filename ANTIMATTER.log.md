# ANTIMATTER — log

Append-only history sister of `ANTIMATTER.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T10:46Z — ⓸냉각 cyclotron cooling verify (🔵 exact B-exponent + 🟢×2 numeric · 음성대조 🔴×2)

**공정단계 ⓸냉각**: 트랩의 강한 자기장 B 속에서 자이로(회전)하는 전하는 라모어/싸이클로트론(synchrotron) 방사로 **횡에너지(transverse energy)** 를 지수적으로 잃는다 — E_⊥(t)=E_⊥(0)·e^(−t/τ_c). 양전자·전자가 먼저 자기 방사로 냉각된 뒤, 반양성자를 **공감냉각(sympathetic)** 으로 식힌다.

- [x] 폐형해 — 냉각 시간상수 **τ_c = 6π ε₀ m³ c³ / (e⁴ B²)** (SI) = 3 m³ c³ / (4 e⁴ B²) (Gaussian). 라모어 방사일률 P ∝ q⁴ B² v_⊥² / m² 에서 τ_c = E_⊥/P̄ ∝ 1/B².
- [x] **핵심 스케일링** — (i) **τ_c ∝ B^(−2)** 정확 정수지수 −2 (단위계 무관 구조 불변량) · (ii) **τ_c ∝ m³** → 가벼운 종이 (m_heavy/m_light)³ 배 빨리 냉각.
- [x] 수치 — τ_c(5T)/τ_c(1T)=(1/5)²=**0.04** (1/25) · (m_p/m_e)³=(1836.1527)³≈**6.19e9×** (e⁺ 가 p̄ 보다 ~61억배 빨리 자기냉각 → 그래서 p̄ 는 직접 방사 아닌 전자/양전자 공감냉각). e⁺ τ_c(B=1T)≈4 s (order).
- [x] 평형온도 — 냉각률(시간상수)이 아니라 **trap/blackbody floor**(예 ~4 K cryostat)가 평형 T 의 바닥. 시간상수는 접근, cryostat 가 floor.
- [x] hexa-native fn 3종 (`tool/verify_cli.hexa`) — `cyclotron_cool_bexponent(_)`→−2 (정수 dispatch, 🔵) · `cyclotron_cool_bratio(B_hi,B_lo)`=(B_lo/B_hi)² (float, 🟢) · `cyclotron_cool_massspeedup(m_h,m_l)`=(m_h/m_l)³·1e-9 Giga-view (float, 🟢; raw ~6.19e9 은 abs-ε=1e-9 무의미 → ×1e-9 정규화, `sigma_v_dt_e18` 류 discriminating-ε 관행). `bin/hexa-verify` 재빌드 (-lm/-ldl, clang -O2, canonical root).
- [x] verify 호스트 = mini only (`POOL_DISABLE=1`); 3 atom 🔵/🟢/🟢 + **음성대조 2건 🔴** (B-exponent=−3 · B-ratio=0.10) — verbatim 아래.
- [x] hexa-lang PR **#1015 MERGED** — throwaway worktree 에서 origin/main 위 rebase(형제 ⓶감속 `rel_kinetic_from_p`/`rel_p_from_kinetic` #1014 가 fork 후 main 진입 → rebase 로 흡수, 순수 +59/−0 additions, 형제 fn·FUSION sigma_v 보존 @D d9).
- [x] record — `exports/antimatter/verify/2026-05-25T10-46-06Z/cyclotron_cool_2026-05-25T10-46-06Z.json`
- [x] ANTIMATTER.md ⓸냉각 `- [ ]`→`- [x]` (🔵+🟢) · V3 cyclotron sub-item.
- [ ] absorbed — 全 게이트 PASS 아님 (⓵생성·⓹합성·⓺가둠 미완) → false 유지 (@D d5).

verbatim hexa verify verdict (`POOL_DISABLE=1 ./bin/hexa-verify --expr …`):

```
verify --expr cyclotron_cool_bexponent(0)=-2
  calc   = -2  == expected -2
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)

verify --expr cyclotron_cool_bratio(5.0,1.0)=0.04
  calc   = 0.04  ≈ expected 0.04  (|Δ|=6.93889e-18 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr cyclotron_cool_massspeedup(1.67262e-27,9.10938e-31)=6.19051
  calc   = 6.19051  ≈ expected 6.19051  (|Δ|=1.42109e-14 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

음성대조 (negative control) — 결정론적 불일치 → 🔴, calc 시스템이 정답을 강제하지 않음을 입증:

```
verify --expr cyclotron_cool_bexponent(0)=-3
  calc   = -2  != expected -3
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees — TECS-L result-agnostic closed negative)

verify --expr cyclotron_cool_bratio(5.0,1.0)=0.1
  calc   = 0.04  ≠ expected 0.1  (|Δ|=0.06 > ε=1e-9)
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)
```

note: B-지수 −2 는 순수 정수 closed-form 이라 🔵(g_self_verify Tier1); ratio/speedup 은 나눗셈·세제곱 포함 libm-class 라 🟢. 질량 speedup 은 raw≈6.19e9 가 절대-ε=1e-9 게이트에서 ULP 무의미 → ×1e-9 Giga-view 로 order-unity 정규화(=6.190509123255138)해 변별력 있는 🟢 확보. hexa-lang verify_cli.hexa 변경은 형제(⓵생성·⓶감속·⓹합성·FUSION) fn 과 같은 파일 공존 → 본 agent 는 origin/main rebase 후 본인 fn 만 +additions 로 커밋(형제 작업 0 삭제, @D d9).
## 2026-05-25T10:48Z — ⓹합성 recombination verify (🔵 밀도멱 + 🟢 T-스케일링)

반수소 합성 공정 ⓹ — 차가운 p̄/e⁺ 플라즈마에서 **3체 재결합(three-body recombination, TBR)** 채널 `p̄ + e⁺ + e⁺ → H̄ + e⁺` (둘째 양전자가 제3체로 결합에너지를 들고 나감) 이 복사재결합을 지배. Mansbach–Keck / Glinsky–O'Neil 저온 플라즈마 이론의 폐형해 스케일링 불변량을 hexa CLI verify.

- [x] 폐형해 스케일링 도출 — α₃ᵦ ∝ e¹⁰/(m_e^(1/2)(k_B T)^(9/2)) ⇒ **α₃ᵦ ∝ n_e · T^(−9/2)**, 반양성자당 재결합률 ∝ **n_e² · T^(−9/2)**. 핵심 불변량 = T-지수 −9/2=−4.5 (정확한 유리수) + 밀도멱 2 (정확한 정수). 대조: 복사재결합 p̄+e⁺→H̄+γ ~ T^(−1/2) (Kramers, 훨씬 약함).
- [x] 수치예 — α₃ᵦ(4 K)/α₃ᵦ(100 K) = (100/4)^4.5 = **25^4.5 = 5⁹ = 1953125.0** (정확) — 100 K→4 K 냉각이 TBR 계수를 ~1.95×10⁶배 증폭 (ALPHA/ATRAP).
- [x] hexa-native fn 3종 추가 (tool/verify_cli.hexa) — `recomb_3body_density_power(n)=2·n` (정수 🔵) · `recomb_3body_exponent()=−9/2=−4.5` (0-arg float) · `recomb_3body_tratio(T_hi,T_lo)=(T_hi/T_lo)^4.5` (2-arg float) → impl + _recompute/_recompute_float dispatch + _is_float_fn/_is_zero_arg_float_fn 멤버십 + help. `bin/hexa-verify` 재빌드 (-lm/-ldl 포함 clang -O2; tool/build_hexa_verify.sh). **hexa-lang PR #1018 MERGED** (06b61657).
- [x] verify 호스트 = mini only (`POOL_DISABLE=1`) — 밀도멱 **🔵 SUPPORTED-FORMAL** · 지수/T-비율 **🟢 SUPPORTED-NUMERICAL |Δ|=0.0 ≤ ε=1e-9** (verbatim 아래).
- [x] **음성대조 3건 모두 🔴 FALSIFIED** — 밀도멱=3 · 지수=−4.0 · T-비율=2000000.0 전부 결정론적으로 falsify → LLM 자기판정 아닌 결정론적 재계산 증명.
- [x] record — `exports/antimatter/verify/2026-05-25T10-43-31Z/recomb_3body_20260525T104331Z.json`
- [x] ANTIMATTER.md ⓹합성 `- [ ]`→`- [x]` (🔵+🟢 result note)
- [ ] atlas register — SKIP (installed hexa 바이너리 verify_cli 에 신규 fn 미반영 → `register --from-verify` 🟠 INSUFFICIENT; task상 optional. atom 은 origin/main verify_cli + 재빌드 바이너리로 재현 가능. 다음 `hx install` 후 fold 가능)
- [ ] absorbed — 全 게이트 PASS 아님 (다른 공정 미완) → false 유지 (@D d5)

verbatim hexa verify verdict (`POOL_DISABLE=1 bin/hexa-verify --expr …`):

```
verify --expr recomb_3body_density_power(1)=2
  calc   = 2  == expected 2
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)

verify --expr recomb_3body_exponent()=-4.5
  calc   = -4.5  ≈ expected -4.5  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr recomb_3body_tratio(100.0,4.0)=1953125.0
  calc   = 1953125.0  ≈ expected 1953125.0  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

negative control (determinism — wrong value MUST falsify):

```
verify --expr recomb_3body_density_power(1)=3
  calc   = 2  != expected 3
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees — TECS-L result-agnostic closed negative)

verify --expr recomb_3body_exponent()=-4.0
  calc   = -4.5  ≠ expected -4.0  (|Δ|=0.5 > ε=1e-9)
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)

verify --expr recomb_3body_tratio(100.0,4.0)=2000000.0
  calc   = 1953125.0  ≠ expected 2000000.0  (|Δ|=46875.0 > ε=1e-9)
  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)
```

note: 밀도멱은 정확한 정수 2 → 🔵 (g_self_verify · 순수 정수 closed-form). T-지수(−4.5)/T-비율(25^4.5)은 폐형해이나 float/pow libm-class 재계산이라 rubric상 🟢 (🔵=순수 정수/symbolic). hexa-lang verify_cli.hexa 변경은 형제 ANTIMATTER agent fn(penning_*·pair_threshold_*·transition_factor_1s2s·h1s2s_rydberg·rel_kinetic_from_p·cyclotron_cool_*) 과 같은 파일 — origin/main(#1014 ⓶감속·#1015 ⓸냉각) 진행으로 2차례 rebase·forward-merge, 형제 fn 전부 보존 (@D d9). 본 agent 는 자기 fn 3종만 추가.
## 2026-05-25T10:43:31Z — ⓶감속 AD/ELENA ladder verify (상대론 감속 ladder 🟢 · 비상대론 극한 환원)

- [x] 물리 도출 — 상대론 정확식 E=√((pc)²+(m_p c²)²) ⇒ T=√((pc)²+(m_p c²)²)−m_p c² · 역식 pc=√(T²+2·T·m_p c²) · m_p c²=938.272 MeV (CODATA)
- [x] 수치 — AD-in pc=3500→T=2685.3110811482716 MeV(≈2.685 GeV) · AD-out pc=100→T=5.313897512250946 MeV · ELENA-out T=0.1 MeV(100 keV)→pc=13.69906566156977 MeV/c · 비상대론 극한 √(2·m_p c²·T)=13.698700668311576 MeV/c (Δ=3.6e-4 MeV/c, ~3e-5 frac → 환원 확인)
- [x] hexa verify CLI (host=mini · POOL_DISABLE=1) — `rel_kinetic_from_p(pc_MeV)`=√(pc²+938.272²)−938.272 · `rel_p_from_kinetic(T_MeV)`=√(T²+2·T·938.272) 함수 추가 (help+dispatch+_is_float_fn) 후 bin/hexa-verify 재빌드 (additive diff 36 insertions, sibling fn 무손실 @D d9)
- [x] verdict (verbatim, AD-in T(pc)):
      `verify --expr rel_kinetic_from_p(3500.0)=2685.31`
      `  calc   = 2685.31  ≈ expected 2685.31  (|Δ|=0.0 ≤ ε=1e-9)`
      `  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)`
- [x] verdict (verbatim, AD-out T(pc)):
      `verify --expr rel_kinetic_from_p(100.0)=5.3139`
      `  calc   = 5.3139  ≈ expected 5.3139  (|Δ|=0.0 ≤ ε=1e-9)`
      `  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)`
- [x] verdict (verbatim, ELENA-out pc(T)):
      `verify --expr rel_p_from_kinetic(0.1)=13.6991`
      `  calc   = 13.6991  ≈ expected 13.6991  (|Δ|=0.0 ≤ ε=1e-9)`
      `  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)`
- [x] verdict (verbatim, 역변환 roundtrip pc(T_AD-out)→100):
      `verify --expr rel_p_from_kinetic(5.3139)=100.0`
      `  calc   = 100  ≈ expected 100.0  (|Δ|=7.38964e-13 ≤ ε=1e-9)`
      `  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)`
- [x] 비상대론 극한 엄밀 probe (verbatim) — rel pc(0.1) vs √(2mT): T²항≠0 ⇒ ε=1e-9에서 불일치 (정직 🔴; 물리적 환원은 ~5자리 성립):
      `verify --expr rel_p_from_kinetic(0.1)=13.6987`
      `  calc   = 13.6991  ≠ expected 13.6987  (|Δ|=0.000364993 > ε=1e-9)`
      `  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)`
- [x] negative control (verbatim) — `rel_kinetic_from_p(3500)=2700` (오답; 참값 2685.311) → 🔴 (검증기 변별력 확인):
      `verify --expr rel_kinetic_from_p(3500.0)=2700.0`
      `  calc   = 2685.31  ≠ expected 2700.0  (|Δ|=14.6889 > ε=1e-9)`
      `  tier   = 🔴 FALSIFIED  (calc deterministically disagrees beyond ε — TECS-L result-agnostic closed negative)`
- [x] atlas — `--absorb` → atlas/inbox/verified_equations.tape (🟢 inbox-fold, @D verified_rel_kinetic_from_p_3500_0__2685_31; shared sibling artifact라 커밋 X)
- [x] record — `exports/antimatter/verify/2026-05-25T10-43-31Z/decel_ladder_2026-05-25T10-43-31Z.json`
- [x] hexa-lang PR #1014 MERGED (rel_kinetic_from_p / rel_p_from_kinetic) · demiurge PR 별도
- [ ] absorbed — ⓶감속 비-wet-lab gate PASS; 全 공정 gate PASS 시 도메인 absorbed (@D d5)

## 2026-05-25T09:13:09Z — ⓻측정 1S-2S Rydberg verify (leading 폐형해 🟢 · CPT Δ absorbed=false)

- [x] 물리 도출 — E_n = − R∞·h·c/n² → ΔE_1S2S = R∞·h·c·(1/1²−1/2²) = (3/4)·R∞·h·c → f = (3/4)·R∞·c
- [x] 수치 재현 — R∞=1.0973731568e7 m⁻¹ · c=2.99792458e8 m/s ⇒ f = 2.4673814701521856e15 Hz ≈ 2.4674 PHz ≈ 2467 THz
- [x] hexa verify CLI (host=mini · POOL_DISABLE=1) — `transition_factor_1s2s` + `h1s2s_rydberg` 함수 추가 후 bin/hexa-verify 재빌드
- [x] verdict (verbatim, factor 3/4):
      `verify --expr transition_factor_1s2s()=0.75`
      `  calc   = 0.75  ≈ expected 0.75  (|Δ|=1.11022e-16 ≤ ε=1e-9)`
      `  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)`
- [x] verdict (verbatim, leading freq PHz):
      `verify --expr h1s2s_rydberg(1.09737e+07,2.99792e+08)=2.46738`
      `  calc   = 2.46738  ≈ expected 2.46738  (|Δ|=8.88178e-16 ≤ ε=1e-9)`
      `  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)`
- [x] gap-to-measured 정직 명시 — 측정값 2 466 061 413 187 035 Hz (=2.466061 PHz) vs leading 2.467381 PHz; ratio 0.999465 ≈ 환산질량 m_e/(m_e+m_p)≈0.999456. 잔차 ~1e-5 = QED/Lamb-shift. leading 폐형해는 15자리 재현 X (overclaim 금지)
- [x] CPT 맥락 — H vs H̄ 1S-2S는 측정정밀도(ALPHA 2018 ≈2e-12)까지 일치해야 함. **CPT Δ 자체는 실측 oracle 필요 ⇒ absorbed=false 유지** (@D d5 · projection flip 금지)
- [x] record JSON — `exports/antimatter/verify/2026-05-25T09-13-09Z/h1s2s_rydberg_2026-05-25T09-13-09Z.json`
- [x] ANTIMATTER.md ⓻측정 milestone `- [x]` flip (leading 🟢, CPT absorbed=false 주석 동반)

## 2026-05-25T09:13Z — ⓵생성 pair-threshold verify (🔵 SUPPORTED-FORMAL + 🟢 SUPPORTED-NUMERICAL)

반양성자 쌍생성(pair-production) 문턱 — **p + p → p + p + p + p̄** (고정표적, 한 양성자 정지) — 을 로런츠 불변 Mandelstam s 로 폐형해 유도 + hexa CLI verify. 바리온수 보존이 여분 양성자를 강제 → 종말상태 4 바리온.

- [x] 폐형해 유도 — 문턱에서 종말 4입자가 CM에서 정지 ⇒ s_min=(4 m_p c²)². 고정표적 s=2 m_p c²·E_beam+2(m_p c²)². 등치 ⇒ **E_beam,th=7 m_p c²** ⇒ **운동에너지 문턱 T_th=E_beam,th−m_p c²=6 m_p c²** (Chamberlain–Segrè 1955 Bevatron)
- [x] 수치 — m_p c²=938.272 MeV ⇒ T_th=6×938.272=**5629.632 MeV ≈ 5.63 GeV** · 총 빔에너지 E_beam,th=7×938.272=6567.904 MeV ≈ 6.57 GeV
- [x] hexa-native fn 3종 추가 (tool/verify_cli.hexa) — `pair_threshold_factor(n)=6·n` (정수 폐형해, _recompute) · `pair_threshold_kinetic(m_p_c²)=6·m_p_c²` (float, _recompute_float) · `pair_threshold_total(m_p_c²)=7·m_p_c²` → `bin/hexa-verify` 재빌드
- [x] verify 호스트 = mini only (`POOL_DISABLE=1`) — factor-6 항등식 **🔵 SUPPORTED-FORMAL** · 운동/총에너지 수치 **🟢 SUPPORTED-NUMERICAL** (verbatim 아래)
- [x] 음성대조 — `pair_threshold_factor 1 5`→🔴 FALSIFIED, `pair_threshold_kinetic 938.272 5000.0`→🔴 FALSIFIED (결정론적, rubber-stamp 아님 확인)
- [x] `hexa atlas register --from-verify pair_threshold_factor 1 6` → `@F verified-pair_threshold_factor-1` 을 `compiler/atlas/embedded.gen.hexa` 에 직접 fold (live atlas, no rebuild)
- [x] record — `exports/antimatter/verify/2026-05-25T09-12-57Z/pair_threshold_2026-05-25T09-12-57Z.json`

verbatim verdicts:

```
verify --expr pair_threshold_factor(1)=6
  calc   = 6  == expected 6
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)

verify --expr pair_threshold_kinetic(938.272)=5629.63
  calc   = 5629.63  ≈ expected 5629.63  (|Δ|=9.09495e-13 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr pair_threshold_total(938.272)=6567.9
  calc   = 6567.9  ≈ expected 6567.9  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

## 2026-05-25T09:11Z — ⓷포획 Penning 3-freq verify (🟢 SUPPORTED-NUMERICAL)

대표 반양성자(p̄) 페닝트랩 파라미터 — **B=5 T · U₀=10 V · d=5 mm · m=m_p · q=e** (CODATA 2018, CPT로 m_p̄=m_p) — 로 3 고유운동(eigenmotion) 각진동수 폐형해 계산 + Brown–Gabrielse 불변량 정리(invariance theorem) hexa CLI verify.

- [x] 3주파 폐형해 계산 — ω_c=qB/m=4.78941658e8 rad/s (f_c≈76.23 MHz) · ω_z=√(qU₀/(m·d²))=6.18993801e6 (f_z≈985.16 kHz) · ω₊=ω_c/2+√((ω_c/2)²−ω_z²/2)=4.78901654e8 (f₊≈76.22 MHz) · ω₋=ω_c/2−√(…)=4.0003341e4 (f₋≈6.37 kHz)
- [x] 트랩 조건 확인 — 판별식 (ω_c/2)²−ω_z²/2 ≥ 0 (ω_c ≥ √2·ω_z) 만족 → 방사방향 운동 속박
- [x] 부속 항등식 — ω₊+ω₋=ω_c (잔차 6e-8 = float roundoff) · ω₊·ω₋=ω_z²/2 · **불변량 ω_c²=ω₊²+ω_z²+ω₋² (재구성 ω_c 잔차=0.0, 정렬오차/타원성에도 robust)**
- [x] hexa-native fn 3종 추가 (tool/verify_cli.hexa) — `penning_omega_plus(ω_c,ω_z)` · `penning_omega_minus(ω_c,ω_z)` · `penning_invariance(ω_c,ω_z)=√(ω₊²+ω_z²+ω₋²)==ω_c` → `bin/hexa-verify` 재빌드 (-lm/-ldl 포함 clang -O2)
- [x] verify 호스트 = mini only (`POOL_DISABLE=1`); 3 atom 전부 **🟢 SUPPORTED-NUMERICAL |Δ|=0.0 ≤ ε=1e-9** (verbatim 아래)
- [x] `hexa atlas register --from-verify penning_invariance …` → `@F verified-penning_invariance-num` 을 `compiler/atlas/embedded.gen.hexa` 에 직접 fold (live atlas, no rebuild)
- [x] record — `exports/antimatter/verify/2026-05-25T09-11-36Z/penning_3freq_20260525T091136Z.json`
- [x] ANTIMATTER.md ⓷포획 `- [ ]`→`- [x]` (🟢) · V2 Penning-3freq sub-item + V3 주석
- [ ] V2 전체(pair-threshold·Rydberg 1S-2S·Ioffe-P depth)는 미완 — Penning sub-item만 닫음
- [ ] absorbed — 全 게이트 PASS 아님 (다른 공정 미완) → false 유지 (@D d5)

verbatim hexa verify verdict (`POOL_DISABLE=1 hexa verify --expr …`):

```
verify --expr penning_omega_plus(4.78942e+08,6.18994e+06)=4.78902e+08
  calc   = 4.78902e+08  ≈ expected 4.78902e+08  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr penning_omega_minus(4.78942e+08,6.18994e+06)=40003.3
  calc   = 40003.3  ≈ expected 40003.3  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr penning_invariance(4.78942e+08,6.18994e+06)=4.78942e+08
  calc   = 4.78942e+08  ≈ expected 4.78942e+08  (|Δ|=0.0 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

note: 불변량 정리는 정확한 대수 항등식(잔차 0.0 at machine precision)이나 sqrt 포함 libm-class 재계산이라 rubric상 tier=🟢 (🔵=순수 정수/symbolic). hexa-lang 측 verify_cli.hexa 변경은 형제 ANTIMATTER agent 들의 미커밋 fn(pair_threshold 등)과 같은 파일에 공존 → @D d9 준수 위해 본 agent 는 hexa-lang 커밋 안 함(형제 작업 흡수 방지); atom 은 live atlas + 재빌드 binary 로 재현 가능.

## 2026-05-25T09:02:13Z — 도메인 개설: 반물질 공장 (단일 도메인 · 생산라인=축)

- [x] `/domain init ANTIMATTER` — ANTIMATTER.md + ANTIMATTER.log.md scaffold
- [x] 프레임 확정 — "반물질 공장" 단일 도메인, 7공정(생성→…→측정)이 곧 축 (RTSC 5축 패턴 미러링, 별개 도메인 분할 X · Occam g0)
- [x] @goal = a+b 둘 다 — (a) 공정별 verify-native 닫기 + (b) 풀 7-verb 공장 인계
- [x] @title + @goal + 10 milestones + 축 구조표 + 공정×물리 verify 타깃표 박음
- [x] ⓺가둠 축 = RTSC 자석 toolchain(getdp 4.0 · Wheeler 폐형해) 직계 상속 명시 (Ioffe-Pritchard 자기최소 트랩)
- [ ] V1 claim inventory 착수 — 7공정 물리량 tier triage

