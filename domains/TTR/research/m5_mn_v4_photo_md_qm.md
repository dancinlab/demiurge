# TTR-MN M5-v4 — photo MD/QM (UV-A + Cu-Pc/Cr₂O₃ excited state · cascade ternary)

> milestone: TTR-MN.md "M5-MN v4 — photo MD/QM (Cu-Pc/Cr₂O₃ excited state · site-localized)"
> driver: v4 floor의 photo-Fenton path 검증 (UV-A 365 nm + wall pigments)
> base: M5-MN v1 (12-cell · `TTR/research/m5_mn_md_qm_design.md`) 위 v4 photo + quad payload 추가

## TL;DR

v4 추가 시뮬 8-cell: (Cu-Pc + UV-A) · (Cr₂O₃ + UV-A) · (TiO₂ NP + UV-A · catalyst) · (CeO₂ + photo + Fe oxide) · (quad cascade ternary MD with TLR7) · (imiquimod TLR7 docking) · (1500/cm² needle plume MD) · (LED light propagation simulator). 도구 stack: TD-DFT (ωB97X-D · CAM-B3LYP cross-check) + GROMACS (CHARMM36m + photo-active extension) + COMSOL/Lumerical (LED propagation). GPU pod 예산 **$200-300** 추가 (v3 $400 baseline + v4 $200-300 = **$600-700 total**).

## §1 v4 추가 simulation matrix (8 cell)

| cell | target | method | grid | budget |
|---|---|---|---|---|
| **P1** | Cu-Pc + UV-A 365 nm + ¹O₂ generation | TD-DFT (ωB97X-D · 50 atoms) | A100 | $35 |
| **P2** | Cr₂O₃ band-gap excited state (e⁻/h⁺) | DFT + plane-wave + HSE06 hybrid | A100 24h | $30 |
| **P3** | TiO₂ NP + UV-A (catalyst booster) | DFT cluster TD-DFT | A100 | $25 |
| **P4** | CeO₂ + photo + Fe₂O₃ + H₂O surface MD | ReaxFF 50 ns · 5k atom | A100 | $40 |
| **P5** | Quad cascade ternary MD (AzoR + DyP + CeO₂ + TLR7 docking)| GROMACS CHARMM36m · 15k atom · 100 ns | A100 48h | $80 |
| **P6** | Imiquimod-TLR7 ECD docking + MD | Vina + GROMACS 50 ns · 8k atom | A100 | $30 |
| **P7** | 1500/cm² needle plume CFD | OpenFOAM steady-state | A100 | $20 |
| **P8** | UV-A LED light propagation through skin | Lumerical FDTD or MCRT | A100 | $25 |

⇒ **총 $285 추가** · v1+v3+v4 합 ~$685 GPU pod

## §2 Photo-Fenton mechanism 정량 (P1-P3)

### P1 — Cu-Pc + UV-A 365 nm

```
   Cu-Pc 50 atom (macrocycle + Cu² central)
        ↓
   UV-A 365 nm (3.40 eV) excitation
        ↓
   Cu-Pc Q-band 670 nm (1.85 eV) — direct off-resonance
   But Soret band ~340 nm (3.65 eV) — close to UV-A
        ↓
   S1 → T1 inter-system crossing (Cu heavy atom · φ_T ~ 0.5)
        ↓
   T1 + ³O₂ → ¹O₂ generation (φ_¹O₂ ~ 0.05-0.15 · TD-DFT 계산 target)
        ↓
   ¹O₂ + macrocycle methine bridge → ring-open (literature)
```

⇒ **TD-DFT goal**: φ_¹O₂ 정확 수치 (0.05-0.15 range narrow)

### P2 — Cr₂O₃ band-gap excited state

```
   Cr₂O₃ band gap 3.40 eV (arxiv:2405.11122 정합)
        ↓
   UV-A 365 nm (3.40 eV) — thermodynamic match
        ↓
   e⁻/h⁺ separation at surface
        ↓
   h⁺ + H₂O → ·OH (surface · phagolysosome 환경)
        ↓
   ·OH + Cr³⁺ → Cr⁴⁺ → Cr³⁺ + chelator binding ↑ (DFO 친화)
        ↓
   Surface chemistry restructure → enzymatic + chelation 가속
```

