# κ-71 horizon candidate research — 4th cell 5-fold lock-in OPTIONS

> **status**: scaffold-open · 2026-05-22 (post-κ-70 R9 4/4 CLOSURE
> `e818218` · G38 LANDED)
>
> ARCH.md §11.6 Round 10 의 G40 pre-code decision gate (κ-68 G27 /
> κ-69 G32 / κ-70 G36 와 동형) 의 *candidate digest*. User pick 전
> 단계의 anchor — 본 note 는 후보 cell 의 5-fold lock-in dimension
> (cell / external oracle / bridge stack / hexa-native scope / PASS
> criterion) 을 articulate. 결정은 user 가 다음 engagement 에서 수행 —
> 본 agent 는 RANK 만 제안 (advisory only).
>
> **κ-70 G36 research note** (`inbox/notes/2026-05-22-k70-horizon-
> candidate-research.md`) 의 직접 successor. 그 노트의 Candidate B
> (Energy/wind) + Candidate C (Bio/ECG) 가 *그대로* 4th cell 후보로
> carry — Candidate A (Ufo/plasma) 는 κ-70 G37 으로 picked & landed
> (D118 / D119 · `absorbed=true` 3rd cell). 본 노트 = 그 둘 + 새
> finalist 1 (Chem/Arrhenius) 의 3-way 비교. (Exit-path γ: κ-70 후보가
> 직접 carry — Energy/wind #2 → κ-71 #1 natural · 본 note 는 κ-71
> framing 으로 re-document + 새 substrate-floor fact 갱신.)

## 구조적 inflection — κ-71 은 lowest-friction carrier 가 소진됨

**핵심 finding** (κ-69/κ-70 와 본질적으로 다른 점): cockpit VerifyRecord
inventory 를 `hexaNativeParity` carrier × `measuredOracle` field 로
audit 한 결과 —

| record | hexaNativeParity | measuredOracle | κ-status |
|---|:---:|:---:|---|
| `EnergyVerifyRecord` | ✓ | ✓ | κ-68 G29 1st carrier (LANDED) |
| `AuraVerifyRecord` | ✓ | ✓ | κ-69 G33 2nd carrier (LANDED) |
| `UfoVerifyRecord` | ✓ | ✓ | κ-70 G37 3rd carrier (LANDED) |
| **`FusionVerifyRecord`** | **✓** | **✗** | **D106-LOCKED** (mc_transport illustrative-physics · `MeasuredOracleRef` 부착 불가 · RFC 013 §6.12) |
| (10 others) | ✗ | ✗ | parity 미land |

κ-70 의 Ufo 는 `hexaNativeParity` carrier 이면서 `measuredOracle` 가
없는 **마지막 1-field-extension 후보** 였다 (Aura G33 mirror · 최저
friction). 그 패턴이 κ-70 으로 소진됨 — 남은 유일 `[HP][✗]` carrier
(`FusionVerifyRecord`) 는 **D106 illustrative-physics gate 로 영구
잠김** (mc_transport pilot 은 single-energy-group illustrative MC ·
real Li-blanket cross-section 아님 · `absorbed` flip 후보에서 명시
제외). 따라서 **κ-71 의 어떤 후보도 κ-69/κ-70 의 "1-field 확장 =
최저 friction" 패턴을 재현 불가** — 모든 후보가 (a) 새 VerifyRecord
신설 (Bio/Chem) 또는 (b) 기존 record 재사용 + producer-side 새 sub-cell
경로 신설 (Energy/wind = `EnergyVerifyRecord` 재사용 또는 `EnergyWind
VerifyRecord` 신설) 중 하나. 이 inflection 은 κ-71 의 critical-path 가
κ-68..κ-70 의 어느 것보다 **substrate-side 또는 schema-side 한 단계
더 무겁다**는 honest signal — round 의 est 가 그만큼 길어짐.

## 5-fold lock-in (G27 / G32 / G36 pattern · D109 / D115 / D118 reference)

| dimension | κ-70 G36 reference (Ufo/plasma Stage-2 · D118/D119) |
|---|---|
| cell | `UfoVerifyRecord` (cockpit · 1-field 확장 · 3rd carrier) + `domains/ufo.md` Stage-2 sister-substrate fusion plasma diagnostic |
| external oracle | JET open-pulse archive mid-Ohmic single shot (n_e + T_e timeseries) — *real archive anonymous access 불가 → synthetic_jet_like_mid_ohmic fallback* (D118 exit-criterion-δ permitted · Keilhacker 1999 reference operating point) |
| bridge stack | `stdlib/fusion/jet_pulse_fetcher.py` + `jet_plasma_measured_oracle.py` (plasmapy → math-CODATA-2022 fallback trusted bridge) → hexa-native `_plasma_lambda_d_batch.hexa` |
| hexa-native scope | `stdlib/kernels/plasma/plasma_metrics_kernel::lambda_d` (`pilot-plasma_metrics` 41/41 PASS @ rel_err=0.0 IEEE-754 bit-exact) · λ_D Debye-length axis |
| PASS criterion | `mean_rel_err ≤ 0.05` over N=50 JET-like mid-Ohmic stationary timesteps — D119 result `2.21e-06` (numeric-equivalence shape · D117 mirror NOT D110 predict-vs-measure) |

