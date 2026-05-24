# κ-70 horizon candidate research — 3rd cell 5-fold lock-in OPTIONS

> **status**: scaffold-open · 2026-05-22 (post-κ-69 R8 4/4 CLOSURE
> same-cycle)
>
> ARCH.md §11.5 Round 9 G36 의 pre-code decision gate (κ-68 G27 / κ-69
> G32 와 동형) 의 *candidate digest*. User pick 전 단계의 anchor —
> 본 note 는 3 후보 cell 의 5-fold lock-in dimension (cell / external
> oracle / bridge stack / hexa-native scope / PASS criterion) 을
> articulate. 결정은 user 가 다음 engagement 에서 수행 — 본 agent 는
> RANK 만 제안.
>
> **κ-69 G32 research note** (`inbox/notes/k69-g32-candidate-research-
> 2026-05-21.md`) 의 직접 successor. 그 노트의 Candidate B (Energy/wind)
> + Candidate C (Ufo/plasma) 가 *그대로* 3rd cell 후보로 carry —
> Candidate A (Aura/EEG) 는 κ-69 G33 으로 picked & landed (D115 / D117).
> 본 노트 = 그 둘 + 새 finalist 1 (Bio/seq-alignment) 의 3-way 비교.

## 5-fold lock-in (G27 / G32 pattern · D109 / D115 reference)

| dimension | κ-69 G33 reference (Aura/EEG · D115/D117) |
|---|---|
| cell | `AuraVerifyRecord` (cockpit · `hexaNativeParity` + `measuredOracle` 둘 다 carrier) + `domains/aura.md` EEG signal-proc 경로 |
| external oracle | PhysioNet **Sleep-EDF Expanded** · 153 PSG · 100 Hz EEG Fpz-Cz · 30-s epochs · anonymous wget |
| bridge stack | `stdlib/aura/sleep_edf_fetcher.py` + `sleep_edf_measured_oracle.py` (MNE-Python Welch boxcar single-segment trusted) → hexa-native `dft_naive.hexa` |
| hexa-native scope | `stdlib/kernels/signal_proc/dft_naive.hexa` (`pilot-dft_naive` 17/17 PASS @ rel_err ≤ 1e-12) · alpha-band 8-13 Hz integrated PSD axis |
| PASS criterion | `mean_rel_err ≤ 0.05` on alpha-band integrated power over N=100 30-s epochs — D117 result `8.40e-07` (~5 orders below threshold · numeric-equivalence PASS shape) |

## Candidate 분석 (3 finalist · D106 illustrative 제외 후보 우선)

### Candidate A — Ufo / plasma Stage-2 (ITER IMAS / JET pulse archive · λ_D · plasma_metrics)

| dimension | proposal |
|---|---|
| **cell** | `UfoVerifyRecord` (cockpit · 이미 존재 · `hexaNativeParity` carrier · `measuredOracle` field 없음 → G37 schema 확장 1 field 추가 = AuraVerifyRecord κ-69 G33 mirror) + `domains/ufo.md` Stage-2 (sister-substrate fusion cross-link · NOT Stage-4..7 warp/wormhole/dim) |
| **external oracle** | 후보 = (a) ITER **IMAS** open release (2025 신규 · UDA REST · 토카막 plasma profile DB), (b) JET pulse archive open subset (single mid-Ohmic shot · n_e + T_e timeseries), (c) public NSTX-U Langmuir-probe diagnostic snapshot. 모두 plasma_metrics (λ_D · ω_p · Larmor radius) 의 측정 oracle. default 제안 = **JET open-pulse archive mid-Ohmic single shot** (auth burden 가장 낮음 · solar G29 의 single-day mirror) |
| **bridge stack** | (신설) JET pulse data fetcher `stdlib/fusion/jet_pulse_fetcher.py` (HTTP + parse) → bridge-trusted ITER IMAS-like data shape adapter → hexa-native `stdlib/kernels/plasma/plasma_metrics_kernel.hexa` (`pilot-plasma_metrics` 41/41 PASS bit-exact). bridge = data-to-kernel-args adapter (단순) |
| **hexa-native scope** | `stdlib/kernels/plasma/plasma_metrics_kernel.hexa` (NRL Formulary p.34 · `pilot-plasma_metrics` 41/41 PASS @ rel_err=0.0 IEEE-754 bit-exact). 측정 axis = **λ_D = sqrt(ε₀ k_B T_e / (n_e e²))** 의 측정 n_e / T_e 입력 → modeled λ_D output 의 measured-oracle 일치 |
| **PASS criterion** | `mean_rel_err ≤ 0.05` over N=50 JET pulse mid-Ohmic stationary timesteps. **CAVEAT**: plasma_metrics 는 *formula evaluation* 이지 *prediction* 아님 — 측정 n_e/T_e → λ_D 계산 결과 의 measured-oracle 대비 가 다소 trivial (formula-as-algorithm honesty floor 약함). G33 의 numeric-equivalence shape (D117) 와 동형 PASS shape 이 될 가능성 — *prediction* shape 의 D110 mirror 는 아니라는 honest disclosure 필요 |

