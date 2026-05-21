# κ-69 G32 cell-pick candidate research — 5-fold lock-in OPTIONS

> **status**: pickup-open · 2026-05-21
>
> ARCH.md §11.4 Round 8 G32 의 pre-code decision gate (κ-68 G27 와
> 동형) 의 *candidate digest*. User pick 전 단계의 anchor — 본 note
> 는 3 후보 cell 의 5-fold lock-in dimension (cell / external oracle /
> bridge stack / hexa-native scope / PASS criterion) 을 articulate.
> 결정은 user 가 다음 engagement 에서 수행 — 본 agent 는 RANK 만 제안.

## 5-fold lock-in (G27 pattern · D109/D110 인용)

| dimension | κ-68 G29 reference (Energy/solar) |
|---|---|
| cell | `EnergyVerifyRecord` (cockpit) + `domains/energy.md` solar 경로 |
| external oracle | NREL MIDC SRRL Golden CO · pyranometer GHI · 2026-05-15 · 1-min · clear-sky day |
| bridge stack | `stdlib/energy/_solar_position_batch.hexa` (hexa-native) → `pvlib_clearsky.py` Ineichen (substrate-parity trusted) → `nrel_midc_pyranometer.py` (fetch + filter) |
| hexa-native scope | `stdlib/kernels/solar/solar_kernel.hexa` (21/21 PASS · sun-position axis) · `pilot-solar` |
| PASS criterion | `mean_rel_err ≤ 0.05` (clear-sky daylight filter · D110 = 0.04967 PASS) |

## Candidate 분석 (3 finalist · D106 illustrative 제외 후보 우선)

### Candidate A — Aura / wearable BCI (EEG · PhysioNet Sleep-EDF)

| dimension | proposal |
|---|---|
| **cell** | `AuraVerifyRecord` (cockpit · 이미 존재 · `hexaNativeParity` 있고 `measuredOracle` 없음 → schema 확장 1 field 추가만 필요) |
| **external oracle** | PhysioNet **Sleep-EDF Expanded** (open · CC-BY · 153 PSG records · 100 Hz EEG · Fpz-Cz/Pz-Oz channels). 후보 alt = MIT-BIH Arrhythmia (ECG, brain-EEG 보다 신호처리가 더 단순), BNCI Horizon 2020 motor-imagery sets. |
| **bridge stack** | `stdlib/aura/aura_mne.py` (이미 존재 · MNE-Python EEG signal-proc substrate adapter) → `stdlib/kernels/signal_proc/mne_psd_kernel.py` (이미 존재 · Welch PSD oracle-companion shape) → `stdlib/kernels/signal_proc/dft_naive.hexa` (hexa-native · `pilot-dft_naive` 17/17 PASS rel_err ≤1e-12). MNE-Python = substrate-parity trusted. |
| **hexa-native scope** | `stdlib/kernels/signal_proc/dft_naive.hexa` (naive O(N²) DFT · already landed). 측정 대상 = 단일 EEG 채널 의 power-spectral-density 의 dominant-frequency / band-power (delta/theta/alpha/beta/gamma 5-band). hexa-native sun-position-equivalent = "DFT spectral peak axis". MNE Welch PSD = substrate-parity trusted bridge. |
| **PASS criterion** | 후보: **(a)** `mean_rel_err ≤ 0.05` on **alpha-band (8-13 Hz) integrated power** across N=100 30-second eyes-closed REM/Wake epochs (solar G29 와 동형 5% 임계). **(b)** spectral-peak-frequency rel_err ≤ 0.02 (더 tight · 한 결과 axis 만). default 제안 **(a)**. |

**G33 schema cost**: `AuraVerifyRecord.swift` 에 `measuredOracle: MeasuredOracleRef?` field 1 줄 추가 (EnergyVerifyRecord 패턴 1:1 mirror) + JSON CodingKeys 1 줄. 새 record 생성 불필요.

**ranking factors**:
- D106 gate clean (signal-proc · physiological data · illustrative 아님)
- substrate-parity 이미 PASS (`pilot-dft_naive` 17/17)
- aura_mne.py bridge stack 이미 존재
- PhysioNet 은 wget/curl 직접 접근 가능 (auth 없음)
- AuraVerifyRecord 가 `latticeInvariant` 추가 field 있어 schema 가 조금 더 풍부 (downside: G33 schema extension 이 EnergyVerifyRecord 만큼 깔끔하진 않을 수 있음)

