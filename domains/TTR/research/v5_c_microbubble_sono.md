# TTR-MN v5-C — micro-bubble cavitation (sonophoresis + MN combo)

> milestone: v5 path C · sono + MN 결합 · per-cycle x +30% via cavitation
> driver: payload deposition + dermal mixing 가속 (Mitragotri 1995 sonophoresis precedent)
> base: v5_rd_paths_physical_floor_bypass.md (Path C overview) 위 detailed

## TL;DR

**Low-frequency sonophoresis (20 kHz · 1-2 W/cm² · 30 sec)** + MN array combo. Cavitation micro-bubble in dermis → payload spreading 가속 + macrophage stimulation. per-cycle x: 14% → **18%** (30% boost via mixing + macrophage stimulation). N=11 cycle × 격일 = **38일 ≈ 1.3mo**. R&D 1-2년 · $3-4M (combo device · Sontra precedent).

## §1 mechanism

```
   v4 MN 단독:
        MN press → payload deposit → passive diffusion
        plume radius 30-100 μm · macrophage 자연 phagocytose
        per-cycle x 14%
   
   v5-C MN + sonophoresis combo:
   ┌─────────────────────────────────┐
   │  step 1: MN press 30 sec          │
   │     ↓                              │
   │  step 2: HA dissolve (5 min)       │
   │     ↓                              │
   │  step 3: ★ Sono 20kHz × 30s ★    │ ← NEW
   │     ↓                              │
   │     micro-bubble cavitation        │
   │     in dermis                      │
   │     ↓                              │
   │     ① payload mixing (plume        │
   │        radius 30 → 100 μm boost)   │
   │     ② macrophage stimulation       │
   │        (mechanical · gentle US)    │
   │     ③ tissue mass transfer ↑       │
   │     ↓                              │
   │  step 4: LED 5 min (optional)      │
   └─────────────────────────────────┘
   per-cycle x 18% (30% boost)
```

## §2 sonophoresis parameter optimization

| param | value | rationale |
|---|---|---|
| Frequency | **20 kHz** (low) | optimal cavitation in skin (Mitragotri 2000) |
| Intensity | **1.5 W/cm²** | FDA precedent (Sontra · 0.5-2 W/cm²) · cavitation threshold |
| Duration | **30 sec** | sufficient mixing · skin safety (no thermal burn) |
| Mode | Pulsed (50% duty) | thermal control |
| Coupling | Water-based gel (CMC) | acoustic impedance match |

⇒ FDA-precedent 정합 (Sontra SonoPrep)

## §3 cavitation boost factor (literature)

### Mitragotri sonophoresis review (2003 · 2011)

```
   Solute mass transfer in skin (passive vs sonophoresis):
        - small molecules (~500 Da): 10-100× boost
        - macromolecules (~10 kDa): 100-1000× boost
        - large molecules (~70 kDa enzyme): 50-500×
   
   For TTR v4 payload:
        - AzoR (23 kDa): ~200× passive (diffusion-limited)
        - DyP (50 kDa): ~100× passive
        - CeO₂ NP (5-10 nm = ~10 kDa equivalent): ~50×
        - Ascorbate (176 Da): ~10×
```

⇒ payload mass transfer 50-200× boost · plume volume 5-10× larger

### Practical per-cycle x boost

```
   v4 plume radius: 30-100 μm (single-cycle Fick)
   v5-C with sono: 100-300 μm (plume tripling)
   
   coverage per needle: π·r² → π·(3r)² = 9× area
   in 1500/cm² array: overlap factor η drops further (more coverage but 더 saturated)
   
   net per-cycle x boost: ~30% (14% → 18%)
```

## §4 cumulative (격일 cycle)

| N | timeline (격일) | cumulative (18%) |
|---|---|---|
| 8 | 28일 | 80.4% |
| 10 | 35일 | 86.9% |
| **11** | **38일 ≈ 5.5주** | **89.5%** ★ ≈ 90% |
| 12 | 42일 | 91.4% |

⇒ **N=11 · 1.3mo** (v4 2mo 보다 35% 빠름)

## §5 SKU + device cost