**G37 schema cost** (κ-69 G33 mirror): `UfoVerifyRecord.swift` 에 `measuredOracle: MeasuredOracleRef?` field 1 줄 + JSON CodingKey 1 줄 추가. 새 record 생성 불필요. XCTest invariant auto-extension test (`testUfoVerifyRecordCoveredByInvariantNoCodeChange`) 50-line 추가 (G33 AuraVerifyRecord 패턴 1:1 mirror — invariant helper code 변경 0).

**ranking factors**:
- D106 gate **partial** — Ufo Stage-2 (sister-substrate fusion plasma diagnostic) 만 non-illustrative. Stage-4..7 (warp/wormhole/dim/use) 은 명시 D106 illustrative 제외 carve-out — note 박제 + D-block body 에 명시 필요 (D115 의 Ufo reject reason 의 carry-over disclosure)
- substrate-parity 이미 PASS (`pilot-plasma_metrics` 41/41 bit-exact — `pilot-dft_naive` 17/17 보다 더 강한 substrate floor)
- bridge stack 신설 필요 (JET archive fetcher · IMAS UDA REST 의 2025 신규 access pattern 불확실)
- "formula evaluation vs prediction" 의 ambiguity — measured-oracle 의 prediction-shape honesty 가 G29 solar (modeled GHI vs measured GHI prediction) 보다 약함. G33 (D117) 의 numeric-equivalence shape 와 동형이라 본 카테고리에선 acceptable
- G37 schema-extension audit payoff = third-record-type land (κ-69 G33 second-record AuraVerifyRecord 의 자연 다음 step · `invariantHolds` shape 의 record-type-agnostic 설계 가 third carrier 에서도 0-code-change 확장하는지 audit)
- `domains/ufo.md` Stage-2 narrative 가 ITER/JET cross-link 명시 — context 정합

---

### Candidate B — Energy / wind sub-cell (NREL Wind Toolkit · IEC 61400-12 power curve)

| dimension | proposal |
|---|---|
| **cell** | `EnergyVerifyRecord` 재사용 (이미 `measuredOracle` field carrier · G29 1st carrier) + producer side 에 wind-power 경로 신설. **OR** 새 `EnergyWindVerifyRecord.swift` (Energy 가 multi-sub-cell domain 이라 separation 이 깔끔 · G37 schema-generalization payoff 강화). default 제안 = **새 record** (sub-cell separation + third-record-type audit) |
| **external oracle** | NREL **Wind Toolkit (WTK)** · 5-min cadence · 100 m hub-height · 7-year 2007-2013 archive · CONUS 2-km grid. HSDS REST API public access (NREL token 필요 = anonymous 아님 · solar MIDC 보다 한 단계 약함). 측정 = single turbine site power-curve 대 modeled wind→power |
| **bridge stack** | (신설) `stdlib/energy/wtk_fetcher.py` (HSDS REST adapter · auth header pass-through) → `stdlib/energy/_wind_power_curve_batch.hexa` (hexa-native IEC 61400-12 power curve · solar G31b `_solar_position_batch.hexa` 의 sibling). pvlib equivalent = `windpowerlib` (오픈소스 community-validated) |
| **hexa-native scope** | **새 kernel 필요**: `stdlib/kernels/wind/power_curve_kernel.hexa` (IEC 61400-12 reference power curve + air-density correction Betz limit + Weibull integration). 현재 wind/aero kernel 없음 — G35 (cell pick) 가 G31 mirror substrate-side 새 라운드 trigger (1-3 session est) |
| **PASS criterion** | `mean_rel_err ≤ 0.05` over `wind_speed ∈ [4, 25] m/s` (cut-in to cut-out · operational regime filter · solar 의 daylight filter mirror). prediction-shape = modeled wind→power 대 measured turbine output (G29 solar 의 modeled GHI vs measured GHI 와 동형 prediction axis) |