---

### Candidate B — Energy / wind sub-cell (NREL Wind Toolkit)

| dimension | proposal |
|---|---|
| **cell** | `EnergyVerifyRecord` 재사용 (이미 `measuredOracle` field carrier) + producer side 에 wind-power 경로 신설. **OR** 새 `EnergyWindVerifyRecord.swift` (Energy 가 multi-sub-cell domain 이라 separation 이 깔끔). |
| **external oracle** | NREL **Wind Toolkit (WTK)** · 5-min · 100 m hub-height · 7-year 2007-2013 archive · CONUS 2-km grid (publicly accessible via HSDS/REST API). 측정 = single turbine site power-curve 대 modeled wind→power. |
| **bridge stack** | (신설) `stdlib/energy/wtk_fetcher.py` (HSDS REST adapter) → `stdlib/energy/_wind_power_curve.hexa` (hexa-native wind→power IEC 61400-12 curve). pvlib equivalent = `windpowerlib` (오픈소스). |
| **hexa-native scope** | **새 kernel 필요**: `stdlib/kernels/wind/power_curve_kernel.hexa` (IEC 61400-12 reference power curve · air-density correction · Weibull integration). 현재 wind/aero kernel 없음 — G32 결정 = G31 가 substrate-side 작업 (κ-68 G31 mirror) 의 새 라운드 trigger. |
| **PASS criterion** | `mean_rel_err ≤ 0.05` over `wind_speed ∈ [4, 25] m/s` (cut-in to cut-out · operational regime filter, solar 의 daylight filter mirror). |

**G33 schema cost**: EnergyVerifyRecord 재사용 시 0; 새 `EnergyWindVerifyRecord` 시 ~30 줄 (EnergyVerifyRecord 1:1 mirror).

**ranking factors**:
- D106 clean (real wind data · IEC reference curve · illustrative 아님)
- bridge stack + hexa-native kernel **둘 다 신설 필요** — substrate-side cost 가 G31 mirror scale (1-3 session)
- "G33 = schema re-use" 의 본래 의도 (G27 schema generalization audit) 가 약간 희석 — EnergyVerifyRecord 두번째 풀-카리어 instance 는 *같은* record type 이라 second-record-type 확장 신호는 안 줌
- NREL Wind Toolkit HSDS API auth 필요 (NREL token); pvlib MIDC 같은 anonymous 직접접근 아님
- Schema-generalization payoff (다른 record type 에 schema 확장) 이 G33 의 명시 exit criterion — 본 후보는 그 axis 약함

---

### Candidate C — Ufo / plasma-stage non-illustrative (Stage-2 fusion · plasma_metrics)

| dimension | proposal |
|---|---|
| **cell** | `UfoVerifyRecord` (cockpit · 이미 존재 · `hexaNativeParity` 있고 `measuredOracle` 없음). `domains/ufo.md` 의 Stage-2 (fusion sister-substrate cross-link) 만 — Stage-4..7 (warp/wormhole/dim) 는 D106 illustrative 명시 제외 (closed-form theory only, falsifier OPEN). |
| **external oracle** | 후보 = ITER **IMAS** open release (2025 open-source) plasma profile DB (실 토카막 측정), OR JET pulse archive (open subset), OR public **NSTX-U** Langmuir-probe diagnostic snapshot. 모두 plasma_metrics (λ_D · ω_p · Larmor radius) 의 측정 oracle. 후보 dataset = "single JET shot, mid-Ohmic phase, electron density n_e + temperature T_e timeseries → λ_D vs hexa-native modeled λ_D". |
| **bridge stack** | (신설) IMAS UDA REST → `stdlib/fusion/imas_fetcher.py` (신설) → `stdlib/kernels/plasma/plasma_metrics.hexa` (hexa-native · 이미 `pilot-plasma_metrics` 41/41 PASS bit-exact). bridge = IMAS-data-to-kernel-args (단순). |
| **hexa-native scope** | `stdlib/kernels/plasma/plasma_metrics_kernel.hexa` (NRL Formulary p.34 · `pilot-plasma_metrics` 41/41 PASS at rel_err=0.0 IEEE-754 bit-exact). 측정 axis = λ_D = sqrt(ε₀ k_B T_e / (n_e e²)) 의 측정 n_e/T_e 입력 시 modeled output 의 측정 oracle 일치. |
| **PASS criterion** | `mean_rel_err ≤ 0.05` over N=50 JET pulse mid-Ohmic stationary timesteps. **CAVEAT**: plasma_metrics 는 *formula evaluation* 이지 *prediction* 아님 — 측정 n_e/T_e → λ_D 계산 결과의 measured-oracle 대비 가 다소 trivial (formula-as-algorithm). 진짜 prediction 평가는 BOUT++ 같은 SOL-turbulence sim 이 필요. |

