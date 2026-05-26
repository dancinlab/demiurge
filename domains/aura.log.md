# AURA — step log

> Append-only progression log for the AURA (post-aural wearable BCI) domain.
> Snapshot SSOT: [aura.md](aura.md) · verb-cell manifest: [aura.demi](aura.demi)

## 2026-05-27 — G1-G3 brk path declarations + A1-A4 readiness LANDED — 🎉 도메인 코드-side depletion

V1-V7 + D1-D7 이후 G1-G3 brk path declaration + A1-A4 readiness 일괄 표시.

### G1-G3 brk path declarations (hexa-native)

| G | brk | hexa-lang PR | LOC | stages | timeline | cost |
|---|---|---|---|---|---|---|
| G1 | MRI-safety open path | #1392 | 177 | 6 | 3-5y | $0.5-2M |
| G2 | EEG acquisition open path | #1400 | 156 | 6 | 2-4y | $0.2-1M |
| G3 | BLE non-Nordic + RISC-V path | #1404 | 151 | 6 | 1-5y | $0.1-0.5M |

**총 +484 LOC · 3 hexa-lang PR**. 모두 @D d2 honest — brk path concrete, NOT solver/platform/SoC. absorbed=false PERMANENTLY.

### A1-A4 accredited-lab gates — readiness 표시 (gate pending)

A1-A4는 외부 accredited-lab paid work이라 코드 path 만들 수 없음. D7 substance를 통해 **readiness만 LANDED**:

| A | gate | readiness 근거 | pending |
|---|---|---|---|
| A1 | FDA 510(k) review | D7 fda_510k_substance (Muse S/Dreem 3 predicate · IEC 62304 · eSTAR) | 실 submission + 90day FDA clock |
| A2 | EU MDR NB audit | D7 eu_mdr_substance (BSI/TUV SUD · ISO 13485 · UDI · EUDAMED) | 실 NB engagement (multi-quarter) |
| A3 | EMC testhouse | D7 emc_substance (UL/TUV/SGS/Intertek · $25-50K · 2-4주/cycle) | 실 EUT delivery + testhouse run |
| A4 | BT SIG qualification | D7 bt_sig_substance (Element Materials/Sporton · $8K · 4-8주) | 실 BQTF engagement |

A 마일스톤은 `[ ]`(undone) 그대로 — accredited-lab gates는 코드만으로 닫을 수 없음. 모두 D7 substance를 토대로 **submission-ready** 상태.

### 🎯 AURA 도메인 코드-side 일주 완성 요약

| 트랙 | 마일스톤 | 완성 |
|---|---|---|
| V0-V7 producer skeleton | 8 | 8 ✅ (V0 absorbed=true · V1-V7 LANDED) |
| D1-D7 substance | 7 | 7 ✅ (illustrative reference targets) |
| G1-G3 brk path | 3 | 3 ✅ (path declarations) |
| A1-A4 accredited gates | 4 | 0 (readiness LANDED · gate pending · 외부 lab) |
| **합** | **22** | **18 LANDED + 4 readiness** |

**총 PR**: 17 hexa-lang + 10 demiurge = **27 PR** · 약 **1500+ LOC** in hexa-lang.

g3: 모든 LANDED 마일스톤 absorbed=false PERMANENTLY. accredited-lab gates(A1-A4)만이 진짜 absorbed=true 통로이고, 외부 paid lab work 영역.

## 2026-05-27 — D1-D7 dossier substance 일괄 LANDED — 🎉 7-verb substance 일주 완성