**G37 schema cost**: EnergyVerifyRecord 재사용 시 0; 새 `EnergyWindVerifyRecord` 시 ~30 줄 (`EnergyVerifyRecord` 1:1 mirror) + CodingKeys + memberwise init + tests.

**ranking factors**:
- D106 clean (real wind data · IEC reference curve · illustrative 아님 · prediction-axis honesty 강함 G29 mirror)
- bridge stack + hexa-native kernel **둘 다 신설 필요** — substrate-side cost = G31 mirror scale (1-3 session) · κ-70 round 의 G35 + G36 단계 가 합쳐 G27/G32 보다 더 무거움
- κ-70 G37 (first-flip) deps 가 substrate kernel 신설 완료 후 → critical-path length 가 κ-68/κ-69 보다 1 step 길어짐 (G31 G29-β port 와 유사한 mid-round bridge land cycle 필요)
- NREL WTK HSDS API token 필요 = honesty floor 가 solar MIDC anonymous wget 보다 한 단계 약함 — record 의 `dataset_caveats` 에 명시 disclosure 필요
- G37 schema-generalization payoff 강함 (새 record type = third-record-type audit · `invariantHolds` record-type-agnostic 검증의 third instance)
- prediction-shape 강함 (G33 D117 의 numeric-equivalence PASS shape 약점 보완 — κ-70 의 PASS 가 prediction shape 으로 다시 elevate)
- domains/energy.md sub-cell 구조 강화 (solar / wind 분리 narrative)

---

### Candidate C — Bio / sequence-alignment NW (PhysioNet ECG 또는 Durbin §2.3 textbook fixture)

| dimension | proposal |
|---|---|
| **cell** | **새 `BioVerifyRecord.swift`** (cockpit · 현재 미존재 — κ-70 G35 schema cost 의 first-record-type carrier 신설 · ~40 줄 EnergyVerifyRecord 1:1 mirror + hexaNativeParity + measuredOracle 둘 다 from-start carry) + `domains/bio.md` (이미 존재 · T3 .py→.hexa port WEAVE 상태 — D80 pilot 박힘) |
| **external oracle** | 후보 = (a) PhysioNet **MIT-BIH Arrhythmia Database** (48 ECG record · 360 Hz · open · CC-BY · anonymous wget) — QRS detection / R-peak interval 의 measured oracle. (b) **Durbin §2.3 textbook fixture** (7 sequence pair · `pilot-bio_align_nw` 이미 PASS) — *textbook fixture as oracle* (D106 partial — clean-room reference 가 *real biological data* 아님 → measured-oracle shape 약함). default 제안 = **(a) MIT-BIH ECG** (real biological signal · prediction shape 강함) |
| **bridge stack** | (신설) `stdlib/bio/mitbih_fetcher.py` (PhysioNet anonymous-HTTPS · Aura sleep_edf_fetcher 1:1 mirror · D86 floor · CLI/env-var) → `stdlib/bio/qrs_detector_measured_oracle.py` (4-stage producer · MNE-like substrate-parity trusted bridge → hexa-native batch → JSON emit with absorbed gate · G33 sleep_edf_measured_oracle.py mirror) → hexa-native `stdlib/kernels/bio_align/needleman_wunsch_kernel.hexa` (linear gap · `pilot-bio_align_nw` PASS 7 textbook pairs). **CAVEAT**: NW kernel 은 sequence-alignment axis · ECG 의 QRS detection 은 signal-proc axis — bridge mismatch. 본 후보 honestly disclose: **NW kernel 은 ECG QRS axis 와 다른 algorithm** → option (i) ECG oracle 채택 시 hexa-native scope 신설 (`stdlib/kernels/signal_proc/qrs_detector.hexa` 새 kernel · Pan-Tompkins 1985 algorithm) · option (ii) Durbin §2.3 fixture oracle 채택 시 sequence-alignment axis 일치 |
| **hexa-native scope** | option (i) ECG QRS detection — **새 kernel 신설** `stdlib/kernels/signal_proc/qrs_detector.hexa` (Pan-Tompkins band-pass filter + derivative + squaring + integration + threshold · `pilot-dft_naive` 17/17 PASS substrate-parity floor reuse 가능). option (ii) sequence-alignment — `pilot-bio_align_nw` (Needleman-Wunsch linear gap · 7 textbook pair PASS 이미 land) reuse |
| **PASS criterion** | option (i) `mean_rel_err ≤ 0.05` on R-peak interval (RR-interval ms) over N=100 randomly-sampled QRS events from MIT-BIH record `mitbih_100`. option (ii) `mean rel_err = 0` (integer DP score · `pilot-bio_align_nw` 의 textbook fixture 7 pair 의 *score field* 대 oracle score) — **discrete integer algorithm 이라 G33 의 floating-point numeric-equivalence shape 와 다른 honest shape** (rel_err=0 exact match) |