**G33 schema cost**: `UfoVerifyRecord.swift` 에 `measuredOracle: MeasuredOracleRef?` field 1 줄 추가. AuraVerifyRecord 와 동일 비용.

**ranking factors**:
- D106 gate **partial** — Ufo Stage-2 만 non-illustrative (sister-substrate fusion cross-link). Stage-4..7 은 명시 제외 필요 — note 박제에 명시할 caveat.
- substrate-parity 이미 PASS (`pilot-plasma_metrics` 41/41 bit-exact)
- bridge stack 신설 필요 (IMAS UDA REST adapter)
- "formula evaluation vs prediction" 의 ambiguity — measured-oracle 의 정직성 floor 가 G29 solar 의 *modeled GHI vs measured GHI* 의 prediction shape 보다 약함
- IMAS open release 가 2025 신규 — dataset stability / access pattern 불확실

---

## 비교 표

| factor | Aura / EEG | Energy/wind | Ufo / plasma |
|---|---|---|---|
| D106 clean | yes | yes | partial (Stage-2 only) |
| substrate-parity PASS | yes (`pilot-dft_naive` 17/17) | NO (kernel 신설) | yes (`pilot-plasma_metrics` 41/41) |
| bridge stack 존재 | yes (`aura_mne.py`) | NO (둘 다 신설) | partial (kernel 있고 fetcher 신설) |
| cockpit record 존재 | yes (`AuraVerifyRecord`) | yes (`EnergyVerifyRecord` 재사용) or 신설 | yes (`UfoVerifyRecord`) |
| dataset access | trivial (PhysioNet wget anonymous) | NREL token 필요 | IMAS auth 불확실 |
| G33 schema-extension payoff | high (different record type) | low (same record type) | high (different record type) |
| prediction-shape honesty | strong (PSD on real EEG) | strong (power on real wind) | weak (formula on measured inputs) |

## RANK 제안 (user 가 결정 · 본 agent 는 advisory only)

- **#1: Aura / EEG (Candidate A)**
  - 모든 5 dimension 의 "이미 있음" check 가 가장 깔끔: bridge stack ✓ (aura_mne.py) · substrate kernel ✓ (`pilot-dft_naive`) · cockpit record ✓ (AuraVerifyRecord) · dataset trivial-access (PhysioNet anonymous wget) · G33 schema-extension audit 가 다른 record type 으로 확장되어 G27 generalization signal 강함.
  - solar G29 의 "single clear-sky day · 1-min cadence" 와 mirror 되는 shape = "single Sleep-EDF subject · 30-s epoch · alpha-band power".

- **#2: Ufo / plasma (Candidate C)**
  - substrate-parity 가 41/41 bit-exact 로 가장 강력. 그러나 measured-oracle 의 prediction-shape 약함 (formula evaluation) + Stage-4..7 illustrative carve-out 명시 필요 + IMAS access 불확실.
  - 이 후보가 #1 으로 올라가려면 BOUT++/Hermes-3 SOL-turbulence prediction 가 substrate kernel 로 새로 land 되어야 — 본 round scope 초과.

- **#3: Energy/wind (Candidate B)**
  - Schema-generalization payoff 가 약함 (같은 record type 재사용) + substrate kernel 신설 cost (G31 mirror new round) + NREL Wind Toolkit auth overhead. G33 의 명시 exit criterion ("MeasuredOracleRef field 가 두번째 record type 에 land — schema generalization audit") 와 alignment 약함.

## 주요 trade-off

