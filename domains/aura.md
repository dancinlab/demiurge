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
- [ ] V5 aura+synthesize — Zephyr / nRF firmware build pointer + 신호처리 deployable bundle skeleton
- [ ] V6 aura+verify(EM-side) — openEMS antenna + SAR honest-gap 닫기 (EEG-spectral은 V0 완료)
- [ ] V7 aura+handoff — FDA 510(k) Class II 제출 dossier + EU MDR conformity-assessment + BT SIG qualification 패키지

## Open-gap 돌파 후보 (@D d2 breakthrough)

- [ ] G1 MRI-safety(ASTM F2182-19e2 + ISO 10974) 오픈 등가물 — Sim4Life FDA MDDT 의존 깨기 위한 openEMS 검증 워크플로우 확장
- [ ] G2 EEG 상용 acquisition(BrainVision Analyzer / Neuroscan Curry) 대체 — MNE-Python acquisition-side 강화
- [ ] G3 BLE 5.x SoC Nordic 의존 줄이기 — RISC-V BLE SoC 시야

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