**G37 schema cost**: 새 `BioVerifyRecord.swift` ~40 줄 (EnergyVerifyRecord 1:1 mirror with `hexaNativeParity` + `measuredOracle` 둘 다 from-start) + CodingKeys + memberwise init + tests + XCTest invariant auto-extension test ~50 줄 = ~120 줄 schema land. κ-69 G33 의 AuraVerifyRecord (이미 존재) 보다 작업량 더 많음.

**ranking factors**:
- D106 clean — bio domain 의 measurement axis 는 *real biological signal* (ECG QRS) · illustrative 적용 안 됨
- substrate-parity 이미 PASS (`pilot-bio_align_nw` 7 textbook pair PASS · `pilot-dft_naive` 17/17 reuse 가능)
- bridge stack 신설 필요 (`mitbih_fetcher.py` · `qrs_detector_measured_oracle.py` · sleep_edf 패턴 1:1 mirror 라 작업 낮음 estimated 0.5-1 session)
- cockpit `BioVerifyRecord` 신설 = 작업 더 무거움 (vs Aura/Ufo 의 1-field 확장)
- bio domain narrative 가 D80 pilot WEAVE 상태 — substrate sibling `~/core/hexa-bio/` D116 으로 docs-only · 모든 substrate code = hexa-lang/stdlib/bio/ ONLY (이미 정합)
- option (i)/(ii) split 의 honest disclosure 필요 — kernel scope 정렬이 oracle 과 axis-match 여야
- "first NEW DOMAIN cell" signal (κ-68=Energy, κ-69=Aura, κ-70=Bio 의 3-domain progression) · GOAL.md 의 multi-domain coverage 강화
- prediction-shape 가능 (option (i)) 또는 discrete-exact (option (ii)) — 둘 다 G33 numeric-equivalence shape 다른 honest shape 제공

---

## 비교 표

| factor | Ufo/plasma (A) | Energy/wind (B) | Bio/ECG (C) |
|---|---|---|---|
| D106 clean | partial (Stage-2 only · Stage-4..7 carve-out 필요) | yes | yes |
| substrate-parity PASS | yes (`pilot-plasma_metrics` 41/41 bit-exact) | NO (kernel 신설 1-3 session) | yes (`pilot-bio_align_nw` 7 textbook OR `pilot-dft_naive` reuse) |
| bridge stack 존재 | partial (kernel 있고 fetcher 신설) | NO (둘 다 신설) | NO (Aura sleep_edf 1:1 mirror — 0.5-1 session) |
| cockpit record 존재 | yes (`UfoVerifyRecord` · 1-field 확장) | yes (재사용) or 신설 (~30줄) | NO (`BioVerifyRecord` 신설 ~40 줄) |
| dataset access | partial (JET archive · IMAS 2025 신규 access 불확실) | NREL HSDS token 필요 | trivial (PhysioNet anonymous wget) |
| G37 schema-extension payoff | high (3rd record type · `invariantHolds` audit 3rd instance) | high (3rd record type if 새 record) or low (재사용) | very high (NEW DOMAIN + 3rd record type) |
| prediction-shape honesty | weak (formula on measured inputs · D117 numeric-equivalence shape) | strong (modeled wind→power · G29 mirror) | strong (R-peak prediction) or discrete-exact (alignment) |
| critical-path length | short (1 session est · G36→G37 같은 cycle 가능) | long (G35→G36→substrate kernel land→G37 = 3-step) | medium (record type 신설 cost · bridge stack mirror) |