1. **cockpit record creation cost vs hexa-native kernel availability**: Aura 와 Ufo 는 record 가 이미 있어 schema 1-줄 확장. Wind 은 kernel 신설 필요 (1-3 session) — G31 mirror scale work.
2. **schema-generalization (G33 exit criterion) vs same-record reuse**: G33 의 명시 목적은 "MeasuredOracleRef field 가 두번째 record type 에 land" — Wind 은 EnergyVerifyRecord 재사용 시 이 axis 못 충족. Aura/Ufo 는 충족.
3. **prediction-shape vs formula-evaluation honesty**: solar G29 = modeled vs measured GHI prediction (강함). Aura PSD = real EEG signal-proc prediction (강함). plasma λ_D = formula(measured n_e, T_e) — measured input → modeled output 의 *역방향* axis 가 약함.
4. **dataset access overhead**: PhysioNet (anonymous wget) < NREL MIDC (anonymous · solar G29 reference) < NREL Wind Toolkit (HSDS token) < IMAS (auth + 2025 신규).

## User 가 lock-in 시 답해야 할 open question

1. **#1 후보 (Aura/EEG) 가 picked 시**:
   - PhysioNet Sleep-EDF specific subject + epoch — single subject (e.g. SC4001E0) vs multi-subject mean? default 제안 = **single subject · 5 eyes-closed Wake epochs · alpha-band integrated power**.
   - PASS criterion (a) mean_rel_err ≤ 0.05 alpha-band power vs (b) spectral-peak rel_err ≤ 0.02 — default 제안 (a).
   - hexa-native scope 확장 — `dft_naive.hexa` 만 (현 pilot) 으로 충분 vs Welch averaging 도 hexa-native 필요? default 제안 = **dft_naive 만 · Welch averaging 은 bridge (mne_psd_kernel.py) substrate-parity trusted** (solar G29 의 pvlib clearsky bridge 와 동형).
2. **#2 후보 (Ufo/plasma) picked 시**:
   - IMAS vs JET archive vs NSTX-U Langmuir — 어느 dataset? default 제안 = **JET open-pulse archive (mid-Ohmic 단일 shot)**.
   - Stage-4..7 명시 제외 carve-out 문구는 design.md D111 entry 의 어느 field? default 제안 = `scopeCaveats` + D-block body 명시.
3. **#3 후보 (Energy/wind) picked 시**:
   - EnergyVerifyRecord 재사용 vs 새 EnergyWindVerifyRecord? default 제안 = **새 record (G33 schema-generalization payoff)**.
   - NREL WTK HSDS token 의 honesty floor (auth 필요 = solar MIDC 의 anonymous 보다 한 단계 약함) 를 어떻게 record 에 명시?
4. **G32 design.md D-block 번호**: D111 (ARCH.md §11.4 G32 block 의 `exit criterion` 인용 = "design.md D111 (κ-69 G32 land) record").

## Cross-references

- ARCH.md §11.4 Round 8 G32 block (line 1970..1994)
- design.md D106 (`.illustrativePhysics` GateType) · D103 (dimension separation) · D109 (κ-68 G27 land · solar) · D110 (κ-68 G29 first flip)
- `inbox/notes/k68-cell-pick-2026-05-21.md` (κ-68 G27 mirror 의 candidate-digest 본 note 의 template)
- `inbox/notes/k68-d109-draft-2026-05-21.md` (D109 entry 의 5-fold lock-in 박제 shape)
- `domains/PILOTS.demi` `[pilot-dft_naive]` (17/17 PASS · Aura bridge substrate-parity floor) · `[pilot-plasma_metrics]` (41/41 PASS · Ufo bridge floor)
- `cockpit/Sources/DemiurgeCore/Models/MeasuredOracleRef.swift` (G28 schema · 4a1a087)
- `cockpit/Sources/DemiurgeCore/Models/EnergyVerifyRecord.swift` (G29 first carrier) · `AuraVerifyRecord.swift` · `UfoVerifyRecord.swift` (G33 candidate carriers)

## Next pickup

User review → 1 candidate pick → design.md D111 entry 박제 (k68-d109 mirror style) → ARCH §11.4 G32 `[ ]` → `[x]` flip with first-land cite block. Code 변경 0 (decision gate only · G33 가 first-flip cycle).
