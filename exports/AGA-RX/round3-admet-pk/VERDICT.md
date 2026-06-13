# AGA-RX Round-3 — In-Silico Developability Verdict (ADMET + topical follicular PK)

date: 2026-06-03 · milestone = ANALYZE · engines: ADMET-AI v2.0.1 (QSAR) + RDKit (physchem) + sympy/scipy PK
inputs: 4 round-2 leads (`exports/AGA-RX/round2-docking/RESULTS.md`) · see ADMET.md, PK.md, pk_follicular.py

## Combined verdict (ADMET PASS/flag × reaches-DPC PASS/flag)

| lead | Vina ΔG | target potency | ADMET | reaches-DPC | developability |
|---|---|---|---|---|---|
| **WAY-316606** | −7.77 | SFRP1 EC50 0.65 µM (measured) | FLAG-systemic (DILI 0.83 · CYP3A4 0.69 · hERG 0.56) — all *systemic*, topical-mitigable | **PASS** (×19–20000 margin, robust) | **★ BEST topical-developable lead** |
| 2-naphthylguanidine | −7.17 | est. Kd ~6 µM (Vina) | FLAG (skin 0.68 · CYP1A2 0.52 · 2 BRENK) | FLAG (potency unvalidated) | fragment — elaborate first |
| 4-guanidinobenzoic_acid | −7.16 | est. Kd ~6 µM (Vina) | cleanest tox, but poor permeability (PAMPA 0.015) | FLAG (shunt-entry limited) | fragment — permeability wall |
| tyramine-guanidine_hybrid | −6.87 | est. Kd ~9 µM (Vina) | cleanest tox, but **skin 0.77** | FLAG (skin caps C_surf) | fragment — topical-safety wall |

## Best topical-developable lead = **WAY-316606**

Rationale:
1. **Only measured-potency lead** (SFRP1 EC50 0.65 µM, ex-vivo hair-growth active) — the 3 LRP6 hits are
   unvalidated fragment-class (Vina-rank only, sub-200 Da).
2. **Most drug-like** (QED 0.73 · HIA 0.999 · 0 BRENK/PAINS · Ro5+Veber PASS).
3. **Reaches-DPC PASS with the widest margin** — clears the SFRP1 EC50 at the dermal papilla across the entire
   λ_foll/D_foll bracket, even at a low 0.1% w/v surface load (min λ_foll ≥ 0.18 mm; the shunt is mm-scale).
4. Its ADMET liabilities (DILI · CYP3A4 · hERG) are **systemic-exposure-driven** and are precisely the liabilities a
   **topical follicular** route minimizes — keeping plasma C low de-risks all three. This is the rare case where the
   delivery route directly retires the tox flags.
5. **AR-safe** by an orthogonal method: NR-AR 0.025 / NR-AR-LBD 0.008 (Tox21 QSAR) — relieves round-2's 🟠 AR gate.

## Next-round handoff (d1/d2)
- **WAY-316606 → SYNTHESIZE milestone**: topical follicular formulation (penetration enhancer / nanoparticle 400–700 nm
  for shunt targeting) + a DILI-mitigating analog series (replace the bis-sulfonyl/CF3 hepatotox motif while keeping
  the SFRP1 pharmacophore).
- **Fragments → DESIGN re-entry**: elaborate to measured-potency leads; 4-GBA needs a permeability fix (prodrug/ester),
  tyramine-hybrid needs the skin-sensitizer phenol/guanidine de-risked.
- **Oracle handoff (wet-lab, same class as TTR-LAC/NUMB)**: Tier-A Franz cell + follicular-closing technique converts
  the λ_foll/D_foll 🟠 bracket and the DILI/skin QSAR flags to 🟢.