## Candidate 분석 (3 finalist · D106 illustrative 제외 후보 우선)

### Candidate A — Energy / wind sub-cell (NREL Wind Toolkit · IEC 61400-12 power curve)

> κ-69 G32 Candidate B → κ-70 G36 Candidate B → κ-71 Candidate A
> (3-round carry · 매 round prediction-shape 강함으로 #2 ranked · 본
> round 에서 #1 후보로 승격 — Ufo 의 1-field-extension 우위가 G37 로
> 소진되어 더 이상 friction 비교의 분모 아님).

| dimension | proposal |
|---|---|
| **cell** | (i) `EnergyVerifyRecord` 재사용 (이미 `measuredOracle` + `hexaNativeParity` 둘 다 carrier · G29 solar 1st carrier) + producer-side wind-power 경로 신설, **OR** (ii) 새 `EnergyWindVerifyRecord.swift` (~30 줄 · `EnergyVerifyRecord` 1:1 mirror · sub-cell separation + 4th-record-type schema-generalization payoff). default 제안 = **(ii) 새 record** (solar/wind sub-cell separation 깔끔 · `invariantHolds` record-type-agnostic 의 4th instance audit) |
| **external oracle** | NREL **Wind Toolkit (WTK)** · 5-min cadence · 100 m hub-height · 7-year 2007-2013 archive · CONUS 2-km grid · HSDS REST API (NREL token 필요 = anonymous 아님 · solar MIDC anonymous wget 보다 한 단계 약함). 측정 = single turbine site power-curve 대 modeled wind→power. **honesty floor**: Ufo G37 의 synthetic fallback 과 동형의 fallback path 가 token-gating 시 필요할 수 있음 (`data_source` field disclosure) |
| **bridge stack** | (신설) `stdlib/energy/wtk_fetcher.py` (HSDS REST adapter · auth header pass-through · D86 env-var/CLI only) → `stdlib/energy/_wind_power_curve_batch.hexa` (hexa-native IEC 61400-12 power curve · solar G31b `_solar_position_batch.hexa` sibling). trusted-bridge equivalent = `windpowerlib` (오픈소스 community-validated · pvlib sibling) |
| **hexa-native scope** | **새 kernel 필요**: `stdlib/kernels/wind/power_curve_kernel.hexa` (IEC 61400-12 reference power curve + air-density correction + cut-in/cut-out + Betz limit). **현재 wind/aero kernel 없음** — `domains/PILOTS.demi` 에 `pilot-power_curve` row 부재 확인 (substrate-parity floor ZERO). G39 (cell pick) 이전 별 cycle 의 substrate kernel land (G31 mirror · 1-3 session) 가 dependency |
| **PASS criterion** | `mean_rel_err ≤ 0.05` over `wind_speed ∈ [4, 25] m/s` (cut-in to cut-out · operational regime filter · solar daylight filter mirror). **prediction-shape** = modeled wind→power 대 measured turbine output (G29 solar 의 modeled-vs-measured prediction axis 와 동형 · D117/D119 numeric-equivalence shape 보다 강함) |

**G40 schema cost**: `EnergyVerifyRecord` 재사용 시 0; 새 `EnergyWind
VerifyRecord` 시 ~30 줄 (mirror) + CodingKeys + memberwise init +
XCTest invariant auto-extension test ~50 줄.

**ranking factors**:
- D106 clean (real wind data · IEC reference curve · illustrative 아님 · prediction-axis honesty 가장 강함 — G29 mirror)
- **substrate-parity floor ZERO** — `power_curve_kernel.hexa` 신설 필요 (`pilot-power_curve` 부재 confirmed) · κ-71 critical-path = G39 (cell pick) → substrate kernel land (별 cycle · 1-3 session) → G41 (first-flip) = κ-68/κ-69/κ-70 보다 substrate-side 1-step 더 무거움 (G31 G29-β port mirror)
- bridge stack + hexa-native kernel **둘 다 신설 필요** — κ-70 Ufo (kernel 이미 있음 · fetcher 만 신설) 보다 무거움
- NREL WTK HSDS API token 필요 = honesty floor 가 solar MIDC anonymous wget / PhysioNet anonymous 보다 한 단계 약함 — record `datasetCaveats` 명시 disclosure 필요 (Ufo G37 의 synthetic-fallback honesty disclosure 와 동형 risk)
- G40 schema-generalization payoff 강함 (새 record type = 4th-record-type audit · `invariantHolds` record-type-agnostic 검증의 4th instance · 4 cell × 동일 predicate × helper edit 0)
- **prediction-shape honesty 가 가장 강함** — D117 G33 / D119 G37 의 numeric-equivalence shape 약점 (formula evaluation on measured inputs · predict-vs-measure 아님) 을 보완 · κ-71 의 PASS 가 D110 G29 의 *predict-vs-measure* shape 으로 다시 elevate (solar 이후 두번째 prediction-shape land)
- `domains/energy.md` sub-cell 구조 강화 (solar / wind 분리 narrative)

