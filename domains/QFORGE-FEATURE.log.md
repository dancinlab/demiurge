# QFORGE-FEATURE — work log (append-only)

## 2026-06-02 — domain created · seeded from migration-gate campaign gaps
- Created as the FORWARD capability backlog for QFORGE (QE-independent el-ph engine + dispatch toolchain). Sibling of QFORGE-PROCESS (process observability) and QFORGE-PERF (GPU/perf track).
- Seeded the backlog from gaps surfaced during the 2026-06-01/02 QFORGE migration-gate campaign:
  - **engine**: correlation-XC functional (PZ81/PW92) — screening.hexa is Hartree+LDA-exchange only · real-q metallic α²F beyond M5.8 Γ-only Einstein · NVPTX GPU hot-kernels · in-engine q-star symmetry reduction.
  - **dispatch**: dft-run corrupt-recover salvage (DONE #2459/2460) + proxy scp-fallback (DONE #2451/2453) + HostPort-lag orphan guard (filed 9e2347d6) + true resume-in-place (.save bank) + per-stage telemetry → QFORGE-PROCESS.
  - **verify**: one-shot 3-anchor cross-val harness (CaH6·LaH10·Li2MgH16).
- Boundary kept explicit: bugs/defects → `hexa-lang/inbox/patches/` (d8); this file = forward features only.
- migration default-flip stays HELD (d6/@L4) until correlation-XC + real-q metallic λ + 3-anchor cross-val all close.