## RANK 제안 (user 가 결정 · 본 agent 는 advisory only)

- **#1: Ufo / plasma Stage-2 (Candidate A)**
  - **5 dimension "이미 있음" check 가 가장 깔끔**: substrate kernel ✓ (`pilot-plasma_metrics` 41/41 bit-exact — 17/17 dft_naive 보다 강함) · cockpit record ✓ (`UfoVerifyRecord` · 1-field 확장 = Aura G33 mirror) · bridge stack partial ✓ (kernel + fetcher 신설만) · κ-69 G33 schema land 패턴 1:1 mirror (XCTest invariant auto-extension test 3rd carrier audit · 최저 friction). **dataset access** 가 약점 — JET pulse archive default 채택 시 anonymous access 가능 후보 있음
  - Stage-4..7 (warp/wormhole/dim/use) D106 illustrative carve-out **명시 disclosure 필요** (G36 D-block body 에 "본 land 는 Stage-2 sister-substrate fusion cross-link axis 만 · Stage-4..7 은 RFC 013 §6.12 anti-conflation 유지 · scopeCaveats array 에 명시" cite)
  - **prediction-shape honesty 약함** — formula evaluation (measured n_e/T_e → modeled λ_D) 이라 G33 D117 의 *numeric-equivalence PASS shape* 와 동형 (D110 *predict-vs-measure PASS shape* 아님). 본 weakness 는 acceptable — κ-69 closure entry 가 "κ-70+ Hann/Welch hexa-native port" 를 prediction-axis elevate path 로 cite (즉 κ-70 자체는 prediction shape elevate 미요구)
  - "G37 = 3rd record type schema-extension audit" 가 κ-69 G33 의 자연 다음 step — `invariantHolds(absorbed, measuredOracle, isIllustrativePhysics)` shape 의 record-type-agnostic 설계의 *3rd instance* 검증

- **#2: Energy / wind (Candidate B)**
  - prediction-shape 가 가장 강함 (G29 solar 의 modeled-vs-measured shape 1:1 mirror) · D106 clean · D33 schema-generalization payoff 강함 (새 record type 채택 시)
  - 그러나 substrate kernel 신설 (`stdlib/kernels/wind/power_curve_kernel.hexa`) 가 dependency · κ-70 critical-path = G35 (cell pick) → G36 (substrate kernel + bridge stack land · 1-3 session) → G37 (first-flip) = κ-68/κ-69 보다 1-step 더 길어짐. NREL WTK HSDS token honesty floor weakness
  - 이 후보가 #1 으로 올라가려면 "prediction-axis honesty elevate" 가 κ-70 의 명시 목표여야 — κ-69 closure entry 의 "κ-70+ next horizon" 후보 4 가지 중 하나 (Hann/Welch port · Cooley-Tukey FFT · 다른 cell · multi-subject aggregate) 의 첫번째 (prediction-axis elevate) 와 alignment 강함

- **#3: Bio / ECG (Candidate C)**
  - "first NEW DOMAIN cell" signal 강함 (3-domain progression) · trivial dataset access (PhysioNet anonymous wget = solar MIDC + sleep-edf 와 동형 floor) · bridge stack 작업 낮음 (Aura sleep_edf 1:1 mirror)
  - 그러나 cockpit `BioVerifyRecord` 신설 = 작업 가장 무거움 · option (i)/(ii) bridge axis-match honest split 필요 · κ-68/κ-69 의 "schema 재사용 / 1-field 확장" 패턴과 가장 멀리 벗어남
  - 이 후보가 #1 으로 올라가려면 "new-record-type land 의 schema audit" 가 κ-70 의 명시 목표여야 — κ-69 G33 의 "second-record-type audit" 의 자연 다음 (`BioVerifyRecord` 가 *3rd record type 이자 from-start carrier* 라 invariant audit shape 가 약간 다름) 인데 그 추가 audit dimension 의 가치가 critical-path length 보다 우선일 때만

## 주요 trade-off

1. **schema 재사용 friction vs new record type signal**: Ufo (1-field 확장 · κ-69 mirror 최저 friction) < Energy/wind (재사용 가능 · 새 record 도 가능) < Bio (새 record 필수 · NEW DOMAIN signal). κ-69 G33 의 lowest-friction principle 유지하려면 Ufo > Energy/wind > Bio
2. **prediction-axis honesty vs numeric-equivalence honesty**: G29 solar = prediction (강함). G33 Aura = numeric-equivalence (D110 와 다른 shape 의 honest disclosure 명시). κ-70 의 honest shape 선택:
   - Ufo λ_D = numeric-equivalence (formula evaluation · G33 mirror)
   - Energy/wind = prediction (G29 mirror · honesty floor elevate)
   - Bio ECG = prediction OR discrete-exact (alignment)
