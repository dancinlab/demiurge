# AURA — step log

> Append-only progression log for the AURA (post-aural wearable BCI) domain.
> Snapshot SSOT: [aura.md](aura.md) · verb-cell manifest: [aura.demi](aura.demi)

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