---

### Candidate B — Bio / sequence-alignment NW 또는 ECG QRS (PhysioNet 또는 Durbin §2.3)

> κ-69 G32 Candidate C (당시 Ufo/plasma 였음 — 명칭 혼동 주의) 와 무관 ·
> κ-70 G36 Candidate C (Bio/ECG) 의 직접 carry. **새 fact 갱신**:
> `pilot-bio_align_nw` 가 κ-70 note 시점 "7 textbook pair" 에서 현재
> **36/36 PASS @ rel_err=0** (exact integer equality · `hexa_lang_sha
> d73a2cbf`) 으로 성장 — substrate-parity floor 가 κ-70 note 가 가정한
> 것보다 강함 (option ii 의 substrate floor 가 매우 견고).

| dimension | proposal |
|---|---|
| **cell** | **새 `BioVerifyRecord.swift`** (cockpit · 현재 미존재 — κ-71 schema cost 의 first-record-type carrier 신설 · ~40 줄 `EnergyVerifyRecord` 1:1 mirror · `hexaNativeParity` + `measuredOracle` 둘 다 from-start carry · evolved shape) + `domains/bio.md` (D81 신규 도메인 · sibling `~/core/hexa-bio/` D116 docs-only · substrate code = hexa-lang/stdlib/ ONLY) |
| **external oracle** | (a) PhysioNet **MIT-BIH Arrhythmia Database** (48 ECG record · 360 Hz · open · CC-BY · anonymous wget = Aura Sleep-EDF / solar MIDC 동형 floor) — QRS R-peak interval (RR-interval) 의 measured oracle. (b) **Durbin §2.3 textbook fixture** (`pilot-bio_align_nw` 의 36 sequence pair · *textbook fixture as oracle* · D106 partial — clean-room reference 가 real biological data 아님 → measured-oracle shape 약함). default 제안 = **(a) MIT-BIH ECG** (real biological signal · prediction shape 강함 · trivial anonymous access) |
| **bridge stack** | (a) 채택 시 (신설) `stdlib/bio/mitbih_fetcher.py` (PhysioNet anonymous-HTTPS · Aura `sleep_edf_fetcher.py` 1:1 mirror · D86 floor) → `stdlib/bio/qrs_detector_measured_oracle.py` (4-stage producer · MNE-like substrate-parity trusted bridge → hexa-native batch → JSON emit with absorbed gate · G33 `sleep_edf_measured_oracle.py` mirror). **CAVEAT**: NW kernel 은 sequence-alignment axis · ECG QRS 는 signal-proc axis → axis mismatch (아래 hexa-native scope 참조) |
| **hexa-native scope** | **option (a) ECG QRS** — 새 kernel `stdlib/kernels/signal_proc/qrs_detector.hexa` (Pan-Tompkins 1985 band-pass + derivative + squaring + integration + threshold · `pilot-dft_naive` 17/17 substrate-parity floor 일부 reuse 가능). **option (b) sequence-alignment** — `pilot-bio_align_nw` (Needleman-Wunsch linear gap · **36/36 PASS @ rel_err=0** · 이미 land · 신설 0) reuse |
| **PASS criterion** | option (a) `mean_rel_err ≤ 0.05` on R-peak interval (RR-interval ms) over N=100 QRS events from MIT-BIH `mitbih_100` (prediction-shape 강함). option (b) `rel_err = 0` exact (integer DP score 대 oracle score · 36-pair · **discrete-integer exact-match shape** — D110/D117/D119 의 어느 shape 와도 다른 새 honest shape) |

**G40 schema cost**: 새 `BioVerifyRecord.swift` ~40 줄 + CodingKeys +
memberwise init + tests + XCTest invariant auto-extension ~50 줄 =
~120 줄 schema land. κ-69/κ-70 의 1-field 확장보다 가장 무거움.