3. **critical-path length (κ-70 R9 4/4 close time)**: Ufo (G35+G36+G37 = 1-2 session) < Bio (G35+G36+G37 = 2-3 session · record 신설 cost) < Energy/wind (G35+substrate-kernel-G36+G37 = 3-5 session · G31 mirror)
4. **dataset access overhead**: PhysioNet (anonymous wget) < NREL MIDC (anonymous · solar G29 reference) < JET pulse archive (partial anonymous · IMAS 2025 신규 access 불확실) < NREL Wind Toolkit (HSDS token)
5. **invariant-helper audit signal**: 1st (D110 Energy)→2nd (D117 Aura)→3rd (κ-70 G37 record-type-agnostic audit). 3rd carrier 가 같은 0-code-change 패턴 확인되면 `invariantHolds` shape 의 generalization 완성 (κ-68 G30 Stage 1 의 record-type-agnostic 설계의 strongest evidence)

## User 가 lock-in 시 답해야 할 open question

1. **#1 후보 (Ufo/plasma) picked 시**:
   - JET vs IMAS vs NSTX-U — 어느 dataset? default 제안 = **JET open-pulse archive mid-Ohmic single shot** (anonymous access 가능 + dataset stability 검증된)
   - Stage-4..7 명시 carve-out 의 disclosure shape — design.md D-block body 명시 + `UfoVerifyRecord.scopeCaveats` array 에 entry 추가? default 제안 = **양쪽 다** (D-block body 가 carve-out narrative · scopeCaveats 가 record-level enforcement)
   - PASS criterion threshold — D109 / D115 의 5% mirror (G29 / G33 동형) 또는 plasma-metrics 의 bit-exact 41/41 substrate-parity floor 를 *measurement* axis 에 보유 (rel_err ≤ 1e-12)? default 제안 = **5% mirror** (κ-68/κ-69 동형 일관성 우선)

2. **#2 후보 (Energy/wind) picked 시**:
   - `EnergyVerifyRecord` 재사용 vs 새 `EnergyWindVerifyRecord`? default 제안 = **새 record** (G37 schema-generalization payoff 강화 · sub-cell separation)
   - 새 `stdlib/kernels/wind/power_curve_kernel.hexa` 의 G35 partial-land 처리 — κ-70 R9 의 첫 G item (e.g. G35a substrate kernel + G35b producer integration) 으로 split? default 제안 = **G36 (cell pick) 이전 별 cycle 의 G31-mirror partial-land** (G35 cell pick → 별 cycle 의 substrate kernel land → G36 producer wire → G37 first-flip · κ-69 G31 의 partial-land 패턴 mirror)
   - NREL WTK HSDS token 의 honesty floor (auth 필요 = solar MIDC 의 anonymous 보다 한 단계 약함) record disclosure shape? default 제안 = `MeasuredOracleRef.datasetCaveats` array 에 entry "requires NREL WTK HSDS API token (not anonymous)"

3. **#3 후보 (Bio/ECG) picked 시**:
   - option (i) ECG QRS prediction vs option (ii) Durbin §2.3 sequence alignment? default 제안 = **option (i) ECG QRS** (real biological signal · prediction shape 강함 · Sleep-EDF mirror)
   - 새 `BioVerifyRecord.swift` schema shape — `hexaNativeParity` + `measuredOracle` 둘 다 from-start? default 제안 = **둘 다** (EnergyVerifyRecord 의 evolved shape mirror · κ-68 G29 의 1-field-at-a-time growth 보다 한 단계 evolved)
   - 새 `stdlib/kernels/signal_proc/qrs_detector.hexa` 신설 vs `dft_naive.hexa` reuse? default 제안 = **신설** (Pan-Tompkins QRS detection axis · ECG signal 의 axis-match 필요)

4. **κ-70 G36 design.md D-block 번호**: D118 (κ-69 G33 D117 직후 자연 순서 · 본 horizon-scaffold 자체는 D-block 미생성 — κ-68/κ-69 의 scaffold opening 도 D-block 없이 land · D-block 은 G36 cell pick 시점 land)