V1-V7 producer skeleton (PR #1338~#1366) 이후 D1-D7 substance content 일괄 추가 완성.

| D | verb | hexa-lang PR | LOC | block 수 |
|---|---|---|---|---|
| D1 | specify | #1371 | +97 | 6 (intended_use·IFU·predicate·user_needs·performance·safety) |
| D2 | structure | #1374 | +76 | 5 (sensor·AFE·BLE·battery·mechanical) |
| D3 | design | #1376 | +53 | 4 (kicad·ngspice·freecad·nrf-firmware) |
| D4 | analyze | #1381 | +42 | 3 (mne-dataset·openems-antenna·openems-sar) |
| D5 | synthesize | #1384 | +53 | 4 (firmware-build·dsp-bundle·release·ci) |
| D6 | verify(EM) | #1386 | +44 | 3 (openems-run·sar-run·honest-gap-report) |
| D7 | handoff | #1389 | +60 | 4 (fda-510k·eu-mdr·bt-sig·emc) |

**총 +425 LOC** illustrative substance content · **29 substantive blocks**.

g3 honest: 모든 D 마일스톤 substance는 **ILLUSTRATIVE reference targets** · NOT regulatory commitments / vendor-qualified / accredited measurements. absorbed=false PERMANENTLY 유지 — 진짜 accredited closure는 A1-A4(downstream lab gates) territory.

핵심 illustrative 결정:
- 제품: AURA-100 (post-aural wearable BCI · Class II non-implantable)
- 센서: 16ch bilateral · Ag/AgCl 5mm dry + 하이드로젤 옵션
- AFE: TI ADS1299 ×2 daisy · 24-bit ΣΔ · ~1µV-pp noise · CMRR ≥110dB
- 무선: Nordic nRF5340 · BLE 5.3 · LE 2M PHY · custom EEG GATT service
- 배터리: Li-Po 200mAh ×2 / CR2032 옵션 · 12h runtime · USB-C 90min charge
- 기구: 클램셸+클립 · 25g/side · 의료급 실리콘 · IPX4
- 510(k) predicate: Muse S Athena + Dreem 3
- NB 후보: BSI Group / TUV SUD
- BQTF 후보: Element Materials / Sporton
- EMC testhouse 후보: UL Solutions / TUV Rheinland / SGS / Intertek
- 안전: 'MR Unsafe' 라벨 until G1 brk Sim4Life-parity 워크플로우 확보

## 2026-05-27 — V7 handoff producer LANDED (hexa-native) — 🎉 7-verb 일주 완성

- `stdlib/aura/handoff.hexa` 신규 166 LOC (hexa-lang PR #1366 MERGED) — final verb.
- 5 block: fda_510k (510(k) Premarket Notification Class II non-implantable · substantial equivalence + predicate · IFU/labeling 21 CFR 801+803 · ISO 10993-1 biocompat + cytotoxicity · IEC 62304 SW lifecycle moderate-to-major LOC · eSTAR submission template) · eu_mdr (MDR 2017/745 Class IIa wearable · Annex IX QMS + TD baseline · GSPR Annex I 매핑 · Notified Body engagement + ISO 13485 audit + design-dossier review · UDI-DI + UDI-PI GS1 + EUDAMED 등록) · emc_testhouse (IEC 60601-1-2 Ed.4.1 home-healthcare · CISPR 11 Group 1 Class B emission + immunity ESD/RF/PFMF/proximity-field · ISO/IEC 17025 accredited testhouse · test plan+risk-analysis+uncertainty budget) · bt_sig (Bluetooth Core Spec v5.x · Declaration ID + Qualified Design ID QDID · PHY/LL/HCI/GAP/GATT/SMP per TCRL · BQTF Bluetooth Qualification Test Facility · launch studio listing + member fee + declaration submission · custom GATT EEG + Battery + DIS) · qms_risk (ISO 13485:2016 medical QMS · ISO 14971:2019 risk analysis/control · IEC 62366-1 usability engineering + summative validation · IEC 62304 SW lifecycle · PMS vigilance reporting + CAPA · DHF/DMR/DHR records).
- cellrun manifest 변경: `[cell.handoff]` substrate=python3 → hexa, script=*.py → *.hexa, required_deps=python3 → hexa, python_candidates 제거.
- 마일스톤: V7 → `[~]` in-progress (producer LANDED).
- g3 honesty: `absorbed=false` PERMANENTLY · accredited-lab gates (510(k) FDA review · Notified Body audit · EMC testhouse · BT SIG qualification) 모두 downstream · MRI-safety labeling honest-gap = V6/G1 brk territory (Sim4Life FDA MDDT IRREPLACEABLE for ASTM F2182-19e2 + ISO 10974).

### 🎯 AURA 7-verb 일주 완성 요약

| verb | state | producer | LOC |
|---|---|---|---|
| V0 verify (EEG-spectral) | absorbed=true (G33 LANDED · Sleep-EDF 8.4e-07) | `sleep_edf_measured_oracle.py` + `_dft_alpha_band_batch.hexa` | — |
| V1 specify | producer LANDED · in-progress | `specify.hexa` (PR #1338) | 124 |
| V2 structure | producer LANDED · in-progress | `structure.hexa` (PR #1342) | 150 |
| V3 design | producer LANDED · in-progress | `design.hexa` (PR #1343) | 142 |
| V4 analyze | producer LANDED · in-progress | `analyze.hexa` (PR #1345) | 140 |
| V5 synthesize | producer LANDED · in-progress | `synthesize.hexa` (PR #1347) | 146 |
| V6 verify (EM-side) | sibling producer LANDED · in-progress | `verify.hexa` (PR #1350) | 143 |
| V7 handoff | producer LANDED · in-progress | `handoff.hexa` (PR #1366) | 166 |

총 1011 LOC · 14 PRs (7 hexa-lang + 7 demiurge) · 모두 g3 absorbed=false PERMANENTLY (TEMPLATE skeletons).

다음 단계: dossier content 실제 채움(V1-V7 각 셀의 placeholder를 실값으로) + G1-G3 갭 돌파(@D d2) + accredited-lab gates 통과 (downstream).

## 2026-05-27 — V6 verify (EM-side) sibling producer LANDED (hexa-native)

- `stdlib/aura/verify.hexa` 신규 143 LOC (hexa-lang PR #1350 MERGED) — EM-side sibling track.
- TWO verify tracks 명시: (a) EEG-spectral Sleep-EDF G33 LANDED absorbed=true (V0, substrate=sleep_edf_measured_oracle.py + _dft_alpha_band_batch.hexa, mean_rel_err 8.4e-07, D117 2nd cell, R8 4/4 CLOSURE) · (b) EM-side openEMS antenna+SAR honest-gap pending (이 파일).
- 3 block: eeg_spectral_absorbed_V0 (V0 G33 reference) · em_antenna_sar_pending (openEMS GPL-3 3D FDTD BLE 2.4-2.4835GHz S11/VSWR + 3D radiation pattern + ITIS Foundation Virtual Population head phantom SAR + π/T smith-chart 매칭 + paraview VTK + matplotlib polar) · honest_gap_G1_brk (Sim4Life ZMT/IT'IS FDA MDDT-qualified IRREPLACEABLE for MRI-safety labeling — ASTM F2182-19e2 passive implants + ISO 10974 active implants · G1 breakthrough candidate = open EM/SAR/MRI-safety solver at Sim4Life parity with regulatory acceptance).
- cellrun manifest [cell.verify] 무변경 (G33 sleep_edf path absorbed=true 그대로 유지). 이 .hexa는 sibling EM-side track 표명자.
- 마일스톤: V6 → `[~]` in-progress (sibling producer LANDED · MRI-safety 라벨링 closure는 G1 brk territory).
- g3 honesty: `absorbed=false` PERMANENTLY for EM-side track. open EM solver != FDA-MDDT-qualified Sim4Life · MRI-safety claim CANNOT be closed by open-source path alone.

## 2026-05-27 — V5 synthesize producer LANDED (hexa-native)

- `stdlib/aura/synthesize.hexa` 신규 146 LOC (hexa-lang PR #1347 MERGED).
- 4 block: firmware_bundle (Zephyr RTOS Apache-2.0 + nRF Connect SDK BSD-3 · west+cmake+ninja meta-build · MCUboot ed25519/RSA-2048 서명 · OTA SMP over BLE) · dsp_pipeline (V4 analyze territory 통합 · 0.5-50Hz bandpass+notch+Welch PSD · naive-DFT companion=`_dft_alpha_band_batch.hexa` G33 · JSONL over BLE GATT custom EEG service) · bundle_skeleton (`<release>/{firmware.signed.bin, dsp_manifest.json, README.md}` · 호환성 매트릭스 SoC × Zephyr × MNE · MCUboot dual-slot rollback · SHA-256 무결성) · ci_integration (GitHub Actions matrix nRF52840+5340+54L15 · QEMU native_posix/qemu_cortex_m3 smoke · shellcheck+clang-tidy+checkpatch.pl · GHA Releases + SBOM 발행).
- cellrun manifest 변경: `[cell.synthesize]` substrate=python3 → hexa, script=*.py → *.hexa, required_deps=python3 → hexa, python_candidates 제거.
- 마일스톤: V5 → `[~]` in-progress (producer LANDED).
- g3 honesty: `absorbed=false` PERMANENTLY · 실 cross-compile은 firmware domain D73 cellrun territory · 실 DSP emit은 V4 analyze.

## 2026-05-27 — V4 analyze producer LANDED (hexa-native)

- `stdlib/aura/analyze.hexa` 신규 140 LOC (hexa-lang PR #1345 MERGED).
- 3 analysis track: eeg_dsp (MNE-Python bandpass 0.5-50Hz+notch 50/60Hz mains+epoching 2-30s+Welch PSD · α 8-13Hz · β 13-30Hz · γ 30-50Hz · substrate SSOT=`stdlib/aura/aura_mne.py` D61-from-birth · naive-DFT companion=`_dft_alpha_band_batch.hexa` G33 LANDED) · em_fdtd (openEMS GPL-3 3D FDTD · BLE 2.4-2.4835GHz ISM · S11/VSWR + 3D radiation pattern + SAR via ITIS Foundation Virtual Population head phantom + π/T 매칭 + paraview VTK post) · synthetic_input (default = 사인+1/f pink-noise · Sleep-EDF measured-oracle parity는 V0 verify cell G33).
- cellrun manifest 변경: `[cell.analyze]` substrate=python3 → hexa, script=*.py → *.hexa, required_deps=python3,mne → hexa,python3,mne.
- 마일스톤: V4 → `[~]` in-progress (producer LANDED).
- g3 honesty: `absorbed=false` PERMANENTLY · openEMS SAR FDA-MDDT honest-gap = V6 EM-side verify (G1 breakthrough 후보).

## 2026-05-27 — V3 design producer LANDED (hexa-native)

- `stdlib/aura/design.hexa` 신규 142 LOC (hexa-lang PR #1343 MERGED).
- 4 design block: pcb_eda (KiCad 8.x BSD-3 + ngspice 임베디드 AFE 시뮬 + IEC 60601-1 Annex L creepage rules + 4층 FR-4 1.6mm) · mech_cad (FreeCAD 1.0+ LGPL + KiCad StepUp 워크벤치 PCB↔MCAD 연동 + 클램셸+클립 + IPX4 가스킷) · firmware_sdk (nRF Connect SDK BSD-3+Apache-2.0+Zephyr RTOS · BLE 5.x host+LL · 커스텀 GATT EEG 서비스 + Battery + DIS · MCUboot 서명 image) · dev_bringup (sigrok/PulseView GPL3 + nRF sniffer + Wireshark + JLinkExe/pyOCD).
- cellrun manifest 변경: `domains/aura.demi [cell.design]` `substrate=python3` → `hexa`, `script=*.py` → `*.hexa`, `required_deps=python3` → `hexa`, `python_candidates` 제거.
- 마일스톤: V3 → `[~]` in-progress (producer LANDED · 실 tape-out/vendor-validated silicon은 chip+component cell territory).
- g3 honesty: `absorbed=false` PERMANENTLY — TEMPLATE EDA/MCAD/firmware stub, NEVER tape-out / vendor silicon selection.

## 2026-05-27 — V2 structure producer LANDED (hexa-native)

- `stdlib/aura/structure.hexa` 신규 150 LOC (hexa-lang PR #1342 MERGED).
- 패턴: V1 `specify.hexa` mirror (sentinel + scope_caveats).
- 출력: `AURA_STRUCTURE_OK record_kind=aura_structure_record geometry_id=aura_structure_v1 gate=GATE_OPEN absorbed=false version=0.1.0` + `__HEXA_AURA_STRUCTURE__ PASS` + 5 architectural block + 4 scope_caveat.
- 5 block: sensor_array (다중전극 8-32ch dry/wet + RLD + biocompat ISO 10993-1 + IEC 60601-1 Type BF) · afe_adc (low-noise instr-amp + 24-bit sigma-delta ADC ADS1299-class ref + RLD CMRR) · radio_ble (BLE 5.x nRF52/53/54 + nRF Connect SDK Zephyr + chip/trace antenna + custom GATT EEG service) · battery_power (CR2032 vs Li-Po + PMIC + 12-24h runtime + IEC 62133-2 safety) · mechanical (mastoid/temporal-bone clip + 의료급 실리콘 + IPX4 + <15g + FreeCAD/KiCad StepUp).
- cellrun manifest 변경: `domains/aura.demi [cell.structure]` `substrate=python3` → `hexa`, `script=*.py` → `*.hexa`, `required_deps=python3` → `hexa`, `python_candidates` 제거.
- 마일스톤: V2 → `[~]` in-progress (producer LANDED · 실 BOM/silicon selection은 chip+component cell territory).
- g3 honesty: `absorbed=false` PERMANENTLY — partitioning skeleton, NEVER a built BOM.

## 2026-05-27 — V1 specify producer LANDED (hexa-native)

- `stdlib/aura/specify.hexa` 신규 124 LOC (hexa-lang PR #1338 MERGED).
- 패턴: `bio.hexa` 루트 디스패처 sentinel 스타일.
- 출력: `AURA_SPECIFY_OK record_kind=aura_specify_record geometry_id=aura_specify_v1 gate=GATE_OPEN absorbed=false version=0.1.0` + `__HEXA_AURA_SPECIFY__ PASS` + 8 regulatory base 라인 + 7 design-input source + 5 EMC immunity level + 4 scope_caveat.
- 표준 매핑: 21 CFR 820.30 (FDA Class II Design Controls) · EU MDR 2017/745 (Class IIa) · IEC 60601-1 Ed.3.2 (일반 안전) · IEC 60601-1-2 Ed.4.1 (EMC) · BT SIG Core Spec v5.x · ISO 14971 (위험관리) · ISO 10993-1 (생체적합성 skin-contact).
- cellrun manifest 변경 (이 PR): `domains/aura.demi [cell.specify]` `substrate=python3` → `hexa`, `script=stdlib/aura/specify.py` → `stdlib/aura/specify.hexa`, `required_deps=python3` → `hexa`, `python_candidates` 라인 제거.
- 마일스톤 상태: V1 → `[~]` in-progress (producer LANDED, dossier content 실제 채움은 follow-up).
- g3 honesty: `absorbed=false` PERMANENTLY — dossier skeleton은 aspirational scaffolding, NEVER an FDA-cleared submission. 인계 절차(510(k) · Notified Body · BT SIG qualification)는 다 accredited-lab gate 통과 후 별도.

## 2026-05-26 — domain ingest from sibling repo

## 2026-05-26 — domain ingest from sibling repo

- 🎧 AURA 도메인 demiurge 본체로 이관 (sibling repo `hexa-aura` 봉인 결정).
- 이전 위치: `github.com/dancinlab/hexa-aura` + 로컬 `~/core/hexa-aura/` (4.5 MB, 마지막 커밋 master @origin sync).
- 신규 위치:
  - 도메인 스냅샷: `demiurge/domains/aura.md` (대문자 헤더 prepend, legacy public-surface tool map 보존)
  - step log: `demiurge/domains/aura.log.md` (이 파일)
  - archive snapshot: `demiurge/domains/AURA/` — docs + .tape + papers + state(708 KB), 코드 없음 (@D d3 준수)
- GitHub 처리: `dancinlab/hexa-aura` → `dancinlab/archive-aura` rename + visibility=private
- 로컬 폴더: `~/core/hexa-aura/` 삭제
- DOMAINS.tape: `@domain AURA := "domains/aura.md"` 등록 (NAME 대문자 · 경로 소문자 = case-insensitive FS 충돌 회피)
- 구현 SSOT는 그대로: `~/core/hexa-lang/stdlib/aura/{specify,structure,design,analyze,synthesize,verify,handoff}.py` + `aura_mne.py` + `sleep_edf_measured_oracle.py` + `_dft_alpha_band_batch.hexa`
- G33 absorbed=true 상태 보존 (Sleep-EDF spectral parity mean_rel_err 8.4e-07 · D117 2nd cell first-flip · R8 4/4 CLOSURE) — `aura.demi` cellrun manifest 무변경.