**ranking factors**:
- D106 clean — bio measurement axis 는 real biological signal (ECG QRS · option a) · illustrative 아님. (option b textbook fixture 는 partial — real data 아님)
- substrate-parity 이미 PASS — `pilot-bio_align_nw` **36/36 @ rel_err=0** (option b · 매우 견고 · 신설 0) 또는 `pilot-dft_naive` 17/17 reuse (option a 의 일부 floor)
- bridge stack 신설 (option a · `mitbih_fetcher.py` + `qrs_detector_measured_oracle.py` · Aura sleep_edf 1:1 mirror · est 0.5-1 session) — Energy/wind 의 substrate kernel 신설보다 가벼움
- **cockpit `BioVerifyRecord` 신설 = κ-71 후보 중 schema 작업 가장 무거움** (vs Energy/wind 의 재사용-가능 또는 ~30 줄)
- "**first NEW DOMAIN cell**" signal 강함 (κ-68=Energy · κ-69=Aura · κ-70=Ufo · κ-71=Bio 의 4-domain progression · GOAL.md multi-domain coverage)
- option (a)/(b) axis-match honest split 필요 — ECG oracle = signal-proc kernel · alignment fixture = bio_align kernel
- option (b) 의 `rel_err=0` discrete-exact shape 는 D110/D117/D119 의 floating-point shape spectrum 에 **새 4th shape (integer-exact)** 추가 — honest-shape diversity 가치

---

### Candidate C — Chem / Arrhenius kinetics (Cantera 또는 NIST kinetics oracle)

> κ-70 G36 의 open-candidate (Chem · "Arrhenius kernel pilot exists")
> 의 finalist 승격. **honest 갱신**: `pilot-chem_arrhenius` 는
> `domains/PILOTS.demi` scope_notes 가 명시하듯 **Stage-0 scaffolding
> seed** — "NOT a D80 pilot in the parity-oracle sense (no Python
> reference, no Cantera/RDKit/Psi4 substrate exists yet) · formula IS
> the algorithm · 6/6 self-test PASS · Promotes to Stage-2 when a
> Cantera/Psi4 parity oracle lands". 즉 substrate-parity floor 가
> *self-test only* 라 Ufo λ_D (41/41 bit-exact + 19 orders n_e × 5
> orders T_e sweep) 보다 honest floor 가 **약함**.

| dimension | proposal |
|---|---|
| **cell** | **새 `ChemVerifyRecord.swift`** (cockpit · 현재 미존재 · ~40 줄 mirror · Bio 후보와 동일 schema cost) + `domains/chem.md` (D81 신규 도메인 · prereq=matter · sibling `~/core/hexa-chem/` planned · substrate code = hexa-lang/stdlib/ ONLY) |
| **external oracle** | **Cantera** (BSD · open kinetics) 의 reference reaction-rate 또는 **NIST Chemical Kinetics Database** (공개 evaluated rate constant · A/Ea literature value) 의 measured Arrhenius parameter. 측정 axis = (A, Ea, T) → k(T) rate 의 modeled (hexa Arrhenius) 대 NIST/Cantera reference k(T). **honesty floor 약점**: Arrhenius 는 closed-form formula evaluation — D119 Ufo λ_D 와 동형의 *numeric-equivalence* shape (predict-vs-measure 아님). NIST reference 는 measured A/Ea 위 *재평가* 라 prediction shape 도 partial 가능 (NIST 의 experimentally-fitted k(T) vs hexa formula k(T)) |
| **bridge stack** | (신설) `stdlib/chem/nist_kinetics_fetcher.py` (NIST WebBook / Cantera reference data fetch · D86 env-var/CLI) → `stdlib/chem/arrhenius_measured_oracle.py` (Cantera-trusted bridge → hexa-native batch → JSON emit · G33/G37 producer mirror) → hexa-native `stdlib/kernels/chem/arrhenius_kernel.hexa` (`pilot-chem_arrhenius` 6/6 self-test PASS · 신설 0) |
| **hexa-native scope** | `stdlib/kernels/chem/arrhenius_kernel::k` (`k = A·exp(-Ea/(R·T))` · CODATA 2018 R · 6/6 self-test · 신설 0 reuse). **CAVEAT**: Stage-0 scaffolding — no temperature-dependent A, no tunnelling, no reaction catalog. 측정 axis = single-reaction k(T) over T-sweep (Ea/A fixed) |
| **PASS criterion** | `mean_rel_err ≤ 0.05` over N=50 temperature points T ∈ [273, 1273] K for a single NIST/Cantera-catalogued reaction (e.g. H + O2 → OH + O · NIST evaluated A/Ea). **shape** = numeric-equivalence (closed-form k(T) on reference A/Ea · D119 Ufo λ_D mirror) — *not* prediction unless NIST experimental k(T) ≠ Arrhenius-fitted k(T) (catalysts/non-Arrhenius 영역만 prediction shape) |

**G40 schema cost**: 새 `ChemVerifyRecord.swift` ~40 줄 + CodingKeys +
init + tests + invariant auto-extension ~50 줄 = ~120 줄 (Bio 와 동일
무게).

