# domain — firmware (embedded firmware end-to-end)

> Status: **shallow public-surface map** (added 2026-05-20). Boundary:
> public-surface clean-room (`design.md` Decision 1). Pipeline = 7-verb
> spine (`HANDOFF.md` §4 · D5). **Why this domain**: user gate 2026-05-20
> — "펌웨어 완벽제작 → 검증 단계까지의 과정을 7-verb 의 적절한 곳에 넣자".
> Firmware = end-to-end deliverable that fits the spine cleanly: 합성
> SYNTHESIZE emits the signed firmware image, 검증 VERIFY measures it on
> QEMU / Renode / HIL — the prior verbs are the design path that gets us
> there.

**Substrate** (where the .hexa kernels live): hexa-lang `stdlib/firmware/` (born hexa-native; no sibling repo)

## 1. "Design blueprint" deliverable

A complete embedded firmware artifact: target-specific signed binary
(`.elf` / `.bin` / `.hex`), an SBOM (software bill of materials), a
verified-on-emulator (QEMU / Renode) or HIL test report, and an audit
dossier (MISRA-C deviation log, IEC 61508 SIL claim if safety-critical,
secure-boot chain manifest). Target boards span Cortex-M (STM32 / nRF /
RP2040), RISC-V (ESP32-C3 / GD32V / Pico-RV), Cortex-A (i.MX / Zynq).