⇒ **DFT goal**: 표면 ·OH yield · Cr³⁺ → Cr⁴⁺ kinetic 정량

### P3 — TiO₂ NP catalyst booster

```
   TiO₂ band gap 3.20 eV (387 nm absorption edge)
        ↓
   UV-A 365 nm (3.40 eV) > band gap → excitation
        ↓
   e⁻/h⁺ generation · TiO₂ photocatalysis
        ↓
   surface ·OH · ¹O₂ generation (broader spectrum)
        ↓
   patch payload booster (optional · CeO₂ + TiO₂ combo)
```

⇒ TD-DFT optional · CeO₂ 단독 vs CeO₂+TiO₂ booster 비교

## §3 cascade ternary MD (P5 핵심)

### 시뮬 setup

```
   Box size: 10 × 10 × 10 nm (15,000 atom)
   Time: 100 ns NPT (CHARMM36m · TIP3P water · 0.15 M NaCl · pH 4.5 모사)
   Components:
     - AzoR enzyme (1V4B · 1672 atom · holo FMN)
     - DyP enzyme (4G2C · 2500 atom · heme)
     - CeO₂ NP (5 nm cluster · ~200 atom)
     - Methyl orange substrate (35 atom · azo prototype)
     - Cu-Pc model 10 atom (방향족 fragment)
     - Imiquimod 25 atom
     - TLR7 ECD fragment (1500 atom · UniProt Q9NYK1)
     - water + ions
```

### 측정 endpoint

| measurement | target |
|---|---|
| AzoR-substrate binding ΔG | match closed-form -5.35 kcal/mol (Vina) |
| DyP-Cu-Pc binding ΔG | target -5 to -7 kcal/mol |
| CeO₂ NP + Fe³⁺ exchange kinetics | rate constant |
| Cascade synergy (multi-enzyme co-occupancy) | TLR7 + macrophage residence time |
| AzoR cascade product (aromatic amine) trajectory | 24-72h clearance 모사 |
| **Synergy factor 정량** | mass-action 1.71× → MD 실측 비교 |

## §4 LED light propagation (P8)

### Skin penetration depth (UV-A 365 nm)

```
   UV-A penetration depth (Anderson 1981 · Bashkatov 2011):
        SC (20 μm)        → 60% transmittance
        Epidermis (100 μm) → 30% transmittance @ 100 μm
        Dermis (500 μm)   → 10% @ 500 μm
        Dermis (1000 μm)  → 3% @ 1000 μm
        Dermis (1500 μm)  → 1% (잉크 거주 깊이)
```

### MN-tip waveguide possibility

```
   needles 1200 μm 길이 → photonic waveguide?
   HA refractive index n ≈ 1.40 (water 1.33)
   total internal reflection 가능 angle: arcsin(1.33/1.40) = 71°
   needle taper 8:1 = 7° angle → 평행한 빛 효율적 guiding 어려움
   
   → MN-tip waveguide 효과 제한적
   → LED 광은 skin surface 에서만 활성 (표면 0-500 μm 깊이)
   → photo-Fenton 활성은 표피-진피 경계 부근 (잉크 표면 노출 영역)
```

⇒ **honest disclosure**: photo-Fenton 효과는 잉크 전체 분율의 30-50% (표면 영역) · 깊은 잉크는 cascade only

## §5 imiquimod-TLR7 docking (P6)

### TLR7 ECD docking

```
   TLR7 ECD 구조 (PDB 5GMF · 5GMG)
        ↓
   Imiquimod 분자 docking
        target: hydrophobic pocket near LRR (leucine-rich repeat)
        expected ΔG ≈ -6 to -8 kcal/mol (FDA-approved · 강한 binding)
        ↓
   MD 50 ns 후 binding residence time
        ↓
   IFN-α signaling cascade 가속 (downstream)
```

⇒ **goal**: imiquimod의 TLR7 binding 정합 (FDA-precedent 이라 confirmation)

## §6 비용 + 시간 plan

### Sequential dispatch (1 cohort at a time)

```
   Phase 1: P1 + P3 (TD-DFT · 1d)        → $60
   Phase 2: P2 (DFT plane-wave · 2d)      → $30
   Phase 3: P4 (ReaxFF MD · 2d)           → $40
   Phase 4: P5 (cascade ternary MD · 3d)  → $80  ← critical
   Phase 5: P6 (imiquimod docking · 1d)   → $30
   Phase 6: P7 + P8 (CFD + light · 2d)    → $45
   ────────────────────────────────────────
   총 12일 · $285
```