**ranking factors**:
- D106 clean 가능 — Arrhenius 는 illustrative-physics gate 미적용 (real reaction kinetics · NIST measured A/Ea · falsifier OPEN). 단 mc_transport 와 달리 Stage-0 scaffolding 이라 *measurement* axis 가 아직 미성숙
- **substrate-parity floor 약함** — `pilot-chem_arrhenius` 6/6 *self-test only* (no external oracle · formula IS algorithm · PILOTS scope_notes 명시 "Stage-0 scaffolding · NOT a D80 pilot in parity-oracle sense"). Ufo λ_D 41/41 bit-exact + multi-order sweep 보다 약함 — κ-71 PASS 의 substrate floor 가 self-test-only 위에 서는 honest weakness
- bridge stack 신설 (`nist_kinetics_fetcher.py` + `arrhenius_measured_oracle.py` · G37 mirror · est 0.5-1 session)
- cockpit `ChemVerifyRecord` 신설 = Bio 와 동일 schema 무게 (~120 줄)
- "NEW DOMAIN cell" signal (4-domain progression 의 대안 — Bio 대신 Chem)
- **prediction-shape honesty 약함** — Arrhenius closed-form = D119 Ufo numeric-equivalence shape mirror (formula evaluation) · NIST experimental k(T) 가 Arrhenius fit 과 다른 영역 (non-Arrhenius curvature) 에서만 prediction shape. κ-71 이 prediction-axis elevate 를 명시 목표로 하면 Energy/wind 가 우위
- chem domain 은 prereq=matter (D82 graph) · sibling `~/core/hexa-chem/` 아직 planned (substrate maturity 가장 낮음)

---

## 비교 표

| factor | Energy/wind (A) | Bio/ECG (B) | Chem/Arrhenius (C) |
|---|---|---|---|
| D106 clean | yes (real wind · IEC curve) | yes (real ECG · option a) | partial (real kinetics but Stage-0 scaffolding) |
| substrate-parity PASS | **NO** (`pilot-power_curve` 부재 · kernel 신설 1-3 session) | yes (`pilot-bio_align_nw` 36/36 @ rel_err=0 · option b · 또는 `pilot-dft_naive` 17/17 option a 일부) | weak (`pilot-chem_arrhenius` 6/6 *self-test only* · no external oracle · Stage-0) |
| bridge stack 존재 | NO (둘 다 신설) | NO (Aura sleep_edf 1:1 mirror · 0.5-1 session) | NO (G37 mirror · 0.5-1 session) |
| cockpit record | 재사용 가능 (`EnergyVerifyRecord`) or 신설 (~30줄) | NO (`BioVerifyRecord` 신설 ~40 줄) | NO (`ChemVerifyRecord` 신설 ~40 줄) |
| dataset access | NREL HSDS **token 필요** | trivial (PhysioNet anonymous wget) | partial (NIST WebBook open · Cantera bundled) |
| G40 schema payoff | high (4th record if 새 record) or low (재사용) | very high (NEW DOMAIN + 4th record) | very high (NEW DOMAIN + 4th record) |
| prediction-shape honesty | **strong** (modeled wind→power · D110 G29 mirror) | strong (R-peak · option a) or discrete-exact rel_err=0 (option b · 새 shape) | weak (closed-form k(T) · D119 numeric-equivalence mirror) |
| critical-path length | **long** (G39→substrate kernel land→G41 = 3-step · substrate-side 가장 무거움) | medium (record 신설 + bridge mirror · 1.5-2.5 session) | medium-weak (record 신설 + bridge · substrate floor self-test-only risk) |
| 1-field-extension 가능 | NO (모든 κ-71 후보 동일 — Ufo 로 소진) | NO | NO |

## RANK 제안 (user 가 결정 · 본 agent 는 advisory only)

- **#1: Energy / wind sub-cell (Candidate A)**
  - **exit-path γ 의 natural carry**: κ-70 G36 #2 → κ-71 #1. Ufo 의
    1-field-extension 우위가 G37 로 소진되어 더 이상 friction 비교의
    분모가 아니므로, κ-70 에서 #1 을 막던 유일 요인 (substrate kernel
    신설 cost vs Ufo 의 zero-cost 1-field 확장) 이 사라짐. 남은 모든
    κ-71 후보가 동일하게 신설 cost 를 지므로, **prediction-shape
    honesty 가 가장 강한** Energy/wind 가 자연 #1.
  - **prediction-axis re-elevate**: D110 (Energy/solar G29) 의
    *predict-vs-measure modeling-error-bounded statement* 가 κ-69
    (D117 Aura numeric-equivalence) + κ-70 (D119 Ufo numeric-
    equivalence) 두 round 동안 numeric-equivalence shape 으로 후퇴.
    Energy/wind 는 modeled wind→power vs measured turbine output 으로
    **prediction shape 을 두번째로 land** — honesty floor 가 G33/G37
    의 numeric-equivalence 약점을 보완. κ-70 closure entry 의 'next
    horizon (κ-71+)' 4-item list 의 첫 line item ("다른 cell measured-
    oracle round — Energy/wind NREL Wind Toolkit") 와 직접 alignment.
  - **honest weakness**: substrate-parity floor ZERO (`pilot-power_
    curve` 부재) — G39 cell pick 이후 별 cycle 의 `power_curve_kernel.
    hexa` substrate land (G31 mirror · 1-3 session) 가 G41 first-flip
    의 dependency. κ-71 critical-path 가 κ-68..κ-70 보다 substrate-side
    1-step 길어짐 (round est 가장 큼). NREL WTK HSDS token honesty
    floor (anonymous 아님 · `datasetCaveats` disclosure 필요).
  - **schema 결정**: 새 `EnergyWindVerifyRecord` (default) vs
    `EnergyVerifyRecord` 재사용 — 새 record 채택 시 4th-record-type
    `invariantHolds` audit (4 cell × 동일 predicate × helper edit 0 ·
    G30 record-type-agnostic 의 4th instance · κ-70 의 3rd instance 의
    자연 다음).