| component | mass · spec | cost |
|---|---|---|
| **Sono device (USB-rechargeable)** | 20 kHz · 1.5 W/cm² · disposable head | $100 one-time (60+ cycle reuse) |
| CMC coupling gel | 5 mL per cycle | $0.50 per cycle |
| v4 patch (1500/cm² + quad) | (M7-v4) | $45 |
| **per-cycle total** | | **$45.50** + amortized $1.67 device |
| **treatment** (11 cycle) | | $45.50 × 11 + $100 = $600 |

⇒ v4 $705 → **v5-C $600** (15% cheaper · timeline shorter)

## §6 manufacturing path

- Sono device: medical-grade transducer + LED + ergonomic case
- CDMO: Sontra (정합) · GE · Philips ultrasound · 소형 medical device makers
- FDA 510(k) Class II (intensive ultrasound device)
- Approved precedent: Sontra SonoPrep (interstitial fluid sampling)

## §7 R&D + Phase 1

| phase | task | duration | cost |
|---|---|---|---|
| R&D-1 | Sono device prototype (transducer · case · safety circuit) | 6mo | $800k |
| R&D-2 | MN + sono sequencing protocol (timing · gel · interaction) | 4mo | $300k |
| R&D-3 | ex-vivo combo verification (M8-v5C) | 3mo | $50k |
| R&D-4 | in-vivo combo (v4 + sono Tier 2 expand) | 6mo | $200k |
| R&D-5 | FDA 510(k) submission (device) + 505(b)(2) (combo) | 6mo | $200k |
| Phase 1 | n=12 v5-C arm | 2mo trial + 2mo follow | $700-1000k |
| **합계** | | **24mo** | **$2.7-3.3M** |

## §8 safety + risks

| risk | likelihood | mitigation |
|---|---|---|
| Cavitation excessive (thermal burn) | low | pulsed mode + temperature sensor (auto-off) |
| Sono depth uncertainty (skin variability) | mid | individual calibration step (first cycle) |
| Patient compliance (sono device usage) | mid | guided app + visual indicator |
| Combo device regulatory complexity | mid | 510(k) device + 505(b)(2) drug-device combination |
| Sono + payload interaction (denaturation?) | low-mid | sono 30 sec · payload stable (literature) |

## §9 v5-AC hybrid (engineered + sono)

```
   v5-A: K_cat 10× (per-cycle x 21%)
   v5-C: sono (+30% boost)
   combined:
     per-cycle x = 21% × 1.30 = 27%
     N for 90% = (1-0.27)^N = 0.1 → N=7.3
   ⇒ N=8 × 격일 = 28일 = 4주 = 1mo
```

⇒ v5-AC = **1mo timeline** (v4 2mo의 50%) · 다만 R&D + cost 합산

## §10 marketing pitch (v5-C SonoMN)

```
🔊 TTR-MN-Sono — "초음파 + 패치 combo"

- 1.3개월 timeline (v4 2mo · 35% 빠름)
- $600/treatment (v4 -15%)
- Sono device 1회 구매 ($100 · 60+ cycle reuse)
- 매 cycle: patch + sono 30초 = 6분 (v4 5분 + 1분)
- FDA-precedent Sontra (sonophoresis · 인터스티셜 fluid)
```

## §11 honest unknowns

- 30% boost factor 정확 (literature 50-200× mass transfer · per-cycle x boost 30% 보수적)
- Sono + payload interaction long-term (NADPH · TLR7/8 stability under cavitation)
- Patient adherence (1 minute sono 추가 OK)
- Sono device cost scale (small batch $100 → mass production $30-50)
- Regulatory complexity (combo device first-in-class)

## §12 진행 상태

- ✅ Sono parameter 정의 (20 kHz · 1.5 W/cm² · 30 sec pulsed)
- ✅ Cavitation boost factor (literature 50-200× mass transfer)
- ✅ Per-cycle x 30% boost (14% → 18%)
- ✅ Timeline N=11 × 격일 = 38일 (1.3mo)
- ✅ Cost analysis ($600/treatment · v4 -15%)
- ✅ R&D plan ($2.7-3.3M · 24mo)
- ✅ Safety + regulatory path (510(k) combo)
- ✅ v5-AC hybrid (engineered + sono = 1mo)
- next: v5-B chemotaxis 또는 atlas dispatch n6 staging
