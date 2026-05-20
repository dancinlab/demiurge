# domain — aura (post-aural wearable BCI)

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