- **#2: Bio / ECG 또는 sequence-alignment (Candidate B)**
  - "**first NEW DOMAIN cell**" signal 가장 강함 (4-domain progression).
    trivial anonymous dataset access (PhysioNet · solar MIDC + sleep-edf
    동형 floor). substrate-parity floor 강함 — `pilot-bio_align_nw`
    **36/36 @ rel_err=0** (κ-70 note 가정 7-pair 보다 크게 성장 ·
    option b 매우 견고) 또는 `pilot-dft_naive` 17/17 (option a 일부).
    bridge stack 작업 낮음 (Aura sleep_edf 1:1 mirror).
  - 그러나 cockpit `BioVerifyRecord` 신설 = κ-71 schema 작업 가장
    무거움 (~120 줄). option (a)/(b) axis-match honest split 필요.
  - **이 후보가 #1 으로 올라가려면**: "new-record-type land + NEW
    DOMAIN signal" 가 κ-71 의 명시 목표여야 (prediction-axis re-elevate
    보다 우선). option (b) 의 `rel_err=0` discrete-integer-exact shape
    가 D110/D117/D119 의 floating-point shape spectrum 에 새 4th shape
    추가 — honest-shape diversity 우위.

- **#3: Chem / Arrhenius (Candidate C)**
  - "NEW DOMAIN cell" 신설 대안 (Bio 와 동일 schema 무게). NIST
    WebBook open access. `arrhenius_kernel` 6/6 self-test 이미 존재
    (kernel 신설 0).
  - 그러나 **substrate-parity floor 가장 약함** — `pilot-chem_
    arrhenius` 는 PILOTS scope_notes 가 명시한 **Stage-0 scaffolding ·
    no external oracle · "formula IS the algorithm"** — D80 pilot
    parity-oracle sense 아님. Ufo λ_D (41/41 bit-exact + multi-order
    sweep) 보다 substrate floor 약하고, measurement axis 도 closed-form
    numeric-equivalence (D119 mirror · prediction shape 약함). chem
    domain 자체가 prereq=matter · sibling repo planned 단계 (substrate
    maturity 가장 낮음).
  - **이 후보가 #1 으로 올라가려면**: "chem domain 의 measurement-
    axis bootstrap (Stage-0 → Stage-2 promotion)" 자체가 κ-71 의 명시
    목표여야 — substrate floor weakness 를 감수하고 chem 의 first
    measured-oracle 를 land 하는 것이 가치가 있을 때만.

## 주요 trade-off

1. **substrate-side cost (κ-71 critical-path)**: Bio option-b
   (`pilot-bio_align_nw` 36/36 reuse · 신설 0) < Chem (`arrhenius`
   6/6 reuse · 신설 0 but self-test-only floor) < Bio option-a (qrs_
   detector 신설) < Energy/wind (`power_curve_kernel` 신설 · floor
   ZERO · 1-3 session). **κ-71 은 1-field-extension 패턴 소진으로 모든
   후보가 record-side OR substrate-side 신설 cost 를 짐** — κ-68..κ-70
   보다 round est 가 본질적으로 큼.
2. **prediction-axis honesty vs numeric-equivalence honesty**:
   D110 solar = prediction (강함) · D117 Aura + D119 Ufo = numeric-
   equivalence (2 round 연속). κ-71 의 honest shape 선택:
   - Energy/wind = **prediction** (D110 G29 mirror · honesty floor
     re-elevate · 2 round 후퇴 회복)
   - Bio ECG = prediction (option a) OR discrete-integer-exact
     rel_err=0 (option b · 새 4th shape)
   - Chem Arrhenius = numeric-equivalence (D119 mirror · 약함) ·
     non-Arrhenius 영역만 partial prediction
3. **dataset access overhead**: PhysioNet (anonymous wget · Bio) <
   NIST WebBook (open · Chem) < NREL WTK HSDS (token 필요 · Energy/
   wind) — Energy/wind 만 token honesty floor weakness (Ufo G37 의
   synthetic fallback 과 동형의 disclosure risk)
