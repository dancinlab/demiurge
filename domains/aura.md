# AURA — current state

@title: 🎧 AURA — "귀뒤 BCI" (post-aural wearable brain-computer interface)

@goal: 후이부(mastoid · temporal-bone clip) 웨어러블 BCI 7-verb 설계도 완성 — FDA Class II 510(k) + EU MDR Class IIa + IEC 60601-1 / -1-2 EMC + Bluetooth SIG qualification dossier-skeleton 7개 셀 통과 · G33 absorbed=true(Sleep-EDF spectral parity mean_rel_err 8.4e-07, D117 2nd cell first-flip, R8 4/4 CLOSURE) 기반으로 verify 외 6개 verb-cell도 absorbed=true 끌어올림.

## Migration note (2026-05-26)

Sibling repo `github.com/dancinlab/hexa-aura` 봉인:
- GitHub: `dancinlab/hexa-aura` → `dancinlab/archive-aura` (private)
- 로컬 폴더 `/Users/ghost/core/hexa-aura/` 삭제
- 핵심 docs / *.tape / papers / state(708 KB) → `domains/AURA/` 이관 (snapshot 전용 · 코드 없음)
- 구현 SSOT(`stdlib/aura/*.py`)는 `~/core/hexa-lang/stdlib/aura/` 그대로 유지 — `aura.demi` cellrun manifest 그대로 동작 (@D d3 canonical-home 준수)

## Milestones (7-verb absorbed 끌어올리기)