Default reference target this domain ships against: `qemu-system-arm
-machine mps2-an385` (Cortex-M3, no special HW) — gives every cell a
measurable producer with zero hardware dependency.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | IETF / Zephyr public RFCs; AUTOSAR Classic Platform public spec (autosar.org); IEC 61508 (Functional Safety, public summary); MISRA-C:2012 public summary; CERT-C secure coding (cert.org) | IBM DOORS Next (public docs); Vector PREEvision |
| 구조 ARCHITECT | **Zephyr RTOS** (Apache-2.0, devicetree-driven; zephyrproject.org); **FreeRTOS** (MIT; freertos.org); **NuttX** (Apache; nuttx.apache.org); **Apache Mynewt**; AUTOSAR Classic OS public structure | Wind River VxWorks (public docs); BlackBerry QNX |
| 설계 DESIGN | `arm-none-eabi-gcc` / clang-LLVM cross-compile (developer.arm.com); **west** (Zephyr build orchestrator); **CMake**; **ESP-IDF**; **libopencm3**; **STM32CubeMX** (vendor-free generator); **TinyUSB** | IAR Embedded Workbench (public docs); Keil µVision; Green Hills MULTI |
| 해석 ANALYZE ⟲ | **clang-tidy** + **cppcheck** (static); **Frama-C** (deductive verification, frama-c.com); **KLEE** (symbolic execution — OSDI'08 cited); **CBMC** (bounded model checker — kissat / cbmc.diffblue.com); **Coverity Scan** (free-tier for OSS); MISRA-C OSS checkers (`misra-c2012` rule packs) | Polyspace (MathWorks); Synopsys Coverity; LDRA; Vector VectorCAST |
| 합성 SYNTHESIZE | **cross-compile chain** → `.elf` / `.bin` (arm-none-eabi-gcc / clang-LLVM / riscv-gcc); **west build**; **CMake/Ninja**; **MCUboot** image signing + secure-boot header (`mcuboot/imgtool.py`); **TUF/Uptane** OTA manifest; **cosign** / openssl signing | IAR/Keil/GHS commercial compilers; NXP MCUXpresso secure provisioning; ST Cube Programmer (signed) |
| 검증 VERIFY | **QEMU** (`qemu-system-arm` / `-riscv` — system emulation; qemu.org); **Renode** (Antmicro multi-node HIL simulation; renode.io); **OpenOCD** + **pyOCD** (flash + JTAG/SWD debug); **Unity + Ceedling** (C unit-test framework, ThrowTheSwitch); **CMock** (mocking); **gcov + lcov** (coverage); **PlatformIO** test runner | Lauterbach TRACE32; Segger J-Link / Ozone; Vector CANoe; National Instruments VeriStand HIL |
| 인계 HANDOFF | **MCUboot** OTA-update; **SWUpdate** (rootfs-level); **TUF/Uptane** signed manifest; secure-boot chain manifests (NXP/ST/Nordic AN public docs); SBOM via **CycloneDX** / **SPDX**; IEC 61508 SIL audit dossier (public template); CVSS / NVD vulnerability disclosure trail | Vector OTA Suite; HARMAN OTA; Aurora Labs DriverSphere |

**Per-verb deliverable shape** (what a cell emits as a typed `Record`):

```
명세    →  requirements.json   (MCU + RAM/flash + interfaces + SIL level)
구조    →  arch.json           (RTOS choice + task tree + memory map)
설계    →  source/             (Zephyr west tree or bare-metal repo)
해석    →  analysis.json       (clang-tidy + Frama-C / KLEE proof status)
합성    →  firmware.bin + sig  (signed image + MCUboot header + SBOM)
검증    →  verify.json         (QEMU/Renode pass list + coverage + HIL)
인계    →  release.tar.gz      (image + dossier + OTA manifest)
```

That column makes 합성 → 검증 the deliverable seam — the "완벽제작"
step emits the signed firmware image; the "검증" step boots it on
QEMU / Renode and measures.

## 3. Notable proprietary (public docs only)

IAR, Keil, GHS dominate certified safety toolchains (ISO 26262 / IEC 61508
SIL3+). Lauterbach TRACE32 + Segger J-Link / Ozone are the de-facto
debug-probe standards for production HIL. MathWorks Polyspace + Synopsys
Coverity hold the high-end static-analysis enterprise tier. Vector
(CANoe / DOORS Next / OTA Suite) dominates automotive AUTOSAR pipelines.
The OSS column (Zephyr / QEMU / Renode / MCUboot) is now feature-complete
for non-certified consumer / IoT / research firmware; the gap is the
audit-evidence pipeline (Polyspace-grade reports + accredited lab
sign-off), not the engineering tooling.

## 4. Biggest open-source gap

Certified safety pipelines — open static-analysis tools (Frama-C / KLEE
/ CBMC) produce strong formal results but lack the IEC 61508 / ISO 26262
tool-qualification dossier that Polyspace / Coverity ship as a product.
A second gap: full hardware-in-the-loop with real sensor/actuator
fidelity — Renode is good for digital MCU+peripheral emulation but
mixed-signal / analog HIL still needs commercial NI VeriStand-class
benches. For demiurge purposes, **QEMU / Renode reference target gives
every 7-verb cell a measurable producer with zero hardware dependency**
— the safety-qualification gap is filed as a per-customer integration
concern, not a demiurge-side blocker.

## 5. Cited sources

- Zephyr RTOS — <https://zephyrproject.org>, <https://docs.zephyrproject.org>
- FreeRTOS — <https://www.freertos.org>
- Apache NuttX — <https://nuttx.apache.org>
- ESP-IDF — <https://github.com/espressif/esp-idf>
- arm-none-eabi-gcc — <https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain>
- QEMU — <https://www.qemu.org>, mps2-an385 board docs: <https://www.qemu.org/docs/master/system/arm/mps2.html>
- Renode (Antmicro) — <https://renode.io>, <https://github.com/renode/renode>
- OpenOCD — <https://openocd.org>
- pyOCD — <https://pyocd.io>
- Unity + Ceedling — <https://www.throwtheswitch.org>
- MCUboot — <https://mcu-tools.github.io/mcuboot/>
- TUF / Uptane — <https://theupdateframework.io>, <https://uptane.org>
- SWUpdate — <https://sbabic.github.io/swupdate/>
- cosign — <https://github.com/sigstore/cosign>
- CycloneDX SBOM — <https://cyclonedx.org>
- SPDX — <https://spdx.dev>
- AUTOSAR Classic Platform — <https://www.autosar.org/standards/classic-platform>
- IEC 61508 (functional safety) — <https://www.iec.ch/functional-safety>
- MISRA-C:2012 — <https://www.misra.org.uk>
- CERT-C secure coding — <https://wiki.sei.cmu.edu/confluence/display/c>
- Frama-C — <https://frama-c.com>
- KLEE (OSDI '08, Cadar et al.) — <https://klee-se.org>, <https://www.usenix.org/legacy/event/osdi08/tech/full_papers/cadar/cadar.pdf>
- CBMC (Diffblue) — <https://www.cprover.org/cbmc/>

## 6. Workbench shelf — proposed defaults

For cockpit project type `firmware`:

- 명세: text editor on `requirements.json` (template form)
- 구조: graphviz preview of task tree from `arch.json`
- 설계: integrate `west init -m <repo>` or `cmake + ninja` invocation
- 해석: clang-tidy + cppcheck output viewer + Frama-C summary
- 합성: cross-compile build + MCUboot sign + SBOM emit
- 검증: QEMU/Renode auto-launch, Unity test runner, coverage HTML
- 인계: tar.gz bundle of image + report + SBOM + dossier

## 7. D72 kernel mapping (honest)

Firmware is mostly **build/run orchestration + signing + emulation
launch**, not numeric math. Per D72 there is no obvious shared kernel
to extract (no FEM / MC / graph / circuit math); the adapter sits as
`stdlib/firmware/<verb>.py` and shells out to the toolchain. Promotion
to a kernel only if some math primitive (e.g., a custom static-analysis
algorithm) appears that a second domain reuses. Until then this is an
**adapter-only domain** by D72 design — and that is fine.