4. **invariant-helper audit signal (4th instance)**: 1st (D110
   Energy/solar) → 2nd (D117 Aura/EEG) → 3rd (D119 Ufo/plasma) →
   **4th (κ-71 G41)**. κ-70 가 "3 cell × 동일 predicate × helper edit
   0 = strongest evidence cycle" 를 land — 4th carrier 도 같은 0-code-
   change 확인 시 generalization 의 *redundant confirmation* (3rd 가
   이미 strongest evidence 라 4th 의 marginal audit 가치는 체감 ·
   대신 NEW DOMAIN 또는 prediction-shape re-elevate 의 다른 축 가치가
   4th instance 의 주 motivation)
5. **NEW DOMAIN signal vs schema-reuse**: Energy/wind (재사용 가능 ·
   기존 domain) < Bio/Chem (NEW DOMAIN · 새 record 필수). κ-68..κ-70
   은 모두 기존 domain (Energy · Aura · Ufo). κ-71 이 first NEW DOMAIN
   cell (Bio 또는 Chem) 을 land 하면 multi-domain coverage 의 질적
   확장 — 단 schema cost 가장 무거움

## User 가 lock-in 시 답해야 할 open question

1. **#1 후보 (Energy/wind) picked 시**:
   - `EnergyVerifyRecord` 재사용 vs 새 `EnergyWindVerifyRecord`?
     default 제안 = **새 record** (4th-record-type audit + sub-cell
     separation)
   - `power_curve_kernel.hexa` 의 G39-이후 substrate-land 처리 —
     G39 cell pick → 별 cycle 의 G31-mirror substrate kernel land →
     G41 first-flip? default 제안 = **별 cycle partial-land** (κ-69 G31
     partial-land 패턴 mirror · `pilot-power_curve` row PILOTS.demi 신설
     포함)
   - NREL WTK HSDS token honesty floor disclosure shape? default
     제안 = `MeasuredOracleRef.datasetCaveats` entry "requires NREL
     WTK HSDS API token (not anonymous)" + token-gating 시 synthetic
     fallback (Ufo G37 `data_source` disclosure mirror)
   - PASS threshold — D110/D115/D118 의 5% mirror? default 제안 =
     **5% mirror** (round 간 일관성)

2. **#2 후보 (Bio) picked 시**:
   - option (a) ECG QRS prediction vs option (b) Durbin §2.3 sequence
     alignment? default 제안 = **option (a) ECG QRS** (real biological
     signal · prediction shape · Sleep-EDF mirror) — 단 `qrs_detector.
     hexa` 신설 필요 시 option (b) 의 `pilot-bio_align_nw` 36/36 reuse
     (zero substrate cost · discrete-exact shape) 가 critical-path 우위
   - 새 `BioVerifyRecord.swift` schema — `hexaNativeParity` +
     `measuredOracle` 둘 다 from-start? default 제안 = **둘 다**
     (Energy/Aura/Ufo 의 evolved shape mirror)

3. **#3 후보 (Chem) picked 시**:
   - substrate floor weakness (`pilot-chem_arrhenius` self-test-only)
     를 어떻게 honest disclose? default 제안 = D-block body 에 "Stage-0
     scaffolding floor · NIST/Cantera external oracle 가 본 round 의
     first parity-oracle land = chem Stage-0 → Stage-2 promotion" 명시 +
     `scopeCaveats` entry
   - NIST WebBook vs Cantera reference oracle? default 제안 = **NIST
     evaluated kinetics** (literature A/Ea · anonymous-ish open access)

4. **κ-71 G40 design.md D-block 번호**: **D120** (D119 = κ-70 G37
   직후 자연 순서 · 본 horizon-scaffold 자체는 D-block 미생성 — κ-68/
   κ-69/κ-70 scaffold 도 D-block 없이 land · D-block 은 G40 cell pick
   시점 land). `grep -nE '^### Decision [0-9]+' design.md | tail -1`
   확인 = D119 마지막 → 다음 D120.

## Cross-references