- [x] V0 aura+verify absorbed=true — Sleep-EDF spectral parity 8.4e-07 · G33 LANDED · D117 2nd cell first-flip · R8 4/4 CLOSURE
- [~] V1 aura+specify — producer hexa-native LANDED (hexa-lang PR #1338 · `stdlib/aura/specify.hexa` 124 LOC, sentinel emit + 8 regulatory base + 7 design-input source + 5 EMC immunity level + 4 scope_caveat) · dossier content 실제 채움(intended_use_statement · IFU · predicate_devices · user_needs · performance_requirements)은 follow-up · absorbed=false PERMANENTLY (g3)
- [~] V2 aura+structure — producer hexa-native LANDED (hexa-lang PR #1342 · `stdlib/aura/structure.hexa` 150 LOC, 5 architectural block: sensor_array · afe_adc · radio_ble · battery_power · mechanical · 4 scope_caveat) · 실 BOM/silicon selection은 chip+component cell · absorbed=false PERMANENTLY (g3)
- [~] V3 aura+design — producer hexa-native LANDED (hexa-lang PR #1343 · `stdlib/aura/design.hexa` 142 LOC, 4 design block: pcb_eda(KiCad 8.x+ngspice) · mech_cad(FreeCAD 1.0+KiCad StepUp) · firmware_sdk(nRF Connect SDK BLE 5.x+Zephyr+MCUboot) · dev_bringup(sigrok/PulseView+nRF sniffer+pyOCD) · 4 scope_caveat) · 실 tape-out/vendor-validated silicon은 chip+component cell · absorbed=false PERMANENTLY (g3)
- [~] V4 aura+analyze — producer hexa-native LANDED (hexa-lang PR #1345 · `stdlib/aura/analyze.hexa` 140 LOC, 3 track: eeg_dsp(MNE bandpass+notch+Welch · α 8-13/β 13-30/γ 30-50Hz · substrate=aura_mne.py) · em_fdtd(openEMS 3D FDTD BLE 2.4GHz + SAR via ITIS phantom) · synthetic_input(default smoke-test) · 5 scope_caveat) · openEMS SAR honest-gap는 V6 EM-side verify · absorbed=false PERMANENTLY (g3)
- [~] V5 aura+synthesize — producer hexa-native LANDED (hexa-lang PR #1347 · `stdlib/aura/synthesize.hexa` 146 LOC, 4 block: firmware_bundle(Zephyr+nRF Connect SDK · MCUboot 서명+OTA SMP) · dsp_pipeline(V4 analyze 통합 · JSONL over BLE GATT) · bundle_skeleton(manifest+dual-slot rollback+SHA-256) · ci_integration(GHA matrix+QEMU smoke+SBOM) · 4 scope_caveat) · 실 cross-compile은 firmware D73 cellrun · absorbed=false PERMANENTLY (g3)
- [~] V6 aura+verify(EM-side) — EM-side sibling producer hexa-native LANDED (hexa-lang PR #1350 · `stdlib/aura/verify.hexa` 143 LOC, 3 block: eeg_spectral_absorbed_V0(reference) · em_antenna_sar_pending(openEMS FDTD + ITIS phantom SAR) · honest_gap_G1_brk(Sim4Life FDA MDDT 대체 불가) · 5 scope_caveat) · MRI-safety 라벨링은 G1 brk 후보 (open EM/SAR/MRI-safety solver at Sim4Life parity) · absorbed=false PERMANENTLY (g3) · cellrun [cell.verify] G33 sleep_edf path 무변경 (V0 absorbed=true 보존)
- [~] V7 aura+handoff — producer hexa-native LANDED (hexa-lang PR #1366 · `stdlib/aura/handoff.hexa` 166 LOC, 5 block: fda_510k(510(k) PMN Class II · ISO 10993 + IEC 62304 · eSTAR) · eu_mdr(MDR 2017/745 Class IIa · Annex IX QMS+TD · GSPR · Notified Body · UDI-DI/PI · EUDAMED) · emc_testhouse(IEC 60601-1-2 Ed.4.1 · CISPR 11 Group 1 Class B · ISO/IEC 17025) · bt_sig(Core Spec v5.x · Declaration ID+QDID · TCRL · BQTF) · qms_risk(ISO 13485+14971+62366+62304 · DHF/DMR/DHR) · 5 scope_caveat) · accredited-lab gates는 모두 downstream · MRI-safety honest-gap은 V6/G1 brk territory · absorbed=false PERMANENTLY (g3)

## Open-gap 돌파 후보 (@D d2 breakthrough)

- [x] G1 MRI-safety(ASTM F2182-19e2 + ISO 10974) 오픈 등가물 — path declaration LANDED (hexa-lang PR #1392 · `g1_mri_safety_path.hexa` 177 LOC, 6 block + 6-stage roadmap · timeline 3-5y · cost $0.5-2M · NIH SBIR/STTR funding) · g3 ROADMAP NOT solver · absorbed=false PERMANENTLY · @D d2 honest
- [x] G2 EEG 상용 acquisition(BrainVision Analyzer / Neuroscan Curry) 대체 — path declaration LANDED (hexa-lang PR #1400 · `g2_eeg_acquisition_path.hexa` 156 LOC, 6 block + 6-stage roadmap · OpenBCI foundation · timeline 2-4y · cost $0.2-1M · NIH BRAIN funding) · g3 ROADMAP NOT platform · absorbed=false PERMANENTLY
- [x] G3 BLE 5.x SoC Nordic 의존 줄이기 — path declaration LANDED (hexa-lang PR #1404 · `g3_ble_non_nordic_path.hexa` 151 LOC, 6 block + 6-stage roadmap · ESP32-C6 near-term 1-3y · 완전 open RISC-V 3-5y · cost $0.1-0.5M · corporate+RISC-V Int'l funding) · g3 ROADMAP NOT SoC · absorbed=false PERMANENTLY

## Dossier 실값 채우기 (V1-V7 substance · placeholder → 실값)

> V1-V7 hexa-native producer가 emit하는 record의 placeholder를 실제 값으로 채움.
> g3: 채워도 absorbed=false 유지 (TEMPLATE 형태가 substance를 가져도 accredited-lab 통과 전까지는 aspirational scaffolding).

- [x] D1 specify 실값 — illustrative dossier blocks LANDED (hexa-lang PR #1371 · specify.hexa +97 LOC, 6 block: intended_use · IFU · predicate · user_needs · performance · safety) · g3 absorbed=false PERMANENTLY (ILLUSTRATIVE reference targets)
- [x] D2 structure 실값 — illustrative BOM-level blocks LANDED (hexa-lang PR #1374 · structure.hexa +76 LOC, 5 block: sensor_array_real · afe_adc_real · radio_ble_real · battery_power_real · mechanical_real · TI ADS1299 + Nordic nRF5340 + Li-Po 200mAh · IPX4 25g) · g3 NOT vendor-qualified
- [x] D3 design 실값 — illustrative design artifact blocks LANDED (hexa-lang PR #1376 · design.hexa +53 LOC, 4 block: kicad_schematic_real(6 sheets · 120 nets) · ngspice_afe_sim_real(MC 100-run 0.9-1.1µV-pp) · freecad_enclosure_real(클램셸+클립 IPX4) · nrf_firmware_real(NCS v2.5+ west build --sysbuild)) · g3 NOT tape-out
- [x] D4 analyze 실값 — illustrative sim parameter blocks LANDED (hexa-lang PR #1381 · analyze.hexa +42 LOC, 3 block: mne_dataset_real(Sleep-EDF + BNCI + EEGBCI · α-rel 0.20-0.35) · openems_antenna_real(S11 ≤-10dB · ~1.5-2.5dBi) · openems_sar_real(ITIS Duke · ≤0.5 W/kg 1g)) · g3 NOT accredited measurement
- [x] D5 synthesize 실값 — illustrative build artifact blocks LANDED (hexa-lang PR #1384 · synthesize.hexa +53 LOC, 4 block: firmware_build_real(west build · ~120-180KB) · dsp_bundle_real(FIR 0.5-50Hz N=151 · biquad 60Hz) · release_bundle_real(matrix SoC×Zephyr×MNE · MCUboot dual-slot) · ci_real(GHA matrix + QEMU + secrets)) · g3 NOT flashed/signed release
- [x] D6 verify(EM-side) 실값 — illustrative openEMS run + honest-gap report LANDED (hexa-lang PR #1386 · verify.hexa +44 LOC, 3 block: openems_run_real(60×40×20mm PML · 30-60min · -12~-18dB) · sar_run_real(ITIS Duke v3.1 · 13.5M voxels · 0.30-0.50 W/kg 1g) · honest_gap_report_real('MR Unsafe' label until accredited)) · g3 openEMS NOT FDA-MDDT
- [x] D7 handoff 실값 — illustrative regulatory submission content LANDED (hexa-lang PR #1389 · handoff.hexa +60 LOC, 4 block: fda_510k_substance(Muse S + Dreem 3 predicate · IEC 62304 Class B · 90day) · eu_mdr_substance(BSI/TUV SUD NB · ISO 13485 · UDI · EUDAMED · CE+DoC) · bt_sig_substance(EPL + Nordic reuse · BQTF · $8K Declaration · QDID) · emc_substance(UL/TUV/SGS/Intertek · CISPR 11 Class B · $25-50K · 2-4주)) · g3 NOT submitted/cleared/qualified

## Accredited-lab gates (downstream · g3 absorbed=true 통로)

> 이 게이트들이 통과되어야만 absorbed=true 가능. open-source-only path로 닫을 수 없는 진짜 closure 지점.

- [x] A1 FDA 510(k) — submission-ready DRAFT package LANDED (hexa-lang PR #1405 · `a1_fda_510k_package.hexa` 204 LOC, 8 eSTAR sections: admin · IFU · SE · device description · performance+safety · labeling · standards · summary+attestation) · gate pending = 실 submission + 90-day FDA review (paid)
- [x] A2 EU MDR NB — engagement runbook LANDED (hexa-lang PR #1407 · `a2_eu_mdr_nb_runbook.hexa` 161 LOC, 7 sections: classification(Class IIa Annex IX) · GSPR · TD Annex II/III · QMS audit(ISO 13485) · NB engagement(BSI/TUV SUD · €30-100K · 6-18mo) · UDI EUDAMED · PMS vigilance) · gate pending = 실 NB contract (paid + multi-quarter)
- [x] A3 EMC testhouse — test plan runbook LANDED (hexa-lang PR #1409 · `a3_emc_test_runbook.hexa` 150 LOC, 6 sections: standard scope(IEC 60601-1-2 Ed.4.1) · emission(CISPR 11 Class B) · immunity(8 IEC 61000-4-*) · essential performance · testhouse engagement(UL/TUV/SGS/Intertek · $25-50K) · pre-compliance) · gate pending = 실 EUT delivery + testhouse cycle (paid)
- [x] A4 BT SIG qualification — engagement runbook LANDED (hexa-lang PR #1410 · `a4_bt_sig_qualification_runbook.hexa` 152 LOC, 6 sections: membership · qualification strategy(EPL + nRF5340 reuse) · test categories(TCRL HCI/GAP/GATT/SMP) · BQTF engagement(Element/Sporton · $15-40K · 4-8wk) · Declaration+QDID($8K) · radio cert(FCC/ETSI/ISED/MIC/KC 별도)) · gate pending = 실 BQTF + Declaration (paid)

## Next-list — V-D-G-A 일주 후 추가 substantive 경로 (N1~N15)

> V0-V7 + D1-D7 + G1-G3 + A1-A4 = 22 마일스톤 LANDED 후, 더 진행 가능한 substantive 경로 15개.
> 우선순위: 🔴 brk stage_1 실 시작 (highest-leverage) → 🟡 dossier 확장 (breadth) → 🟢 cross-domain + 추가 market (lateral) → 🔵 verification + 측정 (depth) → ⚪ meta (governance + audit).

### 🔴 brk stage_1 실 시작 (G 후속 · highest-leverage)

- [x] N1 G1 stage_1 — openEMS ISO 10974 + ASTM F2182 fixture FIRST CODE LANDED (hexa-lang PR #1414 · 159 LOC · 5 blocks: ASTM F2182 + ISO 10974 + openEMS impl + V&V plan + repo scaffold)
- [x] N2 G2 stage_1 — OpenBCI ↔ AURA LSL bridge FIRST CODE LANDED (hexa-lang PR #1415 · 137 LOC · 5 blocks: OpenBCI source + LSL outlet + AURA GATT + MNE-realtime + repo scaffold)
- [x] N3 G3 stage_1 — ESP32-C6 alt-SoC NimBLE port FIRST CODE LANDED (hexa-lang PR #1417 · 148 LOC · 6 blocks: SoC + firmware stack + GATT mirror + power profile + V&V + repo)

### 🟡 dossier 확장 (D 후속 · breadth)

- [x] N4 clinical evaluation report (CER) draft LANDED (hexa-lang PR #1418 · 143 LOC · 6 blocks: scope + equivalence Muse S + literature review + risk-benefit + PMCF + conclusion)
- [x] N5 usability validation runbook LANDED (hexa-lang PR #1420 · 143 LOC · 6 blocks: scope + use-spec + 3 formatives + summative n≥15 + residual risk + documentation)
- [x] N6 IEC 62304 SW traceability LANDED (hexa-lang PR #1421 · 145 LOC · 6 blocks: Class B safety + dev process 5.1-5.8 + 6-column matrix + SOUP + risk + DHF artifacts)
- [x] N7 cybersecurity package LANDED (hexa-lang PR #1422 · 144 LOC · 6 blocks: 524B scope + STRIDE + secure boot/OTA/BLE controls + SPDX SBOM + vuln mgmt + testing)
- [x] N8 PMS plan + vigilance LANDED (hexa-lang PR #1424 · 145 LOC · 6 blocks: MDR+CFR + data sources + workflow 15/30day + analysis + PMCF + EUDAMED+MAUDE)

### 🟢 cross-domain + 추가 market (lateral expansion)

- [x] N9 AURA × BRAIN cross-link LANDED (hexa-lang PR #1427 · 130 LOC · 5 blocks: shared Sim4Life gap + coordination + AURA wellness vs BRAIN clinical + joint funding)
- [x] N10 AURA × FIRMWARE D73 integration LANDED (hexa-lang PR #1428 · 118 LOC · 4 blocks: substrate handoff + manifest schema + cellrun dispatch + CI integration)
- [x] N11 추가 regulatory markets (KR+JP+CN+BR) LANDED (hexa-lang PR #1430 · 138 LOC · 5 blocks: MFDS + PMDA + NMPA + ANVISA + common MDSAP strategy)

### 🔵 verification + 측정 substantive (depth)

- [x] N12 V0 G33 dataset extension LANDED (hexa-lang PR #1433 · 137 LOC · 5 blocks: existing G33 ref + BNCI Horizon + EEGBCI + workflow + acceptance ≤1e-6)
- [x] N13 ngspice AFE sim runbook LANDED (hexa-lang PR #1434 · 146 LOC · 6 blocks: test circuit + noise model + ngspice invocation + Monte-Carlo + expected output + record emission)
- [x] N14 paper scaffold LANDED (hexa-lang PR #1436 · 154 LOC · 6 blocks: metadata + abstract + 10 sections + 8 figs + figure generation + related work)

### ⚪ meta (governance + audit)

- [x] N15 AURA audit cell LANDED (hexa-lang PR #1437 · 133 LOC · 5 blocks: audit scope + 7 consistency checks + 6 g3 axes + summary stats + outputs)

## Next-list N16-N20 — cross-link + 실측 정밀화 (N1-N15 일주 후)

- [x] N16 선행 도메인 cross-link 5 cells (aura.demi [xlink.*]) LANDED (PR #295 · 77 LOC · chip+component+firmware+brain+bio)
- [x] N17 5 도메인 역방향 cross-link [xlink.aura_*] LANDED (이 PR · 5 도메인 .demi 각 +12 LOC · peer view)
- [x] N18 N13 ngspice 실측 path PROVEN (pool:ubu-1 · ngspice 42 install + v1+v2 batch run · numerical output 획득 · g3 ILLUSTRATIVE)
- [x] N19 N13.3 ADS1299 정밀화 — v3 deck 실험 LANDED (Rn=Vn²/(4kT) thermal trick · Vn=25 nV/√Hz · 0.5-50Hz band · ngspice 42 · output 2932 µV-pp ≠ datasheet 1 µV-pp 차이 ~1700× · g3 ILLUSTRATIVE · INBOX TI macro fetch follow-up PR #299)
- [x] N20 4 도메인 hexa-native dispatcher LANDED (hexa-lang PR #1441 · stdlib/{chip,component,firmware,brain}/*.hexa 4 신규 · bio.hexa 패턴 · 각 ~15 LOC · per-verb .py 점진 마이그레이션)

## 7-verb cell 상태

| verb | substrate | absorbed | gate | 근거 |
|---|---|---|---|---|
| specify | python3 | false | OPEN | dossier skeleton TEMPLATE — 실 제출 dossier 아님 |
| structure | python3 | false | OPEN | sensor + AFE + radio partitioning skeleton |
| design | python3 | false | OPEN | KiCad / FreeCAD / nRF Connect SDK 스텁 |
| analyze | python3 + mne | false | OPEN | MNE band-power on synthetic — 측정 oracle은 verify에 있음 |
| synthesize | python3 | false | OPEN | firmware build pointer만 |
| **verify** | **python3 + mne** | **true ✅** | **CLOSED (G33)** | **Sleep-EDF spectral 8.4e-07 · D117 2nd cell · R8 4/4** |
| handoff | python3 | false | OPEN | FDA 510(k) + EU MDR + BT SIG dossier skeleton |

## 파일 레이아웃 (이관 후)

```
demiurge/domains/
├─ aura.md         ← 이 파일 (도메인 스냅샷 + public-surface tool map)
├─ aura.demi       ← verb-cell cellrun manifest (포인터)
├─ aura.log.md     ← step log (append-only)
└─ AURA/           ← archive snapshot (708 KB · docs + .tape + papers + state)
    ├─ README.md / INDEX.md / TODO.md / CHANGELOG.md / RELEASE_NOTES_v1.0.0.md
    ├─ LIMIT_BREAKTHROUGH.md / LATTICE_POLICY.md / TAPE-AUDIT.md / DEPENDENCIES.md
    ├─ IMPORTED_FROM_CANON.md(.tape) / hexa.toml / install.hexa / .roadmap.hexa_aura
    ├─ AGENTS.tape · BENCHTOP.tape · CLIP.tape · COIL.tape · CORTEX.tape · SAFETY.tape · TODO.tape
    └─ papers/ · state/ · docs/

hexa-lang/stdlib/aura/  ← 구현 SSOT (그대로 · @D d3)
├─ specify.py / structure.py / design.py / analyze.py / synthesize.py / verify.py / handoff.py
├─ aura_mne.py
├─ sleep_edf_measured_oracle.py
└─ _dft_alpha_band_batch.hexa
```

archive: `github.com/dancinlab/archive-aura` (private · 2026-05-26 봉인)

---

# (legacy section) domain — aura (post-aural wearable BCI)

> Status: **shallow public-surface map** (Cohort 2, `design.md` Decision 6).
> Boundary: public-surface clean-room (`design.md` Decision 1). Pipeline =
> 7-verb spine (`HANDOFF.md` §4 · D5). **Cross-link**: shares `brain.md`'s
> regulatory-verify proprietary gap (Sim4Life FDA MDDT for MRI safety has
> no open equivalent), but the bar is lower — non-implantable wearable
> likely Class II (not Class III implant), 21 CFR 820.30 design controls
> + general controls rather than PMA.

**Substrate** (where the .hexa kernels live): hexa-lang `stdlib/aura/` + sibling `~/core/hexa-aura/` (born hexa-native + sibling extension)

## 1. "Design blueprint" deliverable

A post-aural / temporal-bone clip device spec — multi-electrode dry / wet
EEG / EOG sensor array + reference, low-noise analog front-end + ADC,
BLE radio + antenna, battery + power management, biocompatible enclosure
+ ergonomic fit (mastoid / temporal-bone clip), plus FDA Class II design
dossier (21 CFR 820.30) and IEC 60601-1 + 60601-1-2 EMC dossier.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (user-need + FDA Design Input per 21 CFR 820.30; EU MDR 2017/745 GSPR; IEC 60601-1 + 60601-1-2 EMC; Bluetooth SIG core spec) | — |
| 구조 ARCHITECT | (sensor array + AFE + radio + battery partitioning; mastoid / temporal-bone clip mechanical) | — |
| 설계 DESIGN | **KiCad** (PCB + embedded ngspice for AFE simulation); **FreeCAD** (parametric enclosure; KiCad StepUp workbench for PCB↔mechanical co-design); **nRF Connect SDK** (Nordic, BSD-3 + Apache-2.0 + Zephyr; BLE 5.x host + LL on nRF52 / 53 / 54) | **Altium Designer** · **SolidWorks** (mainstream commercial PCB + MCAD) |
| 해석 ANALYZE ⟲ | **openEMS** (FDTD electromagnetic field solver, GPL-3; antenna + matching network design); **MNE-Python** (EEG / MEG signal processing — mne-tools); (computational-neuroscience adjacency: **Brian2**, **NEST** — ⚠ *spiking-neuron simulators, useful for source-modeling research but not the on-device DSP path*) | **ANSYS HFSS** (3-D EM at BLE band); **Keysight ADS** (RF / matching) |
| 합성 SYNTHESIZE | (firmware build via Zephyr / nRF Connect SDK; signal-processing pipelines in MNE-Python) | — |
| 검증 VERIFY | openEMS antenna pattern + SAR estimate; MNE-Python validation against open EEG datasets (PhysioNet, BNCI Horizon) | **Sim4Life** (ZMT / IT'IS; FDA MDDT-qualified IMAnalytics + MRIxViP for MRI-safety / EM exposure — first FDA-qualified computational MDDT); commercial EMC testhouses for IEC 60601-1-2 |
| 인계 HANDOFF | FDA 510(k) submission (Class II) or De Novo; EU MDR conformity assessment with Notified Body; Bluetooth SIG qualification | — |

## 3. Notable proprietary (public docs only)

**Altium Designer**, **SolidWorks**, **ANSYS HFSS**, **Sim4Life** —
same EM / structural / safety-sim proprietary axis as `brain.md`, but
the regulatory bar is lower for a non-implantable wearable (Class II
vs Class III). Sim4Life's FDA MDDT status for MRI-safety evaluation
(ASTM F2182-19e2 passive implants, ISO 10974 active implants — IMAnalytics
V3.0 + MRIxViP V2.1) remains the singular irreplaceable proprietary
tool for any device that may end up in an MRI bore. EEG-specific
proprietary acquisition (BrainVision Analyzer, Neuroscan Curry) exists
but MNE-Python is an established research-grade replacement.

## 4. Biggest open-source gap

Validated open-source RF / SAR / MRI-safety simulator at Sim4Life
parity, with regulatory acceptance. openEMS handles antenna + field
solving credibly but is not FDA-MDDT-qualified and has no validated
ISO 10974 / ASTM F2182-class workflow. For wearable BCI this is a
softer gap than for `brain.md`'s implant case but still binding for
MRI-safety labeling.

## 5. Cited sources

- KiCad (with embedded ngspice) — <https://www.kicad.org/discover/spice/>
- FreeCAD + KiCad StepUp — <https://www.freecad.org/>, <https://hackaday.io/course/172360-introduction-to-kicad-and-freecad>
- openEMS — <https://www.openems.de/>, <https://github.com/thliebig/openEMS>
- MNE-Python — <https://github.com/mne-tools/mne-python>
- nRF Connect SDK (Nordic / Zephyr) — <https://www.nordicsemi.com/Products/Development-software/nRF-Connect-SDK>, <https://github.com/nrfconnect/sdk-nrf>
- Sim4Life FDA MDDT — <https://sim4life.swiss/>, <https://www.fda.gov/media/148922/download>, <https://zmt.swiss/news-and-events/news/sim4life/fda-extends-mddt-qualification-to-imanalytics-v3-0-and-mrixvip-v2-1>
- IEC 60601-1-2 EMC for wearables + EU MDR — <https://www.testinglab.com/iec-60601-1-2-emc-testing-for-medical-wearable-electronics>, <https://blog.johner-institute.com/systems-engineering/iec-60601-1-2/>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 통신 = BLE / 유선
- 설계: 센서 = 건식 EEG / 습식 EEG ; 전원 = 일회용 배터리 / 충전식
