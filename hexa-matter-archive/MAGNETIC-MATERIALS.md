# MAGNETIC-MATERIALS — Phase D candidate stub

> **Authored**: 2026-05-13 (Phase A elevation) · **Status**: STUB — Phase D roadmap marker
> **Author**: 박민우 <nerve011235@gmail.com>
> **Target group**: GROUP_CER ∩ GROUP_MET (cross-cutting) · **Phase D priority**: MEDIUM
>
> Stub placeholder for the Phase D `magnetic-materials` verb covering hard
> magnets (NdFeB, SmCo, ferrite), soft magnets (electrical steel, ferrite,
> permalloy), and recording media.

---

## §1 Scope

Magnetic materials split into two operational classes:

| Class | Coercivity Hc | M_s | Use |
|-------|---------------|-----|-----|
| **Hard (permanent)** | high (> 1 kA/m, often > 1000 kA/m) | moderate-high | motor, sensor, MRI, speaker |
| **Soft (low-loss)** | low (< 1 kA/m) | high | transformer, inductor, motor stator |

---

## §2 Workhorse hard magnets

| Magnet | Composition | (BH)_max (MGOe) | T_curie (°C) | Use |
|--------|-------------|------------------|---------------|-----|
| Nd₂Fe₁₄B (NdFeB N52) | sintered or bonded | 52 | 310 | EV motor, hard disk, MRI |
| Sm₂Co₁₇ | sintered | 32-35 | 800 | aerospace motor (high-T), sensor |
| SmCo₅ | sintered | 22-28 | 720 | high-T motor |
| AlNiCo (cast/sintered) | Fe-Al-Ni-Co-Cu | 8-12 | 850 | speaker, sensor |
| Ba-ferrite (BaO·6Fe₂O₃) | sintered ceramic | 3.7 | 450 | toy magnet, low-cost motor |
| Sr-ferrite (SrO·6Fe₂O₃) | sintered ceramic | 4.3 | 450 | refrigerator magnet, household motor |

(BH)_max is the maximum energy product, the canonical figure of merit. NdFeB N52 at 52 MGOe is the highest commercially-available; lab-best is ~ 56 MGOe for special-grade NdFeB with heavy-rare-earth (Dy, Tb) substitution.

---

## §3 Workhorse soft magnets

| Material | M_s (T) | Hc (A/m) | μ_r | Use |
|----------|---------|----------|-----|-----|
| Pure Fe (annealed) | 2.16 | 80 | 5000 | rare; reference |
| Si-Fe electrical steel (3% Si) | 2.03 | 30-60 | 7000-10000 | transformer core |
| Permalloy (Ni80Fe20) | 1.05 | 0.4-1.6 | 50000-100000 | low-loss inductor, sensor |
| Supermalloy (Ni79Mo5Fe16) | 0.79 | 0.2 | 100000-1000000 | precision transformer |
| Mn-Zn ferrite | 0.5 | 10 | 1000-5000 | high-freq transformer, EMI suppressor |
| Ni-Zn ferrite | 0.4 | 100 | 100-500 | RF inductor |
| Metglas (Fe-Si-B amorphous) | 1.56 | 1-2 | 600000 | distribution transformer |

Electrical steel (Si-Fe) at 3% Si by mass:
- Si addition raises resistivity (lowers eddy-current loss)
- Si raises Curie temperature
- Si reduces magnetostriction
- M-19 (3.25% Si) and HiB (Hi-B grain-oriented) are the workhorse grades

---

## §4 Rare-earth supply chain

NdFeB production depends on Nd (~ 220 kt/yr global; ~ 70% from China) and heavy-rare-earth Dy (~ 1.5 kt/yr; ~ 90% from China). This creates a strategic supply concern for:
- EV motors (Tesla Model 3 has ~ 1 kg NdFeB per motor)
- Wind turbine direct-drive generators (~ 600 kg NdFeB per 1 MW turbine)
- MRI permanent magnets (per-machine 1-2 tons NdFeB)


---

## §5 Real-limit anchors (planned)

- L6 density 22.59 g/cm³ (Os) HARD_WALL — not directly applicable
- L12 entropy of mixing — relevant for recycling NdFeB (Dy/Tb separation is energy-intensive)
- Theoretical (BH)_max ceiling: ~ 64 MGOe for Nd-Fe-B based on Stoner-Wohlfarth + Nd_2Fe_14B saturation magnetization — soft ceiling, not hard

---

## §6 Cross-links (when expanded)

- `metallurgy/metallurgy.md` + `METALLURGY-DEEP.md` — Fe-based alloy baseline
- `ceramics/ceramics.md` + `CERAMIC-ENGINEERING.md` — ferrite ceramic processing
- `silicon/silicon.md` — Si-Fe electrical steel (cross-link)
- `recycle_n6/` + `recycling/` — rare-earth recovery
- `hexa-energy` — wind turbine + motor
- `hexa-mobility` — EV motor

---

## §7 Honest C3

Phase D candidate. Stub-level. (BH)_max + Curie T values cite manufacturer datasheets (Hitachi Metals, Magnequench, Vacuumschmelze). Rare-earth supply chain figures cite USGS Mineral Commodity Summaries 2024-2025. No lattice fit. Per `LATTICE_POLICY §1.2`.

---

*Stub authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase D roadmap marker.*
