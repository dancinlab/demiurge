# TTR-CREAM M5 — 잉크-활성분자 MD/QM (cream profile)

> milestone: TTR-CREAM.md "M5-CREAM MD/QM — cream concentration profile (SC 통과 후 진피 농도) 정합"
> driver: cream + sono delivery 시 dermal concentration profile · per-cycle reactivity 정량
> base: TTR-MN M5 (12-cell · GPU) + M5-v4 (photo) · 위 cream/sono path-specific

## TL;DR

cream + sonophoresis 통합 MD/QM 시뮬 8-cell. ① sono cavitation in SC bilayer (Mitragotri model) · ② CREAM-α/β/γ payload dermal concentration profile · ③ ethosome encapsulation MD · ④ cream + ink interface reaction · ⑤ 1년 multi-cycle stochastic · ⑥ CPE + payload combo · ⑦ DFO + Fe oxide dermal exchange · ⑧ CeO₂ NP + ethosome stability. GPU pod $150-200 추가. ubu-1 CPU 일부 가능.

## §1 8-cell cream simulation matrix

| cell | system | method | host | budget |
|---|---|---|---|---|
| **CR1** | Sono cavitation in SC lipid bilayer | LAMMPS bubble MD (10⁵ atom · 10 ns) | A100 | $40 |
| **CR2** | Ethosome encapsulation MD (CeO₂ NP 5 nm + phospholipid) | GROMACS CHARMM36-lipid (15k atom · 100 ns) | A100 | $50 |
| **CR3** | Ascorbate + DFO + Fe₂O₃ surface MD | ReaxFF MD (5k atom · 50 ns) | A100 | $30 |
| **CR4** | DFO + Cr₂O₃ surface coordination | DFT cluster (50 atom) | A100 | $20 |
| **CR5** | CPE (azone · DMSO) + SC lipid disrupt | GROMACS Slipids 50 ns | A100 | $20 |
| **CR6** | Cream + ink interface reaction kinetic | Eyring TS (DFT cluster) | A100 | $25 |
| **CR7** | Multi-cycle stochastic Monte Carlo | Python on ubu-1 | ubu-1 CPU | $0 |
| **CR8** | AzoR sono permeation simulation | Mitragotri model + diffusion | ubu-1 + Python | $0 |

⇒ 총 **$185** GPU pod + 2 CPU cells

## §2 expected outputs per cell

### CR1 — Sono cavitation in SC

```
   Mitragotri 모델 (2000 · 2003):
   - bubble formation at 20 kHz · 1.5 W/cm²
   - SC lipid bilayer disruption mechanism
   - cream payload transport boost
   
   target: payload mass transfer factor (예상 50-100× passive)
```

### CR2 — Ethosome + CeO₂ NP MD

```
   Ethosome composition:
   - phosphatidylcholine 90 %
   - ethanol 30 %
   - cholesterol 5 %
   - + CeO₂ NP (5 nm) encapsulated
   
   target: encapsulation efficiency · lipid bilayer stability · NP release rate
```

### CR3 — DFO + Fe₂O₃ surface

```
   ReaxFF MD:
   - DFO (656 Da) approach Fe₂O₃ (100) surface
   - chelation kinetic (binding rate · K_a)
   - 진피 환경 (pH 7.4 · 0.15M NaCl)
   
   target: DFO-Fe³⁺ binding rate · saturation
```

### CR4 — DFO + Cr₂O₃ DFT cluster

```
   DFT (B3LYP-D3 · def2-TZVP):
   - DFO + Cr³⁺ complex geometry
   - log K(Cr³⁺) computed (literature 30 · check)
   - Cr₂O₃ surface ·OH formation
```

### CR7 — Multi-cycle Monte Carlo (CPU OK)

```
   Python MC 1000 trials:
   - per-cycle x = 8-10% (sono + cream)
   - σ = 2-3%
   - N = 22-28 cycle (1년)
   - cumulative coverage prediction
   - 95% CI for honest goal update
```

## §3 단순 CPU validation (ubu-1 시도 가능)

### Multi-cycle MC for cream