- ARCH.md §11.6 Round 10 G39..G42 block (본 horizon-scaffold)
- ARCH.md §11.5 Round 9 G35..G38 (κ-70 R9 4/4 CLOSURE LANDED `e818218`) — direct mirror template
- ARCH.md §11.4 Round 8 G31..G34 (κ-69 R8 4/4 CLOSURE) · Round 7 G27..G30 (κ-68 R7 5/5 CLOSURE) — grandparent templates
- design.md D109 (κ-68 G27 land · solar · 5-fold lock-in template) · D110 (κ-68 G29 first-flip · **prediction shape** · Energy/wind 후보의 mirror)
- design.md D115 (κ-69 G32 land · Aura) · D117 (κ-69 G33 first-flip · numeric-equivalence shape)
- design.md D118 (κ-70 G36 land · Ufo) · D119 (κ-70 G37 first-flip · numeric-equivalence shape · 본 note 의 직접 parent)
- design.md D106 (`.illustrativePhysics` GateType · Fusion mc_transport + Ufo Stage-4..7 carve-out · `FusionVerifyRecord` 영구-잠김 gate)
- design.md D103 (dimension-separation · `absorbed` stored vs `hexaNativeParity` substrate-parity) · D86 (no hardcoded data) · D80 (endpoint rule) · D114 (stdlib SSOT hexa-lang only) · D116 (sibling repos docs only)
- `inbox/notes/2026-05-22-k70-horizon-candidate-research.md` (κ-70 G36 candidate-digest · 본 note 의 직접 template · Candidate B/C carry)
- `inbox/notes/k69-g32-candidate-research-2026-05-21.md` (κ-69 G32 grandparent template)
- `domains/PILOTS.demi` `[pilot-bio_align_nw]` (36/36 PASS @ rel_err=0 · Bio option-b floor) · `[pilot-chem_arrhenius]` (6/6 self-test · Stage-0 · Chem floor) · `[pilot-dft_naive]` (17/17 · Bio option-a partial floor) · (`pilot-power_curve` **부재** · Energy/wind substrate floor ZERO)
- `domains/energy.md` (solar/wind sub-cell) · `domains/bio.md` (D81 · sibling docs-only) · `domains/chem.md` (D81 · prereq=matter · sibling planned)
- `cockpit/Sources/DemiurgeCore/Models/EnergyVerifyRecord.swift` (재사용 carrier) · (`BioVerifyRecord.swift` · `ChemVerifyRecord.swift` not-yet) · `FusionVerifyRecord.swift` (`[HP][✗]` D106-locked · 유일 잔여 1-field 후보지만 illustrative)
- `cockpit/Sources/DemiurgeCore/Models/MeasuredOracleRef.swift` (G28 schema · `4a1a087` · κ-71 G41 재사용 · 4th record-type instance)
- PLAN.md κ-70 R9 closure entry (2026-05-22 `## 진행 로그`) — 'next horizon (κ-71+)' 4-item list (G37-β real JET raw · plasmapy bridge · ω_p/Larmor/ln Λ port · **다른 cell measured-oracle round** [Energy/wind · Bio/ECG · Chip §B Tier]). 본 note 의 candidate cluster 가 그 4번째 line item 의 finalists

## Next pickup

User review → 1 candidate pick → design.md D120 entry 박제 (D118
mirror style · 5-fold lock-in 명시) → ARCH §11.6 G40 `[ ]` → `[x]`
flip with first-land cite block. Code 변경 0 (decision gate only ·
G41 가 first-flip cycle · #1 Energy/wind 채택 시 substrate kernel
land 가 G40↔G41 사이 별 cycle).

## g3 honest invariants

- 본 note 는 **decision 가이드 only** · 어떤 cell 의 `absorbed=true` 도 flip 안 함
- 본 note 는 ranking 제안 만 · user 의 명시 pick 전에는 D120 D-block 박제 금지 (decision 미수행)
- κ-70 G36 candidate-research note 의 Candidate B (Energy/wind) + C (Bio/ECG) 는 κ-71 carry · 두 후보의 5-fold lock-in 본문은 그 노트의 evolved 갱신 (4th-cell framing + 새 substrate-floor fact: `pilot-bio_align_nw` 7→36/36 · `pilot-power_curve` 부재 confirmed · `pilot-chem_arrhenius` Stage-0 self-test-only 명시)
- **κ-71 structural inflection 박제**: lowest-friction 1-field-extension carrier 가 κ-70 으로 소진 (`FusionVerifyRecord` 만 잔여 `[HP][✗]` 이나 D106 illustrative 영구-잠김) · 모든 κ-71 후보가 record-side 또는 substrate-side 신설 cost 를 짐
- D106 illustrative-physics gate 적용 cell (Fusion `mc_transport` · Ufo Stage-4..7 propulsion · RFC 013 §6.12 anti-conflation) 은 본 round 의 `absorbed` flip 후보에서 **명시 제외**
- D95 computed projection (substrate-parity `isHexaNativeAbsorbed`) 만으로 만족하는 cell 은 **measurement-parity 아님** — κ-71 의 점이 아님
- D106 illustrative cell (mc_transport · Ufo Stage-4..7) 는 candidate 에서 제외 — 본 note 의 3 finalist 모두 non-illustrative measurement axis
- ChipAnalyze (chip §B substrate-axis · §12.1 active in `~/core/hexa-lang` · 다른 agent · cross-axis 충돌 회피) 는 본 round 의 scope 외 ([[feedback-parallel-agent-cap]] — 본 cycle 은 Track 26 iter-2e + Track 27 PR #276 와 병행 = 3 total)
