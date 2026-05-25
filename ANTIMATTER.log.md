# ANTIMATTER — log

Append-only history sister of `ANTIMATTER.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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