## Cross-references

- ARCH.md §11.5 Round 9 G35..G38 block (본 horizon-scaffold)
- ARCH.md §11.4 Round 8 G31..G34 (κ-69 R8 4/4 CLOSURE LANDED) — direct mirror template
- ARCH.md §11.4 Round 7 G27..G30 (κ-68 R7 5/5 CLOSURE LANDED) — original template
- design.md D109 (κ-68 G27 land · solar · 본 후보 5-fold lock-in template) · D110 (κ-68 G29 first-flip · prediction-shape PASS)
- design.md D115 (κ-69 G32 land · Aura · 본 후보 mirror) · D117 (κ-69 G33 first-flip · numeric-equivalence shape)
- design.md D106 (`.illustrativePhysics` GateType · Ufo Stage-4..7 carve-out gate)
- design.md D103 (dimension-separation docstring · `absorbed` stored vs `hexaNativeParity` substrate-parity)
- design.md D116 (sibling repos = docs only · bio substrate code = hexa-lang/stdlib/bio/ ONLY)
- `inbox/notes/k69-g32-candidate-research-2026-05-21.md` (κ-69 G32 의 candidate-digest · 본 note 의 template) — 그 노트의 Candidate B + C 가 κ-70 carry
- `inbox/notes/k68-cell-pick-2026-05-21.md` (κ-68 G27 의 candidate-digest 의 grand-parent template)
- `domains/PILOTS.demi` `[pilot-plasma_metrics]` (41/41 PASS · Ufo bridge substrate-parity floor) · `[pilot-bio_align_nw]` (7 textbook PASS · Bio NW bridge floor) · `[pilot-dft_naive]` (17/17 PASS · 기존 Aura bridge · ECG QRS 도 가능한 reuse path)
- `domains/ufo.md` (Stage-2 sister-substrate fusion narrative) · `domains/bio.md` (D80 pilot WEAVE · sibling docs-only D116)
- `cockpit/Sources/DemiurgeCore/Models/UfoVerifyRecord.swift` (1-field 확장 carrier) · `EnergyVerifyRecord.swift` (재사용 가능 carrier) · (`BioVerifyRecord.swift` not-yet)
- `cockpit/Sources/DemiurgeCore/Models/MeasuredOracleRef.swift` (G28 schema · `4a1a087` · κ-70 G37 재사용)
- κ-69 PLAN.md closure entry (`## 진행 로그` 2026-05-22) — `next horizon (κ-70+)` 4 후보 cite (Hann/Welch port · Cooley-Tukey FFT · 다른 cell · multi-subject aggregate). 본 note 의 candidate cluster (Ufo · Energy/wind · Bio) 가 "다른 cell measured-oracle round" line item 의 finalists

## Next pickup

User review → 1 candidate pick → design.md D118 entry 박제 (D115 mirror style · 5-fold lock-in 명시) → ARCH §11.5 G36 `[ ]` → `[x]` flip with first-land cite block. Code 변경 0 (decision gate only · G37 가 first-flip cycle).

## g3 honest invariants

- 본 note 는 **decision 가이드 only** · 어떤 cell 의 `absorbed=true` 도 flip 안 함
- 본 note 는 ranking 제안 만 · user 의 명시 pick 전에는 D118 D-block 박제 금지 (decision 미수행)
- κ-69 G32 candidate-research note 의 Candidate B (Energy/wind) + Candidate C (Ufo/plasma) 는 κ-70 carry · 두 후보의 5-fold lock-in 본문은 그 노트의 evolved 갱신 (3rd-cell framing + κ-69 G33 mirror invariants 반영)
- D106 illustrative-physics gate 적용 cell (Fusion `mc_transport` · Ufo Stage-4..7 propulsion · RFC 013 §6.12 anti-conflation) 은 본 round 의 `absorbed` flip 후보에서 **명시 제외**
- D95 computed projection (substrate-parity `isHexaNativeAbsorbed`) 만으로 만족하는 cell 은 **measurement-parity 아님** — κ-70 의 점이 아님
- ChipAnalyze (chip §B substrate-axis · §12.1 active work in `~/core/hexa-lang` · 다른 agent · cross-axis 충돌 회피) 는 본 round 의 scope 외