### Parallel dispatch (3 cohort 동시)

```
   Cohort A: P1 + P2 + P3 (photo TD-DFT) · 2일 · $90
   Cohort B: P4 + P5 (MD heavy) · 4일 · $120
   Cohort C: P6 + P7 + P8 (docking + CFD + light) · 2일 · $75
   ────────────────────────────────────────
   총 4일 · $285 (병렬 시간 단축 · 비용 동일)
```

## §7 expected outputs · gate criteria

| sim | target | gate |
|---|---|---|
| P1 Cu-Pc φ_¹O₂ | 0.05-0.15 | ≥ 0.05 → photo-Fenton viable |
| P2 Cr₂O₃ surface ·OH | yield/photon | ≥ 0.3 → chelation enhancement OK |
| P3 TiO₂ booster | optional | binary go/no-go (P1+P3 vs P1 only) |
| P4 CeO₂+Fe oxide surface | rate constant | viable |
| **P5 cascade synergy** | mass-action vs MD | ratio MD/closed-form (1.71× target) |
| P6 imiquimod-TLR7 ΔG | -6 to -8 | confirms FDA-precedent |
| P7 plume distribution | 1500/cm² overlap | matches M7-v4 η=0.4 |
| P8 LED penetration depth | depth % map | 표면 영역 vs 깊이 분포 |

## §8 risks + mitigations

| risk | mitigation |
|---|---|
| TD-DFT functional choice (ωB97X-D vs CAM-B3LYP · ~0.3 eV scatter) | dual-functional cross-check (별 cohort) |
| Cascade ternary MD 100 ns 부족 (longer needed?) | extend 200 ns if synergy unconverged |
| TLR7 ECD docking 정확 (Vina rigid · induced fit?) | enhanced sampling (metadynamics) 시 추가 |
| LED light propagation 단순 BCN 모사 (skin scattering 부정확) | MCRT (Monte Carlo radiative transfer) tighter |
| GPU pod cost overrun (시뮬 reconverge) | budget +20% buffer ($285 → $345) |

## §9 hexa cloud dispatch path (per @D d7)

```bash
# Pod launch (RunPod or Vast.ai · A100 24GB spot $1/hr)
# Manual launch · 비용 confirm 필요

hexa cloud copy-to <pod-host> --port <ssh_port> -- input/ /workspace/sim/input
hexa cloud nohup <pod-host> logs/sim.log --port <ssh_port> --insecure -- bash run.sh

# Polling (hexa cloud poll)
hexa cloud poll <pod-host> <remote_pid> --port <ssh_port>

# Fetch
hexa cloud copy-from <pod-host> --port <ssh_port> -- /workspace/sim/output output/
```

## §10 honest unknowns

- Cu-Pc φ_¹O₂ 정확 수치 (in dermal env vs vacuum · ~30% drop)
- Cr₂O₃ surface band-gap excited dynamics 정확 (HSE06 vs PBE+U)
- Cascade ternary MD 100 ns 충분성 (longer · 별 cohort 가능성)
- TLR7 induced fit (rigid docking 한계)
- LED light propagation MCRT vs Beer-Lambert vs FDTD
- GPU pod cost · spot interruption (RunPod · Vast.ai)

## §11 진행 상태

- ✅ 8-cell v4 simulation matrix (photo TD-DFT · DFT band-gap · ReaxFF · cascade ternary MD · imiquimod-TLR7 · CFD · light propagation)
- ✅ Photo-Fenton mechanism 정량 path (Cu-Pc φ_¹O₂ · Cr₂O₃ surface · TiO₂ booster)
- ✅ Cascade ternary MD 100 ns design (15k atom · CHARMM36m)
- ✅ LED light propagation 분석 (잉크 30-50% 표면 영역 photo + cascade only deep)
- ✅ Imiquimod-TLR7 docking (FDA-precedent confirmation)
- ✅ GPU pod 예산 $285 추가 · 4-12일 timeline
- ✅ hexa cloud dispatch path (per @D d7)
- next: M8-MN v4 (ex-vivo ultra-compressed 15일)