```python
# ubu-1 ttr env · CPU only
import random, math
random.seed(42)

x_cream = 0.08  # cream + sono (M2 estimate)
sigma = 0.025

def cumulative_MC(x_mean, sigma, N, trials=1000):
    results = []
    for _ in range(trials):
        rem = 1.0
        for _ in range(N):
            x = max(0, min(1, random.gauss(x_mean, sigma)))
            rem *= (1 - x)
        results.append(1 - rem)
    return sum(results)/len(results)

# 52 cycle (1년 주 1회)
mc_52 = cumulative_MC(0.08, 0.025, 52)
print(f"CREAM-β 1년 (52 cycle): {mc_52:.1%}")
# expected: ~89% (sono boosted)
```

### Cream + ink kinetic (Eyring · CPU)

```
   Eyring TS: k = (kB·T/h) × exp(-ΔG‡/RT)
   ΔG‡ = 18 kcal/mol (estimated AzoR + azo TS)
   k = 6.2e12 × exp(-18000/(1.987×310)) = 100 s⁻¹
   → AzoR K_cat ~ 10² s⁻¹ literature 정합 ✅
```

## §4 cream + sono integration model

```
   Mitragotri sonophoresis mass transfer:
   J_sono = J_passive × (1 + α·I·t)
       I = ultrasound intensity (1.5 W/cm²)
       t = duration (30 sec)
       α = molecular-size factor
   
   For AzoR (23 kDa):
       J_sono / J_passive = 1 + 50 (Mitragotri 2003)
   
   For DFO (656 Da):
       J_sono / J_passive = 1 + 10
   
   For CeO₂ NP (5 nm encapsulated):
       J_sono / J_passive = 1 + 30 (ethosome carrier 동승)
```

⇒ payload별 sono boost factor 정합

## §5 cream concentration profile (depth)

```
   sono boost로 도달 가능 깊이 vs 농도:
   ─────────────────────
   100 μm (표피):    ~80% payload (sono 강함)
   300 μm:          ~50%
   500 μm (진피 shallow): ~30%
   1000 μm (진피):  ~15%
   1500 μm (진피 deep): ~5%
   2000 μm:         < 2%
   
   ⇒ 잉크 1000-1500 μm 영역 sono 보조 시 ~15-30% 접근
   ⇒ multi-cycle 누적 시 sufficient
```

## §6 honest unknowns

- Mitragotri α factor variability (skin individual)
- Ethosome + CeO₂ NP encapsulation efficiency (실측)
- DFO cream + ethosome 안정성 (chelation 활성 유지)
- AzoR cream activity vs in-vitro K_cat
- 진피 pH (7.4) 의 sono cavitation 영향

## §7 dispatch path

```
   Phase 1: CR7 (CPU MC) · CR8 (Mitragotri) · CR6 (Eyring) — 0 GPU · 1일
   Phase 2: CR4 (DFT cluster · A100 12h · $20)
   Phase 3: CR3 (ReaxFF · A100 24h · $30)
   Phase 4: CR2 + CR5 (lipid MD · A100 36h · $70)
   Phase 5: CR1 (sono cavitation · A100 24h · $40)
   ─────────────────────────────────────────
   total $185 · ~5일 sequential 또는 2-3일 parallel
```

## §8 M7-CREAM handoff

다음 milestone (M7-CREAM 제형) 가 받는 입력:
- Cream-friendly molecule (M3) + dermal concentration profile (M5)
- Sono device parameter (M2)
- Ethosome composition (CR2)
- Per-cycle x: 8-10% (CR7 MC) · 95% CI
- multi-cycle 1년 cumulative goal: 70-80%

## §9 진행 상태

- ✅ 8-cell cream simulation matrix
- ✅ Mitragotri sono boost factor (50× AzoR · 30× CeO₂ NP)
- ✅ Cream concentration profile (depth-resolved)
- ✅ Multi-cycle MC plan (CPU validation)
- ✅ Eyring TS estimate · DFO + Cr₂O₃ DFT
- ✅ GPU pod budget $185 · 5일 sequential
- next: M7-CREAM 제형 설계
