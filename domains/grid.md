# domain — grid (datacenter / network fabric)

> Status: **shallow public-surface map** (Cohort 2, `design.md` Decision 6).
> Boundary: public-surface clean-room (`design.md` Decision 1). Pipeline =
> 7-verb spine (`HANDOFF.md` §4 · D5). **Note**: 9-verb DC fabric substrate
> per the project's public description — the OCP open-spec stack covers
> SPECIFY / ARCHITECT remarkably well (rare among the cohort), while
> proprietary advantage lives in EDA-class signal-integrity tools.

## 1. "Design blueprint" deliverable

An AI-DC fabric spec — rack + power + cooling layout (Open Rack v3 +
OCP server contributions), network topology (fat-tree / leaf-spine /
dragonfly), per-link bandwidth + latency + congestion-control
configuration, BMC + management plane (OpenBMC / DC-SCM), plus
ASHRAE TC 9.9 thermal envelope per equipment class (A1–A4 + H1
liquid-cooled).

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | **OCP** rack / server / DC-SCM specs (Open Rack v3 base spec; opencompute.org contributions); **ASHRAE TC 9.9** 5th ed. (2021) thermal classes A1–A4 + H1; **IEEE 802** Ethernet | — |
| 구조 ARCHITECT | OCP topology + rack layout; **NetworkX** (graph-level topology authoring) | — |
| 설계 DESIGN | **P4** (PISA / Open Networking Foundation; Apache-2.0; Tofino software now open-source per p4.org); **OpenBMC** (Linux Foundation; Yocto + U-Boot + D-Bus + Redfish — Microsoft / Intel / IBM / Google / Meta) | — |
| 해석 ANALYZE ⟲ | **ns-3** (GPL; DC topologies — fat-tree / leaf-spine well-supported); **OMNeT++** (academic / non-commercial license — ⚠ *not OSI-style permissive*); **SST** (Sandia Structural Simulation Toolkit, permissive open; parallel discrete-event for HPC architectures) | **Cisco Modeling Labs** / **EVE-NG**; **Riverbed Modeler** (public docs only) |
| 합성 SYNTHESIZE | **Kubernetes** (CNCF; service / container orchestration); **Slurm** (SchedMD; batch / HPC scheduler); **Slinky** / **SUNK** (Slurm-on-K8s integrations — NVIDIA + CoreWeave) | — |
| 검증 VERIFY | SST + ns-3 regression; OpenBMC Redfish conformance | **ANSYS HFSS** + **SIwave** (signal integrity); **Cadence Sigrity** / **Clarity 3D**; **Siemens HyperLynx** (PI / SI) |
| 인계 HANDOFF | OCP contribution flow (specs → certified hardware); OpenBMC release cadence | — |

## 3. Notable proprietary (public docs only)

The proprietary gap is concentrated at the **physical-layer signal /
power-integrity EDA** surface — **ANSYS HFSS / SIwave**, **Cadence
Sigrity / Clarity 3D**, **Siemens HyperLynx** — and at **vendor
NMS** (Cisco DNA Center, Juniper Mist, Arista CloudVision; public
marketing). For *network behavior* simulation, ns-3 / SST are credible
research-grade; for *DC operations / orchestration*, the open stack
(Kubernetes + Slurm + Prometheus + OpenBMC) is operationally
deployed at hyperscale (NVIDIA Slinky to >8000 GPUs).

## 4. Biggest open-source gap

3-D full-wave SI / PI simulation (HFSS / Sigrity-class) for high-speed
backplane / package / interposer co-design — no open equivalent at the
fidelity required for ≥ 112 Gb/s SerDes channels. Note that this overlap
with `cern.md` (3-D RF EM) and `rtsc.md` (3-D coupled EM) makes a shared
demiurge `fem` abstraction a load-bearing cross-domain lever (Cohort 1
synthesis point 3).

## 5. Cited sources

- OCP Open Rack v3 base spec — <https://www.opencompute.org/documents/open-rack-base-specification-version-3-pdf>, <https://www.opencompute.org/wiki/Open_Rack/SpecsAndDesigns>
- OCP server / DC-SCM contributions — <https://www.opencompute.org/wiki/Server/SpecsAndDesigns>
- ASHRAE TC 9.9 5th ed. (2021) — <https://www.ashrae.org/file%20library/technical%20resources/bookstore/supplemental%20files/therm-gdlns-5th-r-e-refcard.pdf>
- OpenBMC (Linux Foundation) — <https://github.com/openbmc>, <https://en.wikipedia.org/wiki/OpenBMC>
- LibreBMC (OCP DC-SCM-compatible) — <https://openpowerfoundation.org/groups/librebmc/>
- P4 (ONF) — <https://opennetworking.org/p4/>, <https://github.com/p4lang>, <https://p4.org/intels-tofino-p4-software-is-now-open-source/>
- ns-3 / OMNeT++ DC fabric usage — <https://ns3simulation.com/how-to-implement-data-center-networking-in-ns3/>, arXiv:2402.05312 (SplitSim)
- SST (Sandia) — <http://sst-simulator.org/>, <https://github.com/sstsimulator/sst-core>
- Kubernetes + Slurm (Slinky / SUNK) — <https://developer.nvidia.com/blog/running-large-scale-gpu-workloads-on-kubernetes-with-slurm/>, <https://slurm.schedmd.com/kubernetes.html>
